Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECD2EDB7F7
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 10:58:23 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78524.1775559493719073492
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Apr 2026 03:58:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: ef8PLn/jS3mKbk/llCa+Ww==
X-CSE-MsgGUID: Cuyzg1COSiusxPggWc4lpg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 07 Apr 2026 19:58:12 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.188])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 83E07400754E;
	Tue,  7 Apr 2026 19:58:11 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 01/10] dt-bindings: clock: renesas,r9a09g077/87: Add XSPI0/1 IDs
Date: Tue,  7 Apr 2026 11:57:59 +0100
Message-ID: <20260407105808.15196-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407105808.15196-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260407105808.15196-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Apr 2026 10:58:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22622

commit 7c0b8360a4e2892bc1748aca77c0825af82f3dcd upstream.

Add clock definitions for XSPI0/1 to both R9A09G077 and R9A09G087 SoCs.
These definitions are required for describing XSPI devices in DT

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251028165127.991351-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h | 2 ++
 include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h b/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
index 2a805e06487b9..9eaedca6a6163 100644
--- a/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
+++ b/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
@@ -31,5 +31,7 @@
 #define R9A09G077_ETCLKC		19
 #define R9A09G077_ETCLKD		20
 #define R9A09G077_ETCLKE		21
+#define R9A09G077_XSPI_CLK0		22
+#define R9A09G077_XSPI_CLK1		23
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G077_CPG_H__ */
diff --git a/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h b/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
index 09da0ad33be61..606468ac49a4f 100644
--- a/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
+++ b/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
@@ -31,5 +31,7 @@
 #define R9A09G087_ETCLKC		19
 #define R9A09G087_ETCLKD		20
 #define R9A09G087_ETCLKE		21
+#define R9A09G087_XSPI_CLK0		22
+#define R9A09G087_XSPI_CLK1		23
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G087_CPG_H__ */
-- 
2.43.0


