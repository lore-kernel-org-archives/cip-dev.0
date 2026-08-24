Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1210C5DF81
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 09:26:30 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12942.1787563587117522122
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2026 02:26:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=UXsVG6+S;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 541C1119AA2;
	Mon, 24 Aug 2026 11:26:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787563580;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ethKr03RtEyFflsXc4CYZJGUuWpoCr3GNXvThDSozTI=;
	b=UXsVG6+StedX4pTrImDQ+EdN8n/7B5ex7IsIrG3GdhBl99ZxOLSIpQmwZMnLtJdDsIQnlk
	YASJ4llfOd9zTWJHyQXIIbEc23aSOoN9tbNSgthMqHvY565jFrLDGHeNkUyZaXXGdnB47Y
	nB3UnuZegNv0l8hF4OkV0RKp29j4Vcy1NThfarkrIv4g6yl7C2WDg74wxcOIkgBe38C2Ti
	4/IKFhkcJJ1IOSE6EPqiRVC0yEQGjHFVk2F4I6iFrWPvZQxHUrNmEMNT+mkL4hox+k2wci
	1qwZ7SHpbcaKRyLHYHTt/Hfr/N4d1kv0fMSBTM4iZxBe4WAP3WeTrvLLRBX06w==
Date: Mon, 24 Aug 2026 11:26:17 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: pavel@nabladev.com, cosmin-gabriel.tanislav.xa@renesas.com,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/18] Add ICU support for RZ/T2H
 and RZ/N2H SoCs
Message-ID: <aowOOePmsSk1I0ph@duo.ucw.cz>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <aolZq2gonRLG4U4k@duo.ucw.cz>
 <TY7PR01MB148186ABF5271325B7E7E7AD9CDA02@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J0ynJrJrVQBq6sJC"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148186ABF5271325B7E7E7AD9CDA02@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Aug 2026 09:26:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23980


--J0ynJrJrVQBq6sJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch series adds support for the ICU block, including
> > > software-triggered interrupts and error interrupts, as found in the
> > > Renesas RZ/T2H and RZ/N2H SoCs.
> >=20
> > This looks okay to me.
> >=20
> > Reviewed-by: Pavel Machek <pavel@nabladev.com>
> >=20
> > I can apply the series if it passes testing and there are no other comm=
ents.
>=20
> I also reviewed this series, look good to me too.
> I applied with Pavel's reviewed-by tag.

Sorry, we were working on the same thing at the same time.

It passed my testing, and I pushed the resulting tree before checking
the emails.

Best regards,
									Pavel

--J0ynJrJrVQBq6sJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaowOOQAKCRAw5/Bqldv6
8mMpAJ9y3leAr9QtyU8Liw4kJurF37jfTgCaAkYcBYZM9LwYdQySByl41K9Ay3o=
=qY7D
-----END PGP SIGNATURE-----

--J0ynJrJrVQBq6sJC--

