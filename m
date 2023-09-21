Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EE4E70713
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 10:40:51 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.12974.1695292842553016379
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Sep 2023 03:40:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 11C811C001A; Thu, 21 Sep 2023 12:40:40 +0200 (CEST)
Date: Thu, 21 Sep 2023 12:40:39 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Message-ID: <ZQwdpyL2uVYmbEkq@duo.ucw.cz>
References: <f06ca763-a337-40de-95e7-501c03c8bfe9@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="42X1FFJpdbI1sbQs"
Content-Disposition: inline
In-Reply-To: <f06ca763-a337-40de-95e7-501c03c8bfe9@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Sep 2023 10:40:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13197


--42X1FFJpdbI1sbQs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm not sure if I'll be able to participate or participate fully in
the meeting, so:

> * Kernel maintenance updates

Reviewing 6.1.53, 6.1.54.

> * Kernel release status
>   - 4.4
>   - 4.19
>   - 5.10

-rt should be on track here.

>   - 6.1

Iwamatsu will do the release over the weekend, and I'll follow up with
-rt here.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--42X1FFJpdbI1sbQs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZQwdpwAKCRAw5/Bqldv6
8iNbAKCwd5ubAX+6m8Dm4VfMahtp4eZTIACfXHHhii2+ZWBy36HA7m9HAPZhW9E=
=frEV
-----END PGP SIGNATURE-----

--42X1FFJpdbI1sbQs--

