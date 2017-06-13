From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Tue, 13 Jun 2017 13:41:39 +0100
Subject: [cip-dev] The Beaglebone black health check supplied in b@d
	0.9.1 will no longer run
In-Reply-To: <877f0hbikx.fsf@ctlt579.codethink.co.uk> (Robert Marshall's
	message of "Mon, 12 Jun 2017 11:34:22 +0100")
References: <877f0hbikx.fsf@ctlt579.codethink.co.uk>
Message-ID: <87ink09i0s.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Robert Marshall <robert.marshall@codethink.co.uk> writes:

> The 0.9.1 release of b at d contains a health check for the beaglebone
> black which uses various build artifacts on the linaro website at:
>
> http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4
>
> this directory has been moved and the files are now at
>
> http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/1
>
> If you have the Vagrant install you will need to change the suggested
> test at tests/bbb_debian_ramdisk_test.yaml to reflect the new location
> and edit the BBB health check if you have already installed that.
>
>     https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingboardatdesksingledevsetup#configure-the-lava-health-check-jobs-for-both-devices
>
> bbb_debian_local.yaml makes one reference to the linaro location which
> will also need changing if you use that file in association with
> lava-tool.
>
>     https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingreferencetestcases#test-5use-lava-tool-utility
>
> The issue https://gitlab.com/cip-project/cip-testing/testing/issues/103
> has been created to track this issue.
>
> We intend to update the git repository and release a new provisioned box
> later this week to resolve this issue.
>

Having thought more about this issue we would like to put forward the
following suggestion. Note that the URLs in the following are not
working they are only there as placeholders! Comments on the proposed
solution are welcome!

* Proposed solution to the issues with the Beaglebone health check

In the short term we propose that we create a tar archive of a new
version of the tests directory which we upload to the downloads area.

The differences between that archive and the one in the provisioned box
are at the end of this message. We will though upload the actual files
rather than the differences (though we could provide just the diff and explain
how to apply them?)

*** Important ***
These changes need applying whether the user is using b at d from git or the pre-provisioned box.

The Known issue section on this will include the following workaround:
------------------------------------------------------------------
The installation procedure is as follows:

On the VM
wget https://s3-us-west-2.amazonaws.com/download.cip-project.org/ciptesting/b%40d/b%40d_v0_9_1/box/tests-0.9.1.tgz.notworking
wget https://s3-us-west-2.amazonaws.com/download.cip-project.org/ciptesting/b%40d/b%40d_v0_9_1/box/tests-0.9.1.sha256sum.notworking
wget https://s3-us-west-2.amazonaws.com/download.cip-project.org/ciptesting/b%40d/b%40d_v0_9_1/box/tests-0.9.1.tgz.sig.notworking

* A standard section on using SHA256sum and GPG to check integrity and signature of
these tests will be included.

Then:

cd /vagrant
sudo tar txf $DOWNLOADDIR/tests-0.9.1.tgz

If you have already created a Beaglebone black health check then you
need to replace it with the new /vagrant/tests/bbb_debian_ramdisk_test.yaml

In the longer term there will be a 0.9.2 release of b at d which will
include a local version of initramfs and versions of the BBB kernel to
provide an initial health check.

-----------------------------------------------------------------------
Differences in tests:

diff --git a/tests/bbb_debian_local.yaml b/tests/bbb_debian_local.yaml
index acaaa5c..5dd7e1d 100644
--- a/tests/bbb_debian_local.yaml
+++ b/tests/bbb_debian_local.yaml
@@ -33,7 +33,7 @@ actions:
       url: http://localhost:8010/TREE/BRANCH/TAG/arm/omap2plus_defconfig/zImage
     ramdisk:
       # for the moment download from linaro
-      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/initramfs.cpio.gz
+      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/1/initramfs.cpio.gz
       compression: gz
       # the bootloader needs a u-boot header on the modified ramdisk
       add-header: u-boot
diff --git a/tests/bbb_debian_ramdisk_test.yaml b/tests/bbb_debian_ramdisk_test.yaml
index b9ff381..2a291e0 100644
--- a/tests/bbb_debian_ramdisk_test.yaml
+++ b/tests/bbb_debian_ramdisk_test.yaml
@@ -29,19 +29,19 @@ actions:
       minutes: 4
     to: tftp
     kernel:
-      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/vmlinuz
+      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/1/vmlinuz
     ramdisk:
-      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/initramfs.cpio.gz
+      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/1/initramfs.cpio.gz
       compression: gz
       # the bootloader needs a u-boot header on the modified ramdisk
       add-header: u-boot
     modules:
-      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/modules.tar.gz
+      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/1/modules.tar.gz
       compression: gz
     # despite this being a Debian initramfs, it is not a complete Debian rootfs, so use oe compatibility
     os: oe
     dtb:
-      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/dtbs/am335x-boneblack.dtb
+      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/1/dtbs/am335x-boneblack.dtb
 
 # BOOT_BLOCK
 - boot:
diff --git a/tests/bbb_debian_ramdisk_test2.yaml b/tests/bbb_debian_ramdisk_test2.yaml
index 4168acb..a7ca2c6 100644
--- a/tests/bbb_debian_ramdisk_test2.yaml
+++ b/tests/bbb_debian_ramdisk_test2.yaml
@@ -29,19 +29,19 @@ actions:
       minutes: 4
     to: tftp
     kernel:
-      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/vmlinuz
+      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/1/vmlinuz
     ramdisk:
-      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/initramfs.cpio.gz
+      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/1/initramfs.cpio.gz
       compression: gz
       # the bootloader needs a u-boot header on the modified ramdisk
       add-header: u-boot
     modules:
-      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/modules.tar.gz
+      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/1/modules.tar.gz
       compression: gz
     # despite this being a Debian initramfs, it is not a complete Debian rootfs, so use oe compatibility
     os: oe
     dtb:
-      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/4/dtbs/am335x-boneblack.dtb
+      url: http://snapshots.linaro.org/components/lava/standard/debian/jessie/armhf/1/dtbs/am335x-boneblack.dtb
 
 # BOOT_BLOCK
 - boot:
