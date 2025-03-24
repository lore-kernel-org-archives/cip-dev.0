Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79212C3600C
	for <webhook@archiver.kernel.org>; Mon, 24 Mar 2025 09:04:21 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.41])
 by mx.groups.io with SMTP id smtpd.web10.34985.1742807054962853805
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Mar 2025 02:04:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=aWH0AwXF;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.41, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6D5XNUJkYqf4fZBIOqdCDuONBCKoS/H141/teknaYuQr9msFw3cm772hMGVqKgCtUxzVHFUZmkoFjg4g5SGa4QqdN1Dl2DhbNXUpKwcfXPEIoPsA7XSGZDghLBqJml6X/Ev/KF7jkqzIs/WCCMdDlLjncVGLoBQgsNl6MHS7Lk+roBAwMUT1NrOYop7GNmV6zV3L61EmYRgoX+oHL6s2FA8q4ZJ7gb9vuN6lUChvO+fjhEgsrJVN5N0OVf0p5g0gTTTqCX5aWPHRi3KW3r2T82G4VrrMrMTjcGBe7dEJNnYogFPtRRk5JCsF3vzjDQ7aB9n5m/irPv8kERoNl3+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYP2saKdh8cgUPlREV2114YipOjqGJOss5DjbM8LRQo=;
 b=iu5y9iAgJnce4xr753SB+xnc8M77TGYhfknmXD1W/4BC8PD+I56/JVfhUkUJHUdKZgqe8q/O5LryDCE1mUZeRXg6nlZQg5HErFyXz/DDMK/Zy1HRUnSnlJ0EKmjEAVGxUB5Ze/ETIViagl3ceHIW19CwZhJj75aRxFwu2vd8WiMtanUzAqjiSp6b0qSOglFd45uN9BAahOSS5VC1t2DTt4MUhCEhbpBl0qHC2HOOQSTWU22/uja7WzfZKzZue9sZX0Nd+GAtmeKkOlyjzCbK/xcB3hZSZaf6rn46X7FPlOHgyy9T9n1mBzhTym/YdhX05b+8IMg7WQaZ84aTNNcQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYP2saKdh8cgUPlREV2114YipOjqGJOss5DjbM8LRQo=;
 b=aWH0AwXFzAcVug2t/x288AZqleIZPxEw2lFsauYpeLXtZsLtIneL7XViY2MoG7hKTYkwYPnJ5rhRXSPSh0O2y0eAOkt8aCYVq+Ao9/qfvjDZz8DqAS9UVbbIv45K/mBenLY7EyT27iOpRKv4pG0jirUtFqD5q90i2GE/Ew+m/Gc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9339.jpnprd01.prod.outlook.com (2603:1096:400:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:04:09 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:04:08 +0000
Date: Mon, 24 Mar 2025 10:03:51 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/21] Add support for Renesas RZ/G3E SoC and
 SMARC-EVK platform
Message-ID: <Z-Ef99PHhg9P9kWP@tom-desktop>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
 <Z93ILAaLP1+LR2gP@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z93ILAaLP1+LR2gP@duo.ucw.cz>
X-ClientProxiedBy: FR4P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYCPR01MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: 893f0823-9104-4dc0-0aec-08dd6ab2d625
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?w0xyR8v9TZ9Jy0JCGmaE3kn31JZ6J4U/0feK+p/1YOoQuEoUZcs/6MAD1riU?=
 =?us-ascii?Q?8wDiGRQRSBdP2QUIYEPeBxHLN8yR24lKlDO67vRNoWrguVKJj/GppGfysASo?=
 =?us-ascii?Q?KyMPWuXQdP1rM8RVhIbW6Watjb8+tw1Zepu8KKhy7MMhVZ9tWG19b9hnNBwW?=
 =?us-ascii?Q?OWZavc0lhhZTy10hxPqALMSmepIditd4LIkPCSRyIia3vzWyLauH/L4umB90?=
 =?us-ascii?Q?sbUwWVCiB0s7ePQyw1i4uXrMpuv4yPbmd8Df0cOr9PZgkKCZwU9rpTXJF/+Y?=
 =?us-ascii?Q?v2NPfS0rYTUW2BUyiEWlAVC5YVCjgKZU99NOADRz0gnyDFUQPZF+gd5zJyNy?=
 =?us-ascii?Q?dFnyl48cFZB/pzM7jdsUiUAYFGiVdkb0vU+ewyXuusSBK81A2QRf1+5zKymE?=
 =?us-ascii?Q?ECmWFfa1xmW/mFp4yz+CrrXvHnYNwuHK2ekFcKT1I7eAvgewEvA/lIXuvm/H?=
 =?us-ascii?Q?GBM/2cj5YGxTj8YTF41ARlhSdOKoUGmjQlIA4Nr+PSdj0idDIBrlQmR2DNg5?=
 =?us-ascii?Q?cljTcPdqLvnQVf5DOVpr7nNsU+PANqavYi5ERM5BtZtrwzOunCVG+Zvb2OlS?=
 =?us-ascii?Q?/HVGYCPImjUU+Ot0v4dQjSJ7RLVi5jrDTvnK3sMf/2SZaZZSvrAusQ95bS94?=
 =?us-ascii?Q?oMfmgwedlaXWJv616khNegzRzqCA7+NsCve6YkHFh534TE0UPojkd+r2sTr9?=
 =?us-ascii?Q?/VImZx4gOZFtBoVuju/ihjyd6BmiCWVuq/W+Z/pYth6xvMFpzNwCRfwqW9P3?=
 =?us-ascii?Q?akMC2XTdYzVSbR2h6WKiQImq+bRuB2DjPdwd9QEeimRQhxZrTpz6MP7lOkFK?=
 =?us-ascii?Q?Bei3oFkwXts6GPO/bl9lpV43TguiSEI4P4e4EdEXaNGLa4KPdJadazmnegiR?=
 =?us-ascii?Q?iYCjpZxAUcZQqzvZEX9aXCpWxANdJVeuWv6+kj2nOFV8POgVlSkFcKgX+q+R?=
 =?us-ascii?Q?O7NXLpcIPQHGcDVZ/mfh2Td5QrTijMt7Y+Zu6t9wfXPIMnjVUhcnhFsBkqbf?=
 =?us-ascii?Q?yS0zxrBpySuUhIAnbWUIYgFlt8HorkN1+ZN/122SCnhr6Bg9oBpsDKJyXHoL?=
 =?us-ascii?Q?uuBMyWjss7YuHoLN/0u9QSKbpli4b6xbnj5ulR2tD1pa0mKdQEbwrMG0m6xL?=
 =?us-ascii?Q?eDhmK6VjbHadsiTmzILPLXET8IVC6f5HG5SxPvdZ7Yb1Ox/jTGddr8bTHt96?=
 =?us-ascii?Q?ADO6YUzXV9PdsHTKG7VU6WnCFr5JOibo1xgo0DfBz7fjyAieYqeKtxxAb94O?=
 =?us-ascii?Q?PJonXFMUNE5vL8Oqso5DFwPH5rNtVgb6WdvdrqsUPxQhcEDYuaa5rVw2qbUw?=
 =?us-ascii?Q?5W0s7Dj8lPwQ8gegqe0yNd1Wq02IXrkudz/6WeQzbpJ67pd28urD+lW33CLN?=
 =?us-ascii?Q?UDocbJpFuo79AT6WjsNqCO2UunUCwdHbqwjayEzEYmJIrBSluvxWyjhPYDg4?=
 =?us-ascii?Q?aKms/hr52QbzJJLWJkrwj1RLc1Dwlpx5?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QEugf5kN/t2Ki6aq3Rkw+wkZDSxX535m/BtzaCeLQj9/FZgUCV2IkGJPvkqI?=
 =?us-ascii?Q?MDJFdLWqS3RVFduwDQrs/dFpsjomnIqHJxAj14xNlUzbBFIgn6PTeF0yhmsl?=
 =?us-ascii?Q?LQRJuZc30ZBcCih3LD5jSbLKHBwYwo5Ckq3fcEzmhPywal7XMGzF79ZNoxrH?=
 =?us-ascii?Q?BlFj08nstIS/LCDHa9+V3hRQkN9nONfzLfrTFH0+B+Qm0btWenF0AJ88SkVQ?=
 =?us-ascii?Q?yeB6lCSdtlNnXffz/WUXCjg1y3T7/NClOi36ADWOXXYYvtme1o+ms9eIiOCB?=
 =?us-ascii?Q?2EMEK04R/sgtzKOiQw7GLkFm8yMgUO06nwne9fUai45NBnUmYUw8ZESVKeUT?=
 =?us-ascii?Q?Q6M6qFWP7XRynPDLnI0/jkHd8nBmzWjGQ+oCwnQFzbwcMDei1CsxoGfgztsT?=
 =?us-ascii?Q?D6PHenrDI1Mz3XZKn/VPuLrSKWOpCKTZa4tdXdH8LPkk6IBFaXNHFuhst+wL?=
 =?us-ascii?Q?PIxCpgal9eT0e6akt/CofrqoonLKUURnGWApdj5oCEJDA8xRzOtKNMGLK3Qc?=
 =?us-ascii?Q?PBXSQZe9XN0YdPml2slx16J5Z+UaXUotNqvVuHE6ZKLCJ6PF+hnR/fomlO5P?=
 =?us-ascii?Q?OQM91g3q5NddSCJ0LvSD8FMaqvojBgt1K+0ilFGpMIexEjgRJ8ZZ287R6GOV?=
 =?us-ascii?Q?P+nlCFGvu/Z/PXQ8HYVmqkyidXp3uDQxuH758wA49HZ0eEV30bwDPeRJoM/1?=
 =?us-ascii?Q?dtkxsV3QAFGkmxLD42FLiCopYhzODXlYCiGWNju+0UKE53G2LER8gvbd7+lE?=
 =?us-ascii?Q?65sevUnUU1nbGAlkTSO9dk/c+Vmzkuxli8nytLniiol4oCYDnPrn5yRP0i79?=
 =?us-ascii?Q?7XNC+d3q9nt5HoLnMnvFLa8AdIlVhoVduiymkNzkW9HjdFCZhskvS1eGhzgT?=
 =?us-ascii?Q?rwOpo+u4PWD6tbF0GmgklC70cGSk/X3NYyThCuaygOLTQ6cMP0E+6qWhuyi0?=
 =?us-ascii?Q?oZW3bcFrIWuW8QXIX6bnOS6OZ1NHRLJRAvGkdvlo6mhlWRolgbqIfVrZjSPy?=
 =?us-ascii?Q?amgN1zHnA43jVQJzzqKepRuCVo/IUhkb3b43U94JfUsm4fxL1rDrE9SDMO7x?=
 =?us-ascii?Q?UdUY0n3Gb7h5lqBsLYS+2qzHl9xQUovcsmyrJCmfebr2foPdxCz9ueIsV8OW?=
 =?us-ascii?Q?89tHoDuiUFlAFscCazJs8nCImCZJBnj+qvz55qTmNIg/H12I46PfwkOCh3+s?=
 =?us-ascii?Q?Gre0StcGOcBsD86Su9Gu1vmJEx8o/+xlZnXczOgsuj5CncK0cJqBMb9+GkvX?=
 =?us-ascii?Q?xo6awiRZg/zxLD/WFaJ7N2zw0rl0jq/CHDjgTYU4iPAv/2OMfvHY5DDNATgQ?=
 =?us-ascii?Q?MVO6Jnm6E3MZz2IKkoLI13Cdw7FU2dBADR8crNFpGnwHxQ8G1J2vQa7Hph63?=
 =?us-ascii?Q?81Eth93vIjqQym8zBhdwnAhhR6JedBo/ub9TJ34WZ/Ru4syZRIShcx6mIfBJ?=
 =?us-ascii?Q?9vvxU48TN2ROL2p7LiKSy3sYVDbV9h/lWkys9NPqm6VbZbAhn7IuF9mUDo6H?=
 =?us-ascii?Q?CtneN839bcEbI5SAi//5t+Ng2689iEjwjIqB81js+YLyaaPq7w77elc1pIDj?=
 =?us-ascii?Q?9jaNqXEAu6ZCTjcWhuNJVxafXYWqbRtq7fEt0CajUuXGebU5C/gGm0czMh06?=
 =?us-ascii?Q?jvJL2ZmXMp1FEBwjQL8N6ao=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893f0823-9104-4dc0-0aec-08dd6ab2d625
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 09:04:08.9305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4G0UiLJgms0bQRCVwsekgzv/c9HbN0GFxTPV2kl3YO+VzaQUKYJl6JqTj/wSWoC/5Nq4tstMkCx64VsDwaNrFtqC71jmgzOoOgZ74mMjQ48kcAjDnC9E/sWm+kZLScES
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9339
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Mar 2025 09:04:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18336

Hi Pavel,

Thanks for your comment.

On Fri, Mar 21, 2025 at 09:12:28PM +0100, Pavel Machek wrote:
> Hi!
> 
> > This patch series adds initial support for the Renesas RZ/G3E SoC and
> > RZ/G3E SMARC EVK platform to linux-6.1.y-cip kernel. The RZ/G3E device is a
> > general-purpose microprocessor with a quad-core CA-55, single core CM-33,
> > Ethos-U55 NPU, Mali-G52 3-D Graphics and other peripherals.
> > 
> > All patches are cherry-picked from mainline kernel.
> 
> Ok, thanks for the series, it looks good to me.
> 
> Should I simply try to apply it to both 6.1 and 6.12? I guess I can do
> that if there are no other comments.

I tested on my side and I can share that the following patches are needed
to boot the board on top of be95b49207284 (linux-6.12.y-cip):

abf61442f5523 (HEAD) arm64: defconfig: Enable R9A09G047 SoC
5fe2ef2536b4b soc: renesas: Add RZ/G3E (R9A09G047) config option
0b2bbca0cccdc arm64: dts: renesas: Add initial device tree for RZ/G3E SMARC EVK board
b39f424adff45 arm64: dts: renesas: Add initial support for RZ/G3E SMARC SoM
b1f6a3f53e512 arm64: dts: renesas: r9a09g047: Add OPP table
a89ab4d1d72ad arm64: dts: renesas: Add initial DTSI for RZ/G3E SoC
0545748b50260 clk: renesas: r9a09g047: Add CA55 core clocks
53902b5dba919 clk: renesas: rzv2h: Add support for RZ/G3E SoC
a1721e1ab4092 clk: renesas: rzv2h: Add MSTOP support
c5e58c15e5b02 clk: renesas: r9a09g057: Add support for PLLVDO, CRU clocks, and resets
6e9acef8a72fd clk: renesas: r9a09g057: Add clock and reset entries for ICU
13f8ef8afecea clk: renesas: r9a09g057: Add CA55 core clocks
f53d5c3439ebf clk: renesas: rzv2h: Add selective Runtime PM support for clocks
510f8e3823b22 dt-bindings: clock: renesas: Document RZ/G3E SoC CPG
bcb927d43ed05 dt-bindings: soc: renesas: Document RZ/G3E SMARC SoM and Carrier-II EVK
541305514cdf5 dt-bindings: soc: renesas: Document Renesas RZ/G3E SoC variants

Patches need some really small rework, (just moving up/down things to be
applied).

Test log:

root@smarc-rzg3e:~# uname -r
6.12.19-00045-gabf61442f552

root@smarc-rzg3e:~# cat /proc/cpuinfo 
processor       : 0
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 1
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 2
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 3
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0


root@smarc-rzg3e:~# cat /proc/meminfo
MemTotal:        3883788 kB
MemFree:         3569016 kB
MemAvailable:    3503672 kB


root@smarc-rzg3e:~# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 11:       5442       5213       7158      10565     GICv3  27 Level     arch_timer
 14:          0          0          0          0     GICv3 561 Level     11c01400.serial:rx err
 15:          1          0          0          0     GICv3 564 Level     11c01400.serial:rx full
 16:       1668          0          0          0     GICv3 565 Level     11c01400.serial:tx empty
 17:          0          0          0          0     GICv3 562 Level     11c01400.serial:break
 18:        116          0          0          0     GICv3 566 Level     11c01400.serial:rx ready
 19:          0          0          0          0     GICv3 563 Level     11c01400.serial:tx end
IPI0:       403        479        131        286       Rescheduling interrupts
IPI1:      4293       4511       1482       4291       Function call interrupts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop NMIs
IPI4:         0          0          0          0       Timer broadcast interrupts
IPI5:       447        524        272        565       IRQ work interrupts
IPI6:         0          0          0          0       CPU backtrace interrupts
IPI7:         0          0          0          0       KGDB roundup interrupts
Err:          0


> 
> Best regards,
> 								Pavel
> -- 
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

Thanks & Regards,
Tommaso


