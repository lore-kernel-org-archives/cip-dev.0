Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3C6C004D4
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 06:35:21 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.87])
 by mx.groups.io with SMTP id smtpd.web11.9817.1674023720261591964
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jan 2023 22:35:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hZYbRlz/;
 spf=pass (domain: siemens.com, ip: 40.107.7.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q85tRLrsHzOVh91mfZKT7ZP6EAewPxpxw2igmDI2T/EJlDvUS3jEmL3gUAhzvTenRLtKXMxf7QCotHRL38BelS3GEgv4zNQKUrDUP6w9D7SBmHcpjjYl9QNGtqxkIRv9Qaw+nfIuPh50srNMP1h43MHUypQKgeKrQkE0a3+vYcAJv7YEKJQ0cz01k67DvBfqm6wJjLWUOjaX0M4BdFZirmxJnWCuGKjM+pdOFgQh/8EUlMYO3LLVqpLgtkqP49R96t7juJQ/PSG++J3OfLJRaPDDFtMrbB1b0YH5AeFDJQ3wmWMcoZJHH4zj0JmzikhLxAwUAsm/lEa28yVn7hmE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HijcaONuKJBNHzjHoljc05/6XdktOpKpP5qW2mKXWGw=;
 b=ZLF0VdsxQGB2y+O9hnOk/qyZJgcvyUmwl95//pOfBtooJdAC1VCz1uWhTnhk4GAS4G+qrWHPw7BQ9nkp16/+3DV6RDz8tLZSWpphTmUziKmzTn/tNDK2YV0kp/UuPYVwJUDM56890m6d4ittavZ9WcCgf6NLLSYC/BEsmbtR3+cqcvAUel68R7JaGT4EjDC1BOI9aXXaAUqRLHjI//0OYUWr2GBqOiX/udWHqPDjz6eiLIfU04HIQtOCnf5Z9QOnFQLA73yrt/wtvr4nlp7j/gZpSSlJaLqa/6RH7xi2izZfmw2BFTzlhK4IGlZ+Il/cFFe05N67m9XpMM3mBJRWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HijcaONuKJBNHzjHoljc05/6XdktOpKpP5qW2mKXWGw=;
 b=hZYbRlz/JTaDU+U58O3F/NXLz9WT+oAPdDCyb4ldXZcPksY+6q+9M4R4vYAvsVnZGcYqTvKsEQDbTCeSPSUz6N9A6nClI5u/r/wsFstGJ5xf/Yearf4W6IQfNUSrVpkB/pLQ4KFxjyw7unD/0+b83nTMwoJrjZni91LF86WA3l/W8aBEUTRcrhrp+igSQ7qCs5PSZGpjU/oneT3nI9MgjeksxPLuRpXcQ55beG2frZd70dyLGAUeM9jGPbSactLeh1f0RBzkWb/OBQnyNvBwEqSobUam52bDwsogIkO8ZnFAbZi4dCIE9pFgpTwE2Z0FY7P8was9HjmfglO8ikfZ8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5857.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 06:35:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Wed, 18 Jan 2023
 06:35:16 +0000
Message-ID: <ceeea435-4bad-9b96-ecb0-8cbc021cb8d0@siemens.com>
Date: Wed, 18 Jan 2023 07:35:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core][PATCH] Add recipe for EDK2 StandaloneMmRpmb
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: "Schultschik, Sven Angelo (PD PA CI R&D 4)"
 <sven.schultschik@siemens.com>,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
 Christian Storm <christian.storm@siemens.com>
References: <b6ae5c2f-962b-4291-4673-c26f0909fc95@siemens.com>
In-Reply-To: <b6ae5c2f-962b-4291-4673-c26f0909fc95@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: f2441a05-c76e-4f4b-abe7-08daf91e291d
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LjUnAny/x/fkkjQv8dkVnT2BLEbQaVixfcDa38S6oSqRaVXCYVGNlnqlfwlDQsphOr41Um+wxWPhxClcd4+AeZmTMZmpJi4hX5ELkqcdRJaLCNZNtvvKANDFxfxHtGGeoXhp13V/m2SNfpCbVera6+i/fDL+9/Kmfor5t1CSApGWq5MUGvN5AUU77IrUqQOSv2tl+Lz6gJkXX+JyvPaL8UwDjHL4wl2sCgR8B41CutnkA354rHIcWApxyaGtOhNlmfxrL+EK5VtIxuj+wAwO3axUlIQgVMtDh3gxUiB8rqyfr/NS5DIzHuUatTqdfLUj+siyf+KXD6NPFM2JUrzrCdTuK6taTlAw5c+CSUtITLh0H5e1h2poEyhKcCcVU+EYZaFFvIg9WTwhH6dcqT56dcB+F4R83c9NiaFUI8BxKGmC+4Kty8uc+bFlOPBzcnwlgLiF9HLo2mx8nViZ4IuLM8xnP5N/0lBZHCbUfa0uAuRsaRAKZj35wVpby9qg0C6SScjET4ECcTUmWuL3cWKi+Wt/MuJYdKiApml8qtuyvkuIhtW+flY7yyg4r/1Wo6QckN671nm2lXQ0FRIk5FVeS6K5FfLofZsvnL8cdGfyfiCCoADGeQX8xwaFkwaUbRc09XdQ9hmXYW6dZQ6NjcF9Jg1Op8tAQm4/1oXcT+52HcCXrfMaHTxarHZtyMzVn2e2lWwhr/7ZO4tviLge6koA7Eh+Hq7RCe+4hbrMqS5VDld5QtFzTC29k96yFadq8glyoUi2zQgvfcy0oHK5WwTaQkR/nAAZI/xechm8KX8o24aTdgZJ+QmbVAKixHlzCu/c
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(6029001)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199015)(8936002)(31686004)(82960400001)(966005)(6486002)(44832011)(5660300002)(66556008)(26005)(53546011)(41300700001)(4326008)(31696002)(8676002)(66946007)(66476007)(36756003)(2906002)(54906003)(316002)(86362001)(6916009)(478600001)(38100700002)(6506007)(107886003)(6512007)(186003)(6666004)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M2pJREtJaG45U3ptU1YrUmJLVGxBS1JaR3V4K3hEZ09IWVJESmdEKy9RVG1B?=
 =?utf-8?B?ZFBBRU10MWNjNXMvektmY05wdjhuZWl4WnlFemFsTUR3YytuaEVLbnhOVUFP?=
 =?utf-8?B?dXFTOEpCdE5aekFNRkRwVFBnSjhSemJZOGt2dm9WdUJka1UxNS9DbktIRG4w?=
 =?utf-8?B?QmNPbzV3bFkvSnBVOHJCLzRJUjhSQnd5Kyt5bjY3clVhZzVZdGJkRVM1TFBO?=
 =?utf-8?B?STVZTHdIOSs4LzBDNUxTdlQ3SnpMbUtzbFlDVjNUb1M2aEo2ejUvWVlEcS9m?=
 =?utf-8?B?WnVmcStaR2ZCQ1AxU1FjYnp1ZnVCeDQvZ2lvYXYyTDNiZ2xRczE4dk1aYzNF?=
 =?utf-8?B?NjJtVitHZnFwOTJmemtXc05BWkx3TkVzWElYb2RZWGdrcnZhK3l1dWZhbWpj?=
 =?utf-8?B?TFlwSitidVlYYWdaVkVLcWJVSFRUY2lJR2tmN2hTWnRIZUFFeEc0NXB1L1lM?=
 =?utf-8?B?ZlJHN01VY0pBbXZrNnBHRGQxalFpYXc1TWxydVhHNU5yMHpqeVBFMUxrWDJ3?=
 =?utf-8?B?clBFaFpoZE9FM1pqS2x3VVlkWndEZThSVVIxR1VCeWdJcWhSQmRpZlV0RGFv?=
 =?utf-8?B?c01UaDN0YldzRU9NVTRlNDFZblhQcnhVdWxvUis2ZFhLNFJrVUE2N1lqTTFJ?=
 =?utf-8?B?R3JOZ25OM3NxcWdxSFBhekZNemRaYzVNVDRXMFlLeDg1U0IrTWNId2JaRllw?=
 =?utf-8?B?ZEdPc01SWDVaSXQ2blYzSTJLM0kweUpGV3Z0N21zOCtBd09SeVIvVkQ0eHFP?=
 =?utf-8?B?WUNLZ2pzZ2FEOW94STlzMkZpSnMvYWNIcnZDcm1wQ0Q0STZDeU92RzFRMC8w?=
 =?utf-8?B?VzZRT2w4d09kejFhd1Mzc0RIZzJra3ZQZHdrbVNHeFEwaVZCbzQrZUw0Sk4x?=
 =?utf-8?B?VExMVjlXV2lXenlOV2xPSWd1VE0ybWtlbjRCaE4zSzk0SGdDQksxdFBQM3B4?=
 =?utf-8?B?N0pFbUhXd3BTbk9zenUxY3FnbEU3TEdSYlBXM29qRytOeGlvSUhITkdMU3Ns?=
 =?utf-8?B?NzFvZWxNZS9FaWFxdUxueHBnNjhobDR1OUh3NWFvakFOaC9KRmh4YVlNZ3oz?=
 =?utf-8?B?OWk2MnpHeG13VmFHcXhSSGMvMy83M1E1dUhPQlNoQVdudDl1dW5CZmRycVpB?=
 =?utf-8?B?aTlUSzB4TmFScll2cnpXN1NyYkVqME42V3A4dFRRZmJsbUZjTXlsdlRFWEUy?=
 =?utf-8?B?RHRiMTd1cHFYZXlZSWRod1c0REtkVHJ1eUhVeWowUElEZiswSEpJWEVvSHJ5?=
 =?utf-8?B?ZnNhcGE5RUhyUWFaRkw2RFpSeXRlWDhlNFJZRWJEWi8xdXEvRWNnN2E3dzJW?=
 =?utf-8?B?dTQ2Qmp1cUtRMHFMbGxFVklBcTNZR2dNSW03bWxGQzluOVArNTVtVmw1cVJl?=
 =?utf-8?B?TUZTU2grWHBsdE10R21XdVBPUXFkU3RZb1NHbjI3Rmoxd0VmVjEvRTB4b29U?=
 =?utf-8?B?Qm9GSHBFYzFCRCtuVFdvY3dibEhXUWgzVHB0andjVVA2Y3VjVURMaXFURmox?=
 =?utf-8?B?VTBzUkptMXJ0QmpVV0NVQWxCbm9oOWZOcUtqc2hSbytiaG1TRFlZbitiYjVi?=
 =?utf-8?B?WHlYU0RieWNEZDNhN1Qrc2ZuelFLVUtZOWt3SHR0K29kaG9NOE00WFBxWTll?=
 =?utf-8?B?SDVNL2tPQ0h6blVEV3Z1bUVyY2UyNHZJaEtYVzgzTFZMbEwvbmRDZEs1c3V0?=
 =?utf-8?B?NHowdUFzVGdrU0c1OS8xaXpMNlFZdGs0TjQ5a2gwZ01IYmxTVklidWxiNU5Y?=
 =?utf-8?B?TlRVVHJaNXNTWGl5MVVrY1JvUE51c3JxaWRaUHVMUGJodEc0Mkh0TDd4K0ds?=
 =?utf-8?B?dkZXdnBMTEVTRThyOG5mQzhwVFR5U0RqWUNyVHQzc1NpeDdOdnRsTXNMRWx5?=
 =?utf-8?B?aWlxMVBRYXY5UmJhS3F4dnB0SzJscWkraW9weW1uWUg0MmorSE04NGN2dTU2?=
 =?utf-8?B?UEV5a2NwMFhFaVgrb2JIRkxsdGR1SEh5Wm0rV0gxN0t1TW1LMkJHMFFuTkJN?=
 =?utf-8?B?VFhIdVNKSC9UM0JUbmx3ZGZIR2VKNGtoL3NkcER3TG9kQTVOSUxyb3p1cWJZ?=
 =?utf-8?B?ZjRMTEZ1aFQ4TGRxN0VjdWp3N2NjbGo3ZGF6eUhNRTlvRHl0MC8zRjdwZ3kr?=
 =?utf-8?B?SlhTaGpJeGttckdrMGV3SGZUc0hZcG9Mbi8xbDJuTmk1RjBpUFJjVGM1dFo3?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2441a05-c76e-4f4b-abe7-08daf91e291d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 06:35:16.2366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5d9ieJ8Hw5GR5Dvcp4AHatmp1HsdKnvmKsc8p+iekXblCeNCQsuF2qNxcl7l0esf0VRU1ltok0b3Nzh+SApMRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5857
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 06:35:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10382

On 10.01.23 20:47, Jan Kiszka wrote:
> From: Sven Schultschik <sven.schultschik@siemens.com>
> 
> Provide a recipe to create the BL32_AP_MM.fd binary from EDK2. This
> binary provides a stand-alone version for securely managing the access
> to EFI variables stored in RPMB. It needs to run in a Trusted Execution
> Environment (e.g. under OPTEE on ARM), thus will become a dependency of
> firmware build that what to provide UEFI secure boot with keys
> provisioned into secure storage.
> 
> Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
> [Jan: refactorings]
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes to Sven's last version:
>  - renamed recipe
>  - dropped .inc
>  - updated to 202211
>  - avoid copying sub-module folders around
>  - fetch edk2-plaform as archive
>  - added bash as build dependency
>  - smaller cleanups
> 
> I did not try fetching the openssl sources from Debian. That may work 
> today with bullseye, because at least fragile with buster and will fail 
> with bookworm (no more OpenSSL 1.x). We need to vendor.
> 
> As explained in the other thread, I would accelerate the merge of this 
> even though we don't have in-tree users. meta-iot2050 will soon become 
> the first external user while creating a useful QEMU target 
> unfortunately requires creating an eMMC+RPMB model in QEMU first. :(
> 
>  recipes-bsp/edk2/edk2-standalonemm-rpmb/rules | 64 +++++++++++++++++++
>  .../edk2/edk2-standalonemm-rpmb_202211.bb     | 57 +++++++++++++++++
>  2 files changed, 121 insertions(+)
>  create mode 100755 recipes-bsp/edk2/edk2-standalonemm-rpmb/rules
>  create mode 100644 recipes-bsp/edk2/edk2-standalonemm-rpmb_202211.bb
> 
> diff --git a/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules b/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules
> new file mode 100755
> index 00000000..4161e6ca
> --- /dev/null
> +++ b/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules
> @@ -0,0 +1,64 @@
> +#!/usr/bin/make -f
> +#
> +# Copyright (c) Siemens AG, 2022-2023
> +#
> +# Authors:
> +#  Sven Schultschik <sven.schultschik@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
> +export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
> +endif
> +
> +export WORKSPACE=$(shell pwd)
> +export PACKAGES_PATH=$(WORKSPACE)/edk2:$(WORKSPACE)/edk2-platforms
> +export ACTIVE_PLATFORM="Platform/StandaloneMm/PlatformStandaloneMmPkg/PlatformStandaloneMmRpmb.dsc"
> +
> +# https://github.com/tianocore/edk2-platforms/blob/master/Readme.md#if-cross-compiling
> +ifeq (arm64,$(DEB_TARGET_ARCH))
> +export TARGET_ARCH = 'AARCH64'
> +else ifeq ((armhf,$(DEB_TARGET_ARCH))
> +export TARGET_ARCH = 'ARM'
> +else ifeq ((amd64,$(DEB_TARGET_ARCH))
> +export TARGET_ARCH = 'X64'
> +else ifeq ((i386,$(DEB_TARGET_ARCH))
> +export TARGET_ARCH = 'IA32'
> +else
> +$(error DEB_TARGET_ARCH $(DEB_TARGET_ARCH) unsupported)
> +endif
> +
> +export SHELL=/bin/bash
> +
> +# ENV Vars which should get set by edksetup.sh
> +export PYTHON_COMMAND=python3
> +export PYTHONHASHSEED=1
> +export CONF_PATH=$(WORKSPACE)/edk2/Conf
> +export EDK_TOOLS_PATH=$(WORKSPACE)/edk2/BaseTools
> +export PATH=$(WORKSPACE)/edk2/BaseTools/Bin/Linux-$(TARGET_ARCH):$(WORKSPACE)/edk2/BaseTools/BinWrappers/PosixLike::/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
> +
> +# When cross-compiling, or building with a different version of the compiler than
> +# the default `gcc`, we additionally need to inform the
> +# build command which toolchain to use. We do this by setting the environment
> +# variable `{TOOL_CHAIN_TAG}_{TARGET_ARCH}_PREFIX` - in the case above,
> +# **GCC5_AARCH64_PREFIX**.
> +# export GCC5_AARCH64_PREFIX=aarch64-linux-gnu-
> +# using export here at TOP Level does not work, because
> +# GCC5_$(TARGET_ARCH)_PREFIX gets deleted again for what reason ever
> +# Therefore it is set right before the build command
> +# export GCC5_$(TARGET_ARCH)_PREFIX=$(DEB_HOST_GNU_TYPE)-
> +
> +override_dh_auto_build:
> +	source edk2/edksetup.sh --reconfig
> +
> +	CFLAGS= LDFLAGS=  make -C edk2/BaseTools
> +
> +	(export GCC5_$(TARGET_ARCH)_PREFIX=$(DEB_HOST_GNU_TYPE)- && \
> +		build -p $(ACTIVE_PLATFORM) -b RELEASE -a $(TARGET_ARCH) -t GCC5 -n $(shell nproc))
> +
> +override_dh_auto_install:
> +
> +override_dh_auto_test:
> +
> +%:
> +	dh $@ --no-parallel
> diff --git a/recipes-bsp/edk2/edk2-standalonemm-rpmb_202211.bb b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202211.bb
> new file mode 100644
> index 00000000..40d979d9
> --- /dev/null
> +++ b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202211.bb
> @@ -0,0 +1,57 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022-2023
> +#
> +# Authors:
> +#  Sven Schultschik <sven.schultschik@siemens.com>
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +HOMEPAGE = "https://github.com/tianocore/edk2"
> +MAINTAINER = "Sven Schultschik <sven.schultschik@siemens.com>"
> +
> +inherit dpkg
> +
> +SRC_URI = " \
> +    https://github.com/tianocore/edk2/archive/refs/tags/edk2-stable${PV}.tar.gz;subdir=${S} \
> +    https://github.com/tianocore/edk2-platforms/archive/${SRCREV-edk2-platforms}.tar.gz;name=edk2-platforms;subdir=${S} \
> +    https://github.com/google/brotli/archive/${SRCREV-brotli}.tar.gz;name=brotli;subdir=${S} \
> +    https://github.com/openssl/openssl/archive/refs/tags/${PV-openssl}.tar.gz;name=openssl;subdir=${S} \
> +    file://rules \
> +    "
> +SRC_URI[sha256sum] = "b7276c0496bf4983265bf3f9886b563af1ae6e93aade91f4634ead2b1338d1b4"
> +SRC_URI[edk2-platforms.sha256sum] = "b0f5b6d832e4dcc1d47a98ae0560e0b955433e32e8ac6d12c946c66d5fa6f51a"
> +SRC_URI[brotli.sha256sum] = "6d6cacce05086b7debe75127415ff9c3661849f564fe2f5f3b0383d48aa4ed77"
> +SRC_URI[openssl.sha256sum] = "6b2d2440ced8c802aaa61475919f0870ec556694c466ebea460e35ea2b14839e"
> +
> +# according to edk2 submodules
> +SRCREV-brotli = "f4153a09f87cbb9c826d8fc12c74642bb2d879ea"
> +
> +# revision closest to edk2 release
> +SRCREV-edk2-platforms = "4ad557e494d8055f5ea16009d6e565cace6571d6"
> +
> +PV-openssl = "OpenSSL_1_1_1n"
> +
> +DEBIAN_BUILD_DEPENDS = "bash, python3:native, dh-python, uuid-dev:native"
> +
> +do_prepare_build() {
> +    deb_debianize
> +
> +    ln -sf edk2-edk2-stable${PV} ${S}/edk2
> +    ln -sf edk2-platforms-${SRCREV-edk2-platforms} ${S}/edk2-platforms
> +
> +    rm -rf ${S}/edk2/BaseTools/Source/C/BrotliCompress/brotli
> +    ln -s ../../../../../brotli-${SRCREV-brotli} ${S}/edk2/BaseTools/Source/C/BrotliCompress/brotli
> +
> +    rm -rf ${S}/edk2/MdeModulePkg/Library/BrotliCustomDecompressLib/brotli
> +    ln -s ../../../../brotli-${SRCREV-brotli} ${S}/edk2/MdeModulePkg/Library/BrotliCustomDecompressLib/brotli
> +
> +    rm -rf ${S}/edk2/CryptoPkg/Library/OpensslLib/openssl
> +    ln -s ../../../../openssl-${PV-openssl} ${S}/edk2/CryptoPkg/Library/OpensslLib/openssl
> +
> +    echo "Build/MmStandaloneRpmb/RELEASE_GCC5/FV/BL32_AP_MM.fd /usr/lib/edk2/" > \
> +        ${S}/debian/edk2-standalonemm-rpmb.install
> +}

Applied to next - even though we have no in-tree user yet. But it's
better than risking downstream deviations.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


