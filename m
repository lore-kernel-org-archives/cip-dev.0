Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3543.1794950784612637243
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 13:26:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=F1nL4mW4;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2DA8510F8CA;
	Tue, 17 Nov 2026 22:26:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794950778;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BYQO8SoG2zjG6pzdS54zNu0xtcSedsJpk9uvoCE1iEc=;
	b=F1nL4mW4QzjRAvi0ldc479Nc2Jrk7OU8OgHy8LYtNO6RJH3CGqHz614vvTGQNbmj/5lo+K
	c+kzpwfl2hiqSFOIo01+zS4cqSzYxap6OItU4YGWti7W2dDRuCaVnU1dem4NB9eYpkyUGo
	qb1sjCfvh2N8daOOGMIdH2J3WRTvZayTTbNCMJ1Nfe529mkbTLgG2upfar+jshaxZ2Tmz8
	F8gSU5TBHu3HG64+rlMTpCYcPgck5pkSg0Yxm+U/c0EXGZxGy3g/K/F+9HibPycFVoDVVe
	RvFEn+WT2QChXiy8E7QAheO3+wW+MtUnV6O/F9RuP2uEBVfBnG1/G0TKdELjdA==
Date: Tue, 17 Nov 2026 22:26:14 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
	cip-dev <cip-dev@lists.cip-project.org>,
	Pavel Machek <pavel@nabladev.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Ulrich Hecht <uli@fpond.eu>
Subject: CVE-2026-99288: Re: [kernel-cve-report] New CVE entries this week
Message-ID: <avzGdm2kkPzk8cLD@duo.ucw.cz>
References: <CAODzB9rb+qvRFhe8UcFY2Pt-j82sqgpS=mfc4NbCrbdwww2Tpw@mail.gmail.com>
 <4b4745fa-2a9e-48ea-996f-fff98ffec832@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kYEYZhb8QDJz723y"
Content-Disposition: inline
In-Reply-To: <4b4745fa-2a9e-48ea-996f-fff98ffec832@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 21:26:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24948


--kYEYZhb8QDJz723y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > CVE-2026-99288: inet: reject unhashed sockets during established lookups
> >=20
> > Announce: https://www.cve.org/CVERecord?id=3DCVE-2026-99288
> >=20
> > Introduced commit is not determined.
> > Introduced by 079096f ("tcp/dccp: install syn_recv requests into ehash
> > table") in v4.4-rc1.
> >=20
> > Fixed status
> > mainline: [4e2b3ef19e0e04adca38442f07dd6bc93c712bf1]
> > stable/6.12: [d69100340b4cae08d40f898f1b601032403f6be6]
> > stable/6.18: [8e5172cbd227fae32f3313cba1f3e1b9edb5c4fd]
> > stable/7.3: [eb8a2d156f2c1d862fffdfd1b3432bfbcd939879]
> >=20
>=20
> This one is gaining attention now ("NoisyTCP") because it allows remote
> DoS in default configurations. Score: 7.5. Are handling this
> specifically already?

I tried to do a quick research, and this seems to be more of server
issue, and may be hard/impossible to exploit in embedded
systems. Researcher's writeup seems to be at
https://github.com/V4bel/NoisyTCP . Quoting "so it can be triggered
against servers that have two or more RX queues, or where RPS
distributes packets across multiple CPUs."

sudo sysctl -w net.ipv4.tcp_syncookies=3D0 was cited as possible
workaround.

If someone believes their machine are in danger, please let us know.

We could do 6.12-cip fairly easily, older would be more tricky as
there was no suitable -stable release. But I don't think this is "as
bad" as bugs we did extra releases for.

Best regards,
							Pavel

--kYEYZhb8QDJz723y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavzGdgAKCRAw5/Bqldv6
8lxKAJwMobb7E9Q3Z5fj7KoE6utl4/jUNQCgvIA+FTtGPlyr4JFpvXeJSUayWZc=
=Qc+P
-----END PGP SIGNATURE-----

--kYEYZhb8QDJz723y--
