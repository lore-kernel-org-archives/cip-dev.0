Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC9AC433F5
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 14:19:44 +0000 (UTC)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (EUR02-AM5-obe.outbound.protection.outlook.com [40.107.0.83])
 by mx.groups.io with SMTP id smtpd.web09.6682.1639750782519912377
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 06:19:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TloHZLG9;
 spf=pass (domain: siemens.com, ip: 40.107.0.83,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXq14BLFqCDIWKwnLhPpln2ij/6iVzhm2+nw+VYDq0xDc8lWKJjxbcqsK9OkDXka76PpAMa6u+TFoG6FNnp5d3Ng3NVJWPkLgVYSuHr9gpzUKo/CYe7HRBIdX2cW1QbksoOg89OZ3s0tGOY2kkUct1BKD1lRALzPj1kIZKNsc22fs0QVN3kH1BT262pZYXpCJMGN/c+wpbB8jHb715J31m111e17ZhrjLwfpBuBZg+ItGDojFW7mR5DgdTfy7ut0quwgIGbl648jsqxIxSqqpf2+FbCyDTADghMf5kWHw3SOgoxYiMuRWTTCraO+UXiKttXyWGy5WPwrNnFR6DxcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tm81f1H+PLywS90jl7JeRLDnCzs7xUd7jKEJ2XWBaF4=;
 b=UhXNFcoRnw8ljj6pKQj/q2nDsYgAShzYpD34CRYXGlyJFZ7TEm3Ew6M0vYbX8FA7tTjtd2JnyMcM/LOminW8z/AUe4BZFPNZJb7Wd5Nzl3TL9BQ68REr5AvlN2nblWHxJdISxCaSm6Avix6QWmxRkCoBvjwB1kaki+qVPKzgPl7A0x8NGIJWNGruK/NADR8V1DJHxtJdCEWrWFpnBtuMI3BtkZBVYdQxJ65IyJIU4B9v74HWq3i+keLyZOgPEiACJgD5KcXt7w+R/Zz9eOTmCdAs6Tatp/dfPsQlfMoR1mv0PxavnrwSAU5Idx98P/T5Gar14RisKJY6puNlBoH5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tm81f1H+PLywS90jl7JeRLDnCzs7xUd7jKEJ2XWBaF4=;
 b=TloHZLG9XNwSxUT67wV9RB5NYSPVzmi+Z+1PXDdHNgh8GWjm0Ng1vBJrcBvTc85VNQew1K/7jmS/bWzg4+G2vSpB5Iu2qkPjgjkCwsK5g2V/DrnvvU6O77ckz75/i2+Y1Z4I2ejgGU19S75S2C4XZkezPuB/2mCidFe88c+sFyPdWYPxdLLReP43QqdP4YuV0rDhoK8XP+jzj4adyQrtYa3MdAx/dlTclK21bjHvE9W9NGljSLmD+kOeWxLnP0+PiwVZpjjXrKaRqpxWNWOqochFgNH1CN1t6Py4YlfCPqpIUjRz0lXk9/ADAgvFkd8wUzVkBl4kYTqmtoCTzuKcqw==
Received: from DB6PR0501CA0014.eurprd05.prod.outlook.com (2603:10a6:4:8f::24)
 by HE1PR1001MB1436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Fri, 17 Dec
 2021 14:19:39 +0000
Received: from DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:8f:cafe::4e) by DB6PR0501CA0014.outlook.office365.com
 (2603:10a6:4:8f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 14:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT055.mail.protection.outlook.com (10.152.5.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 14:19:39 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 15:19:39 +0100
Received: from [167.87.72.12] (167.87.72.12) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:19:38 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH] Make read-only rootfs a inc file
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20211217135015.1189442-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6066ea89-53fb-98b6-9e4f-7e27486b6d97@siemens.com>
Date: Fri, 17 Dec 2021 15:19:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211217135015.1189442-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.12]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65a40fb4-6b6d-4e8f-75a7-08d9c168432b
X-MS-TrafficTypeDiagnostic: HE1PR1001MB1436:EE_
X-Microsoft-Antispam-PRVS: 
	<HE1PR1001MB14360CE34E457EE7D6A0EAC995789@HE1PR1001MB1436.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	P77dshYDfrg9DESUt1uhXsJ4eLVRCZd3B2i0PDi2G+cQnKieVKdu1YXHMjCqv82FKlTZUf0JAJ3IdbjSwl5sYy0C/ULfPraDY/1GPGXv+wQOO7y2P/HST+kZ9wRsQ6qKzd4nh61eZqkdNPqxAkSSH5eNidQR3gkt1OykP2JuBNUfkaD7EKIFHJJ0/xXnJCHDSvJpFlUKQuLz3Ucz7Nxi9IER0hG2JtvsPXj/LgPQpQClHEiXc/JxhTABDrSAcDHZ8teWrvALYdcFLvDrde0eOKIzY/pW6q1ILiAPufVkhQx2b+VW/JdUVqC96jiZEf5QZCI4qzSPbf9+NhwxTW07sZwkXAarm8baymmV+fDbe2i8v56AHmTsKCGZjkHWC92ciCISbcCj+hZFJjiypjeGhzuoDtl9vrnRzQNyFJPIWIKpXA80UevdLfhTsH+NBpYEvp9cOrs7ZEzqUVjaCNMvt8SBcTHWSbDKVJEWJ7esPMu77FnTAV71bYLSUxS0x8lnqLCFlWHgxTz8wySCopltI6iUw9DA7oecAUky5raoMrl5QlkXn0jhW49AZCVk3QUxb51zPJeGTC912oDVEEOF/Nz7O2Cm48oUxmxsgT8qEnvxQiZK1WLzAqKohagOaDDDeGDVXlffYH0oyiKOhPSi0sEbGUiOlWilbq9+NE2lbnxU3v2jEaTjUolk/avp7gxo5tZ+LvsO+0RlExa+XtbGTY0WuBDy3XMduYDR7qNZ6g8IEpuJ4B+dnxn2DRtONiBadRMNDlt1QjxYTd/vyZPu38/oE2/Ws6mQDMXYZQg93LxMllsWCifdfM4J8+CumClftQrS8C2jzJU6pTSzmICcwqj44EKxcU5yc4PAI3+spyU=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(31696002)(47076005)(5660300002)(508600001)(36756003)(956004)(81166007)(86362001)(26005)(356005)(82310400004)(2616005)(36860700001)(44832011)(16576012)(31686004)(316002)(16526019)(6706004)(186003)(110136005)(2906002)(53546011)(40460700001)(336012)(70206006)(82960400001)(8676002)(83380400001)(8936002)(70586007)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 14:19:39.6692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 65a40fb4-6b6d-4e8f-75a7-08d9c168432b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1436
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 14:19:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7180

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

Thanks, applied to next.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

