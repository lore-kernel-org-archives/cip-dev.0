Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC955D116F6
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 15:50:15 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.369.1764690605947071028
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 07:50:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=FruUGjgr;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1330684-20251202155003ae72fde9990002079c-cvlqaf@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251202155003ae72fde9990002079c
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 16:50:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=nJUux6uA0CqkMgjMeaP9riOMT9BcwVTTug3PW0Ae9hM=;
 b=FruUGjgr+467Vb3xUd0yqbBZ29U+3pSju1NfdV3Y8MN7G7vpbpLsrTKE0QdePxX9pXENls
 QOusHmvBCZ8QVZ/TsU32bqbVwnOUEVpEMZsamOfEQcMAcstTa5X2qJB5QzTMOeDaZBeqcRan
 m1V8DQAPKOYZttF+e3Y9g0IQ4PeF+tHnfyGTg5SpS5O+7wr/b6U98zV8Iu0cHRNbu8tjaoV9
 BOqzvdMRxVfpOCsfc5rH/DnbrciHyaHttiwC4EP3zJw/athdtcDBqo4bhZ2Aa1uyilZC4aLO
 hn3rhiX5DUnFCJ/3MwTWa/gGxH59NV/z+jNeNMNgMtoBAX9TPskYzyqA==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH] initramfs-vertiy-hook: Fixing log when verityroot device was not found initially.
Date: Tue,  2 Dec 2025 16:49:59 +0100
Message-ID: <20251202154959.784147-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 15:50:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20811

From: Alexander Heinisch <alexander.heinisch@siemens.com>

This seems to be a copy/paste error from abrootfs-hook introduced in 27f88e9a

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 .../initramfs-verity-hook/files/local-top-complete.tmpl         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl b/recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl
index db805c0..ba7bb7f 100644
--- a/recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl
+++ b/recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl
@@ -122,7 +122,7 @@ case "$ROOT" in
         partitions="$(blkid -o device)"
         find_root_via_image_uuid "$partitions"
         if [ -z "${found_root}" ]; then
-            log_begin_msg "Waiting for IMAGE_UUID=${TARGET_IMAGE_UUID}"
+            log_begin_msg "Waiting for disk with verity header UUID=${UUID}"
             scanned_partitions="${partitions}"
             wait_30sec_for_condition scan_for_partitions
         fi
-- 
2.47.3


