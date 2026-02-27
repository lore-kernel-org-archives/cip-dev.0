Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE56FD7F8F
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 10:20:10 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.92811.1772187596299261833
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Feb 2026 02:19:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=TumrBn8x;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE551103DD1;
	Fri, 27 Feb 2026 11:19:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772187594;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dWrlYEPa4UkJ0TND+C13Wacv6fQup38UCYkHQtd5Qlw=;
	b=TumrBn8xWoh97PhGvnVI964NJosIchi0OJsXtCoGv08N0GuPXmDaH5mUGNI1M2dBfKYwrv
	AAtZjKf+l+AhH3KWJDBAcXKNO5hFyH0FJnthrSkdn7aUetZmOz+9TBra35nu8DaaoHVxNc
	rELurqBDRcWteZaiJ0PSJe2TVYN6886co8jVc8r8VINIYFZehZSxNeE3cc0GD5fAZm2ouf
	dsbcR5GZbmRZuViG5eHaoHWY0c7ODnjzgkcb/M6vSZs+MWeSO0RMtQyEa/2te24WmRP+WF
	XtGcG2mt1wNJ+P4FeriiHKzAme7E6nQ/+/lQnb5NzRQVFIkfpNrqXzEhiULouw==
Date: Fri, 27 Feb 2026 11:19:49 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 00/24] Add RZ/V2H display support
Message-ID: <aaFvxbyk6igbre3v@duo.ucw.cz>
References: <20260225121232.129678-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xv1SZcVe86c9h+kG"
Content-Disposition: inline
In-Reply-To: <20260225121232.129678-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Feb 2026 10:20:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22028


--Xv1SZcVe86c9h+kG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds display support for the Renesas RZ/V2H SoC and EVK board.
>=20
> All patches were cherry-picked from mainline kernel.

Similar to 6.1 version, this looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--Xv1SZcVe86c9h+kG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaaFvxQAKCRAw5/Bqldv6
8slzAKCym9TKLJk2eRY2kLRZYtCCZRmuWgCffD9aTSCtbQswx38IxHB+VW9Yz7Q=
=/Nzd
-----END PGP SIGNATURE-----

--Xv1SZcVe86c9h+kG--

