Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B09FCA5FB1
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 09:19:15 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9419.1790759950087432470
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Sep 2026 02:19:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=D5s2d+rp;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B557106B4D;
	Wed, 30 Sep 2026 11:19:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790759943;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=0LnerNiez1R7I3Wo10/XJ/KNi5ITd/ZiPQlGp4DXiVg=;
	b=D5s2d+rpHHo0TDE6T92xBfeJYDCGrPR3+aszPqAcW6XOE44sWvH4haR6ZSo+zQc8uf4E+y
	bc4GKvfax4N/lBp9932GRKKQGiGtAIVPsHPBgk0igFBLrCv2JZv+zV5+8ivxFeAy6+R3my
	QnNBof1Ch5LUw8E6S6gDzTYFJju6xyOT6g2bNT3BsiRgwjkJMQH2Gl0FXz0/CNfwKjppG/
	myu4xyuZXlujsQnwmyVXGPo1Eu7iZgmXF0A4U6Wi31iKgrg/s8YmP2ld7EOLTrb5R/y0OK
	Aliqn9ldLibEm4j3vIuBpaZc5QjhefZhgueGt6lA09O7Eqpn/pLyFas+8x9fuA==
Date: Wed, 30 Sep 2026 11:18:59 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>, uli <uli@fpond.eu>,
	Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
	Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: CIP kernel lunch
Message-ID: <arzUAwDrIuZPF6y1@duo.ucw.cz>
References: <06640825-6f58-484e-b9e5-5e5349938fd0@siemens.com>
 <OS3PR01MB9738E9D0D4A0C5B0A1C65D7EB78C2@OS3PR01MB9738.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IVetN6s/1rL5yPqf"
Content-Disposition: inline
In-Reply-To: <OS3PR01MB9738E9D0D4A0C5B0A1C65D7EB78C2@OS3PR01MB9738.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Sep 2026 09:19:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24378


--IVetN6s/1rL5yPqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > if your are attending OSS Prague: How about having lunch together on
> > Thursday (Oct 8, 12:20) and chatting about CIP kernel topics a this
> > chance?
>=20
> Sounds good to me. I'll keep it free.

I added it to my calendar, too. It should work out.

Best regards,
								Pavel

--IVetN6s/1rL5yPqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCarzUAwAKCRAw5/Bqldv6
8kW8AJwJqCuhaWnHWgjyrYtemz3oNE4VWQCfWXwjGnFHYcrLsdGhROlVCO32ZNs=
=WHAQ
-----END PGP SIGNATURE-----

--IVetN6s/1rL5yPqf--

