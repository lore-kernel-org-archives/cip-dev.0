Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15856CDE03B
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 08:29:28 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13389.1763108962840447038
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 00:29:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=D71VtsQo;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D5F1011837A2A;
	Fri, 14 Nov 2025 09:29:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763108960; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=oOXGG8xbPTPz8Gw/hLB2lqUKVGkRJSCOWT7U1mp9oZM=;
	b=D71VtsQoT3f4YhqZyiXeUj2gN1eOb+y5gBdBc0j3Q0M6y/LUXq+VxnCKnj5qcxY9RQypU2
	Av/MIScI/iE/kRDKgWjyE+x15tzvYTym5RgyHgXsSgeSrvPWQCxTKBqMnG8FzMJqSSOIz5
	N5V8hN7rGqhU/ELNR9ypntFEmBwtO2cCyRxth/C3lo4Ok8fmUCNJFR/BrWtx44+eXrVGXr
	E/Gwpt10L5uICVcP+CNMxuzS5udvTEa5EhSh/pho1M0AL/vHyMf/Q1x0M5r79C4fVBBGTr
	uVXtrCL5KmTyWSrwk95ndcra1O3rfWmHD+DZ5xawb/7FmGOHn45ycKvL9BgZcQ==
Date: Fri, 14 Nov 2025 09:29:16 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com
Cc: cip-dev <cip-dev@lists.cip-project.org>, Ulrich Hecht <uli@fpond.eu>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] ARM: 8933/1: replace Sun/Solaris
 style flag on section directive (part II)
Message-ID: <aRboXLoabNR7ENsG@duo.ucw.cz>
References: <6b9feb19-856e-43a1-ab2b-38311130d71e@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WX2xeYf/+es4WneB"
Content-Disposition: inline
In-Reply-To: <6b9feb19-856e-43a1-ab2b-38311130d71e@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 08:29:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20535


--WX2xeYf/+es4WneB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> From: Nick Desaulniers <ndesaulniers@google.com>
>=20
> [ Upstream commit 790756c7e0229dedc83bf058ac69633045b1000e ]
>=20
> It looks like a section directive was using "Solaris style" to declare
> the section flags. Replace this with the GNU style so that Clang's
> integrated assembler can assemble this directive.
>=20
> The modified instances were identified via:
> $ ag \.section | grep #
>=20
> Link: https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_7.htm=
l#SEC119
> Link: https://github.com/ClangBuiltLinux/linux/issues/744
> Link: https://bugs.llvm.org/show_bug.cgi?id=3D43759
> Link: https://reviews.llvm.org/D69296
>=20
> Acked-by: Nicolas Pitre <nico@fluxnic.net>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Fangrui Song <maskray@google.com>
> Suggested-by: Jian Cai <jiancai@google.com>
> Suggested-by: Peter Smith <peter.smith@linaro.org>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> [Jan: add bits missing in part I (e47595d2e9fa) ]
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>=20
> Note that building with cip_merged_defconfig and gcc14 from trixie=20
> (which becomes possible with this patch) generates several warnings, and=
=20
> some might indicate backporting issues. Please check!

We have patch in 4.19, so we can take this, I guess.

Reviewed-by: Pavel Machek <pavel@denx.de>

Would it be possible to share the log with warnings?

Best regrads,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--WX2xeYf/+es4WneB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaRboXAAKCRAw5/Bqldv6
8kv3AKC2/Laz1bh+1U4Q9K2Tz+FW+t13ZgCeL6wF41rYasVwk8/etDWq0WdJF3o=
=U2K3
-----END PGP SIGNATURE-----

--WX2xeYf/+es4WneB--

