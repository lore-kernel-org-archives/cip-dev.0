Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF97C433EF
	for <webhook@archiver.kernel.org>; Fri, 19 Nov 2021 06:41:44 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web08.5265.1637304102893645640
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Nov 2021 22:41:43 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AJ6fdkL004105
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 19 Nov 2021 07:41:40 +0100
Received: from [139.22.32.112] ([139.22.32.112])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AJ6fdhs027074;
	Fri, 19 Nov 2021 07:41:39 +0100
Subject: Re: [cip-dev][isar-cip-core]RFC v2 5/9] Create an read-only rootfs
 with dm-verity
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org
References: <20211117121815.efuw3n7pyehisw75@MD1ZFJVC.ad001.siemens.net>
 <18128c5f-d4ea-7f8f-e1a3-77390afa6a86@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <993de67e-5d48-4375-163b-3736f63a0526@siemens.com>
Date: Fri, 19 Nov 2021 07:41:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <18128c5f-d4ea-7f8f-e1a3-77390afa6a86@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by goliath.siemens.de id
 1AJ6fdkL004105
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Nov 2021 06:41:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6956

On 18.11.21 19:10, Gylstorff Quirin wrote:
>=20
>=20
> On 11/17/21 1:18 PM, Christian Storm via lists.cip-project.org wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This root file system supports SWUpdate and secure boot.
>>> We need a writable /tmp and /var for a boot without error messages.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +-
>>> =C2=A0 classes/secure-swupdate-img.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 32 +++++++++++++++++++
>>> =C2=A0 kas/opt/ebg-secure-boot-base.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
>>> =C2=A0 kas/opt/ebg-secure-boot-snakeoil.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +++++++-
>>> =C2=A0 kas/opt/ebg-snakeoil-swu.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 -=
---------
>>> =C2=A0 .../images/cip-core-image-read-only.bb=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 20 ++++++++++++
>>> =C2=A0 recipes-core/tmp-fs/files/postinst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
>>> =C2=A0 recipes-core/tmp-fs/files/tmp.mount=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 +++++++
>>> =C2=A0 recipes-core/tmp-fs/tmp-fs_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++++++
>>> =C2=A0 wic/qemu-amd64-efibootguard-secureboot.wks=C2=A0=C2=A0=C2=A0 |=
 11 -------
>>> =C2=A0 wic/qemu-amd64-efibootguard-secureboot.wks.in | 13 ++++++++
>>> =C2=A0 11 files changed, 103 insertions(+), 30 deletions(-)
>>> =C2=A0 create mode 100644 classes/secure-swupdate-img.bbclass
>>> =C2=A0 delete mode 100644 kas/opt/ebg-snakeoil-swu.yml
>>> =C2=A0 create mode 100644 recipes-core/images/cip-core-image-read-onl=
y.bb
>>> =C2=A0 create mode 100755 recipes-core/tmp-fs/files/postinst
>>> =C2=A0 create mode 100644 recipes-core/tmp-fs/files/tmp.mount
>>> =C2=A0 create mode 100644 recipes-core/tmp-fs/tmp-fs_0.1.bb
>>> =C2=A0 delete mode 100644 wic/qemu-amd64-efibootguard-secureboot.wks
>>> =C2=A0 create mode 100644 wic/qemu-amd64-efibootguard-secureboot.wks.=
in
>>>
>>> diff --git a/Kconfig b/Kconfig
>>> index 8421f1b..e97cb03 100644
>>> --- a/Kconfig
>>> +++ b/Kconfig
>>> @@ -141,7 +141,6 @@ config IMAGE_SECURE_BOOT
>>> =C2=A0 config KAS_INCLUDE_SWUPDATE_SECBOOT
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default "kas/opt/ebg-swu.yml" if IMAGE=
_SWUPDATE &&
>>> !IMAGE_SECURE_BOOT
>>> -=C2=A0=C2=A0=C2=A0 default "kas/opt/ebg-secure-boot-snakeoil.yml" if
>>> !IMAGE_SWUPDATE && IMAGE_SECURE_BOOT
>>> -=C2=A0=C2=A0=C2=A0 default "kas/opt/ebg-snakeoil-swu.yml" if IMAGE_S=
WUPDATE &&
>>> IMAGE_SECURE_BOOT
>>> +=C2=A0=C2=A0=C2=A0 default "kas/opt/ebg-secure-boot-snakeoil.yml" if=
 IMAGE_SECURE_BOOT
>>> =C2=A0 =C2=A0 endif
>>> diff --git a/classes/secure-swupdate-img.bbclass
>>> b/classes/secure-swupdate-img.bbclass
>>> new file mode 100644
>>> index 0000000..431939b
>>> --- /dev/null
>>> +++ b/classes/secure-swupdate-img.bbclass
>>> @@ -0,0 +1,32 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2021
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +SECURE_IMAGE_FSTYPE ?=3D "squashfs"
>>> +
>>> +inherit ${SECURE_IMAGE_FSTYPE}-img
>>> +
>>> +VERITY_IMAGE_TYPE =3D "${SECURE_IMAGE_FSTYPE}"
>>> +
>>> +INITRAMFS_RECIPE ?=3D "cip-core-initramfs"
>>> +do_wic_image[depends] +=3D "${INITRAMFS_RECIPE}:do_build"
>>> +INITRD_IMAGE =3D "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.im=
g"
>>> +
>>> +inherit verity-img
>>> +inherit wic-img
>>> +inherit extract-partition
>>> +inherit swupdate-img
>>> +
>>> +SOURCE_IMAGE_FILE =3D "${WIC_IMAGE_FILE}"
>>> +
>>> +addtask do_verity_image after do_${SECURE_IMAGE_FSTYPE}_image
>>> +addtask do_wic_image after do_verity_image
>>> +addtask do_extract_partition after do_wic_image
>>> +addtask do_swupdate_image after do_extract_partition
>>> diff --git a/kas/opt/ebg-secure-boot-base.yml
>>> b/kas/opt/ebg-secure-boot-base.yml
>>> index 8f769b6..acb4de0 100644
>>> --- a/kas/opt/ebg-secure-boot-base.yml
>>> +++ b/kas/opt/ebg-secure-boot-base.yml
>>> @@ -19,3 +19,5 @@ local_conf_header:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IMAGE_INSTALL +=3D "initramfs-abrootfs=
-secureboot"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SWU_DESCRIPTION =3D "secureboot"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG =3D
>>> "secureboot/swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
>>> +=C2=A0 kernel: |
>>> +=C2=A0=C2=A0=C2=A0 SECURE_BOOT_KERNEL =3D "1"
>>> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml
>>> b/kas/opt/ebg-secure-boot-snakeoil.yml
>>> index 2f45bde..4a9185c 100644
>>> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
>>> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
>>> @@ -14,13 +14,24 @@ header:
>>> =C2=A0=C2=A0=C2=A0 includes:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - kas/opt/ebg-secure-boot-base.yml
>>> =C2=A0 +target: cip-core-image-read-only
>>> =C2=A0 =C2=A0 local_conf_header:
>>> +=C2=A0 swupdate: |
>>> +=C2=A0=C2=A0=C2=A0 IMAGE_INSTALL_append =3D " swupdate"
>>> +=C2=A0=C2=A0=C2=A0 IMAGE_INSTALL_append =3D " swupdate-handler-round=
robin"
>>> +
>>> +=C2=A0 verity-img: |
>>> +=C2=A0=C2=A0=C2=A0 SECURE_BOOT_KERNEL =3D "1"
>>> +=C2=A0=C2=A0=C2=A0 SECURE_IMAGE_FSTYPE =3D "squashfs"
>>> +=C2=A0=C2=A0=C2=A0 VERITY_IMAGE_RECIPE =3D "cip-core-image-read-only=
"
>>> +=C2=A0=C2=A0=C2=A0 IMAGE_TYPE =3D "secure-swupdate-img"
>>> +=C2=A0=C2=A0=C2=A0 WKS_FILE =3D "${MACHINE}-efibootguard-secureboot.=
wks.in"
>>> +
>>> =C2=A0=C2=A0=C2=A0 secure-boot: |
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Add snakeoil and ovmf binaries for q=
emu
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IMAGER_BUILD_DEPS +=3D "ebg-secure-boo=
t-snakeoil ovmf-binaries"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IMAGER_INSTALL +=3D "ebg-secure-boot-s=
nakeoil"
>>> -=C2=A0=C2=A0=C2=A0 WKS_FILE =3D "${MACHINE}-efibootguard-secureboot.=
wks"
>>> =C2=A0 =C2=A0=C2=A0=C2=A0 ovmf: |
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # snakeoil certs are only part of back=
ports
>>> diff --git a/kas/opt/ebg-snakeoil-swu.yml b/kas/opt/ebg-snakeoil-swu.=
yml
>>> deleted file mode 100644
>>> index 2f15c0e..0000000
>>> --- a/kas/opt/ebg-snakeoil-swu.yml
>>> +++ /dev/null
>>> @@ -1,16 +0,0 @@
>>> -#
>>> -# CIP Core, generic profile
>>> -#
>>> -# Copyright (c) Siemens AG, 2021
>>> -#
>>> -# Authors:
>>> -#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> -#
>>> -# SPDX-License-Identifier: MIT
>>> -#
>>> -
>>> -header:
>>> -=C2=A0 version: 10
>>> -=C2=A0 includes:
>>> -=C2=A0=C2=A0 - kas/opt/ebg-secure-boot-snakeoil.yml
>>> -=C2=A0=C2=A0 - kas/opt/swupdate.yml
>>> diff --git a/recipes-core/images/cip-core-image-read-only.bb
>>> b/recipes-core/images/cip-core-image-read-only.bb
>>> new file mode 100644
>>> index 0000000..7ef2dc2
>>> --- /dev/null
>>> +++ b/recipes-core/images/cip-core-image-read-only.bb
>>> @@ -0,0 +1,20 @@
>>> +require cip-core-image.bb
>>> +
>>> +SQUASHFS_EXCLUDE_DIRS +=3D "home var"
>>> +
>>> +IMAGE_INSTALL +=3D "tmp-fs"
>>> +IMAGE_INSTALL_remove +=3D "initramfs-abrootfs-secureboot"
>>> +
>>> +image_configure_fstab() {
>>> +=C2=A0=C2=A0=C2=A0 sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
>>> +# Begin /etc/fstab
>>> +/dev/root=C2=A0=C2=A0=C2=A0 /=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 auto=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defaults,ro=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=
 0
>>> +LABEL=3Dvar=C2=A0=C2=A0=C2=A0 /var=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 auto=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defaults=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=
 0
>>> +proc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /proc=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 proc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n=
osuid,noexec,nodev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0 0
>>> +sysfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 sysfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
nosuid,noexec,nodev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0 0
>>> +devpts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /dev/pts=C2=A0=C2=A0=
=C2=A0 devpts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gid=3D5,mode=3D62=
0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> 0=C2=A0=C2=A0=C2=A0 0
>>> +tmpfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /run=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 tmpfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> nodev,nosuid,size=3D500M,mode=3D755=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=
=A0 0
>>> +devtmpfs=C2=A0=C2=A0=C2=A0 /dev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 devtmpfs=C2=A0=C2=A0=C2=A0 mode=3D0755,nosuid=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0
>>> +# End /etc/fstab
>>> +EOF
>>> +}
>>> diff --git a/recipes-core/tmp-fs/files/postinst
>>> b/recipes-core/tmp-fs/files/postinst
>>> new file mode 100755
>>> index 0000000..07017fd
>>> --- /dev/null
>>> +++ b/recipes-core/tmp-fs/files/postinst
>>> @@ -0,0 +1,3 @@
>>> +#!/bin/sh
>>> +
>>> +deb-systemd-helper enable tmp.mount=C2=A0 || true
>>> diff --git a/recipes-core/tmp-fs/files/tmp.mount
>>> b/recipes-core/tmp-fs/files/tmp.mount
>>> new file mode 100644
>>> index 0000000..7a31ed6
>>> --- /dev/null
>>> +++ b/recipes-core/tmp-fs/files/tmp.mount
>>> @@ -0,0 +1,11 @@
>>> +[Unit]
>>> +Description=3DCreate /tmp
>>> +
>>> +[Mount]
>>> +What=3Dtmpfs
>>> +Where=3D/tmp
>>> +Type=3Dtmpfs
>>> +Options=3Dnodev,nosuid,size=3D500M,mode=3D755
>>
>> Hm, shouldn't size be configurable?
>=20
> I will make it configurable in the next version.
>>
>>
>>> +
>>> +[Install]
>>> +WantedBy=3Dlocal-fs.target
>>
>> Is this the right point in time? Isn't /tmp needed before this?
>=20
>=20
> According my testing and [1] if /tmp is mount a in /etc/fstab. systemd
> mounts before the local-fs.target.
>=20
> In the cip-core-image /tmp is not need before this as the /tmp of the
> initrd is used.
>=20
> The systemd log looks like this
> ```
> [=C2=A0 OK=C2=A0 ] Started Remount Root and Kernel File Systems.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Starting Create Static=
 Device Nodes in /dev...
> [=C2=A0 OK=C2=A0 ] Started Create Static Device Nodes in /dev.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Starting udev Kernel D=
evice Manager...
> [=C2=A0 OK=C2=A0 ] Reached target Local File Systems (Pre).
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Mounting Create /tmp...
> [=C2=A0 OK=C2=A0 ] Mounted Create /tmp.
> [=C2=A0 OK=C2=A0 ] Started Journal Service.
>=20
> ```
>=20
> [1]: https://www.freedesktop.org/software/systemd/man/systemd.special.h=
tml

Reason should also be recorded then, e.g. in the commit message.

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

