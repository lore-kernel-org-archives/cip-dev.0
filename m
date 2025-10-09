Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D57CCD183
	for <webhook@archiver.kernel.org>; Thu,  9 Oct 2025 07:49:15 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.6606.1759996148122145976
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Oct 2025 00:49:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=iswQeNgd;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B027C103A841A
	for <cip-dev@lists.cip-project.org>; Thu,  9 Oct 2025 09:49:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1759996145; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=COMTx7gRTnmqCkBN7QdAcySBd/8VyZgtiMPIrQvWsX4=;
	b=iswQeNgd6iYD5+q6oX+YaC3FYdIR0dQbxxtxorxP6tqicTK8ImQlB28I8U6/WBci79M5pC
	x6rs4gF80v70U8jn+Km6Zo/Ja7ftJK+MStua68ZlBQEwgIaIu5u32kAUwOJ3ZpCFi1wmIg
	v4Rvm0eBHF701G65NzPQE7xI2Ji4PXOo06llBJWH300ROxZo+lqTx4VMJ8YQdhEzLvh/AC
	uycQOWZI22o6sUqVBarThNdQoxjOtG47HyK+ehAag/tPH+/eHDwHHBCZiWPGDE8rNZXk3V
	P9VZjorRepEPV4dZfF8vhEs4p2Q5nJly1Sj/GUntXs1lKHy8q7i5iz5giXzAmQ==
Date: Thu, 9 Oct 2025 09:49:02 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: CIP IRC weekly meeting today on libera.chat
Message-ID: <aOdo7slYjteweK6+@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3ngH/FvNKRs0RQtO"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Oct 2025 07:49:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20164


--3ngH/FvNKRs0RQtO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00.

https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2025&mont=
h=3D10&day=3D9&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/10/cip.2025-10-02-1=
3.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3ngH/FvNKRs0RQtO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaOdo7gAKCRAw5/Bqldv6
8s9tAKCxiv8exbsxXBNpkJrcUjeKL+qu4gCfXH4J7R50+1tkhdbAk4sWI+PeNWM=
=mEnp
-----END PGP SIGNATURE-----

--3ngH/FvNKRs0RQtO--

