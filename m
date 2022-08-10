Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3D2C00140
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 19:42:46 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.57])
 by mx.groups.io with SMTP id smtpd.web10.2771.1660160565271411833
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Aug 2022 12:42:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fPMQbDgH;
 spf=pass (domain: siemens.com, ip: 40.107.104.57,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SM2FQS4Tk+IBuCf5afeRkMDFdlJbbRx/MmdHFhNsIMAo3CPHifJsrSrTTlxyNmR/YA4TIu3qtefZaf2HNOPSnXIt8Tq5i/+zO3vZRqrOpanuXggh19N3bDF5ACMsLYjwGD/sMz8VflKrzTr0DV+XIxVAA2agfHYm1odsAJGU84w2tilAey9cSx41WunOYzzV2ZKcuGsgGXqOwjuDb9R19vv+1Pe/TcK5CmFyLzzZqVleOp+Ld4mZ3scP+G77/wUf4nNLq6VlqRKt8rnrEzVcNqUA1hZGXFjyY6oBvFZ6Q4fzJPF0S+od7/Br5vSj6jxxJMQoLR06DiAXnoEAqFe/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSCtzfFt/hWN+L6v4UYxwzYtzecjS7OVKwqPTdRCUug=;
 b=mRxGivW0X3qVPW1uW3SxIcT7e+s3DuUwG91P/XObi5xvdfD+Kqx77ylO8dTvDLgV1MjM7R65qVp5lO5pFrswNRUbJo8uvxR71F8/EdIamX+78w34rVdIRMzzmK2DJuDw7HdgPtgVFs9CFw/Fz8wBQFSugBDjfaOsS4p5r4OtMSjUD+ADJAj+E4vbfusz/8tYzXzibAje56g70TkCm5pDQ//tM8HtFqG4d0b949kG0/vmYvGkq/kQA3NyGM+6o50QmiBGih6NaKaDLccdx0KYZje0tRqQiGAUOstwgV4ZrdXX4ys7/UjwNTA2cj0IYHQSdi7AEIc2KGZKK3jQB6upSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSCtzfFt/hWN+L6v4UYxwzYtzecjS7OVKwqPTdRCUug=;
 b=fPMQbDgHBfqkeVDQAjx67VBbBTH9ayDQXsQLXGDx92EgZ49bhehOk4a1xuV3heT9VjAgxL6kyvcEX7gFTwcLuO+g9oWZcaqZ5TA0/Ld37GUMOC82ESn6BNLe1/KxTbUQNbJjyJVqbHtGggP4Z0QJYCI+9Bu/mMQ1u5C48vyIU/9fjKsMwBJF+yev38OHzUQTlbaEhJpzkb16MGBgTxAc8S7U3gjMYYVlVv+8fKk/E5tP/nR4exvZei47pNEGH/LLi3fBzRuoK2MSlsh+ktSQwyy+GA7tqdHVw8pcc4orX245giWPw2AGycJ+iHUHJOWVSw91yscm+VY2Ms7C16402Q==
Received: from AM7PR03CA0015.eurprd03.prod.outlook.com (2603:10a6:20b:130::25)
 by DB7PR10MB2027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Wed, 10 Aug 2022 19:42:42 +0000
Received: from VE1EUR01FT016.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:130:cafe::62) by AM7PR03CA0015.outlook.office365.com
 (2603:10a6:20b:130::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Wed, 10 Aug 2022 19:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT016.mail.protection.outlook.com (10.152.2.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Wed, 10 Aug 2022 19:42:41 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 10 Aug 2022 21:42:41 +0200
Received: from [167.87.13.241] (167.87.13.241) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 10 Aug 2022 21:42:40 +0200
Message-ID: <9a85c13d-e945-8694-003b-32bbc88635fe@siemens.com>
Date: Wed, 10 Aug 2022 22:42:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 1/3] kas: Remove
 efibootguard.yml
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220809104100.469265-1-Quirin.Gylstorff@siemens.com>
 <20220809104100.469265-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220809104100.469265-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.13.241]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.727400-8.000000
X-TMASE-MatchedRID: /fpDbfajygI5QaOxwNGfvo9bHfxDWoibR/oM2cgUsZr/XfgEFWz6XEKJ
	5iyNYGPpBph69XjMbdmVKkReE4K0FOtq38W/Yl/coJpneC8uzLwCVvo5Hft/7k+zv2ByYSDQS1z
	wNuiBtITfUZT83lbkEH43HV+1jEvwiAcXrmviP5DRl2x5voGCF+wm7JbHWLoRJDcimQIrvHhoqf
	yBzG0Z5tOIkdaFnzrXe/cQkmt0G7EJpPIlWv1oBEDVDr5/unyvrSv+cSvbTp4Pe5gzF3TVtwGZ/
	+APXW9k7649n0TgA4mqsuk6UYOGocUKZFvJm5zf9SS97+Iy3WvHyxUABVxAfP9N7e3lwkwbH0MA
	L5h27KNTbQ95zRbWVmBt9mS7pKVTeoqVs1ZLrvAzd+tJEfcx1FxxDx5qbkR9OX/V8P8ail1ZDL1
	gLmoa/PoA9r2LThYYKrauXd3MZDVQXfNswV5LyJCiF2VBxY13WjIeO3un9m4F8I329QSNDk4YWJ
	LMhj48
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.727400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 30646CDE8E2EC195CB10CEC2F5E90F5F033BC22D43E9FE6C0988AE67AAC966942000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e10dd6a2-5c7d-4f72-0135-08da7b087d36
X-MS-TrafficTypeDiagnostic: DB7PR10MB2027:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nyyvxqkWHT+yMF20rcg4SMqEkaM+kLot+GVBrLKy1mwv9649PUmfz7EFNk7eYeO3rh/rJZYqvTZXT2BtwHxM9bJDJB2Ymy+kfy8W82VUtfIQ2mLCKP9gQfGRl+5OYFCGqd5+KBdzEMucyqRXtKLMuNoywQgf3QWplZFZflbsF4CHsOnE2brIIDoAh2TxgDWBsLs+eZ+Qtg1Spd7ceoJwV6I1ivwoohGfLpX4reiRSuAktkAXxnTytaht4sKuHcMdWlsx68Tp+kUVqL1AUdze8cAlQwzryQg03f3BZbJ5y2iIPf4EjnCWW8Is0RwHVZxWcVgpkFm7C6r8tUULj3cZc66r6AZAx9qXEOmTdnbED1vD0an3uoFbds89MANG0ehIRIZ9KXJ7doiF0Ie1xyZEvdWsyHpXPBhckN2MFF8iIF7tAtD5TEe8weVGSBaDpTCqTXm7ltLt3VMwDVFVgRwRqpF/H1B6xViAIOMUdXHlLsSLMbTtFQrS8ThSSUX/vLYG8n4voitBR1bPY+C2Wu+dDF83P16R04xH+fXeuoTe9Kgsww1H5A6WWguBp+HMpzcD5T8pdH83rLyRigk7cnaYRjlPrUp3tq38vGI8Vglwiw8K4SukNkt7T5nAdly+A/dvoP4Dpw9o7krCJqr2d+JTDta1i4j0IadvqaMHk0EtcNUowx0NtkCnDxgN7HPesvwghIknUXTBguP18rWFtnNVr2wQf0YGnWcOYd6K7IEiLKqr4a2tkkYWrZb6Y2AjV8qRjJakG7n/2fDqfatbI1ATAmfh5R9OVrYRNmHfDaRHR4nMGaMpIAnLvrr0XAGbZFvtgsDlgExgHY3Mt7iEGkEA8gJG+eDp5GEqjJIFWtOLTXipDmvdRrF/0TWF7VcFjGkXVaL0cR4fLgo5HF8DT1+AMg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(40470700004)(36840700001)(46966006)(336012)(2616005)(956004)(2906002)(47076005)(186003)(83380400001)(70206006)(70586007)(8676002)(16526019)(82310400005)(44832011)(41300700001)(40480700001)(478600001)(5660300002)(36756003)(31686004)(26005)(53546011)(8936002)(31696002)(81166007)(36860700001)(86362001)(82960400001)(40460700003)(6706004)(316002)(110136005)(16576012)(356005)(82740400003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 19:42:41.6523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e10dd6a2-5c7d-4f72-0135-08da7b087d36
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT016.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2027
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Aug 2022 19:42:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9152

On 09.08.22 13:40, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> A build with only the option `kas/efibootguard.yml` will not succeed.
> Move the content to a include in the image directory and the adapt the kas
> files.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/distro/cip-core-common.inc      |  2 +-
>  kas/opt/ebg-secure-boot-snakeoil.yml | 11 +++-----
>  kas/opt/ebg-swu.yml                  | 17 +++++++++---
>  kas/opt/efibootguard.yml             | 39 ----------------------------
>  recipes-core/images/efibootguard.inc | 19 ++++++++++++++
>  5 files changed, 37 insertions(+), 51 deletions(-)
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
> index 2822cef..ff65e99 100644
> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
> @@ -12,21 +12,16 @@
>  header:
>    version: 10
>    includes:
> -   - kas/opt/efibootguard.yml
> +    - kas/opt/ebg-swu.yml
>  
>  local_conf_header:
> -  image-options-swupdate: |
> -    CIP_IMAGE_OPTIONS_append = " swupdate.inc"
> -
> -  swupdate: |
> -    IMAGE_INSTALL_append = " swupdate"
> -    IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
> -
>    secure-boot-image: |
>      IMAGE_CLASSES += "verity"
>      IMAGE_FSTYPES = "wic"
>      WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
>      INITRAMFS_INSTALL_append = " initramfs-verity-hook"
> +    # abrootfs cannot be installed together with verity
> +    INITRAMFS_INSTALL_remove = " initramfs-abrootfs-hook"
>  
>    secure-boot: |
>      IMAGER_BUILD_DEPS += "ebg-secure-boot-signer"
> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
> index 5e4e771..bf54e4c 100644
> --- a/kas/opt/ebg-swu.yml
> +++ b/kas/opt/ebg-swu.yml
> @@ -12,12 +12,23 @@
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
> +  firmware-binaries: |
> +    # Add ovmf binaries for qemu
> +    IMAGER_BUILD_DEPS_append_qemu-amd64 += "ovmf-binaries"
> +    # not needed for Debian 11 and later
> +    OVERRIDES_append_qemu-amd64 = ":${BASE_DISTRO_CODENAME}"
> +    DISTRO_APT_SOURCES_append_qemu-amd64_buster = " conf/distro/debian-buster-backports.list"
> +    DISTRO_APT_PREFERENCES_append_qemu-amd64_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
> +    # Add U-Boot for qemu
> +    IMAGER_BUILD_DEPS_append_qemu-arm64 += "u-boot-qemu-arm64"
> +    IMAGER_BUILD_DEPS_append_qemu-arm += "u-boot-qemu-arm"
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
> index 0000000..504a9a9
> --- /dev/null
> +++ b/recipes-core/images/efibootguard.inc
> @@ -0,0 +1,19 @@
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

$ kas-container build kas-cip.yml:kas/board/bbb.yml:kas/opt/rt.yml:kas/opt/wic-targz-img.yml:kas/opt/bullseye.yml

ERROR: /build/../repo/recipes-core/images/cip-core-image-security.bb: WKS_FILE 'sdimage-efi.wks' not found                                                                                 ERROR: /build/../repo/recipes-core/images/cip-core-image.bb: WKS_FILE 'sdimage-efi.wks' not found
ERROR: Failed to parse recipe: /build/../repo/recipes-core/images/cip-core-image-security.bb
ERROR: /build/../repo/recipes-core/images/cip-core-image-kernelci.bb: WKS_FILE 'sdimage-efi.wks' not found

Dropping the series from next again.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

