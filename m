Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1794C624D4
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 17:01:35 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.509.1788368492580030938
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 10:01:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=UCz/wft/;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF3D011D5F3;
	Wed, 02 Sep 2026 19:01:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788368486;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=KuASTnQ1nHyFNhSzSVfElWCGDuZ39n+48ij7vPW0gZo=;
	b=UCz/wft/ZFKNKu9h1Azjw+DO7t5Ptfplm1ijTXaM7IE285axK5sPpk716U9DrGzccLfE/Y
	TNjyUPZol7DXmc9OujQIIH2sowP0Bi926XwWM1fHp9gOFXdynP+N5wmC6jEc62w6XHIwKN
	Ox48DelnBTfN/pnb7qvU6bUcu8aMvwmswGvH3pyKiu6/sjjJcZIIUzfUJXwcaPrymtluXG
	1ugQrPB8MANMODn5HLRXGVw73Xi9UTGfjcKBNbgz+AIJhYHkd2yq8nyNi47p0Ywu1awkuX
	NqhGN1mxKhg1ZIP1d+u4sk+E6LhWpeunDQG/PolZsb3CZ0ZjcoPiW5QekUt3dA==
Date: Wed, 2 Sep 2026 19:01:24 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 00/11] Add ICU error and software interrupt
 support for RZ/V2H and RZ/V2N
Message-ID: <aphWZPm2254mrZK6@duo.ucw.cz>
References: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="50fZUGkS+s5mXzs7"
Content-Disposition: inline
In-Reply-To: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 17:01:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24082


--50fZUGkS+s5mXzs7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds support for error and software interrupts in the ICU
> driver for the Renesas RZ/V2H and RZ/V2N SoCs.
>=20
> Patches were cherry-picked from mainline kernel.

I had some minor comments here, but those should be fixed in mainline,
first, so they should not block the merge.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--50fZUGkS+s5mXzs7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaphWZAAKCRAw5/Bqldv6
8mn8AKDCZ2MhAUrcrBe5toIzj9WRR+ZMPgCgv4FnfAYN0Jsy7uE6l898mreMp1g=
=63S8
-----END PGP SIGNATURE-----

--50fZUGkS+s5mXzs7--

