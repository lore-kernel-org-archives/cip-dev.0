Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB9BC433F5
	for <webhook@archiver.kernel.org>; Thu, 14 Oct 2021 06:55:57 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.5963.1634194555546868426
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Oct 2021 23:55:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9E04B1C0BB1; Thu, 14 Oct 2021 08:55:46 +0200 (CEST)
Date: Thu, 14 Oct 2021 08:55:45 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entry this week
Message-ID: <20211014065545.GA18251@amd>
References: 
 <CAODzB9qOyXSQ=P0x1CrPEC1=mCW3PUN4_Zx9hp0ZPpZWbM1WUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: 
 <CAODzB9qOyXSQ=P0x1CrPEC1=mCW3PUN4_Zx9hp0ZPpZWbM1WUw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Oct 2021 06:55:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6824


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * New CVEs
>=20
> CVE-2021-0935: bug is in ipv6 and l2tp code.
>=20
> This CVE addresses two commits, one in the ipv6 stack and the other in l2=
tp.
> There is two introduced commits one is 85cb73f ("net: ipv6: reset
> daddr and dport in sk if connect() fails") was merged in 4.12 and the
> other commit 3557baa ("[L2TP]: PPP over L2TP driver core") was merged
> in 2.6.23-rc1.
>=20
> Fixed commits have been merged since 4.16-rc7 so 4.16 or later kernels
> don't affect this vulnerability.
>=20
> Commit 2f987a76("net: ipv6: keep sk status consistent after datagram
> connect failure") fixes 85cb73f and commit b954f940("l2tp: fix races
> with ipv4-mapped ipv6 addresses") fixes commit 3557baa.
>=20
> To apply patches to 4.4, it needs to fix conflicts.
>=20
> CVSS v3 score is not provided.
>=20
> Fixed status
>=20
> mainline: [2f987a76a97773beafbc615b9c4d8fe79129a7f4,
> b954f94023dcc61388c8384f0f14eb8e42c863c5]
> stable/4.4: not fixed yet

Others are fixed, but this one may be worth watching. Fortunately it
is not remote attack, AFAICT.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmFn1HEACgkQMOfwapXb+vJOwwCcD6JHQKoPlzpu0gfHlxOXsbVU
qqAAnjjiMkADfz2fItH9gdGOG+F8tGPv
=llFL
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

