Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED08BC8303C
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 08:49:46 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.2])
 by mx.groups.io with SMTP id smtpd.web10.55341.1751878176937091170
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 01:49:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=PZzA9lhn;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.2, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BraviB1ep8KnmdMHKD398OdwZOOzb1Y49QUWQMv9a1nTTj9ciXUHTHewZtwi9eKJBbxGDZzh8ngvGZFom1Y075MiHBRUABrgm6ekFktE+VZmMT4mqDv78JKMfGgPMWfGtKAXWoVrkoQH80B+Q3w1MGb58wK+qWUDr9BO1VITisJ1F5CJUE9d3yYjyxq9jdbgeqXOoPJwppUAaR3HR3Dg0IVn8jBoV4YbDn3a6peYnFMx3E1DO7htNF6txiydxudzhcokGpWvWmDMeYibMH4zsoLIE2hwOqxWUx1gmLXjNYO62yirNTurj/gzICVohaCFgC+WEuG/4aIWb7l8ZA4IZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdAv/NnGQ2yoja/ksBbGS4XzmxKTdCDwryzuK3GP0B0=;
 b=ZOYK+L69itdC/BuvreCGN0y9nSfqjjH4PGpOGXPpE5PnNjXUz1vnLBFPpCctMpMJvfksD19ESOQhjlri6CgITCtFyC9HDRmNOAJhGRP/n29n71/VGegHWRhVPRb1mARfzWCT1bp3T3ROYijtiqcJhM24fnlPjouH8hDvuPMkYf8QQBzgOTjCb9wS+7hqfXWr7qQGwbCWpXxOSF3ZpVLTWUyNrN/PtVFM0P52dvfMKNlzaoYlhqBmMBrCTUVw9K7YnUNlU3bJJFsvTYHsoJvH8NryfkP2NybEunoAxrZxOgeUCu5wURPbh/N3Vgl50/h7kS9ICioqpaXZNN6lrRWsLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdAv/NnGQ2yoja/ksBbGS4XzmxKTdCDwryzuK3GP0B0=;
 b=PZzA9lhnj2E7pwI4TKYPpHfBwYlSbUIIl+BJLJZ/91+x0jREkqQi+vH58N79N/2rcV9m485mrNAdGo2eL6ATRZJkW8aeIZnKNngzb2edjMwWeFZHuGGSgf5BWfydVgTBsyLASbdCGsxev18SLGr6j+0Kr7qwsPihwqEJ30IwRT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB15438.jpnprd01.prod.outlook.com (2603:1096:604:3b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 08:49:30 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%3]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 08:49:30 +0000
Date: Mon, 7 Jul 2025 10:49:15 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/18] Add Support for RZ/G3E ICU
Message-ID: <aGuKC8cWBN-B2SIa@tom-desktop>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
 <aGgZqPAT9QADIQZr@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGgZqPAT9QADIQZr@duo.ucw.cz>
X-ClientProxiedBy: FR4P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::8) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB15438:EE_
X-MS-Office365-Filtering-Correlation-Id: 14aba6ad-9baa-443f-0ce7-08ddbd332fc9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jj9Fsx3seztNkl9KqpPIthhRBuBx0C9wNAZcq2VPBErVmy+wOty5WLbIWcWW?=
 =?us-ascii?Q?Qj+665coQvAXNPjHryufluZGDWChE8Cjx8ZVTBCTgigQgGBAu8bsO01Td+wP?=
 =?us-ascii?Q?2H4sKzxDxnxpbWkAPAQTSi794NTegIglXwQIGQvsT0G+P0c0gfVub23PUSJh?=
 =?us-ascii?Q?YttBnIH3ijv19txIUWUgadMhfAIoUH5zNCMZpY7NSDqaeNWAwbGTrWjtjocQ?=
 =?us-ascii?Q?lppAHA0q/A23e7TG2svq9wr6maM9WvWBP/v6KUwq6Wn2LPjA5tbLuFGtw8tV?=
 =?us-ascii?Q?ll1B/4EN5Vl1Q4DLz15KCDcVhZki2UGC5/f23tzheefVnB86O0qP/xBiiTrI?=
 =?us-ascii?Q?CG9Gw0fEsky3hEusHXiw0l4WfoCCdyuACYxafWWUCI8j3xYFjPkq/5nHUMSO?=
 =?us-ascii?Q?AXI3XNZCLgWv4p9UNM2rgYwZugIs2mfOID/HvQRyYAf3qIR2EJeUHtsLgChU?=
 =?us-ascii?Q?+AVe9VR4YuNKJtRivbwdkTkthParOzjjZaydwc8xXVpMc+9i1wrD9ppKJ3ms?=
 =?us-ascii?Q?yTFIGjcb8yuZvMZ/keu3aKgpFVfOx2ZCeOooMeA9X+BuLxqBbgp8eciqEjXq?=
 =?us-ascii?Q?8lAZo/Uda/TvO525eUNeP1pc0dU3pDP66tG2FLr0Wl7EyAUiZEhQJVtWUYe4?=
 =?us-ascii?Q?RIHfXKTP201Miv0HjyQ9xm8rCtMbUZ6aQqcBwKaZnydt35yek3rHQ917oClG?=
 =?us-ascii?Q?CdUDWYqVojeb0RhuU2fx5IBF5jvZINUDMzbLgOTcowg6blKtN1YOI+eiExvn?=
 =?us-ascii?Q?pdYG6d1v0V1cEIsjz9qEWbVvVOuUyWd7azLGHsepGxrjv1Ys3Uhy+mVmgRGn?=
 =?us-ascii?Q?txtKOs3KdHYSuldX+7SGdHEGmugf+PgrhkficlPNdRh8KrcMydW54AuWHRlf?=
 =?us-ascii?Q?cP/vC8y8xjBhDVmURqoFOotlIh4zgnK5vbfFhmDsCYojhPhkdBTs0TGPfzZe?=
 =?us-ascii?Q?ZgIXywRfzpTTRvbkANxuTo3lZIklsA5EyScqqF2hnvwImUu949ohemWZfHI3?=
 =?us-ascii?Q?GX5uKgNUWNlMAXodudAMVBWaQdsg6qSjDseeJYGy1HPPwx1EJmN0gD5Hv7uH?=
 =?us-ascii?Q?Y+ffBrNEeLT+pcLhtpXGs58DKpuV0gwRNIFW1Xdb+zUB5AnngEwYIWHhgx4s?=
 =?us-ascii?Q?28e23i1l7rbLTspe8Y7gfOOgsAwAU4or/vdoRVdtVPe8nvjDNjbCGxfTA5DV?=
 =?us-ascii?Q?qNpLHYZ5vkByyR0D50DEb3cErmwgMsgBh3nMUFd3z4ATRD9vi2nCjwQ2j/Pa?=
 =?us-ascii?Q?szkY88kz4qOy5+exC2L11Lcihwz9Kp6jU9Rl2lAtE9gvgwRPdaSEMjZIy+mL?=
 =?us-ascii?Q?1t0ri/lp+dhHqlWzABayEoRs/lzoDXzs7l6Pm+a5nsornfhSJXQaKlaS9CS1?=
 =?us-ascii?Q?mHb0m8Ppt171jKdS0lyX9s1lYxZzumUd2Qz5kuwMNgTYdhTjOOSxv1pHwWjG?=
 =?us-ascii?Q?MHelQDcH+4jWp7UOKUTYq0AFlyV2Mm3ZhtQtEEJHJPYgoLkaIHNlUA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UQeAXLXjWX8HBwXH7FqQFsmxkE5PTfYHegU0+QzsxS+bMuTkHT04RGgS0gHH?=
 =?us-ascii?Q?12ODHOmmDvXxQbnjKGI0cfUMJkk3xmlZvpyQ4i5zwPiUCFmgHKQyeIkL0h22?=
 =?us-ascii?Q?SwIDvIGAX35VgnocnPrjjAkgYO1LCc6tgw9FDXTQBLZBqQ7eWOy3+ympC5Fb?=
 =?us-ascii?Q?DfqwxWWJ1Aq+IojJ4ZlxoYVWavQor3w5sH+kbxngwqqQObU2qFGEvDOpA1Dz?=
 =?us-ascii?Q?3H9ruI5yfigvYnBWxpGyCcNvRMGQDjtgMqM8yKf3tiJDCcUiSwM41u2T3Wvk?=
 =?us-ascii?Q?vPia4kSsoFGAmKC6Nlvh/BNrD8ff8/ae+FLCgXwOnm4ToNVnHotFGZwg3gUf?=
 =?us-ascii?Q?54kMzYowmur/+WDNn2go8lLN/9Ae2fZm+FTJOSPJBP1DZpUsGPPYfDD6Hz8A?=
 =?us-ascii?Q?gGHioxQe7KF1bj9vxQTFjw5PYOC6CzOjEgQ2kyJLyD/WXAvmwtA9G2lsIzMU?=
 =?us-ascii?Q?0tBo6ytC0rPNNz0OrK2a77qrzTsC1DauOX4erjHOBNrgnDnGKLaGB3xZCWB3?=
 =?us-ascii?Q?1ejIiTBUHQgD31mluGJttoC9lMh2X2diUqW2EepPG0o2psyW/zkEtayuq+YW?=
 =?us-ascii?Q?uMTRixiPS8WxOmEXV93nVIGtTiCXjbX0ZNAYjVLstwqDnjdwVfG971UzTniV?=
 =?us-ascii?Q?Mq16cG7JiIpWrojNKT9g/9FK9IC2PMmLYxftamq36blaHmQi/LvAImdxYrdl?=
 =?us-ascii?Q?V73xMihm5TFU0z38e/pL35WEWnJKpxXZjY274/bCczBdWiDCw7tSEaBID5IC?=
 =?us-ascii?Q?e9mgPMzdC9QUgAnI94lCmvq8MrXx0XuZlpkepOVr+e28UH8VJxky4pFbbT6F?=
 =?us-ascii?Q?L9AdVglvzLuF16a/fKipgf4c49foBJCx7vHT8BVXE6NcgqCK1T5rDMtMYT9/?=
 =?us-ascii?Q?SQ6yN02NIiJ0TfgB3+FCLY/d8NVVmR03FQe6RxEJtNQWquUT3kbUwxs6bHjT?=
 =?us-ascii?Q?Q7J4vWZJTOGJs12v8ptlw7elkzcqtKrOIs4xFJdMIQvFZcqT3oqirRhePkdP?=
 =?us-ascii?Q?K1iAN83mrlZpplm4vlM+bVcrb0aTKHFjfKEIU7yJJXqgBczT6+ztcYJ52pkB?=
 =?us-ascii?Q?PUcExq6RkfAFmG9BlgZFsxNKTaSSQzMg4LiWyDuGZKLEyOUtSU3YzaJhlKx3?=
 =?us-ascii?Q?DPvhpEtDUpf+ASy9wGamQ3J29PaJNvZZud1zNczDjK1vne690Pa3jQJa3YXA?=
 =?us-ascii?Q?BHuMUUNevl+Gj03raEdyrWdbk4nrcBQGfM91GRCobVcgkMharKUa4D1ujvuo?=
 =?us-ascii?Q?uS/6c+Zjd2gVETJRq+SvT1cRA33RiJ1OnjvAmfvbsjvUfmgPop45RsAb/UD7?=
 =?us-ascii?Q?lM8+LmUX7X0Gs2IEY8H5bPApxNctC4hQ7mAXuGJNr0Fje5LjU8yQzMCBCc+z?=
 =?us-ascii?Q?55BTE2+EbL1vI1HEcmHyO90sy4bHR9MEAO1GkJpFmFW5dySffPHJ7XpndQBm?=
 =?us-ascii?Q?Ca7vtzo0KJ7Btt933XONom6z+G6uJgWXjavsOKpFvVfT4S7RbLr/5mqsJhDw?=
 =?us-ascii?Q?u9JNfcj7eQOQAQreCkT4iFArFjvBDci9IRCZjxnAgVAm1xmWtAV3jAcP5dxT?=
 =?us-ascii?Q?Y9ZePI63JApg2lU8gvV1/DrRSzeCsfeClTtWjyFzOQBMoMbN+64KhE2+gTXe?=
 =?us-ascii?Q?wBEnt8+rahJlh2zQ9rri/Y8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14aba6ad-9baa-443f-0ce7-08ddbd332fc9
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 08:49:30.2569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fxn1CAJqajwbRiOg/O0VP8Fmo8h1KxYZTnMM7gVKe0cgBVRQ81SZUekc9MNUnWhH5mSTzN0JzpqzYd7vm57g7Xoknzmjs8WQYf2ewx7mQh0+rAslIjnJs8cmq1zfVldw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15438
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Jul 2025 08:49:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19368

Hi Pavel,
Thanks for your work!

On Fri, Jul 04, 2025 at 08:12:56PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This series adds support for the RZ/G3E ICU driver into linux 6.12.y-cip.
> > 
> > The ICU block on the RZ/G3E SoC is almost identical to the one found on
> > the RZ/V2H SoC, with the following differences:
> >  - The TINT register base offset is 0x800 instead of zero.
> >  - The number of supported GPIO interrupts for TINT selection is 141
> >    instead of 86.
> >  - The pin index and TINT selection index are not in the 1:1 map
> >  - The number of TSSR registers is 16 instead of 8
> >  - Each TSSR register can program 2 TINTs instead of 4 TINTs
> > 
> > This series applies on top of [1]
> > 
> > [1] https://patchwork.kernel.org/project/cip-dev/list/?series=978150&state=%2A&archive=both
> 
> Series looks ok to me.
> 
> I'll have some minor comments but nothing that should prevent
> merge... so I can merge this if it passes testing and there are no
> other comments.
> 
> One thing: "Signed-off-by:" section should not have empty lines in
> that. I guess we can fix that up doing merge.

Sorry for that and thanks for taking care of this.
Tbh I'm just using "git commit -s" to apply upstream patches.
Any suggestion? Thanks in advance.

Maybe I have somenthing wrong in my configuration :'(

Thanks again,
Tommaso

> 
> Best regards,
> 								Pavel
> -- 
> In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
> Office: Kirchenstr.5, D-82194 Groebenzell, Germany



