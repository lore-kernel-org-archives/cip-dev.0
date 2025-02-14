Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B49C02198
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 10:41:08 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.55])
 by mx.groups.io with SMTP id smtpd.web10.18212.1739529665444511762
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Feb 2025 02:41:06 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=mYnzw8qU;
 spf=pass (domain: siemens.com, ip: 40.107.159.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2gyP9z3XZ4BeePjX25zs6EHtK5LHDxwMBdr+J9MNWdd51mU2KOU5Tnf8xBJGmtJ25le9GYi+JIJ5gJcZ8ctB8guLUCt3q5z20lu9WMCJc4hh1ypj3BKJehpo8GE4ysSObFGZ/rthlzFxO9N13sitvo8Ii+r0LbZCtB+H+B9lvzsnHwSXQ8Lt2gLZ07+QIesFqQJgQ5t/ggwpTEX2Mmnj6Kr4wxVmr4TTmM+2xtsT3iG02DnuRz+oxfA/OIaPDIXFfOtZIy40q8orCL9TpNEbOpuHbVJj1aAUCd4Vuxf1J7ofjSB+6Y9nPg12kqyg8P4XJB1SYejYuRotoHawuBg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNasDflmEPqgPJkPGFwJ/KambkMYYP95FxgImQi3/pI=;
 b=O3247GF3NN/jFZU/zVS+FscjDeR22xsV96V1x0/sscbrRxLOY1Hvqj3aFzI+9z5pFAmvfwVazM7Z2mcEWAFfnZN8L9w3mHzDfCSeNZ09SmJ7SV37oS6wJ4tPB4F1LwhvmjyV3Qm2ndLMnbAcwTGTl3pei/HwffO78qKYdpeyqPwUn23H2tLTA0K1ExeS3ck8+tNI1Z93MTvu1q2BsBD10eST72QKqh87M+FuVHtADAoLGNUOxuq4Ah0f53Mj2YLYTJmdQk5Su1roaL/HX4lTMTtUUwMejPyK+OiwJauQ6NUEVy/VhKZzOGnFdekjQVVLHJzNCVVdskVywNfpLrmRBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNasDflmEPqgPJkPGFwJ/KambkMYYP95FxgImQi3/pI=;
 b=mYnzw8qUemRoyvXfvZZZSOZH2cpU+I4SxG3uNRBm2IQIfhSNV+K7kIk5MO7EsiNCyaTruUauTOFRfFvWDMg4K3f0BEqvSFIiJun18MsNCshoiDneu1djiP6uOMMcVVdYzfLkKw0mCpPLuV517ehn3Hsjmg2+yGqnXMqC1KTp4GYscz6a8gbasCMs9Su12Gihh6jfyCGH2gdeIuSqAQ9IU/JejhlLdQGopKm74EmC0vtsNuVLPWADMd15s1msftJZrbr/kYCMKMxMxhd/oiKGRR3gM46AlwpTx4RkT/6JBbiTlZhoKIJNKQ1VZihUK5h9O1OID8jR22TU1yozHmAtKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5907.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.8; Fri, 14 Feb
 2025 10:41:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 10:41:01 +0000
Message-ID: <2463f342-16cc-4606-acb9-c1339f886253@siemens.com>
Date: Fri, 14 Feb 2025 11:40:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.325-cip117
To: Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 cip-dev@lists.cip-project.org, Ulrich Hecht <uli@fpond.eu>
CC: "pavel@denx.de" <pavel@denx.de>,
 "masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
 "chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
 "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1733593115.596079.1739239912119@webmail.strato.de>
 <CANgtXuPttHLDcdO7U-WaNS3tTeRUkDB6LBiTt1T0mvsCMjKwOA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CANgtXuPttHLDcdO7U-WaNS3tTeRUkDB6LBiTt1T0mvsCMjKwOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: bec91d1c-8ec1-48ba-2031-08dd4ce412ef
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vUgCoUwiZ7CP5RdjwIQnoW2UwcxQJuoH+kuKDP7vlcSwkNW2dCRv8g3uyuyq?=
 =?us-ascii?Q?uPOnQ6QEJOR+xP5Yh9OCbBzKB8u1KB/ELCCp+xV6TqALN7cCsTDQcu4bBjqV?=
 =?us-ascii?Q?14d8rhuwJenTORR/WcdekVsoi/1BuKpUKz/gNIvaVcUKTvOlFqpTYA00BLeH?=
 =?us-ascii?Q?/0rAUA2YDfbeU/9cuVME3nUJth1TwF8Wlu9rhFhRN648E41tuQiBm+Pi9vaE?=
 =?us-ascii?Q?Ka7jZO21MQh2j36Jic8SOnmM+pLypt+BC1r/pz/ejj6h+Fxmq6ddxyzVYAhu?=
 =?us-ascii?Q?eaaYMZtxwYlS9bMcZ6+zmwm1ScsaKlZCfj/AQGXUYtTkrTnUTEgXz93CEaQY?=
 =?us-ascii?Q?YM+Omo5KT0jUwaArCDDyKdSKbDc8tp5bSm7o0X9aeFTuhMMbDbxQXToqFdAn?=
 =?us-ascii?Q?0r/lGZ5BRPulFvH4edDgOHQdIGDvkgR/SOYM3GVGR7FDnx7i2ADWQrevH4aa?=
 =?us-ascii?Q?460zj4+OfL6vkGE+phUZTZEnWcitSIcdcHyfpWhWyE/eRr2cUckyFgVJZwl7?=
 =?us-ascii?Q?t7g0Q+1sc5J0VREBdCITqHSPZFslClEW7GshnvV4juWCVyyUuo+3qACJbRq8?=
 =?us-ascii?Q?foTSI3uqx6EYjYzwVgmAkF7eheKvWzeXBf6q/vFrVoqk2ymDInv37VuvOemD?=
 =?us-ascii?Q?WzZLK4aZ1kcA9TxZDtiahN2Gr28LiU3r6Vh8oZJQQwIQzt2xi7FtPjoXFR0I?=
 =?us-ascii?Q?ClPb40oMJ0EMtI38ug8HBKKdTJNisbBiqQ3/Ix5LQ5h4fdYYXVzCwodw3xRp?=
 =?us-ascii?Q?nBXdk5roTsvuRqiie+R/LlUgwxlIMpBr9OCmvOYQjswg9HB7Vwv+7YzwuVfU?=
 =?us-ascii?Q?2zuD5dbmGXdGTUBr6kfGwYgfSC80fKdYSuvpoQ4hXdI/3pmr50WYlY3JJAjp?=
 =?us-ascii?Q?rEzZC5W9lO8yPiVAvawq3HGUaGvJ3AmRtfzg/EInbiOUp0iKHtGFQlvbaneF?=
 =?us-ascii?Q?06xEJA49m+VESxEcnbom8p8Jg3eBVDVPkvjN2D1HlxhUvf4FYbF78+mYbniW?=
 =?us-ascii?Q?83UmRX5gAv4ZBTQ3rMFnbpk8aoEKou9PDoG3KaDv6DItGudy4E5LJl9eSCFQ?=
 =?us-ascii?Q?oDjOaI0Pbn0WTEOAQryxryPLxwLvuvnmM60slgregBXemrpzTlWGtEpRCNx4?=
 =?us-ascii?Q?6n6+uIRF3Iftd+iwswuaM5729cj24B+oef6lf9i6ZSjG4/xDFfKJO/9zKSg/?=
 =?us-ascii?Q?xGGiNepfQfxhFjg0FP5nuYXZkc7RCyPOoFYc1T+UJgHdI2iYLKHRQyfHNWAG?=
 =?us-ascii?Q?hNwb81HGPLEjmg7Dj7bsdzrvZGF7KAw7G/zPUzS1jVxNjBYkdxv8WtmSNA0z?=
 =?us-ascii?Q?gu9UjdsEH0hZkDxh/5iBnOBK2nSatRSPq3pwY81UNXhafQDEMOTVrmsZBv80?=
 =?us-ascii?Q?hWgJBso5Utw65mvvf89hEwdDC6Mg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OvOOxQ9wYZasIhfYbzZ7/Gbdr1d5FQUSTcACZNORu7SQRUzIdF1bNDXhH0RZ?=
 =?us-ascii?Q?6OuWAAoKYSlr9GatNGpBBHruzOxZrJ3+TqUC8RYwnxnlOdPD9o3+Cs+kOhi+?=
 =?us-ascii?Q?QKyVYUopglcu3Z4Lbs3/k6MUQrbGULzp67POESNtqKx2l8qg13wJBRLu52zb?=
 =?us-ascii?Q?hX3Sk2NlkI64duGkuQOLsgT8jfNvSEw2Hru1UyaO3dfUDxP1KwkJ6mMlPnFR?=
 =?us-ascii?Q?2HV7f0XtDeqnFlENO8NQA83J6yJ4DWrOMosf7R9CiCtE59uAYxy7KkGd/G2b?=
 =?us-ascii?Q?Bo6nk5WM8haIiUvz8xdh9qxdISwWk64oWDMbiwUwd+naQOz1ORHnzmH6l6xA?=
 =?us-ascii?Q?RLZja6gTBCW+Depad/ov7swguJhSdEL0uaiL4ey3eiFN7jjtHMKNC1u2SZfb?=
 =?us-ascii?Q?lnHr6KpKMV0yfNty3fk6zFi0UJ9jbKjL8KLsZQ3Wxf22OpfvO2vEjJBvNuji?=
 =?us-ascii?Q?/AFW/KCtuRYg11O5HtYb3Uwv/nS7pRxpHfirFmY4evHvMgpjptvmXWr9RYkq?=
 =?us-ascii?Q?+kTw+9HPGL6GeAOsguzRa7vPdKz1xqU6y4s93/5Z6Zk7ew6Z3bb43NlpCJ6O?=
 =?us-ascii?Q?oDh+xalDVwyEU3LsSsTyVqjoVt6tzXoztCeOyLTVFnuKDo3Hqo/Dxumf7Z++?=
 =?us-ascii?Q?ddldipgwqqHrDLmiitEtDOCgNVvwAYx0sSgCFOpFz9vpMWBI/0hDehiJ430R?=
 =?us-ascii?Q?cBrpw9e348IksKBujBvTHieNuyNukb/ppTZv0KaEJmv3X90dxMn7lZnTuddG?=
 =?us-ascii?Q?gHssUTGN6kQVflTXF+ZcreZUPZjr+h3EyymkXLLhtkrC+XtGcGnnJdYikR79?=
 =?us-ascii?Q?YdMZdUSGnC3EAYpRNyqoBrBYUMnT8CaUaT6rNJje0Opo8B/wmoa3THxiz0tf?=
 =?us-ascii?Q?QBLs0xQhxwFI+HFfmnSeJfRDr47lkKOS6X+TFXp7KF07eD58yEAF7gRN2QH8?=
 =?us-ascii?Q?m7cyNrHvJ+9UNtakL/yaYBilfVtbe/9CaK8wAhWwOb0NbDW48LZX4iCmGkfV?=
 =?us-ascii?Q?eCbSX9niL5xWwya6zZNGufh5j1uxZA43Y8vOQ2nc6tD0WOUzLuyJDw/aZUjM?=
 =?us-ascii?Q?4bXJGm0E/XYVI4usifegJgDOxgsI39tYy30S3Sq/B4vge6GEqR0jn/3rbwn5?=
 =?us-ascii?Q?JCXFzf5flG9RMJzxWaJDDnP/BaoXDh2YqoeKfNmrB+LaBxXmSgKo9tODvrTb?=
 =?us-ascii?Q?UinB7PC4vIv78Sw7/9LjGmemLAOkA1aAeZ98TL1J+d7Cr+r7Q8r0O1TkMhVQ?=
 =?us-ascii?Q?3tOxqqMf/bdp40qKYhPOmek0apj+E8RoOjSYuL+lk+QqtpcjueU0pHciQd1P?=
 =?us-ascii?Q?J9DT/Mqt1v2LJKr0APeCpO0EYSb8lzOXqeU7ddBsePqiFJM4gsGI6FgDrJX6?=
 =?us-ascii?Q?CrM4bheXgubAqB2sV6sH73oF4vX5VY7EmFfOFuoCL9IBlIKWkHZCWfJ2IdzG?=
 =?us-ascii?Q?xO1cUsAZPdoBJHB2vYoUd4TgpSbD5PXLk7HE+/9E6dCjCsE7Q43Rc9uflJ68?=
 =?us-ascii?Q?/G805ZpmOcO4RaCByg8sPY1hY5nepmJofSUI7a0w/X5FND/QQBRI6IHSw1My?=
 =?us-ascii?Q?2UFHLpjaCHZnaayojaQH9hY3w8yVJwubkvNkCYMwsPHLxpxSX7ib69emr/sJ?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec91d1c-8ec1-48ba-2031-08dd4ce412ef
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 10:41:01.2192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0+2gn2ifF1mIHs898yHvm8WHu0Oxf/h5N5kq+YoS4dNcNYGTSVc8aoKVc5Ee248RWcneqWnZDSV/BrAkVXeCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5907
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Feb 2025 10:41:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17838

On 14.02.25 11:18, Arisu Tachibana wrote:
> On Tue, Feb 11, 2025 at 11:12=E2=80=AFAM Ulrich Hecht via
> lists.cip-project.org <uli=3Dfpond.eu@lists.cip-project.org> wrote:
>>
>> Hi,
>>
>> the CIP kernel team has released Linux kernel v4.19.325-cip117. The linu=
x-4.19.y-cip tree's base version has been updated to v4.19-st1. The trees a=
re up-to-date with kernel 5.4.289. This is the first 4.19 release maintaine=
d exclusively by CIP
>=20
> I noticed that v4.19.325-cip117 and v4.19-st1 tags are both a lightweight=
 tag,
> instead of the usual annotated tag with the PGP signature.
> Same is for linux-4.4.y-cip branch.
>=20

Thanks for pointing out! Ulrich, please fix and please use a scripted
release process in the future if this isn't the case yet to avoid mistakes.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

