Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27ABBC77B60
	for <webhook@archiver.kernel.org>; Sun, 30 Apr 2023 09:54:31 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.65630.1682848465771973395
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Apr 2023 02:54:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 03C941C0E60; Sun, 30 Apr 2023 11:54:22 +0200 (CEST)
Date: Sun, 30 Apr 2023 11:54:21 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: Request for reviews for 4.4-st40, 4.4-cip75
Message-ID: <ZE46zUIujMJ+7/dI@duo.ucw.cz>
References: <1785763423.1934045.1682608850821@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MvqqBew1Bt+we1mQ"
Content-Disposition: inline
In-Reply-To: <1785763423.1934045.1682608850821@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 30 Apr 2023 09:54:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11371


--MvqqBew1Bt+we1mQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4-st40 and 4.4-cip75 rel=
eases that should be reviewed, and that can currently be found in https://g=
it.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3Dlinux-4.4=
=2Ey-st-rc
>=20
> Trivial backports:

These seem ok.

a | 3c29c13c3 968b66 o+ | hwmon (it87): Fix voltage scaling for chips with =
10.9mV ADCs
a | 36bfbaa29 b871cb .+ | ALSA: hda/conexant: Partial revert of a quirk for=
 Lenovo
a | 1487976d3 c17f8f f  | ALSA: hda/sigmatel: add pin overrides for Intel D=
P45SG motherboard
a | 078465f34 bf8493 .+ | coresight-etm4: Fix for() loop drvdata->nr_addr_c=
mp range bug
a | bff19445c ef8327 o  | nilfs2: initialize unused bytes in segment summar=
y blocks

Can you doublecheck these?

> ** m | e10703fd5 5d8d4a o+ | arm64: KVM: Fix system register enumeration

AFAICT kvm_arm_copy_core_reg_indices() does not have the problem
described in the changelog, so no change is
neccessary. copy_timer_indices() in 4.4 always return 0 or -EFAULT, so
it does not need changing, either.

> ** m | 3d081d862 c86c00 o+ | i40e: fix i40e_setup_misc_vector() error han=
dling

AFAICT this should be going to end_unlock.

> Not completely trivial backports:

They seem ok.

a | 38d976de6 621489 o+ | hvc/xen: prevent concurrent accesses to the share=
d ring
a | 1629f6f52 90410b o+ | ocfs2: fix data corruption after failed write

> This is a rather convoluted way to insert a missing prerequisite. It had =
to be backported because the reverted patch was also a manual backport:

Yep, I seen the "fun" in newer kernels. No problems found here.

a | 65cb67402 67d7d8 o  | Revert "ext4: fix use-after-free in ext4_xattr_se=
t_entry"
a | 0a8cff7f0 310c09 o  | ext4: remove duplicate definition of ext4_xattr_i=
body_inline_set()
a | 322d238b7 67d7d8 o  | ext4: fix use-after-free in ext4_xattr_set_entry

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--MvqqBew1Bt+we1mQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZE46zQAKCRAw5/Bqldv6
8jF+AJ4pyEgl/evXeEegM2BXlSceHWylegCfabrjogX8N0r/yBeECDQoMU68iHU=
=Hbys
-----END PGP SIGNATURE-----

--MvqqBew1Bt+we1mQ--

