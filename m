Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B158EE57DE
	for <webhook@archiver.kernel.org>; Wed, 11 Sep 2024 23:20:37 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
 by mx.groups.io with SMTP id smtpd.web11.35159.1726096826936379862
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Sep 2024 16:20:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=cAwxQxdX;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.178, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e033e37bc9so165483b6e.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Sep 2024 16:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1726096826; x=1726701626; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DcjVGNCZS+B5HYuGTMGpEaz+1uzhR5Vn2mfjalBRGV4=;
        b=cAwxQxdXwB+ujl5KQ5fiqoG7njP4SiIxs/M95ET3TfIGU8clJd3+6xWLzEuwCSpELK
         d3hNmIGRQ+BXYzi3GUnfV8dpqV+tJAGJuitLJAhML5p8wQ7+ZGqjmVBD6g/ZOjVBPS9h
         IUMEMcH2vWaPhlXJydnsXjnd1l/5/1SdzRpXq11owReDVBQn/IBFnk0/EKweEN+2mTHv
         JK8YsTzCDAecKWxBg2mesFc9jxtLCvdc4CUaVzgHWL24VIHInAOJUiK6B9Ly/1UmNuaE
         rWmvOl4mK7EoYlR5xn5GZjAxxzpydxvWChMiRmyTJTge8b7XLGOloACcFX1yt5Nf2v26
         APZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726096826; x=1726701626;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DcjVGNCZS+B5HYuGTMGpEaz+1uzhR5Vn2mfjalBRGV4=;
        b=kxd/sCEi8L7jJgq5+yfc8C9jS/NGThknwCQUEHyuTofgRXuaDU7eFGvRXjvWVOHYvS
         /kKRLoMO4bChOPl5wfA868OIdDl9MMOEWzrzpEk6LqVL/MQWllNZ56sfwm9PtKUJ5cE3
         FTfXSBydLHQElAd4Ig7v0YN8WYD5oPh0jFEFEhoHNfqfWlZaOCg62CxGMmtPD/lYPH5B
         OIOCPSlv7GkCKEkIBGppXqG1pQM84ycNkepoh9Zxavj4IfKtp4Wi9cHgkul1fnTgs/Zo
         m/14Zag8FjhgMmWBPVHl8xcmWY/EfS7vjw7U96cGZ+yNB2za6mCF6pGaH7G3UGgshg1h
         +bmA==
X-Gm-Message-State: AOJu0YwYhn2KYyvUnK/Q3z08I5AeASAfKMznAN64TuJPGW746sIn5U4o
	p3hMwIgKcinc7/cx1NqgOyZ4+MKHVYkYLroRllpOqcxA97ad3YJcsh4NEiMByp3elkB4LmEfFwv
	yWf0Jwhax5s+LdKAkI1Fw8L01W83PGLt+LENxvN0b2QZrLqd7Rz0=
X-Google-Smtp-Source: AGHT+IF+Gt0ceI6CZGJ3aNpetJnz0mzKK1eLjNQ3QPpzmrynmCxHFfvRyUJpIFBFCc/9uQFftxB8WESOAtO/Id+Ukbw=
X-Received: by 2002:a05:6808:220b:b0:3e0:6a7f:4752 with SMTP id
 5614622812f47-3e071af7f1dmr486310b6e.41.1726096825058; Wed, 11 Sep 2024
 16:20:25 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 12 Sep 2024 08:19:49 +0900
Message-ID: <CAODzB9rTsq9Mdisjr_+mtkkYxqBSXoddNzqY5Jj_a3msZgx3=A@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Sep 2024 23:20:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16885

Hi!

It's this week's CVE report.

This week reported 23 new CVEs and 23 updated CVEs.

* New CVEs
CVE-2023-52915: media: dvb-usb-v2: af9035: Fix null-ptr-deref in
af9035_i2c_master_xfer

Announce: https://lore.kernel.org/linux-cve-announce/2024090653-CVE-2023-52915-21a9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.6-rc1.

Fixed status
mainline: [7bf744f2de0a848fb1d717f5831b03db96feae89]
stable/4.19: [fa58d9db5cad4bb7bb694b6837e3b96d87554f2b]
stable/5.10: [6c01ef65de0b321b2db1ef9abf8f1d15862b937e]
stable/5.15: [d9ef84a7c222497ecb5fdf93361c76931804825e]
stable/5.4: [b49c6e5dd236787f13a062ec528d724169f11152]
stable/6.1: [0143f282b15f7cedc0392ea10050fb6000fd16e6]

CVE-2023-52916: media: aspeed: Fix memory overwrite if timing is 1600x900

Announce: https://lore.kernel.org/linux-cve-announce/2024090655-CVE-2023-52916-edc0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.6-rc1.
CONFIG_VIDEO_ASPEED was added by commit d2b4387f ("media: platform: Add Aspee
Video Engine driver") in 5.0-rc1.

Fixed status
mainline: [c281355068bc258fd619c5aefd978595bede7bfe]

CVE-2024-45009: mptcp: pm: only decrement add_addr_accepted for MPJ req

Announce: https://lore.kernel.org/linux-cve-announce/2024091104-CVE-2024-45009-24ea@gregkh/

Introduced by commit d0876b2 ("mptcp: add the incoming RM_ADDR
support") in v5.10-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c1f721375989579e46741f59523e39ec9b2a9bd]
stable/6.1: [85b866e4c4e63a1d7afb58f1e24273caad03d0b7]
stable/6.6: [d20bf2c96d7ffd171299b32f562f70e5bf5dc608]

CVE-2024-45010: mptcp: pm: only mark 'subflow' endp as available

Announce: https://lore.kernel.org/linux-cve-announce/2024091107-CVE-2024-45010-33ee@gregkh/

Introduced by commit 06faa22 ("mptcp: remove multi addresses and
subflows in PM") in v5.13-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [322ea3778965da72862cca2a0c50253aacf65fe6]
stable/6.1: [7fdc870d08960961408a44c569f20f50940e7d4f]
stable/6.6: [43cf912b0b0fc7b4fd12cbc735d1f5afb8e1322d]

CVE-2024-45011: char: xillybus: Check USB endpoints when probing device

Announce: https://lore.kernel.org/linux-cve-announce/2024091107-CVE-2024-45011-e729@gregkh/

Introduced by commit a53d120 ("char: xillybus: Add driver for XillyUSB
(Xillybus variant for USB)"). in v5.14-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2374bf7558de915edc6ec8cb10ec3291dfab9594]
stable/5.15: [25ee8b2908200fc862c0434e5ad483817d50ceda]
stable/6.1: [4267131278f5cc98f8db31d035d64bdbbfe18658]
stable/6.6: [5cff754692ad45d5086b75fef8cc3a99c30a1005]

CVE-2024-45012: nouveau/firmware: use dma non-coherent allocator

Announce: https://lore.kernel.org/linux-cve-announce/2024091107-CVE-2024-45012-9234@gregkh/

Introduced by commit 2541626 ("drm/nouveau/acr: use common falcon HS
FW code for ACR FWs") in v6.2-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b340aeb26d50e9a9ec99599e2a39b035fac978e]
stable/6.6: [cc29c5546c6a373648363ac49781f1d74b530707]

CVE-2024-45013: nvme: move stopping keep-alive into nvme_uninit_ctrl()

Announce: https://lore.kernel.org/linux-cve-announce/2024091107-CVE-2024-45013-8efe@gregkh/

Introduced by commit 3af755a ("nvme: move nvme_stop_keep_alive() back
to original position") in v6.7-rc3.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a54a93d0e3599b05856971734e15418ac551a14c]

CVE-2024-45014: s390/boot: Avoid possible physmem_info segment corruption

Announce: https://lore.kernel.org/linux-cve-announce/2024091107-CVE-2024-45014-2925@gregkh/

Introduced by commit 693d41f ("s390/mm: Restore mapping of kernel
image using large pages") in v6.10-rc4.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7fd2941ae9a67423d1c7bee985f240e4686634f]

CVE-2024-45015: drm/msm/dpu: move dpu_encoder's connector assignment
to atomic_enable()

Announce: https://lore.kernel.org/linux-cve-announce/2024091107-CVE-2024-45015-c139@gregkh/

Introduced by commit 25fdd59 ("drm/msm: Add SDM845 DPU support") in v4.19-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aedf02e46eb549dac8db4821a6b9f0c6bf6e3990]
stable/6.6: [3fb61718bcbe309279205d1cc275a6435611dc77]

CVE-2024-45016: netem: fix return value if duplicate enqueue fails

Announce: https://lore.kernel.org/linux-cve-announce/2024091108-CVE-2024-45016-fd5a@gregkh/

Introduced by commit 5845f70 ("net: netem: fix skb length BUG_ON in
__skb_to_sgvec") in v5.0.
Fixed in v6.11-rc5.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19

Fixed status
mainline: [c07ff8592d57ed258afee5a5e04991a48dbaf382]
stable/5.10: [c414000da1c2ea1ba9a5e5bb1a4ba774e51e202d]
stable/5.15: [52d99a69f3d556c6426048c9d481b912205919d8]
stable/5.4: [759e3e8c4a6a6b4e52ebc4547123a457f0ce90d4]
stable/6.1: [0486d31dd8198e22b63a4730244b38fffce6d469]
stable/6.6: [577d6c0619467fe90f7e8e57e45cb5bd9d936014]

CVE-2024-45017: net/mlx5: Fix IPsec RoCE MPV trace call

Announce: https://lore.kernel.org/linux-cve-announce/2024091108-CVE-2024-45017-ee3e@gregkh/

Introduced by commit dfbd229 ("net/mlx5: Configure IPsec steering for
egress RoCEv2 MPV traffic") in v6.7-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [607e1df7bd47fe91cab85a97f57870a26d066137]

CVE-2024-45018: netfilter: flowtable: initialise extack before use

Announce: https://lore.kernel.org/linux-cve-announce/2024091108-CVE-2024-45018-7e30@gregkh/

Introduced by commit c29f74e ("netfilter: nf_flow_table: hardware
offload support") in v5.5-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9767137308daf906496613fd879808a07f006a2]
stable/5.10: [e5ceff2196dc633c995afb080f6f44a72cff6e1d]
stable/5.15: [356beb911b63a8cff34cb57f755c2a2d2ee9dec7]
stable/6.1: [7eafeec6be68ebd6140a830ce9ae68ad5b67ec78]
stable/6.6: [c7b760499f7791352b49b11667ed04b23d7f5b0f]

CVE-2024-45019: net/mlx5e: Take state lock during tx timeout reporter

Announce: https://lore.kernel.org/linux-cve-announce/2024091108-CVE-2024-45019-5f8b@gregkh/

Introduced by commit eab0da3 ("net/mlx5e: Fix possible deadlock on
mlx5e_tx_timeout_work") in v6.7-rc6.
Fixed in v6.11-rc4.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [e6b5afd30b99b43682a7764e1a74a42fe4d5f4b3]
stable/6.1: [03d3734bd692affe4d0e9c9d638f491aaf37411b]
stable/6.6: [b3b9a87adee97854bcd71057901d46943076267e]

CVE-2024-45020: bpf: Fix a kernel verifier crash in stacksafe()

Announce: https://lore.kernel.org/linux-cve-announce/2024091108-CVE-2024-45020-afcc@gregkh/

Introduced by commit 2793a8b ("bpf: exact states comparison for
iterator convergence checks") in v6.7-rc1.
Fixed in v6.11-rc4.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [bed2eb964c70b780fb55925892a74f26cb590b25]
stable/6.6: [7cad3174cc79519bf5f6c4441780264416822c08]

CVE-2024-45021: memcg_write_event_control(): fix a user-triggerable oops

Announce: https://lore.kernel.org/linux-cve-announce/2024091109-CVE-2024-45021-68c4@gregkh/

Introduced by commit 0dea116 ("cgroup: implement eventfd-based generic
API for notifications") in v2.6.34-rc2.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [046667c4d3196938e992fba0dfcde570aa85cd0e]
stable/4.19: [fa5bfdf6cb5846a00e712d630a43e3cf55ccb411]
stable/5.10: [ad149f5585345e383baa65f1539d816cd715fd3b]
stable/5.15: [0fbe2a72e853a1052abe9bc2b7df8ddb102da227]
stable/5.4: [1b37ec85ad95b612307627758c6018cd9d92cca8]
stable/6.1: [43768fa80fd192558737e24ed6548f74554611d7]
stable/6.6: [f1aa7c509aa766080db7ab3aec2e31b1df09e57c]

CVE-2024-45022: mm/vmalloc: fix page mapping if vm_area_alloc_pages()
with high order fallback to order 0

Announce: https://lore.kernel.org/linux-cve-announce/2024091109-CVE-2024-45022-08f3@gregkh/

Introduced by commit e9c3cda ("mm, vmalloc: fix high order
__GFP_NOFAIL allocations") in v6.3-rc4.
Fixed in v6.11-rc4.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [61ebe5a747da649057c37be1c37eb934b4af79ca]
stable/6.1: [fd1ffbb50ef4da5e1378a46616b6d7407dc795da]
stable/6.6: [de7bad86345c43cd040ed43e20d9fad78a3ee59f]

CVE-2024-45023: md/raid1: Fix data corruption for degraded array with slow disk

Announce: https://lore.kernel.org/linux-cve-announce/2024091109-CVE-2024-45023-d7f2@gregkh/

Introduced by commit 9f3ced7 ("md/raid1: factor out choose_bb_rdev()
from read_balance()") in v6.9-rc1.
Introduced by commit dfa8ecd ("md/raid1: factor out choose_slow_rdev()
from read_balance()") in v6.9-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c916ca35308d3187c9928664f9be249b22a3a701]

CVE-2024-45024: mm/hugetlb: fix hugetlb vs. core-mm PT locking

Announce: https://lore.kernel.org/linux-cve-announce/2024091109-CVE-2024-45024-2de4@gregkh/

Introduced by commit 9cb28da ("mm/gup: handle hugetlb in the generic
follow_page_mask code") in v6.10-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f75cfbd6bb02295ddaed48adf667b6c828ce07b]

CVE-2024-45025: fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE

Announce: https://lore.kernel.org/linux-cve-announce/2024091109-CVE-2024-45025-94f6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc4.
iIt seems as if 4.4 may be affected. It requires backporting
bitmap_copy_and_extend() as 4.19 does

Fixed status
mainline: [9a2fa1472083580b6c66bdaf291f591e1170123a]
stable/4.19: [ee501f827f3db02d4e599afbbc1a7f8b792d05d7]
stable/5.10: [fe5bf14881701119aeeda7cf685f3c226c7380df]
stable/5.15: [5053581fe5dfb09b58c65dd8462bf5dea71f41ff]
stable/5.4: [e807487a1d5fd5d941f26578ae826ca815dbfcd6]
stable/6.1: [8cad3b2b3ab81ca55f37405ffd1315bcc2948058]
stable/6.6: [dd72ae8b0fce9c0bbe9582b9b50820f0407f8d8a]

CVE-2024-45026: s390/dasd: fix error recovery leading to data
corruption on ESE devices

Announce: https://lore.kernel.org/linux-cve-announce/2024091110-CVE-2024-45026-eaa8@gregkh/

Introduced by commit 5e2b17e ("s390/dasd: Add dynamic formatting
support for ESE volumes") in v5.3-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7db4042336580dfd75cb5faa82c12cd51098c90b]
stable/5.10: [e245a18281c252c8dbc467492e09bb5d4b012118]
stable/5.15: [a665e3b7ac7d5cdc26e00e3d0fc8fd490e00316a]
stable/5.4: [19f60a55b2fda49bc4f6134a5f6356ef62ee69d8]
stable/6.1: [0a228896a1b3654cd461ff654f6a64e97a9c3246]
stable/6.6: [93a7e2856951680cd7fe6ebd705ac10c8a8a5efd]

CVE-2024-45027: usb: xhci: Check for xhci->interrupters being
allocated in xhci_mem_clearup()

Announce: https://lore.kernel.org/linux-cve-announce/2024091110-CVE-2024-45027-95b9@gregkh/

Introduced by commit c99b38c ("xhci: add support to allocate several
interrupters") in v6.8-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dcdb52d948f3a17ccd3fce757d9bd981d7c32039]

CVE-2024-45028: mmc: mmc_test: Fix NULL dereference on allocation failure

Announce: https://lore.kernel.org/linux-cve-announce/2024091110-CVE-2024-45028-34f7@gregkh/

Introduced by commit 2661081 ("mmc_test: highmem tests") in v2.6.27-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1e627af32ed60713941cbfc8075d44cad07f6dd]
stable/4.19: [e97be13a9f51284da450dd2a592e3fa87b49cdc9]
stable/5.10: [9b9ba386d7bfdbc38445932c90fa9444c0524bea]
stable/5.15: [e40515582141a9e7c84b269be699c05236a499a6]
stable/5.4: [2b507b03991f44dfb202fc2a82c9874d1b1f0c06]
stable/6.1: [3b4e76ceae5b5a46c968bd952f551ce173809f63]
stable/6.6: [cac2815f49d343b2f0acc4973d2c14918ac3ab0c]

CVE-2024-45029: i2c: tegra: Do not mark ACPI devices as irq safe

Announce: https://lore.kernel.org/linux-cve-announce/2024091110-CVE-2024-45029-662e@gregkh/

Introduced by commit bd2fded ("i2c: tegra: Add the ACPI support") in v5.17-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14d069d92951a3e150c0a81f2ca3b93e54da913b]
stable/6.1: [a89aef1e6cc43fa019a58080ed05c839e6c77876]
stable/6.6: [6861faf4232e4b78878f2de1ed3ee324ddae2287]

CVE-2024-45030: igb: cope with large MAX_SKB_FRAGS

Announce: https://lore.kernel.org/linux-cve-announce/2024091110-CVE-2024-45030-c2eb@gregkh/

Introduced by commit 3948b05 ("net: introduce a config option to tweak
MAX_SKB_FRAGS") in v6.4-rc1.
Fixed in v6.11-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8aba27c4a5020abdf60149239198297f88338a8d]
stable/6.6: [8ea80ff5d8298356d28077bc30913ed37df65109]

CVE-2024-46672: wifi: brcmfmac: cfg80211: Handle SSID based pmksa deletion

Announce: https://lore.kernel.org/linux-cve-announce/2024091111-CVE-2024-46672-7542@gregkh/

Introduced by commit a96202a ("wifi: brcmfmac: cfg80211: Add support
for PMKID_V3 operations") in v6.4-rc1.
Fixed in v6.11-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ad4e1ada8eebafa2d75a4b75eeeca882de6ada1]
stable/6.6: [4291f94f8c6b01505132c22ee27b59ed27c3584f]


* Updated CVEs

CVE-2024-42131: mm: avoid overflows in dirty throttling logic

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [311ee740029733c173a7fc7636929b884964ad02]
cip/4.4-st: [311ee740029733c173a7fc7636929b884964ad02]
stable/4.19: [2b2d2b8766db028bd827af34075f221ae9e9efff]
stable/5.10: [7a49389771ae7666f4dc3426e2a4594bf23ae290]
stable/5.15: [a25e8536184516b55ef89ab91dd2eea429de28d2]
stable/5.4: [4d3817b64eda07491bdd86a234629fe0764fb42a]
stable/6.1: [c83ed422c24f0d4b264f89291d4fabe285f80dbc]
stable/6.6: [bd16a7ee339aef3ee4c90cb23902afb6af379ea0]

CVE-2024-42265: protect the fetch of ->fd[fd] in do_dup2() from mispredictions

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [40f3e5b0f39c49db1e0b03afcae4692c5e9152e1]
cip/4.4-st: [40f3e5b0f39c49db1e0b03afcae4692c5e9152e1]
stable/4.19: [ed42e8ff509d2a61c6642d1825032072dab79f26]
stable/5.10: [08775b3d6ed117cf4518754ec7300ee42b6a5368]
stable/5.15: [3f480493550b6a23d3a65d095d6569d4a7f56a0f]
stable/5.4: [41a6c31df77bd8e050136b0a200b537da9e1084a]
stable/6.1: [5db999fff545b924b24c9afd368ef5c17279b176]
stable/6.10: [1171ceccabfd596ca370c5d2cbb47d110c3f2fe1]
stable/6.6: [da72e783afd27d9f487836b2e6738146c0edd149]

CVE-2024-42271: net/iucv: fix use after free in iucv_sock_close()

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [7096f812168f1243c77323d84d6e23e908ae3803]
cip/4.4-st: [7096f812168f1243c77323d84d6e23e908ae3803]
stable/4.19: [84f40b46787ecb67c7ad08a5bb1376141fa10c01]
stable/5.10: [c65f72eec60a34ace031426e04e9aff8e5f04895]
stable/5.15: [ac758e1f663fe9bc64f6b47212a2aa18697524f5]
stable/5.4: [37652fbef9809411cea55ea5fa1a170e299efcd0]
stable/6.1: [8b424c9e44111c5a76f41c6b741f8d4c4179d876]
stable/6.10: [69620522c48ce8215e5eb55ffbab8cafee8f407d]
stable/6.6: [01437282fd3904810603f3dc98d2cac6b8b6fc84]

CVE-2024-42280: mISDN: Fix a use after free in hfcmulti_tx()

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [9ee375d7e5ef48c57b78eba35188a57dcc166128]
cip/4.4-st: [9ee375d7e5ef48c57b78eba35188a57dcc166128]
stable/4.19: [70db2c84631f50e02e6b32b543700699dd395803]
stable/5.10: [9460ac3dd1ae033bc2b021a458fb535a0c36ddb2]
stable/5.15: [8f4030277dfb9dbe04fd78566b19931097c9d629]
stable/5.4: [d3e4d4a98c5629ccdcb762a0ff6c82ba9738a0c3]
stable/6.1: [4d8b642985ae24f4b3656438eb8489834a17bb80]
stable/6.10: [7e4a539bca7d8d20f2c5d93c18cce8ef77cd78e0]
stable/6.6: [ddc79556641ee070d36be0de4a1f0a16a71f1fc7]

CVE-2024-42284: tipc: Return non-zero value from tipc_udp_addr2str() on error

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [067c903b48150396dc47ffa310cc5d2c38cf2dc4]
cip/4.4-st: [067c903b48150396dc47ffa310cc5d2c38cf2dc4]
stable/4.19: [7ec3335dd89c8d169e9650e4bac64fde71fdf15b]
stable/5.10: [aa38bf74899de07cf70b50cd17f8ad45fb6654c8]
stable/5.15: [5eea127675450583680c8170358bcba43227bd69]
stable/5.4: [253405541be2f15ffebdeac2f4cf4b7e9144d12f]
stable/6.1: [728734352743a78b4c5a7285b282127696a4a813]
stable/6.10: [2abe350db1aa599eeebc6892237d0bce0f1de62a]
stable/6.6: [76ddf84a52f0d8ec3f5db6ccce08faf202a17d28]

CVE-2024-42295: nilfs2: handle inconsistent state in nilfs_btnode_create_block()

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [59de81bedb893c7b00f7c4e519da0d6c00308f71]
cip/4.4-st: [59de81bedb893c7b00f7c4e519da0d6c00308f71]
stable/4.19: [19cce46238ffe3546e44b9c74057103ff8b24c62]
stable/5.10: [5f0a6800b8aec1b453c7fe4c44fcaac5ffe9d52e]
stable/5.15: [e34191cce3ee63dfa5fb241904aaf2a042d5b6d8]
stable/5.4: [02b87e6334a38c65eef49848d3f1ac422f0b2a44]
stable/6.1: [012be828a118bf496e666ef1fc47fc0e7358ada2]
stable/6.10: [366c3f688dd0288cbe38af1d3a886b5c62372e4a]
stable/6.6: [be56dfc9be0604291267c07b0e27a69a6bda4899]

CVE-2024-42305: ext4: check dot and dotdot of dx_root before making dir indexed

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [288371badca6bc2b5d8f2d61476fe400418663a3]
cip/4.4-st: [288371badca6bc2b5d8f2d61476fe400418663a3]
stable/4.19: [b80575ffa98b5bb3a5d4d392bfe4c2e03e9557db]
stable/5.10: [42d420517072028fb0eb852c358056b7717ba5aa]
stable/5.15: [8afe06ed3be7a874b3cd82ef5f8959aca8d6429a]
stable/5.4: [19e13b4d7f0303186fcc891aba8d0de7c8fdbda8]
stable/6.1: [abb411ac991810c0bcbe51c2e76d2502bf611b5c]
stable/6.10: [cdd345321699042ece4a9d2e70754d2397d378c5]
stable/6.6: [9d241b7a39af192d1bb422714a458982c7cc67a2]

CVE-2024-42309: drm/gma500: fix null pointer dereference in
psb_intel_lvds_get_modes

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [d7612431834ee6ff544676f830774ccac47bfc97]
cip/4.4-st: [d7612431834ee6ff544676f830774ccac47bfc97]
stable/4.19: [13b5f3ee94bdbdc4b5f40582aab62977905aedee]
stable/5.10: [6735d02ead7dd3adf74eb8b70aebd09e0ce78ec9]
stable/5.15: [7e52c62ff029f95005915c0a11863b5fb5185c8c]
stable/5.4: [d6ad202f73f8edba0cbc0065aa57a79ffe8fdcdc]
stable/6.1: [f70ffeca546452d1acd3a70ada56ecb2f3e7f811]
stable/6.10: [475a5b3b7c8edf6e583a9eb59cf28ea770602e14]
stable/6.6: [46d2ef272957879cbe30a884574320e7f7d78692]

CVE-2024-42310: drm/gma500: fix null pointer dereference in
cdv_intel_lvds_get_modes

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [742f39fc8f70286ec17c4a23a2d0870dd0557dea]
cip/4.4-st: [742f39fc8f70286ec17c4a23a2d0870dd0557dea]
stable/4.19: [f392c36cebf4c1d6997a4cc2c0f205254acef42a]
stable/5.10: [b6ac46a00188cde50ffba233e6efb366354a1de5]
stable/5.15: [08f45102c81ad8bc9f85f7a25e9f64e128edb87d]
stable/5.4: [a658ae2173ab74667c009e2550455e6de5b33ddc]
stable/6.1: [e74eb5e8089427c8c49e0dd5067e5f39ce3a4d56]
stable/6.10: [977ee4fe895e1729cd36cc26916bbb10084713d6]
stable/6.6: [2d209b2f862f6b8bff549ede541590a8d119da23]

CVE-2024-42311: hfs: fix to initialize fields of hfs_inode_info after
hfs_alloc_inode()

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [7f9b1662b09a1b8c368842bd7a560124cf206fd2]
cip/4.4-st: [7f9b1662b09a1b8c368842bd7a560124cf206fd2]
stable/4.19: [f7316b2b2f11cf0c6de917beee8d3de728be24db]
stable/5.10: [10f7163bfb5f8b4e0c9c05a939f20b8540e33c65]
stable/5.15: [d55aae5c1730d6b70d5d8eaff00113cd34772ea3]
stable/5.4: [4a52861cd76e79f1a593beb23d096523eb9732c2]
stable/6.1: [58d83fc160505a7009c39dec64effaac5129b971]
stable/6.10: [d3493d6f0dfb1ab5225b62faa77732983f2187a1]
stable/6.6: [9c4e40b9b731220f9464975e49da75496e3865c4]

CVE-2024-43839: bna: adjust 'name' buf size of bna_tcb and bna_ccb structures

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [67ff40d801c47b54bd85188a2295d9dae3699851]
cip/4.4-st: [67ff40d801c47b54bd85188a2295d9dae3699851]
stable/4.19: [f121740f69eda4da2de9a20a6687a13593e72540]
stable/5.10: [6ce46045f9b90d952602e2c0b8886cfadf860bf1]
stable/5.15: [6d20c4044ab4d0e6a99aa35853e66f0aed5589e3]
stable/5.4: [c90b1cd7758fd4839909e838ae195d19f8065d76]
stable/6.1: [ab748dd10d8742561f2980fea08ffb4f0cacfdef]
stable/6.10: [e0f48f51d55fb187400e9787192eda09fa200ff5]
stable/6.6: [b0ff0cd0847b03c0a0abe20cfa900eabcfcb9e43]

CVE-2024-43858: jfs: Fix array-index-out-of-bounds in diFree

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [75c2d85f2f4c4f0b7449048c1750a40650aebc39]
cip/4.4-st: [75c2d85f2f4c4f0b7449048c1750a40650aebc39]
stable/4.19: [55b732c8b09b41148eaab2fa8e31b0af47671e00]
stable/5.10: [538a27c8048f081a5ddd286f886eb986fbbc7f80]
stable/5.15: [63f7fdf733add82f126ea00e2e48f6eba15ac4b9]
stable/5.4: [9b3a4345957f5372041bc4f59de322f62653e862]
stable/6.1: [8d8f9a477de0d7962342eedf2a599215b7c63d28]
stable/6.10: [6aa6892a90a5a7fabffe5692ab9f06a7a46c6e42]
stable/6.6: [ff14eadc278663cac69d57d3ca7fb2f394e1f8a7]

CVE-2024-43882: exec: Fix ToCToU between perm check and set-uid/gid usage

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [dc94c7ed18b093f47bf32ea94ea768345cdf4ee4]
cip/4.4-st: [dc94c7ed18b093f47bf32ea94ea768345cdf4ee4]
stable/4.19: [d5c3c7e26275a2d83b894d30f7582a42853a958f]
stable/5.10: [15469d46ba34559bfe7e3de6659115778c624759]
stable/5.15: [9b424c5d4130d56312e2a3be17efb0928fec4d64]
stable/5.4: [368f6985d46657b8b466a421dddcacd4051f7ada]
stable/6.1: [f6cfc6bcfd5e1cf76115b6450516ea4c99897ae1]
stable/6.10: [90dfbba89ad4f0d9c9744ecbb1adac4aa2ff4f3e]
stable/6.6: [d2a2a4714d80d09b0f8eb6438ab4224690b7121e]

CVE-2024-43883: usb: vhci-hcd: Do not drop references before new
references are gained

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [851f3d2f24d29037983055159644be5047315fdc]
cip/4.4-st: [851f3d2f24d29037983055159644be5047315fdc]
stable/4.19: [5a3c473b28ae1c1f7c4dc129e30cb19ae6e96f89]
stable/5.10: [4dacdb9720aaab10b6be121eae55820174d97174]
stable/5.15: [e8c1e606dab8c56cf074b43b98d0805de7322ba2]
stable/5.4: [9c3746ce8d8fcb3a2405644fc0eec7fc5312de80]
stable/6.1: [585e6bc7d0a9bf73a8be3d3fb34e86b90cc61a14]
stable/6.10: [c3d0857b7fc2c49f68f89128a5440176089a8f54]
stable/6.6: [128e82e41cf7d74a562726c1587d9d2ede1a0a37]

CVE-2024-43893: serial: core: check uartclk for zero to avoid divide by zero

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [5f00eb3fc53d99633b99afb1ace18ee3a65a91ff]
cip/4.4-st: [5f00eb3fc53d99633b99afb1ace18ee3a65a91ff]
stable/4.19: [3bbd90fca824e6fd61fb20f6dd2b0fa5f8b14bba]
stable/5.10: [52b138f1021113e593ee6ad258ce08fe90693a9e]
stable/5.15: [9196e42a3b8eeff1707e6ef769112b4b6096be49]
stable/5.4: [55b2a5d331a6ceb1c4372945fdb77181265ba24f]
stable/6.1: [e13ba3fe5ee070f8a9dab60029d52b1f61da5051]
stable/6.10: [68dc02f319b9ee54dc23caba742a5c754d1cccc8]
stable/6.6: [e3ad503876283ac3fcca922a1bf243ef9eb0b0e2]

CVE-2024-43914: md/raid5: avoid BUG_ON() while continue reshape after
reassembling

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [18d531fff4a7fa4eb0888b871f1810a9e172f5d5]
cip/4.4-st: [18d531fff4a7fa4eb0888b871f1810a9e172f5d5]
stable/4.19: [2c92f8c1c456d556f15cbf51667b385026b2e6a0]
stable/5.10: [c384dd4f1fb3b14a2fd199360701cc163ea88705]
stable/5.15: [bf0ff69a42a3d2d46876d0514ecf13dffc516666]
stable/5.4: [6b33c468d543f6a83de2d61f09fec74b27e19fd2]
stable/6.1: [3b33740c1750a39e046339ff9240e954f0156707]
stable/6.10: [4811d6e5d9f4090c3e0ff9890eb24077108046ab]
stable/6.6: [775a9ba16c9ffe98fe54ebf14e55d5660f2bf600]

CVE-2024-44944: netfilter: ctnetlink: use helper function to calculate expect ID

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [0b0ff680bfcb450ab4896f9c79c547e6d5832445]
cip/4.4-st: [0b0ff680bfcb450ab4896f9c79c547e6d5832445]
stable/4.19: [66e7650dbbb8e236e781c670b167edc81e771450]
stable/5.10: [eb4ca1a97e08ff5b920664ba292e576257e2d184]
stable/5.15: [5e2c24f7b0911b15c29aefce760bcf770542fb61]
stable/5.4: [64c0b8e64be8368617ef08dfc59a3160563a1435]
stable/6.1: [24f407042cf90b0872de667460230d8d50c06c39]
stable/6.10: [74de442b8e12a207c07953ee068009a7701aff8f]
stable/6.6: [27662b46f2adaa52c1665a82af4b21c42c4337fd]

CVE-2024-44948: x86/mtrr: Check if fixed MTRRs exist before saving them

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [37bc154f61c9e697fe619eeb4fc40d24951a7417]
cip/4.4-st: [37bc154f61c9e697fe619eeb4fc40d24951a7417]
stable/4.19: [34f36e6ee5bd7eff8b2adcd9fcaef369f752d82e]
stable/5.10: [450b6b22acdaac67a18eaf5ed498421ffcf10051]
stable/5.15: [ca7d00c5656d1791e28369919e3e10febe9c3b16]
stable/5.4: [06c1de44d378ec5439db17bf476507d68589bfe9]
stable/6.1: [8aa79dfb216b865e96ff890bc4ea71650f9bc8d7]
stable/6.10: [388f1c954019f253a8383f7eb733f38d541e10b6]
stable/6.6: [8a90d3fc7c24608548d3a750671f9dac21d1a462]

CVE-2024-44954: ALSA: line6: Fix racy access to midibuf

cip/4.4, cip/4.4-st were fixed.

Fixed status
cip/4.4: [1ac1b3829b4de84fed73b581b68d3d101c91b267]
cip/4.4-st: [1ac1b3829b4de84fed73b581b68d3d101c91b267]
stable/4.19: [643293b68fbb6c03f5e907736498da17d43f0d81]
stable/5.10: [e7e7d2b180d8f297cea6db43ea72402fd33e1a29]
stable/5.15: [a54da4b787dcac60b598da69c9c0072812b8282d]
stable/5.4: [40f3d5cb0e0cbf7fa697913a27d5d361373bdcf5]
stable/6.1: [c80f454a805443c274394b1db0d1ebf477abd94e]
stable/6.10: [51d87f11dd199bbc6a85982b088ff27bde53b48a]
stable/6.6: [535df7f896a568a8a1564114eaea49d002cb1747]

CVE-2024-41096: PCI/MSI: Fix UAF in msi_capability_init

stable/6.1 was fixed.

Fixed status
stable/6.1: [0ae40b2d0a5de6b045504098e365d4fdff5bbeba]
stable/6.6: [ff1121d2214b794dc1772081f27bdd90721a84bc]

CVE-2024-43835: virtio_net: Fix napi_skb_cache_put warning

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [6b5325f2457521bbece29499970c0117a648c620]
stable/6.10: [468a729b78895893d0e580ceea49bed8ada2a2bd]
stable/6.6: [f5e9a22d19bb98a7e86034db85eb295e94187caa]

CVE-2024-43859: f2fs: fix to truncate preallocated blocks in f2fs_file_open()

stable/6.1 was fixed.

Fixed status
stable/6.1: [5f04969136db674f133781626e0b692c5f2bf2f0]
stable/6.10: [3ba0ae885215b325605ff7ebf6de12ac2adf204d]
stable/6.6: [f44a25a8bfe0c15d33244539696cd9119cf44d18]

CVE-2024-44974: mptcp: pm: avoid possible UaF when selecting endp

stable/6.1 was fixed.

Fixed status
stable/6.1: [2b4f46f9503633dade75cb796dd1949d0e6581a1]
stable/6.10: [0201d65d9806d287a00e0ba96f0321835631f63f]
stable/6.6: [9a9afbbc3fbfca4975eea4aa5b18556db5a0c0b8]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

