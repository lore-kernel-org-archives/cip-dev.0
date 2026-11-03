Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7406.1793699161279103009
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2026 01:46:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=EjFkhr5p;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D76FF10C6C3;
	Tue, 03 Nov 2026 10:45:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793699155;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ze8zWCTJv7hraTTCUffxY5vh/ZBVQkpWunjrNV2fgek=;
	b=EjFkhr5pqq5cXRsFBLt3ZE4F5q6+dSmbKnNLR0uVdYDa+PKGFoVZHfWwVBgOfFz0xhrrEf
	epATwUh2XcOsAbvt0OT8sFdFGqinQssWZggRFAetW8IKXFqiBV4EMarUn9EbHiJ8JwbP1V
	LkvSGeX3KrsvSsFtI/vzmscHYFrnWtOMLwzm3CdiVygOWHO+hXhUgtZQP0OChSCyVlYmsf
	5NCjrA7Dl0rkIIWbz9FNZ98ZOA+I12HQ+SIByeTxDPUalxuuiZjGdzg5rx5lsSi4x+VFUJ
	2KH3jUUSYq2LzncqnHxsT8S80kZp++YWGGu0Irrc8HwNfj0zBspzLHL7JriPbg==
Date: Tue, 3 Nov 2026 10:45:51 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: pavel@nabladev.com, cip-dev@lists.cip-project.org, uli@fpond.eu,
	claudiu.beznea.uj@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 1/1] iio: adc: rzg2l_adc: Set driver
 data before enabling runtime PM
Message-ID: <aumtTx3OmX-omdaW@duo.ucw.cz>
References: <1792979104-32023-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1792979104-32023-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <at-DUZn8PsBDbxxQ@duo.ucw.cz>
 <TY7PR01MB1481833F5CB169A124842DCB0CD6E2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sNlUeh8CqshXqEv+"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB1481833F5CB169A124842DCB0CD6E2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 03 Nov 2026 09:46:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24630


--sNlUeh8CqshXqEv+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >
> > Consider moving platform_set_drvdata() immediately before
> > pm_runtime_set_autosuspend_delay().
> >=20
> > I'm okay with taking this patch, but someone should take second look at=
 the
> > mainline.
>=20
> +1, that proposed change sounds good.
> Moving it to just before runtime PM is enabled would be safer.

I applied the patch. I would still like for someone to take a look at
the mainline, as the code is quite confusing.

Best regards,
								Pavel

--sNlUeh8CqshXqEv+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaumtTwAKCRAw5/Bqldv6
8r+/AKCrAc42/Xk+JQv46IITCgwMB6hJ+QCgluWEasnXihK+F8PCDMxGoDp23s0=
=KO06
-----END PGP SIGNATURE-----

--sNlUeh8CqshXqEv+--
