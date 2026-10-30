Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8509.1793356454815612615
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Oct 2026 03:34:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Zv8xRr3w;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43AE9109278;
	Fri, 30 Oct 2026 11:34:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793356448;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IVw9G3X9zw30sjXQ2fT2ZmC12oPX8Gx6utn9r2uRnp8=;
	b=Zv8xRr3w3DOYTUsUyCnwyAq0xWDIxebNMXS8FPTwdqTiQfI+DwKvhUy7tp0NVquJXFRIM7
	XOWCEgcCM80kZebAD5DfJU0dmgkv9hVBiCX5YdtNTjkUGn0McxugdX/HnVtut2AxTz+B7Q
	ZOMWno1+K0mxYTivxr1cSHEBuZEOWMGaW4tB0XTMj03L6sTOn/gpkey5G19CgH16tOoCTW
	A27VJUOfz1MdSbeyPECZYG/S2lP5uKY8sejE3lTaVzwMW9/hGqQbKMJB1WrGHPGu+v3onW
	qeL+C0hdytt+krNLdPfeaTdqshKn1czrMuLtgE50PeDTe8nY6EQDs+drckORjA==
Date: Fri, 30 Oct 2026 11:34:04 +0100
From: Pavel Machek <pavel@nabladev.com>
To: florian.bezdeka@siemens.com
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Ulrich Hecht <uli@fpond.eu>, Pavel Machek <pavel@nabladev.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"Kowalsky, Clara (T CED SES-DE)" <clara.kowalsky@siemens.com>
Subject: Re: [cip-dev] CVE-2026-98432 and CIP
Message-ID: <auRynJ4kOMaSdpvC@duo.ucw.cz>
References: <27271c84-9136-43d0-9769-bf45500f8946@siemens.com>
 <8a1ccfa3242ed0941606b8e3b398d5edb72faec9.camel@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qLXJxNzA9X+96uis"
Content-Disposition: inline
In-Reply-To: <8a1ccfa3242ed0941606b8e3b398d5edb72faec9.camel@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 10:34:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24585


--qLXJxNzA9X+96uis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > there has been some media coverage like [1] on this two weeks old=20
> > vulnerability [2] which is reported as "remote exploitable". Assessment=
s=20
> > still seem vary, though the tendency is "increasing criticality".
> >=20
> > The issue apparently depends on CONFIG_MPTCP enabled, and that is=20
> > fortunately not the case in most CIP kernel configs. Furthermore, this=
=20
> > feature did not even exist in 4.19 and 4.4.
> >=20
> > Still, we do have CONFIG_MPTCP enabled for 6.12.y-cip/x86 in [3]. I'm=
=20
> > clarifying with our colleagues if that was by intention. The next 6.12-
> > cip release is due today, and we should then also pick up the related=
=20
> > upstream stable patch [4] very soon.
>=20
> It's enabled to keep feature parity with the Debian kernel
> configuration.=20

Please disable unused config options. "Feature parity with Debian"
should not be consideration, because that way, you'll get the security
holes, too.

> As the name of this configuration indicates, it's about server class
> hardware in this case. It's hard to predict what end users will run on
> those systems. That's the main reason why we try to stay as close as
> possible to the Debian configuration.
>=20
> In this case I doubt that it is used at the end. Servers are normally
> single-homed and do not require any multi path TCP. On the other hand we
> will have to update anyway, so it can stay enabled.

Disable unused config options, so we can focus efforts on maintaining
config options that are actually used.

Best regards,
								Pavel

--qLXJxNzA9X+96uis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauRynAAKCRAw5/Bqldv6
8kzLAKCGketfb351ON8om5vEMtokm16ubgCggougsCe2I24vK/YaL0q9HJMuYPg=
=Hu+K
-----END PGP SIGNATURE-----

--qLXJxNzA9X+96uis--
