Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C72CCF9E3
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 12:55:32 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16917.1762260929305352971
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Nov 2025 04:55:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=GAiJsi/e;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5930310398810;
	Tue,  4 Nov 2025 13:55:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762260927; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=rD5blrriWeEXbo3PrFP1W7SMhcQ5j01P1jBLCg1AGfQ=;
	b=GAiJsi/eDEwbZSEJr4tAeD7ufWcDqv6QEJjLWJVWiG7m7c88MJJnlcfy9qeXfirBkFPqNN
	BYm2cCJlSB2BPNRSIIsKqAML2/R9uexOm9Q4xaNEsbuIks0behXQdUwbRVdQlFAqdZXK/s
	Txn+FQ6+s74GWXgHHnR7RE50WihaySc2eYYof3eVwTQd0lwdB7eQ2HuYvf2hXaZFLacnnE
	2D6x1WrafjVMoXjNcYMMuI20rTUy9zgfRkzSpQ3SEhIVvkyqQtQUhNkCBXYXGZqKlVsyb1
	xlBlLKKocmjFnmqroEc4nnHaPJMlZqZUpqVgndhaLf+/Kqlc+mchZ4g/zl/cDg==
Date: Tue, 4 Nov 2025 13:55:23 +0100
From: Pavel Machek <pavel@denx.de>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 6.1.y-cip 12/25] pinctrl: renesas: rzg2l: Fix OEN resume
Message-ID: <aQn3uxHX0ebCjGta@duo.ucw.cz>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
 <20251103113608.36240-13-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vMPFY0bmooJkl3uc"
Content-Disposition: inline
In-Reply-To: <20251103113608.36240-13-john.madieu.xa@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Nov 2025 12:55:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20351


--vMPFY0bmooJkl3uc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> [ Upstream commit 30247fc3254a4502465ab809d49e2167ace5a6f2 ]
>=20
> Writing to the PFC_OEN register is controlled by the write protect
> register (PWPR).  Currently the OEN register write in resume() is done
> without enabling write access in PWPR leading to incorrect
> operation.

> @@ -3150,7 +3152,16 @@ static int rzg2l_pinctrl_resume_noirq(struct devic=
e *dev)
>  	}
> =20
>  	writeb(cache->qspi, pctrl->base + QSPI);
> +	if (pctrl->data->hwcfg->oen_pwpr_lock) {
> +		spin_lock_irqsave(&pctrl->lock, flags);
> +		pwpr =3D readb(pctrl->base + regs->pwpr);
> +		writeb(pwpr | PWPR_REGWE_B, pctrl->base + regs->pwpr);
> +	}
>  	writeb(cache->oen, pctrl->base + pctrl->data->hwcfg->regs.oen);
> +	if (pctrl->data->hwcfg->oen_pwpr_lock) {
> +		writeb(pwpr & ~PWPR_REGWE_B, pctrl->base + regs->pwpr);
> +		spin_unlock_irqrestore(&pctrl->lock, flags);
> +	}
>  	for (u8 i =3D 0; i < 2; i++) {
>  		if (regs->sd_ch)
>  			writeb(cache->sd_ch[i], pctrl->base +
>  	SD_CH(regs->sd_ch, i));

This is "interesting" piece of code (just take the spinlock always?),
plus we already have similar code in rzg2l_write_oen, could it be
shared?

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vMPFY0bmooJkl3uc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQn3uwAKCRAw5/Bqldv6
8pBPAJ0XhIzDHAHFPgF9eMUXMKNkejxnDQCbBZsWUWvtfANeTTefmeuaweeuOQ0=
=CIwc
-----END PGP SIGNATURE-----

--vMPFY0bmooJkl3uc--

