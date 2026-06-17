Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3762ACD98F5
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:36:37 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11010.1781685396091271823
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:36:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=kx6oKyHF;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.42, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ol9iX/Ey3xVNQ9KCF+HPTrTaC0T+RjjAUJ5wqvDWTNH1OXlaYC+js6RWOLpyoffY0tTtrHmwOP/54kN5SBXwV3+GbYl31jDXWsQR1+djsO/mGxiARI3/AItU9R6rPRivZyNysp2sFe3FAEXwvWR/2MDih6R27ZgEP/5u4f//eq+G2fkE/c3Rl9PbjC6Fqk+0qlz84diEo4PE50qrqcctscSreQ0eI4RSJutokQXdIrfWOAntFRdk+L3YahK6xG5bF+mH2QR8kFNYncJLpB0vovtM4I20txtSQhi15+051AzKq1Un3HgPKVa5bJGxOMP8WIKnovoE2M9kWmBYhG5MqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yGf1dFPlqwQ51NwUyptxX/XJUKweCl9J2SIez8nnmM=;
 b=s7puXf8FBgmTlcBe2CMz78zlDaSSAAmosogaw9tPbuHqSEjAN+98n4skS7qCTLMD86SyWC+pSgB6arYydQYwiHJdM99yCGYxLK4QW6O+ZrmNhcL0ad2LEJQUNIceNrDRFcAqk/7i9wi2JVir7qsZt7yeeLY9IwckBrd18ZUb2bad7kenWDefgsQjb+2wiA5f5OiGqXb0MR2JY6snuYQfObZSwiTRB3lmjaeCZVSyF5Bko+dVGMYKmtA8ZgXCAPclIDjjcIVRfkSQWHozLBtVcTm8F7DYpKaKbj87qGdLJkiFAfc4oNrWW8sBuNdWLS2GZzCM/JpD0ywMmYiqfRx5Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yGf1dFPlqwQ51NwUyptxX/XJUKweCl9J2SIez8nnmM=;
 b=kx6oKyHFlwgP7kJp3VSPExmPQVSqpxfCKyaPpq9iMzFTNLE4dDXSecI87CxsEFB7BxH8JRT9It0doAMcbHTaVhwFN3mopC+OLjifAjhC7LEQN2xdWTk1fC7Vro0Wu6BQqtqisMZuDUjpkzXtsFHYtKOzPNtp9/25Oc2lQl1TbSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY4PR01MB12634.jpnprd01.prod.outlook.com (2603:1096:405:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:36:33 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:36:33 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 23/24] arm64: dts: renesas: r9a09g047: Add RSPI nodes
Date: Wed, 17 Jun 2026 10:35:01 +0200
Message-ID: <20260617083502.1074160-24-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY4PR01MB12634:EE_
X-MS-Office365-Filtering-Correlation-Id: 63972afe-c664-4b33-0964-08decc4b891a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|52116014|366016|376014|11063799006|56012099006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	6+EyGsPZFLgPZ3rzMpsNAkt58WMWf7EM6pXf52HFBwZOWJz22Mi/THx+VozHcxWIJjzYJJ3VNb69OPFggeEov9htPWncIdDWhw9IVpNYxcvt5EGtHmQ1yxYdmvX2jNlSXQtalLBvWMom9bdfjFh3MaJDZFePZIT+W14vOIAM+yVaAzd3IpQzBwwtTY/mrmh4UOLkG3/aXxukZan3fmC3Dptg1+g0ZDWwhJKVVi5FUN1fdf4lX2AC5rdE5CjuXZYgVgr+KkFwzDSSaMpB/oBpUe4k2EHQ3xnBURbLKVYaX4sq7sTk4aYq9SOUU85+OsWnLwB8Avms/9V447Wl5KSz2Sb6R4NKfQ8vv2NMb78gBetw/bBUgEg5mgsKmD38M7XkFs9yWwqbGE9dQpvBDEbVFVXH2Nuj6SgA/NrfL6S88RcAOzW5de38ayZF3VgrOhEkYplZq2nsEqpc4hDqX8cGurz/iT58txitSn7dvEkqpKli5SnK8nHXe5bVU0vskx8Q5WLBife7Q2ry5PFm3bVHMwpm1mHzGnts9jwnFDO1TM0lhvLpNg+EM02ikGz24e5gbHxUn7opl7kiG4Ey8O9IUBUSptRJ1Y1jNaJ8hDQJwIIU0xuxQXj0zjcnjQ408bjkSIDI1ld8PujFzYJWN6783xPjRC1Xn36c5/1pZr38yrB1xnSZvoGM0/5mwCAFRDm4HACMoVkm3G8wVbU7W5M0UQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(52116014)(366016)(376014)(11063799006)(56012099006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GULcxKH+4kz8MYmU0kw2NejTfBDUp04YOnZtblVIsbFJCw/IfwdD0pKdkcUd?=
 =?us-ascii?Q?oqzoVI7SzrmQEqpoqoIpHLns33rzbwsxpfWIpYbsxR9uBymYGHENkiwSocSf?=
 =?us-ascii?Q?LxE2PTTUT5K3WV45b2EFpsMbJisK/zp/fOlAudLO05VhlNrV3SVpLnvuqn7u?=
 =?us-ascii?Q?8IvY3E0/vEh3It9oxWzXSpxTrO4QzD62cLdFidyT8M/PbdNLzTxq8sEf+ZRQ?=
 =?us-ascii?Q?alsoCFA58oucxFTlz/MXpTc5c0GAuHnrWtD2zV58EtcC3t059lXPYjMhjpbr?=
 =?us-ascii?Q?kOTxovrs+mavjzvoAac+F2VM8pEzw6apIuNqWaHJrgIG3hZUN1meo+ulBcHx?=
 =?us-ascii?Q?JcO5RimeSg9ClT+IzVX07qqo1mF8k9UIfuGUJAwQCiPr1Zp6Ujv2rxkzE5Ou?=
 =?us-ascii?Q?bHku50ewIoEE7Nz8I46s937QlUInYlePuukv2jW7UlaUjmigJ9rIpcSoUyjT?=
 =?us-ascii?Q?twmRbZ5WmJU5wDX+YZDPiNNYXnGQQKbreWTCrG2ZAubd2J+rVpxqOoFRqdaI?=
 =?us-ascii?Q?5pNW7jhOPD+jp+gsYj0owZYNgYkfy0h4y7TmqCxrzoT9oMew0Dd7HZQnhO5s?=
 =?us-ascii?Q?VDZ7qLt4EvkNQa3rKN5bUBjzFJIW88g8+b65ZRMFJMcQ07ZCUtCdGNDJNMWC?=
 =?us-ascii?Q?TILdklKJV+chQbijyo/3VuLBsTkeXMuGJnELh1qiSyiMGf73V8VL3S11TxTl?=
 =?us-ascii?Q?/MpaDOTjYmDEVzGbazWz4X2rBqxS1gJJZoxLqZgaCSZRU2uVdaYXQejQgaey?=
 =?us-ascii?Q?y4h9/VVWCfAYY8paZO7wO4jnDENzuvVsGdCmUBvsHxdwcVsyOLHR608BxuCt?=
 =?us-ascii?Q?ePW4zu5DqW4vZRE6/YCYAel4M3nPeTXcryExBwSgGpGAh1r+wPBsXUZM5E6t?=
 =?us-ascii?Q?UBVRIPGSR5eEi7gCqYO+7Is0CD86XnMU2eA3T2rgnAq1ZHCBCnLPGjXHveif?=
 =?us-ascii?Q?uGpE5aZE/S0XnvPyIl4e6bmzmtrzvRNyiIN678q56h0QNH6fGP/YhAyyZqo8?=
 =?us-ascii?Q?RN9b+kvuiDn8IqcNUsD8r/Wksvnpu9RdKiK4gLP2ogt3vM7LIg2RyDNKHEMy?=
 =?us-ascii?Q?bMhVKRFDz3slD+zeFcbeAV+O0fmkPRwzP82ahsBQ0jprAzUHOl2kiJ/6eXSX?=
 =?us-ascii?Q?RACiwP6gF2W4OjILzvlNdqCnC+yZdVqxIHRyZUczwJgm1XdQuX6cQTvZFX0e?=
 =?us-ascii?Q?qlmpZ/GtsvgUJpPBE33UtTm2Z0oqGkg4IJ72HGTqzgWCFQtSwvmOg62jwOVZ?=
 =?us-ascii?Q?y/T0E6esVQzlNvyku5dxfuoNti0PEuHmODYiUxHZa92NTjOWeKEnY7CAjjcP?=
 =?us-ascii?Q?RBCi41+ztt86fo/KFgt64dlmN4vqL6iGZrhy3U1DozrSufQUxCXh253SvE7O?=
 =?us-ascii?Q?uMqGd5NXANWzjx2Gqk+WwH/g34BVCTnPXn8yplvqWJMYsMfMjUxdBPFuByvT?=
 =?us-ascii?Q?iuUlQSG00uIgsOHinZ4vRQWyExITBBg1CWzHKDDbjy0/UZAQs4mSmriwV5Ma?=
 =?us-ascii?Q?isCB6BUVZPP6qtjbznzpl7tFxhtB12F8jtqOPHk0YgKp9gaWsw2P6/7Jh4Vd?=
 =?us-ascii?Q?IR/U3RAY7Mb1MZnvECPQ3OKUgfJ5d/ZuVu1oHYO1hjTaLVtlUv/F5aKlOMo+?=
 =?us-ascii?Q?qa161TyMKz20Ov35EWenHGfhhsOOtkotveoV3y40XLFk5pBziABh9pUKITSC?=
 =?us-ascii?Q?r0IY2J8APf985K1SwjiD9vyxrTaYIFQF22ipIrHNd3FUyOJyU2mgiTxt2SNS?=
 =?us-ascii?Q?iudY4jwUdKvbVnvwNsT0lPFMTJyGWAiTT3HkfC00B8QXz8j6+D1H?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63972afe-c664-4b33-0964-08decc4b891a
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:36:33.1151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zz8WfNiwUr0wKsyYzjxyaMdz+pKBTOnnlvQgDXPKisRFKpHv+Xjq/OB42FDC9hCk4OWtKY3Gf8+RPAGFG4c6yu/I4G49hdARVCcBFHUX/+815rkposX+Bz7tQs/VAMya
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12634
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:36:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23215

commit d2c3353ddbebd07b27ded9813a665557cc0f96d7 upstream.

Add nodes for the RSPI IPs found in the Renesas RZ/G3E SoC.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/c8df5202caf4e36ee5beafe78ad0940643edcbb6.177=
1344527.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index cc0dc3df9e7f..10b7b8a5c236 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -591,6 +591,90 @@ channel5 {
 			};
 		};
=20
+		rspi0: spi@12800000 {
+			compatible =3D "renesas,r9a09g047-rspi", "renesas,r9a09g057-rspi";
+			reg =3D <0x0 0x12800000 0x0 0x400>;
+			interrupts =3D <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 500 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 501 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "idle", "error", "end", "rx", "tx";
+			clocks =3D <&cpg CPG_MOD 0x54>,
+				 <&cpg CPG_MOD 0x55>,
+				 <&cpg CPG_MOD 0x56>;
+			clock-names =3D "pclk", "pclk_sfr", "tclk";
+			resets =3D <&cpg 0x7b>, <&cpg 0x7c>;
+			reset-names =3D "presetn", "tresetn";
+			dmas =3D <&dmac0 0x448c>, <&dmac0 0x448d>,
+			       <&dmac1 0x448c>, <&dmac1 0x448d>,
+			       <&dmac2 0x448c>, <&dmac2 0x448d>,
+			       <&dmac3 0x448c>, <&dmac3 0x448d>,
+			       <&dmac4 0x448c>, <&dmac4 0x448d>;
+			dma-names =3D "rx", "tx", "rx", "tx", "rx", "tx",
+				    "rx", "tx", "rx", "tx";
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		rspi1: spi@12800400 {
+			compatible =3D "renesas,r9a09g047-rspi", "renesas,r9a09g057-rspi";
+			reg =3D <0x0 0x12800400 0x0 0x400>;
+			interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 110 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 502 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 503 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "idle", "error", "end", "rx", "tx";
+			clocks =3D <&cpg CPG_MOD 0x57>,
+				 <&cpg CPG_MOD 0x58>,
+				 <&cpg CPG_MOD 0x59>;
+			clock-names =3D "pclk", "pclk_sfr", "tclk";
+			resets =3D <&cpg 0x7d>, <&cpg 0x7e>;
+			reset-names =3D "presetn", "tresetn";
+			dmas =3D <&dmac0 0x448e>, <&dmac0 0x448f>,
+			       <&dmac1 0x448e>, <&dmac1 0x448f>,
+			       <&dmac2 0x448e>, <&dmac2 0x448f>,
+			       <&dmac3 0x448e>, <&dmac3 0x448f>,
+			       <&dmac4 0x448e>, <&dmac4 0x448f>;
+			dma-names =3D "rx", "tx", "rx", "tx", "rx", "tx",
+				    "rx", "tx", "rx", "tx";
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		rspi2: spi@12800800 {
+			compatible =3D "renesas,r9a09g047-rspi", "renesas,r9a09g057-rspi";
+			reg =3D <0x0 0x12800800 0x0 0x400>;
+			interrupts =3D <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 504 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 505 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "idle", "error", "end", "rx", "tx";
+			clocks =3D <&cpg CPG_MOD 0x5a>,
+				 <&cpg CPG_MOD 0x5b>,
+				 <&cpg CPG_MOD 0x5c>;
+			clock-names =3D "pclk", "pclk_sfr", "tclk";
+			resets =3D <&cpg 0x7f>, <&cpg 0x80>;
+			reset-names =3D "presetn", "tresetn";
+			dmas =3D <&dmac0 0x4490>, <&dmac0 0x4491>,
+			       <&dmac1 0x4490>, <&dmac1 0x4491>,
+			       <&dmac2 0x4490>, <&dmac2 0x4491>,
+			       <&dmac3 0x4490>, <&dmac3 0x4491>,
+			       <&dmac4 0x4490>, <&dmac4 0x4491>;
+			dma-names =3D "rx", "tx", "rx", "tx", "rx", "tx",
+				    "rx", "tx", "rx", "tx";
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
 		rsci0: serial@12800c00 {
 			compatible =3D "renesas,r9a09g047-rsci";
 			reg =3D <0 0x12800c00 0 0x400>;
--=20
2.54.0


