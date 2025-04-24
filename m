Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33701C369AB
	for <webhook@archiver.kernel.org>; Thu, 24 Apr 2025 09:23:13 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.11058.1745486585755280684
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Apr 2025 02:23:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=EW1CUeJO;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-2025042409230387b5793c27ac1dc543-wgcuoa@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025042409230387b5793c27ac1dc543
        for <cip-dev@lists.cip-project.org>;
        Thu, 24 Apr 2025 11:23:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=/C1ri1fVYCW/ZgJ5ytK5QN59DYYeh5l+aSCYwEXm5ZM=;
 b=EW1CUeJOHmboN/fwqsqUC0F9hx+D2Z1ma6/OZqN9X5yleYvJYzmWjHwO3mMgw3WS6AVMCw
 OscfVTofEKrTa9V9Ltb5GI8UeuwHG6b5jMOT/WfgcTfsGdTv9qh2WMnkaRo73vA13B36IIZ8
 WuYht50OWHpOiMqqxeqd0AxQei99c6GVGpvDi2UjEUEQWEiIVvJr8IaN++tYcksDnfZ/nNX5
 bmav/+6CgTc/Ora+qjm+KHQmtlsF9W2st/ghz/D6kvbmHGoCOH5n+0gipKlTHvO7vhp+qYiX
 proW9qxsb+O2kohwbhvIvoVSk/uFNgXLXy7ucJPrqzn61VFmgsl+55Xw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [PATCH 2/2] add data-reset hook to cip-core-initramfs
Date: Thu, 24 Apr 2025 11:22:22 +0200
Message-ID: <20250424092302.2066773-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250424092302.2066773-1-Quirin.Gylstorff@siemens.com>
References: <20250424092302.2066773-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Apr 2025 09:23:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18594

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
index 0e4cf74..d4b1e5e 100644
--- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
+++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
@@ -12,6 +12,7 @@
 inherit initramfs
 
 INITRAMFS_INSTALL += " \
+    initramfs-data-reset-hook \
     initramfs-overlay-hook \
     "
 
-- 
2.47.0


