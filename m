Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F25EC98317
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 10:06:28 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.59])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4291.1790244386388827311
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 03:06:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=I81EqJpj;
 spf=pass (domain: siemens.com, ip: 40.107.162.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnCUFycwC/vX99pEuSiJ7rnhvWnpEhMsp2yB93slFaxLl8A2nkhLXKfWYCnuhmnLBfVdQPdDyF/CLP+GBiy/AnHi8GuJ4RhhWgrQz1wTKKNuguQVhuwLwshqsrrr4GAjLQZg3zA1xabffNDWquebIVd1M2Cls93T1QhpNMtFRzWHS50qKsGFjNq+VA8l1PV6hYjfFkeP/z8dcs2lkW0BK2LDOpPMAIWAFvP2xZ0BsSjTNKzV39em58mhmyD2ulGPXwQ2KwBpKS+ISK5LlO9PMbs+ga7IxC/tjrgqD8HUh4BGC4Phz1tr90450l/9QKv9D30xit6WFj2K2dkBVLfSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mmeXN9LmLur4aQ2IF43hrnaVWC7Yshjpy3Lv1AeNEg=;
 b=Q3i0eZfRBx8nn/J7z92mzCaz4Ost0TGPtfeHrP3O1j7rNjSW+GaviR1WXeH+yrrGbWavQCyZTBX6fIvK2t9LJmzBJjnoAj+e5D59amefYicF0OXoEslwvKTbARz2P38ARwwIn65onuMRMNCSdpQaOSFGBNSJ2i4HyLl+bhcmIOrZZgvRseUTteH89hHi6SceeEVFDMj6d4lkfvRJD4DEaFscTZuc6h2KUicv8c8xtfgRQfxwWXoPoRkCW70cQcOjRd1If306sRvlmAfiaKkbjEqKJGOP3py2fvS0jAabEadY/exG+IqVZsi0LnU9Hhc82tPcdnXf99vR0O6KyIhe6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mmeXN9LmLur4aQ2IF43hrnaVWC7Yshjpy3Lv1AeNEg=;
 b=I81EqJpjA83eZejFW6GFsNmvwD9ruHtAbvgB791sI0nnWTZv+q8F3F4wn2H93ZyU9fYf69FwTIOI9KO/4KYa3/L8oSn8W/f7yzmPs9rVfGADIGg4FIcK5Y9/Vev0YmD/9eWiGeJBIomfNrrqAcmWUWeZwHpb1NEzfi5L0o+MRXeheGRcflWOEUv8FFVJxvDd9DmZj48AFwsAD7m2DEDHO7CtzmBGFikdhybLxtvXaP1KAdAtUu0gRf99xjyxDE/Qbhhc/AUCvDNcHJ4jTu/qOw0YFEdxOuXfHmT7M+5MSbeHXKkSAueSTIZL3pGJR4o02peAb6t1gV57l/OmCSN9zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5948.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 10:06:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 10:06:20 +0000
Message-ID: <5d98ec2f-dfec-4f48-80c4-7e1b939cca16@siemens.com>
Date: Thu, 24 Sep 2026 12:06:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 00/14] Add recipes for image
 hardening
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 clara.kowalsky@siemens.com, christoph.steiger@siemens.com
References: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JN3P275CA0074.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:c9::7)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: b4977612-2b34-4213-6a0c-08df1a237b70
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|5023799004|11063799006|3023799007|6133799003|20046099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	owr6vwdcApWJzU3wqaZhI/nwnztRvXN3fsZQOBSZ9WUK46y+QbLMM9qBLCZe4qflFi+gZv6RfosWjmJmaGBkAPIckBnO1UubPf0aOmL/WfYj3GGX9U6YhAJP3tMSa8B/g/Xuk4obA/URQTo/p6lz0nsp/zh+UUaXEEE+jq659jmLyRE+F703tBTGjTUoC0h9GrzkKM++MWLO60kIgXKb3iKbhtJL4xeM+fhB8zBTlJEk+AcT9Z6ZAQ0wDreAatdGIv50yWeW2V3b5/GuJTlL2bnV6LZc6IevIm5gztDakZaqwJsOOQ585UgJ70D3SajI0qdLztptwb+MjZD7Lm9/wDvyfO7gvu2W6oLk1X27wAim9/FOzsL4myB2mNzFROHzre84lYb2KiDM/+0M41e5n+21GutoYOogaMIqdzWEOqGp/Dzs+uDIpR9Cp7VpG/SyEkYMpngpWIdv401q2gglp+TdthBO5ClCReXMyf78zit6MEFWyLpueJYsnst81xE9Ffza7Ecg+1xrbHygYxsFySlQo45LSq9Ugv8Z9VT0XWaryuaEdQbvmgoZdJ/+YXlcQoxy5tRT8h0Wy+3IJRtowB+S7Inz+Y2NZ9KvuOPjdOexdxJF9JRoQBTz02rsMGMBeN2lnNNzF2Zl+72tn49ivEn0XR2cUhyW75afv25VZV8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(5023799004)(11063799006)(3023799007)(6133799003)(20046099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WU5UNW1sdHVkcWpUaWlROGNzblZxQ2I4cUVCSjJrUkdHeHZrVklZZWk0QkQ5?=
 =?utf-8?B?ZzRGcTlXM2tIMFlPMDRBeVZaMlJ0aWpHTXhPRDJOMjBDaFliNzlUOEFjY2M0?=
 =?utf-8?B?dnhHS0ExbGVSL1grcVJ1Sk5hOUxVVGcyM3RPS3BGa29PZExJTGFETmtoWkE5?=
 =?utf-8?B?dUFkaEFRNUt6dVl4Q2loblpuT3NjMDlvcmxjbHRKSnpvT0pjS0NFYkU1Njd1?=
 =?utf-8?B?dWN2WUorb0kwRGNuclRHZE9vdDljZ3lOUGxaMTlWSmpKYXVyYXYyUmVmOTNJ?=
 =?utf-8?B?dDRGVlFiRkN1d2tWYlJleGl4R0pZbE0ydkcvK3YzWU1CYU9CQVAzOXBWanZC?=
 =?utf-8?B?SVFnWE91MXp2ZSt4dmdhVGpVU3k3MWdQNGN6ZU13ZXdZUFdOVExMM1BmZUo1?=
 =?utf-8?B?WHBielhkdmhuR0dCL1hiRDFlTktwQnMzVFFHSnVDL3F3VkZrcURkNmlaZGNv?=
 =?utf-8?B?UC9sYUd6R3pYdzBONC81RXpadDNsM25lbmhOT0JoR3F4MDJ2T0NZSENud1dq?=
 =?utf-8?B?b2d3UWRBb2hVYXBWTGVEekJXVzRlNjgyWE8xYlZKWldmTFhIVXBwM0xVTGNq?=
 =?utf-8?B?QktzNFBhSUdjS0x6NDRrRkkrLzh5UXdjbUN5LzNrVDJiQWRLcHZTckdNVXk1?=
 =?utf-8?B?TDhnRE84OFk0c0Fsclp5czVjNEhqTDVXUEM2WlBKQUQ1QVBmWEFYS0pGZFBR?=
 =?utf-8?B?YXVYZGk5eCszenp5b1lSWHZrL2Q0RVdBNm13Y3pvOTkxaDZaNmkxSTFSNHJG?=
 =?utf-8?B?a2Fvcm5qbmtOR1dObzRaR0pZeUE2Y3JMRGRWQzBZc1pjeDBDdWdYTkx5UkZl?=
 =?utf-8?B?SjNEVXB4SWdTd2NGUlBiZHBjc0RYcTdvUDlEVW55SkJGNXIxZ1dEZWhyRjFS?=
 =?utf-8?B?QWZZZXlBVE9ncy9TQmZFWDZXVFlqcnJUeGJyd2Rvd1BaclZ1WlV2V0FqZk9r?=
 =?utf-8?B?eC9TcDFJekJrbTdhVWNBR1BMRkVNKzdIaEp0Y3JxRmkvWHVVS2hZVitPb29a?=
 =?utf-8?B?MmJGNmQvYUhoQTNtcjBMTk9XcjFieTE4Mmg0QW44S2ZHWUFvS0ZRamUvSkNK?=
 =?utf-8?B?TFJWTkxMYXNVcEhvK04raWlPWEpEODBKTmtQMkR6R2piTTBlRm5aME1mWFEw?=
 =?utf-8?B?dy9SQ2pxMGIwNlVrd0tXdHM5cys5UXphL1hrTHpYZTdNZld5ckd6RWxaKzI4?=
 =?utf-8?B?TkpYR3BkTHlyend0VkpaUUY3ZFd6U3JHZUlnUi9OMElQQVVHY3VTd3BmbUEx?=
 =?utf-8?B?Mm1ocURLRVBHbG1lbWF3QU1Yc1pYVUVMSDZqYXZDYWVmTDFDTVVpUnhsQ0pl?=
 =?utf-8?B?RzR1SkRBdXV1d1d1MldVcjBaQmpvZzRGemNvUmFVdm9QdkdjTURGUFVvcE9Q?=
 =?utf-8?B?RFVGSTBqK2ZLTEFqOUcvUVJxTU0xWmF3OTQwMHBHUzZDNHNyL28zWU0xN0ZW?=
 =?utf-8?B?NjNXcUxlRVVORUlZeUhFN2dTeEwwSjh0M21IQkVQK293elNPT3FJWWxRZ242?=
 =?utf-8?B?a1l4bldnODZEb0JRQ3huT0J4VTRhN1RZa0pQd1ZLUTV6OGVCMld1QStOVSs3?=
 =?utf-8?B?Q1Zwb2Y1TUZpTXNVeDk1a3RldG9aVVZ0empyRzRmR2ZWeUxuUVA1YVBDbTFL?=
 =?utf-8?B?dTZBVG50dDhNSTlUa2l6VXNPbmFUbmJNZitVZlAyblE1Yk5BTkdadk1tRlB2?=
 =?utf-8?B?WHVLc2dJamxtZ1J2ZEVpNnRxZkhJTTJoakl4K2h0WHZ3Rk9tRnExV0RiSHdq?=
 =?utf-8?B?NHFuRXF1WTVuZTk1eGs5NXdyQVZyaUh5dVZPNWlFNUtYRVlSMjJMTm5YYkNi?=
 =?utf-8?B?QWQ1MVlRYk1odnJSQnlBN09rWk1rU0xJTzlzS1JKWGlLandvbHhPQTFtK3JZ?=
 =?utf-8?B?aFc0VEtTK2FIY1RmT1RtTEExUG9lQW03QXJUa3pQZFVpd0xYaEhsR3c0RkxR?=
 =?utf-8?B?MERJaEN5cmtGRVQ5Qm5kejl3K1BzWUFBTzJwSC9tdEZmd2xHMTRqaWsvdGZS?=
 =?utf-8?B?ekMxanBhaXEwdW1tbWF0K04vRXIrQ05WcWxrK011NG4zeG1hRW54VEpGUDJS?=
 =?utf-8?B?TkRxbHJBbnNRem11Qkh0Wm5KRFhsTEQ1OVJqR3diMzgrMHh1RnFNRUpVTTNH?=
 =?utf-8?B?WnRYYWRYWE1iNUhuUy8xSGVWb2VUVzZKVVZOeGZJdyt3ZmFsZHFyV0RTbGFm?=
 =?utf-8?B?N2VRMTZ4bmszREc4aENlZWQyLzVqUFpmaDFhN3lWbU1hQjVrcVB4cXY2Sm9J?=
 =?utf-8?B?anBRUFQ1eTdHVVIxSms4M0U1UnkzS21iTGN3UUtQaGoxWTBjK0FMQWFjWE4y?=
 =?utf-8?B?NlVDdWYyTExQaW1vVGRlSTk5d1djZTZrcHMwVWpFUGNoQlpKNjJCZktPQS9q?=
 =?utf-8?Q?l+JKI08HMSh4ZmNI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4977612-2b34-4213-6a0c-08df1a237b70
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 10:06:20.7978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SzOTPOxpeQRBEyVFk0OD0E6FcD+AxViE096Q72hs4DQ9zeMBtCHi3wF8JlTJBssOy66FauiAzBk/EGV8+wfbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5948
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 10:06:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24306

On 24.09.26 10:12, Quirin Gylstorff wrote:
> This patch series adds the option to harden the build image according to
> the guidelines published by CIS. The patch introduces the following packages:
> 
> cip-cis-rules-config: user-facing configuration, stored in .config.json and
> configurable interactively via Kconfig.
> 
> cip-cis-rules: uses the configuration from cip-cis-rules-config to generate
> a custom Debian package containing the necessary hardening configuration.
> 
> cis-validation: an optional package to validate the hardening rules.
> 
> Additionally, the kernel configuration is checked against the hardening rules.
> This patch set is currently developed and tested for hardening level 2.
> 
> 
> Changes v4:
>  - rebase onto commit 6ced51c2993421738c86838832fcf37b9b2076f3
>  - Remove redundant addtask for prepare_build
>  - Switch cis-validation.service Type from oneshot to exec
>  - move validation to kernel recipe to avoid issues with kernel config not
>    being available during rootfs install or validation of a upstream kernel
> 
> Changes v3:
>  - switch cip-cis-rules-config to dpkg instead of dpkg-raw as it allows
>    better task dependency management
>  - remove json schemata validation during menuconfig read to avoid a
>    issue were outdated config cannot be updated.
> 
> Changes v2:
> 
> - rebased onto commit 73d8558efc2fb49436aafac36126564c6a725565
> - reorder patches
>   - README is now first to explain architecture
>   - layer.conf before arming
>   - kernel and image are armed together
> - use external repo for cip-cis-rules https://gitlab.com/cip-playground/cip-cis-rules
> - menuconfig now uses devshell to be independent from kas environment
> - generate config.json and kconfig on the fly
> - bugfixes
> - rename cip-cis-validation to cis-validation
> - remove CIP_ prefix from variables
> - rework readme
> 
> Clara Kowalsky (2):
>   Add cis-validation to validate the hardening based on the CIS rules
>   Add kas file for hardening configuration
> 
> Quirin Gylstorff (11):
>   Add doc/README.cis-hardening.md
>   Add cip-cis-rules to apply hardening configuration to the system
>   Add github.com/ovh/debian-cis for the hardening validation
>   layer.conf: use variables to control path of hardening config
>   Add cip-cis-rules-config to configure the hardening according to CIS
>   Apply hardening configuration to the kernel
>   Add class for validating the CIS options in the kernel config
>   Add class cis-hardening for post rootfs generation fixups
>   Integrate cis-hardening into cip-core-image
>   Integrate kernel validation into linux-cip
>   Kconfig: add option to enable CIS hardening
> 
> Shivanand Kunijadar (1):
>   Fix file timestamps are not reproducible for EFI certificates
> 

This patch is no longer in next as-is and is not part of this series.
Please check your baseline again.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

