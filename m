Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C3CC369D1
	for <webhook@archiver.kernel.org>; Thu, 24 Apr 2025 11:10:43 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.12428.1745493037639891144
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Apr 2025 04:10:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=CRzSfgd2;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0BC3310275AF1;
	Thu, 24 Apr 2025 13:10:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745493035; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=5tf+HrvS0c8jKMAx9rA3EmIAEh5jvKXLHmoA5TU4n5k=;
	b=CRzSfgd2+aB1v/tVicy3Lf5mAAT/KqDgEV4xP7PvI6efm+XF+K01kiJ+HAR+VwirWPYeb+
	z0Vn2A6dyi4J/JfIp3uq2ZfeovYqo2G3Lc38UCntmj7dMWPRn9rHETYfArJ2zRqh6d89KK
	unP5dqW5SiGyW2M2WfERfGfg9m65L8r77eIe8dmH2lcoKEebwowXalCeSmAqr6mtIvp28H
	a8DLqnY1BnEQR4Z2hc3Kls5VyYlnqgRcom4KvjBcHQhhZjKMpMDiprxzMg/thXsaFC5TeO
	qmsbMoKPG8WmCXzBm+71YowR1izJZNOH3kCGFqxgyi1M1Q5xMUkYxVsbncTaVg==
Date: Thu, 24 Apr 2025 13:10:29 +0200
From: Pavel Machek <pavel@denx.de>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip] clk: renesas: r9a07g044: Add clock
 and reset entry for DRP-AI
Message-ID: <aAocJbbP7I+9GtfP@duo.ucw.cz>
References: <20250422123255.7722-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XXrlO+xAyrBYkO46"
Content-Disposition: inline
In-Reply-To: <20250422123255.7722-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Apr 2025 11:10:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18598


--XXrlO+xAyrBYkO46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 989d673ff7c461b2abd472227fdb7df69860d23f upstream.
>=20
> Add clock and reset entries for the DRP-AI block, which is available only
> on the Renesas RZ/V2L SoC.

Thank you, applied.

Best regards,
									Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--XXrlO+xAyrBYkO46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAocJQAKCRAw5/Bqldv6
8nMYAJ9aduZ3C/51TjGTzOJVLJrqIwxovgCbBlVwUpU1vK/hN0NJRpFgOAURiUc=
=q1oY
-----END PGP SIGNATURE-----

--XXrlO+xAyrBYkO46--

