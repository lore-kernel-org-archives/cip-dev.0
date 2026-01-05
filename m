Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA04DCD0414
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 21:55:53 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.76521.1767650147011544454
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jan 2026 13:55:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=J6yhrGyS;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C32C410A209;
	Mon,  5 Jan 2026 22:55:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767650144;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tdaNv0Z6z9njdtyoiznQOu1jtR679D2CzigPjD0FTlM=;
	b=J6yhrGySD9ZNKm5mXq8tTLF9uwFTeropyVOc7RtweHJDALtIXZBgdCl4nOXwfKsMDFhRxh
	LjMzr6JZALhECKYoZgdsT1oEe3s0ZsBKiSy0oWo8+/nDggIxAWx0g4rYouP0mHz1v9G92M
	D+MNBYpnrDXoyLWwOAzOCw0ZRgz/AgoqER+Ur+UBh41SE1JXoN1udejJEf8f95jMDuBcMt
	6rtggzNsKEUP2Xp//EK08X5DV94fbZ4AsfvSTFdhSsieOSNtllhJoBK7Ys/+eGMSS9hIhQ
	GAXFOVcz/9VbSrJtjjmghwsHR4npiNRW19VJUT/AvCo+l7zcBuWP4c1Zp1AtHw==
Date: Mon, 5 Jan 2026 22:55:39 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st11, 4.19-cip127
Message-ID: <aVwzWx4vKyMEaIXL@duo.ucw.cz>
References: <512263003.35605.1766383683487@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3h7T6UruvylGr0T"
Content-Disposition: inline
In-Reply-To: <512263003.35605.1766383683487@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jan 2026 21:55:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21316


--O3h7T6UruvylGr0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.19 kernel release. As al=
ways they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/c=
ip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>=20
> 0b4f892d4caa usb: uas: fix urb unmapping issue when the uas device is rem=
ove during ongoing data transfer
> d5e8379424542 scsi: pm80xx: Set phy->enable_completion only when we
> 82c4ffb49e987 drm/amd/display: Check NULL before accessing
> 772b21d2f0317 wifi: ath10k: Fix connection after GTK rekeying
> 7da6f50f7d7a5 pinctrl: single: fix bias pull up/down handling in pin_conf=
ig_set
> 80bf4633c7043 libceph: fix potential use-after-free in have_mon_and_osd_m=
ap()
> 495e4a086b69a nvme-fc: use lock accessing port_state and rport state
> d6c1721463a61 net: netpoll: fix incorrect refcount handling causing incor=
rect cleanup
> df6e18b2a9179 net: ethernet: ti: netcp: Standardize knav_dma_open_channel=
 to return NULL on error
> aa71fdcea176e tipc: Fix use-after-free in tipc_mon_reinit_self().
> 92396463b534a sctp: prevent possible shift-out-of-bounds in sctp_transpor=
t_update_rto
> 4051e60b1c5fc Bluetooth: btusb: reorder cleanup in btusb_disconnect to av=
oid UAF
> ef3aaa87ec116 net: ravb: Enforce descriptor type ordering
> dd2973f30a943 wifi: brcmfmac: fix crash while sending Action Frames in st=
andalone AP Mode
> 22a3a715eb41f net/sched: sch_qfq: Fix null-deref in agg_dequeue

These patches look good to me. I did not take complete review of
"80bf4633c7043 libceph: fix potential use-after-free in
have_mon_and_osd_map()" as that one looks tricky.

Thanks and best regards,
							Pavel
--=20
In cooperation with Nabla.

--O3h7T6UruvylGr0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVwzWwAKCRAw5/Bqldv6
8pzAAKCv1xz5nE8RLsI0UVrFPdgaXTxqeACgiZmhc8UjfJUT9fT9n1ytewAQq3I=
=8D3N
-----END PGP SIGNATURE-----

--O3h7T6UruvylGr0T--

