Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5C0CEFD01
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 19:45:22 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.98820.1767728717769076319
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 11:45:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=DoWqIaOy;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5CD110C8A8;
	Tue,  6 Jan 2026 20:45:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767728715;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OYjTfvwIyDCRn+KnT2jfO7AHbZiSOGOC+7c/t+s2WWU=;
	b=DoWqIaOy0pZ6ZggKowPI9D0Shd9kZBPPPoh/RaraNL5PfGoOWneQ1rOh5j67zi2/FPaMc2
	GtduODi4WJsnQtz8s6craTBHyDh7p4HdkqzxitBfrGBN5dFbjVyk6SMb04lEA+4M8SLNTO
	qVXMmpjODmG2CB0FXAiWxFftjED2wFqo7M41Q76fg8EZ9/dU1Ofp6X03uvj3d96BOiiKPn
	gvGLhbNDLYzDBqzKsQt40/rqJgTHBszDmi/DHBf4igitK5CNR+emuovubWjW6qMxGXtLnd
	M6z3lYa2aQ3Pw52wLW1mizc+KCtfmAo6jbq+ip6KEZMJfWfF3BNE/M7iXQsN7Q==
Date: Tue, 6 Jan 2026 20:45:09 +0100
From: Pavel Machek <pavel@nabladev.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Add SDHI/eMMC and WDT support
 for RZ/T2H and RZ/N2H
Message-ID: <aV1mRc+5axWmoPGi@duo.ucw.cz>
References: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r4/3paMMTakRJgtJ"
Content-Disposition: inline
In-Reply-To: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 19:45:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21391


--r4/3paMMTakRJgtJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series of patches adds support for the SDHI/eMMC controller as well =
as
> the Watchdog Timer (WDT) found on the Renesas RZ/T2H (R9A09G077) and RZ/N=
2H
> (R9A09G087) SoCs. The series includes device tree bindings, clock control=
ler
> support, and device tree nodes for the respective peripherals.

Thank you, applied.

Best regards,
									Pavel
--=20
In cooperation with Nabla.

--r4/3paMMTakRJgtJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaV1mRQAKCRAw5/Bqldv6
8qVlAKDDdeO7pejCULAHZguQ55OVXQaRsQCfbJPhruHCnoCey/wpVo10Lj0smi8=
=fWjs
-----END PGP SIGNATURE-----

--r4/3paMMTakRJgtJ--

