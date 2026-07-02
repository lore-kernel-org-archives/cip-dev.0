Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DACFC43458
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 07:50:44 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.64038.1782978641779737383
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2026 00:50:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=fQIfwVhM;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30FF31128B7;
	Thu,  2 Jul 2026 09:50:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782978639;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mt1kQmQgSI+X0QnJaCVhUnVHve+I9pqG1ViLaMzC5zI=;
	b=fQIfwVhMPot8m15lHU15jqvc8+87UfR0YRpnZKhFa6LXuSXaA53m62ZtwnqgQsOmQQqhb8
	vD/t9tmSznNVr3vfWPNbwXpJ6zdLMx6suXihmOt+aLk/Qq2UepV8ONc8idvmfhkH4Ac8pI
	aasrW5xW2IyuAadMyy164kaOmhZz8NK1h9urXZr6tdI/GM7DBrVEdxmLq77gqBabOucidH
	+Z4FKDePi8Y3dYX/wHIORsUjJm+pEEq4Yiktb2NTHpK4Qs0R8S3P/TczeirnpouT5iQT43
	xW9s8VIQbZze22GtUdBTUJgVOYced5ZnJyhmqNoVMNRoNDhpQqLuIF93PzZ8vQ==
Date: Thu, 2 Jul 2026 09:50:36 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: biju.das.au@gmail.com, cip-dev@lists.cip-project.org,
	pavel@nabladev.com, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/39] Add RZ/G3L SMARC EVK support
Message-ID: <akYYTKhxlGh5qk8X@duo.ucw.cz>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
 <TY7PR01MB148184B8AA70882BB40F17F53CDF52@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UZ9qlzYLtM85OFOw"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148184B8AA70882BB40F17F53CDF52@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 07:50:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23376


--UZ9qlzYLtM85OFOw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >=20
> > This patch series add minimal boot support for RZ/G3L SMARC EVK. All
> > patches in this series are cherry-picked from mainline.
=2E..
>=20
> I reviewed this. and looks good to me.
> I will apply with Pavel's Reviewed-by tag.

Thank you. For the record, it passed my testing:

https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-test

Best regards,
									Pavel

--UZ9qlzYLtM85OFOw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCakYYTAAKCRAw5/Bqldv6
8qc1AJ9H+UXbfEvlQwf4pM4H8/vKgeA5EACgmMm8y0RqSKPRxa9ngUmC99cINt0=
=qt2O
-----END PGP SIGNATURE-----

--UZ9qlzYLtM85OFOw--

