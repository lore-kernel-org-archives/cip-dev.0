Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F0DCD98F4
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:32:05 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.71])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10942.1781685125123537376
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:32:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=o9+PSanp;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.71, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEvb8sPsC+taxNyd3zRYyl9cZ05V/05Gr6zDcXLCjtWDPb/bvaATYeOxYXlc07ZzoGg5RMdN8GUg+RbzaEmAB2LS7qW6yjNy7sVItYidlZFPkyXNbY1ZAKBu7p5Y7x363dQigYcUyHQnuP8pot0NbfQPI7I/8waxhxf3y8jPXcHVrs5XaGkFnVX5iwEyhJuSIeeHRJ0Ocysheaa8dfYcJdRtSqGMjV6U3ysV8qoFH1bPRqZw5gThBVg3A3pBxWqxbn6giByUi7U9cZ2jFZiLAGR32nraxl4jQNgAj9w+3+6ktPF7JZozRhkCpHDDi/4rVeMMbx6+4oGoYTpsZ7yZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yGf1dFPlqwQ51NwUyptxX/XJUKweCl9J2SIez8nnmM=;
 b=E7ZlvgaJGS/cz1VMEMLvpNvRjNvx5sRCQNOTYo0RlzSXfvX6YQR2YKTqeGYHx1XXevFqg0I1yvfB4ElPcyFCNkg7qkW8ypZQSPCqh9hYPc8oNVMt13FI4ug4OvLBukkA3bCHxSxkGE8fukXx5KPD+VbfZXdDAoO7SmxTwfAuEphtOfaxzWpNjX7oypS6a98o7BZ+r36k7/MroJGbf9ZxxfXyptP/nMVnhbKxpEJUvctte0nj5KLklLKWOseSYugDiRcx6g64zQoLdEfrkAYVDZhKmPW2WOaQIja3OM03W5NGII2nDITfcr5awFW9ow3FpX40tRI9TITZOFER6oNkCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yGf1dFPlqwQ51NwUyptxX/XJUKweCl9J2SIez8nnmM=;
 b=o9+PSanpEcgfhlPl3yjptX3Vun/3jH+DkCndn68oFd8h0oC4rwlG647x7A1getzDcRjuZM1+RUdn9BxSUEiT+AzxnWPYWNpiTPkYPqR9IYcp/bomCjfAuJS70K1/OWRqGQRJF+6dndo1GCcZOgn+gJwCrv36lJApxk1HhLLONqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8108.jpnprd01.prod.outlook.com (2603:1096:604:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:32:02 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:32:02 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 31/32] arm64: dts: renesas: r9a09g047: Add RSPI nodes
Date: Wed, 17 Jun 2026 10:30:02 +0200
Message-ID: <20260617083003.1071543-32-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1c5c40-c132-4db0-d971-08decc4ae7ed
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|23010399003|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	fRgWHe9e5Wn7olhtJtgOe0Qg077E+qEPZsn/3QPhDKvfXCXwcEy8A/UO9OtHyCb7c+EkwDzxteGizba6pzEqgWruE+qa4qh8lgbSaheKeLO0RXG6Axh64BGLyKnRqal/+AFP6kSeTYWYcFBchKVyyQHhjXmKD4MOJ4zFBxsglODufVLpWRpIeftiKIx71vwVqIXdm8dt8WyluGAM/6T24Uug1vrHXOsaXYDTtZZV23FSq9PTx9Tr6qKFuJODQiQ+eRFMPsoSi1kz25Z/9bjI91ZhdLlRiGrSVrP7qUJWhh1iITg6Tw8xk7gf8chME1uauY4Wyk+M0/YMmpwyLFFLzGLlUEHTZFK09m8Kx3lcRRk282tbLUEfiCc0x20BReQwZIkluqrDCIvS6XpunapgwC9gG6Cf4UAVTncucx6JDo5K52qU7nx4hGh3uQI0Tm4STEq+BLdKcsTVyav056LtTd4cGAVUhBuNW0PNxnK3kUAO7LlH8yWA8JQoOC2TFhbo8wxLjlGTvgvilfteyAr1OeDNRCwU+APBjSR333QGVk+LZYxYYdCSsxgBjvzPDwzSIqUYgCExM5Nqxtsvfa3kDjclmomEMpPzYWfFSWzcImgUXxJ30axtNhw+31860n/TQFcZiGHrwTdBJ+D7iOloPlslgqaxKzbxXXqlQh+WYbfxQjdHWhTTkXe/A+ZWVhsPGkoukJGqxsWmHyHZCUo6JA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(23010399003)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3LBS9d684/cdkAkxbpm7h+RiGSg+sB4GU/bMylwBUu0hUt6okxMDIIjUye3d?=
 =?us-ascii?Q?eisWpEax5fCuYCE95O/rxdD3LgSKfsK7ZBc7N+W9Kkde3erYiblB/9L9mKMd?=
 =?us-ascii?Q?/g9jPSYji0oJyl1r5y9q2CsxfnKU7vHMoYOp699B//gHZ+GyQra3okZsc63g?=
 =?us-ascii?Q?o/BE+irIlpb92msklQ85Wv9tkJXgIPbCfxrAT/nJoaZD/UCnjeLyuzsHtbex?=
 =?us-ascii?Q?nbm9dfems6fGNuoyVuGKYUNXoN/7stst9qKP25t+ixc3FUZdm6XLh7z7EIwA?=
 =?us-ascii?Q?21KvJNvP+cca/+U59yCZtTmr9rtOa5DJ/2FS32rIEn8ebWYLWaMSwn/m7Gr1?=
 =?us-ascii?Q?lsiWvcoWq979OMheU9kTJKK5lW6qTZN4280S5Xd3zviENfwQ0Dpb+lAAd2Xs?=
 =?us-ascii?Q?dLh5Rvq8Xk182+Q2qXRRIl6d9JZWoIBSpSxCyxVvKkcfIqzrTnOx/K27hm9A?=
 =?us-ascii?Q?QkanQtfOJWgpzTYROLbufE03THYPU8Iz/WH4tew+y/dLeVEXnXGSx8MSI7H0?=
 =?us-ascii?Q?gJWigkPghFKPBGYHUVpMsKHO6olzObWvMnMQc39hCy0uUxlI/mpEBAdQmBYq?=
 =?us-ascii?Q?r6hxiYgSjbvMxCXS4NRnt68d72HpLjuFzZNhLgTrnuq0pHr7ACdZDvMrKjAY?=
 =?us-ascii?Q?AzcKPNduIA1OHaogkB3c+5wRzGgIXSgruBFe6D17MErsXbH37FmQHoj6Ja5V?=
 =?us-ascii?Q?C+tP/v4QT+HUF3F4Sl2pUdODlL4ZAX+LxR3HIMor1CcTphAZ/hjqTtu9Je2Y?=
 =?us-ascii?Q?88a2McyrV+egLfxsToauVUiFPys6cQ9hJp1qwwTD2PKUr6uvHtgA6ZmfjtDS?=
 =?us-ascii?Q?4PI8R1RldXCMDnfCoNQKbi3h9I0n8nfuqyuwzSWSo8qySB6mwGrGVTXSTYiw?=
 =?us-ascii?Q?bXN5Ap1VgZAi3M/jkUtVZOtgu+57tg3THvpq7z+OlHXIPA2z/nDXA4voNQvY?=
 =?us-ascii?Q?ApRfNooGOCb6dIVhaFk47NO2SI4PP1pdKClI6cqJvVfkB+n/jM6/tPuJCAoE?=
 =?us-ascii?Q?NOU1G3ZowCGOKs0nX8Lm2HvSkl9H6GQHfTIBh+ntoOMLv80Za+KJ+dz5Hb2V?=
 =?us-ascii?Q?u3ZQDByOFg5PReIkHwKkN3J0/GPOK9F0LoyCsgytqu0ZqWRBiivzlh0fmTER?=
 =?us-ascii?Q?usDV3yuaFgGXC122a0e6bHiPajATSDCDZYUFZUaoo+K5ApMrZ7qxElNR3jXi?=
 =?us-ascii?Q?6OEWGMGem06QNTfjz10ZyTOhWfv0Ih732G0nEYffaUfGWfEZbHd3O9KZiwzD?=
 =?us-ascii?Q?1FECFHT5xVuzhwzWqyL4SO5ula0l5SUl9TAY7a6wU5weHlC42Qf2cwoF9Tvq?=
 =?us-ascii?Q?OUqaHpBxdv6WnmE/Yjrv/2toKBdFneQ3pD0DQekUsT+nVH2BBkzCz+VRzOAy?=
 =?us-ascii?Q?ndKf8U1gR0jzQcUHdPmyLWiOCUXeT0PVLTRL/vSjEa8SCkuqzpBmrMCPpe3Z?=
 =?us-ascii?Q?AA9pClZY/3jCkLOhxhsCDUQWTjpMBJGSrRXJb8l18MJl3expwZJCG3H1mQKz?=
 =?us-ascii?Q?sl2HZeImGWcq7L5CiTAws/zY18OziaTX8h/XJU9iViiWntmdHlr7VpcQqE/S?=
 =?us-ascii?Q?2iUORo8Yhfn1GV0UgsN+7/fEhYIJ9feLIfjuoyJZ+NBp2NEr28OJXhO0xmhr?=
 =?us-ascii?Q?txI2u3ZvIXYZaPzPAOsRT2/RqZd41DPciX6DHj5k2Fhr5vkYPXetZ4mYZY7r?=
 =?us-ascii?Q?Dfx/0jf81TSc+S7Yv9dZcpUA3e/fxgETx2Czt6xwlY1knRojweSowBYa5Xb6?=
 =?us-ascii?Q?h0C2S9PLyvEqMZh+Ia07QqrXU4wzFd+m42hecqgQZNWPegOp79Ff?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1c5c40-c132-4db0-d971-08decc4ae7ed
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:32:02.7624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1dQ8TuXNhUV8Zv/Oz3+oegc/d8i7gh4fIGXGOfeAptg2Y6gSw1ybxQpTdUecwbzq/YwT/hQFURHpzBXjETbszN+IZZG0TYCVgJv6QWczezdJi3HrmSJhFMhI2+2G6Dg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8108
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:32:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23190

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


