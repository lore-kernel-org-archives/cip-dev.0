Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194F7C982D5
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:14:21 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35281.1789636450218691523
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:14:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=hygbFTqC;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.71, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zACvavtmeoiFAqVPS5lVCaOCoHQ5K/p26ODX1S7lSnCRdlN2QMZ7IwLZQYYfaTuPgIPZedD22rJ5TNFHszBDScbQJnfJRGzZgFtNJFbx0Ybj4AycXSP8MhaOILTehSeyOQqHxlT2oNlpugix68ynr1H5HOlszq++FYfEPu+w3BAx746HfXKF2WyRzOUWkLlURwt6EznBiMhA42e7n0xontiPCw6jYNcBVOnpe9xjFEaRgLgMhB6vcV+1SlKdMiK3jph0e1zncltzLPd9Ya9E19NfySxOfhnDBIpCGH1sCeDZlHj2zwyqHoOPT2pkPv250O62TIipEzcUOgtXuuSGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xobAQ/z/TFP3XXuYNKsOk6WLu1VqgIyKUdX8ybBWWzs=;
 b=S7gLUotVW2FO6Igm+oYBd4vLJ5Gb68ogzE8U0LsZ7oVyr9kjwfKW3tWArOyYFAU++T63289nhnSGGFcxEaxfaAIDpHjdHv+mMzmTxTnYIkqEDJpFghn6DjAzRqw7AenfEhkVfwNYFlcpVjNn0yGY8QN5zLqFKiKOF/LRvNQ2uS+2Rsv2PyzT9R4ASZvIKEKzmsSGmx+AWudS7aNH+nfzqpNnsd35iZmwU2BJzV6VkzeUjMgbgMnZvTNtFFobc4D0NvkJppe+tQecX578WdqvJfc0M7KUOWLNWS0IuDEg8RSkBBLQRB50aa08WTK/tl3zFeNJr2pnTMp72sEp+OImrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xobAQ/z/TFP3XXuYNKsOk6WLu1VqgIyKUdX8ybBWWzs=;
 b=hygbFTqChGTrPJiOC/qBP70OG+owOqZOSD41RwgNtFSKJJ/1yXIEq6/CevBulghzKY7K2HXjwzyvislgmgy64rcOE4sw/ksqUgf9BcnKkQFFe6qGuUNYZvBc1dLCHh93vXFvyZZA97yngmdXtRzbURAK6iVRbJ8tYEOkmD+pRTo=
Received: from TYCP286CA0293.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c8::11)
 by OS3PR01MB6724.jpnprd01.prod.outlook.com (2603:1096:604:f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:14:02 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8:cafe::42) by TYCP286CA0293.outlook.office365.com
 (2603:1096:400:3c8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:14:02 +0000
Received: from Ubuntu-22.. (ukr-5cg3160n5k.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id D913E30001E3;
	Thu, 17 Sep 2026 18:14:00 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 00/10] Add RTC support to RZ/V2N SoC
Date: Thu, 17 Sep 2026 10:13:49 +0100
Message-ID: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|OS3PR01MB6724:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b5a6e5bd-bf6d-4598-86a8-08df149c03e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	+LM8QYiSjaeaS5DxZ+kllXIZzqKPpolL3qiRNHLj9ztektqlGScDwHqVbTRng11CUAocwwnlHCqkorceCpI18WZ9qvYSWKwSDa//+Wk7PgB1JdoCgHcuOCc3cI3nYHPYXjJNrREDYExlXuHzqbY+Iu+9TUrmaIcvCgBTCUc+/Z8WnUhCuhcODAss0uprIJPp1S3HxDNx3XtCNCgzeb3cCzPBlwuvGsd1PUS6TOhvlRzhnGQKJhYxDy/nsuc72ArFqyplmfnxODWAUyy0YAkO7fjwbz+9T5QMLcTWYgr3EHNl+ZnIWF/LEaSVwXiLztztBEjdvgSr1Zx1731MwbZqmJ8EbdYhC/ME48uMANT8//7jwsw8auSSghBLtLRv5MiY8+PNFaxDGrCnf3Q6txB73eu+UZmaR9EuYhlWoiGM3Cu42MGvjmVUmZ4DizrJFwOmgGUXhDwkTN6vuu9wrX6q4Hgomx9c/x1ClcLMfB3TLxjIUQ5CaJTD2McbXwJ2gT0ivFQe+wAzBA0VT7qWba6lgoTi4NA2EH8newV9tSS/QiuKbix6nvbQMwGC2YWnwYuvBijxnz2JHuBpjWereg5C0HfiUbizepj84yNSLt7BtB9JGYdYHWNF28vwxv9N7BrvFjxdEhs1lGh5OZ5k+hlo+dxhzEMFtdAc61qjplL1V4eyagok8L4f0dRJeZZ3+9MFMlK78x5Kqtj7LVVQ85Cv/Q==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	HZsr4umODEcFABzjEINx+PlkDY+U6fJCQV5n3nR2fbjIAiOMRXqWqKnyWZ0mmfMf2GyG3waBrgE9jm7f/TvhSxkT9mqB6x1ChuZ2S5fHuznc4/FRhA2qcqkaW5//po46GoIi44meL3EJOr0gx9YNNxGhxGGM7gpJE+r1HXYyFiCma81NptCFg+R8C/H3yeWI+Q8EITkjLSblXWxxzFmNzF1NCess+xlP7ItCWEtXmhD+iJK6hm5p1by3fy5o+0wXxBJ3D3PfSbhmy+zJpC411hzr3yVKT4wiRWeclouPUdcIT2EZAJnQxEzAxgVsCcqLJLarvME9t4Zd1oui0TTr5Cc1F4pNyhRnMQ/kYQ9pztnGPREUWLnYaBvvn2vQRKeTdnqbPwKYCT0GejHq1W8WY8pBHe4IViRQ70A18PZuM6oCJMeiK60Xm3CjtRGk10oC
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:14:02.1970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a6e5bd-bf6d-4598-86a8-08df149c03e1
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6724
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:14:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24198

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


