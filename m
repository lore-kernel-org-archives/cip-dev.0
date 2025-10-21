Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D107FCCD1AA
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 13:04:44 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.61])
 by mx.groups.io with SMTP id smtpd.web11.11317.1761051878768720665
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Oct 2025 06:04:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IYrs7TH3;
 spf=pass (domain: siemens.com, ip: 52.101.69.61, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTF393q2xE7xseu+M7ZQrNfkTDFhaIp2+pXB9G8KqptvAAym3Xq2gRHJuNb3WFHA4q9ckCPMcrIA9HsnLV3Gmwa5Q1Hr6MOTOcMyR+hD9hzgabHcZIObZyXVmHL/nHFkYmjb7x+wFt8qhqGPq5FNxn7KwQa1Gi2et8q5Wn0tUhA5mfnm3SOfJ4W/cDCuf2P9GecyGJ3sBL8N/+RtiWFdB32jQZdiWIEKnzJeXxAEXlhBsjQhWbVYMYj63VTpYZKD9LauC4y+JVCOuWk3qXR3NBdrNqpYUMekrJFkEN+n8gudlPqSxi1/Ml9aKGYlx4kO+3BL9dBqXAblYL7ZePDqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwDyTf7Df5hiP+bv6/qrzUcTWwgI+3SSOGH6kaHj4DQ=;
 b=nSuMltYejGodcNkRRw7/3jAiIitELi8bKvTJmq75U3dRTIOm2h2Nt2fjVX5WTsekrACAzYqStByCP+P4Frw2Meq454AfL6wuAb8wnh6Ky3mzTgqz7OoHNwYqiYdH6BajWoMH9plWgKaFKhLfIeHKOU0WPC0QYFnmFmufHDis9RAErY+iZk+nd2vc9VgELDqzQ8sOZ4dMMeHuJIbdvoTQm8WiuSJavr8rJDVH/AyT+P4klkF67HrglB6MylriiIljQl0xyhM4Q7ynT3bNC1X7ZtVwqoWbHKdC2TtHvfIDyG+xfycSWFGboL9hVSs9R5E/F2RF18fU6/89pK/7NizdcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwDyTf7Df5hiP+bv6/qrzUcTWwgI+3SSOGH6kaHj4DQ=;
 b=IYrs7TH3e7Qdx3HU58WlRaMoobEKnae6Wsl3u5HwsuwSD37KSTIsjdNNP33y9nOYAeF8FBy3g04QPxWWOze6pjedrPcv0bnf9adsGK4xkDRtkGLryIvxRptdXEOLNmIP/KHHsQVRebiYPrmut2hS8od1ohGqKwBQ0puh7ynWf5ZEtZxXqOYL9xRhVl/ahnahzxIISKB+iLElGS/UN7Yi4QHManAouE2CVwJIbxLnbqcc55WuMsuxItR0r5V6g7vTw9ktm8EDq2+nWKyeBZdVLBRwtFimvs5FovKI3WT4pHpSgRm51/kK6HqlJb+EkxFe4m4bOaVxG1aPtg5kYA8tOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::16)
 by AS2PR10MB7251.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:608::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Tue, 21 Oct
 2025 13:04:34 +0000
Received: from GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8141:f914:455e:a790]) by GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8141:f914:455e:a790%3]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 13:04:34 +0000
Message-ID: <70151038-f129-42e4-acf4-9d0e4384da38@siemens.com>
Date: Tue, 21 Oct 2025 15:04:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v1 2/5]
 recipes-core/swupdate-config: Add suricatta section in swupdate.cfg
To: cip-dev@lists.cip-project.org
References: <20251021125233.1528087-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251021125233.1528087-3-Adithya.Balakumar@toshiba-tsip.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <20251021125233.1528087-3-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::8) To GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR10MB6005:EE_|AS2PR10MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8305fc-978a-436b-9834-08de10a2617a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z2dJNTdDajdRSitURS9ieXd3U2VlNFdwenVTZTZ1UEJDR2wzR1cyV1FKcFV0?=
 =?utf-8?B?Vy9qNGpIUlpmcHhibVF1bmhqVDQ4UDVMT1EyRzRnNmp0UjdjZXZsYzN1Q0Vv?=
 =?utf-8?B?ZEF1N2o1OWZGcGxRMngxK0JYZ1c1K2JxSTFUcjA4SUxBaFVUbk0yZ3YxVVo2?=
 =?utf-8?B?V0RGalA1eVAyVlNLaCtLTDlUL2xZYkwybmZLNG1FbGRwRWV1RzJUcnh5OUFV?=
 =?utf-8?B?bjNTOGZueFJkcCtEcjdkZERWenJVc2tteUdsdWFtd1E5TkZzR1dXdWJXNFMv?=
 =?utf-8?B?NHZmYWI1a3FFcDhRQlJvdGQrNzZWY0NwTk5iWVI1cTY4b3pILys5M2ZWRFZu?=
 =?utf-8?B?bTFyV3UrdFphWDMvUk8rdUg3R3ZDdE1iQ0E0Nlh3eUVLU0FEMGhTeDlOaExH?=
 =?utf-8?B?V3ZNNmJaeDZCaExRT1B4RFJuQStOZkhiZmxERHhKRzBVOThIaXV2bXNLTTI5?=
 =?utf-8?B?NVY0WU0zczUvL0l3S21jeDBiQUFSV1JMMGJpck4rc2JKbUdMNFZzcS9HdkJB?=
 =?utf-8?B?SkNrVkdKRHQ2M3JEM3ZUWWtoc2IxQkY4WWRBMzZ6R25xQVYxMlQzeFhZV1ZK?=
 =?utf-8?B?ZFVpcExTdGVPV0F4VGpacUZwVkMwcnEzUllja2JuMUlPMzZrMUVOVGM2SnpP?=
 =?utf-8?B?a0Q5VE1IQnpOQ1lqMkJ2cDEybVcrdjFYUGpTZGhCMzZrUkdyOEJXa2NndjIx?=
 =?utf-8?B?VS9lOUViRktYV0RrMmdpQURObjhLNjVJdUpJZm92dkd1NzB0akk0ZHZNc0Nn?=
 =?utf-8?B?WDROenNQaUNpVURuWHRwdlAreGtwRUwwOWFqWFlGY0VEd3A0eFZlbExZUlhQ?=
 =?utf-8?B?VVljWnJqUHZKNnZCdVp5WWRrNkE0a3VLR2d6TmtndngzRTU3MVBTOGNLRWZN?=
 =?utf-8?B?aERtT2RkZ3ZyQ3FoVmRKOHViVDdwSWhaaTBGTU4yczFYYnJrUWtFWkRjWExE?=
 =?utf-8?B?SzRmMVlmNEkra1NYek1pbFcxc1k5Nk9nZFl1VDBSYTh4dE8xYUpDcXFaZWg5?=
 =?utf-8?B?anRZUjVtMitJbXVaSFpFR1YrRDlGVHBaTTloQkdVZFpUZUVZT2Ixa3htd1hi?=
 =?utf-8?B?NTRmdlgxS0NBckxRd2tGenhyR1pZV1dNSEZjdGxHRnRGT2QzTFhkaldGR2w3?=
 =?utf-8?B?Ryt4UVNnOUE4d2pEenhMRE5BQVRyNEdNa3JjdjJtbG5saDg1dndmWkp2bmI3?=
 =?utf-8?B?ckx5N2Y0TzBNbGwvdVpjbVJuek9IMStkWnNaRlQ5SGt2djlrUVBzU1RGMzF6?=
 =?utf-8?B?eEd2QkJ6MHFETURyUWRaNnRDOW5JMXF1UStMWTBQYzN1b3I1RUxUVk9LU3o2?=
 =?utf-8?B?RUZjRlpOZnp0ZlRER0VjY1FuWDh3OTRrOVROR2ZIWW41b2JHQmZpUVpDMGNS?=
 =?utf-8?B?MXlGejUvNlczQ3paSWIrVlI2b3c0aVZHeHhzazdTN3VnaWEzdUZlanhmRi96?=
 =?utf-8?B?N3VMdk94dlZPUlhkR2IyQ2VoWENBWTVTUGlqajhOMzQwUTN4WU9RS3I5K28y?=
 =?utf-8?B?cjhCbXRIVzc0ZHZybjVybzVnSWVHWUovWTRmdFF6aWZEOXRYQmZOdU5kdjZo?=
 =?utf-8?B?L3FndWRYRkk0UnlGU254YXFSdnVMUm1tWHRXYk51MDFWY09qUW5pbUdFNUpZ?=
 =?utf-8?B?YXMrV1ZmNk1KY00zeXZKOURWekpjVVpUMWxiS003cnBaUmtjcnBiY0FSRDZP?=
 =?utf-8?B?UFlwNWViL1pva3ZIYzBLdFJTVUdtUDJVbDNYVjlvQjI1b0RtODV1MEtnNVE3?=
 =?utf-8?B?TjljNUd3WGdzTDAxRUM5WFBMcUhZY0E5dU9UeHE1Njlkd0dNVktnKzlBc3JE?=
 =?utf-8?B?THVsUU9BVzZrUFBJdmw2QVJNQUhYNlhEdlEzWHBiVElqR21rWE5WUjF2aEJ5?=
 =?utf-8?B?Q0FlQldqbnZ2WWt1V1N1clVpazBzbmhrME5Ya293WFZkM0E9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MkJKTXAyWnl5am8vdGVoOXRwck5KVFFxMmhFQVZTNDFiOVE2QUsySjZpYmU2?=
 =?utf-8?B?d1AwN2xTcUpTMVBxdGhyZ3lZbHF3bGtzN3hiNk5ab3lobnpIeVR2SkVoK1VR?=
 =?utf-8?B?d2xESHloa2ZyNXNzbVNrRW5qQWZ0aU9rS0J6SXd1NzZkTXdhQm1GRVJ5MDVB?=
 =?utf-8?B?SHkvUWVJcnR3YnNlZEo1NnIzNVhVTzl5WGZHZ1VVdEphYjBGL3l0eDJ2aklE?=
 =?utf-8?B?ZW55L0d0cFVETFl0dFA3S1RkRjlBdXU4cFI1YnBxbE5KbmNmbElTMEd4SHF4?=
 =?utf-8?B?Q20vL2dXWnd4SUc0QUFMT3FpT3dLQUsyTm1iWjlqcUttUVpGMkRVTW05cWla?=
 =?utf-8?B?QkhRR21SbGcwVFZWSFMxelpiU0pUcGVVUDFkUDlVSDJXNmtlN1pZMUVOS2cv?=
 =?utf-8?B?NjExRVpsa3g3U2hsYzU0V2dpNEwyTlZIekIwVUJRaE12M1hoSVVHUnhOSmZk?=
 =?utf-8?B?eHBwK0xsSjgxYkdkc1JnTHpzSFl1dUZyWEZqa3hXWktiek1CWTI4cVh1OUVq?=
 =?utf-8?B?RUVCZmExMWRST2Q1TmhMSStTdEtGalRYMmYyLzdkQXJOeUpYQlBIcDh5YzVK?=
 =?utf-8?B?VFlZVnZGVkcxTTFaam9Ic2U2MWgxbmRidXVBemh2aURrc1dSVXZPUFdma20v?=
 =?utf-8?B?K1dXdTlEUHNoMUJ2QWVaMnV5eUxhY0tsY2ZnYVdSTTl4SEFZN3l4T2RkOUVN?=
 =?utf-8?B?T3A0bFZUam9hMFJ1N09lYW1EY3FDQ2J3SE5YeC93bjhuR2s5RDZsVHI5RWN4?=
 =?utf-8?B?dTIrc2N2cFJKZWFyNTZGRW4yRVNkK09jbWVnUVpFcDNjT3ZhalVNVkxuWjVw?=
 =?utf-8?B?T3B0MWVrVlExaEhJdlhzbVZPV2dvb1BQTnl2dDFFcmF6N3grRnU5ZTdaRUI4?=
 =?utf-8?B?YVliM2RpeCtOaEtlRFg4REtYcTgyYnRHL1VpYVVKeWNYSGtjbXd5YXhYcU1i?=
 =?utf-8?B?b0QvN3RxLy9uMWNzWmxXbXBzcE1iTUkwR3ZjQnJZRjhwUTRyK2FKYmpjRGxI?=
 =?utf-8?B?SnR6RUhUQXFPb0gvbkw0eklRTGR0THlTQUVDUW5XYWx6TDBhVSs2aUthNHli?=
 =?utf-8?B?MkVMdDc3UjF5WFBFQ0hWalFjL3NIQnBIWG5sZlp5WkNKWnlOV0l4ZnJucW1j?=
 =?utf-8?B?Mzc3V0RYSHFGS0E3d2ptd3NjUmdoai96OFUwTTI1ZGpIOGNlTzFWNVdUN3Fa?=
 =?utf-8?B?cG55WXdwMnl2Z3RvYjRBT0JGZzRDTVZOUlIrRVk3Q25Rb1dveEZPZXQ5aWEr?=
 =?utf-8?B?K2MrdGRuVkVFdTQxRkJkZVViMlBmNVYzZWpCZVFxRHZuUUVETW8ydG5YYVpV?=
 =?utf-8?B?TFBMNThlVWV6WUl5NUtjdHYyVXVWL00xNEZoY3BXMklCZkVyd09hYkdKNXhp?=
 =?utf-8?B?Yy82ZzNVRUhwdGxEUTFWNlRxQS9IN0pLL1p6NWpPSU9Cbmh2RW1mNTFCenRl?=
 =?utf-8?B?RzI5QlBkTXRkWlVaQ0VuaXZ1QXFJZGVmUTN1VmV6TjJSYlVBM2RGTllQdEpI?=
 =?utf-8?B?Q05lK0liRlRIdFlkYkN2aUNPY2RZZXAveUtHdmtDY0dZOWFHK3ZoOUM3aXZ3?=
 =?utf-8?B?dXRLUkg3cFlnWFBoc3RsTC9pVTF4ZHBxVG1pclZZdnRMYWN0V0F0SGo4eGxR?=
 =?utf-8?B?SlN0ck9XVndpV0NtdFFqSjN0MU9yYVVHVXVONXVPVEt1ZE5SWUdJcWY1NFBa?=
 =?utf-8?B?bFNRL0NNL2ZnMUlsYktBam1GazYzdFVEK2FTWnVHck1NMzJNZE95L0JxamhF?=
 =?utf-8?B?U2xWUHJ0Mmlmb0RpRUptSXVhMnEvMWxqT2g1NUtSWXgxcWtaSTdsOTZOY2do?=
 =?utf-8?B?Yy9FMWJTcHB2cG9DNXU3cjZhc2tXN0J6NElOSnYrMGdOeHN2N3ZzdjNNWHhC?=
 =?utf-8?B?cEFrUzNzUVdRbGZXVkZZRFZtaDFycDVsNWdVMnJKZ1NjSHVuVmlTRzMyYzNG?=
 =?utf-8?B?dGJ1aDErbE10VHJ2cVU2TWJTdFBQVUVkaWZUcnAxc0prZXpsVS9EUkk0aHN0?=
 =?utf-8?B?MEpMd2t6SVVTY2xzRU84TWNnZW9pTS8rZFlmM2t2NWpnT20rL1BHOUVGYkJi?=
 =?utf-8?B?citqelczbTFucUg5c0M4SDFjVitROWlENTVmaCtJTlhBVDRZbE1QOEc2ZkE5?=
 =?utf-8?B?VmltRkZUM20xSXluTTE3L3FNNE5DTVZrN0x3dUcxUXFvUWV3cEZyM0dkZEZl?=
 =?utf-8?Q?oQ+WcPAPyyvrCXbuFxh8Il4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8305fc-978a-436b-9834-08de10a2617a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 13:04:34.1249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRuOgSKtzROisoyMWoU/zo2rROUHhXh/jn+nOuIfEl6svoxnxWk2IUjlS8TwmUgryWssspzJWwSHfBnpLsaEjQdSKX940tf/6+YH2NR5o28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7251
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Oct 2025 13:04:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20209



On 10/21/25 14:40, Adithya Balakumar wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> wfx requires options to be set via the suricatta section of swupdate.cfg,
> let's add a suricatta section to the swupdate.cfg file and also an
> additional suricatta arguments file to allow swupdate to start in
> suricatta daemon mode at boot time.
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>   recipes-core/swupdate-config/files/suricatta         |  1 +
>   .../files/{swupdate.cfg => swupdate.cfg.tmpl}        |  7 +++++++
>   recipes-core/swupdate-config/swupdate-config_0.2.bb  | 12 ++++++++++--
>   3 files changed, 18 insertions(+), 2 deletions(-)
>   create mode 100644 recipes-core/swupdate-config/files/suricatta
>   rename recipes-core/swupdate-config/files/{swupdate.cfg => swupdate.cfg.tmpl} (55%)
> 
> diff --git a/recipes-core/swupdate-config/files/suricatta b/recipes-core/swupdate-config/files/suricatta
> new file mode 100644
> index 0000000..1dbdd5a
> --- /dev/null
> +++ b/recipes-core/swupdate-config/files/suricatta
Why was this empty file added?> @@ -0,0 +1 @@
> +SWUPDATE_SURICATTA_ARGS="-S lua"
> \ No newline at end of file
> diff --git a/recipes-core/swupdate-config/files/swupdate.cfg b/recipes-core/swupdate-config/files/swupdate.cfg.tmpl
> similarity index 55%
> rename from recipes-core/swupdate-config/files/swupdate.cfg
> rename to recipes-core/swupdate-config/files/swupdate.cfg.tmpl
> index 3e2b45c..8a60f4b 100644
> --- a/recipes-core/swupdate-config/files/swupdate.cfg
> +++ b/recipes-core/swupdate-config/files/swupdate.cfg.tmpl
> @@ -3,3 +3,10 @@ globals :
>       bootloader = "ebg";
>       public-key-file = "/usr/share/swupdate-signing/swupdate-sign.crt"
>   };
> +
> +suricatta :
> +{
> +    id = "__DEVICE_ID__";
> +    url = "${WFX_URL}";
> +    polldelay = 20;
> +};

This section should be optional appended if somebody is not using wfx.

Quirin> diff --git a/recipes-core/swupdate-config/swupdate-config_0.2.bb 
b/recipes-core/swupdate-config/swupdate-config_0.2.bb
> index 63fa320..218174a 100644
> --- a/recipes-core/swupdate-config/swupdate-config_0.2.bb
> +++ b/recipes-core/swupdate-config/swupdate-config_0.2.bb
> @@ -16,12 +16,14 @@ DEBIAN_PROVIDES := "${PN}"
>   
>   PN .= "-${MACHINE}"
>   
> -SRC_URI = "file://swupdate.cfg \
> +SRC_URI = "file://swupdate.cfg.tmpl \
>              file://hwrevision.tmpl"
> +SRC_URI:append:wfx = " file://suricatta"
>   
>   MACHINE_HW_VERSION ??= "cip-core-1.0"
> -TEMPLATE_FILES += "hwrevision.tmpl"
> +TEMPLATE_FILES += "hwrevision.tmpl swupdate.cfg.tmpl"
>   TEMPLATE_VARS += "MACHINE MACHINE_HW_VERSION"
> +TEMPLATE_VARS:append:wfx = " WFX_URL"
>   
>   do_install[cleandirs] = "${D}/etc/"
>   do_install() {
> @@ -30,3 +32,9 @@ do_install() {
>           install -v -m 644 "${WORKDIR}"/hwrevision "${D}"/etc/
>       fi
>   }
> +
> +do_install:append:wfx () {
> +    # start swupdate service in suricatta mode
> +    install -d ${D}/etc/swupdate/conf.d
> +    install -m 0644 ${WORKDIR}/suricatta ${D}/etc/swupdate/conf.d
> +}
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#20204): https://lists.cip-project.org/g/cip-dev/message/20204
> Mute This Topic: https://lists.cip-project.org/mt/115872047/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 



