Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6496.1792760804228799988
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Oct 2026 06:06:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=UvfagDNG;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84E8A10AEE2;
	Fri, 23 Oct 2026 15:06:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792760797;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=AtkM1EdovWsN763XTuKwrJQ3XJ/JgsZb+1BmQEP44NM=;
	b=UvfagDNGh9kLMrLm6b+nFfCBP+HguVR+uMzNvDE2GrrEKvIWFxUCsja4nDf9cupbuU+PEO
	c4glKizOX61IlydrCTojBta5K2LiD4dc7IxxBF3P/f+oUcB60NBx1mMWjuTFtSeLAI17Bq
	Q1yBT+YJfRlJXVkrK0TMrLsYJTzr1YNylPqRrGHkXve8+wWR0phuvCzBjy6q40CJZw/Zgn
	WqwBbGtyDl+X72LQRIrU/u4aNXlWhvC6CFGBL4VXb3Br37/IvMdVS9aT0PdFobRt3vkH/g
	wxdFAiTR5PrZWmriumKu7twioYORQKkxVqRwkhk140XQL8HAfeuxViefRhyVDg==
Date: Fri, 23 Oct 2026 15:06:34 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: pavel@nabladev.com, biju.das.au@gmail.com,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/5] Add RZ/G3L RSCI support
Message-ID: <attb2l3tgBf9GuLG@duo.ucw.cz>
References: <20261022134021.217964-1-biju.das.au@gmail.com>
 <atpr2xe3h0fPVx3X@duo.ucw.cz>
 <TY7PR01MB148186B8C06F49B31B84D9366CD642@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WQP9f+qOlNuaHk20"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148186B8C06F49B31B84D9366CD642@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 23 Oct 2026 13:06:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24520


--WQP9f+qOlNuaHk20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch series aims to enable RSCI support on RZ/G3L SMARC EVK.
> > > All the patches in this series are cherry-picked from mainline.
> >=20
> > This looks okay to me.
> >=20
> > Reviewed-by: Pavel Machek <pavel@nabladev.com>
> >=20
> > I can apply the series if it passes testing and there are no other comm=
ents.
>=20
> I reviewed this series, looks good to me too.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thank you, I added your tag and applied the series.

Best regards,
							Pavel

--WQP9f+qOlNuaHk20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCattb2gAKCRAw5/Bqldv6
8rXoAJ9lYK7UUSaBz538JfDQk/S3k+jqsQCgtg31P88rWP3K+X9C57OZ5iiDwNk=
=mJSN
-----END PGP SIGNATURE-----

--WQP9f+qOlNuaHk20--
