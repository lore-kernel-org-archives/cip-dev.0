Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C487C38161
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:07 +0000 (UTC)
Received: from mta-64-227.flowmailer.net (mta-64-227.flowmailer.net
 [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web12.3489.1649834203718853424
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=LFRS0GpI;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-20220413071641458befd0565cf5d5f8-ucwzoq@rts-flowmailer.siemens.com)
Received: by mta-64-227.flowmailer.net with ESMTPSA id
 20220413071641458befd0565cf5d5f8
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=pYYd3KVfhb3NbqQjxRW+m46pbpRHOjlE/YTA9S3iHkU=;
 b=LFRS0GpIXiloA3AWr5egM86W6iTfrU8jwRU6Nk7gnRtteF9OlQjEnEPGifTGKTwDl4x3QO
 3QVnyUP1VZfK3F+FOlxktolLaevgd5CeT8Fulv3aE2YWIKIri+n5N6w5S/cX6JywJJxQRpRL
 uVsgbAP3j8vtJXV7KkiIpJZmZcLAw=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 13/19] swupdate: Add patch to fix EBG
 bootloader_env_get
Date: Wed, 13 Apr 2022 09:16:30 +0200
Message-Id: 
 <958c2c379e58a62919aecf825c431dbac2882d96.1649834193.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1649834193.git.jan.kiszka@siemens.com>
References: <cover.1649834193.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8068

From: Jan Kiszka <jan.kiszka@siemens.com>

Will be required for using bootenv_rrmap with the roundrobin handler.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...onfig-Make-image-encryption-optional.patch |  8 +--
 .../0002-debian-rules-Add-CONFIG_MTD.patch    |  6 +-
 ...es-Add-option-to-disable-fs-creation.patch |  8 +--
 ...ules-Add-option-to-disable-webserver.patch |  8 +--
 ...Make-CONFIG_HW_COMPATIBILTY-optional.patch |  8 +--
 ...ules-Add-Embedded-Lua-handler-option.patch |  6 +-
 ...-SWUpdate-USB-service-and-Udev-rules.patch | 10 +--
 ...option-to-disable-CONFIG_HASH_VERIFY.patch |  6 +-
 ...ch-to-fix-bootloader_env_get-for-EBG.patch | 66 +++++++++++++++++++
 ...repare-build-for-isar-debian-buster.patch} | 10 +--
 .../swupdate/swupdate_2021.11-1+debian-gbp.bb |  5 +-
 11 files changed, 104 insertions(+), 37 deletions(-)
 create mode 100644 recipes-core/swupdate/files/0009-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch
 rename recipes-core/swupdate/files/{0009-debian-prepare-build-for-isar-debian-buster.patch => 0010-debian-prepare-build-for-isar-debian-buster.patch} (92%)

diff --git a/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch b/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
index c501e42..aa20ab6 100644
--- a/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
+++ b/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
@@ -1,7 +1,7 @@
-From 20bb45563fe8f3ec95ef22d715d1add014156543 Mon Sep 17 00:00:00 2001
+From 5d78de76eab1218494c714e9816152e4d821fa86 Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Wed, 29 Sep 2021 15:28:21 +0200
-Subject: [PATCH 1/9] debian/config: Make image encryption optional
+Subject: [PATCH 01/10] debian/config: Make image encryption optional
 
 This can be use to ease the setup with SWUpdate.
 
@@ -12,7 +12,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
  2 files changed, 3 insertions(+), 1 deletion(-)
 
 diff --git a/debian/configs/defconfig b/debian/configs/defconfig
-index 02681e53..b34168e3 100644
+index 02681e5..b34168e 100644
 --- a/debian/configs/defconfig
 +++ b/debian/configs/defconfig
 @@ -3,7 +3,6 @@ CONFIG_HW_COMPATIBILITY=y
@@ -24,7 +24,7 @@ index 02681e53..b34168e3 100644
  CONFIG_SURICATTA_SSL=y
  CONFIG_UPDATE_STATE_CHOICE_BOOTLOADER=y
 diff --git a/debian/rules b/debian/rules
-index 864add23..08b74a1d 100755
+index 864add2..08b74a1 100755
 --- a/debian/rules
 +++ b/debian/rules
 @@ -41,6 +41,9 @@ endif
diff --git a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
index 50cf805..e62a4fc 100644
--- a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
+++ b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
@@ -1,7 +1,7 @@
-From 1d52fe25e72f9e33525bca7efa5efe901cb32c65 Mon Sep 17 00:00:00 2001
+From c3adc5d2be41e151c811c96f2bed245778fec82c Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Wed, 29 Sep 2021 11:29:57 +0200
-Subject: [PATCH 2/9] debian/rules: Add CONFIG_MTD
+Subject: [PATCH 02/10] debian/rules: Add CONFIG_MTD
 
 if pkg.swupdate.bpo is set CONFIG_MTD is disable but not enabled.
 
@@ -11,7 +11,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/debian/rules b/debian/rules
-index 08b74a1d..6705140b 100755
+index 08b74a1..6705140 100755
 --- a/debian/rules
 +++ b/debian/rules
 @@ -20,6 +20,7 @@ endif
diff --git a/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch b/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
index c5815cb..08ba9b9 100644
--- a/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
+++ b/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
@@ -1,7 +1,7 @@
-From 8b6f01b6126933723963497d0db0c256e5251c5b Mon Sep 17 00:00:00 2001
+From 17d962a9b43f5debaed85affc6dccb2c471bffe9 Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Mon, 4 Oct 2021 17:15:56 +0200
-Subject: [PATCH 3/9] debian/rules: Add option to disable fs creation
+Subject: [PATCH 03/10] debian/rules: Add option to disable fs creation
 
 Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 ---
@@ -10,7 +10,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
  2 files changed, 9 insertions(+), 6 deletions(-)
 
 diff --git a/debian/configs/defconfig b/debian/configs/defconfig
-index b34168e3..d011deb1 100644
+index b34168e..d011deb 100644
 --- a/debian/configs/defconfig
 +++ b/debian/configs/defconfig
 @@ -9,12 +9,6 @@ CONFIG_UPDATE_STATE_CHOICE_BOOTLOADER=y
@@ -27,7 +27,7 @@ index b34168e3..d011deb1 100644
  CONFIG_RAW=y
  CONFIG_RDIFFHANDLER=y
 diff --git a/debian/rules b/debian/rules
-index 6705140b..983e122f 100755
+index 6705140..983e122 100755
 --- a/debian/rules
 +++ b/debian/rules
 @@ -45,6 +45,15 @@ endif
diff --git a/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch b/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
index 4a9076d..eaa6fcf 100644
--- a/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
+++ b/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
@@ -1,7 +1,7 @@
-From c1f46ecb2ac3aed3a711dec767321afa92b600d8 Mon Sep 17 00:00:00 2001
+From a02a6d4385f314601ef5c7094ecb26f5b5c3f134 Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Mon, 4 Oct 2021 17:27:11 +0200
-Subject: [PATCH 4/9] debian/rules: Add option to disable webserver
+Subject: [PATCH 04/10] debian/rules: Add option to disable webserver
 
 Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 ---
@@ -10,7 +10,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
  2 files changed, 4 insertions(+), 2 deletions(-)
 
 diff --git a/debian/configs/defconfig b/debian/configs/defconfig
-index d011deb1..337fcce0 100644
+index d011deb..337fcce 100644
 --- a/debian/configs/defconfig
 +++ b/debian/configs/defconfig
 @@ -6,8 +6,6 @@ CONFIG_SIGALG_CMS=y
@@ -23,7 +23,7 @@ index d011deb1..337fcce0 100644
  CONFIG_UNIQUEUUID=y
  CONFIG_RAW=y
 diff --git a/debian/rules b/debian/rules
-index 983e122f..6078ed89 100755
+index 983e122..6078ed8 100755
 --- a/debian/rules
 +++ b/debian/rules
 @@ -39,6 +39,10 @@ else ifneq (,$(filter pkg.swupdate.efibootguard,$(DEB_BUILD_PROFILES)))
diff --git a/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch b/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
index 87eba2c..eb19e5f 100644
--- a/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
+++ b/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
@@ -1,7 +1,7 @@
-From ccc6f5d04aba0f1270f7d6b6de298b2084ad3bfd Mon Sep 17 00:00:00 2001
+From 8315d5ff8168fca1bd3752764e71f98e8b55f2ad Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Tue, 5 Oct 2021 10:56:25 +0200
-Subject: [PATCH 5/9] debian: Make CONFIG_HW_COMPATIBILTY optional
+Subject: [PATCH 05/10] debian: Make CONFIG_HW_COMPATIBILTY optional
 
 Add option for qemu.
 
@@ -12,7 +12,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
  2 files changed, 3 insertions(+), 1 deletion(-)
 
 diff --git a/debian/configs/defconfig b/debian/configs/defconfig
-index 337fcce0..6fc1137f 100644
+index 337fcce..6fc1137 100644
 --- a/debian/configs/defconfig
 +++ b/debian/configs/defconfig
 @@ -1,5 +1,4 @@
@@ -22,7 +22,7 @@ index 337fcce0..6fc1137f 100644
  CONFIG_DOWNLOAD_SSL=y
  CONFIG_SIGALG_CMS=y
 diff --git a/debian/rules b/debian/rules
-index 6078ed89..19870e98 100755
+index 6078ed8..19870e9 100755
 --- a/debian/rules
 +++ b/debian/rules
 @@ -39,6 +39,9 @@ else ifneq (,$(filter pkg.swupdate.efibootguard,$(DEB_BUILD_PROFILES)))
diff --git a/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch b/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
index 5d7543b..1d6a247 100644
--- a/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
+++ b/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
@@ -1,7 +1,7 @@
-From 7107052e6aa1a35a2900070797ac013d49814f0b Mon Sep 17 00:00:00 2001
+From 19969a388e414db84e54a706e9227c301b0408a2 Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Wed, 29 Sep 2021 11:32:41 +0200
-Subject: [PATCH 6/9] debian/rules: Add Embedded Lua handler option
+Subject: [PATCH 06/10] debian/rules: Add Embedded Lua handler option
 
 Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 ---
@@ -9,7 +9,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
  1 file changed, 5 insertions(+)
 
 diff --git a/debian/rules b/debian/rules
-index 19870e98..12eb0ba5 100755
+index 19870e9..12eb0ba 100755
 --- a/debian/rules
 +++ b/debian/rules
 @@ -68,7 +68,12 @@ ifneq (,$(LUA_VERSION))
diff --git a/recipes-core/swupdate/files/0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch b/recipes-core/swupdate/files/0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
index 2779d8b..90c8d98 100644
--- a/recipes-core/swupdate/files/0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
+++ b/recipes-core/swupdate/files/0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
@@ -1,7 +1,7 @@
-From 625db939a1dec7d1aa6fbcb01c2c4cbd699bfe7b Mon Sep 17 00:00:00 2001
+From db391d1dd34806ae6694205b08b4661318bef37b Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Mon, 7 Feb 2022 09:28:39 +0100
-Subject: [PATCH 7/9] debian: Remove SWUpdate USB service and Udev rules
+Subject: [PATCH 07/10] debian: Remove SWUpdate USB service and Udev rules
 
 The current implementation will install an abitrary SWUpdate binary
 from a plug-in USB stick. This is a major security risk for devices
@@ -19,7 +19,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
  delete mode 100644 debian/swupdate.udev
 
 diff --git a/debian/rules b/debian/rules
-index 12eb0ba5..76fce010 100755
+index 12eb0ba..76fce01 100755
 --- a/debian/rules
 +++ b/debian/rules
 @@ -101,7 +101,6 @@ override_dh_auto_install:
@@ -32,7 +32,7 @@ index 12eb0ba5..76fce010 100755
  override_dh_gencontrol:
 diff --git a/debian/swupdate.swupdate-usb@.service b/debian/swupdate.swupdate-usb@.service
 deleted file mode 100644
-index eda9d153..00000000
+index eda9d15..0000000
 --- a/debian/swupdate.swupdate-usb@.service
 +++ /dev/null
 @@ -1,8 +0,0 @@
@@ -46,7 +46,7 @@ index eda9d153..00000000
 -ExecStopPost=/bin/umount /mnt
 diff --git a/debian/swupdate.udev b/debian/swupdate.udev
 deleted file mode 100644
-index b4efd0b7..00000000
+index b4efd0b..0000000
 --- a/debian/swupdate.udev
 +++ /dev/null
 @@ -1,2 +0,0 @@
diff --git a/recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch b/recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch
index a7c5ee7..a5207ee 100644
--- a/recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch
+++ b/recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch
@@ -1,7 +1,7 @@
-From cddd3472aad2d8e48d557705b82ffcc0c7d14a02 Mon Sep 17 00:00:00 2001
+From 2776a4817eb91be3df001e04d548a702e9f5291a Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Mon, 14 Feb 2022 12:27:43 +0100
-Subject: [PATCH 8/9] Add Profile option to disable CONFIG_HASH_VERIFY
+Subject: [PATCH 08/10] Add Profile option to disable CONFIG_HASH_VERIFY
 
 This change also enables CONFIG_HASH_VERIFY by default.
 
@@ -11,7 +11,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/debian/rules b/debian/rules
-index 76fce010..4dc9e170 100755
+index 76fce01..4dc9e17 100755
 --- a/debian/rules
 +++ b/debian/rules
 @@ -42,6 +42,9 @@ endif
diff --git a/recipes-core/swupdate/files/0009-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch b/recipes-core/swupdate/files/0009-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch
new file mode 100644
index 0000000..fd263ee
--- /dev/null
+++ b/recipes-core/swupdate/files/0009-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch
@@ -0,0 +1,66 @@
+From 09a736a651ae05378d9ef8018589c9f834b729a6 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Tue, 12 Apr 2022 08:01:21 +0200
+Subject: [PATCH 09/10] debian: Add patch to fix bootloader_env_get for EBG
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ ...ix-do_env_get-for-anything-but-globa.patch | 38 +++++++++++++++++++
+ debian/patches/series                         |  1 +
+ 2 files changed, 39 insertions(+)
+ create mode 100644 debian/patches/0001-bootloader-EBG-fix-do_env_get-for-anything-but-globa.patch
+
+diff --git a/debian/patches/0001-bootloader-EBG-fix-do_env_get-for-anything-but-globa.patch b/debian/patches/0001-bootloader-EBG-fix-do_env_get-for-anything-but-globa.patch
+new file mode 100644
+index 0000000..f99f7ee
+--- /dev/null
++++ b/debian/patches/0001-bootloader-EBG-fix-do_env_get-for-anything-but-globa.patch
+@@ -0,0 +1,38 @@
++From 62cd7c93dc31e5ad8dccdd1db791892864fbbccf Mon Sep 17 00:00:00 2001
++From: Jan Kiszka <jan.kiszka@siemens.com>
++Date: Tue, 12 Apr 2022 07:49:14 +0200
++Subject: [PATCH] bootloader: EBG: fix do_env_get for anything but global state
++
++The return value conversion must only be applied on STATE_KEY. This
++fixes strangely broken strings for all other keys.
++
++Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
++---
++ bootloader/ebg.c | 4 ++--
++ 1 file changed, 2 insertions(+), 2 deletions(-)
++
++diff --git a/bootloader/ebg.c b/bootloader/ebg.c
++index 2aa9010..a0b45dc 100644
++--- a/bootloader/ebg.c
+++++ b/bootloader/ebg.c
++@@ -115,6 +115,8 @@ char *bootloader_env_get(const char *name)
++ 	if (strncmp(name, (char *)STATE_KEY, strlen((char *)STATE_KEY) + 1) == 0) {
++ 		value = (char *)malloc(sizeof(char));
++ 		*value = ebg_env_getglobalstate(&ebgenv);
+++		/* Map EFI Boot Guard's int return to update_state_t's char value */
+++		*value = *value + '0';
++ 	} else {
++ 		if ((size = ebg_env_get(&ebgenv, (char *)name, NULL)) != 0) {
++ 			value = malloc(size);
++@@ -133,8 +135,6 @@ char *bootloader_env_get(const char *name)
++ 		    name, strerror(errno));
++ 	}
++ 
++-	/* Map EFI Boot Guard's int return to update_state_t's char value */
++-	*value = *value + '0';
++ 	return value;
++ }
++ 
++-- 
++2.34.1
++
+diff --git a/debian/patches/series b/debian/patches/series
+index 8c5564a..98628a7 100644
+--- a/debian/patches/series
++++ b/debian/patches/series
+@@ -1 +1,2 @@
+ use-gcc-compiler.diff
++0001-bootloader-EBG-fix-do_env_get-for-anything-but-globa.patch
+-- 
+2.34.1
+
diff --git a/recipes-core/swupdate/files/0009-debian-prepare-build-for-isar-debian-buster.patch b/recipes-core/swupdate/files/0010-debian-prepare-build-for-isar-debian-buster.patch
similarity index 92%
rename from recipes-core/swupdate/files/0009-debian-prepare-build-for-isar-debian-buster.patch
rename to recipes-core/swupdate/files/0010-debian-prepare-build-for-isar-debian-buster.patch
index 8afef74..1d476e9 100644
--- a/recipes-core/swupdate/files/0009-debian-prepare-build-for-isar-debian-buster.patch
+++ b/recipes-core/swupdate/files/0010-debian-prepare-build-for-isar-debian-buster.patch
@@ -1,7 +1,7 @@
-From 5dda7f815dafdfbd1b187ccc912eca38e9aee7bb Mon Sep 17 00:00:00 2001
+From c9661853aea11f090b5936363b0bae10fe6ebed6 Mon Sep 17 00:00:00 2001
 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 Date: Wed, 29 Sep 2021 16:17:03 +0200
-Subject: [PATCH 9/9] debian: prepare build for isar debian buster
+Subject: [PATCH 10/10] debian: prepare build for isar debian buster
 
 Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 ---
@@ -13,13 +13,13 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
 
 diff --git a/debian/compat b/debian/compat
 new file mode 100644
-index 00000000..f599e28b
+index 0000000..f599e28
 --- /dev/null
 +++ b/debian/compat
 @@ -0,0 +1 @@
 +10
 diff --git a/debian/control b/debian/control
-index 192c4a2a..9318fa12 100644
+index 192c4a2..9318fa1 100644
 --- a/debian/control
 +++ b/debian/control
 @@ -4,7 +4,7 @@ Priority: optional
@@ -47,7 +47,7 @@ index 192c4a2a..9318fa12 100644
                 libebgenv-dev <pkg.swupdate.efibootguard> | efibootguard-dev <pkg.swupdate.efibootguard>,
                 libcmocka-dev,
 diff --git a/debian/rules b/debian/rules
-index 4dc9e170..370ca3d8 100755
+index 4dc9e17..370ca3d 100755
 --- a/debian/rules
 +++ b/debian/rules
 @@ -19,13 +19,15 @@ endif
diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
index bf060b4..7edefe7 100644
--- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
@@ -23,7 +23,8 @@ SRC_URI += "file://0001-debian-config-Make-image-encryption-optional.patch \
             file://0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch \
             file://0006-debian-rules-Add-Embedded-Lua-handler-option.patch \
             file://0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch \
-            file://0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch"
+            file://0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch \
+            file://0009-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch"
 
 # end patching for dm-verity based images
 
@@ -39,7 +40,7 @@ DEB_BUILD_PROFILES += "cross nocheck"
 # DEB_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
 
 # modify for debian buster build
-SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
+SRC_URI_append_buster = " file://0010-debian-prepare-build-for-isar-debian-buster.patch"
 
 # disable create filesystem due to missing symbols in debian buster
 # disable webserver due to missing symbols in debian buster
-- 
2.34.1


