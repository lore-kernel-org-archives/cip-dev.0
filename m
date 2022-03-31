Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5908CC433EF
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 10:14:10 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.5327.1648721635642478640
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Mar 2022 03:13:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3DC011C0B96; Thu, 31 Mar 2022 12:13:51 +0200 (CEST)
Date: Thu, 31 Mar 2022 12:13:50 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 04/39] mmc: renesas_sdhi: clear TAPEN when
 resetting, too
Message-ID: <20220331101349.GA21513@amd>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220330185454.10887-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20220330185454.10887-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Mar 2022 10:14:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7895


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> commit 183edc060e6969a3afe83f663b534f6324fb7e3a upstream.
>=20
> We want to clear TAPEN in a software reset, too, to have a completely
> known state. Especially when we doing the initial reset during boot to
> clear previous firmware states.
>=20

> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -558,7 +558,7 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *=
host)
>  	struct renesas_sdhi *priv =3D host_to_priv(host);
> =20
>  	if (priv->scc_ctl) {
> -		renesas_sdhi_reset_scc(host, priv);
> +		renesas_sdhi_disable_scc(host->mmc);
>  		renesas_sdhi_reset_hs400_mode(host, priv);
>  		priv->needs_adjust_hs400 =3D false;

Having half of functions receive host, priv pointers and the other
half receiving host->mmc pointer is not very nice. Is there some logic
behind that / is it possible to somehow fix?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJFft0ACgkQMOfwapXb+vKBegCgmVD2glqOd+5ylp4SMKB2nLdB
GeQAoJk5ofck14za0knOqkOd2zHznnug
=Syh6
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

