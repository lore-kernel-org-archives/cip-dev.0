Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442E0D5E144
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 12:01:15 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20655.1765886473378179011
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 04:01:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=gc9qlh83;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5478E106680B9;
	Tue, 16 Dec 2025 13:01:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1765886471; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=x8TQCZ0jv85QvZcj7Mnu3texWpVtjCDI3s+/XDzSdQw=;
	b=gc9qlh83SIqCDfrKh4Wvi7l/sujZhd2GdaBUft5bN+hSz6AgvaLuLcZRPuwfNXZeM7NREi
	KcTj2IgtDCn3U4nYL8un3/3elDkiDDCmRJdtm0Tm6UX+/22GxnKVnu4jbzxAwvXPy2flBd
	bq2Ju7vf5Y7auDTCJbXqY7RvocQ+taPx8XtFWh+78W/Y/Q8wxBAO8vZzfT1EdI5dRoovGR
	nORe0TuuGw941kd9PDgAJt+GeXEiBtBIEVMl1lflRb6x7TKdKNA8DVFew0IVqS3kFqYBYO
	vZFjDDiFFLQ6XywoxoqBKAyYDKr3/KRC2Ys09DyVScQST70O+t19Z48E0A+Qgw==
Date: Tue, 16 Dec 2025 13:01:09 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 0/3] mmc: renesas_sdhi: Add 64-bit polling
 support
Message-ID: <aUFKBR8JII4rHjNg@duo.ucw.cz>
References: <20251214121627.4656-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kJaA5PPx9SI08V2Q"
Content-Disposition: inline
In-Reply-To: <20251214121627.4656-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 12:01:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21083


--kJaA5PPx9SI08V2Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> As per the RZ/{G2L,G3E} HW manual SD_BUF0 can be accessed by 16/32/64
> bits. Most of the data transfer in SD/SDIO/eMMC mode is more than 8 bytes.
> During testing it is found that, if the DMA buffer is not aligned to 128
> bit it fallback to PIO mode. In such cases, 64-bit access is much more
> efficient than the current 16-bit.

Thank you, applied.

Best regards,
     								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--kJaA5PPx9SI08V2Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaUFKBQAKCRAw5/Bqldv6
8kSdAKCrEaDc7he9oBGkwrsBPoqGzPCahQCgw5rqeqtPlEEFSuirwkpCL9pRiVk=
=q57z
-----END PGP SIGNATURE-----

--kJaA5PPx9SI08V2Q--

