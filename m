Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE558D6408F
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 08:24:24 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9739.1765959859881384993
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 00:24:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=daD1nJzY;
 spf=pass (domain: siemens.com, ip: 40.107.159.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3SfnJ98A2bGl0C711JjNOPmoO3yJodLxFsWiAGPi4Nedj3ngiE9k7Vd/hF3vwrK37cSWalaFt+2+gQ7SQSvegnD3NJttLfgb60W/Yz81st9+WxkjavCv5wkGdehanqpfQ9KGgz++887xQS1mknJVXVAuzR+zfYYE5eTdFhjX1A57SSKCnWluqcT7HbHrQ7xUWM1oKPvl5lqGtVVbCbROa780zpnyrcr/0Z0KHJZjKoUwkSrvBZ63JT+xZd6+x3Cfxf4t3B50NYFHgGQHuwtbj+IGs6bVS4cMUDSWjngiZMohyRFdSM8BjGsrzUc9krp+myik4N8vHGtGp1t/do1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loAgPjqyoi4zi0pOp/7ZhjrTUpmrxrojRDKs0rofvRg=;
 b=iz0YKedFZObaeX1cWTgUMMeS2Es4qsEl60npGZd+juA/ZUQPumVCexR3y0ibsPVZsAxmJgNNN8jwDKDikJUdVTWQHVl/L3XHGNJsIWzI+2ei7hHdGbTiOG4uNkiLV2EeNDHlcxD/bZZb7FatUg+HBXzRClAI3MJ3fnJSrCrvI6GAA98TRu5OvaMs8eLt1/nsCNSYphV9L+jEZNaCCOill8zh5bY6AiXGH6QJacTZyHprKXcBVGT6zxlZZGAkJ7H1GzkDIsA28F2X/+UjLhANbGb2kBBD8YOrDanY/BlYwp6+qZNjC88Qv3aq8ijznIcQ7/gpe70lBdH/YDYkrVSjvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loAgPjqyoi4zi0pOp/7ZhjrTUpmrxrojRDKs0rofvRg=;
 b=daD1nJzYGjvznNQ8VWYPOTCHwziiZu4nuyfGT9qTAoslEq47MCqvpIvGZPHDoSXAD0Z4SvQ0PdcvhU9HVjh6DMzjKd/lP5uQ7Wug32WcHFzoEbMAQ6G+4v83tYMszBlg97+JH11nroVblgz58q/oDnpz6iwGzJa70CAI9sVh/gt9o9lJ+y2iaG24QfCgSvEI7RXRlsz6u0gnPI6mzqqzHlKJ6wyWapqv7Ck69756xdRGH3+MFc4iw5D3m4th6l1/A3TBZBnSV5PCvlzOZQmEauf4BtaftMpUiGVekHRoF8cIA3EAZkAHjHcpPf6jAkqLPPjsJe3LPg0j6O/U6CyIQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5443.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 08:24:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 08:24:14 +0000
Message-ID: <beccb2a1-431a-4323-a039-b43e2f8ed1ca@siemens.com>
Date: Wed, 17 Dec 2025 09:24:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC][PATCH] Remove support for building
 KernelCI images
To: nobuhiro.iwamatsu.x90@mail.toshiba, Chris.Paterson2@renesas.com,
 iwamatsu@gmail.com
CC: cip-dev@lists.cip-project.org, arisu.tachibana@miraclelinux.com
References: <5a48c2d2-2699-44a2-89ef-c44ef1c9ca38@siemens.com>
 <OSZPR01MB812347C7FA70D10AE6C7D096B7AFA@OSZPR01MB8123.jpnprd01.prod.outlook.com>
 <CACe6DC7J75AYUkgW1RGWOd1A3y5oS_Y1LQe1TPvb=ZEGX3PBDA@mail.gmail.com>
 <OSZPR01MB8123C821438DC9ADE3D79479B7AAA@OSZPR01MB8123.jpnprd01.prod.outlook.com>
 <TY7PR01MB14818FA909C360802A421C4E0CDABA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY7PR01MB14818FA909C360802A421C4E0CDABA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0396.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5443:EE_
X-MS-Office365-Filtering-Correlation-Id: cd280565-16ba-46e5-0b54-08de3d45a9cd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vtfbUJpvz1XdtXBVBFZaIX1jhthJl4dxh/YIspEdkJezjrVKBB7iEPxYteZe?=
 =?us-ascii?Q?zPYf2BG6AQfbgI9waXiXrWt+FILLnTVrJm+jvJ3AFOXyVLPeZCIwLWLRY9Lp?=
 =?us-ascii?Q?3oYS7lay0YQE/+kQBz+sZbvWTK6RMgBLmgu9732uX4C1eNKbirbBOMkwzrCx?=
 =?us-ascii?Q?qkg239zYbt0/juET2aFL4XkELBoAxnRG0X5Pg29L+Z0JzcFCAlo6JH8tRdo6?=
 =?us-ascii?Q?0e9rnxVqBFs+v5bCtq5SNMxJ8ivwbFvY11Vabe9EHFTked9QBohHxy5uQjxV?=
 =?us-ascii?Q?tjhTeHuRaGXFnHYXsgcgBLwPzoq2dGSXxjgwwT/SWmhueiV3FRvFWwOtMSDq?=
 =?us-ascii?Q?MISnhnFq4TpBpdrvrxzjymmLFc2yEx6YkXnyKz7IhoBwY2Jk+Ddir0yppQ0/?=
 =?us-ascii?Q?wBmPZmEI9Q3ruJErw7hepdpuJ743GHadzn93kxDp12O66dWWX3KgySZWJG6d?=
 =?us-ascii?Q?rhHqtTgHcCzBPGJ9+dR+PU8sxHUkshDglMcKjfUf4ufQ7jpYuEmp2onrSkWw?=
 =?us-ascii?Q?Ql7c/uoy9BJJ8bXkXR7h2BJ3VYx9G+1Dz2zstxYXsjk9gdG+tDf7iJI8G6dh?=
 =?us-ascii?Q?bKPp7l4e+iTCjyEYyRssklnfZ8ycGnfu2L7Isq/ZA+18PezEVLoxxSl03HN+?=
 =?us-ascii?Q?hivwRIZXsSV2ne5xcoZfgaK4TxbqH7BexoCXFmgOHydOpbcsEmSM6P9RhfMs?=
 =?us-ascii?Q?mHEeG6Ar6HYYviEzrEQscQ8qiRcy1m95lLaFhtTzfK8k1tVtWqRI4cXDSSdY?=
 =?us-ascii?Q?mDU6JXmZTIT07Ob+z7DARPChPFr6TUy/ww/M9krpImz7XIRuN5IGEJOy0UYf?=
 =?us-ascii?Q?6aza+mng4tP6dOA4k2jiD1kRh3BSLNpOAO8GcrUVz9oieLzNejjNKsJEAE74?=
 =?us-ascii?Q?faV+u3rcSw2/JP4CarrSwjLUK/Iy+lYQ2Nug2NCJp5vykVCTaGx7ZKVB1e8R?=
 =?us-ascii?Q?6+irBwVR7WNLGaGbztPPbqt/xhZQ2UdezV2+96bWQzl6sSN0Xe/5DflJQXCn?=
 =?us-ascii?Q?Kaf2BV/Jgur6PCOtJeZgKPnxKr9VwltXsRPRJWo/dSmWlBHnQwkyNVVY3RVM?=
 =?us-ascii?Q?tu2fxWZ1QQ0hhIUo5eMxew3GcSiMbM/ruYHoYyZc/d4pkJzlUvCvtlUDQiVx?=
 =?us-ascii?Q?4NTG5JmyCv5Koxm/6B6dmmjrz5MiDUBS6Hj6OFnYlXfkiXCiaTpkVvf1aKWN?=
 =?us-ascii?Q?QIcDMmH9PddFKJb8LRlzgKU997ny9mRWTW2xNh0Yd8HfMchVU3OknJ6hdeyG?=
 =?us-ascii?Q?6+h3ungT/+uk21hPMKObmGU3P124f7KvV9XiHqBMqmVrRmzdsLBcQNlMAMre?=
 =?us-ascii?Q?egt3GDeUZ/dHrLRSBDdRj1N3j4P95kYgK0XqB4ho47gBmfJvlIyoUOYBlr+B?=
 =?us-ascii?Q?bDf6Yi/j26xIVVDfsXtjTQHzVmS6MMM8RC07GhtVG9aURqj6hhpxAwhwm2G5?=
 =?us-ascii?Q?aRRTxBer+QPtLz1asUA7T0JPB4hKolGc?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9i94L/1KS+vRFZtg665+IMJz4oc6ZIWopeMubpSq2EFtaq5lg92B8wGXgikM?=
 =?us-ascii?Q?7if8rCXc2rRepsF+RXYj2wpm8MBu3U+Wm9vJj0R2ts3+w33Tz0xDswt3Ri3I?=
 =?us-ascii?Q?2IGQgbxr/dlEFJrH/HqXgDOIfExa5S+NUZvlnS43RQOK0DInKl6xPBEVJ8Iw?=
 =?us-ascii?Q?CEkeArq9e/ybnr2RZ6icPi2or7aXZ0IOsM8C1E3fQVzIQFIorXiSJDtvNF1S?=
 =?us-ascii?Q?rgz7sU7+iULQ3BpGmGdActr7PoN2XxrCA5hMxRaWaN8QaG96FT+QX3B5DMXY?=
 =?us-ascii?Q?kSl06nKCShg40AwYliXheqBNSoCIyy+pR706NsA031KvOvSjW2RF/m4PntMX?=
 =?us-ascii?Q?vS8QvyJdafbnm4f1jNK1Yu3zgi7/E3hsXFl9dbCsTVQWTNOHdys1jmYTrKwb?=
 =?us-ascii?Q?qmZz3XHGogeTtvz8E3yhRvaS4NhofO3VlueE0EVo0FH68CpSlIm5j5O3622T?=
 =?us-ascii?Q?onm1Kgbbzlk7ve8ofZbL6WCudPjreJWjPckPP4e3fOamTfKgmf8FFv6TQ4BH?=
 =?us-ascii?Q?1XdLWHKgn8kLLkLDWD+ho7I4EJCvCxqqa4Y3j1Nj7TH2G929xYbW5FJINUW/?=
 =?us-ascii?Q?/3LJK3ZDS3vYbQYnNOXAjjrx0mmO/Y99CiIKKvKWTyGfgid8mPfaRP0FwSLr?=
 =?us-ascii?Q?BqqmuVWbyrhsK1vcMZkDvgFUEODpCI2YxK2NBkeHjZ6SJlSWRXdmk/YVwwM4?=
 =?us-ascii?Q?DijcdWfnaMehgneOF+/FApqdPEl78p3Bkj8SgvgWlQsFdPLfSPMkrAMAV9pm?=
 =?us-ascii?Q?dI5ovUy8zWJYmwxuvGdXPxBLZxiLmJuMc+xvoEdlpVZdEaTPK8qbEf/lrS9d?=
 =?us-ascii?Q?bDfbdhjSb5g1IsIUupiCQ61YYiMLvgJMHvqzwwlJ6pFPd0a/DE6QiC/vIOHE?=
 =?us-ascii?Q?ztIqLWBGN9CCfaTjM+Sd/8n9IGGXuloxDkuFrV7Wp9FGTi58Dc3zQ3yVZqqL?=
 =?us-ascii?Q?rQxFdhlUVAyx7W5LTKCMR7s5QAQ3Vo0AvX+tHqHi0ad0tiJD35bRR3XDPRM4?=
 =?us-ascii?Q?W36/RJd2cL5+8UyciH9FSprca426X1zqUiLTZS6IphvOBKyUoqCH6ZlVUI5a?=
 =?us-ascii?Q?cjn5L3OGHZBcX/BATFIMgVZZvyKdIIKk5EYnX1Q3wQqT1Ma9C57A1Ibzxtn8?=
 =?us-ascii?Q?fXPYgwD3P5mzpWdNATlJoCCDQ9P//q5dM/rw+SKNLqxWo9yUKVXuXqi40N6n?=
 =?us-ascii?Q?LZoeb0Z65Nt69MtgcwsxLd8MjC6JXcm6WQDWcZkEJ/M6/U0+BDY5Jj+VVcTy?=
 =?us-ascii?Q?zOPZcXJ2hnImMYykjLoRRM2jT77NojVYLfRxaDwvEEt4hUav6kqTOrw48/5v?=
 =?us-ascii?Q?bIq5Pq+HqpT5HW/losr8pURibKuAolzbhWp1wio+9hyb/bLGqDhJZIsgJzvU?=
 =?us-ascii?Q?GXobn0KEiv0W8ef884NAMEzrlwjV88lzQVN1z1dc44gs5BGdcfNdSbRIFQ7P?=
 =?us-ascii?Q?t3Wgs3ClN1gvIdPnYqLJyV4LHfMdI7AwbJdK8PwvH/dnOooneDIMcW8Mlq8y?=
 =?us-ascii?Q?zZ+iFKJV5W/1HSdtFB+New9mA3FNZOH8xmRjD3DrXj74ywzrPwPwS4Vcte0R?=
 =?us-ascii?Q?T+9Ifcmva7ez/q/bpjXNiV7ZCOKu/mz57mKXFPpA?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd280565-16ba-46e5-0b54-08de3d45a9cd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 08:24:14.5313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjzhUs/EW1CJ7/uD6EjRtbiUNVJNW+5FlKvuW3g1qSDKt4BYkKhNXa5+IaSXVSMfU0Q0tOFI7TfRpwot49hYyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5443
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 08:24:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21096

On 17.12.25 04:02, nobuhiro.iwamatsu.x90@mail.toshiba wrote:
> Hi all,
>=20
>> -----Original Message-----
>> From: Chris Paterson <Chris.Paterson2@renesas.com>
>> Sent: Tuesday, December 16, 2025 3:23 PM
>> To: iwamatsu@gmail.com
>> Cc: Jan Kiszka <jan.kiszka@siemens.com>; cip-dev
>> <cip-dev@lists.cip-project.org>; Arisu Tachibana
>> <arisu.tachibana@miraclelinux.com>; iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE=
 =E4=BF=A1=E6=B4=8B =E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=B4
>> =EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=EF=BC=B4) <nobuhiro.iwamatsu.x90@ma=
il.toshiba>
>> Subject: RE: [cip-dev] [isar-cip-core][RFC][PATCH] Remove support for
>> building KernelCI images
>>
>> Hello Iwamatsu-san,
>>
>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>>> Behalf Of Nobuhiro Iwamatsu via lists.cip-project.org
>>> Sent: 13 December 2025 17:57
>>>
>>> Hi all,
>>>
>>> 2025=E5=B9=B412=E6=9C=8813=E6=97=A5(=E5=9C=9F) 9:26 Chris Paterson via =
lists.cip-project.org
>>> <chris.paterson2=3Drenesas.com@lists.cip-project.org>:
>>>>
>>>> Hello Jan,
>>>>
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> Sent: 10 December 2025 17:41
>>>>>
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> We are solely using the KernelCI-provided rootfs images by now and
>>>>> do not plan to change that.
>>>>>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> I'm happy with this.
>>>> If there is a requirement to re-add cip-core support for the new
>>> KernelCI we can revert accordingly.
>>>>
>>>
>>> Excuse me, I want to understand the information correctly, so please
>>> confirm this.
>>> Does this mean that the rootfs used to test CIP kernels in kernel CI
>>> is not isar-cip-core, but the rootfs provided by kernel CI?
>>> If this is correct, what is the reason?
>>
>> The main reason is that the testing is focused on the kernel, not usersp=
ace.
>> I hope to start enabling more KernelCI tests and some of them will add v=
arious
>> dependencies.
>> I'd rather make use of KernelCI's efforts to support these dependencies,=
 rather
>> than CIP have to do their own maintenance.
>>
>=20
> Personally, I think it's best to test using the rootfs created with cip-c=
ore and kernelCI.=20
> One of our goals is to maintain Linux systems for over 10 years, so I thi=
nk it's better to test
> on the Linux system that will ultimately be used.
>=20
> Of course, as you explained, I understand that it can be difficult to dea=
l with dependencies on a
> test rootfs, so considering everything at this point, there's no problem =
with using the kernelCI rootfs.
>=20
>> Of course, if I'm missing something obvious as to why we should be using=
 CIP
>> Core please let me know - I'm always happy for better ideas :)
>=20
> For example, what about compatibility between the rootfs and the kernel?
> I don't know how the rootfs provided by kernelCI is provided, but if the =
ABI is different,
> unexpected behavior may occur.
> # I think it's probably built with generic binaries that run on many envi=
ronments.
>=20
> An explanation of these things may need to be included on the wiki or oth=
ers.

Valid points.

Given that I ran into various issues booting full images (not just
kernel + nfsroot) on some boards we claim to support in isar-cip-core, I
think we could address both concerns also by enhancing our own on-device
testing for isar-cip-core itself, similar to what we are doing for the
M-COM right now. Yes, this is not a simple way to scale out (assist
devices needed for the DUTs), but it would gives more flexibility, and
if we eventually consider including firmware qualification, it would pay
off as well.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

