Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB9CC43458
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 22:50:27 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.57891.1782946224297282054
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Jul 2026 15:50:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=tx6Wd1DV;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.178, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-80dc4a68e4aso12533817b3.0
        for <cip-dev@lists.cip-project.org>; Wed, 01 Jul 2026 15:50:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782946223; cv=none;
        d=google.com; s=arc-20260327;
        b=eHA+kspUW8RVLmFZDRgkZ6RTReB8Ct2HgpeNTKb2ePCVaX5YIX2gLQ7fv3KmYyYerX
         0l4QUPkhNuS8kW5kMt1UBQsCpbzKvBJhfqYbStvWZy+F5aHKl15Ksl9kdvNbZQX40x1C
         YyFUACzchuqEHlXccSz2Jk37aHRkPqKlM2+dynT5qGZAYW3Gt1ZkG7xkA7dfHsab8BwE
         sZKNDyimh1JFXstaDYYfWumDf6Wv3igaOemOabNUoAeDdFGtDsJJdRqSGDUhNRdvbh+v
         BbtznICWM19Vu+v2L1uWfXGxUxbeSK0Om1lnDlwk/axRVbh1uVQaccopCjROgBJT8gpU
         EnkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=t8aylgEKMZzGxsNujK+TLAPh3XuUJ0rwIT3aiaZkyLI=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=TUV3nMLPnGfS3wPBFrwht+bWecOEVcyw8LYLY+t3vRWbwXnma4lIQ1drUQflEIfv6L
         iheNiYQnDdNLAYEh02J/1HF0P+m7MW7K/NxgQMjrarJ14czej7uJRNpDbhSd/l/SCzSt
         /8lSDfIVpo8Zfj5R4C71GCNM1ui0R//j+nnorWmrwBqGGqcpamSnsPA77c7OlzyMfGOm
         MvgL9Eb2BE+pZ2zXRcGMJrFBHm4p8CGHWaBqhLJzNXMmbVlzChlWJ4C2emLNY73Cfx0Z
         EY6Bxr2gqzsbcgI966yaObDXqLh37J6CwLVh2CPLy7K7FKE6g4vTbF3sW1iBK1w0fQI+
         C2Tw==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1782946223; x=1783551023; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t8aylgEKMZzGxsNujK+TLAPh3XuUJ0rwIT3aiaZkyLI=;
        b=tx6Wd1DVqYHgZDjzAtaPYfLcHWyHrGgkqRNgeMCC6X8zjFcG6/PFLo6Y2zXp4mYrqO
         JDRkji6xdpEpIaoxZGSvBryTL7aAUROZNBe3aAu2Wo1SlK0zLJzhazfgYB8u8k7B62Dl
         RgpPAgzvbNlu61t4NbvCfLlijwpJ2kDwHX0cSKgDTKDPLBFcBcDnkWqpqr3SLOriAr80
         dkB0BEUIYz6Ni5tYL1BFN88xqTbARg1mDkzVvgMhivg6keYsEw8Mqo2g7IME43x42opT
         yjIvb9ytDh1nLCW+wVm8fV9JoaNW/OaIXXt+1u993RdwDjfsM568duobMhyehucRtzse
         AoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782946223; x=1783551023;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8aylgEKMZzGxsNujK+TLAPh3XuUJ0rwIT3aiaZkyLI=;
        b=EvjwHMVHRynzijyczu4ZRWUSD5opuO+46n+EcdV89XmhrZETAYtpP5HTngXA06VTSs
         p4nJJuZ0S7kdM1Ohri9qKDcXeKB4EEXb2Fv8P1ozPm8E+Yzt79IxkIpOPNysnlpAdY2X
         nGFbn0slVuwDl439DpnwMR1dW3AAnGiO4detvfuZ7RmVVqJNEb/Mu5oNdOYlxyiQ3/EQ
         F49U4pkuxoJVA57/qyUf+3Q1xTZVWud/2Bi+hPjfWlbdz8ffJYs18fRNgQuLrdN/1Dta
         lsdOJ1x90i2siWRVcJu/otrhRW5sVa5Y3wKyjXKZ0yFDnL9usPuNuYPPOK+xkVVU1fGQ
         LHHg==
X-Gm-Message-State: AOJu0YwFHxvyE2WaqZEqqc7OOpEKaRAkRv57Em4V5YeedOKItUeF9INo
	DU8FdeZncNqulN4Uj97ve3O9DbSsI+mx0sITglSvXnxGOS5GjDry6KyyqeV97WNGi3eC2yQbLju
	tRDzsLeJUL84asVXer8LZaac44ixQqYa9Wm5pfZhU8DufecvzV/vuObtr8g==
X-Gm-Gg: AfdE7cmow6QBo+ZAN9G24bZp6wQpOsRW64WT+acxj9VzC68A2iZuWf6rP8vKdvWmY1Q
	2eAYm2+SRNg7vMN3hir5GdoSM/Gv8u/LgeZYpw+YJmQIkTQSOVGPn/Ra00A/k1cs5KtuLEOWnmw
	uMTcuRfyasZGhl+JfVg5SUonE23F3UXgXsXAqBgAQikBC+X9kgPgO53LQoqIrxXz+/ss+MTau/o
	wE0TjYcIt4z6gTPACxMn3rnkE6sEboTIlR7xhBgjrpbI8t3rv5IgQ84rHCpM0ZN/HRJun11rw==
X-Received: by 2002:a05:690c:3706:b0:80b:9114:3b9b with SMTP id
 00721157ae682-812e8bf2243mr39279437b3.14.1782946220670; Wed, 01 Jul 2026
 15:50:20 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 2 Jul 2026 07:49:44 +0900
X-Gm-Features: AVVi8CfrAjGNsOAWvMj4E9Gvb0Dn1eJZ3TVqY-gzCvInDLURhegWxIXfsh3cFag
Message-ID: <CAODzB9rn1J4k4qt0yQbz4wgr7CYM8cyjrht1J27qNTWaA8OiMg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Jul 2026 22:50:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23372

Hi!

It's this week's CVE report.

This week reported 226 new CVEs and 5 updated CVEs.

* New CVEs
CVE-2026-53131: netfilter: require Ethernet MAC header before using eth_hdr()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53131

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62443dc21114c0bbc476fa62973db89743f2f137]
stable/5.15: [4435888e1bf139d2bfe5911643d4217382136743]
stable/6.1: [063f43361e884acd7300790e90194430275d0d0c]
stable/6.12: [367abcacc13a8e2e7624408b7f593bd1e60e49d9]
stable/6.18: [5d634afb8b83b49de562792fd0d047416a43bd4d]
stable/6.6: [726abf97566867f808fec9d8a408eb9698bd570a]
stable/7.0: [cea435ea7e868ea6fdf039bc4f2090c1d829b556]

CVE-2026-53132: vsock/virtio: fix potential unbounded skb queue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53132

Introduced by commit 0777061 ("virtio/vsock: don't use skbuff state to
account credit") in v6.3-rc3.
Fixed in v7.1-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [059b7dbd20a6f0c539a45ddff1573cb8946685b5]
stable/6.12: [1eca304f97a34ed5e921e1f0e06c8b241f25bf12]
stable/6.18: [9bdc637fde66b63d6cad0caacd034888bb7bf5f5]
stable/7.0: [100d5b2ffdc6468b9e48532641f29e83efdcb63c]

CVE-2026-53133: RDMA/umem: Fix truncation for block sizes >= 4G

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53133

Introduced by commit a808273 ("RDMA/verbs: Add a DMA iterator to
return aligned contiguous memory blocks") in v5.2-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15fe76e23615f502d051ef0768f86babaf08746c]
stable/5.10: [2ff4b7817e5b78070c30f5fb5e678e452a2628b3]
stable/5.15: [dee2a49adeeb2a5e16a3fc858fa21b841c519802]
stable/6.1: [cc644d5608e3b0dadc970bd6e6aa26b91ea07d0f]
stable/6.12: [baf8685bcf56dc1efb44b8f6a57c42516e549068]
stable/6.18: [afd35fec9297195b759078745549c2671223f24f]
stable/6.6: [8fe0231adebe086c8a459c790944ac026cd99c6e]
stable/7.0: [ac1aad8e1281534ce936c250f68084fc79c5469e]

CVE-2026-53134: netfilter: nft_fib: fix stale stack leak via the
OIFNAME register

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53134

Introduced by commit f6d0cbc ("netfilter: nf_tables: add fib
expression") in v4.10-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab185e0c4fb82dfba6fb86f8271e06f931d9c64c]
stable/5.10: [6744e49fe51bfba26522acc2d0e9703cb41d8e50]
stable/5.15: [eca18feed38b3377a2ec5d1f22af1170c55d0171]
stable/6.1: [d19ddef8c327a4773ff81f8e51027d1e0b4cf069]
stable/6.12: [8c84885e9790823828bb8084736ea15769b1ac16]
stable/6.18: [84d8f58cf28a0415413f43ba7148f7bacd4c1b6e]
stable/6.6: [eb8a8124484dbc3c2b543e207da39bbccb703d31]
stable/7.0: [3544210609f6d1db282bbdeca639104ef624c393]

CVE-2026-53135: drm/amd/display: Fix NULL deref and buffer over-read
in SDP debugfs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53135

Introduced by commit c7ba365 ("drm/amd/display: Generic SDP message
access in amdgpu") in v5.2-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [adf67034b1f61f7119295208085bfd43f85f56af]
stable/5.10: [ee9cfcf77a8e8af637396dc00966df5f701e661c]
stable/5.15: [b781f90a9528555c709e59789550893581ef0be4]
stable/6.1: [a2de1d71891a038a9346b2c1a72b88c8350f2479]
stable/6.12: [7ae95c0275c330b5dbae806f8e431720edad776f]
stable/6.18: [bb6f705b73b5f191f14ad004e2c8c4b615806187]
stable/6.6: [7fc4fab4acc307ad2903312c195872b2953d32c3]
stable/7.0: [c90954cdea4d6998ec345de0d840d030c145b89e]

CVE-2026-53136: drm/amd/display: Clamp VBIOS HDMI retimer register
count to array size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53136

According to the .vulnerable file, this bug was introduced by commit
1e8635e in v4.15-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb0707ce00eef4e2d60c3020e1c0432739703e4a]
stable/5.15: [029571d51140650783be4fb98fe7cb4754752086]
stable/6.1: [5f8b39452fb16f507c9e4d8b4a83ce27e893307c]
stable/6.12: [d6be8e59af412623e3d874be3a048406c0edfe60]
stable/6.18: [3f32d52ec604c659725d865cf8cc6a17a33f9c6a]
stable/6.6: [4d1c3c26c2ab1842e139e61983395d64bd2e518b]
stable/7.0: [8aaa7e317fbd4beb9c6a9f77aa4cf52fae78b117]

CVE-2026-53137: drm/amd/display: Clamp HDMI HDCP2 rx_id_list read to buffer size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53137

Introduced by commit eff682f ("drm/amd/display: Add DDC handles for
HDCP2.2") in v5.6-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0f3981c43b32cadfe373d636d9e9ca522bb3702]
stable/5.10: [3c4444aec06c74fbc05661f370954ac814963c38]
stable/5.15: [91fb41218c413989d8b6c837748751454b452d68]
stable/6.1: [964e50ef7b8f09815a7d05b8326af700f8d5bc96]
stable/6.12: [bfba882cfcd08f6540f72f48e786b6404f5d2c5b]
stable/6.18: [1906064d50d194a145486e5caf3db3e708b6f6ef]
stable/6.6: [79e0273272a05fb26f9b1e55bf1a52eefc3b7b35]
stable/7.0: [98cfb7530ea91d8e5e928285cdce58e1131f6e83]

CVE-2026-53138: drm/amd/display: Bound VBIOS record-chain walk loops

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53138

Introduced by commit 4562236 ("drm/amd/dc: Add dc display driver
(v2)") in v4.15-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff287df16a1a58aca78b08d1f3ee09fc44da0351]
stable/6.12: [6173cfea2f916e01c4f98e29cd654384a05e32a3]
stable/6.18: [0e56f460bddb397fa9a8e6faf7ae7eaa86953eb1]
stable/7.0: [2645e3caf7e013189da9c6ff621d006cca5a538b]

CVE-2026-53139: drm/v3d: Skip CSD when it has zeroed workgroups

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53139

Introduced by commit d223f98 ("drm/v3d: Add support for compute shader
dispatch.") in v5.3-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f93fad5ea0affc9e1505dd0f7596c0fdb496213]
stable/6.18: [9655b56b6de918e1c22b92f3880ae41b052cbd00]
stable/7.0: [11e6432836394e00d39e468cd514f9ddb66f1e49]

CVE-2026-53140: drm/v3d: Fix vaddr leak when indirect CSD has zeroed workgroups

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53140

Introduced by commit 18b8413 ("drm/v3d: Create a CPU job extension for
a indirect CSD job") in v6.8-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae7676952790f421c40918e2586a2c9f12a682b6]
stable/6.12: [0b59d0946913a0df7d1a033013e259e9b6a76546]
stable/6.18: [90b629269088a9fe24a02c032be9f08357f47873]
stable/7.0: [60ebeb23eaf3d7fd2e0551fe304309305e31d424]

CVE-2026-53141: drm/v3d: Fix global performance monitor reference counting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53141

Introduced by commit c6eabba ("drm/v3d: Add
DRM_IOCTL_V3D_PERFMON_SET_GLOBAL") in v6.14-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6bf7e2affc6e62da7add393d7f352d4040f5bc27]
stable/6.18: [3e1947573140a57119294f0bff39ee18d93f23e1]
stable/7.0: [ed2eaf3b7b1820b690e4b896d344e00027526a25]

CVE-2026-53142: drm/xe/display: fix oops in suspend/shutdown without display

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53142

Introduced by commit 44e6949 ("drm/xe/display: Implement display
support") in v6.8-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [68938cc08e23a94fd881e845837ff918de005ce7]
stable/6.18: [0f68ddfaaebfbb5581ee931779757d31f4dc9e24]
stable/7.0: [238bcdaae8f2abc65e182de7d1f69cf8f611a610]

CVE-2026-53143: drm/amdkfd: Fix buffer overflow in SDMA queue
checkpoint/restore on GFX11

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53143

Introduced by commit cc009e6 ("drm/amdkfd: Add KFD support for soc21
v3") in v5.19-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [352ea59028ea48a6fff77f19ae28f98f71946a80]
stable/6.12: [2c5b66c9b4057b385566940935ebc32f6e6ebfd2]
stable/6.18: [d3efcadfe3eea5b4263b8f2d4463b15c9fc46a64]
stable/6.6: [16dad1fb0d783a4008de30e32d0038c393de05b1]
stable/7.0: [d02f05d30f35b036f7cbaf72de634affb5b38ec6]

CVE-2026-53144: drm/amdkfd: fix NULL dereference in get_queue_ids()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53144

Introduced by commit a70a93f ("drm/amdkfd: add debug suspend and
resume process queues operation") in v6.5-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2bd550b547deabef98bd3b017ff743b7c34d3a6d]
stable/6.12: [daeceb0fe2a19651c58bbfa3d9d515ecb6ca8996]
stable/6.18: [72e259a32084c42816152c346096d2edd4213e23]
stable/6.6: [62bd09e23a23da70f9aae02748eba3e6bd93095d]
stable/7.0: [e1965e8913cfbf17622ca12638e7a07f68ba0848]

CVE-2026-53145: drm/gem: Try to fix change_handle ioctl, attempt 4

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53145

Introduced by commit dc36660 ("drm: Replace old pointer to new idr")
in v7.1-rc4.
Introduced by commit 5e28b7b ("drm: Set old handle to NULL before
prime swap in change_handle") in v7.1-rc3.
Introduced by commit 7164d78 ("drm/gem: fix race between change_handle
and handle_delete") in v7.1-rc6.
Introduced by commit 5e28b7b ("drm: Set old handle to NULL before
prime swap in change_handle") in v7.1-rc3.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
stable/6.18 stable/7.0

Fixed status
mainline: [1a4f03d22fb655e5f192244fb2c87d8066fcfca2]
stable/6.18: [c0639ede2f24ac224b2079cd35ecd5fd8ad4e3cd]
stable/7.0: [1d9b93df7fc768228906e24220591ec1cddad391]

CVE-2026-53146: thunderbolt: Limit XDomain response copy to actual frame size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53146

Introduced by commit cdae7c0 ("thunderbolt: Add support for XDomain
properties") in v4.15-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4db2bd2ed4785dbadaeeab9f4e346b21ac5fb8eb]
stable/5.10: [c55da494dfb445fb28df3a9d293c2be6a299cd01]
stable/5.15: [7720654b4842bcdfeb64bc002f6186041849e1e7]
stable/6.1: [033dfa63bf6be2653441a1dccae4a8313a91bb9d]
stable/6.12: [a15b6d3136accb2bf84b04d9a3ddd991f7fbf1cb]
stable/6.18: [b5daa920f44cb582272fc9bfaeb67408776cbaef]
stable/6.6: [fc261397295b8ad0654cec747b0ec25ea0011995]
stable/7.0: [b2c1e5d9f1598cc1a4736d5c6bd1218f90805ee4]

CVE-2026-53147: thunderbolt: Validate XDomain request packet size
before type cast

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53147

Introduced by commit 8e1de70 ("thunderbolt: Add support for XDomain
lane bonding") in v5.19-rc1.
Introduced by commit cdae7c0 ("thunderbolt: Add support for XDomain
properties") in v4.15-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a504b9f2797b739e0304d537e8aa4ce883ecce39]
stable/6.1: [a770e62923090d7572f1f5a8507ae551d354a057]
stable/6.12: [79235c8add5da4bf27a12f5a5dbb579f300c059e]
stable/6.18: [46da5c3ea011e884028a91cf913db093920a915b]
stable/6.6: [0dd61ba03d05187726ecdf9c0e2175a81b9b24f6]
stable/7.0: [07cd2787cdf8942d24a1a3ef81aa89b526fb6381]

CVE-2026-53148: thunderbolt: Clamp XDomain response data copy to allocation size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53148

Introduced by commit cdae7c0 ("thunderbolt: Add support for XDomain
properties") in v4.15-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [322e93448d908434ae5545660fcbe8f5a7a8e141]
stable/5.10: [0b334279a82d79fb4723bd4f614305de1ab69caa]
stable/5.15: [6021d39ccd979713b39b980286020d8f9a45efd1]
stable/6.1: [89ae04365e01d5ae4aae83044a8bbd2a9aaf8d0d]
stable/6.12: [05a43157676c243c248d1c6d9dcecbe6eba2f35d]
stable/6.18: [fcbd0cdab92838854a5818be7ed8a097164ef6d5]
stable/6.6: [5db10c8ad8c09f72c847dfeef3d876098257f505]
stable/7.0: [906035d5c3784570191d259cbf9a0ac1617852b5]

CVE-2026-53149: thunderbolt: Bound root directory content to block size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53149

Introduced by commit cdae7c0 ("thunderbolt: Add support for XDomain
properties") in v4.15-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [65423079c7420e3dbf9a7aa345c243a3f5752e5d]
stable/5.10: [5c7657d38d07268124782f03519f07c22a5814fb]
stable/5.15: [b212bc161d8a9937b42153723a4a3f2f74fab528]
stable/6.1: [1912be23daf4afc8d24ce916021ab68ca4c679db]
stable/6.12: [0a32040a48db8cf35de48b85d6115df5623e4964]
stable/6.18: [60ba6217460792356a238299edd675d91d46bab4]
stable/6.6: [4d0b1524caadb04c10a71f3f88692c63dcb39115]
stable/7.0: [cbeb68cbaa0a6f979ef428a7f2d0268c082ba166]

CVE-2026-53150: thunderbolt: Reject zero-length property entries in validator

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53150

Introduced by commit cdae7c0 ("thunderbolt: Add support for XDomain
properties") in v4.15-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cff8eb65d1eafe7793e54b4d0cf6bf831644630b]
stable/5.10: [581c2053ab4dbe27e83c9e62deb4c73aa8dc0c3a]
stable/5.15: [35d6c9252a152e756768a26dbf216b9dd9dd8e92]
stable/6.1: [99d9dbad1463afb510d42c9714f846361d1b726d]
stable/6.12: [ca11e7da4fba4b394f69e16448f4463c44c84de6]
stable/6.18: [2e0ddac549ebd713eb9f4a15b6496e3440a17d8b]
stable/6.6: [5f56bc6bddffe8710ba0ba8844023b5a44ca90e4]
stable/7.0: [3b6e68cb97f725385010264a873e14a3921b6b8a]

CVE-2026-53151: rxrpc: Fix the ACK parser to extract the SACK table for parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53151

Introduced by commit d57a3a1 ("rxrpc: Save last ACK's SACK table
rather than marking txbufs") in v6.2-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [333b6d5bb9f87827ac2639c737bf9613dbae7253]
stable/6.18: [566c4c1244de50fbff1f89ff93c9d7b0fc256db4]
stable/7.0: [224298450be5c04d2a6ea1c2a94669d7ebf65d00]

CVE-2026-53152: mmc: dw_mmc-rockchip: Add missing private data for
very old controllers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53152

Introduced by commit ff6f028 ("mmc: dw_mmc-rockchip: Add memory clock
auto-gating support") in v6.19-rc1.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [1e9a4850afa0ceb63984fb1a9f3e86d0fc4fd18f]
stable/6.12: [b1180ff50cca48807893ecde7d1f81d573c88c85]
stable/6.18: [7f8007be13e6cc1e0a508fe461f9a91ba9a28b8c]
stable/7.0: [8d9eca906e76d3dd40e5f2c79701f066678f2e62]

CVE-2026-53153: mm/list_lru: drain before clearing xarray entry on reparent

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53153

Introduced by commit fb56fdf ("mm/list_lru: split the lock to
per-cgroup scope") in v6.13-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98733f3f0becb1ae0701d021c1748e974e5fa55c]
stable/6.18: [c19ff4351214f059349788e13e70e74325831ff6]
stable/7.0: [2b66496d794e98f7aeec7688573051f22ec40bac]

CVE-2026-53154: mm/hugetlb: restore reservation on error in hugetlb
folio copy paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53154

Introduced by commit 1cb9dc4 ("mm: hwpoison: support recovery from
HugePage copy-on-write faults") in v6.4-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40c81856e622a9dc59294a90d169ac07ea25b0b0]
stable/6.12: [e47bf16af3c45470ea32f2241fa69aefe0dd61bd]
stable/6.18: [c72469ac0f274bde3f0df60a4584e14a123d0aa6]
stable/6.6: [8d6e1dd3ad1340cd8b6d554b7aa93d8f0a1c6d38]
stable/7.0: [45e33d43243d71d089af42f5077b8213cee6610f]

CVE-2026-53155: mm/huge_memory: use correct flags for device private PMD entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53155

Introduced by commit 65edfda ("mm/rmap: extend rmap and migration
support device-private entries") in v6.19-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43e7f189769c512c843184a8a5892ac779a6bd90]
stable/7.0: [d7251c8d3f7cea76543abac6cf4ed15582c10846]

CVE-2026-53156: nvmem: core: fix use-after-free bugs in error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53156

Introduced by commit 7ae6478 ("nvmem: core: rework nvmem cell instance
creation") in v5.16-rc1.
Introduced by commit e888d44 ("nvmem: resolve cells from DT at
registration time") in v4.20-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b6b6fc491899d583eaa75344e094796ae9b530b]
stable/6.12: [e0d38bf47a72da2f02c9fa6f752cd66d977cd7f7]
stable/6.18: [cb85ef5a227b3662b88f4d849a1aad43bfe7f5ae]
stable/7.0: [40e2a459c0dd1333b2343831480a0ad80dc07614]

CVE-2026-53157: net: phonet: free phonet_device after RCU grace period

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53157

Introduced by commit eeb74a9 ("Phonet: convert devices list to RCU")
in v2.6.33-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71de0177b28da751f407581a4515cf4d762f6296]
stable/6.18: [52b8f5ef82c886f7cd24617915e4b1579ddfd001]
stable/7.0: [bff309ea51f1395c1ef8be8b75ce62d28a319113]

CVE-2026-53158: misc: fastrpc: Fix NULL pointer dereference in rpmsg callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53158

Introduced by commit f6f9279 ("misc: fastrpc: Add Qualcomm fastrpc
basic driver model") in v5.1-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5401fb4fe10fac6134c308495df18ed74aebb9c4]
stable/6.12: [4bfdf0a9855df55e9e031ca6a25b855820590c70]
stable/6.18: [d5de9cb5355db36438edc621dde3673e3f235767]
stable/6.6: [8fb4a23df5b7c02929b62e5dbc270ec7c42b8134]
stable/7.0: [d77583ca33299fede0c194744ef2284e7ba5b763]

CVE-2026-53159: misc: fastrpc: fix DMA address corruption due to find_vma misuse

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53159

Introduced by commit 80f3afd ("misc: fastrpc: consider address offset
before sending to DSP") in v5.2-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [464c6ad2aa16e1e1df9d559289199356493d1e00]
stable/5.15: [2d0f47e27c1fa718b29c69aa7c96a2c5161bc2c2]
stable/6.1: [708c17b52c60fe7a57e73b495bdee50f58feb48c]
stable/6.12: [e69e306a4cccb40a73511350cb280825a556ce3c]
stable/6.18: [53e06f8a3c2b085c31bf1284e2ebcb8036e99625]
stable/6.6: [d3e26df2e8eb361e6bef096b2fd565476a1f14c4]
stable/7.0: [7ba7b30ddb04646d4d638f4d8c4718a304bbbddd]

CVE-2026-53160: misc: fastrpc: fix use-after-free race in fastrpc_map_create

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53160

Introduced by commit 10df039 ("misc: fastrpc: Skip reference for DMA
handles") in v6.18-rc1.
Fixed in v7.1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [07ebe87915d8accdaba20c4f88c5ae430fe62fbb]
stable/6.1: [0a3b87293fbd34fda651e6aead9964f84b893962]
stable/6.12: [5b0166112019d1dce30b976ab28fd67f7f0be532]
stable/6.18: [992f121796b7ca83a5a8b93da24e971363206218]
stable/6.6: [8b080c89183196fd3e49212f2a1a1c4a29335b9c]
stable/7.0: [f20f6512ecb75c816e0debf4551a138f098615c4]

CVE-2026-53161: misc: fastrpc: fix use-after-free of fastrpc_user in
workqueue context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53161

Introduced by commit 6cffd79 ("misc: fastrpc: Add support for dmabuf
exporter") in v5.1-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e85eb5feca8e254905ffa6c57a3c99c89a674a0f]
stable/5.10: [c6e5c2be09f814377d7f1ce97370a5b7b3e02814]
stable/5.15: [e1e3a05efe5954d5bad01157d79429d39a67a7ae]
stable/6.1: [d42679eef34dd590b694ce3b666c5e2ba10cd4bf]
stable/6.12: [ecea4967c2bff92c2fafbc59893f711b39f7b152]
stable/6.18: [5278ccd357e0d7aeeb1e76c0f3e0e02894a9897c]
stable/6.6: [df08fadcf0e5f3708365ec3b6d30b5aafd98bea1]
stable/7.0: [fbe0947420eec18a84638d29468c2d563ce4e6a3]

CVE-2026-53162: memcg: use round-robin victim selection in refill_stock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53162

Introduced by commit f735eeb ("memcg: multi-memcg percpu charge
cache") in v6.16-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0cafe24d3f6534294c4b2bc2d47734ff7cbd313]
stable/6.18: [89bd8215e25aa6999cc51696da418e0d422bc5e0]
stable/7.0: [00731bd7e18f182a32ca54d6b176eaa470b51ed7]

CVE-2026-53163: locking/rtmutex: Skip remove_waiter() when waiter is
not enqueued

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53163

Introduced by commit 3bfdc63 ("rtmutex: Use waiter::task instead of
current in remove_waiter()") in v7.1-rc1.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18
stable/6.6 stable/7.0

Fixed status
mainline: [40a25d59e85b3c8709ac2424d44f65610467871e]
stable/6.18: [a388e3dfaf9538a680de5ed43a8ebb5dd45b6e53]
stable/7.0: [55363fa0a04524d11efeaadee734d2db1756ed27]

CVE-2026-53164: iommu/dma: Do not try to iommu_map a 0 length region in swiotlb

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53164

Introduced by commit 433a762 ("dma-mapping: Implement link/unlink
ranges API") in v6.16-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ec91df8aff77e2e8fe3179c1f3fc15b43a40ba3]
stable/6.18: [ab61c990a87d084f5565ee70340543e3a5394697]
stable/7.0: [b16f8d40bac9ced838d24c9842707af9ecae92e2]

CVE-2026-53165: iomap: avoid potential null folio->mapping deref
during error reporting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53165

Introduced by commit a9d573e ("iomap: report file I/O errors to the
VFS") in v7.0-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2eea7f44b9c8b42fd7d3a1a87c06a7cd1b99c327]
stable/7.0: [1ad453817a4077230d1ba88eb0868f05f824449a]

CVE-2026-53166: futex/requeue: Prevent NULL pointer dereference in
remove_waiter() on self-deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53166

Introduced by commit 3bfdc63 ("rtmutex: Use waiter::task instead of
current in remove_waiter()") in v7.1-rc1.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18
stable/6.6 stable/7.0

Fixed status
mainline: [74e144274af39935b0f410c0ee4d2b91c3730414]
stable/6.18: [16f8e17184b31382076f84751db5ac51fc02733e]
stable/7.0: [1f2f3f3eacd6653ab215c5d2ea70811148d433fc]

CVE-2026-53167: fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53167

Introduced by commit 2d45ba3 ("fuse: add retrieve request") in v2.6.36-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e3d1b2c48ca6c55f1e9ca7f8dccc76f120f276c]
stable/6.18: [56763afa013444a9d84ca1b74e4b7130942177ba]
stable/7.0: [1fb8735a3a4d894f8c1f90b741a3ab1d3817f9bd]

CVE-2026-53168: fuse: reject fuse_notify() pagecache ops on directories

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53168

Introduced by commit 5d7bc7e ("fuse: allow using readdir cache") in v4.20-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c954499d43aefac01c5dfb57a82b13d2dcf4b94]
stable/5.10: [15487f98863dc7156ed43c5be26d478beb82ba35]
stable/5.15: [bd23fa0c16c5c86e5b7713224ffbb87d9db81cca]
stable/6.1: [9dbf1b2fadfc6c40805631d8a8276d1639fc9ab6]
stable/6.12: [99c317d7f8b7bbf3de16d20a01f363e390114cea]
stable/6.18: [12df4cfa738aefff21756728e91056d7defb0fe6]
stable/6.6: [dd92773d4d9cea010474eb08a5133c14ff6ab53a]
stable/7.0: [e692f0cb86204dcdb9dddc0b355407eda6394a67]

CVE-2026-53169: accel/ethosu: reject NPU_OP_RESIZE commands from userspace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53169

Introduced by commit 5a5e9c0 ("accel: Add Arm Ethos-U NPU driver") in v6.19-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef911805d86a05363d3ec2fa9835a41def83bb7e]
stable/7.0: [70090a32f56a4589e7e860e0f9a8fbe4417df0a1]

CVE-2026-53170: accel/ethosu: reject DMA commands with uninitialized length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53170

Introduced by commit 5a5e9c0 ("accel: Add Arm Ethos-U NPU driver") in v6.19-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9d021218162b6c4fe0bdf42b2b340f1aae23a12]
stable/7.0: [fb25c76a820ca8a547aa478bfb503da0a11494ab]

CVE-2026-53171: accel/ethosu: fix arithmetic issues in dma_length()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53171

Introduced by commit 5a5e9c0 ("accel: Add Arm Ethos-U NPU driver") in v6.19-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee6d9b6e51626f259c6f0e38d94f91be4fd14754]
stable/7.0: [6bb73845d1855ceaf50e397175e5979a7bdf69bc]

CVE-2026-53172: accel/ethosu: fix IFM region index out-of-bounds in
command stream parser

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53172

Introduced by commit 5a5e9c0 ("accel: Add Arm Ethos-U NPU driver") in v6.19-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00f547e0dfecf83014fb32bcba587c6b684c1362]
stable/7.0: [ee7bed779def61ebff1b92b0e851f412176fa416]

CVE-2026-53173: accel/ethosu: fix OOB write in
ethosu_gem_cmdstream_copy_and_validate()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53173

Introduced by commit 5a5e9c0 ("accel: Add Arm Ethos-U NPU driver") in v6.19-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0837b9cf6eabbad8b8cbddaff1a46a6d0a2e29d]
stable/7.0: [db6cb3e35cebf487f9a78ebd4cfa4b83708ff40d]

CVE-2026-53174: ovl: keep err zero after successful ovl_cache_get()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53174

Introduced by commit d25e4b7 ("ovl: refactor ovl_iterate() and port to
cred guard") in v6.19-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1711b6ed6953cee5940ca4c3a6e77f1b3798cee2]
stable/7.0: [e7051909a01bfb883bfa78b27514854068ac4b85]

CVE-2026-53175: inet: frags: fix use-after-free caused by the
fqdir_pre_exit() flush

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53175

Introduced by commit 006a503 ("inet: frags: flush pending skbs in
fqdir_pre_exit()") in v6.19-rc2.
Fixed in v7.1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [32594b09854970d7ba83eb2dc8c69a2edd158c8e]
stable/6.12: [c22599cc90e1cd5f8129c8670bd68a02ff7177b4]
stable/6.18: [89b909e9704587bfecc1aab1d37e98faee03b9f9]
stable/6.6: [0e823ca0e7391630784ae7dd0981b7ad170a93d9]
stable/7.0: [010c3313a4d178dc2d3ce958d2e5cb055e2864c1]

CVE-2026-53176: IB/isert: Reject login PDUs shorter than ISER_HEADERS_LEN

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53176

Introduced by commit b8d26b3 ("iser-target: Add iSCSI Extensions for
RDMA (iSER) target driver") in v3.10-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29e7b925ae6df64894e82ab6419994dc25580a8a]
stable/5.10: [75ee6e4aa096aa9e7b2dd5c8ff98356e30aceefb]
stable/5.15: [e8a013c0c3ca2f6708341a56612a3f6d6921620a]
stable/6.1: [bd22740d7f14cb1c0289444cfd2c8d2938667c1d]
stable/6.12: [c5584e089b5af7b3bf8bd5e8ca0560cbf32b0a47]
stable/6.18: [df422fd273c96c2ee5beb80fc21adc8c70c29260]
stable/6.6: [c1234229399f4af12c553b1b0ffd978eeba65548]
stable/7.0: [1ca40b243277c9e88be5e00bd3e083f71aefb93e]

CVE-2026-53177: bnxt_en: Fix NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53177

Introduced by commit e5811b8 ("bnxt_en: Add IRQ remapping logic.") in v4.17-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d930276f2cddd0b7294cac7a8fe7b877f6d9e08d]
stable/5.15: [964b1c3eb71afe58bb61c8b984164447e000ae8a]
stable/6.1: [59c5a3e69c7630a811565937e64be70b08436761]
stable/6.12: [08e57d014ea19f303d5d57a849beb846f37788b7]
stable/6.18: [3884976f87448e269908ae61bd5d62d54ce9c0c7]
stable/6.6: [1a418ad0e5e525d1d117dd1601681f75455af320]
stable/7.0: [580844a9683afe7974856dd5b7886447435b3474]

CVE-2026-53178: staging: rtl8723bs: rtw_mlme: add bounds checks before
ie_length subtraction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53178

Introduced by commit 2038fe8 ("staging: rtl8723bs: fix spacing around
operators") in v7.0-rc1.
Introduced by commit d3fcee1 ("staging: rtl8723bs: fix camel case in
struct wlan_bssid_ex") in v5.15-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88e994c57a79f62d5338231d8d37ee8dd98baffe]
stable/7.0: [542d65a6dbd9733baab96313c9fe76a76e93f484]

CVE-2026-53179: staging: rtl8723bs: fix buffer over-read in
rtw_update_protection

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53179

Introduced by commit e945c43 ("Staging: rtl8723bs: Delete dead code
from update_current_network()") in v6.10-rc1.
Introduced by commit d3fcee1 ("staging: rtl8723bs: fix camel case in
struct wlan_bssid_ex") in v5.15-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [514ab98364595007d4557ecc85d7e5f012c504d3]
stable/6.18: [735dabdf21561a24d8bcae456c9c32f7f961a029]
stable/7.0: [303f65af819f6d5aa302e82bce72b57a8575faea]

CVE-2026-53180: timers/migration: Fix livelock in tmigr_handle_remote_up()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53180

Introduced by commit 7ee9887 ("timers: Implement the hierarchical pull
model") in v6.9-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d486b4934a8e504376b85cdb3766f306d57aff5b]
stable/6.12: [07b3b83587fb3012619f4439389b64a955fc7836]
stable/6.18: [1d6c2062b77be09ec15d6bf637b2e2221c4482fc]
stable/7.0: [d338e61ea94052a786aac9f58e9f0d8520afa0fd]

CVE-2026-53181: vsock/vmci: fix sk_ack_backlog leak on failed handshake

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53181

Introduced by commit d021c34 ("VSOCK: Introduce VM Sockets") in v3.9-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c05fa14db43ebef3bd862ca9d073981c0358b3f0]
stable/5.10: [22c587aa3ab1ab5264daff3ec32136fd30436c13]
stable/5.15: [cf7090e255d74c4b61c51f8ede9fcacdd8393b5b]
stable/6.1: [ea0b03d52881c12a8c634ea0d6cbfa61cefdb488]
stable/6.12: [bcb275626055df7f8f947f1a349754b4004d9a15]
stable/6.18: [ba9ad6015937a5e46ba1a31370e3efdec8abbdcc]
stable/6.6: [dfd853197615d322d3a88dbcab91fc0fd2096219]
stable/7.0: [9698582a4dd9c4a05889d7db96d4c0edc9e69cac]

CVE-2026-53182: wifi: nl80211: reject oversized EMA RNR lists

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53182

Introduced by commit dbbb27e ("cfg80211: support RNR for EMA AP") in v6.4-rc1.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [4cd92957e8f8cc4ebfe8a5d4203c14c592fde6b1]
stable/6.1: [fc0ec2fc02dfe52c5821f36fbccf6a45df43f508]
stable/6.12: [30c3fa80f423613efdda3deca4af52ff7d20e4e2]
stable/6.18: [265c07c09c837621730d35f02975207a1224bf05]
stable/6.6: [688fcac7054abc680c0eef753f2bb772cfaf8cf7]
stable/7.0: [ecbf3c45add30a0857414e156bdb9c79906f0ff6]

CVE-2026-53183: mptcp: allow subflow rcv wnd to shrink

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53183

Introduced by commit f3589be ("mptcp: never shrink offered window") in
v5.19-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da23be77e1292cd611e736c3aa17da633d7ddce7]
stable/6.1: [bf364b0f10b27679140699821f88af7f01e2a6e3]
stable/6.12: [aa3861f40ac32706d9e97bfac76984613e278788]
stable/6.18: [653245266913f03fcf21cbca68eed5c197a33e52]
stable/6.6: [b1fd13074f22105deec45aa02283e322733e0c2d]
stable/7.0: [c297a4e65c50a2b807d9309b22615080faffa8f3]

CVE-2026-53184: udp: clear skb->dev before running a sockmap verdict

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53184

Introduced by commit 965b57b ("net: Introduce a new proto_ops
->read_skb()") in v6.0-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c94f241f776562c489876ff506f366224565c21]
stable/6.1: [263779a6beff03b8b06f6d25566cb0f45af361f2]
stable/6.12: [90d35188aaa92b8f8b23f66335e0e91bf60103a3]
stable/6.18: [6822eed69572000a181fa4e31fceacc60918c471]
stable/6.6: [1b585673a2249f13678e7ac443ac683ba767e0b6]
stable/7.0: [7d6d92d000ebe3a845a17c165c1d3a70c5d84fe1]

CVE-2026-53185: zram: fix use-after-free in zram_bvec_write_partial()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53185

Introduced by commit 8e654f8 ("zram: read page from backing device")
in v4.14-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [732fd9f0b9c1cdc6dfd77162ded60df005182cc0]
stable/6.12: [77a602b505ce4802915853cfc435a4722fab3e64]
stable/6.18: [c96786d6ff1acc1d54d9241e97767554c1dfdd5b]
stable/6.6: [0c2821665ff71be3f4b07ecece384669f2877f6a]
stable/7.0: [198b5a14cca27263b9c14b20114c8092de15dfcb]

CVE-2026-53186: RDMA/srp: bound SRP_RSP sense copy by the received length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53186

Introduced by commit aef9ec3 ("IB: Add SCSI RDMA Protocol (SRP)
initiator") in v2.6.20.16.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13e91fd076306f5d0cdfa14f53d69e37274723c4]
stable/5.10: [3889517c2ec7f364914aea8209abfff735f7ecde]
stable/5.15: [ed77cc819ad631264787cade5ae5ec4c535ec6bb]
stable/6.1: [0b9ee09d5e849591f17d98c078033dadea967293]
stable/6.12: [2015038195939eac54a1ee83c9d98ef1a8ccbbce]
stable/6.18: [f92a285db7ff6e598591ccbfb551be155c5f4d57]
stable/6.6: [0d64bc200ebe4f275b27438c6e593903e0b16fe1]
stable/7.0: [3523e53ff95f1837ec3f57ff7558532bcb2661b7]

CVE-2026-53187: RDMA/core: Validate cpu_id against nr_cpu_ids in DMAH alloc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53187

Introduced by commit d83edab ("RDMA/core: Introduce a DMAH object and
its alloc/free APIs") in v6.17-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [323c98a4ff06aa28114f2bf658fb43eb3b536bbc]
stable/6.18: [bd5e818be7964c1689fba2dad9e6bd3a827fee74]
stable/7.0: [0efbb6b54ff56300867027d8e0800d0e32226a20]

CVE-2026-53188: RDMA/core: Validate the passed in fops for ib_get_ucaps()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53188

Introduced by commit 61e5168 ("RDMA/uverbs: Introduce UCAP (User
CAPabilities) API") in v6.15-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a1b1ac2744694a2ecd66a84bdb1445f4ef24bee]
stable/6.18: [96b6e98ff12d50ed5817230c6f1188e1150d225d]
stable/7.0: [aa181287ebdcc53ee0ba5c2f8243e2d541ebc19b]

CVE-2026-53189: mm/huge_memory: update file PMD counter before folio_put()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53189

Introduced by commit fadae29 ("thp: use mm_file_counter to determine
update which rss counter") in v4.19-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d878059924f12c1bc24556a92ec56add74de3c8]
stable/5.10: [84b3212b166b446faea27ebebb7161405ffceef9]
stable/5.15: [108963978a681c0c468d279cac2b930c27672877]
stable/6.1: [459771c9cf30f378bdbd30fc65d17f7eb931bb59]
stable/6.12: [6c29a8ba084e89499ca77b947e07ae817f9c16ce]
stable/6.18: [5f5b604e1e6bde4e889199168ee80fe8306d06ad]
stable/6.6: [ae9d4caf6f133e884cf5fcda4982c493b35e5194]
stable/7.0: [ed5b030931292c94133437ac5e5ff580e498eabd]

CVE-2026-53190: drm/virtio: fix dma_fence refcount leak on error in
virtio_gpu_dma_fence_wait()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53190

Introduced by commit eba57fb ("drm/virtio: Wait for each dma-fence of
in-fence array individually") in v6.5-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f26bb732cc136ab20176697c92f32c9c84cb125]
stable/6.12: [73524e9f96a278b521f257a78a845c49eb522bc1]
stable/6.18: [8348567a6afb24e2c9cafe8a321162d0eebe1411]
stable/6.6: [898bd0ccfed71651b881660c5d20ad73b5203174]
stable/7.0: [c0fffc874c264292e769f26194a2a5e66ce31810]

CVE-2026-53191: io_uring/net: inherit IORING_CQE_F_BUF_MORE across
bundle recv retries

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53191

Introduced by commit ae98dbf ("io_uring/kbuf: add support for
incremental buffer consumption") in v6.12-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed46f39c47eb5530a9c161481a2080d3a869cfaf]
stable/6.12: [f40570fda3f3a1f96aeaa4aef665ba274b2810b5]
stable/6.18: [0bbc9481f970b0b4ddb08cfa464db1cc93b74b56]
stable/7.0: [4973232a67e4137ab9399f504f7f2bdd847f96d2]

CVE-2026-53192: ALSA: timer: Fix UAF at snd_timer_user_params()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53192

According to the .vulnerable file, this bug was introduced by commit
3774591 in v6.12-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [053a401b592be424fea9d57c789f66cd5d8cec11]
stable/5.10: [92ad2d7f80cad43b046f093e808e11fe919d304a]
stable/5.15: [117743d62e1225e208568a3ffc2c07214f1347cb]
stable/6.1: [b2214914e461d0466548a52dfe4f4ee8ce362276]
stable/6.12: [38034d04d4a75bbca01df2b313ced0bcd0fa3242]
stable/6.18: [3d39da65b5c422c5e5afb7d5651b0698d060a827]
stable/6.6: [e2331730175f74169046d2af8db1b47243df7c7a]
stable/7.0: [306427adf9b97e29e5958cb9cf3096c6151fc9ff]

CVE-2026-53193: ALSA: timer: Forcibly close timer instances at closing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53193

Introduced by commit 3774591 ("ALSA: timer: Introduce virtual
userspace-driven timers") in v6.12-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da3039e91d1f835874ed6e9a33ea19ee80c2cb92]
stable/6.12: [586b219a22b1032b28b8bd356b963276c5e5bf53]
stable/6.18: [f46093dd22969037beb1fce2e043f3236be41c92]
stable/7.0: [60e73ab87b84bbd6bd7ddd1d16019a3a3705ab8f]

CVE-2026-53194: USB: serial: kl5kusb105: fix bulk-out buffer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53194

Introduced by commit 60b3013 ("USB: kl5usb105: reimplement using
generic framework") in v2.6.35-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96d47e40bf9db4a9efd5c8fb53287a508d165f14]
stable/5.10: [60af1fd82983c26604102e63a3fcc822c186cceb]
stable/5.15: [0a57320f71941d4e0b1307453c9a1f0939afe666]
stable/6.1: [14147b7963685957839c76ba8094924e22777d79]
stable/6.12: [70d86e355c564b5510fde61361df014f5476c83e]
stable/6.18: [372f33ebed747d91870f57c0a2e62884a870bffa]
stable/6.6: [a1288cd700f721c1a119c4f1e8efa234e59caada]
stable/7.0: [bde742b076cbe26ecc89c8c68c76ae076a524d02]

CVE-2026-53195: USB: serial: io_ti: fix heap overflow in build_i2c_fw_hdr()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53195

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0fd2b00b2d3d05e3eaa13342b3dfb0fa85c226ae]
stable/5.10: [3e187152f44d76d7633a3855ffd0099e1588b82a]
stable/5.15: [b7faf660eefa2047ebc2959ff76da2b6eae2e9e3]
stable/6.1: [2fd64bf0ad66ab5de0c73524591d879427ba5aba]
stable/6.12: [130d6567eb148040eed1b73e1414ad6c27d22bd5]
stable/6.18: [294692d3296eee3391c348d7ea6401916d27806c]
stable/6.6: [4cb722747ed25971f35cc47ce5c0e79d7f717713]
stable/7.0: [5a79b634ee58786ca627268daefa7744f2af2e14]

CVE-2026-53196: USB: serial: io_ti: fix heap overflow in get_manuf_info()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53196

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [183c1076eca43bbb3e7bdf597456f91d81c73e74]
stable/5.10: [e168db91442b94e64fa82a7dd297983d48ea5cc0]
stable/5.15: [561edb021486e6723d841926aa4b48097da06190]
stable/6.1: [cfd634f6dfd40c49a84f9bddc2867a80e2e2623a]
stable/6.12: [b849f30d1a9e66aae6b715aaef66e427390cb081]
stable/6.18: [f96cf7bf9fbf15d7fcf0c91fec47ba8a010369ea]
stable/6.6: [d92f17af7097d10bdeddf26f66f34b354104b277]
stable/7.0: [d214d2341d4f9f447e36a7d012cdf6a6631a55f1]

CVE-2026-53197: xfrm: iptfs: fix ABBA deadlock in iptfs_destroy_state()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53197

Introduced by commit 4b3faf6 ("xfrm: iptfs: add new iptfs xfrm mode
impl") in v6.14-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c8a8a75b733467b00c08b91a38dbaf207a08ed6e]
stable/6.18: [a13ca53e47e500854a3b9ec18b5dc83acfec863e]
stable/7.0: [822b98d354e63e8249e85473c5f3c519f3c9cecc]

CVE-2026-53198: ksmbd: fix use-after-free of a deferred file_lock on
double SMB2_CANCEL

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53198

According to the .vulnerable file, this bug was introduced by commit
e2f3448 in v5.15-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f580d27e8928828693df44ba2db0fffdbe11dfea]
stable/6.1: [b7063c7426ea5a4d15e01b60538718765392f49d]
stable/6.12: [89ae9df09d2c1fb4a4eb495c113a7ce1dca34147]
stable/6.18: [14d2eee0193ac3cd1bf3d014373449f0b8d35d6d]
stable/6.6: [0da2e073f9cbf4985a0fd9acb71bc5ff599f8afd]
stable/7.0: [2b2eda2821cff1d1b5a423b6ee7d8fc6fbc8e694]

CVE-2026-53199: hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53199

Introduced by commit c25aaf8 ("hyperv: Enable sendbuf mechanism on the
send path") in v3.16-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [004e9ecfe6c5384f9e0b2f6f6389d42ec22789af]
stable/5.10: [16514afeb7d3d121072ba9a0b640d6c1c5507db0]
stable/5.15: [a82d4251918f37d9c5aab7b365157669fb885ec3]
stable/6.1: [695c59cf7bf707e6ff8cea01916ee50e86616933]
stable/6.12: [918c0c988239aa5ab96b254e504d191af6191061]
stable/6.18: [0b38870d81ab3a04c1ab0598d9d3285f5d9d0584]
stable/6.6: [09b8a7aa5a341bb345dc492aac139525efa13515]
stable/7.0: [fe7221b4346418d27ec2daccfc09df6692b76f0b]

CVE-2026-53200: KVM: arm64: nv: Fix handling of XN[0] when !FEAT_XNX

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53200

Introduced by commit d93febe ("KVM: arm64: nv: Forward FEAT_XNX
permissions to the shadow stage-2") in v6.19-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49b32ddb87a3a109afecea89e55d70f73956b8bc]
stable/7.0: [b95976c2ea446044553a5f469c0bae13553d75ab]

CVE-2026-53201: Revert "drm/xe: Skip exec queue schedule toggle if
queue is idle during suspend"

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53201

Introduced by commit 8533051 ("drm/xe: Skip exec queue schedule toggle
if queue is idle during suspend") in v7.0-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa7c84726dc217ce0c183926ef9411636c7a2213]
stable/7.0: [b69b715f48ac7e802c89ed5924795c5b055da91e]

CVE-2026-53202: accel/ivpu: Fix signed integer truncation in IPC receive

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53202

Introduced by commit 3b434a3 ("accel/ivpu: Use threaded IRQ to handle
JOB done messages") in v6.8-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9faef564438d1e4579c692c046603e7ada7bdf4]
stable/6.12: [4788556d4dd9d717037e385de178974e9649231d]
stable/6.18: [45cb105b8642c65e9be286f7058e92314efe7ea3]
stable/7.0: [2821bf2b79e47f87e1dbdd9d25c78240965a97d6]

CVE-2026-53203: accel/ivpu: Add buffer overflow check in MS get_info_ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53203

Introduced by commit cdfad4d ("accel/ivpu: Add NPU profiling support")
in v6.11-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb176425837693f50c5c9fc8db6fbb04af22bd0a]
stable/6.12: [d3c12ed33e8923f3090909a1738f3e59292996a6]
stable/6.18: [fa598556ecef412edcb391f144b7642e18fdfd45]
stable/7.0: [4e5047cc94bea1cc7b670b7f503358e9af0542df]

CVE-2026-53204: firmware: stratix10-rsu: Fix NULL deref on
rsu_send_msg() timeout in probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53204

Introduced by commit 1584753 ("firmware: stratix10-rsu: Migrate RSU
driver to use stratix10 asynchronous framework.") in v6.19-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfd2eb9bba548a8f63c3339bb1fb9a2031a42d86]
stable/7.0: [6bc249d324241c64118a3018124798c28e2950f7]

CVE-2026-53205: accel/ivpu: Add bounds checks for firmware log indices

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53205

Introduced by commit 1fc1251 ("accel/ivpu: Refactor functions in
ivpu_fw_log.c") in v6.13-rc1.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [dd1311bcf0e62f0c515115f46a3813370f4a4bb1]
stable/6.12: [5961c703414048f46818be8bbb11075a9a63fb4e]
stable/6.18: [8ec70c0dbdf04392a26e03e38798a373934177be]
stable/7.0: [535da9ad8420c3b686a642403d4147ff220255fd]

CVE-2026-53206: accel/ivpu: Add bounds check for firmware runtime memory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53206

Introduced by commit 2007e21 ("accel/ivpu: Split FW runtime and global
memory buffers") in v6.19-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d0b597facdd3c0239c88e8797c1014e1ea0ef15]
stable/7.0: [f8ab60ae9309e76d9a09c601c10cc222e25b3d5b]

CVE-2026-53207: mm/memory-failure: fix hugetlb_lock AA deadlock in
get_huge_page_for_hwpoison

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53207

Introduced by commit 405ce05 ("mm/hwpoison: fix race between hugetlb
free/demotion and memory_failure_hugetlb()") in v5.18-rc4.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [3c2d42b8ee345b17a4ba56b0f6492d1ff4c1178e]
stable/6.1: [fc3ff42cb0cbf947e4600ae9761c3783760050e2]
stable/6.12: [a33bfed648c10f5a1519981dbfad80841191edc8]
stable/6.18: [dd77a83915b07e2b0205adb284f08b39ae31dc4b]
stable/6.6: [77b73b54801ae7137479c141fd0473a491c1dc48]
stable/7.0: [bf7ba8f96c258c30393814491930ae4ecdc5fe5e]

CVE-2026-53208: Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53208

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd214733544427587a95f66dbf3adff072568990]
stable/5.10: [e05c4ac575b457978a7ef441053394169084869c]
stable/5.15: [fa5823126239b3e453fac1a2fe50726c7f4a55e1]
stable/6.1: [b20e8a98dd29b121f58fcdf51e8576119aba536a]
stable/6.12: [a8335f3db15bd1e0e82e0db5d488fabc7d10d1ab]
stable/6.18: [dedc92b96dc1d8919a3bdf2495ede68922ef7ebc]
stable/6.6: [214a2042b16b3c8d798a8b9ef9f36094f13a9859]
stable/7.0: [e2b8acf9405bd9b1baf1c54dc897b0905db689bf]

CVE-2026-53209: Bluetooth: hci_sync: reject oversized Broadcast
Announcement prepend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53209

Introduced by commit 5725bc6 ("Bluetooth: hci_sync: Fix broadcast/PA
when using an existing instance") in v6.16-rc2.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [5c65b96b549ea2dcfde497436bf9e048deb87758]
stable/6.1: [10b0e832cc05d7aef4b92bed912cbd4a395d0862]
stable/6.12: [02f50e8bb69f9b22516163a09922f5537d3b12d1]
stable/6.18: [dafc9f57140e66a10945127aa7433c3d715dc253]
stable/6.6: [1338ee049a8910ba6c9cee963920e978e6893c7d]
stable/7.0: [cdd8bbdbee763fdf5bf343e6f7d4e79347739f62]

CVE-2026-53210: tee: shm: fix shm leak in register_shm_helper()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53210

Introduced by commit 7bdee41 ("tee: Use iov_iter to better support
shared buffer registration") in v6.8-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26682f5efc276e3ad96d102019472bfbf03833b2]
stable/6.12: [4277759906b44d923a38c8f59f5576501b187b0d]
stable/6.18: [c10c9c48b2903f41ed4c532043b0576e86228236]
stable/7.0: [dbf779db927414f5b37c1f666013e9b48a88cfde]

CVE-2026-53211: netfilter: nft_meta_bridge: fix stale stack leak via
IIFHWADDR register

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53211

Introduced by commit cbd2257 ("netfilter: nft_meta_bridge: introduce
NFT_META_BRI_IIFHWADDR support") in v6.18-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c7d573551f9286100a055ef696cde6af54549677]
stable/6.18: [07acb9798477535933bd658ac9fa85b6cb10d995]
stable/7.0: [f1e81d571e375d10e50e852223593493d98c1bac]

CVE-2026-53212: netfilter: nft_tunnel: fix use-after-free on object destroy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53212

Introduced by commit af308b9 ("netfilter: nf_tables: add tunnel
support") in v4.19-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c32b26aaa2f9216520a38b3f4bfeec846eb3eb8a]
stable/5.10: [349df61526d2e39decc685d246202e3e284cfe05]
stable/5.15: [55b79b1ae42372012413ce0413181d26679b17ef]
stable/6.1: [5e9ee18b27fde88cb6148202b33916c66693fe82]
stable/6.12: [fda6573a46ad24f35348e024905ee5bdf729797e]
stable/6.18: [941d7394efda5e054e2d6f3e0dd0f6a9ba19aaa3]
stable/6.6: [8767fe4079affa74314d7eb3220e700150289842]
stable/7.0: [f9a0e4b61054cde89a2a77845293c726cc07cc43]

CVE-2026-53213: drm/vc4: fix krealloc() memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53213

Introduced by commit 6d45c81 ("drm/vc4: Add support for branching in
shader validation.") in v4.8-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d563a5da8717629ae72f9eadf1e0e340bd1658b]
stable/5.15: [30165a09f76eaf34951c818eb5d9d6e4771d76f6]
stable/6.1: [fd87d6966041e33ef7d2e5dc59f9a52b71c6ae5f]
stable/6.12: [c034aa0b1ba5f49cbdf8ef193d6ec714d74aac27]
stable/6.18: [02f5e4db57c0cdd7bac89d503b301a093a0fa95c]
stable/6.6: [e0ce103e89d61eef70edc1d1ae3bfd4c0aacbc2e]
stable/7.0: [4fc692dc6df5bc777cc1bcebf95179e28594875f]

CVE-2026-53214: ipv6: Fix a potential NPD in cleanup_prefix_route()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53214

Introduced by commit 5eb902b ("net/ipv6: Remove expired routes with a
separated list of routes.") in v6.9-rc1.
Fixed in v7.1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [b70c687b7cf267fb08586667a3946c8851cad672]
stable/6.12: [192df376a05c2db15564640f9da7e20907c1fa24]
stable/6.18: [07d9a0870a178843cea44cfd58c27445dc94cf5f]
stable/6.6: [5f82b02b4059ddc06e4fcfd057bfb59fd6885cd2]
stable/7.0: [653a2849305708f75260b5296f17b2a759ff9cc7]

CVE-2026-53215: net: mvpp2: refill RX buffers before XDP or skb use

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53215

Introduced by commit 07dd0a7 ("mvpp2: add basic XDP support") in v5.9-rc1.
Introduced by commit d652692 ("net: mvpp2: fix memory leak in
mvpp2_rx") in v5.9-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e8e2a9624df72fca7c736b2966b2cbf6c9c3ff6]
stable/5.15: [a88b3293b556f4d8fba11db9a8061a6b0d3b69e6]
stable/6.1: [a03cdcedb2cbcc42551dc3e4746929e93c5352d5]
stable/6.12: [d0c8c4fbd22d260fe28530260656c5fb3c20ce84]
stable/6.18: [8a2126c5afe89f8ceeb60a3afb9f075b736194cd]
stable/6.6: [580f92f27cb8724bcc4be98ee89890eab524a2ae]
stable/7.0: [02e1b5c4d3b4c658b72c145427cded1bba613fc1]

CVE-2026-53216: net: mvpp2: limit XDP frame size to the RX buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53216

Introduced by commit 07dd0a7 ("mvpp2: add basic XDP support") in v5.9-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3c6aa078927e6fe8121c9c591ddee8716c5305a]
stable/5.15: [a3ee9231ccec6ec3be2de89c56f897055fd9eab1]
stable/6.1: [ec8e1e5842bc0dbd4c272761f4db3651eecd0339]
stable/6.12: [994bd2b58d2bd08aa97ec0836cc813cfcb00d749]
stable/6.18: [910617a4e67dbdd5fdb39d9dc6a51e491e1b2c3e]
stable/6.6: [3b8b0c3631b19faee53f0d15a49924129b063eec]
stable/7.0: [9545cc5ef18ca22d031f2f47c157192460652359]

CVE-2026-53217: net: mvpp2: sync RX data at the hardware packet offset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53217

Introduced by commit e192116 ("mvpp2: sync only the received frame")
in v5.5-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [180235600934bef6add3be637c296d6cf3272e67]
stable/5.10: [60412bdd1b2576659eac23a23d2d9ff96228a643]
stable/5.15: [19f8bc139e9b149d1e5bf75ae761d1bb8dd3e7d8]
stable/6.1: [a3ad9b5767c89531fc7dae951b51b0933dcf7051]
stable/6.12: [23548007b3c66d628fc7d6b80d1e23be04ea10d9]
stable/6.18: [a13199fa224e9f776f4005d5037df03aa9ea8f37]
stable/6.6: [bede0f481b9137d73d1cf64309cbe4b94818a5d6]
stable/7.0: [e302206ad84a407a7e5f3f6fe767ff5efaace689]

CVE-2026-53218: netfilter: nft_exthdr: fix register tracking for F_PRESENT flag

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53218

Introduced by commit c078ca3 ("netfilter: nft_exthdr: Add support for
existence check") in v4.11-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [772cecf198da732faebb5dcfc46d66a505be8495]
stable/5.10: [8738b1b6d0e639ca1fc0f61516afd3557ac4ecc6]
stable/5.15: [19748967d59c31d24d21d40b728570788310b237]
stable/6.1: [46fc15a044e9938e7ea77786fb37edd2cd74f031]
stable/6.12: [67b27434c43b68a97becda98c9f0c8cf6cba2134]
stable/6.18: [78069a6d8bc86c9e036eb82c2af4a19cc1871a53]
stable/6.6: [cd513e43b4b2bd1de39e2367bc4261c699a8652f]
stable/7.0: [f08fb3d42fd3aad0b7a263da3ac3ebaf0845e265]

CVE-2026-53219: netfilter: x_tables: avoid leaking percpu counter pointers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53219

Introduced by commit 71ae0df ("netfilter: xtables: use percpu rule
counters") in v4.2-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7f2fbb0e893a0238dc464f8d8c0f5609bec584f]
stable/5.10: [b74ba3343eb44b2cbf7e9665918c287df1d52ebb]
stable/5.15: [0b35dc8527ccc16b7dc34e8a3164313e68cd4e45]
stable/6.1: [b28e2fcad3db7e8687b15bc20bced26b5b7c920e]
stable/6.12: [8d67e42ad3b1a95a152541015a07110e06992d6c]
stable/6.18: [08a3e218064db11f154ad9ad5541751ea7f34ebe]
stable/6.6: [a0d16941adf3a501956d74aefd8d6e217906e79c]
stable/7.0: [fb0521aff1e10e300d89725cc439d3ea74c828c5]

CVE-2026-53220: netfilter: revalidate bridge ports

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53220

Introduced by commit f350a0a ("bridge: use rx_handler_data pointer to
store net_bridge_port pointer") in v2.6.36-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ccb9fd4b87538ccf19ccff78ee26700526d94867]
stable/6.12: [43330a1e8aace6b5a8de9aba127e9e394ab49b0f]
stable/6.18: [4beffcd726e2a731cea4dc18e1fbc55c8d76f1a0]
stable/7.0: [d4b1301fd3c9e5e105fd3767c68bc4ba558bb228]

CVE-2026-53221: ip6_vti: fix incorrect tunnel matching in vti6_tnl_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53221

Introduced by commit fbe68ee ("vti6: Add a lookup method for tunnels
with wildcard endpoints.") in v3.19-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5c0359f5cbc51a2e2b114d6041e0f3c73f903e9]
stable/5.10: [c327fa4fca31415431202e063767a7ae342e19c6]
stable/5.15: [fc657ac0767c49839b3ef0b08dc0953ca30883f8]
stable/6.1: [47fb3c2b4203556308e64354b3e78f2ce221d646]
stable/6.12: [90fd4513315ca07da99cfd8549d3e553a7160f0d]
stable/6.18: [2abfb19bbb81958714ad1d43ebeb65b30394184b]
stable/6.6: [f513f308cc4bdb4530d033431592ffbc29b7fca1]
stable/7.0: [2fc7bc087cc7085368263d9d37bfe9a0bddd6a2d]

CVE-2026-53222: ptp: ocp: fix resource freeing order

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53222

Introduced by commit a60fc32 ("ptp: rework ptp_clock_unregister() to
disable events") in v6.18-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [627366c51145a07f675b1800fb5ea2ec960bd900]
stable/7.0: [aa03698bb28d3be5ee180adb185395054b342b04]

CVE-2026-53223: net: guard timestamp cmsgs to real error queue skbs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53223

Introduced by commit 8605330 ("tcp: fix SCM_TIMESTAMPING_OPT_STATS for
normal skbs") in v4.11-rc4.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1ee90b77b727df903033db873c75caac5c27ec98]
stable/5.10: [24a0d548d3a765cd4558224e4f8e06e14cba26e3]
stable/5.15: [71ff5cdd5da61d0438e902aa0fd68c28bc901abe]
stable/6.1: [ad9a0374ee6d11048e1f74cd5180bad58b9848b4]
stable/6.12: [e0665b2a8e90bb08bd205062c75662b502d31797]
stable/6.18: [3dde4fb941fa5649ab809f6cd3e20e0c424a4e31]
stable/6.6: [b903e9b5629ec8dd6db92174070045bf81ad7060]
stable/7.0: [eb51a9ad3ceb01bc6c0fb608dbc856e03ee6f24a]

CVE-2026-53224: sctp: validate embedded INIT chunk and address list
lengths in cookie

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53224

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f4c80a2a7e6d06753b89a578b710a2499a5e62b]
stable/6.18: [7560afb8cddafd829e709d7ea09230e45a825557]
stable/7.0: [512a9bb77c04ac9927648ea58af617e472be96e6]

CVE-2026-53225: sctp: fix uninit-value in __sctp_rcv_asconf_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53225

Introduced by commit df21857 ("[SCTP]: Update association lookup to
look at ASCONF chunks as well") in v2.6.25-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8373d7090b745728de66308deeecc67e8d319ce]
stable/5.10: [446e0ecd845abc394b24ae2030a883572bec9d16]
stable/5.15: [928dd94db23e8ba340f83d68f7f24d831b7a4426]
stable/6.1: [d796cfd06074b579d265b28401306cadd30db945]
stable/6.12: [d6bd0bb7697ea8c0387b0d9d973453f479017b23]
stable/6.18: [f76a8b323e28e0951f979dbef20a7496383c47df]
stable/6.6: [8ce96f1182644079249a24ac7e2ffc32e0301a46]
stable/7.0: [8e86817b8af4d552f3c6fe04ca52bb0c8c57411d]

CVE-2026-53226: gpio: rockchip: fix generic IRQ chip leak on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53226

Introduced by commit 936ee26 ("gpio/rockchip: add driver for rockchip
gpio") in v5.15-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c1e0fc88d6ef65bf15d517853251f75ab9d18c3]
stable/6.18: [bace7b99bfa555fe833aee8827b8004c43666d02]
stable/7.0: [1f34ea5f6114011092d9a5c8b901ad6741144a1d]

CVE-2026-53227: net: openvswitch: fix possible kfree_skb of ERR_PTR

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53227

Introduced by commit 893f139 ("openvswitch: Minimize
ovs_flow_cmd_new|set critical sections.") in v3.16-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee30dd2909d8b98619f4341c70ec8dc8e155ab02]
stable/5.10: [e248fb2e680deb2bd37bac551b72638fe4938a76]
stable/5.15: [0bb5b2dc1b90aa7dd1473fc8c4d813a29255ff8d]
stable/6.1: [971b1b37774f13acc5add0a2843f8598446b8598]
stable/6.12: [e3d509a1b71396e1452060dbf84a805fd1c3c549]
stable/6.18: [ecc55aad3390129a87106841f4b68bf3d70c9264]
stable/6.6: [25fdf53698535fe8790237f5a8a9626791429785]
stable/7.0: [895d1dd9057cde1687fa0f4286d47ceed0b82997]

CVE-2026-53228: ipv6: sit: reload inner IPv6 header after GSO offloads

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53228

Introduced by commit 1490966 ("sit: Setup and TX path for sit/UDP
foo-over-udp encapsulation") in v3.18-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0e42f0c4337b1f220de1ddd63f47197c7dee4de]
stable/5.10: [fddd41445a0537b093e6b3f6232c9933cad1e48b]
stable/5.15: [1132e5edc2866c3530be17622153a597095f0e43]
stable/6.1: [9c67b44edb3598d234efae6e44649eb993c03da5]
stable/6.12: [59f80c919713250fe5d25a4d9aea4e49580fa1d4]
stable/6.18: [2fa49b2715e1bad12ce3b0fa64e234d9582c8193]
stable/6.6: [0bfa7bba1f41aaf5f0604dc712bb4701493e3aa0]
stable/7.0: [cb658c2f5f7977c2a1c77c9f239f4bc8196edb5c]

CVE-2026-53229: net/mlx5e: xsk: Fix DMA and xdp_frame leak on XDP_TX
xmit failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53229

Introduced by commit 84a0a23 ("net/mlx5e: XDP_TX from UMEM support")
in v5.3-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b69004f5a6ad32da84d8aa5b23b9c0caafe6252e]
stable/6.12: [7b3eeba50fbc3b45f279037c29a87a90e8bac1e1]
stable/6.18: [2789b74ae1f4b68333c9d5eec2f3354d07b16e61]
stable/7.0: [0aabca726b43d833721034e97d99efcc8237b22a]

CVE-2026-53230: net/mlx5: Fix slab-out-of-bounds in
mlx5_query_nic_vport_mac_list

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53230

Introduced by commit e16aea2 ("net/mlx5: Introduce access functions to
modify/query vport mac lists") in v4.5-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [894e036a24a26a6dd7b17d8d3fb5c53ab48a6074]
stable/6.12: [537d87784e81c3d7037525b99416455cee088cdc]
stable/6.18: [0f807764bb122fd63aa45f4229cb1ef2679fbd40]
stable/6.6: [41781f2789309462520a93822e946521ed78f97f]
stable/7.0: [2398e497389ed4be43f7cfbab499b49cec7dae1a]

CVE-2026-53231: net: phy: don't try to setup PHY-driven SFP cages when
using genphy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53231

Introduced by commit bad869b ("net: phy: Only rely on phy_port for
PHY-driven SFP") in v7.0-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a0082ec20a05ef2378410323a5089a8f1786f4a]
stable/7.0: [ef8d739eee6f85303cbecebc01eb72f063de74e0]

CVE-2026-53232: net: phy: clean the sfp upstream if phy probing fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53232

Introduced by commit 298e54f ("net: phy: add core phylib sfp support")
in v5.5-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48774e87bbaa0056819d4b52301e4692e50e3252]
stable/6.12: [9326b654f90a09eadeb796c82801a5609d57f0c8]
stable/6.18: [3a254779c169954fe23328a1db51f67be374f913]
stable/6.6: [12fb84dc4dc8eb47ebe2b27f7de6255a4a205e1b]
stable/7.0: [0b27701ce93161d7bbf4b25fa20ca59963b0e20c]

CVE-2026-53233: netdev: fix double-free in netdev_nl_bind_rx_doit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53233

Introduced by commit 170aafe ("netdev: support binding dma-buf to
netdevice") in v6.12-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c849de7d8757a7af801fc4a4058f71d481d367f2]
stable/6.12: [e055ca9205d3eb6aec3e5fe4ecc18abbbf18c599]
stable/6.18: [c299321bc6232770ce378d6fa6bc46004d2d7fdb]
stable/7.0: [9b019376cbee10c4f9184d1745fa37d156e36f30]

CVE-2026-53234: net: ibm: emac: Fix use-after-free during device removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53234

Introduced by commit a4dd853 ("net: ibm: emac: use devm for
register_netdev") in v6.12-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0130d682222ae21afc395aead7cd2d87e1a8358]
stable/6.12: [cf8e14db93eaecc4c0c58299be3b3183b0e53ed5]
stable/6.18: [c09c2e236eef6f59e105f38a30f5439e6ccbcad7]
stable/7.0: [c12584cd6078085d707266be864e7e1cc91d74e3]

CVE-2026-53235: net: add pskb_may_pull() to skb_gro_receive_list()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53235

Introduced by commit 8d95dc4 ("net: add code for TCP fraglist GRO") in
v6.10-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2bb3434544454099a5b6dec213567267b05d79d]
stable/6.12: [9e636c995b7beeb74ea882968248752821c244c4]
stable/6.18: [0cde3a004119db637b401c54e77536e4145fc0b4]
stable/7.0: [848571dcbbbea7ba44dd4f7ebe1fbb274afe08ac]

CVE-2026-53236: tcp: restrict SO_ATTACH_FILTER to priv users

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53236

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d39580f68e6ddeedd15e587282207489dfb3da2]
stable/6.1: [3747de241a66ef2c7032d2cc2b826a47c5fa0f6a]
stable/6.12: [82b3e7ce10c53fc12aab8904745603efc74f8c07]
stable/6.18: [ede69b8f6670600e534591664584f810d7c385f9]
stable/6.6: [ecfe9171b26ae3eed0cd8bab7a943e9e2c9e51ba]
stable/7.0: [c68517a3e18e20997808821c5559d0cba4d776c1]

CVE-2026-53237: gpio: mvebu: fix NULL pointer dereference in suspend/resume

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53237

Introduced by commit 757642f ("gpio: mvebu: Add limited PWM support")
in v4.12-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b9ad50d7505ebd48282ec3630258dc820fc85c81]
stable/6.12: [4ef24338eda3c7e96d6f94a988266ff16ed3985d]
stable/6.18: [6136c1474db88272231573e222896e1998d34662]
stable/6.6: [7db09011ce62162d72897fc4856b4425245dfe35]
stable/7.0: [c9677a9274ffb44987ec209dc8ec9f2d34946956]

CVE-2026-53238: netlabel: validate unlabeled address and mask attribute lengths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53238

Introduced by commit 8cc4457 ("NetLabel: Introduce static network
labels for unlabeled connections") in v2.6.25-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9772589b57e44aedc240211c5c3f7a684a034d3a]
stable/5.10: [975a84fd741440853380d37465b6e226cf47254c]
stable/5.15: [672f0f3b8f875ffe6525a37847eafa7648c4c0c6]
stable/6.1: [95bda3eac0b1454c2cee98d58d9ba6dd8391e843]
stable/6.12: [71c52da13c3737493b42d20d9f33de34e03b3156]
stable/6.18: [0c4bb32ad7fdc2dc6a8050f41eb04d4bda56b6c8]
stable/6.6: [07a18f5c90dd3d586b73242f5a5bbf0a72f2fdc6]
stable/7.0: [ccfe292a966079c61ea68a2da303b2a336170993]

CVE-2026-53239: xfrm: policy: fix use-after-free on inexact bin in
xfrm_policy_bysel_ctx()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53239

Introduced by commit 6be3b0d ("xfrm: policy: add inexact policy search
tree infrastructure") in v5.0-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f2d76c9c03257c0782afef9d95321fa04096f60]
stable/5.10: [8fc536e9f6856230f19c7d13e71af064b6a77b22]
stable/5.15: [c4c1ea36d83bf3c4569468ca5b8b614fda1bf821]
stable/6.1: [25c8c7fb3b0b9668c7d05e209f58c158d2b020c7]
stable/6.12: [88697cf980222d5906a37bf47662dac0732e2a0f]
stable/6.18: [b5316e2b8614a87d8736941972441cb47bfd4491]
stable/6.6: [42827d03f8009a6a218bacab153e21f39d6a121c]
stable/7.0: [ec82ea4eb220164d854f8734ca5a35e23e577b94]

CVE-2026-53240: xfrm: iptfs: fix use-after-free on first_skb in
__input_process_payload

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53240

Introduced by commit 3f33398 ("xfrm: iptfs: add reusing received skb
for the tunnel egress packet") in v6.14-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb48730bb827d1550401a5d391903f9d90b493c8]
stable/6.18: [8d9a79fbf5172d9c4c0146057af2360913265a11]
stable/7.0: [ff2ee35b6ce5fa8a8e24ea50b15733d5c8780198]

CVE-2026-53241: ALSA: seq: dummy: fix UMP event stack overread

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53241

Introduced by commit 32cb23a ("ALSA: seq: dummy: Allow UMP
conversion") in v6.10-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b5ff4db5d7aa5b981d966df02e687f79ad7b311]
stable/6.12: [a7ef78a2c536242ccb7a4429da01580b2409bb24]
stable/6.18: [6671a46144f880c5a167930ebb14c12f3d059fe9]
stable/7.0: [6676b6063440561db600494049ce7ffb695c8cc4]

CVE-2026-53242: ALSA: PCM: Fix wait queue list corruption in
snd_pcm_drain() on linked streams

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53242

Introduced by commit 9b1dbd6 ("ALSA: pcm: fix use-after-free on linked
stream runtime in snd_pcm_drain") in v7.0-rc4.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [88fe2e3658726cb21ff2dcf9770bf672f9b9d31b]
stable/5.10: [cac5bf3500ee6422cf64e0df0b5daeecfed42917]
stable/6.1: [d842f26a167e77a36f3ed333b9fa99d36ef99fe6]
stable/6.12: [b053fcd8912f06c30f932f5b8ec41c72de474695]
stable/6.18: [cd98837db15f323463b8df07282ac723bd5c3fed]
stable/6.6: [d68b621bb5a48051932f1017a6e1bc9b18f854d0]
stable/7.0: [7c71a9522555ff137a9ca36b15d759ca04d84788]

CVE-2026-53243: rseq: Fix using an uninitialized stack variable in
rseq_exit_user_update()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53243

Introduced by commit 82f5724 ("rseq: Implement read only ABI
enforcement for optimized RSEQ V2 mode") in v7.1-rc3.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
stable/7.0

Fixed status
mainline: [6d99479799c69c3cb588fcda19c81d8f61d64ecd]
stable/7.0: [e12d20a63b61aaf9de4772effccf42cc9a003e58]

CVE-2026-53244: VFS: fix possible failure to unlock in nfsd4_create_file()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53244

Introduced by commit 64a989d ("VFS/knfsd: Teach dentry_create() to use
atomic_open()") in v7.0-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e824bbd4d224cce4b5fb59cc9dcd3447fe0b7e44]
stable/7.0: [ee1f40759a50b1800c98c1c369afd5b3e44ad987]

CVE-2026-53245: net/802/mrp: fix vector attribute parsing in
mrp_pdu_parse_vecattr

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53245

Introduced by commit febf018 ("net/802: Implement Multiple
Registration Protocol (MRP)") in v3.9-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7561c7fbc694308da73300f036719e63e42bf0b4]
stable/5.10: [ae65714d96f68bb252eb20085320bdaacab36c00]
stable/5.15: [36d259711872e3b2f6cd76a4d270c21931c0f35f]
stable/6.1: [cc98717e591a963a616fdf15ecf48eefaf45d758]
stable/6.12: [fd9c3a47c670bec6b18f44454cea023f93b5adb3]
stable/6.18: [42446ca0f3570663e87183c065e0b4def52dfba2]
stable/6.6: [6d6e42e8e17f18d61327f8653479c5b5e161ae1d]
stable/7.0: [6eea6494e542a03cdf755a593b7d74f3f7c260fd]

CVE-2026-53246: sctp: validate cached peer INIT chunk length in
COOKIE_ECHO processing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53246

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0861615c28de668669d748ef4eb913ea9262d13b]
stable/6.18: [cc272185c9a9a4b7febc2de52eeaa3d00f19091e]
stable/7.0: [edccbf3d63b0a3362bc916ea72edacc1e1ca456a]

CVE-2026-53247: net: ethernet: mtk_eth_soc: Fix use-after-free in
metadata dst teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53247

Introduced by commit 2d7605a ("net: ethernet: mtk_eth_soc: enable
hardware DSA untagging") in v6.2-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [80df409e1a483676826a6c66e693dba6ac507751]
stable/6.12: [459c6f35c58cf0fd5247e55d73ddaa29571d9b7e]
stable/6.18: [e634408d2b0cd939cfe019398a21fb47b7a8ffe3]
stable/6.6: [72775977e89c25c99ee84d2c5baa3f86a8ba5cb4]
stable/7.0: [2d86aeb46d5f69c704065a8c69822582787272a1]

CVE-2026-53248: net: airoha: Fix use-after-free in metadata dst teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53248

Introduced by commit af3cf75 ("net: airoha: Move DSA tag in DMA
descriptor") in v6.15-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b38cae85d1c45ff189d7ecb6ac36f41cdc3d84d0]
stable/6.18: [6f829e2c17a53a35321268339cd252aff6d6d723]
stable/7.0: [4b5a574e033e66d2131eff1c18feef8d8643c67e]

CVE-2026-53249: ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53249

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3915a1f5a4bc0ac911032903c3c6ab8df9fcc7c]
stable/5.10: [4cd6e9ed49347d3a2fdaaf07e32fb524756dddc2]
stable/5.15: [2a87c3e8f03ce655ed0ef500d64d5fd924ec3691]
stable/6.1: [89343ff12b3178fc236fe531a3603e7c97c68278]
stable/6.12: [00e8845fe3428c69e980dce5071cb3da1d8f7578]
stable/6.18: [a4f3fd6516920988c47ba8d19714985c40c816a1]
stable/6.6: [8ff85dbabbbfb05e86e6cde31d91ac5782179d4d]
stable/7.0: [28f5ad1b4055405eb1616e603fe511ba5e3725e7]

CVE-2026-53250: xsk: cache csum_start/csum_offset to fix TOCTOU in
xsk_skb_metadata()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53250

Introduced by commit 48eb03d ("xsk: Add TX timestamp and TX checksum
offload support") in v6.8-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22ba97ea9cc1f63a0d0244fae38057ed452b6ac7]
stable/6.18: [0dfe05b938435892875e07771170051346412df9]
stable/7.0: [bfdfd2706d5fb2cd496a1506e680daf979309c8b]

CVE-2026-53251: Bluetooth: ISO: Fix not releasing hdev reference on
iso_conn_big_sync

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53251

Introduced by commit 07a9342 ("Bluetooth: ISO: Send BIG Create Sync
via hci_sync") in v6.13-rc1.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [5cbf290b79351971f20c7a533247e8d58a3f970c]
stable/6.12: [4bbec25f47b930101294fd310c627c3f53e9661f]
stable/6.18: [33d677d2e3713d98012c3dbd4a9207f7d785b854]
stable/7.0: [23e8eb16820b866528fb300dc67fe3f67f00ef62]

CVE-2026-53252: Bluetooth: fix memory leak in error path of hci_alloc_dev()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53252

Introduced by commit 1d61231 ("Bluetooth: hci_core: Fix use-after-free
in vhci_flush()") in v6.16-rc4.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1
stable/6.12 stable/6.6

Fixed status
mainline: [37b3009bf5976e8ab77c8b9a9bc3bbd7ff49e37f]
stable/5.15: [5b7dfca6f852e6b9d809fd0263b5427cc9fb33fd]
stable/6.1: [c016118b9e51eeaf5bc93850d4c455a3b583c0aa]
stable/6.12: [bc2efe73c194a74839d7cf57b63880d97e21d309]
stable/6.18: [ce4b4cac3c5749b6aa75e62e2991ae2263f2f889]
stable/6.6: [0622e527a31d4b44737fed5c1a2ac1fc2cfb5184]
stable/7.0: [f82799407a50af7bcacacf09cc9b279af8fe9b81]

CVE-2026-53253: Bluetooth: bnep: reject short frames before parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53253

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6770d3a8acdf9151769180cc3710346c4cfbe6f0]
stable/5.15: [0ef2ea86c82b2615902d085cd5a586fe9f58994f]
stable/6.1: [2b83afb19293e4de700edae306115f18966dc4f9]
stable/6.12: [d76dec1a37122bc16d83d059c08c0512ea8de909]
stable/6.18: [c893e17d2809ec9c4b3f1cdd5847cecbc27a311b]
stable/6.6: [691f14b6a48b637655755134f1e551c7c6fedc2e]
stable/7.0: [be837cd09897e9e6e1958174501d467bdcbcc2bc]

CVE-2026-53254: Bluetooth: RFCOMM: validate skb length in MCC handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53254

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23882b828c3c8c51d0c946446a396b10abb3b16b]
stable/5.15: [7c15c7c2878957cbfed93bcc29c13fdace464254]
stable/6.1: [0d637136ce89f9a2309b2c3502402ce400dab0ef]
stable/6.12: [1b070ac9e99c2c2c3a8112943ca98ab6fca7f10c]
stable/6.18: [3eabc6d47a0ad22b053329997aaf0ec1e581e392]
stable/6.6: [98377e6b1a1a56561ec66a181573ea2b61b2079e]
stable/7.0: [08b9c1fbe78f4ad3f6250c6541cfaabdbeb81997]

CVE-2026-53255: Bluetooth: MGMT: validate advertising TLV before type checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53255

Introduced by commit 2bb3687 ("Bluetooth: Unify advertising instance
flags check") in v4.9-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de23fb62259aa01d294f77238ae3b835eb674413]
stable/5.10: [13ad995071a06570668dd8daab3616c247c72080]
stable/5.15: [06fcbd79c3c360a50f9be9d370769bbd738d0976]
stable/6.1: [f7093ac233c1e7f51d125534f46067772a113175]
stable/6.12: [18fea1cb0c2599752e908c8217490f73ddd33e00]
stable/6.18: [1a3c8ffbb469859b076445af44bdfa6a711d483e]
stable/6.6: [74c08e4db35a476c3462aeb65846f955be732626]
stable/7.0: [2a3f3ed9e198ae23c15859ace2f9ca6cfdc35b57]

CVE-2026-53256: Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53256

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43c441edacf953b39517a44f5e5e10a93618b226]
stable/5.10: [f5ec76bdbeb80f75ad0be204371afffee0f8fac8]
stable/5.15: [a07d741c077d4e34b16458241a94d29039386553]
stable/6.1: [1f73f92f66251065a5f39b09a47cf05ea14d3107]
stable/6.12: [b0e33e409715c617e2a20f46f99aa5403a14dfda]
stable/6.18: [8802413ce63175fb522a2bd609fb043a3550c720]
stable/6.6: [de31973ef00e5aa55496f84cf6a44bb157a34e02]
stable/7.0: [6f4462d12133106460d7c046b95aad2491e3fddf]

CVE-2026-53257: wifi: cfg80211: enforce HE/EHT cap/oper consistency

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53257

Introduced by commit 22c64f3 ("wifi: mac80211: Update MCS15 support in
link_conf") in v6.16-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb9959ab5f99611d27a06586add84811fe8102dc]
stable/7.0: [0f5e9ddd7e8e7758771a63cdd498a2007dc8da7a]

CVE-2026-53258: wifi: fix leak if split 6 GHz scanning fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53258

Introduced by commit c8cb5b8 ("nl80211/cfg80211: support 6 GHz
scanning") in v5.10-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8694f7cc29287e843648d1075177b9a2000d957]
stable/6.18: [fb8db813eba2e56ee001c9fb5c2ce2cb78c42642]
stable/7.0: [a24134ddc18b4d440714365637d440b7121447b9]

CVE-2026-53259: ipv6: anycast: insert aca into global hash under idev->lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53259

Introduced by commit eb1ac9f ("ipv6: anycast: Don't hold RTNL for
IPV6_JOIN_ANYCAST.") in v6.17-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f723ccaff2fb72b71ae8a9fd283f0dee4d9ae7a3]
stable/6.18: [15be7e9fdbff831fb3e89b83cc337a4f85ad3310]
stable/7.0: [3a967c498baa976b11d4800dda224c507416e97c]

CVE-2026-53260: tcp: Add preempt_{disable,enable}_nested() in
reqsk_queue_hash_req().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53260

Introduced by commit d2d6422 ("x86: Allow to enable PREEMPT_RT.") in v6.12-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e10902df24488ca722303133acfc82490f7d59ad]
stable/7.0: [b183215ff714efb747d9d5a429322ba6404b5401]

CVE-2026-53261: devlink: Release nested relation on devlink free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53261

Introduced by commit c137743 ("devlink: introduce object and nested
devlink relationship infra") in v6.7-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3522b21fd7e1863d0734537737bd59f1b90d0190]
stable/6.12: [a9137286884703113b1c9e6403bd6d7d97b14754]
stable/6.18: [927f96861f939c0b517d13ed27bf4fabbfc1cfb3]
stable/7.0: [11324d52b0c63f4f202b35793c6507a575e9a689]

CVE-2026-53262: l2tp: pppol2tp: hold reference to session in pppol2tp_ioctl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53262

Introduced by commit fd558d1 ("l2tp: Split pppol2tp patch into
separate l2tp and ppp parts") in v2.6.35-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a213a8950414c684999dcf03edeea6c46ede172e]
stable/6.12: [78cdfdca88cbf731a92f3b9ee5427c633dd94e28]
stable/6.18: [e251d4cdfc725c9e7d686161e3b775a0e7d95053]
stable/7.0: [62f327e287cf7b595ae3f73ba72f5cd2a9e9f39f]

CVE-2026-53263: 6lowpan: fix off-by-one in multicast context address compression

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53263

Introduced by commit 5609c18 ("6lowpan: iphc: add support for stateful
compression") in v4.6-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a58899d11009bffc7b4b32a571858f381121837]
stable/5.10: [f24a58c72a45f4c109f3557a760cc4b60b7a6037]
stable/5.15: [da8cbb64b47e9066b40af0de170901caf17b768c]
stable/6.1: [4485d79617520d84ba5a14515e2b5136007d6deb]
stable/6.12: [dcb1bec1c32ee5c3878354e087cf5dbee2b7c7af]
stable/6.18: [c32f30ef5e66adbfa102348e2e8a23776eb007cb]
stable/6.6: [06ce6fc106b16dec9b535950db626261be865e5b]
stable/7.0: [da8808463882c3f3c357b072e25053c2121f1419]

CVE-2026-53264: net/sched: act_api: use RCU with deferred freeing for
action lifecycle

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53264

Introduced by commit d7fb60b ("net_sched: get rid of tcfa_rcu") in v4.14-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5057e1aca011e51ef51498c940ef96f3d3e8a305]
stable/5.10: [98b2e40879abf0245be5a5b7af69e0f6ff524ac3]
stable/5.15: [18af5d2ef0c4f65787fd1280c8b23286b9f2a835]
stable/6.1: [1f1b98fea6b9ea30507d0f2fbff6750292d097e2]
stable/6.12: [5dd51e09020c65aa53cf128e5e3517cd53b3c113]
stable/6.18: [b60e9391142e983fab2be53497aa8f71fdd09cd5]
stable/6.6: [8b136f18ac4b2ace5aaad3305b3f8a5d8165a009]
stable/7.0: [91d105d2cbe002f9c7b43a6183adedc37e1da1f7]

CVE-2026-53265: dm cache policy smq: check allocation under invalidate lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53265

Introduced by commit 2d1f7b6 ("dm cache policy smq: fix missing locks
in invalidating cache blocks") in v7.1-rc1.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-st cip/5.10 cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6 stable/7.0

Fixed status
mainline: [d3f0a606b9f278ece8a0df626ded9c4044071235]
stable/5.10: [c242c7af2aecf0b538b8623bdb86b8b441da38d9]
stable/5.15: [13da856c86fb8c2ccab95034fd77da1bb2c2a17c]
stable/6.1: [d886945fcb0f8c9dc6b39928d7a96c95c587346c]
stable/6.12: [03ffe1112ed88bb3a9bd0b971549bf4d64bfc59a]
stable/6.18: [42ff6774ecd9d7f70d599cb71ff64373a1da4948]
stable/6.6: [b4892561552d671bd8c4da5ebb70e9fbb1ec446e]
stable/7.0: [c57570fba24016ec25ec046ab44db39143fb7a64]

CVE-2026-53266: netfilter: bridge: make ebt_snat ARP rewrite writable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53266

Introduced by commit 63137bc ("netfilter: ebtables: Fixes dropping of
small packets in bridge nat") in v5.10-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67ba971ae02514d85818fe0c32549ab4bfa3bf49]
stable/5.10: [bf84ad7c7a9ede46e31afaa41a1ba06a159e8c87]
stable/5.15: [76280b78cc9f23bdc6438e10ad6dff148ef8375b]
stable/6.1: [b7e91939ba9be805a62a257fa4e227dffbb88fa0]
stable/6.12: [153ea96c806aea395daba907a4f88480b6ad5093]
stable/6.18: [b18675263db1147c8e1cab625400c13a0d87bd2d]
stable/6.6: [afd64b59c3de9bbbdd3759e834fdc55cda716e0b]
stable/7.0: [c9b5ff59feffb92a147a84a5aa28acd2cb8ff4c5]

CVE-2026-53267: netfilter: nft_ct: bail out on template ct in get eval

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53267

Introduced by commit 45d9bcd ("netfilter: nf_tables: validate len in
nft_validate_data_load()") in v4.1-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3027ecbdb5fdf9200251c21d4818e4c447ef78e1]
stable/6.12: [8470f676eadeab99132708acb1a85915664d6115]
stable/6.18: [f071b0bf078146368d18e4eec386bf2ddc0ab7e0]
stable/6.6: [af80f78ce984649e1698b841cd33f4fa505ad828]
stable/7.0: [2e154b5f53f1b0b490c7b8b02499f90feb86b1d5]

CVE-2026-53268: netfilter: conntrack_irc: fix possible out-of-bounds read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53268

Introduced by commit 869f37d ("[NETFILTER]: nf_conntrack/nf_nat: add
IRC helper port") in v2.6.20.16.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66eba0ffce3b7e11449946b4cbbef8ea36112f56]
stable/5.10: [4cdda7f868f48e2f81579371584fdbdce37df2c8]
stable/5.15: [8a1d6e40dedfe1068aee094d851bd69e289c9fd6]
stable/6.1: [0afc802160af0df61ed374fdb97fb34cfe5cdf2f]
stable/6.12: [ddddd8271359961e403d11c90c9ba9fc38914f7e]
stable/6.18: [9e5da2379f968a3ea5a6e38921ab6201576466dc]
stable/6.6: [7c34f91305292083253df6a9f6c8ede02d4ccaea]
stable/7.0: [573810f61bcd6b6815e2ff53bbdd2b9c9d747176]

CVE-2026-53269: netfilter: synproxy: add mutex to guard hook reference counting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53269

Introduced by commit ad49d86 ("netfilter: nf_tables: Add synproxy
support") in v5.3-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2fcba19caaeb2a33017459d3430f057967bb91b6]
stable/5.10: [0ec9ddc1bda261a2c57636c74c8b4e53000102c9]
stable/5.15: [56ffbe3a08c01dcdb0d6adee9ce1e535bfb3b389]
stable/6.1: [debc57b83d5b323df74bf010c8d50fe26ad2ed6b]
stable/6.12: [640441348258220e78daed40528b85b8afcedab6]
stable/6.18: [aaf80701dc2f7a48fe543961e21f8ca3924d587c]
stable/6.6: [0f8ba5e4c53d2e4a536aa68140beda9fe59b2f88]
stable/7.0: [fbf0591275f50eae5733c3d7a8cd6c1e79933ffa]

CVE-2026-53270: ipvs: clear the svc scheduler ptr early on edit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53270

Introduced by commit 05f0050 ("ipvs: fix crash if scheduler is
changed") in v4.2-rc5.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [193989cc6d80dd8e0460fb3992e69fa03bf0ff9b]
stable/5.10: [d10730a1f2caf08088e0db1b19b242f3e6fa5f06]
stable/5.15: [e4feec3174036ba772006be74beee0efa09a9eb8]
stable/6.1: [7d4f5004511757e3984901ffb412fcf858d80ed5]
stable/6.12: [14e4689c113b4c06af1069364ade24fdd7055f33]
stable/6.18: [25918720ba97f974a4f8d433b5a0132c5b43f6f3]
stable/6.6: [c6376b9b1b4d2bad638256b1b3588e073344ae69]
stable/7.0: [19a9493faa4bf3c7bd0a386f30b60b1bb4a3da03]

CVE-2026-53271: ksmbd: fix NULL-deref of opinfo->conn in oplock/lease
break notifiers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53271

Introduced by commit c8efcc7 ("ksmbd: add support for durable handles
v1/v2") in v6.9-rc1.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [b003086d76968298f22e7cf62239833b5a3a06b1]
stable/6.12: [1ff58dcfcab434ebb51649da33774fbb8e1f7b67]
stable/6.18: [e735dbd489e3ea02be78dba991056fe1138be51e]
stable/6.6: [945a86b21b40fb17183f5b27461baa6f03e2467f]
stable/7.0: [75e33deda658c1ab3a9336cbdb1436536f9b3660]

CVE-2026-53272: erofs: fix use-after-free on sbi->sync_decompress

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53272

Introduced by commit 40452ff ("erofs: add sysfs node to control sync
decompression strategy") in v5.17-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1aee05e814d292064bf5fa15733741040cdc48ba]
stable/6.12: [86ab00cf81d44b675bb23db62b88fd76c8ac8cea]
stable/6.18: [00bf6868df65fa95b3854996246d15759fdc7070]
stable/7.0: [95caf60da33d87ed26c28993620f0d92487b0296]

CVE-2026-53273: tee: optee: prevent use-after-free when the client
exits before the supplicant

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53273

Introduced by commit 70b0d6b ("tee: optee: Fix supplicant wait loop")
in v6.14-rc4.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [387a926ee166814611acecb960207fe2f3c4fd3e]
stable/5.10: [416259cb5bffecaaae5f76539deb535a8c1b2c34]
stable/5.15: [724d0caffd4204b46f78efe22f18f8338031c6e1]
stable/6.1: [ae847ab29ded2d7cece4d5970f0edefa4137bf2f]
stable/6.12: [d366a01475f927402c96a3fe78bfc06b924fc87d]
stable/6.18: [d5b57bb314d79e99bebb58a53588fa11dd4dbf69]
stable/6.6: [9a0dc9279d0907b198f205a693aedf696b08145d]
stable/7.0: [373152c94e57e9592b68c100e224fbd943cfd608]

CVE-2026-53274: net/smc: fix sleep-inside-lock in __smc_setsockopt()
causing local DoS

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53274

Introduced by commit a6a6fe2 ("net/smc: Dynamic control handshake
limitation by socket options") in v5.18-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3fdd924d88c30b9f488636ce0e4696012cf5511]
stable/6.1: [35a22117839602bb52283de08894c5a7dde92420]
stable/6.12: [89f6fbe0033c942cb790ffd53ca93a45eeaf1c91]
stable/6.18: [dcd90f42a33e4220385f27b515183d0c91b2fc4a]
stable/6.6: [5d27d2ffe487df89ce28fda0410eafa05dbe03a0]
stable/7.0: [94d286fa5eedc550d42bcb9c85416af8f77736ff]

CVE-2026-53275: ipv6: mcast: Fix use-after-free when processing MLD queries

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53275

Introduced by commit 97300b5 ("[MCAST] IPv6: Check packet size when
process Multicast") in v2.6.20.16.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [791c91dc7a9dfb2457d5e29b8216a6484b9c4b40]
stable/5.15: [1354271c89d0e5fbf8b3d94097ff0216695209c7]
stable/6.1: [53baa63a4183291574483f89583dbef13677a2c4]
stable/6.12: [b2eb8886200b907fc71806869620609f0f4cacb0]
stable/6.18: [4203806f700bb44ea0b05d484d9d40044b47fb04]
stable/6.6: [2a613bf497029d555a7428406aa8cdb84a503cea]
stable/7.0: [087dbacf897c020f438f780f0a4a8aa73b6d7c5a]

CVE-2026-53276: Bluetooth: ISO: Fix a use-after-free of the hci_conn pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53276

Introduced by commit d341370 ("Bluetooth: ISO: Add support to bind to
trigger PAST") in v6.19-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f50331f2a1441ec49988832c3a95f2edacc47322]
stable/7.0: [d324b8aa20bd3c3394e3647dc22491d88f3f4e7a]

CVE-2026-53277: KVM: arm64: Take the SRCU lock for page table walks in
fault injection and AT emulation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53277

Introduced by commit 50f77dc ("KVM: arm64: Populate level on S1PTW SEA
injection") in v6.18-rc1.
Introduced by commit be04ceb ("KVM: arm64: nv: Add emulation of AT
S12E{0,1}{R,W}") in v6.12-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2ca45b50d4216c9cc7ffabf50d9ad1932209251]
stable/6.18: [97706097f9b851cfe55c3b00b083dfc2bcf542bc]
stable/7.0: [ec42b4ed1b072ea2d03f086061aa67bad6d8de39]

CVE-2026-53278: arm_mpam: Check whether the config array is allocated
before destroying it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53278

Introduced by commit 3bd04fe ("arm_mpam: Extend reset logic to allow
devices to be reset any time") in v6.19-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ccbb613b42a1f1ba7bfd547a148f644a902a25c]
stable/7.0: [8eb6dc76eeae5302c0d885906a0e469ef9630a59]

CVE-2026-53279: drm/gma500/oaktrail_lvds: fix hang on init failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53279

Introduced by commit a57ebfc ("drm/gma500: Make oaktrail lvds use ddc
adapter from drm_connector") in v6.0-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [657a091ab6d01d0091b77660c75cfed573c9a53e]
stable/6.1: [5fe9f505d8578852c30668567bc3ce52e776e8c7]
stable/6.12: [7877f7e231a8bd5c817af1491276550a5e195cd7]
stable/6.18: [ab9256936b58eb178caddcf5b5b1638f079909d2]
stable/6.6: [4e04b564c005c9900643c56656d751ad677889be]
stable/7.0: [f6fc44af3bbd5ab0fb6bdec6f47decca11b38425]

CVE-2026-53280: iommu: Fix NULL group->domain dereference in
pci_dev_reset_iommu_done()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53280

Introduced by commit c279e83 ("iommu: Introduce
pci_dev_reset_iommu_prepare/done()") in v7.0-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d769711fcddd005f1e654b3bde547140917fe696]
stable/7.0: [17194cd0dd236e732d116d50840d795ca50ef196]

CVE-2026-53281: iommu/vt-d: Avoid NULL pointer dereference or refcount
corruption

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53281

Introduced by commit 60f030f ("iommu/vt-d: Avoid use of NULL after
WARN_ON_ONCE") in v6.14-rc1.
Fixed in v7.1-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [79ea2feb917b05366b49d85573c9c5331f043b2c]
stable/6.18: [9022cb9ac0c2a72a57fa8ebf92ac74f953ca0153]
stable/7.0: [cdfe3c9f2c9e28a8651ee463c88ad191ced2f840]

CVE-2026-53282: x86/kexec: Push kjump return address even for non-kjump kexec

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53282

Introduced by commit 2cacf7f ("x86/kexec: Fix stack and handling of
re-entry point for ::preserve_context") in v6.14-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [786a45757dcdf8f2beb9d4a6db605db16c18b2b4]
stable/6.18: [b0bd7a850e1f082560959707dbf57b0402071646]
stable/7.0: [7dba9631faa2ee0785e8c2bf0e3d90a05f26dd8c]

CVE-2026-53283: iommu/amd: Bounds-check devid in __rlookup_amd_iommu()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53283

Introduced by commit e874c66 ("iommu/amd: Change rlookup, irq_lookup,
and alias to use kvalloc()") in v6.16-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07d0f496fe7ec5abe3bee7e38be709521567bb33]
stable/6.18: [f0a0f01787ecece814414b0665df879b69849d09]
stable/7.0: [79db4cbab81f07ce69a93d379ebd40d3709ecfb2]

CVE-2026-53284: btrfs: only release the dirty pages io tree after
successful writes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53284

According to the .vulnerable file, this bug was introduced by commit
663dfbb in v3.19-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4066c55e109475a06d18a1f127c939d551211956]
stable/6.18: [9ebb7eba1237dc198768b9c76506a79f924c82bb]
stable/7.0: [df03d67dc63722845cb9fe59d815d1225b04fd54]

CVE-2026-53285: drm/amd/display: Wrap DCN32 phantom-plane allocation
in DC_RUN_WITH_PREEMPTION_ENABLED

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53285

Introduced by commit 235c676 ("drm/amd/display: add DCN32/321 specific
files for Display Core") in v6.0-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [183182235f6d53bac62c6c39014738a54a68dfa6]
stable/7.0: [30bb2ec6695d62f63db4aa6179c4626834ed0cd6]

CVE-2026-53286: idpf: fix double free and use-after-free in aux device
error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53286

Introduced by commit be91128 ("idpf: implement RDMA vport auxiliary
dev create, init, and destroy") in v6.17-rc1.
Introduced by commit f4312e6 ("idpf: implement core RDMA auxiliary dev
create, init, and destroy") in v6.17-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c77b9510829a424d1b74409b7db9456e3522871]
stable/6.18: [722b91d5086a249318c9d0e2b36aeac80ba8c808]
stable/7.0: [f319de7074e1728a9f9ff7134257360c694ec2b2]

CVE-2026-53287: audit: fix incorrect inheritable capability in CAPSET records

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53287

Introduced by commit e68b75a ("When the capset syscall is used it is
not possible for audit to record the actual capbilities being
added/removed.  This patch adds a new record type which emits the
target pid and the eff, inh, and perm cap sets.") in v2.6.29-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [260daaa585c43e6b37247be6bc30413c2dac589b]
mainline: [e4a640475e43f406fdfd56d370b1f34b0cbbc18d]
stable/5.10: [75bd76c9eb2de9afeca03dc5152ebca5fb8fc816]
stable/5.15: [febb4bf373ac565d3fb8d1f429827bdd983be496]
stable/6.1: [95de7bb4bf535a9288549d401ebde83cdcbf2792]
stable/6.12: [0a065c51a225854768b772a0b733a44d77162582]
stable/6.18: [e35f3550c5b4fab33103c18654c293cee9850b0a]
stable/6.6: [151ee470edc3d7ed29fe72df678f8357d2ad8ced]
stable/7.0: [d782e4d200cd9036ef353eeb29525bfbfd13a14e]

CVE-2026-53288: arm64: Reserve an extra page for early kernel mapping

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53288

Introduced by commit 5973a62 ("arm64: map [_text, _stext) virtual
address range non-executable+read-only") in v6.18-rc1.
Fixed in v7.1-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [4d8e74ad4585672489da6145b3328d415f50db82]
stable/6.12: [a4ff33053da0a34b14abb5c96dc5a48379e26fce]
stable/6.18: [dcb89deed40ba55ff7020061712fdabf098cc2cc]
stable/7.0: [9fe9e3acaa14921b0cf0d6cc2de5b562499bf721]

CVE-2026-53289: ice: fix NULL pointer dereference in ice_reset_all_vfs()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53289

Introduced by commit 12bb018 ("ice: Refactor VF reset") in v5.8-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [54ef02487914c24170c7e1c061e45212dc55365e]
stable/6.1: [acc76b97902757b63ba5136f787d107647236a19]
stable/6.12: [4c2ac52eeeb672624b06c7a135301d7b8a21d52e]
stable/6.18: [1e9185b13ce57b86844447e092e58abb3be849b1]
stable/6.6: [3ad2471e61e9f0c4d25046d08e3d747501c3b0dd]
stable/7.0: [429024f3a407e4137aee825c2a6be0aba857937d]

CVE-2026-53290: drm/xe/eustall: Fix drm_dev_put called before stream
disable in close

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53290

Introduced by commit 9a0b11d ("drm/xe/eustall: Add support to init,
enable and disable EU stall sampling") in v6.15-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc2d9842c67d883d3200ae33b9c3859dd9492408]
stable/6.18: [bebce43f34b5feb8a760aa832eba81e0f8a38871]
stable/7.0: [84f2bfbe6e38f8b9815ca00826e53b7f51420402]

CVE-2026-53291: ALSA: hda/conexant: Fix missing error check for jack detection

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53291

Introduced by commit 7aeb259 ("ALSA: hda/conexant: Fix headset auto
detect fail in cx8070 and SN6140") in v6.8-rc1.
Fixed in v7.1-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [b0e2333a231107adedd38c6fcfe1adc6162716fc]
stable/5.15: [49c2c5924552e1d2f8b635dee663abebbb7cf63b]
stable/6.1: [a2a33e87a2ffce3046c574d24eec4390c27c9365]
stable/6.12: [dd110cc00cf854a8ecd8d003127a4178c28574ea]
stable/6.18: [f837c7b85143a7c54140ff41ad5c076b73cd9933]
stable/6.6: [d68f753d89f4ef6e410d7e8b7e8ab2fdde921b80]
stable/7.0: [1da5c73f3793b224696617a2a21def7500ba18d6]

CVE-2026-53292: net: phonet: do not BUG_ON() in pn_socket_autobind()
on failed bind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53292

Introduced by commit ba113a9 ("Phonet: common socket glue") in v2.6.28-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b0c911bcdbd982f7748d11c0b39ec5808eae2de]
stable/7.0: [6db58ee730bf434d1afca91b91826e26688856ed]

CVE-2026-53293: drm/amdgpu: fix AMDGPU_INFO_READ_MMR_REG

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53293

Introduced by commit 9e823f3 ("drm/amdgpu: Block MMR_READ IOCTL in
reset") in v6.12-rc1.
Fixed in v7.1-rc2.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [0ef196a208385b7d7da79f411c161b04e97283e2]
stable/6.12: [61957c2e467b39b528a290016367d32a433fa846]
stable/6.18: [a31c3feb54b15a90232e497ad0e27e8a82052d8d]
stable/6.6: [8c4254c8f5836e77ae83e7fc037f02b69f7a0977]
stable/7.0: [5c29d20470d4566d1b68df57097d642d01f8b427]

CVE-2026-53294: mailbox: mailbox-test: don't free the reused channel

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53294

Introduced by commit 8ea4484 ("mailbox: Add generic mechanism for
testing Mailbox Controllers") in v4.4-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [dd5648d3af2ad6bb096464773ab49d2e1df18840]
mainline: [88ebadbf0deefdaccdab868b44ff70a0a257f473]
stable/5.10: [fc0089f82c3e36060c2c79156bc2018bfb16b56b]
stable/5.15: [5d4f3d0f64f1016cb78b400a70b67df91fac99b5]
stable/6.1: [c494a11da45ad7ec9b0ff216c3e3ace351193bb6]
stable/6.12: [5c209299b0113e289e238fa5f2e8f00c59f76060]
stable/6.18: [82f6dcea46cf5de65c4ba7283f7c7b34de4a324d]
stable/6.6: [3afca89fae501dbd7421e1777b5b8f033b1d98d0]
stable/7.0: [240c71a2aea36a1a4210f911a1c32ea88777e8e4]

CVE-2026-53295: mailbox: add sanity check for channel array

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53295

Introduced by commit 2b6d83e ("mailbox: Introduce framework for
mailbox") in v3.18-rc2.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ea3023ea2640ab9e7697514d2d5f894ed1ef0ed8]
mainline: [c1aad75595fb67edc7fda8af249d3b886efa1be9]
stable/5.10: [5cc3300fab262b26c28bc2fc06df693410c3840b]
stable/5.15: [0f11444271110d9b5bc6316a153c6431abda899c]
stable/6.1: [d44872a569b8fbacde457ff2587a775e5004bb79]
stable/6.12: [6362c4a7d7e21e68cd9aa04df7cde16befba3a4b]
stable/6.18: [9dd7489943324298bb0f385495795a82f1dd6507]
stable/6.6: [14aed0d4e58389cc6a88acf8610b12d3e476272b]
stable/7.0: [37792091ab28ba030fd8d61184c47d4d51294170]

CVE-2026-53296: mailbox: mailbox-test: free channels on probe error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53296

Introduced by commit 8ea4484 ("mailbox: Add generic mechanism for
testing Mailbox Controllers") in v4.4-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d4b78afbb94a6cd77751771c3c2f8d38eaa94aeb]
mainline: [c02053a9055d5fdfd32432287cca8958db1d5bc5]
stable/5.10: [0ad8c4a03a358de7811ba1ab8cbd1fe76ad0ff6b]
stable/5.15: [15c4cc3850cfe1b973eb7b63c02314b267f06a64]
stable/6.1: [187069ccc3474516af32350e20d7e449160fa6de]
stable/6.12: [6c6ce2ccb4fcf1617fec83f91b21aa0265f30701]
stable/6.18: [742001919653e7313b4e91780c5d108be1692365]
stable/6.6: [81c9e7e4030e71391ab479c4c6e17b64802577aa]
stable/7.0: [02beb178e2e159daeb8f992d7abb16a37da31664]

CVE-2026-53297: net: mana: Guard mana_remove against double invocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53297

Introduced by commit 635096a ("net: mana: Support hibernation and
kexec") in v5.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50271d7ec95144d26808025b508f463780517d3c]
stable/6.18: [a1ddfd2c0b7a48e5239fadd2a24cc4bc2cda90e6]
stable/7.0: [bbe5c3c570645a4ceb120979d3ee203a1583d775]

CVE-2026-53298: net: airoha: Move ndesc initialization at end of
airoha_qdma_init_rx_queue()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53298

Introduced by commit 23020f0 ("net: airoha: Introduce ethernet support
for EN7581 SoC") in v6.11-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [379050947a1828826ad7ea50c95245a56929b35a]
stable/6.12: [d36be272adda7f313e39dd118086955d993bf6a7]
stable/6.18: [4d4acfa348a1d8c0941004823662ede0fdb5dea5]
stable/7.0: [14dc48e5ba73d5c69559bf1a1a6884f7843aade7]

CVE-2026-53299: net: airoha: Move ndesc initialization at end of
airoha_qdma_init_tx()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53299

Introduced by commit 3f47e67 ("net: airoha: Add the capability to
consume out-of-order DMA tx descriptors") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [f329924bb49458c65297f1361f545816a5b90998]
stable/6.18: [90619fdedfb9cc8a80f217d882ee7a84d3703e72]
stable/7.0: [ece31f9dae0c3cd3277e66667e7b8ab2577cf34a]

CVE-2026-53300: net: enetc: fix NTMP DMA use-after-free issue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53300

Introduced by commit 4701073 ("net: enetc: add initial netc-lib driver
to support NTMP") in v6.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3cade698881eb238f88cbbfec82acc2110440a3f]
stable/6.18: [37c8933064be714ee672b0a0523c2fd045b73b3d]
stable/7.0: [655d9ce9b1d3db0aa5271acb5e5101c66bd0d58b]

CVE-2026-53301: reset: amlogic: t7: Fix null reset ops

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53301

Introduced by commit fb4c315 ("reset: amlogic: add auxiliary reset
driver support") in v6.13-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9797524ef2b69c6b187b55bd844eb72a8c1cbd99]
stable/6.18: [cde69482d2e6834dcd4ed675d1ef84e48627ee9f]
stable/7.0: [463a0885de665d3f36e219c5502584b99fa61c85]

CVE-2026-53302: crypto: eip93 - fix hmac setkey algo selection

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53302

Introduced by commit 9739f5f ("crypto: eip93 - Add Inside Secure
SafeXcel EIP-93 crypto engine support") in v6.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ba3b02f897b14e34977e1886d95ffe64d907204]
stable/6.18: [fc9310d79fdb117b369a01eb00f4fd5fb4849d4e]
stable/7.0: [ec226d3e58bb9f0e26a77346085b6b4d594d53d8]

CVE-2026-53303: f2fs: protect extension_list reading with sb_lock in
f2fs_sbi_show()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53303

Introduced by commit b6a06cb ("f2fs: support hot file extension") in v4.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5909bedbed38c558bee7cb6758ceedf9bc3a9194]
stable/6.1: [d3ff0c121bbaef026df6248ab7ef6f0b068b0647]
stable/6.12: [4b3a1bf4c2ffd4c9595d900ead78c9035894a025]
stable/6.18: [d0e877810baf613b018fd9747440b9d4d9db1428]
stable/6.6: [cea15f66b7b68b2c50943a6660e0692c6635e4eb]
stable/7.0: [ea3ab43a1f3cf2c7cecd75c8be1ee99a5e94a92e]

CVE-2026-53304: scsi: sg: Resolve soft lockup issue when opening /dev/sgX

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53304

Introduced by commit 6460e75 ("[SCSI] sg: fixes for large page_size")
in v2.6.20.16.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c42315cc48f0cd7390eab6dccb1a7b6cb6f6facd]
mainline: [d06a310b45e153872033dd0cf19d5a2279121099]
stable/5.10: [3d74e0654ac908c65a8f20373091826fe43b1363]
stable/5.15: [c47ccfb3d80dfed522ca06a5954ac97488d78c5a]
stable/6.1: [fe671d3c84ffb1b763d590c25195755adeaadaba]
stable/6.12: [9676ca7b1ef31a3a65b3e61e7ce3b54ce7364202]
stable/6.18: [1afd963fcd963db0dc5d47df6dfcf010c9c4647e]
stable/6.6: [c5f4a211e82d04ccc1809311322c47023bbe66e2]
stable/7.0: [feade299e932967de27519338d41de348fb5b061]

CVE-2026-53305: usb: typec: ps883x: Fix Oops at unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53305

Introduced by commit 257a087 ("usb: typec: Add support for Parade
PS8830 Type-C Retimer") in v6.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [381133848a033c2086cf9cafb226f425bd0414ff]
stable/6.18: [37a3d1b6827783f26d2f8e6c7683e253ba79ae93]
stable/7.0: [c404d0ac0cb085cb7077ba32c334cc4042feb81a]

CVE-2026-53306: tty: hvc_iucv: fix off-by-one in number of supported devices

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53306

Introduced by commit 44a01d5 ("[S390] s390/hvc_console: z/VM IUCV
hypervisor console support") in v2.6.29-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ba64ed2af2d69ceef0811117ac4f4a641ab4f8b9]
mainline: [f2a880e802ad12d1e38039d1334fb1475d0f5241]
stable/5.10: [3d3b89e6ab93bdd0efd45828bda6b0e61cc46dff]
stable/5.15: [484357dff256c816d9466bda35eb765685e4dc86]
stable/6.1: [11207e42a332eb8bbcb9fe74df9edd2a807c5607]
stable/6.12: [a76511bc654819425d3b15e77b523d7f9d81f064]
stable/6.18: [3104a3f40feb107f77d7116ad9bf6c210ab7babf]
stable/6.6: [fed8b8f33a46db0ee2efdb000f4f630c86ed8ca4]
stable/7.0: [f1dc8e72de9aabe5d96767a4e97219ac26b79fe5]

CVE-2026-53307: pinctrl: pinconf-generic: Fully validate 'pinmux' property

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53307

Introduced by commit 7112c05 ("pinctrl: pinconf-generic: Add API for
pinmux propertity in DTS file") in v6.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c98324ea7849b6e5baa1774f71709b375a2c2f9e]
stable/6.18: [6476aac13805721e16439bd71f0e1703a4154517]
stable/7.0: [b7842b722169359e7ffe4b838d2496e9e72ac996]

CVE-2026-53308: power: supply: max77705: Free allocated workqueue and
fix removal order

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53308

Introduced by commit 11741b8 ("power: supply: max77705: Fix workqueue
error handling in probe") in v6.16-rc1.
Introduced by commit a6a494c ("power: supply: max77705: Add charger
driver for Maxim 77705") in v6.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e668baadefb16e81269dbfebf3ffc2672e3a3bb]
stable/7.0: [b98e4e57e34d099a8f846fa54749654082975ea0]

CVE-2026-53309: ocfs2/dlm: fix off-by-one in dlm_match_regions()
region comparison

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53309

Introduced by commit ea20344 ("ocfs2/dlm: Add message
DLM_QUERY_REGION") in v2.6.37-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1201158265810b1f5d2a43770069798c702e190f]
mainline: [01b61e8dda9b0fdb0d4cda43de25f4e390554d7b]
stable/5.10: [760ab35040aca8399021fdb9ff1db1089feb7194]
stable/5.15: [c60a2710b73838d250cda57344c049b89abc5d52]
stable/6.1: [2a0673836f019e7c032acbf48d022d5ccf02a845]
stable/6.12: [d5403ae28085761d58b555645bc7d5feadb10073]
stable/6.18: [1fb7f356547d9688822315cd2b205ff0bd5429b4]
stable/6.6: [819d8ebad3200a53de99bd7e297bc428e41ced54]
stable/7.0: [426cd8eedac89b86148d4478990eeef16e8a2520]

CVE-2026-53310: soc/tegra: cbb: Fix cross-fabric target timeout lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53310

Introduced by commit 25de5c8 ("soc/tegra: cbb: Improve handling for
per SoC fabric data") in v6.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5f51b04cbb3ae0f9cb2c4488952b775ebb0ccbf]
stable/6.18: [c892d0d4fe5ec05d3fdfb1616c3c0e3c12ef5abc]
stable/7.0: [8445d69a5cabd8d6cb2bf0f8b798be205f53afa2]

CVE-2026-53311: fuse: fix uninit-value in fuse_dentry_revalidate()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53311

Introduced by commit 2396356 ("fuse: add more control over cache
invalidation behaviour") in v6.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a6baf204610589f8a5b5a1cd69d1fe661d9d3cd]
stable/6.18: [da3d241c5b925f17a9d8051d7a9e0d454d8e01f6]
stable/7.0: [3ac9117ba3deab8a5dd22847355f861686f4bee7]

CVE-2026-53312: iommu/riscv: Remove overflows on the invalidation path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53312

Introduced by commit 488ffbf ("iommu/riscv: Paging domain support") in
v6.13-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40a13b49957937427bc23e78eb50679df4396a47]
stable/6.18: [9f0632b0d4246675fa221aa1a3bffadf9c6bd9ac]
stable/7.0: [e4b7687784153481de45fd39fb97ba3919605c0c]

CVE-2026-53313: drm/amd/display: Avoid NULL dereference in dc_dmub_srv
error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53313

Introduced by commit 2631ac1 ("drm/amd/display: add DMUB registers to
crash dump diagnostic data.") in v5.14-rc1.
Introduced by commit 71ba6b5 ("drm/amd/display: Add interface to
enable DPIA trace") in v6.6-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ae3e16f4b3bf64140f773629b765d605ee079a9]
stable/7.0: [b37a978e6d8c33fbfa4abc5dcca4c7cfc6d01f22]

CVE-2026-53314: padata: Put CPU offline callback in ONLINE section to
allow failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53314

Introduced by commit 894c9ef ("padata: validate cpumask without
removed CPU during offline") in v5.6-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [c8c4a2972f83c8b68ff03b43cecdb898939ff851]
stable/6.1: [65dae8b34f0810f3fa9f77c4c63650cd20820693]
stable/6.12: [3e6c08dd97dcd22a00aee469e0adfa819071d80e]
stable/6.18: [5a9f29a3e076b637d2234093e57989cf755ded5b]
stable/6.6: [a6d44f477000c6352de6b05e9e276e62083e5fbf]
stable/7.0: [9afe53f14a2aae8c4beb30e5ea51641a34f1a3d3]

CVE-2026-53315: drm/amd/ras: Fix NULL deref in
ras_core_get_utc_second_timestamp()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53315

Introduced by commit 13c91b5 ("drm/amd/ras: Add rascore unified
interface function") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b8101cc3b34d4d80d799360d2744829d5964479]
stable/7.0: [6c84f7f0afc415691ffa7d48aa7ce1d8e6083032]

CVE-2026-53316: drm/amd/ras: Fix NULL deref in ras_core_ras_interrupt_detected()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53316

Introduced by commit 13c91b5 ("drm/amd/ras: Add rascore unified
interface function") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b606216e03fa2b53cc179d8383b683a140fe6e1]
stable/7.0: [f2f2ed3d359509c311cc6626226e4578d7eb77d8]

CVE-2026-53317: wifi: mt76: mt7921: Place upper limit on station AID

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53317

Introduced by commit 5c14a5f ("mt76: mt7921: introduce mt7921e
support") in v5.12-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d0bf21e3e20619d51d06c0c36207aabab8b712c]
stable/6.12: [6dbe70f9ef14d8ac1c24bf19fd9510978a3ab952]
stable/6.18: [35835ff71e6e618155578b8e3905597edd5f601c]
stable/7.0: [1a4b802afe15c5b33b2dcb37a594aba2fa215d52]

CVE-2026-53318: wifi: mt76: mt7925: prevent NULL pointer dereference
in mt7925_tx_check_aggr()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53318

Introduced by commit 44eb173 ("wifi: mt76: mt7925: add link handling
in mt7925_txwi_free") in v6.11-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83ae3a18ba957257b4c406273d2da2caeea2b439]
stable/6.12: [28ed0b61f67386c0ba1213227d350005000240fd]
stable/6.18: [93d0694fb56de4628a921244d7f100c28acd2def]
stable/7.0: [b0332428a8d4cf93752eda9e2b0d5585525e689f]

CVE-2026-53319: blk-wbt: remove WARN_ON_ONCE from wbt_init_enable_default()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53319

Introduced by commit 41afaee ("blk-wbt: fix possible deadlock to nest
pcpu_alloc_mutex under q_usage_counter") in v7.0-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9b004ff83067cdf96774b45aea4b239ace99a2f]
stable/7.0: [fd7a982657077469802594a5165bc30b9a55af70]

CVE-2026-53320: nilfs2: reject zero bd_oblocknr in
nilfs_ioctl_mark_blocks_dirty()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53320

Introduced by commit 7942b91 ("nilfs2: ioctl operations") in v2.6.30-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d91bd069a12cfefba241cdc92ccab5d07ba6717f]
mainline: [be3e5d10643d3be1cbac9d9939f220a99253f980]
stable/5.10: [e0a0c4903cbba351f0f5b5d104960d3a5b23202f]
stable/5.15: [9472d37799a0b9ff9b99639f35961ac2f0b3c9be]
stable/6.1: [65e07964b4b2daf9a54e686cf0fa72d74a9648a8]
stable/6.12: [4525658002be3ad310b16bf8db48c8adb6a55d32]
stable/6.18: [e5ff0ba4b6983cdbcc826efc201e7179ece5d46f]
stable/6.6: [b88f905d4449b70da6bda547be546e365e44352e]
stable/7.0: [94094e70fe292c9566502772d4d4d6d6a99204b1]

CVE-2026-53321: io_uring/napi: cap busy_poll_to 10 msec

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53321

Introduced by commit 8d0c12a ("io-uring: add napi busy poll support")
in v6.9-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [df8599ee18c0e5fe343ffe0b4c379636b8bb839a]
stable/6.18: [39767f944a8c9e696566c37ad5b20131406c4b8d]
stable/7.0: [cb3af525f8dfb8930f0c123e5755fa967a12d5c1]

CVE-2026-53322: vfio/pci: Clean up DMABUFs before disabling function

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53322

Introduced by commit 5d74781 ("vfio/pci: Add dma-buf export support
for MMIO regions") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d97708701434ce72968e771976aaf9d3438fcafd]
stable/7.0: [4f1000a30f67cf7d328059242776a858611d5ef9]

CVE-2026-53323: net: dsa: remove redundant netdev_lock_ops() from
conduit ethtool ops

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53323

Introduced by commit 2bcf477 ("net: ethtool: try to protect all
callback with netdev instance lock") in v6.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f99e0c3e19badaf3fdced0d3feba623e59eed41]
stable/6.18: [74d64ae4254e99ef8c8215b057a76edac82c5f99]
stable/7.0: [abe91fd045874d21834482adcd7a9693e7377056]

CVE-2026-53324: net: mana: Use pci_name() for debugfs directory naming

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53324

Introduced by commit 6607c17 ("net: mana: Enable debugfs files for
MANA device") in v6.13-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c116f07ab9d22bb6f355f3cf9e44c1e6a47fe559]
stable/6.18: [34dbd7b819544c99c9d96b400fe4db613f40ac4b]
stable/7.0: [9211eb97e8f8c28bf9313ab97862d143dbbbef97]

CVE-2026-53325: agp/amd64: Fix broken error propagation in agp_amd64_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53325

Introduced by commit a32073b ("[PATCH] x86_64: Clean and enhance up K8
northbridge access code") in v2.6.20.16.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b08472db93b1ccff84a7adec5779d47f0e9d3a30]
stable/6.18: [53483a9f4ee9eeb18aa866ec16cce79e136987e1]
stable/7.1: [cefe535a60a2e00e09f4b2689b0c8ffc6912459a]

CVE-2026-53326: debugobjects: Don't call fill_pool() in early boot
hardirq context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53326

Introduced by commit 06e0ae9 ("debugobjects: Allow to refill the pool
before SYSTEM_SCHEDULING") in v6.19-rc1.
Fixed in v7.1.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [0d046ae106255cba5eb83b23f78ee93f3620247d]
stable/6.18: [44b8b03a9fb5c575548fc72c674653d6baba142a]

CVE-2026-53327: debugobjects: Do not fill_pool() if pi_blocked_on

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53327

Introduced by commit 4bedcc2 ("debugobjects: Make them PREEMPT_RT
aware") in v5.15-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f41161059fd0f1bbf18c90f3180e38cc45a14eb]
stable/6.18: [3a408cae608d9c075dd3a9e5cfc03b3cb0726863]

CVE-2026-53328: sched_ext: Don't warn on NULL cgrp_moving_from in
scx_cgroup_move_task()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53328

Introduced by commit 8195136 ("sched_ext: Add cgroup support") in v6.12-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [02e545c4297a26dbbc41df81b831e7f605bcd306]
stable/6.12: [cdff2eb97be147d2ce52ac1327841068781f25dc]
stable/6.18: [0ffcad63b19a1cadb475c9f405a93607fdcd0d7c]

CVE-2026-53329: drm/amd/display: Use krealloc_array() in dal_vector_reserve()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53329

Introduced by commit 2004f45 ("drm/amd/display: Use kernel
alloc/free") in v4.15-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da48bc4461b8a5ebfb9264c9b191a701d8e99009]
stable/5.15: [31180638a33acad12c863132704a76536fb66211]
stable/6.1: [b15825deac1acff72638bbc8f05b89ceef8dfb13]
stable/6.12: [a914aa802669e073f014dae2e5708633b5cecd34]
stable/6.18: [e09689286385a66311ac6922af95339d7a3cef8d]
stable/6.6: [201151e120f0062bcda21cad5d007b82725ad23b]

CVE-2026-53330: drm/amd/display: Fix out-of-bounds read in
dp_get_eq_aux_rd_interval()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53330

Introduced commit is not determined.Fixed in v7.1-rc7.


Fixed status
mainline: [e8b4d37eba05141ee01794fc6b7f2da808cee83b]
stable/6.18: [454d3b3d499c18373f8960d31aea48338a3ca9e0]

CVE-2026-53331: slimbus: qcom-ngd-ctrl: Avoid ABBA on tx_lock/ctrl->lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53331

Introduced by commit a899d32 ("slimbus: qcom-ngd-ctrl: add Sub System
Restart support") in v5.11-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55f2ea9ff83cc27a85526b14bc9b32f96a08d6ec]
stable/5.15: [3d1561537237c6cc1db76155183d8bbdac2339f0]
stable/6.1: [dc4d5c57e012c2c669793deb1515a57bbc6bf5dd]
stable/6.12: [aad4337a21b9ad3ae8d668fa8678d05e26ecbaa8]
stable/6.18: [9f0d45d509b434c54da10e01f4ef8086e4583401]
stable/6.6: [d54a221b0f3cd9e1f03f18104be34e02a8258fae]

CVE-2026-53332: slimbus: qcom-ngd-ctrl: Register callbacks after
creating the ngd

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53332

Introduced by commit 917809e ("slimbus: ngd: Add qcom SLIMBus NGD
driver") in v4.19-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a9d50e9ea406e0c8735938484adc20515ef1b47]
stable/6.12: [fa3790c7ea98328ddc3f7d8bf40247556245a6fc]
stable/6.18: [24ec89123fc9d0d24ce719dcf7fd6c57e5b0d753]

CVE-2026-53333: mm/mincore: handle non-swap entries before !CONFIG_SWAP guard

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53333

Introduced by commit 1f20527 ("mm/mincore: use a helper for checking
the swap cache") in v6.18-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c25b8734367574e21aeb8468c2e522713134da7]
stable/6.18: [a8f91ddf67f669f547bb9fb559738da6f8ee2cf3]

CVE-2026-53334: mm/damon/reclaim: handle ctx allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53334

Introduced by commit 3f7a914 ("mm/damon/reclaim: use
damon_initialized()") in v6.18-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e2ed8a29427af534bf2cb9b8bc51762b8b6e654]
stable/6.18: [66bc00ea37fa8ec14be5a3909d067a5967ef234b]

CVE-2026-53335: mm/damon/lru_sort: handle ctx allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53335

Introduced by commit c4a8e66 ("mm/damon/lru_sort: use
damon_initialized()") in v6.18-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab04340b5ae5d52c1d46b750538febcde9d889e7]
stable/6.18: [6d48f15659395bf1381114f01be91bc68e0be46a]

CVE-2026-53336: nvmem: layouts: onie-tlv: fix hang on unknown types

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53336

Introduced by commit d3c0d12 ("nvmem: layouts: onie-tlv: Add new
layout driver") in v6.4-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea41020b9018e31c2ea7e9d89021e3e6d7470883]
stable/6.12: [fd47edeabadfaa75422009dc5894e92c4c697517]
stable/6.18: [4a4d21f531ccf5bb333d99b620e0d66551f3652c]
stable/6.6: [033d498b0f473c6456be5f885be172024ad84972]

CVE-2026-53337: net: bonding: fix NULL pointer dereference in bond_do_ioctl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53337

Introduced by commit e2a7420 ("bonding/main: convert to using slave
printk macros") in v5.3-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a764b0e8317a863006e05732e1aefe821b9d8c2d]
stable/5.10: [1b7558c85493467b2ea20738866b822db6442034]
stable/5.15: [b02b2e3e876c18733b868a29064abd11cdbf8feb]
stable/6.1: [66693957bacd1c9dae6188a7312d6be69a221f2d]
stable/6.12: [c2cfe290fdb1c32a4f4eb2b8ca3f363b305d21ba]
stable/6.18: [bcb8fad90f27300add583a8371db504b766d95c7]
stable/6.6: [a629418d463fb50d132a1aa063b0105857311e5f]

CVE-2026-53338: net: airoha: Add NULL check for
of_reserved_mem_lookup() in airoha_qdma_init_hfwd_queues()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53338

Introduced by commit 3a1ce9e ("net: airoha: Add the capability to
allocate hwfd buffers via reserved-memory") in v6.16-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9f25118faa4dd2b6e3d14a03d123bbdbd59925d]
stable/6.18: [01f7d4b504580664d36faea5671cde5e3f0d8a5b]

CVE-2026-53339: i2c: qcom-cci: Fix NULL pointer dereference in cci_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53339

Introduced by commit e517526 ("i2c: Add Qualcomm CCI I2C driver") in v5.8-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [729ac5a4b966aac42e08a94dea966f4429008548]
stable/5.10: [e8669d12da0ade52adfe0abe96cd99e708abc9bd]
stable/5.15: [4d2b4a9cda6837e5ee1de1290f2e773a713b71e9]
stable/6.1: [a50b8adb9cdb9a495b0b45583956897b7411ed7a]
stable/6.12: [4cd206c1d57a9370d5219f7b1fc45169d7bdf951]
stable/6.18: [a162a260c8c4db7501c65220e76913e8e351f823]
stable/6.6: [7107627b8b35015027201e7a095a3f6e30b4a46f]

CVE-2026-53340: i2c: imx: fix clock and pinctrl state inconsistency in
runtime PM

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53340

Introduced by commit 576eba0 ("i2c: imx: switch different pinctrl
state in different system power status") in v6.14-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8783fb8031799f1230997c16df8c8dce9fcd1841]
stable/6.18: [9fa82cf393bafc7bd7ca15c1d5cbd5b57ab9de1d]

CVE-2026-53341: fhandle: fix UAF due to unlocked ->mnt_ns read in
may_decode_fh()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53341

Introduced by commit 620c266 ("fhandle: relax open_by_handle_at()
permission checks") in v6.11-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40ab6644b99685755f740b872c00ef40d9aa870e]
stable/6.18: [32138633e51e6db59e474765cf93268c92b42888]

CVE-2026-53342: arm64: mm: call pagetable dtor when freeing
hot-removed page tables

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53342

Introduced by commit 5e8eb9a ("arm64: mm: always call PTE/PMD ctor in
__create_pgd_mapping()") in v6.16-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c594b83457ccdee76d458416fb3bc9348a37592f]
stable/6.18: [95f27fcda681021ed3906d3cae7e68b6a57a1d8e]

CVE-2026-53343: ARM: 9475/1: entry: use byte load for KASAN VMAP stack shadow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53343

Introduced by commit 44e9a3b ("ARM: 9430/1: entry: Do a dummy read
from VMAP shadow") in v6.13-rc1.
Fixed in v7.1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [77a1f6883dc6e837bb2cb30b9b02e2f94338e2c6]
stable/6.1: [c0b8c148a7754826156993ed6442d31536ec86b4]
stable/6.12: [c74990828d3c486ee44aaa68240eb3abff289d1c]
stable/6.18: [517720913bd3c17a52cd55a740064f68455ab88e]
stable/6.6: [c2e3aadc8fef7da068490597fc5582f8f362aeb2]

CVE-2026-53344: pinctrl: mcp23s08: Initialize mcp->dev and mcp->addr
before regmap init

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53344

Introduced by commit f9f4fda ("pinctrl: mcp23s08: init reg_defaults
from HW at probe and switch cache type") in v6.19-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8473c3a197b57ff01396f7a2ec6ddf65383820d4]
stable/6.12: [d487a945769396cc94a8549d1fae838bd642f9a1]

CVE-2026-53345: KVM: Don't WARN if memory is dirtied without a vCPU
when the VM is dying

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53345

Introduced commit is not determined.Fixed in v7.1-rc7.


Fixed status
mainline: [8618004d3e897c0f1b71d9a9ab860461289bb89a]
stable/6.12: [66a8e7ddd901023c89a2733494d827eca3f9c1b0]
stable/6.18: [343e95c8ecc40e0738975ef4ee24c0c35e800e6b]
stable/6.6: [033d39e41fc30f484f4e4f37fb4cd76b12cbb18e]

CVE-2026-53346: rust: arm64: set uwtable llvm module flag for
CONFIG_UNWIND_TABLES

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53346

Introduced by commit d077242 ("rust: support for shadow call stack
sanitizer") in v6.12-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac35b5580ace12e5d0a0b5e61e36d2c4e1ffa29c]
stable/6.12: [bde772ee239720af216fb0b14753971059e132dc]
stable/6.18: [d0f25a1755f2c15b1746379c8d9d7dfde85f58f5]

CVE-2026-53347: drm/virtio: Fix driver removal with disabled KMS

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53347

Introduced by commit 72122c6 ("drm/virtio: Add option to disable KMS
support") in v6.4-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f329e8325e054bd6d84d10904f8dd51137281b92]
stable/6.12: [38a5f891cda6d121c149c94cda89c31ec7024ee3]
stable/6.18: [19a6a00ff50c284f3a9818882ad2be58b33b790a]
stable/6.6: [ed3e134700a2e07caa99b9bc0683ebbe0327c562]

CVE-2026-53348: ASoC: SDCA: fix NULL pointer dereference in
sdca_dev_unregister_functions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53348

Introduced by commit 4496d1c ("ASoC: SDCA: add function devices") in v6.19-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4c60a1d4b6ccc66aefb3789cd908d4f9482eefd]

CVE-2026-53349: netfilter: nf_conntrack: destroy stale expectfn
expectations on unregister

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53349

Introduced by commit f587de0 ("[NETFILTER]: nf_conntrack/nf_nat: add
H.323 helper port") in v2.6.20.16.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3009418f9fa1dcb3eb86f4d8c92583537b5faa3]
stable/6.1: [fbfde85308b99938a6092c48753214d190ece48d]
stable/6.12: [f92c90a2a3e6ff6f9f7fe88fde9004b4ca8f956d]
stable/6.18: [9d017671dcfcec23321fb7962dea624f9e71ddb1]
stable/6.6: [29d8cc44bbdf7b83a1929912214afe6643c1b4f1]

CVE-2026-53350: ASoC: wm_adsp: Fix NULL dereference when removing
firmware controls

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53350

Introduced by commit 0700bc2 ("ASoC: wm_adsp: Separate generic
cs_dsp_coeff_ctl handling") in v5.16-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d3fb78b550301e43fdc60312aed733069694426]
stable/6.1: [5ee9bbe2af2f373e08d3017f9aef2f2eaf29fbc3]
stable/6.12: [2f1be283aa777d655525d000d16474b7e7d015ea]
stable/6.18: [12e579b889624ec54a201d98fdff975de556c731]
stable/6.6: [10def23b67b42679d5b1a356e1a6f3498bd188c3]

CVE-2026-53351: riscv/ptrace: Use USER_REGSET_NOTE_TYPE for REGSET_CFI

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53351

Introduced by commit 2af7c9c ("riscv/ptrace: expose riscv CFI status
and state via ptrace and in core files") in v7.0-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3573f739e3dadab57ec80488d07e05c8f6e82d3]

CVE-2026-53352: signal: clear JOBCTL_PENDING_MASK for caller in
zap_other_threads()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53352

Introduced by commit 39efa3e ("signal: Use GROUP_STOP_PENDING to stop
once for a single group stop") in v3.0-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90918794a4e2c3b440f8fcf3847765a8b1d81b25]
stable/5.10: [2b32b2fb241435145ea199efac024540759d2495]
stable/5.15: [391ebe74456a0f1d60b3ba4a8a64d9f44c1728fe]
stable/6.1: [f8d720bc2e35d568c18be0644e92a468de428370]
stable/6.12: [76aebd9ef20078719dfd6282d3b06c27e900a65a]
stable/6.18: [8c046f36222c6ce1e0daef2c45c891c72602f8a1]
stable/6.6: [f4aae11abb449dc536269705d0419ec69480faa9]

CVE-2026-53353: hsr: Remove WARN_ONCE() in hsr_addr_is_self().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53353

Introduced by commit f266a68 ("net/hsr: Better frame dispatch") in v3.17-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [afd0f17ca46258cec3a5cc48b8df9327fe772490]
stable/6.12: [0232b6fcb7615fb7fecfe0727a23065a53e228b8]
stable/6.18: [66a46e22396fd5d09606f37f73643eb20e99aa42]
stable/6.6: [271355c2ef6171dbc815e7ae653eed63444bbd58]

CVE-2026-53354: arm64: errata: Mitigate TLBI errata on various Arm CPUs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53354

Introduced commit is not determined.Fixed in v7.2-rc1.


Fixed status
mainline: [cfd391e74134db664feb499d43af286380b10ba8]
stable/5.10: [925058203229403008d77a52b1e63e2ae5f4a3cf]
stable/5.15: [8364384ae82fbffdf8968abaac3455ed854da18d]
stable/6.1: [7c3ad9365079e716b57d2363d3081ee7680cc18e]
stable/6.12: [4e7c80742e6dada9f8b9ad63f3a49c03af07ecb8]
stable/6.18: [d4fd4282204044fdedd1e42abbe70a9206f74ec0]
stable/6.6: [e717a4d08779f1a28d6e0275e75040b12c33c753]
stable/7.1: [1268c64e2bcb6e968152990e87bd10c440fcc9c0]

CVE-2026-53355: net: rds: clear i_sends on setup unwind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53355

Introduced by commit 3b12f73 ("rds: ib: add error handle") in v4.11-rc3.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [20cf0fb715c41111469577e85e35d15f099473e0]
stable/5.10: [66cccec111421a10efdc2c74499d15b93e7acae5]
stable/5.15: [2c5e5e4a5970c41f16e3ad801a78719ed5d5c71b]
stable/6.1: [29d940026dce39e3018dab6f67c9427249321270]
stable/6.12: [f16ad421a4e3e7db2d14bdf3b16f583bc4f3b30a]
stable/6.18: [1d4ec754ee3871f7e3670c67bb0298c9c5760926]
stable/6.6: [e7cf30aa5f1fc6c2a86df65df8b731df20e44d79]

CVE-2026-53356: drm/i915/gem: Fix phys BO pread/pwrite with offset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53356

Introduced by commit c6790dc ("drm/i915: Wean off
drm_pci_alloc/drm_pci_free") in v5.7-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d21ad938398bca695a511307de38a65889e3b354]
stable/5.10: [40f738991058eb3e3530c3006a5bd6fd5e29f035]
stable/5.15: [1ec8fc63e9cdb22da54e48e536c9204020416fc6]
stable/6.1: [14469860e2e39b7095dcd658d2bad38a11110a68]
stable/6.12: [3bd168dd835b93a3862cd05b0d13c432b115f9d6]
stable/6.18: [32d4c5d328a3ff995420f4f85163e1e403f43628]
stable/6.6: [07c33be968d9e0cab6cba38c81850a09942fcb2e]


* Updated CVEs

CVE-2026-52945: Revert "wireguard: device: enable threaded NAPI"

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [18e65229a328304a7ef59899a30fd34ad73ed56b]
stable/6.1: [fb978675ccfd4a93549e49624127d8332cc61cbf]
stable/6.6: [8c9e9cd398777fd60ba202211da1110614cb5bc5]

CVE-2026-52946: fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling

stable/5.15, stable/7.1 were fixed.

Fixed status
stable/5.15: [897d6a7247739fb1528f98c575df4f2e5de7f994]
stable/7.1: [36c1b57b2ecf3c61ac93f5f07bd29b6f21e226ed]

CVE-2026-52972: crypto: af_alg - Cap AEAD AD length to 0x80000000

stable/5.15 was fixed.

Fixed status
stable/5.15: [a9f68d9ed38dd6e5a6c6d75b03d25c1c133e321d]

CVE-2026-46252: regulator: core: fix locking in
regulator_resolve_supply() error path

stable/6.18 was fixed.

Fixed status
stable/6.18: [bde74af8d4466213007bdd42cc85fa72c861dea7]

CVE-2026-53070: sctp: disable BH before calling udp_tunnel_xmit_skb()

stable/6.18 was fixed.

Fixed status
stable/6.18: [0de7db2eb27e82b983157016fa604b1ba664ae5f]
Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

