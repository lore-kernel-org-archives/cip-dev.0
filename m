Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0895C00140
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 16:56:53 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.8652.1659459397820849945
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 09:56:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4B57A1C0004; Tue,  2 Aug 2022 18:56:36 +0200 (CEST)
Date: Tue, 2 Aug 2022 18:56:35 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>, nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 00/24] Add RZ/{G2LC, V2L} support
Message-ID: <20220802165635.GC9523@duo.ucw.cz>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline
In-Reply-To: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 16:56:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9025


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add Basic board support for SMARC EVK
> based on RZ/G2LC and RZ/V2L SoC. RZ/{G2L, G2LC, V2L} share the same
> SMARC EVK board, but SoM is different and pin mapping of SoM
> module is different.
>=20
> All these patches are cherry-picked from the mainline.

Series looks okay to me. I can apply it if there are no other commands
(and if it passes testing).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYulXQwAKCRAw5/Bqldv6
8hK9AJwOhsLWaw2igmM1HTJwk6mdE2WrKQCbB8zk8QB5J3b1IO4wZeSROOkamvg=
=D0jM
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--

