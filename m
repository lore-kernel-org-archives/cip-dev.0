Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16068.1795521158011976258
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2026 03:52:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=cLy6rMa1;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9054510F234;
	Tue, 24 Nov 2026 12:52:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795521152;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=TYfQU0JiP84nzJoiDln/OE5499TIh0+o69nREuxS8es=;
	b=cLy6rMa1oUIus/aB5SgywVvuxOluJHMYFy43HlRBxH+wQDVCTSagzDY9gIU7er8ZFMFpsQ
	fox0yc8n9pwZiG82QJTtCB3Y6HJSdwM69ZGG8l7U30DBVc4vig5uNVJ8tUufmvHKWIi7+m
	UlmhMmuyu5UXYhSF+IE/UW3Xtyb/b27w8i2THEt7akQwk655MIwBHS8++ovFM1FR5ollT4
	5s8jjAE5PA077ahjuyGiT3y0F1SKv4rS1HYPmMgs0QPScTcm1wo2oykxDt7uacBSqnj7fL
	FIq6QhtO5wHWLCwUnJKIEekthhrpwv4oINabezG17dQBi/GayCJZd45IaKNt9g==
Date: Tue, 24 Nov 2026 12:52:29 +0100
From: Pavel Machek <pavel@nabladev.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org,
	pavel@nabladev.com
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/69] i3c: Backport I3C support for
 Renesas RZ/G3S
Message-ID: <awV6ffvCg6wqqpoi@duo.ucw.cz>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
 <TY7PR01MB14818259F230784C9BEE2DDD7CD442@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <ea842856-92ca-4df1-a28e-1abf85d5c524@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g6MMQtP5/3VHq7D0"
Content-Disposition: inline
In-Reply-To: <ea842856-92ca-4df1-a28e-1abf85d5c524@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 11:52:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25064


--g6MMQtP5/3VHq7D0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Please provide your feedback.
> >=20
> > We require the following commitments:
> > 510d2358c466bf6588034f0d3b2266eed2bc0a51 i3c: master: dw: stop hardcodi=
ng initial speed
>=20
> If there are no other comments on this series, would you like me to send =
it
> as reply to this thread (with --in-reply-to git-send-email option) or
> re-send the full series and add 510d2358c466 ("i3c: master: dw: stop
> hardcoding initial speed") ?

If the 510d2358c466 can goes before or after the series, just submit
it separately. Otherwise please start a new thread.

Thanks and best regards,
								Pavel

--g6MMQtP5/3VHq7D0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawV6fQAKCRAw5/Bqldv6
8mmmAKC8sqrEBOoCAwwpPl0ZXo+TKaqP/gCdE8x9ISN+/mNItM1YEywejR2tU+Q=
=4zez
-----END PGP SIGNATURE-----

--g6MMQtP5/3VHq7D0--
