Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB07C88E72
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:14:31 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.21])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35098.1789636461771033869
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:14:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=bpQgX5IL;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.21, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8CDHE9jOHwzQy1k2R8xnk+fRseff/xg21Tm9FqTGAjkMLPlhb/uflNOhZC1oihVp2DkhX3FDOE97EAdMGV04So4Ap6z0+M5GfSfL9n26D2kue5To8F8eMNtjF0lC+a1vLXTqLnjlyjV8RD7jFxoeAfFn39/xH0F/A0nEKZ2TOjQ65B0RTRXsYI6RU+JN3ur2kNq4f3msEGyE5SIMPOpzVwAgGylokkIYON/tnlkWmsoFC8MrBRJ1r5D3tacaInB1eLcYq54o8s4Pdq84FBmzWlpAnkAi8i2Ssverl7wf2jasiKGHJiVCaystSbfQ4hajjkklrIWvROjbLZH7AGc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmudUUdMkGT9+hQZJsi6FqMzd2Co0Bn45Erx7K5AnM4=;
 b=uUbt8xH2IAOSGvXO8ORhM2Oj4zmK8fNaqNhGbhUOuRWLgdMzGXqKSHAHxCYDSwDYudLYRxxcLooVrLhHFuDJuJOzrW92xd+UmY8Gbs0AjJHAWuVisYpHGXQ7W0OIvC/JXkiZPLAb6TXg72O6nh6Y3ILNx6rtWFAUySg6jq3ssnAcNTli9BOi9vuQUKq/G1NC/GZ22PsTCBj8Jd0u/Vsv4KnTYtwYF2Cv3C2Q1tXf7JfowLf1SXk5ip5z3XPsjwF/CqOtDACpRZLcQ5/Fk7Pb/LruYcdbpP6ir91axhe+S1aGAow1sfbWh3lpMDoH+8cG6NzFe+RMxL7nmMBV2DPDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmudUUdMkGT9+hQZJsi6FqMzd2Co0Bn45Erx7K5AnM4=;
 b=bpQgX5IL2CAggq3O4x9+YFhEj1mQthPSyjU528GoZDt8OwXpCM+UFPUH12mk0wMVm3N0GRtS7znJKNKGNoTQGg3FlinKuMPZbUirGdnO9G509A1vqsoYDbozmHD7WrqgezAtzamJynPtJ1p2CGQfhHPJS0v47LkszZ1CVd4iX20=
Received: from TY4P301CA0015.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:2b1::17)
 by TYCPR01MB11054.jpnprd01.prod.outlook.com (2603:1096:400:3ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:14:16 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b1:cafe::aa) by TY4P301CA0015.outlook.office365.com
 (2603:1096:405:2b1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:14:16 +0000
Received: from Ubuntu-22.. (ukr-5cg3160n5k.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 0D4F230001E3;
	Thu, 17 Sep 2026 18:14:14 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 08/10] arm64: dts: renesas: r9a09g056: Add RTC node
Date: Thu, 17 Sep 2026 10:13:57 +0100
Message-ID: <20260917091359.18445-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|TYCPR01MB11054:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5c25bb35-80d4-4f4c-d6d2-08df149c0c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	FoYQj2liCG7Wj++/QzuAJAUlaju+qBga9r4riXT6pyZ8fh01yDLvVoMOiyer8dencXT/R5KoAoAEUOEFR8X0WUvy5BRtNhBu9TCg9AlP3KUqDaVLbiCNIrYoSU7jA0Lpw1O6/C5+E1rwFSvmCiU81MVBAZGEbtGa2TQmO3vfa98o6LEzXxls/y9m4RCxsnTs2G2XVHjvLuEkUg+Q8JZB5SwrIojVML3yK4g5kxqgEAIZfpz+kW20qCefcAL0mt03PlGUpd+DrVeGvL0RU+7Kj360q7S+C/Qi2q51r50ZmbnmD1T5UhR2J80eGz6Jvx4pZeqr77OOo4s5PYk+wfkPaFGtJgXoOdZ7OOhY2FgYMqBWmglpykjFmm3aUwZostPFzvL0bctxLEsXBCva3odqcOxgh9BI9bhDPKx/aayUA6AHRiIdoZZWGg5xIqRe8bhrp7NjcmNPMYdRcZ/5r1lW21aHtGNG/XZd7Sgj+mZkgDjdI/iwEMZdaLFIZ2tOHjWxl02hZsY5O3IRIj+kO9FIHX17264ZFXaGY6PSO712HCsD9eQmnOzmbrTmhHyYBKRQJzeRdg68fhCCDHyzishwElg0cC4CDuYMgxMDGVNelJs0fJRUvU6fQeblRpr31+QnLYdF3EHt5RaB9bMH2gfcEA==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	9qY2t3c5RVdDrKigErHzX7cj8lNHGMEdcm43IdafMLkDYJN+m8mTFGuel81W6EtXlBK7YyTuKiFq2iXNEeiPCuFV6oEfGcUEaGU5spfe4FxGz2HHl5PNXj1/eNMvf1egGbMAfz9S2VqvsOHzmFqeOoQZ2EV9Tb9hCno/RnCdar4/ju+1obn0Lh4IW0F9WXZ0dKZFebi44G/ng3q2i8+zoZUIgyDt8u7Jai9IF47zDdYNhjS0TcxHtGsp8q0Pg3Aoumf7Q2EYjMBd/QKD2Vw0JEkrI++F1lvgloTvCHXqhQMmDUiNBL0wdaxLKOrOGP3hxplU7PovSDAaQ97tL6smw56f+Qe/mFLMgcRCLSrvjncCWWKllBa3VK3yE2mLqkqZRStI3efBPNQhwWJg0PgKiXYvP8WbyNB24oDPpPN//LfdoHKw3B1wbyDZj4XKj5Jo
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:14:16.3936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c25bb35-80d4-4f4c-d6d2-08df149c0c57
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11054
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:14:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24205

From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

commit eb90ae0b39a15c380e640efc0c927b012d8b28fb upstream.

Add RTC node to Renesas RZ/V2N ("R9A09G056") SoC DTSI.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260125192706.27099-5-ovidiu.panait.rb@rene=
sas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g056.dtsi
index 9a244145c60d9..01a5980b9260f 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -634,6 +634,21 @@ wdt3: watchdog@13000400 {
 			status =3D "disabled";
 		};
=20
+		rtc: rtc@11c00800 {
+			compatible =3D "renesas,r9a09g056-rtca3", "renesas,rz-rtca3";
+			reg =3D <0 0x11c00800 0 0x400>;
+			interrupts =3D <GIC_SPI 524 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 525 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 526 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "alarm", "period", "carry";
+			clocks =3D <&cpg CPG_MOD 0x53>, <&rtxin_clk>;
+			clock-names =3D "bus", "counter";
+			power-domains =3D <&cpg>;
+			resets =3D <&cpg 0x79>, <&cpg 0x7a>;
+			reset-names =3D "rtc", "rtest";
+			status =3D "disabled";
+		};
+
 		scif: serial@11c01400 {
 			compatible =3D "renesas,scif-r9a09g056",
 				     "renesas,scif-r9a09g057";
--=20
2.43.0


