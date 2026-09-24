Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20651C98311
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 09:32:28 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.10])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3855.1790242347060716071
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 02:32:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=glHopw6b;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.10, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3+HuUMcrUdLVIkdjYW0J5WYwFhUxCAQEQcm+WyBJPF6g81C9ZcJKFDsDYfsb4S6CmVSMGfpC31zeKAkE90tCjx3kx59cBtdshZ8V77i/RbLtMNaadRXQZ5/X63R5JRut7rKtpHJgUzFjPUqfm4G2eWPNkBSNE3ZGuhpOxLuBFGLvuT8m+KSRmQEj77YndVZV9NmBqMBZU+dQlSLW9XvOePvR6pf9PkDDYcoBhF6pycbq17jydpdTZWd+btycDhLgYSb75RL6/x9h9Bd2he2fZnSZBJCUvIUjrzX9URayEHrJF6Rd+0FQ/dcsqVOQ8kmQGkn8kd3oUVGyOuY3GbtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4G18Nb3Ard+RKCrPsUKRtmPpZN65VA9FQkDtoaAOpw=;
 b=St1PyxPp8o2bsCfA2mBI8xUvKcF//eRiZyAOyPdj72Bz7HP7UsHHmGVUBWnCcEpShx5JLwuJzrtaUT2X4h/G2fgAQNeAiyMvy2oic9knkdS5nOzM9zqtYPc0m8OIHhGYT8lAuv0AktscriiED+lUV5VyqOodCXwUunWK9AJ7s1J3A63Z10seVfjcGRV+guJruOHsvHinQAcRsbIqG+0BVhGbYmSFsjDpilMSSE1+cB+iBwwnet91b9HMFuQVF/EtjZG1r21uNkdzamuWdmMuitTtP3t+XNLRu3cNEGhruDjkdCF1GTl3QuN3+afjZptQ4HZDiAvDUHbGcgL6gA+ycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4G18Nb3Ard+RKCrPsUKRtmPpZN65VA9FQkDtoaAOpw=;
 b=glHopw6bDWgrsPz1b6f6HNC3ingZgMrDuE5/EnRb3IraU2pkOflq6yZekCunMZbhmRlsCD4p326be41pDOx6S7nemEGwsu39okTz9LdEEhLWXQ04J+IOJ82C+xmpcSheQ1Z6mQUL70P5jsvcALJvMq/O1KakFpvcylyVli8KsXY=
Received: from TYCP286CA0037.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:29d::12)
 by TY4PR01MB15625.jpnprd01.prod.outlook.com (2603:1096:405:270::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 09:32:23 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d:cafe::23) by TYCP286CA0037.outlook.office365.com
 (2603:1096:400:29d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 09:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 24 Sep 2026 09:32:23 +0000
Received: from biju-VirtualBox.adwin.renesas.com (DEU-5CG6192QFB.adwin.renesas.com [10.226.92.107])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 6097F300020C;
	Thu, 24 Sep 2026 18:32:19 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 2/3] arm64: dts: renesas: r9a08g046: Add RSPI{0..2} nodes
Date: Thu, 24 Sep 2026 10:31:52 +0100
Message-ID: <20260924093156.131928-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924093156.131928-1-biju.das.jz@bp.renesas.com>
References: <20260924093156.131928-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|TY4PR01MB15625:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 881ca98e-f303-4fe5-0b70-08df1a1ebd02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|13003099007|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	HtG0KnAIBT/gSBheT3e3W0Fh96hoPKMM+QKvu+vt2zIECVJmOvcXJ1NCvNln6f6ra7w/07QK9BxvS1Hv8yKfxfkpghRjdQvNTH9PZiO3NJheK9QW2nvjxTVMC51lY9VMwNXW5Zq7518nOK7MU+YROztP+yfwZtylqDKDRj5JqKmrBkibXYe5lrIH4BomhXisb6mwJKuymuki7ZKnPxLYtbJL1Ghsx6mQfk2NFndHi7mtL0Cml6dZiXY8b5gCiSOyraAeJ5q5utYub7g2R68c1PvxXiIDBTdJPHh5+Omb7AkEnM7C3z021bV60aO1QXG9arC3QX4IpdCIdqVJI1V6zlmkOrx6pIRvVAYC3rmjb35AE1hzTbC08xAeAlej7L4RqEF4jSOv9Aee4TQA3oJXVtgcxENgmP6JCJ/cBVjaPPgPSbNkKfuI/cGUnxMg1HQWOJ1i9XRFoDzzJeTLn6mO3ndGoEMxh7II0Fx3FdpZrLCdH7GjUUorF+qcd7IgCtDjeoXHpTiU6ZxB8jGFgHiOizTR7NL5/DbmzB5uKfR4TnoFsAcmhznDVx/4k5CSc/1QvnZJ8dP+tPid5T+hrstBrj4a89lHps3pJSmrIxYPum8W7YZiru9ZWKrxtYrNOmFvBL+90KcqiWxkbUaWeickdQ==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(13003099007)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	fbLQSCN5zzVoCEW56TTC/ewjG5j/jWd/Y3ebjSicrHrELqfdbjDY8JSxtwsODhkYGIZQauBzcSO5hA7mRmew5kfkxSbY5pBSVfCBcFtia+7tO84Y7qPkh7mGNFucPHHE4Gnbqnd5KjUIV3wwYpwjm88Va2UeAVWvzzvs2qzj0ZrgVaXUx/1dnQGY17WGjYJZ/zWIdRES5Qn28COPhqivI6767X5tOoQDtvwc2vVRT5TwpgiLrrJtXIBga8ZhG4YCsR/9gb/XcpgvngMoSoth1+IdDZy1GNA80txpBbM+I0hbrHgvo3xWDNS7//Nw3ZoWv4+LdggsWAjMd6a+g6M8Xw6Di9Z4JAL1LrjOdWv4Cz6i1BhqmD2+CcXw0Bc/336VuI/6zEqZiR6I+hgGKlnHBKFNZnU8M76NNdag9hdWiTSVuyDnNoMWC5pHNREBsyIe
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:32:23.1772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 881ca98e-f303-4fe5-0b70-08df1a1ebd02
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15625
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 09:32:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24304

commit ba82a7f75e8a33963354c1be109793f2bccccb79 upstream.

Add device tree nodes for the three RSPI channels on the RZ/G3L
(R9A08G046) SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260529130704.327505-2-biju.das.jz@bp.renes=
as.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a08g046.dtsi
index 4bb156dc3b23..57c63f7ab6d8 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
@@ -358,6 +358,75 @@ i2c3: i2c@10090c00 {
 			status =3D "disabled";
 		};
=20
+		rspi0: spi@100b0000 {
+			compatible =3D "renesas,r9a08g046-rspi";
+			reg =3D <0 0x100b0000 0 0x1000>;
+			interrupts =3D <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 442 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 443 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 444 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "idle", "error", "end", "rx", "tx";
+			clocks =3D <&cpg CPG_MOD R9A08G046_RSPI0_PCLK>,
+				 <&cpg CPG_MOD R9A08G046_RSPI0_TCLK>;
+			clock-names =3D "pclk", "tclk";
+			resets =3D <&cpg R9A08G046_RSPI0_PRESETN>,
+				 <&cpg R9A08G046_RSPI0_TRESETN>;
+			reset-names =3D "presetn", "tresetn";
+			dmas =3D <&dmac 0x26f2>, <&dmac 0x26f1>;
+			dma-names =3D "rx", "tx";
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		rspi1: spi@100e9000 {
+			compatible =3D "renesas,r9a08g046-rspi";
+			reg =3D <0 0x100e9000 0 0x1000>;
+			interrupts =3D <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 447 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 448 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "idle", "error", "end", "rx", "tx";
+			clocks =3D <&cpg CPG_MOD R9A08G046_RSPI1_PCLK>,
+				 <&cpg CPG_MOD R9A08G046_RSPI1_TCLK>;
+			clock-names =3D "pclk", "tclk";
+			resets =3D <&cpg R9A08G046_RSPI1_PRESETN>,
+				 <&cpg R9A08G046_RSPI1_TRESETN>;
+			reset-names =3D "presetn", "tresetn";
+			dmas =3D <&dmac 0x26f6>, <&dmac 0x26f5>;
+			dma-names =3D "rx", "tx";
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		rspi2: spi@100ea000 {
+			compatible =3D "renesas,r9a08g046-rspi";
+			reg =3D <0 0x100ea000 0 0x1000>;
+			interrupts =3D <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 452 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 453 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 454 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "idle", "error", "end", "rx", "tx";
+			clocks =3D <&cpg CPG_MOD R9A08G046_RSPI2_PCLK>,
+				 <&cpg CPG_MOD R9A08G046_RSPI2_TCLK>;
+			clock-names =3D "pclk", "tclk";
+			resets =3D <&cpg R9A08G046_RSPI2_PRESETN>,
+				 <&cpg R9A08G046_RSPI2_TRESETN>;
+			reset-names =3D "presetn", "tresetn";
+			dmas =3D <&dmac 0x26fa>, <&dmac 0x26f9>;
+			dma-names =3D "rx", "tx";
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
 		canfd: can@100c0000 {
 			reg =3D <0 0x100c0000 0 0x20000>;
 			/* placeholder */
--=20
2.43.0


