Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C74FC592F
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 11:05:29 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.67786.1772103928109723133
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 03:05:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=RZZde/YL;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F2D3103D43;
	Thu, 26 Feb 2026 12:05:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772103925;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=0uYJUPwBeyjGB09yTn2reQc3S8KD76MffxHn8F20F04=;
	b=RZZde/YLtfh7XyPgLydpV874xTtkxtsoG4uP39HnFxS0sMa+5iI0P9XnqEuLEz73qKnunT
	BeXvuF/rroIP8p6iv8CGqROgQbkJevcBuvc+4a7P/Aq1mnWJ2Vk/tfg3YiLsCKVd//9QEK
	py7SaUpMnILndEO+JW/CoxMSsY1Imwoxy89Pfy4rykKsZjWiiFhVosHwTw2A6ZY8k+D5AY
	QtNwdxmf2d34A0aRdb8fVF8JktPHcj4rpGxP2EX+ucWniqGBs3kkeoSlHkfPGiWXpe42co
	gzkZxXKv7EsQL0Qnjpq2yjlOEuqHoEWapvg4jtFwo4SuhmMITQT6OFG05QFwtg==
Date: Thu, 26 Feb 2026 12:05:21 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.4-st73, 4.4-cip108
Message-ID: <aaAo8TUKFDgI9j+f@duo.ucw.cz>
References: <440487134.6462.1771997574376@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m08rFpRjhJf+a/fC"
Content-Disposition: inline
In-Reply-To: <440487134.6462.1771997574376@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:05:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21991


--m08rFpRjhJf+a/fC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4 kernel release. As alw=
ays they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/ci=
p/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>=20
a > dd2af1ff15baa macvlan: fix possible UAF in macvlan_forward_source()
a > 6e7f9685b9d35 wifi: wlcore: ensure skb headroom before skb_push
a > 1b847006e7141 sctp: move SCTP_CMD_ASSOC_SHKEY right after SCTP_CMD_PEER=
_INIT
a> bf3c650dfddf3 btrfs: fix deadlock in wait_current_trans() due to ignored=
 transaction type
a> 9dbc25309be1c net/sched: sch_qfq: do not free existing class in qfq_chan=
ge_class()
>

Thank you, these look good to me.

> Plus one fix for my convenience:
>=20
> e0e89cfcf08df arm64: replace Sun/Solaris style flag on section directive

Pointer "mainline equivalent of this is XXX" would be nice here.

Thanks and best regards,
									Pavel

Author: Ulrich Hecht <uli@kernel.org>
Date:   Tue Feb 24 18:21:17 2026 +0800

    arm64: replace Sun/Solaris style flag on section directive
   =20
    Fixes compilation with recent GNU toolchains.
   =20
    Signed-off-by: Ulrich Hecht <uli@kernel.org>

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 0b095b75abeb74..16b1b654d14020 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -152,7 +152,7 @@ alternative_else
 alternative_endif
 ENDPROC(cpu_do_switch_mm)
=20
-       .section ".text.init", #alloc, #execinstr
+       .section ".text.init", "ax"
=20
 /*
  *     __cpu_setup


--=20
In cooperation with Nabla.

--m08rFpRjhJf+a/fC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaaAo8QAKCRAw5/Bqldv6
8qGuAJ9Z8r8Uxxw8qNuYElrffyBAkKkj4gCdFmNP2fJ4SB/U7vG+TxzN7OCKeRI=
=PDPb
-----END PGP SIGNATURE-----

--m08rFpRjhJf+a/fC--

