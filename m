Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAABEF3715
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 08:19:03 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9344.1773044335878502112
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 01:18:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=T8uFOAV4;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8E7B1107D3C;
	Mon,  9 Mar 2026 09:18:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773044334;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fMj5FsuTt9edhg2UPCZ/GBXwE7QOKFrdmi+eyULE9I0=;
	b=T8uFOAV4dc2n8UXbZBUzD3rbXJCZLGiiOXQQw/bHHmbVHR806PUQd7GEwzQPxS7QW0xO3L
	qaHsFlZ0eEvoEqJtm/cmtmS+5b3bf0Wokq7jqp5qanesfQyFsRIbjN9rhZ7ReyHBB/sDve
	sGsqW2KMgJqVkEutx/tluzgv1E+M5R8kDL3kIXHatrPvsvaWO9MKRht0IdhJFcHteIYpGE
	+OIsAUtpdqa6npioKoVGNKIV5JCa+zvV8ZUNr5IzSQ1Iyzre6Etand8vHeBYIruuhnFFfm
	sfYmIg3VJ0WDp1VDESM8Oo6tjXApoHR4rjd9FThDeCXyXYKd5bQImw3F/ZHtwA==
Date: Mon, 9 Mar 2026 09:18:52 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/6] Add suspend/resume support for RZ/G3E ICU
Message-ID: <aa6CbMQ18Zflw2Yk@duo.ucw.cz>
References: <20260309081129.154109-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iHZZ1U+NaqPVBNPd"
Content-Disposition: inline
In-Reply-To: <20260309081129.154109-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 08:19:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22164


--iHZZ1U+NaqPVBNPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Add suspend/resume support for RZ/G3E ICU(interrupt controller unit). Also
> add support for CAN FD-Only mode.

Similar to 6.12, this looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--iHZZ1U+NaqPVBNPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaa6CbAAKCRAw5/Bqldv6
8pHBAJ9BHJv6entNuxZroVALFOyEsK64CgCeNVp1K/89dJ48Kt6EJdrqHKh1+VY=
=kmjG
-----END PGP SIGNATURE-----

--iHZZ1U+NaqPVBNPd--

