Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C782C44500
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 18:23:54 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.28])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.157793.1783362230080606741
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Jul 2026 11:23:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=AhbKqymH;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.28, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WE8ja/N9RHDzuFiGVlt/HxvCNCL+9HcPXqojeGnI94u726PIf+QFaKu8b4XCWdpHyVEUE7kYSY9dgkBB8IBH+vIS10fUE/fn+Tf/B0gzRgCtzResHf5y7sctlVWdOOIKe9kn/1B2X7Ibd/Ip+hkIr15DqK1N9JKz/gr527PU8XsPNDNjstlqSIRxaTtmpPfHaKh8m0lgBX9o9A620jTjrevQfGmMJLPUI5QdAI6ZfOBHCTEqKNph0pAHnQny3z1a8VhES8PIO1fFMwxdCqNmwBLm9M9F0H0d2iNXvP80hiuI3mQC3L8jT7GvAGshIEf/5iypu8xbrTkuVO+irsY1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXume8FsvHR8XYyCty/sB20998J2Hps2fydvu5HraEM=;
 b=sZsu/a92If3VvQW6cnaTS3AX8IXxcIfDvInWPUnO4MYWP7aYTVr8u9KZUpVf5ySYk/I4vRouDnOGlHlHeXJbMvA8TncUjQpv1mOy5YbTZX+8T3L1Edb1vjXkDScPRK53Q6ZJW27i08Ck1wsGpzRGXQOayMcRSIxELN7C5fk2zgIQhSyvSR0OwH7V/EkjzXOv+eOGYRwFDlmZjOeXeh6Kjz9NBwYS8H5cwvhWb8kcL9pquA2Hu1umgP9IpjpihdOiwzdXPEjW0+LZ9oWW80yXLVq7yfmoYRG1HPyAUuh6W6i6lL36Z4VRwDPT22rxC0otCRPcd6nrWkkV9h+dmiHSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXume8FsvHR8XYyCty/sB20998J2Hps2fydvu5HraEM=;
 b=AhbKqymHETQkj0FeUzGqGLFleysEpqcciju5Bar1bn/IhZR8eV8oX0tRl45jrpyJgVjIWD8FtB/3Q3lX13xmr9k0SYvxFkLLBw4orzmjSO7U9S/kF1fGy69q31LobrlWEwM9sr8mLk8vDU4fU8Un87PbAvglsezR4bTYTdELECE=
Received: from OSTP286CA0082.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:227::19)
 by TYRPR01MB15836.jpnprd01.prod.outlook.com (2603:1096:405:2d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 18:23:43 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:227:cafe::44) by OSTP286CA0082.outlook.office365.com
 (2603:1096:604:227::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 18:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 6 Jul 2026 18:23:43 +0000
Received: from Ubuntu-22.. (ed-eng-lt-ism.diasemi.com [10.24.0.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 416483000152;
	Tue,  7 Jul 2026 03:23:42 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 7/8] arm64: dts: renesas: r9a09g087: Add xSPI nodes
Date: Mon,  6 Jul 2026 19:23:27 +0100
Message-ID: <20260706182328.5237-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|TYRPR01MB15836:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 012279e1-dc75-4402-f1c0-08dedb8bb635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	/BvjuYsrA6ySqiMRS2LW0lOjc1cqf0TvkHIhqUjfAKqE9dYMsyXZuIb3i7WH21oJMJDRVGNlbTbE6BNaH8VO/vuVDfo9ll9RkbB5TIO/FFQSZKv+KEIAzGDwK80iW++jsmf7UG0fIdLaSE3eqkVJYDzjnMRlENC/ZAK0yVZNOxWzkzutLIsvMZlPKwhxswJNWeejm0Ng0n+nuOj+g8Gz1Yru5dPP/gtecacZ/uCqWXvwNlpWJeaZUyszYLs28nRHVu1syR9VLwi+BJzxzKpfW+iR/Q22QRfHpskombFdhCipc2FkXVEuJU3rNL56LhqclzXv6MGoAgZiKwGIj90RXngccNEWIFmoo9xQBpQLOjj22bs4xWdJ8vs4HJ8EoN4TUlo9gAN61qCB66FBvycuOyrPn8z6BwLGHcjhcaBIRZQNTFqLt4LAU2CVhQ5Yv0OtdxUigc3hV+Mj3nJJREwos6HOVogDVAsmIyZJJY5GBZVDUZ8AP9k+i4qIZYgIm7PVmcdGw/V1dSqWjt7yU0uBit7tEfI1eTl5FbjYLOdzJdE0AKD4p6xjZQXpvfRFnLU10sFXXt5HSoIQ1dMQKfs4q/5NbGTlrgEhC2B8lHpc8g4jpr1i2+T2OS1q4AZcR87h3ObVu/b+6lwbn3t0xr0H0WJOF2GGyBnKOFnYG6tu+0Y=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	/3pX/IM5/jb5ZPuy8SF+Vud6uunZE7XLpy0X+hdpnz38JY3AY4dTs3XWmADf5AXvAbYoWIITHdSmPaDBFqaoUZo4LHtnDquIicd1Nb7R5zyAhpodJXvy9w6w8PiZyhUFz9hQnNE5WcflezwMDodz5Av5+IJDWNEDr4pmpJO9tv0C4ouSPciKm+QTmz/CTSuJQbg2R4AS0rlAAQEfFvHbW1owdZNbqhsDR0smSDX1hippsNGzjaN9w+FKkVxN22mmyhzMgtBCBiPCR5uVoQEIqpCq2Hh/I+Ff0tg/Q08DoGMBVGa3ApEQqtTfdAzes4Hg/khQVkx7Rrp+ZtSs0xgD/WFMjbfKeIDTQZVMDX9S/SBQLLdzN+hLAI4Tb9CXdYsr2uC26l2fQrlFM6bfeXsM3jT3HL0amTmxtJpUjOHgYBY0iAwI87B0+JSquIOVKAIp
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:23:43.6475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 012279e1-dc75-4402-f1c0-08dedb8bb635
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15836
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jul 2026 18:23:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23469

commit 8fa0a1ae4f434be1b8ea6223636c065c8e39d09b upstream.

Add device tree nodes for the two xSPI (Expanded SPI) controllers
integrated into the RZ/N2H (R9A09G087) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260526204045.3481604-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g087.dtsi
index b1f6b997376f..64886ab95bc3 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -880,6 +880,46 @@ mii_conv3: mii-conv@3 {
 			};
 		};
=20
+		xspi0: spi@801c0000 {
+			compatible =3D "renesas,r9a09g087-xspi",
+				     "renesas,r9a09g047-xspi";
+			reg =3D <0 0x801c0000 0 0x1000>,
+			      <0 0x40000000 0 0x10000000>;
+			reg-names =3D "regs", "dirmap";
+			interrupts =3D <GIC_SPI 654 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 655 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "pulse", "err_pulse";
+			clocks =3D <&cpg CPG_MOD 4>,
+				 <&cpg CPG_CORE R9A09G087_XSPI_CLK0>;
+			clock-names =3D "ahb", "spi";
+			resets =3D <&cpg 4>;
+			reset-names =3D "hresetn";
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		xspi1: spi@801c1000 {
+			compatible =3D "renesas,r9a09g087-xspi",
+				     "renesas,r9a09g047-xspi";
+			reg =3D <0 0x801c1000 0 0x1000>,
+			      <0 0x50000000 0 0x10000000>;
+			reg-names =3D "regs", "dirmap";
+			interrupts =3D <GIC_SPI 656 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 657 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names =3D "pulse", "err_pulse";
+			clocks =3D <&cpg CPG_MOD 5>,
+				 <&cpg CPG_CORE R9A09G087_XSPI_CLK1>;
+			clock-names =3D "ahb", "spi";
+			resets =3D <&cpg 5>;
+			reset-names =3D "hresetn";
+			power-domains =3D <&cpg>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
 		cpg: clock-controller@80280000 {
 			compatible =3D "renesas,r9a09g087-cpg-mssr";
 			reg =3D <0 0x80280000 0 0x1000>,
--=20
2.43.0


