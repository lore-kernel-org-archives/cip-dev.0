Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3526CEEB589
	for <webhook@archiver.kernel.org>; Sat,  9 Sep 2023 11:06:57 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.58])
 by mx.groups.io with SMTP id smtpd.web10.14549.1694257607159202265
 for <cip-dev@lists.cip-project.org>;
 Sat, 09 Sep 2023 04:06:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FBMc6nYg;
 spf=pass (domain: siemens.com, ip: 40.107.22.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avyJH8jgE1qOGE31QeiXNZz4BniY2Kgr3UxKyRVFViK9KHm36tOIeqf1NhpQ8imTWVsGOV3Rusbqgiya2c1TX6dSa2qP0P+rPHy4pHZoVRPpZ9q0zz3hc5XGvEiqgnKRdDgRB4E+t1bSxypGNLJHH5D8yogj3DhqcQ/jkTwVbWI9l/03WbFfwY6/59nQimTxvmgPSww58iOUZa28p1JN2aGN0R4ablZzV86b9ciwxRfng6A/K5Hd0S4NY/mGroSE8QI3xNLZupAzjop4kgYlmR1Lpedq0XX7kVmVZkMtD5m5GFiZDnlhYzpmaYam2lPC3n0YB0ZiFkD1gXEpD9WpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IPVcqADANh1z4KwUMPlCHDb7VEQbaRFlgzI0GarZYI=;
 b=f0g30SmnqcS6tN9aOrHZLWwIzH9VttANWehb/ccxgJqNUUZ3qPQSAOO7HNDtY4VxHsSWZcCRngVWqWe4pWwBQ+9KnBrC37SxxuGqVl3+vzZmn382KZD/hqiVLCyEQiSQOGpRHAVLKqbcDj9HAj48+/fSPQOiys50q9PyiOw5tI1prCNfYvbbiGor74Yf4akaksw96LDCmdoGBMFVFaLk60/jt16H39Q8AlukwxFHrIXrAV5lbB8oe0qS2TTviUxH4neAHvPQaNgbWrjI/qABiWf0tSMIxuTArz1ysiea/+QFwPvQpJCvQWGdZsqqgSpgmu5U0CC2tei4JuHhkkAUTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IPVcqADANh1z4KwUMPlCHDb7VEQbaRFlgzI0GarZYI=;
 b=FBMc6nYgQXmgJQNmgpKkuFatsjDYX8PkVvuXE5LNqQ8EcGT0QyDyyWh5l8B6MwIINeEsAbLjVwvN/hMWn85B+i1oLiYK/V/sEq88g5TwdT4R0igaPJiXOYPwEl7vc/5CmkITQpC2n2kk32eaqVQqSYOOJm5xUzTUT2sJulHs3OVuXT3A+Dqok++Ew8yOlyUK8PVloKecMtnaYwcYq8Br/yAlNwTzhe0iYuCbNnY4ba3fdxHJlV7s0Od4rP9KgN7vWCuId3BwDBcYYiQRli4VkJ9K/61JdjI0LK7IjgptyXschwyPSDSUw2hjjTrcmgKgRCYy17+sAmVIKd8WWiRTCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Sat, 9 Sep
 2023 11:06:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Sat, 9 Sep 2023
 11:06:43 +0000
Message-ID: <8ea1baf3-eda7-4dbd-8617-2f982a243d83@siemens.com>
Date: Sat, 9 Sep 2023 16:36:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 1/3][v2] Kconfig: Opt additional IEC 62443-4-2
 features when security option is selected
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230908124237.508469-1-Sai.Sathujoda@toshiba-tsip.com>
 <20230908124237.508469-2-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230908124237.508469-2-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3942:EE_
X-MS-Office365-Filtering-Correlation-Id: 439417d5-49bc-4728-5fec-08dbb124d9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z39Aoylar4YAyE6WMcwFWAWvczfcfuMb9bbzaAgwjKlzuWH0T7sog2DQTyoOa8wHOIkghvHQBU/8sffwPYonhtTTdmzYuuMF3LfVUf4rfKHGL+la8twN/uuXNMeYDdI+pfl9i/0Q2CZQP8ZLdldZw+OsOhBaeP2D8tuJK4vQdux4n2YZLBwXWPB6AYS61nOFGTVmnLOS67bGXesJiXJLxAnAituCmqzLqM5AZgtVAF77tTL2MKVXlowBcMoeSUcYGbsLDY4xsgREjODUa1BURu56DywMHReWOSawpXvWOXjOgcMISJnWEJg3Q/fBc1fHgop4KQaEc7n9rWgSL4MO5GcyfO0LsmzP/lNYPrbiLlUB4CtRE7l9jkSyGAH1OVHYFWJpv/c8+kgkU0HJ74bxlrU91ggoW/60rrq7ny/sEAKTYlHkdt/3euBPVOisnt+Z+YlYhS3nKMHUlwkcdT61KuVpVN1NkhKc9QuXzBz1M/K/kL2GWIYVkh0/6e/nI1UAIaufxVIwd+7Rd1pp3eMkAIpiISQcm/O0kThIxooCmOpnAEzit/jlhqZ0lhApB7qRTnqd1XTYNznTzvKvRygReyj2ZdjCsRwS+xmjl6Mb13/OhoecDdwahHUlb5VQgNtwvd5wEz6BdMM9zb3zXXxW6A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199024)(1800799009)(186009)(5660300002)(15650500001)(83380400001)(31686004)(44832011)(4744005)(8936002)(4326008)(8676002)(26005)(66476007)(41300700001)(6666004)(6512007)(53546011)(38100700002)(2616005)(82960400001)(86362001)(478600001)(36756003)(6486002)(6506007)(2906002)(66946007)(66556008)(31696002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RVViZnhpbk54NEVvSGQ5WWJoWjdVT2p2Vy9aWkpPNUFJYjNhSWUvTWdTdmt5?=
 =?utf-8?B?eENTVkpCWEo4UndrWmw4Z3doQzRZTzY0UmtXTHlpakpGaVBLQ29idG56VE5T?=
 =?utf-8?B?bjF4RDFVcjY5aDFkV3UrM2FERmVBRjdhbTlIYnQ1bHQ1ZkVnMjh1Ujd6ZkJv?=
 =?utf-8?B?eXVrL3pJTjUydlZnaUc1aURkbTZLVE9IWXJjRGticEErVWpZZWszQWRuTFpy?=
 =?utf-8?B?NndlVFpyL0JxN1diS0tDcWFSUVlHZE9IOXp4MWFDQWhPdnhzblpwQWVmenBr?=
 =?utf-8?B?R2NxdXNMeS81VzBBcVBEUmtvTklBbWNRbkNCcWNoU1ViMG0vcmxtNkJTOVVJ?=
 =?utf-8?B?WUV1Y1JQNFZ5a3dML0h5SUI4S2FhWHd6bUJLdXZwTVhpSCsrNUpKYVJrblI5?=
 =?utf-8?B?ZWFKLzRFTzUxSWdFOWlac2R3YmRLd09jbGpiTzNKSGJnQ2Y2dDdCWG8zRURO?=
 =?utf-8?B?WGZOSkhQbGlOVm40TzNnaXlsQ2RqN2g3azU5Rm5CQWdlVUswbUpXSHBxdFIy?=
 =?utf-8?B?aDI2TVEwWFIzaFVsK0lLeWF4Ryt4OWllSXhHS2tYNnR0RU5ldTNqdkgwQ1Jn?=
 =?utf-8?B?MzJ0WXM3RGhVL3FvVHhCa1RaVHpLV3F6UnQ4RXRZZVlOOTcxckdKaTVQeEdG?=
 =?utf-8?B?ZFZxZEZPV2tUemVPOE81cExDTm1YSmtlS2FXZERwZzA3RFZCWHE4eEc3QzJp?=
 =?utf-8?B?RG5RanEvbXFzRnVWcWZpSElNQmt1Rk1zNE1RN2N6OE80N0JSaDBLbjBCYXF5?=
 =?utf-8?B?RGNvVnFaZHp0b0h5K1lUeHFhR2dTWE11VUVQMkY0OEJxWGtVZ2s0OHUzMlpH?=
 =?utf-8?B?eGNUQmFPS2ZyOEpWQndOMEFHR2pYZFZDNjZvNTNPY2VKUmphRDhEVXYveFNN?=
 =?utf-8?B?WTZBQ3RFaXlJYlZJMzJha1U4U3NaSTVyRUVsRXFMV2xPbkh1SFZQOEFXcFRq?=
 =?utf-8?B?aDg1TVIva3A5Q2t5bWZRQjVQd3NlblZEem93clc2UnR2bnlXcXR2R1dZeHVQ?=
 =?utf-8?B?OHFMR2lhSFl0UlZLVjFaYWRjYVVjRCszMmRiVjFtT2twK3NuNjYrblhpNVA3?=
 =?utf-8?B?dW16M05hcUlFNnhBSTQzN1hLZnNadnE0ZXo5OEdLQW52S3cvRVY0Q1VDMmJB?=
 =?utf-8?B?L256bUVoVDFBV3Y5bGpZMUJsMWR6OHp0TzIzdGNhU0VpVUhxRWZRZ0pJenBZ?=
 =?utf-8?B?QXNYdHNYS1F1MHU1Yk5vbDBDTSt1bjJETkRMMzBWUG5DK1orYlJ4Mkd3Rlh1?=
 =?utf-8?B?YisvTEVTV1VIMUJxZTRWOEtidjNBMUtzazhOa2ZyYS9oT2ROK3Jjb0hVUy9M?=
 =?utf-8?B?UUsvei9kM25hVWhvbkF2NkI3WUlURU9UamE1bzBFZE0wK1ZyVENIQzUxb1RE?=
 =?utf-8?B?LzRjRm1SMEgwVVVVQWJLRjBYVnh0eVNteHIyQnozem4rQW56c3o1OEwvTnUr?=
 =?utf-8?B?QndEQVhDcE85YURuNWhjbkNHd1BSYlVHbVRaaGt4YUI0VXZBUmt0b2NaRDBn?=
 =?utf-8?B?TkRUQ2JiQzlpdFZGVFdFU3BrYnhaSWV6Tkk4ZDlhT2tlWnkyVU5UOGdsMWMy?=
 =?utf-8?B?cWJ4SWRYdy83KytOZWVOT3RyQzV6UGRjK1lTb2NDa2FqNkpmcS9IUkRacmJW?=
 =?utf-8?B?WWc4V1pPL3F5eE9kZUJ0cmVXUU9BWmJzZlhjUGppL21KdlNyVzk2emswUXpv?=
 =?utf-8?B?MW5kWmxBenExLy9zUG15dk16S1dSaFdVK2ROdCs0Q2hrOFRhdzJ6czlBU3kw?=
 =?utf-8?B?cnRQNzVxUHA2czd2UEhLL3UwMlZQUmpyQ3BWSStlM0toY3Zpd0drZmE3cHBV?=
 =?utf-8?B?M0tSMGVIa2NuZEhRU2xOZXNUbVpTR1hOL3hmU3orKzhCSE1JckpvbDN4SXJs?=
 =?utf-8?B?VVliMVlGMlZ3NEpIMXkzd0VqVEZOMlE1RE1BZjRjalFqVWVuZncxV1NiU3hC?=
 =?utf-8?B?bUZ2UEF3OGFRK0dBTnNidHJsS29YY2FPbjNHb1FRVFZDaFpQdzBzcnROTlli?=
 =?utf-8?B?ZU82Z2tOZkRlNkxCVXArSWE4L3F1VGpiRmU1OVBCdjFSQlJiMjZwRTllakFM?=
 =?utf-8?B?c3hoN1I2OVlLRUQ5WHljemtSZ1crSk15cFAyR05HS3cyV0tzK3c3d2pyVThZ?=
 =?utf-8?B?ZGNLNzRTZTZoSTV4RzZGcmthS0RFclc3bDlndzFNeHhqdlVjOXNzWnlLUXFt?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439417d5-49bc-4728-5fec-08dbb124d9a0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2023 11:06:43.7977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UP8n8u5z0jlDr8KdQF/4Z0Ztv4pAlxEdGo+myv3bINklekutpg4lIFVA4yGaRNvkkYYiky9ry2yTF6/redwx9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3942
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 09 Sep 2023 11:06:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13014

On 08.09.23 14:42, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> 
> Data encryption, Secureboot and Swupdate options will be automatically
> selected when security extensions is selected.
> 
> Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Kconfig b/Kconfig
> index ec49631..dca137d 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -170,6 +170,9 @@ config KAS_INCLUDE_IMAGE_FORMAT
>  
>  config IMAGE_SECURITY
>  	bool "Security extensions"
> +	select IMAGE_DATA_ENCRYPTION
> +        help
> +          This enables security, encryption, secureboot and swupdate for IEC 62443-4-2.
>  
>  config KAS_INCLUDE_SECURITY
>  	string

Thanks, all three applied, but I tried to massage the commit message of
patch 2 a bit further. Please cross-read.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


