Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7E6CA0FFC
	for <webhook@archiver.kernel.org>; Thu, 28 Aug 2025 11:07:24 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.18177.1756379236553818539
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Aug 2025 04:07:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=rLyysUJh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20250828110713b4213a98590002078b-9qpniw@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250828110713b4213a98590002078b
        for <cip-dev@lists.cip-project.org>;
        Thu, 28 Aug 2025 13:07:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=5EeyCH6FYL/P/Iu+GJEwxmMf7Qtdv+aB64+Uf1vLlJc=;
 b=rLyysUJh5PhEX94ALjqGmrTMF4OdMIW3K+F9MoZM/1O/CvawbbJ8Y/7R/sd7DvpYG2CgHt
 mGatv7MS+WDLAxpESGjLCbeSPrq2iEDVcYswXG57WYW9NMdbJxPS4PNh5UQaK0ccBzsO6+0c
 erM7f0hFP1O3D0UcP9Q3fyJ2rcdKj4aUMtw3/nOat5jQgsJOXyUQRx1KbgW977h4szczNfQs
 fWXQVoMk8jrqpnHfmNtNDZUcZ+SI3ec+iPa2UQMBq5H7e4KjKw3CrY/UBDXBryeMiHmN7CqY
 UGpMmgJS0oDSJMkZ5cgxXtn/MmYI5y49a6xKysutOrMNf4OMPierqPgA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	gokhan.cetin@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 4/7] Add factory-reset information to encrypt-data
Date: Thu, 28 Aug 2025 13:06:51 +0200
Message-ID: <20250828110712.392641-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250828110712.392641-1-Quirin.Gylstorff@siemens.com>
References: <20250828110712.392641-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Aug 2025 11:07:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19981

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/encrypt-data.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kas/opt/encrypt-data.yml b/kas/opt/encrypt-data.yml
index 3de76ab..4292d4c 100644
--- a/kas/opt/encrypt-data.yml
+++ b/kas/opt/encrypt-data.yml
@@ -15,3 +15,6 @@ header:
 local_conf_header:
   initramfs-option-encrypt-partitions: |
     OVERRIDES .= ":encrypt-partitions"
+  initramfs-factory-reset: |
+    INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE = "/dev/disk/by-partlabel/BOOT0"
+
-- 
2.50.1


