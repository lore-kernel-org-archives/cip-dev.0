Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D24C5320E
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 12:51:47 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.209676.1724071903243660940
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Aug 2024 05:51:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=I5IARKVh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-202408191251402ed276e2f0975e0d52-crxygp@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202408191251402ed276e2f0975e0d52
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Aug 2024 14:51:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=sYGAf7trV+W2c30/QR4GsTGldsB111ffs+BSo5Y4EXw=;
 b=I5IARKVh7d4JZi1U28RP7Kr4Kn7+jQjShWP9lg4UeAjFaMeesyfpHsiigRD0V7fOBxSP47
 ol0a3+Dj7pFKjufU7ieVwHvbqEF/Y4+zDb0X++AKX52A/LRky3CqMlT4nIjY1ZxTqNS0xsDA
 czfxN0uIEa5sLX7sey5fEAJjaELO0F/DHc1dnF2nGd+maBVRpb7gvyJBMWTCNzMVZSB8fy8y
 InrNYuIEuNWAjKjlZ5lXhd8hODc/MSv0S+igCt4sPRvkEDnQF40714xYMALz49YXBNGn2JZN
 9Xk0/SP5Htj/SczSDHXmFFCUkL14OQbNZ27VB2uoQRDnR8raoMqA81JA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp,
	Sai.Sathujoda@toshiba-tsip.com,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 2/2] fix: force mke2fs in overlay recovery action
Date: Mon, 19 Aug 2024 14:51:26 +0200
Message-ID: <20240819125138.1543399-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240819125138.1543399-1-Quirin.Gylstorff@siemens.com>
References: <20240819125138.1543399-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Aug 2024 12:51:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16803

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If mke2fs detects an existing file system, it enters interactive mode
avoid interactive mode by forcing the creation of a new filesystem.

The issue was introduced with:

8644fb1 initramfs-overlay-hook: Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-overlay-hook/files/overlay_recovery_action.script | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
index d13111d..0cd084b 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
@@ -11,4 +11,4 @@
 partition_fstype="$1"
 ovl_partition_device="$2"
 
-mke2fs -t "$partition_fstype" "$ovl_partition_device"
+mke2fs -q -FF -t "$partition_fstype" "$ovl_partition_device"
-- 
2.43.0


