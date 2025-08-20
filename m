Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB96CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:33:54 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.35])
 by mx.groups.io with SMTP id smtpd.web10.1746.1755707624036216678
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:33:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lJd9c0/T;
 spf=pass (domain: siemens.com, ip: 52.101.65.35, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0Ksw6v0pKvEwP/O1q6DIomuGtHP6gf1p2+c+BZmUtHFhIMWHMlhVu8Ys83W4pHvQbRxRZb0yHkzK8JZoWBC/VfWjVrGLDD9t2miK7We7IjUo0h/oeD5fjn5STY/MOdkq4qyKoGoFOTkEeBeOwjZ0tbpZviPaLGJ1SXQWx12pNpJQFKH9Ln2aGr58yfP4U0qibP5IOQutpo8JdY60/H4vtzrq2xqrsiFcf+NnJ3+B0FKw43GyOd+VDBiuKzCULCr8RWVzyRRTk6v1jLX7bonNvdFkGo9lYk7wgVcGuA2edZzzhzufRooy+LBts901r1wcrwXAaEZDTB9HPlMxyz92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jHSxJPt/1Kmyw3pAcY8dlYZy69C60gr2OCILLEuUpU=;
 b=Y2SFA0juYnX/+ftoBYxjZTcaUnR2xf3A7xLQKAqu+gZrb2XlEegrlQLoZftd6RWnL9Nacj2El2IsmXhAyRqymDYmajwYQBugZfhUbkW3OXhJ4QlzVtUPJjciXPGGPEgIPEU1D0boC6Mw64oiZYTcMDHZUNEHghzMS2d4C7A3sMH2QwS6h75jY0pWO5V4086UkcdQUMbMaBt0BbCaR5QcJjfbIIId9064SFVehmu/3r9xQkArpEs/awr2hVW6PcvndcFADGPEEbkn6uS9Qd8fmohago+wchNcctvzblhuoCevQSCyOpE+1xcaYfh8MsVSL1ikEXvKryIn2YYorJVJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jHSxJPt/1Kmyw3pAcY8dlYZy69C60gr2OCILLEuUpU=;
 b=lJd9c0/TFHGIsK5OPuI+LyQNk3yVe2KBP+ND9uCuPE9nyATPcr8AfjdKARAgSdpGnSJv5q26QV0C1bI66QNjrSInaXm5LlwmXm731pxX5K+h9++oVuVhSoFVBJNZnUwdC9Hke4d+Z2Ft2N9vY5RXgKUdkN9FmwZlCJNYDnV7RHz214lEoj0MpqjWY8isKJEELhdxRjOzNGiRsxOt3oR6apCCOF2xgdmgMTvWP4xaEkkSPr5WW18st2rarB5WoSF9PEtKLKYYn6hkUU+MxsqBCf2PvQ9PokUt4etRhs/2REadhWyHWVhSVji9FMacm8nbgsxZWfVu37nQEJc/+dC7cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8474.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:444::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:33:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 16:33:39 +0000
Message-ID: <19f17067-e097-4a34-9225-188580235c9b@siemens.com>
Date: Wed, 20 Aug 2025 18:33:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] initramfs-crypt-hook: remove redundant
 logs from console
To: "Sari, Sercan" <sari.sercan@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
References: <DB9PR10MB66433A47DB000397BB6EA9BDF033A@DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <DB9PR10MB66433A47DB000397BB6EA9BDF033A@DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc84c86-6994-4a83-7e6f-08dde00751ab
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UTB1RnBlQzZQQU5tM0pzeTltYlpMbXhlTzBRR0p5dUVLenZMU1BVbUc5d29k?=
 =?utf-8?B?NkJrcVowblFRbU5sTmJ5dkVlZHI3ZGxZZDFmOVYwM2JDemlNUlBMY2FpTGxB?=
 =?utf-8?B?My9CTGMxQWFVYlkvbHRuWlptNEFYK3F2Q0UxVGtaTWxkR3R2WVE0cWxxMytl?=
 =?utf-8?B?UDNrVXdWeVJJSGxqb1FHcldlS1k4bmpoOGJQc3gxUEJkYy81ZmpGZU1kTkVN?=
 =?utf-8?B?MTZJd0duTFZEUHBmQW5CVzhPTDJ6VjRPd2tBK24wcVpHdFF4UTRoc05XdERl?=
 =?utf-8?B?TVdIbW43OWJ5Ri9WelVlMzlIb2kzTTBTcTNUTTcrY2FRMVAzTyt4My9zTDBH?=
 =?utf-8?B?ZGlKUzRuRUNUVDVBTVBDODhRbCtQK2RVU2U5SXdFMVdmaUtPUVdMaHN6TDJn?=
 =?utf-8?B?Vkpmb01TSnZMeHAzaXk0L2ZheTc1NHpSbEh4SDlCeHV1c084a0tIWk5ZL1dk?=
 =?utf-8?B?Zm90aVZhekRqcXVKTkdLMDk2V0YrY25QQmRNSGt4TTJVc29Jc3BMVGpiek44?=
 =?utf-8?B?bFJGU0dmaEFXUTV2TVh3OG5mQktXODdCcWd5aG1XZFYyYXA4a1NpNzA2REhF?=
 =?utf-8?B?NWprMm9EeWdGUVVIcm5zanpLUkUvTjdwa1RhU1J4ekE0dkJMeVJLdCtOV0o0?=
 =?utf-8?B?bzhnckZ3Q3JmNkpISDJSdGR3VVpDWnNiY29uVWVwQ0xtdEF3djl2Y3lqdkR6?=
 =?utf-8?B?RGhjVk51K2xuc0tWZWVGTjh1NFZZRXZqZXF3ZG1mWmg3NHlVVGt5cnB1UTVt?=
 =?utf-8?B?UU5ZbXVQbWhHRGtINEJpdVg4UGdEVlJHR2F3TTJteklFeXRZTjF2K3pHTjht?=
 =?utf-8?B?RWNLRFBzQ2ZJdEJSazFybWo1ODhlclNBRkFKOVFwV2YySXZQWjlSditCMGUw?=
 =?utf-8?B?WU5QUGRTdm8raFN1VTJSeWJIVS9mZ1VqaW5QcGJlL2xPV0NEaklPeVVmTHAr?=
 =?utf-8?B?czNyUGFUSXNtSi9tUTZCNDRoMzhxSTdHUExDdTVHMDBpTndUV014UmNxUUtz?=
 =?utf-8?B?MnNUTysxNmlQMEQwS3JzS2kwMG1PcktmemExT2JoaVY5M04vbGJGWkhLZjZW?=
 =?utf-8?B?M1c3OXExOGptMWRVMnJKWDFNZUo5QUtvdkpzbGk5cnVmUCtCOTdVYzVpOUNC?=
 =?utf-8?B?RUhHSE9Uc29QQ3RQZThJWjNreE9VcnE4VnBQTXQrTHdwV0tQYXJRL3RiUHF4?=
 =?utf-8?B?OTd3dFk0eUp4ZmErOWthaHh5azFsSmk2N3hkQVZOMVd0ZksxcmV3TFhHQnFo?=
 =?utf-8?B?L053QzhzTGVrek9rYnI2Vi9oQmZHTWNGbU56Z1dmb1pNbjRnd0dhQkZtUS96?=
 =?utf-8?B?cmExbVR3eldCVEo2bGZTTktiQU05TVAzcUtQY2RRbzd2elIwY1RaWFcxdE5J?=
 =?utf-8?B?d3kya2NiNkNJK3kyOHY5Z2VMNko0MnlFWVR2aTF6alBZcjNuY2prbmNVOGdE?=
 =?utf-8?B?K0pCcWVubzRNN2pjYVQzVmdpQ213OVdMelBwbk00aEFHR2kyTTJ4eCtxWnZR?=
 =?utf-8?B?amprdTJyd1hTUEo1MUxXOFM5WW82WFRiRjFZR0VrY0RiZjhHdkxHRlh1T3ZD?=
 =?utf-8?B?eS8wcjMrYXN3T0xIY1dpQjd6NFd2a0VtNytVWkJDbUVLSm1LNnRxWXVNK04w?=
 =?utf-8?B?RVBjNURqRXZma1c5S3c2WHJVUmdJVTdWdGUyTmtZaytmdyt0dnNPTmZvdlJG?=
 =?utf-8?B?QUo1dWVQWlRVd0p4SStzcFF2bElMV3RVVU1TWkp4emN2d2R1MnRsQThsZlVI?=
 =?utf-8?B?K2pnWjNYYW51T2U4ZHJlRFJBVEhzanJ4dEVhRnpNTzYxcUNQN3MyK2Qra2Ja?=
 =?utf-8?B?TldXL21JVUd6SWQzRHQwS1RXeXFQWkM5TnVSc0t3K3IzNmVkRlVrSXYyTnZF?=
 =?utf-8?B?Y0VuY0tiWjZHU1BNY0VxUkRhU1N1TGwycGI5b2xHOVUzZmNBRU9uNlpHamty?=
 =?utf-8?Q?6nOIOz7FxaI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TGRYWk1JckZBS1ZFWitpdmc2RlV4MjA4RVl0VkwvTXUwbU1sVXQ0aU45VThN?=
 =?utf-8?B?dmJnOVcyWjN0RDYrQlY0cFV5R0U2TmZjbWdVSUNlRmk3WkpXTkowL1Zrd2Vz?=
 =?utf-8?B?THoyTEZUc05FeG5xSmdrM2sxNHYvNkFwb2kxQzBOcU13UEVYUWpqbVUrcDFn?=
 =?utf-8?B?Z1JUMnpqK0ZpdS9uN09qRU9uazNxcUNUbjlpeDBtMUdFRlhuSHQ2VWd1bjh3?=
 =?utf-8?B?dElCbHNGTkpCU1dtcXJlTEhNVGkwc2M5SzdiVGZ0S2pMeTh5V3FXdWI1K0p6?=
 =?utf-8?B?bUVlVWVUTHhoK0Rhd1VZY04wSFVvU1EwSDZha01WRHREY1RhTDBBSzhhak0v?=
 =?utf-8?B?OWFlTW14V3ZCQWhyM3dpK3MzWXB1bTlYK0VzWVdRam1ZVnRsMzQ1OXV2OHFG?=
 =?utf-8?B?ODE2OEtCY3VOUk5jbTdiYXJWVWZuUTY2SHkwK2dacUp1Qkx6UDJtYTVMai8z?=
 =?utf-8?B?bXlqZjlnVGRZOFF4UDBoWTZ6NWIrZ2o1RGNDV2tFcFpoVVlOVmc0bC80aVlK?=
 =?utf-8?B?UEFMSDVDOFVoTEdja3hKWDlUVnFzZHoyU0U4OUxLQmxCNmdDa3hZRFBHeWht?=
 =?utf-8?B?UWZhVE9va3RoRUk2bno1VHlKNU9PcTZuYzZSUVcyQ2xldElISHJlRWZCbFR2?=
 =?utf-8?B?bzN5dThobHZsTVkyN2ROSnpKTXdma0lzQ0d0dXFxdThwd0xkRDRZZTBrcE4z?=
 =?utf-8?B?YlRCR3FGTGYrVHRjQURFdTZ1Y3UxeVNSNmc1RGlvM0dhSFVRb1FOYjNLZmwz?=
 =?utf-8?B?ckhjQVJkVjNBYXNhUTNQaVQzd0ZYdzlDSy9UK1h0K2JQQWFucDM2aEhXM1hO?=
 =?utf-8?B?VkRIbnlqMkpRZTcyQTQ3V29PMTIyMlNUVGdqMUFrQzViaXZmS0RJNWNMK2FE?=
 =?utf-8?B?ejYwaUR1MUJMZ2hPU1p0TG83bmVOL0VhV3grbnJVMjkrNS9Damk4Uk9xa1ZK?=
 =?utf-8?B?K0RRM3dLZEwybmh1TVJ6MmJzcFdRRG53andhblhTSDlzTWVBVFpXSDFBRWpn?=
 =?utf-8?B?VTdBaElqSHRUSitZTWtKRmNLWjFkOVBBc0pyNUQzM2MySFpheE9kUHFpYnFl?=
 =?utf-8?B?NHdBV0dqcnlGY3ZzN3BpVGNmaERFUlZsMXBBSWtXeHlPQ0FVWlVPYitVQ1Ft?=
 =?utf-8?B?V2V3N2JqM25NOHR6OHJuVDhkbWpBaTVlTFlVK3BwNXpnSU1SNnVpZndmTm5R?=
 =?utf-8?B?aDN5UjBzRmJmc0V6ajkwcVZLdHhmNlV3QkU1ZUFPQWJFMVptSU9ZaTRKdGNz?=
 =?utf-8?B?VjcrcUZFamNIL2Z0V0UrMmxJcUpIRFpIR3RRVlRDajUzR2F5OW5SQXBWbzli?=
 =?utf-8?B?d1hWbUJVU3p0elJoTWFPdCtwZEhJL2hzTUMyNUNWL1BUTlE2QjNTMWY2UXRq?=
 =?utf-8?B?T0pSYmN3WFJHblljQnVZcGRLYnhrOUpFWTdXWUZwNEsrbHFkR2oyMzNWT3dB?=
 =?utf-8?B?KzRvVDlQYlkvSXlhNHVjK0RIdnJJL0hlemFTa2RiK201UC9xQmpDSndlUDNk?=
 =?utf-8?B?RVk3U2VLSFFyM1FaZGIwU3hkR0xSbmNtTXhDcEpnUi83bmoxUlpXQitIbE1Y?=
 =?utf-8?B?bHQ4ekd1WmM3blhqNUwyb1FXZXUyTjNMQmpPaGw5OWVtQTYrd3hLRDZJbDJs?=
 =?utf-8?B?RGs4OXV5VmttdVVZYlZGNGNmMXkrSVZXR1kzd05MVElMZlBkNHhpVVpObE1Z?=
 =?utf-8?B?YkVQdTM4ekRJNDgwMkoyVnVBSnY3MkRiM1Q5V3VlUHZPNzRaVXQzSzNRa3M4?=
 =?utf-8?B?dW1POUZXZzNoTFVBM1NXNlRzN2hGc2ppems2bFd0K3hzV2NrU1J6R2pLa0Jt?=
 =?utf-8?B?aXM4NUhNcWpiUkpZUkxqM0R0RE9tSTdZSEx1SHdBSk9Sc2FBNjhQUForUFZp?=
 =?utf-8?B?WCtJUmdUVlpUS3ArK0VqbU5HRzhhNEZWZUdkQldTOFpHc2dQUWRVQnJNVzB4?=
 =?utf-8?B?RjdhTnBpLzg3dTZZMzhUcW9yb2tpSzM1cFoyaW12WGZHTVRHRGFhM1VpUHpE?=
 =?utf-8?B?UVpQSjZIYVBxeVJzRGl0MUIzbnpacFE5Nk53SUp4M2ZGek81RUdnS253OUJD?=
 =?utf-8?B?U2d3NjVXaFdCbStrNndSSmloV3NTc0JIMkgveW1Mb0piMk1kMlAwS3RTRTRJ?=
 =?utf-8?B?bGxTZDJkdEJwSjhNWUU1TTZJOE12SzloWVQzTXY3RHVqeTk4K2cxVVVXWkhI?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc84c86-6994-4a83-7e6f-08dde00751ab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:33:39.8193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2vOsIn5uOYhcRND+qLucy4//PSjVouVpWYjUvYOzTAkDq0sMuofns1wOz/ydWSCLPW2+6e3zE2QsSdQNPgzBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8474
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:33:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19925

On 20.08.25 06:58, Sari, Sercan wrote:
> it is already provided via warning message in case of optional encryption or
> panic message when it is not optional, no need to create confusion to users.
> quite won't help when used alone.
> 
> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
> ---
>  recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
> index 01a4003..54d43f3 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
> @@ -11,8 +11,8 @@
>  # SPDX-License-Identifier: MIT
>  
>  tpm2_check_device() {
> -	tpm2_pcrread -T device:"$1" "$pcr_bank_hash_type":7 --quiet &&
> -		tpm2_testparms -T device:"$1" "$tpm_key_algorithm" --quiet
> +	tpm2_pcrread -T device:"$1" "$pcr_bank_hash_type":7 --quiet 2>/dev/null &&
> +		tpm2_testparms -T device:"$1" "$tpm_key_algorithm" --quiet 2>/dev/null
>  }
>  
>  TPM2_HANDLE="0x81080001"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

