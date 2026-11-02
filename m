Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11873.1793624012409108730
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 04:53:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=v5ZgE0vv;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.47, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcnAlGrzDPFdm5KCqjvPyYX1GS2omw2Iaaqs1eWjIeWZnvEGMRkxFCVg9Cjhrirgh63RPcjZlLnKALgSsEP+fn8KhubSi7RwSc/MzDt1X5ZaC7b0zSGy1ZADPYqv1xTk0Ccc8IPJjPWHiZttyoEw2bUsTKkL6GywlwtHgE2kct52WBvaj9XDxnYePWyXvQuw9PTtV/jPwN9bqqrRl/ns6GzcY5+BRjzvlGtS5Vdqs2eSzsvURupK7F+frOPuJqvod/GYzCY0OxNfzlccHKcTMBv/UtK/+ho4fKeY1Ri4aQBUBVM+QIJegwxx6M8LHD8+KRYZxbzLyzwawa+xgFCE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/jKuOockCE2k4zpjd7HNTl+s6htxKROc4pOTYdRvN4=;
 b=APVPitVQ0DS5oCjCcwahI6iHnSbandQWcHKuDPI5nEeibz55rQiZGiSvj1v2fYRht4Wfwzz43WwuZ4J46QtGQ6qiuyCub/ahPJZSHCgNF2WUsGuIEgQLfihK0ppFQtYATQQhLccb2i+mE/aZhH5Cpz2YmlZpxn0b7l5ZkrIHL+cLakhysKPPZ+DloMWu23aqnyBFFjXozMiBgm85oDo4qSoi1UGbcNuQ9f01ptcyOmeFWK7Kby+uYrPEhvu7QZJ0O1JtrGD1fErbSEnZRL8mQ54Z+N8K2sVlmD32jmQsIdQ8Nh6jFHIcTOs+wPXeemAwxJne5EmaP0fv3jC1eWR5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/jKuOockCE2k4zpjd7HNTl+s6htxKROc4pOTYdRvN4=;
 b=v5ZgE0vvs40j+vvWE5ffsqP6OXmipW9sVF9UcS111AuQ8N7M4MvhkY2OmgdIzE2autRc4U9/u3qO9QKl6hrDwthKKveXRxJ1JRsErVg1PlBLFobQnduJRPqyPeOTOoCje8wYE/4OiiRIyEwjyx9aV6+7mlgHFrCcAHKZxyqT5IA=
Received: from OS0P286CA0033.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:9d::20)
 by OSZPR01MB9548.jpnprd01.prod.outlook.com (2603:1096:604:1d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:53:26 +0000
Received: from OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9d:cafe::9e) by OS0P286CA0033.outlook.office365.com
 (2603:1096:604:9d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 12:53:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D215.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 12:53:26 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 2C12E3000230;
	Mon,  2 Nov 2026 21:53:24 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 7/7] arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable PCIe
Date: Mon,  2 Nov 2026 12:53:09 +0000
Message-ID: <20261102125309.7743-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D215:EE_|OSZPR01MB9548:EE_
X-MS-Office365-Filtering-Correlation-Id: e78ceaff-7da1-439a-55e3-08df38e04989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|261021121427099003|261009223027099003|11063799006|10067099003|56012099006|18002099003|22082099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: zACnDoXRW1qIG4WHqkaXDZ8SrnTdVu6kM9JCDKJrJuwVdEuKGLniEb1iiHuImMKiEL974ZDlzecbpzY9/UMVe7JIma+Qf0gfVYs57XrLHL2p+on+6YYvEgBJTWZH6pf67AEFkmSppfNZRS2eLkzE9k4h/g7K/ud65VwFe10fuQU6jemp8oGH+yq1H/YZc66c30ePctyLcFB8dae3VPrwndzP+H8OHZ0kAVwYNpr9H9awtmYcDFq7HqOnJNFE3ATyLizJWi8/Ssc+6e0X7a+WvNNwFvV0BA1LSkucsSf9Qic5v/92CSQ2bkSpkxKvkg8TzuwV5ABsthJIJdajEw8Fe5OnXDyk1dXf/x2ILT5gBm61PjePzInSugjZMN+KoY26hA8fGcybwhVPL0sAgWHKE3NRBJEpcx+/PQsgDGmX3cBXkKny3kAacnGh47oqwTcP/zKHMZDQjIgS9FpwmC3wdEkFBQEVdKeme74b0tVtm9mhpp775es4aPJDoLfbebVimzmT3T47sqYApDIpyWhfw2itgCoHdmaG7if3ansjF5gh2DFOlztJhUYtIsWOBMMix41R6vkEXXaaUD8GWnhI1HL0vJm3i33AuFhN4WAcgKercYSM2JVpaBRk1TgtTYJiP72bUni6wZNqzfri7hRltA==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(261021121427099003)(261009223027099003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fy6ZHtt67rTGyGw+VTqkb9zS+2y0ZePWetFIun15/VC5qRDhBSvAaNjt71IZj5irj0c4HTWmBg9mRnWWj7Y/TIb6XARSDNzA9arZUhHuVrjaKgm9ba0nFYitek6F7Xk5FIEc8VE9BAGyZWkjzS5E0Av4OmIzHPYSxkAUwKLoH3SNIXEDGIH5x1KSFig8JqZN8UowtulUXsuCya6Ov8sDgqPOjwqa7zRn8JI6MaHyyYETotJPsnp6UuLbflHoGwEEz267CB25RhhpmGjpvLDtVChegdcrFpW5QvW9gdAsQwzgmhuxZlY6e2q47v5ZIGlyGh38beOESV9pFdZfFO6vtTSJ+U1UmbRKXLtonaKikhgKshRO95tu7qAsQrcN9FcHb9K3i0/bk70krjnE8aKzQ5TQ0tvNrZMY+K97AXANzb/rlKVjlbA6aXE0YDbK+9Lh
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:53:26.6835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e78ceaff-7da1-439a-55e3-08df38e04989
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9548
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 12:53:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24609
Content-Type: text/plain; charset="utf-8"

commit 90a9d595f36ba11d95568acfda641a7e371f627d upstream.

Enable the PCIE1 slot which is connected to PCIe0 channel.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260708163311.222176-3-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Added pcie_refclk node as versa support is not present]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts b/arch/=
arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
index 5540b97a4a9ea..35baa63a67b6b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
@@ -69,6 +69,12 @@ memory@240000000 {
 		reg =3D <0x2 0x40000000 0x2 0x00000000>;
 	};
=20
+	pcie_refclk: clock-pcie-ref {
+		compatible =3D "fixed-clock";
+		#clock-cells =3D <0>;
+		clock-frequency =3D <100000000>;
+	};
+
 	reg_0p8v: regulator-0p8v {
 		compatible =3D "regulator-fixed";
=20
@@ -343,6 +349,18 @@ &ostm7 {
 	status =3D "okay";
 };
=20
+&pcie0 {
+	pinctrl-0 =3D <&pcie0_pins>;
+	pinctrl-names =3D "default";
+	num-lanes =3D <4>;
+	status =3D "okay";
+};
+
+&pcie_port0 {
+	clocks =3D <&pcie_refclk>;
+	clock-names =3D "ref";
+};
+
 &pinctrl {
 	eth0_pins: eth0 {
 		pins =3D "ET0_TXC_TXCLK";
@@ -389,6 +407,12 @@ i2c8_pins: i2c8 {
 			 <RZV2H_PORT_PINMUX(0, 7, 1)>; /* I2C8_SCL */
 	};
=20
+	pcie0_pins: pcie0 {
+		pins =3D "PCIE0_RSTOUTB";
+		slew-rate =3D <0>;
+		renesas,output-impedance =3D <2>;
+	};
+
 	scif_pins: scif {
 		pins =3D "SCIF_TXD", "SCIF_RXD";
 		renesas,output-impedance =3D <1>;
--=20
2.43.0

