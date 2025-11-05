Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C38CCF9F8
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 09:21:05 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5619.1762334455203004564
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Nov 2025 01:20:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Hc2ygZDb;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA6F1103CF29C;
	Wed,  5 Nov 2025 10:20:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762334452; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YL4vxsuvCubxDM2aA23rd2/ruNO8KKCYfRiM9Vgn66Q=;
	b=Hc2ygZDb2NYKNrNJ8HpGjObbWSs4UGATb0Jwsq+wFQ0g0IU7GLOFW1mAuDNq7FxY3fNodR
	VPJtsyb1GAcSeZ0Kq3VglSj2LT+pWjVIdW5bK2YT3avKZHmNt/SYaTl+PZxYGB4jmHhRji
	/WrhPRhIO72UquOsQ80rY2yp3R0b/cbRGsOQpzStH18KmH5oQlbqaQN7TUE1T3/M+wBd4k
	WhLQ3jmpj+TKcior54oRkKiVf6srGqukU+4L5fGsbwd+mL6OMPRd1YKzjcujbVPtrbPh4F
	+np6UxXhpzGho41lFcMcjSKfE8+2BniYpjk7A0F1waVJfMdV1IyEAEHt1nZFeQ==
Date: Wed, 5 Nov 2025 10:20:46 +0100
From: Pavel Machek <pavel@denx.de>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 6.12.y-cip 00/22] Add RZ/G3E GBETH support
Message-ID: <aQsW7v7fTWuS5Zi9@duo.ucw.cz>
References: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q/3kIjnVU/3hxIeT"
Content-Disposition: inline
In-Reply-To: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Nov 2025 09:21:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20357


--Q/3kIjnVU/3hxIeT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add RZ/G3E GBETH support to cip-6.12. While at it, also backport RZ/V2N P=
inctrl and
> OEN dependencies.

I agree that most of the issues are best solved in mainline and should
not block merge (provided this passes testing and there are no other
comments).

Please take a look at=20

"[cip-dev] [PATCH 6.12.y-cip 01/22] soc: renesas: Add config option for..."

It may make sense to put that one at end of series, and I can probably
do it while applying, but I'd like confirmation.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Q/3kIjnVU/3hxIeT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQsW7gAKCRAw5/Bqldv6
8r5JAJ9Z+cb26qcPWBt81pIGHcjeVpiPsACgvS5JyXs6gEJ/W+P+UJGTzWblwHk=
=Piom
-----END PGP SIGNATURE-----

--Q/3kIjnVU/3hxIeT--

