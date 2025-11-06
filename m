Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86486CCFA13
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 19:16:01 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5969.1762456553943560847
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 11:15:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=iYsTfdZL;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 778FB1003CE2F;
	Thu,  6 Nov 2025 20:15:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762456552; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=1juX0F7lS8Ia0M2wyS1lfw8UHqyQUmMPYMc8ER8zelQ=;
	b=iYsTfdZLeLtp90ONnvAx4PPSB9tkEOokgzymqc7J4BwrZtAhJpAfoWqyoqk75cbIATw32t
	hzUhVXDMWgGzHOd8IKQTLYxv8bQr7A8kdDeghNNw17fRXJOuYvWENdorLrtRh6Z0NMXRPv
	pEz5UKtGl211+L970Rsu4/DTguleyYkeAo0zMBot2BGJzJ5LjUvTzjajB6YipHon0veB2d
	sA4MiGOQKG/ZMmVHp9ylbGHOw53US8uVihI7ozUzuqfpFevPpz1nv0yA3P9X/SlCEMlHdm
	6FcmChNXMixUpR3mYsTe/TVPOxtYxDX9MKUJz/6dioUeAj7+9CPrtFlJ5TSFYw==
Date: Thu, 6 Nov 2025 20:15:49 +0100
From: Pavel Machek <pavel@denx.de>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 6.1.y-cip 00/25] Add RZ/G3E GBETH support
Message-ID: <aQzz5f6AoiW5jKPt@duo.ucw.cz>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N7gIkLgOvpFIfzRX"
Content-Disposition: inline
In-Reply-To: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 19:16:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20464


--N7gIkLgOvpFIfzRX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add RZ/G3E GBETH support to cip-6.1. While at it, also backport RZ/V2N Pi=
nctrl and
> OEN dependencies.

Thank you, applied.

> Lad Prabhakar (12):
>   soc: renesas: Add config option for RZ/V2N (R9A09G056) SoC

I dropped this one, as discussed.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--N7gIkLgOvpFIfzRX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQzz5QAKCRAw5/Bqldv6
8hxLAJ4qVnIC1kN9mEGs1kQsq5A4vM7yZgCgrMTHc/ZyjNNn2W+NjLHPI/OReqg=
=j5Oc
-----END PGP SIGNATURE-----

--N7gIkLgOvpFIfzRX--

