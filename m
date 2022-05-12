Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5415FC433EF
	for <webhook@archiver.kernel.org>; Thu, 12 May 2022 11:17:23 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.2868.1652354234954768463
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 May 2022 04:17:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4E06F1C0B95; Thu, 12 May 2022 13:17:10 +0200 (CEST)
Date: Thu, 12 May 2022 13:17:08 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Message-ID: <20220512111708.GA18891@duo.ucw.cz>
References: <3ce4350a-d5a9-0d46-56c0-efcc76d53ed2@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <3ce4350a-d5a9-0d46-56c0-efcc76d53ed2@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 May 2022 11:17:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8338


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>=20
>     irc:irc.libera.chat:6667/cip
>=20
> The IRC meeting is scheduled to UTC (GMT) 12:00:
>=20
>
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2022&mont=
h=3D5&day=3D12&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

I'm not sure if I'll be able to make it today.

I was reviewing patches queued for 5.10.114 and .115, and am now
fighting with 4.4.X branch.

It looks like 4.4.x-cip-rebase has patches in wrong order -- see email
"linux-4.4.y-cip-rebase: patches in wrong order?"

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYnzstAAKCRAw5/Bqldv6
8nGdAJ9UyBtncGdnxu4Tujo+B1Gk9yexPACghs6RtVrdHjpZzPST0oFpmy6HHJc=
=v0Eb
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

