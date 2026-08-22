Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E73CC5DF97
	for <webhook@archiver.kernel.org>; Sat, 22 Aug 2026 08:13:12 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3003.1787386387322230710
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Aug 2026 01:13:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=V+7LuT74;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 526DA11C00C;
	Sat, 22 Aug 2026 10:13:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787386381;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=GgX4lSwyuNgvSU8rNmP0wyXni5xpzbrUrqLpKlzIbeg=;
	b=V+7LuT74w98tFx2A2QtnD3jhDTNjPcuB9H7dnzYISVGRrx16xoHv2W64DGVnLMWM8qdQMa
	Xtv+hknK3r4smfCsZjGLW/0TOqKT7LntMGsXOamcvgs39UsLiZpvHHODZD1tivnnppp87o
	YzXbMfxYOFiHs7hAtSipMXTN7y3pUnDmrNwemKyV30uzLp+e2J3DNp9XzY0fT1ERh09R/g
	QYBiQqnlgGrKaUF/vy50eD4lD2lQXcja8tbpaoBB4OGcYi/PKSq8xoehmvS6poX8vOqcMa
	7dL+kfbSFc++OZiFMEGUlO8s1RrPz+52FNL+B47MITEhbPLdH4mEm51IGd01qg==
Date: Sat, 22 Aug 2026 10:12:59 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com, uli@fpond.eu,
	biju.das.jz@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip] serial: rsci: Fix symbol namespace
 of MODULE_IMPORT_NS()
Message-ID: <aolaC10D2GVjTNMa@duo.ucw.cz>
References: <1787270513-25812-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xF1PC50OkE9klpud"
Content-Disposition: inline
In-Reply-To: <1787270513-25812-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Aug 2026 08:13:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23977


--xF1PC50OkE9klpud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> In linux-6.1.y, the namespace specified in MODULE_IMPORT_NS() does not
> require a string. This removes the quotes from the namespace name.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel

> +++ b/drivers/tty/serial/rsci.c
> @@ -15,7 +15,7 @@
>  #include "serial_mctrl_gpio.h"
>  #include "rsci.h"
> =20
> -MODULE_IMPORT_NS("SH_SCI");
> +MODULE_IMPORT_NS(SH_SCI);
> =20
>  /* RSCI registers */
>  #define RDR	0x00


--xF1PC50OkE9klpud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaolaCwAKCRAw5/Bqldv6
8uanAJkBZEGFzPvCy5w/0V3JGp9QfK4GCACePBgZeMLk7SXmG+70DGmP3l3xJxo=
=do+o
-----END PGP SIGNATURE-----

--xF1PC50OkE9klpud--

