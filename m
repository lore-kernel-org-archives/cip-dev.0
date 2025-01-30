Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADDAC0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 16:10:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.47])
 by mx.groups.io with SMTP id smtpd.web10.18950.1738253431427468761
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 08:10:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=guIyzzIh;
 spf=pass (domain: siemens.com, ip: 40.107.22.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPQDVzMO4rGodzkwZQUybaVT9h9ex8ZlK3imjn8MYcVPlvVN9fQkk2xf54zTBVB057AN2OzUo/nxHonp73490zdW+wLLAdeESJLLOPrRXH+jqN9DSc3rTrmro/FWzAMPAPmOzSi55aOck46BwtbWXXhYpJXF8LE8GWBvBBuOzHVE07630hsrqCZeoVHB0GO1BrjguRepCcL73GzRKwXtCjCRLDOtWWL5rRBgKEwQ+Eu6lpAQLDX2qTKprZZSAjDihNA6ycj8pKrsQ0uZf2t4uPItZinq7BW604KhBYUCgC+3bVqXD8MM9HE2I+Ih2xq/+5GoYVmUUT7KzVkhJMPztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mICbhbXCpGXMtYV1TiLnst7NZA0ZzEp2TUc7UTzVozQ=;
 b=C8IDUKKC8u7b1aeLP0V3Suqm5mZ8idsuijKyvka/2vaw2yr4+h/fGq9cZ/qOj9YVAnnFS3LaNr3/EAV2WAPRmrst8bG9emfNmIshb9Z4mBFbeazSkh4jb6u+/Ft//P8MWkDnAg6YamsDhlzVjtSG/I7n75ic4cJFTF+gSdcIxlwVxQtxyolfoa1pv3N0lEW5FouqokNowOTflLVq1Rb/hZoZCUs9YhdlpnnK2eZpKp+ETFPNE6Tx7Yj2j5zzPnLg0D32fO8iBrCMZtgMGFcEj/HG785PgjaYR9q1pX+uZ91OM/PPA17VDuPrT0RSz+GTcBkQ2VfKgXMxLyP6TvJUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mICbhbXCpGXMtYV1TiLnst7NZA0ZzEp2TUc7UTzVozQ=;
 b=guIyzzIhDvSIKPGriL3X8fQnOWogMibJUeroBjPdQl3UYyFRYeznR+CvDoK1se3UcIYiKdm7S2WwORbrT+X9o0At+35oDDSSkRmJUTaPOxOLDC/FZz9qRUyzQfosObriYDOgL7HLwH3IFS/0WlFz4ISN8ci6qVVvqzNKG2s88Npi/pV2asaJpwmY6MKwRgYUZ/vLlFkTrADe3l8jlwhqqKeJXFGRfC/negluiNAj5kfd7FCleGQHjOIKdHkmMKfqIdfjA8jO0olgzErNvLrKHSXEn9zu4TD3kK/k0OcEPzfZGcZtQAPHpKbNlNAtM7ZPEu6YXQuGeDnnKk9llLtYbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5544.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:242::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.12; Thu, 30 Jan
 2025 16:10:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Thu, 30 Jan 2025
 16:10:28 +0000
Message-ID: <42476d3a-e59a-4dc8-8e88-fc379d2d963e@siemens.com>
Date: Thu, 30 Jan 2025 17:10:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC][PATCH 03/10] initramfs: Add hook for
 managing /var in A/B fashion
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>
References: <cover.1738229957.git.jan.kiszka@siemens.com>
 <37b9560989414bfd128bfe7e1d5afec53a148179.1738229957.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <37b9560989414bfd128bfe7e1d5afec53a148179.1738229957.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0007.namprd14.prod.outlook.com
 (2603:10b6:610:60::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5544:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a53accd-29f1-463c-df24-08dd41489cc5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TndXL2IyTm5tOFhBWnJVUjVmSGdVTFJnSGlyZXQxdklvNnFqUDBDdmRwMTF0?=
 =?utf-8?B?MnNtWE5hMkg4NFJEdzVERG54ZjJTS2RPaGl1ZnRiNFJUOWg0UHNhSkExTkhM?=
 =?utf-8?B?bmtDV3VUMHNyWG9LbUN1UmZPNmNIM3pVREwzSS8rTzh0dlgyOXU0VXZzelc0?=
 =?utf-8?B?ZzFRRUhtUnppTW5WVVVxWkF2ZTdTMVFZeUtCYVNmMXFWUzluaGRxRVV0L2cv?=
 =?utf-8?B?bmF1bmgzdXhPQm5iVG5TVXROVmg0UDFGbC85VU5qMG1hRVNzZWc0VnNvdmlz?=
 =?utf-8?B?bzZJTmhiL1pmMkllbUFyVFlHM2VUU1Uya1ZEL1gxMUxxdUJOY0FyRkgvVnBl?=
 =?utf-8?B?Z2JGTWc3b0VtV3NWZTRmVkYxdE1vdmNIYkx5SkZkQU82dDRYZi9IRGphRnYy?=
 =?utf-8?B?dkFoOUszdUtkSE9JZ2IwYUFYUFF4K0w0a0RCMnlScmRJSUg2WTlYbk1VaG1o?=
 =?utf-8?B?RVlBM3ZWU3J3bUtFVEVQeWVjSFhpNjQyNTd5ak8xOFNrNDVTbHFYNnZIaWNY?=
 =?utf-8?B?OERBb3BDSkROMFkveTZ5c0pmUGNQaHdiT1o2ZzBJdWJEMllDS2FKMGNBVEtS?=
 =?utf-8?B?Z2p3cXdJaW5RWEc3MFZmRDFqTjlKcjEzcVhrWVpHYjRqNFhzOWxXdHNzaTlz?=
 =?utf-8?B?L0hRWFd6ZmdWOFBlbkF6Y0cxUm43bUU1YklBZWQwblREOTVpWEl4dDBvT09X?=
 =?utf-8?B?RUdTZE1tYlBBSzlOVVdlR2x2ZUtncmdUd1BieTdXeWFiWTNRNlVVcjd6K2Ja?=
 =?utf-8?B?SzdVVE5yaDJZUEorNmxPemtzT0pXVFNta1RkVzYrNmZLRFg0dExpZExKZmEw?=
 =?utf-8?B?Z25KdjNLVVhsNjJyc2tQTktUa2dpd21rcWdkcG9UZFBYNFh3MU1WYWQ0Q1Q0?=
 =?utf-8?B?TGFYcEF1emNaUlJQaGlnL3Jxa0V2eEdycDk5TVdqWm12akdNTkhQcVdmRU1L?=
 =?utf-8?B?SmtDemJPUTBaSzNNdnJXalc0cjgyS29wbktmWktEQWMydDlOVHdYZlJMOC9B?=
 =?utf-8?B?cStBdElrVDNFaFpBd0tPVitVM1grYzc1NndOcVVPY0dFR2Ztc1EyYS8vT05u?=
 =?utf-8?B?VGtRK3JOQnIxN1NpUWpMN044dXNpY3F5VFYyVU1nTzFjNTRVZzRmODU4L05n?=
 =?utf-8?B?eWVQSGs2TG8zNVNmVEpIVkxKWXpQdnRqcys5VXZwV0xmK1FldXNNRXdsTkwy?=
 =?utf-8?B?aUFNS2lLekpQOTBlTnc1THZoTkdPdlNKL2MvQVZ2RXRZbnhFbjB3c1dpd0V0?=
 =?utf-8?B?RDdLeU82eVVXZlZLYjh1Z0NsUExPb0NJTmRaQXBJNlJlSklIem9GZlUweU80?=
 =?utf-8?B?SmJYZ3dFdGJydG1CblVKYmE1NjY1cUl1MnZKcHZTcmlIT3ZNMmV0eEV5MkFr?=
 =?utf-8?B?bkZSTnpUeTlNbDA2SGYxYkxhaUVIbXpFS2JWNDZYaHhXM3BmWnpldUdta1hI?=
 =?utf-8?B?NU1ENDhFMTBYWDM2QStZWjJjWk1GVCtYVFRuWFh4NzE5TUhtNkc0Mk0rQkQr?=
 =?utf-8?B?Z3BZSHJ6c09vaTdndWdtVkVMV05uQmxmRnFUbjUrYWROcVNJd1BSVkRVdTR1?=
 =?utf-8?B?NE1HRUZaTHRoc3RBSFZTZHRNQnlMeVR1cW5INlRnRHJnL0NBdWp4bjdwWDJq?=
 =?utf-8?B?MHMrUThYM1EwQXJ5TWpTL1dJRmhGOElrVUNuYzBrcGpYL0FISEE2em1SSE9m?=
 =?utf-8?B?VEFIVkVCeVk2WnlqNFVmVnB0bDYxcXB1emFyYXJzc3BUYm9IR04zWHZrdktY?=
 =?utf-8?B?anBJczBacG5FcEtkUkwzTjJYUzFUOTAwdHdsTHN3VjM4dVRaTXVka3AvSFAw?=
 =?utf-8?B?YUFGMit4RlYzY0xSNnRsazN6ZEdiQWJBdC95V1N3T2JWdFpiRkQrSG8yckN3?=
 =?utf-8?Q?EUbfidJfI8lMU?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dGFQT2tKc1BnN2w0eXU5WHJBdUlLRkQwSnJHbHVhQWxQZUpSUWxsTzlHZTFF?=
 =?utf-8?B?dDNaN2kyQnlDM282YU9iOGt3VG1QSFcwdXpXWVpIY3dTZmVuQ3d4Z0lramFx?=
 =?utf-8?B?Nm1zTU96cnVJNUs4RXcwMzU3STJtTU5jN2pIMUIyVUNxcXBGOHpTbThmTDZx?=
 =?utf-8?B?cWZSdFdtMXJNSTFoRWJjS0lEM21nMVA4a2lZbVVjcy9iZS9HdFFzalVIN2dZ?=
 =?utf-8?B?V05PUzBtOXdZVGUvbjVEVndSTEZFYW1FZk03eFBTbktpV2FLTms5dVJlaXB4?=
 =?utf-8?B?dklNYU9nVG14T29aK3BRejFHRG43VEt0M2poa2R1aFIwYXlUMGxMQTEyc0x1?=
 =?utf-8?B?VWdFamllVE1mT1RLc3pFVXRUKzl5ZHEzN3ArODl5YnpxNnEzZXF1MmZ6QUR5?=
 =?utf-8?B?TzJObWZDL0xTNXZJaHRta0FwZnREQTd1K0s5bGR2RlErSkVlUUczT2FrQWlw?=
 =?utf-8?B?Yjk1a3MxVWJXUUtnRVlVVHU1NWplT2xpUnJhaHh4UHVvSnpVVmVOZWFSRnN4?=
 =?utf-8?B?dmFNbURwSVUvWkUwanAyMERtRlhpTTA4L0Zyck1rOVpHc0h2TTV4UDRQa2hy?=
 =?utf-8?B?VWtha29tN0ExS2NOZkU2Q293OGJLTkYvYUZ6Y05CT0JoV05XeTdwQ1FmY29D?=
 =?utf-8?B?eFF3VjRWZ05yVE9lOGo2QTZKTDlKRW9CbzNHV3BYWGdxL0haa25YajhTajBX?=
 =?utf-8?B?Nkt1aE4xaExWREhHR2hPaWtJTEp0cXYzQ3RrOXptVkJHMGlwNWdyUkFtcFBU?=
 =?utf-8?B?S2NSeFVWRWdTWGxra0MyMGhOT092UHZDMmsxeG93RXlkUXhMbndRcUUvaGhV?=
 =?utf-8?B?V2VUZlFtNlRVSXUwNFdZRG1qbU5TdjFjcldtVHRaQlZ1elZidEV3dXd3dmxN?=
 =?utf-8?B?cHFtWXdIeWJ4NjNiRFd1cUhoTzJ5QTc1MVNBcFF3bU1IaTU3QzdCSFdXcFlF?=
 =?utf-8?B?WEt0ajBvY3lIRjB0UU5mZi94N3NSSVVTd0p5bUdrTDFVb2VMVE1pNXp0L1pJ?=
 =?utf-8?B?ZWhrVTR6bGgvSllOZzJMbE92ZlFFeXlqamxOK2RySk5BcWYwNHVJWThoL1pJ?=
 =?utf-8?B?dG5nalQrM01VWkRuR1haVFRhcjNHNTc0RG9IT2w4NG15ZnNDMDZPL2E4b0V6?=
 =?utf-8?B?QlppcnptYzQzWDExbjVPdTRsOEdyL3dCOWlNelRQZU5zWEIwU1FxcTlwNFlr?=
 =?utf-8?B?RGVVZFAveU5UZXpDK2lJQityaktBWnV6UFIvODlYanorOUFFNWpybXlhNmRP?=
 =?utf-8?B?OXRHenUxT040dU1JaHJxUHZjNEpNNXZzNXF2dEVnM2hmc0FvdjBLVW1rbXBU?=
 =?utf-8?B?bFVxSmRucE9qYWRaNGR6Z24rUkpFclQzSXh6dmZGTGhrUkp5RVp5K05mMHlW?=
 =?utf-8?B?V2huQkxKYXBMM2JxN0MxUzRvQ2FIdlNGSyt4L2p5K25wdkUyV2Jxdk5LYWJH?=
 =?utf-8?B?dWdWTG01eEwrdVQwY0diOFA1L0Q1aTZndHdCRlNoWTZVWm5qMDlpZHVHb2FB?=
 =?utf-8?B?YTgxNktoL2FBdmtzcnhOenlKSzZqRGxMVlNvZFFOTUpMck9mMzhFWjFlYm52?=
 =?utf-8?B?R2NyVHpxUElGemJuRFk1OS90L0VoaFduNTVmZ3QzSEoxNVVnck5XNkpDekNx?=
 =?utf-8?B?Vld4V3FEQkVtOWRkenFOU2lkdHJ2MldEQzR4bjQwQ2VBNk03SVlqYzlBWFBl?=
 =?utf-8?B?aXZuc2FhZjBkbXF0dkQ4R20rbm5RUUhRQ3pkd09lNmpLNy9QeUVlYVdzYnVS?=
 =?utf-8?B?emZVMWZ5WDg2NVlSempyVS9iRVFRNlhJcEk5eFgyeEZneWxqUFQ5U3lqRzBB?=
 =?utf-8?B?SVZnKzJJNXR2SWoyNHgxRXFzQkVYamVDTWhRekJHOXBiUWcwSXBUZDY0NkdC?=
 =?utf-8?B?aForaWZtWEpNY1lUd0xzc2Ywc3FaMElWdGNlRDlBZ3FHK1ZhSW5PeVVMSWlO?=
 =?utf-8?B?emQvVXRCZHJ1TmJabzJzNTF1VVZjSSt0R2JmU0NlMUszZysyUUMyMm5JYm9p?=
 =?utf-8?B?dWZyNDA0SXZBdEFUTjZtR1luMnZHbFRoV3ozSFpMK3ZmYnZMdlAvRWVSUkJr?=
 =?utf-8?B?WUJIYjhJMDFRaENORDVhWVc1WFpJc2ttV2g1TlBZbWF0dWhZSzlTamRIZ3Zx?=
 =?utf-8?B?TURJUHFBK0RkYmt0aStSRVlsdTRSNHEvVzNFcHBMMHdKTkFrL040YWM5Uitx?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a53accd-29f1-463c-df24-08dd41489cc5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 16:10:28.3302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ya7zkzIRGi0HsizVVJ6UiHgxiliPeXzcXCtliywaHtf/7nzhrMIoAW+ysz2lsMgHBJEjXY9/8nVJBO+o5eiLTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5544
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 16:10:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17712

On 30.01.25 10:39, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This hook manages snapshots of the filesystem backing /var in an A/B
> way, aligned with rootfs instances. That means when an new version is
> first booted in testing mode (EFI Boot Guard ustate=2), a snapshot of
> the current version is taken before that snapshot is mounted as /var.
> On rollback, the previous version will still be available and will be
> used again. After committing a new version, garbage collection of the
> previous snapshot is happening on next boot.
> 
> This first version of the hook is written around EFI Boot Guard as A/B
> boot manager and btrfs as mechanism (here in form of a filesystem) to
> create and manage snapshots with low overhead. Other implementations
> are imaginable and would only require small refactorings to enable them
> as configurable alternatives.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .../files/local-bottom.tmpl                   | 86 +++++++++++++++++++
>  .../initramfs-abvar-hook_0.1.bb               | 31 +++++++
>  2 files changed, 117 insertions(+)
>  create mode 100644 recipes-initramfs/initramfs-abvar-hook/files/local-bottom.tmpl
>  create mode 100644 recipes-initramfs/initramfs-abvar-hook/initramfs-abvar-hook_0.1.bb
> 
> diff --git a/recipes-initramfs/initramfs-abvar-hook/files/local-bottom.tmpl b/recipes-initramfs/initramfs-abvar-hook/files/local-bottom.tmpl
> new file mode 100644
> index 00000000..91b8d017
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-abvar-hook/files/local-bottom.tmpl
> @@ -0,0 +1,86 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens, 2025
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +
> +var_device="${INITRAMFS_VAR_DEVICE}"
> +var_opts="${INITRAMFS_VAR_MOUNT_OPTIONS}"
> +btrfs_mnt="/.var-btrfs"
> +snap_prefix="abvar-"
> +
> +. "${rootmnt}/etc/os-release"
> +
> +get_default_subvolume()
> +{
> +	subvol=$(btrfs subvolume get-default "$1" | grep path || true)
> +	echo "${subvol##*path }"
> +}
> +
> +ustate_val=$(bg_printenv -c -r -o ustate)
> +
> +# when in testing state or on first boot, create new snapshot
> +if [ "$ustate_val" = "USTATE=2" ] ||
> +    ! mount -t btrfs -o "$var_opts,subvol=/$snap_prefix$IMAGE_UUID" \
> +	"$var_device" "${rootmnt}/var" 2>/dev/null; then
> +	log_begin_msg "Creating new /var snapshot for image $IMAGE_UUID"
> +
> +	mkdir "$btrfs_mnt"
> +	mount -t btrfs -o subvol=/ "$var_device" "$btrfs_mnt"
> +
> +	# delete any dangling previous snapshot
> +	btrfs subvolume delete "$btrfs_mnt/$snap_prefix$IMAGE_UUID" \
> +		2>/dev/null || true
> +
> +	default_subvol=$(get_default_subvolume "$btrfs_mnt")
> +	btrfs subvolume snapshot "$btrfs_mnt/$default_subvol" \
> +		"$btrfs_mnt/$snap_prefix$IMAGE_UUID"
> +
> +	umount "$btrfs_mnt"
> +	rmdir "$btrfs_mnt"
> +
> +	log_end_msg
> +
> +	mount -t btrfs -o "$var_opts,subvol=/$snap_prefix$IMAGE_UUID" \
> +		"$var_device" "${rootmnt}/var"
> +else
> +	default_subvol=$(get_default_subvolume "${rootmnt}/var")
> +fi
> +
> +active_entry=$(btrfs subvolume list -a "${rootmnt}/var" |
> +	grep "<FS_TREE>/$snap_prefix$IMAGE_UUID")
> +active_id="${active_entry#ID }"
> +active_id="${active_id%% *}"
> +
> +# adjust default subvolume to the active one
> +if [ "$default_subvol" != "$snap_prefix$IMAGE_UUID" ]; then
> +	log_begin_msg "Adjusting /var subvolume default to $IMAGE_UUID"
> +	btrfs subvolume set-default "$active_id" "${rootmnt}/var"
> +	log_end_msg
> +fi
> +
> +if [ "$(bg_printenv -c -r -o ustate)" != "USTATE=0" ]; then
> +	# still testing the current version, skip cleanup
> +	exit 0
> +fi
> +
> +# get rid of obsolete snapshots, ie. everything but the active one
> +log_begin_msg "Performing /var snapshot housekeeping"
> +
> +IFS="
> +"
> +for entry in $(btrfs subvolume list -aqu "${rootmnt}/var" |
> +		grep "<FS_TREE>/$snap_prefix"); do
> +	entry_id="${entry#ID }"
> +	entry_id="${entry_id%% *}"
> +
> +	if [ "$entry_id" != "$active_id" ]; then
> +		btrfs subvolume delete -i "$entry_id" "${rootmnt}/var"
> +	fi
> +done
> +unset IFS
> +
> +log_end_msg
> diff --git a/recipes-initramfs/initramfs-abvar-hook/initramfs-abvar-hook_0.1.bb b/recipes-initramfs/initramfs-abvar-hook/initramfs-abvar-hook_0.1.bb
> new file mode 100644
> index 00000000..c7b58243
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-abvar-hook/initramfs-abvar-hook_0.1.bb
> @@ -0,0 +1,31 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens, 2025
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require recipes-initramfs/initramfs-hook/hook.inc
> +
> +SRC_URI += " \
> +    file://local-bottom.tmpl"
> +
> +# override this to switch to UUID or PARTUUID based mounts
> +INITRAMFS_VAR_DEVICE ??= "/dev/disk/by-label/var"
> +
> +INITRAMFS_VAR_MOUNT_OPTIONS ??= "defaults,nodev,nosuid,noexec"
> +
> +TEMPLATE_FILES += "local-bottom.tmpl"
> +TEMPLATE_VARS += "\
> +    INITRAMFS_VAR_DEVICE \
> +    INITRAMFS_VAR_MOUNT_OPTIONS"
> +
> +HOOK_ADD_MODULES = "btrfs"
> +HOOK_COPY_EXECS = "btrfs grep rmdir bg_printenv"
> +
> +DEBIAN_DEPENDS .= ", btrfs-progs, efibootguard"
> +
> +SCRIPT_PREREQ = "crypt"

This prereq is actually wrong because crypt tries to mount the partition
as well, but that would happen without the logic of this hook. Happens
to work because crypt pushes itself to the end of the list and wins so far.

We generally do not need to wait on crypt bottom because also the top
script unlocks the partition AND updates by-xxx links as well. We just
need to use only those for the abvar hook. Next version should therefore
enforce the usage of labels or fs UUIDs.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

