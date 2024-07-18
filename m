Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BE5C3DA49
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 06:25:28 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.9328.1721283919274618513
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jul 2024 23:25:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm2 header.b=Pu8DuT3q;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1324425-2024071806251509bd6d7b7046eadfe1-l4bzpz@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024071806251509bd6d7b7046eadfe1
        for <cip-dev@lists.cip-project.org>;
        Thu, 18 Jul 2024 08:25:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=nWmGXBfXM9ci3/W6+XY/lncr5WSSDYmjHzbVTMccPys=;
 b=Pu8DuT3qqjlZBm/5N1hhv7EF/iRCctTNQ0yhO3m6Ia1SiT2s3i1RouHMBKlQHDmJ07i7o1
 JOtNGA/HalEtv8hRY7F1NIPRykHx4m7Y9CSdAsbX5LtIUBau1Nv6rIl5CWyfU9oTKfC8VQrq
 46p2VZ5a8g6CkDS/tbJoDcgERO0h0=;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] wic/x86-uefi-efibootguard: correct the partition name
Date: Thu, 18 Jul 2024 11:54:55 +0530
Message-Id: <20240718062455.9560-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 06:25:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16573

From: Srinuvasan A <srinuvasan.a@siemens.com>

Use the correct partition name for partition B.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 wic/x86-uefi-efibootguard.wks.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.wks.in
index 4c0484f..a1cebc1 100644
--- a/wic/x86-uefi-efibootguard.wks.in
+++ b/wic/x86-uefi-efibootguard.wks.in
@@ -4,7 +4,7 @@
 include ebg-sysparts.inc
 
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
-part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
 
 # home and var are extra partitions
 
-- 
2.34.1


