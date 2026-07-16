Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABFDC4450A
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 21:17:43 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.485.1784236660187732564
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2026 14:17:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=DBM4Triy;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43B1F119E3E;
	Thu, 16 Jul 2026 23:17:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784236657; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=rPJP/MLQw3ip8GvNGEULO7Ga2m6abkNuTTImr0WsOg0=;
	b=DBM4TriyZWsBGokr/9nuy+vI4lC6Uh3beX43a/UATUomIkJhCJkfqZrpoP5d+gh/SAVqFe
	nANAoMNr/YZ/q9jUxwIuJE0QSgzSjEa4R3kCiHSxb4T0PpnhyZ6gRdzooImolEzvfVEDFR
	SxpF+3WFdmHBggq31Qs3hbITwf87A/0bUcEMsNeQ7xcsmRfsOiCUHAYM7ARqTX+ALhxxMe
	Tnw5HXyRvmoiqKhRkANXGYePBnk0jRa6eBkn5EtFMXTrcvGsQepVJwmQsiABBOiGcgOLKD
	Jkde+9CLxH0yFDvPd0EUET8xxpfxgA4mtziBhMqRBJMM4URlUpDxlomLMkwpTQ==
Date: Thu, 16 Jul 2026 23:17:34 +0200
From: Pavel Machek <pavel@nabladev.com>
To: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
Subject: -stable testing failing: out of ephermal space?
Message-ID: <allKbnDSqXCS3vZ0@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iWk7rT0zE+U5DBh0"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 21:17:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23625


--iWk7rT0zE+U5DBh0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New -stable review cycle started, and I see a bit too much red in the
gitlab:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/2682279698

I clicked into some results, and it complained about out of space, or
`subj`.

I hit retry on 6.12, but I'm not sure it is going to help this time.

Best regards,
								Pavel

--iWk7rT0zE+U5DBh0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCallKbgAKCRAw5/Bqldv6
8hl4AJ9Pl6pgtaGzrM/9K/VqTDU2OWVlswCgnOO+C4nOMNkPxaeiG6XJ7YPf+C8=
=iiTg
-----END PGP SIGNATURE-----

--iWk7rT0zE+U5DBh0--

