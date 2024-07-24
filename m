Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E0CC3DA63
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 09:12:48 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.6600.1721812365654207111
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jul 2024 02:12:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,232,1716217200"; 
   d="scan'208";a="212548617"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 24 Jul 2024 18:12:46 +0900
Received: from localhost.localdomain (unknown [10.226.92.210])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 99BA24215B95;
	Wed, 24 Jul 2024 18:12:44 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 1/1] Revert "arm64: dts: renesas: rzg2l: Add missing cache-level properties"
Date: Wed, 24 Jul 2024 10:12:37 +0100
Message-ID: <20240724091240.67115-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724091240.67115-1-biju.das.jz@bp.renesas.com>
References: <20240724091240.67115-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Jul 2024 09:12:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16612

This reverts commit f703a1ddec6a36b67e895921951666e0ffe58c54.

It is triggering a warning on linux-6.1.y-cip:
"cacheinfo: Unable to detect cache hierarchy for CPU 0"

Backporting the generic patches may not suitable for linux-6.1.y-cip.
---
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 1 -
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi  | 1 -
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index f0c1757a794a..427c0746f235 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -31,7 +31,6 @@ L3_CA55: cache-controller-0 {
 			compatible = "cache";
 			cache-unified;
 			cache-size = <0x40000>;
-			cache-level = <3>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 87a07a359c57..94867568f46b 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -109,7 +109,6 @@ L3_CA55: cache-controller-0 {
 			compatible = "cache";
 			cache-unified;
 			cache-size = <0x40000>;
-			cache-level = <3>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 8f2430c95f07..968dbcd0aa09 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -109,7 +109,6 @@ L3_CA55: cache-controller-0 {
 			compatible = "cache";
 			cache-unified;
 			cache-size = <0x40000>;
-			cache-level = <3>;
 		};
 	};
 
-- 
2.43.0


