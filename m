Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A0FC0219E
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 10:02:08 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.47995.1739786518734494207
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Feb 2025 02:01:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=XaJWXaPv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1326448-20250217100156943ccd959b8ba78b89-plno_w@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250217100156943ccd959b8ba78b89
        for <cip-dev@lists.cip-project.org>;
        Mon, 17 Feb 2025 11:01:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=H2mQBGyAWWGAIa2mmtvr+MjrVL2hg7bWxg1+/8FEKl0=;
 b=XaJWXaPvmZMw/vIqPUO+1IJ4On6mljdjTAwH9+YSVdIaUct+aLtrwGJCAZPKPBLRPD/edJ
 +WLu+TSBKib+q42BIys4HCv6RWx8VAHNJ/M+hbsZ9wR36yzcpRfUIycxjD3z2iE2qOhOwY5O
 a6keF/OtXg+6HIxysz6IyMJzRuvu3lhmJtH9/qL1PMgVUFjhxJqQ8AR38XirF+oLxnaV+nEO
 HRH1Xr/MIBo46T1r1UHDhlNT8/ATbReorMMbDG90ZfyJJHKnmntWRjozHAPT7zj4yB13Yqy0
 SHrYbfTBVm0b9knHUvG7F+Z+mOkdEiFo+npc5dzNfeD5jkxlZFck0w1g==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 1/3] Removed "ro" option from read-only-rootfs's fstab.
Date: Mon, 17 Feb 2025 11:00:22 +0100
Message-ID: <20250217100024.42995-2-alexander.heinisch@siemens.com>
In-Reply-To: <20250217100024.42995-1-alexander.heinisch@siemens.com>
References: <20250217100024.42995-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1326448:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Feb 2025 10:02:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17856

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Since we only support erofs and squashfs this option is not needed
any more. Further, it causes potential overlay rootfs variants
to be remounted read-only.

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 classes/read-only-rootfs.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
index 35a3ab3..83ddc33 100644
--- a/classes/read-only-rootfs.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -41,7 +41,7 @@ SQUASHFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
 image_configure_fstab() {
     sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
 # Begin /etc/fstab
-/dev/root	/		auto		defaults,ro			0	0
+/dev/root	/		auto		defaults			0	0
 LABEL=var	/var		auto		defaults			0	0
 proc		/proc		proc		nosuid,noexec,nodev		0	0
 sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
-- 
2.39.5


