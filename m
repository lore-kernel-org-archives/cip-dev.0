Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBC7C433F5
	for <webhook@archiver.kernel.org>; Sat, 29 Jan 2022 21:03:54 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.11206.1643490232856649411
 for <cip-dev@lists.cip-project.org>;
 Sat, 29 Jan 2022 13:03:53 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B9D471C0B77; Sat, 29 Jan 2022 22:03:47 +0100 (CET)
Date: Sat, 29 Jan 2022 22:03:47 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries in this week
Message-ID: <20220129210347.GA27693@duo.ucw.cz>
References: 
 <CAODzB9oLrBx-866T7ywB4CT4o4Nvkk8WrH-X+DGzsSMt=NswGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: 
 <CAODzB9oLrBx-866T7ywB4CT4o4Nvkk8WrH-X+DGzsSMt=NswGA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 29 Jan 2022 21:03:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7517


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
>=20

> CVE-2022-0330: drm/i915: Flush TLBs before releasing backing store
>=20
> CVSS v3 score is not provided
>=20
> Vulnerability in the i915 driver. Without an active IOMMU malicious
> userspace can gain access (from the
> code executing on the GPU) to random memory pages.
>=20
> Fixed status
>=20
> mainline: [7938d61591d33394a21bdd7797a245b65428f44c]

Wow. This must have been important. It looks like 5.10.95 (+4.4 and
4.19) was released just to get this fixed. Fix is "interesting" but...
it should be fixed.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYfWrswAKCRAw5/Bqldv6
8oRkAJ92cQ0vrfRn3tm2XWXJHas6xJgXCgCffIZvsfLCarjfIgH1ZwhP0KIQBzc=
=yXld
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

