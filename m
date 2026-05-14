Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BF4CD4F42
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:43:14 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7035.1778751792839156177
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:43:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=JrW5zC7j;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.43, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9KWgEQg5xw2or35HG2fB9hu03Lv52Dx41LNLmQtUV8RoKKWHlyS5oU5j5DlEehIeFeCfJvoaJZPe7A9bEpDmo0a/Vi6/6SioU9UQHJosm471l/xgs4NecinymBihMex+lkBLkhvLRH55AEWWdpBMISMzCmEypNNvVr2BJ7Do+Hhp9G5b+gdXsRuMzcdYxLn/MXaumEktQq5udoK2/T+N7K/aeyH9K4TVpXUqnWokIFIkt4rU+H8c45QFRc864O5DzrRo4bNy1z26KN2tjJSOiZoAgKyaWEVpCTkm7mQiZfnuOvaFoWrO3eY5Q7rmh2PJNNUYY4YES1eAkZ/PKBCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raTNPBYXCO+Skoe4rL466KUp1Yu+SHNYc+/Zmbn8sck=;
 b=lVmrssYHict89HdDJ7uUd7pkiI2FEzIizu75dl0W3iZT1qeEPitP/uveUikrDGkfeJtcW+/J2TkNI60e1/fNA0NmmNuk6fMbDRXiQ/298jHobC1hAGHxp5OgGDRieUrY/F++3UdEr2f+spOG3d12vY41mbifZugiskThq6iwdI3AfNFnaa6EhLBa2uUJ6WbZvESbl09zq5xC1qg/7ozWkZQyicsZqQZDKGVUag6ATU7Leh6IaAJQIC30Y37vreoqfTf3tWAhCuUP9FNsLe/hTv4FtM1QPg9FUnlR/Jgj9PCLWuvf7WdJZqdk2IA6himhaqrQdVqqx6bS1rPsptZOzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raTNPBYXCO+Skoe4rL466KUp1Yu+SHNYc+/Zmbn8sck=;
 b=JrW5zC7j7GdmT9DxHdjyJ0Zqrf+40O6hhTVgqirND9GRHIwXKdl2NpHk0qCQmgzQ62JSxzfgA3brm2Kwa79KYBzdZXPvI2C1TU+ZYkblBTfTrFpDjctFTzwplYjKogB2Sd3pqnZ1uTaIzeEcUkIOspVoTqGoaS5gMyZL/QQSViw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYCPR01MB8192.jpnprd01.prod.outlook.com (2603:1096:400:105::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 09:43:08 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:43:08 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 16/17] arm64: dts: renesas: r9a09g047e57-smarc-som: Add PCIe reference clock
Date: Thu, 14 May 2026 09:41:51 +0000
Message-ID: <20260514094152.2215176-17-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
References: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::12) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYCPR01MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fddad0-e299-47f8-6b1f-08deb19d3434
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|56012099003|22082099003|18002099003|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: 
	KVzZRvMH9fLIugA13ZxNEovFlA5qFn9tsay6keJh/j+QON5LGOXd9DsT0T56iP+JSt/yrvSZu0Gf8nP1F2LSqZn1+EMO1fk61M/RGjcyiWgwO0Se+IswZCbWSeaUtWDIUjGxhW5qG6EF5daWl1vqEPd1NQRzB2gpH312MQ+CZXy1ruaHCrulcRheHTbGYlfStAe1+bKe2qG1Y9Czb1gOurYG4DhVC/MITUPEx+P0BjH1Bx4nioA9QVSrbLTVUEEuMks7f9KviOQRJHxV+2R0V4x4IF3+LWKYw5SV1PRXO2J2JSrNvrMq0djjDQQis+0uNqtonZnJx9vKBTEmoddy1ALryYQhVNRjGUVG5erRjhGXmj7J9/7L4TAxX9kMapJc86ZzPG2J4cJqHtxEs3Pslw0DPAbRgIaeUtHmQAQ9Up0EEZmjvahauxN8148TB6BqWEsBjrPpVxnG3FBTKXBBKJcrQRYHrGSmq0AlO17p5yIFtUV8aYBlmzE3Zg7ACcKzFqkVmyA8s/TphiE1fNOzAbC663i/lRjdN0OXr4Fse4knThy58xrpj4HfZiukE01Eaff0RZMgwVglRuiChIRshq51sNx6p54K9QtnBPgBIyowP1rVVXTOn7EEVzGVoFN/z8wMI3jRphfMD74Lmx7nqpEKLHzw0TTT/Zd9vv40QMDjTRiRlYR869pXCeYS+//zG1X+aFnskw2w8c0cPkdLIg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XNdsjllRmTKx9x4Hk9Tj2pOF9uWrW5upNayS4P4/zHahZjM1DaZ/QEmSZe4f?=
 =?us-ascii?Q?P1HoXL088nM2M+LPjDz6vAmkxJ0cwIOgWG7xYodoey56NDFOUr9I6Vjitv8x?=
 =?us-ascii?Q?qhtq7eFeqQuQ6JJxu8xkv4ENC5BPzoQKeB45NOESC0ruasMEoqVjE4meIoWE?=
 =?us-ascii?Q?P/PblW7WfvZCCWZGAoF1r4xWb+L14PwNOz6Sic0py7k7SwiTaMCWR6l1gkWI?=
 =?us-ascii?Q?kygus/LQriF9YEq06UDHd6SjQ06pHEQTIAQqZgn4xOcuU2iWKyTBxAvaV6fr?=
 =?us-ascii?Q?ygEQdVjliwm6TBZ8a9Mn7wndzR/ep90toM2DX5QlZ8LPvuIyyYPK7wbbt93+?=
 =?us-ascii?Q?Ly+3vZid8lQlEdY29lo8mSPe4m3aNuWKdao5SpUDWd+s1KmysnKZgSv/sM+d?=
 =?us-ascii?Q?4E8d7E01/fGQf3Tz/WL9/E+dFmzqmLBc0M1I0UryGd0to29JUqMd2xZRAwIf?=
 =?us-ascii?Q?WBkrabRJk1pSkKZcawf3PXddZwEBCUPAlLDgadEcLWGU3DDx9TOAXXR2Qyzl?=
 =?us-ascii?Q?pVZ0L/L9QyiFAjoKZ1dN9n8FsqZKBM3hN4TCKWfK6gjkEGW9iJQ5GGuru9N0?=
 =?us-ascii?Q?EC6ZUGenpIz3TEGOGjPj2FOk9W4KwSFbU4egDuCubid6goWaQLmnIglzkSKG?=
 =?us-ascii?Q?DvN1giugpzhK1vaW7CyewYxzpprANYc3BsHxbQ2UsHmNbug2n4bkJ8dN/6i0?=
 =?us-ascii?Q?81HNOocCjf+iePJYPx41dKkApQjVVeuEXcN252bDZQE8r/nl/dum9aFcLeZY?=
 =?us-ascii?Q?e1Wa9zGrpjkx1josNre/upvvTtilaj7gPjgmM9SCEkv6KiwMLSxwJO+c6IIZ?=
 =?us-ascii?Q?hmCQnKb9TnQmtDeRFtw59z9ZRipoSSVYxNcGa33VfY4widhPg2DRydmvqyS6?=
 =?us-ascii?Q?0KzxaJAk4ME+R4+srp91JAb+gh2JxU0KkUwsdChlkw/QudXZNenZVqa3ErLn?=
 =?us-ascii?Q?+ht0aj+ZyggV3UPAcE/N7tAn9EbulJwatLc7A5flo1X2cLwvHiBO45vSwiWH?=
 =?us-ascii?Q?wdfvS27ugPT2XUpDRPDmLExgzYuqXoeKa5Yqc147/vS6r0jnrqf5syXFhu3c?=
 =?us-ascii?Q?t40jEeVOdZoqEZ+RPDEO8PxZU6VxoZmuer9BS8Uz5BqKBfLJaPfGc+D/icIF?=
 =?us-ascii?Q?/j8sjxxWJ2n5jpdBvK6vVreSQtlSqRNpiLFcaElrEJxtbwaDhMcywcYRETs1?=
 =?us-ascii?Q?dZGRhmpDZy7gafCruxyUzXzkiofdLjgX0qJ3fD2/EoG57N7FBD6Si4P9inYN?=
 =?us-ascii?Q?atCOeNoR4WqmsavfUxF6vu/gfx0mURbLwVElwbEzM0kzXh94T8W6uBWv6Mda?=
 =?us-ascii?Q?jAqYNisvq27EIEln5MLhSMubqHM7wQXHEYrrj6hNyfB+0VCWBGRyPDR2f/Tx?=
 =?us-ascii?Q?8ypy/gfEnlaUQ0UjxsAUo7k5fuYT7eIgtryOBTtBnBk7q6ktbg8Qb0Bb36qG?=
 =?us-ascii?Q?c3j67c4K7JZZdO10h37uxEdSO1PpGrPYvGiXCfj8FZETzSz3J5TpasSWP/Nx?=
 =?us-ascii?Q?9VBpbVNecvFeKGFW09CDJR7A95mTZrGu9+lrIU6YYpeC1JLAg2eo5bGbeTUK?=
 =?us-ascii?Q?aDtW0pXSTbR9X5bP7NI6Ol8wwwSX9jvFa1xRyQjzBVOMFyNRr3pVgEiGGboG?=
 =?us-ascii?Q?kc+7UofU1LX3cLJngXhOWe/KONZWnID+EJEgoIhfn1+O8aP6d/96jDHip0Ig?=
 =?us-ascii?Q?swkNNuXOURWbb2Woj7Ji90MUK58/5AsYYoMbfaOzul/ag9RanXcIiHMOb97J?=
 =?us-ascii?Q?qhOG5COfkXVBO+YlIf25RKJLr0DkLiA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fddad0-e299-47f8-6b1f-08deb19d3434
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:43:08.0383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bLN2bBiV9yzwC5dtis81/PnYAqAFP64IFZMWhEO6mxwnDaMwwuDL9yoqjfdbwmSpPFeQ6ZYPuFFGC6uDoFmA5IydZqim/9aVjsdtZeUZRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8192
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:43:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22968

[ Upstream commit 8af9fd59cb7737ca1c707db8e72774f5fa1576fd ]

The RZ/G3E SMARC SoM has a fixed 100 MHz reference clock generator
for PCIe.  Model it as a fixed-clock and assign it to the PCIe port.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260318085119.44717-4-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
index 3b571c096752..0eb0c6e92fd5 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -43,6 +43,12 @@ memory@48000000 {
 		reg =3D <0x0 0x48000000 0x0 0xf8000000>;
 	};
=20
+	pcie_refclk: pcie-ref-clock {
+		compatible =3D "fixed-clock";
+		#clock-cells =3D <0>;
+		clock-frequency =3D <100000000>;
+	};
+
 	reg_1p8v: regulator-1p8v {
 		compatible =3D "regulator-fixed";
 		regulator-name =3D "fixed-1.8V";
@@ -176,6 +182,11 @@ phy1: ethernet-phy@7 {
 	};
 };
=20
+&pcie_port0 {
+	clocks =3D <&pcie_refclk>;
+	clock-names =3D "ref";
+};
+
 &pinctrl {
 	eth0_pins: eth0 {
 		clk {
--=20
2.25.1


