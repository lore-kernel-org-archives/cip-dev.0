Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B464CCD98F2
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 14:04:07 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43651.1782137037560372530
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jun 2026 07:03:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=EUSsrpYu;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 162441151ED;
	Mon, 22 Jun 2026 16:03:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782137035;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=A7hXSqudLgGCAON5pvpgCHaJe8xFPovj9KJPtR0Hp1M=;
	b=EUSsrpYulQEgelGRVIH37h1lNrVrWYq4tnkSzh3fUVHLdf0+kA/8Od2NMhwu69G+oeePQs
	DicnelAFmmqHnOXcGVKefKHwDP9Hi4MGkVvDAAiGhA+3/5yMW914ySLWm098nd7uAwG1NY
	OGvLpbJq9ppppmZZfAYY7XtrsFIyjZbHb5I39ZSBG4HAO1tZEkBloRuxHOSkS/5K4tZb61
	lziUzvXHMydqfsll7l5IG9LsKbBiKhUAF0LPnSz2fADPkKeqpXvSsph5v675RprEM7fC06
	mY04nQYjnXw+NL1uxG9r8qRiRpVy5q5X3pg6PoSAY0Iefs+TzJuJvgAtpzatlw==
Date: Mon, 22 Jun 2026 16:03:49 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st18, 4.19-cip134
Message-ID: <ajlAxQVzhGGpBs0w@duo.ucw.cz>
References: <92480685.1219204.1781878850004@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sj5bzKuLfFE4Oysp"
Content-Disposition: inline
In-Reply-To: <92480685.1219204.1781878850004@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jun 2026 14:04:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23249


--sj5bzKuLfFE4Oysp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.19 kernel
>  release. As always they can be found in
>  https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinux-4.19.y-st-rc

Patches look mostly good to me. Some notes are below

Best regards,
											Pavel

? why the null check > ac6678cb12932 batman-adv: clear current gateway duri=
ng teardown

Why the added NULL check? Mainline patch does not have it, and it will
not break anything, but I don't understand reasoning.

a > 8a8f72ed32162 netfilter: ipset: stop hash:* range iteration at end
a > 239972f582859 net/sched: netem: fix queue limit check to include reorde=
red packets
a just a interface fix> 290ca3d4cc0fe cdrom, scsi: sr: propagate read-only =
status to block layer via set_disk_ro()
a > d09410f835071 btrfs: fix double-decrement of bytes_may_use in submit_on=
e_async_extent()
a > 8134eaf6adc42 tipc: fix double-free in tipc_buf_append()
a > 02d2ac7f84d00 slip: reject VJ receive packets on instances with no rsta=
te array
a > 50beb65e59221 netfilter: nfnetlink_osf: fix potential NULL dereference =
in ttl check
a > 602bc47c8749f crypto: ccp - copy IV using skcipher ivsize
a > b9d8a2d537ce9 wifi: brcmfmac: Fix error pointer dereference
a > 041440c0902f7 bpf: fix end-of-list detection in cgroup_storage_get_next=
_key()
a > f43b5f55f017c crypto: authencesn - reject short ahash digests during in=
stance creation
a just a hw bug workaround > fa4149888d92f mmc: block: use single block wri=
te in retry
a mostly a robustness > 0ecdcd07a75d2 crypto: ccp: Don't attempt to copy PD=
H cert to userspace if PSP command failed

Hmm. This is wrong. In case of argp->error, we'll return 0, even when
we have failure. AFAICT same problem exists in mainline.

a mostly a robustness > c14d8dc588ad5 crypto: ccp: Don't attempt to copy CS=
R to userspace if PSP command failed

Same problem here, we'll return 0 on argp->error.

a just a tracing fix > 3bffafe5e8975 x86/uprobes: Fix XOL allocation failur=
e for 32-bit tasks
a > 2008358d97f17 blk-mq: use quiesced elevator switch when reinitializing =
queues
a > e336fb23c682a scsi: ufs: core: Improve SCSI abort handling
a > 6f7e7878e3c89 bcache: fix cached_dev.sb_bio use-after-free and crash
a not a minimum fix > a33e2701e85c8 rxrpc: proc: size address buffers for %=
pISpc output
a > 7a2d6e91f43a6 can: raw: fix ro->uniq use-after-free in raw_rcv()
a > 5553ed48c310e batman-adv: hold claim backbone gateways by reference
a > 781ff3428d09f l2tp: Drop large packets with UDP encap

Error-handling code could be shared here.

a > b741e14915ee3 xsk: tighten UMEM headroom validation to account for tail=
room and min frame
a > 9eddb82dc26e4 wifi: brcmfmac: validate bsscfg indices in IF events
a > b03bfcc22433c can: mcp251x: add error handling for power enable in open=
 and resume
a > 133952b84ff40 net: skbuff: propagate shared-frag marker through frag-tr=
ansfer helpers
>=20

--sj5bzKuLfFE4Oysp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCajlAxQAKCRAw5/Bqldv6
8uC0AKCDDGq3BYXjRW0otG7TG6cbH7bn2QCgupY7iOyZd3Xo6/Ns8WfwMvWL5ek=
=zR82
-----END PGP SIGNATURE-----

--sj5bzKuLfFE4Oysp--

