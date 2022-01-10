Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F19BC433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 18:06:41 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.35563.1641837999768935306
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 10:06:40 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9050E1C0B77; Mon, 10 Jan 2022 19:06:35 +0100 (CET)
Date: Mon, 10 Jan 2022 19:06:35 +0100
From: Pavel Machek <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Cc: Amy Fong <Amy_Fong@mentor.com>, cip-dev@lists.cip-project.org,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 1/6] Backport netfilter: nf_tables:
 autoload modules from the abort path
Message-ID: <20220110180635.GB3396@duo.ucw.cz>
References: <16C8EE09FDEB733D.27414@lists.cip-project.org>
 <Ydw+c4lHNdN0zAE6@cat>
 <20220110175519.GA3396@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <20220110175519.GA3396@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 18:06:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7436


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Ok, let me take a look at the series. But... could you provide some
> kind of explanation of what these are and why you want them in -cip?
>=20
> These are not usual "hardware enablement" patches...

0/6 email was not part of the thread, so I missed it in the first
look.

I see it fixes sysbot report.

Do you have special loads where you are hitting these netfilter
problems? Are similar fixes needed in 4.4 / 5.10?

Would it make sense to get it fixed in -stable kernels?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYdx1qwAKCRAw5/Bqldv6
8lVgAJ9ZZdEEks56Ls5DhNXtAO/cdV73ZwCdF1dG4+a+nrXD+bE1CROgmg9UuaU=
=rYwL
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--

