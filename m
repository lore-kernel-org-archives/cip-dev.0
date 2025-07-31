Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3B2C87FD5
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 12:00:50 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.60287.1753963247619146087
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Jul 2025 05:00:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=KWEpRxPY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-202507311200452e55b5809016ae0453-wd5_sj@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202507311200452e55b5809016ae0453
        for <cip-dev@lists.cip-project.org>;
        Thu, 31 Jul 2025 14:00:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=yulJUhNpk8AX5VeE3rG3B92NY7pxB/3kVVH2250Fm8Y=;
 b=KWEpRxPYSRK6MBeK6B825KfV7HrfLMvqaWZbskFo/PGR4fn0LnRct9gIQYSYMHoekGtfeG
 OUnP+GASy4k3IqAVTFIdHsw+cggZwgmRgqlJBLgHn+aVieTWZmQB/nehNzXQKdQ0xZ+6MRH3
 KHD2l6NveK/V5ou8MHHqjJBvk9bXCyWJSvIxtP8umDrdI3boFeqvsy1bqVjKxtfjlgC4U9sV
 FDji0PAH7lbIhcFkkydyyPcxElP2THLvWR/paQ0ozXuGfviCMakkO7mLggtZ5DfAiZiJiKPp
 g9zViGqkYvLjDQgANoxux8u3KhoWMzD95N0b0gHTbQFDmRf+L433Xkig==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	gokhan.cetin@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 6/7] add factory-reset to initramfs
Date: Thu, 31 Jul 2025 13:58:45 +0200
Message-ID: <20250731120043.333345-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250731120043.333345-1-Quirin.Gylstorff@siemens.com>
References: <20250731120043.333345-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 12:00:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19641

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
2.50.1


