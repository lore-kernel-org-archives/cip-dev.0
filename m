Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.297.1795708098926381266
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:48:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=U2VN40kM;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.24, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpMc0HA4Aq7Gp5NEQN2EEr6I/sZpUiZRntcnrNg+RNhNjvz0RyhKrKbEy1oetLj7HPMrkqg0Sk+I4frGzOW/lxzVyMOXxezDf+ul1nSX4vtq1KCE97jJfVbNXQdhUo8bYI18yheHBgGwiLJ4eedp0tiRzeaIIR8I8MPLkgUiu4xPP4bCq6OA+2XCr4daT5gQmTAcY4JRqT+jhIVqwTcVcu/2YKKoPP7nkRxGy/tgwvScDaz0HHpoS6YxcKQ47ug4dJv7nLkGIB7Sk0R03IKGEC0zEyJxVlkektvpCQ+8nh1XAbR39jw7oX/MlBW9BJbkrXSC6k2kX4JRR/WJYHHt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ro22NeiE7qtsaKbKfoqcLTKyqqN1CKGltyvd0yPf7Q4=;
 b=HB4V9Oxd9zrperS7bD48vEEw6GU0Hn8vx94qDZq+heDa9teqovFJCigCm2oRJqSshwqMpF7SBWQtdvZTRAu0x8eqnMyH6YKcq1SzYWoB/mdkZxV8Z4/xlwW453XFln0yhIAwgGm74DdqjGRM6ypKld13Eq7AP5S9oXNrtLKqGDE8ENU4EGwNN580Tp5ccTC/8SJSzVMUBOPIIzBK1HXMFKhbdtAIx6PuXHfyqFGkY2NxCBswnsjddK8NQ+8WZuvQcFiGbSGHQRJH/PPOL8qDdunIHS5/rK8eXqiDb/E8tu4trfJ1zTXgeZ1zpByL27llt659idyybqZovefmsWNSrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro22NeiE7qtsaKbKfoqcLTKyqqN1CKGltyvd0yPf7Q4=;
 b=U2VN40kMtcRNFm9ElojNWmut5VgCyKHTnvfMh64/wvkdAoF6f+4P+Ut/dm3fnGhVA22w6GPKq1UgTICh5+RkYTq2veXkpuXOygkfg5rLw+D7ahLQVlDgLH/aRH8gMvlzghLeNJW1UFdFB3y92vzt9uydkQE0daJu6E65bkjJYAI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:12 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:12 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 00/27] Renesas: Backport DMA fixes and improvements
Date: Thu, 26 Nov 2026 16:47:20 +0100
Message-ID: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OSCPR01MB12784:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d9b96d-fc88-4761-805c-08df4bd4ad61
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|261102123227099003|10067099003|11063799006|56012099006|261026121527099003|261026130827099003|261026140227099003|261028144727099003|261022113327099003|261021130227099003|261021121427099003|261021123027099003|261021135927099003|261022105027099003|261022075727099003|261022115727099003|261009223027099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: iJVwDOkl4Y+S6dN6UeHiNoeOc5QwKNxZoYGTA4ji+FrU5+Y+mIAFkVYj5bnSJIFceF4ZUuf6mlRyZJMYGseaOLiTeRTCdylWO922T7iVyTSYAT64aDTdwsQsdVK39hhBi0rbYsFGuBz4rXwXhNQxf3Cdq6dYPBIDLdkYyORqSZihBb+tTm13LGv45mmbxmELncBVdgU5SLSD503LbXmrq3cZUcOYk8LPIcVRJR6r7N87LMmGec7F4vdmmaoBnMpWhxrtJi6fP8L4y0kF4mHAjuVtLhiyPTGs6FtEolvixBARIWC0wcKzDN+2vz3Vb53Oc1h/4PWujsZJgPmKfCRP/UK4HIWUPrzMEYzly7kVeeM+nk8NHJv7kof+r+pBwdMEN2OWR1YPxSisTTX7MwhngLfzZEGklJicFUCLUdXtDPhVgqwnvjryM41vEDLpZKGtp3ZLYlJd+0WCT2L9cccmKs2rzoBjD8c8UtBqZOS1Bbowy7z38u/2YZmsKJ1DQHD2bFoaOC2qxndtZhnx8OriYTcXVzh5FdG5OFsRSB6ktFyUT3Gfb5g0pKG+RWrsVSOgtfE90bY1dJx8WLTcSQAf8qo6XYbZdA7BdDs6eM/qdJ6vgTIO1eYY4tU+sbTl3vXB0JybwYRA+8u5sYqxE/Ck6vj/0jfoVSC0OqfxZw2KGyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026130827099003)(261026140227099003)(261028144727099003)(261022113327099003)(261021130227099003)(261021121427099003)(261021123027099003)(261021135927099003)(261022105027099003)(261022075727099003)(261022115727099003)(261009223027099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pc25Fq39QVztWT8E+IYVau+/5c3CVaxjRH7oCIY1WHxgac0GuZLOd76cid+6?=
 =?us-ascii?Q?ZdxQO87wFaE5syq4i6hkwFPQeqyoTBexx0gC5QNBvbJpf7C7GryQgS9+yvzf?=
 =?us-ascii?Q?D5pSTUeJ1Qnr1wqckk/JMgZ1mXvYXmmdVyGUh1TzincXjR2drmVRbUr5PVzO?=
 =?us-ascii?Q?HnKb+EbFVmMvrYh7jNxY6eIVO5XsrDYRO9BGGFqs/4P/CSgxbCG5rYOZSrlG?=
 =?us-ascii?Q?NLMpZk1sF2aCmz075eeJVdChPxquO6j5jyaFSWMrqS39PE7eHTPFdABiZQKX?=
 =?us-ascii?Q?HWdXaFFUX2lUniUCl69okKrvmw1VY/bd0kK/Z+c01l8XOnI2ajHB7qOaR3dC?=
 =?us-ascii?Q?Nu3RVrDxtcBUh+NEJ+g6AFvNbPwt+a0KRqbpa0qzOkN2+up+t5EuW8alZ9Yc?=
 =?us-ascii?Q?f1vTw3xfY/cbNB19EqyTgPq+wQ+bGhYhK2VvA6YAi9Ny6IfVzpnySVEIZEsb?=
 =?us-ascii?Q?+LQkmVQj1iAgSG4HgP/Kzr34o3PxT/VxehXh8CH2ZDP7V1tjVpS6rpBixRer?=
 =?us-ascii?Q?B/H2aifM09Qz3+0HleedHQK+KnOEEu/48BUUJDHFOQ9wXfGxPCAGnvjiUnsO?=
 =?us-ascii?Q?29hXX6UrylEbsQql6ZqPUIiDNd9yaVPY3aP5iqawyrkdVDroc8z8v8yts53D?=
 =?us-ascii?Q?rKIyHGzhgvF9tG/3u9tRO+1CwoIyvAq5/8TmLp5+NgSW3ZY1UeISGlz4xhP9?=
 =?us-ascii?Q?ya+gV1Gl85piWJPWERzjDINs6MbZbhXcZlw62bWRwYNWiHLF1oC1r5kW7QYY?=
 =?us-ascii?Q?g2Oy/2gkANXjXJzF7E0/igwxKTIbAwgrhPA0CsBzLwL2DvD8K/+ZGaghBHz3?=
 =?us-ascii?Q?g2noaLnchDotetYwxxZXQh7gC/3FFQhH6xx98klSXcZi2udp+alVMNBmMqqt?=
 =?us-ascii?Q?KXtVGyrfmIdQo3OpCCYEi38D2k+lzpncMlb80LA3GO6r3/HDrdPhstlV9Udy?=
 =?us-ascii?Q?k+rWYUWsPtwViFNL1V6GmPeDNtwaZN980mN1mrWy/7LX/k0qPbJxo95gQiXM?=
 =?us-ascii?Q?URvbynZRNZfZ/XDNwXXRhrzmULZ0MpVNRkSekRHK0CXmBgsZ6oPoj3/q60yM?=
 =?us-ascii?Q?oKxelmY5LRv4lDLUhub5fg7uxSly494hGaRc8awxQeoYtILpxGEnjaToDJXI?=
 =?us-ascii?Q?6Y5N0RU+V/HG/7mE/VaIZW1LgsKuyy2mEEBeo8Tqb5JSLHliiP4wXpTmF9PC?=
 =?us-ascii?Q?BSGqIOLsuyZpYODeAuORSOSWs66Y+TBpUvNGImykHSh3q0/xKyUUcqgoBTLc?=
 =?us-ascii?Q?+OahbTg8aZOQ3u/4kdgryRKWqfHGponXdCynnv5jQGwq6i/g5MyRJ+8UQJNM?=
 =?us-ascii?Q?LOji9g14BjpGOi1jCvHDZ4PvvwoVkxTILvMHgC+BPo3Qb8sHFY6r8ckae0xp?=
 =?us-ascii?Q?yF5F0XMN/wPgonc7bvBEvYw4CbqfvC3Iur89ww/E8LTqQMkmGK5rDPA36h9H?=
 =?us-ascii?Q?ZfPSRV8j3Bxosqlf01TpqrYwPkO61mbmefH9zEx3XKpRcJUKQZYgNfQbbDLv?=
 =?us-ascii?Q?kXsRdGBQ5XI7sHRFDQeCU8i5efwq1j9cfEgghpdHWHvNlTsr/9upb1kEuPIj?=
 =?us-ascii?Q?wC8gI3eR3LF4ZpYcMmeMaxdZmoejIbqEYUkSZKCBW3upJWYSoyACt25KJ7pT?=
 =?us-ascii?Q?nTqmAAITCCnzvS9Zud4rmahc1LA8pXyfeIaXjeiwlFqIyJP0UoY43jU8SBaI?=
 =?us-ascii?Q?SkDkddUHbI6L+Xa5Fgn6SkdnnGP1JpuxXgD+mI8pKJlkyGqOi1z0XcbeNvGp?=
 =?us-ascii?Q?8zBYRYz0JH1d1+m4eb/m3mQziDn/7e7JmivjsAITUKQl3K4cYWDy?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d9b96d-fc88-4761-805c-08df4bd4ad61
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:12.6886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NiIGyeR6IyJM2viBqGJIWj244uvU75VX+yvvkveZLJRrvCedSFi7r5/Xbk5TMqCKTl20AeOHyMuTXF1lJcR7etUiwV5guURlgqgQs/rdtGW0iXwagU6dhbsI72vD2hgT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:48:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25150

Hi,

This series backports cyclic DMA, runtime PM and suspend to RAM
along with preparatory and cleanup patches into linux-6.1.y-cip.

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

Cosmin Tanislav (2):
  dmaengine: sh: rz_dmac: make error interrupt optional
  dmaengine: sh: rz_dmac: make register_dma_req() chip-specific

Geert Uytterhoeven (1):
  dmaengine: sh: rz-dmac: Make channel irq local

John Madieu (1):
  dmaengine: sh: rz-dmac: Use rz_lmdesc_setup() to invalidate
    descriptors

Lad Prabhakar (1):
  dmaengine: sh: rz-dmac: Avoid format-overflow warning

Tommaso Merciai (1):
  dmaengine: sh: rz-dmac: Fix off-by-one in residue lmdesc lookup

Uwe Kleine-K=C3=B6nig (1):
  dmaengine: sh: rz-dmac: Convert to platform remove callback returning
    void

 drivers/dma/sh/rz-dmac.c | 906 +++++++++++++++++++++++++++++++--------
 1 file changed, 730 insertions(+), 176 deletions(-)

--=20
2.54.0

