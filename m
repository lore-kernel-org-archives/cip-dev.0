Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A887CCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 11:55:17 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13667.1762430113358979542
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 03:55:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=ahJzsjWh;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D5F31003CE21;
	Thu,  6 Nov 2025 12:55:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762430111; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ybhqoBygvJlvC2ZCp6Tm44dgIemohCkSTBMsZNmzd74=;
	b=ahJzsjWhFRE2cq/x0djguvnGrvn8fwOFCWyF9w28/710tyYdHSCFnwwYJtBO1sIY33KdSf
	tgUR/ZSm5osPNL6kVDg78xImq/Xs4c8hNEQL+uHc3IUqJhpQCGDboBIU3BP8ecJsyEFK65
	ySqOXzDGYRgQmX6M+6IUPIVHARPyh8fU45Xg7Wf2qA5crYP6c2996ubjV9jImvtFc3YCt5
	Mgu3arVEeWtna72YoULWgcoOatWxH7qmEIB4TcZL/OXzcpMwHyWFqEHBpBMx5FfHQtfY3T
	do6PWMCjhkWDJWGUl8ZIxtTJC+usYwV21xF7nXxQq1t6+2jp40x7rhtnO+1PKA==
Date: Thu, 6 Nov 2025 12:55:09 +0100
From: Pavel Machek <pavel@denx.de>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 6.12.y-cip 01/22] soc: renesas: Add config option for
 RZ/V2N (R9A09G056) SoC
Message-ID: <aQyMnX/es/SKISqF@duo.ucw.cz>
References: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
 <20251103113817.36331-2-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XCpyCJLHwtYERq7U"
Content-Disposition: inline
In-Reply-To: <20251103113817.36331-2-john.madieu.xa@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 11:55:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20461


--XCpyCJLHwtYERq7U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi1

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> [ Upstream commit 31d358e611b7cc21349da58dd2c9118c84b0859f ]
>=20
> Add a new Kconfig option, ARCH_R9A09G056, to enable ARM64 platform support
> for the Renesas RZ/V2N SoC. Default this option to "y" when ARCH_RENESAS =
is
> enabled, ensuring that support for the RZ/V2N SoC is automatically
> included.

As for the 6.12 series, I propose to drop this patch and apply the
series.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--XCpyCJLHwtYERq7U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQyMnQAKCRAw5/Bqldv6
8mVoAJ95gzhhfQmgS4o0Ayq81Uf3V/Df8QCgqGCIDSDGJ2oj1BuC4lgf+lD+rWE=
=FppL
-----END PGP SIGNATURE-----

--XCpyCJLHwtYERq7U--

