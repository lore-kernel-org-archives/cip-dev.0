Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27998C47258
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 18:22:13 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.2599.1706725325842950129
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jan 2024 10:22:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 982671C0079; Wed, 31 Jan 2024 19:22:02 +0100 (CET)
Date: Wed, 31 Jan 2024 19:22:02 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [cip-dev] 6.1.75-cip-rt
Message-ID: <ZbqPym58ar2dltkz@duo.ucw.cz>
References: <17AF367A08806988.24874@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dyc2WmnDv0UIFZLN"
Content-Disposition: inline
In-Reply-To: <17AF367A08806988.24874@lists.cip-project.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 18:22:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14569


--Dyc2WmnDv0UIFZLN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> 6.1.75-rt is out, could I ask for 6.1.75-cip?

And v5.10.209-cip... It looks like v5.10.209-rt101-rc1 is going to be
out "soon".

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Dyc2WmnDv0UIFZLN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZbqPygAKCRAw5/Bqldv6
8qr5AJ0XOgUkL8dqFG3tRrdYDZapjrsUcgCgq/GON0m60t42fvnjIFjUm+i8aBg=
=4afa
-----END PGP SIGNATURE-----

--Dyc2WmnDv0UIFZLN--

