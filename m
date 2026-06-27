Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175D9C43458
	for <webhook@archiver.kernel.org>; Sat, 27 Jun 2026 21:35:48 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8490.1782596145347357741
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 Jun 2026 14:35:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Qyg3ilLC;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF66B118250;
	Sat, 27 Jun 2026 23:35:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782596142;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=AzQ9uMYz0+wXDD/NlbjBnoV+AnNYzOEzufz8OyTxQuw=;
	b=Qyg3ilLCmaqJFYth00aSO7EjTetvudYlkEPXRS47xyQiV7Log5deYm0DBBefQ/7eqzWrlw
	5gYQCzpx6DXGILjkqt3Cxq4XydlJrW2jvJGsHFaKtp52JNtMToUnJwnGHXhOnYOlPaJilr
	Si8lbWLIP6P2eeWKPub6n9q8CWmSCQ6T5WsdrknIKMU5iGnqCZXTdMW4oNyQMtz599n7tR
	CSxLhkuBuwV9HmgtR8asSpIOpqWMbaUlEBmQyX9OjSZjTYXPQgYZjfXB3U/EJ2BBQmTMhK
	3W0Jucl0ZJlvuFYn6MSLY2h5PupEGuv3jwsYb3MyVm2SezdgAHYN4JShxYl0TQ==
Date: Sat, 27 Jun 2026 23:35:36 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/32] Add RSPI support for RZ/G3E SoC
Message-ID: <akBCKNYSELOi93EL@duo.ucw.cz>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5eSA14V35jseKllk"
Content-Disposition: inline
In-Reply-To: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 Jun 2026 21:35:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23294


--5eSA14V35jseKllk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This patch series adds RSPI support for the Renesas RZ/G3E SoC, which
> features three RSPI controllers. The series also enables DMA support in
> the RSPI driver, and backports the necessary infrastructure changes
> into linux-6.1.y-cip.

Thank you, applied.

Best regards,
								Pavel

--5eSA14V35jseKllk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCakBCKAAKCRAw5/Bqldv6
8lgPAJ9Y2g5IkzqH33lRbLE+9p262XxZYgCfdOzxVBtqHKR/wdnXF0amupXijto=
=lJVZ
-----END PGP SIGNATURE-----

--5eSA14V35jseKllk--

