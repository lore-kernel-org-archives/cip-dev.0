Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB76C433EF
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 18:49:57 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.781.1637002195869336938
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 10:49:56 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AFInrCV004801
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Nov 2021 19:49:53 +0100
Received: from [167.87.32.59] ([167.87.32.59])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AFInrQj003376;
	Mon, 15 Nov 2021 19:49:53 +0100
Subject: Re: [isar-cip-core][PATCH 07/11] Create cip-core-image-kernelci
To: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>,
        cip-dev@lists.cip-project.org
References: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
 <20211115161724.19516-8-alice.ferrazzi@miraclelinux.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <04ad9f33-27ca-f6b5-27e5-a6c3fa805297@siemens.com>
Date: Mon, 15 Nov 2021 19:49:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211115161724.19516-8-alice.ferrazzi@miraclelinux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 18:49:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6921

On 15.11.21 17:17, Alice Ferrazzi wrote:
> Initialization of the cip-core-image-kernelci
> 
> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> ---
>  .gitlab-ci.yml                                |  3 ++
>  kas/opt/kernelci.yml                          | 16 +++++++++
>  .../images/cip-core-image-kernelci.bb         | 16 +++++++++
>  .../files/99-silent-printk.conf               |  1 +
>  .../kernelci-customizations/files/ethernet    | 23 +++++++++++++
>  .../kernelci-customizations/files/postinst    | 22 ++++++++++++
>  .../kernelci-customizations.bb                | 34 +++++++++++++++++++
>  scripts/deploy-kernelci.py                    | 13 +++----
>  8 files changed, 122 insertions(+), 6 deletions(-)
>  create mode 100644 kas/opt/kernelci.yml
>  create mode 100644 recipes-core/images/cip-core-image-kernelci.bb
>  create mode 100644 recipes-core/kernelci-customizations/files/99-silent-printk.conf
>  create mode 100644 recipes-core/kernelci-customizations/files/ethernet
>  create mode 100644 recipes-core/kernelci-customizations/files/postinst
>  create mode 100644 recipes-core/kernelci-customizations/kernelci-customizations.bb
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 9776754..7e9b31c 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -84,6 +84,7 @@ build:qemu-amd64-base-kernelci:
>      - .build_base
>    variables:
>      target: qemu-amd64
> +    extention: kernelci
>      use_rt: disable
>      wic_targz: disable
>      targz: enable
> @@ -105,6 +106,7 @@ build:qemu-arm64-base-kernelci:
>      - .build_base
>    variables:
>      target: qemu-arm64
> +    extention: kernelci
>      use_rt: disable
>      wic_targz: disable
>      targz: enable
> @@ -126,6 +128,7 @@ build:qemu-arm-base-kernelci:
>      - .build_base
>    variables:
>      target: qemu-arm
> +    extention: kernelci
>      use_rt: disable
>      wic_targz: disable
>      targz: enable
> diff --git a/kas/opt/kernelci.yml b/kas/opt/kernelci.yml
> new file mode 100644
> index 0000000..9c67864
> --- /dev/null
> +++ b/kas/opt/kernelci.yml
> @@ -0,0 +1,16 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation, 2020
> +# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> +#
> +# Authors:
> +#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
> +#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +header:
> +  version: 10
> +
> +target: cip-core-image-kernelci
> diff --git a/recipes-core/images/cip-core-image-kernelci.bb b/recipes-core/images/cip-core-image-kernelci.bb
> new file mode 100644
> index 0000000..479c14c
> --- /dev/null
> +++ b/recipes-core/images/cip-core-image-kernelci.bb
> @@ -0,0 +1,16 @@
> +#
> +# A reference image for KernelCI
> +#
> +# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> +#
> +# Authors:
> +#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit image
> +
> +DESCRIPTION = "CIP Core image for KernelCI"
> +
> +IMAGE_INSTALL += "kernelci-customizations"
> diff --git a/recipes-core/kernelci-customizations/files/99-silent-printk.conf b/recipes-core/kernelci-customizations/files/99-silent-printk.conf
> new file mode 100644
> index 0000000..ad24d3a
> --- /dev/null
> +++ b/recipes-core/kernelci-customizations/files/99-silent-printk.conf
> @@ -0,0 +1 @@
> +kernel.printk = 3 4 1 3
> diff --git a/recipes-core/kernelci-customizations/files/ethernet b/recipes-core/kernelci-customizations/files/ethernet
> new file mode 100644
> index 0000000..fa47d1a
> --- /dev/null
> +++ b/recipes-core/kernelci-customizations/files/ethernet
> @@ -0,0 +1,23 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2019
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +allow-hotplug eth0
> +allow-hotplug enp0s2
> +allow-hotplug enp2s0
> +
> +# used on BBB
> +iface eth0 inet dhcp
> +
> +# used on qemu-amd64
> +iface enp0s2 inet dhcp
> +
> +# used on simatic-ipc227e
> +iface enp2s0 inet dhcp
> diff --git a/recipes-core/kernelci-customizations/files/postinst b/recipes-core/kernelci-customizations/files/postinst
> new file mode 100644
> index 0000000..33faaeb
> --- /dev/null
> +++ b/recipes-core/kernelci-customizations/files/postinst
> @@ -0,0 +1,22 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2019
> +# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +echo "CIP Core Demo & Test Image" > /etc/issue
> +
> +echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
> +echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
> +
> +HOSTNAME=demo
> +echo "$HOSTNAME" > /etc/hostname
> +echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
> diff --git a/recipes-core/kernelci-customizations/kernelci-customizations.bb b/recipes-core/kernelci-customizations/kernelci-customizations.bb
> new file mode 100644
> index 0000000..15788a0
> --- /dev/null
> +++ b/recipes-core/kernelci-customizations/kernelci-customizations.bb
> @@ -0,0 +1,34 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2019
> +# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +
> +DESCRIPTION = "CIP Core image demo & customizations"
> +
> +SRC_URI = " \
> +    file://postinst \
> +    file://ethernet \
> +    file://99-silent-printk.conf"
> +
> +DEPENDS += "sshd-regen-keys"
> +
> +DEBIAN_DEPENDS = " \
> +    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys"
> +
> +do_install() {
> +	install -v -d ${D}/etc/network/interfaces.d
> +	install -v -m 644 ${WORKDIR}/ethernet ${D}/etc/network/interfaces.d/
> +
> +	install -v -d ${D}/etc/sysctl.d
> +	install -v -m 644 ${WORKDIR}/99-silent-printk.conf ${D}/etc/sysctl.d/
> +}
> diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
> index c234113..1df4e72 100755
> --- a/scripts/deploy-kernelci.py
> +++ b/scripts/deploy-kernelci.py
> @@ -19,14 +19,15 @@ extension=sys.argv[3]
>  if extension == "security":
>      rootfs_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+".tar.gz"
>      initrd_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img"
> -elif extension == "base":
> +    initrd_gz_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img.gz"
> +elif extension == "kernelci":
> +    rootfs_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+".tar.gz"
> +    initrd_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img"
> +    initrd_gz_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img.gz"
> +else:
> +    # base extension is not adding extension name in the filename
>      rootfs_filename="cip-core-image-cip-core-"+release+"-"+target+".tar.gz"
>      initrd_filename="cip-core-image-cip-core-"+release+"-"+target+"-initrd.img"

I didn't look at the complete file yet (too many steps) but I suspect it
can be shrunk by

 - using initrd.img.gz for all images
 - doing
    if extension:
        extension = extension + "-"
   and then using it unconditionally again

> -
> -# initrd is actually gz compressed
> -if extension == "security":
> -    initrd_gz_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img.gz"
> -elif extension == "base":
>      initrd_gz_filename="cip-core-image-cip-core-"+release+"-"+target+"-initrd.img.gz"
>  
>  input_dir="build/tmp/deploy/images/"+target
> 

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

