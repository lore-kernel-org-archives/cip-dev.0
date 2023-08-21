Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883A3EE4996
	for <webhook@archiver.kernel.org>; Mon, 21 Aug 2023 14:38:41 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.1008.1692628695125774967
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Aug 2023 07:38:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,190,1684767600"; 
   d="scan'208";a="173473054"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2023 23:38:32 +0900
Received: from localhost.localdomain (unknown [10.226.92.38])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BDF3E4007552;
	Mon, 21 Aug 2023 23:38:30 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 13/15] arm64: dts: renesas: rzg2l: Add missing cache-level properties
Date: Mon, 21 Aug 2023 15:37:57 +0100
Message-Id: <20230821143759.227105-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
References: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Aug 2023 14:38:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12807

From: Pierre Gondois <pierre.gondois@arm.com>

commit 4662d6e8c9b0035581ffc31cab80ea5963bd9f24 upstream.

The DeviceTree Specification v0.3 specifies that the cache node
'cache-level' property is 'required'.  Cf. s3.8 Multi-level and Shared
Cache Nodes.

Update the Device Trees accordingly.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Link: https://lore.kernel.org/r/20221107155825.1644604-19-pierre.gondois@arm.com
[geert: Update description]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 1 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi  | 1 +
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index ebaaf82edeca..9d854706ada5 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -31,6 +31,7 @@ L3_CA55: cache-controller-0 {
 			compatible = "cache";
 			cache-unified;
 			cache-size = <0x40000>;
+			cache-level = <3>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 67677a4bd4c7..ee6c384c6933 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -109,6 +109,7 @@ L3_CA55: cache-controller-0 {
 			compatible = "cache";
 			cache-unified;
 			cache-size = <0x40000>;
+			cache-level = <3>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 60ad8b05948f..3efd63b0981a 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -109,6 +109,7 @@ L3_CA55: cache-controller-0 {
 			compatible = "cache";
 			cache-unified;
 			cache-size = <0x40000>;
+			cache-level = <3>;
 		};
 	};
 
-- 
2.25.1


