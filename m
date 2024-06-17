Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE496C27C79
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 12:03:04 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.54966.1718625777946446773
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jun 2024 05:02:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7591C1C0082; Mon, 17 Jun 2024 14:02:55 +0200 (CEST)
Date: Mon, 17 Jun 2024 14:02:54 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/8] Add Display support for SMARC
 RZ/{G2L,G2LC,V2L}
Message-ID: <ZnAl7gi8ZSC3W1Kb@duo.ucw.cz>
References: <20240614101845.40656-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FPC6aMy+hrfh4Q7T"
Content-Disposition: inline
In-Reply-To: <20240614101845.40656-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jun 2024 12:03:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16264


--FPC6aMy+hrfh4Q7T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add Display support for SMARC RZ/{G2L,G2LC,V2L}=
 EVK
> platforms.
>=20
> All the patches are cherry-picked from the mainline.

Thanks for the series. I could not find anything significant in the
review. I can apply the series if there are no other comments and if
it passes testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FPC6aMy+hrfh4Q7T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZnAl7gAKCRAw5/Bqldv6
8hc1AJ43HVOnR1ebULhjEzPcHVpT6DajYACdGNQn6XhcpAsRz7+iQZWYZjkJK6s=
=NZPm
-----END PGP SIGNATURE-----

--FPC6aMy+hrfh4Q7T--

