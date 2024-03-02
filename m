Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B18C54798
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 21:08:48 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.60606.1709413720255237269
 for <cip-dev@lists.cip-project.org>;
 Sat, 02 Mar 2024 13:08:40 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6DC4A1C006B; Sat,  2 Mar 2024 22:08:37 +0100 (CET)
Date: Sat, 2 Mar 2024 22:08:36 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
	masami.ichikawa@cybertrust.co.jp
Subject: 6.1.80-cip release to get match with -rt release
Message-ID: <ZeOVVL/qDRP3YBa4@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o5R4Mo0ooUDbTHRr"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 21:08:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15164


--o5R4Mo0ooUDbTHRr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

6.1-cip-rt is due, and there's v6.1.80-rt26 out, so easiest would be
to get matching 6.1.80-cip. If there are no comments, I'll likely
prepare that release, and then prepare -cip-rt based on that.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--o5R4Mo0ooUDbTHRr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZeOVVAAKCRAw5/Bqldv6
8la+AKC5/4fe1VZbon54pijBl+Pe21jx8gCglZR0joBAf5R46X9UCWPqBmTXweM=
=j2EY
-----END PGP SIGNATURE-----

--o5R4Mo0ooUDbTHRr--

