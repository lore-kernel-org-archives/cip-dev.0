Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E29FC77B73
	for <webhook@archiver.kernel.org>; Tue,  2 May 2023 09:41:49 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.124820.1683020501404649311
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 May 2023 02:41:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A865B1C0AAC; Tue,  2 May 2023 11:41:37 +0200 (CEST)
Date: Tue, 2 May 2023 11:41:37 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Subject: Re: [cip-dev] Request for reviews for 4.4-st40, 4.4-cip75
Message-ID: <ZFDa0eQR2hhBZYBP@duo.ucw.cz>
References: <1785763423.1934045.1682608850821@webmail.strato.com>
 <ZE46zUIujMJ+7/dI@duo.ucw.cz>
 <2033971969.2306363.1683017459015@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U7waQ/K7R4PjZVb+"
Content-Disposition: inline
In-Reply-To: <2033971969.2306363.1683017459015@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 May 2023 09:41:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11374


--U7waQ/K7R4PjZVb+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > AFAICT kvm_arm_copy_core_reg_indices() does not have the problem
> > described in the changelog, so no change is
> > neccessary. copy_timer_indices() in 4.4 always return 0 or -EFAULT, so
> > it does not need changing, either.
>=20
> Indeed; I'll drop it.

Thank you.

> > > ** m | 3d081d862 c86c00 o+ | i40e: fix i40e_setup_misc_vector() error=
 handling
> >=20
> > AFAICT this should be going to end_unlock.
>=20
> There is no end_unlock, because their is no lock here in 4.4.
> (That's why it needed a backport in the first place.)

Sorry about this, you are right, I was likely looking at wrong
version.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--U7waQ/K7R4PjZVb+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZFDa0QAKCRAw5/Bqldv6
8t+5AJ4+u4YlVuOI+pmpgWyGdFLv2Np6pgCfafZFUIDCaWWCOggx5479S7EEYR0=
=fPqU
-----END PGP SIGNATURE-----

--U7waQ/K7R4PjZVb+--

