Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB75ED7B90
	for <webhook@archiver.kernel.org>; Tue, 14 Apr 2026 09:05:33 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14508.1776157532065646968
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Apr 2026 02:05:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=MrNCQEOn;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F24A51123B0;
	Tue, 14 Apr 2026 11:05:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776157529;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=XW83JIYNGdr1DbxH3pKWJ7fr23YFzT6lIvviPbSrVGw=;
	b=MrNCQEOnaW/aGQWpXD26qPEBG1LDp0Bjdcs1To7+CRLccsN2B78DDQ1lhHB7ilKhmSJtDq
	+4WNfywBIgygGCTEi7AA50cFWuDdA14MFMZ9BDG7T7sAB1wv+OAMqW/Z89pzKebU9xeIxC
	f+Hs0VyB7+YNxnVBdU7qbeTlhr45RIfSzcUbBui3UlQN03/vJAvpAApbxkgAgnDbGrVgjq
	BkWiNA7NvPqp5lCDawn2lhF40sdx6NGq2tG8xI1nC/yTkQrXl/p6A1AMkajN1kZaEgiuxn
	/nc7usXkedBmf/uXO9FYqA8NL+1byFHqRfA1SFEUIXIk90VS1WNkfNAZ5wcizw==
Date: Tue, 14 Apr 2026 11:05:26 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Chris Brandt <chris.brandt@renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: Re: [PATCH 6.12.y-cip 1/7] drm: renesas: rz-du: Add atomic_pre_enable
Message-ID: <ad4DVpSwzcEoXo0l@duo.ucw.cz>
References: <20260413171733.3088070-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lPY3qu2HugW3RZPQ"
Content-Disposition: inline
In-Reply-To: <20260413171733.3088070-1-chris.brandt@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Apr 2026 09:05:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22698


--lPY3qu2HugW3RZPQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

It seems I got this series twice. If there's any difference between
them, let me know.

I'd report on 0/7 series overview, but this did not come with series
overview :-(. It would be also useful to know why this series is need.

Best regards,
								Pavel

> When drm_panel.prepare_prev_first is set to true in a panel driver, the
> panel expects the MIPI DSI hardware to be already configured before the
> panel's prepare function is called because it might need to send DCS
> commands.
>=20
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

--lPY3qu2HugW3RZPQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCad4DVgAKCRAw5/Bqldv6
8u1bAKC9P2n7KhyNMmAjOiJSghsZO0GYdgCgiQpfaEWJZEx/Ru5+IqW22VCbkXo=
=TqMi
-----END PGP SIGNATURE-----

--lPY3qu2HugW3RZPQ--

