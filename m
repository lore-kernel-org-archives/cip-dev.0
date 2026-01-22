Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F9EC44500
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 10:47:18 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34637.1769078835510009828
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Jan 2026 02:47:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=EC3/xHgH;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B28FE10E1DF;
	Thu, 22 Jan 2026 11:47:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1769078833;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=a4MFmmLHyuZUlyybCbnCeKWGnR93fqDuelCHJjGnc90=;
	b=EC3/xHgHNNJpOAwaFnhdZ/qSk6i5JJfZiy5SrvqJW0bnQFLXrEEoj4FXJjyyL/EJJ9aKCI
	Ez0FUg+vJCog66+P6QgpP943Xwjh6kocTEC0mUHKKFCL4OPXLUmOyoMSZkr5IFNS6f7zjy
	QReJXlHzBR88gWkK7Cbnwj/8DQtjTNpTrNbRaGgeaCx20pRBmzM5Ny8dnQY1UtBE8XScmn
	FjvgUZ0FamK+tMOI8dfJJ9cYaWjOZAS6N91WEyWD1oNsQhnE7oZTuVzYlH250JfbsQMuL7
	eVYmcRcOsJYVqRl5yNOq0fBOIiiOC9Z2BxQpb/TQNPSV0NEyBB3iZlXmH7UNZw==
Date: Thu, 22 Jan 2026 11:47:10 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip v3 00/18] RZ/{G2L, G2LC, G2UL, G3S, Five,
 V2L}: Backport MSTOP support
Message-ID: <aXIALj2xjzefpk/u@duo.ucw.cz>
References: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CFSLaxFoRkxyPX7A"
Content-Disposition: inline
In-Reply-To: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jan 2026 10:47:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21700


--CFSLaxFoRkxyPX7A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the MSTOP (Module Stop) support for the Renesas
> RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/G3S, RZ/Five, RZ/V2L SoCs.
>=20
> The purpose of MSTOP is to reduce power consumption by stopping
> unnecessary module's functions.
>=20
> If any master accesses a module that has the clock stopped and the
> MSTOP bit set, a bus error will occur.
>=20
> Due to this, to avoid CPU generating synchronous aborts, changes
> to PM domain specific code were needed. The changes backported in
> this series were adjusted to be executed only for the above
> mentioned Renesas SoCs.

Thank you, applied and pushed out.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--CFSLaxFoRkxyPX7A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaXIALgAKCRAw5/Bqldv6
8o+/AJ4hrQgI4CX3pzvsYFQ88MWGStpK4QCgknifmekBoYPs8h3MOMYFB1SWxok=
=xThi
-----END PGP SIGNATURE-----

--CFSLaxFoRkxyPX7A--

