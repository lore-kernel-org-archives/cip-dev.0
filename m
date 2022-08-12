Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E5CC00140
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 08:22:14 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.8371.1660292528319242665
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Aug 2022 01:22:09 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D44EF1C0003; Fri, 12 Aug 2022 10:22:04 +0200 (CEST)
Date: Fri, 12 Aug 2022 10:22:04 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
Subject: Root filesystem for risc-v board
Message-ID: <20220812082204.GA16699@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 08:22:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9167


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

So... how do you get root filesystem for RISC-V board? Ideally I'd
like to get something Debian based.

Best I could try is debootstrap for Debian testing:

sudo debootstrap --no-check-gpg --foreign --arch=3Driscv64 --keyring
/usr/share/keyrings/debian-ports-archive-keyring.gpg
--include=3Ddebian-ports-archive-keyring unstable /some/suitable/dir
http://deb.debian.org/debian-ports

Unfortunately, I can't get debootstrap --second-stage to work (I get
sigsegv in ldconfig, I guess testing may be too experimental?). Is it
possible to debootstrap stable or testing distributions?

I don't think CIP project provides binary images somewhere. What is
recommended way to get a root filesystem? Is there suitable
documentation I should follow?

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYvYNrAAKCRAw5/Bqldv6
8ttYAKCp34LHP2fe87w19vK0aEBtUF6MYwCgozkqtqpbRrdHVPBoZDGxjQyirUs=
=c1pE
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

