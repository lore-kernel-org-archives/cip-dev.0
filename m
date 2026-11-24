Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15240.1795517668242317092
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2026 02:54:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=bDVS9mfF;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8E8CF10F2B4;
	Tue, 24 Nov 2026 11:54:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795517661;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Z1ELdbD2sTpBQFbEGwFcksfa6o2LNK4e47/8v/d1+sY=;
	b=bDVS9mfFlL49eVnfveD7ksjqkoOpU62L/1sB8mT2P9Sw7fLMBbV7PCMdUhTo5Mhn248LsO
	zOKWBG0URE9s9Vpb6K2cB6IbSJdJCpaz0uePAYQdYFJoRjemIc+gSoKKyxfTqtt1MfdVHu
	hpWOl7OT51tIoSXQR2bmcFlznQPZio1aiz+dtGu9Tno5j3x4k5sOWImb5+mNfGglWYUQ/W
	2c8udyRebfXIKj1kNX2GI8u9TDQEowWA3bD96ITRoKVDkvrALX55cD/eqzz2kV/ryjE/w1
	Tzb1LhdGMMsRK+/0z2OA85hPsPIe6v3zCxRYmhvFqTvFt8bLR4hFPcFSt/Vkug==
Date: Tue, 24 Nov 2026 11:54:17 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: pavel@nabladev.com, claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/35] i3c: Backport I3C support for
 Renesas RZ/G3S
Message-ID: <awVs2ei8KJNOQklI@duo.ucw.cz>
References: <20261117115038.1485554-1-claudiu.beznea@tuxon.dev>
 <awSzpbvC6xKPC5nJ@duo.ucw.cz>
 <TY7PR01MB1481855B15236A42E8F5B7FF8CD442@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="07tq/1s8nnsS2O7I"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB1481855B15236A42E8F5B7FF8CD442@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 10:54:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25056


--07tq/1s8nnsS2O7I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Series backports the I3C support for the Renesas RZ/G3S.
> > >
> >=20
> > Looks good to me. I can apply the series if there are no other comments=
 and if it
> > passes testing.
> >=20
> I also reviewed this series, looks good to me.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thank you, I added your tag, applied, and pushed out.

Best regards,
							Pavel

--07tq/1s8nnsS2O7I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawVs2QAKCRAw5/Bqldv6
8mQpAJ9z5oAGNjCEahSoKPwiKl54O5bG0ACfRTYbtbVYdAZDB+dHciRLwOyl9qs=
=DE3P
-----END PGP SIGNATURE-----

--07tq/1s8nnsS2O7I--
