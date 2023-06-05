Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC803C77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 15:27:13 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.11444.1685978823701129716
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 08:27:04 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9E0201C0AB3; Mon,  5 Jun 2023 17:27:00 +0200 (CEST)
Date: Mon, 5 Jun 2023 17:27:00 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 3/7] tty: serial: sh-sci: Fix end of
 transmission on SCI
Message-ID: <ZH3+xJpv4yKjc/3v@duo.ucw.cz>
References: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
 <20230605110512.111017-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oFsi1M8JYCAE6HUj"
Content-Disposition: inline
In-Reply-To: <20230605110512.111017-4-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 15:27:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11812


--oFsi1M8JYCAE6HUj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> commit f06c2a9000ebecbb461196e59ce063f742272902 upstream.
>=20
> We need to set TE to "0" (i.e., disable serial transmission) to
> get the expected behavior of the end of serial transmission.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Link: https://lore.kernel.org/r/20230412145053.114847-6-biju.das.jz@bp.re=
nesas.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Should this be done in other cases when transmit is finished/stopped?
Could this be refactored so that this code goes to sci_stop_tx()?

This would be probably just a cleanup, so it should not prevent merge.

Thanks and best regards,
									Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oFsi1M8JYCAE6HUj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZH3+xAAKCRAw5/Bqldv6
8qdCAJ0YgNBtOgCx1Xr7oaBB/H3ixRT+zQCeJXtFAFX9tyNDk2C7XeI3nZn+ZYc=
=xrt3
-----END PGP SIGNATURE-----

--oFsi1M8JYCAE6HUj--

