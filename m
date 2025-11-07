Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C15CCF9F8
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 19:23:55 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7660.1762543432772916905
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Nov 2025 11:23:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=UOYTk6IN;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EEABA103ABB76;
	Fri,  7 Nov 2025 20:23:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762543430; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hjq8nG+I5GemVIKJgwJH878UzSCF40oiI3bhc24+VXw=;
	b=UOYTk6INT6DqCYdWYtJf9doG0dZNNJiEBvz6WnZkkVn6lRse7CLABCBhOMHrZFB9ryrPx3
	qAvpkqQWDNkl7MTYpkkXTmLL9HkxbHTaheCkJjTbUXxy3P5k7t1q8byqsGbQh3kvDpB/kD
	mD55ZS8MDRw72dJwaWK7FXJoSAifeQQnW1pb70XnJlWTsqNzR0r69w8TYPBQtuosQLE/Ve
	meoaRPAi8T5gJDb8qr6OME4GJoCE4rt37LtT8QCDjfsvMMU14pzC7viFmnlthjqh8Lqrbc
	TcSL/FiixQnsDZ+5aL92Ut0nmSQzoj9iXuGCBBhERN9oIp59PvLEh3UOKp6+Og==
Date: Fri, 7 Nov 2025 20:23:45 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip] mmc: renesas_sdhi: Set the SDBUF after reset
Message-ID: <aQ5HQfvwfBo1fV3s@duo.ucw.cz>
References: <20250827104521.931674-1-claudiu.beznea.uj@bp.renesas.com>
 <c23c084e-8a2b-4a9e-9e43-502ee4a4b50a@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hJRO4f4nPscUIwgN"
Content-Disposition: inline
In-Reply-To: <c23c084e-8a2b-4a9e-9e43-502ee4a4b50a@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Nov 2025 19:23:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20476


--hJRO4f4nPscUIwgN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >=20
> > commit 68dbe38ed7ba9141b9329eb203fe9762a93b60e8 upstream.
> >=20
> > For development purpose, renesas_sdhi_probe() could be called w/
> > dma_ops =3D NULL to force the usage of PIO mode. In this case the
> > renesas_sdhi_enable_dma() will not be called before transferring data.
> >=20
> > If renesas_sdhi_enable_dma() is not called, renesas_sdhi_clk_enable()
> > call from renesas_sdhi_probe() will configure SDBUF by calling the
> > renesas_sdhi_sdbuf_width() function, but then SDBUF will be reset in
> > tmio_mmc_host_probe() when calling tmio_mmc_reset() though host->reset(=
).
> > If SDBUF is zero the data transfer will not work in PIO mode for RZ/G3S.
> >=20
> > To fix this call again the renesas_sdhi_sdbuf_width(host, 16) in
> > renesas_sdhi_reset(). The call of renesas_sdhi_sdbuf_width() was not
> > removed from renesas_sdhi_clk_enable() as the host->reset() is optional.
>=20
> Is there anything I should do for this patch and it's v5.10 variant here:
> https://lore.kernel.org/cip-dev/20250827104321.931369-1-claudiu.beznea.uj=
@bp.renesas.com/T/#u
> ?

Sorry for the delay. It passed testing, and had reviewed-by tag by
Nobuhiro Iwamatsu, so I applied it.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--hJRO4f4nPscUIwgN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQ5HQQAKCRAw5/Bqldv6
8vPlAKCxGTXm0CvJpeW1LptwBTDewzuYcACffUmoI+WzX6/tzEhyV0ASGKP5AXc=
=RYnw
-----END PGP SIGNATURE-----

--hJRO4f4nPscUIwgN--

