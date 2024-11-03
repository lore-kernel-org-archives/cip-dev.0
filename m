Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398F8D11180
	for <webhook@archiver.kernel.org>; Sun,  3 Nov 2024 16:28:27 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.38717.1730651302912351852
 for <cip-dev@lists.cip-project.org>;
 Sun, 03 Nov 2024 08:28:23 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 722A21C006B; Sun,  3 Nov 2024 17:28:20 +0100 (CET)
Date: Sun, 3 Nov 2024 17:28:17 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/2] media: platform: rzg2l-cru: Trivial code
 cleanup
Message-ID: <ZyekoYEd8Mafc+NZ@duo.ucw.cz>
References: <20241101141538.34849-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WsDYUtaFiUh2i/dB"
Content-Disposition: inline
In-Reply-To: <20241101141538.34849-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 03 Nov 2024 16:28:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17166


--WsDYUtaFiUh2i/dB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to fix trivial code changes to RZ/G2L CRU driver.

Thank you. Series looks good to me and passes testing; I can apply it
if there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--WsDYUtaFiUh2i/dB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZyekoQAKCRAw5/Bqldv6
8saOAJ0cUDfU8gSSNtjzcTaUZVaXvPskVgCfbLJLqGyf+dPEoW0jT2dsIaATqCA=
=30Y5
-----END PGP SIGNATURE-----

--WsDYUtaFiUh2i/dB--

