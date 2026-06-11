Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7307CD98C7
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 09:26:34 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41404.1781169985136144426
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 02:26:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=h2pFL+Ps;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB94D1000C9;
	Thu, 11 Jun 2026 11:26:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1781169982;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=AYYom6wfNBzruus6FozlnEu+t7VWKdCKuQ3ITMio9mk=;
	b=h2pFL+Psug63lwgAwKQhjamLcKdccpdy65Vr8MN/Xyle0IM3+VSI+6r0KM6I/ftKlWOt3W
	E+Z+6l/nxcC2CmgCDtmhqsLqQ+/S1mohN9ReiX81bGY7PosFP1rht3wP+hp3DLKnc6Sk7X
	JG/auJhAjMibNd0dxC8MKg3tWRemIW4Pv39L7AZscgyNp2BGWxJeoBewsDGEVGySySTSqJ
	tIcWu5qD1cddtE6s8eDk9NYHWUA6R+tsM3LVQt9CQ8FeWVszB/9kZ6SyTa5ZdDi76nMayK
	IvlGy92+ZhnUsR/NdzdwdNOteIZ7AHWSV2my8lxoauBvWNul0Bf0GiEVufXj0w==
Date: Thu, 11 Jun 2026 11:26:17 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
Message-ID: <aip_OTMSZ_HVvzmv@duo.ucw.cz>
References: <20260610194849.2502517-1-claudiu.beznea@kernel.org>
 <TY7PR01MB1481870E0F531E41AE63C8462CD1B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <e7d3fbb7-4b06-4e7d-b0b4-323534343f31@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/V1+VGuc7i0ByDMI"
Content-Disposition: inline
In-Reply-To: <e7d3fbb7-4b06-4e7d-b0b4-323534343f31@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 09:26:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23061


--/V1+VGuc7i0ByDMI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Thanks for your patch.
> > I reviewed this and other series, these seems to be fine.
> > I can apply this if tests are OK and there are no other comments.
> >    Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> >=20
> > BTW, it seems your patches hasn't been posted to cip-dev ML yet. (Maybe=
 because the email address is at kernel.org?)
> > Could you check it?
>=20
> It may be, it's the first time I'm using this kernel.org email to send
> patches to cip-dev. Could you please let me know where should I check?
>=20
> I can re-post using the previously good email address. Would you like me =
to
> proceed like this?

Yes, please. Uli and others should see it, too, before it is applied.

Best regards,
								Pavel

--/V1+VGuc7i0ByDMI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaip/OQAKCRAw5/Bqldv6
8k0SAJ0eI464c7/K7TNc/znayQOIYXpryACfe78uY/qtUDGVKVKUqF9m6qS1Nzk=
=+6h+
-----END PGP SIGNATURE-----

--/V1+VGuc7i0ByDMI--

