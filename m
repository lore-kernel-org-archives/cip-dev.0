Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934A9C00140
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 16:47:03 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.8534.1659458819271778903
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 09:47:00 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 969FA1C0004; Tue,  2 Aug 2022 18:46:56 +0200 (CEST)
Date: Tue, 2 Aug 2022 18:46:56 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>, nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 02/24] arm64: dts: renesas: Add initial device
 tree for RZ/G2LC SMARC EVK
Message-ID: <20220802164656.GA9523@duo.ucw.cz>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
 <20220802110850.1496057-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20220802110850.1496057-3-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 16:47:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9023


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
>=20
> Add basic support for the RZ/G2LC SMARC EVK (based on R9A07G044C2):
> - memory
> - External input clock
> - SCIF
> - GbEthernet
> - Audio Clock
>=20
> It shares the same carrier board with RZ/G2L, but the pin mapping is
> different.  Disable the device nodes which are not tested and delete the
> corresponding pinctrl definitions.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Git is a bit unhappy with blank lines --

Applying: arm64: dts: renesas: Add initial device tree for RZ/G2LC SMARC EVK
=2Egit/rebase-apply/patch:171: new blank line at EOF.
+
=2Egit/rebase-apply/patch:253: new blank line at EOF.
+

-- but as before that is probably not worth solving in separate patch.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYulU/wAKCRAw5/Bqldv6
8uuyAKCDzQfx8dB3vRhP1UU2DK9rZ3FlLACdG+xEMUVr99CV4d/9mt6va+xN1Rs=
=bV3Q
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--

