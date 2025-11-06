Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDCBCCFA05
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 19:23:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6180.1762457004184714176
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 11:23:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=bWuy4COR;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 409981003CE29;
	Thu,  6 Nov 2025 20:23:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762457002; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=GMpHux49Fc2HNSWUyObU62JZO+2RsD8UExdRHpI8ITA=;
	b=bWuy4CORwIMXevlJLKvRtMUGnPcbR0ksaLYHXacWiI9smoeGj68w+Yht4ymi41y+hp7Tpf
	+24XfJckHV0WQ9YHDXp/uxPjArrFQOcb9AlzAXARbfYis6TVGKNV8QhghAi0H+PVPDF8Zh
	FPvLCgwF5mW4PSkIGyM4nG/60h64ZqWhqY+G5ReXMRD7Z6E//a2j2SnEjXM36oTaUR9UvG
	91YVtmNk+95pke3IIn3B3Upli3qPnIqmRN/6ThsRgPk0TN2LDzvwU7w+5vbdJT5NENtAvk
	2D+nkgbJ8x7aSuUJG0/nisBxJ7xODy9Sdq/420Q3luCvkxmiI9MVtSPQtFfsbg==
Date: Thu, 6 Nov 2025 20:23:18 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 00/22] RZ/{G2L, G2LC, G2UL, G3S, Five, V2L}:
 Backport MSTOP support
Message-ID: <aQz1pgHaEQNgfdKa@duo.ucw.cz>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yYCOmnlgXL7/mXM0"
Content-Disposition: inline
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 19:23:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20465


--yYCOmnlgXL7/mXM0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the MSTOP (Module Stop) support for the Renesas
> RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/G3S, RZ/Five, RZ/V2L SoCs.
>=20
> The purpose of MSTOP is to reduce power consumption by stopping
> unnecessary module's functions.
>=20
> If any master accesses a module that has the clock stopped and the
> MSTOP bit set, a bus error will occur.
>=20
> Due to this, to avoid CPU generating synchronous aborts, changes
> to PM domain specific code were needed. The changes backported in
> this series were adjusted to be executed only for the above
> mentioned Renesas SoCs.
>=20
> Please share your thoughts on this approach.

This is a bit more intrusive than I'd like. dev_pm_domain_detach()
changes API and now we have to modify unrelated drivers to fix it up.

How much power does it save? Do we really need this? Could it be done
without changing semantics of existing functions?

>   driver core: platform: Drop dev_pm_domain_detach() call
>   mmc: sdio: Drop dev_pm_domain_detach() call
>   spi: Drop dev_pm_domain_detach() call
>   rpmsg: core: Drop dev_pm_domain_detach() call
>   soundwire: bus: Drop dev_pm_domain_detach() call
>   serdev: Drop dev_pm_domain_detach() call
>   i2c: core: Drop dev_pm_domain_detach() call

Thanks and best regards,

								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yYCOmnlgXL7/mXM0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQz1pgAKCRAw5/Bqldv6
8iIzAKCQK7WV5TVclwhNgM9loAEDABWz5ACgrQdJZXBl7BYAOStNc14K9uRLFII=
=WLgT
-----END PGP SIGNATURE-----

--yYCOmnlgXL7/mXM0--

