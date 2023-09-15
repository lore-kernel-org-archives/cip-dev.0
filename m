Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A47EEE642E
	for <webhook@archiver.kernel.org>; Fri, 15 Sep 2023 07:34:41 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.15800.1694763271478848349
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Sep 2023 00:34:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=APjwqMa/;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202309150734283bd6e7bd52b4a621d9-y_1j9w@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202309150734283bd6e7bd52b4a621d9
        for <cip-dev@lists.cip-project.org>;
        Fri, 15 Sep 2023 09:34:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=I9R6F/rQ7h20N+gHP/xiTRsWIfx3LGol4q9Ms/myNMk=;
 b=APjwqMa/wpErGbLsdtbYhEAqEHE9gxsdeDsT4/kgNfPsG6vQBBz692XqnGE30ceYSWrvn5
 aurqeOozufDr0vI/N2RQwpIMucV92XWTgWUI1m9scdEcwl3L3W26rl9XigrCw31lESNDRh/w
 7FvveFB2eE1A8pSFSHAL4uGWSIyd8=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2] classes/verity: Set salt and uuid for reproducible builds
Date: Fri, 15 Sep 2023 09:34:26 +0200
Message-Id: <20230915073426.1558460-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <7fce798e-8ac1-40f4-83c6-4fc4ccb9b304@siemens.com>
References: <7fce798e-8ac1-40f4-83c6-4fc4ccb9b304@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Sep 2023 07:34:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13138

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Currently veritysetup generates a random salt and uuid for the
verity file system. This leads to a changed root hash which makes
the verity image no longer reproducible and bootable.

This also fixes together with the option `kas/opt/reproducible.yml`
the issue that after a sstate build the image can no longer be
booted.

This introduces the following variables:
 - VERITY_IMAGE_SALT: set the verity salt the value of variable. If
   VERITY_IMAGE_SALT is not set the salt is derived from IMAGE_UUID
 - VERITY_IMAGE_UUID: set the verity UUID to the value of the variable.
   If VERITY_IMAGE_UUID is not set the UUID is set to the IMAGE_UUID

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Can we set the option in `kas/opt/reproducible.yml` as default or are
there still issues open?

This patch superseeds `[cip-dev][isar-cip-core][PATCH] initramfs-verity-hook:
Ensure sync on rebuild`[1].

[1]: https://lore.kernel.org/all/595d5791-a08d-f08f-5dee-6f9ed5d472e0@siemens.com/T/

 classes/verity.bbclass | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/classes/verity.bbclass b/classes/verity.bbclass
index 747a7ae..bacf592 100644
--- a/classes/verity.bbclass
+++ b/classes/verity.bbclass
@@ -19,6 +19,37 @@ VERITY_IMAGE_METADATA = "${VERITY_OUTPUT_IMAGE}.metadata"
 VERITY_HASH_BLOCK_SIZE ?= "1024"
 VERITY_DATA_BLOCK_SIZE ?= "1024"
 
+# Set the salt used to generate a verity image to a fixed value
+# if not set it is derived from TARGET_IMAGE_UUID
+VERITY_IMAGE_SALT ?= ""
+
+# Set the UUID used to generate a verity image to a fixed value
+# if not set it is set to TARGET_IMAGE_UUID
+VERITY_IMAGE_UUID ?= ""
+
+python derive_verity_salt_and_uuid() {
+    import hashlib
+
+    verity_salt = d.getVar("VERITY_IMAGE_SALT")
+    verity_uuid = d.getVar("VERITY_IMAGE_UUID")
+    target_uuid = d.getVar("TARGET_IMAGE_UUID")
+
+    if not verity_salt:
+        if target_uuid:
+            verity_salt = hashlib.sha256(target_uuid.encode()).hexdigest()
+        else:
+            bb.error("TARGET_IMAGE_UUID and VERITY_IMAGE_SALT are empty. Could not set VERITY_SALT.")
+
+    if not verity_uuid:
+        if target_uuid:
+            verity_uuid = target_uuid
+        else:
+            bb.error("TARGET_IMAGE_UUID and VERITY_IMAGE_UUID are empty. Could not set VERITY_UUID.")
+
+    d.setVar("VERITY_IMAGE_SALT_OPTION", "--salt=" + str(verity_salt))
+    d.setVar("VERITY_IMAGE_UUID_OPTION", "--uuid=" + str(verity_uuid))
+}
+
 create_verity_env_file() {
 
     local ENV="${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.verity.env"
@@ -49,8 +80,9 @@ python calculate_verity_data_blocks() {
     d.setVar("VERITY_DATA_BLOCKS", str(size // data_block_size))
 }
 
+do_image_verity[vardeps] += "VERITY_IMAGE_UUID VERITY_IMAGE_SALT"
 do_image_verity[cleandirs] = "${WORKDIR}/verity"
-do_image_verity[prefuncs] = "calculate_verity_data_blocks"
+do_image_verity[prefuncs] = "calculate_verity_data_blocks derive_verity_salt_and_uuid"
 IMAGE_CMD:verity() {
     rm -f ${DEPLOY_DIR_IMAGE}/${VERITY_OUTPUT_IMAGE}
     rm -f ${WORKDIR}/${VERITY_IMAGE_METADATA}
@@ -62,6 +94,8 @@ IMAGE_CMD:verity() {
         --data-block-size "${VERITY_DATA_BLOCK_SIZE}"  \
         --data-blocks "${VERITY_DATA_BLOCKS}" \
         --hash-offset "${VERITY_INPUT_IMAGE_SIZE}" \
+        "${VERITY_IMAGE_SALT_OPTION}" \
+        "${VERITY_IMAGE_UUID_OPTION}" \
         "${PP_DEPLOY}/${VERITY_OUTPUT_IMAGE}" \
         "${PP_DEPLOY}/${VERITY_OUTPUT_IMAGE}" \
         >"${WORKDIR}/${VERITY_IMAGE_METADATA}"
@@ -70,3 +104,4 @@ IMAGE_CMD:verity() {
         >>"${WORKDIR}/${VERITY_IMAGE_METADATA}"
     create_verity_env_file
 }
+addtask do_image_verity after do_generate_image_uuid
-- 
2.40.1


