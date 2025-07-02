Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF23C83F03
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 20:13:09 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.6049.1751487181051936572
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 13:13:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=K3KgVbok;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ECFDA10380104;
	Wed,  2 Jul 2025 22:12:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751487179; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=DHbZPH0LiXlHhm28o5gcBVj7u/Q6bGytktfu6PF40r8=;
	b=K3KgVbokfekaqMekT+n+BqmjXOGvHTem5qWBma0cq+jrco9/4opxKgbKqhIYMQ0tLYtF1O
	e0IPED0HefmK1Bxvtjr/876+H7p6CMlVO7ucoo18jrvjRXbEpWvZS7UWh8/SkKPOMJYktG
	oPIBu/eK59KiMH/0j+vBJse8icIuwfKvLSFC4tJHOXADNC1dJZ/X/GyRLQHI6gY6zYIsGO
	N0va6JaLXZS5TnX3i/oLVKCh/Hekw/SAoYjUyseuhqA3iCBM3oGTOa0Q9yedAREaB8Mbrf
	/9+eQoDpXVCvXAaE6HZk4eU9QEWihn14hkxa3tOewaFHTJNFSiAkmH3MnRreYA==
Date: Wed, 2 Jul 2025 22:12:50 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/12] Add support for Mali-G52 to RZ/G3E SoC
Message-ID: <aGWSwnzsMe0Opgsp@duo.ucw.cz>
References: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7ARY9jJGf3UxSbp"
Content-Disposition: inline
In-Reply-To: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 20:13:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19315


--Y7ARY9jJGf3UxSbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds support for the Mali-G52 GPU on the RZ/G3E SoC into
> linux-cip 6.12.y Linux Kernel.
>=20
> The changes include updating the device tree bindings, adding the GPU node
> to the SoC device tree, and enabling the GPU on the R9A09G047E57
> SMARC SoM board.

Looks good to me. I can apply it provided it passes testing and there
are no other comments.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Y7ARY9jJGf3UxSbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGWSwgAKCRAw5/Bqldv6
8q37AJ422+c5Li+qmF0Dw7uTY2wx62XqYQCfRhhtD0Az/+lbmFwXc99Ip5nbG5g=
=/Q10
-----END PGP SIGNATURE-----

--Y7ARY9jJGf3UxSbp--

