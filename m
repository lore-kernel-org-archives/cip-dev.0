Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55888CA5FDD
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 13:10:57 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11729.1790946649285130801
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 06:10:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Z1aVvjof;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C474D10769A;
	Fri, 02 Oct 2026 15:10:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790946642;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=gKFZ1KYe17+rMJisUsbJntNRxwiQylzISf2fobaZTgs=;
	b=Z1aVvjofoz+o3OQapPgXrOQ20RTxmVFuIz+VA1QvErzyd2C3ZP8USKiz406tX5gDi0aTWf
	0H4oSuLmLO0WzB9ENc4xWodSleydK+W0P3+RYytlzi8sEpnxuY1sIGf+MtLcLTvxCofOKQ
	+nEhrh04soDDKxIwGD0AFzUk0MoHZMoTyP0VSDCsdN1a1nsCOgmMvDRuymXhKXdrKthhle
	7o4CK7jYxfoP8lOg2gCEdk9F1uTLID/Fm5mvLIPNyg8QH8P9qVYya6Eyj5A+GZd0d/q/Oy
	nNw+FdssdFc5CDd6nPBnNC7VOaF6u9QPiOSHt+c8puWXfHD3rIFtFsTTVXyQ1Q==
Date: Fri, 2 Oct 2026 15:10:37 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip] irqchip/renesas-rzg2l: Fix loss of interrupt
Message-ID: <ar-tTUo5zWBE1kMg@duo.ucw.cz>
References: <20261002125054.360202-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r9GdPnAbN1JmHAKQ"
Content-Disposition: inline
In-Reply-To: <20261002125054.360202-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 13:10:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24416


--r9GdPnAbN1JmHAKQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> [ Upstream commit 50b10bd0c2d721ad38abd1abe3acdefb6caa0944 ]
>=20
> rzg2l_clear_irq_int() and rzg2l_clear_tint_int() perform a
> read-modify-write on the ISCR/TSCR status registers to clear the bit
> for the interrupt just handled. Since these registers are
> write-0-to-clear per bit, this is racy:
>=20
> If another interrupt's status bit gets set between the read and the write,
> that bit is written back as 0 by the software-constructed value, clearing
> an interrupt that hasn't been serviced yet and losing it.
>=20
> This can be reproduced by triggering multiple interrupts at once, e.g.:
>=20
>   gpioset -c gpiochip0 355=3D0 353=3D0 328=3D0 352=3D0
>=20
> Fix this by writing back only the bit being cleared, with all other bits
> set to 1, instead of read-modify-writing the whole register.  Since 1-bits
> are left unchanged by hardware, concurrently-set status bits for other
> interrupts are preserved.

Looks good to me. drivers/irqchip/irq-renesas-rzg2l.c does not exist
in v5.10, so -stable can't pick this up for us.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply this if it passes testing and there are no other comments.

Best regards,
                                                                Pavel


--r9GdPnAbN1JmHAKQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCar+tTQAKCRAw5/Bqldv6
8sBvAJ4yqq55C0OctP3TAUCcIBj/O8gFbQCfVwWJoCVjbBVN73Lq51x9PbkcONE=
=wJT3
-----END PGP SIGNATURE-----

--r9GdPnAbN1JmHAKQ--

