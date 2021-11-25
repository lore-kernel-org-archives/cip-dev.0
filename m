Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7FDC433EF
	for <webhook@archiver.kernel.org>; Thu, 25 Nov 2021 09:09:19 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.9859.1637831357368996102
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Nov 2021 01:09:18 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 08B531C0B7C; Thu, 25 Nov 2021 10:09:13 +0100 (CET)
Date: Thu, 25 Nov 2021 10:09:12 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries in this week
Message-ID: <20211125090911.GA3327@amd>
References: <16BAA9D56D09F20A.23256@lists.cip-project.org>
 <CAODzB9pm61qjStFZ9_GW-w-M2nqiUyrk1aR3-fJhkzfSyNpx-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: 
 <CAODzB9pm61qjStFZ9_GW-w-M2nqiUyrk1aR3-fJhkzfSyNpx-g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Nov 2021 09:09:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7013


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Fixed status
> >
> > mainline: [353050be4c19e102178ccc05988101887c25ae53]
>=20
> I attached a patch for 5.10.

Thank you.

Looks good to me,

Reviewed-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmGfUrcACgkQMOfwapXb+vI01gCgiu+DzaFvvhjuwQ/o1F1+Y7yL
MLUAn3HbxebrYRcuHk/yTFC3MdZ9sFRx
=0GA/
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

