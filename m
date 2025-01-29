Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E039FC0218D
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 08:58:04 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.8627.1738141071314132962
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jan 2025 00:57:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=inyfpOM9;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB8F210382D08;
	Wed, 29 Jan 2025 09:57:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1738141069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=gn2VrvjIynAHMyc+Iw6bh8NVbo55cl69JXSee/HRIw8=;
	b=inyfpOM9migMmUixLzwDXv+T7gvwqASzgUhD4VmOfCO9R6a6gU0gu5Nwb5nSr0J77CMicV
	58DMBx1T5qMkINFLR7fRtb1awUXWLd+0sJhfIWLcuGHcEBmVsNVs4YfdFQ/YFuySVYAu6L
	bKDk7Grnz7wUjPVSw7WfE9ljWrEjCbsuxBpo+Qs0EY98WzSJhb+GGNK+5UpQNWzyk0aY0p
	y3SNL1vLUx0aoqibnCcFCj1eePagHyE6c48Kt/sWCYgLByFv4Ab/xT62TTd3thNC4Iz/VW
	653+yoGJFXOGW61vrNySSXx1//yvEcYWLMtf2gUq2kVIs1UXXP+x+L3kI5xyww==
Date: Wed, 29 Jan 2025 09:57:43 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [ANNOUNCE] v6.1.127-cip36
Message-ID: <Z5nth2WooaiPYAW+@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mvxix9Ccy5gTvjoO"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Jan 2025 08:58:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17676


--Mvxix9Ccy5gTvjoO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New -cip release should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rebase

And their content should be identical.

There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Mvxix9Ccy5gTvjoO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ5nthwAKCRAw5/Bqldv6
8u39AJ95TkO3ikhwqw3DLVYqPhU91IzX/ACfSxw4XWMv//rLp6dDQKz4PMAkuFY=
=GVBa
-----END PGP SIGNATURE-----

--Mvxix9Ccy5gTvjoO--

