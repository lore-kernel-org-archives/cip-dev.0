Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94278C3DA7F
	for <webhook@archiver.kernel.org>; Wed, 31 Jul 2024 07:54:26 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.37868.1722412459451360485
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jul 2024 00:54:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4580E1C0082; Wed, 31 Jul 2024 09:54:17 +0200 (CEST)
Date: Wed, 31 Jul 2024 09:54:16 +0200
From: Pavel Machek <pavel@denx.de>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y cip 0/8] Backport ravb driver performance
 improvements
Message-ID: <ZqntqGYravYHauM1@duo.ucw.cz>
References: <20240729150049.1924352-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Oa4MIOQYALXaiv8y"
Content-Disposition: inline
In-Reply-To: <20240729150049.1924352-1-paul.barker.ct@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jul 2024 07:54:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16690


--Oa4MIOQYALXaiv8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series includes the performance improvements present in Linux
> v6.11-rc1 along with dependencies.

That's a bit aggressive timing, is it? -rc1 does not really get much
testing.

Please avoid blank lines in the signoff area.

>   RZ/Five:
>     * 19% increase in TCP TX bandwidth
>     * 225% increase in TCP RX bandwidth
>     * >10,000% increase in UDP RX bandwidth
>         (UDP RX bandwidth was <100kbps and unstable with v6.1.101-cip25
>          so it's difficult to get an exact figure here)
>     * 6% loss in UDP TX bandwidth
>=20
> Small losses in UDP TX bandwidth are considered acceptable to achieve
> the above improvements in other test cases. If UDP TX bandwidth must be
> maximised for a particular use case, NAPI threaded mode can be disabled
> at runtime via sysfs writes.

And this wories me. One of the configurations works so badly that
tests don't even finish. You automatically select "right"
configurations in some cases, but that can't be complete fix. It would
be good to find out what is going on there, and fix not-threaded so
that it works well enough to finish tests.

Anyway... this is still not reason to block the patches, so I can
apply this if it passes testing and there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Oa4MIOQYALXaiv8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqntqAAKCRAw5/Bqldv6
8oJSAJsG6NYknItVxgICHOBr6IblnQ/fwgCaAl9Y+Zsd2F8ZLtatS5Qq2XJQCsE=
=c0k6
-----END PGP SIGNATURE-----

--Oa4MIOQYALXaiv8y--

