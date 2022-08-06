Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D143CC19F29
	for <webhook@archiver.kernel.org>; Sat,  6 Aug 2022 06:19:22 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.65])
 by mx.groups.io with SMTP id smtpd.web10.767.1659766757138359484
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Aug 2022 23:19:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sk3Bz+cZ;
 spf=pass (domain: siemens.com, ip: 40.107.21.65,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K85HAGNXXsh9I8P36Typ4MvCkvUgwQpfTl2PfJy1Plg3PIoTxIwQrOU975cGT36FV0B8CbB3MLF8vhAypdEwMzE8pHmr3vzhFx7p844cQllQyYhI7T7YMV7fB4XELPgZ7CR7iSOhz7gJBB6xc0SKQvEFb3FsTprxcT4+G6PQpov6FY6PeVV65uJQCf4eI1OBrzPBeX6iFTImTFuHa1Ihsl5n1unNS/BBbZEb/5bxjk5iqinGtopiO5E9Cr+Ih6N0f5zuPTb/cA2YYUnLggq22UB7qukrcBVX/WQn6HSUiOXVKFSYzQEGvyhePq+WiTWlIQ+7qhpT05adsQB4VQ0b8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkLWOBFBdqZ3EEGnk67HpEm9JMjy2pW2i2qXjbRwtRM=;
 b=QyzGlbS/4nJ18v7+3lTjujIQFAInqu36vKXFNsZzPCfbRZKvvSzx9hE6Y0WbcA5N8n538LxVv1aXx1uL52D1ZtZx144izW6sX6uXnrkIylhaeWewrS2tzzsJMrraB2P0fWO8AYZCopjb2KrRTegbEwHX/F17+k8uiB/zV/YJ6REJjIC85GjQrE3sv1yxBjcR1NQBfNZA6lKDXu33aC3dibgjgaTbTFZuLS1hU64eUq1fLzAr+tZ4T46i4TBzyGmSwwjWzdzwQ3Kt6eVDDMJ3bQz9IdW9ALFvBf9+c0GfMsx4N+fZXhPq+YeXNVeJDStWziKwOHB+zcsosN0GLQYZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkLWOBFBdqZ3EEGnk67HpEm9JMjy2pW2i2qXjbRwtRM=;
 b=sk3Bz+cZwEQQcehfvaH0L62LH+f+gEFf8intJ0lCMCJriuACzjWcdrRhjaIq/5G6OjXKkS7cJH7FBly89254g3mL1snxA/ZF3foJA7cbYKpBIWba8U0swPw/MfOP87WX+oVbM0ODq02OMkI6hG1xnFf4rgfBKelPAGIVN94lojW6piIpjBSnmyIsSVIJeOGiKjLDq3M4YTu3gzk/tgl2gap7rcIoegxR4jTSjN5NljJucp0aPQj/V5KtUuCr2Jydfb5jOgrGzgSsE3mZOkHILvM+r3VE8cPFTXyZXi6/Pjmzg93UsKzwLLAGvhPMytGPsv9rsRsS5SbQ/y0IrfhsCg==
Received: from GV3P280CA0088.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::19) by
 PAXPR10MB4899.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:1dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Sat, 6 Aug
 2022 06:19:13 +0000
Received: from HE1EUR01FT047.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:a:cafe::5f) by GV3P280CA0088.outlook.office365.com
 (2603:10a6:150:a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Sat, 6 Aug 2022 06:19:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT047.mail.protection.outlook.com (10.152.1.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Sat, 6 Aug 2022 06:19:12 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Sat, 6 Aug 2022 08:19:12 +0200
Received: from [139.22.137.228] (139.22.137.228) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Sat, 6 Aug 2022 08:19:11 +0200
Message-ID: <02b6c4fc-3b33-a7d1-8353-22002545d92e@siemens.com>
Date: Sat, 6 Aug 2022 08:19:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 1/2] kas: Remove
 efibootguard.yml
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220805152623.2155519-1-Quirin.Gylstorff@siemens.com>
 <20220805152623.2155519-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220805152623.2155519-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.137.228]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--13.923400-8.000000
X-TMASE-MatchedRID: Cc2Ao8tLfKA5QaOxwNGfvo9bHfxDWoibR/oM2cgUsZr/XfgEFWz6XEKJ
	5iyNYGPpBph69XjMbdmVKkReE4K0FOtq38W/Yl/coJpneC8uzLwCVvo5Hft/7k+zv2ByYSDQS1z
	wNuiBtITfUZT83lbkEH43HV+1jEvwiAcXrmviP5DRl2x5voGCF+wm7JbHWLoRD3uYMxd01bcBmf
	/gD11vZO+uPZ9E4AOJqrLpOlGDhqHFCmRbyZuc3+DcAHv31uCXxrW3OZZ/rLZff79rzPd1mHqTi
	LZEbYB6WAuSz3ewb20UiHfUmS+ulivn27+DO/kwtTOrxEGQm4Zw1ghGV72CB54CIKY/Hg3AtOt1
	ofVlaoLUHQeTVDUrItRnEQCUU+jzjoczmuoPCq3AJoKlkKpRwm1o5fexW4AjehFnF70NqLu+8eO
	gwaussAA3rbel16Dv
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.923400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 7D942922A0855CEC63F60C2D0BBABA0543CDFAC08A87B8D2F079CB4AE176D8122000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24beb5d6-a61a-48c2-a8a4-08da777394ac
X-MS-TrafficTypeDiagnostic: PAXPR10MB4899:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NDwzZBJiiezICp+jsWOUXJ31li7oBON31G/vddo/X8uP2QM+ffj/M5iriOV/0QUC5OVIJX7cp7zBNHxvCCpTDAtu33YWrBmhQMRz+M4vQ9DW9yK/wJpwj8irbQAdO66lGY9B3R9LFkPihAum78YThnIiFfLKAXIrdRapYWNo2Yya/4TKLEPPXWS8rin/Cl4Tzdw20KEYx4LwrrgzlS+n9WB9n2y0cfWcAa0YTGRI1zP2kzAAxYiCzQSMTqvEu3qJbgpgJa5A52kxeUIIRy2qUYMf/OjP6tzM9zVgTd6CZJQgI2WhY3hxtoe6TW0xH44KVF3V2vtx8VxBsXTneyXnkqhGbnmUSwDc4o43oT5wxJ2/eab5pCbN2PziwJDuXV6hRb+VvoR4bbImmNeHpRGmlXU/OShvIRajAXj2CV2OG+9eWBPDr0R+eTK/ijoDEUwt7RIDy23kwH+yLfe5iVJmelK4O5hUILxnyE+m36TGThW9V63hZ0/k7ozcpPLA8loKLW2YzIJ7eaFJ87vr7h4bT8ctYOGh3779vijGotFHQYHs9nZ1rleVxDnDod7nGafDFAQ7xvefaQVftCFSzLqSGG8BUEslOxiJXPPw8JqQPmqSWee8XefuAH7V+hJ1AToDmFysnXCjfscsIJdXtYKhLTfAnkrgvwNDJ8dDaAcWiVUXoDwellBsDFFO6NhkBwW3mVxQOnoGk8XAS+/BWgL3Tx6D4aHTAS8OLQ9CefQKIVfBfezNA5l3jcyRvDbb5qkXWl49vHC8NVgyfD9Z+NVDKkReTtidPUT46qo2buYTCAlDojT5ExAJcGAeYAmEmkVgIi8Sid7AjjCzqOTr31z3OrxsB09vYQmn3APIm1dEEwblvfaIcvohkd42pSdGl7uvEzB6GWAN0Vegl7GYeMnPOg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(40470700004)(46966006)(83380400001)(82740400003)(31696002)(53546011)(36756003)(81166007)(31686004)(70586007)(70206006)(40480700001)(8676002)(86362001)(36860700001)(82960400001)(316002)(336012)(40460700003)(41300700001)(16576012)(44832011)(356005)(47076005)(2616005)(956004)(2906002)(110136005)(6706004)(8936002)(5660300002)(478600001)(26005)(82310400005)(16526019)(186003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2022 06:19:12.4853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 24beb5d6-a61a-48c2-a8a4-08da777394ac
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT047.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4899
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 06 Aug 2022 06:19:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9138

On 05.08.22 17:26, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> A build with only the option `kas/efibootguard.yml` will not succeed.
> Move the content to a include in the image directory and the adapt the kas
> files.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/distro/cip-core-common.inc      |  2 +-
>  kas/opt/ebg-secure-boot-snakeoil.yml |  9 +++----
>  kas/opt/ebg-swu.yml                  |  7 ++---
>  kas/opt/efibootguard.yml             | 39 ----------------------------
>  recipes-core/images/efibootguard.inc | 28 ++++++++++++++++++++
>  5 files changed, 37 insertions(+), 48 deletions(-)
>  delete mode 100644 kas/opt/efibootguard.yml
>  create mode 100644 recipes-core/images/efibootguard.inc
> 
> diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
> index 5cd1603..20a30d2 100644
> --- a/conf/distro/cip-core-common.inc
> +++ b/conf/distro/cip-core-common.inc
> @@ -11,4 +11,4 @@
>  
>  KERNEL_NAME ?= "cip"
>  
> -WKS_FILE ?= "${MACHINE}.wks"
> +WKS_FILE ??= "${MACHINE}.wks"
> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
> index 2822cef..0791ea3 100644
> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
> @@ -11,16 +11,15 @@
>  
>  header:
>    version: 10
> -  includes:
> -   - kas/opt/efibootguard.yml
>  
>  local_conf_header:
> -  image-options-swupdate: |
> -    CIP_IMAGE_OPTIONS_append = " swupdate.inc"
> +  ebg_secureboot_bootloader: |
> +    SWUPDATE_BOOTLOADER = "efibootguard"
>  
> -  swupdate: |
> +  image-options-swupdate: |
>      IMAGE_INSTALL_append = " swupdate"
>      IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
> +    CIP_IMAGE_OPTIONS_append = " swupdate.inc efibootguard.inc"
>  
>    secure-boot-image: |
>      IMAGE_CLASSES += "verity"
> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
> index 5e4e771..9c50358 100644
> --- a/kas/opt/ebg-swu.yml
> +++ b/kas/opt/ebg-swu.yml
> @@ -12,12 +12,13 @@
>  header:
>    version: 10
>    includes:
> -   - kas/opt/efibootguard.yml
>     - kas/opt/swupdate.yml
>  
>  local_conf_header:
> +  ebg_swu_bootloader: |
> +    SWUPDATE_BOOTLOADER = "efibootguard"
> +  ebg_swu_image_options: |
> +    CIP_IMAGE_OPTIONS_append = " efibootguard.inc image-uuid.inc"
>    initramfs: |
>      INITRAMFS_INSTALL_append = " initramfs-abrootfs-hook"
>  
> -  image-option-uuid: |
> -    CIP_IMAGE_OPTIONS_append = " image-uuid.inc"
> diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
> deleted file mode 100644
> index cee9c78..0000000
> --- a/kas/opt/efibootguard.yml
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2020
> -#
> -# Authors:
> -#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -# This kas file adds efibootguard as the bootloader to the image
> -
> -header:
> -  version: 10
> -
> -local_conf_header:
> -  efibootguard: |
> -    IMAGE_INSTALL_append = " efibootguard"
> -
> -  efibootguard-swupdate: |
> -    SWUPDATE_BOOTLOADER = "efibootguard"
> -
> -  efibootguard-wic: |
> -    WIC_IMAGER_INSTALL_append = " efibootguard"
> -    WDOG_TIMEOUT ?= "60"
> -    WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
> -    IMAGE_FSTYPES ?= "wic"
> -    WKS_FILE ?= "${MACHINE}-efibootguard.wks.in"
> -
> -  firmware-binaries: |
> -    # Add ovmf binaries for qemu
> -    IMAGER_BUILD_DEPS_append_qemu-amd64 += "ovmf-binaries"
> -    # not needed for Debian 11 and later
> -    OVERRIDES_append_qemu-amd64 = ":${BASE_DISTRO_CODENAME}"
> -    DISTRO_APT_SOURCES_append_qemu-amd64_buster = " conf/distro/debian-buster-backports.list"
> -    DISTRO_APT_PREFERENCES_append_qemu-amd64_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
> -    # Add U-Boot for qemu
> -    IMAGER_BUILD_DEPS_append_qemu-arm64 += "u-boot-qemu-arm64"
> -    IMAGER_BUILD_DEPS_append_qemu-arm += "u-boot-qemu-arm"
> diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
> new file mode 100644
> index 0000000..d6a7db6
> --- /dev/null
> +++ b/recipes-core/images/efibootguard.inc
> @@ -0,0 +1,28 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2020
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +IMAGE_INSTALL_append = " efibootguard"
> +
> +WIC_IMAGER_INSTALL_append = " efibootguard"
> +WDOG_TIMEOUT ?= "60"
> +WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
> +WKS_FILE ?= "${MACHINE}-efibootguard.wks.in"
> +IMAGE_FSTYPES += "wic"
> +
> +# Add ovmf binaries for qemu
> +IMAGER_BUILD_DEPS_append_qemu-amd64 += "ovmf-binaries"
> +# not needed for Debian 11 and later
> +OVERRIDES_append_qemu-amd64 = ":${BASE_DISTRO_CODENAME}"
> +DISTRO_APT_SOURCES_append_qemu-amd64_buster = " conf/distro/debian-buster-backports.list"
> +DISTRO_APT_PREFERENCES_append_qemu-amd64_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
> +# Add U-Boot for qemu
> +IMAGER_BUILD_DEPS_append_qemu-arm64 += "u-boot-qemu-arm64"
> +IMAGER_BUILD_DEPS_append_qemu-arm += "u-boot-qemu-arm"

This block is only for testing purposes in isar-cip-core. Therefore, it
was not part of any image but of a overwritable kas config section.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

