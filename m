Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF7DCCF9F8
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 12:33:40 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10363.1762518816456161677
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Nov 2025 04:33:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=GWQnySbK;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B9811003CE1D;
	Fri,  7 Nov 2025 13:33:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762518813; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=bEVIdIxG7oJvHyAf1zBlZAFoni04cUfbI1AgBOjfaTI=;
	b=GWQnySbKJlVcx2pQ+6G0Ii579f3GeN+BF1z24Cipgeefc//ByfqEvfgyuBPfTzDDJYkMyn
	nlC+x+gdhkf9pb88zGGZWI0LRqnx+6UEkL5FOEfVm1Foz+sS061cTekFxn/4Sz+rSZ/a1d
	G5tkAa4FA+QRtcl6Cx10Rz4Qz1T+M9jEUwuA2grmxK22kVBOUwzfsd85xoW/g8CHNuM+1H
	YpB26usZB8nKg5W284mu3ZfBvJywShoRdhfwdtYG326a5diIX7fsa7aJzpdnMymW5lTXfd
	JW2ga/nkJ7JaujKzJfVoIcUmZ9rWKAmpbl9/in4rR5fOhGIB9+xX5GePQHzXGA==
Date: Fri, 7 Nov 2025 13:33:29 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 0/9] Add RZ/V2H GBETH support
Message-ID: <aQ3nGSXdBz/hENrE@duo.ucw.cz>
References: <20251106104024.28947-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB14818E6DD3F60EA38F0D79E44CDC3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/kFPGYnQ7jtRoUbK"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818E6DD3F60EA38F0D79E44CDC3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Nov 2025 12:33:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20472


--/kFPGYnQ7jtRoUbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series adds GBETH support for the Renesas RZ/V2H SoC, to the
> > linux-6.12.y-cip kernel.

> I reviewed this series, looks good to me.
> I can apply this series, if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thank you, I added the reviewed-by tag and pushed the series.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/kFPGYnQ7jtRoUbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQ3nGQAKCRAw5/Bqldv6
8j2QAJ91yUVbVPOG4QStvbMu/u68XISCqQCcDoaDHUoXUre0oR5Nohw6E6HoBmo=
=t7K2
-----END PGP SIGNATURE-----

--/kFPGYnQ7jtRoUbK--

