Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE042C44500
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 16:35:38 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.96270.1783096532899798849
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 09:35:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=vAOCmDXU;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.6, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlrBmUUZacxwOy4+PVhp1YUS+V48XdB1Ske3L+Mx/wO+VwQSJj8nx4pUs7s6Y04GYkYz6h/WlHVR017ypBigchSVylK5WIldn77pKj2OTvfHIB4HstridlRRhnkTG7L9umtpHkqRA+zNVEiFMePVHRyi8oJ2d7/wcJjUPq7WrSuOIfxyC4F2knp/uu33kou9JKpv6dxM41bUrW5Q3PSITjtyi8VmGJk9CBHxCeZnAOYThjzSWy88W3XYjpgxh6i1e+uVMa4jRobp3vkYZvgWu9Mu9oEhy/wWZgcv/+cqiz+vh9y/chPMiWM4xxAzxPtkBMfh3lLlR08DbgJ7x7XF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxgbW7KppcZacz2eDGnSM//03fLKkccRcgPnu7RiwIo=;
 b=LCEc6nrvde/ONMHMRpwGEfzp8SBnKSvik5s/fvNxJN7aal7bqPV+0IF1PHOn+Z5oFmH0y7RhezUTiJUz/Xf7Xe6ouWsphgQLdETb2C5M7cyP+iFZ3sPYTvKPpxn4atqMWznSAwSC72QoiWECF5oi/y67/qFKYSOD2IwOuNL0QinhT7LURaoZ7idtchuzyFzBEiLDvcuUwUoONqt2ISRxr6gVUMOcBZBdDHzMacEKXvGi26ftHKYzAOJNcjvRgAOfdG9gjSFVrh+Y0qdzY4vz1Ejkcxu9YCnPKxJ+sb9mqvq882c2D3VjBKMuCko7vnapBjS5Jmi//QYLVZrAqOjW2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxgbW7KppcZacz2eDGnSM//03fLKkccRcgPnu7RiwIo=;
 b=vAOCmDXUsNMosw0GOusGeqG6H6mXgmRw43qy6CCz1iqT1jS2KjeVNOhWQwtKtnZpOTx6qAA6DrwE8W2GhwQUtLPKTRDCYAgSMzom0YNS84ffdww6tBChSM06kTXYENHDE1Sadxygcu+DIntbD3s2bjnZWr0I129WVAUnmumQSgY=
Received: from TY4PR01CA0089.jpnprd01.prod.outlook.com (2603:1096:405:37d::16)
 by TY4PR01MB14610.jpnprd01.prod.outlook.com (2603:1096:405:238::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 16:35:26 +0000
Received: from TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37d:cafe::8f) by TY4PR01CA0089.outlook.office365.com
 (2603:1096:405:37d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 16:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005624.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 3 Jul 2026 16:35:26 +0000
Received: from Ubuntu-22.. (nld-5cg2234fz3.diasemi.com [10.24.0.5])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C895F300026F;
	Sat,  4 Jul 2026 01:35:24 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 3/4] arm64: dts: renesas: r9a09g056: Add PCIe node
Date: Fri,  3 Jul 2026 17:35:14 +0100
Message-ID: <20260703163515.35831-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703163515.35831-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260703163515.35831-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005624:EE_|TY4PR01MB14610:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2d0f777e-a95d-48d7-2ac4-08ded921167d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|20052099010|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	NDiQdUSiECiQNFBqG81i63wn0IN8GZeOK4e8E/2UBolufAXzh8EndbbX6ZGfe0YYDawvbFV936fkSbtbXu3GYJk45kla8NEf0JC4X96yaAI5xdGnwVgGLmexqva+X+OjW8lWVfprGVn/AEb0N5xilBcazCm8MCsWuA9cKNxwjiSxybWbt5G6Scgi50Knq3JZ7VdJfnRfOFior/OkEdDMj4LFjR3Vuxz3whPOlYsOLQ/NwAS1u6rWfqWWhtpq5Z0HqASBe/CEEreSqCTO9wSbi5fWQaL4Mn3WLS5U6GIBzYlZABWqUCG8fd03kqRhZCMwSgmbT6wiCG8b+VM/kz3KY+U83FCbfnVY/xNRJpA88ZnuQyEDL/EwmZvnuf1F8Ku5XLHiaARpuP16fLShpwZTAHi+ynRjH0queYuZ43j/ZYvkCDIMQU7xJqnAAPd9a5lKy6o2V6HtGydlidBg7Vj8lkGFZub72GziC1sYK5+yv9SGYiL6NK6dLiJeR8s/+/izO58PgYuzkfdF1TVqa6SGD68jCotDVG3ehj9rEQDsbmmssaovXDGN4mBGMlhP0uGJfvQsLRGgcpTcRm4Q4kWJSxDCctgU4jGLFNeilrroK56uPSi2PtoKpoCi0ddsGwaEvTBZpn6F9WZILE+iJUU0UHg+iO+5GjQ9TdaN0Uz3PdA=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(20052099010)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	FhFGbbo0+uIpzpWETAw0tRGDjekx5Sf3kaNWNXsLnQslmiW0IuvI4XGjTSz4Pqppz1bZNumbpd39g5iK5Vb7xtYAJtaqi7+O7h6TcKOc4Dwln5KNM3LrLPRnIv7KTRbvu6c1RVgKlrp5ZZMZYk+Wbjcp6LXSEOU9ZTzU6e8DwSv2YH13xZc2/QX6ZWN3X/ltO5BU4MD35s5o4XnWU8PZceV4BSNT+wSXJPn9mZKQX3LvawIbCr3mQQjuKhbG2Wt1f325SbaLKvHZEnp4LMsEbXh1xxFvTP0sO9dDBPRQaHJxiGZ7R0PA7715IaRa/tWIz1CdcDT+7NYKDK9Ett2FdYBC09Hslj5GjDBSCF0l059pex67vdZK9FJ7/12SYVNrmqmS21LS4762o1HOASCaYCdrQYbbBNWrExiCEwCTfJNQRey14t+/u/ihWFcbXbCN
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 16:35:26.7121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0f777e-a95d-48d7-2ac4-08ded921167d
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14610
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 16:35:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23451

commit 4c443296ff17f5670ce926f47de8ec5a1f50f857 upstream.

Add PCIe node to Renesas RZ/V2N ("R9A09G056") SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260501105116.33452-2-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g056.dtsi
index e312dd1d7ac9..9a244145c60d 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -779,6 +779,75 @@ rspi2: spi@12800800 {
 			status =3D "disabled";
 		};
=20
+		pcie: pcie@13400000 {
+			compatible =3D "renesas,r9a09g056-pcie", "renesas,r9a09g047-pcie";
+			reg =3D <0 0x13400000 0 0x10000>;
+			ranges =3D <0x02000000 0 0x30000000 0 0x30000000 0 0x8000000>,
+				 <0x43000000 4 0x40000000 4 0x40000000 6 0x00000000>;
+			dma-ranges =3D <0x42000000 0 0x40000000 0 0x40000000 2 0x00000000>;
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
+			interrupt-map =3D <0 0 0 1 &pcie 0 0 0 0>, /* INTA */
+					<0 0 0 2 &pcie 0 0 0 1>, /* INTB */
+					<0 0 0 3 &pcie 0 0 0 2>, /* INTC */
+					<0 0 0 4 &pcie 0 0 0 3>; /* INTD */
+			clocks =3D <&cpg CPG_MOD 0xc4>, <&cpg CPG_MOD 0xc5>;
+			clock-names =3D "aclk", "pmu";
+			resets =3D <&cpg 0xb2>;
+			reset-names =3D "aresetn";
+			power-domains =3D <&cpg>;
+			device_type =3D "pci";
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			renesas,sysc =3D <&sys>;
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
 		i2c0: i2c@14400400 {
 			compatible =3D "renesas,riic-r9a09g056", "renesas,riic-r9a09g057";
 			reg =3D <0 0x14400400 0 0x400>;
--=20
2.43.0


