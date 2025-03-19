Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1C7C35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:14:10 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.0])
 by mx.groups.io with SMTP id smtpd.web11.4326.1742379239737329424
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:14:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=FmKS8l47;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.0, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdMTFhhQWChJCCN6A8kzw6W8q/q+NfoFVKamvaKif6/WFRywQZtQODS0T+BV20k2T0sW67HPode6vOn72g1nG69Quf7jgGwVpwBqSIympW9Efq1nSV24vmNe+8mqSpUmhH13FrbomC8IZcsUMjkcnSJcRH/4EeH5DvVbpMhmnFTmI30AMdFPhvYAyLrbXIEi77OabgdCIwO9vaJz2YzobpcEJFCNOQ+nI3j4j+koBvWxkyx4MUNVUIudMcdJEO5F9VtWgcnKy4SPqbQWYklwMeYGgeM5Cx1F41wLsbPw87iPNZ7BxdjU3vUEfA7pQYkyYVCRhGkmMBvCw3nuhNoEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lbg3wL7nALa6dIv7qKk/27n2Z10u0mXYrcoNot3/4hc=;
 b=Iz6L8Azj9+S9EOlRIH26Lo93Y50sUyhH7vVsU/OjAC+/G85Y9/guuYgVUGU8db7p03QcKQJnNZjN5wLLgCBcQI5WnRrAFcqBPrS+3oJ91Il5UV6oK+8RjU0+xCN59XG7ua4RHAjmNMMe/Gi96+KGqfvLYHB1HaCUfttw7sXcRwzkLO3kV8j7S8ZUpHtulonGe+Zib5Xe8X9Wzcm6t5l1h3DxX+2qqsewzQUp0ha9QGk1wOKE9SZl/hBlVmKpPABgd18JS+WzQBsrxRd6108n2SBfefVZStq+pZbPqD6f9d4SB/pdTLuEDa49rLPoLLM2cnuEgEcd90u3wOZCPDWrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lbg3wL7nALa6dIv7qKk/27n2Z10u0mXYrcoNot3/4hc=;
 b=FmKS8l47gihSQXN0hjXoP8prPRoYBiMagQApVSrHKAoKQoo3+WZREif4Gw1w4uExtejJdbIyj2GZk/kuqlKGZIhZvXoeZjGTa04k+HLorZVn22VkYLR2e/Gwwfu0ZILTxy2vxTX4aecXFjgNRj5qVzOosH+Bn2ZenaU4iYHI0HQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS0PR01MB5986.jpnprd01.prod.outlook.com (2603:1096:604:cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:13:52 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 10:13:52 +0000
Date: Wed, 19 Mar 2025 11:13:40 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/12] serial: sh-sci: Add support for RZ/G3E
 serial driver
Message-ID: <Z9qY1CmxX2iSDirr@tom-desktop>
References: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::7) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS0PR01MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: 1529c2d8-3266-4f10-05fb-08dd66cebfd3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9pdzQyTg/XIhn+g96xhH0K1jbwfAy1uS4Ein+j9ieJOaLpE90hLqOYvUQsan?=
 =?us-ascii?Q?7s+AdcI3ZyyU7pQgbgjejthoBI1XqXwOvQDtCBA7d0dBAFpgo/LI50da6RIu?=
 =?us-ascii?Q?8tbGXc/xmXmD25/mVSYDo8pYO+HrENCZ+0scpS79UaisEzzdSkyQzSI7Pa7X?=
 =?us-ascii?Q?B1zZSUmIh91/VkhmWkiS7bPWmBCptAjhgjKl/nggH8o1K+P2aKXh4ql1fFaI?=
 =?us-ascii?Q?VcbmhRhRlXjzfAxG8zmwFce0CAR9sEpd5E13h/QlLn3JP01XJ3OtUcnricgb?=
 =?us-ascii?Q?2l7h28185tikjSJIJU3tJXVjvY80OVo4fuNV2YgHvR01eW+bKVqYsDmF4cfg?=
 =?us-ascii?Q?Pg8Ozr/H3dkxNB2mnpSEnFqFlRwnfsHEZ/T4a5QzQ+qm6FoNakrt3csx5VjE?=
 =?us-ascii?Q?dooc9josLaIFaRofgVhuZ2WlmePudSn5mxl4ACB1oi4R7QQcAkFIi4jZAVBv?=
 =?us-ascii?Q?rcR6OdqbRupDf8LdCVoxWLxxWk9IKhyCfWDjdiRdTnw4mv9cUjfh3xVqAl05?=
 =?us-ascii?Q?d18LqoOX0QS0kiCAsgMaIv7O0njQ4/kxCv5395z3n4SATxaoK0clkJJ1gSi+?=
 =?us-ascii?Q?KABtkwLtxG1QP2WaPy71oIYHLrB5FoxuBQPyb09E2p6SURAjKcDU9dZaRVqc?=
 =?us-ascii?Q?ADYg2+zU1TwIjbWfbZIC8up9h192ihJ970pPusnnqsOftrZWSM/0boQAGS8e?=
 =?us-ascii?Q?zd6J32tLBMNb8mci4qBRe5sGzm8EDnW3Gofqix4vwL3GreP6LS3aQIbVupbE?=
 =?us-ascii?Q?STcnajOwCs579Z0GEu4yadKMdfQ9Am4/FjLOCTPADvUrcxBS9wm3N0O3vFlp?=
 =?us-ascii?Q?jyiX2q2k9aCPQh/v84LVME60dgi9ImVB4UC2DgTEmc69VNi7UQWfzvbBuxSw?=
 =?us-ascii?Q?d6orTS9y/svLKmcrJ1gy9K3bVuDrM8HUmnkxgjL5uUdKkg2x75eAR2Ofi74F?=
 =?us-ascii?Q?HjOLP8Grb+YX2Svc7uWVgZkwEfZ+eU3Ck8Z2mTmABWbjJ6h70kSNM9UNfw9k?=
 =?us-ascii?Q?XPgqKDmqen/5+HIE5QiCwGL7G9dakOqkuITKcuEAI/fa101i7EhZBq7wGmX6?=
 =?us-ascii?Q?kb+N/9gvPrPZawQlQVwXTw+gQ5+icVvI5NeDBi5zZnbAcEMkP941A5+8dUb1?=
 =?us-ascii?Q?OUjFBpiVMwmz7tA8L4I+nvrOP8dQ7Qply4CRffVMDWxbDfuCSoJPNvYKf6eV?=
 =?us-ascii?Q?z9i5S0m/AI/2QpInBecMDbjMldYUochmMxES7oCuXGyAgNHAJCpX+DX3cmok?=
 =?us-ascii?Q?hL4nDcQawbcM7RPIn/lglI1wIhCnpBVYNpQF/IhX4hzrhx3dr+t8yDwXSkcS?=
 =?us-ascii?Q?aV7Ry7xidY0tDsK0TsQLC0zwvAH2+tWl/aFl9zr4iOHCBgTExLc6ha+2u+lk?=
 =?us-ascii?Q?e5XlrEJkBlC58O9dowTz2focw8eKIOunmnOMoQ8+BCQ5ufneTnbnWX0g+wFm?=
 =?us-ascii?Q?xa7S4BHcDHjZFZyJjzaAqcMQofUYb521?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CvFPJ+ovlk+8KkXc/V0MjutL+2miAQON8EGfRYFYfnFsE0hz2Iyh9Prmi6Uw?=
 =?us-ascii?Q?t38OdTQkkg5+YJWbahsCkJrS07Vug6TCHtaT/nzbmSbNLR31g0gV/KoIO1nA?=
 =?us-ascii?Q?kerMtlqNNpQAhP3SNxH5XPfYv79cu5dIfrhmSkLN4D9r8JZGOXH3JZBwROZs?=
 =?us-ascii?Q?/EBXS0IAo+L370ZY+z1OMEXtmX/F/3yaegJk6FFonRw2NxxGTI7YNfJ5T36l?=
 =?us-ascii?Q?dpvLDYCBLPcPH8pww0iojLzRbopTgWfH+TtR8nUnr+bL7mMSxYenCV0IUWJy?=
 =?us-ascii?Q?ohcPTcdUCxMNoARIJiKgfaPxmpmebENZ5DzSoo3nHRyRjKo/L8uPkhAk9Leb?=
 =?us-ascii?Q?2d1BZvSnC48cGP4QPe3/VTKJeqbobblVSDWxMH2cegd9RDDg/f60tztjgwaK?=
 =?us-ascii?Q?+F//HoTJKHO7WUfarri3cSWsP9xW8D6UYuhLfKyA4b++tUUGBUoDWcjFtEKR?=
 =?us-ascii?Q?Q1qApxICkah9bKMc4vzselx6SAbnGD9EbWECBntdgj6WR4RYCQEt0jnAP3cW?=
 =?us-ascii?Q?ZEI77LkBYMR18NXu2wnXzLbp/Pinii6mGdeAwBpa5RRf+BNHmFDkGt59hORk?=
 =?us-ascii?Q?Ee3nn/guaGC95KMBNsV93328zRG938ZN0OQTJj2XINW7aRiq4VlMuO0TfFod?=
 =?us-ascii?Q?2r1kawAqyvv71BShDsxMpyvEpRCIVUDuLYX1N/82Gc2bxDSEA2gDl3Jd5t5H?=
 =?us-ascii?Q?VNnfq53+Jh8yTvMuhsR/Yy1wehfF90wnuP/zDyrBw+q+z3KsVO0z3ynSXxWY?=
 =?us-ascii?Q?kFFNEiPG+cT/vN601Ip8Vbo958lpNrJdHtfJdKxi83z/cZ4YB82FtjE88JHX?=
 =?us-ascii?Q?SL4nf/gJBIP1mSqMGX+UV1XcUVlfE7gpo4w62IvkiPV9PYqnIzqHF1qmAMBo?=
 =?us-ascii?Q?6/EoHytfcuHhSX+9jF1nFZGrbxmq95VQl/CgqEqYyuwmmSkuQ1jTszDCnf4R?=
 =?us-ascii?Q?j/g47RgPrWI91z7mK3PimrlqVDv1JZt40s0aRfT4bxGvejVa1YB92P0d8/e0?=
 =?us-ascii?Q?KFe9TzJBUu/vd3lesxp8g75RYxw3Lpp6MsLnsPhWItC449IjGkwx4USeXcx1?=
 =?us-ascii?Q?vGphRd4xW5HWZnyHXX6xv+gVQW9WwAm4v3GyriK1expVQfMDbmW2Q5JvP7Jb?=
 =?us-ascii?Q?sbOcuA5EsQFu+qJz8LAn+uKjtTJqpJE6f8SkdDBkvS4wCQF4iRQt1Kg9l7XA?=
 =?us-ascii?Q?+qvi6d1w4oamfi76idJq9CaolhWdMleySLBw6IilsHgiEHXdo3no6W3dWecG?=
 =?us-ascii?Q?HUjquR9oBU967bItLtKzyJeb9z/+iqWJXSy4hyQDPurCzvCjJGZIpQJdAFb0?=
 =?us-ascii?Q?CrslecTplSfzQuiRFlmQDkQSe/s7r6YqyMniF02i+vjResFw4AH+Fr9iVmgW?=
 =?us-ascii?Q?nSbWZGO3KopOh0jLV/vS3Z4yzz5WL5BLYE1b3+0jA2SJaDEu5F8xqn/4GxaH?=
 =?us-ascii?Q?mHM6n/f67R/7ZqBkE1hyTPxltFMsCZE8/PYuNgb8anKd/R9ddKCHMxKN7Vst?=
 =?us-ascii?Q?UA6kKAIfO9Khhm6PnZyJ50fVwJpeKoVCEx2Os3fMRwFAq9q5ZNg217WwvaQt?=
 =?us-ascii?Q?RwsEuv+JXom1buioTxyRiUGXe1M9NrrDZvOtm9cVDG08wvxldbmJTEuQt1Ob?=
 =?us-ascii?Q?LMiLbnvlWNvUQ6Xao3uWEuA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1529c2d8-3266-4f10-05fb-08dd66cebfd3
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:13:52.7820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqF71sKg35ySM+svAoMpVMmmvl/96ztdbRZUydDUu/qws/Pp+pT3JCbUHU462QWDJTY1QqbRldU2cFsi1kW1jIkwiwcbArhmrHbTGCX3Q3HpWw/zdICde1ifFMbITkmf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5986
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:14:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18260

On Wed, Mar 19, 2025 at 10:47:42AM +0100, Tommaso Merciai wrote:
> Dear All,
> 
> This series add support for RZ/G3E SCIF interface to linux-6.1.y-cip kernel.
> SCIF interface in Renesas RZ/G3E is similar to the one available in RZ/G2L.
> This series add also some fixes found during SoC bring up stage.
> 
> All patches are cherry-picked from mainline kernel.
> 
> base commit: 8da62141b20b (tag: v6.1.129-cip38, linux-cip/linux-6.1.y-cip)
> 
> Thanks & Regards,
> Tommaso
> 
> Biju Das (1):
>   dt-bindings: serial: renesas: Document RZ/G3E (r9a09g047) scif
> 
> Claudiu Beznea (4):
>   serial: sh-sci: Check if TX data was written to device in .tx_empty()
>   serial: sh-sci: Move runtime PM enable to sci_probe_single()
>   serial: sh-sci: Clean sci_ports[0] after at earlycon exit
>   serial: sh-sci: Increment the runtime usage counter for the earlycon
>     device
> 
> Geert Uytterhoeven (1):
>   serial: sh-sci: Use plain struct copy in early_console_setup()
> 
> Lad Prabhakar (5):
>   dt-bindings: serial: renesas,scif: Move ref for serial.yaml at the end
>   dt-bindings: serial: renesas,scif: Validate 'interrupts' and
>     'interrupt-names'
>   dt-bindings: serial: renesas,scif: Make 'interrupt-names' property as
>     required
>   dt-bindings: serial: Add documentation for Renesas RZ/V2H(P)
>     (R9A09G057) SCIF support
>   serial: sh-sci: Add support for RZ/V2H(P) SoC
> 
> Wolfram Sang (1):
>   serial: sh-sci: describe locking requirements for invalidating RXDMA
> 
>  .../bindings/serial/renesas,scif.yaml         | 141 +++++++++++----
>  drivers/tty/serial/sh-sci.c                   | 160 +++++++++++++++---
>  include/linux/serial_sci.h                    |   1 +
>  3 files changed, 242 insertions(+), 60 deletions(-)
> 
> -- 
> 2.43.0
>

Hi,

Please ignore this, missing my SOB.
Will send v2 with my SOB.

Thanks & Regards,
Tommaso

