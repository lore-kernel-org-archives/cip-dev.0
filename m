Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB44EB64DA
	for <webhook@archiver.kernel.org>; Sat, 22 Jul 2023 11:31:17 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.3684.1690025475689173497
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Jul 2023 04:31:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 12A281C0A92; Sat, 22 Jul 2023 13:31:13 +0200 (CEST)
Date: Sat, 22 Jul 2023 13:31:12 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip] pinctrl: renesas: rzg2l: Handle non-unique
 subnode names
Message-ID: <ZLu+AAp7waAEQZzv@duo.ucw.cz>
References: <20230721095859.280864-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7a264odulWjYyVsd"
Content-Disposition: inline
In-Reply-To: <20230721095859.280864-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Jul 2023 11:31:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12494


--7a264odulWjYyVsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Currently, sd1 and sd0 have unique subnode names 'sd1_mux' and 'sd0_mux'.
> If we change these to non-unique subnode names such as 'mux' this can
> lead to the below conflict as the RZ/G2L pin control driver considers
> only the names of the subnodes.
>=20
>    pinctrl-rzg2l 11030000.pinctrl: pin P47_0 already requested by 11c0000=
0.mmc; cannot claim for 11c10000.mmc
>    pinctrl-rzg2l 11030000.pinctrl: pin-376 (11c10000.mmc) status -22
>    pinctrl-rzg2l 11030000.pinctrl: could not request pin 376 (P47_0) from=
 group mux  on device pinctrl-rzg2l
>    renesas_sdhi_internal_dmac 11c10000.mmc: Error applying setting, rever=
se things back
>=20
> Fix this by constructing unique names from the node names of both the
> pin control configuration node and its child node, where appropriate.
>=20
> Based on the work done by Geert for the RZ/V2M pinctrl driver.

Looks okay to me, and I can apply it if it passes testing and there
are no other comments.

I believe we want this for 6.1, too. I can apply it there, too.

There was quite a lot of patches recently; I believe we handled all of
them, but let me know if we did not.

If there's something in 5.10 we don't have in 6.1, we want to fix
that, too.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7a264odulWjYyVsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLu+AAAKCRAw5/Bqldv6
8mWGAJ434+A4bQf/q4c7LWd9DEZ6io4EzgCgwA132hFcHEXLMWWcQcLwz7wdQec=
=1FhW
-----END PGP SIGNATURE-----

--7a264odulWjYyVsd--

