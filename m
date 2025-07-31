Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746BCC87FD8
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 12:00:50 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.60288.1753963247619436321
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Jul 2025 05:00:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=L3N1UzSv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-202507311200456352f124a61607ce8d-snvnxe@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202507311200456352f124a61607ce8d
        for <cip-dev@lists.cip-project.org>;
        Thu, 31 Jul 2025 14:00:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=6y5+2QxM+YuR8IZc8Dhtp3BfR10g0KLv3GP0R8VZng8=;
 b=L3N1UzSvwMALjye/gj4yWVZDQsyCIZH/T8dtumyE08TqV4Jm7A9Dv5o/ckCtB/6wwWSzxw
 88Zw4FkG+rYeijNRYJF/wFUReU2tntwAPlHP97Pc7hz7NonSA1J1lF7gaLQqz7iwwalYDcZo
 jYFbCPq2wff2hxkrQI4Ex1zdoianxsBQmK4mltFKnrzQt4oV993UIgXycSyU36y8O2eLRYhj
 yhkM+OoD6UROL4iJuphm8q/6YNIGd31sfhfQqiGSR9jQ+e8V8XmUMPE+42nW+jdV3JfMy7Tw
 bUCOUFPvwOWoYs6SE9XAHxaHfTpUuF6anX8m7/MN7/YOA9ZUdGPIQroQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	gokhan.cetin@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 7/7] Add settings for factory-reset with a separate home partition
Date: Thu, 31 Jul 2025 13:58:46 +0200
Message-ID: <20250731120043.333345-8-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19647

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


