Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455D6CAC592
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 16:25:57 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.2])
 by mx.groups.io with SMTP id smtpd.web10.3011.1758039949782631008
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Sep 2025 09:25:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NgzFav6Q;
 spf=pass (domain: siemens.com, ip: 52.101.65.2, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIVtwsF3s5tzqiO/08+QthYR3NmqQtwpvz2VKqJ6PKDeFzfNBgy08sA1qtZHnhl+WhhzVwIHCgntTKtV7EiuXkb1dtF8MObOE8/CRnNhHreh9ufOTSs+QHaHevc9wpd/HauAN3tOhRVUPbzRmRm5SqTc0ky2GhN/unusrZDJLeZJKjF5G7/jEZRQQsX8qI3s3bLy0Wf6EiYcnBG8/wx7ba9oVJV8ClSr0MXZMOXLkB/NNFqW3IOgmi+DnbAmK1Pei4MbdLwtFTRcDLjamED8uIkoFUFGkyClyKJ4Y7PgtViBU1OgFcJoew6461Kxq+HshrCfnnG9vBNnatOdYi18Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlffW2ytsz0gqaHD/ch00O2Y5KuYwIMqVQHrA+vgqeI=;
 b=CrRFO3CH78oCD4nxmkHttc/C57NNmlPiskxDz/orHV2AApIDcND0i2/REjaedNtgO9CxHQZr5yZSuqrQwSq3FoLLAQUmmXaFzQyU145gfrXH2fPD0yxgcNalNa9P8qrP55TUQURYBQSlHVAjJRcWZ9sa/+Uc3sSjqmxbMez3NcfvM7iuyJBggORDg+6653mQ5wqVXWh5km2KbOvhW9LGGBYGy/n2Yym7KZVGw/BsZs/Q1lfeO3UteNmdVS2q8ecUdrEJwfqi/w2FtDHTwupIZdjvf0TY3EvDKyLg5PohfWNEvkfZlP5s0vPxOf7GO7VPVYyzFKuBil0T8nuALUvi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlffW2ytsz0gqaHD/ch00O2Y5KuYwIMqVQHrA+vgqeI=;
 b=NgzFav6QKxDkHljjpW1QTAa0IMMBJaGzsk8jv34wjMy9QSWk+nGR4oMxwu23ogMJ6VC+XI/IARNG58lPU1Dx+kw30ioD+huomggJUcRa8AKvrsHK4VaTLZ/rLJOVmEt8SlaUwAwhvgTbNL4Di3Pj3wjqS3G9n0pXdtbtpvsJKUy7BuSKM+HChe/I9Un8fSvKSexPOxE1ZdLUtOixti/eMzktNAPRRpxHvPAjehjFoJ83Y6yOhNfWwSW/k4RH8bXN++aYSXdH12Oi49QTNfTM2/ITAVkW0R9mbYcJGTEBTCaEyfrI5Ir1BWucrB30jJsHIqDijYCxZUFOy3i1R7Akrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS2PR10MB7155.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 16:25:45 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 16:25:45 +0000
Message-ID: <97f0a470-ad01-477d-9184-d6a1eb9bc6d5@siemens.com>
Date: Tue, 16 Sep 2025 18:25:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] erofs: Set UUID and
 SOURCE_DATE_EPOCH with empty exclude dir
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250916160909.1797500-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250916160909.1797500-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:610:4e::17) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS2PR10MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: b7fe6790-178f-47a4-0dbd-08ddf53db005
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?STExNUwwd01QSU14aDh4WWlDREdvVjBSMUZ2ekFXdHFEZXRmMUIwaDI4bko3?=
 =?utf-8?B?SDE3N2JjY2YyYmt3cXVYNUk5Z3djZEI0Wlc2ZVNaRXFWaWN1YmNEWFBuSFM0?=
 =?utf-8?B?K0x1bnZJYmRHaU1YS2VLSCtKSnRQcDRtOFFFZTVaQUhjVnNPQzlYaWpYRkgz?=
 =?utf-8?B?OTVwQlYrcDJSblRuZEtDeldqZzZhZDBib3JSbHlFVHBzQm5BYlpHTGRlMDZj?=
 =?utf-8?B?K2U2RG04dFdWMnlONnNvME1FSVFXM1YrQXd1MFdBRllOTG5TQzNiZGRMeGl6?=
 =?utf-8?B?Y0JnNHIzcVZyOGRjQmYrYnZNTmc5ei9tejRKNkkvU1JkaVVLc0Q0ZGtEMnI5?=
 =?utf-8?B?UmgrYUJmcUxpWVpSSFpON05nK3NaR3ZRU0I1dm41Nm9ERDMycGIydk1hQkpQ?=
 =?utf-8?B?ejVZbzVwYThvekxyNTNMTlNJcVhRWmFPZ1Z0UTg2d01kYnliZE03cnZ5WGxm?=
 =?utf-8?B?Y3lnSlZFeUNObHM2VXBBaXBjb0FsNElUT3hIaTdJMmt2VmI2Wm9Rb0U4M1Vy?=
 =?utf-8?B?dTVMaEo1K28rWUNPMUZkS0RnWVFKazhVM0wxSTY2bVhPdUVXY1piazh4ODMz?=
 =?utf-8?B?TGZTQk1MeTBsM0J0ZHU2N1lQRitFVFlBZk5iWGkyeHZ4VE9VNjlLejJQbWVJ?=
 =?utf-8?B?dFhZU1JUSjRBSmNQbHp4SG9WWHN1aGMwcmkzaTNTYk4xM1ZGWVdyN0xqK1JW?=
 =?utf-8?B?K0FpQSs1RVZZaHJLdmVVTnpxaXBKVkZ3ajdFUmp6N1FLcHRmTVN6cEh6QThS?=
 =?utf-8?B?RW4xVDR1ZzJHUENLTUZwMFE1MncyMWVpT0dsUHhYL3RUcWpvM1dDbE83ZUZR?=
 =?utf-8?B?SjhZY0p6eEhsdndIUis2VitJUHUvSXE5bzg1ek5jVUNsSmZ0Z2NPeW85NFpU?=
 =?utf-8?B?ZWtVWWZYczlvdmxUZnkzSHhDdk5MRkhzb25FWDBwZFJHOFNmSEFvL2p2c3hl?=
 =?utf-8?B?YnZFeTc3bTB3UWxPRExYcytmWktjK0sxZ2pnZnJ3M3Rka3duNGN4aExUckR0?=
 =?utf-8?B?TnlwRjFrbW54akhuaXpWTStKWC9wUzdEcFNkeEZpU1g2RnpGaU81bUZvQnF5?=
 =?utf-8?B?V1I0K1d5N0VyMk9hZXNiRm4rUFo5akl5YzdUZnN5bUVUZ3IrbHY0WGNsbTE2?=
 =?utf-8?B?ZUtEOEpyOEN6UmRUODNxRjdINHlob29YVkFEODZVdWtJNzA4YmIwVW5xbjdZ?=
 =?utf-8?B?K0g3eVRHSnhTdzIwbkVlUEJDUzI3ZllWbTUySXo3VlhTZkdMeGRIOGFiR25m?=
 =?utf-8?B?bzViRjFNeTlOSC9WWFdPU0oyU3hhMjRYOTZQS0U1bmpKVG1tWURZSTJTMnFz?=
 =?utf-8?B?Yk13NXF1UlZUMkxxZVk4SllZWDZFWEJFNlVQNHhabktqb2J5ek5qSjdLQ0xQ?=
 =?utf-8?B?K0g0NUJiRk1aWjRkTkMwQUZYdVRORjhkczZReHovaEdhaFR0L0pqN01vbG1k?=
 =?utf-8?B?d0U0WU5sQjR0YTgyZ1kzSDRySEFyZmVnbEo4Qk9SSDIwZzN6NUJiV2NWYUxL?=
 =?utf-8?B?REFPanRBbnNuSk5YMmNGL1hNR0FMNHJwdXlvZEUwallKL1dncnkyS202eGE4?=
 =?utf-8?B?RTJPc3hxdGFZQkt3Vks0WjNDWlFtN0ppeFczT1BSenp0MytrTGUxOWZ1ME8z?=
 =?utf-8?B?ZU5DajVWdmdxMWU2cmk5UjU4U3BrblpZbzVhWll1M3VVQTAvRXd1bHZEeDV0?=
 =?utf-8?B?M1hjTENwOTNjcnAzb1FaNVBIdnJmc2hjNlArM3c0dFM4dXBWb0ZDemdEb2g3?=
 =?utf-8?B?YWY1NkRzU09tYk1jN1dYQk42SmhOZWNlWVlqTGR4ZitIYTNrS3Y0bkIyZ0lm?=
 =?utf-8?B?Mm1aL2UzdGdScFVTeTc2SVNTWjBwbUNJT3cwUVlLckNHeWc1TjZaYmRSMGN6?=
 =?utf-8?B?emFqSkhDNjJEbWRSbHA1UkMxd1d0emxGQjJiMFM1UUtmT3JoU3ZBblcrclpI?=
 =?utf-8?Q?sRlHdkqepoE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZkdiUDZyYThOZEZYLytjenorUG5hcWVmVnBBcU9qL01qWWtaNllJajhyT0pQ?=
 =?utf-8?B?dVpSTGtGaFlqbXladlR4KzE5OEtTbkczTThacnc4bDUyUURJaDBOam00Sldp?=
 =?utf-8?B?Vnk4VERsOWw4V2pnUVB5K01jQnNQR1Y3eERpWHRkK1dRQjV5c0pJZCtXdTlo?=
 =?utf-8?B?bEsvWjBrTGZ2U0xNNzR5Z0J4bWluVTNCUlIwa01JY1hYaG9kL1pxcllIaEZj?=
 =?utf-8?B?NzJ1bXJlZVRqdmFldnhadFpiNnBPZ0Z3aEtUTkVLQ2ZjVkttVmgwNlVFb0Vk?=
 =?utf-8?B?c1UyaGN3UHRjSnNUVENzejJtYUorSzQ5cVNvZC91ZmxsRlJ6Y3o3a2FYeURw?=
 =?utf-8?B?a3pWdFhPYjRITkxyTWw5emhUZ0UxUXNGM0tBODBpdUU5Y0wxQ0Q4WmRtbXV6?=
 =?utf-8?B?UXhwd0N3T2M3YUtwQXdYa1UvTnlMckpzN0duVU9DTTZNanVEd1VtTmxxbncx?=
 =?utf-8?B?b1BNUk9jUkJoQ09kRmFvd2RnRTlPUm9kSWwvMGJVY0lMa041am5ubVMrQi9m?=
 =?utf-8?B?bnN5SVZiL1k2R2VFemZpWXo2a1cwRVdudHhGSUd3VEhLdFpSVjRwWU50WEsv?=
 =?utf-8?B?dmpoZXhvK2ZINXEwUnpwTFJqSWd4Q2F2RFcxSi9NRGFrRFI4WEwvU08xL0hN?=
 =?utf-8?B?Unc2eEZlNlBFbitmRGNVNXZ5bkt0TGVnK1lkWWdLU21JbUJKTTRScWhsclRE?=
 =?utf-8?B?dFNiaTZsKzI3aVd4MFJGZzFneVhYYy9CRjBOWnVLamVqOFFhMUlxeEdwbXIz?=
 =?utf-8?B?Sk1SOGNqYW5zVkpubUpYaFhtQ1EzeXYxV1ZkVXV2OXJ3Zm5ITHVSSjUrQlh4?=
 =?utf-8?B?VXhYN2ZLRXVlWFFpL2FQK21qRFprUDNPdWRveGpYWVlMcE1DTlFwQzVLcFhR?=
 =?utf-8?B?aWJaN0w3M0dZbGJ6dk5Ka1RiOFkvZEZ4dGlCa244eFFNMWZzVW8wa3p0QXJn?=
 =?utf-8?B?VXlsaVQ0b2hFKy9UTlhKc0Jlc2xjQllvSHl2WGtUY3VsNFg0UGY4Ty9WVmZD?=
 =?utf-8?B?NmdDQ0FVb1hJd3VBOFZLT3NiZFNlU01DakpUZmw0bmRsK1lwb3N5NEZpVUNK?=
 =?utf-8?B?MGxoL0s5MmFvbkRyOEtUOTRXcVk2Y3M4WWxTZndZOHVBSEEvenlZZWFqaWZ2?=
 =?utf-8?B?Nko4MFFpTFdBWjJMVStDSnA5SWVYUXhOUytxd1BrN1pPcWtjRVErSkVIaDk1?=
 =?utf-8?B?YjY3NE5YRU43YWRVdnQzSE0wOFNMQ2xSdDMwV3lTV09Fay9UVjJLTTF0cXJ2?=
 =?utf-8?B?U0JVMlB0Ulh5cVd3aUdWQzRyU0FkbGFjQTZKdDBmVWdiekF4VXB4VkdwMmo1?=
 =?utf-8?B?emlVUFlIM2tqZUk5RXlXeTg5eldkOUhwQ2RhakY5NjVMOXdsejU1cUxiR2th?=
 =?utf-8?B?OWtsSEpyVnFwdzAzcUlpMDVFVFp1dHR1b2lRR3VycWZtdld5bE9JMjg3WU5Q?=
 =?utf-8?B?RHRqSjJYWVZ1MENTVmpiaDU0aXIzK1hpY0I0dHRDU2dMTmRMWXo1a2tnWDY0?=
 =?utf-8?B?UUt2c2h4STBIWElFdkZ6VUQ4TFRYN3VkMGlUTjVjbVg2MmRrWTErLzJvQ1Mz?=
 =?utf-8?B?Mi83THIxTFZ5dnU3UGY3QjBlMmg5azAzMXhZLzNPb24vR3JmM0lRRlRGSlph?=
 =?utf-8?B?ckNQMVZZWHRxTW42YXBLOThyeXpNVFFXcHVBSXUzOUpaYlh0L25PRHFhODl2?=
 =?utf-8?B?dXpVejdtWUdQV1oyUlNJUWx3eWxLdytkbGNVT1NSZm5xK0ZFVENqK0l4YmN6?=
 =?utf-8?B?b0ZNZ2FrdUpWMjJtSWdHY3lObkZNckpRc3hZTW1KYk9JV2xFek85VmkzQ202?=
 =?utf-8?B?SmZza2JSOFM0TzdnZGpZRHlHaDF3MmRYZkFleXRNMCtCTjZGZDRpdmh0VnZ0?=
 =?utf-8?B?MktqMlFUVXdYTkUzcUs4VjUwTlc0Ky9QdkVtN0JrTm1ubVp1K0doK2V2SklI?=
 =?utf-8?B?WGFaUXlOU24vNnFJemhFdnp2UzZWSGtZZFRWOGZBT2E2SVVha1Y1LzMrS0VP?=
 =?utf-8?B?OW5yVHozRGtaNEtBUWcySmcvb1M3SXkybVNLMkdvcnU5Z0RGdGpKNnFEZ09P?=
 =?utf-8?B?MTdaYzBHaUp6SEhQdHg5WGdqd0Vpekc4RlRMb3FObTZqQmVZRnZXbnVSU1Fm?=
 =?utf-8?B?aDAyNkJZcVRtNjdHYlZtbzBITUZRSkkvbzBneGxVeG5zaGJHU1hSemZXcFdX?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fe6790-178f-47a4-0dbd-08ddf53db005
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 16:25:45.4201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPF3h1QQTcSAe8nb0vV88D4BkyqCDXayDE217YyHuZWubam/dtZiOZ7+rlh7CixekNa8wjs9FTg+lepo2cG5BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7155
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Sep 2025 16:25:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20065

On 16.09.25 18:08, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> if EROFS_EXCLUDE_DIR is empty then SOURCE_DATE and UUID are not
> set. These variables should not be depend on EROFS_EXCLUDE_DIR
> as the are necessary for reproducible erofs builds.
> 
> Also add a space to setting the uuid string. This avoids
> the mangle of EROFS_CREATION_ARGS in case EROFS_EXCLUDE_DIRS
> is empty.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - append EROFS_CREATION_ARGS only once
>  - add info about space before uuid to message
> 
>  classes/erofs.bbclass | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/classes/erofs.bbclass b/classes/erofs.bbclass
> index 2743bd1..0b928d1 100644
> --- a/classes/erofs.bbclass
> +++ b/classes/erofs.bbclass
> @@ -17,21 +17,19 @@ EROFS_CREATION_ARGS ?= "-z lz4hc,12"
>  
>  python __anonymous() {
>      exclude_directories = d.getVar('EROFS_EXCLUDE_DIRS').split()
> -    if len(exclude_directories) == 0:
> -        return
>      args = ""
> -    # Use regex to exclude only content of the directory.
> -    # This allows to use the directory as a mount point.
> -    for dir in exclude_directories:
> -        args += " --exclude-regex '^{dir}/.*' ".format(dir=dir)
> -    d.appendVar('EROFS_CREATION_ARGS', args)
> +    if len(exclude_directories) > 0:
> +        # Use regex to exclude only content of the directory.
> +        # This allows to use the directory as a mount point.
> +        for dir in exclude_directories:
> +            args += " --exclude-regex '^{dir}/.*' ".format(dir=dir)
>  
>      import uuid
>  
>      sde_time = int(d.getVar('SOURCE_DATE_EPOCH'))
>      erofs_uuid = uuid.UUID(int=sde_time)
>  
> -    args = "-U " + str(erofs_uuid)
> +    args += " -U " + str(erofs_uuid)
>      d.appendVar('EROFS_CREATION_ARGS', args)
>  }
>  

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

