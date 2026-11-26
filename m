Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13695.1795699453344295143
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 05:24:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=badrikesh.prusty@siemens.com header.s=fm1 header.b=SqExA92e;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1328765-20261126132409fb7650a11b00020762-pmemrj@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20261126132409fb7650a11b00020762
        for <cip-dev@lists.cip-project.org>;
        Thu, 26 Nov 2026 14:24:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=badrikesh.prusty@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=sPoeiiTEnatlpPjM8r6Re5N5P5bxhXrkkSg/xCTeivc=;
 b=SqExA92evMoOsAeZG4ylOwLaVYYxSfd2B1B//u8CABEbDG10F0zYDWutdq/vLyFZefOIYs
 C74hiHtfhIxMZTjcafF3X/JjBBIoeKlzFy21IO4KQu9PrU5MuolEe09bcROrIlNTtecEp6np
 M13PVwbbvI1QDNZgIMgjDvuuWfb0/g7WSAaresoj2LbJrF76vm0Cmxx3Y+B76euJTkPBFNnd
 8Qm6thZZ/qNPpSnY5lHZFduUT/MaBN/aomvnutdy1PE35MVX7VcIgnl/PcXVOim/PStwVSgH
 XYqDMHtan9kfhT5o4ys5UcCDuoXLOx54ypU9TBdUndAMJZIgrI1F/Epw==;
From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Badrikesh Prusty <badrikesh.prusty@siemens.com>
Subject: [isar-cip-core][RFC][PATCH] swupdate: deploy SWU_ROOTFS_TYPE artifact alongside swu
Date: Thu, 26 Nov 2026 08:23:40 -0500
Message-ID: <20261126132340.121225-1-badrikesh.prusty@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328765:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 13:24:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25105
Content-Type: text/plain; charset="utf-8"

In upstream Isar commit 63935232 ("image: remove unrequested
intermediate image types"), Isar began cleaning up intermediate image
types that are not explicitly listed in IMAGE_FSTYPES.

Previously, swupdate.inc added ${RO_ROOTFS_TYPE} to IMAGE_TYPEDEP:wic,
but only added "swu" to IMAGE_FSTYPES. With the upstream change, the
underlying rootfs artifact (such as .squashfs, .verity, or .erofs) was
treated as an unrequested intermediate dependency and removed from
DEPLOY_DIR_IMAGE once wic and swupdate completed.

However, delta update generation (in delta-update.bbclass) explicitly
expects ${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE} to be present in the deploy
directory to create binary deltas against previous release artifacts.
Explicitly append ${SWU_ROOTFS_TYPE} to IMAGE_FSTYPES in swupdate.inc so
the payload filesystem artifact is deployed and retained.

Reference: https://github.com/ilbers/isar/commit/63935232
Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
---
 recipes-core/images/swupdate.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 699c961..bbedbdd 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -22,7 +22,7 @@ python __anonymous() {
 include recipes-core/images/swupdate-${SWUPDATE_BOOTLOADER}.inc
 
 IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
-IMAGE_FSTYPES:append = " swu"
+IMAGE_FSTYPES:append = " swu ${SWU_ROOTFS_TYPE}"
 # input is already compressed
 SWU_COMPRESSION_TYPE = ""
 
-- 
2.43.0

