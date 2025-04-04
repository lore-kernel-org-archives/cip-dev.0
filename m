Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C0AC36010
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 10:49:43 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.8007.1743763774475981626
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 03:49:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=L+Soh6iB;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D28DA1029836A;
	Fri,  4 Apr 2025 12:49:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743763772; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9nqm83lIlj4Zzn7uDmEU+O/r0yjtMQEXmhWOaw4ehIs=;
	b=L+Soh6iBZ6rpN1Z1u27YnVnHO/lXKyElzdjfIjtfzgJVUM4HdEh4eH8b4XgvQ8iNEpwF3e
	1YACwKpMt8WhPLhAJOe0w6aAldIWQ5mkfhykI6FRNB6ujSy6tbzFDVEoIhUVfsJkyFRbqj
	hlpfxG9DVRM6dXGC1tnPits1dxDgrWvXw1muDk2skoV0dggzuetQiYJEUJyszNCEjebfaT
	Tj4TFmWdTj13K8/XZe8DPxQ+V2YwrSR1EspfhJU19C9S0IjS+oWce9Ac90hocJNZcxDQ1N
	kgyN/qX8LktPuupAVY7/Kutc3AYuYKLYTz+KSxi8nXEsCGQm/Cdp8BWqFC7Xgg==
Date: Fri, 4 Apr 2025 12:49:28 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 0/9] Add RZ/G3E RIIC support
Message-ID: <Z++5OPl5iDqd91/6@duo.ucw.cz>
References: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRKtSaXvk6QrnEAN"
Content-Disposition: inline
In-Reply-To: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 10:49:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18481


--BRKtSaXvk6QrnEAN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds support for the I2C Bus Interface (RIIC) found in =
the
> Renesas RZ/G3E (R9A09G047) SoC to linux-6.1.y-cip kernel.
>=20
> All patches are cherry-picked from mainline kernel.

Ok, patches look good, I can apply them if they pass testing, unless
there are other comments... for both 6.1 and 6.12 series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--BRKtSaXvk6QrnEAN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ++5OAAKCRAw5/Bqldv6
8tAQAKCgPDM+tafiJOSmXAjpPq/v1aHMxwCfWuzIMwHENzSgCdDQ/7nYSKeXJjk=
=p05w
-----END PGP SIGNATURE-----

--BRKtSaXvk6QrnEAN--

