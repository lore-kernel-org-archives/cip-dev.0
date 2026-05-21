Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6470CD5BA4
	for <webhook@archiver.kernel.org>; Thu, 21 May 2026 10:35:38 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33576.1779359732698925716
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 May 2026 03:35:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=OGFsaOyT;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB588115B4C;
	Thu, 21 May 2026 12:35:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779359730;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=nXwY+jVVxoTpceA82DRYc1KokzeizL8Cci5svf4sw4Y=;
	b=OGFsaOyTnAcmYsvi2zdlcYxKBeDE0+AdPoqn3pm1nKQNq5/PNGaMHA9LEFASW0RdkVPsyB
	GA3Eb4xcuoO9nj9eGOXk5e2mBrTTSdJRJA6iVdQDYi3bFD/vDYJipUWo8f6TVPgIjhi2wJ
	0kFW9LiB2TLOHplkA67xGqBlf5wOkF2LPMbdacRM8jZqavPGeA4D3XKKUxZEPH1Pfh0JeP
	u6y6OwG+ppwqPgrxxizC+3AG2Rn0GAhCTQTs7K7SJvTSRRG19oHyrlEuc6mDbK7Qo8PU+0
	5kIvgMJBJ0czivsaN6yxld4dedh+sNU3Fe4UXXjM1O5zneIZJh1w6pnjbFA7Mg==
Date: Thu, 21 May 2026 12:35:28 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: john.madieu.xa@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@nabladev.com, biju.das.jz@bp.renesas.com,
	claudiu.beznea@tuxon.dev, john.madieu@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/17] PCI: renesas: Add RZ/G3E PCIe
 controller support
Message-ID: <ag7f8NjbSGWZA7_8@duo.ucw.cz>
References: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
 <TY7PR01MB148184CC9DDA8E51E85ACB89ACD0E2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/6wkGXc0mfvlHpF3"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148184CC9DDA8E51E85ACB89ACD0E2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 May 2026 10:35:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22991


--/6wkGXc0mfvlHpF3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series and 6.12.y-cip, looks good to me.
> I can apply if there are no other comments and no test issues.
>=20
> Tests:
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2542248=
407
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2542257=
325
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel

--/6wkGXc0mfvlHpF3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCag7f8AAKCRAw5/Bqldv6
8jHdAJ9K8F80hNDepSX+Lk/LijB3GWs9YgCeOqMjQrMZVeRksgBqByjLVyDa9ko=
=CRC5
-----END PGP SIGNATURE-----

--/6wkGXc0mfvlHpF3--

