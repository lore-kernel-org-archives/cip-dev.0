Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC361C001B0
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 15:35:09 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.61638.1688484896860911751
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jul 2023 08:35:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: fabrizio.castro.jz@renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,181,1684767600"; 
   d="scan'208";a="166817099"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jul 2023 00:35:03 +0900
Received: from dev.ree.adwin.renesas.com (unknown [10.226.38.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 492DC40062A9;
	Wed,  5 Jul 2023 00:35:01 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip v2 3/4] arm64: dts: renesas: r9a09g011: Add PWC support
Date: Tue,  4 Jul 2023 16:34:51 +0100
Message-Id: <20230704153452.11780-4-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230704153452.11780-1-fabrizio.castro.jz@renesas.com>
References: <20230704153452.11780-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 15:35:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12216

Commit cf67b31904d42275e7b5eaf55c191db1925abb7a upstream.

The RZ/V2M SoC contains an External Power Sequence Controller (PWC)
module. This module provides an external power supply on/off
sequence, on/off signal for the LPDDR4 core power supply, General
Purpose Outputs, and key input signals.

This patch adds PWC support to the SoC specific device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230118144747.24968-2-fabrizio.castro.jz@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---

v2: No changes

 arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
index fe9bc7fe1701..d3af097f5fae 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
@@ -175,6 +175,14 @@ cpg: clock-controller@a3500000 {
 			#power-domain-cells = <0>;
 		};
 
+		pwc: pwc@a3700000 {
+			compatible = "renesas,r9a09g011-pwc", "renesas,rzv2m-pwc";
+			reg = <0 0xa3700000 0 0x800>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			status = "disabled";
+		};
+
 		sys: system-controller@a3f03000 {
 			compatible = "renesas,r9a09g011-sys";
 			reg = <0 0xa3f03000 0 0x400>;
-- 
2.25.1


