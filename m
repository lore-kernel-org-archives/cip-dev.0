Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0D8D0E6C4
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 10:51:28 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14231.1764067887306386340
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Nov 2025 02:51:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=CSMm3HJB;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D55FB10074A3C;
	Tue, 25 Nov 2025 11:51:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1764067884; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Z3BGMMl13iCZB5TypY5gCUUQlzbgyczJL5sC5aECfgo=;
	b=CSMm3HJBrCuWLZI81PMVXDQRo+IAZBbLJwG6r/4mbjEAiKoHJTyXHCxISL8yDcRWgJVZDM
	RjU8U0ArmFYB4O+zooEij5X9LOnLHMw/Hx6lbVcxKBgH/p1NbGa1MCDe87WMxtVzM3+EjB
	Ox9kZxgTGC2iO9yFaVx/ISdpFszWWgjH8LfSWRjh7qFitchgeeRnO4i21oE3cJ59n+DbHD
	gvocNDWa+QvcuTnZJuxlolrkETauiRNBXTMz0BmoM/s8gVdCmrEHx05FgUbeEu1KsmPTO0
	fQS/BncwIQFW9YsVOEVOL9QOAxn+HU2Dy9M/tPodT1GcncqYXO8Argw5SvFD3g==
Date: Tue, 25 Nov 2025 11:51:12 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 0/2] ASoC: Renesas: Backport audio fixes
Message-ID: <aSWKIPt09PcsDXiC@duo.ucw.cz>
References: <20251122105133.2783194-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ap8iRf+aTKGogaY"
Content-Disposition: inline
In-Reply-To: <20251122105133.2783194-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Nov 2025 10:51:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20723


--4Ap8iRf+aTKGogaY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports audio fixes necessary for the Renesas RZ/G3S SoC
> and the Renesas RZ SMARC Carrier-II board.

Thank you, applied and pushed out.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4Ap8iRf+aTKGogaY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSWKIAAKCRAw5/Bqldv6
8vQaAKCVwr4lrmzdG4xRSP2XhFEtvjCDmgCfUKU+x9jJPXy/PGDqDGuTAZO/1eA=
=GvPt
-----END PGP SIGNATURE-----

--4Ap8iRf+aTKGogaY--

