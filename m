Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E78DC53209
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 17:05:16 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.35])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36113.1785171906138809468
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 10:05:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ytrxznKN;
 spf=pass (domain: siemens.com, ip: 40.107.162.35, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpLNA0N2itE1XEqlsBkeYx+Ho8bdeZFyByBfcAvzjHlk66WVySvxxkuEmjOPHwoi1c+rwjxIvHmA0jj37n0MYy2L2IU8qblLOgm44ELz+htYP4S9Pnxfcl4IHGcA7FOvPOTycbGZC2rg6ZneyNBpbGdGDTO9vbhdTlWhqKx6WXY14hnAN1oh9RfFCqqeMuQ5juyEMVvaUBel0jdmEf4FxyCZ3vwMqhs98gwOMJwLd8+IUSgCnjdnEliy04uc2MIIVOuxOZ4gLnTDizWB3d+taUgxBxRUNbyASW0zBX2Rox2xBVVOvk0aFOa+N6fzVQX7FnTZbfsY7VlMKyVJSZGgtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zV+kYpyURu25TI04dWb9b28wrglQ6eCqXzC+mh8qaUE=;
 b=IxTMUbXPXSkJy/lbTzVBKBHnNDrkah5Urjp5j4MHlQyS12i1nq+zDuavGis6w5WMyyY1Qvh1ccjF/yQO0NLduYBaqatX9n52lQi7euvUm6bwQR6ws3Ukg0c1bwf4/IAFmpYQrUQLBXF8RTPBwrK1DJtopRPQLmWbrMzgiUMltGkMVjZPZQd1cVWhuNVPlp+0JZHtUoDRYOByXdP1zDXZZDqjGIJrw6s/xJEkRY5c5gKIEnENo6w1W+2SfdFF6+X1mSCtBHbX+o7LztGXbeoAeN5LdxydgMXZRa1dOh7yW51Ek37TcqTT+2NtM2SDKK3eoNHnihEzLWI9UvnM8g0siw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zV+kYpyURu25TI04dWb9b28wrglQ6eCqXzC+mh8qaUE=;
 b=ytrxznKN8gCi2BULxrIZ5KpKHBNdu+Wl/ffJZaObsXJE8HPeVEfudX8CjKFauePe15Aoi1qPbBbJlJvFZS+DUcMWGSGLdn+DJj6RkovJ36MnWAn+7tmAwOHzj/EeYLrbZND66ggIh8w06oG9Ocoexv9Snas+WOG7Y+UUHX8FtGnb5K6NthYrfK5RdkLFPLOYKaXaqQhmYjgs7RWBmPT1NGaMsC2QPZwy80vxSppbHNiW/LEqPDmObW6180R3wdl/25cJ782OiJ3UmPO75RzIl9R2nPCFssot11Mk9n8ghVetjfB8g4mdV099UPIlC6Crlfx60m826uQDtGIJxCnkeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5310.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 17:05:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 17:05:01 +0000
Message-ID: <e7db87cb-3908-4b4e-804f-a6cfd8c2e246@siemens.com>
Date: Mon, 27 Jul 2026 19:04:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1 1/2] Enable the support of Debian forky
 based builds
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: kumar.dinesh.h95@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba
References: <20260727141136.1773671-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260727141136.1773671-2-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260727141136.1773671-2-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0001.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5310:EE_
X-MS-Office365-Filtering-Correlation-Id: 916ff7e8-5ba9-4bbc-4423-08deec0131ec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|18002099003|55112099003|22082099003|4133799003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	b6lMrgfVKRihEkxA26TvSTVtp6d0VMJB1YAWurJ6lCYO99d0SZvy3MGTSgBNlorjaixCwuWqlw5t3ykaEGImrT4Ddx8fmgV0fjrb9/gptOPUYAu6yPC+0CKyK2k0A+ojBjCcjadGrBQtk6NP60p6zcxLC+sDUPo7b/A2tklJMd9/AmR/MoOhynkyzKTh12UWfqq9nwZvtuEpXMPZIqCPtYdyhmLlMLFo5QltH896DUI2/6wOaERhmdxLIYDaQM1YefJzV26bKEe3U1mnX3Fn2AEtbzpwRH1Rq+Oe5rXEZ6FKTJHZAZ8IwX6BT5JBPAw2Nkr6CTmEyNDpyAXCBD3AUcdyuCsQacGuo9rtyhgFny3Zmb6Bs1lyitdsRXdORxZLzpRqLY0dAjxqUCn0gJe5W0jCzqmjrR9DrsIOI1sTdnJG09/AXkpKM751OOK00kCRDMVZVf6KrnT1tMEj18f9+Pp0idU/XknqptyPhHV8CTjVW/1XjxlCfVZz4dhSeSkxTGx/76aQGMOs06r/t9Rsv070OSQseqs+8s2m8/zCzgB7AJAeXpnGD09Wwf+WroD5kmGstYpjOZO5/aseVCXhi4sekxuU3FD+JR6vHoFQNqmBNIhlkS73uGqpI+9Dq5EQkYFSXccsWLZchir/iQ8HHqzMu4vfuAx6DIQ+mayBTBk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(55112099003)(22082099003)(4133799003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NDA1VWJJNE9za043a2ZtMnJNZFcycW1VM3NHdjFMTUcrMWRBWU9DS0VxMFMv?=
 =?utf-8?B?ZHprYXJnWkJFK1A3bEEvb1ZENmtqc3lnT2RJRk5uZUR6WlBCekp3S3E1RENR?=
 =?utf-8?B?NEMzNDVCWk5kbVBzMk1nVHJjakpYS1FzNzRGRWpicjVIN2lKWFRQVHRUMGNh?=
 =?utf-8?B?WVY4cFJhd3p1R2szYjRPZ2k3eEdQM2JrcnZKbk5MMFpnTjFzTWFQT253MzlS?=
 =?utf-8?B?VzRuUUlEZUNiSVNVTmZJQVQyN0FNMWwrYTBOMHhhMjcza0xNRjBNWC9pOENO?=
 =?utf-8?B?enFmZ3FQbjNLRGhDTVZ3UFQzbTNKeWFrR0FkMVRSdEYwMHAyTjFncExTTS9j?=
 =?utf-8?B?aGtpbTlTTUF3ZVhOeklIenhXM0V6enVuNyt4eUdZTzVFMnREM3MzMHIyY1B2?=
 =?utf-8?B?UHREd1lWSW9zTW9aMWFPMituVk9lS2gxa0w5S0lCWTg0YkVielRWU1ZNMW9K?=
 =?utf-8?B?VlBMY2FDUHJ2bi9nS2FWeGt2R2hDTTFUTjRNeStyQjJIVWR6bzFrZ1BGVXFH?=
 =?utf-8?B?UjlnM3ZLRE9MVzJ1SlhmRTJPTUZWOWN6QzQzK3lZRzBhemV0ZXJ6eWJ0RjBa?=
 =?utf-8?B?RGE5WE9nMTE5bWlsR3JYbU53Z2swc0drVGdva3FwMUZvdGhTaC9aYnBjMmtF?=
 =?utf-8?B?QVp5ZnRQOTVxTWQ4Yk9nVUdPaVJkbHh4NHkrTmp1L3N2YWpOWlNTaVFMcUo2?=
 =?utf-8?B?M09EK2Z2bXhQeW5QUzhiaTFjdjExSTlpQktpQkp4MVc4ZUg2TkVYTGpUaGcz?=
 =?utf-8?B?eVJZUjA1V0x3RTRoRTJkb29XZVE0MDc2RjNmdGtxQUpHZ2JsVTFPbzdqZmVv?=
 =?utf-8?B?b21aa2t3NmVRczM0S24xUXdRUEtIL09NeE1iRkZ3cmlHR2FoYkNZNUtseWdv?=
 =?utf-8?B?RWE0bDk4Um1OZ3R4K2xhZUNkTzd5bW5pVmwrOGdiMm0wbjdpayt2OUJaTm5X?=
 =?utf-8?B?bEtqTkJNNllxbG4wTjE0cEpySmNGcTdXNE9MWjZtRkFBM1JCY0hmQjlUTDFC?=
 =?utf-8?B?YnJaOTZSWnpKYkpZdW9lNDZ4QVJrZjg2NTlhbU0xWlIzdEVsVTd3YlBSOEZt?=
 =?utf-8?B?dXVhV2IyTm95a2xEUHZmTUo1bmxUOENudS9vVHdZYit1L0R2R0hYRUlKT01H?=
 =?utf-8?B?VzZ6ZUVGaklCaWs0STVPU3VmLzNGeU1mVUZMUXc4aE9jUGpid1VuaGVxYWF1?=
 =?utf-8?B?c1FxejJiU3FvK2RWZHFDYWIxL3J6dSs5dEN5L0tDc0Nxem9mUTdYaFlzcjZE?=
 =?utf-8?B?WDRFamFCSUgrUzQxcnovdVorcnkvVXE5dmFVUmFnQ1p6c1AvZ2JUL1EvM2hZ?=
 =?utf-8?B?YytKRTA4WGRNVXNyd2F2d3hhclV1M3g1OExlQjFpMU5YZENNQlI2UCtvcHR2?=
 =?utf-8?B?OHhqQ2FPM2NDQzh1Ni9YVXhVeW5VRmNqVjEyVk8zeSt5NUhMRVhJVTVjN0Nn?=
 =?utf-8?B?eWJneCtPRVBXMEk4Z1cvQ2JxSnhZV2R6cTZJU1hZZXlnVnZyeUJGMlVMcmhC?=
 =?utf-8?B?UVc4N2JVUENENWwwZjc1c0xVSUJxQWU2ZXAyN0hQQWVUa2Jxai9aK2hwME5s?=
 =?utf-8?B?TjlGeit4TUtMaWE0aGlDZVJ0dlR5aWx3R3FjdE45VlBPc3F1aldKdnFWUGx5?=
 =?utf-8?B?bjR6WndxdEU4ZkZqU3JNZEx5YmdhSGJBekMyMVFVUVdyVkNFU2ZNRWQvWEs3?=
 =?utf-8?B?MjFxMEZ6bVFzSWM4TVVDMlpXMXFtNjcvbS9vQXBEeWRKRUJpVXhCQ1R4QmtY?=
 =?utf-8?B?dFgzUVF0YU5WWHZqQkNjL2V2KzVzeWgvWUdvVFpuVy95MWlUZGlUeFNLNnVa?=
 =?utf-8?B?K21aMmtidGlSNmhlc1NTQlZ6T1ovQlFjMnJPTXF4ekovMU9uRzlOaXA3cm50?=
 =?utf-8?B?bWNwbUdDMy9Ddkx0N2FTTm5XblAycmNTSDI4bm1CMlpmd3h5cm5wNmdwMFd2?=
 =?utf-8?B?aDlGQ0VjSm5YbUxXcTJrRFZhdGlUN2JiVytURm55THR6OGtUemp4N1hoL2cw?=
 =?utf-8?B?QkRkeHVQUHgvRWhrYWxXcTA2cCtMQUEyOEN4OG1WNnFwNHhFVlR3aFJwU1hr?=
 =?utf-8?B?VUF5aWNhMi9LOHUrMlhQTEZlUWk3bUxaQ0pTZitIL2VDeCtmTjVCNnhLME4v?=
 =?utf-8?B?dDEyMUkrRGsrSXZZVXRRMUpQaEkxZEVXSE53VlY4ZUYra1Z5NHdCKzNITXR2?=
 =?utf-8?B?cFhWdWE3dEhnUDZMQThITWRpb29vRHpYL0V6TllNb0llSlY0cHF4SnJkQjhN?=
 =?utf-8?B?YnROUmhHa1RPK2V5Ynd3NFVyNTlCMmhJMEVhbkhQejVCU1ZmY2VkbzEyQ2Nk?=
 =?utf-8?B?WitFSVdUWUR5RlU0OVMzM2NnU25GOU5RWE03R09taVVaVkMxa3B6dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916ff7e8-5ba9-4bbc-4423-08deec0131ec
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 17:05:01.1753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbWoO7/gEG05n9lwg0fAfw85hnXa+oJAgDJIiSH3HMWjpKiqVQW/Jq1y699bhvbRpuGQLvgMHJlT3FI9zh89LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5310
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 17:05:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23785

On 27.07.26 16:11, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> The .key & .pem files are addded using below .deb package,
> https://snapshot.debian.org/file/d32d11a5aacbf5685b81e8176a27a6918e9b55fb/ovmf-generic_2025.11-5_all.deb
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  Kconfig                                       |  4 +++
>  conf/distro/cip-core-forky.conf               | 13 ++++++++
>  kas/opt/forky.yml                             | 15 ++++++++++
>  .../files/forky/PkKek-1-snakeoil.key          | 30 +++++++++++++++++++
>  .../files/forky/PkKek-1-snakeoil.pem          | 23 ++++++++++++++

So, current sid uses different keys that forky? Is that always the case?

>  .../swupdate-certificates/files/forky         |  1 +
>  start-qemu.sh                                 |  2 ++
>  7 files changed, 88 insertions(+)
>  create mode 100644 conf/distro/cip-core-forky.conf
>  create mode 100644 kas/opt/forky.yml
>  create mode 100644 recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key
>  create mode 100644 recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.pem
>  create mode 120000 recipes-devtools/swupdate-certificates/files/forky
> 
> diff --git a/Kconfig b/Kconfig
> index 438234c..14cd677 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -241,6 +241,9 @@ config DEBIAN_TRIXIE
>  config DEBIAN_SID
>  	bool "Sid (Unstable)"
>  
> +config DEBIAN_FORKY
> +	bool "forky (14)"
> +

Let's sort forky before sid.

>  endchoice
>  
>  config KAS_INCLUDE_DEBIAN
> @@ -250,6 +253,7 @@ config KAS_INCLUDE_DEBIAN
>  	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
>  	default "kas/opt/trixie.yml" if DEBIAN_TRIXIE
>  	default "kas/opt/sid.yml" if DEBIAN_SID
> +	default "kas/opt/forky.yml" if DEBIAN_FORKY
>  

Here as well.

>  comment "Image features"
>  
> diff --git a/conf/distro/cip-core-forky.conf b/conf/distro/cip-core-forky.conf
> new file mode 100644
> index 0000000..7a868ce
> --- /dev/null
> +++ b/conf/distro/cip-core-forky.conf
> @@ -0,0 +1,13 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation, 2026
> +#
> +# Authors:
> +#  Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require conf/distro/debian-forky.conf
> +require cip-core-common.inc
> diff --git a/kas/opt/forky.yml b/kas/opt/forky.yml
> new file mode 100644
> index 0000000..6c4fcdc
> --- /dev/null
> +++ b/kas/opt/forky.yml
> @@ -0,0 +1,15 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation, 2026
> +#
> +# Authors:
> +#  Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +distro: cip-core-forky
> diff --git a/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key b/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key
> new file mode 100644
> index 0000000..dd7f492
> --- /dev/null
> +++ b/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.key
> @@ -0,0 +1,30 @@
> +-----BEGIN ENCRYPTED PRIVATE KEY-----
> +MIIFHDBOBgkqhkiG9w0BBQ0wQTApBgkqhkiG9w0BBQwwHAQIs4RXCLmGLJgCAggA
> +MAwGCCqGSIb3DQIJBQAwFAYIKoZIhvcNAwcECHer6014IEhGBIIEyO8O2zL8CJwV
> +auQpWLJsMMWxu2aSh1WadX9+rg+O61mukuS4rQSH5shMQ2krZZKzyXx0q8+2AySD
> +EtDXwhLvep60gUxOoNqK1+l3AxSFfIGOY8NC6yW67VX+G09ajWpgHj3ox63VRW8v
> +6mA8TFWYbOIwB8J7ScF4NszVwyiUnW13oKi7svoBM3LYYG2IMvre+gOvyMGfM8uv
> +X3txcYqAjhRV6n7vGo9LRLIIRSPKzaJbm/W7nT38LRUJP8JMSQUOPKgeEwQvOTVZ
> ++1kd7WeaGZrjagTDM4yhBjpOmB3D8aeT6xkjBlUwuddPzbdi0N7GrU520RcJMjxt
> +JMyOgabHKUKmPTX4m0ZCKi2jSILi7/6fBF+TZDxpakLwAwpTzm6kXArXb6AYtTEX
> +GPihB4O69ZgEc90jp3EnZt7HtKZn1HTbPNQAlWgvESgJ7hWHnTlM5Obqnyb78tj5
> +VdcOfTSQRYmw4Rh/lSUX0vQLhdmYSVLiMFFvT4IepXZgQ6McIdcvqoVrPgr0HoVz
> +5YILZdmbs80VcgYL853lMfQ84kRwUcw8jNyz7mBK7V7rE5QhaF5lunZ/R41ZRXRy
> +1ys1rNvLPvtOq/K51+A9U+h5lLM9LjeoOR+IUk2Vg4aIap+Z+lxbImH0gcJTrpem
> +ctA/2sBjLN7w811EjB/Tlu2awzbsKLpIDFVGHiGBI2zb41gtPd2RkijmiZab6nuM
> +ETg4ad3GscMoa++01oX/lrnVe386ECSjurmThb7I01eTNZrBlNsLyBeFzlEIEoBR
> +TqUXHLiDACxzL6U4vWzdnvVrCOW9fwvJJqChj7Wy822w2LXxVhOryNujBmZCmOht
> +mgDaJ15QiF+DACcX6VoBbm/462z+9Skxa0DqGwGzMOD5HldwvQSyZSykk/BzGFWP
> +rXfLYoMjN+dgA/yNfem64ayGsmoPUAjnsE4YasD58UVO0XwwtdMGJSOVmkdyWMcM
> +t+lN74kX/gmIvciK06N6prBfowgBEIJ6ev2dzlydSN8rGORmQ+OFzjP14rT0O+1Q
> +O48yR2ZZ9jl4YPUKSFJ3EUc/Qt9vO+chNiNYSy6TABGXur0WWiDvGURG9K5fWTqq
> +U2KydSRoYD5iF0caOgMZecNhZV+4CX927j3XuuKKx49qTAt3WMtmJ/UQFHMtQ833
> +XDFWHpEKDImfHfyiB1f8bOmqYmPuE6Shup0UMJsMFel4QVJM0Jn9+wHw/0qqPiS3
> +a769S/u9U2dfyZY5PfymY8UjFRMDtLaUoJSRaGp6RNc6LynuMMKdzho0GwvL3+m9
> +xKLDbbks8hVdmtcxxDKiio+F0hp3yc/2PyA/VGAlARiGp7876WTCZox9Bwnf6lkS
> +k9eYLSabe/r3Ag1SbWEGpFk3VO37qCyfp2xTfrHXK1ZJlvFwj3FFSprUaMrV+81K
> +FCEcSozXpVsQ7e7d11A7S8rTbtp09Q/J2oxyR0A9lk/ia5Qd/xwbPl4QJcWK2Jar
> +K3yFK8VrUNib7CjI1kdB479KIllD8oK6druBkzwGzFxDtcl47RlfkqW96XSQT7x/
> +h/YKSLcpMx9x9TJd2GDKj2t4oE9eGTBC0YbdH+HJNSrjEsWkjgY6Uw++S6VzKvQZ
> +DDsMJfxwcChc2zKRou+BFA==
> +-----END ENCRYPTED PRIVATE KEY-----
> diff --git a/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.pem b/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.pem
> new file mode 100644
> index 0000000..7cd2487
> --- /dev/null
> +++ b/recipes-devtools/secure-boot-secrets/files/forky/PkKek-1-snakeoil.pem
> @@ -0,0 +1,23 @@
> +-----BEGIN CERTIFICATE-----
> +MIID1zCCAr+gAwIBAgIUDMG7xGGEPj+ABvbflim0PNb/loowDQYJKoZIhvcNAQEL
> +BQAwejELMAkGA1UEBhMCVVMxETAPBgNVBAgMCENvbG9yYWRvMRUwEwYDVQQHDAxG
> +b3J0IENvbGxpbnMxETAPBgNVBAoMCFNuYWtlT2lsMS4wLAYDVQQDDCVTbmFrZU9p
> +bCBUZXN0IEtleSBmb3IgRUZJIFNlY3VyZSBCb290MCAXDTIzMDUxOTIzMTE0NVoY
> +DzIwNTMwNTE3MjMxMTQ1WjB6MQswCQYDVQQGEwJVUzERMA8GA1UECAwIQ29sb3Jh
> +ZG8xFTATBgNVBAcMDEZvcnQgQ29sbGluczERMA8GA1UECgwIU25ha2VPaWwxLjAs
> +BgNVBAMMJVNuYWtlT2lsIFRlc3QgS2V5IGZvciBFRkkgU2VjdXJlIEJvb3QwggEi
> +MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDIi65d6LmojD5S9q8vE/LI2HHQ
> +boiO5/1KrFVc6kpxD6XdkJwpBoItYIfSls9CPnzvNWOAxR3hIeBd1U/prAPPxvQ1
> +wuDLMXfWkcGaYHfPnme/YluAjnpuLH1MQcumgOzj5xYBvZZk+RbytX/phH7FW4Tx
> ++L1oBYnsfh3BSE/NTtEEHV1nXAXpa/dvyefWMlrlbwjfM5362lZzM6yrJGcOcWEy
> +I66UYCIVO2Yhe/ZVF5B/tPGtd2oACz11xLeqLPM1WBjlekAG2Zi7UCPIvDCpdn5u
> +Vna2ZRQmJyDDdh0Ja2VMC19dkMd/5nOAI21O+FvYPOkBWYX8f4DzDyVQlmIFAgMB
> +AAGjUzBRMB0GA1UdDgQWBBRjuNXuXfh7mi8I3eTboeYGyFTa2zAfBgNVHSMEGDAW
> +gBRjuNXuXfh7mi8I3eTboeYGyFTa2zAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3
> +DQEBCwUAA4IBAQBBxlfo6MxBN44mXBIhE/QUbJZ+bo/Vrqv2DIZqOlV5+Sk6KnK8
> +X9Rz2IJwoqLjB6cW9yInk5P/QS45880K1fDT/lu5/2U64i3l1ZFK75qLDCn4/khF
> +birV2U6LBZpxLe3UvXk3xZMoUPzvT2rhrsf78G0pSmAnP8li8Co8F6hTjQzB8IgC
> +DpYVATCoWBH6GhudtjUp+CJSyGApdL+HKX6i6oD7vutvWYBf0Hx5r1NrqIv31Y4V
> +bhwvK5zajFamj/VYeVy7/roqD06hNF1ImhsuBOqoJlKu+cHMGN9DOJqjGup1T9aI
> +2dpEOK5vbKXFrox/yCLgXmUkdwZ3BK4lcxCq
> +-----END CERTIFICATE-----
> diff --git a/recipes-devtools/swupdate-certificates/files/forky b/recipes-devtools/swupdate-certificates/files/forky
> new file mode 120000
> index 0000000..2719d00
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/files/forky
> @@ -0,0 +1 @@
> +../../secure-boot-secrets/files/forky
> \ No newline at end of file
> diff --git a/start-qemu.sh b/start-qemu.sh
> index d12fa23..0b783d6 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -47,6 +47,8 @@ if [ -z "${DISTRO_RELEASE}" ]; then
>  		DISTRO_RELEASE="trixie"
>  	elif grep -s -q "DEBIAN_SID: true" .config.yaml; then
>  		DISTRO_RELEASE="sid"
> +	elif grep -s -q "DEBIAN_FORKY: true" .config.yaml; then
> +		DISTRO_RELEASE="forky"

..and here.

>  	else
>  		echo "No supported Debian release configured"
>  		exit 1

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

