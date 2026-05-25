Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0012CD5BBF
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 09:52:53 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12859.1779702771000350520
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 May 2026 02:52:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=M5hQMdXf;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 372BA112618;
	Mon, 25 May 2026 11:52:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779702768;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=cQpeWz/oJ5DOVyGHML3oBCEDVCPvWLylyPJxFJ64h/w=;
	b=M5hQMdXff7EC9vyRmnwCuktShAcCcexo/rXSfbIraC+KTben6RTqiA2Al7aJdVYp7CBLLB
	5uYnAT1k/GijVYWkFj9hY49WoEvVfehcwwpS9Xwm5AOVQN/M3481P9Ad+zkfZsEXfQoPPJ
	l0Kk2511RPbdIWh628+iyWG0KauMA57sewKUTyLfhBB4N3HHzggpMKb5uG6FGGZdiFyTGG
	YvqNRDKK9hoD+K8AUWDfI23Q+DsH24dv9InUwX1Niae5U14ciF3dlk5LwwAUQOEpp2ZULY
	YGQAbGLug4kDnPLKS20pKhDuW22zKeqlrfgoyGkdTxAowwIHq6vT7YF8OhJVXg==
Date: Mon, 25 May 2026 11:52:44 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st17, 4.19-cip133
Message-ID: <ahQb7MAc-usvN_Yc@duo.ucw.cz>
References: <516262162.225768.1779356981051@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vD0FRvWxKTtydobT"
Content-Disposition: inline
In-Reply-To: <516262162.225768.1779356981051@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 May 2026 09:52:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23005


--vD0FRvWxKTtydobT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> Here are the manual backports for the upcoming 4.19 kernel release. As al=
ways they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/c=
ip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>=20
a just a hw bug workaround > b7885f23ff4c9 x86/CPU/AMD: Prevent improper is=
olation of shared resources in Zen2's op cache
a just a preparation > da51b237e7bbd x86/CPU/AMD: Add X86_FEATURE_ZEN1
a just a preparation > e49d8098895b4 x86/CPU/AMD: Rename init_amd_zn() to i=
nit_amd_zen_common()
a just a preparation > f7c75253044df x86/CPU/AMD: Add ZenX generations flags
a > 874e7cb1436fc ptrace: slightly saner 'get_dumpable()' logic
>=20

Looks good to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
								Pavel

--vD0FRvWxKTtydobT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCahQb7AAKCRAw5/Bqldv6
8ieGAKC2nvZ7TWzVVGnHyp7/RYcqgXM58wCgg5E1pmgYa6zb5xDblUxhZ3rzgZ4=
=nZvy
-----END PGP SIGNATURE-----

--vD0FRvWxKTtydobT--

