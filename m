Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4B8C3ABC5
	for <webhook@archiver.kernel.org>; Tue,  6 May 2025 12:08:14 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.74171.1746533291024547657
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 May 2025 05:08:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Vo6yFiOc;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-202505061208080a098be0be571c83a3-2hpvtf@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202505061208080a098be0be571c83a3
        for <cip-dev@lists.cip-project.org>;
        Tue, 06 May 2025 14:08:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=WhNsAvYwICnBKGwAKRqHukTN0THl/hkNQ0X81bh9lA8=;
 b=Vo6yFiOcQ34/2dyUe1+0C4NtuPu/fbib4Y6rGSYyzxqh4GFVPURYkqRdpI8Ngrn06AT5R+
 ksgkZWXL4bLOl6w2wenHvMMh9wsS2xZyeRycIoaeLISmLwp7/CjD5NonmldXWA0xQb7aBrlv
 cYF/rfwe+NWVTlaHGw+485UY6nmwZ7RtQB6svSDGq3U+1ojFWLrNygNhc4aAGTpNpgdJXSCn
 8iFHUQbBqWsbIyG+bTrtm+qLXbc+4iahIHIgtFianSihCM77QpNQpFxd1iJCHnUeUtRrQ52x
 Ud3Nbiu/HLpumSOQk6O5QgSYETxx0MZOVxcoRsJqqc+v1XeUn0+jUARQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 5/6] add factory-reset to initramfs
Date: Tue,  6 May 2025 14:07:47 +0200
Message-ID: <20250506120807.255675-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250506120807.255675-1-Quirin.Gylstorff@siemens.com>
References: <20250506120807.255675-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 May 2025 12:08:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18765

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
index 0e4cf74..7a16849 100644
--- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
+++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
@@ -12,6 +12,7 @@
 inherit initramfs
 
 INITRAMFS_INSTALL += " \
+    initramfs-factory-reset-hook \
     initramfs-overlay-hook \
     "
 
-- 
2.47.0


