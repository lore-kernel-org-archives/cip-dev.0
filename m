Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03039C021B8
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 15:13:06 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.33])
 by mx.groups.io with SMTP id smtpd.web11.24114.1741101179775957109
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Mar 2025 07:13:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=RKTAEL3E;
 spf=pass (domain: siemens.com, ip: 40.107.162.33, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVEBCVU//fprt8887WTLWLscsM/ydG4pFQDbx1dHo93/4NvQEsYoGSjnzgAmUvDNli1mO6LDRu3xK7lTh1CJV34T2SMMh7mW5Tw6hwsax1/Rlj7gJl9QubPvLl871Cnc+Uxsg7nOw38TeMTT/ONWS2BuRrfwek+fEl71TFG4fTjhXnOfUJ1kUdurdf1yEJeP+DV0FT9XaQK9UcqecAhqh6g8rTsCijPyhpH13MLwKNBi/cwMidiwXgbL5j7CldTHqop1Ssilcgx4IUX3mGStRMSno/Xkx3W/NK/QcCrAFfgMZA59X8cMKOv1ZUv2kE1wLWMnOEMIDt3WmqLuqoWzpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgxDP7R26kQ+5Dy+ug3x5V8E1vIP5YZvH1awsWAiRbk=;
 b=XG9gs/G590X02t/LDj8tW9hxNQaKblobW7oU7mR9S0cHqPG+Fnwpi+SZCVl0L/KoPlcX/AJy4XZG1QlVuHyv8uS42HeDSdsOj3r7miHoKKZSbC2wlpLZnUNjnkTRKNnrcodetbAl6ceadcKYXLkKtH4o19P+2lTV6cyzHVP7UkGh25NMUKVpzyb+exqTNLy8glmOuZOgClVh+ZJNSDGGDivWE+V+QII06hUW/p1453MAPNOfHVkJWNVUh51u/8sfq2TZixgqZq/Wq6Agf9Vo9eAGkMGlP7Op8nq21iSXUTmrXO8PLXAxOZxMnIe5YD5D9aDeh8UyKnAK/5rXIrJaCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgxDP7R26kQ+5Dy+ug3x5V8E1vIP5YZvH1awsWAiRbk=;
 b=RKTAEL3EzFwrHXrllA9/6wzg/KnTkotlI4tlRmTN+LcWx7ehWWQW/EKvS3DTAV+lY0g23O747BO2TLSttfb1hgE9ITT6A82epM+ZBdEVvODQ/gkIIc8/hkuVb4NHoM07zcosSiw8sLFqA5h6Ge3NJ/ZrKQ/bwJPgeNPKuIuZEkGOqEweelvB1a0cqeE1xIIsx0cUPFu3uX0ncEFZX6ZNSHvt7Rb4c6FayMSDHuU6yCdBSGmNpw6CgpzUbpvSytQETHl7JYbLBcnsSba0uxCzja/L7ZEmE4R7+5gEg6stsLL2EuL4KZqYn+MeLmN5xqBNTeN99cxGS+OxpV45RYiyKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8690.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:441::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 15:12:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 15:12:56 +0000
Message-ID: <57d7ae71-ec8e-4acb-b14f-9b5e93d20f09@siemens.com>
Date: Tue, 4 Mar 2025 16:12:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] initramfs-crypt-hook: add re-encryption recovery
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
References: <20250304130743.2812183-1-ch@denx.de>
 <20250304130743.2812183-5-ch@denx.de>
 <3d4d80f3-64c0-4d2c-aa32-f4987f370eed@siemens.com>
 <24d1b6ba-f774-4616-9c1f-6de0b555932a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <24d1b6ba-f774-4616-9c1f-6de0b555932a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: af278e15-8315-4c7f-f97d-08dd5b2f0b4a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?MrzJjTP6E+QGcRnRa9rcn4FfdE+7tKH8Rky9xPa6pK8VIx8Hogv/ivP9ndbh?=
 =?us-ascii?Q?uulFapBgQy5P8BtJ4zFOwN384vnbQ5vFlVFBeBYlL4JwdUTDB0TBaYvWTA4Z?=
 =?us-ascii?Q?I0gsGxNIOL/eo98KK5dB1WeVgo7tQAOFJMu4siBTH3c/2UxYNDTqZQrRpx9c?=
 =?us-ascii?Q?GhP9OTLbk58LNzmYAze7t9Whx4mNOVM3NT5aiuiKUU20rZluQr1TUcQVyp7X?=
 =?us-ascii?Q?hxr4+Fo0oi3QdJCfBH8P9WxOKDJJIXXvJrTE7bfNAa9TI7hgQa/W+IJE4ikn?=
 =?us-ascii?Q?U7bHkzyzpt3Dx6u0VTaLWiELfQipbeLgHna5QZCnUIqkUZT+aEhCTaLMR9Lc?=
 =?us-ascii?Q?1QnMmFFX0//yInIilE1fXQ9e0EwR8xPCntygvE6cMd9XVF2ZA/FGbtdXfEwP?=
 =?us-ascii?Q?8H4bSfUENHIaoZQTtPgIME4dvunmh7W6QMdycCXG4JEsGulSubD4nYIe1vIj?=
 =?us-ascii?Q?Odn1S4H5ctwtn+2wagiZMKdxJct3sioobQfyb25TnUwh8/jAkpM0aCg3KNIM?=
 =?us-ascii?Q?zJbTGolRSuCySUKg3IQMn7XOjpPktQH6cJRvikNUGKYgtyrxp3QUthHpTSmt?=
 =?us-ascii?Q?niTb3sjKeM7lEU0ViI/WcGmr6u+NwFBuIR/IJLjZLtB2yCfujznQSEoHn/i7?=
 =?us-ascii?Q?CtgH+vD5dcRkLE5aZE9VHn8PIQRMrR/szcaq8nBovKxyjBMKPIjr3Ifl5DL6?=
 =?us-ascii?Q?vgLq0orArn2QcORH8OI/OpcJR2jC/VlCNOyXrayZs+ZsnLTT4xrsUtgICyNx?=
 =?us-ascii?Q?xF+hOJzAbVguKfv/4d8rt2BamYqhENcmS4Okeoxktq9qD0ZFeD84YKpx+cEI?=
 =?us-ascii?Q?l1RBJRfIyXIT6UUlSuM09SCUYAScMoL+3qf58Mz+qkxdPbEvkdjwf5nb1lEs?=
 =?us-ascii?Q?4VvbM2LugoXUoO+5YTxUhR9XmRmHQtdUL+hq991p/T7kX4TTutV+HJ4t4ZYJ?=
 =?us-ascii?Q?LHepTqBvhxx8KSgf9tUaJUxABrQDThh7sUCjXMw7z+kqurkeb97KnRbFJPiN?=
 =?us-ascii?Q?n6pMjpEUe9NOSTZSM+H78hphnBvKvRr0yaj5hS+tWnZxKS61xazVSL9pXFx8?=
 =?us-ascii?Q?Z8DJN/3qBiAXqnQLxhMzx+30ix/pHJ/68apjm8vVj2cCaNG0Je+2LRNQElOg?=
 =?us-ascii?Q?iaPQxu8U5G1NLUvMTobXaws/9SzLxkt9ZwVPa0eAIigl5UoRji4O4jJnkYG6?=
 =?us-ascii?Q?rT5w2hwMY7fT9Scjb8qHSS4YlGp/R3D28oeIa60DFKOySpbQ6joWKIVJNjnU?=
 =?us-ascii?Q?jjF0xX8IDyGg8BnYioRBJf4Xf6t4FR9HHiglH18p1WKsIWtLSZuZx/y1KGyz?=
 =?us-ascii?Q?jS9zFm7JOrvnhkYSTZ1U1V9/08Vlt/adn9ngJX9mzja5oKRQv1S5HZdUTP72?=
 =?us-ascii?Q?a3beWWu4BVK72yP4miV5KFttfgE/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3v/8qz11mmrHBcOxaTZrc9Qrcw2CSHJdcPOJG7bAhgPPKa8JjyPhKo4tvCmn?=
 =?us-ascii?Q?Y6rYnNZL4fuvzgLEBsbWnoYprt2zNyYKV5ZQfR/OGDZTe5/J7Tj5ne010qHl?=
 =?us-ascii?Q?gpLGQtYAqe21JKl50NHRQRHtfWNRKrjGgb2ABjQegNrg9x25acpDJcVQhy9+?=
 =?us-ascii?Q?SFuA8W8vvJxeEtdFLlmY8et6FTxbVvs/fBNl/2q/CZIS/qeuXVjrm3evY1gp?=
 =?us-ascii?Q?hHuOMOB2KbeP9aMn5oBpbTOaBUaN++9oPLCHj1x1M3mGMTRndh/1Yq0mCyww?=
 =?us-ascii?Q?n8ucTXhXATuDd362T7IYS57zIiORnCFrCc9SjptjOyfbtC+lWwalq+M+6iBU?=
 =?us-ascii?Q?RgV11VDe6ineRLQRGenYpdzxUlonjXjXyhPhPN1jpt/QLXcYR5lhIgXvrVUE?=
 =?us-ascii?Q?ZPSckDzQYlNsn8G3qNzUzjHoIVLNA1LwTPv9FLxmWw+KgmGyOT5wfpBu79c5?=
 =?us-ascii?Q?1JaPOj+R4zTUSTVKA21LaQgXUeBZW62wzShQlIhmv7agRLn+FuFXkShbkdU1?=
 =?us-ascii?Q?GMgkZBaV52f0luDsWNfSdxWd60T3IhnHyN4O5ompWuM1eESntyV/MEq7jomb?=
 =?us-ascii?Q?GXcutHyXcZJxvoYWKpJNRwrLRmdGCvfLAqZvKJVEZbI2jUbQII21EV0hIqdR?=
 =?us-ascii?Q?CraZwFkCP7b9zycHxMatTIlysrjCuXOV0jkAvcOcuKmSFh8HpbSLYDP6QOj5?=
 =?us-ascii?Q?G/AQL2iyLardD4CCu3VAPzmqOblYTiEfqvRj7q0o4LazFRvJArRTCAlQ4RfW?=
 =?us-ascii?Q?S126kDb1oJK0PSDFEHXqwOPK4tenYeXMBwiPUqDVjWAkLQSlW1maoQxrSWOU?=
 =?us-ascii?Q?G+Ty6PxMtFeuZnq1Vp8CHbMLBNNANqwMloR95cHDuerChRRZatLf63YtC4mh?=
 =?us-ascii?Q?YXKpqz1qqKDGhCymet2KR8LvotGQxfktI6weMFYNvRm9G4jmKCTOhP5ziO6n?=
 =?us-ascii?Q?ldaqYIIV+o80qDya0DBv5AYWg8ZS2LxlWsLZ9+CmbhYlu91WixiD59u94/6r?=
 =?us-ascii?Q?SKEb5Qu7+NFT3NQ9EVF0i5PaMgS/x6lW1t2qOPzkh18z/h8OY6VGB5cfv+fh?=
 =?us-ascii?Q?msAKU5wO2oLsGtRFs653lfL9/F9HXRt90wtKfOLUPMDrvOw2VNvs4aHn4/zP?=
 =?us-ascii?Q?0LBVPMTLdxqT01ll7ZEkIObMhwGJjBxgqEilQ0v48arJqD0cOkxezC2omZOq?=
 =?us-ascii?Q?aJlTutFcLXzg4juklu4H52PmNll8VXBjtIh6/RKSttzu5a+fODPpdq+bdMsv?=
 =?us-ascii?Q?MQtT5Ml2Qvxt09TcAHMZgqvn410oNxCPaPQJ2qPsYgQ1LONh7wSGeqN/Y+lh?=
 =?us-ascii?Q?GotMBDgmW9RG2r1Lvoe/MxcGwh5XkwyG+CEdp7GOITN3LL+U4d0m4AJbAksL?=
 =?us-ascii?Q?2BVVhLRyxL7B8nhcnOh50XwLIaO6eAFg6naMNsdVBUcBoC2bCF7D6gFApZdG?=
 =?us-ascii?Q?orPKi0fxMRKqjchr8QyTJn6l1ue9pstBFWIcmvTqRpRMfM05/l1cIaMJrFQ/?=
 =?us-ascii?Q?WOaNn865jS3ukTI2lfJEwgPJnPKG9Afle9LNNxpONweAS7IDAFrcnQinkI8t?=
 =?us-ascii?Q?J2KKg0KZ3tjG8TjC/D9+HhD/y9mJi2PYzZs8q8Ay/v2N5AQzk81jfzrtJf56?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af278e15-8315-4c7f-f97d-08dd5b2f0b4a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:12:56.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3SfwDBe1Ruy1sn2cedCM8fOQV8Ab/Qymz3jOYmcLMkwvln3NogjJXzwp+Bh5WrxgcsxjblAkS5hsg+G11bImw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8690
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Mar 2025 15:13:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18024

On 04.03.25 16:10, Quirin Gylstorff wrote:
>=20
>=20
> On 3/4/25 15:52, Jan Kiszka wrote:
>> On 04.03.25 14:07, Claudius Heine wrote:
>>> Integrate detection and recovery of power failures while a partition is
>>> being encrypted.
>>>
>>
>> Why is this at the end of the series? It can already help the existing
>> implementation during encrypt-on-first-boot.
>>
>>> There are possible scenarios:
>>> 1. Power-fail happens while the partition is reencrypted:
>>> =C2=A0=C2=A0 - The LUKS header contains `online-reencrypt-v2` and needs=
 to be
>>> =C2=A0=C2=A0=C2=A0=C2=A0 repaired with `cryptsetup repair` before it ca=
n continue.
>>> =C2=A0=C2=A0 - Also no resizing of the file system is necessary
>>> 2. Power-fail happens before the systemd-tpm2/clevis token can be
>>> installed
>>> =C2=A0=C2=A0 - The LUKS header does not contain 'systemd-tpm2'/'clevis'=
, thus it
>>> =C2=A0=C2=A0=C2=A0=C2=A0 needs to be registered and the temporary encry=
ption key needs to be
>>> =C2=A0=C2=A0=C2=A0=C2=A0 removed
>>>
>>> In both scenarios the system after the reboot needs to have access to
>>> the temporary encryption key that was initially used. So using a random
>>> one, generated via `openssl rand` is not possible. Since it is only a
>>> temporary key and gets removed after the systemd-tpm2/clevis token was
>>> installed, a known password can be used.
>>>
>>> The list of these scenarios is not complete, there might be other
>>> instances where a sudden power-fail could be fatal to the system, but
>>> these where the most obvious and risky ones.
>>
>> For recovery of the first boot, this might be enough. But when proposing
>> this for in-field recovery, we should be stricter with thinking the
>> details through. If we fix them, immediately or later (or never if
>> unfixable) is on a different page.
>>
>>>
>>> Signed-off-by: Claudius Heine <ch@denx.de>
>>> ---
>>> =C2=A0 .../files/local-top-complete=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 33 +++=
++++++++++++----
>>> =C2=A0 .../initramfs-crypt-hook_0.6.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++-
>>> =C2=A0 2 files changed, 29 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-
>>> complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-
>>> complete
>>> index 47533b5..e67f26f 100644
>>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> @@ -72,6 +72,9 @@ reencrypt_existing_partition() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reduced_size=3D"$(expr "$part_size_block=
s" - 65536 )"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reduced_size_in_byte=3D"$(expr "$reduced=
_size" \* 512)"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reduced_size_in_kb=3D"$(expr "$reduced_s=
ize_in_byte" / 1024)K"
>>> +
>>> +=C2=A0=C2=A0=C2=A0 CRYPTSETUP_PARAMS=3D"--reduce-device-size ${reduce_=
device_size}k"
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case $partition_fstype in
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ext*)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # reduce the fil=
esystem and partition by 32M to fit the
>>> LUKS header
>>> @@ -90,14 +93,25 @@ reencrypt_existing_partition() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 squashfs|swap|erofs|"")
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ "$debug" =3D "=
y" ] && echo "skip disk resize as it is not
>>> supported or unnecessary for fstype: '$partition_fstype'"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> +=C2=A0=C2=A0=C2=A0 luks)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Check if reencrypt was ab=
orted
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if /usr/sbin/cryptsetup luk=
sDump --batch-mode "$1" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | grep -q "online-reencrypt-v2"; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /us=
r/sbin/cryptsetup repair --batch-mode "$1" < "$2" || \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 panic "cryptsetup repair was not successful"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # already luks partition, d=
on't resize
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CRYPTSETUP_PARAMS=3D""
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "cannot re=
size partition, unsupported fstype:
>>> '$partition_fstype'"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 esac
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -x /usr/sbin/cryptsetup-reencrypt ]=
; then
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup-reencr=
ypt --new --reduce-device-size
>>> "$reduce_device_size"k "$1" < "$2"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup-reencr=
ypt --new ${CRYPTSETUP_PARAMS}
>>> "$1" < "$2"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup reencr=
ypt --encrypt --reduce-device-
>>> size "$reduce_device_size"k "$1" < "$2"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup reencr=
ypt --encrypt
>>> ${CRYPTSETUP_PARAMS} "$1" < "$2"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> =C2=A0 }
>>> =C2=A0 @@ -244,7 +258,7 @@ for partition_set in $partition_sets; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # If partition is already encrypted, dec=
rypt and continue with
>>> next partition:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 decrypted_part=3D/dev/mapper/"$crypt_mou=
nt_name"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if /usr/sbin/cryptsetup luksDump --batch=
-mode "$part_device" \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | g=
rep -q "luks2"; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | g=
rep -q "systemd-tpm2\|clevis"; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 open_tpm2_partit=
ion "$part_device" "$crypt_mount_name"
>>> "$tpm_device"
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # check i=
f we are trying to mount root, set ROOT to
>>> decrypted partition:
>>> @@ -255,6 +269,12 @@ for partition_set in $partition_sets; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 # If partition contains an aborted reencrypt=
 luks header,
>>> switch to reencrypt mode:
>>> +=C2=A0=C2=A0=C2=A0 if /usr/sbin/cryptsetup luksDump --batch-mode "${pa=
rt_device}" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | g=
rep -q "online-reencrypt-v2"; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 partition_format=3D"reencry=
pt"
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # If partition should not be encrypted, =
continue with next
>>> partition:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$partition_format" =3D "noencrypt"=
 ]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 then
>>> @@ -272,10 +292,11 @@ for partition_set in $partition_sets; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 watchdog_pid=3D$=
!
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 # create random password for initial encrypt=
ion
>>> -=C2=A0=C2=A0=C2=A0 # this will be dropped after reboot
>>> +=C2=A0=C2=A0=C2=A0 # use partuuid of the partition for initial encrypt=
ion password,
>>> this key
>>> +=C2=A0=C2=A0=C2=A0 # will be removed after the reencryption has finish=
ed and the
>>> TPM2 token is
>>> +=C2=A0=C2=A0=C2=A0 # registered:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_key=3D/tmp/"$(basename "$part_device=
")-lukskey"
>>> -=C2=A0=C2=A0=C2=A0 openssl rand -base64 32 > "$tmp_key"
>>> +=C2=A0=C2=A0=C2=A0 lsblk -no partuuid "$part_device" > "$tmp_key"
>>
>> This should be factored out into a separate commit. I don't disagree
>> about it, it just deserves an own, clear reasoning. Without recovery, it
>> looks to me like a nice size optimization for the initramfs by dropping
>> the openssl dependency.
>=20
> Why `lsblk` instead of `blkid -s PARTUUID -o value`, as blkid is already
> used in initramfs-verity-hook and initramfs-abrootfs-hook this would
> save more space.

Or just use "some-long-hardcoded-temporary-password". From a security
perspective, there should be no difference.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

