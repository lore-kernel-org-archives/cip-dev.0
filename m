Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38349C6FD1C
	for <webhook@archiver.kernel.org>; Thu, 23 Mar 2023 09:32:59 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.68017.1679563971599255047
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Mar 2023 02:32:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8744D1C0E52; Thu, 23 Mar 2023 10:32:48 +0100 (CET)
Date: Thu, 23 Mar 2023 10:32:48 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: xfs/setgid rewrite in 5.10 was Re: [cip-dev] New CVE entries this
 week
Message-ID: <ZBwcwEZGDg/KbtFR@duo.ucw.cz>
References: <CAODzB9q+eAUeNM0FFxZ=OypyxugvfRUMy1GZvhJp0GhNPg38ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="60JKtVY6GVSohROn"
Content-Disposition: inline
In-Reply-To: <CAODzB9q+eAUeNM0FFxZ=OypyxugvfRUMy1GZvhJp0GhNPg38ag@mail.gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Mar 2023 09:32:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11097


--60JKtVY6GVSohROn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> It's this week's CVE report.
>=20
> This week reported 6 new CVEs and 2 updated CVEs.
>=20
> * New CVEs

There is something going on with xfs/chown/setgit and probably
overlayfs. These are from 5.10.176 review:

 |73894b749 e014f3 o: 5.10| xfs: use setattr_copy to set vfs inode attribut=
es
 |be9c3268a 2b3416 o: 5.10| fs: add mode_strip_sgid() helper
 |5b02d54d5 1639a4 o: 5.10| fs: move S_ISGID stripping into the vfs_*() hel=
pers
 |b5eea92ad 11c2a8 o: 5.10| attr: add in_group_or_capable()
 |9a856d215 e243e3 o: 5.10| fs: move should_remove_suid()
 |bba459793 72ae01 o: 5.10| attr: add setattr_should_drop_sgid()
 |c2abc5886 ed5a70 o: 5.10| attr: use consistent sgid stripping checks
 |215bf9f27 8d84e3 o: 5.10| fs: use consistent setgid checks in is_sxid()
 |1c7588d55 b0463b o: 5.10| xfs: remove xfs_setattr_time() declaration

If you are using xfs or overlayfs, you may want to investigate.

If someone has corresponding CVE entry, that would be nice, too.

Best regards,
									Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--60JKtVY6GVSohROn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZBwcwAAKCRAw5/Bqldv6
8ji7AJwM3TU9WGmmnGtYwubmLk2YM6tVpwCfT1MDg3QaWpLGm5tVEUIMdaxCoFc=
=CgPR
-----END PGP SIGNATURE-----

--60JKtVY6GVSohROn--

