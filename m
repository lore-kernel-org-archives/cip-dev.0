Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14965C88E72
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:16:35 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.55])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35310.1789636588303971880
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:16:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=IdUKKtWS;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.55, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdLEGqyDdNrfqhCXwXW74/AFp/cE6LJ6MWFuQEUCex2uQ5mtQOrdkLs/uPcw1Q7H47w7UpkkchKr+tbut4MRgG17JwnHnnSx6UPuJB89DqTRY3k+IQHDalMoXwTfDKC8bd37qGkOyvS/dVmOZdndTimCHktfvzI2RvWlH2bGZoNJGKPLZvnBedo/w/tww2zEv6hjNZv+fYhcDo6/KhZXVWx00J87vHm0Azi+ra3p1qzUo3hV4bq+3w7/PAdT9oNJVHxg41LukFDmLPqAsQO0RuBqwrE328TOyaqyFPwyEh1zkJVn+lmzjBdW8/GC9UkaBExR6AAQB/8I3uWd/eleww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xobAQ/z/TFP3XXuYNKsOk6WLu1VqgIyKUdX8ybBWWzs=;
 b=kCFSWluYXncfknNMThPLv0YsRUXfdQ3uTXp1gZUvaRFuBO0LqpD2ULaswdKApUJ2ejJfNozx9/tGpaAsOIhZ13SiHDLbEqxWfVkGmOZHO6xotkdI0T9xEbSjJX0NCF8FPzrWCiSAR4NgSdGLIr3J0la6uqpYpqjpw6F1MCKf0w8vticjX9tKdEUAtziFB+YYowKNyxOQBrtwBfYi+9zYIA5FCwanl4QIXQC2+7vWSrGBosqcFvF5J8dW3sYblX9Dd6h6oZgvcLZAaQ7eH1/KXP2oDX5aZlUV3XXCmvSnHAEgTyeX32cK6W6/9Fcx7U984HtsB20yNmuvKKnXFDgxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xobAQ/z/TFP3XXuYNKsOk6WLu1VqgIyKUdX8ybBWWzs=;
 b=IdUKKtWSuC4BakfpMAJ5ajePMKPUZqaRwlhIraVCdyLEUIElU9g7yPTIEMmC44HDdcf0un4y5Xo14T7AldM0cjgOWtJFyhQzVczccESu3WBqje0vIXABQv+2ocQnKUhD/AVY99XpOKV2jt9SOJ2vVabDpH39J8Cr72MpQ4hKCjM=
Received: from TP0P295CA0016.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::20) by
 TYRPR01MB13233.jpnprd01.prod.outlook.com (2603:1096:405:116::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Thu, 17 Sep
 2026 09:16:24 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:910:5:cafe::88) by TP0P295CA0016.outlook.office365.com
 (2603:1096:910:5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 09:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:16:23 +0000
Received: from Ubuntu-22.. (li-hr-lt-dhl.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 9A3D430001E3;
	Thu, 17 Sep 2026 18:16:22 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 00/10] Add RTC support to RZ/V2N SoC
Date: Thu, 17 Sep 2026 10:16:11 +0100
Message-ID: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|TYRPR01MB13233:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b35ea115-34b9-48cd-faf3-08df149c5860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	SzOeBJ4dRekO8IJL3nu0vJSOje1irDTdwwlc+DdG/F8UmbRkuy8E4S0KSCza95+3a/H/RTo8ue7YGf8AZSGXwMM+4edzmOrFUjZ/hDKVBWjlTYl1wOzBAEeTaGp9pn9Evd4MfnMjib/JeHesh5siy0mnGbQa0m66811l0+EsteJCSPTlt34Qi/IvA12Kbj8EVVlS6mCXtiC+zRmilVzZQYTCPr9AFUTn6oDXzVLmeAcpYJrIlA0hBsvEkhvbN5VeUEmlGNnchQwJOjGAI0n/eS1JiQt7nu+HZikPutmp8WxG7U5qKBq/A24dSPUsWQvPsXMHOYhXsc3StJQ4S64Tppixge6We+DXu1ZP6AN10ClN1ioCkDXji4VrE0Eey/O6MrWDlHBGRBMFgs3oJr7ipudkwQPQVlwsibFY5wJP7CCGA1d3UZZv+Ka+/pIIoIK9yHZSt8Qy+ZJll5VoTRcF7OVPJocDq2VhDlqL/Vze/ulOCmiWXGXGOy31rAO/6tH10PJnISx+PsY7xLLR4MzcWIOLOdf07fHb1sEsQfP0xxXpDbGK7hzIDEo+hBJC/oYmWMlFc4dObUDIk377JOKxmU7t/Km989eOxFRdMKyZCsBEsoDhsdlFFPuR3LEMaRM6SAc6kl906u3ZosaALlolheW/S7fKcuAd+FOpCv5L2bI7yVOOixe6JZ4Wc0uKC2NocDWL+AzFKU/7aJ0AMsbzIA==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	hYKGXDGLgGgDCScoAHruvNZ54j9iChSY8Bvm+NV8qBApcXNs2c4zqCjcCzNt6ArTMp8ryC8L6zO5KvyXaCtK+SN6ONRssOtVsxmtgTb814Mi52RTuF4P9L0vF+nIYfY6Np9zAXOjBDmmygX3q2WAAe0oFdMuUVKX/TPZHColjgFLa0EQHrN4tuvxLrJ/8d9uu4rViRHu84NQGQSH7BEcHHpt3XZqDxBfh2Cov2+4bgIBfLm1Yx5EYzv7FuC9Ffu2Sw+/D7x1caetetP+PH1O/xkEHLgaizFFQEM/ju0S6d/dx5BUkAXpBAFa78XtEPctwKABnoLTrLv4ew1L8vCseUY6nkFfXa4ODhAYKtBk1uX/tB0Qh5uu53dElLOXRGGoQkNAg8HnFaibvyEnKmW2UDJtWv19PzssYc3XWszfUGJDnVEzqtoTu+NLRSeNZghb
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:16:23.9608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b35ea115-34b9-48cd-faf3-08df149c5860
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13233
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:16:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24208

Hi All,

This patch series aims to add RTC support to RZ/V2N SoC. The RTC IP on
RZ/V2N SoC is identical to one found on the RZ/V2H(P) SoC for which
patches have been already backported.

All the patches have been cherry-picked from upstream kernel.

Cheers,
Prabhakar

Lad Prabhakar (6):
  rtc: renesas-rtca3: Fix PIE clear polling condition in alarm setup
    error path
  rtc: renesas-rtca3: Check RADJ poll result during initial setup
  rtc: renesas-rtca3: Fix incorrect error message for reset assert
  rtc: renesas-rtca3: Fix typo in rtca3_ppb_per_cycle documentation
  rtc: renesas-rtca3: Factor out year decoding helper
  arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Add alias for on-SoC RTC

Ovidiu Panait (4):
  dt-bindings: rtc: renesas,rz-rtca3: Add RZ/V2N support
  clk: renesas: r9a09g056: Add clock and reset entries for RTC
  arm64: dts: renesas: r9a09g056: Add RTC node
  arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable RTC

 .../bindings/rtc/renesas,rz-rtca3.yaml        |  5 +++-
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 15 +++++++++++
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    |  5 ++++
 drivers/clk/renesas/r9a09g056-cpg.c           |  4 +++
 drivers/rtc/rtc-renesas-rtca3.c               | 26 +++++++++++--------
 5 files changed, 43 insertions(+), 12 deletions(-)

--=20
2.43.0


