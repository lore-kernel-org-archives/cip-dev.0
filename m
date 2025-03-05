Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E574C282D3
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 08:27:31 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.70])
 by mx.groups.io with SMTP id smtpd.web11.8822.1741163246182708518
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Mar 2025 00:27:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=APTgcu74;
 spf=pass (domain: siemens.com, ip: 52.101.66.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/OV2e/s4hBCjyVXoX1CsjM/d/vAFlsjQD23y61n4TY7V6/73IZ1O9fnCWoqHBxWusy6Zp1xXbnPB6jgsRSepFT+Gf6Vi+QxQ3LEgZjiRQPxyKVwuPwAqDCGK6lUneLOE39nCT9VNb+HUAyOz+Q8dv/0CdjXujEZmowZl7VtExQrb0ueOk/N7Rs16XEyQqR9cioZo+Wqsrk3AUnjLiAhkyPTJVsfBgFcYuTuEUuA6BmjGO/HGseeES6OeybDHrNIMlU2S6uo0rCNjxt+yKULibx9QdR2sapfA1I3vqHo81G1Dv1vjSJ4U2w3tX8mCWL0t2rkoxGGl6ILMTO6XJdX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75yJ3eI6ySwTxP3g6LXS/oDwX9MrSCfXx5nl74erDmk=;
 b=rvJrOty7hnn6oxEURk7Q0dYnL/xP8QHmotJXOGpAAd2nawgneww922ZRWfkjRrhHLq/XHvJpbbx6iXaaEQVRFHbI/leYMZyHJehPrtInkMip9Bcv2VazeVqH+sBOj/xgQf1IMPZAu8ZRE7AiyY8OTksK+LQCaTvbma5wgvnvOVl+bOIHL9IsQgfbGkmGHlPw/5+cLpL4Ad3y7mX1N0nWDg6sgKRWhA/+PLNQt4McUz0hlpWn28O/DgPDJ3VwNV7lrmuYrSakqReT7qSIbTYh3+NAkOgVjahi+KV7ZuPIyFoiTuhQZ2GpPz8rvRlavNJNn3+4lpka689XL1stsktmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75yJ3eI6ySwTxP3g6LXS/oDwX9MrSCfXx5nl74erDmk=;
 b=APTgcu74Vb3iz6iOy1h7X/1V8MWW34TG2I6pOqFGa5zdB85MbjhWdHz2WMoTXk3GlhXg9Mm0SziM9V8LIqNccrTrZ7GRjTYB+dvAdYg76AGifyOCmePWHwS2bIKnh4Yu8SB1v3SUz05JDT2FCHtw/BDCxSUEbHBnv0K3ocITakt57CVzoNwhetgeYUc5nwq67uDFH56Zz9RVjU9qxtfANOS25plNrnfbTcczxjIYQd+n5GHgnIzMNzbPhDg0rXCnfXgoFM0Js5m1L+QTUU33+RTA/uuKUlMGAK7TyiIAny+MpxI6eWTJ8oHK4DSQCYjpFPpP9bgoO930V3ftfR0OuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8387.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 08:27:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 08:27:23 +0000
Message-ID: <014850ef-8627-4266-baa0-136d39f3e88e@siemens.com>
Date: Wed, 5 Mar 2025 09:27:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] initramfs-crypt-hook: implement 'noencrypt' option
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20250304130743.2812183-1-ch@denx.de>
 <20250304130743.2812183-3-ch@denx.de>
 <c98de579-e33f-486f-b964-4f4a0aebd1d5@siemens.com>
 <12212010-abfc-4e1d-a6bc-0a89754c2b86@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <12212010-abfc-4e1d-a6bc-0a89754c2b86@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0224.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6440ca-d949-4a05-7201-08dd5bbf8d80
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/KFBQGJ9aEoCG87j0jgfTGDb1L+KSeNf5s81KjkotA8gUElZiF+d4D8eSTIR?=
 =?us-ascii?Q?5eHOhTRr9zmEX4Tq5IGaz0o57DZ/gFL973vwtQ/q5lLzG6OX4zn8xpSCcrxu?=
 =?us-ascii?Q?NL7RoAWTwpAY4Cy1rzmiN9VAJ8R9LqLFFdh9qs8byR4pxG3yLGpBSvOxh3Y+?=
 =?us-ascii?Q?7u8COZPai/ir+TWd5Q/lbf04piVKxQLmYQ7t9qtODeqqQGVRXKorXpPEF3Yp?=
 =?us-ascii?Q?U0p/BFpbb2Tf2sJUSh9hjjzoeIPsokcbw5d/3f0N+UOGV2miV5RHABWlSuL3?=
 =?us-ascii?Q?qqJURXzVPUWpDk2Lr65E2hWVLorSeQ4ZjJ8m5S76k7u7X3yW90Pu/ZZrGIs/?=
 =?us-ascii?Q?b725oJyqccgQ3mcxWcjRpH3InAR3twdRjBkAkjDd74mS0E5uW3Yeyp6w+8RG?=
 =?us-ascii?Q?kEaGqmxzFVToSQ/SCrBzxbr0B+EyqqldCeiUfqmz73gX18nmdZ0mHxhVaqYH?=
 =?us-ascii?Q?BswI0MnlEpI9uOSuNKPZXWn6PYpSuvup8wy8/BFWeN1yas8l40NSHeCZ71X8?=
 =?us-ascii?Q?KebHoFiBoSEwdglyLuqB1v+4yYTE1vJ4heAWIZONLrX2ZHT088K/jYFJxUY7?=
 =?us-ascii?Q?F1hdNjiAsgan6oSiPNYxtKdUZlOHEdESibKQNc2fREWspwtPNZzNlpsY9OOA?=
 =?us-ascii?Q?Amyystnwoqq+WHR3PEqvuHNUlNGbr7vsH7DBMNssrZPkMLnRzsfVUVrjlpPf?=
 =?us-ascii?Q?P3td2MeI1XS6ErtQvjSWeExH2/cjbh4crU4jHIEra2luiIJ9GebLCk5u3ikf?=
 =?us-ascii?Q?Z6Zp61p6VKOFV4NZLJ2yWkC3vCc/u7f8pnARmspaEJG4dN4BSV5Lbp+RzLBf?=
 =?us-ascii?Q?UQpCI/PdragJ5YtED0yCLwxOR2ZhWCZfIOozyUOuRfGzibx6nZ3/ZLxGjY0Z?=
 =?us-ascii?Q?jEX9/8F3FxrXylBECrTleiZDgzQHljECopI4JznTvHWhmbjohidu2yvlJeIV?=
 =?us-ascii?Q?KgoxN8b9ec/CKkQYJmNJP1euCZoAlmLxqVlKmZ2fsP30AQusr7VR0+1KAwmF?=
 =?us-ascii?Q?7me3aFmXv//fPj40aqX1SD3YsuYHbcqr3d3ZQnRY7bpGvJN9PBVmeXQjmXE/?=
 =?us-ascii?Q?KevyY2uETnTDVvHPjVYoImyaykqqrv8eR2Vsb9t1bEldRUZGUxqi7CjzoEpo?=
 =?us-ascii?Q?lQaPzNm3aIE4zOvzJ57Zxg7uR3+Caj1YCIUemhyvEvOlXbgR8jF30Y36JIKW?=
 =?us-ascii?Q?2Pv1X27jQRj9HKI45bcPi+tN48ivEGiAnufl8Lm3RR67YOslPyrbnPSiVJGd?=
 =?us-ascii?Q?QIZeqQ3OFdcegZgqaEmp+NXqWFQxy6Y7+7oS0zOQ48TbUfZpWRxNOEOs8u+s?=
 =?us-ascii?Q?1P2VrAPWEDPSfatZlcbIDTR9u4Cygw+7xjPMiQbGazQcoLMVIa/rreCL+r93?=
 =?us-ascii?Q?qK918DwPuWdyR6RefrmhP+kJ/U5n?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Wutc8uHhWVS5/Aoh1d9pu7vJHKD9gFuqouG2MAqYB3vAr9TwPAgdyOfHVy8O?=
 =?us-ascii?Q?XiFWoh3Pg3/188wDjUvB55ql9hQjLB4MXYLFc/n1+HVmAiWBvcSf4Lci0ZpP?=
 =?us-ascii?Q?E4KRbp9nUHXB43zm3EWsWDqmYjG1Nfw7c6F06kKoNknrw392naRoZUdyMIvS?=
 =?us-ascii?Q?qwV3XgthaHKwZDWTcJf5NKKo2oaa1Xg9JxV10R6zIPTiNRUYzUm7dY3dOMEo?=
 =?us-ascii?Q?NmF+Bz+OX5DhAdW7UnMcFrfov5jMe7oVJKOzjXHKQSxPCLS1KNCtQlWcjkDq?=
 =?us-ascii?Q?Zk157i06ke/rZ8+KG4wfmgJLKWxzvRhXNR/z7dHiUEii1essbaq77032McZi?=
 =?us-ascii?Q?QsH/EqiBKA3T3qDroMGGnz2kj0pEjqzvJ86NYzf0KJzd3+Mu0nKe1y4zgSo6?=
 =?us-ascii?Q?a2xdL5Y1azt1QA1P49eJjzS6P+3G5nH57mGqJpuSUQeBkh4FqQTxm9z89Ff4?=
 =?us-ascii?Q?qrIn+sciYkzY3toTbUlVGvGtL8k99neAU8hbjLxbBDx88VgYyTXkIWKazyZr?=
 =?us-ascii?Q?QPbTqZksAioJslql08lctgBSggKO/D9JRytGkr6L9mY+KF8rHAQsjOHpr2Tz?=
 =?us-ascii?Q?bAQR9ia84KsWOEa/Igi1KzaD+kWmZCZO5d88aogXQ9KkL1aFVKX38Br57+0F?=
 =?us-ascii?Q?0W1XMXClebh2K9ydwCEPN4pBIWrR1zSoN+mMwLS5mKszOJHXiVv4NPylD+C8?=
 =?us-ascii?Q?9OjLO5pCmNn8Jn9O1esOCy3nImRyyEI6BqP9torA425OTPFzVPTh2YRVtHlU?=
 =?us-ascii?Q?z7k7sJ16jAbs7yvcv1vUUc0ztvZ3PKz/lnrvWmIFhhepmB6U37GXC6hLGmRg?=
 =?us-ascii?Q?YLKbvO1pJs7RqnTrFxZzK1yrSGsPa7VyQMJFCfL2wqgfBqUB28fWDdIA1nDH?=
 =?us-ascii?Q?QJg1UFlooPg9LwYPCLlNFQOaoBtbcChHC5oUv+JKNm0NaEAMRr2SN8+npVuH?=
 =?us-ascii?Q?irUmj49Q2BoDderwv3WLNMtcYJHDKjGtuyMzPoKcc5XIK/nA8XURYVAnTKQB?=
 =?us-ascii?Q?jzd5AGQGjmKJZg03x+V+ZB0D0PXrApSiUKJgqk1gRwBTDM8gDVebIB9woUKU?=
 =?us-ascii?Q?U7WNgJBwVP37AlZHnL/LlCOjYOE1rB9uknHEiZEQro3O8DSbmIwW1nVBlRIw?=
 =?us-ascii?Q?plUPWb7UhU1vhTCTYZh65FK0JY8XgKkVYZ+gbjPe3ruoHJMlJV1HyfpH81ns?=
 =?us-ascii?Q?gsqzcY6eLXfYKKOCq3LjrxRtblATolGPMzB8YflBmN1vy9PTJV3/3oqWfSmf?=
 =?us-ascii?Q?M40TLgLAbYbZzd2Tsri5rjU7QDcMnfA0QpBVf1/CW8rOhvl8jy6a4uKX4ubw?=
 =?us-ascii?Q?mQR/e9u07M8Gxm7ph6oPeoC0fV3uFAa8BVOg7/ixyW74CBTFkKrYMhUEzOJn?=
 =?us-ascii?Q?i3j/DXzBcSvaEk7dJiaTIUElAbUyi5ZEFZqd9zAcG+6WaUxWSTj4/Ih+5R2v?=
 =?us-ascii?Q?NB2kSE562vdJCkLSYYnzxuG116FNShm51Pr0UV3WoRSHp1b4yTJ/o/Ew8X5B?=
 =?us-ascii?Q?byx6AqkrD3z/rAR4U4IPknpM3R4Km6wu0pOirjcBfBimzRJAnZe3IUAyUDpW?=
 =?us-ascii?Q?Zl5H2yIBsObrrTvbZzddCs56OOS8hkmbczg4tJqW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6440ca-d949-4a05-7201-08dd5bbf8d80
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 08:27:22.9519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n51t855Aow7e2SFrjTRt+ldP7RSWgKXJ7WVR3nZdC0hc4xzQotwwCMw9wPvebp1iLe4e+4FsOcJllVfYJykxQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8387
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 08:27:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18032

On 05.03.25 09:21, Claudius Heine wrote:
> Hi Jan,
>=20
> On 2025-03-04 4:11 pm, Jan Kiszka wrote:
>> On 04.03.25 14:07, Claudius Heine wrote:
>>> In case encryption needs to be enabled via an update, while still
>>> allowing the update fall back to work. One update step where encryption
>>> is supported, but no reencryption is taking place if the device is not
>>> encrypted.
>>>
>>> For this the `noencrypt` hook is implemented, which requires some
>>> restructure/reordering of the `local-top-complete` script.
>>>
>>> Signed-off-by: Claudius Heine <ch@denx.de>
>>> ---
>>> =C2=A0 doc/README.tpm2.encryption.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 ++++++=
++++++++++-
>>> =C2=A0 .../files/local-top-complete=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 +++=
++++++++++++----
>>> =C2=A0 2 files changed, 40 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/doc/README.tpm2.encryption.md b/doc/
>>> README.tpm2.encryption.md
>>> index 3f7e89f..a97425c 100644
>>> --- a/doc/README.tpm2.encryption.md
>>> +++ b/doc/README.tpm2.encryption.md
>>> @@ -42,11 +42,12 @@ The initramfs-crypt-hook recipe has the following
>>> variables which can be overwri
>>> =C2=A0 ### CRYPT_PARTITIONS
>>> =C2=A0 =C2=A0 The variable `CRYPT_PARTITIONS` contains the information =
which
>>> partition shall be encrypted where to mount it.
>>> -Each entry uses the schema `<partition-
>>> identifier>:<mountpoint>:<reencrypt or format>`.
>>> +Each entry uses the schema `<partition-
>>> identifier>:<mountpoint>:<reencrypt | format | noencrypt>`.
>>> =C2=A0 - The `partition-idenitifer` is used to identify the partition o=
n
>>> the disk, it can contain a partition label, partition UUID or
>>> absolute path to the partition device, e.g. `/dev/sda`.
>>> =C2=A0 - The `mountpoint` is used mount the decrypted partition in the
>>> root file system
>>> =C2=A0 - `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting
>>> content of the partition. This reduces the partition by 32MB and the
>>> file system by a similar amount
>>> =C2=A0 - `format` creates a empty LUKS partition and creates a file sys=
tem
>>> defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
>>> +- `noencrypt` will not try to encrypt the partition, if it isn't
>>> encrypted already, but will open it if it is. See the section
>>> [Encrypting the shared partition via an update](#### Encrypting the
>>> shared partition via an update) for more information
>>
>> "...encrypt the partition if it isn't..." (not sure about the second
>> comma as non-native speaker, though)
>=20
> fixed, thx.
>=20
>>
>>> =C2=A0 =C2=A0 #### Encrypted root file system
>>> =C2=A0 @@ -58,6 +59,25 @@ The mountpoint is empty as the root partition=
 is
>>> mounted=C2=A0 by a seperate initramf
>>> =C2=A0 Both partitions are encrypted during first boot. The initramfs h=
ook
>>> opens `${ABROOTFS_PART_UUID_A}` and `${ABROOTFS_PART_UUID_B}`
>>> =C2=A0 during boot.
>>> =C2=A0 +#### Encrypting the shared partition via an update
>>> +
>>> +With the following requirements, special handling is necessary:
>>> +
>>> +- A/B update scheme is used
>>> +- Both slots have a shared volume, that needs to be encrypted as well
>>> +- The system in field is currently unencrypted and encryption should
>>> be added via an update
>>> +- When the update failed, the fallback system needs to deal with an
>>> encrypted data partition
>>> +
>>> +If this case the fallback system needs to support an encrypted
>>> shared data partition, but would not encrypt it themselves. For this
>>> the `noencrypt` flag can be used.
>>
>> "In this case"? Sounds strange.
>=20
> fixed, thx.
>=20
>>
>> "themselves" - where is the plural coming from?
>=20
> There is the rule: "He, she, it; das S muss mit"
>=20

"the fallback system... would not encrypt it itself" - it's only one
fallback system from my reading of the sentence.

Jan

> I went ahead and let languagetool decide, and it also wants there to be
> "themselves" instead of "themself", but just to be sure, I rewrote
> 'themselves' to 'on its own' there. (notice the s there as well :)
>=20
>>
>>> +
>>> +The data partition in the fallback system will have the `noencrypt`
>>> flag set, while the update system will set the flag to `reencrypt`,
>>> this will handle the following case, for example
>>> +
>>> +- Un-encrypted system on slot A is running, shared data partition
>>> has set `noencrypt` flag and is not encrypted
>>> +- Update for enabling encryption is applied to slot B, where the
>>> shared data partition has the `reencrypt` flag
>>> +- System reboots to slot B, encrypting the shared data partition
>>> +- Update fails at a later point and is not blessed, system reboots
>>> into the fallback system on slot A
>>> +- Fallback system now needs to be able to use the shared data partitio=
n
>>
>> Where do you describe the "format-if-empty" usage of patch 3? Seems that
>> is an important element as well.
>=20
> I will add a note there in the format-if-empty patch.
>=20
> regards,
> Claudius
>=20
>>
>>> +
>>> =C2=A0 ### CRYPT_CREATE_FILE_SYSTEM_CMD
>>> =C2=A0 =C2=A0 The variable `CRYPT_CREATE_FILE_SYSTEM_CMD` contains the =
command
>>> to create a new file system on a newly
>>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-
>>> complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-
>>> complete
>>> index cf49e63..1ef784d 100644
>>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> @@ -240,18 +240,32 @@ for partition_set in $partition_sets; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ ! -e=C2=A0 "$part_device" ]; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "Could not=
 find device=C2=A0 mapped to '$partition' cannot
>>> be encrypted!"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> -=C2=A0=C2=A0=C2=A0 decrypted_part=3D/dev/mapper/"$crypt_mount_name"
>>> -=C2=A0=C2=A0=C2=A0 # check if we are trying to mount root
>>> -=C2=A0=C2=A0=C2=A0 if [ "$partition_mountpoint" =3D "/" ]; then
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "ROOT=3D$decrypted_par=
t" >/conf/param.conf
>>> -=C2=A0=C2=A0=C2=A0 fi
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 # If partition is already encrypted, decrypt=
 and continue with
>>> next partition:
>>> +=C2=A0=C2=A0=C2=A0 decrypted_part=3D/dev/mapper/"$crypt_mount_name"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if /usr/sbin/cryptsetup luksDump --batch=
-mode "$part_device" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | grep -q "luks2"; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 open_tpm2_partit=
ion "$part_device" "$crypt_mount_name"
>>> "$tpm_device"
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # check if we are trying to=
 mount root, set ROOT to
>>> decrypted partition:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$partition_mountpoint=
" =3D "/" ]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ech=
o "ROOT=3D$decrypted_part" >/conf/param.conf
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 # If partition should not be encrypted, cont=
inue with next
>>> partition:
>>> +=C2=A0=C2=A0=C2=A0 if [ "$partition_format" =3D "noencrypt" ]
>>> +=C2=A0=C2=A0=C2=A0 then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> +=C2=A0=C2=A0=C2=A0 # check if we are trying to mount root, set ROOT to=
 decrypted
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
>> Jan
>>
>=20

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

