Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143D3C25B7C
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 14:49:13 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web11.24273.1716907747622039820
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 07:49:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=Ooi2p/ue;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-20240528144904ea8582c50e9859553e-l5mz6n@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20240528144904ea8582c50e9859553e
        for <cip-dev@lists.cip-project.org>;
        Tue, 28 May 2024 16:49:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=UarOj3T5Im/oJo5JhW6estqFQZpZCqFmMufSCJBIowU=;
 b=Ooi2p/ueXBMbvAA3RlBrTBXgVV5fr7QfMZ4uydsr4KhgzVsZ/4m504B1zgFoczaoTemZ9B
 IIja01VSf828Zed3v+pK66tTo+4z/2MMV7RI0AVCfXDIbtGk1aF+hT0IvZqUeq/v10zQ297F
 +rRHh+si+VsetacRsSKyeB6oiwyKI=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 3/3] Remove tpm2-abrmd
Date: Tue, 28 May 2024 16:42:45 +0200
Message-ID: <20240528144903.922587-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240528144903.922587-1-Quirin.Gylstorff@siemens.com>
References: <20240528144903.922587-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 May 2024 14:49:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15966

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

According to https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/107
not used.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/cip-core-image-security.bb | 1 -
 1 file changed, 1 deletion(-)

diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index 2b1f3ef..8a8c695 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -25,7 +25,6 @@ IMAGE_PREINSTALL += " \
 	libpam-pkcs11 \
 	chrony \
 	tpm2-tools \
-	tpm2-abrmd \
 	acl \
 	audispd-plugins \
 	uuid-runtime \
-- 
2.43.0


