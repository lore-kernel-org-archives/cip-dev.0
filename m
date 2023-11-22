Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA36C61D9C
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 21:03:22 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.40043.1700686999825950265
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 13:03:20 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5DEC71C0075; Wed, 22 Nov 2023 22:03:18 +0100 (CET)
Date: Wed, 22 Nov 2023 22:03:17 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/11] Add versa3 clk generator support
Message-ID: <ZV5slWlS0Qv5yN3n@duo.ucw.cz>
References: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="91syNA73j51Bqn3s"
Content-Disposition: inline
In-Reply-To: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 21:03:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13652


--91syNA73j51Bqn3s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add versa3 clk generator support on
> RZ/G2{L,LC,UL}/RZ/Five SMARC EVKs.
> =20
> All the patches are cherry-picked from the mainline.

Thanks for patches. Both this and 6.1 version looks okay to me, and I
have only very minor comments. I can apply them if there are no other
commens and if they pass testing. (But I'd preffer to have
5.10.101-cip release, first).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--91syNA73j51Bqn3s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZV5slQAKCRAw5/Bqldv6
8l5EAKC8V3iySMnv0PROdgFTYGtMfdqFrQCfYd32nW4zZ/xSpk6dl3+nlt1RjNU=
=tE+M
-----END PGP SIGNATURE-----

--91syNA73j51Bqn3s--

