Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEE3C3601B
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 07:40:31 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.70])
 by mx.groups.io with SMTP id smtpd.web10.6123.1743752427376949511
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 00:40:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Jc3w/8H+;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.70, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+Afz1V/SVJeC4ukzz1HDZwe9Vid+aA/DBKm5BdZDhSJJCoRVUtKb6BnACfMWXLU9wPXrmBAsEkmaIPNpkpB/cyFUI8TtHvmSMG3Fwz/oTG3XhTpjvQ1wVS6KIk6fnCcW23fYgognz1TSWfispAC3PL2yRlue3JU/KZiz2ht1AecEI18pmTAcFbM6gKxBpWEDKaKQ2SMdTa+h0HS9EXSms+t9d81d2dzNn9t24Paob7zVFiE2LJ6Tn+mqPXzkpmZNxtIhSLc4HVrnTkPdyq5Yow2u8zhsJ5I83B3Pnm0X1YNf9HSQ5UlEa2odekBI77qXZ/Rg6E8kHkdSDlmM3/hPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNP0G7O7FsfBuRj7qsRlCt6LZAmHKn6T4PHVUDp801U=;
 b=pDLqRiEnY+XiMGsB7HYVz6BAbHsnbaN3d71qfhji33S6eZSci3MrYGpd31Orbo2ZvP332hwI7j0w9d2Q0wgOmdffXTZl6W36oFGYX2Ah6ok0P85oxkWhTC0vBva/vQXTWEh8ZqU46rHymzNlQftFDOT6hNtO4SNU0MAeZMSBncU2Gg7MapvlkbrCjKWdIiHKX3vvkS5+VxI1sCHS20AgDULP0erK7yjRUUHGFFFERKflHPCg+LImULxfZpS44db6x/ElKmJx8W7GgiAprRRH7WOwt34U56FLOJNvlxPtKag1k6baUAXMnMHgKiwPFwWw3EW+qnNBRCvI+wjJ54hyUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNP0G7O7FsfBuRj7qsRlCt6LZAmHKn6T4PHVUDp801U=;
 b=Jc3w/8H+FCN1o/5u4vOEp7uw63I5kEGsPruimGKjxMOCipZ/HhsBfzI/i0gMIzPwJK1/UMXCIGkFYGrEVbyiLTDyF9GCNXvbGSLoH19h8gLGXd6pI8kMets70obmgdiVGFv2fMS3KGd6zAyyQQBf+L/tAjYUBgduB6XlOW/5tIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB11793.jpnprd01.prod.outlook.com (2603:1096:604:236::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Fri, 4 Apr
 2025 07:40:21 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 07:40:21 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 3/3] arm64: dts: renesas: r9a09g047: Add I2C nodes
Date: Fri,  4 Apr 2025 09:39:54 +0200
Message-ID: <20250404073954.173387-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404073954.173387-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250404073954.173387-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB11793:EE_
X-MS-Office365-Filtering-Correlation-Id: c3caf0ef-a1ae-4f53-2725-08dd734bf430
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OelREwS1BRsvreLIXNCuhtYR8lYd9UAlL7dNnt9ScYkiJKGTnWuMIVTLVQTm?=
 =?us-ascii?Q?zVOHX08DKuax5QC/nDZEgw4+i/EnxU4Ocg9mwqfLhIdFQyxf5+PDH3vMBvnE?=
 =?us-ascii?Q?K9E20XQbBj+nITIJcx39eGoeHYw6iHkO59a/84Kjwi8V0nri17jw0nBs6yzd?=
 =?us-ascii?Q?KmKpbAkYTsWt3ijZcXmkZoD4YstGDcwiMrXrvE4rqmkIg0zDMU5PW/MS5+ub?=
 =?us-ascii?Q?5S78OLnY2HTo2e7zLbnwcJb/wRzbg82n3HtJuUf0HJkdPj09hz41Nlnf5lu6?=
 =?us-ascii?Q?b+YNkJpQt4F2RAXibbH/7ogZ6x2v+V9BzNM4u9q0RGXX1VbLODd9MXaBYMN8?=
 =?us-ascii?Q?+/LMjjsl8nmO6eTop5enNQQDjRb+k4fZniZXLDpeoKfsU2RVdO5VsFzwiXnh?=
 =?us-ascii?Q?2UxSjcu3yCI+9XcT1OfJsInupZIbvlYvhU04pmgrxNbU2RxtvK34uhbqnYVc?=
 =?us-ascii?Q?V1cJjgDIprBbS2LwHeBSBR89LcNQui99QOrM0/p1f8gGn0IzDHSdbA+/EVXp?=
 =?us-ascii?Q?KpylfFaa73Urp/gOxo5AZXOj6DTZsHuqhEasNb2vEDk3FQpO9pX989wdpAto?=
 =?us-ascii?Q?CGTiCcgF3GvgJ0P3wKwp2o0meuouGOpWwAGdbmjtiGRPLWdPwJH+BkqKmEs6?=
 =?us-ascii?Q?cZhHWKdwGBQCjAmG0krle8csqDaoPR0pKosgo1lloNbuztIyTnDL/EDaHQRE?=
 =?us-ascii?Q?UUMI1W2craQvqGUDWZ31POhAcewUKpnFL7VY1IPWuiH9JuwYFoviivR1KdCU?=
 =?us-ascii?Q?EN85S8NNnv4uzDB0J/jg0pA57n8M0ik/y1TT6ExCmYNO7dTuIqO2EU/fIDJ3?=
 =?us-ascii?Q?4SeqVLtGwniyRf8C1lcUuOxnJZSP5LEXS4OW5+KH/uEVCLyT+zjzWRtyVOQh?=
 =?us-ascii?Q?BObo8T1QFD/5E5UILXu0Pi6GP562KLQluyKbayPc+MpHJZivZAvP1dcetKih?=
 =?us-ascii?Q?htkV/+//QCiNdKIHmLfNCX2wfuo5fXrYysSMKdjjEmSvgUTCbPlqNl4x5r/T?=
 =?us-ascii?Q?yzuDpnR/bPuxzcEniPMprTqzpZRogYy7PBJirXstUf/PV/Z1lVeIAvDxP94h?=
 =?us-ascii?Q?vn0fxScSX13ICLOR9489/eu/T3gXK32IEuC7Xjqt2sBjRBrd/mqTSRxSHVoF?=
 =?us-ascii?Q?ygcqB3iwclw/ckkIguy2OzcQ8pLqsOEL9VvBO4MGma2qnxzcEePMXJZLSJYr?=
 =?us-ascii?Q?kqND5muilxd2ZaMr+kv/qAXit2shHiaK3O5T4Xin6mae6aY+gsmFyk5wYida?=
 =?us-ascii?Q?ldUoB+DwN/dfnsykEj1/zB/qOHiAPkZz3U08hv+HjxolED+hRjuTj/DNIcj+?=
 =?us-ascii?Q?2GsSDYvTchr82V00zxhe0M16tWHSOR9bR3SMizK956z3DyaodbLbR8TX8OMS?=
 =?us-ascii?Q?z1cOkiHyj5uIW/USrP6LAbUjRmsaIzxNEGOYDSEWPBJ/hma0z7Orae0EeIaL?=
 =?us-ascii?Q?HfbTlwijkZKarZ//XKdcu6m2BLuPUDFz?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PZQuQsm9hQPdwdmQNhhF6czEsBvEEAucQy82NTz1oGQ1V38r0xH9aUrJlJjD?=
 =?us-ascii?Q?dDqO6bGcjrds31BOWlMs52y5yTb3ZH+MZPuRVKs59aNkAK1HaCqlexlUNXzR?=
 =?us-ascii?Q?LkzZYBpnj3vo4yZ9yk2mIVN4cuECuRXliB0Yh/xS1BIhLulngAvlIzARBxAR?=
 =?us-ascii?Q?y329x69QraCWDe3/0miIX9uOz4K1DHz2yd53Zhnt5WUqBIOnnA85K+zskebL?=
 =?us-ascii?Q?IDL0anR0kc9jsjfoXjdZIwPSQjEecmWEQcge8/9SYDhMk5kzmGVBGzrDLBFA?=
 =?us-ascii?Q?ZimKdR1F8Td/ZVrjyIzh4qG+JtSoTW3EbV1MyGKDQ/8LXHmVR58yywuL7gQC?=
 =?us-ascii?Q?U6mtwYwbHXgNVh4Qou/8+WALXUv4GRkrmDWxfXCJq+4Aow58fWEFl1pHK5uC?=
 =?us-ascii?Q?JT24x4LH7px+KPZ7TL8wMU76RxJYG7n37rKzWBgtHOCmtaIyTJRENuXZzbjX?=
 =?us-ascii?Q?gXff+G7QA+J/u1InHBxx4PJD3hlWK2N4ToZMpVHYzWU8jW6CLl+U5FqEkRw+?=
 =?us-ascii?Q?hydYkYOiyfBbP9hmKUQKP6P3FZQNZKm0OFQac/QF/eUriNd6Ihzso9eUGBc6?=
 =?us-ascii?Q?eQoVQlKsDypy/FqA+/YIb8nT87LeE53ihvvdrBmR35JU5iG9EmE7lMXvIeeE?=
 =?us-ascii?Q?cdjSM71flUqeVVeRa2EpMo1Ws60z4w9PX9ao/rQOsfNjpuPHpC6bfqczay1/?=
 =?us-ascii?Q?cAM5e6sM/K005C0ITijkVTSNllC5NQzSN4sEIZxg8ILfCKOePBfxYZ+BAzuF?=
 =?us-ascii?Q?cYYHFpzBc0uerKRJzcmIxMWyQ2t7jRrW6zh4C0IJ/uZCo3MsmIaiw71MuNbN?=
 =?us-ascii?Q?UfiCoLp65sCi7zeivk/bW6uZK/TXNMgdx4ldD8VBmjmw2nJkiYL+ORNxLF67?=
 =?us-ascii?Q?Em0zvGt5nrSZAnI7TbGRFw1jUdUM1s2X6eLHX54GG11tMcCAkLwA8t5HbtZB?=
 =?us-ascii?Q?uS/hjwOedf3d7Wi2LWSPevuA1p0fEGKWMC2WKOe4RnmkjaxY0uUX9NzEgwPZ?=
 =?us-ascii?Q?qEcS/M/xHu+72uSXBp4PjiGDnVBON29g2007qcshKqDouZUQmVBYvYehYyI2?=
 =?us-ascii?Q?mFPgpQYadYKIbFbRnInFsP99iNDyC04+0a9iCVz+fhPG/ZmrDdyZ7JgIdCQ9?=
 =?us-ascii?Q?g+R7YUPqnXK2+0nGQtJVfYpXn16FVhWgerKrJSkBtt06rQoQUUcxg6D2StO3?=
 =?us-ascii?Q?9vhj8TJAVdFxqrZYo4cSoFG6izneLLUa1kC3YQCfjaW/NInuI4BRgE6H/JId?=
 =?us-ascii?Q?pZy6DyJRGnFmdKRo/cDKC4IekFo44ckArY8m9dnzRfxiV14Nv9BaE3x8/6gc?=
 =?us-ascii?Q?UjKG8r9aSWeCFzoRRTImcEQnUj/fpnKtVIcWpKzyNpZPx2uuVu3xqmyOljjw?=
 =?us-ascii?Q?vD7x8pg7ljpvw3SI6o0gMPcSQcqAE4zW3UaZshjwTU3ic4zEhu7dKRpplKJJ?=
 =?us-ascii?Q?o7vHzBIM6f/kz4XReo1MIHtnbFfLwWat1cwuML98PTkFFMcHRARW7CV8pxtU?=
 =?us-ascii?Q?H5gVt1VV7D+waHN2/kqWghhNfh9MJ3YkkNkztq7qvZa0X5pHZxbEGi7tFcY2?=
 =?us-ascii?Q?eV86qKyYX2OHIVygtVEVQ+4y+Y6SVQy8PE2K+Mvjp/AWC1QlQ1Nf7ct3wh83?=
 =?us-ascii?Q?4lIhU00yOMrFKEF3iQj4czQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3caf0ef-a1ae-4f53-2725-08dd734bf430
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 07:40:21.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BgYWZZ9YLgi1VSrHc0EEAvaDyOdS8hb66ZdZWhtFIK6aFpv4nPUMtaciM5z9XSbMY6DBqx8li7FG9q4A5Dq9Y2WkSrVnuruUM79BOaJs2kiXf8csDSZMZvkle0+KL0a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11793
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 07:40:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18477

From: Biju Das <biju.das.jz@bp.renesas.com>

commit acb247afab5bc2b4462f4dfc17a9d930e1153e52 upstream.

Add I2C{0..8} nodes to RZ/G3E (R9A09G047) SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241216120029.143944-4-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 189 +++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index 15711f9b6038c..200e9ea891935 100644
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


