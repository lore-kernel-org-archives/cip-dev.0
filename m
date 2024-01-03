Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8223C3DA6E
	for <webhook@archiver.kernel.org>; Wed,  3 Jan 2024 18:26:36 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.24687.1704306389091188222
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jan 2024 10:26:29 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 820641C006B; Wed,  3 Jan 2024 19:26:24 +0100 (CET)
Date: Wed, 3 Jan 2024 19:26:23 +0100
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de, uli@fpond.eu,
	masami.ichikawa@cybertrust.co.jp, Chris.Paterson2@renesas.com,
	cip-dev@lists.cip-project.org
Subject: Re: [ANNOUNCE] Release v5.10.205-cip42 and v6.1.67-cip12
Message-ID: <ZZWmz5ZxB10Suz2T@duo.ucw.cz>
References: <TYVPR01MB1124522792658D6523F2C04C39299A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
 <77cc26df-0e6d-4415-9f06-6916643ed05a@siemens.com>
 <e6b43450-52e5-4529-8006-de503c30df7b@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B34eoFnbGi3s1sPQ"
Content-Disposition: inline
In-Reply-To: <e6b43450-52e5-4529-8006-de503c30df7b@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jan 2024 18:26:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14249


--B34eoFnbGi3s1sPQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Seems v6.1.67-cip12 was not pushed as tarball. I only find the
> > corresponding -rt release there:
> >=20
> > https://cdn.kernel.org/pub/linux/kernel/projects/cip/6.1/
>=20
> Nobuhiro is probably on leave right now. Could someone else help out in
> fixing this? I'd like to update our recipes to the latest releases.

I ran the script to generate/push the signatures, so the tarball
should appear in few minutes. It looks like v5.10.205-cip42 has
corresponding tarball, so no need to do anything there.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--B34eoFnbGi3s1sPQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZZWmzwAKCRAw5/Bqldv6
8pCTAJ9l+lU441Glnpd8yOsHt9tuZ5hABQCgu5J7OveU8HoImoj46B5uYJqhD8A=
=HAN1
-----END PGP SIGNATURE-----

--B34eoFnbGi3s1sPQ--

