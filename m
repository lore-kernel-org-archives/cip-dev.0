Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1832.1793653912221374211
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 13:11:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=KClHDeq8;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.34, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIWX2Afle4kRl7TcKXSb+ONtMdT95jEHeY7HZ9qsgBLmcn7PUpD+VfM1js/pdjFdVbKPSVTEJQFtCEJvzftbHCpQAmTZVmrApmxkAbN6eNppC7IFmSBIl+A3RBM44MAbG9bzqKYFKqWS5Hl5Z3ZH4wcJhStIX4CfFa7Xwmer9AxEwyO7eZwWb8OnXs0kc++cTbiZGbLhlfxCT8AruwDf299Cy4YBrNYXdQUSFlPwEZ31dWHEpMgiTREVGu0YG/ul0npNVTIiqusXlIaPPA4P54pej77vrp7CNf8+CHxzc/3ZT98GPu9H+MPIAz8nNCj4vzX/AC4tQx9Iak81eRjW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCG6odw9pN8SaYUYr2CDsaN8tVWxCQuCmjzG+Vbrdx8=;
 b=cnkZvxcoBpqEZw/1HA8JgWaRE5JvB7gpErxppvSkH0IDmW9+U6vtixdY3l3YXfGsmRsEeYIfJafFNKlIyo56ROwyIdIG1El7uLs7Zed2yiJUYJrj13b21Bs9PScyIhJGrK0NH6XKwegr3lWISJH2ISKW39fvUh1XotBNS3POGYu0dEsDcXIqV1DQGkum1PgnM7J9ZrWZavoNFEGDx2GQJj4U2SPKDB801KwI4bJ8R7XR0JzuisRQ/SUhNPExLbLYY0CFC1gQXH/D8iv0rm5zGXmt9qVj0sY4z99Df6UD/G48jmF5aC1P1aZFrFqhk2C8JrRSQkaccZdSR8vXKHaj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCG6odw9pN8SaYUYr2CDsaN8tVWxCQuCmjzG+Vbrdx8=;
 b=KClHDeq8bWLanflGOMG3NrLYjX45L9M+g1wquHQvEnWHTD+YKQwitT739AiViohHv1pSqwBJR3zh/c48CpXDodSg7WwK/sltkeBBB/B0JlHbCO6WGX7WOs4bQneDbVzLzbwoPHtHTDqNVP2fLuTIsNwR3iOAqjPafz1xEiig8vM=
Received: from TY4P301CA0033.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:2be::13)
 by TYCPR01MB7966.jpnprd01.prod.outlook.com (2603:1096:400:187::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:11:46 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2be:cafe::67) by TY4P301CA0033.outlook.office365.com
 (2603:1096:405:2be::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 21:11:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 21:11:46 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C42C43000230;
	Tue,  3 Nov 2026 06:11:44 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 7/8] memory: renesas-rpc-if: Use runtime PM autosuspend after transfers
Date: Mon,  2 Nov 2026 21:11:30 +0000
Message-ID: <20261102211132.22646-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|TYCPR01MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa82e44-30d2-4561-b996-08df3925e6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261009221227099003|261026140227099003|261028144727099003|11063799006|56012099006|22082099003|18002099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: rRB4IsZ83paniZ7NfNkk+1j7QYHU2OVw87Y5Mal6LXJhrREb7vN0n2nRI1nkVRaGh7I/u1hoULkxXYCCzw6HAgnVZ2jA3W028sN103NLPhUwScbwgZ1MciwJCM60CbJrZTX0h69jmiRi7wSZgLtNDJ7TqurV6KJkFRRJe62pl4gPqpXFryYa3eVIC/0fcd6SrlmIbrhZvZt69B5A3RPaSz+G1KNrdEKS4W2BALl7zyx8MdJxcBlLEBbYCc5nOgmWtgN7o3sjx9Lm+v23Nog98xYjddqAUsKx8ancqp4gImTA5rXV2+DcsyirOhnoLl1oO6pydkP8x/HavHzg2GXtk6hpVcdnDKSK/3yX+5DkI5v+48ubZi4rozk+3clZCZroVGiIf9h4JHL3zOpc6kZ07wMjNoi40qJitFrK7xuV/e410kyjMMO/smr9Yszt43Vxj9NCWyfzAjA568med/0gKCZCPpCrBVf6MFUF2Z4H7Wty3pTsW9XYqIS6i5B8P/zCqZoACMtXGj5/n4jWb4ALe44UyL8rsXna8Lslx9rHsbDiP49xdQ3MN6Q1/1V+yWEI7Iun2tFtxdpLG9vUujsXmkv7Hzxww1DjPcgcCYqdv9mNZmsukZpSZIfttvpO+RTNPLIbamFsLhKQh7VhiqN5Qg==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261009221227099003)(261026140227099003)(261028144727099003)(11063799006)(56012099006)(22082099003)(18002099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I8RvvUD6W+k/q3LQLCBwH06Z0P7/WrkIF74uef1CTZbG6oe1K33MBPC4iRX3P0IgNVUDbgAOBWEEf6PJA/DI0sLELlc7/+a4otDEUD6mKVq2ISWQCwsREzUncZJG5+mCosrLCJnnshq7Vcs+dU6CKD6QPKlkSkn0qqJk33HsKkqCLaxBe8U21xcotp2ggoH2tgGtzNjcrBIm9avFLyKS78cezKWds3Cr8X+3mShSjAeSZvNxKqalNiVysE8/2CCLEmBunCMfNQ2tRRoIssq7oDZhs7WWzZexIAYH8kH4Q8HXrLjPeJ/k9TPqVHfXL6/pchLmEMVMqyeHthVfaKiI9pMlmTs58FHNnaqhvhcCyZ8uFeKRpRZTPgdFF7iog2Q/7kRzfrQ84dOzTNqB2tm3Um8msOfausxdlFOjidDcPnSJD1EqO3eE6u3dIB78Fj4S
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:11:46.0566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa82e44-30d2-4561-b996-08df3925e6f1
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7966
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 21:12:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24626
Content-Type: text/plain; charset="utf-8"

commit c8d0e87bc2413c6a3f92c7130a4cbad51f8703da upstream.

Replace pm_runtime_put() with pm_runtime_put_autosuspend() after manual
transfers and direct memory-mapped read/write operations.

Flash page programming may be performed as a sequence of closely spaced
transfer operations. Calling pm_runtime_put() after each operation allows
the runtime PM core to suspend the controller between successive
transfers, introducing unnecessary suspend/resume cycles and potentially
interrupting multi-step transfer sequences.

Use pm_runtime_put_autosuspend() instead so the controller remains
active while transfers continue, allowing it to suspend only after an
idle period.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20260727103449.3188105-7-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-i=
f.c
index 7ea91f7d519e0..0b685979897a9 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -776,7 +776,7 @@ int rpcif_manual_xfer(struct device *dev)
=20
 	ret =3D rpc->info->impl->manual_xfer(rpc);
=20
-	pm_runtime_put(dev);
+	pm_runtime_put_autosuspend(dev);
=20
 	return ret;
 }
@@ -891,7 +891,7 @@ ssize_t rpcif_dirmap_read(struct device *dev, u64 offs,=
 size_t len, void *buf)
=20
 	read =3D rpc->info->impl->dirmap_read(rpc, offs, len, buf);
=20
-	pm_runtime_put(dev);
+	pm_runtime_put_autosuspend(dev);
=20
 	return read;
 }
@@ -948,7 +948,7 @@ ssize_t xspi_dirmap_write(struct device *dev, u64 offs,=
 size_t len, const void *
 		regmap_update_bits(xspi->regmap, XSPI_BMCTL1,
 				   XSPI_BMCTL1_MWRPUSH, XSPI_BMCTL1_MWRPUSH);
=20
-	pm_runtime_put(dev);
+	pm_runtime_put_autosuspend(dev);
=20
 	return writebytes;
 }
--=20
2.43.0

