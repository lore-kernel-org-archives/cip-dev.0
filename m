Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96801103D926
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 10:02:33 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10620.1773828144028267422
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2026 03:02:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=XPnbojm5;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98FB5101F1F;
	Wed, 18 Mar 2026 11:02:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773828141;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Kd5ylUCU/nTv6EzBVvELZutr6FL8PT32ZRg1HVr8GO4=;
	b=XPnbojm59pPcMj/PViw3C7u6iQaNjqIK5esEqPNl1oUvMcaVId25q+gsKbJI067AHY+SCi
	fSI3seg6Mpuq6LY6xWSRxse82friZfZvEyr2mg2IJHH4YF4RPuBWyxsTgDLuhUF6dVI46i
	GKE7uaxaE1//R5N7yA1EWJIVPdy3rrl+9tr6YccgZP+brIa0GP6SJSvEKR9HL4908KvPJe
	xHrPyoNsO/0c+dLg4Bv19fbyIADEIP88/I6Qae7jVLk3/hBJb1Pmi0bZnoZe9pB874/4iO
	zEanDr4RNlIqQbEqXydK56cEEJspNtwn55blHSLOYULxhgrJ3VOaROXVrDgTDw==
Date: Wed, 18 Mar 2026 11:02:18 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 08/11] phy: renesas: Add Renesas RZ/G3E USB3.0
 PHY driver
Message-ID: <abp4KprlYyU+jMPu@duo.ucw.cz>
References: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
 <20260312153522.1131675-9-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0l57bu7s69La5YsJ"
Content-Disposition: inline
In-Reply-To: <20260312153522.1131675-9-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 10:02:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22497


--0l57bu7s69La5YsJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Add Renesas RZ/G3E USB3.0 PHY driver. This module is connected
> between USB3 Host and PHY module. The main functions of this
> module are:
>  1) Reset control
>  2) Control of PHY input pins
>  3) Monitoring of PHY output pins

> +++ b/drivers/phy/renesas/Kconfig
> @@ -40,3 +40,10 @@ config PHY_RCAR_GEN3_USB3
>  	select GENERIC_PHY
>  	help
>  	  Support for USB 3.0 PHY found on Renesas R-Car generation 3 SoCs.
> +
> +config PHY_RZ_G3E_USB3
> +	tristate "Renesas RZ/G3E USB 3.0 PHY driver"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	select GENERIC_PHY
> +	help
> +	  Support for USB 3.0 PHY found on Renesas RZ/G3E SoCs.

We usually have notice about module name here.

> +++ b/drivers/phy/renesas/phy-rzg3e-usb3.c

> +MODULE_AUTHOR("biju.das.jz@bp.renesas.com>");

This should include real name and "<".

Thanks and best regards,
								Pavel

--0l57bu7s69La5YsJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabp4KgAKCRAw5/Bqldv6
8glaAJ4oW0dso/wEWwXtkE7DdDAj/H75IgCgsyFVFCXW7iHWZCh12JXC0VCmSmE=
=U7Q6
-----END PGP SIGNATURE-----

--0l57bu7s69La5YsJ--

