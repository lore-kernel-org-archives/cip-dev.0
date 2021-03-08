Return-Path: <SRS0=2D6l=IG=lists.cip-project.org=bounce+64572+6214+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44FDC433E6
	for <cip-dev@archiver.kernel.org>; Mon,  8 Mar 2021 13:23:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474F2651C3
	for <cip-dev@archiver.kernel.org>; Mon,  8 Mar 2021 13:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474F2651C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6214+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id OhwmYY4521723xtp2TieqPIH; Mon, 08 Mar 2021 05:23:10 -0800
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web11.35847.1615209789106582658
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Mar 2021 05:23:09 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 128DN7RZ023138
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 8 Mar 2021 14:23:07 +0100
X-Received: from [167.87.91.100] ([167.87.91.100])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 128DN6EK019178;
	Mon, 8 Mar 2021 14:23:06 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/2] conf/machine: Add KERNEL_DEFCONFIG_VERSION to select defconfig path
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20210304170934.7424-1-Quirin.Gylstorff@siemens.com>
 <20210304170934.7424-2-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <3a498774-8cd6-e3b8-3a6b-74fc04919bb2@siemens.com>
Date: Mon, 8 Mar 2021 14:23:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210304170934.7424-2-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: DLO7flinyEwe2ZMKtHUvRfcSx4520388AA=
Content-Type: multipart/mixed; boundary="YyiVgtO0AJRkkAoq1zuB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615209790;
 bh=AR/Y7EQaBWUVi1izG/9H5yec6gTA0pa51sy5sScdKvM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=L5vlJ5pxv/a1imBAYltzLpASKkzjNNOaFxosWsn2EklmQbsiwrZWcCWMcujlgWj1fzT
 kmU46Lw6Ew3ObbuiSa6909Pkbm4tBf8spXdNnTvUAg88VYYPkx46ChKNVPzanN/9VSOAx
 9MsjOoSBhikv7ZWSspJKA1ZJDcielcY1li0=

--YyiVgtO0AJRkkAoq1zuB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 04.03.21 18:09, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The repository cip-kernel-config[1] contains for each supported kernel
> version its own directory. Add the variable KERNEL_DEFCONFIG_VERSION
> to select the defconfig matching the kernel version.
> 
> Also add a version to select the rt configuration of [1].
> 
> [1]:https://gitlab.com/cip-project/cip-kernel/cip-kernel-config
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/machine/bbb.conf             | 5 +++++
>  conf/machine/hihope-rzg2m.conf    | 5 ++++-
>  conf/machine/iwg20m.conf          | 5 ++++-
>  conf/machine/qemu-amd64.conf      | 5 ++++-
>  conf/machine/simatic-ipc227e.conf | 5 ++++-

Err, shouldn't those version-selecting variables better be moved into
the versioned kernel recipes?

Jan

>  kas/opt/4.4.yml                   | 1 +
>  kas/opt/rt.yml                    | 1 +
>  7 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
> index a9b460e..2878ed1 100644
> --- a/conf/machine/bbb.conf
> +++ b/conf/machine/bbb.conf
> @@ -11,6 +11,11 @@ DISTRO_ARCH = "armhf"
>  IMAGE_TYPE ?= "wic-img"
>  IMAGER_INSTALL += "u-boot-omap"
>  
> +# kernel defconfig
> +USE_CIP_KERNEL_CONFIG = "1"
> +KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_bbb_defconfig"
> +
>  # On stretch, select U-Boot from buster which comes with distro-boot support
>  DISTRO_APT_SOURCES_append_cip-core-stretch = " conf/distro/debian-buster.list"
>  DISTRO_APT_PREFERENCES_cip-core-stretch += "conf/machine/preferences.bbb.conf"
> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
> index a2ae03d..2a46b74 100644
> --- a/conf/machine/hihope-rzg2m.conf
> +++ b/conf/machine/hihope-rzg2m.conf
> @@ -13,7 +13,10 @@ DISTRO_ARCH = "arm64"
>  
>  IMAGE_TYPE ?= "wic-img"
>  
> -KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/arm64/renesas_defconfig"
> +# kernel defconfig
> +KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/renesas_defconfig"
>  USE_CIP_KERNEL_CONFIG = "1"
> +
>  DTB_FILES = "r8a774a1-hihope-rzg2m-ex.dtb"
>  IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
> diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
> index 91bfd94..b5f9490 100644
> --- a/conf/machine/iwg20m.conf
> +++ b/conf/machine/iwg20m.conf
> @@ -17,8 +17,11 @@ BAUDRATE_TTY = "115200"
>  # kernel version
>  PREFERRED_VERSION_linux-cip ?= "4.4.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "4.4.%"
> +
> +# kernel defconfig
>  USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG = "cip-kernel-config/4.4.y-cip/arm/renesas_shmobile_defconfig"
> +KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/renesas_shmobile_defconfig"
>  
>  # Boot partition files
>  DTB_FILES = "r8a7743-iwg20d-q7-dbcm-ca.dtb"
> diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
> index c90d957..d99d8b1 100644
> --- a/conf/machine/qemu-amd64.conf
> +++ b/conf/machine/qemu-amd64.conf
> @@ -9,5 +9,8 @@
>  DISTRO_ARCH = "amd64"
>  
>  IMAGE_TYPE ?= "ext4-img"
> +
> +# kernel defconfig
>  USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/x86/cip_qemu_defconfig"
> +KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_qemu_defconfig"
> diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
> index 3c9638f..aacfc9d 100644
> --- a/conf/machine/simatic-ipc227e.conf
> +++ b/conf/machine/simatic-ipc227e.conf
> @@ -10,5 +10,8 @@ DISTRO_ARCH = "amd64"
>  
>  IMAGE_TYPE ?= "wic-img"
>  IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
> +
> +# kernel defconfig
>  USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/x86/siemens_ipc227e_defconfig"
> +KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_ipc227e_defconfig"
> diff --git a/kas/opt/4.4.yml b/kas/opt/4.4.yml
> index 65a4775..a601be3 100644
> --- a/kas/opt/4.4.yml
> +++ b/kas/opt/4.4.yml
> @@ -16,3 +16,4 @@ local_conf_header:
>    kernel-version: |
>      PREFERRED_VERSION_linux-cip = "4.4.%"
>      PREFERRED_VERSION_linux-cip-rt = "4.4.%"
> +    KERNEL_DEFCONFIG_VERSION = "4.4.y-cip"
> diff --git a/kas/opt/rt.yml b/kas/opt/rt.yml
> index b8fe6bb..d6fcf78 100644
> --- a/kas/opt/rt.yml
> +++ b/kas/opt/rt.yml
> @@ -15,3 +15,4 @@ header:
>  local_conf_header:
>    preempt-rt: |
>      KERNEL_NAME = "cip-rt"
> +    KERNEL_DEFCONFIG_VERSION_append = "-rt"
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--YyiVgtO0AJRkkAoq1zuB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6214): https://lists.cip-project.org/g/cip-dev/message=
/6214
Mute This Topic: https://lists.cip-project.org/mt/81081992/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--YyiVgtO0AJRkkAoq1zuB--
