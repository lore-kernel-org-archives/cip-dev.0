Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E69C369CB
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 22:46:09 +0000 (UTC)
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
 by mx.groups.io with SMTP id smtpd.web11.2437.1745448367349803991
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 15:46:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=A8eyAbci;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.194, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e6405e4ab4dso1385959276.0
        for <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 15:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1745448366; x=1746053166; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zO3AO0r7BtIlqYq8K/QEocYjCmM25/7IIc0q1+CI+H0=;
        b=A8eyAbcitND+NkVsL/tNEHApmMscpsipU1QDPWjQ5OXs9dA1c+hfBZA+jMzfsOwHFW
         I8Xe7ePOiU9BDI65SdoZ9h5qerLEs75aVgAr+G4nlngtdiPYRzCswLECfmuaHwWNGTb4
         HHPDCELStiQ2qRhBPkj53UuuRguez1690KundANSEVVx50WUnDtW2KIFlnsMl5OZ/Ch+
         KT/igLpaTHpncvovRjJfrjIl1dTZ+NEPZA/rzRgFm1xBOLfN2ClxbjfmWyNwAYZ1fUCf
         lPQoF8AFtYWWvBGJo04QlXXDs6/HVT3ukIz0k9U5HnjGdvXGWWPnsLdRoDZ6f2sSv286
         6TAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745448366; x=1746053166;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zO3AO0r7BtIlqYq8K/QEocYjCmM25/7IIc0q1+CI+H0=;
        b=nL69qWjo8Zr4oSkKizdB4oUFv3tTLHnPPSC6TUyEw2ehXhP7/DJylz4GwdIX9B7nox
         FeStDVVO11yiobgO+xQsWXz7ZF/2GgueRfwaEPIEeh12/PShU2XJbE6dRMvwIfh3FltR
         k/kqbzookcTdNaHW4FESMH5csKQE9qU5FjtTQO25q2lLr6dheMMnLPyEmoRtMnVnsfAO
         lmSj3oNdfMmNqVWvoPIgA3kfZPeyEjNvbG7dT8hPJd9AlrlMuc7hDUk9ZZ9YwNx3AcUi
         rPqh3QlZ1cgDx3BSPevK2m5TWsESF0OpjdVxHJcAWcLUcbboPE0ezWD0jnOEIX6E3nZi
         U+NQ==
X-Gm-Message-State: AOJu0Yxpvi5WuQCsklEZCMJkw445x0QQ9qofQSX+0Fzua90ux/TrRX4L
	2XF0gf6awNmOJ/fGiGbs4MEh0WtwwKbsgaKWq5fz5GuqPBWPA2vGPGCupjyQSq2a9iZ3+fpU+3B
	JHsHdnERiD8eLvOQw8mXCJBrowEYg52W7+upkVSiB2swkp9n3eK4E2r9Z
X-Gm-Gg: ASbGncvQGh0t1i10txf1nc4QLGvyZA9pv/7K5uKQmvKeRjHszFnvVas0erosfxkBbZI
	17xyjjb6s90fophuypVJ7IERXW+0CLPMkvnTmPR23RefkfnJ3JMWa4r+PKB4ZD6k8QZC13v8LUh
	TuFoEphQ5BTyPll8k8LJgmW8I=
X-Google-Smtp-Source: AGHT+IFDPSqzihZ77k7jpdwb0UbHA3JIh1Hh3v9D2BG3CXCWsWnAigdfiyMxNXLjpUq1l6UEnq9T4Atc9KQrCCLHG7w=
X-Received: by 2002:a05:6902:e11:b0:e73:27b:a829 with SMTP id
 3f1490d57ef6-e73051c54dfmr136968276.11.1745448366088; Wed, 23 Apr 2025
 15:46:06 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 24 Apr 2025 07:45:30 +0900
X-Gm-Features: ATxdqUHOVKy8KGxCyPk6-wcgxXHJd4RxbNwDAhVejZBY-PQ3oUPp1E05A82dBFk
Message-ID: <CAODzB9roW_ObEa8K8kowbfQ4bL3w4R78v2b_yBU4BQL4bpXrWw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 22:46:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18592

Hi!

It's this week's CVE report.

This week reported 28 new CVEs and 4 updated CVEs.

* New CVEs
CVE-2020-36789: can: dev: can_get_echo_skb(): prevent call to
kfree_skb() in hard IRQ context

Announce: https://www.cve.org/CVERecord?id=CVE-2020-36789

Introduced by commit 39549ee ("can: CAN Network device driver and
Netlink interface") in v2.6.31-rc1.
Fixed in v5.10-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7e4cf2ec0ca236c3e5f904239cec6efe1f3baf22]
cip/4.4-st: [248b71ce92d4f3a574b2537f9838f48e892618f4]
mainline: [2283f79b22684d2812e5c76fc2280aae00390365]
stable/4.19: [7e4cf2ec0ca236c3e5f904239cec6efe1f3baf22]
stable/5.10: [2283f79b22684d2812e5c76fc2280aae00390365]
stable/5.4: [ab46748bf98864f9c3f5559060bf8caf9df2b41e]

CVE-2021-47668: can: dev: can_restart: fix use after free bug

Announce: https://www.cve.org/CVERecord?id=CVE-2021-47668

Introduced by commit 39549ee ("can: CAN Network device driver and
Netlink interface") in v2.6.31-rc1.
Fixed in v5.11-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [08ab951787098ae0b6c0364aeea7a8138226f234]
cip/4.4-st: [260925a0b7d2da5449f8ecfd02c1405e0c8a45b8]
mainline: [03f16c5075b22c8902d2af739969e878b0879c94]
stable/4.19: [08ab951787098ae0b6c0364aeea7a8138226f234]
stable/5.10: [593c072b7b3c4d7044416eb039d9ad706bedd67a]
stable/5.4: [ac48ef15826e83f4206c47add61072e8fc76d328]

CVE-2021-47669: can: vxcan: vxcan_xmit: fix use after free bug

Announce: https://www.cve.org/CVERecord?id=CVE-2021-47669

Introduced by commit a8f820a ("can: add Virtual CAN Tunnel driver
(vxcan)") in v4.12-rc1.
Fixed in v5.11-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9b820875a32a3443d67bfd368e93038354e98052]
mainline: [75854cad5d80976f6ea0f0431f8cedd3bcc475cb]
stable/4.19: [9b820875a32a3443d67bfd368e93038354e98052]
stable/5.10: [e771a874076115df8bff27d325edfd2340e4ec69]
stable/5.4: [a24476b37167816e6352ca1a2cf3769847774f70]

CVE-2021-47670: can: peak_usb: fix use after free bugs

Announce: https://www.cve.org/CVERecord?id=CVE-2021-47670

Introduced by commit 0a25e1f ("can: peak_usb: add support for PEAK new
CANFD USB adapters") in v4.0-rc1.
Fixed in v5.11-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5408824636fa0dfedb9ecb0d94abd573131bfbbe]
mainline: [50aca891d7a554db0901b245167cd653d73aaa71]
stable/4.19: [5408824636fa0dfedb9ecb0d94abd573131bfbbe]
stable/5.10: [ec939c13c3fff2114479769c8380b7f1a54feca9]
stable/5.4: [ddd1416f44130377798c1430b76503513b7497c2]

CVE-2021-47671: can: etas_es58x: es58x_rx_err_msg(): fix memory leak
in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2021-47671

Introduced by commit 8537257 ("can: etas_es58x: add core support for
ETAS ES58X CAN USB interfaces") in v5.13-rc1.
Fixed in v5.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9447f768bc8c60623e4bb3ce65b8f4654d33a50]
stable/5.15: [7eb0881aec26099089f12ae850aebd93190b1dfe]

CVE-2025-37785: ext4: fix OOB read when checking dotdot dir

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37785

Introduced by commit ac27a0e ("[PATCH] ext4: initial copy of files
from ext3") in v2.6.20.16.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5e206778e96e8667d3bde695ad372c296dc9353]
stable/5.10: [e47f472a664d70a3d104a6c2a035cdff55a719b4]
stable/5.15: [b7531a4f99c3887439d778afaf418d1a01a5f01b]
stable/6.1: [89503e5eae64637d0fa2218912b54660effe7d93]
stable/6.6: [52a5509ab19a5d3afe301165d9b5787bba34d842]

CVE-2025-37860: sfc: fix NULL dereferences in ef100_process_design_param()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37860

Introduced by commit 98ff4c7 ("sfc: Separate netdev probe/remove from
PCI probe/remove") in v6.0-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8241ecec1cdc6699ae197d52d58e76bddd995fa5]

CVE-2025-37893: LoongArch: BPF: Fix off-by-one error in build_prologue()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37893

Introduced by commit 5dc6155 ("LoongArch: Add BPF JIT support") in v6.1-rc1.
Introduced by commit bb035ef ("LoongArch: BPF: Support mixing bpf2bpf
and tailcalls") in v6.4-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e2586991e36663c9bc48c828b83eab180ad30a9]
stable/6.1: [e9ccb262b39ab01a5ac2e485b7996b8498e7b373]
stable/6.6: [b3ffad2f02db4aace6799fe0049508b8925eae45]

CVE-2025-37925: jfs: reject on-disk inodes of an unsupported type

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37925

Introduced by commit 79ac5a4 ("jfs_lookup(): don't bother with . or
..") in v3.1-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c3f9a70d2d4dd6c640afe294b05c6a0a45434d9]

CVE-2025-38049: x86/resctrl: Fix allocation of cleanest CLOSID on
platforms with no monitors

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38049

Introduced by commit 6eac36b ("x86/resctrl: Allocate the cleanest
CLOSID by searching closid_num_dirty_rmid") in v6.9-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a121798ae669351ec0697c94f71c3a692b2a755b]

CVE-2025-38104: drm/amdgpu: Replace Mutex with Spinlock for RLCG
register access to avoid Priority Inversion in SRIOV

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38104

Introduced by commit e864180 ("drm/amdgpu: Add lock around VF RLCG
interface") in v6.11-rc1.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [dc0297f3198bd60108ccbd167ee5d9fa4af31ed0]

CVE-2025-38152: remoteproc: core: Clear table_sz when rproc_shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38152

Introduced by commit 9dc9507 ("remoteproc: Properly deal with the
resource table when detaching") in v5.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [efdde3d73ab25cef4ff2d06783b0aad8b093c0e4]
stable/5.15: [6e66bca8cd51ebedd5d32426906a38e4a3c69c5f]
stable/6.1: [e6015ca453b82ec54aec9682dcc38773948fcc48]
stable/6.6: [7c6bb82a6f3da6ab2d3fbea03901482231708b98]

CVE-2025-38240: drm/mediatek: dp: drm_err => dev_err in HPD path to
avoid NULL ptr

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38240

Introduced by commit 7eacba9 ("drm/mediatek: dp: Add
.wait_hpd_asserted() for AUX bus") in v6.6-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [106a6de46cf4887d535018185ec528ce822d6d84]
stable/6.6: [13ec849fd2eab808ee8eba2625df7ebea3b85edf]

CVE-2025-38479: dmaengine: fsl-edma: free irq correctly in remove path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38479

Introduced by commit 44eb827 ("dmaengine: fsl-edma: request
per-channel IRQ only when channel is allocated") in v6.11-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa70c4c3c580c239a0f9e83a14770ab026e8d820]

CVE-2025-38575: ksmbd: use aead_request_free to match aead_request_alloc

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38575

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6171063e9d046ffa46f51579b2ca4a43caef581a]
stable/5.15: [571b342d4688801fc1f6a1934389dac09425dc93]
stable/6.1: [a6b594868268c3a7bfaeced912525cd2c445529a]
stable/6.6: [1de7fec4d3012672e31eeb6679ea60f7ca010ef9]

CVE-2025-38637: net_sched: skbprio: Remove overly strict queue assertions

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38637

Introduced by commit aea5f65 ("net/sched: add skbprio scheduler") in v4.19-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce8fe975fd99b49c29c42e50f2441ba53112b2e8]
stable/5.10: [1284733bab736e598341f1d3f3b94e2a322864a8]
stable/5.15: [32ee79682315e6d3c99947b3f38b078a09a66919]
stable/5.4: [7abc8318ce0712182bf0783dcfdd9a6a8331160e]
stable/6.1: [1dcc144c322a8d526b791135604c0663f1af9d85]
stable/6.6: [864ca690ff135078d374bd565b9872f161c614bc]

CVE-2025-39688: nfsd: allow SC_STATUS_FREEABLE when searching via
nfs4_lookup_stateid()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39688

Introduced by commit 8dd91e8 ("nfsd: fix race between laundromat and
free_stateid") in v6.12-rc5.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1bc15b147d35b4cb7ca99a9a7d79d41ca342c13]

CVE-2025-39728: clk: samsung: Fix UBSAN panic in samsung_clk_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39728

Introduced by commit e620a1e ("drivers/clk: convert VL struct to
struct_size") in v5.5-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d19d7345a7bcdb083b65568a11b11adffe0687af]
stable/5.10: [00307934eb94aaa0a99addfb37b9fe206f945004]
stable/5.15: [d974e177369c034984cece9d7d4fada9f8b9c740]
stable/6.1: [0fef48f4a70e45a93e73c39023c3a6ea624714d6]
stable/6.6: [4d29a6dcb51e346595a15b49693eeb728925ca43]

CVE-2025-39735: jfs: fix slab-out-of-bounds read in ea_get()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39735

Introduced by commit d9f9d96 ("jfs: xattr: check invalid xattr size
more strictly") in v6.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [fdf480da5837c23b146c4743c18de97202fcab37]
stable/5.10: [50afcee7011155933d8d5e8832f52eeee018cfd3]
stable/5.15: [78c9cbde8880ec02d864c166bcb4fe989ce1d95f]
stable/5.4: [3d6fd5b9c6acbc005e53d0211c7381f566babec1]
stable/6.1: [46e2c031aa59ea65128991cbca474bd5c0c2ecdb]
stable/6.6: [a8c31808925b11393a6601f534bb63bac5366bab]

CVE-2025-39755: staging: gpib: Fix cb7210 pcmcia Oops

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39755

Introduced by commit e9dc699 ("staging: gpib: Add Computer Boards GPIB
driver") in v6.13-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1baf6528bcfd6a86842093ff3f8ff8caf309c12]

CVE-2025-39778: objtool, nvmet: Fix out-of-bounds stack access in
nvmet_ctrl_state_show()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39778

Introduced by commit 649fd41 ("nvmet: add debugfs support") in v6.11-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [107a23185d990e3df6638d9a84c835f963fe30a6]

CVE-2025-39930: ASoC: simple-card-utils: Don't use __free(device_node)
at graph_util_parse_dai()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39930

Introduced by commit 419d191 ("ASoC: simple-card-utils: use
__free(device_node) for device node") in v6.14-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de74ec718e0788e1998eb7289ad07970e27cae27]

CVE-2025-39989: x86/mce: use is_copy_from_user() to determine
copy-from-user context

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39989

Introduced by commit 4c132d1 ("x86/futex: Remove .fixup usage") in v5.17-rc1.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [1a15bb8303b6b104e78028b6c68f76a0d4562134]

CVE-2025-40014: objtool, spi: amd: Fix out-of-bounds stack access in
amd_set_spi_freq()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40014

Introduced by commit 3fe2612 ("spi: amd: Configure device speed") in v6.1-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76e51db43fe4aaaebcc5ddda67b0807f7c9bdecc]

CVE-2025-40114: iio: light: Add check for array bounds in
veml6075_read_int_time_ms

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40114

Introduced by commit 3b82f43 ("iio: light: add VEML6075 UVA and UVB
light sensor driver") in v6.8-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee735aa33db16c1fb5ebccbaf84ad38f5583f3cc]

CVE-2025-40325: md/raid10: wait barrier before returning discard
request with REQ_NOWAIT

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40325

Introduced by commit c9aa889 ("md: raid10 add nowait support") in v5.17-rc1.
Fixed in v6.15-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [3db4404435397a345431b45f57876a3df133f3b4]

CVE-2025-37838: HSI: ssi_protocol: Fix use after free vulnerability in
ssi_protocol Driver Due to Race Condition

Announce: https://www.cve.org/CVERecord?id=CVE-2025-37838

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [e3f88665a78045fe35c7669d2926b8d97b892c11]
stable/6.12: [ae5a6a0b425e8f76a9f0677e50796e494e89b088]
stable/6.13: [834e602d0cc7c743bfce734fad4a46cefc0f9ab1]
stable/6.14: [4b4194c9a7a8f92db39e8e86c85f4fb12ebbec4f]

CVE-2025-40364: io_uring: fix io_req_prep_async with provided buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40364

This CVE announce does not contain fixed commit in the mainline.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b85ea95d086471afb4ad062012a4d73cd328fa86]
stable/6.1: [a1b17713b32c75a90132ea2f92b1257f3bbc20f3]
stable/6.6: [a94592ec30ff67dc36c424327f1e0a9ceeeb9bd3]

* Updated CVEs

CVE-2024-53204: phy: realtek: usb: fix NULL deref in rtk_usb3phy_probe

stable/6.6 was fixed.

Fixed status
stable/6.12: [776f13ad1f88485206f1dca5ef138553106950e5]
stable/6.6: [e27877990e54bfe4246dd850f7ec8646c999ce58]

CVE-2024-53205: phy: realtek: usb: fix NULL deref in rtk_usb2phy_probe

stable/6.6 was fixed.

Fixed status
stable/6.12: [fb83c9a08324e37f321ffb400809aa4310387d65]
stable/6.6: [7e2cde1813418b39b5e95d86e10d6701dccf18af]

CVE-2025-22026: nfsd: don't ignore the return code of svc_proc_register()

stable/6.12, stable/6.13 were fixed.

Fixed status
stable/6.12: [6a59b70fe71ec66c0dd19e2c279c71846a3fb2f0]
stable/6.13: [e31957a819e60cf0bc9a49408765e6095fd3d046]
stable/6.14: [9d9456185fd5f1891c74354ee297f19538141ead]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

