Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A267D46BF8
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 19:36:34 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3369.1769628989685821948
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 11:36:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=NCZFZBjo;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34AF510E9A1;
	Wed, 28 Jan 2026 20:36:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1769628987;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qNmoNzeUEQW5jpMx52ZpFplVSYCTz1QNlwyrAOkBMzM=;
	b=NCZFZBjoYCtxa8JRZfqNROMfgMwPp25nGWpWdN24d7H/gfski95JKQl4fZqm+Rv+mb7x2O
	J28m2x6tuHDYkKV/eRxOt7Q5TzDzOH3ymv+mIZuEgb9IPZ+jrVZEL+3gb6GlijZw7FMJrC
	2hNGqCkbDcRsf/rdLz3yYJHr0z9XBaRUj/OZY+gyUxvCEVg+EnjzY3kUYAL7FAPjhTZnhG
	m05UUR7VIAIXTmvlareWGksqq+sKPY44e9NQy8FJhTBTkTmF9ea+5Qr0E5TfVA8GOgOgXo
	GHsj/6fmtnbkjZLzK4U2sS28HEJaMWXqjc9OJnXC/LeJ77fvqkc3+Dx7LkLmrA==
Date: Wed, 28 Jan 2026 20:36:25 +0100
From: Pavel Machek <pavel@nabladev.com>
To: tommaso.merciai.xr@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/4] Add RZ/G3E DMAC support
Message-ID: <aXplOU/fgckpEbAT@duo.ucw.cz>
References: <20260128160048.1445926-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z+trZjlYoyF0Ljqf"
Content-Disposition: inline
In-Reply-To: <20260128160048.1445926-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 19:36:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21780


--Z+trZjlYoyF0Ljqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds DMAC support for the Renesas RZ/G3E SoC into linux-cip
> 6.12.y-cip kernel. Backported also commit
> e57389d5547ee24b472ac5c8f8a7dc21b063ad73 upstream on top of this series.

As with 6.1 version, this looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--Z+trZjlYoyF0Ljqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaXplOQAKCRAw5/Bqldv6
8ptcAJ95pCkKxShtx9Mde3xHNPzdWF7TjgCgpWn8bj3kFB2mQWub7JJ9OmCvK/U=
=8fCl
-----END PGP SIGNATURE-----

--Z+trZjlYoyF0Ljqf--

