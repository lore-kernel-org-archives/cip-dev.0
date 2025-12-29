Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B50E92FC4
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 20:12:45 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50582.1767039163141493624
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 12:12:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=BMWWQ1O3;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08FE210092128;
	Mon, 29 Dec 2025 21:12:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1767039161; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LVFkrwaFa0lhmuvZaiWbiRT9+7m/MRqbssncGe9Irxg=;
	b=BMWWQ1O3joimyjbF5uQwA9D2oKdB1W2mII16AtiTFTOhtZd6/DSGqAwEPBVcX6R10q2ZEP
	6Q6hG1EE96efqUKiN+6tcgJ3Y4xFjQe2We0eA0uSvK6ZIGyaxWOron4R01Bj/79A1OWTnP
	UVDe0rMXAkFdaZhd2kK/+qpPBKsaacnErqdcM1nlsYgYuTCMUNnx4OV3VKRTxX/a5oTvb2
	BMDBxNbbsGHcuDgTtHdQgTFikEbFatkUdOr3Gac5G96MWH2IGsbFZhmtch1uZ03VUrAa6B
	kCtfexVjcPUXu+x4Cu7msMfEbOmMCFZYWtA4b+EfTK2zrIMPC4wxhYv3j+7yng==
Date: Mon, 29 Dec 2025 21:12:35 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/6] RZ/G3S: Backport TSU support
Message-ID: <aVLgsxs+w2gvDjmm@duo.ucw.cz>
References: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB14818367AD749019DCAAF7364CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <535bd4f4-117b-475a-b616-2262c2247152@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="58IrQdN1mllE0ncj"
Content-Disposition: inline
In-Reply-To: <535bd4f4-117b-475a-b616-2262c2247152@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 20:12:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21250


--58IrQdN1mllE0ncj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I reviewed this series for each branches, looks good to me.
> > I can apply this if testing is no issue and there are no other comments.
> >    https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2232=
119913
> >    https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2232=
120629
> >    https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2232=
120713
>=20
> I see there are some failures among these pipelines. I see bootloader iss=
ues
> and console logging kind of failures. Are these related to this series and
> v5.10, v6.1 ones?

The "*629" pipeline... mcom does not have available targets, so that's
not your fault. I hit retry on the renesas target.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--58IrQdN1mllE0ncj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVLgswAKCRAw5/Bqldv6
8k1LAJ9dda72ti9qu4DGXrhsvyO8PCArXwCgp9SaG87SZ/nzXN670iUPeDH3TOI=
=B9Sv
-----END PGP SIGNATURE-----

--58IrQdN1mllE0ncj--

