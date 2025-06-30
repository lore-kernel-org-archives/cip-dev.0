Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABE8C83036
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 18:15:42 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.48074.1751307332116737751
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jun 2025 11:15:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=hndAYSZo;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1330684-202506301815261569309d6bd2c3f706-t1othq@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202506301815261569309d6bd2c3f706
        for <cip-dev@lists.cip-project.org>;
        Mon, 30 Jun 2025 20:15:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=O2BQzLKrkBKQDciOHs2D/UkAjZhy6ivcoFmXePkxBPM=;
 b=hndAYSZoDnuM6dudRodCuA4MbFqVphLNowZqFyPoxe89hRonqFVKV+Yi/sUPplFKJDAqya
 xhhmlH3HlnOnrjkWfqqIHTAHrxvcWV/WXTWwIVByqlqC8jGrTFDEwDs3tFcYq3SPE5HBPYjs
 goon40dtJ0bAHaINpUN+/6MvH6pv/e4gQWnnz7MxYJz6eEPe92tb4ZXeu/9UYjFO8FaMB0V7
 rhAcDin97eT6VfTTwzyzflLxeyyvzBzoof9fwzxC3JZUGiV44U4LLd9F/FPUknFRhCQeXRGO
 D/fAcrmT2tjRmPFuA9i5aZKeKLs8dQvI5xyeAcdwPs53+f8erVTE7i9g==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	felix.moessbauer@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][RFC 2/7] initramfs: Add overlay hook only if overlays are configured.
Date: Mon, 30 Jun 2025 20:15:11 +0200
Message-Id: <20250630181516.1718712-3-alexander.heinisch@siemens.com>
In-Reply-To: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
References: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jun 2025 18:15:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19262

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
index 12797d3..506b433 100644
--- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
+++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
@@ -11,9 +11,9 @@
 
 inherit initramfs
 
-INITRAMFS_INSTALL += " \
-    initramfs-overlay-hook \
-    "
+INITRAMFS_OVERLAY_PATHS ??= "/etc"
+OVERRIDES .= "${@':overlay-enabled' if d.getVar('INITRAMFS_OVERLAY_PATHS') and d.getVar('INITRAMFS_OVERLAY_PATHS').strip() else ''}"
 
 INITRAMFS_INSTALL:append = " initramfs-persistence-hook"
+INITRAMFS_INSTALL:append:overlay-enabled = " initramfs-overlay-hook"
 INITRAMFS_INSTALL:append:encrypt-partitions = " initramfs-crypt-hook"
-- 
2.39.5


