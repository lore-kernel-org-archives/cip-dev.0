Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DC3C44501
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 15:28:27 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.28])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.95654.1783092501813350008
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 08:28:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=InI4kH4h;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.28, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQm/ISo5jwkmhGlgwnuyKnk0oS4D/7sk/yWYA5un4v7YeCIF6rBYWy6lI/WzGqBiXYwOjIDx8cA8BAobjLAW7LmleCTapOVuMVoVqHspiC6k6o0ZLrh2UV6JWxtX0g0YE9DNy06iPdUYJWfD1QwY6/iRj6U9t5OqOHIi7HGjR/2xqq5co3ifhN91OUEp9KISEeDhHyKIk8Z5RDtu+NTV1HwobAYCLbLLVCgDKaQYyvM9wXCjlQtI7HXrT0ixPK8E9u0/TrNbB0hI24eDzFvTULmNBOk2zzitUl61v6CZRx+2cCWepAj9xtuMANqSs0fiqDLppdJeJ0yDPlqwz7kgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb+5Ks39rUZ/mqaP7LOl54IXtxsHXOS0lKWZSbnDtj0=;
 b=DLtrkFqiq53DHGjZX4B+84lSwl1s7sT7dEdoGYdpHSQ44Ih+fv1S1M8gc34owStIgfp0Ou8xWG7kkZnLrxip0ZnTR8F1FsTwibEUSaNGQUwsyXcZX0aMPI1BlR2z6xDwvwpowP62BP4YewZWTHhLZo5jcFDMj82rPX7dQe+Rs+rmS3gos1vNigOqbc5jgKuxEQ5lzohNN9oLdhPnuWauQhWD6PT9TipF3VhbHup/QCsRdSit8Qyr58UEynpq/KmwT3LEFh5pVE2keftMQAsI2t18xyQukOH+V2vJdy+UtJrCNCbrjZNkfzZkbT8DmXcmnasUoHznLuuD0eXFSGb+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb+5Ks39rUZ/mqaP7LOl54IXtxsHXOS0lKWZSbnDtj0=;
 b=InI4kH4h3hqiY9DvWS8BFsQX3KMUFMHiIay+4VkzKrqw9pGLMNzI4t7bFJIKtAba8y0bqTXEyUaGe1G7lzBQbYCJCL+Pn5hpA/aXGHAMzIPwc/7ogEz23T/dgM1gvFyXwAvP/o9GGiEStTEUAQW1e4H2V3cHKAJcJ4BqCD3qDvo=
Received: from OS7PR01CA0225.jpnprd01.prod.outlook.com (2603:1096:604:252::20)
 by OS7PR01MB17264.jpnprd01.prod.outlook.com (2603:1096:604:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 3 Jul 2026
 15:28:17 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:252:cafe::78) by OS7PR01CA0225.outlook.office365.com
 (2603:1096:604:252::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 15:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 3 Jul 2026 15:28:17 +0000
Received: from Ubuntu-22.. (ukr-5cg4053kvs.diasemi.com [10.24.0.5])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 46C2130002BB;
	Sat,  4 Jul 2026 00:28:14 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 4/4] arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable PCIe
Date: Fri,  3 Jul 2026 16:28:03 +0100
Message-ID: <20260703152803.29302-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703152803.29302-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260703152803.29302-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|OS7PR01MB17264:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7beb52a5-cffa-4a4a-4bf6-08ded917b4bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|11063799006|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	1i+cPNOviWZThRzyxT9KXTisqSZoWYxmEkCAsuDteat6NLnnW2q7hHjgz8A9pklU8ir+QI83unCzKSjUanCzx/ohrkJfcvWGRF1UecsV3NJFdJpPb0+SLmLOIoB18Ztfjxg59Crrb6nARlBU7ln6fBFDaGwwxJUVzGFxKePBonpX5+2/gK+7TUM7HOLV/DO7s3/hPqehiuCUsDG66fpvjiw/N3w/MJauX2qiu7P8tCY5LKJ6J3NyO7wm9EGDaYdc7Y6jhiJ11kPzcCQPo+YfDLz+TZ0zuSRgkiiVhFzhJBStBCwUNIZ4DMSv2vh11T7rw87ZwewY68wBMww6kp1ZwFyJA1+dajSsyfHpZhsxQzZDYnYml2kQSFXLDK4xrvvCQudZW9Y8/doDAxcRmSsWIP5qBGYaPjzvOd+ePr2HTxA9FBWnX/y36l3pDnrwYZpE9g24RdKHvkmiI00VOYLRGfoFdAmaDjr/RkV1iBwTvQvdNI/9MNXAREl8R8VKIygXfsktYKg8anybUyVEmZVnMPuBP0QdnFZ9YpdSgJF/QurIDHXbLKq4/eFFvUzRaOwEbUMkUJ4sal9vS9MBgmB38LeWsYDggZ2Ggby8LPlOeoxOukZRb8BiOesQAed6e7TXMSeVt1yVGpT6/1blkj3yWw==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	IdqmAIB4fFdRzYJdhvpqKuSueK6HHldX/rzArZmuCRMTI0hGjpoScvJXRCkrH50yLfRwEjggI/iC6Evo9gdhqBJvRrqpYv6LF0PFK/89PA7WYx+h1vu+RA68nf9vM2fMfXcXwJ0d4KvLVpoLELTvPR8pYzxQWF/ajx/GwWzOuGbP2JsDoiV/S33ojMM2r+mtAXWnXdnXGQGs20yxfhQJ3/WzRWJ/XnByKw+MIwU6Al3NGy5Ke7mm1iw48VG9quJBsvSbsWHkq68DZzZwRTvgXyRWsqh042i26fCQqRgVsGqLnYnMzkVjs9klwWB5gklBqIxQyF3vn2e7RhGW+ci+QkBvmWXNYkjiKac/VhlnTr/kxg14TWH/COyIpcSXC0dHWduAWlqHzSGd7HnGogZ716RHkyTkbOjDeUo0zd2NdFzf52XD2KEi8iI9EgaHeseS
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:28:17.2195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7beb52a5-cffa-4a4a-4bf6-08ded917b4bb
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17264
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 15:28:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23446

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


