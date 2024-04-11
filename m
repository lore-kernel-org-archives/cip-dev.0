Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B75C4345F
	for <webhook@archiver.kernel.org>; Thu, 11 Apr 2024 16:45:57 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.50])
 by mx.groups.io with SMTP id smtpd.web11.23118.1712853954655772493
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Apr 2024 09:45:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=L2uK2iD7;
 spf=pass (domain: siemens.com, ip: 40.107.6.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGB9IRjkkRORFGth4j+G/0s6lEBHY+gRRKgtbebcXMJcryCcw2JbZvuKP05KLow55JtPWxKDQ3CJOH0lejUDSk8/mIR3kSbKcMdL8BgGhtRYaV1D03vC0CXs1xIWLN4Pt20fd5c+qTCo1K+YzjDiJTei7Zqg7wAacm4HuCzDvLmePEYzNrBdOtTOnRwBY+83NE2ovXqi9KKoOemWLhKJKOMX6b5lVzHdRk2PeGnyF1K0n4EJetTUligel8nznvVCzzLKO94MRaV1OW9ZyJHd2bX+vbL/9L2TfeyWBJoGFbQE575gIvXxnvWbkaQRv+Ss0yxZ38sLBLifSxiRTg0ujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z2MKcwCxen8IogITgA94g1xYVUgWXvQv7ZvIB0/vbo=;
 b=WrFY/0T/y8CvLsqakEYzUsmPaEFpYg2JpxjIbXmLUjjX3QAQmz0dkKt0y+zlGfZld1eeNpwmVWFmYPYFUjl2oOdMWQsBft5REcweMrRDzMaeB/7uY4wk8w6L7xF4ekYYlagiN47GrJNXc0+YmINCLnC7HCtxffHI8hwDQwcjkc5gek4LFPvcIhGhIGEYFmfsNyGEvbXn5BTZdRVJwTD7LNteLoWNhWeE/LUjdfi6I/G/mMR8BqEioVZMCU6Aw2vU5e+arE2qDRVYxkoRcvzu4ZsklXhb3r3/nYY8yZWVs3M8j+JzeoNol7RI7M4YGPqP6XllNZ+/1RkXzOe/0O0eFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z2MKcwCxen8IogITgA94g1xYVUgWXvQv7ZvIB0/vbo=;
 b=L2uK2iD7njkuMIkfb2w4U6e0HB/UCbTdXTOPwlqDJ3j9p98jCGx9N0gl1QTPC64qK8sL0ACElq70o3IurgDxEzsVxrxijMKrTA+fxGHRQMT6ojXeHdFMsD7toaQiXpZcMLdgL9l2+fsibR0mz4JVu+JBcqkBPvb1w4EveImTgkiOGfbvxrFlF7393pTPWPHXdU9jB9xU7rVxVivnaRgt3z69ZzsQXNJUHKZ1BgFkqNORqoemlETifqc6co2k8E6ac31+p+XqJP6yzX/oPE2ktCOwEVSzAtgWtr387avxwmh9r1MfP0P8w38Du0dMzOkGfR29s/0K+Bk7j/mLEogDkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3688.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:138::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 16:45:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 16:45:48 +0000
Message-ID: <71e9f4ce-970e-41b1-b4e6-ef16e184a77d@siemens.com>
Date: Thu, 11 Apr 2024 18:45:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Bookworm with swupdate 2021.11: Error getting key 'kernelfile'
 from bootloader environment.
To: Hannah Kiekens <hannah.kiekens@essensium.com>,
 cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 "Schaffner, Tobias (T CED SES-DE)" <tobias.schaffner@siemens.com>
References: <CAP07BnkpBLJ0vnN3FUJZp+DDiWm8wjj5F3=wMNfabqjPJvMDDQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <CAP07BnkpBLJ0vnN3FUJZp+DDiWm8wjj5F3=wMNfabqjPJvMDDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:610:e7::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3688:EE_
X-MS-Office365-Filtering-Correlation-Id: db4f5bf1-bd86-48f8-0328-08dc5a46d730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CjzYejcP1Z2y7focowbclrZtJK7QvmeM18HtHlXcrZnTuUdP4kFAPDux+sSmLonKM8MFvpcSTDp8QePP/xeqQzXk/CDsGShlI5CX9RHQpHKjQi13XP57ZFMhD7LT6jVBjH/5enbJo+NyX0IwOSObOO5Bv1D1iwc9b/9ReyCvBI59lak8pmI6H/wcju6qU65d9ouE3gBZSx+hrjgGLmrE5rz01/U2/egp28eOvWEHLlnURKYmF+3wA27HVVNXhX1c8+DGFt+HJ1w+DncMjajCYIYVDX0zAg+KJbmLY94dVz7gpcTW29YnAQYsO7XJKpQK1g95TcZcYljYSKZKK9hYKGly6+KK0kFVfV3XsOWBf4f1ttKHqzBXWktg5qnb1f7d9E8TUX1NJNKQi8w3m71as81LEFqU5S8yF1S4w8GekJvZzfnXhQmsui+w6DVGyYpUP+ZDQ9Wa6WZMQvyNhAZgOwWVDtFn3Vo7ZxEuv31kCeqjtfDKIVEtIEQC5bQpiQXEtkU73jPWDJvT/GXCoji3mqg0T0MIWAuxt5aU21UtrfL436mDPjRZY7dQv7Kj/DDc3QrO0sCWZnOjECQ2yjmUIWsACQ3CTYEInX5oeEJSNjbJhk7HIk9kGhssQxAEUsjasVX2HlGPMVqkRx5p53f5EQ4xFcvnLoDtPW3uWHXn1rs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eG45wV6zI7vQaHtDwlJQ841lecwEkwHE57IS264y1dJJszCrQrSawvNV5RqB?=
 =?us-ascii?Q?Ysn/qfYHHkMfKQDCEVdomYQeseAarvsnPKHjQ3nKdH/vhvYcu2Esoear2jQu?=
 =?us-ascii?Q?R93vP4XcgzdxKcmhx3TyaFjrp9RdGxVcqvNJk1nBSK5c1XzcCtRxWLwfDz0T?=
 =?us-ascii?Q?Ei1c25+ApsMHjdBS9Z6UPM7meou/cdSBWuKUpp98n3x5k+DUNoa4y07fjiMi?=
 =?us-ascii?Q?ZP8F6gmK1dY65O66hZbcRV2+12QFYyTX935LyxAWItgqfU5SJzL5D/Qkm86a?=
 =?us-ascii?Q?pp6YtUl8t5pPrJ4W8rmo54pt7oxPmwaMl2KwEnUmRsr/NGR2/c2gLcVHGw3t?=
 =?us-ascii?Q?345FLIaKCbUFFBnyjzZdYheH9ljpFByLF69DeCZLpMQJQpgvTpa95Sz4MJHP?=
 =?us-ascii?Q?sgSj9+UDkNC3O+UD3yZdhJ00G28QduF+aGfGDWE6Bqmjmsx736IGDygVXgPK?=
 =?us-ascii?Q?nV4hQZlH6NVQP9TG8WBLMmb2aWxiDDnUIyzHfY9Wypu+0xAfudvDoVRbFzZB?=
 =?us-ascii?Q?wLa3HumAe2+hwaq7qm5EMIzplQZtxTYClpa314N6j4j7oBwZgzXmcfCaKMIK?=
 =?us-ascii?Q?e7K/pj4PS/B9OGRAp3q+C97Wsjdb3p43amaG0F1uSoRDd9vMxgQB9Ojl2Sm4?=
 =?us-ascii?Q?v2jwC9yeX1ClDXRAnzpEWNEeq1hVzwON5eSElMzXjD4GDE21PuuiwTwT/mJ5?=
 =?us-ascii?Q?kFiCBug2LqOFoTBgSdPn0Z+jmTlDS25sbXRAkqasb1EIarGu9S+K5iBTgkzq?=
 =?us-ascii?Q?CXVxu8xMCQrsn3wQV2mCb1mmPaCthSGJUQMt3ACs11Cy10JIbjTNomYhNE+b?=
 =?us-ascii?Q?CEkCO42Tu6XwwBR1yNDRYHp6kIi2QUkxywqtLev1EoRgJvjfvGJ7VjZgzXcf?=
 =?us-ascii?Q?iUORkYZUyqkGKTIZIlqg3NrfOsOmQBz8ryT3vbSSFhl+VjKApeJIsuFcYJ/v?=
 =?us-ascii?Q?NuAU1g5jSZsqzdcBFekdNBvrbOVETJDSzvH6kchx2hUpArOWsBMLXPx6EBMh?=
 =?us-ascii?Q?MbdQZ5rCnTXCL/GhxqR83kHq5Jlz1grXtmTOQsUgghELkWp9dOVHyl8dgVu6?=
 =?us-ascii?Q?baSR/dWumxLDsmuBwNGK0iXS1oFLYUPQzwSfj+zyPCi7aa4KYLBdOS28wRRC?=
 =?us-ascii?Q?EyOa97iyixRaH0ShwUdZau0qn99qSFM6hIRziqIec+4eB/2vRMpsgff7ZF8w?=
 =?us-ascii?Q?q+TP9mqMZuISBqwU0+w3uOK13riSxdV/yHtkPE1eAI2nG1yUlbWSPdmyJhCG?=
 =?us-ascii?Q?lUJHNXj1hCW5QmhNEopj6G+rn57FBGMFnS7MF8qvQq+jkaRc69w0/SrBgSLj?=
 =?us-ascii?Q?9KoklP18V1K+jXRjMBeQwNzH7gMNRUWYqhBpyXjPWC6U21Vu7pkvJFj6WuEn?=
 =?us-ascii?Q?BzFHVhhwZlcb2UY3JTs3tBgk6NuYgY6AWzok3zGlnu9xZccmTEwftyrTtz2n?=
 =?us-ascii?Q?WsZ5Hs/t/e+FMB9fYfQgZh4o5x2gs1rZLxZrtdPLxc4LAm45IGBEY1Xo6YvX?=
 =?us-ascii?Q?VL0D0JD+SRoWqyLJ8l5fB9xcH/erYZkGRoJfE/TyW214Nop5gqhQIEKJFanZ?=
 =?us-ascii?Q?txJ9cUvtm2vmw0NvelVY1i70jnYuq685kMyBu83g1bVnVVMoEcyaHlVaTBmq?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4f5bf1-bd86-48f8-0328-08dc5a46d730
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 16:45:48.6585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5rx+0YkMCI7NRrfqNSXznABhZcrRt5YrLkm0+vbU6r45e/OYYLE2G6m9fHQq2rodARLU2meiu+3datgWVOayw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3688
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Apr 2024 16:45:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15546

CC'ing folks who may have a clue as they may actually use that combo.

On 11.04.24 17:09, Hannah Kiekens wrote:
> Hi everyone!
>=20
> The roundrobin handler seems broken for the bookworm with swupdate
> 2021.11 combination.
> It is easy to reproduce with qemu on the next branch,
> PREFERRED_VERSION_swupdate =3D "2021.11%" is the only change that's
> needed. Log of this setup included at the end of the e-mail
>=20
> I am not seeing anything that's obviously different with bullseye.=C2=A0
> We are using bullseye with swupdate 2021.11 on tag v1.3. I am working on
> an upgrade path to bookworm

So, bullseye and 2021.11 are still fine with current 'next'?

>=20
> Regards,
> Hannah
>=20
> LOG:
> root@demo:~# swupdate -v -i cip-core-image-cip-core-bookworm-qemu-amd64.s=
wu
> [TRACE] : SWUPDATE running : =C2=A0[swupdate_dgst_init] : public key / ce=
rt
> /usr/share/swupdate-signing/swupdate-sign.crt ignored, you need to set
> SIGALG
> Swupdate v2021.11.0
>=20
> Licensed under GPLv2. See source distribution for detailed copyright
> notices.
>=20
> [INFO ] : SWUPDATE running : =C2=A0[lua_handlers_init] : Lua handler(s) f=
ound.
> [INFO ] : SWUPDATE running : =C2=A0[main] : Running on cip-qemu-amd64
> Revision cip-core-1.0
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : Register=
ed
> handlers:
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 dummy
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 archive
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 tar
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 uboot
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 bootloader
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 uniqueuuid
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 lua
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 raw
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 rawfile
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 rawcopy
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 rdiff_image
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 rdiff_file
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 readback
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 shellscript
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 preinstall
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 postinstall
> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 roundrobin
> [TRACE] : SWUPDATE running : =C2=A0[network_initializer] : Main loop daem=
on
> [TRACE] : SWUPDATE running : =C2=A0[listener_create] : got no socket at
> /tmp/swupdateprog from systemd
> [TRACE] : SWUPDATE running : =C2=A0[listener_create] : creating socket at
> /tmp/swupdateprog
> [TRACE] : SWUPDATE running : =C2=A0[listener_create] : got no socket at
> /tmp/sockinstctrl from systemd
> [TRACE] : SWUPDATE running : =C2=A0[listener_create] : creating socket at
> /tmp/sockinstctrl
> [TRACE] : SWUPDATE running : =C2=A0[network_thread] : Incoming network
> request: processing...
> [INFO ] : SWUPDATE started : =C2=A0Software Update started !
> [TRACE] : SWUPDATE running : =C2=A0[network_initializer] : Software updat=
e
> started
> [TRACE] : SWUPDATE running : =C2=A0[extract_file_to_tmp] : Found file
> [TRACE] : SWUPDATE running : =C2=A0[extract_file_to_tmp] : =C2=A0 filenam=
e
> sw-description
> [TRACE] : SWUPDATE running : =C2=A0[extract_file_to_tmp] : =C2=A0 size 12=
67
> [TRACE] : SWUPDATE running : =C2=A0[get_common_fields] : Version 0.2
> [TRACE] : SWUPDATE running : =C2=A0[parse_hw_compatibility] : Accepted Hw
> Revision : cip-core-1.0
> [TRACE] : SWUPDATE running : =C2=A0[add_properties] : Found properties fo=
r
> linux.efi:
> [TRACE] : SWUPDATE running : =C2=A0[add_properties_cb] : =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Property
> subtype: kernel
> [TRACE] : SWUPDATE running : =C2=A0[_parse_files] : Found File: linux.efi=
 -->
> linux.efi (C:BOOT0:linux.efi->BOOT0,C:BOOT1:linux.efi->BOOT1)
> [TRACE] : SWUPDATE running : =C2=A0[add_properties] : Found properties fo=
r
> cip-core-image-cip-core-bookworm-qemu-amd64.squashfs:
> [TRACE] : SWUPDATE running : =C2=A0[add_properties_cb] : =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Property
> subtype: image
> [TRACE] : SWUPDATE running : =C2=A0[add_properties_cb] : =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Property
> configfilecheck:
> /etc/os-release@not_match@IMAGE_UUID=3D7f15735e-dd28-48b3-a881-a2e7353d93=
df
> [TRACE] : SWUPDATE running : =C2=A0[_parse_images] : Found Image:
> cip-core-image-cip-core-bookworm-qemu-amd64.squashfs in device :
> C:BOOT0:linux.efi->fedcba98-7654-3210-cafe-5e0710000001,C:BOOT1:linux.efi=
->fedcba98-7654-3210-cafe-5e0710000002 for handler roundrobin
> [TRACE] : SWUPDATE running : =C2=A0[check_hw_compatibility] : Hardware
> cip-qemu-amd64 Revision: cip-core-1.0
> [TRACE] : SWUPDATE running : =C2=A0[check_hw_compatibility] : Hardware
> compatibility verified
> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : Found file
> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 filename
> sw-description.sig
> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 size 1348 Not
> required: skipping
> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : Found file
> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 filename
> cip-core-image-cip-core-bookworm-qemu-amd64.squashfs
> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 size 119066624
> required
> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : Found file
> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 filename linux.efi
> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 size 16962560
> required
> [TRACE] : SWUPDATE running : =C2=A0[extract_padding] : Expecting 388 padd=
ing
> bytes at end-of-file
> [TRACE] : SWUPDATE running : =C2=A0[network_initializer] : Valid image fo=
und:
> copying to FLASH
> [INFO ] : SWUPDATE running : =C2=A0Installation in progress
> [TRACE] : SWUPDATE running : =C2=A0[install_single_image] : Found install=
er
> for stream cip-core-image-cip-core-bookworm-qemu-amd64.squashfs roundrobi=
n
> [TRACE] : SWUPDATE running : =C2=A0[notify_helper] : Round Robin Handler:=
 No
> compiled-in config found, trying /etc/swupdate.handler.ini
> [ERROR] : SWUPDATE failed [0] ERROR : Round Robin Handler: Error getting
> key 'kernelfile' from bootloader environment.

I suppose this is where the problem starts.

Jan

> [ERROR] : SWUPDATE failed [0] ERROR : Round Robin Handler: Could not
> determine current root device.
> [TRACE] : SWUPDATE running : =C2=A0[l_handler_wrapper] : [Lua handler]
> returned: 1
> [TRACE] : SWUPDATE running : =C2=A0[install_single_image] : Installer for
> roundrobin not successful !
> [ERROR] : SWUPDATE failed [1] Installation failed !
> [TRACE] : SWUPDATE running : =C2=A0[network_initializer] : Main thread sl=
eep
> again !
> [INFO ] : No SWUPDATE running : =C2=A0Waiting for requests...
> [INFO ] : SWUPDATE running : =C2=A0[endupdate] : Swupdate *failed* !
>=20
>=20

--=20
Siemens AG, Technology
Linux Expert Center


