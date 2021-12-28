Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D87C433EF
	for <webhook@archiver.kernel.org>; Tue, 28 Dec 2021 09:34:03 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.36803.1640684040942742862
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Dec 2021 01:34:02 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1FEF61C0B77; Tue, 28 Dec 2021 10:33:55 +0100 (CET)
Date: Tue, 28 Dec 2021 10:33:54 +0100
From: Pavel Machek <pavel@denx.de>
To: iwamatsu@nigauri.org, cip-dev@lists.cip-project.org
Subject: 4.4.296-rt229 is released
Message-ID: <20211228093354.GA6842@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Dec 2021 09:34:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7276


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

4.4.296-rt229 is released. If we could get corresponding 4.4.296-cip
release, it would make -cip-rt release easier.

Thank you,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHK2gIACgkQMOfwapXb+vL1QgCfXOrnKGbLjQdiU9mH9bxfORSz
Uw4AnRq0GTjNTClCTCByplYTb45DUZhx
=vUtw
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--

