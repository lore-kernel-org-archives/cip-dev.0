Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27793C433F5
	for <webhook@archiver.kernel.org>; Mon, 13 Dec 2021 08:17:55 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.42])
 by mx.groups.io with SMTP id smtpd.web09.8733.1639383473151497397
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Dec 2021 00:17:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MopMd1mD;
 spf=pass (domain: siemens.com, ip: 40.107.22.42,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UN0zmf38YL5gSS09z7sX+Up1Lkh3oLrlIZgria08s5O6yxPVKUuWGF4D64ih3TtFTRhMLHhtUWiL205K982ObupEUWyf3cSjg4gszauGBVmMkn/A0LsbXklkufoScndR/bpPeN8Ep/OVbxdSqzScUkfWmv9AbK010lyeW8X795qltF3pMSXWsEvrS2S1kngBS2hMkJUCoaipzkBklabw8wP7qtmwici+MTzk7KGoIIOOCPCqsP/EQw6HPjs5VEN8j/Ap9/KHNC7/VBMJySFoRQm5/NYIM3kx9u65DRWa0OwLEilHs1LxrgzY30+Sd24VgfnDKfZl5XJaXxPQRvVLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRBNxvSAEEV9QHaff4xg/LSj2azIOEOu+7U+KuYLjek=;
 b=VwXgWwT1IjGAhlujdixKuFDoGzzmrGd4Fx19U1L5Ktr7zi6F/is57bq+vCpDeATdr+Y8dhbLjdfiiOTi8uL92+eBObRXhBSh0pKM/n8razVu8NsucTv3DkQcWwAIMTiRbvVwF5gyuqKpRwHw/dfwUKRgWmcJsh2Uh6I8m98acClBl1J2qq9qHsxGTS7KvNuJXeSA14+oROa/r20Evq/0l5uRrSuX9fQJTw03U79Y5YWqHjmHjKr/R8K1VBMt/JLkYpstGikjIRpcN91EMeoDJe86V9l7PckLUEKrDl5d9wGLJodi4nB7JOBeQLD+N10xcx1kNCRp40rBw5p6PX+9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRBNxvSAEEV9QHaff4xg/LSj2azIOEOu+7U+KuYLjek=;
 b=MopMd1mDVsO5PYc8FNXSd3VCnEPSMTWT1LR5M3IwGORGHDin18NEYumpuqfsmFhZXz658mzslPvpGiLuRIymqEXBRhR2JgtdutYYge0bbF5SGByJ9fpT1TL9a+6KnWTRCfoTdar5SCSC3mjDNZx1RAWF0kn6OmpULslgQx20P5WHgC7qyqhElZ9wdhlNzDkCluQ35t1mq7HAs8fX3ng5nDWARMqJC3PL9aPl7EEtgXlLeBn7JFrjoph198/bnd2x/X7o7alsYIylPPrf1Kg/hl48YGGUFibnCgD7UPGBFqcd/7X+oTZ/QDGNqEjkgEf9fSaQRa0VzUoj7KIjKMYt7A==
Received: from DU2PR04CA0360.eurprd04.prod.outlook.com (2603:10a6:10:2b4::28)
 by DB6PR10MB1815.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:39::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 13 Dec
 2021 08:17:50 +0000
Received: from DB5EUR01FT042.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b4:cafe::57) by DU2PR04CA0360.outlook.office365.com
 (2603:10a6:10:2b4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Mon, 13 Dec 2021 08:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT042.mail.protection.outlook.com (10.152.5.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Mon, 13 Dec 2021 08:17:49 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 09:17:49 +0100
Received: from [167.87.72.173] (167.87.72.173) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 09:17:48 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] conf/machine/*: Add variable
 to set version of kernel defconfig
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20211213081354.2500909-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d7e29dad-0ba4-c87a-3d62-d2b439612521@siemens.com>
Date: Mon, 13 Dec 2021 09:17:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211213081354.2500909-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.173]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d38c0434-6926-4e7a-55dc-08d9be110d58
X-MS-TrafficTypeDiagnostic: DB6PR10MB1815:EE_
X-Microsoft-Antispam-PRVS: 
	<DB6PR10MB1815AEAD1336E386C70E004A95749@DB6PR10MB1815.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HbQ9KjZOixOHyC5VL/9XjHK19Hm8/unDO30Nvq5mV1V8sHMk3qQFamHmi8h+y7rM5dKjtlAskTfVI9N/rTVPECtZFI1OuQSkzgMih6XsFiV2xhQvYM8O4cDN7b9rZAw3FYpEaXcuWWFWDDFpJHkMt5q2A+hmn/qPt0BWqLjSQBIE8yk5V6KyMb1UuWMmoViAdP5dMr2qQsHUgcASnNx/63IOViUVlZNV3HgGioY5ZxmUr5nOyfGUuWqNtX2NMq2DtfjSMM7yBODSC7eAAEWp5ofr688DntZOMhnf+E7VefIvcKmceYiMdyp7GJ3xGenBHXm4XlNn0sma3+CF6X4Vsv1k7vg03dy+LXtx6MqIqrCWkaMHKjRUwoWSSXgYpfEXQOl1sOwyIr9aTTtefKPbTmtrT2mApIZIURwW1N6rN5Xhz0onO9ujWBxhzgAeEFU8OIuYwJT2zLuQGuAVR1puc9rcLVk/7LD7CVyb1hGv/Yjzl96XINwURnXxQ566IVnvNzDHCLjHLu5SjRnW9aHuvIXf/RwIg3UTnnkashc6cdVEgNGHQUWj8sqt91cyXWP7DZJfOR3Qr59XhFKALgnXgiZeq/PJJB6Yp7lk1E5PmtrC0/NaM97JOq7nx4u6fYg5jQZbkrUw8Tr44EbZXhollWoZwWjNSHERqvaelRfEhxfW2gLzJDw1v6zbsf2jnsD13zIqJzws+AV3uUu5t5xfShUobHNdBbBcQ62SOzHMeCs3oj84HByAewiQAzJmEjmixaadIBiKVhhB9O7zXwZivyEXRsDryvllLfgyzRrTawxWDw4zYU2r7a5evKclwMvY63MDXQZGl0SHvwP1E3CEdQKwQ/D5pRDSdms/NjyrlHON9oUG2tXeiw8iRtXRE+959bdx3+GiGA4KaDTnd+S4hbzvjGgEd7QTxU4PI5h4Fyo=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8676002)(16526019)(8936002)(31686004)(70206006)(110136005)(82310400004)(956004)(53546011)(47076005)(86362001)(508600001)(82960400001)(356005)(36860700001)(6666004)(6706004)(2906002)(83380400001)(16576012)(70586007)(44832011)(966005)(81166007)(5660300002)(336012)(2616005)(36756003)(31696002)(186003)(26005)(316002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 08:17:49.6625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d38c0434-6926-4e7a-55dc-08d9be110d58
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT042.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1815
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Dec 2021 08:17:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7096

On 13.12.21 09:13, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes an issue, that the defconfig from kernel 4.19.X does not
> work with kernel 5.10.X. The kernel boots but cannot find any qemu hard
> disk.
> 
> The fix adds the new Variable
> KERNEL_DEFCONFIG_VERSION to select to correct path in [1].
> 
> This fixes issue [17].
> [1]: https://gitlab.com/cip-project/cip-kernel/cip-kernel-config
> [17]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/17
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes V2:
>  - Set KERNEL_DEFCONFIG_VERSION in linux kernel recipes instead of
>    machine config
>  - change Commit message
> 
>  conf/machine/hihope-rzg2m.conf                           | 2 +-
>  conf/machine/qemu-amd64.conf                             | 2 +-
>  conf/machine/qemu-arm.conf                               | 2 +-
>  conf/machine/qemu-arm64.conf                             | 2 +-
>  conf/machine/simatic-ipc227e.conf                        | 2 +-
>  recipes-kernel/linux/linux-cip-rt_4.19.217-cip62-rt23.bb | 2 ++
>  recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb  | 2 ++
>  recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb    | 2 ++
>  recipes-kernel/linux/linux-cip_4.19.217-cip62.bb         | 2 ++
>  recipes-kernel/linux/linux-cip_4.4.291-cip65.bb          | 2 ++
>  recipes-kernel/linux/linux-cip_5.10.83-cip1.bb           | 2 ++
>  11 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
> index 4f4ee81..18a86d4 100644
> --- a/conf/machine/hihope-rzg2m.conf
> +++ b/conf/machine/hihope-rzg2m.conf
> @@ -13,7 +13,7 @@ DISTRO_ARCH = "arm64"
>  
>  IMAGE_TYPE ?= "wic-img"
>  
> -KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/arm64/renesas_defconfig"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/renesas_defconfig"
>  USE_CIP_KERNEL_CONFIG = "1"
>  DTB_FILES = "r8a774a1-hihope-rzg2m-ex.dtb"
>  IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
> diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
> index c90d957..d9605ca 100644
> --- a/conf/machine/qemu-amd64.conf
> +++ b/conf/machine/qemu-amd64.conf
> @@ -10,4 +10,4 @@ DISTRO_ARCH = "amd64"
>  
>  IMAGE_TYPE ?= "ext4-img"
>  USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/x86/cip_qemu_defconfig"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_qemu_defconfig"
> diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
> index 81a22c1..e439d49 100644
> --- a/conf/machine/qemu-arm.conf
> +++ b/conf/machine/qemu-arm.conf
> @@ -11,4 +11,4 @@ DISTRO_ARCH = "armhf"
>  
>  IMAGE_TYPE ?= "ext4-img"
>  USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG ?= "cip-kernel-config/4.19.y-cip/arm/qemu_arm_defconfig"
> +KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_defconfig"
> diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
> index eb34703..f2a301b 100644
> --- a/conf/machine/qemu-arm64.conf
> +++ b/conf/machine/qemu-arm64.conf
> @@ -10,4 +10,4 @@ DISTRO_ARCH = "arm64"
>  
>  IMAGE_TYPE ?= "ext4-img"
>  USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG ?= "cip-kernel-config/4.19.y-cip/arm64/qemu_arm64_defconfig"
> +KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/qemu_arm64_defconfig"
> diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
> index 3c9638f..552a0b0 100644
> --- a/conf/machine/simatic-ipc227e.conf
> +++ b/conf/machine/simatic-ipc227e.conf
> @@ -11,4 +11,4 @@ DISTRO_ARCH = "amd64"
>  IMAGE_TYPE ?= "wic-img"
>  IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
>  USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/x86/siemens_ipc227e_defconfig"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_ipc227e_defconfig"
> diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.217-cip62-rt23.bb b/recipes-kernel/linux/linux-cip-rt_4.19.217-cip62-rt23.bb
> index a3a9c43..2eefbdc 100644
> --- a/recipes-kernel/linux/linux-cip-rt_4.19.217-cip62-rt23.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_4.19.217-cip62-rt23.bb
> @@ -11,4 +11,6 @@
>  
>  require linux-cip-rt-common.inc
>  
> +KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
> +
>  SRC_URI[sha256sum] = "f7584d79132ad99ed5b7ce7430c79a08cb9b81ad40b5982464f95859a00ceb6f"
> diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb b/recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb
> index c051583..41342b3 100644
> --- a/recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_4.4.285-cip63-rt36.bb
> @@ -11,4 +11,6 @@
>  
>  require linux-cip-rt-common.inc
>  
> +KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
> +
>  SRC_URI[sha256sum] = "c2fe6bcf44fc7a8ee9785adc4dc41d07c50d803883add859648cbbb0461854fa"
> diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb b/recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb
> index 7b38c1e..b20ac56 100644
> --- a/recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_5.10.83-cip1-rt1.bb
> @@ -11,4 +11,6 @@
>  
>  require linux-cip-rt-common.inc
>  
> +KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
> +
>  SRC_URI[sha256sum] = "e10b3ab1ad09ed7650883c5357b68660ac1c56f6d71b3b82feb0d69ed182ea54"
> diff --git a/recipes-kernel/linux/linux-cip_4.19.217-cip62.bb b/recipes-kernel/linux/linux-cip_4.19.217-cip62.bb
> index 1a60571..0147313 100644
> --- a/recipes-kernel/linux/linux-cip_4.19.217-cip62.bb
> +++ b/recipes-kernel/linux/linux-cip_4.19.217-cip62.bb
> @@ -11,4 +11,6 @@
>  
>  require linux-cip-common.inc
>  
> +KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
> +
>  SRC_URI[sha256sum] = "00b22f2e7b3d4f5787ca92f2e182211ac2c1391c09435174c2b4670b2837b23c"
> diff --git a/recipes-kernel/linux/linux-cip_4.4.291-cip65.bb b/recipes-kernel/linux/linux-cip_4.4.291-cip65.bb
> index e45c57c..4e32031 100644
> --- a/recipes-kernel/linux/linux-cip_4.4.291-cip65.bb
> +++ b/recipes-kernel/linux/linux-cip_4.4.291-cip65.bb
> @@ -11,4 +11,6 @@
>  
>  require linux-cip-common.inc
>  
> +KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
> +
>  SRC_URI[sha256sum] = "9ed7782c067793e684691e99388608ff746f04121cc35dbbbfc2fa5ed6f9e88e"
> diff --git a/recipes-kernel/linux/linux-cip_5.10.83-cip1.bb b/recipes-kernel/linux/linux-cip_5.10.83-cip1.bb
> index a89f568..236358a 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.83-cip1.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.83-cip1.bb
> @@ -11,4 +11,6 @@
>  
>  require linux-cip-common.inc
>  
> +KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
> +
>  SRC_URI[sha256sum] = "85af8f809b2505c6434266d6658d977d62d383889b3a4f9968b2764794108d4f"
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

