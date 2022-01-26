Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01521C2BA4C
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 09:40:59 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.62])
 by mx.groups.io with SMTP id smtpd.web09.10478.1643190059107921461
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jan 2022 01:40:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=d9523BVo;
 spf=pass (domain: siemens.com, ip: 40.107.20.62,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASn5+IZQ3YEZQqAQS8KHnUnwcx4XDvRIQfxfYof2WUBE3diXBVpFS6Q2XkIINiv1aKedZ0rKUH4NDyfpg25EIzCVYVn9GvddOYD5Q71OyDmlYB0dKkE4ZJQIZyw0jIf/zwj9pFBjUZjRnVHeKdbKo9Vtp3gtR7wSm2FgZzARywlxFuDBL+1RIOGZ0FvpmOArcPEXqnamQfMMVtCYxF+C3dQP+zKvJwt1zdNsziptntMTQWdRm1CrG3QfJGkmp9nzB01oRy2abBRjzTHARhKPfYVwLtUp9K+pnd7f3DRTEPzUnk7w/dnbybV3g9ZgcCbqnC4VaEVqjzYNLGdqKySgog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atVxSAREkIkQLT6kTQ0RWbk65QlSYrp5qMqGfzcDsFk=;
 b=dfcLt8EtHE9dpX5MjJr8qejhf0yjfqZbWEBzlpMxhIWyPYneh/2lbR0FpR/VyNw48KKLmQ/CC6PDxS9wbp5zgOMP4WrJPVxMOIh5dgy/M8tKnPS5NjXunEm85yWryZ60SROA7/BgHsSvQVqAPpcTfx6A6RufPCt6CB10TOzHETdQFa6u7PGN1bQIESgcBBBpj4Al/bkAEVLuWVkmYXjyulaTkq3vfNyILUXZPf3tq5luNp29tNR/ZjcTL0Cmt2xBX7xkhxLH13kZw+wZi80ekDBqfKYy9liV/QVzk7tj7zo/XggDjnKWAZYmnCfQ5NBIsny47y3YqnaVXujsOqyUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atVxSAREkIkQLT6kTQ0RWbk65QlSYrp5qMqGfzcDsFk=;
 b=d9523BVo4d5B3tBxSwfLiHaC3KNW76NTV/fql/12s+s1+zYLrgmHpsRIlDQSmSHbmd6LVdoxUMJE0R9j8L3YyQhG/akljvCtBST/h0i5v8BMFjiYmq55JbgGE73qhTo0YgZnJGTpl3Rjb9qr0jAhLddBIi6SZ6MqBmB7Bma0nAJqjGhi8ZkCfacyRkPbumdRv0azV3Cx/Z4KS/YWbXUVmqUvwdzN+TwjddsXS6F9ZqmJSxD0Ro0oFEx0PnOif1ouf41lA8NKKqMYIfACMxYGiftoNyobNTtrO1OqsGWYpbBS9DgHWXH0CONFLfELrnEc3wD+i80LAzTln0exLm/llQ==
Received: from SV0P279CA0071.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::22)
 by DB9PR10MB4378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 09:40:57 +0000
Received: from HE1EUR01FT039.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::51) by SV0P279CA0071.outlook.office365.com
 (2603:10a6:f10:14::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Wed, 26 Jan 2022 09:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT039.mail.protection.outlook.com (10.152.0.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 09:40:56 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 26 Jan 2022 10:40:56 +0100
Received: from [167.87.32.162] (167.87.32.162) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 26 Jan 2022 10:40:55 +0100
Message-ID: <77019310-49de-2bb6-1070-d2c9303767b2@siemens.com>
Date: Wed, 26 Jan 2022 10:40:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] Update ISAR
Content-Language: en-US
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220124153748.646550-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220124153748.646550-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.162]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e378791-62f5-40a4-f111-08d9e0aff403
X-MS-TrafficTypeDiagnostic: DB9PR10MB4378:EE_
X-Microsoft-Antispam-PRVS: 
	<DB9PR10MB4378B495F1F8A926A9EF0F6295209@DB9PR10MB4378.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:30;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cd+Vj6jwu2XQxGQIieFBNUWYDXP4xMNs08UnsNHxZ5d7zxvWs/nwvbJSyPmVFZQ/F7BDZ5OymshNzqbVLwGYKZ1RGYj0r7ZDu95Raqd+ShkJHGeAQIdq4HZPJvWxmyWeIOTCLERnEUbHVZsHxDVumyILBS2MrHtuP+2dINcg/QzcRVBRv4DvwOLB8s6ku3Q8sGf+Q2eah9iLJCGzz+lBPBYqKYGjIWStS/MO9M5p07X/P/WJAL5uDUiEsMUOA6B2bgvYiu15HIWfXAMNi527S/r4/gkSGBrz7rkKyBRP+3q9vJ5epIRdIKfbXG2nMRVORGT/ljGh4GULcNgdrt7qZmTsxd7IA6vPZeu1DBF5Bgq0oBP8n8TnoV4xd8iN+ekOT9xxRY+7lGBQw0GGopl8etgCOb7A4JVWj5YltprDifbtHfHrrfuCIWwEAsWkZYfnlBleexgEKwFcQpLwbFdosKqGKvi5jm92GNq+y1Zqxb7vFZ3sYg6aO+UIWat+41rh//JQT8Q7QL/AXTzlDCZ4SNJcsGjmHwXQhXLxrQv3916Zyj6hnhuOgMjnbIKugW+DD4lAAxf4h6hi7T4hOvtZDGac1vFfCxrh5GA4P8ogqRyr+c6DesrU9iTM4Xjwbe+AlI/Gwuposo3H3ZGP8zdQhVveh2sZC65L/JHcD1/sqj1Z3PP7inCsEsNM871fwaGhF/IXpyMDArZlzRgT7re5039AFgy8jEpR00+Sb5jP2N18zgihpuq39CuwgDqnvfGjH9zV02Si9fYbr+v9M+xzjGM+Utz0enzDK6gQgYWqJbR4R7XDlF8VhJSkJnkMXnN6VYrVbEQyuYgxr1hbetzq726L9X5+pnK99Gg09kTq28I=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(40460700003)(356005)(15650500001)(44832011)(81166007)(82960400001)(110136005)(36756003)(5660300002)(316002)(8936002)(70206006)(70586007)(31686004)(8676002)(6706004)(16576012)(966005)(36860700001)(83380400001)(31696002)(508600001)(53546011)(47076005)(336012)(82310400004)(26005)(16526019)(86362001)(956004)(186003)(2616005)(2906002)(3940600001)(43740500002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 09:40:56.6496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5e378791-62f5-40a4-f111-08d9e0aff403
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT039.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jan 2022 09:40:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7484

On 24.01.22 16:37, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Update ISAR to commit 33b5aa65fa3f28987525799d0731fb4e7050207d and fix warnings.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   conf/machine/bbb.conf                | 2 +-
>   conf/machine/hihope-rzg2m.conf       | 2 +-
>   conf/machine/iwg20m.conf             | 2 +-
>   conf/machine/qemu-amd64.conf         | 2 +-
>   conf/machine/qemu-arm.conf           | 2 +-
>   conf/machine/qemu-arm64.conf         | 2 +-
>   conf/machine/simatic-ipc227e.conf    | 2 +-
>   kas-cip.yml                          | 2 +-
>   kas/opt/ebg-secure-boot-snakeoil.yml | 2 +-
>   kas/opt/efibootguard.yml             | 2 +-
>   kas/opt/swupdate.yml                 | 2 +-
>   kas/opt/targz-img.yml                | 2 +-
>   kas/opt/wic-targz-img.yml            | 2 +-
>   13 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
> index 6d8facb..81e624e 100644
> --- a/conf/machine/bbb.conf
> +++ b/conf/machine/bbb.conf
> @@ -8,7 +8,7 @@
>   
>   DISTRO_ARCH = "armhf"
>   
> -IMAGE_TYPE ?= "wic-img"
> +IMAGE_FSTYPES ?= "wic-img"
>   IMAGER_INSTALL += "u-boot-omap"
>   
>   IMAGE_INSTALL += "u-boot-script"
> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
> index 18a86d4..bc80ddd 100644
> --- a/conf/machine/hihope-rzg2m.conf
> +++ b/conf/machine/hihope-rzg2m.conf
> @@ -11,7 +11,7 @@
>   
>   DISTRO_ARCH = "arm64"
>   
> -IMAGE_TYPE ?= "wic-img"
> +IMAGE_FSTYPES ?= "wic-img"
>   
>   KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/renesas_defconfig"
>   USE_CIP_KERNEL_CONFIG = "1"
> diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
> index 91bfd94..a26f7fe 100644
> --- a/conf/machine/iwg20m.conf
> +++ b/conf/machine/iwg20m.conf
> @@ -8,7 +8,7 @@
>   DISTRO_ARCH = "armhf"
>   
>   # see wic/iwg20m.wks
> -IMAGE_TYPE ?= "wic-img"
> +IMAGE_FSTYPES ?= "wic-img"
>   
>   # sets serial login getty
>   MACHINE_SERIAL = "ttySC0"
> diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
> index d9605ca..a60f818 100644
> --- a/conf/machine/qemu-amd64.conf
> +++ b/conf/machine/qemu-amd64.conf
> @@ -8,6 +8,6 @@
>   
>   DISTRO_ARCH = "amd64"
>   
> -IMAGE_TYPE ?= "ext4-img"
> +IMAGE_FSTYPES ?= "ext4-img"
>   USE_CIP_KERNEL_CONFIG = "1"
>   KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_qemu_defconfig"
> diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
> index e439d49..aca6d7d 100644
> --- a/conf/machine/qemu-arm.conf
> +++ b/conf/machine/qemu-arm.conf
> @@ -9,6 +9,6 @@
>   
>   DISTRO_ARCH = "armhf"
>   
> -IMAGE_TYPE ?= "ext4-img"
> +IMAGE_FSTYPES ?= "ext4-img"
>   USE_CIP_KERNEL_CONFIG = "1"
>   KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_defconfig"
> diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
> index f2a301b..0d21262 100644
> --- a/conf/machine/qemu-arm64.conf
> +++ b/conf/machine/qemu-arm64.conf
> @@ -8,6 +8,6 @@
>   
>   DISTRO_ARCH = "arm64"
>   
> -IMAGE_TYPE ?= "ext4-img"
> +IMAGE_FSTYPES ?= "ext4-img"
>   USE_CIP_KERNEL_CONFIG = "1"
>   KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/qemu_arm64_defconfig"
> diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
> index 552a0b0..50d1f8a 100644
> --- a/conf/machine/simatic-ipc227e.conf
> +++ b/conf/machine/simatic-ipc227e.conf
> @@ -8,7 +8,7 @@
>   
>   DISTRO_ARCH = "amd64"
>   
> -IMAGE_TYPE ?= "wic-img"
> +IMAGE_FSTYPES ?= "wic-img"
>   IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
>   USE_CIP_KERNEL_CONFIG = "1"
>   KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_ipc227e_defconfig"
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 8226954..9c8ac9f 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>   
>     isar:
>       url: https://github.com/ilbers/isar.git
> -    refspec: ceb7e21154fc4862f704bb5c7739e87a26db6eb3
> +    refspec: 33b5aa65fa3f28987525799d0731fb4e7050207d
>       layers:
>         meta:
>       patches:
> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
> index 5aa5eff..1f4d668 100644
> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
> @@ -24,7 +24,7 @@ local_conf_header:
>   
>     verity-img: |
>       SECURE_IMAGE_FSTYPE = "squashfs"
> -    IMAGE_TYPE = "secure-swupdate-img"
> +    IMAGE_FSTYPES = "secure-swupdate-img"
>       WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
>   
>     secure-boot: |
> diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
> index 580c315..75d4ab1 100644
> --- a/kas/opt/efibootguard.yml
> +++ b/kas/opt/efibootguard.yml
> @@ -23,6 +23,6 @@ local_conf_header:
>     efibootguard-wic: |
>       WDOG_TIMEOUT ?= "60"
>       WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE"
> -    IMAGE_TYPE ?= "wic-img"
> +    IMAGE_FSTYPES ?= "wic-img"
>       WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
>   
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index 974eacb..a8b903f 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -20,5 +20,5 @@ local_conf_header:
>       IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
>   
>     wic-swu: |
> -    IMAGE_TYPE = "wic-swu-img"
> +    IMAGE_FSTYPES = "wic-swu-img"
>       WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
> diff --git a/kas/opt/targz-img.yml b/kas/opt/targz-img.yml
> index bdb5231..d555a8a 100644
> --- a/kas/opt/targz-img.yml
> +++ b/kas/opt/targz-img.yml
> @@ -14,4 +14,4 @@ header:
>   
>   local_conf_header:
>     image-type: |
> -    IMAGE_TYPE = "targz-img"
> +    IMAGE_FSTYPES = "targz-img"
> diff --git a/kas/opt/wic-targz-img.yml b/kas/opt/wic-targz-img.yml
> index 7e9081f..2e83760 100644
> --- a/kas/opt/wic-targz-img.yml
> +++ b/kas/opt/wic-targz-img.yml
> @@ -17,4 +17,4 @@ header:
>   
>   local_conf_header:
>     image-type: |
> -    IMAGE_TYPE = "wic-targz-img"
> +    IMAGE_FSTYPES = "wic-targz-img"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

