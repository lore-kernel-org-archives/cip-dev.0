Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D05AC83F07
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 10:44:39 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.57017.1751885078306552304
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 03:44:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=BFv2J16C;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 427F310380104;
	Mon,  7 Jul 2025 12:44:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751885076; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=7lHYrH+vouX2LaHpthe8A9udiRTqw7aotqUAgIDT9Rg=;
	b=BFv2J16CVa+XRTUodTBUpVpb7+lV8xr0dyhRARXu1pgEbOdGku4ijm3Maoyn/pMB6rSRSD
	Z9/ymahvPZ5hTMZtgWMaCDd7NdbnK86cRNZi3SJs7fdhlKjzYpyUU5iQX9DRd3BrPUuX/v
	V8cZapHNWsSGpRl3pOxtp9FqeDc3LXNXZgHxZom89PADDnQawOszvGj8Q9e7s/gf/yYuc7
	9rLNY6awicDGpcr0MytfM9qCD8bG/QjMCvgAHAOBqybRhEpL8/U1womesmdTO0imIfvc5F
	jgbyYad2heb5APPi4KSxwIlekZ6F79D7dU9WIQRahQx97NiU3ONOzUlLRWB4uQ==
Date: Mon, 7 Jul 2025 12:44:29 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: tommaso.merciai.xr@bp.renesas.com, cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/18] Add Support for RZ/G3E ICU
Message-ID: <aGulDRIlJUb0sp/y@duo.ucw.cz>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
 <TY7PR01MB14818CB81D68F62448BF2E546924FA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ef62YbH4cGVSu1gg"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818CB81D68F62448BF2E546924FA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Jul 2025 10:44:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19384


--ef62YbH4cGVSu1gg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> I reviewed this series, looks good to me. I can apply, if there are no ot=
her comments and test was OK.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for the review.

I ran the tests at
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1910922707
=2E vx2 is not yet finished, but I don't believe that will finish, as
reported in the other mail. This was arm patch, so....

I've added your reviewed-by tag and pushed the series.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ef62YbH4cGVSu1gg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGulDQAKCRAw5/Bqldv6
8rMQAKDE1k0sLPeGpfQpYIeVuYsPNLQLxgCfUJDpm6F2wsVYX8YdYiBLX1Y16j8=
=Ccz+
-----END PGP SIGNATURE-----

--ef62YbH4cGVSu1gg--

