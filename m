Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57424C79F89
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 11:04:50 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32240.1788779081888534990
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Sep 2026 04:04:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=MYGmbIfl;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4959311D9DB;
	Mon, 07 Sep 2026 13:04:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788779075;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=QNq9uu7wJNH7d3kk7M2XC9sCFAyIDqBwnHMAdMKh8mI=;
	b=MYGmbIflTPEgbvcShG35cJjKNOtf/Bd4OGDc8zYJva6KhT+xSPMRGY1OVF+4+Up7Pb/dXd
	JXIxaoraW6cZ0YEWxFvHn2s7kRUWvlVY2ucf7I6uUYwGy0G4UooF0A0hnAq9qhGIRSTImv
	9YttbqTrKQ7IHST8L9gIwchcEEln8WwY1NbnoWXrDPND6jb11RGQfiFsfRB8jjbwgcYyPz
	RqjhExbmny627lYMm+jGS21dlbRlyn3K361v5/fX6JwMKQUEyLM03xT7Kz60qP/mBoZd//
	j/3zd7iym2O7/1hnny9OW8/ZyAj9V0ydqKoS6kI7vyh1iOGcvWbvy2QMmXI2cQ==
Date: Mon, 7 Sep 2026 13:04:31 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st20, 4.19-cip136
Message-ID: <ap6aPwQoEtRazAe9@duo.ucw.cz>
References: <588742173.259606.1788373971804@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0sw7ifQEUHKLyRc/"
Content-Disposition: inline
In-Reply-To: <588742173.259606.1788373971804@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Sep 2026 11:04:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24099


--0sw7ifQEUHKLyRc/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the "manual" backports for the upcoming 4.19 kernel release. The=
re's a total of 68; 40 by me, and 28 by LLM. (The latter are labeled with "=
Assisted-by: SLTR:qwen-3.8".)
>=20
> As always they can be found in
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinux-4.19.y-st-rc

More reviews here. The alf_alg thing is kind of scary, I was not able
to review that one relative to mainline version.

Best regards,
								Pavel

>=20
a marking definitely unused code "maybe unused" is kind of
interesting; but mailine has similar trick > 837b739d485a8 serial: 8250_mid=
: Disable DMA for selected platforms
a > c9534ae294af2 bonding: 3ad: fix mux port state on oper down
! this is now completely different from mainline, and pretty non
trivial; I don't know how to review this one  > 0ee0719ebd182 crypto: af_al=
g - Remove zero-copy support from skcipher and aead
a > 8d4d8938c938b apparmor: mediate the implicit connect of TCP fast open s=
endmsg
a > d1ae7480a5a50 netfilter: ipset: fix refcount race between list:set GC a=
nd swap
a > afe5bdeae11e4 btrfs: do not trim a device which is not writeable
a > c819b97d60589 xfs: use null daddr for unset first bad log block
a > 82f3412405d88 HID: appleir: fix UAF on pending key_up_timer in remove()
a > f6b1dda2a3508 smb: client: Fix next buffer leak in receive_encrypted_st=
andard()
a st_sensors_get_unaligned_be24() is strange, it playes some tricks
with s32 casts and shifts data back and forth > 598fd8e4db9ac iio: common: =
st_sensors: honour channel endianness in read_axis_data
a we dropped WARN_ON, I guess that's ok > a43c58057c539 netfilter: nf_nat_s=
ip: reload possible stale data pointer
a > 19f32fd717473 ipvs: ensure inner headers in ICMP errors are in headroom
a > a777755df8ee5 netfilter: ip6tables: mark malformed IPv6 extension heade=
rs for hotdrop
a > de57725fa7d0d rtc: ds1307: Fix off-by-one issue with wday for rx8130
a > 27f698f798451 smb/client: preserve errors from smb2_set_sparse()
a > 1afab31384e2e netfilter: ipset: fix order of kfree_rcu() and rcu_assign=
_pointer()
a > 80f8dca831e42 tipc: prevent snt_unacked underflow on CONN_ACK
a > 21754c9585fc3 tipc: require net admin for TIPCv2 netlink mutators
a > 3face51d6506e net: fib_rules: Don't dump dying fib_rule in fib_rules_du=
mp().
a > be43ba6f489b6 ocfs2: rebase copied fsdlm LVB pointers in locking_state
a > d145312da325f net/sched: cls_bpf: prevent unbounded recursion in offloa=
d rollback
a > 21aebfc636b9c crypto: ecc - Fix carry overflow in vli multiplication
a > ea5470a093f6d Bluetooth: fix UAF in bt_accept_dequeue()
a > 5fb906176753b net: ipv4: bound TCP reordering sysctl writes and MTU pro=
be sizes
a just a robustness against bad hw > b06d8e05be8d6 drm/dp/mst: fix buffer o=
verflows in sideband chunk accumulation
a just an api fix > 2ee87cc535310 net: ipip: require CAP_NET_ADMIN in the d=
evice netns for changelink
a > 798716bc98db1 rxrpc: Fix notification vs call-release vs recvmsg
a > 483240e3761eb libceph: fix multiple unsafe decodes in decode_locker()
a > 4338c41c423b1 scsi: scsi_debug: Negate wrapped memcmp() result

--0sw7ifQEUHKLyRc/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCap6aPwAKCRAw5/Bqldv6
8pIFAKDDzp+4Nt1HxstDO8sKTP/3Pn353QCfVuCbJAwMxR0hYMP4EC0DSHANaDA=
=pQvn
-----END PGP SIGNATURE-----

--0sw7ifQEUHKLyRc/--

