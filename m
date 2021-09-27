Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D7FC433EF
	for <webhook@archiver.kernel.org>; Mon, 27 Sep 2021 10:09:57 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.29149.1632737396304878607
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Sep 2021 03:09:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 387531C0B7C; Mon, 27 Sep 2021 12:09:51 +0200 (CEST)
Date: Mon, 27 Sep 2021 12:09:50 +0200
From: Pavel Machek <pavel@denx.de>
To: uli@fpond.eu, cip-dev@lists.cip-project.org
Subject: Coordinating stable reviews
Message-ID: <20210927100950.GA11971@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Sep 2021 10:09:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6751


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

It is good to review "stable" patches soon, because such reviews are
more useful for the stable community, and because when bug is spotted,
it is easier to get patch dropped in the 5.10.X-rc phase than waiting
for 5.10.X release and then having patch reverted in 5.10.X+1.

Unfortunately, we don't have good system for coordinating reviews in
-rc phase.

There's a script (commit.py) that produces one-line-per-patch output
suitable for review. One possibility would be to have shared place
somewhere reviewers could tag "I'm working on these patches".

I don't believe lts-commit-list.git repository is suitable for that;
format suitable for review is different from what we have in
lts-commit-list, and there is going to be multiple updates per day in
busy periods.

We don't really need commit messages for this. Actually, we don't
really need to keep history, either. It would be good if system could
be controlled from command line for easy scripting.

Any ideas what kind of service could be used for this?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmFRmG0ACgkQMOfwapXb+vJRbwCfY3b+ezSJoL6txCpH+CdShXGw
OVwAoIbvMlYcW+K3mc0eh8OCr98KYhys
=WsMM
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

