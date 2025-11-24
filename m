Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE60CFA466
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 10:00:47 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13457.1763978443982926579
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 02:00:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=M93ztb5S;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D562F10074A12;
	Mon, 24 Nov 2025 11:00:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763978441; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=j8MNZQDz5/MOvF+jtf9+yaO+YGopl5omjnu7RpvI8j0=;
	b=M93ztb5SVLm4HsM5gpfLcc5/mV+4WP1rneyVuvafNFq8Ja8119ItTkzpmTfpyVUpceHisk
	IyJmj6ePwOtFRv2JB3E7xnDjUQEjUpmjPygv+b92IUcnXj8/mYrubKPT1pL/g5v76jfLJ8
	vmL421C+9Oh+g29WBD7hlVZK3cjfNQ8o1EJD+ExDRm+lgzU0RaGJXDPXbSiJTgAI2sPl33
	vEny8pFDHx0/jLmG9OZnrupejGYcjF+OoWu1Tcipc7527l57uFehBAiappWlGe+WxWEoaI
	yqTD2J3P+F3dSSMJHGczYt0dNqwBIa7XnR5KWJzdreb/WwKSqjcIi/SRCks2Qg==
Date: Mon, 24 Nov 2025 11:00:37 +0100
From: Pavel Machek <pavel@denx.de>
To: iwamatsu@gmail.com
Cc: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/6] Add RZ/V2H XSPI support
Message-ID: <aSQsxWLLrEku0o5y@duo.ucw.cz>
References: <20251121080647.20592-1-ovidiu.panait.rb@renesas.com>
 <CACe6DC4YQQfySU-Cy81aEBN42L7hp+Ff0JvmhJctsWvg4xE0Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZopkDnwq4D98pOW9"
Content-Disposition: inline
In-Reply-To: <CACe6DC4YQQfySU-Cy81aEBN42L7hp+Ff0JvmhJctsWvg4xE0Hw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 10:00:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20706


--ZopkDnwq4D98pOW9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This series adds XSPI support for the Renesas RZ/V2H SoC and enables the
> > MT25QU512ABB8E12 flash device used on the RZ/V2H EVK board.
> >
> > Patches were cherry-picked from mainline kernel.

> Looks good to me,  I can apply this series if there are no other comments.

Thank you, applied and pushed out.

Best regards,
     								Pavel	=09
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ZopkDnwq4D98pOW9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSQsxQAKCRAw5/Bqldv6
8l75AKCuKYwBtdqeNlE/i7W0AcbolRKEFgCggzN8yNYBxpCS+7lPHPQRa9Jzgbs=
=/qoB
-----END PGP SIGNATURE-----

--ZopkDnwq4D98pOW9--

