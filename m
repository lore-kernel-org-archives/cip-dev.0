Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF47CD8CA4
	for <webhook@archiver.kernel.org>; Tue,  9 Jun 2026 08:51:25 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.75173.1780995078490840255
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Jun 2026 01:51:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=FI9vfpb0;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D12AA115CD6;
	Tue,  9 Jun 2026 10:51:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1780995076;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=VnyjeQ4ViZ+QPtqq13KOgZVAEeXv+Y/82fTpAu613w0=;
	b=FI9vfpb0jW7H98pFwT9hFIrMYwg/WcDVM04ht+muxOwQcIruMaWhbqXKlKucyXCj+idvNB
	nWGpk4l6Z3lXwnGB5cGZWwCn7izFVl3lAFz4O7fg6Hiq3FMYgrntYT3wKFFVnJtEkMWVkm
	xlWBUGIJz529W3h1UVbUysv3yr8xtOcjzksApE45xeTj0EW86iHJNy93rOAtLy6QjCQdCO
	0CBqP0eCrSeAg1urJogg28CfStrj56FZHMFWrkkEARV6nxMK09etDIn0eQDjMZi2dTlRt/
	SGAT/UrTZ3F+lTn1rDwEuP8Hy0mE/VkGntT34logZTnugsy/EtHPYbMhf3oylg==
Date: Tue, 9 Jun 2026 10:51:13 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.4-st77, 4.4-cip112
Message-ID: <aifUAaSVDIRHHN_a@duo.ucw.cz>
References: <1985872946.840508.1780932177008@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VkVq2yXtwghyG4UJ"
Content-Disposition: inline
In-Reply-To: <1985872946.840508.1780932177008@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Jun 2026 08:51:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23054


--VkVq2yXtwghyG4UJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4 kernel release. As alw=
ays they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/ci=
p/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>

Looks good to me.

a > 6e6dafcb73d7f x86/CPU/AMD: Prevent improper isolation of shared resourc=
es in Zen2's op cache

I don't believe define in tools/testing/selftests/kvm/include/x86.h is
used anywhere.

a > 8e98545170c1b x86/CPU/AMD: Add X86_FEATURE_ZEN1
a > 5e0f887ad764d x86/CPU/AMD: Rename init_amd_zn() to init_amd_zen_common()
a > 6f2a036399e90 x86/CPU/AMD: Add ZenX generations flags
a > e379f10bd8fb5 ptrace: slightly saner 'get_dumpable()' logic
>=20
> (All of these patches had to be manually backported to 4.19 and
again to 4.4.)

I see:

    [uli: backport to 4.19]
    Signed-off-by: Ulrich Hecht <uli@kernel.org>

I guess that should be "backport to 4.4" or perhaps even

    [uli: backport to 4.19]
    Signed-off-by: Ulrich Hecht <uli@kernel.org>
    [uli: backport to 4.4]
    Signed-off-by: Ulrich Hecht <uli@kernel.org>

But that's not a big deal.

Thanks and best regards,
								Pavel

--VkVq2yXtwghyG4UJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaifUAQAKCRAw5/Bqldv6
8qfCAKC0DwC2ozVYulDDcJdBVgcvU/xrAwCgrvteOtI1BseVS+m5Ai1XWGY25/k=
=CBT9
-----END PGP SIGNATURE-----

--VkVq2yXtwghyG4UJ--

