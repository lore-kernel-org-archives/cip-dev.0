Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF1FCFA76A
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 10:04:45 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8342.1763719482794735796
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Nov 2025 02:04:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=WNx6MA3W;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 595E41007854C;
	Fri, 21 Nov 2025 11:04:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763719480; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=7zuDjCTpwVuXSWIzAft+V7bgLrDo6d87amZX+0KFMM0=;
	b=WNx6MA3WmK80DYeXrNhG4sXn7j1YPioMG/xuWMJx4R0O2HlRPF+i/LF+bNuhvYBsPq0czf
	3oNZUNS8+n6KbfLUXy/dq80Y85Sqg37jFGl0C55QmSLMjO0ZY4RCIlnq/S++g/jI8wzViM
	nbUTc7+8OOYvyRzAqNQKANjCTaKtWQWyiFk9J4/2B74jsiIlWqyXkKksEewmZe45Sapad2
	UDDApWScT6cF0vjUXJFVoMwmL557QhrfCAAqo36YisRKQqvxN7vldLjPEI/8En+rTxAFgO
	9q0BBcVj9wEeQWEoWU3nXSkZbte/WJYM+1M57rc0agg2/vvu6rlJN7aOSi/kdg==
Date: Fri, 21 Nov 2025 11:04:34 +0100
From: Pavel Machek <pavel@denx.de>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/10] Add RZ/V2H USB2.0 support
Message-ID: <aSA5MgqyTTsWh4DV@duo.ucw.cz>
References: <20251120170357.18342-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DMzNLjKJx/+0ste2"
Content-Disposition: inline
In-Reply-To: <20251120170357.18342-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 10:04:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20677


--DMzNLjKJx/+0ste2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds USB2.0 support for the Renesas RZ/V2H SoC.
>=20
> Patches were cherry-picked from mainline kernel.

This looks okay to me, I can apply it if there are no other comments
and it passes testing.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--DMzNLjKJx/+0ste2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSA5MgAKCRAw5/Bqldv6
8oRkAKCfXelAiZAydXfs+BCB7wfraa3DsQCfQaz6j0SF//LWrkdgxGkgbXEPULQ=
=Qo4m
-----END PGP SIGNATURE-----

--DMzNLjKJx/+0ste2--

