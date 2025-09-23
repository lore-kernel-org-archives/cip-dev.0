Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F96CAC5B5
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 11:53:42 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.14947.1758628411447755593
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 04:53:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=F+DJqEZ8;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20250923115329c807c14c44000207cd-a41vto@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250923115329c807c14c44000207cd
        for <cip-dev@lists.cip-project.org>;
        Tue, 23 Sep 2025 13:53:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=RzX1T4s4XA0SaiDOi7zOK/p8UXbB9pI/XNd3BA+2Bp4=;
 b=F+DJqEZ8SblPcdczmEx3F6bJJgXa7b53FbOf5vblDHeqzkb9w3wsVJCT+9jsyWvwjCpIsO
 U44F4gp/4G8pD2qd0WSNrWDrcTvZRXQiDWjxQSFUx9ZnWu+yrGFvjMDu0U1JBiOrXF95YDV+
 3QwRdmkm+Gh2j5CWVWIPvmolXLMkT1e2RUUVwlz5hwlF2Ke4hOM4gq30aIo0z9egqyx6HyJy
 977IaZohSJJavUccr4XAWBrTGWkZjNT8IMvdnu5ews3/CK8Thi4n40F3zZ40WAQfX/UukDoj
 06HbzkVZFlT7GyNJHvWpIzFNycD4MXyuSsMd/h8d7Gip0HnBZSD761vg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v7 5/7] Add settings for factory-reset with a separate home partition
Date: Tue, 23 Sep 2025 13:52:56 +0200
Message-ID: <20250923115319.335608-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250923115319.335608-1-Quirin.Gylstorff@siemens.com>
References: <20250923115319.335608-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 11:53:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20112

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


