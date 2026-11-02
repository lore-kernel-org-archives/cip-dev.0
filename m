Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.36])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11872.1793624010250615588
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 04:53:30 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=OeOZnSeP;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.36, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSf7cgH+gJFdBpwsgDoljIBwdKzaEjkj8lIkWQDLjbCquIatiZQRyGwtU5lvqZrgNbHjqh9PsN3x022agRbFuJGB+57EFbC5bbWx+uBbWNZZ84wPWxcuyerY7ncSpBksjtyxgjSFtUkBZk3s+HBC6hDQgGSY62RV9OgE17NCxTyOXHxhh0jrU3i9sF3z22aNKiLy7uoS1pREDSQ7yVehHHZ1SwORc3oZB0iDpetvDXwxpl0/er5F1h1NrmW9ebgwu8bXkEkcw4VHz4T2LsmEfK8JQg1wsz3SYYJEcWfBUxE94pR3ID07DHz/Zi9svnVm765MsRem8/xGiiSddoxb6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqERyKKBJSnLmqKBmhSOU2ObySA3CxDk0cy7GK6Y0cs=;
 b=e+6Vq4SjM4l/6EPNO9MmyfneIUrQo4Esdg7p16NnIb7H2F3l+xeX+AzeKCynYEc+at47UKa9sJHNUjgoeWqqZ/wH+1jbwVeH+E3f9JLHqRcUrtrYhWBchSVDoap3KiO+cgzhi0a6Rxk+meYE91br4voc4CDTSRS14085zn2bzuvd0bJMr5stlff2kxOoBNLedSyJmic1M2aAIhCDtUR0Nt2sSUG+gKlzWzqXbBXkJ0+Wg5UciOJxVo5gzzzMvwH57OzgrIosBQ6wWrEDtMd3mFtOv8urmyARF1dEq9iQFduF/iHGjeEE9J8+1dCXPFrrz++AczWwHMW+3c6FodTpBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqERyKKBJSnLmqKBmhSOU2ObySA3CxDk0cy7GK6Y0cs=;
 b=OeOZnSeP31qoZ37jxVeIC65aofJASzLFFp28FN50UqdRUe9iyjGFRDqT1SexJxGS/2z6vgk1x0CH/lRH3sqaLQiOyVkKB2HT1RMpLPZYI7hvPPmA2Kp15zE5ypgEnU3OdSlhBOgqRGi4R6Ng+XMiYzLOm99//YoEPAoOBkarsGA=
Received: from TYCP286CA0279.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c9::6)
 by TYTPR01MB10900.jpnprd01.prod.outlook.com (2603:1096:400:39f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:53:24 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9:cafe::52) by TYCP286CA0279.outlook.office365.com
 (2603:1096:400:3c9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 12:53:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 12:53:24 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 57A4E3000230;
	Mon,  2 Nov 2026 21:53:23 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 6/7] arm64: dts: renesas: r9a09g057: Add PCIe nodes
Date: Mon,  2 Nov 2026 12:53:08 +0000
Message-ID: <20261102125309.7743-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|TYTPR01MB10900:EE_
X-MS-Office365-Filtering-Correlation-Id: 74535e4f-4e82-400b-7dee-08df38e04868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|10067099003|20052099010|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: DCus9RW/2w6kSKCryEPNJc37OoOcYbCF3JpIreroSRJ42jY2E588GEhXjZTETXMHbPN6nI0UIFCyE74LfC3+y+VDucYCjKQPIYHQETxGC16HGruQGhgfiesdUpuFbvDmflAOkKPJ85F2G9lLhI4eWMh0rNNHvKoTorAlpqA3RiUlZnnz6RHO9xH11LbVBu8DGRswic/Z7+EmIQnQdtOFod9BSPdiETJ9ZCKZuVa3SMER+CpD49GClYP1U5Ru2PhpcvVjvRNxbNlBqWbS/xgMenvOsgZJspc6gJM+a01ri9v6pFrX5XppEfd8N+B6oTgfeVSalOXMq0vq6OpCPSrbbEzcjbuQvsuE1+A/DY/AsLstI0IvRrKEdDFERwGAfzjkwzHK0DOU4Px3Oz2ro+/Bo5HSE7HH1YicRs1YliQy06toF2zQydpCnvKLcNoMVDYln1dhOJI8DpaDiV2hnsywEnaRxkncMrlqeJZijlFnIi45HkM3A0UHySiLPlYaZBbxmKfptCsaObhrFVhy6z1Mr1KqAQl2QKH38uBGp/gchvOzQi3jsAQEQrj77HGchJT7VauvN2DGymcFQqjfEXViSeWbmjaDRfRLVUtp9QLfAInmkA8KkdoRrhxLk0Npv8XhS5eZiJoAqDKn8jPIEGxdla3s0aOylydO7MbvaNddM8k=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(20052099010)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EfFJeHHBTSXyeTa2mpq/pdM0ihIovPcJMBIazyhAonYY0r6lQmqUlIz89eS+TLAP82GFLkoEbLnNp0Lj2nF0s8jP4xPc6Gm/NQk1As02y7II9PdYQFhvfiB17FEMGa6YhmehuF5TD1ZXSteQw2QSvzF8vDsMqdI7jyLS1J0LUcrXIleI3jMbT0TdAeKTulyhdFETatuZBHO/Hw2Y5Zi1IWoHAaoGe2r5IWJKPZRwIR76kAx5ty8dR0S37d2VmeZRD9jj0V+uHTl72QEcD86HV7MDyPDXUaHph1IxrRwe+J9ARH4d+xX7evUkr/00K8oG0YoDa86tXlncp7W9an+q1tKoeDu7zmhn/4HISO3She0rE9+ZKosswSqjA5GlMhhNiTmbbXfijr785BUc+5E+4Oq3SehWA3QpdhuC7mUfov/IYBV5GSzI8AVcy+ZBAGf3
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:53:24.8026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74535e4f-4e82-400b-7dee-08df38e04868
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10900
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 12:53:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24608
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
index d2cf6e2f7b6fc..9132d72c05da1 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -796,6 +796,146 @@ rspi2: spi@12800800 {
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

