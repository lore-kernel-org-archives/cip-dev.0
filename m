Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3890CCA470
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 01:46:39 +0000 (UTC)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
 by mx.groups.io with SMTP id smtpd.web11.2591.1759369596597385118
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Oct 2025 18:46:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=aEpQhrFN;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.45, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-633be3be1e6so582340d50.1
        for <cip-dev@lists.cip-project.org>; Wed, 01 Oct 2025 18:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1759369595; x=1759974395; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c+5EUjI4fqjkvPAtjmD3G5YOHpJlHqfnomvxWJDWWGw=;
        b=aEpQhrFN6jznM3u/Im5v3JcJY9vfyVK6ADfyEvFt8x3gWQ428OsEGHU84U0AwIje7e
         wATGUjOB1Iw3YJgnkG2wlS7yWBiMZa23Je40yivnPMXC3M0+dPfJsdzFTuyqQ9C/J/3H
         pxzcDW7pzX2nkeG4HG7XIWGJyumoCVEPwAUDqVndGTX16K0FP8pQL8tOKlHB6OI9xiLF
         94016L1NoF+D94LPValnjtyXdZNGoof2LmCREFx7j6MaLEFQoLx7BzQgk319se68Qucu
         785fD0ZQu7a/1qO0IeHxteI+IF3Qwf1Y2iZQA4f6B7+KlEdW6c++Rj35lNZlxqQo7GCd
         Suug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759369595; x=1759974395;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c+5EUjI4fqjkvPAtjmD3G5YOHpJlHqfnomvxWJDWWGw=;
        b=XcmXq76wXLdP0szKV9rBI/zQA9gIheCmOtfPDoTLWraPU1KmOBJNs6Gcnh/+XC4WZd
         jrV3GEtSmE1tETQaInr08heLBvKEAHrO2QiXpTQEMJMy1uKeUILov86wURpp1fKOnH5Q
         KGZcviES3hn/tFbfVo+OEwk1g2VtxZYG9KD3HQ+3MEviJWZ1QaUdJiTPa+YKAcGJs1gx
         y4M3nQn48Q7/VmriRKpsDyMLBrqmB+B6CI7v33u/yd+1PDd0mtmY/7m2cee2sBRgsVt1
         QG+6yA/xHNW0DgcTOZnw7Q/9+4n53+1z0Fx+4xGrtkvnIBaYfysQkzY3DTmKqzoJ1vz5
         i3XA==
X-Gm-Message-State: AOJu0YwmbYwysrijRJLQqRmH71wm8/YaUaUiCly3GFNzadsvkHmuWJtl
	VBKUFTVjj+DpbB8NZDC/77cruuFCFefIAFJC8A5egNW2Qx+TyGlwIe2EgInLJM+GBkArlbZC4Nd
	0MzxQ6nnPZW0iFrQpz6wsllzMX1/1SIF+lbpXU+uCb+H0JeipeLzT8I0=
X-Gm-Gg: ASbGnctgOVXCRie1vCnure0MFiITPyJxIwHFU2yzeksa1tHxwDpgxJ7q1neoe5BDRHr
	xxepeOggytD8zbVFGCqydTGERhjrF6eqtdnNm7O0jW18owjnsrIF+aq6QXLOHgO0b7QTSzhWsvk
	N48Vq89sQ2VWPhEOL9Ay2WgN4S6oDIMy+ZC0pbBT2fhEwJD4RlF1ddHGqrvVLaXEGz5OJubh/Z2
	8zn1oINjOiJBECnnQucC6aLE8GhDhGq
X-Google-Smtp-Source: AGHT+IHtvQKABojh+Rfed/jqdURJkMXq9mn8BAZAYVNVPZ/etO+gHIf74Y3D8gTs83puFC4e6dGlrisEEHpzYX+G3Wg=
X-Received: by 2002:a05:690e:110:b0:636:cc3:af35 with SMTP id
 956f58d0204a3-63b83b8f1ffmr1698784d50.22.1759369593081; Wed, 01 Oct 2025
 18:46:33 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 2 Oct 2025 10:45:57 +0900
X-Gm-Features: AS18NWCFM_L-sb1sBaLuX8PdgePy9TSl-1pnjZDO5T2tSMK9ul8QWEoSSHK6GYQ
Message-ID: <CAODzB9p3Vy6T4F8ab6PFcyqtKRQbtGuDdHNa_BRa97B1WN37Lg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Oct 2025 01:46:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20153

Hi!

It's this week's CVE report.

This week reported 173 new CVEs and 3 updated CVEs.

* New CVEs
CVE-2021-4460: drm/amdkfd: Fix UBSAN shift-out-of-bounds warning

Announce: https://www.cve.org/CVERecord?id=CVE-2021-4460

Introduced commit is not determined.Fixed in v5.13-rc1.
Affected file was added by 64c7f8c ("amdkfd: Add device queue manager
module") in 3.19-rc1.

Fixed status
mainline: [50e2fc36e72d4ad672032ebf646cecb48656efe0]
stable/5.10: [1874b0ef1426b873de94c61861e38f29a8df714c]
stable/5.4: [0c0356ef2498c1a250fe3846f30293f828737309]

CVE-2022-50420: crypto: hisilicon/hpre - fix resource leak in remove process

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50420

Introduced commit is not determined.Fixed in v6.2-rc1.
Calling the hpre_sriov_disable was introduced by 5ec302a ("crypto:
hisilicon - add SRIOV support for HPRE") in 5.5-rc1.

Fixed status
mainline: [45e6319bd5f2154d8b8c9f1eaa4ac030ba0d330c]
stable/5.15: [2b3e3ecdb402ff1053ee25b598ff21b9ddf4384f]
stable/6.1: [cb873c93a7ad27681920bf062ef052fca1e8d5b1]

CVE-2022-50421: rpmsg: char: Avoid double destroy of default endpoint

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50421

Introduced by commit bea9b79 ("rpmsg: char: Add possibility to use
default endpoint of the rpmsg device") in v5.18-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [467233a4ac29b215d492843d067a9f091e6bf0c5]
stable/6.1: [467233a4ac29b215d492843d067a9f091e6bf0c5]

CVE-2022-50422: scsi: libsas: Fix use-after-free bug in smp_execute_task_sg()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50422

Introduced by commit 2908d77 ("[SCSI] aic94xx: new driver") in v2.6.20.16.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [46ba53c30666717cb06c2b3c5d896301cd00d0c0]
stable/5.10: [a9e5176ead6de64f572ad5c87a72825d9d3c82ae]
stable/5.15: [e45a1516d2933703a4823d9db71e17c3abeba24f]
stable/5.4: [117331a2a5227fb4369c2a1f321d3e3e2e2ef8fe]
stable/6.1: [46ba53c30666717cb06c2b3c5d896301cd00d0c0]

CVE-2022-50423: ACPICA: Fix use-after-free in
acpi_ut_copy_ipackage_to_ipackage()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50423

Introduced by commit 8aa5e56 ("ACPICA: Utilities: Fix memory leak in
acpi_ut_copy_iobject_to_iobject") in v3.17-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c9125b643fc51b8e662f2f614096ceb45a0adbc3]
cip/4.4-st: [0993034713a69866e436fc7e9926cb9e6e4fa70b]
mainline: [470188b09e92d83c5a997f25f0e8fb8cd2bc3469]
stable/5.10: [02617006b5a46f2ea55ac61f5693c7afd7bf9276]
stable/5.15: [6fde666278f91b85d71545a0ebbf41d8d7af8074]
stable/5.4: [dfdde4d5138bc023897033a5ac653a84e94805be]
stable/6.1: [01f2c2052ea50fb9a8ce12e4e83aed0267934ef0]

CVE-2022-50424: wifi: mt76: mt7921: resource leaks at
mt7921_check_offload_capability()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50424

Introduced by commit 034ae28 ("wifi: mt76: mt7921: introduce
remain_on_channel support") in v6.2-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47180ecf4541146836c5307c1d5526f8ac6a5a6d]

CVE-2022-50425: x86/fpu: Fix copy_xstate_to_uabi() to copy init states correctly

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50425

Introduced by commit 2308ee5 ("x86/fpu/amx: Enable the AMX feature in
64-bit mode") in v5.16-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [471f0aa7fa64e23766a1473b32d9ec3f0718895a]
stable/6.1: [471f0aa7fa64e23766a1473b32d9ec3f0718895a]

CVE-2022-50426: remoteproc: imx_dsp_rproc: Add mutex protection for workqueue

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50426

Introduced by commit ec0e554 ("remoteproc: imx_dsp_rproc: Add
remoteproc driver for DSP on i.MX") in v5.16-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47e6ab07018edebf94ce873cf50a05ec76ff2dde]
stable/6.1: [b9693304b7133b81741add5bfb56f022596df012]

CVE-2022-50427: ALSA: ac97: fix possible memory leak in snd_ac97_dev_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50427

Introduced by commit 0ca06a0 ("[ALSA] AC97 bus interface for ad-hoc
drivers") in v2.6.20.16.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ee8bf0946f62ef00e5db4b613a9f664ac567259a]
cip/4.4-st: [da7860843a799f040f056d9938efce1d48e7f452]
mainline: [4881bda5ea05c8c240fc8afeaa928e2bc43f61fa]
stable/5.10: [bfce73088682ef0770da951f51156c36a89be490]
stable/5.15: [4fdf6f978c6b605ca0d67bf0e982b7a8fc0f4aab]
stable/5.4: [758dbcc6fbf2286eff02743b093c70a18a407d66]
stable/6.1: [4881bda5ea05c8c240fc8afeaa928e2bc43f61fa]

CVE-2022-50428: ext4: fix off-by-one errors in fast-commit block filling

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50428

Introduced by commit aa75f4d ("ext4: main fast-commit commit path") in
v5.10-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48a6a66db82b8043d298a630f22c62d43550cae5]
stable/5.15: [18f28f13301d1afb8cea9c4ddcecdbff14488ec6]
stable/6.1: [5439ad45c0d0c8db41eb6f4dce6f778f15a5ee16]

CVE-2022-50429: memory: of: Fix refcount leak bug in of_lpddr3_get_ddr_timings()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50429

Introduced by commit 976897d ("memory: Extend of_memory with LPDDR3
support") in v5.5-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48af14fb0eaa63d9aa68f59fb0b205ec55a95636]
stable/5.10: [1d312c12c91f831fcc48623c921f2d4560edb159]
stable/5.15: [7e053784c4c70df28324106d476778be7a4519b3]
stable/6.1: [48af14fb0eaa63d9aa68f59fb0b205ec55a95636]

CVE-2022-50430: mmc: vub300: fix warning - do not call blocking ops
when !TASK_RUNNING

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50430

Introduced by commit 88095e7 ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC
driver") in v3.0-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6f7258c6f66692b3760c37ddd4bc9e02bb290da7]
cip/4.4-st: [6fe5b7b09a6f67aee7e8847cee469dd6dc3d4d7a]
mainline: [4a44cd249604e29e7b90ae796d7692f5773dd348]
stable/5.10: [b51d5fed9f53e07ce9fc65efb4ff1abe021a4c16]
stable/5.15: [d58289fc77f8c1f879c818bddaf7ef524c73658b]
stable/5.4: [f1c08947ab0538b07a0bd9d6edadfb5185f56344]
stable/6.1: [ba2e7d07dd06e646a72ba906a89fdc1cca7ea560]

CVE-2022-50431: ALSA: aoa: i2sbus: fix possible memory leak in i2sbus_add_dev()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50431

Introduced by commit f3d9478 ("[ALSA] snd-aoa: add snd-aoa") in v2.6.20.16.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [027fee10e3a400cf6f3237374a1248da1082807b]
cip/4.4-st: [498530feefa371deb92d9497f7f7aad321b3afb0]
mainline: [4a4c8482e370d697738a78dcd7bf2780832cb712]
stable/5.10: [ce6fd1c382a38b75557db85a2fe99d285540a03d]
stable/5.15: [e81d7826b8f40430a1ea1b330e24d9a9eb4512c4]
stable/5.4: [5bdea674534153110b90d70b02f2fbaf48b2c0eb]
stable/6.1: [4a4c8482e370d697738a78dcd7bf2780832cb712]

CVE-2022-50432: kernfs: fix use-after-free in __kernfs_remove

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50432

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [028cf780743eea79abffa7206b9dcfc080ad3546]
cip/4.4-st: [30d583eb7a4f705d21daf060a894ba7014dafe8a]
mainline: [4abc99652812a2ddf932f137515d5c5a04723538]
stable/5.10: [6f72a3977ba9d0e5491a5c01315204272e7f9c44]
stable/5.15: [94d2643df1e70a4c310ebb5e2c493eec33df1a06]
stable/5.4: [c78b0dc6fb7fb389d674e491fd376388cdfb1d53]
stable/6.1: [4abc99652812a2ddf932f137515d5c5a04723538]

CVE-2022-50433: efi: ssdt: Don't free memory if ACPI table was loaded
successfully

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50433

Introduced by commit 3881ee0 ("efi: avoid efivars layer when loading
SSDTs from variables") in v6.0-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b017e59f01097f19b938f6dc4dc2c4720701610]
stable/6.1: [4b017e59f01097f19b938f6dc4dc2c4720701610]

CVE-2022-50434: blk-mq: fix possible memleak when register 'hctx' failed

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50434

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [02bc8bc6eab03c84373281b85cb6e98747172ff7]
cip/4.4-st: [4f4f698f1cc40253f09f32c842b6b9e5a343911f]
mainline: [4b7a21c57b14fbcd0e1729150189e5933f5088e9]
stable/5.10: [e8022da1fa2fdf2fa204b445dd3354e7a66d085a]
stable/5.15: [eff45bfbc25a2509a6362dea6e699e14083c693c]
stable/5.4: [87fd18016a47ea8ae12641377a390172c4aa97a7]
stable/6.1: [33e8a3f61814ea30615d0fafaf50477975d6c1ca]

CVE-2022-50435: ext4: avoid crash when inline data creation follows DIO write

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50435

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [59b108630a4987f71e1dc1dc50b8062e992b49c6]
cip/4.4-st: [bb3efcf56d345170370ae5e9ed40d1336fd494f8]
mainline: [4bb26f2885ac6930984ee451b952c5a6042f2c0e]
stable/5.10: [fb98cb61efff3b2a1964939465ccaaf906af1d4f]
stable/5.15: [d8e4af8314df54d94cf2a541cf9c8626afe81d41]
stable/5.4: [a22f52d883313bbfaf864669c14003f9456d4f8f]
stable/6.1: [4bb26f2885ac6930984ee451b952c5a6042f2c0e]

CVE-2022-50436: ext4: don't set up encryption key during jbd2 transaction

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50436

Introduced by commit a80f7fc ("ext4: fixup ext4_fc_track_* functions'
signature") in v5.10-rc4.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c0d5778385cb3618ff26a561ce41de2b7d9de70]
stable/5.10: [23ad034760dd38e12b0e0e1b28b9629f330810a1]
stable/5.15: [6220ec405571ded17efedc56587190b542adf246]
stable/6.1: [1ba993208bcfd691e241483420a2a761d3f15750]

CVE-2022-50437: drm/msm/hdmi: fix memory corruption with too many bridges

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50437

Introduced by commit a3376e3 ("drm/msm: convert to drm_bridge") in v3.12-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3c43f3ec731c233eb84b66199ee76dbf3ec6ecae]
cip/4.4-st: [fe532b2f8333b7a72952489788c29aabb32c1c29]
mainline: [4c1294da6aed1f16d47a417dcfe6602833c3c95c]
stable/5.10: [08c7375fa27a8ceee028868e03ffb3a0db919d44]
stable/5.15: [b48949ab451eaf1e2c04c272c8a9a96a2b56546f]
stable/5.4: [ed7f1ff87a4afea1bc220d2ff00a7ce8e61f0b53]
stable/6.1: [4c1294da6aed1f16d47a417dcfe6602833c3c95c]

CVE-2022-50438: net: hinic: fix memory leak when reading function table

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50438

Introduced by commit 5215e16 ("hinic: add support to query function
table") in v5.10-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c1f602df8956bc0decdafd7e4fc7eef50c550b1]
stable/5.10: [bb01910763f935b16538084b4269696e0de17f79]
stable/5.15: [e6765fe8de372a84f8dbe9e03ec13c7c70f946b8]
stable/6.1: [4c1f602df8956bc0decdafd7e4fc7eef50c550b1]

CVE-2022-50439: ASoC: mediatek: mt8173: Enable IRQ when pdata is ready

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50439

Introduced by commit ee0bcaf ("ASoC: mediatek: Add AFE platform
driver") in v4.2-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cbb264d4e9136acab2c8fd39e39ab1b1402b84b]
stable/5.10: [57491967ad8f865a9a81d08c36b26facd14d84e5]
stable/5.15: [27e7cf595d4a9fea9d3906b47d0faa87896beeb3]
stable/5.4: [190685ff4ee03eef8f12c71d8f626e414fa078a9]
stable/6.1: [77c6b6be7e80ca4a4d4b66b63fd5bb48ccefdd5a]

CVE-2022-50440: drm/vmwgfx: Validate the box size for the snooped cursor

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50440

Introduced by commit 2ac8637 ("vmwgfx: Snoop DMA transfers with
non-covering sizes") in v3.2-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6b4e70a428b5a11f56db94047b68e144529fe512]
cip/4.4-st: [b72b4b251971a78faf9a2e68144df537853e12f5]
mainline: [4cf949c7fafe21e085a4ee386bb2dade9067316e]
stable/5.10: [439cbbc1519547f9a7b483f0de33b556ebfec901]
stable/5.15: [6948e570f54f2044dd4da444b10471373a047eeb]
stable/5.4: [94b283341f9f3f0ed56a360533766377a01540e0]
stable/6.1: [622d527decaac0eb65512acada935a0fdc1d0202]

CVE-2022-50441: net/mlx5: Lag, fix failure to cancel delayed bond work

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50441

Introduced by commit 0d4e8ed ("net/mlx5: Lag, avoid lockdep warnings")
in v6.1-rc7.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d1c1379d71777ddeda3e54f8fc26e9ecbfd1009]
stable/6.1: [8f1b8b3133504bf9125ee507ddcc3a8fb41a41f0]

CVE-2022-50442: fs/ntfs3: Validate buffer length while parsing index

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50442

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected file was added by 82cae26 ("fs/ntfs3: Add initialization of
super block") in 5.15-rc1. The ntfs3 was introduced in 5.15-rc1.

Fixed status
mainline: [4d42ecda239cc13738d6fd84d098a32e67b368b9]
stable/5.15: [3cd9e5b41b83bb57ac3cf9888f9fef2a6ef8ed96]
stable/6.1: [3f6f75e8863f41c8b3dbfd9d99e3963aaca42601]

CVE-2022-50443: drm/rockchip: lvds: fix PM usage counter unbalance in poweron

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50443

Introduced by commit 34cc0aa ("drm/rockchip: Add support for Rockchip
Soc LVDS") in v4.15-rc1.
Introduced by commit cca1705 ("drm/rockchip: lvds: Add PX30 support")
in v5.6-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4dba27f1a14592ac4cf71c3bc1cc1fd05dea8015]
stable/5.10: [110bf15825edf4f20bc4e56aba624297861b06ab]
stable/5.15: [f6ed73db390319b248b91a6325da1a48ad85e0d1]
stable/6.1: [12a9b4c4ebd9a0ba856370e088564af83cffd565]

CVE-2022-50444: clk: tegra20: Fix refcount leak in tegra20_clock_init

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50444

Introduced by commit 37c26a9 ("clk: tegra: add clock support for
Tegra20") in v3.9-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0172d14f50098f5736b4b272a1529a3e05419bd6]
cip/4.4-st: [b02960ff6ddafef0c42321c9070dc520d93316cf]
mainline: [4e343bafe03ff68a62f48f8235cf98f2c685468b]
stable/5.10: [70f0a0a27d79f689defc5f5f0bd47d07813e6dea]
stable/5.15: [d6e750535b46e12cdde185b416c415e49e4e6e22]
stable/5.4: [5d9fb09612defe7b1d5627db7b3833b46eb21e7b]
stable/6.1: [4e343bafe03ff68a62f48f8235cf98f2c685468b]

CVE-2022-50445: xfrm: Reinject transport-mode packets through workqueue

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50445

Introduced by commit acf568e ("xfrm: Reinject transport-mode packets
through tasklet") in v4.15-rc6.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f4920669d21e1060b7243e5118dc3b71ced1276]
stable/5.15: [7d98b26684cb2390729525b341ea099f0badbe18]
stable/6.1: [4f4920669d21e1060b7243e5118dc3b71ced1276]

CVE-2022-50446: ARC: mm: fix leakage of memory allocated for PTE

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50446

Introduced by commit d9820ff ("ARC: mm: switch pgtable_t back to
struct page *") in v5.15-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4fd9df10cb7a9289fbd22d669f9f98164d95a1ce]
stable/5.15: [14009ada5712649589ab4ad0441b811780ea8773]
stable/6.1: [4fd9df10cb7a9289fbd22d669f9f98164d95a1ce]

CVE-2022-50447: Bluetooth: hci_conn: Fix crash on hci_create_cis_sync

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50447

Introduced by commit 26afbd8 ("Bluetooth: Add initial implementation
of CIS connections") in v6.0-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50757a259ba78c4e938b5735e76ffec6cd0c942e]
stable/6.1: [09a3b0c9c7c6b10587fbb610b718014703cff341]

CVE-2022-50448: mm/uffd: fix warning without PTE_MARKER_UFFD_WP compiled in

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50448

Introduced by commit b1f9e87 ("mm/uffd: enable write protection for
shmem & hugetlbfs") in v5.19-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [515778e2d790652a38a24554fdb7f21420d91efc]
stable/6.1: [515778e2d790652a38a24554fdb7f21420d91efc]

CVE-2022-50449: clk: samsung: Fix memory leak in _samsung_clk_register_pll()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50449

Introduced by commit 3ff6e0d ("clk: samsung: Add support to register
rate_table for samsung plls") in v3.12-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [2e8dc0626fe86ae08914478dec1419618c557bc0]
mainline: [5174e5b0d1b669a489524192b6adcbb3c54ebc72]
stable/5.10: [da13355bb9961316d124f94dfc7a1385d0fb035a]
stable/5.15: [4e501a31af8efa593a2f003637b56d00b75dca23]
stable/5.4: [a00b4e0fa27317957536abf8f5d6a96d6cb9d9be]
stable/6.1: [a35323218ff32782d051d2643912311a22e07b6a]

CVE-2022-50450: libbpf: Use elf_getshdrnum() instead of e_shnum

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50450

Introduced by commit 0d6988e ("libbpf: Fix section counting logic") in
v5.17-rc1.
Introduced by commit 25bbbd7 ("libbpf: Remove assumptions about
uniqueness of .rodata/.data/.bss maps") in v5.16-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51deedc9b8680953437dfe359e5268120de10e30]
stable/6.1: [622ff59742fe7bf53c06a57332040fa0e08b8242]

CVE-2022-50451: fs/ntfs3: Fix memory leak on ntfs_fill_super() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50451

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected file was added by 82cae26 ("fs/ntfs3: Add initialization of
super block") in 5.15-rc1. The ntfs3 support was addd in 5.15

Fixed status
mainline: [51e76a232f8c037f1d9e9922edc25b003d5f3414]
stable/5.15: [2dd9ccfb06bcdad30ad92d96c3affa38a458679e]
stable/6.1: [2600c80ea7b39f987c3fa89287e73d62e322bbbd]

CVE-2022-50452: net: sched: cake: fix null pointer access issue when
cake_init() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50452

Introduced by commit 046f6fd ("sched: Add Common Applications Kept
Enhanced (cake) qdisc") in v4.19-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [86aa1390898146f1de277bb6d2a8ed7fc7a43f12]
mainline: [51f9a8921ceacd7bf0d3f47fa867a64988ba1dcb]
stable/5.10: [ae48bee2830bf216800e1447baca39541e27a12e]
stable/5.15: [154f4c06d9dbec1a14e91286c70b6305810302e0]
stable/5.4: [bc8301ea7e7f1bb9d2ba2fcdf7b5ec2f0792b47e]
stable/6.1: [51f9a8921ceacd7bf0d3f47fa867a64988ba1dcb]

CVE-2022-50453: gpiolib: cdev: fix NULL-pointer dereferences

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50453

Introduced by commit d7c51b4 ("gpio: userspace ABI for reading/writing
GPIO lines") in v4.8-rc1.
Introduced by commit 3c0d9c6 ("gpiolib: cdev: support
GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL") in
v5.10-rc1.
Introduced by commit aad9558 ("gpiolib: cdev: support
GPIO_V2_GET_LINEINFO_IOCTL and GPIO_V2_GET_LINEINFO_WATCH_IOCTL") in
v5.10-rc1.
Introduced by commit a54756c ("gpiolib: cdev: support
GPIO_V2_LINE_SET_CONFIG_IOCTL") in v5.10-rc1.
Introduced by commit 7b8e00d ("gpiolib: cdev: support
GPIO_V2_LINE_SET_VALUES_IOCTL") in v5.10-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [533aae7c94dbc2b14301cfd68ae7e0e90f0c8438]
stable/5.10: [6d79546622baab843172b52c3af035f83c1b21df]
stable/5.15: [7c755a2d6df511eeb5afba966ac28140f9ea5063]
stable/6.1: [ac6ce3cd7a3e10a2e37b8970bab81b4d33d5cfc3]

CVE-2022-50454: drm/nouveau: fix a use-after-free in
nouveau_gem_prime_import_sg_table()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50454

Introduced by commit 019cbd4 ("drm/nouveau: Initialize GEM object
before TTM object") in v5.4-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [540dfd188ea2940582841c1c220bd035a7db0e51]
stable/5.10: [5d6093c49c098d86c7b136aba9922df44aeb6944]
stable/5.15: [861f085f81fd569b02cc2c11165a9e6cca144424]
stable/5.4: [56ee9577915dc06f55309901012a9ef68dbdb5a8]
stable/6.1: [540dfd188ea2940582841c1c220bd035a7db0e51]

CVE-2022-50455: nfs: fix possible null-ptr-deref when parsing param

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50455

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
mainline: [5559405df652008e56eee88872126fe4c451da67]
stable/6.1: [55513864b418c6453d68aebc36cffcf965342426]

CVE-2022-50456: btrfs: fix resolving backrefs for inline extent
followed by prealloc

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50456

Introduced commit is not determined.Fixed in v6.2-rc3.


Fixed status
mainline: [560840afc3e63bbe5d9c5ef6b2ecf8f3589adff6]
stable/5.10: [0061ab5153fb8bc574b44fbb773680d0ede48c9c]
stable/5.15: [99590f29b2b7567fda2b503aa3d81a0d3e09dce5]
stable/5.4: [c59ee1528b3432ec9dca220567f7eb507820917a]
stable/6.1: [a94b90ac1f251d1007c0c43ee289a61b50f2505f]

CVE-2022-50457: mtd: core: Fix refcount error in del_mtd_device()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50457

Introduced by commit 0059657 ("mtd: core: clear out unregistered
devices a bit more") in v5.17-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56570bdad5e31c5c538cd6efff5c4510256e1bb4]
stable/6.1: [616dc895d982026f41f500c88d1bfea004938cc8]

CVE-2022-50458: clk: tegra: Fix refcount leak in tegra210_clock_init

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50458

Introduced by commit 6b301a0 ("clk: tegra: Add support for Tegra210
clocks") in v4.5-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ac010ec3484ba95c6ab3d946f9a83560005c13c6]
mainline: [56c78cb1f00a9dde8cd762131ce8f4c5eb046fbb]
stable/5.10: [f487137a53b1a0692211f7ae82c0a7f87c30bdbe]
stable/5.15: [417ed4432b1b40526b1cb50e535d46900505f6d9]
stable/5.4: [6d3ac23b952f374017e1a5249d1f03bdbc7f9878]
stable/6.1: [56c78cb1f00a9dde8cd762131ce8f4c5eb046fbb]

CVE-2022-50459: scsi: iscsi: iscsi_tcp: Fix null-ptr-deref while
calling getpeername()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50459

Introduced by commit bcf3a29 ("scsi: iscsi: iscsi_tcp: Avoid holding
spinlock while calling getpeername()") in v5.9-rc8.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57569c37f0add1b6489e1a1563c71519daf732cf]
stable/5.10: [884a788f065578bb640382279a83d1df433b13e6]
stable/5.15: [a26b0658751bb0a3b28386fca715333b104d32a2]
stable/6.1: [57569c37f0add1b6489e1a1563c71519daf732cf]

CVE-2022-50460: cifs: Fix xid leak in cifs_flock()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50460

Introduced by commit d067799 ("cifs: add support for flock") in v5.5-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [575e079c782b9862ec2626403922d041a42e6ed6]
stable/5.10: [2d08311aa3056a84bfdc09bc47777de6a9b16c30]
stable/5.15: [8905d13b9ede4caa88c577faed832d6c7383f4fb]
stable/6.1: [575e079c782b9862ec2626403922d041a42e6ed6]

CVE-2022-50461: net: ethernet: ti: am65-cpsw: Fix PM runtime leakage
in am65_cpsw_nuss_ndo_slave_open()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50461

Introduced by commit 93a7653 ("net: ethernet: ti: introduce
am65x/j721e gigabit eth subsystem driver") in v5.7-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5821504f5073983733465b8bc430049c4343bbd7]
stable/6.1: [a8846b3398600a632696b6cf79f8a44a107eb226]

CVE-2022-50462: MIPS: vpe-mt: fix possible memory leak while module exiting

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50462

Introduced by commit 1fa5ae8 ("driver core: get rid of struct device's
bus_id string array") in v2.6.30-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [851ae5640875f06494e40002cd503b11a634c6fb]
cip/4.4-st: [5d4e2d439e0dfb72e77effffba6e3aabee06b386]
mainline: [5822e8cc84ee37338ab0bdc3124f6eec04dc232d]
stable/5.10: [48d42f4464d713fbdd79f334fdcd6e5be534cc67]
stable/5.15: [e820a8192ff68570100347855b567512aec43819]
stable/5.4: [b3325a443525e3b89151879b834519b21c5e3011]
stable/6.1: [ab3d47c1fd0202821abd473ca87580faafd47847]

CVE-2022-50463: powerpc/52xx: Fix a resource leak in an error handling path

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50463

Introduced by commit 3c9059d ("powerpc/5200: add LocalPlus bus FIFO
device driver") in v2.6.33-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e4002f293e5b44e57d2930513cca0dff32249812]
cip/4.4-st: [6b35f0f32c4456382ab2e7cd2ab0ae0c604f2cdb]
mainline: [5836947613ef33d311b4eff6a32d019580a214f5]
stable/5.10: [40b4be399e0db7073dec5a0de5ca9994f7e31e58]
stable/5.15: [0accd460dc7bbe5f55e41a8867c63db9d07b3ec8]
stable/5.4: [9bf842ffdd216b9f94d5b051b5d8b815f2426538]
stable/6.1: [fb3ef6a5af4b003502c940ea50c0f55b06ebbfc9]

CVE-2022-50464: mt76: mt7915: Fix PCI device refcount leak in
mt7915_pci_init_hif2()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50464

Introduced by commit 9093cff ("mt76: mt7915: add support for using a
secondary PCIe link for gen1") in v5.12-rc1.
Introduced by commit 2e30db0 ("mt76: mt7915: add device id for
mt7916") in v5.18-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5938196cc188ba4323bc6357f5ac55127d715888]
stable/6.1: [2d4b9c7e81f3a4df27749ebecb426b145e68be2a]

CVE-2022-50465: ext4: fix leaking uninitialized memory in fast-commit journal

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50465

Introduced by commit aa75f4d ("ext4: main fast-commit commit path") in
v5.10-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [594bc43b410316d70bb42aeff168837888d96810]
stable/5.10: [b8b7922374b00a44137e5bcdd46ef86c8b065f27]
stable/5.15: [871800770d7f2f952c7249ad52485c3564dab44e]
stable/6.1: [7c1fb65e8ce85c281d2cba9c236f9edbbc4eaca6]

CVE-2022-50466: fs/binfmt_elf: Fix memory leak in load_elf_binary()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50466

Introduced by commit 0693ffe ("fs/binfmt_elf.c: allocate less for
static executable") in v5.7-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [594d2a14f2168c09b13b114c3d457aa939403e52]
stable/5.10: [706215300411d48db6b51a5832b872632a84bbc1]
stable/5.15: [265b6fb780f57d10449a40e94219b28fa52479cc]
stable/6.1: [594d2a14f2168c09b13b114c3d457aa939403e52]

CVE-2022-50467: scsi: lpfc: Fix null ndlp ptr dereference in abnormal
exit path for GFT_ID

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50467

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected function was added by a0f2d3e ("scsi: lpfc: NVME Initiator:
Merge into FC discovery") in 4.11-rc1

Fixed status
mainline: [59b7e210a522b836a01516c71ee85d1d92c1f075]
stable/6.1: [59b7e210a522b836a01516c71ee85d1d92c1f075]

CVE-2022-50468: platform/chrome: cros_usbpd_notify: Fix error handling
in cros_usbpd_notify_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50468

Introduced by commit ec2daf6 ("platform: chrome: Add cros-usbpd-notify
driver") in v5.7-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a2d96623670155d94aca72c320c0ac27bdc6bd2]
stable/5.10: [5c0cacdd354987f8f5348d16908716f154047890]
stable/5.15: [cab345f9d51943898e406275f9607c145adb1877]
stable/6.1: [751f12696d797e785d2611099fe9f0569d47556e]

CVE-2022-50469: staging: rtl8723bs: fix potential memory leak in
rtw_init_drv_sw()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50469

Introduced commit is not determined.Fixed in v6.1-rc1.
Affeced file was added by 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in 4.12-rc1.

Fixed status
mainline: [5a5aa9cce621e2c0e25a1e5d72d6be1749167cc0]
stable/5.15: [b4573a2bad3c3e2643ef3939079eb7035a30e6ee]
stable/6.1: [5a5aa9cce621e2c0e25a1e5d72d6be1749167cc0]

CVE-2023-53448: fbdev: imxfb: Removed unneeded release_mem_region

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53448

Introduced by commit b083c22 ("video: fbdev: imxfb: Convert
request_mem_region + ioremap to devm_ioremap_resource") in v6.0-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45fcc058a75bf5d65cf4c32da44a252fbe873cd4]
stable/6.1: [6aa851f6276fa08cd59b044bc2b803c49edf58a2]

CVE-2023-53449: s390/dasd: Fix potential memleak in dasd_eckd_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53449

Introduced by commit 9e12e54 ("s390/dasd: Handle out-of-space
constraint") in v5.3-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [460e9bed82e49db1b823dcb4e421783854d86c40]
stable/5.10: [a50e28d433acf22258f9f34831057387f04ef074]
stable/5.15: [544a552be0869231799784279d52704c4d314d33]
stable/5.4: [ee986d80acdef710a886be404308188ea11000c8]
stable/6.1: [ef3a7ffc0a6f833578bc8d1dcb79d0633c7e4ec3]

CVE-2023-53450: ext4: remove a BUG_ON in ext4_mb_release_group_pa()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53450

Introduced commit is not determined.Fixed in v6.4-rc2.


Fixed status
cip/4.19-st: [ef16d8a1798db1a1604ac44ca1bd73ec6bebf483]
cip/4.4-st: [22a0589c40d77e80921d98558475422d6d2c784e]
mainline: [463808f237cf73e98a1a45ff7460c2406a150a0b]
stable/5.10: [b0fc279de4bf17e1710bb7e83906538ff8f11111]
stable/5.15: [978e5e9111af18741449b81fefd531a622dd969a]
stable/5.4: [185062a21976fbc38f2efd296951b02c4500cf65]
stable/6.1: [d87a4e4094c9879fc8acdff8ce59fdffa979c8e0]

CVE-2023-53451: scsi: qla2xxx: Fix potential NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53451

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [ee4c9a93238b9ce3703942500cb1aeacf77090d2]
cip/4.4-st: [a43e260814470bfcfd8c6dea15ec76f48ee087ec]
mainline: [464ea494a40c6e3e0e8f91dd325408aaf21515ba]
stable/5.10: [2bea9c1c983152c5411f5a2f1113cb790ce1389d]
stable/5.15: [5a52a2e14fe866541bbc0033058e44bf0bf0c580]
stable/5.4: [4f90a8b0481615622bd0558aa8cf361bea872045]
stable/6.1: [ce2cdbe530b0066bae1f98dbab590a232d507eaa]

CVE-2023-53452: wifi: rtw89: fix potential race condition between
napi_init and napi_enable

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53452

Introduced by commit e3ec701 ("rtw89: add Realtek 802.11ax driver") in
v5.16-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47515664ecfbde11425dff121f298ae4499425c9]
stable/6.1: [39712c8aeb79691bcec8bd6ff658cde1651e0803]

CVE-2023-53453: drm/radeon: free iio for atombios when driver shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53453

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [9cdb96b55651c92fc949cfd54124406c3c912b6b]
cip/4.4-st: [be735f0b37e5d2a789a704755dc0a4782ba5e7dc]
mainline: [4773fadedca918faec443daaca5e4ea1c0ced144]
stable/5.10: [ce9e9d3dcbb0d1551ffd1a7f16e7c051f3ba4140]
stable/5.15: [cda2f7efbc2d857220dad32e315a54565b285c1c]
stable/5.4: [f9f55fc64928b5e30d78f861c5fc76db9e769ebb]
stable/6.1: [107b8b542bb9dab4cbdc3276c85fbdd7f6782313]

CVE-2023-53454: HID: multitouch: Correct devm device reference for
hidinput input_dev name

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53454

Introduced by commit c08d46a ("HID: multitouch: devm conversion") in v3.12-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [39c70c19456e50dcb3abfe53539220dff0490f1d]
cip/4.4-st: [4d7af218c21c21709df85e89b2050b0a62bfde3e]
mainline: [4794394635293a3e74591351fff469cea7ad15a2]
stable/5.10: [15ec7cb55e7d88755aa01d44a7a1015a42bfce86]
stable/5.15: [dde88ab4e45beb60b217026207aa9c14c88d71ab]
stable/5.4: [df7ca43fe090e1a56c216c8ebc106ef5fd49afc6]
stable/6.1: [2763732ec1e68910719c75b6b896e11b6d3d622b]
stable/6.6: [4794394635293a3e74591351fff469cea7ad15a2]

CVE-2023-53455: drm/vc4: drop all currently held locks if deadlock happens

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53455

Introduced by commit 6bed2ea ("drm/vc4: hdmi: Reset link on hotplug")
in v6.1-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [479d4f0be4237ba33bc9432787aeb62c90e30f95]
stable/6.1: [41286a53e7f54202fd277cd516724de3ab7497c7]

CVE-2023-53456: scsi: qla4xxx: Add length check when parsing nlattrs

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53456

Introduced by commit 26ffd7b ("[SCSI] qla4xxx: Add support to set CHAP
entries") in v3.13-rc1.
Introduced by commit 1e9e2be ("[SCSI] qla4xxx: Add flash node mgmt
support") in v3.10-rc1.
Introduced by commit 00c3188 ("[SCSI] qla4xxx: fix data alignment and
use nl helpers") in v3.2-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5925e224cc6edfef57b20447f18323208461309b]
cip/4.4-st: [6af1decb5dc80cf073dcb87c4450763d8580c589]
mainline: [47cd3770e31df942e2bb925a9a855c79ed0662eb]
stable/5.10: [6d65079c69dc1feb817ed71f5bd15e83a7d6832d]
stable/5.15: [f61fc650c47849637fa1771a31a11674c824138a]
stable/5.4: [47f3be62eab50b8cd7e1ae5fc2c4dae687497c34]
stable/6.1: [25feffb3fbd51ae81d92c65cebc0e932663828b3]
stable/6.6: [47cd3770e31df942e2bb925a9a855c79ed0662eb]

CVE-2023-53457: FS: JFS: Fix null-ptr-deref Read in txBegin

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53457

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [1b4c144767736221cad92c132f72b3c6ed06a0ea]
cip/4.4-st: [edce7a27f8ccb58e91195d98483ac8d3f6839a5b]
mainline: [47cfdc338d674d38f4b2f22b7612cc6a2763ba27]
stable/5.10: [2a3f20efe6c901d4c0871cfd1d8c65e2ade71fc1]
stable/5.15: [3e94d0d378d2754b26fc54b429582553f7b53e15]
stable/5.4: [a7d17d6bd7cd4f6940b335ea7a6fce5b6d22adc2]
stable/6.1: [3e5eb6c5ecd8ddb9cfea751cf30f9e23eac97ca3]

CVE-2023-53458: media: cx23885: Fix a null-ptr-deref bug in
buffer_prepare() and buffer_finish()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53458

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [47e8b73bc35d7c54642f78e498697692f6358996]
stable/5.15: [f0a06203f2fe63f04311467200c99c4ee1926578]
stable/6.1: [6738841f6fcf23e9fc30e2449f32fc84ee19c6f1]

CVE-2023-53459: HID: mcp-2221: prevent UAF in delayed work

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53459

Introduced by commit 960f9df ("HID: mcp2221: add ADC/DAC support via
iio subsystem") in v6.2-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47e91fdfa511139f2549687edb0d8649b123227b]

CVE-2023-53460: wifi: rtw88: fix memory leak in rtw_usb_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53460

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected file was added by a82dfd3 ("wifi: rtw88: Add common USB chip
support") in 6.2-rc1.

Fixed status
mainline: [48181d285623198c33bb9698992502687b258efa]

CVE-2023-53461: io_uring: wait interruptibly for request completions on exit

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53461

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
mainline: [4826c59453b3b4677d6bf72814e7ababdea86949]
stable/5.10: [28e649dc9947e6525c95e32aa9a8e147925e3f56]
stable/5.15: [8e29835366138389bfad3b31ea06960d0a77bf77]
stable/6.1: [b50d6e06cca7b67a3d73ca660dda27662b76e6ea]

CVE-2023-53462: hsr: Fix uninit-value access in fill_frame_info()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53462

Introduced by commit 451d812 ("net: prp: add packet handling support")
in v5.9-rc1.
Fixed in v6.6-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [484b4833c604c0adcf19eac1ca14b60b757355b5]
stable/5.10: [1e90a93ac4845c31724ec5dc96fb51e608435a9d]
stable/5.15: [6a4480c5e6ebaf9f797ac300e2a97a02d4e70cfd]
stable/6.1: [61866f7d814e5792bf47410d7d3ff32e49bd292a]
stable/6.6: [484b4833c604c0adcf19eac1ca14b60b757355b5]

CVE-2023-53463: ibmvnic: Do not reset dql stats on NON_FATAL err

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53463

Introduced by commit 0d97338 ("ibmvnic: Introduce xmit_more support
using batched subCRQ hcalls") in v5.11-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48538ccb825b05544ec308a509e2cc9c013402db]
stable/5.15: [b8aedf29db1280c83191fc9579ae605791faf97f]
stable/6.1: [f67ef8f9f6776e2b2073cad7c5cf29de850f83d7]

CVE-2023-53464: scsi: iscsi_tcp: Check that sock is valid before
iscsi_set_param()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53464

Introduced by commit 57569c3 ("scsi: iscsi: iscsi_tcp: Fix
null-ptr-deref while calling getpeername()") in v6.1-rc1.
Fixed in v6.3-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [48b19b79cfa37b1e50da3b5a8af529f994c08901]
stable/5.10: [499757ad3332e2527254f9ab68dec1da087b1d96]
stable/5.15: [5e5c5f472972c4bc9430adc08b36763a0fa5b9f7]
stable/6.1: [6e06a68fbbfcd8576eee8f7139fa2b13c9b72e91]

CVE-2023-53465: soundwire: qcom: fix storing port config out-of-bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53465

Introduced by commit 9916c02 ("soundwire: qcom: cleanup internal port
config indexing") in v5.13-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [490937d479abe5f6584e69b96df066bc87be92e9]
stable/5.15: [20f7c4d51c94abb1a1a7c21900db4fb5afe5c8ff]
stable/6.1: [801daff0078087b5df9145c9f5e643c28129734b]

CVE-2023-53466: wifi: mt76: mt7915: fix memory leak in mt7915_mcu_exit

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53466

Introduced by commit e57b790 ("mt76: add mac80211 driver for MT7915
PCIe-based chipsets") in v5.8-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49bd78282e79ad177d14f37f4049f0605bf92dad]
stable/6.1: [4cbb876153b63fe248200f734069c6881cf97722]

CVE-2023-53467: wifi: rtw89: fix potential leak in rtw89_append_probe_req_ie()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53467

Introduced by commit 8959077 ("rtw89: 8852a: add
ieee80211_ops::hw_scan") in v5.18-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a0e218cc9c42d1903ade8b5a371dcf48cf918c5]
stable/6.1: [1e336d6bab68973084a18c1e4bd78cd0bbbdcacd]

CVE-2023-53468: ubifs: Fix memory leak in alloc_wbufs()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53468

Introduced by commit 1e51764 ("UBIFS: add new flash file system") in
v2.6.27-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a1ff3c5d04b9079b4f768d9a71b51c4af578dd2]
stable/5.10: [bf50229494f0443b3f08427d7df63e5a7e2a796a]
stable/5.15: [3e29634eb56e6547272fe4e568f63421f8b3b9fa]
stable/5.4: [1f206002c6bc302bface871ef3f72c0bbcaa931c]
stable/6.1: [26ec45f1c504e15268383019df139d7983f1e67f]

CVE-2023-53469: af_unix: Fix null-ptr-deref in unix_stream_sendpage().

Announce: no reference


Introduced by 869e7c6 ("net: af_unix: implement stream sendpage
support") in 4.2-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a3fcfc3b51796e5e6974041c9a7cf7808d16f9e]

CVE-2023-53470: ionic: catch failure from devlink_alloc

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53470

Introduced by commit df69ba4 ("ionic: Add basic framework for IONIC
Network device driver") in v5.4-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a54903ff68ddb33b6463c94b4eb37fc584ef760]
stable/5.15: [c177dd465f5c1e5f242cdb9258826c591c257e9a]
stable/6.1: [0d02efe7f25158c93146e3bb827bc7bb3cd5e71a]

CVE-2023-53471: drm/amdgpu/gfx: disable gfx9 cp_ecc_error_irq only
when enabling legacy gfx ras

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53471

Introduced commit is not determined.Fixed in v6.4-rc2.
Affected code was added by 760a1d5 ("drm/amdgpu: enable ras on gfx9
(v2)") in 5.2-rc1.

Fixed status
mainline: [4a76680311330aefe5074bed8f06afa354b85c48]
stable/5.10: [20ca90ceda71ed90a4d6960acbe7d5e120b40c0d]
stable/5.15: [cd3c0f7013c37cd24fc40b601319007f136c1201]
stable/5.4: [625d4112ea25dbad7ddf749fd5c1287ceffb2339]
stable/6.1: [f661ad53658a1ea35c004af1f5fbe25c4d1cdb08]

CVE-2023-53472: pwm: lpc32xx: Remove handling of PWM channels

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53472

Introduced by commit 3d2813f ("pwm: lpc32xx: Don't modify HW state in
.probe() after the PWM chip was registered") in v5.15-rc1.
Fixed in v6.6-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
cip/4.19-st: [a9a505f5b39d8fff1a55963a5e524c84639e98b2]
mainline: [4aae44f65827f0213a7361cf9c32cfe06114473f]
stable/5.10: [a2d9d884e84bfd37892219b1f55847f36d8e9901]
stable/5.15: [5e22217c11424ef958ba28d03ff7167b4d7a8914]
stable/5.4: [04301da4d87067a989f70ee56942bf9d97cd2a45]
stable/6.1: [523f6268e86552a048975749251184c4e9a4b38f]
stable/6.6: [4aae44f65827f0213a7361cf9c32cfe06114473f]

CVE-2023-53473: ext4: improve error handling from ext4_dirhash()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53473

Introduced commit is not determined.Fixed in v6.4-rc2.


Fixed status
mainline: [4b3cb1d108bfc2aebb0d7c8a52261a53cf7f5786]
stable/5.15: [b2531936118deb3f479c4fa1bcd787b74b8faa6a]
stable/6.1: [f68876aeef96ef8b708ab10b9cb47ce0a5adb424]

CVE-2023-53474: x86/MCE/AMD: Use an u64 for bank_map

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53474

Introduced by commit a0bc32b ("x86/mce: Increase maximum number of
banks to 64") in v5.10-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c1cdec319b9aadb65737c3eb1f5cb74bd6aa156]
stable/5.10: [a9b9ea0e63a0ec5e97bf1219ab6dcbd55e362f83]
stable/5.15: [11c58a0c1937c157dbdf82d5ab634d68c99f3098]
stable/6.1: [ba8ffb1251eb629c2ec35220e3896cf4f7b888a7]

CVE-2023-53475: usb: xhci: tegra: fix sleep in atomic call

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53475

Introduced by commit f836e78 ("usb: xhci-tegra: Add OTG support") in v5.7-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c7f9d2e413dc06a157c4e5dccde84aaf4655eb3]
stable/5.10: [b4b4f17aa46c025da77aed5133b08971959c9684]
stable/5.15: [1122474b757a5dd8b2b50008a97f33cdb10dff6e]
stable/6.1: [130c61c516cd0684282a8f6ab163281d60642fc5]

CVE-2023-53476: iw_cxgb4: Fix potential NULL dereference in
c4iw_fill_res_cm_id_entry()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53476

Introduced by commit 116aeb8 ("iw_cxgb4: provide detailed
provider-specific CM_ID information") in v4.18-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ca446b127c568b59cb8d9748b6f70499624bb18]
stable/5.15: [76e0396313c79ecd0df44ee3c18745cfac52b3e6]
stable/6.1: [24278dc380aab6a1aef0a75317f57ad4c2453cf6]

CVE-2023-53477: ipv6: Add lwtunnel encap size of all siblings in
nexthop calculation

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53477

Introduced by commit beb1afa ("net: ipv6: Add support to dump
multipath routes via RTA_MULTIPATH attribute") in v4.11-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cc59f386991ec9374cb4bc83dbe1c0b5a95033f]
stable/5.10: [da26369377f0b671c14692e2d65ceb38131053e1]
stable/5.15: [dcdddb5f490890d058ea1f194d661219e92fe88d]
stable/5.4: [aba298b35619213ca787d08d472049627d8cd012]
stable/6.1: [e11e4d524eba2d3c8fdf897d7ce3853f7573bae9]

CVE-2023-53478: tracing/synthetic: Fix races on freeing last_cmd

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53478

Introduced by commit 27c888d ("tracing: Remove size restriction on
synthetic event cmd error logging") in v5.18-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ccf11c4e8a8e051499d53a12f502196c97a758e]
stable/6.1: [9fe183f659a2704255e5d84f6ae308c234a113ec]

CVE-2023-53479: cxl/acpi: Fix a use-after-free in cxl_parse_cfmws()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53479

Introduced by commit e50fe01 ("cxl/core: Drop ->platform_res attribute
for root decoders") in v6.0-rc1.
Fixed in v6.5-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cf67d3cc9994a59cf77bb9c0ccf9007fe916afe]
stable/6.1: [748fadc08bcbdaf573b34d9784bb3dbd87441dbf]

CVE-2023-53480: kobject: Add sanity check for kset->kobj.ktype in
kset_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53480

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
cip/4.19-st: [039ec9db2d30032eafa365f5f89b30eca5322b05]
cip/4.4-st: [fc85988d66071b87c8c98852c8b4294325ef1d69]
mainline: [4d0fe8c52bb3029d83e323c961221156ab98680b]
stable/5.10: [5df5829158513134ddcaf2184d9286eda7b0bb18]
stable/5.15: [f3f6bf22a4f5ba649cf26ae4670de5c7f861bdef]
stable/5.4: [964e025ceefdf75da46b0133d0c2790de451aeec]
stable/6.1: [48aebbe801e78a8932404c122ed0e880ccedc220]
stable/6.6: [4d0fe8c52bb3029d83e323c961221156ab98680b]

CVE-2023-53481: ubi: ubi_wl_put_peb: Fix infinite loop when
wear-leveling work failed

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53481

Introduced by commit 43f9b25 ("UBI: bugfix: protect from volume
removal") in v2.6.25-rc1.
Introduced by commit ee59ba8 ("UBI: Fix stale pointers in
ubi->lookuptbl") in v4.1-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f006f596fe851c3b6aae60b79f89f89f0e515d2f]
cip/4.4-st: [77cb3ce44816345303876ca6124b5b859ba81635]
mainline: [4d57a7333e26040f2b583983e1970d9d460e56b0]
stable/5.10: [8a18856e074479bd050b01e688c58defadce7ab0]
stable/5.15: [3afaaf6f5867dc4ad383808d4053f428ec7b867d]
stable/5.4: [b5be23f6ae610bdb262160a1f294afee6d0e6a69]
stable/6.1: [cc4bc532acda66189bddc03b3fe1ad689d9a48a2]

CVE-2023-53482: iommu: Fix error unwind in iommu_group_alloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53482

Introduced by commit bc7d12b ("iommu: Implement reserved_regions
iommu-group sysfs file") in v4.11-rc1.
Introduced by commit c52c72d ("iommu: Add sysfs attribyte for domain
type") in v4.19-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4daa861174d56023c2068ddb03de0752f07fa199]
stable/5.15: [f119ef452e2d82d912797273cb790a86f1125b3e]
stable/6.1: [4c23124b45ee0aa895ed8d5d08871ae6b15ee336]

CVE-2023-53483: ACPI: processor: Check for null return of
devm_kzalloc() in fch_misc_setup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53483

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected code was added by 7fdb98e ("ACPI: APD: Add a fmw property
clk-name") in 5.17-rc1.

Fixed status
mainline: [4dea41775d951ff1f7b472a346a8ca3ae7e74455]
stable/6.1: [79ca94bc3e8cc3befa883c7d30b30a27ef0ea386]

CVE-2023-53484: lib: cpu_rmap: Avoid use after free on rmap->obj array entries

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53484

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [d1308bd0b24cb1d78fa2747d5fa3e055cc628a48]
cip/4.4-st: [bc0e034c90d76f7d3cee0e5eecfffe85692d864b]
mainline: [4e0473f1060aa49621d40a113afde24818101d37]
stable/5.10: [f748e15253833b771acbede14ea98f50831ac289]
stable/5.15: [c6ed54dd90698dc0744d669524cc1c122ded8a16]
stable/5.4: [cc2d2b3dbfb0ba57bc027fb7e1121250c50e4000]
stable/6.1: [c9115f49cf260d24d8b5f2d9a4b63cb31a627bb4]

CVE-2023-53485: fs: jfs: Fix UBSAN: array-index-out-of-bounds in dbAllocDmapLev

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53485

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [53b0a362aca2583729e8ca2936ca657ff3247d88]
cip/4.4-st: [d480736c89f438c1723a9fb7f08355a686c5fbf7]
mainline: [4e302336d5ca1767a06beee7596a72d3bdc8d983]
stable/5.10: [911b48eec45152822bccf45cd3563b48256b1520]
stable/5.15: [39f6292d75959e8accac0b3e24090094ba0824e9]
stable/5.4: [6e7d9d76e5654bcdd3cdb7c9441a8113428ecebb]
stable/6.1: [bdf07ab1595b613b03f32dbb5cb379edfa1a7334]

CVE-2023-53486: fs/ntfs3: Enhance the attribute size check

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53486

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected file was added by 4342306 ("fs/ntfs3: Add file operations and
implementation") in 5.15-rc1. The ntfs3 support was added in 5.15-rc1.

Fixed status
mainline: [4f082a7531223a438c757bb20e304f4c941c67a8]
stable/5.15: [1fd5b80c9339503f3eaa4db3051b37ac506beeab]
stable/6.1: [277439e7cabd9d4c6334b39a4b99d49b4c97265b]

CVE-2023-53487: powerpc/rtas_flash: allow user copy to flash block cache objects

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53487

Introduced by commit 6d07d1c ("usercopy: Restrict non-usercopy caches
to size 0") in v4.16-rc1.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [8f09cc15dcd91d16562400c51d24c7be0d5796fa]
cip/4.4-st: [7d19037231af7e8a6b3257c87f480c37b8e48800]
mainline: [4f3175979e62de3b929bfa54a0db4b87d36257a7]
stable/5.10: [0ba7f969be599e21d4b1f1e947593de6515f4996]
stable/5.15: [8ef25fb13494e35c6dbe15445c7875fa92bc3e8b]
stable/5.4: [1d29e21ed09fa668416fa7721e08d451b9903485]
stable/6.1: [b8fee83aa4ed3846c7f50a0b364bc699f48d96e5]

CVE-2023-53488: IB/hfi1: Fix possible panic during hotplug remove

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53488

Introduced by commit 7724105 ("IB/hfi1: add driver files") in v4.3-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [bfd727ad8411995218f336ead9f2becfde7f3a89]
cip/4.4-st: [f5a9912046f1920cace295366a8d89a94e10cec7]
mainline: [4fdfaef71fced490835145631a795497646f4555]
stable/5.10: [33c677d1e087e437c7dcaad8d73402cf6add282e]
stable/5.15: [918c1e6843b7e81d0e5cf7994f41f28dc34c98b0]
stable/5.4: [c2145b18740c7e697748e4005ce93a5c683c86a8]
stable/6.1: [ac6640f4193d0f5b44269a7f08372909f9a18e5c]

CVE-2023-53489: tcp/udp: Fix memleaks of sk and zerocopy skbs with TX timestamp.

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53489

Introduced by commit f214f91 ("tcp: enable MSG_ZEROCOPY") in v4.14-rc1.
Introduced by commit b5947e5 ("udp: msg_zerocopy") in v5.0-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1f69c086b20e27763af28145981435423f088268]
mainline: [50749f2dd6854a41830996ad302aef2ffaf011d8]
stable/5.10: [230a5ed7d813fb516de81d23f09d7506753e41e9]
stable/5.15: [43e4197dd5f6b474a8b16f8b6a42cd45cf4f9d1a]
stable/5.4: [602fa8af44fd55a58f9e94eb673e8adad2c6cc46]
stable/6.1: [cb52e7f24c1d01a536a847dff0d1d95889cc3b5c]

CVE-2023-53490: mptcp: fix disconnect vs accept race

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53490

Introduced by commit 2a6a870 ("mptcp: stops worker on unaccepted
sockets at listener close") in v6.3.
Fixed in v6.5-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [511b90e39250135a7f900f1c3afbce25543018a2]
stable/6.1: [ded9f5551ce5cafa3c41c794428c27a0d0a00542]

CVE-2023-53491: start_kernel: Add __no_stack_protector function attribute

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53491

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
mainline: [514ca14ed5444b911de59ed3381dfd195d99fe4b]

CVE-2023-53492: netfilter: nf_tables: do not ignore genmask when
looking up chain by id

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53492

Introduced by commit 837830a ("netfilter: nf_tables: add
NFTA_RULE_CHAIN_ID attribute") in v5.9-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [515ad530795c118f012539ed76d02bacfd426d89]
stable/5.10: [4ae2e501331aaa506eaf760339bb2f43e5769395]
stable/5.15: [041e2ac88caef286b39064e83e825e3f53113d36]
stable/6.1: [fc95c8b02c6160936f1f3d8d9d7f4f66f3c84b49]

CVE-2023-53493: accel/qaic: tighten bounds checking in decode_message()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53493

Introduced by commit 129776a ("accel/qaic: Add control path") in v6.4-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51b56382ed2a2b03347372272362b3baa623ed1e]

CVE-2023-53494: crypto: xts - Handle EBUSY correctly

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53494

Introduced by commit 8083b1b ("crypto: xts - add support for
ciphertext stealing") in v5.4-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51c082514c2dedf2711c99d93c196cc4eedceb40]
stable/5.10: [92a07ba4f0af2cccdc2aa5ee32679c9c9714db90]
stable/5.15: [912eb10b65646ffd222256c78a1c566a3dac177d]
stable/6.1: [57c3e1d63b63dc0841d41df729297cd7c1c35808]

CVE-2023-53495: net: ethernet: mvpp2_main: fix possible OOB write in
mvpp2_ethtool_get_rxnfc()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53495

Introduced by commit 90b509b ("net: mvpp2: cls: Add Classification
offload support") in v5.2-rc1.
Fixed in v6.6-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51fe0a470543f345e3c62b6798929de3ddcedc1d]
stable/5.10: [61054a8ddb176b155a8f2bacdfefb3727187f5d9]
stable/5.15: [5bb09dddc724c5f7c4dc6dd3bfebd685eecd93e8]
stable/5.4: [ba6673824efa3dc198b04a54e69dce480066d7d9]
stable/6.1: [349638f7e5d3c7d328565587bb7b0454bbee02e2]

CVE-2023-53496: x86/platform/uv: Use alternate source for socket to node data

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53496

Introduced by commit 8a50c58 ("x86/platform/uv: UV support for
sub-NUMA clustering") in v6.5-rc1.
Fixed in v6.6-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5290e88ba2c742ca77c5f5b690e5af549cfd8591]

CVE-2023-53497: media: vsp1: Replace vb2_is_streaming() with
vb2_start_streaming_called()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53497

Introduced by commit a10b215 ("media: vb2: add (un)prepare_streaming
queue ops") in v6.2-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52d8caca3d533cc499f1255be25576ffd936ec95]

CVE-2023-53498: drm/amd/display: Fix potential null dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53498

Introduced by commit 9a71c7d ("drm/amd/display: Register DMUB service
with DC") in v5.6-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52f1783ff4146344342422c1cd94fcb4ce39b6fe]
stable/5.15: [4b1afffdd94093118b3cc235ef2b4d2520fb4950]
stable/6.1: [b75aaebac265e3f29863699d9a929fdfba13d0a4]

CVE-2023-53499: virtio_net: Fix error unwinding of XDP initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53499

Introduced by commit 754b8a2 ("virtio_net: setup xdp_rxq_info") in v4.16-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5306623a9826aa7d63b32c6a3803c798a765474d]
stable/5.15: [6a7690f2bd178eee80f33411ae32e543ae66379c]
stable/6.1: [73f53bc295727a3cdbd9d6bcdfaa239258970cf4]

CVE-2023-53500: xfrm: fix slab-use-after-free in decode_session6

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53500

Introduced by commit f855691 ("xfrm6: Fix the nexthdr offset in
_decode_session6.") in v3.19-rc7.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [da4cbaa75ed088b6d70db77b9103a27e2359e243]
mainline: [53223f2ed1ef5c90dad814daaaefea4e68a933c8]
stable/5.10: [bafa236380816b41b2c4c6970d9067fefa4a6c9e]
stable/5.15: [44b3d40967009304617a7a6486490c1d6c12f899]
stable/5.4: [db0e50741f0387f388e9ec824ea7ae8456554d5b]
stable/6.1: [0d27567fde5be5f0edc2db5c110142b7915b8fa8]

CVE-2023-53501: iommu/amd/iommu_v2: Fix pasid_state refcount dec hit 0
warning on pasid unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53501

Introduced by commit 8bc5482 ("iommu/amd: Convert from atomic_t to
refcount_t on pasid_state->count") in v5.15-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [534103bcd52ca9c1fecbc70e717b4a538dc4ded8]
stable/5.15: [a50d60b8f2aff46dd7c7edb4a5835cdc4d432c22]
stable/6.1: [13ed255248dfbbb7f23f9170c7a537fb9ca22c73]

CVE-2023-53503: ext4: allow ext4_get_group_info() to fail

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53503

Introduced commit is not determined.Fixed in v6.4-rc2.


Fixed status
mainline: [5354b2af34064a4579be8bc0e2f15a7b70f14b5f]
stable/5.10: [100c0ad6c04597fefeaaba2bb1827cc015d95067]
stable/5.15: [620a3c28221bb219b81bc0bffd065cc187494302]
stable/6.1: [b4319e457d6e3fb33e443efeaf4634fc36e8a9ed]

CVE-2023-53504: RDMA/bnxt_re: Properly order ib_device_unalloc() to avoid UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53504

Introduced by commit 6d75814 ("RDMA/bnxt_re: Use auxiliary driver
interface") in v6.3-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5363fc488da579923edf6a2fdca3d3b651dd800b]

CVE-2023-53505: clk: tegra: tegra124-emc: Fix potential memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53505

Introduced by commit 2db04f1 ("clk: tegra: Add EMC clock driver") in v4.2-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53a06e5924c0d43c11379a08c5a78529c3e61595]
stable/5.10: [404e9f741acfb188212f7142d91e247630dd77cc]
stable/5.15: [fd1c117bb5d7e033bf1aa25ac97ff421f81a1199]
stable/5.4: [801c8341f7aff07c494b53e627970b72635af5d3]
stable/6.1: [96bafece6ff380138896f009141fd7337070e680]

CVE-2023-53506: udf: Do not bother merging very long extents

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53506

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [5d029799d381a9ee06209a222cae75f04c5d5304]
cip/4.4-st: [6738e9a258a09f7ad994866a8bbf98d022379b9a]
mainline: [53cafe1d6d8ef9f93318e5bfccc0d24f27d41ced]
stable/5.10: [965982feb333aefa9256c0fe188b5f1b958aef63]
stable/5.15: [9a8d602f0723586e668bae7e65c832ceb9bcc8bc]
stable/5.4: [3d20e3b768aff32112bdce8d3219d923ae75f9f1]
stable/6.1: [adac9ac6d2e04ea0782b91a00ba10706002f3ec4]

CVE-2023-53507: net/mlx5: Unregister devlink params in case interface is down

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53507

Introduced by commit fe578cb ("net/mlx5: Move devlink registration
before mlx5_load") in v6.4-rc1.
Fixed in v6.5-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53d737dfd3d7b023fa9fa445ea3f3db0ac9da402]

CVE-2023-53508: ublk: fail to start device if queue setup is interrupted

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53508

Introduced by commit 71f28f3 ("ublk_drv: add io_uring based userspace
block driver") in v6.0-rc1.
Fixed in v6.5-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53e7d08f6d6e214c40db1f51291bb2975c789dc2]
stable/6.1: [0d5916c439574b18a0734872daa0022b3d6105ad]

CVE-2023-53509: qed: allow sleep in qed_mcp_trace_dump()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53509

Introduced by commit c965db4 ("qed: Add support for debug data
collection") in v4.9-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5401c3e0992860b11fb4b25796e4c4f1921740df]
stable/6.1: [50c81b35df01db12b348c5cbf4b1917dc9a7db54]

CVE-2023-53510: scsi: ufs: core: Fix handling of lrbp->cmd

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53510

Introduced by commit 5a0b0cb ("[SCSI] ufs: Add support for sending NOP
OUT UPIU") in v3.12-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [549e91a9bbaa0ee480f59357868421a61d369770]

CVE-2023-53511: io_uring: fix fget leak when fs don't support nowait
buffered read

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53511

Introduced by commit a196c78 ("io_uring: assign non-fixed early for
async work") in v5.18-rc6.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [54aa7f2330b82884f4a1afce0220add6e8312f8b]
stable/6.1: [75a499fc9d66a32271e2b3e4ca71156e8ad3b484]

CVE-2023-53512: scsi: mpt3sas: Fix a memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53512

Introduced by commit dbec4c9 ("scsi: mpt3sas: lockless command
submission") in v4.16-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [54dd96015e8d7a2a07359e2dfebf05b529d1780c]
stable/5.10: [30c7c72b6cf9d8c95f9b219c9d2e4e31b15bebe5]
stable/5.15: [378cc0eec4aa546ce1ae17515e2dfab719d4fb1e]
stable/6.1: [847cdbdcd5a24c1eec9595161a23b88fef91ff42]

CVE-2023-53513: nbd: fix incomplete validation of ioctl arg

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53513

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [55793ea54d77719a071b1ccc05a05056e3b5e009]
stable/5.15: [52851d0c3354b397c11d31dfeb8b2a2fc85a0002]
stable/6.1: [fab766c8a1aff715bce7075aab40e780266f8e1a]

CVE-2023-53514: gpu: host1x: Fix memory leak of device names

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53514

Introduced by commit 8aa5bcb ("gpu: host1x: Add context device
management code") in v6.0-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55879dad0f3ae8468444b42f785ad79eac05fe5b]
stable/6.1: [958c6cbc32996c375af42db96ceba021a1959899]

CVE-2023-53515: virtio-mmio: don't break lifecycle of vm_dev

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53515

Introduced by commit 7eb781b ("virtio_mmio: add cleanup for
virtio_mmio_probe") in v4.15-rc3.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [97a2d55ead76358245b446efd87818e919196d7a]
mainline: [55c91fedd03d7b9cf0c5199b2eb12b9b8e95281a]
stable/5.10: [3ff54d904fafabd0912796785e53cce4e69ca123]
stable/5.15: [5b7d5c2dd664eb8b9a06ecbc06e28d39359c422e]
stable/5.4: [b788ad3b2468512339c05f23692e36860264e674]
stable/6.1: [af5818c35173e096085c6ae2e3aac605d3d15e41]

CVE-2023-53516: macvlan: add forgotten nla_policy for IFLA_MACVLAN_BC_CUTOFF

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53516

Introduced by commit 954d1fa ("macvlan: Add netlink attribute for
broadcast cutoff") in v6.4-rc1.
Fixed in v6.5-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55cef78c244d0d076f5a75a35530ca63c92f4426]

CVE-2023-53517: tipc: do not update mtu if msg_max is too small in mtu
negotiation

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53517

Introduced by commit ed193ec ("tipc: simplify link mtu negotiation")
in v4.1-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56077b56cd3fb78e1c8619e29581ba25a5c55e86]
stable/5.10: [2bd4ff4ffb92113f8acd04dbaed83269172c24b4]
stable/5.15: [575e84d90a74c0b091b3417ba763ebb237aa0a8c]
stable/6.1: [259683001d7e879fea4b42084fb6560dd9408a7e]

CVE-2023-53518: PM / devfreq: Fix leak in devfreq_dev_release()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53518

Introduced by commit 0fe3a66 ("PM / devfreq: Add new
DEVFREQ_TRANSITION_NOTIFIER notifier") in v4.7-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [64e6e0dc2d578c0a9e31cb4edd719f0a3ed98f6d]
mainline: [5693d077595de721f9ddbf9d37f40e5409707dfe]
stable/5.10: [ab192e5e5d3b48415909a8408acfd007a607bcc0]
stable/5.15: [111bafa210ae546bee7644be730c42df9c35b66e]
stable/5.4: [29811f4b8255d4238cf326f3bb7129784766beab]
stable/6.1: [8918025feb2f5f7c73f2495c158f22997e25cb02]

CVE-2023-53519: media: v4l2-mem2mem: add lock to protect parameter num_rdy

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53519

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [7fc7f87725805197388ba749a1801df33000fa50]
cip/4.4-st: [dd04497396bf430da2213d954168250ef62a89bf]
mainline: [56b5c3e67b0f9af3f45cf393be048ee8d8a92694]
stable/5.10: [e52de26cb37459b16213438a2c82feb155dd3bbd]
stable/5.15: [1676748aa29099fc0abd71e0fb092e76e835f25c]
stable/5.4: [ef009fe2010ea2a3a7045ecb72729cf366e0967b]
stable/6.1: [c71aa5f1cf961264690f2560503ea396b6e3c680]

CVE-2023-53520: Bluetooth: Fix hci_suspend_sync crash

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53520

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
mainline: [573ebae162111063eedc6c838a659ba628f66a0f]
stable/6.1: [06e2b5ad72b60f90bfe565c201346532e271f484]

CVE-2023-53521: scsi: ses: Fix slab-out-of-bounds in ses_intf_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53521

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [87e47be38d205df338c52ead43f23b2864567423]
cip/4.4-st: [565ea88addabf3e25a01ec14da15e32312771afb]
mainline: [578797f0c8cbc2e3ec5fc0dab87087b4c7073686]
stable/5.10: [8f9542cad6c27297c8391de3a659f0b7948495d0]
stable/5.15: [0595cdb587726b4f0fa780eb7462e3679d141e82]
stable/5.4: [40af9a6deed723485e05b7d3255a28750692e8db]
stable/6.1: [82143faf01dda831b89eccef60c39ef8575ab08a]

CVE-2023-53522: cgroup,freezer: hold cpu_hotplug_lock before freezer_mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53522

Introduced by commit f5d39b0 ("freezer,sched: Rewrite core freezer
logic") in v6.1-rc1.
Fixed in v6.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57dcd64c7e036299ef526b400a8d12b8a2352f26]
stable/6.1: [3756171b97c307d9df8b8ded1d883eec30172085]

CVE-2023-53523: can: gs_usb: fix time stamp counter initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53523

Introduced by commit 45dfa45 ("can: gs_usb: add RX and TX hardware
timestamp support") in v6.1-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5886e4d5ecec3e22844efed90b2dd383ef804b3a]

CVE-2023-53524: wifi: iwlwifi: pcie: Fix integer overflow in
iwl_write_to_user_buf

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53524

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected function was added by f7805b3 ("iwlwifi: add debugfs file to
read fw debug data recording") in 5.0-rc1.

Fixed status
mainline: [58d1b717879bfeabe09b35e41ad667c79933eb2e]
stable/5.10: [059e426d666a41e26b184c177c1ca3ee2d6fa1b6]
stable/5.15: [82f877ec9b041edc4c7c509c605cc3393d837bf0]
stable/5.4: [0ad8dd870aa187d0c21d032bb2c6433559075eec]
stable/6.1: [eb1ef44efac797b384d361a76e33f77027c29a14]

CVE-2023-53525: RDMA/cma: Allow UD qp_type to join multicast only

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53525

Introduced by commit b5de0c6 ("RDMA/cma: Fix use after free race in
roce multicast join") in v5.10-rc1.
Fixed in v6.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58e84f6b3e84e46524b7e5a916b53c1ad798bc8f]
stable/5.10: [ae11498851423d6de27aebfe12a5ee85060ab1d5]
stable/5.15: [48e8e7851dc0b1584d83817a78fc7108c8904b54]
stable/6.1: [02eabb635bc64bd1e3a7cf887d6d182bffb64b99]

CVE-2023-53526: jbd2: check 'jh->b_transaction' before removing it
from checkpoint

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53526

Introduced by commit 46f881b ("jbd2: fix a race when checking
checkpoint buffer busy") in v6.5-rc3.
Fixed in v6.6-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [590a809ff743e7bd890ba5fb36bc38e20a36de53]
stable/5.15: [ef5fea70e5915afd64182d155e72bfb4f275e1fc]
stable/6.1: [dbafe636db415299e54d9dfefc1003bda9e71c9d]

CVE-2023-53527: thunderbolt: Fix memory leak in tb_handle_dp_bandwidth_request()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53527

Introduced by commit 6ce3563 ("thunderbolt: Add support for
DisplayPort bandwidth allocation mode") in v6.3-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [596a5123cc782d458b057eb3837e66535cd0befa]

CVE-2023-53528: RDMA/rxe: Fix unsafe drain work queue code

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53528

Introduced by commit 49dc9c1 ("RDMA/rxe: Cleanup reset state handling
in rxe_resp.c") in v6.4-rc1.
Introduced by commit fbdeb82 ("RDMA/rxe: Cleanup error state handling
in rxe_comp.c") in v6.4-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5993b75d0bc71cd2b441d174b028fc36180f032c]

CVE-2023-53529: wifi: rtw88: Fix memory leak in rtw88_usb

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53529

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected file was added by a82dfd3 ("wifi: rtw88: Add common USB chip
support") in 6.2-rc1.

Fixed status
mainline: [59a3a312009723e3e5082899655fdcc420e2b47a]

CVE-2023-53530: scsi: qla2xxx: Use raw_smp_processor_id() instead of
smp_processor_id()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53530

Introduced commit is not determined.Fixed in v6.6-rc2.


Fixed status
mainline: [59f10a05b5c7b675256a66e3161741239889ff80]
stable/5.15: [1a541999f31fcb10ea50eba2a563e6c451fd5c7d]
stable/6.1: [52c7b41ad6ee53222f4ee2f0c099a6ed8291a168]

CVE-2023-53531: null_blk: fix poll request timeout handling

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53531

Introduced by commit 0a593fb ("null_blk: poll queue support") in v5.16-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a26e45edb4690d58406178b5a9ea4c6dcf2c105]
stable/6.1: [a0b4a0666beacfe8add9c71d8922475541dbae73]

CVE-2023-53532: wifi: ath11k: fix deinitialization of firmware resources

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53532

Introduced by commit f9eec49 ("ath11k: Add support for targets without
trustzone") in v5.19-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a78ac33e3cb8822da64dd1af196e83664b332b0]
stable/6.1: [0324300dce3412d4737b4ec5898d0188495a7caa]

CVE-2025-39891: wifi: mwifiex: Initialize the chan_stats array to zero

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39891

Introduced by commit bf35443 ("mwifiex: channel statistics support for
mwifiex") in v3.19-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e20450829ca3c1dbc2db536391537c57a40fe0b]
stable/5.10: [05daef0442d28350a1a0d6d0e2cab4a7a91df475]
stable/5.15: [acdf26a912190fc6746e2a890d7d0338190527b4]
stable/5.4: [9eb0118b3470b4d2e4e3bbb1fc088b30c0285d65]
stable/6.1: [32c124c9c03aa755cbaf60ef7f76afd918d47659]
stable/6.12: [06616410a3e5e6cd1de5b7cbc668f1a7edeedad9]
stable/6.6: [9df29aa5637d94d24f7c5f054ef4feaa7b766111]

CVE-2025-39892: ASoC: soc-core: care NULL dirver name on
snd_soc_lookup_component_nolocked()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39892

Introduced by commit 144d6df ("ASoC: soc-core: merge
snd_soc_unregister_component() and
snd_soc_unregister_component_by_driver()") in v6.16-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [168873ca1799d3f23442b9e79eae55f907b9b126]

CVE-2025-39893: spi: spi-qpic-snand: unregister ECC engine on probe
error and device remove

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39893

Introduced by commit 7304d19 ("spi: spi-qpic: add driver for QCOM SPI
NAND flash Interface") in v6.15-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1991a458528588ff34e98b6365362560d208710f]

CVE-2025-39894: netfilter: br_netfilter: do not check confirmed bit in
br_nf_local_in() after confirm

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39894

Introduced by commit 62e7151 ("netfilter: bridge: confirm multicast
packets before passing them up the stack") in v6.8-rc7.
Fixed in v6.17-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [479a54ab92087318514c82428a87af2d7af1a576]
stable/5.15: [d00c8b0daf56012f69075e3377da67878c775e4c]
stable/6.1: [ccbad4803225eafe0175d3cb19f0d8d73b504a94]
stable/6.12: [c47ca77fee9071aa543bae592dd2a384f895c8b6]
stable/6.6: [50db11e2bbb635e38e3dd096215580d6adb41fb0]

CVE-2025-39895: sched: Fix sched_numa_find_nth_cpu() if mask offline

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39895

Introduced by commit cd7f553 ("sched: add sched_numa_find_nth_cpu()")
in v6.3-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ebf512f335053a42482ebff91e46c6dc156bf8c]
stable/6.12: [b3ec50cc5eb5ca84256ca701d28b137a6036c412]
stable/6.6: [f9b8d4dba8e78c1887fecd81ba0d8204d6ff05fc]

CVE-2025-39896: accel/ivpu: Prevent recovery work from being queued
during device removal

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39896

Introduced by commit 58cde80 ("accel/ivpu: Use dedicated work for job
timeout detection") in v6.8-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69a79ada8eb034ce016b5b78fb7d08d8687223de]
stable/6.12: [54c49eca38dbd06913a696f6d7610937dcfad226]

CVE-2025-39897: net: xilinx: axienet: Add error handling for RX
metadata pointer retrieval

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39897

Introduced by commit 6a91b84 ("net: axienet: Introduce dmaengine
support") in v6.8-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bbceba7dc5090c00105e006ce28d1292cfda8dd]
stable/6.12: [d0ecda6fdd840b406df6617b003b036f65dd8926]

CVE-2025-39898: e1000e: fix heap overflow in e1000_set_eeprom

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39898

Introduced by commit bc7f75f ("[E1000E]: New pci-express e1000 driver
(currently for ICH9 devices only)") in v2.6.24-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90fb7db49c6dbac961c6b8ebfd741141ffbc8545]
stable/5.10: [ce8829d3d44b8622741bccca9f4408bc3da30b2b]
stable/5.15: [99a8772611e2d7ec318be7f0f072037914a1f509]
stable/5.4: [ea832ec0583e2398ea0c5ed8d902c923e16f53c4]
stable/6.1: [b48adcacc34fbbc49046a7ee8a97839bef369c85]
stable/6.12: [b370f7b1f470a8d5485cc1e40e8ff663bb55d712]
stable/6.6: [50a84d5c814039ad2abe2748aec3e89324a548a7]

CVE-2025-39899: mm/userfaultfd: fix kmap_local LIFO ordering for CONFIG_HIGHPTE

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39899

Introduced by commit adef440 ("userfaultfd: UFFDIO_MOVE uABI") in v6.8-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9614d8bee66387501f48718fa306e17f2aa3f2f3]
stable/6.12: [b051f707018967ea8f697d790a1ed8c443f63812]

CVE-2025-39900: net_sched: gen_estimator: fix est_timer() vs CONFIG_PREEMPT_RT=y

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39900

Introduced by commit d2d6422 ("x86: Allow to enable PREEMPT_RT.") in v6.12-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f74c0ea9b26d1505d55b61e36b1623dd347e1d1]
stable/6.12: [a22ec2ee824be30803068a52f78f7ffe3bc879fb]

CVE-2025-39901: i40e: remove read access to debugfs files

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39901

Introduced by commit 02e9c29 ("i40e: debugfs interface") in v3.12-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9fcdb1c3c4ba134434694c001dbff343f1ffa319]
stable/6.12: [70d3dad7d5ad077965d7a63eed1942b7ba49bfb4]

CVE-2025-39902: mm/slub: avoid accessing metadata when pointer is
invalid in object_err()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39902

Introduced by commit 81819f0 ("SLUB core") in v2.6.22-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4efccec8d06ceb10a7d34d7b1c449c569d53770]
stable/5.10: [f66012909e7bf383fcdc5850709ed5716073fdc4]
stable/5.15: [7e287256904ee796c9477e3ec92b07f236481ef3]
stable/5.4: [872f2c34ff232af1e65ad2df86d61163c8ffad42]
stable/6.1: [1f0797f17927b5cad0fb7eced422f9a7c30a3191]
stable/6.12: [dda6ec365ab04067adae40ef17015db447e90736]
stable/6.6: [0ef7058b4dc6fcef622ac23b45225db57f17b83f]

CVE-2025-39903: of_numa: fix uninitialized memory nodes causing kernel panic

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39903

Introduced by commit 7675076 ("arch_numa: switch over to
numa_memblks") in v6.12-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee4d098cbc9160f573b5c1b5a51d6158efdb2896]
stable/6.12: [c2daa6eb4740720b5bd0e06267d7c93a3eed844e]

CVE-2025-39904: arm64: kexec: initialize kexec_buf struct in
load_other_segments()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39904

Introduced by commit bf454ec ("kexec_file: allow to place kexec_buf
randomly") in v6.16-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04d3cd43700a2d0fe4bfb1012a8ec7f2e34a3507]

CVE-2025-39905: net: phylink: add lock for serializing concurrent
pl->phydev writes with resolver

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39905

Introduced commit is not determined.Fixed in v6.17-rc6.
Affecte file was added by 9525ae8 ("phylink: add phylink
infrastructure") in 4.14-rc1.

Fixed status
mainline: [0ba5b2f2c381dbec9ed9e4ab3ae5d3e667de0dc3]

CVE-2025-39906: drm/amd/display: remove oem i2c adapter on finish

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39906

Introduced by commit 3d5470c ("drm/amd/display/dm: add support for OEM
i2c bus") in v6.15-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1dfd2864a1c4909147663e5a27c055f50f7c2796]

CVE-2025-39907: mtd: rawnand: stm32_fmc2: avoid overlapping mappings
on ECC buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39907

Introduced by commit 2cd457f ("mtd: rawnand: stm32_fmc2: add STM32
FMC2 NAND flash controller driver") in v5.1-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [513c40e59d5a414ab763a9c84797534b5e8c208d]
stable/6.1: [75686c49574dd5f171ca682c18717787f1d8d55e]
stable/6.12: [26adba1e7d7924174e15a3ba4b1132990786300b]
stable/6.6: [06d8ef8f853752fea88c8d5bb093a40e71b330cf]

CVE-2025-39908: net: dev_ioctl: take ops lock in hwtstamp lower paths

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39908

Introduced by commit ffb7ed1 ("net: hold netdev instance lock during
ioctl operations") in v6.15-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [686cab5a18e443e1d5f2abb17bed45837836425f]

CVE-2025-39909: mm/damon/lru_sort: avoid divide-by-zero in
damon_lru_sort_apply_parameters()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39909

Introduced by commit 40e983c ("mm/damon: introduce DAMON-based
LRU-lists Sorting") in v6.0-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [711f19dfd783ffb37ca4324388b9c4cb87e71363]
stable/6.1: [74e391f7da7d9d5235a3cca88ee9fc18f720c75b]
stable/6.12: [af0ae62b935317bed1a1361c8c9579db9d300e70]
stable/6.6: [7bb675c9f0257840d33e5d1337d7e3afdd74a6bf]

CVE-2025-39910: mm/vmalloc, mm/kasan: respect gfp mask in
kasan_populate_vmalloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39910

Introduced by commit 451769e ("mm/vmalloc: alloc GFP_NO{FS,IO} for
vmalloc") in v5.17-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79357cd06d41d0f5a11b17d7c86176e395d10ef2]

CVE-2025-39911: i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39911

Introduced by commit 493fb30 ("i40e: Move q_vectors from pointer to
array to array of pointers") in v3.13-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [915470e1b44e71d1dd07ee067276f003c3521ee3]
stable/6.1: [b905b2acb3a0bbb08ad9be9984d8cdabdf827315]
stable/6.12: [a30afd6617c30aaa338d1dbcb1e34e7a1890085c]
stable/6.6: [23431998a37764c464737b855c71a81d50992e98]

CVE-2025-39912: nfs/localio: restore creds before releasing pageio data

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39912

Introduced by commit b9f5dd5 ("nfs/localio: use dedicated workqueues
for filesystem read and write") in v6.12-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [992203a1fba51b025c60ec0c8b0d9223343dea95]
stable/6.12: [57c1bb02b4fc8eec6eb01736e7fad26dffacf18c]

CVE-2025-39913: tcp_bpf: Call sk_msg_free() when
tcp_bpf_send_verdict() fails to allocate psock->cork.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39913

Introduced by commit 4f738ad ("bpf: create tcp_bpf_ulp allowing BPF to
monitor socket TX/RX data") in v4.17-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3967baad4d533dc254c31e0d221e51c8d223d58]
stable/6.1: [9c2a6456bdf9794474460d885c359b6c4522d6e3]
stable/6.12: [539920180c55f5e13a2488a2339f94e6b8cb69e0]
stable/6.6: [66bcb04a441fbf15d66834b7e3eefb313dd750c8]

CVE-2025-39914: tracing: Silence warning when chunk allocation fails
in trace_pid_write

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39914

Introduced by commit 8d6e909 ("tracing: Create a sparse bitmask for
pid filtering") in v5.16-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd4453c5e983cf1fd5757e9acb915adb1e4602b6]
stable/6.1: [7583a73c53f1d1ae7a39b130eb7190a11f0a902f]
stable/6.12: [88525accf16947ab459f8e91c27c8c53e1d612d7]
stable/6.6: [1262bda871dace8c6efae25f3b6a2d34f6f06d54]

CVE-2025-39915: net: phy: transfer phy_config_inband() locking
responsibility to phylink

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39915

Introduced by commit 5fd0f1a ("net: phylink: add negotiation of
in-band capabilities") in v6.14-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2a10daba84968f6b5777d150985fd7d6abc9c84]

CVE-2025-39916: mm/damon/reclaim: avoid divide-by-zero in
damon_reclaim_apply_parameters()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39916

Introduced by commit f5a79d7 ("mm/damon: introduce struct
damos_access_pattern") in v6.1-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6b543ca9806d7bced863f43020e016ee996c057]
stable/6.1: [64dc351e58271c1e9005e42f5216b4f3d7a39b66]
stable/6.12: [5d6eeb3c683c777ed4538eb3a650bb7da17a7cff]
stable/6.6: [9fe0415156fbde773b31f920201cb70b1f0e40fe]

CVE-2025-39917: bpf: Fix out-of-bounds dynptr write in bpf_crypto_crypt

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39917

Introduced by commit 3e1c6f3 ("bpf: make common crypto API for TC/XDP
programs") in v6.10-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9bb6ffa7f5ad0f8ee0f53fc4a10655872ee4a14]
stable/6.12: [0126358df12d6f476f79251d9c398ac5c1b3062d]

CVE-2025-39918: wifi: mt76: fix linked list corruption

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39918

Introduced by commit 0b3be9d ("wifi: mt76: add separate tx scheduling
queue for off-channel tx") in v6.12-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49fba87205bec14a0f6bd997635bf3968408161e]
stable/6.12: [e4d5a5fc61fdc65220a1ce078d24c1d20bbb0835]

CVE-2025-39919: wifi: mt76: mt7996: add missing check for rx wcid entries

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39919

Introduced by commit 7464b12 ("wifi: mt76: mt7996: rework
mt7996_rx_get_wcid to support MLO") in v6.15-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a522b01e368eec58d182ecc47d24f49a39e440d]

CVE-2025-39920: pcmcia: Add error handling for add_interval() in
do_validate_mem()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39920

Introduced by commit 7b4884c ("pcmcia: validate late-added resources")
in v2.6.34-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a81f78caa53e0633cf311ca1526377d9bff7479]
stable/5.10: [ae184024ef31423e5beb44cf4f52999bbcf2fe5b]
stable/5.15: [85be7ef8c8e792a414940a38d94565dd48d2f236]
stable/5.4: [5b60ed401b47897352c520bc724c85aa908dedcc]
stable/6.1: [06b26e3099207c94b3d1be8565aedc6edc4f0a60]
stable/6.12: [289b58f8ff3198d091074a751d6b8f6827726f3e]
stable/6.6: [8699358b6ac99b8ccc97ed9e6e3669ef8958ef7b]

CVE-2025-39921: spi: microchip-core-qspi: stop checking viability of
op->max_freq in supports_op callback

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39921

Introduced by commit 1352964 ("spi: microchip-core-qspi: Support per
spi-mem operation frequency switches") in v6.14-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [89e7353f522f5cf70cb48c01ce2dcdcb275b8022]

CVE-2025-39922: ixgbe: fix incorrect map used in eee linkmode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39922

Introduced by commit 9356b6d ("net: ethernet: ixgbe: Convert EEE to
use linkmodes") in v6.9-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7e5c3e3bfa9dc8af75ff6d8633ad7070e1985e4]
stable/6.12: [682105ab63826fb7ca7c112b42b478d156fbb19f]

CVE-2025-39923: dmaengine: qcom: bam_dma: Fix DT error handling for
num-channels/ees

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39923

Introduced by commit 48d163b ("dmaengine: qcom: bam_dma: get
num-channels and num-ees from dt") in v4.17-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5068b5254812433e841a40886e695633148d362d]
stable/6.1: [555bd16351a35c79efb029a196975a5a27f7fbc4]
stable/6.12: [1fc14731f0be4885e60702b9596d14d9a79cf053]
stable/6.6: [ebf6c7c908e5999531c3517289598f187776124f]

CVE-2025-39924: erofs: fix invalid algorithm for encoded extents

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39924

Introduced by commit 1d191b4 ("erofs: implement encoded extent
metadata") in v6.15-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [131897c65e2b86cf14bec7379f44aa8fbb407526]

CVE-2025-39925: can: j1939: implement NETDEV_UNREGISTER notification handler

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39925

Introduced by commit 9d71dd0 ("can: add support of SAE J1939
protocol") in v5.4-rc1.
Introduced by commit 25fe97c ("can: j1939: move j1939_priv_put() into
sk_destruct callback") in v5.4-rc8.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7fcbe5b2c6a4b5407bf2241fdb71e0a390f6ab9a]

CVE-2025-39926: genetlink: fix genl_bind() invoking bind() after -EPERM

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39926

Introduced by commit 3de21a8 ("genetlink: Add per family bind/unbind
callbacks") in v6.9-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1dbfb0363224f6da56f6655d596dc5097308d6f5]
stable/6.12: [98c9d884047a3051c203708914a874dece3cbe54]

CVE-2025-39927: ceph: fix race condition validating r_parent before
applying state

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39927

Introduced commit is not determined.Fixed in v6.17-rc6.


Fixed status
mainline: [15f519e9f883b316d86e2bb6b767a023aafd9d83]
stable/6.12: [db378e6f83ec705c6091c65d482d555edc2b0a72]

CVE-2025-39928: i2c: rtl9300: ensure data length is within supported range

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39928

Introduced by commit c366be7 ("i2c: Add driver for the RTL9300 I2C
controller") in v6.13-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06418cb5a1a542a003fdb4ad8e76ea542d57cfba]

* Updated CVEs

CVE-2025-22106: vmxnet3: unregister xdp rxq info in the reset path

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [23da4e0bb2a38966d29db0ff90a8fe68fdfa1744]
stable/6.6: [a6157484bee3385a425d288a69e1eaf03232f5fc]

CVE-2025-38322: perf/x86/intel: Fix crash in icl_update_topdown_event()

stable/6.12 was fixed.

Fixed status
stable/6.12: [e97c45c770f5e56c784a46c2a96ab968d26b97d9]

CVE-2025-39816: io_uring/kbuf: always use READ_ONCE() to read ring
provided buffer lengths

stable/6.12 was fixed.

Fixed status
stable/6.12: [695673eb5711ee5eb1769481cf1503714716a7d1]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

