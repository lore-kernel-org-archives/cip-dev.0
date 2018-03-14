From: gitlab@mg.gitlab.com (Robert Marshall)
Date: Wed, 14 Mar 2018 09:49:10 +0000
Subject: [cip-dev]
 [Git][cip-project/cip-testing/board-at-desk-single-dev][master] 2 commits:
 Alter provisioning so that it works with the latest kernelci
Message-ID: <5aa8f016145bb_18d023fdd64ad240c6236d6@sidekiq-asap-03.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Robert Marshall pushed to branch master at cip-project / cip-testing / board-at-desk-single-dev


Commits:
7a268430 by Robert Marshall at 2018-03-14T09:49:04Z
Alter provisioning so that it works with the latest kernelci

- - - - -
482e656e by Robert Marshall at 2018-03-14T09:49:04Z
Merge branch &#39;new-kernelci&#39; into &#39;master&#39;

Alter provisioning so that it works with the latest kernelci

See merge request cip-project/cip-testing/board-at-desk-single-dev!53
- - - - -


3 changed files:

- integration-scripts/install_backend.sh
- integration-scripts/install_dependencies.sh
- integration-scripts/install_frontend.sh


Changes:

=====================================
integration-scripts/install_backend.sh
=====================================
--- a/integration-scripts/install_backend.sh
+++ b/integration-scripts/install_backend.sh
@@ -14,14 +14,37 @@
 echo "START: install_backend.sh"
 
 set -e
+# test whether the tmphosts marker file is already created
+if [ -f ~/git-repos/kernelci-backend/tmphosts ] ; then
+# install backend partially done, continuing..
+    # Make sure the backend REST service started to listen  on port 8888 before
+    # trying to obtain an admin session token
+    while netstat -lnt | awk '$4 ~ /:8888$/ {exit 1}'; do sleep 2; done
+
+    # Obtain the session token with admin privileges.
+    MASTER_KEY=`cat /vagrant/config/secrets-backend.yml | grep master_key | \
+                                           awk '{print $2;}'`
+    TOKEN=`python /vagrant/scripts/get_admin_token.py ${MASTER_KEY}`
+    echo $TOKEN > $HOME/backend-admin-token.txt
+
+    # Create a configuration file for the build script
+    echo "[CIP-KernelCI]" > $HOME/.buildpy.cfg
+    echo "token=$TOKEN" >> $HOME/.buildpy.cfg
+    echo "url=http://localhost:8888" >> $HOME/.buildpy.cfg
+
+    # with stretch an explicit install of bc is required
+    sudo DEBIAN_FRONTEND=noninteractive apt-get -y install bc
+    rm ~/git-repos/kernelci-backend/tmphosts
+    echo "END: install_backend.sh"
+    # move onto the next provisioning stage
+    exit 0
+
+fi
 
 cd $HOME && mkdir git-repos && cd git-repos
 git clone https://github.com/kernelci/kernelci-backend-config.git kernelci-backend
 
-# revert to using version of kernelci-backend that works without substantial changes for the release
-cd kernelci-backend
-git checkout 22eea06bce942980c9f0be2e5221e19f3b8fb6db
-cd ..
+sudo DEBIAN_FRONTEND=noninteractive apt-get -y install nginx nginx-extras
 
 cp /vagrant/config/secrets-backend.yml kernelci-backend/secrets.yml
 
@@ -34,6 +57,30 @@ sudo touch /etc/sysfs.d/99-thp-defrag.conf
 cd kernelci-backend
 # Use port 80 for apt-key to prevent problems when running behind a web proxy
 sed -i 's/hkp:\/\/keyserver.ubuntu.com/hkp:\/\/keyserver.ubuntu.com:80/g' roles/install-deps/tasks/install-mongodb.yml
+echo "storage_certname: localhost" >> group_vars/all
+sed -i group_vars/all -e 's/hostname: kernelci-backend/hostname: localhost/'
+
+cat > tmphosts  <<EOF
+[dev]
+# this machine will be managed directly via root
+localhost ansible_ssh_user=root
+[rec]
+# this machine will be managed via the user admin becoming root via "su"
+localhost ansible_ssh_user=admin become_method=su
+[prod]
+# this machine will be managed via the user admin using sudo
+localhost ansible_ssh_user=admin become_method=sudo
+EOF
+
+sudo mkdir -p /etc/ansible
+sudo DEBIAN_FRONTEND=noninteractive bash -c "cat tmphosts >> /etc/ansible/hosts"
+ 
+
+set +e
+ansible-playbook -i hosts site.yml -l local -c local -K -e "@secrets.yml" \
+                 -e "@secrets.yml" --skip-tags=backup,firewall,web-server
+# TODO: Fix error during the first run (second run succeeds deterministically)
+set -e
 # TODO: This asks for a sudo password, which we need to provide non-interactively
 ansible-playbook -i hosts site.yml -l local -c local -K -e "@secrets.yml" \
                  -e "@secrets.yml" --skip-tags=backup,firewall,web-server
@@ -41,22 +88,11 @@ ansible-playbook -i hosts site.yml -l local -c local -K -e "@secrets.yml" \
 # with stretch a install of net-tools for netstat is required
 sudo DEBIAN_FRONTEND=noninteractive apt-get -y install net-tools
 
-# Make sure the backend REST service started to listen  on port 8888 before
-# trying to obtain an admin session token
-while netstat -lnt | awk '$4 ~ /:8888$/ {exit 1}'; do sleep 2; done
-
-# Obtain the session token with admin privileges.
-MASTER_KEY=`cat /vagrant/config/secrets-backend.yml | grep master_key | \
-           awk '{print $2;}'`
-TOKEN=`python /vagrant/scripts/get_admin_token.py ${MASTER_KEY}`
-echo $TOKEN > $HOME/backend-admin-token.txt
+sudo sed -i 's/^[ ]*ssl/    # ssl/' /etc/nginx/sites-enabled/storage.kernelci.org.conf
+sudo sed -i 's/resolver False/# resolver False/' /etc/nginx/sites-enabled/storage.kernelci.org.conf
 
-# Create a configuration file for the build script
-echo "[CIP-KernelCI]" > $HOME/.buildpy.cfg
-echo "token=$TOKEN" >> $HOME/.buildpy.cfg
-echo "url=http://localhost:8888" >> $HOME/.buildpy.cfg
 
-# with stretch an explicit install of bc is required
-sudo DEBIAN_FRONTEND=noninteractive apt-get -y install bc
+echo now run 'vagrant halt; vagrant up; vagrant provision; '
+echo 'to complete b at d provisioning'
+exit 1
 
-echo "END: install_backend.sh"


=====================================
integration-scripts/install_dependencies.sh
=====================================
--- a/integration-scripts/install_dependencies.sh
+++ b/integration-scripts/install_dependencies.sh
@@ -18,7 +18,10 @@ if [ -f ~/mybbb.dat ] ; then
     echo 'KernelCI already configured remove ~/mybbb.dat to force configuration'
     exit 1
 fi
-
+if [ -f ~/git-repos/kernelci-backend/tmphosts ] ; then
+    echo continuing kernelci-backend provisioning
+    exit 0
+fi
 # Add backports repository - main branch
 echo "deb http://deb.debian.org/debian stretch-backports main" | sudo DEBIAN_FRONTEND=noninteractive tee -a /etc/apt/sources.list
 


=====================================
integration-scripts/install_frontend.sh
=====================================
--- a/integration-scripts/install_frontend.sh
+++ b/integration-scripts/install_frontend.sh
@@ -19,11 +19,6 @@ set -e
 cd $HOME/git-repos
 git clone https://github.com/kernelci/kernelci-frontend-config.git kernelci-frontend
 
-# revert to using version of kernelci-frontend that works without substantial changes for the release
-cd kernelci-frontend
-git checkout 71dbe698c9353f01cf63baa318cfb126d1afb207
-cd ..
-
 
 TOKEN=`cat $HOME/backend-admin-token.txt`
 cat /vagrant/config/secrets-frontend.yml | sed -e "s/TOKEN/${TOKEN}/" \
@@ -31,6 +26,7 @@ cat /vagrant/config/secrets-frontend.yml | sed -e "s/TOKEN/${TOKEN}/" \
 
 cd kernelci-frontend
 sed -i group_vars/all -e 's/^role: production/role: atdesk/'
+sed -i group_vars/all -e 's/hostname: kernelci-backend/hostname: localhost/'
 
 set +e
 ansible-playbook -i hosts site.yml -l local -c local -K -D \
@@ -48,4 +44,7 @@ sudo sed -i /srv/kernelci-frontend/app/dashboard/default_settings.py -e 's/^SECR
 sudo mkdir -p /var/www/images
 sudo chown -R www-data.www-data /var/www
 
+# /vagrant/scripts/start_webserver.sh &
+# and the instructions say a reboot is necessary!
+
 echo "END: install_frontend.sh"



View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/a2b0bba4506b27d3308f35f6c17f4bc4729b3c44...482e656e4c4488c2ea936df5ec11080c76956656

---
View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/a2b0bba4506b27d3308f35f6c17f4bc4729b3c44...482e656e4c4488c2ea936df5ec11080c76956656
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180314/fb5fd12c/attachment-0001.html>
