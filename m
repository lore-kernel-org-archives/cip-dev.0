Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86658C4345F
	for <webhook@archiver.kernel.org>; Sun, 21 Apr 2024 14:15:54 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.32778.1713708948254022268
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Apr 2024 07:15:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C52C31C0080; Sun, 21 Apr 2024 16:15:46 +0200 (CEST)
Date: Sun, 21 Apr 2024 16:15:46 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 03/53] clk: renesas: rzg2l: Trust value
 returned by hardware
Message-ID: <ZiUfkth+hLTsfFWk@duo.ucw.cz>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
 <20240419081742.3496709-4-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xqv94ob+PCeLBQPO"
Content-Disposition: inline
In-Reply-To: <20240419081742.3496709-4-claudiu.beznea.uj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 21 Apr 2024 14:15:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15713


--Xqv94ob+PCeLBQPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The onitial value of the CPG_PL2SDHI_DSEL bits 0..1 or 4..6 is 01b.  The

"initial", I guess. but its too late to fix that.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Xqv94ob+PCeLBQPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZiUfkgAKCRAw5/Bqldv6
8trvAJoD8cVFvfI5OGK5RQ6gt+Z2fIHMJgCdFUf49f5IVq/9z6mBjgtpuaCJce8=
=nbbt
-----END PGP SIGNATURE-----

--Xqv94ob+PCeLBQPO--

