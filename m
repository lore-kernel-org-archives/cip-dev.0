Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF860D32D74
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:33:41 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6927.1764945202623019546
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:33:34 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: CUr9+M5/Sg6ThNMa5w+mtw==
X-CSE-MsgGUID: ZpMUddoBS7q9kTBX2UFFvA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Dec 2025 23:33:34 +0900
Received: from Ubuntu-22.. (unknown [10.24.1.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0AC484179CE0;
	Fri,  5 Dec 2025 23:33:32 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 19/38] dt-bindings: clock: renesas,r9a09g077: Add PCLKL core clock ID
Date: Fri,  5 Dec 2025 14:32:39 +0000
Message-ID: <20251205143258.13748-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:33:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20933

commit 62ab7ac5be90392a9ac0955febab778ebf51bc0a upstream.

Add the Peripheral Module Clock L (PCLKL) core clock ID for the RZ/T2H
(R9A09G077) SoC.  This clock is used by peripherals such as IIC, WDT,
and others.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250617155757.149597-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h b/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
index 1b22fe88dec7a..f6e5f62b07c4a 100644
--- a/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
+++ b/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
@@ -23,5 +23,6 @@
 #define R9A09G077_CLK_PCLKGPTL		11
 #define R9A09G077_CLK_PCLKH		12
 #define R9A09G077_CLK_PCLKM		13
+#define R9A09G077_CLK_PCLKL		14
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G077_CPG_H__ */
-- 
2.43.0


