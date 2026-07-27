Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FD7C531FC
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 15:24:43 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.63])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33593.1785165876211464210
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 08:24:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=J4oBrJ1t;
 spf=pass (domain: siemens.com, ip: 52.101.84.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wW7rJDEFuvdpf9o70ugqBpKeRILnqAMlvm1Kvvuyyl91aUpEReoqYlzZCV9lGaa1LJaLUcjQpm4VbhD5y/c2HAcAOmUxAGsITkGkzMgNZreFMmIjXpTIFaM/GaqfXKIvuUIBnzwFkM53RlPKGPNj6k/hi0XtZcSsBX9346lXT/jhb/dn2s5H5ea0h4eWjDpSK94B1ib+zIKwqpqmYM1DzXbybhY9nz3LLG5mzCgjPUgMVE4lpRSKKyKOnAe0hbbAYlMmZhWzNtGJF8gY9qP4NTRlozikrX9spQvp6bV6x37OW7uYgRFqQs0ah0RO6PPEkMXM3ccEwVm1U+yhdT1DUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plmlu/0QnUzG6ePTd6o9eut0bx1/EFJ2SljsqcY0h3s=;
 b=m2nEb7mA7OWapLMdJRhHO0IuTtgTdqqNOFZsPAT+vYNueedsyZHH6EO1vgqvc1SdAtOewg1q7aVaqyhIqesmAqQAvkwC8ikDNnzTD5ZpMK3kuSqJX1aPuLjVgxaUKH5QXXCaVZepgp/n2fhDDDLb9l5FrvFXuWqIEnatG1Rik27Su67awMXMnJecpw6t7BwtPTpYMVzM6v/rUevIu9N2/gimULNXyP8cAuTb3W4nfrW15aZvE0eAXcIJRm5aXeJyBJeI0L7KokC+VXJvj7y1v++4jKMr5ap2U8x5tUQwJxp2KbPONvLK9vg38ho+sXxy1GH+1ZHcuuS0WKav2JkwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plmlu/0QnUzG6ePTd6o9eut0bx1/EFJ2SljsqcY0h3s=;
 b=J4oBrJ1tpJEv68L3ATZDNgvFGYQsIkgylnRCVmG2fck33XCAAkUGfCopKwI9wKz/6/XuGZ1fcw0W60dPw2ZpQLOoY+9EaYYSW6itslUI8mqJA++W0vsbTgKMu5Jbo3mgZP6bsQYuoBFQ2CJqiJ9xYsIcC+AgpiimR0CZwYl/fRjyzwAb7wNvmwH+5vT0qHcRetCYQ0iim7+SYvYSnu/LQpLVz1WzEtqFvzQK3Htv+eA7SoYeFHikLeXE1OQxU7uPDiuxlZPn2A+jdpVt4la6sDQOLhzvRSzuf2c/brm2fBCTOd9R5CireYzkzpeN8GCKCOZhkybpjE2E2rc0sr2HqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXSPRMB0032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 15:24:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 15:24:31 +0000
Message-ID: <0bbb36ab-d91d-4fd9-a4db-7605b9e13b71@siemens.com>
Date: Mon, 27 Jul 2026 17:24:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 14/14] Add
 doc/README.cis-hardening.md
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christoph.steiger@siemens.com, clara.kowalsky@siemens.com
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260724124945.3636668-1-Quirin.Gylstorff@siemens.com>
 <20260724124945.3636668-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260724124945.3636668-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXSPRMB0032:EE_
X-MS-Office365-Filtering-Correlation-Id: b34b2f9e-f50c-4c03-5ce2-08deebf327b5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|9063799003|6133799003|5023799004|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	KCXCqnVKU6XmS/kb+0U6dFJtzD7Zkh0UdQaFixS13NP74CPaTmIkN+UiPxz9v523mZqth1iBJDSXkKWZliryjrDplWfBIzGouS1+H5n0RjI+Qqnqxl7UqTQMyeXvMFTgpbBTzzYJ+iG9iTtkA4jKwuh1mSdJWupnLIVONAq/aeT9XFGwMJsNzfu8FG4BTDTVLHup/XUYy2Zwl0L+0A9ux+KAw0JYy9mFdi8EIUP8axtanq0lIkpDdQPK4WjaEiYDf4qL1uiT4fl/tYv32VOlBQ4zrdqYjbapN6zb3t9lMp9cUr/O/6tLEFb9NrJW+vRhFFJ0TgDEVT/hlSUZVrhuk7aH+inJp+ru06i1YL4ziGqRjvTSnw8omzB5YddtXpUzOpDWXbh9UUyCMuuIWFxHtw0l7hLuw0ceBmAYO8zF40xMt80eWwfT5eY1rFtyFE/O4jjZ9ntNaBa7AmZ6AkuWmVehijlimsaOd3nkfnzp6WcyYBrfziu6u0aMdyUh+stdyxmwo67V9UZ+EgwFeEkKE5fLWJsvQqYiZoKXG76+zEg0S6XuhNj8RhFsqWGHPf6ekbKDuHfqDZSECDfWpf/5YKC+1a9ZgchiCGAz20mXnt+NvYbb+i03fmQtjlxp80pEhvhNob6mWJ4mbKEQED+lByu+qwwHwxLixs1Ev3C8F+0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(9063799003)(6133799003)(5023799004)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MDF4Rnpja3paWXJnL01yUmptdEN6Y1FHeXpUanp2Y3RQdUhPRjJVTytnOGhk?=
 =?utf-8?B?R0ZidUhVOUp3K0wzMXMzaEZhMjc1bVN2Q2ZDaStDOGcwREJJWHJkZ2Y3V0tZ?=
 =?utf-8?B?YzQvRm9yWEJSYVVMVGtjcHUvbXA4aVg1bW5QRzY2Vis4MXFpRnAzV0tTS3Jh?=
 =?utf-8?B?R2RqMEdWSDNINmRONjE5MjQ1dDRrVkJUc0d4QUNBbmpOQ2hUMElFS1dodHd4?=
 =?utf-8?B?b1l5M2RrYnVlSit5WURXc1pkN0dUaElUa1lCbzRJSDdrZXd0ZWd2aTB5a09F?=
 =?utf-8?B?UkxIYWNLanR1bW5IdlRoeGJodTdtSGs2WEJJTE5QU2RjRG5lTVd3M2szRWNx?=
 =?utf-8?B?cE42QmlNa2lVVmo1ZmZPNzRTMW5hYm9WdmpZM0dtdGlzQ1ovcEdMckF0SkZw?=
 =?utf-8?B?RXZ4UjhKWUEzQW92VkxrZlFIY21WczduSmswVThFUlFhT1Y0L0M3YnhqMTdL?=
 =?utf-8?B?WjQ0SEJabFRyclQzbU1SNEVDQXNUcHlGY0ZEbGVMQWxYalNKa0h2LzREbWNN?=
 =?utf-8?B?Qjk3cGRmSFRWOGVQRlVtNEh1dURYT0VLNFBJY09GNHRQa2FCZ0szc3IxbE9y?=
 =?utf-8?B?MFh0UTBZQWJzTnBRai9CNGM5NGJLQlpCb2ZWVDVIblFETnNrUDUwZkN2KzU1?=
 =?utf-8?B?L0pZdytBbVZMVkl3VEVFZURpd3VvMTYxQkFRTlRFOVR0TjMzZzg1NVVFSjF3?=
 =?utf-8?B?RTZTVit3M09NSzNrNHFoNjUxdEdxQkVicTMwWWg5SnFXRVdFYlhnS2pCRWtl?=
 =?utf-8?B?Sjh0S3BIOGlPeDVOSFVYYkZBS09LZ3d0ZVVNcmpwN3ROVDV0ek1aWjdsb0FL?=
 =?utf-8?B?OWJMZE85NXZocFFxZXg3K3VGVnNzZVFnMU4vcVo5UXo2WDFzalRBNXd5aXFN?=
 =?utf-8?B?L29VT0YrNXRUTXNxV2JvOE9OWGhWWVlPSEhiQWVCUlhKaWx6aWltN1o3b3Zt?=
 =?utf-8?B?VWFwbHlCRkhZOTROb1NFMUxGY2VMMFh1NStHNnFzU1QyTjdGYTRHblpVaStk?=
 =?utf-8?B?KytGaFZ5YmYyR0k5VzFoVlJxTUI1RVJ4K0ZtSnZvMHRwckl4M3pUYXc4TnBm?=
 =?utf-8?B?R0d3Rlo0OCt4dXBaWVQ2bDRKYS9SWVBJUU5oQSt6Q09RbEY2ZUNiWW1PVFp2?=
 =?utf-8?B?WkxuV0VmMWdiWHlaajlpOWl4SjJOL3lPbk1FN3dqWDZSek1Fbk95Q2RjbWxw?=
 =?utf-8?B?TitvUDBQb3M2SnVKckxOOGJIVUpqMnpJVHFkREJ1dmZGVVZvT1pkdU93c3U4?=
 =?utf-8?B?eFFSOUxIUjJUVjhOaWtNOU0vMTUvNUFEUnMyc1FOb0RNcEJtU0VDM2tweTZH?=
 =?utf-8?B?bGhNcllma3VNVm01UlNjMVZqMFdCMlRqNDltaHpGaTJrdW1qMXlTcjdkcFZK?=
 =?utf-8?B?ME0xa1JmNWlVV0dtZVNtQ2Q0a1Z2RTBjWHVMMVREVTZQVUM1NGUzdEtySy9F?=
 =?utf-8?B?dHhtRWlTRTlQV2FJNzh2QkVoVDFMVUhQMFYxaVYvcWtybEVBTTBVcnFBM0Z4?=
 =?utf-8?B?OEh4RTZmbERhQWMxREthOG0vYU1sSEZtWWNMZFdNNDVOV3JkN3hqNGxBeEhM?=
 =?utf-8?B?cksvNndsWjJNeVhOQU95dk1WbG5SUkh3bndBMEF1YWRqb0lJMkJZVmo2WTgw?=
 =?utf-8?B?aXgvdmU5MFI5YVZkbnNpYS9tQkMvOWdmK3lzUHNiY2RSTDQvRFQ5NVphcTg3?=
 =?utf-8?B?TWh0VmE0US9USUNKalc2SDFGR0pBTjhZdExmVFFlc0NhZmc5dXdGL2VnSTAz?=
 =?utf-8?B?eHh0UmkxaDg4bWIreHp0TTFid2phclJsNzM0ZW9mYnBNSHBuS2wyNGVIOWhP?=
 =?utf-8?B?QUhRTWlTZ0Z1RVFHamdISWtFRXdtRzRIMzBrS0N6N0JHYXdQblJ1ZHE4dGE3?=
 =?utf-8?B?aUlrQ3p2TmdMN2VDaHg0cDhNZFh5N0hHZ0JHUml5NU5QZ2FWZkRMMXM4K25Y?=
 =?utf-8?B?VUFWNUlaTUxOeWo3bHllcXIzY1JRc1RPN21pT0NxR1dZN0d6SW1hRi9DaFAv?=
 =?utf-8?B?eTVkVkJReGlLM3FtcmNpcEt6UlNmM1FmZVdDKzdrYW04TUlEczgyajQ1a1Bk?=
 =?utf-8?B?OXp1Wks5ak5HOWlPVGZkblNKZWJOc2w2Mk9hSWlDdjFZYmw1SWRsam11bWx6?=
 =?utf-8?B?OUViRHFMajJKUHhFd29LQnljNXJlbFU1bWREeVBUS0pLYzF5Q2w5ekR3RUJ4?=
 =?utf-8?B?MGdOWm1CRTk0N1p2ZUJmMVB1UStvM0VJVFhna2V5eHFta1R0ZkZaU2hFTURS?=
 =?utf-8?B?SzZ3Y1B4TnFSNGRqSHViQUdObE0zVWc2UGpBTksycUhLNEhNTDJBdnhTMlRM?=
 =?utf-8?B?MHBBMXljRDNqY01RSjdLSTRkVVUwUkwrWityWFRuNFovRHdWeGtLajZZVUI4?=
 =?utf-8?Q?yTWmCS29kJQpmyoE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34b2f9e-f50c-4c03-5ce2-08deebf327b5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 15:24:31.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMz/ZZJ4rE53SxLA3F1T6zgdW04ntl0tcs/8UB9GJ7SOzrtmFR5EVyrulxDH/Zy5a7imUA9IecJor7eP/Mg4uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXSPRMB0032
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 15:24:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23783

On 24.07.26 14:47, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  README.md                   |   1 +
>  doc/README.cis-hardening.md | 183 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 184 insertions(+)
>  create mode 100644 doc/README.cis-hardening.md
> 
> diff --git a/README.md b/README.md
> index 435d037..f9f4f01 100644
> --- a/README.md
> +++ b/README.md
> @@ -60,6 +60,7 @@ The following topics are in separate READMEs:
>   - [Update and Secure boot signing](./doc/README.signing.md)
>   - [Encryption with TPM2](./doc/README.tpm2.encryption.md)
>   - [Factory-reset](./doc/README.factory-reset.md)
> + - [CIS hardening](./doc/README.cis-hardening.md)
>   - [Release policy](./doc/README_version-release-policy.md)
>  
>  ## Community Resources
> diff --git a/doc/README.cis-hardening.md b/doc/README.cis-hardening.md
> new file mode 100644
> index 0000000..104818a
> --- /dev/null
> +++ b/doc/README.cis-hardening.md
> @@ -0,0 +1,183 @@
> +# CIS Hardening
> +
> +CIP Core can generate and apply a selected set of CIS hardening rules during
> +the image build.  The rule catalogue is derived from OVH `debian-cis` and is
> +exposed as a Kconfig menu.  The selected rules are exported as JSON, converted
> +into Debian package content, and reused for kernel configuration and optional
> +runtime validation.
> +

Ok, here is hopefully my architectural overview. Let's see.

First, some links to CIS (what is this? why/when do you want this?) and
to that OVH repo you refer to would be good.

> +## Key design decisions
> +
> +- CIS hardening is optional.
> +- Hardening is enabled by a single image configuration option,
> +  `CIP_CIS_HARDENING`, plus the selected rule configuration.
> +- Hardening and validation are independent.  An image may apply hardening,
> +  include validation support, or do both depending on the product workflow.

...but we do not allow to select only hardening in the Kconfig menu. Why
then this separation? How do we test their independence?

BTW, how do we test at all? Nothing of this is built in CI.

> +- Hardening and validation configuration must be overridable from a
> +  third-party layer, for example through a `cip-cis-rules-config_%.bbappend` that
> +  provides a checked-in configuration.
> +- The default level `2` configuration must harden all generic settings.
> +  A conformity level below `100%` is acceptable for this default because the
> +  remaining rules are product specific and must be completed downstream.

What is "level 2"?

> +- CIS `99.x` rules are ignored.

What is that, and why do we ignore that?

> +
> +## Enabling CIS hardening
> +
> +Enable hardening for an image by setting `CIP_CIS_HARDENING`:
> +
> +```
> +CIP_CIS_HARDENING = "1"
> +```
> +
> +When this option is enabled, `cip-core-image`:
> +
> +- inherits the CIS hardening image class
> +- installs the `cip-cis-rules` and `cip-cis-rules-config` package
> +- applies the generated hardening package to the root file system,
> +- adds the generated kernel hardening fragment to the CIP kernel build.
> +
> +## Configuring rules
> +
> +Rules can be selected with the recipe menuconfig task:
> +
> +```
> +./kas-container shell <kas files>
> +bitbake cip-cis-rules-config -c menuconfig
> +bitbake cip-core-image

Simpler and more generic:
$ kas-container build --target cip-cis-rules-config -c menuconfig
$ kas-container build

> +```
> +
> +The menu contains:
> +
> +- a hardening level choice, currently levels `1` to `5`,
> +- one boolean option per CIS rule,
> +- justification strings for rules disabled even though the selected level
> +  requires them.
> +
> +Changing the hardening level in the menu resets rule selections to the defaults
> +for the new level.  Existing justification strings are kept.
> +
> +The menu writes `.config.json` in the `cip-cis-rules` work directory.  To use
> +this configuration for hardening it must be copied into `cip-cis-rules-config`
> +and added there in the `SRC_URI` and `HARDENING_CFG`.

That again raises the questions why this is .config.json has a leading
".", why we are checking in some prefilled version of it, and what that
default contains.

> +
> +For product builds, copy the generated `.config.json` into a local layer, add
> +it to `SRC_URI` from a `cip-cis-rules-config_%.bbappend`, and check both files into
> +version control.  You can have multiple configurations checked in this way, and
> +select which one should be applied with `HARDENING_CFG`.

Could someone run that menuconfig in a way that the resulting config is
directly placed into a downstream layer? That is particularly important
when we continue to check in a default version into isar-cip-core.

> +
> +The JSON format is validated against
> +`recipes-security/cip-cis-rules/files/cip-cis-rules/generator/config.schema.json`,
> +whereby `apply` controls whether the rule is enabled.  `justification` documents
> +why a required rule is disabled.
> +
> +## What the hardening package installs
> +
> +The `cip-cis-rules` package is a configuration package.  It installs only the
> +files for rules with `apply: true`; rules without implemented snippets are
> +kept in the JSON selection but do not add files to the root file system.
> +
> +Implemented snippets currently cover:
> +
> +- `/etc/modprobe.d/` files for disabled filesystems and USB storage,
> +- `/etc/sysctl.d/` files for kernel and network sysctl settings,
> +- `/etc/ssh/sshd_config.d/` files for SSH daemon hardening,
> +- `/etc/sudoers.d/` files for sudo hardening,
> +- `/etc/security/limits.d/` and `/etc/security/pwquality.d/`,
> +- PAM snippets under `/usr/share/pam-configs` and `/etc/pam.d`,
> +- chrony configuration under `/etc/chrony/conf.d`,
> +- helper scripts under `/usr/share/cip-cis-rules/configuration` for settings
> +  that require an install-time action, such as file permissions,
> +  `pam-auth-update`, and `/etc/login.defs` edits.
> +
> +The `cip-cis-rules-config` package installs the generated data artifacts under
> +`/usr/share/cip-cis-rules/`:
> +
> +- `.config.json`, the selected rule set,
> +- `hardening.cfg`, the kernel config fragment generated from enabled
> +  kernel-relevant rules.
> +
> +The same artifacts are also deployed to `DEPLOY_DIR_IMAGE` as:
> +
> +- `${CIP_CIS_HARDENING_CONFIG}`,
> +- `${CIP_CIS_HARDENING_KCONFIG}`.
> +
> +## Kernel hardening
> +
> +When `CIP_CIS_HARDENING` is enabled, the CIP kernel includes
> +`${DISTRO}-hardening.kernel.cfg` as `hardening.kernel.cfg` through
> +`KERNEL_CONFIG_FRAGMENTS`.
> +
> +The fragment is generated from enabled rules only.  Disabled rules are omitted
> +from the kernel fragment and should carry a justification in `.config.json` if
> +they are required by the selected level.

It's likely important to note the ordering issue here: Any own .cfg
snippets added to the SRC_URI after that hardening fragment may override
decision there. And that will only be noticed during validation.

> +
> +## Validation
> +
> +Set `CIP_CIS_HARDENING_VALIDATION` to enable validation support in the image:
> +
> +```
> +CIP_CIS_HARDENING_VALIDATION = "1"
> +```
> +
> +With validation enabled, `cip-core-image` installs `cip-cis-validation` and
> +inherits the kernel hardening validation class.  Validation uses the selected
> +CIS rule configuration and can be enabled independently from hardening.
> +
> +Runtime validation uses the OVH `cis-hardening` audit tooling. During the
> +image build, disabled rules from `${CIP_CIS_HARDENING_CONFIG}` are converted
> +into override files with `status=disabled`, so the audit run checks the selected
> +policy instead of the complete upstream rule set.
> +
> +The validation command runs the audit in a temporary CIS configuration tree and
> +succeeds only when the reported `CONFORMITY_PERCENTAGE` is `100.00`.
> +
> +Kernel validation runs during the image build.  It compares the generated
> +hardening kernel fragment with the kernel config installed under `/boot`.  A
> +JSON report is written to `DEPLOY_DIR_IMAGE` as:
> +
> +- `${CIP_CIS_HARDENING_REPORT}`
> +
> +If a kernel option that should be disabled by CIS hardening is still enabled as
> +`y` or `m`, the build fails and the report lists the non-compliant rules.
> +

As commented on the related patch already: This should be moved into the
kernel recipe, and a validation result should only be checked when
assembling the system. Avoids being bitten my a missing config on the
final rootfs of an embedded device.

> +## Notes and limitations
> +
> +Some CIS rules are inherently use case specific. Examples are partition layout
> +rules, firewall policy, SSH access lists, password ageing, and rules that
> +inspect existing users or files.  Configure or justify those rules according
> +to the target product requirements before relying on validation results.
> +
> +The hardening package will **not** install additional packages to fulfill
> +a rule, for example iptables or ssh. These use case specific packages need to
> +be installed by the user.

Actually, ssh should be *deinstalled* prior to shipping a typical
embedded device ;)

> +
> +### Comparison to security-customizations
> +
> +The recipe `security-customizations` sets some hardening options similar to the recipe `cip-cis-rules`.
> +Because `security-customizations` is part of the certification efforts, it is not modified. The following sections
> +list the touch points.
> +
> +#### SSH hardening
> +
> +The recipe `security-customizations` contains hardening rules for ssh. This table summarizes the differences from
> +the cip-cis-rules:
> +| security-customizations | cis-rules |Comment|
> +| ------ | ------ |------|
> +|ssh-remote-session-term.conf|cis-5.2.16-sshd-idle-timeout.conf| adapt cis hardening to lower values of cip security|
> +|ssh-pam-remote.conf        |    -    | no rule implemented in cip-cis-rules |
> +|ssh-hardening.conf        |cis-5.2.7-sshd-maxauthtries.conf        | 3 vs 4 |
> +|ssh-hardening.conf        |cis-5.2.23-limit-ssh-max-sessions.conf        |2 vs 10|
> +|ssh-hardening.conf        |cis-5.2.21-disable-ssh-allow-tcp-forwarding.conf        ||
> +|ssh-hardening.conf        |cis-5.2.6-disable-x11-forwarding.conf        ||
> +|ssh-hardening.conf        | -       | AllowAgentForwarding is allowed according to cis rules|

So, we already had harder rules in place than CIS demands? Didn't CIS
allow to set harder rules, or what was needed then to merge that?

> +
> +####  Other hardening
> +
> +The script `postinst` of the recipe `security-customizations` contains the following changes:
> +|security-customizations|cis-rules|Comment|
> +| ------ | ------ |------|
> +| set password creation parameters with pam.cracklib| | parameter differ between the implementations|
> +|lock user account after unsuccessful attempts| - | no rule implemented in cip-cis-rules|
> +| Concurrent session control| - |no rule implemented in cip-cis-rules|
> +| Audit storage capacity| - |no rule implemented in cip-cis-rules|
> +| Enable Multi Factor Authentication for Local and Remote Session| - |no rule implemented in cip-cis-rules|

Again, we were already going beyond CIS in the security image, right?
CIS rules weren't applied because of that, or didn't they even exist?

Are there other cases where the CIS rule set what modified, justifying
it to be called "CIP-flavored"? Where are those deviations documented?
How will be maintain them in the future (Debian 14+, CIS updates)?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

