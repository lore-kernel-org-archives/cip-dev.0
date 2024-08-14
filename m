Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2CDC3DA4A
	for <webhook@archiver.kernel.org>; Wed, 14 Aug 2024 10:30:30 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.94891.1723631422057315678
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Aug 2024 03:30:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A473F1C008E; Wed, 14 Aug 2024 12:30:19 +0200 (CEST)
Date: Wed, 14 Aug 2024 12:30:19 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [ANNOUNCE] v6.1.102-cip26
Message-ID: <ZryHO8+6w0DseQZI@duo.ucw.cz>
References: <ZrjoeDL95EC/rBlE@duo.ucw.cz>
 <9fe32cd5-7159-4e53-b8e1-3db1f29fe383@siemens.com>
 <Zrt/a+EkczsJFeGp@duo.ucw.cz>
 <034146a1-95b8-421b-9d3d-1070b2a162a5@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o/+Pj8nB9cgEqYG/"
Content-Disposition: inline
In-Reply-To: <034146a1-95b8-421b-9d3d-1070b2a162a5@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Aug 2024 10:30:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16787


--o/+Pj8nB9cgEqYG/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Did you push the tarball of this as well? I find 6.1.101-cip26-rt14 but
> >> only 6.1.101-cip25.
> >=20
> > So tarball should now be there.
>=20
> Thanks, works now.
>=20
> Without knowing all the details: I have the impression that there are
> traps in the upload process so far. Maybe it is possibly to automate
> them further and also share that automation across the cip maintainers?

We already use the script we got from kernel.org, but yes, it is a bit
unfriendly. Basically you go from shell workflow to web for testing,
back to shell, and then to email for tar creation. I'll try to improve
this.

Best regards,
								pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--o/+Pj8nB9cgEqYG/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZryHOwAKCRAw5/Bqldv6
8iVMAKC7mntSQggj4jlocEQafXsdze4/jACfc7A2azvIQqpQNlLkExXcS69qiAI=
=QaCH
-----END PGP SIGNATURE-----

--o/+Pj8nB9cgEqYG/--

