Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F22E9A74E
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 09:37:45 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16060.1774345063825451707
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 02:37:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=gjw9YvsW;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 397AD1121A3;
	Tue, 24 Mar 2026 10:37:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774345062;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=l+b2Z95AImgYShkHpEapjXouk6zrStWOSldPwknGvT0=;
	b=gjw9YvsW48NFhDymmlfPV5DPBm8muo8agXZ3gf6LycKt72A2TCdDfaScP4DcN/bXwgVWS6
	kDRK/G0FPwAAE1ZNqHoQgG8fkE/W+bu31NTVjU0k0dm+/1PIZ3EMIHugio0nFGfl7SRE+U
	uyck84PdarJRNcM7KlMqtSJia0izzHzZT3suBfvEDNjw2XPYb2dMLv9+ebljtLzacsAKG2
	NDRzHSOhsc5oB/SjIcgda55XCVsfK6L+TnGKildmisfuMTWPeygGlzrLmHmlX0nPOVt6LR
	IbQiJmkS7XKL49OubWH50wSU9recjyyUKmU/26QKI8Qv0vRwIT/g4PxjheYpwQ==
Date: Tue, 24 Mar 2026 10:37:39 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 12/28] reset: make shared pulsed reset
 controls re-triggerable
Message-ID: <acJbYxKGAB4lxGQr@duo.ucw.cz>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
 <20260311110357.1938200-13-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UE2PcQBMIlEZSff3"
Content-Disposition: inline
In-Reply-To: <20260311110357.1938200-13-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 09:37:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22545


--UE2PcQBMIlEZSff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 662867435fbe..4d1cd09096f5 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -325,6 +358,46 @@ int reset_control_reset(struct reset_control *rstc)
>  }
>  EXPORT_SYMBOL_GPL(reset_control_reset);
> =20
> +/**
> + * reset_control_rearm - allow shared reset line to be re-triggered"

O guess " should be deleted here.

Thanks and best regards,
									Pavel

--UE2PcQBMIlEZSff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCacJbYwAKCRAw5/Bqldv6
8lYqAJ0f52ELX8bEeNDA+lq5bl6xbI9KzgCfY7qnKClDaZQgrbrI2V8yYBW6/DY=
=eaB5
-----END PGP SIGNATURE-----

--UE2PcQBMIlEZSff3--

