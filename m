Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F98ECD98F3
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:35:36 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.60])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10817.1781685325940444383
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:35:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=SufW/X6c;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.60, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMd7cyfwVz9jCImSZ1SppeXc6hQZJ2sgSNho92pl3hkCUXiEBJumniX5Q2wqE8QpOclBDBYx8Su+LzF/Wrt+RMzcKjMSErNwNLU88aqvE4JvhZ68HFncXNgvYm3Mkh0SqFKxPNccKIOujCnXLoywb2WWUSDBuzvvzvINhhU83uJxox9mfVoMBqRAkiJ5eAQ/PUd+tdkf5qxtuHXwrEKs9W8KTN3N+A+bQnP6POdCG3nftqQtJC7YwryAmc26QUt4bxsNJUD+A1xp1J49bbFNk20RXooHY21L7o1w08FZ/Trp2ZkJCnkzmqhESBHZmOp9NNtlY7xVbmlY+B7lVbEstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqVZId751Xghy3sirZE99tjyxIrmVWTQscvRTQxDMTE=;
 b=WDh5I7xdvJz6hSsm+twS4Zu4mPl7uT/v/7MYUd1D7aN6jpRSr4LNNhRm4EX3j/8DZdkEBEx5sCdfR96F5PCXogMjUw0QLjaG4HiOkH8BbUteatKXA6CF17Pa5iW5euqK3XnISKBOXFJz1osEygC4ZNoV28KPVMIoYcKUA7tIgHy1fIWN+QuElLzohJFUAi8L0tIKIyrWxhuD6RXnfc2dFi6a/iG5u9YeS3Qlzepjyqy+i06A/2yQUNK/ZbvBbJL5PeHj/XuFy+Ht7AGxCONuaax4mbu68h1uV2gErcwjswMjXJ4zCJSU+Sxu9Y85hzS+NkBoA4iU8pP3PRCMc8wiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqVZId751Xghy3sirZE99tjyxIrmVWTQscvRTQxDMTE=;
 b=SufW/X6c/3cMsDl79bhiw7O73vx4P7gJee8v/vXpQlx77QcnZQrD0Mh24NCRfPdR+KmDSqXSTWOCMIvkWcmmbEf3YCwb7RF0QT96aq6UqCo3v4pMCOlwTYotewdQUL1kmqtLOmN3mQHg03y9NtBMZSl116yclHuq2SXIuIGq8Ms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYYPR01MB13245.jpnprd01.prod.outlook.com (2603:1096:405:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:35:23 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:35:23 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 00/24] Add RSPI support for RZ/G3E SoC
Date: Wed, 17 Jun 2026 10:34:38 +0200
Message-ID: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYYPR01MB13245:EE_
X-MS-Office365-Filtering-Correlation-Id: f826d39a-2f06-44fd-a4ca-08decc4b5f59
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|52116014|376014|1800799024|56012099006|11063799006|6133799003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 
	ioNVte5HcO44eSDBPTMso8KZvMbvfldTJ+mLhKXx14onfjPyEiJYBlRqe7OWz1T4/cn0xd+QyBg1x3TkMj5SddXBNO21Lc6PLhmSmOvmOv0e8hVVXD0WUUDrRVujH+FlrbhGcmriEeJ7c0iVVCnQ0pH9NUIoe66qYW0UoGnLb0sNH386HvftCQzQ1bAEHTy2ZBEmmGT3QwcmGpmix9YbBm5xEbsi/TCTVEfwiInewBU8exHNRFXUMq4gZWnMW6NYL4vH/sEaavXDmioLuNTLWONfi2nz2kwpsKw1JUK7a5ZdE76cF8Q+OD/Q5cq95svRzJ709/3/CkdlAoalF6KCfCmqflUeeNoIwlWGp9O0fIsRPyjOJ0CvLSglDDzYDC7TrUGfTLk7kmtKEVTwPn8KRvUiFxyDg6ar42l+iMrPj15VAeLLgmos5WVjhsZYpC6eMA+uoP0GDBjDYMIfZQTlNLFGkUnXZdrhNMOv+TSg/WJRQYZa2dI81vbiSE8CNQqdgoZHAClhN6VBi1eABQAK1b9ssvXz4vdZSdyY69/mOu8ui51UDhZPiom2JZzi8D1VC6cFU+DGTeBWWAfLfJRTAO90BpLyz/V208g84fj9JjllAIw3UO3gSgiB9tK1A+MWUO3egCtGwCoy+roLSBQQ06W+DmA4+HQ8g3f2WrV2FDwZZVPkz30GiYnLyLAZKaSkuNFdBDD0bDGO4JMmEgeQlsFTWRb0UeDel2x3TEjEydO6qEy0ERt+KaiprD5sgUJx
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Vz1nt49I7sdeDwIk6YLKIzGLKVU/iSmN5u/k0e0pB2H2ORCScezFnHPQCUJf?=
 =?us-ascii?Q?Nd1aQJObknnFhwYORZMaDfVMVE5bCcew5JHSiiy18sW0l2DwRUZawFoismCK?=
 =?us-ascii?Q?HnPhHN9maV5316r5AC3mdBi5uTvogWUY/K73smixTE0AkrIzjVyihgfe8g+9?=
 =?us-ascii?Q?fwPCbCQKfvYtShcsvnLBtsANpnTYvN9EnmGLXjCYqHdUd3WkhGy5OBBTps4+?=
 =?us-ascii?Q?xSpwHNpK1Sw6Xpz2Zu+km505iAGo9X/vNhSWFGlzD9qtkRR+e7mYCR2Cwpig?=
 =?us-ascii?Q?ffCi8wFN/ge/T4lNWmCMjiZzmqww4NbbybRTNQ8UeEXjEfMLTQf2cdjBb6X3?=
 =?us-ascii?Q?ijg72EGveIj5/NfslTIJA4EgiVFVSVEC/whggj03KkUM2kJm9+RXkGHQULag?=
 =?us-ascii?Q?JpdnrXJ9SSaqloRVxA5zgVcVRCDb26WUALzDUtgyWO3fY37KF0MzatGE8KNn?=
 =?us-ascii?Q?HrkmClUUdf7d/3EFgDL65OgWUkqKnGRusmYcZeCKORUC21NKoyqHV4CXwHOE?=
 =?us-ascii?Q?5SDf9kVL2lNQ7Bqz8VSjjeUHPK+yA1ZWHGyaW5s/VqwKUyFrvSsmj0pSsMgY?=
 =?us-ascii?Q?lRMBmk4aNnBIZUN+Gjm1sQj4Pnk1wVEsmq3TXhO/4ozmy+Z2AWwavdCOgiIP?=
 =?us-ascii?Q?AmTUnDOJrb1rS0+HhB+4ANLrOebplzLjg5cHdipEQI9GrkUrhyADkv8LgPM1?=
 =?us-ascii?Q?06oDEn57IkNXlLSw/WgUEypM+kAbjIiR0P6g9PqsGotsiStpjL0OavOxxips?=
 =?us-ascii?Q?C07o4kPlwXvjOWRE9y0BDV1ikQaUFGrn0KPVbfMyOpXdW+Q/btGsYkqqE7rA?=
 =?us-ascii?Q?WFHP01+FytlEgW8tirNLGyT83NO3L8A5R4UER2ctAf2NwCFRHIzbkVqUlPzi?=
 =?us-ascii?Q?J47O0JrL3xnsZpagWEM9BgU+JWMI8e0vhA+lXAD13iRUjPdW3yzbW4s70KyV?=
 =?us-ascii?Q?gHPYhNBPx/yy1hkBKCMPFSqP5jKNgR0xgD+KEIXhaEP4Mkkoqsaf2mPWVfLb?=
 =?us-ascii?Q?w4cpw6J/mUdLpocbOk0qqBJOojxdGXUV8yj4v7HiFdBWsWl63aAQBD/pT4jU?=
 =?us-ascii?Q?tJ7Lr+DkWGk/TeYaBYDfyeP9BIlDEQ0b1tbP+KmHerHqnnztlZ14DrSiii14?=
 =?us-ascii?Q?/XUwwzypwuobxTgP7tctJtqD6RR3sskZbXVWzrwtvAQ2ZWE8WkB9Y+rA6xps?=
 =?us-ascii?Q?sMGM0aShalMg4wsPjGjiTH3q10Io0UH7ZCRE0AiXaiGEr3ACjVJWILEVkbow?=
 =?us-ascii?Q?to7fkiA7wZxBzijhZgJHNoKaqAhivx0wotYvgFo34VisFCXEpyLhgidwLmEj?=
 =?us-ascii?Q?Th2DxiKQg1fwTDdj7srfLRVZbOpchCJ1FkLuzF/dPUlqRabbYBSjWxJTmTZl?=
 =?us-ascii?Q?jHzdgDjhmlc2jv0N6P5Wjt+kqgKE9dsTlF+yTatj83U+Yn2NjLObdGGjNC19?=
 =?us-ascii?Q?+QY92wb2HZ01L/bnS8KVGism2zw9suSBLInswLjV+WJgqPC4jSnF8hk3NbPF?=
 =?us-ascii?Q?lYZTDbPTYKNttLD9jRqn9+0TZdAkdJEq9q+lDhTB66ucn5lXx8Z/i5MZ9H0/?=
 =?us-ascii?Q?ZIRDCITQKqXbYxMcwwof2MllPF3RllZoLyAqF3L9QzQjnNTsPC3Ozck5ca5e?=
 =?us-ascii?Q?dtAQ7DsuDixMrdLDz5s7+bIn3kXHcPH2FleJE9TzOFxTkYuOaI/lhJFai/ol?=
 =?us-ascii?Q?XEs5e3OMit4RmjzVtfrj+JqBxDJ5GIThJtoPyba2TN/TjmohDO9SYe8j6YMP?=
 =?us-ascii?Q?X363uViSA7lYhaYHExXiMDp2D49xXMNCP+gh0VDiveLviyX6epQf?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f826d39a-2f06-44fd-a4ca-08decc4b5f59
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:35:23.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9vhEhdDDqC74iMq8FKHbIVdXH7WAsZNRuemVINkrZ1L8DzQwHbh4LdUSdtgIEHNrz7kxz2hgKgkpx2etrgq2FFz/E1XGnMhruS6pvcGs9nos2mLvPrvPYM9HlRocype
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13245
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:35:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23192

Dear All,

This patch series adds RSPI support for the Renesas RZ/G3E SoC, which
features three RSPI controllers. The series also enables DMA support in
the RSPI driver, and backports the necessary infrastructure changes
into linux-6.12.y-cip.

The series is structured as follows:
 - Clock entries for the three RSPI instances on RZ/G3E SoC
 - DT binding updates: document DMA properties and add RZ/G3E compatible
 - Device tree nodes for RZ/G3E RSPI controllers and SMARC board enablement
 - Driver improvements backported from mainline: DMA support, device-manage=
d
  APIs, bug fixes for clock setup and FIFO thresholds

Kind Regards,
Tommaso

Bence Cs=C3=B3k=C3=A1s (1):
  dmaengine: Add devm_dma_request_chan()

Biju Das (1):
  spi: rzv2h-rspi: Add support for RZ/G3L (R9A08G046)

Cosmin Tanislav (12):
  spi: dt-bindings: renesas,rzv2h-rspi: document optional support for
    DMA
  spi: dt-bindings: renesas,rzv2h-rspi: allow multiple DMAs
  spi: rzv2h-rspi: fix rzv2h_rspi_transfer_one() indentation
  spi: rzv2h-rspi: remove call to spi_finalize_current_transfer()
  spi: rzv2h-rspi: do not set SPI_TRANS_FAIL_IO
  spi: rzv2h-rspi: use device-managed APIs
  spi: rzv2h-rspi: store RX interrupt in state
  spi: rzv2h-rspi: set MUST_RX/MUST_TX
  spi: rzv2h-rspi: set TX FIFO threshold to 0
  spi: rzv2h-rspi: enable TX buffer empty interrupt
  spi: rzv2h-rspi: split out PIO transfer
  spi: rzv2h-rspi: add support for DMA mode

Dragan Simic (1):
  driver core: Add device probe log helper dev_warn_probe()

John Madieu (1):
  spi: rzv2h-rspi: Fix silent failure in clock setup error path

Lad Prabhakar (3):
  spi: rzv2h-rspi: Fix max_speed_hz advertising prohibited bit rate
  spi: rzv2h-rspi: Fix invalid SPR=3D0/BRDV=3D0 clock configuration
  spi: rzv2h-rspi: Simplify clock rate search function signatures

Tommaso Merciai (5):
  clk: renesas: r9a09g047: Add entries for the RSPIs
  spi: dt-bindings: renesas,rzv2h-rspi: Document dmas property
  spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3E SoC support
  arm64: dts: renesas: r9a09g047: Add RSPI nodes
  arm64: dts: renesas: r9a09g047e57-smarc: Enable RSPI0

 .../bindings/spi/renesas,rzv2h-rspi.yaml      |  25 +-
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  84 +++++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  16 +
 drivers/base/core.c                           | 129 +++++--
 drivers/clk/renesas/r9a09g047-cpg.c           |  24 ++
 drivers/dma/dmaengine.c                       |  30 ++
 drivers/spi/spi-rzv2h-rspi.c                  | 335 +++++++++++++-----
 include/linux/dev_printk.h                    |   1 +
 include/linux/dmaengine.h                     |   7 +
 9 files changed, 535 insertions(+), 116 deletions(-)

--=20
2.54.0


