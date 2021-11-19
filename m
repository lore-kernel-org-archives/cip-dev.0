Return-Path: <christian.storm@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE526C433F5
	for <webhook@archiver.kernel.org>; Fri, 19 Nov 2021 13:27:14 +0000 (UTC)
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.8801.1637328433464088703
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Nov 2021 05:27:14 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.14, mailfrom: christian.storm@siemens.com)
Received: from mail2.siemens.de (mail2.siemens.de [139.25.208.11])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AJDR7O7018471
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 19 Nov 2021 14:27:07 +0100
Received: from localhost ([139.22.47.12])
	by mail2.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AJDR60R003199
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <cip-dev@lists.cip-project.org>; Fri, 19 Nov 2021 14:27:06 +0100
Date: Fri, 19 Nov 2021 14:29:15 +0100
From: Christian Storm <christian.storm@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev][isar-cip-core]RFC v2 4/9] Create a initrd with support
 for dm-verity
Message-ID: <20211119132915.unoqty5scuaxvdsw@MD1ZFJVC.ad001.siemens.net>
Mail-Followup-To: cip-dev@lists.cip-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2e1c1ff2-612b-7273-c294-e780154f5f9b@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by david.siemens.de id
 1AJDR7O7018471
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Nov 2021 13:27:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6960

> > > diff --git a/recipes-initramfs/initramfs-verity-hook/files/verity.s=
cript.tmpl b/recipes-initramfs/initramfs-verity-hook/files/verity.script.=
tmpl
> > > new file mode 100644
> > > index 0000000..c4f3dc4
> > > --- /dev/null
> > > +++ b/recipes-initramfs/initramfs-verity-hook/files/verity.script.t=
mpl
> > > @@ -0,0 +1,68 @@
> > > +#!/bin/sh
> > > +prereqs()
> > > +{
> > > +    # Make sure that this script is run last in local-top
> > > +    local req
> > > +    for req in "${0%/*}"/*; do
> > > +        script=3D"${req##*/}"
> > > +        if [ "$script" !=3D "${0##*/}" ] && [ "$script" !=3D "cryp=
troot" ]; then
> >=20
> > Hm, so you explicitly enumerate all scripts except for cryptroot so t=
hat
> > you run (hopefully right?) thereafter.
> > Isn't it sufficient to make cryptroot dependent on this?
> > Looks too verbose and complicated...
>=20
> It is the same scripting as cryptroot uses in Debian 11 which inspired =
this
> script. See [1].
> [1]: https://salsa.debian.org/cryptsetup-team/cryptsetup/-/blob/debian/=
latest/debian/initramfs/scripts/local-top/cryptroot

Anyway, this doesn't answer the questions?



Kind regards,
   Christian

--=20
Dr. Christian Storm
Siemens AG, Technology, T RDA IOT SES-DE
Otto-Hahn-Ring 6, 81739 M=FCnchen, Germany

