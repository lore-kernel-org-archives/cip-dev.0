Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D818E77187
	for <webhook@archiver.kernel.org>; Tue, 17 Dec 2024 20:30:10 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.91328.1734467400517385621
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Dec 2024 12:30:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=TfXvu2CL;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84BB11048AF6C;
	Tue, 17 Dec 2024 21:29:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734467398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5JUYF5wQQJoCps9mhfgCyi1dVgJDngezdqWs7X/5n+E=;
	b=TfXvu2CLiSj2P2eiYLHTdLWolkOeU3hIn6U5nOlXi7ixM/vHjYgdwL0ffAWshMZjs1RJr9
	ty/+gFbf5hFxd0fe2/isA2wMb546M1B6JJ88od2kYZV2AWV1XyP9jfgcGT/+PU/NZoZmnr
	Et7UHr7Hkt9SEgWhk2Xzyeo4a4tdGgKwzZ+ZjrcipD6vkKmtns+/QWDy2YisxqCFi+toR8
	OUDEoWsgh0kBuh3JPHY76hvu6wiUX/VNKciMfrBs/AUIY/OY7RHNZZGvdW32rPVAjLEMmi
	uOtB9JlKlfD5hBbHcMg/Oit3AQ19EuvD4z49CTtTcnxE9hYgWNbhzy6cMydzYA==
Date: Tue, 17 Dec 2024 21:29:53 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [cip dev][PATCH 6.1.y-cip 0/3] pinctrl: renesas: rzg2l: Fixes
 for suspend to RAM
Message-ID: <Z2HfQYAgp7rIVp1N@duo.ucw.cz>
References: <20241216130619.321397-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cs7qUoGrITmrGQhA"
Content-Disposition: inline
In-Reply-To: <20241216130619.321397-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Dec 2024 20:30:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17440


--Cs7qUoGrITmrGQhA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series backports suspend to RAM fixes for the rzgl2 pinctrl
> driver.

Thank you, applied and pushed out.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Cs7qUoGrITmrGQhA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ2HfQQAKCRAw5/Bqldv6
8mzYAJ9b0crC61nZ7gMI7ydq9rszby2tkACfVPhjRn/tLeYkAWmxX9bHJTMYjzo=
=OXvL
-----END PGP SIGNATURE-----

--Cs7qUoGrITmrGQhA--

