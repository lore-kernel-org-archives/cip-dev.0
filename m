Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61998D4A619
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 09:54:55 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2654.1768557291652859771
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jan 2026 01:54:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=hXutdkG/;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C528910E46D;
	Fri, 16 Jan 2026 10:54:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768557289;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=c97YTrSDH8dMRcmSxUG0rrsINc5Y7o/RYA9VPUruMDE=;
	b=hXutdkG/6UVMX3AQ9X2MgZ5gbxpEd6LUI2mMBw1jrTz5BxCinnTCYOzG78dXICR4twYN1D
	sv+RGqd4QQUimLd73rxmWJtWgEUh1BiPO7rEvQx7tRO6wsZO6c4lHP/k9v2vpWiXyOkqVq
	jQMhABo/Zt+t7PF/n0qyFmX//WhaY3b8YL6EHJIRsdgITPXVYZzWE8qTY+yMgeuibKw38N
	hrW8pGDmtIPW759xitTUP+PlDv5FqtIpAADNRFJE8wgxlfLsQbuGBjeFUh8/MY7GA3G+02
	Vl4mQru157FTPbG44dhtEGbaSyzxbsiO5d24GZ1esu2LZH1F+DK5FH0htYNnfw==
Date: Fri, 16 Jan 2026 10:54:44 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: pavel@nabladev.com, ovidiu.panait.rb@renesas.com,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/4] Add RZ/V2N I2C support
Message-ID: <aWoK5NOnLJFHVceY@duo.ucw.cz>
References: <20260114125359.8668-1-ovidiu.panait.rb@renesas.com>
 <aWjm1902KAC3sQ9S@duo.ucw.cz>
 <TY7PR01MB14818CAEEAC8D66234B709B50CD8DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yZfjX+DwCOLFiWFb"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818CAEEAC8D66234B709B50CD8DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jan 2026 09:54:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21629


--yZfjX+DwCOLFiWFb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Thank you, applied.
>=20
> It seems you haven't pushed yet.
> Could you please push?

Aha, sorry about that. I added your reviewed-by and pushed the result.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--yZfjX+DwCOLFiWFb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWoK5AAKCRAw5/Bqldv6
8hN/AJ4zems/wjMdyaw0ACaFIQaCbFOzYwCfb+j8ORTor/xa8X3TR4OHUi7gh4g=
=9S/t
-----END PGP SIGNATURE-----

--yZfjX+DwCOLFiWFb--

