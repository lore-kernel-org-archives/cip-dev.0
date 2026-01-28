Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18CAD3F087
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 16:00:21 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.29])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.720.1769616014445519675
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 08:00:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=NescAwX9;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmZB2uOuOGvID1U4/3/cx8iBFbuZmgUlYyFX0mehhs8bT+vCF7xiyorcKNfQcK1V4DgkrRlxSZ/FW3eoWqQ6uUTAH9WWXblO5W2mZgcOSVaQXVIwF7eLwqSCtCEqz+WOEmm4WlnMVyEoMnJL1ZIc2qi1LPcHh+PJ49WlLdLeF0FgrAibr3FxWODOmHMKkpaWZkuOay7LfHUO4uhAD7l+oAjEjT2HY2YFJM7ecBGFLNsD9PwCHjYtIWVH+wAiRnwhw2Z9Qhs1etleX48U8KaKL2hGKQPZA78HsUtFDZlkG7KnCNNtyiugDDDLWWDvW0vKilyh9C0LbhVhrqyu8w+bcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fj6gvbuPtN+AQSy7b0D54VajfDKljCtE7Appfln1R90=;
 b=qgJl4j41ah5MEmmjRQg7JMYRMblXSp5l/WOaKIcCzU91L5P84hIB2hNVwB9q7fjWuhtbrNJY30CGlGtN+JnyknNJ8y3pTacy6l42US+eXOGLUNpAqZJ7ZbQ9ixyT257ZrMHPme0/lqBUNMnCRM+DitYIdLeWtBs9Pjwe2TEQ51Fv96DCywnl8nr7IaFngScaGbVryrAdQIsqQc1/rRVa+M8MWFjb3b4j8+liTjLrGNRfduZ6GNc4TGFb/jlrif92DJ5K3JDjJWrFzO1k7GqJ63bATbthJ4lPuazUMEXYG09CG6PWXOavhZwShVlsRHWYXjVFeHe8NPOQmzjrf4BFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fj6gvbuPtN+AQSy7b0D54VajfDKljCtE7Appfln1R90=;
 b=NescAwX9oRz1j3WbngFEJ1snRT1wmwwHMmvxPdu6iY/t7Q5mjHX9K+pm6nqpXbCOX3AYNCeERqApEWGrUFYNYCwLSTALLH86i26ujjjLjXwQxOa5u5fQHkc/1QEpgqqyduRk5opyuUiZLoBuaEm/ykg42VO1sTEMNRfW4BIFe/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com (2603:1096:400:409::5)
 by OS9PR01MB12487.jpnprd01.prod.outlook.com (2603:1096:604:2f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 16:00:14 +0000
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495]) by TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 16:00:14 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 3/4] arm64: dts: renesas: r9a09g047: Add DMAC nodes
Date: Wed, 28 Jan 2026 16:59:39 +0100
Message-ID: <20260128155940.1445842-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128155940.1445842-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260128155940.1445842-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::15) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11948:EE_|OS9PR01MB12487:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fb8c3f-7026-48ec-ce4e-08de5e86530a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YkgMwBuylsbC1rBaFA6HvPGmImC0YvM4k8eNqGM2AHyZT9oYzP7xEAQKhZw8?=
 =?us-ascii?Q?2HIshWonPX3BktjpHutyxVYneJPhVpf/t2orvZlOxBQFg5vBWyNWmsXpdO+G?=
 =?us-ascii?Q?ihaKuH9RcRj9hf36IIjIJ2pgRVi85fNF+JtaXnz06yK47QxaK3UNRlXdLN6f?=
 =?us-ascii?Q?VbrzDPfRxJ91OoD/vlxrGalH4NS3pGJlbdx6AXZNxlOCcN5ugGnoC9ZDkQrl?=
 =?us-ascii?Q?4hZTQYfhWZ+JpPNDmdePPUtFnqGrg1LRM90WoG3X2hRYLG4iwteoqP9kL40i?=
 =?us-ascii?Q?QIIHPcJAcIPWm4PYAaTGR0wASgdhwBJKFjFMKTHlm7o/kOh6pC4rEFT6Ctvp?=
 =?us-ascii?Q?YoaV8gKa8a/Lu8AF4DuH6VAQ8VcoHXTsJ+8G6RyNEAZi56AAH5zuUG+cuzZB?=
 =?us-ascii?Q?rgyIwobvl+uyn9l0/NwRmEvcstOQqxotWiMxoerTB1xrqD32agwMipO8E0dt?=
 =?us-ascii?Q?UaopHrw3MyqEQlQqcSSRweNOHfF8W4SHjY8A6FeptHUVmfcM8feFazRnCprv?=
 =?us-ascii?Q?oslCdrwwPec34ndMwfLohzVrwEofJoIPgGxp7fYc6mnezpXKArLZ+HrsuZ4Y?=
 =?us-ascii?Q?s0lWa1Ww7dmlpWyVctDEjc2DFjjKjIb2g5/NuuFfb5cMpDIS3cjHjDECi1fd?=
 =?us-ascii?Q?PJYGL8rBhPuQtJuAs/hut/z6KMjw4KdmljzlhmP99HuEnxz+3b+xj8LoZ/J8?=
 =?us-ascii?Q?f7KQK6Eqed57ZTi6nmSVj8mCKDsVXPpvp82tfUnS3BmKwtKkolR+vmV6t2WW?=
 =?us-ascii?Q?MJdIQY40PkDdnHFm17+rOtQKOsfJAMZlnGkMpsT1ji0g6ZjyyGwZVQppi/P2?=
 =?us-ascii?Q?w7M8UOWfCuWk9hdUFqJ83wZC29jgg6XCmQj7QqgUNEu0FfV8XLHLZec4Y5Ac?=
 =?us-ascii?Q?avKzpZZM622eEgjWre+mZBynX2pBZkfkbxpknOvGAbY7kQIJynKWfDRhgQ3f?=
 =?us-ascii?Q?El1BJHsI+PUMA6NwjQP7R0cwJ0ASZav+9qGYoUA4HLUPENdr2TlsvzMIeRwB?=
 =?us-ascii?Q?ImS9G445SvNAHhAoezTEBBZJeJzP+zadti8vh7E4TTXtm41FKrN8k6F3SghA?=
 =?us-ascii?Q?DmL7eaA+FdOttzLA74maCE7e1qGDu/YGTUydEE9zBgWGiVR0g7/PUpWGIiUy?=
 =?us-ascii?Q?RqwzOjEk7kKysJ6xKliMcDBcRCpm87x5tysMBDR3asUSjtIaEy9ZJJsBPKau?=
 =?us-ascii?Q?7v5jEQybczkJJ13jb2wCD9mOHm+ZDGfe3URblMOCJMbFt9RHx8eqYymRL5Rr?=
 =?us-ascii?Q?1yqF8UrKEsVuG3bFmjAtYOKeoxGmiEKyAY+/VSzraCgTvxNawrGHKfhF0zOY?=
 =?us-ascii?Q?yfjd7bPmIkKicT70E2pc4Jl0BG3eEkBrD6bBCATU72I7op0N3kndAsDg8Wlq?=
 =?us-ascii?Q?CN1b0fWW1FhcS5qNkjVZSZLmvxoOrRDeF5VdCepHGijUEnTj/cqHd5Wk2KyK?=
 =?us-ascii?Q?elMJ2ejmsLD/BC5cIK106mPxV83Cm6n51NppOhDmDILl90sIu8WpY6IGhNo/?=
 =?us-ascii?Q?HCSOSq/2piy0OupsjPhmRUicY81Psna27cfwB9UxNgZ+aoditOoOzMx3sIVz?=
 =?us-ascii?Q?WXBmclSNlrLz5x4b2opvicOTs0uEwR3kjr78GjwIETsZkMjGd1PNjQBf9L/0?=
 =?us-ascii?Q?rzdOEDTXLpx/MWghVm2dmJ0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11948.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/pKvi+YOlTxKD6XxlidEYuHj4T6oqaZZXLFjYTMvp4hIiiSv1K3eXiqpWE1A?=
 =?us-ascii?Q?kwUpqcpJhm6A0TNy/iamoJd2eIlrJrFfrWHHFfSE/t5SEP8spa5aCZoscaP4?=
 =?us-ascii?Q?3Zh6ykYsAnA95u9Mh0p+C1SZu3f4hXKKJuNp2lRyIRRcgBvJjx/zopGRt5vL?=
 =?us-ascii?Q?ESj99+O5E2mJsRoDh9hsMCY+Yo1Cp3KA87l2wXGR7dBA3NRo3WivI6YWBu/e?=
 =?us-ascii?Q?IUzCy2HBqw5Ry8fItrA5MTLcLmC7M80GBp8hYRoSXM6UsU+k+zLo2oM+Lj/j?=
 =?us-ascii?Q?CC9Qp/GqnV8AEvVQCYctnVxEuHggoMGUYxDF1Wt+vLD1VemrP3stSo39YYMC?=
 =?us-ascii?Q?fSgab7qxc+LY6Vx3vummuBG038mkJpndH1bZz03qrkkQASKt8x8hOlwPr0Nz?=
 =?us-ascii?Q?6ePmWhtke6mJIgqPD3NeHvUh+BCSTcvxre3VneiHL1ExRPrBpsX0nsvcpTQ2?=
 =?us-ascii?Q?h1XtC44+uFKZqiY8uLosG1667JKW1Dt/vXgeF82bqQRPn8LzygE30y4uiMix?=
 =?us-ascii?Q?qvWKRgp1y0FeB8z0bB0ki0c3tCwNVTgtJ/mORJ9MpBlb6Radlxp2xOozX5E/?=
 =?us-ascii?Q?X2U+N9JP86kj7/bkZ/TvSP2TF5a8+SAjYnc6w0y7+cCgUdSGIL+EgX2KdzGf?=
 =?us-ascii?Q?3f702NPp6CCwvbDMrdrU9ypkatzD0D9wOjjNwPpf3zz8uoX4kR0KAIUqC57c?=
 =?us-ascii?Q?myncfng5p9nIP15HSixhmV3nYswLp4EbBox8hqauNsECQu6aKmgoIAPvHcra?=
 =?us-ascii?Q?t8pxTogM6WE5o25JTF+jhT+5Oi4cs77RBkM9drvzC3+S9py17oIMj2ZqYDBz?=
 =?us-ascii?Q?jGkDZM0aR7UUyZ+5DUJ5UGfS/tWILF1fOtrIGd7PmloQwGSRzfbKJZQgNkNK?=
 =?us-ascii?Q?nFm9QeV0vENSZ1UNEIZ5zRnaf2GQKSxZfIZBD6c148Y9e3W5oMgzIxaWqZCb?=
 =?us-ascii?Q?UciCSb6Jbdgu+RWfxBXost5iIlKu3O3Yy4dftdE9q3FHA5nO/18YNixOYypR?=
 =?us-ascii?Q?wUnsFIsPpyVx3/E9rcpjtEvbT8LpZ1L7d5Afo8oXCrnABXpPI10AFo/BjWtJ?=
 =?us-ascii?Q?RAbAdYY66Rx0HvgAcKmmaQiudRLzgU3+fFR9tUtc7LJ6vHuZF02RxUqng9cY?=
 =?us-ascii?Q?7ezxAQjcz4/xD2Wltjck7Dkrf5S2aNm4eln4TGAXHFI/2jCpDklhPWw0Lsua?=
 =?us-ascii?Q?zBJw6y6IBVOyhfXj/V/87ksL97b9wvwkbxFxAul4GOFlxkmqC3XhvdxuqbNS?=
 =?us-ascii?Q?8/eB5nbbbfke8q7vK6dRxfdBnkS8yHIWLkABHyQ4/UDPfHiflTsWIiE/c1cT?=
 =?us-ascii?Q?T+2tOEpsTPyuQaIsAwSaWVb+otrkd4lSE+tO/ixx02KOfdkzyFozrOKHH7Ku?=
 =?us-ascii?Q?TIHV2+mh0tO5z2uzxbLRBHzC2rJ1SqZQmXMtGgDbituLJIjlcduB43OXesBI?=
 =?us-ascii?Q?F7VaWFQO7JXXEaOgrh6VX4CoQrn/po/xE3K6T46Mh4hylrobC951IjTfYFRs?=
 =?us-ascii?Q?XerHgj7cimpGGuSJcsXkJl2mvZBysfkkYChHdibGRbdFk0F9vgje+UFEJ52T?=
 =?us-ascii?Q?9b1kd8b5ilIWDnh39CuVM8BA9bG8oHQ2Csofv4BxjKgbZhurGLLdGLg1EzwA?=
 =?us-ascii?Q?kN/K9syquD1jSDUGbges5XKtT14eEhbHSJGjGo4Fy5R5OCHG32ocLosItEzQ?=
 =?us-ascii?Q?G0H9zRDXb/Qcz042ccRzgoN0YOBpwr5RwAZkRdRKr5zgq4vk5PBwcjUvYni1?=
 =?us-ascii?Q?wIj8JhayedJDIQrJ33uFuqPr6RYOZSFjbbBGU/e7YuSTVsNlwNa5?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fb8c3f-7026-48ec-ce4e-08de5e86530a
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 16:00:14.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MH/qFxl5Y7oUsQRoSGJwkIryiOx7KW13H41fx49sMTWTilX/B1NlzfyaMKz94JoQnC6Kmloo8ApjszFn7hjcK4PZE382aL8WADF1JGy8oGn84H+kditsaAouNgnFM5KB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12487
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 16:00:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21771

commit c44c51bc3566412075c66e0064e17c0c9cb5a638 upstream.

Add nodes for the DMAC IPs found on the Renesas RZ/G3E SoC.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250801084825.471011-4-tommaso.merciai.xr@bp=
.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 170 +++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index 42bf6a57df97..47d843c79021 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -301,6 +301,176 @@ xspi: spi@11030000 {
 			status =3D "disabled";
 		};
=20
+		dmac0: dma-controller@11400000 {
+			compatible =3D "renesas,r9a09g047-dmac",
+				     "renesas,r9a09g057-dmac";
+			reg =3D <0 0x11400000 0 0x10000>;
+			interrupts =3D <GIC_SPI 499 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 89  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 90  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 91  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 92  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 93  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 94  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 95  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 96  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 97  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 98  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 99  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 100 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 101 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 102 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 103 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 104 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15";
+			clocks =3D <&cpg CPG_MOD 0x0>;
+			power-domains =3D <&cpg>;
+			resets =3D <&cpg 0x31>;
+			#dma-cells =3D <1>;
+			dma-channels =3D <16>;
+			renesas,icu =3D <&icu 4>;
+		};
+
+		dmac1: dma-controller@14830000 {
+			compatible =3D "renesas,r9a09g047-dmac",
+				     "renesas,r9a09g057-dmac";
+			reg =3D <0 0x14830000 0 0x10000>;
+			interrupts =3D <GIC_SPI 495 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 25  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 26  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 27  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 28  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 29  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 30  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 31  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 32  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 33  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 34  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 35  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 36  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 37  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 38  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 39  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 40  IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15";
+			clocks =3D <&cpg CPG_MOD 0x1>;
+			power-domains =3D <&cpg>;
+			resets =3D <&cpg 0x32>;
+			#dma-cells =3D <1>;
+			dma-channels =3D <16>;
+			renesas,icu =3D <&icu 0>;
+		};
+
+		dmac2: dma-controller@14840000 {
+			compatible =3D "renesas,r9a09g047-dmac",
+				     "renesas,r9a09g057-dmac";
+			reg =3D <0 0x14840000 0 0x10000>;
+			interrupts =3D <GIC_SPI 496 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 41  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 42  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 43  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 44  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 45  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 46  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 47  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 48  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 49  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 50  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 51  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 52  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 53  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 54  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 55  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 56  IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15";
+			clocks =3D <&cpg CPG_MOD 0x2>;
+			power-domains =3D <&cpg>;
+			resets =3D <&cpg 0x33>;
+			#dma-cells =3D <1>;
+			dma-channels =3D <16>;
+			renesas,icu =3D <&icu 1>;
+		};
+
+		dmac3: dma-controller@12000000 {
+			compatible =3D "renesas,r9a09g047-dmac",
+				     "renesas,r9a09g057-dmac";
+			reg =3D <0 0x12000000 0 0x10000>;
+			interrupts =3D <GIC_SPI 497 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 57  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 58  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 59  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 60  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 61  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 62  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 63  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 64  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 65  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 66  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 67  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 68  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 69  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 70  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 71  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 72  IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15";
+			clocks =3D <&cpg CPG_MOD 0x3>;
+			power-domains =3D <&cpg>;
+			resets =3D <&cpg 0x34>;
+			#dma-cells =3D <1>;
+			dma-channels =3D <16>;
+			renesas,icu =3D <&icu 2>;
+		};
+
+		dmac4: dma-controller@12010000 {
+			compatible =3D "renesas,r9a09g047-dmac",
+				     "renesas,r9a09g057-dmac";
+			reg =3D <0 0x12010000 0 0x10000>;
+			interrupts =3D <GIC_SPI 498 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 73  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 74  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 75  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 76  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 77  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 78  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 79  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 80  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 81  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 82  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 83  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 84  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 85  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 86  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 87  IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 88  IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15";
+			clocks =3D <&cpg CPG_MOD 0x4>;
+			power-domains =3D <&cpg>;
+			resets =3D <&cpg 0x35>;
+			#dma-cells =3D <1>;
+			dma-channels =3D <16>;
+			renesas,icu =3D <&icu 3>;
+		};
+
 		scif0: serial@11c01400 {
 			compatible =3D "renesas,scif-r9a09g047", "renesas,scif-r9a09g057";
 			reg =3D <0 0x11c01400 0 0x400>;
--=20
2.43.0


