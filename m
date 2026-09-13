Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986A3C88E63
	for <webhook@archiver.kernel.org>; Sun, 13 Sep 2026 16:37:09 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2224.1789317422644103678
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Sep 2026 09:37:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=W1nFCloV;
 spf=pass (domain: renesas.com, ip: 52.101.125.0, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bR7PydTRz9bJSYLN1kd5jAgE41vK5dVsuGbWWPC/4kLp45GYA0BSIvAdFOWoffT/TJP03m7KYdlu3MgcouIlHsQClgZXsvNdCullSYJgh0ljgFP+VqPNZ8OMtxEJLZBYNaaOgi5mQiWJabjhFMf8UmjwQTQl6xYYNTV6Cbbre/s7IoQ5ICPxbiIKpBKsC3zT0J9T0nGBB/iu+Nr68MHa9zDE0W/xIsLwmZDlZPhgQTtolZzE/Q6wThL8CV5u6WOMPig/W35xgXq9sGKyoAR9zBsx73rvW44P4ce8ifIMXXwoQlZRUydKF2/X1Fj+mYZkPi2ziO4W96+CtjPiGKd/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPUuYe9L11TBwUjqB/clpDJY7Xqn70IF5i5ep8ucb1s=;
 b=dzZw6xUlQCxyirgIyhj/5lBOvzNMBTEPAdR1FyuK/jioe8kkgG3L17swCqH4lG3R4kUh5gnXLrUcMaKF9sFx0mHF5WY8Sh3S+hOIqgMvLvHUMAlCInxx/laACzxnUuWm2xT058d3y57X5ZvmhWXCrVGpaSXHF7Pp6Jh6e6g1Ph5zAyp6v9syUXPmfx7O0gHMV1+c7ehZRHExzk1R0D2PPRCROr/RTfuJwy6aT59Fq6B6KrV6fDTnJw0Pdn84glMgFtIz3sZKwT6qud+eFTft9zR+vqKMoIOOI2jtu4qf8oaHFM2Ziy+Krt3oHXJ9NbiBwH+vGRYhaqLZbuHtXKgeKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPUuYe9L11TBwUjqB/clpDJY7Xqn70IF5i5ep8ucb1s=;
 b=W1nFCloVSJtod71y3kxWOyKuGn2Gcg4OZvgaYig5zUHe/uIRFLgEMpCEZmhJ03ozJtCYEjTRehJ2vtqONc5u/co4T6qNaCh/gtgTRajN7EgzwFrOKZHfquGAgLQK6DXv8PglXjIiqCPt0idyqmFQG9IZGgYpIQS9ME6iXal0xg4=
Received: from TYCP286CA0373.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:79::15)
 by OSZPR01MB8829.jpnprd01.prod.outlook.com (2603:1096:604:15a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Sun, 13 Sep
 2026 16:36:57 +0000
Received: from TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79:cafe::15) by TYCP286CA0373.outlook.office365.com
 (2603:1096:405:79::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Sun,
 13 Sep 2026 16:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005026.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Sun, 13 Sep 2026 16:36:56 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.2])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id EB068300024B;
	Mon, 14 Sep 2026 01:36:54 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 2/2] arm64: dts: renesas: r9a09g057: Add DMA support for RSPI channels
Date: Sun, 13 Sep 2026 16:36:34 +0000
Message-ID: <20260913163634.77803-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913163634.77803-1-ovidiu.panait.rb@renesas.com>
References: <20260913163634.77803-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005026:EE_|OSZPR01MB8829:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4a903492-4f05-4071-614d-08df11b53990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|10067099003|22082099003|18002099003|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	6VAhhCm+CPIy/VVHyF40GJon0R9kl+Q7S5Hb7IClG2OrbHbztms428QS70K2BiAb4JemG8ERT7NYVPDRQ9DeD5vqiLzQJqDYdoWqpy7lRxjrxTK0ngq3wpmQAdhMYqbk23BnOGzxVr38JQEicKl+iP5UUFrvg8Ff+hIpl7KonBi5V8QUegKjnaXjTd5TxuwLvWKrM5sejkVSBvbaSMNWqdSDQk+EnEUlLxYQIeI6/BTd56I2WQ8hmu+q+EO7ga+QmJvZ4k6Dov7ZhBkT6t6gYdRHX2lx0K3DeCnKworR30t3cQvTsmIrtzo0HIFuYB671F24udhrmqX/8mREURP0ZjKCN9OlvyDv2LoXQAGMMijRlLfySyqCGvSTxOMPv9im3L/Af6kNeTceB6T2DNsIa1soMJH/gzhi6ruEHafV8tfdK4+CsGRJBXvb6QChaUMns3rPbl4H8VypxQvAO8hBaRjBvT+4j2gnmbze/29X29NWIbH4yZdk+Pu8Al63arspuECQPF102O/TiCGM8FMVb1HNp3VsNWW4kloa3WL4PK+k/0wRHFne2y9sTbWZENDIXu/QcL8UBvee5g4f4wvhm+AAK57FIDookjO/fMapTghn9WnlcVt30VRE1rVUl8D3FrmnE9nxt9tUJfRHafZJyg==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	aGTOPoOkCLM2TMoMPLR2stgRQLLnUZq9ksTf4X0HFZMsmBX6Cf7DS4q/VaefBlXCRxyAEAm33f1pt86eGDZnR5O8TxI4g5gsB+KiDOv3vayEsin2i5g/HQbxVfIpnCnJfScRee2JZrPZjotUtEuk+A0S99LseT99A7p4p2kCnZvQtSQ9yi+kMgEkCccKKE0QDjDMbzDQM6rIeHezIz+3wpbOkpzwavg0P7Exl3zbVYCXKEDIGNFnxyPz1CFyS4mW7OM8gcFwOY/pXr2TU71fBXb7LI38Oj5f1jX/HxOhQvbmhm0VB0j1TCI4DS1/WCf6+o4gAgTFnhfM+gsx1T87HPV9XHMnU6ncf4ZSnKRh+7qhpMhrANxN5UDxQmf9Ec/I78AJzT7hHBg1QnhBHG+u9G6U0XolVv9PXSA6SP63dN9waen/tvBbWmok1ETbtoBU
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2026 16:36:56.1917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a903492-4f05-4071-614d-08df11b53990
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8829
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 13 Sep 2026 16:37:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24157

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 6c9940cbf7f3e7f9dc8f0ba3de74640ca9e66feb upstream.

Enable DMA support for RSPI channels.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260303233314.2928711-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g057.dtsi
index eca57c29fc9b..4f81f6d9222e 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -698,6 +698,13 @@ rspi0: spi@12800000 {
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
@@ -719,6 +726,13 @@ rspi1: spi@12800400 {
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
@@ -740,6 +754,13 @@ rspi2: spi@12800800 {
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


