Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BACA103D924
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 09:53:53 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10487.1773827623727852050
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2026 02:53:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=D9ZT6fHU;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F7AE101EFE;
	Wed, 18 Mar 2026 10:53:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773827621;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YbXFpmQjpfI8Zxy5yT2H60e1TJUrN1xPyD5aap5oylg=;
	b=D9ZT6fHUocxx4qnSJnhjhIYlU3OFPzqGZp+H1AZ30jYU+YMuoTCXaw/Sc/vhhxFEP35HSN
	upp3oEGfGOI66bIrXtWlIgVJ+nxRRevC06t6jgL+Au4ouLKk+rSauiTOTkU4ctNuFXHuzy
	qViW32FZgS8KEjx4xwfoyEjjESexfwIY05jMWwVrstRuT2uX+IcOdUxbipG8YGso76v2rd
	NQsM78HT7GfQ/g+6IOFbLiooHmqIaLj6speDBCjpSdueC09+PEteFn7086cPd0Znq3PBlH
	GzApJfFtgMakjJ3TEZ8gbDuHtIFw5fxzg3ZDiQSm4gkVkwnYBwudWyUhHXYrlQ==
Date: Wed, 18 Mar 2026 10:53:36 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip v2 00/27] Add RZ/G3E RSCI support
Message-ID: <abp2IKZAbWTGmy3q@duo.ucw.cz>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gI4wxg5q40PnasQ"
Content-Disposition: inline
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 09:53:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22496


--7gI4wxg5q40PnasQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Add RZ/G3E RSCI support for FIFO and non-FIFO mode. RSCI IP found on
> RZ/G3E SoC is similar to one on RZ/T2H, but has 32-stage fifo. RZ/G3E has
> 6 clocks (5 module clocks + 1 external clock) compared to 3 clocks
> (2 module clocks + 1 external clock) on RZ/T2H, and it has multiple
> resets. It has 6 irqs compared to 4 on RZ/T2H. Add support for the
> hardware flow control.

Thank you, applied.

Best regards,
								Pavel

--7gI4wxg5q40PnasQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabp2IAAKCRAw5/Bqldv6
8o+lAJ0W/RuVlCZ7vAaMp9QXdMOk8gdUxgCeLjct6Au18wfAC/VjrotoD8EiomM=
=RZnl
-----END PGP SIGNATURE-----

--7gI4wxg5q40PnasQ--

