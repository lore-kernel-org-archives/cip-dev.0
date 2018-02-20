From: gitlab@mg.gitlab.com (Agustin Benito Bethencourt)
Date: Tue, 20 Feb 2018 09:19:57 +0000
Subject: [cip-dev]
 [Git][cip-project/cip-testing/board-at-desk-single-dev][master] 3 commits:
 Install python-selinux to fix kernelci-backend issue #168
Message-ID: <5a8be83dba5ae_1adde3fe19ebdc5e471648ef@sidekiq-asap-01.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Agustin Benito Bethencourt pushed to branch master at cip-project / cip-testing / board-at-desk-single-dev


Commits:
645520c6 by Robert Marshall at 2017-11-06T15:19:06+00:00
Install python-selinux to fix kernelci-backend issue #168

- - - - -
c3d64a3b by Robert Marshall at 2017-11-07T10:55:53+00:00
Merge branch &#39;fix-selinux-error&#39; into &#39;master&#39;

Install python-selinux to fix kernelci-backend issue #168

See merge request cip-project/cip-testing/board-at-desk-single-dev!51
- - - - -
a2b0bba4 by Robert Marshall at 2018-02-07T13:42:22+00:00
Fix comment typo (port now 8080)

- - - - -


2 changed files:

- Vagrantfile
- integration-scripts/install_dependencies.sh


Changes:

=====================================
Vagrantfile
=====================================
--- a/Vagrantfile
+++ b/Vagrantfile
@@ -41,7 +41,7 @@ Vagrant.configure(2) do |config|
   config.vm.network :forwarded_port, guest: 8010, host: 8010
   # Forward port 5000 for the KernelCI Frontend Web Server
   config.vm.network :forwarded_port, guest: 5000, host: 5000
-  # Forward port 80 for the http Lava Frontend Web Server
+  # Forward port 8080 for the http Lava Frontend Web Server
   config.vm.network :forwarded_port, guest: 8080, host: 8080
   # Forward port 443 for the https Lava Frontend Web Server
   config.vm.network :forwarded_port, guest: 443, host: 4443


=====================================
integration-scripts/install_dependencies.sh
=====================================
--- a/integration-scripts/install_dependencies.sh
+++ b/integration-scripts/install_dependencies.sh
@@ -32,7 +32,7 @@ sudo DEBIAN_FRONTEND=noninteractive apt-get -y update
 sudo DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
 
 # Install the dependencies
-sudo DEBIAN_FRONTEND=noninteractive apt-get -y install git python-pip python-dev python-concurrent.futures python-tornado libffi-dev libyaml-dev libssl-dev rng-tools python-requests ser2net telnet screen
+sudo DEBIAN_FRONTEND=noninteractive apt-get -y install git python-pip python-dev python-concurrent.futures python-tornado libffi-dev libyaml-dev libssl-dev rng-tools python-requests ser2net telnet screen python-selinux
 
 # Install the ARM, ARM-HF & ARM64 Toolchain
 sudo DEBIAN_FRONTEND=noninteractive apt-get -y install gcc-arm-linux-gnueabi gcc-arm-linux-gnueabihf gcc-aarch64-linux-gnu



View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/9d233b0c7039095546f7d7fb171a05a1f993e0ed...a2b0bba4506b27d3308f35f6c17f4bc4729b3c44

---
View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/9d233b0c7039095546f7d7fb171a05a1f993e0ed...a2b0bba4506b27d3308f35f6c17f4bc4729b3c44
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180220/275163f7/attachment-0001.html>
