Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1681DFF6E87
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 21:58:12 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.934.1773784681422033005
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 14:58:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=MGBlTpI+;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBBA510DD8D;
	Tue, 17 Mar 2026 22:57:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773784679;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ZFMpDK6fkd07rjrYK2LQ1JPo0435IVlS/y4Dw48yKyA=;
	b=MGBlTpI+sRLUYHWtKMD89ITOYHIxKR4Usr7aV5aUnMK9IjmgaUu9mHghVL3UPIDaRNBV/l
	xsB7NWmFw33ausj7VRWh525MO7vadl11nzK9ZsxgZ5Fx8OuDvXPOrEDFz+jtG/Xo8tJ7Il
	Q/rxnTzR2JCzDywaIt7T5yisyLAnY5D0/34pxnWqZU48IpH9rp4iDHPhSJPC9D98h6Wdl6
	I8WMzF9RDDKoRNGLYJb/YqaeJ4Lxjr5bcqaV+UTmZeRk8QyTcfhRBR2RDQ5yPj6avS1Ldf
	FmYfnaXJMfAVnIfjMahNcpZwLO0mIWISA8C4iiXTR4BTAcivMD5FBErNW7khlA==
Date: Tue, 17 Mar 2026 22:57:55 +0100
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/3] Add RZ/V2N DMAC support
Message-ID: <abnOY5qdgwtwSfZb@duo.ucw.cz>
References: <20260316143417.76612-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uVuCt+p7Nk5k9rt8"
Content-Disposition: inline
In-Reply-To: <20260316143417.76612-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 21:58:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22491


--uVuCt+p7Nk5k9rt8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds DMAC support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--uVuCt+p7Nk5k9rt8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabnOYwAKCRAw5/Bqldv6
8sTEAKCbGqc+PJTDVBAbFK7IOlkdX+XEnQCfWvx70gpLCl6+ygYx0SqrfTLppUA=
=Sy+0
-----END PGP SIGNATURE-----

--uVuCt+p7Nk5k9rt8--

