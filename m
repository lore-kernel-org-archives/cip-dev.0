Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CD3C43458
	for <webhook@archiver.kernel.org>; Mon, 13 Jul 2026 10:37:33 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7993.1783939050985676849
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jul 2026 03:37:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=jg9ELe8A;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC05B11997E;
	Mon, 13 Jul 2026 12:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1783939048;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=CeQTObP98ixsypXD8z4ByTyMseMCLwoKx1VJaF1tOyQ=;
	b=jg9ELe8APx02Gd4ySmoZ7qEgWOEoVnudOW7XbTfZBwGtGIkfha37NanMTRiCQ0yJTrV8N8
	lWuF5lpEGNogfHFYowgJSCcIxQxv4AZo603X5ItYAkRYx+qD9/u2qgqLp7fClZrIXq2uvp
	FoMDUukY4KBJ3UnD8i4l9YmzTtveT54iFzzQNO1LG/MAcaci6b/R8jmfMX4wcFSk+K6ndq
	W9dKkn4w4IjenWAMKwxZVIb3v+ahg0B9oj4LvwPPBk3+FVvfRSjYAbS2Y3qzJR0p9dtgIX
	NWjgPkzhLpmsPu70ShpgpGwop9XhWRkIlrUAMWi8JUrqfgXM5/AhCbLyINP4qg==
Date: Mon, 13 Jul 2026 12:37:23 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.4-st78, 4.4-cip113
Message-ID: <alS_410BkUAadIMY@duo.ucw.cz>
References: <396580511.533337.1783432236611@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XGnSWG20b9OFgq5o"
Content-Disposition: inline
In-Reply-To: <396580511.533337.1783432236611@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jul 2026 10:37:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23561


--XGnSWG20b9OFgq5o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> Here are the manual backports for the upcoming 4.4 kernel release. As alw=
ays they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/ci=
p/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>

For now, I have not checked the batman-adv stuff. Two comments below.

a > 6fc536e081b4e cdrom, scsi: sr: propagate read-only status to block laye=
r via set_disk_ro()
a > a70db8dc8aa2d bcache: fix cached_dev.sb_bio use-after-free and crash
a operation order in error handling does not match initialization > d6dc394=
717b9d can: mcp251x: add error handling for power enable in open and resume
> 270f518e2aab7 batman-adv: tt: fix negative tt_buff_len
> b9d56f0fa7881 batman-adv: tt: fix negative last_changeset_len
> 2ea84dbb4204d batman-adv: frag: disallow unicast fragment in fragment
> 3075eb7fe5a6a batman-adv: fix fragment reassembly length accounting
> 5c81177e39927 batman-adv: clear current gateway during teardown
a > 516397de58548 net: usb: rtl8150: fix use-after-free in rtl8150_start_xm=
it()
a introduces stricter parsing > 2c14f681cb8ca netfilter: nf_conntrack_sip: =
don't use simple_strtoul
a > a177703144795 netfilter: arp_tables: fix IEEE1394 ARP payload parsing
a > 90d4b856cc573 netfilter: conntrack: remove sprintf usage
a > a5e1c4172bf7b sctp: fix OOB write to userspace in sctp_getsockopt_peer_=
auth_chunks
a just a robustness against fairly interesting device > a4e3e33596f1b HID: =
usbhid: fix deadlock in hid_post_reset()
a also removes a comment > b2df99543367b ALSA: core: Validate compress devi=
ce numbers without dynamic minors
> a856ea763a0c8 batman-adv: bla: put backbone reference on failed claim has=
h insert
> 420d73ca52ee2 batman-adv: bla: only purge non-released claims
> 283a66b993a78 batman-adv: bla: prevent use-after-free when deleting claims
a just a fix for unusual dts > 1f1f946bac592 power: supply: max17042: avoid=
 overflow when determining health
! no dec in munmap? , c/e, will we now have framebuffer refusing resize? > =
0bd353e476ab2 fbdev: udlfb: add vm_ops to dlfb_ops_mmap to prevent use-afte=
r-free

I don't see how this works. mmap_count is increased in mmap, but I
don't see corresponding decrease in munmap.=20

a > e27540595d282 md/raid5: fix soft lockup in retry_aligned_read()
! check_mul_overflow -- is it generic for all types? does sizeof > return s=
ize_t?...? > 16b4cbdf426d7 lib/ts_kmp: fix integer overflow in pattern leng=
th calculation

+       unsigned int prefix_tbl_len;
+       if (unlikely(check_mul_overflow(len, sizeof(*kmp->prefix_tbl),
+                                       &prefix_tbl_len) ||

AFAICT sizeof returns size_t, so I'd be much if prefix_tbl_len was
size_t, too.

a just clang fortify workaround > f03a0d998b054 ALSA: control: Validate buf=
_len before strnlen() in snd_ctl_elem_init_enum_names()
a > 7d2c7f0155186 gfs2: Validate i_depth for exhash directories
a > 06c757446f45d rxrpc: reject undecryptable rxkad response tickets
a > f842b70abca24 wifi: brcmfmac: validate bsscfg indices in IF events
>=20

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
								Pavel
--XGnSWG20b9OFgq5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCalS/4wAKCRAw5/Bqldv6
8sjRAJ0ej7kqKA2ot6ThLehAzuJ3WrpJ4QCfedqNJIZ4h3biX0RcBhTIOBRdL/c=
=Gqjo
-----END PGP SIGNATURE-----

--XGnSWG20b9OFgq5o--

