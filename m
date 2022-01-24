X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web09.4768.1643036982431121553
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Jan 2022 07:09:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=kDFGyA/b;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202201241508560e98f97b4d877485cf-q_rn_c@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202201241508560e98f97b4d877485cf
        for <cip-dev@lists.cip-project.org>;
        Mon, 24 Jan 2022 16:09:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=09fBmd6Vwmtp940QJZpsKv6enVEQUbOEVAUtN7U0ECA=;
 b=kDFGyA/bJTaF2XiNCzV+1mifJnDgcB5sHRmP0izNIsAwdxVO1uk+aJqSf8JC7EvRigxMbe
 Emohn0H03Co6KNWzSvJG8Oebb+qNE7GuFV2lc+7FAd0kHypxKfqNAM8amON5EBymsFnZgVZw
 BzYuD22O+FOrR/JTi7xyuDQu6X1kI=;
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	Jan.Kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] update SWUpdate to 2021.11
Date: Mon, 24 Jan 2022 16:08:55 +0100
Message-Id: <20220124150855.633257-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
List-Id: <cip-dev.lists.cip-project.org>

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../swupdate-handler-roundrobin_0.1.bb        |   4 +-
 ...dd-option-to-build-with-efibootguard.patch |  39 ----
 ...nfig-Make-image-encryption-optional.patch} |  14 +-
 ...an-patches-add-patches-for-dm-verity.patch | 191 ------------------
 .../0002-debian-rules-Add-CONFIG_MTD.patch    |   8 +-
 ...-debian-config-Make-signing-optional.patch |  40 ----
 ...s-Add-option-to-disable-fs-creation.patch} |  32 +--
 ...les-Add-option-to-disable-webserver.patch} |  10 +-
 ...ake-CONFIG_HW_COMPATIBILTY-optional.patch} |  10 +-
 ...les-Add-Embedded-Lua-handler-option.patch} |  10 +-
 ...repare-build-for-isar-debian-buster.patch} |  18 +-
 ...bp.bb => swupdate_2021.11-1+debian-gbp.bb} |  19 +-
 12 files changed, 63 insertions(+), 332 deletions(-)
 delete mode 100644 recipes-core/swupdate/files/0001-debian-Add-option-to-build-with-efibootguard.patch
 rename recipes-core/swupdate/files/{0004-debian-config-Make-image-encryption-optional.patch => 0001-debian-config-Make-image-encryption-optional.patch} (80%)
 delete mode 100644 recipes-core/swupdate/files/0001-debian-patches-add-patches-for-dm-verity.patch
 delete mode 100644 recipes-core/swupdate/files/0003-debian-config-Make-signing-optional.patch
 rename recipes-core/swupdate/files/{0005-debian-rules-Add-option-to-disable-fs-creation.patch => 0003-debian-rules-Add-option-to-disable-fs-creation.patch} (51%)
 rename recipes-core/swupdate/files/{0006-debian-rules-Add-option-to-disable-webserver.patch => 0004-debian-rules-Add-option-to-disable-webserver.patch} (85%)
 rename recipes-core/swupdate/files/{0007-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch => 0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch} (85%)
 rename recipes-core/swupdate/files/{0008-debian-rules-Add-Embedded-Lua-handler-option.patch => 0006-debian-rules-Add-Embedded-Lua-handler-option.patch} (83%)
 rename recipes-core/swupdate/files/{0009-debian-prepare-build-for-isar-debian-buster.patch => 0007-debian-prepare-build-for-isar-debian-buster.patch} (84%)
 rename recipes-core/swupdate/{swupdate_2021.04-1+debian-gbp.bb => swupdate_2021.11-1+debian-gbp.bb} (68%)

diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index 3a5a51e..1f0a620 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -22,10 +22,10 @@ SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if
 
 # lua version 5.2 is currently hard coded in swupdate @ debian salsa
 do_install[cleandirs] = "${D}/etc \
-                         ${D}/usr/share/lua/5.2"
+                         ${D}/usr/share/lua/5.3"
 do_install() {
     if [ -e ${WORKDIR}/${SWUPDATE_LUASCRIPT} ]; then
-        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${D}/usr/share/lua/5.2/swupdate_handlers.lua
+        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${D}/usr/share/lua/5.3/swupdate_handlers.lua
     fi
     if [ -e ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ]; then
        install -m 0644 ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ${D}/etc/swupdate.handler.ini
diff --git a/recipes-core/swupdate/files/0001-debian-Add-option-to-build-with-efibootguard.patch b/recipes-core/swupdate/files/0001-debian-Add-option-to-build-with-efibootguard.patch
deleted file mode 100644
index 00f9a5f..0000000
--- a/recipes-core/swupdate/files/0001-debian-Add-option-to-build-with-efibootguard.patch
+++ /dev/null
@@ -1,39 +0,0 @@
-From fe3f090e3764e1e2625d509a56bd521bab507ce7 Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Wed, 15 Sep 2021 12:36:09 +0200
-Subject: [PATCH 1/9] debian: Add option to build with efibootguard
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- debian/control | 1 +
- debian/rules   | 2 ++
- 2 files changed, 3 insertions(+)
-
-diff --git a/debian/control b/debian/control
-index 9e43eab..6031537 100644
---- a/debian/control
-+++ b/debian/control
-@@ -28,6 +28,7 @@ Build-Depends: debhelper-compat (= 13),
-                libwebsockets-dev (>= 3.2.0) <!pkg.swupdate.bpo>,
-                liburiparser-dev <!pkg.swupdate.bpo>,
-                libubootenv-dev <pkg.swupdate.uboot>,
-+               efibootguard-dev <pkg.swupdate.efibootguard>,
-                libcmocka-dev,
-                pkg-config,
-                gawk,
-diff --git a/debian/rules b/debian/rules
-index 4b55be2..c076839 100755
---- a/debian/rules
-+++ b/debian/rules
-@@ -33,6 +33,8 @@ ifneq (,$(filter pkg.swupdate.uboot,$(DEB_BUILD_PROFILES)))
- else ifneq (,$(filter pkg.swupdate.grub,$(DEB_BUILD_PROFILES)))
- 	echo CONFIG_BOOTLOADER_GRUB=y                   >> configs/debian_defconfig
- 	echo CONFIG_GRUBENV_PATH=\"/boot/grub/grubenv\" >> configs/debian_defconfig
-+else ifneq (,$(filter pkg.swupdate.efibootguard,$(DEB_BUILD_PROFILES)))
-+	echo CONFIG_BOOTLOADER_EBG=y                    >> configs/debian_defconfig
- else
- 	echo CONFIG_BOOTLOADER_NONE=y                   >> configs/debian_defconfig
- endif
--- 
-2.30.2
-
diff --git a/recipes-core/swupdate/files/0004-debian-config-Make-image-encryption-optional.patch b/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
similarity index 80%
rename from recipes-core/swupdate/files/0004-debian-config-Make-image-encryption-optional.patch
rename to recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
index 45990f8..c07b103 100644
--- a/recipes-core/swupdate/files/0004-debian-config-Make-image-encryption-optional.patch
+++ b/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
@@ -1,7 +1,9 @@
-From b0cfcc9980c6daf6383c6dc51fdbe90e1c7625d5 Mon Sep 17 00:00:00 2001
+From 20bb45563fe8f3ec95ef22d715d1add014156543 Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Wed, 29 Sep 2021 15:28:21 +0200
-Subject: [PATCH 4/9] debian/config: Make image encryption optional
+Subject: [PATCH 1/7] debian/config: Make image encryption optional
+
+This can be use to ease the setup with SWUpdate.
 
 Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 ---
@@ -10,7 +12,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
  2 files changed, 3 insertions(+), 1 deletion(-)
 
 diff --git a/debian/configs/defconfig b/debian/configs/defconfig
-index f959e44..8e1a810 100644
+index 02681e53..b34168e3 100644
 --- a/debian/configs/defconfig
 +++ b/debian/configs/defconfig
 @@ -3,7 +3,6 @@ CONFIG_HW_COMPATIBILITY=y
@@ -22,10 +24,10 @@ index f959e44..8e1a810 100644
  CONFIG_SURICATTA_SSL=y
  CONFIG_UPDATE_STATE_CHOICE_BOOTLOADER=y
 diff --git a/debian/rules b/debian/rules
-index 4793c84..6d32d50 100755
+index 864add23..08b74a1d 100755
 --- a/debian/rules
 +++ b/debian/rules
-@@ -42,6 +42,9 @@ endif
+@@ -41,6 +41,9 @@ endif
  ifeq (,$(filter pkg.swupdate.nosigning,$(DEB_BUILD_PROFILES)))
  	echo CONFIG_SIGNED_IMAGES=y >> configs/debian_defconfig
  endif
@@ -36,5 +38,5 @@ index 4793c84..6d32d50 100755
  	echo CONFIG_PKCS11=y >> configs/debian_defconfig
  endif
 -- 
-2.30.2
+2.34.1
 
diff --git a/recipes-core/swupdate/files/0001-debian-patches-add-patches-for-dm-verity.patch b/recipes-core/swupdate/files/0001-debian-patches-add-patches-for-dm-verity.patch
deleted file mode 100644
index a4c8856..0000000
--- a/recipes-core/swupdate/files/0001-debian-patches-add-patches-for-dm-verity.patch
+++ /dev/null
@@ -1,191 +0,0 @@
-From 9904222a872e1707d8e1205009962fd68c3e5c7d Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Mon, 25 Oct 2021 14:43:07 +0200
-Subject: [PATCH] debian/patches: add patches for dm-verity
-
-Backport the following patches to detect the correct partition to
-update.
-388f1777 util: Add get_root source /proc/self/mountinfo
-3914d2b7 util: Extend get_root to find LUKS devices
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- ...d-get_root-source-proc-self-mountinfo.diff | 67 +++++++++++++++
- ...-Extend-get_root-to-find-LUKS-devices.diff | 82 +++++++++++++++++++
- debian/patches/series                         |  2 +
- 3 files changed, 151 insertions(+)
- create mode 100644 debian/patches/0001-util-Add-get_root-source-proc-self-mountinfo.diff
- create mode 100644 debian/patches/0002-util-Extend-get_root-to-find-LUKS-devices.diff
-
-diff --git a/debian/patches/0001-util-Add-get_root-source-proc-self-mountinfo.diff b/debian/patches/0001-util-Add-get_root-source-proc-self-mountinfo.diff
-new file mode 100644
-index 0000000..2b25a19
---- /dev/null
-+++ b/debian/patches/0001-util-Add-get_root-source-proc-self-mountinfo.diff
-@@ -0,0 +1,67 @@
-+From 388f1777e3e9e7dfbe41768aa7ce86bc0ee25c37 Mon Sep 17 00:00:00 2001
-+From: Christian Storm <christian.storm@siemens.com>
-+Date: Thu, 10 Jun 2021 00:30:24 +0200
-+Subject: [PATCH 1/2] util: Add get_root source /proc/self/mountinfo
-+
-+Filesystems such as BTRFS report synthetic device major:minor
-+numbers in stat(2)'s st_dev value. Hence, such a root filesystem
-+won't be found by get_root_from_partitions().
-+
-+As /proc/self/mountinfo's information is subject to mount-
-+namespacing, it complements get_root_from_partitions() rather
-+than replacing it.
-+
-+Signed-off-by: Christian Storm <christian.storm@siemens.com>
-+---
-+ core/util.c | 28 ++++++++++++++++++++++++++++
-+ 1 file changed, 28 insertions(+)
-+
-+diff --git a/core/util.c b/core/util.c
-+index 7d7673a..51a16b6 100644
-+--- a/core/util.c
-++++ b/core/util.c
-+@@ -883,6 +883,32 @@ static char *get_root_from_partitions(void)
-+ 	return NULL;
-+ }
-+ 
-++/*
-++ * Return the rootfs's device name from /proc/self/mountinfo.
-++ * Needed for filesystems having synthetic stat(2) st_dev
-++ * values such as BTRFS.
-++ */
-++static char *get_root_from_mountinfo(void)
-++{
-++	char *mnt_point, *device = NULL;
-++	FILE *fp = fopen("/proc/self/mountinfo", "r");
-++	while (fp && !feof(fp)){
-++		/* format: https://www.kernel.org/doc/Documentation/filesystems/proc.txt */
-++		if (fscanf(fp, "%*s %*s %*u:%*u %*s %ms %*s %*[-] %*s %ms %*s",
-++			   &mnt_point, &device) == 2) {
-++			if ( (!strcmp(mnt_point, "/")) && (strcmp(device, "none")) ) {
-++				free(mnt_point);
-++				break;
-++			}
-++			free(mnt_point);
-++			free(device);
-++		}
-++		device = NULL;
-++	}
-++	(void)fclose(fp);
-++	return device;
-++}
-++
-+ #define MAX_CMDLINE_LENGTH 4096
-+ static char *get_root_from_cmdline(void)
-+ {
-+@@ -936,6 +962,8 @@ char *get_root_device(void)
-+ 	root = get_root_from_partitions();
-+ 	if (!root)
-+ 		root = get_root_from_cmdline();
-++	if (!root)
-++		root = get_root_from_mountinfo();
-+ 
-+ 	return root;
-+ }
-+-- 
-+2.30.2
-+
-diff --git a/debian/patches/0002-util-Extend-get_root-to-find-LUKS-devices.diff b/debian/patches/0002-util-Extend-get_root-to-find-LUKS-devices.diff
-new file mode 100644
-index 0000000..039bfb8
---- /dev/null
-+++ b/debian/patches/0002-util-Extend-get_root-to-find-LUKS-devices.diff
-@@ -0,0 +1,82 @@
-+From 3914d2b73bf80b24aba015d9225082c2965c7a02 Mon Sep 17 00:00:00 2001
-+From: Stefano Babic <sbabic@denx.de>
-+Date: Thu, 10 Jun 2021 16:14:44 +0200
-+Subject: [PATCH 2/2] util: Extend get_root to find LUKS devices
-+
-+This helps in case of encrypted filesystem or device mapper.
-+The returned device read from partitions is usually a dm-X device and
-+this does not show which is the block device that contains it. Look in
-+sysfs and check if the device has "slaves" entries, indicating the
-+presence of an underlying device. If found, return this instead of the
-+device returned parsing /proc/partitions.
-+
-+Signed-off-by: Stefano Babic <sbabic@denx.de>
-+---
-+ core/util.c | 26 ++++++++++++++++++++++++--
-+ 1 file changed, 24 insertions(+), 2 deletions(-)
-+
-+diff --git a/core/util.c b/core/util.c
-+index 51a16b6..3b81c09 100644
-+--- a/core/util.c
-++++ b/core/util.c
-+@@ -24,6 +24,7 @@
-+ #include <libgen.h>
-+ #include <regex.h>
-+ #include <string.h>
-++#include <dirent.h>
-+ 
-+ #if defined(__linux__)
-+ #include <sys/statvfs.h>
-+@@ -851,6 +852,10 @@ size_t snescape(char *dst, size_t n, const char *src)
-+ /*
-+  * This returns the device name where rootfs is mounted
-+  */
-++
-++static int filter_slave(const struct dirent *ent) {
-++	return (strcmp(ent->d_name, ".") && strcmp(ent->d_name, ".."));
-++}
-+ static char *get_root_from_partitions(void)
-+ {
-+ 	struct stat info;
-+@@ -858,11 +863,28 @@ static char *get_root_from_partitions(void)
-+ 	char *devname = NULL;
-+ 	unsigned long major, minor, nblocks;
-+ 	char buf[256];
-+-	int ret;
-++	int ret, dev_major, dev_minor, n;
-++	struct dirent **devlist = NULL;
-+ 
-+ 	if (stat("/", &info) < 0)
-+ 		return NULL;
-+ 
-++	dev_major = info.st_dev / 256;
-++	dev_minor = info.st_dev % 256;
-++
-++	/*
-++	 * Check if this is just a container, for example in case of LUKS
-++	 * Search if the device has slaves pointing to another device
-++	 */
-++	snprintf(buf, sizeof(buf) - 1, "/sys/dev/block/%d:%d/slaves", dev_major, dev_minor);
-++	n = scandir(buf, &devlist, filter_slave, NULL);
-++	if (n == 1) {
-++		devname = strdup(devlist[0]->d_name);
-++		free(devlist);
-++		return devname;
-++	}
-++	free(devlist);
-++
-+ 	fp = fopen("/proc/partitions", "r");
-+ 	if (!fp)
-+ 		return NULL;
-+@@ -872,7 +894,7 @@ static char *get_root_from_partitions(void)
-+ 			     &major, &minor, &nblocks, &devname);
-+ 		if (ret != 4)
-+ 			continue;
-+-		if ((major == info.st_dev / 256) && (minor == info.st_dev % 256)) {
-++		if ((major == dev_major) && (minor == dev_minor)) {
-+ 			fclose(fp);
-+ 			return devname;
-+ 		}
-+-- 
-+2.30.2
-+
-diff --git a/debian/patches/series b/debian/patches/series
-index 8c5564a..f3bd00e 100644
---- a/debian/patches/series
-+++ b/debian/patches/series
-@@ -1 +1,3 @@
- use-gcc-compiler.diff
-+0002-util-Extend-get_root-to-find-LUKS-devices.diff
-+0001-util-Add-get_root-source-proc-self-mountinfo.diff
--- 
-2.30.2
-
diff --git a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
index 0921aef..8ebd09e 100644
--- a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
+++ b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
@@ -1,7 +1,7 @@
-From 43365f98d70d83dac42913ff907a8a9dd25a4333 Mon Sep 17 00:00:00 2001
+From 1d52fe25e72f9e33525bca7efa5efe901cb32c65 Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Wed, 29 Sep 2021 11:29:57 +0200
-Subject: [PATCH 2/9] debian/rules: Add CONFIG_MTD
+Subject: [PATCH 2/7] debian/rules: Add CONFIG_MTD
 
 if pkg.swupdate.bpo is set CONFIG_MTD is disable but not enabled.
 
@@ -11,7 +11,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/debian/rules b/debian/rules
-index c076839..292133b 100755
+index 08b74a1d..6705140b 100755
 --- a/debian/rules
 +++ b/debian/rules
 @@ -20,6 +20,7 @@ endif
@@ -23,5 +23,5 @@ index c076839..292133b 100755
  	echo CONFIG_CFI=y                  >> configs/debian_defconfig
  	echo CONFIG_CFIHAMMING1=y          >> configs/debian_defconfig
 -- 
-2.30.2
+2.34.1
 
diff --git a/recipes-core/swupdate/files/0003-debian-config-Make-signing-optional.patch b/recipes-core/swupdate/files/0003-debian-config-Make-signing-optional.patch
deleted file mode 100644
index 347b316..0000000
--- a/recipes-core/swupdate/files/0003-debian-config-Make-signing-optional.patch
+++ /dev/null
@@ -1,40 +0,0 @@
-From 37f9afeeac5483f677b5be41b3d31e6557fcc146 Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Wed, 29 Sep 2021 15:27:51 +0200
-Subject: [PATCH 3/9] debian/config: Make signing optional
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- debian/configs/defconfig | 1 -
- debian/rules             | 3 +++
- 2 files changed, 3 insertions(+), 1 deletion(-)
-
-diff --git a/debian/configs/defconfig b/debian/configs/defconfig
-index b38aa62..f959e44 100644
---- a/debian/configs/defconfig
-+++ b/debian/configs/defconfig
-@@ -2,7 +2,6 @@ CONFIG_SYSTEMD=y
- CONFIG_HW_COMPATIBILITY=y
- CONFIG_DOWNLOAD=y
- CONFIG_DOWNLOAD_SSL=y
--CONFIG_SIGNED_IMAGES=y
- CONFIG_SIGALG_CMS=y
- CONFIG_ENCRYPTED_IMAGES=y
- CONFIG_SURICATTA=y
-diff --git a/debian/rules b/debian/rules
-index 292133b..4793c84 100755
---- a/debian/rules
-+++ b/debian/rules
-@@ -39,6 +39,9 @@ else ifneq (,$(filter pkg.swupdate.efibootguard,$(DEB_BUILD_PROFILES)))
- else
- 	echo CONFIG_BOOTLOADER_NONE=y                   >> configs/debian_defconfig
- endif
-+ifeq (,$(filter pkg.swupdate.nosigning,$(DEB_BUILD_PROFILES)))
-+	echo CONFIG_SIGNED_IMAGES=y >> configs/debian_defconfig
-+endif
- ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
- 	echo CONFIG_PKCS11=y >> configs/debian_defconfig
- endif
--- 
-2.30.2
-
diff --git a/recipes-core/swupdate/files/0005-debian-rules-Add-option-to-disable-fs-creation.patch b/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
similarity index 51%
rename from recipes-core/swupdate/files/0005-debian-rules-Add-option-to-disable-fs-creation.patch
rename to recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
index 1121923..876e164 100644
--- a/recipes-core/swupdate/files/0005-debian-rules-Add-option-to-disable-fs-creation.patch
+++ b/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
@@ -1,47 +1,51 @@
-From 22a96e95676123c6ce8800b9d911402704dce9e2 Mon Sep 17 00:00:00 2001
+From 8b6f01b6126933723963497d0db0c256e5251c5b Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Mon, 4 Oct 2021 17:15:56 +0200
-Subject: [PATCH 5/9] debian/rules: Add option to disable fs creation
+Subject: [PATCH 3/7] debian/rules: Add option to disable fs creation
 
 Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 ---
- debian/configs/defconfig | 4 ----
- debian/rules             | 7 +++++++
- 2 files changed, 7 insertions(+), 4 deletions(-)
+ debian/configs/defconfig | 6 ------
+ debian/rules             | 9 +++++++++
+ 2 files changed, 9 insertions(+), 6 deletions(-)
 
 diff --git a/debian/configs/defconfig b/debian/configs/defconfig
-index 8e1a810..d011deb 100644
+index b34168e3..d011deb1 100644
 --- a/debian/configs/defconfig
 +++ b/debian/configs/defconfig
-@@ -9,10 +9,6 @@ CONFIG_UPDATE_STATE_CHOICE_BOOTLOADER=y
+@@ -9,12 +9,6 @@ CONFIG_UPDATE_STATE_CHOICE_BOOTLOADER=y
  CONFIG_WEBSERVER=y
  CONFIG_MONGOOSESSL=y
  CONFIG_ZSTD=y
 -CONFIG_DISKPART=y
+-CONFIG_DISKPART_FORMAT=y
 -CONFIG_DISKFORMAT=y
+-CONFIG_DISKFORMAT_HANDLER=y
 -CONFIG_FAT_FILESYSTEM=y
 -CONFIG_EXT_FILESYSTEM=y
  CONFIG_UNIQUEUUID=y
  CONFIG_RAW=y
  CONFIG_RDIFFHANDLER=y
 diff --git a/debian/rules b/debian/rules
-index 6d32d50..9349c22 100755
+index 6705140b..983e122f 100755
 --- a/debian/rules
 +++ b/debian/rules
-@@ -45,6 +45,13 @@ endif
+@@ -45,6 +45,15 @@ endif
  ifeq (,$(filter pkg.swupdate.noencryption,$(DEB_BUILD_PROFILES)))
  	echo CONFIG_ENCRYPTED_IMAGES=y >> configs/debian_defconfig
  endif
 +ifeq (,$(filter pkg.swupdate.nocreatefs,$(DEB_BUILD_PROFILES)))
-+	echo CONFIG_DISKPART=y       >> configs/debian_defconfig
-+	echo CONFIG_DISKFORMAT=y     >> configs/debian_defconfig
-+	echo CONFIG_FAT_FILESYSTEM=y >> configs/debian_defconfig
-+	echo CONFIG_EXT_FILESYSTEM=y >> configs/debian_defconfig
++	echo CONFIG_DISKPART=y            >> configs/debian_defconfig
++	echo CONFIG_DISKPART_FORMAT=y     >> configs/debian_defconfig
++	echo CONFIG_DISKFORMAT=y          >> configs/debian_defconfig
++	echo CONFIG_DISKFORMAT_HANDLER=y  >> configs/debian_defconfig
++	echo CONFIG_FAT_FILESYSTEM=y      >> configs/debian_defconfig
++	echo CONFIG_EXT_FILESYSTEM=y      >> configs/debian_defconfig
 +endif
 +
  ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
  	echo CONFIG_PKCS11=y >> configs/debian_defconfig
  endif
 -- 
-2.30.2
+2.34.1
 
diff --git a/recipes-core/swupdate/files/0006-debian-rules-Add-option-to-disable-webserver.patch b/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
similarity index 85%
rename from recipes-core/swupdate/files/0006-debian-rules-Add-option-to-disable-webserver.patch
rename to recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
index 23a456d..66e48e6 100644
--- a/recipes-core/swupdate/files/0006-debian-rules-Add-option-to-disable-webserver.patch
+++ b/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
@@ -1,7 +1,7 @@
-From 9caabe416aca7ca2bf1cd2d8be89cfc89cedf6cd Mon Sep 17 00:00:00 2001
+From c1f46ecb2ac3aed3a711dec767321afa92b600d8 Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Mon, 4 Oct 2021 17:27:11 +0200
-Subject: [PATCH 6/9] debian/rules: Add option to disable webserver
+Subject: [PATCH 4/7] debian/rules: Add option to disable webserver
 
 Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 ---
@@ -10,7 +10,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
  2 files changed, 4 insertions(+), 2 deletions(-)
 
 diff --git a/debian/configs/defconfig b/debian/configs/defconfig
-index d011deb..337fcce 100644
+index d011deb1..337fcce0 100644
 --- a/debian/configs/defconfig
 +++ b/debian/configs/defconfig
 @@ -6,8 +6,6 @@ CONFIG_SIGALG_CMS=y
@@ -23,7 +23,7 @@ index d011deb..337fcce 100644
  CONFIG_UNIQUEUUID=y
  CONFIG_RAW=y
 diff --git a/debian/rules b/debian/rules
-index 9349c22..4574b18 100755
+index 983e122f..6078ed89 100755
 --- a/debian/rules
 +++ b/debian/rules
 @@ -39,6 +39,10 @@ else ifneq (,$(filter pkg.swupdate.efibootguard,$(DEB_BUILD_PROFILES)))
@@ -38,5 +38,5 @@ index 9349c22..4574b18 100755
  	echo CONFIG_SIGNED_IMAGES=y >> configs/debian_defconfig
  endif
 -- 
-2.30.2
+2.34.1
 
diff --git a/recipes-core/swupdate/files/0007-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch b/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
similarity index 85%
rename from recipes-core/swupdate/files/0007-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
rename to recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
index c2d37a9..4cca3bf 100644
--- a/recipes-core/swupdate/files/0007-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
+++ b/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
@@ -1,7 +1,7 @@
-From 538e54a36b24eb6caf49d7dca91598fa9fc86713 Mon Sep 17 00:00:00 2001
+From ccc6f5d04aba0f1270f7d6b6de298b2084ad3bfd Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Tue, 5 Oct 2021 10:56:25 +0200
-Subject: [PATCH 7/9] debian: Make CONFIG_HW_COMPATIBILTY optional
+Subject: [PATCH 5/7] debian: Make CONFIG_HW_COMPATIBILTY optional
 
 Add option for qemu.
 
@@ -12,7 +12,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
  2 files changed, 3 insertions(+), 1 deletion(-)
 
 diff --git a/debian/configs/defconfig b/debian/configs/defconfig
-index 337fcce..6fc1137 100644
+index 337fcce0..6fc1137f 100644
 --- a/debian/configs/defconfig
 +++ b/debian/configs/defconfig
 @@ -1,5 +1,4 @@
@@ -22,7 +22,7 @@ index 337fcce..6fc1137 100644
  CONFIG_DOWNLOAD_SSL=y
  CONFIG_SIGALG_CMS=y
 diff --git a/debian/rules b/debian/rules
-index 4574b18..9a4b0d4 100755
+index 6078ed89..19870e98 100755
 --- a/debian/rules
 +++ b/debian/rules
 @@ -39,6 +39,9 @@ else ifneq (,$(filter pkg.swupdate.efibootguard,$(DEB_BUILD_PROFILES)))
@@ -36,5 +36,5 @@ index 4574b18..9a4b0d4 100755
  	echo CONFIG_WEBSERVER=y   >> configs/debian_defconfig
  	echo CONFIG_MONGOOSESSL=y >> configs/debian_defconfig
 -- 
-2.30.2
+2.34.1
 
diff --git a/recipes-core/swupdate/files/0008-debian-rules-Add-Embedded-Lua-handler-option.patch b/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
similarity index 83%
rename from recipes-core/swupdate/files/0008-debian-rules-Add-Embedded-Lua-handler-option.patch
rename to recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
index 44a83c4..447f6ad 100644
--- a/recipes-core/swupdate/files/0008-debian-rules-Add-Embedded-Lua-handler-option.patch
+++ b/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
@@ -1,7 +1,7 @@
-From c2f07b552c6d83562fed5452bc778ae0e5e19cd4 Mon Sep 17 00:00:00 2001
+From 7107052e6aa1a35a2900070797ac013d49814f0b Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Wed, 29 Sep 2021 11:32:41 +0200
-Subject: [PATCH 8/9] debian/rules: Add Embedded Lua handler option
+Subject: [PATCH 6/7] debian/rules: Add Embedded Lua handler option
 
 Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 ---
@@ -9,10 +9,10 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
  1 file changed, 5 insertions(+)
 
 diff --git a/debian/rules b/debian/rules
-index 9a4b0d4..a1f73fd 100755
+index 19870e98..12eb0ba5 100755
 --- a/debian/rules
 +++ b/debian/rules
-@@ -66,7 +66,12 @@ ifneq (,$(LUA_VERSION))
+@@ -68,7 +68,12 @@ ifneq (,$(LUA_VERSION))
  	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
  	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
  	echo CONFIG_HANDLER_IN_LUA=y             >> configs/debian_defconfig
@@ -26,5 +26,5 @@ index 9a4b0d4..a1f73fd 100755
  	echo CONFIG_EXTRA_LDFLAGS=\"$(LDFLAGS)\"           >> configs/debian_defconfig
  	echo CONFIG_EXTRA_LDLIBS=\"$(LDLIBS)\"             >> configs/debian_defconfig
 -- 
-2.30.2
+2.34.1
 
diff --git a/recipes-core/swupdate/files/0009-debian-prepare-build-for-isar-debian-buster.patch b/recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debian-buster.patch
similarity index 84%
rename from recipes-core/swupdate/files/0009-debian-prepare-build-for-isar-debian-buster.patch
rename to recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debian-buster.patch
index 8462951..3ff4ca9 100644
--- a/recipes-core/swupdate/files/0009-debian-prepare-build-for-isar-debian-buster.patch
+++ b/recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debian-buster.patch
@@ -1,7 +1,7 @@
-From 16dd48c2282aba91f8fc1f458f7b0c06504cac19 Mon Sep 17 00:00:00 2001
+From 123190b2aa72818186ba12a04d793ff7d4244828 Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Wed, 29 Sep 2021 16:17:03 +0200
-Subject: [PATCH 9/9] debian: prepare build for isar debian buster
+Subject: [PATCH 7/7] debian: prepare build for isar debian buster
 
 Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 ---
@@ -13,23 +13,23 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 
 diff --git a/debian/compat b/debian/compat
 new file mode 100644
-index 0000000..f599e28
+index 00000000..f599e28b
 --- /dev/null
 +++ b/debian/compat
 @@ -0,0 +1 @@
 +10
 diff --git a/debian/control b/debian/control
-index 6031537..710cb2d 100644
+index 192c4a2a..9318fa12 100644
 --- a/debian/control
 +++ b/debian/control
 @@ -4,7 +4,7 @@ Priority: optional
- Maintainer: Stefano Babic <sbabic@denx.de>
+ Maintainer: Bastian Germann <bage@debian.org>
  Uploaders: SZ Lin (林上智) <szlin@debian.org>,
             Nobuhiro Iwamatsu <iwamatsu@debian.org>
 -Build-Depends: debhelper-compat (= 13),
 +Build-Depends: debhelper,
                 dh-lua:native <!nolua>,
-                liblua5.2-dev <!nolua>,
+                liblua5.3-dev <!nolua>,
                 libfdisk-dev,
 @@ -23,10 +23,10 @@ Build-Depends: debhelper-compat (= 13),
                 libzstd-dev,
@@ -44,10 +44,10 @@ index 6031537..710cb2d 100644
 +               libwebsockets-dev,
 +               liburiparser-dev,
                 libubootenv-dev <pkg.swupdate.uboot>,
-                efibootguard-dev <pkg.swupdate.efibootguard>,
+                libebgenv-dev <pkg.swupdate.efibootguard> | efibootguard-dev <pkg.swupdate.efibootguard>,
                 libcmocka-dev,
 diff --git a/debian/rules b/debian/rules
-index a1f73fd..a2ae1ac 100755
+index 12eb0ba5..e1c4a921 100755
 --- a/debian/rules
 +++ b/debian/rules
 @@ -19,13 +19,15 @@ endif
@@ -68,5 +68,5 @@ index a1f73fd..a2ae1ac 100755
  	echo "# CONFIG_MTD is not set"     >> configs/debian_defconfig
  endif
 -- 
-2.30.2
+2.34.1
 
diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
similarity index 68%
rename from recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
rename to recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
index e25ee4c..48a6cc1 100644
--- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
@@ -13,20 +13,15 @@ inherit dpkg-gbp
 include swupdate.inc
 
 SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master"
-SRCREV ="debian/2021.04-1"
+SRCREV ="debian/2021.11-1"
 
 # add options to DEB_BUILD_PROFILES
-SRC_URI += "file://0001-debian-Add-option-to-build-with-efibootguard.patch \
+SRC_URI += "file://0001-debian-config-Make-image-encryption-optional.patch \
             file://0002-debian-rules-Add-CONFIG_MTD.patch \
-            file://0003-debian-config-Make-signing-optional.patch \
-            file://0004-debian-config-Make-image-encryption-optional.patch \
-            file://0005-debian-rules-Add-option-to-disable-fs-creation.patch \
-            file://0006-debian-rules-Add-option-to-disable-webserver.patch \
-            file://0007-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch \
-            file://0008-debian-rules-Add-Embedded-Lua-handler-option.patch"
-
-# Patch for dm-verity based images - can be removed with next SWUpdate release
-SRC_URI += "file://0001-debian-patches-add-patches-for-dm-verity.patch"
+            file://0003-debian-rules-Add-option-to-disable-fs-creation.patch \
+            file://0004-debian-rules-Add-option-to-disable-webserver.patch \
+            file://0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch \
+            file://0006-debian-rules-Add-Embedded-Lua-handler-option.patch"
 
 # end patching for dm-verity based images
 
@@ -42,7 +37,7 @@ SWUPDATE_BUILD_PROFILES += "cross nocheck"
 # SWUPDATE_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
 
 # modify for debian buster build
-SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
+SRC_URI_append_buster = " file://0007-debian-prepare-build-for-isar-debian-buster.patch"
 
 # disable documentation due to missing packages
 SWUPDATE_BUILD_PROFILES_append = " nodoc "
-- 
2.34.1


