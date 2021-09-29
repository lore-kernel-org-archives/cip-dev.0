Return-Path: <SRS0=AxNM=OT=lists.cip-project.org=bounce+64572+6761+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77FCC433EF
	for <cip-dev@archiver.kernel.org>; Wed, 29 Sep 2021 18:56:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15CFB61390
	for <cip-dev@archiver.kernel.org>; Wed, 29 Sep 2021 18:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 15CFB61390
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Ms9GYY4521723xIGi9HSSlBg; Wed, 29 Sep 2021 11:56:32 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.1811.1632941790614989594
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Sep 2021 11:56:31 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6D9731C0B87; Wed, 29 Sep 2021 20:56:25 +0200 (CEST)
Date: Wed, 29 Sep 2021 20:56:24 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
	yasin.demirci@siemens.com
Subject: [cip-dev] Quality of wireless drivers (rtl8821ae, ath10k, wl18xx)
Message-ID: <20210929185624.GA12171@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2G7r0UhCvi4BQqpHWxvPQHCXx4520388AA=
Content-Type: multipart/mixed; boundary="KDogS5In4Td7BBpwi3vz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632941792;
 bh=xJ/REt6BOSwmZPCYq2h6sqQV9rI7oeXbyx3wI8AaNzs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=lceKxM7FO0AUlt4rFMbQuQu6chZTdiPLHBu+H/oBW+oFHvTrpq3IxnNNiQ3Y64wKCnq
 dW00fQ1i9g1sWihKXy4VWXZvy2YGahtD0t7uNou3KnjL6m56l4X+8v5cKBEtfYvsD75hr
 qb7dsxZXa8h1ryNbqtNkXzS4xqP6RHTkuRk=
Message-ID: <20210929185624.UeJaD445YP2HcXdHYL5MFN-to2XuKrYjvyOxXqqzApc@z>

--KDogS5In4Td7BBpwi3vz
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On cip-members there's discussion about quality of selected wireless
drivers.

AFAICT we are reviewing changes to those drivers on -stable series
(good). We are not testing the drivers in any meaningful way, and it
may be good to mark them built-in (=3Dy, not modular) in some configs so
at least probing is tested. Proper testing would be quite hard, and
ammount of changes to them in stable probably does not require it.

To me it looks like wl18xx is getting very little changes; rtl8821ae
gets a bit more, but they are simple cleanups; only ath10k seems to be
under any kind of active development.

I have no experience with any of those drivers. I don't expect much
work would need to be done on any of these. If there's work I'd expect
ath10k to be slightly easier to work with.

Any comments?

Best regards,
								Pavel

* rtl8821ae (wifi + BT)

CONFIG_RTL8821AE
=2E/drivers/net/wireless/realtek/rtlwifi/rtl8821ae
=2E/drivers/bluetooth/btrtl.c

=2E/4.19.y-cip/x86/plathome_obsvx2_defconfig:CONFIG_RTL8821AE=3Dm
=2E/5.10.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_BT_RTL=3Dm

=3D> We should be reviewing it. We probably are not testing it at
all. Single change in 5.10-stable. Some developement from 4.19, but
looks mostly like staging-type cleanups.

* ath10k

CONFIG_ATH10K
=2E/drivers/net/wireless/ath/ath10k/

=2E/5.10.y-cip/arm64/qemu_arm64_defconfig:CONFIG_ATH10K=3Dm
=2E/5.10.y-cip/arm64/qemu_arm64_defconfig:CONFIG_ATH10K_PCI=3Dm
=2E/5.10.y-cip/x86/plathome_obsvx2_defconfig:CONFIG_ATH10K=3Dm
=2E/5.10.y-cip/x86/plathome_obsvx2_defconfig:CONFIG_ATH10K_PCI=3Dm
=2E/5.10.y-cip/arm/moxa_mxc_defconfig:CONFIG_ATH10K=3Dm
=2E/5.10.y-cip/arm/moxa_mxc_defconfig:CONFIG_ATH10K_DFS_CERTIFIED=3Dy

=3D> We should be reviewing it. We probably are not testing it at
all. 19 patches in 5.10-stable. Under active development, changes from 4.19.

* wl18xx

(wl1837 hardware is handled by wl18xx driver.)

CONFIG_WL18XX
CONFIG_BT_HCIUART_LL
=2E/drivers/net/wireless/ti/wl18xx
=2E/drivers/bluetooth/hci_ll.c

=2E/5.10.y-cip/arm64/qemu_arm64_defconfig:CONFIG_WL18XX=3Dm
=2E/5.10.y-cip/arm64/ctj_zynqmp_defconfig:CONFIG_WL18XX=3Dy
=2E/5.10.y-cip/arm/moxa_mxc_defconfig:CONFIG_WL18XX=3Dm

=2E/5.10.y-cip/arm64/qemu_arm64_defconfig:CONFIG_BT_HCIUART_LL=3Dy
=2E/5.10.y-cip/arm64/ctj_zynqmp_defconfig:CONFIG_BT_HCIUART_LL=3Dy

=3D> We should be reviewing it. We do some minimal testing by compiling
module in ZYNQMP configuration. No changes in 5.10-stable. Very few
changes from 4.19, mostly treewide cleanups.



--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYVS22AAKCRAw5/Bqldv6
8rpFAKCL7CPUHajARkDS4NBFzymflM6q5QCgtvDGNCA2sx2m3GvyyWfKm6xCTZE=
=DZ1J
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

--KDogS5In4Td7BBpwi3vz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6761): https://lists.cip-project.org/g/cip-dev/message/=
6761
Mute This Topic: https://lists.cip-project.org/mt/85956701/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--KDogS5In4Td7BBpwi3vz--
