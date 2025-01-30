Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52E1C0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:39:18 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.15])
 by mx.groups.io with SMTP id smtpd.web11.12041.1738229949774553286
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:39:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kXYREcls;
 spf=pass (domain: siemens.com, ip: 52.101.67.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMnx5jmkfW5aCfqdfqKxDwGii67AW8SnlT2lRoGTWQydCgadJExx6vbSZekDAU68kP3k9TIUxkKEoGFmjBG6waePQWocyVZTUyXoFTko+croTUPl2GyOtbI/zMwyBUw2zApOsYqRvy9L2RGj1A6soKyre2DnEhhtg70MY7/c6sciMH6snuJdNfvdVxSbUzE6+cVb6Rem2J+WfwA3WLFNk0aMxsME8NlHfsXJ57J1FXDH0W90C+Vu+j5qeKUG0JOyj4j2OoWVoFSVevIgeRRR7LCYlRucNI3deBpnGPlGa0L/XnTOJVQW5ZqaRSt7crAwMVcXh0HSmLeng/crR5vMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3lElYRufikE2TxAWdVOZbw2wlrxdGUO/303QmTkaBY=;
 b=Y9ZDvrQI398kUECUmGrkBOCuqU3AwcjKjP4cOn9JCjkQGl5HEcFCETcYe3Tmtd71NybkeZs0RqLdtRozs9PRQrnoAuRtt2Lh2F5DoeXlU0vANGmP5fQSAY0l2ieKO4Zp8rVhK/n/ggYfXFjtMXZ9MG3KL2wUuLCck/5ZnehgasNpje8Yy1w4A/CL2/aN/q2BQ7mioV4AcPE2OcHv3FhCzVXwPJruVvP3izSPYxf9V8h4Zojna+k0Xqaic/gHH3czKfkPereGV1FVQ6xfcq88S4LI4B0CpjgAImTlNnnrBgaI3GZJrsf8/lYMjv3ZDZDdPihW9xhomS0vhAzRdGggxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3lElYRufikE2TxAWdVOZbw2wlrxdGUO/303QmTkaBY=;
 b=kXYREclscEBuPgJI2gECHBOcQ52/XdEjO5t8RWse4INTfq4OWhxb3X5cHTFwP2/r+Ivd3CxcjKTEBuO+ehesAulN5OpV7GoKE7MoWiutEqHntruQEKR62Rr3pqacmuMO04rqr15aLOZVKLB+nHd4cJ7fP3q1Gf0ZDN5ZgNvp1ElEGJVKZ8aLGdLDZq6ukLBd4LowIIzN0VC+88VZwfRbP2jpP1PuEbKKmmOhx3Ia9xbVWXlH83VUwB/ufPeCRNr0J1zZR183QCEUWONNcnp1+4tapVtsXlTYiql6IacMw4hrWLGp90kLXxXsbyOHh5bK55Yr6n7YZnTHGQ3tiPefvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9054.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:239::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.5; Thu, 30 Jan
 2025 09:39:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Thu, 30 Jan 2025
 09:39:07 +0000
Message-ID: <023fca75-ae89-4101-82af-d59e111bfedc@siemens.com>
Date: Thu, 30 Jan 2025 10:39:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] read-only-rootfs.bbclass:
 Exclude boot,home and var from the erofs and squashfs
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, ludwig.nussel@siemens.com,
 felix.moessbauer@siemens.com
References: <20250130085342.2806658-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250130085342.2806658-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c83451a-d53d-45ef-a59f-08dd4111f0ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R0lyLzN0dEdEeFNzd1hadlExZWc4S0VtY3E2QkFKKzJzbW9sMXNIT1Fhb005?=
 =?utf-8?B?bkk5V0dqSUF5dFdjUlVtdXJ5QnpLUVpPeWxvSjZ6aDIzUXIzOGgweUNka3k1?=
 =?utf-8?B?Tk82YTFEMUIxVEU4a2MrQUt6R1dEUm1kZWI0bW5zOVVZaWdmOVRsOWhkNDVO?=
 =?utf-8?B?U1lnRitLTGdkcFRqTUx0OEJUZEZhOVJzb1puTFVZTHlNYittb29pUHVxeTdO?=
 =?utf-8?B?aG5EL25BRVdQV010VWI4RXBKZ3pMYVVmRWxZSC9USm4xb3FQWWJQZzl2RjU5?=
 =?utf-8?B?ZGM2eUZ1UWIvSnpqUnVpMWFnUU01aXFHZG9Yd2FmK1p3RnBhSlZta3pOOXMr?=
 =?utf-8?B?RDc5bmJLeWtCZWIwem1oa0JPbUZEN1NkV3hLa2VxSHN0SGdHOHczbU9veXlh?=
 =?utf-8?B?d1VJZHQwYXRyRy9ia2hIZXlOVXlNbmlTQ2gzeVFmc211U1lRbXpKTVVtc2ZH?=
 =?utf-8?B?VytpL04xYmxySVNXa3VLaDZOc3ZCZVREWElYQi9USk4zOUdXVzBsLzBOYlgy?=
 =?utf-8?B?aGhwTTQ2b1I5S2p0dy9sK0UzWkRKZld5LzAxZWRPMDkzbi9pdDlTbjEyWkxJ?=
 =?utf-8?B?RjIxSk45dkxFRHlQWXRTaVN1MU1CQktveHExSG8wYXdhM0tlUjArSTF0ZnY2?=
 =?utf-8?B?U2l5SEEzMjVHbWNFVW9vWUxIa0tLWHJpVndiczIwZ2UyVHViSDBKMUVDQ3JQ?=
 =?utf-8?B?cjVRUWVEeUZNekI3OVJ4bHc2Y003enl2M0ZCUGpac3hFRDUrbmtaM1BmN2Y1?=
 =?utf-8?B?WjV6OHZ6dm1qenFpbm5UZkdkSXZPTzBabG8wL3F0V1lPL0p4TXZQY3JkOThV?=
 =?utf-8?B?bUE0Ums3aEtTRlZ1cHMwQ2JpMldSYlhqWEpPclJXYTk1aW9JVVBSK3kzR1lm?=
 =?utf-8?B?VVlYNVN5U1NzUkh0dzJPSmkvSTF2aWRGeXplYzJPUkZrdUwxZlVHeWY2Slly?=
 =?utf-8?B?NE5MNnArUUsrMExnckZQWWhrTFM1cTgvUm1YUVBUQ3JiUTlnOWxQd0JpdjNx?=
 =?utf-8?B?MFZuNXZtV0hzbXlGNVFxckpvVWhhb1NRUVJYdCtpVG5NVUxwbUl3Mm1ubkli?=
 =?utf-8?B?dG9PRVJLUGs2NmpYbjdjVlNJKzRVN0lzbVJnZzJnNnpMT2E5VVVFdmNiSXVV?=
 =?utf-8?B?TnlXSmptUXlmRU9Wczh1cWtESm1UYXgvUUE0WjJRMnN0UGJ1RExyckorMTVn?=
 =?utf-8?B?dFRyZzh3WUZFWENFeVpFUnpNUlRpcGVxdkVyUHRVOXhLb0FVVEdLTXh0REVT?=
 =?utf-8?B?SnJmOGVTL3pLZ1RLakVoTmdyODE2bHhKZnhJQ25JOTZlZ0dtdkFmR3Y4TXN3?=
 =?utf-8?B?TUdDZk9ZQmE4VWZnd25GZXE1TFRTcklFT09XK1hsOCtGUlhqWTlCUzFpNVdJ?=
 =?utf-8?B?NVovYzcvOTJQVlgzL3RyZCtzWk9rZW1lNGhYWEdMTmphSVhkZjAyT3MxeldJ?=
 =?utf-8?B?SDlkMkU0T3p1T0IzOEdSbEd2WWxTSXZyM0VKaVFQZ2t2NjR5TnkvaklYNUhR?=
 =?utf-8?B?QmRaclZBWHFKN0plUFlwOVhxUy9nVjFDeDdOQzBEa2pBczlTakIvTVQ0UVgy?=
 =?utf-8?B?NXBjbzlkOFFuaXcxUlZJQVpaOFZLQlQ2M09Hd2pnL3p6VGNLWGZQd2FNSmRR?=
 =?utf-8?B?aUMxazRtRUFGdGZSN1ZOektteWMwWDdlc3lISVBGV21TOEwrY3JzaXZrZ21D?=
 =?utf-8?B?d2gzc0FINk1EUzZMeit6c2l3VWc4MUtISGJ3a3V5cTJwTUNHODEvbzlLYWMz?=
 =?utf-8?B?WDNxWTRjYnhVRkNuNHpJWWFSd0lBUnZUeU56NVI3SFZUcUIvYWcvRThNNEtn?=
 =?utf-8?B?WkYxS0JDLzcvTTFOais4N2xsdnVUaFBPOUdtUzZqdWFzT1QvNkJLYk1yT2lP?=
 =?utf-8?Q?2lt7sWZBLag0n?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cEtHMitsWGMzK1MxZkIvSUlqVERpNmNONWxXR2xnT01TUHQybWM4WDFHYkZW?=
 =?utf-8?B?bG9tWTZsb1VnWmgrS3VQeGVFY0FrQ2pJWHd2RFZNMUZxSm9TeU9XZWN6NjJJ?=
 =?utf-8?B?bnFQY1ZUSGttaW1DN0NFb1BqblY3RzNYZWJwWjllK1AyRHpEVXlONlUwa2hK?=
 =?utf-8?B?WFBBcXNxck1TMDI4bHdYYlc4ZDNDQnZQTUZ3YTdaS1Y2YkVyQWZHeVZTQy9j?=
 =?utf-8?B?dnFlTy8wL2hGMzRZSnlUbnpOM2lnVHlWazZaL1Z2UlFjdDNSY0h0c1hDQ05W?=
 =?utf-8?B?TkIzbFpWbVcvTkpWM0NRckNOTTdhUlZteXRnWS9JS1UvcHpqZ1JUWWdoVnFp?=
 =?utf-8?B?MjZocGdCZklSNUpoeGE5VG5WQUJKcU1ucThaQnlhK0EySkd3Y1NEdEprczUy?=
 =?utf-8?B?RUJnODdjYTdTYmhsSlYzU0Y1WnFlTGlwdDJvcUc0SjVnekZoQ2l1S1MzV3Vi?=
 =?utf-8?B?OCtoUkNqL1B0Q3VIdlhQL2pSUk1kY0lyMTE5TzJ2dk9acFhOcE0zU1MvdW4y?=
 =?utf-8?B?U3h2SFd4eG9GazdqOWlhejcxT0orUFRCUFpRanZQYTNwMG1uK1A0TGlxU0lF?=
 =?utf-8?B?ODNLRyt2TWVsV2YrWDh2a09hWFhpSGdWZ3A3SXMvbUtCYmlqckQyK2JNbVZN?=
 =?utf-8?B?MzVSVU12Wkx1QzlaOUlJMkhYUnpiMXByS2o0aGdCT0hGSTU1aGVWV0ZuR0Vv?=
 =?utf-8?B?R3h1VlhBL1BDTlByRWpqQ2tNN1ByaGNZVHhsSjlvVmF5ZGZueU5ZWHAxVDF5?=
 =?utf-8?B?Ym1JeHRhcWV5enJOaWY4RzdGYmtRNWh0YkltSG4rOHo0TUg1WTI1TkM4T3ZM?=
 =?utf-8?B?S01oRlNNd3NCR0pIVzh2eFZlS21QWTNlSHVRS01BT3JOK2d2Y0J3OWtOckY1?=
 =?utf-8?B?UXNRUEhTbmpmc3VQLysxbG9MZEVpQkxiN0JreGhwVXh0VXphNzNIS1JYeHAv?=
 =?utf-8?B?TXdDZ0FOYWlmc0d1VW5ub3g3YkFsM2JpbjFkbWZtbHBkNTd4Q2tsWGR6RHUw?=
 =?utf-8?B?N3U4RXQzb1dSZXNITElPUXRkeFFsMmwvSjJOYXBuSUVOYXNQcUhJclNTUHMz?=
 =?utf-8?B?c2lDVDIvMTJJT0I4UVJWSGRHU0haYW5mZTI1NjNUaWdpb1lVbTVQK2xZZ3lX?=
 =?utf-8?B?aEFnV2xFK0xOQkZaUm1URVdsbCthdXNLOXhud0hGVGozNDZvWHZTeFBZVDlG?=
 =?utf-8?B?b0RaOWNnUlZUdDl2VUhIbFg2bWwzRU1mMG1XeitESUhsSVlCVlZTdFJKSkp4?=
 =?utf-8?B?M3hyRWRkbW10aHhsV3RHcm5PNUxsQlJMNjNQVEwxaVlKWXJpM0hhL3NsWXJJ?=
 =?utf-8?B?eG9lUUEyUThPWDRPS1Fja2N2Q3dqeUIxWUNGRGlyYVhDUHBidWlQcmxYMjNv?=
 =?utf-8?B?ejJxcjVjVUpRb1ZMWjBjUU5hY0EyK3hUOS9EYURuS01mMEVYOWpqbGpVS0t3?=
 =?utf-8?B?SEJtbHNPa3JZZm5rY3FONzN6OFFmZDBENXllS3p0bXFXVzNST0pNY054cUlz?=
 =?utf-8?B?dG9oRmwwOE1PYlphNXdpaEd0VHdhWVhMcjVJSHpEK1c5aW55aHR4akluMGVj?=
 =?utf-8?B?OGxLYWkya0JKV3E1UlZtVU5XbDFOKzFLRjA3bjJDakdBUWYrU1VWTlZpWE40?=
 =?utf-8?B?di9vZXRHOW9EZHlCUWVla3UvaEtOZmxyMk4yREdwS0NHNW1pL2NuTjA4WXBj?=
 =?utf-8?B?VnF4V2Iyd0U3NzkwREFEdTF2U2p2eUxnazg2U0Z3Rm85TkNOSk5STEtXa2ZQ?=
 =?utf-8?B?cm5nNEhaSWVTWXNPKzZyKzNyazFTRE45TVF1WTRBVDlKQmVubmc1NVNmTktz?=
 =?utf-8?B?dHJaaUVtdVFkMy9pbFJ4eEJLSjFNMHBVZXE4eW9NQTJ1V2F2amdTRDhaWC8y?=
 =?utf-8?B?YVJmWWVxb09mV3E3VUEyeHdFUGFZbVgvaWdLanl0UksvemdUd21GVndlQThN?=
 =?utf-8?B?Zld2STNpZGUwSUdRN2hRYVp1bUEvc0dSZnJFRk4xWWRaY045dUxUb2ZvSWpy?=
 =?utf-8?B?OTgrUEV3c2ZwMk5sSFJRdEVXUmxKTGlLbnMya2NWa1U1SUxNZW4rWmlodGVw?=
 =?utf-8?B?eGthZUUwVjdxWnVKU1daU1E0Umw5QjN4NWc2QmE3V1UrU0RNS3puMUh2cHc3?=
 =?utf-8?B?R0I0dXBUb0doWXhpZVM4bG1ESVVPRzlBNTV4T2sxWHdseDNmdnkwTEdva3dB?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c83451a-d53d-45ef-a59f-08dd4111f0ee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:39:07.0065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cf1J4s2YMbhmORmsadsv84mouyhtF7UmfRYNkzkrODA8wGTMXEzfkICdNzZBrDdkTqXZeKr6ZfZAB+CtMJuMlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9054
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 09:39:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17697

On 30.01.25 09:51, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This excludes the content of boot,home and var from the root file
> system. Home and var are stored in separate partitions and boot
> is not necessary as we use a unified kernel image(UKI). This UKI
> is stored twice in separate partitions.
> 
> It should fix issue #126.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - Also exclude /boot
>  - define empty RO_ROOTFS_EXCLUDE_DIRS in read-only-rootfs
>  - define excluded partitions in recipes-core/images/swupdate.inc
>  - Update Copyrights
>  - Add information to commit message
> 
>  classes/read-only-rootfs.bbclass | 6 +++++-
>  recipes-core/images/swupdate.inc | 8 +++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
> index 9ebcadc..35a3ab3 100644
> --- a/classes/read-only-rootfs.bbclass
> +++ b/classes/read-only-rootfs.bbclass
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2020
> +# Copyright (c) Siemens AG, 2020-2025
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -34,6 +34,10 @@ copy_dpkg_state() {
>      sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
>  }
>  
> +RO_ROOTFS_EXCLUDE_DIRS ??= ""
> +EROFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
> +SQUASHFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
> +
>  image_configure_fstab() {
>      sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
>  # Begin /etc/fstab
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 81c3365..07dbe97 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2023-2024
> +# Copyright (c) Siemens AG, 2023-2025
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -12,6 +12,12 @@
>  inherit image_uuid
>  inherit read-only-rootfs
>  
> +# read-only rootfs with /home and /var
> +# as separate partitions is used
> +# /boot is excluded as an unified kernel image
> +# is used. This images are stored in seperate partitions.

separate - spell checking editor?

> +RO_ROOTFS_EXCLUDE_DIRS = "boot var home"
> +
>  SWU_SIGNED ?= "1"
>  SWU_HW_COMPAT ?= "cip-core-1.0"
>  IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"

Looks good to me but more comments welcome.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

