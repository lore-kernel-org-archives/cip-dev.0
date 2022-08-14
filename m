Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFABCC25B0D
	for <webhook@archiver.kernel.org>; Sun, 14 Aug 2022 12:47:44 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web08.4613.1660481259200066709
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Aug 2022 05:47:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=QU5/nhl4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-294854-20220814124736dc9f7be4ddbe0e3c7d-kbu0my@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20220814124736dc9f7be4ddbe0e3c7d
        for <cip-dev@lists.cip-project.org>;
        Sun, 14 Aug 2022 14:47:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=U1SNDCFzjpb1h43DpUEDUm/tl5RkDGSRX2lvvq8Q9Wo=;
 b=QU5/nhl4WFfztH5Cwhc/ukWz0mlRUgU0OTyGKSJJcR8DFF7QFGiSJNqJRVHB/m1KxJjw5a
 CBTjK47gH6fxyZzYds77Pbz7WJYRETtg11RoWeU6opUwZNcBlI6TEakWmZZecTmFLezBfB50
 RrQT06JAiO6HDLv5e+FueZEktl0aA=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Shivanand.Kunijadar@toshiba-tsip.com
Subject: [isar-cip-core][PATCH 1/4] bbb: Fix console parameter
Date: Sun, 14 Aug 2022 15:47:30 +0300
Message-Id: 
 <c1e54cd1cc1ba6fd913bee6d7750698cd7741b7c.1660481252.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1660481252.git.jan.kiszka@siemens.com>
References: <cover.1660481252.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Aug 2022 12:47:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9208

From: Jan Kiszka <jan.kiszka@siemens.com>

Broke booting under certain kernel configuration, e.g. our
cip_bbb_defconfig.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 wic/bbb.wks | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wic/bbb.wks b/wic/bbb.wks
index 17b85f1..2822ce7 100644
--- a/wic/bbb.wks
+++ b/wic/bbb.wks
@@ -11,4 +11,4 @@ part --source rawcopy --sourceparams "file=/usr/lib/u-boot/am335x_boneblack/u-bo
 
 part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active
 
-bootloader --append "rootwait console=ttyO,115200"
+bootloader --append "rootwait console=ttyO0,115200"
-- 
2.35.3


