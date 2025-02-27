Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F98C19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 16:07:31 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.28])
 by mx.groups.io with SMTP id smtpd.web10.14379.1740672445854711024
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 08:07:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=BBgDfqP9;
 spf=pass (domain: siemens.com, ip: 52.101.65.28, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGgp8lksBioGmEXuq32p7s2wQczsmvZMQWhmS2Dl0onXPmSbio/7APdR9trlcJlUbtJ+1LSmoGc8JCSWo2D+NmKSo0qjTrqyOAti3+Ms5jQ2HN8A+DwHZevfAIv0jPZGcgO+o7ksVHHIYTs6HnMoD16HESQTYPU0rOc4M+r2f8hxElgcjMGuVP8qmeORxEI4466VMoA6E/78zlRwknOLeP8pVHUGLsb78wLu2NmnGtZsdxqVEJGhEIBk784sOcbAVHfaK1OJXCpAcnqhob65v+njOZ8YF9uObzENBrcCaUZDa9RW710iHGZWoMSmHoMcFSNJ7wJk736jtq2SnYLxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY0+9f8rBaYoGWxlRlaJF5LTIjO1BQJZ8IdQv2U+i5A=;
 b=OZZZQXUGX3n0XCWKwMd8TyiuqMKbBh0exrYpNG3MPpy7exx1aLCuHu0C+l8iaVZfCxe4Ifo7KRLG9M7UEyRlQmc7/rdjKbmuML2Yi/j8x1T0w8pM0vFMP2aHGri3c66gi4IfThuj8QFgkRlfJWOTHOmBMEQbotUO+BBBNGfguzkEwpvlB+jKb6KehVj0W3ye8apKxXK6CxDqy0JsW/nfyn0LSP9MWGB+NMoyopGPdkptgwngOi+5zlhZahU+9LSFqnTKa6x3AS5EYcjhOYw9NW9nJmhed3aue0d3/kddOxTGVj3QAi0HPeqQV7dR8guDyBJ1XKMG4pHXEdiaBJv7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY0+9f8rBaYoGWxlRlaJF5LTIjO1BQJZ8IdQv2U+i5A=;
 b=BBgDfqP9+K3cFWyc5sf71BI22CCJzupaI/GbBDaRqUtJYDUBbQgST49100EXU0UDcW1UDjRxHTBjk3Qfd+gR3JptVwpf7QuHRXHT00HLQ9f5w8FUA5jii6LkG/SJdgMYx5zYOS52En1VOeYCYBj+YcOL4sv3WZZgntLtiKTUo/78eB57sbKvdDx+vq6OYDT8fLE6ax3q5r8mw3jBBE3Lbu4cpTMa7/4wruy9jc8TTCQBJNYs3XEFQTnt71sbEQxZyxExksHEpy3RMwKel7P7ZZHwn6yPf3o/Np+Dp6txLazilhAO4++f7/VQWQD4qwCo8QkYzUdag07eHIGJ4cYGig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PA1PR10MB8405.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:441::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 16:07:21 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 16:07:21 +0000
Message-ID: <fe273710-8c84-47ce-bcfe-e7df71d9b553@siemens.com>
Date: Thu, 27 Feb 2025 17:07:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] initramfs-crypt-hook: implement 'noencrypt' option
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org,
 Jan Kiszka <jan.kiszka@siemens.com>
References: <20250227143022.323950-1-ch@denx.de>
 <20250227143022.323950-3-ch@denx.de>
 <56a7a225-2213-49b4-980e-0c288b1e8874@siemens.com>
 <01544894-2abd-4f58-ae7f-4ca43e137138@denx.de>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <01544894-2abd-4f58-ae7f-4ca43e137138@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::15) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PA1PR10MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d81e465-02c4-486a-cad9-08dd5748d0f6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vMR7VQ69FBOQddw81XFZ/7W4NHobP9VAxRc1U+LG9YRAB+yKUzXyeHx3zMP9?=
 =?us-ascii?Q?x7hZ7DI3IQwFhsSIbu6l2D/VUDDPHvSwyQdB2xNz7Zq7KECs7Q8f/QkVKhCh?=
 =?us-ascii?Q?SEHXxS96ewE8VLewcKdjC0l0+EKR/h5yqunKta1NrzYlx3bbkMda7LTxaCb+?=
 =?us-ascii?Q?FUyWf9wOQXQ25s77MdXsECXo/TD0SI+F8sToJHKse9lcbRBFF3P8T18AcoJh?=
 =?us-ascii?Q?FTp6qwJmsNkU2jxaZ5NKB8V/GlYpzdJvnFaWM8vIqn1PwnZshuoH5UEL5AYW?=
 =?us-ascii?Q?Jct//66P99YCb7GCFP3+wkDsZtYqqEJ+cGC6LShKYMhXvYsIXXW7LjYcc396?=
 =?us-ascii?Q?1MHjehcg/UKIgpzY68RWuzw/zhkL7jC3XDE767BjiM7ZSs0Bgm97xBV58nUK?=
 =?us-ascii?Q?L+cWATV8LQdUn0dZrbhBBNh/YW/C+vqXG6Gi6UbhWzNW8YKjTl8TvPSF2w0+?=
 =?us-ascii?Q?fYwqouPqvyw/AMKLRonB7H/MR6FC1ZpOR/kH9QLUC3Qz8e+ezqKxWD+Fhxzn?=
 =?us-ascii?Q?v4h0rENvIwmBLsxoZ3++9uDx9BR8rK19IhLJa6qM+ZXJUB5wP/By3P1WJcCD?=
 =?us-ascii?Q?VXY8ROR0rNnmhd9XhOBgIjE5mFtyXen8scVhnijJ45kHibeToKBXP5HBgRch?=
 =?us-ascii?Q?vMXrbLe9aDCkywFMuhmh4IIFqFuAmJuboBRdknNOjYkmi+ZlKRnNxkiak69c?=
 =?us-ascii?Q?hIRvWEEeeaoCUZ50uxBVFEUNfo6uwh+qdbO+vOHxCqjRMsC2G6LIKT5t5MVJ?=
 =?us-ascii?Q?f0GyJpMbBbgKuej4i4jaTh6QSThofqpnf1iaOUGTesgPjaElHD5IWiDoYUv9?=
 =?us-ascii?Q?Pwo1Y61MsRpSLkFre14RVB/XmWrGbBH+eR/sLR702fVEyJT1uzzuuqXtcfSq?=
 =?us-ascii?Q?BdIq2ySEnWCbdFcKaBFnEQ8LePk7A+w4V0DJJe1jpHBPG+ijC+2/xFj9NlBw?=
 =?us-ascii?Q?ReJlUyiRr8D25SWKyhxOZsnBWQU9NAiB3HAC+gK5VPpLOKGg1Z6agz7ZpMjp?=
 =?us-ascii?Q?/ER+8T49O3LowvbCbaXfyEq7iQSLNKhUEzzHKYwN8uXGmTtOvNw7aGBgSjLT?=
 =?us-ascii?Q?YJrSiXvIJ30c1qaj+X6gItHURFzgytXRRtbpr0KWwY3SdJzL8celREZFQSzs?=
 =?us-ascii?Q?iZhukUQYz7vU433zotfUhHDLGMUcbR2rCD5IhPOvRkWl0l57y0To1uoGZkuB?=
 =?us-ascii?Q?V66t42eEtW9DGAXPoU7124Im79+R/iuPDXXiKuGwU0mCpXQi3/h8EDjJm3qM?=
 =?us-ascii?Q?yWJhuSgDSBUdXCLrP5SDhiSgXm9eaFu93Ya6Hsh/7llchts0pt/qzy91t7ID?=
 =?us-ascii?Q?ruGuUxm65NCK94W6hm81QzuFHRUyqgPwpETEIwDPQ5wuPSpm9jqatVV6dqvz?=
 =?us-ascii?Q?NcV7h1/xr7PA0xy6pxHEDHNS2O1s?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nAHh7xzxXLBvB0sfTpENHaDr7DhQlzxszHtt6d8R+1dQh0xiz28jGoXb/rrF?=
 =?us-ascii?Q?8cf71isfKxcRCmi36F+eqWqjULmCJ0w/VBavdP0lSDhueuddtuzBdS416CbC?=
 =?us-ascii?Q?ed6hgYM3vUCwqr3XDvqOlXqlBwyxT0QVCjaaNbW/ojOqKvEzXvqs8pnJO18Y?=
 =?us-ascii?Q?o+s7iaynZTCgrfyvCvKstyJSxC+f5eZ0U4SmOoYvv3FCdBmkzSOe3bBkHp0q?=
 =?us-ascii?Q?MPVZvTLvomsv8hTxRaVPmpSRr1QvwjV7q2eRWcvqSgfGjWNvwuC5P1TzlCaQ?=
 =?us-ascii?Q?0+sCLlqHkx+x6+3XncSVV007A/z7gU0+jhwghbVLuF87APe+ukRr/9JYq9tz?=
 =?us-ascii?Q?K9ZSzfxdbPd/NFztG23YYooEeR/FNPEwFscy3riT1Lq7cn7CHVohnnOZrZRD?=
 =?us-ascii?Q?H7ajYE5XdaDhpIKSGwFPGQi6+C1ZmvF3OyuTeOnevtGqLW8VPiZs/9bfwwaQ?=
 =?us-ascii?Q?0suU/EqsgxATgesNzgFWOXDYIQbGxs593rP8o34nQC92hrjM+OM6ydFC3/N7?=
 =?us-ascii?Q?Uuz7HigWuAvZhRE/K7R6CX9yC8UqVyWD4iEnSD/P1+syozKoWGRO4NDUsi4O?=
 =?us-ascii?Q?WtYy7Mdvak6lPiraXiv4olbvm1FYgJt2TjIm3o4C8l+g/nY92JwLOrQICyhv?=
 =?us-ascii?Q?jhcfEZ6LJO219hbBlH8a8pPBigluti1c4MdKFYC2Bt0Tmvp6h4rCVSyBPxnf?=
 =?us-ascii?Q?XnEOGkTwcnSIwste36c5m49GuwA05LioPDPgM1S8kKLMaAWmTCM/GbpVZHbA?=
 =?us-ascii?Q?HRgNsDwCGB30fPLXidK/GeFQVIAsTuTkMbK1Buv+NwH79JOuu9TgefzB33Qf?=
 =?us-ascii?Q?DnEfjpEBgq5DGY9+m5MNbWk8qvC8OphUFVqJWwgC0EZ0FfD4dQXxwkzi92Nu?=
 =?us-ascii?Q?UGWh6toVvvrRIQAjMRdYJnZhj2d0SPvRresGjZyuHDDDaTjPuHOlmIYMbkIk?=
 =?us-ascii?Q?/QLnusC2A21EuLO7wc9rLc1NNxSAb+AB85qPj/vXVkE0voK7dYAOf7JdyRx4?=
 =?us-ascii?Q?teAB3bKpFJRH4S/r7FObAO8uOModbsNyhNeaYQblVuwJGBwB82b4suXoRC1G?=
 =?us-ascii?Q?HQv8cUPqfZJbCfggAtel5WsgwH7PnJcQwh/0NpA/FxUWzarXUrQt4fLJdZR6?=
 =?us-ascii?Q?S3XIIUgvcv8TgsYssF1l6FZdLNoqD4+dPxlTHkSefmkGKC5uX0ud685HZxU1?=
 =?us-ascii?Q?vKM2TXkNJgJSnjFHsD7AN++bIPYT3Zfm3fwvB7VqWe3F7tQNpSuGkon209A+?=
 =?us-ascii?Q?D0S4R/whPoYJD+rQWhyiWzaileCiUhM7FYxVHV1hAej8OI8yHioeAcwI5mLu?=
 =?us-ascii?Q?FLbpYrAjEbOL6CzrpS08Mv1lrdNCfnlxRq0GX+GN1hQqs823xbcfhbTuYJgt?=
 =?us-ascii?Q?Em098Rx+duaINgAMPYnCp3Sg6KybHiVRlc2OfuNo34KJGFsHf57MbiASdr4z?=
 =?us-ascii?Q?untLpoFauKrMRfg13vSNUuIL9DNoLamZWngNJCIPWHbdRd3XHBlxmcjpBdol?=
 =?us-ascii?Q?0Wbng2aOYo3yQ80wH4sMU+FGwYPVwsIroqTO8M1yXUZ3nB8sIufVksQb3SLv?=
 =?us-ascii?Q?Ly14r2Rx/+K3oONg6zf2w0HPZ74q8iyokC4cphV0tQanoYFW8e4fwJNRE4Na?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d81e465-02c4-486a-cad9-08dd5748d0f6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:07:21.6969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qerlxa8ffoxI3/Ya9V1YPRs+oMOenqrkLpqtzVrU7jCiJPsrGqYwP6N/f+wKS0m6hJmmUWiDYYMOVyoriG7/yVX9W5SKZfXBO6No9sdFx8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8405
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 16:07:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17977



On 2/27/25 15:49, Claudius Heine wrote:
> Hi Qurin,
>=20
> On 2025-02-27 3:42 pm, Quirin Gylstorff wrote:
>>
>>
>> On 2/27/25 15:30, Claudius Heine wrote:
>>> In case encryption needs to be enabled via an update, while still
>>> allowing the update fall back to work. One update step where encryption
>>> is supported, but no reencryption is taking place if the device is not
>>> encrypted.
>>
>> The scenario this patch tries to solve is update from A to B:
>> - Update is not confirmed
>> - the encryption was successful
>> -=C2=A0 Error occurs and we fallback to Partition A
>>
>> Is that correct?
>=20
> Yes, and it is about a shared data partition, that needs to be available=
=20
> on both systems and should eventually be encrypted. The root file=20
> systems do not really matter, because they are belong to each update slot=
.
>=20
> Update slot A needs to be able to mount the encrypted partition, but=20
> should not encrypt it.

Can you add that example  to the commit message.

Quirin
>=20
> regards,
> Claudius
>=20
>>
>> Quirin
>>>
>>> For this the `noencrypt` hook is implemented, which requires some
>>> restructure/reordering of the `local-top-complete` script.
>>>
>>> Signed-off-by: Claudius Heine <ch@denx.de>
>>> ---
>>> =C2=A0 doc/README.tpm2.encryption.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +=
+-
>>> =C2=A0 .../files/local-top-complete=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 +++=
++++++++++++----
>>> =C2=A0 2 files changed, 21 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/doc/README.tpm2.encryption.md b/doc/=20
>>> README.tpm2.encryption.md
>>> index 3f7e89f..a503095 100644
>>> --- a/doc/README.tpm2.encryption.md
>>> +++ b/doc/README.tpm2.encryption.md
>>> @@ -42,11 +42,12 @@ The initramfs-crypt-hook recipe has the following=20
>>> variables which can be overwri
>>> =C2=A0 ### CRYPT_PARTITIONS
>>> =C2=A0 The variable `CRYPT_PARTITIONS` contains the information which=20
>>> partition shall be encrypted where to mount it.
>>> -Each entry uses the schema `<partition-=20
>>> identifier>:<mountpoint>:<reencrypt or format>`.
>>> +Each entry uses the schema `<partition-=20
>>> identifier>:<mountpoint>:<reencrypt | format | noencrypt>`.
>>> =C2=A0 - The `partition-idenitifer` is used to identify the partition o=
n=20
>>> the disk, it can contain a partition label, partition UUID or=20
>>> absolute path to the partition device, e.g. `/dev/sda`.
>>> =C2=A0 - The `mountpoint` is used mount the decrypted partition in the=
=20
>>> root file system
>>> =C2=A0 - `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting=
=20
>>> content of the partition. This reduces the partition by 32MB and the=20
>>> file system by a similar amount
>>> =C2=A0 - `format` creates a empty LUKS partition and creates a file sys=
tem=20
>>> defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
>>> +- `noencrypt` will not try to encrypt the partition, if it isn't=20
>>> encrypted already, but will open it if it is. This makes it possible=20
>>> for an system to support encrypted partitions, while not encrypting=20
>>> anything on their own. Useful when updating from a system that is=20
>>> unencrypted to one that is, while supporting a fallback system. For=20
>>> example, with a shared data partition, the fallback system would have=20
>>> the `noencrypt` option, while the encrypted system would have the=20
>>> `reencrypt` option set for it. Now the fallback system can still open=20
>>> the data partition if the update to the encrypted system failed.
>>> =C2=A0 #### Encrypted root file system
>>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-=20
>>> complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-=20
>>> complete
>>> index 502fcc1..67722fc 100644
>>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> @@ -211,22 +211,36 @@ for partition_set in $partition_sets; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ ! -e=C2=A0 "$part_device" ]; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "Could not=
 find device=C2=A0 mapped to '$partition' cannot=20
>>> be encrypted!"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> -=C2=A0=C2=A0=C2=A0 decrypted_part=3D/dev/mapper/"$crypt_mount_name"
>>> -=C2=A0=C2=A0=C2=A0 # check if we are trying to mount root
>>> -=C2=A0=C2=A0=C2=A0 if [ "$partition_mountpoint" =3D "/" ]; then
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "ROOT=3D$decrypted_par=
t" >/conf/param.conf
>>> -=C2=A0=C2=A0=C2=A0 fi
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$partition_expand" =3D "expand" ];=
 then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 expand_partition=
 $part_device
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +=C2=A0=C2=A0=C2=A0 # If partition is already encrypted, decrypt and co=
ntinue with=20
>>> next partition:
>>> +=C2=A0=C2=A0=C2=A0 decrypted_part=3D/dev/mapper/"$crypt_mount_name"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if /usr/sbin/cryptsetup luksDump --batch=
-mode "$part_device" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | grep -q "luks2"; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 open_tpm2_partit=
ion "$part_device" "$crypt_mount_name"=20
>>> "$tpm_device"
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # check if we are trying to=
 mount root, set ROOT to=20
>>> decrypted partition:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$partition_mountpoint=
" =3D "/" ]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ech=
o "ROOT=3D$decrypted_part" >/conf/param.conf
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +=C2=A0=C2=A0=C2=A0 # If partition should not be encrypted, continue wi=
th next=20
>>> partition:
>>> +=C2=A0=C2=A0=C2=A0 if [ "$partition_format" =3D "noencrypt" ]
>>> +=C2=A0=C2=A0=C2=A0 then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> +=C2=A0=C2=A0=C2=A0 # check if we are trying to mount root, set ROOT to=
 decrypted=20
>>> partition:
>>> +=C2=A0=C2=A0=C2=A0 if [ "$partition_mountpoint" =3D "/" ]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "ROOT=3D$decrypted_par=
t" >/conf/param.conf
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # service watchdog in the background dur=
ing lengthy re-encryption
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -z "$watchdog_pid" ]; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 service_watchdog=
 &
>>
>=20


