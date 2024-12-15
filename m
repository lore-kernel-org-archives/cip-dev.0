Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9B8E7716A
	for <webhook@archiver.kernel.org>; Sun, 15 Dec 2024 18:07:43 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.40])
 by mx.groups.io with SMTP id smtpd.web11.40030.1734286056669272195
 for <cip-dev@lists.cip-project.org>;
 Sun, 15 Dec 2024 10:07:37 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=zcYctdSs;
 spf=pass (domain: siemens.com, ip: 40.107.105.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bc+P7Sb3zHN8l9+CKTxTp8zprRyXSSfr8agokh8IT1gqPX98iZGXksZD/iBm6iwloFV2Uw6yvgOjvgt/ldBtD45WmojSQNZS08lX7gWTgOKcy+U4NSNH7JnllOu0s+WrY7OO4FlXnm88kyjgQ/MSlVw+x/9eMitPpaIlY+hNU8k0dPCP5nc+nTWxlwQoUQ18iyiVahQEz4idSHXUKWhC/NWT625G2ckajzS7OlIx8AqODm+0QPJOx8tZTtSs+oPV+5Ma0XgrzEzbkolSOZ+pqhgeeypm5RnWOUuVX77llGzS4eUyynpi4c60FUDNCOIduYVeSMlKcWnvHQcFTXymrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uJWIOm19al2dyOIo4i00mt2W0hBluMX84QbXz8hSSg=;
 b=FLnwlM6SGcX5qMyTY8/wOwFrdWTpZQF4djxq1ioUVR6GX1NwPxagTRCBEaUWvN9Ce8pd1OijnFlwyau4OHXA0NT4mKJMXOE7mHIZy2laVEzMU8XtlE/awA7i8AeOk8+RQ12SJq/IYv5019WmzT5suxw00Ify12U3PWEN+MhU/OavLc/cdovCTrD+sRkN8Qi1xYQUGtHy+N0bo130H1IZpfelTkRx9EsRnO/6ErDU/UJ9SnB6MiYxicurP+JPOEEQqHBBKw4yUrvzJG6s6tY83WWeSnKfxEOZQTVjL7TuYcf9hAt5pdo0MraJI1ZyauQbFUb6G6vWXLcSJlr4gl/FYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uJWIOm19al2dyOIo4i00mt2W0hBluMX84QbXz8hSSg=;
 b=zcYctdSs+9S8N9kKEZyrBomU+8+iKhrwwxphldFNz48ZJFjtEMjq82w6V4l/Yt363F4Zum/k4ifSriZxrg+da7GvDFeu5YwsEhF9jvt38FOodXF84dwP31VW4QN8rnGy6ZBjGia3CT7rlgtij6M5uCuzIzHBUaju9Qf5wartY97/IHOEQCHqzYTrmESLRk5epnPinref+OcijO3ree8bNdqKrNRSj/p0RtZvaooStOjr5ohKILG5H55tlVcLjFh2T+LqTQ0bw0SW7fLWyCdX7226FkQmRmfX3kROQlrnqS8yxGxAZnf/2yUWUkJYGg44rI30yvU3VN8HJ0K85oHf6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7424.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.11; Sun, 15 Dec
 2024 18:07:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8272.005; Sun, 15 Dec 2024
 18:07:33 +0000
Message-ID: <2bbf9009-2fe9-4227-bc1f-829fed0c1042@siemens.com>
Date: Sun, 15 Dec 2024 19:07:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Issue with the latest commit from master regarding initramfs-hook
To: JohnW <johnxw@amazon.com>, cip-dev@lists.cip-project.org
References: <Atyk.1734113139634423310.wcyy@lists.cip-project.org>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <Atyk.1734113139634423310.wcyy@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a137f0-582f-4760-bb74-08dd1d335911
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?m94M81LEeSfBEbK+C+IQWUbT4zuj1xoTYfN4V12fbr84Q6zL+HP+nrbl7qhd?=
 =?us-ascii?Q?T9LsNrV7i2g73ztWD0M6TOTKor9wUTFXk/DtN4BImDKufJnOGHEC+396Yxyp?=
 =?us-ascii?Q?d6UKNTg5v4gM89oYvjSpzmP95unhAN326//z09dGEdxcHlUFA2DfpX58QdzO?=
 =?us-ascii?Q?pXRP8b3n/l3gVnv5EhqWWmEaI2P+7+JLkwGtydOIufOzIAje1+brsML10bgg?=
 =?us-ascii?Q?aUIgh6Qj081hBqVelGdRWeZfMeeriuNPXfQmTK2gryPqtfC9yEjEZs0gD/JJ?=
 =?us-ascii?Q?h7npVKjDAe+5jGiHHwVGjXt/UR0OrlEAlOB4/0JFlvCRDK/Ef6lpwmTescwm?=
 =?us-ascii?Q?Oty9QdqWDOBKaSIFZnN4FWDlnh4ZDYhFmG2kSYSJxrrcy1CKWrNuz5ihp20j?=
 =?us-ascii?Q?iZmfm3nd63Ic7cOVHwIV/6ALrFiJuC//dqEn1n81+TB59DgnkhKreGsBvLvq?=
 =?us-ascii?Q?GvPpQxq+DAF7qSOzzwNTd6HgNrKjp24973ejV1+H/zD4Y+sSxUM/PwZ4g6gY?=
 =?us-ascii?Q?RpPrNIJbSKGLx4sRQZPtMLZjN0SNyW+y8GsBVS23R+zIKiyYnxHPTe9uhYiz?=
 =?us-ascii?Q?RkW+hT7wiXzZ4HmBZElNabrUv8sm+AkQFz/VLsvRN2cl6T+2CJHtK7fbTrb+?=
 =?us-ascii?Q?zE9pTJ243k9vvMLDxcfgLEy3DUK/z2fY21G/UN8UydJCprlb0K883lgBAgJc?=
 =?us-ascii?Q?PTm/Uhlr3iWEBjpmHdb0KpFDFUFCEZfSmLt0yFuRql9SFg6YL9wmJYn02mIx?=
 =?us-ascii?Q?0yaMQ4xxwewnHXN8LpWHrZ1MngnbXKPbbke5xDD8UOKiphOU4pAYlgYHHSz7?=
 =?us-ascii?Q?6cNSNEQrKirkXwTktQ81zgAxsBBL5lCWslsgu47/aIho6tsghr5j42BDvha9?=
 =?us-ascii?Q?6evnrjANwRUqMjZc1xBanP059exIF88mO37LbS827YrXrGNE6l5TARuocIL1?=
 =?us-ascii?Q?/PyA3AfadTq28ftO1K0ykF61fJUq5PsPQycN8Y7fg4BqlaQ98oelRjKzSJIN?=
 =?us-ascii?Q?PjmvU6rRi2GjNCr4bOKhWZnNIGkYs6W4GnMyMVgHb5d4VULazAw1LVojkqQb?=
 =?us-ascii?Q?JJztDmX/dA6vAQASJ+HIhbVpsqeu4qCoyoag95itP8jAdDjxLLG96mnmRnpX?=
 =?us-ascii?Q?Cnq0DQ6JUXH9a7njyQ6Af7lxH2ruzoPY5MwLm4lf9CHgvvqD35lRnme3lXhY?=
 =?us-ascii?Q?1qAKpSh7H/6J3ksadtwh56sd8b9XouBzvuWJILLsMvMPNoMwT+uADSqpLyVj?=
 =?us-ascii?Q?TsIHRC1b/jxQYM1GpuxTwX0WYKhvFCJTRFrLVYBPi6w+YCvq3pE5srvZ6sbG?=
 =?us-ascii?Q?RdhEz0wznwExkmPw62r/Jlhk06VKl+1ZK8zClYCvZamnAg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QtGw247OdEvpiJ4WTAAIogqLoLrdPgneYlRhRCWHaKC5axGLHTJWof1JdPWA?=
 =?us-ascii?Q?6CKkRdcy194oxOXWKPBv5JsIrj2VbF7ayq6zoy3JgMKrIFq+Pgnf2e3W1HPN?=
 =?us-ascii?Q?wQUrOIhOIqXTCNqJXumP7CVaqNG/12zJ2H6bKRDr5p9G04QUxlkl6mR3UaL3?=
 =?us-ascii?Q?miAP32K75vM0KV+2BZvpR+6HdCwbEOVdP5dsWc+JmAP+Zr0FJ2k7LAGISBxY?=
 =?us-ascii?Q?NQw+hUd23T1VtCpVk6ZI2dY6K8TPf84hGLMZ84IsKBbfGXTKBqfp/JDj+W6E?=
 =?us-ascii?Q?LkPlFhiGEigYXUnXNFZ8jLO9eNtvGYj8ozVhPfsGyP/o4XwakgaDLgPatjjX?=
 =?us-ascii?Q?MenCSwNKfesb8OWCI6ia5i7IcTbFKUcZLyh0LqyZzeDP9Cu/RLNm6iR+4o5J?=
 =?us-ascii?Q?HYAs99YsY8AufhGb1F3ITQaPYK+f9OEIn45Eb/0t3XWq3fTuzUrwtw0pZinS?=
 =?us-ascii?Q?MpemrBgvZm2BfSg+oKKh78DCgVlCbEWiWgtBd01Is/rmy1F0zJFVdi/8LWdz?=
 =?us-ascii?Q?QvIxyWeTdc5k+YeyxQQDmuDArcRwU1rb0Fpb5S1NFTZ+SIgI/jXV21A8Hd+y?=
 =?us-ascii?Q?X0XbI8wjLEAA0G16hWRUZZGBtSHQcU2zbOfPWbxaU4+JJw1PWIIVSX/+oLrC?=
 =?us-ascii?Q?24ptJel5T5jwlh8ex5oGS+VhUEmPKShMwNwWNHVLFLdTCFsmrbrSxJsgoqxP?=
 =?us-ascii?Q?YzFfRQYj1G1FUn5id6f6z2cwwIX5rrDmdXgcT79WGJmcltzUog2dmzXKNOui?=
 =?us-ascii?Q?Yqd647rpTa8YzG0ypsobuU20yxXY1eosK+hXrBpc+Nznl6QgEZluGDwYyIxN?=
 =?us-ascii?Q?gUjFM1693kxPZR2B+rqYOKp4i2x2PXWhEAVcGqwf8tL+vhfpUASq1y/PnEXf?=
 =?us-ascii?Q?zr/ThiobQe0f8AHj7ADt0dynO/SYvbzDP/Z3Sg8f8DPaCdFXeMmyA1t/4QZK?=
 =?us-ascii?Q?iDDm2qFX8Dq/kRWdKYHttqgrMsM50fNUG493WhqnGADqFUbEN0rH7qHP8tYT?=
 =?us-ascii?Q?9mbYoOolTU1YZd1U/h+c8KNXJcnLswNy+quZ65X6IFAyXjKJKeJAyASGckCi?=
 =?us-ascii?Q?3DSsxAf703cObm5TH4eyDTrd3OyX2rOZIubtid+wEjl6uzaLvAu3TYyvcOkG?=
 =?us-ascii?Q?Hny0QpE75GwbnV7uHDOp/vap/kDKiWLgR6SLdZBtwouMovJNsef0cSjf4W9U?=
 =?us-ascii?Q?Mhq+BcZ4FhSefVBt0UcuDXpbTp6MODjT6onjEWh7Qqva+kv1m40W+5BcY9Iq?=
 =?us-ascii?Q?UqO5hdMLNCBjJ2jQN9MgCP9bNACh5j7PdnYg/WZseXryYj55l5G3NV2weUpS?=
 =?us-ascii?Q?TLQRxQoyYssBjC0iIJnE4yvKozaC4xT/0CsWEXBK65G1cXezyuhIea6BR6dA?=
 =?us-ascii?Q?y3fCYwbv00o3Cr77A6kekuYo9Wp7M9ww6Rnm8BwcIAPzEl3lt0K77VYLijCd?=
 =?us-ascii?Q?wdJ/ykS9mNq1kVNt08GncvnIgtI2yjpG/ZBaJ6vblJsWKIWR2r8WG5M4EQ2W?=
 =?us-ascii?Q?T906ICHsa4G0n+/uwWoOaiRFN8/VeJS6xhkdi3ssxC90MIbKXIzTo8pek0NS?=
 =?us-ascii?Q?5DPOAEe7wG7j6QbS7HjrmC4AAnbN3NjbiD4X8E7Y?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a137f0-582f-4760-bb74-08dd1d335911
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 18:07:33.3233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wb/dbHjFXKtzGd4O7Ex6AcisAFgkh9tz4pQ5/hcm4Z71cezgGuQ6m+CBIX0avV+iurQyTSS4VtEMs1K2UK9Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7424
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 15 Dec 2024 18:07:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17421

On 13.12.24 19:05, JohnW wrote:
> Hi,
> =C2=A0
> I am seeing the following error when building my image with the latest
> commit from master. (2024-12-13 18:01:20 - INFO =C2=A0 =C2=A0 - Repositor=
y isar-
> cip-core checked out to b3b30a1b411db10012d9b4c79fd5d2b400c68eb9)
> =C2=A0
>=20
>     build/../isar-cip-core/recipes-initramfs/initramfs-abrootfs-hook/
>     initramfs-abrootfs-hook_0.2.bb:12: Could not include required file
>     recipes-initramfs/initramfs-hook/hook.inc
>=20
> =C2=A0
> It seems like the initramfs-hook recipe is no longer there?
> =C2=A0

You need to update isar to a revision that contains hook.inc. The kas
file of isar-cip-core references one that works, but you may have an own
kas file that lacks such an update so far.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

