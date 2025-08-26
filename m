Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69775CA0EFA
	for <webhook@archiver.kernel.org>; Tue, 26 Aug 2025 07:39:54 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.59315.1756193984652274940
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Aug 2025 00:39:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=I+ABfzG2;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E47391038C102;
	Tue, 26 Aug 2025 09:38:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1756193982; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=T2QAWWafrd8Ck++jbiYY2oybAmc7sEObYcXmNh7NA5k=;
	b=I+ABfzG2vnIFz6qpiYQIapPYjJv64mT8ufBEIzvqAyruO1FZ6GnLsHN3L516mulsnyGqvs
	0YDpv1U5JPgOMMmCPFExuoHCSdWFsOIJY+zAvvhpQzyEfUrXopUE7Duj/HAdVDA7dOXCYt
	f8Kstr4TyvZfDIW7IVNVfUwW5McSH5PpZTAcGVSw1LeyrE5DyR/GgJTaHCMQmrXjZX5cYF
	GeM7U8L75yVj0oKsMLdf/EFmB/Y0hepH6xkMfgjv3uWOFBYIxIs6DwEjtqYuSInrifJTw+
	+hmWDUxeym0u6d0tJ04GA0r4NEKw98ce2edcCMeH9841LyR2tmhRcZIa3FooAg==
Date: Tue, 26 Aug 2025 09:38:41 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>
Subject: Re: [PATCH 6.1.y-cip 55/55] media: i2c: ov5645: Set
 V4L2_SUBDEV_FL_HAS_EVENTS flag
Message-ID: <aK1kgYt6kjQFmEIT@duo.ucw.cz>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
 <20250820160413.801341-56-tommaso.merciai.xr@bp.renesas.com>
 <aKhWKC0G6Q9UBkWA@duo.ucw.cz>
 <TY3PR01MB11948A3D133C865A23ACAB261E03EA@TY3PR01MB11948.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ukq3FlPn/5CYV58C"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11948A3D133C865A23ACAB261E03EA@TY3PR01MB11948.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Aug 2025 07:39:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19963


--Ukq3FlPn/5CYV58C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > The ov5645 subdev can generate control events, therefore set the
> > > V4L2_SUBDEV_FL_HAS_EVENTS flag.
> > >
> > > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> >=20
> > This misses "upstream XXX" marking, and likely some sign-offs, too.
>=20
> Same, sorry this was added by me to pass the v4l2-compliance into 6.1-cip=
 kernel.
>=20
> Let me gently know if you want me to send v2 for fixing the series or
> you can take care while applying. Thanks in advance.

I'm currently traveling and have problems with internet access.

I don't believe I need new series, I can just take patches 1..48 from
the series.

I would not mind getting Reviewed-by from others here.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Ukq3FlPn/5CYV58C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaK1kgQAKCRAw5/Bqldv6
8lY2AJ9Ho7dkP4FQVtymWOyVmdvfApQvGACfaB5vc1qMYDhwUbJwGu+PJ1TNnlE=
=ZU3Z
-----END PGP SIGNATURE-----

--Ukq3FlPn/5CYV58C--

