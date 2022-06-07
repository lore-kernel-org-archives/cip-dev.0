Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD37EC433EF
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 08:20:59 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.9884.1654590051215840716
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 01:20:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AA7741C0BB6; Tue,  7 Jun 2022 10:20:46 +0200 (CEST)
Date: Tue, 7 Jun 2022 10:20:46 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org
Subject: Re: pkexec vs kernel -- root to anyone who asks nicely
Message-ID: <20220607082046.GA23037@duo.ucw.cz>
References: <20220606175706.GA19989@duo.ucw.cz>
 <8a6279d1-a02f-8808-de08-c2c195d36969@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <8a6279d1-a02f-8808-de08-c2c195d36969@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 08:20:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8501


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > There's a security problem in pkexec vs. kernel interaction. Impact is
> > local root. If you want to get root on someone else's system, it
> > should be easy right now. It is fixed in 5.18, 5.10.120, and latest
> > 4.9 and 4.19 kernels.
> >=20
> > Do you have untrusted users on your system and you need pkexec?
> >=20
>=20
> Is that https://nvd.nist.gov/vuln/detail/cve-2021-4034, and does that
> relate to "This vulnerability has been modified and is currently
> undergoing reanalysis."? Or is it something else?

Yes, it is same thing... see dcd46d897adb70d63e025f175a00a89797d31a43
and https://www.qualys.com/2022/01/25/cve-2021-4034/pwnkit.txt .

Pkexec is gnome-related, so should not be too usual on embedded
systems, and you should not really have untrusted users on your
embedded system, either.

But if someone has them and is using pkexec, we may need to do extra
updates.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYp8KXgAKCRAw5/Bqldv6
8kIHAJ97XZoLj7R0CNSGKDVHu2eQP/FNkwCfchqs4x9IL15Ky3Y8SsvAuzFbv04=
=zqPd
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

