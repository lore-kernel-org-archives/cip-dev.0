Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0CEC433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Jun 2022 12:04:53 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.16846.1655381085552664572
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jun 2022 05:04:47 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1D6AB1C0BC8; Thu, 16 Jun 2022 14:04:41 +0200 (CEST)
Date: Thu, 16 Jun 2022 14:04:40 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries this week
Message-ID: <20220616120440.GA3351@duo.ucw.cz>
References: 
 <CAODzB9qmZ1m6L8MZYUOooRYfXh5Z_uj=o=ieR+Rn9jfSmdxQQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: 
 <CAODzB9qmZ1m6L8MZYUOooRYfXh5Z_uj=o=ieR+Rn9jfSmdxQQA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jun 2022 12:04:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8570


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> It's this week's CVE report.
>=20
> This week reported 3 new CVEs and 3 updated CVEs.
>=20
> FYI: A new side-channel attack which is called "Hertzbleed Attack" has
> been published.
> This vulnerability has assigned to CVE-2022-23823 and CVE-2022-24436.
> Researchers confirmed Intel's 8th to the 11th generation Core
> microarchitecture and AMD Ryzen processors are affected but the
> haven't confirmed other processors(e.g. ARM) are affected or not.
> Intel and AMD provided guidance to mitigate the Heartbleed Attack.
> However, researchers said that Intel and AMD haven't planned to
> provide microcode patches.
>=20
> https://www.hertzbleed.com/

They certainly have good marketing and clearly want attention. Whether
they deserve attention... is hard to tell. Maybe situation will be
more clear after reading the paper.

There are three more vulnerabilities from the "fast and secure CPUs
are hard, and consumers can't easily tell CPUs are not secure as our
designs are secret" family:

+Device Register Partial Write (DRPW) (CVE-2022-21166)
+-----------------------------------------------------
+Some endpoint MMIO registers incorrectly handle writes that are smaller th=
an
+the register size. Instead of aborting the write or only copying the corre=
ct
+subset of bytes (for example, 2 bytes for a 2-byte write), more bytes than
+specified by the write transaction may be written to the register. On
+processors affected by FBSDP, this may expose stale data from the fill buf=
fers
+of the core that created the write transaction.
+
+Shared Buffers Data Sampling (SBDS) (CVE-2022-21125)
+----------------------------------------------------
+After propagators may have moved data around the uncore and copied stale d=
ata
+into client core fill buffers, processors affected by MFBDS can leak data =
=66rom
+the fill buffer. It is limited to the client (including Intel Xeon server =
E3)
+uncore implementation.
+
+Shared Buffers Data Read (SBDR) (CVE-2022-21123)
+------------------------------------------------
+It is similar to Shared Buffer Data Sampling (SBDS) except that the data is
+directly read into the architectural software-visible state. It is limited=
 to
+the client (including Intel Xeon server E3) uncore implementation.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYqscWAAKCRAw5/Bqldv6
8qgPAJ40bkewhmARx1GM7shuNV5q7ABsegCgjJqp+9ZpOMic+2XB0bM8saLeuxc=
=l1xl
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

