Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D766C43334
	for <webhook@archiver.kernel.org>; Sun, 24 Jul 2022 10:31:30 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.15279.1658658687350005026
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Jul 2022 03:31:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 75D461C0001; Sun, 24 Jul 2022 12:31:23 +0200 (CEST)
Date: Sun, 24 Jul 2022 12:31:22 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, iwamatsu@nigauri.org
Cc: Chris.Paterson2@renesas.com, alice.ferrazzi@miraclelinux.com
Subject: 4.4-st20 -- Re: [cip-dev] Failures in 5.10, 4.4 testing
Message-ID: <20220724103122.GA10257@duo.ucw.cz>
References: <20220723210456.GA7918@duo.ucw.cz>
 <CABMQnVK74F-VbNUecaNFqP4CB-fCns4ZBkyovkvqn9v_xpo0tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: 
 <CABMQnVK74F-VbNUecaNFqP4CB-fCns4ZBkyovkvqn9v_xpo0tg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 24 Jul 2022 10:31:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8896


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I pushed 4.4-st20 to linux-4.4.y-st-rc tree. Testing does not work too
well at the moment, but I believe it is candidate for -st and -cip
releases.

Specifically testing that TCP still works in 4.4 and that privacy
fixes are effective would not be bad.

I would not mind someone reviewing "tcp: change source port
randomizarion at connect() time". In particular, 4.9 code has " %
remaining" there.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYt0fegAKCRAw5/Bqldv6
8t5TAJ474tJ6LSJ2geRfRH+UiSToWn20JgCfadWY1qmON68j3z3qKL6Ps7sAD68=
=ZUBV
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

