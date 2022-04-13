Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E998C388F3
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 16:03:53 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.3664.1649881985188112662
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 13:33:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7B1E01C0B8B; Wed, 13 Apr 2022 22:33:00 +0200 (CEST)
Date: Wed, 13 Apr 2022 22:32:59 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Message-ID: <20220413203259.GA3826@duo.ucw.cz>
References: <76860af5-c727-1ca9-a572-ef505ed51aaa@siemens.com>
 <20220407090607.GA20233@duo.ucw.cz>
 <54e32f3a-cc78-2e6f-2414-9ee2e2791243@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <54e32f3a-cc78-2e6f-2414-9ee2e2791243@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Apr 2022 16:03:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8083


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Last meeting minutes:
> >> https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/03/cip.2022-03=
-17-13.00.log.html
> > ...
> >> IMPORTANT NOTE: I'm unfortunately not able to run the meeting myself=
=20
> >> today due to an appointment conflict (damn DST...). Could someone else=
=20
> >> from the kernel team take over again? Thanks in advance.
> >=20
> > After DST shift, 13 UTC is not really great time for me, either. 12
> > UTC would be better, 9 or 10 UTC would be even better. I don't propose
> > shifting today's meeting, but should we talk about shift?
> >=20
>=20
> Forgot to follow up on this:
>=20
> Are there any concerns among our participants to move this by one hour
> earlier?

Not from me.

> If no, the next logical question would then be:
>=20
> Stick with one hour earlier, or will this cause conflicts again on the
> end of DST in Autumn?

My preferences are:

best/1: permanently one hour earlier.

2: one hour earlier at least during DST.

3: current time.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYlczewAKCRAw5/Bqldv6
8tRoAKCLlYsjmV2gtCEAI8W7xuVeF25ADwCfctmopK3zZmi3uMmp7DYbdxZSpO0=
=4g9F
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--

