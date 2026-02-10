Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE322EA3F39
	for <webhook@archiver.kernel.org>; Tue, 10 Feb 2026 10:27:03 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.21])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16650.1770719221011844023
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Feb 2026 02:27:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=S+lsuPu2;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.21, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bqf9V09Ucmd7+bbDiNkf6EtRVityaVDtnmp1SzoLsP3p9KN8LSBhMwmTMVF40hz3jc5/uz2dPdi4rooqjWSFHbSqAvoFrTJ5OltWGS50SOtDowTUou3LXWGkPwDvq8WWw4K9/clonbL4BtXZzeDK8Wzg1r3wkeCPVHA7ih6aY7nAzVsIvX71LUMQsJjdbAPUK39BY2FCJflqKV52qxfr8GWIhryyqDKua+eht4D6mkw0vL9QCR+NMgk7dCHqKr+bXNg0jM4CUdcR5gZvW3LjdseJQ/XXdOuwocwIliI11NjO6iJSBQibzbTh8aOWap8P+gqkvx6aCmhuqsZbwTYtFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zk4WY2E9cb/PxNJLVMoVxEJ95OYobcCmnir0PVgmmSE=;
 b=uID1WYwzfREj5lAuDRf+zWeW9R/9LfurfsrlxeL407yaVrmcBYrbGYhtoDg0nbFY6r41Mv8F4IM2ZRKYeyQeB6YcyQvywFTLpgJuo9aVycdh07DS43GK0T2CHxAKGpkG6Yzwyhgguf1YM1ro+YDKhVA2G97WLZ7fo5qw/7Ye16VvdZkIcqKY3WtgmHJi4nPZ7m/KDmj+309fgVlT4q9fDV2N+/f50WPaxn2IPLo07wTTpkX8XEbLymf4lZoO7fIsVq2Hagsa1VJeHj59cf7H5wMh1bsetZd7o1/2xbA3M36K9SdPMqB1PCKdAWEZI+4u57phKw/jwH0mdMAjwUtwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk4WY2E9cb/PxNJLVMoVxEJ95OYobcCmnir0PVgmmSE=;
 b=S+lsuPu2VHsX+UusV5r1eXZG5bckhD9aJJhiDuyR4nwxYIq860Qikskkk65ZiVjRRCODienNrujEscBw2Oudd4zN7+pcGpNyfF4AignVcLgLbbTqWf17pQltazuiIyp/wXGB5mmwZncfKyf6PaZGZOXG/9EadXf3zd/LChxhrRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10424.jpnprd01.prod.outlook.com (2603:1096:400:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 10:26:55 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 10:26:55 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 5.10.y-cip] i2c: riic: Move suspend handling to NOIRQ phase
Date: Tue, 10 Feb 2026 11:26:37 +0100
Message-ID: <20260210102637.484003-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYWPR01MB10424:EE_
X-MS-Office365-Filtering-Correlation-Id: 1944508c-9ec5-47f7-92d4-08de688ee9fe
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?icjASnDbHTv6sdPucktnzbQ4COCT9GIGeYwUKqYPvuD1TXvEHbybFXM2SU5v?=
 =?us-ascii?Q?aYKnfm4X94jXtVXnvijH7XpOEY3zOtezBuF1efeDL4w/6W8zO9W6NdEMwFly?=
 =?us-ascii?Q?L962XWG2vJd2Iai/pSQNYIXCTw0S2C7Msl1AUKrgx8WuvIoK65L/bLVYki7o?=
 =?us-ascii?Q?Li1ItGZ2ow1iJvjR/qdZeDE01CmerISrUmgs67sV27pQekPV/IWPqH5hU8dv?=
 =?us-ascii?Q?4APQuwpBNwWBtqhNoy8e/Byi35nyZXM6dHttq6lfu/kaLXyQNNtcy4lXB38x?=
 =?us-ascii?Q?aIPlaFxg+5cSkF9rqRqcvGDaEEPtvivYn8OmwPE8w0eDigqcLtWoxvZ06WuB?=
 =?us-ascii?Q?Y2OO4GRkXQU4QltFuLQI7QIPmEVxQR5E95k01jrVynuFOBGfPrZUDO+Fhc7v?=
 =?us-ascii?Q?vDe1BAVnjlpCAsHOrWNlyqkKH3ETadYEpNLG+y1vmSi7XMhONWarQolHcjvu?=
 =?us-ascii?Q?9mVFjVbXFBtj+trsUcfLqF9O6afRHKrMaCon8OHehc+6vOIBD4Ytph1XE1Qc?=
 =?us-ascii?Q?l9JdWmXVyXzBI6fJPPu2S/Q4lBVkz17SMhmb8QeZ5BtilD+oiY3gbZ407Q+h?=
 =?us-ascii?Q?AAjSoiollEvNWms+8/XJv7DUrG7JwU6jAWrYSJWPMvx5Ua/m9x2euAKaOh76?=
 =?us-ascii?Q?k46ggmWOLkFT4eG2AxsS/PwdllDnooRVP5LysbJxshuRcXPxxIakQ7vzVvxn?=
 =?us-ascii?Q?Yd1M/PNfoRIYb3HRLbY/L/SfmH2DA6bkMMz1QA0jdmzMfV5c0rMI7cpovrLi?=
 =?us-ascii?Q?8V87q1XH1G88V7dJK3SH5u8ZdlNAmWROZ6QOxneR7X0MO15lPjZYIJtkVShQ?=
 =?us-ascii?Q?WDBazHyr6RPm5n0eovM5RfDAhJ6BYfKOgwa8+m1rLWH+T84rGqc8Z5GnYFKP?=
 =?us-ascii?Q?6OfaIDn/uOW43YG7I1yOaf3aAHP4fcFejNDhz58JR+74pItoB/hi80EKmJKY?=
 =?us-ascii?Q?U5TqQp6MZzMVW2WwBvSr6r/W+r9PB/lrIOmUJAFd6eOXJtkkIcZwaTgd4Xkt?=
 =?us-ascii?Q?tQyRaRsMKGJgv93KwAweVBkwvHf6VkU4Hs25LjC1NkDii5T9NwFwHcs+uBl8?=
 =?us-ascii?Q?UJRWYJ3mQYfPCwox8bOWc0H6ai7u7ZxoF+PrXpLKne0FzI8YYSEiIUsSetKP?=
 =?us-ascii?Q?flERpKamJLScJToyCGY7oobtcUZIsrtIPTSlqIGejILlrGT0bS4b1pteW4gx?=
 =?us-ascii?Q?3YaPKcsRcw1rFMQDH7+Qwmippnjv3M9F/B0JBn0KlowOL0S8WTEHCNNvmAds?=
 =?us-ascii?Q?jZg8rtNzDmcdQ5KKdip+2sx2hIloUNS0ZlHNjwuCmB4usB3cyPZNCRglmqf2?=
 =?us-ascii?Q?yYNb0bzopmijLEUGF7oH62QG+SjKAt+6lhUxc87AwgWFVEbZ33KbUxx7PIRT?=
 =?us-ascii?Q?6ZJcLc7iX6Xd6s/P1TMZQjtM0OnzsBaBiVtrudpfd2SYBxqoaOsdrD8cD9X4?=
 =?us-ascii?Q?A832uexWFf0JT2Tee/23YTxOIN35griCMZ5RFRky0Vdh/XdVmxx10tsvm0tX?=
 =?us-ascii?Q?N/7RVt6g4vx46JpPs/4SwMcjpg8CKTgGIvizTLsq6f7hGImtL6qXc7/hnCbq?=
 =?us-ascii?Q?/p+yuJNjSBkOUH2H9q2Tr0hTLHC2Fi8AOxTIAf6BDSsmdUq9p6nvHkF9ozPf?=
 =?us-ascii?Q?j/Noq2zJZHRKCJA4OCGknQ4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2vOsBPy84Ly2LPhKbbgUowFOyUpTshGQ6vODSdnLfM9YNHc+/lQZOe5DpjFG?=
 =?us-ascii?Q?YcKxaZWyGpsUwYlIj9/KskVEPKEz62tQbubDtWYgiz/jgIXEfY58+fr2d9No?=
 =?us-ascii?Q?aj87OrYAq1irWv/q7hMQxjLqqUjUIx3HWXIZAHEpPd6R8mzCGIpWEPhIfsdg?=
 =?us-ascii?Q?EAUyagO3fq225VY0HGzm2CeFDkfFWJmW1dVC+/PbisX9nCViko9j647yrT2n?=
 =?us-ascii?Q?RiVh+Xa0jsgvnkA2//2vDP1hABMkyxfSz2Ra8durKtIp1OxHcD6L2L+iqW5O?=
 =?us-ascii?Q?BjdZapnM5PylSjH2bAogfKMLfyLMgGtnqEPXXrXZn+eTNtLkDHHFlwe6ZUqU?=
 =?us-ascii?Q?VDSV2+zCzD1OX7ScDIh8q3UzXOxHXR+NUUsbdyG1p/ssvynaTxImZdxAGWbk?=
 =?us-ascii?Q?VkjVUaszpphFZkG3CaiAZCWeH0HET/kJNclWcjX5TcpBPLHy4coALoUzYrIZ?=
 =?us-ascii?Q?zgqQ7prNEr/pQ/24XNRDvhyQepOTQKEr381kO8iHiiG/nK/khER09qRWRxPz?=
 =?us-ascii?Q?TygZySg/eNtPkhjrSIEv3jrx8EUSMIezpMhG8iZeWlzphYbTL6MqPEB3daq9?=
 =?us-ascii?Q?muDUEV8AWr8eoa6K8cG9UZQ7B7RtWP1wfWM+sxZgx6+OZgSGym2Fql7YcrWo?=
 =?us-ascii?Q?8Q8NAEr7qq5LVKQFk6n3jVihSPnCxXPvYXMnLEvd81MVZ9uFlUfu2JcVFVlO?=
 =?us-ascii?Q?eUCbg6j2cUS0sPjqIv3tHC3XzOqbxJAbq/yWl2J+pct/KGbvuCnokgvZE6B9?=
 =?us-ascii?Q?7sicbiY3fzXrVEdMpcNju1u3/apD7NCFk+7hBsSLLszdOt92WS7kFEeA5Llp?=
 =?us-ascii?Q?cGA84d0YjuxMza4l8V8vDyYZ99mFlPI0FyALQ1kPpv7gMtphWnmi60Q8cLcR?=
 =?us-ascii?Q?XWC6LO4CTcflD/rVNmB8gluH/6G2KUcdC/pHGx7TxZhjqn8Rz1rFbqCCa4J8?=
 =?us-ascii?Q?kvAMhFeNvU5VgjkKiYJaw34yscB6rHE/YUICk9I5En2uVN18yyIgW4U6XdwK?=
 =?us-ascii?Q?6EvJZm5G8VLzH+WNn9f6lVnmX4NAGnCv6GDDt034TOtQwsW1JZUBGSVeN+xz?=
 =?us-ascii?Q?21XdZaeCt/QsEEcVsocK9F3MaTxuxrlZN+tgf1OkZZhPBENcqTPB3I2TvmvS?=
 =?us-ascii?Q?AZQ7toLt4m5bWST8Hm77p8Tv2uVpEiTEk+mNnDlAYXeH/kGQH4199de2qMsT?=
 =?us-ascii?Q?7XVQ4k2/nkVexitAgu9vQ+VJ6b6ZOOaeRkOP1qw7d5mAtwUdkvdeqfjgGW/H?=
 =?us-ascii?Q?LdD91T7hP1eO4sTZmGVJ1FVMJG2v41Pcf1WWgTI8BajPXk7Tlrc0qdoVC0b2?=
 =?us-ascii?Q?R51dobmtFPN6cRoKqmMSa4Zkrk6H8AxtI838luTZD2cOu9pm2s2Lo64y8gUX?=
 =?us-ascii?Q?ez3GFFT5IED2jQQXKf+yxI40hK/yLBLznZ/JIUgF08gOkOFdZbjVo1pEiwo7?=
 =?us-ascii?Q?qHWz0lcclBBQSYZb4fe8Zp9Y1zBYaNQiJSTSUlVriAJEZAsiN3rBmsG4TCqX?=
 =?us-ascii?Q?FB2BPWJSLZ+CTq7PBfMZU0Uiwkm9xNT1Ys1flKJJ721gRqaghMwfQEiNvDSR?=
 =?us-ascii?Q?WbzUknw1a/as43EPQXh4o0uowjQqW6GnPVajtX1+qx7LzpMVMfy5zfCNW15i?=
 =?us-ascii?Q?4etIy/z/47keWikQqVlag1iE0dU4NpaKeFWSG+/JjbU4GjYUle8RiXEhWQ5Q?=
 =?us-ascii?Q?iEab8Euf8hWQwLyluC5/rB92XAAIDVysv7hi38CwL4bscUNn0E+pzRHbd8b7?=
 =?us-ascii?Q?PraJAZ6qUSeCBgv8OA3YEj2q2D1S1+mUdGhuK6IsZ+UP63/Ew+LG?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1944508c-9ec5-47f7-92d4-08de688ee9fe
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 10:26:55.7272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6XfUfSox5m7AoJm4k/2nunC6e1B3IgexpttyYcyZeOwcC6L0tXzUvQNPZGwxpD1YV+wESOfNksJ4yyK/TZGYGyQdjHBrMZnv7nXjDAuEY/xWJUHDxpWXy4DilUnVmXd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10424
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Feb 2026 10:27:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21851

commit e383f0961422f983451ac4dd6aed1a3d3311f2be upstream.

Commit 53326135d0e0 ("i2c: riic: Add suspend/resume support") added
suspend support for the Renesas I2C driver and following this change
on RZ/G3E the following WARNING is seen on entering suspend ...

[  134.275704] Freezing remaining freezable tasks completed (elapsed 0.001 =
seconds)
[  134.285536] ------------[ cut here ]------------
[  134.290298] i2c i2c-2: Transfer while suspended
[  134.295174] WARNING: drivers/i2c/i2c-core.h:56 at __i2c_smbus_xfer+0x1e4=
/0x214, CPU#0: systemd-sleep/388
[  134.365507] Tainted: [W]=3DWARN
[  134.368485] Hardware name: Renesas SMARC EVK version 2 based on r9a09g04=
7e57 (DT)
[  134.375961] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  134.382935] pc : __i2c_smbus_xfer+0x1e4/0x214
[  134.387329] lr : __i2c_smbus_xfer+0x1e4/0x214
[  134.391717] sp : ffff800083f23860
[  134.395040] x29: ffff800083f23860 x28: 0000000000000000 x27: ffff800082e=
d5d60
[  134.402226] x26: 0000001f4395fd74 x25: 0000000000000007 x24: 00000000000=
00001
[  134.409408] x23: 0000000000000000 x22: 000000000000006f x21: ffff800083f=
23936
[  134.416589] x20: ffff0000c090e140 x19: ffff0000c090e0d0 x18: 00000000000=
00006
[  134.423771] x17: 6f63657320313030 x16: 2e30206465737061 x15: ffff800083f=
23280
[  134.430953] x14: 0000000000000000 x13: ffff800082b16ce8 x12: 00000000000=
00f09
[  134.438134] x11: 0000000000000503 x10: ffff800082b6ece8 x9 : ffff800082b=
16ce8
[  134.445315] x8 : 00000000ffffefff x7 : ffff800082b6ece8 x6 : 80000000fff=
ff000
[  134.452495] x5 : 0000000000000504 x4 : 0000000000000000 x3 : 00000000000=
00000
[  134.459672] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c9e=
e9e80
[  134.466851] Call trace:
[  134.469311]  __i2c_smbus_xfer+0x1e4/0x214 (P)
[  134.473715]  i2c_smbus_xfer+0xbc/0x120
[  134.477507]  i2c_smbus_read_byte_data+0x4c/0x84
[  134.482077]  isl1208_i2c_read_time+0x44/0x178 [rtc_isl1208]
[  134.487703]  isl1208_rtc_read_time+0x14/0x20 [rtc_isl1208]
[  134.493226]  __rtc_read_time+0x44/0x88
[  134.497012]  rtc_read_time+0x3c/0x68
[  134.500622]  rtc_suspend+0x9c/0x170

The warning is triggered because I2C transfers can still be attempted
while the controller is already suspended, due to inappropriate ordering
of the system sleep callbacks.

If the controller is autosuspended, there is no way to wake it up once
runtime PM disabled (in suspend_late()). During system resume, the I2C
controller will be available only after runtime PM is re-enabled
(in resume_early()). However, this may be too late for some devices.

Wake up the controller in the suspend() callback while runtime PM is
still enabled. The I2C controller will remain available until the
suspend_noirq() callback (pm_runtime_force_suspend()) is called. During
resume, the I2C controller can be restored by the resume_noirq() callback
(pm_runtime_force_resume()). Finally, the resume() callback re-enables
autosuspend. As a result, the I2C controller can remain available until
the system enters suspend_noirq() and from resume_noirq().

Cc: stable@vger.kernel.org
Fixes: 53326135d0e0 ("i2c: riic: Add suspend/resume support")
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
[tm: Used SET_NOIRQ_SYSTEM_SLEEP_PM_OPS, SET_SYSTEM_SLEEP_PM_OPS and
 CONFIG_PM_SLEEP ifdef for backward compatibility]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 48 ++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 1528912d7a13..4d76f066dd4c 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -577,14 +577,42 @@ static const struct riic_of_data riic_rz_v2h_info =3D=
 {
 	.fast_mode_plus =3D true,
 };
=20
+#ifdef CONFIG_PM_SLEEP
 static int riic_i2c_suspend(struct device *dev)
 {
-	struct riic_dev *riic =3D dev_get_drvdata(dev);
-	int ret;
+	/*
+	 * Some I2C devices may need the I2C controller to remain active
+	 * during resume_noirq() or suspend_noirq(). If the controller is
+	 * autosuspended, there is no way to wake it up once runtime PM is
+	 * disabled (in suspend_late()).
+	 *
+	 * During system resume, the I2C controller will be available only
+	 * after runtime PM is re-enabled (in resume_early()). However, this
+	 * may be too late for some devices.
+	 *
+	 * Wake up the controller in the suspend() callback while runtime PM
+	 * is still enabled. The I2C controller will remain available until
+	 * the suspend_noirq() callback (pm_runtime_force_suspend()) is
+	 * called. During resume, the I2C controller can be restored by the
+	 * resume_noirq() callback (pm_runtime_force_resume()).
+	 *
+	 * Finally, the resume() callback re-enables autosuspend, ensuring
+	 * the I2C controller remains available until the system enters
+	 * suspend_noirq() and from resume_noirq().
+	 */
+	return pm_runtime_resume_and_get(dev);
+}
=20
-	ret =3D pm_runtime_resume_and_get(dev);
-	if (ret)
-		return ret;
+static int riic_i2c_resume(struct device *dev)
+{
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+static int riic_i2c_suspend_noirq(struct device *dev)
+{
+	struct riic_dev *riic =3D dev_get_drvdata(dev);
=20
 	i2c_mark_adapter_suspended(&riic->adapter);
=20
@@ -592,12 +620,12 @@ static int riic_i2c_suspend(struct device *dev)
 	riic_clear_set_bit(riic, ICCR1_ICE, 0, RIIC_ICCR1);
=20
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_sync(dev);
+	pm_runtime_force_suspend(dev);
=20
 	return reset_control_assert(riic->rstc);
 }
=20
-static int riic_i2c_resume(struct device *dev)
+static int riic_i2c_resume_noirq(struct device *dev)
 {
 	struct riic_dev *riic =3D dev_get_drvdata(dev);
 	int ret;
@@ -606,6 +634,10 @@ static int riic_i2c_resume(struct device *dev)
 	if (ret)
 		return ret;
=20
+	ret =3D pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
 	ret =3D riic_init_hw(riic);
 	if (ret) {
 		/*
@@ -621,8 +653,10 @@ static int riic_i2c_resume(struct device *dev)
=20
 	return 0;
 }
+#endif /* CONFIG_PM_SLEEP */
=20
 static const struct dev_pm_ops riic_i2c_pm_ops =3D {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(riic_i2c_suspend_noirq, riic_i2c_resume_noi=
rq)
 	SET_SYSTEM_SLEEP_PM_OPS(riic_i2c_suspend, riic_i2c_resume)
 };
=20
--=20
2.43.0


