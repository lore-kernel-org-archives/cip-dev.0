Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23C1C433F5
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 18:43:11 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web12.697.1637001790072932825
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 10:43:10 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AFIh76l030764
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 19:43:07 +0100
Received: from [167.87.1.223] ([167.87.1.223])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AFIh63r030824;
	Mon, 15 Nov 2021 19:43:07 +0100
Subject: Re: [cip-dev][isar-cip-core][RFC 4/8] Create a initrd with support
 for dm-verity
To: Raphael Lisicki <raphael.lisicki@siemens.com>,
        cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
References: <20211112115017.401779-1-Quirin.Gylstorff@siemens.com>
 <20211112115017.401779-6-Quirin.Gylstorff@siemens.com>
 <39f049c6-510a-5ac4-6e73-8a865e95405e@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Message-ID: <883fcc26-08e6-f546-e094-6fa16329efb8@siemens.com>
Date: Mon, 15 Nov 2021 19:43:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <39f049c6-510a-5ac4-6e73-8a865e95405e@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by david.siemens.de id
 1AFIh76l030764
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 18:43:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6918

Hi,

On 11/15/21 5:58 PM, Raphael Lisicki wrote:
>=20
>=20
> On 12.11.21 12:50, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Adapt the initrd to open a dm-verity partition with a fixed
>> root hash.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> =C2=A0 .../cip-core-initramfs/cip-core-initramfs.bb=C2=A0 | 16 +++++
>> =C2=A0 .../files/verity.conf-hook=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 1 +
>> =C2=A0 .../initramfs-verity-hook/files/verity.hook=C2=A0=C2=A0 | 23 ++=
+++++
>> =C2=A0 .../initramfs-verity-hook/files/verity.script | 68 ++++++++++++=
+++++++
>> =C2=A0 .../initramfs-verity-hook_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 39 +++++++++++
>> =C2=A0 5 files changed, 147 insertions(+)
>> =C2=A0 create mode 100644=20
>> recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
>> =C2=A0 create mode 100644=20
>> recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook
>> =C2=A0 create mode 100644=20
>> recipes-initramfs/initramfs-verity-hook/files/verity.hook
>> =C2=A0 create mode 100644=20
>> recipes-initramfs/initramfs-verity-hook/files/verity.script
>> =C2=A0 create mode 100644=20
>> recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>>
>> diff --git=20
>> a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb=20
>> b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
>> new file mode 100644
>> index 0000000..825fb9f
>> --- /dev/null
>> +++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
>> @@ -0,0 +1,16 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2021
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +inherit initramfs
>> +
>> +INITRAMFS_INSTALL +=3D " \
>> +=C2=A0=C2=A0=C2=A0 initramfs-verity-hook \
>> +=C2=A0=C2=A0=C2=A0 "
>> diff --git=20
>> a/recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook=20
>> b/recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook
>> new file mode 100644
>> index 0000000..9b61fb8
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook
>> @@ -0,0 +1 @@
>> +BUSYBOX=3Dy
>> diff --git a/recipes-initramfs/initramfs-verity-hook/files/verity.hook=
=20
>> b/recipes-initramfs/initramfs-verity-hook/files/verity.hook
>> new file mode 100644
>> index 0000000..5eada8a
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-verity-hook/files/verity.hook
>> @@ -0,0 +1,23 @@
>> +#!/bin/sh
>> +PREREQ=3D""
>> +prereqs()
>> +{
>> +=C2=A0=C2=A0=C2=A0 echo "$PREREQ"
>> +}
>> +case $1 in
>> +prereqs)
>> +=C2=A0=C2=A0=C2=A0 prereqs
>> +=C2=A0=C2=A0=C2=A0 exit 0
>> +=C2=A0=C2=A0=C2=A0 ;;
>> +esac
>> +
>> +. /usr/share/initramfs-tools/hook-functions
>> +# Begin real processing below this line
>> +
>> +manual_add_modules dm_mod
>> +manual_add_modules dm_verity
>> +
>> +copy_exec /sbin/veritysetup
>> +copy_exec /sbin/dmsetup
>> +copy_file library /lib/cryptsetup/functions /lib/cryptsetup/functions
>> +copy_file library /usr/share/verity-env/verity.env=20
>> /usr/share/verity-env/verity.env
>> diff --git=20
>> a/recipes-initramfs/initramfs-verity-hook/files/verity.script=20
>> b/recipes-initramfs/initramfs-verity-hook/files/verity.script
>> new file mode 100644
>> index 0000000..a66b557
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-verity-hook/files/verity.script
>> @@ -0,0 +1,68 @@
>> +#!/bin/sh
>> +prereqs()
>> +{
>> +=C2=A0=C2=A0=C2=A0 # Make sure that this script is run last in local-=
top
>> +=C2=A0=C2=A0=C2=A0 local req
>> +=C2=A0=C2=A0=C2=A0 for req in "${0%/*}"/*; do
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 script=3D"${req##*/}"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$script" !=3D "${0##=
*/}" ] && [ "$script" !=3D "cryptroot"=20
>> ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
intf '%s\n' "$script"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0 done
>> +}
>> +case $1 in
>> +prereqs)
>> +=C2=A0=C2=A0=C2=A0 prereqs
>> +=C2=A0=C2=A0=C2=A0 exit 0
>> +=C2=A0=C2=A0=C2=A0 ;;
>> +esac
>> +
>> +. /scripts/functions
>> +. /lib/cryptsetup/functions
>> +. /usr/share/verity-env/verity.env
>> +# Even if this script fails horribly, make sure there won't be a=20
>> chance the
>> +# current $ROOT will be attempted.=C2=A0 As this device most likely=20
>> contains a
>> +# perfectly valid filesystem, it would be mounted successfully,=20
>> leading to a
>> +# broken trust chain.
>> +echo "ROOT=3D/dev/null" >/conf/param.conf
>> +wait_for_udev 10
>> +case "$ROOT" in
>> +=C2=A0=C2=A0=C2=A0 PART*)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # root was given as PARTUU=
ID=3D or PARTLABEL=3D. Use blkid to=20
>> find the matching
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # partition
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ROOT=3D$(blkid --list-one =
--output device --match-token "$ROOT")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>> +=C2=A0=C2=A0=C2=A0 "")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # No Root device was given=
. Use veritysetup verify to search=20
>> matching roots
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 partitions=3D$(blkid -o de=
vice)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for part in $partitions; d=
o
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 [ "$(blkid -p ${part} --match-types novfat -s USAGE -o=20
>> value)" =3D "filesystem" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if veritysetup verify \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "$part" "$part" "${ROOT_HASH}" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --hash-offset "${HASH_OFFSET}";th=
en
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ROOT=3D"$part"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>> +esac
>> +set -- "$ROOT" verityroot
>> +if ! veritysetup open \
>> +=C2=A0=C2=A0=C2=A0=C2=A0 --restart-on-corruption \
>=20
> Would be great if this was configurable for test-builds, which might=20
> need to be modified.
>=20

No problem - I will make this configurable during build time in v2.

Quirin
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0 --data-block-size "${DATA_BLOCK_SIZE}" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0 --hash-block-size "${HASH_BLOCK_SIZE}" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0 --data-blocks "${DATA_BLOCKS}" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0 --hash-offset "${HASH_OFFSET}" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0 --salt "${SALT}" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0 "$1" "$2" "$1" "${ROOT_HASH}"; then
>> +=C2=A0=C2=A0=C2=A0 panic "Can't open verity rootfs!"
>> +fi
>> +
>> +wait_for_udev 10
>> +
>> +if ! ROOT=3D"$(dm_blkdevname verityroot)"; then
>> +=C2=A0=C2=A0=C2=A0 panic "Can't find the verity root device!"
>> +fi
>> +
>> +echo "ROOT=3D${ROOT}" >/conf/param.conf
>> diff --git=20
>> a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb=
=20
>> b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>> new file mode 100644
>> index 0000000..e067a22
>> --- /dev/null
>> +++=20
>> b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>> @@ -0,0 +1,39 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2021
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +inherit dpkg-raw
>> +
>> +SRC_URI +=3D " \
>> +=C2=A0=C2=A0=C2=A0 file://verity.conf-hook \
>> +=C2=A0=C2=A0=C2=A0 file://verity.hook \
>> +=C2=A0=C2=A0=C2=A0 file://verity.script \
>> +=C2=A0=C2=A0=C2=A0 "
>> +
>> +DEBIAN_DEPENDS =3D "initramfs-tools, cryptsetup"
>> +
>> +VERITY_IMAGE_RECIPE ?=3D "cip-core-image-read-only"
>> +VERITY_ENV_FILE =3D=20
>> "${DEPLOY_DIR_IMAGE}/${VERITY_IMAGE_RECIPE}-${DISTRO}-${MACHINE}.verit=
y.${VERITY_IMAGE_TYPE}.env"=20
>>
>> +do_install[depends] +=3D "${VERITY_IMAGE_RECIPE}:do_verity_image"
>> +do_install[cleandirs] +=3D " \
>> +=C2=A0=C2=A0=C2=A0 ${D}/usr/share/initramfs-tools/hooks \
>> +=C2=A0=C2=A0=C2=A0 ${D}/usr/share/verity-env \
>> +=C2=A0=C2=A0=C2=A0 ${D}/usr/share/initramfs-tools/scripts/local-top \
>> +=C2=A0=C2=A0=C2=A0 ${D}/usr/share/initramfs-tools/conf-hooks.d"
>> +do_install() {
>> +=C2=A0=C2=A0=C2=A0 # Insert the veritysetup commandline into the scri=
pt
>> +=C2=A0=C2=A0=C2=A0 if [ -f "${VERITY_ENV_FILE}" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -m 0600 "${VERITY_=
ENV_FILE}"=20
>> "${D}/usr/share/verity-env/verity.env"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -m 0755 "${WORKDIR=
}/verity.script" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "$=
{D}/usr/share/initramfs-tools/scripts/local-top/verity"
>> +=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0 install -m 0755 "${WORKDIR}/verity.hook" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "${D}/usr/share/initramfs-=
tools/hooks/verity"
>> +}
>>






