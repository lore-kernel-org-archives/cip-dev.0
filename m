Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844EFCF58C9
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 19:17:55 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15325.1763579864727705159
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Nov 2025 11:17:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=AX5evvI7;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00D4D118689E3;
	Wed, 19 Nov 2025 20:17:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763579861; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=k39kw++X6imI9988J2Bo57/UsEOnsx4aOg/TiL1cw2s=;
	b=AX5evvI7k7yPXFgZjTEQNGYFgxBtRgAULSomQD2bWYS6cKiV/m0swZr1HNW6wSQolmBrYJ
	PlYMtgOd0JmbJYZBV1R7PP+iCepCwgComoUBEBXm96nbsX21Batozi2oATOCVScqvu11nH
	XGzDSqK3AyJEaOp2eMsofB2/Vkta1xE5WR8Sx27R/5b3vz17rKwHuwV51MuKX9pQK9ofEH
	ehYhcTy5JBkB2xNkr0FWXjQR2s6YP7ipIAgkrCxdGyOo8P3B9ZNKepL7FymylPpfYMJisH
	Y1CC0CsyOMOcDAaA6l8eachXkcD23u1cGvnJCsstv7pjMo2FSyIPjZDBNYt6Og==
Date: Wed, 19 Nov 2025 20:17:36 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for review for 4.19-st10, 4.19-cip126
Message-ID: <aR4X0EMXkE9PNigR@duo.ucw.cz>
References: <2007204340.35590.1763377975626@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V/uY6a6kH9Aiila0"
Content-Disposition: inline
In-Reply-To: <2007204340.35590.1763377975626@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Nov 2025 19:17:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20627


--V/uY6a6kH9Aiila0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.19 kernel release. As al=
ways they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/c=
ip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>

Changes look good to me.=20

a > 047c1ac84d5e8 net: ravb: Ensure memory write completes before ringing T=
X doorbell
a > 1308591f9614f net/ip6_tunnel: Prevent perpetual tunnel growth
a > fe026547bb822 tracing: Fix race condition in kprobe initialization caus=
ing NULL pointer dereference
a > c9c5642eb5eed rtc: interface: Ensure alarm irq is enabled when UIE is e=
nabled

This one is ... interesting. The goto out in 4.19 just a nop, because
label is just below else. Which makes patch looks strange, but still
correct.

Probably not worth changing.

a > b25bf5615ed6f tpm_tis: Fix incorrect arguments in tpm_tis_probe_irq_sin=
gle
a > 69fb0056f8312 nfsd: nfserr_jukebox in nlm_fopen should lead to a retry
a > ee1eb7fcc4b27 scsi: mvsas: Fix use-after-free bugs in mvs_work_queue
a > 9255f4f0f7088 scsi: pm80xx: Fix array-index-out-of-of-bounds on rmmod
>

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--V/uY6a6kH9Aiila0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaR4X0AAKCRAw5/Bqldv6
8qo0AJ0ebaYLt7nVjoIIU1431HuvH93OjACgnkoIz0lYutYo/IiWCUFPrSYV8lw=
=yxfw
-----END PGP SIGNATURE-----

--V/uY6a6kH9Aiila0--

