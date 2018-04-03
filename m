From: gitlab@mg.gitlab.com (Agustin Benito Bethencourt)
Date: Tue, 03 Apr 2018 09:26:44 +0000
Subject: [cip-dev] [Git][cip-project/cip-testing/testing][master] 2 commits:
 remove 0001.patch
Message-ID: <5ac348d49c8af_a6173f95739d6f8c2432c4@sidekiq-asap-04.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Agustin Benito Bethencourt pushed to branch master at cip-project / cip-testing / testing


Commits:
ddbe6ede by Don Brown at 2017-01-20T17:34:08Z
remove 0001.patch

- - - - -
40d4405b by Don Brown at 2017-02-22T18:43:47Z
Update README.md
- - - - -


2 changed files:

- ? 0001.patch
- README.md


Changes:

=====================================
0001.patch deleted
=====================================
--- a/0001.patch
+++ /dev/null
@@ -1,83 +0,0 @@
- integration-scripts/install_backend.sh      |  8 +++++++-
- integration-scripts/install_build_script.sh |  9 ++++++++-
- integration-scripts/install_frontend.sh     |  8 +++++++-
- scripts/setup-dev-env.sh                    | 11 +++++++++++
- 4 files changed, 33 insertions(+), 3 deletions(-)
- create mode 100644 scripts/setup-dev-env.sh
-
-diff --git a/integration-scripts/install_backend.sh b/integration-scripts/install_backend.sh
-index 72a974033a3c..157e7184e349 100755
---- a/integration-scripts/install_backend.sh
-+++ b/integration-scripts/install_backend.sh
-@@ -4,7 +4,13 @@
- # Install kernelci backend
-
- cd $HOME && mkdir git-repos && cd git-repos
--git clone https://github.com/kernelci/kernelci-backend-config.git kernelci-backend
-+
-+GIT_SRC="https://github.com/kernelci/kernelci-backend-config.git"
-+if [ -d /vagrant/kernelci-backend-config ]; then
-+    GIT_SRC=/vagrant/kernelci-backend-config
-+fi
-+git clone $GIT_SRC kernelci-backend
-+
- cp /vagrant/config/secrets-backend.yml kernelci-backend/secrets.yml
-
- # Fixme: Don't let ansible try to create the file in the first place.
-diff --git a/integration-scripts/install_build_script.sh b/integration-scripts/install_build_script.sh
-index 322619317af6..879aaed01792 100755
---- a/integration-scripts/install_build_script.sh
-+++ b/integration-scripts/install_build_script.sh
-@@ -3,7 +3,14 @@
- # Copyright (C) 2016, Siemens AG, Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
- # SPDX-License-Identifier:     Apache-2.0
-
--cd $HOME && git clone https://github.com/kernelci/kernelci-build.git
-+cd $HOME
-+
-+GIT_SRC="https://github.com/kernelci/kernelci-build.git"
-+if [ -d /vagrant/kernelci-build ]; then
-+    GIT_SRC=/vagrant/kernelci-build
-+fi
-+git clone $GIT_SRC
-+
- cd kernelci-build
-
- MASTER_KEY=`cat $HOME/backend-admin-token.txt`
-diff --git a/integration-scripts/install_frontend.sh b/integration-scripts/install_frontend.sh
-index 48ab91ab83ce..251ef89d28f3 100755
---- a/integration-scripts/install_frontend.sh
-+++ b/integration-scripts/install_frontend.sh
-@@ -4,7 +4,13 @@
- # Install kernelci frontend
-
- cd $HOME/git-repos
--git clone https://github.com/kernelci/kernelci-frontend-config.git kernelci-frontend
-+
-+GIT_SRC="https://github.com/kernelci/kernelci-frontend-config.git"
-+if [ -d /vagrant/kernelci-frontend-config ]; then
-+    GIT_SRC=/vagrant/kernelci-frontend-config
-+fi
-+git clone $GIT_SRC kernelci-frontend
-+
- sed -i kernelci-frontend/roles/install-app/tasks/main.yml \
-     -e 's/kernelci\/kernelci-frontend.git/siemens\/kernelci-frontend.git/'
-
-diff --git a/scripts/setup-dev-env.sh b/scripts/setup-dev-env.sh
-new file mode 100644
-index 000000000000..59c13b233065
---- /dev/null
-+++ b/scripts/setup-dev-env.sh
-@@ -0,0 +1,11 @@
-+#!/bin/sh
-+
-+if [ ! -f "Vagrantfile" ]; then
-+    echo "script is supposed to be run from the top folder where"
-+    echo "the Vagrantfile is."
-+    exit 1
-+fi
-+
-+git clone https://github.com/kernelci/kernelci-backend-config.git
-+git clone https://github.com/kernelci/kernelci-build.git
-+git clone https://github.com/kernelci/kernelci-frontend-config.git
-


=====================================
README.md
=====================================
--- a/README.md
+++ b/README.md
@@ -1,90 +1,20 @@
-# Kernel CI for the Civil Infrastructure Platform #
+# Board at desk - single dev description  #
 
-This repository provides vagrant infrastructure that allows users/labs
-to easily set up a kernel CI front- end backend tailored to the needs
-of the civil infrastructure platform (http://www.cip-platform.org).
+Board at desk - single dev is an effort to ease the deployment of KernelCI and LAVAv2 allowing
+a developer with a board connected to its machine test kernels. 
+In order to do so, a VM has been created with all the tools and configurations required. 
+The current technology used to create that VM is Vagrant. 
 
-KernelCI Virtual Machine Setup & Configuration
+# Interesting links #
 
-The current setup requires (2) Virtual Machines; one for KernelCI and the other for LAVA v2
+* Board at desk - single dev [feature page](https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingboardatdesksingledevfeaturepage)
+* [Download](https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipdownload) Board at desk - single dev.
+* Instructions to [download and set up Board at desk - single dev](https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingboardatdesksingledevsetup).
+* [Connect and configure Beaglebone Black](https://wiki.linuxfoundation.org/civilinfrastructureplatform/beagleboneblackboard) to test the kernel on the board.
+* [CIP testing project home page](https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting)
 
-Edit
-Setting up KernelCI VM
+# Contribute to the CIP testing project: #
+* Please read the Testing at [CIP FAQ](https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingfaq) to learn more about this action.
+* Join the technical mailing list ( [cip-dev](https://lists.cip-project.org/mailman/listinfo/cip-dev) ) to follow this effort.
+* Report a [bug](https://gitlab.com/cip-project/testing/boards). 
 
-1. Install Vagrant
-
-[user at host ~] $ sudo apt-get install vagrant
-
-2. Install Oracle Virtualbox
-
-[user at host ~] $ sudo apt-get install virtualbox
-
-OR, if you downloaded Virtualbox from the Oracle website
-Note: This assumes you are running Ubuntu Xenial(16.04) 64-bit
-[user at host ~] $ cd Downloads
-[user at host Downloads] $ sudo dpkg -i virtualbox-5.1_5.1.8-111374-Ubuntu-xenial_amd64.deb
-
-3. Get the CIP KernelCI Project
-
-[user at host ~/git] $ git clone https://gitlab.com/cip-project/testing.git
-
-4. Change to the testing directory
-
-[user at host ~/git] $ cd testing
-
-5. Launch the KernelCI Virtual Machine
-
-[user at host ~/git/testing] $ vagrant up
-
-Note: Please ignore any warnings such as ?GetPassWarning: Can not control echo on the terminal.? or ?Warning: Password input may be echoed.? - These do not affect the operation of the KernelCI VM.
-
-6. Connect to the KernelCI VM through ssh using vagrant
-
-[user at host ~] $ vagrant ssh
-
-Edit
-Get CIP Kernel using git
-
-7. Change to the git-repos directory
-
-vagrant at guest:~$ cd git-repos
-
-8. Clone the Linux Kernel
-
-vagrant at guest:~/git-repos$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
-
-9. Find the branch of the kernel version you want (i.e. 4.4.27)
-
-vagrant at guest:~/git-repos$ cd linux-stable
-
-vagrant at guest:~/git-repos/linux-stable$ git tag -l | grep 4.4.y
-
-10. Create a new branch using that tag.
-
-vagrant at guest:~/git-repos/linux-stable$ git checkout -b cip_v4.4.27 v4.4.27
-
-Edit
-Compile CIP Kernel
-
-11. Set the environment variables
-
-vagrant at guest:~/git-repos/linux-stable$ export TREE_NAME=cip-test
-
-vagrant at guest:~/git-repos/linux-stable$ export ARCH=arm
-
-vagrant at guest:~/git-repos/linux$ export CROSS_COMPILE=arm-linux-gnueabi-
-
-Note: Don't forget the dash (-) at the end of the CROSS_COMPILE line!
-
-12. Execute the build.py command
-
-vagrant at guest:~/git-repos/linux-stable$ ~/kernelci-build/build.py -c tinyconfig -p CIP-KernelCI
-
-13. The Web Server is already running in the background. when you navigate from page to page the logs are written to the screen. To get back to the command line, simply press Enter
-
-14. On your host machine, open a web browser and enter the following in the address box:
-
-http://localhost:5000
-
-15. You will see the KernelCI Website home page from which, you can navigate to the different builds and trees that you've created
- 



View it on GitLab: https://gitlab.com/cip-project/cip-testing/testing/compare/047b8bf220441ec4dc93b76ecc10a0d7423e944a...40d4405b5312123eb0796d1885114feb7dca84bc

---
View it on GitLab: https://gitlab.com/cip-project/cip-testing/testing/compare/047b8bf220441ec4dc93b76ecc10a0d7423e944a...40d4405b5312123eb0796d1885114feb7dca84bc
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180403/2c8a013c/attachment-0001.html>
