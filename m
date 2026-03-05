Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD39EEF327
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 08:43:20 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39840.1772700193687721901
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Mar 2026 00:43:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=gi5UeX1p;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B930103754;
	Thu,  5 Mar 2026 09:43:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772700192;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=6WdrtQBK5RdqtYT3rUEbyprgZapO9m4d4LKEAeO+huc=;
	b=gi5UeX1pKOi5XXIoCuCCxiTCDu9m1Zn2qZl1wSH1gCrd1LmnNqiQx2E+6xiYCufyP1qrrP
	OWs15GURyI4WfrnZXe1ZDiHV9ngItTtDok6m2xmhafSI9IL/ub/DPpQSEAo2J780gXMFwP
	PVAaKnAS3bg4PSw3d+FAxYaswRFAG9M/Jsc3cGr2epYe4yPJMwR8f7o1QxiXKWfBnNOB13
	h22G/Vavs5hPD18Sz7YgsblVpWVlK8Fp5J0XVBwj6xQLgso/oD3uL6LcOxdR+Nv6d4Iqav
	m827zfRGtLALod7FD/G+9+qaF5EbDqtsnaEBVYuoQm9RALYfy1unHRvsuaTlOw==
Date: Thu, 5 Mar 2026 09:43:09 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 06/11] iio: adc: add RZ/T2H / RZ/N2H ADC driver
Message-ID: <aalCHfG2axQ6CaoN@duo.ucw.cz>
References: <20260303165351.914437-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260303165351.914437-7-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yiowL94xYjgr1PD"
Content-Disposition: inline
In-Reply-To: <20260303165351.914437-7-cosmin-gabriel.tanislav.xa@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Mar 2026 08:43:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22076


--1yiowL94xYjgr1PD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> +++ b/drivers/iio/adc/rzt2h_adc.c
> @@ -0,0 +1,304 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>

Normally, we'd have at least few lines of comments, perhaps saying
what hardware this support and copyright with dates?

Thanks and best regards,
								Pavel

--1yiowL94xYjgr1PD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaalCHQAKCRAw5/Bqldv6
8pbRAKCjYkZXWdewuodVVs1ieIyDQRrgRwCgifK78shHrtwU8TlyU+wIhpb0EvU=
=vIjH
-----END PGP SIGNATURE-----

--1yiowL94xYjgr1PD--

