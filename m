Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E09C4332F
	for <webhook@archiver.kernel.org>; Sun, 13 Nov 2022 16:27:24 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.3992.1668356836665186312
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Nov 2022 08:27:17 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9C0F41C09ED; Sun, 13 Nov 2022 17:27:13 +0100 (CET)
Date: Sun, 13 Nov 2022 17:27:13 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: 4.4-st-rc updated with patches up-to 4.9.328
Message-ID: <Y3Ea4T2hx8Sq/CdK@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="073O3D00B2qJm6he"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 13 Nov 2022 16:27:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10033


--073O3D00B2qJm6he
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Results were pushed to -st-rc.

I have added "KNOWN-BUGS" with ... well.. some documentation, and
commit f077ac447faf72436e0a7e153695bbf1fccbcd68 is worth
checking. Unfortunately, that tcp stuff is rather "random" and I'm not
sure if we are testing it efficiently.

Best regards,
								Pavel

commit 3564fad7204ed8fc2e8b7eea19bface6e1fabfd7
Author: Pavel Machek <pavel@ucw.cz>
Date:   Thu Nov 10 22:01:55 2022 +0100

    tcp: Fix missmerge in perturb table handling
   =20
    I left duplicate code after the merge, and it was causing a
    warning. This should fix it, but I'm not sure how to test it.
   =20
    Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 73bebd4239b15..ee9a76ac24fed 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -597,16 +597,8 @@ ok:
 		 * it may be inexistent.
 		 */
 		i =3D max_t(int, i, (prandom_u32() & 7) * 2);
-		WRITE_ONCE(table_perturb[index], READ_ONCE(table_perturb[index]) + i + 2=
);
+		WRITE_ONCE(table_perturb[index], (READ_ONCE(table_perturb[index]) + i + =
2) & ~1);
 	=09
-		/* If our first attempt found a candidate, skip next candidate
-		 * in 1/16 of cases to add some noise.
-		 */
-		if (!i && !(prandom_u32() % 16))
-			i =3D 2;
-
-		WRITE_ONCE(table_perturb[index], READ_ONCE(table_perturb[index]) + (i + =
2) & ~1);
-
 		/* Head lock still held and bh's disabled */
 		inet_bind_hash(sk, tb, port);
 		if (sk_unhashed(sk)) {

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--073O3D00B2qJm6he
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY3Ea4QAKCRAw5/Bqldv6
8mEWAJ9Hxd2RlJBdmdJVBlQrQD/0G2TNwwCePL3Y7oQIej6p/8/gXOalGRuZ72M=
=vUhG
-----END PGP SIGNATURE-----

--073O3D00B2qJm6he--

