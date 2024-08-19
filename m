Return-Path: <florian.bezdeka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAF3C5320E
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 10:04:36 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.207048.1724061867963490527
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Aug 2024 03:04:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=florian.bezdeka@siemens.com header.s=fm1 header.b=Hz6C0wLS;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-68982-202408191004240c2cf38cc4fb81c523-qbozig@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202408191004240c2cf38cc4fb81c523
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Aug 2024 12:04:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fAWvrxN66SkhaKYuzK/fvyaOfHDfvt2P7S3PXChee+U=;
 b=Hz6C0wLSZyihU13OKMvF+Kf/dOKncRmiFZtW9kelo4sspAs8XO7BTSiiIY423da1DzNAcc
 Bjhumcr9uiShKLmkauOvOi00cQF/YqGDJ1YEIrvwL5y6TxWPisBueg06xpKvlw/Tyr5FNsjx
 IzEvz/3xkFyG6WC6lJrLqeAUDhDZ6NxLiQ8S3aZBucZUFKY2HgNE0xE6mNJOn2/tLgMJ3DKU
 yA+KQgFFChN+4w8q0MlxPrMVl93AS3xvkdfKMe5woL15Cq4apSiq0DwoX+BgUrsKqCEO8ZuW
 5/2YogfgCOLZynk/ZXU+pDMYf10n5tk2lIZvgxgYB+JjDGG8n2a8S2Vg==;
Message-ID: <8a6f051dd26ee829b386d358569afe4036b14ddd.camel@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v6] initramfs-overlay-hook:
 Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: cip-dev@lists.cip-project.org, Sai.Sathujoda@toshiba-tsip.com
Cc: quirin.gylstorff@siemens.com, clara.kowalsky@siemens.com, 
	dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Date: Mon, 19 Aug 2024 12:04:21 +0200
In-Reply-To: <4554969f-4d97-4aed-b8b9-d78c2db6212f@siemens.com>
References: <20240805091905.1818691-1-clara.kowalsky@siemens.com>
	 <OS3PR01MB6103795DE9A6A06EF71DB552C28C2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
	 <4554969f-4d97-4aed-b8b9-d78c2db6212f@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Aug 2024 10:04:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16796

On Mon, 2024-08-19 at 11:38 +0200, Jan Kiszka via lists.cip-project.org
wrote:
> On 19.08.24 11:34, Sai.Sathujoda@toshiba-tsip.com wrote:
> > Hello all,
> >=20
> > File system errors are detected in `/dev/disk/by-label/var` which is tr=
iggering `mke2fs` to re-create the file system during reboot.
> >=20
> > In LAVA jobs, mke2fs is asking for proceed prompt (y/n) because of whic=
h all software update jobs get stuck leading to a timeout error. -> https:/=
/lava.ciplatform.org/scheduler/job/1180009#L1213
> >=20
> > Currently I am not sure why file system errors are detected in `/dev/di=
sk/by-label/var` during reboot, but this needs to be handled in software up=
date test automation may be using mke2fs -FF -t "$partition_fstype" "$ovl_p=
artition_device".
> >=20
> > I request everyone to provide their opinions.
>=20
> So, we have two topics:
>=20
> 1. How to prevent getting stuck if /var is corrupt in way that it
>    falls back to interactive mode (-FF?)?
> 2. What is causing this issue in our test case?
>=20
> Before fixing 1. we should understand 2., I would say.

Is there a device reboot involved? If yes, make sure that you "sync"
your file system to disk before returning from the LAVA test suite.

It might happen that LAVA powers the device off too early (due to
incorrect timeout settings, ...) before all changes were written.

HTH,
Florian

>=20
> Jan
>=20
> >=20
> > Thanks and regards,
> > Sai Ashrith Sathujoda (T S I P)
> >=20
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On =
Behalf Of Clara Kowalsky via lists.cip-project.org
> > Sent: Monday, August 5, 2024 2:49 PM
> > To: jan.kiszka@siemens.com; cip-dev@lists.cip-project.org
> > Cc: quirin.gylstorff@siemens.com; Clara Kowalsky <clara.kowalsky@siemen=
s.com>
> > Subject: [cip-dev] [isar-cip-core][PATCH v6] initramfs-overlay-hook: Ch=
eck file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
> >=20
> > In case of ext*, this detects and fixes file system errors in the parti=
tion device before doing the partition mount.
> > If the partition turns out to be broken, the factory state is recovered=
.
> >=20
> > Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> > ---
> >  .../initramfs-overlay-hook/files/overlay.hook      | 11 +++++++++--
> >  .../files/overlay.script.tmpl                      | 11 ++++++++++-
> >  .../files/overlay_recovery_action.script           | 14 ++++++++++++++
> >  .../initramfs-overlay-hook_0.1.bb                  |  8 +++++++-
> >  4 files changed, 40 insertions(+), 4 deletions(-)  create mode 100644 =
recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.scri=
pt
> >=20
> > diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hoo=
k b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> > index 8b00ecf..6f634c5 100644
> > --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> > +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> > @@ -22,6 +22,13 @@ esac
> > =20
> >  . /usr/share/initramfs-tools/hook-functions
> > =20
> > +hook_error() {
> > +    echo "(ERROR): $1" >&2
> > +    exit 1
> > +}
> > +
> >  manual_add_modules overlay
> > -copy_exec /usr/bin/mountpoint
> > -copy_exec /usr/bin/awk
> > +copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not f=
ound"
> > +copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
> > +copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
> > +copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
> > diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.scr=
ipt.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tm=
pl
> > index 42eb59c..c655a4f 100644
> > --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmp=
l
> > +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmp=
l
> > @@ -31,12 +31,21 @@ ovl_partition_device=3D"${INITRAMFS_OVERLAY_STORAGE=
_DEVICE}"
> >  ovl_storage_path=3D"${INITRAMFS_OVERLAY_STORAGE_PATH}"
> >  ovl_lower_dirs=3D"${INITRAMFS_OVERLAY_PATHS}"
> >  ovl_mount_option=3D"${INITRAMFS_OVERLAY_MOUNT_OPTION}"
> > +ovl_recovery_script=3D"/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
> > =20
> >  root_mount_storage=3D${rootmnt}${ovl_storage_path}
> >  storage_mount_point=3D"$(echo "${ovl_storage_path}" | awk -F/ '{print =
FS$2}' )"
> > +partition_fstype=3D$(get_fstype "${ovl_partition_device}")
> > =20
> >  if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
> > -	if ! mount -t $(get_fstype ${ovl_partition_device}) \
> > +	case $partition_fstype in
> > +	ext*)
> > +		if ! e2fsck -p -f "$ovl_partition_device" && [ -x "$ovl_recovery_scr=
ipt" ]; then
> > +			"$ovl_recovery_script" "$partition_fstype" "$ovl_partition_device"
> > +		fi
> > +		;;
> > +	esac
> > +	if ! mount -t ${partition_fstype} \
> >  		 -o ${ovl_mount_option} \
> >  		 ${ovl_partition_device} \
> >  		 ${rootmnt}${storage_mount_point}; then diff --git a/recipes-initram=
fs/initramfs-overlay-hook/files/overlay_recovery_action.script b/recipes-in=
itramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
> > new file mode 100644
> > index 0000000..d13111d
> > --- /dev/null
> > +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_a=
c
> > +++ tion.script
> > @@ -0,0 +1,14 @@
> > +#!/bin/sh
> > +#
> > +# CIP Core, generic profile
> > +#
> > +# Copyright (c) Siemens AG, 2024
> > +#
> > +# Authors:
> > +#  Clara Kowalsky <clara.kowalsky@siemens.com> #
> > +
> > +partition_fstype=3D"$1"
> > +ovl_partition_device=3D"$2"
> > +
> > +mke2fs -t "$partition_fstype" "$ovl_partition_device"
> > diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay=
-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-h=
ook_0.1.bb
> > index 955748f..7097130 100644
> > --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0=
.1.bb
> > +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0=
.
> > +++ 1.bb
> > @@ -12,9 +12,12 @@
> > =20
> >  inherit dpkg-raw
> > =20
> > +INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??=3D "overlay_recovery_action.scrip=
t"
> > +
> >  SRC_URI +=3D " \
> >      file://overlay.hook \
> >      file://overlay.script.tmpl \
> > +    file://${INITRAMFS_OVERLAY_RECOVERY_SCRIPT} \
> >      "
> > =20
> >  # The variable INITRAMFS_OVERLAY_PATHS contains the directories which =
are @@ -35,7 +38,8 @@ TEMPLATE_FILES =3D "overlay.script.tmpl"
> >  TEMPLATE_VARS +=3D " INITRAMFS_OVERLAY_STORAGE_PATH \
> >      INITRAMFS_OVERLAY_PATHS \
> >      INITRAMFS_OVERLAY_STORAGE_DEVICE \
> > -    INITRAMFS_OVERLAY_MOUNT_OPTION"
> > +    INITRAMFS_OVERLAY_MOUNT_OPTION \
> > +    INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
> > =20
> >  DEBIAN_DEPENDS =3D "initramfs-tools, awk, coreutils, util-linux"
> > =20
> > @@ -48,4 +52,6 @@ do_install() {
> >          "${D}/usr/share/initramfs-tools/hooks/overlay"
> >      install -m 0755 "${WORKDIR}/overlay.script" \
> >          "${D}/usr/share/initramfs-tools/scripts/local-bottom/overlay"
> > +    install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" =
\
> > +        "${D}/usr/share/initramfs-tools/scripts"
> >  }
> > --
> > 2.46.0
> >=20
> >=20
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center


