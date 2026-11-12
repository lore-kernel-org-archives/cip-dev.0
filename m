Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.14])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1543.1794503518538147585
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 09:11:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QVXCY7E/;
 spf=pass (domain: siemens.com, ip: 40.107.130.14, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAMJEF9iTTeZm7ogB5KyoG39dfzD+90vqgtFxzZDNtDh09j0Nenh2KfJffILEeA5leL1lB7SmZzuvL7oVhESPfHynDrskfKK9toJg6jQPUCJFxC6VdzI76MsP4q/qNznrUaTYIzE3gYWmkDih81DDhO+pc0N9zqpIyJHZXambCL1rlHYeGH3hNG1X7FIoWXBOeccfxn3f0As08IznFiY1nGKSkg925QwSPS/fX2diwvYT6TD+DfGmMZmghwkEGkKC57tNpw6gTeTrmbeQfkrqXN4G5ZuQeUKSD6O3I925FREWMKqI3ZlZZfPsZTqVv8Rn+UF6WMooWE1FWNBHLU6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejfMZ6TLZPYvfmwCYsaL0BAXc38q7iO/EhJMpFQJAts=;
 b=Wr6PmTpoOcb7a0X67MG0wWvnJWUUy5BkWlJdIhGzrqO2E/aSrMR+Y59Ryg57ebbqsdWJa14WzwZ04MXubZDOW0R38ebSSZir3S0nXcDbcqTcneEdgMOC0P28hQxB/n8Jbgl6ikAuA3dHlUkvWvNJMcHa+haRmC9xT6wmnjxgSbjmFucmfF6xKEw5kpsOAP/gWUdHzkUQrL+9V8StqfYp0HzCuNQQTglxxJ6W8SU5y/7ISIDLx5mQ2BR5XHkeQlxg2drt7VKthDMHu3DgwxOZ6wq3onwoLMwmtJk9whLdpKDi6HYEMXW+B/DyMgFk6v68AEWvp2Z1C8c1Gg/Ncafd2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejfMZ6TLZPYvfmwCYsaL0BAXc38q7iO/EhJMpFQJAts=;
 b=QVXCY7E/ZYl8a7upwCALepT0UNj2uGJDuWQc11PlC6i46LXHhkJScN+A8A8IVnTwVLMftAaWFFWJAhCmgZtUVvRrKNu9EMu7cOo1m732+WQvWz8QO70skoAhLyASdSzOXDFpPXIkvixZXjxgefbvITj7Vy4WrYA1D74bey3YdeBnjrIU2V5jYv7PesLiiA4HJmBY23tsGuROehs0FB4GsjpZjQH4ZZKUcvTLOaTNvhLDjj19RzftQnshR0Wb0Op4Jia8DvA6C9L89b4QbXiOUKjteUBtl2rHrE58wnFW3L1Tyy30CGeDzIXVyUQeLl0YMz5SQu+QpzXCx8EOh7Xmxg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB8PR10MB3767.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:167::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 17:11:54 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 17:11:54 +0000
Message-ID: <1fb0fb2a-2a16-440d-ba95-ede59d20e850@siemens.com>
Date: Thu, 12 Nov 2026 18:11:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isa-cip-core][PATCH v3 8/8] Kconfg: Add '!TARGET_TI_AM62PX_SK'
 to the dependencies for 'buster'.
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
Cc: cip-dev@lists.cip-project.org
References: <1794466758-28304-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1794466758-28304-9-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1794466758-28304-9-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:208:36e::24) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB8PR10MB3767:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a21af9-b7f8-4263-08a8-08df40e00ce0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|4143699003|6133799003|10067099003|261028144727099003|261026140227099003|261021123027099003|261102123227099003|261022105027099003|261021121427099003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: /fm5OGInpynq+OGe8EJ2OUMJggDdmNDd+LebIFap+FjgC/qU7jwQI3kuEwLU8ujA0P/gz7sTF+sncwWZ0lSq28hmN7IPBH/IxcM8JS2x/w434ZPvA5yfoo8vqyXA46/Be3FjSnNixZbz18PNcpfCk0vO9wQdlGlCv7PanYvSb4XEQVliz4IDFnRAiiIMg1r/2+2VZop2kmPOTZEQ1GJqxhN30D3GudXKZSi2W54wumNhWGgEdkuk1c65/vKXSgzmQUnyvoO6/if8TWtf42GAlmQAErjbfwHn1QLUgjunAF5b2r8rF+pL9eus2oMrFy3UtgwG/scW3C/flojfZ4I1aeEheO5AysUNRsG08lTFk8l891L+EOngkv5Wi1PKzPc1HcsgC9Msc7BBxc8h6x04B3kd9Kc6b9QAimGeHHdAz7E72Auxsdo0Sf8fvXRrCChaVGVeVr5PMZaV6b9MKniT6fynCCFNA3onhtTQ/SuyVHdhPx8lmyPe2znwsxYo4168NpwtxcD2i92WYUXzjpTQnGROvUsu+rcj4W5mPjJ6/Fxr3UvRWIVpR3+DNvKwzX/9UHfY0GgUHOoR63TLhrHbZOYuahL6n6hBI/wkRDNxjbrnha63fGuEOJlcbZ7uv3JsWfHOjSXKqoiAh7IUlW/Y7ayTaS6rYexubMnMxwq11Iw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(4143699003)(6133799003)(10067099003)(261028144727099003)(261026140227099003)(261021123027099003)(261102123227099003)(261022105027099003)(261021121427099003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE5sS1Zkd1FVN3pGMW9mdjJYN2tjcEEwdXFxVDBqWDJHcXNzTUxQNzVJN3Qx?=
 =?utf-8?B?Z3VmUTRTMnZaYnovOGdHUTFVSHpyNVR2TjJPZTJvLytUdWhBekdtTkRsdXhz?=
 =?utf-8?B?SkZhNmsyeGJENXBIQlgxbUJ4TGxRWGdzUVZlWWJLaitta1lqbDRDeHFoR0l1?=
 =?utf-8?B?RmJkWjcwSFhnaUV5Qk1zR3ZUWTBDSG1LNDJ3bUdXdkpYcTg5YlRDb1hRdEI4?=
 =?utf-8?B?MXVVbFB3b3dMUFFXS25GNUo4Vy9OZjNwemluLzVqWEx6RVljR2ZNa3Q5NkRL?=
 =?utf-8?B?Zlp0VUszeVZvK3VmL1o2b2VyTThBNG0zTzNWejNmVVlGNmp2aW9Ua0tuQzlX?=
 =?utf-8?B?QmlERHlZd0RqTXV3Zy81Si9hbVJvSEMwWmg3SWc5eUNaRGZUQzQ0OXRuOEsw?=
 =?utf-8?B?N29wbTlmYWdyTUgzREJTa2dBT1BZY2o2aEVZakNCYS9pbzBycmMyU3ZkVmd4?=
 =?utf-8?B?ZnU3MUpYWWhVL2tlYmdqMlpjYXV4ZndnZVhoZm81cTNrUm9OVTlLYTVYbUpM?=
 =?utf-8?B?VUlXRDlQZkpMRDRHQXNOaFM1aGIrRUJPVnQ2TEdueTdvSGJuNnVqcWI0bkpt?=
 =?utf-8?B?MFg5YktsRHNTZzNHZ2tsWDRxSjNyYVZQMFZIRmM0ck9tc3ZTT1FIN0JYVTBy?=
 =?utf-8?B?eDI1SkJkMjlkVXkzMVNFUm5WUWpEd3B2aWtMMk9MelQ1bU5OdGF4Zi9WelN1?=
 =?utf-8?B?MHlINXYybE5kUlB6dXVCNW9MbUc3MnBjUjgxSUoyK252VnJiQVVvMm9UN2hG?=
 =?utf-8?B?NmJucVhoTU9kWEFCemRKZ1VjUDI3YWpxVkdPT0NWcDBCRHdoVHJSU2lQNWdT?=
 =?utf-8?B?ZDJ4UDlSYmUrdTlFdk41ckxxbWgvMC8yWFRMYWpyTDhzQ2w1YmdGTzZnLzJZ?=
 =?utf-8?B?SFJIb3N0aCtPc3JYdlkwRWlsUi9pR1E4SjgyUUdReEdDTUlvSGoraXFCSEVR?=
 =?utf-8?B?dncvZG9LaHF2S2VBampyc0daMXlBeG84cXpjUmZBVzA3ZUV0WXNJTmM0Njg4?=
 =?utf-8?B?TVgyYjhyQWo0SkxkZjJYaUhyT3loNklaRmxRMlNJaUJySkRHRlJDazZBU1ZS?=
 =?utf-8?B?bkR1UnBMM2pVay94VUJzakZBYVkzMlBqNmRySGo2N0tReXg5Z3dvcTV2U0xH?=
 =?utf-8?B?MEdjMVMxcisrbURyLytOa2EwS2g3dW81SVZJYnhwVEcySUdIR2FVNTdjR2NX?=
 =?utf-8?B?Yy9IcmhjbTEwR3V3OEF4SHpzbEpLRGZvUUdiaXpORWE0bzRNOXdUZU9VMDZY?=
 =?utf-8?B?OHVhOWgrbnUvMFRJL1l2S1VZc1NHSkdxUTVyMFV2WXY1cTA1VWowTUxSd2Vz?=
 =?utf-8?B?Nk1oWXFyY1pnTTBxcy9Gd2JUYzhUVndMcXA5blIybGp0bWlvekNTblIxcEhw?=
 =?utf-8?B?a3FaR21tTllYUm5zUGZEcHRCTWw2NGphb3FwWnkvWVhyN09sc1UycklDdUI4?=
 =?utf-8?B?SmQ0b3ZLMVNjY1FIN1ZkLzMwclZUQllnWGhVOWloT2VuWVRrYVR1aHhnYStQ?=
 =?utf-8?B?bC9PbGoySUN5YVdqZDV2ak9Nb0hTUXJObllXQkM1MmpHUDh4WC9BcE9rU2pE?=
 =?utf-8?B?K1hYVUVJRWJqOGdjQk94S2lHaEZQQzQ0UDZ1WjVXVWtpYUV4NXB5RmtYQktF?=
 =?utf-8?B?aUdnY0xjUTBFdStDeGR3Ni9LeG9SQnBURVhQRUhpU1lWYUE1ejNwcCt6dnhq?=
 =?utf-8?B?cnliNCtYL0hvbXVrMjhBZ05MTEkwMWREN2hHQzQwV2s5UVFBanhON2VPamZa?=
 =?utf-8?B?NkRvRlRac2lTMkxNVXNLR0ZxNDkwZERpM1FOT1h0dk4xZkFabGNDRy9DczZN?=
 =?utf-8?B?UFA1WWI1a0dwOW9XRmtZKzhIaHgwMm5hVTBjc1FTNDhVVk5pY0xoWUswMlBE?=
 =?utf-8?B?YjErNWxacHdjV29iSElCUUVZdkNyQnZ3UnhsVE52Q0xOZUxiQzZaR0g0YnVZ?=
 =?utf-8?B?cXA0SnlCUXFPVzZJV2RhYmtXZzJmYi8xaWpRQXI4L0VuLzE3R2lUZ29wT0Rj?=
 =?utf-8?B?b2pDdm5aN3BVTS9MblFjQ1pSbGZ1LzVEeXVLMm04QjlrYVNNaVVMYVpyVTFx?=
 =?utf-8?B?SWNodnFkYW5YZTVOc2d6eUg4V2RrTGVQMzNibUlGa0x4L0tGSnRMb3dnTUFt?=
 =?utf-8?B?ZldxbkVxZm5HdlUycjRwRDZxb1FqdldENW1oZ0JmN0xlVW5yRVJmZ3B6SE11?=
 =?utf-8?B?ejlyR0FFWGtMNU1iQnJab0gvc0dCY1FnenJFZDhMY21VNmJycDRSbitMWitj?=
 =?utf-8?B?bTdnQmN6dkNmM2l1c2tJb2Q1QURvZ3FrQXphWFZmalpGaVZsSkhvaG9mN2Yw?=
 =?utf-8?B?dGxqeTR4cTVvMmhRL2owTzRXc0g5LzQvMGRYY3BYWWtURFVsZmY3UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a21af9-b7f8-4263-08a8-08df40e00ce0
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 17:11:54.3483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2HgrmADLcfsSImw1OeIwMt3PtQesNhHBF38tBLJN/hDWYIupzAgM5o0Cyyp1SlzNOuagSgZKOwhMYN/Tnc/ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3767
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 17:12:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24788

On 12.11.26 07:59, Nobuhiro Iwamatsu wrote:
> Since U-Boot for AM62Px SK is not supported on 'buster', this adds
> '!TARGET_TI_AM62PX_SK' to the dependencies.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> ---
> 
> v3:
>   new patch.
> 
>  Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Kconfig b/Kconfig
> index 163813b..23e5d01 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -232,7 +232,7 @@ choice
>  
>  config DEBIAN_BUSTER
>  	bool "buster (10)"
> -	depends on !ARCH_RISCV64
> +	depends on !ARCH_RISCV64 && !TARGET_TI_AM62PX_SK
>  
>  config DEBIAN_BULLSEYE
>  	bool "bullseye (11)"

I wonder if there is a need to allow builds older than trixie for this
board. Sai?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
