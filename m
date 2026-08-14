Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F232C5CFDB
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 11:38:46 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11113.1786707518623944286
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Aug 2026 04:38:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=P1npl+0P;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88C8A11837F;
	Fri, 14 Aug 2026 13:38:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1786707512;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=xXqwDwbTeZeMStaq+bRx0LecEMJs7qTwrtpfuaMHGKU=;
	b=P1npl+0PLVfAJLE3UuA4hTTtMMTQr0z3Un4gZHPzXh9yLdRtDnWYbVyLhRJTublVGVrAKS
	wPuZPe3IoGq+KVWroq0dpDyFk1I2rMM0zvlhhQBbk7w1Ec3D3LBS/ZmB95CSMH+jChn86H
	JE0wABcMTx4VjxKUAM+SiBOKNKfi1znbyf0A6ujwztz6RSoS/NS1kaLSOl+QGm09DLaRjC
	MzGUK6YsK4b24Ct2GoxRNa6CdS18nH/WiE33OvH0BRQ2PzHBesjl2j/aOC4q8g7JHX/pyj
	J6cp/nobuJ4HqQy45Dm/SFXuWIkZB1AmTNglEQ5Kzm7H9jcgUZxJUsydAr2twg==
Date: Fri, 14 Aug 2026 13:38:27 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.4-st79, 4.4-cip114
Message-ID: <an7-M_D45SkSyucI@duo.ucw.cz>
References: <1456594884.221583.1786615509120@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sKhxtD2xJ5MDWJhQ"
Content-Disposition: inline
In-Reply-To: <1456594884.221583.1786615509120@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Aug 2026 11:38:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23935


--sKhxtD2xJ5MDWJhQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4 kernel release. As alw=
ays they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/ci=
p/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>

I have skipped batman for now, rest looks good to me.=20

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
								Pavel

a > f43fffe93e6a8 nfsd: fix posix_acl leak on SETACL decode failure
> 5fe3e0f96cabc batman-adv: bla: annotate lasttime access with READ/WRITE_O=
NCE
a > 9a9be3c47aa06 mtd: spi-nor: sst: Fix write enable before AAI sequence
a > 840c7bea0c5e9 sched: Use u64 for bandwidth ratio calculations
a preparation > aaf78df38c15f bnxt_en: Modify bnxt_disable_int_sync() to be=
 called more than once.
a just a robustness against fs corruption > 5e572058a9346 f2fs: validate AC=
L entry sizes in f2fs_acl_from_disk()
> 5366a10a971a4 batman-adv: tvlv: enforce 2-byte alignment
> 5d687ed16afba batman-adv: dat: prevent false sharing between VLANs
> 3e77213407fe6 batman-adv: tt: track roam count per VID
> 3d81ed513fc9e batman-adv: frag: ensure fragment is writable before modify=
ing TTL
> 92575ea68fa04 batman-adv: tt: reject oversized local TVLV buffers
a > 07df65dd3eef3 f2fs: fix incorrect file address mapping when inline inod=
e is unwritten
a > 126982eee7c4f dm-thin: fix metadata refcount underflow
a > 0275d20ddb91d btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU whi=
ch can lead to info-leak
a > 4f5d828b39324 fbcon: Avoid OOB font access if console rotation fails
a > 3331822db4e85 ceph: only d_add() negative dentries when they are unhash=
ed
a > 045ec6aa429b5 wifi: mwifiex: fix use-after-free in mwifiex_adapter_clea=
nup()
a > b56b15a4c9ea2 thermal: core: Fix thermal zone governor cleanup issues
a > 4cc65feb8ed2c fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signali=
ng
a > d1646af403aff mmc: sdhci: add signal voltage switch in sdhci_resume_host
a just a robustness against bad hardware > dce100a688c8d USB: serial: digi_=
acceleport: fix memory corruption with small endpoints
a optional locking. fun. > 052afb5d9f67b Bluetooth: hci_core: Fix use-after=
-free in vhci_flush()
a just a NAT tweak > 8a733c1ac979a netfilter: conntrack: tcp: do not force =
CLOSE on invalid-seq RST without direction check
a > 8ec3e1e63a29d xfrm: route MIGRATE notifications to caller's netns
a > 10411ac1d277d HID: wacom: Fix OOB write in wacom_hid_set_device_mode()
a > e79c2c6a7dd5a ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().
a just a robustness against hw > d7893890c93c5 USB: serial: omninet: fix me=
mory corruption with small endpoint
a > 4d349853d3d4a Bluetooth: btusb: Allow firmware re-download when version=
 matches
a > ccea3d2dd014f ALSA: usb-audio: fix null pointer dereference on pointer =
cs_desc
>=20

--sKhxtD2xJ5MDWJhQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCan7+MwAKCRAw5/Bqldv6
8lBhAKCcqZh+fPYUvdqlwigDIsK8czTF7gCbB+QYKSWqi8MNaGqZPbe2rWyYKoA=
=81St
-----END PGP SIGNATURE-----

--sKhxtD2xJ5MDWJhQ--

