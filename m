Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9903C83F03
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:50:56 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.9068.1751622649767217365
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:50:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Q7YzQ5H1;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98B8C10380104;
	Fri,  4 Jul 2025 11:50:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751622647; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=u+qnMpA3+vZbllgiABZHhOYzdHTKFReSOJEn6L6XGbI=;
	b=Q7YzQ5H1jdcSxzKpzh1l8hJzal56mHNLJG0JJQOiR8bGDJkDR0n3Cr4VzXQEhuxjhOA2Dd
	YF+u/bJVGixONTYG1c8aRcIctdBxUu4lhOseKbhnNFvhm5kTJQXRP5gNR5OqfMqRUPglqz
	pB2mdWWTgafM446HqCwvRBUgyyN9vX1mwn9JztHbgJdG46WB0AWOED31R4okVNpaDJziFP
	hiKRS6dr2qXVUL+jNIOL0ZZupjP3PLhM4KmOfkhFBLsYqrKycJBZVtYkoktjlyU838cc35
	o3Gt4RZigdjz0U3/T99Azgp1iux2VWtKSuRiCJrLQe1i6URaaRO+BYm9R4IL8A==
Date: Fri, 4 Jul 2025 11:50:39 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: tommaso.merciai.xr@bp.renesas.com, cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/12] Add support for Mali-G52 to RZ/G3E SoC
Message-ID: <aGej7w1QxYULTBSM@duo.ucw.cz>
References: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
 <TY7PR01MB14818D02E5540125AEF41103A9243A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vHz6JWWG2kG/pVy0"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818D02E5540125AEF41103A9243A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:50:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19363


--vHz6JWWG2kG/pVy0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series, looks good to me.
> I can apply, if there are no other comments and test is green.
>   Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1=
903593313
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you all, I added your reviewed-by tag and applied the series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vHz6JWWG2kG/pVy0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGej7wAKCRAw5/Bqldv6
8r+nAJdZ2DvXoJHCQhO8CRAD4BcXQKMiAJ4y8AQ0L6eIyoCmFh7BlO1E3f8sMw==
=jIRe
-----END PGP SIGNATURE-----

--vHz6JWWG2kG/pVy0--

