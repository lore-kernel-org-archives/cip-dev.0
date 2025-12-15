Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9C4D5B16E
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 13:03:45 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.47891.1765803817257744586
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 05:03:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=M4vuPu6b;
 spf=pass (domain: siemens.com, ip: 52.101.84.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=js6d6xTzpPo63sd3TbTN3sEsP1TKwYXU6jt9Cz7dFIMbVOa4Qm34j69eEmjXjlCPqGbFQVxYHxyDo1IjuVja9hW9sYqpISdUM/HpJHJ9EemFsOY+lJPEJvaiwiHa8/u47gQn7QeDTHdrJFajtCX8BQBQk+ISoq7/Jn+S0Ej/ahDYgHPKK8pvgqS8FEofJ4hN+Q+PWnyvG/94NrQOgW4uzzB68EuyddV3H7yPWu93nKwMNcJCLcgWLfxJx88LB7nI9S3YxjMzeqxpU42sScO0Lk3PVNAwRqdhFn8jq5S24fYObJaH11UE+7wpHKm6t4QkCWyBfEGbcHWWSwe9vJtBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R340UUBujGFUw+V4Yx4YxWOlWXJTFQ1BylVPVbwZ0AE=;
 b=c6AOi4mGknNr8pVDQuTzTtp2DF5d198zOwWbo2tSc2SKBlCgEBrMt29JdsDmDVqePFjN2hzJMcRvOAXiKbB1g/ce7oVrjh3T26OEO+ema/sv50xNZCD/jbZi4urQkZoOzO2ogiHgRlBOnvloEFQ97vimJ4AMMuogqIv3zbcBnYo1JpRpCO6tRH65A0RnMygYtO+XeYaXtcBUo2YAg1Do0gzNRVjsIhzI2c/MAvK/kchWG34tL+XepUb47mGI0OdZ+F1TIuGnxsPEZcSEeVE8zTNBLCzitdVVm8d5caHwNeMXotuEu78/n2N9Bbf8CstkvRJN64i1SBbB8e1vLjO5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R340UUBujGFUw+V4Yx4YxWOlWXJTFQ1BylVPVbwZ0AE=;
 b=M4vuPu6bW24ibGFs6oGWFeAXIr1SspuC/8O7+Eh4M2yO2HM4CgLW78GTM5YgHn7+HYG1CsMeKFigcwU+FEkfOmHivYzHfiDz0jiOrQFzNfIt9muVhxvCNoybHyRsneuBBxwNLjUKIufVuVbxV/Fn57+ys8NKQXfdjGd9t/5FsBE3t4EukNoQqySudb/GYkBZUtflxRKTDnb8SP9zoIRJvVe9tErt/CmAvtINM+Mtzm4icBm2a1ATo9ahwravaYKWi0bDeTHaF44i+XIC8kUwNJk/kT6bUQLNYwJTpwxlXbWy7PWQGNQhPO4ZUdv5kX0px3Hr7noBODqsAlcUBKjjkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8894.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:441::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 13:03:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 13:03:33 +0000
Message-ID: <04433088-58a1-4b85-a72c-d4aad7538920@siemens.com>
Date: Mon, 15 Dec 2025 14:03:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 3/3] fix: ensure separate root
 home dir is recreated after factory-reset
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20251215093719.323668-1-Quirin.Gylstorff@siemens.com>
 <20251215093719.323668-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251215093719.323668-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2c13cf-01a8-434b-5ab1-08de3bda5a57
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N05FdHRjRjNPd3llZUE1MGFZVUZXMjV4SU01czNWa3hXU2dKMU1KTUszenYr?=
 =?utf-8?B?QVNROFRzM1BCMVJtdHBhdTAyK3lWa2pPalpoS1FwTXNhd1VKZUFZWEpSUGRI?=
 =?utf-8?B?STZBelVHYXdHWEJpQUFnZ3Q1bStDTjlNN2hWanVVR3hwL0NiemJaV2k4Q1N3?=
 =?utf-8?B?U2YxQXBPTE1qY1I5Q3JFVzAySjZJZGpMUVVtRGtYNmpsQlg1Y01ZcW9VZmZ6?=
 =?utf-8?B?T3B1amZqMmhhVURLMkxZZHAwem0vbmFwdE9xNk9zYVJBUnNlUUVaYVpvdkk0?=
 =?utf-8?B?T0NqdlBacGNyUytQdkNxaDdiM0g4T3lsWlNyWURzdWRsOWhGRWJDK1ZGU1dG?=
 =?utf-8?B?N0h3SGpMUkpvR1gwZWpIQ2VlK21taGxkQ3dnc09GcGI5aTJBVFkyVFJxN0Qy?=
 =?utf-8?B?M1NDK3FmNGtrcUdDMzNKYnl5cGRlbWtLY28rbkxWL2ZueHIxRElkMmlGSkla?=
 =?utf-8?B?NHRHeFNpZjFpSnZGaVNTK2xFdzlkZFh2dVJXemkyeXFZaXdjeitsdGV6RWNu?=
 =?utf-8?B?OUpRY0ticitzZTg5Y0hrMnVVTkQ3ZDE5VFlVbTdYdk1NOVRFQkR6RDYxdG5i?=
 =?utf-8?B?Mm40WTRBVC8wdnNFZyszOUdBVnhoSU1kWWR0WFByOVN1OHJVYitZRThnWU5D?=
 =?utf-8?B?MHVwUWUwUEczMzBETHRsMlIySmxFTjBOejh0NlNIVENJUlExdFVZTzRjWTJ3?=
 =?utf-8?B?bGZVQml6TUxVNy9VVHBmdlVZdXE4L1c0Z1FSQkVMRHlSYWc5TGlJY2EybmFD?=
 =?utf-8?B?Ly85aEFzMkJoZTI1OURZZ3VpZisydWpUZFdXdnBjSXg1TUtIamsxbzZSUXlC?=
 =?utf-8?B?MGdQS0ZjVHRSMkhLVEdkQk5qbkpaMHRpT3RBQzVMTlp4ZHY4dzNtQU45ZjRX?=
 =?utf-8?B?NlJvbzBZdWllK1dNMGhNTkhUanRQSVJJWno5cU5tajdmNzVhZ1ptMmxPZkhY?=
 =?utf-8?B?N2UyTEhFZUt5Z0lmTXJhZDVSem5tT1JWVVo3VFRCY0Y3bzlzYjAxSFllalVQ?=
 =?utf-8?B?c1VNRzRkV0R6ZUsyZHJEeVpWdWQvbWg2WVZ3RXdHK0RkT0JBNTdDSThGOW9P?=
 =?utf-8?B?T3YxVTZuM3RwTTMxdkp2ZnZQNUF2Z1ROdzlNSVMzR1hqMkxacFNsRHM1dkZt?=
 =?utf-8?B?YzRieUxrNFdsWWIzcVk3NHZXNmhqRDc0elpiYjZoZHJsZjhxUWNxaU40MCtl?=
 =?utf-8?B?cG4yNElwSlN6ZDZZOGFHUUR6eTNKMGs0Ylo0Q0xhRGtNTDlIMTRBbmlqRHFV?=
 =?utf-8?B?cUFBUkdKTmM2QUtEK3UvZjJHSExQalppZkplSGZQZWtJeGZHeU1uWnQrdnpL?=
 =?utf-8?B?cGp1VFMrdEZoZE52UFQwLzZFWE5lOGN2dm9VWFozZDdFQjdtSC9sU2hsK2lm?=
 =?utf-8?B?TWpOZUNYcTl2aEJiR1dWbkZUQi9iTithN0xaSlYyQXJJZms0alRPSHdpdzBy?=
 =?utf-8?B?S09UK2RiRjhRM0pScEMydTcwcXBJRUtPTFJheVIwc1JGejZkUEVwenUvdkxx?=
 =?utf-8?B?bkFJZTRIckFEMU1YOE9rNThOUnd6V3pjNzRxbzllMFQxNTNmZmVSN3k3Z2xG?=
 =?utf-8?B?ZUJURDhsbVFjbVhweEpaTlFyMTV1c2o4SEZXcEhkUUh6dnV3ZlhQMncrUFBn?=
 =?utf-8?B?NDQvbzJxQ25BMHdNQjE2R0pXWWNsQlJabUxHRE82WlRFY3ZYdG5tOUNPM1Yz?=
 =?utf-8?B?dCtCdzRqaFBoQ2lQa2NLa013ZDVTQzZ3M1Y4QXhoQ2dYdGF6RUt0QUFBWTBo?=
 =?utf-8?B?VTh5bzJIQ0hQZXZhVHhaOFNpSDlhUkZkVlIyMmtPVDVsQjRXOWdzSVFOc2Jx?=
 =?utf-8?B?MHp0NkJjL1dKWWhiUmdhSkF0NHFvK3ZHczRxZEViWEF0cFpqajZmK1lBSFo3?=
 =?utf-8?B?NzlpeVhmSGdoMVE2cDgrVjJVcERHT2NrVmNCd0FDRklOcmc4c0EyQ2FjMGFr?=
 =?utf-8?Q?Uh2ldiJOX4v0d4PycLIqTtYgnLUAF9fn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M1YzbnlLeXJLS2hkbnZneWVvbFdUMlFRN21UMWhsWUhxa3lWVWtIMVhGaFdW?=
 =?utf-8?B?R2Yza1RYTVdtRlpVQVpuREZlM0lFVWFxYVh2cVk0QjlKc3dWd1prUlhTWi90?=
 =?utf-8?B?T0NtK0k0VTJVeDVXczFhb2MrTUhYaHlYTmRRR1ZJczIvdWs3R2NrY3JEOUlN?=
 =?utf-8?B?dWhtY0NkNkpFWHhXMDFYeWNNL1UxVmZFN0Jjdi9yU1hlQVd0Q1AzY2hCVGZX?=
 =?utf-8?B?eHZVaDBnSVBraFh1WmNYSGpBT1MyRVpKYUFtL0ZGaVlEalRNYWViVkpNTHUv?=
 =?utf-8?B?a0VTMmMrUklUSnBkdjJNSTlOWEN6aHp2K2dzQXVvUVZKa09HbGl0SkV1M2RK?=
 =?utf-8?B?SVFxVGtYcVNNRndFM09ZZ0ZQbXo4LzR6RlAzdmNJVHFRaUpzQTd0azNldGhr?=
 =?utf-8?B?SFlYK0JXZndxZ0FLS1dpUnRRUTQxM1pzWEk5OTFyQ280L25VSmxvRStPUTJ3?=
 =?utf-8?B?cHNybG5UV1lkMVlCOE54Q1ArWVVrMWhqVXhydlFiUWE2TGI5T0ZGa2xNR2FZ?=
 =?utf-8?B?bTh3cW5raFJLNXo5aGY2OTBoRkpKd2hQZzg4QlNnN2ZuNnhtbGJieExVSXZ5?=
 =?utf-8?B?QWppQUhFbEVsOERkSXh2T2lqaC93d1Q5QUdsRkxUMWxnMjVCT2ZuemtVb2JO?=
 =?utf-8?B?WVN1bzNIUVUwRXpmbVJSQVBRT2dzM2NvWmx0VnJXRjNwNDNuUDJwWE9lcnJN?=
 =?utf-8?B?NDBPYXIvMUxMNHp6RG95TEV6ZytYVjhFNjQwUWVmV0pXOGlVTTluWVpNSGQx?=
 =?utf-8?B?eE42RnFKRmRTNDRVaHpqUnFjdzhuK1cwTm81ckhCVFBmWldtalMrbkFhYVhT?=
 =?utf-8?B?Lzl1NytyOExCRC9kSW1nMGt1SS9aVEZRY3BiM1lXejd2R2xyaHc4TXlVY3Zm?=
 =?utf-8?B?VWNMMjAwcTJRMldwY2RWQXBSVFRZZjRlSk5icHF6MnFKWkk5NnVqNFNqNWhS?=
 =?utf-8?B?WUEyUVhoWVhldy9vRXh1cm9Ua0J2NFUwWkl2dzVGeDJsTWk2U2VhcnNmcFZ2?=
 =?utf-8?B?NWRLTWYrSGFkaDhIY1hZRVpjVlVydy9HV2tDeGd2cWMwWW9lV0Y1Q3cyOThT?=
 =?utf-8?B?eHp1ODRQd1hFRFRJQ3U4MzBZQmR5aVpuNWtOM2RXdFRNQ0JQcERaK1FhMVBN?=
 =?utf-8?B?dGNONC9BSnc3TG8wZDhrT2RrV3ExQll5TkxnYklmY09GWC8veWdiN1ZNbEJL?=
 =?utf-8?B?MUlXd1Z1UkJUMWt0RWp4MjhQZVJieGRkSDRycUVpOUVlU1FDVHFtRXdrb3RY?=
 =?utf-8?B?a0tKanVaVUZ5ZHpmSURqY29BclFuSUtxdzJIME1lRHl6ejAxQzB3V3NBRHk3?=
 =?utf-8?B?RkY5ZHBpM2ptYnIyYnhmaC95b0pUSTM4THpVV0REVXIyK3lBY20wcFVRNkl6?=
 =?utf-8?B?V2JrdmtYYkRLeUdINXZuR3FObUFseHhqY0VPQkRxOTJWU2xpYTE3Z3h4aE5B?=
 =?utf-8?B?cjN3bGU3eUd2S29KWWNvU2Q3ajJsMXdNcm5nUThDT01XQTRSc09NSjZCN1BQ?=
 =?utf-8?B?VkFpL1FYOXlwNVNiTHg4SUxWdHp1TXpMUWRxZTMyNzJublFFakZESXhOa1Fr?=
 =?utf-8?B?NEVnK3lSaGpsdHVHWlJhQzVMWHhKTmpkdUczN2hnbU9UZFU2dDF6ODFRNmNO?=
 =?utf-8?B?NVVOaERVcDBlaTJ1cmVNU1R2RG1HT1JrOTM0dVJqSGtaVWRJYmhObTNpV2g5?=
 =?utf-8?B?MnczVzhsMnJjTSs4WkxQVmI0R3BUdXJ0S2dyWEFiYWhxSGxHUTM4TWltWExU?=
 =?utf-8?B?MVFWZEx2RjJlTFJodmNYLzVRVG9Tc0lnbWlqQTFNSkJwQVlqb0Y5YkZEODdE?=
 =?utf-8?B?eWR2MGxpeWJ3aTBNMmQzdXRnUnN0VlVEdXJ1QUpsaW1YZlZpZ2FWRTlWalZ0?=
 =?utf-8?B?Z25VWmlFb3U2UUtGS3JuNnRrVlowbXlHQWZhNTMwd0UwSGVBQ2xwSFd5RFVJ?=
 =?utf-8?B?OTdUb1A5VXp4TjZsOXhna3pPQTkrZGdjMVZXbWZYLytFWHRUTysxT2x4RVNM?=
 =?utf-8?B?S25WTlhweFBQcGJkMTdEc0owajhRam15ekVJNG1vREdFaTB4aVA0UWxlQ1F2?=
 =?utf-8?B?bVFubzZDQjRtd3VYanh2Mm9PdU9lRlhoc1VTeUZScmJjcGplbVZ3QzVKMmM0?=
 =?utf-8?B?dlhuNXF6eDJYc0VXSUErMWFlRHdhNlZrVHk3YkV3bXI5WVBYVnhMME11SGlD?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2c13cf-01a8-434b-5ab1-08de3bda5a57
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 13:03:33.8895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTsqPDL4M3fOKq7vB0M4yrN44/ao/PCjYSTDk1jsvEw5qG7gvXfXquGmAxozaS1GnEkXnTPrCFv5X2GOaRDQxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8894
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 13:03:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21060

On 15.12.25 10:35, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If the option `separate-home-part` is used the home partition is deleted
> during a factory-reset. To ensure that the root home directory is
> available recreate it with tmpfiles.

"via systemd tmpfiles" would be clearer - I first read it as it would be
recreated from some tmpfiles, but only the folder is created.

What happens to the root home in case of single partition?

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../change-root-homedir_0.1.bb                | 15 -----------
>  .../change-root-homedir_0.2.bb                | 25 +++++++++++++++++++
>  .../files/change-root-homedir.tmpfiles        |  0
>  3 files changed, 25 insertions(+), 15 deletions(-)
>  delete mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.1.bb
>  create mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.2.bb
>  create mode 100644 recipes-core/change-root-homedir/files/change-root-homedir.tmpfiles
> 
> diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb b/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
> deleted file mode 100644
> index 79c7e67..0000000
> --- a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2021-2023
> -#
> -# Authors:
> -#  Henning Schild <henning.schild@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -
> -inherit dpkg-raw
> -
> -DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
> -
> -SRC_URI = "file://postinst"
> diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.2.bb b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
> new file mode 100644
> index 0000000..0e356cb
> --- /dev/null
> +++ b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
> @@ -0,0 +1,25 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2021-2023

Can be updated at this chance.

> +#
> +# Authors:
> +#  Henning Schild <henning.schild@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg-raw
> +
> +DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
> +
> +SRC_URI = "file://postinst \
> +           file://${BPN}.tmpfiles"
> +
> +do_prepare_build:append:separate-home-part() {
> +    if ! grep -q /home/root ${WORKDIR}/${BPN}.tmpfiles; then
> +        echo "d /home/root 0700 root root -" >> ${WORKDIR}/${BPN}.tmpfiles
> +    fi
> +}

Newline here.

> +do_prepare_build:append() {
> +    cp ${WORKDIR}/${BPN}.tmpfiles ${S}/debian/
> +}
> diff --git a/recipes-core/change-root-homedir/files/change-root-homedir.tmpfiles b/recipes-core/change-root-homedir/files/change-root-homedir.tmpfiles
> new file mode 100644
> index 0000000..e69de29

What's the purpose of this empty file? Why not only create it when it is
non-empty?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

