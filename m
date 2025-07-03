Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29246C77B7C
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 09:32:05 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.46])
 by mx.groups.io with SMTP id smtpd.web11.18430.1751535117086237729
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Jul 2025 02:31:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=F23DygqW;
 spf=pass (domain: siemens.com, ip: 52.101.69.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPRk22m81Dxs7x+Eu8Le2ilnssfDsrQO4hlma0WJCAeTANmLGWJuh/09OneeIcsrgP7YDNDfDsEH/vMF8RjmJULXctg053l9dGM0vk/q/WaOdQYZSxsTxizCBxEbuKetks80/3k/H5AxF3gCzoO3MYaIor9E2iiJZwS4vX/yjkZADDs3/XOadFNXUTuy4BoGjrEXYOlG9zsfLzjDNVXzc5A+88UjBvJvc6F+SKNNZrUBj9L/04bkGf7JXAwT7RwTwdI3ymuiKOTTovt1wRwSn7Fpn5LXwPdC1UN4ltTLkhnB1RQIWrwYUgqV44hXZNOnyV2p0wpG3+VGK5DYy0yYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONbejbyj1XdrYNJB2RwxLCv/jHZFYQMqE3pQKfp/Xe4=;
 b=jWFmNsJY2jhk82fcplBfXOBBi5SWnR5xxZ3zCiAudfB+pV6ng6dDvUOcahKiIVS/ugrQ/rCFoRiyATG7xdk6l7vrjiRF2QKaCLBL7O8gnWoQ5eCMCmdPu1ZtmY7tsM0Br9CagoPiprH0ZmaHC5t36bzozwTTp+x2LKpO8x51+tNiM0kfBkQXGogTeDHvWgzHSGcpU6SbJTjUejR+vUTc1yrinsPjEBtg6HEM9YJeG2u0MCuWhb54IiFKcZKrfZS1uqqw9EJAIRhsc+FPD4y86zrOPngiQ/22BSFnnd1UUJJwyqsjdZUy9lqaVvCe+KsBj9WNU4xHT5wNbxF8CREwmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONbejbyj1XdrYNJB2RwxLCv/jHZFYQMqE3pQKfp/Xe4=;
 b=F23DygqWyu3m2SFKyRg6w+V2ZdLIS/++CvaLKApq/3FPuBRFZIcIOpkCuak8JZ2jNc/RZck0+RGqmW5lQrNg6qNW15TZITsrsg/6X3xgwbJYuaJICU+X92MaZ4mXNV3mkJOrmmnJTs3HHyxSsmn0fwvZe9fOy/H7J07j4uiDq0OjS3zTFsmfatVDP1pZlmSq/qFn4hxBKDHW4eExk7LXqTa2eQA4KQ8QX2z/cSHEYpXby1Q9y1rjx8wioseGZ9+7vikK/qaq+K+jlO6vdnKiZoOdWAqZVOMojbkIS7sbbcmAqfPs2C8Fguo0XTHHzHBbewn1jJ4BqbN5ku7hK0G8Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Thu, 3 Jul
 2025 09:31:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 09:31:53 +0000
Message-ID: <8fd66993-fc8f-4694-9fcb-82be970efafb@siemens.com>
Date: Thu, 3 Jul 2025 11:31:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] Enable persistent storage of
 journald
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20250702194747.21837-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250702194747.21837-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: b0bdac40-27ee-44c9-747e-08ddba147240
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N0JKWS9zM2I2QXdZT3JJSUlGc2ZXR3MwOUo3enJVU2RQWS9LQ3NKNzhMVEV6?=
 =?utf-8?B?UHhXM05aOUYxZCt3YVB0NE5mM3BjRUNFNSt4MlhXVzQ2cURBOTBqdjIwU0lQ?=
 =?utf-8?B?bVNranNScHZaNFhmUFZJNFZQczI4Tzg1YS9LMzlqNmtHTUNKUXptZE0xQzJp?=
 =?utf-8?B?ZTJ6bVpwZGdaYkZyQW9wZ2FjVVpwaDZ0cHJNMytHL1pzVFVnQUJoSEVEV3Jq?=
 =?utf-8?B?OTcyNktmTE9QNEhoOXYxZHUxU1NvcURmYWhrZDdqZDhQR3RRTXFpZDNlTEtk?=
 =?utf-8?B?c2l0SjRZdVFUSk5RUjZ3Vk5IUGVLWGVGbGxDcXlWNjlRUldseFZ3QjZtWm9P?=
 =?utf-8?B?dnJzekp1UTVic3hMeVVBTGZnZFFxcVhTSzdjZmtiRDRkKzhCbHFyWm9iWEJB?=
 =?utf-8?B?UzdEcTdvNzRma3VtTm51eWlDb2NRYmttMWdZem5PeU5wTWZLcVB6M1NRTWZZ?=
 =?utf-8?B?SEJlREtaRm1GNWZXeThrUWlDNzJQSGdOanFxRzQxS1EwMWZyWUJtUzQ5a0xv?=
 =?utf-8?B?WmczNytkT3JsWGkyTWwxdXlrYkdRKzRlcFcyekowaWNWUS9mWG9zZThxcjI3?=
 =?utf-8?B?OEtIQ253ZnNsS0w3UFduZHVvM1JqNUFKVnE5MDA0amVPdm4wQ0hvczNBYzFF?=
 =?utf-8?B?RXQrelRJRWpocncxcS9JcUZjRTVaYU1LTHhYQXJXQ2VPbDR2MlVJTHNBNzdp?=
 =?utf-8?B?blBiNDY1bmZhOXRyRXp6cVpGajhrcUM5Wmc0WDA2VnpHSXVKNjRtMXFMcUI0?=
 =?utf-8?B?SnBGSE1XNHNuV2ZVVUR2NVQ5MDQxbXlkY3BoK2xzVUZzVWIxdGtpMkJOaTZK?=
 =?utf-8?B?QmRubUMwYlE3U000S2k5U1dGZnhEMGtJWWFKV3g3RDdVQjNhTC9neHB0elhN?=
 =?utf-8?B?c0xzbDF0RUVDYXA0czdyaXhkOXVtdjNJbTc0RU9qSGk3V2tPc0xMK2YrME0x?=
 =?utf-8?B?aUZOK2pxN2JtR0xiSXBtTDZsVlhzMDBHNENQcVlheHk4RC9rSDdFaFMzSnJ5?=
 =?utf-8?B?bzF1SEZiWXE4cXA1WEVWRU5LT1F0RXdjMUIyRENaSTVzRnBjcjd4OFg2d3BQ?=
 =?utf-8?B?MEFyS3ltR0RlbFRxdXRKSFFNcWdpU0JzdGRrMGFMUklxTDU4ZFdIL3krSHl5?=
 =?utf-8?B?aTA4YnFCcG1RQ2pRdEpoTlRCd2ZLalBDck55TDl3cVp4RlVTL21rS1orRC9T?=
 =?utf-8?B?N0JESDZZOCt2ZGhDTHB6K0RIaTVmZDhvdXliZFlsd1BaT3ZoTm5neCtOTW16?=
 =?utf-8?B?eEdSbEc5TmFsNW1WVjNFT21uRnpuVk1CMjZGeFBNL1owUFVYOGw5U3RvYkty?=
 =?utf-8?B?WXJHYkZlanc4czhyWW9UY3VGMGJuenRUTVZPNU4yS1ZnV3B6Uk8rWmt0RlFz?=
 =?utf-8?B?RGZUeng2V2ZrRHBkTlFMVlZHa2dPcytoZEtpRHUzdE9XaHhJWGtsMldzMCtG?=
 =?utf-8?B?TkpCSWp4RU54djJhbnVWcllOSVFlQ0lEYnhhTG9XVnFlZlRvRnBSUUREMHc3?=
 =?utf-8?B?eGVSU0dmL3dINnVNdzFDbmNURkNMcmJIWi9NU0pBTktiUTlkZTZRSTlxNmov?=
 =?utf-8?B?czNQQ1lTanpmVGlSSlUwSjlmT0JDZyt1UXJqbUpQOU9wNFBUd3ZwMlZNWFBH?=
 =?utf-8?B?ZkRpNWdsMUFOTmxqMC93aGRoTEdnSFlzbXNlYVBxc1kyb0g5ZHdVL2hKSHR3?=
 =?utf-8?B?c1lHcHI4YUdrWkpoNVh5YkRGdkxPa0x5MkVuSFVvd1R5SCs4VGEwaTJJU09R?=
 =?utf-8?B?d3lRSFY0aXNQeHI5cnRQR3c5ZnFRTnB3U3hMRWk5QnBDU3I5WE5RSHU0dWNJ?=
 =?utf-8?B?RS9ma2s5RWJPby9acHEwNnVNQ0VIK2NNUGE5Vyt1T3ZTbTlIVm0wSEZWUWFP?=
 =?utf-8?B?OFZaaUdpdmJnR29VYit0SmlIMnVINFRXTHN0VlN3NWJ1QWJMRHM3SXBVcStU?=
 =?utf-8?Q?fI3PaUtlleY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N3ZXL0JtOFdGWCtZbnVqcEFxanJ4MWxXTGU2VHRXSWVPUG45OTR3T1poZ3Qy?=
 =?utf-8?B?cEsraCtlTVVRSDEzcUZ2MnRkZGxFUmNQY2JtMkhNcWVIQmNYZmtzZG9RTWIw?=
 =?utf-8?B?YmJydyt5R1FBamZNL3ZCajNhSHZBdmJGdXQwckhvdlFTZXQycmwvVkV2dW9U?=
 =?utf-8?B?eXl2eFpPbkRiendBdDYzVkRua3RTMmdOREVVUVRyQ0s4NEI3VEY4Z253ZnVD?=
 =?utf-8?B?ZlZycDNrWHArWWNyRzdIL3BvRzhZbzZJbFpycDlVaS9YWEdwQnIvbXh6ZFpo?=
 =?utf-8?B?bG9nM3pQTEV5eUs5R1h6U2FIcE9IVnFYR0VuOGJQRHpwcEcrcmVjSmRVekMy?=
 =?utf-8?B?ZmhzcURFVE1zZWRsSEhQdzlUUXdldzVpd2Njd0pzdjFGTmt6cUU1TjdBZC9K?=
 =?utf-8?B?dUtRN2Q2emdXdVZ4ajBIbjgxVlNRdjVuRHRhSy9EbmZwSWJJdmQzajh2WU9h?=
 =?utf-8?B?ZUlzcnpWTXF5b25EVjlWY1BJMDdUY3RTQU9JekMyK2NvbU9kdUZ1eFQ5TWwr?=
 =?utf-8?B?ZUdzZC9BVFhhRXRqckNnQkpwOWR5NXQrRElWN1R5RFRKcDN5aVk1dElPZHhi?=
 =?utf-8?B?RmdkdTRZZmJGRzdldXdrSkE0em5sc01NMm4xU1l5TldVdEJwUHFyd2NDRHo3?=
 =?utf-8?B?MzQ3KzlaS1orY05pNXlzL1EwUW1qREs2bmtlbFQ2dERRS1lPK25hTmNEZmdM?=
 =?utf-8?B?REpCVVNDWHdLanY0b1J5ZUJvdzV5R3NOWk9rS1RURjF6UFlIeXhrcXRJaTVR?=
 =?utf-8?B?S3ptZzdLeW94Z2E4R0hVMUJEUlk4VkNBWDk4NjA1eE4zdnpjSTg0Qk5VODFT?=
 =?utf-8?B?djZuS3RwdWtBVkdJY0tiTjNNNjJxSlM1RFBmSmRoaVI1TWNObTU0VnlGWHBq?=
 =?utf-8?B?emwrRFNZZ05yOTgweTZRaFR1QUtlMENoRUtzK3Z4TnJ0bjlqVENRam5kN3RJ?=
 =?utf-8?B?VnVIZDJ5dkhBRUVCaUM2UkRnWVg3WmhFLzlRQUNrcWFUK3JJMmd2L2JLbS9K?=
 =?utf-8?B?VW9TWFZTeFZaTXBZMjViNHl2NnFidkhjWnlIK2lkcktoZk9yOXFqVmlDbzlt?=
 =?utf-8?B?MlRkRk5nbTBIM2NCenh6Yk4wbHpGUEVCbldrRlEyeTdmY09RWEw0MEpOckNj?=
 =?utf-8?B?cDdtRXRFNTRTSFhVWmVjN2c0RFNmYkVyNTVzUmhhZWsweXFDRVhxM0RuS2Rn?=
 =?utf-8?B?SWhkaHRxTXVpZVFpU0o2Ly9yN1h5VXlseDMvN0JFNUk5SkxyWlVOREJoUDNC?=
 =?utf-8?B?VzVhS3Erb3lWSlJRZ3NrR0prcWNQdGgrWUZaRVFVeEc2T1JZcktGem94L1Ru?=
 =?utf-8?B?eFNDL3pnZE53cmRwTS9PQjlWbTE5cmhsZVJHanp3TGp3SGhSS1F2RDFld0xk?=
 =?utf-8?B?elUxa29wUitCVUtWZnpHRUJSczAwMG9oSGhHM0xGNjF6dWcxVC9ybWlyOTlz?=
 =?utf-8?B?L1pPZTlja21VVkdvWUpqd2pZM0V3d1JJRTlsbGR0WVpycVBCLzB6SkxxaWQ4?=
 =?utf-8?B?TmN6T3B3RzJXRzdJREw1MGQwR3B0T1dHdmlkbm5GNlZFQkpHRUZkSTFGL2Ev?=
 =?utf-8?B?S2UyR0crVUhVV3ZpdFAyVXArME90U3VJMThNWWcxQ0ZCVlBqN1JENmRXZzR1?=
 =?utf-8?B?VWpaOVZyTlE1bzUveWlWY2c0SysvVWh4ZkJndVVlbXNqOTUyMi9keSsveW1H?=
 =?utf-8?B?NzM2cXQ2cEJJL0xOM3MzSnZZeDRNWHFXMmNpTGM1cFF4M3UyUG9QVDl3Z0pF?=
 =?utf-8?B?ZTdDbDZtWC9qUzNWZ01IRnZleEpadGlIcEJUcG5UMWw4NFkrdEZlZFdrL2pq?=
 =?utf-8?B?clE4UkVjQXl3aU5LajNHQmVIUWhkYUYzRDF4Nkd5eEZqYlZ2M3NvMkUvdmVN?=
 =?utf-8?B?V1VQTFlJOUx2OGxiQzNBQjFoWkNyK2Rkb2JGVjNmSEtEc0E5K0c0WEdtVVNa?=
 =?utf-8?B?cHRDcXBkOVBNSUwyK3dHZFA5WmFEalNEZkVEQ0FZcDh5Rkk0NzRCQXF0M3U0?=
 =?utf-8?B?SWVvUEhSajFMNDFKN1N6L3h1aTIwcmNvRGZXSzVNVXNPMVpXdDB0KzFlZ2pY?=
 =?utf-8?B?dUhrbVBHaWJaM0x5cUpqdVhDSkxkRkUweEJhbFhZM3FYVDB4anhJcStQOS9k?=
 =?utf-8?B?ako0NmtrQVY4MjVqSmpHRGpCQ2FHNXYzWllPTXN4RlFFcG5tczhnWjBoU2RY?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bdac40-27ee-44c9-747e-08ddba147240
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 09:31:53.6705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGJHBjQEFatciMW9qMr6F/t3VYJL2uzITOTTjURfwfdHVOU3ma06CF6kuSf7Bahsgf5i/LqfAhTUmFeLsUxOxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6005
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Jul 2025 09:32:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19323

On 02.07.25 21:44, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes the persistence of journald with an empty /var.
> In the default configuration journald only stores files persistent
> if the directory /var/log/journal exists. Since commit 1eb074 the
> directory no longer exists.
> 
> tpmfiles are not a solution as the systemd-journald-flush service
> is executed before systemd-tmpfiles-setup.service.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/read-only-rootfs.bbclass               |  4 ++++
>  .../files/persistent-journal.conf              |  2 ++
>  .../journald-config/journald-config_0.1.bb     | 18 ++++++++++++++++++
>  3 files changed, 24 insertions(+)
>  create mode 100644 recipes-core/journald-config/files/persistent-journal.conf
>  create mode 100644 recipes-core/journald-config/journald-config_0.1.bb
> 
> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
> index e81084d..78cdf60 100644
> --- a/classes/read-only-rootfs.bbclass
> +++ b/classes/read-only-rootfs.bbclass
> @@ -27,8 +27,12 @@ IMAGE_INSTALL:append:bookworm = " tmp-fs"
>  
>  # For pre bookworm images, empty /var is not usable
>  IMAGE_INSTALL:append = " immutable-rootfs"
> +IMAGE_INSTALL:append = " journald-config"
>  IMAGE_INSTALL:remove:buster = " immutable-rootfs"
>  IMAGE_INSTALL:remove:bullseye = " immutable-rootfs"
> +IMAGE_INSTALL:remove:buster = " journald-config"
> +IMAGE_INSTALL:remove:bullsye = " journald-config"
> +

Dropped unneeded newline on merge.

>  
>  ROOTFS_POSTPROCESS_COMMAND:append =" copy_dpkg_state"
>  ROOTFS_POSTPROCESS_COMMAND:remove:buster =" copy_dpkg_state"
> diff --git a/recipes-core/journald-config/files/persistent-journal.conf b/recipes-core/journald-config/files/persistent-journal.conf
> new file mode 100644
> index 0000000..21dfde0
> --- /dev/null
> +++ b/recipes-core/journald-config/files/persistent-journal.conf
> @@ -0,0 +1,2 @@
> +[Journal]
> +Storage=persistent
> diff --git a/recipes-core/journald-config/journald-config_0.1.bb b/recipes-core/journald-config/journald-config_0.1.bb
> new file mode 100644
> index 0000000..00dbfce
> --- /dev/null
> +++ b/recipes-core/journald-config/journald-config_0.1.bb
> @@ -0,0 +1,18 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg-raw
> +
> +SRC_URI = "file://persistent-journal.conf"
> +
> +do_install[cleandirs] = "${D}/usr/lib/systemd/journald.conf.d/"
> +do_install() {
> +    install -v -m 644 "${WORKDIR}"/persistent-journal.conf ${D}/usr/lib/systemd/journald.conf.d/
> +}

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

