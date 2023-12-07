Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF332C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 11:05:35 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.81493.1701947126086729672
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 03:05:26 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0C4241C0075; Thu,  7 Dec 2023 12:05:23 +0100 (CET)
Date: Thu, 7 Dec 2023 12:05:22 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Message-ID: <ZXGm8hlfZRmosI1O@duo.ucw.cz>
References: <2df11e62-6cb3-413e-b72d-3a2f6b3332ec@siemens.com>
 <TYVPR01MB1124553711DEB70B23EDEF814928BA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOSiD7c0kyAvtU7X"
Content-Disposition: inline
In-Reply-To: <TYVPR01MB1124553711DEB70B23EDEF814928BA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 11:05:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13826


--BOSiD7c0kyAvtU7X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2023&
> > month=3D12&day=3D7&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136=
&p4
> > =3D37&p5=3D241&p6=3D248
> >=20
> > USWest    USEast    UK        DE        TW        JP
> > 05:00     08:00     13:00     14:00     21:00     22:00
> >=20
> > Last meeting minutes:
> > https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/11/cip.2023-11-=
30-
> > 13.04.log.html
> >=20
> > * Action items
> > * Kernel maintenance updates
> > * Kernel release status
> >   - 4.4
> >   - 4.19
> >   - 5.10
> >   - 6.1

> FYI:
> Date (the data is created): Thu 07 Dec 2023 07:23:38 AM UTC

Hehe, nice script. Should we put it into version control somewhere?
I'm using gitlab.com:cip-project/cip-kernel/lts-commit-list bin
directory for various tools, so perhaps there?

> linux-4.19.y-cip: interval 30 day
>   latest version release date: Mon 06 Nov 2023 04:21:02 AM UTC
>   limit date: Wed 06 Dec 2023 04:21:02 AM UTC
>   Status: late

I can do the 4.19-cip release if that would help...

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--BOSiD7c0kyAvtU7X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXGm8gAKCRAw5/Bqldv6
8nO9AKCMANFD2pZTU4BBiXhuy6CmAz081ACeIzoT4xP+s/6pGwO3w4na8e0QNLQ=
=NW9Y
-----END PGP SIGNATURE-----

--BOSiD7c0kyAvtU7X--

