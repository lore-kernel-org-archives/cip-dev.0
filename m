Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15331.1795518054371030563
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2026 03:00:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Z/S+kdvs;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD98D10F341;
	Tue, 24 Nov 2026 12:00:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795518048;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LRNgV6w9Bvam1m3iSZ3Dqk2VT7MJb38v+HPxDrq//KU=;
	b=Z/S+kdvst+qew9IqHFvXqb1a3w6vhSRaqL1CbiXQcdymMkKp615wq9PYAbzQGrkEAVTOan
	pza/JvLGfIQECxrNVAUf0qdA0T+6zJnS0aRvvKKfTiEZsq52LtZgjrHY6v2cbF7KZ8QfYf
	ghtBiUMP3zGeFie7A43TSE2QEiTBhoa6xD/jwpr9RP5dYRhQgD24X7K2ifotR1URY96oVd
	jnFFHc3E8MOsa2nVslW2fqFLe1bcAZjBlYIkXS1/LSz6OTxTtYy1Rm0nW5pO+dAsoJk07Y
	Amat88pPtL9h05BGsbvlmMNDxiI9ylt0qTyH08RI2S5sfVh5r7RiMBTMOGw3OA==
Date: Tue, 24 Nov 2026 12:00:46 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: pavel@nabladev.com, claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/34] i3c: Backport I3C support for
 Renesas RZ/G3S
Message-ID: <awVuXmUreAU_rSRU@duo.ucw.cz>
References: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
 <awStSzX0cNPoVR5E@duo.ucw.cz>
 <TY7PR01MB1481815D9A300F44E1C64853ACD442@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U0fKmrl2ZqcPn4JL"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB1481815D9A300F44E1C64853ACD442@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 11:01:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25058


--U0fKmrl2ZqcPn4JL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Series backports the I3C support for the Renesas RZ/G3S.
> > >
> > > Please provide your feedback.
> >=20
> > I'd be happier if series were closer to 20 patches than 35 or 70... but=
 I got
> > through this, and besides few poorly formatted comments, it looks okay =
to me.
> >=20
> > I can apply this if it passes testing and if there are no other comment=
s.
> >=20
>=20
> I reviewed this series, looks good to me.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thank you, applied and pushed out.

Best regards,
									Pavel

--U0fKmrl2ZqcPn4JL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawVuXgAKCRAw5/Bqldv6
8kZFAJ0U1qlNeAjPeXs6KGoZECtdEWBCawCgqxNOJM6LbaIx0AInSZ0O8WWxLos=
=VyR+
-----END PGP SIGNATURE-----

--U0fKmrl2ZqcPn4JL--
