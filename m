Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5742.1794388786397921250
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:46 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=D5oJmMqz;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.1, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwFT06//WyBLHfWMLfVjLrnqxzCtIMqS7pORDRDhwEthBpAara0ggj4sS0tNHySeUh9LR7sjWSOXvxMEz92cc7oeUV2kH3lr2nDA5Uc9yI0xB7kFoRY0YnD1OJ9EAJX9wLf0q045cTf6AG8pZurscPrfwCV5kye/UaUWx+iV2IiW/3UQmSFQVbHW6e1J1hSEvzSfkqI9IwKhzoXLUc0IAKyHXb1f8geLJnoVxmd7FWjcVV2bf+5ec7T5JmeZIKrUguJFWSjgRMQkQUWGD27RBzeHdZx1wGLRiQZA2k9yZV3CDKfccoawkbYWdSxf92m6Ge+6p34/rS75U7FUskBSKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7idJGvAOWwm5UbSyyg3lpLYovkYdZ3fL4k2/p5jzPo=;
 b=dJMDzHTOWHNlnfDIPu7/J8ejaoZqOJPFreD04uHniN2Uf692Clp9p6mJje4gVxAYGEKnswEMnXyQI7ts+5k5AScmtZKibKNBMonnxHhpnxfLSgVQx/De1coBvIMYtS5GA/rZGjY9NC5iEHg74KTr7RU3G/iwwWU46quNxQBSKZGM8V7JDsyDJSD6xExgeVmRZkoPHLtohdrdQJG5i6L9la4+sUlXXkPqxTOvqZ/4zS0GYnJRw3xxe0lAWu2CUj8JZeH1MHzzilDoUmU7L1YsuPY8VTxeGhdNCaN3J4+XnipHmucWOW3CD29uPz8emMjwhqV91XXGp02uXZANUqqpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7idJGvAOWwm5UbSyyg3lpLYovkYdZ3fL4k2/p5jzPo=;
 b=D5oJmMqz3INul4A+tQPHI8h64iz4x72WRCdkXbKIwmvs9qDgeLH896SPQhwxrDC8Qi8fM11FJHh3QkiZp8ReaTFSE7K7YyxphRcwg4XZEacW3kGD/p9pcIky+JxmkdSFiBLK6V2il0BnIdAeoHUx7gcEFO7Jf2e9zQ9rTrvrEek=
Received: from OS3PR01CA0002.jpnprd01.prod.outlook.com (2603:1096:604:dc::7)
 by TYCPR01MB10383.jpnprd01.prod.outlook.com (2603:1096:400:226::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:36 +0000
Received: from OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:dc:cafe::a2) by OS3PR01CA0002.outlook.office365.com
 (2603:1096:604:dc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 09:19:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003C.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:36 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 62DF63001DF5;
	Wed, 11 Nov 2026 18:19:35 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 20/21] arm64: dts: renesas: r9a09g087: Add RTC node
Date: Wed, 11 Nov 2026 09:18:59 +0000
Message-ID: <20261111091901.41995-21-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003C:EE_|TYCPR01MB10383:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4091ce-9a8f-4598-4622-08df3fd4e804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|13003099007|261021121427099003|261026121527099003|261028144727099003|261026140227099003|261102123227099003|261009223027099003|261022105027099003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KDWBY4s9lB9tN4y9EtJo9+c1G4d18cn4ZPujem6Xml5ZddS1OUyiT8ta9/6lyv3yDXVmXpTVATcqoZAGp1PdzPaHxiuCLsNP9givCIn0CmzdTMMucyDV4CqDicUd/xIzsKZoNIOd+/SrDnjzxi6KeAgWtXhRxK+/xLLIixkGSlYYl2gn35cMldZC240pwwXg7IA12PcfJ1RJko3B+a/R8cr0HNZgX+RrxjGzn1N4lxo0WHxIVPLdkceQLVxXjtVsJ4CtCnXm2BGU5AmUEEGitPYjybuA73ZkENgwI8ncIkLyIMn9+Mm75pAnEki1LPaBtnmyZyFUW8eOwox9ZkOKSYr1Q2iqlSDN4EgSVwCqyaoBVM+d2hsTxxbxHQtMrQ1kxrKT3x+3QW5ig5YmYymvix9NwH1fe26TqMKkxE9/0vNvQ62RmrF1uA5PGd2d9UBEK27roDLhEBMnpqRB+0dbgF112F9ApUysURGSVwbJHZ37WzcMNNacn1kcUOU835UNEkNqKczynSBRAFGQGDybVMYd23v/T+6izSNZai1ElLCSfAVEdeyqT6/cGH+cnLo3u8Kcyl/O4lMfFqGVJlBgz5PyhhIZyz471UYJ4txfn/M8dBAyGS+sMOVUDNN/IeQT+A4BZhVoB+UI3B7wZYqUHv+iMIOAbPS/t3SVa2SjXRk=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(13003099007)(261021121427099003)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(261009223027099003)(261022105027099003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RmORt3m6lxFRtDQLPsIPHDeLjiXgtwJwKApVDvw+ACGyw1xinRQ2wVX1tAOF0iLhafnE5PAm39LgiLtFPuw56YL0CA0oGDMKjFZ9E03Pbsb5SD4l1pt6wnBuXq9uajOYPV9EXqQm3npsE17a6zAum4sgnvIX11qW23BXTmOM7My5XepRtrsKhZr6eQduDDB9dxjeFkFOR6mX/i815O2Ca8Kf4+HrCyzZ22qJYTkdOjtjY+2Gw0kmZ9Lvgf8Bi4TVafoPZBLfJpOh0Qmadgy9zfPqciMmehrTEZwz9aurgmAIe8upLhfQ9CffJqlRogqZ+n4MQT9USGao8KKkPN2N/+npUD6dfb/y5bdvBH7cNPvDSw1lrldZNSEL1Y+1obX2DugkmIxFjlCN74lxrEYe0txirCcyraCaaQBg9egJQ74HXy6s2nRc1UgpDlToj70A
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:36.7480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4091ce-9a8f-4598-4622-08df3fd4e804
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10383
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24762
Content-Type: text/plain; charset="utf-8"

commit 727533b7fad5bed6ae9d79391363c8e78e2a4e02 upstream.

Add Real Time Clock (RTC) node to SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260824075936.2904336-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g087.dtsi
index 3cffa5ad81a33..7055c0ee1af3b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -1110,6 +1110,19 @@ pinctrl: pinctrl@802c0000 {
 			power-domains =3D <&cpg>;
 		};
=20
+		rtc0: rtc@81009000 {
+			compatible =3D "renesas,r9a09g087-rtc", "renesas,r9a09g077-rtc";
+			reg =3D <0 0x81009000 0 0x1000>;
+			interrupts =3D <GIC_SPI 495 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 497 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 496 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "alarm", "timer", "pps";
+			clocks =3D <&cpg CPG_MOD 605>, <&cpg CPG_CORE R9A09G087_PCLKRTC>;
+			clock-names =3D "hclk", "xtal";
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+		};
+
 		gic: interrupt-controller@83000000 {
 			compatible =3D "arm,gic-v3";
 			reg =3D <0x0 0x83000000 0 0x40000>,
--=20
2.43.0

