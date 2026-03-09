Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E7EEF3714
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 08:17:43 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9336.1773044259631170649
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 01:17:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=iS2eWqQQ;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EEAB107D3C;
	Mon,  9 Mar 2026 09:17:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773044257;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=1hrv1ZLWT9UjAW7GT72H8g5K3ThSxC37BKKqSZFn6Bk=;
	b=iS2eWqQQlT0bQTb3NdfqfFJyJChLVq5vZ2CLnwBYAiAwTVNkV6btlkAuyktWUF5RofX4LK
	7zCqVVHQgI9dqWq4Nztl7izuMDTLJ1AAjTxjPU05RnfTQ7lQCFaVKgIdyjQFi/fwZn/MFy
	LnRTq7G1T0MftFro3UHgUmm+BpLAJYHnjB6TppXrGUlRmJuesZuuBo2L+M2S6ViPue2NVA
	mzuOXO9OdHADDzzVLYPTnGJUfeN6GK7W1F1qvdTYhZLUSxClxVh+7Bu7Hq6ubLE/mpRBIT
	8cQkF3jEAjqiYDBeqwKQOVRDKOsbcD5k12SaFz1XN+j8lHysEMnh3ihk8CfEOA==
Date: Mon, 9 Mar 2026 09:17:35 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 0/6] Add suspend/resume support for RZ/G3E ICU
Message-ID: <aa6CH7BewI/LNNPi@duo.ucw.cz>
References: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p7Z3AtEYGDLujn8o"
Content-Disposition: inline
In-Reply-To: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 08:17:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22163


--p7Z3AtEYGDLujn8o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Add suspend/resume support for RZ/G3E ICU(interrupt controller unit). Also
> add support for CAN FD-Only mode.

Should be refactored in the mainline, but that should not block the merge.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--p7Z3AtEYGDLujn8o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaa6CHwAKCRAw5/Bqldv6
8pI2AKCsA+Ryz/NTsd5gU8pRbKS1gb94IACglUjRCtq6aAKPVuiRMD4VXEiwL7I=
=2MXY
-----END PGP SIGNATURE-----

--p7Z3AtEYGDLujn8o--

