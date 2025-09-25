Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A4ECAC5B8
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 06:00:36 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.4680.1758780027546826074
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Sep 2025 23:00:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=qe/372gy;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-2025092506002569f1dd3f1c00020777-n8aobn@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2025092506002569f1dd3f1c00020777
        for <cip-dev@lists.cip-project.org>;
        Thu, 25 Sep 2025 08:00:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=H6zfzy1SOnvn4QOSPNFeApOV1C6p5Zl1IG+VXAmP/rw=;
 b=qe/372gyCRya/sxPQJzLgsBBeMYLArGWk9Bi/56Qs5xr5OwjRWhIIqPhZP6l1DKg+xL0Vf
 DjpH72groksbMrJ6V2piPh6A/vwkrn+Q/dBvUVJuNq5VdiLhmFrHw/6praDdH5aI2VxRQuRw
 JUyX29Uc+5M4WJ3nXbwmStxr2ezK4DGD1UdX2bkxca42Akz+6KrFFrgJuBTAMXluLB7zAkjN
 vbzFzgyaic708JNpOexI9VdLTLpiy49keJ8uUdFqjoUSM65mBz99mpZotMS4r3dI5vKev1v4
 iTUXZPoOqwTx8niQYimH22u0bz0z+w/ru1CnR/KnJGt7F0C0NILSTmeA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v8 5/8] Add settings for factory-reset with a separate home partition
Date: Thu, 25 Sep 2025 07:59:17 +0200
Message-ID: <20250925060009.1711605-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250925060009.1711605-1-Quirin.Gylstorff@siemens.com>
References: <20250925060009.1711605-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Sep 2025 06:00:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20125

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
2.51.0


