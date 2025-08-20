Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF54CA0EF8
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 22:19:35 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.web11.2449.1755728367514369454
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 15:19:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=yb+ZuhaW;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.171, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d6051aeafso3158037b3.2
        for <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 15:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1755728366; x=1756333166; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H3g2UE3S9UFcpxR6HME+kpY4jchLaH1S6LI5A9EXM6U=;
        b=yb+ZuhaWm0iMFjp3iAJhp+maLJ7zNYL1oehe9m33a7suOxWinOEivhyyzROwaW00ic
         pkNaAcHzjJT+5t4MeC2Jl259Fl1NqBFBXjL0oLHfVnAe2t1kqNv9uIjVc5r4eOOauNyD
         Pbkl+JzgpRvv2b7qQ6EqVJnHWhKJpqme2jGSUTwn1/yeiE18EPjlke58ml4FQupCG+Fg
         9Z05bYhdbYs4KaVydK2WF9gmN6DbVWZSNH8MKEgzAtnuBbRMj1tRJPpadXnopUlrLPjf
         S0l9jDhgZbKoyfYcXjqkusvfuwor0l38N0kPTFF/OP2Z697krKYIliY8/6I0ROkH//b4
         EDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755728366; x=1756333166;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H3g2UE3S9UFcpxR6HME+kpY4jchLaH1S6LI5A9EXM6U=;
        b=CY6Js09l+s7Ggw6BjE8QriI5bJetlQwiwG7wIHQwbp3lBDCQOnDcFWBRTzZpz9U1k0
         GRp1fm8b0MCQa18hmKEDs4PwuOkiwVhkTS6aYsK8a58iTs4/vjTM8U789O+yGdA5n0TO
         8THZx1Xf2qRSZy0PYSL0G1ecVAWHz714FbCOaJPJxjdQ3VgS2HyVmGBywqzfiltU+11R
         9Zy5h5nlEAmEpD16VrNv3eFELBw1pWQ3HaTCKvbjvXdygBgfgfo/jGx3ObPMSQQtm+0C
         89OxHtjnVCgEG0rH9swawgRXoqwRR+UABwW9IrD99NfbbVb3aB1wirSUcoAtPY5RLII9
         W+QQ==
X-Gm-Message-State: AOJu0Ywl4VnyD5nwG3GRpoypjD8RVSeKPrb1dKhJyu9pctdBNVkUQWv0
	RTO1JSj/Qs4m6+QNFKpOB0bx0FDVO19b3DGeOfePrSGW2vSs0Ps7FFcMc0Z+fTtyuqW3FYNzKRK
	E9kW3eBfPCLA1Ppns2c0zxTYXU61s/qFpy1suz3MjPkuzWw6T6LmURC0=
X-Gm-Gg: ASbGncuTkuoRFwSYllTQGt8E/6BR2MPDEZTGMhd+z1xsSlizCGHghRxiuW1ZebCZDqJ
	MYrkf7PYQyPBYzZTvUcM0NiZ0S096+njisx/gEJIIhyahCEjLXpQKum23uIBjQku2mJDVAxOj2v
	7eQY+VDSSDBT9GQtVZS2/AF4xMvHLZMTiEBfqQ0tdrpD0zV24N1IfrtC7dF+p0Rv14hk7uT1Qy/
	p0k5Hqx7kAvk4SJuLQ=
X-Google-Smtp-Source: AGHT+IH8C5ao4Rcrm4+VASTv5KFt3tKo+lLOzYfR7s/OuZXZ+DV5ndCIv8g1xQyEy+wPr78+OIE2Te/6YbO6blXE0+M=
X-Received: by 2002:a05:690c:6990:b0:71f:b944:1028 with SMTP id
 00721157ae682-71fc8b0e394mr6688577b3.49.1755728365206; Wed, 20 Aug 2025
 15:19:25 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 21 Aug 2025 07:18:48 +0900
X-Gm-Features: Ac12FXwuI5Jx9pnPeadKn8lR0xp_6gEMmaKQv9LEz8cADABCkpyE-f99cvbqDh4
Message-ID: <CAODzB9r3N_Ny0YoG7dcePkAdUGW4VH6gwP_WmfG-D5cEa=f1hg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 22:19:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19926

Hi!

It's this week's CVE report.

This week reported 118 new CVEs and 6 updated CVEs.

* New CVEs
CVE-2023-32246: ksmbd: call rcu_barrier() in ksmbd_server_exit()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-32246

Introduced commit is not determined.Fixed in v6.4-rc1.
Vulnerable code was added by 0626e66 ("cifsd: add server handler for
central processing and tranport layers") in 5.15-rc1.

Fixed status
mainline: [eb307d09fe15844fdaebeb8cc8c9b9e925430aa5]
stable/5.15: [c053e389db0d892e2ff5a60ec5e533b976503795]
stable/6.1: [b80422474ffe44cb5e813cd6da1f1c6bc50fd9d2]

CVE-2023-32249: ksmbd: not allow guest user on multichannel

Announce: https://www.cve.org/CVERecord?id=CVE-2023-32249

Introduced commit is not determined.Fixed in v6.4-rc1.
Vulnerable code was added by 0626e66 ("cifsd: add server handler for
central processing and tranport layers") in 5.15-rc1.

Fixed status
mainline: [3353ab2df5f68dab7da8d5ebb427a2d265a1f2b2]
stable/5.15: [ed76d3a8910be06cd4e4ba63bf6075bf903945a1]
stable/6.1: [1f0490586544455e5be698be2e6c30077b4ec461]

CVE-2023-4130: ksmbd: fix wrong next length validation of ea buffer in
smb2_set_ea()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-4130

Introduced commit is not determined.Fixed in v6.5-rc6.
Vulnerable code was added by 9496e26 ("ksmbd: add request buffer validation
in smb2_set_info") in 5.15-rc4.

Fixed status
mainline: [79ed288cef201f1f212dfb934bcaac75572fb8f6]
stable/5.15: [aeb974907642be095e38ecb1a400ca583958b2b0]
stable/6.1: [f339d76a3a972601d0738b881b099d49ebbdc3a2]

CVE-2023-4515: ksmbd: validate command request size

Announce: https://www.cve.org/CVERecord?id=CVE-2023-4515

Introduced by commit 2b9b8f3 ("ksmbd: validate command payload size") in v6.4.
Fixed in v6.5-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [5aa4fda5aa9c2a5a7bac67b4a12b089ab81fee3c]
stable/5.15: [595679098bdcdbfbba91ebe07a2f7f208df93870]
stable/6.1: [c6bef3bc30fd4a175aef846b7d928a6c40d091cd]

CVE-2025-38501: ksmbd: limit repeated connections from clients with the same IP

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38501

Introduced commit is not determined.Fixed in v6.17-rc1.
Vulnerable function was added by 0626e66 ("cifsd: add server handler for
central processing and tranport layers") in 5.15-rc1.

Fixed status
mainline: [e6bb9193974059ddbb0ce7763fa3882bd60d4dc3]
stable/6.1: [cb092fc3a62972a4aa47c9fe356c2c6a01cd840b]
stable/6.12: [7e5d91d3e6c62a9755b36f29c35288f06c3cd86b]
stable/6.6: [fa1c47af4ff641cf9197ecdb1f8240cbb30389c1]

CVE-2025-38502: bpf: Fix oob access in cgroup local storage

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38502

Introduced by commit 7d9c342 ("bpf: Make cgroup storages shared
between programs on the same cgroup") in v5.9-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abad3d0bad72a52137e0c350c59542d75ae4f513]

CVE-2025-38503: btrfs: fix assertion when building free space tree

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38503

Introduced commit is not determined.Fixed in v6.16-rc4.
Vulnerable function was added by a5ed918 ("Btrfs: implement the free space
B-tree") in 4.5-rc1.

Fixed status
mainline: [1961d20f6fa8903266ed9bd77c691924c22c8f02]
stable/6.1: [7c77df23324f60bcff0ea44392e2c82e9486640c]
stable/6.12: [0bcc14f36c7ad37121cf5c0ae18cdde5bfad9c4e]
stable/6.6: [f4428b2d4c68732653e93f748f538bdee639ff80]

CVE-2025-38504: io_uring/zcrx: fix pp destruction warnings

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38504

Introduced by commit 34a3e60 ("io_uring/zcrx: implement zerocopy
receive pp memory provider") in v6.15-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [203817de269539c062724d97dfa5af3cdf77a3ec]

CVE-2025-38505: wifi: mwifiex: discard erroneous disassoc frames on
STA interface

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38505

Introduced by commit 3699589 ("wifi: mwifiex: add host mlme for client
mode") in v6.12-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b602ddc0df723992721b0d286c90c9bdd755b34]
stable/6.12: [a963819a121f5dd61e0b39934d8b5dec529da96a]

CVE-2025-38506: KVM: Allow CPU to reschedule while setting per-page
memory attributes

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38506

Introduced by commit 5a47555 ("KVM: Introduce per-page memory
attributes") in v6.8-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47bb584237cc285e3a860b70c01f7bda9dcfb05b]
stable/6.12: [d9bd1163c8d8f716f45e54d034ee28757cc85549]

CVE-2025-38507: HID: nintendo: avoid bluetooth suspend/resume stalls

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38507

Introduced commit is not determined.Fixed in v6.16-rc4.
According to the CVE-2025-38507.json, this bug was introduced by
2af16c1 ("HID: nintendo: add nintendo switch controller driver") in 5.16-rc1.

Fixed status
mainline: [4a0381080397e77792a5168069f174d3e56175ff]
stable/6.12: [7b4a026313529a487821ef6ab494a61f12c1db08]

CVE-2025-38508: x86/sev: Use TSC_FACTOR for Secure TSC frequency calculation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38508

Introduced by commit 73bbf3b ("x86/tsc: Init the TSC for Secure TSC
guests") in v6.14-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52e1a03e6cf61ae165f59f41c44394a653a0a788]

CVE-2025-38509: wifi: mac80211: reject VHT opmode for unsupported channel widths

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38509

Introduced by commit 751e748 ("wifi: mac80211: expose
ieee80211_chan_width_to_rx_bw() to drivers") in v6.13-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58fcb1b4287ce38850402bb2bb16d09bf77b91d9]

CVE-2025-38510: kasan: remove kasan_find_vm_area() to prevent possible deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38510

Introduced by commit c056a36 ("kasan: print virtual mapping info in
reports") in v5.18-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ee9b3d84775944fb8c8a447961cd01274ac671c]
stable/6.1: [595f78d99b9051600233c0a5c4c47e1097e6ed01]
stable/6.12: [2d89dab1ea6086e6cbe6fe92531b496fb6808cb9]
stable/6.6: [8377d7744bdce5c4b3f1b58924eebd3fdc078dfc]

CVE-2025-38511: drm/xe/pf: Clear all LMTT pages on alloc

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38511

Introduced by commit b1d2040 ("drm/xe/pf: Introduce Local Memory
Translation Table") in v6.8-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [705a412a367f383430fa34bada387af2e52eb043]
stable/6.12: [ff4b8c9ade1b82979fdd01e6f45b60f92eed26d8]

CVE-2025-38512: wifi: prevent A-MSDU attacks in mesh networks

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38512

Introduced commit is not determined.Fixed in v6.16-rc6.
This vulnerability is variant of CVE-2020-24588.

Fixed status
mainline: [737bb912ebbe4571195c56eba557c4d7315b26fb]
stable/6.1: [e2c8a3c0388aef6bfc4aabfba07bc7dff16eea80]
stable/6.12: [e01851f6e9a665a6011b14714b271d3e6b0b8d32]
stable/6.6: [ec6392061de6681148b63ee6c8744da833498cdd]

CVE-2025-38513: wifi: zd1211rw: Fix potential NULL pointer dereference
in zd_mac_tx_to_dev()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38513

Introduced by commit 459c51a ("zd1211rw: port to mac80211") in v2.6.25-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [29ea915b1e8758a4d63a45a4f1d5ab65d0d9fa56]
mainline: [74b1ec9f5d627d2bdd5e5b6f3f81c23317657023]
stable/5.10: [014c34dc132015c4f918ada4982e952947ac1047]
stable/5.15: [b24f65c184540dfb967479320ecf7e8c2e9220dc]
stable/5.4: [c1958270de947604cc6de05fc96dbba256b49cf0]
stable/6.1: [adf08c96b963c7cd7ec1ee1c0c556228d9bedaae]
stable/6.12: [fcd9c923b58e86501450b9b442ccc7ce4a8d0fda]
stable/6.6: [5420de65efbeb6503bcf1d43451c9df67ad60298]

CVE-2025-38514: rxrpc: Fix oops due to non-existence of prealloc backlog struct

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38514

Introduced commit is not determined.Fixed in v6.16-rc6.
Introduced by 248f219 ("rxrpc: Rewrite the data and ack handling code")
in 4.9-rc1.

Fixed status
cip/4.19-st: [947c6b05e3c7e316fb4de0e5831f27a676d25da7]
mainline: [880a88f318cf1d2a0f4c0a7ff7b07e2062b434a4]
stable/5.10: [f7afb3ff01c42c49e8a143cdce400b95844bb506]
stable/5.15: [f5e72b7824d08c206ce106d30cb37c4642900ccc]
stable/5.4: [bf0ca6a1bc4fb904b598137c6718785a107e3adf]
stable/6.1: [0eef29385d715d4c7fd707b18d4a9b76c76dd5e6]
stable/6.12: [d1ff5f9d2c5405681457262e23c720b08977c11f]
stable/6.6: [efc1b2b7c1a308b60df8f36bc2d7ce16d3999364]

CVE-2025-38515: drm/sched: Increment job count before swapping tail spsc queue

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38515

Introduced by commit 1b1f42d ("drm: move amd_gpu_scheduler into common
location") in v4.16-rc1.
Introduced by commit 27105db ("drm/amdgpu: Add SPSC queue to
scheduler.") in v4.16-rc1.
Fixed in v6.16-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e4e6360ae748e9f21d3fc57ba96aed9908b10d2d]
mainline: [8af39ec5cf2be522c8eb43a3d8005ed59e4daaee]
stable/5.10: [e62f51d0ec8a9baf324caf9a564f8e318d36a551]
stable/5.15: [ef841f8e4e1ff67817ca899bedc5ebb00847c0a7]
stable/5.4: [549a9c78c3ea6807d0dc4162a4f5ba59f217d5a0]
stable/6.1: [f9a4f28a4fc4ee453a92a9abbe36e26224d17749]
stable/6.12: [e2d6547dc8b9b332f9bc00875197287a6a4db65a]
stable/6.6: [c64f5310530baf75328292f9b9f3f2961d185183]

CVE-2025-38516: pinctrl: qcom: msm: mark certain pins as invalid for interrupts

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38516

Introduced by commit f365be0 ("pinctrl: Add Qualcomm TLMM driver") in v3.14-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93712205ce2f1fb047739494c0399a26ea4f0890]
stable/5.10: [3f8fc02c2582c1dfad1785e9c7bc8b4e1521af0a]
stable/5.15: [cb4b08a095b1fa4b3fca782757517e4e9a917d8e]
stable/5.4: [6a89563ccf9cd0d745e2291302878a061508573f]
stable/6.1: [cc145e02d6b8494c48f91958d52fa76b7e577f7b]
stable/6.12: [275605a8b48002fe98675a5c06f3e39c09067ff2]
stable/6.6: [1d57f7132662e96aace3b8a000616efde289aae1]

CVE-2025-38517: lib/alloc_tag: do not acquire non-existent lock in
alloc_tag_top_users()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38517

Introduced by commit 780138b ("alloc_tag: check mem_profiling_support
in alloc_tag_init") in v6.16-rc1.
Introduced by commit 1438d34 ("lib: add memory allocations report in
show_mem()") in v6.10-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99af22cd34688cc0d535a1919e0bea4cbc6c1ea1]
stable/6.12: [febc0b5dbabda414565bdfaaaa59d26f787d5fe7]

CVE-2025-38518: x86/CPU/AMD: Disable INVLPGB on Zen2

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38518

Introduced by commit 767ae43 ("x86/mm: Add INVLPGB feature and Kconfig
entry") in v6.15-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a74bb5f202dabddfea96abc1328fcedae8aa140a]

CVE-2025-38519: mm/damon: fix divide by zero in damon_get_intervals_score()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38519

Introduced by commit f04b0fe ("mm/damon/core: implement intervals
auto-tuning") in v6.15-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd225b9591442065beb876da72656f4a2d627d03]

CVE-2025-38520: drm/amdkfd: Don't call mmput from MMU notifier callback

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38520

Introduced by commit fa582c6 ("drm/amdkfd: Use mmget_not_zero in MMU
notifier") in v5.19-rc2.
Fixed in v6.16-rc5.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [cf234231fcbc7d391e2135b9518613218cc5347f]
stable/6.1: [c1bde9d48e09933c361521720f77a8072083c83a]
stable/6.12: [e90ee15ce28c61f6d83a0511c3e02e2662478350]
stable/6.6: [145a56bd68f4bff098d59fbc7c263d20dfef4fc4]

CVE-2025-38521: drm/imagination: Fix kernel crash when hard resetting the GPU

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38521

Introduced by commit cc1aeed ("drm/imagination: Implement firmware
infrastructure and META FW support") in v6.8-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d38376b3ee48d073c64e75e150510d7e6b4b04f7]
stable/6.12: [9f852d301f642223c4798f3c13ba15e91165d078]

CVE-2025-38522: sched/ext: Prevent update_locked_rq() calls with NULL rq

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38522

Introduced by commit 18853ba ("sched_ext: Track currently locked rq")
in v6.15-rc7.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e14fd98c6d66cb76694b12c05768e4f9e8c95664]

CVE-2025-38523: cifs: Fix the smbd_response slab to allow usercopy

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38523

Introduced by commit ee4cdf7 ("netfs: Speed up buffered reading") in v6.12-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43e7e284fc77b710d899569360ea46fa3374ae22]
stable/6.12: [87dcc7e33fc3dcb8ed32333cec016528b5bb6ce4]

CVE-2025-38524: rxrpc: Fix recv-recv race of completed call

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38524

Introduced by commit 248f219 ("rxrpc: Rewrite the data and ack
handling code") in v4.9-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [962fb1f651c2cf2083e0c3ef53ba69e3b96d3fbc]
stable/6.12: [839fe96c15209dc2255c064bb44b636efe04f032]
stable/6.6: [7692bde890061797f3dece0148d7859e85c55778]

CVE-2025-38525: rxrpc: Fix irq-disabled in local_bh_enable()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38525

Introduced by commit a2ea9a9 ("rxrpc: Use irq-disabling spinlocks
between app and I/O thread") in v6.14-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4d2878369d590bf8455e3678a644e503172eafa]

CVE-2025-38526: ice: add NULL check in eswitch lag check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38526

Introduced by commit 776fe19 ("ice: block default rule setting on LAG
interface") in v6.6-rc6.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ce58b01ada408b372f15b7c992ed0519840e3cf]
stable/6.12: [5a5d64f0eec82076b2c09fee2195d640cfbe3379]
stable/6.6: [27591d926191e42b2332e4bad3bcd3a49def393b]

CVE-2025-38527: smb: client: fix use-after-free in cifs_oplock_break

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38527

Introduced by commit b98749c ("CIFS: keep FileInfo handle live during
oplock break") in v5.1-rc6.
Fixed in v6.16-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [705c79101ccf9edea5a00d761491a03ced314210]
stable/6.1: [0a4eec84d4d2c4085d4ed8630fd74e4b39033c1b]
stable/6.12: [09bce2138a30ef10d8821c8c3f73a4ab7a5726bc]
stable/6.6: [2baaf5bbab2ac474c4f92c10fcb3310f824db995]

CVE-2025-38528: bpf: Reject %p% format string in bprintf-like helpers

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38528

Introduced by commit 48cac3f ("bpf: Implement formatted output helpers
with bstr_printf") in v5.13-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8242745871f81a3ac37f9f51853d12854fd0b58]
stable/6.1: [61d5fa45ed13e42af14c7e959baba9908b8ee6d4]
stable/6.12: [6952aeace93f8c9ea01849efecac24dd3152c9c9]
stable/6.6: [e7be679124bae8cf4fa6e40d7e1661baddfb3289]

CVE-2025-38529: comedi: aio_iiro_16: Fix bit shift out of bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38529

Introduced by commit ad7a370 ("staging: comedi: aio_iiro_16: add
command support for change of state detection") in v4.0-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66acb1586737a22dd7b78abc63213b1bcaa100e4]
stable/6.1: [ff30dd3f15f443d2a0085b12ec2cc95d44f35fa7]
stable/6.12: [e0f3c0867d7d231c70984f05c97752caacd0daba]
stable/6.6: [955e8835855fed8e87f7d8c8075564a1746c1b4c]

CVE-2025-38530: comedi: pcl812: Fix bit shift out of bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38530

Introduced by commit fcdb427 ("Staging: comedi: add pcl821 driver") in
v2.6.30-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b14b076ce593f72585412fc7fd3747e03a5e3632]
stable/6.1: [5bfa301e1e59a9b1a7b62a800b54852337c97416]
stable/6.12: [a27e27eee313fe1c450b6af1e80e64412546cab4]
stable/6.6: [7e470d8efd10725b189ca8951973a8425932398a]

CVE-2025-38531: iio: common: st_sensors: Fix use of uninitialize device structs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38531

Introduced commit is not determined.Fixed in v6.16-rc7.


Fixed status
mainline: [9f92e93e257b33e73622640a9205f8642ec16ddd]
stable/6.12: [610615c9668037e3eca11132063b93b2d945af13]

CVE-2025-38532: net: libwx: properly reset Rx ring descriptor

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38532

Introduced by commit 3c47e8a ("net: libwx: Support to receive packets
in NAPI") in v6.3-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d992ed7e1b687ad7df0763d3e015a5358646210b]
stable/6.12: [10e27b2a6ebeda49e9c2897a699d3ce1ded565ee]
stable/6.6: [d510116c80b37efb100ce8d5ee326214b0157293]

CVE-2025-38533: net: libwx: fix the using of Rx buffer DMA

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38533

Introduced by commit 3c47e8a ("net: libwx: Support to receive packets
in NAPI") in v6.3-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5fd77cc6bd9b368431a815a780e407b7781bcca0]
stable/6.12: [ba7c793f96c1c2b944bb6f423d7243f3afc30fe9]
stable/6.6: [027701180a7bcb64c42eab291133ef0c87b5b6c5]

CVE-2025-38534: netfs: Fix copy-to-cache so that it performs
collection with ceph+fscache

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38534

Introduced by commit e2d46f2 ("netfs: Change the read result collector
to only use one work item") in v6.14-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c238e30774e3022a505fa54311273add7570f13]

CVE-2025-38535: phy: tegra: xusb: Fix unbalanced regulator disable in
UTMI PHY mode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38535

Introduced by commit 49d46e3 ("phy: tegra: xusb: Add set_mode support
for UTMI phy on Tegra186") in v5.7-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cefc1caee9dd06c69e2d807edc5949b329f52b22]
stable/6.1: [1bb85b5c2bd43b687c3d54eb6328917f90dd38fc]
stable/6.12: [ec7f98ff05f0649af0adeb4808c7ba23d6111ef9]
stable/6.6: [5367cdeb75cb6c687ca468450bceb2602ab239d8]

CVE-2025-38536: net: airoha: fix potential use-after-free in airoha_npu_get()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38536

Introduced by commit 23290c7 ("net: airoha: Introduce Airoha NPU
support") in v6.15-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3cd582e7d0787506990ef0180405eb6224fa90a6]

CVE-2025-38537: net: phy: Don't register LEDs for genphy

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38537

Introduced by commit 01e5b72 ("net: phy: Add a binding for PHY LEDs")
in v6.4-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0f2b992d8185a0366be951685e08643aae17d6d]
stable/6.12: [fd6493533af9e5d73d0d42ff2a8ded978a701dc6]
stable/6.6: [ec158d05eaa91b2809cab65f8068290e3c05ebdd]

CVE-2025-38538: dmaengine: nbpfaxi: Fix memory corruption in probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38538

Introduced by commit b45b262 ("dmaengine: add a driver for AMBA AXI
NBPF DMAC IP cores") in v3.17-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [188c6ba1dd925849c5d94885c8bbdeb0b3dcf510]
stable/6.1: [f366b36c5e3ce29c9a3c8eed3d1631908e4fc8bb]
stable/6.12: [122160289adf8ebf15060f1cbf6265b55a914948]
stable/6.6: [4bb016438335ec02b01f96bf1367378c2bfe03e5]

CVE-2025-38539: tracing: Add down_write(trace_event_sem) when adding trace event

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38539

Introduced by commit 110bf2b ("tracing: add protection around module
events unload") in v2.6.31-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5e8acc14dcb314a9b61ff19dcd9fdd0d88f70df]
stable/6.1: [7803b28c9aa8d8bd4e19ebcf5f0db9612b0f333b]
stable/6.12: [33e20747b47ddc03569b6bc27a2d6894c1428182]
stable/6.6: [6bc94f20a4c304997288f9a45278c9d0c06987d3]

CVE-2025-38540: HID: quirks: Add quirk for 2 Chicony Electronics HP 5MP Cameras

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38540

Introduced commit is not determined.Fixed in v6.16-rc4.


Fixed status
cip/4.19-st: [4c4cada0a10a72caa8af7f88e7bf6c732cdc9928]
mainline: [54bae4c17c11688339eb73a04fd24203bb6e7494]
stable/5.10: [7ac00f019698f614a49cce34c198d0568ab0e1c2]
stable/5.15: [1b297ab6f38ca60a4ca7298b297944ec6043b2f4]
stable/5.4: [35f1a5360ac68d9629abbb3930a0a07901cba296]
stable/6.1: [2b0931eee48208c25bb77486946dea8e96aa6a36]
stable/6.12: [c72536350e82b53a1be0f3bfdf1511bba2827102]
stable/6.6: [3ce1d87d1f5d80322757aa917182deb7370963b9]

CVE-2025-38541: wifi: mt76: mt7925: Fix null-ptr-deref in mt7925_thermal_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38541

Introduced by commit 396e41a ("wifi: mt76: mt7925: support temperature
sensor") in v6.9-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [03ee8f73801a8f46d83dfc2bf73fb9ffa5a21602]
stable/6.12: [1bbdf4213711bb6dc365e7628430a63dd3280794]

CVE-2025-38542: net: appletalk: Fix device refcount leak in atrtr_create()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38542

Introduced by commit c7f905f ("[ATALK]: Add missing dev_hold() to
atrtr_create().") in v2.6.12.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [48d92e3f35e304573a7653139ce5295f05e15abe]
mainline: [711c80f7d8b163d3ecd463cd96f07230f488e750]
stable/5.10: [a7852b01793669248dce0348d14df89e77a32afd]
stable/5.15: [b2f5dfa87367fdce9f8b995bc6c38f64f9ea2c90]
stable/5.4: [b92bedf71f25303e203a4e657489d76691a58119]
stable/6.1: [d2e9f50f0bdad73b64a871f25186b899624518c4]
stable/6.12: [473f3eadfc73b0fb6d8dee5829d19a5772e387f7]
stable/6.6: [4a17370da6e476d3d275534e9e9cd2d02c57ca46]

CVE-2025-38543: drm/tegra: nvdec: Fix dma_alloc_coherent error check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38543

Introduced by commit 46f226c ("drm/tegra: Add NVDEC driver") in v5.17-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44306a684cd1699b8562a54945ddc43e2abc9eab]
stable/6.1: [61b8d20962d00b7df117011c52f97cbb9c76a669]
stable/6.12: [a560de522374af931fa994d161db3667b0bb2545]
stable/6.6: [d1240029f97ac8c06db4dd4407bbbf83e8d08570]

CVE-2025-38544: rxrpc: Fix bug due to prealloc collision

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38544

Introduced by commit 00e9071 ("rxrpc: Preallocate peers, conns and
calls for incoming service requests") in v4.9-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69e4186773c6445b258fb45b6e1df18df831ec45]
stable/6.12: [5385ad53793de2ab11e396bdcdaa65bb04b4dad6]
stable/6.6: [432c5363cd6fe5a928bbc94524d28b05515684dd]

CVE-2025-38545: net: ethernet: ti: am65-cpsw-nuss: Fix skb size by
accounting for skb_shared_info

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38545

Introduced by commit 8acacc4 ("net: ethernet: ti: am65-cpsw: Add
minimal XDP support") in v6.10-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [02c4d6c26f1f662da8885b299c224ca6628ad232]
stable/6.12: [fc2fffa2facac15ce711e95f98f954426e025bc5]

CVE-2025-38546: atm: clip: Fix memory leak of struct clip_vcc.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38546

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d537410974cdd77487c8f6eb499ca2cde719c475]
mainline: [62dba28275a9a3104d4e33595c7b3328d4032d8d]
stable/5.10: [9e4dbeee56f614e3f1e166e5d0655a999ea185ef]
stable/5.15: [1c075e88d5859a2c6b43b27e0e46fb281cef8039]
stable/5.4: [2fb37ab3226606cbfc9b2b6f9e301b0b735734c5]
stable/6.1: [0c17ff462d98c997d707ee5cf4e4a9b1b52b9d90]
stable/6.12: [9f771816f14da6d6157a8c30069091abf6b566fb]
stable/6.6: [1fb9fb5a4b5cec2d56e26525ef8c519de858fa60]

CVE-2025-38547: iio: adc: axp20x_adc: Add missing sentinel to AXP717
ADC channel maps

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38547

Introduced by commit 5ba0cb9 ("iio: adc: axp20x_adc: add support for
AXP717 ADC") in v6.12-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3281ddcea6429f7bc1fdb39d407752dd1371aba9]
stable/6.12: [086a76474121bf2351438e311376ec67b410b2ea]

CVE-2025-38548: hwmon: (corsair-cpro) Validate the size of the
received input buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38548

Introduced by commit 40c3a44 ("hwmon: add Corsair Commander Pro
driver") in v5.9-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [495a4f0dce9c8c4478c242209748f1ee9e4d5820]
stable/6.1: [0db770e2922389753ddbd6663a5516a32b97b743]
stable/6.12: [3c4bdc8a852e446080adc8ceb90ddd67a56e1bb8]
stable/6.6: [eda5e38cc4dd2dcb422840540374910ef2818494]

CVE-2025-38549: efivarfs: Fix memory leak of efivarfs_fs_info in
fs_context error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38549

Introduced by commit 5329aa5 ("efivarfs: Add uid/gid mount options")
in v6.7-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64e135f1eaba0bbb0cdee859af3328c68d5b9789]
stable/6.12: [816d36973467d1c9c08a48bdffe4675e219a2e84]

CVE-2025-38550: ipv6: mcast: Delay put pmc->idev in mld_del_delrec()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38550

Introduced by commit 63ed8de ("mld: add mc_lock for protecting
per-interface mld data") in v5.13-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae3264a25a4635531264728859dbe9c659fad554]
stable/6.1: [728db00a14cacb37f36e9382ab5fad55caf890cc]
stable/6.12: [7929d27c747eafe8fca3eecd74a334503ee4c839]
stable/6.6: [dcbc346f50a009d8b7f4e330f9f2e22d6442fa26]

CVE-2025-38551: virtio-net: fix recursived rtnl_lock() during probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38551

Introduced by commit df28de7 ("virtio-net: synchronize operstate with
admin state on up/down") in v6.12-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be5dcaed694e4255dc02dd0acfe036708c535def]
stable/6.12: [4e7c46362550b229354aeb52038f414e231b0037]

CVE-2025-38552: mptcp: plug races between subflow fail and subflow creation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38552

Introduced by commit 478d770 ("mptcp: send out MP_FAIL when data
checksum fails") in v5.15-rc1.
Fixed in v6.16-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [def5b7b2643ebba696fc60ddf675dca13f073486]
stable/6.12: [f81b6fbe13c7fc413b5158cdffc6a59391a2a8db]
stable/6.6: [7c96d519ee15a130842a6513530b4d20acd2bfcd]

CVE-2025-38553: net/sched: Restrict conditions for adding duplicating
netems to qdisc tree

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38553

Introduced by commit 0afb51e ("[PKT_SCHED]: netem: reinsert for
duplication") in v2.6.12.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec8e0e3d7adef940cdf9475e2352c0680189d14e]
stable/6.1: [325f5ec67cc0a77f2d0d453445b9857f1cd06c76]
stable/6.12: [795cb393e38977aa991e70a9363da0ee734b2114]
stable/6.6: [103c4e27ec9f5fe53022e46e976abf52c7221baf]

CVE-2025-38554: mm: fix a UAF when vma->mm is freed after
vma->vm_refcnt got dropped

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38554

Introduced by commit 3104138 ("mm: make vma cache
SLAB_TYPESAFE_BY_RCU") in v6.15-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9bbffee67ffd16360179327b57f3b1245579ef08]

CVE-2025-38555: usb: gadget : fix use-after-free in composite_dev_cleanup()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38555

Introduced by commit 37a3a53 ("usb: gadget: OS Feature Descriptors
support") in v3.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [151c0aa896c47a4459e07fee7d4843f44c1bb18e]
stable/6.1: [e624bf26127645a2f7821e73fdf6dc64bad07835]
stable/6.12: [5f06ee9f9a3665d43133f125c17e5258a13f3963]
stable/6.6: [aada327a9f8028c573636fa60c0abc80fb8135c9]

CVE-2025-38556: HID: core: Harden s32ton() against conversion to 0 bits

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38556

Introduced by commit dde5845 ("[PATCH] Generic HID layer - code
split") in v2.6.20.16.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6b87bfc2ab5bccb7ad953693c85d9062aef3fdd]

CVE-2025-38557: HID: apple: validate feature-report field count to
prevent NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38557

Introduced by commit 394ba61 ("HID: apple: Add support for magic
keyboard backlight on T2 Macs") in v6.11-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1bb3363da862e0464ec050eea2fb5472a36ad86b]
stable/6.12: [ba08cc6801ec5fb98f2d02b5f0c614c931845325]

CVE-2025-38558: usb: gadget: uvc: Initialize frame-based format color
matching descriptor

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38558

Introduced by commit 7b5a589 ("usb: gadget: uvc: configfs: Add
frame-based frame format support") in v6.13-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [323a80a1a5ace319a722909c006d5bdb2a35d273]

CVE-2025-38559: platform/x86/intel/pmt: fix a crashlog NULL pointer access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38559

Introduced by commit 045a513 ("platform/x86/intel/pmt: Use PMT
callbacks") in v6.12-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [54d5cd4719c5e87f33d271c9ac2e393147d934f8]
stable/6.12: [860d93bd6a21f08883711196344c353bc3936a2b]

CVE-2025-38560: x86/sev: Evict cache lines during SNP memory validation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38560

Introduced commit is not determined.Fixed in v6.17-rc2.
SEV-SNP was first introduced in 5.19.

Fixed status
mainline: [7b306dfa326f70114312b320d083b21fa9481e1e]
stable/6.1: [1fec416c03d0a64cc21aa04ce4aa14254b017e6a]
stable/6.12: [aed15fc08f15dbb15822b2a0b653f67e76aa0fdf]
stable/6.6: [1fb873971e23c35c53823c62809a474a92bc3022]

CVE-2025-38561: ksmbd: fix Preauh_HashValue race condition

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38561

Introduced commit is not determined.Fixed in v6.17-rc1.
It looks as if vulnerable code was added by e2f3448 ("cifsd: add server-side
procedures for SMB3") in 5.15-rc1.

Fixed status
mainline: [44a3059c4c8cc635a1fb2afd692d0730ca1ba4b6]
stable/6.1: [fbf5c0845ed15122a770bca9be1d9b60b470d3aa]
stable/6.12: [edeecc7871e8fc0878d53ce286c75040a0e38f6c]
stable/6.6: [b69fd87076daa66f3d186bd421a7b0ee0cb45829]

CVE-2025-38562: ksmbd: fix null pointer dereference error in
generate_encryptionkey

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38562

Introduced commit is not determined.Fixed in v6.17-rc1.
Vulnerable code was added by e2f3448 ("cifsd: add server-side procedures
for SMB3") in 5.15-rc1.

Fixed status
mainline: [9b493ab6f35178afd8d619800df9071992f715de]
stable/6.1: [96a82e19434a2522525baab59c33332658bc7653]
stable/6.12: [2a30ed6428ce83afedca1a6c5c5c4247bcf12d0e]
stable/6.6: [d79c8bebaa622ee223128be7c66d8aaeeb634a57]

CVE-2025-38563: perf/core: Prevent VMA split of buffer mappings

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38563

Introduced by commit 45bfb2e ("perf: Add AUX area to ring buffer for
raw data streams") in v4.1-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b024d7b56c77191cde544f838debb7f8451cd0d6]
stable/6.1: [7b84cb58d1f0aa07656802eae24689566e5f5b1b]
stable/6.12: [e529888b7e8092912dd8789bdfc76685ccd2ff5f]
stable/6.6: [6757a31a8e295ae4f01717a954afda173f25a121]

CVE-2025-38564: perf/core: Handle buffer mapping fail correctly in perf_mmap()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38564

Introduced by commit b709eb8 ("perf: map pages in advance") in v6.14-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f74b9f4ba63ffdf597aaaa6cad7e284cb8e04820]

CVE-2025-38565: perf/core: Exit early on perf_mmap() fail

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38565

Introduced by commit 1e0fb9e ("perf: Add pmu callbacks to track event
mapping and unmapping") in v4.0-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07091aade394f690e7b655578140ef84d0e8d7b0]
stable/6.1: [27d44145bd576bbef9bf6165bcd78128ec3e6cbd]
stable/6.12: [92043120a2e992800580855498ab8507e1b22db9]
stable/6.6: [f41e9eba77bf97626e04296dc5677d02816d2432]

CVE-2025-38566: sunrpc: fix handling of server side tls alerts

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38566

Introduced by commit 5e052dd ("SUNRPC: Recognize control messages in
server-side TCP socket code") in v6.4-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bee47cb026e762841f3faece47b51f985e215edb]
stable/6.12: [25bb3647d30a20486b5fe7cff2b0e503c16c9692]
stable/6.6: [b1df394621710b312f0393e3f240fdac0764f968]

CVE-2025-38567: nfsd: avoid ref leak in nfsd_open_local_fh()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38567

Introduced by commit e6f7e14 ("nfs_localio: simplify interface to nfsd
for getting nfsd_file") in v6.16-rc1.
Fixed in v6.17-rc2.

Bug introduced commit was backported to following branches.
stable/6.15

Fixed status
mainline: [e5a73150776f18547ee685c9f6bfafe549714899]

CVE-2025-38568: net/sched: mqprio: fix stack out-of-bounds write in tc
entry parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38568

Introduced by commit f62af20 ("net/sched: mqprio: allow per-TC user
input of FP adminStatus") in v6.4-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ffd2dc4c6c49ff4f1e5d34e454a6a55608104c17]
stable/6.12: [d00e4125680f7074c4f42ce3c297336f23128e70]
stable/6.6: [39491e859fd494d0b51adc5c7d54c8a7dcf1d198]

CVE-2025-38569: benet: fix BUG when creating VFs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38569

Introduced by commit 1a82d19 ("be2net: fix sleeping while atomic bugs
in be_ndo_bridge_getlink") in v6.14-rc6.
Fixed in v6.17-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/5.4 stable/6.1
stable/6.12 stable/6.6

Fixed status
mainline: [5a40f8af2ba1b9bdf46e2db10e8c9710538fbc63]
stable/6.1: [46d44a23a3723a89deeb65b13cddb17f8d9f2700]
stable/6.12: [0ddfe8b127ef1149fddccb79db6e6eaba7738e7d]
stable/6.6: [c377ba2be9430d165a98e4b782902ed630bc7546]

CVE-2025-38570: eth: fbnic: unlink NAPIs from queues on error to open

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38570

Introduced by commit 557d022 ("eth: fbnic: centralize the queue count
and NAPI<>queue setting") in v6.14-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b31bcb025cb497da2b01f87173108ff32d350d2]

CVE-2025-38571: sunrpc: fix client side handling of tls alerts

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38571

Introduced by commit dea034b ("SUNRPC: Capture CMSG metadata on
client-side receive") in v6.5-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc5d59081fa26506d02de2127ab822f40d88bc5a]
stable/6.12: [c36b2fbd60e8f9c6f975522130998608880c93be]
stable/6.6: [a55b3d15331859d9fdd261cfa6d34ca2aeb0fb95]

CVE-2025-38572: ipv6: reject malicious packets in ipv6_gso_segment()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38572

Introduced by commit d1da932 ("ipv6: Separate ipv6 offload support")
in v3.8-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d45cf1e7d7180256e17c9ce88e32e8061a7887fe]
stable/6.1: [de322cdf600fc9433845a9e944d1ca6b31cfb67e]
stable/6.12: [5489e7fc6f8be3062f8cb7e49406de4bfd94db67]
stable/6.6: [ef05007b403dcc21e701cb1f30d4572ac0a9da20]

CVE-2025-38573: spi: cs42l43: Property entry should be a null-terminated array

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38573

Introduced by commit 0ca645a ("spi: cs42l43: Add speaker id support to
the bridge configuration") in v6.11-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ffcfd071eec7973e58c4ffff7da4cb0e9ca7b667]
stable/6.12: [674328102baad76c7a06628efc01974ece5ae27f]

CVE-2025-38574: pptp: ensure minimal skb length in pptp_xmit()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38574

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de9c4861fb42f0cd72da844c3c34f692d5895b7b]
stable/6.1: [504cc4ab91073d2ac7404ad146139f86ecee7193]
stable/6.12: [ea99b88b1999ebcb24d5d3a6b7910030f40d3bba]
stable/6.6: [5005d24377378a20e5c0e53052fc4ebdcdcbc611]

CVE-2025-38576: powerpc/eeh: Make EEH driver device hotplug safe

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38576

Introduced commit is not determined.Fixed in v6.17-rc1.


Fixed status
mainline: [1010b4c012b0d78dfb9d3132b49aa2ef024a07a7]
stable/6.1: [59c6d3d81d42bf543c90597b4f38c53d6874c5a1]
stable/6.12: [d2c60a8a387e9fcc28447ef36c03f8e49fd052a6]
stable/6.6: [a426e8a6ae161f51888585b065db0f8f93ab2e16]

CVE-2025-38577: f2fs: fix to avoid panic in f2fs_evict_inode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38577

Introduced by commit 0f18b46 ("f2fs: flush inode metadata when
checkpoint is doing") in v4.8-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a509a55f8eecc8970b3980c6f06886bbff0e2f68]
stable/6.1: [4732ca17c17f5062426cfa982f43593e6b81963b]
stable/6.12: [97df495d754116c8c28ac6a4112f831727bde887]
stable/6.6: [880ef748e78a1eb7df2d8e11a9ef21e98bcaabe5]

CVE-2025-38578: f2fs: fix to avoid UAF in f2fs_sync_inode_meta()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38578

Introduced by commit 0f18b46 ("f2fs: flush inode metadata when
checkpoint is doing") in v4.8-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c30d79930132466f5be7d0b57add14d1a016bda]
stable/6.1: [917ae5e280bc263f56c83fba0d0f0be2c4828083]
stable/6.12: [dea243f58a8391e76f42ad5eb59ff210519ee772]
stable/6.6: [3d37cadaac1a8e108e576297aab9125b24ea2dfe]

CVE-2025-38579: f2fs: fix KMSAN uninit-value in extent_info usage

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38579

Introduced by commit 94afd6d ("f2fs: extent cache: support unaligned
extent") in v5.15-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [154467f4ad033473e5c903a03e7b9bca7df9a0fa]
stable/6.1: [e68b751ec2b15d866967812c57cfdfc1eba6a269]
stable/6.12: [44a79437309e0ee2276ac17aaedc71253af253a8]
stable/6.6: [dabfa3952c8e6bfe6414dbf32e8b6c5f349dc898]

CVE-2025-38580: ext4: fix inode use after free in ext4_end_io_rsv_work()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38580

Introduced by commit ce51afb ("ext4: abort journal on data writeback
failure if in data_err=abort mode") in v6.15-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c678bdc998754589cea2e6afab9401d7d8312ac4]

CVE-2025-38581: crypto: ccp - Fix crash when rebind ccp device for ccp.ko

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38581

Introduced by commit 3cdbe34 ("crypto: ccp - Add debugfs entries for
CCP information") in v4.13-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [181698af38d3f93381229ad89c09b5bd0496661a]
stable/6.1: [2d4060f05e74dbee884ba723f6afd9282befc3c5]
stable/6.12: [9dea08eac4f6d6fbbae59992978252e2edab995d]
stable/6.6: [db111468531777cac8b4beb6515a88a54b0c4a74]

CVE-2025-38582: RDMA/hns: Fix double destruction of rsv_qp

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38582

Introduced by commit fd84892 ("RDMA/hns: Fix Use-After-Free of rsv_qp
on HIP08") in v6.12-rc1.
Fixed in v6.17-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [c6957b95ecc5b63c5a4bb4ecc28af326cf8f6dc8]
stable/6.12: [dab173bae3303f074f063750a8dead2550d8c782]

CVE-2025-38583: clk: xilinx: vcu: unregister pll_post only if
registered correctly

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38583

Introduced by commit 4472e18 ("soc: xilinx: vcu: make pll post divider
explicit") in v5.12-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b0abc443ac22f7d4f61ddbbbbc5dbb06c87139d]
stable/6.1: [88bd875b7f9c3652c27d6e4bb7a23701b764f762]
stable/6.12: [f1a1be99d5ae53d3b404415f1665eb59e8e02a8c]
stable/6.6: [51990eecf22f446550befdfd1a9f54147eafd636]

CVE-2025-38584: padata: Fix pd UAF once and for all

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38584

Introduced by commit 16295be ("padata: Generic
parallelization/serialization interface") in v2.6.34-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71203f68c7749609d7fc8ae6ad054bdedeb24f91]

CVE-2025-38585: staging: media: atomisp: Fix stack buffer overflow in
gmin_get_var_int()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38585

Introduced by commit 38d4f74 ("media: atomisp_gmin_platform: stop
abusing efivar API") in v6.0-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee4cf798202d285dcbe85e4467a094c44f5ed8e6]
stable/6.12: [3d672fe065aa00f4d66f42e3c9720f69a3ed43e7]

CVE-2025-38586: bpf, arm64: Fix fp initialization for exception boundary

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38586

Introduced by commit 5d4fa9e ("bpf, arm64: Avoid blindly
saving/restoring all callee-saved registers") in v6.12-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b114fcee766d5101eada1aca7bb5fd0a86c89b35]
stable/6.12: [0dbef493cae7d451f740558665893c000adb2321]

CVE-2025-38587: ipv6: fix possible infinite loop in fib6_info_uses_dev()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38587

Introduced by commit d9ccb18 ("ipv6: Fix soft lockups in
fib6_select_path under high next hop churn") in v6.13-rc1.
Fixed in v6.17-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [f8d8ce1b515a0a6af72b30502670a406cfb75073]
stable/6.1: [bc85e62394f008fa848c4ba02c936c735a3e8ef5]
stable/6.12: [db65739d406c72776fbdbbc334be827ef05880d2]
stable/6.6: [9cb6de8ee144a94ae7a40bdb32560329ab7276f0]

CVE-2025-38588: ipv6: prevent infinite loop in rt6_nlmsg_size()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38588

Introduced by commit d9ccb18 ("ipv6: Fix soft lockups in
fib6_select_path under high next hop churn") in v6.13-rc1.
Fixed in v6.17-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [54e6fe9dd3b0e7c481c2228782c9494d653546da]
stable/6.1: [6d345136c9b875f065d226908a29c25cdf9343f8]
stable/6.12: [cd8d8bbd9ced4cc5d06d858f67d4aa87745e8f38]
stable/6.6: [e1b7932af47f92432be8303d2439d1bf77b0be23]

CVE-2025-38589: neighbour: Fix null-ptr-deref in neigh_flush_dev().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38589

Introduced by commit f7f5273 ("neighbour: Create netdev->neighbour
association") in v6.13-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1bbb76a899486827394530916f01214d049931b3]

CVE-2025-38590: net/mlx5e: Remove skb secpath if xfrm state is not found

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38590

Introduced by commit b2ac754 ("net/mlx5e: IPsec: Add Connect-X IPsec
Rx data path offload") in v5.9-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d19c44b5c6dd72f9a357d0399604ec16a77de3c]
stable/6.12: [781a0bbf377443ef06f3248221f06cb555935530]
stable/6.6: [314f568b84b01f6eac1e4313ca47f9ade4349443]

CVE-2025-38591: bpf: Reject narrower access to pointer ctx fields

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38591

Introduced by commit f96da09 ("bpf: simplify narrower ctx access") in v4.13-rc1.
Introduced by commit 0df1a55 ("bpf: Warn on internal verifier errors")
in v6.17-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e09299225d5ba3916c91ef70565f7d2187e4cca0]

CVE-2025-38592: Bluetooth: hci_devcd_dump: fix out-of-bounds via dev_coredumpv

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38592

Introduced by commit b257e02 ("HCI: coredump: Log devcd dumps into the
monitor") in v6.15-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7af4d7b53502286c6cf946d397ab183e76d14820]

CVE-2025-38593: Bluetooth: hci_sync: fix double free in
'hci_discovery_filter_clear()'

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38593

Introduced by commit ad383c2 ("Bluetooth: hci_sync: Enable advertising
when LL privacy is enabled") in v5.17-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2935e556850e9c94d7a00adf14d3cd7fe406ac03]
stable/6.12: [16852eccbdfaf41a666705e3f8be55cf2864c5ca]

CVE-2025-38594: iommu/vt-d: Fix UAF on sva unbind with pending IOPFs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38594

Introduced by commit 17fce9d ("iommu/vt-d: Put iopf enablement in
domain attach path") in v6.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0b9d31c6edd50a6207489cd1bd4ddac814b9cd2]

CVE-2025-38595: xen: fix UAF in dmabuf_exp_from_pages()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38595

Introduced by commit a240d6e ("xen/gntdev: Implement dma-buf export
functionality") in v4.19-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [532c8b51b3a8676cbf533a291f8156774f30ea87]
stable/6.12: [e5907885260401bba300d4d18d79875c05b82651]

CVE-2025-38596: drm/panthor: Fix UAF in
panthor_gem_create_with_handle() debugfs code

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38596

Introduced by commit a3707f5 ("drm/panthor: show device-wide list of
DRM GEM objects over DebugFS") in v6.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe69a391808404977b1f002a6e7447de3de7a88e]

CVE-2025-38597: drm/rockchip: vop2: fail cleanly if missing a primary
plane for a video-port

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38597

Introduced by commit 604be85 ("drm/rockchip: Add VOP2 driver") in v5.19-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9f68bf1d0efeadb6c427c9dbb30f307a7def19b]

CVE-2025-38598: drm/amdgpu: fix use-after-free in
amdgpu_userq_suspend+0x51a/0x5a0

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38598

Introduced by commit adba092 ("drm/amdgpu: Fix Illegal opcode in
command stream Error") in v6.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a886d26f2c8f9e3f3c1869ae368d09c75daac553]

CVE-2025-38599: wifi: mt76: mt7996: Fix possible OOB access in mt7996_tx()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38599

Introduced by commit 3ce8acb ("wifi: mt76: mt7996: Update mt7996_tx to
MLO support") in v6.15-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64cbf0d7ce9afe20666da90ec6ecaec6ba5ac64b]

CVE-2025-38600: wifi: mt76: mt7925: fix off by one in mt7925_mcu_hw_scan()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38600

Introduced by commit 8284815 ("wifi: mt76: mt7925: add RNR scan
support for 6GHz") in v6.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3a431fe2e399b2e0cc5f43f7e9d63d63d3710ee]

CVE-2025-38601: wifi: ath11k: clear initialized flag for deinit-ed srng lists

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38601

Introduced by commit 5118935 ("ath11k: dump SRNG stats during FW
assert") in v5.7-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5b46aa7cf5f05c213316a018e49a8e086efd98e]
stable/6.1: [916ac18d526a26f6072866b1a97622cf1351ef1c]
stable/6.12: [72a48be1f53942793f3bc68a37fad1f38b53b082]
stable/6.6: [5bf201c55fdf303e79005038648dfa1e8af48f54]

CVE-2025-38602: iwlwifi: Add missing check for alloc_ordered_workqueue

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38602

Introduced by commit b481de9 ("[IWLWIFI]: add iwlwifi wireless
drivers") in v2.6.24-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90a0d9f339960448a3acc1437a46730f975efd6a]
stable/6.1: [6663c52608d8d8727bf1911e6d9218069ba1c85e]
stable/6.12: [7dd6350307af6521b6240b295c93b7eec4daebe6]
stable/6.6: [ca980f1911a7144d451d1c31298ab8507c6bd88f]

CVE-2025-38603: drm/amdgpu: fix slab-use-after-free in
amdgpu_userq_mgr_fini+0x70c

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38603

Introduced by commit adba092 ("drm/amdgpu: Fix Illegal opcode in
command stream Error") in v6.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5fb90421fa0fbe0a968274912101fe917bf1c47b]

CVE-2025-38604: wifi: rtl818x: Kill URBs before clearing tx status queue

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38604

Introduced by commit c1db52b ("rtl8187: Use usb anchor facilities to
manage urbs") in v2.6.29-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16d8fd74dbfca0ea58645cd2fca13be10cae3cdd]
stable/6.1: [8c767727f331fb9455b0f81daad832b5925688cb]
stable/6.12: [7858a95566f4ebf59524666683d2dcdba3fca968]
stable/6.6: [14ca6952691fa8cc91e7644512e6ff24a595283f]

CVE-2025-38605: wifi: ath12k: Pass ab pointer directly to
ath12k_dp_tx_get_encap_type()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38605

Introduced by commit e93bbd6 ("wifi: ath12k: fix packets are sent in
native wifi mode while we set raw mode") in v6.4-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05062834350f0bf7ad1abcebc2807220e90220eb]

CVE-2025-38606: wifi: ath12k: Avoid accessing uninitialized arvif->ar
during beacon miss

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38606

Introduced by commit aa80f12 ("wifi: ath12k: defer vdev creation for
MLO") in v6.14-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36670b67de18f1e5d34900c5d2ac60a8970c293c]

CVE-2025-38607: bpf: handle jset (if a & b ...) as a jump in CFG computation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38607

Introduced by commit 14c8552 ("bpf: simple DFA-based live registers
analysis") in v6.15-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3157f7e2999616ac91f4d559a8566214f74000a5]

CVE-2025-38608: bpf, ktls: Fix data corruption when using
bpf_msg_pop_data() in ktls

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38608

Introduced by commit d3b18ad ("tls: add bpf support to sk_msg
handling") in v4.20-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [178f6a5c8cb3b6be1602de0964cd440243f493c9]
stable/6.1: [16aca8bb4ad0d8a13c8b6da4007f4e52d53035bb]
stable/6.12: [ee03766d79de0f61ea29ffb6ab1c7b196ea1b02e]
stable/6.6: [0e853c1464bcf61207f8b5c32d2ac5ee495e859d]

CVE-2025-38609: PM / devfreq: Check governor before using governor->name

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38609

Introduced by commit 96ffcdf ("PM / devfreq: Remove redundant
governor_name from struct devfreq") in v5.11-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bab7834c03820eb11269bc48f07c3800192460d2]
stable/6.1: [631e101728df2a86b8fb761b49fad9712c651f8a]
stable/6.12: [d5632359dbc44862fc1ed04093c1f57529830261]
stable/6.6: [81f50619370045120c133bfdda5b320c8c97d41e]

CVE-2025-38610: powercap: dtpm_cpu: Fix NULL pointer dereference in
get_pd_power_uw()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38610

Introduced by commit eb82bac ("powercap/drivers/dtpm: Scale the power
with the load") in v5.16-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [46dc57406887dd02565cb264224194a6776d882b]
stable/6.1: [27914f2b795e2b58e9506f281dcdd98fef09d3c2]
stable/6.12: [8374ac7d69a57d737e701a851ffe980a0d27d3ad]
stable/6.6: [c6ec27091cf5ac05094c1fe3a6ce914cf711a37c]

CVE-2025-38611: vmci: Prevent the dispatching of uninitialized payloads

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38611

Introduced by commit 28d6692 ("VMCI: context implementation.") in v3.9-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfb4cf9fb97e4063f0aa62e9e398025fb6625031]
stable/6.1: [bfd6b211fe8aae79acbedd19e8d5bea5d062a41b]
stable/6.12: [87f8f8654e55cf9327cc63746595085a041699dc]
stable/6.6: [6696a46f4ebdc7314ff23a2fb0e93a95da2c45ee]

CVE-2025-38612: staging: fbtft: fix potential memory leak in
fbtft_framebuffer_alloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38612

Introduced by commit c296d5f ("staging: fbtft: core support") in v4.0-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb2cb7dab60f9be0b435ac4a674255429a36d72c]
stable/6.1: [6f9e2cf9e9c1a891a683329af35bb33ed9d38b5f]
stable/6.12: [a3177955f8da3c826a18b75e54881e2e9a9c96f1]
stable/6.6: [b31cf6f7716a5d3e4461763f32d812acdaec6e74]

CVE-2025-38613: staging: gpib: fix unset padding field copy back to userspace

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38613

Introduced by commit 9dde455 ("staging: gpib: Add GPIB common core
driver") in v6.13-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a739d3b13bff0dfa1aec679d08c7062131a2a425]

CVE-2025-38614: eventpoll: Fix semi-unbounded recursion

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38614

Introduced by commit 22bacca ("epoll: prevent creating circular epoll
structures") in v2.6.38-rc7.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2e467a48287c868818085aa35389a224d226732]
stable/6.12: [7a2125962c42d5336ca0495a9ce4cb38a63e9161]
stable/6.15: [ea5f97dbdcb1651581a22bd10afd2f0dd9dc11d6]

CVE-2025-38615: fs/ntfs3: cancle set bad inode after removing name fails

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38615

Introduced by commit 78ab59f ("fs/ntfs3: Rework file operations") in v5.15-rc1.
Fixed in v6.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d99208b91933fd2a58ed9ed321af07dacd06ddc3]
stable/6.12: [3ed2cc6a6e93fbeb8c0cafce1e7fb1f64a331dcc]
stable/6.6: [b35a50d639ca5259466ef5fea85529bb4fb17d5b]


* Updated CVEs

CVE-2024-36331: x86/sev: Evict cache lines during SNP memory validation

stable/6.1, stable/6.12, stable/6.15, stable/6.6 were fixed.

Fixed status
stable/6.1: [1fec416c03d0a64cc21aa04ce4aa14254b017e6a]
stable/6.12: [aed15fc08f15dbb15822b2a0b653f67e76aa0fdf]
stable/6.15: [a762a4c8d9e768b538b3cc60615361a8cf377de8]
stable/6.6: [1fb873971e23c35c53823c62809a474a92bc3022]

CVE-2025-37925: jfs: reject on-disk inodes of an unsupported type

stable/6.1 was fixed.

Fixed status
stable/6.1: [afc08b0b5587b553799bc375957706936a3e0088]

CVE-2025-38335: Input: gpio-keys - fix a sleep while atomic with PREEMPT_RT

stable/6.1 was fixed.

Fixed status
stable/6.1: [a8f01e51109f77229e426b57c5d19251b462c6aa]

CVE-2025-38500: xfrm: interface: fix use-after-free after changing
collect_md xfrm interface

stable/6.1 was fixed.

Fixed status
stable/6.1: [a8d4748b954584ab7bd800f1a4e46d5b0eeb5ce4]

CVE-2025-21988: fs/netfs/read_collect: add to next->prev_donated

stable/6.12 was fixed.

Fixed status
stable/6.12: [62b9ad7e52d4777f7e775ee1f0ad2452f6041024]

CVE-2025-21884: net: better track kernel sockets lifetime

stable/6.12 was fixed.

Fixed status
stable/6.12: [4ceb0bd4ffd009821b585ce6a8033b12b59fb5fb]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

