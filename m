Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928A4C46467
	for <webhook@archiver.kernel.org>; Sun, 15 Jan 2023 22:10:03 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.152073.1673820594250640667
 for <cip-dev@lists.cip-project.org>;
 Sun, 15 Jan 2023 14:09:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 91F821C09F4; Sun, 15 Jan 2023 23:09:50 +0100 (CET)
Date: Sun, 15 Jan 2023 23:09:49 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Subject: Re: [cip-dev] 4.4 steps towards release
Message-ID: <Y8R5rSX/stuomgBP@duo.ucw.cz>
References: <Y7w4dfYgh7d10IdS@duo.ucw.cz>
 <588609118.480377.1673338487702@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ShijI7nDL8YFbr4x"
Content-Disposition: inline
In-Reply-To: <588609118.480377.1673338487702@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 15 Jan 2023 22:10:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10368


--ShijI7nDL8YFbr4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > - update v4.4.org
>=20
> Done.
> (For those playing along, that's at https://gitlab.com/cip-project/cip-ke=
rnel/lts-commit-list/-/raw/master/v4.4.org )
>=20
> > For patches that were applied automatically, I don't think we need to
> > additional review. For the others, I guess you should send list to
> > cip-dev, and someone will take a look.
>=20
> These are the patches I had to touch up manually:

Ok, let me take a look.

Ok, I'm a bit confused. I remember working these patches, and I do not
see your sign-offs. If you checked them, I guess I don't need to go
through them at this point.

 | 9cb1ee33e a36e50 .+ | drm/msm/hdmi: check return value after calling pla=
tform_get_resource_byname()
 | c132f2ba7 ddbd89 o  | swiotlb: fix info leak with DMA_FROM_DEVICE
 | fd97de9c7 901c72 o  | Reinstate some of "swiotlb: rework "fix info leak =
with DMA_FROM_DEVICE""
 | 136b47994 190cc8 o  | tcp: change source port randomizarion at connect()=
 time
 | 05a12e5c4 c579bd o  | tcp: add some entropy in __inet_hash_connect()
 | 576696ed0 b2d057 o  | secure_seq: use the 64 bits of the siphash for por=
t offset calculation
 | 2ed413f14 9e9b70 o  | tcp: use different parts of the port_offset for in=
dex and offset
 | aa7722529 ca7af0 o  | tcp: add small random increments to the source port
 | dd82067bd e92614 o  | tcp: dynamically allocate the perturb table used b=
y source ports
 | 3c78eea64 4c2c8f o  | tcp: increase source port perturb table to 2^16
 | a81a6b204 e81613 o  | tcp: drop the hash_32() part from the index calcul=
ation

These look okay:

a | ed71adaa8 17d3df o  | cifs: don't send down the destination address to =
sendmsg for a SOCK_STREAM
a | 6eb181a64 60deb9 o  | wifi: mac80211: Fix UAF in ieee80211_scan_rx()
a | e2b46cd57 81225b o+ | ipvlan: Fix out-of-bound bugs caused by unset skb=
->mac_header
a | f8a1ac3db 544042 .+ | can: gs_usb: gs_can_open(): fix race dev->can.sta=
te condition
a | 146357504 c292a3 o+ | nvme: Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls =
for nvme devices
a | 27c2c6d35 1b24a1 .+ | clk: iproc: Do not rely on node name for correct =
PLL setup
a | bb63454b6 21a87d o  | nilfs2: fix NULL pointer dereference at nilfs_bma=
p_lookup_at_level()
a | b63026b5e 723ac7 o  | nilfs2: replace WARN_ONs by nilfs_error for check=
point acquisition failure

Might be better to backport the dependencies... or ignore. Anyway, it
is good as it is too:

-- | c4a13e588 56e696 o  | ALSA: hda: Fix position reporting on Poulsbo

These look okay:

a | a9043a24c d325dc o  | nilfs2: fix use-after-free bug of struct nilfs_ro=
ot
a | cf3166691 620d5e .+ | wifi: rtl8xxxu: tighten bounds checking in rtl8xx=
xu_read_efuse()
a | c202cda08 668a8f o+ | drm/mipi-dsi: Detach devices when removing the ho=
st
a | 9183a37d3 551e32 .+ | HSI: omap_ssi_port: Fix dma_map_sg error check

You merged two patches here. I guess we can live with it.

-- | 7b0efe753 1c78f1 .+ | media: xilinx: vipp: Fix refcount leak in xvip_g=
raph_dma_init

These look ok:

a | 2319e8f80 9c6e09 o+ | ata: fix ata_id_has_devslp()
a | e01f64a34 630624 o+ | ata: fix ata_id_has_dipm()
a | d96732831 898ec8 o+ | dmaengine: ioat: stop mod_timer from resurrecting=
 deleted timer in __cleanup()
a | 508a9b8a8 110024 o  | openvswitch: Fix double reporting of drops in dro=
pwatch
a | 56761647e 3fd7bf o  | can: bcm: check the result of can_send() in bcm_c=
an_tx()
a | 0adda6e12 c44f15 .+ | arc: iounmap() arg is volatile
a | e1b5b0619 1f65ea .+ | media: vivid: dev->bitmap_cap wasn't freed in all=
 cases
a | 795afe0b9 8bdc2a o+ | net: sched: Fix use after free in red_enqueue()
a | d81370396 d37de9 o+ | btrfs: fix ulist leaks in error paths of qgroup s=
elf tests
a | dc30e05bb 3aff8a o+ | Bluetooth: L2CAP: Fix use-after-free caused by l2=
cap_reassemble_sdu

Patch "arc: iounmap() arg is volatile" is not something I'd bother
backporting.

I'll continue tommorow.

Thanks for doing this and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ShijI7nDL8YFbr4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY8R5rQAKCRAw5/Bqldv6
8vDgAJ4i2+Z+VDlz248641QRI+ofxqQLvwCbBOmqXHS418lzWu1oqifk1uTlETs=
=26E8
-----END PGP SIGNATURE-----

--ShijI7nDL8YFbr4x--

