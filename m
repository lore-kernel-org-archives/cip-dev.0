Return-Path: <ubely@ilbers.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9E7C83005
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 12:21:47 +0000 (UTC)
Received: from shymkent.ilbers.de (shymkent.ilbers.de [85.214.156.166])
 by mx.groups.io with SMTP id smtpd.web10.7023.1686140500050926824
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jun 2023 05:21:40 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: ilbers.de, ip: 85.214.156.166, mailfrom: ubely@ilbers.de)
Received: from [127.0.0.1] (host-80-81-17-52.static.customer.m-online.net [80.81.17.52])
	(authenticated bits=0)
	by shymkent.ilbers.de (8.15.2/8.15.2/Debian-8+deb9u1) with ESMTPSA id 357CLan5004338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Jun 2023 14:21:37 +0200
Message-ID: <33a2eaa5a69e113eaba7b4732927430ad1bf8a64.camel@ilbers.de>
Subject: Re: [isar-cip-core][PATCH] IMAGE_TYPEDEP:swu: Don't depend on wic
From: Uladzimir Bely <ubely@ilbers.de>
To: Jan Kiszka <jan.kiszka@siemens.com>,
        "MOESSBAUER, Felix"
	 <felix.moessbauer@siemens.com>,
        "cip-dev@lists.cip-project.org"
	 <cip-dev@lists.cip-project.org>,
        "Gylstorff, Quirin"
	 <quirin.gylstorff@siemens.com>
Cc: ubely@ilbers.de
Date: Wed, 07 Jun 2023 15:21:36 +0300
In-Reply-To: <1d6b07c98b52bfd54e2eb78b7087b0357d7c5024.camel@ilbers.de>
References: <20230516085018.26436-1-ubely@ilbers.de>
	 <cb62ac04-f64e-192e-7d00-e411f4422cea@siemens.com>
	 <0fc8aa184fe24a549be85f87a69a0edb@siemens.com>
	 <86438485-f93d-5457-cfd2-7021a0b2916d@siemens.com>
	 <b7d6f5e4-7da1-bc89-4500-e51ead5f3b3a@siemens.com>
	 <1d6b07c98b52bfd54e2eb78b7087b0357d7c5024.camel@ilbers.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (by Flathub.org) 
MIME-Version: 1.0
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 12:21:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11907

On Wed, 2023-06-07 at 12:03 +0300, Uladzimir Bely wrote:
> On Tue, 2023-06-06 at 09:57 +0200, Jan Kiszka wrote:
> > On 06.06.23 09:09, Jan Kiszka wrote:
> > > On 05.06.23 09:13, MOESSBAUER, Felix wrote:
> > > > > On 16.05.23 10:50, Uladzimir Bely wrote:
> > > > > > Settings IMAGE_FSTYPE to something like "ext4 swu" or
> > > > > > "wic.xz
> > > > > > swu"
> > > > > > causes uncompressed '.wic' image left non-removed after the
> > > > > > build=20
> > > > > > finished. This is caused by indirect dependency on "wic" in
> > > > > > swupdate=20
> > > > > > bbclass that can't be overriden by the user in local.conf.
> > > > > >=20
> > > > > > This patch removes this depencency. If the user want to use
> > > > > > some wic=20
> > > > > > partitions to be packed into .swu bundle, they could simply
> > > > > > add=20
> > > > > > directly add "wic" or "wic.xz" to IMAGE_FSTYPE.
> > > > > >=20
> > > > > > Signed-off-by: Uladzimir Bely <ubely@ilbers.de>
> > > > > > ---
> > > > > > =C2=A0classes/swupdate.bbclass | 2 +-
> > > > > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >=20
> > > > > > diff --git a/classes/swupdate.bbclass
> > > > > > b/classes/swupdate.bbclass index=20
> > > > > > 9a4d509..6f034c1 100644
> > > > > > --- a/classes/swupdate.bbclass
> > > > > > +++ b/classes/swupdate.bbclass
> > > > > > @@ -31,7 +31,7 @@ SWU_SIGNATURE_TYPE ?=3D "rsa"
> > > > > > =C2=A0
> > > > > > =C2=A0SWU_BUILDCHROOT_IMAGE_FILE ?=3D
> > > > > > "
> > > > > > ${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))
> > > > > > }"
> > > > > > =C2=A0
> > > > > > -IMAGE_TYPEDEP:swu =3D "wic
> > > > > > ${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
> > > > > > +IMAGE_TYPEDEP:swu =3D
> > > > > > "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
> > > > > > =C2=A0IMAGER_INSTALL:swu +=3D "cpio ${@'openssl' if
> > > > > > bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> > > > > > =C2=A0
> > > > > > =C2=A0IMAGE_SRC_URI:swu =3D "file://${SWU_DESCRIPTION_FILE}.tmp=
l"
> > > > >=20
> > > > > Oops, this almost fell through the cracks.
> > > > >=20
> > > > > I'm indeed not seeing anything in this class referencing wic,
> > > > > so this removal seems logical to me. I'm just concerned if we
> > > > > have downstream users relying on >it and then seeing a hard
> > > > > to
> > > > > understand error. Any thoughts?
> > > >=20
> > > > Downstream layers need to adapt to the new interface anyways
> > > > (if
> > > > they don't use the plain version provided by CIP).
> > > > The .wic is not needed and should be removed.
> > > >=20
> > > > Acked!
> > > >=20
> > >=20
> > > Thanks, applied now.
> > >=20
> >=20
> > ...and dropped again. Seems this requires rebasing or some other
> > tuning,
> > see e.g.
> > https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/4418633832
> >=20
> > Jan
> >=20
>=20
> Reproduced the issue locally, for one of failing targets, `kas-
> cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml`
>=20
> It seems the problem is not directly related to removing "wic" but to
> missing dependencies. Task `do_image_swu` finally failed with the
> following message:
>=20
> ```
> sha256sum: /home/builder/cip-core-image-qemu-
> amd64/work/swu/linux.efi:
> No such file or directory
> ```
> Default value of=C2=A0 SWU_ADDITIONAL_FILES is "linux.efi
> ${SWU_ROOTFS_PARTITION_NAME}" but the recipe that provides
> "linux.efi"
> is built later due to some missing dependency.
>=20
> Without any changes in the code, build was OK on second (or third)
> attempt.
>=20

Prepared and sent patch v2 where restored swu dependency on wic image
for targets with efibootguard (swupdate bundle depends on "linux.efi"
file in deploy dir that is created by do_image_wic).

