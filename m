Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EB5C5CFEB
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 14:15:43 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20122.1786630541004165862
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 07:15:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kLQsHjIs;
 spf=pass (domain: siemens.com, ip: 40.107.159.1, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qa1bwOhUEoVh+d+16keJCHg9ZsaDDz6TCn+C6PKOugxXyJ9z0f49KpqVDOC5PrIQI4fFCo0Njm3M9Q9CszVuvnyXCml0IUrP2XZGXm5X8si8hoDtbP6UoH4CsgdVF40Bj8OpZ8+YcJD8yR4Uz0sJAiNpZURQBui3MmYZAs3ellQU+PftdOl6VE8TzniCt8W2ktkRoTQw/UsKTYAeBpsb4MwFeDaIUyNfMhd/1o0y7mK44u0OdApuGcOL0g/19IUvHLQC9mBfnF5cfedZlNfW0Pc973JETuU8cBhwJqouL4T6VQ48nj5q35Muco+Lm2aqQ4nrLJsiJSLMd84+v0rLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0zZ6dR8Hwmhnfr5aQQLbFWEVaL8DDsTX6Q8eVF/Koc=;
 b=klyR9g7YUeNzN/TLQWEMUs75dJKvopIcfHJSbTz7yFxehO9YqoLdnv434Lyezus1pju9EhrqOiF2IkAjZGuo5M9aXWEPzFDgEEbl0G5mcga2gb3InapivITRZSlVA4+xtXDqfS/X87CCWMeiyU4ZPG95Nnzj3uyAilQn4mM8fkhlemKDfT5f5CvCaWszcvnNWCj4iuMveANG4a61r4or6ZGVzbPoL2WsHxaFCZN/Yh+EV1WGz7q7s26PxNDzjkgnvwE5WiW5Wxo5D0aF7fdTSieCV7CzJ6wC433+X6C1yDndOPU+APStUk4EICVvSpZn6SzKN5kICIseQiWwV2p0pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0zZ6dR8Hwmhnfr5aQQLbFWEVaL8DDsTX6Q8eVF/Koc=;
 b=kLQsHjIs8Y3YFN4M+XSkf1Ob0f9RU97tO41SVfjRxdTDphmM4Ts6b6H+oMK999M2Bu23NoYRIiYz4jyitdTZNE+ZdC/7BbWAoyQ3js/B2HCBLVGJiW79IFIu6t2msRhc5HNG6fCciF1iGZZkY4jfMJtoGNNOJE50pTuChI30kvaR8fiZvTh1sDxCJWPE7AdL2CjdxzaqbxJL8E0T7yalIJHxJIFoRiDO6NB9/uu2cszkVrCwAskqDWYZlIlAeQWlDuCWQ0WNqD/tz3j7HCFFMA2kpk8pJn1+OepitfLq273QL/5NZlW0tg76ItItAAiIsgX4/xXg8xDuWAkVmeT0FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 14:15:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 14:15:36 +0000
Message-ID: <a14d818d-2cf6-45cc-9b10-8287842bfc9e@siemens.com>
Date: Thu, 13 Aug 2026 16:15:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] recipes-core: ltp: add python3 and jq
 runtime dependencies
To: Gourav Singh <gouravsingh@siemens.com>, cip-dev@lists.cip-project.org
References: <20260813125157.877874-1-gouravsingh@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260813125157.877874-1-gouravsingh@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0407.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3261:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e29dd87-2207-48cb-3a4d-08def945582c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|22082099003|55112099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	tN/I28AdSsEO1T5H9AFVoKSYAC6NfxoNaXIf8+YJ1u64+miiGp0aLe6adkkal+pG7cwSc0i+R/xIo0ykS0D85uNMRPS0VbMXUgGXiTOqbeh6ljp9iBS20RrLUfeEiZERoFRVjClkJ8VSnHUcpGSV4utEf3mfxogd41/JpCcBd5yrCp8p3mDtv9v8V3QBxeHAjSv2Y40tJcM2aI1qO6lvEIQR1P3Vkmj60tpCQ/KzkRQ4axWJkaPP12hTVNiwYvksayxdHzBtFrs+C86Wjsx/yBHntHesz+nszgsiuKufsurwFTyEc8IMk+ppF+DTwpzsC4NqbMQt2vG8Vp12pGQyOOUX7qVkaOGCIC44nMqpFbKDhxF+9ThmkgGsQq5XYWODrQ+TdRXJH9P8tmk76oIrNT/XIUydDEICSZSNUlvTieGTMIH0RDY+yY77B0DYmxRysjkIYa7X32oi7mRbA0swDsluTE1wPGbw/PbnzdGVIe6ifN5t1wME1W6yi7B+U5W24eZkP4Is39z37OJKWE3bKmUOVFzSqj/wORkhVHWTPpkN76lIblnP1vshT2T/CipJ1ijJ0VqzkjOQt2hxrIddiHjy3wLGhn4PsLOR1Pr/m1o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(55112099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dnA1YlJJSGRyYW5XR25TK0dKL0JKTU14dkNhRjNhY0hNS0lPUlFSbGR3VDhV?=
 =?utf-8?B?d3ArZWxqb2tHbWZBWVdKaUhpWkVKSVd2QmFTbnBOU1RyQ0ZIUWErcENrZGYr?=
 =?utf-8?B?TWwxdWVhNUdicG55aHdtMjZ6M2N5bXBCbm1CUm5xTE44cjZ1YmZ6b1o2Mkhy?=
 =?utf-8?B?UlNzbmdmL2tseTh0NjFBNnJGV2VJQzMyMDNwS0dUK0VkMWwvdFpBSnhpTFdY?=
 =?utf-8?B?bnQ5WFkvU29CR2dyemszNFljVUtyWU5wUjlyY2I1OTM1RVliaWdiSzg5Y1N2?=
 =?utf-8?B?UTdyTkpOVmt6OWxhbnRYcndWanMyYVRHQWZ5b2FKMFFkVVc5WDFSYVFYQjBD?=
 =?utf-8?B?NmxkbmJsT2JCUG1tckYrWjlWOVBDWXQzTWdwT0lXYmNTNklwTWdaR05Za0lV?=
 =?utf-8?B?LzA1ZDZvT3dvd25hRGNEL0o4eXNJWXcyRzJGMjZib3R2NFNrRk5IaEZNWTFv?=
 =?utf-8?B?cWRmWDQ0V29tTnROUTlzUGd6ajRWTnRGcUpoWEo1bDJMR1FsOFJVWDVFQS82?=
 =?utf-8?B?UWdwRWZjRC9vOGdZcE5OM3ZNQUx4MVhZVGZraEs1TW8rZktlcHY5emI3Q3Mr?=
 =?utf-8?B?bmFrZEZQWk1SamExYXNNR0QvbFRsRnhRMEppaGVLd0x0WEdyQkFTcGIwOFBM?=
 =?utf-8?B?OXdndkFxSzZSR0w4TkY2dkszN3ZTc1dIKzNJbG9HL3lscEIvQlVIYmZkUEFi?=
 =?utf-8?B?d3RvZ1Q4MzY4djN1V0dhNTdwR2l0RGFraWttKytndWZUTUg4V0ZUOE4vTVpj?=
 =?utf-8?B?UzZCTnpQQW5TbEVHYU5ON1BBSXdJMkxneWliN3VIK0F4dGlpZVlxTlU1YWxL?=
 =?utf-8?B?UFErTHNkYWdyNlRONFBZcWY1Mk90OHljd0IrSzk4eGRLdGpCYWx3dm9SY0hn?=
 =?utf-8?B?Ym9GV1NEdTJBaHBidysyTEFCa1d3a1loWGdRVDh1Sy92M2hVSVJHM016Ym1I?=
 =?utf-8?B?N2ZXUmNOSkR3RVRjMjNXV0UxbmJnckpsUXlYV0lsSDNpUkZoNDZEeERsQTQy?=
 =?utf-8?B?R21zL2hTbWE2VnRkeFBoSkhLdldhdHMrU3hFTktZNmkyTDg3QTZKUkVWSExI?=
 =?utf-8?B?TFFBdEFmVkM3bFdaRmFrUU82UmhPRlJCQjBIVEN0MC9NRVFtaFRLdkcwSVlr?=
 =?utf-8?B?T1liMjBSS3gxNnFCTitQMFVxMElUdk1reWF1R1orekowc3lEZXRyK0I5N2Zh?=
 =?utf-8?B?cld3cmxFUGViS0FTRWt3S1MvQ0RTbzgzTDc5MkpTakxHYlNsSUtFcTVsYXNQ?=
 =?utf-8?B?U0lsM2lnZHptQWRaNVFBQ3FQRVlENFlqYk5MaFBpYzNFd2NmK3lUUWlLZ2J6?=
 =?utf-8?B?ZitvRDFJNmRMcjlldFpPU3d2OENHSWZjS0twTVplOFBJMlFHWFNGRlJob0dB?=
 =?utf-8?B?MSsxZ0NqUitkNmtXR3hDd0tpWGV5WG9EdTFIL3VsN3M2N0ZlOS81TllWZG5J?=
 =?utf-8?B?QjAzbVNKNmhtUlpIU1VxeGFPU0FIZlRwLzRJK0l5dFcvVkh3T3BXUDk4WUVC?=
 =?utf-8?B?RWJQVW8yU1lpSHY3YStFZ1BMZ3lJMThNdU5UMnhpVUZWVjNuZjdLenQ3Uy82?=
 =?utf-8?B?eklrckxab3NzUnZNT09ORGFaajdocHFwVERhWEVYdlQ4cCs5T3JDaGxBTUFn?=
 =?utf-8?B?L2tyYWJJVkRBUGZYN2o2TzlIb1dIMi82dGtJSFBTaEtaNWFwcUs1VlZMMzRB?=
 =?utf-8?B?Slp0a1pnUDdTWC9HL2NIZEpnRWtSV2l4QmZTamVDUVgyZ1l4UzhHQTVPdmto?=
 =?utf-8?B?Y05qK2xML3FPdGN2Rk1ia2NMVXUxUllpQWY3ZnJzSUhzeEFvV2Nrbm9BK2Ro?=
 =?utf-8?B?eXRrN2h2YW5ycWhCOFQrK3I2alFxQnZScFlZazk5bEI4RjJCOHJCVHN5elhY?=
 =?utf-8?B?YzRxOHVNQ05QWCtpZDM4VXNicWlsRC9hS2FGSEJKRUJ6dlRrZEJTU1IzUU5D?=
 =?utf-8?B?WmhCZkZuancvM2IyNDBnTXY5TFJKRWRBaFhoc20ycG92N2ZZYnRpc1ZZejlm?=
 =?utf-8?B?dU1GSUVzb2RxKzRkSUk5NllUZ0Y3REFOSkxGamhEUHVJNmNDSUs2czBEdUE1?=
 =?utf-8?B?T2xVaGRzN3JOY1hUZW0yZEc3WEZ2UmdLa2ZDWGVJV0pneEpuaHMvMlEra0tQ?=
 =?utf-8?B?OHZBejg2V3JwN2liQzZjYnpBZmpwd1A0ME1INExoVkplT2JocTBQdzBnaDdR?=
 =?utf-8?B?L2JTOE14SWxmY0ZiWExxVGNONWgvblBrTlVUZ1VjdzVPc2M4U25aT0xHcG5q?=
 =?utf-8?B?SWNyNURRSVlLbW5JUTB1c21aeWJTU1Jwc2E5SmFKamlYVzEreTVkRXBVRHk1?=
 =?utf-8?B?dzRPc2x0YTdObkFWdFF6M29xRmQyRFpVSGVrQXpPSUVFcE1oeU1GclBpVmM4?=
 =?utf-8?Q?YKIDbSi3v+2OkGyM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e29dd87-2207-48cb-3a4d-08def945582c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 14:15:36.2663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1i0xPTJwesJF3VNgOKve29f2OhNvHBf19ewVYBcEBMHz0EGHZX27wUIioncVODf7KtOky6v+rATGPY7GfDPUcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3261
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 14:15:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23930

On 13.08.26 14:51, Gourav Singh wrote:
> Ensure ltp-full runtime includes tools needed by the bundled kirk runner
> and report parsing/inspection workflow.
> 
> - python3: required to execute /opt/ltp/kirk.
> - jq: required for parsing/inspection of JSON reports produced by kirk.
> 
> This avoids manual package installation on targets and makes LTP/kirk usage
> reproducible.
> 
> Debian buster compatibility is preserved: buster provides Python 3.7, while
> kirk requires Python >= 3.6.
> 
> Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
> ---
>  recipes-core/ltp/files/debian/control.tmpl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-core/ltp/files/debian/control.tmpl b/recipes-core/ltp/files/debian/control.tmpl
> index a7d0087..039c6d0 100644
> --- a/recipes-core/ltp/files/debian/control.tmpl
> +++ b/recipes-core/ltp/files/debian/control.tmpl
> @@ -11,7 +11,7 @@ Homepage: https://linux-test-project.github.io/
> 
>  Package: ltp-full
>  Architecture: any
> -Depends: ${shlibs:Depends}, ${misc:Depends}
> +Depends: ${shlibs:Depends}, ${misc:Depends}, python3, jq
>  Description: A collection of tools for testing the Linux kernel
>   The Linux Test Project is a joint project started by SGI,
>   developed and maintained by IBM, Cisco, Fujitsu, SUSE,
> --
> 2.39.5
> 

Is that a longer pending issue or a fix for [1]?

Jan

PS: [1] still didn't make it to the list. Please check your submission 
settings and error logs. I received it because I was on CC.

[1] https://lore.kernel.org/cip-dev/0f8dfe37-8856-4895-8cef-b40342339c66@siemens.com/

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

