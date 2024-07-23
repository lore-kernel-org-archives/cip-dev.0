Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A68C3DA49
	for <webhook@archiver.kernel.org>; Tue, 23 Jul 2024 08:59:40 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.58])
 by mx.groups.io with SMTP id smtpd.web10.39865.1721725170768745916
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jul 2024 01:59:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=RD3VTsiE;
 spf=pass (domain: siemens.com, ip: 40.107.20.58, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGAsMzwl0o7cMpvqdDcTxRNe13+P5uKO+qQB2J5luy88diZP2+cxcGEVB97UisoLsU1M/hY6UqZhilW6foU/xAEoobfm6upD9JMqCwHHWHsDA2/8yfnMdB9+2lonXYVEKglL0Uiifm4gxF82/F6W3EOzaZ7ZwIRYi7NdLK79sn1xUZH2a6tweJDqHV/L5j3NEMLZi8TY5QWUO0jvh+d95SLvX9JIufPpilfPQioAmmQJqsXR/WPOLpBSp+wb8xThQq0Wo+waSeK9gMMJIPUWhyFr7uk/BqG8FlQyYuPidufB7UK1256tc0qs52OdhKHJD2BjLbgqU9VyrBS+N2z0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uN1pl1uPLTS+eOYBnAJdbT7FeoSynQJynHr9tQUSHt4=;
 b=cGt6OUNLiYa+Lv2tR8qwKEBJfN+Fkg2uG9hRVEb6/0Yksbq0SXEIB4H5cRD3Ruba3pDmdyOgeXAenCUIZyEVlUaDock05Ru9PybJnVYccFHyUmP/cvV8Fs/FzpmyTRkk70T8HPFA3mMW3ihvt52UYprO8tDVeAo1ki/6naaMgyyM7Ck/X924cMfqbqxlBT1AmOvLkHZlW6JxwvgEqHT+WapEyZAxyC5BPimh4GkdAKOMaSshTauezO+j+iecPVJ2k2eBrlxsctA4UPhhqYpIs9Ciym06LDRJTEK+9grwBvyNSEDVByYw8u+k+e2qK3Fwj0qrW1yAmWCnRXrnUDH6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN1pl1uPLTS+eOYBnAJdbT7FeoSynQJynHr9tQUSHt4=;
 b=RD3VTsiEi3HEzVqYxX8GqbZ/DWcHKQOZjKtBPTjaFO0egKz9aBNJFKv4vhV+U0CeMy60hMR6eiaGco+Xby0J0Ny6qx87XTuCRGE1ytaVd/QCIGIbOskO436CIqA6Ygi656lOt4AOyM5eDvdJEgznlaLa+rIgfV8sEHKDQDDiUUJ0QvYu9Fmk25GImNKxeY2pGwe4mGtEh40SZM9Q5JQBKg4JAT9qT6HWRLt6CDNDi488mXS76WaDPONqes/1ChO16hDYMgeSOZuL0lNW2/3fBJvTIEsxjfyLlLH02sWsQYZOiONxsM5ISKLLFVaBEUp3PkJEEhFrtVSPCSUHOFSeGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GV2PR10MB6137.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 23 Jul
 2024 08:59:27 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 08:59:27 +0000
Message-ID: <5117e9cc-2378-434f-8c3e-aebfad314313@siemens.com>
Date: Tue, 23 Jul 2024 10:59:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] wic/x86-uefi-efibootguard: correct the
 partition name
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Arjunan, Srinu (DI CTO FDS CES LX PBU 2)" <srinuvasan.a@siemens.com>
CC: "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
References: <20240718062455.9560-1-srinuvasan.a@siemens.com>
 <b6ecf38200a44b234becad864518c55ce49ce944.camel@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <b6ecf38200a44b234becad864518c55ce49ce944.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::16) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GV2PR10MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa5e952-761a-458e-6596-08dcaaf5c1ac
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?MnkE20tKHWONP81s57ajdAbpr2S8NMJhm2v2XS1V+m49zPBWqbRsArGMFEEM?=
 =?us-ascii?Q?qkfBibO+X8N12yw/rMu/moDBQHh26/bl3kSKwMrJ9qIh8JUQFYrL8ZcFl14+?=
 =?us-ascii?Q?M5cebkFi7UHi//k3G66Xjh2eEo16lFHz63YqfJdShwbgZbg8lSu5Zy0dGk+N?=
 =?us-ascii?Q?FOJ79iOeOA2uDoVydAvpCA6ts+XrwLEK7jfoWcISPF7pClrgPGgpUovF6PrD?=
 =?us-ascii?Q?NRsB+BchcNuxGDbuqhI+cW/hapvTQfhtoD+VvKl9eBOZLv37H2Rz3jiK4Hb1?=
 =?us-ascii?Q?tHUkc+k3wgYl1YFeDPP4Jc7S5B81DpqUq8eejGJh/8f+PU63mzVaucvTzwVb?=
 =?us-ascii?Q?7Srt83v5ABVX6itMFQzSf1Q47ipH9ct7ueqx7yT27odhEfxd2KnkmH2xVT4n?=
 =?us-ascii?Q?aj8/nvZoPqj/3DhsRXmwGIMu1WTXtoiiYGtY+Ei+y3P3kNnuO0Ip4leDfiwv?=
 =?us-ascii?Q?LCcKBaFbLLjiLelbelgsVk9Hc8xQKq0TXodVmwxs10PjjTWCMDaqs/sOLUHy?=
 =?us-ascii?Q?qrP4sSHdIucJy056cTWNfUvqe3S2iW+0kJ1yrEoXAoiAC1FkJLkFx+1ZGXY0?=
 =?us-ascii?Q?qLlZC3sSvWfU2jo3P6y4IrEfuLTaZFumJLF9FtGlZyNw11gMfqo8Z6p7uOf3?=
 =?us-ascii?Q?4pOqnMzjFeZFX8pg1SWTrKXN5Grs6MLKfN2/I6nGLrjvR3Iz0y6OXnnQk+oo?=
 =?us-ascii?Q?lFin/GxTUlmliUThEqkD8h/Sh0FmHUDY8MPwaorACgg/Qku6i8ychSh64AW5?=
 =?us-ascii?Q?XNTYgBhksgMVWipaxRepyr+Fflbdv3SrqjGu6oIljuEGP1csG1jkwbCOEXZR?=
 =?us-ascii?Q?5f+AFpfr+T46zvMPdjsYcemztz0Fgv9q45hrpjzIQ6LSORgwgQ604a9sK3+L?=
 =?us-ascii?Q?QifIFjAlA51AUTNSpwhvigB7YSZW2g3y/sljD1rJE5AUimhT9yPmrhrWApHJ?=
 =?us-ascii?Q?HOiPZ9RQewbe8iy19s6WcbTf2jT8sZlC14mpREb880XmhQnese2ITMbUYQaC?=
 =?us-ascii?Q?/b8Ub/g9ewhT94DvW6vlPtpdNED+fq5vTDOEF6hyfpPYyNjUp+6/2X8SCMxC?=
 =?us-ascii?Q?EykoXupGJHdydScsfGlnqiPquI4OjM8PuCzdLpct3zw+CWSnsb7fBwAgqEKx?=
 =?us-ascii?Q?bTBEyOP43JmTY19LZUc4pqr6LQ7J+DOOMl/ce/BC6VREh5h9pnUw1Lq0mBh0?=
 =?us-ascii?Q?HbmbCRzYUEnCqmJRJB+Lr5Hp1ZWNRhe2CTjh2Ze4ifPdURD3FFrt9TVGjrt0?=
 =?us-ascii?Q?No1Q81iIZ1uThbscqwWdKaDTFQEAkJyC/t20xXMY+nQJMHKb4FGFA6WtjB3e?=
 =?us-ascii?Q?mamOEUWb77dP9Pfi7kXExDwCyGI84ufuZgEl/mSXTxhTCQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?n/9rJiI46VDkjxTM2MQDD7Ex4GD9P2eXNQO47Shkm1iPABrzUcknK/9egM/i?=
 =?us-ascii?Q?DQe+IWbzpmKHKJPT/TnSo9ZAZiCOfBg279LEopEzt4KhpB1zFGPivaCoiynm?=
 =?us-ascii?Q?PB4Dxo+KpsHdWVWH4DixdjiJWOtfV/SFVKsBsXGi5ZPVclAJI1LiufEN2yFZ?=
 =?us-ascii?Q?eFE8UyZ3pVRKrknGPxd/BkBSTeQqn8JjVmzkRup/aqLtApdJbTDxRDdiW4Qm?=
 =?us-ascii?Q?ogMqumrvhBCeBf/NfZ3Y/VqVFhAj/1SOq8M9DbqhlZEID4LFHXmbok1oQWQ9?=
 =?us-ascii?Q?id4rwWvT8RCeZoxbiM6+sLpkOQQM6V0WSh9Fr9IodRE2A9ANusymlf62x0/2?=
 =?us-ascii?Q?Wjl26Jm+EE0liLVk3AUohDyN2MdNLEFpUK+2xDzS3p0xr2nSKHkwRE/X+xYL?=
 =?us-ascii?Q?EizlNvn20oRS9UPOtO1PZjIMnChfQ5D8+B1sSkEvSO0V9pkuFD31ZhgmmVM2?=
 =?us-ascii?Q?8R6R9BgMyhD6LbZC8+L+EG+e9/8YfRWXCfs5kbrLM2J17eWe10G8CPeDwgqw?=
 =?us-ascii?Q?z41MNJ5nqPjZeG7tOyFGyg2SZXdEksrVshWYz679XuLov1sm7L9DG1nfvbGq?=
 =?us-ascii?Q?JuC1DY3o9LhHe9Nmv2QEuAUuJzbRkXSlfvmhQwLHbS7kIA0CJvQXlcvZtdiI?=
 =?us-ascii?Q?2GrYzEsKc7nbw+mJZ2TgiftObQYWRoqZAQhj+X31TPLe6IwDWwwNWOm3npQ2?=
 =?us-ascii?Q?tAUvblW97ykbea945lJo3v11UOJtYJrEoGcR/CWccshOGTmSWzLqhrLH8oY2?=
 =?us-ascii?Q?7ePdFnrgkqe8Rk+xlR/LpKp6j6tTfoYuJQOXy1z/C+ddwo2GMCgaPrdM4wD+?=
 =?us-ascii?Q?Oh6TH3rTC2YOh+YkhM6JQ7YmEerm2fa0EaGahbDSCOnq9il+hZw9QOWf5EmZ?=
 =?us-ascii?Q?pPYziG+FEGetbzrihcvhDYRgZc/EXY6Id7+nDV4Izpq5bMbyLO/mrhDJg19A?=
 =?us-ascii?Q?jWgSwufyEHB4PiSuOC0jC/P2qiNI7NHZM8/7evFHjpEWSngjZd+AFq7lzI6+?=
 =?us-ascii?Q?whipzQPkRaUUgXTAgfZO3/z/WCj94mSP/mBc9uvDDZr+AgSDDP+IQFH7w0IK?=
 =?us-ascii?Q?Y8usrRhwupAwuRFZjVaWn1q1XQ8Vv6slbPnPe1P71PFas1pUCjycZZJG/xng?=
 =?us-ascii?Q?QoANP+aYi/WwHfxfWX/ASnRVPruDLRy0VwFSynQWkP4Rm3BsicqRQSeYnpzi?=
 =?us-ascii?Q?yL8kBKD6TT8SLpYsz9uWzvZpkuF5ld7DLILNpy6laafxRzYF2QtKl8hAGatT?=
 =?us-ascii?Q?OBUrjcCvcIWSvtLF9EGzyFJlJiB3ES0c5rsHQLEpP36Y2HlnX593iHaTJAO0?=
 =?us-ascii?Q?++hR74L+t9j3gqFY2gghJsiNWImRHwbhegJWIyUYmbSsCn9rq72+WzVCyNA7?=
 =?us-ascii?Q?nbsYVXmyGGIkqEJxcjrHWFdt52LATTc/qopAEY+lQKWhSgAK5DoF2Q/1NXVL?=
 =?us-ascii?Q?JGU8JhpdV5PTnSCqYfnE17NEFmYqGXhB91Kb2g56m4NKQwJzxQTpqr4rJu4h?=
 =?us-ascii?Q?jmFoO3Jr6IwqmqYXRXdMOlnUinT0IVrh04HIkwJKLkuNMU9fQnU0EoohNhib?=
 =?us-ascii?Q?3HOZTLiGYio9+6XGyFXzIxUb21Qg5+V9+t497BXVos8wtukJff2b4aPCeIUZ?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa5e952-761a-458e-6596-08dcaaf5c1ac
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 08:59:27.3810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OP4lRTjHNYYN5MJiTCN0/zbxIUcdjvCHK4a7ugg5ntPEPCFUhBoIGtIac9TVRTYui9Dre+GWZLb/hOLfgv1uCcmoQ1zUvaz5xpO4iPPOqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6137
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jul 2024 08:59:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16595



On 7/18/24 9:34 AM, Moessbauer, Felix (T CED OES-DE) wrote:
> On Thu, 2024-07-18 at 11:54 +0530, srinuvasan.a@siemens.com wrote:
>> From: Srinuvasan A <srinuvasan.a@siemens.com>
>>
>> Use the correct partition name for partition B.
>=20
> Wow... I'm surprised how that could stay undetected.
> Thanks for this fix!

We don't use the partition names anywhere :-D.
Quirin
>=20
> Anyways, I really recommend to not rely on partition labels, as they
> are not unique. Further, when building products, make sure to use fresh
> UUIDs for the partitions and not the default ones from CIP.
> IIRC, Quirin wanted to add a note about this to the docs.
>=20
> Felix
>=20
>>
>> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
>> ---
>>  =C2=A0wic/x86-uefi-efibootguard.wks.in | 2 +-
>>  =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-
>> efibootguard.wks.in
>> index 4c0484f..a1cebc1 100644
>> --- a/wic/x86-uefi-efibootguard.wks.in
>> +++ b/wic/x86-uefi-efibootguard.wks.in
>> @@ -4,7 +4,7 @@
>>  =C2=A0include ebg-sysparts.inc
>>  =20
>>  =C2=A0part --source rawcopy --sourceparams
>> "file=3D${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid
>> "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-
>> 3D69D8477DE4 --part-name systema
>> -part --source empty --align 1024 --fixed-size 1G --uuid
>> "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-
>> 3D69D8477DE4 --part-name systema
>> +part --source empty --align 1024 --fixed-size 1G --uuid
>> "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-
>> 3D69D8477DE4 --part-name systemb
>>  =20
>>  =C2=A0# home and var are extra partitions
>>  =20
>=20

