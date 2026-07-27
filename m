Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D768C531FC
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 14:45:13 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32631.1785163509716866939
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 07:45:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DYTrAP2B;
 spf=pass (domain: siemens.com, ip: 52.101.70.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSU0aaRhptRdZo+pq2eeW5fLgiN9ac2zaceD76sMS+IzsnEAGZIy8ko+HQ0UGKAhtaNvdr7y4yXaGAOKmb1qfQHpP0rn81aieUVYmiYmVFrFN66hSww+hAsEC4OVL8Sl03CofJ5oUFPzvxpJ3QG+L1i8u9tVQQMFw/PBATqf/qKqhYtR81FLM0LoB9U5yCvO4UosYCwtysr62bIU5yzHuy019kd+H4PA6cnmMwKQphiqftvBHPWE+MXp7XMAYN/7Ki0MzwQTQk86ez/e/au/v7CB29/cMmRKY6pScGjDchbzZgJq1s8tw5ZEPXlEtCMeDaicwxn1mYjXTXBOVyy0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z177dOG/6gG5l5dcSOR53PClKv/4MBFyhxxKVkcq/OI=;
 b=P3+pcEkZLpy8/fs974OfUk+d49CxeX6Jn+KgNvO/B+UQW/eT7qUqiXRIU6Mvpl4Md2VPvpODIqyOMdZV2LKOKjnRKJ2oK5/QuVbrKk/lPHfN2Zmf2zzZWuSBV/RlqFEE/8ou3hAg0dNYbo0QPxsT7oZE/Mj5bX2t21mdYZluzd5iyMYOzrhzUF7KYPYZr856PKkJeTH/JNDmkINO4wFkIO0I72yYCcIYO6t3SpyX/n2UqKY1MxyyXzQ03HXHzyjWC+0pEp84+d5bQBTu5a0XCpwYsVQBe6rx0vT7QOjqudpkW+cjAdjkc0gBhv4vKAWvXx2QFpl12HtG2zefpvGxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z177dOG/6gG5l5dcSOR53PClKv/4MBFyhxxKVkcq/OI=;
 b=DYTrAP2BuaJUpDMDx7KsgFoVaWdXDeHumyuJ2qhWg0ls3NqyBZ3pdXmAeeTvKbGlBIbjFnKIA9M4cpISoO9vsXL8KQEFWSBCyqcMgkCWAs2kek9qq+5PNFZPaqSdWpAR187+DaFgaMYCHWVS2chmP3iD7G8/UYJL/JleelGaKBYh3jKfiuNnlD7rYquKlAtXCvumT2dvk0epGg4AkV9JaiNyOky/MV7Lb8RSymfhmqXUJ8UY0ekTrArX5cm7nBLkw1MRZ+CmBqH2jVYECbbPlnKGyBMuLqCWokrOvvHrPSstJKGgMSihlBQV7q+fUef8mB3SRrG+6l/Qunf4DhyxsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7704.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:45:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:45:03 +0000
Message-ID: <0e888ac9-f01d-49bf-98dc-9babfa9f2294@siemens.com>
Date: Mon, 27 Jul 2026 16:45:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 12/14] Add kas file for
 hardening configuration
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christoph.steiger@siemens.com, clara.kowalsky@siemens.com
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260724124945.3636668-1-Quirin.Gylstorff@siemens.com>
 <20260724124945.3636668-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260724124945.3636668-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0297.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: fec0e47e-e680-4d2c-d238-08deebeda48e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|4143699003|56012099006|11063799006|10067099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	y4Fy4e9qSEJ+zEiCF6pMjbgkB3U5CSQy759P4ah5Xztm7zcSDQx3470uLyz5ltS305UF0H3mrBJ89gWKSLaMGNKHUP5TF0MbHLiWW7y18HIHN79ivH9gnaTz8ET9v2zP0Aw7IvDylXx3YIkXgIzUVLLZnAKAVanknBMF0YYuDbizGm8Mr2CoBj6hanLaff0aiEAXkZU6pVyv117ITfUc8ZaxqRxu+AU3s5iRoRqlkYOjansdKn+Cjq2pcASoJ2ZwTvmbVsdG4WPufLA9xt6TQi66zn8uFdCV0Wu04WJabjNk1esd927m1ja8b4JAHDF6C3DZdZD3NdLPFwRzDSOVloRO8UXS2Xmgc+rIOVN74EVwcqQ/oiU4b7NBzAk/MqaT3bkQk8Jt4kYyO88a8TfS96AsxkWoxPT4bByHHXmVE/wAUzs2s/0vthFB6deUgopYxZmLviM6GlU6CGCpDLiLcUVTxr/D/oWy39KhiF7Mq+GXodL6y+/SzUKNnebgJKQIt/FX8ipcIl2lE8q6K+SjqNKoQj/iDAhg2k53/TdOOoD73fKARCNTDKIREVuhdG7H9Lk3DpbPk4cKCeW1AB0uiDP8pIxTVQe969coq75SGLqjfdA0TezLbRABz0pm1K1hrlIz4typ/aDbnzDTolLeitGWvS+azXu/8HvPBXoV4gA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(4143699003)(56012099006)(11063799006)(10067099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QWgySm9ZSXY0SjYvTTFXS05FK05OL1RmaG5SdUpIcjRyb2NEbXliUWV0UEw0?=
 =?utf-8?B?OHF4SnErZ0Q1TEpmWmY5bXNObC9INWdjRWF4RTVuK3RRa21XSkFoVjJURnFu?=
 =?utf-8?B?MGxPY0x0VnFOdWpzQys3bW5HR1VZUFNndnVJUXNUVE40KytlU0UvZURySGNi?=
 =?utf-8?B?eHpWWWNHbFpRSHlXMkh3QXZDZzB3SDJmVzZ6TEtYSENub3FSQVNkdWZvQi9a?=
 =?utf-8?B?VWkzM1dEM0NneUxTSWJvTGFsSkJVWUVINDFYTkNiL1pRSU4yTEZHZTZLenhh?=
 =?utf-8?B?cnk3OG1LdDhPQnF2NjF6MnJqbDNvTFVyc3RZK3NQaXYxSG13V0lxV3E1dkxQ?=
 =?utf-8?B?MVhhQ0JUYkhLUmxHdHhLQTVYNDMvUWNPQm51ajE4MGtyazJvUjNvZVhXYnpB?=
 =?utf-8?B?ZnEwM0Qxait2SS84ekJGNnMxakFPRVVqdHdBdWlrUkN6ZVdhY2htN0ZuZXF6?=
 =?utf-8?B?ZjhneGdiaG5jZTdkTzNrUFRRbFplMS90Uk5ML3JpVkxtNTdNekk4UW1uU1NF?=
 =?utf-8?B?NEF6UHhZOXdGVEoyK1NjVlgvSUtGSFFPUGNBbzN6Y21SWkhZSUdaMkRwR1lp?=
 =?utf-8?B?OGRuVVhLMVVNVnp6bzIwNXo1NUdrL211WlVnVkptZjBDZEN1Kyt2TmgrK05F?=
 =?utf-8?B?WmRHcndYMHNCR3VrUTVwemthK3k0S2NHVnR1ckxiczVyaForYVM2bi9wM256?=
 =?utf-8?B?ejBHUm4wbFlxUkxTOEw4U05wbUdHdDE1RlE2OENYV2s1ZFRseGg5MGRkRUxV?=
 =?utf-8?B?bm4xWS84dlVnY3I5em9PSkE3ejJ1dmsxcmVNdEpHeCtpQ0J3Z0pLejMvTTFF?=
 =?utf-8?B?Z0pYcWRxWC8zd0QvNFh6QmdIYUpYOWZQWld3QmFqYzJSYlJrWlRVaFNUSE1C?=
 =?utf-8?B?TEJlcG9IRlE0MGtzZFZtNTJGNXNXZWd0VlNBRCtLTDJ3MHYrcWRweVNsNElQ?=
 =?utf-8?B?TWNYTURyZk5hcHFPSVlMbEFNSHNrVHdRY2hLYkUxVFBnNGtUVzRBQW5PQXFq?=
 =?utf-8?B?UXlqS1R6d09kN25LSUxaM3g5N3NGZGJzdi9ROWNrbnpBWjVZSUpXMThySU1k?=
 =?utf-8?B?R2RKbWgwNnJ6U3VyYXAwUDh0YWQ1eXJlb1hsTks0QzhldkltZGl2SmFvQW9C?=
 =?utf-8?B?VVlQcTJwc3BxSGh6cXhXdURyNjlkYTFsb3EwaVJJR3ZCVGJEVEVoZlVBRFlR?=
 =?utf-8?B?RTMvTURXLy8zM3Z6UzhHdTRoZkpVVVVpKzJxVC9xYmFoNVJFcmN0c3M3emR2?=
 =?utf-8?B?WnI0Q0ZJTjNCaDN2aGdTRXVqbTNjcHhGYWVXSnhrQm1tTHovQVUvS1BtZ0Yy?=
 =?utf-8?B?Q0dTR1ZteFpYUVVobzV3RFJnLy8vWjhZVWFLazRyV0Nyakw2NGUrdUppaHBl?=
 =?utf-8?B?RzUwbS9ETjFkMTlienJuS29IQWVqcnorNit0bmluKzM5NDE1WWhaWitLTTlu?=
 =?utf-8?B?NjBPZVlFUnV3RkdLNW04RG9EaWhCOHR3dk16ditRdEFVNFlGU0RtQVBhaC9L?=
 =?utf-8?B?VnI4UlpJVVV2VXc3eUNybmZyNGhHeWw0cGdOdFYxTGNsYlBEU0xEUjNnT2tR?=
 =?utf-8?B?bTdtdllWMUpCdFJyWEVVMU04VzNQWWFxYkpUVUIzZENqeXRKL05sNEFnTUE0?=
 =?utf-8?B?cWhZeFNSUUMzNEprRWlRQXhVN1pVbU8wZjVUM3hLbnpuMGFRanNJNnNUZlk0?=
 =?utf-8?B?WXRWUzVrRUYxY0J5d0ptbE5UQ1IvbXd6TlM2T0NZQU9ucWZRTzE5MW0wV0hp?=
 =?utf-8?B?ZzlGZjFwSTN0V2RzQWVqbHN5M3M4SFJ5SWI4d1VZbGR3Y0lXS2U4cU5jUE9F?=
 =?utf-8?B?VWQra3BpR2UyTzV1L0swUVBKS0tUOUVtSStwT2YyM1dKRDk2UW41K1RwUHdD?=
 =?utf-8?B?aEplNHVPVFZRRVNDdHUzWEM5TmFLdDN2Q1docnpSd1NCL0wwaXUwZ2pZQ2gy?=
 =?utf-8?B?QnVoM2h3Rm5menJqYnFwNkJ3b1hMY1BPR2hnTk81bXdaU1JSaVNQWS9FRHpH?=
 =?utf-8?B?Mk1RVmZEalVqc3l3amJ3THQvelN3M21LV1N2SmxzZmVGbzh3QnJoZ0hlTzRD?=
 =?utf-8?B?Y2t4YkZNMUFQMkJWTzRpakdhOXQ5S3hxRlJqWVhKRzJsQ2VucWJZeXVYRitt?=
 =?utf-8?B?Mk4rRGZXOXBtRjhqN2ZIVlk1b2FZY0g1TlR2blRPOFEvZkx6MmZUVXRJR1FZ?=
 =?utf-8?B?ODJuNFV3TzZDVnFYcVdnbFQ4L0dqbCtFb1Z2R3FXSjYrWHpzSitMSzJwbmxu?=
 =?utf-8?B?QlNRNlEyazdqUDg1OC80THVNbmlFV2pValA0bmdRdzdDNzBBemFXRElydFdm?=
 =?utf-8?B?QmVJaEFFVjUzdk5maG9INGNqc2JLYnI5RUJtaEg5cGdQSlc1WE9WQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec0e47e-e680-4d2c-d238-08deebeda48e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:45:03.6092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWQ2lfuklewxu/dQsGbt8DmZSWtZNCod1golr1A5NJMrnVlNL40W+EtaVYhe/mjpFeiwK7gY+Em8LztJ60KvnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7704
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 14:45:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23780

On 24.07.26 14:47, Quirin Gylstorff wrote:
> From: Clara Kowalsky <clara.kowalsky@siemens.com>
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/cis-validation.yml | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 kas/opt/cis-validation.yml
> 
> diff --git a/kas/opt/cis-validation.yml b/kas/opt/cis-validation.yml
> new file mode 100644
> index 0000000..0f15747
> --- /dev/null
> +++ b/kas/opt/cis-validation.yml

Why is this called "validation" when the subject is only "hardening"?

Jan

> @@ -0,0 +1,19 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  enable-hardening: |
> +    CIP_CIS_HARDENING = "1"
> +  enable-validation: |
> +    CIP_CIS_HARDENING_VALIDATION = "1"

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

