Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74250C3DA78
	for <webhook@archiver.kernel.org>; Sun, 15 Jan 2023 16:52:30 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.143989.1673801544326311771
 for <cip-dev@lists.cip-project.org>;
 Sun, 15 Jan 2023 08:52:25 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DF3641C09F4; Sun, 15 Jan 2023 17:52:20 +0100 (CET)
Date: Sun, 15 Jan 2023 17:52:20 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] 6.1 LTS
Message-ID: <Y8QvRNxsp0N3Sa2D@duo.ucw.cz>
References: <c4648640-e690-5afb-85fc-85bb81889737@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iBgYTXnEaY+s9X1"
Content-Disposition: inline
In-Reply-To: <c4648640-e690-5afb-85fc-85bb81889737@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 15 Jan 2023 16:52:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10367


--7iBgYTXnEaY+s9X1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> in case you didn't see this yet (thanks to Florian for pointing it out):
> https://lore.kernel.org/all/Y53BputYK+3djDME@kroah.com/
>=20
> How could we contribute to this as CIP?

Well, I believe we should start testing 6.1.X.=20

Greg does not (and can not) know how well 6.1.X works, and it is hard
for him to call if it LTS if he's not confident with it, and that's a
place where we can help.

If we wanted to push it a bit more, at some point we may want to write
"hey this seems to work okay for our uses, and we'd like to see it as
LTS" or something like that.

On a related note, 4.9.X was discontinued; I believe we should create
configs for 4.14 and start testing that, to help with 4.4-st
maintainance.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7iBgYTXnEaY+s9X1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY8QvRAAKCRAw5/Bqldv6
8pwpAJ9zE5Sp+W0VZbzgK7T1Lh0cbSE2IACfYuPVitTwIZ/ZBhg6WzWyYQvkDzQ=
=pt2y
-----END PGP SIGNATURE-----

--7iBgYTXnEaY+s9X1--

