Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF9BE77187
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 15:52:56 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.108698.1734537165836490577
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 07:52:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=b1eK382Q;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BC90104811D1;
	Wed, 18 Dec 2024 16:52:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734537163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gKE0F+7IHFruhbDtMB4U4BijFlp8pCkDcB6Y9KjIork=;
	b=b1eK382QFw/5rjqh4ZTTNQyPGDkYw7fbm/U5Js7eTb+PVX5jT3BTXc1lF5e8Stly23jfdn
	5PoQ7VqdHmP6Ox92SBNBieWlJcCDY38Vm24BGJcHOF9yFnQmCiX2fgyMycqXAEOGebND2L
	YNv56RoNPMXsBh8KMOIE3JR6YpcFTdJPsCfrCkgJf20s0lgGDd0W2CV/xaJmsbq9sHC3vB
	u3F+aQZLwiyZVBLep86ryhmnM38eFweALm43HjngP4m61YRJPv4XbZaSM/lmHF/i3P9f44
	vcKr03JQi+tKvIVsO590oTahSmLuqVUPnp49+w4nKXuZ4PAD6hM0fyqlChUAxg==
Date: Wed, 18 Dec 2024 16:52:39 +0100
From: Pavel Machek <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix
 FOUTPOSTDIV clk
Message-ID: <Z2Lvx+d6NOE0VHRx@duo.ucw.cz>
References: <181032168C715C4E.8579@lists.cip-project.org>
 <OSZPR01MB701902FE30A554F6C65B52F7AA052@OSZPR01MB7019.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3VM4HRZwW35TC0vr"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB701902FE30A554F6C65B52F7AA052@OSZPR01MB7019.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 15:52:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17467


--3VM4HRZwW35TC0vr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > While computing foutpostdiv_rate, the value of params->pl5_fracin is
> > discarded, which results in the wrong refresh rate. Fix the formula for
> > computing foutpostdiv_rate.
> >=20
> > Fixes: 1561380ee72f ("clk: renesas: rzg2l: Add FOUTPOSTDIV clk support")
> > Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Link: https://lore.kernel.org/20241024134236.315289-1-
> > biju.das.jz@bp.renesas.com
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/clk/renesas/rzg2l-cpg.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> Gentle ping for review.

Again, sorry for the delay. Should we have similar patch for 6.1? I
can't seem to find that in my mailbox...

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3VM4HRZwW35TC0vr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ2LvxwAKCRAw5/Bqldv6
8lUMAJ98CcNimpUoLCVALI1tumWyegODnQCePozjHp7Ehw+K+B30hspIHNsfiTY=
=YdJt
-----END PGP SIGNATURE-----

--3VM4HRZwW35TC0vr--

