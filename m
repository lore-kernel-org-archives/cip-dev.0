Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C263E73175
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 13:48:38 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52830.1770040113314820547
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 05:48:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=HNux2B4m;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F243010FB10;
	Mon,  2 Feb 2026 14:48:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1770040111;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=xTQojzu16dAA11QW+BNns+AyJlFq8g8fiG0xpWUgF/w=;
	b=HNux2B4mmdr7GZHKhMaprfuS031v8MN97h/obdp3Jv43TXTcf7evCCw2IINN1iCS7hLPpX
	dy4ald6OSdPpV51LR5HBtdyiH9iCX6NYvIGmRexR0af8t5k6c8yFDqHwhQY37hSVfNPhJx
	agpLFg5rtdpgkBS+yD/TY+lhkipR1gAgjiYj8ML695TSF9p5kitML568kzEGBCvuyBtRhJ
	bTaGkUPfdec4yz8rbBvpWkmLYagwnZ5uWB+hT04Qc47LPo2MfkVYdS+FrVzbbKS+lMXJBk
	dLlYLet9a2FJQ3ijk8n7CYWae1/ciondJYigjLyVLExtFHANxLQrDZ7QlQg3gw==
Date: Mon, 2 Feb 2026 14:48:29 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org,
	pavel@nabladev.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/11] Add RZ/V2H TSU support
Message-ID: <aYCrLSJwY8wE5ciJ@duo.ucw.cz>
References: <20260128132522.6902-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB148183B37BD1A587297164320CD9EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY7PR01MB14818DE9A3E9F0D4E49132C7FCD9AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="svooJy3P/QtvC0rl"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818DE9A3E9F0D4E49132C7FCD9AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 13:48:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21813


--svooJy3P/QtvC0rl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I reviewed this series, looks good to me.
> > I can applyt this patch if there are no other comments and no issues on=
 CI.
> >  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/229341=
5029
> >=20
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> >=20
> > Best regards,
> >   Nobuhiro
>=20
> Applied and pushed, thanks.

Thank you!

For the record, I reviewed this and 6.12 version, and had some minor
comments but nothing that should prevent merge.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--svooJy3P/QtvC0rl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaYCrLQAKCRAw5/Bqldv6
8r16AKCVa+6Rz5mq/7vG8N/kpwyvhvdUGgCfaMuvCDm3lJv7j0sejWVgxSbamvQ=
=ctiw
-----END PGP SIGNATURE-----

--svooJy3P/QtvC0rl--

