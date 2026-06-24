Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9DACDE000
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 23:11:58 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.328.1782342710924557859
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jun 2026 16:11:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=D386cmn/;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.176, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7fdeab38240so15522147b3.2
        for <cip-dev@lists.cip-project.org>; Wed, 24 Jun 2026 16:11:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782342710; cv=none;
        d=google.com; s=arc-20260327;
        b=BV1CwpZPEGII2SIjheMvWtFyzXUdaFMjt2BJ4JSaYB14vIFanxUt3rziz2YPjfWNGo
         8X33Y7YdonJT3Y7cEQeuRXk9muzwkOilbIuBayfg21ktJ4xOTXqtyrfcELDTC4McvzQh
         dnxoMTp0UO1WCZ02QL1BfpVeyZkzVCQ2O4pqscfxz5ScpNya2C8DIeijpF+7Ph4S+Z2D
         VIziKQoh4+SlZGU58BYgyAC3K++vvfigwgYa5oUmyRAIBAGEzaYt4VncTWCcEhQDhblZ
         H+J23mtLWfIB1y4P4LyNvP7etrOmMIrSqbo5nloXyo0SuLy07uJrGj5w2wBI4/tvrd5F
         YG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5nCCDhmxMlvszMrr5ak+YKyuDMu91VItxSnnBCsdp0c=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=eL60Bpqsjv0lgXgIMuL8g/W+ypyc0TRwRDepcN2nrWqS1cVEETcNFMka/RvXw+sarp
         N8rimz/nq3Rwh5LxSCQxh0BiNQkKBPWD8pH0jkP7m+jo0OK7LipNjtRnwiyDQsdWoRNS
         D3VRx4AE2sygcqG4cJ8GmrM/mIJ1gazQJR6WBCSfb4EZicnoo/9PTDJKURgpptT/h7vA
         P04zLjyTcR4wbycMMxZH/nEVVXsxlTQop44kuyO0IRzV5vJxSzstEavo/fICFm3AYfkl
         NDglSUTbAgC7SRDkmEOQizmXt1Ot1TcFL8Lss1wSF+AWCsPfVooVhDOKRDddYf3xAofm
         Vqqg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1782342710; x=1782947510; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5nCCDhmxMlvszMrr5ak+YKyuDMu91VItxSnnBCsdp0c=;
        b=D386cmn/et1oYvV9ScBzvt7yc3CQKYx9/WTQy8vv5ojhXqnV+pxCQiuJbZRyasTOT5
         yX6DjVirsHbNp/Zg8Ra6vFncdP6YbTOb8XfRJwobLLI4xlK5kGkvwG4aa+HPjRNrtuQh
         plwtjTdFuVCB8Y8tK2ZjDejOUBMI6/4U+7ZJxeBaF9Iw0e2eGf8k+KroWveEGy+BpAAw
         VOCZaQ3p7XDLPtIirO/pl6w7Cok2mn4PPrGaHFSU+9+4gGpnXlAQARkYeKBabaYiYEDo
         uGCOX8VHSjxAKQ+ptcVJxXdSQF9xO6am5UPKOAx+D1Vd6NDhOACYuo4XdeWx+LvrJktI
         JAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782342710; x=1782947510;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5nCCDhmxMlvszMrr5ak+YKyuDMu91VItxSnnBCsdp0c=;
        b=YTU6vedlpmt90KLWNQpkn+KlgFo8pf8U4Nq1Urr18luMB/nCowRzNV1ZbsI47AockJ
         pyjGCUC9OqtZ60rfbYon9bD+gJkX5dAlbgAXzrroKYb2IZONQmA437yYFja7mizCd8CD
         qmEASnBtyUHVu9JfGfI1XYrU2nD9/dq+yJtd+eo6N/0m26HqrBNexXU7AzMdt5R7Al9y
         kP6VDIpiogkcyUagZ8S6VjMj066WMAQYqOCBzcy2izqQdzMZmnfenMR8MESYvXA/5vQZ
         bhdq+/s4+Ra0VNJxICs3Vr9xv7M7pzMIJdtBkGZAzjoh6TYcKI4wsdRQdjPixESgZFmR
         0mQA==
X-Gm-Message-State: AOJu0Yy65VLfweGLhS5tVDzj5eo0BuiJ3yH84LT3wpHFeV/q8kTzQhRP
	xT5IbnSy00n14xTiPP4E3FyAPS0dSx0m8LWCm2FfxxMwlXgpshEJThWsX8KaJtAGtT++uFYFP0t
	xeN08yA0pMlluvkN5Hbqz6k2syLgEdyOxWVnn/vclVEWMqjd2nZXYwJLfeg==
X-Gm-Gg: AfdE7cl8brdpV2rlPLTmCbVDdAbLLMNq3+LOX0BYi0Y0JVCt6jdUo1M9rzidNwvxx0C
	lf3ewZT6OZAsAhkub05INE69TLzMY6eXVMDOqmQ5cv3yd0wPjlBhPqukBsA8hXZwiEyE3cnb/wx
	3w2cT3h5AIHCLD4RQuij02MC5wSJhEtleVenc4YNI/X5XvoYVQLWWbY4PtFXWC1wJhAoO7sZLkF
	ato4C40ED/UDCJeqJJKd6yCwSBI1IQMYDu5O2BUBMwAQkFtrgWAzCOVkBFupcYG1t1Pn2FaAw==
X-Received: by 2002:a05:690c:7301:b0:7d0:4824:6424 with SMTP id
 00721157ae682-80a6d2615a1mr2245147b3.39.1782342706871; Wed, 24 Jun 2026
 16:11:46 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 25 Jun 2026 08:11:10 +0900
X-Gm-Features: AVVi8CfvQTxIXF1CSOpd8ra0-Bv_6dqXexYv3gkRBuLi7ZIdfJSTCmPWZeSuW6Q
Message-ID: <CAODzB9ruOdT89OuGg+-dzb9P0eE5rLgjY+HQ7uVOS19a7qCG_Q@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Jun 2026 23:11:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23277

Hi!

It's this week's CVE report.

This week reported 223 new CVEs and 104 updated CVEs.

* New CVEs
CVE-2026-52908: RDMA: During rereg_mr ensure that REREG_ACCESS is compatible

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52908

Introduced by commit b40656a ("RDMA/umem: remove FOLL_FORCE usage") in v6.2-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [badad6fad60def1b9805559dd81dbab3d97b82aa]
stable/6.12: [eba5df21eda0fe7418efbea2f799f8ea1b8ca94c]
stable/6.18: [2904e985a2917b5dac65df82733065e78a65fc9d]
stable/6.6: [09dc18894148381d3bfc550083b1236043870dce]
stable/7.0: [50334a05a950840b39a1ce3d2a173b4183db9b3e]

CVE-2026-52909: ip6_vti: set netns_immutable on the fallback device.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52909

Introduced by commit 61220ab ("vti6: Enable namespace changing") in v3.15-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d289d5307762d1838aaece22c6b6fcad9e8865f9]
stable/6.18: [ecf8904067dcba0dad86ece80874841e60317885]
stable/7.0: [dcdce3bc9f08026ff3739ee7339e1bef526fc5f3]

CVE-2026-52910: bpf: Free reuseport cBPF prog after RCU grace period.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52910

Introduced by commit 538950a ("soreuseport: setsockopt
SO_ATTACH_REUSEPORT_[CE]BPF") in v4.5-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18fc650ccd7fe3376eca89203668cfb8268f60df]
stable/5.10: [08264d5bba0bdd3a79bc2984fee09286aba0c4eb]
stable/5.15: [fec41484e7c2aa7ded44c541bba98872be937754]
stable/6.1: [c3e3fddda6b5d9ba505d218b4055e7d8a282ac57]
stable/6.12: [298db6167f81e9c470a57cf652e4e47757b4293e]
stable/6.18: [87dfb977bdb6eaa47e9993a34e18f44970f88b1f]
stable/6.6: [f8b8f1d4bb76098e87b8269a0631019648330e6d]
stable/7.0: [90e47dc5c572d1c73971ac51c7428803f42b78eb]

CVE-2026-52911: ksmbd: scope conn->binding slowpath to bound sessions only

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52911

Introduced by commit f5a544e ("ksmbd: add support for SMB3
multichannel") in v5.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0da97c034b6107d14e537e212d4ce8b22109a58]
stable/5.15: [e74c00c6af428a39e564cdc5bd3a3648c6d8de87]
stable/6.1: [e3a93ce6e25757b8f375e38b8f91e1d9da4edc1a]
stable/6.12: [974c1c224e85549dc3459f3bb2255bbbdd2b9372]
stable/6.18: [2cc8a4db633b10715450b291c1343859a4b2c509]
stable/6.6: [1ff46c9915c1cbf454db58a8cb87f7cac818e6a6]
stable/7.0: [1e2bec062c5c9ec282636715166056d0998d746d]

CVE-2026-52912: netfilter: nf_queue: hold bridge skb->dev while queued

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52912

Introduced by commit ac28634 ("netfilter: bridge: add nf_afinfo to
enable queuing to userspace") in v4.7-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e196115ec330a18de415bdb9f5071aa9f08e53ce]
stable/5.10: [950d809f154dca04e5fbe5d3c8b9c5e44769cd57]
stable/5.15: [a698ac8ab2561cf575d2d9f34095032651dd952e]
stable/6.1: [19924bdd8a45ebc72a7b84c57fd63057d1dc75ac]
stable/6.12: [3823c27099cfe2482299065814adbaa771be9644]
stable/6.18: [15d464265120ab9818bd673af301deee09bedab2]
stable/6.6: [1e5e20031c5eee8d2e490a90ff4d6a2feecfc3be]
stable/7.0: [3fb0f5c0f64162a8c3f25616a4f1e340b921737f]

CVE-2026-52913: batman-adv: v: stop OGMv2 on disabled interface

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52913

Introduced by commit 0da0035 ("batman-adv: OGMv2 - add basic
infrastructure") in v4.6-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8ce8b8331a1bc44ad4905886a482214d428b253]
stable/5.10: [d7391a2b854a62235539c68e9cbf6fc7910a8e9a]
stable/5.15: [70c9f6ab0d8f785087fb74fb85464a9a5288bfdb]
stable/6.1: [040fe8eb34624002071dd21de9824dfe668ce65d]
stable/6.12: [aad70db50ea3d7dfe30e402b889ff075a293b287]
stable/6.18: [1be1e99cbd5b74a69d3f92200ca87cf1bce852db]
stable/6.6: [31dcb9711abd1dcd2080d9fac05c79dd9997d6bf]
stable/7.0: [4ff461af943efb5e74d09942d5ffee7644d1e1fe]

CVE-2026-52914: batman-adv: fix fragment reassembly length accounting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52914

Introduced by commit 610bfc6 ("batman-adv: Receive fragmented packets
and merge") in v3.13-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cd3f16c320bfdadd4509358122368deb56a5741]
stable/5.10: [e4f3f6b818aa6a678bc54a2d4e0bece2303c6a64]
stable/5.15: [37be61825b15534a16ff9cfc9546de155b6df982]
stable/6.1: [975563c5de1123dde1ec7946bf5556d20c89d74e]
stable/6.12: [e910dbf509125fe51ad68e4fa74dc8ab0a8e787a]
stable/6.18: [3eb8bcb823391bd58997831b3c9c152a4ba8e255]
stable/6.6: [f653b040dad1af70fa5cd4fe085e4758925480c9]
stable/7.0: [fdb2c96efb2baeb3725e9ce3ede8f1e36f5490f0]

CVE-2026-52915: netfilter: ip6t_hbh: reject oversized option lists

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52915

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4322dcde6b4173c2d8e8e6118ed290794263bcc8]
stable/5.10: [2d523ba48d4ecc46acfb6aba548292cfcce1ac02]
stable/5.15: [588933f1a2ca5ff99274f8c9f25dc3a25d0191c3]
stable/6.1: [784aadea7a108c9f90985683caa87fb0198c6a39]
stable/6.12: [db0250470f023f159094052c0bd5ab026a88ae93]
stable/6.18: [57b0ac5e1b46f1f0338dff392ef2092e2871b412]
stable/6.6: [41ec2e242f1702e8370ddfe14d22b7a766021c3e]
stable/7.0: [6feb43c0995ab3a9c826707eb46541a1696fe4f7]

CVE-2026-52916: batman-adv: frag: disallow unicast fragment in fragment

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52916

Introduced by commit 610bfc6 ("batman-adv: Receive fragmented packets
and merge") in v3.13-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc62216dc8e221e3781afa14430f45208bfa9af9]
stable/5.10: [0c208fa3859e3a33a1c38bebc41d021166e94ac8]
stable/5.15: [bcda4814dc6524283c0b958882cb963d75fe411d]
stable/6.1: [aea54d0bbe156d5ab7d00d68f66149ff41f4612a]
stable/6.12: [5418be6c2e117bf8a316582795a8e3ff90f45e5d]
stable/6.18: [5895ad21c7059a652da83fb817510f7a1e962abf]
stable/6.6: [b54e459cf86943583c1aa2ee3081874e7ab1f5f3]
stable/7.0: [7138c35c9ad39a2fca6264af6b87466471f04ffc]

CVE-2026-52917: sctp: diag: reject stale associations in dump_one path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52917

Introduced by commit 8f840e4 ("sctp: add the sctp_diag.c file") in v4.7-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5eba3e48d78edd7551b992cb7ba687019b3a78da]
stable/5.10: [6657af827e21883ae90693e42e7f59a6aab690b5]
stable/5.15: [b2be72d401833194917e44fbd8d8144bb4f2db16]
stable/6.1: [5425de8bd6e9fe5bd67d158e3348171ae7510117]
stable/6.12: [480f754580b5686b928977d16a59f20cef83ff01]
stable/6.18: [78c4f964b2f94e405721c093773f6250e1e676b2]
stable/6.6: [e97c2a535e23ed0fdd2660993fb3f10d9535c9bc]
stable/7.0: [f5af203dec6e0e7a6090fcc2130e9f3901bfc84d]

CVE-2026-52918: Bluetooth: serialize accept_q access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52918

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e83f5e24da741fa9405aeeff00b08c5ee7c37b88]
stable/5.10: [d9ce4de05df2385c19e2c7d12f529144e1a44af1]
stable/5.15: [41c8c1c7923e86e0eb59cfb4279349112756a336]
stable/6.1: [4ec17782fd186f901a7329605d11048b085b945a]
stable/6.12: [85f8674cae82053f1e6bab295f6a8422cca14db5]
stable/6.18: [8b4c412e001b0c670eb937beab491af974da55b3]
stable/6.6: [be43e6b4043113c3b3cf887c3c8350f67140274c]
stable/7.0: [a218bf69eb51fefe59a3976fa8925261141f681c]

CVE-2026-52919: batman-adv: fix tp_meter counter underflow during shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52919

Introduced by commit 33a3bb4 ("batman-adv: throughput meter
implementation") in v4.8-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94f3b133168d1c49895e7cc6afbcf1cc0b354602]
stable/5.10: [e75e2ab463b5b34df6b98f94d740aff327ce9f6b]
stable/5.15: [abae88fa254f2981d39ac003a7b302528a22af64]
stable/6.1: [c66d20a3ff095e3f000551d208ec2606616db15c]
stable/6.12: [01cefc5923889e29dbb5f281c3d457714ceb9c00]
stable/6.18: [90ae3eae06b7b8ab9f6250b9497c860915b4c17b]
stable/6.6: [c1bac194733aabd731aafa6a01350c229e187dba]
stable/7.0: [aeae11c5dad9cd0d50723890bdd866f8e6db2e7d]

CVE-2026-52920: netfilter: xt_policy: fix strict mode inbound policy matching

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52920

Introduced by commit c4b8851 ("[NETFILTER]: x_tables: replace
IPv4/IPv6 policy match by address family independant version") in
v2.6.20.16.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b2b4d7d4e203c92db8966b163edfacb1f0e1e29]
stable/5.10: [eb323f7b82d2e2f638de0cc2a177803eb20e0707]
stable/5.15: [fc1c518bb1f054831ecabb32da9b8e1dff9699c6]
stable/6.1: [f98b7f85e04b40e28b08c461ded0cc79f14f5509]
stable/6.12: [b130a6eefa02bd4d475f2f059da8bcfb3e7d18d9]
stable/6.18: [938867e870fb5471bb16f442aeac81326e05bf65]
stable/6.6: [82664d0f1ba25e4f9a71994954abae24c60f4067]
stable/7.0: [392cc1d8408b5665215c1e9290bbf0f92339b043]

CVE-2026-52921: netfilter: ipset: stop hash:* range iteration at end

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52921

Introduced by commit 48596a8 ("netfilter: ipset: Fix adding an IPv4
range containing more than 2^31 addresses") in v4.14-rc5.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d3a282ab5f165fc207ff49ea5b6ad8f54616bd6]
stable/5.10: [be75218fadea22e59c8673db212f29c681bf45bb]
stable/5.15: [383418c20e69f5761b6ec5238f599423f4fb77fb]
stable/6.1: [0d7b33ace701fe397e6e4de145f32e098178d901]
stable/6.12: [02f75f041a93ea045834da89cd3234f4c1d749b4]
stable/6.18: [952e988163c2ab9939c3db9f0f8e77af6a1bb436]
stable/6.6: [c281e018af98df91827d65bec00f4956c00a1b02]
stable/7.0: [0b530efb2cc9dbdddfd49d392e3a857f0d4ce8dc]

CVE-2026-52922: batman-adv: dat: handle forward allocation error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52922

Introduced by commit 785ea11 ("batman-adv: Distributed ARP Table -
create DHT helper functions") in v3.8-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d8826a2d3657cea66fb0370f9e521575a673871]
stable/5.10: [9bcebaedfb8479cb4affb23c7a0d000ca9a20e73]
stable/5.15: [2edb8aeb3cdda9d00ec4997252dc5bcd6f54d8ef]
stable/6.1: [ce0c381199402a2c58f4599f4f6ed100d872d0da]
stable/6.12: [4d420d9ee70a220a2cd95aa0dd2e15acad66a505]
stable/6.18: [9cceea8eeba710def2a5707ee00f00c74a9a1cac]
stable/6.6: [866ac1d57040ed0b44ca732e3c66b3aa6b93011c]
stable/7.0: [cf48e75fc4fe0d5cc7721c82d454221d01367b93]

CVE-2026-52923: ipc: limit next_id allocation to the valid ID range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52923

Introduced by commit 03f5956 ("ipc: add sysctl to specify desired next
object id") in v3.8-rc3.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa0b9b2b7ae3539908d69c2b9ac0d144d9bc5139]
stable/5.10: [3bbe2bb9111ce6967a951bfac79af142d816fae5]
stable/5.15: [8c58a92849175f5e2ab7bc2734b3b89afe79f6ef]
stable/6.1: [af24e202b543ded8a34f1d5d3db54eb916173f04]
stable/6.12: [41058d4c3f63ab64901560a704882e0565f4e456]
stable/6.18: [a3cc795129e5ec0f8948653a3bf471e7d8852f5e]
stable/6.6: [157ce2c6836ce0ff19108a819f38df061345425f]
stable/7.0: [bd4be70669af55b974860d13680348cfdf50bbed]

CVE-2026-52924: sctp: purge outqueue on stale COOKIE-ECHO handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52924

Introduced by commit 5bbbbe3 ("sctp: introduce stream scheduler
foundations") in v4.15-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e374b22e9b07b72a25909621464ff74096151bfb]
stable/5.10: [84b7a319105db2f917ccdcf502bdc866082b1285]
stable/5.15: [f46e1d1a758878f0d22c4fbbd1bf42bb7165d1e8]
stable/6.1: [3c0741a441a7df7099d7ca6a64a6a0de09c677c8]
stable/6.12: [1d4652f677906a64487c13f9ace54b0eb263b5d0]
stable/6.18: [a6207349e703cfc04756a4d16dec9176135813a5]
stable/6.6: [2afc9e684dc7fecf73db1edc937ebbc47b4b68dc]
stable/7.0: [83ade59e5da365f4bf8bce72c5a38774202b442f]

CVE-2026-52925: vrf: Fix a potential NPD when removing a port from a VRF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52925

Introduced by commit fdeea7b ("net: vrf: Set slave's private flag
before linking") in v4.12-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2674d603a9e6970463b2b9ebcf8e31e90beae169]
stable/5.10: [2c022f582fd16a470df6ed9e7fb7e9fc48946d49]
stable/5.15: [4ab6fc60ed5a0344b60711b09bff1dc238d8d6a4]
stable/6.1: [468defa0b70902a22f4478c1207624bc1b31c124]
stable/6.12: [8c2b792f04a3db97c9d8d2a45817e93f8884baf5]
stable/6.18: [a7a97f2303e63ede105c1d55ef53dc497364e11d]
stable/6.6: [3db8d078f7f652379ee394132b169d304f6eb4c1]
stable/7.0: [d47204c127992da0c976ac9747070a575912e0fe]

CVE-2026-52926: batman-adv: clear current gateway during teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52926

Introduced by commit 2265c14 ("batman-adv: gateway election code
refactoring") in v3.1-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a340a51ed801eab7bb454150c226323b865263cc]
stable/5.10: [a3f3f1ec8aad84c5dd386c430b9c61cddd85b18f]
stable/5.15: [e2ec4c712d19141ca7bf7fbbb1d842f73abaa186]
stable/6.1: [9a1a8ed4facfe843bde6fdfcf7af0e9923eb2e17]
stable/6.12: [30bda3ef4b0cac777f1a7c314cd08b8ff6437365]
stable/6.18: [ae7aeb0ce3c0ebbe357ed525779acac197a18086]
stable/6.6: [6de089b545db013433cf934bb4e4433dec2dd65f]
stable/7.0: [17e3a441111cd1a530cd6ee69a22f3161d80d810]

CVE-2026-52927: netfilter: ebtables: fix OOB read in compat_mtw_from_user

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52927

Introduced by commit 81e675c ("netfilter: ebtables: add CONFIG_COMPAT
support") in v2.6.34-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f438d1786d657d57790c5d138d6db3fc9fdac392]
stable/5.10: [d7a8fb6f10d55a1c37b0bf8c20cca24dffd76e00]
stable/5.15: [21af4c030567d2e6c89bb927bc18b51fba52a400]
stable/6.1: [dad9ebf8107955bb54bd3f9cf22591b6ff37bac1]
stable/6.12: [7ad0e463fc7eafae2141cc38054264636f8b3e94]
stable/6.18: [bf8e8eac7ede51dc318e06acef5a896dcbba7595]
stable/6.6: [a27cb7325a6c69970041c7f8541fafed5a1ea3ec]
stable/7.0: [fcc4c043d137e7f1de4673dba1f3116e45377c67]

CVE-2026-52928: af_unix: Reject SIOCATMARK on non-stream sockets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52928

Introduced by commit 314001f ("af_unix: Add OOB support") in v5.15-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d119775f2bad827edc28071c061fdd4a91f889a5]
stable/6.12: [645b1ed3259af38b7814242a420bc2081bdd1eb6]
stable/6.18: [c34c41446acf6c0d13b5b06c809be11e0f7f2729]
stable/6.6: [0d7e7235bc543c6ed7b873e3015db814d8e8c414]
stable/7.0: [3147ddf5a41c20c45c2eb69e00b62f10f822056a]

CVE-2026-52929: sctp: stream: fully roll back denied add-stream state

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52929

Introduced by commit 637784a ("sctp: introduce priority based stream
scheduler") in v4.15-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5f8a90ac9f77c678a9781c0a464b635e0d63e49]
stable/5.10: [0cd2dc6dce8ca47212cd306ccd52eb315ef3cf85]
stable/5.15: [a6724b7b812ac8793514a1d5938db5d9d29ae725]
stable/6.1: [9662eb0401518f0b4681f10e7fbf688f504f24cf]
stable/6.12: [39dc2b0eb5371a669ebc9ec6072b9184eac95418]
stable/6.18: [d5ea0b3e261fcb2cfff142675516165244cab1da]
stable/6.6: [7dd9a42b044aad2dbe037db1c1e2943582485b44]
stable/7.0: [1c6773b8c081509dcd5cd2954f2b02c50c00f151]

CVE-2026-52930: ipc/shm: serialize orphan cleanup with shm_nattch updates

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52930

Introduced by commit 4c677e2 ("shm: optimize locking and ipc_namespace
getting") in v3.1-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e5c6f4fd4001562781e99bbfc7f1f0127187542]
stable/5.10: [b1e9aef48e4d8a0c1b54fb913077b0824ed7d650]
stable/5.15: [92cda2593cf2ed25b0e9d78e5e6d8303bba1a064]
stable/6.1: [1f0d01e35dbb228084d5187212e32c91a30dcbeb]
stable/6.12: [b5107b4ce3ad45fcf369ee2058c8910620f4b5a8]
stable/6.18: [db752ebfdaf2c7f27cd9690ef48b616af068319c]
stable/6.6: [6560be3f6a5bb84f006f184f0c966747bb58e1a3]
stable/7.0: [030bbc857bd51d4b25a90d931d3f8775ef22823a]

CVE-2026-52931: batman-adv: tp_meter: avoid use of uninit sender vars

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52931

Introduced by commit 33a3bb4 ("batman-adv: throughput meter
implementation") in v4.8-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c65cf23d4c6170fcf5714c32aa64689718cb142]
stable/5.10: [0e388af04b3958b178a1b979527f93eb46ea1fee]
stable/5.15: [1a21c055f66e78973712a4a1be2a554f1ee2e4f4]
stable/6.1: [9884c9c02d3c90e9215db3c5128f59045d20ae91]
stable/6.12: [ecdaa3e4d91040206afe21bc8a0d1198a0971ff3]
stable/6.18: [dc2ae5fbd2dadc26735092f140b246841d969a11]
stable/6.6: [53f931e0146ae5bdab4cba302646827d06b3794b]
stable/7.0: [85397e48afe6be83ffca5ad3f4792296bfc81d3d]

CVE-2026-52932: xfrm: ipcomp: Free destination pages on acomp errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52932

Introduced by commit eb2953d ("xfrm: ipcomp: Use crypto_acomp
interface") in v6.15-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dbac7680eb629b3b4dc7e98c34f943b8814c0c8]
stable/6.18: [dc6dcba80d72a27ab61831ad3d253316e0c9b9d5]
stable/7.0: [b30aa173c3809f6af4c83a86099be1be19aa48eb]

CVE-2026-52933: io_uring/poll: fix signed comparison in io_poll_get_ownership()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52933

Introduced by commit a26a35e ("io_uring: make poll refs more robust")
in v6.1-rc7.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [326941b22806cbf2df1fbfe902b7908b368cce42]
stable/6.1: [81bf96b0abbfa4cd47ea32e12596aed3855fb2f3]
stable/6.12: [fc47043f3d9af3efa407665b47f8378ec691ba18]
stable/6.18: [ea0697129807d718037f618221037aa0660ee3c5]
stable/6.6: [cf522703d4f194991615763697ae25a3f9539763]
stable/7.0: [c6d191164dc81838d8dbf452a6000f68c558d1ae]

CVE-2026-52934: batman-adv: tvlv: reject oversized TVLV packets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52934

Introduced by commit ef26157 ("batman-adv: tvlv - basic
infrastructure") in v3.13-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f50487e3566358b2b982b7801945e858c78ad9ab]
stable/5.10: [c02aa6c0c9d1bea9bb75dea362b75ad225137bae]
stable/5.15: [1595628a2f877d052eda18865ccf539392c47c04]
stable/6.1: [6448a49344e87487b61bd88cb850cd694a0f576d]
stable/6.12: [94db72e9dac202e017ee3db22c59d17e4f3bf171]
stable/6.18: [ede47988ac5687793745b17c1634a496a2299919]
stable/6.6: [13493b00dd1e05a705981e052158652ea23eb482]
stable/7.0: [94a3d72cd9b21116d7c6d5bdc57c11401fc28557]

CVE-2026-52935: xfrm: espintcp: do not reuse an in-progress partial send

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52935

Introduced by commit e27cca9 ("xfrm: add espintcp (RFC 8229)") in v5.6-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c381039ade2e161ab08c0eda73c4f8b9a7115928]
stable/5.10: [6564e9c7af7e1dc7bfe7f3093b728abe484d7630]
stable/5.15: [1777ceac4bea5e568a5ad44b7f9bb219c1db21b6]
stable/6.1: [8c6c691bf062dc0753a139a4ab8cb92a70fcf8f3]
stable/6.12: [ba21439302db9a82fe4edbed1e38a97271529421]
stable/6.18: [f9b38a8fbfa07f1deaf7ee1eb38fa8b21ea13990]
stable/6.6: [aa82a078f70f7ff88ba7d1017134e79d1ac140f2]
stable/7.0: [37487d55bf3300e3d2c1368da5c2bd3e3834ea4f]

CVE-2026-52936: crypto: jitterentropy - replace long-held spinlock with mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52936

Introduced by commit bb5530e ("crypto: jitterentropy - add
jitterentropy RNG") in v4.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01d798e9feb30212952d4e992801ba6bd6a82351]
stable/6.12: [4c03e6eb98443dc4d6d422a9780034a5b75376b4]
stable/6.18: [ff734dbd9e2432601a6dcd167cfb0bf8a36d1880]
stable/6.6: [18216b8ab6904753eaf31baf453cb02ecd202ba4]
stable/7.0: [ec427dc5286da1ed08f2d510e2147a7581b0cb02]

CVE-2026-52937: tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52937

Introduced by commit 3b23a32 ("net: fix dev_ifsioc_locked() race
condition") in v5.12-rc1.
Fixed in v7.1-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [bddc09212c24934643bd44fc794748d2bbb3b6cd]
stable/6.18: [719007c3492f0f1f9e9cdbed8ac45ba45bb13eeb]
stable/7.0: [05305e832be7b9d65b2b72caacf7d850b3942b2a]

CVE-2026-52938: bpf: Fix NULL pointer dereference in
bpf_sk_storage_clone and diag paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52938

Introduced by commit 5d800f8 ("bpf: Support lockless unlink when
freeing map or local storage") in v7.0-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [375e4e33c18dfa05c5dfd5f3dfffeb29343dd4c7]

CVE-2026-52939: net/rds: fix NULL deref in rds_ib_send_cqe_handler()
on masked atomic completion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52939

Introduced by commit 20c72bd ("RDS: Implement masked atomic
operations") in v2.6.37-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34080db3e70ddf94c38512ad2331e3c3afca6cc1]
stable/5.10: [a0148342badd8c9b2e46551766a27cb76c82e715]
stable/5.15: [4dd262f875e87653df50b138de1390ab0628e6b7]
stable/6.1: [6e4615164d185a26badb2f376a2449f4d174a5f0]
stable/6.12: [0f7baa82a24813cdad0b06a6f8f07e4824af5ed5]
stable/6.18: [dcf458120add64c96a6ef5cf719340453f6e6abf]
stable/6.6: [0f22412a2f4fbbe0251c132abee045d15a90e5b6]
stable/7.0: [4fd34669558085bcb589aa2078a13b0ca79e360d]

CVE-2026-52940: tun: zero the whole vnet header in tun_put_user()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52940

Introduced by commit 288f304 ("tun: enable gso over UDP tunnel
support.") in v6.17-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f2fcff15e99bb852f6967396ed12b38376e2c8d]
stable/6.18: [5fd1fa5a4254bfdd70571c77f5e3bcb4e43738d5]
stable/7.0: [585cb85e9a29185be05f326369573c2663cf4380]

CVE-2026-52941: net/smc: avoid NULL deref of conn->lnk in
smc_msg_event tracepoint

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52941

Introduced by commit aff3083 ("net/smc: Introduce tracepoints for tx
and rx msg") in v5.16-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7bf563badd37cb796df5477d2b78bb64148a1268]
stable/6.1: [68200112534bb2acd1d7117dc2d5c124868d866d]
stable/6.12: [b706d6d76a2a2793fe5ad0fbc2a75b6a460094ef]
stable/6.18: [d2ea0b8aef8746e147602eac87ca8538f4bc7e66]
stable/6.6: [720c76b930c52cd58f50eb6b10569d03dccc7959]
stable/7.0: [561cf66fa9b6c86dfe4e687d2d1aeaaa6739917f]

CVE-2026-52942: netfilter: nf_log: validate MAC header was set before dumping it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52942

Introduced by commit 7eb9282 ("netfilter: ipt_LOG/ip6t_LOG: add option
to print decoded MAC header") in v2.6.36-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a84b6fedbc97078788be78dbdd7517d143ad1a77]
stable/5.15: [d704ee9c7bc68a161684c51a7ac05b446dcf38d4]
stable/6.1: [befb8968a2abdfa948d5600ea7f7a509a292a590]
stable/6.12: [c38d41134085193efd5b237cf513ad5b3421a60d]
stable/6.18: [af1b7699466f6556b351fa25d3dc870abfb5d310]
stable/6.6: [8a81e336da685423f5b64aac4d571e63d674c52a]
stable/7.0: [65ef7397eb9a296e91839f5fd10be96f23d332e7]

CVE-2026-52943: net: skbuff: fix missing zerocopy reference in
pskb_carve helpers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52943

Introduced by commit 6fa01cc ("skbuff: Add pskb_extract() helper
function") in v4.7-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98d0912e9f841e5529a5b89a972805f34cb1c69d]
stable/5.10: [8dbed691e43a50903658130bde0fcb5abc425b37]
stable/5.15: [9b40bdc2a3298225dffab8158208a0d8c6300578]
stable/6.1: [fd470f0a97b8e9a125f520265d2f3b088ffb5b8a]
stable/6.12: [2e0e74c59b2761a414d9f48d7bee1e45220b2427]
stable/6.18: [96a4713ae041cc85e712bac682cd2e644004d6c6]
stable/6.6: [ceafb893b12f23331dcc5ff9587e643c3a40ee9f]
stable/7.0: [474d6c771d798bca84f0a140b611e36743511e18]

CVE-2026-52944: ksmbd: fix FSCTL permission bypass by adding a
permission check for FSCTL_SET_SPARSE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52944

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc57232cae23c0df91b4a59d0f519141ce9b5b02]
stable/6.18: [de9eb0b44fa9123170e6245b49638e0e453c10f8]
stable/6.6: [3127a884525dc8ca4def73254bfcd3ccef0bf812]
stable/7.0: [aef151bcfa494bfe983669de2726734b534adb73]

CVE-2026-52945: Revert "wireguard: device: enable threaded NAPI"

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52945


This fix revert e7096c1 ("net: WireGuard secure network tunnel").
Fixed by db9ae3b ("wireguard: device: enable threaded NAPI") in
v6.16-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db9ae3b6b43c79b1ba87eea849fd65efa05b4b2e]
stable/6.12: [e94b369ff82f9bc84f090f271bd78f41c9f6ab2f]

CVE-2026-52946: fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52946


Fixed by 00633c4 ("fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync
signaling") in master branch.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00633c4683828acd5256fa8d5163f440d74bbe71]
stable/5.10: [54626335ea4174ab2d9a183b511d825f6765e47b]
stable/6.1: [32dbd5ce4be3a3ed7e00f8af18795cc84fc50a33]
stable/6.12: [1bee417678f1135e35b25a37734db46aa94258d2]
stable/6.18: [20a93e397abe850c49b6fa0e8cc827b5f634a8f5]
stable/6.6: [b5fa9e32fb6718f70c986ee14dd5d01b4846f331]
stable/7.0: [bfcc8e8d8a495bb34cae9e620adfb75fb13a3954]

CVE-2026-52947: net: qrtr: fix refcount saturation and potential UAF
in qrtr_port_remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52947

Introduced by commit bdabad3 ("net: Add Qualcomm IPC router") in v4.7-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2171131ecda1ed61a594a1eb715e75fdad0fef5]
stable/5.10: [2aa4c12723fe432e623462a3be42a197a128722b]
stable/5.15: [03bfa95e452e2b6ccd76a332060ae4feaf5ad84d]
stable/6.1: [474293d90880622fde9d2430fb0165767090f7b3]
stable/6.12: [7de2d447072be3b1a76793f034432338fc9c494b]
stable/6.18: [ab269990ed58143a92a263be1bee626d82ac03da]
stable/6.6: [2047c2aa0963bb2872fd722300a15bcb441a4c00]
stable/7.0: [3b20ec8f31e8a6a6782243f473b0abd3463621df]

CVE-2026-52948: i2c: dev: prevent integer overflow in I2C_TIMEOUT ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52948

Introduced commit is not determined.Fixed in v7.1-rc3.


Fixed status
mainline: [617eb7c0961a8dfcfc811844a6396e406b2923ea]
stable/5.10: [e9ffd5f5050fbb199d270a85614cd27ebed6fbac]
stable/5.15: [0b88ecfbc9dc33b4db8836c37b50cf174e6c0691]
stable/6.1: [943e318eedbeaeea08ece3f5dd44c982f4ed2ef5]
stable/6.12: [ff02add34ffd03449b8115904ebe2ec4fed022d4]
stable/6.18: [ffbcf31f032eb454ebfd29309f51366fe57f4ac4]
stable/6.6: [aa6ef734016912653a909477fb30aeb66c98b3a2]
stable/7.0: [4576621dc6577f21a032acfd16c3ad61907a5ea7]

CVE-2026-52949: drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52949

Introduced by commit 70d645d ("drm/ttm: Add helpers for shrinking") in
v6.15-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d59f36e95f7f7134db0e313c9d787cb0adb2153]
stable/7.0: [9402ad98a047dd9894ec868a7df5ad9bd03327d3]

CVE-2026-52950: drm/xe/dma-buf: fix UAF with retry loop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52950

Introduced by commit eb289a5 ("drm/xe: Convert xe_dma_buf.c for
exhaustive eviction") in v6.18-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [155a372a1cc50fa93387c5d3cdfd614a61e1afd1]
stable/6.18: [39fdac6be02eb7c3460518c1c4085f75f935c4ce]
stable/7.0: [827062952ed9bdf4220466c1f05ce452d04bdedf]

CVE-2026-52951: drm/xe/dma-buf: handle empty bo and UAF races

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52951

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [981bedbbe61364fcc3a3b87ebaf648a66cd07108]
stable/6.12: [9894731e513019df22a29e5c52f1c98890355ff1]
stable/6.18: [20a99ea1e2fd720856d6ba497ff26b82c604751f]
stable/7.0: [c473ae25421fddc3dde247ba7b85225b10641d09]

CVE-2026-52952: iommu: Fix WARN_ON in
__iommu_group_set_domain_nofail() due to reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52952

Introduced by commit c279e83 ("iommu: Introduce
pci_dev_reset_iommu_prepare/done()") in v7.0-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5474e6e17a262db45c60575c73f70210f5c7001f]
stable/7.0: [8fc289e809f3eb7e36cadc4684ab6fad747a5a93]

CVE-2026-52953: iommu/vt-d: Fix oops due to out of scope access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52953

Introduced by commit 7d0c9da ("iommu/vt-d: Add set_dev_pasid callback
for dma domain") in v6.6-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6dea58d8625c06b9654c0555f101742481335c3]
stable/6.18: [88397fad7914ee74a7880fa5ce01f9eb6bfe0743]
stable/7.0: [1e659db468476733d217c1314c1e0d9244356d6c]

CVE-2026-52954: libceph: handle rbtree insertion error in decode_choose_args()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52954

Introduced commit is not determined.Fixed in v7.1-rc4.


Fixed status
mainline: [d289478cfc0bcf81c7914200d6abdcb78bd04ded]
stable/5.10: [c7bf7864e2924fa5508ac270b0e9364bc13d5a6c]
stable/5.15: [f47430fc1f815e87406e2d3b4e476eff1bc7fd9b]
stable/6.1: [0b6a3bcb91bc5bfeda39f0df3b71bab62c13e9da]
stable/6.12: [80c73bd1b2b04355d1d0c29be8ccbd25a380905d]
stable/6.18: [4d2b37abda9536808655830d683dc491d31741a8]
stable/6.6: [534ebc08df97c47d4c7596f336fa31ecbf91519c]
stable/7.0: [0a1265a9ab875f92b6a3ffb497404f46cf9d76a3]

CVE-2026-52955: libceph: Fix potential out-of-bounds access in crush_decode()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52955

Introduced commit is not determined.Fixed in v7.1-rc4.


Fixed status
mainline: [4c79fc2d598694bda845b46229c9d48b65042970]
stable/5.10: [6e70ef53e818c53eab28d7b0026b7fd03dddaba5]
stable/5.15: [ebe76d58a48a48031b98543d86c4cd30a825b622]
stable/6.1: [3f42508191e129ee6b5ea96578d5cab14f2a013a]
stable/6.12: [cceb10023e76bc89f3fe9238ebd0ccab0fc7c7c5]
stable/6.18: [0f3604cbe4df14c5e58288ac9f57511e726a222d]
stable/6.6: [ea0d42137f0c06da71e37ffc647aab4c5309599a]
stable/7.0: [fb176a99e4c1a5a8448a83d83d3606203ba81faa]

CVE-2026-52956: libceph: Fix potential out-of-bounds access in
__ceph_x_decrypt()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52956

Introduced commit is not determined.Fixed in v7.1-rc4.


Fixed status
mainline: [821365487aa58d06bda65c676ba215d506ba9768]
stable/7.0: [c7e9b53aebe401970f1b5f5a01b4e021b18e8bb2]

CVE-2026-52957: libceph: Fix potential null-ptr-deref in decode_choose_args()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52957

Introduced commit is not determined.Fixed in v7.1-rc4.


Fixed status
mainline: [28b0a2ab8c82d0bbdeb8013029c67c978ce6e4bf]
stable/5.10: [d55ffad8d422b5d1cc44dad32bd3d25f4471cd9f]
stable/5.15: [301286c0ccd37d66b0e40786fd35a4f19cdbd88a]
stable/6.1: [7169f326a23d0f547fcd90e68b72fd387622e126]
stable/6.12: [312ec973efac0efb9b9ed64214235910e9ecbaa8]
stable/6.18: [f2f95e6d4b97e70bb876139b0583fc8079983f85]
stable/6.6: [d7a65a34d2453f8cd3e0cc0e1319740af7e24276]
stable/7.0: [a20e16ebfe2fa65348eb4b2dc7deac330ce03e9c]

CVE-2026-52958: libceph: Fix potential out-of-bounds access in osdmap_decode()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52958

Introduced by commit dcbc919 ("libceph: switch osdmap decoding to use
ceph_decode_entity_addr") in v5.3-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35d0ed82d03e5ee77ea4f31f20e29562a7721649]
stable/5.10: [36a79759a288961b1ff28a68ec2d1f56f6848098]
stable/5.15: [3f2575bb7f955d42569d96c3e04fa958a0dcf4b4]
stable/6.1: [8713bbc4b2b9ad78f803978e54b7e49dd21bd9be]
stable/6.12: [e7187f33c02488697ec0d01d82bf7a3f8deaba8f]
stable/6.18: [48df98d12b15360cd56af5c1f460307b340c1197]
stable/6.6: [0d2dd7e6bb74fd7712aa73457a4a821906c6863a]
stable/7.0: [ee933694645dac062d65fc2743f92bc06fa0db6b]

CVE-2026-52959: virt: sev-guest: Do not use host-controlled page order
in cleanup path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52959

Introduced by commit 3e385c0 ("virt: sev-guest: Move SNP Guest Request
data pages handling under snp_cmd_mutex") in v6.14-rc6.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23e6a1ca04ae44806439a5a446e62e4d42e80bb4]
stable/6.18: [3f6fb0211b39aaa1b841260681dd02ca6b693ed5]
stable/7.0: [9e48b4f813d2c3db75d522aa82ab705ce04b7e2d]

CVE-2026-52960: ceph: put folios not suitable for writeback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52960

Introduced commit is not determined.Fixed in v7.1-rc4.


Fixed status
mainline: [544576f0f05c4a759806acddfaaeb686f14fb4b0]
stable/7.0: [86921e890fe1dea9791fb70bec552516fd47716a]

CVE-2026-52961: ceph: fix BUG_ON in __ceph_build_xattrs_blob() due to
stale blob size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52961

Introduced by commit d93231a ("ceph: prevent a client from exceeding
the MDS maximum xattr size") in v6.0-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c22d9511cbde746622f8e4c11aaa63fe76d45f9]
stable/6.12: [7eb72425c4e3234926502eb262f9d6193ccd572c]
stable/6.18: [d5bd8b4e39cfa8b087448adcd48088065cd629d5]
stable/7.0: [368d21ae9081c93497b1c8163bed3eddcb2443ff]

CVE-2026-52962: ceph: fix a buffer leak in __ceph_setxattr()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52962

Introduced commit is not determined.Fixed in v7.1-rc4.


Fixed status
mainline: [5d3cc36b4e77a27ce7b686b7c59c7072bcb3fa8e]
stable/5.10: [521e5aba857fd267624892c8dd6295f22ce0267e]
stable/5.15: [d0cb994605c84a159c1d00d72cdc8583c321ef95]
stable/6.1: [ecf94823c5c6a20790bb76ed2816822b0beb0c22]
stable/6.12: [7d3e8d2d648d5f0df29b4710246680f47695fe94]
stable/6.18: [3fa13ceefbc5f36131110342743994cb3de80637]
stable/6.6: [4bfdcefdaa6092a06cacd59389c7756b36e6de8c]
stable/7.0: [bc7abce4460e490dcb579eec770f175b150b685f]

CVE-2026-52963: ALSA: usb-audio: Bound MIDI endpoint descriptor scans

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52963

Introduced by commit 5c6cd70 ("ALSA: usb-audio: Fix case when USB MIDI
interface has more than one extra endpoint descriptor") in v5.7-rc1.
Fixed in v7.1-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [d6854daa67be623860f4e1873fd3d3c275aba4ed]
stable/5.10: [e2f1260a056eb3215c13c48c5378f3e4112dc3af]
stable/5.15: [c65b137d351e21cbc5630e73ef0eb1e1d75f5b20]
stable/6.1: [728ab0c72e49ca27185067984cd565425eb69b2e]
stable/6.12: [a0226560540c16717efcceaf15c862cf115b01d3]
stable/6.18: [09141583bd97f4bbd7358e29fd138fe798467cdb]
stable/6.6: [3d3b2b01a3e73828e201ece96f863e7a3e0cdc6e]
stable/7.0: [c59159ce10e75b568cd0d4b29efcb0fb0ddecc94]

CVE-2026-52964: ALSA: usb-audio: Bound MIDI 2.0 endpoint descriptor scans

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52964

Introduced by commit ff49d1d ("ALSA: usb-audio: USB MIDI 2.0 UMP
support") in v6.5-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [918be519c7876329e1b6e2ea1c59f0b75e792dca]
stable/6.12: [a310b4bebda5e4a1b26520c0cc5145ccd6d617e2]
stable/6.18: [f9c184a83574549a36ea69b755f650e57d164c78]
stable/6.6: [fafc97bd01e4c737eaeafadfdadb1af4bbfa7307]
stable/7.0: [17e76b19de1aff5ff4de64d269290bd1b07a01d3]

CVE-2026-52965: drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on
swapout failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52965

Introduced by commit fc5d966 ("drm/ttm: Move swapped objects off the
manager's LRU list") in v6.13-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2ed01e7ad3de80333e9b962a44024b094bc0b2b]
stable/7.0: [0124a09e3e5f5f6080efe9663b27af27933f8382]

CVE-2026-52966: drm: Replace old pointer to new idr

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52966

Introduced by commit 5e28b7b ("drm: Set old handle to NULL before
prime swap in change_handle") in v7.1-rc3.
Fixed in v7.1-rc4.

Bug introduced commit was backported to following branches.
stable/6.18 stable/7.0

Fixed status
mainline: [dc366607c41c45fd0ae6f3db090f31dd611b644a]
stable/6.18: [318b995cffcfcaa69a234d28123a3f4ae186a9df]
stable/7.0: [38f12d0e10d83b66fa1466400d876a3a8da31542]

CVE-2026-52967: smb/client: fix possible infinite loop and oob read in
symlink_data()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52967

Introduced by commit 76894f3 ("cifs: improve symlink handling for
smb2+") in v6.1-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d9a7f1f96cd617ee9e75bb22217c709038e26b8]
stable/6.1: [1cfa2d59f669db28d6292d10ff87ca6837c781b0]
stable/6.12: [cd4b9b662f0fb9aa97ee6bf9034eca76fc6cab23]
stable/6.18: [97a05b0ae9ea5ec052be2eef0f9cc7ce03501bbb]
stable/6.6: [b41598bf54b3fe528994e573df6008f8f4d0a4f4]
stable/7.0: [1b9331b16b0ed9414dcf7583d8134bdfeb117aae]

CVE-2026-52968: KVM: s390: pci: fix GAIT table indexing due to
double-scaling pointer arithmetic

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52968

Introduced by commit 3c5a1b6 ("KVM: s390: pci: provide routines for
enabling/disabling interrupt forwarding") in v6.0-rc1.
Introduced by commit 73f91b0 ("KVM: s390: pci: enable host forwarding
of Adapter Event Notifications") in v6.0-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16d990a15491cf76cd6eef0846e1b4100e63261a]
stable/6.1: [31a9d9f9942885aae356a1a57c79e82c5b5b0828]
stable/6.12: [11b8ff5b930b351dd1f6f088dce0beb027ac92d0]
stable/6.18: [b22a2da8792a7bfe743c1a922e77fa499ddedbe8]
stable/6.6: [a99a25db131ece5e6c0f7632da606de631efe4f2]
stable/7.0: [e7216651b94e92e5433fb2f54b77864642b4ea48]

CVE-2026-52969: KVM: Reject wrapped offset in kvm_reset_dirty_gfn()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52969

Introduced by commit fb04a1e ("KVM: X86: Implement ring-based dirty
memory tracking") in v5.11-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [577a8d3bae0531f0e5ccfac919cd8192f920a804]
stable/5.15: [74f1a22f7a80f03d28ad8551a2d25d563433addf]
stable/6.1: [0eb281eb95b2d4eea4db1da5fe91023aecc97095]
stable/6.12: [b315b033a877b1ee6d827810b5d7bb4392ffcf8d]
stable/6.18: [0d419c23bb11b5c9664de777c47c1f04a235882d]
stable/6.6: [01b71b930f15728aa8599478a7ce90c19dcd9fc2]
stable/7.0: [ecf9b3ea7847fe14f34b8c41f00de1eb95c747da]

CVE-2026-52970: netfilter: nft_ct: fix missing expect put in obj eval

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52970

Introduced by commit 857b460 ("netfilter: nft_ct: add ct expectations
support") in v5.3-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19f94b6fee75b3ef7fbc06f3745b9a771a8a19a4]
stable/5.10: [cdb9a25dd3416d427e8b2753210f8baf44207577]
stable/5.15: [26ab32ec73941871c97562ee1f39587950dc3b68]
stable/6.1: [7b96242ceedfe249f158419f3254bcee04173ffe]
stable/6.12: [2aef1b13d5c0285f340512c6c07eb858fd018fd8]
stable/6.18: [1dced0725e2fae3ac3416274db20a7ff5a46931d]
stable/6.6: [ecca618e1e339494911090474ed87742c0f73976]
stable/7.0: [84c422cea5a45fe56be839f25880f21fd33940cd]

CVE-2026-52971: net: ena: PHC: Fix potential use-after-free in get_timestamp

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52971

Introduced by commit e0ea341 ("net: ena: Add PHC support in the ENA
driver") in v6.17-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e42c755582f0960e684298762f0ab927b3778376]
stable/6.18: [95e8ae9af2a61b4e72f5c585bf4c7d8aaf2a2c98]
stable/7.0: [ca9ed40f28949353911dcb524ff8fff2f3409c97]

CVE-2026-52972: crypto: af_alg - Cap AEAD AD length to 0x80000000

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52972


Introduced by 400c40c ("crypto: algif - add AEAD support"). Fixed by
e4c0647 ("crypto: af_alg - Cap AEAD AD length to 0x80000000") in
master branch.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4c06479d7059888adf2f22bc1ebcf053bf691a2]
stable/5.10: [f8a5203596797f394ff3f9aa4005597a92249802]
stable/6.1: [a4fe4eb580bbc7439f649a496d4cf38415a4021c]
stable/6.12: [265ac26d1c5e17b34d497cbda1f754a1ec8552bc]
stable/6.18: [a1c5672faf8e93e38c2deac3979cc767ca5cf918]
stable/6.6: [e4c4a5074532eaaa14951994a3aad0d479aa7431]
stable/7.0: [97948906dc8e0ea84775e03e35b60a2063c70193]

CVE-2026-52973: futex: Drop CLONE_THREAD requirement for private
default hash alloc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52973

Introduced by commit d9b0532 ("futex: Move futex_hash_free() back to
__mmput()") in v6.17-rc5.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee9dce44362b2d8132c32964656ab6dff7dfbc6a]
stable/6.18: [1dcd36420af2da5bd59306dba9caf78e3d248b1d]
stable/7.0: [974ac49a9a068b0591a59f65c63eb06579a13091]

CVE-2026-52974: net: tls: fix strparser anchor skb leak on offload RX
setup failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52974

Introduced by commit 84c61fe ("tls: rx: do not use the standard
strparser") in v6.0-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58689498ca3384851145a754dbb1d8ed1cf9fb54]
stable/6.1: [0c9f399b37ce22a5ed94cc51f03ed07ac7f38e32]
stable/6.12: [3c405dfa9619e506e75b8e41f8b29a5b99731877]
stable/6.18: [9c54e76f8d6eb11735918777ef0e0509e089557d]
stable/6.6: [688f12aa44511dd57e448eb670075c6302ad1dc1]
stable/7.0: [bd07fe6c38b9e44ff3fc02692a53f095c5cc9afc]

CVE-2026-52975: bonding: 3ad: implement proper RCU rules for port->aggregator

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52975

Introduced by commit 47e91f5 ("bonding: use RCU protection for 3ad
xmit path") in v3.13-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4f050ce06c56cfb5993268af4a5cb66ed1cd04e]
stable/6.1: [ba2272be04f0cb1e74e1e355ff32ef95df280731]
stable/6.18: [c169c5837525ad842df6a542facf52b6f866a519]
stable/6.6: [3b7265b3a82f40d2357c4004b26eb794a095b186]
stable/7.0: [78f409fd34fe9de2b24ad8e9dca1b4608a48ed3d]

CVE-2026-52976: drm/xe: Fix error cleanup in xe_exec_queue_create_ioctl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52976

Introduced by commit 7970cb3 ("'drm/xe/hw_engine_group: Register hw
engine group's exec queues") in v6.12-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3cc22d4df3ed58439ea7e21daa54c3608e03b78]
stable/6.12: [f93b00161213a0fe9f7ff1d8498ee5ca9e0a5c43]
stable/6.18: [753b149d5a433eb19e0c1b0eb4526a6e26120d1f]
stable/7.0: [1be55646d8a2035343b012dcb12210db7bb8b056]

CVE-2026-52977: futex: Prevent lockup in requeue-PI during signal/
timeout wakeup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52977

Introduced by commit 07d91ef ("futex: Prevent requeue_pi() lock
nesting issue on RT") in v5.15-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc7304f3ae20972d11db6e0b1b541c63feda5f05]
stable/6.1: [4e0ed44e51727d56244a822ab941efe507c47966]
stable/6.12: [0aacb6d18f76552e3e0ee25d9f40d21b3486f4cf]
stable/6.18: [69a7cfc66405aeaa2483147653d031b3592ffc9c]
stable/6.6: [e3f95b1ba242e37093305812df7fdbe7288a43ac]
stable/7.0: [0304d60abb9dcc02bc7fe6d1850f4ca206e8f1a0]

CVE-2026-52978: net: psp: require admin permission for dev-set and key-rotate

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52978

Introduced by commit 00c94ca ("psp: base PSP device support") in v6.18-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b718342a7fbaa2dff5fefc31988c07af8c6cbc21]
stable/6.18: [aa1a08a4632af5d1117779e7ff0e32e3c69f29bd]
stable/7.0: [fb88a8c86109edb15971481e3de816a8bfdfe571]

CVE-2026-52979: net: psp: check for device unregister when creating assoc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52979

Introduced by commit 6b46ca2 ("net: psp: add socket security
association code") in v6.18-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b89769f936a8fa9e66de72ddc1b71a9745a488e6]
stable/6.18: [d90df5ce6deb2424de3ad89bcc693ac1b67accc9]
stable/7.0: [e201c57073e624dd2ba5beaf9eda31e19b77b332]

CVE-2026-52980: sched/fair: Clear rel_deadline when initializing forked entities

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52980

Introduced by commit 82e9d04 ("sched/fair: Avoid re-setting virtual
deadline on 'migrations'") in v6.12-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3da56dc063cd77b9c0b40add930767fab4e389f3]
stable/6.12: [c71bf35caba12bfd9bc23e32b0bcd9e02d1cf1ac]
stable/6.18: [f3c16e1f4a314a20717ab90a41885f8111a242ab]
stable/7.0: [8f4a16200785f49cf02c5b71bdfe7a9dab63f23a]

CVE-2026-52981: neigh: let neigh_xmit take skb ownership

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52981

Introduced by commit 4fd3d7d ("neigh: Add helper function neigh_xmit")
in v4.1-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4438113be604ee67a7bf4f81da6e1cca41332ce4]
stable/6.1: [8a89054a1ec0767aec25ed2bbac933da6ba3cf5a]
stable/6.12: [0084712e0bee204b284510cdb63182fd5a30c2b7]
stable/6.18: [63063ba60d2dc334e34f1e3f9271d7f3f6f30307]
stable/6.6: [9247d59ca15bf60a57dca08103f055d8a4340877]
stable/7.0: [445e45a2c3a078316a62d2d331a570cf34ef5079]

CVE-2026-52982: net: usb: rtl8150: fix use-after-free in rtl8150_start_xmit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52982

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23f0e34c64acba15cad4d23e50f41f533da195fa]
stable/5.10: [5af290c86fa81ddbc86a08d54229af5daa40c6a4]
stable/5.15: [24831b0b2ada9fef18d1f486b7b7c444ee5ba637]
stable/6.1: [423b5b86e14e190f6e3161eb5f2ea5f908295ba7]
stable/6.12: [30cf9829d09ca958279c937af8e35495cd2f1e09]
stable/6.18: [6999d70e0eda39af029fa1891c48f0a8832b09d5]
stable/6.6: [5db090ca07b28a63fb1499690cf19a3f3adafacb]
stable/7.0: [4dd7eb94f79486b77ca6b4c8676aedbc465dc802]

CVE-2026-52983: net: airoha: fix BQL imbalance in TX path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52983

Introduced by commit 1d30417 ("net: airoha: Implement BQL support") in
v6.13-rc1.
Introduced by commit c9f9477 ("net: airoha: Reset BQL stopping the
netdevice") in v6.13-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d9f5a118205da2683ffcec78b9347f1f01a820e]
stable/6.18: [aaad53a55812acd2355c0e5478896381e78b0110]
stable/7.0: [ded2694247a55a16d0ebbe2d6f9139305c21457a]

CVE-2026-52984: net/sched: netem: fix queue limit check to include
reordered packets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52984

Introduced by commit f8d4bc4 ("net/sched: netem: account for backlog
updates from child qdisc") in v6.13-rc3.
Fixed in v7.1-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [4185701fcce6b426b6c3630b25330dddd9c47b0d]
stable/5.10: [0f875d52db4c921da610e481b72f03cc82fdcb72]
stable/5.15: [ef9a41b3870fb90577da5b2de5bd140022d4021e]
stable/6.1: [74fcd8e127200a50ee22ba2b45c164722bdb9177]
stable/6.12: [54b5dbacd00dedffd5e2eed76de1c3839996b5e6]
stable/6.18: [8450462eaf91d5d2a9e863507b16d18e814baef3]
stable/6.6: [39a66e83ea41fe845631eeb8d326953de27d13f9]
stable/7.0: [936a7dd87251f6f3e88983350833edf60fe6a80b]

CVE-2026-52985: netdevsim: zero initialize struct iphdr in dummy sk_buff

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52985

Introduced by commit da58f90 ("netdevsim: Add devlink-trap support")
in v5.4-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35eaa6d8d6c2ee65e96f507add856e0eacf24591]
stable/5.10: [175556c049eaec14efde8c6475e763b7579b9de7]
stable/5.15: [6e2cfd0904976e701d7a76b86b694e72af230ab0]
stable/6.1: [1b7b6ae0e93b8d512e208b1378d74af052e4f4e7]
stable/6.12: [978ca6ff789f1f19c03288ac20cc1f4774e88490]
stable/6.18: [750d0091bebf44975421268d37484ef87060d263]
stable/6.6: [818f7673ed7f4a29d4b9cee8184c47d6e57162b4]
stable/7.0: [bc6002865e8c4fcf9e94975f7cf023448d8764e2]

CVE-2026-52986: netfilter: nf_conntrack_sip: don't use simple_strtoul

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52986

Introduced by commit 05e3ced ("[NETFILTER]: nf_conntrack_sip:
introduce SIP-URI parsing helper") in v2.6.26-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8cf6809cddcbe301aedfc6b51bcd4944d45795f6]
stable/5.10: [8cd0358379570003659186706e077929d6930c40]
stable/5.15: [9c6afcb1c3cbb2c0da65b8515ac14d7273872f84]
stable/6.1: [b3264c977e79d8a25778d4fd11520f00fea1329c]
stable/6.12: [9f69c323ae0ab517e595c2cc74e0ae0d9d085611]
stable/6.18: [7df9863bf538a626e8a684e59cb2c43eac0ef3c8]
stable/6.6: [ea2ecd29b8f4433e52607192ca91084f95787ca0]
stable/7.0: [523762e3b6933fff81f01dfa3c60c0774044cdab]

CVE-2026-52987: drm/amdgpu: avoid double drm_exec_fini() in userq validate

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52987

Introduced by commit 42f1487 ("drm/amdgpu/userqueue: validate userptrs
for userqueues") in v6.19-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [508babf310365f1107a2e8831c267c292a286818]
stable/7.0: [c7c3ae7c01e5a0742b93cb9b40800bdd7f811e38]

CVE-2026-52988: netfilter: nf_tables: join hook list via
splice_list_rcu() in commit phase

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52988

Introduced by commit 78d9f48 ("netfilter: nf_tables: add devices to
existing flowtable") in v5.8-rc1.
Introduced by commit b9703ed ("netfilter: nf_tables: support for
adding new devices to an existing netdev chain") in v6.4-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6134e62dba2ea4f760b29d5226907f447c92400]
stable/7.0: [1346be9379639c30877083b12747d4eacb83c24f]

CVE-2026-52989: nvmet-tcp: propagate nvmet_tcp_build_pdu_iovec()
errors to its callers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52989

Introduced by commit 52a0a98 ("nvmet-tcp: add bounds checks in
nvmet_tcp_build_pdu_iovec") in v6.19.
Fixed in v7.1-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [ea8e356acb165cb1fd75537a52e1f66e5e76c538]
stable/6.1: [3df42a854686fa06484e37ac1a3931c8e3e3453c]
stable/6.12: [f9204a2b78dd18374d3bcf9bf93d9021ce22de1b]
stable/6.18: [c2a11441538bdbbc5aa003f190995eba93a89b88]
stable/6.6: [d7c8f95f599b3b38a717d2e771c3f8c174f657c3]
stable/7.0: [046fa5c72d15cd8e2d592e275697ea399d8f76b0]

CVE-2026-52990: fsnotify: fix inode reference leak in fsnotify_recalc_mask()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52990

Introduced by commit c3638b5 ("fsnotify: allow adding an inode mark
without pinning inode") in v5.19-rc1.
Fixed in v7.1-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [4aca914ac152f5d055ddcb36704d1e539ac08977]
stable/6.12: [8c8afa6444e6bdc145d2bf2f3aeeca6da3e36b42]
stable/6.18: [b740cc86816bbc87902ae9db74cd21abde3c8d63]
stable/7.0: [5c80289503da3658e3df80280598c68d181eadbd]

CVE-2026-52991: sched/psi: fix race between file release and pressure write

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52991

Introduced by commit 0e94682 ("psi: introduce psi monitor") in v5.2-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5b98009f16d8a5fb4a8ff9a193f5735515c38fa]
stable/6.18: [03dc070fa0fc3cb4068693f468ccd5f8a7e58282]
stable/7.0: [d4352c0709bfd38c752fccbde7fd72a82ac78f23]

CVE-2026-52992: fs/adfs: validate nzones in adfs_validate_bblk()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52992

Introduced by commit f6f14a0 ("fs/adfs: map: move map-specific sb
initialisation to map.c") in v5.6-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd9d3e16c2d5fa166e13dce07413be51f42c8f5d]
stable/5.10: [33aafd2418a59c96c0389d47ea09026661fa9ec6]
stable/5.15: [1f0ed0f57f0fc87e46fe19a05435c214dc464be2]
stable/6.1: [6ff8cca5cdb4f2e0ea6d28ecd78479dd3f221ebc]
stable/6.12: [1586bd2d2fb436a26df20a70e78b000d34a7d159]
stable/6.18: [a3fd5dc1c7b0aae947a67dc2e2c037d57557a4de]
stable/6.6: [a11372a8b1ceaa5e950a84b3b5fbf8228f25e277]
stable/7.0: [60d82592ac8b5637fbed871381eb0a16df0a492e]

CVE-2026-52993: tipc: fix double-free in tipc_buf_append()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52993

Introduced by commit d618d09 ("tipc: enforce valid ratio between skb
truesize and contents") in v4.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d293ca716e7d5dffdaecaf6b9b2f857a33dc3d3a]
stable/5.10: [a438975a6dcdbd70865978c021650d1485586f0b]
stable/5.15: [4ee4deadaae7cb2e3d53af0fc889cf92a73413c0]
stable/6.1: [d3556656c6daebf8def751c7e71d11dd0a180d24]
stable/6.12: [4d104882bc815d4ec666ace9155f5f52715879a6]
stable/6.18: [1d5e589055880fae229e229e1929e087dbe08cf3]
stable/6.6: [0274f24485fc38032d4093e463dc3ff5c7a667c9]
stable/7.0: [29940fff14110ca48c5ccc168d121665b51bb778]

CVE-2026-52994: vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52994

Introduced by commit 581512a ("vsock/virtio: MSG_ZEROCOPY flag
support") in v6.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1cb36e252211506f51095fe7ced8286cc77b4c80]
stable/6.18: [6af1736b5810bc8a4a43a8518530113f5a757dc1]
stable/7.0: [d0117950075f0a9d5944980784c719d8ebcd4bff]

CVE-2026-52995: net/rds: zero per-item info buffer before handing it to visitors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52995

Introduced by commit ec16227 ("RDS/IB: Infiniband transport") in v2.6.30-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c88eb7e8d8397a8c1db59c425332c5a30b2a1682]
stable/5.10: [81651e9d7dea1c048d2952f57632a042931d7b43]
stable/5.15: [0797b2e6901827694aa9c34c4c72118c8c97fba1]
stable/6.1: [5e67cc262afb384e835c3327e9d954eeaedc6a87]
stable/6.12: [c7cb9eed8215a790f052f49cdccf577720d2bb62]
stable/6.18: [91ce1bb6e4194dc2321748f68145359dcf86e350]
stable/6.6: [b6ba93a7b71ed443c9843eb12d27ed86f1e52694]
stable/7.0: [912ba2e5704fdb8bc5decda96dfc1a57838f0099]

CVE-2026-52996: ksmbd: fix durable fd leak on ClientGUID mismatch in
durable v2 open

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52996

Introduced by commit c8efcc7 ("ksmbd: add support for durable handles
v1/v2") in v6.9-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [804054d19886ac6628883d82410f6ee42a818664]
stable/6.12: [f31beef633fbf2b5af7805fa187a10bcff1d4b49]
stable/6.18: [06f709d0e531f3e54d88665dd426be3998a774e6]
stable/6.6: [407b6e699ba8b45b72cc265eed8a1bc8a7191609]
stable/7.0: [8c4a0ef19c8264c150833131af34541495832cd0]

CVE-2026-52997: net/sched: sch_dualpi2: drain both C-queue and L-queue
in dualpi2_change()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52997

Introduced by commit 320d031 ("sched: Struct definition and parsing of
dualpi2 qdisc") in v6.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [478ed6b7d2577439c610f91fa8759a4c878a4264]
stable/6.18: [86cf2eba2056bcf9c41fba260e599bd95bf9943b]
stable/7.0: [3042add80c2c50bd127d570b83319af612efde65]

CVE-2026-52998: netfilter: nfnetlink_osf: fix potential NULL
dereference in ttl check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52998

Introduced by commit 11eeef4 ("netfilter: passive OS fingerprint
xtables match") in v2.6.31-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [711987ba281fd806322a7cd244e98e2a81903114]
stable/5.10: [f4de0777e4554a7de19c920accde6319dd530782]
stable/5.15: [c996a90f3071cf43683e5423da31aadbe002b8b4]
stable/6.1: [edc806f9122961f0d3819f7c69c14cccde31f277]
stable/6.12: [95be653a76793856ff8b2d8bd82c2943c23f5ca8]
stable/6.18: [79b90a96688e521771fa6ed3dc7864b76b8df293]
stable/6.6: [5d05de2f0928d81309a815ecc76d1a3ad72cbc16]
stable/7.0: [83fc5dd63455a779ea2dd0f7ffee3c920919d80b]

CVE-2026-52999: netfilter: nfnetlink_osf: fix out-of-bounds read on
option matching

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52999

Introduced by commit 1a6a095 ("netfilter: nfnetlink_osf: add missing
fmatch check") in v5.0-rc5.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [f5ca450087c3baf3651055e7a6de92600f827af3]
stable/5.10: [0145548346c4a30981a870a8ca00eac46ba27e85]
stable/5.15: [1c136f2c44a5913646bac85303612fd0825197a0]
stable/6.1: [1e19a07291bb8682c14c39a64725a3ae54ab8ccc]
stable/6.12: [70a3f31d25cf2ec9d4ddfa408120171ead955623]
stable/6.18: [21883587593d7c8bb519a79460a0b5bc5ffbdabd]
stable/6.6: [32e50f92c7cf3f4eba29622179a5fcdc2aebab41]
stable/7.0: [edb78a142d2e5948e63647c0646aa7e7886935f0]

CVE-2026-53000: netfilter: nat: use kfree_rcu to release ops

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53000

Introduced by commit e2cf17d ("netfilter: add new hook nfnl
subsystem") in v5.14-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6eda0d771f94267f73f57c94630aa47e90957915]
stable/6.18: [32fdd2e38e7435a368d88f5977a7d6585ebc8b0e]
stable/7.0: [3c7511f38ab511b791196b13ae48bf4973bf7dfd]

CVE-2026-53001: netfilter: xtables: restrict several matches to inet family

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53001

Introduced by commit ab4f21e ("netfilter: xtables: use NFPROTO_UNSPEC
in more extensions") in v2.6.28-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6fe26f86a1649f84e057f3f15605b08eda15497]
stable/5.10: [14203f9edf944b3fb63faadd62f38452421ecdfc]
stable/5.15: [7eaf9c740f33230cb224dc265f3c69f8531ff57b]
stable/6.1: [9a109751b297b0f2135495749ef5a18ba31ec7d4]
stable/6.12: [689a91ff18d6448d94c1ab7c076fecdb2b668bef]
stable/6.18: [76160e04440c9698b989dbd9492a7ec4f520c9ee]
stable/6.6: [cbeb259f31382de70a70a59ffd0e66f5e80d9818]
stable/7.0: [fa88161ef56e29bdaa05cc89dbc4ee221e94bfe9]

CVE-2026-53002: netfilter: conntrack: remove sprintf usage

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53002

Introduced by commit 9fafcd7 ("[NETFILTER]: nf_conntrack/nf_nat: add
SIP helper port") in v2.6.20.16.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e7066bdb481a87fe88c4fa563e348c03b2d373d]
stable/5.10: [2f793ba78470a99f40389b7dc60a81d9f5ad3956]
stable/5.15: [6bbf829b4c1b44c941c47dd0d710f1393258f3d5]
stable/6.1: [ab64e61c9323fa6de21bd20da1ddb29a0fb65d34]
stable/6.12: [a8e0a32a23d3f34862af3b4da792ecb3a891a9a3]
stable/6.18: [8e3be0d12615a173fe260cd42753ca7a001acbf2]
stable/6.6: [1c9fb8aeed06790d42cdcd00f6c3ce0b9e926c1e]
stable/7.0: [c08ff52e44945e6ef4ce0790f49ea761b060c45b]

CVE-2026-53003: pppoe: drop PFC frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53003

Introduced by commit 7fb1b8c ("ppp: Move PFC decompression to PPP
generic layer") in v5.0-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc1ff87bce1ccd38410ab10960f576dcd17db679]
stable/5.10: [cb3beef35ab5e0c1afca9fd7648c6ae499786377]
stable/5.15: [ba758fdf1399f310b30098b6faa3fd043de47dd2]
stable/6.1: [fcca1df05322bb04e344dd1178b54b76a08eb7c3]
stable/6.12: [49e41b60ccd1bdbe9e218420f716dd5f9a2f9c71]
stable/6.18: [0cab5d077dd1efd2bd1a47271acc35894f945b4f]
stable/6.6: [8a5e840babc5c0fbd10c73728a13192347771ec6]
stable/7.0: [2b5c3c040d020e3ab3b9a8887031202d96843b1e]

CVE-2026-53004: sctp: fix OOB write to userspace in
sctp_getsockopt_peer_auth_chunks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53004

Introduced by commit 65b07e5 ("[SCTP]: API updates to suport SCTP-AUTH
extensions.") in v2.6.24-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0cf004ffb61cd32d140531c3a84afe975f9fc7ea]
stable/5.10: [a132e199de69e2a45628aa8534df1bf5d44e1b6e]
stable/5.15: [2b5a2c957c7769d40110f725cf23987fcef50d75]
stable/6.1: [d45c7e99caf915b0f6c716bd8ffe9d45b9685761]
stable/6.12: [6849b995cda88a677bf08a05765d1db7905974fc]
stable/6.18: [70a089cc9590aa347a61e84434116ab74619e3c3]
stable/6.6: [d67fbc6dea5dbf7f46c618ebf65910a276078e20]
stable/7.0: [6bcf8fe4ef7967b22b814cbae9a57bbd3c853410]

CVE-2026-53005: af_unix: Drop all SCM attributes for SOCKMAP.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53005

Introduced by commit c638291 ("af_unix: Implement
->psock_update_sk_prot()") in v5.15-rc1.
Introduced by commit 77462de ("af_unix: Add read_sock for stream
socket types") in v5.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [965dc93481d1b80d341bdd16c27b16fe197175ee]
stable/7.0: [b34a1d83c74a124c968b5adb25c809db3e2eb86a]

CVE-2026-53006: ipv6: fix possible UAF in icmpv6_rcv()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53006

Introduced by commit 4b3418f ("ipv6: icmp: include addresses in debug
messages") in v4.4-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f996edd7615e686ada141b7f3395025729ff8ccb]
stable/5.10: [7bff2c8fe5c35ae58bf73104f53db3676e6e5d94]
stable/5.15: [aff0f28f5be803de2452ce702631c021fcd9ce8a]
stable/6.1: [38bdbc897c0d83a3e2b925a51b69420f1feba29a]
stable/6.12: [1e1f0f89ee4692a64be3f3707ff8ac1ae57b03e7]
stable/6.18: [7c66b368c6ff453f99cb39d84af93e908e51eef2]
stable/6.6: [0069813e6ca9309eca78022bcb3aeb1e9ef90a12]
stable/7.0: [085e31a811ef234ef8c3e219c4636dfebfe7e10f]

CVE-2026-53007: ice: fix potential NULL pointer deref in error path of
ice_set_ringparam()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53007

Introduced by commit ccde82e ("ice: add E830 Earliest TxTime First
Offload support") in v6.18-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa28351f970fa5138c7c5dedfe5dea480a0ee065]
stable/7.0: [c54e3c270384829336b2526033d44ce1aa6dc67c]

CVE-2026-53008: ice: fix race condition in TX timestamp ring cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53008

Introduced by commit ccde82e ("ice: add E830 Earliest TxTime First
Offload support") in v6.18-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c72ec18c2a4111204c2e915f8e4f6d849ce9398]
stable/7.0: [097409d20465723283632515df73038a4a853eda]

CVE-2026-53009: ice: fix double-free of tx_buf skb

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53009

Introduced by commit d76a60b ("ice: Add support for VLANs and
offloads") in v4.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a303baa715e6b78d6a406aaf335f87ff35acfcd]
stable/6.12: [fd95ef8d0f6dbe2daa95d6488c9e0f8a95a7e048]
stable/6.18: [7cb19ec8ac087f33bee60f5d6054b284a5b9bb6f]
stable/6.6: [ca6f9d9aee5408c47e6c0fac10955cb6825ecd96]
stable/7.0: [4c08fc2119ef0281cfa2cee007acf0a251be55f2]

CVE-2026-53010: ksmbd: fix use-after-free in smb2_open during durable reconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53010

Introduced by commit c8efcc7 ("ksmbd: add support for durable handles
v1/v2") in v6.9-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [1baff47b81f94f9231c91236aa511420d0e266b9]
stable/6.18: [ce2e164c1c51c3f7813b80f8c926836e896bcbb3]
stable/7.0: [97a0cd55283b4e63fd92804da91c8d9896adcad9]

CVE-2026-53011: net/sched: taprio: fix use-after-free in
advance_sched() on schedule switch

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53011

Introduced by commit a3d43c0 ("taprio: Add support adding an admin
schedule") in v5.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [105425b1969c5affe532713cfac1c0b320d7ac2b]
stable/5.10: [a8fc396519ef4f081bc545e88f61241728bb78d7]
stable/5.15: [3471874578160a28c171a607fa069f24062634b8]
stable/6.1: [7256996e1ef553716817f3bfd077c2f3b48b582f]
stable/6.12: [1bd286fa3e21200133478ed523cc6a2788baf38a]
stable/6.18: [b73235da5dde77ed1264f9767b62c28c9d71fd78]
stable/6.6: [eee072fe16c646190d33ae69c9983d8de1562bf8]
stable/7.0: [0e62171df8ed4804d00db088f17eed06468233fa]

CVE-2026-53012: nexthop: fix IPv6 route referencing IPv4 nexthop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53012

Introduced by commit 7bf4796 ("nexthops: add support for replace") in v5.3-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29c95185ba32b621fbc3800fb86e7dc3edf5c2be]
stable/5.10: [ceffe81a0be92afc0cd1340bc8ca46559cce9bb4]
stable/5.15: [9c2d6770a5f4545a307eb66979bef7656a34d621]
stable/6.1: [6275796f22bb382f3e9aa58ed0b4ef7bdad78cb8]
stable/6.12: [ad85961004fd4bd2f31209ac4b07612c6cefb9e7]
stable/6.18: [613c8f4a501421dd258b07ea614205d4e16ec845]
stable/6.6: [aaac3bed034239e1d75732211d9b05f30b0b4f35]
stable/7.0: [b3b7e850e1541f0520c4a12ec884255c30427ff6]

CVE-2026-53013: macvlan: fix macvlan_get_size() not reserving space
for IFLA_MACVLAN_BC_CUTOFF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53013

Introduced by commit 954d1fa ("macvlan: Add netlink attribute for
broadcast cutoff") in v6.4-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa92a77b0ed4d5f11a71665a232ac5a54a4b055d]
stable/6.12: [77ecfa4e27f282d224215895ddfbeb916fc75e24]
stable/6.18: [b6b7154e9f5d75b608ceb2d05b376de8c638c40e]
stable/6.6: [4979252758387b338ca968ba7e0515b0ae2257e3]
stable/7.0: [1c004f14ccdc11585625c168bb9a7c5e1b8afb0c]

CVE-2026-53014: net/sched: act_mirred: fix wrong device for
mac_header_xmit check in tcf_blockcast_redir

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53014

Introduced by commit 42f3903 ("net/sched: act_mirred: Allow mirred to
block") in v6.8-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4510d140524ca7d6e772db962e013f26f09a63b1]
stable/6.12: [8fda5174286119addd28473fb2ec5bdf521c05a8]
stable/6.18: [7db3e4e03032261b1b519341123fc30d995478ca]
stable/7.0: [4764953c4b47585eb72797b216b63a831dc0c7e6]

CVE-2026-53015: erofs: unify lcn as u64 for 32-bit platforms

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53015

Introduced by commit 152a333 ("staging: erofs: add compacted
compression indexes support") in v5.3-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d8c7edcb661812249469f4a5b62e9339118846f]
stable/6.12: [4fc9b12e43a3f19a01a8fb61f7961be79de20253]
stable/6.18: [858e4d98a86adf34584767388deb6c9b217f70c5]
stable/7.0: [582b0bf201157632cb5474c885989a6ebda46521]

CVE-2026-53016: crypto: ccp - copy IV using skcipher ivsize

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53016

Introduced by commit 2b78943 ("crypto: ccp - CCP AES crypto API
support") in v3.14-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7a1f3cdd64d8a165d9b8c9e9ad7fb46ac19dfc4]
stable/5.10: [939061b2d0f7f15114e34b4ce878ef50ff4089c3]
stable/5.15: [798d409a8949f3f495f238549b86de2886b129bd]
stable/6.1: [dfb2cf434829819268fe50f41542aad318ad62b2]
stable/6.12: [bb01d8f1f385bc9034ca114d3508c7fdea24fc9a]
stable/6.18: [df9784bb5b637ac80f4a2768a58ca9a50bef28a9]
stable/6.6: [eecee15e263ccb8cd77170a56ab6c969cb54dd6a]
stable/7.0: [227c1e1d9e2aa4cfc65ba446d5690da1f546cda4]

CVE-2026-53017: f2fs: fix data loss caused by incorrect use of nat_entry flag

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53017

Introduced by commit e05df3b ("f2fs: add node operations") in v3.8-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [238e14eb7226f883b72caccd2d37bf5707df066b]
stable/7.0: [20cedb4d9f6b230d0ee469690b8f868f06a07c29]

CVE-2026-53018: f2fs: avoid reading already updated pages during GC

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53018

Introduced by commit 6aa58d8 ("f2fs: readahead encrypted block during
GC") in v4.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [570e2ccc7cb35fe720106964e65060602d3d2ac4]
stable/6.18: [4623c251496b99c530ce225c05334f4eac8b933a]
stable/7.0: [b663ebb8a340eae5442e605b6acd2cff5677f016]

CVE-2026-53019: clk: spacemit: ccu_mix: fix inverted condition in
ccu_mix_trigger_fc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53019

Introduced by commit 1b72c59 ("clk: spacemit: Add clock support for
SpacemiT K1 SoC") in v6.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [54e97360b44bed6b4399dd3be3d65f392df940fa]
stable/6.18: [da99d0302d3ccccfb13c69e663bf8eae698b9562]
stable/7.0: [16dfbc4e95c46dd9c79cb8d550c7f267d4a79b91]

CVE-2026-53020: um: Fix potential race condition in TLB sync

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53020

Introduced by commit 1e4ee51 ("um: Add initial SMP support") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [102331b66bcaf1f41f50b9c4cd5c36e46bafa9f3]
stable/7.0: [f21c343ec7419377bff89ab11146c03ae117036f]

CVE-2026-53021: scsi: target: core: Fix integer overflow in UNMAP bounds check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53021

Introduced by commit 86d7182 ("target: Add sbc_execute_unmap()
helper") in v3.10-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2bf2d65f76697820dbc4227d13866293576dd90a]
stable/5.10: [c08ab702c4699c6efb9d60bdb15b73e7a627ee7e]
stable/5.15: [2e1ed9a7b6ea5bfefb5d80a02b1c71c7dee1f0dd]
stable/6.1: [5efc3ef4758f8d98c257419fa21daca3227de61a]
stable/6.12: [3facdecc3fcf115cc4f9b3d8f118d6705e2456a8]
stable/6.18: [51075df70c46e60a9773f2dcd28299e40dac36fb]
stable/6.6: [d7aef29573c7c5cdb2dfad939253287a6329c2a4]
stable/7.0: [02115986d027ade793e7f6be87e91d6a796d0aa3]

CVE-2026-53022: platform/x86: dell-wmi-sysman: bound enumeration
string aggregation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53022

Introduced by commit e8a60aa ("platform/x86: Introduce support for
Systems Management Driver over WMI for Dell Systems") in v5.11-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c34471c26abc52a37f5ad90949e2e4b8027eb14]
stable/5.15: [7b3dc1f764bf24eb99474a5de8173b0b43a8b071]
stable/6.1: [75c738d4f27fa18a2a033de153bd40302bde6a66]
stable/6.12: [5a04f9a36930792f6d64e28d43609e158d09b665]
stable/6.18: [c5683ca4949a514fbe656c6d0d08c4c126e21db9]
stable/6.6: [ba0843c1955864401295f7ba3b420afe19f2266d]
stable/7.0: [90b118d264845f7aaf539ac49f7c75f1f29590e2]

CVE-2026-53023: fs/ntfs3: terminate the cached volume label after
UTF-8 conversion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53023

Introduced by commit 82cae26 ("fs/ntfs3: Add initialization of super
block") in v5.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6cd43fe9b083fa23fe1595666d5738856cb261a]
stable/5.15: [32b0686369e0afbb3549a0d93e2d8517da84cd30]
stable/6.1: [bc7a0c34c4ca259cfddf3bc18fc5b3c6411d26ed]
stable/6.12: [54d564b762389679e2f8fb9eeb20af7e82371e1c]
stable/6.18: [6136bbb054f7ab9f51ae99915541633b18bcef90]
stable/6.6: [0b11fcbe80a59acdf58337d80ebb5f72201d73d6]
stable/7.0: [5cd0707b81cb4589f00aec5c4c1288bd0980d2a4]

CVE-2026-53024: greybus: raw: fix use-after-free if write is called
after disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53024

Introduced by commit e806c7f ("greybus: raw: add raw greybus kernel
driver") in v4.9-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84265cbd96b97058ef67e3f8be3933667a000835]
stable/7.0: [48d6c32bc049abd114e8f0836c0e7d7cbfba7827]

CVE-2026-53025: greybus: raw: fix use-after-free on cdev close

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53025

Introduced by commit e806c7f ("greybus: raw: add raw greybus kernel
driver") in v4.9-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [983cc2c7efbce04ecbf6328448d895044dd6ab31]
stable/7.0: [ef2d97c15b19b3489de01695bce478601e236c3e]

CVE-2026-53026: NFSD: fix nfs4_file access extra count in
nfsd4_add_rdaccess_to_wrdeleg

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53026

Introduced by commit 8072e34 ("nfsd: fix nfsd_file reference leak in
nfsd4_add_rdaccess_to_wrdeleg()") in v6.19-rc4.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [b48f44f36e6607b2f818560f19deb86b4a9c717b]
stable/6.18: [4584229395d0d65bd517780afe97ffea07cb2c3d]
stable/7.0: [b81572b073441dfd32213e41857676d0dbff4665]

CVE-2026-53027: fs/ntfs3: fix missing run load for vcn0 in
attr_data_get_block_locked()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53027

Introduced by commit c380b52 ("fs/ntfs3: Change new sparse cluster
processing") in v6.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [d7ea8495fd307b58f8867acd81a1b40075b1d3ba]
stable/7.0: [2b4ae1ce613ade8a7e118fba4a5a77cd23e97e54]

CVE-2026-53028: usb: typec: Fix error pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53028

Introduced by commit 82432bb ("usb: typec: tipd: Handle mode
transitions for CD321x") in v6.18-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2529d08fcb429ea01bb87c326342f41483f8b2f]
stable/6.18: [19951118fb22b5ad512379ee64510fe0e2c40eb3]
stable/7.0: [9e31082f92c913d74fefb4e60cd0284e605ba3a3]

CVE-2026-53029: fs/ntfs3: prevent uninitialized lcn caused by zero len

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53029

Introduced by commit 10d7c95 ("fs/ntfs3: add delayed-allocation
(delalloc) support") in v7.0-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e98266e823a1fa06fe6499df61aeaac2fd6f7a49]
stable/7.0: [485f750cac3d8bdf5552a0e3d79ce5e3a03ece49]

CVE-2026-53030: i3c: master: renesas: Fix memory leak in renesas_i3c_i3c_xfers()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53030

Introduced by commit d028219 ("i3c: master: Add basic driver for the
Renesas I3C controller") in v6.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12

Fixed status
mainline: [d7665c3b4f575251e449e2656879392346ca612b]
stable/6.18: [1b6a7e94be678d34a9ccb9db7e2443ae02ad2bc8]
stable/7.0: [ab8f00ffcca0f618fb8198d358f24728950d9860]

CVE-2026-53031: bpf: Validate node_id in arena_alloc_pages()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53031

Introduced by commit 3174603 ("bpf: Introduce bpf_arena.") in v6.9-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2845989f2ebaf7848e4eccf9a779daf3156ea0a5]
stable/6.12: [31d3b4b28e55835646d6829d60023f730dd34e85]
stable/6.18: [e15900888c09480a4c632bc598f1c5bd39bed6d6]
stable/7.0: [fb66e20130f95a93ffea1677252526a9e39170b2]

CVE-2026-53032: bpf: Fix NULL deref in map_kptr_match_type for scalar regs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53032

Introduced by commit ab6c637 ("bpf: Fix a bpf_kptr_xchg() issue with
local kptr") in v6.6-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d0a375887ab4d49e4da1ff10f9606cab8f7c3ad]
stable/6.12: [0a36c1f72888bca0237295a4da19cd91821a90be]
stable/6.18: [6982653ce5f119982aa58f1af58e7bfbebf39252]
stable/6.6: [520454e839710c327808c2fcc98e28cee77355fc]
stable/7.0: [da1d615ce49a47986a8864e2371a26e97861085c]

CVE-2026-53033: bpf, sockmap: Take state lock for af_unix iter

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53033

Introduced by commit 2c860a4 ("bpf: af_unix: Implement BPF iterator
for UNIX domain socket.") in v5.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64c2f93fc3254d3bf5de4445fb732ee5c451edb6]
stable/6.1: [c6f4015eac2e3cbc3cb7a17539e10bbb5c2049c3]
stable/6.12: [1a59cc6b65fd3ad9915aae5970d859109d4ce9fb]
stable/6.18: [921920c34cb591947dd30c692500795a69f1e3fa]
stable/6.6: [d0d124dbcef9318e326956137b31671407094bd4]
stable/7.0: [98f744d204e5d6fca589cd2c44c3190a0c71697f]

CVE-2026-53034: bpf, sockmap: Fix af_unix null-ptr-deref in proto update

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53034

Introduced by commit c638291 ("af_unix: Implement
->psock_update_sk_prot()") in v5.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dca38b7734d2ea00af4818ff3ae836fab33d5d5a]
stable/6.1: [75b7d3b3f8bd4e59eb3af1b11a43c64c0c2db6f4]
stable/6.12: [4913c94a3adcdbb64c552110c0c243cb1fdbb317]
stable/6.18: [041eb6348d73ee5e15fc8161f1eac5a6e8289ca0]
stable/6.6: [a94d3dd78ee8b63e6b8ad629081c952c93ee5a10]
stable/7.0: [37bfcd164161b47d00b1c3bd20adc816a6977ce0]

CVE-2026-53035: bpf, sockmap: Fix af_unix iter deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53035

Introduced by commit 2c860a4 ("bpf: af_unix: Implement BPF iterator
for UNIX domain socket.") in v5.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d328dd695383224aa750ddee6b4ad40c0f8d205]
stable/6.1: [bd3592129f24243713673a07225cf1f15a9bb835]
stable/6.12: [87828b380956d4986f59f2c086e0b09b3e6cdaae]
stable/6.18: [527057ebe8076dfbcaef51195ff1b7508646be2c]
stable/6.6: [3cef33b9813b78f227942572fb317afcd5c9ac94]
stable/7.0: [66d9fab4565eafe1afe7ba0581f79b76073b60fa]

CVE-2026-53036: bpf, arm64: Fix off-by-one in check_imm signed range check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53036

Introduced by commit e54bcde ("arm64: eBPF JIT compiler") in v3.18-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1dd8be4ec722ce54e4cace59f3a4ba658111b3ec]
stable/6.1: [a5dfeb3b61065039488342d43ae06d4729d955d4]
stable/6.12: [6927f0d6794aa73318bbfa929f1ff6065b0620df]
stable/6.18: [1a113b5497297871699cd498b1b83542e0db7f15]
stable/6.6: [7fd3b41260c6120e7b60164afea5d961af6224f9]
stable/7.0: [fb74defa1cca1a73177c0c761e641332e4f979a3]

CVE-2026-53037: HID: usbhid: fix deadlock in hid_post_reset()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53037

Introduced by commit dc3c78e ("HID: usbhid: Check HID report
descriptor contents after device reset") in v3.5-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8df2c1b47ee3cd50fd454f75c7a7e2ae8a6adf72]
stable/5.10: [56d318ef8766f0deb08517fd8f3007256ea7997d]
stable/5.15: [90550af0aad5e75110073c501e4fb42fca20ff80]
stable/6.1: [eeceb6f4dd42065fdda3a526a93d08b8fb90fb69]
stable/6.12: [4e900465296ce9fb12ed47dc77389b8dde95bfe0]
stable/6.18: [c7abd0e6c87441e99c759d40eb6fe589634e3041]
stable/6.6: [ad4505d2ab3aaac6498f17649608e70e80034bf2]
stable/7.0: [b3d16611d7cd78e9d5c6baa19b61b7caf9f1ab5e]

CVE-2026-53038: ima_fs: Correctly create securityfs files for
unsupported hash algos

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53038

Introduced by commit 9fa8e76 ("ima: add crypto agility support for
template-hash algorithm") in v6.10-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7bd8cf0b348d3edae7bee33e74a32b21668b181]
stable/6.12: [081b557cb56e1cfa8d1619b2601b01c53e3f418c]
stable/6.18: [b6766b171a5c4c33b26ff6fec530cb798db1f75e]
stable/7.0: [88d4e89a39f0de07798ca3fd93bd1a9ea212a82e]

CVE-2026-53039: ocfs2: validate group add input before caching

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53039

Introduced by commit 7909f2b ("[PATCH 2/2] ocfs2: Implement group add
for online resize") in v2.6.25-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70b672833f4025341c11b22c7f83778a5cd611bc]
stable/5.10: [f7e139d7563f6947ad509fb468903941d0bb7ddd]
stable/5.15: [22544ddedf381ed5191cfc783aea8d6c936bc201]
stable/6.1: [76bd722db0a92b84ccd99e03796a0b6f1ae71c31]
stable/6.12: [e7c2cb552e6eb85c0f5aefdd7f0f7c3c8591a6a3]
stable/6.18: [aed87e866d1a321edb9703563c2faa8fec89835d]
stable/6.6: [b9ae3942deec4c9e3fa2070521f90910f7490011]
stable/7.0: [6c5e70409c1961fe1278968f038eaaed6cc1145a]

CVE-2026-53040: ocfs2: validate bg_bits during freefrag scan

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53040

Introduced by commit d24a10b ("Ocfs2: Add a new code
'OCFS2_INFO_FREEFRAG' for o2info ioctl.") in v3.0-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f687eeed3da3012152b0f9473f578869de0cd7b]
stable/5.10: [bb2906a1065ec28de021bac2ed03f2624edd7d07]
stable/5.15: [3e167e230d19cd273108bab2e4c61800fc335ae8]
stable/6.1: [0998674eec138c55e9e349b9cbd9dbc5129a9cc8]
stable/6.12: [05d0cbea41167b6b061c6ba5b70ee5a9a7a24c9e]
stable/6.18: [4c2d62ddde8928db12f4608950b67a20e67deab2]
stable/6.6: [bb3c54d1e71578521111f1a1ee7d5f4761a242b8]
stable/7.0: [e0dcf12665d6dde37facf790803cdad44d5c328c]

CVE-2026-53041: ocfs2: fix listxattr handling when the buffer is full

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53041

Introduced by commit 936b883 ("ocfs2: Refactor xattr list and remove
ocfs2_xattr_handler().") in v2.6.28-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d12f558e6200b3f47dbef9331ed6d115d2410e59]
stable/5.10: [a35a1c2b170b5b578b1b3fecb95694796552af9a]
stable/5.15: [2323084c17370304f49c84b354fe7b3edbb264fe]
stable/6.1: [6f702b00b8124c5d3525f19172934544826a114d]
stable/6.12: [46e66fefb83811958127bc9ad736983ec629d82b]
stable/6.18: [2685df8577a38d83b367c8cf52eda9dc286959ff]
stable/6.6: [d919b905939eda93393e3572900ff70dbad2b47f]
stable/7.0: [50033ec1350fe68abdc63b950ced7ae57364b77a]

CVE-2026-53042: fwctl: Fix class init ordering to avoid NULL pointer
dereference on device removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53042

Introduced by commit 858ce2f ("cxl: Add FWCTL support to CXL") in v6.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a55f80233f384dc89ef3425b2e1dd0e6d44bcf29]
stable/6.18: [a28f56988c8e5bb9375806a5cfb0bf54d662ae3f]
stable/7.0: [1075f2f590fdac147f8b8010c35b606564b5c7d7]

CVE-2026-53043: ocfs2/dlm: validate qr_numregions in dlm_match_regions()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53043

Introduced by commit ea20344 ("ocfs2/dlm: Add message
DLM_QUERY_REGION") in v2.6.37-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ab3fbb01bc6d79091bc375e5235d360cd9b78be]
stable/5.10: [d3d5efade0c79dac1cac98c0cb1115432f804439]
stable/5.15: [f69551139caf6d24242a0ad049ee46b264e3aee0]
stable/6.1: [1f8b91275912cd428289c1fb424bebd7ff5302bd]
stable/6.12: [6c6e8fc3c007319981647b410c29bb5775048551]
stable/6.18: [3f474c33ebc2e2ca3fcb587d7de4375348f13373]
stable/6.6: [f37de46149db49abd2b24f4f0c5a88cf4dfb5f47]
stable/7.0: [3c2d0de23ae4be22b6c18e8f0915be74d3b5fb21]

CVE-2026-53044: soc/tegra: cbb: Fix incorrect ARRAY_SIZE in fabric lookup tables

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53044

Introduced by commit 25de5c8 ("soc/tegra: cbb: Improve handling for
per SoC fabric data") in v6.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [499f7e5ebbdd9ff0c4d532b1c432f8a61ff585b3]
stable/6.18: [f46870b451f7583802ed26eec8b93e138840fcd9]
stable/7.0: [5c009a5f8bb3c81f2cfb511701ce571e3c8733cd]

CVE-2026-53045: memory: tegra124-emc: Fix dll_change check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53045

Introduced by commit 73a7f0a ("memory: tegra: Add EMC (external memory
controller) driver") in v4.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9597ab9a8296ab337e6820f8a717ff621078b632]
stable/5.10: [a85967331144fde9300be38bb44d2558eb6b742e]
stable/5.15: [db0ae80865b515cc0b705c85877ec00f7eebe9fe]
stable/6.1: [2369b1831161356e1bcb51385d3e532dc4fe2771]
stable/6.12: [05f138fc7e27ee8e7a83ccf966c3fa26cda44dda]
stable/6.18: [1793249c067a4b28e1aba0ad0e4d73aa9f9e165a]
stable/6.6: [7e19e72f306484996c52ff96cc92f69b78ed5435]
stable/7.0: [1ebbbef47d11cc90219c081492ccf995aaa3e9b3]

CVE-2026-53046: ksmbd: fix use-after-free from async crypto on
Qualcomm crypto engine

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53046

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e298897f41c61450c2e7a4f457e8b2485eb35b3]
stable/5.15: [57b47231055b431ed0a1a55f33cac32981564405]
stable/6.1: [cc2da381875d4a67026e4c8feb3dba51a2a2d1bc]
stable/6.12: [8ef183216feaa24b66b940510d8b68f680eb56e9]
stable/6.18: [7164b3953cefd540e7ebca828c793bc6869cfbc4]
stable/6.6: [8fcefe840fa8c14ce667768e5b043286ac3bbcbe]
stable/7.0: [b46aa129fa2807bfe1545fe74d9295d53c51520b]

CVE-2026-53047: efi/capsule-loader: fix incorrect sizeof in phys array
reallocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53047

Introduced by commit f24c4d4 ("efi/capsule-loader: Reinstate virtual
capsule mapping") in v4.15-rc7.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48a428215782321b56956974f23593e40ce84b7a]
stable/5.10: [22022cd8851703a58f67615a17bc7e9e8682785b]
stable/5.15: [67adde6bfdfd563a54b045d59aeb9a2d90c80697]
stable/6.1: [608e1f7bc9d171ab26c1fba288c97fc76363c27d]
stable/6.12: [5e185330d902b12fe8e6eb4b8514b5d736d8d66d]
stable/6.18: [e0e6b14995fd6fa2c0df8c712d76ab32f0694c31]
stable/6.6: [8be69e9245f805566bac68ffc8574b64735fd996]
stable/7.0: [ab3f7098a3a27175b91cfc947950f5c26855801b]

CVE-2026-53048: gfs2: prevent NULL pointer dereference during unmount

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53048

Introduced by commit 3526490 ("gfs2: Fix NULL pointer dereference in
gfs2_log_flush") in v6.10-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [74b4dbb946060a3233604d91859a9abd3708141d]
stable/5.15: [cec55674354794eddb80b914f73a6bf9b7fc304a]
stable/6.1: [2fc4c868c9060f424fd4a7cacb0aec5082aba4de]
stable/6.12: [e15f16761594e80b15776980b27c35477655a135]
stable/6.18: [d8ffae016c4a78693fe1283335d0b6833a9c1366]
stable/6.6: [233a0945a4b1dbe3f38c30afb7d05b76c67f1193]
stable/7.0: [abd73229f0e886a91a16ea781ab656bd9b4d1ee8]

CVE-2026-53049: gfs2: add some missing log locking

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53049

Introduced by commit 5e4c763 ("gfs2: Issue revokes more
intelligently") in v5.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe2c8d051150b90b3ccb85f89e3b1d636cb88ec8]
stable/5.15: [3b28eb75afe520972bacc833850c2b30aa0824cd]
stable/6.1: [ca95342cb1b39062a03c115830286f0a426053d5]
stable/6.12: [f2f225cf505ac016132ded21690f3ba0a080a4e8]
stable/6.18: [49d9be0722da3a4a893ba905720cba1921834ec3]
stable/6.6: [bf5fcd9c37c2546beaf7b401d31aefd89017dc3d]
stable/7.0: [98e8bf249c790d56de1abc4a5f8bd68035a00921]

CVE-2026-53050: quota: Fix race of dquot_scan_active() with quota deactivation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53050

Introduced by commit 869b6ea ("quota: Fix slow quotaoff") in v6.6-rc6.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [e93ab401da4b2e2c1b8ef2424de2f238d51c8b2d]
stable/5.10: [2bdc80f4619411e5bd4a3ef23f51e14021ed457c]
stable/5.15: [f9438cb8c8ec3adc84b2b450a3aab0123d074c3b]
stable/6.1: [ac8a2e0d287ebf35e5d7e51e260b4e146648ba4a]
stable/6.12: [61e25f664dc2a08299e07d84c85776abc2350f75]
stable/6.18: [fdd424d7c35633ac577fd87d1b043d1b8a6cd350]
stable/6.6: [6678dde265708003c2b42551af4a2e3cb05decd5]
stable/7.0: [82cbdb4c1ebb5ea7d7bd45c18d3483b5bd32ebc1]

CVE-2026-53051: PCI: tegra194: Fix CBB timeout caused by DBI access
before core power-on

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53051

Introduced by commit 40e2125 ("PCI: tegra194: Move controller cleanups
to pex_ep_event_pex_rst_deassert()") in v6.13-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [34b3eef48d980cd37b876e128bbf314f69fb5d70]
stable/6.12: [010983063a806720b45778d191335f8ea864fea3]
stable/6.18: [b059a41bdd5b202b2b9d7708403fb43c69689e53]
stable/7.0: [ce899f9c019591b73ef84b9afa332ed53beece25]

CVE-2026-53052: ASoC: qcom: qdsp6: topology: check widget type before
accessing data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53052

Introduced by commit 36ad9bf ("ASoC: qdsp6: audioreach: add topology
support") in v5.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5bfdd28e0cdd45043ae6e0ac168a451d59283dc]
stable/6.1: [8e8cd78b6000c9d19db249a5a68287158f288ef3]
stable/6.12: [296810e91f21a21794886c57f954495d8afd7f32]
stable/6.18: [a1a24d4b8c9682f9b7a9138f636ff004c721aef1]
stable/6.6: [1ac96689ce2984f4f6ef8892fcb65da377408421]
stable/7.0: [6d2491a585202a967ed91f30ec5960024f2536d0]

CVE-2026-53053: iommu/amd: Fix clone_alias() to use the original device's devid

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53053

Introduced by commit 3332364 ("iommu/amd: Support multiple PCI DMA
aliases in device table") in v5.5-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [faad224fe0f0857a04ff2eb3c90f0de57f47d0f3]
stable/6.12: [dbd76a537d8cb814e7f5b795ab21ecb7949c821d]
stable/6.18: [20b3c566e2702e5d4d0545be8a97029a2eebcc0e]
stable/7.0: [dae251ff11d2d2208a029f98923756831cefec46]

CVE-2026-53054: drm/msm: Fix VM_BIND UNMAP locking

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53054

Introduced by commit 2e6a8a1 ("drm/msm: Add VM_BIND ioctl") in v6.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85042c2cd970a6b0e686329387096fe19989ae62]
stable/6.18: [206f812ef140727b75697111391ae320fd8aa652]
stable/7.0: [d9ecf758270501b2e7a0bc1dd69a6f28f1ae3cae]

CVE-2026-53055: crypto: hisilicon/sec2 - prevent req used-after-free for sec

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53055

Introduced by commit f0ae287 ("crypto: hisilicon/sec2 - implement full
backlog mode for sec") in v6.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67b53a660e6bf0da2fa8d8872e897a14d8059eaf]
stable/6.18: [b375c3c7209cc59e40e97998aa9bc768369cca0e]
stable/7.0: [ad73563f3a1edbfddf2724136c6a15826b354e18]

CVE-2026-53056: drm/msm/dpu: fix mismatch between power and frequency

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53056

Introduced by commit b0530eb ("drm/msm/dpu: Use OPP API to set
clk/perf state") in v5.9-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc1dccc518cc5ab5140fba06c27e7188e0ed342b]
stable/6.1: [1181a7028d37e0b1e720a36125a03f5db97e3d27]
stable/6.12: [c5735c7d0eef7a5240f9c1c66e44ba52a1be58d6]
stable/6.18: [0f7dd5839cfabaf9c007fb718ec66e907a473c93]
stable/6.6: [9830999c9e065c1813ec5435bfe4eab98ee54a87]
stable/7.0: [0ccf4f27b4652570b5de3de02a89a86435559de9]

CVE-2026-53057: iommu/riscv: Add IOTINVAL after updating DDT/PDT entries

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53057

Introduced by commit 488ffbf ("iommu/riscv: Paging domain support") in
v6.13-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5c262b544975e067ea265fc7403aefbbea8563e]
stable/6.18: [3f917d9bff68600f77561900f3145bd4706dc840]
stable/7.0: [d99d1c13faa793ff1abab0d20ab6473c838081b3]

CVE-2026-53058: drm/bridge: cadence: cdns-mhdp8546-core: Set the mhdp
connector earlier in atomic_enable()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53058

Introduced by commit c932ced ("drm/tidss: Update encoder/bridge chain
connect model") in v6.6-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43d6508ddbf9fb974fbc359a033154f78c9d4c8b]
stable/6.12: [a3611554e599d1a24b45fd8415bacb72ce861e4b]
stable/6.18: [cf2ac2cac8b319f89b3a3851ca0c5ffb6a549575]
stable/6.6: [5302015daf26ef6b48e067f2b86c9482ac19e015]
stable/7.0: [1af3b42e08a957e53bab8e1897393fe0a27d9fbf]

CVE-2026-53059: dm log: fix out-of-bounds write due to region_count overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53059

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c20e36b7631d83e7535877f08af8b0af72c44b1a]
stable/5.10: [44ab8875ae4a2842bde2d756bed195d375e0debb]
stable/5.15: [defe483e47173768c227532694dc78cb65db5f09]
stable/6.1: [3ec74da927b4e171a6fc0e77b1188ba4d019af51]
stable/6.12: [12bd5b88e91a02785244ff1d20fb157e96e9cdc8]
stable/6.18: [b455903eed4558982be0811f5b7f44f6bbc4ff57]
stable/6.6: [d4ac87567f86a55c3c92e9a5144dcd943a9772a1]
stable/7.0: [4ec8323b9f0764a14d532b1ae9b87f8a9fecb867]

CVE-2026-53060: dm cache metadata: fix memory leak on metadata abort retry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53060

Introduced by commit 352b837 ("dm cache: Fix ABBA deadlock between
shrink_slab and dm_cache_metadata_abort") in v6.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1

Fixed status
mainline: [044ca491d4086dc5bf233e9fcb71db52df32f633]
stable/5.10: [14f60e957f34f95a626caec76a8fae88cf4c397f]
stable/5.15: [6b97cc7a42905755c56bbddc33aa8b792205caee]
stable/6.1: [d1a79620c419a0af1911f99c873014b30740e303]
stable/6.12: [b0bd35535bdb6f58505f3a30ee5793986943997a]
stable/6.18: [322a3b70368d49e39591fe9fc6c07d262128b05f]
stable/6.6: [15c30997dca681f90dbf2d45ee629c1828bf0c0d]
stable/7.0: [4311ca59a1891d33c4c8b7946f98c34f167fe833]

CVE-2026-53061: dm cache: fix dirty mapping checking in passthrough
mode switching

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53061

Introduced by commit 2ee57d5 ("dm cache: add passthrough mode") in v3.13-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [322586745bd1a0e5f3559fd1635fdeb4dbd1d6b8]
stable/5.10: [c2e86f647561fcf5e1c6eba7d75e9e0c4299c94d]
stable/5.15: [5c98a3f1d7a554c9e920aa31daf92af6b5bbb8cc]
stable/6.1: [1443c32f24d6d8bcdf4beceef2afc09290b98717]
stable/6.12: [bd5a2c1018938e6b32670728bdb32a3f0efff00f]
stable/6.18: [21c503d60a257e54ca3ac58e2721bd24501d5bde]
stable/6.6: [12105c7f18375d7615dad7605d89eadae7eb12a6]
stable/7.0: [01b22656d8a68dbeae59f8b80866e7b11936b20a]

CVE-2026-53062: dm cache policy smq: fix missing locks in invalidating
cache blocks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53062

Introduced by commit b29d498 ("dm cache: significant rework to
leverage dm-bio-prison-v2") in v4.12-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d1f7b65f5deedd2e6b09fdc6ea27f8375f24b45]
stable/5.10: [4991b5a08751e2e82488fb93ae08849b6aea10d9]
stable/5.15: [1b2bec4a7dcf5f00b7a1cbeeec8997841d783513]
stable/6.1: [9a5fdfb9e57ec3a8ad2b8fce5e5ffa42d53b130e]
stable/6.12: [93627a29d4b66d4a2def938dfb8610cc80ae454b]
stable/6.18: [c348ae47d8e65f06429fa41adce9ad986b696766]
stable/6.6: [ac5ee99443891bdb161f5539606a66a1b5e72542]
stable/7.0: [2b62d0611c9af14a16bddf22df2612b4f40eb5a1]

CVE-2026-53063: dm cache: fix write hang in passthrough mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53063

Introduced by commit b29d498 ("dm cache: significant rework to
leverage dm-bio-prison-v2") in v4.12-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ca8b8bd952df7c3ccdc68af9bd3419d0839a04b]
stable/6.1: [9fa18d0b981776b190ca4632942a7c2174052b78]
stable/6.12: [64d6519b00be4116d365bd31f33a5e5ce2944c1a]
stable/6.18: [b8ace9e96983abb20ccf39edce8a60f1bb0b83d8]
stable/6.6: [ecb10c193cbebf5e6984246a9b4ff1f95d45ed87]
stable/7.0: [05798d091ebcfb6d68228890e593f209e8ac940d]

CVE-2026-53064: dm cache: fix null-deref with concurrent writes in
passthrough mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53064

Introduced by commit b29d498 ("dm cache: significant rework to
leverage dm-bio-prison-v2") in v4.12-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d1f98d668ee34c1d15bdc0420fdd062f24a27c0]
stable/5.10: [01264a6a3a3ad7ac1d73443299cd5a9568002454]
stable/5.15: [ee38fb00e1a80f46a4990e38f25ecb04ae7b7417]
stable/6.1: [c7fb6bc864c4910b344dafa36dd5028e9b980768]
stable/6.12: [a2635d541a93fd111e743cf14b6275dc81be2abc]
stable/6.18: [25dcc1989c194ba2b5fb6d03cbb9b83814ac0d15]
stable/6.6: [0aa745fea1f8dc81bcdd0a45e215b6706727b482]
stable/7.0: [df3b8ef06cc62de4fca5d2108e285085b3cffd44]

CVE-2026-53065: ASoC: sti: use managed regmap_field allocations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53065

Introduced by commit 76c2145 ("ASoC: sti: Add CPU DAI driver for
playback") in v4.3-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1696fad8b259a2d46e51cd6e17e4bcdbe02279fa]
stable/5.10: [4b8dba4527727623a97948aff9f0969a14c203a9]
stable/5.15: [c3af3bcfc1deb3b230cc266a2ac75bca8f4dfba9]
stable/6.1: [43b67761d486d719128e164536e58de5a81dff9b]
stable/6.12: [9641071e3a8e0bc664477a0e54db5f9815f0fb79]
stable/6.18: [a3f3c332882c98ae7553af372191116d1384ca52]
stable/6.6: [002a5f925d42eca8ad547e55a4ae22714cfe9dec]
stable/7.0: [7422a11a753daacbc2409513cf65e1de0d17c291]

CVE-2026-53066: drm/sun4i: backend: fix error pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53066

Introduced by commit 96180dd ("drm/sun4i: backend: Add a custom
atomic_check for the frontend") in v4.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06277983eca4a31d3c2114fa33d99a6e82484b11]
stable/6.1: [ea51fd96aca01381e8f1ac0c671a57b7619193bb]
stable/6.12: [779c2f10743fc021f2f0ebe2b188cadfb973c5e4]
stable/6.18: [47038159c559824f4dbfb5b0d87b9b3416663372]
stable/6.6: [cf615b90a11a39a28e313be5e508e94bcde72016]
stable/7.0: [e9bef62f1bb9fcb38223730657af20f4c6283c16]

CVE-2026-53067: PCI: endpoint: pci-ep-msi: Fix error unwind and
prevent double alloc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53067

Introduced by commit 1c3b002 ("PCI: endpoint: Add RC-to-EP doorbell
support using platform MSI controller") in v6.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1cba96c0a795124c3229293ed7b5b5765e66f259]
stable/6.18: [175717cfc06cab79f84cd037d66dda1b8564cd9e]
stable/7.0: [3c25587fbf8797b92090b064a6d239a873e55fb1]

CVE-2026-53068: drm/komeda: fix integer overflow in AFBC framebuffer size check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53068

Introduced by commit 65ad239 ("drm/komeda: Added AFBC support for
komeda driver") in v5.3-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [779ec12c85c9e4547519e3903a371a3b26a289de]
stable/5.10: [a3a2a9bdc0f9c2d863a5a290cb2d4a565f7268e7]
stable/5.15: [e27b58095d7d3ac72f230e318838dee956258460]
stable/6.1: [02ff8a7d3d0eecc546b9ab4c07b3d7c65d485583]
stable/6.12: [8165e8b28fdf392c2c7412518d602b4f193812a8]
stable/6.18: [fe1f80f8f6e8611ac6349b9d464e8750443390cf]
stable/6.6: [d8a541906860aa3519b1874780d933c766918a7c]
stable/7.0: [872d923b852705054bc099af663da862fdc1097d]

CVE-2026-53069: net, bpf: fix null-ptr-deref in xdp_master_redirect()
for down master

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53069

Introduced by commit 879af96 ("net, core: Add support for XDP
redirection to slave device") in v5.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1921f91298d1388a0bb9db8f83800c998b649cb3]
stable/5.15: [3128b294b426533c8d9162187446d93a8a160359]
stable/6.1: [acbf45bd584d924b320bee2a7fe2a26f64904d95]
stable/6.12: [183128da0406b1c10e6f60b7b9fe70788b9c8c1d]
stable/6.18: [7bad93e99737e4a5c0c14ac50c05152cf4e28022]
stable/6.6: [866d3d9b87751b1944168fd82615505e0c0fd6cf]
stable/7.0: [ea690b3b6e58ae00979af8195b4cc24df466b65e]

CVE-2026-53070: sctp: disable BH before calling udp_tunnel_xmit_skb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53070

Introduced by commit 6f1a914 ("net: add xmit recursion limit to tunnel
xmit functions") in v7.0-rc4.
Introduced by commit 046c052 ("sctp: enable udp tunneling socks") in v5.11-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [2cd7e6971fc2787408ceef17906ea152791448cf]
stable/7.0: [790093245e35040c2adb15f48970020425aa3f47]

CVE-2026-53071: Bluetooth: l2cap: Add missing chan lock in
l2cap_ecred_reconf_rsp

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53071

Introduced by commit 15f02b9 ("Bluetooth: L2CAP: Add initial code for
Enhanced Credit Based Mode") in v5.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [42776497cdbc9a665b384a6dcb85f0d4bd927eab]
stable/5.10: [96dca51715d86559ed6ed8028e5445cecb80f3ae]
stable/5.15: [330b20ec97916961ee0e6c29c06bc0fa7c96e64c]
stable/6.1: [0ccd75c51f620374086f359e906917676e699a1c]
stable/6.12: [fe1188abdae9b7a8199dcdfcf9244d5e5d61eb14]
stable/6.18: [dc89961b76f12aff47124c1df4bdb32a080f4d0c]
stable/6.6: [77a853aec710b2fdf41fa298ea3cbc9a4358f917]
stable/7.0: [5501d055a1ce3c747141e3955ba8cf034d193f3e]

CVE-2026-53072: Bluetooth: fix locking in hci_conn_request_evt() with
HCI_PROTO_DEFER

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53072

Introduced by commit 70c4642 ("Bluetooth: Refactor connection request
handling") in v3.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c7209a341ff2ac338b2b0375c34a307b37c9ac2]
stable/5.10: [60e3f4ff02d1f2d55bfbf2ca32a97285a9771ee4]
stable/5.15: [9d4a6c0f43fc5e4d4f062e8e450e5483eb74176e]
stable/6.1: [c7777f534a8018ae4bb1c80d8925af4df588a314]
stable/6.12: [541d5bf9b5afaf41090b2a3aa7b47f2db2ff801f]
stable/6.18: [385b2d0468a0871fc716c549fa3b0c257c7dbcb3]
stable/6.6: [6b4d226d01ab7da0d2027a2a1e3a6079152e5065]
stable/7.0: [c27224daf0b08efbb2b24ed64b6139b294f5473a]

CVE-2026-53073: Bluetooth: hci_ldisc: Clear HCI_UART_PROTO_INIT on error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53073

Introduced by commit 5df5daf ("Bluetooth: hci_uart: Fix another race
during initialization") in v6.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [68d39ea5e0adc9ecaea1ce8abd842ec972eb8718]
stable/5.10: [ebb39b2d81731b83ee71a1ba6dd0291a57b5ac07]
stable/5.15: [ed4033fb85ccaaf6c3983be3c7b037e48253d232]
stable/6.1: [356dee1bcac4d0d9152390561fa63331ebff211b]
stable/6.12: [f4b69c35813c432973d340d3600c01de106ed474]
stable/6.18: [3daa5818e473ed60eb69d8b5c71b651909d28c5a]
stable/6.6: [a673cf6c4ac702cb79ac1f4d7fc4de763a6a3e40]
stable/7.0: [194f029a4d7f739e44ebc1f473120187b4de5104]

CVE-2026-53074: bpf: reject short IPv4/IPv6 inputs in bpf_prog_test_run_skb

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53074

Introduced by commit fa5cb54 ("bpf: Setup socket family and addresses
in bpf_prog_test_run_skb") in v5.9-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12bec2bd4b76d81c5d3996bd14ec1b7f4d983747]
stable/5.10: [7254267799d083280c0e53effc101a33add95f7b]
stable/5.15: [6a9f38d5ff11e00bc54baab752642978805e81eb]
stable/6.1: [e6aa481f21fc7a41ed344767ea25aae9d03fae71]
stable/6.12: [1f882c492d46f90bdb36f4936876c88c28dab21c]
stable/6.18: [8042240412de3222d27b31e89d29336961cad9e4]
stable/6.6: [0a04db240effd85773f66244645a28cedddb72d2]
stable/7.0: [6def5fe753cbe5b279ee5fd10327b2611cbddaca]

CVE-2026-53075: ppp: require CAP_NET_ADMIN in target netns for unattached ioctls

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53075

Introduced by commit 273ec51 ("net: ppp_generic - introduce
net-namespace functionality v2") in v2.6.30-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2bb6379416fd19f44c3423a00bfd8626259f6067]
stable/5.10: [c9edd90c57ae23692fff6b049fdfa4572a9fd532]
stable/5.15: [5080e188c914110034bbc569d5cfa2f06204681d]
stable/6.1: [67e901e28d177ac9a9bed76d69ce3471e704a89e]
stable/6.12: [3b2c2157dc2afc5c17cd7238afefca92f1ef330e]
stable/6.18: [5013be175c7ffd8b39efbc3c9c4db5b10b85fea8]
stable/6.6: [954745d0223e7caec917c0b2d1a889ff56fa6e54]
stable/7.0: [1a8a51ce85075a56a743b6f142606dd2696a391c]

CVE-2026-53076: bpf: Fix OOB in pcpu_init_value

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53076

Introduced by commit d3bec01 ("bpf: Zero-fill re-used per-cpu map
element") in v5.10-rc4.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [576afddfee8d1108ee299bf10f581593540d1a36]
stable/6.12: [e0378419b0e20178b5d100b27c9cc7e51064202e]
stable/6.18: [6086079e6d1c32ba4c4b422612b8aebb1129a96c]
stable/6.6: [e19c5ed9f1922a6854073f8651a63fa7be26e9e9]
stable/7.0: [634a793d0e1c822412095d25a1338f8831ad894c]

CVE-2026-53077: net/rds: Restrict use of RDS/IB to the initial network namespace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53077

Introduced by commit d5a8ac2 ("RDS-TCP: Make RDS-TCP work correctly
when it is set up in a netns other than init_net") in v4.3-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ebf71dd4aff46e8e421d455db3e231ba43d2fa8a]
stable/5.10: [3e7f14cd5a51533404e1ae4809caab46073fb5c7]
stable/5.15: [3174fc703d081d2ca538b22fba734e3ad5b52322]
stable/6.1: [c244b79adffad89a5173cf8bfaa06a6b40bbd09b]
stable/6.12: [fb407343c0c16e94584707b2dfdd350a5f81b000]
stable/6.18: [a7494479757d60d2413bfaa087f8431a26eea032]
stable/6.6: [07035306bf722f4676a1aee35cbeb3732c76194e]
stable/7.0: [b6a54f5e9ce9b97ae641855378d71c5154a085c0]

CVE-2026-53078: bpf: Fix same-register dst/src OOB read and pointer
leak in sock_ops

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53078

Introduced by commit fd09af0 ("bpf: sock_ops ctx access may stomp
registers in corner case") in v5.9-rc2.
Introduced by commit 84f44df ("bpf: sock_ops sk access may stomp
registers when dst_reg = src_reg") in v5.9-rc2.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10f86a2a5c91fc4c4d001960f1c21abe52545ef6]
stable/7.0: [18e3ffde1822f0b48b1753bf34aa97ce839df1d8]

CVE-2026-53079: net_sched: fix skb memory leak in deferred qdisc drops

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53079

Introduced by commit a6efc27 ("net_sched: use qdisc_dequeue_drop() in
cake, codel, fq_codel") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6bd339dbb3514bce690fdcf252e788dfab4ee76]
stable/7.0: [bf26ad92ffda7884825d67b46bd5efe615c3babf]

CVE-2026-53080: net/sched: cls_fw: fix NULL dereference of "old"
filters before change()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53080

Introduced by commit faeea8b ("net/sched: cls_fw: fix NULL pointer
dereference on shared blocks") in v7.0-rc7.
Introduced by commit ed76f5e ("net: sched: protect filter_chain list
with filter_chain_lock mutex") in v5.1-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [65782b2db7321d5f97c16718c4c7f6c7205a56be]
stable/5.10: [a719275da488835e987d28effc04679b4aace3a0]
stable/5.15: [c205da704c84eeb4247d770150440294fd547049]
stable/6.1: [5dcce34c57d5e5990869384d69deeb9414bf9b92]
stable/6.12: [829808cbf8cf8a6d07a0e67a5ea2c3fcd63a9e5c]
stable/6.18: [41845bc5bb64f3d615abe575ad655b5e7f193634]
stable/6.6: [5df49f0579f7e625f2358a219d31fbc7621be799]
stable/7.0: [4fabcfea7a9dd159df32c5df6587fe858cb0d748]

CVE-2026-53081: bpf: Enforce regsafe base id consistency for
BPF_ADD_CONST scalars

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53081

Introduced by commit 98d7ca3 ("bpf: Track delta between "linked"
registers.") in v6.11-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f2ec8e7730e21fc9bd49e0de9cdd58213ea24d0]
stable/6.12: [13c02881e49aac4c82b261faa26db9edf2567231]
stable/6.18: [691adf738817275368ed56311b7d798d617823a3]
stable/7.0: [7d73c72cccac651acc891377a5e623e4021c6380]

CVE-2026-53082: net: hamradio: 6pack: fix uninit-value in sixpack_receive_buf

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53082

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf9a38803b2626b01cc769aaf13485d8650f576f]
stable/5.10: [1d3abf0c3ddeefc6f6d913aa129acc06fce8240a]
stable/5.15: [d4cceb5184538613572fb79319453f281b1eeacb]
stable/6.1: [2951656b0de00153f2687f3a093890bce72b6215]
stable/6.12: [d9ce2a4b679122397d7f35bad7be46913ad1ca80]
stable/6.18: [987af7625ceb1ee59d70eb0abd7af11c75e45d79]
stable/6.6: [e9cf4018d74237d142cd66243c821d13593270f0]
stable/7.0: [578f3aba427c938fecfa0d8c83d9acb213a9b24a]

CVE-2026-53083: bpf: Fix RCU stall in bpf_fd_array_map_clear()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53083

Introduced by commit da765a2 ("bpf: Add poke dependency tracking for
prog array maps") in v5.5-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4406942e65ca128c56c67443832988873c21d2e9]
stable/6.12: [71ddb7defc442ab38c53123c384fedbfd8410a15]
stable/6.18: [e1ed678855e315f90c70c1723e94157a9a82e660]
stable/6.6: [b1f7158a86f3cbac4d5a32beb55ca0f8027d44cd]
stable/7.0: [67bdb4b0d26f2d6bbf1798a925ef5a3b9ed7357a]

CVE-2026-53084: bpf: return VMA snapshot from task_vma iterator

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53084

Introduced by commit 4ac4546 ("bpf: Introduce task_vma open-coded
iterator kfuncs") in v6.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cbee026db54cad39c39db4d356100cb133412b3]
stable/6.12: [83b8802c034e843b83a3e1ef6f30cdd4e9ec291c]
stable/6.18: [592226d138378601ae28eb890e2bbc23ec3600f7]
stable/7.0: [13860ca37b8df0b856ee1ce3bdbd7c327d5f53e8]

CVE-2026-53085: bpf: fix mm lifecycle in open-coded task_vma iterator

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53085

Introduced by commit 4ac4546 ("bpf: Introduce task_vma open-coded
iterator kfuncs") in v6.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d8e27d2d22b6e2df3a0125b8c08e9aace38c954c]
stable/6.12: [239cec25a22662dbd80f57d94b38178c8be95269]
stable/6.18: [d0862de7c866c5bd7c32531f66738c21197af888]
stable/7.0: [43683bb280330f3d36f0f2a3932a4867b9603e9c]

CVE-2026-53086: net: bcmgenet: fix racing timeout handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53086

Introduced by commit 13ea657 ("net: bcmgenet: improve TX timeout") in v4.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5393b2b5bee2ac51a0043dc7f4ac3475f053d08d]
stable/6.1: [e85b0c0a12e967930044608311471b665baa315c]
stable/6.12: [681fdfe823b4f1036ed50b58b8838c7917ea389c]
stable/6.18: [c270e2bec3e55a716d25c35341091339457ac883]
stable/6.6: [e8206538cbaf4f4068e99a4cb1138690a1e00499]
stable/7.0: [7ce1c26aac3b318886a57425f64b522da7389153]

CVE-2026-53087: net: bcmgenet: fix leaking free_bds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53087

Introduced by commit f1bacae ("net: bcmgenet: support reclaiming
unsent Tx packets") in v6.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [3f3168300efb839028328d720ab3962f91d6a0d0]
stable/6.1: [150d06aae1839a6564ab200ef0e7291c3528bbb0]
stable/6.12: [3c3abbcfa05bad17965498ff7cc94c2418fa94b3]
stable/6.18: [25ff3a3e47ea635ec08dc93e84dd2bfe15abfebb]
stable/6.6: [52b9f80993698138b90e5ca3a72550a2501f2a96]
stable/7.0: [ac4a29c331ecb5b10240c44247a8e010c95bc15b]

CVE-2026-53088: net: bcmgenet: fix off-by-one in bcmgenet_put_txcb

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53088

Introduced by commit 876dbad ("net: bcmgenet: Fix unmapping of
fragments in bcmgenet_xmit()") in v4.13-rc2.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57f3f53d2c9c5a9e133596e2f7bc1c50688a6d38]
stable/5.10: [14e9f86564fff7bcf7f45c1b69080e837b31d185]
stable/5.15: [fb9a3c1f547d0ff024dbfe7b6f327626ddf0a3de]
stable/6.1: [85f34ec320d3881badfd4edc5fee5cd5012bb54d]
stable/6.12: [29394f722f620281f2ee9a47f947734e53d72c90]
stable/6.18: [4cab761fc51c65aef741fcece4a18f3554edbc09]
stable/6.6: [2a74590170427a3ca7cc4bb8690cdd559129c29c]
stable/7.0: [72df896e31ddd06fcc5a789f025ad7a62a18bc9b]

CVE-2026-53089: bpf: Fix use-after-free in offloaded map/prog info fill

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53089

Introduced by commit 675fc27 ("bpf: offload: report device information
for offloaded programs") in v4.16-rc1.
Introduced by commit 52775b3 ("bpf: offload: report device information
about offloaded maps") in v4.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0c584fc18056709c8e047a82a6045d6c209f4ce]
stable/7.0: [a51e7fbe94a87e236631a83973d4f558310b2cd2]

CVE-2026-53090: bpf: Fix ld_{abs,ind} failure path analysis in subprogs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53090

Introduced by commit 09b28d7 ("bpf: Add abnormal return checks.") in v5.10-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee861486e377edc55361c08dcbceab3f6b6577bd]
stable/7.0: [d846d83bdacbd8f14fc45c63b8c1d22608452e1c]

CVE-2026-53091: net: pull headers in qdisc_pkt_len_segs_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53091

Introduced by commit e876f20 ("net: Add a software TSO helper API") in
v3.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7fb4c19670110f052c04e1ec1d2b953b9f4f57e4]
stable/7.0: [9d4f5c68f5ad4ab425f3ce1500c97c9f9743999a]

CVE-2026-53092: bpf: Fix linked reg delta tracking when src_reg == dst_reg

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53092

Introduced by commit 98d7ca3 ("bpf: Track delta between "linked"
registers.") in v6.11-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7f14173c0d5866c3cae759dee560ad1bed10d2e]
stable/6.18: [d88e8e4a3b52bd5b2ff3eceba4b29d1b5506d066]
stable/7.0: [cc86a8b0a1c54d2bccf6f68cf49b82dea91b84de]

CVE-2026-53093: wifi: brcmfmac: Fix error pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53093

Introduced by commit cb7cf7b ("brcmfmac: make chip related functions
host interface independent") in v3.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd8592fc6007a451c3e4b9025de365e39de8178a]
stable/5.10: [a3b45090a91e2f0b9715870d8f8d9ca2fdfbc1af]
stable/5.15: [99ef547659178eef6d6ba4738a9d989ce90cf909]
stable/6.1: [bd6c906e0c4af6d5d0c49c3c4ee090b4913da17d]
stable/6.12: [2e0e5a43ed126f896a4ad31ade66c90270601bae]
stable/6.18: [cbea71b4480394708f9a6e007a0385acfe5e1ec8]
stable/6.6: [d3f280be48f1c672cb10e8026c236d0cca60048a]
stable/7.0: [334c68750eee84c2327db1d152be83ff5ad8e20b]

CVE-2026-53094: bpf: Fix stale offload->prog pointer after constant blinding

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53094

Introduced by commit 2b3486b ("bpf: Introduce device-bound XDP
programs") in v6.3-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1aa9ef47c299c5bbc30594d3c2f0589edf908e6]
stable/6.12: [25484c39d1ec82a0368798d956da3de5039b3fe8]
stable/6.18: [059525cf18e69a9313baf947d8898c6ee7ca6b65]
stable/6.6: [a713b72ff88cdab4d5d692908ab1259ada511f4d]
stable/7.0: [c79f8503d83d4665be461fb9e45e215d0380c67b]

CVE-2026-53095: bpf: Fix abuse of kprobe_write_ctx via freplace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53095

Introduced by commit 7384893 ("bpf: Allow uprobe program to change
context registers") in v6.18-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [611fe4b79af72d00d80f2223354284447daafae9]
stable/6.18: [b312cf41b9e43f442613053f6cad39898e1baf96]
stable/7.0: [9836cadbd96c7e0dbb0018fa60e7872dd31ac4f8]

CVE-2026-53096: bpf: Use RCU-safe iteration in dev_map_redirect_multi() SKB path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53096

Introduced by commit e624d4e ("xdp: Extend xdp_redirect_map with
broadcast support") in v5.14-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ed82f807bb09d2c8455aaa665f2c6cb17bc6a19]
stable/5.15: [4a3d0fe30b907ff324b1b49756f7e713d67f3645]
stable/6.1: [b089aa6e94d7a08e74d076a0fe274842dc9feccc]
stable/6.12: [cb2c1f3cf65b855548e1b8d55a08bfbaa5a0901a]
stable/6.18: [d4c4bd231ebad70e6f30db429e9640bf378b2f52]
stable/6.6: [571a05ea1baaccc0dc1e0d227b2cbc978b96d392]
stable/7.0: [7027e705062482a8cea43a1c13ede3c35653966f]

CVE-2026-53097: wifi: mt76: mt7996: fix use-after-free bugs in
mt7996_mac_dump_work()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53097

Introduced by commit 878161d ("wifi: mt76: mt7996: enable coredump
support") in v6.4-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c8f62f73bbced3a79894655bdb0b625462d956fc]
stable/6.12: [180182a3f23ff79430a32ca2c4c1885368ceab48]
stable/6.18: [aa4a31cd89f4fde5043ac613fe0e27014a60a60b]
stable/7.0: [188e10f9ea3109d23c6b7643aa6ec2f5cb0faa6d]

CVE-2026-53098: wifi: mt76: mt7915: fix use-after-free bugs in
mt7915_mac_dump_work()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53098

Introduced by commit 4dbcb91 ("wifi: mt76: mt7915: enable coredump
support") in v6.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1146d0946b5358fad24812bd39d68f31cd40cc34]
stable/6.12: [e6856af8a22a8e2cd18241a465ed00c2301b3a5e]
stable/6.18: [6b7cbb13c838cf2a5f2e7be0e96fe15250087939]
stable/6.6: [6d5202409467d621b6d1dfd7fc7dadb997fe66d2]
stable/7.0: [21ce6d867867645fff0ef657be18f61d9f39dcd8]

CVE-2026-53099: bpf: Switch CONFIG_CFI_CLANG to CONFIG_CFI

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53099

Introduced by commit 99fde4d ("bpf, btf: Enforce destructor kfunc type
with CFI") in v7.0-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b0cf064ea0a6bac5e1a5fb43b004fd52fbe2b3b]
stable/7.0: [f74fce43dbc059e059b5346a670f697c0e97b1d0]

CVE-2026-53100: wifi: mt76: fix deadlock in remain-on-channel

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53100

Introduced by commit a8f424c ("wifi: mt76: add multi-radio
remain_on_channel functions") in v6.14-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6939b97ddad3cf3dfbb3b5a0a12ef79cb886747e]
stable/6.18: [5fc8c5d45e44575dda9fcabdc2aac4ad97baf0cd]
stable/7.0: [7a89c245d203aa0ed5ff2d68ac05b48b2ef9fa3f]

CVE-2026-53101: wifi: mt76: mt7921: fix potential deadlock in
mt7921_roc_abort_sync

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53101

Introduced by commit 352d966 ("wifi: mt76: mt7921: fix a potential
association failure upon resuming") in v6.9-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5059e52fd8bc624ec4255c9fa01a266513d126b]
stable/6.18: [35180c772f5e11e2fa4d80d3dfd50906cb6d9646]
stable/7.0: [91e77840bf13de3add125060cf8b32ca24a52c8c]

CVE-2026-53102: wifi: mt76: Fix memory leak after
mt76_connac_mcu_alloc_sta_req()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53102

Introduced by commit d1369e5 ("wifi: mt76: connac: introduce
mt76_connac_mcu_sta_wed_update utility routine") in v6.2-rc1.
Introduced by commit 6683d98 ("mt76: connac: move
mt76_connac_mcu_add_key in connac module") in v5.18-rc1.
Introduced by commit 4f831d1 ("wifi: mt76: mt7915: enable WED RX
support") in v6.2-rc1.
Introduced by commit c948b5d ("wifi: mt76: mt7925: add Mediatek Wi-Fi7
driver for mt7925 chips") in v6.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c41075ce8cf05ed8c0e7b7efef000dce548ffc42]
stable/7.0: [eb466406d2094deefadc2cd6ddb4f6eeb086d1b4]

CVE-2026-53103: wifi: mt76: mt7925: fix potential deadlock in
mt7925_roc_abort_sync

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53103

Introduced by commit 45064d1 ("wifi: mt76: mt7925: fix a potential
association failure upon resuming") in v6.12-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd08ca3f092f4185ece69ce2a835c23198b1628a]
stable/6.18: [153bcba36c87a1ba555b57b6c49028d5812f895b]
stable/7.0: [2d8e0053bca29143ace51e08c980ff076844a4b0]

CVE-2026-53104: wifi: mt76: Fix memory leak destroying device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53104

Introduced by commit 950d0ab ("wifi: mt76: mt7996: add wed rx
support") in v6.8-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b470f36616e3448d44b0ef4b1de2a3e3a31b5be]
stable/6.18: [dcbc13d19bef3326c72f324b10f5a3e5fc4d71de]
stable/7.0: [4b7c92fd8b8700fac387ff43c6f6e0c4e05ec93f]

CVE-2026-53105: wifi: mt76: mt7925: prevent NULL vif dereference in
mt7925_mac_write_txwi

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53105

Introduced by commit ebb1406 ("wifi: mt76: mt7925: add link handling
to txwi") in v6.11-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [962eb04e67552be406c906c83099c1d736aae3b6]
stable/6.12: [6c52fbdc6f656ac2e8ed1e3d0f42ed21ef285e15]
stable/6.18: [815db7fd57aa81c93fc8a66c2fac5f8bd0a8d153]
stable/7.0: [5d5bdea4ffcf54a6c4e751df713f95a1d783f298]

CVE-2026-53106: bpf: Do not allow deleting local storage in NMI

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53106

Introduced by commit a10787e ("bpf: Enable task local storage for
tracing programs") in v5.13-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [350de5b8a9befaa2a68861c51f671d4f5f751ca5]
stable/7.0: [e84acaf936970b5b0be2c93bbf255295ba9406df]

CVE-2026-53107: wifi: libertas: don't kill URBs in interrupt context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53107

Introduced by commit d66676e ("wifi: libertas: fix WARNING in
usb_tx_block") in v7.0-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [7c5c2b661bdb78c1472b8833265c9ed1ee880039]
stable/6.18: [00c0317cebf44151df18fb647781f315268cdd98]
stable/7.0: [4f273d3f98ebc60c30bbfb3ed4a7f0477d3eaed2]

CVE-2026-53108: powerpc/64s: Fix unmap race with PMD migration entries

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53108

Introduced by commit 75358ea ("powerpc/mm/book3s64: Fix MADV_DONTNEED
and parallel page fault race") in v5.8-rc1.
Introduced by commit a30b48b ("mm/migrate_device: implement THP
migration of zone device pages") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbcbf045d6c778e82b47a35fc8728387708e9a3d]
stable/7.0: [829367e55012c053738ebe7db20c4a90d6609ece]

CVE-2026-53109: powerpc/pgtable-frag: Fix bad page state in pte_frag_destroy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53109

Introduced by commit 32cc0b7 ("powerpc: add pte_free_defer() for
pgtables sharing page") in v6.6-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fda4d71651f71c44b35829d13f3c8bf920032f77]
stable/6.18: [c8b710655012a2993a9567873fb71a8a51f8459c]
stable/7.0: [a32db6fca3c74b4eb8bae5470f0680deb4cbac6f]

CVE-2026-53110: s390/bpf: Zero-extend bpf prog return values and kfunc arguments

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53110

Introduced by commit 528eb2c ("s390/bpf: Implement
arch_prepare_bpf_trampoline()") in v6.3-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [202e42e4aa890172366354b233c42c73107a3f59]
stable/6.12: [44c4f999b03f55debb1a0c5ab5c1796895a1adf8]
stable/6.18: [366b0e05ee24f5ba62bdc7ec1346038258b9a797]
stable/6.6: [edc90a12073b9a530064a99945c183dde120cb99]
stable/7.0: [834918a77be51419383bf1dda9f02b81ecf26b34]

CVE-2026-53111: bpf: test_run: Fix the null pointer dereference issue
in bpf_lwt_xmit_push_encap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53111

Introduced by commit 52f2787 ("bpf: implement BPF_LWT_ENCAP_IP mode in
bpf_lwt_push_encap") in v5.1-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [972787479ee73006fddb5e59ab5c8e733810ff42]
stable/6.1: [5c8d1f91fc4898d79f29d79c1a6f7c2b3ee66fb0]
stable/6.12: [599905c3f10bb83e6e6881d5a7f5cea5df07dc23]
stable/6.18: [5500913516e071dbe23e5a404c861dd2d82c9589]
stable/6.6: [c7ad31fb948fdd4905263f4324160682c3fa7bc6]
stable/7.0: [94f95328b9070909b5b875c647b17a11d3d85567]

CVE-2026-53112: wifi: rtlwifi: pci: fix possible use-after-free caused
by unfinished irq_prepare_bcn_tasklet

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53112

Introduced by commit 0c81733 ("rtl8192ce: Add new driver") in v2.6.38-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [039cd522dc70151da13329a5e3ae19b1736f468a]
stable/5.10: [ae10d4a1ab6bcaa1336abb171908a9a365761d3e]
stable/5.15: [fac1079e0fdec6df6d7562c21941587236dc3def]
stable/6.1: [e40873820c9d245ce482faa7ad514ebdb3b8d23d]
stable/6.12: [7731b67bd59d1284d150cbe40a47e95a10613234]
stable/6.18: [aa10a452e34810987fb9f4a047995b30003fb53f]
stable/6.6: [008c456b76e9070979bc0e763897a5d3b0fdd4dc]
stable/7.0: [3c0e8a3179e6325a7dc6ce221aef0e03d854ab4b]

CVE-2026-53113: wifi: ath11k: fix memory leaks in beacon template setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53113

Introduced by commit 3a415da ("wifi: ath11k: add P2P IE in beacon
template") in v6.10-rc1.
Introduced by commit 335a927 ("wifi: ath11k: MBSSID beacon support")
in v6.5-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff49eba595df500e4ddccc593088c8a4ab5f2c27]
stable/7.0: [5d63aa38d5ca85206d9699ffdd616b58780dba07]

CVE-2026-53114: perf/amd/ibs: Avoid calling perf_allow_kernel() from
the IBS NMI handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53114

Introduced by commit 50a53b6 ("perf/amd/ibs: Prevent leaking sensitive
data to userspace") in v6.14.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0a09142622a994c4f4088c3f61db5da87cfc711]
stable/6.18: [2783ed2442ce69ae240b787aee6dae801cef7aec]
stable/7.0: [0584e74fa2b27e9e722cfb5b579f79263df20040]

CVE-2026-53115: bus: fsl-mc: use generic driver_override infrastructure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53115

Introduced by commit 1f86a00 ("bus/fsl-mc: add support for
'driver_override' in the mc-bus") in v5.10-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c8dfb0362732bf1e4829867a2a5239fedc592d0]
stable/6.12: [4911b836f35c034c36f102db4ecbe339b38e7d1d]
stable/6.18: [8139ce66b52a4a5638bfb445b037c07d4abeb08e]
stable/7.0: [60bfb563a399c4597dc80588a1109758a8908b97]

CVE-2026-53116: s390/ap: use generic driver_override infrastructure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53116

Introduced by commit d38a87d ("s390/ap: Support driver_override for AP
queue devices") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81d6f7c3a70b10ff757ee8b5f8114a190871cf1e]
stable/7.0: [8f2eca0570438b94602da1297353eb7b10dcb6cb]

CVE-2026-53117: s390/cio: use generic driver_override infrastructure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53117

Introduced by commit ebc3d17 ("s390/cio: introduce driver_override on
the css bus") in v5.3-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac4d8bb6e2e13e8684a76ea48d13ebaaaf5c24c4]
stable/6.12: [106d594711e97762788046c5bbb94f580abc4bf4]
stable/6.18: [2081957d8c323ffb58a10bc64837717ac5a042a1]
stable/6.6: [c4295487124f461405e1ef64dfa8c4ab0cb7ebcf]
stable/7.0: [b660ba045b2b22cf3b4be72773de00cb48f47be5]

CVE-2026-53118: vdpa: use generic driver_override infrastructure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53118

Introduced by commit 539fec7 ("vdpa: add driver_override support") in v5.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85bb534ff12aab6916058897b39c748940a7a4c6]
stable/6.18: [654ef9c33e138ede6734ac286282df9faf83cd11]
stable/7.0: [fb5cb4913ce333cc4647722e8c2b8378e12f2464]

CVE-2026-53119: platform/wmi: use generic driver_override infrastructure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53119

Introduced by commit 12046f8 ("platform/x86: wmi: Add driver_override
support") in v6.11-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a700b1fc94df4d847a04f14ebc7f8532592b367]
stable/6.12: [13d201bd840d2e2a645ef899f81342cd27ced346]
stable/6.18: [2c5507010fc3b8e2bd596c63c88f6ad39a69b1c4]
stable/7.0: [4dc755d86deed88789540d960e421124bad4c568]

CVE-2026-53120: PCI: use generic driver_override infrastructure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53120

Introduced by commit 782a985 ("PCI: Introduce new device binding path
using pci_dev.driver_override") in v3.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10a4206a24013be4d558d476010cbf2eb4c9fa64]
stable/6.12: [dfe950d9464cad609f3b118c6203e2708055bc61]
stable/6.18: [58a42be0d70307d765594fc581f5f5e5ef059712]
stable/7.0: [c5b2c5755495507e14f310c2653c85de0a309b1f]

CVE-2026-53121: amd-pstate: Fix memory leak in amd_pstate_epp_cpu_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53121

Introduced by commit f9a378f ("cpufreq/amd-pstate: Set different
default EPP policy for Epyc and Ryzen") in v6.14-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [beda3b363546a423e4e29a7395e04c0ac4ff677e]
stable/6.18: [539aabbab190825c77eb455ec35652cb3720625f]
stable/7.0: [7f9aa2359742eaa6ea65ec0d20dafdfd0add9b8b]

CVE-2026-53122: btrfs: fix deadlock between reflink and transaction
commit when using flushoncommit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53122

Introduced by commit 05a5a76 ("Btrfs: implement full reflink support
for inline extents") in v5.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b48c980b6a7e409050bb3067165db31cc6205e3e]
stable/6.12: [73be4a08306bb84f4d5d16f62cb80e1543109ffa]
stable/6.18: [9a24f0000876b8755cf21972b41632f4d6f3dafb]
stable/7.0: [6f0f9c0a368aa1fe078109091322d3b0632d9380]

CVE-2026-53123: md: wake raid456 reshape waiters before suspend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53123

Introduced by commit 714d201 ("md: add new helpers to suspend/resume
array") in v6.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf86bb53b9c92354904a328e947a05ffbfdd1840]
stable/6.12: [8b6a72420821e6da2cab6a69d5233500d2698b93]
stable/6.18: [ff6b93410192b812d73cc54062529715b2dc849f]
stable/7.0: [8ae3e14d7f3df58f7f49c02d74344e3dcd5f84f0]

CVE-2026-53124: ublk: reset per-IO canceled flag on each fetch

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53124

Introduced by commit 728cbac ("ublk: move device reset into
ublk_ch_release()") in v6.15-rc3.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0842186d2c4e67d2f8c8c2d1d779e8acffd41b5b]
stable/7.0: [63335e5a67d89bb7cb9b023bbb3785896587a648]

CVE-2026-53125: md: fix array_state=clear sysfs deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53125

Introduced by commit 9e59d60 ("md: call del_gendisk in control path")
in v6.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2aa72276fab9851dbd59c2daeb4b590c5a113908]
stable/6.18: [62c44566da7493ee48ef17e8507bb798338a07cb]
stable/7.0: [92ad0ec509ffb188d8f849b63148664df37b4a52]

CVE-2026-53126: blk-cgroup: fix disk reference leak in
blkcg_maybe_throttle_current()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53126

Introduced by commit f05837e ("blk-cgroup: store a gendisk to throttle
in struct task_struct") in v6.3-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23308af722fefed00af5f238024c11710938fba3]
stable/6.12: [73a5af059905d171b398c8b2381632ee499948b5]
stable/6.18: [b3e005f16cd98f815429a87aef4c61e9c140779f]
stable/6.6: [4048ed98860d3785645ebbd34f69566a6c7320c3]
stable/7.0: [000e8454692cab9d1f1b80130e2870e355301d06]

CVE-2026-53127: block: fix zones_cond memory leak on zone revalidation
error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53127

Introduced by commit 6e945ff ("block: use zone condition to determine
conventional zones") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a2f520fda824b5a25c93f2249578ea150c24e06]
stable/7.0: [29153d128384fa7c48a8ca8d34094b1cbe2d5bdc]

CVE-2026-53128: drbd: Balance RCU calls in drbd_adm_dump_devices()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53128

Introduced by commit a55bbd3 ("drbd: Backport the "status" command")
in v4.5-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b31e86387e60b3689339f0f0fbb4d3623d9d494]
stable/5.10: [ae12bb44b392637a8321ade305c883f9ffc0daea]
stable/5.15: [68ebb9183ac3621b96b18e046841eadb9508783c]
stable/6.1: [6cd27bcb71bb73f955d104cc3a62be6f83724392]
stable/6.12: [8092713a10c19fa0f731b71b2853af4319ca54fd]
stable/6.18: [996d279f2c985d771d6cfdd923e447d825726e06]
stable/6.6: [282e06e6d494a7bee85af78c747527b7d4009cc3]
stable/7.0: [1f112240531f0a0b437b2e001c1d89e8b25a8328]

CVE-2026-53129: fs/mbcache: cancel shrink work before destroying the cache

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53129

Introduced by commit c2f3140 ("mbcache2: limit cache size") in v4.6-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d227786ab1119669df4dc333a61510c52047cce4]
stable/6.12: [a88d39a74a208e197c03bffaa2df34de732af19f]
stable/6.18: [0e4eff315d799f5842b95872199b0f0fb8ef5f51]
stable/7.0: [b25fd3523bef88fb7ffd4c5b63bbe9c08f73bb4c]

CVE-2026-53130: fs/omfs: reject s_sys_blocksize smaller than OMFS_DIR_START

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53130

Introduced by commit a3ab715 ("omfs: add directory routines") in v2.6.27-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0621c385fda1376e967f37ccd534c26c3e511d14]
stable/5.10: [fbc72f5c645155dc2ed3573243ed20f9913e3a54]
stable/5.15: [5822a05a841a10794ad818620dd2af490b0705d3]
stable/6.1: [754ff1bea3819a90c6f33cccfc1a299ef7609f07]
stable/6.12: [79f84af38c9fef9deb0e02c79eb969b5541c2644]
stable/6.18: [6561afc38398e3518a29c5eebb975c30468f98a6]
stable/6.6: [131ea3e57fc22936ed0e2c8330f2e36106172f51]
stable/7.0: [817f16ed62bc58a168417bfb5e859c2a370bab03]


* Updated CVEs

CVE-2021-47211: ALSA: usb-audio: fix null pointer dereference on pointer cs_desc

stable/5.10 was fixed.

Fixed status
stable/5.10: [3455984b16eeb6914caf8b59498ef24fcc1f0a78]

CVE-2023-54125: fs/ntfs3: Return error for inconsistent extended attributes

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [6557c4504c5a1bbbbac25d14d7dcf2a4912d1508]
stable/6.1: [486666c2c2714788705d02d98d0332c8a2328575]

CVE-2023-54129: octeontx2-af: Add validation for lmac type

stable/5.10 was fixed.

Fixed status
stable/5.10: [4392454c694b13d78c84165c0964729772cd3b73]

CVE-2023-54271: blk-cgroup: Fix NULL deref caused by blkg_policy_data
being installed before init

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [da6cc648c1f570290af1ddbe6b7ca3d91b1d6db9]
stable/6.1: [33f0370bb7ce15a59d72a4d8a05421d334a04add]

CVE-2024-27012: netfilter: nf_tables: restore set elements when delete set fails

stable/6.1 was fixed.

Fixed status
stable/6.1: [faa0deee272128b95a838fe7c6ebf6a2a426df14]

CVE-2025-21863: io_uring: prevent opcode speculation

stable/5.10 was fixed.

Fixed status
stable/5.10: [87e9eef43c758da267f6332678058a79764c7eba]

CVE-2025-22026: nfsd: don't ignore the return code of svc_proc_register()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [51107e768de6821b68aa34a136d07bc7a09cf6c3]
stable/5.15: [e4316bd85e42b01125b2aab691769234a388b8a3]

CVE-2025-38129: page_pool: Fix use-after-free in page_pool_recycle_in_ring

stable/5.10 was fixed.

Fixed status
stable/5.10: [c2c906142293931e33ef4be79ebc36c25c4e21dd]

CVE-2025-38250: Bluetooth: hci_core: Fix use-after-free in vhci_flush()

stable/5.10 was fixed.

Fixed status
stable/5.10: [dd4becd3fd4102696e1c15e6d260a1712a2d8685]

CVE-2025-39863: wifi: brcmfmac: fix use-after-free when rescheduling
brcmf_btcoex_info work

stable/5.15 was fixed.

Fixed status
stable/5.15: [c75600e69e66a751cc046cd9c407b942f298d852]

CVE-2025-39929: smb: client: fix smbdirect_recv_io leak in
smbd_negotiate() error path

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [5aa69aabcb275a8012265233c7694076ce1d9102]
stable/5.15: [aa4cf7615328eae44f3b4bf5f4fde3fb390c27c6]

CVE-2025-40164: usbnet: Fix using smp_processor_id() in preemptible
code warnings

stable/5.10 was fixed.

Fixed status
stable/5.10: [6635e52bc4165793aefd686962d912d73d323afe]

CVE-2025-68296: drm, fbcon, vga_switcheroo: Avoid race condition in fbcon setup

stable/6.6 was fixed.

Fixed status
stable/6.6: [711ebd961190def4c69ea24b2f0be75e995af24a]

CVE-2025-68340: team: Move team device type change at the end of team_port_add

stable/5.10 was fixed.

Fixed status
stable/5.10: [f82d1fb65549de241fe312fcb2bcb8e0ad7b424d]

CVE-2025-68736: landlock: Fix handling of disconnected directories

stable/6.6 was fixed.

Fixed status
stable/6.6: [fbf718d5afe21057694a0c0223a18b0c7a5960b6]

CVE-2025-68768: inet: frags: flush pending skbs in fqdir_pre_exit()

stable/6.6 was fixed.

Fixed status
stable/6.6: [22ee4010866da81aeee08e1ea3fddbe418feb212]

CVE-2026-23099: bonding: limit BOND_MODE_8023AD to Ethernet devices

stable/5.10 was fixed.

Fixed status
stable/5.10: [19266182b82e9100c799d8a29f5e0452f0bf7703]

CVE-2026-23247: tcp: secure_seq: add back ports to TS offset

stable/6.12 was fixed.

Fixed status
stable/6.12: [5da5662181ef8a251e3ba564903002c2e87de452]

CVE-2026-23310: bpf/bonding: reject vlan+srcmac xmit_hash_policy
change when XDP is loaded

stable/6.1 was fixed.

Fixed status
stable/6.1: [0a80e6ecaf669c77260b44254f4a84d76bf83e89]

CVE-2026-23346: arm64: io: Extract user memory type in ioremap_prot()

stable/6.6 was fixed.

Fixed status
stable/6.6: [64858b76ec67c5fc40fef8ec1841fecb78c1ebde]

CVE-2026-23364: ksmbd: Compare MACs in constant time

stable/5.15 was fixed.

Fixed status
stable/5.15: [8a665d733940592e671ec6afadcd0be80a091a80]

CVE-2026-31402: nfsd: fix heap overflow in NFSv4.0 LOCK replay cache

stable/5.15 was fixed.

Fixed status
stable/5.15: [2665887a69437a8a4f552f69509eecfb73d4aa19]

CVE-2026-31419: net: bonding: fix use-after-free in bond_xmit_broadcast()

stable/6.6 was fixed.

Fixed status
stable/6.6: [2de5c8eea0a9db99dae7c36f4b541b74b41d3a04]

CVE-2026-31432: ksmbd: fix OOB write in QUERY_INFO for compound requests

stable/6.6 was fixed.

Fixed status
stable/6.6: [850452af77f55d185f9445e1f7a1db53c5e4aad4]

CVE-2026-31449: ext4: validate p_idx bounds in ext4_ext_correct_indexes

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [39d6e2b67651614bac0dc6592fa9836321910067]
stable/5.15: [c5839b34704c9c2f47f079451bdbb22de0da1ed1]

CVE-2026-31486: hwmon: (pmbus/core) Protect regulator operations with mutex

stable/6.6 was fixed.

Fixed status
stable/6.6: [b26849cffaa7c43355b82e9bef3725e786973a1a]

CVE-2026-31489: spi: meson-spicc: Fix double-put in remove path

stable/5.10 was fixed.

Fixed status
stable/5.10: [01f5f7976c24d6e9beef6b5a410af3b9b1d4d476]

CVE-2026-31663: xfrm: hold dev ref until after transport_finish NF_HOOK

stable/6.12 was fixed.

Fixed status
stable/6.12: [4236c30b437b80f673b9e08c8fae38b8d471ac9e]

CVE-2026-31700: net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [0f4c9754956b86de158a4af5278c5cf5bda9439e]
stable/5.15: [714aa973da8163925eda7efd49361ccbee21ee46]
stable/6.1: [1490f82353bdabc09265a74e645b07f05cf4188e]

CVE-2026-31703: writeback: Fix use after free in inode_switch_wbs_work_fn()

stable/6.12 was fixed.

Fixed status
stable/6.12: [156cc63691c1f20905510b1007896e090355e6c2]

CVE-2026-31708: smb: client: fix OOB read in smb2_ioctl_query_info
QUERY_INFO path

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [e66bdc0704977ecee667a81d38255b579c2353d0]
stable/5.15: [9e203dbb5402897c43130fb171a2617008a91f45]

CVE-2026-31709: smb: client: validate the whole DACL before rewriting
it in cifsacl

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [b8603d9ae6c9087662b098619996bc4a8064319d]
stable/6.1: [c2abdebf72000a64603ced84d36ccbd164f11391]

CVE-2026-31711: smb: server: fix active_num_conn leak on transport
allocation failure

stable/5.15 was fixed.

Fixed status
stable/5.15: [dc2e7d595d68cf1be1ba64e3d30ebf3266bf7242]

CVE-2026-31712: ksmbd: require minimum ACE size in smb_check_perm_dacl()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [282cbbb476b9f35793452bc461934af4c7eca169]
stable/6.1: [f20adc4ef7428bc485ee83fd1a592252fb87718b]

CVE-2026-31715: f2fs: fix UAF caused by decrementing sbi->nr_pages[]
in f2fs_write_end_io()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [7dbdab4430e4654db9aacef12b9b3b8b29ca25cb]
stable/5.15: [ffb94770dbdfb5411be5d9f44a960b010ec890ad]
stable/6.1: [0d40b26377f891e6dcb6efaf8ef9374c99be1b1d]

CVE-2026-31727: usb: gadget: u_ether: Fix NULL pointer deref in eth_get_drvinfo

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [f9f987472f4b8ab177be2b6492a59278ed969479]
stable/6.6: [7fce959e9be3bf63bb0fdf4b05f9cc42cb289fe2]

CVE-2026-43019: Bluetooth: hci_conn: fix potential UAF in set_cig_params_sync

stable/6.6 was fixed.

Fixed status
stable/6.6: [7502c1cf303b69f71d085f5ff7251b0e1b0f09df]

CVE-2026-43052: wifi: mac80211: check tdls flag in ieee80211_tdls_oper

stable/5.10 was fixed.

Fixed status
stable/5.10: [e602246235fc2ef06c39b2e9cf147d84d0896b73]

CVE-2026-43064: dmaengine: idxd: Fix not releasing workqueue on .release()

stable/5.15 was fixed.

Fixed status
stable/5.15: [70ae35be58d476e2fd9f7a941a5e03b2f5fadb8d]

CVE-2026-43088: net: af_key: zero aligned sockaddr tail in PF_KEY exports

stable/6.6 was fixed.

Fixed status
stable/6.6: [3c19cb8a84ef709d57943bd6664cf31cb91ba6ec]

CVE-2026-43116: netfilter: ctnetlink: ensure safe access to master conntrack

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [9e1196d27ef496f404c76f7a9d03761142d991c4]
stable/6.12: [d52fa1fa7440676b8c238037a050ab008c22737f]
stable/6.6: [5e1c1d22268ae710c238342c8030c21daf298168]

CVE-2026-43129: ima: verify the previous kernel's IMA buffer lies in
addressable RAM

stable/6.6 was fixed.

Fixed status
stable/6.6: [43308106a1762b72f3b20a44b75b2df5cb25b77b]

CVE-2026-43219: net: cpsw_new: Fix potential unregister of netdev that
has not been registered yet

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [d31a12cee10bbc12b4b523a4709fd1fdee8b7d0f]
stable/6.1: [23acc565186ee27e788408cbd81b92730b6aaa3a]
stable/6.6: [67cca9df4d17f2c824655d31195b2e75334ae286]

CVE-2026-43303: mm/page_alloc: clear page->private in free_pages_prepare()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [e7790ab165713b79b1617ce659742ceb3a859d05]
stable/6.6: [3edb8ebbf79b9016040e8f3421d723ae3d542b32]

CVE-2026-43311: soc/tegra: pmc: Fix unsafe generic_handle_irq() call

stable/6.6 was fixed.

Fixed status
stable/6.6: [d1c9c79eb06ed7c4e0a090ba5b1d4e475f7d0681]

CVE-2026-43331: x86/kexec: Disable KCOV instrumentation after load_segments()

stable/6.6 was fixed.

Fixed status
stable/6.6: [0e96cd314c0d819c1635d68125a4d77852c2162e]

CVE-2026-43341: net/ipv6: ioam6: prevent schema length wraparound in trace fill

stable/5.15 was fixed.

Fixed status
stable/5.15: [d3a1fb2ca323d7a4e10ab3afbfa25e6d8921e4f2]

CVE-2026-43350: smb: client: require a full NFS mode SID before
reading mode bits

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [23b54d6cc3ef30a51d984dc74364f24039ae2ecb]
stable/5.15: [1592a6cd6f653f2d24572a6976c7a775b19f4940]

CVE-2026-43383: net/tcp-md5: Fix MAC comparison to be constant-time

stable/5.15 was fixed.

Fixed status
stable/5.15: [ff44ec94d4fc8348600a69de0a8fa1102c23bce8]

CVE-2026-43421: usb: gadget: f_ncm: Fix net_device lifecycle with device_move

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [7c97366f5dac5255e60a317ffe3a5b18f3745547]
stable/6.6: [36c41e9724c9a7a7cda37f5a4e9d94f25c8031c4]

CVE-2026-43492: lib/crypto: mpi: Fix integer underflow in
mpi_read_raw_from_sgl()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a1793a48881ec8d26e9c79b0ee65753f1c6846a4]
stable/5.15: [1abd50fc3cfa16fc2074a3c8c2729c50fd9d7043]
stable/6.1: [6d63615c796c085b4984e3031b9fa77fffb47360]

CVE-2026-43495: net: wwan: t7xx: validate port_count against message
length in t7xx_port_enum_msg_handler

stable/6.1 was fixed.

Fixed status
stable/6.1: [307c5d0f36a5c74042217136da5bfbd9f7504650]

CVE-2026-45850: ipvs: skip ipv6 extension headers for csum checks

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.18,
stable/6.6 were fixed.

Fixed status
stable/5.10: [0bf92a90bf05ecafe52e92d5bc15a585021a64ac]
stable/5.15: [54add3b7d3c154ca89ef5bac2582b0ed1a3a15d5]
stable/6.1: [768f665f3685b455ed686370ed7ccb852a125a3b]
stable/6.12: [d643c1ec80b70508f54dac12179e36920e2c00de]
stable/6.18: [cdce1e797addab72393c0dfee31aaca41ef7d937]
stable/6.6: [9aa7edc1347b98774e5167ca34e5b8aa6083bde7]

CVE-2026-45930: net: mctp: ensure our nlmsg responses are initialised

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [b37da3ac099e145bcd3be82c745a8d335772e3af]
stable/6.1: [c4f840437e7641764de15f2de951ac8335d641f1]
stable/6.6: [963537a26fd892f7e414a091f807b44aeee97a7d]

CVE-2026-45991: udf: fix partition descriptor append bookkeeping

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ad3c0c4400686f6f37b382aaa48fac2b9aefccbe]
stable/5.15: [68013a9bd4c01acd42073715f00e1a1992f089ee]
stable/6.1: [e8474cfbac9ada2cdaa4eaedec22aadfa0f58559]

CVE-2026-45993: LoongArch: Add spectre boundry for syscall dispatch table

stable/6.1 was fixed.

Fixed status
stable/6.1: [c8a8e863928424046b8fd328f02c359baa0a0c3f]

CVE-2026-45996: spi: imx: fix use-after-free on unbind

stable/6.1 was fixed.

Fixed status
stable/6.1: [c7c40c3e7b9fb900504aa746de3e53c5275b24bd]

CVE-2026-45999: erofs: fix unsigned underflow in z_erofs_lz4_handle_overlap()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [778acd52e9497806fbd2cea7f770c41d6850fc48]
stable/6.1: [118ff71ff09ebaf323a09af9e911517321a299f4]

CVE-2026-46003: net: qrtr: ns: Limit the total number of nodes

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b703ee903b24974aca4bde99c7d25d66309d35dd]
stable/5.15: [823310645065bd49666e84af689fa95192819f55]
stable/6.1: [ed29887286aba96d1930f4ddb9f235f6b421073c]

CVE-2026-46005: xfs: fix a resource leak in xfs_alloc_buftarg()

stable/6.1 was fixed.

Fixed status
stable/6.1: [ed2d6442e61169e565727ba15c4f6a0cb5ce16df]

CVE-2026-46006: drm/nouveau: fix u32 overflow in pushbuf reloc bounds check

stable/5.10 was fixed.

Fixed status
stable/5.10: [3429275684f4bad42876955301f3c5c814aae909]

CVE-2026-46021: thermal: core: Fix thermal zone governor cleanup issues

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a172fa18bc370b776ac1510abb0dcb50a7a35fac]
stable/5.15: [8e563d8db50f303171aceb79eec0807e7ba06951]
stable/6.1: [d4eb861adde5ce22e459fbd29366f47bb2167977]

CVE-2026-46026: net: qrtr: ns: Limit the maximum number of lookups

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [bd69e0e8a7643ba5385f19f479e8e3da71f8d495]
stable/5.15: [91cb30b6bb1880ba0748ca059bef50b8ac13793d]
stable/6.1: [6e3675251fcea06caecc61eb76462467558adfa6]

CVE-2026-46038: net: qrtr: ns: Free the node during ctrl_cmd_bye()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6c9cca46acb6f22e63f015ea7b2ed6032d2badf5]
stable/5.15: [a5a454f3364877b22f0e5a165df8b3702ff96ae7]
stable/6.1: [25d580a46b079a7963ff024a5195e547baf12b64]

CVE-2026-46044: ipmi:ssif: Clean up kthread on errors

stable/6.1 was fixed.

Fixed status
stable/6.1: [e662be2d0d05253d0fd7deda9771aa036c23393e]

CVE-2026-46052: ceph: only d_add() negative dentries when they are unhashed

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [4147ae08824cc8b65d2b2018f79d416af2937108]
stable/5.15: [73b47a1f06dee5e61b00dee5227d75d3f1f6d977]
stable/6.1: [79ffcbeac6bc1dc1bcdb0434acf250f6215ec111]

CVE-2026-46056: Bluetooth: hci_event: fix potential UAF in SSP passkey handlers

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [ea18732d2614557e59f4c0d8cdbe6611aeab33b7]
stable/5.15: [d28311539ac9f65e29308ea219ecaa48aa5e76e5]

CVE-2026-46065: fbdev: defio: Disconnect deferred I/O from the
lifetime of struct fb_info

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [4aab89603b637a2e441b38808c4f6fe7d1184df6]
stable/6.1: [4fda0d6b45faad44926dd3e4f55f118d899b2e27]

CVE-2026-46069: wifi: mwifiex: fix use-after-free in mwifiex_adapter_cleanup()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c3508895450cca4aeaf5dbadbb5e582363005264]
stable/5.15: [1958a92599b2653d730ccb6f5685fc3fbed21812]
stable/6.1: [a88f5391dc68f78cae5eb6a8cd341cafee795d3d]

CVE-2026-46078: erofs: fix the out-of-bounds nameoff handling for
trailing dirents

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [a8ee527807f7d97e55ce2ef2906f7f34975eb1c7]
stable/5.15: [aa16dca1b062355181ef215229eeac249d7c0d61]

CVE-2026-46083: spi: fix resource leaks on device setup failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [e0401de43dac00f3e4841ca2aeb98bc10a4c5f13]

CVE-2026-46086: net: bridge: use a stable FDB dst snapshot in RCU readers

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c502fa9f094cb03d1d1685c71e2105ab359bc2b8]
stable/5.15: [a6ae4511c07b91f597e461406c6330f0d4ff810e]
stable/6.1: [1406c4e0ed1eaf8a29801ab1163d00fb7ee4359a]

CVE-2026-46090: ALSA: aloop: Fix peer runtime UAF during format-change stop

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [83bd62fa9620ac98d5d694bde14c50f98c8e7189]
stable/5.15: [345c24b2bcf0923dfae1ab41497351c68214ff76]

CVE-2026-46091: media: rc: igorplugusb: heed coherency rules

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [bc04b8633b375af6ac8a8bb615258b80fe06cdaa]
stable/5.15: [81f0fb813e4bf28b3ca28dc218938a32eb48f740]
stable/6.1: [0e84aa8fc23c7578f105e3a2160f9d0aa2bed79a]

CVE-2026-46092: wifi: rtw88: check for PCI upstream bridge existence

stable/5.15 was fixed.

Fixed status
stable/5.15: [959c13da6c36167ce1016d400a6104d2367f686e]

CVE-2026-46103: can: ucan: fix devres lifetime

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [a90f0815aaa9c629ac4750e7c71c357dd7f231d7]
stable/5.15: [cb2e41e87a2893345859440017e7178bf7a4c70d]

CVE-2026-46107: dm-thin: fix metadata refcount underflow

stable/5.10 was fixed.

Fixed status
stable/5.10: [b719d12cb94df345e9ad2715fd0abe9afcaeb111]

CVE-2026-46110: net: stmmac: Prevent NULL deref when RX memory exhausted

stable/6.1 was fixed.

Fixed status
stable/6.1: [fdeb95b1fc7de25c9362990efb9996a8d761055c]

CVE-2026-46116: xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [3943fcad7694a7d0b15aeabe7d3cc2a2eb8e92e8]
stable/6.1: [2c617848ae6e4f07a3e397f604208c293bbecacc]

CVE-2026-46125: wifi: mac80211: remove station if connection prep fails

stable/6.1 was fixed.

Fixed status
stable/6.1: [18fed0a209500bfea5c4c08609ec93855e4e500b]

CVE-2026-46137: mptcp: pm: ADD_ADDR rtx: fix potential data-race

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d9b272a85fe6b8f993e37915311e4038c814a533]
stable/5.15: [23079e0b7742ec114d3507c3e3aad01b7b69e4af]
stable/6.1: [b35605e1f1e877038c8c9d499babbc891cdd234f]

CVE-2026-46159: btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU
which can lead to info-leak

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [f407aad350bdea4db300c47433573b7a41630d33]
stable/5.15: [d8224b1be6627c6c3b204bfb264508d27c65ac44]
stable/6.1: [d69a4a6813fdba7c4cc3695a7e843842b240790d]

CVE-2026-46160: btrfs: fix missing last_unlink_trans update when
removing a directory

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [af467162290f5fe79d6a361b7c84302e45b1fd9f]
stable/5.15: [2525998ac956476bded26b9f34c4164dc890b87a]
stable/6.1: [6acbb2f6dff23c9bb9761fb98b516525b9cf1ce9]

CVE-2026-46164: btrfs: fix double free in
create_space_info_sub_group() error path

stable/6.1 was fixed.

Fixed status
stable/6.1: [c2d59527cba6d59f0d77a75c1101ab4e69758bea]

CVE-2026-46169: hfsplus: fix uninit-value by validating catalog record size

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3003dbf62d151d47a6b90f71655292a51a05f244]
stable/5.15: [8be69532e399eec9d9d990f6958b4ff2383b19b3]
stable/6.1: [3bc337697c66db2e2a4a94f0509c282c1a014b86]

CVE-2026-46180: wifi: brcmfmac: Fix potential use-after-free issue
when stopping watchdog task

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a21f735fb1017ef89c6f9dbf4d799513b4e7bd5a]
stable/5.15: [df2e90d6a9955510f24f1dada78cfc439fd9fa88]
stable/6.1: [d616bb10de79e5c2bd8a24230a1128aeaf715615]

CVE-2026-46190: mtd: spi-nor: debugfs: fix out-of-bounds read in
spi_nor_params_show()

stable/6.1 was fixed.

Fixed status
stable/6.1: [231b8e1f604f6e0a7e100536f506cdf482e2c5f5]

CVE-2026-46191: fbcon: Avoid OOB font access if console rotation fails

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b51c343a81e6e806525a4435e22532c107dd7e9d]
stable/5.15: [46cf3646dea54baeaa2eafe3fb1ba769947f31b0]
stable/6.1: [524a6079395916fb3d790ef2bb46a1d2939b27dd]

CVE-2026-46193: xfrm: ah: account for ESN high bits in async callbacks

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [ec406c26c97594124e79d14516b729a8d5dced62]
stable/6.1: [1dae77078ceb4bab833f7a4935f05c5b8c97b9ba]

CVE-2026-46195: smb: client: validate dacloffset before building DACL pointers

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [5de2665e913a10ad70aaeecf736b97276e83d995]
stable/6.1: [f9dc3be8f403c1216df73e57221f44b045e7ee0b]

CVE-2026-46196: tracepoint: balance regfunc() on func_add() failure in
tracepoint_add_func()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [5787052e5f69beb649f3d6a80a8aa37d9e683e4e]
stable/5.15: [4f1756d043e56ea2e9a6c858fb290a0cf6fc2251]
stable/6.1: [36ff362235307af95152d510b53c2d9b8773a342]

CVE-2026-46203: spi: cadence-quadspi: fix unclocked access on unbind

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [2e7cd62c37f51823c2bb79de1d4d76d0c1678c7e]
stable/6.18: [63a9f6012f453578898c9fcc13c8452a8651104e]

CVE-2026-46208: batman-adv: stop tp_meter sessions during mesh teardown

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [5e7d0ac936354c36810e74ac3056b334ed1f4058]
stable/5.15: [268078acae72daa12b17b2b299701cb9924e469a]
stable/6.1: [58943b7ea356294749dae3e75b96c0ee292c00be]

CVE-2026-46280: lib: test_hmm: evict device pages on file close to
avoid use-after-free

stable/6.1 was fixed.

Fixed status
stable/6.1: [234071b4318feaeb27cd2e4e1b16ef6b055adf89]

CVE-2026-46291: crypto: caam - guard HMAC key hex dumps in hash_digest_key

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e8e72fdf47bd5ef7abe642b034c6178a61a8580a]
stable/5.15: [cd849c07b8d706425e60a4dfcef54b7b67c967ce]
stable/6.1: [a9207798fe619cbc85c8744a9b9e2af1db2b6e1a]

CVE-2026-46292: pmdomain: core: Fix detach procedure for virtual
devices in genpd

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e8f8dad44f024a5c99e54a48ad5c943fa8e54319]
stable/5.15: [98b8104978474d381256a2b2fb0e7ca8e05a7bfa]
stable/6.1: [52e485ed0dcb5496864003ba9ffcef7d5b613f83]

CVE-2026-46296: spi: s3c64xx: fix NULL-deref on driver unbind

stable/6.1 was fixed.

Fixed status
stable/6.1: [29e219a18e21258bdb4ee12cecd0e9ec87d7e6a7]

CVE-2026-46299: hfsplus: fix held lock freed on hfsplus_fill_super()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e890656accee4c26d932ea388eb8936a6e22184d]
stable/5.15: [6499c9c8ec437a369e7e221dad91f6122b50759d]
stable/6.1: [c554ddc87af4d4e4be42f8aed1baec9e1c7588e0]

CVE-2026-46314: drm/v3d: Reject empty multisync extension to prevent
infinite loop

stable/6.1 was fixed.

Fixed status
stable/6.1: [309abbddeca0c12714721928a819ef45e5710998]

CVE-2026-46320: tap: free page on error paths in tap_get_user_xdp()

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.18,
stable/6.6 were fixed.

Fixed status
stable/5.10: [8d03e65eb6cfbffec471a6b65416f93679bf3286]
stable/5.15: [f979971835dddbca86cf99e3b2e2b94a408a1ab2]
stable/6.1: [3f52a86a482a69294c50a5a2a097bd6f4104990a]
stable/6.12: [d68eab61944a9b0826fa2e954e42db1aa3201b7a]
stable/6.18: [e27c17346628cb56843a83f93ac63c314c00f388]
stable/6.6: [d30aac0fa00ca0afc3e08174cf7f974a66bdcf05]

CVE-2026-46321: tun: free page on short-frame rejection in tun_xdp_one()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [0a6f46a9332ad6958992d64d3b3a81a80b2ca940]
stable/5.15: [0e8211fcf9426f5adddf32516ba0f400ceb9544d]
stable/6.1: [e915445942af6dcea628bf66d6241641201a0c41]
stable/6.6: [5b34f9e4fe2f203724a6e893d6df0316b9670057]

CVE-2026-46322: tun: free page on build_skb failure in tun_xdp_one()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [26fe549b5192536b6c1c68a2dfdc8c0dcf9fa4a9]
stable/5.15: [793385c154771603b8671dd8338927221e9d8d78]
stable/6.1: [2638a9c1521905bb5c5d1e95c8fbc09f79148ed7]
stable/6.6: [60d9c0d6cdde5420d6483c921b16fe5465eb5238]

CVE-2026-46323: net: gro: don't merge zcopy skbs

stable/6.1 was fixed.

Fixed status
stable/6.1: [3c6cc9f2ca65b6dd61b1af75452dc0e1cd0aad8d]

CVE-2026-46331: net/sched: fix pedit partial COW leading to page cache
corruption

stable/6.12, stable/6.18, stable/7.0 were fixed.

Fixed status
stable/6.12: [2bec122b9fb91507a758ab5e3e5c4fbe7cb3f61b]
stable/6.18: [b198ed4e52580a7238c7c7082f03906f8b310313]
stable/7.0: [3dee9d0c198faeb95d052c1b94c2958751a28512]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

