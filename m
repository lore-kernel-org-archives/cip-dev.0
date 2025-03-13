Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0E4C282DE
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 13:56:41 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.15536.1741874192899708245
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 06:56:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=JdWndF3G;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 955281020E4C2;
	Thu, 13 Mar 2025 14:56:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741874191; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ItakK9KD0HlFFrvny4z13FD7CAKr/Qs7RDygeMdUpNg=;
	b=JdWndF3GeGbRurxntECj/2vASVl058KFKZOHggZMoDbW/ujoaQ55W7hKNfZi14BApCl7YG
	7cg0ryPRL0y/s/dqrr+XyTcXjVqfzdeOEY3yVYTz+qrEYSDd6IqAAC9xOOwcaIzR6TaT+y
	tIH/j703F6VSK0vy75isKe4Mor56fjsOBX3Rlo0IloChvjPPmE8lwV5F3KQwXQdLGFGYyi
	Z9ZBrDYruMIhF0+1xCyTVZjfTm+CXWsfGAFHTSi5eQalnK4jVbHFJWXIK2cUWzYjq9qmxp
	e5Y+ps35kA1MONsQzBo7DXjZllykKrcNzlULlDf02vR6WULqn2xwIrK4Mub/IA==
Date: Thu, 13 Mar 2025 14:56:26 +0100
From: Pavel Machek <pavel@denx.de>
To: Michael Adler <michael.adler@siemens.com>
Cc: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Subject: Re: [cip-dev] Mailing list inventing addresses for people
Message-ID: <Z9LkCoI8fcTIPlvq@duo.ucw.cz>
References: <Z9LQ6u3m4LRFTCPM@duo.ucw.cz>
 <80dca55b-9632-46d5-9dab-74dde8ba4424@siemens.com>
 <whqvkav5o3ofm2kubxknu4mpctdtce76jiplvg7aemtn2d3q4g@f7ehpky3zjqp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5CBzcQlgoZKXMEx5"
Content-Disposition: inline
In-Reply-To: <whqvkav5o3ofm2kubxknu4mpctdtce76jiplvg7aemtn2d3q4g@f7ehpky3zjqp>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 13:56:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18198


--5CBzcQlgoZKXMEx5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> maybe it depends on the mail client what is actually being shown to the u=
ser.
> For example, I see the following mail headers (and my mail client ignores=
 the Resent-From header):
>=20
> ...
> From: "Pavel Machek via lists.cip-project.org" <pavel=3Ddenx.de@lists.cip=
-project.org>
> Resent-From: pavel@denx.de
> ...
>=20
> Do you mean that with "invented address"?

Well -- this one is not my email address: pavel=3Ddenx.de@lists.cip-project=
=2Eorg=20

This one is: pavel@denx.de

I don't want people to bookmark pavel=3Ddenx.de@lists.cip-project.org ,
for example.

We talked about it on IRC: http://ircbot.wl.linuxfoundation.org/meetings/ci=
p/2025/03/cip.2025-03-13-13.01.log.html

The mangled address + reply-to to the list means that it is impossible
to send direct reply to the user, which we agreed is "not
optimal". From the irc discussion it looked like address mangling is
now common feature due to DMARC/DKIM.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5CBzcQlgoZKXMEx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9LkCgAKCRAw5/Bqldv6
8q5PAKCmJTJ4VoGQzMa6713kDLOfm6L81gCeMk2oztpoij/248V+4afrY6cX3sU=
=S1Wg
-----END PGP SIGNATURE-----

--5CBzcQlgoZKXMEx5--

