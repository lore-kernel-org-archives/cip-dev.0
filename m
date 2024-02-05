Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A977EC4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 12:43:16 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.61950.1707136991311154909
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 04:43:11 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,245,1701097200"; 
   d="scan'208";a="196827790"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Feb 2024 21:43:10 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4D8E740065B6;
	Mon,  5 Feb 2024 21:43:09 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 45/48] riscv: dts: renesas: Clean up dtbs_check W=1 warning due to empty phy node
Date: Mon,  5 Feb 2024 12:41:32 +0000
Message-Id: <20240205124135.14779-46-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 12:43:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14714

From: Conor Dooley <conor.dooley@microchip.com>

commit 7a98d75c4a63a90e81178170b748512e7a23417d upstream.

dtbs_check w/ W=1 complains:

    Warning (unit_address_vs_reg): /soc/ethernet@11c20000/ethernet-phy@7: node has a unit name, but no reg or ranges property
    Warning (avoid_unnecessary_addr_size): /soc/ethernet@11c20000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

The ethernet@11c20000 node is guarded by an `#if (!SW_ET0_EN_N)` in
rzg2ul-smarc-som.dtsi, where the phy child node is added. In
rzfive-smarc-som.dtsi, the ethernet node is marked disabled & the
interrupt properties are deleted from the phy child node. As a result,
the produced dts looks like:

    ethernet@11c20000 {
	    compatible = "renesas,r9a07g043-gbeth",
	    		 "renesas,rzg2l-gbeth";
	    /* snip */
	    #address-cells = <1>;
	    #size-cells = <0>;
	    status = "disabled";

	    ethernet-phy@7 {
	    };
    };

Adding a corresponding `#if (!SW_ET0_EN_N)` around the node in
rzfive-smarc-som.dtsi avoids the complaint, as the empty child node is
not added:

    ethernet@11c20000 {
	    compatible = "renesas,r9a07g043-gbeth",
	    		 "renesas,rzg2l-gbeth";
	    /* snip */
	    #address-cells = <1>;
	    #size-cells = <0>;
	    status = "disabled";
    };

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230712-squealer-walmart-9587342ddec1@wendy
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
index d6f18754eb5d..c62debc7ca7e 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -22,6 +22,7 @@ &dmac {
 	status = "disabled";
 };
 
+#if (!SW_ET0_EN_N)
 &eth0 {
 	status = "disabled";
 
@@ -30,6 +31,7 @@ phy0: ethernet-phy@7 {
 		/delete-property/ interrupts;
 	};
 };
+#endif
 
 &eth1 {
 	status = "disabled";
-- 
2.34.1


