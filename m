Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF74AC5AD49
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:38:17 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.7326.1748943495539451836
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:38:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=X8UzDxQJ;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6381410397298;
	Tue,  3 Jun 2025 11:38:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1748943493; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=bYawYL7dBtDkNxuYYHFWBMxGib6MOsdOYWPCXWYUYd0=;
	b=X8UzDxQJ5xgvQgYnON+qAx8xQ0dI47Ru8OuuC/U68xsf4VFLpu8CA0LHFnWXE4nWAh0CaI
	6JkFRRwZ+mvHCtPn1MWrfM8azTp5DLn8sQUfzZ62SrgiemHFy2F2eZIRDCP8j5RysV9uyF
	Mme2Palbi42pD5JlnCQG4HDK/puGH7qrCBKMIc5Sz+IRuBxLQp7GZwHbNY79wILNu0opIf
	GB5e/3S1VE0EP5nJiZ2kvoxjSCGtBA1iXosff8X6nprneOKFuWBzmokoiWlalM0u0hnpdd
	NLVK0msFNyLHX877RcM9MFBfoLXlvKz659uKqUyGTxxahMpxAejwYz1iYQ3cBg==
Date: Tue, 3 Jun 2025 11:38:07 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 0/8] RZ/G3S: Backport SCIF support
Message-ID: <aD7Cf7uE9wWuckfc@duo.ucw.cz>
References: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wHcVO/KQeCq96EjJ"
Content-Disposition: inline
In-Reply-To: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:38:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18991


--wHcVO/KQeCq96EjJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the Renesas RZ/G3S SCIF support to v5.10.y CIP.

Looks good to me. I can apply it provided it passes testing and there
are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wHcVO/KQeCq96EjJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaD7CfwAKCRAw5/Bqldv6
8s/sAJ9gWa1+sgD+L3dLiRYxkUYH2XAWNACdHcuL7MxQ1iOeWJNwo+WvMGgZ9uc=
=LX4x
-----END PGP SIGNATURE-----

--wHcVO/KQeCq96EjJ--

