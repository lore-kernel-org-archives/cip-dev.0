Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006C0D5CCA8
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 10:25:24 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19172.1765880720825194243
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 02:25:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=UrrbbLVv;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 398D5106680B9;
	Tue, 16 Dec 2025 11:25:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1765880718; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=5Hf4lBjCcU4zjKT+kxVdWK3mp3RvOQE5tBH+iAu4z+M=;
	b=UrrbbLVvV64aN6Wr+8w0qY8awed1c3tlbmbWSBxKCQ/YZ+Z7O+BBFJD/p+UGEmd17m5RMQ
	lwVLG3EpPYAwkhXINGslO3Vm84wRHn1MngcLMdDHi6fa98gpt+yogAoaTePN+LW9AO10CU
	cw7Q/GZ+cng9KZJV6CVMYNTGc4/Lgqo/KfLXnLQTfqIIyVtsVcEFraLNJRtGVizpyOJd68
	AxmpYKqvzjVNqoSzLVB9g4DSUDXFA7l91RP2Pc2zfsgnXFWSFNHy17YAWqS2ut7+wc03JG
	mYGP6lF6AONkIkFP/5UWjo7TwEPkykBJnB+DqULClTVyKLtK8S/6rzg4eJYy1Q==
Date: Tue, 16 Dec 2025 11:25:13 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/3] Add 64-bit polling support
Message-ID: <aUEziZB2rbYEU3L1@duo.ucw.cz>
References: <20251215125316.137879-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F1vfFFpkNHwzG3je"
Content-Disposition: inline
In-Reply-To: <20251215125316.137879-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 10:25:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21081


--F1vfFFpkNHwzG3je
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> As per the RZ/{G2L,G3E} HW manual SD_BUF0 can be accessed by 16/32/64
> bits. Most of the data transfer in SD/SDIO/eMMC mode is more than 8 bytes.
> During testing it is found that, if the DMA buffer is not aligned to 128
> bit it fallback to PIO mode. In such cases, 64-bit access is much more
> efficient than the current 16-bit.

This looks okay to me. I can apply it if it passes testing and there
are no other comments.

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--F1vfFFpkNHwzG3je
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaUEziQAKCRAw5/Bqldv6
8iL+AJ9MBGQ/S5EnyPSxhqebqSQrCLcXYQCggUM6Mg+zOAA8n0TQcoVNIamSm+Q=
=ObNC
-----END PGP SIGNATURE-----

--F1vfFFpkNHwzG3je--

