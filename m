Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42BEC433EF
	for <webhook@archiver.kernel.org>; Thu,  5 May 2022 12:01:26 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.9903.1651752085122101460
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 May 2022 05:01:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B1B981C0BA6; Thu,  5 May 2022 14:01:20 +0200 (CEST)
Date: Thu, 5 May 2022 14:01:20 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, iwamatsu@nigauri.org
Subject: linux-4.4.y-cip-rebase: patches in wrong order?
Message-ID: <20220505120120.GA4543@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 May 2022 12:01:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8254


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

In previous linux-4.4.y-cip-rebases, order of patches was:

git log:
[CIP patches]
[Greg's stable tree]
[Linus tree]

With start of self-maintainance, we now have:

git log:
[-st patches]
[CIP patches]
[Greg's stable tree]
[Linus tree]

This was unexpected for me, may be unexpected for our users, and would
make -cip-rt release different to previous ones. COuld we get order of
patches be

git log:
[CIP patches]
[-st patches]
[Greg's stable tree]
[Linus tree]

?

(Simply ... put the stable patches where they would be if Greg
continued doing them).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYnO8kAAKCRAw5/Bqldv6
8vIRAJ0d2mrUsiKIKFz9dAGHmbBrZ9GIIgCfdeFtudH6yr/qOXW5rdBSiDCOonA=
=Rvdn
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

