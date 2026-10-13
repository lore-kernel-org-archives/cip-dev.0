Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A49CA9ED2
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 13:11:03 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6835.1791897056316280527
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Oct 2026 06:10:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=URIcJbOw;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A4006108E98;
	Tue, 13 Oct 2026 15:10:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1791897049;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=U6CExUSNqbz9EdvWoFGSnZY2XDwjEXrzSIGkojQTLgU=;
	b=URIcJbOwEXxR+q1VewHneFQuRswNd/HyGETHzK74TPswqG0TTyz5OcW4aEv8ZecrYEHMes
	I8pspsEv00zaW43r1h96gR1pGSNQ0i5qJcrCwB71bmAlaaF0mB0DXWQUF89TfPOjC0G7Wl
	Ref8o9/vZJ5OA3LDCHayf9jG0oVH9tIESHWKWmkdT8z2ZxcXmHGZl+Y49AZWZobrE4qp0s
	Ar1IJ1j42ipmFvgGmFifXLasItBpGaQ3XrqCbo8mrisy3rmisFmwd5sbQcjkfS3vD20TxO
	4PMVIXsz9sFvNqDKmP20w7a7sRG2nZj75TpnN+GUMaMMD4KjMCVWvUsJ9SvECg==
Date: Tue, 13 Oct 2026 15:10:45 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 5.10.y-cip v3] PCI: rzg3s-host: Fix compilation
 warning
Message-ID: <as4t1cyscqLGSdg6@duo.ucw.cz>
References: <20261002141124.2402765-1-claudiu.beznea@tuxon.dev>
 <OS7PR01MB1480829D2B2DA4FCC97978D98CD9E2@OS7PR01MB14808.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D21+GJ6oJRg8WIIq"
Content-Disposition: inline
In-Reply-To: <OS7PR01MB1480829D2B2DA4FCC97978D98CD9E2@OS7PR01MB14808.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Oct 2026 13:11:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24449


--D21+GJ6oJRg8WIIq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >=20
> > Fix the following compilation warning:
> >=20
> > pcie_rzg3s_host.c: In function =E2=80=98rzg3s_pcie_probe=E2=80=99:
> > ../drivers/pci/controller/pcie-rzg3s-host.c:1558:2: warning: ISO C90 fo=
rbids
> > mixed declarations and code [-Wdeclaration-after-statement]
> >  1558 |  struct rzg3s_pcie_host *host;
> >       |  ^~~~~~
> >=20
> > Fixes: c5249a6594d6 ("PCI: Add Renesas RZ/G3S host controller driver")
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > ---
> >=20
> > Changes in v3:
> > - fixed it by dropping ';'
> >=20
> >  drivers/pci/controller/pcie-rzg3s-host.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> Looks good to me. I can apply this if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Thank you,
								Pavel

--D21+GJ6oJRg8WIIq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCas4t1QAKCRAw5/Bqldv6
8uJ7AJ9Nro7uG93RXDSktg1degGQKMQ5/gCgjBehEgvRsolJpaXBs1W4bzO0nf8=
=0AuN
-----END PGP SIGNATURE-----

--D21+GJ6oJRg8WIIq--

