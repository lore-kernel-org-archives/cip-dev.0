Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA428C3DA78
	for <webhook@archiver.kernel.org>; Tue, 17 Jan 2023 20:51:06 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.209100.1673988659168508035
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jan 2023 12:50:59 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: ucw.cz, ip: 46.255.230.98, mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 567101C09F6; Tue, 17 Jan 2023 21:50:55 +0100 (CET)
Date: Tue, 17 Jan 2023 21:50:54 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] 4.4 steps towards release
Message-ID: <Y8cKLnKsp+jiHUna@duo.ucw.cz>
References: <Y7w4dfYgh7d10IdS@duo.ucw.cz>
 <588609118.480377.1673338487702@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CfzCdnWQHYgIsrCx"
Content-Disposition: inline
In-Reply-To: <588609118.480377.1673338487702@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Jan 2023 20:51:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10376


--CfzCdnWQHYgIsrCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Thank you. I reviewed these, and they seem ok. I'd not bother
backporting patches marked (), but they should not harm.

a | b670996ca 038ee4 o  | serial: 8250: 8250_omap: Avoid RS485 RTS glitch o=
n ->set_termios()
() a | 8d4ceb13d e103ba o  | net: usb: qmi_wwan: add Telit 0x103a compositi=
on
a | 89840b12c f7e942 o  | btrfs: qgroup: fix sleep from invalid context bug=
 in btrfs_qgroup_inherit()
a | 2f2c59506 f0a0cc o  | nilfs2: fix NULL pointer dereference in nilfs_pal=
loc_commit_free_entry()
a | 02c468589 17b57b o  | arm: dts: rockchip: fix node name for hym8563 rtc
a | 1a1d9be7b ad7f40 .+ | xen/netback: Ensure protocol headers don't fall i=
n the non-linear area
a | b41eab579 74e7e1 .+ | xen/netback: don't call kfree_skb() with interrup=
ts disabled
a | a0e661a7d c981cd o+ | mmc: sdhci: Fix voltage switch delay
a | 4749c5cc1 45fecd .+ | gpio: amd8111: Fix PCI device reference count leak
a | 62ae69ea7 743117 o+ | tipc: Fix potential OOB in tipc_link_proto_rcv()
a | fbc70a04a 7dfa76 .+ | xen/netback: fix build warning
a | cb0f2530f 16d055 o  | udf: Discard preallocation before extending file =
with a hole
a | eee369a46 1f3868 o  | udf: Fix extending file within last block
a | bd1c152be 94a7ad .+ | media: vivid: fix compose size exceed boundary
() a | c2fe0cac3 c2f292 o+ | wifi: brcmfmac: Fix error return code in brcmf=
_sdio_download_firmware()
a | 3f418ad65 39c1eb o+ | Bluetooth: hci_core: don't call kfree_skb() under=
 spin_lock_irqsave()
a | 52dc66bf4 415565 o+ | scsi: fcoe: Fix transport not deattached when fco=
e_if_init() fails
() a | 694bd441a 04ba54 .+ | crypto: img-hash - Fix variable dereferenced b=
efore check 'hdev->req'
a | 2210b22c7 02cd30 .+ | cxl: fix possible null-ptr-deref in cxl_pci_init_=
afu|adapter()
a | c3595370a 6a46bf o  | binfmt_misc: fix shift-out-of-bounds in check_spe=
cial_flags
a | 548d04953 cfd3ff .  | clk: st: Fix memory leak in st_of_quadfs_setup()
() a | 215d58e8c 1db1f3 o  | HID: wacom: Ensure bootloader PID is usable in=
 hidraw mode
() a | 5f578bbe1 8508fa .  | ALSA: line6: correct midi status byte when rec=
eiving data from podxt
a | 887f47cf9 341097 o  | md: fix a crash in mempool_free

> There are also a few fixes for previous backports that need to be reviewe=
d:

And these look okay to me, too.

a > e80d1e591dbba xen/gntalloc: fix backport of "xen/gntalloc: don't use gn=
ttab_query_foreign_access()"
a > baf4fff4a69b7 Revert "hwmon: (sch56xx-common) Replace WDOG_ACTIVE with =
WDOG_HW_RUNNING"
a > a5387f2e581e5 xen/blkfront: fix backport of "xen/blkfront: don't use gn=
ttab_query_foreign_access() for mapped status"

Thanks and best regards,
									Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--CfzCdnWQHYgIsrCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY8cKLgAKCRAw5/Bqldv6
8nS4AJ46uzL1qPlL2cIIB8mwKgsC8TfC4gCfUy/dJETKReTiOzD5sHicW9dl8u0=
=7gju
-----END PGP SIGNATURE-----

--CfzCdnWQHYgIsrCx--

