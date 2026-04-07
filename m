Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BE4F46C7B
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 10:58:25 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78638.1775559492699210337
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Apr 2026 03:58:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: 4/xd5j1kQ7WFNrI6NJWNdA==
X-CSE-MsgGUID: 2ps+fKMiRfyUFpzOI3SgoA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 Apr 2026 19:58:14 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.188])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3776C4007F40;
	Tue,  7 Apr 2026 19:58:12 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 02/10] dt-bindings: clock: renesas,r9a09g077/87: Add PCLKCAN ID
Date: Tue,  7 Apr 2026 11:58:00 +0100
Message-ID: <20260407105808.15196-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407105808.15196-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260407105808.15196-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Apr 2026 10:58:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22623

commit 481b64376c3fb72557725acf2f4fbc4f73bc3188 upstream.

Add PCLKCAN ID for CANFD to both R9A09G077 and R9A09G087 SoCs.
This definition is required for describing CANFD device in DT.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251224165049.3384870-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h | 1 +
 include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h b/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
index 9eaedca6a6163..c4863e444458f 100644
--- a/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
+++ b/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
@@ -33,5 +33,6 @@
 #define R9A09G077_ETCLKE		21
 #define R9A09G077_XSPI_CLK0		22
 #define R9A09G077_XSPI_CLK1		23
+#define R9A09G077_PCLKCAN		24
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G077_CPG_H__ */
diff --git a/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h b/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
index 606468ac49a4f..0d53f1e650776 100644
--- a/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
+++ b/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
@@ -33,5 +33,6 @@
 #define R9A09G087_ETCLKE		21
 #define R9A09G087_XSPI_CLK0		22
 #define R9A09G087_XSPI_CLK1		23
+#define R9A09G087_PCLKCAN		24
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G087_CPG_H__ */
-- 
2.43.0


