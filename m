Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F57C87FCB
	for <webhook@archiver.kernel.org>; Wed, 30 Jul 2025 22:08:55 +0000 (UTC)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
 by mx.groups.io with SMTP id smtpd.web11.47890.1753913331173304570
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Jul 2025 15:08:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=Inq8WAQm;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.178, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e75668006b9so378779276.3
        for <cip-dev@lists.cip-project.org>; Wed, 30 Jul 2025 15:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1753913330; x=1754518130; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+zWzdCSwyMO7DBfVruxPlaEv70FYtg94tcM9fMD5sRM=;
        b=Inq8WAQmHDbQanXDL028EmkO2CyzWS+y/JqbsgGMLNy9yWwbiktQZ+baOQ8BeQXgp3
         VDWjsVE8ocXQtELs03N9Ys1Yn0wPmZsBAJL2eAtnzGhoWrRYFenqNE5vlcK4DqywpZ0C
         AAAdsRyZTN7eVOQ4Hnoqd9zcP8DV3LHChBGmvMsl+I7YcEliaEPhmPBFBXlQH42Vhosk
         uhYWwQz21W0nbc/biD8YEW/hykCMXCMctZ2QhGidsjUQ/GoAM9fLyisbvqzw+NBasGMx
         11gwy6EOHWgZMWVeT3rOnKQciZ+YBixbnwrmnBSdnZwmECdE7qr7OZs19xktzwoJZ8FC
         HSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753913330; x=1754518130;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+zWzdCSwyMO7DBfVruxPlaEv70FYtg94tcM9fMD5sRM=;
        b=g0emZdUxjlT5jWtXJYJVPl4tLKXyTqWnUUDfhYVukCstQ67umpqT6JmCv0qz06NzZQ
         tYwdVDu+lkhRzm2QFDw/E1kpIJ5KeVHhQAn3Gs6920NgrBvMJtenNc8TOir1bAOkz9MI
         iCDlSYYzWW7yYZqVHBlbzW4o5wqALMbqItQyn9YBML9eJ94p6CqTohf0dgP5wh+UK6EO
         6fo9f5+IYmu6U/WiBzQ7MwjWy+xIsumvuzkKSxik/pR7uawo7zyni9JaSbdFuHW6MU7P
         urLkl8IRZUT2xI/zzP6uKdXomKqhL5P4iKv/9FU1q2+9M1WQL6n3rRktxhC21jky6XMS
         5aFw==
X-Gm-Message-State: AOJu0YwdywJlZxGbv5PTrt82+Fp5UuWrOrn1bKoRzqPFb3Tv85z6i3Ot
	C6wwhXe2SaXOM0zeEKb4kVup3pC6XucM4b0+mXj1uMhHK6aeB2XT8nIdA1q6fkAbWAXIG/0IJ+q
	Y/lvDEqYlNzJQg61M0c0aYyXX7wKjOiFuZOLG7DCEIgTDj1yRRh7Mrr8=
X-Gm-Gg: ASbGnctlKrNFKHAXdQ0Nmds4KVJ6KJd5ic1DrcpYkV3gMQrliDfkydmoDNcY7kyq/Kn
	GOweBnhZhbphhVqJ4wRPT3aOKsVgoGZ2YkH/A0etvSYfTvhLh6J5snd4Qc/nwK8Z53vFlLvYqdr
	rwL3As9mx1MLUGTKOM5QaLFLWDxCwFJAHIIi7iWDMCJErzz5+qBnMGLXlYZEdCkUxEmqC7y5zWT
	uiqMLKT
X-Google-Smtp-Source: AGHT+IEe7ZzVBZ668GUkZYEvfozAVLqUc0V1LKNEcN8rHDrTR/sQSEJMqm8Y5JRJDA5Sn15O5rvt4QNt4DgqR9XDy7w=
X-Received: by 2002:a05:6902:4893:b0:e8e:2a6b:251f with SMTP id
 3f1490d57ef6-e8e315cd6f1mr6281106276.32.1753913328374; Wed, 30 Jul 2025
 15:08:48 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 31 Jul 2025 07:08:10 +0900
X-Gm-Features: Ac12FXx_Sj9U3BgVpYBDQUtkMVBqs_fZZefRgN_4ZvBvzwH66FIavZCwGTAqCJY
Message-ID: <CAODzB9reT8Zqwbjr8ovoPLQq5AYJvzGePBGK55+OJOVNvLdP=g@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Jul 2025 22:08:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19623

Hi!

It's this week's CVE report.

This week reported 145 new CVEs and 0 updated CVEs.

* New CVEs
CVE-2025-38353: drm/xe: Fix taking invalid lock on wedge

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38353

Introduced commit is not determined.Fixed in v6.16-rc1.
Vulnerable driver was added by dd08ebf ("drm/xe: Introduce a new DRM
driver for Intel GPUs") in 6.8-rc1.

Fixed status
mainline: [1e1981b16bb1bbe2fafa57ed439b45cb5b34e32d]
stable/6.12: [a6d81b2d7037ef36163ad16459ed3fd17cb1b596]

CVE-2025-38354: drm/msm/gpu: Fix crash when throttling GPU immediately
during boot

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38354

Introduced by commit 6694482 ("drm/msm: Avoid unclocked GMU register
access in 6xx gpu_busy") in v6.0-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b71717735be48d7743a34897e9e44a0b53e30c0e]
stable/6.1: [ae2015b0dbc0eea7aaf022194371f451f784d994]
stable/6.12: [1847ea44e3bdf7da8ff4158bc01b43a2e46394bd]
stable/6.6: [7946a10f8da75abc494e4bb80243e153e93e459a]

CVE-2025-38355: drm/xe: Process deferred GGTT node removals on device unwind

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38355

Introduced by commit 919bb54 ("drm/xe: Fix missing runtime outer
protection for ggtt_remove_node") in v6.12-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af2b588abe006bd55ddd358c4c3b87523349c475]
stable/6.12: [1b12f8dabbb8fd7d5a2611dd7bc5982ffbc2e5df]

CVE-2025-38356: drm/xe/guc: Explicitly exit CT safe mode on unwind

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38356

Introduced by commit 09b2869 ("drm/xe/guc: Allow CTB G2H processing
without G2H IRQ") in v6.11-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad40098da5c3b43114d860a5b5740e7204158534]
stable/6.12: [6d0b588614c43d6334b2d7a70a99f31f7b14ecc0]

CVE-2025-38357: fuse: fix runtime warning on truncate_folio_batch_exceptionals()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38357

Introduced by commit bde708f ("fs/dax: always remove DAX page-cache
entries when breaking layouts") in v6.15-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [befd9a71d859ea625eaa84dae1b243efb3df3eca]

CVE-2025-38358: btrfs: fix race between async reclaim worker and close_ctree()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38358

Introduced by commit 19e60b2 ("btrfs: add extra warning if delayed
iput is added when it's not allowed") in v6.15-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a26bf338cdad3643a6e7c3d78a172baadba15c1a]

CVE-2025-38359: s390/mm: Fix in_atomic() handling in do_secure_storage_access()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38359

Introduced commit is not determined.Fixed in v6.16-rc1.
Vulnerable function was added by 084ea4d ("s390/mm: add (non)secure page
access exceptions handlers") in 5.7-rc1.

Fixed status
mainline: [11709abccf93b08adde95ef313c300b0d4bc28f1]

CVE-2025-38360: drm/amd/display: Add more checks for DSC / HUBP ONO guarantees

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38360

Introduced commit is not determined.Fixed in v6.16-rc3.
Vulnerable functions were added by 6f8b756 ("drm/amd/display: Add DCN35 HWSEQ")
in 6.7-rc1.

Fixed status
mainline: [0d57dd1765d311111d9885346108c4deeae1deb4]
stable/6.12: [646442758910d13f9afc57f38bc0a537c3575390]

CVE-2025-38361: drm/amd/display: Check dce_hwseq before dereferencing it

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38361

Introduced commit is not determined.Fixed in v6.16-rc3.
Affected driver was added by 4562236 ("drm/amd/dc: Add dc display driver (v2)")
in 4.15-rc1.

Fixed status
mainline: [b669507b637eb6b1aaecf347f193efccc65d756e]
stable/6.12: [e881b82f5d3d8d54d168cd276169f0fee01bf0e7]

CVE-2025-38362: drm/amd/display: Add null pointer check for
get_first_active_display()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38362

Introduced by commit 2deade5 ("drm/amd/display: Remove hdcp display
state with mst fix") in v5.8-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3e9826a22027a21d998d3e64882fa377b613006]
stable/5.15: [34d3e10ab905f06445f8dbd8a3d9697095e71bae]
stable/6.1: [1ebcdf38887949def1a553ff3e45c98ed95a3cd0]
stable/6.12: [4ce9f2dc9ff7cc410e8c5d936ec551e26b9599a9]
stable/6.6: [5148c7ea69e9c5bf2f05081190f45ba96d3d1e7a]

CVE-2025-38363: drm/tegra: Fix a possible null pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38363

Introduced by commit b7e0b04 ("drm/tegra: Convert to using
__drm_atomic_helper_crtc_reset() for reset.") in v5.3-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [780351a5f61416ed2ba1199cc57e4a076fca644d]
stable/5.10: [ab390ab81241cf8bf37c0a0ac2e9c6606bf3e991]
stable/5.15: [c7fc459ae6f988e0d5045a270bd600ab08bc61f1]
stable/6.1: [99a25fc7933b88d5e16668bf6ba2d098e1754406]
stable/6.12: [31ac2c680a8ac11dc54a5b339a07e138bcedd924]
stable/6.6: [5ff3636bcc32e1cb747f6f820bcf2bb6990a7d41]

CVE-2025-38364: maple_tree: fix MA_STATE_PREALLOC flag in mas_preallocate()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38364

Introduced by commit 54a611b ("Maple Tree: add new data structure") in v6.1-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fba46a5d83ca8decb338722fb4899026d8d9ead2]
stable/6.1: [d69cd64bd5af41c6fd409313504089970edaf02f]
stable/6.12: [cf95f8426f889949b738f51ffcd72884411f3a6a]
stable/6.6: [e63032e66bca1d06e600033f3369ba3db3af0870]

CVE-2025-38365: btrfs: fix a race between renames and directory logging

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38365

Introduced by commit 259c4b9 ("btrfs: stop doing unnecessary log
updates during a rename") in v5.18-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ca864de852bc91007b32d2a0d48993724f4abad]
stable/6.1: [51bd363c7010d033d3334daf457c824484bf9bf0]
stable/6.12: [2088895d5903082bb9021770b919e733c57edbc1]
stable/6.6: [aeeae8feeaae4445a86f9815273e81f902dc1f5b]

CVE-2025-38366: LoongArch: KVM: Check validity of "num_cpu" from user space

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38366

Introduced by commit 1ad7efa ("LoongArch: KVM: Add EIOINTC user mode
read and write functions") in v6.13-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc8d5b209e09d3b52bca1ffe00045876842d96ae]

CVE-2025-38367: LoongArch: KVM: Avoid overflow with array index

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38367

Introduced by commit 3956a52 ("LoongArch: KVM: Add EIOINTC read and
write functions") in v6.13-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [080e8d2ecdfde588897aa8a87a8884061f4dbbbb]

CVE-2025-38368: misc: tps6594-pfsm: Add NULL pointer check in
tps6594_pfsm_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38368

Introduced commit is not determined.Fixed in v6.16-rc1.
This vulnerability was introduced by a0df3ef ("misc: tps6594-pfsm: Add
driver for TI TPS6594 PFSM") in 6.5-rc1.

Fixed status
mainline: [a99b598d836c9c6411110c70a2da134c78d96e67]
stable/6.12: [a10c8bff454b11ef553d9df19ee722d2df34cd0e]
stable/6.6: [a8d1b4f219e8833130927f19d1c8bfbf49215ce4]

CVE-2025-38369: dmaengine: idxd: Check availability of workqueue
allocated by idxd wq driver before using

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38369

Introduced commit is not determined.Fixed in v6.16-rc1.
Vulnerable code was introduced by c40bd7d ("dmaengine: idxd: process user
page faults for completion record") in 6.4-rc1.

Fixed status
mainline: [17502e7d7b7113346296f6758324798d536c31fd]
stable/6.12: [98fd66c8ba77e3a7137575f610271014bc0e701f]
stable/6.6: [e0051a3daa8b2cb318b03b2f9317c3e40855847a]

CVE-2025-38370: btrfs: fix failure to rebuild free space tree using
multiple transactions

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38370

Introduced by commit 882af9f ("btrfs: handle free space tree rebuild
in multiple transactions") in v6.14-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e6ed33cabba8f06f532f2e5851a102602823734]

CVE-2025-38371: drm/v3d: Disable interrupts before resetting the GPU

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38371

Introduced by commit 57692c9 ("drm/v3d: Introduce a new DRM driver for
Broadcom V3D V3.x+") in v4.18-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [226862f50a7a88e4e4de9abbf36c64d19acd6fd0]
stable/5.10: [2446e25e9246e0642a41d91cbf54c33b275da3c3]
stable/5.15: [576a6739e08ac06c67f2916f71204557232388b0]
stable/5.4: [b9c403d1236cecb10dd0246a30d81e4b265f8e8d]
stable/6.1: [c8851a6ab19d9f390677c42a3cc01ff9b2eb6241]
stable/6.12: [9ff95ed0371aec4d9617e478e9c69cde86cd7c38]
stable/6.6: [387da3b6d1a90e3210bc9a7fb56703bdad2ac18a]

CVE-2025-38372: RDMA/mlx5: Fix unsafe xarray access in implicit ODP handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38372

Introduced by commit d3d9304 ("RDMA/mlx5: Fix implicit ODP use after
free") in v6.14-rc1.
Fixed in v6.16-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [2c6b640ea08bff1a192bf87fa45246ff1e40767c]
stable/6.12: [9d2ef890e49963b768d4fe5a33029aacd9f6b93f]

CVE-2025-38373: IB/mlx5: Fix potential deadlock in MR deregistration

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38373

Introduced by commit abb604a ("RDMA/mlx5: Fix a race for an ODP MR
which leads to CQE with error") in v6.14-rc1.
Fixed in v6.16-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [2ed25aa7f7711f508b6120e336f05cd9d49943c0]
stable/6.12: [beb89ada5715e7bd1518c58863eedce89ec051a7]

CVE-2025-38374: optee: ffa: fix sleep in atomic context

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38374

Introduced by commit d0476a5 ("optee: ffa_abi: add asynchronous
notifications") in v6.8-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [312d02adb959ea199372f375ada06e0186f651e4]
stable/6.12: [5f28563f0c6862c99eb115c918421d9b73f137ad]

CVE-2025-38375: virtio-net: ensure the received length does not exceed
allocated size

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38375

Introduced by commit 4941d47 ("virtio-net: do not reset during XDP
set") in v4.14-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [315dbdd7cdf6aa533829774caaf4d25f1fd20e73]
stable/5.15: [982beb7582c193544eb9c6083937ec5ac1c9d651]
stable/6.1: [6aca3dad2145e864dfe4d1060f45eb1bac75dd58]
stable/6.12: [bc68bc3563344ccdc57d1961457cdeecab8f81ef]
stable/6.6: [80b971be4c37a4d23a7f1abc5ff33dc7733d649b]

CVE-2025-38376: usb: chipidea: udc: disconnect/reconnect from host
when do suspend/resume

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38376

Introduced by commit 235ffc1 ("usb: chipidea: udc: add suspend/resume
support for device controller") in v6.2-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31a6afbe86e8e9deba9ab53876ec49eafc7fd901]
stable/6.12: [c68a27bbebbdb4e0ccd45d4f0df7111a09ddac24]
stable/6.6: [937f49be49d6ee696eb5457c21ff89c135c9b5ae]

CVE-2025-38377: rose: fix dangling neighbour pointers in rose_rt_device_down()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38377

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34a500caf48c47d5171f4aa1f237da39b07c6157]
stable/5.10: [fe62a35fb1f77f494ed534fc69a9043dc5a30ce1]
stable/5.15: [2b952dbb32fef835756f07ff0cd77efbb836dfea]
stable/5.4: [94e0918e39039c47ddceb609500817f7266be756]
stable/6.1: [b6b232e16e08c6dc120672b4753392df0d28c1b4]
stable/6.12: [446ac00b86be1670838e513b643933d78837d8db]
stable/6.6: [7a1841c9609377e989ec41c16551309ce79c39e4]

CVE-2025-38378: HID: appletb-kbd: fix slab use-after-free bug in
appletb_kbd_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38378

Introduced by commit 93a0fc4 ("HID: hid-appletb-kbd: add support for
automatic brightness control while using the touchbar") in v6.15-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38224c472a038fa9ccd4085511dd9f3d6119dbf9]

CVE-2025-38379: smb: client: fix warning when reconnecting channel

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38379

Introduced by commit 42ca547 ("cifs: do not disable interface polling
on failure") in v6.16-rc1.
Fixed in v6.16-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.15 stable/6.6

Fixed status
mainline: [3bbe46716092d8ef6b0df4b956f585c5cd0fc78e]
stable/6.12: [3f6932ef25378794894c3c1024092ad14da2d330]
stable/6.6: [0cee638d92ac898d73eccc4e4bab70e9fc95946a]

CVE-2025-38380: i2c/designware: Fix an initialization issue

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38380

Introduced by commit 17631e8 ("i2c: designware: Add driver support for
AMD NAVI GPU") in v5.13-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d30048958e0d43425f6d4e76565e6249fa71050]
stable/5.15: [475f89e1f9bde45fc948589e7cde1f5d899ae412]
stable/6.1: [5b622e672e49e50c33fc64cd06b05ce76e1de460]
stable/6.12: [4c37963d67fb945a59faf53bebe048ca201e44df]
stable/6.6: [6358cb9c2a31e23b6b51bfcd7fe2b7becaf6b149]

CVE-2025-38381: Input: cs40l50-vibra - fix potential NULL dereference
in cs40l50_upload_owt()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38381

Introduced by commit c38fe1b ("Input: cs40l50 - Add support for the
CS40L50 haptic driver") in v6.11-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cf65845fdd09d711fc7546d60c9abe010956922]
stable/6.12: [ea20568895c1122f15b6fc9e8d02c6cbe22964f8]

CVE-2025-38382: btrfs: fix iteration of extrefs during log replay

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38382

Introduced by commit e43eec8 ("btrfs: use struct qstr instead of name
and namelen pairs") in v6.2-rc1.
Fixed in v6.16-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [54a7081ed168b72a8a2d6ef4ba3a1259705a2926]
stable/6.1: [539969fc472886a1d63565459514d47e27fef461]
stable/6.12: [7ac790dc2ba00499a8d671d4a24de4d4ad27e234]
stable/6.6: [2d11d274e2e1d7c79e2ca8461ce3ff3a95c11171]

CVE-2025-38383: mm/vmalloc: fix data race in show_numa_info()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38383

Introduced by commit 8e1d743 ("mm: vmalloc: support multiple nodes in
vmallocinfo") in v6.9-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c5f0468d172ddec2e333d738d2a1f85402cf0bc]
stable/6.12: [ead91de35d9cd5c4f80ec51e6020f342079170af]

CVE-2025-38384: mtd: spinand: fix memory leak of ECC engine conf

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38384

Introduced commit is not determined.Fixed in v6.16-rc3.
Vulnerable code was added by 7529df4 ("mtd: nand: Add core infrastructure
to support SPI NANDs") in 4.19-rc1.

Fixed status
mainline: [6463cbe08b0cbf9bba8763306764f5fd643023e1]
stable/5.15: [68d3417305ee100dcad90fd6e5846b22497aa394]
stable/6.1: [f99408670407abb6493780e38cb4ece3fbb52cfc]
stable/6.12: [c40b207cafd006c610832ba52a81cedee77adcb9]
stable/6.6: [d5c1e3f32902ab518519d05515ee6030fd6c59ae]

CVE-2025-38385: net: usb: lan78xx: fix WARN in __netif_napi_del_locked
on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38385

Introduced by commit ec4c7e1 ("lan78xx: Introduce NAPI polling
support") in v5.17-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c7ffc9af7186ed79403a3ffee9a1e5199fc7450]
stable/6.1: [7135056a49035597198280820c61b8c5dbe4a1d0]
stable/6.12: [510a6095d754df9d727f644ec5076b7929d6c9ea]
stable/6.6: [968a419c95131e420f12bbdba19e96e2f6b071c4]

CVE-2025-38386: ACPICA: Refuse to evaluate a method if arguments are missing

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38386

Introduced commit is not determined.Fixed in v6.16-rc3.


Fixed status
mainline: [6fcab2791543924d438e7fa49276d0998b0a069f]
stable/5.10: [2219e49857ffd6aea1b1ca5214d3270f84623a16]
stable/5.15: [ab1e8491c19eb2ea0fda81ef28e841c7cb6399f5]
stable/5.4: [b49d224d1830c46e20adce2a239c454cdab426f1]
stable/6.1: [4305d936abde795c2ef6ba916de8f00a50f64d2d]
stable/6.12: [18ff4ed6a33a7e3f2097710eacc96bea7696e803]
stable/6.6: [d547779e72cea9865b732cd45393c4cd02b3598e]

CVE-2025-38387: RDMA/mlx5: Initialize obj_event->obj_sub_list before xa_insert

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38387

Introduced by commit 7597385 ("IB/mlx5: Enable subscription for device
events over DEVX") in v5.3-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8edab8a72d67742f87e9dc2e2b0cdfddda5dc29a]
stable/5.10: [972e968aac0dce8fe8faad54f6106de576695d8e]
stable/5.15: [00ed215f593876385451423924fe0358c556179c]
stable/5.4: [716b555fc0580c2aa4c2c32ae4401c7e3ad9873e]
stable/6.1: [9a28377a96fb299c180dd9cf0be3b0a038a52d4e]
stable/6.12: [93fccfa71c66a4003b3d2fef3a38de7307e14a4e]
stable/6.6: [23a3b32a274a8d6f33480d0eff436eb100981651]

CVE-2025-38388: firmware: arm_ffa: Replace mutex with rwlock to avoid
sleep in atomic context

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38388

Introduced by commit e057344 ("firmware: arm_ffa: Add interfaces to
request notification callbacks") in v6.7-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ca7a421229bbdfbe2e1e628cff5cfa782720a10]
stable/6.12: [31405510a48dcf054abfa5b7b8d70ce1b27d1f13]

CVE-2025-38389: drm/i915/gt: Fix timeline left held on VMA alloc error

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38389

Introduced by commit 75d0a7f ("drm/i915: Lift timeline into
intel_context") in v5.4-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5aa7bc1fca78c7fa127d9e33aa94a0c9066c1d6]
stable/5.10: [e47d7d6edc40a6ace7cc04e5893759fee68569f5]
stable/5.15: [f10af34261448610d4048ac6e6af87f80e3881a4]
stable/5.4: [60b757730884e4a223152a68d9b5f625dac94119]
stable/6.1: [4c778c96e469fb719b11683e0a3be8ea68052fa2]
stable/6.12: [5a7ae7bebdc4c2ecd48a2c061319956f65c09473]
stable/6.6: [40e09506aea1fde1f3e0e04eca531bbb23404baf]

CVE-2025-38390: firmware: arm_ffa: Fix memory leak by freeing notifier
callback node

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38390

Introduced by commit e057344 ("firmware: arm_ffa: Add interfaces to
request notification callbacks") in v6.7-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a833d31ad867103ba72a0b73f3606f4ab8601719]
stable/6.12: [076fa20b4f5737c34921dbb152f9efceaee571b2]

CVE-2025-38391: usb: typec: altmodes/displayport: do not index invalid
pin_assignments

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38391

Introduced by commit 0e3bb7d ("usb: typec: Add driver for DisplayPort
alternate mode") in v4.19-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af4db5a35a4ef7a68046883bfd12468007db38f1]
stable/5.10: [114a977e0f6bf278e05eade055e13fc271f69cf7]
stable/5.15: [621d5a3ef0231ab242f2d31eecec40c38ca609c5]
stable/5.4: [c93bc959788ed9a1af7df57cb539837bdf790cee]
stable/6.1: [2f535517b5611b7221ed478527e4b58e29536ddf]
stable/6.12: [5581e694d3a1c2f32c5a51d745c55b107644e1f8]
stable/6.6: [45e9444b3b97eaf51a5024f1fea92f44f39b50c6]

CVE-2025-38392: idpf: convert control queue mutex to a spinlock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38392

Introduced by commit a251eee ("idpf: add SRIOV support and other
ndo_ops") in v6.7-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2beb5bb2cd90d7939e470ed4da468683f41baa3]
stable/6.12: [9a36715cd6bc6a6f16230e19a7f947bab34b3fe5]

CVE-2025-38393: NFSv4/pNFS: Fix a race to wake on NFS_LAYOUT_DRAIN

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38393

Introduced by commit 880265c ("pNFS: Avoid a live lock condition in
pnfs_update_layout()") in v5.19-rc3.
Fixed in v6.16-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [c01776287414ca43412d1319d2877cbad65444ac]
stable/5.10: [08287df60bac5b008b6bcdb03053988335d3d282]
stable/5.15: [8846fd02c98da8b79e6343a20e6071be6f372180]
stable/6.1: [e4b13885e7ef1e64e45268feef1e5f0707c47e72]
stable/6.12: [864a54c1243ed3ca60baa4bc492dede1361f4c83]
stable/6.6: [8ca65fa71024a1767a59ffbc6a6e2278af84735e]

CVE-2025-38394: HID: appletb-kbd: fix memory corruption of input_handler_list

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38394

Introduced by commit 7d62ba8 ("HID: hid-appletb-kbd: add support for
fn toggle between media and function mode") in v6.15-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c80f2b047d5cc42fbd2dff9d1942d4ba7545100f]

CVE-2025-38395: regulator: gpio: Fix the out-of-bounds access to drvdata::gpiods

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38395

Introduced by commit d6cd33a ("regulator: gpio: Convert to use
descriptors") in v5.1-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9764fd88bc744592b0604ccb6b6fc1a5f76b4e3]
stable/5.10: [9fe71972869faed1f8f9b3beb9040f9c1b300c79]
stable/5.15: [56738cbac3bbb1d39a71a07f57484dec1db8b239]
stable/5.4: [a3cd5ae7befbac849e0e0529c94ca04e8093cfd2]
stable/6.1: [a1e12fac214d4f49fcb186dbdf9c5592e7fa0a7a]
stable/6.12: [e4d19e5d71b217940e33f2ef6c6962b7b68c5606]
stable/6.6: [24418bc77a66cb5be9f5a837431ba3674ed8b52f]

CVE-2025-38396: fs: export anon_inode_make_secure_inode() and fix
secretmem LSM bypass

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38396

Introduced by commit 2bfe15c ("mm: create security context for
memfd_secret inodes") in v6.0-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbe4134ea4bc493239786220bd69cb8a13493190]
stable/6.1: [66d29d757c968d2bee9124816da5d718eb352959]
stable/6.12: [f94c422157f3e43dd31990567b3e5d54b3e5b32b]
stable/6.6: [e3eed01347721cd7a8819568161c91d538fbf229]

CVE-2025-38397: nvme-multipath: fix suspicious RCU usage warning

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38397

Introduced by commit 4dbd2b2 ("nvme-multipath: Add visibility for
round-robin io-policy") in v6.15-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d6811074203b13f715ce2480ac64c5b1c773f2a5]

CVE-2025-38398: spi: spi-qpic-snand: reallocate BAM transactions

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38398

Introduced by commit 7304d19 ("spi: spi-qpic: add driver for QCOM SPI
NAND flash Interface") in v6.15-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d85d0380292a7e618915069c3579ae23c7c80339]

CVE-2025-38399: scsi: target: Fix NULL pointer dereference in
core_scsi3_decode_spec_i_port()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38399

Introduced commit is not determined.Fixed in v6.16-rc3.
Introduced by f32ba61 ("scsi: target: Fix crash during SPEC_I_PT handling")
in 5.9-rc1. This commit removed checking dest_se_deve is NULL or not.

Fixed status
mainline: [d8ab68bdb294b09a761e967dad374f2965e1913f]
stable/5.10: [70ddb8133fdb512d4b1f2b4fd1c9e518514f182c]
stable/5.15: [1129e0e0a833acf90429e0f13951068d5f026e4f]
stable/6.1: [1627dda4d70ceb1ba62af2e401af73c09abb1eb5]
stable/6.12: [7296c938df2445f342be456a6ff0b3931d97f4e5]
stable/6.6: [55dfffc5e94730370b08de02c0cf3b7c951bbe9e]

CVE-2025-38400: nfs: Clean up /proc/net/rpc/nfs when
nfs_fs_proc_net_init() fails.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38400

Introduced by commit d47151b ("nfs: expose /proc/net/sunrpc/nfs in net
namespaces") in v6.9-rc1.
Fixed in v6.16-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [e8d6f3ab59468e230f3253efe5cb63efa35289f7]
stable/5.10: [412534a1fb76958b88dca48360c6f3ad4f3390f4]
stable/5.15: [b92397ce96743e4cc090207e2df2a856cb4cef08]
stable/5.4: [8785701fd7cd52ae74c0d2b35b82568df74e9dbb]
stable/6.1: [7701c245ff1ac1a126bf431e72b24547519046ff]
stable/6.12: [3c94212b57bedec3a386ef3da1ef00602f5c3d1d]
stable/6.6: [d0877c479f44fe475f4c8c02c88ce9ad43e90298]

CVE-2025-38401: mtk-sd: Prevent memory corruption from DMA map failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38401

Introduced by commit 2084890 ("mmc: mediatek: Add Mediatek MMC
driver") in v4.2-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5de469990f19569627ea0dd56536ff5a13beaa3]
stable/5.10: [d54771571f74a82c59830a32e76af78a8e57ac69]
stable/5.15: [48bf4f3dfcdab02b22581d8e350a2d23130b72c0]
stable/5.4: [5ac9e9e2e9cd6247d8c2d99780eae4556049e1cc]
stable/6.1: [63e8953f16acdcb23e2d4dd8a566d3c34df3e200]
stable/6.12: [3419bc6a7b65cbbb91417bb9970208478e034c79]
stable/6.6: [61cdd663564674ea21ceb50aa9d3697cbe9e45f9]

CVE-2025-38402: idpf: return 0 size for RSS key if not supported

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38402

Introduced by commit 02cbfba ("idpf: add ethtool callbacks") in v6.7-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f77bf1ebf8ff6301ccdbc346f7b52db928f9cbf8]
stable/6.12: [018ff57fd79c38be989b8b3248bbe69bcfb77160]

CVE-2025-38403: vsock/vmci: Clear the vmci transport packet properly
when initializing it

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38403

Introduced by commit d021c34 ("VSOCK: Introduce VM Sockets") in v3.9-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [223e2288f4b8c262a864e2c03964ffac91744cd5]
stable/5.10: [1c1bcb0e78230f533b4103e8cf271d17c3f469f0]
stable/5.15: [2d44723a091bc853272e1a51a488a3d22b80be5e]
stable/5.4: [19c2cc01ff9a8031398a802676ffb0f4692dd95d]
stable/6.1: [0a01021317375b8d1895152f544421ce49299eb1]
stable/6.12: [75705b44e0b9aaa74f4c163d93d388bcba9e386a]
stable/6.6: [94d0c326cb3ee6b0f8bd00e209550b93fcc5c839]

CVE-2025-38404: usb: typec: displayport: Fix potential deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38404

Introduced by commit b4b38ff ("usb: typec: displayport: Receive DP
Status Update NAK request exit dp altmode") in v6.16-rc1.
Fixed in v6.16-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12 stable/5.10 stable/5.15 stable/5.4 stable/6.1
stable/6.12 stable/6.15 stable/6.6

Fixed status
mainline: [099cf1fbb8afc3771f408109f62bdec66f85160e]
stable/5.10: [eb08fca56f1f39e4038cb9bac9864464b13b00aa]
stable/5.15: [7be0d1ea71f52595499da39cea484a895e8ed042]
stable/5.4: [749d9076735fb497aae60fbea9fff563f9ea3254]
stable/6.1: [76cf1f33e7319fe74c94ac92f9814094ee8cc84b]
stable/6.12: [c782f98eef14197affa8a7b91e6981420f109ea9]
stable/6.6: [63cff9f57e86b2dc25d7487ca0118df89a665296]

CVE-2025-38405: nvmet: fix memory leak of bio integrity

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38405

Introduced by commit bf4c89f ("block: don't call bio_uninit from
bio_endio") in v6.11-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [190f4c2c863af7cc5bb354b70e0805f06419c038]
stable/6.12: [431e58d56fcb5ff1f9eb630724a922e0d2a941df]

CVE-2025-38406: wifi: ath6kl: remove WARN on bad firmware input

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38406

Introduced commit is not determined.Fixed in v6.16-rc3.
Introduced by bdcd817 ("Add ath6kl cleaned up driver") in 3.2-rc1.

Fixed status
mainline: [e7417421d89358da071fd2930f91e67c7128fbff]
stable/5.10: [e6c49f0b203a987c306676d241066451b74db1a5]
stable/5.15: [46b47d4b06fa7f234d93f0f8ac43798feafcff89]
stable/5.4: [7a2afdc5af3b82b601f6a2f0d1c90d5f0bc27aeb]
stable/6.1: [89bd133529a4d2d68287128b357e49adc00ec690]
stable/6.12: [327997afbb5e62532c28c1861ab5534c01969c9a]
stable/6.6: [347827bd0c5680dac2dd59674616840c4d5154f1]

CVE-2025-38407: riscv: cpu_ops_sbi: Use static array for boot_data

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38407

Introduced by commit 6b9f29b ("riscv: Enable pcpu page first chunk
allocator") in v6.8-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b29be967ae456fc09c320d91d52278cf721be1e]
stable/6.12: [f5fe094f35a37adea40b2fd52c99bb1333be9b07]

CVE-2025-38408: genirq/irq_sim: Initialize work context pointers properly

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38408

Introduced commit is not determined.Fixed in v6.16-rc3.
It seems as if this bug was introduced by b19af51 ("genirq/irq_sim: Add
a simple interrupt simulator framework") in 4.14-rc1.

Fixed status
mainline: [8a2277a3c9e4cc5398f80821afe7ecbe9bdf2819]
stable/6.12: [19bd7597858dd15802c1d99fcc38e528f469080a]

CVE-2025-38409: drm/msm: Fix another leak in the submit error path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38409

Introduced commit is not determined.Fixed in v6.16-rc3.


Fixed status
mainline: [f681c2aa8676a890eacc84044717ab0fd26e058f]
stable/6.1: [00b3401f692082ddf6342500d1be25560bba46d4]
stable/6.12: [3f6ce8433a9035b0aa810e1f5b708e9dc1c367b0]
stable/6.6: [c40ad1c04d306f7fde26337fdcf8a5979657d93f]

CVE-2025-38410: drm/msm: Fix a fence leak in submit error path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38410

Introduced commit is not determined.Fixed in v6.16-rc3.


Fixed status
mainline: [5d319f75ccf7f0927425a7545aa1a22b3eedc189]
stable/5.15: [5deab0fa6cfd0cd7def17598db15ceb84f950584]
stable/6.1: [201eba5c9652a900c0b248070263f9acd3735689]
stable/6.12: [0eaa495b3d5710e5ba72051d2e01bb28292c625c]
stable/6.6: [fe2695b2f63bd77e0e03bc0fc779164115bb4699]

CVE-2025-38411: netfs: Fix double put of request

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38411

Introduced by commit 2b1424c ("netfs: Fix wait/wake to be consistent
about the waitqueue used") in v6.16-rc1.
Fixed in v6.16-rc5.

Bug introduced commit was backported to following branches.
stable/6.15

Fixed status
mainline: [9df7b5ebead649b00bf9a53a798e4bf83a1318fd]

CVE-2025-38412: platform/x86: dell-wmi-sysman: Fix WMI data block
retrieval in sysfs callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38412

Introduced by commit e8a60aa ("platform/x86: Introduce support for
Systems Management Driver over WMI for Dell Systems") in v5.11-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb617dd25ca176f3fee24f873f0fd60010773d67]
stable/5.15: [92c2d914b5337431d885597a79a3a3d9d55e80b7]
stable/6.1: [68e9963583d11963ceca5d276e9c44684509f759]
stable/6.12: [5df3b870bc389a1767c72448a3ce1c576ef4deab]
stable/6.6: [0deb3eb78ebf225cb41aa9b2b2150f46cbfd359e]

CVE-2025-38413: virtio-net: xsk: rx: fix the frame's length check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38413

Introduced by commit a4e7ba7 ("virtio_net: xsk: rx: support recv small
mode") in v6.11-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5177373c31318c3c6a190383bfd232e6cf565c36]
stable/6.12: [892f6ed9a4a38bb3360fdff091b9241cfa105b61]

CVE-2025-38414: wifi: ath12k: fix GCC_GCC_PCIE_HOT_RST definition for WCN7850

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38414

Introduced by commit d889913 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in v6.3-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7588a893cde5385ad308400ff167d29a29913b3a]
stable/6.12: [569972c5bdb839b0eaf8aba6ce76ea0b78e2acf8]

CVE-2025-38415: Squashfs: check return result of sb_min_blocksize

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38415

Introduced by commit 0aa6661 ("Squashfs: super block operations") in
v2.6.29-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [92d7eb33374fc44cf6e57e08086b503c6603c283]
cip/4.4-st: [de2a7553c6b22414e1f1409343e5a5e815e7e908]
mainline: [734aa85390ea693bb7eaf2240623d41b03705c84]
stable/5.10: [549f9e3d7b60d53808c98b9fde49b4f46d0524a5]
stable/5.15: [5c51aa862cbeed2f3887f0382a2708956710bd68]
stable/5.4: [db7096ea160e40d78c67fce52e7cc51bde049497]
stable/6.1: [6abf6b78c6fb112eee495f5636ffcc350dd2ce25]
stable/6.12: [0aff95d9bc7fb5400ca8af507429c4b067bdb425]
stable/6.6: [4f99357dadbf9c979ad737156ad4c37fadf7c56b]

CVE-2025-38416: NFC: nci: uart: Set tty->disc_data only in success path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38416

Introduced by commit 9961127 ("NFC: nci: add generic uart support") in v4.2-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c0056ee6b6aa8a72f6f94bfa403331b9abc09d45]
cip/4.4-st: [32228391989602e224670a452d2946c28085b461]
mainline: [fc27ab48904ceb7e4792f0c400f1ef175edf16fe]
stable/5.10: [000bfbc6bc334a93fffca8f5aa9583e7b6356cb5]
stable/5.15: [ac6992f72bd8e22679c1e147ac214de6a7093c23]
stable/5.4: [a514fca2b8e95838a3ba600f31a18fa60b76d893]
stable/6.1: [dc7722619a9c307e9938d735cf4a2210d3d48dcb]
stable/6.12: [55c3dbd8389636161090a2b2b6d2d709b9602e9c]
stable/6.6: [a8acc7080ad55c5402a1b818b3008998247dda87]

CVE-2025-38417: ice: fix eswitch code memory leak in reset scenario

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38417

Introduced by commit 415db83 ("ice: make representor code generic") in
v6.12-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48c8b214974dc55283bd5f12e3a483b27c403bbc]
stable/6.12: [d6715193de439b79f1d6a4c03593c7529239b545]

CVE-2025-38418: remoteproc: core: Release rproc->clean_table after
rproc_attach() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38418

Introduced by commit 9dc9507 ("remoteproc: Properly deal with the
resource table when detaching") in v5.13-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bcd241230fdbc6005230f80a4f8646ff5a84f15b]
stable/5.15: [3562c09feeb8d8e9d102ce6840e8c7d57a7feb5c]
stable/6.1: [bf876fd9dc2d0c9fff96aef63d4346719f206fc1]
stable/6.12: [f4ef928ca504c996f9222eb2c59ac6d6eefd9c75]
stable/6.6: [3ee979709e16a83b257bc9a544a7ff71fd445ea9]

CVE-2025-38419: remoteproc: core: Cleanup acquired resources when
rproc_handle_resources() fails in rproc_attach()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38419

Introduced by commit 10a3d40 ("remoteproc: imx_rproc: move memory
parsing to rproc_ops") in v5.13-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7692c9fbedd9087dc9050903f58095915458d9b1]
stable/5.15: [c56d6ef2711ee51b54f160ad0f25a381561f0287]
stable/6.1: [82208ce9505abb057afdece7c62a14687c52c9ca]
stable/6.12: [92776ca0ccfe78b9bfe847af206bad641fb11121]
stable/6.6: [9515d74c9d1ae7308a02e8bd4f894eb8137cf8df]

CVE-2025-38420: wifi: carl9170: do not ping device which has failed to
load firmware

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38420

Introduced by commit e4a668c ("carl9170: fix spurious restart due to
high latency") in v2.6.38-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [881cceddd1a6c056267dfeebdfd2af6cb73e28f2]
cip/4.4-st: [a7de7ab227eb95edc10f26380640031062a9b2a8]
mainline: [15d25307692312cec4b57052da73387f91a2e870]
stable/5.10: [8a3734a6f4c05fd24605148f21fb2066690d61b3]
stable/5.15: [527fad1ae32ffa2d4853a1425fe1c8dbb8c9744c]
stable/5.4: [0140d3d37f0f1759d1fdedd854c7875a86e15f8d]
stable/6.1: [bfeede26e97ce4a15a0b961118de4a0e28c9907a]
stable/6.12: [301268dbaac8e9013719e162a000202eac8054be]
stable/6.6: [4e9ab5c48ad5153cc908dd29abad0cd2a92951e4]

CVE-2025-38421: platform/x86/amd: pmf: Use device managed allocations

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38421

Introduced by commit 5b1122f ("platform/x86/amd/pmf: fix cleanup in
amd_pmf_init_smart_pc()") in v6.14-rc7.
Fixed in v6.16-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [d9db3a941270d92bbd1a6a6b54a10324484f2f2d]

CVE-2025-38422: net: lan743x: Modify the EEPROM and OTP size for
PCI1xxxx devices

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38422

Introduced commit is not determined.Fixed in v6.16-rc1.
Vulnerable function was added by d808f7c ("net: lan743x: Add support for
OTP") in 5.18-rc1.

Fixed status
mainline: [3b9935586a9b54d2da27901b830d3cf46ad66a1e]
stable/6.1: [6b4201d74d0a49af2123abf2c9d142e59566714b]
stable/6.12: [51318d644c993b3f7a60b8616a6a5adc1e967cd2]
stable/6.6: [088279ff18cdc437d6fac5890e0c52c624f78a5b]

CVE-2025-38423: ASoC: codecs: wcd9375: Fix double free of regulator supplies

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38423

Introduced by commit 216d041 ("ASoC: codecs: wcd937x: Remove separate
handling for vdd-buck supply") in v6.11-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63fe298652d4eda07d738bfcbbc59d1343a675ef]
stable/6.12: [c8228b5f3d74fd8ad4dfc79d5d601eb6fca5e63e]

CVE-2025-38424: perf: Fix sample vs do_exit()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38424

Introduced by commit c5ebced ("perf: Add ability to attach user stack
dump to sample") in v3.7-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d45c8bd5d5800889e8ec03fd65bb06af3f4c04cc]
mainline: [4f6fc782128355931527cefe3eb45338abd8ab39]
stable/5.10: [507c9a595bad3abd107c6a8857d7fd125d89f386]
stable/5.15: [a9f6aab7910a0ef2895797f15c947f6d1053160f]
stable/5.4: [7b8f3c72175c6a63a95cf2e219f8b78e2baad34e]
stable/6.1: [975ffddfa2e19823c719459d2364fcaa17673964]
stable/6.12: [456019adaa2f5366b89c868dea9b483179bece54]
stable/6.6: [2ee6044a693735396bb47eeaba1ac3ae26c1c99b]

CVE-2025-38425: i2c: tegra: check msg length in SMBUS block read

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38425

Introduced commit is not determined.Fixed in v6.16-rc1.


Fixed status
mainline: [a6e04f05ce0b070ab39d5775580e65c7d943da0b]
stable/6.1: [c39d1a9ae4ad66afcecab124d7789722bfe909fa]
stable/6.12: [75a864f21ceeb8c1e8ce1b7589174fec2c3a039e]
stable/6.6: [be5f6a65509cd5675362f15eb0440fb28b0f9d64]

CVE-2025-38426: drm/amdgpu: Add basic validation for RAS header

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38426

Introduced commit is not determined.Fixed in v6.16-rc1.
Affected file was addded by 64f55e6 ("drm/amdgpu: Add RAS EEPROM table.")
in 5.4-rc1.

Fixed status
mainline: [5df0d6addb7e9b6f71f7162d1253762a5be9138e]

CVE-2025-38427: video: screen_info: Relocate framebuffers behind PCI bridges

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38427

Introduced by commit 78aa89d ("firmware/sysfb: Update screen_info for
relocated EFI framebuffers") in v6.9-rc1.
Fixed in v6.16-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [2f29b5c231011b94007d2c8a6d793992f2275db1]
stable/6.12: [5c70e3ad85d2890d8af375333699429de26327f2]
stable/6.6: [cc3cc41ed67054a03134bea42408c720eec0fa04]

CVE-2025-38428: Input: ims-pcu - check record size in ims_pcu_flash_firmware()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38428

Introduced by commit 628329d ("Input: add IMS Passenger Control Unit
driver") in v3.10-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [cedbc4bf8aca40150f00539b22ed878b03b83128]
cip/4.4-st: [ecf9441718a85a360155a9200c22d531561fefc0]
mainline: [a95ef0199e80f3384eb992889322957d26c00102]
stable/5.10: [d63706d9f73846106fde28b284f08e01b92ce9f1]
stable/5.15: [e5a2481dc2a0b430f49276d7482793a8923631d6]
stable/5.4: [c1b9d140b0807c6aee4bb53e1bfa4e391e3dc204]
stable/6.1: [8e03f1c7d50343bf21da54873301bc4fa647479f]
stable/6.12: [5a8cd6ae8393e2eaebf51d420d5374821ef2af87]
stable/6.6: [17474a56acf708bf6b2d174c06ed26abad0a9fd6]

CVE-2025-38429: bus: mhi: ep: Update read pointer only after buffer is written

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38429

Introduced by commit bbdcba5 ("bus: mhi: ep: Add support for ring
management") in v5.19-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f18d174b73d0ceeaa341f46c0986436b3aefc9a]
stable/6.12: [f704a80d9fa268e51a6cc5242714502c3c1fa605]
stable/6.6: [44b9620e82bbec2b9a6ac77f63913636d84f96dc]

CVE-2025-38430: nfsd: nfsd4_spo_must_allow() must check this is a v4
compound request

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38430

Introduced commit is not determined.Fixed in v6.16-rc1.
It looks as if v4.4 is affected too.

Fixed status
cip/4.19-st: [d1a9581a536714d93573141b981002422a8971cb]
mainline: [1244f0b2c3cecd3f349a877006e67c9492b41807]
stable/5.10: [b1d0323a09a29f81572c7391e0d80d78724729c9]
stable/5.15: [425efc6b3292a3c79bfee4a1661cf043dcd9cf2f]
stable/5.4: [bf78a2706ce975981eb5167f2d3b609eb5d24c19]
stable/6.1: [64a723b0281ecaa59d31aad73ef8e408a84cb603]
stable/6.12: [7a75a956692aa64211a9e95781af1ec461642de4]
stable/6.6: [e7e943ddd1c6731812357a28e7954ade3a7d8517]

CVE-2025-38431: smb: client: fix regression with native SMB symlinks

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38431

Introduced by commit 12b466e ("cifs: Fix creating and resolving
absolute NT-style symlinks") in v6.14-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff8abbd248c1f52df0c321690b88454b13ff54b2]

CVE-2025-38432: net: netpoll: Initialize UDP checksum field before checksumming

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38432

Introduced by commit f1fce08 ("netpoll: Eliminate redundant
assignment") in v6.15-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5990207026987a353d5a95204c4d9cb725637fd]

CVE-2025-38433: riscv: fix runtime constant support for nommu kernels

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38433

Introduced by commit a44fb57 ("riscv: Add runtime constant support")
in v6.15-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d90d9872edae7e78c3a12b98e239bfaa66f3639]

CVE-2025-38434: Revert "riscv: Define TASK_SIZE_MAX for __access_ok()"

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38434

Introduced by commit ad5643c ("riscv: Define TASK_SIZE_MAX for
__access_ok()") in v6.10-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [890ba5be6335dbbbc99af14ea007befb5f83f174]
stable/6.12: [fe30c30bf3bb68d4a4d8c7c814769857b5c973e6]

CVE-2025-38435: riscv: vector: Fix context save/restore with xtheadvector

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38435

Introduced by commit d863910 ("riscv: vector: Support xtheadvector
save/restore") in v6.14-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4262bd0d9cc704ea1365ac00afc1272400c2cbef]

CVE-2025-38436: drm/scheduler: signal scheduled fence when kill job

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38436

Introduced commit is not determined.Fixed in v6.16-rc1.
Vunlerable function was added by 2fdb8a8 ("drm/scheduler: rework entity
flush, kill and fini") in 6.2-rc1.

Fixed status
mainline: [471db2c2d4f80ee94225a1ef246e4f5011733e50]
stable/6.12: [aefd0a935625165a6ca36d0258d2d053901555df]
stable/6.6: [c5734f9bab6f0d40577ad0633af4090a5fda2407]

CVE-2025-38437: ksmbd: fix potential use-after-free in oplock/lease break ack

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38437

Introduced commit is not determined.Fixed in v6.16-rc6.
Vulnerable function was added by e2f3448 ("cifsd: add server-side procedures
for SMB3") in 5.15-rc1.

Fixed status
mainline: [50f930db22365738d9387c974416f38a06e8057e]
stable/6.1: [e38ec88a2b42c494601b1213816d75f0b54d9bf0]
stable/6.12: [815f1161d6dbc4c54ccf94b7d3fdeab34b4d7477]
stable/6.6: [97c355989928a5f60b228ef5266c1be67a46cdf9]

CVE-2025-38438: ASoC: SOF: Intel: hda: Use devm_kstrdup() to avoid memleak.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38438

Introduced commit is not determined.Fixed in v6.16-rc4.
Vulnerable function was added by 85b6635 ("ASoC: SOF: Intel: hda: refactoring
topology name fixup for SDW mach") in 6.12-rc1.

Fixed status
mainline: [6c038b58a2dc5a008c7e7a1297f5aaa4deaaaa7e]
stable/6.12: [68397fda2caa90e99a7c0bcb2cf604e42ef3b91f]

CVE-2025-38439: bnxt_en: Set DMA unmap len correctly for XDP_REDIRECT

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38439

Introduced by commit f18c2b7 ("bnxt_en: optimized XDP_REDIRECT
support") in v5.3-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3cdf199d4755d477972ee87110b2aebc88b3cfad]
stable/5.10: [16ae306602163fcb7ae83f2701b542e43c100cee]
stable/5.15: [8d672a1a6bfc81fef9151925c9c0481f4acf4bec]
stable/5.4: [e260f4d49370c85a4701d43c6d16b8c39f8b605f]
stable/6.1: [f9eaf6d036075dc820520e1194692c0619b7297b]
stable/6.12: [f154e41e1d9d15ab21300ba7bbf0ebb5cb3b9c2a]
stable/6.6: [5909679a82cd74cf0343d9e3ddf4b6931aa7e613]

CVE-2025-38440: net/mlx5e: Fix race between DIM disable and net_dim()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38440

Introduced by commit 445a25f ("net/mlx5e: Support updating coalescing
configuration without resetting channels") in v6.10-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb41a264a3a576dc040ee37c3d9d6b7e2d9be968]
stable/6.12: [7581afc051542e11ccf3ade68acd01b7fb1a3cde]

CVE-2025-38441: netfilter: flowtable: account for Ethernet header in
nf_flow_pppoe_proto()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38441

Introduced by commit 87b3593 ("netfilter: flowtable: validate pppoe
header") in v6.9-rc5.
Fixed in v6.16-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [18cdb3d982da8976b28d57691eb256ec5688fad2]
stable/5.15: [a3aea97d55964e70a1e6426aa4cafdc036e8a2dd]
stable/6.1: [eed8960b289327235185b7c32649c3470a3e969b]
stable/6.12: [e0dd2e9729660f3f4fcb16e0aef87342911528ef]
stable/6.6: [9fbc49429a23b02595ba82536c5ea425fdabb221]

CVE-2025-38442: block: reject bs > ps block devices when THP is disabled

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38442

Introduced by commit 47dd675 ("block/bdev: lift block size
restrictions to 64k") in v6.15-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cdf1bdd45ac78a088773722f009883af30ad318]

CVE-2025-38443: nbd: fix uaf in nbd_genl_connect() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38443

Introduced by commit 6497ef8 ("nbd: provide a way for userspace
processes to identify device backends") in v5.14-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa9552438ebf015fc5f9f890dbfe39f0c53cf37e]
stable/5.15: [cb121c47f364b51776c4db904a6a5a90ab0a7ec5]
stable/6.1: [91fa560c73a8126868848ed6cd70607cbf8d87e2]
stable/6.12: [8586552df591e0a367eff44af0c586213eeecc3f]
stable/6.6: [d46186eb7bbd9a11c145120f2d77effa8d4d44c2]

CVE-2025-38444: raid10: cleanup memleak at raid10_make_request

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38444

Introduced by commit c9aa889 ("md: raid10 add nowait support") in v5.17-rc1.
Fixed in v6.16-rc6.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [43806c3d5b9bb7d74ba4e33a6a8a41ac988bde24]
stable/5.15: [10c6021a609deb95f23f0cc2f89aa9d4bffb14c7]
stable/6.1: [9af149ca9d0dab6e59e813519d309eff62499864]
stable/6.12: [2941155d9a5ae098b480d551f3a5f8605d4f9af5]
stable/6.6: [8fc3d7b23d139e3cbc944c15d99b3cdbed797d2d]

CVE-2025-38445: md/raid1: Fix stack memory use after return in raid1_reshape

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38445

Introduced by commit afeee51 ("md: convert to
bioset_init()/mempool_init()") in v4.18-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d67ed2ccd2d1dcfda9292c0ea8697a9d0f2f0d98]
stable/5.10: [12b00ec99624f8da8c325f2dd6e807df26df0025]
stable/5.15: [48da050b4f54ed639b66278d0ae6f4107b2c4e2d]
stable/5.4: [d8a6853d00fbaa810765c8ed2f452a5832273968]
stable/6.1: [5f35e48b76655e45522df338876dfef88dafcc71]
stable/6.12: [776e6186dc9ecbdb8a1b706e989166c8a99bbf64]
stable/6.6: [df5894014a92ff0196dbc212a7764e97366fd2b7]

CVE-2025-38446: clk: imx: Fix an out-of-bounds access in
dispmix_csr_clk_dev_data

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38446

Introduced by commit 5224b18 ("clk: imx: add i.MX95 BLK CTL clk
driver") in v6.10-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aacc875a448d363332b9df0621dde6d3a225ea9f]
stable/6.12: [fcee75daecc5234ee3482d8cf3518bf021d8a0a5]

CVE-2025-38447: mm/rmap: fix potential out-of-bounds page table access
during batched unmap

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38447

Introduced by commit 354dffd ("mm: support batched unmap for lazyfree
large folios during reclamation") in v6.15-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ddd05742b45b083975a0855ef6ebbf88cf1f532a]

CVE-2025-38448: usb: gadget: u_serial: Fix race condition in TTY wakeup

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38448

Introduced by commit 35f95fd ("TTY: usb/u_serial, use tty from
tty_port") in v3.5-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c529c3730bd09115684644e26bf01ecbd7e2c2c9]
stable/5.10: [d43657b59f36e88289a6066f15bc9a80df5014eb]
stable/5.15: [a5012673d49788f16bb4e375b002d7743eb642d9]
stable/5.4: [18d58a467ccf011078352d91b4d6a0108c7318e8]
stable/6.1: [ee8d688e2ba558f3bb8ac225113740be5f335417]
stable/6.12: [abf3620cba68e0e51e5c21054ce4f925f75b3661]
stable/6.6: [c6eb4a05af3d0ba3bc4e8159287722fb9abc6359]

CVE-2025-38449: drm/gem: Acquire references on GEM handles for framebuffers

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38449

Introduced commit is not determined.Fixed in v6.16-rc5.


Fixed status
mainline: [5307dce878d4126e1b375587318955bd019c3741]
stable/6.12: [08480e285c6a82ce689008d643e4a51db0aaef8b]
stable/6.6: [cb4c956a15f8b7f870649454771fc3761f504b5f]

CVE-2025-38450: wifi: mt76: mt7925: prevent NULL pointer dereference
in mt7925_sta_set_decap_offload()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38450

Introduced by commit b859ad6 ("wifi: mt76: mt7925: add link handling
in mt7925_sta_set_decap_offload") in v6.11-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35ad47c0b3da04b00b19a8b9ed5632e2f2520472]
stable/6.12: [9b50874f297fcc62adc7396f35209878e51010b0]

CVE-2025-38451: md/md-bitmap: fix GPF in bitmap_get_stats()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38451

Introduced by commit 6ec1f02 ("md/md-bitmap: fix stats collection for
external bitmaps") in v6.15-rc3.
Fixed in v6.16-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [c17fb542dbd1db745c9feac15617056506dd7195]
stable/6.1: [a23b16ba3274961494f5ad236345d238364349ff]
stable/6.12: [3e0542701b37aa25b025d8531583458e4f014c2e]
stable/6.6: [3d82a729530bd2110ba66e4a1f73461c776edec2]

CVE-2025-38452: net: ethernet: rtsn: Fix a null pointer dereference in
rtsn_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38452

Introduced by commit b0d3969 ("net: ethernet: rtsn: Add support for
Renesas Ethernet-TSN") in v6.11-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95a234f6affbf51f06338383537ab80d637bb785]
stable/6.12: [9f260e16b297f8134c5f90bb5a20e805ff57e853]

CVE-2025-38453: io_uring/msg_ring: ensure io_kiocb freeing is deferred for RCU

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38453

Introduced by commit 0617bb5 ("io_uring/msg_ring: improve handling of
target CQE posting") in v6.11-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc582cd26e888b0652bc1494f252329453fd3b23]

CVE-2025-38454: ALSA: ad1816a: Fix potential NULL pointer deref in
snd_card_ad1816a_pnp()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38454

Introduced by commit 2086917 ("ALSA: ad1816a: Use standard print API")
in v6.12-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [043faef334a1f3d96ae88e1b7618bfa2b4946388]
stable/6.12: [e14bffc90866596ba19ffe549f199d7870da4241]

CVE-2025-38455: KVM: SVM: Reject SEV{-ES} intra host migration if vCPU
creation is in-flight

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38455

Introduced by commit 0b020f5 ("KVM: SEV: Add support for SEV-ES intra
host migration") in v5.16-rc1.
Introduced by commit b566393 ("KVM: SEV: Add support for SEV intra
host migration") in v5.16-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ecf371f8b02d5e31b9aa1da7f159f1b2107bdb01]
stable/6.1: [e0d9a7cf37ca09c513420dc88e0d0e805a4f0820]
stable/6.12: [fd044c99d831e9f837518816c7c366b04014d405]
stable/6.6: [8c8e8d4d7544bb783e15078eda8ba2580e192246]

CVE-2025-38456: ipmi:msghandler: Fix potential memory corruption in
ipmi_create_user()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38456

Introduced by commit 8e76741 ("ipmi: Add a limit on the number of
users that may use IPMI") in v5.19-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa332f5dc6fc662ad7d3200048772c96b861cf6b]
stable/6.1: [cbc1670297f675854e982d23c8583900ff0cc67a]
stable/6.12: [9e0d33e75c1604c3fad5586ad4dfa3b2695a3950]
stable/6.6: [e2d5c005dfc96fe857676d1d8ac46b29275cb89b]

CVE-2025-38457: net/sched: Abort __tc_modify_qdisc if parent class
does not exist

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38457

Introduced by commit 5e50da0 ("[NET_SCHED]: Fix endless loops (part
2): "simple" qdiscs") in v2.6.20.16.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ffdde7bf5a439aaa1955ebd581f5c64ab1533963]
stable/5.10: [90436e72c9622c2f70389070088325a3232d339f]
stable/5.15: [25452638f133ac19d75af3f928327d8016952c8e]
stable/5.4: [923a276c74e25073ae391e930792ac86a9f77f1e]
stable/6.1: [23c165dde88eac405eebb59051ea1fe139a45803]
stable/6.12: [8ecd651ef24ab50123692a4e3e25db93cb11602a]
stable/6.6: [4c691d1b6b6dbd73f30ed9ee7da05f037b0c49af]

CVE-2025-38458: atm: clip: Fix NULL pointer dereference in vcc_sendmsg()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38458

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22fc46cea91df3dce140a7dc6847c6fcf0354505]
stable/5.10: [a16fbe6087e91c8e7c4aa50e1af7ad56edbd9e3e]
stable/5.15: [7f1cad84ac1a6af42d9d57e879de47ce37995024]
stable/5.4: [9ec7e943aee5c28c173933f9defd40892fb3be3d]
stable/6.1: [27b5bb7ea1a8fa7b8c4cfde4d2bf8650cca2e8e8]
stable/6.12: [34a09d6240a25185ef6fc5a19dbb3cdbb6a78bc0]
stable/6.6: [07b585ae3699c0a5026f86ac846f144e34875eee]

CVE-2025-38459: atm: clip: Fix infinite recursive call of clip_push().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38459

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c489f3283dbfc0f3c00c312149cae90d27552c45]
stable/5.10: [125166347d5676466d368aadc0bbc31ee7714352]
stable/5.15: [5641019dfbaee5e85fe093b590f0451c9dd4d6f8]
stable/5.4: [f493f31a63847624fd3199ac836a8bd8828e50e2]
stable/6.1: [1579a2777cb914a249de22c789ba4d41b154509f]
stable/6.12: [024876b247a882972095b22087734dcd23396a4e]
stable/6.6: [3f61b997fe014bbfcc208a9fcbd363a1fe7e3a31]

CVE-2025-38460: atm: clip: Fix potential null-ptr-deref in to_atmarpd().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38460

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [706cc36477139c1616a9b2b96610a8bb520b7119]
stable/5.10: [70eac9ba7ce25d99c1d99bbf4ddb058940f631f9]
stable/5.15: [3251ce3979f41bd228f77a7615f9dd616d06a110]
stable/5.4: [a4c5785feb979cd996a99cfaad8bf353b2e79301]
stable/6.1: [ee4d9e4ddf3f9c4ee2ec0a3aad6196ee36d30e57]
stable/6.12: [36caab990b69ef4eec1d81c52a19f080b7daa059]
stable/6.6: [06935c50cfa3ac57cce80bba67b6d38ec1406e92]

CVE-2025-38461: vsock: Fix transport_* TOCTOU

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38461

Introduced by commit c0cfa2d ("vsock: add multi-transports support")
in v5.5-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [687aa0c5581b8d4aa87fd92973e4ee576b550cdf]
stable/5.10: [8667e8d0eb46bc54fdae30ba2f4786407d3d88eb]
stable/5.15: [36a439049b34cca0b3661276049b84a1f76cc21a]
stable/6.1: [9ce53e744f18e73059d3124070e960f3aa9902bf]
stable/6.12: [ae2c712ba39c7007de63cb0c75b51ce1caaf1da5]
stable/6.6: [9d24bb6780282b0255b9929abe5e8f98007e2c6e]

CVE-2025-38462: vsock: Fix transport_{g2h,h2g} TOCTOU

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38462

Introduced by commit c0cfa2d ("vsock: add multi-transports support")
in v5.5-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [209fd720838aaf1420416494c5505096478156b4]
stable/5.10: [c5496ee685c48ed1cc183cd4263602579bb4a615]
stable/5.15: [80d7dc15805a93d520a249ac6d13d4f4df161c1b]
stable/6.1: [5752d8dbb3dfd7f1a9faf0f65377e60826ea9a17]
stable/6.12: [3734d78210cceb2ee5615719a62a5c55ed381ff8]
stable/6.6: [401239811fa728fcdd53e360a91f157ffd23e1f4]

CVE-2025-38463: tcp: Correct signedness in skb remaining space calculation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38463

Introduced by commit 270a1c3 ("tcp: Support MSG_SPLICE_PAGES") in v6.5-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3a5f2871adc0c61c61869f37f3e697d97f03d8c]
stable/6.12: [62e6160cfb5514787bda833d466509edc38fde23]
stable/6.6: [81373cd1d72d87c7d844d4454a526b8f53e72d00]

CVE-2025-38464: tipc: Fix use-after-free in tipc_conn_close().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38464

Introduced by commit c5fa7b3 ("tipc: introduce new TIPC server
infrastructure") in v3.11-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [667eeab4999e981c96b447a4df5f20bdf5c26f13]
stable/5.10: [15a6f4971e2f157d57e09ea748d1fbc714277aa4]
stable/5.15: [dab8ded2e5ff41012a6ff400b44dbe76ccf3592a]
stable/5.4: [03dcdd2558e1e55bf843822fe4363dcb48743f2b]
stable/6.1: [1dbf7cd2454a28b1da700085b99346b5445aeabb]
stable/6.12: [50aa2d121bc2cfe2d825f8a331ea75dfaaab6a50]
stable/6.6: [be4b8392da7978294f2f368799d29dd509fb6c4d]

CVE-2025-38465: netlink: Fix wraparounds of sk->sk_rmem_alloc.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38465

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae8f160e7eb24240a2a79fc4c815c6a0d4ee16cc]
stable/5.10: [c4ceaac5c5ba0b992ee1dc88e2a02421549e5c98]
stable/5.15: [fd69af06101090eaa60b3d216ae715f9c0a58e5b]
stable/5.4: [9da025150b7c14a8390fc06aea314c0a4011e82c]
stable/6.1: [76602d8e13864524382b0687dc32cd8f19164d5a]
stable/6.12: [4b8e18af7bea92f8b7fb92d40aeae729209db250]
stable/6.6: [55baecb9eb90238f60a8350660d6762046ebd3bd]

CVE-2025-38466: perf: Revert to requiring CAP_SYS_ADMIN for uprobes

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38466

Introduced by commit c9e0924 ("perf/core: open access to probes for
CAP_PERFMON privileged process") in v5.8-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba677dbe77af5ffe6204e0f3f547f3ba059c6302]
stable/5.10: [d7ef1afd5b3f43f4924326164cee5397b66abd9c]
stable/5.15: [c0aec35f861fa746ca45aa816161c74352e6ada8]
stable/6.1: [8e8bf7bc6aa6f583336c2fda280b6cea0aed5612]
stable/6.12: [a0a8009083e569b5526c64f7d3f2a62baca95164]
stable/6.6: [183bdb89af1b5193b1d1d9316986053b15ca6fa4]

CVE-2025-38467: drm/exynos: exynos7_drm_decon: add vblank check in IRQ handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38467

Introduced by commit 96976c3 ("drm/exynos: Add DECON driver") in v4.0-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b846350aa272de99bf6fecfa6b08e64ebfb13173]
stable/5.10: [a2130463fc9451005660b0eda7b61d5f746f7d74]
stable/5.15: [87825fbd1e176cd5b896940f3959e7c9a916945d]
stable/5.4: [b4e72c0bf878f02faa00a7dc7c9ffc4ff7c116a7]
stable/6.1: [a40a35166f7e4f6dcd4b087d620c8228922dcb0a]
stable/6.12: [e9d9b25f376737b81f06de9c5aa422b488f47184]
stable/6.6: [391e5ea5b877230b844c9bd8bbcd91b681b1ce2d]

CVE-2025-38468: net/sched: Return NULL when htb_lookup_leaf encounters
an empty rbtree

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38468

Introduced by commit 512bb43 ("pkt_sched: sch_htb: Optimize WARN_ONs
in htb_dequeue_tree() etc.") in v2.6.29-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e1d5d9b5c5966e2e42e298670808590db5ed628]
stable/6.1: [890a5d423ef0a7bd13447ceaffad21189f557301]
stable/6.12: [e5c480dc62a3025b8428d4818e722da30ad6804f]
stable/6.6: [7ff2d83ecf2619060f30ecf9fad4f2a700fca344]

CVE-2025-38469: KVM: x86/xen: Fix cleanup logic in emulation of Xen
schedop poll hypercalls

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38469

Introduced by commit 92c5896 ("KVM: x86/xen: Use kvm_read_guest_virt()
instead of open-coding it badly") in v6.2-rc2.
Fixed in v6.16.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a53249d149f48b558368c5338b9921b76a12f8c]
stable/6.12: [fd627ac8a5cff4d45269f164b13ddddc0726f2cc]
stable/6.6: [3ee59c38ae7369ad1f7b846e05633ccf0d159fab]

CVE-2025-38470: net: vlan: fix VLAN 0 refcount imbalance of toggling
filtering during runtime

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38470

Introduced by commit ad1afb0 ("vlan_dev: VLAN 0 should be treated as
"no vlan tag" (802.1p packet)") in v2.6.36-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [579d4f9ca9a9a605184a9b162355f6ba131f678d]
stable/6.1: [d43ef15bf4856c8c4c6c3572922331a5f06deb77]
stable/6.12: [8984bcbd1edf5bee5be06ad771d157333b790c33]
stable/6.6: [bb515c41306454937464da055609b5fb0a27821b]

CVE-2025-38471: tls: always refresh the queue when reading sock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38471

Introduced by commit 0d87bbd ("tls: strp: make sure the TCP skbs do
not have overlapping data") in v6.1-rc2.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ab26bce3969f8fd925fe6f6f551e4d1a508c68b]
stable/6.1: [730fed2ff5e259495712518e18d9f521f61972bb]
stable/6.12: [cdb767915fc9a15d88d19d52a1455f1dc3e5ddc8]
stable/6.6: [1f3a429c21e0e43e8b8c55d30701e91411a4df02]

CVE-2025-38472: netfilter: nf_conntrack: fix crash due to removal of
uninitialised entry

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38472

Introduced by commit 1397af5 ("netfilter: conntrack: remove the percpu
dying list") in v5.19-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d72afb340657f03f7261e9243b44457a9228ac7]
stable/6.1: [a47ef874189d47f934d0809ae738886307c0ea22]
stable/6.12: [fc38c249c622ff5e3011b8845fd49dbfd9289afc]
stable/6.6: [76179961c423cd698080b5e4d5583cf7f4fcdde9]

CVE-2025-38473: Bluetooth: Fix null-ptr-deref in l2cap_sock_resume_cb()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38473

Introduced by commit d97c899 ("Bluetooth: Introduce L2CAP channel
callback for resuming") in v3.13-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0075accbf0d76c2dad1ad3993d2e944505d99a0]
stable/6.1: [ac3a8147bb24314fb3e84986590148e79f9872ec]
stable/6.12: [b97be7ee8a1cd96b89817cbd64a9f5cc16c17d08]
stable/6.6: [c4f16f6b071a74ac7eefe5c28985285cbbe2cd96]

CVE-2025-38474: usb: net: sierra: check for no status endpoint

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38474

Introduced by commit eb4fd8c ("net/usb: add sierra_net.c driver") in
v2.6.34-rc6.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c4ca3c46167518f8534ed70f6e3b4bf86c4d158]
stable/6.1: [5849980faea1c792d1d5e54fdbf1e69ac0a9bfb9]
stable/6.12: [65c666aff44eb7f9079c55331abd9687fb77ba2d]
stable/6.6: [5dd6a441748dad2f02e27b256984ca0b2d4546b6]

CVE-2025-38475: smc: Fix various oops due to inet_sock type confusion.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38475

Introduced by commit d25a92c ("net/smc: Introduce IPPROTO_SMC") in v6.11-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60ada4fe644edaa6c2da97364184b0425e8aeaf5]
stable/6.12: [5b02e397929e5b13b969ef1f8e43c7951e2864f5]

CVE-2025-38476: rpl: Fix use-after-free in rpl_do_srh_inline().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38476

Introduced by commit a7a29f9 ("net: ipv6: add rpl sr tunnel") in v5.7-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b640daa2822a39ff76e70200cb2b7b892b896dce]
stable/6.1: [e8101506ab86dd78f823b7028f2036a380f3a12a]
stable/6.12: [06ec83b6c792fde1f710c1de3e836da6e257c4c4]
stable/6.6: [62dcd9d6e61c39122d2f251a26829e2e55b0a11d]

CVE-2025-38477: net/sched: sch_qfq: Fix race condition on qfq_aggregate

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38477

Introduced by commit 462dbc9 ("pkt_sched: QFQ Plus: fair-queueing
service at DRR cost") in v3.8-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e28d5a3f774f118896aec17a3a20a9c5c9dfc64]
stable/6.1: [466e10194ab81caa2ee6a332d33ba16bcceeeba6]
stable/6.12: [a6d735100f602c830c16d69fb6d780eebd8c9ae1]
stable/6.6: [fbe48f06e64134dfeafa89ad23387f66ebca3527]

CVE-2025-38478: comedi: Fix initialization of data for instructions
that write to subdevice

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38478

Introduced by commit ed9eccb ("Staging: add comedi core") in v2.6.29-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [46d8c744136ce2454aa4c35c138cc06817f92b8e]
stable/6.1: [d3436638738ace8f101af7bdee2eae1bc38e9b29]
stable/6.12: [c42116dc70af6664526f7aa82cf937824ab42649]
stable/6.6: [673ee92bd2d31055bca98a1d96b653f5284289c4]

CVE-2025-38480: comedi: Fix use of uninitialized data in insn_rw_emulate_bits()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38480

Introduced by commit ed9eccb ("Staging: add comedi core") in v2.6.29-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9cb26291d009243a4478a7ffb37b3a9175bfce9]
stable/6.1: [3050d197d6bc9ef128944a70210f42d2430b3000]
stable/6.12: [2af1e7d389c2619219171d23f5b96dbcbb7f9656]
stable/6.6: [10f9024a8c824a41827fff1fefefb314c98e2c88]

CVE-2025-38481: comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38481

Introduced by commit ed9eccb ("Staging: add comedi core") in v2.6.29-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08ae4b20f5e82101d77326ecab9089e110f224cc]
stable/6.1: [d4c73ce13f5b5a0fe0319f1f352ff602f0ace8e3]
stable/6.12: [992d600f284e719242a434166e86c1999649b71c]
stable/6.6: [c9d3d9667443caafa804cd07940aeaef8e53aa90]

CVE-2025-38482: comedi: das6402: Fix bit shift out of bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38482

Introduced by commit 79e5e6a ("staging: comedi: das6402: rewrite
broken driver") in v3.15-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70f2b28b5243df557f51c054c20058ae207baaac]
stable/6.1: [a18a42e77545afcacd6a2b8d9fc16191b87454df]
stable/6.12: [3eab654f5d199ecd45403c6588cda63e491fcfca]
stable/6.6: [8a3637027ceeba4ca5e500b23cb7d24c25592513]

CVE-2025-38483: comedi: das16m1: Fix bit shift out of bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38483

Introduced by commit 7299885 ("staging: comedi: das16m1: tidy up the
irq support in das16m1_attach()") in v3.14-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed93c6f68a3be06e4e0c331c6e751f462dee3932]
stable/6.1: [65c03e6fc524eb2868abedffd8a4613d78abc288]
stable/6.12: [076b13ee60eb01ed0d140ef261f95534562a3077]
stable/6.6: [adb7df8a8f9d788423e161b779764527dd3ec2d0]

CVE-2025-38484: iio: backend: fix out-of-bound write

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38484

Introduced by commit 035b498 ("iio: backend: make sure to NULL
terminate stack buffer") in v6.15-rc1.
Fixed in v6.16-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [da9374819eb3885636934c1006d450c3cb1a02ed]
stable/6.12: [6eea9f7648ddb9e4903735a1f77cf196c957aa38]

CVE-2025-38485: iio: accel: fxls8962af: Fix use after free in
fxls8962af_fifo_flush

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38485

Introduced by commit 79e3a5b ("iio: accel: fxls8962af: add hw buffered
sampling") in v5.14-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1fe16dc1a2f5057772e5391ec042ed7442966c9a]
stable/6.1: [6ecd61c201b27ad2760b3975437ad2b97d725b98]
stable/6.12: [bfcda3e1015791b3a63fb4d3aad408da9cf76e8f]
stable/6.6: [dda42f23a8f5439eaac9521ce0531547d880cc54]

CVE-2025-38486: soundwire: Revert "soundwire: qcom: Add
set_channel_map api support"

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38486

Introduced commit is not determined.Fixed in v6.16-rc7.
This fix reverts commit 7796c97 ("soundwire: qcom: Add set_channel_map
api support")
in 6.15-rc1.

Fixed status
mainline: [834bce6a715ae9a9c4dce7892454a19adf22b013]

CVE-2025-38487: soc: aspeed: lpc-snoop: Don't disable channels that
aren't enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38487

Introduced by commit 9f4f9ae ("drivers/misc: add Aspeed LPC snoop
driver") in v4.13-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56448e78a6bb4e1a8528a0e2efe94eff0400c247]
stable/6.1: [dc5598482e2d3b234f6d72d6f5568e24f603e51a]
stable/6.12: [b361598b7352f02456619a6105c7da952ef69f8f]
stable/6.6: [329a80adc0e5f815d0514a6d403aaaf0995cd9be]

CVE-2025-38488: smb: client: fix use-after-free in crypt_message when
using async crypto

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38488

Introduced by commit b0abcd6 ("smb: client: fix UAF in async
decryption") in v6.12-rc1.
Fixed in v6.16-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [b220bed63330c0e1733dc06ea8e75d5b9962b6b6]
stable/6.1: [9a1d3e8d40f151c2d5a5f40c410e6e433f62f438]
stable/6.12: [2a76bc2b24ed889a689fb1c9015307bf16aafb5b]
stable/6.6: [15a0a5de49507062bc3be4014a403d8cea5533de]

CVE-2025-38489: s390/bpf: Fix bpf_arch_text_poke() with new_addr == NULL again

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38489

Introduced by commit 7ded842 ("s390/bpf: Fix bpf_plt pointer
arithmetic") in v6.9-rc2.
Fixed in v6.16-rc7.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [6a5abf8cf182f577c7ae6c62f14debc9754ec986]
stable/6.12: [d5629d1af0600f8cc7c9245e8d832a66358ef889]
stable/6.6: [0c7b20f7785cfdd59403333612c90b458b12307c]

CVE-2025-38490: net: libwx: remove duplicate page_pool_put_full_page()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38490

Introduced by commit 3c47e8a ("net: libwx: Support to receive packets
in NAPI") in v6.3-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b7e585c04cd5f0731dd25ffd396277e55fae0e6]
stable/6.12: [08d18bda0d03f5ec376929a8c6c4495f9594593a]
stable/6.6: [3c91a56762b1f0d1e4af2d86c2cba83b61ed9eaa]

CVE-2025-38491: mptcp: make fallback action and fallback decision atomic

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38491

Introduced by commit 0530020 ("mptcp: track and update contiguous data
status") in v5.19-rc1.
Fixed in v6.16-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [f8a1d9b18c5efc76784f5a326e905f641f839894]
stable/6.12: [54999dea879fecb761225e28f274b40662918c30]

CVE-2025-38492: netfs: Fix race between cache write completion and
ALL_QUEUED being set

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38492

Introduced by commit e2d46f2 ("netfs: Change the read result collector
to only use one work item") in v6.14-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [89635eae076cd8eaa5cb752f66538c9dc6c9fdc3]

CVE-2025-38493: tracing/osnoise: Fix crash in timerlat_dump_stack()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38493

Introduced by commit e7186af ("tracing: Add back FORTIFY_SOURCE logic
to kernel_stack event structure") in v6.6-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85a3bce695b361d85fc528e6fbb33e4c8089c806]
stable/6.12: [7bb9ea515cda027c9e717e27fefcf34f092e7c41]
stable/6.6: [823d798900481875ba6c68217af028c5ffd2976b]

CVE-2025-38494: HID: core: do not bypass hid_hw_raw_request

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38494

Introduced commit is not determined.Fixed in v6.16-rc7.
hid->ll_driver->raw_request() was introduced by 4fa5a7f ("ID: core: implement
generic .request()") in 3.15-rc1.

Fixed status
mainline: [c2ca42f190b6714d6c481dfd3d9b62ea091c946b]
stable/6.1: [a62a895edb2bfebffa865b5129a66e3b4287f34f]
stable/6.12: [d18f63e848840100dbc351a82e7042eac5a28cf5]
stable/6.6: [0e5017d84d650ca0eeaf4a3fe9264c5dbc886b81]

CVE-2025-38495: HID: core: ensure the allocated report buffer can
contain the reserved report ID

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38495

Introduced commit is not determined.Fixed in v6.16-rc7.
It looks as if this vulnerablity was added by 19e4ec5 ("HID: core: fix
computation of the report size") in 3.15-rc5.

Fixed status
mainline: [4f15ee98304b96e164ff2340e1dfd6181c3f42aa]
stable/6.1: [d3ed1d84a84538a39b3eb2055d6a97a936c108f2]
stable/6.12: [a262370f385e53ff7470efdcdaf40468e5756717]
stable/6.6: [fcda39a9c5b834346088c14b1374336b079466c1]

CVE-2025-38496: dm-bufio: fix sched in atomic context

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38496

Introduced by commit 450e8de ("dm bufio: improve concurrent IO
performance") in v6.4-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1bf1a782fdf5c482215c0c661b5da98b8e75773]
stable/6.12: [68860d1ade385eef9fcdbf6552f061283091fdb8]
stable/6.6: [469a39a33a9934af157299bf11c58f6e6cb53f85]

CVE-2025-38497: usb: gadget: configfs: Fix OOB read on empty string write

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38497

Introduced commit is not determined.Fixed in v6.16-rc7.
The os_desc_qw_sign_store was added by 87213d3 ("usb: gadget: configfs:
OS String support") in 3.16-rc1. The webusb_landingPage_store was added by
93c4739 ("usb: gadget: add WebUSB landing page support") in 6.3-rc1.

Fixed status
mainline: [3014168731b7930300aab656085af784edc861f6]
stable/6.1: [2798111f8e504ac747cce911226135d50b8de468]
stable/6.12: [783ea37b237a9b524f1e5ca018ea17d772ee0ea0]
stable/6.6: [58bdd5160184645771553ea732da5c2887fc9bd1]

CVE-2025-38498: do_change_type(): refuse to operate on unmounted/not ours mounts

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38498

Introduced by commit 07b2088 ("beginning of the shared-subtree
proper") in v2.6.20.16.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0d17aa4eae2d61965f9edfcdafaa17ebdb534d84]
cip/4.4-st: [1feae3766893a3af0a96d0b699cce0074dab4bb1]
mainline: [12f147ddd6de7382dad54812e65f3f08d05809fc]
stable/5.10: [c7d11fdf8e5db5f34a6c062c7e6ba3a0971879d2]
stable/5.15: [432a171d60056489270c462e651e6c3a13f855b1]
stable/5.4: [787937c4e373f1722c4343e5a5a4eb0f8543e589]
stable/6.1: [064014f7812744451d5d0592f3d2bcd727f2ee93]
stable/6.12: [9c1ddfeb662b668fff69c5f1cfdd9f5d23d55d23]
stable/6.6: [4f091ad0862b02dc42a19a120b7048de848561f8]

* Updated CVEs

No CVEs.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

