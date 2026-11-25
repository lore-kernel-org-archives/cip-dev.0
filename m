Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2913.1795645354640666617
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2026 14:22:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20260707.gappssmtp.com header.s=20260707 header.b=o7aehVaT;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.42, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67db763cec7so6593365d50.1
        for <cip-dev@lists.cip-project.org>; Wed, 25 Nov 2026 14:22:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795645354; cv=none;
        d=google.com; s=arc-20260327;
        b=FRL8JvHOt4VsJzN9py6qBdbkcfx3dZPc1jdxJIe4ET+pvbY2hbUwHlr1FdzUdkQ7Xx
         OE7WPJX3o9hOmT5Su+J05OwpqGHWOnDCfVJvpQazBkMKoHnEja8mdp2ag9UM+8JgAjK5
         WgUKXCTBm913BovOcdpUKzdMZhoPNuc7m08rWUBmKRsOlGsJluULkysgcX31fGU9hElF
         ot9qOH9RKPyUK8laCQj1p7SSAsYzgX9EDHEtaOTWK+DQv4Lx4gLq9PDyKxWGFlBRF+Gq
         7snSxxTI10bIj5E43tr0pRXmHdW9KgnGCQdUj3PNRhaqdJmjFYV22BOVcXiV8vMm3Bcs
         SFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WzjFIyWjzoiOJIKU29rBAsbt+IMWAzvV39z8loBKTuE=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=NYTEedvngTw/xcafsc1XrfNqYfNqXnY6bkuaDtCTi55L0Ogbva1ywLynfX/hz5NWGu
         cyMcop3Y/KVKVd6Fj4qXGWTilv+NwaEqcFZFTYmajl3aiT+d2bYfngsjIBrDL2UQg/K2
         aMeOlzfUnojqHf72+rR8j2pFzLQzDa8Ld3E/msW98BV/pwrOQtBZrCAdP+UIeLEoBkKf
         WpnVcCVrD0GOlEWB0vSHO4Lc4WqB9U/H/wqidO3p0NaBfkuUVopmrs94AUdGYG+USqYr
         mCw2JUiNbeeRdYMc43QxwQ/zOsTezGWD38oLsABuTeP8qcEG8lzGzBQoxIEIDgE0+WZ+
         5VFg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20260707.gappssmtp.com; s=20260707; t=1795645354; x=1796250154; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WzjFIyWjzoiOJIKU29rBAsbt+IMWAzvV39z8loBKTuE=;
        b=o7aehVaTSOUSz+WFVrbtXd/HS62AM0ZowzJGdRWLkvkwbYczdpyJGxlcSjUCRCKlfU
         plDgbRkp+vc9Op37jQa6AUcsUkRMWbgVAdWPHAO81mmpqZDjD0SEzVxl6wvlGVRtLKkZ
         X1sDtmEicZBCeHz7wT6VvrCh/9avf6/Wl0BPHUmz+jc8w4jfo7oG8QigInZQJyqWUYUH
         VunbQq4E/mNxjHIjD9WFUs8r+OyTCjIV/q4Vmk12AZy2umy2R64BnEI8M6+UMp2IZ+2L
         81HbeiKNQkY4rDDSF+6pICFaCjwBO1iEAA1Pe7L6qpeP8ekjaQBnXiA8UhGNaH9PMOgv
         T6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645354; x=1796250154;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WzjFIyWjzoiOJIKU29rBAsbt+IMWAzvV39z8loBKTuE=;
        b=E6FjWamspv02sV2FqvOBAeKsVqh+UrQwOHY2rfRgMes4ccF9WaI6xQSK3taMUbVbUm
         vSjAAjwKlqbsggLcCQ2r9r5u0MBAye6ZV+j+BUpZ1pwNP2gt00oRrk2lLtfG3wywv2sx
         IlIY6lY7i3zAVjTuw9icC+cAsKaOkPO7kTWnbGarC8aQOldKuiYyguIpYi18Ql7ghuEh
         ouEJzThzgh6FVW236EQTh1jmguqsCRqp7ShQ/YeSR77YL8nU3zzCdWODhRvxnhKSFFuW
         1UGnyfBvGTuYhBzbkG9XPCP+XNuAC9jZ2JvNWv6W/06GkMZtq6fhpZSdrsWdNjVSBklX
         8igQ==
X-Gm-Message-State: APuU4Z/UDfog9Qczn9mPrpAnmO/sA4w6Hb+XJ2owf7iQbMRPcZ2sWRlZ
	1dFXVG10X+jkw+tcBiCVbHKqwNp7OuUJvviEQKHG2Wyw2kk3sHo0zUay9/3QeU7xUNCgrifXDCI
	s5NpaDBfW+m1M5RV2BKjLvHuNCpanddy4zQtaijrAUGacSEAFsUiLSjyUtg==
X-Gm-Gg: AZFdTZc4L+Jh93s+uNIZ2rnCpPKY4ucVNRuYNI0pxRCdlRfDaKOzGUpL9deYTTgfxga
	MVLB2R9E+EA9ZXNjn1AJzvpbbiYNYKSpWSLWCXfNZIY62oFJw22quqSckRElXVkBbqXQY2fdASz
	FMH9Y/edhshAUVE7f5fXy5STljrEdH4jiRzJVMa6St06fXKWUQs1ahPwj3WY/j6NP/+r/LEk6HZ
	+P7Cuo3V3rrQgciNFm/Pq3XtB5U8O0VtvD+SVq3V0NY9HXAir0khi81wFWgHD0lcO4SOXMArPKC
	R6h1oq1xdK9/0A0TdvUwBiFgfOHRpsfdC6hxKTdombSWXM97GF3H5fSzrfu60rnZnfLWstYAi6x
	ADGk0lhAKx/uKX3atom5cOp8jZ8uPBmDVVbkdFjgT+5GwmBRga29VHcTj/eeld2mWBr1ioY/vpb
	qd1+TZ6XFufNKvuTMIw4IOM861oYm2xtA=
X-Received: by 2002:a05:690e:47c7:20b0:679:ad63:6752 with SMTP id
 956f58d0204a3-67df4485df0mr5070062d50.88.1795645348516; Wed, 25 Nov 2026
 14:22:28 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 26 Nov 2026 07:21:50 +0900
X-Gm-Features: Aa3M54rN_hAV-r2jJx_siWsqznuE2HAThh5C57EJvmuNLCMyZnkyR4I7WiqCv24
Message-ID: <CAODzB9ohPAa_daWUUxBJm9y8jLR8vhYUbfsqMNat7kpmno5V6Q@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 25 Nov 2026 22:22:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25075

Hi!

It's this week's CVE report.

This week reported 492 new CVEs and 169 updated CVEs.

* New CVEs
CVE-2026-99320: ipv6: raw: fix use-after-free in rawv6_send_hdrinc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99320

Introduced by commit 4c1feac ("net: vrf: Flip IPv6 output path from
FIB lookup hook to out hook") in v4.9-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66dfb2cacda7faae614d688943d85e75abf7f586]
stable/5.10: [cf0ac98b750292a2389cd21af7cf0e89c712ee09]
stable/5.15: [a31dee121f5ba1c3f521f7a929e0ad4a0d9a431d]
stable/6.1: [f38df644608ffd1253074f6d55103c1d8b2a197c]
stable/6.12: [afb69c90cf62b630bf74c82d7bcfca840db8b076]
stable/6.18: [3fda55b34d8f1621676f1238728c16033dff1148]
stable/6.6: [6cf361f77b4b329ad009daa63397a32bab95b1d0]
stable/7.3: [18772182967f9a0160dc7ada43311eab87c3d9ec]

CVE-2026-99321: rust_binder: wake epoll on self-work queued to poll thread

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99321

Introduced by commit dbb17c9 ("rust_binder: move (e)poll wait queue to
Process") in v7.3-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [985955d8e6b2b15cfd65b7ac6893e3a5a90c5870]
stable/7.3: [efb488fd08fd9993d5bad6b6e2848d12a16e1a3a]

CVE-2026-99322: ksmbd: rebind completed CREATE replays without
draining the old channel

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99322

Introduced by commit bb8bf7e ("ksmbd: add SMB3 request replay
support") in v7.3-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [864bbcd5dc5e70d639a3011eae81a872b69ff402]
stable/7.3: [7b54fe3db87bc3dee16c66b400206978e515a705]

CVE-2026-99323: ksmbd: fix invalid pointer dereference when
get_inode_acl() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99323

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19d180c7baab7126af5848ed87d5f7b5add0cef2]
stable/5.15: [a3a284d36c0b5f1b5e203f21a446be308cedea08]
stable/6.1: [1281624452531a5051f0015ef3e8457a8e090b2c]
stable/6.12: [5a04348b4492fe993ed709e601f01877e5dab220]
stable/6.18: [4a7f332fd43eee2541197d6e1e297b9ef2e1b07f]
stable/6.6: [4c2ed8a2d49719cf849e03b6f4b0ccad0bd9cc90]
stable/7.3: [44950fdcc645041912fecc257c01a1f253abf05e]

CVE-2026-99324: ksmbd: fix out-of-bounds read when padding the final
compound response

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99324

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [714f27729121d59f103ca4dad7b0c2d1c125cd71]
stable/5.15: [002e425ef1ff1f6135e08ac866ee807e1f59c7d1]
stable/6.1: [b663b29e3eb76f4c0923d1408be4c8e33fb54c6c]
stable/6.12: [f4d6f211be04c9b018ce4cfb9793ea1f48c150c3]
stable/6.18: [3092d8a596efaeccdebe0804bf263e5e6eef39d7]
stable/6.6: [79b12c8b00410ca268ef0c9be65df526fcf567f1]
stable/7.3: [52bda0cf91b62bf679d67d6a3adc20b0be8ff4f7]

CVE-2026-99325: HID: hid-lenovo-go-s: Add suspend function and gate
access under bool.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99325

Introduced by commit a23f349 ("HID: hid-lenovo-go-s: Add Lenovo Legion
Go S Series HID Driver") in v7.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e69b64d3d75eb10177f75d3d4947e032cb46eeb9]
stable/7.3: [cd4a95557f3c156bf06bb2e2b5667d59343ebdb2]

CVE-2026-99326: HID: hid-lenovo-go-s: Prevent deadlock if device
removed during setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99326

Introduced by commit a23f349 ("HID: hid-lenovo-go-s: Add Lenovo Legion
Go S Series HID Driver") in v7.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ef3036c68979194fdee77a3a825fb94ef307a54]
stable/7.3: [df2b31428cb2e6c8f8fec8225b42e5e8d85bf7ee]

CVE-2026-99327: HID: roccat: kovaplus: reject short button reports

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99327

Introduced by commit 0e70f97 ("HID: roccat: Add support for Kova[+]
mouse") in v2.6.39-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e95917a606f486e46f5136fc1b72190742a091d6]
stable/5.10: [7ada4098ada50d58a8dada93a2987cfd48d3d972]
stable/5.15: [c0224e0fa6d9c9bc4a14b3a93cbde584fecd067a]
stable/6.1: [474a61daf1d40d8a2d16b47880a8f621fff2b318]
stable/6.12: [ee3166e260e4217b9b332d38eb3c75bd72d1bc63]
stable/6.18: [196fff636bf4fd8ca7dcdeb46b17c275d9064766]
stable/6.6: [9cc3c6e5939404872c1e950828803e34e7e1a1e1]
stable/7.3: [1b19a4415e9baac8f5fad0577756621d5bb14487]

CVE-2026-99328: HID: picoLCD: check for fb_deferred_io_init() error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99328

Introduced by commit 56c134f ("fbdev: Track deferred-I/O pages in
pageref struct") in v5.19-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [feade898fc958ff355101adf12d5632272e64220]
stable/5.15: [a4d7231da151ec42e10510a7e7ecf60a64175929]
stable/6.1: [be019e20f8bb0afa6ffb87494527c25b59108c17]
stable/6.12: [28be73031ae5397a0592fa6308051f743fb428f7]
stable/6.18: [14acfdfca5151537b623243a6c0e66a2e6fca7de]
stable/6.6: [79914eb199e0dff8218b5e3ebb3cad91f20f052e]
stable/7.3: [ebe54f9e793bf05c7bd82110fdab24f10b89eac3]

CVE-2026-99329: HID: mcp2221: always initialize and cancel init_work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99329

Introduced by commit 200e6c6 ("HID: mcp2221: Add module parameter to
enfoce GPIO mode") in v7.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a006ff898b459e0bd10375d7fbe0ea7f7a132b9]
stable/7.3: [19711bd64d60378137353ac3e6b774bd3a660f89]

CVE-2026-99330: HID: mcp2200: validate READ_ALL response length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99330

Introduced by commit 740329d ("HID: mcp2200: added driver for GPIOs of
MCP2200") in v6.8-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [26ce0e6bf0b27fc6a2f490f38555dfd0a27c9605]
stable/6.12: [0210fd34232c8450fcaa5a68ff4360f275c755f2]
stable/6.18: [47f50fbfd664ceede78f502950eb5638b537ed74]
stable/6.6: [591352a66dab5d55ae30721500e82472268ea99b]
stable/7.3: [6ee339f14d81da30909075f2dc88926dd317591a]

CVE-2026-99331: HID: cp2112: validate response report lengths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99331

Introduced by commit e932d81 ("HID: add hid-cp2112 driver") in v3.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc54e71a063c0dcc4bceba6d0f71805a9b84082d]
stable/5.10: [dfea21d67426b93c60ec4575f27ee1e73c3a75d5]
stable/5.15: [4ebc9aed3fb7326daad7e7b336bb17b9d41b91d2]
stable/6.1: [f1b4bed4163e7097cd2d59b2c21220d038b6b20f]
stable/6.12: [e178cdd6ed0f4ac20afc9220eceae3a89e6719af]
stable/6.18: [94d0e789d8b0d2ea8e25ed5ff2fe2648e11f2297]
stable/6.6: [50fc069cfcb25e9d36a8cccf9111d53bc47a309c]
stable/7.3: [773307dd4c3e8c27eb31650af2df2d91cba22de8]

CVE-2026-99332: HID: core: Fix out-of-bounds left shift by 32 in s32ton()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99332

Introduced by commit 69c02ff ("HID: core: clamp report_size in
s32ton() to avoid undefined shift") in v7.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [5fe63b415c636c7f4f6848a8e53bdd4bbf0c300d]
stable/5.10: [982413b709dd105cdf34bdfa9c4a8063ce574dea]
stable/5.15: [4a9540176af7f784ba3660a8da45bf66defc9960]
stable/6.1: [a34e4bd9c4ef339cb99dd533bf24a077b84dd099]
stable/6.12: [8bc6279634b03222d79788481810562a7d3564fe]
stable/6.18: [076bea989f998f4d5a62d74de2f04f6f5b94b3f3]
stable/6.6: [e0581a828c8cab80f13f70a4371bf5fc101f68c8]
stable/7.3: [20518a118bf185e72f769eb07aeed5848c095d31]

CVE-2026-99333: HID: amd_sfh: Use report type from request node

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99333

Introduced by commit 1434f9f ("SFH: Create HID report to Enable
support of AMD sensor fusion Hub (SFH)") in v5.11-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85f1bea97f1909f81577cfcf3e4db9017e7f5337]
stable/5.15: [cec8ff26a95d19dbd3069660c27d6db53c3febee]
stable/6.1: [b723f3e731dc30f35910cc47dbcc85c8aba50004]
stable/6.12: [65dddbaa40117ebb351080d56d22d8d53b78b1c8]
stable/6.18: [5652b50db002f6cd72c86886aaa1372a429375b9]
stable/6.6: [2bfc7c140dff40e4bf7401b58fe5293b75358538]
stable/7.3: [a59661811be67ac0911e9af44e43b9b7c169f065]

CVE-2026-99334: KVM: PPC: Book3S HV: Add preempt_disable() around
virtual-mode HPTE bit-lock users

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99334

Introduced by commit 6165d5d ("KVM: PPC: Book3S HV: add virtual mode
handlers for HPT hcalls and page faults") in v5.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abbbe5ff83e7c9ed3a4d61b73011f1df7bf87907]
stable/5.15: [0f678269ac881d02f073ddf4297c65408bee8dce]
stable/6.1: [aecbd8c58be307910b2c6c03ec284aa65dd01b13]
stable/6.12: [8f021a671b511a49468e87a4935b43b0a4d045c0]
stable/6.18: [7a02dfbd2f4a7dec468221d639f740a51d4483e1]
stable/6.6: [85ce15cb2636c11b0b3821bde903bbeba7e13d82]
stable/7.3: [9ffe72ff3f1ef66dc554ecafbe0861c8c118eb41]

CVE-2026-99335: KVM: guest_memfd: Establish memslot<=>guest_memfd
bindings *after* memslot is ready

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99335

Introduced by commit a7800aa ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl()
for guest-specific backing memory") in v6.8-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3fe5d2944e5ac3fc5073344b0982c73703332e18]
stable/6.12: [698f807aa8df9414fdc23d9ea454f4883b5b08ff]
stable/6.18: [dc0cb5d30647b22a3da252a2847ed8f6afb5d567]
stable/7.3: [fd224f1778e13660aec4e1f51fcdaeab5794e7ee]

CVE-2026-99336: KVM: guest_memfd: take the invalidate lock when
unbinding a dying file

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99336

Introduced by commit ae43105 ("KVM: guest_memfd: Remove bindings on
memslot deletion when gmem is dying") in v6.18-rc6.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [0ee2c883b62deb74d8c43007e8049dc006d3a2fb]
stable/6.12: [4ae4316682cdc78d8f5a856ab0712a8281f211ca]
stable/6.18: [3af94f4e3526efdf52d84d7ba8d9fb8e8facb93a]
stable/7.3: [024be82ac4c4df650cc6daca6d7db79daee95470]

CVE-2026-99337: KVM: TDX: Enable Bus Lock VM exit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99337

Introduced by commit 161d346 ("KVM: TDX: Make TDX VM type supported")
in v6.16-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63d196e2e20429de5ba501f1b6059d9b93140007]
stable/7.3: [0f5a9b6e7b222595a3146320875203621bb22d7d]

CVE-2026-99338: KVM: TDX: Enable Notify VM exit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99338

Introduced by commit 161d346 ("KVM: TDX: Make TDX VM type supported")
in v6.16-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d93395058c1951bb657c8895dd1fc0f22263f1cc]
stable/6.18: [216729d9780df7d4cf91435af38c8f65d51ce93d]
stable/7.3: [02b92b0d7cdcda3c1f7196a3210bbe867ae6693e]

CVE-2026-99339: KVM: x86: Zero reserved synic flags when delivering
message to avoid stack leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99339

Introduced by commit 3a0e773 ("x86: kvm: hyperv: simplify SynIC
message delivery") in v5.0-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2616f497506a772db53e7bb1024cde50b4c165e0]
stable/5.10: [20931f3d794632f265be952e60808e65c142a6ae]
stable/5.15: [8fdb97a4c89635c7ba973c5ef98efd1d8c8e0405]
stable/6.1: [17e825d384861e49049160811758c7fc7001a979]
stable/6.12: [fd7764eea189053ce6345950f11e4aeecd741fba]
stable/6.18: [ab15e4093e2aff170ea2087ab994f64530a13cba]
stable/6.6: [d8b73d478858f8249af318e249df38d98a103480]
stable/7.3: [416da9d1824cf34c709f3222f5012714810734dd]

CVE-2026-99340: KVM: x86: Take SRCU in kvm_zap_gfn_range()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99340

Introduced by commit 362ff6d ("KVM: x86/mmu: Zap KVM TDP when
noncoherent DMA assignment starts/stops") in v6.7-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b59a87c1ba3c347e8aec5f932eb7abf13064fd62]
stable/6.12: [9d119b4921ac74bc606917fd274c10c966fa5b72]
stable/6.18: [ec9df57c8e00f189d58d927cc9a1f49592f687af]
stable/7.3: [e34057e59ed784a37657835aac9f54eec0864342]

CVE-2026-99341: KVM: x86: Request event processing for exception VM-Exits

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99341

Introduced by commit 7709aba ("KVM: x86: Morph pending exceptions to
pending VM-Exits at queue time") in v6.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88b23a2e8286b7016c3b58dc10093cf28c22aa3d]
stable/6.1: [1833cf1c9ab68add7102d932a3b135f1a487a944]
stable/6.12: [e663aa0755a11f13e45ebe65a0c37d47f5529560]
stable/6.18: [a92a07205e010029796b35924655aebb903b2e7c]
stable/6.6: [e73cc3e9718f821a605968ebc63028880e6c7949]
stable/7.3: [6513f7be321ea273ad19ceb08afeac2b93ea28dd]

CVE-2026-99342: KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99342

Introduced by commit 73e69a8 ("KVM: x86/xen: register vcpu info") in v5.12-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eacdb76c5f04956035c5d7f7e1973028f30684a2]
stable/6.12: [0381288c2fad72cdbe868216c179f6cbefc2ea01]
stable/6.18: [b7af8dc92af17e107d15360e62470ec862fa3d7f]
stable/7.3: [ff7b7447397638c31200e87993589ea42d6f96ff]

CVE-2026-99343: KVM: x86/mmu: Bug the VM if KVM attempts to walk more
levels than the MMU has

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99343

According to the .vulnerable file, this bug was introduced by commit
fe660f7 in v5.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [115f9405a2ed6d78ee7ad8436bdd638743f6d1d4]
stable/5.10: [0e71b873df7290b86a7daa3dcc83275d5c092961]
stable/5.15: [5e355f718d31145946fbe62d31f642eb990a0076]
stable/6.1: [40730c48b8ec666cfa65522beaeca681583a0991]
stable/6.12: [d6f3877eabf159167ee9972d627396412a04ac74]
stable/6.18: [54afd548602bb96b3fbb0b4b11ccbbfeb5fb46fc]
stable/6.6: [eb9ad548e9b269172ff83719f75ffdce4df2e7cf]
stable/7.3: [73f427e5afd94edd5d0e7cdddc2ecc794f28c492]

CVE-2026-99344: KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when preparing L2 state

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99344

According to the .vulnerable file, this bug was introduced by commit
236de05 in v2.6.30-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c4c84a643b704e473cb171f7b61359ff29b12a4]
stable/5.10: [92c1aed9e100e6f3a13746456c679a8846f831c3]
stable/5.15: [2d7c4481d2dce9310cd4abc3e4c1a0c7b1878744]
stable/6.1: [39016b9d8892b57d53db16190653e28484df3425]
stable/6.12: [ccd10b6ce7fb6dc36b70fd75dfb8bab33e65e9ae]
stable/6.18: [a4c2d0a9a9019e71c94ff2b8f56b8f7fc97bd71d]
stable/6.6: [eb2d046f13796466eadd46d7ef039fc31f101d63]
stable/7.3: [359888db0e2253365583376ab24dede981ce9f32]

CVE-2026-99345: KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has
EFER.LMA=1 && EFER.LME=0

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99345

Introduced by commit cc440cd ("KVM: nSVM: implement
KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE") in v5.8-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5dc500a354cc8e109df678076ae3488094649468]
stable/5.10: [db914162770d60faaff53b3ed68e4785ac219072]
stable/5.15: [fb11e2b98cb543df5b7e955a991e72163d902fa9]
stable/6.1: [bd10bd806e1a30a905a0595d6c5add3c2a05cc03]
stable/6.12: [c0b29d523ef363d1d7ccfb3199f0126b22a61f66]
stable/6.18: [98362865bb626bb5e76cede98555d7cd4fefc016]
stable/6.6: [08cb539fdd19ea7093af55c6b97d4d7a198aa247]
stable/7.3: [81c460713ca62fa33ee1241fda1ddaf099facb32]

CVE-2026-99346: KVM: SVM: Trigger new ASID allocation in both VMCBs on
pCPU switch

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99346

According to the .vulnerable file, this bug was introduced by commit
193015a in v5.13-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf260dc9e7b8bfcd06c1a8e739797b1cf0917c72]
stable/5.15: [57cecf976ba4abea93b6ce2c6e3d2ad2f0be94dd]
stable/6.1: [d953b0eb5191e3c8811d747d08e72eac157747ae]
stable/6.12: [5636d57b61068918085360aaad18ab57872e5800]
stable/6.18: [058173bce103b6ac405b2bbf61e29a7f3767348f]
stable/6.6: [5a329cebca79bfdb42210798686d4d36dfb693b1]
stable/7.3: [7d787fb34e825218702496fb0d5892529bea9366]

CVE-2026-99347: ALSA: x86: hdmi: fix chmap array missing terminator entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99347

Introduced by commit 5dab11d ("ALSA: x86: hdmi: Add audio support for
BYT and CHT") in v4.11-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5e1a9a3fddab8421416b68bb132ae9626d07156]
stable/5.10: [0ec83d9adc4ee09df7afedacacadd86258f31bec]
stable/5.15: [d7eb7812f258b488950b2cd28f352c79d10a8f27]
stable/6.1: [9fa311daa6c836b93ebf1464050d977a419d05a1]
stable/6.12: [a0b1f32f912faaad0ed3ee98a04367d9a6e3a737]
stable/6.18: [29fdc91fb672da4532cc9da6d53aa9b3c396ec63]
stable/6.6: [210cb53b0365b484b74e546f6c5b208049f4c7d6]
stable/7.3: [92f77936554b01ed5bff3175e511111b5aa57976]

CVE-2026-99348: afs: Fix afs to abort the rxrpc call on send error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99348

Introduced by commit 08e0e7c ("[AF_RXRPC]: Make the in-kernel AFS
filesystem use AF_RXRPC.") in v2.6.22-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e6af08a571fe2943a006acf3e890f36322602bc]
stable/5.10: [0d6710bf05a1b3ec4f182d19d05e263bdcd5f518]
stable/5.15: [fb5cbd2de13d579030fe255831fcd93c326c6e97]
stable/6.1: [2358dcd9b19d3b352cc0fce089cab94463b4c784]
stable/6.12: [0d47f7387a21178f799bbe7a98a58bc2a215eb9d]
stable/6.18: [ff518f5f7adc035d10c70216c0475305f58c004c]
stable/6.6: [ba9e41dd82b5f1ed54a228e66f245b866310a71d]
stable/7.3: [6b576c59a8ce1d69108d1b844cecb9e4a0349af4]

CVE-2026-99349: rxrpc: Fix lack of short-send handling in
rxrpc_kernel_send_data()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99349

Introduced by commit 651350d ("[AF_RXRPC]: Add an interface to the
AF_RXRPC module for the AFS filesystem to use") in v2.6.22-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af208f36ae22440cf6011a43cb3064fd525d85b4]
stable/6.18: [8b9efc7b27bf7d3f12f5ba3d5d9ab39a76883637]
stable/7.3: [3f37c5ff0b93b6dcced633eb62a7091281527830]

CVE-2026-99350: rxrpc: Fix update of call->tx_pending without holding lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99350

Introduced by commit b0f571e ("rxrpc: Fix locking in rxrpc's sendmsg")
in v6.0-rc3.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [7801c42c3bb737cfb06194a383873fcad8daacf5]
stable/5.10: [43ba0d1e2e2aaef662eeebb30b7065e54a92f153]
stable/5.15: [d625b62be703e03d8ebe1caf578029d699009dcd]
stable/6.1: [a1610975f8766ac492de56336086e7a895881947]
stable/6.12: [35f7a69391ca0819d04ca6db3c2355848d633e16]
stable/6.18: [965456110cf6952cc4eec80761171503e6e424df]
stable/6.6: [b878e2b7445a220746eaa3db0e448d6b4a122d2d]
stable/7.3: [ec98e8bdbde85e2dd2d43570e25b52bdfac1735b]

CVE-2026-99351: sunrpc: treat empty auth.unix.gid replies as negative entries

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99351

Introduced by commit 3fc605a ("[PATCH] knfsd: allow the server to
provide a gid list when using AUTH_UNIX authentication") in
v2.6.21-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a12cc0930235b86b934ade7c077a1935c2ac333d]
stable/5.10: [544d9ac0f6ea71ef743b249eb5dcd4af4fcf9497]
stable/5.15: [7257ffbd64309a39b1c5febb8d1709072837e0e1]
stable/6.1: [d449a7448cf18f06eda673095be653d5cc44ae70]
stable/6.12: [3a791bd9456839f8f13c4686b2287524a0a04141]
stable/6.18: [8067c654ae8c6d88aa0d499e9974b59ab2fe5042]
stable/6.6: [c687133dce7fff425a943057b891e782719e112a]
stable/7.3: [9d161fa805f49dd21d131065485065067bb96c8a]

CVE-2026-99352: SUNRPC: trace an accepted transport before publishing it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99352

Introduced by commit 11bbb0f ("SUNRPC: Trace a few more generic
svc_xprt events") in v5.8-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06f90cf104fc21ee01e7ef1eb80e092173089b9f]
stable/5.10: [9ee046d30f9bbcc5f3f9680f24307b766f9e0876]
stable/5.15: [11516c07bad931f87ecf83353a98f22653889f77]
stable/6.1: [1320fc2ccfcb16381ffbecdc3e460b944194ffb8]
stable/6.12: [4d20ecd289ede2487ee5a23962fa78fcb47c0500]
stable/6.18: [fd7b12865b2078f16406834631c4a68262d28346]
stable/6.6: [0b69b7b0338892ecf95758e50b1401ecd344b33c]
stable/7.3: [86f3078ed2bd6645f5d44fa41917453b774808c1]

CVE-2026-99353: SUNRPC: Reject a socket that already has an svc_sock attached

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99353

Introduced by commit b41b66d ("[PATCH] knfsd: allow sockets to be
passed to nfsd via 'portlist'") in v2.6.20.16.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0995447b8059c4d23853cdcddbe789c4a2b6bb88]
stable/5.10: [bcc27e675d5da0766c1833217ed8e1a802377ad6]
stable/5.15: [aa549d480fbb1e7ae4f7603040abe43c98abae29]
stable/6.1: [b777afc4e25d0dce306a114466fc5ecb1b40274b]
stable/6.12: [514ce838b4f26780fa31da7d7f1e30d696ea6a9e]
stable/6.18: [f44daa50489fede01012c575d9f5e7b11a212fe4]
stable/6.6: [86e3096c0644825e2549b02900b633b80782e895]
stable/7.3: [42923e0fc817a7e78d1a5e7cb82966d27919e332]

CVE-2026-99354: sunrpc: pin gss module across auth_domain RCU free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99354

Introduced by commit 608a0ab ("SUNRPC: Add lockless lookup of the
server's auth domain") in v4.20-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b64d21116374688c33302a6704387c27d1156d72]
stable/5.10: [c36c7c801e031fc0e1618b45c54bc52d6a0fad70]
stable/5.15: [e0f6f39ede63762eb78ffeff3243373c822c58c9]
stable/6.1: [e9df0ccf281645613570cc2a7bf9bd0a18792c41]
stable/6.12: [0cbdbf26c456ef6ad1260dbd1b772239ce7bd071]
stable/6.18: [f735700c06303335067a49ad4ad8f0b60eb43897]
stable/6.6: [9d995c5debff0312fe70cbdddb3696b7413494d9]
stable/7.3: [1c582f719010b5ff9f678cf8307594be0570831b]

CVE-2026-99355: SUNRPC: fix oversized GSS proxy token copy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99355

Introduced by commit 5866efa ("SUNRPC: Fix svcauth_gss_proxy_init()")
in v5.5-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [62319c2534b603b416fa2aa2f3ef18c311f75010]
stable/5.10: [a192eb3af6461502b7dc28d0f9b31d8f7591a5e5]
stable/5.15: [9ddb4c22c43144fa2bf52848ad2bc485997d9e2c]
stable/6.1: [b71755674f473f5405b39a598b35d3b44e362a75]
stable/6.12: [213fba11c0508f2e7d37ce8592072eed28ca0171]
stable/6.18: [1cc4b3089eabec479b9cce2d6999ab2263d7def2]
stable/6.6: [97dc03ca9f8e58ef7d5a87b7e2c6635c02869cb2]
stable/7.3: [147a30e2e482c9764acf529ba22916cf1212d7ed]

CVE-2026-99356: SUNRPC: Do not credit control-record octets to the RPC stream

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99356

Introduced by commit bee47cb ("sunrpc: fix handling of server side tls
alerts") in v6.17-rc2.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [129e7107b971009bc81643d23f3ab949f540d321]
stable/6.12: [d784d46e19b52a553d5c772a18e13b4c6dc84708]
stable/6.18: [67d36b376f76a71e52a5f8ed4a4d9d90b8b68133]
stable/6.6: [24a2e754fe2c9a8f1f642ff694545cdbe088e9d7]
stable/7.3: [99eb91d68e73a08bfc784eff6f5c02ecb6ea58ba]

CVE-2026-99357: SUNRPC: Copy the deferred RPC Call from the head buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99357

Introduced by commit 260c1d1 ("svc: Add transport hdr size for
defer/revisit") in v2.6.25-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2192a56b0686599358909c3e12e9a366f5b5d452]
stable/5.10: [2df839cb84c87063328fbde7ed596ebfcd90f5c1]
stable/5.15: [de4c9b2daac9e0e9bcf2f63b4c2c61f59c63a3e7]
stable/6.1: [a56ec5e117238c45d66be6f1125b4d5d0e715241]
stable/6.12: [629a17cc81fe0b749bbee8303797b6c99a3e776b]
stable/6.18: [d514dd81771aff1192e84a57ae60428c13f07ccb]
stable/6.6: [6ba5228ca9ec4adf24c1d1ac50620556993ac6bd]
stable/7.3: [70614e41d379e5b9b1893ac65b49ae4cea6c36eb]

CVE-2026-99358: nfsd: zero NFSv4 COMPOUND tag padding

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99358

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f1181cb09c85499286c7f462d93530b0ebcafcc]
stable/5.10: [16c25cc18e93b8849e2f969cfbc55e68b4ad9548]
stable/5.15: [e6b07186f06695e691b8483b570dcc4538db637d]
stable/6.1: [58e564cfc1572ca41532fd5f6f2d4a49b5668c89]
stable/6.12: [c9c771118ad1f94d70430975383f4440cd2d88fb]
stable/6.18: [c1e38828c93e5fc958a3d6155c5703d6e7b3de8e]
stable/6.6: [78899d88f03475ce4dd5249107ba25deeb40d8b3]
stable/7.3: [35fc1e20d2b002f43073707ee2f77811706b64ea]

CVE-2026-99359: NFSD: validate transport name in listener_set before
serv creation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99359

Introduced by commit 16a4711 ("NFSD: add listener-{set,get} netlink
command") in v6.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [421becdc5cf4d7d2fbda393e78ca76d25d277c0f]
stable/6.12: [90202cf720f47d4183b4da8ef43bed7dfec0c572]
stable/6.18: [f5a336ad931afdd609c809cea4b3d910e781bd6f]
stable/7.3: [49f6570e1a8989268cfb71448e3d301c5c850c2d]

CVE-2026-99360: NFSD: Set nn->cld_net before registering the cld pipe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99360

Introduced by commit f3f8014 ("nfsd: add the infrastructure to handle
the cld upcall") in v3.4-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14996e662f3b734427e2d645cacffc27b779f7d1]
stable/6.12: [2cdbc244cf895a436f04def419df3bb257e42608]
stable/6.18: [c12f04f29dac29fba1f4eafe54455d48b4ca8df0]
stable/7.3: [d67360912543356aca6fc39e4bb286e08d1c77af]

CVE-2026-99361: nfsd: propagate SETXATTR value decode errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99361

Introduced by commit 23e50fe ("nfsd: implement the xattr functions and
en/decode logic") in v5.9-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cfcfe0b38a66bbc4122c78a2b75e1b97b3534761]
stable/5.10: [236fe4068621dd8d28626b322792daa4bb1c5738]
stable/5.15: [4ebc19779c82ea90c6fc06e74423c08a6ccf560f]
stable/6.1: [31958d44816b4e240938515176149001d78545ec]
stable/6.12: [f394f6d81cda9dc8626aeb556600b9fe94d3a5c0]
stable/6.18: [7d464c3e93214a8d1fcbd226f5d622993232bbb3]
stable/6.6: [bc150e1da0df0dbb6c5f894c79bd2e54e76177e9]
stable/7.3: [479651d608f3734fd0b8ca6243e247e9f09d0414]

CVE-2026-99362: nfsd: preflight SEQUENCE replies before accepting a slot

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99362

Introduced by commit 47ee529 ("nfsd4: adjust buflen to session channel
limit") in v3.16-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35ff1a7a7e3835c3e974bc5c45d335897564ceae]
stable/5.10: [aff12e327620258123f847d7d06565f4555c5cb4]
stable/5.15: [6a26c5473bb112d8420ffd48d5331bc5fb5a2065]
stable/6.1: [fa85acf074f000ad3d1a5ffb703128ff97de983d]
stable/6.12: [1a5a227bca6a8a9f9d31230697aeb84c62a21da6]
stable/6.18: [37fc2ec211630360e9aefcaaec8730db964645f2]
stable/6.6: [cd303eb29cf34a6780f4c42aca5b8ca4a05a5d59]
stable/7.3: [ed98b0c57e5e84290c5b35428144ab26778905f3]

CVE-2026-99363: NFSD: Map flex file layout IDs through the request's
user namespace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99363

Introduced by commit 9b9960a ("nfsd: Add a super simple flex file
server") in v4.8-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f913d5d2130a584d1a027ffe3dfd88b6be2e0540]
stable/5.10: [64b971da40273654126365d9c07405c0a5e0dddb]
stable/5.15: [8e496e6de043c4910f91ebad832065b84a607520]
stable/6.1: [184893a9c44c29c8afbf061303af3c26a665f97e]
stable/6.12: [e10bf0e125ebf6b9669b3158eda5fa67b56809d4]
stable/6.18: [76bb89e8155fe29da36ecf0121e9e98afc0f4184]
stable/6.6: [f3cb478d231ca0dc9093def921189779891d8056]
stable/7.3: [c0dacde381e1311bba8074e660d41ecc57c3bd2b]

CVE-2026-99364: NFSD: Fix out-of-bounds read in the rpc_status dump

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99364

Introduced by commit bd9d6a3 ("NFSD: add rpc_status netlink support")
in v6.7-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbea14890783fead76f878caf0775a62a42049bf]
stable/6.12: [6239443bacb4cb1bb4a9e868474ccc03b2f709ce]
stable/6.18: [676b048197cd4b83d63690fc7452a3af9bfd0c43]
stable/7.3: [35c0d6b9d14c1f065dfa8338063fbe3b396b4b3c]

CVE-2026-99365: nfsd: Fix id-to-name cache entry leak in idtoname_parse()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99365

Introduced by commit f9ecc92 ("[PATCH] knfsd: Use new cache code for
name/id lookup caches") in v2.6.20.16.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ca3b74c0c447af17d0e27e76658a3d4cae3c5ba]
stable/5.10: [1faf4158d9f6953fe8c8a7401434fcbded7a1fd3]
stable/5.15: [43f06992d9c717368b3635d9a177e610cf2b063c]
stable/6.1: [cb3edcc87e81c24b8cb7ebc3c52c1f2b65f9beb2]
stable/6.12: [c480c7bea087d923f97a0fd88e51943c3a9cb407]
stable/6.18: [e48996466d78606890613a950fcddbdaa8fd41e8]
stable/6.6: [1cccc9de860073d23aae780a6eae5bf668c2cf1f]
stable/7.3: [24a2a428cb2a95cabdeccd98912b41bc13907065]

CVE-2026-99366: nfsd: don't modify a session slot when replaying its
cached reply

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99366

Introduced by commit cc028a1 ("NFSD: Hoist status code encoding into
XDR encoder functions") in v5.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2987838317501ff67b672ac2a441fe34b7729f3d]
stable/5.10: [77abd676699dfb8926d6ae240140a40f4dc3f4bc]
stable/5.15: [55ff12f6805a3afba9b1ee1b3b09d8e486770c24]
stable/6.1: [82ec8a5a98aae4b74a94ba41d420e57f889a47eb]
stable/6.12: [065764e256ebff20201dca5bc6ff075c6cb62e17]
stable/6.18: [0b5149b7ad8ccd64c61e887e2cf1af068b6210c9]
stable/6.6: [e089a272755632f0c2f227ad042557afafe88a34]
stable/7.3: [4e3c12151f13c4e51eb381f9377835fb94b9f56a]

CVE-2026-99367: NFSD: Don't complete a cld upcall the daemon has not read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99367

Introduced by commit f3f8014 ("nfsd: add the infrastructure to handle
the cld upcall") in v3.4-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f4bf851aca4e18940ebf2bddf4ba6783802ee81]
stable/5.10: [b3824c740ba907f5bf9e1248a9544434f71fd329]
stable/5.15: [2b39561981d208b6c4d421aa87e889e556ab2a67]
stable/6.1: [4bf83e257e6e11ef074e0b3022f70674973a9ad2]
stable/6.12: [e058341ceb177226fdb20a36d48fa827851d9c81]
stable/6.18: [f6d1f1072243a1adb1ae15425f6e36f86be94078]
stable/6.6: [abc3d64d002af2d6078e6cbdc654e3ff5654d5a4]
stable/7.3: [226c11eb20042ce4251f50870ce61f86581f8152]

CVE-2026-99368: NFSD: Do not send CB_RECALL_ANY to NFSv4.0 clients

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99368

Introduced by commit 44df6f4 ("NFSD: add delegation reaper to react to
low memory condition") in v6.2-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [95ff0c079b9cab91f2327beb4197a3bc48c71f55]
stable/5.10: [5fd9411300edf074b1307d7faeb20153f698587e]
stable/5.15: [e1f84dfc4fae9339d241e78d986473330a5c3d0a]
stable/6.1: [0e0e2ac530fc7cc60fb656ae90f2ba31c29bae91]
stable/6.12: [6338a0182628da8ea1e66ac5397510796e71c632]
stable/6.18: [b202a337fddfb81c5d159e66441fb84c7783f537]
stable/6.6: [d5f3f5c23ae1020d6ff84b28e3c98ef81180983e]
stable/7.3: [cd58899f22a9a232c741f890728fb5d9a2b007fe]

CVE-2026-99369: NFSD: Destroy a recalled delegation the client does not hold

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99369

Introduced by commit 3bd64a5 ("nfsd4: implement
SEQ4_STATUS_RECALLABLE_STATE_REVOKED") in v3.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbfa823f624d41e85ebca929ac77dc2182cadfed]
stable/7.3: [d568594503a09ed2761fada2117e4fbaa31972e0]

CVE-2026-99370: NFSD: copy SETXATTR data from all XDR buffer segments

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99370

Introduced by commit c1346a1 ("NFSD: Replace the internals of the
READ_BUF() macro") in v5.11-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [b01319947c69b0e3ea0fcd4b675eb892f9cad8a0]
stable/5.10: [dcb096258b059d83320c29ef012643c6f4ee00d8]
stable/5.15: [d887960eda2512330d7fc2fa41339cc94bca3df0]
stable/6.1: [1cfd4174cd278eac259a0b6742bbf3f486a13603]
stable/6.12: [019cf7e0eebf6dc14b465cc984390b41c854da69]
stable/6.18: [20b76bdbd029343ea98944cb88bf016da2371739]
stable/6.6: [b5ff29c96ea95d351ab14b9043a25844c26ed41d]
stable/7.3: [fea77ec4a37614cbbe4fb26c621227182439f487]

CVE-2026-99371: nfsd: clear XDR padding in GETXATTR replies

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99371

Introduced by commit 23e50fe ("nfsd: implement the xattr functions and
en/decode logic") in v5.9-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [daba58690339ae86f1ebeb5197aa1369fae37e57]
stable/5.10: [9fea978a36cc46870c32e404ce160abf917dd1c7]
stable/5.15: [7a73ae3a6b3a0d37319ec9dc23bdb5906e695712]
stable/6.1: [560803be825f30932af7ff97b7437059f55dced0]
stable/6.12: [842e2215a87d062b69d5170840f34fbd83f47b41]
stable/6.18: [624531ecd48b96be2a94c964685762960bd11208]
stable/6.6: [e2e76ac79296c3d0efdd0b7f183f33df7cee4c7e]
stable/7.3: [99ab5346b69834587b4ae59d1addea5960b50c8b]

CVE-2026-99372: NFSD: cap the number of listeners accepted in listener_set

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99372

Introduced by commit 16a4711 ("NFSD: add listener-{set,get} netlink
command") in v6.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a05e5ee0a98b9550521df86936b5f825bc07ec2]
stable/6.12: [4a6c685d7e443d5c12197d01576202544247d107]
stable/6.18: [f256b39c64e956d9db46c5a42be99f9fe9685919]
stable/7.3: [340fd5acb07f0299e71afc54a4a4b32e129177c4]

CVE-2026-99373: NFS/localio: detect a short read or write before the
iterator has moved

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99373

Introduced by commit c817248 ("nfs/localio: add proper O_DIRECT
support for READ and WRITE") in v6.18-rc1.
Introduced by commit d0497dd ("nfs/localio: backfill missing partial
read support for misaligned DIO") in v6.18-rc6.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db3ca539c1142d2c5380c5dbd3154ab7bb1c7d77]
stable/6.18: [8be28bd11e098cd4f109edca1b883fe5704167ee]
stable/7.3: [ca85441a75b526228923e2959bd576403c4bba85]

CVE-2026-99374: NFSv4/flexfiles: Use the full 64-bit stripe_unit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99374

Introduced by commit 20b1d75 ("NFSv4/flexfiles: Add support for
striped layouts") in v6.18-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0cc1191538b1523dfe944eedc799fdd146c05fbf]
stable/6.18: [43b9e0c39eed665be2267329b5c041ba2b2a997c]
stable/7.3: [2e58e4f9a8dcab90d384d5888ffec38c8718ea05]

CVE-2026-99375: NFSv4/flexfiles: fail I/O to the data server once a lock is lost

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99375

Introduced by commit d67ae82 ("pnfs/flexfiles: Add the FlexFile Layout
Driver") in v4.0-rc1.
Introduced by commit bb21ce0 ("flexfiles: use per-mirror specified
stateid for IO") in v4.20-rc4.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [7fa2ad367abe6d3155daefb57331e7fce1a17afd]
stable/5.10: [f7956dbc775af2a2456e53cdb189155c7b6cc146]
stable/5.15: [d2b4f986c3367a17ec1a8b1b5be1485228a79ea0]
stable/6.1: [68d807d65c479fc4bea3aba2b82fcc6eedcbe552]
stable/6.12: [88f3916a239fc945362eaac13ca2e29f59539f42]
stable/6.18: [938f374ec83912d1383810a1d31aa7ac1940b11e]
stable/6.6: [4232b03065752e0ae1a8544c587577067960f91a]
stable/7.3: [fe52fa5319458d3d5f04046422b4cf954024a26f]

CVE-2026-99376: NFSv4/pnfs: Free the netid when draining a data-server
address list

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99376

Introduced by commit 4be78d2 ("NFSv4/pNFS: Store the transport type in
struct nfs4_pnfs_ds_addr") in v5.11-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7c8e96d1b9fa327cbdea514d047c8295b28d49a]
stable/5.15: [70761862c8b753e0d29a3fa53b41d5cccf83aaf3]
stable/6.1: [b1e27720e14cd28e39f04bd8db3ad94581ef4f03]
stable/6.12: [3c964cb0527bd58f46cb3965e4c78033d892683b]
stable/6.18: [cf4c0b3acb1d0600acc39ecb2f3b22647ac6ddb1]
stable/6.6: [3dad2a9c46753bee387ec3b75f74c50dd571d16e]
stable/7.3: [fde95d71af2c3a3efac0cd4a09f7082e3d1d7805]

CVE-2026-99377: NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count
before allocating

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99377

Introduced by commit 1be5683 ("pnfs: CB_NOTIFY_DEVICEID") in v3.0-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32f0967ea296d447925465c98e7eec71d4e2f755]
stable/5.10: [e322152215bd326404c084c4efd4c77d0ab4dde1]
stable/5.15: [221757078e3d4c9b47067fa41eabcefbc55d760f]
stable/6.1: [d48df0602e96e0fa76c3fbd65ac2c2a8db3a0594]
stable/6.12: [fa718909a6585b73857f5d8a62b830ae0c28234a]
stable/6.18: [0e712029fa3370308a15b3e136fddc687b56f4b1]
stable/6.6: [f79519c21e0f578a2c7c3fb8549049c07bd94a89]
stable/7.3: [92371c6d8b0ea9e7c336ad902bcc076f2caa2aa8]

CVE-2026-99378: pnfs/blocklayout: Complete a device upcall when the
pipe is closed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99378

Introduced by commit fe0a9b7 ("pnfsblock: add device operations") in v3.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a25cc8e984610828a526086313b8a7aeefe507d]
stable/5.10: [8ae8e20e8114979b7e4ad2c489450d1ad7c36def]
stable/5.15: [ca46d7173b4d8cf2e5de3720e79208dad3008293]
stable/6.1: [828c73249ca40c86307326202f123f672892128a]
stable/6.12: [e4db79581b42ced776b726587571969aac162c74]
stable/6.18: [9b89bd161183277fe08077f7877b495ec53a2440]
stable/6.6: [a8daef6eb70993690441dbf749d5c96685b6efcc]
stable/7.3: [1c46038a0117c4495783edc8a7532dbda7828e49]

CVE-2026-99379: smb: client: validate SMB1 EA list bounds before parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99379

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ddc7a7e1eeb116ccaf010a6f1fb6ab927f3f888d]
stable/5.10: [3c3679ef16b5e763809f91eb0cde20ee17b6f5a3]
stable/5.15: [e4a360cb4d0a3be7e2812caece32cd03f72c7745]
stable/6.1: [fe9262a2a4c5e12d6bd6237bfc7addf778f97435]
stable/6.12: [25b2cf78709cffcc04b2c576e7150d46b0cecef0]
stable/6.18: [ccdd05f4573951164edd0390bb995fe6d2072441]
stable/6.6: [cb6df4e56561f7f59f90293d67ba93018fd9a5c6]
stable/7.3: [8eec99e61b79bb5f698754dda8e8a1ff7e4ed7ff]

CVE-2026-99380: smb: client: validate NT transaction response layout and offsets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99380

Introduced by commit 0a4b92c ("[CIFS] Add worker function for Get ACL
cifs style") in v2.6.20.16.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83d0d5e0ca22233c75daf139ec0063b9d2ff1ac7]
stable/6.18: [520b48753e3c54172a078e7e4b82aec83ae2e08d]
stable/7.3: [d55c0c19b0d1f5c0101f9aa3b60534b6d6e11052]

CVE-2026-99381: smb: client: reject short or out-of-range FIND
response parameters

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99381

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [531aa4239b0d80d7146b102b98f7aa7da989ccdd]
stable/7.3: [1374082f0897c95610190dfacce463904ec11ea2]

CVE-2026-99382: smb: client: reject FIND data areas that run past the
received response

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99382

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29bd6773187cb5c1bbbdf90d677c6add7d58af26]
stable/6.12: [dbc8b87b91b1838beb3e7135a592bbbbd7741404]
stable/6.18: [9763e65a0a4588217cee2c05a00f1023820519b9]
stable/6.6: [7a336f8218dbe972543e530119a6b0e07b6bce43]
stable/7.3: [4dfc78e53f419834d99e626fc27083799e2ea4c1]

CVE-2026-99383: smb: client: reclaim credits for decrypted reads with
no matching mid

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99383

Introduced by commit c42a6ab ("CIFS: Add capability to decrypt big
read responses") in v4.11-rc1.
Introduced by commit 35cf94a ("smb3: allow parallelizing decryption of
reads") in v5.4-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78f73985846465a25a7bd1d89904053661f3ca92]
stable/6.18: [9b3473e7bc5ec104c37faa7f7c9092914d97f076]
stable/7.3: [b3f511aa7f45ff9ab1abc38d133e05b919563aaf]

CVE-2026-99384: smb: client: fix OOB read of the resume name sent in
TRANS2_FIND_NEXT2

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99384

Introduced by commit 0752f15 ("[CIFS] make sure we have the right
resume info before calling CIFSFindNext") in v2.6.28-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8171804a39ee89a11cd462f67862899de9c6b10]
stable/6.1: [7eee47912315711be5eaf371520a9f673a4edfa3]
stable/6.12: [0cc7589ab18a891eb9aa8621f76e1eb09a6d0704]
stable/6.18: [556c3a72f58e0ce4356d57301712cbcd7b2e4c65]
stable/6.6: [44804c38298619152c7cb893c2c0b5a592e699b6]
stable/7.3: [7141cde58f9dc15cf0869529ba2cb09fb0f082e5]

CVE-2026-99385: smb: client: fix buffer overflow in SMB2_tcon()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99385

Introduced by commit 62a1a43 ("cifs: clean up handling of unc=
option") in v3.8-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [73cc469b0ff7551f8537ea919709973e6dc4f514]
stable/5.10: [a4e022f375a04cadca3f799f6157877961be5829]
stable/5.15: [e17fe5c8bf3fca4852e497b7061e316d314d7c52]
stable/6.1: [85692a261042bab56fdfd51e10630f09ef5a5082]
stable/6.12: [75fd4c72aa3dcfabb318144636f416be6796d423]
stable/6.18: [acf25a7be39dccdbf60fdf3d437dd7832fa4b6d3]
stable/6.6: [0149377b312eeb136119223a7c05d55c4b24c76d]
stable/7.3: [d26f7fbca42532c6c79efdceb4bd5198e1849314]

CVE-2026-99386: smb: client: don't resurrect an exiting tcon from
cached dir workers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99386

Introduced by commit 3fa640d ("smb: During unmount, ensure all cached
dir instances drop their dentry") in v6.13-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [d58e7b40908a8a57755811d5b37af1df3380278f]
stable/6.12: [d1b779a4b5acf9a8692b7f002bf6d98e0597cc86]
stable/6.18: [b304a9268f7d54eb75ce62f75013c9a90eabf084]
stable/6.6: [76c98dbe97f8a2c1465b4b21c9428333ba284d81]
stable/7.3: [ed62849db326dc166aa18496e40f27a44b2c7ad0]

CVE-2026-99387: smb: client: bound POSIX lock data area by response length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99387

Introduced by commit fc94cdb ("[CIFS] Fix new POSIX Locking for
setting lock_type correctly on unlock") in v2.6.20.16.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8fc9af68c57156ff64769f30e831553cd03b3000]
stable/5.10: [d4fca47b80e5534b44a74cc23d29e6cb78afcc84]
stable/5.15: [52675cc732ba1bfbb9647d69a71b1d17eabfb079]
stable/6.1: [33f564592a1a3b99df582214f2ba7751db101fd0]
stable/6.12: [659148924f05cfc453cca39b885d76b25b84cc29]
stable/6.18: [9b75ba374fe03e3650d86fe9cf7fcec117389516]
stable/6.6: [c89e3605e9d3d15b584ee99076acd5acfc5b5fb0]
stable/7.3: [d5993c6146ad74a3dab2d9cbd09106d644d761cb]

CVE-2026-99388: smb: smbdirect: fix buffer length underflow in RDMA transfers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99388

Introduced by commit e628bf9 ("ksmbd: reduce descriptor size if
remaining bytes is less than request size") in v6.6-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [7193241a49c958782ba4b8df06da3734d1e317d2]
stable/5.15: [94b94000981c56aa01e9ca2b411dff15600c079c]
stable/6.1: [2e4a60ba7adc1e7529f8923a8b1e452c6ba53c76]
stable/6.12: [5072f32330c71de91c1a844e7becaee48d743561]
stable/6.18: [1f5c774488fa2dabe6667cb26888aaea39c4ead6]
stable/6.6: [a1a44af9fd0555755a81ca0c201f681572471d05]
stable/7.3: [956968544ae647aa9a9534b58735f47922c85d44]

CVE-2026-99389: smb: server: size directory name conversion buffer correctly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99389

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1f37834eaba5904103af1f18afe3510c7e9dc71]
stable/5.15: [534f1360fa87a1a72a5f25541103c66b8d42f73c]
stable/6.1: [9b9d681fd3a78932331ab1246503f102d489cd63]
stable/6.12: [e736ee3660eac5922729a9b3c55cecd74611663c]
stable/6.18: [93d1fbe38f0c1f230fdd24410353b1fd9e5883d3]
stable/6.6: [84e2e9e1167ea4a6ea68b90eb190bd0350e7be74]
stable/7.3: [c8a4c381fd68895bbb077df9b5322c8987b31cf5]

CVE-2026-99390: xfs: fix correction of unwritten extents in quota file data fork

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99390

Introduced by commit a5b9155 ("xfs: repair quotas") in v6.8-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f2792720673f569fa3e1f68181b9d6fd26802b5]
stable/6.12: [d81cc4b379f0ad4cad022896a174313fdba5a780]
stable/6.18: [9702d68ad6264299994b188d2c835dd062a45217]
stable/7.3: [696ef990e101edb4489782301f5a39cfc496bb9d]

CVE-2026-99391: xfs: don't try to scrub self-referential dirent in
metapath checker

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99391

Introduced by commit b3c03ef ("xfs: check metadata directory file path
connectivity") in v6.13-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e7337a3ecebab1bb2ba02187d88b94e5146e4f0]
stable/6.18: [1bde9463d75244ade3f870e34e9e60f2cb686c44]
stable/7.3: [4fe6d43988e98c25e592b560b63d055c01a0046d]

CVE-2026-99392: xfs: don't subtract excess usage twice when computing
agf_btreeblks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99392

Introduced by commit 4bdfd7d ("xfs: repair free space btrees") in v6.8-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4439b626fb5104204952aa2f169451688fb6be26]
stable/6.12: [7fd7a78cb5cce2a6fabd50cf77d059a10cbcf9b8]
stable/6.18: [3e8c3ed178c1e8a1cc93f773ed15c6e487c7885e]
stable/7.3: [10fead7a6e6ec8ed9e2f749012163b19afc5b445]

CVE-2026-99393: xfs: don't overrun incore inode when cleaning attr forks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99393

Introduced by commit e744cef ("xfs: zap broken inode forks") in v6.8-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c28b4b48deac17749ed1ebe4289a4ba73541ddc6]
stable/6.12: [4a6217e7bdf3b1cdd28799d19c175cb3bad375ec]
stable/6.18: [6b93f0aeb8815a3ad296492e97173f9fc137340e]
stable/7.3: [471e4ae43cc5f931430f7701df45ce82c8afc05d]

CVE-2026-99394: xfs: complain loudly when dirtree checker finds broken links

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99394

Introduced by commit 928b721 ("xfs: teach online scrub to find
directory tree structure problems") in v6.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e09438cab72c2c6a32665829d4186155346bfee8]
stable/6.12: [fe4ecd7f474ecb17487ae7c3d9b9cb2009f1e977]
stable/6.18: [b5eb4ffd63fd2207568fcf2b76abffa86bbcf1ed]
stable/7.3: [1faee6fac8cb907c6066f22af6669db0396faa3f]

CVE-2026-99395: xfs: bound inode fork length against the fork size
during log recovery

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99395

Introduced by commit 658fa68 ("xfs: refactor log recovery inode item
dispatch for pass2 commit functions") in v5.8-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9232301894a06e664d8de2da97175cf98419bd16]
stable/5.15: [738959d93ca51be0d9d3d15f9b5b84ac4d39fe8a]
stable/6.1: [f9827d457addf4a7fb089124fff01f10de83d557]
stable/6.12: [af559d87fdd921b90c86125f78d8b97d754432dd]
stable/6.18: [f2cc5001ffcc1d8e5e16607ce4b6920ea30c2cfe]
stable/6.6: [287bb7a11fe1053d78172f874e16873d4b20d6e5]
stable/7.3: [e2768e65a5f2f942c831e3df3b06ad7332d423e6]

CVE-2026-99396: xfs: bound da-node entry count against the correct geometry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99396

Introduced by commit 7ab610f ("xfs: move node entry counts to
xfs_da_geometry") in v3.16-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3df5e5aaa3bc0913236c48ab29b7df3a785aa29f]
stable/5.10: [cb0c634fd6de2cf3daf3d6f91ffec3873497f404]
stable/5.15: [83cb680ad9154a3ebf1a22b793b6932e1abc7c47]
stable/6.1: [84ceb84e83aff1eb6043a247a70543c1b5a81e54]
stable/6.12: [aaeb3e51052c94959bbc286ccda0c6f2feb3cd69]
stable/6.18: [5909f2935ca2897b51800d00f58a48605253ef4b]
stable/6.6: [3619d3f206ae62ca9354e521b82e02d3438d2c4d]
stable/7.3: [229c4478a35663582893916250ebcdfc7b845b85]

CVE-2026-99397: xfs: always report inode repair setup failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99397

Introduced by commit 2d295fe ("xfs: repair inode records") in v6.8-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce9098338a7e1a77246684242d10779fc4d4a539]
stable/6.12: [7759a4711b5c443a9dcb9cfff161b550c519aaf5]
stable/6.18: [782bcf8c6d3683f91cd40cd6cc169eb62106da4e]
stable/7.3: [194dfc48a109d5a4411ba2e86c349d2a25e09109]

CVE-2026-99398: xfs: always forget cached ACLs if the attr fork swap succeeds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99398

Introduced by commit e47dcf1 ("xfs: repair extended attributes") in v6.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41ee987f53785b9443388a756912b1a0fe3c9592]
stable/6.12: [f56d0d49f555db88cac92b20dcc988664c72c280]
stable/6.18: [8cce27911eb3f8bb16f04b0a913277de6b7506b4]
stable/7.3: [2430132937e9ce5c6144db0de27439c31d189229]

CVE-2026-99399: xfs: reject remote xattr entries with an out-of-range
value length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99399

Introduced by commit c847606 ("xfs: check attribute leaf block
structure") in v5.5-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15ccd92a782a0253f4a17895f3d3f71e5c1d1973]
stable/5.10: [cb6dcf2e5a339bf83683186652f7149e0a4c03d9]
stable/5.15: [e16b8078e804cc190e7f03bdfc0569595b541238]
stable/6.1: [1bec5e735e51d840268ed43b3829b3b0b7ff2953]
stable/6.12: [56b701b3c272f143bb5f6a346bfbb1fe28ee14b1]
stable/6.18: [97b85a593188f63e133883525c9159f77e660197]
stable/6.6: [a15646a4d5a2c15b9cd809cd531a412501349624]
stable/7.3: [1481b4644cd640f0a603d97ced300a1fbd7d3a94]

CVE-2026-99400: xfs: reject out-of-range attribute value lengths in
xfs_attr_copy_value

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99400

Introduced by commit 9df243a ("xfs: consolidate attribute value
copying") in v5.4-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0643549ffecaeb716c0b75590a9b76dfa5eb35b3]
stable/5.10: [42db3bdf727398cb0e5020fbfec8fc0afca9deb8]
stable/5.15: [b3f78fa60d4be346df7d5dfcbde7a3c05a7a1975]
stable/6.1: [e32f3a262c5739128506f0dad08471dfee06a3e0]
stable/6.12: [91d0cf6244280e67bdc2787a60a10f635ac064c0]
stable/6.18: [c2cd6b3b480ef2ae9752ed924a2199c8c90569a1]
stable/6.6: [655cb24f3852b41a9ddbf0d228f483537832b075]
stable/7.3: [c5c34a0a5a80ecd8fea9fff960907b2924d18cd9]

CVE-2026-99401: rtnetlink: wait for RCU readers in rtnl_link_unregister()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99401

Introduced by commit 6b57ff2 ("rtnetlink: Protect link_ops by mutex.")
in v6.13-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b70edea393de445255da6c706eebb823117a955]
stable/6.18: [9e3a6b707681a6291a410d1b7ce15840a9912a86]
stable/7.3: [ee636421740bc47e9d9e612ca7c9fa7dc5d17be1]

CVE-2026-99402: netfilter: nft_payload: restrict checksum offsets to
known values

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99402

Introduced by commit 112e447 ("netfilter: validate L4 headers after
userspace packet writes") in v7.3-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [c2226f0c7fe90b67732e5ae36dc5c3cc01ddf888]
stable/6.18: [d1f2c892c6cb5801a51817b12bd0326b22b27880]
stable/7.3: [e81a69d22ae06c1cbb211f3301641f332d74f83e]

CVE-2026-99403: xfs: mark overfull dabtree node blocks as corrupt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99403

Introduced by commit 7c4a07a ("xfs: scrub directory/attribute btrees")
in v4.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f61c91a2e5994fa81141d6c06dadae1fed206018]
stable/5.10: [cb9be4fa1e1a3d17419b9a4ce0fc7f954d1634b4]
stable/5.15: [89f9be150b865256c774045fcb4425a6d08e66e7]
stable/6.1: [716790d5bced8ad9038d51dba18e48c2227354bb]
stable/6.12: [bbb234712cc1baada3d04f4900e5ce4c8e70fb49]
stable/6.18: [44cc66d047efa739b2bd816177dd3ebad3c0e76c]
stable/6.6: [5829831f82af286d9070a293e98bb4ae72a2c6e2]
stable/7.3: [aa186263329717e33f52615c243e57a669486d26]

CVE-2026-99404: xfs: check fork type against dabtree block magic number

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99404

Introduced by commit 7c4a07a ("xfs: scrub directory/attribute btrees")
in v4.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43030b72a11a532e7e3c21ac84a8625425b4201b]
stable/5.10: [ae84bd3ab0d0e9ef0bf1ba4d1dc841a676eab978]
stable/5.15: [40abdbcb5a40720a69a1a01964219a0d2dd4cce7]
stable/6.1: [d749e3fbc88ac70b3909e5a2cdf36f3ef9b95f8c]
stable/6.12: [273d2ab0bcd687df4726ad11c86cffa703f452a9]
stable/6.18: [c67017f673bc4a118fac377bc99d39b34465f426]
stable/6.6: [fc5634a20fcf70a9a12757957d4739e4b1fc1fb2]
stable/7.3: [db77cc2d232a2a2a1c6364c9ef3131f0e8445315]

CVE-2026-99405: xfs: abort dirtree repair if the live update hook dies

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99405

Introduced by commit 3f31406 ("xfs: fix corruptions in the directory
tree") in v6.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07732dea4f5d0410e1566b81a58a1154bf9dcb29]
stable/6.12: [9ebf7830d193eb1730a7a1323930129f89c448c7]
stable/6.18: [31f79a0919e3f0d96f7df2c3aa4f7896394f2356]
stable/7.3: [86598d7f4b0ebbca905f650f3a0ba74de957a9ee]

CVE-2026-99406: xfs: fix lost errno returned from xfarray_foliosort

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99406

Introduced by commit ee13fc6 ("xfs: convert xfarray_pagesort to deal
with large folios") in v6.9-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c4f172c246717b1420f138a159ed15c315a58bd]
stable/6.12: [32a4e4be6af9d68283e333844997b2269312bf49]
stable/6.18: [5cdd8d436feba462a2f7a41bf04bc3bfe84c17fc]
stable/7.3: [7322bbd8660abc3bbad7431d88245c38c6d7c2e7]

CVE-2026-99407: xfs: don't repair fs summary counters with garbage

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99407

Introduced by commit 4ed080c ("xfs: repair summary counters") in v6.9-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22a8a7501c0146dba4ce99b8256975ffe945125d]
stable/6.12: [1f88a2c46bac04827eb56d0a9cc29527a04eebe6]
stable/6.18: [1fc1a5a2419a5315872c239e8c56c6dbf26539ae]
stable/7.3: [7dd8e5cced0b0b8570fa42f2b91bd1f9da23e147]

CVE-2026-99408: xfs: don't proceed with xattr repair if the live update fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99408

Introduced by commit e5d7ce0 ("xfs: replay unlocked parent pointer
updates that accrue during xattr repair") in v6.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [833f98b3be45bc7c6ce4c87bdc4892f546ab72ee]
stable/6.12: [66436c033f396e3f1df4027d6368486fcd11ab65]
stable/6.18: [0c5802d7be2bd122ddd8922f262cab8be2e977d5]
stable/7.3: [1e2d0332e619b75bb4d675400bf450db80b41431]

CVE-2026-99409: xfs: don't fix the directory tree if live update fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99409

Introduced by commit 3f31406 ("xfs: fix corruptions in the directory
tree") in v6.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c8226f3d1a7eafe472addc232689e9c9a0c36a1c]
stable/6.12: [9d31894780974d239832f22377ae4a66655626f7]
stable/6.18: [18773e41e92b21f4f8082f12750404bea4caab0a]
stable/7.3: [95c96e9695b8310f91edef38fd9a3e1ceb0f2c77]

CVE-2026-99410: xfs: always reset incore attr fork buffer when resetting fork

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99410

Introduced by commit e5d7ce0 ("xfs: replay unlocked parent pointer
updates that accrue during xattr repair") in v6.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71cb13685e72a3c5d118732559c727a0c9090b7f]
stable/6.12: [e8ce55fa962553faaade7121aed714f787f5d218]
stable/6.18: [a9e94a4cd5a0ed3e875f03c9495f014d3ba71744]
stable/7.3: [a6de88e800a37671ad4f5306b9c4557d502727cc]

CVE-2026-99411: xfs: actually lock the metafile reservation when
adjusting after repair

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99411

Introduced by commit 1df8d75 ("xfs: make metabtree reservations
global") in v6.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e53c620b3670fc0c162b5f768a10a3a17d0c04f6]
stable/6.18: [83f274a69ba6379a50780a7cb117b9052d3a8e6f]
stable/7.3: [45e05c784eee04fb78d8eb80d6635bd85482644a]

CVE-2026-99412: xfs: avoid cross-rtgroup reaping after a repair

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99412

Introduced by commit fd97fe1 ("xfs: fix CoW forks for realtime files")
in v6.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7c204d4ea7ef0cf0dac908388984c2936f1f94e]
stable/6.18: [84c0abd7e70fde9f2f61f06287dbee82734e664a]
stable/7.3: [d46e7803780d5f1a7bbb889f54ab400c30508f09]

CVE-2026-99413: xfs: fix buffer overruns in xfs_ioc_attr_list

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99413

Introduced by commit 371baf5 ("xfs: convert flex-array declarations in
struct xfs_attrlist*") in v6.5-rc3.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b9081a774ee7b9dff1e9ac3765b73c1d6bba5b2]
stable/6.12: [426ba9b807dfda7a0f41754ce8689b2fda4ad36d]
stable/6.18: [173eb03891f4cf7f390521e66cdc5f203dbed591]
stable/6.6: [9aaf87d1c5a58a25dc6edcac403e7c19b28ba72a]
stable/7.3: [4fe8b75e3917113da8ae9d69a08ba9257e97b7c1]

CVE-2026-99414: ovl: skip copy up of empty security.capability

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99414

Introduced by commit 8db6c34 ("Introduce v3 namespaced file
capabilities") in v4.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50912a1715b8a7c614b654011a0db750e372b43e]
stable/6.1: [5c1a0c08f4725d8cf70bfc260ad0ba5ac962d246]
stable/6.12: [ce8fa086d095141675801bb9dea81d24fb43c5ef]
stable/6.18: [5c6a8b2f2f4dc3a0da89c7379ae64962850ba1e3]
stable/6.6: [7cb6f7c291caca7594d73aa6cea16df60afaa9b1]
stable/7.3: [f46a6fdbe8ccc4f64e2e8a8d8cd3a6bd753552be]

CVE-2026-99415: ovl: set the revalidate flags after d_instantiate()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99415

Introduced by commit bccece1 ("ovl: allow remote upper") in v5.7-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75e89c0055c1d7f7eeb462995f11253ca5864f79]
stable/6.1: [b4364e6841b41a6dae250b351d539ed258c77972]
stable/6.12: [e876482d955476d0c066afda8273bfd38e0f65be]
stable/6.18: [7ecbeb1a84f2d099012ccd95a8a7588e1306cc46]
stable/6.6: [d05ab44d355770e20eabd3be06ad1edaaf4bf18c]
stable/7.3: [3d92153206cebe95dc873a4b2b3d506ddf2271e7]

CVE-2026-99416: ovl: read the nlink xattr of every indexed non-dir

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99416

Introduced by commit fbd2d20 ("ovl: index all non-dir on copy up for
NFS export") in v4.16-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb644ed5c6d9afdb1554c41cef1f39d150fbc554]
stable/5.10: [3608b53735e5554b98825ee7c21cf7df489569f1]
stable/5.15: [358cd0602a79792dbf968478536bd6fc8151a37c]
stable/6.1: [8938407fd80d92f286466674e9e9ad4e1bc81e27]
stable/6.12: [07b000b5b458723ca85d67dbbe5f6359c0202cfc]
stable/6.18: [9b50f28c22c948b0c134d5c5dbd62ea0ada97fc3]
stable/6.6: [9597ef3f028c2972d2a4a6d246161bd0736a1178]
stable/7.3: [ffe508adf85acdd57db01a234161e795b7403062]

CVE-2026-99417: ovl: fix a torn path in ovl_get_redirect()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99417

Introduced by commit e04527f ("ovl: fix dentry leak in
ovl_get_redirect") in v5.11-rc7.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [2001cd7ca5560198131e46c6ca3c3472b06145c2]
stable/5.10: [f3efc797bc49489f047f15dda5714c5dbebcb2e4]
stable/5.15: [c7aacd5d22c3423bc31e76d9cd88659efdd01e79]
stable/6.1: [83d71d72e7d8e0f470191739ec56f459e2d4c891]
stable/6.12: [a8ad9bba205f7c6f3b86fcf0bd2d98adcd750f2e]
stable/6.18: [b9f57bb52124aec87bbe344d70a30806fe22b992]
stable/6.6: [0764d318892af6fe1823589ba44248812e78a105]
stable/7.3: [0aa08f8f07872b9f67ab20d4c51e0cf6fc924714]

CVE-2026-99418: ovl: do not copy up an xattr value that was never read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99418

Introduced by commit e4ad29f ("ovl: use a minimal buffer in
ovl_copy_xattr") in v4.5-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [755b5c5c9277be251a51623d6065abab948c61bc]
stable/5.10: [8ed53aab9c9f12f9d258ebd2e4b268e92d4f9cf8]
stable/5.15: [16fe398cdbcad6ee230aff5deb4386bc4560baca]
stable/6.1: [2dedd7b7b805ce8a466c610115cc4565182f952e]
stable/6.12: [3b1f5a4652539014f0162944f1a5f71ee520188a]
stable/6.18: [628260a7204314ab5f1cd93bddb1721cc0226b38]
stable/6.6: [6501862d1842865c163fcc6db5fc06da479bb456]
stable/7.3: [e35c3b1dc69b8c8efe3d751fafb9b50a85f0e2f7]

CVE-2026-99419: ovl: do not copy up a dentry that was removed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99419

Introduced by commit e9be9d5 ("overlay filesystem") in v3.18-rc2.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f635192ad223d2009ee640b63adf5ce3198aa338]
stable/5.10: [509166108df0ef63f946f328c0228e80ca6da67e]
stable/5.15: [7795a4233280a77d0f4905c3313e46e94c9d97a4]
stable/6.1: [a13c8b1cc720e463255eef7026ef90d5156d2ebe]
stable/6.12: [383a883cf71525752a3092bba3c22aa1ab04df37]
stable/6.18: [1d9706fb79a9499f5a0f7d7f755b6bb9b14cc426]
stable/6.6: [1f1e53002416b8574a5b168e6f61d02e1685bc07]
stable/7.3: [0defa3e443bbdd38628f0b594809c52295836dec]

CVE-2026-99420: ovl: check that the parents of volatile/dirty are dirs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99420

Introduced by commit c86243b ("ovl: provide a mount option
"volatile"") in v5.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e34d2ef818e4c7676d8d8e1bf43e6a1ed39efb2a]
stable/5.10: [7a7ff41b7dbc1db48a2227e08488693f8a37dfcd]
stable/5.15: [988392818127403da5c563dfd7e1b96c393b1260]
stable/6.1: [e94cc0c00eca6e29d49ba2530c203c3cb4c03d4b]
stable/6.12: [a343bd631606d9d508808fca272e1e482ed6c61f]
stable/6.18: [68439a05ed529a8b0350f8c6ff3618ff4a8d972d]
stable/6.6: [880fea99b57516ecf0606fe7b7f40b795793d61f]
stable/7.3: [3bf6fda63259692331d21392c3f7c0c02594dae5]

CVE-2026-99421: ovl: always encode the origin fh when index is enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99421

Introduced by commit 5b02bfc ("ovl: do not encode lower fh with upper
sb_writers held") in v6.7-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [949f9d8a5580c77a45fa759123367682aba4d173]
stable/6.12: [4a58c0d62bd23173dee3f337f623d3e14b6c9dd4]
stable/6.18: [b050952bc4e3409c655a4abcd987131bd77ef570]
stable/6.6: [1795ca6571199008f67afa9e88cddf199ddde9ca]
stable/7.3: [5ccb1e71dfea95a9789967c34d68a2b7c048303e]

CVE-2026-99422: ovl: use the pinned upper dir in ovl_fix_origin()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99422

Introduced by commit 9678e63 ("ovl: fix inconsistent d_ino for legacy
merge dir") in v4.16-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f61ff2ebfb3d2967b83b6a4d456242244d5a61f]
stable/6.1: [8ae1e7876107fbe7318ac5594b8bf2a887a9c578]
stable/6.12: [17a540e65e567c8e4dd165a3ce5b592842ba5ab5]
stable/6.18: [b219cdaea16b2f3e8e13a63662d462addd8a2cd0]
stable/6.6: [50ae0a83625d08b4be4f047c293cf1149fe7ea98]
stable/7.3: [77c9b481faacf46b9d9282ffaa71afbac7acf819]

CVE-2026-99423: ovl: take a snapshot of the name for copy up

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99423

Introduced by commit 829c28b ("ovl: use d_splice_alias() in place of
d_add() in lookup") in v4.16-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [65bf000962a33ec9d2488e4e1797b6cf630abcbb]
stable/5.10: [094b5a8d942eecd75cf2a7225d17b21c4112dc02]
stable/5.15: [74826e1afdcbe80e3708055420d36e7b82f899b9]
stable/6.1: [1640716a273a7c25e3da6db2b4adc6fae69322c8]
stable/6.12: [9d844cf28544bfb3e121d31c68f3062bb237022e]
stable/6.18: [c7e2808209899b2b94dbbcc3b28d44f6c065df62]
stable/6.6: [f0e24cf4ca9e412c24f8ccb6739e4b92b4a5ad70]
stable/7.3: [b2d4777172bea58a521358f7d9b871cffe4d5751]

CVE-2026-99424: ovl: set OVL_WHITEOUTS before publishing the upper dir

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99424

Introduced by commit b79e05a ("ovl: no direct iteration for dir with
origin xattr") in v4.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbec8610ec5aaf35df50094ff639febc23f20773]
stable/5.10: [4b079c17a1088b50a117f9a40708e30a3874dba9]
stable/5.15: [c585b90d28036e5adf38790efc3de0613d41237d]
stable/6.1: [6fff0fe13fb982cc19a1f8825ce5a49ed7dd23a3]
stable/6.12: [43ad4a3090e1c2a0c34e9802882b42c5c078d556]
stable/6.18: [7805739ce4577f2c53f5a30be2d48e83e91c63bc]
stable/6.6: [0c0c2086680ea9eb4945fa610df5e252213b9d24]
stable/7.3: [ea5327a9228bfd1609e54f1fca50786e8f963da5]

CVE-2026-99425: ovl: hold a reference on the parent in readdir

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99425

Introduced by commit b5efccb ("ovl: constant d_ino across copy up") in
v4.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16d319e12328acafeafd3eecdf09c46d7fb43452]
stable/5.10: [a23b702ca4799c0975424280c8124a091f818e22]
stable/5.15: [068d627b3dbc98389a71e382311382b122dfbc70]
stable/6.1: [7480571ee0444f281bb6f4f6702c87c107235bbc]
stable/6.12: [862804fc1d8e6d11652d01f84451a0c9396d10cd]
stable/6.18: [0759376aa01168edeec9319f9cc8e5e9b9388c5c]
stable/6.6: [c5bda25914a35bef4b9d01d047efefc8b828875e]
stable/7.3: [73aae2a6b5b34b4ee5dbc7b008fc658c2a16fcea]

CVE-2026-99426: smb: client: hold server info until cifsd exits

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99426

Introduced by commit a5c3e1c ("Revert "cifs: No need to send SIGKILL
to demux_thread during umount"") in v3.17-rc6.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [482c117c6dbeee382790168af10959810450ab09]
stable/5.10: [f2b6e15cb5e5c6b64636aeca4a7b8f6d86d7279a]
stable/5.15: [dacdee7d19dbc80a25a0ad21f3b8ce085922900f]
stable/6.1: [d659f080d135534cdda44f4b7373dd3c8f37550c]
stable/6.12: [54919a8dcd3c2fcaa535597da5290a7a1dece5b3]
stable/6.18: [3c0a424aabe7a312badd9e9d5c530a73901a104c]
stable/6.6: [2e8630114a29713a65aa2ed183ba356443ea550f]
stable/7.3: [20a2fb9842ca504ce8d877ee04fb850a1af5ef73]

CVE-2026-99427: smb: client: fix OOB last_entry pointer from unbounded
LastNameOffset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99427

Introduced by commit 0752f15 ("[CIFS] make sure we have the right
resume info before calling CIFSFindNext") in v2.6.28-rc1.
Introduced by commit b77d753 ("[CIFS] Check that last search entry
resume key is valid") in v2.6.28-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [570c783a96f054dd3ac409a92772e9afb705d21c]
stable/5.10: [f9545b63ec9a58dbca0b9ac48424e263b776842d]
stable/5.15: [9181a0429c8c457a1231f6b50edd7a8e0ef6058f]
stable/6.1: [729ad2e6e48a6bc8a688027746955014499b76fc]
stable/6.12: [9bb37c10bbd57a4a2b7fa61f7c4af479225d0c11]
stable/6.18: [daee49d7a51f1edb062581d49684c9cbfb3d7dc9]
stable/6.6: [c6c79b3ba7ce4d94f1d49e7b44010dca3b601b9c]
stable/7.3: [d6074ea8379b4bee953883f3bfa684cbc284eeeb]

CVE-2026-99428: ocfs2: snapshot dentry names in file and setattr traces

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99428

Introduced by commit 468eedd ("ocfs2: Remove mlog(0) from
fs/ocfs2/file.c") in v2.6.39-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8cd3ff30659775a6831c66687a69d2b83d163591]
stable/5.10: [73faa02f10991761e4fa1a55b619e6de69e2bc88]
stable/5.15: [e651287f55d6ff4a90ef5eb7cd9bbb8cc489d59b]
stable/6.1: [c1495716d84d4bb144646c28a15251ad767824f0]
stable/6.12: [84908981fbda3c133b60e75568d853d3191f9fb2]
stable/6.18: [f976692490bbdf670d4cc241b8951c8cfddb1583]
stable/6.6: [1c90d90e345156b0e0afd37b887e187307fc71cf]
stable/7.3: [d2052367cbdad321d131e6280f41c4be5a1b5c96]

CVE-2026-99429: ocfs2: pin refcount trees before dropping the lookup lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99429

Introduced by commit 374a263 ("ocfs2: Add refcount tree lock
mechanism.") in v2.6.32-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c714a074074af7ae59233c1fa6ef9d7aa710462]
stable/5.10: [86b7a6e80104f714cd354d36c4c8a124ea8e05b1]
stable/5.15: [4e824bf75ce260951433bb22d33f1179d5a3d2fd]
stable/6.1: [c873a7a67cd8d8a26f4ce4a830deb3748e7439d9]
stable/6.12: [ce7b46556af15642a1e9f8d0c596022dd7cfb4a7]
stable/6.18: [7ff4f020f7b03fddd529735f0b61ac0a8dd92c9e]
stable/6.6: [4720f762623680e36d2241cf4d113cf0318c0cf9]
stable/7.3: [2d9e864c234469dc7f56ea974f8269d251441e6a]

CVE-2026-99430: ocfs2: fix chunk number of the first chunk in a local quota file

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99430

Introduced by commit 9e33d69 ("ocfs2: Implementation of local and
global quota file handling") in v2.6.29-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4effccfd50baee4f325694964aeee997dca7bd96]
stable/5.10: [c8f5d2c6b066823f96723bdc0501f0de6bff1cef]
stable/5.15: [b5eb8e75a2a47a8a494a94df4a0f71bf274d568a]
stable/6.1: [ddb61eb4987a6040526a18430c4ec72e2f141124]
stable/6.12: [76986d0ad2e1b71a304db59980f7d3440709cf69]
stable/6.18: [59d336153d40649afe86ff57d3bde1ac1588e850]
stable/6.6: [e310b75834c52e55ba07c9d0699b16fd508bdd6b]
stable/7.3: [5778be09eab716b7d37f653d72c2c34a25f6ba05]

CVE-2026-99431: ocfs2: cancel quota sync work before freeing quota info

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99431

Introduced by commit 1a6152d ("quota: propagate error from
__dquot_initialize") in v4.15-rc2.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1dd1f005026d52642b994d63baa16b0b31f3b14f]
stable/5.10: [76108d9cac8635bdf695dabea978b31b994bb41a]
stable/5.15: [e3a55e1d7b00e4a9d0f21d5da0c084cd7091778f]
stable/6.1: [3c0e55230ad59083247eba653de17c99c0caea46]
stable/6.12: [7873680692369bcdf65480a8d81ccd2f298a13b3]
stable/6.18: [5ff0f92064ab9bb344e7389c198cc9fd7ed30e29]
stable/6.6: [ef6de1ffc15c3ae7cb3764d80f09c6a414d50a15]
stable/7.3: [cd3119eb1ebf8ea7631f68069addf109d4e77159]

CVE-2026-99432: ocfs2/dlm: hold the lookup reference across convert AST enqueue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99432

Introduced by commit 2c5c54a ("ocfs2/dlm: Add missing
dlm_lock_put()s") in v2.6.25-rc6.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [125fe08ff6cfa064e1212f586f01993ee45c0330]
stable/5.10: [a57126a2f5a81232b3453fab8fd9f2f8fcf27017]
stable/5.15: [059d951ef87959435d6f1126ed7d2305dc836d45]
stable/6.1: [c736487fc0b933238ca59ec976dbd628c6ba1bf7]
stable/6.12: [ecc5b17b8d2b1f720262e991896da2c909154a4d]
stable/6.18: [a3dd8d3af023837516d8715393acbaa7b252f6d7]
stable/6.6: [7b8a7bb21a478dc1f0212f99bbfa017f2ee566d0]
stable/7.3: [574aa7782c780b130463e1d7c0605a9e617880d1]

CVE-2026-99433: ocfs2/dlm: hold a lock reference across grant AST enqueue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99433

Introduced by commit 2c5c54a ("ocfs2/dlm: Add missing
dlm_lock_put()s") in v2.6.25-rc6.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71743471204e21113295c786e5cfa570294234a4]
stable/5.10: [c5147b0e9651f6748908977789493a8a44d7b55c]
stable/5.15: [f86c0676010d6987073e2d9fa57259694dec2b98]
stable/6.1: [5b134d3095fc335be882fd342e9c6184736c313f]
stable/6.12: [11643cb726c6077c8d80766516c20ff25ba29609]
stable/6.18: [f4ae0b96a4abc7d59088eb2e0a2ee524c15f3bf0]
stable/6.6: [e62b4ccb47375ba9ece39231378e62759413d071]
stable/7.3: [0eb7cd1641695c5de549516661c9b90ba20f943d]

CVE-2026-99434: ocfs2/heartbeat: unlink live slots when their node is missing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99434

Introduced by commit a7f6a5f ("[PATCH] OCFS2: The Second Oracle
Cluster Filesystem") in v2.6.20.16.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ccd24c3f7a577b84a532cb027f1378385b82ef6]
stable/5.10: [bb9364d7900b31b907a3a2c37acf25281ef1c1fc]
stable/5.15: [210766ec3387a07887445b3ea34853f401577a3d]
stable/6.1: [dfebbcc2db2a98c8bd43a2578866373ad508fa80]
stable/6.12: [dffcdb5633641360204daee2f27d259a06f494ca]
stable/6.18: [3e05df6bd33a920687c90061a6c0cc67cf71464a]
stable/6.6: [597bbd635b2d292c2435e243531a189078204b4c]
stable/7.3: [7294ec25a13c20fe31c543589466d26cf24207a4]

CVE-2026-99435: media: rc: Fix use after free in bpf progs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99435

Introduced by commit dccc0c3 ("media: rc: fix race between unregister
and urb/irq callbacks") in v7.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [f95a9f8472f97c30106513fc7494b7abad243949]
stable/6.12: [52efde6424420e0cf33df2ba23a8495cc141581f]
stable/6.18: [4528f92222e7b90b2ea634338657888f63887d7a]
stable/6.6: [116145c0445480581584e80daf8306ba622fd705]
stable/7.3: [341e2ba83d23b169808b8ccf29d41aee899148fd]

CVE-2026-99436: media: rc: After rc_unregister_device() timers can be re-armed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99436

Introduced by commit dccc0c3 ("media: rc: fix race between unregister
and urb/irq callbacks") in v7.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [ef41a67979aed4d7d4f393c56c1e25b6754e2b78]
stable/6.12: [dbc33be4381cec822906781abb58465d136208a2]
stable/6.18: [e6ed118d14267f6bb03b9ad9ac60fdb8bd52f902]
stable/6.6: [32462d79b9fd619da17425eeb02caba25f7fdbd4]
stable/7.3: [46607d55c3f29b687731f4eb9904b3b8e4916fa5]

CVE-2026-99437: media: rc: Use after free in ir_raw_event_handle()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99437

Introduced by commit dccc0c3 ("media: rc: fix race between unregister
and urb/irq callbacks") in v7.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [3ae19773168104fa57d2a2ec57731e89df54175f]
stable/6.12: [31d5d26130bf4b53684e662e3c3add03662b69d3]
stable/6.18: [6d1be288650bb590aa3894bb060f8a5497c27bab]
stable/6.6: [6b54a7b9fb0ee2390cbff8233255a8fa7441b9e2]
stable/7.3: [ba90c13e3347d6765d00544280cff0401027d22a]

CVE-2026-99438: media: rc: mce_kbd: Fix inconsistent locking of keylock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99438

Introduced by commit 53a6280 ("media: rc: mce_kbd decoder: fix race
condition") in v4.18-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29ee25fa9beb3232808e6d0b3e8ebfb0427cb820]
stable/5.10: [d6b886251b3a39c6197807752b69b68e7b8bd928]
stable/5.15: [c3d1e4f22e0343527405d8bb42589a13aac2dc7d]
stable/6.1: [f4f048f1afae2fac132f87b2ba438dfa49f89d97]
stable/6.12: [15c53a8b50a9595fbd14befe8eb0455616e648a5]
stable/6.18: [0e18282783cc426207127c1214b40967a18ef939]
stable/6.6: [944ae6245f5aed07e0aac871a24a5ae6bf3daa66]
stable/7.3: [7df669eab2abcb141f43cab1e558c401a1093b37]

CVE-2026-99439: media: rc: Ensure registered is cleared in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99439

Introduced by commit dccc0c3 ("media: rc: fix race between unregister
and urb/irq callbacks") in v7.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [37efd09ba2c62e46e3a3a793025c186f8cd1a417]
stable/6.12: [4c94661218f2accf309372cac59ebe9e21853349]
stable/6.18: [63644a8b70dab7e67a8a6f563b7df9647324a41f]
stable/6.6: [eda129862b995154d19eb7af7c9024c2fe0115f6]
stable/7.3: [7a6e8c9726dfd1cb284708f7b179a6bc9bcd6e0e]

CVE-2026-99440: media: rc: Ensure that rc_unregister_device() does not
free input device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99440

Introduced by commit dccc0c3 ("media: rc: fix race between unregister
and urb/irq callbacks") in v7.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [61c7ca95d2483c77dfdde1b007cbe846f145dec4]
stable/6.12: [5698bd38cf2a64c8bdb84243ec9c664d7b941135]
stable/6.18: [144ce635f8cc02955a9bfc7caf14b1818d957a63]
stable/6.6: [0a3afefaef7fea7ccc8c4c98ea73552645d158b8]
stable/7.3: [1a565b81f8ddb01d0b43a9060106dcc88cb3c636]

CVE-2026-99441: nvmet-auth: serialize access to DH-HMAC-CHAP state to fix UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99441

Introduced by commit 7a277c3 ("nvmet-auth: Diffie-Hellman key exchange
support") in v6.0-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53f6efe00cea0c0cf7bd99debe3cdac8567170b5]
stable/6.1: [52642b931d0fdbae34ec414c6e156c1e2ef61d22]
stable/6.12: [4074511c39abed4b763392f0430bf84f166abb4c]
stable/6.18: [edb4f7bcffdb768103c561c588de310f34dd26ba]
stable/6.6: [b77027a6127d85ddd2eb2de94d1be17dba895cb8]
stable/7.3: [35f55810ee2410815d687ff00fb8412d63ab2899]

CVE-2026-99442: nvmem: core: Fix OOB read for bit offsets of more than one byte

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99442

Introduced by commit 7a06ef7 ("nvmem: core: fix bit offsets of more
than one byte") in v6.15-rc4.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [24530401e8001aaa637dd5007fcdc6fbc00300be]
stable/6.12: [2b76fa7fb0a44ded2367e51b1d296f962854301f]
stable/6.18: [006ad1a97ab79f0173e44d82f75340243b54024b]
stable/7.3: [91895cfc28aed7c5daad13475c68588a844843d8]

CVE-2026-99443: pps: generators: don't use the driver's info after unregister

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99443

Introduced by commit 86b525b ("drivers pps: add PPS generators
support") in v6.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e8063cae337cb7328e6856235cf4de5d165516e]
stable/6.18: [a7ba1a5a0c16d3aad161681b01933703419fd52d]
stable/7.3: [ea2aaf6bda6ba90e92abe3aeaff426bba082c0eb]

CVE-2026-99444: power: supply: sbs-battery: disable polling before
supply teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99444

Introduced by commit 6d0c5de ("power: supply: Clean-up few drivers by
using managed work init") in v5.13-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c1c602463d597c5189ddc5a73dece588ba2c57a]
stable/6.12: [3146e37745171f9b9b8aab48d9b8dbcb14a186e0]
stable/6.18: [fce1dd31b185ceadb9669162a5a35444b1059960]
stable/7.3: [190a92be785336a03c36450af560a79a631b192d]

CVE-2026-99445: power: supply: pf1550: drain IRQ work before
unregistering supplies

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99445

Introduced by commit 4b6b643 ("power: supply: pf1550: add battery
charger support") in v6.19-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4856b49317ccd4ce96a0e8970df7d13ce8975a02]
stable/7.3: [2a3ac39a7a260895d794e0a175e9b9a8d2acd207]

CVE-2026-99446: phy: core: Fix race-condition between _of_phy_get()
and try_module_get()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99446

Introduced by commit ff76496 ("drivers: phy: add generic PHY
framework") in v3.13-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [090055ee629523092688da42428558ba56d4272f]
stable/5.10: [bcf7154dee9399c8e51686830d48cb61fee2a915]
stable/5.15: [ad72ea0fd5f00a234f17fe4e3f8c9936e638b6c8]
stable/6.1: [d34440199817f1570bce2164cf3504b9ff45805a]
stable/6.12: [2156c5aefd2c97a60766520bd04f4790f3b38f64]
stable/6.18: [2ea5385758a7cc863d9e2f6b642c8e7820437980]
stable/6.6: [e4061a95067d9aed4b35fa8cd25493ac010e7a2f]
stable/7.3: [8a9f16b5237eb5690cc109d37a545f034afa81de]

CVE-2026-99447: spi: spi-pci1xxxx: quiesce DMA engines on transfer timeout

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99447

Introduced by commit 9538ede ("spi: mchp-pci1xxxx: DMA support for
copying data to and from SPI Buf") in v6.9-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b591332a2bdc13d3f9163793131fe3651d1556a]
stable/6.18: [733552f8c5f5fdce6b2a135dfa2a05ead9f66e91]
stable/7.3: [d858330e288a7818cf6d52ed1bd62153f4cd35c0]

CVE-2026-99448: ufs: use u64 for directory size in ufs_last_byte

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99448

Introduced by commit b71034e ("[PATCH] ufs: directory and page cache:
from blocks to pages") in v2.6.20.16.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1eff23433e73d7da4f9e3529d2701e34962b161f]
stable/5.10: [c43f74f9a7418790f4e28bb94c1423be3ed6b22d]
stable/5.15: [119344a21852412d867c499457b4111a0fb967f1]
stable/6.1: [36b76a83cd622dfd52878c67437d6c3f55c44667]
stable/6.12: [ae50223c56b9a1c27d4f824c9e2fbbefc8686891]
stable/6.18: [c792858491ee39e8f6e1547c45422595cf25b415]
stable/6.6: [627b432794b1114ab2934f6ae6199d789842cb37]
stable/7.3: [ac2859c61ecf52a9e39b44b35c981dbfeb8ad54b]

CVE-2026-99449: usb: gadget: fix refcount underflow in gadgetfs_bind()
error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99449

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb3b441f2698455a48e9a023d5f7f4e3fcb94c73]
stable/5.10: [09e4c7127b4663317c54f37b29722843dc0d93aa]
stable/5.15: [260b0c0ab0b75b358b0b22988ea9a93b5c40c593]
stable/6.1: [48373c3c210e7d797993953ae6d619dfc9e7df54]
stable/6.12: [a28791bdb256abd0f338a9b32a95392907d1c987]
stable/6.18: [e7e89759445e97ccb445758c6c8d5caed4eb42f9]
stable/6.6: [5370f6139485ee3801a83ab32b4b881b97cead46]
stable/7.3: [adb693d0369cd7f08f9424588fdd1f613c22d43b]

CVE-2026-99450: vfio/nvgrace-gpu: Use a core-only open_device in fallback mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99450

Introduced by commit e5f19b6 ("vfio/nvgrace-gpu: register device
memory for poison handling") in v7.0-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c48b994b66d7b585698f9aaee8ff559a7755c0a]
stable/7.3: [a2942b3abb5bddd1bac418abd61fb5f0616ab897]

CVE-2026-99451: wifi: mt76: mt7996: unlink TWT flow if the MCU rejects
the agreement

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99451

Introduced by commit 98686cd ("wifi: mt76: mt7996: add driver for
MediaTek Wi-Fi 7 (802.11be) devices") in v6.2-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [022f5f8b7a0580da50fcbc34da853d03d4321fe2]
stable/6.12: [dd0978ebf56ee9dda9fc0ff36db91511c01fa716]
stable/6.18: [26dc15da08f15e8320514d700d6a4c449d1bb047]
stable/6.6: [3e5327940a2a72f1f81d167eb5e9176341c89e45]
stable/7.3: [40e3d300cc7e27b12e3307099247d6c5cc1fa009]

CVE-2026-99452: wifi: ath9k: delete channel-context timers on deinit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99452

Introduced by commit 705d0bf ("ath9k: Add a routine for initializing
channel contexts") in v3.18-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81394dfb9a7905472957628b560ae894eae3a30f]
stable/5.15: [b4c35b916e0c887de5af4b6771b670ec892eba07]
stable/6.1: [a0c3db730d12800961b20c33f73e394c17417b2a]
stable/6.12: [c2c268ec920867b42ad5a26781f3c0ec426fb897]
stable/6.18: [49e05c8d3d8f546a9723e0fca20df02703f9015d]
stable/6.6: [238f76a81b4725f69855c7065c3024b6ed439134]
stable/7.3: [6609261ccf32e95b67b7c762ff23ddd7788114d2]

CVE-2026-99453: xen-blkfront: unbind irq before tearing down ring and
shadow requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99453

Introduced by commit 1165956 ("xen/blkfront: split per device
io_lock") in v4.5-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3e27b7955727a4d7c0e9264a2a209fbba788bdc]
stable/5.10: [81e5134e16d8418886df1904361691ad873409f2]
stable/5.15: [96ce725ba00576a2334efe449e917eddde7a7a88]
stable/6.1: [4c5664453104926d7bd1f78508e6564ddae70faa]
stable/6.12: [9cdf4fae8fde297ed9ce6bb0058d25449606ee66]
stable/6.18: [e64707d07fcda07c71d4f1405c1bedb0787a6889]
stable/6.6: [2bbf1c1d03258cbc3ad7bf37ae272693d5c9d5c3]
stable/7.3: [5f4b2debc87b6f86b56c6e1f5d97007a330d6aac]

CVE-2026-99454: staging: rtl8723bs: fix protected RX frame validation
in decrypt path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99454

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [495cb31c791bdf3f9efef255a9587b05b0526c9d]
stable/5.10: [d65f8309c25bf52dd2f18ae12670a8f7063a89f2]
stable/5.15: [4992aed169e5c0db152f4a1a2e7f86d67aef8eee]
stable/6.1: [f8eb2d12c741af831b7169eb3a65a327438605f1]
stable/6.12: [60e3352593f224306dfab578bf586b301642265f]
stable/6.18: [33e8f5740319996788395d85a4c100f61593cb75]
stable/6.6: [8d291314426d5626407ba6e281992f14bee96785]
stable/7.3: [b0e79d0ed03ee2e2b9bc0b637fcb87567ff46112]

CVE-2026-99455: serial: core: shut down initialized port on removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99455

Introduced by commit 761ed4a ("tty: serial_core: convert uart_close to
use tty_port_close") in v4.9-rc1.
Introduced by commit f7048b1 ("tty: serial_core: Add name field to
uart_port struct") in v4.12-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [810d467c11f0c85107874d08dfdd11acba6aa0c0]
stable/5.10: [ab8b95daebb4109e454e1f10364aa38d978ca330]
stable/5.15: [8afa64b162759edfd491d1d768e0a020fcd05853]
stable/6.1: [fe1ed96339693654e96d99c980b122b6c4d65712]
stable/6.12: [b05d5ed61e84ad15536e4e51db79a1d1c221c6f1]
stable/6.18: [0f332cce4d592d751aad89b404f68463099167c8]
stable/6.6: [1dcfb3e31d56deafddb8d0fea849838497581e62]
stable/7.3: [928335263daf58e8c0e14d860091e57791693ea0]

CVE-2026-99456: scsi: dc395x: sync the waiting_timer before freeing the host

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99456

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b1a79f2791a06f139dce5450e487307cf0e241f]
stable/5.10: [f2043f041e72a382abca83f2b2f0a39485b78e30]
stable/5.15: [899322bc298ff860d30dce0651ed8f8fae6898a6]
stable/6.1: [fd6af0272d57f85711ffd3310313fccf9fa0856d]
stable/6.12: [0b65c96e51e6aac86f2db251b5bdc5255294a107]
stable/6.18: [a79de0e5e66bd0b69b38c855413a9e3a82926b24]
stable/6.6: [715ad3c3f53b7f4994f5d00f19a4a2de2f12d3c7]
stable/7.3: [bd04acf9b9d589d93823bfeeea9932cd9ce4ee48]

CVE-2026-99457: net: sched: prevent scheduling deactivated qdiscs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99457

Introduced by commit 47e8dbb ("net/sched: do not reset queues in graft
operations") in v7.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d6f81fd6abe209f9803d8f74ce9ec69b8126bad3]
stable/7.3: [34500fda2384be9301d1bdda1cd9c8b49f51f7e0]

CVE-2026-99458: mtd: virt-concat: unlink discarded items before freeing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99458

Introduced by commit 43db636 ("mtd: Add driver for concatenating
devices") in v7.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [112a666bd82e96e4a01e0cd8a0fb9c88dd0bce38]
stable/7.3: [d6bb100e3febf5d0c6c6bed4d4edc5ff7ac0937a]

CVE-2026-99459: mshv_vtl: detach poll waiter on POLLFREE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99459

Introduced by commit 7bfe3b8 ("Drivers: hv: Introduce mshv_vtl
driver") in v6.19-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [efc5dc4c15713fdd6e87882686a26ed1deb22dab]
stable/7.3: [ce2b83e47af491f4b7f0f286367b34cdc57e17e9]

CVE-2026-99460: mptcp: hold MP_JOIN msk ref when cloning reqsk

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99460

Introduced by commit c905dee ("tcp: Migrate TCP_NEW_SYN_RECV requests
at retransmitting SYN+ACKs.") in v5.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9c90cf437a9e6597611b6d3aad6e255fad22867]
stable/5.15: [5d52d2e4c538fe1b81cc39511fd4755a9a46f000]
stable/6.1: [b494df6147b5c435e8a63a7ea8e658c82fe6f922]
stable/6.12: [23f917d95b88a73d1498dd00456cec418dd355c4]
stable/6.18: [c290f8641e41c535c8201e40d6c903f40c6d6e94]
stable/6.6: [fbe825f9e23498de4687a547064e4e363064aa71]
stable/7.3: [aff16e324463d31add9312b171ea96a309cbe4e3]

CVE-2026-99461: mm: khugepaged: fix swap entry value to folio_pfn()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99461

Introduced by commit d41fd20 ("mm/khugepaged: add tracepoint to
hpage_collapse_scan_file()") in v6.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [942c8ec27aa4ffc587511650718349964e1696e6]
stable/6.1: [67d5822d6fbb93abcaae74853f4d125cb6118a46]
stable/6.12: [384c524e066459c91a8750a055fe70d56b334437]
stable/6.18: [c4252273ead984541eb9313667f2924f2ff8d0e0]
stable/6.6: [72b6f93acb1518e811dfd4828ab917acacb32920]
stable/7.3: [9efc8d0c9c81094cfa99667154f5682d487e9b63]

CVE-2026-99462: mm/truncate: look up the end-edge straddler by index

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99462

Introduced by commit 7460b47 ("mm/truncate: use folio_split() in
truncate operation") in v6.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f47dee903b9f0f1e4e7181e8a398a7678cabf0a5]
stable/6.18: [0fab93d241cfb6f3aae29530a9a214157bb64087]
stable/7.3: [863ecacdae9ebac39e25a3e90e6cec3e86bc856a]

CVE-2026-99463: mm/rmap: don't discard lazyfree THPs at PMD level

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99463

Introduced by commit 735ecdf ("mm/vmscan: avoid split lazyfree THP
during shrink_folio_list()") in v6.11-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [984c0700854e35779a2bcce6b02783e709b6efa2]
stable/6.12: [8cf9517996067cfbfc5abdb4cfb3d7e15a7b34a3]
stable/6.18: [3594027c292b09d9301b4be80fa8e0c815ffaf2a]
stable/7.3: [b8c683bd548268453d50e933aab2e7d50a7ac2be]

CVE-2026-99464: media: redrat3: fix UAF in probe error path leaving rc
device registered

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99464

Introduced by commit 2154be6 ("[media] redrat3: new rc-core IR
transceiver device driver") in v3.0-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af452b9e01331b5338a1e5141624f17607239207]
stable/6.12: [d8f44a9e4820797067b8cdf1b6a4cb0c0ae3d143]
stable/6.18: [98e3df13c9fd57cc4051e9ee1717cfc65ee04c7d]
stable/6.6: [880b4990b6b74e9c9dcb3549520f7b56ccf56210]
stable/7.3: [e0e12b25b102e22f17ec3d0c00eb22ef7b792489]

CVE-2026-99465: media: microchip-isc: take a reference on the parsed endpoints

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99465

Introduced by commit c9aa973 ("media: atmel: atmel-isc: add
microchip-xisc driver") in v5.14-rc1.
Introduced by commit d6701f1 ("media: atmel: Use
v4l2_async_notifier_add_fwnode_remote_subdev") in v5.12-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2eb2fd388bf3f1959556a326e797cacca341c86]
stable/5.15: [8a6dc561687b5414db226330d36b7e9d7923bf6c]
stable/6.1: [0c2a5de1fb18b2939c189b4f1a9542d424a8e43b]
stable/6.12: [e89700269a8158781cb0053589a0d7f206bdf7cb]
stable/6.18: [1711d758ede7ad6dc9f9b96366a6eea5c8c867df]
stable/6.6: [4173add1900a69c64d6b634f732f7480d8f0ce2c]
stable/7.3: [f402682026d589474209816ef37dbeb945ebdb62]

CVE-2026-99466: media: microchip-csi2dc: fix async notifier leak on
probe error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99466

Introduced by commit 2de0b3c ("media: atmel: introduce microchip
csi2dc driver") in v5.18-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c7528789244ce7329ca883170fb9315d739ae985]
stable/6.1: [92f9fad36158fe0dfb1b102e0edd291482cb2f29]
stable/6.12: [c287bcddda615b3c954cb5b1fc7e59292c878eeb]
stable/6.18: [9fa70d75ab03f5babb072ad872a54879af4be55c]
stable/6.6: [732aa9069c0f03ab8186997532b4b77eeb77e797]
stable/7.3: [e7dd17ce3190dd6f60e2d0153d8df15562347947]

CVE-2026-99467: media: marvell: mcam: stop DMA and cancel s_bh_work
before freeing DMA buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99467

Introduced by commit 67a8dbb ("[media] marvell-cam: Basic working MMP
camera driver") in v3.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f29f84317c1e35f6a9265277be33e60d3fc8c1c]
stable/6.12: [8445398f75ed573cd8eafaa01273c10990e05eae]
stable/6.18: [12d0222809f943d9bcaffd5fe1d8b9d2c3c74f07]
stable/7.3: [71de8e33596c9c8b3e20e51e18883e6c5f25f7a4]

CVE-2026-99468: media: imx-jpeg: cancel timeout worker when streaming stops

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99468

Introduced by commit cfed963 ("media: imx-jpeg: Add a timeout
mechanism for each frame") in v6.2-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [78fdfbf117c409273eecbfa7a528ef42358a0e38]
stable/6.1: [e5127281b5869ee8279b7790d059180476daeb62]
stable/6.12: [77e1c41d65a9f3cd22d73d0ec1f33cf6cd37b341]
stable/6.18: [49a0623994a10d3d333d48c304f89d816495f332]
stable/6.6: [699777bac0c3a7c33bd63b2536d1ab5562392f24]
stable/7.3: [9e393784a902bb4eb00a21e46d389a32c7ea61b0]

CVE-2026-99469: media: gspca: use vb2_video_unregister_device() on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99469

Introduced by commit f729ef5 ("media: videobuf2-v4l2.c: add
vb2_video_unregister_device helper function") in v5.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3dbbbc3cafa2de377d9b97af4e35b8b6b5282047]
stable/5.10: [aa3d73c8f24eca700a3278985b61f8a437f59805]
stable/5.15: [99ce88b7439d2bb2e5da774a9c9e9c38a8b3dde5]
stable/6.1: [a80e1fba874ca71f328094c8c5276e8be0f091cc]
stable/6.12: [fda9ca3cbee24f6e48c04946a8d2f66565d2d4b2]
stable/6.18: [d02a2ed057372d3739ab23d778fc4e04d3330513]
stable/6.6: [e87a2571054aad561d028fee9b85c000af022726]
stable/7.3: [f6b21af3e32f142bf3e591dbb10044c60472f716]

CVE-2026-99470: media: cx23885: unregister DVB bus when SP2 CI setup fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99470

Introduced by commit 2b0aac3 ("[media] cx23885: move CI/MAC
registration to a separate function") in v4.0-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22f552ff726a82a086be4ef02ce5099a0e8624b6]
stable/5.10: [3a6e950e07ba6be5102cc992f4f3acc536e0a58e]
stable/5.15: [c2605ecebba5199dbbc89701e151f3b5e89be9a0]
stable/6.1: [dd29be85fdff68f3e0252c5db0475930db55559d]
stable/6.12: [262bca0d6761f4fd8755e8e223ea666d6cb81f1b]
stable/6.18: [cbe537c64b8fb1d0cf4bee20f89204fa51e384e5]
stable/6.6: [fc9a91c2be3e0a28f106f0f583908340988772dc]
stable/7.3: [47b32af13359e1bf859a449daa7a1b389bd93cb9]

CVE-2026-99471: KVM: PPC: Book3S HV: Add SRCU protection for
virtual-mode HPT hcalls

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99471

Introduced by commit 6165d5d ("KVM: PPC: Book3S HV: add virtual mode
handlers for HPT hcalls and page faults") in v5.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61a39797bb136243c48b46e2586d8a9e2cea6a89]
stable/5.15: [fbfff331e73f44c25f4edd112eaef3b6865171c6]
stable/6.1: [294e306dc1c49f1124d0b82eef565778d975420b]
stable/6.12: [0f86aba67317d65b2dc89995dd5ddefe219411a7]
stable/6.18: [4ab2c987fd15a4bd28ef46a9ac871359886e6439]
stable/6.6: [0b456d70fff190abac02795ddb088618ff512a48]
stable/7.3: [c3d0261c4fae2cc36dcf9f4e247552498232caff]

CVE-2026-99472: KVM: pfncache: use a dedicated invalidation sequence
for cache refresh

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99472

Introduced by commit b9220d3 ("KVM: x86/xen: allow shared_info to be
mapped by fixed HVA") in v6.9-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da260bcb56feeb6489a83f310308453a0a7de25e]
stable/7.3: [fabc002f6396202b5ad7ad4ceec24d27aad90f3f]

CVE-2026-99473: KVM: guest_memfd: Gracefully handle xarray errors when
binding a memslot

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99473

Introduced by commit a7800aa ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl()
for guest-specific backing memory") in v6.8-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6ecb88711d93b9e014532f17d3d29b57e80932c]
stable/6.12: [2cfc1ccf67ffe96811c816d27d44128c5d5833ec]
stable/6.18: [1706461eb1af814366b6d0ab413edd0876bd8033]
stable/7.3: [2fa83c615f8dbb240b262265e788b120b6384e7b]

CVE-2026-99474: HID: hiddev: keep state alive through disconnect unlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99474

Introduced by commit 0790340 ("HID: hiddev cleanup -- handle all error
conditions properly") in v2.6.29-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [03f449b5de36a25fc5eba7dabf2b4494389bdb91]
stable/5.10: [56c3173c455a809f6b3413a5ee01bb500d093dd0]
stable/5.15: [99dede838f116bd1ea28c83b78725107e339af0c]
stable/6.1: [1ab3dba884b58ad4fc3afecba7d2346b527b006e]
stable/6.12: [81e3e5ae4228f95414665877f5e487917fbef9c0]
stable/6.18: [1b7b31f0d4bbfb9a87dd8acce1e001a3cf1c1623]
stable/6.6: [dc3245516b252d1ff682e3ef32320cf6009ab9a5]
stable/7.3: [f214e9fe86a0aba6deb4a0b31b9998fb2b6879b5]

CVE-2026-99475: genirq: Defer kfree(irqaction) until irq_thread_dtor() finishes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99475

Introduced by commit ed3e694 ("move exit_task_work() past exit_files()
et.al.") in v3.6-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d04adff6860587e843948b0c31174f8ae11b8dfe]
stable/5.10: [38d9f85a44e58e20ee2495d284bedae07ce32ee2]
stable/5.15: [c5c65a0a75362ff9d28f96c719e9f458c72f17c0]
stable/6.1: [ac1dfa127969307c432aa4eb2ae21b406d51be46]
stable/6.12: [ec397edc4c8ca868865953926831b539698469e6]
stable/6.18: [a6deaadd460a3a3cfd59c857247097e8da892af8]
stable/6.6: [b21cf04007f8e039170674a6815e4ac97bbab417]
stable/7.3: [08aaea3e62b2ddc69a65d52609a5924559d05af2]

CVE-2026-99476: fsverity: Set S_VERITY only after rollback is no longer possible

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99476

Introduced by commit f77f281 ("fsverity: use a hashtable to find the
fsverity_info") in v7.0-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c349b233d6ab0fc3517401a1e2d36f5f90eb8c9b]
stable/7.3: [10c13801ea38e4ced23c59052ce45acb07c5deda]

CVE-2026-99477: fs/proc/task_mmu: pin mm_users in do_pagemap_scan()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99477

Introduced by commit 52526ca ("fs/proc/task_mmu: implement IOCTL to
get and optionally clear info about PTEs") in v6.7-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4fb975471717c953f912776bb60301add1ffae11]
stable/6.12: [6e2299a9356de3364e193d6eaf123b90d7698c1d]
stable/6.18: [abc9c0f4f850d23e55f4230cd0f54938a64267bf]
stable/7.3: [14a853bf3e6f0dd62ff479a36613411237dec24c]

CVE-2026-99478: filelock: keep superblock active through delegation wait

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99478

Introduced by commit e12d203 ("vfs: allow mkdir to wait for delegation
break on parent") in v6.19-rc1.
Introduced by commit 4fa7631 ("vfs: allow rmdir to wait for delegation
break on parent") in v6.19-rc1.
Introduced by commit c826229 ("vfs: make vfs_create break delegations
on parent directory") in v6.19-rc1.
Introduced by commit e8960c1 ("vfs: make vfs_mknod break delegations
on parent directory") in v6.19-rc1.
Introduced by commit 92bf535 ("vfs: make vfs_symlink break delegations
on parent dir") in v6.19-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c206cdfee6c037b829178bb7e17e6e37ddc9aa35]
stable/7.3: [a6e222f1d75bce8de430ba4d0f8c6a1e923f9acd]

CVE-2026-99479: fbdev: atmel_lcdfb: Prevent FIFO work after removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99479

Introduced by commit d22579b ("atmel_lcdfb: FIFO underflow
management") in v2.6.27-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [20b3b97cf89cb381bf07516090d99399cc9b91fd]
stable/5.10: [403bc5965c002f3a7901d011db6750cfd83b9bf6]
stable/5.15: [e3fa1607c3d98b93f56e4ce03a9df035f4bf90ef]
stable/6.1: [b372a095e86cbd107151f18994ff7abd6193225f]
stable/6.12: [0c782a29f66eab8f2f9ce2b4325cfb5b9f01f8ff]
stable/6.18: [3b0be34d9d1e7add0c9b99b0b4b969ca56d81066]
stable/6.6: [ba161393a4e5f0f4487a1763e8d88da6d1c9cac6]
stable/7.3: [f099d5adad31609a6de64aea12a8609734570b00]

CVE-2026-99480: drm/panthor: Fix TOCTOU race between GROUP_REGISTERED
check and erase

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99480

Introduced by commit eec7e23 ("drm/panthor: Prevent potential UAF in
group creation") in v6.19-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [7764289d76a38c3a2f9b093bf17e193ab54acd70]
stable/6.12: [01806613d39191f530e72926960b20638e8cde93]
stable/6.18: [aa0be226ff227b051205d05dcfd6d38c0200e5ae]
stable/7.3: [4fa318e637dc83ed621073b058bcf404a2ff0845]

CVE-2026-99481: Bluetooth: hci_vhci: Pin module for debugfs file operations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99481

Introduced by commit 2801079 ("Bluetooth: vhci: Prevent use-after-free
by removing debugfs files early") in v6.17-rc5.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [645ee6b176c958579cff1c783413d5cff65c8197]
stable/6.12: [a82b3dec02bd42eedbc2733b092910f3b6bc4948]
stable/6.18: [d5cc1f1333d47593fcc71b73d1fade556c8ece76]
stable/6.6: [ede71f3136da3a0040c1407ce0a96a6802ce107a]
stable/7.3: [19502449eeeafbf48ad1626cc356d178d549fcc0]

CVE-2026-99482: ASoC: amd: ps: fix snd_acp63_remove() teardown ordering

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99482

According to the .vulnerable file, this bug was introduced by commit
5bbeca6 in v6.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c53791d673ed4da6759d276078627ec4d0c6536b]
stable/6.12: [be66694b2f818d7b14eb5022382b15df837459d8]
stable/6.18: [2ff55599528d7712c46956c038665a4d5a5160e5]
stable/7.3: [01ab732291bb05cc60952cbb365f4523b747ccfb]

CVE-2026-99483: ALSA: pcmtest: handle multiple wraps in random capture fill

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99483

Introduced by commit 315a3d5 ("ALSA: Implement the new Virtual PCM
Test Driver") in v6.5-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6541871e8e63e721733cd120af4d9cd22c5ef62f]
stable/6.12: [8f8555e03bb2596b0d521c5b95c72cbd76e7d9af]
stable/6.18: [5cb07a5941b1e3dbe655110618869a81af68907e]
stable/6.6: [31b98cff13e17c6060342dfee73b4aeb2e383b16]
stable/7.3: [76319a56f069bb950d9cebbc1a291cbfa94a1c1f]

CVE-2026-99484: ALSA: emux: Fix UAF of soundfont zones at note-on

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99484

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34e3e04b8a1731a773797542f0781e99ce7cd755]
stable/5.10: [18eb027b711e8fb7b5771e78cecfb0d6b6eb023c]
stable/5.15: [153547a5018726fa94e2fbe964fbf060006bac92]
stable/6.1: [df85c9211220c7139ef6772686b0b7654b8c6cc2]
stable/6.12: [102b2474f4b6809be934bbf2428b4ae4f3883e32]
stable/6.18: [af2b590be8feb62b5a0779dadd08e2ece5f370f2]
stable/6.6: [1f9da9df213fa13be38ad33b1a314767e43eed42]
stable/7.3: [fb5ae914176d7252c9bd6aee7ab94a64a41ebf3b]

CVE-2026-99485: accel/amdxdna: clear the mailbox channel pointer when
starting it fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99485

Introduced by commit d5b8b03 ("accel/amdxdna: Split mailbox channel
create function") in v7.0-rc3.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2117e3d96a4fd1ee13fa28b31494ff5f5db6ccf4]
stable/7.3: [35003a3a2221207ded92ca4c60a54c2f83136473]

CVE-2026-99486: rust: configfs: fix data offset calculation for
subsystem callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99486

Introduced by commit 446cafc ("rust: configfs: introduce rust support
for configfs") in v6.16-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e84c9b64df615e658e47561b835c1364dc48f0c0]
stable/6.18: [dc1744584b2b9cd8a04e1b824f72bfec0e3c3374]
stable/7.3: [b91e8d8c2ed97b49a2fd6c2c9516586a8f2aa3c0]

CVE-2026-99487: rust: bug: pass TAINT_WARN to warn_slowpath_fmt() on UML

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99487

Introduced by commit dff64b0 ("rust: Add warn_on macro") in v6.17-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [951d09ca450ca76a695016ea76c3fa653bd20439]
stable/6.18: [8a16e766cf58c26d5aa5e41cc88e649e9cd97157]
stable/7.3: [e05c740e7536fbd5dd85b437eea50f39e45fc87d]

CVE-2026-99488: klist: avoid accesses after waking klist_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99488

Introduced by commit 8b0c250 ("[PATCH] add klist_node_attached() to
determine if a node is on a list or not.") in v2.6.13-rc1.
Introduced by commit 210272a ("driver core: Remove completion from
struct klist_node") in v2.6.29-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [732e3e10234cbe302d0dcbaa98c91c66628209cb]
stable/5.10: [224f1c87086b9bc15bfc2dc0fd6f23df265eb976]
stable/5.15: [2c3bbc8a1acd7b52a7785b51994a39aa336e2c08]
stable/6.1: [428846fffb806a2c1e7f5f9bb976964f011c8803]
stable/6.12: [3fee2a5ef405f08ea3d87d2014ae7d38e61dd06f]
stable/6.18: [d655ef174056457d1c3bc06b4405097e0a9b3bf5]
stable/6.6: [1da13ac31040f1fb7365e994f84a6b2e32043363]
stable/7.3: [7d3df012573523cb2f38a65e3e00125d9869b390]

CVE-2026-99489: HID: wacom: Redesign shared sibling data lifecycle

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99489

Introduced by commit 4492eff ("Input: wacom - share pen info with
touch of the same ID") in v2.6.35-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [480c9cb14ae81f8e112ff83f8778b3d7b9324dc8]
stable/5.10: [27b12280feb489d5d69e5aab438f040f2309f4c7]
stable/5.15: [4e7a9a00d3912e4cd3fc5c999c06343e96884a99]
stable/6.1: [904a80e13e5579492b6a180ca00be84491941bbe]
stable/6.12: [4eeb0a16f11c72a0a15e793310470418d1c2d3cd]
stable/6.18: [321da540c4a2091c0e23b5f4ced0131a1c77d679]
stable/6.6: [8567f0560af6089af356b586df92c3f1d963628c]
stable/7.3: [f1fb9f9087c76bca6de81aa38e1e9c820dc54744]

CVE-2026-99490: HID: wacom: Fix Use-After-Free in wacom_bamboo_pad

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99490

Introduced by commit 8c97a76 ("HID: wacom: add full support of the
Wacom Bamboo PAD") in v4.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a523ecf9ac3fdd33f5eb31c43937ee44135395b]
stable/5.10: [b5c7d12527ba739721e0902b64ff05c568041c24]
stable/5.15: [48ecba8b326732cb24f698bd85285ac46471013c]
stable/6.1: [21a1e897b98653f0d2d5dc41cadbf3e6a588e1b9]
stable/6.12: [6704d7e9ca8aa1ec66d97fe1b2bc89e07ad710c7]
stable/6.18: [ac81120321a90b052cc50ecc9e38753c9471c75e]
stable/6.6: [b893d6b0a8dd71c5f0644f82c15dae8ed732a050]
stable/7.3: [8e56f274d61a21e7aa0bf4000f839f34dd721fe5]

CVE-2026-99491: HID: wacom: Fix Use-After-Free in wacom_intuos_pad

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99491

Introduced by commit 961794a ("Input: wacom - add reporting of
SW_MUTE_DEVICE events") in v3.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef32877368a7013c060ef6bd03a30b6da2fe0c41]
stable/5.10: [ddf09302779e6add98c1f2fb4b01ae8e75964cda]
stable/5.15: [d1dabfbcbc6993baec60925bf4d02d0cd597e479]
stable/6.1: [e106375d2e34c338a05e1b0a99c281b038fea996]
stable/6.12: [1178927ffa54a1f9e52fa4e5974862023237fce6]
stable/6.18: [ef74a8a685e272dbe0d21844c6e70841ccc9b1bc]
stable/6.6: [d7fba097f368001ea094ce8f3470708a901f31e0]
stable/7.3: [4e1bf2f5fe28cb8719aee7ca9d99ea529224ed1f]

CVE-2026-99492: HID: wacom: Advertise SW_MUTE_DEVICE capability prior
to registration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99492

Introduced by commit d2ec58a ("HID: wacom: generic: support generic
touch switch") in v4.11-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba16e5ffbaa10fde960918d69af5e49f2b3fdd5e]
stable/5.10: [06e705c79a5e88b71044a778cb361e1a475a0bf1]
stable/5.15: [0428166e57234e08e79134942010f4dc550131d7]
stable/6.1: [16d8717209b0991fa71c0ee75b03294382df57ce]
stable/6.12: [64a4b7b20f864687dc3da88bd2acfccdf8056ce6]
stable/6.18: [1df501b62a2fa6bc24c74a8eefba61ffc1cf6bea]
stable/6.6: [560dbe955f2f591fe3fbfd0aec8e01ac1e338e74]
stable/7.3: [9970418ce814d13396778694a5170073449dcd34]

CVE-2026-99493: s390/zcrypt: Guard domain index uses against speculative bypass

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99493

Introduced by commit e935cd5 ("s390/zcrypt: Close speculative mem read
possibility") in v7.2-rc6.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [7b88e8b6d714cd1b2b6185e2963c8ec4d98542d0]
stable/7.3: [47597992e6c20a298cec03016ebba669f0e17484]

CVE-2026-99494: s390/zcrypt: Fix out-of-bounds ptr advance in
cca_query_crypto_facility()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99494

Introduced by commit 2004b57 ("s390/zcrypt: code cleanup") in v5.19-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9fd7fca66735307fd7afa3450882a55ef80f2add]
stable/6.1: [46c743cad286fd4a2f084f1bab50495b59ac3b50]
stable/6.12: [49dfd61f1c2ddfe028d4a9a603afc33b013e9ee9]
stable/6.18: [bd30e2b60e811140861d53030cf9b6226b46c032]
stable/6.6: [2e98b8e0d2f0ee86357a31d0e836ea72685f6d1e]
stable/7.3: [21268907891d5496e495ca17511aff11d8f99731]

CVE-2026-99495: s390/zcrypt: Fix and improve zcrypt reply message
verification checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99495

Introduced by commit 5e55a48 ("s390/zcrypt: Separate msgtype
implementation from card modules.") in v3.7-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e9b339f323216d71f3ede8a0a427abf7859c486]
stable/7.3: [0f0aa2b560a6eca76778083b0c6f155bb458b56f]

CVE-2026-99496: s390/vmcp: Initialize full session info to zero

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99496

According to the .vulnerable file, this bug was introduced by commit
6b979de in v2.6.13-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f63eb4ee4a30fc5d8de07a229d92310e3c8d560c]
stable/5.10: [da67881f5b2cd072616f9e5049a33827b7150f63]
stable/5.15: [ddf4e41f95f71978c43fa78541da867ca68e5e1f]
stable/6.1: [bba87142de33a82ad55ecab64038831634a35914]
stable/6.12: [35254c6be12fb439be34a67dcba120bcb4542b3f]
stable/6.18: [041c5072258525fd54a15247e6a59446a34a5a76]
stable/6.6: [f9def674193e782936de0aabe2314faf02edaf3a]
stable/7.3: [1653ab681d830fcc20d69334f36808765b4de3fd]

CVE-2026-99497: s390/probes: Fix wrong opcode for cgrb fixup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99497

Introduced by commit 6b169ac ("s390/kprobes: add support for compare
and branch instructions") in v3.12-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7ccab11a13475e656b9d2277900422c1bfc12c5]
stable/5.10: [cf0942ba38c2db5d2bc3aa7a9a8a47ca281de87c]
stable/5.15: [96a2aa7578fc2cfc48088c36ad61254dcde7adbb]
stable/6.1: [9747ef0445284ad2097c6b75671f90d07267c5f0]
stable/6.12: [e0682a8fb9c27dffc461a8a4e76b54a65f7391e9]
stable/6.18: [0917637564e953daa79dd4f44fd86637816d2fc1]
stable/6.6: [ce0a82ddab88d868967159b58bea90f51b12b26e]
stable/7.3: [e3d89fe35617477806a65d0f5769efb237dfb6ef]

CVE-2026-99498: s390/kprobes: Prevent kprobes on instructions with
exception table entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99498

Introduced by commit c488f51 ("s390/uaccess: Shorten
raw_copy_from_user() / raw_copy_to_user() inline assemblies") in
v6.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc9bb0ecd310b53af5116415952a1fb89d4660b9]
stable/6.18: [3a4da934737159d2ec5341fb8c8a5c9a0c6efee2]
stable/7.3: [641040939ef86fd149e90f3cd4025607afcf160d]

CVE-2026-99499: s390/pci: Fix use-after-free race in zpci floating
interrupt cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99499

Introduced by commit f770950 ("s390/pci: Migrate s390 IRQ logic to IRQ
domain API") in v6.19-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [422d75ad5bc96b8eb9cb3cfd9d68fc685a0a9b75]
stable/7.3: [da15d34d6cb9cdca309c59d1ae0f155da31ed2c2]

CVE-2026-99500: s390/pci: Fix resource leak in zpci MSI setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99500

Introduced by commit f770950 ("s390/pci: Migrate s390 IRQ logic to IRQ
domain API") in v6.19-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a185d99179a307d856dc43610cfe72395d0c42a]
stable/7.3: [5c1096d6d24aa595decdb229542cf772a7a9e21e]

CVE-2026-99501: s390/pci: Fix MSI directed-mode teardown IRQ bit count

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99501

Introduced by commit f770950 ("s390/pci: Migrate s390 IRQ logic to IRQ
domain API") in v6.19-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1844913582fec337c54b54fdd3c92ce225930515]
stable/7.3: [b4d2ce74ee1270abd89c39bdf26116902549b46c]

CVE-2026-99502: s390/pci: Fix double-free and NULL deref in zpci MSI
domain cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99502

Introduced by commit f770950 ("s390/pci: Migrate s390 IRQ logic to IRQ
domain API") in v6.19-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31c66bd273303590fe69fad370e72a12faa0bf76]
stable/7.3: [5259b258f234cca127651cd983ea879a7ad4ea8c]

CVE-2026-99503: ata: sata_fsl: Fix use-after-free of host_priv on
probe() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99503

Introduced by commit 6c8ad7e ("sata_fsl: fix UAF in sata_fsl_port_stop
when rmmod sata_fsl") in v5.16-rc4.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [70b1196740d61aabda13b2ad0e9c1dfa2ef9cfa3]
stable/5.10: [1d90d6d679cefe20d223c2f196ffd9fea297be1f]
stable/5.15: [4ef0a14d952dd4475e2016475b1dda73f63c5dae]
stable/6.1: [6c69c0754f9052a9369c154530ca4855f9bcdca9]
stable/6.12: [3e00737e95485b2a35bf5f515f56a4c416d5971f]
stable/6.18: [59eac6863eede5957bfd8872633608431ac42d3c]
stable/6.6: [57f0d1fcfd1eb4c05f8edb883ed34914a77a02d5]
stable/7.3: [9d9d62dfef3609f664c60f6fe61528a2e876a64b]

CVE-2026-99504: ASoC: audio-graph-card2: Fix use-after-free in
audio_graph2_link_c2c()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99504

Introduced by commit 5f281c3 ("ASoC: audio-graph-card2: use
__free(device_node) for device node") in v6.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ea495bccfd746b063bc6702064f167467717b41]
stable/6.18: [fd0dd0ee82ef62b8b4bda1ffceb361946f403404]
stable/7.3: [85db2c35fd93bc6604e4d7abe4701d6587bc15a3]

CVE-2026-99505: apparmor: fix a use-after-free in aa_lookupn_ns()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99505

Introduced by commit 3664268 ("apparmor: add namespace lookup fns()")
in v4.13-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f292873ceb4bd3a1a0f75f884361cd556e457692]
stable/5.10: [87124024b0a7c46e04f5588808fd2c0e95ce567a]
stable/5.15: [df8685e4f9da816927395c456a62c1043ecdd99a]
stable/6.1: [ba45d73f8782e3e9d521ec2bd4c4b4b4dc548f2b]
stable/6.12: [2588c5693f4535e856841976cb1e1532bae77109]
stable/6.18: [174b4b90ec6731934cf84eb267a86ad7152267fa]
stable/6.6: [1f09cc23d1cdf440ff03d4a0cf3ed8100134d9d3]
stable/7.3: [8db1a8614b4f8f3da11c568e2b5af4fe56eef360]

CVE-2026-99506: mm/hugetlb: fix use-after-free of a new anon folio

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99506

Introduced by commit 3a47c54 ("hugetlbfs: revert use i_mmap_rwsem for
more pmd sharing synchronization") in v6.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [824cc56bf43c714319992bad3558803cac6e77c0]
stable/6.12: [727dfb28c6a2334f08cdaef82540137c9b094ab7]
stable/6.18: [1108d9a51c91bb459fa62506fd0176dc9e0927c5]
stable/6.6: [50d813d4fb702a502a34eb5ddd3f94eb2eee96c4]
stable/7.3: [51b21515bdac0a60efac142dbfa44481e4206f28]

CVE-2026-99507: mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99507

Introduced by commit cb6acd0 ("hugetlbfs: fix races and page leaks
during migration") in v5.0.
Introduced by commit 1c9e8de ("userfaultfd: hugetlbfs: add UFFDIO_COPY
support for shared mappings") in v4.11-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [d8a9cd7fd2fb01211430c933932da58839b8ca65]
stable/5.10: [3e0da2f9f19e28d6bc1afc5090a089c125db5d73]
stable/5.15: [b4669d77bf9cab09a96dcacda4b20ffe727bc9f6]
stable/6.1: [dc9426dfa7fdaf9b00f5c5342f95e708b3567b31]
stable/6.12: [cda6c4819b4a45dbeac92652eaaffb156b3f11b1]
stable/6.18: [8b87fd23be5a816ad572e23eb4e1e2bea027db6c]
stable/6.6: [fd16432642b3e206a73e95ccd043dc686844fc0f]
stable/7.3: [83798e46a01c3139273cddcc634e96dfee980c42]

CVE-2026-99508: media: ipu-bridge: Fix use-after-free in IVSC error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99508

Introduced by commit c66821f ("media: pci: intel: Add IVSC support for
IPU bridge driver") in v6.6-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d42d1c82717f0853379b516a7fab54b636e09cc]
stable/6.12: [2af4892580167181c3181b2f0b6ffab1be0096c9]
stable/6.18: [d1df2ec20a6ddac6ae553b34b39472a20c5de9c6]
stable/6.6: [92c84f225836f26375b769f23f7dfdb31bb677d6]
stable/7.3: [adf422b7587bff1c9069406ce7a6c5a1f0e70193]

CVE-2026-99509: media: imon: fix use-after-free in display_close via dev_dbg

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99509

Introduced by commit 21677cf ("V4L/DVB: ir-core: add imon driver") in
v2.6.35-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [118a3590a4080c71c565265b05b3f92e814d7647]
stable/5.10: [4ffdd654d17d122478ea55a26021826cbc2ae1d6]
stable/5.15: [ae80707ed44f31a61ea5d7af8c2cd81385227065]
stable/6.1: [041e6e8db5ae45e6dd6da5932a96496a7dc7fa12]
stable/6.12: [883eee3a9e66add5dc93455dfca5b0ba5294c2d4]
stable/6.18: [c33165bb785cb0b496a196a5ca50b9d725bb7f82]
stable/6.6: [5f86ad5e7412190c2f799362962bc028ab6ef06b]
stable/7.3: [a7962198ab367f732a8ced1682f2738d712ad473]

CVE-2026-99510: media: hackrf: fix use-after-free in
hackrf_alloc_urbs() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99510

Introduced by commit 969ec1f ("[media] hackrf: HackRF SDR driver") in v3.18-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6802ad4b6b267dda02209b5811edac7825c8a5f6]
stable/5.10: [8019a26c425f9434d879ce291b7e004cbda77410]
stable/5.15: [33ad76cb192cfff66a36d034d06b2ac7fab1cc22]
stable/6.1: [9166409615dc009bdb118dc205a89c81bf598308]
stable/6.12: [ed8d9b2015afd540f6159ed272702a87f02fbd05]
stable/6.18: [e9deece85062873763dfbb8b1121e722ef2959a0]
stable/6.6: [caf376902c1f19783345e8bfec147bfdeac15bd5]
stable/7.3: [ba097d24c56bc3c57a1173506c3c5a42d0f94988]

CVE-2026-99511: media: cx23885: Fix use-after-free in cx23885_finidev
due to race condition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99511

Introduced by commit e5514f1 ("V4L/DVB: cx23885: Move AV Core irq
handling to a work handler") in v2.6.36-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75016a992d9b03f5cc6df1414d1da35840d4feeb]
stable/5.10: [bdcd99f5d47bdc0104cc816dd1885121321803a8]
stable/5.15: [094e57f65751c99b5e7a88b9d6f199b3c11ef134]
stable/6.1: [58dba8af3a48e5c9799941194fcb022192e6702d]
stable/6.12: [4c28161c8893bf7a396bda1ba9d8fa6e528c1a21]
stable/6.18: [2344922abe2ad811003794092931bf454b556109]
stable/6.6: [a791e659029244c94d16bb662884cab832231e62]
stable/7.3: [544b575ba44d566cfd4f82e3d8faee5db01addf5]

CVE-2026-99512: media: au0828: fix use-after-free in bulk_timeout
timer on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99512

Introduced by commit 53460c5 ("[media] au0828: Add timer to restart TS
stream if no data arrives on bulk endpoint") in v4.13-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [521030837bee352515d5ea57cc6a29581db3506e]
stable/5.15: [f6828fdabb07a9738419792273886d5b7d096757]
stable/6.1: [ca99be2c3c5e8794444fd4a5ce324c7672b0aa68]
stable/6.12: [0cfc8c1884451c4c3839dfeb1e0e2b008bc00efc]
stable/6.18: [95a1f45a82e51ff23bd82c0529bfd817c8ec437f]
stable/6.6: [cb104ec7111aec9f9c19775422d70f917b39e947]
stable/7.3: [5e30e92df3a0fb3985f3686536065219c28dd65d]

CVE-2026-99513: lockd: Fix use-after-free in nlmsvc_retry_blocked

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99513

Introduced by commit 0e4ac9d ("lockd: handle fl_grant callbacks") in
v2.6.22-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5b7634f0f213299a07b461fb10385c8639a4ab8]
stable/5.10: [12515c7c98ed26de43276d2f05e3bbf987a957a4]
stable/5.15: [aa5cb74fdbb5accd0d5e96eea9116b277057eb24]
stable/6.1: [ae650b72f49cf07b22dcfb538f1362ed1cfa7200]
stable/6.12: [6506c27da6756c0c7590ef60774ee5d35f6a4100]
stable/6.18: [70825b251e5f7855fd7bd93afc0b698154e00e70]
stable/6.6: [25d464587df6b0b0f3f34dfbd4b4770a0ef674eb]
stable/7.3: [25d0baa6adb4a0b3f6889d42033ce8df3232bea7]

CVE-2026-99514: landlock: Fix superblock use-after-free in release_inode()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99514

Introduced by commit cb2c7d1 ("landlock: Support filesystem
access-control") in v5.13-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e271a27c46fd591d1011c7de5a644a41e2010f1]
stable/5.15: [f8e921fb6367c2b6b64f39943300727f67952362]
stable/6.1: [f882b70e659178d9d47d5e191061934660748c82]
stable/6.12: [1824d884e5076e3fdd83f44256746f2f95d062ec]
stable/6.18: [2b61008c9f884ead174a67f1cc70342a9efee3e4]
stable/6.6: [63bcfd04210960743fc7286796e3c42e731f6707]
stable/7.3: [f79a0195db1f2568fd82999fd814af071b2dbca7]

CVE-2026-99515: iommufd: Fix event queue release use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99515

Introduced by commit 07838f7 ("iommufd: Add iommufd fault object") in v6.11-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [440ca8a4b69f40088065b9e05ef11373292a254e]
stable/6.12: [e4ed15ae7111ef97c92092998b8fcdbfb25f4fdf]
stable/6.18: [439c23b897c8787f2d0c292ba9c1a2ee75595c0d]
stable/7.3: [3e0bb6b07a95f730a36f65d959708606ca0d78ce]

CVE-2026-99516: nvmet-fc: fix use-after-free in nvmet_fc_ls_create_connection()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99516

Introduced by commit c534320 ("nvme-fabrics: Add target support for FC
transport") in v4.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c29f8c9b9e598c09fa50aa02200136a107f6b3f]
stable/5.10: [3bc95d8fd1f503b832d778c0c23da6108897167e]
stable/5.15: [0cd9f4beec82be7a9a4b2797e0f12ea2f0a54082]
stable/6.1: [71a9218bcea2e70e44a12655568d14369725ef65]
stable/6.12: [74e01caeea4c16298f28bfb7ea87b0c9835e1777]
stable/6.18: [6324f087caf817f00840baa82664dec3c5634f1c]
stable/6.6: [c2125253a246568e47d31a6c1e9c0035a008b402]
stable/7.3: [5ee2e99021c5ec3e89aa6dc2fc1ad5ed46446523]

CVE-2026-99517: nvmet: fix use-after-free of the old registrant in
nvmet_pr_preempt()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99517

Introduced by commit 5a47c20 ("nvmet: support reservation feature") in
v6.13-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f316aa7f018840523939183425394931b373e4d7]
stable/6.18: [506c066da8fb2cef32210ca84439c7bb9855504f]
stable/7.3: [fd7843365a9e73f6ee32c30487c21cb62b84c0a2]

CVE-2026-99518: platform/x86: asus-wmi: fix use-after-free
unregistering kbd_led led

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99518

Introduced by commit fac55d2 ("platform/x86: asus-wmi: Add support for
multiple kbd led handlers") in v7.0-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [639bc2254816b7c4e7a9801a7b3aa71bfa3f915c]
stable/7.3: [465f3074762ad943370881d7b6f096e70d9a5a5a]

CVE-2026-99519: PM: EM: Fix use-after-free of perf domain in netlink
doit handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99519

Introduced by commit 380ff27 ("PM: EM: Add dump to get-perf-domains in
the EM YNL spec") in v6.19-rc6.
Introduced by commit f2d2946 ("PM: EM: Implement
em_nl_get_pd_table_doit()") in v6.19-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f58dacfbadb7be7c7dbb2b95e9341ad56710849e]
stable/7.3: [a3b57ce3e95d338a9a24eb760171aa16f742f008]

CVE-2026-99520: pps: generators: fix use-after-free when closing a
removed device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99520

Introduced by commit 86b525b ("drivers pps: add PPS generators
support") in v6.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d19552611cb2eb6329826871565e5309bec2f288]
stable/6.18: [63dc56500a91591ad9b42e09ca4646b0a4d03406]
stable/7.3: [3c94478114384d97795029160ceb539ade38cc43]

CVE-2026-99521: rapidio: mport_cdev: fix use-after-free in mport_mm_close()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99521

Introduced by commit e8de370 ("rapidio: add mport char device driver")
in v4.6-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f2cd84858e67cf8e02438bf28243bcdc67aa49a]
stable/5.10: [4fd7df6e7040fad99fee8989783748afefcee6ce]
stable/5.15: [1c66d8e8fc67f2471675e361b16200d419e40ef3]
stable/6.1: [40f37f710ef220286600bae75456977f3629629f]
stable/6.12: [df3008607f2c3343f7ad34001af656a185c123ee]
stable/6.18: [48157350b24ac0343374ee3fa34188d7ff30be81]
stable/6.6: [3dc409ad1865d68f884611f7503c409071499067]
stable/7.3: [a0aaf59e7a86312c0272e36f19fb507f91405209]

CVE-2026-99522: RDMA/irdma: avoid use-after-free in icrdma_remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99522

Introduced by commit 8498a30 ("RDMA/irdma: Register auxiliary driver
and implement private channel OPs") in v5.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a8088b899e4cdfe558428cd6113d45df81625be]
stable/6.18: [e5388f15d595dd4d7599a43e9cb58c0656a6aec6]
stable/7.3: [47eb0ec18f7bbd40cf1f1d261f15ef3c03e4c8d6]

CVE-2026-99523: RDMA/uverbs: Fix DMABUF use-after-free during ufile cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99523

Introduced by commit 0ac6f40 ("RDMA/uverbs: Add DMABUF object type and
operations") in v7.0-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2854f9025d4ef6c4566f71e52d7f496d9a0f5737]
stable/7.3: [0b6d8b41af154b1137efb578afb8c8fc39d136aa]

CVE-2026-99524: sched_ext: Fix use-after-free of a local reenq node
left on an inactive cpu

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99524

Introduced by commit 238eba8 ("sched_ext: Use
schedule_deferred_locked() in schedule_dsq_reenq()") in v7.1-rc1.
Introduced by commit 76edc27 ("sched_ext: Use irq_work_queue_on() in
schedule_deferred()") in v7.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43e1ef14a47257ebf7e3bb3ab9a6df9c6f817c5f]
stable/7.3: [0b5282963734a51b6dad978ccfe0fa22c4d4fb17]

CVE-2026-99525: smb: client: fix use-after-free in cifs_ses_add_channel()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99525

Introduced by commit ee1d217 ("cifs: handle when server stops
supporting multichannel") in v6.7-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [031278577380e7875d95aed81a2b2bcac39be923]
stable/6.1: [093a42a31ae8bb26da7f4a358f83300d76d0c46b]
stable/6.12: [d88e3e844fad0f6b9fbeb8c8862f9272a7c26a99]
stable/6.18: [8069935474b1502459ab50f75a67d7394a93cd5d]
stable/6.6: [4bc20a4ccdbdbe14e8628073109c52a22d7512d1]
stable/7.3: [72367dacb5c9d8bd486b2fcaf56b6d3086d57250]

CVE-2026-99526: smb: client: fix use-after-free infoleak via the
readdir resume name

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99526

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Introduced by commit b77d753 ("[CIFS] Check that last search entry
resume key is valid") in v2.6.28-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59131dd72f62b198fc9ea1489ad9d3573154f684]
stable/5.10: [6386f2f406ccebfb66997b288a694e35e61d2d54]
stable/5.15: [44deaa4a4cbd8c9e4cd0c577ac78090c3372428e]
stable/6.1: [d065da30398162e477d427c7b3cb83589f043614]
stable/6.12: [8c8f8029fe07634b626e96472b584b29a33993b8]
stable/6.18: [6c4c12b0fadcb71e4e6616e6c1ca529c772f2a15]
stable/6.6: [24e83a84521e2812a31eba38ee7c1285af2b3ab1]
stable/7.3: [a3481ed0aea2fc41a6d892a586b6eb7a97662034]

CVE-2026-99527: spmi: Fix potential use-after-free by grabbing of_node reference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99527

Introduced by commit bc32bbd ("spmi: Set fwnode for spmi devices") in v6.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7aa9de4f2b197cdd704cdc476901b68ee128433]
stable/6.18: [b5e5d035abd1b49ecc9c85320fd6dfcc57ef9c79]
stable/7.3: [5653608781a660485d5e9be48a1d06025c4b97cf]

CVE-2026-99528: SUNRPC: fix netns use-after-free in write_gssp()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99528

Introduced by commit 030d794 ("SUNRPC: Use gssproxy upcall for server
RPCGSS authentication.") in v3.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e7a8721b7edb54a157623f9e31d71345333b5fb9]
stable/5.10: [f7f78a8f19c86ed9fcdf60b245bf4b96c93543db]
stable/5.15: [49e2bc27ff9f6cd3843828a9f469a2e1af69a0cb]
stable/6.1: [ff077f38c886616e4fc8e888f1212b9121bda81a]
stable/6.12: [0a908446c5edc42905f9136e91bbf4e45d0747b6]
stable/6.18: [3c3b401650227e147c609c33fa458d5d963f2918]
stable/6.6: [c538969194c2a47132fe1f96ba40f85e159d4f38]
stable/7.3: [75120454474be7bc62b77af12bd591a339be27e1]

CVE-2026-99529: wifi: b43: fix use-after-free in b43_bcma_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99529

Introduced by commit 96838d6 ("b43: Fix memory leaks in
b43_bus_dev_ssb_init and b43_bus_dev_bcma_init") in v4.7-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c6c8bc355657115664131b38c53c5ddf7d93b072]
stable/5.10: [32804bfb455df8381b9782a82e4a206ae48867f3]
stable/5.15: [c3eea1e3a2a4d4943aa5a38a8ec7760fa0fd3cb5]
stable/6.1: [dba6f8fce71880d23d6628525b3aab39fe95e59f]
stable/6.12: [9389b2a21223032ab7d873806d283cc33bc34b01]
stable/6.18: [ac7558126767d26198c94d21cdfe8a920ccccb79]
stable/6.6: [0ec8b5f0bc22d39b848c2923e7f219e3ecdaff33]
stable/7.3: [f6a3ccfc8d6f6d0fb8a20bfb49ede223f151b8e8]

CVE-2026-99530: cgroup: serialize migrations of newly forked processes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99530

Introduced by commit 0568f89 ("cgroup: replace global percpu_rwsem
with per threadgroup resem when writing to cgroup.procs") in
v6.18-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf6fbf46b5ff68c4eebad5aa52309eb124f4509c]
stable/6.18: [d3d5560fb7550e74fb9851826d7dab505ffd05e0]
stable/7.3: [13610241843ccd928d83c6d51b5e044e4faf56c8]

CVE-2026-99531: ksmbd: verify transform SessionId matches the decrypted header

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99531

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [798214e6fafcdcc29f5ba2661a473232b5e70cfb]
stable/5.15: [aff28f0f92ab3f9809ccab5075724ab54809378f]
stable/6.1: [1ab4528483a8307787ad66457045ebfb7c652d16]
stable/6.12: [b150049dffd0865fb6e60ce843299216687f02ad]
stable/6.18: [7f30b886c5a1a2b3d9342ea82d0699eff812a472]
stable/6.6: [62af7b1179fb0155ecda158b6e02e145d1abdc99]
stable/7.3: [8c5f62dd9a0b61e0082d419796e0743e820bd002]

CVE-2026-99532: ksmbd: validate security descriptor offsets before
pointer arithmetic

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99532

Introduced by commit 0626e66 ("cifsd: add server handler for central
processing and tranport layers") in v5.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3474e1a304fbf9f7c996b24adcd519e031227a90]
stable/5.15: [6d9bd792f0aedef467fe76430a2c5b8d19de5a0d]
stable/6.1: [a20f213f0bac5b911268ec2c3b932ee85e05c87d]
stable/6.12: [f2eca58cf5de3554f7083c0ae5f78a93e2fe88c3]
stable/6.18: [e8aa0ac634f0d30a5df8106791ba67b17f71e2ae]
stable/6.6: [1e1bf8ea2768f8b32fc280308a96f1dcbd5cf24c]
stable/7.3: [e14b640498c4c5dae35ee1c605a76527f01fdc8b]

CVE-2026-99533: ksmbd: validate AppInstanceId takeover target

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99533

Introduced by commit 16c3064 ("ksmbd: handle durable v2 app instance
id") in v7.2-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0386cd6498b9c63f8c6d10b3e08670b92c0f3f1]
stable/7.3: [896ecf714703f6801af43b6d3db4b824d8a12286]

CVE-2026-99534: ksmbd: prevent stale data from being written by SMB2
WRITE requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99534

Introduced by commit 443d61d ("ksmbd: allocate one more byte for
implied bcc[0]") in v6.4-rc3.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [bc0e0f5ac1d7b044d403f859406b4b66d4b1ce9b]
stable/5.15: [6a64849ea35b5eb247e8bbb60bb03d1a181223c3]
stable/6.1: [344cc4368b1e29620a004dd36738537f464ef426]
stable/6.12: [139e8a3d6edd0c5b5dfe4ada2f636146e1209dc3]
stable/6.18: [fbe9fcda7ae8835b454c376de1d49232ab6bbcfb]
stable/6.6: [0f05dc524e8154f4aead793d4b3f58af3d32c66e]
stable/7.3: [97d489f68b85a5b64496e01d4cb3c0e092aa817e]

CVE-2026-99535: ksmbd: prevent share root removal through empty paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99535

Introduced by commit 74d7970 ("ksmbd: fix racy issue from using
->d_parent and ->d_name") in v6.4-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [9fd1fcbbf84986a7bcf601a2b90540899069d263]
stable/5.15: [c718c89d0a36275580fd478bc86c23f2d1e6034a]
stable/6.1: [a87ef12487a1cc6232076d709e0470f5f309fc60]
stable/6.12: [007eaa56b06fd05c55b86afabab3354ff7c24653]
stable/6.18: [2756a41a82d618bf1d8b41d74108311815cb695c]
stable/6.6: [c73044f67fc01705eb9eb921da55a51f03f83566]
stable/7.3: [1f8945d2eb20a135b4e22e6fe2348a0191be208a]

CVE-2026-99536: ksmbd: prevent session binding in compound requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99536

Introduced by commit 4b70636 ("ksmbd: fix multichannel binding and
enforce channel limit") in v7.2-rc3.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19f8fd6b5ced33b02a083759e6901f9d6e8076df]
stable/7.3: [4f148586c9cb18ad47b5f41153139d0fefa596d3]

CVE-2026-99537: ksmbd: preserve unreadable named streams on open

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99537

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [80c816c047f7cae3c99cc75740c1f5d2c4d97b45]
stable/5.15: [de47a7e952b9e09b3e814a740481bd2f9dbb8e30]
stable/6.1: [163f8b0c72fa0e398bfdd88545d32a4f4a80d72b]
stable/6.12: [f5f6a705247314540b780dbf94c319d764b84bb4]
stable/6.18: [22464634d240f5132b0787048a10e8260ac7e639]
stable/6.6: [6a42992b9c74d9c8ef96dba6f7137adcfb64a5cc]
stable/7.3: [4cdee894f9bcebe0093df90cf28dc732d38418da]

CVE-2026-99538: ksmbd: ignore network devices of other namespaces

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99538

Introduced by commit 0626e66 ("cifsd: add server handler for central
processing and tranport layers") in v5.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f5ce2b8b9164b3fcb93a18fe1e7b451c2fc6eea]
stable/5.15: [a842094b4a3ac6116ccd002b1c73768051de9835]
stable/6.1: [f909dfc54facd84906e0293047618aa18ae5b938]
stable/6.12: [cd27b2436d7fd04aaa8166ff3ce0da74cb12fe49]
stable/6.18: [9582dc3a31784ac930293b15edaa36c897d74e27]
stable/6.6: [86798325d2c4594565c2a9349173a69d08056540]
stable/7.3: [ddbcb0fe1b4ae5fd2c85fba5be61af1a554fce3b]

CVE-2026-99539: ksmbd: fix session reference leak on compounded SESSION_SETUP

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99539

Introduced by commit 7aa8804 ("ksmbd: fix user-after-free from session
log off") in v6.12-rc4.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [03bd8f5279e490e15e0c0f0fa388ffbd2fbacd65]
stable/5.15: [a259b8f25de7b50d43fb94b29489d98848bba580]
stable/6.1: [964c39f41c837fc2de221dcb860ff6451e17deae]
stable/6.12: [b2d710b12e86fd4cf02be090651fa6ea8683fc29]
stable/6.18: [38cddb9f7c9102f23652d198748c658072cf0df5]
stable/6.6: [84deaeff31f4bdf5fee5c8dd1e3a4a49c3ffc05d]
stable/7.3: [db30f8f330fc73304edfe595dc5a6f5e17ba97f2]

CVE-2026-99540: ksmbd: fix parent dentry lifetime in directory enumeration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99540

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [171df27077fb49b4af2c53ad2cedcd0e39664fe8]
stable/6.1: [cdc9a843b4688fa2729ddaf3e575dadd243aacc1]
stable/6.12: [32934b13b1a63c86d2fa68df0bfb28c51ce38879]
stable/6.18: [93566781118cdff874023d5ca4e7b8054baaec31]
stable/6.6: [e8af427da35cf10c9d26b96d91b6849dd01e125c]
stable/7.3: [b62ef8cfec9351662e42cbf7da2d743068699bba]

CVE-2026-99541: ksmbd: fix OOB read and cross-share confusion in
ksmbd_validate_name_reconnect()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99541

Introduced by commit c8efcc7 ("ksmbd: add support for durable handles
v1/v2") in v6.9-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [783a7fc454991544bf92268d8f2413af1a7c7eb8]
stable/6.12: [0129f7196a05a974bfb3ac4efd8380be651a51b9]
stable/6.18: [93cb902b0ca04c9dc28b38776f7a03503c84b7ad]
stable/6.6: [89b539970af70a003a475c1ec975b16f6b4dae69]
stable/7.3: [828c02c65e2b0541f0cce403e336b978f92b6dfa]

CVE-2026-99542: ksmbd: deny access for an empty DACL instead of
granting the request

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99542

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de0cffef897c1c232ed973f89928cd6c93d0b1e3]
stable/6.12: [0c96f614876e251ae9d6764e8d52d6544fef0424]
stable/6.18: [28db998d396a9b2e6e9ecf69c2a201b8f06df2b2]
stable/7.3: [be67941493114d1145d16088938bf589e34f111b]

CVE-2026-99543: backlight: qcom-wled: Fix NULL pointer dereference in
wled_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99543

Introduced by commit feeab87 ("backlight: qcom-wled: Add support for
short circuit handling") in v5.5-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1dbd46d4b2fb416a8202b1a8e4ef9d0cadbe075f]
stable/5.10: [7e949e3a66b0a72b4394518f9d97e4d530430299]
stable/5.15: [37feb050077803d0f539613f4a84a511a9df874e]
stable/6.1: [2691d5e511db0f0272f361151f57de5abdf9ad35]
stable/6.12: [a4fdcde0855cf0dc754da02dc23b4af36b64e3f8]
stable/6.18: [8eee3226bccd34d7edced8913968a72a9c50d3b3]
stable/6.6: [625dfa745c9877327cb1f7b28e37841d435ca04c]
stable/7.3: [a1f4944f6f79bc4d9e44203a797d62b2b645d8f6]

CVE-2026-99544: Drivers: hv: vmbus: Bounds check the shared ring buffer indices

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99544

Introduced by commit 3e7ee49 ("Staging: hv: add the Hyper-V virtual
bus") in v2.6.32-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d287c17cc5bfd6386fe0770999be410b248d021]
stable/5.10: [97b0aa62197b4ffb4d6a9c3905ce581ac9ec4a2c]
stable/5.15: [c2657e0671fae29e66204da3201c0eb51dd42744]
stable/6.1: [2955188276124e71d540dc7f5e9ce369b664b5a5]
stable/6.12: [cdb9126a79b608b4331dfdc03beb05be8d2563be]
stable/6.18: [f204bb7c5d10482067e095af567c391bc88ecb44]
stable/6.6: [4bc0832dfbddec0440152ee3ec7e7dd31857e231]
stable/7.3: [1611ce4dc6cbace75f27db6a559af8d391a06118]

CVE-2026-99545: driver core: take parent lock on deferred probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99545

Introduced by commit d1c3414 ("drivercore: Add driver probe deferral
mechanism") in v3.4-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4059f8986c8f50102a04335cc1da4921dfd262d8]
stable/6.12: [9bb694ebe1e960f74535611546489b1542519283]
stable/6.18: [4a9a39ef6da4a3447e97033ec53077094fc2d69c]
stable/6.6: [995577021c056c3760bcadc81a3ebd1c6124e60c]
stable/7.3: [444dd434b508e98bfe2e0f3ab04332faa2f9963f]

CVE-2026-99546: net/sched: cls_flower: avoid stale mask references after delete

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99546

Introduced by commit 9214919 ("net: sched: flower: set unlocked flag
for flower proto ops") in v5.2-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58f7989da6e715ce834ac861b7ba6ae9f9bdb098]
stable/5.10: [282807a0ecb8fe5beba8e4983e4330e03311e55a]
stable/5.15: [a2b1492931d41202e03ea55fb0a855f8d19b618e]
stable/6.1: [5f001b9ffe36361d0f07e776b05827c3139c884b]
stable/6.12: [47ae95cdcb9b1d6770c624ae778828b1d698801a]
stable/6.18: [cdffcb89d84455158d057a6baa87a67225a7f062]
stable/6.6: [7def39be0ecaec241699ed001c9d669bf742465e]
stable/7.3: [0cc691a899a43e8ecbddfe657198b3f6935122f0]

CVE-2026-99547: thunderbolt: Do not RPM complete unrelated subtrees on unplug

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99547

Introduced by commit 4f7c2e0 ("thunderbolt: Make sure device runtime
resume completes before taking domain lock") in v5.2-rc6.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96a8479804e3f7af43e639e9df39f562f1a75fd5]
stable/5.10: [30442b8bb43f23545169ef2ad0901505328917fc]
stable/5.15: [f631264cb36f6e103a1d6f793384fab7479eab70]
stable/6.1: [48c44c2609b7b263576584b0b2c4ba5b6fdcd8e6]
stable/6.12: [a7f354751b05ead5538176deadb9bc5b1fda0a3c]
stable/6.18: [85a8777c7ec5e17b999b4c9eb0c8cbf4ab936998]
stable/6.6: [4b9f270fa78fd82c181bbb4d8ed94ee4fac2fc5f]
stable/7.3: [e45356d83adce72fd99f57763eb3456c7c560857]

CVE-2026-99548: smb: client: fix early procfs exposure race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99548

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b1afb631395c958993cda4631002258ef4151ea]
stable/5.10: [2a808ab4b69a3aa8b4119f39179c8e5c3d4a85f9]
stable/5.15: [6c5b5d5c3433c463480ea13c7ffbe1d2c99b33a7]
stable/6.1: [8b04f2b6665612cd1c9a6efd3ca996c4a7f041fd]
stable/6.12: [cfaec5094017bd9d41a0572325ec2cec4f7d5e31]
stable/6.18: [4d6e1b44d1fbfa70b045a670b18200dc4824226b]
stable/6.6: [8c4a58d59a7201c944e12406c7b269d4c708e8f8]
stable/7.3: [31209411c4f98158b41508b7f90583e8cf5d6076]

CVE-2026-99549: smb: client: do not pass a NULL buf to is_oplock_break()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99549

Introduced by commit c42a6ab ("CIFS: Add capability to decrypt big
read responses") in v4.11-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2225ab306575e424b3dad2ee1be2521c89249d15]
stable/5.10: [64bc1cb17a7d278bdfce49c6a2780a43b25f3457]
stable/5.15: [6f879d12f5f6414b3bab55cbafebedaca1a87cc4]
stable/6.1: [a60245d3e5f308eaf2d3e5a97cefc76450c7c6f1]
stable/6.12: [6c1ccd31b3a995a1a73e10e7bc8b6d96cf382241]
stable/6.18: [ee793cc8dcd58ed9afa0a69a84d66df4f8eacd88]
stable/6.6: [ab884f7c08b586aada5f6b2387313c0ceef6507d]
stable/7.3: [4bf4fb7f323402df1c57982365c8ac2498b89d10]

CVE-2026-99550: ocfs2: pin owning modules for open debugfs files

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99550

Introduced by commit 2309e9e ("ocfs2/net: Add debug interface to
o2net") in v2.6.26-rc1.
Introduced by commit 87d3d3f ("ocfs2/hb: Expose the list of
heartbeating nodes via debugfs") in v2.6.30-rc1.
Introduced by commit 3ba169c ("ocfs2/cluster: Add new function
o2net_fill_node_map()") in v3.2-rc4.
Introduced by commit 5039750 ("ocfs2: Expose the file system state via
debugfs") in v2.6.30-rc1.
Introduced by commit ccd979b ("[PATCH] OCFS2: The Second Oracle
Cluster Filesystem") in v2.6.20.16.
Introduced by commit 7209300 ("ocfs2/dlm: Dumps the purgelist into a
debugfs file") in v2.6.26-rc1.
Introduced by commit d0129ac ("ocfs2/dlm: Dumps the mles into a
debugfs file") in v2.6.26-rc1.
Introduced by commit 4e3d24e ("ocfs2/dlm: Dumps the lockres' into a
debugfs file") in v2.6.26-rc1.
Introduced by commit 007dce5 ("ocfs2/dlm: Dump the dlm state in a
debugfs file") in v2.6.26-rc1.
Introduced by commit db02754 ("ocfs2/cluster: Show o2net timing
statistics") in v2.6.38-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26d7e34b4226709084461a07bf28d9066fa96d8c]
stable/5.10: [e0d62a6d9f8052f7300e0413d32a24fad50c014a]
stable/5.15: [97ed524d264baebc632e381422585f95cf8cb4c9]
stable/6.1: [0e573d9b0c5ccf1dd9b62deeb52641fca8e0dcd4]
stable/6.12: [ae5ea8ca2db9a0306c04f4777433908456ce8541]
stable/6.18: [f5e973e238ba686a17f19dfbccccdd1c4447a2be]
stable/6.6: [8c8f39e55c962fef805846a2ab2257ba4d82cd0a]
stable/7.3: [625bbfa9c160ca9d4128acddb15fd7da3ea66c17]

CVE-2026-99551: ocfs2: drain quorum work before removing the cluster

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99551

Introduced by commit f6656d2 ("ocfs2/cluster: Make fence method
configurable - v2") in v2.6.33-rc2.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b584c45b6066fd9799c44ffb9badcb5db351c8a6]
stable/5.10: [f93fa8a7e5f8ccecaf32e308080304eac06f93ab]
stable/5.15: [6f79eeab76fcc22082996235e6ebda80959744ac]
stable/6.1: [52a229f6ad8bcd9f8019f92e9d96fc556800e6c9]
stable/6.12: [102ebaf4db4c81668db6a85d88273826dc94e539]
stable/6.18: [1c77b387fc305c9c314f29cd034a490bff7f81bd]
stable/6.6: [04b958506a00e6506e0c05acc794972e39378498]
stable/7.3: [ef1a59804c07e2e17885cd6c723c4638489cf58a]

CVE-2026-99552: ocfs2/dlm: drain join handlers before releasing module text

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99552

Introduced by commit 6714d8e ("[PATCH] OCFS2: The Second Oracle
Cluster Filesystem") in v2.6.20.16.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [28f366d84023651e50e32e29931401ba0df3e679]
stable/6.1: [bb8a46bb9985b7acfe02a0fe63452fe51ad60549]
stable/6.12: [d2b05b1190bdecbff2d26f48b376345b6f5ec5ea]
stable/6.18: [912327bb4cfdc38e83dd52300a087a7e68826ece]
stable/6.6: [13dd8af7b39a9381ebf82f775572edd67d4661f8]
stable/7.3: [57a474ce387bd68f77b470bba7c0ce10bdb62dfa]

CVE-2026-99553: nfsd: fix race between client_info_show() and free_client()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99553

Introduced by commit 601c8cb ("nfsd: add session slot count to
/proc/fs/nfsd/clients/*/info") in v6.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee62dc03a69ee57855de35da1a8ab53b51d30b32]
stable/6.18: [f43a5d7b665cf04199a3e8ea0dddc9e2dbd5ada6]
stable/7.3: [7f6a52f076d4ebbd91868b06e9546ada829cf101]

CVE-2026-99554: net: usb: pegasus: do not advance rx_skb->data on dropped frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99554

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfa09dccf98cf78dd9282259b2140bd1472f5ae9]
stable/5.10: [f6b5c479ca5515df44462067dc82ba9a1712ded6]
stable/5.15: [113e14871483f3ba7e705de75e18f9f0a9a8c846]
stable/6.1: [df0a69ead4f427570b557cd0de447f1f770795e5]
stable/6.12: [05e204042f213f9d862c6901f53cece61aa5209c]
stable/6.18: [00c0c940c1c8941497a8cf511edc95fdde8c6382]
stable/6.6: [d1b9323203bff9f06a3887715e2320cb6b6b0b6b]
stable/7.3: [6af7578840bde82e6cd5de3235502c116bcc196c]

CVE-2026-99555: media: usbtv: fix null-pointer dereference on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99555

Introduced by commit 65e6a27 ("media: usbtv: Remove useless locks in
usbtv_video_free()") in v6.9-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [cb705f75d03e946a4514488beb9e3bac9bcdb2e6]
stable/5.10: [3ad747dbf0cd07b41af50978ecd6b819f37ecebc]
stable/5.15: [dfc4acc8a05ae8fec335d4425696e3db2dfc6a83]
stable/6.1: [53af48fc2ed1336b8a43e6d6ca8ad9ab15548137]
stable/6.12: [9b8a85025df329bc3d3e063d153aea3baf72d266]
stable/6.18: [42451fefb076230cdeac1da4e85b08e18af67d18]
stable/6.6: [93ef58b176a5376e2a73b3025bb3e10f18c28837]
stable/7.3: [5f4bd9eebdd2c79603ed74e25da7345bcf63345e]

CVE-2026-99556: ksmbd: serialize directory emptiness checks with readdir

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99556

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7220980b2423d06a0604516129bfa4cec8a697ae]
stable/6.1: [67683a6cfbab82bb022d7d89390216c855fa6786]
stable/6.12: [5ad61a34963f32fc1637d26e88cf6e02a3b99d08]
stable/6.18: [818a9fd779443b931b05c025d85f29680efb26c2]
stable/6.6: [068c3a2a70c2c342bb84b882bb1f45f5a8c5a42c]
stable/7.3: [2a4b6ae380a9f5175f002c1921cf9cbc7ca536ba]

CVE-2026-99557: ceph: fail readdir when the MDS reply carries no dirfrag

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99557

Introduced by commit 81c6aea ("ceph: handle frag mismatch between
readdir request and reply") in v3.13-rc2.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [728c856d7da04fb79f7aa00e974ffb6f55e55995]
stable/5.10: [500d7e85af3116803d2cdae9f3a8319e782b84e2]
stable/5.15: [ba0a9ccfd717a603ac10520f723cf4a4881e61b6]
stable/6.1: [12646a00f8549c9f17e5213c30bd608e81fee8f9]
stable/6.12: [37d01a684e6087e264895ab34b829d2267ad607c]
stable/6.18: [49d7c1beac3810983869ed9260dcd444b6a51c8e]
stable/6.6: [4ec54ab76c627e4ff8dc29a18237f923ee1f2bee]
stable/7.3: [d129cfc783b5ff091f5edcccf8129608ec50c000]

CVE-2026-99558: blk-crypto: fix NULL deref and UAF in __blk_crypto_evict_key()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99558

Introduced by commit c984ff1 ("blk-crypto: dynamically allocate
fallback profile") in v6.5-rc7.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [c8c53d669d4e45b3a804013251a34387d7e11bfb]
stable/6.1: [0965c6f8b196a18072b498528521de85971d694f]
stable/6.12: [6304b40fdc8bdde881e2bf7b7cbe501261e4abd3]
stable/6.18: [37c957fbc8ac0bfd85259b37f03e47006c8e35e8]
stable/6.6: [178c924e42afb0bf496af01727bac8ad9745f544]
stable/7.3: [11e9f0c8b30a7cf3ba0869ecea7bf784c3f81dab]

CVE-2026-99559: ARM: 9524/1: mm: align hugetlb mappings to the huge page size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99559

Introduced by commit 7bd3f1e ("mm: make hugetlb mappings go through
mm_get_unmapped_area_vmflags") in v6.13-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1eb87d8f77379d4e4b279487b8c859fb64bd1afb]
stable/6.18: [277157864856d812c82f1ca8c156b392d368b8c7]
stable/7.3: [8602ec8effb019d7db38d3c234d9d7305ee429a5]

CVE-2026-99560: wifi: mt76: mt7925: fix reset panic caused by the WM2
rx irq mask

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99560

Introduced by commit c4edf9e ("wifi: mt76: mt7925: replace shared rx
irq masks with per-chip definitions") in v7.3-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c182bfe944eb275f7526cc326f81229b0e974a0c]
stable/7.3: [3c287de98388c3746d8b884de9fd8c3e83f41c04]

CVE-2026-99561: fork: don't create io threads once PF_POSTCOREDUMP is set

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99561

Introduced by commit 9230738 ("coredump:  Don't perform any cleanups
before dumping core") in v5.16-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f978881ce6c9ac4f4d4a7b6a6e52339eadcd350]
stable/6.1: [bee3b46846a6fa3c2f21c0df394338869e282f64]
stable/6.12: [3a0cdf3eb9c3026b046efe32f01b9090ab4e2d73]
stable/6.18: [64f2a38a1658493d7a53d656bcc483ee4b837623]
stable/6.6: [846ab269dcc9c2f22742cbffead0bbcabbe74b43]
stable/7.3: [026aa32c00b0b3ea849d0ae98313274c9d3c7e21]

CVE-2026-99562: ksmbd: reject FSCTL_SET_ZERO_DATA on a directory handle

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99562

Introduced by commit 25e414d ("ksmbd: report holes in allocated range
queries") in v7.3-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef85bad39cf273a8377722c9f3078294dcc2fc7a]
stable/7.3: [89092aa492f1ff8cbbca14503a008795251bae6d]

CVE-2026-99563: smb: smbdirect: release failed pending sockets of a listener

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99563

Introduced by commit dc691b9 ("smb: smbdirect: introduce
smbdirect_socket_{listen,accept}()") in v7.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [328c7e307e8411899e2f90beae83da9e4c45d700]
stable/7.3: [df7e97ff4f114e1dc2188d11339b8d0299c4a77f]

CVE-2026-99564: smb: smbdirect: don't wait for
RDMA_CM_EVENT_DISCONNECTED in smbdirect_socket_destroy_sync()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99564

Introduced by commit 422a243 ("smb: smbdirect: introduce
smbdirect_socket_destroy[_sync]()") in v7.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ca76b89917ad5b317e07ae4f0edc16f7c2a1248]
stable/7.3: [1ce50f83ed13b3147d4a40b50cc71d0dfdcc6d41]

CVE-2026-99565: ksmbd: wait for negotiation before receiving another PDU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99565

Introduced by commit dc8289f ("ksmbd: fix slab-out-of-bounds in
init_smb2_rsp_hdr") in v6.3-rc6.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [68f410faedaf6ee74d81e574733c50ebcc1bd8ed]
stable/5.15: [0152126adb40f1ca21caf1e4616f526f142caf7a]
stable/6.1: [f60dc56df21d6edbca1df537f8a667439990ae50]
stable/6.12: [a9039d6c9de5dfd91f360b085da75899055b15a5]
stable/6.18: [49675f7bc0e1ae12a60f6af5cb2b800eb39fe055]
stable/6.6: [99bddd24baaf4c92060beebbf7e7561ff9ff8bc4]
stable/7.3: [d4a52e78378a501ae38f676e85a60a2a6c21af35]

CVE-2026-99566: assoc_array: keep gc's cleanup out of the live tree on
allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99566

Introduced by 3cb989501c26 ("Add a generic associative array
implementation.") in v3.13-rc1. Fixed in master.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8afff2e4b90978b8203f9e3898995dcf86821b49]
stable/5.10: [86ea23a14af6e909dd4d3f92ff370f3b06bc6827]
stable/5.15: [f1c3efeb27f2663f1bcd6f794e22aca96c61f018]
stable/6.1: [5511f84917cc4021b46fdf626ae354f28824dacb]
stable/6.12: [cd39c75fbd52017064879061c2f97fa573984c93]
stable/6.18: [c9138a6357a68762e499143160d0d7e0cba3228c]
stable/6.6: [8d7e5fade0a956775d7d695499df490ef3e96a07]
stable/7.3: [c80609763abd3f8ee7c1fe69dd43b07abff474f0]

CVE-2026-99567: assoc_array: don't chain a new shortcut onto an existing one

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99567

Introduced by 3cb9895 ("Add a generic associative array
implementation.") in v3.13-rc1. Fixed in master

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48691075b0adc590a6831390723e3603dfca76fc]
stable/5.10: [dc1105e231546fdef16b8a98a36bddee08644098]
stable/5.15: [61fce0632e56f9e80140453a42c8d876efd0aee7]
stable/6.1: [25097b7dd44d659ea396eca9fa11f351fffcbec2]
stable/6.12: [517e7bbfaf5381d47e8d393ff54c61107f8fb1bb]
stable/6.18: [258745fea55ba057c062e0e680a54fde26630e95]
stable/6.6: [340df159851513c3d1ab73c679e13c3f9576a698]
stable/7.3: [a7990a72267f264f5284f6bcb90d397b29ac00ed]

CVE-2026-99568: iommufd/iova_bitmap: Ensure that iova_bitmap_set()
handles the full IOVA

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99568

Introduced by commit 58ccf01 ("vfio: Add an IOVA bitmap support") in v6.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e21952d72b4740f08a272d694cca223b6b0099ca]
stable/6.1: [dc089da0fcb67d4a9402a3bae70a18845ff79fef]
stable/6.12: [f41d317be00767e81ce0a664fa37ab829654ab8d]
stable/6.18: [63ff69e265bec1712d2b7105e7c1556f73a3080f]
stable/6.6: [668874bfb4b78afa587ce2c724bd44da4c22f19c]
stable/7.3: [dd2f8565e68cac312451926ce2e3883923caf081]

CVE-2026-99569: f2fs: release a removed xattr node in roll-forward recovery

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99569

Introduced by commit 28cdce0 ("f2fs: recover inline xattr data in
roll-forward process") in v3.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5924de8867c09206ba631b9faed63862ec00a10]
stable/5.10: [bf2acd50ae2bf721f97ed108a22139078f3b60e2]
stable/5.15: [1b3f12d3b5799a81d70f23e74d1dfff7b3002ff2]
stable/6.1: [6d20439d101e1574801b05349451e87cf1447a39]
stable/6.12: [246a50b23bf2042c77b167272db121d03c8dd473]
stable/6.18: [c06cfda3b67692651438876663ae7cdc187eb214]
stable/6.6: [9dde888b2260612d05f1077042a12538187afaa4]
stable/7.3: [6d9c89d6dd18c0cfec33bdb468bf4b86c0ca7cea]

CVE-2026-99570: f2fs: fix to invalidate curseg if change_curseg() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99570

Introduced by commit 86f3360 ("f2fs: handle errors of
f2fs_get_meta_page_nofail") in v5.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e74476ad8162c1facc74b74ce2d1372492df872e]
stable/6.12: [1c9ccd9eadf1707a2149c3237b85f1f82ce92702]
stable/6.18: [c8e6c10f95643dd88e73e7daa8ceb1041631920c]
stable/7.3: [c2de116785396df236e311e7643913212fe9fe50]

CVE-2026-99571: nvme-tcp: Validate the queue state under the queue
lock in the address attribute

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99571

Introduced by commit 782373b ("nvme: tcp: avoid race between
queue_lock lock and destroy") in v6.12-rc4.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [2eeeaa9c1ff0c429096acc2947c296db6a56f96d]
stable/7.3: [0af6a8aede3121bc9662111665294731daddb13a]

CVE-2026-99572: f2fs: fix to avoid potential reference count leak in
do_garbage_collect()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99572

Introduced by commit 02d9139 ("f2fs: fix to freeze GC and discard
threads quickly") in v7.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [894ca8b856668a82426dbd0a0042b61541a1a9ec]
stable/7.3: [9d3f586c53d32ce8352e72cdfc2e9ab08b80a615]

CVE-2026-99573: KVM: arm64: vgic: Stop the target vcpu when disabling LPIs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99573

Introduced by commit 96085b9 ("KVM: arm/arm64: vgic-v3: Retire pending
interrupts on disabling LPIs") in v5.1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1b4bd2c2c262b8094c86afb99364d16ac08cb66]
stable/6.12: [b5d4692948f2fc6cf6f1b7223bd10c3d1c3bb104]
stable/6.18: [9b12da785bd0af7f0976ec24332f33634f7ee924]
stable/6.6: [565f1289963ac659aef74e5654c4b08a526390e1]
stable/7.3: [8f431c3829f38bacbf69447cbffda6968b260f5d]

CVE-2026-99574: f2fs: bound the SIT/NAT bitmaps by the checkpoint pack

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99574

Introduced by commit 39a53e0 ("f2fs: add superblock and major
in-memory structure") in v3.8-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [080833a32fd5dc10b3acf2fa9af9b3213e6cb617]
stable/5.10: [8beac82c7cc9f7d0b060a4c67d912c1b6a66a1f8]
stable/5.15: [415b142b03b4daf770340761db1431d638d188e2]
stable/6.1: [47897ae5e050c40ee80994507dd7eb504174e27f]
stable/6.12: [ddb9848fd6b2f4e9ed5ef78b20c9720c65a29df5]
stable/6.18: [9b08fc2d092171af388f83030d54488b87453155]
stable/6.6: [daf5987d2c48d9965534c3adc0a200bcb6e9d726]
stable/7.3: [7f88cd38394a16c326073c8813e7f1f1445bf3ba]

CVE-2026-99575: f2fs: return -EIO for a lost inode block after cp_error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99575

Introduced by commit 28607bf ("f2fs: drop dirty node pages when cp is
in error status") in v5.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53b12b63304b34a3850a901c4de3cc6ad08e0aee]
stable/5.15: [8f86283856882d4e15b54d889b1c35a6c70c28dd]
stable/6.1: [f90fa379296f67c8f8c0e0ddb21ba04bb7be46bb]
stable/6.12: [9960426b20021e2a92916f7836b53ca53f4deeee]
stable/6.18: [935bcf17f7052198a3ec82c55642c8e58f3a483c]
stable/6.6: [9b862bcedc1bf4b40b2f73eef88f3fd371104f8a]
stable/7.3: [86dfdf4f2aeaf68905e9b08752d72624a05dd471]

CVE-2026-99576: f2fs: zone: fix to avoid bio split on sequential zone

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99576

Introduced by commit 52763a4 ("f2fs: detect host-managed SMR by
feature flag") in v4.8-rc1.
Introduced by commit 664ba97 ("f2fs: use BIO_MAX_PAGES for bio
allocation") in v4.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b9b036bd1e2cfbc189d5811d62d8711e216c40b3]
stable/6.12: [e83a3ca9fb7c1f7e439d2c2e547897053342c1c6]
stable/6.18: [ec2e624b95cfda1c8b30e3a5b3ca9a55433da6c3]
stable/7.3: [c28481c073d4ca30c3c2ab6f1a65051cbe936220]

CVE-2026-99577: wifi: rtw88: usb: bound what the driver feeds the
after-DTIM queue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99577

According to the .vulnerable file, this bug was introduced by commit
076f786 in v6.5-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04cc8c59a3d79ef7ec2341f1c7aef1d40a0ce7df]
stable/6.12: [9f7c09a830398003de105004035ed7aa0185b65f]
stable/6.18: [0bd2548fee3ae403550a394b5270d914bc2b76e9]
stable/6.6: [7749af899a1882a17c934c035d30d0870875b0f8]
stable/7.3: [99085c31b8521eb588b66b726ca6d08338e3a14e]

CVE-2026-99578: wifi: rtw88: usb: route bmc frames via the high queue
only for DTIM delivery

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99578

According to the .vulnerable file, this bug was introduced by commit
076f786 in v6.5-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c710c7c2e0380d7c0eeb33b686262edcaef7cb07]
stable/6.12: [8da3a71216a0ecd02980dff5cf9739376249fc72]
stable/6.18: [aa383c35d3e3688da8da0993f751c7b4bab66b02]
stable/6.6: [31aa0c4f82763ce1abe068ba97261de6fc6c1b6f]
stable/7.3: [781af5ab5a848b3c0767c0f057bd6692e3b7c17e]

CVE-2026-99579: mm/shmem: honour F_SEAL_EXEC when an ACL is set

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99579

Introduced by commit 6fd7353 ("mm/memfd: add F_SEAL_EXEC") in v6.3-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0237c47ca17005ea41b510c6116f0257dbf84eab]
stable/6.12: [cd5769d84a3cdf8a935c4fd8987337f1eeed1828]
stable/6.18: [e9fcc5bfa1c8999772c99ff91d1ec0bcc267a02c]
stable/6.6: [37639e667dd6062fc95ab63f52fc1a34d91a0631]
stable/7.3: [7a5eae5fee348b6d04d44577be5df079dc692111]

CVE-2026-99580: mm/userfaultfd: only allocate anon_vma in CoW mappings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99580

Introduced by commit 867a43a ("userfaultfd: use per-vma locks in
userfaultfd operations") in v6.9-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [514c9247db305922591d806ec65d3c3fe420538d]
stable/6.12: [a90e7044b34f801fbafcb682e8ee827a6db26002]
stable/6.18: [3bf446c8ce64938f86439906d730a2cd5c0b31e2]
stable/7.3: [20704188d669ed74a624fd67dfa4711bcb1087b6]

CVE-2026-99581: platform/chrome: cros_usbpd_notify: Only use drvdata
when parent is GOOG0004

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99581

Introduced by commit db65a06 ("ACPI: EC: Convert the driver to a
platform one") in v7.0-rc1.
Introduced by commit e4ee0bb ("platform/chrome: cros_usbpd_notify:
defer probe when parent EC driver isn't ready") in v6.19-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca75b38b1a3c2eabe81d231dae4ea180cf6287cd]
stable/7.3: [4de4a28e514ea2cf9a91d198b66cda7f02ad5edb]

CVE-2026-99582: sctp: re-point retained control chunks on association migration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99582

Introduced by commit d04adf1 ("sctp: reset owner sk for data chunks on
out queues when migrating a sock") in v4.14-rc7.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [52ffeaa358d1f3d91aa87a26ad90d77769cff74b]
stable/5.10: [12ab17f4aed9778389e6e8ef106520dfd74572a4]
stable/5.15: [103e8416d4b00a8061d5937a3032ef65247caedd]
stable/6.1: [f0c67d7efc3d766d921dcece1a2353670ce401e7]
stable/6.12: [830e0073d514eb666f0b7b6529e5e286529e9acf]
stable/6.18: [0cc0f5ed58904cd7c55770d5108dea7125d020ae]
stable/6.6: [92da281bded810165845e4ae40a2b134b2774c31]
stable/7.3: [2070e2a2095c892900d90a6dd609433ce0ad05e4]

CVE-2026-99583: sctp: hold shkey across socket migration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99583

Introduced by commit 1b1e0bc ("sctp: add refcnt support for sh_key")
in v4.17-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad1320865b1826ffa2e81e37c49535751e81335c]
stable/5.10: [38a38f86ea16bb4ebf3fa726f20cf6b147d83d11]
stable/5.15: [a2f593b4dc5ebea19b31dc22abcf3354eb15f9d2]
stable/6.1: [7fd041b9d125dc8351856a28fbe235a7867c161a]
stable/6.12: [bea7f19a12e68a670c7173aac1c52de12fd615e9]
stable/6.18: [79e6577cada6a2d956042e3342ac2b2122ead6b0]
stable/6.6: [4b72a7b4f439964229c9cb11f97e925b92030179]
stable/7.3: [9875dda4a2dbbbe259cd5f88f19d87b8721a98d0]

CVE-2026-99584: f2fs: fix to avoid folio->mapping dereference in
is_{meta, node}_folio()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99584

Introduced by commit 019a891 ("f2fs: introduce is_{meta,node}_folio")
in v6.16-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5a71253c5c7e1139eab2f3e1e13e0bf2cbcaac7]
stable/6.18: [ecf2796547582f1518f36bba370904934e659a46]
stable/7.3: [f56399666631be3d755a16fa9658e088d81c99b7]

CVE-2026-99585: KVM: arm64: Use kvm_s2_fault_vma_info in gmem_abort()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99585

Introduced by commit a7b57e0 ("KVM: arm64: Handle guest_memfd-backed
guest page faults") in v6.18-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [80b0b86dc5e4344e62a2fd3ee43d0ef816fe9122]
stable/6.18: [09462113ed3906929b228144a738e7b15cb9f52d]
stable/7.3: [9f84bde6aaade57b2ef7b71c1783b30773cd43d6]

CVE-2026-99586: iommu/arm-smmu-v3: Handle ARM erratum for CONT under
invalidation with SVA

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99586

Introduced by commit 3f1ce8e ("iommu/arm-smmu-v3: Share process page
tables") in v5.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84c6089a365ff5547f9ea30cb407dc5fe3124fd3]
stable/7.3: [96ecddc5141c967c5a59fa85ccbdfdb3cec61209]

CVE-2026-99587: ata: libata-scsi: reject data-in commands with a data-out buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99587

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4845f077415ef32fe672c841e2fc58ae9e28273]
stable/5.10: [8a57c4ce7fe35b04874685b5df14f72c097016c2]
stable/5.15: [da24281e7f8e3b741ea906395d218e995a3cbbc4]
stable/6.1: [93257499c883d83b531d5ffff57242d2e3762be8]
stable/6.12: [cd77d3791e66350541f1c7c5447db2f28857bba4]
stable/6.18: [f4cfd238e806e6784a7b4ff609a0592382d54df3]
stable/6.6: [97313de58cfd8c5e9251e991079a1879553eec5d]
stable/7.3: [10c6a917284f584162974767d4e2a0cf411db684]

CVE-2026-99588: batman-adv: tt: only update flags for TT events

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99588

Introduced by commit 3c4f7ab ("batman-adv: improve the TT component to
support runtime flag changes") in v3.13-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad1fd828aa3944efc393b84b0d7c02483f1b5638]
stable/5.10: [e264dff563453ca96fdf09eac5a541af43ebb0ca]
stable/5.15: [1d6a23522665be4f6e56b03c9b9200da1884f9dd]
stable/6.1: [e8e09996189e2911f52889cc10fb5801100607f9]
stable/6.12: [92fb8f25fee4c8820b54a18f694b74b3adb79f34]
stable/6.18: [4cec0f6207e551ec4081e84a37918060dd2b51a7]
stable/6.6: [02c5b60fd4b64f505189055232382e76d9d641a0]
stable/7.3: [326bea8dbc9dc741a39c33b4a8cb6ce07dc4cdbe]

CVE-2026-99589: batman-adv: tt: clear ROAM flag when re-adding a
pending local client

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99589

Introduced by commit 068ee6e ("batman-adv: roaming handling mechanism
redesign") in v3.8-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc2186d7854785b30d423f5d43757b086b300e55]
stable/5.10: [072fad3b319198aa8310b632b8f18a1188f3fb8c]
stable/5.15: [03bcdcc6e63983f79005104f672bf556e86b7d4f]
stable/6.1: [16efb7b5a683c762976d581a35ef7cf9f5614d9a]
stable/6.12: [fcf9688afc291bd9d383051c12e8bc148b4add62]
stable/6.18: [658e7e37113f2ef875ea1b17e626f47d54c331ba]
stable/6.6: [045c0ff38474cf8ebb68ba9eb2081974ef9fdab6]
stable/7.3: [32d45d029d9ffdeb99e86ed21406a70485fe08cc]

CVE-2026-99590: ceph: clamp the inline data length in ceph_fill_inline_data()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99590

Introduced by commit 31c542a ("ceph: add inline data to pagecache") in
v3.19-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c1d14d3b66b3e1dd96ee664c0dd2548f2b77a52]
stable/5.10: [d9c1bf1967d0e9a499e311d79e648c14dc9e30eb]
stable/5.15: [5134f282c7c65a1e44a975bb26fe5c022d9625de]
stable/6.1: [7b5eea42b34895df5788789ddd7f748086673a5f]
stable/6.12: [b325a1f0d441bb1925ef3c1e09d1db05ecfcc12c]
stable/6.18: [f07b16256d7041c60dd2e205783d5d3a7934f884]
stable/6.6: [595c6d7d3cf3c90ceaab4eb5392dbc1bbb12821a]
stable/7.3: [9d06011f8c5b4c9989397a501483fec0f4a149cb]

CVE-2026-99591: iommu/amd: Force device table to maximum size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99591

According to the .vulnerable file, this bug was introduced by commit
a69ca34 in v2.6.27-rc1.
Fixed in v7.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e2213dae78b41976c60133eb10cf99e81916638]
stable/5.10: [53d065f896347e22c8aec40524e6ea17a81eb7e2]
stable/5.15: [3d44a3c737901ccb39799f5b926946a3f928b494]
stable/6.1: [fdb721868f361aa33b79e79c7bf261bd2c4f8686]
stable/6.12: [e8f1f1ac434f24604d93ea3c8cbac513b2dead69]
stable/6.18: [046f0b83f18c6313f63419517bb4185e3e0d1a6e]
stable/6.6: [c01e5bd5a6ad66c94834d8d9704ff0a15869b3b0]
stable/7.3: [bdbbf5ad5d032e8cb4b5356d0f3970829f0309c0]

CVE-2026-99592: x86/mm: Fix global ASID handed out to two processes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99592

Introduced by commit d504d12 ("x86/mm: Add global ASID allocation
helper functions") in v6.15-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5cdc3746fa163fb4e8d05fa3cabf46bc6aa7df75]
stable/6.18: [25bf240e1c755aaef670680a6de03f9f561c86f5]
stable/7.3: [02938c10d9e5c7631c8dbd6c48517805c1edf0a6]

CVE-2026-99593: arm64: sdei: Preserve the interrupted context's
exception registers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99593

Introduced by commit f5df269 ("arm64: kernel: Add arch-specific SDEI
entry code and CPU masking") in v4.16-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58c1eb84e97701c583605ba2fd553b69afba2245]
stable/5.10: [914665278485cd633221b637d97bfe923b5290ba]
stable/5.15: [6b0e6363ec642ec05a12b485a2cbdcf8dc9cc1ee]
stable/6.1: [c5b3ef8685cfb61635fc4b5b9ef51d9a09c4e484]
stable/6.12: [41069c9f124e98e0f0f4dbc859a0d1bde5aa6774]
stable/6.18: [4eb6fe1ba6373c573e9940298092fc5d5cd08844]
stable/6.6: [c1fafdf7ca618197fb26880b991f53f41a81c230]
stable/7.3: [d56db59d42d03d138ab643f765c84a48876f7a6a]

CVE-2026-99594: arm64: kexec_file: Fix elf_headers memory leak in retry loop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99594

Introduced by commit 108aa50 ("arm64: kexec_file: try more regions if
loading segments fails") in v5.10-rc3.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac302aea3d824ccc99f29b8e499c365cb9a684a9]
stable/5.10: [cda1faa5e63e721b76cab0125e6c6aec5dd4597d]
stable/5.15: [83f4a7a6d0ed07374b80d963abc6a4e06661cb16]
stable/6.1: [597f4f44256bdafee119e5535fbb18d0b8624bd6]
stable/6.12: [6bbf156e8ec4468d3b9a3caad891c9ca43a9cab7]
stable/6.18: [b784e4391fe79e74f989e997b9a0c2a9c337dbe6]
stable/6.6: [56dddd2c024dd7f627a95c77babe8f0188ac5948]
stable/7.3: [f118ee71df3a2d3c54d57cfbe3643a9a29b83128]

CVE-2026-99595: sched/fair: Clear throttle state when leaving the fair class

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99595

Introduced by commit e1fad12 ("sched/fair: Switch to task based
throttle model") in v6.18-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c282051fc2cae2ea54770ebe435dbea090272c25]
stable/6.18: [a06269eb700537fb8bae657a0c5998ede06360d5]
stable/7.3: [b91da5a7f8bc9ff522c5554c1a1934c2cb7991fe]

CVE-2026-99596: nvme: wait for SRCU readers before splicing the namespace list

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99596

Introduced by commit be647e2 ("nvme: use srcu for iterating namespace
list") in v6.10-rc2.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [8a0449832b50cd4f99f2d2952cfc1476e5f26d0f]
stable/6.12: [a7f566c0c354109ea565ef29afdf23005b2d48dd]
stable/6.18: [38e604a8271ea9fd4add6669de73cc72da8184ae]
stable/6.6: [d2abebe215bddb942f3372f7a964ca46cf21c96d]
stable/7.3: [eec7caddb4d152c72a7b6975c6e3f5589cddbdd4]

CVE-2026-99597: srcu: Add list_splice_init_srcu()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99597

According to the .vulnerable file, this bug was introduced by commit
be647e2 in v6.10-rc2.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [d06917d0ba226206dbd606330d73a8eb1e3029c1]
stable/6.12: [89ffb3ea28fef005ae2bd105565c6010dc9deb67]
stable/6.18: [2edd46589bf92f71a7c8474d84a7258eb13c2d06]
stable/6.6: [8d2bc9fea74e4b24528410250e3a0a990915b201]
stable/7.3: [b66e38c17e5e1e9095f9c3cd203458c2bb11ea5b]

CVE-2026-99598: MIPS: sgi-ip32: Leave MACE PCI control alone in config accesses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99598

Introduced by commit c990081 ("[MIPS] Fix IP32 breakage") in v2.6.24-rc8.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a55a7df2cf788234850d9053ecc25a5470175929]
stable/5.10: [5f5ff9c2e16d911364a87197db9678484662afd0]
stable/5.15: [672120d73a8b274d03f65556faab4f7c77c3e5ac]
stable/6.1: [fd109b7213e40c9833957b7d1da45c720ee6f05b]
stable/6.12: [86b60f2bca5dfce8ca5c4312a26a4a11c087b92b]
stable/6.18: [ce861bb797596734d341c3694a502788268f6636]
stable/6.6: [03e6bcf49a504ccdacbc7ddded2209bada342c1d]
stable/7.3: [d90f4cf6b8edc7e45aedf0036858448d0c1d4e2e]

CVE-2026-99599: udf: don't use eloc after the end of the unallocated space table

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99599

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94401199df90e1c2a50c6e4b73618ac5a4ba83ba]
stable/5.10: [f0800bc874077d48a3e7e2c689ac0dcbab805164]
stable/5.15: [28c14f0297aa03259460825de8712942f25d1e8f]
stable/6.1: [41fe9bee3e6bf5942a97e5ab64696ea1d5784118]
stable/6.12: [0ceb311c0f7af4f4b38fc1066178b84a60d61a05]
stable/6.18: [812d49a09ce0a8fcc784349d6a95e975a4af51cf]
stable/6.6: [82c92d7772d58d0d2f49328b7b846b79db33de91]
stable/7.3: [9ecd3d7ed7d7a57ee6af27dc22be0b3fdc9526f7]

CVE-2026-99600: udf: fix preallocation discarding before an empty
allocation extent

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99600

Introduced by commit cfe4c1b ("udf: Fix preallocation discarding at
indirect extent boundary") in v6.2-rc1.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1

Fixed status
mainline: [0c52750caaaccee8b0e929450fe6538ec4985722]
stable/5.10: [77dd881dfc2ecd3da59c2bede6cca4a92ec975c5]
stable/5.15: [a88467d6d07fdc78cdc0ab7d67605dac65aab73c]
stable/6.1: [246ac240c758f3c3144d65d6bb27265f0ec30a48]
stable/6.12: [4ef0ffc5da8d2966d8f4bd0b6dc88a6fab2e891c]
stable/6.18: [f7d6f3fed104ca7e48a9ed081c2047300d3f96fc]
stable/6.6: [8321a492323588f0875ed8ac92bafffc5fd3ec34]
stable/7.3: [0efa27a0d8b8f4b75eed80728d2c331c6104c308]

CVE-2026-99601: udf: check the unallocated space table when it is loaded

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99601

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e614c3e35a6699ed691b4d17e1ec4230e34aa3eb]
stable/6.12: [9f3df19234d2c180b9a99b0d3c2472e8fade5043]
stable/6.18: [88401035fbfcad7067793455326262ac30633586]
stable/6.6: [3ed23daf545953a7a1f03bad511f9fe742874f43]
stable/7.3: [302eb1fa5be5e476a633d8ed0fd56ea5efa57374]

CVE-2026-99602: udf: don't let the extent type hide an exhausted
free-space table extent

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99602

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da582d84fcf5f2f0c1d7760e1a899ca7cedb80fc]
stable/5.10: [816a6df00e9637a438668da849ee00bf0cf7efe0]
stable/5.15: [762315609f9695d983c43a6031a487693b5cb780]
stable/6.1: [30aac8fc4f24b1b065b59a7b07e26030b22c4c69]
stable/6.12: [a40b887f4b67cf969c23e19c28b650d6b5e8afeb]
stable/6.18: [78885b05188d3df733a9697d67bfcbb6d8330f76]
stable/6.6: [ed79c0538e1e42c706409f4799c6145bf2d02365]
stable/7.3: [c4f8f503f2038269ffe9bca218bea65bbece9998]

CVE-2026-99603: mptcp: pm: kernel: use RCU to free endpoint listeners

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99603

Introduced by commit 1729cf1 ("mptcp: create the listening socket for
new port") in v5.12-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49b09ae0bf57b4230187d4cdd0a370558e44a6e8]
stable/5.15: [30355edfe074f72feafb4470a3937c8c460be589]
stable/6.1: [c05dca67e7475a4e576582f4ed19f67ae92a982d]
stable/6.12: [2004c8fdb1b588188f6a17398782da4551f22be5]
stable/6.18: [c457824f76e95e10356c35c61ffc9d79b8c54228]
stable/6.6: [fc7675944ae787f4fb3cb0ba3db2447eb006d153]
stable/7.3: [78856ded7ec7995e8a05cdc9d08df4c5a62479aa]

CVE-2026-99604: drm/etnaviv: Flush the tile status cache through both
the PE and BLT

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99604

Introduced by commit f232d9e ("drm/etnaviv: fix TS cache flushing on
GPUs with BLT engine") in v5.7-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1a757f8df1363032623fa9b1baaba0dcf34de6d]
stable/5.10: [8623d20c840abfd41376a0331b6446d0d992d1ae]
stable/5.15: [6f564c7ccb8ba741ca1fb36cac1dabf288a4e0ce]
stable/6.1: [e28d6255bc236776011400dbfd3bd4e76202712e]
stable/6.12: [0abbe840a90d2cb568781fd031e514674c397cff]
stable/6.18: [8cd026a2cec3e4ceb4542ba443d9049724ae4a30]
stable/6.6: [50fc6899f1d66ce8b270e50168e02f58c12acedf]
stable/7.3: [e75d39dc2a4dbfa6064bd7e59e0cf5d3d1b89b6d]

CVE-2026-99605: drm/etnaviv: Fix NULL dereference on unbind without
PPU flop reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99605

Introduced by commit 85ba57a ("drm/etnaviv: Add PPU flop reset") in v7.0-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0560a12d8c1a03e925c5d9be8479da75663a40f]
stable/7.3: [1fc4d88bb5398d9687993220effd7d79364e7a13]

CVE-2026-99606: net/smc: don't spin in smc_rx_recvmsg() while a pipe
holds spliced data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99606

Introduced by commit 9014db2 ("smc: add support for splice()") in v4.18-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8288ba942cfd20621c05e16978b7c3da91513ae1]
stable/5.10: [bdb6d2e75fc4eeb5132ca6a7c61027709b4a0c5a]
stable/5.15: [6f9fffc0b39a972e6040f340fff63bcd39cc3389]
stable/6.1: [75197a9f79acb6be19088b01b1d6fb7785860ce1]
stable/6.12: [16bbd8c8381c01598ae91bc72e62f617353d9bd9]
stable/6.18: [f97e7bce1cb1f2c7fc3c0afb1818c7e568624ef7]
stable/6.6: [a16adc69aa7a6b94d2e08f6b61233a2abd0f9960]
stable/7.3: [883b66d11ee3ed89cc22599280d3c319cf38903f]

CVE-2026-99607: ext2: preserve IOMAP_F_DIRTY for extending direct writes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99607

Introduced by commit fb5de43 ("ext2: Move direct-io to use iomap") in v6.5-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f91b042af212ca0b610e43f9a975ddc7f0d0923]
stable/6.12: [45d79b40621212ae720d3712d36f31eb3ea1a2d5]
stable/6.18: [6a5200c0f46ab94d0c29ff9934c81d0de6f7b47a]
stable/6.6: [401e65a425ffc426346ea19d45e65998fe694bfb]
stable/7.3: [2e114662c376f5a5342f2f997c459971dbdf836b]

CVE-2026-99608: ALSA: usx2y: Guard the playback copy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99608

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2c6de52ffacb2c0f4076884ee3fdb744735a4cb]
stable/5.10: [bf8da18fce0c5a5281be4849c7706b17d490f37a]
stable/5.15: [df1f1a0c808f4ef43c4fdd03d7e79f062d46ebce]
stable/6.1: [3b75d7b1fd9f1f9b4f2f0dbe030c057a089fcaf9]
stable/6.12: [116f158a6f6820a93faa12d46d5a2956cae4e4d2]
stable/6.18: [38bb5df007a80f81861a79228f7dae29e4e263c6]
stable/6.6: [812873e093ab6557939348a9119c19fd1c057556]
stable/7.3: [deeccc01999ed8982507945e5ca750e75f0437dc]

CVE-2026-99609: ALSA: usx2y: Require a buffer of two URBs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99609

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cbb826b3b36df6c275454287ba1df4564a5370b]
stable/5.10: [eabdad84684dc5ad8ab7250ba98a95afd4172a4d]
stable/5.15: [2ae93a0781fc6855e9e3f9e4dd1a23b55f24040f]
stable/6.1: [8de4e8ea2b6b0648b3f7c765a9ebcfec4e23df9a]
stable/6.12: [44c6971a79efdb46cd5c9f492f0ad65aafe05add]
stable/6.18: [5356d89f5e581dc207c7a607fe585d3e1cb2471c]
stable/6.6: [0fd6e89b6f1f1ad746aa487a3360176ebdd4ad48]
stable/7.3: [824fdf771cb7cbe9ae50eaec588eaf1acee6da94]

CVE-2026-99610: ALSA: caiaq: free the EP4 URB when input setup fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99610

Introduced by commit 6da7a2a ("ALSA: usb/caiaq: Add support for
Traktor Kontrol X1") in v2.6.35-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d21746bafdb8e1a5fc9bdcb86f603d827a500a62]
stable/5.10: [35ec343eec7f0edc0c9ed21e4db45398a4a10517]
stable/5.15: [07e92793ea93792ba387458ad20d5579536dae70]
stable/6.1: [5ca98a93fcd799e33a4c2ad8f36f37eebc3994e7]
stable/6.12: [998f6dfb9b2ea14cad586417e23b6614a2c99fdc]
stable/6.18: [6f9cd0e44a576556c59e1591e4432d1e6768d088]
stable/6.6: [9caf28f7a675d023955a37ace020b2e64bfd693b]
stable/7.3: [5c1bbdfe5331b287c179fe118cb7e6db04c4032b]

CVE-2026-99611: ALSA: line6: Reject capture buffers smaller than two packets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99611

Introduced by commit 705ecec ("Staging: add line6 usb driver") in v2.6.30-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db51425c9eb038a8e40e09b837afde015ae9e3ec]
stable/5.10: [e5593f7cc02ce02e414df6afa8fb22ab471b15da]
stable/5.15: [31041d36272c74903c2edc79c709adacc3efc532]
stable/6.1: [78cf1c93eaa13f1cd4ebdfdcc3a410f63590c539]
stable/6.12: [3e7f477a9e56b627739832e6cf9b682693a474a9]
stable/6.18: [faf1f471319775e280d959ffbffaa44fd7e5f5b0]
stable/6.6: [ed4d8c52b322edf93113a6cd0234fe585d4d5b5e]
stable/7.3: [9885eaa2091335ed181c93f2b406604ee2bf2312]

CVE-2026-99612: ALSA: hda/tas2781: Only accept CRC-less V1 data if all
entries are valid

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99612

Introduced by commit 4082490 ("ALSA: hda/tas2781: Accept V1
calibration data without CRC") in v7.3-rc7.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [8dbab764f1e0a92c3fac0ce070ce30c0c33c2692]
stable/6.18: [de306e94be56201fab4bb763e4006f7630077708]
stable/7.3: [27ab1608f730961d21988e0f3bf03791982dfb9d]

CVE-2026-99613: ALSA: cs46xx: Handle SCB creation failures before dereferencing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99613

Introduced by commit 41116e9 ("ALSA: cs46xx - Fix suspend/resume with
new DSP") in v2.6.34-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [023d3e1176202339cd94a3d732e3aec74e36ba22]
stable/5.10: [96b5383b2f7e47ea2b06f1220355316d7bc8430e]
stable/5.15: [54c43fc838c304f76243b6ad00d57d81650e3bb8]
stable/6.1: [5e7adea96f2f3b77133edc9e63a5d9bd36aaaee2]
stable/6.12: [4deac108afeab21a5d53108bfb8548ea7c29fd69]
stable/6.18: [286e44e9abd59574f38236b4453069e225fcb071]
stable/6.6: [9802a09dd3f86ddb29a3da9fae96603ef98db7f3]
stable/7.3: [18b7342e7f67022b5c7b51d126550cc74add3e88]

CVE-2026-99614: drm/nouveau/nvkm: clear use.enabled when subdev init fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99614

Introduced by commit 8478cd5 ("drm/nouveau/nvkm: add locking to
subdev/engine init paths") in v6.2-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1f7f37417bacf2eaf80a8ce6b598b1fa56f8906]
stable/6.12: [58899bfd5cf688733c909adb6aa34929c44c8842]
stable/6.18: [8d642da3ec15d0c169948c0af60c6e94cf31a539]
stable/6.6: [4d81a0a292953fd4c8c24e9793b25d9bb82c3fa9]
stable/7.3: [765b4f3fe5003b91d8ad8a47a4d3f62dba5d9e3d]

CVE-2026-99615: l2tp: only return sessions of the given tunnel in
l2tp_session_get()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99615

Introduced by commit 5f77c18 ("l2tp: use IDR for all session lookups")
in v6.11-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a75facf4bb3e866103ddca4f47a6f3ca4b090d8b]
stable/6.12: [649d00a0e1ff2f5a4f5b8c194755f9b9bbd98504]
stable/6.18: [26cb789c98bdd4dcc2af6e083eeaa23c4d8715c4]
stable/7.3: [2dec8c5a6928f27a40e8880df2af3289693abbcd]

CVE-2026-99616: ovl: look up the index by the decoded origin

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99616

Introduced by commit f71bd9c ("ovl: decode indexed non-dir file
handles") in v4.16-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [520ef67f47f69255695859b0008281a384d0bc20]
stable/5.10: [39d1cd14ab2e7c7245dcb53d59b980df578da349]
stable/5.15: [d7bf8cda8c761c1fb8ae667637eb18d80906ec19]
stable/6.1: [73fbc5dade5624f4a4782fb9d0a93801c30a9ecf]
stable/6.12: [4b0d6c2bb0eadacecf35641cd63851d8406b22f2]
stable/6.18: [aae380322cf51c645448d7063888fb5d14df08cb]
stable/6.6: [54084b6bc625642674a16e786c8bf20c6b100c1a]
stable/7.3: [7cd237effa89a6bb59da3bc9f98c9823cf1429ba]

CVE-2026-99617: arm64: mm: validate /dev/mem mmap ranges without overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99617

Introduced by commit 1d18c47 ("arm64: MMU fault handling and page
table management") in v3.7-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0958b1397fb5ffdb995c0ccc74349841929c08d]
stable/5.10: [9ed663f51fa2d0a8a7c4754780809e35da7e5a41]
stable/5.15: [99abd25b9037219ef82c937ff5d1f7c35615bc89]
stable/6.1: [90ff5803ad3b85f1cfd07d427cc6b7d5f2d0d950]
stable/6.12: [db6607fd74263ead8df644b98ff25fac74d86f0e]
stable/6.18: [fddf55af2d078f4186c5ab4f07383c8599b14640]
stable/6.6: [bfcefa665475d737539dbecff57ab1749d81ab2e]
stable/7.3: [c9a54fc8147f45020badd9001d4ed234c74b9526]

CVE-2026-99618: nvmet: don't return memory contents beyond valid data
when reading ANA log page

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99618

Introduced by commit 72efd25 ("nvmet: add minimal ANA support") in v4.19-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29b8758b4700357909f06705a0c48c7a60c556d5]
stable/5.10: [03b6faca43bf208ee36a4d37aea427e7d4743bed]
stable/5.15: [67ba04a50383e987b6ded6ddcee81ba84f5a80c2]
stable/6.1: [c0936ade2fe0752b981d6e56a8fadee98658b540]
stable/6.12: [e129e8b31c8d8d4022d70627b42fae2b9af90a13]
stable/6.18: [65187c29bb45c967f79bccc5ba46479fd32195c0]
stable/6.6: [b58fda1c5f04d3f84c4932100b7696e7180afbcc]
stable/7.3: [73bbd572a0a8c05f38eb9f0d046c583ba7f62f15]

CVE-2026-99619: drm/amdgpu: don't drop the gang dependency fence twice

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99619

Introduced by commit ed21f6c ("drm/amdgpu: fix another missing fence
reference in the CS code") in v6.2-rc4.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d1f901a83603a7d314e4a756b416b11d8dc7e35]
stable/6.12: [2908ef768018ae2bd27eca6cbc79bcabd105a647]
stable/6.18: [162879c7258267c094f541314fac4133fa222f2d]
stable/6.6: [8d6ea1f6330558cda21354a32082759b049fd9a4]
stable/7.3: [9135c7b4666a8b49d1ef3d6a214a46e69eea2f2d]

CVE-2026-99620: drm/amdgpu: don't walk the CS chunks when allocating them failed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99620

Introduced by commit d38ceaf ("drm/amdgpu: add core driver (v4)") in v4.2-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ade92d50aad6799a5a9d7e73cd1604fd0576e656]
stable/5.10: [4cd5e39dd18a4ef6d13fd8ae6160e972f4687041]
stable/5.15: [ce3e5a3441483c6c435c9ff1f94f174a28c6b27c]
stable/6.1: [c30283492afb006b913410d01c5280d9eda866aa]
stable/6.12: [4a2f0b93077dc87f30ad73be8997761a71d124fc]
stable/6.18: [e3be92649ed377d41b1687a84139fc17f335c21f]
stable/6.6: [ff9e4a98f6e854963bd5ed80a5790450956711a5]
stable/7.3: [be90166ed3be02c13253f54ed2a8fe98a66cea30]

CVE-2026-99621: drm/amdgpu: unlock the VM and BO when attaching a KFD BO fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99621

Introduced by commit fd1fa48 ("drm/amdgpu: lock both VM and BO in
amdgpu_gem_object_open") in v7.0-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0a1404b34e0002f03f7979cdb791a9b5c3963f5]
stable/7.3: [1ae594845217ce740b27ec5a202e9e8cb144e0aa]

CVE-2026-99622: drm/amdgpu: drop the dma-buf reference when a KFD import fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99622

Introduced by commit 0e2e7c5 ("drm/amdgpu: Attach eviction fence on
alloc") in v6.7-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb900f8bfd8a16126affd186d21001e4c6533324]
stable/6.12: [a2654cbb6a2244d8200e0505612f03bf36af2908]
stable/6.18: [6f300412649edf42e0eb232334a84764cd945118]
stable/7.3: [1e65f78269a95052c2de91b4a14ee83f3e780828]

CVE-2026-99623: drm/amdgpu: Clamp the ATIF backlight curve to its 99 points

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99623

Introduced by commit f729e63 ("drm/amd: Pass luminance data to
amdgpu_dm_backlight_caps") in v6.15-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ba7655701c5cad5bfa043d464d1e24873e24aab]
stable/6.18: [d00442ef393bd725288514cabc2be4b5472195f4]
stable/7.3: [e36430fda69a3b6087bf57ab52f549deca531f3a]

CVE-2026-99624: drm/amdgpu: Report MES ring wait timeouts.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99624

Introduced by commit 34e087e ("drm/amdgpu/mes: fix mes ring buffer
overflow") in v6.12-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [122e864861144150e905012b5fb52e63ad5de68d]
stable/6.12: [2f51c5874db3b56c3f2562901fef0d1e9d694cd6]
stable/6.18: [ddef6bac4fccf6c531fb2281834603d76f5c00fc]
stable/7.3: [ee488777bde7f0e5b8e4f7fbc2dfe5db0c15aaaa]

CVE-2026-99625: drm/amdgpu: Fix duplicate dependency fence releases

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99625

Introduced by commit 41cc108 ("drm/amdgpu: fix missing dma_fence_put
in error path") in v6.2-rc4.
Introduced by commit c1c4a8b ("drm/amdgpu: grab extra fence reference
for drm_sched_job_add_dependency") in v6.2-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea47f84199241dd083d40a241beea665415d4f6c]
stable/6.12: [9ef784728cfbfcccfed5d3ea92f7861571efc064]
stable/6.18: [5d6e0c2dccf210838ed4eaf4d736a48532bf7bc5]
stable/6.6: [1ef3c576f552997990eaf9acf9fd5a9fc1f3ecfa]
stable/7.3: [4cb2aeb7f23d25b8349ee87048415818b94320ad]

CVE-2026-99626: drm/amd/display: Fix NULL deref in
dcn401_update_clocks_update_dtb_dto

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99626

Introduced by commit b6d5085 ("drm/amd/display: fix a crash when clock
source is reference for non otg master pipe") in v6.11-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7fac15d009cf236677a8cddf6bc0e8c85666ac3b]
stable/6.12: [135691aaf7a2846940928580ae80061f0efa99e7]
stable/6.18: [8f7b663d23f3b66c97afc5f8e36b63388322bc53]
stable/7.3: [7473715dcf76196d2242c1b19756a95c98ea21ba]

CVE-2026-99627: drm/amdgpu/gfx12: disallow GFXOFF while updating the SPM VMID

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99627

Introduced by commit 52cb80c ("drm/amdgpu: Add gfx v12_0 ip block
support (v6)") in v6.11-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1551515a3258b43cba60bd7f45bbdd1f4e9e60a]
stable/6.12: [117e6ac89e730d647aeaf53b77420efece331f4d]
stable/6.18: [cd38a2b45edf84324ee9572c09c279fd4ebec5fc]
stable/7.3: [374aba4bef461462a9640f8355ebff5d5021c459]

CVE-2026-99628: drm/amd/display: Avoid closing unowned DDC pins

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99628

According to the .vulnerable file, this bug was introduced by commit
4562236 in v4.15-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e7ba638b8116cb5f1a5690f543052371215f1626]
stable/5.10: [b6d5078f5ba1c2433cea9b0134f92376148e5f25]
stable/5.15: [8ca066b7633b918be5de4e440cd0e55e4219a6ca]
stable/6.1: [1fc6d6a885d615ff4ba459eecc06be63bd5e7b6c]
stable/6.12: [4c4688f7d1c0ea08ea2b746561505bb9e487644e]
stable/6.18: [5605c171019d14a12327bf41dee7d0851ce2036c]
stable/6.6: [ce411b0e7ca0fd191560daee0dbc1564edf935d9]
stable/7.3: [41b495570564857a74626a527efef541e0af5fa1]

CVE-2026-99629: drm/amdgpu: clear RB_OVERFLOW bit when enabling
interrupts for navi10_ih

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99629

According to the .vulnerable file, this bug was introduced by commit
0a5b8c7 in v5.3-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [146b96974b33b8cca52755ffed3cd24a82836013]
stable/5.15: [ddcd0b6164f1b6920764ec1d401583d563c49a80]
stable/6.1: [946ed5237b226d2bc31843e158b6ddfb912e80d1]
stable/6.12: [53f0c61efb5ff1f203659f3ebb8ccacc39ae28bd]
stable/6.18: [00ae61183bff39238018de3db81d835d87618b42]
stable/6.6: [895c70a32cc38b051411588b7b286284a3fdb988]
stable/7.3: [d7a7d21bebae5e2bf6f0b89d3dd6828de46c8614]

CVE-2026-99630: drm/amdgpu/userq: validate the moved individual BOs on restore

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99630

Introduced by commit 4cdbba5 ("drm/amdgpu: restructure VM state
machine v4") in v7.2-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce5f2a25bdf6b2bccfc4ffb5e4c5f12e97eeace1]
stable/7.3: [2664f497d5e35384736e42fc59e5b9ef27ca791a]

CVE-2026-99631: drm/amdgpu: check amdgpu_vm_ready() in dma-buf move notify

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99631

Introduced by commit aa5fc43 ("drm/amdgpu: fix task hang from failed
job submission during process kill") in v6.17-rc2.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [920ca822f527e45ce084b36f3c420b625eb7c62a]
stable/6.18: [357f2a753287d878ba13d49248c55343bb5e0090]
stable/7.3: [d534c4d5d99c079e760b5d38b1f1813ea81292ea]

CVE-2026-99632: drm/amdkfd: use the queue's process info for the WPTR
BO eviction fence

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99632

Introduced by commit 7f347e3 ("drm/amdkfd: Fix NULL pointer error for
GC 11.0.1 on mGPU") in v6.3-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da2897ee8b811945fd40ecc4aaf03291c14ce61c]
stable/6.1: [d4520fa08717b018cc7802f549832249235353a5]
stable/6.12: [70ea9ed012b756fac5909e0d6be530731dc1e484]
stable/6.18: [c964cd06eb35d2ca2d9b49a7423b5d5cd01441c0]
stable/6.6: [bd2eef06c2daa634877a47508bb6834987f0a5f4]
stable/7.3: [3044e6e19f5746d2c279d0105fd61e759bcb42b3]

CVE-2026-99633: drm/amdgpu: keep the CS user fence BO in GTT

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99633

According to the .vulnerable file, this bug was introduced by commit
1ea863f in v4.6-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a56d929dc2304edaa6231e1eb5eb82b7e8b74a9]
stable/5.10: [1a986bea283c22398fdc08cdb7b0fd674829fb2e]
stable/5.15: [32de880a6d81ecd6a4c9cce3a96ae88aa60a6cdb]
stable/6.1: [de2887eb1c72060895a533af9e19bed9982e953c]
stable/6.12: [b4a1229ab05f0ba7fa1a52032686e32e801fcc04]
stable/6.18: [69a46cbe11b6eb15f6d48591a67217ac634ddc3d]
stable/6.6: [4ec2fa9f4e09610028f1f571fcb1f515cafd3306]
stable/7.3: [2c7bd4568f5d19d63241ccdf930b15e619af7c2b]

CVE-2026-99634: mptcp: do not use Fast Open on MP_JOIN subflows

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99634

Introduced by commit 90bf451 ("mptcp: add new sock flag to deal with
join subflows") in v5.8-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d2cf411aba2aa0bd641b49be5b1964ac5097a50]
stable/6.12: [763e4792e46965adf2f0598cec03c97ae8d384f6]
stable/6.18: [3cb3b9f66a7feb13ba320757178d4cc2bd570102]
stable/6.6: [b465cec8c8de5f0653505eead8cc02f64a58ecc8]
stable/7.3: [d6c89cdb5d2a242940caaddc45acce1e6bfdc967]

CVE-2026-99635: vhost/vsock: size receive SKBs from declared payload

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99635

Introduced by commit 71dc9ec ("virtio/vsock: replace virtio_vsock_pkt
with sk_buff") in v6.3-rc1.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [d5e912448cd98b261eba8e35ab838f2dc69a79f5]
stable/6.1: [e07161f8d1d73a2b66ec24b9ac623d500bb9f006]
stable/6.12: [92ac18f7de67c7cb35b71e9872b08fb9ba9a6bf8]
stable/6.18: [89a2f2251a06751ddabbd6a39c207236b8bd42d5]
stable/6.6: [88910e2a8c690589e29a7b344554595d195ec9b5]
stable/7.3: [9819add3aeb66dc823db0a82337f55481ad463be]

CVE-2026-99636: net: reject a negative TCP header offset in
qdisc_pkt_len_segs_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99636

Introduced by commit 7fb4c19 ("net: pull headers in
qdisc_pkt_len_segs_init()") in v7.1-rc1.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [35d2d6e5ac0d22428b2a0216061f3330c095393c]
stable/6.12: [d88be0067857b68df06a33cc056c9f05101c09d4]
stable/6.6: [93c181f2d0e08c35be9be37db1722c1aae60ee95]
stable/7.3: [765af9e95c840fcbbecf34ca1e787daba8eac569]

CVE-2026-99637: ovl: inherit FMODE_NONOTIFY when opening directory realfiles

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99637

Introduced by commit 130fdbc ("ovl: pass correct flags for opening
real directory") in v5.8-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [323899b4ed233d5b6e2fc160c16fbf39cf0317da]
stable/5.10: [09eb00634387f24d42f96dcb5a2f9b566185d68c]
stable/5.15: [f9589ab7e895998c6e3b4a2b71acebdc3156c329]
stable/6.1: [3d9763c9de7871372d8eb3bad2f852574bda8f9f]
stable/6.12: [96e109ae697eb1b14e5f28ecc00312e023ae5775]
stable/6.18: [59290a9eb2988bea24cc18ace316ee28c9f51138]
stable/6.6: [628e3fb65f8bed95638c9359f280c57a1ce15200]
stable/7.3: [c3ccfbb2acb259b5d3d030fdb63d3cf96de33330]

CVE-2026-99638: net/sched: clamp skb->queue_mapping before indexing the tx queue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99638

Introduced by commit 74e31ca ("bpf: add skb->queue_mapping write
access from tc clsact") in v5.1-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f19f2b308beb158d0e6f6eb806ced636e4ebf6ce]
stable/5.10: [8378f8af694bbebb8aeb8f6b5ee85d8776deb91a]
stable/5.15: [9d102a396aec33bdf4c1e92e0818e2bbdf5b0221]
stable/6.1: [542f917040437eef76fd45df57874541b5dd2e01]
stable/6.12: [8182ba13500b39d75b66fe9f37e13cb325c4b17e]
stable/6.18: [7445eccce376f7adb876c9f466d7d893344af7ce]
stable/6.6: [4697611292458bc7ded42f50ab649d6d5dd68710]
stable/7.3: [7327092a678bfcb1bae033acb1be1006a1399e30]

CVE-2026-99639: ovl: fix whiteout creation in casefolded directories

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99639

Introduced by commit 833d2b3 ("Add start_renaming_two_dentries()") in v6.19-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e803c82dcdd15e87b48fca1ea8d2cfe6a7ed83d4]
stable/7.3: [48bd1823237fb076db6e109e35c59b1bc08f550a]

CVE-2026-99640: ovl: do not let chattr change the casefold flag

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99640

Introduced by commit 083957f ("ovl: support layers on case-folding
capable filesystems") in v6.17-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83b351c3ade542bbfa1073e8c2d919826628252a]
stable/6.18: [ba93074fc1ae11a6c33bb2752ccae6304ab1668e]
stable/7.3: [0f21cfc2a16f79b52cae10649b0f001fe6ffbf9d]

CVE-2026-99641: ovl: fail the mount if the casefold flag has changed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99641

Introduced by commit f9377fa ("ovl: Add S_CASEFOLD as part of the
inode flag to be copied") in v6.18-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c782fc8ada811569811c0fdea5c3412511be95d0]
stable/6.18: [f182e7bc11c401d09f890ee1a3ec359670e1e308]
stable/7.3: [549fb7c77951ad9ddfed05ce1776f497538ad13e]

CVE-2026-99642: mm/gup: check folio->mapping under folio lock in
memfd_pin_folios()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99642

Introduced by commit 89c1905 ("mm/gup: introduce memfd_pin_folios()
for pinning memfd folios") in v6.11-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71555ae8c7572fd99158013ca2e29187c5d2508d]
stable/6.12: [240bc9b873d3522672db13ea93ec73b7f0461912]
stable/6.18: [4480eb27975b91a28bc058a2ca16f466ebd9d7cd]
stable/7.3: [6ac69b444b85d0e511d9bc15f586ebeed49322fa]

CVE-2026-99643: khugepaged: fix readahead lock inversion in collapse_file()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99643

Introduced by commit 730633f ("mm: Protect operations adding pages to
page cache with invalidate_lock") in v5.15-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eadce52a9ef657d561b3e76c9b5f178bd99735f5]
stable/6.12: [8a82f4c7658c221fd45509c44fd1df152b24e27d]
stable/6.18: [fb558d0a6a0c0f650327fbaf1876697c7f668e04]
stable/7.3: [b9b3c367faf1929fb8192a846b3604ad7eced008]

CVE-2026-99644: mm/memory-tiers: unregister empty tiers outside memory_tier_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99644

Introduced by commit 9832fb8 ("mm/demotion: expose memory tier details
via sysfs") in v6.1-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [500624f28eca441e35f978979ccfb373202fefd3]
stable/6.1: [f46708be38c3dba2d7f15a153ebb468e17d11652]
stable/6.12: [b93a1f2c709ca410dda586cf57500c6a8bce3c7c]
stable/6.18: [d2e234d06d77fdaf8a7c1c2fd4effac861b8c9ec]
stable/6.6: [4bbe0324ed925f55374dde24f27ac991c7d30c1f]
stable/7.3: [c6b97a2688e01a6bd323a7d7db1566e7bbc0b424]

CVE-2026-99645: mm/cma: don't release CMA pages still in use

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99645

Introduced by commit 9bda131 ("mm: cma: add
cma_alloc_frozen{_compound}()") in v7.0-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8abc61d8a549a91c8fa639f68be2ef13d5fa63b]
stable/7.3: [485214cc031771fdbd5829b431f4f115e285dc21]

CVE-2026-99646: mm/vma: don't leak the charge for stack growth

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99646

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1ee87802111156e27557e82acc31fa7dfc76e2a]
stable/5.10: [08cfcd65512b2453e3d099614c7064e2cc38fc7a]
stable/5.15: [22cd64e894a4a4e601872d0d4086c22d024d1c74]
stable/6.1: [0101492cbc5df34c25ade08a9f3a481fba4c15bb]
stable/6.12: [4683258334ba6e839c08bf6e9d5a9dc44b078d56]
stable/6.18: [abb98f1c414f1b337eefa6d815b0eb8a9b5ba8d3]
stable/6.6: [bbe903084b7dfdce65c605f94dc298c7eaaa9d9f]
stable/7.3: [1dd99ffea63f3ef82fda213beb3b9b2f9dc41674]

CVE-2026-99647: mm/huge_memory: split huge PUDs when adjusting VMA boundaries

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99647

Introduced by commit f9e54c3 ("vfio/pci: implement huge_fault
support") in v6.12-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23e570927421d569fdc510d5f3f29542a43eeda5]
stable/6.12: [bd918ee291da2d76dd03b5f9c2c2e550095ab538]
stable/6.18: [605ebb555bc8695b309dcd462be6c1437ef98421]
stable/7.3: [4636bc02303032f20710d97f40adb8f4eed22a66]

CVE-2026-99648: mm/vma: call ->may_split() before a partial merge

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99648

Introduced by commit 38607c6 ("fs/dax: properly refcount fs dax
pages") in v6.15-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0193e83368022a308d19ee0293f55a4f5d548e40]
stable/6.18: [f437fcb76d448a396940498aba278ac0ad8d715a]
stable/7.3: [456932cdc6eda70b5ad4c628556098846699ab03]

CVE-2026-99649: mm/ksm: check large swap-cache folios before mapping them

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99649

Introduced by commit f1879e8 ("mm, swap: never bypass the swap cache
even for SWP_SYNCHRONOUS_IO") in v7.0-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f2c000ffb1047b476cbf267f741272c389d3e31]
stable/7.3: [cc4b71683ee9d8d4ed0b25c0744314005fb3e395]

CVE-2026-99650: mm/ksm: fix use of a freed anon_vma at swap-in

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99650

Introduced by commit ba6f0ff ("ksm: fix ksm swapin time optimization")
in v2.6.36-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c2dec1dce368ad9e9b1814307cb5ef3832fa07e]
stable/5.10: [74a05dab72662bd27ade63f6f44a2ea714815de7]
stable/5.15: [27e31a508e4f21f2e1bbb54f8994b235fd3ee2ea]
stable/6.1: [21cc8f704b6aed33175ae22a4c467c5e8e2bdd9e]
stable/6.12: [daa1e227f972f64a8468aa0101170fadb93ab552]
stable/6.18: [97ce258daffd374f5403641ca892f95e31769dbb]
stable/6.6: [d25821a954382d13a5dd770ee5215729e8d274d7]
stable/7.3: [85260730efefc48111603fa865d224bae1f5447a]

CVE-2026-99651: mm/ksm: reset the unstable trees of all nodes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99651

Introduced by commit ef53d16 ("ksm: allocate roots when needed") in v3.9-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [890e118e95bfc2aae4432ec2a95192d6f9193211]
stable/5.10: [28f9a1c759fcf26383707fff784550d14420a72c]
stable/5.15: [2cdc31f57af276e7f133fe1a7d0d6af12dfd192f]
stable/6.1: [431012d95a7a4cd1dfe535d8c18c5de2e085bf01]
stable/6.12: [7e5793cedeb444dc96b3b90e799d16f2f55d51b3]
stable/6.18: [1e59e96a064a6ca44e6fccb7a21f21d41614ff03]
stable/6.6: [07067f250a267471c10133186c7f56e2ea46f864]
stable/7.3: [31a2ba635adae60d23f744db2fef7ad318cdafa1]

CVE-2026-99652: mm: fix deadlock of mremap() against UFFDIO_MOVE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99652

Introduced by commit 867a43a ("userfaultfd: use per-vma locks in
userfaultfd operations") in v6.9-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d03df42ddae196f20e9cfb775704e60269eb6b44]
stable/6.18: [1acdf007989ffe56af434998f0d330e8473d1b07]
stable/7.3: [3627d4eaa7f4426b979d497544ce23cb8884134b]

CVE-2026-99653: mm: fix unkillable fault loop on MAP_DROPPABLE memory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99653

Introduced by commit 9651fce ("mm: add MAP_DROPPABLE for designating
always lazily freeable mappings") in v6.11-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f02ca8c15a74bc9e4e8e05ec089f63cb87cbf75]
stable/6.12: [f8ed1ee3f590555be7cdbaeaa5b349eb9c95ba94]
stable/6.18: [76ae1564e4c77d0ade4f533ac6de4fe1eb6d7e7f]
stable/7.3: [a9756f83b8a84b1f50c6af48aeabe9eb6429bcb1]

CVE-2026-99654: mm: fix unmap_mapping_range() beyond 4 GiB on 32-bit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99654

Introduced by commit 9eab042 ("mm: fix unmap_mapping_range high bits
shift bug") in v6.7.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [7a81bc23dade8082187be6d9cc36e4be4b7207e2]
stable/5.10: [aeaa0d4e301c5d2d97ba40603f899abe4e118572]
stable/5.15: [273121718c4c79ac0dd044d5f7998f21854b7cd6]
stable/6.1: [aff28bb139a69437922311e4078f77dc92d54831]
stable/6.12: [cbf6c66a2ef46433092b41b87176755de32bf65b]
stable/6.18: [0cf8d3fdd869fe079e55f8e621e45397a819d93c]
stable/6.6: [119bb87a630d25d61ed77738c73a4ba743f8e410]
stable/7.3: [67e6d5468a7d693a00176713d44267e5360d63c3]

CVE-2026-99655: mm/memory: reject remote COW faults on PFN mappings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99655

Introduced by commit 6aab341 ("mm: re-architect the VM_UNPAGED logic")
in v2.6.20.16.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8db6921cc07b74197a3866d62ed262b68aeadcf3]
stable/5.10: [ccc4249323a503d4a6331351287155c30417b33d]
stable/5.15: [5ca21505f1ff5f7b798b5e6a9695b1fee7d67d94]
stable/6.1: [ae33e75094c8b924da0fc487e76c4fcd9bd20004]
stable/6.12: [dd273e2d8d20f681a0147f13c12a1eb748fb9621]
stable/6.18: [27b2e29733a837552f0f31370e9066fa28466353]
stable/6.6: [8b7eebc64b4e01cdfb610c3c3da0e494872abfa8]
stable/7.3: [649937cf1df6c70b8e5b0cd13a34945c547235d1]

CVE-2026-99656: mm/madvise: fix data loss from MADV_FREE on a KSM page

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99656

Introduced by commit 854e9ed ("mm: support madvise(MADV_FREE)") in v4.5-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22d043c1da48d6c7274f9dd900714b6d58b7b9c6]
stable/5.10: [8ddaea0ff2e9ed916fd47d355e673b76dd2ba362]
stable/5.15: [fb10875cfa95eb828ccdb3a4d69ffa00d30498df]
stable/6.1: [ec9bd88393c6c5fb5856058867dcbe780d1c3912]
stable/6.12: [af2feafb0437fab5ed9d02eeb1c06ef66e05c55a]
stable/6.18: [8b6860f17b4de23a0b19045c066dc0679e50f0ba]
stable/6.6: [6769efa0e45c61cfa2853d7b8d3760ce66e7c973]
stable/7.3: [64f273b71bf714dd22b803a87d65bb40faaffcad]

CVE-2026-99657: mm/mmu_notifier: set ->mm only after mmgrab()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99657

Introduced by commit 3506ff6 ("drm/radeon: use
mmu_interval_notifier_insert") in v5.5-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ad9e4b0f1104f5dbfb41125c34bb30ea6dc7a94]
stable/5.10: [61bc907ff3fb703484239e963198a66988351877]
stable/5.15: [1dab01f19b76a8e354c2c06800882027ffa6f7c3]
stable/6.1: [b6b43bf9d25a459e3ec9993f05c7c9b1796622db]
stable/6.12: [fe3b7bf598ba708431d531cfbb1035b8a463eed9]
stable/6.18: [3df451b65b6bc342d9291b1132baf4a4dd3a7b63]
stable/6.6: [87e71f7808952b09f0b85e72d58f6dc7fac3efb7]
stable/7.3: [0d9450d006506d2af7016afd435b9c1a24985d02]

CVE-2026-99658: mm/mmu_notifier: finish non-blocking interval
invalidation on error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99658

Introduced by commit 99cb252 ("mm/mmu_notifier: add an interval tree
notifier") in v5.5-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d65925777ecae9d7a571a327e41c63f3940a0c7]
stable/5.10: [ae55bb60306c9aed7205886f594b2ebc2fddf3fe]
stable/5.15: [466869473707e14c8404a0e19dcf956b44173bea]
stable/6.1: [2f0322e263ff009933bf3215051f2a4b1babb102]
stable/6.12: [01ce779d7e598aafd3a02059d100ce66c909bea2]
stable/6.18: [00936003341fdb8c526652a9b84f99124616efb9]
stable/6.6: [cb8f6eef819a210e8fce3a12303004e88bd3dffc]
stable/7.3: [9439da3fa1ac9a7bdc4a2d3729a5bd0c2660c1b9]

CVE-2026-99659: mm/mmu_gather: fix flushing ranges with 4 GiB or larger

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99659

Introduced by commit b528e4b ("mm/hugetlb: add
tlb_remove_hugetlb_entry for handling hugetlb pages") in v4.10-rc1.
Introduced by commit 8ce720d ("mm/hugetlb: fix excessive IPI
broadcasts when unsharing PMD tables using mmu_gather") in v6.19-rc7.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [64ae7959a1df8af8eec504e31df2ec9670424a4e]
stable/5.10: [b0f998ce242e2c310f69e55018639f3b8cc727fd]
stable/5.15: [b263e5ef0456a83568e5f6fd6f4d846403e61520]
stable/6.1: [1fe9a6e2f1d0ce99bb71c8fe7b00e1ad7c551583]
stable/6.12: [da895690b531ba3905c69bd2ed1c447dafa7b4ce]
stable/6.18: [2e12a0d8fa2ea4af9a74f414063359d965784919]
stable/6.6: [28aa2e9f4ab62c66a1b872730b5e6441b40d9b60]
stable/7.3: [3647c49f164004458b5e767deed033bc13a25a2d]

CVE-2026-99660: mm/userfaultfd: write-lock the VMA before waking
waiters when unregistering

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99660

Introduced by commit 29a22b9 ("mm: handle userfaults under VMA lock")
in v6.6-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35f7ecd55ce7e51cb6d5ef49e6dd51f3c80f61e4]
stable/6.12: [2c944974df4faa1428ef84c6eddc7c03386c6b3a]
stable/6.18: [6668c5ad02321817eea9be3481a4eed74f1f6199]
stable/6.6: [f14e717c3fa9bfb7ec7b364eae1388b931864b2e]
stable/7.3: [8a47f699a5c184071bb1dc52f08f98c85bfb85a3]

CVE-2026-99661: mm/gup: check for overflow when converting nr_pages to
bytes in GUP-fast

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99661

Introduced by commit c28b1fc ("mm/gup: reorganize
internal_get_user_pages_fast()") in v5.11-rc1.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [21a3888d3d2f87b7f15ccea1f0befd57346fe899]
stable/5.10: [b83b181b1232f950c2c8789d8d877f776c56cd27]
stable/5.15: [4609adbe69a1604a015def7458bda9b3bf332400]
stable/6.1: [b087093ed2b817ad56c9db1ab104e85c2cea8c29]
stable/6.12: [89eed2a8f389d09d75d90633d879e0f5825f9376]
stable/6.18: [666516c935a353eda4dd43fbbd063d39b7f743bb]
stable/6.6: [6e97f285bc3f914047d57267f735cd999a2b8c8e]
stable/7.3: [063cd7c398fb837d811a72e19a6f71df9f104d9b]

CVE-2026-99662: mm/gup: fix out-of-bounds write for nr_pages == 0 in GUP-fast

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99662

Introduced by commit c28b1fc ("mm/gup: reorganize
internal_get_user_pages_fast()") in v5.11-rc1.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [1dfe4b276c23189394afb42d114ee8a54cc3aff2]
stable/5.10: [0452d6d24ee4d65226824bcbefaf187707b72ced]
stable/5.15: [6ac370032a68a343be599d8476ded2c36b43b53a]
stable/6.1: [21854ef8dc4e9398d84e4129db52dad69622fd9b]
stable/6.12: [11536b9b6bed3cc4d684a70d468493775e7d1d48]
stable/6.18: [0794c5809fa6322e8b43b70601700fd6c48e69ea]
stable/6.6: [32717a0763b2170eae5693fe4afbeecaa168ffdc]
stable/7.3: [5697a3b58722b15fcb06fb30368ce9f46458a95a]

CVE-2026-99663: mm/gup: fix clearing folios in memfd_pin_folios()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99663

Introduced by commit 89c1905 ("mm/gup: introduce memfd_pin_folios()
for pinning memfd folios") in v6.11-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c83ee2fa5a94edb2e04102b9dd4f1ee0eeb2b932]
stable/6.12: [9b9c506018859bb33f01e4b9df213d41b9ca4cc2]
stable/6.18: [d56f6835532c59b1b5e2d43f373f31586e7e457f]
stable/7.3: [65f4a8ef0adf18601c6ddbfd0e3918afffaeb890]

CVE-2026-99664: mm/gup: recheck the PUD under PTL in follow_pud_mask()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99664

Introduced by commit 1b16761 ("mm/gup: handle huge pud for
follow_pud_mask()") in v6.10-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79cb51d538abc459f74e046d27797d36b133ce0e]
stable/6.18: [da57b6bce646946c083a48df644d43bb9d011f5f]
stable/7.3: [9eaedd598cd25eb0e18958e2456153a4c1f3db03]

CVE-2026-99665: mm/khugepaged: preserve dirty bits when collapsing
PTE-mapped THPs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99665

Introduced by commit 27e1f82 ("khugepaged: enable collapse pmd for
pte-mapped THP") in v5.4-rc1.
Introduced by commit 1b64443 ("mm/khugepaged: enable clean pagecache
folio collapse for writable files") in v7.2-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe2817e3d5ea347214342c9a5cd8bcbff20c0574]
stable/6.18: [0af947ae4d91af0c6e9573220a1298cd8302b6c3]
stable/7.3: [1f54708f40b8dea6951426ca567fc96160693388]

CVE-2026-99666: mm/khugepaged: fix PMD table lock leak in
try_collapse_pte_mapped_thp()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99666

Introduced by commit 6375e95 ("mm: pgtable: reclaim empty PTE page in
madvise(MADV_DONTNEED)") in v6.14-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db38b902307e687219ec765ef51a6ef459746c87]
stable/6.18: [7c1170ce1b74a8cd83da2174a3eb9e0755bb1b16]
stable/7.3: [ad5e5800ce560759c8d3c10aac15b48a06cd21c1]

CVE-2026-99667: mm/khugepaged: always recheck the pmd in
try_collapse_pte_mapped_thp()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99667

Introduced by commit 6375e95 ("mm: pgtable: reclaim empty PTE page in
madvise(MADV_DONTNEED)") in v6.14-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa72cf34d90da7019591ab67533a8ece8b41da2d]
stable/6.18: [3f6b29ecde19cab035f59b65012bc9de9a45eccc]
stable/7.3: [9c766a46421509d5a2f46753be3964ae128bf938]

CVE-2026-99668: mm/huge_memory: fix zapping migration entries for
device-private THPs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99668

Introduced by commit 368076f ("mm/huge_memory: add device-private THP
support to PMD operations") in v6.19-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63a940541358d09cc9f02d40b71eb8d3917a21c0]
stable/7.3: [2d7e94a16d0d33ce2cce5ea06cf61079c392d351]

CVE-2026-99669: mm/huge_memory: fix truncate racing with PMD zapping

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99669

Introduced by commit fe6cf98 ("mm/huge_memory: transfer the pmd dirty
bit to the folio on zap") in v7.3-rc2.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [e6a07d29b0a60f3a4cfe77fe34eeb4b3fb38d6c4]
stable/5.10: [37a32c760eb709440bb9cd6cd6852022850a542b]
stable/5.15: [664d37982d094623f5c3ac0373d3751401b10020]
stable/6.1: [b72f49d669840a87d0a811b3f16e14fe597fc3ce]
stable/6.12: [e80c3d6e1dc80bae76471ea5b10bf625168f14c6]
stable/6.18: [d08f371175e5ad3bea97983ef446e416e4fb32e2]
stable/6.6: [df588ea0cf5dce9ee7cc1689e40a6940dc25429a]
stable/7.3: [a5786ec7ba7967433207f20214ff75768497a2c9]

CVE-2026-99670: can: dev: can_fill_info(): don't wake up controller if
interface is down

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99670

Introduced by commit ec56acf ("can: flexcan:
flexcan_get_berr_counter(): switch on clocks before accessing ecr
register") in v3.18-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75332c410c8190d61499001c5516af977ca426c3]
stable/5.10: [ff9776f252168e7c06f8b7bf5b23730dd15ae65e]
stable/5.15: [2c0f27f5a3175cba269b552283f8429fe18bba15]
stable/6.1: [e7f62b7a9592f4eb2723c23ad69acb3fc3a17a28]
stable/6.12: [d2fd689214afa0a983f4f0833075f167b9f4eddf]
stable/6.18: [07521636bb0cfeccb44125a7fc39ee97c36d2e37]
stable/6.6: [5715bdda4e192fff91f2bd09f35be39f8d62c772]
stable/7.3: [0a6f6dcf4c9c03c74de17453bef21697cbff4dc3]

CVE-2026-99671: can: raw, isotp: copy socket options outside of lock_sock()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99671

Introduced by commit c18ce10 ("[CAN]: Add raw protocol") in v2.6.25-rc1.
Introduced by commit 1e5185c ("can: raw: add locking for raw flags
bitfield") in v7.2-rc4.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [43c973a0887d3d7b2ee0a446603c97bf0f38c58e]
stable/5.10: [0ad1f126e04fc19898de9577a01d41b1a02d37cd]
stable/5.15: [61f76d2a9244e103f4eb749e0b001bf9ac5ecec2]
stable/6.1: [6f65cb2f1ea02dde496955f92ea057573f9ac8b4]
stable/6.12: [ecc81d48ae70513db45de567ae164a1993b792c5]
stable/6.18: [233eb0922c17063911dd4e947ef91ef5125b9665]
stable/6.6: [b6ebfbdf543c2155adc7924d9afb1c8e47472459]
stable/7.3: [12b2ddd7d01b7e5ec466c128ff862197d59c2440]

CVE-2026-99672: can: protect the receive lists with a per-device lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99672

Introduced by commit 20bab8b ("can: isotp: fix use-after-free race
with concurrent NETDEV_UNREGISTER") in v7.2-rc4.
Introduced by commit 8e8cda6 ("can: initial support for network
namespaces") in v4.12-rc1.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [0f3ad9ab40e3dad06d5c0693806e07935ceedbc3]
stable/5.10: [c91b7a021f4c407198bcc0da44125e8a1649ad41]
stable/5.15: [dbf57b99e1fc43679d3e3ba6aacb1a9858462302]
stable/6.1: [3fcffe9ef1e900d8551a5872fee9efd8c67785f5]
stable/6.12: [59d91f555ada337458c48316987b8ef46487f885]
stable/6.18: [4b625dde57c0a40a933bf017ff93a64a7306aa43]
stable/6.6: [af23b302ffe575b74d1fab0fae8fe5c605f4952e]
stable/7.3: [228e795ec650c33ebbce8ba81ce983c84d64d889]

CVE-2026-99673: can: replace ARPHRD_CAN type checks with can_get_ml_priv()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99673

Introduced by commit 4e096a1 ("net: introduce CAN specific pointer in
the struct net_device") in v5.12-rc1.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [962947b69589881167054bae5accc8abfd5aa4b6]
stable/5.10: [e7f686bf1dd85c2c128591052268df897d514fd2]
stable/5.15: [7678720471f4e1812c2a2d8ac81a6b8b0518d647]
stable/6.1: [34a6f32b778f8fb3c2b8e3e4bf1db7aefc4d53fc]
stable/6.12: [c693cbfbc2ad5ab159c671c58f285aa3d4d8a98b]
stable/6.18: [f4910431fdf7b2800f0bec9f161900511f9a8bcd]
stable/6.6: [de3e876a2081b7fe051ffdff6a6703ee77ec2599]
stable/7.3: [27edc672a80ae9d5e7e8aa0cc8f5e3ed2b5dab19]

CVE-2026-99674: can: dev: can_dropped_invalid_skb: drop CAN XL frames
on non-CAN XL devices

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99674

Introduced by commit fb08cba ("can: canxl: update CAN infrastructure
for CAN XL frames") in v6.1-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0fce44e29fce4b07642491b098afb41bd571e4f2]
stable/6.1: [3b9a1de970054b31958cefc3ac870ce9be00a37f]
stable/6.12: [2980a293b4d210ca7cfa89f7d4a9bab4f50ecc19]
stable/6.18: [561e44524ef1e0b62675b75c1fc57997ee49431d]
stable/6.6: [cf888ce290b79831a6029860d772fd128bc798f6]
stable/7.3: [2de9c3df452e159f82ef14ca497e5be407c66493]

CVE-2026-99675: nvmet: reject keep-alive timeouts that would overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99675

Introduced by commit a07b497 ("nvmet: add a generic NVMe target") in v4.8-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96ae13f40ce5930cd58c43128e385131476f2a66]
stable/5.10: [a830d5d3df6045e8163b581f7240a6d55c07b9c5]
stable/5.15: [5cd79a60cce6bd1f85da0046fb9b7b836a4acc3e]
stable/6.1: [aad973085ada67e277be338f1f01955f7e4e2800]
stable/6.12: [67976264ee861b2010b2a7195380adf78d59b017]
stable/6.18: [69d4f0ace16c7ff00ff525152aed1383f82b1192]
stable/6.6: [d33ba565748515e8358783e948fd2f7ec2f59a9a]
stable/7.3: [884b47ced96c01e2689ee45dc42902d888c4b7f2]

CVE-2026-99676: net: restore refcount ordering for lockless socket access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99676

Introduced by commit fb041bb ("locking/refcount: Consolidate
implementations of refcount_t") in v5.5-rc1.
Introduced by commit 27e5203 ("bpf: Change bpf_sk_assign to accept
ARG_PTR_TO_BTF_ID_SOCK_COMMON") in v5.10-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b5d8f351dd96f56a58bb516a80e2d4d742fe4e2]
stable/6.12: [6f4fc93f76cd8ebd3c89a064573715503048d1ad]
stable/6.18: [ddd14d0b5b5e650077779d9a158cb7a80ee8297b]
stable/7.3: [52f5a5ab318f5b120eb686069fbd0108016c02b2]

CVE-2026-99677: xfs: clamp the pNFS layout range to the maximum file size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99677

Introduced by commit 5278511 ("xfs: implement pNFS export operations")
in v4.0-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29f3c1be4e554c9dbc66e13333034e0947477cb6]
stable/5.10: [7d1a420f9cec55eb76310cb4d4c5fbd76358d4c4]
stable/5.15: [bddce9ea41ffab37e71b7a668eceed515a3c4b3d]
stable/6.1: [26658a10a18cd59f1f270e4fe3b30165a187f8e3]
stable/6.12: [df8632f36be4693677c18966319ae546b4341061]
stable/6.18: [8e0cea93da8755cfebe9a0ea7e2b37e68d59118d]
stable/6.6: [d892672cb91a831de7e4059bf9a15f4ce56333ab]
stable/7.3: [e8c7a13a7b63542753ab3c6c55b142b09d207c78]

CVE-2026-99678: xfs: cap the block count of xfs_iomap_write_direct()
at one extent

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99678

Introduced by commit 5278511 ("xfs: implement pNFS export operations")
in v4.0-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66d1ce09ebd72709f8d739630c39f440445173fd]
stable/5.10: [a5d7ce30a20abcb1149a793879ac645547c9162d]
stable/5.15: [7c69fa22f36f44eb4dc367b915bb6b06e1f60c42]
stable/6.1: [dbee0c8c244bbe00dbf4da145609de82c2758dc5]
stable/6.12: [7f4972601b3faa66524e44df9e929fd491e35bfd]
stable/6.18: [73b0f3d5201f741125061d8559e9631f1af4cb39]
stable/6.6: [ade881e5fd44b8993c1371bbd8e2ea7f207e5251]
stable/7.3: [83e0edb26d05515083784db26a02a809371ccdb3]

CVE-2026-99679: xfs: refuse a pNFS LAYOUTCOMMIT of a range without blocks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99679

Introduced by commit 5278511 ("xfs: implement pNFS export operations")
in v4.0-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bcf0b7f18ad11e1d410e82ffef678705eff0a317]
stable/6.18: [097608700b06804fe81a695417004896507edaeb]
stable/7.3: [d13039937a44e935ed57d661f3f4adcde8375785]

CVE-2026-99680: xfs: mark the inode preallocated for pNFS write layouts past EOF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99680

Introduced by commit 5278511 ("xfs: implement pNFS export operations")
in v4.0-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b8e265991556d99b6d721697f148975a7c68767]
stable/5.10: [7d59e72920deab04fda0741b1ab7efe06308e29c]
stable/5.15: [82724abee43e41a42c6aa34acfc35ca532c06809]
stable/6.1: [760756e136db8e4d9fd7dce0bccb2593c97d326f]
stable/6.12: [fea6d9e15570eeb41c9e01f22f45a8498d9fe200]
stable/6.18: [ff7646096b6ed2ad415258bfbfb07fa6204698dc]
stable/6.6: [12fc4f754c4caa1fe6651b6bd5a9994cae5a4089]
stable/7.3: [2748b9277ff5e35e222b6c4d46a8285e3cf6051d]

CVE-2026-99681: blk-mq: fix out-of-bounds read in blk_mq_free_rqs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99681

Introduced by commit 04225d1 ("block: fix potential deadlock while
running nr_hw_queue update") in v6.17-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [894e4e6084924cfd590968d45fad20908e02ddae]
stable/6.18: [a66d71dddc041ddf02c0476778573c5dba30f758]
stable/7.3: [92ea40ca224ca9909dc7a5ac80dfb3e7cb0e6cae]

CVE-2026-99682: virtio_blk: use synchronous quiesce in virtblk_freeze_priv()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99682

Introduced by commit 7678abe ("virtio-blk: don't keep queue frozen
during system suspend") in v6.13-rc2.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [6c6dec7883f8eb10b326bc9d109a4990c885d949]
stable/5.10: [9971bc421b3942c2d63f8867fac2780d04610f62]
stable/5.15: [18a5462ff15b344e55bf724589b4de55e4ce91cb]
stable/6.1: [36da437dbc2ea1ae9cbe7cb2441fd8ffb4524504]
stable/6.12: [4ad659b3a1f5716cc270bf62f4e79f4f95ca5443]
stable/6.18: [55cc03a17478e7da75df133a4d94ffa47856fee6]
stable/6.6: [6f15e64dcecbd386badc05189116c18cadd69b74]
stable/7.3: [76f6e24c08a613361fb636d492934cda705d8890]

CVE-2026-99683: vduse: fix VA/PA confusion in the coherent page fault path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99683

Introduced by commit 8c773d5 ("vduse: Implement an MMU-based software
IOTLB") in v5.15-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb2e6f166547838fd7c320b01c90918b736f76e2]
stable/5.15: [8f282b6f383b79a8ed363fbf904485e5eafaca92]
stable/6.1: [5f9da97f368cbf3de0123744d7132187e7e0495e]
stable/6.12: [e74a3ed4f59d84036500c5da3905ee40d2c8efa1]
stable/6.18: [1b46b4182d3d5c1a085cfe2578048e1ce09e0e01]
stable/6.6: [84856994037a1a71bf18163b215afbb331838b88]
stable/7.3: [4c8fdb725614189b6c73cf5f7f509592758b6d18]

CVE-2026-99684: hwrng: virtio - prevent use-after-free after a failed restore

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99684

Introduced by commit 08e53fb ("virtio-rng: support multiple virtio-rng
devices") in v3.16-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f7bf47f5a0cc26320aa4b14f4504d03a07f4b74]
stable/5.10: [4e16413f7bf306947c81b913330d54ed75646808]
stable/5.15: [2aecdb2c490384618057535d461a4fcd19f64b7c]
stable/6.1: [e8a75bd0e3c3270076cdf8d841ffe49c35516096]
stable/6.12: [ec81f97c6b13b839e5800cdade1e5b187b9b2738]
stable/6.18: [42f2f4ee9d6e75b8b55b9108f6f5cf254425db64]
stable/6.6: [eb07306b576b6545323abb806e2f840d2de67dd4]
stable/7.3: [b18bda055c0d3e44fdf419e2739d92ea92a6f1d2]

CVE-2026-99685: iommu/virtio: Reset device before deleting virtqueues
on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99685

Introduced by commit edcd69a ("iommu: Add virtio-iommu driver") in v5.3-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f8efac19a0870cdfdf8477e447e5a07ddce9623]
stable/5.10: [5b1669ec2d6bd3d0958e81f212a7149a6fb042d9]
stable/5.15: [ffcc07d4a69dd7cf2f50e7b8418145ec7596ff53]
stable/6.1: [0d809d701cd4bd789b6c1313ea08778bc8e5d6de]
stable/6.12: [e09d65fd554b78c7277f6379517c773ff36d55d1]
stable/6.18: [e60e6db9d07b2ebaff2e055a086fa8e8d14f565c]
stable/6.6: [d16eda7b2832d23423d84fe6fa50908bd5d2a15d]
stable/7.3: [cfdb3b6915299ebb6ffc98566f9cf73d4d1f1598]

CVE-2026-99686: vhost: fix used ring index wrap in vhost_add_used_n_in_order

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99686

Introduced by commit 67a873d ("vhost: basic in order support") in v6.17-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e244725e86be02cd85cb878b3ed8570eba2e4be1]
stable/6.18: [ebdc350cfb1740b6411420482e58a35cc4761628]
stable/7.3: [308e148cf771ed36ad8cd7ef0e9bee2f7ec478d0]

CVE-2026-99687: vhost-scsi: zero misaligned I/O bounce pages

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99687

Introduced by commit 5ced58b ("vhost-scsi: Fix alignment handling with
windows") in v6.5-rc7.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01c3a5fa6d641c93c7cef4fb25c5f12938316e18]
stable/6.12: [13ecd8872a0bff525243a1e4ba634fbaacac559f]
stable/6.18: [400c629c5ea3e36afdda19b83487f6ba2deca7e4]
stable/6.6: [e35095d881cc34944d9a5c8c7341303b0be18591]
stable/7.3: [e048d90d63d6cdf05b23ba5015de7f7652f11e10]

CVE-2026-99688: net/sched: sch_qfq: prevent aggregate self-replacement

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99688

Introduced by commit 462dbc9 ("pkt_sched: QFQ Plus: fair-queueing
service at DRR cost") in v3.8-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e54b3e187300893688c2c7517894f5d96732e05]
stable/5.10: [bcfe04e5c5fe2f655859ac2e8d56e762fc090bd0]
stable/5.15: [4b3771f062438f6a9086baef5395656c2eae6d60]
stable/6.1: [15607276081f3c1bcbabc3b2269188e4788fc8db]
stable/6.12: [374ea8200331708ead0ba524b5c8cd9640515fd5]
stable/6.18: [11c4ba0c976415176a6d82d6051457455d5b7e40]
stable/6.6: [706fb83f294286f3d7ed95600a1f45153e064810]
stable/7.3: [519f327c7fd1b67327de2e1cff6fbe85a02a151b]

CVE-2026-99689: xfs: fix temporary cursor leak in btree shift corruption paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99689

Introduced by commit 9eaead5 ("[XFS] implement generic
xfs_btree_rshift") in v2.6.29-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2bbca049deeb1699cafd966cb2793fee576ee409]
stable/5.10: [476fa55ee5071b113202d7ff87c53ec12c7714ef]
stable/5.15: [90cf07b0e2d827e7ae1b34cf8b2f337332f67b1e]
stable/6.1: [ef31e08939f5a926cee9ad9e3b35144d6cddff97]
stable/6.12: [3f52eb7dd4a584c60f1b190b18fa4958b5fbef65]
stable/6.18: [fa4189dbbd9487de3ef9437572a29c71c5521fe5]
stable/6.6: [0c9778449bb8beb9408c71904cebcc3d98b1d3c8]
stable/7.3: [845ef1a6277f8b8bdf6479c6f561c16e5d5f56e2]

CVE-2026-99690: ocfs2: cache the mount context for dentry lock callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99690

Introduced by commit 8ed6b23 ("ocfs2: revert iput deferring code in
ocfs2_drop_dentry_lock") in v3.15-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b4696e0bfc358619adaeab25ad35b4979af8331]
stable/5.10: [f0a9113dd9bcf06d6d4053ca6debf5ff8b29447b]
stable/5.15: [86dd70951750f393b38e11eae558e30ec83c2d06]
stable/6.1: [e95883b44156336508eda86e908bfa02634887f1]
stable/6.12: [a392e0231b9d823f2e62e21fef68ad6145119dca]
stable/6.18: [ee8997a4521964631d6cc0e511a186f69ce84dbd]
stable/6.6: [2bb821de615273c256725cc390c748ad5efc5e8b]
stable/7.3: [85bc2a3b1bece826c908a31c34a4865a80136bee]

CVE-2026-99691: ocfs2/cluster: unlink socket containers before
releasing resources

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99691

Introduced by commit 2309e9e ("ocfs2/net: Add debug interface to
o2net") in v2.6.26-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0988f0c0c7c908f0ff77fd8b90ce9918a1f41479]
stable/5.10: [87e985b95dc26ceb447418c56487c17c91420944]
stable/5.15: [d54c9f58305031bd09bdec135838a1bfb0586283]
stable/6.1: [9672428efee9fb71d8d185ef352c797592b50a61]
stable/6.12: [8dc77ad4253904eb768f1aff45bb870d6d5a6eb5]
stable/6.18: [829a331e1b52053c6f2d880daaa2f2c0ee85580f]
stable/6.6: [ed62362be4da1e54ef41e6eb9ecfdd5f04b0db7b]
stable/7.3: [831f6f917f7e22068d850efc6443eca300a11f95]

CVE-2026-99692: ocfs2: stop recovery before shutting down local allocators

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99692

Introduced by commit ccd979b ("[PATCH] OCFS2: The Second Oracle
Cluster Filesystem") in v2.6.20.16.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [126429e2f503ade63502978beb0c519066442250]
stable/5.10: [7660c96d8088a5a4ee2d8b498bc3be9cd4fe59a0]
stable/5.15: [9fcd5b26277d43163f72ec4a766571bff7c0ef3f]
stable/6.1: [176dfc0d57960b736f639794768ba5cf84662562]
stable/6.12: [22c123334f3c4effc0b46923da2938e54ad3075b]
stable/6.18: [781991ddd2c4b6f003b7bdef6b7aae6db722707d]
stable/6.6: [53d34ac869849bead8143182543d819c5831bfd6]
stable/7.3: [47997a43d33fcb3d4a87249bfd8ab07ede119fa3]

CVE-2026-99693: ocfs2/dlm: serialize migration MLE cleanup on failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99693

Introduced by commit 6714d8e ("[PATCH] OCFS2: The Second Oracle
Cluster Filesystem") in v2.6.20.16.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61469249aab03799b0d3294b7a0cd25dd303017a]
stable/5.10: [4ea211e2ff722d287e51f8dedaed196915ef7efa]
stable/5.15: [63bd79bef4f23956aa3c2447e9260f24cdc6f344]
stable/6.1: [09906d797113c370a2bb756f8ddbf6bb5076ff99]
stable/6.12: [e328dd5207cc67bb283208b47b3a349b9ccd7a20]
stable/6.18: [901b58081cc78ac3cca19eb0e2970cc5f187f367]
stable/6.6: [e3c7c28a73ad0c34ef44c7a95c71c5e0ceae110a]
stable/7.3: [1696bbf1d6165421a4f7e15549645d96505b0977]

CVE-2026-99694: ocfs2: do not index before the entry array when
dividing an empty bucket

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99694

Introduced by commit 80bcaf3 ("ocfs2/xattr: Proper hash collision
handle in bucket division") in v2.6.28-rc5.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7133a0d0954c109f1764ebf8ab32d7e757a6c587]
stable/5.10: [da4c7fd9935904f53456ee4c902257732bafa61b]
stable/5.15: [593d7d770b0cb43ec2706d0cc70e69936bd4bea0]
stable/6.1: [f9c03a6b2d822b93e672f6e76c33a721d460dcda]
stable/6.12: [58308e76c036822c78947efbbdcb800c1df6f6b2]
stable/6.18: [7148fa383fb000d3125989ff3e63f3458a33591d]
stable/6.6: [b813e2771f1a52e06c70db1790c602f6e6929eaf]
stable/7.3: [b710975d07b049c957ba6b93985b1cf9b169ad6e]

CVE-2026-99695: ocfs2: find the xattr entry again after converting a
block to a bucket

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99695

Introduced by commit 0122559 ("ocfs2: Enable xattr set in index
btree") in v2.6.28-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c191a7a44882487e291e09f095d2ae4d7cca146]
stable/5.10: [049ded9e088fa206be3148f116ef9c914fd1c979]
stable/5.15: [b38342e173b6011b38349618d4925567e71d949c]
stable/6.1: [dc5ed4e05de2c0c05bb0a4cec7b5b50d18978646]
stable/6.12: [49820bda28134ab0f6748e66cb104c9adcc2e116]
stable/6.18: [1ca9787e733a29aea926f8956dffc41bf553c5ca]
stable/6.6: [f3e86037f2ac33ad13d84d46158e04580bbae24e]
stable/7.3: [2bd2ca4f70570f08992ba38dbf2570f8def4288e]

CVE-2026-99696: ocfs2: find the xattr entry again after defragmenting a bucket

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99696

Introduced by commit 0122559 ("ocfs2: Enable xattr set in index
btree") in v2.6.28-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a40c050f58344615a0604701b5d299519833163]
stable/5.10: [f8e08be071ccc88fdf6b72f48d8f0455b7a340f0]
stable/5.15: [cd5b1b2c797ba1672d126c238314de0effcee9a9]
stable/6.1: [145f999a6c585ee68a6f573f727377c98caebe1d]
stable/6.12: [b839d9913b56f0d769dced34cdfbe02a009b3bf1]
stable/6.18: [89ef9cb4da160b5572e0e5b9cf930335117d561b]
stable/6.6: [10976cdcd61075eb51799a56ac99de1acda8b84c]
stable/7.3: [8c107f10fe63fdec081c2ae471fc90b4d3376db6]

CVE-2026-99697: mm: memcontrol: fix NULL pointer deref and UAF from
high_work_func() on dying memcg

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99697

Introduced by commit e4dde56 ("mm: multi-gen LRU: per-node
lru_gen_folio lists") in v6.3-rc1.
Introduced by commit 5da3bfa ("cgroup: use separate rstat trees for
each subsystem") in v6.16-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd94d8c7660a60dbfcd425e0d10120de6d02a7bd]
stable/6.12: [a44855f25821082e384503abf01a45a5c65a80de]
stable/6.18: [301ac490daf619b8affe12b07e2d68c99adcda79]
stable/6.6: [16062b71048d8ef85ca6a99d5ef26f0143d0e0c7]
stable/7.3: [b558ac673e65b4f302f105a0d9f79fb7cf012330]

CVE-2026-99698: mm/cma: accept memory of CMA areas reserved at a fixed address

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99698

Introduced by commit 75d090f ("x86/tdx: Add unaccepted memory
support") in v6.5-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8f9cbc34a309a388c052706f3329d1b52985aa3]
stable/6.12: [217d34dbf5aa2dbc67ce0b07d97dfe35d86bcdfc]
stable/6.18: [6b1e545759608795f8c6123cca892073a5e5a38d]
stable/6.6: [96fab2b7867eb7f85691bb20d78310979c50a65e]
stable/7.3: [167d6b31a447902c205b34638a6c90b55253f216]

CVE-2026-99699: mm/cma: accept memory of multi-range CMA areas

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99699

Introduced by commit c009da4 ("mm, cma: support multiple contiguous
ranges, if requested") in v6.15-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d002001601a163b6c3500cdc098ff66c34f62d8]
stable/6.18: [8e2dcdc9806546b4bda6f5904c96f1e5c20d477e]
stable/7.3: [89b722ba00b0a6efd3ea14c1fc7996eb3b5a22c1]

CVE-2026-99700: mm/hugetlb_vmemmap: map the shared tail page writable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99700

Introduced by commit 32c440d ("mm: drop fake head checks") in v7.1-rc1.
Introduced by commit 01b1d0f ("hugetlb: remove
VMEMMAP_SYNCHRONIZE_RCU") in v7.1-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0120a603afadba8ab4954bb1ce60f8195f80efc8]
stable/6.18: [f96a68bab26183433ea542dfb29ec41125f9fe39]
stable/7.3: [e570f2c29fc07a1040c3736bf1a1dfa8065d5099]

CVE-2026-99701: mm/ksm: fix userfaultfd protection during merge and unmerge

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99701

Introduced by commit 63b2d41 ("userfaultfd: wp: add the writeprotect
API to userfaultfd ioctl") in v5.7-rc1.
Introduced by commit 2d427bb ("mm/userfaultfd: add RWP fault delivery
and expose UFFDIO_REGISTER_MODE_RWP") in v7.3-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [990d6c2194a938a19a8cf94c6cfd75171345089b]
stable/7.3: [5cf7267b79f276c27825a2ebb95deda788a29e77]

CVE-2026-99702: mm/vma: write lock source VMA before duplicating it in
__split_vma()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99702

Introduced by commit 2ab7f1b ("mm/madvise: allow guard page
install/remove under VMA lock") in v6.19-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [769417e410dd19b2a438c6addb61b194b7a4c387]
stable/7.3: [2c1393ecc3dd399561557c98d7f2e5251bb5bf92]

CVE-2026-99703: mm/hugetlb: fix mremap deadlock when PMD sharing is possible

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99703

Introduced by commit 550a7d6 ("mm, hugepages: add mremap() support for
hugepage backed vma") in v5.16-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92daa8652f88c8cfc05f4899a8408a04b02f211e]
stable/6.1: [02e932981359ff8531293c80f5a974b16b1d793d]
stable/6.12: [6c3cf326b108ede4e9b3c32059f195bf99193ca0]
stable/6.18: [dd2381dabe0761b6a200a9b4f2eca280e5986faa]
stable/6.6: [8886c9c5e008549808b89ae2bb7c736680456497]
stable/7.3: [71568db3f9d90c373881c6d438db9afc47a1755b]

CVE-2026-99704: mm/page-writeback: avoid 32-bit overflow in dirty
threshold shares

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99704

Introduced by commit ae82291 ("mm: use part per 1000000 for bdi
ratios") in v6.2-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9597c2056e05bd79df9d343a9b42e84a54de1c52]
stable/6.12: [64783904ec5eb7240c9e035122367294757311ed]
stable/6.18: [45a2f3102660845d4992ae20587e9afe7c613485]
stable/6.6: [d80b9edae6a099a678387a2ff041f87a674833f5]
stable/7.3: [d342881c5bb75460ae28cfd2006e21dbf9aec443]

CVE-2026-99705: mm: memory: fix truncation removing mapped folios

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99705

Introduced by commit 6375e95 ("mm: pgtable: reclaim empty PTE page in
madvise(MADV_DONTNEED)") in v6.14-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [243cf1f67b365668389832463fc31cbb9fec47af]
stable/6.18: [8011e987026b65f59ea6b6082c777807a008b227]
stable/7.3: [b57cfd4da476a4636bf1ed69dee176cc266e5a06]

CVE-2026-99706: mm: fix address wraparound when scanning large folio PTEs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99706

Introduced by commit d2136d7 ("mm: support multi-size THP numa
balancing") in v6.10-rc1.
Introduced by commit 5087589 ("mm: swap: entirely map large folios
found in swapcache") in v6.11-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f681d4580d5c3c749f623cda722a21aefd3147b3]
stable/6.12: [95dbf4caf986df3cdb5eea3856a8848547c59578]
stable/6.18: [bb712b6f2195953669542f74cbd0ef061314f392]
stable/7.3: [f6c17bda9b304795a2c284fb6c8a8eaac6248b80]

CVE-2026-99707: mm/khugepaged: flush deferred unmaps before dropping a
failed folio

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99707

Introduced by commit 6d9df8a ("mm/thp: collapse_file() do
try_to_unmap(TTU_BATCH_FLUSH)") in v5.18-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [854e5ff8b3ce2a776586cabebaeae645c992345b]
stable/6.1: [61e8b187e011489adcb35aca629431c9b6c7f79a]
stable/6.12: [d9d621ad49a969587d32c98aee1d83e679b9d361]
stable/6.18: [cf1902ab0203f8767a3582143049d1bea5422096]
stable/6.6: [d21e723479d96deeb0f28bca75050e0ce13c5b7b]
stable/7.3: [8c4adb787f77318df3b478f928f271e26d557208]

CVE-2026-99708: ipv6: reject wrapped temporary address preferred lifetimes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99708

Introduced by commit f4bcbf3 ("net: ipv6/addrconf: clamp preferred_lft
to the minimum required") in v6.9-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3e67bd82b9b9b1a5118f09a429ccefe2aab0741]
stable/6.12: [56758052466e6617fa4ac8e68d3c109cca56efb3]
stable/6.18: [11c7029932fb578b12b379a5559702b0cec8feda]
stable/7.3: [6bbce146f893ab8b335e9eb82f4293bc94f3a4bf]

CVE-2026-99709: inet: frags: limit the truesize of a reassembly queue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99709

Introduced by commit 1868545 ("inet: inet_defrag: prevent sk release
while still in use") in v6.9-rc2.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [3ae20e4697eb969104fe4b1e98a675f0100382b6]
stable/5.10: [86bc36effeec87a95b7c6f3cde686161dde21fd9]
stable/5.15: [68515ac2255aa58428b1ae703fd5a20a25fafcf0]
stable/6.1: [85b53c900b50a89bd8fea826f55cf2f7cdd3985c]
stable/6.12: [4d820b22f2ed9f7c919e5e623782dc936ba9a50d]
stable/6.18: [4bf5dee2b4ad14094360e01a1e0847636efa1519]
stable/6.6: [b3a7ab213d05f3a5e48e98cab291d190fbb1e201]
stable/7.3: [b7f84486c44c2ce03dffe5f09a42a38acbaa1551]

CVE-2026-99710: KVM: x86/mmu: Cap number of parent PTEs per SP at 1000
(the arbitrary rmap limit)

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99710

According to the .vulnerable file, this bug was introduced by commit
cea0f0e in v2.6.20.16.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4558c3d7198ed9a0adc3304681f561f4e4d80e1]
stable/5.10: [4559e4cccd75e7bf65daaf170a2f7100df0c0c03]
stable/5.15: [c7ad798a8ca0231696ea1ce40a7ccdb9afac66d9]
stable/6.1: [863810abac0e6dc3dba554e0dabe449442351c98]
stable/6.12: [edf87e07376054eedcd5306e0794a26e3004d97b]
stable/6.18: [e0752f3e543c1b67fc9115251ae6b8f151ba9f04]
stable/6.6: [d358a3e5b7d11b4213c77a96ab5951983210be65]
stable/7.3: [72238066aacc400df69cef4b602f083ae4737762]

CVE-2026-99711: KVM: nVMX: Process each host MSR entry at most once
when unwinding failed VM-Entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99711

Introduced by commit bd18bff ("KVM: nVMX: restore host state in
nested_vmx_vmexit for VMFail") in v4.20-rc1.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [c33ef9d334059f7cb167569ed7b4779752fe4425]
stable/5.10: [011a2aad81c656fc9130803d2bd08f40f961389b]
stable/5.15: [f0f8aa94ca2e5375c588fdc4328812b489c38c71]
stable/6.1: [7e1214410887f4ba5b839f63a541be08ae47606e]
stable/6.12: [05fae367c6878d08f54a7c5bb6986a5e57e9bd1c]
stable/6.18: [42b98982aedf40f5076bf045bf359df4dea09468]
stable/6.6: [78c9a691e11de3ad19a1b7ffc088eaa38a243e6c]
stable/7.3: [6a4697ec81693f8db41a1c3ba81f3b9b2510879f]

CVE-2026-99712: KVM: x86: Conditionally resched when restarting REP
string emulation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99712

Introduced by commit 5cd2191 ("KVM: x86 emulator: restart string
instruction without going back to a guest.") in v2.6.35-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae85ac25eb671d174811cc3101549448671fd505]
stable/5.10: [3ad58cb4ec32dea14c915916c7298bf6c7903695]
stable/5.15: [8871ec66b296bf14f0c096efee42c65990a30b7f]
stable/6.1: [2b1c87db0a2950fd63d62e33570910d3063e1b6c]
stable/6.12: [c1293d2134c2d63741b197a1e5a6363894ed4bce]
stable/6.18: [41a43510f77298d147a098eb182695d0001593c8]
stable/6.6: [e74913838f4b93b5e23731cdcc09356d9697ec5b]
stable/7.3: [5a5f9853a78c45927cd0814ae67c5ad8b5021bcc]

CVE-2026-99713: KVM: x86/mmu: Conditionally resched when retrying gPTE
walk on A/D update failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99713

Introduced by commit b3e4e63 ("KVM: MMU: Use cmpxchg for pte updates
on walk_addr()") in v2.6.25-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2691b3a6cd230209736c89684dab90d939aa56b]
stable/5.10: [6374dbc5021c175a8d6eeaf87564199992f053cf]
stable/5.15: [a5ecd3828a1a2f222555abeb7abc49a2740fbcf3]
stable/6.1: [608b381b7af197a8d2a84d4a108afb72209904fd]
stable/6.12: [399c8c1e2ea42018960a31ef3a2e93554e50f606]
stable/6.18: [9c24e8e00238d7fd12808dcddb41b264f7e4918b]
stable/6.6: [0b869cd9fef56cff6faa00fa1fe967fd2b0fc8cc]
stable/7.3: [193bfab2791eedc1dbe2d61755211a2973d79138]

CVE-2026-99714: nvme: Do not drop the cdev reference twice when
cdev_device_add() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99714

Introduced by commit 9952f38 ("nvme: fix cdev lifetime") in v7.3-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dfe79db5615df8d37ae7de6d3ec099b71bf3e03]
stable/7.3: [45d0c2d7d338ae1606984ed92d254ca0efcef921]

CVE-2026-99715: nvme-rdma: fix NULL queue->ctrl dereference on reconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99715

Introduced by commit 2a85130 ("nvme-rdma: parallelize I/O queue
allocation and startup") in v7.3-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ee50a2d76f278ea0ced45716a62730059283787]
stable/7.3: [ed9e1f64bc79c92340b3d57c7294542ed13eb280]

CVE-2026-99716: hwmon: (coretemp) Set nr_cores only after core_data
allocation succeeds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99716

Introduced by commit 1a793ca ("hwmon: (coretemp) Use dynamic allocated
memory for core temp_data") in v6.9-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95638f1f05ced75a82e83f610cd01b636d2a21b1]
stable/6.12: [18551f9cfa0890187219e5d46a277feb1fa260b9]
stable/6.18: [01bd308458a2855e64358669b057a59e1e819570]
stable/7.3: [2fb99a03cb8c4a5907c55968d1aa8df6c885e347]

CVE-2026-99717: hwmon: (pmbus/q54sj108a2) Add missing NULL pointer check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99717

Introduced by commit d014538 ("hwmon: (pmbus) Driver for Delta power
supplies Q54SJ108A2") in v5.11-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5802c587da97a4ff85c04aad6043fa26640fc9b]
stable/5.15: [267006b770dc1ff8fb72eb1eec1c8181b14e62c1]
stable/6.1: [b85efc7a47f07cae2437b2b40b52a693d3224079]
stable/6.12: [d221b9a6e2328f52c8a3136276efbb1df9272650]
stable/6.18: [e051c87d9333b10a93fb50d6a46ab63ec64e4c98]
stable/6.6: [d61429651e0c498cb7bb6b4d8e7e8f188a2ac19b]
stable/7.3: [73b425e6df23db056873eecce70c3f06db06ca16]

CVE-2026-99718: hwmon: (peci/dimmtemp) Fix devres leak and UAF on
concurrent unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99718

Introduced by commit 73bc1b8 ("hwmon: peci: Add dimmtemp driver") in v5.18-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61bc4514b8e99e9733c04de028885f6fc906d628]
stable/6.1: [31e2d1d0085ca261e42e9ecbbce200de1801d8e5]
stable/6.12: [f27cb64b04af01370fbe2d23ba9aeb3401d6def8]
stable/6.18: [c7dcea6bdc6c36c649c1fdd29909b232bcac28c9]
stable/6.6: [d112d6e815ca4314eb3636f8b37cf0d84cd33a8b]
stable/7.3: [3f6bd7aeea5c3bd5ced9e23184155065f551ea96]

CVE-2026-99719: hwmon: (lm87) Fix drvdata type confusion in vrm_show()
and vrm_store()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99719

Introduced by commit 00a0c90 ("hwmon: (lm87) Use hwmon to create the
sysfs groups") in v4.10-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b51ff0887b9f88d042b92dd07fcdda4132f0ebc]
stable/5.10: [3547b2ba62c663211da61670dc37684aa5fb86b8]
stable/5.15: [aa1a9e462f67ed0e5677c9d881a96018cb250214]
stable/6.1: [7487e06e7f330dabf4059ac563be43e3525d3222]
stable/6.12: [25ff5f904e1cb55ac700ce88db3a5a6b735b12bc]
stable/6.18: [b3b6489a11966c2e3a50574b0f08ada55530c10d]
stable/6.6: [0783b1fd85be407d4630477402ff8f399da8d144]
stable/7.3: [8f5888c37a1a8f5462fdf72fb07d55f23fee5005]

CVE-2026-99720: hwmon: chipcap2: fix IRQ teardown ordering

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99720

Introduced by commit 3af3509 ("hwmon: Add support for Amphenol ChipCap
2") in v6.9-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2a66c515d7730fd453485ffb306c412f1f46d72]
stable/6.12: [93a003172de520f52f2a59206d931607400d697f]
stable/6.18: [c2b2176a9359e813c7c172f6cba6efef31aaf9c4]
stable/7.3: [a205f2113200c6357e0526c94caaa4c2aceb2fc7]

CVE-2026-99721: hwmon: (aquacomputer_d5next) reject short status reports

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99721

Introduced by commit 0e35f63 ("hwmon: add driver for Aquacomputer D5
Next") in v5.15-rc1.
Introduced by commit 19692f1 ("hwmon: (aquacomputer_d5next) Add
support for Aquacomputer Aquastream XT") in v6.4-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf8f81babd2e96087dedbb74985bc1781c98f73d]
stable/5.15: [e85e97a806b41006b303f86d41a54c88460fb72b]
stable/6.1: [25854b0d17b1cf5fc9453447f1e6d4b33c78debd]
stable/6.12: [73a77cc33fd5ea7068eb8bade71f7ab5d3e54d96]
stable/6.18: [33024a7ee9bf6865cc2501b705fab68884067071]
stable/6.6: [470e6bfb505eb2fa9a25066d64fdffd90c21ad54]
stable/7.3: [25dcc6ab1c4c2b55625334b95fecc1acc8203c47]

CVE-2026-99722: vringh: bound top-level re-entry into indirect tables

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99722

Introduced by commit dbd29e0 ("vringh: Fix loop descriptors check in
the indirect cases") in v5.19-rc2.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [f898439ace7f89922e853b43bcbfcd26ea2e0a98]
stable/5.10: [432d305e2e68befd52c23ce688713ad2b5057675]
stable/5.15: [6d080ebafc488ea232021385c65362768ee9f3db]
stable/6.1: [727aed20dac0672ed36368d9b37f1cee12f629d4]
stable/6.12: [8d8fae59c6b00cb6b2d48e1496b8a4cc2f4d5e8f]
stable/6.18: [e7d831fd55e61f76d5dafe4b5e53aa9c87f7c227]
stable/6.6: [75b77789e89eef8bdace2f890e2fd2a58dad5f51]
stable/7.3: [f6b933a9a1ebf67ae5474bfb8824500457dfbb68]

CVE-2026-99723: vhost-vdpa: fix pinned page leak in
vhost_vdpa_pa_map() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99723

Introduced by commit ad89653 ("vhost-vdpa: fix page pinning leakage in
error path (rework)") in v5.10-rc7.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd1462c96bafe2cb14e88c837b270f8990b717b5]
stable/5.15: [23d142e60e3551186a4237649dfbd808780fe574]
stable/6.1: [42aa04c60c739a45bc2f7f4123ef3e8b8150a5e7]
stable/6.12: [441039451a19e171a1d6376b8b16e1b90316d119]
stable/6.18: [77bd4305f34f65630e26a108ec98555d6aafce37]
stable/6.6: [9e13e8eac79134fd45881c85cbea581045ff8ac1]
stable/7.3: [5b9af57dba47a1750be4831da1f1f34c99c50caa]

CVE-2026-99724: ntfs: don't allow compression on volumes with clusters
larger than 4K

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99724

Introduced by commit fc053f0 ("ntfs: add reparse and ea operations")
in v7.1-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c77ab4eeeb3ed471bcc99a94673f0e0142c4b84a]
stable/7.3: [df35f062d4f24e4c9d9711d6af24916d3784871c]

CVE-2026-99725: cipso: fix optlen corruption in cipso_v4_delopt()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99725

Introduced by commit 014ab19 ("selinux: Set socket NetLabel based on
connection endpoint") in v2.6.28-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f1f8e8c5176234fa31858cd25f2e9b88aac0a45]
stable/6.12: [699141380f7f249b7ee594198d9bea6bcd4862ea]
stable/6.18: [4077bd2bcebf43922f84aa87f6839153212df509]
stable/7.3: [0d9a6f9778ccd4401ded4ec9faf750b7b4a14ce7]

CVE-2026-99726: drm/v3d: Widen cache_clean_lock over the whole L2TCACTL sequence

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99726

Introduced by commit abf888b ("drm/v3d: Wait for pending L2T flush
before cleaning caches") in v7.1-rc7.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [994ba6e5c87d6a3d471ea987fe8622168f092334]
stable/6.18: [ea7ed4ab14f9ae79bd798bb156025bc751c71a9b]
stable/7.3: [1b48fe8b323103e278fbc5145231b763577e2487]

CVE-2026-99727: mm/huge_memory: properly handle refcounted PUD mappings on fork

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99727

Introduced by commit aed877c ("device/dax: properly refcount device
dax pages when mapping") in v6.15-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d90bdc02e36ec08d8248ebc6cdc52e12043eb28c]
stable/6.18: [dcd4fd137baa6fe2c6c4643ee0ca0264f71831f8]
stable/7.3: [e8ebc5a46795cd1fb4333df81f19bbf458467cce]

CVE-2026-99728: mm/huge_memory: fix list corruption when
deferred_split_scan() races with deferred_split_folio()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99728

Introduced by commit fafaece ("mm: switch deferred split shrinker to
list_lru") in v7.2-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f09171b67ea06a7fe425db33e8b74a92de1426b9]
stable/7.3: [877a9fbabf760714f510f36b310a986c4be2c2d8]

CVE-2026-99729: mm/rmap: handle device-exclusive entries in
folio_referenced_one()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99729

Introduced by commit b756a3b ("mm: device exclusive memory access") in
v5.14-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3c493d2f42b5f44a5c134d8d7ea7f960caf5e2c]
stable/5.15: [ba808003b93676600006ee0a0f75103a17b822fe]
stable/6.1: [d272ee353e03c4f9afa56a0931526961613d554b]
stable/6.12: [1b0ce69587787c0f3e15545309b201285fd81c61]
stable/6.18: [4e2c3931ed1eb86e75ef27d5ba0a71ef576ebae8]
stable/6.6: [8e2f27af10a191bf32094e52ffefc9964b34d177]
stable/7.3: [9075e5fbad71e00a73cddef901a2a08ad7b51af5]

CVE-2026-99730: mm/filemap: finish fault cleanup before dropping the fault lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99730

Introduced by commit 730633f ("mm: Protect operations adding pages to
page cache with invalidate_lock") in v5.15-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97156a6c355c21f7122421915f05461bd11699a4]
stable/5.15: [35268471f4a4f3b09374a0d97aaa423dfb6aae81]
stable/6.1: [80c954830d5a22fa200d74bac413cb3390b95f04]
stable/6.12: [efa7aec3f30d79a7d35edd219c6f49235f331013]
stable/6.18: [f1c149e651fd55edc0769b76ebd688ae6cbd48f0]
stable/6.6: [c3fa2252d436e4ccd483a329c6b4180d11846269]
stable/7.3: [8500faaa6ef7b4489294f2bf98c9017ee009986c]

CVE-2026-99731: mm/filemap: don't lose a folio lock wakeup to a signal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99731

Introduced by commit 5ef64cc ("mm: allow a controlled amount of
unfairness in the page lock") in v5.9-rc6.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ccb6ded6a47b59b4907ed4f8c293cf8122de889]
stable/5.10: [1fb9f09fe323ea3a09154b9b1e1920efa252581e]
stable/5.15: [8c82eb8476e458b4e9889197843d4bd31f86b738]
stable/6.1: [e51c561f878f9fd58904a03a6c50f65a2ffb088e]
stable/6.12: [3ce549d0df658a36602f2d03882688af0ea03faf]
stable/6.18: [da815f785e568accf0d4f2ec36233d316d5035c8]
stable/6.6: [1b995b2ac9d8a1b1ac6dc5bf85276c4fa18875ea]
stable/7.3: [31cb998f208c078a6e9656b971bb311ea490ff1e]

CVE-2026-99732: mm/filemap: read mapping->a_ops->free_folio under i_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99732

Introduced by commit 59c66c5 ("mm: factor out page cache page freeing
into a separate function") in v4.15-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc24e273244e9d712257d5a6c20a32c7f5ca84e6]
stable/5.10: [728645686f3dd0fc2b87ee51a049979cdcc819dc]
stable/5.15: [7ebf1150db4ea8f7dff081d337a24f05318c0415]
stable/6.1: [dce706b564f19927afdafb67b4703292cd779a0c]
stable/6.12: [a24504359bd69959cc4bf9f988a74d6b7c1d4ef5]
stable/6.18: [8cfa971222e43f950641ea1e611866e6f6fee982]
stable/6.6: [bb15bbc8ca03ab686e5bb7d4747883f034455d15]
stable/7.3: [842bfdb63ff2f9fcc3edc7ae6a33dfae3747a56e]

CVE-2026-99733: mm/truncate: look again if a folio left the mapping

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99733

Introduced by commit 1b64443 ("mm/khugepaged: enable clean pagecache
folio collapse for writable files") in v7.2-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cf632e139737314afa889ca18122bc3fddb9120]
stable/7.3: [f17044fee422605d19e07c4c9f5dc2be7abd7086]

CVE-2026-99734: mm/shmem: make shmem_file() check the file's inode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99734

Introduced by commit c49fcfc ("mm/shmem: update file sealing comments
and file checking") in v4.18-rc1.
Introduced by commit b3749f1 ("mm: memfd_luo: allow preserving memfd")
in v6.19-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3710111839d11339e414b1bb3fea3d05ab83f6e]
stable/5.10: [c640660546a0d6401df8a3bade44106e718acdb8]
stable/5.15: [1b6acc6d060a52d610b95a15e3b10ef92fa94ec8]
stable/6.1: [d59c534c9a89ca9b87a4d8e0012e8d9e9879fac5]
stable/6.12: [f9632dbb5d546d4bd30d922b6ed44735160a3664]
stable/6.18: [8c4a93bb9736256a97660505f0e0d1c01ef60f20]
stable/6.6: [ecc5ee1575c02a87f48867614328604400c65fc0]
stable/7.3: [ea5cc241113f7820ce037dbcf8b7eb959fbf1c0d]

CVE-2026-99735: mm/mglru: don't use stack pointers when walking PUD
and PMD tables

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99735

Introduced by commit bd74fda ("mm: multi-gen LRU: support page table
walks") in v6.1-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [65a9bf08a3e4d6e58df211ed900c16bafb79b267]
stable/6.1: [4240f886a8ba35b5fa18cf067358cd31a122dcc8]
stable/6.12: [a352391f8f9c035d3b2a8a9fe6e3fd2e1c4ec44e]
stable/6.18: [4b428d9d24e303f92819119c66858f5de38bbc78]
stable/6.6: [60454f64ab304a89707291af6f455893e5506187]
stable/7.3: [4e5eb180d37cb222ed3c9b6772c6044e16c2a1c3]

CVE-2026-99736: mm/shmem: fix accounting of swapin-error markers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99736

Introduced by commit 6cec2b9 ("mm/shmem: fix infinite loop when swap
in shmem error at swapoff time") in v5.19-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66ce68a249f4ac56cd6968aa6d8ded20fb4b7d09]
stable/6.1: [00e3efd5d74d18447438edfd2532cd4100fd5756]
stable/6.12: [77ad4ac35977d081f2b69f1c73ae3b210124b1fc]
stable/6.18: [f49d40a699bdaf68bbb307f1fa207512520ce982]
stable/6.6: [5e09340badaf982a2cb73e41da715fcdd0e2eb7f]
stable/7.3: [d4bc03eaeef281c460370dfd57e1a671b787edd4]

CVE-2026-99737: mm/shmem: fix truncate loop after boundary swapin failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99737

Introduced by commit 8a1968b ("mm/shmem, swap: fix race of truncate
and swap entry split") in v6.19-rc8.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [5f1ec2cf92a7d655a8eb39711987822f9b1f9d67]
stable/6.12: [7f1bbb9c6a8ed3fed72bf7efc906ebe31e92feeb]
stable/6.18: [d4d46430852caf5e7dbca1386fc6621ecf8fe2b0]
stable/7.3: [e6e9ba49679e5f33f62615fb57ec103045fbc8f9]

CVE-2026-99738: mm/shmem: preserve allocation errors when swapping in
large entries

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99738

Introduced by commit 91ab656 ("mm/shmem, swap: tidy up swap entry
splitting") in v6.17-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4ce23b1feef16d435aa1188b6c2a637a5373ed5]
stable/6.18: [265dfa2525817d3be437576505186beb623384bf]
stable/7.3: [680afc486db200e7b08307cb28be4f90766afcff]

CVE-2026-99739: mm/shmem: fix truncate hang in large swap entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99739

Introduced by commit 8a1968b ("mm/shmem, swap: fix race of truncate
and swap entry split") in v6.19-rc8.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [fa213b08f37f9dff78ce240a87579dc264fc7a5d]
stable/6.12: [9fbca74e8efbb8fed180639af349449f04a2a3c3]
stable/6.18: [577374a2171cdb68e492725feb564364f93161b6]
stable/7.3: [ef6daf302dc569a67fe50968f9b6085f111b8560]

CVE-2026-99740: mm/shmem: stop retrying folios that cannot be split

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99740

Introduced by commit 55ac8bb ("mm/shmem: fix race in shmem_undo_range
w/THP") in v6.7-rc6.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [a842a1f947da8a7020e72f885ffbf2ce6a93685f]
stable/6.1: [c00f570d296157a89bf25282cfabc057a34dbc85]
stable/6.12: [dfedff4a9f0abcd985dcdfbd721dcd9374d6ff12]
stable/6.18: [1360e0f9a188cfede01d0df81119d925bbfff165]
stable/6.6: [65c71c823b8ceb7721642fdb24a992b22fdf0944]
stable/7.3: [b3239a5a37bba078d83cfb864d47a0cc122f17cd]

CVE-2026-99741: tmpfs: keep the quota soft limits of an unused id

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99741

Introduced by commit de4c0e7 ("shmem: Add default quota limit mount
options") in v6.6-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [968d73463059156e1b89bfa6b189acd7d27197b2]
stable/6.12: [b66796d176dfc107ec7fd2d6b4e9b6fa8b160dd6]
stable/6.18: [e6158f1736ebc3681ee164e8d5b5c1607ac60138]
stable/6.6: [473c522e8230ace167ededa2cef61a9c890e8144]
stable/7.3: [3aa51c92711896c86da9fcef01b1155e8caa7e74]

CVE-2026-99742: mm/mempolicy: charge shared policy nodes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99742

Introduced by commit 5d09705 ("kmemcg: account certain kmem
allocations to memcg") in v4.5-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [68b2aa37afa390f08de13bc0bac61a9ded3318bc]
stable/5.10: [6b2e45efaaf4bca9cf8a6a7b908b0f6a53b95729]
stable/5.15: [310236e5a186f096b3c440632b9e96dd5ec05857]
stable/6.1: [817af14f870d905d2aa3086b2b4d7fab1e447446]
stable/6.12: [d500c37437cce47e492c561757ece2596e21446a]
stable/6.18: [40e340bab4d07958b2077c16650c3da5c76d5820]
stable/6.6: [580e7e86e13092e381aec566ae16fd65c78d59fd]
stable/7.3: [0109fa404651e20493ca35a9a7d4f87861148064]

CVE-2026-99743: ksmbd: grant a POSIX ACL group entry only to the group's members

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99743

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c00ec7ad449b68c291a4986e481941302ed399c5]
stable/5.15: [9abbe237d22e3616e40c1cb545c526844cf434e5]
stable/6.1: [2ccb2c015cdd76a3673e152ff0b6104ba7408a32]
stable/6.12: [cc25a25f20bffce7f138e50d257d0fd23a92c061]
stable/6.18: [629dc60f4c9de7044e6c91832b63e1b78e486635]
stable/6.6: [95d5a1e0cb15def64b7e3eef7ca3b29cac2ca757]
stable/7.3: [92b4dc36ccab59999857a4181284859e5e3fb67b]

CVE-2026-99744: net: atl1c: drop oversized RX frames instead of panicking

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99744

Introduced by commit 43250dd ("atl1c: Atheros L1C Gigabit Ethernet
driver") in v2.6.29-rc7.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4ba1716853de5178a9df785844ebb5e397a80e6]
stable/5.10: [2f29680c3f82a50e91b97b3f2eeb72ecd08116bd]
stable/5.15: [388e78041d938d87f7fc50921d24e99f1b066a73]
stable/6.1: [ad02846336d31ee30fd499a6c34b06036522b27a]
stable/6.12: [11c873d6e6a497b5ee3699c63b57b49a882aa580]
stable/6.18: [655463ba1de62e7f4893cabfc89fe70d0e33f55d]
stable/6.6: [be8ef80bbdb914ac0064f8e00400d3959ec80397]
stable/7.3: [18ca06b36c4da8b46859dcd1c9aec557d05bc23a]

CVE-2026-99745: x86/bugs: Select the BHI mitigation based on the
attack vector properly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99745

Introduced by commit ddcd4d3 ("x86/bugs: Add attack vector controls
for BHI") in v6.17-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3457b3bcd344005af894876cab4e634cabdcbb62]
stable/6.18: [f9f2a155078cf7b10dd8b1ffdacf0a3aeb8baeb5]
stable/7.3: [5bc572befb2990cb2ad83ca447f64e6654a9889f]

CVE-2026-99746: ASoC: SOF: Intel: hda-sdw-bpt: Stop active DMA before
closing BPT streams

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99746

Introduced by commit 4c1ce9f ("soundwire: intel_ace2x: add BPT
send_async/wait callbacks") in v6.15-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [348bc756d912dd8f47fd36c167075717951a515e]
stable/6.18: [d716684a9cd61b53e9186f1955a80699409b0f49]
stable/7.3: [be6fda13447b6aaceb03a06eb5b59d132b1b2b26]

CVE-2026-99747: ksmbd: fix NULL pointer dereference in
session_user_name() and session_account_type()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99747

Introduced by commit 1f7dd03 ("ksmbd: fix malformed procfs status
output") in v7.3-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d13da43938d15b0b719827d8f2b32df8eaec5def]
stable/7.3: [33782daeb2ef6f620b08d41f1a15785676370c78]

CVE-2026-99748: ksmbd: revert fsids on durable reconnect and replay failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99748

Introduced by commit c8efcc7 ("ksmbd: add support for durable handles
v1/v2") in v6.9-rc1.
Introduced by commit bb8bf7e ("ksmbd: add SMB3 request replay
support") in v7.3-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [539223f18026448f67d33d09719c355b91db7fd0]
stable/6.12: [559711f3182f3e17884795bf988cf7cff21e1a9a]
stable/6.18: [fd4f7aa999077a6b0cda4834835aacffb63c634d]
stable/6.6: [9e3b6a97af5340171f51237511afbac62a932b90]
stable/7.3: [bd7142a1d60c8aeb203e007515e077bcded88769]

CVE-2026-99749: ksmbd: enforce the read-only share flag when creating a stream

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99749

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Introduced by commit eaff8e9 ("ksmbd: synthesize empty AFP_AfpInfo
xattr on first probe") in v7.3-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [09139429fab3a5114c18d7c15fb161511d4d66c9]
stable/5.15: [3c226cbf62b7bf2a36e6da4faa8cb6fbe5f8187a]
stable/6.1: [996f257e4bf6d5a5574a3ec10cebe5cf63959e4c]
stable/6.12: [f92cd402cc29889be2dbdcbe60ec014c231f2ec6]
stable/6.18: [d86cea832d4bffabc51190039ee286a0ab9f3b61]
stable/6.6: [bbeae2eb4df84a033a2db1b0d7647ed762bd24fa]
stable/7.3: [ece35b45ec17a462cc5947ad4fbc3450657aa55b]

CVE-2026-99750: ksmbd: require DELETE access for delete-on-close opens

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99750

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1dd91081ba3c692565f9c1f884149178d5a06d1e]
stable/5.15: [b51d1c42d1a9273b00fd886a2378d6e0466a99b0]
stable/6.1: [303298db106c56f7b7eda37a6616429f7f451a1a]
stable/6.12: [cc71e3abb81ae1470c09acae85d989b42509a2e0]
stable/6.18: [2d0d4adb6bade8b204b10ad2a4c43f3b7d2af030]
stable/6.6: [bb6f4069b436bdcd28a8bf96e47c2af0ccae467f]
stable/7.3: [7e9a78223752911e118710009aab9dd9e10b2ee7]

CVE-2026-99751: bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99751

Introduced by commit b4ab314 ("bpf: Add redirect_neigh helper as
redirect drop-in") in v5.10-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23503acb214cbefaf3945d05ab9667ff11ae3de9]
stable/5.10: [bd2ef1677d41bcc942d99a3fe39e87adc2cc595e]
stable/5.15: [9a770d6d356897d3fe73a7bd50a7c2f2a85a0ab6]
stable/6.1: [c98a2a8a9d685c90a3c5d5b272f4c531ebb80903]
stable/6.12: [a725401dd629c6fdda47e3a02efed539ac0ed6d0]
stable/6.18: [2009032471be8b9622bf2496ce9c6b06a1015905]
stable/6.6: [2caaca53a181b490ec56575ed6262cdeb82075e0]
stable/7.3: [890fd9c4e02bc9e477e6365fef4ac8c2262a3b3c]

CVE-2026-99752: drm/loongson: Handle buffer mapping failures when clearing a BO

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99752

Introduced by commit f39db26 ("drm: Add kms driver for loongson
display controller") in v6.6-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f00d7a241f846b053e89c0bb2285ef5988d4cafc]
stable/6.12: [389de73fb826e768c73d82c8f9f7e516b3fff70b]
stable/6.18: [834c2fdf737657c3a16c37b894a6bd07277ff082]
stable/6.6: [344a998475ef96b8640516f21b194fbf3b31063d]
stable/7.3: [256ca06920504adde310fb5252342e4b827ebcce]

CVE-2026-99753: drm/loongson: Fix double free on BO initialization failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99753

Introduced by commit f39db26 ("drm: Add kms driver for loongson
display controller") in v6.6-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f086dbdeb6e56510e158a853d752c6d8ed9e0674]
stable/6.12: [6ad25544f1dd24ac512e4d03b5613f4d6d40576d]
stable/6.18: [dd76e36520a9553a4416412aa114217541218f97]
stable/6.6: [683aa6e8d8dfd0c6b07a1ccdb99b5cfe179deb38]
stable/7.3: [c8da4789c0c916fed4d546a2b07423151e5f9d59]

CVE-2026-99754: scsi: target: Verify the iSCSI ISID is null-terminated

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99754

Introduced by commit d04a179 ("scsi: target: Bound PR-OUT TransportID
parsing to the received buffer") in v7.2-rc4.
Introduced by commit c66ac9d ("[SCSI] target: Add LIO target core
v4.0.0-rc6") in v2.6.38-rc1.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [cdf4b87a18cb6a0ee26865cb1b7b5660a491d302]
stable/5.10: [7cc1ed496b739e0f57c10dd61e289a0b27ca7158]
stable/5.15: [c8f8c568a73d1ba6b045dcb94e23ab50633da9e5]
stable/6.1: [54bf2d26275efaa9caad854880ebba1a42f9a2ad]
stable/6.12: [29c5ce6465b5696fbdf8126fcd0a6946b005c8b7]
stable/6.18: [8a71f25a34439e99e094fabb619f787d15aaf9ae]
stable/6.6: [a5ebdf5b5a2105557a22c00b5e678a8d753a1f8c]
stable/7.3: [d1db24c32bbe7b998573392070c3a6bdd9f4066c]

CVE-2026-99755: ptp: fix use-after-free in extts_fifo_show() reading
tsevqs unlocked

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99755

Introduced by commit d26ab5a ("ptp: Replace timestamp event queue with
linked list") in v6.7-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [603a0c40d414ea12509fc45f2b930449a8d4aad2]
stable/6.12: [3d5d16b797a5a7131bb1a1fb81e2dfbe67aa916e]
stable/6.18: [3e83be2d6473118ef6625c00ec9bc6bf99002847]
stable/7.3: [6a236983e79b92d989d7179cf74927330f6606a4]

CVE-2026-99756: btrfs: prevent deleting the wrong subvolume by ID

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99756

Introduced by commit 949964c ("btrfs: add new
BTRFS_IOC_SNAP_DESTROY_V2 ioctl") in v5.7-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1960146913b31b288ed2cd607d103ee3b41681d4]
stable/5.10: [d75be841c195dd64bab6a8a28cde944ba1670ae0]
stable/5.15: [d70a57571d9b248c36830329c36a17a87e130485]
stable/6.1: [bd5fe32d98fd2a09753034c867a138bd0699d57d]
stable/6.12: [9e7dda14b480bf4c515a6eecc516277f290ff2ee]
stable/6.18: [8e64f41414a2e0ec767dfb317103b931b4be0d64]
stable/6.6: [4bdb2a0ccd2aa93e81fcf13c43f2265f60cfe9a4]
stable/7.3: [db399899dbac590d7d124b6896bd113916e7ab09]

CVE-2026-99757: btrfs: sysfs: restore NOFS context on early return in
btrfs_sysfs_add_block_group_type()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99757

Introduced by commit 49ea112 ("btrfs: do not create raid sysfs entries
under any locks") in v5.10-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4172be965c2ce887ebfb1117c634a68555be8c11]
stable/5.10: [0161848843c2b9c4332db8d3fda5c65e0b426884]
stable/5.15: [27e3994f00f4143b642af67edf5c7fa2a3db2915]
stable/6.1: [ff30c0696ee227ada87b5aaa7c3b7758eafa9cad]
stable/6.12: [fa34d172c9e3ee25162f515c77e04247ea780083]
stable/6.18: [b72664c8d0e6aada7f48277968266867fd127ea7]
stable/6.6: [f56c6e48673e3ffd7bf0485939541c028cb6c084]
stable/7.3: [c7011ad8d6941e1a53882c486145935dc5664c6f]

CVE-2026-99758: sctp: account for chunk padding in sctp_init_cause()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99758

Introduced by commit 8914f4b ("sctp: add sctp_make_op_error_limited
and reuse inner functions") in v4.18-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed6c53b27be492643da2017c6f8e2732be5edf1a]
stable/5.10: [a076d745dca8a5f6535cc169e5a06d98beaf5fca]
stable/5.15: [5d1362808bc4513d7fc0f4e8b83af4763e5cbce5]
stable/6.1: [c57df19f74cf5d92bb60c16ac55cdcfe3c81e2bc]
stable/6.12: [28fb74ed3118cd3f59e1b0a5bdba691a2a4c7ea3]
stable/6.18: [fb28092f5feec64f506f198f56d676ba752e700c]
stable/6.6: [25357a42cabb45d4083947ab3ef131946d9742a1]
stable/7.3: [0ff27cefd26182be8366c414478967d667bd8e86]

CVE-2026-99759: batman-adv: tt: don't drop local events queued during
TVLV update

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99759

Introduced by commit a73105b ("batman-adv: improved client
announcement mechanism") in v3.1-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed7a0dfdd370acb48be7a281df732c1bebcc7f1d]
stable/5.10: [ad8c4a893f18fe031370ec76e48ed9a7ac905373]
stable/5.15: [da9816e6aec5dfbfd6795bc512743d05f2029e62]
stable/6.1: [cb9c398903d37d242de0eaf080cedb0ca5531d38]
stable/6.12: [9c456c887ad9c8950097473590923ce8b553d488]
stable/6.18: [5bfa79a27aee75e3f1d84f9b4d4358dbeb9b7505]
stable/6.6: [13ca299f047263cd238bd42efcdf6168755686d9]
stable/7.3: [cd2ff491c8eed4773f4f50ae10c942e09db1f6c4]

CVE-2026-99760: batman-adv: tt: ignore ROAM flag of received ADD changes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99760

Introduced by commit 068ee6e ("batman-adv: roaming handling mechanism
redesign") in v3.8-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5d68abe6e7f1dbd132a602cb696fe1fff0389eb]
stable/5.10: [352e29de27141a3794a23550a34d67b00249056d]
stable/5.15: [f17c643e1055ab0609714d2cd2e64e8ca48a664e]
stable/6.1: [e3d2306052374410ec39274d9933b13e2d492e3b]
stable/6.12: [06d1e0a779c823c9299a1a59e882365732faa48d]
stable/6.18: [08eef283c81a11da88d1159c17336c40d1834a42]
stable/6.6: [4b44181fe598bcc1e430c1483dc4ac4d7e471382]
stable/7.3: [1654eeaccde3bc9fd71b6b316bcc8eb6f4f9c012]

CVE-2026-99761: batman-adv: stop originator purge worker before freeing TT

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99761

Introduced by commit 9d31b3c ("batman-adv: fix potential TT client +
orig-node memory leak") in v3.19-rc4.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f89eda5a9ccf82cba06b085b42ebc4886b8dfe9e]
stable/5.10: [c39b54b2cbdc94e7d8893ece8d3e14babb745fae]
stable/5.15: [10b097f7fdd7aadb43f1e3b0bc0f7189d859df8e]
stable/6.1: [59797c2df15a582bae0d7f9ef9666420489df6ce]
stable/6.12: [2f5a6b491fcecc6abb3a2741f5ba5e0c5fd8db5b]
stable/6.18: [318b5a4eb1cecf7a4d5291f5265925119b454eab]
stable/6.6: [54f1e9545f64a730284368ad209ce31c9dedc4aa]
stable/7.3: [310479adf366e73944e0d75cc8ec11e99327dafc]

CVE-2026-99762: batman-adv: mcast: validate tracker padding before forwarding

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99762

Introduced by commit 2dfe644 ("batman-adv: mcast: shrink tracker
packet after scrubbing") in v6.8-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea01fff30f631e67ee5f0a2b97855d772b3a35fc]
stable/6.12: [441b922dd65fc50b9b32c2116c4058e96d0746c0]
stable/6.18: [bc9419c51ec011447d63c5c262482d3a682f993a]
stable/7.3: [dc52eedaf27cb9ca4f52202f391c1793c0c54eba]

CVE-2026-99763: 9p: don't decrement a server-owned zero nlink

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99763

Introduced by commit ac89b2e ("9p: don't maintain dir i_nlink if the
exported fs doesn't either") in v4.17-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e915aa8566173b44146bc46177c85afbe6bdf96]
stable/5.10: [21eff52475070ccaf91677d9516d11df3c6ade91]
stable/5.15: [f12fd1899eb570104cd2c0b649486470326dff99]
stable/6.1: [ae24a3e84d9b226d944b3414d78877b8c7313b16]
stable/6.12: [5980952fa41f822440f90df7e4628d4b61d22589]
stable/6.18: [9ea87af4e675ae5c3781f2f362c062a13a93fe15]
stable/6.6: [528cca4452d4aa3fef802e464867788a09803ce3]
stable/7.3: [8d247ae04b11459bc7d2ee295c2327e16a0e2893]

CVE-2026-99764: 9p/xen: validate the response size from the backend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99764

Introduced by commit f66c72b ("xen/9pfs: receive responses") in v4.12-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b4cf60c6b739461c5b4ec9c52587da6b2608786]
stable/5.10: [13bf56cea3953de1af727bda5fa7c922f0df4940]
stable/5.15: [bc445b78cb28825f5788ad21dd95272df244e999]
stable/6.1: [b36f4cc60dd1141e13e3c3921f3d12be6e3d986e]
stable/6.12: [79a3d1bfd5b25bd0da01df4a364c113715146970]
stable/6.18: [0ca38f8aeca45f47123cbf65710b889078558f8a]
stable/6.6: [5574c6dbf2425210598cf21eb313ac65bbb83be8]
stable/7.3: [c342fef95252c92c46531da676784c833806fd9a]

CVE-2026-99765: scsi: target: Fix demo-mode dynamic ACL dev-entry UAF
vs LUN teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99765

Introduced by commit 49cb77e ("target: Avoid mappedlun symlink
creation during lun shutdown") in v4.11-rc7.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [6a6e7d7230cd4e0a6c003bae5b85bf37a1e77b94]
stable/5.10: [386fee5dfd771f6f4c57cc50b92afe1285b1c3d9]
stable/5.15: [64337616fb6edb04b799e921d1c10485af8a0c4d]
stable/6.1: [1131ead1d2789077105ecf1cc86cd545f39eb22a]
stable/6.12: [d17b0e4c7aeed9dac88f3ffe4f8823867d1b852e]
stable/6.18: [c8b6eec86742f736a913aba7d7c1d0cedb1d7751]
stable/6.6: [1ff3d3c6df9c1dcee185bc38ae18cbb7ab1ef072]
stable/7.3: [78ad4413fab0cbd42c7280b5069ed2dd3f039162]

CVE-2026-99766: scsi: aic79xx: Fix NULL pointer dereference in device reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99766

Introduced by commit c67e638 ("scsi: aic79xx: Do not reference SCSI
command when resetting device") in v6.7-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f057a8bfeb6ff89c65e95540b8700a53c66d4a31]
stable/6.12: [8eba199dce256eaa2ee3da460588f2ba5494a4d5]
stable/6.18: [856e3bf320c777b4676d58166745d1c96670574e]
stable/7.3: [dab8971b78d13d0aaca40e96feb6188b85d3c752]

CVE-2026-99767: xfrm4: use a full socket for local errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99767

Introduced by commit 0e4fbf0 ("xfrm: iptfs: add user packet (tunnel
ingress) handling") in v6.14-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5def91015ba7b59de62a81384572da7281b8a033]
stable/6.18: [21ba931b2eec642b1c440e0b6eccc2d80f945060]
stable/7.3: [e465b8f50337d0fb3b9753be6cb9fcac79800046]

CVE-2026-99768: wifi: mac80211: reinstate IEEE80211_TX_CTL_AMPDU flag
in ieee80211_tx_prep_agg()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99768

Introduced by commit 592234e ("wifi: mac80211: Fix iTXQ AMPDU
fragmentation handling") in v6.2-rc5.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [25e73f1d6868c759c8eb56cad4e411692c5341b4]
stable/6.12: [fb658fe8f26994da161cd75f8e32afdef4ed134e]
stable/6.18: [fb9bcf4d90538ad30979266aa315fe3c5b9f1942]
stable/6.6: [261f8430f7bfc59fd312fdcfd8609dd7a44bae3b]
stable/7.3: [03a00b6be3cec2e701e05c877cc210f4555d8b2e]

CVE-2026-99769: drm/vc4: Drop the BO reservations outside of job_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99769

Introduced by commit 0463079 ("drm/vc4: Use DRM Execution Contexts")
in v6.15-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ef66514d7b993c9fb96a5886f001e3556610c1c]
stable/6.18: [548546866909b5e7dea02ac0efb9e1b8d6652d77]
stable/7.3: [6bdd3a24acae6a5f888cca9c148a5c8175f1c5b0]

CVE-2026-99770: drm/vc4: Publish the output fence outside of job_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99770

Introduced by commit e84fcb9 ("drm/vc4: Export fence through syncobj")
in v4.18-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ee552a42c3905b4547e83173d46413137ec329a]
stable/5.10: [7ab29cba85fb016c0921b7e22854a00117b05a1c]
stable/5.15: [65592d2780b97d99829cdc27168b543f39d61358]
stable/6.1: [6d60c8d840138e9858c45b0ce17076f4d2556633]
stable/6.12: [54c219a3de9439fa003b45500a7ea3ad5e2eb6a9]
stable/6.18: [ceee27de7b9d8e9771c8ebda48b6836aa2c4466b]
stable/6.6: [5dc3cdaee6c6ce7d20d508b9376604270ba07ceb]
stable/7.3: [e16cc0843946e998b6dc6c4b41fee8d9e324ccec]

CVE-2026-99771: wifi: mac80211: reload TDLS header pointer after skb_linearize()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99771

Introduced by commit 8a4d32f ("mac80211: add TDLS channel-switch Rx
flow") in v3.19-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35c5a5ea4418571997a7e7af3e7e8922b136f6e6]
stable/5.10: [792b7b3ca335e0f7ed5bb94a20473d1989b97e9e]
stable/5.15: [26203fea51cd17925e2838f7924cc0c93c2f7bfd]
stable/6.1: [e62a1b15a77bc25b465ca1561b4078d17020b077]
stable/6.12: [25af938d604fa729e0d5292b4f56bc81aa8d0d25]
stable/6.18: [16e23c766ecd9f378e09d29ac2ff59c88a656da5]
stable/6.6: [af40bd9aa14a29618aceee2184367b0ab7d2433c]
stable/7.3: [5251ad1a6caa35e6d8378aadb909d3f0a675f321]

CVE-2026-99772: drm/drm_crtc: fix race with dma_fence_signal() in
::get_driver_name()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99772

Introduced by commit 541c8f2 ("dma-buf: detach fence ops on signal
v3") in v7.1-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb104d395da48d965665fefe8502f71b6e7e3733]
stable/7.3: [84b31b9b294ac2f41fc7720444b9171e62562e6f]

CVE-2026-99773: drm/drm_crtc: ensure dma_fence_ops remain valid during
device unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99773

Introduced by commit 6d6003c ("drm/fence: add fence timeline to
drm_crtc") in v4.10-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3be436cbd3d265fe4fcfbb5b650edad7b2108443]
stable/5.10: [6b046b7132b194c73078d237e4220497516011dd]
stable/5.15: [54c350d71a158f005c4613f32f1b0a57777d0a2a]
stable/6.1: [1b0bfef4e31f3c02ed54de519b15b840d5dad804]
stable/6.12: [dd9a96b2271e28340acf2e3764914fe5f32f6102]
stable/6.18: [07b2d7a3f2b984c20f5f2630a94f43ede387a8dc]
stable/6.6: [d07a8465cd50a78d55b745ed002d5accf4a6d0a6]
stable/7.3: [f8e6f4deb868fd9da3eda95db222609ab1edc18d]

CVE-2026-99774: xfrm: espintcp: reorder operations within espintcp_init_sk

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99774

Introduced by commit e27cca9 ("xfrm: add espintcp (RFC 8229)") in v5.6-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9a11716c8445b496e9fafeec7e8412d384d02e2]
stable/5.10: [b3db5d2f73f3246bf42865f317727338586bf9e7]
stable/5.15: [fc33bc17ec5c127d0b80b2650c4e83ef64079368]
stable/6.1: [ccee76927f45868e9abe318b95cadae728834ccd]
stable/6.12: [6653f281a84dfc050042b837fbf0a1ab87f8f645]
stable/6.18: [d50065a04b8b2edd9215a1960a48c4a4667a5b8c]
stable/6.6: [505e5d5bf1248fc011523bbe7feb5ace3cda5d62]
stable/7.3: [3eac7cf352cedd05215bdc7e9786c3ee4b4b43b2]

CVE-2026-99775: xfrm: interface: validate the IP header on xmit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99775

Introduced by commit f203b76 ("xfrm: Add virtual xfrm interfaces") in v4.19-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86de3a1118a16dbbbe5fabe9aa20ffb93c072ed5]
stable/5.10: [11c2ece8914c2c4b76b86517a8500eb0885ec1b4]
stable/5.15: [7d38336911bbcc4818de93c5f1afb5cfed68f1ce]
stable/6.1: [0fd4866adfeca8e120637044f76948c38541ed64]
stable/6.12: [289423502470ec7377efeae20fa802523f336356]
stable/6.18: [2b1e92bd69d0fbb2e1d974e7b57d07429ee902bb]
stable/6.6: [54bfe04a3c0a98c69fb500b717ea680ea597e88d]
stable/7.3: [56f9254cb83d93033e449f70cd9b896bbc3c191f]

CVE-2026-99776: net/9p/usbg: clear stale client pointer on close

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99776

Introduced by commit a3be076 ("net/9p/usbg: Add new usb gadget
function transport") in v6.12-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a478958f4c1181ff3362f8857b489c2d069f9c7d]
stable/6.12: [e56ec7e03bec90050368b9bc268d1de098bb92bc]
stable/6.18: [951a7562ecde301a30ded7305b61dd0e9784bee8]
stable/7.3: [c090c95f747714999a3fdebafa07b663473b7b7b]

CVE-2026-99777: net/9p/usbg: remove bogus context initialization in
alloc_requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99777

Introduced by commit a3be076 ("net/9p/usbg: Add new usb gadget
function transport") in v6.12-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbdb38b2e543ffa72dca5450f2535cf998ef1cdd]
stable/6.12: [3bd662cdf7d18d12be2c6010fe4049b02763d8ec]
stable/6.18: [591939db7cff9ca80a5a5deb2e3371b731817ac4]
stable/7.3: [b3d262be54f5cfc5f75f7271e94d64a6315cd2f1]

CVE-2026-99778: net/9p/usbg: fix out_req buffer leak in disable_usb9pfs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99778

Introduced by commit a3be076 ("net/9p/usbg: Add new usb gadget
function transport") in v6.12-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f9807270c7bda8f86b312ed1a8acd7716600555]
stable/6.12: [b941883db4f3ea5bf57bc8600f945f07b8ba2115]
stable/6.18: [fbdc36c04927c08eb676a5db2120e986654ad17c]
stable/7.3: [9ea2ffacee886707b8728c6b62d9e9650e2733ec]

CVE-2026-99779: net/9p/usbg: call disable_usb9pfs() from usb9pfs_disable()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99779

Introduced by commit a3be076 ("net/9p/usbg: Add new usb gadget
function transport") in v6.12-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd1988cf723c2eae87112b198bf90b0aebfeaf31]
stable/6.12: [2d2e942cd9a8fc1f11e3e8e0340a0bb4ec1e9b9c]
stable/6.18: [52544826f345280beb13d150c3bc41e61353fa0c]
stable/7.3: [277167375d269e411e2c5ce79527ff3ebf57a0bc]

CVE-2026-99780: net/9p/usbg: always reset completion when disconnecting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99780

Introduced by commit a3be076 ("net/9p/usbg: Add new usb gadget
function transport") in v6.12-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08c6b9f484a406d9d87c5b2580725d2e0597f3b9]
stable/6.12: [ec4fbfe4f33318f3d081c879e50fb66b9b1304e3]
stable/6.18: [a3a82145d7b382badc16eea965d129a3e9e68e3d]
stable/7.3: [56a679b49c0598ec0d051b0f592c978fdc77f5a6]

CVE-2026-99781: net/9p/usbg: set client to Disconnected on usb9pfs_disable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99781

Introduced by commit a3be076 ("net/9p/usbg: Add new usb gadget
function transport") in v6.12-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [795f8eeca01d1c9ca3d9a450385b7745ace4e53a]
stable/6.12: [8d8405c6e4e4a7bfa191806c4ce1de95be2a9473]
stable/6.18: [8748824822212318a29e2f0312b2b2f4d77bf3d4]
stable/7.3: [fe814d4a3a3ecd8962cf8289e0c41061f2935557]

CVE-2026-99782: net/9p/usbg: also disable endpoints on p9_usbg_close

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99782

Introduced by commit a3be076 ("net/9p/usbg: Add new usb gadget
function transport") in v6.12-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f81cdb9164806eb2df1e1c6df402e03bff7dde31]
stable/6.12: [56e988e24bd453248faa05ed7d2f8c2affc0f3f0]
stable/6.18: [daab785372d9ee206845af7d59522ff02d9a64ca]
stable/7.3: [3f2f5b01cddeecf36738f5d1f056ea82d1b3290b]

CVE-2026-99783: net/9p/usbg: Fix use-after-free in disable_usb9pfs()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99783

Introduced by commit a3be076 ("net/9p/usbg: Add new usb gadget
function transport") in v6.12-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f401e350939442b2ac905f7e5ac952e3802a5d8]
stable/6.12: [f71172094aeb997efc5dbd01d183db480b308d85]
stable/6.18: [e1c80ecafc65af4100e761844c8aa16be9554bd7]
stable/7.3: [197f886898325b191147e9015a47f969a2568838]

CVE-2026-99784: 9p/xen: fix refcount leak in p9_xen_response() on wrong tag

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99784

Introduced by commit 728356d ("9p: Add refcount to p9_req_t") in v4.20-rc1.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [4d183e6f153245aca2534e372152583b868dd925]
stable/5.10: [6d9fb43bdf4a9640761f17d293c1db1baa1a7d21]
stable/5.15: [c823db831f14b508c97db337c7eb100eaffbbd87]
stable/6.1: [b4026bf188460e93dcc0394d28c0a1e54ff6f3d7]
stable/6.12: [f05c30653f6b25766f2e4c18bf015be9b873e18c]
stable/6.18: [1767c02fb555a093b6584fc43f11f0ec1aa32d94]
stable/6.6: [de316ee7344b84299c622cb795feae47527aab6e]
stable/7.3: [3480ece36ed728c2ddda004bc3e2b99bb364765b]

CVE-2026-99785: 9p/trans_virtio: reject mount tags longer than NAME_MAX at probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99785

Introduced by commit 179a5bc ("net/9p: use memcpy() instead of
snprintf() in p9_mount_tag_show()") in v4.1-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5bfef2b6dafe83fe2d8d210d54093a8f48cfc97e]
stable/5.10: [6801a2dbe6014fb12ac32ab8f93f271d911cbfef]
stable/5.15: [493ac68dbb533b8be6c938376b3d80c0bf819884]
stable/6.1: [a5eddf875437a313a9229415d8fe8caa39a65481]
stable/6.12: [1b8a525573d15370d441c8a25fd27161f1d084c2]
stable/6.18: [030cebd51fcfa46eeb916a599fee447c9d3d1170]
stable/6.6: [42eef160f82496e416597cf9ef8c686545286d12]
stable/7.3: [b8779990399009d73f8d039a149c398a9b879839]

CVE-2026-99786: xfrm: retry inexact policy lookup after node reinsertion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99786

Introduced by commit 9cf545e ("xfrm: policy: store inexact policies in
a tree ordered by destination address") in v5.0-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [868f63c8bfafa9b827168c9126f85264c39c02ec]
stable/5.10: [a8595be59bd8b4efe12febe24e88be8aaf30408a]
stable/5.15: [e89a27224b3018177a4410042a1a9d77aafc70d1]
stable/6.1: [0dd6f109432ad24422f2b021c05782f06f66fcd9]
stable/6.12: [f10bd6c317cef7aa15e185e514513e8548f9ce77]
stable/6.18: [6f66839895b7e9c2673df5bd9dd8d5a82033c825]
stable/6.6: [de8314052f753a6f500c1613c92107709a072575]
stable/7.3: [50d8f2c52093320c70676e9f8af686ff6740abd0]

CVE-2026-99787: cpufreq: CPPC: Select the frequency-invariance callback per CPU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99787

Introduced by commit 997c021 ("cpufreq: CPPC: Update FIE
arch_freq_scale in ticks for non-PCC regs") in v7.0-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21e018235d99bc86249b034c06646df8757b2852]
stable/7.3: [309af21d334f970ad32175eefd1f33d154c1160d]

CVE-2026-99788: ACPI: CPPC: Validate FFH register fields before hardware access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99788

Introduced by commit a6cbcdd ("ACPI / CPPC: Add support for functional
fixed hardware address") in v4.9-rc1.
Introduced by commit 68c5deb ("arm64: implement CPPC FFH support using
AMUs") in v5.11-rc1.
Introduced by commit f489c94 ("ACPI: CPPC: Fix access width used for
PCC registers") in v6.9-rc6.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [6b016c5c96448c0a5f09328d37f66562d154a5e5]
stable/5.10: [d729f3a14de6aad1d0f73c78e8581f24c6bc5ebf]
stable/5.15: [e482141cb6519d49c2a2644c87df9e5f96414060]
stable/6.1: [91eb1633ca0151b701e75e3ea9df6c8a781e7ff6]
stable/6.12: [dd2322d548cc1b424da6d07e69eeab7543020106]
stable/6.18: [353c0cb4375c57d282449cf87e8e405c2e8bc8ed]
stable/6.6: [de2295ca3bd51030b395bd0f66fcc6e84571aa2d]
stable/7.3: [4f6a4864308b57cf7aa38ddd07cf4ddcecfbcc41]

CVE-2026-99789: block: restore the iterator when rejecting a misaligned bio

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99789

Introduced by commit 14b007e ("block: validate user space vectors
during extraction") in v7.3-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40d070cbb1906896d6fd65c39722d2411830ed9f]
stable/7.3: [3a6381f254ed81d36f3896f61dcd5d830e08861d]

CVE-2026-99790: NFSD: stop registering with rpcbind after a failure in
listener_set

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99790

Introduced by commit 16a4711 ("NFSD: add listener-{set,get} netlink
command") in v6.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf0f3a37e6ccb78ae80cc6eb2edde4f033c7574c]
stable/6.12: [f21188d163fe7a6c930ef387af5937b9f7322725]
stable/6.18: [d7515faec4d1b3c67c1c18ec28abad83d90ef8c1]
stable/7.3: [76ca00a4eca507550af13118289169bc4b508b82]

CVE-2026-99791: xfs: improve dirent bounds checking in scrub and repair

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99791

Introduced by commit ce92d29 ("xfs: directory scrubber must walk
through data block to offset") in v4.16-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d470234d04dae6fe2ca2cf4b9ef277b78c7e05a]
stable/5.10: [b6c6c498672655a41044d9902c0c9974729d7ad1]
stable/5.15: [93f004cc758cc5ca5d9073d152fa6e939318a9f0]
stable/6.1: [e6b34cfebf652582d3340e7de941e34180560fb2]
stable/6.12: [119778a329881e043920e198d97b7fdd4debad19]
stable/6.18: [d7b9258b930b42a1681171027d0331d2d7e60c7c]
stable/6.6: [1c43eee6a22daddad27d088d49c9a9ffe4e585e8]
stable/7.3: [f365dc588b2a327e693f3203dd1897bd749f6c32]

CVE-2026-99792: smb/server: prevent file publication after tree disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99792

Introduced by commit f441584 ("cifsd: add file operations") in v5.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ff3730998b015b5b0a3f28330bee16c648dd114]
stable/7.3: [fc5ac6813830eaf5b850e89d57403da1e1c50432]

CVE-2026-99793: Bluetooth: L2CAP: Only accept connection responses to
outstanding requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99793

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a518b9a9ef6ee3b18ecdf6ba5360c608aaf969e9]
stable/5.10: [f329df6081cb4e99d4a73281065a3d92c82ff0c6]
stable/5.15: [7c278d26f36e5b51a7181acf2c68086328e52fd8]
stable/6.1: [d947311badc74dae9188909babaf82167dbfdc1d]
stable/6.12: [08ad7b94a31820eb3082851b924f76503fe66ebf]
stable/6.18: [c6789ceaf6e28e97d73434e12c7ae60432f86dbb]
stable/6.6: [db4a4ce799c3a3f7dee864c0d97a73949ffbe3a5]
stable/7.3: [bef1f610bc1f99b349368cb8d9025c2ff66d1fbe]

CVE-2026-99794: Bluetooth: L2CAP: Reject signalling responses in invalid states

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99794

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6320736af7dcb90da6ee9fd651ecc11c564d45b7]
stable/5.10: [5172f560068ca2450e8c850320215b71ae877634]
stable/5.15: [095f49933357941793653944bf64b5ad67dd6fe8]
stable/6.1: [670d87e7dd273f8b620490996a9a2529d831d5b9]
stable/6.12: [9a63e20fcedef1cb9fd6dc771ee364ca83a36bf2]
stable/6.18: [1485880c4c91d69533e08769d033f0868c85a539]
stable/6.6: [8174e111d6d14d29c4481ba621e25c57cb398c9f]
stable/7.3: [c6f3af8470e4f97553a49c48d9336bdd1f927cb0]

CVE-2026-99795: cxl/features: Ensure that count is set before access
to ent[] __counted_by()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99795

Introduced by commit f0e6a23 ("cxl: Add Get Supported Features command
for kernel usage") in v6.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1031c2474f73261d8d5e4deef2b5dc20fb964f5]
stable/6.18: [63714fa4033b51ce615be6f083be0b19847d0d1e]
stable/7.3: [deb8b87c027db150de626a5808f648b1e52d90a1]

CVE-2026-99796: io_uring/poll: cancel all matching requests in one pass

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99796

Introduced by commit 8e29da6 ("io_uring: add support for
IORING_ASYNC_CANCEL_ALL") in v5.19-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9eff9c07e927dcd9c57150cd6fb3d4ec76f00480]
stable/6.1: [58fb2b7c71d94fb88b689d44efd33490abfa7baa]
stable/6.12: [9073da4d5bd87c71235d909512c478e8a13a5818]
stable/6.18: [5310b477e619209b0cceb00b71ebc05a3e89360b]
stable/6.6: [f206ca81adf22efe05eacf2dd54a520249db38ad]
stable/7.3: [e409e1b03059c544d271c7f8e1215c5c0c62f278]

CVE-2026-99797: io_uring/cancel: drop sqd->lock while SQPOLL waits

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99797

Introduced by commit 6380913 ("io_uring: flush notifiers after
sendzc") in v6.0-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb0306c52ffae083a86fb283de67875ae7a9500e]
stable/6.1: [5cb79df890826e3b3eab81a7cb8fa4ebf7dfec90]
stable/6.12: [9ebfcc60793a46eaf60fc34792486c9a6e114460]
stable/6.18: [96ba960a6099935cfc5ea17aef056553f0c8e647]
stable/6.6: [f2219bb2f4027f6f247660ce06ed8bf62f5e1563]
stable/7.3: [682a8804640b6266a4b7fae5a131c57dd8711f70]

CVE-2026-99798: io_uring: defer foreign io-wq enqueues to task_work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99798

According to the .vulnerable file, this bug was introduced by commit
d803d12 in v6.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3de16279b43dc285ed2222aba06cebdc82fdb28b]
stable/6.18: [0ac8f069a8bd7a507df59c505182065ae720e946]
stable/7.3: [5f7e7afd5418c63473f6ac3a05219e9e6e8a59d9]

CVE-2026-99799: io_uring/sqpoll: don't wait for the thread to exit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99799

Introduced by commit 16efa4f ("io_uring: allow IO worker threads to be
frozen") in v5.12-rc4.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [360395e8dbf9d23579f74b84a1af11190813b0f8]
stable/6.1: [eef52e65034bfaebcd9fe75331298fd96e600f7f]
stable/6.12: [a85561cc4fc542443c9e3c363f8bcb2c016da68e]
stable/6.18: [8bfd0b6319261f08b29945228b3377f89211f303]
stable/6.6: [cc907f5f0afb7286185628d0d80f4c0369985aef]
stable/7.3: [8298ce6443ff75f7edc3e30c967270a9c3c12d4b]

CVE-2026-99800: io_uring: free the task context after a grace period

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99800

Introduced by commit 5623eb1 ("io_uring/tctx: add separate lock for
list of tctx's in ctx") in v6.19-rc4.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f5315d3f4368590c9fe06d4313b7247470bcf15]
stable/7.3: [953174dcb862a7a364efdb65e178dcd3aea5562e]

CVE-2026-99801: io_uring/bpf-ops: clear bpf_ctx while submitting SQEs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99801

Introduced by commit 8908192 ("io_uring/bpf-ops: add kfunc helpers")
in v7.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8543a39f03db8816a2d80d0c92c132a19f2afb48]
stable/7.3: [521861b17a107875c884df9474e7746617f256d5]

CVE-2026-99802: io_uring/register: enforce per-task restrictions in
io_uring_register_blind()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99802

Introduced by commit ed82f35 ("io_uring: allow registration of
per-task restrictions") in v7.0-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a93427e99a8524f3612f29ec8bc0da5f8435a51]
stable/7.3: [681fc755316c4adb37ce481894fb619ff2c477fd]

CVE-2026-99803: io_uring/net: mask socket type with SOCK_TYPE_MASK in
io_socket_bpf_populate()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99803

Introduced by commit cff1c26 ("io_uring/net: allow filtering on
IORING_OP_SOCKET data") in v7.0-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e66907c3ba229399ecfb4ef032b95a4a071c894e]
stable/7.3: [cf635f0def46818d43f40c816b6ba0ff5f3f1618]

CVE-2026-99804: io_uring/io-wq: save worker type before dropping its reference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99804

Introduced by commit e6db6f9 ("io_uring/io-wq: only free worker if it
was allocated for creation") in v6.2-rc4.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [37e425460b7c41687e51e3254b1eb1d799da9614]
stable/5.10: [e47f206b8e582d34ecb4683445ef2b60485021b4]
stable/5.15: [ac0dfebeb0c38d697036d43ddcfb666613d42c74]
stable/6.1: [1869f517f7b16cf9ee509f0d46b9a51c15e9df25]
stable/6.12: [9d7af67e5425ad08d1ab9bbf4a3ad987d7871834]
stable/6.18: [2efcf743664ab4a83b4fae1f152bbea1d298e73f]
stable/6.6: [ac028f54ba7e7bd47548e94a518f1f2bd73cbd3a]
stable/7.3: [11239f2b509cd09d76c564b5fe262c70bad8ea3c]

CVE-2026-99805: net: limit priority VLAN untag depth

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99805

Introduced by commit 36b2f61 ("net: handle 802.1P vlan 0 packets
properly") in v5.2-rc6.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3ff07f5acc573e5f72bf1c581bae5d05191ba61]
stable/5.10: [e80d07f6f08883c922d1e029a0a75ff3fd81e658]
stable/5.15: [376aa7635f7b2ded1012b6dbdef6ead4d072962e]
stable/6.1: [834b0ab00c64886f1de280530c21a40374a6a75a]
stable/6.12: [dedb3f9aa54a3fcff41373ed948078d35c0cc50e]
stable/6.18: [3646b7c04717004d0abfc71dd35d25a646c34f45]
stable/6.6: [052a62de6e467646a2a5f8baced4ea319319ae75]
stable/7.3: [e9e219cc9f542041ab1eb7ac10bf6f01a9d7ed01]

CVE-2026-99806: Bluetooth: L2CAP: Reject mode changes on connected channels

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99806

Introduced by commit f2fcfcd ("Bluetooth: Add configuration support
for ERTM and Streaming mode") in v2.6.32-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1398cf11b31a94c27ed810ba69515e0df5ce379]
stable/5.10: [6525cd5756a3d632c1a5d315c8d2dc22ecd88a82]
stable/5.15: [061d594cf2ba58bf924735bd245c468ba106c03e]
stable/6.1: [b82a10836924702140814cf885531e7ff5cdaec0]
stable/6.12: [5ffc623798d65fa972d3bdde24845421e5ece957]
stable/6.18: [ef5743bd6ede07529f0b88f26443a06b8d1c020a]
stable/6.6: [37569b4f53a5fb3e7bc47a420d73e8c12a6a3102]
stable/7.3: [9d4586b143573de4c40db1036cb23a560f149473]

CVE-2026-99807: Bluetooth: L2CAP: Reject invalid TxWindow in
configuration requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99807

Introduced by commit f2fcfcd ("Bluetooth: Add configuration support
for ERTM and Streaming mode") in v2.6.32-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5ebb0245fe927cf5fa33510a9cb2799c4a2dd01]
stable/5.10: [e8885e1db7df5be64e82ef2b953b4a32e8b10e0c]
stable/5.15: [68340dca01ae410327b698fc989a610618870f1b]
stable/6.1: [d588344600b70c9508c33a8cdbb647aaa38fc00b]
stable/6.12: [774badce7fd0afd8897ba1631b5aa7a259443fbf]
stable/6.18: [c00719deed5b6245dedeeb8d6d19cb852fe2ac4d]
stable/6.6: [6918cd1b9dbcc4ceff17937730faf4f621cf617c]
stable/7.3: [a6a8d864fc7106aa997cb3ef4adc1ff9c5ea6a79]

CVE-2026-99808: Bluetooth: L2CAP: Use default TxWindow for zero socket option

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99808

Introduced by commit 14b5aa7 ("Bluetooth: Add sockopt configuration
for txWindow on L2CAP") in v2.6.35-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [226fa3b676cbf2236f803bccd347462433ffc2c8]
stable/5.10: [7ec69b3d1a768609dbb4cd1599f832f1ee373341]
stable/5.15: [0692f239096bd20b98380b1d04767de3f46802f3]
stable/6.1: [f8020b064766de6cc855b6b8e3a6fd8b7c3c54c1]
stable/6.12: [abf86216bdc04cf2917c516ef15532510252a25b]
stable/6.18: [eb86688484688e7626f71f0a98583f9cdf760f13]
stable/6.6: [7f81ca14df465796603f32ef941f703358651a50]
stable/7.3: [ad9fe095e539f2f2d76a2bc49dd7662596997973]

CVE-2026-99809: vfio/platform: prevent read-only region mappings from
becoming writable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99809

Introduced by commit fad4d5b ("vfio/platform: support MMAP of MMIO
regions") in v4.1-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [420bed9131dbbe37abe9d6b32af51219875811e0]
stable/6.12: [61e756960f715a29fc7f595650e3e5ecc1f7579c]
stable/6.18: [b9289740d2292f02a925f1e34607db678c91000e]
stable/6.6: [0cd753aefee70beced31e89fb4ed78a795411bd0]
stable/7.3: [97faad50e37e5de90eea4f1fb132576b7f9211db]

CVE-2026-99810: vfio/fsl-mc: prevent read-only region mappings from
becoming writable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99810

Introduced by commit 6724728 ("vfio/fsl-mc: Allow userspace to MMAP
fsl-mc device MMIO regions") in v5.10-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25fd8b27ee8d4f59cc2ad99cf67aef4570b82096]
stable/6.12: [6358b4f3e87c4a81d476dae59737ca083c367292]
stable/6.18: [7094d4fe5fb6860e150e790784193e07c8a1ff9f]
stable/6.6: [7aaac9b7fb576512f096ca6841ebddb158e2b228]
stable/7.3: [3043b82aace2dddb7d12585ceee69afcaf657fb7]

CVE-2026-99811: vfio/cdx: prevent read-only region mappings from
becoming writable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99811

Introduced by commit 234489a ("vfio/cdx: add support for CDX bus") in v6.5-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c5cd385d295fa8621dff0e9f6063e3f6ff24159]
stable/6.12: [3eaabe24a0c0c1c67388e2b4e8624ca484a739eb]
stable/6.18: [a82df58e3dbf35325a7eec09d0aa8e16892a3ce3]
stable/6.6: [9628e3fbe9680f5025140cdf44fcbb1de9f8a789]
stable/7.3: [0b4d943393cb75aa398db220c0fa192ed856b6e8]


* Updated CVEs

CVE-2022-3108: Kernel: kmemdup's return value not checked

stable/5.10 was fixed.

Fixed status
stable/5.10: [6a99546222eb2020e112fd9db7ad9100f1743c45]

CVE-2022-50310: ip6mr: fix UAF issue in ip6mr_sk_done() when
addrconf_init_net() failed

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [7cd0f52ee4813854cad75775b78476b32f679abb]
stable/5.15: [339f3a03547ac65efe828168c7b94f25bf030ef1]

CVE-2023-4133: cxgb4: fix use after free bugs caused by circular
dependency problem

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [90052cb089612078e602c972f5225cd35fc39574]
stable/6.1: [b95e8ce8fbe317af49e0c1e1a76c97eb7bb5afe2]

CVE-2024-21963: iommu/amd: Force device table to maximum size

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [53d065f896347e22c8aec40524e6ea17a81eb7e2]
stable/5.15: [3d44a3c737901ccb39799f5b926946a3f928b494]
stable/6.1: [fdb721868f361aa33b79e79c7bf261bd2c4f8686]
stable/6.6: [c01e5bd5a6ad66c94834d8d9704ff0a15869b3b0]

CVE-2024-26669: net/sched: flower: Fix chain template offload

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [118823d722a2983da8c821af80fb39cce3e71adb]
stable/5.15: [85a8b5f3b5e5f2c15a7b6a86976d41e540127ce9]

CVE-2024-26823: irqchip/gic-v3-its: Restore quirk probing for ACPI-based systems

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ffef7a11e05049e5591fb6411dfcba8123a7ecc4]
stable/5.15: [de5a9a610ecaab2a148321251487157b6670609a]
stable/6.1: [4ecd3c4771a131294fbe1bc6094a8ab12914d985]

CVE-2024-42098: crypto: ecdh - explicitly zeroize private_key

stable/5.10 was fixed.

Fixed status
stable/5.10: [bd93f02ec39c731ea05f48072f83006281b592f8]

CVE-2024-47745: mm: call the security_mmap_file() LSM hook in remap_file_pages()

stable/5.15 was fixed.

Fixed status
stable/5.15: [cbd964763fad80b5fb6a2ee40783563933e8083f]

CVE-2024-50271: signal: restore the override_rlimit logic

stable/5.15 was fixed.

Fixed status
stable/5.15: [08628d4548c9d3d26ef76b0fa24b427e1bd77756]

CVE-2025-37939: libbpf: Fix accessing BTF.ext core_relo header

stable/6.12 was fixed.

Fixed status
stable/6.12: [84b3c5fcab11528c16266fd7be14574a125b6254]

CVE-2025-39695: RDMA/rxe: Flush delayed SKBs while releasing RXE resources

stable/6.6 was fixed.

Fixed status
stable/6.6: [54af20221c220f0927ff8f3ce3fdf94a88fd972e]

CVE-2025-40074: ipv4: start using dst_dev_rcu()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [8a426879d820a11f1f83a75c104176b419cac604]
stable/5.15: [0fc847cbb7d214dd05e73ed885bd3a243185b9e0]

CVE-2025-40075: tcp_metrics: use dst_dev_net_rcu()

stable/5.15 was fixed.

Fixed status
stable/5.15: [9236eb7e6f6b22c305eb24e107e385c0921f2dff]

CVE-2025-40158: ipv6: use RCU in ip6_output()

stable/5.15 was fixed.

Fixed status
stable/5.15: [51585434cb3851b4dca15e67223bde8987985aae]

CVE-2025-71309: fs/ntfs3: fix deadlock in ni_read_folio_cmpr

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [3c459f027195d549068e51f12b2f87d73a95803b]
stable/6.18: [18f908324379787b3a5f46d42fc581438fb4e865]

CVE-2026-23231: netfilter: nf_tables: fix use-after-free in nf_tables_addchain()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [d719eb1c1dd2e05dbcf5c45d580a4361fb42ba5b]
stable/5.15: [7e3de296af465b65fb941133459dcbdedab7f497]

CVE-2026-23340: net: sched: avoid qdisc_reset_all_tx_gt() vs dequeue
race for lockless qdiscs

stable/5.10 was fixed.

Fixed status
stable/5.10: [a5dee96fc4407f9944e640e0d732ee6de7504b46]

CVE-2026-23468: drm/amdgpu: Limit BO list entry count to prevent
resource exhaustion

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [7ee125eeda83374f3db67dbccece8fb3a5a3259e]
stable/5.15: [02bbf9804ff94cf16d4fa8c1a4c5d8d389d2a177]

CVE-2026-31675: net/sched: sch_netem: fix out-of-bounds access in
packet corruption

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [48358cb08bf7fb712ab773a27edc4a68c980c721]
stable/5.15: [0f550925d7438781bb73ef02eda0efa32cda6d10]

CVE-2026-31678: openvswitch: defer tunnel netdev_put to RCU release

stable/5.10 was fixed.

Fixed status
stable/5.10: [5622cc9ba01f0188690bd3b4908bfc51e252addd]

CVE-2026-31705: ksmbd: fix out-of-bounds write in smb2_get_ea() EA alignment

stable/5.15 was fixed.

Fixed status
stable/5.15: [1616f77677a30d13baac9fa166999ac1e85f7c61]

CVE-2026-45946: power: supply: ab8500: Fix use-after-free in
power_supply_changed()

stable/5.10 was fixed.

Fixed status
stable/5.10: [5835e6a5a7469991c1adc47fa68464fd8d58c2c1]

CVE-2026-46165: openvswitch: vport: fix self-deadlock on release of tunnel ports

stable/5.10 was fixed.

Fixed status
stable/5.10: [780a547de63cc10a8be3bf236d697e892a6dddf9]

CVE-2026-53036: bpf, arm64: Fix off-by-one in check_imm signed range check

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [6ec3fec39fe4ac8910de5c30749e19e66f86a901]
stable/5.15: [09789251d5d222fb60086a3645cd16799e29e6b4]

CVE-2026-53330: drm/amd/display: Fix out-of-bounds read in
dp_get_eq_aux_rd_interval()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [2c8ad3edafef81e033b6e99046ceb70802b69f59]
stable/5.15: [a276dfedf85dcb4996068124185458c2e4693a1e]

CVE-2026-53375: drm/amdgpu/vce: Prevent partial address patches

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [fc91fab65f100bb8a4704d6681fb8c948e404935]
stable/5.15: [f9da80fe4e21b28b2cddc56879813bcc03735c8d]

CVE-2026-63846: drm/amdgpu/jpeg: set no_user_fence for JPEG v3.0 ring

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [2bcfc47a25b15a415195dc9bc9e6cf9d96169d39]
stable/5.15: [5e066e891a25a2c77c6ed16ef727e4777a0b7bb8]

CVE-2026-63847: drm/amdgpu/jpeg: set no_user_fence for JPEG v2.5 ring

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [bdee3501300a40360a2a559821cb23555ff2288a]
stable/5.15: [5e5f7a54f8eddff63911f93e6e4ef1fb67720502]

CVE-2026-63848: drm/amdgpu/jpeg: set no_user_fence for JPEG v2.0 ring

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [597db9a47b93432ffee2861d11449d45dd32a21d]
stable/5.15: [c809956338e607f7f576c5ddf308d673235fd226]

CVE-2026-63962: usb: typec: tcpm: bound altmode_desc[] per iteration
in svdm_consume_modes()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [850f10f37a9dd874d34f31a66b29b7298c19a707]
stable/5.15: [a449d1f86e7d93a58314bd4f3caa28c06ed0202b]

CVE-2026-68081: KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails
due to invalid guest state

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [7b2116c245450d74b0bb9c365b27bbb4f9bf175a]
stable/5.15: [dcaa7a13b51a7f92adc8a8360d618993056af69a]

CVE-2026-68136: net: gro: fix double aggregation of flush-marked skbs

stable/5.15 was fixed.

Fixed status
stable/5.15: [23e0c08bf8575233b2810aa0a8a7c1b0aacc1913]

CVE-2026-68399: bpf: Fix UAF in sock clone early bailouts

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [413fb3e4bec0193d91a648d133c7bc4c0e630ae0]
stable/5.15: [5ec83e8875feece269d41a68a794048ed75831e1]

CVE-2026-72147: dmaengine: dw-edma-pcie: Reject devices without driver data

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [7fba3d4000361d49eb93707b55bd4429a1c0cf2b]
stable/5.15: [1ef4ceb0565ef0ca002a9146fc7dfb24f39fc053]

CVE-2026-72315: smb: client: fix busy dentry warning on unmount after DIO

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [f763f5e383633c057fca58812e69949496087d1d]
stable/6.6: [702cde1d016c70e92f4b525c0e54d793583ab7e5]

CVE-2026-72457: apparmor: fail policy unpack on accept2 allocation failure

stable/6.12 was fixed.

Fixed status
stable/6.12: [2f60459ff878749c54a78ddab676ceb3673e2125]

CVE-2026-72458: apparmor: fix NULL pointer dereference in unpack_pdb

stable/6.12 was fixed.

Fixed status
stable/6.12: [6402a0e0afd9ea25f4fead7fcf84a824d9989085]

CVE-2026-80612: net: lwtunnel: Drop skb metadata before LWT encapsulation

stable/6.1, stable/6.12, stable/6.18, stable/6.6 were fixed.

Fixed status
stable/6.1: [b0ed49c945b727b7a9714caa588bf65c9e73c658]
stable/6.12: [7069cad67561123ccdd290b5008903b1ca755d2b]
stable/6.18: [bc3191da86f6608fbf20b00f9eb10f36034249bd]
stable/6.6: [bbee8e29285edda69874a22708bbe61d7111c74c]

CVE-2026-80771: HID: nintendo: register input device after capabilities are set

stable/6.6 was fixed.

Fixed status
stable/6.6: [4ba5d83bca1ad4d2a0a6bc9e210a91711695c347]

CVE-2026-89534: svcrdma: Clear sc_cm_id when ADDR_CHANGE replacement fails

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [8068226ebdbbca6e8f1f7762021a9ff9ab61fad8]
stable/6.6: [5e6bd7df5d1910b15a0101005f556198226ee660]

CVE-2026-89556: module: validate string table section types

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [7a3cc3a05613a6a653ea42a3c3f09cf46dc0d706]
stable/6.6: [c7e99baf0310bd52187a6d5914948b8933e6c199]

CVE-2026-89566: jbd2: check need_resched() when skipping busy checkpoint buffers

stable/6.1 was fixed.

Fixed status
stable/6.1: [d340f02eea3afecc17c422301d888fb2a36b2d94]

CVE-2026-89567: jbd2: bound shrinker scans by examined checkpoint buffers

stable/6.1 was fixed.

Fixed status
stable/6.1: [930b63861e99ba82693ed8ab5a445577e76e8ba0]

CVE-2026-89646: ceph: fix leaked inode reference on writeback abort at umount

stable/6.12 was fixed.

Fixed status
stable/6.12: [cfbbb5bb6f2e5e907dd0dd25e282b6184861eb9a]

CVE-2026-89739: usb: dwc3: gadget: Fix use-after-free in
dwc3_gadget_free_endpoints due to race condition

stable/6.6 was fixed.

Fixed status
stable/6.6: [34b92575704f95802b60ff1c2a324a4b5c1f9fc4]

CVE-2026-89793: ublk: clear VM_MAYWRITE on read-only ublk char device mmap

stable/6.1 was fixed.

Fixed status
stable/6.1: [82a59bd763d27bb383c2491c24a9a72fbda9004d]

CVE-2026-89812: drm/amdgpu: force complete the MES ring fences on reset

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [def017ba8c31458b8b6cd4e4bcdc10566c461cb8]
stable/6.6: [459248a7b09dee7d91e8755a3dc847587a2eb84c]

CVE-2026-89929: KVM: nVM: Ensure INVVPID is emulated on the correct physical CPU

stable/6.1 was fixed.

Fixed status
stable/6.1: [f6c81481e00f3b389656e11fd18c06fd7371ada1]

CVE-2026-89931: KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is
cleared on VM-Exit

stable/6.6 was fixed.

Fixed status
stable/6.6: [80aea2ba3eaf0ed19ac14172abd3391a86516cfc]

CVE-2026-90036: NFSD: Prevent client use-after-free during blocked-lock reaping

stable/6.1 was fixed.

Fixed status
stable/6.1: [311f40734e703fede77fe64f77f221639fa42c2f]

CVE-2026-90262: btrfs: retry verity reads for not-uptodate Merkle folios

stable/6.1 was fixed.

Fixed status
stable/6.1: [cda08cc783c0804bc1423f940fddd1e4cafe00e6]

CVE-2026-92499: ext4: validate readdir offset before accessing dirent

stable/6.6 was fixed.

Fixed status
stable/6.6: [c9d5bf6d5c9b8515f64506807d37d36b0567ad48]

CVE-2026-93221: nfsd: convert nfsd_net boolean flags to unsigned long flags word

stable/6.1 was fixed.

Fixed status
stable/6.1: [02f56a14d2dc17a687c3ee2d883a1c1c4878a9de]

CVE-2026-93240: memcg: make the v1 soft limit knob inert

stable/6.1 was fixed.

Fixed status
stable/6.1: [6b19c57385bb0f5bce952f2513d60e814b01585c]

CVE-2026-93241: memcg: bypass the reclaim and oom killer for dying
tasks once oom_reaper is done

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [a133be7d56961e8ecdf1eb4f7f61a3988b962e5d]
stable/6.6: [0015b9f592258a8f8a85391035502c520ae47c86]

CVE-2026-97562: smb: client: pin DFS superblock in iterator callback

stable/6.1 was fixed.

Fixed status
stable/6.1: [d976dfb6dc095db47aa5f9d9b02c8f6ccf776094]

CVE-2026-97619: io_uring/rw: end write accounting from ->ki_complete

stable/6.1 was fixed.

Fixed status
stable/6.1: [647026fd61d9d2e628b2f743bbe09bfd9ddde110]

CVE-2026-97906: bootconfig: Fix integer overflow in initrd size check

stable/6.1 was fixed.

Fixed status
stable/6.1: [d0b86ae31e01fac50996bcaf452468c9392cf740]

CVE-2026-97918: tracing: Undo the registration when enabling the
histogram trigger fails

stable/6.1 was fixed.

Fixed status
stable/6.1: [41f41ee7e2bf699ca58856e6bff01c09a4872040]

CVE-2026-97929: ALSA: usbusx2y: validate URB actual_length in interrupt callback

stable/6.1 was fixed.

Fixed status
stable/6.1: [6183dccec04c3a531ea2305d6864fa26eca7cdc6]

CVE-2026-97933: tracing: Take trace_array reference when opening a
tracer options file

stable/6.1 was fixed.

Fixed status
stable/6.1: [6dc46930000f28e593c2d3e99dae7a57eb0f1e0a]

CVE-2026-97938: reboot: fix cad_pid use-after-free race

stable/6.1 was fixed.

Fixed status
stable/6.1: [d66b5f57cb4b8cf1fbcc8fbc0c2f162a6886e97a]

CVE-2026-97949: configfs: unhash the dentry before dropping the item in rmdir

stable/6.1 was fixed.

Fixed status
stable/6.1: [3d3a0b7ee3baaae7d76d868256fbf2324662beca]

CVE-2026-97950: configfs: pin the symlink target's dirent instead of
chasing ->ci_dentry

stable/6.1 was fixed.

Fixed status
stable/6.1: [0bc27c3d2e24376e34c8db590ae6ecef68c6ed82]

CVE-2026-98109: Bluetooth: hci_core: Fix race condition during device
registration

stable/6.1 was fixed.

Fixed status
stable/6.1: [f25b96a424e0ba0ae3176c9681412c020f0f0054]

CVE-2026-98112: ksmbd: fix listener task lifetime on netdev events

stable/6.18 was fixed.

Fixed status
stable/6.18: [45c9926412526c776d5f035cd40cc0b4138f1bbb]

CVE-2026-98174: smb: client: fix rlist race and missing initialization

stable/6.1 was fixed.

Fixed status
stable/6.1: [0d176a4a7f645ef8f216222699873eaeac33f801]

CVE-2026-98175: smb: client: cancel reconnect work in clean_demultiplex_info()

stable/6.1 was fixed.

Fixed status
stable/6.1: [6eeecaff5a8d5291e91f08d20618c947e7e963e1]

CVE-2026-98176: drm/amdkfd: Avoid integer underflow with ffs in EOP
ring size calc

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [4105d54716c6082b2ff495f2506af130ef79ce0a]
stable/6.6: [6a6d407eb4a8b427240b59d0d2d1f8e1878f06b3]

CVE-2026-98177: drm/amdkfd: Avoid integer underflow in EOP ring size
calculation.

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [ab43ca67eca4149d1af666a1ee1084786bde9cf9]
stable/6.6: [0e28ecdfbee856b9e45f53c341a4b37c822d25dd]

CVE-2026-98179: drm/amdgpu: fix rmmio iounmap skipped on device removal

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [84430fb266943bc79ba94f916b5f6179c25bfb3c]
stable/6.6: [a8f42c923e28a58af841d1c03d6cd6ad3bbd123f]

CVE-2026-98180: drm/msm: RCU-free the scheduler-containing ring and VM objects

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [587f5931eef21218c6310685d174cf7e10db93ca]
stable/6.6: [364e2f53616122f06d96aa51d3308413cfe958ea]

CVE-2026-98182: wifi: mac80211: refuse to make a monitor active when
it has no queue

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [9032450f478edbcd1d593a24047018fab684fcee]
stable/6.6: [afaf694c62eb3eb0b43b2b107099a21823fd5d29]

CVE-2026-98212: mmc: hsq: Fix use-after-free in retry work

stable/6.1 was fixed.

Fixed status
stable/6.1: [a59591ed641f1a5610019d99ff657d33c25ad426]

CVE-2026-98216: IB/hfi1: Fix the PIO_CRED credit-return mmap

stable/6.1 was fixed.

Fixed status
stable/6.1: [b32e8846438b810067bf0503757733bd8b4179ec]

CVE-2026-98222: KEYS: encrypted: fix integer overflow of datablob_len

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [7e58a9ac7798bd66fa9d5ef225b3228383785a70]
stable/6.6: [8454e76acf5d65cf0841f1a026cb68b300c36304]

CVE-2026-98229: xfrm: save input state data before secpath resets

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [173bcf40d9a62521f10d11abe914e7f3b84ce8c7]
stable/6.6: [6d4281f79b5ca0e228ab36477f4c67f7b7feb5d2]

CVE-2026-98248: arm64: percpu: Fix LSE operations on {8,16}-bit types

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [bfd4eab3afd8de81104e865c59c2cd15bbd98094]
stable/6.6: [b790ab06fc44d852738572ed6339123bd3474d55]

CVE-2026-98254: swiotlb: use the adjusted address for the highmem page lookup

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [95049ea3bdfee77902b75410ff4d0333c3ba9fcd]
stable/6.6: [ded61bf0ba8a791940d13d90e5bfc2cef0fb0c4b]

CVE-2026-98260: exec: Cleanup POSIX timers right after de_thread()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [b2a912ac5287ec6228f5c49f476b4e73123a90f0]
stable/5.15: [e6a5144198a59a42ec8f10b01c53dd50a031db53]

CVE-2026-98266: ALSA: core: Fix potential UAF after asynchronous card release

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [723b72f35823173d5581839c0a9616c3cc7375c1]
stable/6.6: [6ccbdeaf1a0f7e4baf7be896fca865a59c742615]

CVE-2026-98316: ALSA: bcd2000: Fix race between rawmidi and disconnect

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [c3f37100d0a5a6f8a4c590b696c7b9d58b006068]
stable/5.15: [9a0f09d80cd54a4e9825e00e4aae5e0e121ef095]

CVE-2026-98353: RDMA/erdma: Use IRQ-safe XArray helpers for QP and CQ tables

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [56be3d8d8911da3b7ed444100279b658e871e694]
stable/6.6: [5e30a8fd207b399b77f30d603ceb8f1f05cdebdc]

CVE-2026-98387: s390/crypto: Fix skcipher_walk return code handling in aes_s390

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [c9351478eab196a1e6ab0c3835a8bcafcebd0326]
stable/6.6: [fb59ef72bebd93de44e9eb28831f91f16acc0338]

CVE-2026-98389: drm/amdgpu: skip gfx switch_power_profile during GPU reset

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [0733c5f91df3e9a5980ffd2e761a6ff51829a3b8]
stable/6.6: [d260dee8991b2d3dd99bf6684639224408e86ab1]

CVE-2026-98435: EDAC/altera: Use parent device for devres in altr_portb_setup()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [5dc56959ba8675d267c807e6b3492fa696dbb24a]
stable/6.6: [650be6c7f6407c0334d760fdb57313fa538b2473]

CVE-2026-98439: smb/server: cancel async requests when closing connection

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [3f2730fbb7c19c2066560be9c8583da8f8e260bb]
stable/6.1: [7deb308c29074af724a24e40f9d89dad058ff970]
stable/6.6: [5c8fbd718000f9141c397fc0bed2d92599d5a76a]

CVE-2026-98449: smb: client: delete compound mids on send failure before unlock

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [4e9a1d5c763f751fcc2928f7131f143251e01760]
stable/6.6: [ae288482a10fb0782b606f20ca4bf32d79efec2b]

CVE-2026-98452: smb: client: clean up failed cached directory opens

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [e747942c2441ea06d83ce134f5d56a34985ef80c]
stable/6.6: [cc7e622340b8fa678ac4edbc4b4459b946d07d2c]

CVE-2026-98458: Bluetooth: ISO: release unused CIS holds after channel attach

stable/6.6 was fixed.

Fixed status
stable/6.6: [1256cb8be9518d82a2b07a90bd7071e7742bee4b]

CVE-2026-98466: KVM: arm64: Transfer the hyp stack pages out of the host stage-2

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [e8d1546515ed6851d3a53d4ca114d0afef664f2b]
stable/6.6: [01da663cf9f92e9a3dd5f165cc4db1d15ebeb2c6]

CVE-2026-98473: s390/vfio-ap: fix KVM GISC and page leak when queue
removed from host config

stable/6.6 was fixed.

Fixed status
stable/6.6: [d08e9fa04f3180351013b311e8bb17fc016e732e]

CVE-2026-98503: packet: use ubuf_info completion for TX_RING packets

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [7a4d999680713a0cba3e76bb232c20391657530f]
stable/6.6: [ff80f2a83aebec516d71757ef07b62a621fc03de]

CVE-2026-98505: mm/damon/vaddr: avoid hw-driven pte updates during
damon_hugetlb_mkold()

stable/6.1 was fixed.

Fixed status
stable/6.1: [54a13c4ba2e814687e3d6954aec75d68b88d03fb]

CVE-2026-98506: mm/hugetlb: do not dissolve gigantic pages without
runtime support

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [27f6ae7fa424a3dfacb58807cb552a74b716279d]
stable/6.6: [cac59c26f81796e19428bfacec6db4dade38f726]

CVE-2026-98525: mctp: route: iterate socket tag list in
mctp_lookup_prealloc_tag()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [de069b0e333094441e84c309ceb2af0129f79396]
stable/6.6: [4a2209a5390df1e491296a87b22a14a55da0eadf]

CVE-2026-98539: fs/ntfs3: use d_instantiate_new() in
ntfs_create_inode() and murder syzbot's "WARNING in do_new_mount" saga

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [b4f6bbac3be870fe689f34192a1407ddbc794336]
stable/6.6: [e093dc24ee8e1536ae0ce5b856522cc75b8472f8]

CVE-2026-98574: net: bcmgenet: stop Tx NAPI before disabling the queues

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [3e5239f1482bebcda456353ad904700d6707a773]
stable/6.6: [94f83b28bac6d20ef7872b0eb677770ac0542dfc]

CVE-2026-98665: iio: health: max30102: fix NULL dereference in interrupt handler

stable/6.1 was fixed.

Fixed status
stable/6.1: [9ffc2c60f5b1ff94dc404ffa1eea91b7470396b1]

CVE-2026-98682: smb: client: drain and invalidate before server-side copy/clone

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [0ec9d8af4555cc47038a06923c10156a136faaff]
stable/6.6: [0f934b17e76426f33b5bbbaeb0fbfe9e26041a00]

CVE-2026-98683: smb: client: flush dirty data before zeroing a range

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [78a254a676c7bd18850ce6ee5e8268ad3fdd03ab]
stable/6.6: [2263b748e9180b14649671fd68ee80116286747a]

CVE-2026-98684: smb: client: flush and commit data before querying
allocated ranges

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [697949f6b226084bf3697a3b699b00b4bcfee100]
stable/6.6: [a6891ec0e940380844dd335f87c3bece299470ea]

CVE-2026-98685: smb: client: discard post-EOF pagecache when extending
a file via clone range

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [b80ac4705a515dba51d80611505ec8a95e306d76]
stable/6.6: [b905aea2cd3cd637ae2ab699dc9d5f5b3817060e]

CVE-2026-98707: wifi: mac80211: shut down RX BA session timer on teardown

stable/5.10 was fixed.

Fixed status
stable/5.10: [98ecdee2801780d3c87bb10c1f62577b92fb0e7d]

CVE-2026-98714: KVM: SVM: Update control fields on #VMEXIT if and only
if VMRUN succeeded

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [67482f0be9a8a8f0ec2f1af0d14700e5c6e9a395]
stable/6.6: [11a563aecdc998958dd1e4bf893a5278d2fafa93]

CVE-2026-98715: KVM: SVM: Preserve TLB control (i.e. pending TLB
flush) on failed VMRUN

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [6b0a674bb7b1666e036add54c9d9d711f35bdd03]
stable/6.6: [e6ec697d2c7ec8dbb6f910f60ab19e074d9f3b49]

CVE-2026-98720: KVM: nVMX: Force MSR bitmap refresh if runtime eVMCS
controls are modified

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [4d21946f601f131b220dfe4606df7bd9a729e113]
stable/6.6: [b6f07c3479ba534ab93df9b69222e299a4f3e116]

CVE-2026-98734: Bluetooth: hci_core: Serialize SCO and ISO scheduling
with teardown

stable/6.1 was fixed.

Fixed status
stable/6.1: [97f78e7ad03fea952614d69d949575951ff1b15f]

CVE-2026-98738: Bluetooth: Serialize SMP remote OOB data access

stable/6.1 was fixed.

Fixed status
stable/6.1: [d6d4d6a8f47b7a9aaa92388b937be648c93bbd8c]

CVE-2026-98786: drm/amd/display: guard dc_sink dereferences in MST
mode validation

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [57cb602fe5fae07e696eec73c8f01d522ecfbb47]
stable/6.6: [a3c9aab41ac7428198d581ef071fc5b6874b7fc0]

CVE-2026-98852: net: extend IPv6 exthdr detection of tunneled packets

stable/6.1 was fixed.

Fixed status
stable/6.1: [3dc4a5374e060f93ffc6b81694826c153b1d93ec]

CVE-2026-98853: net: gso: limit recursive IP-in-IP segmentation

stable/5.10, stable/5.15, stable/6.6 were fixed.

Fixed status
stable/5.10: [91b9ce0a29a2ff77bd7efd5963b54a456534af2e]
stable/5.15: [8c1ef2e252158e79afdf02f1d4743c244149684b]
stable/6.6: [9148199b5c3d0bc71288d79c3ee4ce404f090d3c]

CVE-2026-98859: HID: multitouch: stop the release timer from being
rearmed on remove

stable/6.1 was fixed.

Fixed status
stable/6.1: [bb1b7988bd1552abf9a669be254358b3452ea6a3]

CVE-2026-98863: KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting
said pages fails

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [36b4e0174ba66df85e49295ec2a215d87b44186d]
stable/6.6: [f82ac7dc924bdc3b0b2053ae52701e0af0f69c66]

CVE-2026-98978: namespace: never expire a locked mount

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [435ac7f12209979ae3d080c2a8a74d42ea120a0a]
stable/6.6: [b3af17785bec47a65c820c9e75c5bd0a81b94c80]

CVE-2026-98989: namespace: check a recursive bind mount for mount
namespace loops

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [66cd17e97064d94dcce8228409d85e4436eb5e7a]
stable/6.6: [c6653a4598e87be91de90e4daac0d4eaef273e94]

CVE-2026-99021: regulator: of: fill in supply names in
of_regulator_bulk_get_all()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [b6350b2b10f5d4dd4f58851d453d98c760aac1d2]
stable/6.6: [e02018bc617ffe73948dbb6d7a22d17bcf36c698]

CVE-2026-99026: net: team: free skb when broadcast has no txable port

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [0b8b243846c7bbf5933402e2cb5f6b1af73b4bed]
stable/6.6: [a3bb3f8dfc3ffe060aae5b92ff37ad0b68b5b321]

CVE-2026-99076: ipv6: udp: Create exceptions before socket matching

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [26eaa8c6a6c289382f431fc23e64a2fa4228ddc0]
stable/6.6: [128d11b1281f68dfcc9ca403a58e5004e9d13c66]

CVE-2026-99086: dm-integrity: validate the superblock on resume

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [defa3ee88b79b48d85e066f4b5ac416447fdff0f]
stable/6.6: [4a49b9775193e01ec7b6793fb422116b5addd8e3]

CVE-2026-99087: dm-integrity: fix NULL pointer dereference when the
'R' flag is used

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [1afca864e0bfc4294967087cd13b14705cdd7800]
stable/6.6: [3a6d59455ac06e66f3219c9479c513ead6b27169]

CVE-2026-99090: drm/amdgpu: serialize vblank counter reads against GPU reset

stable/6.1 was fixed.

Fixed status
stable/6.1: [101571b7bca6f24bc72b90871db29d01591e03d5]

CVE-2026-99109: smb: client: reject SetEA requests that do not fit the
request buffer

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [f5b3e6e850ed5128b81f798b74c05f762f1d91c2]
stable/6.6: [f4e01cdab7792ac79eaae27fa4bbbebda3c43382]

CVE-2026-99122: vsock/vmci: validate packet source for connected sockets

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [8fa949146d1239f37ab5603c74f2a5218cae9c4b]
stable/6.6: [5af861f59596a756f81bb78597583d81fbde9f1c]

CVE-2026-99133: net/iucv: fix the recvmsg window update

stable/5.10 was fixed.

Fixed status
stable/5.10: [ff8c480210d6e73150f98462983014e52cf3e9a5]

CVE-2026-99146: drm/i915/dmc: Add sanity check for DMC load address

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [a40ea01106420f24484b3c1b93bd95b810f082f7]
stable/6.6: [77222bbae20ac9ec948efe37b93be07cd763930e]

CVE-2026-99172: ipc: drop the mqueue mount with kern_unmount() on setup failure

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [a18e94fa9238a810b5cef56f696232da6aa3e4e7]
stable/6.6: [4ffb61eeb57e0854bff3a25b210bc0500ff0f6e4]

CVE-2026-99178: x86/kvm: Don't consume async #PF flags on a kernel #PF
in NMI context

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [3a5c80f6256b89127330e08be8ed593438b5a0cc]
stable/6.6: [1ee71122bc81483df91b127fd3fb0b2da7634dbc]

CVE-2026-99218: coredump: hold RCU while releasing parked threads

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [bdb000141ece9ceff6df225a24ac2b9ceed780ce]
stable/5.15: [d626e3e458838bf221be1958e074ddeb9f18cd97]

CVE-2026-99220: asymmetric_keys: reject trust keys without IDs

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [78834a4fa2107c994576a60c51f42471f34dec39]
stable/5.15: [0dd657c709df354ddeef1df48fd1e58b5482f932]

CVE-2026-99233: tracing/histograms: Verify event_call identity when
updating synth_event refcount

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [e906114ac237b8d3adc00a2f369c740d2bfe7bff]
stable/5.15: [4c3b009bd0358b48073d509d3df8cb17f2d08c6d]

CVE-2026-99263: [REJECTED]: io_uring/poll: avoid retry wakeup loss
when dropping ownership

stable/5.15 was fixed.

Fixed status
stable/5.15: [13e88f1fd30332595a50f57802fe8f17a4b87b3a]

CVE-2026-99270: tcp: Fix potential UAF in reqsk_timer_handler().

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [bd3a72a14b1040f0e7ea827bd31322e26e2a9fae]
stable/6.1: [d7f28a027af63a9d47784fd89d72ae15d87b7d5f]
stable/6.6: [c130cc5f70b1f8f1f8f18432dfdc90ac59673f31]

CVE-2026-99271: ALSA: line6: Clear prev_fbuf on capture buffer release

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [4bdaa0a9269c09dbed21e3e66bbe566d4f354512]
stable/5.15: [72cb60d5b535a6a8a2693e0e446fae1cfc16ce50]
stable/6.1: [20a1465ee42601f299781c0d24b6d1b30feb74d3]
stable/6.6: [beb5b8043a42dcac47421be48ca47597389bd2e4]

CVE-2026-99272: smb: client: validate the data area in SMB2_read()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [986d13d390167b8dc7139c8725cdbf94ba1f4941]
stable/5.15: [28419979a1cde58a00cb67620fab6df708b70e47]
stable/6.1: [a1e3edee5ec0f261b048a82bfda071195a78dc0b]
stable/6.6: [ba80cf4a8baa546c709fb0581c04d9b3d9f17c24]

CVE-2026-99273: ksmbd: reserve space for the UTF-16 terminator in stream info

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [9703d2f43587570456712333fe04c2bdbc24cef3]
stable/6.1: [a45a8d283bc5225a9b364c4f262a3cab9ced1018]
stable/6.6: [d6642b5b031fb988e65b8e8bfe7ad130f728e955]

CVE-2026-99274: smb: client: fix fiemap wild read on empty truncated response

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [d4daf95579a2fc481340bf4b5d048512311587a6]
stable/5.15: [70dcd9d353cc180bbac8dd18f6f98e49f5861151]
stable/6.1: [893ac2d1866ed9d0594f94a223af2f5265c4c5ef]
stable/6.6: [79928a7c0f8b6ec3197c58877f83054660b6d93d]

CVE-2026-99281: tun: Require CAP_NET_ADMIN to attach to an ownerless device

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [553fd5722b4df7d6c0290d645e31871a64429b6d]
stable/5.15: [43f0727b2a3a79607e8bc2daf2e5fcc02b571f76]
stable/6.1: [ea77d8eeaf10a2976f82aa099dd879b4f65bf711]
stable/6.6: [8d6ff792add6ceada5a137dcaf08ca05785bac9a]

CVE-2026-99282: net/sched: sch_teql: fix use-after-free on lower qdisc drop

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [b847e54010c49aa0ba458296ea13b3ef0e9f0b9d]
stable/5.15: [5ca419582e7681060c6e3ae10849e6524b1d9768]
stable/6.1: [77abedc14f38755ef5dcfaf660807043ab99d058]
stable/6.6: [b8e2df3e238be6b47394d03d4b05af6b15846682]

CVE-2026-99283: netfilter: conntrack: tcp: use UNACK timeout for
non-closing RST packets

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [3abe7c2d4ad196701cb49c24d573b45c7181894f]
stable/5.15: [1e4f5d5850630ede0b764ba7ba5165581d0a7040]
stable/6.1: [846cfd2f0c385a4ffd69831669cb7384d3084813]
stable/6.6: [dc8f4b1d102854ba82de90a8b4546afbef1d2b61]

CVE-2026-99284: net: skbuff: propagate shared-frag marker in skb_zerocopy()

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [1e2c54fd0f85e41b6cbbcaad2e64ac2271d27cb0]
stable/6.1: [646a06cd62594ae8cdfd26c3bf777b2347c6fa01]
stable/6.6: [b44279042133de6f75a51263d496cdfe02d2d276]

CVE-2026-99286: xen-netback: Fix XenBus connection failure cleanup

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [a08833cf37ea98fbeda9979112932e2cb988446d]
stable/5.15: [84076b0eac5fb7fa87da2bf10448d6b8204798f9]
stable/6.1: [0c4940fd6f879511b414f711c6bf24b7ee39e913]
stable/6.6: [a51681116574b35e81d3016888afbecf8bef3ed0]

CVE-2026-99287: xen-netback: Zero out sring pointers on unmap

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [e53c0df3f1bfe26d1c2cbb6f4071ca317b4bc640]
stable/5.15: [6c37dceb5e105ce5fc8d2deacfaf9407ff9ace66]
stable/6.1: [e27c3cd1b18d0b57ef388ea0b8a37ab20ec65c53]
stable/6.6: [acfd4904d2a51b682de2485d346c54cf38490a60]

CVE-2026-99288: inet: reject unhashed sockets during established lookups

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [82b98cca88e1856245e5f18fd3ddd99b6dab4550]
stable/5.15: [a2f5923c195a1d2b0a3988240b28bd89e078793c]
stable/6.1: [1ab6de9bf42a4349e789de1fe287d2a726bfd21e]
stable/6.6: [cedc85d95ce0d552519c4506927a691c5b97a5dc]

CVE-2026-99290: ksmbd: fix use-after-free after a failed durable reconnect

stable/6.6 was fixed.

Fixed status
stable/6.6: [0dfa5491c8652c7335a1f4640e02ceae15e569ba]

CVE-2026-99292: smb: client: fix slab-out-of-bounds write in
id_mode_to_cifs_acl()

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [d1f14e890dff3b19fbc8dec1eb09f09c71ca69a8]
stable/6.1: [773c30f94a027e6a0a9774906d6cff3902dbe15c]
stable/6.6: [51e5772fdfc92a453995aba07ff2aa6e107b580d]

CVE-2026-99295: smb: client: stop processing a read response after a
receive error

stable/6.6 was fixed.

Fixed status
stable/6.6: [d3d007b7f63310fb6f9bb4ed24d74c14ee34b0b6]

CVE-2026-99296: libceph: bound mon_command ack decode to front len

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [80d86b0d68e9879685da2cf03f176659e2b4b889]
stable/5.15: [f27c07251a5c0eb3da39456ec62de31307407bd8]
stable/6.1: [cbaac517ababcc116988e6ee1f3ad170b4b0b8c2]
stable/6.6: [b4debc9609e9e16444942099efd31ce230fc6154]

CVE-2026-99297: media: em28xx: fix double free in em28xx_alloc_urbs

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [c4ca656ac8f6ee0808fb6789b1b7abc50acb7b3a]
stable/5.15: [504fa5e460aa0f0b9b1aa4958c291ad3f0f5faa1]
stable/6.1: [7e88a3d81166e669d940ac8c1033b8b196d79ba8]
stable/6.6: [8eaa3f63541dd03ae0457d89dc3e891f37412354]

CVE-2026-99298: net: ipv4: add zero check for snd_cwnd_clamp

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [adaf6842e9b66facfeb037b467f75247f30d7481]
stable/5.15: [1adaa73907eea3ce3e189de28867c3cfb73d099c]
stable/6.1: [c4e6c9332e0f0337a6ba19665a6a223dc2acc049]
stable/6.6: [195b61e4067a3f9d733d79df8ac7839d253d7281]

CVE-2026-99299: media: em28xx: reject audio endpoint with zero packet size

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [d5503ac5852cee1507b4d5f5cbd707f106c72542]
stable/5.15: [5133b8c5b458cbbd697900c267e72251bd1682ab]
stable/6.1: [c799a49bdb68c3cb3fa837fc8eaacea1c2bfbc56]
stable/6.6: [3227c593dad737a6b13a103b5f6a5f44239a4947]

CVE-2026-99300: media: go7007: only set audio_enabled if
go7007_snd_init() succeeded

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [63c4867908c5961335f163bbb42657a5f68bdfde]
stable/5.15: [9cbebcd98e74f3fd9f931c7425f28e007e9a896b]
stable/6.1: [ce761854e094e4fbdd4a2b83835213574dd39460]
stable/6.6: [c6791aabde0e84aef319f326afe25245b9e96cf3]

CVE-2026-99302: nvmet-rdma: reject short connection requests

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [9adc20cd6765da78276428a189e7c21ec7f522e5]
stable/5.15: [7a38c6f7b5681fccb5f6975943be8f7c83222eba]
stable/6.1: [a646fb4f3404b228b725f0891c7c3800e0efad38]
stable/6.6: [2409f47284ff77eed3fa4211149ff160607ba96d]

CVE-2026-99303: speakup: Fix NULL pointer dereference on VT switch + selection

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [77fd68ef5b158b40827b2ca194878c78236ec552]
stable/5.15: [65d20c7957cd7a738ed8e240307a2b545f66f8f3]
stable/6.1: [4caa7e5efd459788fe012c9c7a0ae5628ed490ed]
stable/6.6: [5e79aa7cf999fc0013a1bddb31920fda00361fd8]

CVE-2026-99304: ceph: fix integer overflow in the snap trace bounds check

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [b4e69d35322036487941d32fd4055deb6a49f267]
stable/5.15: [63560ef6e6bd060414fe67fc2d1c89008184ad17]
stable/6.1: [442b879c34020ae8034626c83192f94bf6e048e0]
stable/6.6: [dc59983d1a4c8968645c7005f843ec6d8c86291e]

CVE-2026-99305: fbdev: udlfb: don't rebuild the mode list while the
framebuffer is in use

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [16b33efe3f208268805d9ae800802f7a58f87a5d]
stable/5.15: [21b4518d1b6f9de8561a7a98585f42b73900df26]
stable/6.1: [8417440bc3cc5f1cda8795d2b34eb00d1b6b1c3a]
stable/6.6: [1384bb0fa380898a944b8fc71c928a7a9932e682]

CVE-2026-99306: ceph: reject mdsmaps that claim more than CEPH_MAX_MDS ranks

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [09517f7290d67a7d8d52ef09a969b4788a4bf1dc]
stable/6.1: [3e4779e926ce5141205741d6aa50aef2d58615b3]
stable/6.6: [a2d198f691e6a4e0db370eaacb0cfa094bcbc914]

CVE-2026-99307: ceph: require the dentry lease record to cover struct
ceph_mds_reply_lease

stable/6.6 was fixed.

Fixed status
stable/6.6: [62912da82e00aad7cc4d478debb3d648204ebe47]

CVE-2026-99308: usb: xhci: Fix bounce buffer overflow

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [781847f821ab08e22819704b9c6b7ca451854e7b]
stable/5.15: [9bcb39803f65ce8776278021d19527472a2badf6]
stable/6.1: [9e993c586e781056dd29dbd0a84582fb7714c1c7]
stable/6.6: [30fb8c91a47b00616497f8b8493e0e483bee12ec]

CVE-2026-99309: ksmbd: fix overflow in dacloffset bounds check in
build_sec_desc()

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [e32f5d4b1817ba3e9b2b09e4ad2ae6f100f94820]
stable/6.1: [5ac0483e543a8ecf18f5c571cab4cd7d215e1af5]
stable/6.6: [82048635ea5fbc625ed810dfb4dc85a7e47a594b]

CVE-2026-99310: nfsd: hold cl_lock in client_has_openowners()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [ef656992099e2eaa85dda51c8065c65a2f6776c3]
stable/5.15: [41fc0b50b443096a65691b08259478f52540bc75]
stable/6.1: [ea3d70a269976c443181c49d40a8101cb4ed4aa6]
stable/6.6: [7f6b35b5a5f7ac175c6cd1ab4d4f58fee21d59a4]

CVE-2026-99311: udf: fix return value for non-recorded-allocated
extents in udf_map_block()

stable/6.6 was fixed.

Fixed status
stable/6.6: [744d27de2819bb3bbada2ddb380c0fa798d322ce]

CVE-2026-99312: KVM: x86: Unconditionally reset MMU context when emulating INIT

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [97be39acdbd7f33fdd8d8ca900d16fbd05482683]
stable/6.1: [1c59317eba381503abdf38251a687d0e772abbec]
stable/6.6: [87bd6507186c6357fb9267ab5aca869c57f0ef54]

CVE-2026-99314: ALSA: us122l: Add missing NULL check in usb_stream_hwdep_mmap()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [683e063b0ed300d2c09e64b21509ec1ceb6d23c0]
stable/5.15: [a4e41eb6cd57b3e6e2d4c6f6753020b5700b2e22]
stable/6.1: [6c63082368ea1094fc8a452d01e1f4de999e27e2]
stable/6.6: [10dfcb5f0f989b88035c50c752f3e7acd62a6d81]

CVE-2026-99315: ALSA: us122l: Fix NULL dereference at hwdep open and release

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [92d766c3d2b5d2fb45f4e0215dfab944f23c1bbc]
stable/5.15: [c290616fbb7a4abb40ce4df0d53a1815e6442784]
stable/6.1: [ab9b4ed047713411dcb354c37a0aad54d06441db]
stable/6.6: [ba9a21ab9a6bf37a6b40b8dc4df651daae9ee758]

CVE-2026-99316: ALSA: usx2y: Initialize idle URBs before submitting streams

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [c5bb11528ece8b4ac054bb7ea48fc5879c0e3b6a]
stable/5.15: [b400a65c42b579708794a61f2de7ab1ae65612f9]
stable/6.1: [48d692f985ef4bc6d39b7243b945a8e06910e8ae]
stable/6.6: [61362cfa989db8761c5876f09f90c3d5d7b93fc9]

CVE-2026-99317: ALSA: hwdep: Serialize DSP load requests

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [204f368204a1951da349ba68c82f99c464347dd7]
stable/5.15: [ef2aebb0543a20d1ee42ac95483eb54fc8457e88]
stable/6.1: [0e8365c7a4c5202f6b1e802a377d798db2b0e0ab]
stable/6.6: [8fb646220d48322311e135b2508fb9569fbe1d28]

CVE-2026-99318: ALSA: bcd2000: Fix use-after-free of MIDI URBs on file close

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [2fcf9b9d874709421abe2f70b51242224feb666c]
stable/5.15: [a57be92dc97bc4538cc7d0b51a528995c853318c]
stable/6.1: [c1d76e51961979c24b5fd63d8579b3b4c2c4e8fd]
stable/6.6: [8d2cca2909057746af411b5bb54a7fd329f25680]

CVE-2026-99319: ALSA: usx2y: Refuse a retried DSP load after a failure

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [bcbab700ef07dec9774a6ab8d18cd1b88bd932f5]
stable/5.15: [5e3b9f91c09a56cee8b5f43162fc43afa1d608ae]
stable/6.1: [afafe985fa8b0f0750927ae7599a7dfb9c6aef4e]
stable/6.6: [669477e0c758420b8998cdaf4855f1c09b4bb7c0]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com
