Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A071C369AB
	for <webhook@archiver.kernel.org>; Thu, 24 Apr 2025 10:39:03 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.11958.1745491135591899652
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Apr 2025 03:38:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=ZeU1tDds;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3EB810275AE2;
	Thu, 24 Apr 2025 12:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745491133; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=7gl4Hvhdc4ve3n8nAV/aEEHMDKdCwMbi9SJowrS+5KM=;
	b=ZeU1tDdsVM3uSGhH4e+2veXQc8btSU7LNMBW28t5lIuvZPhh9TkulR4iQwo2IDi/Kq9S2e
	ILlM7qotqnSxu3Nge0A50jCCbh6EK8FtATEsB02i6v83+PEtkHMmOozZq6jCvrHKpVBnTh
	FzRxY1lTmzuGQLwyvz2GVugqj+jqQ5kqvNk/m3kuSs+9BV+8/bbgvt/Zusa7CHVPTJGaKL
	hWwBgIIbyOvPIqQufZhSVOA4l3ga6cTY73+V1v1cuMI0oRbhs9pV4msH0FDAiZnvTJteeV
	e+WZI3n/cPsBbg+InhBLbRTxDPVHW86Cp26zQJbns/KldCdE/iwyxOC5q5+xCA==
Date: Thu, 24 Apr 2025 12:38:46 +0200
From: Pavel Machek <pavel@denx.de>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/8] i2c: riic: miscellaneous code
 cleanup and improvements
Message-ID: <aAoUtuG/U7e0X3NC@duo.ucw.cz>
References: <20250423210458.14698-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JmeT2jjIcFZv1XXl"
Content-Disposition: inline
In-Reply-To: <20250423210458.14698-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Apr 2025 10:39:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18597


--JmeT2jjIcFZv1XXl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series includes miscellaneous code cleanup and
> improvements to RIIC driver used by Renesas RZ SoCs.
>=20
> Note, all the patches have been cherry-picked from v6.15-rc3.

Thank you, looks okay to me. I can apply it if passes testing and if
there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--JmeT2jjIcFZv1XXl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAoUtgAKCRAw5/Bqldv6
8kpMAKDEyyC2Qz8ljbJnMs3VO9dFFJTS4ACggoYspIKciXRs6XEt6LTSsvCvxn4=
=JniN
-----END PGP SIGNATURE-----

--JmeT2jjIcFZv1XXl--

