Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C04CD4F26
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 08:11:23 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.70831.1778573475207626953
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 May 2026 01:11:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=glCX980i;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 870F91141EC;
	Tue, 12 May 2026 10:11:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1778573472;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=SBdRVRyYnfYBjl/OsiSwTkPzykBqXd3d+SJGbe+D++Q=;
	b=glCX980irpShH+dHmCi0nC3ps1FQ5ha2VdUeqxSJLzDrMUU+CuHS3JY25O5GReyrJqou1r
	mLayxT1qAxmgMVZjm28TjVitUlGwaafxRe7AL+SLShMFXQrCok44QicSGUTrL845NVntyb
	RSf+XbUpVbLSpY8oDkCmwtg2C5xHBTRIb0EPLdmariwsJVmtUr45oNqVz+uxJ22Vmr8FS0
	w6FGnf0HtCXrZ65FsxjKMy3gBnWzoWCpNY8QV9vHFuvu04GDpOPQ4r6ZwBw9AE2goTsyIy
	Jr1UcT1ry/a3Su/1Xrxrd/nrog1gbmDj2rvE+eQN47Jz/dSeZGphW9uKUFhmzA==
Date: Tue, 12 May 2026 10:11:08 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC][PATCH 6.12.y-cip 00/12] Backport PREEMPT-RT support for
 ARM 32-bit
Message-ID: <agLgnPxH1GISELm_@duo.ucw.cz>
References: <cover.1777964226.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="92aVzVuZazfc/01z"
Content-Disposition: inline
In-Reply-To: <cover.1777964226.git.jan.kiszka@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 May 2026 08:11:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22927


--92aVzVuZazfc/01z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> A first attempt to backport the recently merged ARM 32-bit support of
> PREEMPT-RT from 7.1 to 6.12-cip. Only lightly tested so far, first of
> all looking for feedback regarding completeness.
>=20
> This may also be valuable for 6.12-rt as this series should be able to
> replace all patches tagged with {ARM:,arm:} in v6.12.79-rt17 - adding
> Daniel.

Patches look okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

You may need to sign them off.

Best regards,
								Pavel

--92aVzVuZazfc/01z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCagLgnAAKCRAw5/Bqldv6
8ty4AJ9YcTDByftthXEBcBaFLF6LJBaKHQCePEOvC0lswFYlV1uqn0BBPogCbtM=
=XJQQ
-----END PGP SIGNATURE-----

--92aVzVuZazfc/01z--

