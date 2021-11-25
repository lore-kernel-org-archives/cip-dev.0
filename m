Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992DCC433F5
	for <webhook@archiver.kernel.org>; Thu, 25 Nov 2021 09:14:19 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.9903.1637831658583885627
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Nov 2021 01:14:19 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 32A661C0B7C; Thu, 25 Nov 2021 10:14:15 +0100 (CET)
Date: Thu, 25 Nov 2021 10:14:10 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries in this week
Message-ID: <20211125091410.GB3327@amd>
References: 
 <CAODzB9qEJUBAGggEaTmc27Lr0opreM8wv5D_HStKT6UH=+a_UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: 
 <CAODzB9qEJUBAGggEaTmc27Lr0opreM8wv5D_HStKT6UH=+a_UA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Nov 2021 09:14:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7014


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * Updated CVEs
>=20
> CVE-2021-3640: UAF in sco_send_frame function
>=20
> 5.10 and 5.15 are fixed this week.
>=20
> Fixed status
>=20
> mainline: [99c23da0eed4fd20cae8243f2b51e10e66aa0951]
> stable/5.10: [4dfba42604f08a505f1a1efc69ec5207ea6243de]
> stable/5.14: [2c2b295af72e4e30d17556375e100ae65ac0b896]
> stable/5.15: [b990c219c4c9d4993ef65ea9db73d9497e70f697]
> stable/5.4: [d416020f1a9cc5f903ae66649b2c56d9ad5256ab]

Interesting.

commit 99c23da0eed4fd20cae8243f2b51e10e66aa0951
Author: Takashi Iwai <tiwai@suse.de>

Says:

    This should be the last piece for fixing CVE-2021-3640 after a few
    already queued fixes.

Which means more than 99c23da0eed is needed to fix this one,
unfortunately it does not give us good way to identify what commits
are needed.

> CVE-2021-43975: atlantic: Fix OOB read and write in hw_atl_utils_fw_rpc_w=
ait
>=20
> The mainline kernel was fixed in 5.16-rc2.
>=20
> Fixed status
>=20
> mainline: [b922f622592af76b57cbc566eaeccda0b31a3496]

This is protection of kernel against malicious hardware. I believe we
can ignore this.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmGfU+IACgkQMOfwapXb+vLqAACgsotXJjAnw7u2qCS+M4JLQEC7
8agAnAyRlhyVpqoi0L9qBdg3DZzgLhIZ
=OBj6
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--

