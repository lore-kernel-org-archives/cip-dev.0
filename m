Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FA0C433F5
	for <webhook@archiver.kernel.org>; Thu, 25 Nov 2021 09:53:54 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.10307.1637834029334502990
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Nov 2021 01:53:50 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5DD7A1C0BA9; Thu, 25 Nov 2021 10:53:45 +0100 (CET)
Date: Thu, 25 Nov 2021 10:53:39 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: CVE-2021-3640: UAF in sco_send_frame function was Re: [cip-dev] New
 CVE entries in this week
Message-ID: <20211125095339.GC3327@amd>
References: 
 <CAODzB9qEJUBAGggEaTmc27Lr0opreM8wv5D_HStKT6UH=+a_UA@mail.gmail.com>
 <16BABF37827ACD8B.14741@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <16BABF37827ACD8B.14741@lists.cip-project.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Nov 2021 09:53:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7015


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > CVE-2021-3640: UAF in sco_send_frame function
> >=20
> > 5.10 and 5.15 are fixed this week.
> >=20
> > Fixed status
> >=20
> > mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951]
> > stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de]
> > stable/5.14: [2c2b295af72e4e30d17556375e100ae65ac0b896]
> > stable/5.15: [b990c219c4c9d4993ef65ea9db73d9497e70f697]
> > stable/5.4: [d416020f1a9cc5f903ae66649b2c56d9ad5256ab]
>=20
> Interesting.
>=20
> commit 99c23da0eed4fd20cae8243f2b51e10e66aa0951
> Author: Takashi Iwai <tiwai@suse.de>
>=20
> Says:
>=20
>     This should be the last piece for fixing CVE-2021-3640 after a few
>     already queued fixes.
>=20
> Which means more than 99c23da0eed is needed to fix this one,
> unfortunately it does not give us good way to identify what commits
> are needed.

Aha, but we have required information in
cip-kernel-sec/issues/CVE-2021-3640.yml. It lists patches that should
be fixing this.

Some searching in the trees reveals that one of those patches is buggy
itself, and additionaly 49d8a5606428ca0962d09050a5af81461ff90fbb is
needed.

The patches fixing this are:

~  stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de,
                f2f856b65ac4b77049c76c0e89ecd3a177e9fcd1,
 		98d44b7be6f1bcfd4f824c5f8bc2b742f890879f,
 		c20d8c197454068da758a83e09d93683f520d681,
 		a1073aad497d0d071a71f61b721966a176d50c08]

But we still miss backport of 27c24fda62b6 ("Bluetooth: switch to
lock_sock in SCO") to 5.10, which has its own prerequisites
according to the changelog. AFAICT those prerequisites are
734bc5ff783115aa3164f4e9dd5967ae78e0a8ab and
ba316be1b6a00db7126ed9a39f9bee434a508043, and both are in 5.10.

I'm not sure how to express this in yml cleanly. I came with this:

diff --git a/issues/CVE-2021-3640.yml b/issues/CVE-2021-3640.yml
index fb52d5a..d386093 100644
--- a/issues/CVE-2021-3640.yml
+++ b/issues/CVE-2021-3640.yml
@@ -23,9 +23,23 @@ comments:
     there is no fixed information as of 2021/07/26.
     Fixed in bluetooth-next tree. commit 99c23da0eed4fd20cae8243f2b51e10e6=
6aa0951.
   ubuntu/sbeattie: Possibly addressed by Desmond Cheong Zhi Xi's patchset.
+  pavel: We are one patch away from fixing this 5.10, 27c24fda62b6 is need=
ed.
 fixed-by:
-  mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951]
-  stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de]
+  mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951,
+  	     e04480920d1eec9c061841399aa6f35b6f987d8b,
+	     734bc5ff783115aa3164f4e9dd5967ae78e0a8ab,
+	     49d8a5606428ca0962d09050a5af81461ff90fbb,
+	     ba316be1b6a00db7126ed9a39f9bee434a508043,
+	     27c24fda62b601d6f9ca5e992502578c4310876f,
+	     734bc5ff783115aa3164f4e9dd5967ae78e0a8ab,
+	     ba316be1b6a00db7126ed9a39f9bee434a508043]
+  stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de,
+    	        f2f856b65ac4b77049c76c0e89ecd3a177e9fcd1,
+		98d44b7be6f1bcfd4f824c5f8bc2b742f890879f,
+		c20d8c197454068da758a83e09d93683f520d681,
+		a1073aad497d0d071a71f61b721966a176d50c08,
+		98d44b7be6f1bcfd4f824c5f8bc2b742f890879f,
+		a1073aad497d0d071a71f61b721966a176d50c08]
   stable/5.14: [2c2b295af72e4e30d17556375e100ae65ac0b896]
   stable/5.15: [b990c219c4c9d4993ef65ea9db73d9497e70f697]
   stable/5.4: [d416020f1a9cc5f903ae66649b2c56d9ad5256ab]

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmGfXSMACgkQMOfwapXb+vI2PgCbBpn1RLhRm/YoL9QkG7WweXAy
sP4AoJOIBcZQ03WVcxwqGl6EsipqVcEo
=e8It
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--

