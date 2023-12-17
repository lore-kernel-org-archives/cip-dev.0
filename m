Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E13C3DA6E
	for <webhook@archiver.kernel.org>; Sun, 17 Dec 2023 23:46:11 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.14939.1702796332578074909
 for <cip-dev@lists.cip-project.org>;
 Sat, 16 Dec 2023 22:58:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=oj0QZM9t;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1321639-202312170658487fea4c36d15c4a75df-eknbv6@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202312170658487fea4c36d15c4a75df
        for <cip-dev@lists.cip-project.org>;
        Sun, 17 Dec 2023 07:58:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=0CvfJ6DD5tgVDPCT4mPR4n4b31FNCN3J1YKQFsz1/q8=;
 b=oj0QZM9tabl6nDR3Et2bGYI3ajgR9/OB1tIWR+ubGC/h0OmxU1Zs6ZM5fRhnCYXVVkS4SE
 st6o9e5p/n0YT4qoCeHlxJ/glDMdIYAqi3a1DUeISuHxZgcm4pd/f7msGeEW1VZRBvSLJGJm
 UiX4yn9OgNxPIcM2yyFUyE63ufN7A=;
Message-ID: <a7efd9b61a389b2178be82c1c2c889f41d04d9aa.camel@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH] initramfs-overlay-hook: Get Storage mount point from INITRAMFS_OVERLAY_STORAGE_PATH
From: Moessbauer Felix <felix.moessbauer@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>, jan.kiszka@siemens.com,
  cip-dev@lists.cip-project.org
Date: Sun, 17 Dec 2023 14:58:44 +0800
In-Reply-To: <20231215195526.1117565-1-Quirin.Gylstorff@siemens.com>
References: <20231215195526.1117565-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 17 Dec 2023 23:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14129

On Fri, 2023-12-15 at 20:54 +0100, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> This allows to set the overlay storage to another root directory for
> example to store the overlay is /overlays.
typo --------------------------|

>=20
> This restores a similar behaviour as from before:
> 725dbc99cf9c4956fe7eb04d3932423782b7ce57.

Hi Quirin, thanks for fixing this. Back then I was not aware that there
is a use-case to change the overlay path (I considered these variables
to be internal).

Anyways, a bit more documentation would have avoided this confusion.
Could you please add a comment per variable what to put in there.

>=20
>=20
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> =C2=A0.../initramfs-overlay-hook/files/overlay.script.tmpl=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 8 +++++-
> --
> =C2=A01 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/recipes-initramfs/initramfs-overlay-
> hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-
> hook/files/overlay.script.tmpl
> index d7da6fb..e9a5e40 100644
> --- a/recipes-initramfs/initramfs-overlay-
> hook/files/overlay.script.tmpl
> +++ b/recipes-initramfs/initramfs-overlay-
> hook/files/overlay.script.tmpl
> @@ -1,4 +1,5 @@
> =C2=A0#!/bin/sh
> +# vim: ft=3Dsh

Either we add this to all scripts, or we don't. We should keep it
consistent.

> =C2=A0#
> =C2=A0# CIP Core, generic profile
> =C2=A0#
> @@ -32,12 +33,13 @@
> ovl_storage_path=3D"${INITRAMFS_OVERLAY_STORAGE_PATH}"
> =C2=A0ovl_lower_dirs=3D"${INITRAMFS_OVERLAY_PATHS}"
> =C2=A0
> =C2=A0root_mount_storage=3D${rootmnt}${ovl_storage_path}
> +storage_mount_point=3D"$(echo "${ovl_storage_path}" | awk -F/ '{print
> FS$2}' )"

How about subdirectories? Is this also supported, or would it break
here?

Felix

> =C2=A0
> -if ! mountpoint -q "${rootmnt}/var"; then
> +if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ! mount -t $(get_fstyp=
e ${ovl_partition_device}) \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ${ovl_partition_device} \
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ${rootmnt}/var; then
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0panic "Can't mount /var partition - overlay will not
> work!"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ${rootmnt}${storage_mount_point}; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0panic "Can't mount ${storage_mount_point} partition -
> overlay will not work!"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> =C2=A0fi
> =C2=A0


