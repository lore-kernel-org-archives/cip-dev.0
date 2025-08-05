Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EC5C87FCB
	for <webhook@archiver.kernel.org>; Tue,  5 Aug 2025 10:34:55 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.67])
 by mx.groups.io with SMTP id smtpd.web10.18812.1754390093342255502
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 03:34:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WhsviICk;
 spf=pass (domain: siemens.com, ip: 52.101.84.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyRCUzS4aBd7Et/C6cyw5FkuhtBtcuk14D5R25Ueg8ehVaSy/cC9S9KlMKFn00W63vKGQi5U9Ire8sknQ7VvWlojqNh6ZD9BJ+ks12cTnuuXr+BNfwZfG0fAIk77/CvmpZaf79thKwrtPon6e2dpuwkmnSJIeh+1wqv1v/lGy1ry9dlsrp9jnhp1VcWK4M3rVbFXYlNmgeQ+PfZmQJFG0pw9mOKpgJOUhArJ8vobIGGJ+yFucuq4E8dFaEu7JipFPWxfVyFhh7b76bWf4O/HgtELmcG3EdH3uVTCi/U0ZUkk3FYFXV7nrD0YoKmz/KvmbecEBtaxM2uXiy51VKDnYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xrn2EuG+TS8tCYbmR/u0lUDVz1nawJ/T3TH7B8fKNL8=;
 b=F0nb/J+1Fuq4Z1/S0NdqG1G5rIhmvjwclPubEUhiCDkYGA64GRoeU6F8wEcWd4fNdQu5iRqg57Jxf5XwHDi4XhBkXSY28F3Uydl1uv900T9LfUVuOKcf8JVx6MxDGPZHQGRKXAfdBiEXfDXV5hKuhdJMfWPbdtV4oR3nK9yyZxnYfRGvN2y1KRn/oYwZOHLfSddt3xXV72DG50g64TZ3DpxQU01J+eGajjdHdnBCGXr9lGPwo2KYJjgx3bj5iZM/UKfSQnbrQHvDtge/Gkw8vRanvYoCqybllMne/MWuQcSd8wY65V6wuywPxpMDmbowtHisCMHmlIDU2GYQQZVdng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xrn2EuG+TS8tCYbmR/u0lUDVz1nawJ/T3TH7B8fKNL8=;
 b=WhsviICkDnyE17b5fwxFRvcfqjhCY4VAlRUtVqrwyGUCr2egZjYsoLi4o+cpHbykd2k5UiS/X+wGcGfvO0aYc4DpqpY1fX7nm/5WZSG0qLi6f0dSsIhsDyxI1I2VqQOe5/aXTXnEDlmr1RSRtG41y8gY+jn/kjSg6M/zmY9qsbQ26/WpFzIb1wOrZFrER1c9JEg0VpQSxdinNYuAjtKpcFAneHPAM6mwxf3wzfZV7JZ/WUZh5GjiFIS4FCmn8E3lO53sSzbLMsTwb7UdZ7o99HrC2Pa9XlPpBpBfYFUpPUKKO1DosWNHK1L5/49EtZmwEzwKeIKGA3GW3IwLTmYhNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8099.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 10:34:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 10:34:49 +0000
Message-ID: <62cc4558-57f9-45ab-ac1f-0c3cbed9296a@siemens.com>
Date: Tue, 5 Aug 2025 12:34:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 3/4] ti-am62px-sk: Add support for
 secureboot
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20250722101551.1727649-1-s-adivi@ti.com>
 <20250722101551.1727649-4-s-adivi@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250722101551.1727649-4-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:610:5b::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 121b0327-cc16-4d28-be00-08ddd40bb475
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?alRqTUlhYzIvTDN0bkNkSkJuVEdvNlp5OFZQWm01SW9KL2p2OEdrT0RSN2JW?=
 =?utf-8?B?UGJyQlRETGE0VjRxWHBib2k4NVVRV283c3dKeDFqWmpVb0REM0FxSDRSRTBV?=
 =?utf-8?B?bjA2RENZSzN3cEkvZjU5QzdrNmt2b3NiQjVLNjhvSVBRRTl1ZXB6YzRnZFg2?=
 =?utf-8?B?Szhxb25IS1hUQUh3V0pIeXBjSmxWRmg0TWtPbUdNdnMxWi9JQ0JJY29iUDFS?=
 =?utf-8?B?TExQa3l2bDRXQ3dRQUx6dHZZNVVWb1BSblBCNXJEcmsvQisvNmtBQlJvamFx?=
 =?utf-8?B?OGZtNEZ5R3Qzc3hwSlRCUTBEQjZ4S2Y5SFRJbUdUeUd2MnFDM05hZjAzbmpw?=
 =?utf-8?B?Nmgzdm5qRkVuNnRSOThObFRGWGhDNzl5b21qcm5DRDYxbm83akRmNlY5WjZD?=
 =?utf-8?B?U0NGTk4wMWtxRjcvenU5OUVKNUdrVkVEL0tEd0JEUkN1WTBhNHFiYnNMRVJ4?=
 =?utf-8?B?bXVpQTg0cFJaRGVHRjFIOEpvVWNLVFZWZHN1dW5kU0U0aG9GSzVGSjZ3WXM5?=
 =?utf-8?B?cG9uMUowRk1aNkM2SG1vTjJZeVA0b0xBSldmd3F3dU0xS3RDQ2RsMC9XMXhO?=
 =?utf-8?B?NzJNeUVoQjFHTjE2UGtCNEx2LytaNFkyUmVuNEtRam1mUGsxcmpWSEhyWUsv?=
 =?utf-8?B?amVxZzM3R0NQa01zOC9vOWNUcHhDS3EvWW5DQUFlSzQ2RTcxQ1FoODFQT3NJ?=
 =?utf-8?B?NGMxOWJ1N0RzejlBNEJiQllHOXUrM3lDMW1JTDVKOTdPTjNNVTNhcUpGYmtY?=
 =?utf-8?B?b1RYSnBnR2RaVXlxT0lFOXNGNUZJcldnTXJINXZtZFBhTG5jRXJsU3lGRE9X?=
 =?utf-8?B?S201OTB3VFNCaGl3eHNqbisvRU9wWTJOZWF3ZlZPbndSL2tpUUw2M1hOTWY4?=
 =?utf-8?B?RXJqd0dPSWZGUnBVMjdrNUhpVWRUMkxIM253ajN3WGc1bE9qblNldllYT1FY?=
 =?utf-8?B?d0RNYzdMelMzOW9ld0VuRkxsY1h1LzF2VFZmbUR6ekpMeG85QWZKbnBwQk1K?=
 =?utf-8?B?K3kwWENrVk5rK1RYNjZJWlJ3c1RaQ3ZaNGVDbWNlZUtVMXRWZXhuU2twWExy?=
 =?utf-8?B?ZUpGenA2d3dhdjJDWWNUNnVHUVVKSytGVzlGaHM0VFZ0MW5ROGdrOVB6NTdz?=
 =?utf-8?B?d1dwYUJSZTdSbFRucjRHdUlUaXlVRkNUeWt4Y05yalM3Zk53SEl6VEhyQXVE?=
 =?utf-8?B?WTFtTVdLbkJIU0dtUWFLS1dCa1pQeVpobldXaDlYYTN0WU5FYTRhaUtqSmw1?=
 =?utf-8?B?MlJwSkZZd1dpVm54TTV1Z2YrdDE5RDk0SFF1QjM5NnBEb3dpakVYVTBVZGcw?=
 =?utf-8?B?SlRoVjZMMUZHMnVyY01iYXBTZlNMNGl6Um1qV0xkY0czd3NLOG1Cdk12OE5p?=
 =?utf-8?B?OFhYSXZCMmtOSjFUQXF4SVQrYnJMekFzNEpPNTNPUDM5bnB2TzI1dDZNak9W?=
 =?utf-8?B?U2tvaVFqRWE3VXVGbk9YZzRqTUN5OGpOblpuSUl6S0JZYVpRRFlocHZaZlA5?=
 =?utf-8?B?ZFVRZlZBQXordEtJREtlNnNJTmFkeUZQYmVGTmdrQXJpc1Q1cU8zYnMzS1dj?=
 =?utf-8?B?Q01aWmxQV09nRzFHQ1daTjkvU0tSaStJWEk0bmlydFk1Njk4eUx0MnBHVEJm?=
 =?utf-8?B?dVk1dlFQZlpBeWcwWGhKaWZzZjFNaWhmM2VEODFFSk9BNjRXRXJWSVo0ZGFB?=
 =?utf-8?B?a29vckM4Wm5qaFg3cEtpaUZrUmhpU012WGh5TnpGL3ZpdE82aiszOWVpME82?=
 =?utf-8?B?bnZGR09VZWR4VnZMRzVoMXdkc1FjdXJBQ0hZdkFLMHBraEVCYWJUWGhlVWYr?=
 =?utf-8?B?aHdQWG91bnVBRFNFM2c1K0YzbXhoZy9JbTJ6QXc0RGd2OE1GdVBiM01vclN5?=
 =?utf-8?B?SzBnRit4Nkcvb05xTEQ0Y2k5WEEremw0RHJnVWZ0emliRUE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RzEwTzBpdDgvZmFJVHJiVzdiSktEb1lkT2I1c21MVFN1bDgrZGJycHZIN3dS?=
 =?utf-8?B?WVlaTmlQeURoTmxlZEYreG1KZzEySE8zMmVxRXdHSEhseG9Ha1BHY2ZHZG0z?=
 =?utf-8?B?eHZrT0JXOWZMM2lVNzhsM3FJQTFleVRYSU0wVlNTbzdjSzFqWWhBaWVqdlNY?=
 =?utf-8?B?TUwyNm50MVhBbGxFVzJRZUNWZGhDc0hpU0xhSTErVytheENZTUlrK1plQjg1?=
 =?utf-8?B?UisvM3JIV1BDOWJxVEdKVVFiYWhFRWpxbmo1Qm04Rmpick10QUE3a3FySjFK?=
 =?utf-8?B?OVlnNVdaS0hMaDR5L2R0cjVreUxGTS8yU2xva2ZMRGlxYmZSWHRRQWk2V1li?=
 =?utf-8?B?YjBnZkZ6ZG1pMEhxMmxqbVhjSGpEQ0ZSUEdDbCtHYzBXNThwM3lQVkJieC93?=
 =?utf-8?B?TG0yc1hlSHRKd3MzSmsxaUdmZG5EYWZMSURrYVNyM01aMGRISzNvUU1XYUJR?=
 =?utf-8?B?UllLSUpkdHdoL0tVT1l4RVljd0h4RHg3bkRKTndzSWwvbFkwakczUW1CYldp?=
 =?utf-8?B?OGlaZ3dQR1NBeWlPNGdrc3lvOUxaQmhRSk5VK3BwdmxTQUg2ZGI3MzhIZ2g2?=
 =?utf-8?B?aVp6THc4cE9xQWVLMytjT0FPU2xmV1FmYUl3YWNqN0tkc0NWYU91WVJuL3M0?=
 =?utf-8?B?ZXZEOWhkYlR0cStxRk9jSksyVVRFS3FtVklCcTFKdWhvRHVuaUZGUExPREVH?=
 =?utf-8?B?Vm0zVTdMNEJ5VSt2MHhEL29BdlJHbzNaNVV3NjVXMlFYYVNiSWhEazB3bVlv?=
 =?utf-8?B?cU43MkJ1WTI1QWFaYmlmdTF3ZmJQeTJ4RmdQbWV2SGhQS0tVUzB5VnB5TmlM?=
 =?utf-8?B?UHdETU1iSStNTlBhMDJlOXU3Ujl2VW5OdGdkZklUM3dTZjJIOE9VeU1zOUcx?=
 =?utf-8?B?NHF6NEFFVWZQRFBYZDRieFZJZmU0TU9zQjVhTXAwOFdzYS91WEhXemE3YWZ2?=
 =?utf-8?B?VzI3Wm9SR2tRQkJXQ3doM1g4UlcvR0ZVejR6cU85Q0loc2sxRHUrUGdEZ3J0?=
 =?utf-8?B?REJVY2lRVUdXR05vM3pUV3BVckVudC9NK0RlY3ZrOFJpS1NKQ0JqaTNHTDh4?=
 =?utf-8?B?dWxwU29lYmZ3Qys2WWxMeC9SVWRFSFVoRWFtaDRWT3E3MlNGdDVNdHRsMHNU?=
 =?utf-8?B?RUt4YnVEdGYxeTIrRjRZU1pEVUI2N1VvMjBjTVVuR1pKYlh1a2kxc1FVdkd4?=
 =?utf-8?B?c0VWbE5BN1p2TW5QcTg2cFhCVlQ3WElncUJIZklEUTRUL2dMYTcxQzFGKzVQ?=
 =?utf-8?B?MTZId2FicE5xOUV3WmQ0ZG5EbTJsQW1LeFVCV3BGbFdtV3pjTjh2TWo1S3Rl?=
 =?utf-8?B?Q3VZMVF0emJNNHNCU0lkMjR4OERTL21FWWJ6VDRrL2RpZzRNSi9lSDBmWFVl?=
 =?utf-8?B?TE5pWHlleUg5Z2RySUpvZE1PZjJGM2xnem5qbjdyUmtFUjBITWgvWTVGZmxo?=
 =?utf-8?B?anFKQjJWdmMvellUZWhoam4yOThFQ1dtdVdhZE5RVSsrYy9qRVY4cXFKTWpE?=
 =?utf-8?B?ekp2R29EbnNmeGM0WmpEOExuOHFyemphb2J5WnBWTFY4ZTlQM3lJMldydlZp?=
 =?utf-8?B?WlRzMUw4RXd3Q3hGcnRKVzNFS2pVUVUwS3RTN1FoOGRQNDRncnFoY21NY1Jh?=
 =?utf-8?B?TFVyY05Dc1lNbEw4NjVHNDlYY21EYk94VzdFUnNkaFRpQlUrbHVOWnBmYUcx?=
 =?utf-8?B?UGlKQzlhMG1sdldFcDF4NFFoUS95OG1rTWdpSVo3ZTRKc1VCV0JkSWtURHZW?=
 =?utf-8?B?aCtDT3BtTndVQXR5b3EyOUc1RWpPRHY2T012aGtMSzlJNDd4MHUzcTBIVzhi?=
 =?utf-8?B?UTIzNHVYZ0Mrek1KRmZjZElOSVI2Z2xlR3pYQzVmVGhiS2pUYnA1eFh2aGlL?=
 =?utf-8?B?U3JqaExNaWU4a3ZLaExNQW1WUXF4dzREZFRJdTk2c3ZVRnlmdkt2WFU0UjRZ?=
 =?utf-8?B?MjdmL0tIM3k4d2dXWEM2aU54ODgzM1psNXgwd0UzcTN0QU82RUl3WG8rYktH?=
 =?utf-8?B?Y3E3SVZBSXN6TVlpZDF5SFd6Y0hpSFArK1Vjbk9HTVpLeHVhbHoyTzNnbU5D?=
 =?utf-8?B?aWZEcEVyVlB4OERlS1BhRUkvbFFSaWNJOU1rSThlZGpycWY2b0RuL0MvT2h6?=
 =?utf-8?B?ajQ2UzcrdGRzdWN1bnB0SkRBaUVFWjhEN2ZuSTBFOTNydFdsVHF0MFZMTGwr?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121b0327-cc16-4d28-be00-08ddd40bb475
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 10:34:49.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqqq3klw0PCBFA1aZtOioAb2r+MJ72lr+1DI2HUYVq0n5/btHMfpSjgSfeOAwIe4fNzA/aClo/8H+rOE7nhmdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8099
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Aug 2025 10:34:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19670

On 22.07.25 12:15, Sai Sree Kartheek Adivi wrote:
> - Update u-boot rules to prepare secureboot vars
> - Add new wks file for use with secureboot
> - Update Kconfig file to enable secureboot for TI AM62Px SK
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  Kconfig                                       |  2 +-
>  recipes-bsp/u-boot/files/rules-ti-am62px-sk   | 16 ++++++++++++++++
>  ...i-am62px-sk-efibootguard-secureboot.wks.in | 19 +++++++++++++++++++
>  3 files changed, 36 insertions(+), 1 deletion(-)
>  create mode 100644 wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> 
> diff --git a/Kconfig b/Kconfig
> index 07111e3..68c4309 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -247,7 +247,7 @@ config KAS_INCLUDE_EROFS
>  
>  config IMAGE_SECURE_BOOT
>  	bool "Secure boot support"
> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
> +	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI || TARGET_TI_AM62PX_SK

As this list nicely gets longer, we likely want to introduce
HAS_SECURE_BOOT or so now. Same for patch 4 and encryption.

Jan

>  
>  config KAS_INCLUDE_SWUPDATE_SECBOOT
>  	string
> diff --git a/recipes-bsp/u-boot/files/rules-ti-am62px-sk b/recipes-bsp/u-boot/files/rules-ti-am62px-sk
> index dc53b07..ab8b813 100644
> --- a/recipes-bsp/u-boot/files/rules-ti-am62px-sk
> +++ b/recipes-bsp/u-boot/files/rules-ti-am62px-sk
> @@ -12,6 +12,22 @@ SET_CROSS_BUILD_TOOLS=CROSS_BUILD_TOOLS=y
>  endif
>  
>  override_dh_auto_build:
> +	if [ -e /usr/share/secure-boot-secrets/secure-boot.pem ]; then \
> +		openssl x509 -in /usr/share/secure-boot-secrets/secure-boot.pem -out secure-boot.der -outform der; \
> +		rm -f secure-boot.esl; \
> +		\
> +		if [ -x /usr/bin/efisecdb ]; then \
> +			efisecdb -g 32db313c-f7d4-42a6-9a49-e32870001c63 -a -c secure-boot.der -o secure-boot.esl; \
> +		else \
> +			efisiglist -a -c secure-boot.der -o secure-boot.esl; \
> +		fi; \
> +		\
> +		rm -f ubootefi.var; \
> +		tools/efivar.py set -i ubootefi.var -n PK -d secure-boot.esl -t file; \
> +		tools/efivar.py set -i ubootefi.var -n KEK -d secure-boot.esl -t file; \
> +		tools/efivar.py set -i ubootefi.var -n db -d secure-boot.esl -t file; \
> +	fi
> +
>  	$(MAKE) $(PARALLEL_MAKE) ARCH=arm am62px_evm_r5_defconfig
>  	$(MAKE) $(PARALLEL_MAKE) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
>  
> diff --git a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> new file mode 100644
> index 0000000..29373de
> --- /dev/null
> +++ b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> @@ -0,0 +1,19 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# SPDX-License-Identifier: MIT
> +
> +# Boot partition containing Bootloader binaries
> +part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
> +
> +include ebg-signed-sysparts.inc
> +
> +# ABROOTFS partitions
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
> +
> +# var and optional home are extra partitions
> +part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
> +${WIC_HOME_PARTITION}
> +
> +bootloader --ptable gpt --source hybrid-boot --timeout=0 --append "rootwait rw console=ttyS2,115200n8"

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

