Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69301C28B20
	for <webhook@archiver.kernel.org>; Wed,  2 Apr 2025 07:59:08 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.2709.1743580745467920150
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Apr 2025 00:59:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Zid/EnQv;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E21710269396;
	Wed,  2 Apr 2025 09:58:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743580742; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=TtuLP8RB9hy3ZV458VLI93cFTRzmoC1fos+tcOUSWwY=;
	b=Zid/EnQv982CddQouHw/DVhbicVT58uigHl+lfUvCydj34bbMjWNvG5YeS8tLizx186FND
	a2TX6ytdQvnnnTXeY06Bc0bIy29btItavd+hVzZtZxuCOr0MeXNTA319mTmez5zkZ4BYe8
	WHcy9eY3p2OcD0irBIG6x6Q0DpiOFxhwQcNMnWebo8zl+1b8E8EsXUcmSRIgKCEKGdrNni
	mrgIHpylb2DAf9Ny5vEVPsmcYhKhEYLs2hiA/3d/thLTJQhEVsZpvRyU4pmfn98ARdHIS2
	sEhYvgoJRoGaaTXVniIuEwqSpIUbVUM0DuXTthFrGxzbPzFAL8PaVXvgMhtdoQ==
Date: Wed, 2 Apr 2025 09:58:55 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/13] Add RZ/G3E pinctrl support
Message-ID: <Z+zuPylce9VS+uk4@duo.ucw.cz>
References: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FrK3v7ZqbR4HKFUz"
Content-Disposition: inline
In-Reply-To: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Apr 2025 07:59:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18455


--FrK3v7ZqbR4HKFUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds pin controller support for the Renesas RZ/G3E(R9A0=
9G047)
> SoC to linux-6.12.y-cip kernel, this series adds also device node for SCIF
> pincontrol into RZ/G3E SMARC EVK board dts.
> The RZ/G3E PFC (Pin Function Controller) is almost similar to the one fou=
nd
> into the RZ/V2H which is in turn similar to the one found into the RZ/G2L=
 SoC,
> for this reason pinctrl-rzg2l.c has been re-used.

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FrK3v7ZqbR4HKFUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+zuPwAKCRAw5/Bqldv6
8tP8AKDASPhw/mhto6hqzd48bOXG8o8o9wCfQoYHt3B2hlhCQ3VPXQnvUEjbtD0=
=5xoH
-----END PGP SIGNATURE-----

--FrK3v7ZqbR4HKFUz--

