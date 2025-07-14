Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3624BC83F1B
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:31:01 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.75217.1752489058618525757
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:30:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=PboR4Qq9;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 776B610397286;
	Mon, 14 Jul 2025 12:30:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752489056; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=5VTKA6qG1e1qugw7nOg9qhLte4WJbgnzsC545sA530s=;
	b=PboR4Qq9DFEO/mZ6GzTJRXcU51AL/BiOzWDlr9YG+i7O8vvZjEriJzFiG/rU0FB1Z7eXjo
	zygZM5CETbrUf95Gu/CQXQunkEltFqZPzlgB1wcUsOSIesV78M54t+lZ5zxJ+ovFev5aZG
	N1QZiLnd5VKrrUNlQCo+++8H0DfJ09mgIFeFcI+/xEcg9sePvRkP4ybhP+UbCg+1cFMGd4
	xh1PTZm2Vc4C+zsT8sDdH+lOmHSVegWxod5SaNeH2ChQWGcdjPevJHcoBp7025TcW8INsl
	4d4iZwsKNjonmRnIOJpcDPH10C1EGVe9Balr9lNTyLzS8GWDR2shO+qt8joAdA==
Date: Mon, 14 Jul 2025 12:30:50 +0200
From: Pavel Machek <pavel@denx.de>
To: biju.das.jz@bp.renesas.com
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 0/7] RZ/G2L DU enhancements
Message-ID: <aHTcWm1P9L7Ox/Uw@duo.ucw.cz>
References: <20250711182705.346314-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WHE1vMxbO6KDRaC"
Content-Disposition: inline
In-Reply-To: <20250711182705.346314-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:31:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19524


--/WHE1vMxbO6KDRaC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series for enhancing RZ/G2L DU driver.
> All the patches are cherry-picked from mainline.

Thank you, applied.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/WHE1vMxbO6KDRaC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaHTcWgAKCRAw5/Bqldv6
8girAKC2duc/jm/EjINbbkgCRJ8f4iXFlACfWJ93gGiUkU/SA4wkgOuUmDjOal0=
=e62h
-----END PGP SIGNATURE-----

--/WHE1vMxbO6KDRaC--

