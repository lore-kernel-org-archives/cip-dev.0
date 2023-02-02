Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A41C05027
	for <webhook@archiver.kernel.org>; Thu,  2 Feb 2023 19:58:34 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1801.1675367911737478201
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Feb 2023 11:58:32 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 105F91C0AB2; Thu,  2 Feb 2023 20:58:28 +0100 (CET)
Date: Thu, 2 Feb 2023 20:58:27 +0100
From: Pavel Machek <pavel@denx.de>
To: uli@fpond.eu, cip-dev@lists.cip-project.org
Subject: 4.4-st-rt update
Message-ID: <Y9wV43XxIeT1vMP3@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YsK9wgUmcigsBSav"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Feb 2023 19:58:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10575


--YsK9wgUmcigsBSav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm beggining to update linux-4.4.y-st-rt tree. At this point I should
be merging linux-4.4.y-st.

Would it be possible to add a commit on top of linux-4.4.y-st,
increasing localversion-st and adding note such as "tree should now be
up-to-date with 4.9.XXX" to the changelog?

Thank you and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YsK9wgUmcigsBSav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY9wV4wAKCRAw5/Bqldv6
8nUOAKCVaO6GprFy53myfRxvU70zDmTf9gCfZqpikw4iPg+Vdlgwg31jN4HVIko=
=aJfa
-----END PGP SIGNATURE-----

--YsK9wgUmcigsBSav--

