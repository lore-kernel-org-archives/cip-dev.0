Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19F9C04E69
	for <webhook@archiver.kernel.org>; Thu, 27 Jul 2023 09:26:28 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.3556.1690449979078858182
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jul 2023 02:26:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 66F361C0A9F; Thu, 27 Jul 2023 11:26:15 +0200 (CEST)
Date: Thu, 27 Jul 2023 11:26:14 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries this week
Message-ID: <ZMI4NgQK+Yak7o2A@duo.ucw.cz>
References: <CAODzB9p4_fh21bZoSMyMiF2QKDqE09kZ0b7mHR99LEw0mCF=ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XmrIcvkVBQecKPGv"
Content-Disposition: inline
In-Reply-To: <CAODzB9p4_fh21bZoSMyMiF2QKDqE09kZ0b7mHR99LEw0mCF=ww@mail.gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jul 2023 09:26:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12507


--XmrIcvkVBQecKPGv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> It's this week's CVE report.
>=20
> This week reported 8 new CVEs and 5 updated CVEs.
>=20
> CVE-2023-20593 is the Zenbleed vulnerability which is not a kernel
> vulnerability.  However, the Linux kernel added mitigation code.
> CVE-2023-2640 and CVE-2023-32629 are Ubuntu kernel specific
> vulnerabilities, so mainline/stable/cip kernels aren't affected.

Thank you for the report.

> * New CVEs
>=20
> CVE-2023-3611: net/sched: sch_qfq: account for stab overhead in qfq_enque=
ue
>=20
> CVSS v3 score is not provided(NVD).
> CVSS v3 score is not 7.8 HIGH(CNA).

I'm a bit confused. Is this trying to say that score _is_ 7.8?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--XmrIcvkVBQecKPGv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZMI4NgAKCRAw5/Bqldv6
8it7AKCHqGj/KlfcxESV5cdpaSmeCi3pLACfYb6SI8gu4H9L+bi03yOEM++WnDA=
=FNFv
-----END PGP SIGNATURE-----

--XmrIcvkVBQecKPGv--

