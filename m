Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885C7C36014
	for <webhook@archiver.kernel.org>; Tue,  1 Apr 2025 10:26:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.15616.1743503189190459390
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Apr 2025 03:26:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=dofvLnok;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 60C6E101CF951;
	Tue,  1 Apr 2025 12:26:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743503187; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=yFAeSHNZmJp9MbLwV8Xp9n1h81qf/dNNDuQWLCWhTuM=;
	b=dofvLnokFzaT80syTfxikQZHjy5jv+3E9sRKfQaMBevggB7OVX9zXha5BpVp8WH+Co17Q5
	/nEcAPHu7WgMJjw1fCUHce0fO7iUKL0+7KbyL0eFXTR62DnDGh9y3XrpWoboYrOQAADq87
	J02faNw0WygQUeJPzx/JKkSnRSAjEgTHADzBEJLTLVN3fN9IzqpyguisJPJn2nNnRT1vqa
	RSIqRnweYTbt1LMQmCJxDZ0xMIGFapCGIhNyZrXSB6k7UeVIHDxRCl1owHsjLx/6pWa3Hs
	n6Yf/kVg3YHHroD7JAT35r2N4JX6r4rGDfEIwA0zu+8c7hD/JnNO+0Dc3bjTEg==
Date: Tue, 1 Apr 2025 12:26:19 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 05/13] pinctrl: renesas: rzg2l: Move
 RZG2L_SINGLE_PIN definition to top of the file
Message-ID: <Z+u/S2MaYNST5kNl@duo.ucw.cz>
References: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
 <20250331110659.252237-6-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3BYMnc7ZPIDN8g7d"
Content-Disposition: inline
In-Reply-To: <20250331110659.252237-6-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Apr 2025 10:26:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18446


--3BYMnc7ZPIDN8g7d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 13dcd63dc704b33a8ad94f1d161c0f5dad243a5b upstream.
>=20
> Define `RZG2L_SINGLE_PIN` at the top of the file to clarify its use for
> dedicated pins for improved readability.
>=20
> While at it update the comment for `RZG2L_SINGLE_PIN_PACK` macro and place
> it just above the macro for clarity.

Changelog no longer matches the patch.

> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
> index 5081c7d8064fa..b47f0f1257cff 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -65,6 +65,8 @@
>  #define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
>  #define RZG2L_VARIABLE_CFG		BIT_ULL(62)	/* Variable cfg for port pins */
> =20
> +#define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
> +

And the patch was already applied, see the previous defines. I believe
we can just drop this one safely.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3BYMnc7ZPIDN8g7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+u/SwAKCRAw5/Bqldv6
8gTIAJ9pqjethR5mT5fbaangjYnyTflOzwCgoF3HaFV7XUvuGQZK6v0kLJBLVXY=
=uvtC
-----END PGP SIGNATURE-----

--3BYMnc7ZPIDN8g7d--

