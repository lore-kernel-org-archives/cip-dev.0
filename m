Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ACFCFA441
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 18:54:37 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2109.1763664869764997373
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Nov 2025 10:54:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Yd4w3IJm;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 52.101.83.16, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVZaipOPN6ZZKqXb4/GPrfblxUm9quCiBG2qQqD/9+8c3n5l62dIjrIfGmcuVU/G6QuzNw6xnvIjkG5L6V2vQU6Pps/JVA2e5ec6AtSTTBu23dAmaX62REISGCdWo9HwboK5iwTK/Re69TxBB6EcxaX8uv9lZ0M/Rj1XJy9z4ITplZhg9+HAIiWvNdIA1RSpZcGxQR/kGXchNffxjIdIQJTU5hnnZTaX806fZRMQA8AfesI4O8uadFQGK+caBMnG4oDflbHLGvuyU23mua0FHhw415AliU6D6VI4K5QAgDlfI/ZmUBLHhFnp3Rodtd3PEzVQ3bPa4JYfdiwniWHV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2axL6l0RfelQiaX27bWFpEIdQ/2zkc4ZafwhOEkvFHM=;
 b=Jh1bIyu/vEQQdTZpaUKwfJQImkmghX8DTo4HoLIP4/mDl8Xt4XzI010l6NRh+JRuZtq9y3P9c1Z/PEgqCPKUuBLH/8TW6uxWZb36Cn2UJyV0cuV9PFfU+Jbt0zmwXSkPjyv6VDcj69edzkeZYAYMSrze2IGUKFbeBh1oFaZe1pyG8z02qy2A4jKyjMqn/dm1d03N58Rwp6txcHJ3z0N3AW4yAFMPF8WznUahigql5LTefFZhJd8wOatlKzUk9fGZ1wvZx79vQz8hEjQhpG7QdqAZN4sWhEeDa+2eVVTkUBXH2N9ODDYT9s+4NfaEdu72fR6XRRUal3FoBuMjjmdPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2axL6l0RfelQiaX27bWFpEIdQ/2zkc4ZafwhOEkvFHM=;
 b=Yd4w3IJmIGF++t1DYqBYYjuO8dEw9ycA7XUkb7hW0O+itnbJFubdRGUTrK+AxmF3E0nxwXbjscRwFBx3td8HsMA/d6m4PxPF9jGLvR2N1ex5pC/4CV2SropylfSjhgTUp3Gx8enGYWqW911HmYd8gv9N2i7TyF0fEAxrJfttVGt0q1T+c+77+Vdks7QkEakyVcbv0xo71uVlBGDye0ekMtgxV9ygoybimPHKIkl9QKIAiinHsctgxeepprD1z5iidFurv9Nt8m8S1S9WvXb6OaQJWpGqNdXncrQTqd5bLt/KFFkFI/W1I31ff+3rmBMxOVq7jgzdXG2QXt39Gh3Qeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6364.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:54:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 18:54:29 +0000
Message-ID: <a44e4fd3-8afb-4263-a3e0-d54f6949898b@siemens.com>
Date: Thu, 20 Nov 2025 19:54:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 0/5] De-duplicate code
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20251118151030.504765-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251118151030.504765-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0291.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 38aaa6ed-3897-4858-2ea8-08de28663beb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TmdPTDFtNGUyQ1Z1QndBOTUvQVZnTjRxbGJobnVud2FKTlNDclIzc2VCLzFS?=
 =?utf-8?B?WG9Da2pnSWlvdkIycHJPZTZRTS9ITzB2VjZweEhFa3c5UExQRWxxcHoyTWRL?=
 =?utf-8?B?SFF1enRkWU56cTc0RjJxNnAzR3oxR0xqK2FndHRnZU1acXJORzgrUk94NERY?=
 =?utf-8?B?VVhSOU0wdSt1NHg5RmplcEJ0Qkxxd0duWkUxUVcvZEJNSVdDZVJGcmQvTjdL?=
 =?utf-8?B?NkhITzE1U3pNTk9uS1N0VzBZUktmZzd0Vm5TdkpPQ284ekgyeDBLNEk5QTBG?=
 =?utf-8?B?bUNqcDd1cHJRT1RDaW9hdSswWnZyNXU2S0JYZjA1bDJMMmZIT2J4WWNDdFlI?=
 =?utf-8?B?U1VSQVdXbTJYeEpzcmszd3ZmWVk0MmhPZWVLTEtYZktjdjRmVjlvYVdvQmhm?=
 =?utf-8?B?bW5PNHU1d2NiaW5QenFUY20ybmxtaVE2YlZQRjNiYkVVTjhtVERXSjdtM3l1?=
 =?utf-8?B?OStHTVFFbDJ3Y1ZKV3JHVkJ6bElpVWdIWWtjL1NSTW95MjlPYzZYdEI1QzE4?=
 =?utf-8?B?QkxlSUVKQ2xyK2FXWC8vaGhNT1FIa1BFUU1Dbk9oeDl6RGkwb3l0OFJXNDFB?=
 =?utf-8?B?ZjNqTWQ4ell2NkQwbjdaV280aTlHdFY4c3FlQVZmTDFVVGM5b01UalVaNTF0?=
 =?utf-8?B?ekhCdlB5bHhpQUNLNlFnNlZQcFBmSzZ3dGE5VXdxTFBpTzJRYlBNOWQvdG9s?=
 =?utf-8?B?S2N6SytscHkwMnB6SHZScHlrYVY0bEVONmJzRW1yTzZZSVNydFdqTUVHYWVv?=
 =?utf-8?B?TCtBWWorVGhMMWZLSkxibXBoaFp6YWczODByWGx3Vkh2R2Jia1hFQ3lnR2dK?=
 =?utf-8?B?cWR3NEpuUlJCelgya3Y4QjlWMXZlbW4wMzhtZytocm5kK0dOU0w4MHhDVjFw?=
 =?utf-8?B?STRWUDY4dUVDY09NK0FSSUlqM0tQTTNMZTR5bjVnWlZxUUJSMHF1OUREbEVT?=
 =?utf-8?B?dmFieiszUElCaUE1T0Rqd0RUUnBVWGt1ZTlTT1JybGtJSXhXbE5hYU4zYitr?=
 =?utf-8?B?OFNweW1SbEVjZGVaMDJhVEhTSElNa1dZdmVTYUM4Rm1sSnpudDFOQ2VQZWg3?=
 =?utf-8?B?YVhkWVVwMnpWQUxNMVU2Zk1yVTZrTmpSbWpQRG4xY1FZSnlyY015VVQ5UUt2?=
 =?utf-8?B?RTRuMkxDZWs0VjR4ZG5WZGhYUEZ2VTNFdHZyZGZia3BsMkFoNnJVUTVDbHEx?=
 =?utf-8?B?eU1lbGFWWS91ZDI1aWJKcllxYWpiMEtadnBUeVlFV0ZHVG85KzhVY0FzcGxX?=
 =?utf-8?B?bVR5TzNCcWdycTJZVTVHTlNZZjl3Yk1qTzNjcHBQRHVuK0JvMUY2eUt6a3Rt?=
 =?utf-8?B?b0NsQkJpVEZuQTE3VzBlYzBmTnBDVW10SHYwbG5YUEYwT1RBdnRWWDQ3S2tm?=
 =?utf-8?B?TnZLS3M3Wk94azBFVzE0RFBZNmZRSDNtbnhPMU9Jd0xUMXk1L1Nqd3VYUHJh?=
 =?utf-8?B?VEtNOXZuQy9RSFdDYjB5eGVPUmpQeVNEVXBUSUtQcEd5VTdaREV3Q0hFb1I5?=
 =?utf-8?B?NytsWWZMeHR5Sy9EZFBmWnNIcEJubTdoeURuQkhxclB6ZXNsUHoxT2Z1U1lF?=
 =?utf-8?B?c1QrWlV0cDZCYkVTaDRHRkpSaVorbXpnWFBjd1poL2ZVK0RicFVxdTEwbWJh?=
 =?utf-8?B?QUVEbGFYWUF2NXhoL3l4RXRRak4zS0pTVTY3Znl3R0V1cTJIUEtxSXJ4OHRp?=
 =?utf-8?B?VllkbW1lL3JBeitHRXFuMzQ2WHRyVDk5L0dlcVNLMkp4cGkzZ214MXRtcThK?=
 =?utf-8?B?c2s2U295QmFNdnVJeFh2MTFvNVA5b3UwWGh4c0d5U3FZc0tZb1NJaHRrSWli?=
 =?utf-8?B?WjFBN25wRENlb2ppbmgrZjFlV3ZLcWZlcUlsNHAva2c1NUNob2o5dlNTVU5X?=
 =?utf-8?B?WktoeXRzMXBJa2N2YnZQM1NjcTJGN0RSSnkwUmtwUWI1NENtREFuR2FaMXc2?=
 =?utf-8?Q?066QzwSU0xa557bSiAAX/AgK3mybkJM9?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TkxtMTREZURvZWlyUVJwZSszeHNIbVhuSDdwTU8zSE5LV2VsQzNiTUpxbHEy?=
 =?utf-8?B?NlhHOXcxYitxTFVwZjByQ3ZlOHdKMlRmUE1JWEtVUWpnVDZHRUExdGxhSHVh?=
 =?utf-8?B?VTVabkNSak5IYkEweGNxNE96U2VKSENTVUZxUnNqTkxuVmtlYi9EdXVLMmdC?=
 =?utf-8?B?MzFyZ3lHMWF1R2RoUUdjWTV3Vk40dHRoMkZQdHJzc3QxWTVHM0UzdU0yaUxx?=
 =?utf-8?B?dlhXd2IrYXF4bi9UcmduMWhwT3VyYi9hZ3lFYWwzV3FMRDN1TFpMQ1dRMEpw?=
 =?utf-8?B?amhDc2JwTUp2aDE2WlVhelZUSG1qY0pSKzA5ZWl1SEpTVVBiajlnazVOWmoy?=
 =?utf-8?B?Z3hOM2Rvd3ZxVUQwYks4RjJERldoSHNUUVlialcvRGpYTlhmWDVwZnlJNSto?=
 =?utf-8?B?aUl4a0dLNjlIbWhMSUtMcDFHVno0clBjaURacVByK3ZqZk1VVUZCVGVZdjBI?=
 =?utf-8?B?QXVKRHV3NjZKZm5mWnVqZmNSc3ZnbVB1UlZKRUovWFVPZ2crUFJRT1JYTGxp?=
 =?utf-8?B?S0pMMER1ckg3R0VYejlFRXdaU0c4UlpnMjk5b1RvMXZUWEFXbGpVM0hwVks5?=
 =?utf-8?B?czlDZWF6bmdLNEYvVlEvTldLdFN5RTl2M3pGaE5ONzBvUjQ2QUhKcmhZRW9x?=
 =?utf-8?B?WjFKc0Q2MXJMcHRKcktQTDV0MUhhQURSUkFaMzZ2cTNrT1dibW9JNmRwajI3?=
 =?utf-8?B?UDVYL1Yra2tNZ0NQckM5dWNLdVBsWm5kS3g1WWxLM0ZkMGRENHN6Z2ZseWM1?=
 =?utf-8?B?b3M0RFNZa0dueTR1TTVxaDVYK0Vnd3ZUTWJ0WGR6Z3NWUHRLZ3FLM0dZZzh6?=
 =?utf-8?B?WXduNDF1ank1bjdZUVg3VHkxeHF5blRacUlxTEVMaVl0MVJpNXlua3FGdEtE?=
 =?utf-8?B?VXVrcTFybEUxN1d3eXBPRjR3cVBZdG5JaHFnR2RJOENDRVpld05HcHRtQnlq?=
 =?utf-8?B?M2Z6dW4wVXBpSW44L211Z0FqeEdhSkhEb2lRV1NTTzdwK1p2THFmczJvVndt?=
 =?utf-8?B?SmRlaGg1ZUxtN0RqR25OcTZwWUFIMFBoWDU3SUdSekdSaXpUa1hDRmUzdDF6?=
 =?utf-8?B?cUVvWmYxTjN0VEszeHJUQ3UxN3d1bXYzVmJVWWdTYmVUZDJLallBcTdpRmlY?=
 =?utf-8?B?OVFod0N5dGNlR2NuNUFEdWVQMUJKTi9CTUx6bUFCMWQ1Vy9QK3R2VnlDNnM3?=
 =?utf-8?B?c080TkhsZkdTWjZ0cWNzb1FlSkJPaU0vS3JwR1g4MnhlcVo5WnZNZDI3YnBh?=
 =?utf-8?B?bHI3M0NWMWFvMmdVeFB6a0xQT1pxTVB3NlVPeHVvVVRZMi9nWjZIdFV1ZVpv?=
 =?utf-8?B?WDgxazJQaXVJd1NTdkVtL21xSzZSN0hBSjNLSXJhbDlOZ1RTYVBBTWtpQmYr?=
 =?utf-8?B?TGZrNUlMV2t0RE1OV3hqamZtdTRsMFBIZ0VCd2hGNHlqUlBvc1NoZWJWcHBC?=
 =?utf-8?B?MjhYUlI3dDhnTW95UFdXcWN5YksxMGN5YkJGZGhDdE15Q2N2NHd6S3dRajE4?=
 =?utf-8?B?eTc5WmorV3dzNld6by9yNHdsSGlZckY0QWNRbStoNjVocWovRnJEeTJsTWRu?=
 =?utf-8?B?Z1pXWDkvQVQzd1MzK05GbmdRVm4vOFc5L2pTdkgyRUdaVENwR1Y2Q2NjdHUv?=
 =?utf-8?B?NXZBWmtNL1F6Y2JpUGJlZFJLZW5MZitPUlNtYjBPWHcrVjlRMVJuTm9nQTRU?=
 =?utf-8?B?SlNQK3E5aCtMWEdTeUZNRUNtNm04UmFyU1VpcjliRUlJMENXL3UrYmtUallQ?=
 =?utf-8?B?b3VlS2p4UDdPQWZISHk5dHRSeEM2N3hPWjlWWlp3VzlVUEUyUTN1UUNwSk84?=
 =?utf-8?B?Z2hlLzEwRXhnTVh6NytYbExGZXBUMHpRQ3UvTVl5TXhSOWRscjhVMldiQmNT?=
 =?utf-8?B?OXNGSTBXRUgxWEpicjNNWE4vL24vRFJObWVlazdCRndmYThlMFVRM1Y3cHBj?=
 =?utf-8?B?a0diS3JSRFR5U3RWUk5LL2RmR0tUOWNvQ3FyNlRub3FLNEpiak9WNkxIay9H?=
 =?utf-8?B?aVFZOE5zNmltSGlrd2YvUWxaeTY4d0tSbnljTDQ4dTNvSDMyVkZzZkhIekV2?=
 =?utf-8?B?dlFwMno3UUE0dmxaZ0pCMXNmdlhob1BrUTBDTE93YVY3VFZyNUQ5R2l2QnZh?=
 =?utf-8?B?VDNDQTRqSHd4LzVpUEM4Vkk0czNEd0MwckRodE5DdUczdzVEczVEWXFsZEZz?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38aaa6ed-3897-4858-2ea8-08de28663beb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:54:29.2065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doxUoT33/0eLxX1Cjpm+dwL7sCKiFOswntbYyvxZjiPyQyqdnHTYhGrALXiJQ6lRqvPA62V+r5nLqPBKY4AkQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6364
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 18:54:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20659

On 18.11.25 15:14, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This series de-duplicates:
> - the code between the initramfs-abrootfs-hook and initramfs-verity-hook.
> - the code between local-top and local-bottom in initramfs-tools
> 
> It also adds a fix for the mcom device with trixie.
> 
> Changes v2:
>  - format code
>  - use symbolic link instead of copy
>  - fix spelling
>  - add empty function find_root_via_image_uuid to be overridden
> 
> Quirin Gylstorff (5):
>   Add cip-functions to initramfs
>   initramfs-abrootfs-hook: Use initramfs-cip-functions
>   initramfs-verity-hook: Use initramfs-cip-functions
>   initramfs-factory-reset: de-duplicate code between local-top and
>     local-bottom
>   initramfs-crypt-hook: Scan if all request partitions are available
> 
>  .../files/local-top-complete                  | 53 +++-----------
>  ..._0.2.bb => initramfs-abrootfs-hook_0.3.bb} |  3 +-
>  .../files/cip-initramfs-functions             | 72 +++++++++++++++++++
>  .../initramfs-cip-functions_0.1.bb            | 22 ++++++
>  .../files/local-top-complete                  | 19 +++++
>  ...ok_0.9.bb => initramfs-crypt-hook_0.10.bb} |  5 +-
>  .../{local-top => factory-reset-script.tmpl}  | 18 +++--
>  .../files/local-bottom                        | 48 -------------
>  ...bb => initramfs-factory-reset-hook_0.2.bb} | 18 +++--
>  .../files/local-top-complete.tmpl             | 55 +++-----------
>  ...ok_0.2.bb => initramfs-verity-hook_0.3.bb} |  3 +-
>  11 files changed, 166 insertions(+), 150 deletions(-)
>  rename recipes-initramfs/initramfs-abrootfs-hook/{initramfs-abrootfs-hook_0.2.bb => initramfs-abrootfs-hook_0.3.bb} (79%)
>  create mode 100644 recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
>  create mode 100644 recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
>  rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.9.bb => initramfs-crypt-hook_0.10.bb} (98%)
>  rename recipes-initramfs/initramfs-factory-reset-hook/files/{local-top => factory-reset-script.tmpl} (70%)
>  delete mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
>  rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-reset-hook_0.1.bb => initramfs-factory-reset-hook_0.2.bb} (62%)
>  rename recipes-initramfs/initramfs-verity-hook/{initramfs-verity-hook_0.2.bb => initramfs-verity-hook_0.3.bb} (85%)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

