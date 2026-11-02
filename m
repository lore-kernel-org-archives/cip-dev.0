Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1827.1793653906771082662
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 13:11:47 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=N7NQhpl3;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.14, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YssRqXxj07XuH3zOn91lar2mrWWwOtITCxO63VI/IdcJrh/FRkTbuTPrMbgYXok6OBdP4IX/yj1lAdKBz89hniPEXE04rGq/nzPSzW2NTzFW6hRToKNYYGxfjnyJAlANtGKnlHN4yz5SJSSEaw9ggOB89cb3w+GU18VNP7Q93iIzhel6JYZpHkbo7/t9mpljplikk1QcAKaF+f86gyq0RFSAntPZCC1KT1B2c54DVqOvkzWbIQRcK6QsL+O3knx2D3Pw+NJaNPONJkxCobPihRaejV0vVt2eWjdRoIf3fUEKrxUFnKSo2cAFFU+EVRsZlcYC2H/+Zd2Gi3s20W5WZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12CCap//PXSiUUp8nKi6VqlgkszmHf/8qm9Hkw0cqik=;
 b=Cu/Urd3idOPDNlni+92uoj36gibcFVkjF7DrBLn5tXE8gXJcTpIqyZ4W6Rcp4M8fMInPkkvbf+txeY/muXuxVcV0WOFMGYb42rjmlt446ynIMz2ipt5QrxWVX447ZgSAAcxDt/30VhrNw+w8LOkzeJkSMVuuYewVxw1xWedJ7nkSlWtcAGQihfNtT/gUeuxtCAwxFH6/KMXDU4yhogTUP3Ks1ty5yNC56pbrvjCjBjsEuyffw3jmcFgRnfYCqABezMbCu0UtXdXulZ2uWu+n+ZWZHma9oewSuEpl8JgJYl/tTxnIkZ17fVfFqOOwjQvVun7JsN3tj/GFSI4eAFL2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12CCap//PXSiUUp8nKi6VqlgkszmHf/8qm9Hkw0cqik=;
 b=N7NQhpl3YMEKYny2ikSY05KMG++VnZnKSPvw5dqwYAmlzqaIDNWVRhvfbZHNchr/n8LkLhx6YPAO5+inv4vBt/+o977zh9rjg00mFt4BX5zShVP0EXNj5AXsCsMTkT0e3N4wKdp1LWLkNe1T5iH/uPQ2mf3r5KVsX8BEx1Xvpks=
Received: from TYCPR01CA0137.jpnprd01.prod.outlook.com (2603:1096:400:2b7::13)
 by TYCPR01MB8881.jpnprd01.prod.outlook.com (2603:1096:400:18c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:11:41 +0000
Received: from TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b7:cafe::3b) by TYCPR01CA0137.outlook.office365.com
 (2603:1096:400:2b7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 21:11:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005020.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 21:11:41 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id CA56D3000230;
	Tue,  3 Nov 2026 06:11:39 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 4/8] memory: renesas-rpc-if: Consolidate XSPI_CDTBUF0 updates in write path
Date: Mon,  2 Nov 2026 21:11:27 +0000
Message-ID: <20261102211132.22646-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005020:EE_|TYCPR01MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: a2a586a7-6605-4772-00f7-08df3925e3ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261021123027099003|261026130827099003|11063799006|261021133027099003|56012099006|261021135927099003|261009223027099003|261028144727099003|261009221227099003|261026135527099003|261022115727099003|261022075727099003|261026140227099003|261021121427099003|261021130227099003|261026121527099003|261022113327099003|261022105027099003|10067099003|22082099003|18002099003|261102123227099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: HLunC3kwEeidXkawtbSuQrUgkU89Wy1bvoVkruO/7iZ/2TugAqNsDoO7p+L5rXxokiB+pErtHeIwii2M7zpoLltfzzATFiSKamS965WMw6jraIMLfL/LbmhgCL2gj6iz0Yj09jT/7jmzwdV78vZV6c46A+w6nuzT7/1eBb3PKIT58kgaVCvMrK8LVZtzt96nXhtddVRuNeiG9GWA1lKooWtxTRmYxzfuIP0YRVcIVmHjq+mY/AOur6tlChDTvab1HvqfCdOtRvXRWP9SAKg4qSwtAjE9K2NtyCnu+4v8j3KOOO0WZHMssxpb1Oq9i+nuRJ97uMZqwYn47QzXh0OLtuhctTIwPp1vborX5tIJEdXgZynch3F5ZBKddLg+UbG5IWN9WDxoAwyX4SOX/zq/gha3pPc+qgn0f7KsKaz40gTu5fFSoTERRLaI7yPn4fNMVwrhgIWn1GbJDVvCFH7oGK6PLK1otmOFxCVcmizJOLhjza76cB6W6qg+iOJkIN8mGNM8pvDoz+DYjFr6toIEUZ7OxrYSsorqh2wxRh8KrtM8PUw8AwT6Pb+/93pwTaixA2+QIq2YDzRqi788SiiFGW8NRnEWasi4Dao0l95WqzAqORn+9wHIV0PsxhnOYsdQuibrXP4bh1gw8o1jInQZKJaP8KC9oJmreeGTatsBsqI=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261021123027099003)(261026130827099003)(11063799006)(261021133027099003)(56012099006)(261021135927099003)(261009223027099003)(261028144727099003)(261009221227099003)(261026135527099003)(261022115727099003)(261022075727099003)(261026140227099003)(261021121427099003)(261021130227099003)(261026121527099003)(261022113327099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(261102123227099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /jBAjYHA29kDZ0K+SDOdN9Qa/YjZuiENpMsX59brcXYZZhfAbH396T6YMtE3+mJVcKXR5WYmDoq/9Usn1VU75DJibVtuKg+iGFkT9OSrOkDL0iEETNjQfJ5Ybw8/VwKzv9M5ZptDfromiZNAi0Lah/ZX0/H58IYRlcz2R2XGT+nVGnowDw9JWS+VzLeNUTlWkc1vsCl0viqti1bWYJz49bTvRTbsqHnWUv7vt8jop3pYp51UiRXzul6k+yOm1yTV37j3CwRg7gvntLaxkv8oz+M7iAehg1AV0ksLcDsgzlbMItKeF/xceLsfXuOASpovg5UFnv6CjM0MqeSY+bK7BgYx4gf2/cTwt/Z+87NwDUQti/cMxbrzd2R3Nw21thAcU1yIEhjmF5p81hXV1QquHu/qdBc4TgXhBBZf5ICOdxVSXMOLCs0V8Y94RjjnI5ZQ
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:11:41.1111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a586a7-6605-4772-00f7-08df3925e3ff
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8881
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 21:11:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24623
Content-Type: text/plain; charset="utf-8"

commit 008a7b9631864b708ffc06d42264aeef09f09800 upstream.

Program the XSPI_CDTBUF0 TRTYPE, DATASIZE and ADDSIZE fields with a
single regmap_update_bits() call in the RPCIF_DATA_OUT transfer path.

The existing code updates these fields through three separate
read-modify-write operations even though all values are known before the
transfer request is issued. Combine the updates into a single register
access to reduce overhead and simplify the configuration sequence.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20260727103449.3188105-4-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-i=
f.c
index 655ca50d1c6a1..6dd968ca62b32 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -660,17 +660,12 @@ static int xspi_manual_xfer_impl(struct rpcif_priv *x=
spi)
 			u32 bytes_left =3D xspi->xferlen - pos;
 			u32 nbytes, data[2], *p =3D data;
=20
-			regmap_update_bits(xspi->regmap, XSPI_CDTBUF0,
-					   XSPI_CDTBUF_TRTYPE, XSPI_CDTBUF_TRTYPE);
-
 			nbytes =3D bytes_left >=3D max ? max : bytes_left;
=20
 			regmap_update_bits(xspi->regmap, XSPI_CDTBUF0,
-					   XSPI_CDTBUF_DATASIZE(0xf),
-					   XSPI_CDTBUF_DATASIZE(nbytes));
-
-			regmap_update_bits(xspi->regmap, XSPI_CDTBUF0,
+					   XSPI_CDTBUF_TRTYPE | XSPI_CDTBUF_DATASIZE(0xf) |
 					   XSPI_CDTBUF_ADDSIZE(0x7),
+					   XSPI_CDTBUF_TRTYPE | XSPI_CDTBUF_DATASIZE(nbytes) |
 					   XSPI_CDTBUF_ADDSIZE(xspi->addr_nbytes));
=20
 			memcpy(data, xspi->buffer + pos, nbytes);
--=20
2.43.0

