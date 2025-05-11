Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD40C3ABC5
	for <webhook@archiver.kernel.org>; Sun, 11 May 2025 19:47:07 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.35076.1746992825585490410
 for <cip-dev@lists.cip-project.org>;
 Sun, 11 May 2025 12:47:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=NB0s3N7K;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 33B571048C2EC;
	Sun, 11 May 2025 21:47:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746992823; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hoY5qJmu7qNKqaZQfcziiTt/QJhZOROddkyXdo9VozQ=;
	b=NB0s3N7Kzf9Ml5DFDq2kMcr0ZOD9IkJVKMNGrkyivXtWHTKrh7ODZqlnmkSHyLGGzwxF+9
	/lJwXxZkmkju+Ar6f9fQe2I02AdZiv6ycSjGbZpvyjlhYgk4Ag0ND56bK9SKECk1kU+4n0
	DXPXtRHCN3A/F3cKfoTwPisTfX8Jqk+shVgHRUw8fXlLJFW071xQ566fzUzWezeyqXkjT1
	quuw5NJP93Ljl82qDDNz+CvuQnoX+hgJUBJg/N7ckkgASWKU51CV6HoqdlO25rMrfBCjS8
	C5nsDyx/4zMdsFCea1a+DgS+W8/fwhfcTlCLgcVixurfh2j63foAeHFCG+8yBA==
Date: Sun, 11 May 2025 21:47:01 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip 00/34] RZ/G3S: Backport audio support
Message-ID: <aCD+tdRyNqwZRjAW@duo.ucw.cz>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SqBPGvEq0K1oCYq4"
Content-Disposition: inline
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 11 May 2025 19:47:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18889


--SqBPGvEq0K1oCYq4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the Renesas RZ/G3S audio support to v6.1.y CIP.

I went through 5.10 version, I still need to check this, but I assume
it will be ok. I can apply this if it passes testing and there are no
other comments.

Best regards,
     								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--SqBPGvEq0K1oCYq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaCD+tQAKCRAw5/Bqldv6
8sHgAJ9FZ2FNbpXoD2Z4MAWxNzqynix1ugCfUn/J1NPUSGgkIij0p2cnJFHIGHY=
=t+KP
-----END PGP SIGNATURE-----

--SqBPGvEq0K1oCYq4--

