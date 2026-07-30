Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068E2C5516D
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 20:26:18 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21096.1785443175476862804
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jul 2026 13:26:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=kBper6j8;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C9B911A1AD;
	Thu, 30 Jul 2026 22:26:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1785443168;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=M3yPhip0eDF3Hng3JFGg3d1lxQvs3dgVJl43T4hSPB4=;
	b=kBper6j8o9+NI0STDjlGGxNNFpMPuUwgz8UjJmRWPxNFIaOQJDgcRTmY5JkDmVcW45KXUa
	mlW6dSuVtsMeJQq8/PMJZgMgxgJE0ESC6aSWdDhpPDMqaC+mePx9dgQ3uqO9MbiZcvJaOR
	UHlh5+KTWbC1oxOkOvxYVTbu+/I+KXWb362Z0TIsFZVywN7QkG1Zu4MlqPC1BwGdllHVvC
	NdPLcvZq2aCF5XpHMgsOTv4wpVDqwwNWVJF4HvKjsUlxcwGDi1Bl/S9KeobaDLb3LqAtkh
	LEd9GWvc4aKh0hisjnFUjSOaU37rerl9yX9fBn1oYikrEZqxthzcx/dYQjii6g==
Date: Thu, 30 Jul 2026 22:26:05 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st19, 4.19-cip135
Message-ID: <amuzXTKnx-62O07s@duo.ucw.cz>
References: <527172097.345263.1785165473174@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K6xXDmaPoMwuT1lg"
Content-Disposition: inline
In-Reply-To: <527172097.345263.1785165473174@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jul 2026 20:26:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23819


--K6xXDmaPoMwuT1lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.19 kernel release. As al=
ways they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/c=
ip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>=20

a > db198d6dc3936 nfsd: fix posix_acl leak on SETACL decode failure
a > bd323013cfee9 KVM: SVM: Fix page overflow in sev_dbg_crypt() for ENCRYP=
T path
> b810867b83f20 batman-adv: tp_meter: restrict number of unacked list entri=
es
> ca96eb4f37da2 batman-adv: bla: annotate lasttime access with READ/WRITE_O=
NCE
a > 86a17d8ec355b net/sched: fix pedit partial COW leading to page cache co=
rruption
!! > 5ec48ec054322 arm64: errata: Mitigate TLBI errata on various Arm CPUs

There's something wrong here.

+config ARM64_ERRATUM_4193714

is unused in our tree, and not present in
cfd391e74134db664feb499d43af286380b10ba8. Plus it looks like
documentation is missing.

!! > b24d758d47d69 arm64: Add part number for Arm Cortex-A78AE

Again, something wrong here. It creates the define but never actually
uses it.

a > b68402df84402 iio: gyro: adis16260: fix division by zero in write_raw
a > f3a8383d5d486 scsi: target: iscsi: Fix CRC overread and double-free in =
iscsit_handle_text_cmd()

Note to self -- we may need some kind of markup when only part of
patch is applied.

I'll continue review later.

Best regards,
									Pavel

--K6xXDmaPoMwuT1lg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCamuzXQAKCRAw5/Bqldv6
8k3dAJ4lHNvyWWT5fh9GGzDr8pISUNpClQCgiwWdIWFxwzPF7eYGoz+d/5xUuHM=
=dSbT
-----END PGP SIGNATURE-----

--K6xXDmaPoMwuT1lg--

