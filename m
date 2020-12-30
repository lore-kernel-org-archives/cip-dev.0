Return-Path: <SRS0=MoPp=GC=lists.cip-project.org=bounce+64572+5981+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E8BC433DB
	for <cip-dev@archiver.kernel.org>; Wed, 30 Dec 2020 11:19:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692CC20759
	for <cip-dev@archiver.kernel.org>; Wed, 30 Dec 2020 11:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692CC20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5981+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 34s7YY4521723xxYLfTci8Tv; Wed, 30 Dec 2020 03:19:31 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.5358.1609327169895872707
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Dec 2020 03:19:30 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 75DE61C0B80; Wed, 30 Dec 2020 12:19:25 +0100 (CET)
Date: Wed, 30 Dec 2020 12:19:24 +0100
From: "Pavel Machek" <pavel@denx.de>
To: iwamatsu@nigauri.org, cip-dev@lists.cip-project.org
Subject: [cip-dev] Reviewing 4.4/4.19/5.10.4
Message-ID: <20201230111924.GA2691@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KboKHg5QyoNAinmDq1ZrFmKJx4520388AA=
Content-Type: multipart/mixed; boundary="tjJmqwXLxpVQi7S7QFV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609327171;
 bh=8us1cFGu6r9OuFDC3gbA4yFn3GmPPCOXiHc4LCjRmCk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=n9GsfVlv5WU3rNm5JhaWFIKE0mwM5RJ6sZPZImIarvg72U/LQMbGmgynNfNJcfKcZzT
 fTW2Uj6OoMmLq2b7cI9vr5bwr0VwCTkeGf6lLdhdeio9M28JZZgj7md+pFDcoPo53Zi23
 +McxyOrYBgTHtpfl3T3ryinGVVCVEw0HNgk=

--tjJmqwXLxpVQi7S7QFV2
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have started reviewing all three series "at the same time", always
reviewing the oldest patch... because that's what we'll need to do in
future. Here are my results so far.

What each line means is that $COMMIT in $VERS stable tree, which is
backport of mainline $MAINLI, was reviewed by me with result $R.

If $R starts if "a", I determined patch is okay ("ACK: pavel"), "v"
means that I reviewed older version and should run interdiff to check
it is same, and anything else means that I need to look at the patch
some more.

Best regards,
								Pavel


R COMMIT    MAINLI RE VERS  TITLE
 |83998aacb 0a4e66 o: 5.10| hwmon: (k10temp) Remove support for displaying =
voltage and current on Zen CPUs
v |4dd51b507 4e19d5 .: 5.10| drm/gma500: fix double free of gma_connector
v |8613a8488 4e19d5 .: 4.19| drm/gma500: fix double free of gma_connector
!c/e |cb8ca3ec9 4e19d5 .:  4.4| drm/gma500: fix double free of gma_connector
 |df745e5b2 f091d7 o: 5.10| iio: adc: at91_adc: add Kconfig dep on the OF s=
ymbol and remove of_match_ptr()
 |7d7eefbdb bf296b .: 5.10| drm/aspeed: Fix Kconfig warning & subsequent bu=
ild errors
 |4db5405a7 e2dae6 .: 5.10| drm/mcde: Fix handling of platform_get_irq() er=
ror
v |94119d4e4 77bb5a .: 5.10| drm/tve200: Fix handling of platform_get_irq()=
 error
a |6a7524b46 77bb5a .: 4.19| drm/tve200: Fix handling of platform_get_irq()=
 error
 |8e5d44dc9 67d3dc o: 5.10| arm64: dts: renesas: hihope-rzg2-ex: Drop rxc-s=
kew-ps from ethernet-phy node
 |6dcfe20ea 53e573 o: 5.10| arm64: dts: renesas: cat875: Remove rxc-skew-ps=
 from ethernet-phy node
? |d7634a85f cf25d8 .: 5.10| soc: renesas: rmobile-sysc: Fix some leaks in =
rmobile_init_pm_domains()
a |b12e872bd cf25d8 o: 4.19| soc: renesas: rmobile-sysc: Fix some leaks in =
rmobile_init_pm_domains()
 |116861ce1 400784 .: 5.10| soc: mediatek: Check if power domains can be po=
wered on at boot time
a but code is crazy with all the negations |04cf83d36 400784 .: 4.19| soc: =
mediatek: Check if power domains can be powered on at boot time
 |d5c500974 e55c56 .: 5.10| arm64: dts: mediatek: mt8183: fix gce incorrect=
 mbox-cells value
 |c17aa3632 4af5c6 .: 5.10| arm64: dts: ipq6018: update the reserved-memory=
 node
 |b503d81e6 228813 .: 5.10| arm64: dts: qcom: sc7180: Fix one forgotten int=
erconnect reference
v |3d0a12fe8 4b6ea8 .: 5.10| soc: qcom: geni: More properly switch to DMA m=
ode
a |c6f18d4c6 4b6ea8 .: 4.19| soc: qcom: geni: More properly switch to DMA m=
ode
 |7a6ca3805 9cb4c6 .: 5.10| Revert "i2c: i2c-qcom-geni: Fix DMA transfer ra=
ce"
v |b3f3bd671 53839b  : 5.10| RDMA/bnxt_re: Set queue pair state when being =
queried
a |56f8b7029 53839b  : 4.19| RDMA/bnxt_re: Set queue pair state when being =
queried
 |402a58632 ba1c30 o: 5.10| rtc: pcf2127: fix pcf2127_nvmem_read/write() re=
turns
 |f8121aecd b898d5  : 5.10| RDMA/bnxt_re: Fix entry size during SRQ create
v |8c4972354 83370b o: 5.10| selinux: fix error initialization in inode_doi=
nit_with_dentry()
a known buggy, fixed by subsequent patch |6861b00db 83370b o: 4.19| selinux=
: fix error initialization in inode_doinit_with_dentry()
 |857d4f815 886f82 .: 5.10| ARM: dts: aspeed-g6: Fix the GPIO memory size
v |99fc6ed99 9e1cc9 o: 5.10| ARM: dts: aspeed: s2600wf: Fix VGA memory regi=
on location
a bad example, not known to cause real problem |74a66141d 9e1cc9 o: 4.19| A=
RM: dts: aspeed: s2600wf: Fix VGA memory region location
 |72395bd2d 533349  : 5.10| RDMA/core: Fix error return in _ib_modify_qp()
 |f8020ad41 bb3ab2  : 5.10| RDMA/rxe: Compute PSN windows correctly
 |3d24f862c bb3ab2  : 4.19| RDMA/rxe: Compute PSN windows correctly
v |6dc10f7b3 1fcd00 o: 5.10| x86/mm/ident_map: Check for errors from ident_=
pud_init()
a |5b6928ef9 1fcd00 o: 4.19| x86/mm/ident_map: Check for errors from ident_=
pud_init()
v |839c732c4 4e79f0 o: 5.10| ARM: p2v: fix handling of LPAE translation in =
BE mode
v |edc66cf76 4e79f0 o: 4.19| ARM: p2v: fix handling of LPAE translation in =
BE mode
! code no longer depends on endianity? |74c8c372e 4e79f0 o:  4.4| ARM: p2v:=
 fix handling of LPAE translation in BE mode
 |2312cfa0b 2b3062  : 5.10| RDMA/rtrs-clt: Remove destroy_con_cq_qp in case=
 route resolving failed
 |24ad5b304 f553e7  : 5.10| RDMA/rtrs-clt: Missing error from rtrs_rdma_con=
n_established
 |180514aab d715ff  : 5.10| RDMA/rtrs-srv: Don't guard the whole __alloc_sr=
v with srv_mutex
v |1810f918a 26573a o: 5.10| x86/apic: Fix x2apic enablement without interr=
upt remapping
! support for different config, not a bugfix |91f6ccbe0 26573a o: 4.19| x86=
/apic: Fix x2apic enablement without interrupt remapping
 |0b61c60d7 bcc96d .: 5.10| ASoC: qcom: fix unsigned int bitwidth compared =
to less than zero
v |3c4fc4980 a57415 o: 5.10| sched/deadline: Fix sched_dl_global_validate()
a not a minimum fix |b07ebebd6 a57415 o: 4.19| sched/deadline: Fix sched_dl=
_global_validate()
v |ab738ea14 345a95 o: 5.10| sched: Reenable interrupts in do_sched_yield()
!!a not sure it fixes a real bug, why not for 4.4? |404b6a93b 345a95 o: 4.1=
9| sched: Reenable interrupts in do_sched_yield()
 |364447a05 a110f3 .: 5.10| drm/amdgpu: fix incorrect enum type
v |272f52dd7 195404 .: 5.10| crypto: talitos - Endianess in current_desc_hd=
r()
!a I'd put the conversion on the other side... |4b800ef67 195404 .: 4.19| c=
rypto: talitos - Endianess in current_desc_hdr()
v |69ae28a7a 023761 .: 5.10| crypto: talitos - Fix return type of current_d=
esc_hdr()
v |a231171bd 023761 .: 4.19| crypto: talitos - Fix return type of current_d=
esc_hdr()
!a the code is quite crazy, should it do plain inl? |0fa650db4 023761 .:  4=
=2E4| crypto: talitos - Fix return type of current_desc_hdr()
v |d63f7cc3c c98e23 .: 5.10| crypto: inside-secure - Fix sizeof() mismatch
a does not fix user-visible bug |d3260d052 c98e23 .: 4.19| crypto: inside-s=
ecure - Fix sizeof() mismatch
 |d1bc16b6d 93c021 .: 5.10| ASoC: sun4i-i2s: Fix lrck_period computation fo=
r I2S justified mode
 |dd76c2b1b a0b21e .: 5.10| drm/msm: Add missing stub definition
 |360d73a40 14f100 .: 5.10| ARM: dts: aspeed: tiogapass: Remove vuart
a just a cleanup |4143d9405 dbb600 .: 5.10| drm/amdgpu: fix build_coefficie=
nts() argument
n wrong, 4.19 still uses bool |01f67d1cf dbb600 .: 4.19| drm/amdgpu: fix bu=
ild_coefficients() argument
v |7b2830335 3c0b97 .: 5.10| powerpc/64: Set up a kernel stack for secondar=
ies before cpu_restore()
a |1621f63e5 3c0b97 .: 4.19| powerpc/64: Set up a kernel stack for secondar=
ies before cpu_restore()
v |25e09a198 ee5558 .: 5.10| spi: img-spfi: fix reference leak in img_spfi_=
resume
v |099628cc5 ee5558 .: 4.19| spi: img-spfi: fix reference leak in img_spfi_=
resume
a |f3124cca3 ee5558 .:  4.4| spi: img-spfi: fix reference leak in img_spfi_=
resume
 |f685cf198 3acc45 o: 5.10| f2fs: call f2fs_get_meta_page_retry for nat page
 |64a80058b fc3325  : 5.10| RDMA/mlx5: Fix corruption of reg_pages in mlx5_=
ib_rereg_user_mr()
 |ef4c0d9e7 9b0a78  : 5.10| perf test: Use generic event for expand_libpfm_=
events()
 |48238a2bc 6625e2 .: 5.10| drm/msm/dp: DisplayPort PHY compliance tests fi=
xup
 |fab4a3e96 5047ab .: 5.10| drm/msm/dsi_pll_7nm: restore VCO rate during re=
store_state
v |b7dc6db2e a4ccc3 .: 5.10| drm/msm/dsi_pll_10nm: restore VCO rate during =
restore_state
a |7e83225bd a4ccc3 .: 4.19| drm/msm/dsi_pll_10nm: restore VCO rate during =
restore_state
 |da34a9d12 cccded .: 5.10| drm/msm/dpu: fix clock scaling on non-sc7180 bo=
ard
 |b9827a0fd c02bb1 o: 5.10| spi: spi-mem: fix reference leak in spi_mem_acc=
ess_start
 |5e6e1b094 077054 o: 5.10| scsi: aacraid: Improve compat_ioctl handlers
 |9fed73c63 b507cb o: 5.10| pinctrl: core: Add missing #ifdef CONFIG_GPIOLIB
v |e7ad30b54 4c22b8 o: 5.10| ASoC: pcm: DRAIN support reactivation
v |3a382e93f 4c22b8 o: 4.19| ASoC: pcm: DRAIN support reactivation
a |4e8753653 4c22b8 o:  4.4| ASoC: pcm: DRAIN support reactivation
 |9281d1f57 c2530c .: 5.10| drm/bridge: tpd12s015: Fix irq registering in t=
pd12s015_probe
 |7476a01fc d81236  : 5.10| libbpf: Fix BTF data layout checks and allow em=
pty BTF
 |3e11a9af0 519a0d .: 5.10| crypto: arm64/poly1305-neon - reorder PAC authe=
ntication with SP update
 |d8cc47ac6 a2715f o: 5.10| crypto: arm/aes-neonbs - fix usage of cbc(aes) =
fallback
 |e483ae3f3 ab95bd o: 5.10| crypto: caam - fix printing on xts fallback all=
ocation error path
v |96cb0c4df 200ea5 o: 5.10| selinux: fix inode_doinit_with_dentry() LABEL_=
INVALID error handling
! |c87a2dbd2 200ea5 o: 4.19| selinux: fix inode_doinit_with_dentry() LABEL_=
INVALID error handling
 |7855aca27 ba5c25 o: 5.10| nl80211/cfg80211: fix potential infinite loop
 |46d146619 900ccd .: 5.10| spi: stm32: fix reference leak in stm32_spi_res=
ume
 |933510c95 f0e5ba  : 5.10| bpf: Fix tests for local_storage
 |4f781c4cf 15af36 o: 5.10| x86/mce: Correct the detection of invalid notif=
ier priorities
 |8bc9aea04 991fcb o: 5.10| drm/edid: Fix uninitialized variable in drm_cvt=
_modes()
 |259c4e185 383a32 .: 5.10| ath11k: Initialize complete alpha2 for regulato=
ry change
 |28a716f3b 6189be .: 5.10| ath11k: Fix number of rules in filtered ETSI re=
gdomain
 |8cfa2fffc 36c7c6 .: 5.10| ath11k: fix wmi init configuration
 |bd795054b 9db946 o: 5.10| brcmfmac: Fix memory leak for unpaired brcmf_{a=
lloc/free}
v |0f598cd03 73bc75 o: 5.10| arm64: dts: exynos: Include common syscon rest=
art/poweroff for Exynos7
a cleanup and feature, not a bugfix |8b75cd512 73bc75 o: 4.19| arm64: dts: =
exynos: Include common syscon restart/poweroff for Exynos7
v |fa117df17 e1e47f o: 5.10| arm64: dts: exynos: Correct psci compatible us=
ed on Exynos7
a |8c1cb713d e1e47f o: 4.19| arm64: dts: exynos: Correct psci compatible us=
ed on Exynos7
 |5c9a85b9e ab6fd5 o: 5.10| drm/panel: simple: Add flags to boe_nv133fhm_n61
v |5e38b9359 6dfccd o: 5.10| Bluetooth: Fix null pointer dereference in hci=
_event_packet()
v |edafaf6d6 6dfccd o: 4.19| Bluetooth: Fix null pointer dereference in hci=
_event_packet()
!c/e |7a7a9e3a1 6dfccd o:  4.4| Bluetooth: Fix null pointer dereference in =
hci_event_packet()
 |23ecf3ab5 1fb17d o: 5.10| Bluetooth: Fix: LL PRivacy BLE device fails to =
connect
v |5d5781993 855af2 .: 5.10| Bluetooth: hci_h5: fix memory leak in h5_close
a |1ed1af1eb 855af2 .: 4.19| Bluetooth: hci_h5: fix memory leak in h5_close
 |4ea97ff39 88e141 .: 5.10| spi: stm32-qspi: fix reference leak in stm32 qs=
pi operations
v |f34dffa23 45c0cb o: 5.10| spi: spi-ti-qspi: fix reference leak in ti_qsp=
i_setup
v |e7b7f44f2 45c0cb o: 4.19| spi: spi-ti-qspi: fix reference leak in ti_qsp=
i_setup
a |aa70b62f7 45c0cb o:  4.4| spi: spi-ti-qspi: fix reference leak in ti_qsp=
i_setup
 |95bb147c8 702b15 .: 5.10| spi: mt7621: fix missing clk_disable_unprepare(=
) on error in mt7621_spi_probe
v |ff2bf3cdc 763eab .: 5.10| spi: tegra20-slink: fix reference leak in slin=
k ops of tegra20
v |d2c8b86e3 763eab .: 4.19| spi: tegra20-slink: fix reference leak in slin=
k ops of tegra20
a |7a2a88ffc 763eab .:  4.4| spi: tegra20-slink: fix reference leak in slin=
k ops of tegra20
v |5736997ad 3482e7 .: 5.10| spi: tegra20-sflash: fix reference leak in teg=
ra_sflash_resume
v |0a410bbf6 3482e7 .: 4.19| spi: tegra20-sflash: fix reference leak in teg=
ra_sflash_resume
a |8d41f4c33 3482e7 .:  4.4| spi: tegra20-sflash: fix reference leak in teg=
ra_sflash_resume
v |9d1043f0d a04218 .: 5.10| spi: tegra114: fix reference leak in tegra spi=
 ops
v |d6acdbafe a04218 .: 4.19| spi: tegra114: fix reference leak in tegra spi=
 ops
a |2e34e0503 a04218 .:  4.4| spi: tegra114: fix reference leak in tegra spi=
 ops
v |9bcb384dd 9bb9ef .: 5.10| spi: bcm63xx-hsspi: fix missing clk_disable_un=
prepare() on error in bcm63xx_hsspi_resume
a |b787f651d 9bb9ef .: 4.19| spi: bcm63xx-hsspi: fix missing clk_disable_un=
prepare() on error in bcm63xx_hsspi_resume
 |d62945725 1dcbdd o: 5.10| spi: imx: fix reference leak in two imx operati=
ons
 |b1a0651cd 4e59dd .: 5.10| ASoC: qcom: common: Fix refcounting in qcom_snd=
_parse_of()
 |5e059cbf2 c134d1 .: 5.10| ath11k: Handle errors if peer creation fails
v |685e5893e fa74cb o: 5.10| mwifiex: fix mwifiex_shutdown_sw() causing sw =
reset failure
a |09068a1cf fa74cb o: 4.19| mwifiex: fix mwifiex_shutdown_sw() causing sw =
reset failure
 |7070cce49 e8b0b9 .: 5.10| drm/msm/a6xx: Clear shadow on suspend
 |c81b21b00 5771de .: 5.10| drm/msm/a5xx: Clear shadow on suspend
 |cafc98a99 929499 .: 5.10| firmware: tegra: fix strncpy()/strncat() confus=
ion
 |3a8d88856 19e52b .: 5.10| drm/msm/dp: return correct connection status af=
ter suspend
 |fc1b41c03 ea5303 .: 5.10| drm/msm/dp: skip checking LINK_STATUS_UPDATED b=
it
 |5e1600dde e8c765 .: 5.10| drm/msm/dp: do not notify audio subsystem if si=
nk doesn't support audio
 |166855508 93f20e  : 5.10| selftests/run_kselftest.sh: fix dry-run typo
 |7169fdfbe 58cfa4  : 5.10| selftest/bpf: Add missed ip6ip6 test back
 |40344f007 b8161c .: 5.10| ASoC: wm8994: Fix PM disable depth imbalance on=
 error
v |cb3880417 193aa0 .: 5.10| ASoC: wm8998: Fix PM disable depth imbalance o=
n error
a |d1cc9fc67 193aa0 .: 4.19| ASoC: wm8998: Fix PM disable depth imbalance o=
n error
 |4a0f318e5 e40627 .: 5.10| spi: sprd: fix reference leak in sprd_spi_remove
 |b8e37d47f 66ab33 .: 5.10| virtiofs fix leak in setup
v |39c5a00cb c0c5a6 o: 5.10| net: evaluate net.ipvX.conf.all.ignore_routes_=
with_linkdown
v |6f78da0ec c0c5a6 o: 4.19| net: evaluate net.ipvX.conf.all.ignore_routes_=
with_linkdown
a |0ad6b411d c0c5a6 o:  4.4| net: evaluate net.ipvX.conf.all.ignore_routes_=
with_linkdown
v |a9e7bec20 1af531 o: 5.10| net: evaluate net.ipv4.conf.all.proxy_arp_pvlan
v |4f36059f5 1af531 o: 4.19| net: evaluate net.ipv4.conf.all.proxy_arp_pvlan
a |736c65951 1af531 o:  4.4| net: evaluate net.ipv4.conf.all.proxy_arp_pvlan
v |45fc838d4 5e7aac .: 5.10| ASoC: arizona: Fix a wrong free in wm8997_probe
a |6ee4e8c48 5e7aac .: 4.19| ASoC: arizona: Fix a wrong free in wm8997_probe
v |48f1db6e9 fbb7dc  : 5.10| RDMa/mthca: Work around -Wenum-conversion warn=
ing
v |d11ce6e5d fbb7dc  : 4.19| RDMa/mthca: Work around -Wenum-conversion warn=
ing
a just a warning workaround |1f95a8f30 fbb7dc  :  4.4| RDMa/mthca: Work aro=
und -Wenum-conversion warning
 |0bf2a0db3 358f0a .: 5.10| ASoC: SOF: Intel: fix Kconfig dependency for SN=
D_INTEL_DSP_CONFIG
 |9169380d6 cfbf17 o: 5.10| arm64: dts: ti: k3-am65*/j721e*: Fix unit addre=
ss format error for dss node
v |0cc0b2480 3a5fe2  : 5.10| MIPS: BCM47XX: fix kconfig dependency bug for =
BCM47XX_BCMA
v |f2a378cf3 3a5fe2  : 4.19| MIPS: BCM47XX: fix kconfig dependency bug for =
BCM47XX_BCMA
a |f9821b092 3a5fe2  :  4.4| MIPS: BCM47XX: fix kconfig dependency bug for =
BCM47XX_BCMA
 |e934d72da 3f66bf .: 5.10| drm/amdgpu: fix compute queue priority if num_k=
cq is less than 4
 |453a3ad5e c1995e .: 5.10| soc: ti: omap-prm: Do not check rstst bit on de=
assert if already deasserted
 |7c81e7ecd 6569e3 o: 5.10| crypto: Kconfig - CRYPTO_MANAGER_EXTRA_TESTS re=
quires the manager
v |c193a89ed 3b5c13 .: 5.10| crypto: qat - fix status check in qat_hal_put_=
rel_rd_xfer()
a |3983ccbaf 3b5c13 .: 4.19| crypto: qat - fix status check in qat_hal_put_=
rel_rd_xfer()
 |61c621e32 6bbdb4 .: 5.10| firmware: arm_scmi: Fix missing destroy_workque=
ue()
 |c058977e4 a7319c o: 5.10| drm/udl: Fix missing error code in udl_handle_d=
amage()
v |e86a403b0 395265  : 5.10| staging: greybus: codecs: Fix reference counte=
r leak in error handling
a |ea4d46fef 395265  : 4.19| staging: greybus: codecs: Fix reference counte=
r leak in error handling
 |66b270cb9 ab5b76  : 5.10| staging: gasket: interrupt: fix the missed even=
tfd_ctx_put() in gasket_interrupt.c
 |2f583029c ab5b76  : 4.19| staging: gasket: interrupt: fix the missed even=
tfd_ctx_put() in gasket_interrupt.c
 |1f3134ac5 ae5b17 o: 5.10| scripts: kernel-doc: Restore anonymous enum par=
sing
 |70f72a9de c4cb77 .: 5.10| drm/amdkfd: Put ACPI table after using it
 |32567570d e0243e .: 5.10| ionic: use mc sync for multicast filters
 |aa3fcc8f8 e94f76 .: 5.10| ionic: flatten calls to ionic_lif_rx_mode
 |b499e64a7 81dbc2 .: 5.10| ionic: change set_rx_mode from_ndo to can_sleep
v |ace684a03 a08ad6 .: 5.10| media: tm6000: Fix sizeof() mismatches
a fixes bug with no user-visible impact |6949cda91 a08ad6 .: 4.19| media: t=
m6000: Fix sizeof() mismatches
 |9bc2fcd39 f28a81 .: 5.10| media: platform: add missing put_device() call =
in mtk_jpeg_clk_init()
 |49f840d5c 5d4fa2 .: 5.10| media: mtk-vcodec: add missing put_device() cal=
l in mtk_vcodec_init_dec_pm()
v |7e13d05ef 27c394 .: 5.10| media: mtk-vcodec: add missing put_device() ca=
ll in mtk_vcodec_release_dec_pm()
a |23c12780b 27c394 .: 4.19| media: mtk-vcodec: add missing put_device() ca=
ll in mtk_vcodec_release_dec_pm()
 |258dd2098 4affaf .: 5.10| media: mtk-vcodec: add missing put_device() cal=
l in mtk_vcodec_init_enc_pm()
 |0db958791 69baf3 o: 5.10| media: v4l2-fwnode: Return -EINVAL for invalid =
bus-type
 |9062f6520 b3cc73 o: 5.10| media: v4l2-fwnode: v4l2_fwnode_endpoint_parse =
caller must init vep argument
 |6eb33a11d 68579b .: 5.10| media: ov5640: fix support of BT656 bus mode
 |1107f0fcb 4cbbe2  : 5.10| media: staging: rkisp1: cap: fix runtime PM imb=
alance on error
 |cef670e1e 940727  : 5.10| media: cedrus: fix reference leak in cedrus_sta=
rt_streaming
 |0113fe788 0d72f4 .: 5.10| media: platform: add missing put_device() call =
in mtk_jpeg_probe() and mtk_jpeg_remove()
 |2d7fcc4d4 21926d .: 5.10| media: venus: core: change clk enable and disab=
le order in resume and suspend
 |339a8c284 9e8efd .: 5.10| media: venus: core: vote for video-mem path
 |304d5c479 e44fb0 .: 5.10| media: venus: core: vote with average bandwidth=
 and peak bandwidth as zero
 |e33a8f2ac c80a0c  : 5.10| RDMA/cma: Add missing error handling of listen_=
id
v |cedc7a6ed 299fe9 o: 5.10| ASoC: meson: fix COMPILE_TEST error
a |aa26d5e72 299fe9 o: 4.19| ASoC: meson: fix COMPILE_TEST error
 |2ec7aef71 1241f0 o: 5.10| spi: dw: fix build error by selecting MULTIPLEX=
ER
v |668dfbfa5 2e4209 o: 5.10| scsi: core: Fix VPD LUN ID designator prioriti=
es
! long |de2af3412 2e4209 o: 4.19| scsi: core: Fix VPD LUN ID designator pri=
orities
 |b05eb886c eff5ce .: 5.10| media: venus: put dummy vote on video-mem path =
after last session release
v |fa05885ec dcdff7 .: 5.10| media: solo6x10: fix missing snd_card_free in =
error handling case
v |2155e259d dcdff7 .: 4.19| media: solo6x10: fix missing snd_card_free in =
error handling case
!c/e|15cce2b2e dcdff7 .:  4.4| media: solo6x10: fix missing snd_card_free i=
n error handling case
v |f498ea9e5 ba2364 .: 5.10| video: fbdev: atmel_lcdfb: fix return error co=
de in atmel_lcdfb_of_init()
a |d78beccb3 ba2364 .: 4.19| video: fbdev: atmel_lcdfb: fix return error co=
de in atmel_lcdfb_of_init()
 |4d34e6af8 fcc541 .: 5.10| mmc: sdhci: tegra: fix wrong unit with busy_tim=
eout
v |4cb64f1dd 723ae8 o: 5.10| drm/omap: dmm_tiler: fix return error code in =
omap_dmm_probe()
v |b02829626 723ae8 o: 4.19| drm/omap: dmm_tiler: fix return error code in =
omap_dmm_probe()
a |050fa6884 723ae8 o:  4.4| drm/omap: dmm_tiler: fix return error code in =
omap_dmm_probe()
 |9fb7bc7fd fa62ee .: 5.10| drm/meson: Free RDMA resources after tearing do=
wn DRM
 |ef8ca8fd7 e78ad1 .: 5.10| drm/meson: Unbind all connectors on module remo=
val
 |ba5c6b91c 0405f9 .: 5.10| drm/meson: dw-hdmi: Register a callback to disa=
ble the regulator
 |f3860245e b33340 .: 5.10| drm/meson: dw-hdmi: Ensure that clocks are enab=
led before touching the TOP registers
 |e15987d0f 9a2072 o: 5.10| ASoC: intel: SND_SOC_INTEL_KEEMBAY should depen=
d on ARCH_KEEMBAY
 |89acde034 68dd9d .: 5.10| iommu/vt-d: include conditionally on CONFIG_INT=
EL_IOMMU_SVM
v |16409a049 e52cd6 o: 5.10| Input: ads7846 - fix race that causes missing =
releases
a |7a3542898 e52cd6 o: 4.19| Input: ads7846 - fix race that causes missing =
releases
v |c61b4641d 820830 o: 5.10| Input: ads7846 - fix integer overflow on Rt ca=
lculation
v |d07025e08 820830 o: 4.19| Input: ads7846 - fix integer overflow on Rt ca=
lculation
a |700eeb05f 820830 o:  4.4| Input: ads7846 - fix integer overflow on Rt ca=
lculation
v |6e73d332a 03e2c9 o: 5.10| Input: ads7846 - fix unaligned access on 7845
v |46165dbdc 03e2c9 o: 4.19| Input: ads7846 - fix unaligned access on 7845
a |d14046542 03e2c9 o:  4.4| Input: ads7846 - fix unaligned access on 7845
 |030c00ced 9b627c .: 5.10| bus: mhi: core: Remove double locking from mhi_=
driver_remove()
 |a08510e0d f4d0b3 .: 5.10| bus: mhi: core: Fix null pointer access when pa=
rsing MHI configuration
v |a97e7e095 5a5693 .: 5.10| usb/max3421: fix return error code in max3421_=
probe()
a |fb6769e86 5a5693 .: 4.19| usb/max3421: fix return error code in max3421_=
probe()
v |98c2b5ce3 03fc41 .: 5.10| spi: mxs: fix reference leak in mxs_spi_probe
a |06fd3bcbf 03fc41 .: 4.19| spi: mxs: fix reference leak in mxs_spi_probe
 |8847b460a 6016df  : 5.10| selftests/bpf: Fix broken riscv build
 |72d5c762c a7223f .: 5.10| powerpc: Avoid broken GCC __attribute__((optimi=
ze))
v |6ee46cba1 786651 .: 5.10| powerpc/feature: Fix CPU_FTRS_ALWAYS by removi=
ng CPU_FTRS_GENERIC_32
v |5ad8f5d56 786651 .: 4.19| powerpc/feature: Fix CPU_FTRS_ALWAYS by removi=
ng CPU_FTRS_GENERIC_32
a |f59b70fa8 786651 .:  4.4| powerpc/feature: Fix CPU_FTRS_ALWAYS by removi=
ng CPU_FTRS_GENERIC_32
 |869c72da9 cbee02 .: 5.10| ARM: dts: tacoma: Fix node vs reg mismatch for =
flash memory
 |cdcab647c a40fda .: 5.10| Revert "powerpc/pseries/hotplug-cpu: Remove dou=
ble free in error path"
 |71ba353bd 027717 .: 5.10| powerpc/powernv/sriov: fix unsigned int win com=
pared to less than zero
 |731c08d5a 9a4632 .: 5.10| mfd: htc-i2cpld: Add the missed i2c_put_adapter=
() in htcpld_register_chip_i2c()
 |ef8facf14 de1292 o: 5.10| mfd: MFD_SL28CPLD should depend on ARCH_LAYERSC=
APE
 |c0d3fac04 d75846 .: 5.10| mfd: stmfx: Fix dev_err_probe() call in stmfx_c=
hip_init()
 |23b1c37aa 14639a .: 5.10| mfd: cpcap: Fix interrupt regression with regma=
p clear_ack
 |a8e9d24a9 8de0c9 o: 5.10| EDAC/mce_amd: Use struct cpuinfo_x86.cpu_die_id=
 for AMD NodeId
 |6eb51a386 fd62de o: 5.10| scsi: ufs: Avoid to call REQ_CLKS_OFF to CLKS_O=
FF
 |6cd8779d4 8eb456 o: 5.10| scsi: ufs: Fix clkgating on/off
 |3aec674c1 6dbce0 o: 5.10| rcu: Allow rcu_irq_enter_check_tick() from NMI
 |f7db9200e d2098b o: 5.10| rcu,ftrace: Fix ftrace recursion
 |d53cb33fe 56292e o: 5.10| rcu/tree: Defer kvfree_rcu() allocation to a cl=
ean context
v |dc938af2d 5bdad8 .: 5.10| crypto: crypto4xx - Replace bitwise OR with lo=
gical OR in crypto4xx_build_pd
a |37ed34bc1 5bdad8 .: 4.19| crypto: crypto4xx - Replace bitwise OR with lo=
gical OR in crypto4xx_build_pd
v |b33a1c06d ff8107 .: 5.10| crypto: omap-aes - Fix PM disable depth imbala=
nce in omap_aes_probe
!! missing pm_runtime_put? |88f6e026d ff8107 .: 4.19| crypto: omap-aes - Fi=
x PM disable depth imbalance in omap_aes_probe
 |53cb9df7b 732b76 .: 5.10| crypto: sun8i-ce - fix two error path's memory =
leak
v |922b85fbf 440408 o: 5.10| spi: fix resource leak for drivers without .re=
move callback
a |82927245b 440408 o: 4.19| spi: fix resource leak for drivers without .re=
move callback
 |837a5caec 1dfeea .: 5.10| drm/meson: dw-hdmi: Disable clocks on driver te=
ardown
 |9f7d0cbd1 2b6cb8 .: 5.10| drm/meson: dw-hdmi: Enable the iahb clock early=
 enough
 |ab3925fcd f83c37 o: 5.10| PCI: Disable MSI for Pericom PCIe-USB adapter
 |668c8d12d ddaff0 .: 5.10| PCI: brcmstb: Initialize "tmp" before use
v |18158b716 ec8684 .: 5.10| soc: ti: knav_qmss: fix reference leak in knav=
_queue_probe
v |92166fe9e ec8684 .: 4.19| soc: ti: knav_qmss: fix reference leak in knav=
_queue_probe
a |17eeb1c7f ec8684 .:  4.4| soc: ti: knav_qmss: fix reference leak in knav=
_queue_probe
v |0d912207b b4fa73 .: 5.10| soc: ti: Fix reference imbalance in knav_dma_p=
robe
v |4e3d2b0b3 b4fa73 .: 4.19| soc: ti: Fix reference imbalance in knav_dma_p=
robe
! c/e |4c8d952d1 b4fa73 .:  4.4| soc: ti: Fix reference imbalance in knav_d=
ma_probe
v |9a0b24a16 4cba39 .: 5.10| drivers: soc: ti: knav_qmss_queue: Fix error r=
eturn code in knav_queue_probe
v |8830e7a05 4cba39 .: 4.19| drivers: soc: ti: knav_qmss_queue: Fix error r=
eturn code in knav_queue_probe
a |dca3114ed 4cba39 .:  4.4| drivers: soc: ti: knav_qmss_queue: Fix error r=
eturn code in knav_queue_probe
 |7dd826fff a161ff .: 5.10| soc: qcom: initialize local variable
 |df6b3fd2b d371a9 .: 5.10| arm64: dts: qcom: sm8250: correct compatible fo=
r sm8250-mtp
 |2cc509a04 4e8692 .: 5.10| arm64: dts: qcom: msm8916-samsung-a2015: Disabl=
e muic i2c pin bias
v |4828ea3a2 59bbf8 .: 5.10| Input: omap4-keypad - fix runtime PM error han=
dling
! three fixes in one, long |2c56b0529 59bbf8 .: 4.19| Input: omap4-keypad -=
 fix runtime PM error handling
 |4d03eca6f bae69b o: 5.10| clk: meson: Kconfig: fix dependency for G12A
 |71051225b ba3e4a  : 5.10| staging: mfd: hi6421-spmi-pmic: fix error retur=
n code in hi6421_spmi_pmic_probe()
 |6b3872d05 11af6d .: 5.10| ath11k: Fix the rx_filter flag setting for peer=
 rssi stats
 |e9c90dbd7 6d8285  : 5.10| RDMA/cxgb4: Validate the number of CQEs
 |071063b33 6d8285  : 4.19| RDMA/cxgb4: Validate the number of CQEs
 |662094a7c e6db81 .: 5.10| soundwire: Fix DEBUG_LOCKS_WARN_ON for uninitia=
lized attribute
 |9a95bb7a0 6de7ed .: 5.10| pinctrl: sunxi: fix irq bank map for the Allwin=
ner A100 pin controller
v |3ff5260a1 e3e9ce .: 5.10| memstick: fix a double-free bug in memstick_ch=
eck
v |c0fd09583 e3e9ce .: 4.19| memstick: fix a double-free bug in memstick_ch=
eck
n broken! will cause NULL pointer dereferences dues to host->card =3D NULL =
|df1dc3847 e3e9ce .:  4.4| memstick: fix a double-free bug in memstick_check
 |0706af284 5ba629 .: 5.10| ARM: dts: at91: sam9x60: add pincontrol for USB=
 Host
v |37a9d8c06 be4dd2 o: 5.10| ARM: dts: at91: sama5d4_xplained: add pincontr=
ol for USB Host
v |dc367b853 be4dd2 o: 4.19| ARM: dts: at91: sama5d4_xplained: add pincontr=
ol for USB Host
a comment says only required for 5.7 and above |5163a469e be4dd2 o:  4.4| A=
RM: dts: at91: sama5d4_xplained: add pincontrol for USB Host
v |48dee927a e1062f o: 5.10| ARM: dts: at91: sama5d3_xplained: add pincontr=
ol for USB Host
v |7d060318a e1062f o: 4.19| ARM: dts: at91: sama5d3_xplained: add pincontr=
ol for USB Host
a comment says only required for 5.7 and above |7f1de72ec e1062f o:  4.4| A=
RM: dts: at91: sama5d3_xplained: add pincontrol for USB Host
 |2f0569151 d7b819 .: 5.10| mmc: pxamci: Fix error return code in pxamci_pr=
obe
 |87a7411ae 37ff14 o: 5.10| brcmfmac: fix error return code in brcmf_cfg802=
11_connect()
v |f6126ddf8 a31eb6 .: 5.10| orinoco: Move context allocation after process=
ing the skb
v |321f00105 a31eb6 .: 4.19| orinoco: Move context allocation after process=
ing the skb
! c/e |c1ecac778 a31eb6 .:  4.4| orinoco: Move context allocation after pro=
cessing the skb
 |b3bb27334 31e07a .: 5.10| qtnfmac: fix error return code in qtnf_pcie_pro=
be()
 |60d8e35e1 fb21d1 .: 5.10| rsi: fix error return code in rsi_reset_card()
v |4ae71fe52 7ec8a9 .: 5.10| cw1200: fix missing destroy_workqueue() on err=
or in cw1200_init_common
v |e4b23adf4 7ec8a9 .: 4.19| cw1200: fix missing destroy_workqueue() on err=
or in cw1200_init_common
a |7a9cdaf86 7ec8a9 .:  4.4| cw1200: fix missing destroy_workqueue() on err=
or in cw1200_init_common
v |37464a85a c95e65 .: 5.10| dmaengine: mv_xor_v2: Fix error return code in=
 mv_xor_v2_probe()
a |4c49ce4ea c95e65 .: 4.19| dmaengine: mv_xor_v2: Fix error return code in=
 mv_xor_v2_probe()
 |f64877ea5 95e6f8 o: 5.10| arm64: dts: qcom: sdm845: Limit ipa iommu strea=
ms
 |36a4e6489 311066 .: 5.10| leds: netxbig: add missing put_device() call in=
 netxbig_leds_get_of_pdata()
 |9fe0cc013 6d8d01 .: 5.10| leds: lp50xx: Fix an error handling path in 'lp=
50xx_probe_dt()'
 |727e8da68 98650b .: 5.10| leds: turris-omnia: check for LED_COLOR_ID_RGB =
instead LED_COLOR_ID_MULTI
 |f2de0b907 6b26c1 o: 5.10| arm64: tegra: Fix DT binding for IO High Voltag=
e entry
 |a68ecd81a dd37d2  : 5.10| RDMA/cma: Fix deadlock on &lock in rdma_cma_lis=
ten_on_all() error unwind
 |1f347fb1e 47edc0 .: 5.10| soundwire: qcom: Fix build failure when slimbus=
 is module
 |858b8c1fe 59cb40 .: 5.10| drm/imx/dcss: fix rotations for Vivante tiled f=
ormats
v |b9a10a8d4 abf287 .: 5.10| media: siano: fix memory leak of debugfs membe=
rs in smsdvb_hotplug
a |2cb4eea05 abf287 .: 4.19| media: siano: fix memory leak of debugfs membe=
rs in smsdvb_hotplug
a |99ecdb5cb 2bf504 .: 5.10| platform/x86: mlx-platform: Remove PSU EEPROM =
=66rom default platform configuration
a just a support for (future) hardware |01e0cefe4 2bf504 .: 4.19| platform/=
x86: mlx-platform: Remove PSU EEPROM from default platform configuration
v |967de49dc 912b34 .: 5.10| platform/x86: mlx-platform: Remove PSU EEPROM =
=66rom MSN274x platform configuration
a just a support for (future) hardware |92468d135 912b34 .: 4.19| platform/=
x86: mlx-platform: Remove PSU EEPROM from MSN274x platform configuration
 |ebe582538 8f3483 .: 5.10| arm64: dts: qcom: sc7180: limit IPA iommu strea=
ms
 |e1633a837 7406c0  : 5.10| RDMA/hns: Only record vlan info for HIP08
 |b966e829c fba429  : 5.10| RDMA/hns: Fix missing fields in address vector
 |2f9336e0a 3631da  : 5.10| RDMA/hns: Avoid setting loopback indicator when=
 smac is same as dmac
 |a02c68ff6 6e4e63 .: 5.10| serial: 8250-mtk: Fix reference leak in mtk8250=
_probe
v |7f85bbde2 0afe0a .: 5.10| samples: bpf: Fix lwt_len_hist reusing previou=
s BPF map
a |ce514e780 0afe0a .: 4.19| samples: bpf: Fix lwt_len_hist reusing previou=
s BPF map
 |4026021d1 eeb76a .: 5.10| media: imx214: Fix stop streaming
v |324c56f44 f0e822 .: 5.10| mips: cdmm: fix use-after-free in mips_cdmm_bu=
s_discover
v |af6ba670a f0e822 .: 4.19| mips: cdmm: fix use-after-free in mips_cdmm_bu=
s_discover
a |b479b341c f0e822 .:  4.4| mips: cdmm: fix use-after-free in mips_cdmm_bu=
s_discover
v |95d403509 9b1b0c .: 5.10| media: max2175: fix max2175_set_csm_mode() err=
or code
a |1c3da07b8 9b1b0c .: 4.19| media: max2175: fix max2175_set_csm_mode() err=
or code
v |de79a448a 39014c .: 5.10| slimbus: qcom-ngd-ctrl: Avoid sending power re=
quests without QMI
a |52e206273 39014c .: 4.19| slimbus: qcom-ngd-ctrl: Avoid sending power re=
quests without QMI
 |142ec903d b47a98  : 5.10| RDMA/core: Track device memory MRs
 |40d51fa10 414562 .: 5.10| drm/mediatek: Use correct aliases name for ovl
v |93d07f5ba 41fff6 .: 5.10| HSI: omap_ssi: Don't jump to free ID in ssi_ad=
d_controller()
a |62c51da96 41fff6 .: 4.19| HSI: omap_ssi: Don't jump to free ID in ssi_ad=
d_controller()
v |1fe45b8eb 7f2447 o: 5.10| ARM: dts: Remove non-existent i2c1 from 98dx32=
36
a |c34cf3873 7f2447 o: 4.19| ARM: dts: Remove non-existent i2c1 from 98dx32=
36
 |bd95746f5 3aa669 .: 5.10| arm64: dts: armada-3720-turris-mox: update ethe=
rnet-phy handle name
 |33f40f1b2 d4e9e7 .: 5.10| power: supply: bq25890: Use the correct range f=
or IILIM register
v |d542083ff 4076a0 o: 5.10| arm64: dts: rockchip: Set dr_mode to "host" fo=
r OTG on rk3328-roc-cc
a |ac82872d4 4076a0 o: 4.19| arm64: dts: rockchip: Set dr_mode to "host" fo=
r OTG on rk3328-roc-cc
 |308f3d8ae 4b0a56 o: 5.10| power: supply: max17042_battery: Fix current_{a=
vg,now} hiding with no current sense
v |c78d478a7 a0f1cc .: 5.10| power: supply: axp288_charger: Fix HP Pavilion=
 x2 10 DMI matching
a |e5ef5e9f1 a0f1cc .: 4.19| power: supply: axp288_charger: Fix HP Pavilion=
 x2 10 DMI matching
v |b720aff15 b2f6cb .: 5.10| power: supply: bq24190_charger: fix reference =
leak
a |384b90f5c b2f6cb .: 4.19| power: supply: bq24190_charger: fix reference =
leak
v |e1f0cd215 4615fb o: 5.10| genirq/irqdomain: Don't try to free an interru=
pt that has no mapping
a |a972c527b 4615fb o: 4.19| genirq/irqdomain: Don't try to free an interru=
pt that has no mapping
 |9ee258664 d0570a .: 5.10| arm64: dts: ls1028a: fix ENETC PTP clock input
 |41516971a 588b17 .: 5.10| arm64: dts: ls1028a: fix FlexSPI clock input
 |690a7052a 91ab1c .: 5.10| arm64: dts: freescale: sl28: combine SPI MTD pa=
rtitions
 |ab3db908b 4ea0bf .: 5.10| phy: tegra: xusb: Fix usb_phy device driver fie=
ld
 |6e424ec0e 11d0e4 .: 5.10| arm64: dts: qcom: c630: Polish i2c-hid devices
 |d56896275 f55d37 .: 5.10| arm64: dts: qcom: c630: Fix pinctrl pins proper=
ties
v |264189e46 6534aa o: 5.10| PCI: Bounds-check command-line resource alignm=
ent requests
a just a robustness, not a minimum fix |16f0fbf3e 6534aa o: 4.19| PCI: Boun=
ds-check command-line resource alignment requests
v |8689a49e7 cc73eb o: 5.10| PCI: Fix overflow in command-line resource ali=
gnment requests
a |7f703eedb cc73eb o: 4.19| PCI: Fix overflow in command-line resource ali=
gnment requests
v |dcd7c78f9 a3ff52 .: 5.10| PCI: iproc: Fix out-of-bound array accesses
a |9d625f60b a3ff52 .: 4.19| PCI: iproc: Fix out-of-bound array accesses
 |b3dd0b7e7 89bbca .: 5.10| PCI: iproc: Invalidate correct PAXB inbound win=
dows
v |b2781e981 b6c605 o: 5.10| arm64: dts: meson: fix spi-max-frequency on Kh=
adas VIM2
a just a performance improvement |163732162 b6c605 o: 4.19| arm64: dts: mes=
on: fix spi-max-frequency on Khadas VIM2
 |6bfee9305 b6a1c8 .: 5.10| arm64: dts: meson-sm1: fix typo in opp table
 |a8024927d 28f851 .: 5.10| soc: amlogic: canvas: add missing put_device() =
call in meson_canvas_get()
 |bc220a5c3 2ebde9 .: 5.10| scsi: hisi_sas: Fix up probe error handling for=
 v3 hw
 |0bee5af20 4ba9e5 o: 5.10| scsi: pm80xx: Do not sleep in atomic context
 |5f86d37a7 2c2b3a .: 5.10| spi: spi-fsl-dspi: Use max_native_cs instead of=
 num_chipselect to set SPI_MCR
v |5f635ad84 851a95 o: 5.10| ARM: dts: at91: at91sam9rl: fix ADC triggers
a |8a3f80758 851a95 o: 4.19| ARM: dts: at91: at91sam9rl: fix ADC triggers
 |0c477d7cb 0fd017  : 5.10| RDMA/hns: Fix 0-length sge calculation error
 |13e397ca6 d34895  : 5.10| RDMA/hns: Bugfix for calculation of extended sge
 |4d3befbd0 9905f7 .: 5.10| mailbox: arm_mhu_db: Fix mhu_db_shutdown by rep=
lacing kfree with devm_kfree
 |5d734d43b e04e60 .: 5.10| soundwire: master: use pm_runtime_set_active() =
on add
v |ca38acab9 2425cc .: 5.10| platform/x86: dell-smbios-base: Fix error retu=
rn code in dell_smbios_init
a |0cdaf8e9d 2425cc .: 4.19| platform/x86: dell-smbios-base: Fix error retu=
rn code in dell_smbios_init
 |7d592feb3 0d7f24 .: 5.10| ASoC: Intel: Boards: tgl_max98373: update TDM s=
lot_width
 |9ef548861 909a0a .: 5.10| media: max9271: Fix GPIO enable/disable
 |9ebe6315d 7fe1d4 .: 5.10| media: rdacm20: Enable GPIO1 explicitly
 |8e8ccd244 1ed36e .: 5.10| media: i2c: imx219: Selection compliance fixes
 |4f51237ea f4d291 .: 5.10| ath11k: Don't cast ath11k_skb_cb to ieee80211_t=
x_info.control
 |3484ac880 5da7ac .: 5.10| ath11k: Reset ath11k_skb_cb before setting new =
flags
 |446cb542e e7bcc1 .: 5.10| ath11k: Fix an error handling path
v |bd455a7b4 c7cee9 o: 5.10| ath10k: Fix the parsing error in service avail=
able event
a just a support for new hw |9450ed890 c7cee9 o: 4.19| ath10k: Fix the pars=
ing error in service available event
v |0ee126a6b ed3573 .: 5.10| ath10k: Fix an error handling path
a |ccaae9064 ed3573 .: 4.19| ath10k: Fix an error handling path
v |1744db778 6364e6 .: 5.10| ath10k: Release some resources in an error han=
dling path
a |9e7295a3c 6364e6 .: 4.19| ath10k: Release some resources in an error han=
dling path
 |0d788d339 e4c722 o: 5.10| SUNRPC: rpc_wake_up() should wake up tasks in t=
he correct order
v |a51c7f08e 05ad91 o: 5.10| NFSv4.2: condition READDIR's mask for security=
 label based on LSM state
v |229895036 05ad91 o: 4.19| NFSv4.2: condition READDIR's mask for security=
 label based on LSM state
a not a minimum fix, just a performance improvement |6d4687863 05ad91 o:  4=
=2E4| NFSv4.2: condition READDIR's mask for security label based on LSM sta=
te
v |2841e3cac d5aa6b o: 5.10| SUNRPC: xprt_load_transport() needs to support=
 the netid "rdma6"
! long |be322523a d5aa6b o: 4.19| SUNRPC: xprt_load_transport() needs to su=
pport the netid "rdma6"
 |f8a011964 046e5c o: 5.10| NFSv4: Fix the alignment of page data in the ge=
tdeviceinfo reply
 |90b37bb2d 35a6d3 o: 5.10| net: sunrpc: Fix 'snprintf' return value check =
in 'do_xprt_debugfs'
v |5fdddaca7 9b82d8 o: 5.10| lockd: don't use interval-based rebinding over=
 TCP
v |e76d63ee3 9b82d8 o: 4.19| lockd: don't use interval-based rebinding over=
 TCP
a |17eec4d40 9b82d8 o:  4.4| lockd: don't use interval-based rebinding over=
 TCP
v |208ffaeed bf701b o: 5.10| NFS: switch nfsiod to be an UNBOUND workqueue.
v |0ff0760a8 bf701b o: 4.19| NFS: switch nfsiod to be an UNBOUND workqueue.
a just a performance problem, will that mean new thread for every work item=
? |51f6de720 bf701b o:  4.4| NFS: switch nfsiod to be an UNBOUND workqueue.
 |ce9525175 2c0734  : 5.10| selftests/seccomp: Update kernel config
v |dd87f3297 7b06a5 o: 5.10| vfio-pci: Use io_remap_pfn_range() for PCI IO =
memory
a |76a970b28 7b06a5 o: 4.19| vfio-pci: Use io_remap_pfn_range() for PCI IO =
memory
 |76ffc18b2 bce776 .: 5.10| hwmon: (ina3221) Fix PM usage counter unbalance=
 in ina3221_write_enable
 |6eb9dd0d3 89ff60 o: 5.10| f2fs: fix double free of unicode map
 |14d6ac59c eb08c4 .: 5.10| media: tvp5150: Fix wrong return value of tvp51=
50_parse_dt()
v |9a41257a3 8e4d86 .: 5.10| media: saa7146: fix array overflow in vidioc_s=
_audio()
v |968068efa 8e4d86 .: 4.19| media: saa7146: fix array overflow in vidioc_s=
_audio()
a |351b6ae1d 8e4d86 .:  4.4| media: saa7146: fix array overflow in vidioc_s=
_audio()
 |c410e94d9 f75e7d .: 5.10| powerpc/perf: Fix crash with is_sier_available =
when pmu is not set
 |243925dd8 fe18a3 .: 5.10| powerpc/64: Fix an EMIT_BUG_ENTRY in head_64.S
 |caa170d9b f3e904 .: 5.10| powerpc/xmon: Fix build failure for 8xx
 |f114902ca d3afd2 .: 5.10| powerpc/perf: Fix to update radix_scope_qual in=
 power10
 |29986ccf9 e924be .: 5.10| powerpc/perf: Update the PMU group constraints =
for l2l3 events in power10
 |36c4f9c8a 0263bb .: 5.10| powerpc/perf: Fix the PMU group constraints for=
 threshold events in power10
 |1a73ce7fd c1e6ca .: 5.10| clocksource/drivers/orion: Add missing clk_disa=
ble_unprepare() on error path
v |44ec896ad eee422 .: 5.10| clocksource/drivers/cadence_ttc: Fix memory le=
ak in ttc_setup_clockevent()
!c/e |c5d0924a6 eee422 .: 4.19| clocksource/drivers/cadence_ttc: Fix memory=
 leak in ttc_setup_clockevent()
 |b7476c03e 5bd7cb .: 5.10| clocksource/drivers/ingenic: Fix section mismat=
ch
 |3f3614cf6 ab3105 o: 5.10| clocksource/drivers/riscv: Make RISCV_TIMER dep=
ends on RISCV_SBI
 |abcc7803f 929c1f .: 5.10| arm64: mte: fix prctl(PR_GET_TAGGED_ADDR_CTRL) =
if TCF0=3DNONE
 |2e38084bd 017829 .: 5.10| iio: hrtimer-trigger: Mark hrtimer to expire in=
 hard interrupt context
 |f8b2e7c39 9cf309  : 5.10| libbpf: Sanitise map names before pinning
 |cbcfc8582 ab8a9b .: 5.10| ARM: dts: at91: sam9x60ek: remove bypass proper=
ty
v |183b44fab 9b5dcc o: 5.10| ARM: dts: at91: sama5d2: map securam as device
a |9b4277e04 9b5dcc o: 4.19| ARM: dts: at91: sama5d2: map securam as device
 |d18343545 7d2c6b o: 5.10| scripts: kernel-doc: fix parsing function-like =
typedefs
 |d16a4878a 12cc12 o: 5.10| bpf: Fix bpf_put_raw_tracepoint()'s use of __mo=
dule_address()
 |fd7fa9a8c eceae7  : 5.10| selftests/bpf: Fix invalid use of strncat in te=
st_sockmap
v |e80b1b90e 89cce2 .: 5.10| pinctrl: falcon: add missing put_device() call=
 in pinctrl_falcon_probe()
v |add21a2ee 89cce2 .: 4.19| pinctrl: falcon: add missing put_device() call=
 in pinctrl_falcon_probe()
a |24ff37886 89cce2 .:  4.4| pinctrl: falcon: add missing put_device() call=
 in pinctrl_falcon_probe()
 |8e46a10f5 c2867b .: 5.10| soc: rockchip: io-domain: Fix error return code=
 in rockchip_iodomain_probe()
v |95603cb5f 94dad6 o: 5.10| arm64: dts: rockchip: Fix UART pull-ups on rk3=
328
a |72c833a59 94dad6 o: 4.19| arm64: dts: rockchip: Fix UART pull-ups on rk3=
328
v |908955ecb db29d3 .: 5.10| memstick: r592: Fix error return in r592_probe=
()
v |d01e4fc38 db29d3 .: 4.19| memstick: r592: Fix error return in r592_probe=
()
a |a2137446c db29d3 .:  4.4| memstick: r592: Fix error return in r592_probe=
()
 |4a9988bf4 d121f1  : 5.10| MIPS: Don't round up kernel sections size for m=
emblock_add()
 |f99845316 1c79a1 .: 5.10| mt76: mt7663s: fix a possible ple quota underfl=
ow
 |26813e771 5efbe3 .: 5.10| mt76: mt7915: set fops_sta_stats.owner to THIS_=
MODULE
 |1cb4c4261 f9df08 .: 5.10| mt76: set fops_tx_stats.owner to THIS_MODULE
 |ae31fdcd3 5f0ce5 .: 5.10| mt76: dma: fix possible deadlock running mt76_d=
ma_cleanup
v |e9b0db27c 907af0 .: 5.10| net/mlx5: Properly convey driver version to fi=
rmware
!! strange hack |e91b5a7c0 907af0 .: 4.19| net/mlx5: Properly convey driver=
 version to firmware
 |00985a0bd bc348d .: 5.10| mt76: fix memory leak if device probing fails
 |c5af02b1d 930e0e .: 5.10| mt76: fix tkip configuration for mt7615/7663 de=
vices
v |72611c81d 1c1fb2 .: 5.10| ASoC: jz4740-i2s: add missed checks for clk_ge=
t()
v |f9070d37c 1c1fb2 .: 4.19| ASoC: jz4740-i2s: add missed checks for clk_ge=
t()
a |867bdaa71 1c1fb2 .:  4.4| ASoC: jz4740-i2s: add missed checks for clk_ge=
t()
 |eb162844e 7e20ae .: 5.10| ASoC: q6afe-clocks: Add missing parent clock ra=
te
v |9a754f8ca 4d7659 o: 5.10| dm ioctl: fix error return code in target_mess=
age
v |1c2f64857 4d7659 o: 4.19| dm ioctl: fix error return code in target_mess=
age
a |3ac648a10 4d7659 o:  4.4| dm ioctl: fix error return code in target_mess=
age
 |09631dab6 7061b8 .: 5.10| ASoC: cros_ec_codec: fix uninitialized memory r=
ead
 |30a961f71 292753 o: 5.10| ASoC: atmel: mchp-spdifrx needs COMMON_CLK
 |2fdc3c112 b1b8eb o: 5.10| ASoC: qcom: fix QDSP6 dependencies, attempt #3
 |8ee69ae4b f5f6e0 o: 5.10| phy: mediatek: allow compile-testing the hdmi p=
hy
 |fdb10b0fb 51e339 o: 5.10| phy: renesas: rcar-gen3-usb2: disable runtime p=
m in case of failure
 |edf9054d3 d77d22 o: 5.10| memory: ti-emif-sram: only build for ARMv7
 |a1665d37f 4bfa07 .: 5.10| memory: jz4780_nemc: Fix potential NULL derefer=
ence in jz4780_nemc_probe()
 |db4843efc 7cc29f .: 5.10| drm/msm: a5xx: Make preemption reset case reent=
rant
 |b86aee383 e319a1 o: 5.10| drm/msm: add IOMMU_SUPPORT dependency
 |5c367772a d8cc39 o: 5.10| clocksource/drivers/arm_arch_timer: Use stable =
count reader in erratum sne
v |3d96bbe37 8b7770 o: 5.10| clocksource/drivers/arm_arch_timer: Correct fa=
ult programming of CNTKCTL_EL1.EVNTI
v |f6738d8eb 8b7770 o: 4.19| clocksource/drivers/arm_arch_timer: Correct fa=
ult programming of CNTKCTL_EL1.EVNTI
!a not a minimum fix |2a41f2a4f 8b7770 o:  4.4| clocksource/drivers/arm_arc=
h_timer: Correct fault programming of CNTKCTL_EL1.EVNTI
 |02e49a7b3 925a5b .: 5.10| cpufreq: ap806: Add missing MODULE_DEVICE_TABLE
v |b80b58760 943377 .: 5.10| cpufreq: highbank: Add missing MODULE_DEVICE_T=
ABLE
v |c1003fc7f 943377 .: 4.19| cpufreq: highbank: Add missing MODULE_DEVICE_T=
ABLE
a |d7230c264 943377 .:  4.4| cpufreq: highbank: Add missing MODULE_DEVICE_T=
ABLE
v |609894850 af6eca .: 5.10| cpufreq: mediatek: Add missing MODULE_DEVICE_T=
ABLE
a |7020f918c af6eca .: 4.19| cpufreq: mediatek: Add missing MODULE_DEVICE_T=
ABLE
 |9440d64ff a5a603 .: 5.10| cpufreq: qcom: Add missing MODULE_DEVICE_TABLE
v |7974e3d81 183747 .: 5.10| cpufreq: st: Add missing MODULE_DEVICE_TABLE
a |f2d1ac401 183747 .: 4.19| cpufreq: st: Add missing MODULE_DEVICE_TABLE
 |d6bf2f476 af2096 .: 5.10| cpufreq: sun50i: Add missing MODULE_DEVICE_TABLE
v |61324479c b9acab .: 5.10| cpufreq: loongson1: Add missing MODULE_ALIAS
v |2b28f6ab3 b9acab .: 4.19| cpufreq: loongson1: Add missing MODULE_ALIAS
a |7b536a8d8 b9acab .:  4.4| cpufreq: loongson1: Add missing MODULE_ALIAS
v |2bb4f1712 c0382d .: 5.10| cpufreq: scpi: Add missing MODULE_ALIAS
v |13f66e941 c0382d .: 4.19| cpufreq: scpi: Add missing MODULE_ALIAS
a |09570fb51 c0382d .:  4.4| cpufreq: scpi: Add missing MODULE_ALIAS
 |dc3fc77d5 d15183 .: 5.10| cpufreq: vexpress-spc: Add missing MODULE_ALIAS
 |77fb59319 fc928b o: 5.10| cpufreq: imx: fix NVMEM_IMX_OCOTP dependency
 |38d134fde 2c9cfb .: 5.10| macintosh/adb-iop: Always wait for reply messag=
e from IOP
 |a8e0b2ff7 10199e .: 5.10| macintosh/adb-iop: Send correct poll command
 |f908ccb41 6c9179  : 5.10| staging: bcm2835: fix vchiq_mmal dependencies
 |f77091910 e77b25  : 5.10| staging: greybus: audio: Fix possible leak free=
 widgets in gbaudio_dapm_free_controls
 |8685b0aab e748ed .: 5.10| spi: dw: Fix error return code in dw_spi_bt1_pr=
obe()
 |b711c8207 d1e9d2 o: 5.10| Bluetooth: btusb: Add the missed release_firmwa=
re() in btusb_mtk_setup_firmware()
 |9b36c618f b73b57 .: 5.10| Bluetooth: btmtksdio: Add the missed release_fi=
rmware() in mtk_setup_firmware()
 |04d8ca81e f6b8c6 o: 5.10| Bluetooth: sco: Fix crash when using BT_SNDMTU/=
BT_RCVMTU option
 |7f4730eeb 64e8a6 .: 5.10| block/rnbd-clt: Dynamically alloc buffer for pa=
thname & blk_symlink_name
 |843c55138 733c15 .: 5.10| block/rnbd: fix a null pointer dereference on d=
ev->blk_symlink_name
 |86e36591b d74e0a o: 5.10| Bluetooth: btusb: Fix detection of some fake CS=
R controllers with a bcdDevice val of 0x0134
 |d6f02c2f3 a43279 .: 5.10| platform/x86: intel-vbtn: Fix SW_TABLET_MODE al=
ways reporting 1 on some HP x360 models
 |40962d09a 05c2a6 .: 5.10| adm8211: fix error return code in adm8211_probe=
()
 |ea8f8eeb8 989d4b .: 5.10| mtd: spi-nor: sst: fix BPn bits for the SST25VF=
064C
 |d510c9729 bdb1a7 .: 5.10| mtd: spi-nor: ignore errors in spi_nor_unlock_a=
ll()
 |4e3454cef e6204d .: 5.10| mtd: spi-nor: atmel: remove global protection f=
lag
 |6c0101295 8c174d .: 5.10| mtd: spi-nor: atmel: fix unlock_all() for AT25F=
S010/040
 |5ffbd5920 1c7412 .: 5.10| arm64: dts: meson: g12b: odroid-n2: fix PHY dea=
ssert timing requirements
 |6d30b9786 c183c4 o: 5.10| arm64: dts: meson: fix PHY deassert timing requ=
irements
 |b89f281b0 656ab1 o: 5.10| ARM: dts: meson: fix PHY deassert timing requir=
ements
 |ffd63b4cd 3d07c3 .: 5.10| arm64: dts: meson: g12a: x96-max: fix PHY deass=
ert timing requirements
 |cd8de0d6b 9e454e .: 5.10| arm64: dts: meson: g12b: w400: fix PHY deassert=
 timing requirements
 |c026a87b8 e81bed .: 5.10| clk: fsl-sai: fix memory leak
v |6702d2859 62eebd .: 5.10| scsi: qedi: Fix missing destroy_workqueue() on=
 error in __qedi_probe
!c/e |c834fc8f3 62eebd .: 4.19| scsi: qedi: Fix missing destroy_workqueue()=
 on error in __qedi_probe
v |510be461d 97031c o: 5.10| scsi: pm80xx: Fix error return in pm8001_pci_p=
robe()
v |e7c16dc42 97031c o: 4.19| scsi: pm80xx: Fix error return in pm8001_pci_p=
robe()
a |6c5a53540 97031c o:  4.4| scsi: pm80xx: Fix error return in pm8001_pci_p=
robe()
 |de6bc5e5a 6dc1c7 o: 5.10| scsi: iscsi: Fix inappropriate use of put_devic=
e()
v |96e083a79 d9a928 o: 5.10| seq_buf: Avoid type mismatch for seq_buf_init
v |9bb7e87f2 d9a928 o: 4.19| seq_buf: Avoid type mismatch for seq_buf_init
a just a W=3D2 warning fix |a0ad89528 d9a928 o:  4.4| seq_buf: Avoid type m=
ismatch for seq_buf_init
v |b6382678f d4fc94 o: 5.10| scsi: fnic: Fix error return code in fnic_prob=
e()
v |2c37db34e d4fc94 o: 4.19| scsi: fnic: Fix error return code in fnic_prob=
e()
a |b04fea2e5 d4fc94 o:  4.4| scsi: fnic: Fix error return code in fnic_prob=
e()
v |2fd34c1c8 ba4939 .: 5.10| platform/x86: mlx-platform: Fix item counter a=
ssignment for MSN2700, MSN24xx systems
a |4d2afff39 ba4939 .: 4.19| platform/x86: mlx-platform: Fix item counter a=
ssignment for MSN2700, MSN24xx systems
 |d85cae334 cf7917 .: 5.10| platform/x86: mlx-platform: Fix item counter as=
signment for MSN2700/ComEx system
 |f8bb860a4 f77ac2 o: 5.10| ARM: 9030/1: entry: omit FP emulation for UND e=
xceptions taken in kernel mode
v |746478b98 52719f .: 5.10| powerpc/pseries/hibernation: drop pseries_susp=
end_begin() from suspend ops
v |d338bbf80 52719f .: 4.19| powerpc/pseries/hibernation: drop pseries_susp=
end_begin() from suspend ops
! |0e39d8666 52719f .:  4.4| powerpc/pseries/hibernation: drop pseries_susp=
end_begin() from suspend ops
v |dcf770dbd b86645 .: 5.10| powerpc/pseries/hibernation: remove redundant =
cacheinfo update
a |32cc58c0e b86645 .: 4.19| powerpc/pseries/hibernation: remove redundant =
cacheinfo update
 |046aee9d7 db972a .: 5.10| powerpc/powermac: Fix low_sleep_handler with CO=
NFIG_VMAP_STACK
 |f88ba1343 b097ef .: 5.10| drm/mediatek: avoid dereferencing a null hdmi_p=
hy on an error message
 |753bbd0b6 95d3be .: 5.10| ASoC: amd: change clk_get() to devm_clk_get() a=
nd add missed checks
 |a58deb6f5 45fe7b .: 5.10| coresight: remove broken __exit annotations
 |a040b9697 3cea33 .: 5.10| ASoC: max98390: Fix error codes in max98390_dsm=
_init()
 |a01033230 7ceb40 .: 5.10| powerpc/mm: sanity_check_fault() should work fo=
r all, not only BOOK3S
v |a7f5da379 d6ff32 o: 5.10| usb: ehci-omap: Fix PM disable depth umbalance=
 in ehci_hcd_omap_probe
v |539030ed5 d6ff32 o: 4.19| usb: ehci-omap: Fix PM disable depth umbalance=
 in ehci_hcd_omap_probe
a |18e8fca70 d6ff32 o:  4.4| usb: ehci-omap: Fix PM disable depth umbalance=
 in ehci_hcd_omap_probe
v |554cf4dbb e5548b .: 5.10| usb: oxu210hp-hcd: Fix memory leak in oxu_crea=
te
v |6cb1a9bc8 e5548b .: 4.19| usb: oxu210hp-hcd: Fix memory leak in oxu_crea=
te
a |2095a996e e5548b .:  4.4| usb: oxu210hp-hcd: Fix memory leak in oxu_crea=
te
v |796b980fe d1b928 .: 5.10| speakup: fix uninitialized flush_lock
v |5d4e4150d d1b928  : 4.19| speakup: fix uninitialized flush_lock
a |3e19eaa9d d1b928  :  4.4| speakup: fix uninitialized flush_lock
v |e32cd654f 442044 o: 5.10| nfsd: Fix message level for normal termination
a just a printk tweak |e7d43b984 442044 o: 4.19| nfsd: Fix message level fo=
r normal termination
 |db6fa157c ca9364 o: 5.10| NFSD: Fix 5 seconds delay when doing inter serv=
er copy
v |a9bd191b5 4a9d81 o: 5.10| nfs_common: need lock during iterate through t=
he list
v |472d6ef2b 4a9d81 o: 4.19| nfs_common: need lock during iterate through t=
he list
a |c6241513b 4a9d81 o:  4.4| nfs_common: need lock during iterate through t=
he list
v |bffe3df7f 78ff27 o: 5.10| x86/kprobes: Restore BTF if the single-steppin=
g is cancelled
v |cb6d55129 78ff27 o: 4.19| x86/kprobes: Restore BTF if the single-steppin=
g is cancelled
a |1519d4de3 78ff27 o:  4.4| x86/kprobes: Restore BTF if the single-steppin=
g is cancelled
 |2e6f80c03 8a78dd o: 5.10| scsi: qla2xxx: Fix FW initialization error on b=
ig endian machines
 |4094e4a0e 07a5f6 o: 5.10| scsi: qla2xxx: Fix N2N and NVMe connect retry f=
ailure
 |c5fe1cdfb 74639c .: 5.10| platform/chrome: cros_ec_spi: Don't overwrite s=
pi::mode
 |f1e797550 1749c9 .: 5.10| misc: pci_endpoint_test: fix return value of er=
ror branch
 |85e41272b 61243c .: 5.10| bus: fsl-mc: add back accidentally dropped erro=
r check
v |a94113b7a 3d70fb .: 5.10| bus: fsl-mc: fix error return code in fsl_mc_o=
bject_allocate()
a |8a2dbe42a 3d70fb .: 4.19| bus: fsl-mc: fix error return code in fsl_mc_o=
bject_allocate()
 |d1a4e6c70 dfd7f2 .: 5.10| fsi: Aspeed: Add mutex to protect HW access
 |e1b4e2147 14d4c4  : 5.10| s390/cio: fix use-after-free in ccw_device_dest=
roy_console
 |96affd902 58a1c9 .: 5.10| iwlwifi: dbg-tlv: fix old length in is_trig_dat=
a_contained()
 |ed1ac0d84 8a59d3 .: 5.10| iwlwifi: mvm: hook up missing RX handlers
 |27ad3fd7e d8b3df .: 5.10| erofs: avoid using generic_block_bmap
 |a6d7928fa 146539 .: 5.10| clk: renesas: r8a779a0: Fix R and OSC clocks
 |f87059cdd c9f4ca .: 5.10| can: m_can: m_can_config_endisable(): remove do=
uble clearing of clock stop request bit
 |29e708d08 ef6879 .: 5.10| powerpc/sstep: Emulate prefixed instructions on=
ly when CPU_FTR_ARCH_31 is set
 |be8986485 1817de .: 5.10| powerpc/sstep: Cover new VSX instructions under=
 CONFIG_VSX
 |06f89f983 428bb0 .: 5.10| slimbus: qcom: fix potential NULL dereference i=
n qcom_slim_prg_slew()
 |13c67bf49 b1a503 o: 5.10| ALSA: hda/hdmi: fix silent stream for first pla=
yback to DP
 |b8c9e04b4 779e0b  : 5.10| RDMA/core: Do not indicate device ready when de=
vice enablement fails
 |02a36378f e0da68 .: 5.10| RDMA/uverbs: Fix incorrect variable type
 |6c32d519a 0a4415 .: 5.10| remoteproc/mediatek: change MT8192 CFG register=
 base
 |1eeea9dad e59aef .: 5.10| remoteproc/mtk_scp: surround DT device IDs with=
 CONFIG_OF
 |965520890 a24723 .: 5.10| remoteproc: q6v5-mss: fix error handling in q6v=
5_pds_enable
 |d6f4d4532 aa3744 .: 5.10| remoteproc: qcom: fix reference leak in adsp_st=
art
 |1afbbb26f c0a6e5 .: 5.10| remoteproc: qcom: pas: fix error handling in ad=
sp_pds_enable
 |c470af3e3 6dfdf6 .: 5.10| remoteproc: k3-dsp: Fix return value check in k=
3_dsp_rproc_of_get_memories()
 |109cbf1d7 c3d4e5 .: 5.10| remoteproc: qcom: Fix potential NULL dereferenc=
e in adsp_init_mmio()
 |c71c16526 22c3df .: 5.10| remoteproc/mediatek: unprepare clk if scp_befor=
e_load fails
 |59cdc2052 6d37a8 .: 5.10| clk: qcom: gcc-sc7180: Use floor ops for sdcc c=
lks
v |3709e57eb 5bf586 .: 5.10| clk: tegra: Fix duplicated SE clock entry
a just a warning fix |a67bb88db 5bf586 .: 4.19| clk: tegra: Fix duplicated =
SE clock entry
 |f2918f4c6 1b391c o: 5.10| mtd: rawnand: gpmi: fix reference count leak in=
 gpmi ops
 |721f76597 ad8566 .: 5.10| mtd: rawnand: meson: Fix a resource leak in init
 |a933ea94c 7671ed o: 5.10| mtd: rawnand: gpmi: Fix the random DMA timeout =
issue
 |6894ea645 092fde .: 5.10| samples/bpf: Fix possible hang in xdpsock with =
multiple threads
 |5d7360977 881490 o: 5.10| fs: Handle I_DONTCACHE in iput_final() instead =
of generic_drop_inode()
v |ef34ae222 e1efdb .: 5.10| extcon: max77693: Fix modalias string
v |482a796ed e1efdb .: 4.19| extcon: max77693: Fix modalias string
a |1f6646253 e1efdb .:  4.4| extcon: max77693: Fix modalias string
 |4ff3417b2 d33a23 o: 5.10| crypto: atmel-i2c - select CONFIG_BITREVERSE
v |2e75a6d9d f65607 o: 5.10| mac80211: don't set set TDLS STA bandwidth wid=
er than possible
a |5a12efde7 f65607 o: 4.19| mac80211: don't set set TDLS STA bandwidth wid=
er than possible
 |a1c898951 f879ac o: 5.10| mac80211: fix a mistake check for rx_stats upda=
te
v |891f24899 85a755 .: 5.10| ASoC: wm_adsp: remove "ctl" from list on error=
 in wm_adsp_create_control()
v |6786d16c5 85a755 .: 4.19| ASoC: wm_adsp: remove "ctl" from list on error=
 in wm_adsp_create_control()
!c/e |4dd6abf90 85a755 .:  4.4| ASoC: wm_adsp: remove "ctl" from list on er=
ror in wm_adsp_create_control()
v |1073027cf 384124 .: 5.10| irqchip/alpine-msi: Fix freeing of interrupts =
on allocation error path
a likely untested |a96005ac5 384124 .: 4.19| irqchip/alpine-msi: Fix freein=
g of interrupts on allocation error path
 |ad0696b20 b10d5f .: 5.10| irqchip/ti-sci-inta: Fix printing of inta id on=
 probe success
 |71a7c6c62 fc6c7c .: 5.10| irqchip/ti-sci-intr: Fix freeing of irqs
 |4a25dde70 e2de92 .: 5.10| dmaengine: ti: k3-udma: Correct normal channel =
offset when uchan_cnt is not 0
 |d95aaf5b9 1c0ca9  : 5.10| RDMA/hns: Limit the length of data copied betwe=
en kernel and userspace
 |d154842ea 4ddeac  : 5.10| RDMA/hns: Normalization the judgment of some fe=
atures
 |c57f98ef5 603bee  : 5.10| RDMA/hns: Do shift on traffic class when using =
RoCEv2
 |2cd602399 9d5522 o: 5.10| gpiolib: irq hooks: fix recursion in gpiochip_i=
rq_unmask
 |7ba761103 f57ad6 .: 5.10| ath11k: Fix incorrect tlvs in scan start command
 |6a98c19a3 2f5fbc .: 5.10| irqchip/qcom-pdc: Fix phantom irq when changing=
 between rising/falling
 |6f974dcef 7f6f1d o: 5.10| watchdog: armada_37xx: Add missing dependency o=
n HAS_IOMEM
v |6d90623da 8ae251 o: 5.10| watchdog: sirfsoc: Add missing dependency on H=
AS_IOMEM
a |438e3e194 8ae251 o: 4.19| watchdog: sirfsoc: Add missing dependency on H=
AS_IOMEM
v |17212b057 f61a59 .: 5.10| watchdog: sprd: remove watchdog disable from r=
esume fail path
! |4535c1005 f61a59 .: 4.19| watchdog: sprd: remove watchdog disable from r=
esume fail path
v |84d078782 3e07d2 .: 5.10| watchdog: sprd: check busy bit before new load=
ing rather than after that
a |5d905ca05 3e07d2 .: 4.19| watchdog: sprd: check busy bit before new load=
ing rather than after that
v |a26f639b1 6f733c o: 5.10| watchdog: Fix potential dereferencing of null =
pointer
a |f648cf90f 6f733c o: 4.19| watchdog: Fix potential dereferencing of null =
pointer
 |412060c73 3cded6 .: 5.10| ubifs: Fix error return code in ubifs_init_auth=
entication()
 |82b0b9dd6 e3a01c .: 5.10| um: Monitor error events in IRQ controller
 |f9759b29b e3a01c .: 4.19| um: Monitor error events in IRQ controller
 |e4a4d5a14 9b1c0c .: 5.10| um: tty: Fix handling of close in tty lines
 |303475bbf 9b1c0c .: 4.19| um: tty: Fix handling of close in tty lines
 |b52772248 9431f7 .: 5.10| um: chan_xterm: Fix fd leak
 |245a5b517 9431f7 .: 4.19| um: chan_xterm: Fix fd leak
 |9cd6a5da3 9431f7 .:  4.4| um: chan_xterm: Fix fd leak
 |63a048aea ac9645 o: 5.10| sunrpc: fix xs_read_xdr_buf for partial pages r=
eceive
 |63b84079c e89938  : 5.10| RDMA/mlx5: Fix MR cache memory leak
 |811c29265 e246b7  : 5.10| RDMA/cma: Don't overwrite sgid_attr after devic=
e is released
v |83d9df20d a4485b .: 5.10| nfc: s3fwrn5: Release the nfc firmware
v |ed7616cb5 a4485b .: 4.19| nfc: s3fwrn5: Release the nfc firmware
a |37036ceb0 a4485b .:  4.4| nfc: s3fwrn5: Release the nfc firmware
 |7234c5e64 ee46d1 .: 5.10| drm: mxsfb: Silence -EPROBE_DEFER while waiting=
 for bridge
 |e42935ba4 ef0e3b .: 5.10| powerpc/perf: Fix Threshold Event Counter Multi=
plier width for P10
v |5ac4455b8 d0edaa .: 5.10| powerpc/ps3: use dma_mapping_error()
v |5be97dac4 d0edaa .: 4.19| powerpc/ps3: use dma_mapping_error()
a |730cfe9ed d0edaa .:  4.4| powerpc/ps3: use dma_mapping_error()
 |f64f13d15 b2ce5d  : 5.10| perf test: Fix metric parsing test
 |ddd94beb5 7eded0 .: 5.10| drm/amdgpu: fix regression in vbios reservation=
 handling on headless
 |de7768f58 c28b1f o: 5.10| mm/gup: reorganize internal_get_user_pages_fast=
()
 |1808a53a5 57efa1 o: 5.10| mm/gup: prevent gup_fast from racing with COW d=
uring fork
 |a372809a7 4509b4 o: 5.10| mm/gup: combine put_compound_head() and unpin_u=
ser_page()
 |79d91c719 2f7659 o: 5.10| mm: memcg/slab: fix return of child memcg objcg=
 for root memcg
 |bf04866bb eefbfa o: 5.10| mm: memcg/slab: fix use after free in obj_cgrou=
p_charge
 |1877e85c3 013339 o: 5.10| mm/rmap: always do TTU_IGNORE_ACCESS
 |d1c86faef 06517c .: 5.10| sparc: fix handling of page table constructor f=
ailure
 |c77976753 0a7dd4 o: 5.10| mm/vmalloc: Fix unlock order in s_stop()
 |026a8fc9b c04109 o: 5.10| mm/vmalloc.c: fix kasan shadow poisoning size
 |e28dcf919 1e8aae o: 5.10| mm,memory_failure: always pin the page in madvi=
se_inject_error
 |9e9004f21 7fc251 o: 5.10| hugetlb: fix an error code in hugetlb_reserve_p=
ages()
 |8dfdc7595 597c89 o: 5.10| mm: don't wake kswapd prematurely when watermar=
k boosting is disabled
 |698b934ef c6c75d o: 5.10| proc: fix lookup in /proc/net subdirectories af=
ter setns(2)
v |0e40df820 03f493 o: 5.10| checkpatch: fix unescaped left brace
v |8c9e5ebf4 03f493 o: 4.19| checkpatch: fix unescaped left brace
a |ca14ab5bf 03f493 o:  4.4| checkpatch: fix unescaped left brace
 |f3cc99867 f22b9c  : 5.10| s390/test_unwind: fix CALL_ON_STACK tests
 |6be890762 57030a .: 5.10| lan743x: fix rx_napi_poll/interrupt ping-pong
 |d23c967c3 8d1476 .: 5.10| ice, xsk: clear the status bits for the next_to=
_use descriptor
 |ac9cc2539 64050b .: 5.10| i40e, xsk: clear the status bits for the next_t=
o_use descriptor
 |76d124a47 3e4749 .: 5.10| net: dsa: qca: ar9331: fix sleeping function ca=
lled from invalid context bug
 |20f0bee15 54a57d .: 5.10| dpaa2-eth: fix the size of the mapped SGT buffer
v |e011f964c 4375ad o: 5.10| net: bcmgenet: Fix a resource leak in an error=
 handling path in the probe functin
v |2fbb6974e 4375ad o: 4.19| net: bcmgenet: Fix a resource leak in an error=
 handling path in the probe functin
a |4276f2201 4375ad o:  4.4| net: bcmgenet: Fix a resource leak in an error=
 handling path in the probe functin
 |f1738a148 f87675 .: 5.10| net: mscc: ocelot: Fix a resource leak in the e=
rror handling path of the probe function
v |17a155714 322e53 .: 5.10| net: allwinner: Fix some resources leak in the=
 error handling path of the probe and in the remove function
v |637ad8472 322e53 .: 4.19| net: allwinner: Fix some resources leak in the=
 error handling path of the probe and in the remove function
a |a18b0baad 322e53 .:  4.4| net: allwinner: Fix some resources leak in the=
 error handling path of the probe and in the remove function
 |370921b5e e7508d .: 5.10| block/rnbd-clt: Get rid of warning regarding si=
ze argument in strlcpy
 |0d4ac3f63 460678 .: 5.10| block/rnbd-clt: Fix possible memleak
 |229cec635 52104f o: 5.10| NFS/pNFS: Fix a typo in ff_layout_resend_pnfs_r=
ead()
v |484059a27 7eb000 .: 5.10| net: korina: fix return value
v |a6885b483 7eb000 .: 4.19| net: korina: fix return value
a |abc2236b4 7eb000 .:  4.4| net: korina: fix return value
 |6fedc4496 75f4d4 o: 5.10| devlink: use _BITUL() macro instead of BIT() in=
 the UAPI header
v |efa1dfcdd 4c4676 .: 5.10| libnvdimm/label: Return -ENXIO for no slot in =
__blk_label_update
a |5a8abb3d3 4c4676 .: 4.19| libnvdimm/label: Return -ENXIO for no slot in =
__blk_label_update
 |1a2956f58 c1bea0 .: 5.10| powerpc/32s: Fix cleanup_cpu_mmu_context() comp=
ile bug
v |d8c20240a 7948fa .: 5.10| watchdog: qcom: Avoid context switch in restar=
t handler
!! 150msec mdelay? |73288d2fc 7948fa .: 4.19| watchdog: qcom: Avoid context=
 switch in restart handler
v |e9b01110a 36c47d o: 5.10| watchdog: coh901327: add COMMON_CLK dependency
a |77b97b3e2 36c47d o: 4.19| watchdog: coh901327: add COMMON_CLK dependency
v |c27dd4131 8c6239 o: 5.10| clk: ti: Fix memleak in ti_fapll_synth_setup
v |2cf8463e8 8c6239 o: 4.19| clk: ti: Fix memleak in ti_fapll_synth_setup
a |b0b2d5073 8c6239 o:  4.4| clk: ti: Fix memleak in ti_fapll_synth_setup
v |94751e9b5 269eff .: 5.10| pwm: zx: Add missing cleanup in error path
a |7caa861c0 269eff .: 4.19| pwm: zx: Add missing cleanup in error path
v |51d23c5dc 1f0f1e .: 5.10| pwm: lp3943: Dynamically allocate PWM chip base
a |592148181 1f0f1e .: 4.19| pwm: lp3943: Dynamically allocate PWM chip base
 |68736f755 1ce653 .: 5.10| pwm: imx27: Fix overflow for bigger periods
 |0cac1d4d8 6eefb7 .: 5.10| pwm: sun4i: Remove erroneous else branch
 |c14864700 df9923 .: 5.10| io_uring: cancel only requests of current task
 |1dbc0b0f0 09d59c  : 5.10| tools build: Add missing libcap to test-all.bin=
 target
v |8e400b2fa 2eb5dd  : 5.10| perf record: Fix memory leak when using '--use=
r-regs=3D?' to list registers
v |868bd174b 2eb5dd  : 4.19| perf record: Fix memory leak when using '--use=
r-regs=3D?' to list registers
!c/e |750b9f261 2eb5dd  :  4.4| perf record: Fix memory leak when using '--=
user-regs=3D?' to list registers
v |ebe8c5a72 0d5284 o: 5.10| qlcnic: Fix error code in probe
v |686cb5694 0d5284 o: 4.19| qlcnic: Fix error code in probe
a |969ccd95c 0d5284 o:  4.4| qlcnic: Fix error code in probe
 |8d9d29957 5b33af .: 5.10| nfp: move indirect block cleanup to flower app =
stop callback
 |271a1d4b7 83ef73 .: 5.10| vdpa/mlx5: Use write memory barrier after updat=
ing CQ index
 |920a17aa0 ae93d8 o: 5.10| virtio_ring: Cut and paste bugs in vring_create=
_virtqueue_packed()
 |b5973dece 411ea2 o: 5.10| virtio_net: Fix error code in probe()
 |533a7c58f e152d8 o: 5.10| virtio_ring: Fix two use after free bugs
 |6f719457a 2e1139 .: 5.10| vhost scsi: fix error return code in vhost_scsi=
_set_endpoint()
 |6ec2b1a3e 289caf o: 5.10| epoll: check for events when removing a timed o=
ut thread from the wait queue
 |45343d605 be439c .: 5.10| clk: bcm: dvp: Add MODULE_DEVICE_TABLE()
 |7db86dfe7 912744 .: 5.10| clk: at91: sama7g5: fix compilation error
 |2d5660281 01324f .: 5.10| clk: at91: sam9x60: remove atmel,osc-bypass sup=
port
v |9d4e91b13 d2d94f .: 5.10| clk: s2mps11: Fix a resource leak in error han=
dling paths in the probe function
v |ad7fd3b3e d2d94f .: 4.19| clk: s2mps11: Fix a resource leak in error han=
dling paths in the probe function
a |b4ef47f88 d2d94f .:  4.4| clk: s2mps11: Fix a resource leak in error han=
dling paths in the probe function
v |84547a788 48f68d .: 5.10| clk: sunxi-ng: Make sure divider tables have s=
entinel
a |11ed90dd6 48f68d .: 4.19| clk: sunxi-ng: Make sure divider tables have s=
entinel
 |32c41fc41 4b003f o: 5.10| clk: vc5: Use "idt,voltage-microvolt" instead o=
f "idt,voltage-microvolts"
v |31c98d858 135b49 o: 5.10| kconfig: fix return value of do_error_if()
a |b30b7e67b 135b49 o: 4.19| kconfig: fix return value of do_error_if()
 |59797ec12 ad2091 .: 4.19| ARM: sunxi: Add machine match for the Allwinner=
 V3 SoC
v |5f95726eb f495ac o: 4.19| cfg80211: initialize rekey_data
a |c9eb6a6bf f495ac o:  4.4| cfg80211: initialize rekey_data
a |1deebb168 ed9b25 o: 4.19| fix namespaced fscaps when !CONFIG_SECURITY
!! check, comment says may not work in 5.0 |2fae646b9 d9054a o: 4.19| lwt: =
Disable BH too in run_lwt_bpf()
v |d12293fbd 80db2a o: 4.19| Input: cros_ec_keyb - send 'scancodes' in addi=
tion to key events
a |324e548b3 80db2a o:  4.4| Input: cros_ec_keyb - send 'scancodes' in addi=
tion to key events
v |0ae7a618f cffdd6 .: 4.19| Input: goodix - add upside-down quirk for Tecl=
ast X98 Pro tablet
a |999ddcd81 cffdd6 .:  4.4| Input: goodix - add upside-down quirk for Tecl=
ast X98 Pro tablet
 |5093be45b b36f83 .: 5.10| powerpc/boot: Fix build of dts/fsl
 |15d885497 9014ea .: 5.10| powerpc/smp: Add __init to init_big_cores()
 |470228126 3cce9d o: 5.10| ARM: 9044/1: vfp: use undef hook for VFP suppor=
t detection
 |50d39f390 1ecec3 o: 5.10| ARM: 9036/1: uncompress: Fix dbgadtb size param=
eter name
 |695646e21 514930  : 5.10| perf probe: Fix memory leak when synthesizing S=
DT probes
 |daf9325c2 634578 .: 5.10| io_uring: fix racy IOPOLL flush overflow
 |f3fe4526c cda286 .: 5.10| io_uring: cancel reqs shouldn't kill overflow l=
ist
 |3223986e9 942cb3 .: 5.10| Smack: Handle io_uring kernel thread privileges
 |3680edbb5 14e3e9 o: 5.10| proc mountinfo: make splice available again
 |675304f15 59850d .: 5.10| io_uring: fix io_cqring_events()'s noflush
 |dcb78c7dc 31bff9 .: 5.10| io_uring: fix racy IOPOLL completions
 |50b0dcf35 dad1b1 .: 5.10| io_uring: always let io_iopoll_complete() compl=
ete polled io
 |f1e881f5a 16b8fe o: 5.10| vfio/pci: Move dummy_resources_list init in vfi=
o_pci_probe()
 |14b4fdee8 d22f9a .: 5.10| vfio/pci/nvlink2: Do not attempt NPU2 setup on =
POWER8NVL NPU
v |b7c1e2005 e469d0 o: 5.10| media: gspca: Fix memory leak in probe
v |2883dc166 e469d0 o: 4.19| media: gspca: Fix memory leak in probe
a |e0fe4f04d e469d0 o:  4.4| media: gspca: Fix memory leak in probe
 |b1ecf8adc 0020ef .: 5.10| io_uring: fix io_wqe->work_list corruption
 |eab1a98a6 dd2016 .: 5.10| io_uring: fix 0-iov read buffer select
 |3af6706f6 c07e67 .: 5.10| io_uring: hold uring_lock while completing fail=
ed polled io in io_wq_submit_work()
 |e15823abb a528b0 .: 5.10| io_uring: fix ignoring xa_store errors
 |fc6a24b2e 9faadc .: 5.10| io_uring: fix double io_uring free
 |1c6e5974a 00c186 .: 5.10| io_uring: make ctx cancel on exit targeted to a=
ctual ctx
v |ee1d296d2 3f56df .: 5.10| media: sunxi-cir: ensure IR is handled when it=
 is continuous
v |b74121053 3f56df .: 4.19| media: sunxi-cir: ensure IR is handled when it=
 is continuous
a |734ccca11 3f56df .:  4.4| media: sunxi-cir: ensure IR is handled when it=
 is continuous
v |8a9b30142 e297dd .: 5.10| media: netup_unidvb: Don't leak SPI master in =
probe error path
v |6163859b9 e297dd .: 4.19| media: netup_unidvb: Don't leak SPI master in =
probe error path
! |d450d7d24 e297dd .:  4.4| media: netup_unidvb: Don't leak SPI master in =
probe error path
v |12e290ce7 61e7f8 .: 5.10| media: ipu3-cio2: Remove traces of returned bu=
ffers
a |9d2764fab 61e7f8 .: 4.19| media: ipu3-cio2: Remove traces of returned bu=
ffers
v |315a44366 8160e8 .: 5.10| media: ipu3-cio2: Return actual subdev format
! |87a992251 8160e8 .: 4.19| media: ipu3-cio2: Return actual subdev format
v |57b4d9234 55a6c6 .: 5.10| media: ipu3-cio2: Serialise access to pad form=
at
!c/e |953174d2b 55a6c6 .: 4.19| media: ipu3-cio2: Serialise access to pad f=
ormat
v |c351657c7 a86cf9 .: 5.10| media: ipu3-cio2: Validate mbus format in sett=
ing subdev format
! |642b8cca2 a86cf9 .: 4.19| media: ipu3-cio2: Validate mbus format in sett=
ing subdev format
v |3e62f2e3a 219a8b .: 5.10| media: ipu3-cio2: Make the field on subdev for=
mat V4L2_FIELD_NONE
a |f395c87fa 219a8b .: 4.19| media: ipu3-cio2: Make the field on subdev for=
mat V4L2_FIELD_NONE
v |fd049386b f051ae o: 5.10| Input: cyapa_gen6 - fix out-of-bounds stack ac=
cess
v |eba4d8f56 f051ae o: 4.19| Input: cyapa_gen6 - fix out-of-bounds stack ac=
cess
a |5ec424ff9 f051ae o:  4.4| Input: cyapa_gen6 - fix out-of-bounds stack ac=
cess
v |c3101d3c7 7079f7 .: 5.10| ALSA: hda/ca0132 - Change Input Source enum st=
rings.
! should we have constants? |c1efd10a1 7079f7 .: 4.19| ALSA: hda/ca0132 - C=
hange Input Source enum strings.
 |ba291efe9 9a7e3d .: 5.10| ACPI: NFIT: Fix input validation of bus-family
v |570a317df 7482c5 o: 5.10| PM: ACPI: PCI: Drop acpi_pm_set_bridge_wakeup()
! |edff373bb 7482c5 o: 4.19| PM: ACPI: PCI: Drop acpi_pm_set_bridge_wakeup()
v |8c68ed7e1 12fc4d o: 5.10| Revert "ACPI / resources: Use AE_CTRL_TERMINAT=
E to terminate resources walks"
v |9cefdbaf6 12fc4d o: 4.19| Revert "ACPI / resources: Use AE_CTRL_TERMINAT=
E to terminate resources walks"
a |4dc6cbf20 12fc4d o:  4.4| Revert "ACPI / resources: Use AE_CTRL_TERMINAT=
E to terminate resources walks"
v |32a571215 b08221 o: 5.10| ACPI: PNP: compare the string length in the ma=
tching_id()
v |13e0e9ad0 b08221 o: 4.19| ACPI: PNP: compare the string length in the ma=
tching_id()
! tweak to string comparison heuristics; likely to break someone's config |=
f5a341ce5 b08221 o:  4.4| ACPI: PNP: compare the string length in the match=
ing_id()
v |c3ea66c79 250631 o: 5.10| ALSA: hda: Fix regressions on clear and reconf=
ig sysfs
a |d51bfbc82 250631 o: 4.19| ALSA: hda: Fix regressions on clear and reconf=
ig sysfs
 |e84a786c2 c697ba .: 5.10| ALSA: hda/ca0132 - Fix AE-5 rear headphone pinc=
fg.
 |fb6d07e7c c72b9b .: 5.10| ALSA: hda/realtek: make bass spk volume adjusta=
ble on a yoga laptop
v |52ffbd6da 5cfca5 .: 5.10| ALSA: hda/realtek - Enable headset mic of ASUS=
 X430UN with ALC256
a |04593acaf 5cfca5 .: 4.19| ALSA: hda/realtek - Enable headset mic of ASUS=
 X430UN with ALC256
v |c4dfce834 7e4135 .: 5.10| ALSA: hda/realtek - Enable headset mic of ASUS=
 Q524UQK with ALC255
a |0fc5b0f38 7e4135 .: 4.19| ALSA: hda/realtek - Enable headset mic of ASUS=
 Q524UQK with ALC255
 |1ce3cc8b9 607184 .: 5.10| ALSA: hda/realtek - Add supported for more Leno=
vo ALC285 Headset Button
v |daf0d619f 11cb88 o: 5.10| ALSA: pcm: oss: Fix a few more UBSAN fixes
v |74fc0ec27 11cb88 o: 4.19| ALSA: pcm: oss: Fix a few more UBSAN fixes
! |ac77999b3 11cb88 o:  4.4| ALSA: pcm: oss: Fix a few more UBSAN fixes
 |f5bbd4aa7 13be30 .: 5.10| ALSA/hda: apply jack fixup for the Acer Veriton=
 N4640G/N6640G/N2510G
v |6dae27615 099262 .: 5.10| ALSA: hda/realtek: Add quirk for MSI-GP73
a |6b8ee41cb 099262 .: 4.19| ALSA: hda/realtek: Add quirk for MSI-GP73
v |741e97df2 6ca653 .: 5.10| ALSA: hda/realtek: Apply jack fixup for Quanta=
 NL3
a |d4d2e89f5 6ca653 .: 4.19| ALSA: hda/realtek: Apply jack fixup for Quanta=
 NL3
 |bbe7b735f 34cdf4 .: 5.10| ALSA: hda/realtek: Remove dummy lineout on Acer=
 TravelMate P648/P658
 |d7aa07679 150927 .: 5.10| ALSA: hda/realtek - Supported Dell fixed type h=
eadset
v |ada2c9306 725124 o: 5.10| ALSA: usb-audio: Add VID to support native DSD=
 reproduction on FiiO devices
a |f049e0a45 725124 o: 4.19| ALSA: usb-audio: Add VID to support native DSD=
 reproduction on FiiO devices
v |9505dd776 9df28e o: 5.10| ALSA: usb-audio: Disable sample read check if =
firmware doesn't give back
!c/e, just faster handling of known-broken hardware |173aca40c 9df28e o: 4.=
19| ALSA: usb-audio: Disable sample read check if firmware doesn't give back
 |9369d0407 525d9c o: 5.10| ALSA: usb-audio: Add alias entry for ASUS PRIME=
 TRX40 PRO-S
 |9c1f19389 74c64e o: 5.10| ALSA: core: memalloc: add page alignment for ir=
am
 |916a2c094 b5e438  : 5.10| s390/smp: perform initial CPU reset also for SM=
T siblings
 |56c63a793 b5e438  : 4.19| s390/smp: perform initial CPU reset also for SM=
T siblings
 |aeb7740ea 613775  : 5.10| s390/kexec_file: fix diag308 subcode when loadi=
ng crash kernel
 |98bf1f444 613775  : 4.19| s390/kexec_file: fix diag308 subcode when loadi=
ng crash kernel
 |b88cc5d47 e259b3  : 5.10| s390/idle: add missing mt_cycles calculation
 |14c4df180 454efc  : 5.10| s390/idle: fix accounting with machine checks
 |a2502dc46 658a33  : 5.10| s390/dasd: fix hanging device offline processing
 |a078414c8 658a33  : 4.19| s390/dasd: fix hanging device offline processing
 |fb5476593 a29ea0  : 5.10| s390/dasd: prevent inconsistent LCU device data
 |1379ffebe a29ea0  : 4.19| s390/dasd: prevent inconsistent LCU device data
 |c26a07718 0ede91  : 5.10| s390/dasd: fix list corruption of pavgroup grou=
p list
 |c9d09ea81 0ede91  : 4.19| s390/dasd: fix list corruption of pavgroup grou=
p list
 |c1fc39c0e 0ede91  :  4.4| s390/dasd: fix list corruption of pavgroup grou=
p list
 |73a487a9c 53a7f6  : 5.10| s390/dasd: fix list corruption of lcu list
 |3643ce711 53a7f6  : 4.19| s390/dasd: fix list corruption of lcu list
 |f19a9296f 53a7f6  :  4.4| s390/dasd: fix list corruption of lcu list
 |7153bfa0f 0f966c .: 5.10| binder: add flag to clear buffer on txn complete
 |bf0e2c203 0d024a .: 5.10| ASoC: cx2072x: Fix doubly definitions of Playba=
ck and Capture streams
 |9b6c3b23d 718c40 .: 5.10| ASoC: AMD Renoir - add DMI table to avoid the A=
CP mic probe (broken BIOS)
 |78655fd3a 55d8e6 .: 5.10| ASoC: AMD Raven/Renoir - fix the PCI probe (PCI=
 revision)
v |f80fc4725 56c904  : 5.10| staging: comedi: mf6x4: Fix AI end-of-conversi=
on detection
v |7f2542b57 56c904  : 4.19| staging: comedi: mf6x4: Fix AI end-of-conversi=
on detection
a |d35f02a9d 56c904  :  4.4| staging: comedi: mf6x4: Fix AI end-of-conversi=
on detection
 |d081f27ec fc5488 .: 5.10| z3fold: simplify freeing slots
 |086f84558 dcf5ae .: 5.10| z3fold: stricter locking and more careful recla=
im
 |7b663ef85 306e3e o: 5.10| perf/x86/intel: Add event constraint for CYCLE_=
ACTIVITY.STALLS_MEM_ANY
 |907119c93 46b72e o: 5.10| perf/x86/intel: Fix rtm_abort_event encoding on=
 Ice Lake
 |8c8a9a66c f8129c o: 5.10| perf/x86/intel/lbr: Fix the return type of get_=
lbr_cycles()
v |513f6e9ce aa8e21 .: 5.10| powerpc/perf: Exclude kernel samples while cou=
nting events in user space.
v |ee3dc9678 aa8e21 .: 4.19| powerpc/perf: Exclude kernel samples while cou=
nting events in user space.
a just a statistics fixup |68f68247a aa8e21 .:  4.4| powerpc/perf: Exclude =
kernel samples while counting events in user space.
 |950e2664b e40ad8 o: 5.10| cpufreq: intel_pstate: Use most recent guarante=
ed performance values
v |36239d538 17858b o: 5.10| crypto: ecdh - avoid unaligned accesses in ecd=
h_set_secret()
! check that size is reasonable |9acd48542 17858b o: 4.19| crypto: ecdh - a=
void unaligned accesses in ecdh_set_secret()
 |a1a1983b6 f3456b o: 5.10| crypto: arm/aes-ce - work around Cortex-A57/A72=
 silion errata
 |ad889c0f3 a7b545 .: 5.10| m68k: Fix WARNING splat in pmac_zilog driver
 |df14c2cd5 cf4864 .: 5.10| Documentation: seqlock: s/LOCKTYPE/LOCKNAME/g
v |64f45c95e 83ff51 .: 5.10| EDAC/i10nm: Use readl() to access MMIO registe=
rs
v |672a73ba3 706657 o: 5.10| EDAC/amd64: Fix PCI component registration
a |edf87ff57 706657 o: 4.19| EDAC/amd64: Fix PCI component registration
 |30742bc2f 406100 o: 5.10| cpuset: fix race between hotplug work and later=
 CPU offline
 |c3732e855 3577af o: 5.10| dyndbg: fix use before null check
v |824ccaa7e 975323 o: 5.10| USB: serial: mos7720: fix parallel-port state =
restore
v |a24dbad8f 975323 o: 4.19| USB: serial: mos7720: fix parallel-port state =
restore
a |b7401e611 975323 o:  4.4| USB: serial: mos7720: fix parallel-port state =
restore
v |210dafa87 5098e7 o: 5.10| USB: serial: digi_acceleport: fix write-wakeup=
 deadlocks
! not a minimum fix |6a0df5180 5098e7 o: 4.19| USB: serial: digi_acceleport=
: fix write-wakeup deadlocks
v |48d847ef2 696c54 o: 5.10| USB: serial: keyspan_pda: fix dropped unthrott=
le interrupts
v |061df7316 696c54 o: 4.19| USB: serial: keyspan_pda: fix dropped unthrott=
le interrupts
a! cc says 4.11+ |520bf38f4 696c54 o:  4.4| USB: serial: keyspan_pda: fix d=
ropped unthrottle interrupts
v |1560c7151 7353ca o: 5.10| USB: serial: keyspan_pda: fix write deadlock
v |4696c5f62 7353ca o: 4.19| USB: serial: keyspan_pda: fix write deadlock
a |e1784badc 7353ca o:  4.4| USB: serial: keyspan_pda: fix write deadlock
v |b643a0e9f c01d2c o: 5.10| USB: serial: keyspan_pda: fix stalled writes
v |0fb69b3d9 c01d2c o: 4.19| USB: serial: keyspan_pda: fix stalled writes
a |52f001676 c01d2c o:  4.4| USB: serial: keyspan_pda: fix stalled writes
v |46d7916be 37faf5 o: 5.10| USB: serial: keyspan_pda: fix write-wakeup use=
-after-free
v |8743e73fe 37faf5 o: 4.19| USB: serial: keyspan_pda: fix write-wakeup use=
-after-free
! |ac46a6e12 37faf5 o:  4.4| USB: serial: keyspan_pda: fix write-wakeup use=
-after-free
v |eb9a4c6d0 49fbb8 o: 5.10| USB: serial: keyspan_pda: fix tx-unthrottle us=
e-after-free
v |4775c9a66 49fbb8 o: 4.19| USB: serial: keyspan_pda: fix tx-unthrottle us=
e-after-free
a |c93dd7d00 49fbb8 o:  4.4| USB: serial: keyspan_pda: fix tx-unthrottle us=
e-after-free
v |37a98fe1d 320f90 o: 5.10| USB: serial: keyspan_pda: fix write unthrottli=
ng
v |d797e2872 320f90 o: 4.19| USB: serial: keyspan_pda: fix write unthrottli=
ng
! |23ac38e35 320f90 o:  4.4| USB: serial: keyspan_pda: fix write unthrottli=
ng
 |3fc2bc062 None o:  4.4| btrfs: quota: Set rescan progress to (u64)-1 if w=
e hit last leaf
 |0aafea37f 665d49 o:  4.4| btrfs: scrub: Don't use inode page cache in scr=
ub_handle_errored_block()
 |c06ce0fab 9f7fec o:  4.4| Btrfs: fix selftests failure due to uninitializ=
ed i_mode in test inodes
 |b7a2e41f6 881a3a o:  4.4| btrfs: fix return value mixup in btrfs_get_exte=
nt
 |1d0e43a70 9076db o: 5.10| btrfs: do not shorten unpin len for caching blo=
ck groups
 |8fe1e5f58 27d56e o: 5.10| btrfs: update last_byte_to_unpin in switch_comm=
it_roots
 |a622d353a 7f458a o: 5.10| btrfs: fix race when defragmenting leads to unn=
ecessary IO
 |a80695ea3 bc1854 o: 5.10| ext4: fix an IS_ERR() vs NULL check
v |7ba6fc597 cca415 o: 5.10| ext4: fix a memory leak of ext4_free_data
v |9cc942c89 cca415 o: 4.19| ext4: fix a memory leak of ext4_free_data
a just a robustness against fs corruption |458c79562 cca415 o:  4.4| ext4: =
fix a memory leak of ext4_free_data
v |497122c9f 46e294 o: 5.10| ext4: fix deadlock with fs freezing and EA ino=
des
a |bbfec1c8d 46e294 o: 4.19| ext4: fix deadlock with fs freezing and EA ino=
des
 |84a420c41 b08070 o: 5.10| ext4: don't remount read-only with errors=3Dcon=
tinue on reboot
 |bf2fc8c0f de043d .: 5.10| RISC-V: Fix usage of memblock_enforce_memory_li=
mit
 |55715c2d6 50301e o: 5.10| arm64: dts: ti: k3-am65: mark dss as dma-cohere=
nt
 |3818fea2b f43cad o: 5.10| arm64: dts: marvell: keep SMMU disabled by defa=
ult for Armada 7040 and 8040
v |15afdaecd ca4e51 o: 5.10| KVM: arm64: Introduce handling of AArch32 TTBC=
R2 traps
a not sure if this fixes something |35b9ef43d ca4e51 o: 4.19| KVM: arm64: I=
ntroduce handling of AArch32 TTBCR2 traps
 |7074e0d29 39485e o: 5.10| KVM: x86: reinstate vendor-agnostic check on SP=
EC_CTRL cpuid bits
 |2935d71a6 9d4747 .: 5.10| KVM: SVM: Remove the call to sev_platform_statu=
s() during setup
 |5300b7305 56b75b .: 5.10| iommu/arm-smmu: Allow implementation specific w=
rite_s2cr
 |1ecdcbfd8 07a7f2 .: 5.10| iommu/arm-smmu-qcom: Read back stream mappings
 |07ef43b72 f9081b .: 5.10| iommu/arm-smmu-qcom: Implement S2CR quirk
v |f802bce6f df9dba o: 5.10| ARM: dts: pandaboard: fix pinmux for gpio user=
 button of Pandaboard ES
a |2b4069d86 df9dba o: 4.19| ARM: dts: pandaboard: fix pinmux for gpio user=
 button of Pandaboard ES
v |85c035186 85b835 o: 5.10| ARM: dts: at91: sama5d2: fix CAN message ram o=
ffset and size
a |1dd429392 85b835 o: 4.19| ARM: dts: at91: sama5d2: fix CAN message ram o=
ffset and size
 |975530fa4 bd7cd7 o: 5.10| ARM: tegra: Populate OPP table for Tegra20 Vent=
ana
 |da79cc3d6 15261b .: 5.10| xprtrdma: Fix XDRBUF_SPARSE_PAGES support
 |8ff9b3451 d5c243 .: 5.10| powerpc/32: Fix vmap stack - Properly set r1 be=
fore activating MMU on syscall too
v |7a38af77b d85be8 .: 5.10| powerpc: Fix incorrect stw{, ux, u, x} instruc=
tions in __set_pte_at
a |9a50012e1 d85be8 .: 4.19| powerpc: Fix incorrect stw{, ux, u, x} instruc=
tions in __set_pte_at
v |76cd31a71 f10881 .: 5.10| powerpc/rtas: Fix typo of ibm,open-errinjct in=
 RTAS filter
a |42ba294ba f10881 .: 4.19| powerpc/rtas: Fix typo of ibm,open-errinjct in=
 RTAS filter
 |a70ddee4e 1891ef .: 5.10| powerpc/bitops: Fix possible undefined behaviou=
r with fls() and fls64()
 |c6d2c7156 197493 .: 5.10| powerpc/feature: Add CPU_FTR_NOEXECUTE to G2_LE
v |34d9d8715 7c6c86 .: 5.10| powerpc/xmon: Change printk() to pr_cont()
a just a printk tweak |6453c238a 7c6c86 .: 4.19| powerpc/xmon: Change print=
k() to pr_cont()
 |e7b556a45 1e78f7 .: 5.10| powerpc/8xx: Fix early debug when SMC1 is reloc=
ated
 |814efa7cc 17179a .: 5.10| powerpc/mm: Fix verification of MMU_FTR_TYPE_44x
 |305e4181b b1198a .: 5.10| powerpc/powernv/npu: Do not attempt NPU2 setup =
on POWER8NVL NPU
v |18b7386bd c74cf7 .: 5.10| powerpc/powernv/memtrace: Don't leak kernel me=
mory to user space
a |2ff69f15f c74cf7 .: 4.19| powerpc/powernv/memtrace: Don't leak kernel me=
mory to user space
v |38bc52c27 d67189 .: 5.10| powerpc/powernv/memtrace: Fix crashing the ker=
nel when enabling concurrently
! changes error code |7d9015b18 d67189 .: 4.19| powerpc/powernv/memtrace: F=
ix crashing the kernel when enabling concurrently
 |7399c7875 89bdfa o: 5.10| ovl: make ioctl() safe
v |2eed6766f 207cdd o: 5.10| ima: Don't modify file descriptor mode on the =
fly
! description says 4.20+ |4eae95ae7 207cdd o: 4.19| ima: Don't modify file =
descriptor mode on the fly
 |d8976e364 97be7c .: 5.10| um: Remove use of asprinf in umid.c
 |1793de57d ff9632 .: 5.10| um: Fix time-travel mode
v |9f3e58a72 e5cafc o: 5.10| ceph: fix race in concurrent __ceph_remove_cap=
 invocations
v |21a6ca9b2 e5cafc o: 4.19| ceph: fix race in concurrent __ceph_remove_cap=
 invocations
a not a minimum fix |7e2b3f9dc e5cafc o:  4.4| ceph: fix race in concurrent=
 __ceph_remove_cap invocations
v |ace6201c2 ebcd6d o: 5.10| SMB3: avoid confusing warning message on mount=
 to Azure
a just a printk tweak |063aee939 ebcd6d o: 4.19| SMB3: avoid confusing warn=
ing message on mount to Azure
 |893c445d9 bc7c41 o: 5.10| SMB3.1.1: remove confusing mount warning when n=
o SPNEGO info on negprot rsp
v |459fce4fa 7955f1 o: 5.10| SMB3.1.1: do not log warning message if server=
 doesn't populate salt
a just a printk tweak, not a minimum fix |cd35396b0 7955f1 o: 4.19| SMB3.1.=
1: do not log warning message if server doesn't populate salt
v |a7f50b8ef 20f143 o: 5.10| ubifs: wbuf: Don't leak kernel memory to flash
! introduce helper? |3804d6b11 20f143 o: 4.19| ubifs: wbuf: Don't leak kern=
el memory to flash
v |0531ad2f6 9afc9a o: 5.10| jffs2: Fix GC exit abnormally
v |33bb619ea 9afc9a o: 4.19| jffs2: Fix GC exit abnormally
! c/e |b9a016b3d 9afc9a o:  4.4| jffs2: Fix GC exit abnormally
 |42fb4437c 08cd27 o: 5.10| jffs2: Fix ignoring mounting options problem du=
ring remounting
 |658314571 950cc0 o: 5.10| fsnotify: generalize handle_inode_event()
 |d524ac88e 1a2620 o: 5.10| inotify: convert to handle_inode_event() interf=
ace
 |4f76737a3 fecc45 o: 5.10| fsnotify: fix events reported to watching paren=
t and child
Branches to rc



--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX+xiPAAKCRAw5/Bqldv6
8h0aAJ45T3ciwuK4J6ZY5AH4aKD2Z4je1QCfZ04vwxij69cq5aIX6wXCPPHs2Mg=
=XDA0
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--

--tjJmqwXLxpVQi7S7QFV2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5981): https://lists.cip-project.org/g/cip-dev/message=
/5981
Mute This Topic: https://lists.cip-project.org/mt/79310401/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--tjJmqwXLxpVQi7S7QFV2--
