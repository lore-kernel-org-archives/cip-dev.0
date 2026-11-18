Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1388.1795021151050715889
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:59:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=ex11XTxA;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5632510FA5E;
	Wed, 18 Nov 2026 17:59:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795021144;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=t+ihe1yhT+76h7CDlhh5eOIICAXaUEP5/rulTOZw+B8=;
	b=ex11XTxAfxZGSQ6jT47eumthacqGHCd0/hDdWoZcJuHHBj/2Z5v/lscC7q2Cyhh699B6XR
	wceI3Do+YYw2kp6Mxf/AWv/50teSUUoXNMepIWpZRP/NmFUtdxe/m6zTBHUZ91fYczV/Pz
	9DpOp9TtwhXTQEi/qXurb9SKMHFa5Wcv/6bFAoXgpuyB305cSRLI2wRbgjIbzX9YfGFE7N
	YC/k5joh6skdo3sNzw/QGU3Chd8TnJ4Wp2PgTjrZveLDkiyz59EEwAzzAIPAqU2ABGk5WC
	3CL5eCccvMN/NlUP04rENjd+fSSQQAaR3MuKkoQivKyHuXRNLPsXwHwX5Ie3ig==
Date: Wed, 18 Nov 2026 17:58:59 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@nabladev.com>,
	Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
	cip-dev <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Ulrich Hecht <uli@fpond.eu>
Subject: Re: CVE-2026-99288: Re: [kernel-cve-report] New CVE entries this week
Message-ID: <av3ZUzcCn01qH4YJ@duo.ucw.cz>
References: <CAODzB9rb+qvRFhe8UcFY2Pt-j82sqgpS=mfc4NbCrbdwww2Tpw@mail.gmail.com>
 <4b4745fa-2a9e-48ea-996f-fff98ffec832@siemens.com>
 <avzGdm2kkPzk8cLD@duo.ucw.cz>
 <63257a1a-dcbd-46ea-958d-fd4fc876cd2e@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BY/HXw4acxROeI2s"
Content-Disposition: inline
In-Reply-To: <63257a1a-dcbd-46ea-958d-fd4fc876cd2e@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:59:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24999


--BY/HXw4acxROeI2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I tried to do a quick research, and this seems to be more of server
> > issue, and may be hard/impossible to exploit in embedded
> > systems. Researcher's writeup seems to be at
> > https://github.com/V4bel/NoisyTCP . Quoting "so it can be triggered
> > against servers that have two or more RX queues, or where RPS
> > distributes packets across multiple CPUs."
>=20
> Just to be clear: We have server-like scenarios in scope as well.
> "Embedded" does not imply a specific size of the system or
> performance.

I know. I'm just saying people should not really be running
"crash-me-if-you-can.com" webserver on 4.4-cip (on public internet).

> > sudo sysctl -w net.ipv4.tcp_syncookies=3D0 was cited as possible
> > workaround.
> >=20
> > If someone believes their machine are in danger, please let us know.
> >=20
> > We could do 6.12-cip fairly easily, older would be more tricky as
> > there was no suitable -stable release. But I don't think this is "as
> > bad" as bugs we did extra releases for.
>=20
> Can we support on this, or is this ongoing work already (<6.12)?

-rc1 of -stable kernels was just announced, so I assume we should have
suitable 6.1-stable and 5.10-stable with the fix, soon.

Unless someone tells me otherwise, I can do 6.12-cip "soon" and
6.1-cip / 5.10-cip "soon" once -stable kernels are released.

Best regards,
								Pavel

--BY/HXw4acxROeI2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCav3ZUwAKCRAw5/Bqldv6
8g6pAJoC4TsVqIb4WVgH34ImyoOhZRZUyQCgsTwmVqEgY+/Y7hWPAQgaCiccenQ=
=trd/
-----END PGP SIGNATURE-----

--BY/HXw4acxROeI2s--
