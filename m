Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95477E7717D
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 22:28:06 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
 by mx.groups.io with SMTP id smtpd.web10.7179.1733956083193043546
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 14:28:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=dMcGyZ1I;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.174, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ef7c9e9592so70128287b3.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Dec 2024 14:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1733956082; x=1734560882; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4aWopOVVfSVeCWHVBREw1T7JlicKVEp1PJeb+/fdurU=;
        b=dMcGyZ1I76Yu6NjgE+OFnWwLGRDSt80J/MwYICMQOBYbgswQgBOuHhcmDykfMv/XhL
         EXuicxdBuxKvHbhPxk6LrPgKYVXtoqG8Jwl04kntkXQU7oJsBgkjcLInRxOLi3h/I3q8
         Euzxtzx61v7ARBnjjqpr6iJyIreXRFKDxzHb6Z9I29ExJD3wW1h50LIiZ96/L6X1VZoy
         gF1GRgk1SLNatzYBKuRiZO3mDByGvB2BQeYVyQaQBFXhdRJz76v4bDG7kqFLcJvp0b8F
         wumC2+iIo0LYFOsnRLY3GXXKTUzzc7vebnyuCZiUvY1UUhYz3x2ELNxAWjSMOKJEc0d4
         nOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733956082; x=1734560882;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4aWopOVVfSVeCWHVBREw1T7JlicKVEp1PJeb+/fdurU=;
        b=cIrZ+EI3r99423GZsTG3fvYVqn0uXxzFJsPA3ni1pSAwN1bqLi04KeWN1kzrGMIkP4
         7YBh3I9k56lfGVTScD1STpJlL2MSTwrNhjZV/y+VnG6n8ZLGkWSOG7zrBvRqseSn3p60
         LCHCr67tygwyxd5ofBe9X2uzt1xizTdl2k8F7SGVS0HzMRyX2JpgwiUIL+6aZBXCXllC
         D2wcbpnZcWQnvwzlgII8ZgLt9+XWQ4/ToFohMN32Q85RwobQ2liHbJPSkemnqvU1HOKf
         lUM5KWY8p2RXBQ1hmF8PAfZDyGuhOzQP65EyP6kj1dOOvPiryjEBn+PcWJ8IcCBCRWth
         mmkQ==
X-Gm-Message-State: AOJu0Yz9rzAGSwrggQ0iN6VnRmNuf+uKMkfj+HTVt49v9TRZjIt3/5gC
	SerkruAo2YlcW5L6//xOSHSJfFo5X+fp5/gN0br4S3PZHMY6kYldNzq+UayMfa8lXt9VuCN06W4
	6aPIRmpaSPM+Q9dAHVEa9TYfHK6kcBS6vFwxllrH5X4HGU/RECPo=
X-Gm-Gg: ASbGncsABt9xd3W03TjpbirJsUjeg/GoEeskB61CRqZjluiINEDnljzHz032uNUJP9j
	S6x7jV5ILx0nZjTj6eH2jrvdEE5XMS09vk+2w
X-Google-Smtp-Source: AGHT+IFThiCBRVGKpY3WBzzaSA1Q3Vqx8zwwuT4SS/z4jMuHPlkfedGyT9VpwgD+VgtuJwTmBSXVc5ikfUCElIAI7Ww=
X-Received: by 2002:a05:690c:6008:b0:6ef:641a:2a73 with SMTP id
 00721157ae682-6f198a377ccmr15030887b3.9.1733956081921; Wed, 11 Dec 2024
 14:28:01 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 12 Dec 2024 07:27:26 +0900
Message-ID: <CAODzB9pwOPURc88rXUBdqebV78npPtkfCZi4LVr0OTt43cwBmg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Dec 2024 22:28:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17409

Hi!

It's this week's CVE report.

This week reported 3 new CVEs and 35 updated CVEs.

* New CVEs
CVE-2024-53141: netfilter: ipset: add missing range check in bitmap_ip_uadt

Announce: https://lore.kernel.org/linux-cve-announce/2024120606-CVE-2024-53141-195b@gregkh/

Introduced by commit 72205fc ("netfilter: ipset: bitmap:ip set type
support") in v2.6.39-rc1.
Fixed in v6.13-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35f56c554eb1b56b77b3cf197a6b00922d49033d]
stable/4.19: [3c20b5948f119ae61ee35ad8584d666020c91581]
stable/6.6: [856023ef032d824309abd5c747241dffa33aae8c]

CVE-2024-53142: initramfs: avoid filename buffer overrun

Announce: https://lore.kernel.org/linux-cve-announce/2024120609-CVE-2024-53142-b75e@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.13-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e017671f534dd3f568db9e47b0583e853d2da9b5]
stable/4.19: [bb7ac96670ab1d8d681015f9d66e45dad579af4d]
stable/6.6: [1a423bbbeaf9e3e20c4686501efd9b661fe834db]

CVE-2024-53143: fsnotify: Fix ordering of iput() and watched_objects decrement

Announce: https://lore.kernel.org/linux-cve-announce/2024120746-CVE-2024-53143-05ed@gregkh/

Introduced by commit d2f277e ("fsnotify: rename
fsnotify_{get,put}_sb_connectors()") in v6.10-rc1.
Fixed in v6.13-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21d1b618b6b9da46c5116c640ac4b1cc8d40d63a]



* Updated CVEs
CVE-2024-53112: ocfs2: uncache inode which has failed entering the group

stable/4.19 was fixed.

Fixed status
stable/4.19: [ac0cfe8ac35cf1be54131b90d114087b558777ca]
stable/6.1: [620d22598110b0d0cb97a3fcca65fc473ea86e73]
stable/6.11: [b751c50e19d66cfb7360c0b55cf17b0722252d12]
stable/6.6: [843dfc804af4b338ead42331dd58081b428ecdf8]

CVE-2024-53127: Revert "mmc: dw_mmc: Fix IDMAC operation with pages
bigger than 4K"

stable/4.19 was fixed.

Fixed status
stable/4.19: [00bff71745bc3583bd5ca59be91e0ee1d27f1944]
stable/6.1: [8f9416147d7ed414109d3501f1cb3d7a1735b25a]
stable/6.11: [a4685366f07448420badb710ff5c12aaaadf63ad]
stable/6.6: [56de724c58c07a7ca3aac027cfd2ccb184ed9e4e]

CVE-2024-53130: nilfs2: fix null-ptr-deref in block_dirty_buffer tracepoint

stable/4.19 was fixed.

Fixed status
stable/4.19: [7af3309c7a2ef26831a67125b11c34a7e01c1b2a]
stable/6.1: [86b19031dbc79abc378dfae357f6ea33ebeb0c95]
stable/6.11: [ffc440a76a0f476a7e6ea838ec0dc8e9979944d1]
stable/6.6: [b0e4765740040c44039282057ecacd7435d1d2ba]

CVE-2024-53131: nilfs2: fix null-ptr-deref in block_touch_buffer tracepoint

stable/4.19 was fixed.

Fixed status
stable/4.19: [085556bf8c70e2629e02e79268dac3016a08b8bf]
stable/6.1: [3b2a4fd9bbee77afdd3ed5a05a0c02b6cde8d3b9]
stable/6.11: [77e47f89d32c2d72eb33d0becbce7abe14d061f4]
stable/6.6: [59b49ca67cca7b007a5afd3de0283c8008157665]

CVE-2024-53136: mm: revert "mm: shmem: fix data-race in shmem_getattr()"

stable/4.19 was fixed.

Fixed status
stable/4.19: [36b537e8f302f670c7cf35d88a3a294443e32d52]
stable/6.1: [5874c1150e77296565ad6e495ef41fbf87570d14]
stable/6.11: [901dc2ad7c3789fa87dc3956f6697c5d62d5cf7e]
stable/6.6: [64e67e8694252c1bf01b802ee911be3fee62c36b]

CVE-2024-53140: netlink: terminate outstanding dump on socket close

stable/4.19 was fixed.

Fixed status
stable/4.19: [114a61d8d94ae3a43b82446cf737fd757021b834]
stable/6.1: [4e87a52133284afbd40fb522dbf96e258af52a98]
stable/6.11: [176c41b3ca9281a9736b67c6121b03dbf0c8c08f]
stable/6.6: [bbc769d2fa1b8b368c5fbe013b5b096afa3c05ca]

CVE-2023-52920: bpf: support non-r10 register spill/fill to/from stack
in precision tracking

stable/6.6 was fixed.

Fixed status
stable/6.6: [ecc2aeeaa08a355d84d3ca9c3d2512399a194f29]

CVE-2024-26686: fs/proc: do_task_stat: use sig->stats_lock to gather
the threads/children stats

stable/6.6 was fixed.

Fixed status
stable/6.1: [cf4b8c39b9a0bd81c47afc7ef62914a62dd5ec4d]
stable/6.6: [3820b0fac7732a653bcc6f6ac20c1d72e697f8f6]
stable/6.7: [27978243f165b44e342f28f449b91327944ea071]

CVE-2024-40965: i2c: lpi2c: Avoid calling clk_get_rate during transfer

stable/6.6 was fixed.

Fixed status
stable/6.6: [d038693e08adf9c162c6377800495e4f5a2df045]
stable/6.9: [2b42e9587a7a9c7b824e0feb92958f258263963e]

CVE-2024-40975: platform/x86: x86-android-tablets: Unregister devices
in reverse order

stable/6.6 was fixed.

Fixed status
stable/6.6: [36ff963c133a25ed1166a25c3ba8b357ea010fda]
stable/6.9: [f0c982853d665597d17e4995ff479fbbf79a9cf6]

CVE-2024-41014: xfs: add bounds checking to xlog_recover_process_data

stable/6.6 was fixed.

Fixed status
stable/6.6: [7cd9f0a33e738cd58876f1bc8d6c1aa5bc4fc8c1]

CVE-2024-42122: drm/amd/display: Add NULL pointer check for kzalloc

stable/6.6 was fixed.

Fixed status
stable/6.6: [cd1e565a5b7fa60c349ca8a16db1e61715fe8230]

CVE-2024-42156: s390/pkey: Wipe copies of clear-key structures on failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [a891938947f4427f98cb1ce54f27223501efe750]

CVE-2024-42252: closures: Change BUG_ON() to WARN_ON()

stable/6.6 was fixed.

Fixed status
stable/6.6: [ecb4aaa658da760fb83afd79cc5fd4360aa60635]

CVE-2024-42319: mailbox: mtk-cmdq: Move
devm_mbox_controller_register() after devm_pm_runtime_enable()

stable/6.6 was fixed.

Fixed status
stable/6.10: [11fa625b45faf0649118b9deaf2d31c86ac41911]
stable/6.6: [d00df6700ad10974a7e20646956f4ff22cdbe0ec]

CVE-2024-43857: f2fs: fix null reference error when checking end of zone

stable/6.6 was fixed.

Fixed status
stable/6.10: [381cbe85592c78fbaeb3e770e3e9f3bfa3e67efb]
stable/6.6: [b98777309756ebe15cc9ad4e8ab64bbfaf878a3f]

CVE-2024-43913: nvme: apple: fix device reference counting

stable/6.6 was fixed.

Fixed status
stable/6.10: [d59c4d0eb6adc24c2201f153ccb7fd0a335b0d3d]
stable/6.6: [f7d9a18572fcd7130459b7691bd19ee2a2e951ad]

CVE-2024-44950: serial: sc16is7xx: fix invalid FIFO access with
special register set

stable/6.6 was fixed.

Fixed status
stable/6.10: [6a6730812220a9a5ce4003eb347da1ee5abd06b0]
stable/6.6: [dc5ead0e8fc5ef53b8553394d4aab60c277976b3]

CVE-2024-44955: drm/amd/display: Don't refer to dc_sink in
is_dsc_need_re_compute

stable/6.6 was fixed.

Fixed status
stable/6.10: [39b217193729aa45eded8de24d9245468a0c0263]
stable/6.6: [c7e65cab54a89f4df54110f0b44c4ade93d1a911]

CVE-2024-44963: btrfs: do not BUG_ON() when freeing tree block after error

stable/6.6 was fixed.

Fixed status
stable/6.10: [98251cd60b4d702a8a81de442ab621e83a3fb24f]
stable/6.6: [22d907bcd283d69d5e60497fc0d51969545c583b]

CVE-2024-46841: btrfs: don't BUG_ON on ENOMEM from
btrfs_lookup_extent_info() in walk_down_proc()

stable/6.6 was fixed.

Fixed status
stable/6.10: [704c359b4093a2af650a20eaa030c435d7c30f91]
stable/6.6: [135b4819f6fba87fd5a2693023133e78ac73f1d3]

CVE-2024-49891: scsi: lpfc: Validate hdwq pointers before
dereferencing in reset/errata paths

stable/6.6 was fixed.

Fixed status
stable/6.11: [fd665c8dbdb19548965b0ae80c490de00e906366]
stable/6.6: [232a138bd843d48cb2368f604646d990db7640f3]

CVE-2024-49897: drm/amd/display: Check phantom_stream before it is used

stable/6.6 was fixed.

Fixed status
stable/6.11: [3ba1219e299ab5462b5cb374c2fa2a67af0ea190]
stable/6.6: [d247af7c5dbf143ad6be8179bb1550e76d6af57e]

CVE-2024-49898: drm/amd/display: Check null-initialized variables

stable/6.6 was fixed.

Fixed status
stable/6.11: [115b1a3b0944b4d8ef0b4b0c5a625bdd9474131f]
stable/6.6: [c3a3b6d9a9383e3c1a4a08878ba5046e68647595]

CVE-2024-49899: drm/amd/display: Initialize denominators' default to 1

stable/6.6 was fixed.

Fixed status
stable/6.11: [7f8e93b862aba08d540f1e9e03e0ceb4d0cfd5fb]
stable/6.6: [9f35cec5e4b9759b38c663d18eae4eaf30f36527]

CVE-2024-49906: drm/amd/display: Check null pointer before try to access it

stable/6.6 was fixed.

Fixed status
stable/6.11: [2002ccb93004e76a471b180560accb2c1f850f35]
stable/6.6: [ebef6616219ff04abdeb39450625f85419787ee3]

CVE-2024-49909: drm/amd/display: Add NULL check for function pointer
in dcn32_set_output_transfer_func

stable/6.6 was fixed.

Fixed status
stable/6.11: [5298270bdabe97be5b8236e544c9e936415fe1f2]
stable/6.6: [f38b09ba6a335c511eb27920bb9bb4a1b2c20084]

CVE-2024-49911: drm/amd/display: Add NULL check for function pointer
in dcn20_set_output_transfer_func

stable/6.6 was fixed.

Fixed status
stable/6.11: [827380b114f83c30b3e56d1a675980b6d65f7c88]
stable/6.6: [8c854138b593efbbd8fa46a25f3288c121c1d1a1]

CVE-2024-49914: drm/amd/display: Add null check for
pipe_ctx->plane_state in dcn20_program_pipe

stable/6.6 was fixed.

Fixed status
stable/6.11: [65a6fee22d5cfa645cb05489892dc9cd3d142fc2]
stable/6.6: [68f75e6f08aad66069a629db8d7840919156c761]

CVE-2024-49915: drm/amd/display: Add NULL check for clk_mgr in dcn32_init_hw

stable/6.6 was fixed.

Fixed status
stable/6.11: [7d1854c86d02cea8f8a0c0ca05f4ab14292baf3d]
stable/6.6: [ec1be3c527b4a5fc85bcc1b0be7cec08bf60c796]

CVE-2024-49917: drm/amd/display: Add NULL check for clk_mgr and
clk_mgr->funcs in dcn30_init_hw

stable/6.6 was fixed.

Fixed status
stable/6.11: [56c326577971adc3a230f29dfd3aa3abdd505f5d]
stable/6.6: [205e3b96cc9aa9211fd2c849a16245cf236b2d36]

CVE-2024-49934: fs/inode: Prevent dump_mapping() accessing invalid
dentry.d_name.name

stable/6.6 was fixed.

Fixed status
stable/6.11: [ef921bc72328b577cb45772ff7921cba4773b74a]
stable/6.6: [e0f6ee75f50476607ca82fc7c3711c795ce09b52]

CVE-2024-53085: tpm: Lock TPM chip in tpm_pm_suspend() first

stable/6.6 was fixed.

Fixed status
stable/6.11: [bc203fe416abdd1c29da594565a7c3c4e979488e]
stable/6.6: [cfaf83501a0cbb104499c5b0892ee5ebde4e967f]

CVE-2024-53141: netfilter: ipset: add missing range check in bitmap_ip_uadt

stable/6.6 was fixed.

Fixed status
stable/4.19: [3c20b5948f119ae61ee35ad8584d666020c91581]
stable/6.12: [15794835378ed56fb9bacc6a5dd3b9f33520604e]
stable/6.6: [856023ef032d824309abd5c747241dffa33aae8c]

CVE-2024-53142: initramfs: avoid filename buffer overrun

stable/6.6 was fixed.

Fixed status
stable/4.19: [bb7ac96670ab1d8d681015f9d66e45dad579af4d]
stable/6.12: [fb83b093f75806333b6f4ae29b158d2e0e3ec971]
stable/6.6: [1a423bbbeaf9e3e20c4686501efd9b661fe834db]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

