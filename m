Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31763CDC16B
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:54:19 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88351.1767700456747602058
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:54:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=SuUL9Wyb;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0409A10C1AE;
	Tue,  6 Jan 2026 12:54:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767700454;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ymcxP8E3SOx+wXQL13MUPpiPNNzP19JjuamejuGTFLU=;
	b=SuUL9WybQxq9MeziTbCcdmrjUwOAt3xgDySjNNueR9OMbqxSE997ngBLhxspwdtQPxrQpp
	KKqEcjRsrdTgCes5+yLHxzJgsYYIt3v+uDaHEo40fA9W20BIUpJjC7lPar7JY4oAdgeSiX
	sSP/QbRW84AVbHheCZ+B2VkKWgKnZ2tEjZrnG2nnYgq5ifiPxxC+Y0Lj0zw8ILItZjZBUL
	cwtDNvuCbaocgNkKHzKmEbDwg2D+nYh+7GA6kIuW/mwoPDfo6kLTOJnI+XxQVyccbhk+FB
	wmw2BJ4laYS9PzizOS2u98fyLKUOKkW1Jf/Lhezcc444yqFOxeXDbdQ/a/699w==
Date: Tue, 6 Jan 2026 12:54:11 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.4-st71, 4.4-cip106
Message-ID: <aVz34wWa/HJhamyg@duo.ucw.cz>
References: <1675394165.12181.1766987804067@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PPj40loztnhb/xAk"
Content-Disposition: inline
In-Reply-To: <1675394165.12181.1766987804067@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:54:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21358


--PPj40loztnhb/xAk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4 kernel release. As alw=
ays they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/ci=
p/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>

These patches look ok to me. I'm not sure about iommu/amd change -- it
will only work if config matches between normal and kdump
kernel. Likely noone uses this in 4.4-cip, and mainline would have the
same bug, so I believe we can keep 4.4-st71 as it is.

a > eec045863d21a wifi: ath10k: Fix connection after GTK rekeying
a not sure ... does iommu config always match? > a48589643bfdd iommu/amd: S=
kip enabling command/event buffers for kdump
a > ff08d7a8c5806 net: netpoll: fix incorrect refcount handling causing inc=
orrect cleanup
a > 713eab81a91ae net: ravb: Enforce descriptor type ordering
a > e5614027881ba net/sched: sch_qfq: Fix null-deref in agg_dequeue
a > 05a9484527b6c ata: libata-scsi: Fix system suspend for a security locke=
d drive
a > 7af6c5e760217 fs/proc: fix uaf in proc_readdir_de()
a > a3c1eb2bab5a6 Bluetooth: 6lowpan: Don't hold spin lock over sleeping fu=
nctions
a > 648881139872a Bluetooth: bcsp: receive data only if registered
a > a84ba2b7b6f69 nfs4_setup_readdir(): insufficient locking for ->d_parent=
->d_inode dereferencing
a > 31db58f15a066 net/cls_cgroup: Fix task_get_classid() during qdisc run
a > 2711f9d9013eb usb: gadget: f_ncm: Fix MAC assignment NCM ethernet
a > 9d0655d33b789 net: usb: asix_devices: Check return value of usbnet_get_=
endpoints
a > 8299fa5409dc6 Bluetooth: btusb: reorder cleanup in btusb_disconnect to =
avoid UAF

Thanks and best regards,
									Pavel
--=20
In cooperation with Nabla.

--PPj40loztnhb/xAk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVz34wAKCRAw5/Bqldv6
8sxoAJ9fmN5Cbx8lrlbnH/y8s8JpzSFjBwCgkVMiuhXlPuHgtBa1Pe36WN4rkXo=
=ZlOX
-----END PGP SIGNATURE-----

--PPj40loztnhb/xAk--

