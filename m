Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD22C38142
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 22:59:48 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.9472.1675205981809664873
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Jan 2023 14:59:42 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0F13E1C0AB2; Tue, 31 Jan 2023 23:59:39 +0100 (CET)
Date: Tue, 31 Jan 2023 23:59:38 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, vadym.haidamaka@gmail.com
Subject: Re: [cip-dev] 4.9 SLTS support
Message-ID: <Y9mdWiWsjn9LtqF9@duo.ucw.cz>
References: <CAJDaTYk6Q7zVPv6bVicqoXq8v6p0+x17+DiuuR22_OMWn7G1bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ra+X2etPQ8+t+deS"
Content-Disposition: inline
In-Reply-To: <CAJDaTYk6Q7zVPv6bVicqoXq8v6p0+x17+DiuuR22_OMWn7G1bw@mail.gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 22:59:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10547


--ra+X2etPQ8+t+deS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Would Linux kernel 4.9 be supported by the CIP project as a next SLTS
> version?

There are no plans to do that.

4.4 and 4.19 will be supported for a while by CIP project.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ra+X2etPQ8+t+deS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY9mdWgAKCRAw5/Bqldv6
8ntGAJ0agXz+c2Eis3W7gjDrLGY1w82fmQCfflovpp3zE1baKWxgVglrP/fVDZ4=
=/uZ8
-----END PGP SIGNATURE-----

--ra+X2etPQ8+t+deS--

