Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD274C4345F
	for <webhook@archiver.kernel.org>; Sun, 21 Apr 2024 14:20:24 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.32787.1713709219524630696
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Apr 2024 07:20:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 138AA1C0080; Sun, 21 Apr 2024 16:20:18 +0200 (CEST)
Date: Sun, 21 Apr 2024 16:20:17 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 19/53] clk: renesas: rzg2l: Remove
 CPG_SDHI_DSEL from generic header
Message-ID: <ZiUgoWIMIR7yn8Fg@duo.ucw.cz>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
 <20240419081742.3496709-20-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7tIB4ja03HQh1lmY"
Content-Disposition: inline
In-Reply-To: <20240419081742.3496709-20-claudiu.beznea.uj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 21 Apr 2024 14:20:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15716


--7tIB4ja03HQh1lmY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +++ b/drivers/clk/renesas/r9a07g043-cpg.c
> @@ -14,6 +14,13 @@
> =20
>  #include "rzg2l-cpg.h"
> =20
> +/* Specific registers. */
> +#define CPG_PL2SDHI_DSEL	(0x218)
> +

We should not really need () around single number.=20

> +++ b/drivers/clk/renesas/rzg2l-cpg.h
> @@ -19,7 +19,6 @@
>  #define CPG_PL2_DDIV		(0x204)
>  #define CPG_PL3A_DDIV		(0x208)
>  #define CPG_PL6_DDIV		(0x210)
> -#define CPG_PL2SDHI_DSEL	(0x218)
>  #define CPG_CLKSTATUS		(0x280)
>  #define CPG_PL3_SSEL		(0x408)
>  #define CPG_PL6_SSEL		(0x414)

Aha, I see its for consistency, still... No need to fix this, I guess,
but don't add new ones.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7tIB4ja03HQh1lmY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZiUgoQAKCRAw5/Bqldv6
8t7zAJ0ai/2Mf4gGSbdstmEZS+g6TVd3FgCfcJtAeCkrciejRqidrlltFIwGtdI=
=p9QX
-----END PGP SIGNATURE-----

--7tIB4ja03HQh1lmY--

