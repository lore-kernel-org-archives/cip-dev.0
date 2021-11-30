Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E0BC43219
	for <webhook@archiver.kernel.org>; Tue, 30 Nov 2021 11:47:32 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web12.75058.1638272850595800475
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Nov 2021 03:47:31 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AUBlT04028350
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 30 Nov 2021 12:47:29 +0100
Received: from md2dvrtc.fritz.box ([139.22.40.121])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AUBlQAW003770;
	Tue, 30 Nov 2021 12:47:28 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RESEND PATCH 9/9] swupdate: Backport patches
 from SWUpdate Master
Date: Tue, 30 Nov 2021 12:47:26 +0100
Message-Id: <20211130114726.351921-10-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130114726.351921-1-Quirin.Gylstorff@siemens.com>
References: <20211130114726.351921-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Nov 2021 11:47:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7046

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Backport the following patches to detect the correct partition to
update.
388f1777 util: Add get_root source /proc/self/mountinfo
3914d2b7 util: Extend get_root to find LUKS devices

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...an-patches-add-patches-for-dm-verity.patch | 191 ++++++++++++++++++
 .../swupdate/swupdate_2021.04-1+debian-gbp.bb |   5 +
 2 files changed, 196 insertions(+)
 create mode 100644 recipes-core/swupdate/files/0001-debian-patches-add-patches-for-dm-verity.patch

diff --git a/recipes-core/swupdate/files/0001-debian-patches-add-patches-for-dm-verity.patch b/recipes-core/swupdate/files/0001-debian-patches-add-patches-for-dm-verity.patch
new file mode 100644
index 0000000..a4c8856
--- /dev/null
+++ b/recipes-core/swupdate/files/0001-debian-patches-add-patches-for-dm-verity.patch
@@ -0,0 +1,191 @@
+From 9904222a872e1707d8e1205009962fd68c3e5c7d Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Mon, 25 Oct 2021 14:43:07 +0200
+Subject: [PATCH] debian/patches: add patches for dm-verity
+
+Backport the following patches to detect the correct partition to
+update.
+388f1777 util: Add get_root source /proc/self/mountinfo
+3914d2b7 util: Extend get_root to find LUKS devices
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ ...d-get_root-source-proc-self-mountinfo.diff | 67 +++++++++++++++
+ ...-Extend-get_root-to-find-LUKS-devices.diff | 82 +++++++++++++++++++
+ debian/patches/series                         |  2 +
+ 3 files changed, 151 insertions(+)
+ create mode 100644 debian/patches/0001-util-Add-get_root-source-proc-self-mountinfo.diff
+ create mode 100644 debian/patches/0002-util-Extend-get_root-to-find-LUKS-devices.diff
+
+diff --git a/debian/patches/0001-util-Add-get_root-source-proc-self-mountinfo.diff b/debian/patches/0001-util-Add-get_root-source-proc-self-mountinfo.diff
+new file mode 100644
+index 0000000..2b25a19
+--- /dev/null
++++ b/debian/patches/0001-util-Add-get_root-source-proc-self-mountinfo.diff
+@@ -0,0 +1,67 @@
++From 388f1777e3e9e7dfbe41768aa7ce86bc0ee25c37 Mon Sep 17 00:00:00 2001
++From: Christian Storm <christian.storm@siemens.com>
++Date: Thu, 10 Jun 2021 00:30:24 +0200
++Subject: [PATCH 1/2] util: Add get_root source /proc/self/mountinfo
++
++Filesystems such as BTRFS report synthetic device major:minor
++numbers in stat(2)'s st_dev value. Hence, such a root filesystem
++won't be found by get_root_from_partitions().
++
++As /proc/self/mountinfo's information is subject to mount-
++namespacing, it complements get_root_from_partitions() rather
++than replacing it.
++
++Signed-off-by: Christian Storm <christian.storm@siemens.com>
++---
++ core/util.c | 28 ++++++++++++++++++++++++++++
++ 1 file changed, 28 insertions(+)
++
++diff --git a/core/util.c b/core/util.c
++index 7d7673a..51a16b6 100644
++--- a/core/util.c
+++++ b/core/util.c
++@@ -883,6 +883,32 @@ static char *get_root_from_partitions(void)
++ 	return NULL;
++ }
++ 
+++/*
+++ * Return the rootfs's device name from /proc/self/mountinfo.
+++ * Needed for filesystems having synthetic stat(2) st_dev
+++ * values such as BTRFS.
+++ */
+++static char *get_root_from_mountinfo(void)
+++{
+++	char *mnt_point, *device = NULL;
+++	FILE *fp = fopen("/proc/self/mountinfo", "r");
+++	while (fp && !feof(fp)){
+++		/* format: https://www.kernel.org/doc/Documentation/filesystems/proc.txt */
+++		if (fscanf(fp, "%*s %*s %*u:%*u %*s %ms %*s %*[-] %*s %ms %*s",
+++			   &mnt_point, &device) == 2) {
+++			if ( (!strcmp(mnt_point, "/")) && (strcmp(device, "none")) ) {
+++				free(mnt_point);
+++				break;
+++			}
+++			free(mnt_point);
+++			free(device);
+++		}
+++		device = NULL;
+++	}
+++	(void)fclose(fp);
+++	return device;
+++}
+++
++ #define MAX_CMDLINE_LENGTH 4096
++ static char *get_root_from_cmdline(void)
++ {
++@@ -936,6 +962,8 @@ char *get_root_device(void)
++ 	root = get_root_from_partitions();
++ 	if (!root)
++ 		root = get_root_from_cmdline();
+++	if (!root)
+++		root = get_root_from_mountinfo();
++ 
++ 	return root;
++ }
++-- 
++2.30.2
++
+diff --git a/debian/patches/0002-util-Extend-get_root-to-find-LUKS-devices.diff b/debian/patches/0002-util-Extend-get_root-to-find-LUKS-devices.diff
+new file mode 100644
+index 0000000..039bfb8
+--- /dev/null
++++ b/debian/patches/0002-util-Extend-get_root-to-find-LUKS-devices.diff
+@@ -0,0 +1,82 @@
++From 3914d2b73bf80b24aba015d9225082c2965c7a02 Mon Sep 17 00:00:00 2001
++From: Stefano Babic <sbabic@denx.de>
++Date: Thu, 10 Jun 2021 16:14:44 +0200
++Subject: [PATCH 2/2] util: Extend get_root to find LUKS devices
++
++This helps in case of encrypted filesystem or device mapper.
++The returned device read from partitions is usually a dm-X device and
++this does not show which is the block device that contains it. Look in
++sysfs and check if the device has "slaves" entries, indicating the
++presence of an underlying device. If found, return this instead of the
++device returned parsing /proc/partitions.
++
++Signed-off-by: Stefano Babic <sbabic@denx.de>
++---
++ core/util.c | 26 ++++++++++++++++++++++++--
++ 1 file changed, 24 insertions(+), 2 deletions(-)
++
++diff --git a/core/util.c b/core/util.c
++index 51a16b6..3b81c09 100644
++--- a/core/util.c
+++++ b/core/util.c
++@@ -24,6 +24,7 @@
++ #include <libgen.h>
++ #include <regex.h>
++ #include <string.h>
+++#include <dirent.h>
++ 
++ #if defined(__linux__)
++ #include <sys/statvfs.h>
++@@ -851,6 +852,10 @@ size_t snescape(char *dst, size_t n, const char *src)
++ /*
++  * This returns the device name where rootfs is mounted
++  */
+++
+++static int filter_slave(const struct dirent *ent) {
+++	return (strcmp(ent->d_name, ".") && strcmp(ent->d_name, ".."));
+++}
++ static char *get_root_from_partitions(void)
++ {
++ 	struct stat info;
++@@ -858,11 +863,28 @@ static char *get_root_from_partitions(void)
++ 	char *devname = NULL;
++ 	unsigned long major, minor, nblocks;
++ 	char buf[256];
++-	int ret;
+++	int ret, dev_major, dev_minor, n;
+++	struct dirent **devlist = NULL;
++ 
++ 	if (stat("/", &info) < 0)
++ 		return NULL;
++ 
+++	dev_major = info.st_dev / 256;
+++	dev_minor = info.st_dev % 256;
+++
+++	/*
+++	 * Check if this is just a container, for example in case of LUKS
+++	 * Search if the device has slaves pointing to another device
+++	 */
+++	snprintf(buf, sizeof(buf) - 1, "/sys/dev/block/%d:%d/slaves", dev_major, dev_minor);
+++	n = scandir(buf, &devlist, filter_slave, NULL);
+++	if (n == 1) {
+++		devname = strdup(devlist[0]->d_name);
+++		free(devlist);
+++		return devname;
+++	}
+++	free(devlist);
+++
++ 	fp = fopen("/proc/partitions", "r");
++ 	if (!fp)
++ 		return NULL;
++@@ -872,7 +894,7 @@ static char *get_root_from_partitions(void)
++ 			     &major, &minor, &nblocks, &devname);
++ 		if (ret != 4)
++ 			continue;
++-		if ((major == info.st_dev / 256) && (minor == info.st_dev % 256)) {
+++		if ((major == dev_major) && (minor == dev_minor)) {
++ 			fclose(fp);
++ 			return devname;
++ 		}
++-- 
++2.30.2
++
+diff --git a/debian/patches/series b/debian/patches/series
+index 8c5564a..f3bd00e 100644
+--- a/debian/patches/series
++++ b/debian/patches/series
+@@ -1 +1,3 @@
+ use-gcc-compiler.diff
++0002-util-Extend-get_root-to-find-LUKS-devices.diff
++0001-util-Add-get_root-source-proc-self-mountinfo.diff
+-- 
+2.30.2
+
diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
index 7a0fb9b..a4d67fe 100644
--- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
@@ -25,6 +25,11 @@ SRC_URI += "file://0001-debian-Add-option-to-build-with-efibootguard.patch \
             file://0007-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch \
             file://0008-debian-rules-Add-Embedded-Lua-handler-option.patch"
 
+# Patch for dm-verity based images - can be removed with next SWUpdate release
+SRC_URI += "file://0001-debian-patches-add-patches-for-dm-verity.patch"
+
+# end patching for dm-verity based images
+
 # deactivate signing and encryption for simple a/b rootfs update
 SWUPDATE_BUILD_PROFILES += "pkg.swupdate.nosigning pkg.swupdate.noencryption"
 
-- 
2.30.2


