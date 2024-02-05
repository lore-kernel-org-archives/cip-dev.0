Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C857C48299
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 12:42:46 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.61491.1707136958786898266
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 04:42:40 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,245,1701097200"; 
   d="scan'208";a="192915868"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Feb 2024 21:42:40 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B358640065B6;
	Mon,  5 Feb 2024 21:42:38 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 30/48] dt-bindings: clock: r9a07g043-cpg: Add Renesas RZ/Five CPG Clock and Reset Definitions
Date: Mon,  5 Feb 2024 12:41:17 +0000
Message-Id: <20240205124135.14779-31-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 12:42:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14699

commit 668d361c9d893be3cbd4f3650e1934a62b204def upstream.

Renesas RZ/Five SoC has almost the same clock structure compared to the
Renesas RZ/G2UL SoC, re-use the r9a07g043-cpg.h header file and just
amend the RZ/Five CPG clock and reset definitions.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220622181723.13033-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/dt-bindings/clock/r9a07g043-cpg.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/dt-bindings/clock/r9a07g043-cpg.h b/include/dt-bindings/clock/r9a07g043-cpg.h
index 27e232733096..77cde8effdc7 100644
--- a/include/dt-bindings/clock/r9a07g043-cpg.h
+++ b/include/dt-bindings/clock/r9a07g043-cpg.h
@@ -108,6 +108,15 @@
 #define R9A07G043_ADC_ADCLK		76
 #define R9A07G043_ADC_PCLK		77
 #define R9A07G043_TSU_PCLK		78
+#define R9A07G043_NCEPLDM_DM_CLK	79	/* RZ/Five Only */
+#define R9A07G043_NCEPLDM_ACLK		80	/* RZ/Five Only */
+#define R9A07G043_NCEPLDM_TCK		81	/* RZ/Five Only */
+#define R9A07G043_NCEPLMT_ACLK		82	/* RZ/Five Only */
+#define R9A07G043_NCEPLIC_ACLK		83	/* RZ/Five Only */
+#define R9A07G043_AX45MP_CORE0_CLK	84	/* RZ/Five Only */
+#define R9A07G043_AX45MP_ACLK		85	/* RZ/Five Only */
+#define R9A07G043_IAX45_CLK		86	/* RZ/Five Only */
+#define R9A07G043_IAX45_PCLK		87	/* RZ/Five Only */
 
 /* R9A07G043 Resets */
 #define R9A07G043_CA55_RST_1_0		0	/* RZ/G2UL Only */
@@ -180,5 +189,16 @@
 #define R9A07G043_ADC_PRESETN		67
 #define R9A07G043_ADC_ADRST_N		68
 #define R9A07G043_TSU_PRESETN		69
+#define R9A07G043_NCEPLDM_DTM_PWR_RST_N	70	/* RZ/Five Only */
+#define R9A07G043_NCEPLDM_ARESETN	71	/* RZ/Five Only */
+#define R9A07G043_NCEPLMT_POR_RSTN	72	/* RZ/Five Only */
+#define R9A07G043_NCEPLMT_ARESETN	73	/* RZ/Five Only */
+#define R9A07G043_NCEPLIC_ARESETN	74	/* RZ/Five Only */
+#define R9A07G043_AX45MP_ARESETNM	75	/* RZ/Five Only */
+#define R9A07G043_AX45MP_ARESETNS	76	/* RZ/Five Only */
+#define R9A07G043_AX45MP_L2_RESETN	77	/* RZ/Five Only */
+#define R9A07G043_AX45MP_CORE0_RESETN	78	/* RZ/Five Only */
+#define R9A07G043_IAX45_RESETN		79	/* RZ/Five Only */
+
 
 #endif /* __DT_BINDINGS_CLOCK_R9A07G043_CPG_H__ */
-- 
2.34.1


