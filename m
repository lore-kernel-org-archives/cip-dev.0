Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2950.1794217921978425789
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 01:52:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=ad8DEh83;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B76B510C073;
	Mon, 09 Nov 2026 10:51:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794217915;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=SLCsYcnR1xL/6JpgXLOYa1WqcaWS9ARB3E97+30sEFA=;
	b=ad8DEh838CL9f3/P8OuGkoH7vof2gIw2qFrFuO+GUC0KV91E+WvIVz2CMxGqtL9Jv3X+Hf
	pe8sSP+tIx1EH491toLx4TGjNxmQPLlmwLOWMaxGM1AqJQaOORU5XrkcpAUZiW8Lsuvz5H
	qQtq1Yc4dHAHDWYQbQPAUl3XeDbRtJQGuN2jiKMuZvujAdMix6QhnrSkXJFgoqKr/tg6L8
	+5vsjUZUiLLmePxWhYuIAP4bd4CENiVR7geX3SNlkMOlZ/OWUBeNUcAfNaTVDtZocqiy7S
	JF1/3ii9x2ecL65oqb0f+zRaw0nKBUHUTUnmhkQwwHYvebCwvPkUn6L/wZsRxg==
Date: Mon, 9 Nov 2026 10:51:52 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba, uli@fpond.eu
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@nabladev.com, uli@fpond.eu, biju.das.jz@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] mmc: renesas_sdhi: abort tuning
 when timeout detected
Message-ID: <avGXuLpdFa9CzeeK@duo.ucw.cz>
References: <20261029121432.4909-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY7PR01MB148182531E8307BD3B1211C01CD732@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u08o1HzOGhmT3RsD"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148182531E8307BD3B1211C01CD732@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 09:52:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24694


--u08o1HzOGhmT3RsD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >=20
> > commit 2c9017d0b5d3fbf17e69577a42d9e610ca122810 upstream.
> >=20
> > We have to bring the eMMC from sending-data state back to transfer stat=
e once
> > we detected a CRC error (timeout) during tuning. So, send a stop comman=
d via
> > mmc_abort_tuning().
> >=20
> > Fixes: 4f11997773b6 ("mmc: tmio: Add tuning support") Reported-by Yoshi=
hiro
> > Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Reviewed-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>
> > Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Link:
> > https://lore.kernel.org/r/20210602073435.5955-1-wsa+renesas@sang-engine
> > ering.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > [PL: manually applied the changes]
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> I reviewed this series, looks good to me.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Patch looks okay to me, too. Adding Ulrich to the cc.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
								Pavel

--u08o1HzOGhmT3RsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavGXuAAKCRAw5/Bqldv6
8nn1AJ9da0kCBv8bzAQx74+TIWm6kWsNZACgqarHkoDwsTASOEe9XG1xvG1DNTA=
=iuzM
-----END PGP SIGNATURE-----

--u08o1HzOGhmT3RsD--
