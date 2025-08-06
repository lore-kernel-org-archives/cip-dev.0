Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A436C87FD1
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 09:37:31 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.25])
 by mx.groups.io with SMTP id smtpd.web10.21344.1754473043745595099
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 02:37:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jiNN8imF;
 spf=pass (domain: siemens.com, ip: 40.107.159.25, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mguoXuLZROc4nk1p/u2JnNgmmcEl86BfSSIbrMUe+JSDkKsCBmvFaVNWGxsV78z0V2XqYgsyNFhnuHFHuesP9BQLex6lnC1IAllXkopMtxPd6hfRMVNYhgwo5xnEPxJSCsniMiqaCVr0TjSOErTnD0DBKXjdU0h5btFcrFbjoNTAAkUdRxT4lqMR529iUaqw4T61zBC94jOB34s3aO0KRM4pk43G+PZzMNhVbq+JSU7km3m6meKGxdQWf758foLAOUT95TYohS/JGuGY+S45BcW7j7AzkZXH13koVDhisAfeQhLfMaat1GYLqJJw3dH8aDH9SQ9b0ZGM530/zROdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orTcE5sm/kU1V+vWf5OkaHfeC5nvuqQe/K1KCIwNARo=;
 b=rmhcHxbit9PIKHxlNLtISBjWbtZNjgH3bv2AQDkq+dADQlvaEQa/L4kAJOsTUjOlXUdVZK+IdPaURypE0BOwe40eNTrcicjoP6v3dGKBpGjRl0Eutgx06ysn1y8iCxQyhhMmvRoya3IchLZWiUqsqXYDZBcgd1TBdsdirzu+r7dM1Fcd467dMZUH7hTuqb9+x/xYyocQkyGi1umm8v1Gia8O7hr6rHTrziSDI6PxlOahNizdYXWnPSTue1fHUoHG87Tf7//Kg+l/lyaFaESTqU1HGMiq82JCvnPgZcwfaLs2i9adgRYIw+WhcKkmkhol9xxfnCoOZ6qM023fw909mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orTcE5sm/kU1V+vWf5OkaHfeC5nvuqQe/K1KCIwNARo=;
 b=jiNN8imFV+4p5kv4b2f/QOOyZrupXHQP9EmekpwgSKrYTIU6bQOs2bVx1woBNiZAIEKI+4XEQFGu6qoxDq2FFKQDU3Ff8kE/SPROrvqXNmZd9Ac0f9pXp5AGlcXQly2fE6ilzSpfv0IDaFZsDs7yPpIj1mtE5KjzSS19h1ZrqXRiThlHcrtb8jYMT3LA96K/aSoCYJaaTCVUrt0xFym4hPPFwgY6HJ4rhfrd/Nuq6llvAPYAJMFJn+W7kj6g0Q5m6ia0ZQvOBHan3tCaySNlDx/qR5AmseQ41s2QxOGGjUkixAuIMet3Mp61SXBwZgeJxVAFyLwRrH5NeFJXglENOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3805.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:164::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 09:37:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 09:37:19 +0000
Message-ID: <d98d836e-5cbe-4ce5-84ce-0aeb2ed607b3@siemens.com>
Date: Wed, 6 Aug 2025 11:37:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] .gitlab-ci.yml: Set 'release: trixie' to
 build:qemu-riscv64-test-nokernel pipeline
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
References: <1754465215-9240-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1754465215-9240-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:610:4e::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3805:EE_
X-MS-Office365-Filtering-Correlation-Id: 35302478-a4dc-4c3e-7c61-08ddd4ccd665
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Rjk1OUdmUEhiaG8rcjZNOTB2NExPS3RSNDRFM2plOXBBQm12MU9zTDkrUFp5?=
 =?utf-8?B?Vk8wT2tabHJ0VkZ2NUJkK2lIMFdaNkRIUnVvRURINnVIZ01sam84ckxnY0pi?=
 =?utf-8?B?OVVBb2JVNHJ1dml6WXJyeXB3dTRLUDYyZld5ci9aT0NGQmluell1T2szaytp?=
 =?utf-8?B?RERqZ0I1Q1Z3VnlCZWdxOVFSSkZhSGNDOTZhTUNVcC9OYWRMOU9oYlY5WlJZ?=
 =?utf-8?B?SWRqaGt4RGhBekpkR2YxWXp1UytSUEM5cjQvVTl1dVh3UUk2TVNxYlhEVit5?=
 =?utf-8?B?QlpXbW96cVdKK3BwV1ZCZ1YrSUwyVmwvaWRmdXRabjY2NlNxTXpkSEY0V0FW?=
 =?utf-8?B?b1crMzliRndsb282S3VOVkRiK1dpb3ZCYS9QODBQbWJoZFBON3poVjlvR2xh?=
 =?utf-8?B?UUw4ZEpLSEtuV2MycSs2ajE1QXl5UkM2SzgxZm9ON05BSmxHZVdvK1JJUzYv?=
 =?utf-8?B?UW9jMWt3MDRWbWZIWXdGVFB5WjM2UWt5OUV3bk1PVGh0VEoxTkRLSjFHN2Zn?=
 =?utf-8?B?UlVnYmRvUTJva1JUb2g3L3NtVlZMSnlraDhDY0pqTVA2U3NNOWZ3R0cxTHl0?=
 =?utf-8?B?YmZub0xJVFJDSHY1a04zQWM3ZW1TaFZQSGhsWW00Z2xzRGZ3TG5wVU1MTGNq?=
 =?utf-8?B?dzUrU0N1U3ZkeVk4NlpXUVFHOXM3UHhYYXZZK0MzRnhaenZtY3VLRnNKZ0Rk?=
 =?utf-8?B?WHBQU3d3NUNzOUFVSlJhNUhzTUFrK0M2UFNhNlV5Q3YwQ293UnVBWXVZZ2pm?=
 =?utf-8?B?L0VyU1dsMkc3RCtXTnQydHNSbHFpTmRRbjZweGFUKzdzdm1YVzUwTG9YeEZY?=
 =?utf-8?B?V2tTby9PU251RTRtNGozdlJPdmN4dUxqSnNwQ2Z0OTU4blczeEo1RU0zTDBH?=
 =?utf-8?B?TXhxVzZuY3RJRnpwcHZTd0g0NkU2dk8xYTRBRG9IaVo5dkxkUERqUGRsc3Mz?=
 =?utf-8?B?T2htdlc1TndVbGM4VGRtRklzOVVsK3d5c09wNGVSMm5Lc0RuNFpwa25PMFVT?=
 =?utf-8?B?WHlTMkRrL0xHZkNiSzlTdnFnMjRPQ3hUWU1veDFielhNWEF4WmdpQ01ydnVj?=
 =?utf-8?B?ZnpVUDBKUUlFbmV2cysxMWZKRjVNK2tyMUNoZUJFUmh0VitkcFVHQlQyaEhS?=
 =?utf-8?B?RzVIOVhYVWlXSGVmcklCb0xxamJ6NFFqZHFTK1AyekVZd0R3TUF4dldJQjRT?=
 =?utf-8?B?TzdtajdINzJTVjYzZDQ3U0h1UlJiYnJ0aVZqVEFCQVQzVGsveTJVZFlLd09Z?=
 =?utf-8?B?UWxHTWEyQVg3ZGh3UUhvZDBKSGFoTUtwY3NJd1lRMGNXTFZyWmt5TEVEZytS?=
 =?utf-8?B?cDJQV0hzUFFUbE9qOVR1cklzb1VVcFZSMElYdkJjSXlKblFycFRNZFF2cit5?=
 =?utf-8?B?Uys0RGNOTitiNGVJWGVNV2lkKzBpcUxadnIrajJBQysva0w3NzFidXRlUW8z?=
 =?utf-8?B?b0w4ZGVJYVRzUnR3cVdmZVk3RTBWS2x2QUJUY05rWmhUcmNDbWRlMXE5RzdE?=
 =?utf-8?B?bzh2YzR1ckhsRHNxQktSUXhhdUNOMkUvQUx1VG1QM29YVlJDSEdwN3RXbE1Z?=
 =?utf-8?B?aDQzU2lMaU9VZ0ZrbEp0K2xDYzRJRFUxVGdxYXNrZ2JIUUxyMTNLcDBQSWUv?=
 =?utf-8?B?bjVJVDRRc2tuSTJmZTZHenIxVlg3ekg4UFhaYWcwejZnVUlqNjVDNlp4a0Rs?=
 =?utf-8?B?Z2JzMDU0KytGUlY1OU10b2xKRGd4QnhUWnhpVlVmcUdDSHhWc2wwdHFFNklH?=
 =?utf-8?B?SEF6UXVCM1M1dU1mZGJvREVBR1BVT2RWbWNZRWoyZXZhbHp2eE9jNUoxdmo3?=
 =?utf-8?B?VDVSTnUrUHQzUnhrbFBmb21yQzZxNDEwbGZKRlpDZGR0K0YyMDJXSFNrdGd6?=
 =?utf-8?B?MkxNNmZKUlJ2NjdLWDd3TFdMRytKQ1hmdXZDc29SQjMzU21TdDl5NUVJUUY2?=
 =?utf-8?Q?/z/dxL1LFL8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R292MzRYNXM2bTFIc3lPdlZUdGprRjBvOE1yMGRhbTNkMjZBcHJyWFJid1gr?=
 =?utf-8?B?RFh2b3hIRGJXTDdLUTdVTmxSbk5TQzNiN1RQNC9sdTBGUTlSU3ZnZXMzbmow?=
 =?utf-8?B?NmNRVWNHWmd5TWxRM2J4NjJmQnpza3lXZmd5bm82SlMyWXIxZDZ1N1FGUWNy?=
 =?utf-8?B?U3I1NDByU0xGeXFEWnIzVzkvWVArdDllMWVFUFJjamtoeEhjNWdZNDJOUGZI?=
 =?utf-8?B?WTZzVTJ2YkR1U1Z6MTluMWgvQjNxeVBxRnFmT1VST1ZMa1BNZ09JbjhpVnA2?=
 =?utf-8?B?Y0JCNWRKMGVUSTRNNXVGTXBBbWUzQk5jNk8zMnZDNkdyZ3dEa3VER3B0QXcv?=
 =?utf-8?B?cE5sUmZJVnNYY0hyZmdQcDkybFl4SHIzNzB0Z25EcmlFRy9MSFVNRm5SRlZm?=
 =?utf-8?B?ejN0WThTSTlqWGlveXpERVh0Znk3WVNVQ3dPR2c5Z2JnUFpOK0UzaU9Kdjlt?=
 =?utf-8?B?b0RoMDlINVhWODNNWHM0bGN5UW0vSzQ0YjRVelZLQ0RLNWt4T1h1NFdIaE9z?=
 =?utf-8?B?enFVVHdrUUMwcDVrNmVtNlpCdlZRNmZaSlVxa1AvcVBEdFJzVksxZ0hsMkNX?=
 =?utf-8?B?ZWFsbWpWY1dZeTgwVWw1bDl3dlN4d2dQNnMzWWZaVFpPTWcyd3NOVkduWDNF?=
 =?utf-8?B?Y3Y5VmZ0MUp1Nkx6dlhjc3MzTVNRTjI0YTBMYjkwS2dZRlFoUzJpWExnSU9a?=
 =?utf-8?B?ZklZZFdFbTN0V2Z1RitQWmZpNm1jU1VWVk53VGZVcVkyd29ISG5SUFVsTG8x?=
 =?utf-8?B?dndjZURNMXBFUGxmam52RzJUNlVOY3AyMEVnTlY1c1J5Q3QwN2Q1WUNPQmJC?=
 =?utf-8?B?VDY2WVhBN2RpR2ttNlc5aFU0YVlwREkvSmZDdWU3WXc0bG4reTFIWmpWdXBW?=
 =?utf-8?B?N1VFcjJhNHdaS3FLVkE0TldqMVRrYXlER2x0T3ZNTHRidm5uL3VFWjlFRW5O?=
 =?utf-8?B?amhRdUg2WmZkczRlYThDM3EzUU0vczRFbHI0RG9vMmdJOWxNRnQ1RWhONVk0?=
 =?utf-8?B?Q2l4Ym5aN3dZa3BVU0dUZGd5WW9OOU1aUTUvODdIZmc5U29YcHZ4STdLSjZO?=
 =?utf-8?B?T1JzbER2VmdaV0J3b1p3Q1R1RlZna1lMVWNmaS9yanExbDhHb0VkUWpQeHN4?=
 =?utf-8?B?VG1pa1lWQjBqUTZENnlTTnlHb0dvMklYeFcrTVVRaGl4VTQ0cEZvbVQ4RE9L?=
 =?utf-8?B?eitZSEdGbDI2U3FYTWVnVnN2bFA3UnNXbDBCMlJzOEV5cnpRSVdUS09BNFFl?=
 =?utf-8?B?NVhCVGxSSlFTTUtMR2xJUC9NMkpWakh4ZTdpcDdwazE4dHVYUitXNlU0a0Z6?=
 =?utf-8?B?YW51U0dBY1hOZGdWRStsWFVrVEFuSHkxMktaQWFqTU9YM2Jrc2RqcFVWUjQ5?=
 =?utf-8?B?Vk5nTXlwT2RHMDJlS0ZNMkV5Zm93M1NCVTQ4N1MycjZEbHBrcFJOeS9qV2Qw?=
 =?utf-8?B?V2NvTWNZQkZ1VGhkY2pSY0p2V3Z6OE1VS2FvNHArVGlwVjZXdXlHdXBSTEhH?=
 =?utf-8?B?VjhZVG5NeC9qUXZkbmR6M3hFVUJaeXhEbnJvVkRVOGticjA1TjNXWEpNZERj?=
 =?utf-8?B?ZFVUL2t3eE1WaEo5VERNQ2crS2ZoSzhFR1hLdzRHWWpjRFNqcFBNdENUL3V1?=
 =?utf-8?B?em5Kd3c0c2J5aktnbW1zSXhiYjBoNzFBV0xsNk9GWmZzbVdRQVFseDdZWk80?=
 =?utf-8?B?T3ZZTDR4TDhKUHhzYitGUXNTb2RnTDQvQ1ZDY09CN2l4RDFRZWFnYmJkNUx5?=
 =?utf-8?B?U1o3WjVvQ1RsZHNCRmVPMVg0b2hJQ1k2Rml0a1p1cTBHdkRFQTRVRGVQdlZE?=
 =?utf-8?B?bzJJZUE4VmlJRENYdlBpclZBeHp1aU1tUVljSkxKZFJxbDIzRE5rTzkxUmxL?=
 =?utf-8?B?ZUVHdlZvYXdKZGk1MCtubStPSmZNT241WWovTWRBcE1jZjdFSlVOV0t4UHdD?=
 =?utf-8?B?QWllZnQxRUlmbld4MkxPWjhZSEV6a3NDRGh2dGRvbEd1L2YyNkZVQ2VtUG1J?=
 =?utf-8?B?TGJzdks3Zm1ybEtaSUd3dFdhNjhseW45Y2w3d0ZMN2lDcGFIS3gzdkk0ZjF1?=
 =?utf-8?B?K0hVNXNRWmYxUDhxT0xQTDhvS2Z2SUpwQ0FMdndpczN0SGljS2E4QUtraE91?=
 =?utf-8?B?L0NZMjZHTVlGZ21KYW0xbDR6QUVYQWdFcEx3eDBmQVZLYlRVWmFNVlVQV0NF?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35302478-a4dc-4c3e-7c61-08ddd4ccd665
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 09:37:19.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwaovKmQLuLb3kK0C7UITONutOcT37OqmwTieazgSSLwzMdhaGiZqN6nPCaCNRUAgWoHdCNxkUODe+aEmh1i9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3805
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 09:37:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19692

On 06.08.25 09:26, Nobuhiro Iwamatsu wrote:
> The riscv64 image can be built from 'trixie'. Therefore, set 'release: trixie'
> in the build:qemu-riscv64-test-nokernel pipeline.
> 
> Fixes: 82dc61a44708 ("kas/opt: Add option for not install kernel"
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .gitlab-ci.yml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index a494911..428f479 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -260,6 +260,7 @@ build:qemu-riscv64-test-nokernel:
>      - .build_base
>    variables:
>      target:  qemu-riscv64
> +    release: trixie
>      extension: test
>      no_kernel: enable
>  

I've folded that into 82dc61a44708 - it was still in next, thus could
still be fixed up directly.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

