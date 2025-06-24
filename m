Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A30C7EE31
	for <webhook@archiver.kernel.org>; Tue, 24 Jun 2025 09:04:57 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.4006.1750755892981940787
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Jun 2025 02:04:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=LlA9SBIk;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 56FD7101EC1DA;
	Tue, 24 Jun 2025 11:04:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750755891; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=I8dwPZrNZUebi4zqraJwnu8lOAwL8MaswNuAq3JyHow=;
	b=LlA9SBIk57NDCiIGkatD4yHo8NPj8K4rWPPDUWVh2hA0xwTHbT/Ll27mzO2c5S9TOAK4Xq
	zrF7GNqJwhU/iA8IMkF9EEbMQIUN0nvazYfGMs9cQ8M61hBkdLln0ticT+jHytl6xCizVW
	onr1oXM5kiSQLkJCjATHbz0PhNLp1vHhwanrG95130499Ab7yj/UKCLzT4jf2bi7dfQlSV
	ih18Oe6COJsWXfe9j90fjdujuzaP/rcd/NQXUAHBDi8d8E+MpRSiJwO60fkBZB43uilZB1
	gQeqjBEHebJBZ1UtzF9reQyUlT/E5leRMhwVm3RSy0Pn58/uerYVGQXz77T9Lw==
Date: Tue, 24 Jun 2025 11:04:44 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: tommaso.merciai.xr@bp.renesas.com, cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/10] Add support for RZ/G3E SDHI
Message-ID: <aFpqLLfvL7pYQMBD@duo.ucw.cz>
References: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
 <TY7PR01MB148185605EC0D8AD4B8DFB7D89278A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CPNJsQ/eLhepTqkH"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148185605EC0D8AD4B8DFB7D89278A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Jun 2025 09:04:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19227


--CPNJsQ/eLhepTqkH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > ++++++++++++++
> >  drivers/mmc/host/tmio_mmc.h                   |  10 ++
> >  drivers/of/base.c                             |  27 +++
> >  include/linux/of.h                            |   9 +
> >  13 files changed, 523 insertions(+), 1 deletion(-)
>=20
>=20
> I reviewed this series, looks good to me. I can apply, if there are no ot=
her comments.
> Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/188=
5935233
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, I added your Reviewed-by tag and applied the series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--CPNJsQ/eLhepTqkH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaFpqLAAKCRAw5/Bqldv6
8lWkAKCiPsnX3kz1QEe4B8b0SWD4eAmWLQCfRp2swmY2dairYQRJMjuZBEhjr3I=
=vnYd
-----END PGP SIGNATURE-----

--CPNJsQ/eLhepTqkH--

