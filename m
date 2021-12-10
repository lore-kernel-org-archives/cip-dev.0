Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18276C433EF
	for <webhook@archiver.kernel.org>; Fri, 10 Dec 2021 09:58:19 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.88])
 by mx.groups.io with SMTP id smtpd.web09.5139.1639130296765855246
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Dec 2021 01:58:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vBhIbgoX;
 spf=pass (domain: siemens.com, ip: 40.107.20.88,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeIkCuIHLyZ+4pKTY0XgYpuCPELwtfLc+8pR+2a7/JLoAoy2WpCQOU02rClwLVlIr+SgiaEiyDwnSR3/1DIEZ/y8hQhjSmKfuz4MdGOr5VrAQaO71+RZgDXI5EWUT/9U/lPwyU1XxOBLd7RCz1xmee56AfdRRHt9skylqZIYbHy+WpAlcKhqQE+7m74o5TPOvlnV/woZDssG6fUqveqpjpjNpyV7qYc3oYfe1Vm8N2EjL+j7KWtC0cF6YU96HOhHFHrI0d4b7QMISmQjLd7Tg84B6DVa09zrTGcAIMH+74scrbNbl1BjcCXLbE/pcUuaNPL8YlEn2Ojfs1JsCrJrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQ+tP1gE7sYxDYE6yeCyV5A/DSV2z5ToK9WkhhG95UQ=;
 b=MLXiRD0ocbNnh6oAZxRTmF9TPORbVoG7cTDRyalHYzjyzLhr+cXa6fMdt7QHKsXPxSQRfqq+QdND5mdn/Mm6W/loy6ZDS2eZ+xLLUDmsyZgadso2MMvJrFW/rrV0gA9A1cISD0WiN6IFDIwd3VhuQph3TCMT9MS25w3vrlDhJUvWvXSzb6H52ILEj4y8fNyiqIYVqTDKQjJkvc7onLV8IaQQWztpTktVI1OsBs3V1wfjxFJYB7Nt/uuUIgOVkwPDMQgQsidGD6lpY/RGddp8TcPtf6b+p2aA84m4Vf1bx7wfCFnKEpi0392vEF4T9BQmi04BzMa+ZgiT4X977BWe/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQ+tP1gE7sYxDYE6yeCyV5A/DSV2z5ToK9WkhhG95UQ=;
 b=vBhIbgoXR71bAo8AJP0Qt3LG+ZZzWFGaacKeRRTMWBQD7u8IbzCqDLJOPvHY43oNUf4Wzaz2eGE2dfKTycjB1o6XvaxtD1jcP2MpZUZX23t1gwcmPOUP6KNBrwPwab1f+vcEA0HUD3kLnkofumJ/lOl2q5ROij9hWX4OP4HUf1SIrEiBcabvUarWe5EuQC9ozx/t2G6bEew5W3nb8iJ2QIUsmdIv3zwml7wisFUZSamAA1Pk1AwttfH5W6T7+s9afT+LROIfFIRVsB7EN1Zqf6GUXxGQ9n05XffBSO7M3Mig3zd6gLvu+6Tw4Rtmua+RmLIl0yDcKTufgqdHraQPJA==
Received: from AS9PR06CA0315.eurprd06.prod.outlook.com (2603:10a6:20b:45b::26)
 by AM9PR10MB4354.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:266::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 09:58:14 +0000
Received: from VE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:45b:cafe::4d) by AS9PR06CA0315.outlook.office365.com
 (2603:10a6:20b:45b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Fri, 10 Dec 2021 09:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT043.mail.protection.outlook.com (10.152.3.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Fri, 10 Dec 2021 09:58:13 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Dec 2021 10:58:12 +0100
Received: from [167.87.72.174] (167.87.72.174) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Dec 2021 10:58:12 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH] conf/machine/*: Add variable to
 set version of kernel defconfig
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20211210093448.1860864-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c482fbfe-53b4-5d80-c84f-914343e224e5@siemens.com>
Date: Fri, 10 Dec 2021 10:58:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211210093448.1860864-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.174]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6929a826-3996-4926-089d-08d9bbc394ba
X-MS-TrafficTypeDiagnostic: AM9PR10MB4354:EE_
X-Microsoft-Antispam-PRVS: 
	<AM9PR10MB4354E56050F0A756067F23F795719@AM9PR10MB4354.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Eynq7m7kTlR1Nphh9Za0C0DI/AO79Pp5iCOrm2XShJk3i/O8jPqtnDV15afExOdNg+L2zB/VX/wYcl7ONtjK/mRlZEosnkt6l2t8ZF26t11pjujnlmQcMkOW6LuxUxzrYsKhg8MdKIlpfawRCyqP0oKcbcZ4Xf2NVEtHWiZK3/t8m/VUtp+oKIHinzkIR6FJRUvC/f+rYfeo1Q6vBmKuT/24aQkW3HLmKapYuVKgOeklHPWANYSIkj3QAM4OzglTnPagmXCSuCBVuv1hu+0XrRkBAqXtugok+iXoiPmEyjOPZZuIC6vKItXAvOkMZCHpJvxNcqqL1RO+kv++By+4MgcMA3ci1nhpz2Ir3bGhtEwfa5wA4cVEZBa7be9XeVfAbl4SXcKyqxXoA7G3emnEOKP/iLy0MouAgzqT2jw9saNjURqxHilhfSFy9zpmmBifK5mni3UjNAwf1n4LZCu2og9f2P6tRGhxrSuAZNy+kDSH42FhHYlaVnCRQ3R4VGSj1cAwD/pisXbBiO4OuNwdcSQ9sXKA1PBV20NcjOjS3jYQVXjPa4cXYAcJPwsCW9nPh0L8lFQSjmkoykLA61r+Sl/nip84/mW2AT0jxV4RaVDsXE4s4if9bcfXGZ9zz50wo1CjZ1eeyAkHEFeNwsNYEXUKNTX2XkKn2EU/7SGfQ2IfS3pEoPuPc+dOwhIHKK0BR+8LGzHpUYj2uWsZpieG4giZb0aV6055yPW1DiouLeIJUWngDzRt3CepLmjIcTf/wrphvkI9ugkkVy86uoAGeLQ1oTusbJ9gQCk+2xF3dBF66AS7GkwVmm8mQLrv8flOjdfOmE4P8XkWZakes3HdcBLWyql4sWUol8qQ2HPxOaGFg5JbOWesjfYH/D+PG2/4ABRADGv/vQhqpr7VdW5iTGJPbLu9VeLxfUGclNMthfc=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(26005)(81166007)(16576012)(31696002)(47076005)(70586007)(82960400001)(2616005)(70206006)(83380400001)(956004)(5660300002)(86362001)(356005)(44832011)(53546011)(966005)(110136005)(31686004)(82310400004)(36860700001)(8676002)(316002)(36756003)(2906002)(6706004)(186003)(16526019)(8936002)(336012)(508600001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 09:58:13.7247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6929a826-3996-4926-089d-08d9bbc394ba
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4354
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Dec 2021 09:58:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7085

On 10.12.21 10:34, Q. Gylstorff wrote:
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
> 
> [1]: https://gitlab.com/cip-project/cip-kernel/cip-kernel-config
> [17]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/17
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/machine/hihope-rzg2m.conf    | 3 ++-
>  conf/machine/qemu-amd64.conf      | 3 ++-
>  conf/machine/qemu-arm.conf        | 3 ++-
>  conf/machine/qemu-arm64.conf      | 3 ++-
>  conf/machine/simatic-ipc227e.conf | 3 ++-
>  kas/opt/4.19.yml                  | 2 ++
>  kas/opt/4.4.yml                   | 2 ++
>  kas/opt/5.10.yml                  | 2 ++
>  8 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
> index 4f4ee81..74f03df 100644
> --- a/conf/machine/hihope-rzg2m.conf
> +++ b/conf/machine/hihope-rzg2m.conf
> @@ -13,7 +13,8 @@ DISTRO_ARCH = "arm64"
>  
>  IMAGE_TYPE ?= "wic-img"
>  
> -KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/arm64/renesas_defconfig"
> +KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"

This variable must be set by the kernel recipe, not the machine.

Jan

> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/renesas_defconfig"
>  USE_CIP_KERNEL_CONFIG = "1"
>  DTB_FILES = "r8a774a1-hihope-rzg2m-ex.dtb"
>  IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
> diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
> index c90d957..af20bf4 100644
> --- a/conf/machine/qemu-amd64.conf
> +++ b/conf/machine/qemu-amd64.conf
> @@ -10,4 +10,5 @@ DISTRO_ARCH = "amd64"
>  
>  IMAGE_TYPE ?= "ext4-img"
>  USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/x86/cip_qemu_defconfig"
> +KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_qemu_defconfig"
> diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
> index 81a22c1..f9e665d 100644
> --- a/conf/machine/qemu-arm.conf
> +++ b/conf/machine/qemu-arm.conf
> @@ -11,4 +11,5 @@ DISTRO_ARCH = "armhf"
>  
>  IMAGE_TYPE ?= "ext4-img"
>  USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG ?= "cip-kernel-config/4.19.y-cip/arm/qemu_arm_defconfig"
> +KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
> +KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_defconfig"
> diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
> index eb34703..1a48093 100644
> --- a/conf/machine/qemu-arm64.conf
> +++ b/conf/machine/qemu-arm64.conf
> @@ -10,4 +10,5 @@ DISTRO_ARCH = "arm64"
>  
>  IMAGE_TYPE ?= "ext4-img"
>  USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG ?= "cip-kernel-config/4.19.y-cip/arm64/qemu_arm64_defconfig"
> +KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
> +KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/qemu_arm64_defconfig"
> diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
> index 3c9638f..d8c7fec 100644
> --- a/conf/machine/simatic-ipc227e.conf
> +++ b/conf/machine/simatic-ipc227e.conf
> @@ -11,4 +11,5 @@ DISTRO_ARCH = "amd64"
>  IMAGE_TYPE ?= "wic-img"
>  IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
>  USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/x86/siemens_ipc227e_defconfig"
> +KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_ipc227e_defconfig"
> diff --git a/kas/opt/4.19.yml b/kas/opt/4.19.yml
> index 5ff1683..581ea93 100644
> --- a/kas/opt/4.19.yml
> +++ b/kas/opt/4.19.yml
> @@ -16,3 +16,5 @@ local_conf_header:
>    kernel-version: |
>      PREFERRED_VERSION_linux-cip = "4.19.%"
>      PREFERRED_VERSION_linux-cip-rt = "4.19.%"
> +  defconfig: |
> +    KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
> diff --git a/kas/opt/4.4.yml b/kas/opt/4.4.yml
> index 65a4775..dae1b52 100644
> --- a/kas/opt/4.4.yml
> +++ b/kas/opt/4.4.yml
> @@ -16,3 +16,5 @@ local_conf_header:
>    kernel-version: |
>      PREFERRED_VERSION_linux-cip = "4.4.%"
>      PREFERRED_VERSION_linux-cip-rt = "4.4.%"
> +  defconfig: |
> +    KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
> diff --git a/kas/opt/5.10.yml b/kas/opt/5.10.yml
> index 612b7f9..e048450 100644
> --- a/kas/opt/5.10.yml
> +++ b/kas/opt/5.10.yml
> @@ -16,3 +16,5 @@ local_conf_header:
>    kernel-version: |
>      PREFERRED_VERSION_linux-cip = "5.10.%"
>      PREFERRED_VERSION_linux-cip-rt = "5.10.%"
> +  defconfig: |
> +    KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

