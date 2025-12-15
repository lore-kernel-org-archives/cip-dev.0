Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8B5D59D99
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 12:38:34 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.69])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47542.1765802312932096071
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 04:38:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=s536hXtC;
 spf=pass (domain: siemens.com, ip: 52.101.66.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPstBOiwDNIyDIfSOpyI6jGwgwrP59JI/sJ05ETBqNkjZi1v6hM50i5eHW6TzR6JvinCtoFZGeH0Wzf9yKi2thDVspqSgLmyq5J2OiohiEW7gwuvmwQNlqBxH/D4e1IQouSdWAUqmASjrCT4C5O2hGxKwibnevuD1FU5x6ddmvcDjdLB8A8XZNBrQ5ioolgwJkll+GHJQJlQYp2keeMtx0GPrXzGiI0ZLI/zSTqBYseyZcrbymw4gXiLUXPIq0J9T+1NHUtMMdwCfGze3Ag+cxtQCp5a+EuHwmbhlWT8Axks4PCKh5SPf2Ux48v1B13HUAPVoXiU7eRVQZB5REvwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUEec16/Y34RrWSglrVxqC4v08e8bUyA1ogNWnjWSa0=;
 b=Ah1SWGQct2qVoMp0t+mBxvX39boiSuf4+gzDp/KftcKDHQsggbOPT0u6yieilwyjE17LIvvDX73QzYOVE97irH4W7p3GrAmZdgWujH00yvQnGe9fT6S8tS6FSd5KS8tFrJmC3FgwWGBolZFQ1jC+EeHIFUR+kVrm9a+gqSwdcs1SFa1NbcIA3DivvNjHjAlM/IVCXgFopkQTcKcjQDbR8hBFWTedzeLsBm/vnPkH7Y6AnEDkbHlc9a5H54UA2Pzj+z9ODvsFACjlmZ7i7Z71C93W2TGnwZSdQSFYf3LuQ/T540yh9Pfcidx+Vw/mX4IG71a9bgbB5CT6y4CY1Gm82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUEec16/Y34RrWSglrVxqC4v08e8bUyA1ogNWnjWSa0=;
 b=s536hXtCR3MXuuv3b8a/VVEAcEqbMWTTrpdiYUAMJr9Qz563nRL2vnssh8Qhfy048ovdLipfP1IOzW0E/OZjz+1PwH85uc66GpE6Xt4Nn3zy0sqNXzgOh5Uc/GZ2tq+ZELMG/xW71TWSc8gbN1I/3Br2f2Soa4aiHo8q3NpdtXsfK4gLRQ9tEUjYeTtKmMM7iCyT0hL5/Mvyb9N/iHAUNjjbSYr0Pt56oCV3UTqPdf0bYkHmLk/jpTtOgLS1wWgJvpXkAqXDCTUuSu/TObXdDdYi0KifwhhsvQUcLxB7BD4dI96qlj0y6KyNW68zL35W5iWfsnU3zG08S1QJftJaRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7157.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 12:38:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 12:38:28 +0000
Message-ID: <d630f6ba-72a0-4cd3-917f-7432c69f6b94@siemens.com>
Date: Mon, 15 Dec 2025 13:38:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC][PATCH] Remove support for building
 KernelCI images
To: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>,
 chris.paterson2@renesas.com,
 Arisu Tachibana <arisu.tachibana@miraclelinux.com>
CC: cip-dev <cip-dev@lists.cip-project.org>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
References: <5a48c2d2-2699-44a2-89ef-c44ef1c9ca38@siemens.com>
 <OSZPR01MB812347C7FA70D10AE6C7D096B7AFA@OSZPR01MB8123.jpnprd01.prod.outlook.com>
 <CACe6DC7J75AYUkgW1RGWOd1A3y5oS_Y1LQe1TPvb=ZEGX3PBDA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CACe6DC7J75AYUkgW1RGWOd1A3y5oS_Y1LQe1TPvb=ZEGX3PBDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc03033-0e6c-4301-9178-08de3bd6d918
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?faShuEvkpaCTMRHaGU0nEc4Rz1ZndkkmCoK2Eh0vwcLRJ1hiCGWHtZDCPQLr?=
 =?us-ascii?Q?m1zFk0NIPBhI8mT0lF9Isvws+LAXo1rsVKU1BsqCSJlo/xOPSnTrc6PHpouS?=
 =?us-ascii?Q?Ls/BXgv25hD9rklWg745CuljTZEOHDdxjoO5sNGIWCr4f6TKw8wVYwTnNw6A?=
 =?us-ascii?Q?EjTLL95w/DhhvLFPv3yEIUQxResAy94NoIj7smGw3PPr3UV+K2ESB6fb54tQ?=
 =?us-ascii?Q?TzWLH4ekqNRN8KRwiLzRhyn5btJtA49UlaMdpIBkasmSqAeXGqN90IyqYzlG?=
 =?us-ascii?Q?iQf740Fe0oySquOj+3Q9IEzHvXmzT95ZbJzYFt7NfkZ+IOJ7/wxx0EG0eIQJ?=
 =?us-ascii?Q?rRGJWXohf0/jQdWdwbBdXM7fVRWUe3WuT32max6SAkGoSAyuLbSJ6x8vtnG6?=
 =?us-ascii?Q?EkE5HaD33/3F60HjPvvtINvrtPFCesGTA5lEqmNYbHLC7FM/G5CuiBGk0Qk5?=
 =?us-ascii?Q?4062TcsfED9HFjcN+S5Ce5q2ZyTUlwc1CtPzyjepz/Oli8k6tSRHMXY3Bn5m?=
 =?us-ascii?Q?8ftkNYdI1K1RWA6ZaNe9CEdCnG/jg9lhDngzCAQpEDvtKxGfEBI30UqWMpPx?=
 =?us-ascii?Q?CvliFoNPzjEg7KY+QDKeaNxzC0UuhNz23symhTYh0iBcEPUfa7k+hR7KEpgj?=
 =?us-ascii?Q?yMEW6Q+IiwWa1XlKkKyt5RFJ+eOnXSdNrraJb5ktx8un33Xw2C8AejMMIHoO?=
 =?us-ascii?Q?ARhzrtz2xnx/XTnykShAXRiUQlhJWmFSGKXoLHfAdHfxsIqYP4phYqlolvrB?=
 =?us-ascii?Q?9INGT3b6Agnlmc/TVfY1pLda0Jm1OsGAnB4Cef0euhXilKitNubrUyzNa6W8?=
 =?us-ascii?Q?7Hk+8P/wRL2+0vCD8NcyA+hBIsGYzKBbslVBQ1FvXQIBQL69csUOjQAjpguS?=
 =?us-ascii?Q?31cIAfCESJLYml8CuC7DrH3miC0QmPfQx7Gutw/S+X1Mhw9PKX0iYUPptYs5?=
 =?us-ascii?Q?QIiKr+Hwob2bXcjohdYG8oou9hkz1Cq6J3Bo9JbnilFYECWgrc9Ipvy+wBAX?=
 =?us-ascii?Q?PcfgZ6TZzn45FqTtOTfZi0SveDVWFrY5GfOz/HelXE9p14RXbgmIxByafZFI?=
 =?us-ascii?Q?a3ep8WDjdpWd3EhGBa1SqgG4gA2R4Ht0sZsMCmN77oA+qjjiCgvq4319onRV?=
 =?us-ascii?Q?c67zBNiAYwXBsgOlajdFtHWFAXINzL4oiuyv6FUGX5vR5OZHFcAhTE5kPIAj?=
 =?us-ascii?Q?tB9fgVcRhC/GIizL6orQumKabnmpvDI4tAk/FBaIFIZ1ZExt22TsEAHCsQQx?=
 =?us-ascii?Q?psBEOWWO/dgYNSrVStbQdqi89uI27VEw7G/14ekQv/6b9ax69obRr9Obuu6q?=
 =?us-ascii?Q?n/+RmENaqldV2vTe+etiH7QZ4Q7+r6KFR4xV9PKW8/WiU715cCSkdTf8Z5oY?=
 =?us-ascii?Q?3IM5qq3PSjgZbrIG3I8KzvTrOR82Jo3/MbYn2WEUlmhMfyEaMF2RbSWSCLDb?=
 =?us-ascii?Q?3Ap4NCXUTv4pNpx62WZCTlwqiU9UEHlL?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3YcABe543HecP9jxoS/5cyjZUAu3iXmbFj7pSimdQalxKn6X3cPvYx4CxZXE?=
 =?us-ascii?Q?bBFltD9JR4v9fidKa5v99aGlorTuID+XxSJqlmSbIAKgmfDD13gvXCD8V/Ex?=
 =?us-ascii?Q?LqDLcnVEShXnXouCx475xEzy7gakOEanBqonhzdvh5DfpS9OTsXCD8zCG+w7?=
 =?us-ascii?Q?LXxIC0dA6MjEQVOdT5aB/QzLMO+cAD5/lOuiFkx3D3+/s6UvV7cSG1eDAK8R?=
 =?us-ascii?Q?nx7mhXjhNFFuvqce2mAyMHz6c7/0HNBGCA29gfqGsBpc5e+M266FEbAoqN1x?=
 =?us-ascii?Q?7ofFzlDvLNfR0CoVCbkhnTzky+J+u5GnQQB6IMsIJC195uQ8+5jKtr3OXV+7?=
 =?us-ascii?Q?GrowxewE08GwKLG12YRWTjsGeM3QodQygBrm2iSfwnl0z/0uV2m3c7bmYwl8?=
 =?us-ascii?Q?4kogY8RiRETDRDDalaiwQNEOMRhAgMxCsRt5ZplEJmyU8OxsJAAmWXATq8tN?=
 =?us-ascii?Q?hMBXvaloyVPlXZfG4PmOiPrAbVIs97KPmRxXpx33trWyjEDubWNtwTWs8Jvx?=
 =?us-ascii?Q?1qd2GqcTi2kwisVkbto6aamU38NVnwtpNES3LJLB6Yx0Yj/mG1Ep5jMlqQKW?=
 =?us-ascii?Q?wnKcA/3iMUb6JiiqnzdXakNqi19GmNpugap2RSxsD028OYtNveZMSOSRJYju?=
 =?us-ascii?Q?B3TEHrA5ugITnp/GWwwxJYbhvA4YdHt3Nnh0Wbl9sgIv8ODWEfIPA6OtuGP+?=
 =?us-ascii?Q?hbIMBU0QLjAgK1Bsh469dk/GVK9hqqXJufkQ7tfSngkMNQer5CWKpsSZM4NE?=
 =?us-ascii?Q?bl/rrc0UO+fncnaLtMK+A+48PEZl1J44Ju6lzt04odXgEKjkWmfuzHFzDbHC?=
 =?us-ascii?Q?TivI+tefT/unHonSrCWRqOWcYA9kqTAQj3Pya0YgXOGWz4t77QpTRbZUTBTw?=
 =?us-ascii?Q?GzIqgqYcdo3lk2zKdtW3L879rQ0LQBz9nD4ItDqJAVTKQsGxqLSlmHl2qAOf?=
 =?us-ascii?Q?5FhNDRKfaS074Z4ltVTEpb13nFFerHzI+YjG6TJKaU1aevJTvymubdIUlMO0?=
 =?us-ascii?Q?Y1qjAGf6kzyk5HBmJ7EZf7S3/mCetujjkV53AVasplYoFVKKOL2t3cEWRu29?=
 =?us-ascii?Q?Z4I1olKJnI0rZ6qf2oOXz8u6DqgdXngHd4EFXvauD96jiVgVoVbcyXxoyAhO?=
 =?us-ascii?Q?GbMrsS4GArhufZNJtqdb6Mc8VGAy0o6H7F/49QCToQqOMiAdF7Zn2piDX7Wb?=
 =?us-ascii?Q?ZwkjRz/4uxWzGuJ8EpgEIhKs6dO5JSX+GEPhzppI4DSiYGy1Uvy0ZX9hjFE3?=
 =?us-ascii?Q?BjyGIQTOy1KtKrTJ3yCsHWQOcbZ17Yxs7kfuZcCrCG7WLo7nFGIg/t3HJ738?=
 =?us-ascii?Q?hdG/eoF4S+HlLtk/KRbmgQGPj7KRxWE+Ovvqpr+KP57dWnCD3b3P5r4Ui4c2?=
 =?us-ascii?Q?PpRdeF6VCXLlyLHX+n4x6a2T0PiuXpWLLze8jMy/v5/I55bVf5T+nLsd/v59?=
 =?us-ascii?Q?4ACtvSPj+UWVfH9PdCzqgf5lErtkCzvii3o7Mo76R/5SPMA1BxfD5C3BdtOM?=
 =?us-ascii?Q?pyARU5cSBrb5lWTyAUBlgXgFLOS2dIjBHL11TggeOse1mMMucXtXN0Z4ny+m?=
 =?us-ascii?Q?XaER2sZI+9zteIUGowjcLVvtDxV2ZySn9j8aSkcCqU8FAfXqkvT+dJFchT8J?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc03033-0e6c-4301-9178-08de3bd6d918
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 12:38:28.5923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFLugb4nRbluNN/GIC+cvTevGLkbArUwXphaxVxDJyl1oO3aAYmTLNsWt2Qd6HpgHWHkIUiWjeAGBrfVwxp8Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7157
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 12:38:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21055

On 13.12.25 09:56, Nobuhiro Iwamatsu (Toshiba) wrote:
> Hi all,
>=20
> 2025=E5=B9=B412=E6=9C=8813=E6=97=A5(=E5=9C=9F) 9:26 Chris Paterson via li=
sts.cip-project.org
> <chris.paterson2=3Drenesas.com@lists.cip-project.org>:
>>
>> Hello Jan,
>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: 10 December 2025 17:41
>>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> We are solely using the KernelCI-provided rootfs images by now and do
>>> not plan to change that.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> I'm happy with this.
>> If there is a requirement to re-add cip-core support for the new KernelC=
I we can revert accordingly.
>>
>=20
> Excuse me, I want to understand the information correctly, so please
> confirm this.
> Does this mean that the rootfs used to test CIP kernels in kernel CI
> is not isar-cip-core,
> but the rootfs provided by kernel CI?

That is my understanding at this stage.

> If this is correct, what is the reason?
>=20

That is a question for Chris or Arisu. In any case, it would be good to
resolve it soon before I tag this for 1.10.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

