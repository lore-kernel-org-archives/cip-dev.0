Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C42C3ABAC
	for <webhook@archiver.kernel.org>; Tue,  6 May 2025 12:08:14 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.74173.1746533291172567885
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 May 2025 05:08:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=OATy1ArQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202505061208083e36ce4df17beedb36-rymwyc@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202505061208083e36ce4df17beedb36
        for <cip-dev@lists.cip-project.org>;
        Tue, 06 May 2025 14:08:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Z/amXjeefHpq6IQFznieAjZj9Iv+aTg3dyk+bggeFRQ=;
 b=OATy1ArQ+fBRKHD8ZlOGtlWI7igRtEr4mXvtgHwxvKtxbISdwHk8Vaj2paJXs8mXIpEGt5
 jDfrHhFHfa0S5d77KS+5W99iuLDvZghdKGMeQ00VUpl7V0xRA/GgWRLr8rIi9qRaP1eCdIHt
 slCwKyQgtwictWLH/QAMDHYKBodX+RIzSH423ey9xX3XNa3Ws3Nebw0Ulw2ePLxzsC7RTafg
 lID34Zsr7Z+V6Pc4tvCenEe23C52VpgZhZyzBYLdTi5noVHyfOJR/BVltuWlq3g2J1HnRFcD
 Hj+zWhnTa/73E69no61R14Ulq4Td/zz6243GW0jW2Q/z9HISL5KMyRAA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 4/6] cip-core-image: add factory-reset helper
Date: Tue,  6 May 2025 14:07:46 +0200
Message-ID: <20250506120807.255675-5-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18762

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/cip-core-image.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 4a9cea9..fb3b185 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -14,6 +14,6 @@ require cip-core-image.inc
 DESCRIPTION = "CIP Core image"
 
 IMAGE_INSTALL += "customizations"
-
+IMAGE_INSTALL += "factory-reset-helper"
 CIP_IMAGE_OPTIONS ?= ""
 require ${CIP_IMAGE_OPTIONS}
-- 
2.47.0


