Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09969C77B6E
	for <webhook@archiver.kernel.org>; Thu, 13 Apr 2023 20:43:51 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.49])
 by mx.groups.io with SMTP id smtpd.web10.3234.1681418626871591279
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Apr 2023 13:43:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WA0zgmb9;
 spf=pass (domain: siemens.com, ip: 40.107.105.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuHoQsem2lmLNZYh/VSCxcSISoV/y+U/8Zijg3XAldoirmoPLGshyXEVNP7Tevv0Zw0o6GBH20xA73fpMySI1A9U4Ehx2ych70mOCKvBLyUdjSqROAPMCKjOTM8lOpcvLmkFF5XudnzhAZgNl9F0guyUPtDQwnh4KooE6ZosfQfDmh+dUkf7Fp0/u9EG+c0jRZh5J2dGdaDqe3Ykc+Vgh2Xe9q0WVTrNqCwmDm3drSn57mHlTnujj+vD1PM8AtLcsPxVWMPYfTcyi/AQaLYz9mR8EeVCncJ083w+hCPNrYOj1nBq7yv+5E/8jovPhw2ocuxJQmgasga+A+AVB2d8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klEo28oKTo3A4daK+LaRdDnS1rUZUej2aCFBFgNJDN0=;
 b=iKQu5pX1Q/8RRHWt43SlrpIC7c6wWoNHKZCnep5+jnxEVx3UYaUhG4cgdWOGTsmAzIxRoX3w+Jduur0upLzo4riZUiY0nOPxM0cidWUiT32mKzNnrALejL9FK2042K0NchSDm/yOo/sSGZ8Jn7N3BXoJIHoVuan2BybCJoyCS0inA50KDZwcx3ddiO0ihRd1ehFiVW/+u8s6jbI1wrELrmr1wafCD2BB8Lj/QEpli/fjPAzzddpWVpYLSeCemInkWCQr0lsG//tCAg6vzxzwlcPul7DfaFQzrUB3Nu263jf+9MF3OXAfs1KO+n3cY1DGmOA2v3aFZf4lrbwymolUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klEo28oKTo3A4daK+LaRdDnS1rUZUej2aCFBFgNJDN0=;
 b=WA0zgmb9C6eXoYIBrBqHkqCD73VSZ8DvLd9Mc4F6GkI9IJnCvvNULxibavFTpGa6uz9/R2XEfr3LWqqBx73yATzGqD0/N0U+pNLKYMpnZD/y2mZVICN0K9mnyBIRIbpa/+eCd6b3m0V0ZcD8XWkkrnpfM6CtjSJYRAz2kGf2sXS+/Ef9fKe/H020EsgpqjGQHb3dNe7JgkgS6o9c6mJ5FGys2kBcqhEqG3aSDuZ1NmQsEpI+4/vNl+7/16YEA4tT53/17SlqSTLFkloVW3gRbqiFCEEBOB53DbapJM1tjF0+gXQQ/IIFUSlBS0Xqy6c0lOQr0cxCMWigHgeNgplCIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3321.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.6; Thu, 13 Apr
 2023 20:43:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.004; Thu, 13 Apr 2023
 20:43:43 +0000
Message-ID: <b351844b-3c12-e8b6-a81a-d8badc32582d@siemens.com>
Date: Thu, 13 Apr 2023 22:43:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/2] Enable Images based on
 Debian 12 (bookworm)
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230310182003.201194-1-Quirin.Gylstorff@siemens.com>
 <20230310182003.201194-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230310182003.201194-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3321:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe3ee76-d628-44fc-a5f5-08db3c5fc57c
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UhDUzBQiAZHna/EocxdhJdNdrDlc6vYngiHloH4EeT9lEmTPD8kX52GILIstjxjL/yD77gldprnz2hyCi6+pFZqrTRdHoU+JTH9zlaUYF8iag2rGuSZiQoVECfFEQecjD05OC+LF3N17kF+d1GT44zJJY1Z7CLbYCQH2ol5Bvv6yv/aKcITFHIPcN3l2NNaSDgXnEBpgU6aBUdVOYvqqoPUQLFFtKOrdFJUOUwmuLamw+KMW9uIIJ0p+97qCmGK9JNYeA+ODmuFvQ9hAhGpJafzl3/7HEj7lA6zjQGqGRnH3ZLvvmUWO+dVtkT6IfxhgliBS7IA1LA4UMwcuS2DDvJCUGERXWbQZ5ov6w1s+gOroaZjqoOseMvpjv8eUO4vPvszWyn/aZGFa0+SFGpsT04CRudTUYqoEZuMOKTKDSSXuQIhs2cM0IION2UGlRBh4ICU2XEvOns7ZNeJQkpvq8tZ7az+6yrSK6gzHJNlSYfZjBXhoSDS8b0JLzUFYpIFZLuy65nQ//U45/9v9A10xIBkLgHWISp2n37vUbY1w9BF332oMsEy56EjgJu+9tkjqKWydgzSMxbP1aySw2kr8NbJAQpsU6u3/8+hhxShLtFg5b9owMROQSTAZ53+RWPDutisNNikMMtlr7I3Qtum72A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(6666004)(6486002)(66476007)(66556008)(66946007)(36756003)(2906002)(44832011)(31696002)(86362001)(82960400001)(41300700001)(5660300002)(8676002)(8936002)(38100700002)(316002)(478600001)(53546011)(6512007)(6506007)(31686004)(26005)(2616005)(186003)(66899021)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cW1HMHRoSDFYVDNnZndmUzlIU3BhR0l6dmd2aVB3aEZKWTkyVEp3RDFveUl4?=
 =?utf-8?B?YWdxaWtlOU9lUExwU3NuWG1taFdnNmNUWUVvdFJ0cFRURk56am11cFJuY1FR?=
 =?utf-8?B?M0NLOEg0TEpJY20wTHM0ckdhVWtrdGxJbHJ3VmprcDdjQVZOYVFac3dza3Nj?=
 =?utf-8?B?enNBUFZjNG4rSjVwSXlhUUYrb0VJcktWRDR5TzdtYjR1VytBVmxmYys1UkZN?=
 =?utf-8?B?TXFBQWZtSWw2d2I3MlVRV0ovcnhqZE1qMUYwNVBiZXVYR3R4MzZScElJNzNS?=
 =?utf-8?B?MEFUR1BXak44amNQYzRxcGQrRFJxVEh3cE5tcVNoeGs1VTdhVG02OUhDZGpu?=
 =?utf-8?B?NEw5YTBzejNFbEJrU29KM2xNeENGZU1rNGFDZ01teVpkTTZEaE9YZXd4ZnQ3?=
 =?utf-8?B?Um1QU0M1QUVPWmFHNVh3aEpjOUdXSkN0RWl1bSs1VmRGTWM5Wi9aMUVzYncr?=
 =?utf-8?B?N3JJOWJTaWNoSG1UUEdKaDJrMUI0U0kxbDdYMEJZTngzSXU5OHd4c0NEcjVZ?=
 =?utf-8?B?b1diK3V3ZVIya0xtTEJpT3NpZUJFNWFxcEN1Y3NuM2VhNXhGd0gzb2hvSncr?=
 =?utf-8?B?TGNRR3ByaXl1QVFKVW0zQm81VmsxMG5MVkhtZWdlNTllZ0xtYlZTOXByNm5Y?=
 =?utf-8?B?U2RGR04yRkdLd2l1aFR2Y29POGQ4RjhxQ09NOFA4cHA5SWtveXVIeldkWUFz?=
 =?utf-8?B?cG1IcTB4a1JVdVk0YWdlQkJ2ZEg1L3Q0am14M1FuRlBzdGFSM0F3ZGVkdVh0?=
 =?utf-8?B?akU5K3lPVTJFaU4rTTlyN1lUd1Q3Qm41VThmT0F5VUdQNU0xd3A1L0dyMXRS?=
 =?utf-8?B?ZFREdXRKa1cwbXByYk5rUGIvcThsNVhrVUVBQTZvY2dLMHk3d0pnTkttRVlm?=
 =?utf-8?B?aGFoMk5zVDQrYzB0bTNDTC9YOFJkQnluWDNBWmZ2NmNUTzN6QzNsaTRIcVlx?=
 =?utf-8?B?NFFWMnZJZTFYMEdtTGNPdnR5c2tYV1NNQzQxL1VtdUphcnM5dWcvbWV5Z29F?=
 =?utf-8?B?NUI2YU0weDhrWVZib3FPUXJ4WUFVUlVQb09wSThQNDFjZmgzejNmRmliRE9N?=
 =?utf-8?B?SlhORnlQZzJHRkpISkIvaldhTnlBSzdPZnpFbjdIQ0daS3BDUzdHOXdvNVJh?=
 =?utf-8?B?YjFUT0lsY1NsWHJGVEdMZkNXNlNiMytXRHpSZzR3aDVJQ0ZHNWxSZ0NpNUJE?=
 =?utf-8?B?NW03SzlhK3BDWlpDTWIxNkdoOHpjU1ZMdWVQVnRzWEMrbXFQTys3KzMzU2lW?=
 =?utf-8?B?N2RSMndpWG55NWMvc2pMY2tyOS81ZlBIVDAzTGU3TzF4bDZEMGh2U0VFSHV6?=
 =?utf-8?B?RW1NR01yOWNDWWdyQXl6czNtMWVVK0M1ZU1jaVlQUDM0M2VzQ002U2cvM09E?=
 =?utf-8?B?ck5TWGJMbmxVbGpmQkVUT1NlQWNzN3M5Tkd1eFJVeXFwdVVQcVdZbU1aQk85?=
 =?utf-8?B?QXhPR29BSnZiUGtNN3BFMXl4V0x3amtLblhqbVk1b0xrL1J2MTFpTnpXU0dL?=
 =?utf-8?B?TXJwZ1NRMi9mZFlXVUVoZ2l0dXVPZHpXRUE1WjQ3QUxidndnQnZLejIxZUdy?=
 =?utf-8?B?Y2EwZlFUa3h1Vy82a1lpTlhFVEZtTDdoSVhhMHQwdmNOdTFTS09TS084VnRh?=
 =?utf-8?B?bXNqTE1kY1k5Tkxlc3Z6R1Z5bUppanlST2JKQStLTkhHdDR2NFVjdXcvYkcx?=
 =?utf-8?B?aWUwYUpKVTNXNDhnelF3MFJXVFcvaSt1c2k0d2t3eEh4RXVhdHFEc0g4dXdC?=
 =?utf-8?B?Vjk4bUpjQk1kdmRMWXNWMVZtMDgrSUZWR25jazZNb1BhZmh6L21yYVczN2I4?=
 =?utf-8?B?cEd5RFdzV3l3eHAvV2pHeUNoUmhlRWVYSVFmUFJJSk8wNzY1dUpCUWtSdUZR?=
 =?utf-8?B?TG0wSFE4eHlVUzFOL2pPdkpFN2pmUzlzZnlRZG0rMTNwdjQ2VlJmc1RGMVg3?=
 =?utf-8?B?K0dxeWdlVGRjWUxqdVBkQVNwQjZ5QmdyNWRyRDNFTmlrNUpVODFTd0FOZ1lQ?=
 =?utf-8?B?aFlwblVCQy94ZXFSVzBNdnRSY0IrMUg3c3orTGdQRmhzK21YL0hMcXdNMzdk?=
 =?utf-8?B?ckluVXEvVUUxWkNTNWFJK2MwN3U3VXJjUTFWV2N1SjZLVzREbzY1dERTL3R1?=
 =?utf-8?Q?6DVWhaVCtTokc164gWXgfQ+gp?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe3ee76-d628-44fc-a5f5-08db3c5fc57c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 20:43:43.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C70P7G2ZaKBie1pZjncEO7FcnyJ3H+Uh9YSXpKOBBPvtsSkiIhOVd/UqEhixsczji9kxJsM1D8bKmYjN/mCGRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3321
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Apr 2023 20:43:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11198

On 10.03.23 19:20, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This will add prelimitary support for the debian 12 aka bookworm.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitlab-ci.yml                       | 45 ++++++++++++++++++++++++++++
>  Kconfig                              |  5 ++++
>  conf/distro/cip-core-bookworm.conf   | 16 ++++++++++
>  kas/opt/bookworm.yml                 | 15 ++++++++++
>  recipes-core/images/efibootguard.inc |  4 +++
>  recipes-core/images/swupdate.inc     |  6 +++-
>  6 files changed, 90 insertions(+), 1 deletion(-)
>  create mode 100644 conf/distro/cip-core-bookworm.conf
>  create mode 100644 kas/opt/bookworm.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index f51b64b..be1d8d9 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -55,6 +55,7 @@ default:
>      - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
>      - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
>      - if [ "${release}" = "sid-ports" ]; then base_yaml="${base_yaml}:kas/opt/sid-ports.yml"; fi
> +    - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
>      - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
> @@ -312,3 +313,47 @@ build:qemu-riscv64:
>      deploy: disable
>  
>  include: '.reproducible-check-ci.yml'
> +
> +# bookworm images
> +build:simatic-ipc227e-bookworm:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: simatic-ipc227e
> +    release: bookworm
> +
> +build:bbb-bookworm:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: bbb
> +    dtb: am335x-boneblack.dtb
> +    release: bookworm
> +
> +build:iwg20m-bookworm:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: iwg20m
> +    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
> +    release: bookworm
> +
> +build:hihope-rzg2m-bookworm:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: hihope-rzg2m
> +    dtb: r8a774a1-hihope-rzg2m-ex.dtb
> +    release: bookworm
> +
> +build:qemu-amd64-secure-boot-bookworm:
> +  extends:
> +    - .build_base
> +  variables:
> +    base_yaml: "kas-cip.yml:kas/board/${target}.yml"
> +    release: bookworm
> +    target: qemu-amd64
> +    extension: ebg-secure-boot-snakeoil
> +    use_rt: disable
> +    wic_targz: disable
> +    deploy: disable
> diff --git a/Kconfig b/Kconfig
> index 7d72094..9cfd3b9 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -132,6 +132,10 @@ config DEBIAN_BULLSEYE
>  	bool "bullseye (11)"
>  	depends on !ARCH_RISCV64
>  
> +config DEBIAN_BOOKWORM
> +	bool "bookworm (12)"
> +	depends on !ARCH_RISCV64
> +
>  config DEBIAN_SID_PORTS
>  	bool "sid (unstable) with unofficial ports"
>  	depends on ARCH_RISCV64
> @@ -142,6 +146,7 @@ config KAS_INCLUDE_DEBIAN
>  	string
>  	default "kas/opt/buster.yml" if DEBIAN_BUSTER
>  	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
> +	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
>  	default "kas/opt/sid-ports.yml" if DEBIAN_SID_PORTS
>  
>  comment "Image features"
> diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-core-bookworm.conf
> new file mode 100644
> index 0000000..de2e435
> --- /dev/null
> +++ b/conf/distro/cip-core-bookworm.conf
> @@ -0,0 +1,16 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require conf/distro/debian-bookworm.conf
> +require cip-core-common.inc
> +
> +PREFERRED_VERSION_linux-cip ?= "5.10.%"
> +PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
> diff --git a/kas/opt/bookworm.yml b/kas/opt/bookworm.yml
> new file mode 100644
> index 0000000..8b4431b
> --- /dev/null
> +++ b/kas/opt/bookworm.yml
> @@ -0,0 +1,15 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 12
> +
> +distro: cip-core-bookworm
> diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
> index b3fe911..bb1aa1d 100644
> --- a/recipes-core/images/efibootguard.inc
> +++ b/recipes-core/images/efibootguard.inc
> @@ -10,6 +10,10 @@
>  #
>  
>  IMAGE_INSTALL:append = " efibootguard"
> +IMAGE_PREINSTALL:append:sid = " efibootguard"
> +IMAGE_PREINSTALL:append:bookworm = " efibootguard"
> +IMAGE_INSTALL:append:bullseye = " efibootguard"
> +IMAGE_INSTALL:append:buster = " efibootguard"
>  
>  WIC_IMAGER_INSTALL:append = " efibootguard:${DISTRO_ARCH}"
>  WDOG_TIMEOUT ?= "60"
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 08867cd..817fce0 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -12,5 +12,9 @@
>  inherit image_uuid
>  inherit read-only-rootfs
>  
> -IMAGE_INSTALL += " swupdate"
> +IMAGE_PREINSTALL:append:sid = " swupdate"
> +IMAGE_PREINSTALL:append:bookworm = " swupdate"
> +IMAGE_INSTALL:append:bullseye = " swupdate"
> +IMAGE_INSTALL:append:buster = " swupdate"
> +
>  IMAGE_INSTALL += " swupdate-handler-roundrobin"

Thanks, merged this one already.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


