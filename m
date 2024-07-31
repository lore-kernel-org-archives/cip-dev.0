Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BB9C3DA7F
	for <webhook@archiver.kernel.org>; Wed, 31 Jul 2024 18:02:40 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by mx.groups.io with SMTP id smtpd.web10.48044.1722445289711290873
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jul 2024 10:01:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=jan.kiszka@web.de header.s=s29768273 header.b=Mi/UWqn3;
 spf=pass (domain: web.de, ip: 212.227.15.4, mailfrom: jan.kiszka@web.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722445287; x=1723050087; i=jan.kiszka@web.de;
	bh=kn5F2x8C6/UAEzXBWuYkV+ZRa6OdfCiGUXD4PJ9EESU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Mi/UWqn3Q1F+fL2XSvqkLZkUUSU/ZQX9GGlGVNXS11Zdh7qtaYw9LpdQJOeTWeip
	 sCGW9ioTksFqbWxaYUEM+rQax9/E+H0oGIbGrQuZZF3LhomF1kc9K3BqpahUUub2O
	 DuxGrSPbjFDBWqfM4cSHgXF0FI6w0K9wSywgFBD7sf7pyQNq1h7WbVa/sfTBvOMKv
	 1TraTjIr0o1VRvXnkUKpOXoksuOTUL0nG3UDbRPvQjkOGohMx2KLIE8kKUEgNSB1v
	 QcizYTRTOibyiF/LT7FCaMBn/QOTrokBB8hQg63PprZVUmVNPxKfFLgTldcgX9UHR
	 1vvA+Rp4NdPsUhXxTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.31] ([82.83.168.54]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyO0u-1sKydv22ai-00uYdB; Wed, 31
 Jul 2024 19:01:27 +0200
Message-ID: <50add61f-23b5-4feb-9187-acc48049f12e@web.de>
Date: Wed, 31 Jul 2024 19:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v5] initramfs-overlay-hook: Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
To: Clara Kowalsky <clara.kowalsky@siemens.com>, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20240723125925.1253022-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@web.de>
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <20240723125925.1253022-1-clara.kowalsky@siemens.com>
X-Provags-ID: V03:K1:mC4q7zz3F/Nz4AjPBOfwLInJil+DLrEZYKoVOs6ffIHljBSSGGr
 gKzf2Sb3xKBFcam/dhidAUSc/jh9MD3qwNqZJrK5x0lOKnObEcb+ElW5yBo94G8qG0UZlPC
 3os+YjtQt/yVnak15L3/ROUARaO6HSi7UUN2jo8myoJj4NHSKG7NFHHs5WdGfHDv97HD2o2
 9XEsGwL8TN/tA3sk9gr+w==
UI-OutboundReport: notjunk:1;M01:P0:F1qap0ZnWGw=;g0sQe8bBfNuM8Zt2LkSmH9ujYDZ
 liQSuGU60YdD3DGSHx2HtsHplGyS0BIMfaxxfc6DKRUrJdjb7DrXGnMbNUS5BfZ9q1dZDMVv/
 MGIxxj7gm918mjUs8Y7JsaA23HNyFwb2heRA5+HpxFTx1LeQLsBENijwAqWA1qs/mZJVLEHkL
 isskFa4IMAaqB7FxZCRTWdFtKlbG9HXQSgzeVTayaeccICrO3+gkvk6V2fp3eaimgoVAGIqsv
 W/fbDC6Juc0Ihne/7AmL/rStGH1FnRoxpzevhrdEmFEXaSQqG3ysZkoIZ+Fso/lbogym1AgOt
 Bq+GpiXP1ZVIYMeGeOh2jOqu80BD68ZOXj+OUu9ZFe9/8HNN/H0PVzwIMAYjwMegP+N0ySN0b
 TTz2LBMm2c0eHZ1JjsWWy/i7qhkt76Vd7qr7ZIfRAec9H6YuFdC8ytzuwSX4WZIiEy5+Z7Dfu
 +5DmrLvumnX4iD5fZWN2axPT8YAaDk5ywL5EUsUcrDzopdPokZ998t4WGrtImg6o/DaSdjDFL
 0FKFxQNKuaTq2SeYo/mBRG69dM8paXEicrhvHQ+IwbQCZtTxckVOuq+Vyf71gelc5XhxYydxm
 0M/0NhJ0hqirTkNLbYgftPHAzW6fHyz7NuZMgSPgL2pKUz6R6tnDGNLUafDD+zJO5u1FvDpXn
 zdb0yk9tfxKxja2hZ/6LKAtM0XpcWzbu5cg/+gf7f2gGfdyZadyYhOoWqGxub43oJW04qMxI2
 KwxrOjow+q/xu2sFzqI5SJGo1nmd1m57azXqT8mRkj3o88D/tJ/NECQy4o7dLFKcDl+mC4v8p
 B4TQOG0qNkAolyW5MmBNfcWA==
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jul 2024 18:02:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16698

On 23.07.24 14:59, Clara Kowalsky wrote:
> In case of ext*, this detects and fixes file system errors in the
> partition device before doing the partition mount.
> If the partition turns out to be broken, the factory state is recovered.
>
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  .../initramfs-overlay-hook/files/overlay.hook      | 11 +++++++++--
>  .../files/overlay.script.tmpl                      | 11 ++++++++++-
>  .../files/overlay_recovery_action.script           | 14 ++++++++++++++
>  .../initramfs-overlay-hook_0.1.bb                  |  8 +++++++-
>  4 files changed, 40 insertions(+), 4 deletions(-)
>  create mode 100644 recipes-initramfs/initramfs-overlay-hook/files/overl=
ay_recovery_action.script
>
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook=
 b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> index 8b00ecf..6f634c5 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> @@ -22,6 +22,13 @@ esac
>
>  . /usr/share/initramfs-tools/hook-functions
>
> +hook_error() {
> +    echo "(ERROR): $1" >&2
> +    exit 1
> +}
> +
>  manual_add_modules overlay
> -copy_exec /usr/bin/mountpoint
> -copy_exec /usr/bin/awk
> +copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not fo=
und"
> +copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
> +copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
> +copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"

Is there no "copy_exec_and_complain+fail_if_missing"? This pattern looks
like it does not scale very well across all our scripts (including isar
upstream).

> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.scri=
pt.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tm=
pl
> index 42eb59c..c6f69b9 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> @@ -31,12 +31,21 @@ ovl_partition_device=3D"${INITRAMFS_OVERLAY_STORAGE_=
DEVICE}"
>  ovl_storage_path=3D"${INITRAMFS_OVERLAY_STORAGE_PATH}"
>  ovl_lower_dirs=3D"${INITRAMFS_OVERLAY_PATHS}"
>  ovl_mount_option=3D"${INITRAMFS_OVERLAY_MOUNT_OPTION}"
> +ovl_recovery_script=3D"/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
>
>  root_mount_storage=3D${rootmnt}${ovl_storage_path}
>  storage_mount_point=3D"$(echo "${ovl_storage_path}" | awk -F/ '{print F=
S$2}' )"
> +partition_fstype=3D$(get_fstype "${ovl_partition_device}")
>
>  if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
> -	if ! mount -t $(get_fstype ${ovl_partition_device}) \
> +	case $partition_fstype in
> +	ext*)
> +		if ! e2fsck -p -f "$ovl_partition_device" && [ -f "$ovl_recovery_scri=
pt" ] && [ -x "$ovl_recovery_script" ]; then

Why testing both -f and -x?

> +			"$ovl_recovery_script" "$partition_fstype" "$ovl_partition_device"
> +		fi
> +		;;
> +	esac
> +	if ! mount -t ${partition_fstype} \
>  		 -o ${ovl_mount_option} \
>  		 ${ovl_partition_device} \
>  		 ${rootmnt}${storage_mount_point}; then
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay_reco=
very_action.script b/recipes-initramfs/initramfs-overlay-hook/files/overla=
y_recovery_action.script
> new file mode 100644
> index 0000000..d13111d
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_ac=
tion.script
> @@ -0,0 +1,14 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +
> +partition_fstype=3D"$1"
> +ovl_partition_device=3D"$2"
> +
> +mke2fs -t "$partition_fstype" "$ovl_partition_device"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-=
hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-h=
ook_0.1.bb
> index 955748f..7097130 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.=
1.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.=
1.bb
> @@ -12,9 +12,12 @@
>
>  inherit dpkg-raw
>
> +INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??=3D "overlay_recovery_action.script=
"
> +
>  SRC_URI +=3D " \
>      file://overlay.hook \
>      file://overlay.script.tmpl \
> +    file://${INITRAMFS_OVERLAY_RECOVERY_SCRIPT} \
>      "
>
>  # The variable INITRAMFS_OVERLAY_PATHS contains the directories which a=
re
> @@ -35,7 +38,8 @@ TEMPLATE_FILES =3D "overlay.script.tmpl"
>  TEMPLATE_VARS +=3D " INITRAMFS_OVERLAY_STORAGE_PATH \
>      INITRAMFS_OVERLAY_PATHS \
>      INITRAMFS_OVERLAY_STORAGE_DEVICE \
> -    INITRAMFS_OVERLAY_MOUNT_OPTION"
> +    INITRAMFS_OVERLAY_MOUNT_OPTION \
> +    INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
>
>  DEBIAN_DEPENDS =3D "initramfs-tools, awk, coreutils, util-linux"
>
> @@ -48,4 +52,6 @@ do_install() {
>          "${D}/usr/share/initramfs-tools/hooks/overlay"
>      install -m 0755 "${WORKDIR}/overlay.script" \
>          "${D}/usr/share/initramfs-tools/scripts/local-bottom/overlay"
> +    install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
> +        "${D}/usr/share/initramfs-tools/scripts"
>  }

Looks good otherwise.

Jan


