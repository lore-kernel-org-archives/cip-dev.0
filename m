Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.26])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11808.1793624555119641856
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 05:02:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=KCOrhcTH;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.26, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKv8dGwA4Fcdu7Scg2z8gtcc9yf1MZ4NmEagjehAunTZ+rnRJOkKRGF3qFeNVwmQDC/a7c0zG7wEyPkg8usKxQKc+yy8lQZ4KDxRYhZPp/e4qinFDOFUBVwnx/2+/lstANfLAxqZ0KpHBM7YJAdd0iaoGA9QbAD9uOfukdmuFlXFZ6oAbdIp60sSZAsPxz3VZ4RMXz1sjyBHk6+Fe5QnJk83KG2HA0orNd8oanj5nu7B8SDwSCCrheYGL/69AOZ40JjtPZ6lr0js1TNKWM051NQ88TpcaW9tejr96C0QLZwSvMM658er9PUKN2xQW7STUsp1xDcwqgwyWDKffgr3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxZDXkDoD+4ioZyCiO7d8SWK0oBczEl6OlQKQPci+7c=;
 b=SqiXJwdqgCNI5yJU3thZZaVZFC7Yrmft7GnT3LdNvqVAKrosTWt6+GlmJ/rtY3P8eqRJmR8TfF9mcWarn0V68S9I7/tWIn2Rv+ler2Wta3sRlSxEJO8kCgJ1ZKln7EXl2hpIJG2bjym6U7zlO+M4PdUzDyxjuFSs0xQL+EcOV1v+ZdUeuDTs7ozEIo2eVwpXG1msT48eGjJDORXJqeWzNRU9ELAYa70NZlB+v846++vS38A8D0S6Ap1WPJt8a3SVYlsq1Znw5qhbOqKZUr5VEjRExgx+UjgxOlBwrBgSMF9DIuAffgLEQQuFDt0tXLj8WjQMqvxRj6FYFQNq6zX73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxZDXkDoD+4ioZyCiO7d8SWK0oBczEl6OlQKQPci+7c=;
 b=KCOrhcTHThKhdmw9x1R0ktBcYt6oRt1g8f7gpOBpHo3lmtJtd2+PmMkXDXdc2QZQV/hXDOe/jBZOSAlm4A2XW0vWQYFa2wqWpDQ0GPXYIh1PKfgIaIezOqm8x0rm7izUgKRJl62YwBfL0r3hLfG0YG8QIQAMB5U19Y+JD4pfHLA=
Received: from TYCP301CA0060.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:384::9)
 by TY7PR01MB161679.jpnprd01.prod.outlook.com (2603:1096:403:404::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:02:29 +0000
Received: from TY1PEPF00046B4D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:384:cafe::91) by TYCP301CA0060.outlook.office365.com
 (2603:1096:400:384::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 13:02:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF00046B4D.mail.protection.outlook.com (10.167.253.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 13:02:29 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id EB0933001283;
	Mon,  2 Nov 2026 22:02:27 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 7/7] arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable PCIe
Date: Mon,  2 Nov 2026 13:02:12 +0000
Message-ID: <20261102130212.8115-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF00046B4D:EE_|TY7PR01MB161679:EE_
X-MS-Office365-Filtering-Correlation-Id: a0722632-8cd1-454f-aa43-08df38e18d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|56012099006|261009223027099003|261021121427099003|10067099003|18002099003|22082099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: BkMqT1eb+kSH3AJp/+aa4ErDs4i4UxD4s0h6wDTdDMEJcHwWvRm7NDlW/LKmbgLhJC7Kvhm2jVnyMxnfYiYu3+mLjVfTrem6ztwYtJOJduM3EcsrJYHZhnS9I8XnhxxcUo3m+9cRLCYVQ10V2HW59ivJhoyqVpDdi3tK9ZdMb7P+1HivqYd5XkVuyMJ97GdhO7oUozG3lQ7hktqJez8azXM1rlBnimUWo/3RdEf7yhPCtCflDjl8vP2+Zf41PVEK5n4lWkhk5EQWjjrYivoJzxajTQZZ/c3DIO2IXiUxgl5Fz2XJUKbvwNliclA3kTmDj5yVGt44BzFaLx3u7aPT87kUdlq6xm9vdG/5Tnb0bCxC0+l3qSDg6ewuTXs4tTMvTlEqG6E83a2bW38x0f61VXk4cmOBOATrvz8T8+IWTD9jO8Xc/k6y9V9acTaHQ4bWxuGjJ7AE05ApYOcRKBbo+6H62BaiUH9W/guseVN3/dnf5TFMdxS2u/+qSv9uS0s3QJsn4ITZ5WMRSvv+qNsYWlG4/msnmQrrURCdE1I2fQ/n+rSwilqpnYsJ1r/ki6UHoqorOk8lij58mKAv8yhOmfAwj0vDTZ3Bsfb/m2KdwIATO1YnSnGAzoKiLx6Xtm6ANJUGgNwQTy9Jpbx2MbbC1F8oBgEXMRxWyOIX1dtNFrc=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WLqhYWU/MNNxc8skhX+WixhHLBxVJjGlK3IuyobvatY0Qjew+oiRw3pM3HOUU0JZXfnXmW96LVazdarTuEBYGoeHcVzVoMO2HfUP8elbqoiH8yjJCbk04JV3QMXLvzcIJBuLDLJdWq7mXZsbjG1WiUSKuJCR/sDTO6fsV3f77W4ryamzff3wLspCvsuTNi/qZbL9PnwNQD4Ob9m9tR+Ci68IOAvpx2tkuNsw3qk2pvocvauNuZxC44q/fV3w75GcbozIAagYp0m/js0d8S8RCqTKraowufBACx8sYtNfQxGpbK+zGY3XBEY0TasPqmFnbovvbzEK9n733WSRZguKj8XlvgjMxR4Bgf6v+4izP3TX1J9tMBOTQGR8Wo5UOm40dha4GxOcgMlv2MIuIZvYZge8g/VokpuP7nbK6/lmvyfP/g882LsMpbatw3Yt6eTa
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:02:29.4353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0722632-8cd1-454f-aa43-08df38e18d08
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF00046B4D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB161679
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 13:02:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24617
Content-Type: text/plain; charset="utf-8"

commit 90a9d595f36ba11d95568acfda641a7e371f627d upstream.

Enable the PCIE1 slot which is connected to PCIe0 channel.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260708163311.222176-3-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Added pcie_refclk node as versa support is missing]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts b/arch/=
arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
index 5540b97a4a9ea..35baa63a67b6b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
@@ -69,6 +69,12 @@ memory@240000000 {
 		reg =3D <0x2 0x40000000 0x2 0x00000000>;
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
=20
@@ -343,6 +349,18 @@ &ostm7 {
 	status =3D "okay";
 };
=20
+&pcie0 {
+	pinctrl-0 =3D <&pcie0_pins>;
+	pinctrl-names =3D "default";
+	num-lanes =3D <4>;
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
@@ -389,6 +407,12 @@ i2c8_pins: i2c8 {
 			 <RZV2H_PORT_PINMUX(0, 7, 1)>; /* I2C8_SCL */
 	};
=20
+	pcie0_pins: pcie0 {
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

