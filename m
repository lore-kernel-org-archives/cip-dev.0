Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE891C27C53
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 15:28:01 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.78])
 by mx.groups.io with SMTP id smtpd.web11.45262.1717774074424606587
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 08:27:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=h4eGIA3U;
 spf=pass (domain: siemens.com, ip: 40.107.15.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5kEY81olq5tMU+D15XPkrbwCpWHGi0hwJbHboNDDHc79eSeOw7xoTWvBHRY0ve65100tZGqr1y6RBE5iDHTnx8Z8RCDqDedwMnQWcRa+6pXeT9VyhlPKaPwJAKUmPMG4RQPA8CFrK3fkKiIUYPiXh0kJc1DM+65BNMi0B5ZexyUMDjkww+D4TuP3zB5DJwywDF0J1N2/AtWCGUej/xW6K5OnEhGInyz/HO6Z1gXBzXCa99PBnEg4Wtg906u6mlrY2OpoohrnuenSvN5CN0rUq2OgKkL+BlLhkdYL6ZOzxPweI88bYas3ioJrYNJuV5+u4wn/UafcuvrfruEMcNaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGkuuMPBja3C0F/E6gmAWgBhoiNIjFggOJFlUlYO6sI=;
 b=A8EEfohnXnMkxxg97aKfBqwPbAv0TDsUI+ycXJF/1Lx5yDsZWrKw+tnyLWsRvnvSjKNcEmOuDPw0qDulmifMk1kWZQoC1l3EjZXkVi0QZwlHnSQ9il8w2aBG0JaVIw2GrYJTzJqFMro2jpocG/7NUY5pDIJXD1q3CfcQbUOPIo0+gWjTH0DvPgz3BoEfov35p2UkG6CJJ9DHPMbUStwbKwuvh5ZSmtIxWAwCpUArlZIvYfBKo8WUh/6H+uPyeDb4U9q64EfW46lnJzAi1EyNrELlu/k+hQ848fVSsSSuJk8FHm+6Lsf7uTzChmJvMLmc6b/lwJn9Oq7Cj/1xUYQRKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGkuuMPBja3C0F/E6gmAWgBhoiNIjFggOJFlUlYO6sI=;
 b=h4eGIA3UTQ62w/VUv+zVYzKiWp7LPjjuBZU2PBm5JRzU2oQfAZtL+Tyile3w9OowcscTsbyyEN/JGpVktQUzYyd8crejsuNwHrrsEIO5YD2+gDxS84HoimX+YxeVyl/DfZylYeUtSv663en3F02L86QQ+Qvmk8Am4aWB2oyAiViS4bT/SuaFEfVQo6yj1XOVSDr96gAdPnnXUXhhejmmK6E8+i4s5TSWqKfLse+K9I0GpH2lJSSLCeZ3E0o4E6U/sVbvvnTAaWKKrmmLq+ixh70/WgHrzBRd0rqHcOjZE9I9LvOARBUJWAx+xBzel0rrIQyly62RKof4K5yRe8gFAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 15:27:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 15:27:50 +0000
Message-ID: <5327056e-3280-4961-a562-3311605c254b@siemens.com>
Date: Fri, 7 Jun 2024 17:27:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v3 2/4] submit_lava.sh: Add script to submit the
 jobs prepared from templates
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240607095229.490871-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240607095229.490871-3-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240607095229.490871-3-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 527edbb0-a82e-4db3-0054-08dc87066481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QkdudDErZEFTV0k4bXJmdFhQMHFIZzQ5Slk2dlRkQmVjS1lEc05UZWFneGhz?=
 =?utf-8?B?U0RCc2N0WTlCc09VZU9JVGFiUjNETjNnTTdFYlNJaFp3K3JUTThrL2FYY0pq?=
 =?utf-8?B?M21GODJ5cFB4RzBPUFJlMlo1ZlpaS01yR256VldsVHFBdjUvVVlLZUxrVk1M?=
 =?utf-8?B?N0hjTnBDSVBZWEdvaFN1TjU4MlNXNk1hWG84VDVDcDVwa2VvK2toR25SNHdw?=
 =?utf-8?B?YmdVbEJlYzVQRGR5TEh1b05maGxxeml5U0xINWtVUWlVcXUwZWhYQWtDYm5C?=
 =?utf-8?B?eWk1Mlp0SVVGbExKcjVFcnh1ZGIvVEtNTWwyME41SnVzS2V3blZXSmhjU1dW?=
 =?utf-8?B?VkZMVGFoNXN6dDVYKzZXaEpGQkVjbHNobFNLWUo5bi9DYXVZTUptNi9MWnhU?=
 =?utf-8?B?eUlqeG50blcyelRBVlk1NHdYbTNpOXRRRnhQblRDTUFwWHl1UDNDRE5RZHN6?=
 =?utf-8?B?MHFYd1BRS3cwRzBQbURaa3Nieml5ZURMSHduRC9FN2JqbEF4TnJUWGFXVmZo?=
 =?utf-8?B?YWFFV2ZsU3F5L29wN3poUzc2djNMVE9TTmJHVzB2eEFDZ1ZqcmdCbE15TGVB?=
 =?utf-8?B?d2ZiamR4R0ZNVzdmMUtVWEtXSU9uU0JPVkk1R2E3eEQxemtYOG5zS0NnclJl?=
 =?utf-8?B?eEdodjR0OWZicSs0ZFJMZWt3MWxVMDNZa1c4MUQ0U1NEY01NS0tkK2hhbzVq?=
 =?utf-8?B?dnFsSWFzdnV2amhxVmdGNFFzUWpRR1Z0dkFXNHpkZEYyZnBoYVFZZGsyV3VZ?=
 =?utf-8?B?Z0RQZWlJVUlqeWlyaHpRTGVMN1Jnb21Db1JtQk16MUttb2VLWlk3S1VBaEpI?=
 =?utf-8?B?VHNIVHhhOWZic2VmOVpIWHdMVm92WXVoR2xrMUVrSVpZdHFEbXdLeTRYY1Vj?=
 =?utf-8?B?MEwveDZOU3VaZHNUVkQ2M0ovc1FMM3ZaWGh6V1A0b0F3T2l2enJhOEt1djJS?=
 =?utf-8?B?Y0FpREdLMnh1bm9nWVNlemxXcHVKWGVRWThEM1JJKzZnUndqZWRiM1pqeVJa?=
 =?utf-8?B?YmhidkV6WGJZS0VHRkNhK3ZYdDdVVEhwdmJoWk1nMzhQaEx3RW5xNURCNUZB?=
 =?utf-8?B?TlVJUTJGOGF0YkZqQUxjeExiZWdtU2lPd3N1OUNKaFc3dk4xN2t4Ymx1RUpv?=
 =?utf-8?B?UjlLWTNNWmQrZnIxOENuclVRZldHcWdiazhFU2VickF5OXhxKzMxd0FiTXFO?=
 =?utf-8?B?QlIyYlZ2Q3RQVFhBdTZkZXpPMDRCNEhQczM0WFBpQTdoQnRDNUtUMEpuK1pY?=
 =?utf-8?B?ZEEyTitCSUMrNkxuY0F5Nmk3dWU2NHF4VFRnS2MyQlJPazlrT3hoK0krRTJv?=
 =?utf-8?B?MU4zdEd5cGdXbTg4Y0swY3lCaUplOXFuTTRJbTdEWGNxbHo2blBOUVd5TVRP?=
 =?utf-8?B?QU1BZEtHaW1FclEyZXYvVm45YnlnMy85ckhQaFhhQ1RzYVhwSERxVTlpUnJa?=
 =?utf-8?B?RlNKNEhZalU1L2h5N0VicEJWc3JjdnBScnBzNVQvQzN0NWVESEtnQlVwTDRw?=
 =?utf-8?B?WER5MnNIVEZraEFKVFptd3UxeFZWTG1pdUQ1V3BTZ0RwTllYMTF3T2hjOVhX?=
 =?utf-8?B?VTY1VVlHRjFxRXhITldnSUdraXQ4c1llZHFRNHJ5aG1WVTV3K21ZandseHpv?=
 =?utf-8?B?dW90WDFvcHY5MW52aDR1aUc1dk94RlZZdS9iM1FnS2EwcnVzNjNKL0swWDVW?=
 =?utf-8?Q?MSE1O0xdcSU8HcyCL8xb?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WEZQV2pGWStLSjdUV0hlekNoeHhJbW1SOHN2eTdEVlRUbzBsZUVTQlB1YXlB?=
 =?utf-8?B?N0sxR2xueGNpcG1FdWdGcUNScnVrNDVIdVRENEo4Uy9xWTdQc0ppeldzMnZv?=
 =?utf-8?B?dU1KT082OGx5U3N0dHg0Vm5vMnBPTkhvU3FZN0RpNFBCWU9EaVJvUFVxTmZm?=
 =?utf-8?B?UFM0aXhkWHRyMUdTQ1pNS2tEaTFudGNyUUt0VXo5NnRFVGhoTmtMSjI5cDd2?=
 =?utf-8?B?Y2N0QlhmNXlJNlhod2hEWVBmWUJydWhRaWNzak9mSVRrMjRuRk5Vb2JMT3Y2?=
 =?utf-8?B?M3ZzTzd2YUQ2RVA0SEZKTEhLUTJwOW13cFp4TkphQU12NjFNV0JWeWFQc2U2?=
 =?utf-8?B?L0xvN3N2c280Q3B4bnRJQ2plZkV4dmJScHhiVEZkTzZDc0V2UFhMbDBRUGU4?=
 =?utf-8?B?ZXpaR2FUY0dzRDNxS0UyTUJpSS80VW8yN3BlUERueXdNcWxxUEpXWGFOWWZZ?=
 =?utf-8?B?NklORWJyQkRiMk80M1gzeEVmRkZMYWZ1TkRwbzFCd0s4U2todkNzL0JFNXJZ?=
 =?utf-8?B?bGVORHViTExHTDZaWVJaSmlOV1Rnak96RnhUbHd4dXp5YUdXSkxuUnpSZFJU?=
 =?utf-8?B?emtaL3NNUHZ5aERPckhISHZmeUcxK2dMUlc3K3h0L1VrNGdHWkNHblg5cG1T?=
 =?utf-8?B?WXFxZGpHT0ZHY2pZenhGNkl0QkdWeU9PMmtjYmR4NnRYNE5Jbmt2ZXBQVnZF?=
 =?utf-8?B?amJsS3hDT1FxMFlTcmw1ZEJaSlNUbkQweUtWaUF3MjlrU3k3Z2NHWVhiaWQy?=
 =?utf-8?B?QlFkQWpZVDNxZE80azZacCs3YVJPSStUNW82bWJGdkxLMHFleXA0alVqSE9i?=
 =?utf-8?B?WFRyUFhqR2FoSkN5cEJJbUNrNzNEaGNhdFNXb21rNEpFVmF5MGFBMkhVWUlt?=
 =?utf-8?B?S01ncmkwVXlTQ2lqaGdWeWJHQmVIZzJPRWNETVRha2FJOTJkeUdQVkRrR2ZI?=
 =?utf-8?B?aDVvZlFocTZKT3lva3Bsc3RFcktNR0F4SUpLNUdoOTdZV2wzZTQrVmNjT2dq?=
 =?utf-8?B?QnVUbEwyWG5zTVZRSnliTnV6NXB0Nm5yM3U5S0lPT0l4UXpGdjIzTnh5ekFG?=
 =?utf-8?B?ZlJDSFR3WkFqNkVWcWxBTHdaVWEvSStueENPZk5KWWIzQ3ZQenNTNk9FQlJN?=
 =?utf-8?B?QVRtbU5uNlhzM0J2akhLdmxNRHVZTTJnRG5CKzBUWml0VTVWSVFLTU9IaVZC?=
 =?utf-8?B?cXZEYnI1WENoN1JESnhldDVPYk5qQlNIdjF6L2V0eVlBc0ZidFhxa0s0Qm1y?=
 =?utf-8?B?NXpRL00wYnpaU3p6Ui9PbE1tQzIzcGNhejlmNS93a3Y5ZjhkOEpTbXNWd01Y?=
 =?utf-8?B?RkUvUEswYmpXOWRGZGFLajlXUDFwRlBIb1dPdnRNQndpMm54Nm0rc2ZXbmdT?=
 =?utf-8?B?dVpBK2p4Yk1NMkRzMlUrVzFCRkxpVzRtR1lIYTNLbTJHMzNqaUQrMnduQlIy?=
 =?utf-8?B?MzZsdVAyMW0wdFAxeXUrc3BUcTJFNXNGcWRkSm0xQnJSRHBvNHFKRWVpcnEx?=
 =?utf-8?B?bURWSktMd1ovSjd3a05tTEQyMUVpbi9Vc3JKd081bEwwTmVJUGdsQ3ZOMm56?=
 =?utf-8?B?U283MFRUcnFpZ0R2OFVZRjBlbXN6ZVU2aVhLd2VTL3AvVDdGUFYrWGM4RTla?=
 =?utf-8?B?dWczUXUwdExlcGgvYWJMaVNjRDhCZUFISWlJK2ZDYndzRFU4RXEyRFoxR3ly?=
 =?utf-8?B?RW5TRzVMRFBJakJlRHpZVmxnU3kvWVVySklZZnVVOTEyeVhQa2FMdjY0MVU0?=
 =?utf-8?B?TktXSTcyV1BVdzQwRjZ6MmlJcTEvRlpWSHIvVEltMEF4Z0hvejRZVmNiY0Zi?=
 =?utf-8?B?K2dGRUxsUjdFMlVCeXpvOFZMdVJacDg4NGI2ZGRXZGI1MjNTRWZOMk5PcTBi?=
 =?utf-8?B?Q3FKWjc1YS82UFpGY2Q1NVE1YXE2TnptTGdMMENtYkdXTjh0ZlBxYU9JNzdH?=
 =?utf-8?B?SUdMOGd3dHpYYmhESTRtSUdpUWxUdStqWmJSNnFuNU1XeUhvR2dnWUE5T1pH?=
 =?utf-8?B?bXpPMXdjM25ubldtUkIyanFCVkpQaU1mWENWYjc3b1U0MUlHMmJwSVowWlVE?=
 =?utf-8?B?ZllBekRrVFRwZ0Y0anhXSFF1QnpkMHN1Y3JDbWZwT2FLemlZVXFHNTEvdEU2?=
 =?utf-8?B?STRjckNOUEFUMmdyTnhmN2VPU2xRSmtEMkp4ak13NlFXRmNqSDYrWXg1K1ht?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527edbb0-a82e-4db3-0054-08dc87066481
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 15:27:50.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knft39WaKA6AhkZc603JWThFKgVoVwRRteFgQoaiIr88m9FqiPNXQSpdAwWlcUupgDligos4qCQ4US6VfNHErg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7428
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 15:28:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16179

On 07.06.24 11:52, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> This script creates job definitions from the template files included in
> the test directory and shall submit these jobs to CIP LAVA platform. This
> script will wait until all the results of all the submitted jobs are obtained.
> 
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  scripts/submit_lava.sh | 464 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 464 insertions(+)
>  create mode 100755 scripts/submit_lava.sh
> 
> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
> new file mode 100755
> index 0000000..a22fba7
> --- /dev/null
> +++ b/scripts/submit_lava.sh
> @@ -0,0 +1,464 @@
> +#!/bin/bash
> +# Copyright (C) 2024, Renesas Electronics Europe GmbH
> +# Chris Paterson <chris.paterson2@renesas.com>
> +# Sai Ashrith <sai.sathujoda@toshiba-tsip.com>
> +################################################################################
> +
> +set -e
> +
> +################################################################################
> +LAVA_TEMPLATES="tests/templates"
> +LAVA_JOBS_URL="https://${CIP_LAVA_LAB_SERVER:-lava.ciplatform.org}/scheduler/job"
> +LAVA_API_URL="https://${CIP_LAVA_LAB_SERVER:-lava.ciplatform.org}/api/v0.2"
> +LAVACLI_ARGS="--uri https://$CIP_LAVA_LAB_USER:$CIP_LAVA_LAB_TOKEN@${CIP_LAVA_LAB_SERVER:-lava.ciplatform.org}/RPC2"
> +SQUAD_GROUP="cip-core"
> +SQUAD_WATCH_JOBS_URL="${CIP_SQUAD_URL}/api/watchjob"
> +SQUAD_LAVA_BACKEND="${CIP_SQUAD_LAVA_BACKEND:-cip}"
> +PROJECT_URL="https://s3.eu-central-1.amazonaws.com/download2.cip-project.org/cip-core"
> +
> +WORK_DIR=$(pwd)
> +RESULTS_DIR="$WORK_DIR/results"
> +ERROR=false
> +TEST=$1
> +COMMIT_REF=$2
> +RELEASE=$3
> +COMMIT_BRANCH=$4
> +
> +if [ -z "$SUBMIT_ONLY" ]; then SUBMIT_ONLY=false; fi
> +
> +# Create a dictionary to handle image arguments based on architecture
> +declare -A image_args
> +image_args[amd64]="-cpu qemu64 -machine q35,accel=tcg  -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
> +image_args[arm64]="-cpu cortex-a57 -machine virt -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
> +image_args[arm]="-cpu cortex-a15 -machine virt -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
> +
> +set_up (){
> +	echo "Installing dependencies to run this script..."
> +	sudo apt update && sudo apt install -y --no-install-recommends lavacli curl
> +	job_dir="$(mktemp -d)"
> +}
> +
> +clean_up () {
> +	rm -rf "$job_dir"
> +}
> +
> +# This method is called only for arm64 and arm targets while building job definitions
> +add_firmware_artifacts () {
> +	sed -i "s@#Firmware#@firmware:@g" "$2"
> +	sed -i "s@#Firmware_args#@image_arg: '-bios {firmware}'@g" "$2"
> +	sed -i "s@#Firmware_url#@url: ${PROJECT_URL}/${COMMIT_BRANCH}/qemu-${1}/firmware.bin@g" "$2"
> +}
> +
> +# This method creates LAVA job definitions for QEMU amd64, arm64 and armhf
> +# The created job definitions test SWUpdate, Secureboot and IEC layer
> +create_jobs () {
> +	if [ "$1" = "IEC_Layer_test" ]; then
> +		for arch in amd64 arm64 arm
> +		do
> +			cp $LAVA_TEMPLATES/IEC_template.yml "${job_dir}"/IEC_${arch}.yml
> +
> +			if [ $arch != amd64 ]; then
> +				add_firmware_artifacts $arch "${job_dir}"/IEC_${arch}.yml
> +			fi
> +		done
> +
> +	elif [ "$1" = "software_update_test" ]; then
> +		if [ -z "$2" ]; then
> +			for arch in amd64 arm64 arm
> +			do
> +				cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}"/swupdate_${arch}.yml
> +
> +				if [ $arch != amd64 ]; then
> +					add_firmware_artifacts $arch "${job_dir}"/swupdate_${arch}.yml
> +				fi
> +			done
> +		else
> +			cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}"/"${2}"_amd64.yml
> +			sed -i "s@software update testing@${2}@g" "${job_dir}"/"${2}"_amd64.yml
> +			sed -i "s@) = 2@) = 0@g" "${job_dir}"/"${2}"_amd64.yml
> +			if [ "$2" = "kernel_panic" ]; then
> +				sed -i "s@kernel: C:BOOT1:linux.efi@Kernel panic - not syncing: sysrq triggered crash@g" "${job_dir}"/"${2}"_amd64.yml
> +			else
> +				sed -i "s@kernel: C:BOOT1:linux.efi@Can't open verity rootfs - continuing will lead to a broken trust chain!@g" "${job_dir}"/"${2}"_amd64.yml
> +				sed -i "s@echo software update is successful!!@dd if=/dev/urandom of=/dev/sda5 bs=512 count=1@g" "${job_dir}"/"${2}"_amd64.yml
> +			fi
> +		fi
> +	else
> +		for arch in amd64 arm64 arm
> +		do
> +			cp $LAVA_TEMPLATES/secureboot_template.yml "${job_dir}"/secureboot_${arch}.yml
> +
> +			if [ $arch != amd64 ]; then
> +				add_firmware_artifacts $arch "${job_dir}"/secureboot_${arch}.yml
> +			fi
> +		done
> +	fi
> +
> +	if [ "$2" = "kernel_panic" ]; then
> +		sed -i "s@#branch#@maintain-lava-artifact@g" "${job_dir}"/"${2}"_amd64.yml
> +	elif [ "$2" = "kernel_panic" ]; then
> +		sed -i "s@#branch#@${COMMIT_BRANCH}@g" "${job_dir}"/"${2}"_amd64.yml
> +	else
> +		sed -i "s@#branch#@${COMMIT_BRANCH}@g" "${job_dir}"/*.yml
> +	fi
> +	sed -i "s@#distribution#@${release}@g" "${job_dir}"/*.yml
> +	sed -i "s@#project_url#@${PROJECT_URL}@g" "${job_dir}"/*.yml
> +
> +	for arch in amd64 arm64 arm
> +	do
> +		sed -i "s@#architecture#@${arch}@g" "${job_dir}"/*${arch}.yml
> +		sed -i "s@#imageargs#@${image_args[$arch]}@g" "${job_dir}"/*${arch}.yml
> +	done
> +}
> +
> +create_cip_core_jobs () {
> +	if [ "$TEST" = "IEC" ]; then
> +		create_jobs IEC_Layer_test
> +	elif [ "$TEST" = "swupdate" ]; then
> +		create_jobs software_update_test
> +		create_jobs software_update_test kernel_panic
> +		create_jobs software_update_test initramfs_crash
> +	else
> +		create_jobs secure_boot_test
> +	fi
> +}
> +
> +# This method attaches SQUAD watch job to the submitted LAVA job
> +# $1: LAVA Job ID
> +submit_squad_watch_job(){
> +# SQUAD watch job submission
> +	local ret
> +	if [ -z ${CIP_SQUAD_LAB_TOKEN+x} ]; then
> +		echo "SQUAD_LAB_TOKEN not found, omitting SQUAD results reporting!"
> +		return 0
> +	fi
> +
> +	if [ "$TEST" = "swupdate" ]; then
> +		squad_project="swupdate-testing"
> +	elif [ "$TEST" = "secure-boot" ]; then
> +		squad_project="secure-boot-testing"
> +	else
> +		squad_project="iec-layer-testing"
> +	fi
> +
> +	local DEVICE=$2
> +	local ENV="${DEVICE}_${squad_project}"
> +	local squad_url="$SQUAD_WATCH_JOBS_URL/${SQUAD_GROUP}/${squad_project}/${COMMIT_REF}/${ENV}"
> +	ret=$(curl -s \
> +		--header "Authorization: token $CIP_SQUAD_LAB_TOKEN" \
> +		--form backend="$SQUAD_LAVA_BACKEND" \
> +		--form testjob_id="$1" \
> +		--form metadata='{"device": "'${DEVICE}'", "CI pipeline": "'${CI_PIPELINE_URL}'", "CI job": "'${CI_JOB_URL}'"}' \
> +		"$squad_url")
> +
> +	if [[ $ret != [0-9]* ]]
> +	then
> +		echo "Something went wrong with SQUAD watch job submission. SQUAD returned:"
> +		echo "${ret}"
> +		echo "SQUAD URL: ${squad_url}"
> +		echo "SQUAD Backend: ${SQUAD_LAVA_BACKEND}"
> +		echo "LAVA Job Id: $1"
> +	else
> +		echo "SQUAD watch job submitted successfully as #${ret}."
> +	fi
> +}
> +
> +# $1: Job definition file
> +submit_job() {
> +        # Make sure yaml file exists
> +	if [ -f "$1" ]; then
> +		echo "Submitting $1 to LAVA master..."
> +		# Catch error that occurs if invalid yaml file is submitted
> +		local ret=$(lavacli $LAVACLI_ARGS jobs submit "$1") || error=true
> +
> +		if [[ $ret != [0-9]* ]]
> +		then
> +			echo "Something went wrong with job submission. LAVA returned:"
> +			echo "${ret}"
> +		else
> +			echo "Job submitted successfully as #${ret}."
> +
> +			local lavacli_output=${job_dir}/lavacli_output
> +			lavacli $LAVACLI_ARGS jobs show "${ret}" \
> +				> "$lavacli_output"
> +
> +			local status=$(cat "$lavacli_output" \
> +				| grep "state" \
> +				| cut -d ":" -f 2 \
> +				| awk '{$1=$1};1')
> +			STATUS[${ret}]=$status
> +
> +			local health=$(cat "$lavacli_output" \
> +				| grep "Health" \
> +				| cut -d ":" -f 2 \
> +				| awk '{$1=$1};1')
> +			HEALTH[${ret}]=$health
> +
> +			local device_type=$(cat "$lavacli_output" \
> +				| grep "device-type" \
> +				| cut -d ":" -f 2 \
> +				| awk '{$1=$1};1')
> +			DEVICE_TYPE[${ret}]=$device_type
> +
> +			local device=$(cat "$lavacli_output" \
> +				| grep "device      :" \
> +				| cut -d ":" -f 2 \
> +				| awk '{$1=$1};1')
> +			DEVICE[${ret}]=$device
> +
> +			local test=$(cat "$lavacli_output" \
> +				| grep "description" \
> +				| rev | cut -d "_" -f 1 | rev)
> +			TEST[${ret}]=$test
> +
> +			submit_squad_watch_job "${ret}" "${device}"
> +
> +			JOBS+=("${ret}")
> +
> +		fi
> +	fi
> +}
> +
> +# $1: Device-type to search for
> +is_device_online () {
> +	local lavacli_output=${job_dir}/lavacli_output
> +
> +	# Get list of all devices
> +	lavacli $LAVACLI_ARGS devices list > "$lavacli_output"
> +
> +	# Count the number of online devices
> +	local count=$(grep "(${1})" "$lavacli_output" | grep -c "Good")
> +	echo "There are currently $count \"${1}\" devices online."
> +
> +	if [ "$count" -gt 0 ]; then
> +		return 0
> +	fi
> +	return 1
> +}
> +
> +submit_jobs () {
> +	local ret=0
> +	for JOB in "${job_dir}"/*.yml; do
> +		local device=$(grep device_type "$JOB" | cut -d ":" -f 2 | awk '{$1=$1};1')
> +		if is_device_online "$device"; then
> +			submit_job "$JOB"
> +		else
> +			echo "Refusing to submit test job as there are no suitable devices available."
> +			ret=1
> +		fi
> +	done
> +	return $ret
> +}
> +
> +# This method is added with the intention to check if all the jobs are valid before submit
> +# If even a single definition is found to be invalid, then no job shall be submitted until
> +# it is fixed by the maintainer
> +validate_jobs () {
> +	local ret=0
> +	for JOB in "${job_dir}"/*.yml; do
> +		if lavacli $LAVACLI_ARGS jobs validate "$JOB"; then
> +			echo "$JOB is a valid definition"
> +		else
> +			echo "$JOB is not a valid definition"
> +			ret=1
> +		fi
> +	done
> +	return $ret
> +}
> +
> +check_if_all_finished () {
> +	for i in "${JOBS[@]}"; do
> +		if [ "${STATUS[$i]}" != "Finished" ]; then
> +			return 1
> +		fi
> +	done
> +	return 0
> +}
> +
> +check_for_test_error () {
> +	for i in "${JOBS[@]}"; do
> +		if [ "${HEALTH[$i]}" != "Complete" ]; then
> +			return 0
> +		fi
> +	done
> +	return 1
> +}
> +
> +# $1: LAVA job ID to show results for
> +get_test_result () {
> +	if [ -n "${1}" ]; then
> +		lavacli "$LAVACLI_ARGS" results "${1}"
> +	fi
> +}
> +
> +get_junit_test_results () {
> +	mkdir -p "${RESULTS_DIR}"
> +	for i in "${JOBS[@]}"; do
> +		curl -s -o "${RESULTS_DIR}"/results_"$i".xml "${LAVA_API_URL}"/jobs/"$i"/junit/
> +	done
> +}
> +
> +# $1: Test to print before job summaries
> +# $2: Set to true to print results for each job
> +print_status () {
> +	if [ -z "${1}" ]; then
> +	# Set default text
> +		local message="Current job status:"
> +	else
> +		local message="${1}"
> +	fi
> +
> +	echo "------------------------------"
> +	echo "${message}"
> +	echo "------------------------------"
> +	for i in "${JOBS[@]}"; do
> +		echo "Job #$i: ${STATUS[$i]}"
> +		echo "Health: ${HEALTH[$i]}"
> +		echo "Device Type: ${DEVICE_TYPE[$i]}"
> +		echo "Device: ${DEVICE[$i]}"
> +		echo "Test: ${TEST[$i]}"
> +		echo "URL: ${LAVA_JOBS_URL}/$i"
> +		if [ -n "${2}" ]; then
> +			get_test_result "$i"
> +		fi
> +		echo " "
> +	done
> +}
> +
> +print_summary () {
> +	echo "------------------------------"
> +	echo "Job Summary"
> +	echo "------------------------------"
> +	for i in "${JOBS[@]}"
> +	do
> +		echo "Job #${i} ${STATUS[$i]}. Job health: ${HEALTH[$i]}. URL: ${LAVA_JOBS_URL}/${i}"
> +	done
> +}
> +
> +check_status () {
> +	if [ -n "$TEST_TIMEOUT" ]; then
> +		# Current time + timeout time
> +		local end_time=$(date +%s -d "+ $TEST_TIMEOUT min")
> +	fi
> +
> +	local error=false
> +
> +	if [ ${#JOBS[@]} -ne 0 ]
> +	then
> +
> +		print_status "Current job status:"
> +		while true
> +		do
> +			# Get latest status
> +			for i in "${JOBS[@]}"
> +			do
> +				if [ "${STATUS[$i]}" != "Finished" ]
> +				then
> +					local lavacli_output=${job_dir}/lavacli_output
> +					lavacli $LAVACLI_ARGS jobs show "$i" \
> +						> "$lavacli_output"
> +
> +					local status=$(cat "$lavacli_output" \
> +						| grep "state" \
> +						| cut -d ":" -f 2 \
> +						| awk '{$1=$1};1')
> +
> +					local health=$(cat "$lavacli_output" \
> +						| grep "Health" \
> +						| cut -d ":" -f 2 \
> +						| awk '{$1=$1};1')
> +					HEALTH[$i]=$health
> +
> +					local device_type=$(cat "$lavacli_output" \
> +						| grep "device-type" \
> +						| cut -d ":" -f 2 \
> +						| awk '{$1=$1};1')
> +					DEVICE_TYPE[$i]=$device_type
> +
> +					local device=$(cat "$lavacli_output" \
> +						| grep "device      :" \
> +						| cut -d ":" -f 2 \
> +						| awk '{$1=$1};1')
> +					DEVICE[$i]=$device
> +
> +					if [ "${STATUS[$i]}" != "$status" ]; then
> +						STATUS[$i]=$status
> +
> +						# Something has changed
> +						print_status "Current job status:"
> +					else
> +						STATUS[$i]=$status
> +					fi
> +				fi
> +			done
> +
> +			if check_if_all_finished; then
> +				break
> +			fi
> +
> +			if [ -n "$TEST_TIMEOUT" ]; then
> +				# Check timeout
> +				local now=$(date +%s)
> +				if [ "$now" -ge "$end_time" ]; then
> +					echo "Timed out waiting for test jobs to complete"
> +					error=true
> +					break
> +				fi
> +			fi
> +
> +			# Wait to avoid spamming the server too hard
> +			sleep 60
> +		done
> +
> +		if check_if_all_finished; then
> +			# Print job outcome
> +			print_status "Final job status:" true
> +
> +			if check_for_test_error; then
> +				error=true
> +			fi
> +		fi
> +	fi
> +
> +	if $error; then
> +		echo "---------------------"
> +		echo "Errors during testing"
> +		echo "---------------------"
> +		print_summary
> +		clean_up
> +		return 1
> +	fi
> +
> +	echo "-----------------------------------"
> +	echo "All submitted tests were successful"
> +	echo "-----------------------------------"
> +	print_summary
> +	return 0
> +}
> +
> +set_up
> +create_cip_core_jobs
> +
> +if ! validate_jobs; then
> +	clean_up
> +	exit 1
> +fi
> +
> +if ! submit_jobs; then
> +        clean_up
> +        exit 1
> +fi
> +
> +if ! $SUBMIT_ONLY; then
> +	if ! check_status; then
> +		ERROR=true
> +	fi
> +
> +	get_junit_test_results
> +fi
> +
> +clean_up
> +
> +if $ERROR; then
> +	exit 1
> +fi

Besides the shellcheck issues I already mentioned (plenty :) ):

This schedules multiple LAVA jobs from the same gitlab job, but also not
all of them in a single gitlab job. What is the reason for this specific
split-up?

In xenomai-images, we run one LAVA job synchronously in one gitlab job,
and we dump live the LAVA console output. Makes it more integrated, and
you don't need to follow links outside of the gitlab UI. Downside: More
runners need to stay in stand-by while waiting for the workers and
devices to finish.

I'm not strongly pro or against a specific way, but I would like to
understand and validate the motivation for the given one - and possibly
adjust it further.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


