Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9066CEBF92
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 17:15:24 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14790.1763399722329863964
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 09:15:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=ne73PKI4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-20251117171518426565c36d000207a3-0ue4aq@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251117171518426565c36d000207a3
        for <cip-dev@lists.cip-project.org>;
        Mon, 17 Nov 2025 18:15:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cxyKejTdD5CiidLJwzL0UUWH7zhnZ8z18unf1mAGfrI=;
 b=ne73PKI43JBpJuutdx7nGHDpjGJuJ5NUkibZcPugp+BaI9QiJJ3qBbsmRl6+68eeYCfWI3
 GXyTEDDpXWieSqe6gqBwWJScOJEF0jTEbxo1b8NzlVgbZoN89QxcvYBHPZpWJwnDWlovb7Nq
 og5dWGdYsHPcUw5jkqzOTsrXAbkTu0DxN1TC5/JRhMI9ukk/8kavjWhWchj3Xk1n+5Nr1193
 l8bBznTUiOoIbZUceHkBCF+Cb3ne231uHNZcXasEscT4soH/1mpzV9iOic2VeaWKi9LN9sCY
 nbhKCuPJ1tONw+UU2Jo3pZbP6Ep9ZNZ52Oghww80g4IyDxjNeienmsXg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [isar-cip-core][PATCH 5/6] u-boot-ti-am62px-sk: Drop redundant or unused DEBIAN_BUILD_DEPENDS
Date: Mon, 17 Nov 2025 18:15:16 +0100
Message-ID: <2888b7f5839b31f31c0067d128eab393bfcd10c1.1763399717.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1763399717.git.jan.kiszka@siemens.com>
References: <cover.1763399717.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Nov 2025 17:15:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20602

From: Jan Kiszka <jan.kiszka@siemens.com>

The 2 ssl deps are already added by the common inc, and grub is uneeded.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb | 1 -
 1 file changed, 1 deletion(-)

diff --git a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
index fa72054c..b26c089d 100644
--- a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
+++ b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
@@ -47,7 +47,6 @@ OVERRIDES .= ":ftpm-stmm"
 
 DEPENDS += "trusted-firmware-a-ti-k3 optee-os-ti-k3"
 DEBIAN_BUILD_DEPENDS =. "gcc-arm-linux-gnueabihf, \
-    libssl-dev:native, libssl-dev, grub-common, \
     swig, python3-dev:native, python3-setuptools, python3-pyelftools, \
     python3-jsonschema:native, yamllint:native, \
     trusted-firmware-a-ti-k3, optee-os-ti-k3,"
-- 
2.51.0


