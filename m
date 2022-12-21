Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDA4C4332F
	for <webhook@archiver.kernel.org>; Wed, 21 Dec 2022 22:59:37 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
 by mx.groups.io with SMTP id smtpd.web10.33231.1671663566242576204
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Dec 2022 14:59:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=p6W5eLzI;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.44, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f44.google.com with SMTP id x25-20020a056830115900b00670932eff32so126320otq.3
        for <cip-dev@lists.cip-project.org>; Wed, 21 Dec 2022 14:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cDa+6gIdQm6jQ3oDbh2kkY1cyYLr4/wPBarEE3riZnk=;
        b=p6W5eLzIZxswmbKP53orgK4C93aM4bjOCNkigBIV4xQdyJxXoFd5HMw+D5pvH5iGHQ
         VewtRd+1+x49L8q5ZwXU/dnLb1rm3+kIsKYhiNXPba9tv/LqjVd81ZR3lYSI6uErzwAQ
         X9JH7PNRbb1Rs7UReUnZPj72VlHM32GiFSGmY1XgSnj0VuhZjMq+mSQ50u+izAP1wQiD
         RvCGQ7bAi/syohjoCxvE9OkYBicmsuZ/dPP5JriqPSiTbJa0cuZJLaak3nvitVk8C6TK
         u/ZqpmtllZv5WW/sTFttpE0fXOIdW+BwZkwRawlILidYfYRH7Qta0nK9wSANIx5O3K2m
         OdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cDa+6gIdQm6jQ3oDbh2kkY1cyYLr4/wPBarEE3riZnk=;
        b=fWbs1p4ivgSvWQgfjwiZGXU03GXWLbtwpM2LGQkiPEE2QRfxCdQ/VjRxASo0So6y5N
         h7+UJ8lDVLHdXze/t6aaZsFc2XkW3u40aR71V0JF69m9dVMgdjrEBsu5CkwrWnSkIVjw
         gkkYu1LK9xIAYQC1yOOwG+dA0ve3+JlCKv7rj/0d9MAdWVkYD7XEHIKoMOU+1C5xjIzQ
         RFmnEDFVYNQvvqGkKZyz8/IKTzQ+aC+PI8yX49wi/sbKnRjv42pMvgop0dh1N358DcBd
         YlUAw6P+ANvFDhRVVwiGMhbS1VT3FipLKco1KOiMCnTokCZleIAQmzVkI2Z23T9Y8JJl
         rfkw==
X-Gm-Message-State: AFqh2krg1/BvrjUipdyNIcPrONKKVVp6dYUgwJQ3L6f29VImyPW863jO
	SL7mlRYq1bPpSNlUeRxZebiOZ5eGrNVyh6IOZinbqCcVcXXai1bO
X-Google-Smtp-Source: AMrXdXuDntah8iWGfE6X3IA1S/pNStcNTDZKcWWx+7o3LHTT+3k/AzYrB1uIkjPtp/zRzqilHiRor4y7B0UYdd5NhLg=
X-Received: by 2002:a9d:4e82:0:b0:66d:65a5:b0b3 with SMTP id
 v2-20020a9d4e82000000b0066d65a5b0b3mr255196otk.170.1671663564775; Wed, 21 Dec
 2022 14:59:24 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 22 Dec 2022 07:58:48 +0900
Message-ID: <CAODzB9phGdgNo0dOTHLyovXP7Gcj9EgR1QDHHaNrAXhBxrHQzg@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Dec 2022 22:59:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10262

Hi !

It's this week's CVE report.

This week reported 6 new CVEs and 10 updated CVEs.

* New CVEs

CVE-2022-2196: KVM: VMX: Execute IBPB on emulated VM-exit when guest has IBRS

CVSS v3 score is not provided

Introduced by commit 5c911be ("KVM: nVMX: Skip IBPB when switching
between vmcs01 and vmcs02") in 5.8-rc1.
This commit fixes commit 15d4507 ("KVM/x86: Add IBPB support") in 4.16-rc1.
Commit 5c911be is not backported to 4.x kernels.

Fixed status
mainline: [2e7eab81425ad6c875f2ed47c0ce01e78afc38a5]

CVE-2022-4543: KASLR Leakage Achievable even with KPTI through
Prefetch Side-Channel

CVSS v3 score is not provided

A user can get KASLR base address on Intel and AMD CPUs based system
even if kernel enables KPTI.

Fixed status
Not fixed yet

CVE-2022-47518: wifi: wilc1000: validate number of channels

CVSS v3 score is not provided

An issue was discovered in the Linux kernel before 6.0.11. Missing
validation of the number of channels in
drivers/net/wireless/microchip/wilc1000/cfg80211.c in the WILC1000
wireless driver can trigger a heap-based buffer overflow when copying
the list of operating channels from Wi-Fi management frames.

It looks like a vulnerable function is not present on 4.4 and 4.9.
That function is present in 5.4 and 4.19 however, this driver is
staging driver at that time.
Also, implementation of wilc_wfi_cfg_parse_ch_attr() in 5.4 and 4.19
are different from newer code. It seems as if they are not affected.

Fixed status
mainline: [0cdfa9e6f0915e3d243e2393bfa8a22e12d553b0]
stable/5.10: [3eb6b89a4e9f9e44c3170d70d8d16c3c8dc8c800]
stable/5.15: [7aed1dd5d221dabe3fe258f13ecf5fc7df393cbb]
stable/6.0: [6195b4838e10a557859862c4e7840dc0eafdd1cd]

CVE-2022-47519: wifi: wilc1000: validate length of
IEEE80211_P2P_ATTR_OPER_CHANNEL attribute

CVSS v3 score is not provided

An issue was discovered in the Linux kernel before 6.0.11. Missing
validation of IEEE80211_P2P_ATTR_OPER_CHANNEL in
drivers/net/wireless/microchip/wilc1000/cfg80211.c in the WILC1000
wireless driver can trigger an out-of-bounds write when parsing the
channel list attribute from Wi-Fi management frames.

It looks like a vulnerable function is not present on 4.4 and 4.9.
That function is present in 5.4 and 4.19 however, this driver is
staging driver at that time.
Also, implementation of wilc_wfi_cfg_parse_ch_attr() in 5.4 and 4.19
are different from newer code. It seems as if they are not affected.

Fixed status
mainline: [051ae669e4505abbe05165bebf6be7922de11f41]
stable/5.10: [905f886eae4b065656a575e8a02544045cbaadcf]
stable/5.15: [143232cb5a4c96d69a7d90b643568665463c6191]
stable/6.0: [c4b629c29a51344a99f279e0bc0caffd25897725]

CVE-2022-47520: wifi: wilc1000: validate pairwise and authentication
suite offsets

CVSS v3 score is not provided

It looks like a vulnerable function is not present in 4.x kernels.
That function is present in 5.4 however, this driver is staging driver
at that time.

Fixed status
mainline: [cd21d99e595ec1d8721e1058dcdd4f1f7de1d793]
stable/5.10: [7c6535fb4d67ea37c98a1d1d24ca33dd5ec42693]
stable/5.15: [cd9c4869710bb6e38cfae4478c23e64e91438442]
stable/6.0: [b3ac275fe82fb2e52085dace26ab65c91b3434b8]

CVE-2022-47521: wifi: wilc1000: validate length of
IEEE80211_P2P_ATTR_CHANNEL_LIST attribute

CVSS v3 score is not provided

An issue was discovered in the Linux kernel before 6.0.11. Missing
validation of IEEE80211_P2P_ATTR_CHANNEL_LIST in
drivers/net/wireless/microchip/wilc1000/cfg80211.c in the WILC1000
wireless driver can trigger a heap-based buffer overflow when parsing
the operating channel attribute from Wi-Fi management frames.

It looks like a vulnerable function is not present on 4.4 and 4.9.
That function is present in 5.4 and 4.19 however, this driver is
staging driver at that time. Also, implementation of
wilc_wfi_cfg_parse_ch_attr() in 5.4 and 4.19 are different from newer
code. It seems as if they are not affected.

Fixed status
mainline: [f9b62f9843c7b0afdaecabbcebf1dbba18599408]
stable/5.10: [5a068535c0073c8402aa0755e8ef259fb98a33c5]
stable/5.15: [e9de501cf70d2b508b2793ed3e7d5d5ceabd7a74]
stable/6.0: [0269a353bb4bf49902c702e0b55dcab0d470f5aa]

* Updated CVEs

CVE-2022-3344: KVM: SVM: nested shutdown interception could lead to host crash

Added 917401f ("KVM: x86: nSVM: leave nested mode on vCPU free") and
f9697df2 ("KVM: x86: add kvm_leave_nested") to mainline.

Fixed status
mainline: [16ae56d7e0528559bf8dc9070e3bfd8ba3de80df,
ed129ec9057f89d615ba0c81a4984a90345a1684,
  917401f26a6af5756d89b550a8e1bd50cf42b07e,
f9697df251438b0798780900e8b43bdb12a56d64]
stable/5.15: [3e87cb0caa25d667a9ca2fe15fef889e43ab8f95,
6425c590d0cc6914658a630a40b7f8226aa028c3]
stable/6.0: [5ca2721b7d3ed4d3da6323a2ea7339f745866d83,
d40ef0a511676bd65ca9acb295430c07af59ab85]

CVE-2022-3424: misc: sgi-gru: fix use-after-free error in
gru_set_context_option, gru_fault and gru_handle_user_call_os

The mainline was fixed.

Fixed status
mainline: [643a16a0eb1d6ac23744bb6e90a00fc21148a9dc]

CVE-2022-36280: An out-of-bounds(OOB) memory access vulnerability was
found in vmwgfx driver in drivers/gpu/vmxgfx/vmxgfx_kms.c

Fixed in the mainline. This bug was Introduced by commit 2ac8637
("vmwgfx: Snoop DMA transfers with non-covering sizes") in 3.2-rc1

Fixed status
mainline: [4cf949c7fafe21e085a4ee386bb2dade9067316e]

CVE-2022-41218: media: dvb-core: Fix UAF due to refcount races at releasing

Fixed in the mainline.

Fixed status
mainline: [fd3d91ab1c6ab0628fe642dd570b56302c30a792]

CVE-2022-4129: l2tp: missing lock when clearing sk_user_data can lead
to NULL pointer dereference

Added commit af295e8 ("l2tp: Don't sleep and disable BH under
writer-side sk_callback_lock") to mainline.

Fixed status
mainline: [b68777d54fac21fc833ec26ea1a2a84f975ab035,
af295e854a4e3813ffbdef26dbb6a4d6226c3ea1]

CVE-2022-3545: nfp: fix use-after-free in area_cache_get()

Patch was backported to 5.10, 5.15, and 5.4.

Fixed status
mainline: [02e1a114fdb71e59ee6770294166c30d437bf86a]
stable/5.10: [eb6313c12955c58c3d3d40f086c22e44ca1c9a1b]
stable/5.15: [9d933af8fef33c32799b9f2d3ff6bf58a63d7f24]
stable/5.4: [3c837460f920a63165961d2b88b425703f59affb]

CVE-2022-3623: mm/hugetlb: fix races when looking up a CONT-PTE/PMD
size hugetlb page

Patch was backported to 5.4.

Fixed status
mainline: [fac35ba763ed07ba93154c95ffc0c4a55023707f]
stable/5.10: [fccee93eb20d72f5390432ecea7f8c16af88c850]
stable/5.15: [3a44ae4afaa5318baed3c6e2959f24454e0ae4ff]
stable/5.19: [86a913d55c89dd13ba070a87f61a493563e94b54]
stable/5.4: [176ba4c19d1bb153aa6baaa61d586e785b7d736c]
stable/6.0: [7c7c79dd5a388758f8dfa3de89b131d5d84f25fd]

CVE-2022-3643: xen/netback: Ensure protocol headers don''t fall in the
non-linear area

Commit 7dfa764 (xen/netback: fix build warning) was added to the
mainline and was backported to 5.10 and 5.4.

Fixed status
mainline: [ad7f402ae4f466647c3a669b8a6f3e5d4271c84a,
7dfa764e0223a324366a2a1fc056d4d9d4e95491]
stable/4.14: [e173cefc814dec81e9836ecc866cdba154e693cd]
stable/4.19: [44dfdecc288b8d5932e09f5e6a597a089d5a82b2,
5215a8c7a72c0c9d49de9450ad92464832e981af]
stable/4.9: [1a1d9be7b36ee6cbdeb9d160038834d707256e88]
stable/5.10: [49e07c0768dbebff672ee1834eff9680fc6277bf,
a00444e25bbc3ff90314ebc72e9b4952b12211d9]
stable/5.15: [0fe29bd92594a747a2561589bd452c259451929e]
stable/5.4: [8fe1bf6f32cd5b96ddcd2a38110603fe34753e52]
stable/6.0: [e8851d841fe4f29b613a00de45f39c80dbfdb975]

CVE-2022-42896: Bluetooth: L2CAP: Fix accepting connection request for
invalid SPSM

Commit f937b75 ("Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm") was
added to the mainline.

Fixed status
mainline: [711f8c3fb3db61897080468586b970c87c61d9e4,
f937b758a188d6fd328a81367087eddbb2fce50f]
stable/4.14: [9f4624c42db9dd854870ccb212ddd405d8c59041]
stable/4.19: [a2045d57e844864605d39e6cfd2237861d800f13]
stable/4.9: [c834df40af8ec156e8c3c388a08ff7381cd90d80]
stable/5.10: [6b6f94fb9a74dd2891f11de4e638c6202bc89476]
stable/5.15: [81035e1201e26d57d9733ac59140a3e29befbc5a]
stable/5.4: [0d87bb6070361e5d1d9cb391ba7ee73413bc109b]
stable/6.0: [d7efeb93213becae13c6a12e4150ce1e07bd2c49]

CVE-2022-45934: Bluetooth: L2CAP: Fix u8 overflow

Patch was backported to 5.10, 5.15, and 6.0.

Fixed status
mainline: [bcd70260ef56e0aee8a4fc6cd214a419900b0765]
stable/5.10: [f3fe6817156a2ad4b06f01afab04638a34d7c9a6]
stable/5.15: [19a78143961a197de8502f4f29c453b913dc3c29]
stable/6.0: [5550bbf709c323194881737fd290c4bada9e6ead]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.

Regards,
--
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
      :masami.ichikawa@miraclelinux.com

