Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8B4CA5FFC
	for <webhook@archiver.kernel.org>; Mon,  5 Oct 2026 17:18:46 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25221.1791220719948092209
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Oct 2026 10:18:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Vz2qdqEC;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 456FB107E15;
	Mon, 05 Oct 2026 19:18:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1791220713;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=KSl1XxCtimYR/Bkp7hOpU7zaW2XVTN4NAp5FgRhfCh0=;
	b=Vz2qdqECuMPINDOd5CjNrFJ+kofnq6xKdUN6A1xIsb37pEDGPY5U+5G8FX9ZlMM9CrrsrE
	QwPj861b1NsfDv2SaYtvDAlkhtuiFcWKInPNZzJJ/1mIh38TP2vYmzc4Wb0meLuqaCPORq
	RFil2mqCy2ldIUh7uIV0QJIr2dFkdmW9/ry6A1AmtDCD95BJz/vVkcX880LLDCRKh+D1zk
	LF/J9u+X7MbVypKn/4QRNkOsTQz/G7+mEGuECFS/KKrcP0bF45WrzRSPClFXHie3+kcl2E
	DIPbQNvBaHt6NAeF/DOIHtbNnQoLyrhB/zXK3I7S02xubreDlOEK2AIpHL90aQ==
Date: Mon, 5 Oct 2026 19:18:29 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.4-st80, 4.4-cip115 (sit down for this
 one)
Message-ID: <asPb5bo-MVMqnJhu@duo.ucw.cz>
References: <1957665225.34596.1790092309178@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LqqYR25ZPbdrxVGq"
Content-Disposition: inline
In-Reply-To: <1957665225.34596.1790092309178@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Oct 2026 17:18:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24429


--LqqYR25ZPbdrxVGq
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

These look ok to me.

Best regards,
								Pavel

a > 96efe281a700d sctp: fix auth_hmacs array size in struct sctp_cookie
a > 13cf40380ac7b KVM: x86/mmu: Fix use-after-free on vendor module reload
a > 2f8e39207d985 crypto: qat - fix restarting state leak on allocation fai=
lure
a theoretical bug, untested > c57604391687e usb: free iso schedules on fail=
ed submit
a just a robustness against bad firmware > 72cc582c593d3 Bluetooth: btrtl: =
validate firmware patch bounds
a > 2e6bd3beccff5 ipvs: use parsed transport offset in SCTP state lookup
> 6dfae728844cc batman-adv: ensure minimal ethernet header on TX
a > 115ac4f85cafb dm era: fix out-of-bounds memory access for non-zero star=
t sector
a > daf3aeba89057 sctp: validate STALE_COOKIE cause length before reading s=
taleness
> e24980505e80e batman-adv: dat: fix tie-break for candidate selection
> 67cccfa82ee2a batman-adv: dat: ensure accessible eth_hdr proto field
a just a robustness > 28454e9b9d7b7 netfilter: xt_nat: reject unsupported t=
arget families

We don't have 9dbba7e694ec "ebtables emulation must reject non-bridge"...

a > 725269d86933c netfilter: nf_conntrack_reasm: guard mac_header adjustmen=
t after IPv6 defrag
a > b20eb35fc03f3 xfrm: validate selector family and prefixlen during match
a > a37ab55bcf26c sctp: validate embedded address parameter length
a > dc3d23e8a71fe firmware_loader: Fix recursive lock in device_cache_fw_im=
ages()
a  > 8c3821a3e30e0 ocfs2: kill osb->system_file_mutex lock
a > cf6f717ba97b8 ipv6: addrconf: bail out of dad_failure when state is no =
longer POSTDAD
a just a robustness against corrupted fs > 10b4440285691 udf: validate free=
 block extents against the partition length
a > 5235e88344349 USB: ldusb: fix use-after-free on disconnect race
a > e1dcc7378c58b cpufreq: Fix hotplug-suspend race during reboot
a > 93f92255a8e24 usb: xhci: Fix sleep in atomic context in xhci_free_strea=
ms()
a > 1c587a9ffd883 Bluetooth: btusb: fix use-after-free on registration fail=
ure
a just a robustness > bb63ea73d42fe mtd: slram: remove failed entries from =
the device list
a > eb25e1a785e08 iio: event: Fix event FIFO reset race

--LqqYR25ZPbdrxVGq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCasPb5QAKCRAw5/Bqldv6
8kQzAJ9Awj0RWtfI6njKzWeTmaBMU4NRyACgvgexLXKSHLM7Id6Myr+6UH+GE5Q=
=QAB8
-----END PGP SIGNATURE-----

--LqqYR25ZPbdrxVGq--

