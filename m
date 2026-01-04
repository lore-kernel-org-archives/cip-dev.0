Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9DCC2A062
	for <webhook@archiver.kernel.org>; Sun,  4 Jan 2026 23:54:56 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46776.1767547886480865668
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Jan 2026 09:31:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=ge23T+Eg;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C802F10D397;
	Sun,  4 Jan 2026 18:22:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767547331;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=0LMWZ+QrvsSRPJNctTWrpwiiRlDg+NqD4lXz5sH5eoc=;
	b=ge23T+Eg//LMnvspmBkfD011rEvl8KSkb4Bg7+ubz5mx90k1wvrVLB4n9ZbTi4tkajiXs0
	4bcwlIChqxIH+dPtKt3gWXJ3MVBJTdGjrMr7FXi0Ya19P6bB2DplFS8sd42PDGHX5dbIYS
	TfuVLBFWBu56JKwgmq4Bwu/6cb7SDpnZ6i8QnoamyLBOPhAoqPK9xFl5hSN7aKrnHQEgZe
	xgbBXSH+9GLEwDIuX2TT4N/GNw5W5PKig9aZq73Cnw7V+K15y9VKaHcRxa+9SWq4MZ+MYB
	mA2VE585JbXHXX/eWWWUsi2IwT3tocv5itBQobTan9+1uJH7TRPGlrVoIBjXXg==
Date: Sun, 4 Jan 2026 18:22:06 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/24] Add suspend/resume support for RZ/G3E CANFD
Message-ID: <aVqhvv51l0tjtPi6@duo.ucw.cz>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y/GrUz0uA1TJP/u6"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Jan 2026 23:54:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21302

--y/GrUz0uA1TJP/u6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Add suspend/resume support for RZ/G3E CANFD. On RZ/G3E using PSCI, s2ram
> powers down the SoC. After resume, reinitialize the hardware for
> CANFD operations. All the patches in this series are cherry picked
> from mainline.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--y/GrUz0uA1TJP/u6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVqhvgAKCRAw5/Bqldv6
8rEhAKCEWy21OuBFPR6Qin7OptVw/ovQrgCglVz/LTlea5qppIZzCssDBJmcC0U=
=gMtc
-----END PGP SIGNATURE-----

--y/GrUz0uA1TJP/u6--

