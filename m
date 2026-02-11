Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15760EDF02F
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 04:26:22 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16153.1770804788992738390
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Feb 2026 02:13:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=badrikesh.prusty@siemens.com header.s=fm2 header.b=AWBfSAxl;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1328765-202602111003013e3543a43900020774-g4pbqo@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202602111003013e3543a43900020774
        for <cip-dev@lists.cip-project.org>;
        Wed, 11 Feb 2026 11:03:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=badrikesh.prusty@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=+cPQluyS/9TqwSmZE0X46mB1rUEs3TSi4Page0W/4lA=;
 b=AWBfSAxlKAY2pgi2wXr2pfF0ktWwUZkIg4LiP2L5988YqrmA6fwI9cvC91F3vFjVDCzwbc
 XIZ6Sbau8jCWDgWCDeBKQxtQNISL4Dpj5un+NIfzMPmaqCNt4deKzK5qSdwY9E7Bp216fXPG
 AAmKeSPYXHuOUbHBsz1k6Uhj3bziO80a0qPTc4ATfaUtrlb3Io4igZePd9M8PvGkAnfM27ly
 Rx+lh7g6w3Tz2eVU8LKhyzaaHNiX5mlqcFjCNjsvpUF56RYgOA5AhWyBSgLHIVhsX5MOr/t+
 WESw/JBpuVN0oZN8fEhRGkksqX9PNcV0BDtUeJmr96Vecamz8amLsaqA==;
From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Badrikesh Prusty <badrikesh.prusty@siemens.com>
Subject: [isar-cip-core][PATCH] wic/ebg*sysparts.inc: increase boot partitions size to 128M
Date: Wed, 11 Feb 2026 05:02:49 -0500
Message-ID: <20260211100249.21454-1-badrikesh.prusty@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328765:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Feb 2026 04:26:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21858

With growing kernel sizes, the fixed 64M partition becomes a limitation.
For example, on ti-am62px-sk machine the generated linux.efi image is
already ~58MB, leaving minimal headroom.

Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
---
 wic/ebg-signed-sysparts.inc | 4 ++--
 wic/ebg-sysparts.inc        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/wic/ebg-signed-sysparts.inc b/wic/ebg-signed-sysparts.inc
index b888239..c35878f 100644
--- a/wic/ebg-signed-sysparts.inc
+++ b/wic/ebg-signed-sysparts.inc
@@ -4,5 +4,5 @@
 part --source efibootguard-efi  --size 16M --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcba --uuid d1360f76-b09a-4bcc-b923-8195088cbe02
 
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --fixed-size 64M --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh,verity_root=y" --fsuuid 0x4321dcbb --uuid f870258b-706f-4a66-8d58-b5a75ce61b8b
-part --source efibootguard-boot --fixed-size 64M --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh,verity_root=y" --fsuuid 0x4321dcbc --uuid 6e41f2a7-e3eb-403f-8637-b111e4482ee9
+part --source efibootguard-boot --fixed-size 128M --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh,verity_root=y" --fsuuid 0x4321dcbb --uuid f870258b-706f-4a66-8d58-b5a75ce61b8b
+part --source efibootguard-boot --fixed-size 128M --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh,verity_root=y" --fsuuid 0x4321dcbc --uuid 6e41f2a7-e3eb-403f-8637-b111e4482ee9
diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
index 7052813..0290024 100644
--- a/wic/ebg-sysparts.inc
+++ b/wic/ebg-sysparts.inc
@@ -4,5 +4,5 @@
 part --source efibootguard-efi  --fixed-size 16M --label efi   --align 1024 --part-type=EF00 --active --fsuuid 0x4321dcba --uuid c19e7e9f-bacf-49a6-b43d-2fc18d2a8d03
 
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --fixed-size 64M --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,abrootfs_root=y" --fsuuid 0x4321dcbb --uuid e8567692-2dfa-459a-be15-f6e5ddcc8f49
-part --source efibootguard-boot --fixed-size 64M --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,abrootfs_root=y" --fsuuid 0x4321dcbc --uuid 94b2174d-c792-4e8e-8a34-b506e2927937
+part --source efibootguard-boot --fixed-size 128M --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,abrootfs_root=y" --fsuuid 0x4321dcbb --uuid e8567692-2dfa-459a-be15-f6e5ddcc8f49
+part --source efibootguard-boot --fixed-size 128M --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,abrootfs_root=y" --fsuuid 0x4321dcbc --uuid 94b2174d-c792-4e8e-8a34-b506e2927937
-- 
2.39.5


