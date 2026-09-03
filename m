Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DBEC61DD3
	for <webhook@archiver.kernel.org>; Thu,  3 Sep 2026 11:59:16 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6016.1788436750724838698
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2026 04:59:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=HBbr0l4G;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3202011D5ED;
	Thu, 03 Sep 2026 13:59:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788436744;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=iZ2NMH+yI6KL66fIKq4RlatfnBHdubXTBoHg/FsKPJU=;
	b=HBbr0l4GlleWm997z1mdVIrQMaEismHm7MLlmF/tdI4Rw5JNIxPgKdOPiLRxqHXW2iY5au
	35SU7oqqTkRoX2RnTmNcbtHFRernrm/ZaMn5jLQlWPHRVZn7PLlERbKpUM0KYFkLWeUH8L
	Im0kh0byjjGJvOcNXH84KAUlMXD3VVpm5Chza3b+xo6UiYpxroP6wlQ6grPM8BjL46YSIR
	IFnRqh8gYj4GoMOFoSzPdidxada7FzAoEVuKhICvd8k1BonBWPWfVfc0E8VioXoUm/sadE
	sjDTw9u7Jj2cLcOli0sBPMc4JRgYTLM596XgqnpIzUUBVzRanIx8vzHS42oI4w==
Date: Thu, 3 Sep 2026 13:59:00 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st20, 4.19-cip136
Message-ID: <aplhBK04CTRBNOBE@duo.ucw.cz>
References: <588742173.259606.1788373971804@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nzci46EOuQel8LWB"
Content-Disposition: inline
In-Reply-To: <588742173.259606.1788373971804@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Sep 2026 11:59:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24090


--nzci46EOuQel8LWB
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

I have some comments here. I'll try to continue review soon.

Best regards,
								Pavel
							=09
>=20
a > 27bcd94232ddc ipv6: mcast: Fix potential UAF in MLD delayed work
!! should return -EINVAL > d03436150e4a9 drm/edid: fix OOB read in drm_pars=
e_tiled_block()
! original patch is not great, if they want to play with sizeof, they
should have introduced a define > 4227b25379d71 drm/displayid: fix Tiled Di=
splay Topology ID size
a just a robustness against filesystem corruption > 43d3d995bf595 f2fs: val=
idate orphan inode entry count
a > 5021916ddfd36 ALSA: seq: close a re-opened queue timer in the destructor
!! it fails to return error > 6fe1ea5d01613 hwmon: (adt7470) Fix PWM auto t=
emp state array and bounds check
a > c32d12e231163 writeback: fix race between cgroup_writeback_umount() and=
 inode_switch_wbs()
a > 725e862fe8b08 ieee802154: admin-gate legacy LLSEC dump operations
a I'd delete the /* already removed */ remark, it is not really helpful, an=
d for consistency > 033fdbe334d3c xen/gntdev: fix error handling in ioctl
a > fdc9c5a408cfc rxrpc: Fix leak of released call in recvmsg(MSG_PEEK)
a > 3ecdb8f5381c2 mac802154: llsec: reject frames shorter than the authenti=
cation tag
!! should VMXNET3_RCD_HDR_INNER_SHIFT be 13? > e05a9dca311e3 vmxnet3: fix B=
UG_ON in vmxnet3_get_hdr_len() for Geneve packets
a > ae8427e05bc1a firewire: net: Fix fragmented datagram reassembly

--nzci46EOuQel8LWB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaplhBAAKCRAw5/Bqldv6
8rmUAJ4mjjXCMMMDpae0jbptTWYkEJ+ezACgqcfDJqbTRUD4N2GZlXEqOlqh1q4=
=JY0W
-----END PGP SIGNATURE-----

--nzci46EOuQel8LWB--

