Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1816.1793653907246610873
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 13:11:47 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=qsbYD/Wf;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.44, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvFrI8Uainfs8v5cceHhNbGgbKPT33rhlqsdnuqQB98ZeKTFs/tIpVSth3rymSCq00j1rduIEF0zmhHeb6VrCybLBjH91cnmge2s0YxX63hHd7Y6NN2Fd8UYnJYVWE7ZXB/CXaP7ooOMNA5SPJY3T+Q/fVQdI+ZpYL19RSaM7WaTfHKUD77JB2YYiSVQ2wKlFbYuGo5H4IhfLyTcADNwR0ZlQdo3qKYZNIEehueGgKJXPWqqvjN5F1uEIcyqHxPldh4d5KT/soWK3bx5/OxspRY0LnyzeVrvhzOSUsG1/p67YBfS8QDTgfnEVvoaJnI7iOASwVKddsLge/tqNbZT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tziVcad6vYd3d4oq3h3JxAfExqPKMEVCblW18+IPOew=;
 b=M9IoP4Vhz3kKffYhwtiX0iqzpin7EkeCsOVWGB/EYMln8MnDZ9gHebrciiVYuKpXEcy9XglhU32I2Sw4BUU6tHwJzRneGzKmomY/iSSxbLDSjP+Ggf749WWCXT1SPp5YTs1le6+oggu7y4eHI93laH8LDQtOL2Hc0VOBauRVjrjcR6pt1gF4qEZmOGf6ECxiHfsPY3GAdeBDL+rb1j4P+DtHkm5ukQgfhDrjdNc36uH9H6N+OfgwpkQTEWwl9QlgwdgjO/bbFjB1fzYCVavCT6tNtoCVjxdfyk6zoazyG7TTAjDqJA2qANL8N2UcQmzhZkmQQOUFBLqfZV7eqtEMWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tziVcad6vYd3d4oq3h3JxAfExqPKMEVCblW18+IPOew=;
 b=qsbYD/WfEdTkXH87ipYOBklpFegDobPiQFGjJCMg7QFeceUeJETNb2M3o0p2t7zlLfJAUYN+iX1F6+6bWHnGRLSlLrWRUoFOm4tlUEEv3zBp7CcFHIv1+XAdUoKGbqFbE4R3DD8v3WCF9DsdqkeannKQfLKgtQ+IYfdHT94IKjw=
Received: from TYCP286CA0342.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:38e::8)
 by TYWPR01MB10630.jpnprd01.prod.outlook.com (2603:1096:400:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:11:42 +0000
Received: from TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e:cafe::a3) by TYCP286CA0342.outlook.office365.com
 (2603:1096:400:38e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 21:11:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005624.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 21:11:42 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 74CEA3000230;
	Tue,  3 Nov 2026 06:11:41 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 5/8] memory: renesas-rpc-if: Consolidate XSPI_CDTBUF0 updates in read path
Date: Mon,  2 Nov 2026 21:11:28 +0000
Message-ID: <20261102211132.22646-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005624:EE_|TYWPR01MB10630:EE_
X-MS-Office365-Filtering-Correlation-Id: 6276cd28-59cc-4c51-d24e-08df3925e4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|22082099003|261102123227099003|18002099003|56012099006|11063799006|261021121427099003|261022075727099003|261009221227099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: n9VSTSn3htbQT7NKxyT3YWPF1GCh1S+rQANlgMH8Y102MxjAnZC9OVYL0pvUY/oTUi5Zq7VZrK7HiScNgdx8PsBZwO241Odtte4j1uXh4OoA+rk3PfaMTUoM9AT+VhYhpxqCtwP2As9XBmoXRMOYCqAP4OvCdiHjclhkavUReKDlqK0r8Tes1BhoUtWrCzyDlcHpLI8CISdcumkhnMfWQDG5vvxHMtY0pMm7g4M/kWZxH6vcmYUO9cLTOo/DgTN300VKO2EbU18C5LKuGiSn4cpmKt+1CSOh1HKAWx+qZdyKl3/79y450FtFSKTkXx1/yRNVn5nrMQstCbbHTOquQkUYi2QRb+r0jhdhykISUPvvKtC/3ghCQ55VWFJcReTHAvGN9oGY00Td/gUgQoAuRncfccGpkbUvQuLNCPKoYiVyZNo8TO1h5QV+fuvveggiTWskHw4x8dlzuiMyXF3u8XxXlsMF0Bx6NZeCkKyLZ23YeQhn2XNEfvoKk32Tkk4FfDwWYxVLlLGfH+i+OGgeZMiP87XVxPX+fm1ATg4wvDwdN3fjjfl+5S9sBpPVrX9LuBXB6sa4XOaRVVL3I3HltZcO7h8ZLXoxmxLJCiUoosU5lt+UWNeQITCh7HeFhemgalbIswDxYzYoUVATNzSFjQ==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(56012099006)(11063799006)(261021121427099003)(261022075727099003)(261009221227099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ibNg7vHa/3VinDTsePa7i9fdYsKLlm1lqGJgTw4PLrK4beojEAYaI7mfn+KAL++eflK4+9v7aIc9+ILxYfL9AF9c+Gy6/xKT+Svla1FCUolhBO0YimcZsZzQ9xyfAMp9LmR+uz2UctxHwb8HGXkBtmIT/kMrSjhp8a/k/5aXOKXXxDzvtI6G8/nefityuu2nUQEgI/YCNMMCGbJyFNTRaIaKBHeup8HDQ3WNokjb5g8b0J6wGJ4D7qYUilsjrZfPsTRx/3xTTMvv7WEeG+k+4kzG0Wjw2kI0ZZcHzg7wsa4nFtTt/ry7JValRx8Ia3LsEn74wWXpGDQRA9DntY+VcSTeLpMSAg5fZp9Uh9E3J2AmeaW+FGn3iTRPHVTIcHgJ+3xRjjBbveX9+Qv7MfVUVuVddNnlW4wRvCAJijVl8Yzgu9Wx93EC5+ik5qaHF4zi
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:11:42.7476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6276cd28-59cc-4c51-d24e-08df3925e4f8
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10630
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 21:11:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24624
Content-Type: text/plain; charset="utf-8"

commit 26883f764dd66d0c82f258a12a2f0f769e6fc68e upstream.

Program the XSPI_CDTBUF0 fields used by the RPCIF_DATA_IN transfer path
through a single regmap_update_bits() call.

The existing code updates TRTYPE, DATASIZE, ADDSIZE and LATE using
multiple read-modify-write operations on the same register, even though
all field values are known before the transfer starts.

Build the register mask and value first, then perform a single register
update. This reduces register accesses and simplifies the transfer setup
without changing functionality.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20260727103449.3188105-5-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-i=
f.c
index 6dd968ca62b32..883893ff6500c 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -697,30 +697,33 @@ static int xspi_manual_xfer_impl(struct rpcif_priv *x=
spi)
 		while (pos < xspi->xferlen) {
 			u32 bytes_left =3D xspi->xferlen - pos;
 			u32 nbytes, data[2], *p =3D data;
-
-			regmap_update_bits(xspi->regmap, XSPI_CDTBUF0,
-					   XSPI_CDTBUF_TRTYPE,
-					   ~(u32)XSPI_CDTBUF_TRTYPE);
+			u32 cdtbuf0_mask, cdtbuf0_val;
=20
 			/* nbytes can be up to 8 bytes */
 			nbytes =3D bytes_left >=3D max ? max : bytes_left;
=20
-			regmap_update_bits(xspi->regmap, XSPI_CDTBUF0,
-					   XSPI_CDTBUF_DATASIZE(0xf),
-					   XSPI_CDTBUF_DATASIZE(nbytes));
+			/* clear TRTYPE */
+			cdtbuf0_mask =3D XSPI_CDTBUF_TRTYPE;
+			cdtbuf0_val =3D 0;
=20
-			regmap_update_bits(xspi->regmap, XSPI_CDTBUF0,
-					   XSPI_CDTBUF_ADDSIZE(0x7),
-					   XSPI_CDTBUF_ADDSIZE(xspi->addr_nbytes));
+			/* program DATASIZE */
+			cdtbuf0_mask |=3D XSPI_CDTBUF_DATASIZE(0xf);
+			cdtbuf0_val |=3D XSPI_CDTBUF_DATASIZE(nbytes);
+
+			/* program ADDSIZE */
+			cdtbuf0_mask |=3D XSPI_CDTBUF_ADDSIZE(0x7);
+			cdtbuf0_val |=3D XSPI_CDTBUF_ADDSIZE(xspi->addr_nbytes);
+
+			/* program LATE */
+			cdtbuf0_mask |=3D XSPI_CDTBUF_LATE(0x1f);
+			cdtbuf0_val |=3D XSPI_CDTBUF_LATE(xspi->dummy);
+
+			regmap_update_bits(xspi->regmap, XSPI_CDTBUF0, cdtbuf0_mask, cdtbuf0_va=
l);
=20
 			if (xspi->addr_nbytes)
 				regmap_write(xspi->regmap, XSPI_CDABUF0,
 					     xspi->smadr + pos);
=20
-			regmap_update_bits(xspi->regmap, XSPI_CDTBUF0,
-					   XSPI_CDTBUF_LATE(0x1f),
-					   XSPI_CDTBUF_LATE(xspi->dummy));
-
 			regmap_update_bits(xspi->regmap, XSPI_CDCTL0,
 					   XSPI_CDCTL0_TRREQ, XSPI_CDCTL0_TRREQ);
=20
--=20
2.43.0

