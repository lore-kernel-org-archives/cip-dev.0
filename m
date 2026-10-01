Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954F4CA5FCB
	for <webhook@archiver.kernel.org>; Thu,  1 Oct 2026 11:56:18 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9413.1790855773106429028
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Oct 2026 04:56:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=O91XIWMv;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 297F6106B40;
	Thu, 01 Oct 2026 13:56:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790855766;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ndIrcch2V94v+ypA4LHIb9XGUV9mip7L/AFvkCnThqk=;
	b=O91XIWMvPROdEsofZMkDPu2ff1fPUHa5N5ECLPFjeySjRkY3H5QvaPd5UJkmgA4QSfVuOb
	jUp97xCQMSyhfqMs5Dqh5LrZxj0/Ou//E1ZUioDcdF7I/RZDd9nMz22D2tZXvUFk6pwnKh
	QTIFmVCfp3pwW8S8FyGa+J3a1CAyPiqip+2zHXLzQMs9QPEkFfwRxXI+MucVCV7PUa2+GM
	ZsTFZoZmGJqApR0X4CUJJoqGHFGq29Hpk+k9Muf6jsWCkv2BFGBA1kWql56i+9Pq29C5gd
	1fPj4X2I6G/7dEeCIbCgEU5X0O1trwMvOs2MKbv07AYhNxPogtg13/Ecqm+0ag==
Date: Thu, 1 Oct 2026 13:55:59 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.4-st80, 4.4-cip115 (sit down for this
 one)
Message-ID: <ar5KT0VJYcgkNhqI@duo.ucw.cz>
References: <1957665225.34596.1790092309178@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UXmPfUcKm7vf2xkG"
Content-Disposition: inline
In-Reply-To: <1957665225.34596.1790092309178@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Oct 2026 11:56:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24397


--UXmPfUcKm7vf2xkG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4 kernel release. As alw=
ays they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/ci=
p/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>=20
> There's a total of 87; 13 by me, and 74 by LLM. (The latter are labeled w=
ith "Assisted-by: SLTR:qwen-3.8".)
> Total manual backport ratio is 21%, slightly down from 22% for st79.
>=20
> Speak up if you find a class of patches in here that we should not consid=
er for backporting in the future.
>

Some remarks below, but these look good.

Best regards,
										Pavel

a > 160be80dcaa57 i2c: core: fix adapter registration race
a just a API fix > 023c8f3acebcc net: ip_gre: require CAP_NET_ADMIN in the =
device netns for changelink
a > b8b285996937e smb: client: restrict implied bcc[0] exemption to respons=
es without data area
a > 62b9455b524a2 ftrace: Add global mutex to serialize trace_parser access
a > 18e1b6863f2a2 wifi: ath6kl: fix use-after-free in aggr_reset_state()
a turns a bug into a WARN > c5d53c4091d2c libceph: Avoid using invalid osd =
indices from primary_temp
a mostly a robustness against strange hw > 02be6f188f65b thunderbolt: Bound=
 the DROM dual link port number before indexing sw->ports
a > 06b62f64d461a tipc: read le->link under the node lock in tipc_node_link=
_down()
a > 231cd04749bc8 ipv6: prevent in6_dev_get() from resurrecting inet6_dev
a patch is now very different > 5b8317d3c81a7 serial: 8250_dma: Clear stale=
 RX state on shutdown
a > 00114c782ae76 net/sched: cls_route: fix fastmap use-after-free on filter
! we are not doing nfs_sb_deactive or nfs_put_client in error path, but nei=
ther does mainline > f2bc9e8652686 nfs4: take a reference on the nfs_client=
 when running FREE_STATEID
a > 334d24ff159be Bluetooth: SCO: Fix use-after-free in sco_recv_frame() du=
e to missing sock_hold
a just a robustness against bad hw > 483db7203c062 can: kvaser_usb_leaf: kv=
aser_usb_leaf_wait_cmd(): validate received command extents
a > c58ecae06d669 sctp: reject stale cookies with mismatched verification t=
ags
a > a913bd184e356 net: sxgbe: check descriptor ring allocation failures
a > f6fa91ea743e3 libceph: Fix multiplication overflow in decode_new_up_sta=
te_weight()
a > 2952ef3847619 can: bcm: add missing device refcount for CAN filter remo=
val

Okay, but code in bcm_rx_setup() is now quite strange.

-                               op->rx_reg_dev =3D dev;
+                               /* keep a reference so that a later
+                                * unregister can safely reach the device e=
ven
+                                * if a concurrent NETDEV_UNREGISTER has
+                                * already unlisted it by ifindex
+                                */
+                               if (!err) {
+                                       op->rx_reg_dev =3D dev;
+                                       dev_hold(dev);
+                               }
                                dev_put(dev);

Minimal fix would be

                                op->rx_reg_dev =3D dev;
-                               dev_put(dev);			=09
+                               if (err) dev_put(dev);

a > f4fa2f7f36f2e sctp: fix auth_chunk_list capacity check in sctp_auth_ep_=
add_chunkid
a just a robustness against bad firmware > 0c6142e6d67bb wifi: mwifiex: bou=
nd uAP association event IEs to the event buffer
a > 41cfceccec572 net/packet: avoid fanout hook re-registration after unreg=
ister

--UXmPfUcKm7vf2xkG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCar5KTwAKCRAw5/Bqldv6
8rAmAJ0ST8vO3MplBeY7M+NNEWZ/4oNXPgCeLVFGKtB1d795w7qe+Yz1rdnKcLQ=
=gh3P
-----END PGP SIGNATURE-----

--UXmPfUcKm7vf2xkG--

