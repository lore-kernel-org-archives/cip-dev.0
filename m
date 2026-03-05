Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A138EEEF329
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 08:45:50 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40087.1772700346342380810
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Mar 2026 00:45:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=aAVNXICs;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 72BB610334E;
	Thu,  5 Mar 2026 09:45:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772700344;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=daGkY72QG7IH1ryXW1qje+528mmPJI1QCMREq3xyPqc=;
	b=aAVNXICsj0kYpWtjJP2Hi2xq4bLwFB51AGWqtVtxpqXh9ESjWRE6DsuzoqeIHPZ0+aU4a7
	6I7ArluWhSjPMtDcnHYAn9mEPWdrduTEaSrrR2CDm/8YT30EGQEDAjh2w1uvF4Dhs5VPrB
	4nHn+syOfxRED06FSMtxQttiOKNvxR+LZ249cOSKiSY8En0LAQ3dr16bd9uKaySOT+feJp
	wAmTkZOkdOWXPNd5gtA+2VBmgxrTtzatOME0MG+O91LoYrb3YFWqcJeC/4F2TwqFPy8t7H
	h6aQcyFcx7hApIH4WHiaIwteU3Mjwi1AUFXQfuCtXPsN0a1qB6rDrb1hKzjP6g==
Date: Thu, 5 Mar 2026 09:45:42 +0100
From: Pavel Machek <pavel@nabladev.com>
To: cosmin-gabriel.tanislav.xa@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/11] Add ADCs support for RZ/T2H
 and RZ/N2H
Message-ID: <aalCtoFg4lm1b0jI@duo.ucw.cz>
References: <20260303165351.914437-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KY+96tKesFjPmsfH"
Content-Disposition: inline
In-Reply-To: <20260303165351.914437-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Mar 2026 08:45:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22078


--KY+96tKesFjPmsfH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On Tue 2026-03-03 18:53:40, Cosmin Tanislav via lists.cip-project.org wrote:
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs include three
> 12-Bit successive approximation A/D converters.

I had some minor comments here, but those should be fixed in mainline,
first, so they should not block the merge.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--KY+96tKesFjPmsfH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaalCtgAKCRAw5/Bqldv6
8j7iAJ4slUnPe4wH4J2sg/cXkt7teLvurwCfTyxGoEvN2E58zHF2hN3PnUbkMIg=
=OfFi
-----END PGP SIGNATURE-----

--KY+96tKesFjPmsfH--

