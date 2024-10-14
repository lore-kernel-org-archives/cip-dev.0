Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CBED18158
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 22:23:04 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.65])
 by mx.groups.io with SMTP id smtpd.web11.175.1728944574692141930
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Oct 2024 15:22:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KtgXauM2;
 spf=pass (domain: siemens.com, ip: 40.107.22.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfxT6YGqolJk+cZeLUT0twjXCBSlEQ4yeGYGENVE397PrFzkDrU4EActD7li2ol8rSTCqfCka/zdhcCHLM/AAkBERbgSFG3zIMQJaOdkF/l7Qre6H47LmfwHvoKjaZAKqhvrPJK+8JaIYox8s/d9mSvo/1+gTOON8PWbi6HAoGjs6w5HefjnQ8y23llAI6Fypc03jxyeIlwddiNEeTp4iqnMieTjvhkJx9f1IT9Wqop6NqcG/iHTDxSxVIMXlGLenJ7eJtcxdYAkqfoIcvFe1uoZsaCnolj3UZ+TUhlqrcZyJM2RWrP11GzJRoGJNCJCzqCpIIsAEFxER8dNK3/Zyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aW+ExESfb2KSbC8JL9xy2Fr4BJvaB/b8sEr1dfDLmwE=;
 b=HUG8nDP0zzbgMKsFJ4PYgAR2lX1P/r/gWYU1YVVq0MB7mxhlgcg7FQkQ7wz+OvfBvP8mOBbwixHpuePargyu8TrFvX6hIwVRtbTfpTCviQUPUaFDRRCySCIHYP0YICk0O5UQkJYp17E8K/A28JqSsX00dy2LdzWmrXT94q4V7Tm3NDdwivyY6x6bF05w6cr+PyYsSpITHGWNRSENyhvzkslJRzc5inJ9aHknotBRFyQtWuh1N0Z4HAy69k740WuhVaUiN0jF7w+WnG8aEH8SDZdEapSpKmH7Uo+ZKu9VVwNf+v4g90ivmI0p/xqcm3KMeoxygVj6MZRu6lHZ4Y60FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aW+ExESfb2KSbC8JL9xy2Fr4BJvaB/b8sEr1dfDLmwE=;
 b=KtgXauM2HdQ4fnZTJtxXcmVJnMp+xmWlmZA9UQmsIxQMJIuhliV9JrQmmb9EY/aAtYj0LIY3wKzcDiaZdPb52ggsIkJL5llESlAxz+idfRrmxBg/FXXOlHh2gSh7UkxOGtf/gz2A4mykj9LxoMmbzZyBCL9j3w+b4JikDSHsdBVgcQ1O3MkdvakjXGdN+KFJgonzoSzsikqnX4LoRv0OFmFzPAdbMrSa7KXl7XPUGakfu3LKN1N1F6ZbHQd0As6EDSUPR97wgtYHXt1Ll0sPEY10K1+C4JeuYc2lqJnYMo1VEP5l17JxvyzXpd/gF0vcXiMvk4mF7YmvECANoUbQiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8630.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16; Mon, 14 Oct
 2024 22:22:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8069.009; Mon, 14 Oct 2024
 22:22:45 +0000
Message-ID: <d59b93d9-44a0-4adf-bb7a-c97d12e1c1b9@siemens.com>
Date: Tue, 15 Oct 2024 00:22:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] distro: add preliminary support for the
 upcoming Debian 13 (trixie)
To: Cedric Hombourger <cedric.hombourger@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20241014155604.569003-1-cedric.hombourger@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241014155604.569003-1-cedric.hombourger@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8630:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf04fc3-3801-4380-5cd5-08dcec9eba67
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Vy9wNURGMWcvRDIzSXpLdWRGRmZsR3BENy90dXlzWVU4dlhCTEZOMjhtbGV5?=
 =?utf-8?B?NGhXR0I1YnJjWE0wWVptVFJrdWZqSiszZjRLWDlwKzhDT0lNbm5CQm9LdC9y?=
 =?utf-8?B?dDFqSHVocWZJUHpIMzNvZzMvekdtZUZ5bUZJK1c2Z1RyTnNRVi9PaUdmUzB0?=
 =?utf-8?B?ekFMMWtKcGhob2JUZTVJSEhNQXRjRWc5c0NPY3dkSkxjMGtGWjhJNmlLbHNV?=
 =?utf-8?B?S2h0QjZsc0JQSHpBU25PMis5YVhMSUltbzVvV3NtcmsydWhwREc4c0cyNlBj?=
 =?utf-8?B?Z1dBS09XUE90NWllQlRBZ05ic3gzMUhvbGxkUlovRWg2bFA0TkhLNnUyc1NN?=
 =?utf-8?B?YUp2aHMrV0xHSlpkTDVBa0NJZkpadHU5Q1FjY1h5L1F3VGd2enBpYTJBeUhT?=
 =?utf-8?B?Z2ZLNVZJUWljd2ZtSW8vdGJMWldEbVNJR0dPNGFxUlpIdGNNckR5L2FmMlhp?=
 =?utf-8?B?VHZFb244NmFpR1lQVHBIVzZwRnJLY1k2aUdWb1NJVHNVMEhjS3FZcVpiVG5h?=
 =?utf-8?B?aytuVnZaZVFVcy83dFJRN0lJNCtKN1BoYTJXQkY5WmtPNnhUblZTNHk5TnVC?=
 =?utf-8?B?KzV1QkxuazN0c1VLVnB3cUV1bDNhRi9hc1czZk9xWFF4N3pYSUVNcE9hNU1B?=
 =?utf-8?B?VVgxTnNhNWI1cnRGd3BydUw5NHoyWGpiU2lneEx3K21UbUxOd1pCVjFlanF6?=
 =?utf-8?B?dVdONG0xVzNlZ00wV0NyUzNKcVlwVDRmQ1RQeVRFRzd4U1U3MGFXSlZ6NjFT?=
 =?utf-8?B?Y0ladUZzVWxsWUFwSkpna05pNklhNnBld3l0OUcwZjMzZVlWTzVSQU9SZGlB?=
 =?utf-8?B?VU9YNEx1MXBLTmJRMDlnZDhUb0dLOThJUlBOUjF5blBUeWVPN3VyUkNrQmxV?=
 =?utf-8?B?a3Mwa01XTWJYaFVQMUxQY2w1OXRUSTl5TGY2bGhRVHh3Rkdrb0xOa0RRS0pm?=
 =?utf-8?B?cWVXWjNTY01VOFJTVlplSHNsMURzV3BnTDZpTU5iMlJPWmxwWmNkUldrbCtJ?=
 =?utf-8?B?cGFLM213amZSejFLVXd1anQwRWFxUGozRDRsOHpTWUtCaThPRmlRYkJhMnha?=
 =?utf-8?B?VjZ0eHF3TWJtQnBrRnVEVWlsQlFhVTUySVFEVHF4dExlL1QxRzF0WjhQUXE1?=
 =?utf-8?B?dUhaY25SMDBXTkFPOEV1VW5WRVlWSmp6bFgvM2FrellEeThnWjF0aENYTW1x?=
 =?utf-8?B?T1g5bmk0MENVdUNhampOYThadkxYRXNBdk8yOERJdzJVcldpQVo2VEVjVDJZ?=
 =?utf-8?B?N21lOGxna1R6THZhVElpQzNJQk9vWjJWZHFGa3B3SEJodnhNZFpTc0wyL0FC?=
 =?utf-8?B?dTY3RFJkM3BpQTE1SlIwRU1WYXVwWXFicGdwdHIra1BHSTh5SUd2OWJic1JW?=
 =?utf-8?B?UmYvY1JMWHBDSVovU2NzUkY5aW5WaHFEek5DNEQwQkhjK3Y4VGl2VzhYM3RB?=
 =?utf-8?B?STFwa3Y0Tkp3bjlUQm1MaW1PR3gwUG5KRjJBZzVHWUUyaEVWbS9kL3RSZDVS?=
 =?utf-8?B?OGhkbUc0ZTNpOU5FVVBQK0o0ZlppTkIvTEJlVWNjSlRURjVCTlh3Q2V1Y0FD?=
 =?utf-8?B?ZGVadVVMTlErVkFWQ0duWkVSRU9iajlySVFGZkozUGovVTFKZy9kSnRMYjc5?=
 =?utf-8?B?dnRQUit4cjYrQm1GSjVRMFdsQlQ1MDBUd0NSKzE1T3AvVG81bFlMaEdQL3VK?=
 =?utf-8?B?bm5oaWVndGFPOXVPUDFuN2JnUnp2aGR6dC9xT0J4cjlWQlM4VjVIQkdBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eUJmRGMzS1JHSlZyanFQRTZCYkhsZWUxNlhLTVdaWnZUYW1ISVJISThoWlZF?=
 =?utf-8?B?cXNJVzVGaDhUVGRXQVkyZXF6MUpUWDNFdExWVklYeEJMZlllZVUrd04valBB?=
 =?utf-8?B?Ujd6N3JBR2tTUjREU2xWMUd1dkg5SHkzN29NaW9WVXl0SFQ1NU1iTzQ5S1ph?=
 =?utf-8?B?UllybnNuOVFYQTB2elgxK001dnR3SGtScGtIc3owS3p3UEZWZ0JsQStnMzNw?=
 =?utf-8?B?MW5qSnhzTHoyVDBEanRQb3pJY0JGUVhKMENFTVQyQlVpSTA5aUpUdS81Q2Mv?=
 =?utf-8?B?V09adW5ReUxCS0dXZHA5OHlwYlFLSmxWTVpycDVNSHFsN0xlaGMvZzR4d0Fy?=
 =?utf-8?B?MGd4eUVVSzNuTmcydjlqUGphYXR3bWg1RjFNMVVuU0hJeDlia0Zob3kyRXRx?=
 =?utf-8?B?c3pYYndzeXkxamV1WlFPRGhycjdYcTlvUDlVMTV0Wm9CZmwwR0ZvMFFUSTBM?=
 =?utf-8?B?WUhmcXFjVit6YlZyVUZiL1p3a05VemNLZ1JFTnFRcUlvcXF6UlczVEoxNmx0?=
 =?utf-8?B?OXBiamVVMnVrMDhqK01XcDVrYmN4L3ZpVHlhU3Fsa2hLcjliZ3d4ZHVYTGZC?=
 =?utf-8?B?V0Z6L2dNZkZYSS81OFhOMzB6cDFMYjc2bVh0VE1STlM1amdRZUw4L2ZZQStt?=
 =?utf-8?B?d2hsL080NlgvOTk1UWMreGo1UUhWcE1aWlNwQmV1bnVHOTFHM3VQYjVGTmht?=
 =?utf-8?B?MWMweDlpUXdRaS9zUkVTdHREOWp5ZCtJd2lBNGV5M3FxK0c5bUI4YTVlOXJw?=
 =?utf-8?B?aS90c2lKRTU3dVcwN3JYNkF0TmlMNkp6aG9meFE3aEsxdHU2WjdXYU9GVzRW?=
 =?utf-8?B?amtLZUhkeTJadXlNVENiZVpyODBtZ3lpWmRrdjhDS2F5THZuRjNuNWxOZU9B?=
 =?utf-8?B?U09EQWZZY005REtzQmJyWmgrdEM5akJseFJDc0NVMWRZdk51Zkp1L3RGdHBN?=
 =?utf-8?B?OWNtSkRmbmM3MUVVQzJ4SzNqcmVDWml4MWxncWQvem5QdVdOK2dKOGttZk5S?=
 =?utf-8?B?d0RmYjJ3Z0dsS1ZOSDFMN3JXVjBXbHpqMVlOa1pTcVNIeVlxWVNvaTlOS000?=
 =?utf-8?B?MzZEOW51eGpIL1h2bXNCN1dGeUNkNmZvODlqZU0vMnc0ODY0SzhmQThyYjdZ?=
 =?utf-8?B?MzU4WTk0cDJMWEJrdXZlWmtUZkFldWUrdFptVDhPUFRMQVFnSzBTRnEzY3JB?=
 =?utf-8?B?YVFJbFRoWUJiZzljV0Nnc080dzBsc0dQZmpJZmVtd28rQ3FHeUx3Zm1CMS81?=
 =?utf-8?B?M2dBUytld0RtM1NOVE1XRkU0eUFnWHUxaks3U2UvWjJqVzIxK291WWZmRXFG?=
 =?utf-8?B?ZDJtcXRuNVhrRGczUVlDQmYyajd6SGRXWkY1ZW12Q1dENmJVWTVBNkJhODB3?=
 =?utf-8?B?ZlFTdmxMcUZkcTFnOXcyRnZHQ040V3o5dUdsUk0yRXBiL2JWSytya1kyT1Bx?=
 =?utf-8?B?TXdtazdXR3FjeUoyaWM2UGFIeGNOQTEra0dKbUV0LzNHdlFnaU1weitRWi9T?=
 =?utf-8?B?ZDNUNXNzSmNXaTVDRmt6RTZTbHV0T1ZYbWNqRGRsLzVJZE8wMG53VWFMY2Ev?=
 =?utf-8?B?dksrd3pNSTAzbW5lVG1rMWc1TmR6dmdNcEtueGwzS1g5bHAvbnoyVTZ0SGJI?=
 =?utf-8?B?U2NUbzA3WUFudlJRZFB4MHh0dEVYdVhwYlFoeXdvY2RUeTZUVWRMbHdIVjhH?=
 =?utf-8?B?NVhtdkxEOXlreXRvaE9Bc2c4L1NINmdPMXc1MzV3NWU5SHd4L0FVMTEybUEx?=
 =?utf-8?B?eGFPaVNLMzVqNHhRM1JaaElwbUFnQ2hOMVBkbTVjNXV4QnhOdno0Y2xSNFZJ?=
 =?utf-8?B?OHAySVhBV0JoMUhnNTNlT3E2ZWRramw0ZUxGWDJUaVo4RUFjUzRMVlB6THZ2?=
 =?utf-8?B?SDdZeXFtWEhVUjhsQVB2Q0xYYXptbjQwV2VMWFI0RXhNUDhNRXNWV2lZT1RF?=
 =?utf-8?B?bFlJMmtsUkR3MjYyRlgxWmlwVHc3OTRLZGlwRllSVGVJNExGalNBOUYxU0F4?=
 =?utf-8?B?ajdQRmxQU0JwZXFJYWJqME90a0xVejF1NUhja04wVXFkQTFPV1JBMjdZWW1p?=
 =?utf-8?B?M2Y5Sm5JdWFHUFdpQmVZZkIrcGJ2MWtlcFNyNjdRV1NVTjJmMVNOdFZsR01a?=
 =?utf-8?Q?UVsd4iVvMTf1lmILg94cxag21?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf04fc3-3801-4380-5cd5-08dcec9eba67
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 22:22:45.7377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyvDjKL7rqv1+O0gpOO7y2wh/UApuxT8cHtAeskJQMHWLM6kKWakp0MnYlHFzpDRd/RmujkaBjVbirFTufKGFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8630
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Oct 2024 22:23:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17037

On 14.10.24 17:56, Cedric Hombourger wrote:
> Debian will probably start freezing packages next year (first a soft freeze
> then a hard freeze). It is important that the CIP community starts testing
> Debian 13 to provide feedback upstream while we may still influence versions
> that the distribution will select for their new major version.
> 
> Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
> ---
>  Kconfig                                          |  5 +++++
>  conf/distro/cip-core-trixie.conf                 | 16 ++++++++++++++++
>  kas/opt/trixie.yml                               | 15 +++++++++++++++
>  .../secure-boot-secrets/files/trixie             |  1 +
>  .../swupdate-certificates/files/trixie           |  1 +
>  5 files changed, 38 insertions(+)
>  create mode 100644 conf/distro/cip-core-trixie.conf
>  create mode 100644 kas/opt/trixie.yml
>  create mode 120000 recipes-devtools/secure-boot-secrets/files/trixie
>  create mode 120000 recipes-devtools/swupdate-certificates/files/trixie
> 
> diff --git a/Kconfig b/Kconfig
> index a70ce22..9b15c05 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -136,6 +136,10 @@ config DEBIAN_BOOKWORM
>  	bool "bookworm (12)"
>  	depends on !ARCH_RISCV64
>  
> +config DEBIAN_TRIXIE
> +	bool "trixie (testing)"
> +	depends on !ARCH_RISCV64

That is obsolete once trixie is stable enough. In fact, being able to
finally build RISC-V via trixie, rather than a sid snapshot, would be a
good indicator that it is worth to start regular testing.

> +
>  config DEBIAN_SID
>  	bool "sid (unstable)"
>  	depends on ARCH_RISCV64
> @@ -147,6 +151,7 @@ config KAS_INCLUDE_DEBIAN
>  	default "kas/opt/buster.yml" if DEBIAN_BUSTER
>  	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
>  	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
> +	default "kas/opt/trixie.yml" if DEBIAN_TRIXIE
>  	default "kas/opt/sid.yml" if DEBIAN_SID
>  
>  comment "Image features"
> diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
> new file mode 100644
> index 0000000..58999d1
> --- /dev/null
> +++ b/conf/distro/cip-core-trixie.conf
> @@ -0,0 +1,16 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Cedric Hombourger <cedric.hombourger@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require conf/distro/debian-trixie.conf
> +require cip-core-common.inc
> +
> +PREFERRED_VERSION_linux-cip ?= "6.1.%"
> +PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"

That will likely change before the release but we indeed started with an
older kernel into bookworm as well.

> diff --git a/kas/opt/trixie.yml b/kas/opt/trixie.yml
> new file mode 100644
> index 0000000..e9a76ef
> --- /dev/null
> +++ b/kas/opt/trixie.yml
> @@ -0,0 +1,15 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Cedric Hombourger <cedric.hombourger@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +distro: cip-core-trixie
> diff --git a/recipes-devtools/secure-boot-secrets/files/trixie b/recipes-devtools/secure-boot-secrets/files/trixie
> new file mode 120000
> index 0000000..91bf492
> --- /dev/null
> +++ b/recipes-devtools/secure-boot-secrets/files/trixie
> @@ -0,0 +1 @@
> +bullseye
> \ No newline at end of file
> diff --git a/recipes-devtools/swupdate-certificates/files/trixie b/recipes-devtools/swupdate-certificates/files/trixie
> new file mode 120000
> index 0000000..3d633ae
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/files/trixie
> @@ -0,0 +1 @@
> +../../secure-boot-secrets/files/trixie
> \ No newline at end of file

As Florian already mentioned, some minimal cross-compilation stability
is required as we cannot wait for hours on emulated native builds. There
is also [1] waiting for a fix so that our core features can be tested.
And there might be more.

Jan

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/114

-- 
Siemens AG, Technology
Linux Expert Center

