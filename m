Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0415CC02192
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 12:56:18 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.11229.1738760170013000212
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Feb 2025 04:56:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=fyYF+3vR;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 03DA310382D08;
	Wed,  5 Feb 2025 13:56:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1738760167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CDjgkHIZ2FH9yH84cxjcC4Ip4QoMP9BgMpfAV1YInSM=;
	b=fyYF+3vRRbvpyMWQ/Qz9FEeTdhUpAefKtWKCh3i3WmKoqvT8Ci3iTmo+83b/KAk6WksX7r
	oGMej8XgNiHXPfs1aASNR/0QQh87ITcX4AGnlGWH8+etphYlm8qU19LMnR58JJisT17tCl
	5GOs2rSSd6pUUOJ4+3bAu0L6L6GA1c+eq9zlAKhufVdc+1dZ65xJ8Ua9K6hUwaPXA4hPLp
	b8DQRQo3L8a4hMYtjhQequ6hwXsm7agamqwioICnDlPymvdmHYC+/CZ7DlDKqkJU9eLgfP
	2xeIKpRPqkGGnUOeRapda7qcWBE9O+P7oWIlqZFbcORzaSJCaWR6YkRR8alIjQ==
Date: Wed, 5 Feb 2025 13:55:59 +0100
From: Pavel Machek <pavel@denx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	cip-dev@lists.cip-project.org, tglx@linutronix.de,
	rostedt@goodmis.org, linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: Re: [PATCH 4.4 4.9 v1 2/2] mm: slub: allocate_slab() enables IRQ
 right after scheduler starts
Message-ID: <Z6Nf32YB/J0LMSPw@duo.ucw.cz>
References: <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
 <1738629964-11977-3-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
 <20250204081813.7qsvLFsU@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Omqnf7SUTSKRSslH"
Content-Disposition: inline
In-Reply-To: <20250204081813.7qsvLFsU@linutronix.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Feb 2025 12:56:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17752


--Omqnf7SUTSKRSslH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > An simple option would be to backport the series[3], which is possible
> > and has been verified[4]. However, that series pulls functional
> > changes like SYSTEM_SCHEDULING and adjustments for it,
> > early might_sleep() and smp_processor_id() supports, etc.
> > Therefore, this patch uses an extra (but not mainline) flag
> > "system_scheduling" provided by the prior patch instead of
> > introducing SYSTEM_SCHEDULING, then uses the same condition as
> > newer RT kernels in allocate_slab().
>=20
> The proposal looks okay. However the verified upstream version not only
> addresses your issue but also makes smp_processor_id() and might_sleep()
> work in the early phase. I would prefer the upstream solution for those
> two reasons.

So... first, thanks for review. This is mostly my fault, Kazuhiro
Hayashi did full backport, but I asked for minimal version.

AFAICT there's no place for stable-rt to apply this, so we'll just be
taking this to our trees in CIP project. (And I prefer smaller
version. Additional checking is nice for development but not so nice
this late in development cycle).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Omqnf7SUTSKRSslH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ6Nf3wAKCRAw5/Bqldv6
8qdHAJ4+/Dac3znHYOzsb3TSumEh2FbZEACfVqCBVseYjulmOKfgT7QMAIp7SJE=
=d8jC
-----END PGP SIGNATURE-----

--Omqnf7SUTSKRSslH--

