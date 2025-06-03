Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B870EC5AD49
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:40:37 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.7358.1748943630599687614
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:40:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=g6qM/Q00;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0FAE10397298;
	Tue,  3 Jun 2025 11:40:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1748943628; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ZkwuwD2VjsB68lp+Ypvu4i4hc6FhiuJY3zmMShlXKTk=;
	b=g6qM/Q00WTFfaucIvvtxwHI7mEiB9IRdG6EdwQoPZ3Wu7uJZgz9qERmLAj+NIa1cREjsKy
	dVcZP3Z1zvuAiLfBZwtl/hh7KrpoKyn06xuaXgyg1Wi36+UpRuIFLU+97J8UOUriRDxtFT
	gb4C4DiaZavk1PQxVGR6LRcmpO6gpcxwP5UEZQDaHys9PdGZAnAj/m6BtGy3rvrCTXlKAF
	Cy5NFt6nb5WPnWgGouhdVpu0pbp1HvjUbVQx2sq3J9jNy8feELUICWjVPUQLfjMK25/e+R
	GTMvXYn6LZv0+zyctObUh3Ym9Z7YEQhDP5CSGr7BAGe22oXoFvcbDD5pFdCPjg==
Date: Tue, 3 Jun 2025 11:40:25 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 0/7] RZ/G3S: Backport SCIF support
Message-ID: <aD7DCYegyFHbp0eu@duo.ucw.cz>
References: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nA9504DZzWjFDccI"
Content-Disposition: inline
In-Reply-To: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:40:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18993


--nA9504DZzWjFDccI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the Renesas RZ/G3S SCIF support to v6.12.y CIP.

Looks good to me. I can apply it provided it passes testing and there
are no other comments.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--nA9504DZzWjFDccI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaD7DCQAKCRAw5/Bqldv6
8vfFAJ4wxmDxVGusO4TipNr8riYUmnDFTQCeOYVjCoKHRdRKWYWifUMw/4Svqfo=
=bk8e
-----END PGP SIGNATURE-----

--nA9504DZzWjFDccI--

