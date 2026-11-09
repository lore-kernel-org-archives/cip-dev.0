Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4592.1794226535572520809
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=fA8HmPcB;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.52, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/FVppL9bC9kT4WKGGaIMFk27iCst1AUc38OO2jQ9w7LolheCGyDb/0+t5zNUPqD1xDhH//LZrt3uQLYACt6IIoQMKBGTJgBs8M0vb6Jfi+zi0kRC1nEt1WgbE4XGqITAtVkP8JV2ev7FlpYYFAGaFH00s9deB3h1GnwoPwquymcXUcjq/KUES0VYWCjuZWPEJZuRynuG+otTJemPy5XxnxuKCIHA+YYYfpgagF5O4vlgRA3kU7w2V8Teemm3Lk4tpnTRNa9w3Bem+wF1VJwgiPqRyyjaP1dFNVnO5CXW2upN3Cxf6LD4pRCE00fWGriYFnO5qZFQGUoQUA0JreUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHDkpmbpW74Mwh5fXCxofGDvhcov9lIB+IZnugUhMx8=;
 b=uQsw+4+8vAnsK5Hcfsuy89f6h1FchI8nMPzQrp0H+OS2BKNI8a3pizDYHkOfhGQulldwlJhMLVbmkxVIiT88OT19IvyKFs8U2wYmTvTgstWnN6YJz1yQRruEZfsLKDSkpi0RxWDWqlPnQRVFTiMZIkU02TxTJSAIgO4rcpxpz3bypg5JwOIh9H3omRGCP529YPV0KBBTb1Z5PISmi1k/tSS6XzgLavRatKLsPy7vOrF0vaXGC/kXsmn6BV65uo5/fsqDSsQeaZ7ohAYpZwLRThtlU8+6rAnXo0TOEaPpTbhSCYgXdHDyfHB++ZODyHau/W+na38ejdCDsw+C2Y73UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHDkpmbpW74Mwh5fXCxofGDvhcov9lIB+IZnugUhMx8=;
 b=fA8HmPcBdsDXDiEHo0XGA0NyQkJfdCDTVbrX98oyw5ro1cYdB3eW/f0w80THivoUaCzadEcijY3eR8/dxRE274CIhocfLdGG8pKjKxHfJo7bOpeWbFJin7Aj2DJGpjcqtLSdy+GdbEahw3Tjh7F/OBUsdRFvw1EV4/f2S6p7aNc=
Received: from TYCP286CA0303.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:38b::11)
 by TYYPR01MB6618.jpnprd01.prod.outlook.com (2603:1096:400:e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Mon, 9 Nov
 2026 12:15:30 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b:cafe::21) by TYCP286CA0303.outlook.office365.com
 (2603:1096:400:38b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 12:15:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:30 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 8809E300028E;
	Mon,  9 Nov 2026 21:15:29 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 22/24] arm64: dts: renesas: r9a09g087: Add DU node
Date: Mon,  9 Nov 2026 12:14:49 +0000
Message-ID: <20261109121451.6042-23-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|TYYPR01MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: d1950474-a50d-49ba-7942-08df3e5b25ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|22082099003|13003099007|18002099003|261022075727099003|261021121427099003|11063799006|56012099006|261026140227099003|261009223027099003|261028144727099003|261022105027099003|261102123227099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info: xpnMyWG3Fm0mxGWwdTGM76fnnGmJ1sq4Je9OYm7YIVH0k3xpvbAjz7Xjt4ekvd0TOcEPPPxrRhMH/fosRftTJHFHflHcfYGDEVUDUNPEVcqtEzPq8XNVj9JO3TxSGh4KnbwxpN9i9Dh1z+d4J8UA8N24OTNhUZJm/vqy6q10awu6QhVl5QFL7j7dBYT7NKmpd/lwASInPjGWr3IwCbU72TVWouJLPvQZ8WzGU1+4TtL45EbTm2Bwl2u8zhCLYInworE/pWtg+CIN+RLOCAtqRGO2EjvRGUuArE8KnU2T/igOA3dlQtWrFLTVtItY94adTMFPt+n57+ybVTTesmhFVljhmCqvQC2t4SlgqJlYwj8g1iBLFy24fMfTtzBQpvh8+qJ4GLPZ2MpRO+QXoysTsXOXqZMIFfkGCMIoAwqRuhtdUkmLQVjVnDmdWCr/14enz6FcV6YD92CJG7Zs0x7R8koTGx2ZFZjVrf23pjjmMJlarF4LZVLsG/UEdr7OtKhVcPRtnHO84jlmBXABqIU1f5aIzxMqIC5NFIHW4mvkXf8OpMHPZMDLxNavkHKJ82/wK4MzshEyW6aH14RMGFHQ32ti3TLkUcqu33ZTohsNaXTmyGiOoAwFX8MAB6OaKQWYdcAv1SpItlLMC07tGfDsz0CsxmqEwnaUg1yqeJfCVLk=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(22082099003)(13003099007)(18002099003)(261022075727099003)(261021121427099003)(11063799006)(56012099006)(261026140227099003)(261009223027099003)(261028144727099003)(261022105027099003)(261102123227099003)(261026121527099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FhI71K5bUXZ1acGr3i4+9PfrofW6prS7gsnm/Q8zadozV0AVhGUNHAPiU6blSCx1oLR8qN/cSBVUicYm/9SKdbykWQ9cLyM3x65dhvFoAzKCUm5RAz0xWQmHSQJGy7aNtrzZfBGuc9g/JOjNwuDyZOROzsov6YeiJYOsNwuMC7s8NNHBgJ6M6O5/1sWon3mVv7U3ts7sfHJ1tiHewnYnefngS0092QQNZLx4XWhLLkMO+1Bg5r6YhRyUy4hcyKWBwyxpNLtIhnYzmW/RqzuXh/WTzgUYJZ2VO8vB/Z2DH5QIvzLqQnuj/hpQisOrmB1MbXS4uPgjordcQGoM4INpzqdmeAiqKweAqYYKfkKfgi+2qMLNWyNKfG1TBbhNvbPtfidPMcghxdWjKd9XkgeRMhCCKXWViaRWEr93NS9x8j0vT895yIpS/cahqb3vw1WC
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:30.8467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1950474-a50d-49ba-7942-08df3e5b25ea
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6618
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24726
Content-Type: text/plain; charset="utf-8"

commit 4fe698532981f7a8735ee9b048cb981fb6448c45 upstream.

Add Display Unit (DU) node to SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260615115455.1412098-5-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g087.dtsi
index 05fc3f92ca437..3cffa5ad81a33 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -1273,6 +1273,30 @@ sdhi1_vqmmc: vqmmc-regulator {
 			};
 		};
=20
+		du: display@920c0000 {
+			compatible =3D "renesas,r9a09g087-du", "renesas,r9a09g077-du";
+			reg =3D <0 0x920c0000 0 0x10000>;
+			interrupts =3D <GIC_SPI 781 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_CORE R9A09G087_CLK_PCLKAH>,
+				 <&cpg CPG_MOD 1204>,
+				 <&cpg CPG_CORE R9A09G087_LCDC_CLKD>;
+			clock-names =3D "aclk", "pclk", "vclk";
+			power-domains =3D <&cpg>;
+			renesas,vsps =3D <&vspd 0>;
+			status =3D "disabled";
+
+			ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				port@0 {
+					reg =3D <0>;
+					du_out_rgb: endpoint {
+					};
+				};
+			};
+		};
+
 		fcpvd: fcp@920d0000 {
 			compatible =3D "renesas,r9a09g087-fcpvd", "renesas,fcpv";
 			reg =3D <0 0x920d0000 0 0x10000>;
--=20
2.43.0

