Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055EAC433EF
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 13:54:03 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.81])
 by mx.groups.io with SMTP id smtpd.web11.6375.1639749239789116210
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 05:54:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TawetWB6;
 spf=pass (domain: siemens.com, ip: 40.107.13.81,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8pHjkBbFkmn1q9TZuKx6CIcSsRcDIJSiEsUGuB2A3vvcSgKRkLaHyNhC3Vzyf8Icc1809RzMcz7cGXYy7cy5Mws0vwu6l9G5PvHkYvsCh/RrM2x4Ka019WkSC9kPYWvOs7SAu59f+LOQSfv+esCWCqJRCmIwCvSdo5YnUTME1A2rIKyBQcYOSecgIqHpnTR+7Lzpzf/bwekzEMGfe8de0i4DlFI5CVeOX8WA/mCRg7B+c9HfKEIwhHjH/c7nLmNCmcf6N94KqPOKNOnPoLxg9ryQlVUWcypA0/WYYFKA2MVpGoJpuR4USKgg7N7aeEpk1gH6BZhPmMJVlOFvo1Z9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbUmMRvivmPQRRpt96vOzBhRa950kdi/JApYTR7c1XU=;
 b=PHY0rUTYvR3zAtjUl1EEBqtJIb+at3L+1wWubGQo6OBXRAJaCTnXpMPAGHHWIy2hFhSaqSGAEXaWf+B1+CTOp+UMq9ceynjr1kGMqsGHYEUR6ktmbSdgE+dn0njPzcs/ZEHz6OpJgYmHlw2bf8figv8vx8Nf6whfxqzv/jz/mc+UAHgs+kzgYOwjc4VyDlIVUmf4vN18ySmGtNetOMIIUv2qZsyjt6XeHI2DABue8vHmtKQAEbIl3HjhGaah6ETMDZa81dihD7jQ95CyzwmT2dk7iaeop5MUGu56xl1ASPgRiy9gtbcchaGtOpeFZriZyui0VVN1/mN9dG4K9nSCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbUmMRvivmPQRRpt96vOzBhRa950kdi/JApYTR7c1XU=;
 b=TawetWB6BHIqyPIs3vJgu16f9oU5+H6twQSEKQ67ahreFHB5kjdBAXaT+q2/car3I5qfpiQhFgC93QVq9kBOmReTqQAGfFnSsctERyprfOpU8Zc8KCGknqqUFReOg2p1FPnlu7NKB8QA0CCybedvSKS69lwkHlEXBp1JH3HDA4+jzDgyJVFLhvIYjFYAY+7B0a4iXwcMaiVFzo/auSJXnbf2uPXB+KZh5TBLaME8KEmsVsTZZUUwjLTHVbzYTlJ/MAM0HARPEAhnJOBrHNt0gfTmQ3CmY9LWb3aJbMTmQPDUQW81gZNg/mTjCrHeIZ7Ic6aYRJewrXHnzseeZBoSWg==
Received: from DB6PR0301CA0026.eurprd03.prod.outlook.com (2603:10a6:4:3e::36)
 by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 17 Dec
 2021 13:53:56 +0000
Received: from DB5EUR01FT024.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:3e:cafe::e3) by DB6PR0301CA0026.outlook.office365.com
 (2603:10a6:4:3e::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Fri, 17 Dec 2021 13:53:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT024.mail.protection.outlook.com (10.152.4.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 13:53:56 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 14:53:55 +0100
Received: from [167.87.72.12] (167.87.72.12) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 14:53:54 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH] Make read-only rootfs a inc file
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20211217135015.1189442-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <21aa70ad-9ffe-aee2-0883-ca6baee66626@siemens.com>
Date: Fri, 17 Dec 2021 14:53:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211217135015.1189442-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.12]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62005053-c872-479f-e15f-08d9c164ab2e
X-MS-TrafficTypeDiagnostic: DB9PR10MB4953:EE_
X-Microsoft-Antispam-PRVS: 
	<DB9PR10MB49537070878E50CEB7EA185A95789@DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hErj6LCqha/Ax/CCYgYFUjkhS7w37YZN7Iv87ta2/fxD9TJq2c6E/Op2mCI1noFxxhwbR7JETRtHFH9PVi+GLz0FWb7i99oJMC0XkENFoBPvv/rOO3bRom3tZC1uPUkDToWf/E2FB5mmCYb00X06DxY/krdkh5YO+wB5T8w+CUFwgVqZBluGYZ++tmzIowK0F/Os0+7BrJLwfOE2iuBoePFUxJNxI0l3MmZtbpsTBuVqRKoovVoebb6HIJsn9whyhHCivg4aoViJSMt9G4f6hlndXfkliAQs3I70H6mvyA7pjQOVDYaJY2Gpj+68cbQvcI+xRpL6Ta3NH3cYPYtmJuISKo2/C9DnMGy9YalUrBqjBYsODla7yje80JUXXEMUGCMPaixCf3lqGLFJiVnBPyUvC3R5iEvkB8qy9fNPb4U+NzP7zHEBH64hYVTWqzZe9zMKdl1dZJsi5en7YdRNOWK8SiOwqoY2JHDVso58bY6DMbfmue5yrYZ+6j5XiHB5axdvoLpwwc1nw8UyHTArGpL5DiT7Wv7mlhfAEvtSfH6DRDvr6OroFCYxZeEpdcneJxUTDK6usvJ9gLLwKBiofuwoHlMXDGwWukx7M7/eRQRJ3T4CSQw7j2bky1Y/MIvLZWnSafFXCr3mgknzXKSvGJZ3Pm+bkmTOzVBimw+p8dMiHTpNFDuZOZa53fXHUpnEA8t9dQ0IcIYRYGWiwaeCAcslSnbSWqdkvdLnaWHA6fk4H8zg7GJLLc0WVT3ezF5di+vzKcszgHlHUCl/hmuZMVpnqF55EHxtXmxf2Nll5HNdnaazVLt3FGLupypx8lfFKrAT3wlwwn1F8IXr3xAQQmq7/xy76GaUtDzXLtMtsUg=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(8676002)(44832011)(336012)(53546011)(70206006)(70586007)(16576012)(316002)(36860700001)(110136005)(36756003)(8936002)(47076005)(2906002)(16526019)(356005)(40460700001)(31686004)(82960400001)(186003)(26005)(5660300002)(83380400001)(6706004)(81166007)(2616005)(508600001)(82310400004)(86362001)(31696002)(956004)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 13:53:56.1721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 62005053-c872-479f-e15f-08d9c164ab2e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT024.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4953
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 13:54:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7178

On 17.12.21 14:50, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows downstream recipes to include the kas option
> and use the include as base without recreating some parts
> of the recipes.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/ebg-secure-boot-snakeoil.yml                  |  4 ++--
>  recipes-core/images/cip-core-image.bb                 |  3 ++-
>  .../{cip-core-image-read-only.bb => read-only.inc}    | 11 ++++++++++-
>  .../initramfs-verity-hook_0.1.bb                      |  2 +-
>  start-qemu.sh                                         |  3 ---
>  5 files changed, 15 insertions(+), 8 deletions(-)
>  rename recipes-core/images/{cip-core-image-read-only.bb => read-only.inc} (78%)
> 
> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
> index 1cfbacc..807b0d7 100644
> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
> @@ -14,16 +14,16 @@ header:
>    includes:
>     - kas/opt/ebg-secure-boot-base.yml
>  
> -target: cip-core-image-read-only
>  
>  local_conf_header:
> +  image-options: |
> +    CIP_IMAGE_OPTIONS += "read-only.inc"
>    swupdate: |
>      IMAGE_INSTALL_append = " swupdate"
>      IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
>  
>    verity-img: |
>      SECURE_IMAGE_FSTYPE = "squashfs"
> -    VERITY_IMAGE_RECIPE = "cip-core-image-read-only"
>      IMAGE_TYPE = "secure-swupdate-img"
>      WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
>  
> diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
> index 2cecde3..9bf21ff 100644
> --- a/recipes-core/images/cip-core-image.bb
> +++ b/recipes-core/images/cip-core-image.bb
> @@ -18,4 +18,5 @@ IMAGE_INSTALL += "customizations"
>  
>  # for swupdate
>  SWU_DESCRIPTION ??= "swupdate"
> -include ${SWU_DESCRIPTION}.inc
> +CIP_IMAGE_OPTIONS ?= "${SWU_DESCRIPTION}.inc"
> +include ${CIP_IMAGE_OPTIONS}

Is just

include

an valid bitbake statement? I think this is what will happen when
CIP_IMAGE_OPTIONS is empty, right?

> diff --git a/recipes-core/images/cip-core-image-read-only.bb b/recipes-core/images/read-only.inc
> similarity index 78%
> rename from recipes-core/images/cip-core-image-read-only.bb
> rename to recipes-core/images/read-only.inc
> index 79cd6bf..604caa0 100644
> --- a/recipes-core/images/cip-core-image-read-only.bb
> +++ b/recipes-core/images/read-only.inc
> @@ -1,4 +1,13 @@
> -require cip-core-image.bb
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2021
> +#
> +# Authors:
> +#  Quirin Gylstorff <Quriin.Gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
>  
>  SQUASHFS_EXCLUDE_DIRS += "home var"
>  
> diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
> index a7fbf5a..f0d2d68 100644
> --- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
> @@ -24,7 +24,7 @@ TEMPLATE_VARS += "VERITY_BEHAVIOR_ON_CORRUPTION"
>  
>  DEBIAN_DEPENDS = "initramfs-tools, cryptsetup"
>  
> -VERITY_IMAGE_RECIPE ?= "cip-core-image-read-only"
> +VERITY_IMAGE_RECIPE ?= "cip-core-image"
>  
>  VERITY_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${VERITY_IMAGE_RECIPE}-${DISTRO}-${MACHINE}.verity.env"
>  
> diff --git a/start-qemu.sh b/start-qemu.sh
> index 4ab3861..24df490 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -45,9 +45,6 @@ if [ -z "${TARGET_IMAGE}" ];then
>  	if grep -s -q "IMAGE_SECURITY: true" .config.yaml; then
>  		TARGET_IMAGE="cip-core-image-security"
>  	fi
> -	if [ -n "${SECURE_BOOT}" ]; then
> -		TARGET_IMAGE="cip-core-image-read-only"
> -	fi
>  fi
>  
>  case "$1" in
> 

Otherwise, helpful cleanup.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

