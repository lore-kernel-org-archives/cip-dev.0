Return-Path: <christian.storm@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8211C433F5
	for <webhook@archiver.kernel.org>; Wed, 17 Nov 2021 12:09:29 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web10.6034.1637150968521873899
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Nov 2021 04:09:29 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: christian.storm@siemens.com)
Received: from mail2.siemens.de (mail2.siemens.de [139.25.208.11])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AHC9QMf026183
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 13:09:26 +0100
Received: from localhost ([139.22.32.60])
	by mail2.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AHC9PJD007563
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 13:09:25 +0100
Date: Wed, 17 Nov 2021 13:11:31 +0100
From: Christian Storm <christian.storm@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev][isar-cip-core]RFC v2 6/9] Create systemd mount units
 for a etc overlay
Message-ID: <20211117121131.as2eyks3q76x75sq@MD1ZFJVC.ad001.siemens.net>
Mail-Followup-To: cip-dev@lists.cip-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20211116112752.1521211-7-Quirin.Gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by thoth.sbs.de id
 1AHC9QMf026183
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Nov 2021 12:09:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6944

> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> As /etc is read-only and needs to be accessed by the initrd
> move the user defined settings to a overlay in /var/local/etc.
>=20
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../etc-overlay-fs/etc-overlay-fs_0.1.bb         | 16 ++++++++++++++++
>  .../etc-overlay-fs/files/etc-hostname.service    | 14 ++++++++++++++
>  .../etc-overlay-fs/files/etc-sysusers.service    | 14 ++++++++++++++
>  recipes-core/etc-overlay-fs/files/etc.mount      | 13 +++++++++++++
>  .../files/overlay-parse-etc.service              | 12 ++++++++++++
>  recipes-core/etc-overlay-fs/files/postinst       |  6 ++++++
>  recipes-core/images/cip-core-image-read-only.bb  |  1 +
>  7 files changed, 76 insertions(+)
>  create mode 100644 recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
>  create mode 100644 recipes-core/etc-overlay-fs/files/etc-hostname.serv=
ice
>  create mode 100644 recipes-core/etc-overlay-fs/files/etc-sysusers.serv=
ice
>  create mode 100644 recipes-core/etc-overlay-fs/files/etc.mount
>  create mode 100644 recipes-core/etc-overlay-fs/files/overlay-parse-etc=
.service
>  create mode 100755 recipes-core/etc-overlay-fs/files/postinst
>=20
> diff --git a/recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb b/recipe=
s-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
> new file mode 100644
> index 0000000..f1c8349
> --- /dev/null
> +++ b/recipes-core/etc-overlay-fs/etc-overlay-fs_0.1.bb
> @@ -0,0 +1,16 @@
> +inherit dpkg-raw
> +
> +SRC_URI =3D "file://postinst \
> +           file://etc.mount \
> +           file://overlay-parse-etc.service \
> +           file://etc-hostname.service \
> +           file://etc-sysusers.service"
> +
> +do_install[cleandirs]+=3D"${D}/lib/systemd/system ${D}/var/local/etc $=
{D}/var/local/.atomic"
> +do_install() {
> +    TARGET=3D${D}/lib/systemd/system
> +    install -m 0644 ${WORKDIR}/etc.mount ${TARGET}/etc.mount
> +    install -m 0644 ${WORKDIR}/overlay-parse-etc.service  ${TARGET}/ov=
erlay-parse-etc.service
> +    install -m 0644 ${WORKDIR}/etc-hostname.service ${TARGET}/etc-host=
name.service
> +    install -m 0644 ${WORKDIR}/etc-sysusers.service ${TARGET}/etc-sysu=
sers.service
> +}
> diff --git a/recipes-core/etc-overlay-fs/files/etc-hostname.service b/r=
ecipes-core/etc-overlay-fs/files/etc-hostname.service
> new file mode 100644
> index 0000000..2306b9f
> --- /dev/null
> +++ b/recipes-core/etc-overlay-fs/files/etc-hostname.service
> @@ -0,0 +1,14 @@
> +[Unit]
> +Description=3Dset hostname /etc overlay-aware
> +Before=3Dnetwork-pre.target
> +Wants=3Dnetwork-pre.target
> +Requires=3Detc.mount
> +After=3Detc.mount
> +
> +[Service]
> +Type=3Doneshot
> +RemainAfterExit=3Dyes
> +ExecStart=3D/bin/hostname --boot --file /etc/hostname
> +
> +[Install]
> +WantedBy=3Dbasic.target
> diff --git a/recipes-core/etc-overlay-fs/files/etc-sysusers.service b/r=
ecipes-core/etc-overlay-fs/files/etc-sysusers.service
> new file mode 100644
> index 0000000..6caf6b0
> --- /dev/null
> +++ b/recipes-core/etc-overlay-fs/files/etc-sysusers.service
> @@ -0,0 +1,14 @@
> +[Unit]
> +Description=3Dmake systemd-sysusers /etc overlay aware
> +Before=3Dnetwork-pre.target
> +Wants=3Dnetwork-pre.target
> +Requires=3Detc.mount
> +After=3Detc.mount
> +
> +[Service]
> +Type=3Doneshot
> +RemainAfterExit=3Dyes
> +ExecStart=3D/usr/bin/systemd-sysusers
> +
> +[Install]
> +WantedBy=3Dbasic.target

Hm, why do you replace/create those services instead of augmenting the
current default ones via conf.d'lets?
Why is this one here dependent on network?
Why does this differ that much from upstream service files, see, e.g.,
https://github.com/systemd/systemd/blob/main/units/systemd-sysusers.servi=
ce


> diff --git a/recipes-core/etc-overlay-fs/files/etc.mount b/recipes-core=
/etc-overlay-fs/files/etc.mount
> new file mode 100644
> index 0000000..f0ae3c5
> --- /dev/null
> +++ b/recipes-core/etc-overlay-fs/files/etc.mount
> @@ -0,0 +1,13 @@
> +[Unit]
> +Description=3DOverlay-mount /etc
> +Requires=3Dvar.mount
> +After=3Dvar.mount
> +
> +[Mount]
> +What=3Doverlay
> +Where=3D/etc
> +Type=3Doverlay
> +Options=3Dnoauto,x-systemd.automount,lowerdir=3D/etc,upperdir=3D/var/l=
ocal/etc,workdir=3D/var/local/.atomic
> +
> +[Install]
> +WantedBy=3Dlocal-fs.target
> diff --git a/recipes-core/etc-overlay-fs/files/overlay-parse-etc.servic=
e b/recipes-core/etc-overlay-fs/files/overlay-parse-etc.service
> new file mode 100644
> index 0000000..062bb40
> --- /dev/null
> +++ b/recipes-core/etc-overlay-fs/files/overlay-parse-etc.service
> @@ -0,0 +1,12 @@
> +[Unit]
> +Description=3DReload Configuration from the etc overlay
> +Requires=3Detc.mount
> +After=3Detc.mount
> +
> +[Service]
> +Type=3Doneshot
> +RemainAfterExit=3Dyes
> +ExecStartPre=3D!/bin/systemctl daemon-reload
> +ExecStart=3D!/bin/systemctl --no-block isolate multi-user.target

Wow, this is a big cannon, why do you need this? Isn't there another way?


> +[Install]
> +WantedBy=3Dlocal-fs.target
> diff --git a/recipes-core/etc-overlay-fs/files/postinst b/recipes-core/=
etc-overlay-fs/files/postinst
> new file mode 100755
> index 0000000..35641af
> --- /dev/null
> +++ b/recipes-core/etc-overlay-fs/files/postinst
> @@ -0,0 +1,6 @@
> +#!/bin/sh
> +
> +deb-systemd-helper enable etc.mount  || true
> +deb-systemd-helper enable overlay-parse-etc.service || true
> +deb-systemd-helper enable etc-hostname.service || true
> +deb-systemd-helper enable etc-sysusers.service || true
> diff --git a/recipes-core/images/cip-core-image-read-only.bb b/recipes-=
core/images/cip-core-image-read-only.bb
> index 7ef2dc2..ceb6ac4 100644
> --- a/recipes-core/images/cip-core-image-read-only.bb
> +++ b/recipes-core/images/cip-core-image-read-only.bb
> @@ -2,6 +2,7 @@ require cip-core-image.bb
> =20
>  SQUASHFS_EXCLUDE_DIRS +=3D "home var"
> =20
> +IMAGE_INSTALL +=3D "etc-overlay-fs"
>  IMAGE_INSTALL +=3D "tmp-fs"
>  IMAGE_INSTALL_remove +=3D "initramfs-abrootfs-secureboot"
> =20
> --=20
> 2.30.2
>=20



Kind regards,
   Christian

--=20
Dr. Christian Storm
Siemens AG, Technology, T RDA IOT SES-DE
Otto-Hahn-Ring 6, 81739 M=FCnchen, Germany

