Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5728C83F03
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 18:13:08 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.2234.1751652785886828006
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 11:13:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Ku30SKkC;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 656E410380104;
	Fri,  4 Jul 2025 20:12:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751652783; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ZVjZKMrjnK+8CJL+D6oH3aSUyT22jCmB119Bw/j82H4=;
	b=Ku30SKkCDqnAGiUJyLgHx3eoHFmeFNCHAW3B2brNkzj4X5S/4S7rRQAzIrqomfabzDVzoZ
	6HMtqwYd8HDhMU9QLdY2gpQSxr+2QmucZMyuV8ysiz5YX9f24crsDlvmAej4vX7KF8H7kf
	8/s5rCQTT8SRstjtqwj5nlj9hT8IB0BoDAkB2RKdi8Q8DnqjvtKb7GRguhal27ytAyRta7
	1BxNh5k/BHIYFniBKzpDV8dxbEo6PcMDIdGPxUrASoeSVqm/CoBu++3lfxUWYUU7x1Dqa6
	S5HZP2pXAzfsiaTy2xJZoe9PF3hBKxyGcOFPtxzUJEF5dDx+IisbSoHOdXrQaQ==
Date: Fri, 4 Jul 2025 20:12:56 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/18] Add Support for RZ/G3E ICU
Message-ID: <aGgZqPAT9QADIQZr@duo.ucw.cz>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fQoHT96KZ+jYhu/N"
Content-Disposition: inline
In-Reply-To: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 18:13:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19365


--fQoHT96KZ+jYhu/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds support for the RZ/G3E ICU driver into linux 6.12.y-cip.
>=20
> The ICU block on the RZ/G3E SoC is almost identical to the one found on
> the RZ/V2H SoC, with the following differences:
>  - The TINT register base offset is 0x800 instead of zero.
>  - The number of supported GPIO interrupts for TINT selection is 141
>    instead of 86.
>  - The pin index and TINT selection index are not in the 1:1 map
>  - The number of TSSR registers is 16 instead of 8
>  - Each TSSR register can program 2 TINTs instead of 4 TINTs
>=20
> This series applies on top of [1]
>=20
> [1] https://patchwork.kernel.org/project/cip-dev/list/?series=3D978150&st=
ate=3D%2A&archive=3Dboth

Series looks ok to me.

I'll have some minor comments but nothing that should prevent
merge... so I can merge this if it passes testing and there are no
other comments.

One thing: "Signed-off-by:" section should not have empty lines in
that. I guess we can fix that up doing merge.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--fQoHT96KZ+jYhu/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGgZqAAKCRAw5/Bqldv6
8piNAJ9FYMpSshXpgnbsfyyuspsVMQD3ggCeLTy1HHR7gT+apIFbM6o01/gRoWs=
=RM69
-----END PGP SIGNATURE-----

--fQoHT96KZ+jYhu/N--

