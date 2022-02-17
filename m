Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B9CC433EF
	for <webhook@archiver.kernel.org>; Thu, 17 Feb 2022 11:55:51 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.6357.1645098949935659533
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Feb 2022 03:55:50 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DEA5E1C0B7F; Thu, 17 Feb 2022 12:55:45 +0100 (CET)
Date: Thu, 17 Feb 2022 12:55:45 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries this week
Message-ID: <20220217115545.GA18631@duo.ucw.cz>
References: 
 <CAODzB9q+vbdYe_OOuyo2+DOQQsm3x-9M7zxpEd=-R9aV9JKqZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: 
 <CAODzB9q+vbdYe_OOuyo2+DOQQsm3x-9M7zxpEd=-R9aV9JKqZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Feb 2022 11:55:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7630


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CVE-2021-33096: Improper isolation of shared resources in network on
> chip for the Intel(R) 82599 Ethernet Controllers and Adapters may
> allow an authenticated user to potentially enable denial of service
> via local access.
>=20
> CVSS v3 score is 5.5 MEDIUM
>=20
> This bug let DoS attack.Intel recommended that "Consult the
> Direct-Assignment Networking Fault Isolation in a Data Center
> Environment Prescriptive Guidance Addressing INTEL-SA-00571
> Application Note. " in their Security Advisory(INTEL-SA-00571), so
> that there is no patches for CVE-2021-33096.
>=20
> Fixed status
>=20
> Security Advisory INTEL-SA-00571 gives recommendations.

Interesting. So Intel hardware is buggy, and it is unsuitable in
certain virtualization configurations. It is a hardware problem, and
there's little we could do about it.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYg43wQAKCRAw5/Bqldv6
8o3EAKCsuVk8xgfP6YWgbyG4t2e9dGfH/ACeN1OPKbbe/W7GxJ74W4yTb4YJ5ug=
=Vmcj
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

