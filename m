Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8255C98317
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:54:04 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6094.1790250841139400955
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:54:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=XICxOBve;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8E65C104A99;
	Thu, 24 Sep 2026 13:53:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790250834;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=v20w2hKCfcDfW1pU0lE2vr4l+bGXLeKQlEE4gzNb3B4=;
	b=XICxOBveu2x0OwkfH4rBH/TFea0K64X1P3doGAAPZvMpe+6NwMkShBKeJ1Snk48SHwXUeX
	rwPizlmARaNMD6xiF3HO2YrlBiLn78Uov9cRF0+G8sfP8892F2LX2Er5y2APZ0hyUv48V9
	8quWy+oohygi2JMyjRujvbbdWAsJDSu/VUCqGhPKvInxM8+4tgY5p3B2iJxw/0cfFdg79f
	/0qImvgruWrBMt6XsltkQr+t2O8ch/C04cUzWe9jGT9dqzAE+tT6zMZE+EjCht62aa9jE7
	5gE5Q6ppv0O3CL3ulwKg5F0lP89HyznE6oOZZcknACpbHMXjRkv5TwMfa4PpYA==
Date: Thu, 24 Sep 2026 13:53:48 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.4-st80, 4.4-cip115 (sit down for this
 one)
Message-ID: <arUPTC54RINDdYlb@duo.ucw.cz>
References: <1957665225.34596.1790092309178@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rn1eDzaAZnxLz/dy"
Content-Disposition: inline
In-Reply-To: <1957665225.34596.1790092309178@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:54:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24336


--Rn1eDzaAZnxLz/dy
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
> Speak up if you find a class of patches in here that we should not
> consider for backporting in the future.

It seems commit ids no longer match what is in the tree.

First third of patches looks good, I believe one will cause
compilation fail.

Best regards,
								Pavel



a an API change, hopefully noone depends on that bug > d482fcdcb9cf5 net: i=
pip: require CAP_NET_ADMIN in the device netns for changelink
a an API change, hopefully noone depends on that bug > 9447834f71856 net: i=
p6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
a an API change, hopefully noone depends on that bug> 66b209be16611 net: ip=
_vti: require CAP_NET_ADMIN in the device netns for changelink
a > f5d2ad74edde2 NFS: Pin the 'struct nfs_server' during a FREE_STATEID ca=
ll
a just a robustness against fs corruption > 4acc604700f7f ocfs2: reject non=
-inline dinodes with i_size and zero i_clusters

This will need to be del_timer_sync(), AFAICT.

!! timer_delete_sync does not exist in 4.4 > 33b3774667584 wifi: libertas_t=
f: fix use-after-free in lbtf_free_adapter()
a just a WARN removal > 15fd6b8ab4e3f net: remove WARN_ON_ONCE() from sk_mc=
_loop()
a > f50d09ccb2a3c net: openvswitch: fix skb leak on flow key update failure=
 during recirculation
a just a robustness against out-of-tree users > f0bb3b226b24d audit: fix po=
tential integer overflow in audit_log_n_string()
a just a preparation > 1e58c90011532 skbuff: introduce skb_pull_data
a > 8a27878187716 tipc: prevent snt_unacked underflow on CONN_ACK
a > 9681717544d1f ipv6: mcast: Fix potential UAF in MLD delayed work
a > e3b1657d6d49f vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Geneve p=
ackets
a > ab0f8bfb5b96d xfrm: defensively unhash xfrm_state lists in __xfrm_state=
_delete
a > 1ee9bb33f50c5 btrfs: do not trim a device which is not writeable
a > 210f49c16babe HID: appleir: fix UAF on pending key_up_timer in remove()
a > f762e427204a5 netfilter: ipset: fix order of kfree_rcu() and rcu_assign=
_pointer()
a > 104e962c0778d Bluetooth: fix UAF in bt_accept_dequeue()

--Rn1eDzaAZnxLz/dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCarUPTAAKCRAw5/Bqldv6
8oupAJ9xyoOj3rUAcLwO7h/i+7eAPX5JZQCgrq3nrnTKTp5C3JBvv1Dak1/QRz4=
=AJZt
-----END PGP SIGNATURE-----

--Rn1eDzaAZnxLz/dy--

