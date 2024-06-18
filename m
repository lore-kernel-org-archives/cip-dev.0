Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD64C27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 05:22:11 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.63])
 by mx.groups.io with SMTP id smtpd.web11.78884.1718688116855559745
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jun 2024 22:21:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dTBlrniL;
 spf=pass (domain: siemens.com, ip: 40.107.22.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjAV02U6gz67Fwmidc6yii2Jvb+ge47LMaUJDWecTQ4mNni52b1HJF3FWkUVo5iMqsNFVz07IlUICPv/YVCTYTZj+JQfESpn9GG43DDiEmW5/5t1+YmJpGDo4VUpyeIqBmK4IhAXIFoAr0RXLkZRsiIaCBsrsVmf++T6YpPLCHkBP7V8g7OrloZAyQUMQk7uhOoacWPsakoTJZJPvI9rCJhAK7dHnn/6U2PwXwhe3Qo1427fJpevfA3ca84CewX1GzrnTkCK4T5yVx/Q6N58S8dtmrQmuT4NMmQ4omptLqa+nM3k33lDaddaqNQmBHfkk8gYWlp/yprjykeapHByDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpfzwgB/EQkWrSe3q21QDMm2e4DUCOVAh/NlPyWNcUs=;
 b=j6udmSlukOqZtaWIAz+7rQJYFw4pEbMq9NP3sD1nj+weTNV/vG/u8sMUqLWjs1CzN9L1z4u4k4SM1Y3fmRjERD9MRXoCevWqG4MjNG9QEH6PDebKUf/tvttQ2Us4Wnmge6fJWlSOjXu4Mmvaxs158TG/pzAazs7zS8LegnsWQfRGUGylujb8AQHU+u+FGpm5Nt9Utce1mNnDuCFbPc0hWzlpLyeRrRIKkXxqZJast1vnuGgsdI8jDOQgqk6GU3kNXcHdkty+JrNbKTvn8aud03uCUcBYxF2UWytcyga1a1rvF4/jNAsKQebg7bxltpz+43Ipzdz9jsOFLc2e9eYcQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpfzwgB/EQkWrSe3q21QDMm2e4DUCOVAh/NlPyWNcUs=;
 b=dTBlrniL5vK5erwxtjQi306YtYcXSVuHrJPy8xsW7orLIWIfjMUYUkhPRP7hPm9jOpooTr+UlLpoBUTV09wDc0f1foqDbiB7CgFM7S4gDXiZpq64iFasq2VDjktdLZ95TPfysoBOZJFAYBeD2h0Wx+REum8hjcOwu5awZwUJoYQmXUlioI0p9rK+hjsm71yevjOfAzibDp/65z4b8FGZONZJitctAsk2W0FgnQSybdqQqFkFvni7qH8jQQtHpfXAQb+NvCf2hjdOhzhKXONBs2awpEG+00a8G1x2jWTDNAXJbpgmUlVYpREtHwt4KiE1tYQ+p6Drmkx0VFLgERYM5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8980.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:453::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 05:21:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 05:21:54 +0000
Message-ID: <9fd8a910-c88d-4262-b753-89a3cbd7020d@siemens.com>
Date: Tue, 18 Jun 2024 07:21:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v2 0/3] Split Gitlab test jobs
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240618045008.1765300-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240618045008.1765300-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 901617d5-ce30-4d5e-cf63-08dc8f5690c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U1kzczZZdGk5M3QzUWd5THc2TW9TZlIzNVBpLzdKNjArajJRenc2MDhPd1JK?=
 =?utf-8?B?MkdPRE1QM092V1d1Q0l2SGZNOTZUL3BaVnNQenVSY3VrQ2tqZVZiME1YSDJq?=
 =?utf-8?B?UDZoQy9ZT2FBeEZSNUdhOWR4OG1MN0JSNDhDSXdpRlRGT0V5aW9KNE05ejlF?=
 =?utf-8?B?NGo0L1BrWHBmR2RXMEFJNSt5VHp5NXNWVWxxcEY4UTY0UkUzUTdxUlk4Vlpm?=
 =?utf-8?B?ZmtHR3hCaUgwVVBqdHVlMVhUbnJ1THUrNzc4NUxQdkdpenlkOWQ0dzZiUXNz?=
 =?utf-8?B?YkRRT0hmRit1RkxldE1MMXp6UG11V2ltWkFCOWhmQWVRVlhJZlNjM3E2TzVu?=
 =?utf-8?B?eURZTU94VzNIY0RRWUU4QzFWdzZFU2tybDBxRGdWdFlDNlJCRVJGWlFHVy9R?=
 =?utf-8?B?NVJyNmZudWI2OEFXWTBVd245V0JHQ050NlB2T0NrTi9UVUtEQjVheWpiZHlE?=
 =?utf-8?B?ZjhkaEZsUGk1eDNGS0RkMitIYlNiUkFwMFdGR0VFTVQrZUxMcHJrb2lGdE1P?=
 =?utf-8?B?YlkrV2MyelVRbHk1MTZyT0VFMGxabkw2YUM3R3dVOGxsN0I2QkgwaStuR2VM?=
 =?utf-8?B?eXpjNDlPK2E4YzRkK1pXUmFUUVFBTmlOWUVLSlB6bEo2WkVxdXJkc3RKWG5R?=
 =?utf-8?B?Nm9YZTJiTC96UTJ3QjI2aWsxNDFJaGtBc0R2ZXIxTEhWNnNMQlF4VndFb1Zl?=
 =?utf-8?B?bmpWWjBpNDFpcHJpTnZDRkxhWHB3TmtQeVZ4ZGFETXNyTTdqRDZheCs3WUlq?=
 =?utf-8?B?TVhSMkF0STFQMHRoY3hGUjFvUFdXSTFmS1ZQMHI2ZlZNRVVrUkpVaVdiNnZz?=
 =?utf-8?B?OW9xdDgzT0RBUVdKeitqWjgyN0pOOHFrYjF6S0g4RWt3RlFwd0JDWnZoYnBK?=
 =?utf-8?B?T0JHcXZtVm95K0o0RmZCRHN4clZlTjRjTkdQL0o4TmVqQ0dlZ3ozWkRvVndk?=
 =?utf-8?B?MGhxdHhkMXY4a04wa3lOVk5WcllOUS9hSkg3V1pzUlo5VFRGMy8xR3VMZ0JB?=
 =?utf-8?B?aUxWSGxSZDhQTllTSURCeEpNQko0cDg2Zm41a3Q0WVozazR6QXFWcko4UzVS?=
 =?utf-8?B?cEVWUWFqSzhrTGNzTWdLRmpOeVNUbVVIYkZKaUJhQXE2UE9WcGFzajVGN0tJ?=
 =?utf-8?B?citWdHRxZGZoWGhURXZyamFLZ3AwQVdGdnNkNU1EQnFXcUhEVExjT2c2bDRa?=
 =?utf-8?B?d3JCZk5CT3crMFdQUXo2QklPQmcvWHRkU2RqU0lyazcraE1wajhQSXhCd3pM?=
 =?utf-8?B?ZUl5TlNGRk5QWHNpYWpwMVJKeWdWZWZhYUdyeWVLMXNtd3lpdmt2R25PbmlY?=
 =?utf-8?B?dndEcklkU3FnTkd1bUF0Mm9EUVlSYzhybGhyRWV6ZUwvNDh2WVBvWEpUaUtx?=
 =?utf-8?B?UVRQTE96ZXdwb2VqWHBBZ2c2NUVXTlFWVXk0RVRzSjhBMkdzQm4xSDZZN2cv?=
 =?utf-8?B?aG80VlJaaTlIY29ERFZTRVcyOGk0Y3oxblJiN0tXd0VNZ1ROajFNeFkvMUlD?=
 =?utf-8?B?NkJMVmR1YkdkSEdNNDVwNGkxVDJidStvaFFGNlBxUnR3UjJybVIxbVYxb0VL?=
 =?utf-8?B?RFA2UWxpRmJ1R3BZdHlzMXhLd3hWMDVFemxrQmRteFVpT0dxYXpGVTcwd3JQ?=
 =?utf-8?B?aE5YNzVkTmFxUHlGam0vR0VDMnBPb1AwWGpwdmVGcGx5WG9RaGdURzFEQk05?=
 =?utf-8?B?aHdOZncyenpUd2phZnc3akl3OTBKU05RZFc2dlJZWXNQeW9vbjZIQXBhRWxv?=
 =?utf-8?Q?9788m2aZUC/NVdRbKk8R5VR0UFL/tQBmLwf41hW?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NEN3WGpySzFOUEJVZG9PZnphdWpqMm5HUFV6eEFxSXJXZGFPL3FlUHdJTzYr?=
 =?utf-8?B?dFVJb2pHclNRRUs4OXhOV01vWXJSMjdtSEZIVXdEOXBwa0QxVEVucmxhQzZP?=
 =?utf-8?B?M0dNLzdjS1NIOXNlNGlIQm1EdXNYcGVQOWVaakpGM1RLU2V0OXp5MXpRNWNu?=
 =?utf-8?B?ajVtM3BCYmZCSCtZdzZPQWJETzFiNkg5c095QTRCVWc3SnNSOStxTFJGeE8x?=
 =?utf-8?B?dk5GTkIrdVcxTGFTenczSk5rL3V2d0JFOGlvTGNrQWhqTjVOam9lWVB0NHd5?=
 =?utf-8?B?VVl4VDZiNlRpVGtHNHRTRlpWNW5qdDlYWjQ4MUp4d0t5OHhYSXcyN3NWTlRK?=
 =?utf-8?B?NTFDWW5mVXNaa2F4NUJmajJCR3NUK0tMZjB1cGdFK1pTdHJxSjhTQ2U4NndK?=
 =?utf-8?B?WVhKcVhDeFJ6MzRWSDUyQUltb2RUSnhUdVNiemF6clhXYkl3d2Z3OTJWZW55?=
 =?utf-8?B?OGpPRWkydnQrYUFZSDB3ZmluMGNJMXRRNjJEeXJ5QVQxck5Hb2cyOEZ1L0JC?=
 =?utf-8?B?bElOUFdWd0R2Q082UW9LZ3o1aS94amRVOEdnU210eDF3dkltdFpxelRHQlMz?=
 =?utf-8?B?MDBzanZvck1hWnExWUR1V1MxS3BHK2kxaTEyVWdPTXcrb05UL1JwQkJzb3ph?=
 =?utf-8?B?Rm1qWWFIaTV0di8wZkoxV0VXcWhYNHA0WFRnK1BlSmRPZ09sRE16RUN5MHh0?=
 =?utf-8?B?MUpHUjd4QVp2ZUxUSWhYcEdxVjBRNWcyZWgwUE4wMGg5ZkwyL2VKYjcrQ1dn?=
 =?utf-8?B?MFBTaGUzeFVHMXU4azlPK1lOMzQ2bDFNc3Q0bFlDQ05kUVRNR1ZSdWQyR1pO?=
 =?utf-8?B?NDlNdkd2Q3ByMXhGbXpSOGhPN2poakllWG5LR1BkWWFSY1UyTmhXdjlpNGFO?=
 =?utf-8?B?WEMyK2U0S1JVYzVCejJVWUg4UGEwOUJQd2xnTXB2d3lqRWhWYUg3dkhhRSti?=
 =?utf-8?B?Qyt5WCsyMGYxS1BkUGQ1QmtKT3I2bDQzY2NheVFzUnVSeHVyRnpQTEFuV01F?=
 =?utf-8?B?NmF4SlplM1VnR0t4RytIcDYwYUN4dmxKSmZFUlVDNzhXZjFSYloxTU54ZDFY?=
 =?utf-8?B?QXFHNlpPekx6QWhnd0RjT0V0TWU3TWNabFZaaTZTbXVpQ2dqdFg1T0M0MWpT?=
 =?utf-8?B?ZjVBVGc5QlUrUUZKSVFsZ0JiWU9lVDRtZmQwNFdDRERrQ2ZOdVdTZEhnRXJT?=
 =?utf-8?B?bUY3TzhyMkJkSzZHYlk2VkVwM0kyRWpEZmllejlLUzZSZTY5L2FZaDdDdFY1?=
 =?utf-8?B?TEViUEwxUTVaM1lhYytZZ2xCUlZkdk4yaThJWE5mZUZPVnRMbS9qbDlqekVs?=
 =?utf-8?B?RGdSVmU3VUU0MWdFN1FyTXdOYU8rVE8rUGNwMFd6TDRuaUFtQ1JLZzcvZkQ1?=
 =?utf-8?B?QWtaSE04TXlDdzVGRVBIK2d2alhPbTJYMUZBRlFSRjBlN2tabWFUM3R1c3J5?=
 =?utf-8?B?SThmbHJtd09jQTJrUjVsQXBqWmVPclhjYVpBYlM2d2tQRWx5cUtXKy9FWE84?=
 =?utf-8?B?Wi8rZExKVG1DakM2bXZUN3FHRndDWUFnc0svR0VRdkgyRkFpQy9XT05NOHBk?=
 =?utf-8?B?MnRoMUIyTEZtNG5qRjVhVHlKck1pMFIwVlFDL0djb045dHJOcS8xZUdQWWtj?=
 =?utf-8?B?aG4zU0JTRThZaElWLzdtVHdjbmlJWnpJSGVPSHBqWTFBWWNLMkl6cWw5SlpF?=
 =?utf-8?B?MWdmVW5BR09EYlpUNFhCM2o3dVdFZTJEU0d4Q2FJNTRFTjIwb2Q0NUcrcm1i?=
 =?utf-8?B?OXd0MGZNYnNZTk1NOWx1RGVpTXN5QWJrOVNsbmZ1YmxaWmNBMHlmMEUxQzFj?=
 =?utf-8?B?M0wrYW5Zc0xLY1FkSlJLekg3RTFqZXZnQm1uTVJpcFBwSEFRcHJSVnFLT21H?=
 =?utf-8?B?OTF5alJtTW5jcXVlNzJtcENXeVNHV1JuY0lqWlpHY3lteTFmUDh5NVRvYi9G?=
 =?utf-8?B?clhaZjZjNHdXSFhvSG9USHYvU1lCSitjSU9lc3BVME1ib3c1TTBLMWNsOXZR?=
 =?utf-8?B?eGRQbmUyVHhzR2ljUDVCaCtURUg0WkpCaEdtRTAzdW5QbzZybkg0OTREWTdE?=
 =?utf-8?B?Yk1qMFM3Undac1ZpbStaRWF2ZHhtQm1VUVRnOGh2UDNZYmlqS1U0UTBESUtB?=
 =?utf-8?B?cU5raVd0NDFkQUZ4cmpBQWs1a0Y4WWVQNGFlcUZKMEtIUnRROXBld0hQWE91?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901617d5-ce30-4d5e-cf63-08dc8f5690c7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 05:21:53.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oBybZs6Dip4KZSmoKxsXO2R4d642ZVcQwBEKvbOqyZk++a+8AFkoH19EOXhTQS/4yU8y/TAaNsYi4L9qDJOow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8980
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 05:22:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16277

On 18.06.24 06:50, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> This series of patches will run one LAVA job per Gitlab test job.
> Accordingly the submit_lava.sh and template files are modified to
> sync with the changes.
> 
> Changes in v2:
> Patches sent in v1 are re-ordered to work as expected.
> 
> sai ashrith sathujoda (3):
>   tests: Modify the replacable strings and increase timeouts in the
>     templates
>   submit_lava.sh: Modify the script to handle only one job at a time
>   .gitlab-ci.yml: Break current test jobs to run one LAVA job per Gitlab
>     job
> 
>  .gitlab-ci.yml                          |  80 +++++-
>  scripts/submit_lava.sh                  | 336 ++++++++++--------------
>  tests/templates/IEC_template.yml        |  16 +-
>  tests/templates/secureboot_template.yml |  14 +-
>  tests/templates/swupdate_template.yml   |  18 +-
>  5 files changed, 227 insertions(+), 237 deletions(-)
> 

Thanks, applied to next.

I've also addressed now the shellcheck warnings on top. Will share patch
if CI passes.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


