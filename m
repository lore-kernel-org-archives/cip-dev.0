Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9BBC43327
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 22:53:43 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.20])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9253.1782773620684081626
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 15:53:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=RRGpp4Qd;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.20, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZD0r7RQLH/BpB5y3ewr1ubv74c9Ylt00+WnTHew6Jx7CyTPQZxbX4I02bu7oGs0Z5UwaB1ISpOZotC89rA0XRNeezQjjz+Cu2Fz1rjRtlCLPMIrrHVsHGH/GP2A297NVoGRGgxM+0R0cVKtfGCcu7M00Aj0vzcKoo2qSYPznGrATN30Oie+B4Ojo3AFiDvBA45OIaoOn1P6QvVEf4qNLdvK84ph7Zq8iJajkzd4z2zbkM4kvOSWfMEjWcZudfkNwZRDVTuamW4r6gyDbo8bi+jzDzHUKbZkhD0y09XMwF8PkMJGXJO7bLoPnJEG1PTts/Ypqfmmn5bwuYmIbonhXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOThXaiW5NzjJL+fTrutgO4qReEk50p06OX+bRDWxB4=;
 b=ZzyvIeiyeiM4GTEUxnZQ+Ws0aSD2j+JseH8KxuCHNZ8js2IzYUHwqcYXrKvod6baHDPEUuZWInjCt+OUCq+OTg29mLjiqw+OuQSGDGeD3BNX0s/Ito9kjsgXAlFeeB5E/roHE8cvu8Z9ku6YgE/rGhC5RVM5+swD+aR9RXquSyJqwovnz5Pa+uVI51POCr88SOzmi/EwaX5NoCSNBZ1/IxHZufIRvlYZu4NMF0+THnPzEBaqrbI6nWf6Tr6lTh2GpYzYPxNdgd2EpIn76ssicccCxRJTEjgaxcPN/lsE0vOVL7DrgoBFBRW6pc2KiDBQyc4zExdwG0ZCOlYDrM6JIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOThXaiW5NzjJL+fTrutgO4qReEk50p06OX+bRDWxB4=;
 b=RRGpp4QdWh6C3c6VF15eb6PXcs22aGq2N26drrPj0kAQXJbZ7fx44NE7YPU1gSGGrMiuRHBFNcNS3RODq1OQDLKbslN8YxUKI5ukk+EPsnxn/GYrW99KJZwg0TMl+J7GLSLlzKhXKppuMPGJIl972XwbGECNZUSMK4dsohfJd5A=
Received: from OS0PR01CA0054.jpnprd01.prod.outlook.com (2603:1096:604:98::25)
 by OSCPR01MB12770.jpnprd01.prod.outlook.com (2603:1096:604:337::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 22:53:34 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:98:cafe::ad) by OS0PR01CA0054.outlook.office365.com
 (2603:1096:604:98::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 22:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 29 Jun 2026 22:53:34 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.99])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 0658C3000255;
	Tue, 30 Jun 2026 07:53:32 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 00/11] Add pin configuration and GPIO IRQ support to Renesas RZ/T2H SoC
Date: Mon, 29 Jun 2026 23:53:20 +0100
Message-ID: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|OSCPR01MB12770:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e11a5b-41d9-408b-0709-08ded6313fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|56012099006|18002099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	O2xFI1v1Al/UaTiMnmvDWCM/oZfayOFnAIavQvaHAudwiH2VQQMNvHK68plnvn1Zp6116KUx1AQ504megB3QpEjwaH1i3Ubavob65v6akhkm0y1zVcLfvWXpYvx9Z+xoEQh1l38vop7gZJa7S4BCCetUl1xZ2LTWW/pOFW7KvYuXHhiIcviV5wWGS3gUva4sgGZNeDoNe2uOxNRkRY8fV9ZJn4sSTaQysu/9hwijbgVM2/CDEopBBsG9iVMR3zJn1vyTACDRDpsufDdXn+9y2pYVAsTskCeYGZUGCpvMI7skwpB10+HauZTpylXyi/Jw/O2Gt3yqzYBCWEDvnMA52XhZunFBra0DVGTzpvAM0k8dQT639ACICkaJRu43XxyROMt4cbEhJaDzLu6hmA+AWWkSWp6f16Gpo+n4K6iNJl0bAUkV762rs3LSt4FrnhS4bYOY6wLe22Bdgz50hxzHEWCQ8gAms83d6kFr3pHBWjhnugyTwIHxizVmN9FQ+T+vCBg8uN39Dy/aNWdq1L2CI4DluzHQfjTVHoKtat3hkY4UfbnOVuwV+G/olJYmqdxhsmRo+NSBFX6W4Iin4eKptRl3Wj/e4HqWmEZ9hSaeGflAhbShG3O1tuzh+7Lf/+AhfwulSm4V20USE8J20xJNkzmh8C4aggok09YPLPUP7OSgiLMW5hxuYQDvFrD1VQmd/qSOVJ9iMk+KdzmBSvC0aw==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(18002099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	+8JAFgHgf3HQ/CU6ybRaO2tQg7NFVym18fbblK50VgPDdOrdw7rrWGOIgUY26G9y2duuyw1bGowDcuehBCKfRGhuLrKMnV51/r/NIcSGqKMt+GoDZ3NlyIsbkrw6t4VVl89g742sqtU81KqetA9Zu8h3Fya8kKHgoCn2bCXmYS17z2fhkpLFu7bjWmJX4w2LK0gAOQJXLAtD9HOb2W9jDBICHxZMyor6heRofUXu9Bgma0jx6f6G/Gh7DeVxDUETw6LUjwZ6qeA3IBU+aembh81rdvrsLxqd1G7RFnTlnR0DdaZLxi86+1OmKhEPLx4hVudVp34LP0VMYMOkMD6yWv2RKkm2z333h+NpeIDBxz/KYN6olt+rWrh65j/G+Ez2u7KoDK6y9Ug8T4mOAkl1vryY4fCThl3OIXJvJm5gD+Wru/KgDrlCHoVEtvi6su3p
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 22:53:34.4837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e11a5b-41d9-408b-0709-08ded6313fd2
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12770
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 22:53:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23308

Hi All,

This patch series aims to backport pin configuration and GPIO IRQ
support to Renesas RZ/T2H and RZ/N2H SoCs. Enabling of GPIO IRQ
support to SoC/board DTS/I will be done as a follow-up series
along with xSPI support.

All the patches have been cherry-picked from upstream kernel 7.2-rc1.
Patches apply on top v6.12.94-cip26 (commit-id e00178e6fe853).

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

Geert Uytterhoeven (3):
  bitfield: Add less-checking __FIELD_{GET,PREP}()
  bitfield: Add non-constant field_{prep,get}() helpers
  pinctrl: renesas: Remove unneeded semicolons

Lad Prabhakar (3):
  pinctrl: renesas: rzt2h: Add pin configuration support
  pinctrl: renesas: rzt2h: Remove unused variable in
    rzt2h_pinctrl_register()
  pinctrl: renesas: rzt2h: Skip PFC mode configuration if already set

 drivers/pinctrl/renesas/Kconfig         |   2 +
 drivers/pinctrl/renesas/pinctrl-rzt2h.c | 536 +++++++++++++++++++++++-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c |  10 +-
 include/linux/bitfield.h                |  95 ++++-
 4 files changed, 608 insertions(+), 35 deletions(-)

--=20
2.43.0


