Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12036.1793624554635342451
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 05:02:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=orwQ8a+Y;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.9, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDmiXVZf2tqdBHevLVeVwbyeezgsq9l/gMXh9rBMDPzEN1mqo/rQ/+jDRFTpJnmqs3AjEd8QJOkrfimP3Ez4oW+NRJ2wnpJ00znQFjOyWGduto9i61SSIz8yvUnM9PI1tPmgIlwxfX60EG4MZabuMqspPqVuCOyTuouhlxUtITTpwosXqw2vJ7sjwJLJZO9gyDLypZZllptr5SKQRHusc/qOM8yqO/5WEAoM+/UhE5On7pD12BQX9kW0OvlG4IBO91epoRwWpJ70ZByP8YRxzuT+qsYiHXiQw435mzJ5vG2gFTnXtdxzfUp2dKFgK+bJLUp6m1h/5eCP4IMQGwK4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bgF3XZjWEcvQM81ENOgrN2N/hXw8fzzVQ4p6/NXobI=;
 b=dnjWgn5lj4NZlk93scKdY+6NIoA1HrVqkzRNJhdzQFiwzFEUkWlTlj+4DWAWnKVL2/KNjF3pTT6IlZy72Drf1bkZPH8BwIEjGvRGfUxld+s4rlYcIK4Fia24Fb5V1wHXt3lDkKSavPnK7WOp0YaVn3gGgFyPyU8PaC+ol93xDz0vAGcEE6xtQ6vRRISRFnqeGzWhHNx2i/YtOsc+3ZN5klPHuG2CvNE2oo+ckVvtyzpZsTLR1P9H+qj9Mf4miAl8WfQhg1NWqv1K+yu1kB2rTpgAhvyH2SiTHcR4XNC3YUx1fkUo6Bs5Jin13/ruWR7so3muhYn+9HjMQ1HcovtXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bgF3XZjWEcvQM81ENOgrN2N/hXw8fzzVQ4p6/NXobI=;
 b=orwQ8a+YiS1J7UESM8iXy/HtnKh83WdPJNEE9uF4QHs+jzUqz1GrhtOxzQtYBisDeRN/DyAQ2FpPMnpZG+JXZbij0jtFH1TQ6SdkEks1wh+85CCnhVGgw6SlFXveBWep2ECI21BX9hJ1aqvny3gqZE/HeCyuL40svJZBLrSTaw8=
Received: from TYCP301CA0057.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:384::8)
 by OS7PR01MB11916.jpnprd01.prod.outlook.com (2603:1096:604:236::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:02:28 +0000
Received: from TY1PEPF00046B4D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:384:cafe::8b) by TYCP301CA0057.outlook.office365.com
 (2603:1096:400:384::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 13:02:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF00046B4D.mail.protection.outlook.com (10.167.253.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 13:02:27 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 0764C3000230;
	Mon,  2 Nov 2026 22:02:25 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 6/7] arm64: dts: renesas: r9a09g057: Add PCIe nodes
Date: Mon,  2 Nov 2026 13:02:11 +0000
Message-ID: <20261102130212.8115-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF00046B4D:EE_|OS7PR01MB11916:EE_
X-MS-Office365-Filtering-Correlation-Id: a4742e30-d7dd-4343-39c3-08df38e18beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261026121527099003|261022105027099003|261026140227099003|10067099003|20052099010|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: g1W7hiLPIVlb7KfNmW2r6O94+ws2Y5JWBerxE3ZJ6IRp7zYK3LOKDAmQ1aTFGYkeNB6DJlL4B0kFC7UP1ymd3zP2l38STNoiEpzGP+tJTUmwPCcZ3up43Iasqg8//D/uv1aIzDd9zgcOhabY+z0qlZMgoBjoz6XJOUre8We3bIIy9ltmuz0UH/5ugmFjI3fNZo/lB2QrunDsjMkFYuZYUSdpbNMPR8jsVNFdwgupo/939KfTh2IebpFah87LI56LN0hfUHrPA5rqGk0EYIHF2Li19R7UBCjq3dTDgMpBzuursU871Ct15R72w1+XRc0M0B6Aap+LKqZq8dHzkoG7vTqbqqueyetK1ajTM/xrx55Q3jhU8imixYjRKQjA5wXiOtMW2F6JhI/0uyGn7AniRuLVouHsUDUH8oAZIEcPbPWqnu+72kdSN7pmdr8HWnMfUsHXU6sgrAxrD+Azbf12m0Qz1m1A4O+KwxQCFLb1j25wS3wbJgZOSNccTxuRQowF8RVIo6jpq0K0txueDKKXot/0VwxDDQk7XA4h8AmoZvP8ITA6R+7enXX7rFI/549Yh4CpETy7rcZscf747nWIswFO8TY7lmZlxIGFJI6VaCicwc9WkhGcKZquDXFjZBup+Hp0qHYuQAU1jNMIOTsq2oe9/mBdoN228MbqZriPyYg=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003)(10067099003)(20052099010)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: malievZUX4mCEHE4qqJYryzouN3KzGnT9ugLaMnVSnwTsdEKmPjm9z3dcbrNt+oKqO3V4y4vRy+0wMQzOFOjWe9W9g0rQvQx6t3n3bnCndWsg3mXppPt1L+68ecSkeK9NdQvZNeEfPg5K35G7EqVnlVnYJCvdekacebREFqUpCbzxBE4aFDjAAQcZX+K9eV8ugREidLZ0ZCRPrdx6EyERqoWdkYYcXnPyiS0yBziIrz2iMpDYJqfA3qsa73e+2JLQJtqUE1Kww5EImxITmQ7Y7RCdASglzL2tHfksn+hpjx6lZmEmxRLk6UiOraD07Wu5+YkdUmAh+sda8gwsbhR2kheEnsf+UXSDoCMUaBQg+K3m912B/yFnqdpK75moAQ4YgQ4zc8R1UAcCnG3zMfwMT5oS9HITRB1qSeboOgf55auRPovjUwLXsNWziVJHSqg
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:02:27.5634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4742e30-d7dd-4343-39c3-08df38e18beb
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF00046B4D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11916
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 13:02:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24616
Content-Type: text/plain; charset="utf-8"

commit c73b080d1d1bf89775d69f2e249820e3e242814b upstream.

Add PCIe nodes to Renesas RZ/V2H(P) ("R9A09G057") SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260708163311.222176-2-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: manually applied the patch.]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 140 +++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g057.dtsi
index 4f81f6d9222e4..8f41d30c41613 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -767,6 +767,146 @@ rspi2: spi@12800800 {
 			status =3D "disabled";
 		};
=20
+		pcie0: pcie@13400000 {
+			compatible =3D "renesas,r9a09g057-pcie";
+			reg =3D <0 0x13400000 0 0x10000>;
+			ranges =3D <0x02000000 0x0 0x30000000 0x0 0x30000000 0x0 0x08000000>,
+				 <0x43000000 0x4 0x40000000 0x4 0x40000000 0x6 0x00000000>;
+			dma-ranges =3D <0x43000000 0x0 0x40000000 0x0 0x40000000 0x4 0x00000000=
>;
+			bus-range =3D <0x0 0xff>;
+			interrupts =3D <GIC_SPI 800 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 801 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 802 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 803 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 806 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 792 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 793 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 794 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 795 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 796 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 797 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 799 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 804 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 805 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 807 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 791 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 798 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 808 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 809 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 810 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 811 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 812 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 813 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "serr", "serr_cor", "serr_nonfatal",
+					  "serr_fatal", "axi_err", "inta",
+					  "intb", "intc", "intd", "msi",
+					  "link_bandwidth", "pm_pme", "dma",
+					  "pcie_evt", "msg", "all",
+					  "link_equalization_request",
+					  "turn_off_event", "pmu_poweroff",
+					  "d3_event_f0", "d3_event_f1",
+					  "cfg_pmcsr_writeclear_f0",
+					  "cfg_pmcsr_writeclear_f1";
+			#interrupt-cells =3D <1>;
+			interrupt-controller;
+			interrupt-map-mask =3D <0 0 0 7>;
+			interrupt-map =3D <0 0 0 1 &pcie0 0 0 0 0>, /* INTA */
+					<0 0 0 2 &pcie0 0 0 0 1>, /* INTB */
+					<0 0 0 3 &pcie0 0 0 0 2>, /* INTC */
+					<0 0 0 4 &pcie0 0 0 0 3>; /* INTD */
+			clocks =3D <&cpg CPG_MOD 0xc4>, <&cpg CPG_MOD 0xc5>;
+			clock-names =3D "aclk", "pmu";
+			resets =3D <&cpg 0xb2>;
+			reset-names =3D "aresetn";
+			power-domains =3D <&cpg>;
+			device_type =3D "pci";
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			num-lanes =3D <2>;
+			renesas,sysc =3D <&sys 0>;
+			status =3D "disabled";
+
+			pcie_port0: pcie@0,0 {
+				reg =3D <0x0 0x0 0x0 0x0 0x0>;
+				ranges;
+				device_type =3D "pci";
+				vendor-id =3D <0x1912>;
+				device-id =3D <0x003b>;
+				#address-cells =3D <3>;
+				#size-cells =3D <2>;
+			};
+		};
+
+		pcie1: pcie@13410000 {
+			compatible =3D "renesas,r9a09g057-pcie";
+			reg =3D <0 0x13410000 0 0x10000>;
+			ranges =3D <0x02000000 0x0 0x38000000 0x0 0x38000000 0x0 0x08000000>,
+				 <0x43000000 0xa 0x40000000 0xa 0x40000000 0x5 0xc0000000>;
+			dma-ranges =3D <0x43000000 0x0 0x40000000 0x0 0x40000000 0x4 0x00000000=
>;
+			bus-range =3D <0x0 0xff>;
+			interrupts =3D <GIC_SPI 823 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 824 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 825 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 826 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 829 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 815 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 816 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 818 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 819 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 820 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 827 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 828 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 830 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 814 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 821 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 831 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 832 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 834 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 835 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "serr", "serr_cor", "serr_nonfatal",
+					  "serr_fatal", "axi_err", "inta",
+					  "intb", "intc", "intd", "msi",
+					  "link_bandwidth", "pm_pme", "dma",
+					  "pcie_evt", "msg", "all",
+					  "link_equalization_request",
+					  "turn_off_event", "pmu_poweroff",
+					  "d3_event_f0", "d3_event_f1",
+					  "cfg_pmcsr_writeclear_f0",
+					  "cfg_pmcsr_writeclear_f1";
+			#interrupt-cells =3D <1>;
+			interrupt-controller;
+			interrupt-map-mask =3D <0 0 0 7>;
+			interrupt-map =3D <0 0 0 1 &pcie1 0 0 0 0>, /* INTA */
+					<0 0 0 2 &pcie1 0 0 0 1>, /* INTB */
+					<0 0 0 3 &pcie1 0 0 0 2>, /* INTC */
+					<0 0 0 4 &pcie1 0 0 0 3>; /* INTD */
+			clocks =3D <&cpg CPG_MOD 0xc4>, <&cpg CPG_MOD 0xc5>;
+			clock-names =3D "aclk", "pmu";
+			resets =3D <&cpg 0xb2>;
+			reset-names =3D "aresetn";
+			power-domains =3D <&cpg>;
+			device_type =3D "pci";
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			num-lanes =3D <2>;
+			renesas,sysc =3D <&sys 1>;
+			status =3D "disabled";
+
+			pcie_port1: pcie@0,0 {
+				reg =3D <0x0 0x0 0x0 0x0 0x0>;
+				ranges;
+				device_type =3D "pci";
+				vendor-id =3D <0x1912>;
+				device-id =3D <0x003b>;
+				#address-cells =3D <3>;
+				#size-cells =3D <2>;
+			};
+		};
+
 		i2c0: i2c@14400400 {
 			compatible =3D "renesas,riic-r9a09g057";
 			reg =3D <0 0x14400400 0 0x400>;
--=20
2.43.0

