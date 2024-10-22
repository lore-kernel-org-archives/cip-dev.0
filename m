Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3083D2C56A
	for <webhook@archiver.kernel.org>; Tue, 22 Oct 2024 15:04:25 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.85])
 by mx.groups.io with SMTP id smtpd.web11.20599.1729609463719004469
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Oct 2024 08:04:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FjQGYJTp;
 spf=pass (domain: siemens.com, ip: 40.107.22.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0FqxierbvqTuC/B6KS854EKSQlPxXYbYWCyOYdXx1EVIHXFKgedqU3vq7+Po1q5tifGlrjj0X8lsQaFcQ5H1qN6LZ26eXp9VH4hiC5L9J8WHFh9xgBFaoSh7r6n9yyhqrP3mBAVRit/iuzAIinf6zOGsY3FkQ6MnCMSkh6lrIqJXHKtCv2uMZvxVzAU6F9h1GWtnAdBPke6KrgaTUD6BUn6DkCiAxUY5kn3+tqh0Y1S7JBIMniOka8rylHb43ERqrjqw1NPYhCgO03SDlAlFFhxgmBaFZ2Ff/staJHQUp0VUZWj4fWm7XfR2CfeH7vsd9tLJD8GYG+QpOabqvVVnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPk/Gn6lLwzwVUbq2Grbh+iCP3YAIpicZDpVNLvU6F0=;
 b=pjBggJ1I1vr4FCcKsKpCLcW1VS6FXuO53nDhEpPFj/UYDw8W+sCrZ3bZZaHr1OIzG92cBI/ImL0EtfMnOk9mY+ss8TFzelNvra7KXIAGGVIf3Xptf9jwHFFxx4jE7H5gHctWZHr9CuD3ZwSKJBpE/by7ywiJ98hOeKJ0PFw8L55FbGIJMf4A5hN8gZKIoBcAgf7MK7C6nf0NgwoJE5eDJOwHmJtBjCZ7lqZtGdhs/AnYcLYgl3RG1m2kDubfInW5at3vF+jXTMcb5tfEQLSrDy9MluJkcOcqwFZ27zqMUe/drMVOrEY+BJTBF+3wTRgZhBnOtL0jYaj5rublOkTkrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPk/Gn6lLwzwVUbq2Grbh+iCP3YAIpicZDpVNLvU6F0=;
 b=FjQGYJTp2J4jnBIcsqOOwbWJPneRHk1vuzGSOdZqIEZ9rgPEbFGuA/tzP8VywgEMxWo25w3fMCE2zqOXjG/IatItKfydn8GWe0nV5SXzdH2ZJ/GKCOGb1doG9nQXX8/kJsHbFO2t67E6ijFCUjpW+Tz+FYPf7fwkEfPo0LlcwRWlmdD3tLByLwlL+w8T5I2Ob1A3TINOiIC4n/9lzjQ9iKXOYCXZf0IpfhCFLhLIqpuQ3pUEH8EwcBvZAxHBRknSKZmjVLOukD11nQIEXtO2whqSh0eJG9anLemh67kfknYH7wO7lw3UemSETUHFA0ISgoJe9jHFSBvZHPGHScAclg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4086.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 15:04:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 15:04:20 +0000
Message-ID: <7e1802f3-9cf0-45c2-8415-c83df142453c@siemens.com>
Date: Tue, 22 Oct 2024 17:04:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] efibootguard-boot.py: Add option
 to build without initrd
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20241022113317.1493580-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241022113317.1493580-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 9799959d-79ab-41f6-d691-08dcf2aacea0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NHVLa2lKNms5RnRPT1B5cnlmMFp1bkZhMmxjRGJxQ1NkQitOT29vanNaTG15?=
 =?utf-8?B?ME56QnArblE4djNHV1RZUWsyUi9mMkZUaGx5eTdjQjBQYldxbUEyUHZ5d2VU?=
 =?utf-8?B?UTlqWlg2V3NGMFdEY2JxeHZ0N0tCd29HRDRnYWQyamFjOFpPRzZYZUx0cGFa?=
 =?utf-8?B?VThWMm00RXp6LzE1ckVHUGdEUGE2ZUhZWEhaRWErWlltd2ZMY0VXYUNPTHov?=
 =?utf-8?B?RzBFQThoVU5WazVLR0k5bHlBdkV3bHZDRVJqR1NvMEVhc2UxL05JbkZkV2lE?=
 =?utf-8?B?dWk0WUdRcWp3dDUwTXNOUUUrL2RxSUtXakVHUW9tVUVwZHQvU0VFazdPRldK?=
 =?utf-8?B?ZDBidG05aHBlaHZRU0xaTVVDZTZTb0NsMHBKbWRWYThFN1l3bUc1ZFEvT2xP?=
 =?utf-8?B?Qi8wQ09FenNvU3hON3drcDRRUGdab2ZoVXBBTVIxMGxTa1FRMWI5Uk40M0xr?=
 =?utf-8?B?NXUvTjN0aTZpa1Rub3ZST0w4QzUwTnZ0RlhwZGtsNFUrMGVlb2N0RFhrZk9M?=
 =?utf-8?B?RkZIUkcwaGhyeUphWk00SlJUQ081MUZMdGRQZDIzc1o2K2dySVo1RmdTTUx4?=
 =?utf-8?B?Z0VWd3RMVzVxV3BCQWRqVGxNNDdQbGRNVkxhTFBWNHFjTUd6MHVudldwWnBy?=
 =?utf-8?B?N0owZmdFeEZYREh3WnJuRDhOam9kRll6SkxweC9RTVBucFZXM1hBZEdjN0tm?=
 =?utf-8?B?RjF5T1BEdURaeGowa2ZiZ25mMERJbU1LazNmQnkyUEhvTzQxUWhvMlZDOVVQ?=
 =?utf-8?B?Yis4d2wxSWtuZGNjUU1iSy9kOENIYWxKQ1FtdVlUWVhtbHJHNkNjTEJwcGVV?=
 =?utf-8?B?eVZrcFpqR2lHS0FyU00xWmtTR2dhMWxUQXZESUJqRWpyc1Bad3ViVjBDQ3pV?=
 =?utf-8?B?eEs2N2NSRmFXRDNNaDBmbHVVdnJESjA0Sm00dTFDOEJiSU5NOUswT3pObXFx?=
 =?utf-8?B?Mlp5WUkyMWxmR1NDcU84eXptVXBBN2E2L2x0UzhRcHJxdU5iMXRSTUZpbW9D?=
 =?utf-8?B?cjdSdXpSQ3QrVm5WN0QvUlhlNkY5bTk2a2preGROaTQ3VGN4cGFhWXR3cE50?=
 =?utf-8?B?WjRjZ3dIbElTUmVZcUVMMWpBcUNsdU1wbUtTUCt5WERyN0lFTEpWa3A5ZmxG?=
 =?utf-8?B?Z1BnRXNVTnZ0dExDdUs5bDBoVm5tbFBsMjA3VHVENHdSaURpNmRHd0VETDFF?=
 =?utf-8?B?MkwxcWh1bGdmYWZkUzU0Q2U2VGNQQjl6ZXNQcGlqcHlFV0huWnhyVzBtejBE?=
 =?utf-8?B?K3ZIRGZCTXpxZFFKYXZsMU96dGVFOGRVUi9HVzlCMTRMQ3FwU1NQS25tcnhz?=
 =?utf-8?B?dHhWS1ZlU0lpclNNa1AyMHZxWTFhS0p3U3gyeVBkb1ZLRGhYM3JLSStrTGJG?=
 =?utf-8?B?SzlYU0xlZmFabThRMFFuU0srZllnM25RRE4ycWhqUDVZek1jcGZMU21nT1VM?=
 =?utf-8?B?Vyt3RnA3a2x3TE1DWW96bDNOOTFQQTVHOFY1OEZYaUUwY01kakd0Q1lRVmZi?=
 =?utf-8?B?cGNHVDRlWEVOOHFHS1F3RCtHM0hsbTNCb1FITUtEOFhINXY2em9OdGplWEpZ?=
 =?utf-8?B?VmxRWXB4T0cvaVBaVklVS2lOSEVSbmxOeUszZ0lRRUU0RnluZ0Y2eHlSTGlF?=
 =?utf-8?B?WVlkUFpOZlhZemdvSVdzRHFvUDQvRkluZmc1L3dacC9ERVR2dHpuK0laMmFv?=
 =?utf-8?Q?49XBBFIWVlv05oFWE3G+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aE9sMnYwVklvVW1iMi9Bams4dlZMNlNmd2lJNWdGRTJ6VlJIMmxBOG1sK2xo?=
 =?utf-8?B?bWlrL2JOSy9COWJxUzBVbit1SUFPODN2UDRqMVJWMlJ0aU1UK1RXek9xeUZO?=
 =?utf-8?B?SDcvOHJZQTBtU0RhT2ptWW1xeERaVldGclc1K1pOZmM0YkUwUXdKT3hhc0RH?=
 =?utf-8?B?QUNZWVNHbzlDM2VEMUx2ZTJtakEvNjd4Z0IvRkVRb2E2RGZuUHUrbGEvWGlC?=
 =?utf-8?B?VzN0Und1YnRYMFZGTlM3dEg2K1E5bXNTc2hNNnltNU5NWVBMR3FGOWp5STR6?=
 =?utf-8?B?VjFmTUNhUlRMR1JVaTBhRUcwd1RwcmlSdmw3ZEJXMDg5alNKTzArOEY4VFNP?=
 =?utf-8?B?RXdqZHIyYXhyZVRHQUtmTURWdkh6d1BkcWRnQkgzLzFHVGp2YzFYNUFBdUFW?=
 =?utf-8?B?amc0cExTYzJWakxMc24ybGRmZjlDbVIxN3F4dlhFZ05TWVE3T0N0MlBMQk0x?=
 =?utf-8?B?VnBNczlOa09MQTFwMThyaDlYcVV6VWhHM3hEMlpIdk9xUVBnbWlGMkE5MkpR?=
 =?utf-8?B?QjFXSGJ2bnpQYmpmcFBqcU9zOWczYU9qc0VyV1UwQ0pveUFzejU1Qkp2QU9X?=
 =?utf-8?B?dE5zV0REY0VlaUZsTkJESURIVVhva1FEbUpvK3VUL3JDVWhmclF2OXYwSEti?=
 =?utf-8?B?ZWtiZlkzMGc1ekgrdFdzNjhrYUlaSlRDdS9WMk40d2NCUTYwc1JxcDV1L0tE?=
 =?utf-8?B?SW9GTkNwL2NSbjB6Sko0V0R4TDBTZlYyd0VwcWovVWxnZHl2V3loNlhxRW55?=
 =?utf-8?B?VmZ1SGFHTllwNndmNE9naDNwVGhyUzZabXFtVUs4eTRYczJGSXRsZ1NoZmRp?=
 =?utf-8?B?ZzA1TEs0ZUlvOWIzUE1lclluSWZqbFVVNGJTcmhZTFhBbERseG5qYXQ3M3ZB?=
 =?utf-8?B?MW03d0MrYXdwTFlRZUZzakd0QkVJbnl0QWk5WVVTUzlxcGJDMzJPcXdtd0Qr?=
 =?utf-8?B?SCtaZWJzRnp2cDBVVzh1VlpMRFU0QXVVcVpaRXJ3VGJJaUoxd01SOW1ZN2lQ?=
 =?utf-8?B?d1hod3RLRnF6cW1vTXhtTkNzSFZiZDAzVmVtVGo3VFJ1SmhtZDFETG9xc1Nv?=
 =?utf-8?B?ZWtWSElOaE0wbDVKVXJKODcyVVNMWXduYWhZK1B4RzBmVCtTWE1yamxVd3lK?=
 =?utf-8?B?NUFqZ2tzb1NnRG40ZUhTZDRvT1grbzEwZnZndGNiNzIyWjB0L2cyZjY2OTlL?=
 =?utf-8?B?YTFpeGZSRE1FZGovbDVKczBoN3pReHNzYkdhSXRLdmx1bE9vLzhLSzBFd0ZT?=
 =?utf-8?B?OEYrUnNlUVNqRHJJZEMzenVqY2R1KzBYdURZUGJqQzFmb2ZYcXIySWdTT0hC?=
 =?utf-8?B?WCsvZVRKOWJxQ2E3b29SY0c2T01TK2JMZFFZWk9FOE53akZaZ0tzTTRxd3JP?=
 =?utf-8?B?ZXA4Q0ZyUUtFWVl4V0Z5RktRc2tWeHQ1OFV4d2YvQmpxL29Tckk0UE94Z1N3?=
 =?utf-8?B?ZWp3eG1icVk2K09mN3g3Y2U3SUdEYTc3MkFSQldIT1JjcEtTc3dnOCtuU25o?=
 =?utf-8?B?cHNqRTQ4R2p4TUx4ZEs1VzloK2xHTkh6RHZveGlwU3NCOHQrdUkwR1NjQzdn?=
 =?utf-8?B?L1hVVEpQMUg1RzlRNEhVTXQxN1UzQjNreFlYamNLNDlIZ0NsTVFVWVdQamEr?=
 =?utf-8?B?dWFqdVJ3ZE4rbnBscFpxWDRUc2dxWTdyS1NteFpZZU9XUTQxUjJrb1JPYk83?=
 =?utf-8?B?SnBSSEgzb28xbThya3FhcXpSQ2o0SWpqVUNLK1NyRjJhVVBMdXA3MlJpVFYx?=
 =?utf-8?B?TjdXbkxzVUF1bnFHU2p4VDA4amxYb0dGcHk0bXQzT2JZenFWV0RScjFITDhm?=
 =?utf-8?B?NnNLa2o1a3JjVUhxcDVNTTVrd0xGMUgzK3BRL0pidVozNHFMVnZXTHRLQTlP?=
 =?utf-8?B?RjV2RlZBNGF1elQ4dVplSG14Zk80UzdEa2h2K0VHanVtWjNMVzhrWlZ4N1Jy?=
 =?utf-8?B?ZWswcS84cnhuZUxNdUhDSmR4dDQzQ1ArMFBDU1dGVWNVSTV6eWVjVW02dDZH?=
 =?utf-8?B?SGVDYTJUWkpxTEhuMHduWU10NGJhTmlZbzJCa3Iyd2JoNGRIZDdCTk42WStT?=
 =?utf-8?B?YzR2STd4Sm82UmFid0E1NXhnVm5XTG9MbjBNQlJWTk1mZFBpWDQwc2ZiSXd0?=
 =?utf-8?B?YjNsWmcyZ0EyYTVmaE82bHNEU216R0xTVFJ4enZyR1NYR08xclpXaVkrVkJr?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9799959d-79ab-41f6-d691-08dcf2aacea0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 15:04:20.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzwDx9yM5AGRk6gLbzdRSfniSsAOpk0EGTw9r9/Cln1wmPA1PoCqscMJOyt8Z4Uyyv6sG5GT4icQ91ZITntq1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4086
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Oct 2024 15:04:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17068

On 22.10.24 13:20, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Some devices have no initrd, due to space or other contstrains.
> If the option `no_initrd=y` is set the boot partition
> or unified kernel image[1] will not contain the optional initrd.
> 
> [1]: https://github.com/uapi-group/specifications/blob/main/specs/unified_kernel_image.md#uki-components
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  scripts/lib/wic/plugins/source/efibootguard-boot.py | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 2b06fd1..221297e 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -60,10 +60,13 @@ class EfibootguardBootPlugin(SourcePlugin):
>              kernel_image = "vmlinuz"
>          boot_image = kernel_image
>  
> +        no_initrd = source_params.get("no_initrd")
>          initrd_image = get_bitbake_var("INITRD_DEPLOY_FILE")
>          if not initrd_image:
>              msger.warning("INITRD_DEPLOY_FILE not set\n")
>              initrd_image = "initrd.img"

Shouldn't this initrd_image block be skipped as well when no_initrd is set?

> +        if no_initrd:
> +            initrd_image = None
>          bootloader = creator.ks.bootloader
>  
>          dtb_files = (get_bitbake_var("DTB_FILES") or '').split()
> @@ -179,15 +182,16 @@ class EfibootguardBootPlugin(SourcePlugin):
>              .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
>          kernel = "{deploy_dir}/{kernel_image}"\
>              .format(deploy_dir=deploy_dir, kernel_image=kernel_image)
> -        initrd = "{deploy_dir}/{initrd_image}"\
> -            .format(deploy_dir=deploy_dir, initrd_image=initrd_image)
>          cmd = 'bg_gen_unified_kernel {efistub} {kernel} {uefi_kernel_file} \
> -            -c "{cmdline}" -i {initrd}'.format(
> +            -c "{cmdline}"'.format(
>                  cmdline=cmdline,
>                  kernel=kernel,
> -                initrd=initrd,
>                  efistub=efistub,
>                  uefi_kernel_file=uefi_kernel_file)
> +        if initrd_image:
> +            initrd = "{deploy_dir}/{initrd_image}"\
> +                .format(deploy_dir=deploy_dir, initrd_image=initrd_image)
> +            cmd += ' -i {initrd}'.format(initrd=initrd)
>          if dtb_files:
>              for dtb in dtb_files:
>                  cmd += ' -d {deploy_dir}/{dtb_file}'.format(

Jan

-- 
Siemens AG, Technology
Linux Expert Center

