Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD1DC02193
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:39:28 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.12050.1738229961122790466
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:39:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=g5ydzaba;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-2025013009391942fa2ad604010ca9dc-vu8aut@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025013009391942fa2ad604010ca9dc
        for <cip-dev@lists.cip-project.org>;
        Thu, 30 Jan 2025 10:39:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qXCSlWvupzE/o+Ixyf6ICrd9wX/d6srQv8AyxSMXuco=;
 b=g5ydzaba5+wywTkdt+8jSsdoI85xfUvoSqBauLn4FdYxfedLnAshr7S0d0q6IzV7x1LmdK
 ukGrRbxxwTSZY68PNQrQwMIGQ90bm0DRRNeD5gPx+dJA8KS/rZ1lHDRwW1eqGizU62h63bF2
 392z6ukNS94GAlVfVqk7hxpFgFaX9YrM8E4qmqVg125CmqLEkvOEkwgCXJgi+MiL6iNG58lc
 XobMq2dZIvfB2hujZ6aTmQmOUha0xmdOwEb4SAqytIDPqusbtjO1mpA8pr9bEefGANhorMk+
 MytfzoVXpYPJdcciAMCJrkASapjUCE8VfB8sChu030TfN3rQhI4rsSvg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC][PATCH 05/10] initramfs-overlay-hook: Tune the parameter documentation
Date: Thu, 30 Jan 2025 10:39:12 +0100
Message-ID: <b78be79bfb3bba1a4efa9a8e7628659003aa6023.1738229957.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1738229957.git.jan.kiszka@siemens.com>
References: <cover.1738229957.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 09:39:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17698

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb    | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
index 4e2e2922..ec7f85b6 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
@@ -25,12 +25,14 @@ INITRAMFS_OVERLAY_PATHS ??= "/etc"
 
 # The variable INITRAMFS_OVERLAY_STORAGE_PATH designates the path were the
 # changes to the overlayed directory are stored (upper dir). The initramfs
-# also mounts the first directory after root to the
-# INITRAMFS_OVERLAY_STORAGE_DEVICE.
+# hook also mounts the first directory after root to
+# INITRAMFS_OVERLAY_STORAGE_DEVICE if it is not mounted yet.
 INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
 
 # override this to switch to UUID or PARTUUID based mounts
 INITRAMFS_OVERLAY_STORAGE_DEVICE ??= "/dev/disk/by-label/var"
+
+# options to use for mounting INITRAMFS_OVERLAY_STORAGE_DEVICE
 INITRAMFS_OVERLAY_MOUNT_OPTION ??= "defaults,nodev,nosuid,noexec"
 
 TEMPLATE_FILES += "local-bottom.tmpl"
-- 
2.43.0


