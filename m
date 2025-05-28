Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7488CC3ABB2
	for <webhook@archiver.kernel.org>; Wed, 28 May 2025 13:57:38 +0000 (UTC)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 by mx.groups.io with SMTP id smtpd.web11.16372.1748440654490648863
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 May 2025 06:57:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=lB7g8N08;
 spf=pass (domain: ti.com, ip: 198.47.19.246, mailfrom: s-adivi@ti.com)
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54SDvXLg2079285;
	Wed, 28 May 2025 08:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1748440653;
	bh=Rr4KlTaZRJjcGgQVw7KE5vwpfn+F/229XXI08rlltGE=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=lB7g8N08SBiFfjPciJZd8Oanpl3hHH0qStAwDlS/6PBHDlFfRlM+/RaueFTfyi2g/
	 H2TLYvF+sYgtxp9kuC9aQwFClLhQ6qyNISG0kqbP7lFf45QlRXCHQDsKc8Peq3NQFU
	 ZDZndZBE+9Cy43H1cabEXB9UrIADg8Vjs4ps87+Y=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54SDvXUc3651437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 28 May 2025 08:57:33 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 May 2025 08:57:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 May 2025 08:57:32 -0500
Received: from [10.249.138.8] ([10.249.138.8])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54SDvUt6208588;
	Wed, 28 May 2025 08:57:31 -0500
Message-ID: <a1604461-aeb6-4470-9e60-15a182b5a9e1@ti.com>
Date: Wed, 28 May 2025 19:27:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/5] linux-cip: Prepare for building
 from git branches
To: Jan Kiszka <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
References: <cover.1748011667.git.jan.kiszka@siemens.com>
 <a68e8919f9ed973f4271d33fc510a5533069fe08.1748011667.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
In-Reply-To: <a68e8919f9ed973f4271d33fc510a5533069fe08.1748011667.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 May 2025 13:57:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18953



On 5/23/2025 8:17 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Split off to common bits that are relevant for all cip kernel builds
> from those that are only used when building release tarballs. This
> prepares to build from git branches as well.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>

> ---
>   recipes-kernel/linux/linux-cip-common.inc             |  9 +--------
>   .../{linux-cip-common.inc => linux-cip-release.inc}   | 11 ++---------
>   .../linux/linux-cip-rt_4.19.325-cip118-rt41.bb        |  2 +-
>   .../linux/linux-cip-rt_4.4.302-cip98-rt55.bb          |  2 +-
>   .../linux/linux-cip-rt_5.10.237-cip60-rt26.bb         |  2 +-
>   .../linux/linux-cip-rt_6.1.134-cip41-rt22.bb          |  2 +-
>   recipes-kernel/linux/linux-cip_4.19.325-cip120.bb     |  2 +-
>   recipes-kernel/linux/linux-cip_4.4.302-cip99.bb       |  2 +-
>   recipes-kernel/linux/linux-cip_5.10.237-cip60.bb      |  2 +-
>   recipes-kernel/linux/linux-cip_6.1.137-cip42.bb       |  2 +-
>   recipes-kernel/linux/linux-cip_6.12.29-cip1.bb        |  2 +-
>   11 files changed, 12 insertions(+), 26 deletions(-)
>   copy recipes-kernel/linux/{linux-cip-common.inc => linux-cip-release.inc} (50%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
> index f20d6a06..aa625674 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -11,17 +11,10 @@
>   
>   FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
>   
> -KERNEL_MAJOR_MINOR = "${@d.getVar('PV').split('.')[0] + '.' + d.getVar('PV').split('.')[1]}"
> -
>   KERNEL_DEFCONFIG_VERSION ?= "${KERNEL_MAJOR_MINOR}.y-cip"
>   KERNEL_DEFCONFIG ?= "${MACHINE}_defconfig"
>   
>   require recipes-kernel/linux/linux-custom.inc
>   require recipes-kernel/linux/cip-kernel-config.inc
>   
> -SRC_URI += " \
> -    https://cdn.kernel.org/pub/linux/kernel/projects/cip/${KERNEL_MAJOR_MINOR}/linux-cip-${PV}.tar.xz \
> -    ${@'file://preempt-rt.cfg' if d.getVar('KERNEL_NAME') == 'cip-rt' else ''} \
> -    "
> -
> -S = "${WORKDIR}/linux-cip-${PV}"
> +SRC_URI += "${@'file://preempt-rt.cfg' if d.getVar('KERNEL_NAME') == 'cip-rt' else ''}"
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-release.inc
> similarity index 50%
> copy from recipes-kernel/linux/linux-cip-common.inc
> copy to recipes-kernel/linux/linux-cip-release.inc
> index f20d6a06..25c2789b 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-release.inc
> @@ -1,7 +1,7 @@
>   #
>   # CIP Core, generic profile
>   #
> -# Copyright (c) Siemens AG, 2022-2025
> +# Copyright (c) Siemens, 2022-2025
>   #
>   # Authors:
>   #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -9,19 +9,12 @@
>   # SPDX-License-Identifier: MIT
>   #
>   
> -FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
> +require linux-cip-common.inc
>   
>   KERNEL_MAJOR_MINOR = "${@d.getVar('PV').split('.')[0] + '.' + d.getVar('PV').split('.')[1]}"
>   
> -KERNEL_DEFCONFIG_VERSION ?= "${KERNEL_MAJOR_MINOR}.y-cip"
> -KERNEL_DEFCONFIG ?= "${MACHINE}_defconfig"
> -
> -require recipes-kernel/linux/linux-custom.inc
> -require recipes-kernel/linux/cip-kernel-config.inc
> -
>   SRC_URI += " \
>       https://cdn.kernel.org/pub/linux/kernel/projects/cip/${KERNEL_MAJOR_MINOR}/linux-cip-${PV}.tar.xz \
> -    ${@'file://preempt-rt.cfg' if d.getVar('KERNEL_NAME') == 'cip-rt' else ''} \
>       "
>   
>   S = "${WORKDIR}/linux-cip-${PV}"
> diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb
> index 1d791669..8c32f39c 100644
> --- a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb
> @@ -9,6 +9,6 @@
>   # SPDX-License-Identifier: MIT
>   #
>   
> -require linux-cip-common.inc
> +require linux-cip-release.inc
>   
>   SRC_URI[sha256sum] = "ac71b31b34e89e7d6daf98a202806037e44203d5d79bc74da5c57f5c24ccf946"
> diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb
> index e5bfca91..8c88eb5e 100644
> --- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb
> @@ -9,6 +9,6 @@
>   # SPDX-License-Identifier: MIT
>   #
>   
> -require linux-cip-common.inc
> +require linux-cip-release.inc
>   
>   SRC_URI[sha256sum] = "70e223852d3a7f711dd511524243df512dcc7799010004b4d99e0acf1f95866a"
> diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb b/recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb
> index 5440ae62..8edf6e85 100644
> --- a/recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb
> @@ -9,6 +9,6 @@
>   # SPDX-License-Identifier: MIT
>   #
>   
> -require linux-cip-common.inc
> +require linux-cip-release.inc
>   
>   SRC_URI[sha256sum] = "e2d8fae539c6429e1680b9875b6b6c16792ee20a85d47b6f8c8227ef679c9886"
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.134-cip41-rt22.bb b/recipes-kernel/linux/linux-cip-rt_6.1.134-cip41-rt22.bb
> index eafe09b8..f4cc8d2a 100644
> --- a/recipes-kernel/linux/linux-cip-rt_6.1.134-cip41-rt22.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_6.1.134-cip41-rt22.bb
> @@ -5,6 +5,6 @@
>   #
>   # SPDX-License-Identifier: MIT
>   
> -require linux-cip-common.inc
> +require linux-cip-release.inc
>   
>   SRC_URI[sha256sum] = "8582da7b30925237cf4905988aefe0a8de23bb4e7546e6ebb998419ee121fa7e"
> diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip120.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip120.bb
> index 9bdf79c0..cbeef699 100644
> --- a/recipes-kernel/linux/linux-cip_4.19.325-cip120.bb
> +++ b/recipes-kernel/linux/linux-cip_4.19.325-cip120.bb
> @@ -9,6 +9,6 @@
>   # SPDX-License-Identifier: MIT
>   #
>   
> -require linux-cip-common.inc
> +require linux-cip-release.inc
>   
>   SRC_URI[sha256sum] = "9149d5ce9bd1a27ebb67358db8c81ef5c3e960c196007d501b731295ce8f7f69"
> diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip99.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip99.bb
> index 4eea2e79..bb307304 100644
> --- a/recipes-kernel/linux/linux-cip_4.4.302-cip99.bb
> +++ b/recipes-kernel/linux/linux-cip_4.4.302-cip99.bb
> @@ -9,6 +9,6 @@
>   # SPDX-License-Identifier: MIT
>   #
>   
> -require linux-cip-common.inc
> +require linux-cip-release.inc
>   
>   SRC_URI[sha256sum] = "ecc90814484dff84dae3f25ac2da7eb9156dc43c18acf2e806dc71ed4800b558"
> diff --git a/recipes-kernel/linux/linux-cip_5.10.237-cip60.bb b/recipes-kernel/linux/linux-cip_5.10.237-cip60.bb
> index 7cad5613..81e21268 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.237-cip60.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.237-cip60.bb
> @@ -9,6 +9,6 @@
>   # SPDX-License-Identifier: MIT
>   #
>   
> -require linux-cip-common.inc
> +require linux-cip-release.inc
>   
>   SRC_URI[sha256sum] = "be99dae17d2989965dc6dae2092067332f9965df0dcee8b7d517b823aac67990"
> diff --git a/recipes-kernel/linux/linux-cip_6.1.137-cip42.bb b/recipes-kernel/linux/linux-cip_6.1.137-cip42.bb
> index 124c205d..125fbe49 100644
> --- a/recipes-kernel/linux/linux-cip_6.1.137-cip42.bb
> +++ b/recipes-kernel/linux/linux-cip_6.1.137-cip42.bb
> @@ -5,6 +5,6 @@
>   #
>   # SPDX-License-Identifier: MIT
>   
> -require linux-cip-common.inc
> +require linux-cip-release.inc
>   
>   SRC_URI[sha256sum] = "05e279c5e955e96c85be7f8b19b3cd7aba109343d7837bbfa9b9a1b6362ecf2b"
> diff --git a/recipes-kernel/linux/linux-cip_6.12.29-cip1.bb b/recipes-kernel/linux/linux-cip_6.12.29-cip1.bb
> index 5b8fbdbc..40a3a702 100644
> --- a/recipes-kernel/linux/linux-cip_6.12.29-cip1.bb
> +++ b/recipes-kernel/linux/linux-cip_6.12.29-cip1.bb
> @@ -5,6 +5,6 @@
>   #
>   # SPDX-License-Identifier: MIT
>   
> -require linux-cip-common.inc
> +require linux-cip-release.inc
>   
>   SRC_URI[sha256sum] = "27bf5750e3ac4ed50b3cca0eb910e330eb3b24ec3d078af3d7d626123ba7b819"


