Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2331E7717D
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 10:11:53 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.68])
 by mx.groups.io with SMTP id smtpd.web11.7366.1733911906260390424
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 02:11:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ggkWEJE4;
 spf=pass (domain: siemens.com, ip: 40.107.103.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WszuBPWjxTt3oV2AM3yt8LmsmaLmJNJtueYARBQdaDM0cON3ZcAPzlQpflqoU27VIJ6kqslR+nMOqhgdz0vK1Dt7bYJ+tkdeFFxqh82lQCUxuRVqoTISJ1/KAIJRjXxMpxbTQsoDtleXRehlfTChz0alyGsSbpDuXbJh7xWiaA1O81Ukm/Vw/FO4rMFN5N3xNFDPBATpNisLn6ibFjZKV/5WL8TY1A62iPXqE+8+xQcPmW33vyCJ/YHC7oP1wEW4gF7xOb6QT0seQ0+iz+b/dFsRzDM8mC/wEKiPYWpCS+NoswN/18p65Tb2MUtTbBiro1wqDaYU2a71HgAVENBmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZLXKxaabwbuzL4dleD1qnzJWvnr2p2bolYQT5v+eGA=;
 b=XUPvpJyj3P0RYGauj2iVACJFbfErFyvJtp/pldSr6yN7xTue46G2ti4OGAD5HDyHyp+jxk4rGyzYX5RsxPn+Z9zMdvXErcXOQmCh3ban9QgEPrPRsYlXUvv8sZoRIUb1yrmQv4qZkcUlRm8YcQ5zzKAyV3RKe3zXhe2Au1Rb9GphFvr8/btwPtlJXtqJLBrMDcz+GtHwDHIP87rla9KOc34Uehrj4EY1flyqBcjjLCf8JEc+ikgMkG4cgoVKdm5Gu3cXTKAvA4bU8shuvlO3TmJ1R4cH4+gGBH16XkKXh1d3c1GDZI48lPyxz3x87dvz0esO1Rij982KzkyiCQbL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZLXKxaabwbuzL4dleD1qnzJWvnr2p2bolYQT5v+eGA=;
 b=ggkWEJE4FlvdY8fgYUUhUKEP5tQr71pfyAyKOgbX2rX809gecAgaAXkzyAET7Cd7Nm3FCJ/qWieVu4fLkyfQanwitOmMVlF4EK7CSK9EHVX2cgaU7N7C/XpWfrkABKkgfRSZJSyXMNBTBgKLkrKuhYt77MTjGXHRQybHX9mZPlLctitaUtEJAnVr3W/cv/wnic1pvJYDvUCDxnHStYVmzcSs1rGYp+0VjgLBoFi9MSKXYCAiO+uI4YtosGBO6Mg0wDWJ4Vvgd0/gNqgrVgkYVPkgIXPm3yrPOueVOBAO4tyqeDB6SkM2Jwck8IWPgo3UO6yR/hHSiiuumxrGqKinvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5241.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.12; Wed, 11 Dec
 2024 10:11:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8251.011; Wed, 11 Dec 2024
 10:11:41 +0000
Message-ID: <9c43e89d-64f0-4248-a155-7ea1ee0ca5a2@siemens.com>
Date: Wed, 11 Dec 2024 11:11:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/1] define RO_ROOTFS_TYPE before using
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20241211095628.2735849-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241211095628.2735849-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3f5d33-a79c-40cb-564d-08dd19cc3526
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UWh3Qi9FdEJnS3FIOGtxUTQ2OHFXQ2hPdUR0eUJHa1ZGMkNXcFA0dUZ6QWYw?=
 =?utf-8?B?UnIvS29Hd2dzNjZHNzN1Q0Zra0dDVThEWGFqaXJZK3JxaVRBbXB3b1VLTjdn?=
 =?utf-8?B?eWZ3bnpFNU5CdGZmcnRqQjRuYVVrY2d5R1VBWDhReE1yN2l2ZzFaakdGcEZo?=
 =?utf-8?B?OGdUTGx1QmZjOFpvdXg3eTJRK3hSSnlkOWhQY1RnbW9xeTJqSnd5aU4wMTJW?=
 =?utf-8?B?WWRzZjNxYnNJZEFWK21NR0JqNTVEbis4VHlwRmNxcWNsVEh3Tjc3MmEydDQr?=
 =?utf-8?B?MmI4TmE4akM1M0dmTEsxc0REMDJkYmp4UWd3S2VxOXc5enFJb09GRUZhcThT?=
 =?utf-8?B?S1cwaUdJcm9GZGZoUDVjZlIvTThpY3JTQWNXWlFybk1iL3BEV3NCb3ZreWFC?=
 =?utf-8?B?MWxQeWtXRnRVeWFtMVV3ZVNIS3JLRDZWMEtsRk5PMVVBQUtCcjFDWFh2d2t4?=
 =?utf-8?B?Wnd2TFZsT1ZwTXhkaFJWMWFGdzBKTkx4SWU1RU9pb2w5ZGlwdlF1TDgvb0RR?=
 =?utf-8?B?aUkxSWpJbzd6RzZSV1NUR3g2bmhTSlc4NUpuUSt1aE02SHkyYlYrZGdUR0J2?=
 =?utf-8?B?V1dVdjF6WDRBMzNZSUFTbGlINFpicUwwYk1aVnQxdndjWFR1RGFFU09KRXZV?=
 =?utf-8?B?NWtMY0JxVWlyNnlJTDVKdHM3N1Q2TGtwOVJLdm5LaG8rYkJEVlgvTTlmVlZV?=
 =?utf-8?B?UGViY2pWTEVnVzI3T3ZKRzNaZENtaUpRZGpLNkRFaUw0c1N5SStzV2pEUDY1?=
 =?utf-8?B?WmRrUEoxQUlINTNCMnN6TWpLNzIwNk9OQ0dEWk53bjROY3FFcWR1NGp6Wk5s?=
 =?utf-8?B?TjRvdmVEQXNDdkFVZHlNZDFVMG9TL05mQmZ3WHZTemtIS3JxU2d1cjBSUG5p?=
 =?utf-8?B?cnFzSVBwQUZoNlp5WnJadHl1clplOEFlTlJDVmZvYkE2LzR1VXpIaUJyS1ZL?=
 =?utf-8?B?eDBhQVBXaDhFa2dVUFM4TXV5cmJFcS82Q1U3WUFIb0cyc1lwMTZnTnhtZkM0?=
 =?utf-8?B?VVlvdkYrd0xJS3BFYTg5ZDhrR2E1Q0JkWFI1UnZQbjhjUUF2RklmZTEzeXlh?=
 =?utf-8?B?TWpqZktIVkVtcW9PV1VsQWxSUS93YU81enVRTzhSTHF4Qmx4ZGJwRXNhc1pC?=
 =?utf-8?B?TldtTzV4Wm1zR2hlY3A5N29NdjZRMFhwcnJBK2lVUGpDSW8vT0RkSVF3eDV5?=
 =?utf-8?B?VzJzb2VmT0NXOFBqYmMwYWJaQzFSTFlabWZkaHFEcXJIRkZGUm5XQVZzc2pN?=
 =?utf-8?B?WkQ3UmNwWlc0R1dMdU1QSWRtQ2J6NnNpWWFDRWF5MTF2RXl4U1JIclY4NGli?=
 =?utf-8?B?V0FGREwxaWd3YzNOV093TVdNckwzMld4TGxjd2ljTXB0UHRJNmdrcHYyZ2My?=
 =?utf-8?B?Z3RrOWNZajJVamh2QTFZSWVHSFgxRlBSckZrNEkrb0JtT2JENEFXTFVqVnA0?=
 =?utf-8?B?cU9SUjVzNTYvcmhFYWgvUWp0Z3pNYlAyNHRqd0IvZThaU2oyRFFFSGtTS1NO?=
 =?utf-8?B?RndBLzk3T3BKemo0RFNjWk5FZ3A2dUVFVzNCV1ZQY3FNVkt1OHlCdHoxR1BQ?=
 =?utf-8?B?Z0NGMlpjeHBJY1p2WE9vTjhnQjRHYyt0b1duZ1paME4zWWNMeHBVVlIvUU5P?=
 =?utf-8?B?czF5YmIrOEFPc2IvY0w3L1VITHdjWmJ3V09La2NBS1FZTEJNRXlXTW5vMlUy?=
 =?utf-8?B?UGZLS2lYTlZnL3ZFR01KV285TEk1SjhWSjhEaFhqNXZLVkdIVlVtY2xSWXkz?=
 =?utf-8?B?YWNJbnhQWkpjQlhjcFZqelVRWWIxOWpGallmV0R6dDFTZkNpNytnWGVyS3ZH?=
 =?utf-8?B?VEU1UVhpUVpEcU9UUXdzQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dWwwdzBpUytvRGNwTVlPRUdXdWRjNEJtOEo1TkVYWEJCcThiZXpCMFF5dTNu?=
 =?utf-8?B?NXhiaGxBcG5PSXc5a2k0WmtoU1ZvK1hZbHdIUlo2ZGE0WGFhNys2SWcxVnFO?=
 =?utf-8?B?V3NaTHNmbEJDakROeTBFUE1WT2VQUkxaYnJpRDVGZnpFeWxIMEtQNU9teFpp?=
 =?utf-8?B?eURnU3NiWVIxQXpxUlNjdUxkVS9LeFdiNlBRbml3N1h4NnpNNnNqRk1JamRn?=
 =?utf-8?B?bkVxZUxQYk9iN01sdi9TUHdhekdBbTV3NTl0RS9nbGlHVURkdkU5T3BNckgr?=
 =?utf-8?B?dTJOdDVWaXRTM2pGS0JFdXpTS0pqR2lrd2NUT0Q5RW9IcVhWR3Y1Y2xrLzhW?=
 =?utf-8?B?bWpsSHdmeitxSERRZE1TM3ZXbk9UMEdrMXpsS3c3SzZWNjI5Y2ZUT1RaUHFx?=
 =?utf-8?B?NXl3NTR5bjJ4UkY2VTdrS3gvQmlXWFp5bUJwY0ZnY3pXYjZCTVdXZlhkTlhp?=
 =?utf-8?B?K1lsWFdEZVkzbTlzVDJKWGFnS2lvNEQyQU4xYWFQLzhwWU84THlyUFVoUVRQ?=
 =?utf-8?B?WkswTjlYQ2pEbllWYmZPM1JKVzA4YXhEWkVadS9WREJnM1RHMTlkckMvd0hR?=
 =?utf-8?B?RHJuaFlkamU1aG5QN0d5aXFNUFdGWDZFOS80M3hiaDlML0c4THYwOWpkR2FK?=
 =?utf-8?B?UGp3S2o4N3RGaEFKZDRoWkhScnNFUGpWQlBlVVFZZk5vam5ML0ptMmVkbW91?=
 =?utf-8?B?TE9qa3BoZkRQeEdkTHZvcHI4b0FJTmUzaHBxRjNNNDQwdm02ZUh4SEl4RDVr?=
 =?utf-8?B?K1Y4Q1VVL2ZuWHFEQTZpNGVicFVuQlpvNWFlRHZBckxPM25ZMG1idkVLZjFq?=
 =?utf-8?B?RmIwaXd6WW5QRnlFS01xUXUwUU5wN2RabER4TGhqSCtnM0IwNXNQU1NQTHFW?=
 =?utf-8?B?eFVSelltZjZOeG1rcnVqN25MWkRjUmpPS29SMHE2TXhUb2I0RWxiSzA5bXVZ?=
 =?utf-8?B?MWJDejZKRTBCQUlRQksreVFXZUdicXVMd2MxdktGRHBWQkZYbkxxTGoyNlFS?=
 =?utf-8?B?Y3BDZUlBeWRKS2dkakowZllGUkx2aWVRSDJLeGdTSUJLVjVPd2VnZi9uUjd2?=
 =?utf-8?B?TmxhQk9QZlBqY0NFckNQV0FFbmE4eUZqQU9DcmFMOXQxSWN2ekU3SDFvNHZr?=
 =?utf-8?B?LzB3Z1BRWkQ5emhLZnFIZGROV0F2aDhlbkNGVVovTlFUYm95QStRcmx2ZVg2?=
 =?utf-8?B?aytXa2JoL0labk5ZRkk1UG9SSUJzWVFZajZzWVJoZzJmaEgyNit2WWVHdGN0?=
 =?utf-8?B?bFFXYWh2aVZTcytCRWhnRDRBZ3VXWUl1OWNUTnN1TkFreVNLanRMbFhXZUpM?=
 =?utf-8?B?aGROS3Z4cW1NdG5XdnEwa1A3TFdzNy9TNm8zK3lYYWFXTTVKaVdwbFljUWFC?=
 =?utf-8?B?SjJRa2Ewalg1N1pyZG1DQ25IcWVGdzZRMEttc1lsaUFxU2pVOWRMVEtvQUM2?=
 =?utf-8?B?MUw5WUQ1WEtTUHFNeDF0S3EzdEJFLzduMTd2Qk1NSWdrZzRIdERSYTl1ZFFN?=
 =?utf-8?B?OE5UZm5LRVVyUDQxMEw2QkZPVThQMlJoOFBmZFdIejhFNk91MTBCSEdaSkRa?=
 =?utf-8?B?QkpjS2Z0bzJHeUhqcVhPNHVGYUowZFl3WWR2SFp4RWs2RlkrbmhPSXAwV0Zr?=
 =?utf-8?B?THlsREdldmV3ekNIU29ULzdhb0ZXanN0VVZQaFpqN3haQ2Q4eDNuUnVNbkR3?=
 =?utf-8?B?MzR4ZTNOMTMwNjNYTUEzbUpGUnM4UGwwVnV1bDBwMHNoRUVEOEdXaEg5eHZB?=
 =?utf-8?B?clR4NVoxSy82ODBWWFdpZ2tVbkxiQ2FlZXhXOW1BY2Q5OVFFSXIrUk1vREpr?=
 =?utf-8?B?dEZVMUpTSVMzSkpGQ3BnVXUyK2wwSzM2ZkovdktXM1RBRS9TRDQvTEpTcEN0?=
 =?utf-8?B?U0poSFRFaGg2ZGJ3VWM4NlJBMm02S3pTbCt0QWxDa0ttRlpuUzdtZzBJRGVk?=
 =?utf-8?B?czJMUDU1Ynh5K3N5bUhUZGFRWUdseUpGYVhJSXU3aDVZZGxPbjl3d1pvYyts?=
 =?utf-8?B?UU81SnhtVEFUSWFEdTJoczVMRjZYWWduU3dDWklycXZlbXVTZ202M3VKU1NL?=
 =?utf-8?B?T1VJWFZYZlFyR0JabVBtL0hXV0ZSemdXR250YnlLalhkVlFkVWw0d05XUUdC?=
 =?utf-8?B?YWhBNWFCakw3dHVYclZRakwvYVV6RVlQM2FHZUVHT1VDOW1odUpzU3lXMjIr?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3f5d33-a79c-40cb-564d-08dd19cc3526
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 10:11:41.3969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnUZl3m4FoJnwIC+MesuiN50D3O9ob2CuUBc0wv+qT3ZvyGKoTLLA0EmfXMEUbqswyFz0cYjI0sO9aVzhVJVKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5241
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Dec 2024 10:11:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17400

On 11.12.24 10:56, Felix Moessbauer wrote:
> When including isar-cip-core in another layer and not using the cip-core
> distribution, the RO_ROOTFS_TYPE is undefined. This results in parsing
> errors.
> 
> We now provide a weak default in the verity and squashfs recipes to not
> break the parsing in downstream layers. As we no longer need the
> definition in the distro file, we remove it there.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
> Changes since v1:
> 
> - remove RO_ROOTFS_TYPE from distro file
> 
>  classes/swupdate.bbclass        | 1 +
>  classes/verity.bbclass          | 1 +
>  conf/distro/cip-core-common.inc | 2 --
>  3 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 5bf021a..3243f67 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -12,6 +12,7 @@
>  
>  inherit template
>  
> +RO_ROOTFS_TYPE ??= "squashfs"
>  SWU_ROOTFS_TYPE ?= "${RO_ROOTFS_TYPE}"
>  SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
>  # compression type as defined by swupdate (zlib or zstd). Set to empty string to disable compression
> diff --git a/classes/verity.bbclass b/classes/verity.bbclass
> index 231d172..c3b89ec 100644
> --- a/classes/verity.bbclass
> +++ b/classes/verity.bbclass
> @@ -12,6 +12,7 @@
>  IMAGE_TYPEDEP:verity = "${VERITY_IMAGE_TYPE}"
>  IMAGER_INSTALL:verity += "cryptsetup"
>  
> +RO_ROOTFS_TYPE ??= "squashfs"
>  VERITY_IMAGE_TYPE ?= "${RO_ROOTFS_TYPE}"
>  VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}"
>  VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.verity"
> diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
> index 3323dd0..d06eef0 100644
> --- a/conf/distro/cip-core-common.inc
> +++ b/conf/distro/cip-core-common.inc
> @@ -15,8 +15,6 @@ WKS_FILE ?= "${MACHINE}.wks"
>  
>  CIP_IMAGE_OPTIONS ?= ""
>  
> -RO_ROOTFS_TYPE ?= "squashfs"
> -
>  IMAGER_BUILD_DEPS:append = " dosfstools-native"
>  IMAGER_BUILD_DEPS:remove:buster = "dosfstools-native"
>  

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

