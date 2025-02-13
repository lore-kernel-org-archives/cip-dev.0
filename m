Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77CAC0219D
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 10:25:30 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.7826.1739442323699984007
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Feb 2025 02:25:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=bnwuPa9w;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD13B1034EAE0;
	Thu, 13 Feb 2025 11:25:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1739442321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IlZhernoeBCYcgq/9qQJAVVvoAPAxnCdoJxrp8s//84=;
	b=bnwuPa9wA7HL/nLFwxTL0Ey5pX4KuF1s0w2gNw2dJuRtP4Jy6WeU8ChD/j3Desk98UyACZ
	i2VSMKuyRYyBeknwo0voHO9ru3Va5ekekEJaFiKms++nccIDezsKHMBgA4sL6CQVGIL2a2
	Fb4tHm/vueD6ryyY1IpD8+J5NJE7J2gJfgcCfMS3mUrUeEboAaud9d3aU4R1XwlGVt15kb
	DbzvQnqHgWAvKEem0PmdmpN96QdoFBl4/usoDw5TNhWje9Rn5DhpPjyUBy+LVjirumWB/+
	YEQLL/flzsnjNlcnDlKx6mfKacpJl64/lswwwMH06574gS23IY35WzIhE/v5lQ==
Date: Thu, 13 Feb 2025 11:25:16 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: pavel@denx.de, cip-dev@lists.cip-project.org
Subject: Re: v6.1-cip-rt based on 6.1.128
Message-ID: <Z63IjCfseqmfZQwa@duo.ucw.cz>
References: <Z6zQG669vWGTBgKI@duo.ucw.cz>
 <OS0PR01MB638855DE9BCE6BF647DB3D4992FC2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m9jICIbG/ZxppO/r"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB638855DE9BCE6BF647DB3D4992FC2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Feb 2025 10:25:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17829


--m9jICIbG/ZxppO/r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > 6.1.128-rt49 is out and it may be good time to do -cip-rt release.=20
>=20
> I think it is a good choice for us.
>=20
> > Could I ask for 6.1.128-cip release? (Alternatively, I can do it myself=
).
>=20
> Yes, could you release it?
> If you do not have a time for work, I can do it.

I will do it, yes. Thanks and best regards,
									Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--m9jICIbG/ZxppO/r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ63IjAAKCRAw5/Bqldv6
8peMAKCUh74gw5o7WrJyGfyQcbnicN6IegCgv52QPKM9A9hJj2QDoO4gKWrk1EI=
=cX2A
-----END PGP SIGNATURE-----

--m9jICIbG/ZxppO/r--

