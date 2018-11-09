From: gitlab@mg.gitlab.com (Robert Marshall)
Date: Fri, 09 Nov 2018 12:56:00 +0000
Subject: [cip-dev]
 [Git][cip-project/cip-testing/board-at-desk-single-dev][master] 2 commits:
 Added admin info - fairly skeletal at the moment.
Message-ID: <5be583e07b420_2183fa7be87e3e414585e2@sidekiq-asap-02-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Robert Marshall pushed to branch master at cip-project / cip-testing / board-at-desk-single-dev


Commits:
70647d07 by Robert Marshall at 2018-10-26T09:56:26Z
Added admin info - fairly skeletal at the moment.

- - - - -
3ad9ac74 by Robert Marshall at 2018-11-08T15:55:02Z
Added significant content

- - - - -


1 changed file:

- + admin-info/admin.mdwn


Changes:

=====================================
admin-info/admin.mdwn
=====================================
@@ -0,0 +1,56 @@
+* wiki link
+  but it's in README.md 
+  https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingboardatdesksingledevfeaturepage
+
+* Mostly in issues
+
+  Highlight some
+  
+* Thoughts on docker
+
+  See the appropriate tickets for the current state #192, #197 and #198
+
+* Populate script
+  There's a script at https://gitlab.com/rajm/board-at-desk-single-dev/blob/boxPopulate/scripts/populate.sh
+  which I use for the fortnightly provision check (#149). It carries out the tasks on the wiki downloading and building a BBB kernel and initramfs
+  and sets off a health check on the BBB and QEMU. You need to visit http://localhost:8080 to check whether it has worked,
+  as it just leaves the 2 health checks running. It could be used as a basis for other build scripts. Run it within the vm.
+
+* Notifications
+  - IRC pinging doesn't currently work on freenode because of spam prevention measures.
+  - Agust?n has the authorisation details for srv_ln001 at codethink.co.uk which was used to
+    email cip-testing-results.
+
+* Box creation script
+
+Instructions for creating and uploading box and associated files
+
+Clone a new version of the repos and step through the setup on the wiki, cloning the linux-cip repos running a build. Configure the notification email smtp settings.
+
+Run the webserver and check that the successful build is visible
+Run a health check on a Beaglebone Black verify that it completes successfully - including a notification to the cip-testing-results list (or preferably to the box builder instead?).
+Remove any local email settings from the box.
+Remove any valid IRC handle /email address from the health checks notification.
+On the VM, edit mybbb.dat to reset IP address to the default 'localhost' (thus matching the wiki instructions) - and add it in that state to the data dictionary. (to avoid a surprise for the user?)
+
+sudo apt-get clean -y
+sudo apt-get autoclean -y
+cd git-repos/linux-cip
+make clean
+git clean -dfx
+cd ~/work/busybox-1.26.2/
+make clean
+
+sudo dd if=/dev/zero of=/EMPTY bs=1M
+sudo rm /EMPTY
+Will also need to clear up ~/work for the initramfs build, and then on the host (in the git board-at-desk-single-dev directory)
+
+for the release
+vagrant package --output ../cip_board_at_desk_v0.9.n.box
+for betas:
+vagrant package --output ../cip_board_at_desk_v0.9.n.beta_YYYY_MM_DD.box 
+(replacing YYYY-MM-DD with the box creation date aka ../cip_board_at_desk_v0.9.date +%Y_%m_%d.box as we will be losing the beta)
+
+We will also need to generate a hash of the release and the source code and upload it all to the download area.
+
+*Finally, * so that we can estimate for the release, we need an accurate record of how long the process takes including the complete upload to all required data to the website.



View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/333024a28086e6f98ec9b871d5467e0544c2ac9e...3ad9ac7426f7ee4cf0104d643505076e1b74cc77

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/333024a28086e6f98ec9b871d5467e0544c2ac9e...3ad9ac7426f7ee4cf0104d643505076e1b74cc77
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20181109/200fd637/attachment-0001.html>
