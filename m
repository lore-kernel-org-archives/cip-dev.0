Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0779D5AE41
	for <webhook@archiver.kernel.org>; Sat, 13 Dec 2025 08:57:08 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2381.1765616223248911203
 for <cip-dev@lists.cip-project.org>;
 Sat, 13 Dec 2025 00:57:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DsrftkTx;
 spf=pass (domain: gmail.com, ip: 209.85.160.180, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4f1899960f0so21203571cf.1
        for <cip-dev@lists.cip-project.org>; Sat, 13 Dec 2025 00:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765616222; x=1766221022; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3o42qveFaJEpynnMxMZo3umeD85o0KkxgnnHO4VhOw=;
        b=DsrftkTxFX9MGcHrf24Frs2M9eo+NtqRSd8JKx0EZFu0/YsLhoNjAKI4/Eav/q98nz
         FZ4J/wOiSUbKpguZUIEXEVYoSIY2rp+/6wcOFYd0NDMIzcEKoPWVOsYa9NQLBhe7e5uc
         bgALUQQnRCmWZJAX42ZO6Y/mmISrORv7/PvlrS4q9L5hPLLUx058MW6mRsG6fpy/LDgG
         Si2L8Xo/iPShvKYmABrUwzP5ESxALvyS9Ay2pWUzEiRC48B6RhwB8JXkdVkgr9MQio0s
         LXQQ8MmUaY/dfZA8D7ZCEWzCVYCBP9RFUAqPD6xeMroUV+VAyjDg1D1YuZyGsRUfG2xU
         K+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765616222; x=1766221022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D3o42qveFaJEpynnMxMZo3umeD85o0KkxgnnHO4VhOw=;
        b=eEBysfNzHPEtqhAm1IMkXE7W+3F4c+tvCx9bqXvUay6QOG/nXAwwYN74UABRaovKXj
         MxCdvuNnWM/GkHQ6NlRDfnAO+Lhi0vEOrZWbqXD3f+ktBxamKdmUb8dCN3i5iuYFHUTk
         /ovbnWb2UlCmfUqLrozNtKB/4V971206hAXc4FBmhRCOFYqvKJ2im2Q7TltZySCspqqB
         HbZmxnYn3kyepmUx7a2KdMnmXAp/0N8x3hb3r/qzdKvcsSJ3fOx8bwUUcrAWeCL7kjPA
         GTCjfYL9wYVkRQtLN+gHeAvJ6pmj10wwOL4Ifq2g001pntzMrClYIka01afbf3xa04IH
         Hn+A==
X-Forwarded-Encrypted: i=1; AJvYcCWxhvSilPzNkz6+B2GFS6ifOnxBfTTzXT6Kksl89af+pmXAIx3xlSds4y0JvJCMZcvSJwkREIbU@lists.cip-project.org
X-Gm-Message-State: AOJu0YzL+BIbr442/fOuSJX/n+U6BPHGCNcgf8073LKPdseMKVlrN/lX
	rzEBKq53hl/TFwZ1/LmsiyG09ecs18Ck77XQhI4jj6/hKeiES/e5XikjMqWUx1hZolwyUP0uDRn
	A3pYgFs4xz+wy1umI0wMaOi9KDxFMEH0=
X-Gm-Gg: AY/fxX7Ep6Cf021eQose3o3Cg07HzioP4yMQOjkUIxtw8gPwqMap4fiUu76F6mPRYRS
	yo5ql/vIW3mRGoJuehMnRHhMBph6UnVxgUGWE9hFcg3exMulnVnapR+plwsPpuNh66PMSiScOiO
	BO5WCkJQaqCTeZaDJY9R9WbvByfWRLh+Tus9NrnmmWzoY3aQj0oe4brGbyv7fWHQOS20a1q9ZYU
	nxqR6cXyEHy7b4TCF8gdcVJ1tcDTMNoTgU8+jAd5OZCnMDs/bX8uIbCPqMNcJwyx5nT
X-Google-Smtp-Source: AGHT+IHYF80VuMBJRTVaiGI5Kd0U8ZMJpnvZ3Rx6XCQ7A32huscmzN2XDF9aAW9YgKUsg6UjyA2bpy7ma8o0Mudsw4o=
X-Received: by 2002:a05:622a:5c15:b0:4ee:1f09:4c39 with SMTP id
 d75a77b69052e-4f1d05a9351mr57888081cf.45.1765616222197; Sat, 13 Dec 2025
 00:57:02 -0800 (PST)
MIME-Version: 1.0
References: <5a48c2d2-2699-44a2-89ef-c44ef1c9ca38@siemens.com> <OSZPR01MB812347C7FA70D10AE6C7D096B7AFA@OSZPR01MB8123.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB812347C7FA70D10AE6C7D096B7AFA@OSZPR01MB8123.jpnprd01.prod.outlook.com>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Sat, 13 Dec 2025 17:56:50 +0900
X-Gm-Features: AQt7F2psHriJP_Zqkr_6qjGuQnQFS-y63hdNZKrEWr0KkO7BTqveIIICJl0Kd54
Message-ID: <CACe6DC7J75AYUkgW1RGWOd1A3y5oS_Y1LQe1TPvb=ZEGX3PBDA@mail.gmail.com>
Subject: Re: [cip-dev] [isar-cip-core][RFC][PATCH] Remove support for building
 KernelCI images
To: chris.paterson2@renesas.com
Cc: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev <cip-dev@lists.cip-project.org>, 
	Arisu Tachibana <arisu.tachibana@miraclelinux.com>, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Dec 2025 08:57:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21011

Hi all,

2025=E5=B9=B412=E6=9C=8813=E6=97=A5(=E5=9C=9F) 9:26 Chris Paterson via list=
s.cip-project.org
<chris.paterson2=3Drenesas.com@lists.cip-project.org>:
>
> Hello Jan,
>
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > Sent: 10 December 2025 17:41
> >
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >
> > We are solely using the KernelCI-provided rootfs images by now and do
> > not plan to change that.
> >
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>
> I'm happy with this.
> If there is a requirement to re-add cip-core support for the new KernelCI=
 we can revert accordingly.
>

Excuse me, I want to understand the information correctly, so please
confirm this.
Does this mean that the rootfs used to test CIP kernels in kernel CI
is not isar-cip-core,
but the rootfs provided by kernel CI?
If this is correct, what is the reason?

> Kind regards, Chris
>

Best regards,
  Nobuhiro

> > ---
> >
> > Please give feedback if we are on the same page.
> >
> >  .gitlab-ci.yml                                | 29 ----------
> >  kas/opt/kernelci.yml                          | 19 -------
> >  .../images/cip-core-image-kernelci.bb         | 16 ------
> >  .../kernelci-customizations/files/dmesg.sh    | 23 --------
> >  .../kernelci-customizations/files/postinst    | 23 --------
> >  .../files/serial-getty-kernelci-override.conf |  3 -
> >  .../files/ssh-permit-empty-passwords.conf     |  1 -
> >  .../kernelci-customizations.bb                | 33 -----------
> >  scripts/deploy-kernelci.py                    | 56 -------------------
> >  9 files changed, 203 deletions(-)
> >  delete mode 100644 kas/opt/kernelci.yml
> >  delete mode 100644 recipes-core/images/cip-core-image-kernelci.bb
> >  delete mode 100644 recipes-core/kernelci-customizations/files/dmesg.sh
> >  delete mode 100644 recipes-core/kernelci-customizations/files/postinst
> >  delete mode 100644 recipes-core/kernelci-customizations/files/serial-
> > getty-kernelci-override.conf
> >  delete mode 100644 recipes-core/kernelci-customizations/files/ssh-perm=
it-
> > empty-passwords.conf
> >  delete mode 100644 recipes-core/kernelci-customizations/kernelci-
> > customizations.bb
> >  delete mode 100755 scripts/deploy-kernelci.py
> >
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index 2714a374..3a202536 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -20,7 +20,6 @@ variables:
> >    encrypt: disable
> >    dtb: none
> >    deploy: disable
> > -  deploy_kernelci: disable
> >    build_updates: disable
> >    swupdate_version: default
> >    test_function: swupdate
> > @@ -93,7 +92,6 @@ default:
> >            done;
> >            scripts/deploy-cip-core.sh ${release} ${target} ${extension}
> > ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swus;
> >        fi
> > -    - if [ "${deploy_kernelci}" =3D "enable" ]; then scripts/deploy-
> > kernelci.py ${release} ${target} ${extension} ${dtb}; fi
> >
> >  # base image
> >  build:x86-uefi-base:
> > @@ -135,15 +133,6 @@ build:qemu-amd64-base:
> >      separate_home_partition: enable
> >      deploy: enable
> >
> > -build:qemu-amd64-base-kernelci:
> > -  extends:
> > -    - .build_base
> > -  variables:
> > -    target: qemu-amd64
> > -    extension: kernelci
> > -    use_rt: disable
> > -    #deploy_kernelci: enable
> > -
> >  build:qemu-arm64-base:
> >    extends:
> >      - .build_base
> > @@ -156,15 +145,6 @@ build:qemu-arm64-base:
> >      separate_home_partition: enable
> >      deploy: enable
> >
> > -build:qemu-arm64-base-kernelci:
> > -  extends:
> > -    - .build_base
> > -  variables:
> > -    target: qemu-arm64
> > -    extension: kernelci
> > -    use_rt: disable
> > -    #deploy_kernelci: enable
> > -
> >  build:qemu-arm-base:
> >    extends:
> >      - .build_base
> > @@ -177,15 +157,6 @@ build:qemu-arm-base:
> >      separate_home_partition: enable
> >      deploy: enable
> >
> > -build:qemu-arm-base-kernelci:
> > -  extends:
> > -    - .build_base
> > -  variables:
> > -    target: qemu-arm
> > -    extension: kernelci
> > -    use_rt: disable
> > -    #deploy_kernelci: enable
> > -
> >  build:qemu-riscv64:
> >    extends:
> >      - .build_base
> > diff --git a/kas/opt/kernelci.yml b/kas/opt/kernelci.yml
> > deleted file mode 100644
> > index 517e7410..00000000
> > --- a/kas/opt/kernelci.yml
> > +++ /dev/null
> > @@ -1,19 +0,0 @@
> > -#
> > -# CIP Core, generic profile
> > -#
> > -# Copyright (c) Toshiba Corporation, 2020
> > -# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> > -#
> > -# Authors:
> > -#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
> > -#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > -#
> > -# SPDX-License-Identifier: MIT
> > -#
> > -
> > -header:
> > -  version: 14
> > -  includes:
> > -    - kas/opt/targz.yml
> > -
> > -target: cip-core-image-kernelci
> > diff --git a/recipes-core/images/cip-core-image-kernelci.bb b/recipes-
> > core/images/cip-core-image-kernelci.bb
> > deleted file mode 100644
> > index 849c0761..00000000
> > --- a/recipes-core/images/cip-core-image-kernelci.bb
> > +++ /dev/null
> > @@ -1,16 +0,0 @@
> > -#
> > -# A reference image for KernelCI
> > -#
> > -# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> > -#
> > -# Authors:
> > -#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > -#
> > -# SPDX-License-Identifier: MIT
> > -#
> > -
> > -require cip-core-image.inc
> > -
> > -DESCRIPTION =3D "CIP Core image for KernelCI"
> > -
> > -IMAGE_INSTALL +=3D "kernelci-customizations"
> > diff --git a/recipes-core/kernelci-customizations/files/dmesg.sh
> > b/recipes-core/kernelci-customizations/files/dmesg.sh
> > deleted file mode 100644
> > index 3b096e10..00000000
> > --- a/recipes-core/kernelci-customizations/files/dmesg.sh
> > +++ /dev/null
> > @@ -1,23 +0,0 @@
> > -#!/bin/sh
> > -
> > -set -e
> > -
> > -if [ "$KERNELCI_LAVA" =3D "y" ]; then
> > -    alias test-result=3D'lava-test-case'
> > -else
> > -    alias test-result=3D'echo'
> > -fi
> > -
> > -for level in crit alert emerg; do
> > -    dmesg --level=3D$level --notime -x -k > dmesg.$level
> > -    test -s dmesg.$level && res=3Dfail || res=3Dpass
> > -    count=3D$(cat dmesg.$level | wc -l)
> > -    cat dmesg.$level
> > -    test-result \
> > -        $level \
> > -        --result $res \
> > -        --measurement $count \
> > -        --units lines
> > -done
> > -
> > -exit 0
> > diff --git a/recipes-core/kernelci-customizations/files/postinst
> > b/recipes-core/kernelci-customizations/files/postinst
> > deleted file mode 100644
> > index 08544a4d..00000000
> > --- a/recipes-core/kernelci-customizations/files/postinst
> > +++ /dev/null
> > @@ -1,23 +0,0 @@
> > -#!/bin/sh
> > -#
> > -# CIP Core, generic profile
> > -#
> > -# Copyright (c) Siemens AG, 2019
> > -# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> > -#
> > -# Authors:
> > -#  Jan Kiszka <jan.kiszka@siemens.com>
> > -#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > -#
> > -# SPDX-License-Identifier: MIT
> > -#
> > -
> > -echo "CIP Core Demo & Test Image" > /etc/issue
> > -
> > -# permit root login without password
> > -passwd root -d
> > -
> > -# set the profile for KernelCI
> > -echo "PS1=3D'\$(pwd) # '" > /root/.profile
> > -echo "cd /" >> /root/.profile
> > -
> > diff --git a/recipes-core/kernelci-customizations/files/serial-getty-
> > kernelci-override.conf b/recipes-core/kernelci-
> > customizations/files/serial-getty-kernelci-override.conf
> > deleted file mode 100644
> > index a1472c5d..00000000
> > --- a/recipes-core/kernelci-customizations/files/serial-getty-kernelci-
> > override.conf
> > +++ /dev/null
> > @@ -1,3 +0,0 @@
> > -[Service]
> > -ExecStart=3D
> > -ExecStart=3D-/sbin/agetty --autologin root --keep-baud 115200,38400,96=
00 %I
> > $TERM
> > diff --git a/recipes-core/kernelci-customizations/files/ssh-permit-empt=
y-
> > passwords.conf b/recipes-core/kernelci-customizations/files/ssh-permit-
> > empty-passwords.conf
> > deleted file mode 100644
> > index 04e75ab6..00000000
> > --- a/recipes-core/kernelci-customizations/files/ssh-permit-empty-
> > passwords.conf
> > +++ /dev/null
> > @@ -1 +0,0 @@
> > -PermitEmptyPasswords yes
> > diff --git a/recipes-core/kernelci-customizations/kernelci-
> > customizations.bb b/recipes-core/kernelci-customizations/kernelci-
> > customizations.bb
> > deleted file mode 100644
> > index 3a99884b..00000000
> > --- a/recipes-core/kernelci-customizations/kernelci-customizations.bb
> > +++ /dev/null
> > @@ -1,33 +0,0 @@
> > -#
> > -# CIP Core, generic profile
> > -#
> > -# Copyright (c) Siemens AG, 2019
> > -# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> > -#
> > -# Authors:
> > -#  Jan Kiszka <jan.kiszka@siemens.com>
> > -#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > -#
> > -# SPDX-License-Identifier: MIT
> > -#
> > -
> > -inherit dpkg-raw
> > -
> > -DESCRIPTION =3D "CIP Core KernelCI image customizations"
> > -
> > -DEPENDS +=3D "customizations"
> > -DEBIAN_DEPENDS +=3D "customizations"
> > -
> > -SRC_URI =3D "file://postinst \
> > -           file://dmesg.sh \
> > -           file://serial-getty-kernelci-override.conf \
> > -           file://ssh-permit-empty-passwords.conf"
> > -
> > -do_install[cleandirs] =3D "${D}/opt/kernelci/ \
> > -                         ${D}/etc/systemd/system/serial-getty@.service=
.d/
> > \
> > -                         ${D}/etc/ssh/sshd_config.d/"
> > -do_install() {
> > -  install -v -m 744 ${WORKDIR}/dmesg.sh ${D}/opt/kernelci/
> > -  install -v -m 644 ${WORKDIR}/serial-getty-kernelci-override.conf
> > ${D}/etc/systemd/system/serial-getty@.service.d/serial-getty-kernelci-
> > override.conf
> > -  install -v -m 600 ${WORKDIR}/ssh-permit-empty-passwords.conf
> > ${D}/etc/ssh/sshd_config.d/ssh-permit-empty-passwords.conf
> > -}
> > diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
> > deleted file mode 100755
> > index 62f3f010..00000000
> > --- a/scripts/deploy-kernelci.py
> > +++ /dev/null
> > @@ -1,56 +0,0 @@
> > -#!/usr/bin/env python3
> > -# -*- coding: utf-8 -*-
> > -
> > -import requests
> > -import os
> > -import sys
> > -import time
> > -from urllib.parse import urljoin
> > -
> > -cdate =3D time.strftime("%Y%m%d")
> > -api =3D "https://api.kernelci.org/upload"
> > -token =3D os.getenv("KERNELCI_TOKEN")
> > -
> > -release =3D sys.argv[1]
> > -target =3D sys.argv[2]
> > -extension =3D sys.argv[3]
> > -
> > -rootfs_filename =3D "cip-core-image-kernelci-cip-core-"+release+"-
> > "+target+".tar.gz"
> > -initrd_filename =3D "cip-core-image-kernelci-cip-core-"+release+"-
> > "+target+"-initrd.img"
> > -initrd_gz_filename =3D "cip-core-image-kernelci-cip-core-"+release+"-
> > "+target+"-initrd.img.gz"
> > -
> > -input_dir =3D "build/tmp/deploy/images/"+target
> > -upload_path =3D "/images/rootfs/cip/"+cdate+"/"+target+"/"
> > -upload_path_latest =3D "/images/rootfs/cip/latest/"+target+"/"
> > -rootfs =3D input_dir+"/"+rootfs_filename
> > -initrd =3D input_dir+"/"+initrd_filename
> > -
> > -
> > -def upload_file(api, token, path, input_file, input_filename):
> > -    headers =3D {
> > -        'Authorization': token,
> > -    }
> > -    data =3D {
> > -        'path': path,
> > -    }
> > -    files =3D {
> > -        'file': (input_filename, open(input_file, 'rb').read()),
> > -    }
> > -    url =3D urljoin(api, 'upload')
> > -    resp =3D requests.post(url, headers=3Dheaders, data=3Ddata, files=
=3Dfiles)
> > -    resp.raise_for_status()
> > -
> > -
> > -if os.path.exists(rootfs) and os.path.exists(initrd):
> > -    print("uploading rootfs to KernelCI")
> > -    upload_file(api, token, upload_path, rootfs, rootfs_filename)
> > -    print("uploading initrd to KernelCI")
> > -    upload_file(api, token, upload_path, initrd, initrd_gz_filename)
> > -    print("uploaded to: https://storage.kernelci.org"+upload_path)
> > -
> > -    # Upload latest
> > -    print("uploading rootfs to KernelCI CIP latest")
> > -    upload_file(api, token, upload_path_latest, rootfs, rootfs_filenam=
e)
> > -    print("uploading initrd to KernelCI CIP latest")
> > -    upload_file(api, token, upload_path_latest, initrd,
> > initrd_gz_filename)
> > -    print("uploaded to: https://storage.kernelci.org"+upload_path_late=
st)
> > --
> > 2.51.0
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#21010): https://lists.cip-project.org/g/cip-dev/messa=
ge/21010
> Mute This Topic: https://lists.cip-project.org/mt/116708993/4520494
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [iwamatsu@gmai=
l.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Nobuhiro Iwamatsu

