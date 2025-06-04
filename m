Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF2DC5B543
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 18:13:05 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.23917.1749060780737461334
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 11:13:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Gt64o1r4;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A450810397298;
	Wed,  4 Jun 2025 20:12:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1749060778; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ei4SefK9seh4N2EwIrTZGDms523uvpAK6WHjv03DWyg=;
	b=Gt64o1r4hgVR2OsTZnGetxefwj3IrpbibtSGmCosl34KY5FSMB9raX4Cm0IUmWbdWJHc6V
	PloFL3gaKLm0JpVYSSzTV9/z+PpvTUzgMWKgdj3JwQbUdTCn/mIiBXUZ1fhCa4YQO6t4Wo
	pems9HJfGYkxaeGhYrVrRQIwkcD+a8WnsAO+H4CU/4fnqw2mfYFQmLXUVtIDocVyH1JV0Q
	0DndGDKhCUuF5OTB1yXXb8BKZt/9JsA88t7vxEtRdO55MAcvxneLKeV17uKUfIg/ifPzy3
	wLLDZ90IzAlaxLcPMNXi53XJ5DJ1Qb2mw9STi/vCdb7y+WlhNuVXLuiZm7KxPg==
Date: Wed, 4 Jun 2025 20:12:52 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: claudiu.beznea@tuxon.dev, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 0/7] RZ/G3S: Backport SCIF support
Message-ID: <aECMpJr2f7SgjTtD@duo.ucw.cz>
References: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB148189C9477EF3A5FA4C5AD0C926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uT8GehmkcQ1oox/M"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148189C9477EF3A5FA4C5AD0C926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 18:13:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19013


--uT8GehmkcQ1oox/M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Series backports the Renesas RZ/G3S SCIF support to v6.12.y CIP.
> >=20
> > Thank you,
> > Claudiu Beznea
> >=20
> > Claudiu Beznea (6):
> >   clk: renesas: r9a08g045: Add clock, reset and power domain for the
> >     remaining SCIFs
> >   serial: sh-sci: Update the suspend/resume support
> >   arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
> >   arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe
> >     different switches
> >   arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
> >   arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1
> >=20
> > Geert Uytterhoeven (1):
> >   serial: sh-sci: Save and restore more registers
> >=20
> >  arch/arm64/boot/dts/renesas/Makefile          |  3 +
> >  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 90
> > +++++++++++++++++
> >  .../r9a08g045s33-smarc-pmod1-type-3a.dtso     | 48 ++++++++++
> >  .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 20 +---
> >  .../boot/dts/renesas/rzg3s-smarc-switches.h   | 40 ++++++++
> >  arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 13 +++
> >  drivers/clk/renesas/r9a08g045-cpg.c           | 25 +++++
> >  drivers/tty/serial/sh-sci.c                   | 96
> > ++++++++++++++++++-
> >  8 files changed, 314 insertions(+), 21 deletions(-)  create mode 100644
> > arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod1-type-3a.dtso
> >  create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
>=20
> I reviewed this series, looks good to me.
> I can apply these, if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, I added your reviewed-by tag and applied the series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--uT8GehmkcQ1oox/M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaECMpAAKCRAw5/Bqldv6
8rfaAJ4yZLBbDk1/XJ60tnLzuRqMdP+/ZQCcDYadeCcE1Yh9Sh1ECHtwG7C9W/Y=
=yd0/
-----END PGP SIGNATURE-----

--uT8GehmkcQ1oox/M--

