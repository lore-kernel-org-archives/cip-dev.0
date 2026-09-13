Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC876C88E65
	for <webhook@archiver.kernel.org>; Sun, 13 Sep 2026 16:37:09 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2223.1789317421841505004
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Sep 2026 09:37:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=GivOj5uv;
 spf=pass (domain: renesas.com, ip: 40.107.74.0, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnBL5I48ifqbKkFTxohVN2RP1UVZ+HxrqW+0ZYl2xoh21R8E7WAuvfdvkN3H7KZ6W+y6JEWtG+W4LAOsuXJKU4M0rnZHFYvORMyLwHX/IZlNv7xewvlkwzZjtPeP7Lkcs1XqqzyUPhc9E5owtzgV/HTkSbwbcO03/WjBAFnfH4VGxehfwRz7cySBDbC/qztCu90ZaJ6zCNMHru2y+Q+yYFuxlgfImMnFn5CqA2hRfy3603wVpnIOSMH3BTVOCA9LfJx0zfSx9/vs8ZVz+QOlovm/zQBL+6FC9I2ellXU3bU+6/Xpls3Nkte9jFvrBUClM8JYmAIa2I0ykG45iBumaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SV0Pj/BllibB5pR2Wikw+9a8kWnSjrBB1gI1XAxHJKg=;
 b=OFXP3ctcRZ/ZnOhO/HzcQ2h/jQdGYEaRomawAsX+f5XPp5QE4ete4d4fW5gr3O/cRelcOldrAPKokZO1N0WClEE/A9HMjZDmSnHrE07dTe5q2Ykl3fS+7KPv75tyWsEvvnOQnvD2NX41fBRSX440c+zA9Rg0jRDWPF7Hef2QeOSrVUcMJpFpqn8ZBKKfNZoXiUj6xo6r6IUgMyAdxAVFyXQ/V9jiCKn5IqKuwrDI9DoiCpM9iIvaaApJxe6N+bQ7lQ1NE0ojbTdNLw3bY3PRAe9WXbaNUoNNZbVJPspJ3r0TAfjqg7q7aSALy/Es9V7L8CHfjrdPqYJyCXpiZRoKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV0Pj/BllibB5pR2Wikw+9a8kWnSjrBB1gI1XAxHJKg=;
 b=GivOj5uvSJSE1V9oyRCan72ckoQjg2S5iL4CLthTkstL0Us8/gGQBuGD5LmOGsnIGFH5K8zlpOezZMuuCj1UwsB1t5rV3CpHj1fC5sZttWTEgcTTNRkGNk6pgtcZPiViMKBdQTtYLcbugrlkpLGh2RD0NpFGh0ve+gI0zIPIXQE=
Received: from TY4P301CA0069.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:36a::6)
 by TY4PR01MB15936.jpnprd01.prod.outlook.com (2603:1096:405:2c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Sun, 13 Sep
 2026 16:36:54 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36a:cafe::39) by TY4P301CA0069.outlook.office365.com
 (2603:1096:405:36a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Sun,
 13 Sep 2026 16:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Sun, 13 Sep 2026 16:36:54 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.2])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 43810300024D;
	Mon, 14 Sep 2026 01:36:52 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 1/2] arm64: dts: renesas: r9a09g056: Add DMA support for RSPI channels
Date: Sun, 13 Sep 2026 16:36:33 +0000
Message-ID: <20260913163634.77803-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913163634.77803-1-ovidiu.panait.rb@renesas.com>
References: <20260913163634.77803-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|TY4PR01MB15936:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cd065d81-c0ae-42b8-919c-08df11b5388f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|11063799006|56012099006|10067099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	WuevIxHMah9Yiegrxq4r7MvXIblgVcnF8HNFMBZnvoCjHXWw0CSsY9m3yVRZB0QS3SAlyXnOW1ngqd8WMFAUHzedyey0TKnLRM9gpJ6iQez/rW3WtB40c5fksioL+tarY9D2NWwnc83S8+BXJU4m9AZPbvNzlhf+dasucp4MqP6AdSrcgkDM/vtHwjnma3+VfEVFyFfvxxcqT7BgGR9O5vmzu6WKVsERygQotH+7jwb5i9Ipf85fIdCKTlS7HiDfUMXIGWWgxJ9BIq/gJp96TbveOnoaH6ByKDFQILBJZCgfLr13xPD97c40flD1En+3PXPIuWmq5oubQ6mK8OpDua0Pvy1xeqXyjp0BioZnKmdN57a4++BDzd7l1M7nI60uDpBe74m2POH+QJFdLm2mhUA/ul/Wh8BBp+shY40k26sFHEiSYaD7t/GOWwlvP2RsLRDcPGkqFq2W8meCkozxSMpAo5tAK5zjbPV1mbnbTgLTSjEgw/U876Rutz/cKYsCevxC19ipugJXt3Yk9GibOAqdF4BtjtKNKhMEatM5ItfgMQZQ+NXCRMKgIFt4r0PgMpFKeK8GAi+UA0cxmfIwHWCi6aVXy2Vna0GatYz+hXL1S+Y1/UQdVykxGvSpN55c4Y/cKP5po0Yh9tsHy8DM6Q==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	oMpZ254EhDg6bnfG1mHJGD894W7OnH3Y5oobSpHz9xZg56sGHJi/s4/oJK6FUeLMGT9kPwWHmBhiCI1jcdSNw1b8xyqQylVUkj9mhQl0qj2GHnPa12PRG76xG4iFIbS571dW0ICAG0tB1wLRWiwKiD1Avpkb1hkgkqhDD2tURHiS098HPUT6TSX90W1p1XKFgvIY0j4UzgxI2hD07Ny4b7B3qOVFj8Bv3ukRgLeBKHxDhX5QND/UWTyRc+Ul2wS8vlys/OFTphf1QnsRWkmjUsjQkEBIhxWUOEFLxGJIMrBd4zftUKht/w9Wgsn/VX/HV2RYrDfHBVY5eJiO674I49ujJ8De8VYjdSh2tvHY3+9Kc6JBJd7SY0wVkI7dp8m+VQbbEhTiE74iTSxZ3d5r2P8pt5YHGZ0KsPCM5kiZXY0zpJ1QmGQYw87nADyPBioP
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2026 16:36:54.5092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd065d81-c0ae-42b8-919c-08df11b5388f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15936
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 13 Sep 2026 16:37:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24156

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit ce2c7ca2c2acd252c495da0d924f48b70f2f4198 upstream.

Enable DMA support for RSPI channels.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260303233314.2928711-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g056.dtsi
index d76c0608524e..0a0d7b400486 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -732,6 +732,13 @@ rspi0: spi@12800000 {
 			clock-names =3D "pclk", "pclk_sfr", "tclk";
 			resets =3D <&cpg 0x7b>, <&cpg 0x7c>;
 			reset-names =3D "presetn", "tresetn";
+			dmas =3D <&dmac0 0x448c>, <&dmac0 0x448d>,
+			       <&dmac1 0x448c>, <&dmac1 0x448d>,
+			       <&dmac2 0x448c>, <&dmac2 0x448d>,
+			       <&dmac3 0x448c>, <&dmac3 0x448d>,
+			       <&dmac4 0x448c>, <&dmac4 0x448d>;
+			dma-names =3D "rx", "tx", "rx", "tx", "rx",
+				    "tx", "rx", "tx", "rx", "tx";
 			power-domains =3D <&cpg>;
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
@@ -753,6 +760,13 @@ rspi1: spi@12800400 {
 			clock-names =3D "pclk", "pclk_sfr", "tclk";
 			resets =3D <&cpg 0x7d>, <&cpg 0x7e>;
 			reset-names =3D "presetn", "tresetn";
+			dmas =3D <&dmac0 0x448e>, <&dmac0 0x448f>,
+			       <&dmac1 0x448e>, <&dmac1 0x448f>,
+			       <&dmac2 0x448e>, <&dmac2 0x448f>,
+			       <&dmac3 0x448e>, <&dmac3 0x448f>,
+			       <&dmac4 0x448e>, <&dmac4 0x448f>;
+			dma-names =3D "rx", "tx", "rx", "tx", "rx",
+				    "tx", "rx", "tx", "rx", "tx";
 			power-domains =3D <&cpg>;
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
@@ -774,6 +788,13 @@ rspi2: spi@12800800 {
 			clock-names =3D "pclk", "pclk_sfr", "tclk";
 			resets =3D <&cpg 0x7f>, <&cpg 0x80>;
 			reset-names =3D "presetn", "tresetn";
+			dmas =3D <&dmac0 0x4490>, <&dmac0 0x4491>,
+			       <&dmac1 0x4490>, <&dmac1 0x4491>,
+			       <&dmac2 0x4490>, <&dmac2 0x4491>,
+			       <&dmac3 0x4490>, <&dmac3 0x4491>,
+			       <&dmac4 0x4490>, <&dmac4 0x4491>;
+			dma-names =3D "rx", "tx", "rx", "tx", "rx",
+				    "tx", "rx", "tx", "rx", "tx";
 			power-domains =3D <&cpg>;
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
--=20
2.34.1


