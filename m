Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC5CE7717F
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 20:38:42 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.66841.1734381517345402647
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Dec 2024 12:38:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Ng8zUB+p;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA2E21049AF73;
	Mon, 16 Dec 2024 21:38:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734381515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TvEFg+FMwnQ0GLEZ8xf4IA8RRvJzYN+Sdtz9oLD3RDE=;
	b=Ng8zUB+poNR4bw3Kln57n1PlgwofdoMpEm8hzzS0xdSc6jteLP0nXeKsjQGfeWDiWG9PmV
	ZMZtY2PJpD7i3oeub6c5u2T7ezKhgbdAjZbnJMUDLXIWhSUn/c5oep3sFqSenV0iF9b662
	HiIW1q6tbJ5XZN2r3DYzIvpvHBmRP7UWIgHOk2aHOIGr9lUUz+0JjEXfUHYQcYVO3Tf6a9
	5F+Mhh/pfsWE+L2P9LAuguIVWDL0576zyfl7hpbyo7hRb8XrtCeAsL/tUcAhHzOMDP3N/5
	hUpAnDoHmuKlKOAEJgRl++6jxCRWDN7znhUevRGyR327uw97pZN867UtdC0ROg==
Date: Mon, 16 Dec 2024 21:38:30 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [cip dev][PATCH 5.10.y-cip 0/3] pinctrl: renesas: rzg2l: Fixes
 for suspend to RAM
Message-ID: <Z2CPxhYHKTCXAqy2@duo.ucw.cz>
References: <20241216130700.321518-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="caY6Dw+ulX9tr5Fr"
Content-Disposition: inline
In-Reply-To: <20241216130700.321518-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Dec 2024 20:38:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17431


--caY6Dw+ulX9tr5Fr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series backports suspend to RAM fixes for the rzgl2 pinctrl
> driver.

So this adds buggy version in 1/ then fixes it in 3/. Ok, that
happened in mainline, so we can't fix that. Also changelog in 2/ says
"resumming", but it is too late to fix that, too.

So I can apply this (and 6.1 version, which looks good, too) (*).

Best regards,
								Pavel
(*) if it compiles and noone else comments, as usual.
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--caY6Dw+ulX9tr5Fr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ2CPxgAKCRAw5/Bqldv6
8tlrAJwJ1ZB5t1Mi5RCG6w01FVC8gWFIuQCfRc6p7ZwRc8VGCBOC3OA+CzKKWzU=
=pNZG
-----END PGP SIGNATURE-----

--caY6Dw+ulX9tr5Fr--

