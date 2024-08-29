Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD6EC8302E
	for <webhook@archiver.kernel.org>; Thu, 29 Aug 2024 10:11:23 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.9434.1724926276068221697
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Aug 2024 03:11:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: ucw.cz, ip: 46.255.230.98, mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A36E91C0082; Thu, 29 Aug 2024 12:11:12 +0200 (CEST)
Date: Thu, 29 Aug 2024 12:11:12 +0200
From: Pavel Machek <pavel@denx.de>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y cip v2 0/9] Backport ravb driver performance
 improvements
Message-ID: <ZtBJQFzUpgQ8yDjB@duo.ucw.cz>
References: <20240827210609.12695-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96GvxS2n73VYrYih"
Content-Disposition: inline
In-Reply-To: <20240827210609.12695-1-paul.barker.ct@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Aug 2024 10:11:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16832


--96GvxS2n73VYrYih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Small losses in UDP TX bandwidth are considered acceptable to achieve
> the above improvements in other test cases. If UDP TX bandwidth must be
> maximised for a particular use case, NAPI threaded mode can be disabled
> at runtime via sysfs writes.

> Changes v1->v2:
>   * Added Geert's patch to ensure that PAGE_PAGE is enabled.
>   * Added Pavel's Reviewed-by tag to patches 1-8.
>   * Removed unnecessary whitespace in commit messages.

Thank you. There were no comments last time, and it passes testing
now, so I applied the series.

I still don't believe this is complete fix, as I explained
before. System should work without major starvation issue with both
NAPI on and NAPI off.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--96GvxS2n73VYrYih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZtBJQAAKCRAw5/Bqldv6
8h0RAKCP55AzI+UqweBcfOf0fnc8c+6PngCeNYK6UxyXSoWMZf+Xl4GBIYBeedQ=
=CzM+
-----END PGP SIGNATURE-----

--96GvxS2n73VYrYih--

