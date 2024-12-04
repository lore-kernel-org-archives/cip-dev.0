Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91E0E7716B
	for <webhook@archiver.kernel.org>; Wed,  4 Dec 2024 12:44:03 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.13108.1733316235470095750
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Dec 2024 04:43:56 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=fail (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 742F21C00A0; Wed,  4 Dec 2024 13:43:52 +0100 (CET)
Date: Wed, 4 Dec 2024 13:43:52 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.4-st59, 4.4-cip94
Message-ID: <Z1BOiEzl1Y3nfxeK@duo.ucw.cz>
References: <1473272532.942564.1733292474812@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i19VFCXzDBfPzFH9"
Content-Disposition: inline
In-Reply-To: <1473272532.942564.1733292474812@webmail.strato.de>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Dec 2024 12:44:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17326


--i19VFCXzDBfPzFH9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> To avoid lag due to the large number of patches in 4.19.325, and to bring=
 the schedule back on track, I'd like to make a release based on 4.19.324. =
It's quite small, there are only two manual backports to review. As always,=
 they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/l=
inux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>=20

a > d8f1878c3b912 dm cache: correct the number of origin blocks to match th=
e target length
a > 23f883c06568b sctp: properly validate chunk size in sctp_sf_ootb()
>=20

They look good to me, thank you!

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--i19VFCXzDBfPzFH9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ1BOiAAKCRAw5/Bqldv6
8rfUAKDAHK61p8qskFCJ+HxTYByNEp/w0QCgtfVlgFUCYJV8UXVVkpC2jB8imlU=
=8i96
-----END PGP SIGNATURE-----

--i19VFCXzDBfPzFH9--

