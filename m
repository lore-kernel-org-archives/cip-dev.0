Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F5AD3F08F
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 16:01:22 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.755.1769616078397665948
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 08:01:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=AcnYXlkc;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.20, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CG8+IyybUCKYDYVAaKSAuMyu/cjBaAKqPzf8A/SrUNYvZkg9xk+n5AvazCJNcXZGPdAj0F/HDruOmMLWkG8gevlvo/nG3o1OE7mwZvNJmEELqHcvoXiBce30X0mQXk/VtfN7DFVtudodfzdZIwYR5PdzOY5pSWML+L6w65S5NqRO6iAAcu4iQzJ04qNXhesdeD/cv9mEB4P/bebHbuoK2hJF31UrDXUBgStqocU2cYIOFiY4kA53WeR2+TMnlgqY/oLC7FEvZN6xlE2TN7N5QOk81YF5LT60MJX3tchriQlm+8kOMNRqMX4c+8JrmZosvlREoTlpEWAkDPHngwkqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fj6gvbuPtN+AQSy7b0D54VajfDKljCtE7Appfln1R90=;
 b=JW1Fmtlg1Bz8Y2Qe95BcA3/6JxCPDCr2vtU8Y40GIn1HHBUFvjiR+Uy5hwmiYsuY1fLFePLn5QiTWJV1+ADRYsMuK1D4x5sqYr7B/8N9/hz8dLk0ELsZlx8GVOzOi+TfsY7TyBildb5phGNXcShIfLj9Qd4GMctCGHQBPsTgC0Ou7xafTLUP9vjRGcIGKq7UQ55Hzpgmg1AyT8Q2QyQSPeVLHHhuwCYa+uc99cWD883+2od6GWNLNW0CK5wdOmL1oZafGaoH/UV2Nz554lKuH2t1TlItThaX1AQCtV0VoKo3vdvM80rqE7zmawy+t3HLG0njOGNuPPiEEQ7KU4gg8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fj6gvbuPtN+AQSy7b0D54VajfDKljCtE7Appfln1R90=;
 b=AcnYXlkcILLJMxTGwddy9EgRvzFYooMK995HVpA4if4p2laE5XBFpdVOoF9tPbxcjE1tkedQAy/kfW0VYXCifNnsFST2HckgVa9H1nzG2vSg1RiKdWhO1/G/+N1bU97X+uw8pHJi8xM03cKqoQqgrjA/0j8NkZ61oST/95gV//0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com (2603:1096:400:409::5)
 by TY4PR01MB15588.jpnprd01.prod.outlook.com (2603:1096:405:28b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 16:01:17 +0000
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495]) by TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 16:01:17 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 3/4] arm64: dts: renesas: r9a09g047: Add DMAC nodes
Date: Wed, 28 Jan 2026 17:00:47 +0100
Message-ID: <20260128160048.1445926-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128160048.1445926-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260128160048.1445926-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11948:EE_|TY4PR01MB15588:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8e1a81-dbac-4c5c-1848-08de5e86789b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fKtyYkE68OUdHcdrYCyH7NzMA79nI8QwLUJKDwvH+K9xEfOJaCRcTm90sNeW?=
 =?us-ascii?Q?HLZXOuAgVGswn0Bl/FKZww/DqWcdtCn4Dc/8/Ajyl9lteMZEa+rKyZXdcrKB?=
 =?us-ascii?Q?YFS9HoS8qLFNNSNIr7edoMyCF0DkhAlS3lTepkSf0JOzHUFlP0rb7QKITGiV?=
 =?us-ascii?Q?hj8ATtH0X0ag3s0+CvYiovIcj4fp4K7rIat9gKpzayke42gI/9Kpnma6i1yo?=
 =?us-ascii?Q?jZp5x1P8KaG0KweJfAy9z7o2tF9QtjiLWG5SQOoPWC8MjWsF7Wfv29NbN5t0?=
 =?us-ascii?Q?Fddg7QjMEsjN7lIN2wD6QdA2nlBI4xei9AjqXn0XwLgreuL1gnvXVcceI/o7?=
 =?us-ascii?Q?OMxtBauAruJ+GVD0YRlFEDiZJA3WHfYF45Vp2z/oB4S1GWFwrgr3UYGSELDC?=
 =?us-ascii?Q?CzxSkK+i378/6OCutXRglhZ0oZwVR7PL/qPkQ6xFQDoS9G2ztXdXVehEw7R5?=
 =?us-ascii?Q?PxwcMuzy4kZ+g5IbFPh1VOPfyJZFfzomv75Dr8Ku3siwPbmGnsyipFj2WVv2?=
 =?us-ascii?Q?oBwiXxA4WWIMhik855ukFClqMaswbCB1QS1aPyUZ5YKCxsO++I9nk3TaxQuN?=
 =?us-ascii?Q?48we68T/Zs3Fz3oOLO9GDxwAor5uKhNnqWliWGiVE0aMG1hWCWBEZFtDGxBj?=
 =?us-ascii?Q?2W/wjEbXcbEIdAnmxHmBjE1CQEjO+kU7NsxMMQy2SsX6k07Yym/G7qkegsRf?=
 =?us-ascii?Q?pJnjLyJf+WBsZINP2+A1kdd+E1Ej2p/EZ7vsc60qq8fxPzrcWjwKUvwVQ9Tc?=
 =?us-ascii?Q?K6xe9XFeDfn1+6BfXP+79svloFo+jhvQZu7OcZ8b1OufRQHrLdMoEcEOk5FT?=
 =?us-ascii?Q?oEcr7Nq482UJ35iK2NS49Kv0A3/FPlsxpA/lPme4N16lqKKAcH9BnouS2hJy?=
 =?us-ascii?Q?L8MMnMFI55ICj8SAiPfLEyOPc9wfQc1j9FNw1k0fSw56EUh5E5+Ye0DV9vXR?=
 =?us-ascii?Q?qvvKlCgc2nmcdSMfv2TeOuSAALtCiSN+RDY73T087P0+JVvoAlbRLGzmhquS?=
 =?us-ascii?Q?TVFdJQN0hUYwFodeRvxOMBPpS8Pa9Tq27Za3AhRoG2ZDjhhuoTtxZnFuv8qT?=
 =?us-ascii?Q?VBY+3pPCFbZnKoTN1/UonPR/Myp9hSouGn3b+lwl0kW+qjR3j2/sm71en61Q?=
 =?us-ascii?Q?KR1I5d6545f9NpDQYhDtwXDDm0hos+KJs/AwFNPZOIrrJhS3rcJg/qyz/90q?=
 =?us-ascii?Q?doRUACDHwUVo1XmL+kZmxm/ZiqR365k+EikYmF30GlSOD+XZwa4ajHmQbtsp?=
 =?us-ascii?Q?9Hx9cfgej3ST1Pto30DJWObMsMJKZI8MhSuwjl9+k1SVp3q2neDox2R80nhZ?=
 =?us-ascii?Q?gwsuZLDXfIkpn302UGNESGYHXyLljT3JjUkMANAdQqdwzvuPQA+l4J0h+4i0?=
 =?us-ascii?Q?qjGvlBkK7EtZTnrpMzS1I5frD0dbMQ9OKP7GKSlFvN01UKIcwRoggK78Sxj/?=
 =?us-ascii?Q?fjMriH6r9XhmLL2M9YO1uAlFF7PxT/3OqpbgbzSAnvQJkXmBraDD5HuuFfSh?=
 =?us-ascii?Q?VmlUS7QbCjLoPYdCrTEgp/VIN0XvScitRvMgq+FZ2IEowYBrLZZZFtVRA+gs?=
 =?us-ascii?Q?ugrjh+7ZfnBFcr9BHdux5VqxdzD3IctmAYwcjlij6CIeGDlBp5axbr1EwArD?=
 =?us-ascii?Q?ehMJMTsQ+mhDIVdly044G30=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11948.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jy3DFrSoZd6poxaqs9mUZDk29hdFTfAkq7X4xaUWA0dErycUKFBNZXS+9LBC?=
 =?us-ascii?Q?GsMcPIICSipIIHSrX7xAl2wFuuh34AW2nvRuu+Z+njZTPLMTikNTZkqImutA?=
 =?us-ascii?Q?LcxPDMQzC+mkjvI39DC1vHfc9+UxsH6wtBz3DyQHRma/TU7AVhMzJaeycXWL?=
 =?us-ascii?Q?cwAD0Oi2U8Mmtaj4iOYmY9Rbkophpnmw3AlAnkRhrp8AoF6iFIQKvTHxdA4X?=
 =?us-ascii?Q?jGLmzbYwcl8cDf/IyDCR9IHSNxGGeF/1dieOXRtEwdBItGH1w0TzjhSjdNJS?=
 =?us-ascii?Q?5fBqg0HpGJLD4Bqanz5z2mCCqUpUbuGZl6DdVNe/Hv6xic6Swo7q2a99gI3j?=
 =?us-ascii?Q?KR6X9n3YDVanRQMCOv84GhceTClYHzpx/ZdqZT8VIUWo6wg+MOfQ/f3ORR0E?=
 =?us-ascii?Q?+GSqSuKwPqugQIZzag1LOd9JL/w0Mhr29d+qoF5TsbgtK3p+B3+Au/1boFbl?=
 =?us-ascii?Q?KeDHsUbb7B4LwYQUhyZHakbAVU3afjFFRHk9xNtbksLq4crFD5g0jspr2XP0?=
 =?us-ascii?Q?A4W2aXS3t9mJa1n8TE3AFMGz39NS4LhXFruemGe0UVBr+lKaXSygahpfOMUS?=
 =?us-ascii?Q?6OJvkBj1C2OSChc4LCFMPtQNDAuTgfHkXqHkCHlwuaA7Fp/pPtciYiPKObN9?=
 =?us-ascii?Q?ozS6gHWfK0vliNDshO2tqR4E4VO65Tgg+khh55LjgpCEBXk+yezRIi3XKn4l?=
 =?us-ascii?Q?xWhAxDfmQmOgFWzXyDh6ZFeYpZwgvTQrE1bis6/0Zphbz4K8lql029LZ3Pu1?=
 =?us-ascii?Q?HfIwK1iutQtA3yEAolTNyIqsCfs6vWM3mNAlb3zOwU11ooBswChs0JdTN0zt?=
 =?us-ascii?Q?HsHvKfrrfKx30YqyzjAbCyWm9ttphqN6yAWbiGrB9Hs17KeDpq+ttGQPZls0?=
 =?us-ascii?Q?rc0QbaBKVMDMPKhHSp7f1zPnzeA9lEIYD712+QCnIzjUIZkM1S4TGNdxLdEc?=
 =?us-ascii?Q?es2asbxnC0LdlyoU8UnOIdovBxphLxhw4TRcLZyNwqs/BkxzTBHorGs7aR5K?=
 =?us-ascii?Q?7D8F1LbxzdlD93FN3WkY0y7v5VfVQh17yNy0JsPlQ9vuU1qB6gxcDwmw8jSp?=
 =?us-ascii?Q?xeV2mMuQ+rDtf0sNodVCuucYoz10+DQqSLkWh0pJcoSN0Ha6LY3wJNG8w2/y?=
 =?us-ascii?Q?96SJ525WQ1rJsHe7YtwcPVxQNxFxugKskNyKWBwcBVgWrmx1gA2kxRZdPyPz?=
 =?us-ascii?Q?qlNKdA2q3Rpe6sbE8kOC4w8u8Mk+0COSW7cSPuc8gKpYEohuxjm0MZRppjzr?=
 =?us-ascii?Q?w8XB0VkPFob/itegxvBlQEQn6vPW8zXMcuxhQDP8LFSJ1rUXGea/Srn0zjIx?=
 =?us-ascii?Q?VyaU1SBNbzGy1WAZP5DJo6Z3VrMlqP0s4LBwmthocPDosXm1LSSbVGYDJiWQ?=
 =?us-ascii?Q?SaMO5t13yeNd1/Em0L/nHJoOGkBIhSwAZk07L3NFApYEHhad+5pkgk6SKqXl?=
 =?us-ascii?Q?m6IyYs/IN3dp26Bkbily58O7wU5rlVMdDDhKI5BN1zh2qWIZQucXDi9rdP0/?=
 =?us-ascii?Q?N6SvRFP2RXlz+i9lPJMwJR2ElYutKUBjyszqlmNlICb4quHKHEd4YFDg/v0u?=
 =?us-ascii?Q?0sxTgG/oVq4kleYN83GIiJI3ZK5or1GFChrjH1HsKa1eiSIRodpjiiw5cX5j?=
 =?us-ascii?Q?x55CgEkzbuHCMnZOWhrvj8EieHnYyQUIiRv3oOFDeXjikzTsdHVchwrORkAW?=
 =?us-ascii?Q?Z3Kdq3Jg2hBYnVqyWbXhkTP9YB4R5zQ4+hFPjKeJH6aChlCMXu5egfnsdMSH?=
 =?us-ascii?Q?vj1TbiQYMp9GFOEni2cYaEAgM9bNIE/LMIz24NtSsVf3k3B1Hs80?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8e1a81-dbac-4c5c-1848-08de5e86789b
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 16:01:17.6255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vU3uf6p/H7gppRDZVluSSX/gzS2msaUcBPzoNIkgKS/0X9nv1PbtPaLzAUb7CqyGoubDLfnc16RyG0dRxBHwDxPsByX2vxNKOwVCME+GE8FMKqrMktqrt0slXeY5acVc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15588
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 16:01:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21776

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


