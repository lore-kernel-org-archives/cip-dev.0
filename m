Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DBFCCFA1A
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 08:15:44 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8436.1762935335504592426
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Nov 2025 00:15:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hM4NGMwr;
 spf=pass (domain: siemens.com, ip: 52.101.70.25, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqpoVrMyC3uH7yMZuRtiDAyWnzuxDnbgrYu9vX2IkjYpyRgZibulWxmAe5JF5qERL/1+/wx6fKz9qONzGh+IA78f8Oc7rlzs0fTVGEU2ls7ZGojJcirgKarEpL2shchgMZdMxqb2YNCWi/zGUcx0nEuD9AU8vpuTunQtOXm10aQeiT7Ev69xezh7I0xi64JxjjFryC8zDvrblvzFnFeZeRxQ5HsRglZV7xg/+VdSLUzf7U3qGNX2Au4U1bz7rwT25f7I+fqyT0L2lqbCB1M4U+xHNIbH3como6C0H+Rqc6remyTMmRhPKyGjQQpx3Qd6uD/tViLgLMeBjIcwGTjlyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xt4tda2F8a7tLfkD1zfc0wfEdEZ3KpcVIQasDRPSkIY=;
 b=xKttD/Lquju4nynqodBY5bBUibQm0MK/YU3CP4J+4Gk1cVnG5E78UCY0WZjNmfxAFqLG7a6uGqKcwsDTarWIZxLjgM81XBPDmj/ZRwJQTYNn27bcdWo5nmNFuBPb2+iwC59Xkbn6kb7RgrkgxCkkK571/Xr2CK9z3pWQuu344hyj9Kmdw2LlfUud6bmF+SbfRsis+qXdpHY+4PUBm9nOaTlxTnCNYcbRPqeWBLs1T2md3Ywa/35a0x4XhMFLWlatn0V9CUHZTzyMGRtOdJ1w49q1iizyzKBtUrvkZFWuJx9T1a9xQkajwm7ISNB3dSTlKPRdVT2zFUiPI8uaL7V51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt4tda2F8a7tLfkD1zfc0wfEdEZ3KpcVIQasDRPSkIY=;
 b=hM4NGMwrBdi+51Kvijqq5uuk8kztd4MfiPPlyNqJrTCCwDuxvueAZ8/hUqwB8UtNVJ+G/K6aBwnAJv6VkyzNJTIcPFyRL4c4zxLFckaMBjixO7QY1DE7wO7pzKR/3Syf+hhqa2KirquJdtmJmbcKXzouwlUb+gzwsCDspcTsLp+4f0Ov/mw8s7I0UC2sstky4lGpDe6VYbhmGw+uB+YzuOrCNvZOxhfwtDkxoM3cbh+2ih/I/lvKDduWrTwi3uIctjojwwqPOFpvpHbqCngAo4pIV7pGcG3APW8OWSIwO8A8G3dbIsu/82VyhrcBZNVe27qn2lIXS3o6L7//dwdI8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6757.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:331::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 08:15:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 08:15:31 +0000
Message-ID: <5df8f579-9160-487b-9d39-a9b6d02f3908@siemens.com>
Date: Wed, 12 Nov 2025 09:15:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] recipes-core/ltp: dynamically set
 Standards-Version for Debian suites
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
References: <20251112060521.350022-1-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251112060521.350022-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0109.eurprd04.prod.outlook.com
 (2603:10a6:208:55::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af72edf-df28-4f1f-4059-08de21c3a55b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZjhUMW8yeDQwSTlTTmYxTmh4eHRJN2JCZUhVSFlnQ0FlOXU0eVdqR1Z6cWha?=
 =?utf-8?B?cmc4L3pyckl5cUQ2ZGQrTDUyMTZIeExZNTg5SnJuNWc0UzcwcHRMVnMzVlpK?=
 =?utf-8?B?Qldxb0FGU3QvNUVKdEovTzlBRmF0ZzM1OUwrc3ZJS2N5OXlUZTRNck16TFY2?=
 =?utf-8?B?V2w4WjJCVlMzZkl1MHMwWm9NWlIweTZ6OFFTa2RORXBjVkJVSmtpb2ZxMjZZ?=
 =?utf-8?B?c2RLdWx4N01YWU15OWlBTVhCYldja2hRdmszeHlwWUQyaWZ4YXFrOTB3Wjcy?=
 =?utf-8?B?cWlNdnM1eXFjbmVyUm82dU9udVBQT2lsMjdDRWJtOGIwTFpTTEdmUUxnOTY5?=
 =?utf-8?B?TURTRFFpOUdpbmwxVTdxbk15SWQwU3U1UFc2Nmd6NVZlSXhNc09RbHFXaWR2?=
 =?utf-8?B?YVdDQ2RzS2VJRnFlZmMzWFA4Q3FNQ0pHaEE1OUtJVHFmWmh1cUpDcURYVzdh?=
 =?utf-8?B?bEFGK0tBekFBa0FZeUYyTlY1TmU4a3NqZ2llWEdkZmRGV3hDV3RBREVYS1Nq?=
 =?utf-8?B?cE5iem56cnJvTVZvZVBTcksxZDU1OTMyM2p3aTJDSWNvMmd0NUpMVjNJTEVl?=
 =?utf-8?B?anEzS2FmS3ZJUVlnR1Bsd1ZYWkVrdWxBQVZnK0NaTzBaTm1nMk9ObkZOT0tR?=
 =?utf-8?B?K1d2YVhHWjhnZmlWSFVxaWg0aE5Zc3RwVjE3ekpZTWI5enNIbkNtRkRUdjdk?=
 =?utf-8?B?bHB6cEl0TDVncmJwS1dZV0d3ZTdHRFVpeXhHSWtyNUQ4czZFUjlCNHFuMExj?=
 =?utf-8?B?TXBKZllNMml5NXZXNnUwUC8xOVp4anphREtkVmdycW9ILzZZc3hsVVh2Y2NK?=
 =?utf-8?B?ZlVCNVNIczBVbzRhakFzZE9SZHdObjVrZzQ5elg1b04wZGR6ZXdVdnZSY1VG?=
 =?utf-8?B?dzRSUEo0dVpVeG12bHFMdXc0aHJFbk5sT2Z4TzN3L1VJTUFYR25iZU1ubXpy?=
 =?utf-8?B?ZlA4ZFpua2FacXhTblNGcytMWU1LMzI1RTJiVFQxY1RObWJ6UVQzODh2bjBY?=
 =?utf-8?B?TXdQdHU4MVI1VHRoRkZVVmo3MWozSnZJdjJhdFZPOThZN0RjZGZ3U205ZzRX?=
 =?utf-8?B?V1dyblBNODZ5TXZzL1JJb2R6cWJveGdUNzBBNnVnN2F2aHlHQThveStTRm5n?=
 =?utf-8?B?enFQMUdZSWduWUsxSnAzWEhTQ2FCc1NOZEovZlNVQXVWWmtTdFhGWEViWWpY?=
 =?utf-8?B?VlZNc2psUnVvYU9XMnpSeXhlUXpkVnBLdmd1MHppck1kUFVNODlBcC8xTkcv?=
 =?utf-8?B?Zmw0Sk5FeC80SzBmKzd6WHhsTzJPTEtzZmIzMFdjTnVNTUpVUHpzbGJRcmU1?=
 =?utf-8?B?R1JDRHd1bVNIUENwZEVENVgwS3ZjTS9kU0RldU1tcWpRT2d2eVJDZlJTb0F4?=
 =?utf-8?B?WVVMR01xVXhmMmtud0pBWC9yQWtlN1h6UDI0SmZ1Nks1WEhwNzM2OXJ2RmVr?=
 =?utf-8?B?SWNleEFSeHdFU1RIR216TnF3VnA4YzNmNUJObStTY1p5MzgxVHdpdEJObUJo?=
 =?utf-8?B?aHM0WWY1aGIwdVFZeWh4OWdiVmpmWjdNdmxEVTdsZGRPc1V6aGFzUnE4ZTVO?=
 =?utf-8?B?c0xPM09ET0xiTTJ2NExqb0JLbHZKTCthb0oxaTQ0bXYzMXhxZnQ3WXJLUUJF?=
 =?utf-8?B?MFlxc1MzckFFSi9pWmFTNlF0dGw5U0o1SnphcUNJSnBnRnJNVmpQQW13MXl4?=
 =?utf-8?B?VUk0NXVxbjZpaEJ0aWpYTTZNbnNqcS9rTng1ZzhONEN0bW9WdUhFRXNDNVVi?=
 =?utf-8?B?bmV1bmR4NG5ocVRXbFhSSGF4TzF6eE5GRU5lYXZtUCtzMWk0RWlFS01mMlZ3?=
 =?utf-8?B?SU5iWHFLcHBtOVg2YWxZbzBtNjlGd1hnYTd2ME1Ec1RNUnI1M0NaYS9VMGwy?=
 =?utf-8?B?RnRpUmJ5NFFEK1c3bGpVSERSVHIwWlFySHpjMkFyWVpvb1E9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ekhWQnFBVDJGdXdxeUxOSFpyV1IyT0JPcmxEZXFRcjR0cXhCZ1Mvb0JHTVIy?=
 =?utf-8?B?UUJZSUUxQlVPbGlScUVYY2lMMnF1R2tzWTUrVkI1RlpCY1pEakx3em9zZU9C?=
 =?utf-8?B?MStMa2dvRE9KdlJPMSt5UW51VW56V2JKVGw2YlVYTnJTRGZWM3RMOFNJbVdn?=
 =?utf-8?B?YU8vRmc1eFpOSXlabUR6c3BiVU1kaHBXK1pqZlJ5WGZRcDlJRk1wVHhuWFVo?=
 =?utf-8?B?MzkyZGlmZkFxMk9wT2V5WTRJVWFGWm5XSVZaRVZuWjZHWFBva2ZWL0xIdCtV?=
 =?utf-8?B?T3UrRVJ2OW5qSy91QzVUV0pXRk9iNjNsNVVZR1RrOHJadHNUcTBiczExTnVK?=
 =?utf-8?B?YW9DYnZnVGkyMTdiU1VFeVVRMmNqMXRXWkxmRFdSQTY3dUhSdlltV0ROemh0?=
 =?utf-8?B?ZmZZOWVGSE5kdUpoSjZSblkwbWxJeDJINnVqaEF3cmFCSDd1TGhTYlZtWGk0?=
 =?utf-8?B?WSswdnlTWHZzang2b2x0RUhRck1Oam1Ub0pCMWthc1BDNjJwb3NVN0Y4QitZ?=
 =?utf-8?B?YXNndVNRMmd4ZXdXV0prMDlZakZFN2toUzVJQ3dzb2hydmVpbkpDblZLVmd4?=
 =?utf-8?B?NUMzRThlVkE5RUpxNlNncGNoaUV4VnJ3QjBhNnd1eEpNT1VvcXJJdW9qTk00?=
 =?utf-8?B?dElpN21WVms5RnVpYkZkeXllY3hKQ2dKbmZmYWpIK21nc09GY3I2bW1Qdlpr?=
 =?utf-8?B?UzNOVE9Uejd0ZXZ5bTBuZXZCMkxiVGpVekxuVlF6Ti9YRUpKeGpYUkV5S2ti?=
 =?utf-8?B?L3Zja1Y0T3VsTkFuVDE0T0pPZEdNSHYvL0xqTVVjL1FVNnlLYm1HMDJGN053?=
 =?utf-8?B?SndZSWkyTzlMVUNndmlvR21GRTEzeFJRcnRBL0RwMWxNK0FGb1VlbWZNMEZ1?=
 =?utf-8?B?ejdqYTAvVWdxbjQ0Y2lYaG5kTDdOZ0VhUS82U2FqcTkvMVh2Z1Jwb2t4RU5G?=
 =?utf-8?B?eXY1RU5icmhjRWhuYXRKV2wydzNWdE9DVzczRTRMd0Y4QjAzVTNwaGNidzIv?=
 =?utf-8?B?L0g3aXg3U2psRWtCVTJsUGZncnhpOWJsZjdrZDU0TWNWVDhiU3JNNGk4c2Uw?=
 =?utf-8?B?akNHcEtTalJZMHNrYkRhY09FMDNxMnZrT1kxRHhhLy9wQWQ4alFkRlJlcXl0?=
 =?utf-8?B?azZtQThYYzFQS0E5NTVvaUJ3bWVPSjV4MzRmQ2h1NWhMTytQTitnbUh2S3dL?=
 =?utf-8?B?dkpvRDZwVk0rS2pNQjg5SmRJRGFaQmFBSjVDR3VGUFNuNDVYajVFM1ovdENW?=
 =?utf-8?B?dXc1ZGFuZUtlSTBFekVuR09seklnUTdUNG5TYmJKMzRpYkRUUlRXVDBPcng1?=
 =?utf-8?B?dnE4WmpsV09PMG1KZi9hVkNURnMwRUxQV3Z3cWdBQm1QbTRKWXVUTDllalFT?=
 =?utf-8?B?aFJuRmdGZ0RyS3g1RHA5VUUxZXgxZWE2bVNZVVBPb1liUFhUajEwVTlMQUJJ?=
 =?utf-8?B?blliNnpzRHI3VzZIMlV5SXBtY1RqK0licVRIbWpPejh2bjRFQ01jMndOa0ZM?=
 =?utf-8?B?VFFBcnhwZ0FubzZYOXJFbkZOUG1SR3JKWXUySERmMlJMUFZjejF1Q2grbnA4?=
 =?utf-8?B?bmNBMXJQWVZSa3hHbTQzeS81OTFkK0xtdHp1alFDU3BBeHJBV2s5dUxKYVlu?=
 =?utf-8?B?RzVid2JxZ25Ca1daOTNzY21FdXN0WlFleEpVdFl1WURxNzZJQWR3aDJOMjFI?=
 =?utf-8?B?akM4WStPOGJBbHBWTjB2NHAxaHdRLzh6aWNLZEF2RDNsM1dSUW9HbGkvSHBE?=
 =?utf-8?B?aGFpU1U3V3dUTWJiMmd6bTA4MUlaeTFEZ1BZMGNoaFZEL2ZTSGJIaXBPTEQ0?=
 =?utf-8?B?VTAvWHZnem85OFkvOVMyRFJnK0xPWnBvZkxaL01CQWVWamxZc01JMDFDLzBC?=
 =?utf-8?B?K2k2SFY4NGJodzRCMWc2RnBlT0hQTXVnNkNGU1pJTURwOGljWXBJK0ttcE5l?=
 =?utf-8?B?eFZPR2UxM0xCeDhNcGNJeVdPR2MxWVJ2ZHhOZEN2S3VKS3E4dHVKcUNkVTh0?=
 =?utf-8?B?YjRteXNwRC80aXNBaWk0RktqYXo3QUR6czlFdCtKajJlTTU0QklKMnNDQWNN?=
 =?utf-8?B?MllLeWE1MXhndW50U3dQYzhmRVBtVHpZdlRwNTVWbC9nR0hMUHJNRWFYaVUy?=
 =?utf-8?B?RHh2VVVuM2ZabnZEYkZxNHp6Q00xTXlMV0FXQTN6bFY1R0VMQ3k4Uy85S2NR?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af72edf-df28-4f1f-4059-08de21c3a55b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 08:15:31.3648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxzZ7uCrS2xVft2idPFmpcSNrwe4uqAlggbDVZiEo7wrTXMgrd3T/1EC3UfVnE55s/4uG1hzuVurBY4LLx2ECw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6757
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Nov 2025 08:15:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20515

On 12.11.25 07:05, srinuvasan.a@siemens.com wrote:
> From: srinuvasan <srinuvasan.a@siemens.com>
> 
> Use the DEBIAN_STANDARDS_VERSION variable to set the Standards-Version dynamically
> instead of hardcoding it. This ensures compliance with the current Debian policy,
> avoids QA/policy warnings, and prevents the package from being flagged as
> unmaintained.
> 
> Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
> ---
>  recipes-core/ltp/files/debian/{control => control.tmpl} | 2 +-
>  recipes-core/ltp/ltp.inc                                | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>  rename recipes-core/ltp/files/debian/{control => control.tmpl} (94%)
> 
> diff --git a/recipes-core/ltp/files/debian/control b/recipes-core/ltp/files/debian/control.tmpl
> similarity index 94%
> rename from recipes-core/ltp/files/debian/control
> rename to recipes-core/ltp/files/debian/control.tmpl
> index b43cd6f..0bfc0c2 100644
> --- a/recipes-core/ltp/files/debian/control
> +++ b/recipes-core/ltp/files/debian/control.tmpl
> @@ -3,7 +3,7 @@ Section: embedded
>  Priority: optional
>  Maintainer: Gylstorff Quirin <quirin.gylstorff@siemens.com>
>  Build-Depends: debhelper-compat (= 11), autotools-dev, pkg-config
> -Standards-Version: 4.1.3
> +Standards-Version: ${DEBIAN_STANDARDS_VERSION}
>  Homepage: https://linux-test-project.github.io/
>  
>  Package: ltp-full
> diff --git a/recipes-core/ltp/ltp.inc b/recipes-core/ltp/ltp.inc
> index c8f1199..27e26a0 100644
> --- a/recipes-core/ltp/ltp.inc
> +++ b/recipes-core/ltp/ltp.inc
> @@ -18,6 +18,9 @@ SRC_URI = " \
>     file://debian \
>     "
>  
> +TEMPLATE_FILES = "debian/control.tmpl"
> +TEMPLATE_VARS += "DEBIAN_STANDARDS_VERSION"
> +
>  do_prepare_build() {
>          cp -R ${WORKDIR}/debian ${S}
>          deb_add_changelog

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

