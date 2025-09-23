Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80782CAC5B4
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 10:07:50 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.13253.1758622066726218110
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 03:07:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=j0xHMfjI;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20250923100743450c8f51dc000207db-inugg0@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250923100743450c8f51dc000207db
        for <cip-dev@lists.cip-project.org>;
        Tue, 23 Sep 2025 12:07:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=RzX1T4s4XA0SaiDOi7zOK/p8UXbB9pI/XNd3BA+2Bp4=;
 b=j0xHMfjIwg2o4rUnrwcEokCqSZ0/D5cF9XaD5k8pEvERvzzd0XcrFSEpfJZQTVxTALr9Q6
 Kq3DgvMgIeszmJY/xTGjLfN07Whmw1m00jo9j+HNrvJvTuvqsO4sp2BvBT/CHE3JCMrV6udK
 QAPNFUvfOFSmmcJZ2fcCUyGdhiiUmIcFgSadOfSCUC9ItxJnNh5TIFZzg0EoDNGm5ETh4s/H
 pp3LhTwgGhETwP2v8lbbNBhT4rjIH2Ui5AsaL6FFQpcU7nHvqXVxQ+C0Zzm08al/657tNyTr
 uLiUuOzTq46sA2fOtOc6fGR5I19RWujel9wqA4yxKpchzQTRM3fnRZLA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v6 4/7] Add settings for factory-reset with a separate home partition
Date: Tue, 23 Sep 2025 12:02:38 +0200
Message-ID: <20250923100734.319688-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250923100734.319688-1-Quirin.Gylstorff@siemens.com>
References: <20250923100734.319688-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 10:07:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20100

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/separate-home-partition.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kas/opt/separate-home-partition.yml b/kas/opt/separate-home-partition.yml
index 83f59a1..9fccd20 100644
--- a/kas/opt/separate-home-partition.yml
+++ b/kas/opt/separate-home-partition.yml
@@ -19,3 +19,5 @@ local_conf_header:
     OVERRIDES .= ":separate-home-part"
   add-home-partition-to-crypt: |
     CRYPT_PARTITIONS:append:separate-home-part = " home:/home:reencrypt"
+  add-home-partition-to-factory-reset: |
+    INITRAMFS_FACTORY_RESET_DEVICES:append:separate-home-part = " /dev/disk/by-partlabel/home"
-- 
2.50.1


