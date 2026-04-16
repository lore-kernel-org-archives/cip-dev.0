Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C446FF8A14E
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 21:08:15 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26331.1776373691499267754
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 14:08:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Loj7CNLs;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC20A1135ED;
	Thu, 16 Apr 2026 23:08:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776373688;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=xGapIQjo0cHfmteV0jj1LDswoXu5K2zcMY6rq4PL0Bg=;
	b=Loj7CNLsI+c7iUpilrkHpjNVP6qlIxyx7U9OnDiO2pmPE8LbURFLzZzVPVKKtxDgAns6kW
	0H8aJSif5R4EHOwFTtoyjXYquanfbULUxliYUFBjw8LT3UzAW+rDaVm5JH+N53Ezial4VR
	N3zwnDs1yrU8efO8JxKrs2QhiRMSvdzlBxbkZMkBATVySs8xbCdlJGAf1dJMn9WfuRYpuI
	dUzqcLk45M7LlEjN369bUl0D8y9qKYKrNEiuagp4DrY4rY97nljtubZTVMIccHTJiRH14h
	k6UIuTWr3tkNTPLKOkZ26IvvpyTkUrJ+wZyQQRYmxnqR5tJwUVt4tRxXtWf/BA==
Date: Thu, 16 Apr 2026 23:08:05 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Chris Brandt <chris.brandt@renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: Re: [PATCH 5.10.y-cip 05/10] clk: renesas: Use IS_ERR() for pointers
 that cannot be NULL
Message-ID: <aeFPtSgi-v1Km1uP@duo.ucw.cz>
References: <20260415181810.4073807-1-chris.brandt@renesas.com>
 <20260415181810.4073807-6-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mrh6WqiTpTuK3HGH"
Content-Disposition: inline
In-Reply-To: <20260415181810.4073807-6-chris.brandt@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 21:08:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22756


--Mrh6WqiTpTuK3HGH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> commit 6a636d203cc8d29ae73116bbca8b0ea2c7a90d7f upstream.
>=20
> The use of IS_ERR_OR_NULL() suggests that "clk" can be a NULL pointer.
> Hence smatch assumes so, and issues a "passing zero to 'PTR_ERR'"
> warning.
>=20
> At these checkpoints, "clk" always contains either a valid pointer, or
> an error pointer (none of the functions called return NULL pointers).
> Hence replace IS_ERR_OR_NULL() by IS_ERR().
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202408032025.ve2JMaoV-lkp@intel.com/
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Link:
> https://patch.msgid.link/81260328acb5c78e915ab04afad3901a31c16128.1758793=
709.git.geert+renesas@glider.be
[<-- here -->]
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Apparently, this one is different from upstream. That is okay, but
note saying [dropped this because that] would be welcome before your
signoff.

Thanks and best regards,
							Pavel

--Mrh6WqiTpTuK3HGH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaeFPtQAKCRAw5/Bqldv6
8p+TAJoD1RptjUsn19vu6zS7UZU8sjCKvACfSD1TzTPZwVAmKrXgCMjVFqNiVhQ=
=xeN2
-----END PGP SIGNATURE-----

--Mrh6WqiTpTuK3HGH--

