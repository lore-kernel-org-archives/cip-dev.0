Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95425D2E019
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 06:15:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.2518.1729664129512184740
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Oct 2024 23:15:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 76EF01C00A2; Wed, 23 Oct 2024 08:15:26 +0200 (CEST)
Date: Wed, 23 Oct 2024 08:15:26 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com,
	Cedric Hombourger <Cedric_Hombourger@mentor.com>
Subject: Re: [ANNOUNCE] v6.1.111-cip29-rt16 (rt42)
Message-ID: <ZxiUfpco2aJapBrI@duo.ucw.cz>
References: <ZwezX12F5AOLW6rU@duo.ucw.cz>
 <42448455-fc7f-4dbf-9bfe-ee741128bf21@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B69iG8nuCWMdXHJp"
Content-Disposition: inline
In-Reply-To: <42448455-fc7f-4dbf-9bfe-ee741128bf21@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Oct 2024 06:15:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17071


--B69iG8nuCWMdXHJp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > New realtime trees should be available at kernel.org.
> >=20
> > Trees are available at
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-6.1.y-cip-rt
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-6.1.y-cip-rt-rebase
> >=20
> > And their content should be identical. There are also tar archives, at:
> >=20
> > https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
> >=20
>=20
> Cedric pointed out that localversion-cip-rt of this release was not
> updated. Is that not happening via some release script? Can we do that
> in future to avoid such glitches?

Sorry about that. Yes, I'm slowly scripting it, but it is hard due to
different releases being different (-cip vs. -cip-rt and 4.4 vs. rest)
and due to way that part is local, part is web-based, and part is
email-based.

What do we do here? Just live with the glitch?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--B69iG8nuCWMdXHJp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZxiUfgAKCRAw5/Bqldv6
8tyXAKCG5izsL9XjF/owpqC9D9vBgF+nnACdHKWP6Kb8vv5mt1Pw+6E+7h8MEYg=
=plhU
-----END PGP SIGNATURE-----

--B69iG8nuCWMdXHJp--

