Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22204C43327
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 10:24:10 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.30])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.65742.1782987840061571898
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2026 03:24:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=vBS4wHeo;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.30, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGr0T1Qd6UrZBB/XZorI8ANuaLGS6i84jAujYNxw0XPgLtcBmbjk0id1HmAov52NSy+90xunlOMqzVr3n4kmowYDq0CPnp3U8Pp9uViWEbCnD87uTgrcWhFhpG8XcyclR2h3czmVZX663rVdT8U+/h3Lk3nWhBLgK7VvKlq+9hNbmLhTex5IoYfxOi77V3oR8kjrEhTy4o101u0zqnh9N4TUAOrCWPeyr/dXr5kAvgptMLqIJyGzPAITTIzNN+S0xWaeSFexRSpTXGAwQuwWfvcG04XRI/3w1o5Ice2P1F3SVPW1SYU4WpTyFz6+eI727n6/CmLAFswSsnGCPeuPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnuiH6hAHhF0mDtTnx0seZVpQdxyuuEwrhXnOFV/itE=;
 b=taphnc9H8GvaD7Igb/arWEhOETBH9SfOZbZcs5S0tBZWq/sdIXA3ebIgkKIYDhLTncCu5t99avKTiUW1SFiLAO7j/B1abkxCzOv/FmlgD0fZJac1sAAk/FLz9oSYuBdE0DUyl+7d8DvR5bnoCvWfJyjVKTa4V983q2qzC6hC3ArjO6tQHN71SiXIRES/Hm1CyEH/wbFcQLC6QqUlBUbtQkEbMrk9eH/fqjmh6UpgyYstBRmT77o2GcLUnMsGGN/rBexMrCtnSFuDHO0iQb/fpLRBXPfuYQZ0EDKFKR7kHCxfrc7AFb1ifq2IcREWRlgdjCZpYIx5whTXbDwDsdPODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnuiH6hAHhF0mDtTnx0seZVpQdxyuuEwrhXnOFV/itE=;
 b=vBS4wHeohtVxnHfTM1DM0vdMZatBbPbj3j2BjMIJVyOpAi+R7ApYsnHTueHD2fiRas+cCQ9eLS0bKUwWF1Z3IuFbzd7rfqmCHr1ItS6ck4oKU9K/iw5+FHLLudPiKhfncrOcD2nYsAe3xird/w320JNR7yN+k10TBUszTtNHzzs=
Received: from OS3PR01CA0085.jpnprd01.prod.outlook.com (2603:1096:604:da::18)
 by OSCPR01MB12707.jpnprd01.prod.outlook.com (2603:1096:604:33d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 10:23:53 +0000
Received: from OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:da:cafe::25) by OS3PR01CA0085.outlook.office365.com
 (2603:1096:604:da::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Thu, 2
 Jul 2026 10:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D214.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 2 Jul 2026 10:23:53 +0000
Received: from Ubuntu-22.. (gbr-5cg2250zyy.diasemi.com [10.24.0.18])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 5E640300024E;
	Thu,  2 Jul 2026 19:23:51 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 00/10] Add pin configuration and GPIO IRQ support to Renesas RZ/T2H SoC
Date: Thu,  2 Jul 2026 11:23:39 +0100
Message-ID: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D214:EE_|OSCPR01MB12707:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3720fec1-7717-4e86-7c38-08ded824042a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	mYKPCdZ5ddMhGVvcG3ucOcqWLW5V9enuy5UPB7AZkaNJLLPj3zXcRI7WSmSXLL/C1duYcKX5OG0srNLz4UBaKtwh/RqRVPGmcjMxbENxc4UpUAPTz0Zx1dnUXIWPtDdSvtEIAdVccIxxB0EUs6fa6d3zw3/zyQymeX9gHviikPablvd3s0kmvy2qi+RaL+pAYrS1Gqg08EdJJcppH67BNxIryplxlh39GIn2AU6TaAr0VEGGzsaYtjvYslExZD57pL5ZmnpRgLKrGlxnFDhMms2PlcwS/2MmmLIMGaCgYgzy5ANBU0WqlbO4PknJo6dcCKJSSjuMZT9VG29brtfQ+hQRPmfYspyagIZQMZv07aP7utn1B4j2EQR7MnvSOhWvWlcs2raREjqQO8VWHUPSAdPcd3g5SqK4K/24h19IcGhcK3k/XtBUYztdKjwe7OKpSTLnwaNvax14S3Z6Mo9sQQ5DjOShcqSwcYMj070Nc5yjxG4QF1pwAehCdYAOYMTb8Up4Krxn4T3idXQUhCbNzeq11SdqOapAWhknV/wjuSnDVBcXTt88x1/4CfE5i5t0GoD6z/Vv8x/vGlSqhEHiGDnNKOxkfU5IDfUOBmAZjpUTDTVN0ndDuxiu8Q+ADPbLlzpWkAICXK/3Yqq46JGeHaEI/MQ6b+BNCBDCXx0Dsc7STofI3WJSamOb8D2IXCfejSFMxRwzrD5AItaRDjlB1Q==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	DZSntO4wlbaoWO0OSACQZNYqSN1mkN/gjzS8UMiTHjUC6jAY670ErFNEHXfhGpyPRdvcPGV9QylRdMHyurmQdKRssYsJVMXwHKsZR8yDevk5Mw8+8QSs0IVfRY426NA9rn9eU2Lp74vRf5QCXDDgR2JyNvXT6U1nKFblr7iu1KqciqRh2QnQJ/ucAJoy/KdRmqYHffV/WvEjv4ZgM1WMAVunNTSnU9EbL1rcdl6VUNk8AlzLO92JSJNdUuIbNAXBlAG8ORD08Bf4wZ+8ohLRlR97scm4nLFm8OkR420u+kaXhnMuuI20ci0KWRnmwjNY+UVP9ga8wZcQQFGe9PpFis8oBx5XNSrL6kfuLEr8KWL+WNvHEZn+W7SzJtc6kzKBflwe3PQSQh8Wjw/N4/h0V2ugCXx/lBOG6RGR7DG3Rk+sgnsR/Kqv7mwBFmyBzTXb
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:23:53.2864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3720fec1-7717-4e86-7c38-08ded824042a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12707
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 10:24:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23381

Hi All,

This patch series aims to backport pin configuration and GPIO IRQ
support to Renesas RZ/T2H and RZ/N2H SoCs. Enabling of GPIO IRQ
support to SoC/board DTS/I will be done as a follow-up series
along with xSPI support.

All the patches have been cherry-picked from upstream kernel 7.2-rc1.
Patches apply on top v6.12.94-cip26 (commit-id e00178e6fe853).

v1->v2:
- Dropped patches to add field_prep/field_get macros
- Added DT binding patch

Cheers,
Prabhakar

Cosmin Tanislav (4):
  pinctrl: renesas: rzt2h: Move GPIO enable/disable into separate
    function
  pinctrl: renesas: rzt2h: Allow .get_direction() for IRQ function GPIOs
  pinctrl: renesas: rzt2h: Add GPIO IRQ chip to handle interrupts
  pinctrl: renesas: rzt2h: Fix invalid wait context

Felix Gu (1):
  pinctrl: renesas: rzt2h: Fix device node leak in rzt2h_gpio_register()

Geert Uytterhoeven (1):
  pinctrl: renesas: Remove unneeded semicolons

Lad Prabhakar (4):
  dt-bindings: pinctrl: renesas,r9a09g077: Document pin configuration
    properties
  pinctrl: renesas: rzt2h: Add pin configuration support
  pinctrl: renesas: rzt2h: Remove unused variable in
    rzt2h_pinctrl_register()
  pinctrl: renesas: rzt2h: Skip PFC mode configuration if already set

 .../pinctrl/renesas,r9a09g077-pinctrl.yaml    |  17 +
 drivers/pinctrl/renesas/Kconfig               |   2 +
 drivers/pinctrl/renesas/pinctrl-rzt2h.c       | 554 +++++++++++++++++-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c       |  10 +-
 4 files changed, 556 insertions(+), 27 deletions(-)

--=20
2.43.0


