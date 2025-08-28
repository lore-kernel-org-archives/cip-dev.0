Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CCAC8303F
	for <webhook@archiver.kernel.org>; Thu, 28 Aug 2025 11:07:24 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.18177.1756379236735241479
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Aug 2025 04:07:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=uDMkUK3i;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20250828110713f009793abd000207b7-r_mesq@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250828110713f009793abd000207b7
        for <cip-dev@lists.cip-project.org>;
        Thu, 28 Aug 2025 13:07:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=6y5+2QxM+YuR8IZc8Dhtp3BfR10g0KLv3GP0R8VZng8=;
 b=uDMkUK3iVOvLnxl4zBL5U02crR5ORZerfW3KGfwn4vwZwROfU9qvgZI2s+jTExGs0L6Jso
 /8Q8odhoNb9xU7azirT96Y9PiCjrOuaiGfUQGMuR9e979dWRjEjZXxKUAJd6JGM6019zj9gY
 b3QbFEnwyD8zyKzNkqBvgsfkL/JU7zX9vGAoUOgG2nzarR/MTmEP5n23fsBZmmcmE6DECKNW
 7mWYVEuZeKrmvLtkC0PFjEYslLOoVjmUO/ATH7e8vlIo9cGYXp0yKVR6csiCofvzT/LR0RDw
 SCVEMDEzChTS1hN7CHMjZhS9HT87d6X0nCvzqz/1bh+OnUdIOvx+Ia1g==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	gokhan.cetin@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 5/7] Add settings for factory-reset with a separate home partition
Date: Thu, 28 Aug 2025 13:06:52 +0200
Message-ID: <20250828110712.392641-6-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19986

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


