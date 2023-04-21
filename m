Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC570C77B76
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 18:04:13 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.71])
 by mx.groups.io with SMTP id smtpd.web10.19797.1682100248006391327
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 11:04:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=j5thM18a;
 spf=pass (domain: siemens.com, ip: 40.107.241.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLy4YMq+UQtzpcQ/2sofydUNqQ7QSR6Y4Y+4OpW+iJPL8m9Tafi1N9r6gjvCee44lORGN0HY8qtkE92OMmeM1QxGuRfxO86W+uJT8cZ71U/hvzRPhW5DqTuR0C7nTd55P3x0ycWjWTNHujmK9azCX7ALARYbIsSsXvLxB9Tc2uSHX6NRZvj2PVFdryI08FMmDN/ZWs4R76o+ffPZmP75kfAlc2Aptiw2sHP4Rn0imwDOD8jFbLRs/t9g8pxmpz2r4qUHhX1Quxjr3iBoBGXsSkoODbZSpyRytNPZBkwHnJyyxSeuJupLuEeB+hTmnXB2NtoU54NRwlF4GOoMBpz07A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UETk+sd0XsfSbPzzMqJXwgaGTEUeiLCVrTmiXoKaxOk=;
 b=dq7Pr3idULiSUye+CkOxs0ZZN7FOyz141WXEjqBAbR0ISWEiqlT7vf+NEYukB20madKeRDb362PWn7dOWcsbPq1GaU2C2ANjqrfRTkng9gTwJZnNCLns3VCTjUipgodHWVqujNFHY30zMSj8tDnhGLwX3edalFzB3ceBE1VgZAAPT+zSt9RGv3KRw7gzpG3vm/+Vkm7zFqriyfiIA7dJTP17ZXzCyPOo2rVC6QpJGyZmOE2bZnqjPXPOoafpUC1hVua6Za9mbH6Z9LqeSwCY3qZY+2IHCucCa6hUDbfYr7607B/hh0/jTwzFb+LKa0Wkl6wv7C/OkMb0Hgn8NA4K/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UETk+sd0XsfSbPzzMqJXwgaGTEUeiLCVrTmiXoKaxOk=;
 b=j5thM18amdHz5HLUnt4drGMzukjnH7dj3xqGf0p3ItDoP3priNJSqNW5bIed8KCwRbu0ZF6CVj6FkZJuQYfUZmAchG0MsetJcLyWmSNyg8k8TZNMYHjtA0GnPGSaB1uKmf/iBYhZB/dcvBV/L2H40wi2Dsb39VY9FGgCr/hR4dnDMbceEKzYDaXrVx8dCHWh+0K0yLVJ81W4Vb+XTHc+zga3ngozTLU1UHHez2yhFKP6l2ZvTWVMOCMEgBEDdCVgzhRoaJi3+vRIjfXLYzlVfn/n4+H6KtREDZpnOstDe3OrlTnJg//Ukbbsc0iDFmlvkGmnS/FlZDENXsQ6+OzcXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5546.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.10; Fri, 21 Apr
 2023 18:04:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.021; Fri, 21 Apr 2023
 18:04:04 +0000
Message-ID: <583ea895-45ee-f430-f31a-b5865e815920@siemens.com>
Date: Fri, 21 Apr 2023 20:03:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/4] secure-boot-secrets: Use
 distro specific snakeoil certs and keys
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230421150545.4073324-1-Quirin.Gylstorff@siemens.com>
 <20230421150545.4073324-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230421150545.4073324-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P193CA0018.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5546:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ff315f-236a-4cad-2110-08db4292cb0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OZNtEEQ1KtxMnWe9Sa4prk0jy0mmwBznc6xO6VS78X1tkxBQKAM2Sh3att8rlCHAiKJyLqzmfSVEIA/WWi6N/mFolqzQOv0+zElKtlnudYw43UDU4q9ZZ/qR4B03cXrwmDa+f6Oed9km8Pv3dG0QBKvAWzx2lpjsF0gpi5fpil1Edgr1uTyYr8bYLjXKDTp03Yz8Aig1LmTen0hoZj8KmRXJ1ZFyKQZkYWm8Qqr8/80xjY1A7O1IJxhSYg38gS4UhhwcT/NjGHbIRIhbXncfBTyBXxc59u07RIzlWXi5GZqQ+rDmRwDmlnZH71KCaqJFVnqfYD9MtBX6TXZZN7Z/m43xNjJw31hrivAl2Qu3EYN9qBIfGMFWPqT9YLDcmfidz6gNSU4V98O0AwZUoV1+DWfDCh2M15aUaygMQd9YivTHTcYhAlGzq0yOBk6WR8xwR5evmMRhAdx5k0FYYgXZJ2rZh0Fz9dprLjOmoF4pvo72sE9HIowCZOwJxxAedNLawmKwSTvfoCHVtRfTlITyru0nQ39gaeroaJHaDDw01V0Efqb/WJmLp/tilfobNIKBr2v7vz0kfsd0ru7PCEuxnwpVJvSg0aWS7SWpuur7bA81v4udL3sg/jqYANuHyRBJD+76UJMdZIur4dMOOpq7BQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(66476007)(19627235002)(66556008)(66946007)(478600001)(82960400001)(8676002)(5660300002)(44832011)(8936002)(41300700001)(316002)(38100700002)(53546011)(83380400001)(186003)(6486002)(2616005)(6666004)(26005)(6506007)(6512007)(30864003)(86362001)(36756003)(31696002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V01jVnV1clIraWZPeW9KVHFYSGNadXpzbDJ5RlZhL3d2RUxsRlo0MGRnNGVj?=
 =?utf-8?B?OE9nT3k3SGNnNy8zakptMERwUzhkY0RBVXg5Sk5WZTQzWkN2d0V4czN3RDMy?=
 =?utf-8?B?a3dlR1hIQ2szRktTTXRES0puSTV3dHBaQjdWZUJqaXJVbU51R25KUUw3dkpv?=
 =?utf-8?B?ZXJNUUdDMjhQdThKRXNVaktSK2Zmd3pLVk5lTmdUWVZaU3phbGJydk5NeVM3?=
 =?utf-8?B?NWRqdGx2OFc5Z1ZBK0x2dU5RSDRoV0M0cEY4dERFL2lvQ1NqeUpuUm9WQ3ZQ?=
 =?utf-8?B?bC8yckg1TTRmdWtpQnE3ODVKY1dyUElabmVlN08xME1tNm0yclRMQndBcEpK?=
 =?utf-8?B?OSthZmtDVitXbDZyY2ZuYWdrWmZYQnRIMC94UWFyVWZsQ2JzdFlkRHdCQUlz?=
 =?utf-8?B?WXpnbEtFUzNqUWFrbkpsVEJqNEJlVEJLNmRKZEl6ZXRDWXZpdWVUUUZnemt5?=
 =?utf-8?B?MjNqV3VDNko4Nlh2OWJVS2QwNUFmZFBZck1hT0xFcDJZcTF6MGV1alRIbEtx?=
 =?utf-8?B?UUV6UXhCMEpxVFVHL1ZPTTcyMVh0SWN4d3pSOEV0U0dyU0xGUUdFMFRkamdq?=
 =?utf-8?B?YzFwejBLVlFMc1dWRG5qZlUySjdEQnN1a3Naa29KUG9WVkZDQzkvcnBOTVls?=
 =?utf-8?B?UXlwSGtZK05ubjVJQko4QVoxQXZuMHVRVzU5MFRoeWd6MUs2a1hFN2NTRVUy?=
 =?utf-8?B?Mk4xcnlPekRhY1gyY2ppL3V0UERlRlV2OWlscVlRc2FGbWRMUitSNkZFcWxj?=
 =?utf-8?B?VERGMTVXb0w3aFhNczFzanlNWXEySTZkMStreUxTQjNZVUx5Uk1kT1hpNW5P?=
 =?utf-8?B?SnhaTmZFa0dtU2NyRkY3RkErS2VjRkpOMjZSQXpjVDh4WGpmL2NRbXV4V2Zv?=
 =?utf-8?B?STF6eUdzUnhHRU1JQzU3MVlmMHlUNFppTmZDUEJpTzVMUVVsYzBuNmtKaGow?=
 =?utf-8?B?dnpSUm45cFdGM2NZdmh3RVBjcVl1Zm1TcEpsMThxbUhMYm1TZFlhU1RVM25C?=
 =?utf-8?B?emplWkxROW5CQUxyTDNic0ZCWHErMlkrYzB1Y25MVndKcEE2T3ZDb2JwVnVM?=
 =?utf-8?B?MkpJTHRuQ0VkYzRLRHpFaHlQZjltbjFMcUVyWFlPN2VxYzl1MjVTd3BzRFdu?=
 =?utf-8?B?dkRoYkpqWmlNMk5oMllHUktlNFM1OEF2VE51eXdzSFNUa1FicDNTQldLTy9M?=
 =?utf-8?B?QzNPTnUwZGFhcXBDUitNZFV0TE1VVmtDR2dhMUVSYUFHTTJtcEFNbGNtWDFL?=
 =?utf-8?B?WlJzNjNpN1lyMTBNVmtHemtIZlFCRDEyQXBVdU9ldFAyYW4wM2IzZzRnWmkv?=
 =?utf-8?B?akxIdTN1UVBxa3M0emxFK3owdGF4SHFjaGhkUDdFcDFBVXI3am5IWE1nTnZs?=
 =?utf-8?B?eVBIem1USUdiZ0F6bUZ2V3d2eExhUG5DUk1SVFJHakh2QkVLVWxxSUhUdEF3?=
 =?utf-8?B?YmVldXhLWjJ5Z3BCRWhVZ3RWWnpzMkZRMlp4YWZqSHcrTEc1aGFBNXpUTUFB?=
 =?utf-8?B?Z3FTOWRtSzNXTzNFeGNHd1FWcEFNMEJ1ZWpCajd5MWY2OFFtaDRYMmczSFZi?=
 =?utf-8?B?eGxRRTl3elBZNjNkckw4ZFludFhMaVhmanB4NmZmbHl3VU1CajJWYXhHRTFx?=
 =?utf-8?B?YklGMnRhWXRhV3pmRFVwVjJEMGZrTS9BYi9pYVJPZDdJZEtGZVZPMURkekM0?=
 =?utf-8?B?cDZSbVJib09UeGVBK25WRzMxb1hYNW13cnRQbmRTQ1V2YUplUk1uWlVPRUxo?=
 =?utf-8?B?UjBxTm11MHRKTHdRKzNNb1hTWHFRMndKdXAwRHhoc2JYcFpSN2p1a2hqcEFj?=
 =?utf-8?B?d2JrUnJPb0NheXZqT3NxN1RBTGE3anM0Z3ZnNDFzT0NKWXNzLzRSbUgrRzMv?=
 =?utf-8?B?Y0RLN0tXclA1SE03SmhIU1NPKzkzVkVzTGJYOUtYanFXSDFJTG82d213b1V1?=
 =?utf-8?B?Z0RnV1J5K1VkTjl2dlR1QjhoendDdmY1RDh1Uko3Q3JVU3FHbGhlWlM0eG1Q?=
 =?utf-8?B?TFJvYitSTmFJRm1IS1BMVmFmRDkvem9QQlBVOW4waDFYcVBUSXdwazB5UGtF?=
 =?utf-8?B?dGtWenJ3YmVRMnZnUGowL1IwN2xzcFVOeldlZFBWdjRsNzRZTEtXQ0dRbm1v?=
 =?utf-8?Q?WhUlon+U/esGJ+aHcdfto62X9?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ff315f-236a-4cad-2110-08db4292cb0c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 18:04:04.3348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uzZVWjMS0pTX4zVxoKJt3Ypa4LT+83HrTDnvkWmujvBFhneErsoQ6MuJzOUCs/gev4PTvt4Pex08UiKymTpyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5546
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 18:04:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11327

On 21.04.23 17:05, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes the boot of Debian buster(10) with secure boot enabled.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../files/bookworm/PkKek-1-snakeoil.key       | 28 +++++++++++++++++++
>  .../files/{ => bookworm}/PkKek-1-snakeoil.pem |  0
>  .../files/{ => bullseye}/PkKek-1-snakeoil.key |  0
>  .../files/bullseye/PkKek-1-snakeoil.pem       | 21 ++++++++++++++
>  .../files/buster/PkKek-1-snakeoil.key         | 28 +++++++++++++++++++
>  .../files/buster/PkKek-1-snakeoil.pem         | 19 +++++++++++++
>  .../secure-boot-snakeoil_0.1.bb               |  4 +--
>  7 files changed, 98 insertions(+), 2 deletions(-)
>  create mode 100644 recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.key
>  rename recipes-devtools/secure-boot-secrets/files/{ => bookworm}/PkKek-1-snakeoil.pem (100%)
>  rename recipes-devtools/secure-boot-secrets/files/{ => bullseye}/PkKek-1-snakeoil.key (100%)

I'm a bit confused that the existing files are partially becoming
bookworm, partially bullseye. Is that correct?

Jan

>  create mode 100644 recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.pem
>  create mode 100644 recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.key
>  create mode 100644 recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.pem
> 
> diff --git a/recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.key b/recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.key
> new file mode 100644
> index 0000000..24a5837
> --- /dev/null
> +++ b/recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.key
> @@ -0,0 +1,28 @@
> +-----BEGIN PRIVATE KEY-----
> +MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDIi65d6LmojD5S
> +9q8vE/LI2HHQboiO5/1KrFVc6kpxD6XdkJwpBoItYIfSls9CPnzvNWOAxR3hIeBd
> +1U/prAPPxvQ1wuDLMXfWkcGaYHfPnme/YluAjnpuLH1MQcumgOzj5xYBvZZk+Rby
> +tX/phH7FW4Tx+L1oBYnsfh3BSE/NTtEEHV1nXAXpa/dvyefWMlrlbwjfM5362lZz
> +M6yrJGcOcWEyI66UYCIVO2Yhe/ZVF5B/tPGtd2oACz11xLeqLPM1WBjlekAG2Zi7
> +UCPIvDCpdn5uVna2ZRQmJyDDdh0Ja2VMC19dkMd/5nOAI21O+FvYPOkBWYX8f4Dz
> +DyVQlmIFAgMBAAECggEAERP8FFk2Pkk7IXuKbZroSPxNrO9Mx8avxkUou9Hj5v7r
> +JBQliETanxyiVGetXLnPj9tfDt86bSqiXbtFo+OXK4GI2G8xD3y19NrSvt/KNC8M
> +LLsmiasYd/tn7C+KNTKzebD7KcjIXu7ral3Ud8Flvk7N4oFJN+uI1E/lHsmWqigO
> +X470lWWe+UkhoV7WtfaxDFnsXyBUg0ogkO+ftlnSjfnW4gyMourCaWJQs9ONnZl5
> +4mqeQHSkVxZnMR/bACeuuCVhF2efXSg3OEHpxcwcl64Q551cQItm2bKdHDV1Zkr3
> +5eS7WMQCpNYCgjQ4iOt9hjOe3B7+RpvzD9FPuiMUYQKBgQD2saG2ZJCKKbaH7eIb
> +Jc1MRCIQ4UUvsTz/WJt9aLe/MOGgsBGucfWnjkM+CcvrrjEsdchSXr/C2jv0iP/a
> +oD2anTnidUnhfgBCCrfEJP/nucvRAd9AtppV3M0ijPiMlPdw7SBhwEArgGD50YZD
> +plStFG3pWQcb9bp9bQPV7s+cSQKBgQDQHGMmvhKE1dvsnhgNDbi5LCZzYTUiBfkW
> +Me78kwoKLIgNZCSvG1V0gv2/r6SZh5zLEUlLdDKvdmo4erA3Wy9i4H8IfIqDp0ev
> +MnJkVOPxyvyHRkosO7bFk0XF8EiOfm+K1Jdb2rfjvugUb/fQTDXZh57g2ENCRoS4
> +H8hz37K/3QKBgHbLTSsuvCe8NIi6deJKztTGDn2AbTetKslvmtjGP42S9WPSxYDy
> +obABIsJSJ1+jr0xQn5mCxOcI/kwgWMyn02KMCd7SSjSK34bt8FZE1vJ4lvxb4W0h
> +QarNO/9CUUIpTgqUNb68vGn2VTyXuAcFpsr+BnuTAohlSVuyzmELse/5AoGBAKxA
> +EsEqaWGRMSqz3+xOAyshI+Iz/ypeD0ETq19axOCO4z1SOhrFYQHCugxCcNayrFBX
> +ynatgpZASMLeqaPn0Vzhu8Nmca9ucaLM+mmY6eJjxIii4RmjgzAdKY8fxq5KcEBU
> +ncLlUXcruCPSWScLLTcTTamE1oawn4FWrS9bZDPxAoGAQHlEqLAmGAZADaj40kop
> +RQIMz2IGw7VjLdDC0NaKgopx0CTF1ODfFH5e0l1eroyQIxYzl6be/oYc9x57GfzU
> +VlPEYFsgwFg2nRKniqz/eUrriWfyblC23F7vQdW2un0eEbmgUnd9S4s9xikTYYyA
> +8z18hsBaH0ZngalMu49G1aA=
> +-----END PRIVATE KEY-----
> diff --git a/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.pem b/recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.pem
> similarity index 100%
> rename from recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.pem
> rename to recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.pem
> diff --git a/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.key b/recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.key
> similarity index 100%
> rename from recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.key
> rename to recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.key
> diff --git a/recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.pem b/recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.pem
> new file mode 100644
> index 0000000..dd02a82
> --- /dev/null
> +++ b/recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.pem
> @@ -0,0 +1,21 @@
> +-----BEGIN CERTIFICATE-----
> +MIIDdzCCAl+gAwIBAgIULTs+L+8XzClMGhAvyFIdsp/PYgUwDQYJKoZIhvcNAQEL
> +BQAwSjELMAkGA1UEBhMCVVMxETAPBgNVBAgMCENvbG9yYWRvMRUwEwYDVQQHDAxG
> +b3J0IENvbGxpbnMxETAPBgNVBAoMCFNuYWtlT2lsMCAXDTIwMDkwNzE4NDMyMloY
> +DzIxMjAwODE0MTg0MzIyWjBKMQswCQYDVQQGEwJVUzERMA8GA1UECAwIQ29sb3Jh
> +ZG8xFTATBgNVBAcMDEZvcnQgQ29sbGluczERMA8GA1UECgwIU25ha2VPaWwwggEi
> +MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDIi65d6LmojD5S9q8vE/LI2HHQ
> +boiO5/1KrFVc6kpxD6XdkJwpBoItYIfSls9CPnzvNWOAxR3hIeBd1U/prAPPxvQ1
> +wuDLMXfWkcGaYHfPnme/YluAjnpuLH1MQcumgOzj5xYBvZZk+RbytX/phH7FW4Tx
> ++L1oBYnsfh3BSE/NTtEEHV1nXAXpa/dvyefWMlrlbwjfM5362lZzM6yrJGcOcWEy
> +I66UYCIVO2Yhe/ZVF5B/tPGtd2oACz11xLeqLPM1WBjlekAG2Zi7UCPIvDCpdn5u
> +Vna2ZRQmJyDDdh0Ja2VMC19dkMd/5nOAI21O+FvYPOkBWYX8f4DzDyVQlmIFAgMB
> +AAGjUzBRMB0GA1UdDgQWBBRjuNXuXfh7mi8I3eTboeYGyFTa2zAfBgNVHSMEGDAW
> +gBRjuNXuXfh7mi8I3eTboeYGyFTa2zAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3
> +DQEBCwUAA4IBAQBW2ckn0APqBnwSiOXCWkMCnvY7K7UOfxAlotEsMFSrkzdEa4IE
> +sn0+A3RV/r3HZGqIaE8GMsBqp8UiVIbL5H67dkqvJEke94/7wEUC16JSSOBc0Mac
> +HeArDWsL/WIbzKiVcRrmgX+XwJFlsUN5UtR/feTHR08yiy5srSCIJEqli/cTrOxS
> +JAgvWPLxcoFhOKf6Mi+nwWdrQEbpXvvv8Jv/qyyz5e/VmTRY0wIVmUjd+Yseu+5M
> +3+cpKtlYaawMxVni5RibA0A12fm+i60fGPrkCNhascUrNY+Oppaf/h+QmKOwEM7h
> +pqKXyGFQyU6dB6cFBQ/uD5IABUYuEOuL7VFY
> +-----END CERTIFICATE-----
> diff --git a/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.key b/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.key
> new file mode 100644
> index 0000000..b9e42c7
> --- /dev/null
> +++ b/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.key
> @@ -0,0 +1,28 @@
> +-----BEGIN PRIVATE KEY-----
> +MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDNQOknAPMOkujb
> +K1VFKC39BZFiT9iNp7l9u6OK2rvddgu4Nn79Z/lTrOk5/J/Nf+XlHQoJX1dhQkXj
> +tASY0KehamDdxF1GvL7cUhi12c0rXnUBnYvvg4jiwxfVqRIT4x9kWB08Vyb6fS4m
> +BC69FgbJhpHo3XBuEn/aI45tr6xsrJxoqIvV9KOKnZyuIcD/TlxhKiZ1RP6tNRkA
> +sV0JC45T6BfxGqGZ9ujxUQTsykTeeu8ehxAAWmHJiAbyNp2OCDKYTuxARkasGo6v
> +AwMeK1umgY2U4jZV0WAvmNEoe4HrWIKSpOZJa5LiVs4QmaazqGFCdOe7/Irs7c0R
> +Z6AA8yu1AgMBAAECggEBAKUb9THx+pObrAM6TYKvOqdSBkxubIYvCPDSs1EseXlB
> +z1WlSOwx6ofcDVUfGbGmk9mFTaCSeGj9ddkg453GI0Ken0NmBZ60kFgNFmGazgd4
> +GWluQbYvOjsnsxGlyqwCxSrkEsiKVwmjDy93p91lTZppTRBkqV9yNDTW62jiqzJT
> +CzWimHWyPlK7MjfOyV/X/GD8rugr0F/ikugzVJXCIuhnO62ouU1Imo+Agb3jJM5h
> +26CWerha8Nd6z6lvHM0g014gzL40JrxehqOkYp/6VF6qX37sTHyAw9J4RUQROC/L
> +L+XYAAQZMv3GBJhkn6FOBlKuBmJLw01mTKXuNyGf1EECgYEA6cShh7uPJHeqqHpm
> +ddt0DBgwFueH3pXPv1a6sDBt8P3PJ376p8X1QpoL30sZYc+cEXJcicoaq5NqrkJA
> +NltHg00sHqyfEfaDS2sr38e5qWoD41BsFdbNmfe2SaunXmSZ7d/QD810l+UaRNCR
> +doZcmeCFpcXRs0N1nc2C0w+Ya/ECgYEA4MYPCZ43lB1qeShUcaY/WFiWnJrNdoJR
> +p9S7xhPAqpXmG19utc+geTvN+y8YqOVg1ICaXpfYV7BG7VdD3mLQTIxdai98Rl4r
> +EBKrSGV6cyXkghaGeZHL2M9/FLxCZrfEpbzl82kacCJHCaiQiu9IVTsOabwoW68x
> +Evfz1FHaEAUCgYAmPrc2n6bhjnprKetNaOPpfqOPe72s2tGsOiI85Q93l+6mRY34
> +mNhxVwaON5kleXPNHuqo2FnYrDuN2uTqf7CJeLy5IAC+TZhZZGU/LUvgval5LRUh
> +1Yy5nd9C2kR9mvPcCPvfOfvTRfYwP/csbvsDacozvtN6ApVhhdfbc/e54QKBgFZV
> +PGlhT8+gDMlEaErOo/326MJ14vzlyR9BYm4OIC5lLODOouNKQETQZ6lWyY31rF9y
> +ldhHUl0748I9hl/gbEk6kJa8bmtIuBmQUiGYeJPJth8RL8155mX8LL92H7r8Upem
> +GlyHvhPb1pUrHXl/trSl3j9WedndTGgQvKKMXclRAoGBAKCwevyJrlhnvbZQzjyV
> +zWPyy3028370nsTYnOBh2yVtPThcOCewp9THEy0FAVkMYqE1sdpAN51PdD5UPGFo
> +RkXd/5HQTSDkVGHhO7VohXM/H/nNQgtotoDRSMkxTymQTHad5LNesi3dCEqa1gTC
> +gyh89dCjF1p+mnLi0xITtkoA
> +-----END PRIVATE KEY-----
> diff --git a/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.pem b/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.pem
> new file mode 100644
> index 0000000..73936f7
> --- /dev/null
> +++ b/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.pem
> @@ -0,0 +1,19 @@
> +-----BEGIN CERTIFICATE-----
> +MIIDCTCCAfGgAwIBAgIUSbJC1oRCJUbGkwfWHscBeZrRHZcwDQYJKoZIhvcNAQEL
> +BQAwFDESMBAGA1UECgwJU25ha2UgT2lsMB4XDTE5MTEwMTIyMDI1NVoXDTE5MTIw
> +MTIyMDI1NVowFDESMBAGA1UECgwJU25ha2UgT2lsMIIBIjANBgkqhkiG9w0BAQEF
> +AAOCAQ8AMIIBCgKCAQEAzUDpJwDzDpLo2ytVRSgt/QWRYk/Yjae5fbujitq73XYL
> +uDZ+/Wf5U6zpOfyfzX/l5R0KCV9XYUJF47QEmNCnoWpg3cRdRry+3FIYtdnNK151
> +AZ2L74OI4sMX1akSE+MfZFgdPFcm+n0uJgQuvRYGyYaR6N1wbhJ/2iOOba+sbKyc
> +aKiL1fSjip2criHA/05cYSomdUT+rTUZALFdCQuOU+gX8Rqhmfbo8VEE7MpE3nrv
> +HocQAFphyYgG8jadjggymE7sQEZGrBqOrwMDHitbpoGNlOI2VdFgL5jRKHuB61iC
> +kqTmSWuS4lbOEJmms6hhQnTnu/yK7O3NEWegAPMrtQIDAQABo1MwUTAdBgNVHQ4E
> +FgQUFD7OXb2T6sOysRo3hj2f15SX8I8wHwYDVR0jBBgwFoAUFD7OXb2T6sOysRo3
> +hj2f15SX8I8wDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEANZRB
> +NFVUVZVehpj3QGbbSjp77m0V6JrEYn6u/XjLRFsUNw5Hh35UCR0HkKZ0cLgrVKb/
> +8yL6LaYLOY6yDwEFWMtLXiF2S4noO8raEgW6A7DHawb2Y4ZNFRO4oBkyWbtd36Uu
> +UfSszs2av048wb5J/pNedRSx8I/FiCNWummzpkBHzx023TdLPd8fmkmG7ZBpStN0
> +Y//EE4DKTfHxAwt5w7WdZF5EY/KHPopnR+WSrdutRIK6zT+/+vKihtHYZbrv+7Ap
> +K7xOM/zJ6E9vUROmuOhL3YL3MuLn5qHEvhM0eMxEAlCnSJlFkQE4/RXhDpZJYbR7
> +x+PQllgoo4H6W30Dew==
> +-----END CERTIFICATE-----
> diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb b/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
> index 24a5352..a446987 100644
> --- a/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
> +++ b/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
> @@ -11,7 +11,7 @@
>  
>  require secure-boot-secrets.inc
>  
> -SB_KEY = "PkKek-1-snakeoil.key"
> -SB_CERT = "PkKek-1-snakeoil.pem"
> +SB_KEY = "${BASE_DISTRO_CODENAME}/PkKek-1-snakeoil.key"
> +SB_CERT = "${BASE_DISTRO_CODENAME}/PkKek-1-snakeoil.pem"
>  
>  DEBIAN_CONFLICTS = "secure-boot-key"

-- 
Siemens AG, Technology
Competence Center Embedded Linux


