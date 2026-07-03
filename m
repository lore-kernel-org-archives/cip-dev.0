Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CC1C44502
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 16:35:39 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.96271.1783096535099609926
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 09:35:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=EygN1YJV;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.51, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0Gn07bg/ge39lVOOEJ7WxALxCHSiCTYXH2REfp04JURgcohCEFwqOsvWxSHF4ZzbjMRMppgNVkaJavjLEndSpWZa+65pTjGaZLoVgqNiWpLZDzxpb8xAoH+ya2tx5tHKkkaJm+1PNitNeK42tAdPQAg2iq5qCVqjON/IvmPYf11S0HlUIZCQwhS3WEc+1i0DepADKG6akAXMTl0yku2a9XOdSwetmhdySV1xgm923PD0fWMi3XLzJE/33RTmY3SrECdvEOBqOi4k/sTkaWJjQ8WMmCtOsqXB1R7NQtzAAlqmamdTP5vD8rNzAyQ1/JFxzAt6pQ25V4ZbMzDMfHXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb+5Ks39rUZ/mqaP7LOl54IXtxsHXOS0lKWZSbnDtj0=;
 b=BgcGCufIxd138AuhlBvBd+8pFtC24UoQBZPp5ftFcLrnyDryrar59TQN6ZsRQM+vaVqtLR9qdrh15a+QAZMjihcEKG7V+stoTFpzWeoGYTc1PcDseFjE/PuuV0t6l4LHcX+7jcr0U/2yE02Zp015TomUDI8SQlYonk0E9K295SrdjXO7TdydBa2ZNW3m2/qOb3K8JjkE8VpBhltPjNVaqlwBBCPQv5eXHOZIkhi0f8JsQzqOYhJaCkGgNyst5r1tELDLdRF7+NORFzKmF4B0u7UvLW+NDpo1a8H5uGnNP6NyLfPlQsZynJcS0EXVOXbooucAaoh6oHhBCX4KMusKWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb+5Ks39rUZ/mqaP7LOl54IXtxsHXOS0lKWZSbnDtj0=;
 b=EygN1YJV7eYvrNdoI0tUrYlLXR5rpancQ8ltoS6Y+bN2CbSZTVAY1LLUuaNm0JBQ4KCQYKnOzvbMIrIDwH7o4ZpWn3/u+MAdERqc0+eU4rplf67icFzN6T/5ZUNYQ6QPxyxHnW8E5z1LbdfnpapKhxxThV8XB8lWp9QtxRR/9oM=
Received: from TYWPR01CA0004.jpnprd01.prod.outlook.com (2603:1096:400:a9::9)
 by TYCPR01MB11052.jpnprd01.prod.outlook.com (2603:1096:400:3a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 16:35:29 +0000
Received: from TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:a9:cafe::ac) by TYWPR01CA0004.outlook.office365.com
 (2603:1096:400:a9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Fri, 3
 Jul 2026 16:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF0000501F.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 3 Jul 2026 16:35:29 +0000
Received: from Ubuntu-22.. (nld-5cg2234fz3.diasemi.com [10.24.0.5])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 4EBE2300026F;
	Sat,  4 Jul 2026 01:35:26 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 4/4] arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable PCIe
Date: Fri,  3 Jul 2026 17:35:15 +0100
Message-ID: <20260703163515.35831-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703163515.35831-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260703163515.35831-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF0000501F:EE_|TYCPR01MB11052:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6d4ab963-3b3a-41ed-4a51-08ded92117f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	/Bku3GaT7JfI/uKwlCbXE0wmjYNc8tr/SqVpfbBC8vfD+FVb52wxCTVY4BOYmIYprOZVVFjS59RUogfy46YC+SbBqX5/kPeg/nW8LSUY9UF2vY/6IHiFuUFcMpi3BtnU5Zxvcl94hTacpXLUS/Hj1tTHCthzBrWAqfmH3yN4E8ffLjavtdJFtTa9XkJf0iTAZFyu8RwF6llEaLlMMH7csMoC1s8n0nhRpbiPmuNN41VpgBdufLyS4LDtNxMn9moHW1VeUN+d0cgL6G/oryM1HwIYPPiBVL4GY3KN/BhIER/rOatdTri8qdjSIMMj2p9dxOUC3x2EJX4vragMQEP58gJQf+HipPKgCFbG+DNgzLNxe0TW2CL2ECKKDzdyw/9W3MJ7vv8tlZWHWQ1KCEkcjuyuZMDA0PWRUa5cNGdL7fy3tBVhMlgTaLWX+OBIHyOHc9xyyaZxNoeLJ05lyCYYzAuDcIAPRZ8EuI7r75LHUs88Jj24g4/gLx5AtrNH9d7u9vYedRGSZezsoO5PKJ7LQLgK6tdm0amub4qaE8uWyp3/BtHuuLPQGuvBvgBO2HCUv1GqPsO1/vJ5skdLoTxuBqFZx1N0Yvxk0GZ5kzEV7zxOKFoMzVbr8zkubIJ5jcoSzUc+KY1KA5BXzFe/SFT/TA==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	qGXCqu4YmSzKCTQGPslzFNxSry7GSR/h+HyoxRNRQUMW5oGWT0I8zpqr4I5e5MgRfCicX9Mq5ekybkqO9nIvnFod43gkHo+uKGvkiaCwMkgOIzf4NedV6oe5yWQ4XwzOAm7kbYr9KYpUqbOLG9vb0n8ilrJeLO4AN7UcIO6BL+WCjElNymM5RE0DQvSDqOfrzkdzaa+et/z4RRfvhYaRC+VBj2Wrnb4UD0nQKBNfooJYQIpvFdnyIB/sNrpzeL27tb1LMA0aruwRwwToNnrau2wCgXi8053awKLy/llRkGN2j5wKYz4BFOUVYNnG1dX3G9nGwR59L0Hl2vMb0MzhUO8MuoBQWOxYtMnFsCqjEOeOFN2DJFTo203WaCpn+XMUHdJwmyx7txcn71TG2M3D5izEtXBZkKb0Fw2P5n8Esx5fqyouubDP34p78EwKlw9h
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 16:35:29.1727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4ab963-3b3a-41ed-4a51-08ded92117f4
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11052
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 16:35:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23452

commit 62169c13d85c143174b61876ff60328b838e02b9 upstream.

Enable the PCIE1 slot available on the RZ/V2N EVK.

Note, the PCIE_REFCLK comes from 5L35023B versa clock generator, once the
support for this clock generator is added, the fixed clock node can be
removed and can be replaced with a reference to the clock generator.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260501105116.33452-3-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts b/arch/=
arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
index 6ed74e091d4b..38c9a0489f85 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
@@ -63,6 +63,12 @@ memory@48000000 {
 		reg =3D <0x0 0x48000000 0x1 0xf8000000>;
 	};
=20
+	pcie_refclk: clock-pcie-ref {
+		compatible =3D "fixed-clock";
+		#clock-cells =3D <0>;
+		clock-frequency =3D <100000000>;
+	};
+
 	reg_0p8v: regulator-0p8v {
 		compatible =3D "regulator-fixed";
 		regulator-name =3D "fixed-0.8V";
@@ -318,6 +324,17 @@ &ostm7 {
 	status =3D "okay";
 };
=20
+&pcie {
+	pinctrl-0 =3D <&pcie_pins>;
+	pinctrl-names =3D "default";
+	status =3D "okay";
+};
+
+&pcie_port0 {
+	clocks =3D <&pcie_refclk>;
+	clock-names =3D "ref";
+};
+
 &pinctrl {
 	eth0_pins: eth0 {
 		pins =3D "ET0_TXC_TXCLK";
@@ -368,6 +385,12 @@ i2c8_pins: i2c8 {
 			 <RZV2N_PORT_PINMUX(0, 7, 1)>; /* I2C8_SCL */
 	};
=20
+	pcie_pins: pcie {
+		pins =3D "PCIE0_RSTOUTB";
+		slew-rate =3D <0>;
+		renesas,output-impedance =3D <2>;
+	};
+
 	scif_pins: scif {
 		pins =3D "SCIF_TXD", "SCIF_RXD";
 		renesas,output-impedance =3D <1>;
--=20
2.43.0


