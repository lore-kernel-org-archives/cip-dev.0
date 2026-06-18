Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69895CD98ED
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 05:07:51 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12861.1781759263629144154
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 22:07:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZEfEOMW2;
 spf=pass (domain: siemens.com, ip: 52.101.72.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNrF8XvjhGfxiwyQEn0FHBGW+pj2mk+F9otN28zxR1vwWAJt6fs/V2HEqVYgEczEBviKIeaFWk0wOjHzx8SXIQL6uHjc3Mdt1JksvUYnOy+EvoXcBZ28sqjZxuWaC6lrb/3TTrqz1ymcs4QEBRvBxvR/hC3qM5ONSDCXUja09Evoo80Tf51Sobx5CBqbAZ+g7DrI5iSXE1RsnX3FCwU+GyybXX8zW6CoYssgHLDkwZueoCaXkRCeOfDjbvkqjQddiZSyNcWWdxkWheOrF8+wLnbKhRqkczFoSa7l44exaRHfVXdtPSNtfX60pfIwV3W7dvi0/48wCeU2WxKMS9VXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z72qNQXg+fSejLx0ZmDuATuuss94UGBHwRUCW2F6oHA=;
 b=shfw3iB+MV4TtXlVnvLmdAXo12WnvklP6zLvI5FCtvG2pYg6sC1X6Rb1ltJ6S51ifB1pugq/NP1ODRhhLuAKdCNXo701vGDCqaYj0TT51iXF1suONusr7X7QRt+cCuxCTbt9YF04CxENJQ4YsaBicZMDye4g3rISgu4+JsLdzF26ksxyZX1cAvlOGi6ip+E+iTGajRoUkpZf0Z2UDmCPZfjTU3x/ysbXmWgVUGHiHicRTVbzt4uhYuQ+NIOsaT0PZE2b6t5rOYCBlBhFZYYIR6mhW/8XnOAvKdoMWZwBPrskComYNh9h+PNcQsoMvFmDyeMLdhrmw64fjmL4Db0u2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z72qNQXg+fSejLx0ZmDuATuuss94UGBHwRUCW2F6oHA=;
 b=ZEfEOMW21r7bC9j4sJzDCyoc5vq2hxcKUXQMpCYjmc4DcjGHaOpBHIQ34gcEcn9k+2D3CKlhpxKx/TsuV3tVwhw7nxbZVBVylfKc+oPsW0mbZ5DEVcn5ODP/wvpYUa6+mm0wGawxYwk9sUvNKxy7OuLdSb01+iAET3iBa1TzGPySAkaXuQNUKz8FRcACfIP6YKL1CRDIvc6CMHGo6kX5tpo7rJSh9PEMzJTH8LUpCyZSEGY3TuyUykqwjDpvgtoO9SLiWgh8F5lZ7/27+ZNr+RSLEIP3a43TVY2qjRf70upw2GH2S2HP62OZRvcduhRBMrWWf4Jz07M5UJWO5DWt2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8921.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 05:07:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 05:07:40 +0000
Message-ID: <8c762450-50ca-4aa3-8b88-42d067ce0e16@siemens.com>
Date: Thu, 18 Jun 2026 07:07:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/2] Enable Debian Sid support
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: Adithya.Balakumar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20260616050628.3560536-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260616050628.3560536-2-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260616050628.3560536-2-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: a5242615-872d-492e-c8fe-08deccf78537
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|55112099003|22082099003|18002099003|11063799006|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: 
	xN3i5xN7DhRUH8pn/10Z8NzvK4+gfzCCyXpuXh/CEx1Ikmfl2iaBjle4YKwL+XPI4g7N3G1JKDKo3WTTn7/3W4+1Lsz4xdN8z03xMbCRcgX/Gy0swYYVMxnvkoJpgpMEy4/VK3usaOMOEow+Tsrt24NfIqvK0eqPUuTpnctb8XjgdRXlT7I+bsBzehPrhlH8ZIIa6sgr3CwfrncGWrBump6wB/yPD3ceObt/gt3qoAtGK0meBz3e4NeoJ/byhF7YUj0gXVhab+MSE2fXqDB3MZdohaydrqUKgrl77emWbndld+756MSsdwr88O0b1cU34xiwF/HiiYWfgbXRCZn+cmSzOI2tw76rh1jl7WYEAY/ctyiuKncTvXmv7F2p2RGoCqCbA+P1D/0ipBsv9QTASdLe9BujOCMwXQay5nvzbXM82q+pHHJDIixkCBvsIlG3UTqtCZh/edfgmjgWucm2OCgbduB+MfLr6IiO/KHs0tyOCCBDYDeCclTw3l8waMwhxeOf5XsM8sCbkG+kfjIeeo3ioAFHPuM0+Waw62uAY/CCz1E7cxi9a9QiM+DldTC0dZ42VLBeBatdKiFJzqNfgEJU185tCDpVG4hYLM1R07Fb5AG1Rzd7V2sDZ+G+s8Dx9acPJnTeBuq2OZIcvjr1HP1AU/xrNZSDna0JyokrR+o37PF98rmfFUdnSCzBIwE9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(55112099003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZFowb2ZQMngwL1RFdUlFMTQ5dkVxd2ZXUHQxZTliRzZML0psTDdaV1pFbHMr?=
 =?utf-8?B?Q3MzQXNkd1lSMGFIaXJ6S01HZ2t1ZmJlOXc2M3lLUDdSYlpkQlBPOS8xb2JE?=
 =?utf-8?B?UzBSaGNsOUNlTnYwNzRucUlxYUxKSXFRS0pXR1Y0Q25NeXZweUk2MlN3eS80?=
 =?utf-8?B?aTZxNUdyRXpnOXNCYjdWR2lCSFY5cWxjZnF0QVR3dGNMSzBBWjlmSzN0N0pl?=
 =?utf-8?B?ZCtqWkRCbU1rSFpoMHVFMlJRc1YvME82K0g5MVhuTUxkbDR5NmRHa0wyT2pX?=
 =?utf-8?B?RTFKLy94Um5icmx0RXJydk0vbm5WQy9TNEo2VUs4TzhEVmhtWU5SNk8zRGlu?=
 =?utf-8?B?N09RSUdOa3QvK0xrU21VNjZjR3hqT3N5VlFMNEIxeVFlUDV3U29UVVZLRzdq?=
 =?utf-8?B?WUNlZTUrdmRJTzhFQWkyZnF1WEdlUXh4bkRXY3BSRENVN3paUTFrVXpudXJT?=
 =?utf-8?B?djdhUzY5WjMraWtSZWNHNS85bnEzeVoyUjN3Y3RKQTN6UGgrNUVsVHdTb3dq?=
 =?utf-8?B?dEl2OUo5YzViOUF4RDJkSFd4S1pTSEV0YktpRUd4SzJ1UlNjYlFlL05oQUg0?=
 =?utf-8?B?dUZzVHJwaDJHakpoNzNPcHdraW11d2hzOHlHSjd6ekI2YzFHOVJsTERFckdW?=
 =?utf-8?B?RXBKUXBtRzRoU1pPZHZSWFl3REFGMHkwYWFSTWJrUGJEOXAzS1l6Tkt3K0kr?=
 =?utf-8?B?MUsvYnIrc0tadVdSZnYxWEtEaGlZRWtiaTFxMkVsMzNkcDZlelhTTVRvSnhx?=
 =?utf-8?B?ZFgzdmN1bWFtR2ZaM2gwbzhnYmM4dXJSYm5GUjZLMThDUjFsbjBsY0NBblRI?=
 =?utf-8?B?OE8vbHdkUUdUeGdLLzlaNFlKVkpIcWsxZkhVSnY4VHQ2TzY1MDdva1QxQnYx?=
 =?utf-8?B?T2ZYdGx2Vys3bFhTdmxSWFc1dFg4aDdBN0JENGViK2lENitSSTJQQVhqSTRN?=
 =?utf-8?B?SlRNblFnb3NwTjJ0VFMzdjhVaDc3QUNKbGxqbVp2eUlQa2dVdVNHaGZ2aWo5?=
 =?utf-8?B?ZlNBeHpmcXk2NlAzUWhucFhtcVIyL29sQysxWDNXUmlpdjNCa29YTEJHZ0V1?=
 =?utf-8?B?VGU1RDJWbEpFN3JFYlg5OXRETUtNR3FxcXI2YTJkTERtQjcxd2psK3FGM0dp?=
 =?utf-8?B?NmZ4NHcydUhrb2o3VGRyVlpGTVdsYzQwMWJRdEVRRTFTODUzTWEvRG1qd2Zw?=
 =?utf-8?B?VnA3SkN0UzNlR2JUNXVQaXliOVI2RGtXK1dOdWM5QjdhQmJjZ1c5azlCOHR3?=
 =?utf-8?B?UnVPR2MxSHRMME9PcE44Y2V4STd5WGhzRFRsRVlla1NJS2NuZ3JWbTRLcStv?=
 =?utf-8?B?clMyaHpHVVdVOGxxSC8vNi9hdzVsYWJ3UWFJck9IL3pSZWNrZHpZRW1MbFZh?=
 =?utf-8?B?ejh3cVY5ajNob2NFaWFqSEFzaTFhNldHcWw0Q0p4K2s4NERBS0kyUEh5aVJZ?=
 =?utf-8?B?QVJoaTlzNThUYy9QMXN5d1dENzdvTkRTTkJNdEFaRk42bjhCZmNKRnpiclNP?=
 =?utf-8?B?RUJ5cUQxUmVZZWZud1puYXliMDlCK2w1b1BYTU42V21KeGVhR2hwTm5vd29F?=
 =?utf-8?B?Sm12L3JnK2JtOTRTSXFqZzhiSmVLb3pVS1NLdXJzSUxoT0xTNFJkQW5hZjBi?=
 =?utf-8?B?SjRuWFB0NlRQYUJ2UEhRV3hiMzVwZFMyMDlscU5HOWFRVG5sU3Z4R1FTaE92?=
 =?utf-8?B?Q0piQjBKZEdwcngxWGFZYUNJV1d3YkVYNUlidzBmeTZZNmR4aFJTZ0t3SVhC?=
 =?utf-8?B?MFRnWmRGazVWYkhDYnRES2hNcTZDRHU2YWxkNEJEbS84S0xUYkFLakg0em9N?=
 =?utf-8?B?YW1hREVmZkNBSU1VdWVXNkd1STBTQjVkcndITEFjcHpuZ09xYVVNUUlVUkdJ?=
 =?utf-8?B?RmxlZkNPdHE3UHd5cDNVOXNMR0ZsL1dVdlpOaGN0WkxvSExhS0lWRWlLa3I4?=
 =?utf-8?B?SDdBamVKcmxxMWJsSnFWSGhnSWdzeEpNazdMQTNxYTY0elpYZExzR3JwamRJ?=
 =?utf-8?B?Q2tUU3NSUURSTUh1Q1l3UU5kVXRxYkFwYmw3NndoRFhLdVY2YU1iVTFjbEVC?=
 =?utf-8?B?T21zNkdKRUJQazJTUkZEMzVrRTZJOVc5SzFtcWV1NWhkclRJSGJsdm5QVm1n?=
 =?utf-8?B?d3IrUGNHNzJGMEFIRkdFYllINzVCVU1nRjBZMGFxZUxrbDRQQldsdU0vWkRa?=
 =?utf-8?B?QkR4cVoxbnhEL0kyOHZ4T2dlbGY0SDV3T0VESk12RC96Um1YWkZrTU4yZ3Rn?=
 =?utf-8?B?TmFGaTY0S3JLYUVXbHVwWkZzTVk4QnlPRHlvR2s1VWZmNXNqK2ZXVENLWS8w?=
 =?utf-8?B?czVaNHVmc2szVUh2YnB1WWJzYlIyQ0gyNFJTUlVKS0hPZmI5RXltUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5242615-872d-492e-c8fe-08deccf78537
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:07:39.9299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VnvPCHdnW7nOr03WUXdF0HxkbR7EcpYhQdC6bZngOuiBa9C0vc0jcnCNSBKNP7LOcvDTPWB9rv70/F7GPMeoDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8921
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jun 2026 05:07:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23220

On 16.06.26 07:06, Shivanand Kunijadar wrote:
> This patch enables to build the images based on the Debian sid version.
> It helps to fix the issues in advance for the newer version.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  Kconfig                       |  4 ++++
>  conf/distro/cip-core-sid.conf | 16 ++++++++++++++++
>  kas/opt/sid.yml               | 15 +++++++++++++++
>  start-qemu.sh                 |  2 ++
>  4 files changed, 37 insertions(+)
>  create mode 100644 conf/distro/cip-core-sid.conf
>  create mode 100644 kas/opt/sid.yml
> 
> diff --git a/Kconfig b/Kconfig
> index bd2b7ce..44f2337 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -239,6 +239,9 @@ config DEBIAN_BOOKWORM
>  config DEBIAN_TRIXIE
>  	bool "trixie (13)"
>  
> +config DEBIAN_SID
> +	bool "Sid (Unstable)"
> +
>  endchoice
>  
>  config KAS_INCLUDE_DEBIAN
> @@ -247,6 +250,7 @@ config KAS_INCLUDE_DEBIAN
>  	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
>  	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
>  	default "kas/opt/trixie.yml" if DEBIAN_TRIXIE
> +	default "kas/opt/sid.yml" if DEBIAN_SID
>  
>  comment "Image features"
>  
> diff --git a/conf/distro/cip-core-sid.conf b/conf/distro/cip-core-sid.conf
> new file mode 100644
> index 0000000..0a2a2da
> --- /dev/null
> +++ b/conf/distro/cip-core-sid.conf
> @@ -0,0 +1,16 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024-2025
> +#
> +# Authors:
> +#  Cedric Hombourger <cedric.hombourger@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require conf/distro/debian-sid.conf
> +require cip-core-common.inc
> +
> +PREFERRED_VERSION_linux-cip ?= "6.12.%"
> +PREFERRED_VERSION_linux-cip-rt ?= "6.12.%"

We should define the kernel default version in cip-core-common.inc
(extra-weak) and only set it to different ones on the release confs if
they deviate. That way, sid will always use the latest CIP kernel when
we update that in the common conf.

> diff --git a/kas/opt/sid.yml b/kas/opt/sid.yml
> new file mode 100644
> index 0000000..d5dce00
> --- /dev/null
> +++ b/kas/opt/sid.yml
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
> +distro: cip-core-sid
> diff --git a/start-qemu.sh b/start-qemu.sh
> index 7ccbefe..d12fa23 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -45,6 +45,8 @@ if [ -z "${DISTRO_RELEASE}" ]; then
>  		DISTRO_RELEASE="bookworm"
>  	elif grep -s -q "DEBIAN_TRIXIE: true" .config.yaml; then
>  		DISTRO_RELEASE="trixie"
> +	elif grep -s -q "DEBIAN_SID: true" .config.yaml; then
> +		DISTRO_RELEASE="sid"
>  	else
>  		echo "No supported Debian release configured"
>  		exit 1

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

