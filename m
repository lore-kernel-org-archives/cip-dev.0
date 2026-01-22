Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85086C44500
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 10:49:08 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34665.1769078941649521865
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Jan 2026 02:49:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=DDy5X8tu;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2DA910D668;
	Thu, 22 Jan 2026 11:48:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1769078939;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=eIRsshj+G3GShUdpQKG3zX1kaDaoMBe2jbbHCzpBTQ0=;
	b=DDy5X8tuEh9WqQtmzWf7f77g7DP707CXxvRadavyG+xme6cyiBbOqPIn0xiV8rcpEQiIM1
	kP9xaHJp7nwS08mDKVAsAhX3wHuu4WmhkY8udRn8YLDDAsboBmbY0zU97qKIGmfZmtkGXT
	CkJ+og99DKivlS85Q7tYVhQkUWgfSFfQ88cSIEwZj/GRHQYvb0j3fPLfruTIwDNI7oDV/I
	QqMkdjXT8on4NLIAgh8sfi62W5FhupXbXtukSZcEdxY5UtdaiVbJUqLFmOK00F7ePSJugH
	wUBSX9TN4U+TskQMv2FDX11cRaNBjivC9ABPwuYHNbZ5wO5999GbOzCg6wQItQ==
Date: Thu, 22 Jan 2026 11:48:57 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev, pavel@nabladev.com,
	cip-dev@lists.cip-project.org, uli@fpond.eu
Subject: Re: [cip-dev] [PATCH 6.12.y-cip v3 00/19] RZ/{G2L, G2LC, G2UL, G3S,
 Five, V2L}: Backport MSTOP support
Message-ID: <aXIAmU+xMSV0WCfP@duo.ucw.cz>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB14818D6D14659F1C91CFE03BDCD96A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IYKuJA9HMPIVitpw"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818D6D14659F1C91CFE03BDCD96A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jan 2026 10:49:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21701


--IYKuJA9HMPIVitpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Please share your thoughts on this approach.
>=20
> Thanks for update this series. And Sorry for the late review. The v3 is o=
kay change for me.
> Other kernel versions seem to be fine too.
>=20
> Reviewed by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thanks for review, for 5.10 / 6.1 I added your reviewed-by and pushed
the results.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--IYKuJA9HMPIVitpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaXIAmQAKCRAw5/Bqldv6
8jWXAKCMqMWlWuyVOwaIEwAdmwc2R7whygCgvdpwxpr635Dc7gMcM1+l/4sud0E=
=HJ6s
-----END PGP SIGNATURE-----

--IYKuJA9HMPIVitpw--

