Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8384D167F7
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 09:59:06 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7079.1767952745999005913
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 01:59:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=P4vdmknk;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9790F10A05C;
	Fri,  9 Jan 2026 10:59:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767952743;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qh8La9ec/dFpCl435l4Q0DJOyOwRo2etqWfw0UfZ08s=;
	b=P4vdmknkYDW9P9K+a1zLYNo64c/k9x+C0SQwt8d+gbf7BIxN/WH6jryzjCJD0alAjcqbjn
	ZHsdtx1ScHrPBmYRchGu7amRrIeGomRMgCaRL0g5V6Y/vCKj9BViWSNUngF1Iuh2fEQT1Y
	nuQySCcFQqVcEJ14PXlbcFJlKzRq60fI9UttNSPBoNcvX07AbD6X5SjVIqal9KS5wAEwqg
	LaEIoJ8MgBExMk9XCSpcKwLYE6Rtx2zHnv1gRyU68XD68pF0Lnu9EWBO0terMDzWRMAHKO
	oEntmcdbAr6sflOZf9KpB+dmXgvr/3OFS23Y0z7h80DHNk7wSoMuRx06cLTqoQ==
Date: Fri, 9 Jan 2026 10:58:58 +0100
From: Pavel Machek <pavel@nabladev.com>
To: tobias.schaffner@siemens.com
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Jan Altenberg <jan.altenberg@osadl.org>
Subject: Re: [cip-dev] preempt_rt on BeagleV-Fire
Message-ID: <aWDRYgwxThmOyGPr@duo.ucw.cz>
References: <36dd7fca-98e9-49ab-8dca-14a3997d0c5f@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xoAVZb08zxHnCwSK"
Content-Disposition: inline
In-Reply-To: <36dd7fca-98e9-49ab-8dca-14a3997d0c5f@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 09:59:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21493


--xoAVZb08zxHnCwSK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> has anyone already tested preempt_rt on the BeagleV-Fire?
>=20
> OSADL has evaluated preempt_rt on both the PolarFire Icicle Kit
> (MPFS250T) and the PolarFire Discovery Kit (MPFS095T) and has reported
> rather problematic latency results so far[1].
>=20
> Since the BeagleV-Fire is also based on a PolarFire SoC (MPFS025T), I
> suspect we might run into similar issues. Any experiences, measurements,
> or insights would be greatly appreciated.

Those OSADL results actually look good to me :-).

Ok, so let me explain. BeagleV-Fire seems to have slow CPUs. Like
"Nokia N900" slow. That's TI OMAP 3430 SoC, 600 MHz ARM Cortex-A8 CPU
=66rom 2010 or so.

It is certainly less than 10% of speed of Core i9-9900K, and that one
reaches 100usec...

https://www.osadl.org/Latency-plot-of-system-in-rack-0-slot.qa-latencyplot-=
r0s5.0.html?latencies=3D&showno=3D&shadow=3D1&slider=3D360

=2E..so 350usec is actually not that bad, AFAICT.

Not sure what our requirements are, sometimes people put the
time-critical stuff into FPGA.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--xoAVZb08zxHnCwSK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWDRYgAKCRAw5/Bqldv6
8scmAJ9eVED22EAyDQYvDUTxeziGteIK8QCfe0ivS4h2wlbBmLvVqrk+ByHrpg0=
=iET3
-----END PGP SIGNATURE-----

--xoAVZb08zxHnCwSK--

