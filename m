Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D383BC43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 18:23:43 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.8])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.157786.1783362218198193030
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Jul 2026 11:23:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=OMVhJjCc;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.8, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJ2N7LMNbseZ6uWesfhySPTuCcNNZIrER3SVYCvDo3I7lJJajRoZJCIw+m2Mk7e7dnpAiiIBDVZ1hsiuQ5MclNp2WpnjkfIYR7R8anbJEoVVqdbraGS1AyrS62a+CLpGW/AZWVf4Cj+vHHwFW0Rv+/3EzSH0XJTNMZ/591I9jj5Lz8PeqRKdaH6iv1IrYg6ugqC2zt76mLRuQospmOtoPX8kbDwxhay2XsIpXyYPoE0F9zH+05NAOXrzv1WKrJxabvOguPKDOGh4IHMKDIBeFg9l1cSK144SGtyRP8AIbwwgDWt894izCIq9X7Q4t/QozAgUy6xhWLYv9RYRiIHe7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AseLHDF0n+6K5VHeBgHQr0NJhgShLPNsY+m5pVYVtS0=;
 b=AYkr38t10vUaJZ01opQ++UE9MV1fMOtK4QjoiVuikdDRJsk5GGXiMetTQQ8QD9uEFKyh0mfSpbEcIlR1s+NQvNfLfKNE8qHxgJ0VNkoK1aTCrT3b4VtaA24dsjdoJIxbufhE/VE8ylfST2j7pfXw36Tk27aeqQFr2cauCVI2i0DrWCbzSq1ZKRa7IvkEJ//eT5GQTV2GFAcAN0AhLbNSKq7mlz/lowdljel9HA1vTh5QC8LvuOnubPk05byreXw9FSI284ZSK3ybeIUKydAmf0LZX4k7KRwWiyXfpypD9hvqocHtKf9OUDtvNUAMxxLPNW7llvzKicrOW2SjIuLf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AseLHDF0n+6K5VHeBgHQr0NJhgShLPNsY+m5pVYVtS0=;
 b=OMVhJjCc2quadpZK4rxp+ghzFpBk9a2oKQWpTubaj5Se35Y5isceS0CiaQK5Xti2nAuRbPZogevkXPSVBrTMlmg76/bLnUb2cBxKU6uHP5b/MUHi9h0+I9OCSNrSH5Y8RT6Ae3SrTgRFkNnJ6Ss9BeywdB8BpgoePqlcJTeiVpc=
Received: from TYCP286CA0216.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c5::12)
 by TYCPR01MB8190.jpnprd01.prod.outlook.com (2603:1096:400:103::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 18:23:31 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5:cafe::29) by TYCP286CA0216.outlook.office365.com
 (2603:1096:400:3c5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 18:23:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 6 Jul 2026 18:23:31 +0000
Received: from Ubuntu-22.. (ed-eng-lt-ism.diasemi.com [10.24.0.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 14DAF3000152;
	Tue,  7 Jul 2026 03:23:29 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 0/8] Add xSPI support to RZ/T2H and RZ/N2H SoCs
Date: Mon,  6 Jul 2026 19:23:20 +0100
Message-ID: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|TYCPR01MB8190:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0dcd9764-f397-4070-67b6-08dedb8baeec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	yUQkjKWZIoSrfgWqNnBpIxN62fwDjEk0Y9nYqqBF0/e2kz8s7uax3BlHgIeUFpGmMgk4/rC9XVUSwUoDtzUVIzDD9+05Ghjc6p3QZQwSAQ2UtkumQ3mza6UJQx1MBY8g6s9sUFr4WzD9y4jtZdk1au50BIeTcvi9Dw4iXYTLB27Ny6aPx5ahlIDhHQ9fpLAUaJU7epnrjw7SzsvfSA3rY404I/obvDj4tPx3EO9fxunKXhw3HUv4EacA0PsWO8rwcVF/VJX4IdgS8/N7aQwqa44FjqPCXRwxYaqTlqBIfQGKUzV33rjKB32bikxjF4QuoXhNf+L3Iqdhd07aldH3rbFcwttHHIly90YwxHXzEyqqVxczYSmAtDEDA5di7Q/k3TEep0wM9GzQre0JktV3VnfYYIcMVat/aYLFUJ0BEK7qO2t3Th+StpWO5bit6FuAMmAn9N5oVAEVl6m05jM6+4OOLUlZxkS86NnrovlFDfe0LvqrjiVJVkKSZsmceO4OiNL6oBooeaTywPzAytplelE5hxC1x0TABT3VRPtspyCMBKuEaKdVxd0TeHg2/0sr0syYHLjdN5oGrW82qRYQdUox9Uwrr666Ewt4uUJs0Aw0r3/HuxiYzNH2w/pZFB/LADqXpadupvtp6vnYRSg6N1NITOxAXeWuWlLFV+3OTcY1GZXO6JX+4pqsnDrVwGhFhakEBYQGnIp14y8XHqs/TA==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ACjeTq6MmEi0tzHA6gDiRTCgF642QKToGgRpzIceqbVr46HCyt2R2pKJ+Zit/idRCJkZehCNSGJpvIB38BjqaBuuhBQrM5DpYz50zHGGJDYEFyY39xQJi+JhG2S5JWmgt9fNJJXsowENKvAYzQQDzQYFIOcCUgh+Z7DaaGGNqvbgaT7LRwe9bfFz2FdV5FzGIFuGuoXY7GrIrmhc/yoWevWJSLdbsyakowxXy60p/XFFljPU7jCnm3wPf+3HYbUtWfcDJDnlTNlkZpB7Wj9wZK7ihqkd7WBUIF9DGKcc8Ek/EAGcO4Y6HO2lkQ6wsgiVbEGyMm6oF5ft93noNmdQd3VtQQnCmxWTNK/h2T/df912rccVnewqJZ2z6DME7G5KLNlhX3Dv2HRWX88sDOjM7pXZAfMQDqjp7lEIxLwONTZSzbf95dzlGhmrSK5s6Bz2
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:23:31.4341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcd9764-f397-4070-67b6-08dedb8baeec
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8190
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jul 2026 18:23:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23462

Hi all,

Add xSPI support to Renesas RZ/T2H and RZ/N2H SoCs. Patch series
backports clock, driver and enabling the IP on SoC and EVKs.

All the patches have been backported from upstream kernel.

Cheers,
Prabhakar

AlvinZhou (1):
  mtd: spi-nor: add support for Macronix Octal flash

Biju Das (1):
  memory: renesas-rpc-if: Add suspend/resume support

Lad Prabhakar (6):
  clk: renesas: r9a09g077: Add xSPI core and module clocks
  dt-bindings: memory: renesas,rzg3e-xspi: Add RZ/T2H and RZ/N2H support
  memory: renesas-rpc-if: Fix duplicate device name on multi-instance
    platforms
  arm64: dts: renesas: r9a09g077: Add xSPI nodes
  arm64: dts: renesas: r9a09g087: Add xSPI nodes
  arm64: dts: renesas: rzt2h-n2h-evk: Enable xSPI nodes

 .../renesas,rzg3e-xspi.yaml                   |  60 +++++-
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  40 ++++
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  15 ++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  40 ++++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     | 127 ++++++++++++
 drivers/clk/renesas/r9a09g077-cpg.c           | 192 +++++++++++++++++-
 drivers/memory/renesas-rpc-if.c               |  60 ++++--
 drivers/mtd/spi-nor/macronix.c                |   9 +-
 8 files changed, 515 insertions(+), 28 deletions(-)

--=20
2.43.0


