Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0B4D4922A
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 13:02:25 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12200.1765544536764267008
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 05:02:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=PGdZEX9f;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 983771038C120;
	Fri, 12 Dec 2025 14:02:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1765544534; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=SHDU6/9xJgwM6FSEi158OQOLNSUbaBq79acKsjs9I0Y=;
	b=PGdZEX9fbhfVg8/6qS3bNOv6tq2KpPLWN4m8jBblYBG9m6vrFvC3YFZtsbxaVhLzhVe4f3
	FO4JSfw1rXsYHpMjSAkzM0cS6WksIwi/6sPqDc85o58nfkNMRKJlF6852Yuy/ix+rVnDXU
	MTJxA1YGea68S/KDxUsG6vhwqrPHbjTxIxJLB7//vHr+edlL41B4PirFoU5gZrnNZaJzcE
	YsclNjnjx5YsWKEi09nVlCt1YUgOk/5iHjCS0tv6Yhk4877l7sZDsUbi0RMm4b6yxK7MKk
	RW5+LGF8kJI0vPHshXRS2cgazn7Dpfc2h1BnESnx41/zrzI/WsNE/EIMfg6PYw==
Date: Fri, 12 Dec 2025 14:02:10 +0100
From: Pavel Machek <pavel@denx.de>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/38] Add support for Renesas
 RZ/T2H and RZ/N2H SoCs
Message-ID: <aTwSUpVdQYXyTzTQ@duo.ucw.cz>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FF7d0tsHZPXVFi3F"
Content-Disposition: inline
In-Reply-To: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 13:02:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20987


--FF7d0tsHZPXVFi3F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds baseline support for Renesas RZ/T2H [0] and RZ/N2H [1]
> SoCs, covering DT bindings, SoC configuration entries, CPG/MSSR clocks,
> pinctrl support, and the necessary updates to the sh-sci driver to handle
> the new SCI/RSCI instances. It introduces initial SoC and EVK DTSI/DTS
> files, refactors the existing RZ/T2H EVK description, and adds variant
> specific data and common EVK features such as pinctrl nodes and user LEDs.
> These changes form the core groundwork for further enablement in
> CIP.

I had some minor comments, but overall this looks good to me, an I can
apply it if it passes testing and there are no other comments.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FF7d0tsHZPXVFi3F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaTwSUgAKCRAw5/Bqldv6
8puHAKCtYhljxEroKoSe+OvHNyCMzKUeOQCdHL0wS7cptAvJmLKxH5azZtLOORQ=
=bokP
-----END PGP SIGNATURE-----

--FF7d0tsHZPXVFi3F--

