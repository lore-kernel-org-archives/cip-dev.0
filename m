Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8138C47079
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 18:16:18 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.4554.1704737776356803706
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jan 2024 10:16:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,180,1695654000"; 
   d="scan'208";a="193590184"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 09 Jan 2024 03:16:16 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.235])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5408840469DF;
	Tue,  9 Jan 2024 03:16:15 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 01/30] arm64: dts: renesas: rzg2ul-smarc: Drop including RZ/G2UL SoM DTSI
Date: Mon,  8 Jan 2024 18:15:43 +0000
Message-Id: <20240108181612.5651-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108181612.5651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240108181612.5651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jan 2024 18:16:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14289

Drop including RZ/G2UL SoM DTSI in carrier board DTSI as the top level
board DTS file r9a07g043u11-smarc.dts includes both of them. Upstream
commit 53072ba67e534ddd208697d3465004738f1d4d61 ("arm64: dts: renesas:
rzg2ul-smarc: Include SoM DTSI into board DTS") already did this change
but it was re-introduced in below commit (for v6.1-cip):

ce658d9231044 ("arm64: dts: renesas: rzg2ul-smarc: Enable SCI0")

This change is in preparation for adding the Renesas RZ/Five RISC-V SoC.
Without this patch when re-using the RZ/G2UL DTS/I for the SMARC RZ/Five
board we see below build issues:

  DTC     arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb
./scripts/dtc/include-prefixes/arm64/renesas/rzg2ul-smarc-som.dtsi:106.23-124.4:
ERROR (phandle_references): /soc/ethernet@11c30000/ethernet-phy@7: Reference to non-existent node or label "irqc"

  also defined at arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi:20.23-23.4
  also defined at ./scripts/dtc/include-prefixes/arm64/renesas/rzg2ul-smarc-som.dtsi:106.23-124.4
ERROR: Input tree has errors, aborting (use -f to force output)
make[2]: *** [scripts/Makefile.lib:406: arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb] Error 2
make[1]: *** [scripts/Makefile.build:500: arch/riscv/boot/dts/renesas] Error

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
index 669703b0c7cb..019bab4ce8e4 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
@@ -8,7 +8,6 @@
 /* Please set this macro to 1 for enabling SCI0 on PMOD1 */
 #define PMOD_SCI0_EN	0
 
-#include "rzg2ul-smarc-som.dtsi"
 #include "rzg2ul-smarc-pinfunction.dtsi"
 #include "rz-smarc-common.dtsi"
 
-- 
2.34.1


