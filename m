Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55259D0D171
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 22:02:09 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18256.1767823325922755898
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 14:02:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=TEJwW29B;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5507C10D56C;
	Wed,  7 Jan 2026 23:02:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767823323;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4LKtaCOyKv3xnZGzWPR1yMrnZYDBtwXqKkVk7667vtk=;
	b=TEJwW29BKwJyI7XRs6GjQ+YjWj5acokevBvi3YdzQY3WhmlkKIp24SwSyL4YPtSHAYJxIn
	bUB9CFxI3tobmtYSuTTbNvazaa+Fd4UCESx19Bqk3me6tdKwNH268Jen3QFZ0x5Fe/Z2vx
	W8jyMYVm7SlEkzmi/XYrzFTzrWA3wxg96cwYZecz7HcbLkFkvZ2+hup1MPW/LLUUq0J8y6
	AHS+t2sdNooYy3Wy7+kTkhgrNZ629R/mzOQI8j75K2NnL1MASCx1YIFuOPqMMbtsyhQ0TL
	BtS6/dDQFp5tGh+NrApC5hyNWLa1oppHnDQqFq+ot0u1Po+7cvn2p3hUWQdbXQ==
Date: Wed, 7 Jan 2026 23:01:58 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip v2 0/6] Add gpio keys/sleep button support for
 RZ/G3E
Message-ID: <aV7X1jwpuT/9ELv7@duo.ucw.cz>
References: <20260106104151.88020-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yptBRfhCgjKi6+3X"
Content-Disposition: inline
In-Reply-To: <20260106104151.88020-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 22:02:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21421


--yptBRfhCgjKi6+3X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add gpio keys support for waking up from s2idle and sleep button support
> for entering to STR. Wakeup of STR is by pressing and holding power
> button. All the patches in this series are cherry-picked from mainline.

Thank you, applied and pushed out.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--yptBRfhCgjKi6+3X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaV7X1gAKCRAw5/Bqldv6
8gQ9AJ9dqg54/U1F2+K2VDnsIbcPbuU/LACeIfSnHpAPJngOHxTxowaDy96AqFo=
=bzTA
-----END PGP SIGNATURE-----

--yptBRfhCgjKi6+3X--

