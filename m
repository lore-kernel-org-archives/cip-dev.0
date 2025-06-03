Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9C7C5AE59
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 08:34:46 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.6396.1748939681097973435
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 01:34:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=fE8K7m1i;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 04D8E10397298;
	Tue,  3 Jun 2025 10:34:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1748939679; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=JrwY06WyCViCwXPxu/6wW3M24q6nwmUCz9gLodj0arc=;
	b=fE8K7m1iZGegbcVLyfJ4Wkn2Ad2MQbrelp+d+gPpNs1wgSN689vMd162wlg9yWxaYdeRe8
	NXyp5yVUfqVSeOuzy1gW7UqvRJuL82S8745Zg3jKfk6G1c/+JDKGh51sJ1eEQ1sYFBlUo+
	bSokkQP6Byl60Mr+hUGIjCt0m68s8vN9e45/PG+m0DOrzQ4dZettvoRIPTIjW3G97LFmNb
	cY/w1OKR+nAnSTTz3HepZJL+7T1NtODKPLfS8vzHVY6ypKjpdY3bTWEqa7CexrHDXNqgLv
	OffyCjAFBzbxkHTklxtbJhDffsuZfMngcUaEA9SmR5N92s4rhh05ntt96VHOwA==
Date: Tue, 3 Jun 2025 10:34:35 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Subject: Re: CIP IRC weekly meeting today on libera.chat
Message-ID: <aD6zm+UdQn1RSRSj@duo.ucw.cz>
References: <aDggNAAp1mnSfQja@duo.ucw.cz>
 <ce5c2a9f-8f9d-4266-8c0d-ceb62dd61405@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C/BPneDzk84953+0"
Content-Disposition: inline
In-Reply-To: <ce5c2a9f-8f9d-4266-8c0d-ceb62dd61405@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 08:34:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18964


--C/BPneDzk84953+0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Kindly be reminded to attend the weekly meeting through IRC to discuss
> > technical topics with CIP kernel today. Our channel is the following:
> >=20
> >     irc:irc.libera.chat:6667/cip
> >=20
> > The IRC meeting is scheduled to UTC (GMT) 13:00, or in about 4 hours.
> >=20
> > Last meeting minutes:
> > https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/05/cip.2025-05-=
22-13.01.log.html
> >=20
> > * Action items
> > * Kernel maintenance updates
> > * Kernel release status [*]
> > * Kernel testing
> > * AOB
>=20
> I cannot find the recording at
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/05/ - were there
> technical issues with bot, or didn't the meeting took place?

I did not manage to start a meeting, and we only noticed when meeting
ended. Sorry about that. The log is at:

https://ircbot.wl.linuxfoundation.org/logs/%23cip/%23cip.2025-05-29.log.html

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--C/BPneDzk84953+0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaD6zmwAKCRAw5/Bqldv6
8tO7AJ9W01XFqNellK1sJyPkb0V5FOtwywCfXMAMBUThWSDu383lGo2gmcD0xTY=
=7K1c
-----END PGP SIGNATURE-----

--C/BPneDzk84953+0--

