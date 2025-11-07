Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A01CCFA05
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 09:15:19 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7508.1762506906353807113
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Nov 2025 01:15:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=djBFIjKw;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 756B9103D145E;
	Fri,  7 Nov 2025 10:15:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762506904; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=k8IwfdoHz5erUxDfwYWmqMYHcUzNRQ3dVSFAny4376E=;
	b=djBFIjKwFsYtr8KXRnS/A5sNsUvU/qgEBWRG1tqJXliVFkldFDEjHa9goGlyktabRaJOMF
	e7421biRObkTXkQQjj61ivkGBwlEV8WxwIubaj1FExrcG1MYfGZ58eo9/e1tM0Wdg+pf9t
	a2642e/cf+exksob0ilh7o1Vdp/+FDWdU5AhNWiBrGrDreEjX/gzVNm4eCqnBRtz1koDBE
	0OqITBJTLmqkKt5EqSJxQjr06R8FTL2RQq+Z9EStztt7cOSUrLMWVlADbLl3pcyKfR6S0B
	CIwR+h/0VtmKqVBoeQnMUTsz76ElF4UwpmiRLzKM20+TJxKef6tbx4YQZSTWjw==
Date: Fri, 7 Nov 2025 10:15:01 +0100
From: Pavel Machek <pavel@denx.de>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/9] Add RZ/V2H GBETH support
Message-ID: <aQ24lZpZu05Qt7Fc@duo.ucw.cz>
References: <20251106103738.28911-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Gwn/TwpW2iVQkpEr"
Content-Disposition: inline
In-Reply-To: <20251106103738.28911-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Nov 2025 09:15:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20468


--Gwn/TwpW2iVQkpEr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds GBETH support for the Renesas RZ/V2H SoC,
> to the linux-6.1.y-cip kernel.
>=20
> Patches were cherry-picked from mainline kernel.

This series looks ok to me. I can apply it if it passes testing and if
there are no other comments.

Reviewed-by: Pavel Machek <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Gwn/TwpW2iVQkpEr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQ24lQAKCRAw5/Bqldv6
8hQfAJ9RRpvQmC+st1bJ6YROzG2yadbY8gCfcgsOOeitA6MU8QJvoV2wyz5ZcIM=
=oEs2
-----END PGP SIGNATURE-----

--Gwn/TwpW2iVQkpEr--

