Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FEBEEAA63
	for <webhook@archiver.kernel.org>; Thu, 14 Sep 2023 18:51:12 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.2750.1694717467820873865
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Sep 2023 11:51:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=B51wTd1v;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-2023091418510324e3457bb7f2c71e0b-be_9rs@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023091418510324e3457bb7f2c71e0b
        for <cip-dev@lists.cip-project.org>;
        Thu, 14 Sep 2023 20:51:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=GGuga2VdOyJHOgEa3eiowO5/Y/yhwpXq4CFCE9fzcCw=;
 b=B51wTd1vs+3sakdCp4a4+I5i7Wq/A2mO6YUZP9QuzGiiSgrJBcpE0LZJXwpVYEyrLrwXR7
 Dzo+ylv8q9TnbtjIILEd+w8vOjDE7E7vgUKio8ciTf1XO+SUUNTAWtcgANHDFYPiJMSrlYnu
 WBxqrsNZl/tAX3G6K5L2c7iq2ZpPE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	adriaan.schmidt@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 1/1] classes/verity: Set salt and uuid for reproducible builds
Date: Thu, 14 Sep 2023 20:51:02 +0200
Message-Id: <20230914185102.1451907-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Sep 2023 18:51:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13133

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Currently veritysetup generates a random salt and uuid for the
verity file system. This leads to a changed root hash which makes
the verity image no longer reproducible and bootable.

This also fixes together with the option `kas/opt/reproducible.yml`
the issue that after a sstate build the image can no longer be
booted.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Can we set the option in `kas/opt/reproducible.yml` as default or are
there still issues open?

This patch superseeds `[cip-dev][isar-cip-core][PATCH] initramfs-verity-hook:
Ensure sync on rebuild`[1].

[1]: https://lore.kernel.org/all/595d5791-a08d-f08f-5dee-6f9ed5d472e0@siemens.com/T/



 classes/verity.bbclass | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/classes/verity.bbclass b/classes/verity.bbclass
index 747a7ae..2cfeb28 100644
--- a/classes/verity.bbclass
+++ b/classes/verity.bbclass
@@ -18,6 +18,34 @@ VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.verity"
 VERITY_IMAGE_METADATA = "${VERITY_OUTPUT_IMAGE}.metadata"
 VERITY_HASH_BLOCK_SIZE ?= "1024"
 VERITY_DATA_BLOCK_SIZE ?= "1024"
+VERITY_IMAGE_SALT ?= ""
+VERITY_IMAGE_UUID ?= ""
+VERITY_IMAGE_SEED ?= ""
+# TODO split if working
+python derive_verity_salt_and_uuid() {
+    import hashlib
+    seed = d.getVar("VERITY_IMAGE_SEED")
+    verity_salt = d.getVar("VERITY_IMAGE_SALT")
+    verity_uuid = d.getVar("VERITY_IMAGE_UUID")
+    target_uuid = d.getVar("TARGET_IMAGE_UUID")
+
+    if not verity_salt:
+        if seed:
+            verity_salt = hashlib.sha256(seed.encode()).hexdigest()
+        elif target_uuid:
+            verity_salt = hashlib.sha256(target_uuid.encode()).hexdigest()
+        else:
+            bb.error("TARGET_IMAGE_UUID and VERITY_IMAGE_SEED are empty. Could not derive verity_salt.")
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
 
 create_verity_env_file() {
 
@@ -49,8 +77,9 @@ python calculate_verity_data_blocks() {
     d.setVar("VERITY_DATA_BLOCKS", str(size // data_block_size))
 }
 
+do_image_verity[vardeps] += "VERITY_IMAGE_UUID VERITY_IMAGE_SALT"
 do_image_verity[cleandirs] = "${WORKDIR}/verity"
-do_image_verity[prefuncs] = "calculate_verity_data_blocks"
+do_image_verity[prefuncs] = "calculate_verity_data_blocks derive_verity_salt_and_uuid"
 IMAGE_CMD:verity() {
     rm -f ${DEPLOY_DIR_IMAGE}/${VERITY_OUTPUT_IMAGE}
     rm -f ${WORKDIR}/${VERITY_IMAGE_METADATA}
@@ -62,6 +91,8 @@ IMAGE_CMD:verity() {
         --data-block-size "${VERITY_DATA_BLOCK_SIZE}"  \
         --data-blocks "${VERITY_DATA_BLOCKS}" \
         --hash-offset "${VERITY_INPUT_IMAGE_SIZE}" \
+        "${VERITY_IMAGE_SALT_OPTION}" \
+        "${VERITY_IMAGE_UUID_OPTION}" \
         "${PP_DEPLOY}/${VERITY_OUTPUT_IMAGE}" \
         "${PP_DEPLOY}/${VERITY_OUTPUT_IMAGE}" \
         >"${WORKDIR}/${VERITY_IMAGE_METADATA}"
@@ -70,3 +101,4 @@ IMAGE_CMD:verity() {
         >>"${WORKDIR}/${VERITY_IMAGE_METADATA}"
     create_verity_env_file
 }
+addtask do_image_verity after do_generate_image_uuid
-- 
2.40.1


