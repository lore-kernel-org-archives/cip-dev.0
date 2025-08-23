Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9910CA0EE4
	for <webhook@archiver.kernel.org>; Sat, 23 Aug 2025 06:46:08 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.2092.1755931564054142533
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Aug 2025 23:46:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=GVsK8+LZ;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2CE0101DBD4D;
	Sat, 23 Aug 2025 08:46:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1755931561; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Ty6nqfHYQLfbnQNCSSxkpQfOW2odsddgf7F3s69Depk=;
	b=GVsK8+LZB1jPKw3V/AO+iN0z8wllaZmJeZTGljewdXVJy/uFvfZfCgdjN/74pduTGKyPBv
	HeceP26yVfnGUH3sNE4yFyTm9ABw9V0HIlaoGaXAhZhIRNNeKMM3BzvvxMYa5ZPjnC7h3K
	MgdV1K016KmOhsWtG55wuGOCgeDGnO6IrsRuq1unHGL6SMyZPROPBLDrqSux7BUGnR3tYM
	6ugo5Ic0QuFebb1yB0f74ZYbHpExfrF6XmsYOAJyzo43SJhRiDtoPoALLBMnNC8ARvkDV0
	l54scagQKgVJp4u/vcS39kncJZJao4rgGIElMLBC78KM2KDO03igM6v/u74oyg==
Date: Sat, 23 Aug 2025 08:45:58 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 00/22] Add RZ/G3E XSPI support
Message-ID: <aKljppxuFxwptxjh@duo.ucw.cz>
References: <20250820083855.6337-1-biju.das.jz@bp.renesas.com>
 <TY7PR01MB14818BF96A3A6A3EE1DB97694CD3DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z31ltrlpiIeBtqLI"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818BF96A3A6A3EE1DB97694CD3DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 23 Aug 2025 06:46:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19953


--z31ltrlpiIeBtqLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series, LGTM.
> I can apply, if there are no other comments and test was OK.
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1997742=
532
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thank you, applied and pushed out.

Best regards,
     								Pavel=09
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--z31ltrlpiIeBtqLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKljpgAKCRAw5/Bqldv6
8lZzAJ96sZNnINizh1VQ/IrQ49tVKJAfkQCcCchb+B/FvWPqgUtZPRLtP5HF5kU=
=NEoR
-----END PGP SIGNATURE-----

--z31ltrlpiIeBtqLI--

