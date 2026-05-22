Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162CECD5BB0
	for <webhook@archiver.kernel.org>; Fri, 22 May 2026 09:25:20 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13402.1779441913237664323
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 May 2026 02:25:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=On0OaUpx;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 203BD10A232;
	Fri, 22 May 2026 11:25:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779441910;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Iejb5DbKHICrhWFaMLgt/VDSgupx3sJj8xNCZ2l8fsU=;
	b=On0OaUpxxaCuysVo24RHJOxgbvKnIbvKhGIu0hM3nWSG3odvTb87HzznPz46fw3bS+5kSE
	ZbYu4uUvaEqHc2+5ULyLIVIUeSS2b3ps7Q2oehWWq/CklpiSTzl/Jzchoz4HlFTeopUtHh
	CiKwnAxbgXG408tDe5XHqVqbZLGcwRH6bPxl1oOIJr+7oCYyolfqt9zsYLe7scT4KR22N6
	YPocPSH3myQwdauqqCbZjl9iZxQkWPK/CWP1cWdRthT61VtGgYnPLpNcf1PiH9Glu6GIf4
	PR+MapbuVFabFkhHxol4nK3MlXXwojLThDcZ/Cpb5Z9ho6SWCkTCTGQTYKe5Lg==
Date: Fri, 22 May 2026 11:25:06 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: pavel@nabladev.com, john.madieu.xa@bp.renesas.com,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	claudiu.beznea@tuxon.dev, john.madieu@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/17] PCI: renesas: Add RZ/G3E PCIe
 controller support
Message-ID: <ahAg8u1Qq6XhNqMW@duo.ucw.cz>
References: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
 <TY7PR01MB148184CC9DDA8E51E85ACB89ACD0E2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <ag7f8NjbSGWZA7_8@duo.ucw.cz>
 <TY7PR01MB148185260482FA754B8DF6D45CD0E2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0nHHkpp84aT9KtA3"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148185260482FA754B8DF6D45CD0E2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 May 2026 09:25:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22999


--0nHHkpp84aT9KtA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI!

> > This looks okay to me.
> >=20
> > Reviewed-by: Pavel Machek <pavel@nabladev.com>
> >=20
>=20
> Applied and pushed with Pavel's Reviewed-by tag.

Thank you. Unfortunately, this will likely cause same field_get
problems we see on 6.12. It may be best to revert to the state before
the series for now.

Best regards,
								Pavel

--0nHHkpp84aT9KtA3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCahAg8gAKCRAw5/Bqldv6
8gMkAJ0cTLTOx1vD6e5lRRk0j0jAc3jV8gCgmqctWiEtr4pVGiVulzEFfO3PZIw=
=yOeI
-----END PGP SIGNATURE-----

--0nHHkpp84aT9KtA3--

