Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DD9D41D74
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 11:58:54 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46945.1765799927007103663
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 03:58:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ucw.cz header.s=gen1 header.b=gNesDvea;
 spf=pass (domain: ucw.cz, ip: 46.255.230.98, mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 687461C01C1; Mon, 15 Dec 2025 12:58:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1765799924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9KvOpeOaMQpN87CqT8chPXCiglje2vznMokAUvrhU4s=;
	b=gNesDveaFhYlMhadzTYH8dK9tRBxb2gT0va84E7tM4/ELrBMAti39VBiKfIPCR36wSHwn9
	mngPM5sdDuKS//UPQYLlUltUhjHLaUmR5+U1QpVovGJqm7bNwu7Hv5gOqKBB77N5eyk/Pp
	8sGuB5NUFApYb2shWhPKKh/Rtzz46CI=
Date: Mon, 15 Dec 2025 12:58:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Biju <biju.das.au@gmail.com>, nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/3] Add suspend/resume support for RZ/G3E
 ethernet
Message-ID: <aT/38yIAfK4C8t6x@duo.ucw.cz>
References: <20251214120122.3784-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gXWIZ0lJOlfN0oVj"
Content-Disposition: inline
In-Reply-To: <20251214120122.3784-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 11:58:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21050


--gXWIZ0lJOlfN0oVj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds support for suspend/resume support for RZ/G3E
> ethernet

This looks okay to me. I can apply it if it passes testing and there
are no other comments.

Best regards,
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--gXWIZ0lJOlfN0oVj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaT/38wAKCRAw5/Bqldv6
8rtDAJ9rhQC8g5aOfuRl9GEAERWRHHO8KwCgssVnlCknXXlfCQXT/fG8rbr8jUI=
=XPtD
-----END PGP SIGNATURE-----

--gXWIZ0lJOlfN0oVj--

