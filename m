Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9B7C47BC8
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 08:37:17 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.85939.1767688633410878256
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 00:37:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=IF0QmaM6;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5C3C610360B;
	Tue,  6 Jan 2026 09:37:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767688631;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=wjDg0GLIBOMlLtdjjvblVFdfERVDRYaOp/bX42Y53Vg=;
	b=IF0QmaM6sASYzJ2k2PU4UyZqIKj0nU2skSMqeWJi9hR5T/8aL2jW1KIUx2Tim9x6E1JGSG
	7qynnEGD8aQ7k641ODY8gw3JnOPNPNYaGzBtaStOEb98t1p+jLwlDbMkDb/iw72wh6FoRV
	6TQ5cl38agLyJOr5mjMvL8NMthlqJ5grjvT9FiYZwKwT8NEvNDK/Gt4FQSiTV7t04LfbHD
	NyZbNP5HETDd2+hi28tkHibomwy6olUcXLdCiOMdHBjckmbNFDkTCQChT4WD+Rf364sIyc
	X9HMGVpVKQOG8oQrPaoMIfYOpO1LlnH4BtmMWXIPPngV8kTajww3Ftz6LRT3Ng==
Date: Tue, 6 Jan 2026 09:37:03 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip 0/7] RZ/G3S: Backport TSU support
Message-ID: <aVzJr9GLZvoBUZF/@duo.ucw.cz>
References: <20251217103210.4183025-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RpH+VM4SEdkwSY2b"
Content-Disposition: inline
In-Reply-To: <20251217103210.4183025-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 08:37:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21321


--RpH+VM4SEdkwSY2b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the TSU (Thermal Sensor Unit) support for RZ/G3S.

Thank you, applied and pushed out.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--RpH+VM4SEdkwSY2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVzJrwAKCRAw5/Bqldv6
8vsAAKCoFk3kHMAtjxqThHxve2zDbPq6QwCeJcc458egFZu5yrPkCRzK/tZjdtc=
=02rm
-----END PGP SIGNATURE-----

--RpH+VM4SEdkwSY2b--

