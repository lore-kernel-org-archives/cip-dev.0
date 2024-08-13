Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0CCC52D7B
	for <webhook@archiver.kernel.org>; Tue, 13 Aug 2024 15:30:14 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.75359.1723563006954832821
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Aug 2024 08:30:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 484481C008E; Tue, 13 Aug 2024 17:30:04 +0200 (CEST)
Date: Tue, 13 Aug 2024 17:30:03 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [ANNOUNCE] v6.1.102-cip26
Message-ID: <Zrt7+75ZR2DxGpi4@duo.ucw.cz>
References: <ZrjoeDL95EC/rBlE@duo.ucw.cz>
 <9fe32cd5-7159-4e53-b8e1-3db1f29fe383@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H8Hxyesh2GcV1FLJ"
Content-Disposition: inline
In-Reply-To: <9fe32cd5-7159-4e53-b8e1-3db1f29fe383@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Aug 2024 15:30:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16782


--H8Hxyesh2GcV1FLJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > New -cip release should be available at kernel.org.
> >=20
> > Trees are available at
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-6.1.y-cip
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-6.1.y-cip-rebase
> >=20
> > And their content should be identical.
> >=20
> > There are also tar archives, at:
> >=20
> > https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
>=20
> Did you push the tarball of this as well? I find 6.1.101-cip26-rt14 but
> only 6.1.101-cip25.

Let me retry. I got some weird problems with tags while pushing (it
seemed like linux-6.1.y-cip is not only head but also some other
object type).

Hopefully it works. If not, at least I should get some kind of error
message in my inbox.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--H8Hxyesh2GcV1FLJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZrt7+wAKCRAw5/Bqldv6
8lUXAKC1jBUOQzcLyAVJggTyKOeTuX6gTwCgqumkdZE6NFGLevtLF8GZ4sGa9Xs=
=e8hR
-----END PGP SIGNATURE-----

--H8Hxyesh2GcV1FLJ--

