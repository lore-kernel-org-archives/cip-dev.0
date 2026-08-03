Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E055EC55822
	for <webhook@archiver.kernel.org>; Mon,  3 Aug 2026 17:27:40 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1637.1785778055200742490
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2026 10:27:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=FNSFhIBi;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08191118B1C;
	Mon, 03 Aug 2026 19:27:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1785778048;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=bEhPNEt3OWkd29wXHtO0+etDxCwIYTr36GpI7CRy4XU=;
	b=FNSFhIBiYOJXGHTuue3ar+lALWoHCDYhCuwIm5ZrWbnZ2TTKxEvrvQKh282TSNFpVNcw+I
	9BRuW5rkWnKtvR1MwhkjWIcS78GFvcyrYVeY3XOPx5kGPIuinsWqJcBFlCS5ONKB5+HroC
	A6rN49cumjB5LcjhaTvfK9tMM+5yKLSQm88G/mbR309ehAVc37phG+I61Wo1KG0NYbGWxO
	z8AEWmnJ9NNqJXuoSvE395q6E9r1mqG1sh6MXcratQZahQFf1+sVpm2k5RPwmUBUhNHVGZ
	dQLJbgvv0k8SSsO8wewUvekuM+T8IhQPl5TLst4IvQJZ9mK/jh7S3lnF5wfggA==
Date: Mon, 3 Aug 2026 19:27:23 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 0/7] Document RZ/G3L I2C, WDT and SSI
Message-ID: <anDPe9GgbIhwB78Y@duo.ucw.cz>
References: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f7gM4M+fGixxXVmL"
Content-Disposition: inline
In-Reply-To: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 17:27:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23862


--f7gM4M+fGixxXVmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> This patch series document I2C, WDT and SSI IP found on Renesas RZ/G3L
> SoC. All the patches in this series are cherry-picked from mainline.

This is just a documentation, and looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--f7gM4M+fGixxXVmL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCanDPewAKCRAw5/Bqldv6
8pLKAJ0Y5J6fmkauIHEu/f/PdsF/8CzlmgCgltgiycI7SOpt7Ln7vIBVoubqEeA=
=nNW5
-----END PGP SIGNATURE-----

--f7gM4M+fGixxXVmL--

