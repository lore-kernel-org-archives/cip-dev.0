Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A4AC3ABCB
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 16:06:36 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.54398.1747065986163499876
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 May 2025 09:06:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=IfPH5izV;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A1F8101EC1F1;
	Mon, 12 May 2025 18:06:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747065984; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YnTu0CiEfRpcXq/nE5wmr+i5wiP1IRS+Ygq1EZJ7jOQ=;
	b=IfPH5izVWIRczmK0dadOAYoo7IHEkzmlir/O8EfITe+OBFR5KkjnhtG9rs0lxlZXVJBiD8
	f9/1SQE/pUksPM/+BqbbSDDTSHQTk65nN/TSbdpii6dPp+xSsePZ5SHTPZr1O11iKmAg9k
	79JCtXwTlWL4iIMrPjT7dC5EeKQOaTuMMFdI9hOCRpLJOD0WdIT00/1GvD/9ppcZ8BZX4o
	Hwg2hAjKGLXHBbqy9CLo5g9XDNtlgAv5Rz9XTfv/3ETTNA28y2x4SiUyljkwrjTJ8nCJll
	yxjGs0AR+SObT+Tj4wmxNxJqGN/y7NLm2N7wGI355Nq61sa4AFz01FE6W+sYVg==
Date: Mon, 12 May 2025 18:06:18 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 00/29] RZ/G3S: Backport audio support
Message-ID: <aCIcegq472gRjUJL@duo.ucw.cz>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KJCRnyvBWIdUF3eF"
Content-Disposition: inline
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 May 2025 16:06:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18898


--KJCRnyvBWIdUF3eF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Series backports the Renesas RZ/G3S audio support to v6.12.y CIP.

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--KJCRnyvBWIdUF3eF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaCIcegAKCRAw5/Bqldv6
8lOFAJ4x6t1UfC/KV9R04mez/2zFlU4WFACdEu2LzHzZoROJewP0xZZweSAzoL0=
=uaOD
-----END PGP SIGNATURE-----

--KJCRnyvBWIdUF3eF--

