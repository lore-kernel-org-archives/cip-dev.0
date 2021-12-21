Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2B2C433FE
	for <webhook@archiver.kernel.org>; Tue, 21 Dec 2021 09:42:15 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.3903.1640079733717645181
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Dec 2021 01:42:14 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id ECC811C0B96; Tue, 21 Dec 2021 10:42:08 +0100 (CET)
Date: Tue, 21 Dec 2021 10:42:07 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/22] RZ/G2L: Add support for pinctrl/dmac/iic
Message-ID: <20211221094207.GA5071@amd>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Dec 2021 09:42:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7221


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds Pinctrl/DMAC/IIC support for Renesas RZ/G2L SoC.
>=20
> All the patches have been cherry picked from v5.16-rc5.
>=20
> I have created a MR [0] for cip-kernel-config (for testing purpose), which
> can later be merged once this patches have been merged.

Series looks okay to me. All I could find are
whitespaces/comments/documentation issues.

I'll proceed with testing; I can apply it if it passes and there are
no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHBoW8ACgkQMOfwapXb+vLFVgCgnmd+CK2AYgfm832VtH9eHcKk
zqEAn1MYrOwYaWv05K066S5SII6n+pSZ
=hSHd
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

