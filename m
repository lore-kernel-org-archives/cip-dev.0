Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F49C433EF
	for <webhook@archiver.kernel.org>; Mon, 27 Jun 2022 12:55:18 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.41097.1656334514644176147
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jun 2022 05:55:15 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 544591C0B8F; Mon, 27 Jun 2022 14:55:11 +0200 (CEST)
Date: Mon, 27 Jun 2022 14:55:10 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org,
	alice.ferrazzi@miraclelinux.com
Subject: gitlab testing down?
Message-ID: <20220627125510.GA13594@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jun 2022 12:55:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8604


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

5.10.127-rc1 is out, but there's something wrong with the testing.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/5=
73859895

                                                                           =
     =20
56There are currently 0 "qemu" devices online.
57Refusing to submit test job as there are no suitable devices available.
58There are currently 0 "qemu" devices online.
59Refusing to submit test job as there are no suitable devices available.
60

(and similar for all the targets and other trees).

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYrmorgAKCRAw5/Bqldv6
8kqpAJ4yRUMOrT2rU26I+P3zL7gvXm3yJgCePAKHZI5jy99uaE5ra7Cv1QTxE2Q=
=QRm+
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--

