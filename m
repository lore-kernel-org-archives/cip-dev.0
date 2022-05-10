Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6E0C433F5
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 13:02:04 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.9434.1652187717772232888
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 May 2022 06:01:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0AC1F1C0B92; Tue, 10 May 2022 15:01:54 +0200 (CEST)
Date: Tue, 10 May 2022 15:01:53 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: pavel@denx.de, cip-dev@lists.cip-project.org
Subject: Re: Coordintaing -rt releases in May
Message-ID: <20220510130153.GA20410@amd>
References: <20220509120033.GA25149@duo.ucw.cz>
 <TYWPR01MB94203CED9AB8DD767CF5614D92C69@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: 
 <TYWPR01MB94203CED9AB8DD767CF5614D92C69@TYWPR01MB9420.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 May 2022 13:02:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8286


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > It is time to do -rt update but I don't see good match in releases:
> >=20
> > 5.10.109-rt65
> > 5.10.112-cip6
>=20
> We have released v5.10.109-cip5.

Ok, I created 5.10.109-based -rt release.

> >=20
> > 4.19.240-rt108
> > 4.19.239-cip72
> >=20
> > It may make sense to delay or do extra releases to get matches.
>=20
> The latest release of 4.19.y is 4.19.241, but we could release CIP
> kernel based on 4.19.240.

I believe that would be rather "strange". I could do
4.19.240-rt108-cip72 based release, but I guess it will be better to
wait for next 4.19-rt and do a matching -cip release.

Thanks and best regards,
								Pavel


--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJ6YkEACgkQMOfwapXb+vJbSgCff/VYQ53eRqm9TPKiqSuUwZLa
ywEAoJf1jieZrq/YCllPXlavtGw9BKw8
=5oDb
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

