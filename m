Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC500C5475B
	for <webhook@archiver.kernel.org>; Fri,  8 Mar 2024 11:36:06 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.72])
 by mx.groups.io with SMTP id smtpd.web11.19824.1709897761397978700
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Mar 2024 03:36:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eMT5XMBI;
 spf=pass (domain: siemens.com, ip: 40.107.13.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAmqGILhFNtyxMV+gu096J+9hF7aX/HtTSe8xLtPXRPBcpBA9JaxDzVsIqZZN2PgAJ/GNSVdanlfyB2UACICKA81Cfq/dHzMlFUp0Jxttqt6Yrv1DEgbQKfRJ8g+DcPgUS7vz3ThAMMYShtIuddxWd04KU8v44BlvlJLIfzv9vHwRu/i7tT4IbtqHqVu3Y+IEQY8bUo/p4LdbpwTyeVV6Z4hVLZiOkS68uGKlj0F8GLYXJaleIcFk5Ez6ubDFntMtGesP28uetsDaSKBO7scYxWTU6iOPZBxbpvBSUiodkCV/ajvLHb/mPEFzTUCve+zSzDBJaIGHp1xUkoWv2hXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygDBn81+hSARLOCrSbxGVaZSIea5Amg8uZH4fuv2JiU=;
 b=a2POSebVljG1tnnQoN5GUxvDLFhjsP4Qhk7fzeyuj5w82OABzheYdjVTKwGMTpbHIIvYyj4fOGgRgHRzKkPvfQHTkdpdZi8eJ+TGFskL9ZG30JhMdyx/3jKQcfsKVL3TSucKfpH/toJ2Kuv+PyItZatUWgvcFaGRswXtcIty9yiyainT0141Ff4lDdHBs0y75TBOtVZbFhN4lLG0qCyei9SjtF1BKNKFiTQNUwdd9sXDjcWaaVKr04dXIyrrkd07es7eRjp3U2tyi/l87gkUOFyDWMeQtFW+1pV2NZridmwFW3H/MetPVGz0+x5grRk1SM8BjgtOIY6RuUu7vyYnLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygDBn81+hSARLOCrSbxGVaZSIea5Amg8uZH4fuv2JiU=;
 b=eMT5XMBIucJipLWYqx41h6v4YpSwxCsleC8CrPZu40bbaGJecnljVeZXK2p430pZKNQUoxlL//jWyqYlDpemC3x+O/ONYUyjMxKx+r3VPCPeEVlhJJHrth8MRrRwBaHgDVW64xOn3sjBmTdAm52RV7LKmku/IzFLOTVY2vDWG1MObLilgBXKZNZR+uAQOXe1AjBa8nphIVy24Uolhd1LIXPfyz5fxg7S5BakIVflaK2XXDf6GN87gzp2PjqwEe130BSTud9ad7bDCFfNQ14ERZ+E2422i7dxL9nYr/eKndI+Nw199ECv7vxsninPvl5xE3C+QGyZQLhQ2qMj6QyMGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5342.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 11:35:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 11:35:57 +0000
Message-ID: <97facebf-c2fc-4253-927c-29831dab40ec@siemens.com>
Date: Fri, 8 Mar 2024 12:35:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC v1 3/6] swupdate: Enable Delta handler in
 swupdate
Content-Language: en-US
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240307074612.1996609-4-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240307074612.1996609-4-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5342:EE_
X-MS-Office365-Filtering-Correlation-Id: f11bdaf0-1e70-42f4-3d74-08dc3f63ec2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uAzvX5zADrlEsRsC3QvmCZu+PO3LXNcH0ypzxc0aqU2EhbWOnP+8mOCtIlXaw2J49ihjg0p2CwyTznrSG1T78exQSDrfS594EqeyhMEIFJdw3LW4AI1wyxQvGG/uiW58EdiaMdgpFu5RjVFlzXtCPt1O950Uh3EjUZVSaLtscpE5CLoDvz6+f74QHu4IzGArg57i/wMNnGAJaOB078dERfUnWPoQltTjpwJSU9oicMOn4ZAhi4b1Mk6KMdHTXrHn6WrKc/v2CPSBvuqxiZW/CwtqL6FHkiuA1d5BuAEnVtKphWQ95i/oS0so+krz1HW4ArHL5SM3BQF9TfWVFIdrjbW4M94SQ4y/cGpHaH0ovwcVvZzq+qZ9NPXR7j+zOYjMcGPadKl4iP0tMtXDYqlxDreQfjC8x2IOpQtTzaUapGdZCa9wIylcYHTlZsSlxxo3kve/8hhgON4zyIEfN5IVvTxo6nf8ZiOkA0yMh/QxArlumf1g4UnwBYctr1Z/ZRlFguUM6z5KxfoMIJNyClceMbnYnO8juBHwWM4VW1k5ltheFIQTuMSBGMZzksaASYXYwfCMh/BOppfC0ipvb+8Z7usI3epDijaIWws90HdenRM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S3hhYVk5eUlRcndVK2ZGV1pjSkZYdHlJYlk4bTU4NkFtUGJlcHptM2grSGR4?=
 =?utf-8?B?TEZoU1RmSGtVT0h2Qk45ODlzZ3loZjhHa2VDSUNhVTJ0cnZvejRwRmphZE95?=
 =?utf-8?B?Mll6c2xVODI3alloa3d1RlVIakROdWN1L0VlLzEyL3JzbW5yUzRyc1oybVFT?=
 =?utf-8?B?K0VoUWFidmsxVW9vNGtWbWRiTUUwNm1jY2tiRkJha3JkckZrbVgyam5ZdHFy?=
 =?utf-8?B?eEZtY05Kc0Z6VDVxRUN4U3FwaFlMdU9UWFAxTmxBNTZVRE9iQjE4ckpOYzZX?=
 =?utf-8?B?RkVaaDVCcDRUaVpkUzZiQ2ZmYWtuN3BObmtyWlk1TGdEZkl3QjVNRmVyN1R1?=
 =?utf-8?B?bEFMREFuTzQ5SjVXTzFPTXpBZlBVTm9ITVhlS3QwT1V0S090dFJEUHpCdGx1?=
 =?utf-8?B?SWhDUUJHK2NnRFZqNHVIQkFzcGFmTHQxMXl2MWYzUVJBaTJmd0dmSURReWdn?=
 =?utf-8?B?OGpjNzFMSXczb0Zudk5iOXdyRXA2Nk5NWWxFSzljeUQ3QlRpMkcybHR3Njhh?=
 =?utf-8?B?N1MwT0pLaXB0cDdQaWJORDYwaXhGRXprcGgzQXN5NDk1WFN1K3ZWMldDUSsx?=
 =?utf-8?B?dlpoMXNjdTc2ZE84SUMwQWpWOWJnM2d4VVNzVWVheXVzSGJleGxhM0pZYXU1?=
 =?utf-8?B?bTlqWDZaQnkyTWd5SVFTakJIUUx4UThWSEFIbW0ycU9LZDVvVENRQy9nY2JR?=
 =?utf-8?B?aDV2cUM4RDJkTlk4azVCclNGNmhLQ3o4VFg4Nlc2UXRHV1VTd3M1YkNQUHhX?=
 =?utf-8?B?d2JHOGxVSVNnbEtHeThNWnE1NCt5Q2ZCbFBNekYydmNGRUdrM3VJUXpiQmYz?=
 =?utf-8?B?YzRtNG9Bd0E4a1pMV0dzUVBGSXVFYzVuN2hUL2RqeDFsMzJ2WTF4Nmo0Si80?=
 =?utf-8?B?OWtaWDIrcmlVTUVrZ1NaOFU2WFpiUzFkZGNJeHoyMjVTZzViNnhjUlJ3SE14?=
 =?utf-8?B?V0FqTVo4UUttb3NNc2lpZWJma2lBbmhSTmRpTVBuanZBQ2FZMjdZVnQrQVk2?=
 =?utf-8?B?L3hZVXZNQkVnK0psandsTnltTTZTTENFTDBxN3NJbmlVek1qOWZiYWg0UVFQ?=
 =?utf-8?B?VnNJdEN0UVZuNy81NXFsWkZVM2svVGFLNTJ2YkFaUDNEcEcxMmlUWW1heXYy?=
 =?utf-8?B?ZDh6UWFUVG9zamNOdVdtVHpLUzB4cGY3azR5eER4ZWVZU0VQTFIydjVXR3RN?=
 =?utf-8?B?RG0xVE5hMm1UbldBemFzVEt5ZzBERTZTejNUeGpnRTczcXgyVFpmTVI1bHpm?=
 =?utf-8?B?M1BpZC9tY2xUbGFhcHJNSWdjVHhhNG9nTDZDcWdHSWhoanc1cHVHb2hqOGIz?=
 =?utf-8?B?RlBKRHpsN2o5VjBsT0pGaWV2SHVrV3hDM0NuV1owOFNveTBKQTliQjc5SlFn?=
 =?utf-8?B?aiticjdVRUFmQXF1ODBWOEJtaUdqb1dzL1Jnclc3RDFoNituNkV5VVpSVlYv?=
 =?utf-8?B?V1gxalczSWFnWGZIY2k2bFd2dVBUSlVYb3lLMXlKQnBHU3R2ZG1zQng2M2di?=
 =?utf-8?B?QzAxcDZCVGpjVEM1RkltK3FGOEk3ZzgraDdYcGp6T2Z6QUtNYUtySGxWVTBR?=
 =?utf-8?B?c1h1bFgzMUxCYmdpamNhb0NvdnY0MHV3LzFzaTdHUWNSNjVpWGd0djhPeUdD?=
 =?utf-8?B?bTBrUFVlemw5WUJ5R1V5ckp1S3RwT241L21YTkVzQWorbTdtNnV6Qy80Y0dV?=
 =?utf-8?B?UHczNnk4WTM2alc0TVp3Z1h3czliWFVmY05PVGQrTklra3YvWlR5RkdWTHY4?=
 =?utf-8?B?b3p0dnE5VXRoRFVrcjE3N29XV2U4MjJYN3FEWmtkWWNETkF2Sm9tNTBNeVZH?=
 =?utf-8?B?bVpoZEx5WEhDZkpCUjRTU0paWG9rQndwbzBtTitvRHAxOG9VWEdRNm5SRVgy?=
 =?utf-8?B?bXlFR0NJeElKQkg1OExnaWlSRzdOOXd6U1FRTUlldjVmZ2QxRnAvVEhTSHAv?=
 =?utf-8?B?M2RmejA2V0o5S3JPaHJ4VjNmSzR2OStTUGp6eGlpU2REZVR3STdhRG1KRE1S?=
 =?utf-8?B?d3AzcG5iZFNXampTZVRJbHJ1MmI5RGN0UytLSXJUR3dLU0t5Q1BFOWIyTDM2?=
 =?utf-8?B?ck41ZGVjZCs0L1AxdEE3Nnc5YkVmdmlUYWtuYVFVcm50TnVoMGZQZmtXdUow?=
 =?utf-8?B?QTl1bnNLV1QyejV5RXg1VkdvR1k3REdZN2F4M0RQR0ZPL1h1aUdHN2VTMkJv?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11bdaf0-1e70-42f4-3d74-08dc3f63ec2a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 11:35:57.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7p5QjlTAgYTmbMA8MmBN8+tmqHwh61BL2xKK80ZKQx1MNGfxLTw/t1JnEDKVQ2ODvu+SCxAAPcPzBylCIRKXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Mar 2024 11:36:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15265

On 07.03.24 08:46, Adithya Balakumar wrote:
> Enable delta handler in swupdate for bookworm and disable cross compile
> for arm and arm64 on bookworm to avoid build issues
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  recipes-core/swupdate/swupdate_2023.05.bb | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
> index d1fe1fa..7a22947 100644
> --- a/recipes-core/swupdate/swupdate_2023.05.bb
> +++ b/recipes-core/swupdate/swupdate_2023.05.bb
> @@ -36,10 +36,13 @@ SRC_URI:append:bullseye = " file://0004-d-swupdate-www.install-Fix-path-for-debi
>  DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
>  # add suricatta wfx
>  DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
> +# add delta update build profile for bookworm
> +DEB_BUILD_PROFILES:append:bookworm = " pkg.swupdate.delta"
>  

What about sid?

>  # Disable cross for arm and arm64 on bullseye
>  # with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
>  ISAR_CROSS_COMPILE:bullseye = "0"
> +ISAR_CROSS_COMPILE:bookworm = "0"

This is unfortunate. Why that?

>  
>  # use backport build profile for bullseye
>  DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"

Jan

-- 
Siemens AG, Technology
Linux Expert Center


