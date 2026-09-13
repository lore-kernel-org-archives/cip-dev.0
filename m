Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA81C88E69
	for <webhook@archiver.kernel.org>; Sun, 13 Sep 2026 16:37:59 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2209.1789317473330318285
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Sep 2026 09:37:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=bdWZ63B3;
 spf=pass (domain: renesas.com, ip: 52.101.229.51, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTduwetcATzTXT5ZJCWIST9KcuEP9CacDnsHR0ZhKe95IrGZyaGOm0fep5sd8+B6dik5v2ABpLCY5k3tTxv8VPjXxy4eO9JAdkz7wVTHuheFHxPCg9RGnkLbTatd9hDFL35frVzDE7Tz0zhKE7HMD0Xk2Z9fB0ccbovAMN8vAj55WvThG5BCYVWma3j5RNL29rkoShHYg+UL57cIqeuJWzJIXKp0i7uPajo3ZOCheQ9+QhNHbGYLIlBFvNvrKN2tG3pmB1lT2o/KFE2OgCIk3EfN5iyd/l1jsa1Q05xFlvHP4moW+QikOU44nkNaOEqk4EO/I2ZIwuhfmUfCmUrZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87iVhLPDXtkuRhNe5RPCwfs/IA4zzYOlVH1GeFq0GHQ=;
 b=T5cxj36l/4So9J6qmU1k+hDeJYEYYa2c7PC5H7UBNjPcmcxlHWxVpXKDjyI2oRjU8oRZggtIogoWPDIqt15eSwol21QS/urS24kQ/4IxGKVfB/GxV0acWxH68dNH80AT1gXnQEFKuLTxu8yeMZDYE3oY4XajaykkBcRLvdwNcWBdaDy8yvK4ANvywBV8JwemLbBAaY1sBUXgfls8kiU2b1yJoPFkGA1XjF/GyPJy7SgBjm5LDD7N5CKmafBxiLkuUwHHMV6c7VzEaujs+T2n8cl67dgIXx9FCJ7wtRGdZ5gL/mTf15rRWjdgbicOg6N4ikWmCAUWbf5jBMOHYByrQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87iVhLPDXtkuRhNe5RPCwfs/IA4zzYOlVH1GeFq0GHQ=;
 b=bdWZ63B3iBhvT2TebJ0rOIA7N25us56+MLT3xWgHz2V9ejlhMkPMGZ4TJQQEliImH0hVkN9p3Ot+AZVs8JC5e6ZSJ2L5Gcoc4TtDasK/gogvEHYWZ0VvVVuaboAz5UUEhff1vMSFeg0QHoRlFduf/OznLQJOtLR5InlwHEF0TMM=
Received: from OS3P286CA0079.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f6::6)
 by TYRPR01MB15855.jpnprd01.prod.outlook.com (2603:1096:405:2d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Sun, 13 Sep
 2026 16:37:47 +0000
Received: from OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f6:cafe::2) by OS3P286CA0079.outlook.office365.com
 (2603:1096:604:1f6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Sun,
 13 Sep 2026 16:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20F.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Sun, 13 Sep 2026 16:37:47 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.2])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 48C29300024B;
	Mon, 14 Sep 2026 01:37:46 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 1/2] arm64: dts: renesas: r9a09g056: Add DMA support for RSPI channels
Date: Sun, 13 Sep 2026 16:37:26 +0000
Message-ID: <20260913163727.77875-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913163727.77875-1-ovidiu.panait.rb@renesas.com>
References: <20260913163727.77875-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20F:EE_|TYRPR01MB15855:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0e772bec-3f10-4f4b-6f78-08df11b55836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|18002099003|22082099003|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	NTOWHNwSj/SMtxyHDKUPypfve+wrPqBzidfsDM4qubeCQbeEKxpUTEAL/Ue1CUb2nh9RPmDkstwVKYuXdeNvKKEXIFtfxRAotA0SvWtY2QFTjgEb+zSnSrMYG+Urs+G7SY66urf5yh55J9y7L+9hG1oQ3+LJ1MENIwpETtmwzrQ5r9agZMhL1THpQsEHDCeQw7A7gR5cdRGLxaXQVuIOsx8v/EcgP34nWZsD0p9BuzP7QPlfOM7k3kGRO0Wjqx/wZ+RlrOirGary39ludiZ38jyO2kdAtGamTV/amZhyh+Qsm11Qc+CJUIQoWhUc9/89aSPGYIFYEno9ZM7ZcaYIK8Hj6IZZCy62uIKsvKuAAVHHfmsnAYwUhyIyYEwEBMOKqU2i59ABUuwAVdQo8Wi4yN1wuGGKGcF4jIeF5s1sCgXOPSSzlTsIdigqysGGO/Ue9tl++p5kDHjYCQB62KQs/a3pJo/MXi/6uAiLhakE+flaeU3VZrX/BEUaF3USieHyjO1GqeqrAjewx6rQ5xPmj7UpygALUph3YIidFL3HMNJ105JAgDXVeyrwDSb6nPNtwg1JLiil2G4qjA9yRUWPUc2F6FwP7ZIU8ASKeCUNGzndV5COsm7EnkVOQfHmrqn/TcPQFlZ/DKMMm2oB/T1sNQ==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	n/e5CeRTEqJA9DJMiaG81MDZeAgdknVvfQ0LYvhbYgLDmVUsXGQrFswXAWZa/O0l1dSZN+35+TGxZjdtobVbEG76gxHDmWhUo1cYSyjGu0wJ5LBCccB7dl5AlThuCDjhSQ7VeCYHjS6fO4DlYwQVV67wN4beTKSNZGcWGr19rhB7Z5Lzk1yQgbEtxHwlOTp/SWIFyfUVwEbuGd07SkQ8wtc7/gmnb7QlMFnmnTABOGHdKgcNtg2F2MdpQM4EZyie/1RdNU4G3uCmC44kIg/or5YkgNQVTmnvYq18ZzGYVGhy6y+O5qA9HYziI74cAIX13DqsVchxYqvD8+oDdVKtyYsW7q7wlZqJvwwRoFiVDMnbnBrBZNXU5e53SYZ2XQ3GMkvEfA4iGg9jk3RARFMx7bSEzHwm3M9O8R5/7D3P60DqGjlK609X6p2dxQ03PJgn
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2026 16:37:47.5969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e772bec-3f10-4f4b-6f78-08df11b55836
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15855
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 13 Sep 2026 16:37:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24159

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
index 9a244145c60d..0a772365c577 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -731,6 +731,13 @@ rspi0: spi@12800000 {
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
@@ -752,6 +759,13 @@ rspi1: spi@12800400 {
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
@@ -773,6 +787,13 @@ rspi2: spi@12800800 {
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


