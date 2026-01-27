Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D74D19515
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 11:20:49 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8566.1769512844192984991
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Jan 2026 03:20:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=YTcZsMzM;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E618410EA05;
	Tue, 27 Jan 2026 12:20:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1769512842;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=PVXX6OeJ6cB1b81qSj0SMYlA6bxapSpNJ9FIiRwbXTc=;
	b=YTcZsMzMflapTXPNcBWU4Dc5ENQchLMgMufgi9VPiYBJk1n//G2Y11PaqhKpabpG+WGOYD
	8O5f97W9tYd3KDysIt+J9pVYAzuqakT4h7tgNavo96VuZbOjGRgCCyQ6xeJJsdmYSIQ0Fo
	2P7rd6MRsrTudkgQaybdKBnA1U0TIMlIh79tv8ED5om1Yvsy8suRUbbbagQF/Fx39o9m5I
	ohVzIAZBKg884FJo3JppGJ49fkZNwdQ56f8eN7X5WCd/O94ZW38+1Ivw4F1qP9HMjAV40d
	07Op36MxYsmKrOcNaQ8n0cmnNTVe+qCwS4JlS7hnTNw7f6xx/67DvjDPyJQPrw==
Date: Tue, 27 Jan 2026 12:20:38 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 0/3] mmc: renesas_sdhi: Backport reset control
Message-ID: <aXifhoUgdgZug8wc@duo.ucw.cz>
References: <20260126094409.2529052-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q3B6D7/qTofxEpgq"
Content-Disposition: inline
In-Reply-To: <20260126094409.2529052-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Jan 2026 11:20:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21723


--Q3B6D7/qTofxEpgq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series backports patches to control the reset signal of the Renesas
> SDHI IP during probe and suspend/resume.

Looks good to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--Q3B6D7/qTofxEpgq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaXifhgAKCRAw5/Bqldv6
8jorAJ9hOFyCzBfEL0NWCyrS8/CfQLUYOwCfX+mryG0Aafs0r5I4iTa2ysaD+9Y=
=jlYY
-----END PGP SIGNATURE-----

--Q3B6D7/qTofxEpgq--

