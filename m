Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583C4C3527E
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:06 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web12.21304.1650547100926865194
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Apr 2022 06:18:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=quirin.gylstorff@siemens.com header.s=fm1
 header.b=a+pRQ9oo;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226,
 mailfrom: fm-51332-202204211318176accb2305debe749ed-dha0gn@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202204211318176accb2305debe749ed
        for <cip-dev@lists.cip-project.org>;
        Thu, 21 Apr 2022 15:18:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=quirin.gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=g8AYsjwo3J13w1FLyGpk7y8XHYJfn8iSrQ9XcxYzbxE=;
 b=a+pRQ9ooGWaDxhF18OMk3TNn12Yizm48m3EqdXms3NYk44aQEnCdjM5nOp5jLdY+4kUrYT
 q0eFY5OsIPzVkP2BaMh31pb0OXSSYxWAKE3lnqoUg8i+yFxragO8x+4Upp2jfyZMaBXrIX4D
 sMh9UZbVwghWW/tX3Z/YRfHip0b68=;
Message-ID: <28c26f61-2ae8-df3a-004f-21ea842439a7@siemens.com>
Date: Thu, 21 Apr 2022 15:18:15 +0200
MIME-Version: 1.0
Subject: Re: [isar-cip-core][PATCH 3/3] Convert /etc overlay from systemd
 mount unit to initramfs hook
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>
References: <cover.1650541963.git.jan.kiszka@siemens.com>
 <6700d82b66bcf4939e729a01b612353b458919b0.1650541963.git.jan.kiszka@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: 
 <6700d82b66bcf4939e729a01b612353b458919b0.1650541963.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8169



On 4/21/22 13:52, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> As systemd is not well prepared for read-only rootfs, specifically /wrt
> machine-id management and anything that depends on it, it's best to
> mount the /etc overlay already in the initramfs. This implies that also
> /var is mounted at that level. We still keep the fstab setup done by
> wic-swu-img class so that systemd will recognize the rootfs as read-only
> and not try to remount it rw which will only fail with underlying
> squashfs.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   classes/wic-swu-img.bbclass                   |  2 --
>   .../etc-overlay-fs/etc-overlay-fs_0.1.bb      | 32 -------------------
>   .../etc-overlay-fs/files/etc-hostname.service | 14 --------
>   .../files/etc-sshd-regen-keys.conf            |  6 ----
>   .../etc-overlay-fs/files/etc-sysusers.conf    |  4 ---
>   recipes-core/etc-overlay-fs/files/etc.mount   | 13 --------
>   recipes-core/etc-overlay-fs/files/postinst    |  4 ---
>   .../cip-core-initramfs/cip-core-initramfs.bb  |  4 +++
>   .../files/etc-overlay.script                  | 24 ++++++++++++++
>   .../initramfs-etc-overlay-hook_0.1.bb         | 27 ++++++++++++++++
>   10 files changed, 55 insertions(+), 75 deletions(-)
>   delete mode 100644 recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
>   delete mode 100644 recipes-core/etc-overlay-fs/files/etc-hostname.service
>   delete mode 100644 recipes-core/etc-overlay-fs/files/etc-sshd-regen-keys.conf
>   delete mode 100644 recipes-core/etc-overlay-fs/files/etc-sysusers.conf
>   delete mode 100644 recipes-core/etc-overlay-fs/files/etc.mount
>   delete mode 100755 recipes-core/etc-overlay-fs/files/postinst
>   create mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
>   create mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
> 
> diff --git a/classes/wic-swu-img.bbclass b/classes/wic-swu-img.bbclass
> index b93a96a..41b2164 100644
> --- a/classes/wic-swu-img.bbclass
> +++ b/classes/wic-swu-img.bbclass
> @@ -15,8 +15,6 @@ inherit squashfs-img
>   inherit wic-img
>   inherit swupdate-img
>   
> -IMAGE_INSTALL += "etc-overlay-fs"
> -
>   INITRAMFS_RECIPE ?= "cip-core-initramfs"
>   INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
>   
> diff --git a/recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb b/recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
> deleted file mode 100644
> index 4e2b80b..0000000
> --- a/recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2021
> -#
> -# Authors:
> -#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -
> -inherit dpkg-raw
> -
> -SRC_URI = "file://postinst \
> -           file://etc.mount \
> -           file://etc-hostname.service \
> -           file://etc-sshd-regen-keys.conf \
> -           file://etc-sysusers.conf"
> -
> -do_install[cleandirs]+="${D}/usr/lib/systemd/system \
> -                        ${D}/usr/lib/systemd/system/local-fs.target.wants \
> -                        ${D}/usr/lib/systemd/system/systemd-sysusers.service.d \
> -                        ${D}/usr/lib/systemd/system/sshd-regen-keys.service.d \
> -                        ${D}/var/local/etc \
> -                        ${D}/var/local/.atomic \
> -                        "
> -do_install() {
> -    TARGET=${D}/usr/lib/systemd/system
> -    install -m 0644 ${WORKDIR}/etc.mount ${TARGET}/etc.mount
> -    install -m 0644 ${WORKDIR}/etc-hostname.service ${TARGET}/etc-hostname.service
> -    install -m 0644 ${WORKDIR}/etc-sshd-regen-keys.conf ${D}/usr/lib/systemd/system/sshd-regen-keys.service.d/etc-sshd-regen-keys.conf
> -    install -m 0644 ${WORKDIR}/etc-sysusers.conf ${D}/usr/lib/systemd/system/systemd-sysusers.service.d/etc-sysusers.service
> -}
> diff --git a/recipes-core/etc-overlay-fs/files/etc-hostname.service b/recipes-core/etc-overlay-fs/files/etc-hostname.service
> deleted file mode 100644
> index 2306b9f..0000000
> --- a/recipes-core/etc-overlay-fs/files/etc-hostname.service
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -[Unit]
> -Description=set hostname /etc overlay-aware
> -Before=network-pre.target
> -Wants=network-pre.target
> -Requires=etc.mount
> -After=etc.mount
> -
> -[Service]
> -Type=oneshot
> -RemainAfterExit=yes
> -ExecStart=/bin/hostname --boot --file /etc/hostname
> -
> -[Install]
> -WantedBy=basic.target
> diff --git a/recipes-core/etc-overlay-fs/files/etc-sshd-regen-keys.conf b/recipes-core/etc-overlay-fs/files/etc-sshd-regen-keys.conf
> deleted file mode 100644
> index b386c12..0000000
> --- a/recipes-core/etc-overlay-fs/files/etc-sshd-regen-keys.conf
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -[Unit]
> -# set hostname /etc overlay-aware
> -Before=network-pre.target
> -Wants=network-pre.target
> -Requires=etc.mount
> -After=etc.mount
> diff --git a/recipes-core/etc-overlay-fs/files/etc-sysusers.conf b/recipes-core/etc-overlay-fs/files/etc-sysusers.conf
> deleted file mode 100644
> index ad45d7f..0000000
> --- a/recipes-core/etc-overlay-fs/files/etc-sysusers.conf
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -[Unit]
> -# make systemd-sysusers /etc overlay aware
> -Requires=etc.mount
> -After=etc.mount
> diff --git a/recipes-core/etc-overlay-fs/files/etc.mount b/recipes-core/etc-overlay-fs/files/etc.mount
> deleted file mode 100644
> index f0ae3c5..0000000
> --- a/recipes-core/etc-overlay-fs/files/etc.mount
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -[Unit]
> -Description=Overlay-mount /etc
> -Requires=var.mount
> -After=var.mount
> -
> -[Mount]
> -What=overlay
> -Where=/etc
> -Type=overlay
> -Options=noauto,x-systemd.automount,lowerdir=/etc,upperdir=/var/local/etc,workdir=/var/local/.atomic
> -
> -[Install]
> -WantedBy=local-fs.target
> diff --git a/recipes-core/etc-overlay-fs/files/postinst b/recipes-core/etc-overlay-fs/files/postinst
> deleted file mode 100755
> index e436b53..0000000
> --- a/recipes-core/etc-overlay-fs/files/postinst
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -#!/bin/sh
> -
> -deb-systemd-helper enable etc.mount  || true
> -deb-systemd-helper enable etc-hostname.service || true
> diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> index 649daa2..9e0ee26 100644
> --- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> +++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> @@ -10,3 +10,7 @@
>   #
>   
>   inherit initramfs
> +
> +INITRAMFS_INSTALL += " \
> +    initramfs-etc-overlay-hook \
> +    "
> diff --git a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script b/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
> new file mode 100644
> index 0000000..08271cd
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +
> +PREREQ=""
> +
> +prereqs()
> +{
> +	echo "$PREREQ"
> +}
> +
> +case $1 in
> +# get pre-requisites
> +prereqs)
> +	prereqs
> +	exit 0
> +	;;
> +esac
> +
> +. /scripts/functions
> + > +mount -t $(get_fstype /dev/disk/by-label/var) /dev/disk/by-label/var 
${rootmnt}/var

should there be a check for existence for /dev/disk/by-label/var?

> +
> +mkdir -p ${rootmnt}/var/local/etc
> +mkdir -p ${rootmnt}/var/local/.atomic
> +mount -t overlay -o lowerdir=${rootmnt}/etc,upperdir=${rootmnt}/var/local/etc,workdir=${rootmnt}/var/local/.atomic overlay ${rootmnt}/etc
> diff --git a/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
> new file mode 100644
> index 0000000..19e9261
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
> @@ -0,0 +1,27 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +
> +SRC_URI += " \
> +    file://etc-overlay.script \
> +    "
> +
> +DEBIAN_DEPENDS = "initramfs-tools"
> +
> +do_install[cleandirs] += " \
> +    ${D}/usr/share/initramfs-tools/hooks \
> +    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
> +
> +do_install() {
> +    install -m 0755 "${WORKDIR}/etc-overlay.script" \
> +        "${D}/usr/share/initramfs-tools/scripts/local-bottom/etc-overlay"
> +}

Quirin

