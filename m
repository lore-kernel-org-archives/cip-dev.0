Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F9CEB64DA
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 10:44:25 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.10892.1689763455846531595
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jul 2023 03:44:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2246E1C0A97; Wed, 19 Jul 2023 12:44:13 +0200 (CEST)
Date: Wed, 19 Jul 2023 12:44:12 +0200
From: Pavel Machek <pavel@denx.de>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/6] Add eMMC/SDHI support
Message-ID: <ZLe+fGQGfdAOeePP@duo.ucw.cz>
References: <20230718153212.327448-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jwkvkkHHGYDpkpCR"
Content-Disposition: inline
In-Reply-To: <20230718153212.327448-1-fabrizio.castro.jz@renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 10:44:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12419


--jwkvkkHHGYDpkpCR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> this series adds eMMC/SDHI support to the Renesas RZ/V2M EVK v2
> platform.
> All the patches are cherry-picked from mainline.

Thanks for the series. It looks okay to me. I can apply it if there
are no other comments and if it passes testing.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jwkvkkHHGYDpkpCR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLe+fAAKCRAw5/Bqldv6
8nvNAJ9b6hwaJdUWqmFA680wk3yzmDd8oQCfYVqZ6Y/1aTzwfw2YKepHh8ri43k=
=mYgp
-----END PGP SIGNATURE-----

--jwkvkkHHGYDpkpCR--

