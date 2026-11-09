Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4590.1794226534615916854
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=tdZbx1rH;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.52, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpK8p+Rm1p1XSd9SfkJtIgs4IA0wJBfbEnYknm5hp8ojJSRLmaD8PIZ59UM4MTh+6Ei5+UwejNRBXuTXRjY3/lItuFjgvkoFyMxeL1QFfsy9QlTMehG2eUPvY2JCE/cxkYf0Dg5zBVhav0u2+1WY0Y107TE7Ppt9oslVew+dMHRr/YZSeGuemrAgxdDWPNl6c8MrCAhtrNGpZ3u39Cd3oDCPB/6aSGKs+G3DoCiVRhsGU0P31Gf1eBLkpeV+7KqkSgvU4c8FBgLPEjYDo9GIgTNUgazYRURTuv9ZX9FbibaeKpbDpxWz+GucVSzLyC8oAP/r45IkGIv7uSp/66r/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys4Oyq+KbXerskU3DtVxFHznTc4rg54s7evOWEPR9Q8=;
 b=lexCZglXcT6dQRiMOtHZxENB1vUVRlCWnp9wE7NV46Q5/PpKNFHxTmqoCHig0kdeXjl9EsfLV+r7s4u3DzALNg3EEDxwMYo+XfN8oCE+yhmW/zkx9y7n9gqjlFpqUBP9VrVF9PwBC8/k0xgF8xoR1eJR0GFUg0Iy/dkAsCJykG22NUJOzoKROIZAe6k/UbiyX366519j5IQ8PG5YpJ1fNS3SJubX88DzhXlB5wnjDVGl2OcOFh4oek2msZaikRxEZw+g+DfUEJRBNIekYOywIfN918p/3rtgKElvFcJarU4VvtvH+7tRFrPkERG52l78NFfkSPh0GA/Tr2KFWj5y0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys4Oyq+KbXerskU3DtVxFHznTc4rg54s7evOWEPR9Q8=;
 b=tdZbx1rHL6B61DTvOJRNc+pFGdhxmmxbcA/x46P00WH/MFlUBhHE3MQg/5Ccii/KrRSvtZGMLZLMX1l5EhCKPRqpwPbh7dmu37RhMnkzQFkss0VOdQkwEzhSB70vY0oF8fkgtfBlyXulYwtUwUWz0jEGjGRQXBJQq+iWPIAwH6w=
Received: from OS0P286CA0093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:b1::8) by
 TYRPR01MB16276.jpnprd01.prod.outlook.com (2603:1096:405:2f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:15:29 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:b1:cafe::2b) by OS0P286CA0093.outlook.office365.com
 (2603:1096:604:b1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 12:15:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:29 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id DA8FA300022D;
	Mon,  9 Nov 2026 21:15:27 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 21/24] arm64: dts: renesas: r9a09g087: Add VSPD and FCPVD nodes
Date: Mon,  9 Nov 2026 12:14:48 +0000
Message-ID: <20261109121451.6042-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|TYRPR01MB16276:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9134b1-8a87-42b6-d61e-08df3e5b24f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|56012099006|261021121427099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: o0TUy12Pn/pbGShAcMC9ezijFYqOsYYw8vn6yVufVnI9Z1Y1GmcpP/Q4Ub2pVvHLQYY6PaibBW388TH3WiVI5S6NshusLSuFHLW7xseVWeCEilXf20w5sZXtrZ/oSa61ihVenWt64Kc3w/+nF/7eS8Z9Q0z9twk2VOKtNTI33sjIVFh/Z6CVrX2daF12LU22KEmZR9MEc41P4s+s2T9RyIeSwHxEaPfPOLTuKbWG5/7P4UqrQ2UMlzs4EisQZ5JA2J3xSTgig/ERzfJ03/e9HcD8RapLcsGl1r2sdhk9HaknfIMB2QfhZqNijsWsJ00EGbk82aO2i1VOG314gF1fknDS7+K295cqx+y8vORY4ki1UlwqyGSe5JNxWd8H7KcZW3Tg6hBsxBt+4zehApgtU/0nOanNBZivdhRlBBOEKNfceYJpxSkUcwFdqJHjvV0qigCpasR432R9mxSH51B0i5u36a8ywKr1BDt8XQDVBJMoMdr6XEXfzk4mSdZOZXy+7J0xXMFsh1WjYcYjFHxIp517uYRw8hi9sCI+wdRUtfdvTFEtFjr4ewaWuKgjQzPe0khrf25b0CYdij5Z4zr6HKl5eSF6qhzzAtcEZwdF8oRcoGIZt2O2eCFYSdciTJr1V6macIseL5csTxHcjNBUtw==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5+WOxnwPnyfaAj6LcXlXE9aGpCbHtxTaXm/U6/72lAVA1jUte49sWQU4RHe14aA93oRWlGw9ZfTEbnXUAWovmD91iCX9nL6lI+d3+D99BoUpjc+2+pHffhtyhCt9bU9BOuqLbrGXlZC5+b0OeAWt4iMXh4svjDbEsbOVmLulbDWVqvtPEXeJ5qZ76QmENQm08uUDcjtqHAR8DtBCFVNSz1IF1Fq/Pn2N/yEnvRP5e1khcl6pUHTMA/+EiwXMEmDrgmqjCAcbWq4uGswn2hDzg01SG2omOpsfdVEH+I9uZCBTiVZuquclyRXK6Qa+Fao8XH9iosFOU816Jx87JLTh1HPNp286ka/cPkev4Uq7QWces2syelD3KH/5zyDqdSqFPnjIn04Qf+YCgb3JS/u+JGTK7UqAuqn6YObWfFrXh7ftRxBYUrImigqMY4xxWzFn
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:29.2496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9134b1-8a87-42b6-d61e-08df3e5b24f8
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16276
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24725
Content-Type: text/plain; charset="utf-8"

commit 58e45a8c713730de22e0c1e4d9744b424bf4124f upstream.

Add VSPD and FCPVD nodes to RZ/N2H SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260615115455.1412098-4-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g087.dtsi
index 82167083bb158..05fc3f92ca437 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -1272,6 +1272,28 @@ sdhi1_vqmmc: vqmmc-regulator {
 				status =3D "disabled";
 			};
 		};
+
+		fcpvd: fcp@920d0000 {
+			compatible =3D "renesas,r9a09g087-fcpvd", "renesas,fcpv";
+			reg =3D <0 0x920d0000 0 0x10000>;
+			clocks =3D <&cpg CPG_CORE R9A09G087_CLK_PCLKAH>,
+				 <&cpg CPG_MOD 1204>,
+				 <&cpg CPG_CORE R9A09G087_LCDC_CLKD>;
+			clock-names =3D "aclk", "pclk", "vclk";
+			power-domains =3D <&cpg>;
+		};
+
+		vspd: vsp@920e0000 {
+			compatible =3D "renesas,r9a09g087-vsp2", "renesas,r9a07g044-vsp2";
+			reg =3D <0 0x920e0000 0 0x8000>;
+			interrupts =3D <GIC_SPI 780 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_CORE R9A09G087_CLK_PCLKAH>,
+				 <&cpg CPG_MOD 1204>,
+				 <&cpg CPG_CORE R9A09G087_LCDC_CLKD>;
+			clock-names =3D "aclk", "pclk", "vclk";
+			power-domains =3D <&cpg>;
+			renesas,fcp =3D <&fcpvd>;
+		};
 	};
=20
 	stmmac_axi_setup: stmmac-axi-config {
--=20
2.43.0

