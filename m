Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B6FC47422
	for <webhook@archiver.kernel.org>; Mon, 29 Jan 2024 12:30:16 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.46])
 by mx.groups.io with SMTP id smtpd.web10.13572.1706531415206073456
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jan 2024 04:30:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=pZSCQ9ud;
 spf=pass (domain: siemens.com, ip: 40.107.104.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZEG02rbOJLz/uXW8tZX5zukZcZP05uyNALCnQou3S3Ti/vb/2GRuLzJYd+jJo4wNO4BOOFJ/zIGpixYB/VxibsDK0sr8xJAkABD0lHMSDlkvZNCGYY/Vh52Ix/cPhkXrdCf01d7qZiNFTdfvFOZYyU77DwLssCsyejgx/oiF/ZNFdztEl3IbngKSF5CrNVcKTnv/fO51UzXwXO1hua5dq96o/fH8vJt7F84ZAk/+1omjT1hD+xwW4cjcsTAC29xWuh89WwDNNEKSnR6IoTB1ZqM0S3h2a+J5hRb++g75/HkPsAT4EoKC8dWw6WRUF08HgJxxRu+wjkQBVDuOlVevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcZJZBIN6ae6CzZA/3Rzj5laNxBLAK81XNDP/90l5KY=;
 b=LsT1V9KRUvRAJ9yXeM69o7Npqz/vuz5/TRZ664+OgTL+wULed7LpB841oIlPQkiO05hUlwfRFw43MsYFeXElcanu+Yj/ujABlN+Mvxe7SslMVA7Y6x69gp+V2pIj+1gCUZErZBaO6ygK+840Y/FRthIk7fRh2kgAI9oqFCulzqdocdBc9b0LMhheQzBHgdSjbw4WtVl9fFi0dCapNyTfw5eN3ozgB1AOXnBe7bb3oAgZTZJTMYEibLmRjA2BcqAaOa+1F2eV52AIODLbdE8cAAk6ecc59ySsvLDRP7YbPqO4Dd4K5LEvGImnwKl3HQVPW0Gx+QSSznichlGaH5+3Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcZJZBIN6ae6CzZA/3Rzj5laNxBLAK81XNDP/90l5KY=;
 b=pZSCQ9uddsTcLApQ+A8UQnnHyUkRLW6/JZ7YGRPzR2uQi8LVCDmHgbo5mRvrBakNpAmmBLpBMr4tchRCdG9+uo0EOwRmQRuY08d9xuiCnqf8hnGO1h1QzQA1cvpmXdlbCMW3DuBM2dCl6JLd7JlHRlCghIlY59yjvyRJ5vnkBEvl25HL11JsbuNDJwTRW2v9jWp73s4Xk8RkReTYAhGUGLUhUx/WdL1z3tcGoXsKNjFIOfOAtusOI0hulVYzsKfWqw6RuLoZdIUXXbV6tq42r6GFAiKt2+Dnj2xCQroHzrU+flIt/HohwyUMLN5DHH5n/j3MbHciXkvFlITrygqh3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7358.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:446::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 12:30:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 12:30:08 +0000
Message-ID: <ef5c8484-26fc-48c7-919c-318cca4ab4c3@siemens.com>
Date: Mon, 29 Jan 2024 13:30:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1] wic: Set fixed partition UUID values
Content-Language: en-US
To: Adithya.Balakumar@toshiba-tsip.com, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
CC: Shivanand.Kunijadar@toshiba-tsip.com, Sai.Sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240122121502.2605116-1-Adithya.Balakumar@toshiba-tsip.com>
 <9e37cacb919c267894dc25a3cf99026b48fd7886.camel@siemens.com>
 <TYCPR01MB966912B6A25CDDAEEBE16DE0C47B2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TYCPR01MB966912B6A25CDDAEEBE16DE0C47B2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR14CA0026.namprd14.prod.outlook.com
 (2603:10b6:610:60::36) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: da71ef38-1e16-4261-870a-08dc20c60781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SZ5kWuDAtUsekWq2BL0gtSDMXwm+g401ER32FLYlXgHazZTlQHL0yIWXF0JL04GY0F9NKzy1TPRTsnxr0QpzDM8Jvhdhd5I9TtJWuH4TVPA1T7zz3Ytn649uHUN1HN1FExF4hINQ7Ls4PKLtNOj5kohbzTf3Ws5uySUwMDjASza6AseCw+XA9OxQG4aef9dRgVygl17sE9OuCi2bM5aSf5eAbqIoGK4iB+qeepmxSToQo6tyu+BsVfhSBb2WpBOCjBWty/cJDgLHwOnXBztw/VksWNeRW+hbdOJ2+0kmFW9HmaYT/U1EQof8T0MKXO9lW1VO3CVOp/f3lefH9Mi0ZJZKhkBg2fvfT0SKbVCAUQOMeZDBQ69F56ArGG/7561lUxJSFzNSImKjH3tltziFrNgo5kS/P8vhWMgM9DCJ1R/ysixfJsw5MJ/7J4/J4qnXD2khEgBpmJ4mC5bsgd1qpFi3m6KXzaM4Bga0R3kTf+X2D40zJIsT5gb2gIN8CJkzDgJLVIMFN6uzxG/fsYRLJrQ1CuE2IS4VJs9Cg2/uUI092iuWR9OvlyLxEZNfvPbMt+Kwjt6ahbVakskEQGi8JP2v06Xlu5vVcttDynP0qz35tztVbnGvZIWb8OUgGhYAg4s9+g/vNT/BQVmEmSypPU6MRLGj5u0ECp0rzphcTz8PLQisXg+jJal5Ip1EpIor
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(8676002)(66476007)(66946007)(66556008)(4326008)(8936002)(316002)(26005)(83380400001)(31686004)(478600001)(82960400001)(6666004)(31696002)(38100700002)(6486002)(86362001)(30864003)(2906002)(5660300002)(44832011)(6512007)(2616005)(6506007)(53546011)(36756003)(41300700001)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8hBglC0GU79KaetFBF69evfuD/xl/XTgokPFnAMlCddK8JB+HJsVoYEjKDNE?=
 =?us-ascii?Q?I1MKU9iBDuYYaUEkD3xCZsKzXEUr1uM1IVtCiGtv+9x4CHkrCEWiBENnwuGA?=
 =?us-ascii?Q?p9tDwmwuQjVebL7l7zB0XBRfnSWCmlbIjUe8MUikydBKaiNBncfaSP+1eR5/?=
 =?us-ascii?Q?oTYPnAZN9qxR2v5uUmGAR1o+/QTDa4SYvrju/HUmImUztfWFr2p8SJCsk0Hf?=
 =?us-ascii?Q?Yb06s0W0SoU1CjCijlEo523JZaxwOArK8nRi9g8VNYe41pRC74ZYPD5vkdNH?=
 =?us-ascii?Q?ySgecEEmSdP94F/D7EtnD8BQ2hoCFRxb25LpGURqQEoy1q0Yjr/p03Zqppa+?=
 =?us-ascii?Q?VKYcLVkOxHQ+EB2AZvZnPD4fRkn396dQ22hpsXoiek7ahPErrEIqFZyuMVX4?=
 =?us-ascii?Q?fxkgg7MWwhLbIWVBw5+ym1yL4ZhEHuK3Y+Ul46/wyxt4UbDOoCLgrVWgycw9?=
 =?us-ascii?Q?s0w5jL/cyhdAwZu/5Q2jR8BAbGjoasAl39ifL30q4uZ8UmT6EtaAOo30Lr1w?=
 =?us-ascii?Q?pYmqXAs29jukwoBZwLxsEEWqFcG+TxGsO3bDuKX8OFz+YMU8oFOyB3lFbic9?=
 =?us-ascii?Q?UI2nNdsQWCwUm6A0YjtimQwK7On1KDKSPIXydxvFaQrZT7cFEX5wbtVhZQWC?=
 =?us-ascii?Q?3hhgKA7jZiPurIJLoEUpb9b2vPhNrIv3VfjCUciRpfHWZCZJABVuwNzPYIsF?=
 =?us-ascii?Q?3jDOgt9o2x81R9LXc0ztl38SvRDwWB2GCrZjkv6mLLt4gQ+VHhj+pH9dLB27?=
 =?us-ascii?Q?GCybQxmcyI5/GrDmbnSEH6jRz7jNHFd9IeBFID+rMnPpjVhr9m8XpC36+mWM?=
 =?us-ascii?Q?p3uLCSOguYwXdBH4X4z9Noq6mhtqT7ERslqhSLEN4znk4uv2qH9OxNC9dLWI?=
 =?us-ascii?Q?nY6YDPIwg3M1AuE2NaPhJlXxccdw2uJRQlebGBVZ6Wr74Iy1/ZHVSPAlOzTG?=
 =?us-ascii?Q?TKBTQfNihfZDX8cGNiZd279iESQyjkPIU+jb6/8/puDrrZieVCvGC8QuBObU?=
 =?us-ascii?Q?X8BRGbHhPYGxXuhxSOV1ICK+0kFqHLxbgds3emhlJJOeXqTdOe0kxglVaMdr?=
 =?us-ascii?Q?U8p8IMoznbNrBqk84ekHAKxx+0E/9KuFo4FedQ2Ak8MO65z/opU5yy+suEKP?=
 =?us-ascii?Q?f7Oi8xEvUPjfUnFrhsSBkoLmSl9UVc7gKf+8ycC2JO1vuGyAPQYHGYZu9Uzc?=
 =?us-ascii?Q?f72txWTkfUq81SjkIou1oajaVyhOftNcnX1m7xtcIGUmk05YtGbAnmB5cHc9?=
 =?us-ascii?Q?nujmbf36HzFIYYVNngmqXcRlFBaQ2r2mzS0UALW3nSk11R15Yl+v7REfXkG+?=
 =?us-ascii?Q?NO3uceBOLh02wr9vJ6pPZ3CebNKelXwsiR7b4Uj+HWxLXCVvDPInTdfow4ED?=
 =?us-ascii?Q?hcT1jp/NqvnT4xEkn8ARhEXh8m9sCl04T9itL4RxXEHW6q99PIHtzvQriclY?=
 =?us-ascii?Q?mAel01/AzAp0LWpzcOgtPtZ/HGX9hVkjDLaLHDlfvGew+QLCfD52q2zL5qRa?=
 =?us-ascii?Q?7Bk/UIT0wuPzgFjp7BOpDCB2KJCvPdZ/UQ78Pjeoh6Qfs4sBC7PgTwv8nu6X?=
 =?us-ascii?Q?abU1zKfFY3AuJSxw78c8Qkul3m/FFhrTZKg9oenqsLpmFsfE0RfW3FA8SJIJ?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da71ef38-1e16-4261-870a-08dc20c60781
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 12:30:08.3303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wnlWiVdxl1FRlnU8MzPP3R+oThUw75XcrYtQrXajwN7p4S7StMOCAOmlQ3Z151ljT/j+7SCOYYhwPznLXdVSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7358
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jan 2024 12:30:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14479

On 24.01.24 07:03, Adithya.Balakumar@toshiba-tsip.com wrote:
> Hi Felix,
>=20
> Thanks for your comment. Will send out a v2 of the patch. I would like to=
 ask a small clarification about your comments?=20
>=20

If v2 should still be part of the 1.3 release (I would consider this as
fix, not as feature), please send it soon.

Jan

> As for the part "Can we please use unique UUIDs across all devices (not a=
lways the same).", I understand this. Will set unique UUIDs across all devi=
ces.
>=20
> However, could you please elaborate on the second part of your comment:=20
> "Also it would be nice to add a note somewhere that these UUIDs should be=
 changed in case the user creates an image for flashing and one for the tar=
get (which is quite common). Here, the UUIDs would collide."
>=20
> Thanks and Regards,
> Adithya Balakumar
>=20
> -----Original Message-----
> From: MOESSBAUER, Felix <felix.moessbauer@siemens.com>=20
> Sent: Tuesday, January 23, 2024 3:02 PM
> To: cip-dev@lists.cip-project.org; balakumar adithya(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0 TEUR) <Adithya.Balakumar@toshiba-tsip.com>; Kiszka, Jan =
<jan.kiszka@siemens.com>
> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Po=
rting) <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=
=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=
=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <dinesh.kumar@toshiba-=
tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=
=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=
=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.c=
o.jp>
> Subject: Re: [isar-cip-core][PATCH v1] wic: Set fixed partition UUID valu=
es
>=20
> On Mon, 2024-01-22 at 17:45 +0530, Adithya Balakumar wrote:
>> From: Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
>>
>> This commit sets fixed partition uuid for partitions. The --uuid=20
>> option in wic allows to set fixed uuid for a partition. This is=20
>> required for generating reproducible images.
>=20
> Thanks for this patch. Just a minor note:
>=20
> Can we please use unique UUIDs across all devices (not always the same). =
Also it would be nice to add a note somewhere that these UUIDs should be ch=
anged in case the user creates an image for flashing and one for the target=
 (which is quite common). Here, the UUIDs would collide.
>=20
> Felix
>=20
>>
>> Signed-off-by: Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
>> ---
>> =C2=A0wic/bbb-efibootguard.wks.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 +=
+--
>> =C2=A0wic/bbb.wks=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 2 +-
>> =C2=A0wic/ebg-signed-sysparts.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +=
++---
>> =C2=A0wic/ebg-sysparts.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
>> =C2=A0wic/hihope-rzg2m-efibootguard.wks.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>> =C2=A0wic/hihope-rzg2m.wks=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>> =C2=A0wic/iwg20m.wks=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>> =C2=A0wic/qemu-amd64-efibootguard-secureboot.wks.in | 4 ++--
>> =C2=A0wic/qemu-arm64-efibootguard-secureboot.wks.in | 4 ++--
>> =C2=A0wic/qemu-arm64-efibootguard.wks.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>> =C2=A0wic/qemu-riscv64-efibootguard.wks.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>> =C2=A0wic/x86-efibootguard.wks.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 +=
+--
>> =C2=A0wic/x86_64-generic.wks=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>> =C2=A013 files changed, 27 insertions(+), 27 deletions(-)
>>
>> diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-=20
>> efibootguard.wks.in index 48789c7..123f86b 100644
>> --- a/wic/bbb-efibootguard.wks.in
>> +++ b/wic/bbb-efibootguard.wks.in
>> @@ -15,7 +15,7 @@ part --source rawcopy --sourceparams=20
>> "file=3D${IMAGE_FULLNAME}.squashfs" --align 1
>> =C2=A0part --source empty --align 1024 --fixed-size 1G --uuid=20
>> "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-
>> 3D69D8477DE4
>> =C2=A0
>> =C2=A0# home and var are extra partitions
>> -part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home --
>> fstype=3Dext4 --label home --align 1024=C2=A0 --size 1G --fsuuid 1f55d66=
a-
>> 40d8-11ee-be56-0242ac120002
>> -part /var --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var --
>> fstype=3Dext4 --label var --align 1024=C2=A0 --size 2G --fsuuid 96be3374=
-
>> 4258-11ee-be56-0242ac120002
>> +part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home --
>> fstype=3Dext4 --label home --align 1024=C2=A0 --size 1G --fsuuid 1f55d66=
a-
>> 40d8-11ee-be56-0242ac120002 --uuid abcdd66a-40d8-11ee-be56-
>> 0242ac120002
>> +part /var --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var --
>> fstype=3Dext4 --label var --align 1024=C2=A0 --size 2G --fsuuid 96be3374=
-
>> 4258-11ee-be56-0242ac120002 --uuid 12343374-4258-11ee-be56-
>> 0242ac120002
>> =C2=A0
>> =C2=A0bootloader --ptable gpt --append=3D"rootwait console=3DttyO0,11520=
0
>> omap_wdt.early_enable=3D1 omap_wdt.nowayout=3D1=20
>> watchdog.handle_boot_enabled=3D0"
>> diff --git a/wic/bbb.wks b/wic/bbb.wks index a797e95..03939b4 100644
>> --- a/wic/bbb.wks
>> +++ b/wic/bbb.wks
>> @@ -9,6 +9,6 @@
>> =C2=A0part --source rawcopy --sourceparams "file=3D/usr/lib/u-boot/bbb/M=
LO"
>> --no-table --align 128
>> =C2=A0part --source rawcopy --sourceparams "file=3D/usr/lib/u-boot/bbb/u=
-=20
>> boot.img" --no-table --align 384
>> =C2=A0
>> -part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-=20
>> extraopts "-T default" --label platform --align 1024 --active --=20
>> fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
>> +part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-
>> extraopts "-T default" --label platform --align 1024 --active --=20
>> fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid abcdd66a-40d8-
>> 11ee-be56-0242ac120002
>> =C2=A0
>> =C2=A0bootloader --append "rootwait console=3DttyO0,115200"
>> diff --git a/wic/ebg-signed-sysparts.inc b/wic/ebg-signed-=20
>> sysparts.inc index b2340e2..0c339fc 100644
>> --- a/wic/ebg-signed-sysparts.inc
>> +++ b/wic/ebg-signed-sysparts.inc
>> @@ -1,8 +1,8 @@
>> =C2=A0# default partition layout EFI Boot Guard usage, signed version
>> =C2=A0
>> =C2=A0# EFI partition containing efibootguard bootloader binary -part=20
>> --source efibootguard-efi=C2=A0 --size 16M --extra-space 0 --=20
>> overhead-factor 1 --label efi=C2=A0=C2=A0 --align 1024 --part-type=3DEF0=
0 --=20
>> active --sourceparams "signwith=3D/usr/bin/sign_secure_image.sh" --=20
>> fsuuid 0x4321dcba
>> +part --source efibootguard-efi=C2=A0 --size 16M --extra-space 0 --
>> overhead-factor 1 --label efi=C2=A0=C2=A0 --align 1024 --part-type=3DEF0=
0 --=20
>> active --sourceparams "signwith=3D/usr/bin/sign_secure_image.sh" --=20
>> fsuuid 0x4321dcba --uuid 0x5678dcba
>> =C2=A0
>> =C2=A0# EFI Boot Guard environment/config partitions plus Kernel files=20
>> -part --source efibootguard-boot --size 32M --extra-space 0 --=20
>> overhead-factor 1 --label BOOT0 --align 1024 --part-type=3D0700 --=20
>> sourceparams "revision=3D2,signwith=3D/usr/bin/sign_secure_image.sh" --=
=20
>> fsuuid 0x4321dcbb -part --source efibootguard-boot --size 32M=20
>> --extra-space 0 -- overhead-factor 1 --label BOOT1 --align 1024=20
>> --part-type=3D0700 -- sourceparams=20
>> "revision=3D1,signwith=3D/usr/bin/sign_secure_image.sh" -- fsuuid=20
>> 0x4321dcbc
>> +part --source efibootguard-boot --size 32M --extra-space 0 --
>> overhead-factor 1 --label BOOT0 --align 1024 --part-type=3D0700 --=20
>> sourceparams "revision=3D2,signwith=3D/usr/bin/sign_secure_image.sh" --=
=20
>> fsuuid 0x4321dcbb --uuid 0x5678dcbb
>> +part --source efibootguard-boot --size 32M --extra-space 0 --
>> overhead-factor 1 --label BOOT1 --align 1024 --part-type=3D0700 --=20
>> sourceparams "revision=3D1,signwith=3D/usr/bin/sign_secure_image.sh" --=
=20
>> fsuuid 0x4321dcbc --uuid 0x5678dcbc diff --git a/wic/ebg-sysparts.inc=20
>> b/wic/ebg-sysparts.inc index 300c36f..beb0903 100644
>> --- a/wic/ebg-sysparts.inc
>> +++ b/wic/ebg-sysparts.inc
>> @@ -1,8 +1,8 @@
>> =C2=A0# default partition layout EFI Boot Guard usage
>> =C2=A0
>> =C2=A0# EFI partition containing efibootguard bootloader binary -part=20
>> --source efibootguard-efi=C2=A0 --size 16M --extra-space 0 --=20
>> overhead-factor 1 --label efi=C2=A0=C2=A0 --align 1024 --part-type=3DEF0=
0 --=20
>> active --fsuuid 0x4321dcba
>> +part --source efibootguard-efi=C2=A0 --size 16M --extra-space 0 --
>> overhead-factor 1 --label efi=C2=A0=C2=A0 --align 1024 --part-type=3DEF0=
0 --=20
>> active --fsuuid 0x4321dcba --uuid 0x5678dcba
>> =C2=A0
>> =C2=A0# EFI Boot Guard environment/config partitions plus Kernel files=20
>> -part --source efibootguard-boot --size 32M --extra-space 0 --=20
>> overhead-factor 1 --label BOOT0 --align 1024 --part-type=3D0700 --=20
>> sourceparams "revision=3D2" --fsuuid 0x4321dcbb -part --source=20
>> efibootguard-boot --size 32M --extra-space 0 -- overhead-factor 1=20
>> --label BOOT1 --align 1024 --part-type=3D0700 -- sourceparams=20
>> "revision=3D1" --fsuuid 0x4321dcbc
>> +part --source efibootguard-boot --size 32M --extra-space 0 --
>> overhead-factor 1 --label BOOT0 --align 1024 --part-type=3D0700 --=20
>> sourceparams "revision=3D2" --fsuuid 0x4321dcbb --uuid 0x5678dcbb
>> +part --source efibootguard-boot --size 32M --extra-space 0 --
>> overhead-factor 1 --label BOOT1 --align 1024 --part-type=3D0700 --=20
>> sourceparams "revision=3D1" --fsuuid 0x4321dcbc --uuid 0x5678dcbc diff=20
>> --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-=20
>> efibootguard.wks.in index 2ac8850..38581dd 100644
>> --- a/wic/hihope-rzg2m-efibootguard.wks.in
>> +++ b/wic/hihope-rzg2m-efibootguard.wks.in
>> @@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --=20
>> uuid "${ABROOTFS_PART_UUID_B}
>> =C2=A0
>> =C2=A0# home and var are extra partitions
>> =C2=A0
>> -part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home --
>> fstype=3Dext4 --label home --align 1024=C2=A0 --size 1G --extra-space=3D=
100M -=20
>> -fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
>> -part /var --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var --
>> fstype=3Dext4 --label var --align 1024=C2=A0 --size 2G --extra-space=3D1=
00M --=20
>> fsuuid 96be3374-4258-11ee-be56-0242ac120002
>> +part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home --
>> fstype=3Dext4 --label home --align 1024=C2=A0 --size 1G --extra-space=3D=
100M -=20
>> -fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid abcdd66a-40d8-
>> 11ee-be56-0242ac120002
>> +part /var --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var --
>> fstype=3Dext4 --label var --align 1024=C2=A0 --size 2G --extra-space=3D1=
00M --=20
>> fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 12343374-4258-
>> 11ee-be56-0242ac120002
>> =C2=A0
>> =C2=A0bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttySC=
0,115200=20
>> rootwait earlyprintk"
>> diff --git a/wic/hihope-rzg2m.wks b/wic/hihope-rzg2m.wks index=20
>> fd3a338..1bb8ced 100644
>> --- a/wic/hihope-rzg2m.wks
>> +++ b/wic/hihope-rzg2m.wks
>> @@ -9,7 +9,7 @@
>> =C2=A0# SPDX-License-Identifier: MIT
>> =C2=A0#
>> =C2=A0
>> -part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat=20
>> --label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba
>> +part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat
>> --label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba=20
>> --uuid 0x5678dcba
>> =C2=A0
>> =C2=A0# Rootfs partition
>> -part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root -=20
>> -align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-
>> 0242ac120002
>> +part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root -
>> -align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-
>> 0242ac120002 --uuid abcdd66a-40d8-11ee-be56-0242ac120002
>> diff --git a/wic/iwg20m.wks b/wic/iwg20m.wks index 85765f0..feea21e=20
>> 100644
>> --- a/wic/iwg20m.wks
>> +++ b/wic/iwg20m.wks
>> @@ -12,7 +12,7 @@
>> =C2=A0# [Note] u-boot runs from an SPI memory device
>> =C2=A0
>> =C2=A0# SDCard Boot partition (copies files in IMAGE_BOOT_FILES: zImage =
and=20
>> device tree) -part /boot --source bootimg-partition --ondisk mmcblk0=20
>> --fstype vfat --label boot --align 1 --size 32M --extra-space 0=20
>> --fsuuid 0x4321dcba
>> +part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat
>> --label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba=20
>> --uuid 0x5678dcba
>> =C2=A0
>> =C2=A0# Rootfs partition
>> -part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root -=20
>> -align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-
>> 0242ac120002
>> +part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root -
>> -align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-
>> 0242ac120002 --uuid abcdd66a-40d8-11ee-be56-0242ac120002
>> diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in
>> b/wic/qemu-amd64-efibootguard-secureboot.wks.in
>> index 2e5cb39..03c715b 100644
>> --- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
>> +++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
>> @@ -4,7 +4,7 @@ part --source rawcopy --sourceparams=20
>> "file=3D${IMAGE_FULLNAME}.verity" --align 102
>> =C2=A0part --source empty --align 1024 --fixed-size 1G --uuid=20
>> "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-
>> 3D69D8477DE4
>> =C2=A0
>> =C2=A0# home and var are extra partitions
>> -part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home --
>> fstype=3Dext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-
>> 40d8-11ee-be56-0242ac120002
>> -part /var=C2=A0 --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var=C2=
=A0 --
>> fstype=3Dext4 --label var=C2=A0 --align 1024 --size 2G --fsuuid 96be3374=
-
>> 4258-11ee-be56-0242ac120002
>> +part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home --
>> fstype=3Dext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-
>> 40d8-11ee-be56-0242ac120002 --uuid abcdd66a-40d8-11ee-be56-
>> 0242ac120002
>> +part /var=C2=A0 --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var=C2=
=A0 --
>> fstype=3Dext4 --label var=C2=A0 --align 1024 --size 2G --fsuuid 96be3374=
-
>> 4258-11ee-be56-0242ac120002 --uuid 12343374-4258-11ee-be56-
>> 0242ac120002
>> =C2=A0
>> =C2=A0bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttyS0=
,115200=20
>> rootwait earlyprintk watchdog.handle_boot_enabled=3D0
>> iTCO_wdt.nowayout=3D1 panic=3D5"
>> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in
>> b/wic/qemu-arm64-efibootguard-secureboot.wks.in
>> index 2fc389c..ede1fd5 100644
>> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
>> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
>> @@ -4,7 +4,7 @@ part --source rawcopy --sourceparams=20
>> "file=3D${IMAGE_FULLNAME}.verity" --align 102
>> =C2=A0part --source empty --align 1024 --fixed-size 1G --uuid=20
>> "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-
>> 3D69D8477DE4
>> =C2=A0
>> =C2=A0# home and var are extra partitions
>> -part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home --
>> fstype=3Dext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-
>> 40d8-11ee-be56-0242ac120002
>> -part /var=C2=A0 --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var=C2=
=A0 --
>> fstype=3Dext4 --label var=C2=A0 --align 1024 --size 2G --fsuuid 96be3374=
-
>> 4258-11ee-be56-0242ac120002
>> +part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home --
>> fstype=3Dext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-
>> 40d8-11ee-be56-0242ac120002 --uuid abcdd66a-40d8-11ee-be56-
>> 0242ac120002
>> +part /var=C2=A0 --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var=C2=
=A0 --
>> fstype=3Dext4 --label var=C2=A0 --align 1024 --size 2G --fsuuid 96be3374=
-
>> 4258-11ee-be56-0242ac120002 --uuid 12343374-4258-11ee-be56-
>> 0242ac120002
>> =C2=A0
>> =C2=A0bootloader --ptable gpt --append=3D"panic=3D5"
>> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-=20
>> efibootguard.wks.in index 1f50ba3..bf58e1c 100644
>> --- a/wic/qemu-arm64-efibootguard.wks.in
>> +++ b/wic/qemu-arm64-efibootguard.wks.in
>> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams=20
>> "file=3D${IMAGE_FULLNAME}.squashfs" --align 1
>> =C2=A0part --source empty --align 1024 --fixed-size 1G --uuid=20
>> "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-
>> 3D69D8477DE4
>> =C2=A0
>> =C2=A0# home and var are extra partitions
>> -part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home --
>> fstype=3Dext4 --label home --align 1024=C2=A0 --size 1G --fsuuid 1f55d66=
a-
>> 40d8-11ee-be56-0242ac120002
>> -part /var --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var --
>> fstype=3Dext4 --label var --align 1024=C2=A0 --size 2G --fsuuid 96be3374=
-
>> 4258-11ee-be56-0242ac120002
>> +part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home --
>> fstype=3Dext4 --label home --align 1024=C2=A0 --size 1G --fsuuid 1f55d66=
a-
>> 40d8-11ee-be56-0242ac120002 --uuid abcdd66a-40d8-11ee-be56-
>> 0242ac120002
>> +part /var --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var --
>> fstype=3Dext4 --label var --align 1024=C2=A0 --size 2G --fsuuid 96be3374=
-
>> 4258-11ee-be56-0242ac120002 --uuid 12343374-4258-11ee-be56-
>> 0242ac120002
>> =C2=A0
>> =C2=A0bootloader --ptable gpt
>> diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-=20
>> efibootguard.wks.in index 9158aa4..b37c971 100644
>> --- a/wic/qemu-riscv64-efibootguard.wks.in
>> +++ b/wic/qemu-riscv64-efibootguard.wks.in
>> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams=20
>> "file=3D${IMAGE_FULLNAME}.squashfs" --align 1
>> =C2=A0part --source empty --align 1024 --fixed-size 1G --uuid=20
>> "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-
>> 3D69D8477DE4
>> =C2=A0
>> =C2=A0# home and var are extra partitions
>> -part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home --
>> fstype=3Dext4 --label home --align 1024=C2=A0 --size 1G --fsuuid 1f55d66=
a-
>> 40d8-11ee-be56-0242ac120002
>> -part /var --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var --
>> fstype=3Dext4 --label var --align 1024=C2=A0 --size 2G --fsuuid 96be3374=
-
>> 4258-11ee-be56-0242ac120002
>> +part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home --
>> fstype=3Dext4 --label home --align 1024=C2=A0 --size 1G --fsuuid 1f55d66=
a-
>> 40d8-11ee-be56-0242ac120002 --uuid abcdd66a-40d8-11ee-be56-
>> 0242ac120002
>> +part /var --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var --
>> fstype=3Dext4 --label var --align 1024=C2=A0 --size 2G --fsuuid 96be3374=
-
>> 4258-11ee-be56-0242ac120002 --uuid 12343374-4258-11ee-be56-
>> 0242ac120002
>> =C2=A0
>> =C2=A0bootloader --ptable gpt
>> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-=20
>> efibootguard.wks.in index 98e8da5..b002ea5 100644
>> --- a/wic/x86-efibootguard.wks.in
>> +++ b/wic/x86-efibootguard.wks.in
>> @@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --=20
>> uuid "${ABROOTFS_PART_UUID_B}
>> =C2=A0
>> =C2=A0# home and var are extra partitions
>> =C2=A0
>> -part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home --
>> fstype=3Dext4 --label home --align 1024=C2=A0 --size 1G --extra-space=3D=
100M -=20
>> -fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
>> -part /var --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var --
>> fstype=3Dext4 --label var --align 1024=C2=A0 --size 2G --extra-space=3D1=
00M --=20
>> fsuuid 96be3374-4258-11ee-be56-0242ac120002
>> +part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home --
>> fstype=3Dext4 --label home --align 1024=C2=A0 --size 1G --extra-space=3D=
100M -=20
>> -fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid abcdd66a-40d8-
>> 11ee-be56-0242ac120002
>> +part /var --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var --
>> fstype=3Dext4 --label var --align 1024=C2=A0 --size 2G --extra-space=3D1=
00M --=20
>> fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 12343374-4258-
>> 11ee-be56-0242ac120002
>> =C2=A0
>> =C2=A0bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttyS0=
,115200=20
>> rootwait earlyprintk watchdog.handle_boot_enabled=3D0
>> iTCO_wdt.nowayout=3D1 "
>> diff --git a/wic/x86_64-generic.wks b/wic/x86_64-generic.wks index=20
>> 1a44e26..a63f7f3 100644
>> --- a/wic/x86_64-generic.wks
>> +++ b/wic/x86_64-generic.wks
>> @@ -6,8 +6,8 @@
>> =C2=A0# SPDX-License-Identifier: MIT
>> =C2=A0#
>> =C2=A0
>> -part /boot --source bootimg-efi-isar --sourceparams "loader=3Dgrub-=20
>> efi" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba
>> +part /boot --source bootimg-efi-isar --sourceparams "loader=3Dgrub-
>> efi" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba --=20
>> uuid 0x5678dcba
>> =C2=A0
>> -part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" -=20
>> -label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-
>> 0242ac120002
>> +part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" -
>> -label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-
>> 0242ac120002 --uuid abcdd66a-40d8-11ee-be56-0242ac120002
>> =C2=A0
>> =C2=A0bootloader --ptable gpt --timeout 2 --append "console=3DttyS0,1152=
00"
>=20
> --
> Siemens AG, Technology
> Linux Expert Center
>=20
>=20

--=20
Siemens AG, Technology
Linux Expert Center


