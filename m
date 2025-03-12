Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF6EC28B2F
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:36 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.23])
 by mx.groups.io with SMTP id smtpd.web10.34514.1741778866232348620
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:27:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lHAuANIg;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.23, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxO7qm2eE4lIZFY8mm+AXZER5dJi7G0pPTeurQSKGTJX5Kpl7RoMJsWa/egfZIm7EZYTOwQtjj2Ie6VztaOn0gnL9sz5PidPrNSF4oG6ZqeuXbm6Hh8dojzuuy7w+1nK8P2EFYipk0gj3jLKhZXHC2xH8SbpqzgPju5zPaV/eqN+cPX88sGxG8oW1Xz6OHJTwVJw7OVvEQEC1DWxCR1dCi1kosuFK0B5JcTYw4tSLUFZRkYNZORjTt779JCSG/TwRwSaGP8T/BsA4qoWusHPSx6UAt7Hw39gsBzGLirGBt0wnstDgAEY9+FYxRuyEudxmVaYw7iwiqFDJSora4pWxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7cyXst6pGuy1PCv2OLO/CTLo6D4i+lv6CDMO2OFJVk=;
 b=qhkkhGpK8UP1h/Mv8ly93aeYfmv3i0YeI5aCRVACl9bE4G1D39fUaMMVu4hV/hfbvtry998sacRbQn6GALaSDpC1tUYONHEK+GdOH0pbNypFHol8it3jjE477/h8IqxnP/OU0NzrgbBu5YklrdmMmNKreNN5YbyQ6f7RhrGjDyd+o2BIbbiBX50jAjd0+192B070Dy6OgCqiOFy4WrkeXG4CdY394rmMgoyoDeC7ClQEJ+tNlKLa7hdL7JHKfqNYLHwbO7s8YmVnxV/mKImzPE8M0HbWtCDG9jrTdqBsfl++XUr6G39qduvEIqCAyPgrJQXXq/SC2tnOjRB0akYc9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7cyXst6pGuy1PCv2OLO/CTLo6D4i+lv6CDMO2OFJVk=;
 b=lHAuANIgA3RHpYZqcorJK+yCWvOMS0/2NCJx/eozW9TTiA+Sc3FVyKp9z6tnAAC6rUy4wlkbCJQqNps98yLvETLTyvtuZaUylvFpz4QJaMSPM+Nvo96BBprhzdsiKcFfDmDJgJ7HrgUHjp7FsiM5Y+u0Z/qi8XcZkMoTIaAgN5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB14981.jpnprd01.prod.outlook.com (2603:1096:604:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:27:44 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:27:44 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 85/85] arm64: dts: renesas: r9a09g047: Add I2C nodes
Date: Wed, 12 Mar 2025 12:23:02 +0100
Message-ID: <20250312112302.1605750-86-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB14981:EE_
X-MS-Office365-Filtering-Correlation-Id: a455611c-5353-4382-65b8-08dd6158e856
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?h9Ln/dmsNcFRSxp/jviFBMw+eN6qTymsVVIjUJY2LTBabaGbsdhpt7ZJ2TiZ?=
 =?us-ascii?Q?3ANfMwj+47Wa3NGm3EiB3qhB4vE7bH7Y5CN3bvG3j8jESJ7TkPclwxYQ45iB?=
 =?us-ascii?Q?qTYgo8Cp5hWP0eTpBhl4jEO+ca7W9ydJTE4Mv8cez0w8MJfJt5UKkZc0G8OV?=
 =?us-ascii?Q?PCuUJxhz8wi+x6JjaqqvRLul6F9pIZufmZY5SIPfjg0trtNcnojjmRlv6l6v?=
 =?us-ascii?Q?UMbbfTk0ZsR2EtGhx3xcjR855csGVdo0OXfgNu0ofMfAhg+qkrl/7H2vRKGa?=
 =?us-ascii?Q?uby5WWtIiEhDkalOh0rbpYykgQ/Gm2Klg6mFPbWPOfHjja/jH+5353ZHMSUW?=
 =?us-ascii?Q?prHdj7+U4t+qLL/Az5+MhZiQnCsxVn8H0pYIjPDNjnOgXV2ja+G8hjvuSxr/?=
 =?us-ascii?Q?XolGmibYX5FjqjBSEkc+Q5LQUZlkMwqgzER/Y7zrjsQ9Cdaf7DDFUqa7Qyw2?=
 =?us-ascii?Q?i7RzZRz77YQq7knIx286j05exHnQLFavtUyV1XHoyaDRAZjjg+PmFwUtBACw?=
 =?us-ascii?Q?NDTojmUIwUk7ofU2u8p+bRT2uEyOw7KtOcXS8pZEOrQ2B8ugLG2rUBn0hqky?=
 =?us-ascii?Q?hMOWqpTw6ed5Gtt6QfoZ6jIFpDCM019FRSL/p3oB7Nl/fyQgHapyxvJyXVLw?=
 =?us-ascii?Q?Vl2VUDoxiEB0mlfTeXWKYM8dje1Z/8RUbT6yQOM3u1i4s0V7b1FXFh8RNRJO?=
 =?us-ascii?Q?Kt+cazb5+eTNev5u3qIqfTGbhOOKH6vAWje5W8LAaXT9Ui8Bi/UUfaYBy3hA?=
 =?us-ascii?Q?hDrs8Ce4bjZzahdZ0nt2rPbvAYuXj1D+c+BLcBmV7UMRDLHWevdpaUsJ42Gc?=
 =?us-ascii?Q?ZZWOYmwOfrBD7Q2O0uSOE9DUaKDjgAzjBvg7HDfwv/Tl1XR9FDxxBI8gtnwW?=
 =?us-ascii?Q?aPTQ1AyH9kzbis1PI7JhYqwpI96ZKdNsllrlZwCl7iEABCmYwIhWSVFyB3+S?=
 =?us-ascii?Q?jnLn2eT4aDBc5t2p4iTt3gLaL/yKvKJGE5OUpUySbSY3DLMGO2bD8sBDWPZy?=
 =?us-ascii?Q?q4P+P+D7SX6jvLEMuYqk2weme+H2+CPcUp4Y1Pdy4RQrhGC8lCjPVepeIrkH?=
 =?us-ascii?Q?kOHJmn+qRhjIFf7XPwvGzkhcH2hHFB2rjBW+T7odBGfpgRZj9T3DAsDDTjE4?=
 =?us-ascii?Q?k3RS+EV96GOFhh1uV5efjIioIee8FCS5UjAj1JcXcV6QGXYFa6r2BHejC0fh?=
 =?us-ascii?Q?E9anKBTnraYSpKBAEyyFFVuisStNJ2J66ITUU/8N84v3h4JXL2+u73BaWVWd?=
 =?us-ascii?Q?4lQmuIDwXMRC5UUro2Ec3Dr5us8Xk/wTH6hajGtCtVhT0dQoONtxqCXYq+if?=
 =?us-ascii?Q?McGbplU2CfghJmBzaTGU8+HPVHgy4CgLzSWswi4uFUYPYaT6eKqcuJAAXbNh?=
 =?us-ascii?Q?bhCNF+HPlAIcHGIxYW3C01O+FPrXOLMkRFhRjSW3ot5mvS7+0wwJiIJeSBSF?=
 =?us-ascii?Q?4LYL8nynbCTjYTe1reUuBF4MxSTO5QRT?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a20xzKo3dm8LPSexj76xpT/8o3ejl0ZI5hJoXP8WbVhuDhVaKAkT15WzTGPA?=
 =?us-ascii?Q?Tcx0kDnal+llRJU6QvfNJStDR0ivc73RLPJ91Zz5eHaB2YXgbiw+tnpiCfYg?=
 =?us-ascii?Q?gKOXLqcNdwvKtYVRn6XTkZtqz+Bx6S4XzpM24rDd0VJEA8Pb7g4Yo3PYfvgE?=
 =?us-ascii?Q?JRriribzUwNp6fZRe+ZXqvEDclL8FDsxAIfLtZD9HTRPqAFlUJjI1fd0ud7G?=
 =?us-ascii?Q?jVEbrR6iwlWU8u5iXImHCncHp0syr9O9S+S7QYKK9jUWoAEycRsWWUjqftBf?=
 =?us-ascii?Q?WFQ7J7r3Zn3C003o7e2EC4Pn73RJvgT9jAkwdFuJwRRTxCG7ss+3VrOn17lc?=
 =?us-ascii?Q?eIbuLGXx5l+BGSy3Ar1f6xOiQPDJ8kt6nHc4BXpmXvdEDd7g6oOtGz3QrRKy?=
 =?us-ascii?Q?Ir2VPkrz/2FDhd2oSAEFOOMDJ8DakPMGQR643CEbI8Jh9CdF4T/fUI7O8Eki?=
 =?us-ascii?Q?VWzEieAJA6zbJexW4nxqWn4dQ7FEk0gUNeNxHjrvI4HA5hcor8MSzaeQMBDl?=
 =?us-ascii?Q?u4C7VeO8gvmtNxXBqTCL6Co/2DZEQ8a1OmYdsydg58itDjeRgxkFwHCUhsMK?=
 =?us-ascii?Q?NkoDc4kfKRXhbjR7FfRiwzgWW4rBbEErmYyAZ8VkjuwKOAXxL4NbHantngSx?=
 =?us-ascii?Q?xxnikK/9NxL9RsTwWFkjbvGNFWqZ0MKVwTAtJ89mFfyS2gbNpGRYLBxrq7qA?=
 =?us-ascii?Q?R6WdL98ZIUYoRIzQTUOyHlPJNJSY6HobzapdiCyYUQ7TiYM6cmNzZPL+9OBM?=
 =?us-ascii?Q?IixyMKotAlmHl992w2Ef2oShN9ggkWaNgisCICbXPkA/keNm6pJTfsO/4qlM?=
 =?us-ascii?Q?pXB4AEfs0lzy5D2yd7G6dwUxwNlFOdmWOKCNPzd4UaY2sNCHf33glF7otxCX?=
 =?us-ascii?Q?g4McKZrp8R1ztSBZ9FSDqXWURUXXqk7/tuoXuWECMfvFiIK/krX4rYIf8iem?=
 =?us-ascii?Q?Cvx0mUnmqfvy7d4tFl6Qc4TZsvMYqaRawFwc2PLXuvz9EkmNDJTBnF+2AAaH?=
 =?us-ascii?Q?xb+bDMxKyLcnrLVrz8CavT2yxfcEHYgXHuUiyHfiCyLPeq8XBHCZEgIbaobR?=
 =?us-ascii?Q?KaFAbwuvmUqr0nbgfVGIHkJ5mvhKR9JbccD9Ddig0UZ4U4ARt/ousurG4s/0?=
 =?us-ascii?Q?76sIMEUPwYFciHeO0U5S6ocZP6VdDfSAftWlU8y+0S9t+w45a2YJozr7oZr+?=
 =?us-ascii?Q?Z/SAcJcp+gEdNxsXT515j1QGiUrI9r9IYzN/t4zyU5+1P3yNwarUFoii9aLb?=
 =?us-ascii?Q?ewOWkX1FMFMSJYhRvKF/UIeO/GLnVTol40Drz9ss3hW55eMDO5hHJwnJ0T+w?=
 =?us-ascii?Q?EKZD0eBz6byJ5QWBLUHQvzdlT4D+vWi4xnsVZaS0eJ5c+rtIhIpaIQecwgYJ?=
 =?us-ascii?Q?b5qWCxHSnjE+Dd0M/VSpCjy9NMpu9UTfJsbe8K+3fJFfX1yn13cmQUQSMQ5h?=
 =?us-ascii?Q?hmIvH+/XBk4kvV6DA8sW1QsoH8Me4Nefz32nfTuMY8jsFToCrl4DnQsYvqb2?=
 =?us-ascii?Q?xfYObPX3zCau/GxE2Fsc/G9nBoSyKH7IXL5AQxJCw5Dj/hpeKbTdcM185Ptn?=
 =?us-ascii?Q?1gdufCcPMXWIoX4/L4oJ39WUBzX8whVc+QZ3bRiEh5ixjJfm9daBwBDf/uaE?=
 =?us-ascii?Q?gldk34HiNg66QVzSuK/asWc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a455611c-5353-4382-65b8-08dd6158e856
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:27:44.2670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JT9eJgZyRjE0sHsnFcKP/YNJ98BR9SKDIkPuzLvUVwjX7G7bnDcVeobu6CrzAYcICgw+F7h+4PDZx9nmk+13iwyEb+tyCZXIaGaWrtUKEGntOUCogPkirTM5hhLN28Gx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14981
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18177

From: Biju Das <biju.das.jz@bp.renesas.com>

commit acb247afab5bc2b4462f4dfc17a9d930e1153e52 upstream.

Add I2C{0..8} nodes to RZ/G3E (R9A09G047) SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241216120029.143944-4-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 189 +++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index 15711f9b6038..200e9ea89193 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -175,6 +175,195 @@ scif0: serial@11c01400 {
 			status =3D "disabled";
 		};
=20
+		i2c0: i2c@14400400 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x14400400 0 0x400>;
+			interrupts =3D <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 507 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 506 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x94>;
+			resets =3D <&cpg 0x98>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c1: i2c@14400800 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x14400800 0 0x400>;
+			interrupts =3D <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 509 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 508 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x95>;
+			resets =3D <&cpg 0x99>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c2: i2c@14400c00 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x14400c00 0 0x400>;
+			interrupts =3D <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 511 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 510 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x96>;
+			resets =3D <&cpg 0x9a>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c3: i2c@14401000 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x14401000 0 0x400>;
+			interrupts =3D <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 513 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 512 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x97>;
+			resets =3D <&cpg 0x9b>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c4: i2c@14401400 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x14401400 0 0x400>;
+			interrupts =3D <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 515 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 514 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x98>;
+			resets =3D <&cpg 0x9c>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c5: i2c@14401800 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x14401800 0 0x400>;
+			interrupts =3D <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 517 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 516 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x99>;
+			resets =3D <&cpg 0x9d>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c6: i2c@14401c00 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x14401c00 0 0x400>;
+			interrupts =3D <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 519 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 518 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x9a>;
+			resets =3D <&cpg 0x9e>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c7: i2c@14402000 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x14402000 0 0x400>;
+			interrupts =3D <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 521 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 520 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x9b>;
+			resets =3D <&cpg 0x9f>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c8: i2c@11c01000 {
+			compatible =3D "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
+			reg =3D <0 0x11c01000 0 0x400>;
+			interrupts =3D <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 523 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 522 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks =3D <&cpg CPG_MOD 0x93>;
+			resets =3D <&cpg 0xa0>;
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
 		gic: interrupt-controller@14900000 {
 			compatible =3D "arm,gic-v3";
 			reg =3D <0x0 0x14900000 0 0x20000>,
--=20
2.43.0


