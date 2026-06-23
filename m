Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1AACD98F2
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 12:35:55 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20055.1782218152260860668
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jun 2026 05:35:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eucQIt+c;
 spf=pass (domain: siemens.com, ip: 52.101.84.2, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aORSIbj0cJE9dHfdKnU9TVwWopaIfQEYU6vweFN1ocOPXk0+6rVVZ+p7ft3YeGbQHJ48i79Y0M7+X7+yjzY7nHWTacca5UDxor8IQreyXaI+12e+m0Ft5dsd4Qz46K+Tp8ElC6qpvS7Sm7TJHcD6kh+tIPOsVEV+pPvfQF4ikYog+Ly9jncpymuYWXX5uGBJ72rUrOa2irjPl2M4+Wr7YQpb025JGrj+V4TyKskZFJ8V9hNXyx6X1b8KqLrwYpLiZPRnCaPRi3CPmpnNTuT0BB/T07d3c+tCm3SUOHdJRKRBhQkUkd+d8dZsb+6a3++vAC+B87VhThn+6UIMKQE3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBNczjEEkaH7rRWmuOBUo9MiAkaHD+2VYE6CwVERtpg=;
 b=Y0jUodHfygN4FrnAPSdkybByzIVwdXuJ2aAq91NA8PECafgcqPUn2mT5u88J/4roco4QCd+nN6rBKKg0Ua3+xPlPOhchnTPeBGR7paansQd3Y346Pjf/NRLMKOYQ2f2pQIuR9OrI1jRug9bxdAe9WUQLLDoUUpZyKouCYWJnCfurYwLMV773Z1hMKJU67Rgo7wmETjG9v3xZk0aZMiPNslQrjHQptXzs2kU/sV4EeZzW+wrsyzsb1gHaOOvqANhgfl8yhv3z6T4G8n9X/IswPzmv5qZrpQn6UJzsHHpHx3US9Ej5U2MU/Nq6bReRxh0r/JCbu6AYHiscPI0FAL0IvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBNczjEEkaH7rRWmuOBUo9MiAkaHD+2VYE6CwVERtpg=;
 b=eucQIt+cxnZrDpebUwjjD9XkG1ZJNOl/y4taxcmx+8CWCoSKpZ1qFcBdpc9cvdq9ElTHg43Bn/S95+r/IXWMk/4Bimi0HSg1vV6DGvkiloDeGHISdfYcn2FZuvQ+v16/9vGoj7JlOXOS0eoYSkchaWG/lIlrnfUlJFMh+duQZ8D9hB9eJuJzBDIW1pHbIZXXNenZVQIqdJ31C1scrACxMdcIEnncc1RtjpxcxRIblSbYHt3Az5K/1rCk2WUhM848JlY3rZLmTSblNvF6HqIDQpXLno69ivgPdEN+ffq8iSFd+jE+Yw9IwKQeJox4aOuGHx4u9CQHQ8wvK5SJuxdkxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5816.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 12:35:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 12:35:47 +0000
Message-ID: <eacf92a9-82e9-45a1-b602-7dbf42034b7a@siemens.com>
Date: Tue, 23 Jun 2026 14:35:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v4 2/3] Enable Debian Sid support
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: Adithya.Balakumar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20260623105234.972121-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260623105234.972121-3-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260623105234.972121-3-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0198.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e58076f-a54e-4499-c457-08ded123f352
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|55112099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	KOTtqNkbYD7WNy5FPDT4HiRTew0ox2eGbNJaCSPYlOhwsRm7b/at572HckaYjNKzPZm/lueXoUciHs+xLdTcDYtQ40lawHe6darIdinmV/rhkS/0a9x1QTeE0MUY9pV7vvNwdow//dIKLDc7XBThPSrunxNZIvCPL5K1NFRk3zPOsbFN7lhsAdOW+dmNiXfLj+ZrgmXcNygK3kunZ+am3TlBhIvSrY/8+oElav5MJGLPKqSTcUFFLD4yOGZ/0WIuncd3q8ck1A/a62UvKrU5mWY9JDK5FbfRoZAtxjfVmOlm/rv0C8hTc2B2A3MRgp313ey8jtEXuW24U1lHX0FcT50hqSEqOXPDYnnmQ74oOlLjBVdccQoZztJsNHA2TPtRxD3KINmOH1wL0XhvPKKF3vCaI1bPJgr149Q113nN52/jyi7jDr7HC2djL9aqd8isZjmjfmdQSd0y7mLK04F4kgdBW8Lr5ioeKSjJT437fFhjkV0zaHpicGh2tfW4hFDtJI5PgzHO3/Nh1GNeRJuX3Rc6wE3djYrboe+AmrHyRxYPW/kJ1gbbNyWLRN3RMd6M/g5lvHBMktMUDVDtNP+045s9OJJJC811lPnekWcXpuBEzAuJjDowM09mUNKXeMm8GT4zpRRCOKCHlX0vCKN40bFJ8keuA9kR/9aFWVCDzKI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(55112099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S3ZVZnpBcVdNYjhxa2hpZnE5NnV5U3VES1N2c1oyZWQwTk8vdEhzWGRobHJZ?=
 =?utf-8?B?bHVrS3ZSaU5RSTk3ZkRUVU44R1oybThsT0FuUUU1VUtRTy9vRi9LdDUrOHBq?=
 =?utf-8?B?RkYyZEpuVE9vYncraHd0aVZVWmJESllEUHBUMmt4cy81VldlYTY3VDBIZVVm?=
 =?utf-8?B?TFoxaVI1ZnZEeGZNMzBRMGxuUmRUMXZnTFQvWnE2bE1uZGMwODl0c0VmN3E5?=
 =?utf-8?B?WElrKzRpRWt5Z0xMVWE2RzdKNFAwa01EMXRET1dwaWRVM1llYjdrYkFTUVJt?=
 =?utf-8?B?TWRrUnBYQkJodFVMb2ZrWVkydWlmOFowOEJ2R3o4YVlxcDRuaVRWNzh6WFJX?=
 =?utf-8?B?WVRRZ1JEY1NDMitibVBqbDZuTHFoWUZGQkRtL3orSllQSzFXQkdrclhrb3NO?=
 =?utf-8?B?UDZIc05XbS85dUVkTGM3dHJ2RXVrR0swMXVWK1V3WE9LeUxZc1FBeTk5QXhN?=
 =?utf-8?B?SlJBS0pCY3JCOE1pLzl5ZGhFSzBNZVVUZGRYRTJWL05wZlJlSnYyMm5ta1lv?=
 =?utf-8?B?OXZLbGJxMnBGcHZ1eHZmbU9lck52bklwZ3JjU0hVam5kai82ZkU4TDhjZ1lK?=
 =?utf-8?B?dllRTjBkSjMvMWx1NWIyRVpON0xwRUQwRlBOckpEVVZOWUt0WTQyWXQzTGJu?=
 =?utf-8?B?UzZFTjduQUJrRGFxd2hUWjJENnhaa1RKTXl2RkQ1ZDI3aEkwcW1PUGxEVUlv?=
 =?utf-8?B?UmRXZ1VGTUszeUFJNHNScWJXY1hIWlNTejR2ZVJMMDllc1ZVQjNOdG5yWkEx?=
 =?utf-8?B?TkhjL0I2K0NzRENXYmowRGh6WG1qL0luQisvaHJCSGdRRGJkcy9nQUYxdWRq?=
 =?utf-8?B?MyttY01Hc2F0TUhuaVJTRVJiNHM3ZE9yQjlMSjZESmx0QVBWQk5iWE04OEhu?=
 =?utf-8?B?SjJFYnl6TEFBSVI2RVJIVm1TNnNTcVN3ejFiVHc5REk2eE8wRTBHNVV6SVFo?=
 =?utf-8?B?N3VaOStic1RoM0taRVFGL3VFK1BMemtoWHRaWW5NZFBWYzFtNzRlSStSOGtm?=
 =?utf-8?B?UWlzZVZyMUxOZU9FZTlnaVZqZWMyL09uUEtkc1FubHlNUVRTYUtSQUFLKzJx?=
 =?utf-8?B?THhNcldKVWRQZzFqd0hWWGNKNlQrRGJKcE9kMmtWdXVnM0kvdlB5MDdSenFj?=
 =?utf-8?B?cmN6NzF0SlRQSWVNOHpXZ2xZWDkvS2lxRUF3NXlpRUR4eUExNnpkdGpWN2hq?=
 =?utf-8?B?L0lkOGFCNXVRUXRiWXIxT2ZmalplSURzT005ZEo3M2V5dXBWc0hTWXFKRkxQ?=
 =?utf-8?B?czhCRFNIdVJuWEV4SEw0M2FycFB0ZVNad2lVV0VkWUk3VkltSGpTMlJBZGMw?=
 =?utf-8?B?WGRrSXg5MTB1eHJaTVcyenRpR0FXU0FKVWN3OGExaFpnZGlsaWJBVWwrTStw?=
 =?utf-8?B?V2RuMWxXNlBYTVBjdmlFNUczVWRjTjhYbEU5YmJZKzVpZzRZa3g2TnJTWDVa?=
 =?utf-8?B?R2RsaENacGpxUjhTNkRLb3VoN3dSS2tsVXY5anBSNDhLdDNtS001S2wrMDIr?=
 =?utf-8?B?T09SVzNFekNGRVlpSXBIN1BVSlEreWtkYU9UQnBxbE5WWVdTbmFneHVQTFZx?=
 =?utf-8?B?R3g2bnRjbHN6QldYcU5sME9IYWlRR3A2ZVJBblNjaDRHanZreFc4VmxTRTJX?=
 =?utf-8?B?ZjllUVZPNHJvWVpYUzdRVlQrclZlL04rdmlNN3hYVStkS25PZm9LaW1Xa2lK?=
 =?utf-8?B?NWkzS1cvVGNQRHhQbjNjVEhpSThYcGUrN25JeHBjYW41MGlXQ0d1dnNCTWdO?=
 =?utf-8?B?QVVnbzZPQUxlNGMyc3UwYnI1d3grTGZEU0tSdk5BQnNmYjIvSFEvQjFsYURt?=
 =?utf-8?B?dVR1WEk1UkpSMS9vZjJYVTA5MFJub2d6V1dvYjJtMjlCRXRmanhKWGs1SGlu?=
 =?utf-8?B?TTZZclQ3T3pNSHUyb3BDL1FxanFZQThkYmNSbi8zWGR5QTdRdWpTektIYVBm?=
 =?utf-8?B?K24vZ2h5Tm84dlBaNGlWVFBXZTdBaXhFZUJkMGZndzhXL2Y3MlB2RFVxVDFC?=
 =?utf-8?B?UGhsWHZVVUlrTWlKbm9UUU0zWmk4RXM1NHJxT1V3TWUvQjZYbU5VNlZvNENz?=
 =?utf-8?B?MzZ2RGRRbDdTMVBObXFyY1MwNjA1eDRCS05sUmJOUWJBbGo4c3BVOUhhMWdr?=
 =?utf-8?B?NElmMGlhYm4wNVF1b1NFMlI4RjdvbkZPRlJuT3hpdFZ3RUVtUWxRbzNWV2ND?=
 =?utf-8?B?b1BOalhidUI1YXdqMFV6NmVSNnkvRks1bzdUbGhZRlFmWXVmdmpGU29rbnNX?=
 =?utf-8?B?dnNwS1l1Y2pYemNKWjZ3cC9EbmQ3T045aDZJWUJ6dzRxSnl0REhjT3hTNlRK?=
 =?utf-8?B?OUdjSG9qUGI0OGRSL3J6NVBoRkRXUXFWc1R5WFVnWkppdUc5bFVMTFhveTVG?=
 =?utf-8?Q?UivGlIqIOcs6DkT0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e58076f-a54e-4499-c457-08ded123f352
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:35:47.0959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VM2vSoKZWKAUR5UxWf9DrvwA9B8f5j83j6T8LbixUCg4Sch0HzfA0h6cNjirpFUHAAfbUwTGeaA7R9iydoRPMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5816
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jun 2026 12:35:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23271

On 23.06.26 12:52, Shivanand Kunijadar wrote:
> This patch enables to build the images based on the Debian sid version.
> It helps to fix the issues in advance for the newer version.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  Kconfig                                           |  4 ++++
>  conf/distro/cip-core-sid.conf                     | 13 +++++++++++++
>  kas/opt/sid.yml                                   | 15 +++++++++++++++
>  .../initramfs-crypt-hook_0.11.bb                  |  2 ++
>  start-qemu.sh                                     |  2 ++
>  5 files changed, 36 insertions(+)
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
> index 0000000..2f6eb69
> --- /dev/null
> +++ b/conf/distro/cip-core-sid.conf
> @@ -0,0 +1,13 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024-2025
> +#
> +# Authors:
> +#  Cedric Hombourger <cedric.hombourger@siemens.com>

Copy and pasted - I'm adding your name and Toshiba as copyright holder here:

# Copyright (c) Toshiba Corporation, 2026
#
# Authors:
#  Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Fine?

> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require conf/distro/debian-sid.conf
> +require cip-core-common.inc
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

Here as well.

> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +distro: cip-core-sid
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> index 3cb0520..9132ad3 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> @@ -38,9 +38,11 @@ DEBIAN_DEPENDS:append:buster = ", libgcc-7-dev, libtss2-esys0"
>  DEBIAN_DEPENDS:append:bullseye = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
>  DEBIAN_DEPENDS:append:bookworm = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
>  DEBIAN_DEPENDS:append:trixie = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
> +DEBIAN_DEPENDS:append:sid   = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
>  
>  DEBIAN_DEPENDS:append:clevis = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools, clevis-tpm2"
>  DEBIAN_DEPENDS:append:systemd:trixie = ", systemd-cryptsetup"
> +DEBIAN_DEPENDS:append:systemd:sid   = ", systemd-cryptsetup"
>  DEBIAN_DEPENDS:append:systemd = ", systemd (>= 251)"
>  
>  HOOK_ADD_MODULES = " \
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

