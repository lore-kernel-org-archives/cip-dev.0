Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9910BCD98C7
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 22:15:08 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32933.1781129700117012106
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Jun 2026 15:15:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=G13GO5Hm;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.174, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7dc6fbf3e86so78924217b3.3
        for <cip-dev@lists.cip-project.org>; Wed, 10 Jun 2026 15:15:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781129699; cv=none;
        d=google.com; s=arc-20240605;
        b=AFHMETYL6AL6Ywc+q6xrajA8EQT4dqDVWyXmA4wehzSzS3JU5S7LM4WWhtuzMbWXEN
         6qZ1Bi+KpL2/5KECO/SKp9mtEt96o81G/tdakTjC+8foALlOdXqscixT+xnaKkm3qGvn
         Zm4h18t7QdRrSCzK+C7Y+BqJPbKE78bEbCvMzxRXgez6QdYWVZQXWNbnICHDnwH0T5ao
         NyJimSGN9pR2iEMMadiisNcJ4dlLYI3KkdX1Dgsa71AOuPSWZ8UZxDNkjJXQj+3Q7Udo
         DUkXOkqBsIKYoM6B5Sdr6KYNwlHx08CUUSB4difxQHEgy84a/bQsmPjAB+6rySVEVS0Z
         nW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=wEW/NwoVenGONgNN7HpY5BGsRHTLNoA284HiDd+Xkv8=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=MCSIjVgo9BO4Aw0CpC8i1d1xUQNpg3SuKa2K062mG9ARTSpecE9NuKvi/vPmJtdqw1
         ENFR8l4ugsWcO1naqZUj8kYymUJlPM/C+M2tycqXJziKGwmxTSL4P6xSgRMH6cY5lnUL
         U4oMWTSIcsHGSPe8xe2ZvrJHflHqCckYkWRUhgLmvyF6rosJnJdDwuvpH3/nNZK/nKGb
         h6I1AOvuBEdri4yxAHAHWfF6AMYjQNqbnaG8vBVam+EZn/XUKGi4dHSJzNXF6F7n5LkY
         zrxBn1dh7ezin62ByYS7Dd89jXe0MHuw5hiNl8qO8U6T1a5Y3lyJZfPk3RWwMhHfTkbf
         bpqQ==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1781129699; x=1781734499; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wEW/NwoVenGONgNN7HpY5BGsRHTLNoA284HiDd+Xkv8=;
        b=G13GO5HmWwIP3a5l40SqTP0IoBB0Fuk8WAK6qMiBzEzXW/iJ5lEV/siyUW4fnIob7p
         Li9SexjX9GIlk5NWkE4gvpCL438lPE6C9FK5eJMh7PjnGPPgb6U7eS1cDPqviQepNRQv
         EGo8mNiqiTKEpRaTal2zPVXdHh5Zx3v8E2Ia5qAyhidkCxoicJlfrLek4W+QM32NpIXt
         E2kmAsI4zSHg+Wa1t214UgG6S6s46dwOQBJDW8TFozUATDTjKs3Bo5fGEYVTI3POOvUr
         sue0I7E6tWTZ0RbOmiMtIkojZR8u5EHS/W4mkvlaUpnRoNdt9bNYjqUe1guBfH8Wtnd4
         CEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781129699; x=1781734499;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEW/NwoVenGONgNN7HpY5BGsRHTLNoA284HiDd+Xkv8=;
        b=YcTHck8ht0zU1AQDFtMS+WpyDELmn5+bqxB88/bDOE9awrIs7/fKcyR4s7V7RLH+b+
         xZvgKq9JHtUHrOE4ScmRodDf7j607SR9o374qu0CNsoYBs3SGelX3PhZCXIoMJEsRQbC
         DDeCg2xvk2c55FUbo1EdSQ5OeqAu2D77wAAbkaRFdrlmnbTdjO9R4Nvbpg1MVAwdcn7y
         WJ9lGoDeYPLIfJmqzvoYrKEpe87OGTDmZ6pxiIkVDYJPKxizKUPmpaGPb8pQ+izPb6o0
         Ec3fVTLcD7n6IjibGj3FcYoQuXTjQ2hKd3SiFMSLJU0HIf0WkJfKFwqKc0mcM5DzCexh
         NPVQ==
X-Gm-Message-State: AOJu0Yz3Pd5fNiUF+BGIH11GykHuEajnETnQPwKg1WrdNLq7B7OXnmFk
	FZtmeAbzU0JgPKCjQQU1YVbvAGi6xxh+9MaJu1QF2x6sUY0dmR156+wVaBVDOo72W61dYds3GWc
	KqqMO8HfftZL7hL2PmFwQmP8QjUbC7blkJHcHzavg7ukDxeI9z/KDnX7g2Q==
X-Gm-Gg: Acq92OFeZUj9s3NS03W2U5gHS6ap7KryH/xURkFpATvbM5J9jHHf7alEMvvIZqjO9ee
	ZAfyIXtnyP5vt9h5vcQ4Q/TFT4EKxwxcnxBDt268xN8kQ5wp+wgh2aHVqXGS2bFyTL7/t8Y3oTp
	g5FJEYUVen0ZY/ycU0ApB0gTjIEBrho/A7HFSGzO9zfEefN5s3D75Bn5zb+cHlKbMALFMm0s9tK
	eQJZwwNeKhTFYfSE6SBeoo3RqgAsy2npKxdyoLQ/Cq6vXfK1VnKKWG8NeIe50ePOkOpY7fNPdtd
	ELquEgDV85GgKl1uig8=
X-Received: by 2002:a05:690c:a08e:20b0:7d0:ae60:de9f with SMTP id
 00721157ae682-7f657677957mr1587327b3.30.1781129698080; Wed, 10 Jun 2026
 15:14:58 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 11 Jun 2026 07:14:22 +0900
X-Gm-Features: AVVi8CdwnO3PXsPstSYqtWMTp4NLl0aDzS40RC8ED6QRKdX8JWarRFW7UPX3MLM
Message-ID: <CAODzB9pnPRDOgXDEJqgT5YB+BeU4MYjCpOLcsxcr1RggVpuKvA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Jun 2026 22:15:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23055

Hi!

It's this week's CVE report.

This week reported 63 new CVEs and 7 updated CVEs.

* New CVEs
CVE-2025-54518: Improper isolation of shared resources within the CPU
operation cache on Zen 2-based products.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-54518

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.19-st: [3461f705cfdf325386297a27e46094efe20f0896]
mainline: [c21b90f77687075115d989e53a8ec5e2bb427ab1]
stable/5.10: [1e23b30a80b14e5764657401ee2cca030525ae8e]
stable/5.15: [f5bc3aef7df46eaaf423d7413ab8833f704ae576]
stable/6.1: [251497955f2314cd39d43191e81c6151dead4c7b]
stable/6.12: [9109489cc8c34e50d15575a3d1ff82af586bc1aa]
stable/6.18: [28f5ed477eef166d678d6966762cbc1de9b4f436]
stable/6.6: [ff6fc65b3bf73acc5ee71919154d830ad5431362]
stable/7.0: [1cd85a19748b2407830376a5cbae5c0f126016e5]

CVE-2025-71315: drm/vkms: Convert to DRM's vblank timer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71315

According to the .vulnerable file, this bug was introduced by commit
3a07099 in v4.19-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [02e2681ffe1addde1fc8c35d05657b16bfa79613]
stable/6.18: [a0582cc923985c6b72fe871b5f7aa7c682bfc230]

CVE-2026-46274: io-wq: check that the predecessor is hashed in
io_wq_remove_pending()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46274

Introduced by commit 204361a ("io-wq: fix hang after cancelling
pending hashed work") in v5.9-rc3.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d6a2d7b04b5a093021a7a0e2e69e9d5237dfa8cc]
stable/6.12: [5a20ebf0c81b61f5ea3b1b529c100cad69b9f603]
stable/6.18: [252c5051dba9c709b6a72f2866f93e5e618b3f06]
stable/6.6: [d6bda9df0c0a3080804181464d5c0f4d78a4e769]
stable/7.0: [d376c131af7c7739a87ff037ed2fdb67c2542c8a]

CVE-2026-46275: Bluetooth: hci_uart: fix UAFs and race conditions in
close and init paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46275

Introduced by commit 3b79925 ("Bluetooth: hci_uart: Cancel init work
before unregistering") in v5.10-rc1.
Fixed in v7.1-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [c1bb9336ae6b54a5f6a353c4bd4ed9a4307e429b]
stable/5.10: [78aad93e938f013d9272fe0ee168f27883afa95c]
stable/5.15: [e2d19969c8d9198ecc3090bcd5312ecd503a3339]
stable/6.1: [c85cff648a2bc92322912db5f1727ad05afae7b6]
stable/6.12: [81c7a3c22a0f2808cf4ae0b4908f59763b23606d]
stable/6.18: [192cb0f1ca706d9a1bc36ae0ad5f666d1e4fd894]
stable/6.6: [9d20d48be2c4a071fb015eb09bda2cecd25daf34]
stable/7.0: [7338031946bd06f6dff149e67b60c4cd083bfea8]

CVE-2026-46276: drm/amdgpu: fix zero-size GDS range init on RDNA4

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46276

According to the .vulnerable file, this bug was introduced by commit
c832c34 in v4.20-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [095a8b0ad3c3b5cdc3850d961adb8a8f735220bb]
stable/5.10: [1f5d33e7b0a9a2a140f46e22fb52eede323c5946]
stable/5.15: [9bc925759c05feae7dfa9570e77131d54729c8ea]
stable/6.1: [36f9602fb22ede69fcc8b422be0cf8105bf655ad]
stable/6.12: [0e21db1a77967bc15df662efdca8ea8a61d124ea]
stable/6.18: [30c000a49094ec568c9b51b7421f7a4a3f0b0298]
stable/6.6: [be0376affcafa0bbb371bb501579a825eae32281]
stable/7.0: [3e26c76891ab99fa173e9c501119fbb5c9f4600f]

CVE-2026-46277: mm/zone_device: do not touch device folio after
calling ->folio_free()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46277

Introduced by commit d245f9b ("mm/zone_device: support large zone
device private folios") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39928984956037cabd304321cb8f342e47421db5]
stable/7.0: [85be0a262e39c706edb53c88af8afde2e98222ba]

CVE-2026-46278: drm/imagination: Fix segfault when updating ftrace mask

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46278

Introduced by commit a331631 ("drm/imagination: Simplify module
parameters") in v7.0-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5dfd429591f8d7185bf63a08b5c30863fb605611]
stable/7.0: [ba422758981b61585c7da6429f50ef1c58d326f7]

CVE-2026-46279: mm/alloc_tag: clear codetag for pages allocated before
page_ext initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46279

Introduced by commit dcfe378 ("lib: introduce support for page
allocation tagging") in v6.10-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b1842775a460245e97d36d3a67d0cfba7c4ff79]
stable/6.18: [d5b495ba9de0423ef39f8bd86729a885870c7efe]
stable/7.0: [b49dfabc38cad5e50af24f63edd124a10de3ebb6]

CVE-2026-46280: lib: test_hmm: evict device pages on file close to
avoid use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46280

Introduced by commit b2ef9f5 ("mm/hmm/test: add selftest driver for
HMM") in v5.8-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [744dd97752ef1076a8d8672bb0d8aa2c7abc1144]
stable/6.12: [5846715b6382dd4c6a69b35a56ca6115d33bc2a0]
stable/6.18: [38f113f81d3f0adc658a4475dd3ecaec985e21d3]
stable/6.6: [bf477abd448c76bb8ea51c9b4f63a3a17c4b6239]
stable/7.0: [9de1eb0aac2862d6144b8db0ec1388e79f8bc3e1]

CVE-2026-46281: vmalloc: fix buffer overflow in vrealloc_node_align()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46281

Introduced by commit 4c5d336 ("mm/vmalloc: allow to set node and align
in vrealloc") in v6.18-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82d1f01292d3f09bf063f829f8ab8de12b4280a1]
stable/6.18: [e9b057a44deff4c59c13f44672a5cc74dcd57522]
stable/7.0: [b281adf71f786c325eb6d6d1582d4d05313438a8]

CVE-2026-46282: iio: frequency: admv1013: fix NULL pointer dereference on str

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46282

Introduced by commit da35a7b ("iio: frequency: admv1013: add support
for ADMV1013") in v5.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aac0a51b16700b403a55b67ba495de021db78763]
stable/6.12: [3a9d8ec2051c2d80158ed7bded5e158c42870037]
stable/6.18: [5e9f1bad26df3d3afb3cbbfa408b6d6e809708ac]
stable/7.0: [2dc8d26690bf4e7226409563221c37bc095c94ff]

CVE-2026-46283: tpm: Use kfree_sensitive() to free auth session in
tpm_dev_release()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46283

Introduced by commit 699e3ef ("tpm: Add HMAC session start and end
functions") in v6.10-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c424d2664f08c77f08b4580b5f0cbaabf7c229b2]
stable/6.12: [dd3ac52ea7a001406c7dbc663aae4b9f89da679a]
stable/6.18: [53e6d2d834df40960b655b353e7a8ff4d927e1c7]
stable/7.0: [84ced03172da544c9f8c0862faad48104f519352]

CVE-2026-46284: mm/hugetlb: fix early boot crash on parameters without
'=' separator

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46284

Introduced by commit 5b47c02 ("mm/hugetlb: convert cmdline parameters
from setup to early") in v6.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c45b354911d01565156e38d7f6bc07edb51fc34c]
stable/6.18: [2774bcf714739cc6bb86f8812167bb9fbda70f6a]
stable/7.0: [357c6d084b6137ae640209c5bfd01180f985c015]

CVE-2026-46285: mtd: docg3: fix use-after-free in docg3_release()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46285

Introduced by commit c8ae3f7 ("lib/bch: Rework a little bit the
exported function names") in v5.8-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca19808bc6fac7e29420d8508df569b346b3e339]
stable/5.10: [8408655ec8344511667b61d8257dc59c80ee3391]
stable/5.15: [f5d2ed4ed47d3906e2495a3537a48b127f497a17]
stable/6.1: [2bf706fe7831b319f23a85b9728f961cfed40c3e]
stable/6.12: [16f6588a3b7a2a20d10ad9b766be74c60ba347cc]
stable/6.18: [d89044889ecd11b0c2f86663597246e9bdd25679]
stable/6.6: [d26f8c361f751c188b7ebaf8189aa0258968fd98]
stable/7.0: [d49628d63d4e6bbc8a1621afb88e5fc901611bee]

CVE-2026-46286: leds: qcom-lpg: Check for array overflow when
selecting the high resolution

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46286

According to the .vulnerable file, this bug was introduced by commit
b00d2ed in v6.4-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d45963a93c1495e9f1338fde91d0ebba8fd22474]
stable/6.12: [36ce3094dc50598f38fd961b46688cd533940efc]
stable/6.18: [438e357b3cc6cd6900df271e4bc567bfe1142281]
stable/6.6: [28a2e047d03721e0517c67ee726eaa6621c30e5f]
stable/7.0: [f67a24e75d3251ba42538738120b6b659c0dca7d]

CVE-2026-46287: net: txgbe: fix RTNL assertion warning when remove module

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46287

Introduced by commit 02b2a6f ("net: txgbe: support copper NIC with
external PHY") in v6.6-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e159f05e12cc1111a3103b99375ddf0dfd0e7d63]
stable/6.12: [3e223a7fd41ce6fffdb10577df9350385262bf33]
stable/6.18: [d29cafc7e4ee9e28a150ba17e9a565ec5d881fbc]
stable/6.6: [0305e7118451c7c363c18f8113b0d8e0077ffa4c]
stable/7.0: [6c5ec52c68a6a442c8a159615ae092512562318a]

CVE-2026-46288: of: unittest: fix use-after-free in of_unittest_changeset()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46288

Introduced by commit 1c668ea ("of: unittest: Use
of_property_present()") in v6.12-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [faecdd423c27f0d6090156a435ba9dbbac0eaddb]
stable/6.12: [37318d1a27c9cc5a70d3cd7e49e30ec86f2b8ca1]
stable/6.18: [7f0f0926f3010b10cff5e93446258f971e42f2fd]
stable/7.0: [6fdad20b7975bdc32e85b45f8f7c640f6687b81f]

CVE-2026-46289: lib/scatterlist: fix length calculations in extract_kvec_to_sg

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46289

Introduced by commit 0185846 ("netfs: Add a function to extract an
iterator into a scatterlist") in v6.3-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07b7d66e65d9cfe6b9c2c34aa22cfcaac37a5c45]
stable/6.12: [e5e22fc9963469e678c4f4bb38d26adcec107f1e]
stable/6.18: [8fbba6829057979149d1b37d65690c037f3ddf4d]
stable/6.6: [3f17500e86d730c76db638bb3ae52f9b5e496c76]
stable/7.0: [9d38756d0a93b66163554219fa9c3365f40c4035]

CVE-2026-46290: x86/efi: Fix graceful fault handling after FPU softirq changes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46290

Introduced by commit d021985 ("x86/fpu: Improve crypto performance by
making kernel-mode FPU reliably usable in softirqs") in v6.15-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [088f65e206087bf903743bd18417261d7a4c9644]
stable/6.18: [22b365ba1af3d8c6036b8e5112fffe80998b85a0]
stable/7.0: [db155b86d1523e85941f61efd7d7ffb594cc9a29]

CVE-2026-46291: crypto: caam - guard HMAC key hex dumps in hash_digest_key

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46291

Introduced by commit 045e367 ("crypto: caam - ahash hmac support") in v3.6-rc1.
Introduced by commit 3f16f6c ("crypto: caam/qi2 - add support for
ahash algorithms") in v4.20-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [177730a273b18e195263ed953853273e901b5064]
stable/6.12: [c7e52fe3f7901ccb9cd29b3f7c683d809ba87e48]
stable/6.18: [5cffe3c136891aa4d579bf5c079a68f7cb371b0c]
stable/6.6: [2adbfca7452eeac45117b8e803288a2767f7075f]
stable/7.0: [b8f12d9b00c1950779e5679b9c13908584682bb6]

CVE-2026-46292: pmdomain: core: Fix detach procedure for virtual
devices in genpd

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46292

Introduced by commit 3c095f3 ("PM / Domains: Add support for multi PM
domains per device to genpd") in v4.18-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26735dfdd8930d9ef1fa92e590a9bf77726efdf6]
stable/6.12: [361518a26e4434e879db6ff43bf364795dcbfbff]
stable/6.18: [51a7dd9cbae9210335ce398642ecaaa52c939eb5]
stable/6.6: [707cb5df3eab32ddc52979418f7ace62941e6381]
stable/7.0: [8d44391a7f29e4601e8243f13498d0219bab2576]

CVE-2026-46293: clk: microchip: mpfs-ccc: fix out of bounds access
during output registration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46293

Introduced by commit d39fb17 ("clk: microchip: add PolarFire SoC
fabric clock support") in v6.1-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f7ae8ab6aa73daaf080d5332110357c29df9c36]
stable/6.1: [9ed9b580a814773482c0a4f1be045636e68cc109]
stable/6.12: [dbfcb09656cb30439577325c9dea2250203c2e3c]
stable/6.18: [a0780aeea166a7cf4706c45af4cadbb2a43a1fc9]
stable/6.6: [47bc7a03449c39805bc2665d3e57c73195d5bcf8]
stable/7.0: [f24efd415455b98a1f1cfc6071fe6fde71986706]

CVE-2026-46294: dm: fix a buffer overflow in ioctl processing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46294

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2fa49cc884f6496a915c35621ba4da35649bf159]
stable/5.10: [c8c5311237448f6ffeecc9aec2362e3692623668]
stable/5.15: [448ee8fb79c26a26599ffa4b2adeb4322d3d3d8c]
stable/6.1: [526ff9126a0ae087b65726e1faf31114c718020d]
stable/6.12: [d271631023cbe1cbe7c31a0275ab797883be6e0a]
stable/6.18: [5af6a879e915ae7bcd83695c316ebb32e1c61bc2]
stable/6.6: [f0b0b09d9840838ae77ccdd6a62de0daef4e6e0a]
stable/7.0: [8daa6c708ef524089ae43f2aed9190acb26d7df8]

CVE-2026-46295: KVM: x86: Do IRR scan in __kvm_apic_update_irr even if
PIR is empty

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46295

Introduced by commit b41f863 ("KVM: VMX: Isolate pure loads from
atomic XCHG when processing PIR") in v6.16-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33fd0ccd2590b470b65adcca288615ad3b5e3e06]
stable/6.18: [bb1703949dcaa9a49c338dee075f659f4634214d]
stable/7.0: [4b6b06a8b12bfd95f9015074b1430c1480908073]

CVE-2026-46296: spi: s3c64xx: fix NULL-deref on driver unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46296

Introduced by commit f52b03c ("spi: s3c64xx: requests spi-dma channel
only during data transfer") in v6.0-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45daacbead8a009844bd5dba6cfa731332184d17]
stable/6.12: [323a258f4b1916b5a3098618e036e033b2f2317f]
stable/6.18: [1b66f16a571a10ba8889ac471755c8af9c5b9266]
stable/6.6: [1108b8722b9ff0cdd3e8aa18d98244fcd93b6760]
stable/7.0: [22788b1a8611380b141e09a8896702e32d164238]

CVE-2026-46297: net: libwx: use request_irq for VF misc interrupt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46297

Introduced by commit eb4898f ("net: libwx: add wangxun vf common api")
in v6.17-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a33345153eeeda195c55f15be27074e4c3b5109]
stable/6.18: [1bca036fe3607182c21f05e2b262167edbef086c]
stable/7.0: [a841574c6e573132681aa57f9b43a0a897a423f6]

CVE-2026-46298: pseries/papr-hvpipe: Fix race with interrupt handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46298

Introduced by commit 814ef09 ("powerpc/pseries: Add papr-hvpipe char
driver for HVPIPE interfaces") in v6.18-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a4f0846ee6cc8cf44ae0046ed42e3259d1dd45b]
stable/6.18: [6542e180fa6e1c701aba446a555c65556e6fd1a5]
stable/7.0: [342c966f81cfc3cb6c297e80b37a9f3a5d637d2c]

CVE-2026-46299: hfsplus: fix held lock freed on hfsplus_fill_super()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46299

Introduced by commit 89ac9b4 ("hfsplus: fix longname handling") in v3.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90c500e4fd83fa33c09bc7ee23b6d9cc487ac733]
stable/6.12: [041acda6d9f96006703466449c10c9a69590c8b9]
stable/6.18: [d309d3308de658d87c42d97e044c89a226327526]
stable/6.6: [3ca80e3012c8be85b4f8d0d20eac8d3b17ff257e]
stable/7.0: [bfbcce6a7b0552a390620d9b2c4d2bcb1825cbdc]

CVE-2026-46301: spi: topcliff-pch: fix use-after-free on unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46301

Introduced by commit c37f3c2 ("spi/topcliff_pch: DMA support") in v3.1-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d72732fe70c11424bc90ed466c7ccfa58b42a9a]
stable/5.10: [43334836b907adc21eab3079d2e6b26754468786]
stable/5.15: [36e58c436d2c2a797800427dc04d74ffd8b6ce1c]
stable/6.1: [4ca90deeca1c7dd72c1c380ba8143565516def2d]
stable/6.12: [8822980668c96b5aa251c1e2daec1873262b8f3f]
stable/6.18: [d50ef3553acbacce6f2843304d41d06dca358bb6]
stable/6.6: [d79e92161b65832e0b8cad5f3d84d17e5cd7a970]
stable/7.0: [0e8e57f9737ea257634db1d152fc430a0788a3e1]

CVE-2026-46302: selinux: allow multiple opens of /sys/fs/selinux/policy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46302

According to the .vulnerable file, this bug was introduced by commit
cee74f4 in v2.6.37-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a02cd6805562305f936e807da83e253b719dd965]
stable/7.0: [714362f3779dfa453a78ced32396a72726962a41]

CVE-2026-46303: isofs: validate Rock Ridge CE continuation extent
against volume size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46303

Introduced by commit f54e18f ("isofs: Fix infinite looping over CE
entries") in v3.19-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a36d990f591320e9dd379ab30063ebfe91d47e1f]
stable/5.10: [8356fb821016797f5677cbeee5ddc0d32a95b4be]
stable/5.15: [d582e12378bc1637f337622feef762f53c43fd57]
stable/6.1: [bf1bc673c587f5ef7e9c09b94aea7c5a7847d4d9]
stable/6.12: [22b36fa081f38ab397c7697f9d539211b51a0cfc]
stable/6.18: [e69da8eeab74b4f4505024c38a17bce060fe7df8]
stable/6.6: [c9b37c8b73f6368e4750e5ccb0632c380b43c6e5]
stable/7.0: [ef048470c90bc8c1b8318bb2ce329da9ef64b9fe]

CVE-2026-46304: nvmet: avoid recursive nvmet-wq flush in nvmet_ctrl_free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46304

Introduced by commit 06406d8 ("nvmet: cancel fatal error and flush
async work before free controller") in v4.10-rc6.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aade8abd8b868b6ffa9697aadaea28ec7f65bee6]
stable/5.10: [ae5b0cad163833e10b271e9becc05d81dae56e5f]
stable/5.15: [8d66ba89480ff098a58d79003a505f383aa4e920]
stable/6.1: [a696fbbd5240b4ac9b166f7bd4c550882ff543f1]
stable/6.12: [ee6e20c4bc9eae542a0954a368449532383169d4]
stable/6.18: [781f47d641432c26c19625b2cdd7f40825097592]
stable/6.6: [9a4d7222c0955b221e38bb66d10e6bccb672c8a1]
stable/7.0: [551f445a56a11a6457550cddcf39c9ebb8bcacc6]

CVE-2026-46305: staging: rtl8723bs: os_dep: avoid NULL pointer
dereference in rtw_cbuf_alloc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46305

Introduced by commit 980cd42 ("staging: rtl8723bs: replace
rtw_zmalloc() with kzalloc()") in v7.0-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc851db06045a40c18233dd76ef0562d7f8bb6db]
stable/7.0: [0a5f411becfb7c57aa89827213d31ef23a03d75a]

CVE-2026-46306: flow_dissector: do not dissect PPPoE PFC frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46306

Introduced by commit 46126db ("flow_dissector: Add PPPoE dissectors")
in v6.0-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
stable/5.10 stable/5.15

Fixed status
mainline: [d6c19b31a3c1d519fabdcf0aa239e6b6109b9473]
stable/5.10: [e7c811ca372d53c2be7d01a1614e71fae1054836]
stable/5.15: [abc5bc84e0f2edc7ea2d437afa6ef3fe1fc43200]
stable/6.1: [18ae9eacfc95cc715c0606b2c86e8aa8a86cf3e3]
stable/6.12: [6044392d9cace3a3672b02c8bc7d38b502e51734]
stable/6.18: [0d00b9015069712944934bab09eaa6c542143049]
stable/6.6: [db104b0d8a7856397c0469d83a4289adf7c54863]
stable/7.0: [7c93f353eab4ea911e394630f07d72e040a729d8]

CVE-2026-46307: wifi: ath5k: do not access array OOB

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46307

Introduced by commit 6d7b97b ("ath5k: fix tx status reporting issues")
in v3.0-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d748603f12baff112caa3ab7d39f50100f010dbd]
stable/5.10: [ecb1c163166759dec004c1fdb9709b8a5992fc8e]
stable/5.15: [9dd6aae4bc7bfa11088d928670a3315eae542769]
stable/6.1: [744c19e266b0d2628c5951439195dcef27eadacf]
stable/6.12: [d6869537013b1f21b292342752d97868b79b5934]
stable/6.18: [e9f1081bc775146156def0dbc821b92f35d56afb]
stable/6.6: [83226c71af53fb9b3cad40cb9a9a79f36d68c020]
stable/7.0: [568173ad9bd0b46cc6cd937dea8791e9b5eefa57]

CVE-2026-46308: pmdomain: mediatek: fix use-after-free in
scpsys_get_bus_protection_legacy()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46308

Introduced by commit c29345f ("pmdomain: mediatek: Refactor bus
protection regmaps retrieval") in v6.18-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec1fcddb3117d9452210e838fd37389ee61e10e8]
stable/6.18: [cb27e43c0511e9e1ca8818d231656070b11c18cf]
stable/7.0: [38d8410021b55d226847b2ac8d189d89fe5a8866]

CVE-2026-46309: drm/xe/uapi: Reject coh_none PAT index for CPU cached
memory in madvise

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46309

Introduced by commit ada7486 ("drm/xe: Implement madvise ioctl for
xe") in v6.18-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e5591c2fc1b30f4ea5e2eab4c3a695acc404e39]
stable/6.18: [87f9b1528e1ffc1da3615d552c9a06aba5e20b00]
stable/7.0: [fea04cf6f2345bc50f15b6638906c35962b89424]

CVE-2026-46310: media: renesas: vsp1: Fix NULL pointer deref on module unload

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46310

Introduced by commit d06c1a9 ("media: vsp1: Add VSPX support") in v6.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58b1e9664d8f74d55d8411cc7a7b275a76a6f24f]
stable/6.18: [bfb2081ba00afbbd15a5ed1ed1acdc3edeea5a98]
stable/7.0: [c4bb1515b26663e5230603892e67f2cc7df9f0ca]

CVE-2026-46311: drm/amdgpu/userq: fix access to stale wptr mapping

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46311

According to the .vulnerable file, this bug was introduced by commit
5fb2f7f in v6.16-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6da7b1242da4455b11c24ce667d1cab1a348c8ea]
stable/7.0: [336a9186f3a4b65bbd865d93936605ac8a1a3991]

CVE-2026-46312: media: videobuf2: Set vma_flags in vb2_dma_sg_mmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46312

Introduced by commit 5ba3f75 ("[media] v4l: videobuf2: add DMA
scatter/gather allocator") in v2.6.39-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7254b31a13aaa0c2c0f9ffbc335b718656117ff4]
stable/6.12: [1a1360264f699521e001e7739009ee3ee3c6a4f5]
stable/6.18: [21fade52ab9fb13368a5709e60b0d9909197aeae]
stable/6.6: [feb17524aa4ec337749344be0db52b88663e25ab]
stable/7.0: [b4cf91658a636618f1437beec971dec25dec28eb]

CVE-2026-46313: media: intel/ipu6: fix error pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46313

Introduced by commit 25fedc0 ("media: intel/ipu6: add Intel IPU6 PCI
device driver") in v6.10-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8dd088b8b106f7b119664f965b691785998edcfb]
stable/6.12: [fad134c446189e9bb48cea1a5ca426d2889a9c71]
stable/6.18: [f43e30646fc93799f3f48530d0ccbd52902c0541]
stable/7.0: [c352f90e093ae49902e47f41579e1aa41899ff64]

CVE-2026-46314: drm/v3d: Reject empty multisync extension to prevent
infinite loop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46314

Introduced by commit e4165ae ("drm/v3d: add multiple syncobjs
support") in v5.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb44d589bf3148e13452185a6e772a7efbf2d684]
stable/6.12: [2270513b5d472f5e090e33b88647f85698eb3630]
stable/6.18: [4fa42a249e8cd6ed17aea04e5695b6e9001f2433]
stable/6.6: [cea7d2688ded7c59d50658dd082c91933c20e8af]
stable/7.0: [9c5164781cb388d219d8f49fa0f0b04cf86ad544]

CVE-2026-46315: io_uring/waitid: clear waitid info before copying it
to userspace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46315

Introduced by commit f31ecf6 ("io_uring: add IORING_OP_WAITID
support") in v6.7-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93d93f5f8da791e98159795c6ef683f45bd95d13]
stable/6.12: [954518e5a4a5efc5033253f6e36fc7b9f98363a3]
stable/6.18: [b737c6612c60c23b40a9f31749b99e6f61943847]
stable/7.0: [4d2a0de611ab60d02fc768ae0cd5918b16bd5474]

CVE-2026-46316: KVM: arm64: vgic-its: Drop the translation cache
reference only for the erased entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46316

Introduced by commit 8201d10 ("KVM: arm64: vgic-its: Maintain a
translation cache per ITS") in v6.10-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13031fb6b8357fbbcded2a7f4cba73e4781ee594]
stable/6.12: [b7b72e88046328c9fdc638fe887d4240257dd5dc]
stable/6.18: [2bbc395e81bd29c543a0529a678327e932a7ec69]
stable/7.0: [9121f4605ab94969f62d1b5714ca3c6c69bd202f]

CVE-2026-46317: KVM: arm64: Reassign nested_mmus array behind mmu_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46317

Introduced by commit 4f128f8 ("KVM: arm64: nv: Support multiple nested
Stage-2 mmu structures") in v6.11-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70543358fa08e0f7cebc3447c3b70fe97ad7aaa8]
stable/6.18: [918450ad6010df6ecd2efde12a1409e011da22d6]
stable/7.0: [4424dbcb06d68e34e51c019a5781a7dc00731971]

CVE-2026-46318: Revert "mm/hugetlbfs: update hugetlbfs to use mmap_prepare"

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46318

Introduced by commit ea52cb2 ("mm/hugetlbfs: update hugetlbfs to use
mmap_prepare") in v6.19-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83f9efcce93f8574be2279090ee2aec58b86cda7]
stable/7.0: [3af5fc3f0ac98c624c109c8c0796fa46e814344c]

CVE-2026-46319: net/sched: act_ct: Only release RCU read lock after ct_ft

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46319

Introduced by commit 138470a ("net/sched: act_ct: fix lockdep splat in
tcf_ct_flow_table_get") in v5.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f462dca0c8415bf0058d0ffa476354c4476d0f09]
stable/5.10: [ece578ca61e572df96cfc80456357ebfae0b4b9e]
stable/5.15: [a2e0c045c87aa252eb61412e67dd91f2c2b19f81]
stable/6.1: [67c9ecc9f2575273ed1323e312881fc98ac83d6d]
stable/6.12: [17dfb67cb399b660105d9a8c6100851c0d0cdc70]
stable/6.18: [4c727c6967a41b37efe0f26332ca9ec5b74785a3]
stable/6.6: [f23424a0ddadb494d4bd57056a7ca703312d3a7b]
stable/7.0: [3e20e1b3058e0b94638e7b931c138e840e266724]

CVE-2026-46320: tap: free page on error paths in tap_get_user_xdp()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46320

Introduced by commit 0efac27 ("tap: accept an array of XDP buffs
through sendmsg()") in v4.20-rc1.
Introduced by commit ed7f2af ("tap: add missing verification for short
frame") in v6.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [3bcf7aec6a9d16438f2cec29f5d7c8d5b8edf9b2]
stable/7.0: [18a84c35842e19cd3c5534d8cee73d31863f696d]

CVE-2026-46321: tun: free page on short-frame rejection in tun_xdp_one()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46321

Introduced by commit 0495848 ("tun: add missing verification for short
frame") in v6.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [f4feb1e20058e407cb00f45aff47f5b7e19a6bbf]
stable/6.12: [69863ff2720a0e9871f1a5710f2a33a94217fee0]
stable/6.18: [37a1c268c2c8090bf4dc552d732bd23ba36f8eb0]
stable/7.0: [98c67be9eb9de72465a071949e84a3cdb8fab5a3]

CVE-2026-46322: tun: free page on build_skb failure in tun_xdp_one()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46322

Introduced by commit 043d222 ("tuntap: accept an array of XDP buffs
through sendmsg()") in v4.20-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa8963fdce667a42fb7f0bdd2909fadcab02f9a8]
stable/6.12: [d16e38fac09a47bfcf98c1ad65a1bb53f94540f5]
stable/6.18: [aa308e9dbb9acb17cacdbbce9e4504f69bac8385]
stable/7.0: [4fefc6156a162a9f50035c12091a5e5130c82c6e]

CVE-2026-46323: net: gro: don't merge zcopy skbs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46323

Introduced by commit 753f1ca ("net: introduce managed frags
infrastructure") in v6.0-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4db79a322db8c97f7b73b8a347395ef4d685eb40]
stable/6.12: [479084ae0e1d9cb7929cb4298d35623de189f80a]
stable/6.18: [e334cbf3388fd9334503a778a82d9e9f14dd2f71]
stable/6.6: [1f9c828556416fbe3f49386708ce999fc4d4da06]
stable/7.0: [44bea2032af0425e4ce6d26a8af0ede79db49ec1]

CVE-2026-46324: netfilter: nf_tables: use list_del_rcu for netlink hooks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46324

Introduced by commit f9a4300 ("netfilter: nf_tables: double hook
unregistration in netns path") in v5.19-rc1.
Fixed in v7.1-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [f3224ee463f8f6f6ced7dcdf6081add4f8128527]
stable/6.18: [0bd93ce4f3c35e845532184331d7917d7e562c80]
stable/7.0: [0f33e8ad6ac563ae2233dd7f75884e0ee010521d]

CVE-2026-46325: RDMA/rxe: Fix iova-to-va conversion for MR page sizes
!= PAGE_SIZE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46325

Introduced by commit 592627c ("RDMA/rxe: Replace rxe_map and
rxe_phys_buf by xarray") in v6.3-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12985e5915a0b8354796efadaaeb201eed115377]
stable/6.18: [409c2c5508f3d30627bea576f8676de523cb906e]

CVE-2026-46326: iio: pressure: mprls0025pa: fix spi_transfer struct
initialisation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46326

Introduced by commit a0858f0 ("iio: pressure: mprls0025pa add SPI
driver") in v6.9-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e0ac56c92e26115cbc8cfc639843725cb3a7d6a]
stable/6.12: [72158f9ae29a9e56d0f9704ce461a866feaf9925]
stable/6.18: [664ffdf34c01810085e4d85508b361c3fdd2ab40]

CVE-2026-46327: dm: fix unlocked test for dm_suspended_md

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46327

Introduced by commit 37f53a2 ("dm: fix dm_blk_report_zones") in v6.16-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [24c405fdbe215c45e57bba672cc42859038491ee]
stable/6.12: [175ac0a6115400278d3900f5a04a58b17b3f6cd0]
stable/6.18: [7a3385e97af2b6f485fef11e82d8c29adee4be93]

CVE-2026-46328: apparmor: fix rlimit for posix cpu timers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46328

Introduced by commit baa73d9 ("posix-timers: Make them configurable")
in v4.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9c4c84e5e0885ea406138b0920a55a1843a8f2c5]
mainline: [6ca56813f4a589f536adceb42882855d91fb1125]
stable/5.10: [e1cc11550b2f66687a374536c9dfdddcefca0efe]
stable/5.15: [2232d7cd243833ad750cae656d1817fe43744a09]
stable/6.1: [28aa93fcfb33b6d580c5df4ae8b6d13fb0e6fcd3]
stable/6.12: [e43818b16815c0c2bf933ef28316f8e704e5e0ef]
stable/6.18: [9bf1fa150775b0c6b794e4b6a2c0395e13777999]
stable/6.6: [1f736dfe27c857b78f8461cd7c3dd9640be74b37]

CVE-2026-46329: erofs: handle end of filesystem properly for file-backed mounts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46329

Introduced by commit ce63cb6 ("erofs: support unencoded inodes for
fileio") in v6.12-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc804a8d7e865ef47fb7edcaf5e77d18bf444ebc]
stable/6.12: [8d582d65d20bb4796db01b19e86909ad68cb337b]
stable/6.18: [e49abde0ffc382a967b24f326d1614ac3bb06a94]

CVE-2026-46330: Revert "net/smc: Introduce TCP ULP support"

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46330

Introduced by commit d7cd421 ("net/smc: Introduce TCP ULP support") in
v5.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [df31a6b0a3057e66994ad6ccf5d95b9b9514f033]

CVE-2026-46332: greybus: gb-beagleplay: bound bootloader receive buffering

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46332

Introduced by commit 0cf7bef ("greybus: gb-beagleplay: Add firmware
upload API") in v6.12-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1214bf28965ceaf584fb20d357731264dd2e10e1]
stable/6.12: [663c2728a6d0f781044431111b53a27f71027e48]
stable/6.18: [fb91d4e49fcbea0b5091394ac5b8f7d4124265c3]
stable/7.0: [0339a746ff7cd3f9d10f565e89c99dc93191e58d]

CVE-2026-52904: drm/nouveau: fix nvkm_device leak on aperture removal failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52904

Introduced by commit c0bfe34 ("drm/nouveau: create pci device once")
in v6.12-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6597ff1d8de3f583be169587efeafd8af134e138]
stable/6.12: [5edd564ccb002ffc830e7818c1c4a992db774678]
stable/6.18: [4404d7d2dda4f3cc84a8fb6ac5417a2afc3b22d6]
stable/7.0: [843c0247cf21364e33bb5a8ffc9af57107d04d05]

CVE-2026-52905: mm/damon/core: disallow non-power of two min_region_sz
on damon_start()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52905

Introduced by commit d8f867f ("mm/damon: add
damon_ctx->min_sz_region") in v6.18-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95093e5cb4c5b50a5b1a4b79f2942b62744bd66a]
stable/6.18: [1de2db19a6028abe7d905875922faef5b873de67]
stable/7.0: [89b6226b6c2a4add3939f361653a47c212d6ab75]

CVE-2026-52906: 9p: fix access mode flags being ORed instead of replaced

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52906

Introduced by commit 1f3e414 ("9p: convert to the new mount API") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da2346a48a5a1fed86c3fe3d73c0b60e7b3027c9]
stable/7.0: [b8f037e87a083291190204b959cda417aaf01058]

CVE-2026-52907: media: rockchip: rkcif: fix off by one bugs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-52907

Introduced by commit 1f2353f ("media: rockchip: rkcif: add support for
rk3568 vicap mipi capture") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4056b84af0fc18c84b4e5741df04ecd8ca17973]
stable/7.0: [73e119036b3a799170ed89907b4273c07306d611]



* Updated CVEs

CVE-2026-45930: net: mctp: ensure our nlmsg responses are initialised

stable/6.12, stable/6.18 were fixed.

Fixed status
mainline: [a6a9bc544b675d8b5180f2718ec985ad267b5cbf]
stable/6.12: [976612471a9e6ead6ceffc241e4d0a1aac90b36a]
stable/6.18: [54ed418de62a148a655262da682a050fa05f7924]

CVE-2026-43331: x86/kexec: Disable KCOV instrumentation after load_segments()

stable/6.12 was fixed.

Fixed status
mainline: [917e3ad3321e75ca0223d5ccf26ceda116aa51e1]
stable/6.12: [593d67032544b9271094fc9b43e437e017cb2b2f]
stable/6.18: [1e3e98596c2769721ade0418434852fb3af4849a]

CVE-2026-43303: mm/page_alloc: clear page->private in free_pages_prepare()

stable/6.12 was fixed.

Fixed status
mainline: [ac1ea219590c09572ed5992dc233bbf7bb70fef9]
stable/6.12: [f9719e32a67b4b00b3c9b133e8b5ffa72a26b67b]
stable/6.18: [23b82b7a26182ad840ae67d390d7ec9771e8c00f]

CVE-2026-43219: net: cpsw_new: Fix potential unregister of netdev that
has not been registered yet

stable/6.12 was fixed.

Fixed status
mainline: [9d724b34fbe13b71865ad0906a4be97571f19cf5]
stable/6.12: [14645799ad5253a028cf662e2f9cd18a68f74b31]
stable/6.18: [29739ec197ed66535bc0b86f14ab66c5f4512138]

CVE-2026-31709: smb: client: validate the whole DACL before rewriting
it in cifsacl

stable/6.18 was fixed.

Fixed status
mainline: [0a8cf165566ba55a39fd0f4de172119dd646d39a]
stable/6.12: [d92f3f0b22414e7515696a02224d0af55e3004a3]
stable/6.18: [ff0ca46b13b9ef6edbcd238a3b6caacfef8ba0e5]
stable/6.6: [8e47d297e7cf9a6029a0d38e7b22faba7d7aaf12]
stable/7.0: [b78db9bddc84136f6a0bb49e8883cf200dfb87a8]

CVE-2026-23346: arm64: io: Extract user memory type in ioremap_prot()

stable/6.12 was fixed.

Fixed status
mainline: [8f098037139b294050053123ab2bc0f819d08932]
stable/6.12: [eeecafce5afffb4da703666ebefbd4d6e2a5abf6]
stable/6.18: [3d64dcc0799c2d6921ba027716b7be721eb19fa8]
stable/6.19: [d1ad8fe7f72d73e1617bac79f2ec7a3bedf47e2a]

CVE-2025-68768: inet: frags: flush pending skbs in fqdir_pre_exit()

stable/6.12 was fixed.

Fixed status
mainline: [006a5035b495dec008805df249f92c22c89c3d2e]
stable/6.12: [543555954b1ee8d1903a7020324efb41b0c97428]
stable/6.18: [c70df25214ac9b32b53e18e6ae3b8f073ffa6903]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

