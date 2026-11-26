Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.462.1795708569504837514
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:09 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=d5swV6tT;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.39, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbs1uvE8PgMye3rnB6Q3XLpRwLTAeZ7CHMIXHfauO08wzHc8BlpfxcJN9eZScv72XP8W0EiBAmIYcQpZokh88fRWYHZ3admQ2zEHBHsg4khe0zjTwJEuND5LK4EDBwhPp99hp7azYihbr4+z02gL1+3vaPsbRHrAyVGFU9n9bQTMY1WsvI0S2Ld6lcbalR/0T6n0G5gs+ocqs9aW03azr2N9wiIY2cMetZcWmJQ3VRB2tO56z06EQz06sIC1VUbl9VWX5n2tNWEuvskg99RRGaEsPnVyjWU7L6AiF9rkN2pouxZT9EsfMKBP3+N5ns3BUMeOkJcwQbn0P9/TbX++UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOeaNMqQeNT5GpUMkIzLpgLUoXxUez/n46T+dy7A5r4=;
 b=ADxF7weXQC6Efjyp1gtQxgrlznzLadjs6fciSnSHBSwaC1EJrVU/IVkF4bjy7VFuAuAHuKZ8UCnt8TvCsrUcyE9pi5DF29JCZO9sjwvMk7ANHCW3pR6owiLfB4uOO3JVb/mYPwfFjD1Hu094rSXwri/UHzdxiuhrQStmZy5Ibx+Md5ncqQ1gNqjOcHrca56P3UfENrTt3HY9qzVmnAek0Ew4bUUije5cwfeIJ9fhe2ca70Q+vviXPrJX3mSsvDJfAFu/g94o1WnHo7WSdE4ErHA5k4Gb079IuUXqlL2vaXcqbS4pkkDw9Qn1nhYifRuHxAvJQVj9uGjVHb8eh/n+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOeaNMqQeNT5GpUMkIzLpgLUoXxUez/n46T+dy7A5r4=;
 b=d5swV6tTeFZu5Z/2PFJKWYZtcUvYqDHOg/7hA9Qe8SzAKT52ck+sYB8MPfWsriqtK6iynBxBevT6fBe071U/wKw1tvH2wsJvBWBfX5hOWMpS0+Fcp8kr3seTyZ7+Q1bM6TumeTO3rzttlA4hoBFi6ko38EFOodokkyaqvEERK9U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:56:06 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 00/23] Renesas: Backport DMA fixes and improvements
Date: Thu, 26 Nov 2026 16:55:22 +0100
Message-ID: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To OSOPR01MB295138.jpnprd01.prod.outlook.com (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OS9PR01MB16957:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa27465-42ea-4692-716d-08df4bd5c7b6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|261021121427099003|56012099006|10067099003|11063799006|261026130827099003|261028144727099003|261022105027099003|261022115727099003|261022113327099003|261026140227099003|261021130227099003|261021123027099003|261102123227099003|261026121527099003|261022075727099003|261021135927099003|261009223027099003|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: NQCRzUYLYJRNzDhrP1isaJDncVhHEz8Hy9nTVlXAxqTw3xNlZWvDGrR2Z6ABAJM2YZx97vM3MW/J5uYBiDbkzzmuH1krj7HYZk7txCkrt3pgxvCZLiAZTtYkx92ZZuZu7NLFsIB1+NzH3N8GbPfM59SW0wKJ7SDAaOfBfVs7X/5MwXoOvd2ZzrLdHIwPeb7wWs4KoEAWTXGlN229W7bCjubXLyL3sQ4vwdBfY8cvjVLntPOHtgdBRIA0xZaDZuiJIJU3qXNxFs7DfFo1DSrMHDZ3c+2c/y7fOSVcVyOzyjK3O1URh9APjlzwVmKcP3EoVIeTpmkSFocBNrnuD9ZouXWHjFUXz+wK22i8W9bSkGDppOOLOGRZZVzT7lyml+q6pJ85f2uBrcifHyEiEzKRXXimLs74TINVE8VWIVOuuxR6CcMsOvAgF8aAcHrBUS5wVBfQBtG/J+sHK0D2Y88tHD4mf2Wsi46Cpnha4B89eZRAla3rT6JmjbUv4B1qu9ASqqkRilGZEQ3NWsxupDLd4RYgog9HiPnFIs1ZWYmEDHGa5RA6WxXmf6Y5nLa7eXPZZMlTUFshxN3bMt7jqryUq0a1uKzh2vKiNP5/ICll9jBOhknmnGsq79DtwS/MuTB22EebOTqMDm7a5DSpaeMSanltuAGqCeeu3aKURM2t18Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(261021121427099003)(56012099006)(10067099003)(11063799006)(261026130827099003)(261028144727099003)(261022105027099003)(261022115727099003)(261022113327099003)(261026140227099003)(261021130227099003)(261021123027099003)(261102123227099003)(261026121527099003)(261022075727099003)(261021135927099003)(261009223027099003)(6133799003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nZ7vWoR5lS7oNAGz+Lmh/8f50Ji38qmp+3yNAWB5i5GSmVMe1WC4KC2kHIvI?=
 =?us-ascii?Q?SyvP9QA8fUvjHmQXpKS+C3GR4F0tzq8jQeznGXsu7DYOLYTH9WxEPg1KfEIr?=
 =?us-ascii?Q?1q7Ik9hLnzAoFHNXhUvQ/w70luqWJePTzlrxZRzg67uqhc/v0TYAht+bHgkx?=
 =?us-ascii?Q?ewYxY6jqxhyj6RU8BEgVo3IlqJOhe1xn5VT7vHMQqaNeuDMOScll39BJ0sXP?=
 =?us-ascii?Q?9Eiz+KU4l01HdMH4HPwva4wxtTQrHUHQgs/6S41iiu9ZHtaEjo3afHy9c536?=
 =?us-ascii?Q?kUKQ79Po3qWl5ZmP15m9wLQLas5eacC56yhnM/Xlwbh9jo73dIEVCKbaoGpY?=
 =?us-ascii?Q?vv2Viocg6/71XaLUJiIg3/pFIKu1dAJ8y6sfoCl7hONTBEGKhCwynLEHOTrB?=
 =?us-ascii?Q?ZNB/OSx5mukcj3kT83BOkEbnT6qJvhyHcpubCGIWO/81kDcnTzbMrzbGFzI/?=
 =?us-ascii?Q?/qndt6Pln/VZbU0sgy+UP7CfyThh1ZlbfrWbrlt0d81zWwUy+HshvhCpld6W?=
 =?us-ascii?Q?dt5tbkC28Iu0TVeaKK+p1WhyNDSDEW13ty7hnN26FfHXAOqnWeZe3HDsi/lc?=
 =?us-ascii?Q?ruxBGwW25196gbeJk0JB97ZT7Or8a+0gXYu4hqLVkYLhUpGzGeJErgXABuG3?=
 =?us-ascii?Q?I5jRxEa88lr8e1EmDRZVYerdIJzwNj+u0fSAoe0Mlh9XwesCPNqxDbY9KI7+?=
 =?us-ascii?Q?poTpZ48qt0WYh7SC7CDyVFLzQSWj8PeiKb77nVILU4zt8XzZNLXgdSJjnFdf?=
 =?us-ascii?Q?Y6vSg+Ct6eHEXp8y/YTSp03S26dSSJ0lka2TvpHdgPjIohyU1vPGbqtj8HT0?=
 =?us-ascii?Q?UAJ+ll9kR2YEvZi87kpXcCH58A7GHowNIsv5SrsovOoPOzVV3qq5SEASMzgw?=
 =?us-ascii?Q?6z3ZzT4yfDfvoyRgWoDq9kB/81FXv2KEANEQQcWuC8apvhjcbOJgBNvgcZlU?=
 =?us-ascii?Q?Oiln3ELKi25A5APXs6eumW8ORGCC4Pb4XaSTl+FuOgg96OUPhtNzshX6cL99?=
 =?us-ascii?Q?aai4mMo01s8qVpfA6UDi1tEOeO+ArtMkBHbnImlolmJ2nKPVFVGYyH3/6pbw?=
 =?us-ascii?Q?IDgzY2QhnFUouM0IaKYpHlZgRbrDVLrARZLr6QnCpyB/DJbkl5d3Pz4SOngd?=
 =?us-ascii?Q?njLxDUMOdGU9/MNbbTD+Y75oaVxEFee6U3IgG2TMKoEybJSiKYzqAhu2AYtY?=
 =?us-ascii?Q?wqizZX2nt9IM+jU6Za7sA8iQlvjYO8qVGzv9HmphsuCGRj2Me7UUG5SoDIQK?=
 =?us-ascii?Q?TCzUFQi9IA2KCrDDJLld7uuTP8yE4qq2W9nEkyCk1yqLZcyWZJlTGWtML3RW?=
 =?us-ascii?Q?5V2BRXWJzg6VhNUrwfTwXwdmqsHSa/5JyNOrqsdnzM3n1bv+hMd3YNMNK3OE?=
 =?us-ascii?Q?tVvmYKKWY0T0ICmQMH+WsPfJLOoQCZZDErVlfWdNizfpR5LrAZAu2jlcGp8I?=
 =?us-ascii?Q?dd5AgpTAyPAwnEVgAbQNLzArrn5jbx8I/1GF6P/pOiG38vt8hQuyfyZwAC/1?=
 =?us-ascii?Q?hlR9nuww2l2NC2KKo4y1RBVpJrwVycUnRaz1sQ7wdW2j99x0RxQ1QkqWTYM+?=
 =?us-ascii?Q?NQ2pbcOXWnFucNdZd2NyV3OR8dEfxwtXpgRZOCOjk0w9nkmi9oYCsdQoyBoh?=
 =?us-ascii?Q?RZQles9JEmqPbrIYLibx7sdQ7Qw+nlTv+eX/RFBuhzzwESA/NDR3eDK36jjC?=
 =?us-ascii?Q?rFLk3zd7AruRudf98Fl/x5KCuvRNopGdJKN6jCh/yFCr8EexkkseAnVs6AYX?=
 =?us-ascii?Q?wR5Wy0rWm3GSsW32i1zMfjrO4Hh2J5p7rfGzbUlh2kJ5XwNADanv?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa27465-42ea-4692-716d-08df4bd5c7b6
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:06.3364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3iZfYfSzwi76LkEEGANV4rAjd+QQKdc8lp6DP5PUMB1Yhp6+AqcyHWhVn0tWFWfzSr19JZRb3nT9VdLUUprGWHQ8k7Zce3cb8IO7FVocgN8SuS4Kxorbogo0ugP6ZjZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:56:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25191
Content-Type: text/plain; charset="utf-8"

Hi,

This series backports cyclic DMA, runtime PM and suspend to RAM
along with preparatory and cleanup patches into linux-6.12.y-cip.

This is the equivalent work done for linux-5.10.y-cip kernel [1].

[1] https://lore.kernel.org/cip-dev/20261126152204.1297798-1-claudiu.beznea=
@tuxon.dev/T/#t

Thanks,
Tommaso

Biju Das (1):
  dmaengine: sh: rz-dmac: Add device_tx_status() callback

Claudiu Beznea (19):
  dmaengine: sh: rz-dmac: Drop read of CHCTRL register
  dmaengine: sh: rz-dmac: Drop goto instruction and label
  dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
  dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
  dmaengine: sh: rz-dmac: Fix incorrect NULL check for
    list_first_entry()
  dmaengine: sh: rz-dmac: Use list_first_entry_or_null()
  dmaengine: sh: rz-dmac: Use rz_dmac_disable_hw()
  dmaengine: sh: rz-dmac: Add helper to compute the lmdesc address
  dmaengine: sh: rz-dmac: Save the start LM descriptor
  dmaengine: sh: rz-dmac: Add helper to check if the channel is enabled
  dmaengine: sh: rz-dmac: Add helper to check if the channel is paused
  dmaengine: sh: rz-dmac: Use virt-dma APIs for channel descriptor
    processing
  dmaengine: sh: rz-dmac: Refactor pause/resume code
  dmaengine: sh: rz-dmac: Drop the update of channel->chctrl with
    CHCTRL_SETEN
  dmaengine: sh: rz-dmac: Add cyclic DMA support
  dmaengine: sh: rz-dmac: Adjust rz_dmac_chan_get_residue() to return
    error codes
  dmaengine: sh: rz-dmac: Add runtime PM support
  dmaengine: sh: rz-dmac: Add suspend to RAM support
  dmaengine: sh: rz-dmac: Set the Link End (LE) bit on the last
    descriptor

Geert Uytterhoeven (1):
  dmaengine: sh: rz-dmac: Make channel irq local

John Madieu (1):
  dmaengine: sh: rz-dmac: Use rz_lmdesc_setup() to invalidate
    descriptors

Tommaso Merciai (1):
  dmaengine: sh: rz-dmac: Fix off-by-one in residue lmdesc lookup

 drivers/dma/sh/rz-dmac.c | 818 ++++++++++++++++++++++++++++++++-------
 1 file changed, 685 insertions(+), 133 deletions(-)

--=20
2.54.0

