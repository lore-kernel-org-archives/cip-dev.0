Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66BBE95A82
	for <webhook@archiver.kernel.org>; Sun,  8 Oct 2023 14:26:20 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.32144.1696734954816626362
 for <cip-dev@lists.cip-project.org>;
 Sat, 07 Oct 2023 20:15:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=bIHmFGiB;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-72506-20231008031552d2ec3397c9ff2e6ed4-dojltp@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20231008031552d2ec3397c9ff2e6ed4
        for <cip-dev@lists.cip-project.org>;
        Sun, 08 Oct 2023 05:15:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Ccosiq23TZXww94gb7twmr+34RI1272pUJ9z491JzOk=;
 b=bIHmFGiBEx0zpdeaVbjVK2+0S5Nzw8pvJt2Mw/lq3MrWVMd7t8ZzwHqqbtIHkwfWG7jwsj
 8j3Xdeos1SyNy3GE5hg0gpyEmWIenl/4FC6jWCH7Jk5YJrKAL9NAM/q0M+4aAG0VbiOAbNp3
 CAaDQ/cjqKUN6DNk+gbeEYKl2MVug=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 2/4] make swupdate class compatible with schroot imaging
Date: Sun,  8 Oct 2023 11:15:27 +0800
Message-Id: <20231008031529.1338834-3-felix.moessbauer@siemens.com>
In-Reply-To: <20231008031529.1338834-1-felix.moessbauer@siemens.com>
References: <20231008031529.1338834-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 08 Oct 2023 14:26:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13308

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/swupdate.bbclass | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index aedaf02..55dad32 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -106,7 +106,7 @@ IMAGE_CMD:swu() {
     # Prepare for signing
     export sign='${@'x' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}'
 
-    sudo -E chroot ${BUILDCHROOT_DIR} sh -c ' \
+    imager_run -p -d ${PP_WORK} <<'EOIMAGER'
         # Fill in file check sums
         for file in ${SWU_ADDITIONAL_FILES}; do
             sed -i "s:$file-sha256:$(sha256sum "${PP_WORK}/swu/"$file | cut -f 1 -d " "):g" \
@@ -138,7 +138,8 @@ IMAGE_CMD:swu() {
                 fi
                 echo "$file.${SWU_SIGNATURE_EXT}"
            fi
-        done | cpio -ovL --reproducible -H crc > "${SWU_BUILDCHROOT_IMAGE_FILE}"'
+        done | cpio -ovL --reproducible -H crc > "${SWU_BUILDCHROOT_IMAGE_FILE}"
+EOIMAGER
 }
 
 python do_check_swu_partition_uuids() {
-- 
2.39.2


