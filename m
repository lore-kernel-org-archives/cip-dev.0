Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D81C43334
	for <webhook@archiver.kernel.org>; Mon, 25 Jul 2022 21:04:09 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.1307.1658783046215403277
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Jul 2022 14:04:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A65BA1C0009; Mon, 25 Jul 2022 23:04:03 +0200 (CEST)
Date: Mon, 25 Jul 2022 23:04:03 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 01/24] soc: renesas: Consolidate product
 register handling
Message-ID: <20220725210403.GC2302@duo.ucw.cz>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
 <20220715072244.2298757-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <20220715072244.2298757-2-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Jul 2022 21:04:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8906


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> commit 05b22caa7490e4f4c94bbde33c61cf72d187b8f7 upstream.
>=20
> Currently renesas_soc_init() scans the whole device tree up to three
> times, to find a device node describing a product register.
> Furthermore, the product register handling for the different variants is
> very similar, with the major difference being the location of the
> product bitfield inside the product register.
>=20
> Reduce scanning to a single pass using of_find_matching_node_and_match()
> instead.  Switch to a common handling of product registers, by storing
> the intrinsics of each product register type in the data field of the
> corresponding match entry.
>
=2E..

> +static const struct of_device_id renesas_ids[] __initconst =3D {
> +	{ .compatible =3D "renesas,bsid",			.data =3D &id_bsid },
> +	{ .compatible =3D "renesas,r9a07g044-sysc",	.data =3D &id_rzg2l },
> +	{ .compatible =3D "renesas,prr",			.data =3D &id_prr },
> +	{ /* sentinel */ }
> +};
> +


>  	match =3D of_match_node(renesas_socs, of_root);
>  	if (!match)
>  		return -ENODEV;
> =20
> +	soc_id =3D strchr(match->compatible, ',') + 1;
>  	soc =3D match->data;
>  	family =3D soc->family;
>

This is quite tricky code. ',' will always be in the compatible with
the current table, but if this ever changes, it will crash. I would
not mind something like.

	soc_id =3D strchr(match->compatible, ',');
	if (!soc_id)
	        return -EIO;
	soc_id++;

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYt8FQwAKCRAw5/Bqldv6
8qpEAJ9CbbAJTP1HW3xsJbAZOt1H8doTGACdHTRcryFlolkmQI3OxUtEwb+zN10=
=RB84
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--

