Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.12])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1820.1793653901179566455
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 13:11:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pmY9AT9i;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.12, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNSyuJvVeJ7GHw4pYaa8C4UOKqyVJtcE0dAtJYyS6e9kM0sf0tVHCBTXb1pZbnA6GV079loJJYZOdRro6naubpHm1Ik8WnTFOBnjKsNkbxnCxBsHp6mWMizyztY3XQLRv8M6PmeNQe9+9sN15GLWTF5FcsNNSi9pi0tl/RPLHaRGv93XecVrdDSpta6ZqPzh/hDOQzZinKKVs+oZt5aPK7gtTougIzfYUoW2X9h8Q0yYloEXNk0obqQYDHC2PMWrc09WlypBnjX/51r93dJZRLjIAIdzLHteo5mTuI3tVSQWQOqouWZ5tiNBTH1NxWNft6CLJAx+hzig2b1guwhhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LPRZ2M4Ip+bzcvbATWAx6VCrvTgcHXl2FMhY6Omq+4=;
 b=DUXiUVNt+cxl7eNv6ZtTM+NyeXJjRE6TIT9ThMmcm0pPB1SeP1FkwEf+YbtR4afpNJu0tt0gPkpmm/3/SPjXXS2imNEo8iHLlJ7WMUIeZqHRzQKgNo5R/BAmWe9u/+ADnQM2UpG0WuMu71pydcc7KvWty16HxcAliMnhKER7/sw8ylWoEJsn6YATxPgLMJUrZcuYQ1N4IsXt84MJKvRkw3BB47WXwfhzVOy/27xivEDLHUNhNPiyzZ95KMPg3zuODK5QL4YmlGvpXRzvBxVHgzEJEV6h8As9sbg7g7ntt+iLKZftPnIad2qPXRoEEXQQmIvfaZKA7KUIiXlQYhQehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LPRZ2M4Ip+bzcvbATWAx6VCrvTgcHXl2FMhY6Omq+4=;
 b=pmY9AT9i0c3vZvvaJbpmg9uAXAue1M0QB83oRb4XpcdT0KeioJkbAqcjgAtnBs1DCUTe+KTyYUDtQ2bZ9bMCtBMBkMu+1z5QQVz73nTGVN7uu002k2zAoUJzegS21rrfRVeuAfqokzgaEG3ydju01YjaafAW8o2koSxEqHVPw90=
Received: from OSTP286CA0035.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:224::20)
 by OS9PR01MB13163.jpnprd01.prod.outlook.com (2603:1096:604:30f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:11:34 +0000
Received: from OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:224:cafe::94) by OSTP286CA0035.outlook.office365.com
 (2603:1096:604:224::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 21:11:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003C.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 21:11:34 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 307C33000230;
	Tue,  3 Nov 2026 06:11:32 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 0/8] memory: renesas-rpc-if: Improve xSPI transfer handling
Date: Mon,  2 Nov 2026 21:11:23 +0000
Message-ID: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003C:EE_|OS9PR01MB13163:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e2b6b8-6f61-4ca4-b365-08df3925e017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|6133799003|10067099003|261102123227099003|18002099003|56012099006|11063799006|261022075727099003|261021121427099003|261009221227099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 3RPuRJ532Z3TFf5RnPz/7GYaDe5jG2IFHqT7NV55f3Jb1+ZBRrwdRBiFUwjOzeZ27ufHjCiluOspZDPBdVUAT3FBO8sfEPjHvPJxLKHXmlBY0TBqBQ/73rTuAhHToXR5cQIoqIJySxjpKBL0eSnB/ehdzoJVfYuXSLHJvzgE2CcmxQpEOkvPJRWQY9nSHCoBM34DtoVORvErnu2PQnhuBrpwGtc1E5f1KduYERzrnj6Tp6pI1SBBBdf9L7sLvqBUHRFZvdhQMsTQFByX25BXpQkJF8fzSsM1+ypKD7GZo6IpQDjq1SoYmY5IQGTu/13IB4mQFbcpZkpAIW2xTASCZrjHluN2Q+wAO4IJt32FpGtvek7Xjpi2UhUrLd5TcxQ6f1UFk0kNwRHmGPvG9yto/4BCz9hOXncDb9zwDbjQAO8WlLXI5Ww5ATC7scy5mRPebG5l+6YArxTQRcwGLUwu4cpybcvxd8DEI/yf63q3Z6d3uA3UOH29hhqlJ1JMdcRKQsBHCzxN8XAklgJrU3emfXFTo3AN66Yyr/fP+cF1p/Engrjj369yhISqk+xoI1PcbZMR0BlpOFjwNVqd7vt8oHJ1QCsb7ZfJMozbxA9XJ4yacfPDX45Vvzk9ZdYJWzOhZR4r4US66YBiHTMkjrl49sgsANUC2bVi1V9mhr2qYI/LmgZuDfiL9JBA5ejIqD/DeCmdsxBcUKznYEFMVycwJg==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(10067099003)(261102123227099003)(18002099003)(56012099006)(11063799006)(261022075727099003)(261021121427099003)(261009221227099003)(261009223027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aFq++y1stw6yrjzr8Esg25EBIyGoB3hYVpy30UciezWpcRQmgP+8G9tPTRuzN41UEFCCGWcLG8LF/cRwwFHGTIjWWKV6p2Z0RchoG5pKgPOGFmNguacb/e3RrwPGVOfWaC9ld0OTHMdrRG1WFpnCehYWkx+lp2LZwHXixqgBdqZQ7h8F8sWTBWwyq7tavo7toakueU1eFRsWBOvggkj4tiwjFYHREqsK/eGw2CqMR2xrt5lXhVNDQlclsdROr61NRh1uZ37KjvjknDZdTltAV9DFERYVa+zI1a12A9P5g3zpyVFlKQ8OwHFC7gk0ZtA/JQrqDsP6keXVeu9/QqFZN8f/HVKA0gYb28puxhtSMGZ0Ox/F/ejmCadH30V9PddMVpI8hIeRUGipf94beOiZgWWLSyBphQSySSqsN1vGG4yOLrheUfhr3SPUvJH4YDSJ
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:11:34.5495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e2b6b8-6f61-4ca4-b365-08df3925e017
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13163
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 21:11:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24619
Content-Type: text/plain; charset="utf-8"

Hi all,

This series improves transfer handling and runtime PM for the Renesas xSPI
controller.

The first patch configures runtime PM autosuspend in the SPI driver. The
following patches reduce redundant register accesses in the RPC-IF transfer
paths, move static bridge configuration out of the dirmap paths, and ensure
the data buffer register is not cached. A further patch uses autosuspend
after transfers to avoid unnecessary suspend/resume cycles during closely
spaced operations.

The final patch marks the XSPI1 boot partitions on the RZ/T2H-N2H-EVK
read-only, consistent with the existing XSPI0 partitions.

Note all the patches have been cherr-picked from v7.4-rc1 kernel.

Cheers,
Prabhakar

Lad Prabhakar (8):
  spi: spi-rpc-if: Implement 200ms runtime PM autosuspend delay
  memory: renesas-rpc-if: Mark XSPI_CDD1BUF0 as volatile
  memory: renesas-rpc-if: Move static bridge configurations out of
    dirmap hot paths
  memory: renesas-rpc-if: Consolidate XSPI_CDTBUF0 updates in write path
  memory: renesas-rpc-if: Consolidate XSPI_CDTBUF0 updates in read path
  memory: renesas-rpc-if: Consolidate command setup register programming
  memory: renesas-rpc-if: Use runtime PM autosuspend after transfers
  arm64: dts: renesas: rzt2h-n2h-evk: Mark XSPI1 boot partitions
    read-only

 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     |  2 +
 drivers/memory/renesas-rpc-if.c               | 87 ++++++++-----------
 drivers/spi/spi-rpc-if.c                      |  4 +
 3 files changed, 42 insertions(+), 51 deletions(-)


base-commit: f0ff96b9db4c6dd62a05fb58babf7d08c83909de
--=20
2.43.0

