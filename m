From: gitlab@mg.gitlab.com (Agustin Benito Bethencourt)
Date: Tue, 20 Feb 2018 09:21:45 +0000
Subject: [cip-dev] [Git][cip-project/cip-testing/kernelci-debian][master] 2
 commits: Modify sed to work only on FILE_SERVER_URL Lines. Also change
 create_builds to clone CIP Kernel
Message-ID: <5a8be8a947637_c51a3fbca999905879079a4@sidekiq-asap-04.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Agustin Benito Bethencourt pushed to branch master at cip-project / cip-testing / kernelci-debian


Commits:
a6c7dc68 by Don Brown at 2017-02-05T20:07:01-05:00
Modify sed to work only on FILE_SERVER_URL Lines. Also change create_builds to clone CIP Kernel

- - - - -
38e351da by Don Brown at 2017-02-22T22:36:49+00:00
Update README.md
- - - - -


3 changed files:

- README.md
- integration-scripts/configure_singledev.sh
- scripts/create_builds.sh


Changes:

=====================================
README.md
=====================================
--- a/README.md
+++ b/README.md
@@ -1,88 +1,20 @@
-# Kernel CI for the Civil Infrastructure Platform #
+# Board at desk - single dev description  #
 
-This repository provides the vagrant infrastructure that allows users/labs
-to easily set up a Kernel CI frontend and backend tailored to the needs
-of the Civil Infrastructure Platform (http://www.cip-platform.org).
+Board at desk - single dev is an effort to ease the deployment of KernelCI and LAVAv2 allowing
+a developer with a board connected to its machine test kernels. 
+In order to do so, a VM has been created with all the tools and configurations required. 
+The current technology used to create that VM is Vagrant. 
 
-## KernelCI Virtual Machine Setup & Configuration ##
+# Interesting links #
 
-The current setup requires (2) Virtual Machines; one for KernelCI and the other for LAVA v2
+* Board at desk - single dev [feature page](https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingboardatdesksingledevfeaturepage)
+* [Download](https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipdownload) Board at desk - single dev.
+* Instructions to [download and set up Board at desk - single dev](https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingboardatdesksingledevsetup).
+* [Connect and configure Beaglebone Black](https://wiki.linuxfoundation.org/civilinfrastructureplatform/beagleboneblackboard) to test the kernel on the board.
+* [CIP testing project home page](https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting)
 
-### Setting up the Debian Jessie KernelCI VM ###
-
-1.) Install Vagrant
-
-```[user at host ~] $ sudo apt-get install vagrant```
-
-2.) Install Oracle Virtualbox
-
-```[user at host ~] $ sudo apt-get install virtualbox```
-
-OR, if you downloaded Virtualbox from the Oracle website
-Note: This assumes you are running Ubuntu Xenial(16.04) 64-bit
-```[user at host ~] $ cd Downloads```
-```[user at host Downloads] $ sudo dpkg -i virtualbox-5.1_5.1.8-111374-Ubuntu-xenial_amd64.deb```
-
-3.) Get the CIP Debian Jessie KernelCI Project
-
-```[user at host ~/git] $ git clone https://gitlab.com/cip-project/kernelci-debian.git```
-
-4.) Change to the kernelci-debian directory
-
-```[user at host ~/git] $ cd kernelci-debian```
-
-5.) Launch the KernelCI Virtual Machine
-
-```[user at host ~/git/kernelci-debian] $ vagrant up```
-
-Note: Please ignore any warnings such as ?GetPassWarning: Can not control echo on the terminal.? or ?Warning: Password input may be echoed.? - These do not affect the operation of the KernelCI VM.
-
-6.) Connect to the KernelCI VM through ssh using vagrant
-
-```[user at host ~] $ vagrant ssh```
-
-### Get CIP Kernel using git ###
-
-7.) Change to the git-repos directory
-
-```vagrant at guest:~$ cd git-repos```
-
-8.) Clone the Linux Kernel
-
-```vagrant at guest:~/git-repos$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git```
-
-9.) Find the branch of the kernel version you want (i.e. 4.4.27)
-
-```vagrant at guest:~/git-repos$ cd linux-stable```
-
-```vagrant at guest:~/git-repos/linux-stable$ git tag -l | grep 4.4.y```
-
-10.) Create a new branch using that tag.
-
-```vagrant at guest:~/git-repos/linux-stable$ git checkout -b cip_v4.4.27 v4.4.27```
-
-### Compile CIP Kernel ###
-
-11.) Set the environment variables
-
-```vagrant at guest:~/git-repos/linux-stable$ export TREE_NAME=cip-test```
-
-```vagrant at guest:~/git-repos/linux-stable$ export ARCH=arm```
-
-```vagrant at guest:~/git-repos/linux$ export CROSS_COMPILE=arm-linux-gnueabi-```
-
-Note: Don't forget the dash (-) at the end of the CROSS_COMPILE line!
-
-12.) Execute the build.py command
-
-```vagrant at guest:~/git-repos/linux-stable$ ~/kernelci-build/build.py -c tinyconfig -p CIP-KernelCI```
-
-13.) The Web Server is already running in the background. when you navigate from page to page the logs are written to the screen. To get back to the command line, simply press Enter
-
-14.) On your host machine, open a web browser and enter the following in the address box:
-
-http://localhost:5000
-
-15.) You will see the KernelCI Website home page from which, you can navigate to the different builds and trees that you've created
- 
+# Contribute to the CIP testing project: #
+* Please read the Testing at [CIP FAQ](https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingfaq) to learn more about this action.
+* Join the technical mailing list ( [cip-dev](https://lists.cip-project.org/mailman/listinfo/cip-dev) ) to follow this effort.
+* Report a [bug](https://gitlab.com/cip-project/testing/boards). 
 


=====================================
integration-scripts/configure_singledev.sh
=====================================
--- a/integration-scripts/configure_singledev.sh
+++ b/integration-scripts/configure_singledev.sh
@@ -11,11 +11,11 @@ sudo sed -ie 's/app.run(thread/app.run(host='\''0.0.0.0'\'', thread/g' /srv/kern
 # To Make KernelCI use the local machine for the "KernelCI Storage Server"
 # 1. Add this line in Vagrantfile, where ports are forwarded:
 # Make FILE_SERVER_URL point to 'http://localhost:8000/' instead of 'localhost'.
-sudo sed -ie "s/localhost/localhost:8000\//" /etc/linaro/kernelci-frontend.cfg
+sudo sed -ie "/FILE_SERVER_URL/s/localhost/localhost:8000\//g" /etc/linaro/kernelci-frontend.cfg
 
 # 2. The first is /etc/linaro/kernelci-frontend.cfg:
 # Make FILE_SERVER_URL point to "http://127.0.0.1:8000/" instead of "127.0.0.1".
-sudo sed -ie "s/127.0.0.1\//127.0.0.1:8000\//" /srv/kernelci-frontend/app/dashboard/default_settings.py
+sudo sed -ie "/FILE_SERVER_URL/s/127.0.0.1/127.0.0.1:8000/g" /srv/kernelci-frontend/app/dashboard/default_settings.py
 
 # 3. Run the fileserver from the directory that has artifacts:
 # cd /var/www/images/kernel-ci


=====================================
scripts/create_builds.sh
=====================================
--- a/scripts/create_builds.sh
+++ b/scripts/create_builds.sh
@@ -1,6 +1,6 @@
 cd ~
 cd git-repos
-git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
+git clone https://gitlab.com/cip-project/linux-cip.git
 cd linux-stable
 git checkout -b cip_v4.4.27 v4.4.27
 echo "Building ARMhf cip-tyrannosaurus Tree"



View it on GitLab: https://gitlab.com/cip-project/cip-testing/kernelci-debian/compare/f565fe7f787912016654920f2f3c566c586fa368...38e351dad3358fd09db59953962b28205f2433d1

---
View it on GitLab: https://gitlab.com/cip-project/cip-testing/kernelci-debian/compare/f565fe7f787912016654920f2f3c566c586fa368...38e351dad3358fd09db59953962b28205f2433d1
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180220/47509741/attachment-0001.html>
