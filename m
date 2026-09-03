Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E25DC624A4
	for <webhook@archiver.kernel.org>; Thu,  3 Sep 2026 09:00:29 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3203.1788426019457741398
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2026 02:00:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=P3Nc1AYv;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4297611D490;
	Thu, 03 Sep 2026 11:00:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788426013;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ZoZ5KsaCpHHyIfdjpwb5BrulKMT7LDqgaM2jcASN6Aw=;
	b=P3Nc1AYv1O/aGgwHO8H7Cz4XvJSQW6afx2CyqByp9vj6OtuHq+Gml7WCL8hDw5HQK+Ywqy
	BRlPsVthILmui8j5WezhnH4tr8axHk0B1iuAaBW/d4Ix/Aj4PCmMKjGDmLHLGkojK88Q+h
	8e4vl79OskwqeX5cXzTq8z10j214SdUgFQvJNXMIM911PjD5L+zmoc+OyGyzIvbi5cT5yP
	9IHg47ITlLoqO5tXykhsBCTkMj4lNJlgBiFNE1wFJVGfQckZhOXKN3sg5I/ZXv2lhR8Y6F
	I/JrZoQeMpsCDoZDBvbwmluZ2yvrz9QMg1gB6P0AGqvHVX1AuLHdcDv0bBxFUA==
Date: Thu, 3 Sep 2026 11:00:09 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st20, 4.19-cip136
Message-ID: <apk3GX_faRAev-Ta@duo.ucw.cz>
References: <588742173.259606.1788373971804@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mu0Bo0krIQJLSyPy"
Content-Disposition: inline
In-Reply-To: <588742173.259606.1788373971804@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Sep 2026 09:00:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24087


--mu0Bo0krIQJLSyPy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Here are the "manual" backports for the upcoming 4.19 kernel
>  release. There's a total of 68; 40 by me, and 28 by LLM. (The latter
>  are labeled with "Assisted-by: SLTR:qwen-3.8".)

I'm not huge fan of "the more the better" here. We are not testing all
of the kernel, we are not even compile testing all of it, so bugs will
eventually creep in.

Can you clarify what role LLM had here, what goals you set for it, and
how you reviewing the stuff?

Best regards,
								Pavel

--mu0Bo0krIQJLSyPy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCapk3GQAKCRAw5/Bqldv6
8gSMAKC9d6RE1cu4czoM4969Gcm5jvBeKgCghxmPOfOXCx9PfZt09RzApiZJM3M=
=rZTS
-----END PGP SIGNATURE-----

--mu0Bo0krIQJLSyPy--

