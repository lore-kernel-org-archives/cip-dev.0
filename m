Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB78C3DA7D
	for <webhook@archiver.kernel.org>; Thu,  5 Jan 2023 15:41:22 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.15812.1672933276336948396
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Jan 2023 07:41:17 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4CE911C09F4; Thu,  5 Jan 2023 16:41:12 +0100 (CET)
Date: Thu, 5 Jan 2023 16:41:11 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Message-ID: <Y7bvl0gZV9woUtmq@duo.ucw.cz>
References: <a599db4f-8df5-3021-b610-3442d6059b01@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v5gLGgAxRQEr4y3n"
Content-Disposition: inline
In-Reply-To: <a599db4f-8df5-3021-b610-3442d6059b01@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Jan 2023 15:41:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10324


--v5gLGgAxRQEr4y3n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>=20
>     irc:irc.libera.chat:6667/cip
>=20
> The IRC meeting is scheduled to UTC (GMT) 13:00:
>=20
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2023&mo=
nth=3D1&day=3D5&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248
>=20
> USWest    USEast    UK        DE        TW        JP
> 06:00     09:00     13:00     14:00     21:00     22:00

Sorry, I got confused and missed the meeting. I notice notes are at

https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/01/cip.2023-01-05-1=
3.02.log.html

so I'll go through them.

I did lot of reviews on 5.10.162 and 163. There is long series with

commit 466f98dac2f4908c8722b5fb23d0a1e481672f2c
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Dec 22 14:30:11 2022 -0700

    io_uring: import 5.15-stable io_uring
   =20
    No upstream commit exists.
   =20
    This imports the io_uring codebase from 5.15.85, wholesale. Changes
    from that code base:
   =20
    - Drop IOCB_ALLOC_CACHE, we don't have that in 5.10.
    - Drop MKDIRAT/SYMLINKAT/LINKAT. Would require further VFS backports,
      and we don't support these in 5.10 to begin with.
    - sock_from_file() old style calling convention.
    - Use compat_get_bitmap() only for CONFIG_COMPAT=3Dy
   =20
    Signed-off-by: Jens Axboe <axboe@kernel.dk>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

=2E..which is 16000 lines of changes. There's no reasonable way to
review that. (And it probably has implications for 4.4 / 4.19).

I guess best way forward is to still take the patches even through we
can't review them, but if anyone is using io_uring (which I'd _not_
recommend at this moment), we might want to do some extra testing, or
get the users to test it.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--v5gLGgAxRQEr4y3n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY7bvlwAKCRAw5/Bqldv6
8nN5AJsHkIQlvhaJ00HtnRqtwjvQf1BkQwCgo0UNktzFcwgR6OKIbSBzLNhWCcU=
=HaF5
-----END PGP SIGNATURE-----

--v5gLGgAxRQEr4y3n--

