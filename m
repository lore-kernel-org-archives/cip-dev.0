Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011D1C4167D
	for <webhook@archiver.kernel.org>; Tue,  5 Apr 2022 19:49:24 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1320.1649185568931043057
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Apr 2022 12:06:09 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 066341C0B66; Tue,  5 Apr 2022 21:06:11 +0200 (CEST)
Date: Tue, 5 Apr 2022 21:06:10 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 26/29] thermal/drivers: Add TSU driver for
 RZ/G2L
Message-ID: <20220405190610.GC27445@duo.ucw.cz>
References: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220404123553.25851-27-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <20220404123553.25851-27-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Apr 2022 19:49:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8003


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> commit 673c68bd48390dad01f7d17670de3e33b60860ac upstream.
>=20
> The RZ/G2L SoC incorporates a thermal sensor unit (TSU) that measures the
> temperature inside the LSI.
>=20
> The thermal sensor in this unit measures temperatures in the range from
> =E2=88=9240 degree Celsius to 125 degree Celsius with an accuracy of =C2=
=B13=C2=B0C. The
> TSU repeats measurement at 20 microseconds intervals and automatically
> updates the results of measurement.
>=20
> The TSU has no interrupts as well as no external pins.
>=20
> This patch adds Thermal Sensor Unit(TSU) driver for RZ/G2L SoC.

> +		/* TSU repeats measurement at 20 microseconds intervals and
=2E..
> +		 * ts_code_ave =3D (ts_code[0] + =E2=8B=AF + ts_code[7]) / 8
> +		 */

> +	/* The temperature Tj is calculated by the formula
> +	 * Tj =3D (dsensor =E2=88=92 calib1) * 165/ (calib0 =E2=88=92 calib1) =
=E2=88=92 40
> +	 * where calib0 and calib1 are the caliberation values.
> +	 */

I'd avoid using non-ASCII characters where possible. ... is not that
much longer, and that symbol should really be -.

Also comments should start with /* on separate line, but that's really
detail.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYkyTIgAKCRAw5/Bqldv6
8rR8AKCB3TTNQoCVFWG2KUK65HKnId0i+gCgokSjJuQNdU/uvBNgtRcVQEP7AfU=
=np21
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--

