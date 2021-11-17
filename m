Return-Path: <christian.storm@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77966C433EF
	for <webhook@archiver.kernel.org>; Wed, 17 Nov 2021 12:31:45 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web08.6463.1637152304022426692
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Nov 2021 04:31:44 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: christian.storm@siemens.com)
Received: from mail1.siemens.de (mail1.siemens.de [139.23.33.14])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AHCVgup019669
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 13:31:42 +0100
Received: from localhost ([139.22.32.60])
	by mail1.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AHCVfRL009744
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 13:31:41 +0100
Date: Wed, 17 Nov 2021 13:33:47 +0100
From: Christian Storm <christian.storm@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev][isar-cip-core]RFC v2 4/9] Create a initrd with support
 for dm-verity
Message-ID: <20211117123347.x6ficeg2bksjujz6@MD1ZFJVC.ad001.siemens.net>
Mail-Followup-To: cip-dev@lists.cip-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20211116112752.1521211-5-Quirin.Gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by david.siemens.de id
 1AHCVgup019669
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 12:31:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6946


> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> Adapt the initrd to open a dm-verity partition with a fixed
> root hash.
>=20
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../cip-core-initramfs/cip-core-initramfs.bb  | 16 +++++
>  .../files/verity.conf-hook                    |  1 +
>  .../initramfs-verity-hook/files/verity.hook   | 23 +++++++
>  .../files/verity.script.tmpl                  | 68 +++++++++++++++++++
>  .../initramfs-verity-hook_0.1.bb              | 51 ++++++++++++++
>  5 files changed, 159 insertions(+)
>  create mode 100644 recipes-initramfs/cip-core-initramfs/cip-core-initr=
amfs.bb
>  create mode 100644 recipes-initramfs/initramfs-verity-hook/files/verit=
y.conf-hook
>  create mode 100644 recipes-initramfs/initramfs-verity-hook/files/verit=
y.hook
>  create mode 100644 recipes-initramfs/initramfs-verity-hook/files/verit=
y.script.tmpl
>  create mode 100644 recipes-initramfs/initramfs-verity-hook/initramfs-v=
erity-hook_0.1.bb
>=20
> diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb=
 b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> new file mode 100644
> index 0000000..825fb9f
> --- /dev/null
> +++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> @@ -0,0 +1,16 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2021
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit initramfs
> +
> +INITRAMFS_INSTALL +=3D " \
> +    initramfs-verity-hook \
> +    "
> diff --git a/recipes-initramfs/initramfs-verity-hook/files/verity.conf-=
hook b/recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook
> new file mode 100644
> index 0000000..9b61fb8
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook
> @@ -0,0 +1 @@
> +BUSYBOX=3Dy
> diff --git a/recipes-initramfs/initramfs-verity-hook/files/verity.hook =
b/recipes-initramfs/initramfs-verity-hook/files/verity.hook
> new file mode 100644
> index 0000000..5eada8a
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-verity-hook/files/verity.hook
> @@ -0,0 +1,23 @@
> +#!/bin/sh
> +PREREQ=3D""
> +prereqs()
> +{
> +    echo "$PREREQ"
> +}
> +case $1 in
> +prereqs)
> +    prereqs
> +    exit 0
> +    ;;
> +esac
> +
> +. /usr/share/initramfs-tools/hook-functions
> +# Begin real processing below this line
> +
> +manual_add_modules dm_mod
> +manual_add_modules dm_verity
> +
> +copy_exec /sbin/veritysetup
> +copy_exec /sbin/dmsetup
> +copy_file library /lib/cryptsetup/functions /lib/cryptsetup/functions
> +copy_file library /usr/share/verity-env/verity.env /usr/share/verity-e=
nv/verity.env
> diff --git a/recipes-initramfs/initramfs-verity-hook/files/verity.scrip=
t.tmpl b/recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl
> new file mode 100644
> index 0000000..c4f3dc4
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-verity-hook/files/verity.script.tmpl
> @@ -0,0 +1,68 @@
> +#!/bin/sh
> +prereqs()
> +{
> +    # Make sure that this script is run last in local-top
> +    local req
> +    for req in "${0%/*}"/*; do
> +        script=3D"${req##*/}"
> +        if [ "$script" !=3D "${0##*/}" ] && [ "$script" !=3D "cryptroo=
t" ]; then

Hm, so you explicitly enumerate all scripts except for cryptroot so that
you run (hopefully right?) thereafter.
Isn't it sufficient to make cryptroot dependent on this?
Looks too verbose and complicated...


> +            printf '%s\n' "$script"
> +        fi
> +    done
> +}
> +case $1 in
> +prereqs)
> +    prereqs
> +    exit 0
> +    ;;
> +esac
> +
> +. /scripts/functions
> +. /lib/cryptsetup/functions
> +. /usr/share/verity-env/verity.env
> +# Even if this script fails horribly, make sure there won't be a chanc=
e the
> +# current $ROOT will be attempted.  As this device most likely contain=
s a
> +# perfectly valid filesystem, it would be mounted successfully, leadin=
g to a
> +# broken trust chain.
> +echo "ROOT=3D/dev/null" >/conf/param.conf
> +wait_for_udev 10

Why this hard timeout? Shouldn't this be configurable so to match to
different setups of hardware?


> +case "$ROOT" in
> +    PART*)
> +        # root was given as PARTUUID=3D or PARTLABEL=3D. Use blkid to =
find the matching
> +        # partition
> +        ROOT=3D$(blkid --list-one --output device --match-token "$ROOT=
")
> +        ;;
> +    "")
> +        # No Root device was given. Use veritysetup verify to search m=
atching roots
> +        partitions=3D$(blkid -o device)
> +        for part in $partitions; do
> +            if [ "$(blkid -p ${part} --match-types novfat -s USAGE -o =
value)" =3D "filesystem" ]; then
> +                if veritysetup verify \
> +                   "$part" "$part" "${ROOT_HASH}" \
> +                   --hash-offset "${HASH_OFFSET}";then
> +                    ROOT=3D"$part"
> +                    break
> +                fi
> +            fi
> +        done
> +        ;;
> +esac
> +set -- "$ROOT" verityroot
> +if ! veritysetup open \
> +     ${VERITY_BEHAVIOR_ON_CORRUPTION} \
> +     --data-block-size "${DATA_BLOCK_SIZE}" \
> +     --hash-block-size "${HASH_BLOCK_SIZE}" \
> +     --data-blocks "${DATA_BLOCKS}" \
> +     --hash-offset "${HASH_OFFSET}" \
> +     --salt "${SALT}" \
> +     "$1" "$2" "$1" "${ROOT_HASH}"; then
> +    panic "Can't open verity rootfs!"

The above comment's gist may also help here in case you run into this
output on a machine.


> +fi
> +
> +wait_for_udev 10

Same as above.


> +
> +if ! ROOT=3D"$(dm_blkdevname verityroot)"; then
> +    panic "Can't find the verity root device!"
> +fi
> +
> +echo "ROOT=3D${ROOT}" >/conf/param.conf
> diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-h=
ook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hoo=
k_0.1.bb
> new file mode 100644
> index 0000000..a7fbf5a
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1=
.bb
> @@ -0,0 +1,51 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2021
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +
> +SRC_URI +=3D " \
> +    file://verity.conf-hook \
> +    file://verity.hook \
> +    file://verity.script.tmpl \
> +    "
> +
> +VERITY_BEHAVIOR_ON_CORRUPTION ?=3D "--restart-on-corruption"
> +
> +TEMPLATE_FILES =3D "verity.script.tmpl"
> +TEMPLATE_VARS +=3D "VERITY_BEHAVIOR_ON_CORRUPTION"
> +
> +DEBIAN_DEPENDS =3D "initramfs-tools, cryptsetup"
> +
> +VERITY_IMAGE_RECIPE ?=3D "cip-core-image-read-only"
> +
> +VERITY_ENV_FILE =3D "${DEPLOY_DIR_IMAGE}/${VERITY_IMAGE_RECIPE}-${DIST=
RO}-${MACHINE}.verity.env"
> +
> +do_install[depends] +=3D "${VERITY_IMAGE_RECIPE}:do_verity_image"
> +do_install[cleandirs] +=3D " \
> +    ${D}/usr/share/initramfs-tools/hooks \
> +    ${D}/usr/share/verity-env \
> +    ${D}/usr/share/initramfs-tools/scripts/local-top \
> +    ${D}/usr/share/initramfs-tools/conf-hooks.d"
> +
> +do_install() {
> +    # Insert the veritysetup commandline into the script
> +    if [ -f "${VERITY_ENV_FILE}" ]; then
> +        install -m 0600 "${VERITY_ENV_FILE}" "${D}/usr/share/verity-en=
v/verity.env"
> +    else
> +        bberror "Did not find ${VERITY_ENV_FILE}. initramfs will not b=
e build correctly!"
> +    fi
> +    install -m 0755 "${WORKDIR}/verity.script" \
> +        "${D}/usr/share/initramfs-tools/scripts/local-top/verity"
> +    install -m 0755 "${WORKDIR}/verity.hook" \
> +        "${D}/usr/share/initramfs-tools/hooks/verity"
> +}
> +
> +addtask do_install after do_transform_template
> --=20
> 2.30.2
>=20



Kind regards,
   Christian

--=20
Dr. Christian Storm
Siemens AG, Technology, T RDA IOT SES-DE
Otto-Hahn-Ring 6, 81739 M=FCnchen, Germany

