Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1F6CFD313
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 11:24:37 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14565.1763983474988308148
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 03:24:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=ROzvgkgb;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0062D10092123;
	Mon, 24 Nov 2025 12:24:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763983472; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=1IdI7dDvvCqXWVqwZ+HY7rYmeIMv62WnxcWnHIcLKE8=;
	b=ROzvgkgbq8t5+wxkLXKc0vtTNV42b/aizh7+jVstQJjodCj1jFY/ebClW2p6QuB1SEG8Aw
	lPKErBIBD8DhXnYRzvVj3BuAMRBU0ga/nfuvk8MaQrK68C7cKa2Ee43PezG8CGthbjerIp
	nt3N3XVj9/2IpJfuCqQsKN9MGvvcssjdye/RkuLMF72xYuuTb2NqGZb80Z3kr6h32MyZus
	wCpLcQO1LRjjKN+G53hKGSJLbdc/K2vC/wss8+H4WyN5XdpGsagukmAJ6rkul6VaGk1DtU
	dad0XCCfSMqoRlEI/qn4yznVgs2pFRdF1p9F2JtTe8aX/sjhztwx8kcD/4XtOw==
Date: Mon, 24 Nov 2025 12:24:18 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 0/2] ASoC: Renesas: Backport audio fixes
Message-ID: <aSRAYixxUIX4ruP8@duo.ucw.cz>
References: <20251122105133.2783194-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UzgmqSiTBwZFhY6j"
Content-Disposition: inline
In-Reply-To: <20251122105133.2783194-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 11:24:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20712


--UzgmqSiTBwZFhY6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports audio fixes necessary for the Renesas RZ/G3S SoC
> and the Renesas RZ SMARC Carrier-II board.

This looks ok to me (missing error handling is something to be fixed
in mainline, first). 5.10 and 6.1 version look ok, too.

I can apply it if it passes testing and there are no other comments.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--UzgmqSiTBwZFhY6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSRAYQAKCRAw5/Bqldv6
8uHdAJ42Rsx3Ux6ydRkoMo0LmznovpSZlgCeKurFM+V2t7oq7aQps01s/8GoGbs=
=TZz+
-----END PGP SIGNATURE-----

--UzgmqSiTBwZFhY6j--

