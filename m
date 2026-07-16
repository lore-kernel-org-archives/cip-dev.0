Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCCCC4450A
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 10:51:00 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10178.1784199052768816525
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2026 03:50:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Rb1U/9tv;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F57E119FBB;
	Thu, 16 Jul 2026 12:50:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784199050;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+18MJXe+HwF3elpwR6rZnlPHuju9R5PcXdnPfbo4pMk=;
	b=Rb1U/9tv2X8AI0xoXgeJcpqxmnMys3pwXCoIdvaeRKfnBFDpHUMXvQcSSZpsGzmwypPHim
	7Q3T9b5m7f7dPix2CSWBBieLAtLBI8vPT+BesjLFk+gkVbSuaEIJiksHjNZDKTvcOnKWaa
	3slEejP/EiQsQulqcg+EHTHBcP/lW8doUSBrXYS1Pw3gJ4IoK50kIVjgj/6xCqnJU13aZW
	jx218ex0PiKOCOv5f2QKrFreG7FdbOM6aBsXJzqDyvnlRHb+9aqTohNIftrR0+4LHpEZfw
	7YxjwgPemMrqGg5CRwmowwAIJ6BUufEZVzEhJj96u6rG4PFKCWS7UVG8HP7EBQ==
Date: Thu, 16 Jul 2026 12:50:48 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 8/8] arm64: dts: renesas: rzt2h-n2h-evk:
 Enable xSPI nodes
Message-ID: <ali3iLuUt9176IX6@duo.ucw.cz>
References: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706182328.5237-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2my29TS23rjSijN1"
Content-Disposition: inline
In-Reply-To: <20260706182328.5237-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 10:51:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23618


--2my29TS23rjSijN1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Configure the xSPI0 controller interface to 1-bit (x1) mode, even though
> the connected MX25LW51245 octal flash device supports octal mode.  Add a
> corresponding inline hardware comment detailing this restriction;

Thanks for the explanation and good comment.

I guess even better solution would be to reset the flash when the
board is reset -- connecting flash reset line to rest of the system?
But that's something for the hardware team.

Best regards,
								Pavel

--2my29TS23rjSijN1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCali3iAAKCRAw5/Bqldv6
8nTxAJ9EUhKTctg6eS7Kt7suGfqHdSWAIwCfba1LSIPu5pp6fnfAaz/zseJPEzs=
=w8Du
-----END PGP SIGNATURE-----

--2my29TS23rjSijN1--

