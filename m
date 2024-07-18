Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89364C3DA60
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 08:16:39 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.10376.1721290593989231180
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 01:16:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EB6671C0099; Thu, 18 Jul 2024 10:16:30 +0200 (CEST)
Date: Thu, 18 Jul 2024 10:16:30 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: Re: [ANNOUNCE] 4.4.302-cip89-rt50
Message-ID: <ZpjPXtOQuyJeKci1@duo.ucw.cz>
References: <ZpgiKy1r4em0IbEh@duo.ucw.cz>
 <d6bdd6c5-bd0f-4cb6-baff-8330bcdfebde@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CJHkUfnV99oZsGMc"
Content-Disposition: inline
In-Reply-To: <d6bdd6c5-bd0f-4cb6-baff-8330bcdfebde@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 08:16:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16577


--CJHkUfnV99oZsGMc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > New realtime trees should be available at kernel.org.
> >=20
> > Trees are available at
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-4.4.y-cip-rt
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-4.4.y-cip-rt-rebase
> >=20
> > And their content should be identical. There are also tar archives, at:
> >=20
> > https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
>=20
> It's not yet there - hick-up of the infrastructure or something
> forgotten during the release?

It went to wrong directory. I'll generate one to the right directory
and ask for the other one to be deleted.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--CJHkUfnV99oZsGMc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZpjPXgAKCRAw5/Bqldv6
8iHcAJ0U3Ey3vxFvjgV0KxV0hvYtwrwH6gCfRLn1g8z+FqZnyrJ4sbuy4eOfbLw=
=Ivq9
-----END PGP SIGNATURE-----

--CJHkUfnV99oZsGMc--

