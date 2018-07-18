From: gitlab@mg.gitlab.com (Robert Marshall)
Date: Wed, 18 Jul 2018 07:26:20 +0000
Subject: [cip-dev]
 [Git][cip-project/cip-testing/board-at-desk-single-dev][master] 2 commits:
 Use 2018.4 version of LAVA #185
Message-ID: <5b4eeb9c3cab9_2b033faa38295230830062@sidekiq-asap-01.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Robert Marshall pushed to branch master at cip-project / cip-testing / board-at-desk-single-dev


Commits:
d7d61d0b by Robert Marshall at 2018-07-18T07:26:18Z
Use 2018.4 version of LAVA #185

- - - - -
ed0c61c4 by Robert Marshall at 2018-07-18T07:26:18Z
Merge branch &#39;stableLAVA&#39; into &#39;master&#39;

Use 2018.4 version of LAVA #185

See merge request cip-project/cip-testing/board-at-desk-single-dev!60
- - - - -


2 changed files:

- integration-scripts/install_dependencies.sh
- integration-scripts/install_lava.sh


Changes:

=====================================
integration-scripts/install_dependencies.sh
=====================================
@@ -22,8 +22,6 @@ if [ -f ~/git-repos/kernelci-backend/tmphosts ] ; then
     echo continuing kernelci-backend provisioning
     exit 0
 fi
-# Add backports repository - main branch
-echo "deb http://deb.debian.org/debian stretch-backports main" | sudo DEBIAN_FRONTEND=noninteractive tee -a /etc/apt/sources.list
 
 # Add Architectures that you will be building
 sudo DEBIAN_FRONTEND=noninteractive dpkg --add-architecture armel


=====================================
integration-scripts/install_lava.sh
=====================================
@@ -15,16 +15,18 @@ set -e
 # Stop nginx
 sudo DEBIAN_FRONTEND=noninteractive systemctl stop nginx.service
 
-# Update the system
-sudo DEBIAN_FRONTEND=noninteractive apt-get -y update
+# retrieve 2018.4 of LAVA from here
+echo "deb     http://snapshot.debian.org/archive/debian/20180526T153644Z/ stretch-backports main " | sudo DEBIAN_FRONTEND=noninteractive tee -a /etc/apt/sources.list
+sudo DEBIAN_FRONTEND=noninteractive apt-get -o Acquire::Check-Valid-Until=false -y update
 sudo DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
 
 # Install postgresql & tftp
 sudo DEBIAN_FRONTEND=noninteractive apt-get -y install postgresql tftp
 
+
 # Install qemu, KVM & LAVA
 sudo DEBIAN_FRONTEND=noninteractive apt-get -y install qemu-kvm libvirt-clients libvirt-daemon libvirt-daemon-system
-sudo DEBIAN_FRONTEND=noninteractive apt-get -y install lava -t stretch-backports
+sudo DEBIAN_FRONTEND=noninteractive apt-get -y install lava=2018.4-1~bpo9+1 -t stretch-backports
 
 # Add the vagrant user to the libvirtd and kvm groups
 sudo DEBIAN_FRONTEND=noninteractive usermod -a -G libvirt,kvm vagrant



View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/01551476f285f2cb5caa5f0e99bf483f24735123...ed0c61c4022e45dcf9e089f983ed0bc557aacf63

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/01551476f285f2cb5caa5f0e99bf483f24735123...ed0c61c4022e45dcf9e089f983ed0bc557aacf63
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180718/5e1c9b95/attachment-0001.html>
