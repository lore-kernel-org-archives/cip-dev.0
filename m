Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51CDC83F17
	for <webhook@archiver.kernel.org>; Mon, 28 Jul 2025 13:49:17 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.25])
 by mx.groups.io with SMTP id smtpd.web10.81588.1753710548168415603
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Jul 2025 06:49:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=BxYCFNpW;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEPsqnnnzOve9CN5BqLFT/lk9LOi517QNGSEkA95nJO+V7O8GYKlSmhNkRTqDSrYcfLv5yD1ZOiCE5WXRM4IChWHvLPxsK0HaTKd/eWEqEKTsXOqPxbIfT8qDgSSCYXnMdD7aAH2M7c1Q+/bJY6WhSqyVQyWZ9ysZrPzAHy+K5fd6DWFPE4dHQmRxFmG+FpyYGL+Dqpvcteygs8OzcwFgZKGonUbnhapmzyRiqGe+Eey+mXOQOyn2CpKpK4zJF8eWrpPL2en3IY642tY7M9NQNQHZBz6mvY0oTr2S7zUBlwdzGIpPl2t9kFvh056hlsiU+QlobQ5a5hajahFGo3c/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i08l/hA/uH4alB/KQ1GAUBQ3BNw2wk9vIqyX7/ffMfQ=;
 b=j2u9CaViKagR2JQja8WK6h6UR1WerRDBXJptEZFettKgtkRtdDE//iGjP8dMD6qNaI8Qw8h8l8Kjz0lKEeTXaFp4LuIu4f8QXwKrpLktDaM/NP24YEEOlJOhBWra6aMo/8Hzt2NZw52PwSi6S9SIlPsuCPBI0FW5b42AnasPMm8Xnqgulnfn+BeYUcBgsEh1ytjlVXZIrb+TXXhsskFUVtLsCz5k06VRMlyGG/xhGfCyngOg3G2SbUUsAdcHufGQWkiHgXDc7lGE0cWEA+hEFrGCLLZsmdpG+k0YTn6+grPYp0jq4BlM/uwRDwOFI58hXY04miUGf2qgWQWrSPBiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i08l/hA/uH4alB/KQ1GAUBQ3BNw2wk9vIqyX7/ffMfQ=;
 b=BxYCFNpWx3f/dNus/TBt4ttMFEbN+wT4qNs0EX+iclcZ8Z/Qgf0v4oqPB+YnoLqeyH4rueFJPDCmTchYzOJ0dVxU9bJdXSml9qORGpf8BAgQ5BDgNkuEQaya30j9EbqH7lms+OSW0t5ad14VD3BsHdof5oxsjDzrseJmEk8Vp9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS3PR01MB6657.jpnprd01.prod.outlook.com (2603:1096:604:10b::10)
 by TY4PR01MB14280.jpnprd01.prod.outlook.com (2603:1096:405:209::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 13:49:06 +0000
Received: from OS3PR01MB6657.jpnprd01.prod.outlook.com
 ([fe80::8575:e22a:3c44:76f0]) by OS3PR01MB6657.jpnprd01.prod.outlook.com
 ([fe80::8575:e22a:3c44:76f0%5]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 13:49:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 2/2] arm64: dts: renesas: rzg3e-smarc-som: Add RAA215300 pmic support
Date: Mon, 28 Jul 2025 15:48:44 +0200
Message-ID: <20250728134844.1288347-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728134844.1288347-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250728134844.1288347-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0150.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::6) To OS3PR01MB6657.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6657:EE_|TY4PR01MB14280:EE_
X-MS-Office365-Filtering-Correlation-Id: c34e4971-c01f-4170-c210-08ddcddd84ff
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?E+2FoNOY6kdIlrlEYobSAW835/EjN4qaIMMXCU7JdVyPl3s1qoBkdpgpcLlu?=
 =?us-ascii?Q?gT0XV2Xo33SnPB+CrsiFcR3G0BaTKa1c4QBbnywk98pS1xiTuCsIJMDAkA1r?=
 =?us-ascii?Q?K6IegnFXb+34GSj3WEYswwR4afmWSws75+8TOe3s4szy9JvkGrRfdduGX9v9?=
 =?us-ascii?Q?+dXULhO9enu376D54PodZiAmJF5qqII6rL1BJdmlz/1KBSmIAr7I7zz8zmrF?=
 =?us-ascii?Q?r/UX4RohooBPMwh+iqC7/0FjhKdS8kKsSwgYLtCN1Ec6xBK9u7qqZ4u1XDu7?=
 =?us-ascii?Q?2yMWewTQTjbCDtCwFN5IiMSt0OwGg+gnlTHVvBlp5Gv1vVPYGmI/t4n9MJXx?=
 =?us-ascii?Q?VYwL0pi6X1yYwz7jatvsA2K8IVaSdr9v61pDhxm88Fgc+fQC7RVMy9ICr3fn?=
 =?us-ascii?Q?zNGycYSkPtfTf6Pd73v1+A8KhWGyptcp6CklHjdQ4sS+ILYbClBw4m2Upvqt?=
 =?us-ascii?Q?Fgrw7ew9Wsvf8f8B2J9RG5NADMOv/EIIr0REQ5yjsEgf+J5Fmskrd+gXJvVt?=
 =?us-ascii?Q?euv0GdjTubAZXbVXbt4J688zE6g6H5AzJjehai1iIK+35yLCHKDH2wy9NKP5?=
 =?us-ascii?Q?OY7/QPJKfnP1pKm5UvFyDJn+OplGiM4Ltcu9mbJJJhNtu/LADeWK0WDKEyFj?=
 =?us-ascii?Q?77vY73NcB6diiORjBANazAtdm6S/unITwCZv7pRC6s5m/Ii6c/LybPGz6S2N?=
 =?us-ascii?Q?af4DRht5gOMovKBNnioZdA1tOUzLEpmYQiXjld8crG7wkWMSJWxyAHlNIYGV?=
 =?us-ascii?Q?k6SuTsbMwOhstL3wdgKa7ZhYgRbS/Z3O2ZiG+6WW2eQybL1udd1AFHmmuLXw?=
 =?us-ascii?Q?FaQ8UVFqeuMxwYzvr4Ux+Ca6cz5KaiRwpKKNEhJw/+kmMmsi4nEbsU9Ke6Ii?=
 =?us-ascii?Q?DzydFFL6Kwloz8fHxkqb+p+CrYRGGM0sAyLs0f0DqelpD+Vvs3R4NkeNVkhn?=
 =?us-ascii?Q?O0TXTiIlOpQQed2pxXRThN4kdQAXTy0OtqCNANcsde0ZoelvbsEeDrztajyh?=
 =?us-ascii?Q?QWO181NVUU+mG7xUFBDxZj2cMu+qglwxlukBZKwM4u4dK+Wnvui0NxBIwxjn?=
 =?us-ascii?Q?3cJg2hV+2oyvCT+QfpFhQWFjGQ/khVH4igkKosvC5vnrz4r1CJMkgYokY6wp?=
 =?us-ascii?Q?OJ/Xfhs6CmhvBY4VYqOAV/PYjWS208Gycsc0almGtpoNWE/ANtw4eWi9i7fK?=
 =?us-ascii?Q?ixceZcBa+vgJpMIma32rWawwBG18GhzNao9UnEnxwFob3C5WHM8XLLY0h3qx?=
 =?us-ascii?Q?2+yP912SoxQdQGNvlUDXGw1v/5iWyKxvdPV+mgIawFaEQ2sicixYli4gfkD3?=
 =?us-ascii?Q?mm8sV6Cz34qVHPbj07dmd28V80+pseok6JVAi0mbqXZW9vVYEUsgKRFHdT6e?=
 =?us-ascii?Q?6ZGJKOSzdP7L1I9jQof+P3km8YvnLkptDDpe2dZq9NgOFixz4bHZe3zBzLUO?=
 =?us-ascii?Q?7JUmUHcJKENsxKRxGTh4+XEYKu4yjLB1pV1aNjAaJ9IUvEW0EyZDVM3p/iYl?=
 =?us-ascii?Q?cqi9akZEGCkVByk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6657.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nbcRWw6aqoYxnyt/1U1Xhp2KirZCu8RbiM3lrWxN6ccwAtKUAjyHELb8AAUQ?=
 =?us-ascii?Q?fusVngRg7Y8kF0yPsvqla/see6TyDYCFdKkwIQ8VXTqO/DhJ86jYf3plQwi6?=
 =?us-ascii?Q?svYMsUjbR6CubLAftwhFSVkRhT3NYMmnYGaRYYjRejUY+TWIbzOU9d7VkCma?=
 =?us-ascii?Q?BFoBJPIPzIpIc5A6ZVYFDORztcHMMfUioyY/CtYqDROEhk1uBjHpN74rBHmd?=
 =?us-ascii?Q?5+v1wNKEgTS8XoBPNK+SBdNjQgwhoPwvkvyr4x5zAuvMYexaAl38kdkLog4e?=
 =?us-ascii?Q?5EhRfcrlfRzZiyolQI6lDZ7yRdY0cV3n9QxxXhqa9lCVaIar0NQgWwuFo82T?=
 =?us-ascii?Q?b7oGkiezpR2Rr2gStlQgYZDrjRPwphTQDQ7p6xHZTHYqbN6OXfATnYqZRte9?=
 =?us-ascii?Q?ppV4dASW/Ke15/cxwKzyArmkKgaqmddoSFw/htKJ9rvbHbPqfXic88fC8qYw?=
 =?us-ascii?Q?E4j3+OhEp5u7Xa0gfUmyn/hVqpValG1zkHMb7oUXFITWxp5OLWvC8H7KFDP/?=
 =?us-ascii?Q?JAShjyX3KwCJUKRfpndG8Z1T6crU3X8I82lgBqD5QjReJAq22T97bxuyLn5O?=
 =?us-ascii?Q?r2cQdgB8p6YJsMyeiKTTfS27pOPHHJAO8Lo43uYCkC67j/IEJs1wGg/s4QhW?=
 =?us-ascii?Q?53po5nNaloFweAC4LWXi8JFeZ/cuyS3+xo1g8u2qn8mI7F/o7ysAK26gTkhn?=
 =?us-ascii?Q?nANtE7PJelSXTGWn33eL6ZlOfT+0c6VTP2KtDB0VzopRACX7v/+v54Ajqodn?=
 =?us-ascii?Q?ZU1yg9jSyt3t9weYXMOZLU0E+lqznLLG97bBxssMGDILwDc4RNgx+A9fqSSi?=
 =?us-ascii?Q?E701U25qHkLTrDjbngFB3WDNTNs7tYmNbCYYZbYpp3SxQ2CCrhpabfUNNP27?=
 =?us-ascii?Q?E5DaoloUE4EfhCcex02nCOo6DzRx0vOWb1m0ITOcbyni0oXZyCrHblGS095C?=
 =?us-ascii?Q?NlkTd5SmRpGb1KDnmji+AJCOVlgUJfCexn2X7nc+S7WrfOoltXQcCwkpnKHj?=
 =?us-ascii?Q?A4SJOABAuA7e9m9LG+nDzm6jd44USAQmYlAQlUSP7ohXCq7KeoXdXFkFvQnp?=
 =?us-ascii?Q?fy+t54y6WK4fKgAB5Wnh9s2Da4PiDgjWurAkNmw4MhL9zf6zBZk48SqKXLpg?=
 =?us-ascii?Q?7GpzcFhtlqzGjbW/pDUAhKxogOc8nDPYTR3HlkYtgPjepGevs4gfOnt30jwx?=
 =?us-ascii?Q?qIkbuySFLRLYX9Y9pYn6mGTWwxehy/0/64wixLnUHRvQOAoQGHDWbkiSAadH?=
 =?us-ascii?Q?hmD6V1dc1qyxPIxOuNxg1CRm7Fnpb4nmPtpN80ksgfmgEfzE+XjFLJ/Xo4et?=
 =?us-ascii?Q?qMzHMsJfEgYJfNtdknwmrw0Wf6t9xNTf65Tw1QkC+xw2Akae0Y2v0SB774e7?=
 =?us-ascii?Q?FM0rgVM/GPERv6bSNMF2xShq4lnA+y0lySSPlq5PO2MTAuGYlUbU8EZZVGQG?=
 =?us-ascii?Q?0TbD6+Ey1NJObg32HXsMVSL9bm9EGX9eZktQkUOTsEQmuL/XmVk54r5DkuZL?=
 =?us-ascii?Q?YS3quWhDml7NF1akG8ALK5qkVskvdFtYEssfXea9/PpJZXJHSfCYiZfbj7Q4?=
 =?us-ascii?Q?Tn3gC0+5u49DDS88iRa3bwSZ6SNnTMtx+u0I32xqk3GwI/PmycuoqEoNLUXt?=
 =?us-ascii?Q?Otnyprn9PvrA5PaPq4MUZ2w=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34e4971-c01f-4170-c210-08ddcddd84ff
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6657.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:49:06.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H58GlLeYmWs4s8GAAW1G4KZ3iPbo5ah6Op02lwHOt1uxnY+pAawrZkZMyDw5jU4MhVI4UlHwdZEKMiXcJ0JDzml8nyGpyr2V3b1LcTgCGxs4+dyptp/Gpym87oWQXkdQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14280
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Jul 2025 13:49:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19608

From: John Madieu <john.madieu.xa@bp.renesas.com>

commit 5ecd5a8261d00c1eb97bbe5392c9f2a7bc1fa2bd upstream.

Enable RAA215300 PMIC and built-in RTC support on the RZ/G3E SoM module.
Also add related clock and interrupt signals.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250329121258.172099-3-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[tommaso: Squashed the commits f62bb41740462("arm64: dts: renesas:
            rzg3e-smarc-som: Reduce I2C2 clock frequency") and
            5ecd5a8261d00 ("arm64: dts: renesas: rzg3e-smarc-som: Add
            RAA215300 pmic support")]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
index d93c846ad391..ecea29a76b14 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -64,6 +64,13 @@ reg_vdd0p8v_others: regulator-vdd0p8v-others {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	/* 32.768kHz crystal */
+	x3: x3-clock {
+		compatible =3D "fixed-clock";
+		#clock-cells =3D <0>;
+		clock-frequency =3D <32768>;
+	};
 };
=20
 &audio_extal_clk {
@@ -78,8 +85,21 @@ &gpu {
 &i2c2 {
 	pinctrl-0 =3D <&i2c2_pins>;
 	pinctrl-names =3D "default";
-	clock-frequency =3D <1000000>;
+	clock-frequency =3D <400000>;
 	status =3D "okay";
+
+	raa215300: pmic@12 {
+		compatible =3D "renesas,raa215300";
+		reg =3D <0x12>, <0x6f>;
+		reg-names =3D "main", "rtc";
+		clocks =3D <&x3>;
+		clock-names =3D "xin";
+
+		pinctrl-0 =3D <&rtc_irq_pin>;
+		pinctrl-names =3D "default";
+
+		interrupts-extended =3D <&pinctrl RZG3E_GPIO(S, 1) IRQ_TYPE_EDGE_FALLING=
>;
+	};
 };
=20
 &pinctrl {
@@ -88,6 +108,11 @@ i2c2_pins: i2c {
 			 <RZG3E_PORT_PINMUX(3, 5, 1)>; /* SDA2 */
 	};
=20
+	rtc_irq_pin: rtc-irq {
+		pins =3D "PS1";
+		bias-pull-up;
+	};
+
 	sdhi0_emmc_pins: sd0-emmc {
 		sd0-ctrl {
 			pins =3D "SD0CLK", "SD0CMD";
--=20
2.43.0


