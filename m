Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.17])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1833.1793653912384585476
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 13:11:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=RvCdV6FL;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.17, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxSR7dG/T7lbSzKArW/Iwq+rRWhKHICLq90hOBNUFkk49vC3V8d2f1Htq2jzD++llbVh8d9KhkjeYc8qJeyZK2ScCrpgZBRMYLYuGrAiaHIUfmYIMgPtx2+VzP0+/qSyM6LiNUtKteZtp5c592JZMOMeKV6jTKgMNHnqsSYIHuig5bVZJt34G5TElTVI5448O3VzvmxAIH+g6oTP4Cw4iVpAMfugY48sF64tCtVNY779A7bo3t92sz1oxBSLBe99BV2jsVdZ87mQm9F7nul+MeKf5Qz2oyaMV1zgBCg2bupOVEFt6if1ULp8RSb05dEdNZKL+ILWt1vTW1k7WxoR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsSIcYOSSYVub3YDjdaOAWvH+TP92ACmqe4QPS+SJSA=;
 b=cjMHh60/X9EAFf5hNSAhjLTxXeCwmWpG7oNRD9N+/OQ7A7CXUbldZMEyPdWpAOTQvIDrrebJI/tu8MkMPBGfJWVSFceb/Wp2HVeRa3JwRVxcwAf7VvN2rCOQb0H1U/JWG2xzXgPngQEPgUR6xEOl4/SzwuQzHso5pCySO3yBBk4WZA6zOQhPvvCSz5pEtL6hIam1YP2P4XeUMigdKxsPtN+fXkeCkQNipez2vavxRAMr7ZFH4LOZslz7f1aCKccbsA9VcbbNqIC0u3YV92uIeQ2Jrfc1CKX01/sm7Ey6wlY+vEJnLi/6EUMYacA7k0USdy2B1o3PZVygoFaC8FyEYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsSIcYOSSYVub3YDjdaOAWvH+TP92ACmqe4QPS+SJSA=;
 b=RvCdV6FLF2QR5/fuCYmfjIyk75NEy4my9gvQhZTJKarB7KFDTTcx27CISf1V4Cyix0JRxmpS7y513CIhwXZrM6/PW6KAK8LIsrq00PseTBBmS3QOYwKsP0H7WIaOcJL0heKseyQ/qJrnz7duuH1CbuX3P24C619SpZ2ChGxlLs8=
Received: from TYCP286CA0334.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:38e::12)
 by TYCPR01MB7177.jpnprd01.prod.outlook.com (2603:1096:400:e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:11:47 +0000
Received: from TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e:cafe::ae) by TYCP286CA0334.outlook.office365.com
 (2603:1096:400:38e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 21:11:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005624.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 21:11:47 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 714D73000230;
	Tue,  3 Nov 2026 06:11:46 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 8/8] arm64: dts: renesas: rzt2h-n2h-evk: Mark XSPI1 boot partitions read-only
Date: Mon,  2 Nov 2026 21:11:31 +0000
Message-ID: <20261102211132.22646-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005624:EE_|TYCPR01MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c81a9d-6980-4463-f92f-08df3925e7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|261102123227099003|22082099003|18002099003|13003099007|56012099006|11063799006|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: DdjN8ThM4jnVDaamJjWGrMo6bQMvrZIxyWBV5ViS/B2uKQr2YvMUcfRLJuj+OxXtLgkFEEcs5lJ1TIaBqt5SL+02OkY0KrIHo0uxvWxNMJuhbhOzxMVLOMZALclKK8fE9wyjiaESW1lYbPPuiAcyHjgYNPn+CtUmtUd4ohVSdnli7rUcuDpbGR5a057UYtbaCqkLxbwhxW9TtP4ahoVsb2C1x/lwsDEh2Vt/tr/Pfw/52iYvhPrRGdFz1jgoVExIpKB9h6zY8q8q2/TfgtsY0di/Ni0BkmKp0sAMh+UfrfM38Y3cZY7yKrL7oa5BFLFN03QpKgpFfMxo76jtVIhufUPpaWvVLEb68SvHuseRHTXom363kJhn8VAKjfHstM2Z0hj+wbD0wLgrg5H7w0zL5GceuWj3c2JvVK1m35HEs30ImzqBLFUWFB8+7LBH3xG72o9z0TwRFeAUb5nXV97tS//ZK7O36FXj5JFoNL41M9xznjvMmXOCbxRY5fGfqJuOFY6XiDnMaE9gN55cb/KNmv2SdC1/9c2rzPtmbErVqtYHs3xxEpmu+IVN3Kn5NpVvgrd6SoR92hWyapK8Jzp2xT2nRBB449X/1YtgHfSmR9nesL2l9WNx3KkhIIeeBK5ofQFBwzZlwtQ0wKU+iLCU6w==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(261102123227099003)(22082099003)(18002099003)(13003099007)(56012099006)(11063799006)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xxzE51NhANegqy3gwUknIlePjMwmCG0ZZirMtke8DN5CJ8gh1D2adThPNT/NUqEsxUMpHIpPBt2rrWUC345ElMReCFbpd2dnlf9zDKeY5WNVUSU950QnjpPmsTFKjhypSLqnGELmcJHsSzxIToKCeyMDfkj+S6pCV2QqET35nnE57hC3wA8Vku3VGdl+/1+/0evttNSN6BaCv5ilYlnNFNB1zyEOD/ayxUItbCAwq7MVpTRw28N9hFCJw1EMk+WiM233+YHrxrCWI0RIXtaijPvHIXRb+mxgw+lQPlkAkOt56a/zznb+z8+FFOgXF9pIoZnOg+kZqYfvaaQWwIc/hP+Aez7rcXN1m0SGC8k5mZqvcWlHp//Tn8hLeOawzDzgrgtRM9UZjsGC1lIYMgFSv0/+wB107/8aSoyTkr1sT0z1eh8jvZjierT18/U6/XRD
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:11:47.7622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c81a9d-6980-4463-f92f-08df3925e7f5
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7177
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 21:12:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24627
Content-Type: text/plain; charset="utf-8"

commit cb430b6c1791e0b1766439f1a527ff003f790484 upstream.

Mark the BL2 and FIP partitions on XSPI1 as read-only to prevent them
from being modified through the MTD partition interface.

The corresponding boot partitions on XSPI0 are already marked
read-only.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260826112821.194877-1-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/a=
rm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
index 4cc68279b8e26..5123a6caa4016 100644
--- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -507,11 +507,13 @@ partitions {
 			partition@0 {
 				label =3D "bl2-1";
 				reg =3D <0x00000000 0x00060000>;
+				read-only;
 			};
=20
 			partition@60000 {
 				label =3D "fip-1";
 				reg =3D <0x00060000 0x007a0000>;
+				read-only;
 			};
=20
 			partition@800000 {
--=20
2.43.0

