Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C93C433EF
	for <webhook@archiver.kernel.org>; Thu, 30 Dec 2021 10:20:47 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.62749.1640859646207530191
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Dec 2021 02:20:47 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B4FE61C0B77; Thu, 30 Dec 2021 11:20:39 +0100 (CET)
Date: Thu, 30 Dec 2021 11:20:38 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries in this week
Message-ID: <20211230102038.GA7207@amd>
References: 
 <CACOXgS9X11kXTPC+ukH2aommTWahwWSuAcuqXveZPpT2YiNBZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: 
 <CACOXgS9X11kXTPC+ukH2aommTWahwWSuAcuqXveZPpT2YiNBZw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Dec 2021 10:20:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7310


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CVE-2021-45469: f2fs: fix to do sanity check on last xattr entry in
> __f2fs_setxattr()
>=20
> CVSS v3 score is not provided
>=20
> OOB access bug in  __f2fs_setxattr().
>=20
> Although it is fixed in stable trees, the patch isn't merged in the
> mainline yet at 2021/12/30. The commit 5598b24 ("f2fs: fix to do
> sanity check on last xattr entry in __f2fs_setxattr()") is in
> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=
=3Ddev&id=3D5598b24efaf4892741c798b425d543e4bed357a1
> but not in the mainline.
>=20

Interesting. That's wrong and unusual for stable tree.

> CVE-2021-45480: rds: memory leak in __rds_conn_create()
>=20
> CVSS v3 score is not provided
>=20
> This bug was introdued by commit aced3ce57cd3 ("RDS tcp loopback
> connection can hang") which was merged at 5.13-rc4.

It was also merged in 4.19-stable as 0a3158ac5999fe. That's why we see
4.19 tree needing the fix. 4.4 is not affected. Good.

> mainline: [5f9562ebe710c307adc5f666bf1a2162ee7977c0]
> stable/4.19: [1ed173726c1a0082e9d77c7d5a85411e85bdd983]

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHNh/YACgkQMOfwapXb+vKSnACgoR7gh4hQZYyDOWSm1VPt/PG+
rWMAnjXq3e0nvhk/yyhPDIYKJWNliwFA
=tbeC
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

