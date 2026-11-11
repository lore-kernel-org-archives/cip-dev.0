Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.20])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5776.1794388749689780302
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:10 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=DVa8d1V3;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.20, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/iv7tB/QkXL3SPyhQEwww/YDMG/U2MtzyNxZN8gEi4GxnjrDoVMlD+B+/xmFse3XNzRo2u7dl4Pm/TuwD/EiYgBm86pS5xRevrGFJlYKIu4QXu2ijO1CEHYF7Ho9TNARa0ts2wunEtr2154zvEFCrciE5WTyP0uMVvJHkGQ4HKdobssWfzYzIWS4iQ0ngF6Ngrc99u6cMgvJknUNcvYDE0AMkr/HcyS6Zv9XKzXUndxTK9XGpEh/gTOGTCSYECTqSimYed1uUF6glpBaTA0KHXjptpiK3eNwAi8TIlOm60X8TSWmaY3UJeeWsfZu9jMlwmlaRansO7MeeUwiLxrlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zccpvkE6p30X1WNblKEyS13JLhrOIkW1V5nCjsxN+Q=;
 b=wJaxqdtkh/NdoKCtO3VRSTp3df4yiilc3n2RRHpiHpYVJhjNAKa8U1FpvNqIIX6W6EOxB36cBh+skWHD7OAb5KRb/YFIcHemLnBDVcw7ntXVAWV2R4ws6QeWPm2nkvBwTgG/NR+WDTXRXRw7JqVZtmlW4FN16vHfGGTbWWPltVU38+xLh9pf0FGK4CFsHoRYqdK0H60vQ7Yz5uHkCPKrNMb+L+Pviy9raruGY+KWSPKpGle2DgWI8d87l+z/AIU49dMYoJpYjn5vsDcGVetJpjIiEttPh7Fw7GPqESgEKb+/9RLMiz97zHfB3nQ2sUzVDGJhgLfBXHJJHbEgsIQgdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zccpvkE6p30X1WNblKEyS13JLhrOIkW1V5nCjsxN+Q=;
 b=DVa8d1V3TsThkApDqqRwtjHq5QbGHMpi3TSIs1Ff1vXZE9c1xqRyR0Hz872oLg2iebWFSeGlWtry51YU/GhEsD4J4sn0Brwse4rN2odrCv5Fxzk1mWt/SjIEy5HJS19B68YrWSaU1eKJ2QmUstT2TK/0Cnr629aHLYt/ytpH5j8=
Received: from OS3P301CA0048.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:21c::8)
 by TYYPR01MB10611.jpnprd01.prod.outlook.com (2603:1096:400:30b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:03 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:21c:cafe::78) by OS3P301CA0048.outlook.office365.com
 (2603:1096:604:21c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 09:19:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:03 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 2C74B3001DF5;
	Wed, 11 Nov 2026 18:19:01 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 00/21] Add RTC support for RZ/T2H and RZ/N2H SoCs
Date: Wed, 11 Nov 2026 09:18:39 +0000
Message-ID: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|TYYPR01MB10611:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f04549-703c-4dfc-d0d6-08df3fd4d436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|261021121427099003|261028144727099003|261026140227099003|261102123227099003|261009223027099003|261022105027099003|261021123027099003|261022075727099003|10067099003|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: NwaOnYaB2VXsvDXFlzNMeson5dwvxzIu2fzWBzpZ1GCgkB/fNlSDxGaVbjRNCCzfXqt8Y4S+XyNq+bgzJkU9eVwiKuRHuiX3AkWtkf5VD2If8QlfFKH2vZ4071nRzVPtm1HYSWwFgItbpxxiWiayj9+1EljnmPJqd9RDwCLSHsot2kf8jto7ta0avhCeT14m/bFgOm8zlhEOuqQSaS3EdSu3LrrKtsKVQkeYpsWzgU8nOKSS275l8xhDTO+k+kF9TAbLVJc9wbd4EdKskmfQdN4xWia9tSXPTMbk5mq7kfAsYFWMEQBa+ZBAyPG1jCpsmAe4ozlXf0q7uJg2pimBknpMyS4xZyi9lMAKZ2siF0tk8518cR/IxHcQBKaRyEt8C6cNA7kNAfA/IFDNoqqpyIoXF/bqULjng63BVmmpBDpnbPqT3njnm47kuYgcQ7zgFDx3EkjU+YzUe2RuqfvbyCZuP2swPLBJAxgKlkrypCHqhoaJalwwGyxXSwv9E2E4/+GztT0w9E8m9MmUlsXM3NyTos95CcTCe5K5zLsIlnuY5qunYiMNltPMe+R8hbSsl3I4kr65wfgSnPjKPBi5GQRx/nt8LimuOuxCDX/ddrKKKO0k87FA2Phf2wNY3DR5zTV8xYzsqWLHSxVV424Wqqfn+dWfvpGw3iwfnf3Fm+U=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(261021121427099003)(261028144727099003)(261026140227099003)(261102123227099003)(261009223027099003)(261022105027099003)(261021123027099003)(261022075727099003)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: crICpCdLcB3aYz1sosenFzzq1qVUuB294vMSEYdwaCrXFlTqyLdYjqKIO3+nn/AGGLOfwD0uecneUmc23Ntis6NmRxhrOkp+wpLKqkKtBkfl/st3piMQm52WfTYofCvBwUspbu1alqpbVvrwewB4YlRi3g6u05PLriWKg6N9hWf5AGTZARBRL/vd+v9IhI/4WGdM2874bKQmq6VyL9e0j/B8NF76hCq5O457W6AZnq2u5PDrRsuXCPcpAOaFj+F7WdxHIGUvTipZbGHTfvkGiSSkSfr6V/Mnz57LD44vuMsOgpn4WDaGmZExrWa3wQ8y+tgY1ClD+w/32D0fbH2RrvYqwfV3VJz5cgm09MKUz16adkmV8oot5Gf0k3TrYlQse3PhdaR9wZZ66/+0QT/eYLYeWbaI2W6Ed2Z+kl1SaxJYwR5f2CJWZpjMqgUrBtLe
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:03.5252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f04549-703c-4dfc-d0d6-08df3fd4d436
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10611
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24741
Content-Type: text/plain; charset="utf-8"

Hi all,

This series backports RTC support for the Renesas RZ/T2H (R9A09G077) and
RZ/N2H (R9A09G087) SoCs to 6.12.y-cip. Both SoCs use an RTC that is
compatible with the RZ/N1 RTC IP, so support is added to the existing
rtc-rzn1 driver.

All patches are cherry-picked from mainline. Note, this series apllies on
top of [0].

[0] https://lore.kernel.org/all/20261109121451.6042-1-prabhakar.mahadev-lad=
.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (15):
  rtc: rzn1: Handle EPROBE_DEFER for optional pps interrupt
  rtc: rzn1: Fix alarm range check truncation on 32-bit systems
  rtc: Kconfig: Broaden RTC_DRV_RZN1 dependency to ARCH_RENESAS
  rtc: rzn1: Use pm_runtime_put_sync()
  rtc: rzn1: Replace remove callback with devm_add_action_or_reset()
  rtc: rzn1: Dynamically calculate synchronization delay based on clock
    rate
  rtc: rzn1: Use temporary variable for struct device
  rtc: rzn1: Consistently use dev_err_probe()
  rtc: rzn1: use FIELD_PREP/FIELD_GET and GENMASK for register access
  rtc: rzn1: Add OF match data to gate SUBU register access
  rtc: rzn1: Drop trailing comma from OF match table sentinel
  rtc: rzn1: Add support for Renesas RZ/T2H and RZ/N2H SoCs
  arm64: dts: renesas: r9a09g077: Add RTC node
  arm64: dts: renesas: r9a09g087: Add RTC node
  arm64: dts: renesas: rzt2h-n2h-evk: Enable RTC support

Wolfram Sang (6):
  rtc: rzn1: drop superfluous wday calculation
  rtc: rzn1: reduce register access
  rtc: rzn1: implement one-second accuracy for alarms
  rtc: rzn1: clear interrupts on remove
  rtc: rzn1: Disable controller before initialization
  rtc: rzn1: support input frequencies other than 32768Hz

 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  13 +
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  13 +
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     |   5 +
 drivers/rtc/Kconfig                           |   5 +-
 drivers/rtc/rtc-rzn1.c                        | 350 ++++++++++++------
 5 files changed, 272 insertions(+), 114 deletions(-)

--=20
2.43.0

