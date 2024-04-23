Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7ADC3271E
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 15:32:18 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.82815.1720452728184509705
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jul 2024 08:32:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm2 header.b=NdKVyJt1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1324425-202407081532047bec9be7a00971c974-o97cev@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202407081532047bec9be7a00971c974
        for <cip-dev@lists.cip-project.org>;
        Mon, 08 Jul 2024 17:32:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=BD1awoNsRL2bcoH/HM3CJF5cQXFd0KvXjmbY6DixmA4=;
 b=NdKVyJt1EcsDY1n28uqjSE1kTw6X6qTjzAWX64gQ5EepHn0W0KDIjvOxpB5To1HoTiEG5f
 PlWCIO8g3uWFfigww4TRksbgidoi8YXzxOTUbgEhXRd9f0Q2KuD2O8+aDC1orru3uDA6EZkp
 N43x5XT6KB1JZwnNRwAsJlgaNuuxc=;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] classes, recipes-initramfs: remove do prefix for adding task
Date: Tue, 23 Apr 2024 21:05:32 +0530
Message-Id: <20240423153532.175546-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jul 2024 15:32:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16436

From: Srinuvasan A <srinuvasan.a@siemens.com>

Try to follow the same pattern as bitbake recommended to add the task
using addtask directive, only we corrected the style apart from there is no functional changes.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 classes/delta-update.bbclass                                  | 2 +-
 classes/deploy-firmware.bbclass                               | 4 ++--
 classes/swupdate.bbclass                                      | 2 +-
 classes/verity.bbclass                                        | 4 ++--
 .../initramfs-verity-hook/initramfs-verity-hook_0.1.bb        | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/classes/delta-update.bbclass b/classes/delta-update.bbclass
index c2df266..ae2453d 100644
--- a/classes/delta-update.bbclass
+++ b/classes/delta-update.bbclass
@@ -96,4 +96,4 @@ IMAGE_CMD:delta_update() {
     esac
 }
 
-addtask do_image_delta_update before do_image_swu after do_image_wic
+addtask image_delta_update before do_image_swu after do_image_wic
diff --git a/classes/deploy-firmware.bbclass b/classes/deploy-firmware.bbclass
index a4b754a..aad7277 100644
--- a/classes/deploy-firmware.bbclass
+++ b/classes/deploy-firmware.bbclass
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2023
+# Copyright (c) Siemens AG, 2024
 #
 # Authors:
 #  Felix Moessbauer <felix.moessbauer@siemens.com>
@@ -27,6 +27,6 @@ do_deploy_firmware() {
 python do_deploy_firmware_setscene () {
     sstate_setscene(d)
 }
-addtask do_deploy_firmware_setscene
+addtask deploy_firmware_setscene
 
 addtask deploy_firmware after do_dpkg_build before do_deploy_deb
diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index e91238d..0fd6329 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -71,7 +71,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
     "
 
 # TARGET_IMAGE_UUID needs to be generated before completing the template
-addtask do_transform_template after do_generate_image_uuid
+addtask transform_template after do_generate_image_uuid
 
 python do_extend_sw_description() {
     cmds = d.getVar("SWU_EXTEND_SW_DESCRIPTION")
diff --git a/classes/verity.bbclass b/classes/verity.bbclass
index 9030c84..93dcd31 100644
--- a/classes/verity.bbclass
+++ b/classes/verity.bbclass
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021-2022
+# Copyright (c) Siemens AG, 2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -104,4 +104,4 @@ IMAGE_CMD:verity() {
         >>"${WORKDIR}/${VERITY_IMAGE_METADATA}"
     create_verity_env_file
 }
-addtask do_image_verity after do_generate_image_uuid
+addtask image_verity after do_generate_image_uuid
diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
index 3fc63ed..526a8d6 100644
--- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -53,4 +53,4 @@ do_install() {
         "${D}/usr/share/initramfs-tools/hooks/verity"
 }
 
-addtask do_install after do_transform_template
+addtask install after do_transform_template
-- 
2.34.1


