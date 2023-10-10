Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC527CD690F
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 09:06:56 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.86581.1696928810147949353
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Oct 2023 02:06:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DEEA11C006C; Tue, 10 Oct 2023 11:06:46 +0200 (CEST)
Date: Tue, 10 Oct 2023 11:06:46 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: 5.10.197-rt96: could we get matching -cip release?
Message-ID: <ZSUUJkXwCr1i3hUG@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e3/rPCTVZ0Sxtypr"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 09:06:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13346


--e3/rPCTVZ0Sxtypr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

5.10.197-rt96 is out, and matching -cip release would be useful for
me. It is time for -cip-rt.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--e3/rPCTVZ0Sxtypr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZSUUJgAKCRAw5/Bqldv6
8rrPAJ9UKs0eDo38XeiS9QLYcB9TJ0KFngCgoedtXcl6XpeWLzIXO35wopukFjg=
=/CkX
-----END PGP SIGNATURE-----

--e3/rPCTVZ0Sxtypr--

