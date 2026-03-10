Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90F6FCA17C
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 10:16:00 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36694.1773137756221554474
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Mar 2026 03:15:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=LLoS5YWM;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6C5F9110E54;
	Tue, 10 Mar 2026 11:15:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773137753;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=lRma36wSNh3aOFAcBg4ZRkb4ii5WpdnWtwwZyVmTcKE=;
	b=LLoS5YWMQuX/brrBK2Rd8JJCQ1KeXy8ICEOop1RcJ/gqIIk32Kwl8bCOE4OeYuVmon7egB
	9HQniUGxIxB0b2tO78rThRdT0B3sad810cElS3KFzveFHoTvD+3P57OETNUGfdBsAtHxnD
	g5qitBch8tsKsPyVWgmSVjvHxCVGpofEt03Obf5PfHxpr2VrUtCrCsJJVWq8XF275E4hgj
	azLWHdkyLCyTTw91oiElsB9c5mQiup04nhgF828kFbK1eQCh19lXcNX4GAx8wcO/kVpX0W
	NjEhjMKVhxHYg9eF5cvuKiDrFF4WGDZ4mZybCJO9GlRbaRU+62DztpcOvrM4FA==
Date: Tue, 10 Mar 2026 11:15:49 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st14, 4.19-cip130
Message-ID: <aa/vVeYwR6tFHnqW@duo.ucw.cz>
References: <1176625679.56445.1773052163068@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xAGNz4VugQ7mqFTP"
Content-Disposition: inline
In-Reply-To: <1176625679.56445.1773052163068@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 10:16:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22226


--xAGNz4VugQ7mqFTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.19 kernel release. As al=
ways they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/c=
ip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>=20
> ae59d713843f7 f2fs: fix out-of-bounds access in sysfs attribute read/write
> 6df6a5fb43fb7 scsi: qla2xxx: Free sp in error path to fix system crash
> ^ note that this patch is incomplete and fixed up by fd6c9803c6324 ("scsi=
: qla2xxx: Validate sp before freeing associated memory")
>=20

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel

--xAGNz4VugQ7mqFTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaa/vVQAKCRAw5/Bqldv6
8lD7AJ9r6hkriu9lEqydlVc4zF22CBQ8FwCeKpspvXlBQ09O60ImgiBrMbzVT7U=
=c+hK
-----END PGP SIGNATURE-----

--xAGNz4VugQ7mqFTP--

