Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2C7FD5327
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 09:53:39 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.91870.1772186011049221442
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Feb 2026 01:53:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=XL431GEv;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC602103D5E;
	Fri, 27 Feb 2026 10:53:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772186009;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+CTduHpPFAwwB2pE7pxxKM1dL59eWnjQQLWfPNR2TRM=;
	b=XL431GEvDenIuAsqnqJFuwtslw7nOZC+o7AVGl4cPtlNKqhhD4gETmojo6E9W2Cl7EAyPn
	eqSAW5boc/hIjeiPbO/ulRTB7DPo8bWhMqXa5FGwBbUMfJ00n1BJ2J/dddOD2nMxE6Xd0K
	dlPYkcHsFp8WLf08lwa8fOM16+Nv2YoxjWmpGtjjTghGTTAndutbYZSamJQKOT4wDXM1IN
	TV3car5/fYcEnPUV0LENcA3ARwWYgRHdwCSJaaBlm6h9ulP5pZra3asVZ0IiTu1L93QM4A
	K5ftGr/O586ihTfuseCCBp5TxDKZi5p49RSh+zDj+s3gcwsqNcNaFe0huFfoWw==
Date: Fri, 27 Feb 2026 10:53:27 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 0/5] RZ/G2L SSI Improvements
Message-ID: <aaFpl8z2owBm/444@duo.ucw.cz>
References: <20260226192846.449277-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96n9LnSJem/o4r6z"
Content-Disposition: inline
In-Reply-To: <20260226192846.449277-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Feb 2026 09:53:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22024


--96n9LnSJem/o4r6z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Add support for 24, 32 bit sample format width.

Similar to 6.1 and 6.12, this looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--96n9LnSJem/o4r6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaaFplwAKCRAw5/Bqldv6
8qqVAKCRr0cAb9wii8gZPuD79877/C68rQCeLnTSFiCmOwVbp2imQkWQ+LtBRas=
=48RA
-----END PGP SIGNATURE-----

--96n9LnSJem/o4r6z--

