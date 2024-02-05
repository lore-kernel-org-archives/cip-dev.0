Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD56C48291
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 11:35:55 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.60511.1707132951205231778
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 03:35:51 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3B2201C0050; Mon,  5 Feb 2024 12:35:48 +0100 (CET)
Date: Mon, 5 Feb 2024 12:35:47 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: 5.10/6.1-cip was Re: [cip-dev] 6.1.75-cip-rt
Message-ID: <ZcDIEwfQIZkoSsn0@duo.ucw.cz>
References: <17AF367A08806988.24874@lists.cip-project.org>
 <17AF81A441E06ADF.11150@lists.cip-project.org>
 <17B00943658B5235.1968@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nknd1b7dblmZ71c7"
Content-Disposition: inline
In-Reply-To: <17B00943658B5235.1968@lists.cip-project.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 11:35:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14668


--nknd1b7dblmZ71c7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > 6.1.75-rt is out, could I ask for 6.1.75-cip?
> >=20
> > And v5.10.209-cip... It looks like v5.10.209-rt101-rc1 is going to be
> > out "soon".
>=20
> If it would help, I believe I can do 6.1.75-cip and 5.10.209-cip
> releases. I need them for -rt releases.

Thanks for 6.1.

There are few series of changes on the mailing list for 5.10, and I
need the release to do 5.10-cip-rt, so I'll make one in few minutes
unless someone stops me.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--nknd1b7dblmZ71c7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcDIEwAKCRAw5/Bqldv6
8kW8AKC9nHfvmb+aiTMqolsfDzmu8EJczgCgoteR78Z4nJn9hp6YvDtnFBMshVk=
=LFbE
-----END PGP SIGNATURE-----

--nknd1b7dblmZ71c7--

