Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E97DCA101F
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 09:52:39 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.35128.1756979555020327049
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Sep 2025 02:52:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=aIz1Bahb;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20250904095233397aa4e22900020706-xbyqna@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250904095233397aa4e22900020706
        for <cip-dev@lists.cip-project.org>;
        Thu, 04 Sep 2025 11:52:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=6y5+2QxM+YuR8IZc8Dhtp3BfR10g0KLv3GP0R8VZng8=;
 b=aIz1BahbIHvZvmkEpW/lSzajFhOPKwLhLWgnh4O57KRxkr8VKyoZH4BxK7EK5WkKplb34D
 tEGPkOepfNjrD4Q+UzsbH3sQ5jqW9Fo10tswVSCOp6RS3Ve/zSQ/x/G05Mj8rHDy2I1u3G13
 KmKUVqtLhWRTHGGrFL8uzaP3adZfbEHco0NH1K0BSatZ9VBvP3besgTjlcpHE+aJg7QV2w6S
 RmlA7lCh5NQzl8px5ZBKfRipBdtiD8FzsWfGk5kfC05kbpW6hZ5Z0BOdpXiw4JNl6EQrN833
 uEJxwaDfgJiL0s01R6V2iifzWyqwdgN+NnHch4ocySaCJRNb9UpzymyA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v5 5/7] Add settings for factory-reset with a separate home partition
Date: Thu,  4 Sep 2025 11:39:28 +0200
Message-ID: <20250904095231.2039819-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
References: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Sep 2025 09:52:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20012

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/separate-home-partition.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kas/opt/separate-home-partition.yml b/kas/opt/separate-home-partition.yml
index 83f59a1..48cccc2 100644
--- a/kas/opt/separate-home-partition.yml
+++ b/kas/opt/separate-home-partition.yml
@@ -19,3 +19,6 @@ local_conf_header:
     OVERRIDES .= ":separate-home-part"
   add-home-partition-to-crypt: |
     CRYPT_PARTITIONS:append:separate-home-part = " home:/home:reencrypt"
+  add-home-partition-to-factory-reset: |
+    INITRAMFS_FACTORY_RESET_DEVICES:append:separate-home-part = " /dev/disk/by-partlabel/home"
+
-- 
2.50.1


