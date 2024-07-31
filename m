Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6864EC3DA7F
	for <webhook@archiver.kernel.org>; Wed, 31 Jul 2024 22:23:32 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
 by mx.groups.io with SMTP id smtpd.web11.55260.1722464605843588751
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jul 2024 15:23:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=Aq8dJJX5;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.49, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d5e1c86b83so2857818eaf.3
        for <cip-dev@lists.cip-project.org>; Wed, 31 Jul 2024 15:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1722464604; x=1723069404; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RBZTSoBB7AqK4A+Y8shsB5q8hz30LB09o/zlZhGoBF8=;
        b=Aq8dJJX5XCa7n0gHFXL7T/aLFRQ98Ax/802lGZontrUCz5CyGWX+gP6X+AbayyMxFm
         3sxa/mQdHwZEwIQtn2fxsKWugcERYSMbkTgUmf7FhM9eZaXGkRMRqCRRpAeY9BBnBK4A
         /LOF5GYAuAoU+nxjPucrpq1AESO15bhnXXRbEH02jU/afchso6+NCRdchP425tVkLOHD
         Kf0UPUUXFw0N9/tGoVpMEFqHCS7+2wGGMF9v5Q91YIaxBBAUJUIoLCPjnQQd2smY0PbB
         MZXajrn5vssFRWD7V+7/TvwdVc0qPfvg5FlH0qTvvgstsGiryLaWB8sKjpDWqYX8OjHS
         torQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464604; x=1723069404;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBZTSoBB7AqK4A+Y8shsB5q8hz30LB09o/zlZhGoBF8=;
        b=vFKNgKvmXbDOCvut1wz7IIgsPHBCBFg5VsQsXTVdGACJvptNxtbAL9zzNuvPApq47W
         xyoaGu+Tuz3mcKKnDHAn0JIFBU9TE2B74Has8/FIHq1ytn3MbZSEGB7lxnOmoh1ReizT
         iA1D8+4pAzLFdlnXsFz6i32BG3k/KEUHWMONnOzAjif5PMPHKhKYvubjNuZWXtthQJ8t
         kOSLubGCaA2BT7TRycLGw3KM7kLTyQMxqbAyWv9eOnhsMY+NPfipdL12rLUTwxyDY1hO
         bUQnbxVj3T8S5OjWOxa2MEf4x+vzgK1dJ/ETzsIlJC9zrqskUY+nPA/Ixk9cwAI0g1nW
         3Chg==
X-Gm-Message-State: AOJu0Yx6983o+LSmr93+LO7Ixecd7lXDItWyFLl64gN5jJ4r1VkTIoFK
	ClI7/5QXY/5B79iGhzR4JiWz4hTwk2wCaz2hnT8IM2rDHssRJ7Bk+GcGO2vqV7TTlYSEFxKEZzg
	abwgm7scZ+rF29NkU8Y4cTF13IIwW/50WDwxJ+dILYtUKVizXYmg=
X-Google-Smtp-Source: AGHT+IH6sq/e69+6BZaCitLPJFI7U6mX692nltltEWJvSUmfmTLtxyHB0qPy/1oQPEuH5W/t+Sq3raGCixmYcVm42Cs=
X-Received: by 2002:a05:6870:45a4:b0:258:42bd:d916 with SMTP id
 586e51a60fabf-2687a50584cmr558944fac.14.1722464601972; Wed, 31 Jul 2024
 15:23:21 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 1 Aug 2024 07:22:45 +0900
Message-ID: <CAODzB9pMBYkD3R3zDqMTfQEX6Qj9Nz3=1TRbiEe+KefEmu=N4g@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jul 2024 22:23:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16700

Hi!

It's this week's CVE report.

This week reported 197 new CVEs and 41 updated CVEs.

* New CVEs

CVE-2024-41090: tap: add missing verification for short frame

Announce: no reference

None
It was introduced by commit 0efac27791ee ("tap: accept an array of XDP
buffs through sendmsg()") in 4.20-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed7f2afdd0e043a397677e597ced0830b83ba0b3]
stable/5.10: [7431144b406ae82807eb87d8c98e518475b0450f]
stable/5.15: [e5e5e63c506b93b89b01f522b6a7343585f784e6]
stable/5.4: [8be915fc5ff9a5e296f6538be12ea75a1a93bdea]
stable/6.1: [ee93e6da30377cf2a75e16cd32bb9fcd86a61c46]
stable/6.6: [aa6a5704cab861c9b2ae9f475076e1881e87f5aa]

CVE-2024-41091: tun: add missing verification for short frame

Announce: no reference

None
It was introduced by commit 043d222f93ab ("tuntap: accept an array
of XDP buffs through sendmsg()") in 4.20-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [049584807f1d797fc3078b68035450a9769eb5c3]
stable/5.10: [6100e0237204890269e3f934acfc50d35fd6f319]
stable/5.15: [589382f50b4a5d90d16d8bc9dcbc0e927a3e39b2]
stable/5.4: [32b0aaba5dbc85816898167d9b5d45a22eae82e9]
stable/6.1: [ad6b3f622ccfb4bfedfa53b6ebd91c3d1d04f146]
stable/6.6: [d5ad89b7d01ed4e66fd04734fc63d6e78536692a]

CVE-2024-41058: cachefiles: fix slab-use-after-free in fscache_withdraw_volume()

Announce: https://lore.kernel.org/linux-cve-announce/2024072905-CVE-2024-41058-4593@gregkh/

Introduced by commit fe2140e ("cachefiles: Implement volume support")
in v5.17-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [522018a0de6b6fcce60c04f86dfc5f0e4b6a1b36]
stable/6.1: [90f17e47f1e209c6a3c92a1d038a0a80c95c460e]
stable/6.6: [9dd7f5663899ea13a6a73216106d9c13c37453e3]

CVE-2024-41057: cachefiles: fix slab-use-after-free in
cachefiles_withdraw_cookie()

Announce: https://lore.kernel.org/linux-cve-announce/2024072902-CVE-2024-41057-1d06@gregkh/

Introduced by commit fe2140e ("cachefiles: Implement volume support")
in v5.17-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d8f805789072ea7fd39504694b7bd17e5f751c4]
stable/6.1: [8de253177112a47c9af157d23ae934779188b4e1]
stable/6.6: [9e67589a4a7b7e5660b524d1d5fe61242bcbcc11]

CVE-2024-41056: firmware: cs_dsp: Use strnlen() on name fields in V1 wmfw files

Announce: https://lore.kernel.org/linux-cve-announce/2024072930-CVE-2024-41056-c324@gregkh/

Introduced by commit f6bc909 ("firmware: cs_dsp: add driver to support
firmware loading on Cirrus Logic DSPs") in v5.16-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [680e126ec0400f6daecf0510c5bb97a55779ff03]
stable/6.1: [16d76857d6b5426f41b587d0bb925de3f25bfb21]
stable/6.6: [392cff2f86a25a4286ff3151c7739143c61c1781]

CVE-2024-41055: mm: prevent derefencing NULL ptr in pfn_section_valid()

Announce: https://lore.kernel.org/linux-cve-announce/2024072928-CVE-2024-41055-5764@gregkh/

Introduced by commit 5ec8e8e ("mm/sparsemem: fix race in accessing
memory_section->usage") in v6.8-rc1.
Fixed in v6.10.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [82f0b6f041fad768c28b4ad05a683065412c226e]
stable/5.10: [0100aeb8a12d51950418e685f879cc80cb8e5982]
stable/5.15: [bc17f2377818dca643a74499c3f5333500c90503]
stable/6.1: [941e816185661bf2b44b488565d09444ae316509]
stable/6.6: [797323d1cf92d09b7a017cfec576d9babf99cde7]

CVE-2024-41054: scsi: ufs: core: Fix ufshcd_clear_cmd racing issue

Announce: https://lore.kernel.org/linux-cve-announce/2024072928-CVE-2024-41054-d2e1@gregkh/

Introduced by commit 8d72903 ("scsi: ufs: mcq: Add supporting
functions for MCQ abort") in v6.5-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9307a998cb9846a2557fdca286997430bee36a2a]
stable/6.6: [bed0896008334eeee4b4bfd7150491ca098cbf72]

CVE-2024-41053: scsi: ufs: core: Fix ufshcd_abort_one racing issue

Announce: https://lore.kernel.org/linux-cve-announce/2024072928-CVE-2024-41053-e8e4@gregkh/

Introduced by commit 93e6c0e ("scsi: ufs: core: Clear cmd if abort
succeeds in MCQ mode") in v6.7-rc4.
Fixed in v6.10.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [74736103fb4123c71bf11fb7a6abe7c884c5269e]
stable/6.6: [c3111b3cf3889bfa7b73ebff83d7397db9b7e5e0]

CVE-2024-41051: cachefiles: wait for ondemand_object_worker to finish
when dropping object

Announce: https://lore.kernel.org/linux-cve-announce/2024072927-CVE-2024-41051-f511@gregkh/

Introduced by commit 0a7e54c ("cachefiles: resend an open request if
the read request's object is closed") in v6.8-rc1.
Fixed in v6.10.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [12e009d60852f7bce0afc373ca0b320f14150418]
stable/6.1: [ec9289369259d982e735a71437e32e6b4035290c]
stable/6.6: [d3179bae72b1b5e555ba839d6d9f40a350a4d78a]

CVE-2024-41050: cachefiles: cyclic allocation of msg_id to avoid reuse

Announce: https://lore.kernel.org/linux-cve-announce/2024072927-CVE-2024-41050-f3ff@gregkh/

Introduced by commit c838305 ("cachefiles: notify the user daemon when
looking up cookie") in v5.19-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19f4f399091478c95947f6bd7ad61622300c30d9]
stable/6.1: [35710c6c4a1c64478ec1b5e0e81d386c0844dec6]
stable/6.6: [de045a82e1a4e04be62718d3c2981a55150765a0]

CVE-2024-41049: filelock: fix potential use-after-free in posix_lock_inode

Announce: https://lore.kernel.org/linux-cve-announce/2024072927-CVE-2024-41049-bf28@gregkh/

Introduced by commit 74f6f59 ("locks: fix KASAN: use-after-free in
trace_event_raw_event_filelock_lock") in v6.6-rc1.
Fixed in v6.10.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [1b3ec4f7c03d4b07bad70697d7e2f4088d2cfe92]
stable/5.10: [7d4c14f4b511fd4c0dc788084ae59b4656ace58b]
stable/5.15: [02a8964260756c70b20393ad4006948510ac9967]
stable/5.4: [1cbbb3d9475c403ebedc327490c7c2b991398197]
stable/6.1: [5cb36e35bc10ea334810937990c2b9023dacb1b0]
stable/6.6: [432b06b69d1d354a171f7499141116536579eb6a]

CVE-2024-41048: skmsg: Skip zero length skb in sk_msg_recvmsg

Announce: https://lore.kernel.org/linux-cve-announce/2024072926-CVE-2024-41048-4150@gregkh/

Introduced by commit 604326b ("bpf, sockmap: convert to generic sk_msg
interface") in v4.20-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0c18025693707ec344a70b6887f7450bf4c826b]
stable/5.15: [195b7bcdfc5adc5b2468f279dd9eb7eebd2e7632]
stable/6.1: [fb61d7b9fb6ef0032de469499a54dab4c7260d0d]
stable/6.6: [b180739b45a38b4caa88fe16bb5273072e6613dc]

CVE-2024-41047: i40e: Fix XDP program unloading while removing the driver

Announce: https://lore.kernel.org/linux-cve-announce/2024072926-CVE-2024-41047-f253@gregkh/

Introduced by commit 6533e55 ("i40e: Fix reset path while removing the
driver") in v5.17-rc3.
Fixed in v6.10.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [01fc5142ae6b06b61ed51a624f2732d6525d8ea3]
stable/5.15: [b399a68054dfb36eed121846ef5fcddba40b7740]
stable/6.1: [4bc336b2345f1485438c0eb7246d9c8a8d09f8ff]
stable/6.6: [5266302cb2c74d8ab0e9a69d5752fffaea70496e]

CVE-2024-41046: net: ethernet: lantiq_etop: fix double free in detach

Announce: https://lore.kernel.org/linux-cve-announce/2024072926-CVE-2024-41046-aea4@gregkh/

Introduced by commit 504d472 ("MIPS: Lantiq: Add ethernet driver") in v3.0-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1533b6319ab9c3a97dad314dd88b3783bc41b69]
stable/4.19: [1a2db00a554cfda57c397cce79b2804bf9633fec]
stable/5.10: [22b16618a80858b3a9d607708444426948cc4ae1]
stable/5.15: [69ad5fa0ce7c548262e0770fc2b726fe7ab4f156]
stable/5.4: [907443174e76b854d28024bd079f0e53b94dc9a1]
stable/6.1: [c2b66e2b3939af63699e4a4bd25a8ac4a9b1d1b3]
stable/6.6: [9d23909ae041761cb2aa0c3cb1748598d8b6bc54]

CVE-2024-41045: bpf: Defer work in bpf_timer_cancel_and_free

Announce: https://lore.kernel.org/linux-cve-announce/2024072925-CVE-2024-41045-6cc1@gregkh/

Introduced by commit b00628b ("bpf: Introduce bpf timers.") in v5.15-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6fcd19d7eac1335eb76bc16b6a66b7f574d1d69]

CVE-2024-41044: ppp: reject claimed-as-LCP but actually malformed packets

Announce: https://lore.kernel.org/linux-cve-announce/2024072925-CVE-2024-41044-5b26@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2aeb7306a898e1cbd03963d376f4b6656ca2b55]
stable/4.19: [97d1efd8be26615ff680cdde86937d5943138f37]
stable/5.10: [3ba12c2afd933fc1bf800f6d3f6c7ec8f602ce56]
stable/5.15: [ebc5c630457783d17d0c438b0ad70b232a64a82f]
stable/5.4: [6e8f1c21174f9482033bbb59f13ce1a8cbe843c3]
stable/6.1: [3134bdf7356ed952dcecb480861d2afcc1e40492]
stable/6.6: [099502ca410922b56353ccef2749bc0de669da78]

CVE-2024-41043: netfilter: nfnetlink_queue: drop bogus WARN_ON

Announce: https://lore.kernel.org/linux-cve-announce/2024072925-CVE-2024-41043-7b96@gregkh/

Introduced by commit 3f80196 ("netfilter: move nf_reinject into
nfnetlink_queue modules") in v6.9-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [631a4b3ddc7831b20442c59c28b0476d0704c9af]

CVE-2024-41042: netfilter: nf_tables: prefer nft_chain_validate

Announce: https://lore.kernel.org/linux-cve-announce/2024072924-CVE-2024-41042-c338@gregkh/

Introduced by commit 20a6934 ("netfilter: nf_tables: add netlink set
API") in v3.13-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cff3bd012a9512ac5ed858d38e6ed65f6391008c]

CVE-2024-41041: udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().

Announce: https://lore.kernel.org/linux-cve-announce/2024072924-CVE-2024-41041-ae0c@gregkh/

Introduced by commit 6acc9b4 ("bpf: Add helper to retrieve socket in
BPF") in v4.20-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c0b485a8c6116516f33925b9ce5b6104a6eadfd]
stable/5.10: [9f965684c57c3117cfd2f754dd3270383c529fba]
stable/5.15: [ddf516e50bf8a7bc9b3bd8a9831f9c7a8131a32a]
stable/5.4: [7a67c4e47626e6daccda62888f8b096abb5d3940]
stable/6.1: [a6db0d3ea6536e7120871e5448b3032570152ec6]
stable/6.6: [c5fd77ca13d657c6e99bf04f0917445e6a80231e]

CVE-2024-41040: net/sched: Fix UAF when resolving a clash

Announce: https://lore.kernel.org/linux-cve-announce/2024072924-CVE-2024-41040-63d5@gregkh/

Introduced by commit 0cc254e ("net/sched: act_ct: Offload connections
with commit action") in v5.13-rc5.
Fixed in v6.10.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [26488172b0292bed837b95a006a3f3431d1898c3]
stable/5.10: [b81a523d54ea689414f67c9fb81a5b917a41ed55]
stable/5.15: [2b4d68df3f57ea746c430941ba9c03d7d8b5a23f]
stable/6.1: [4e71b10a100861fb27d9c5755dfd68f615629fae]
stable/6.6: [799a34901b634008db4a7ece3900e2b971d4c932]

CVE-2024-41039: firmware: cs_dsp: Fix overflow checking of wmfw header

Announce: https://lore.kernel.org/linux-cve-announce/2024072924-CVE-2024-41039-b3bc@gregkh/

Introduced by commit f6bc909 ("firmware: cs_dsp: add driver to support
firmware loading on Cirrus Logic DSPs") in v5.16-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3019b86bce16fbb5bc1964f3544d0ce7d0137278]
stable/6.1: [fd035f0810b33c2a8792effdb82bf35920221565]
stable/6.6: [9c9877a96e033bf6c6470b3b4f06106d91ace11e]

CVE-2024-41038: firmware: cs_dsp: Prevent buffer overrun when
processing V2 alg headers

Announce: https://lore.kernel.org/linux-cve-announce/2024072923-CVE-2024-41038-41ba@gregkh/

Introduced by commit f6bc909 ("firmware: cs_dsp: add driver to support
firmware loading on Cirrus Logic DSPs") in v5.16-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2163aff6bebbb752edf73f79700f5e2095f3559e]
stable/6.1: [6619aa48a011364e9f29083cc76368e6acfe5b11]
stable/6.6: [76ea8e13aaefdfda6e5601323d6ea5340359dcfa]

CVE-2024-41037: ASoC: SOF: Intel: hda: fix null deref on system suspend entry

Announce: https://lore.kernel.org/linux-cve-announce/2024072923-CVE-2024-41037-84b8@gregkh/

Introduced by commit 2b009fa ("ASoC: SOF: Intel: hda: Unify DAI drv
ops for IPC3 and IPC4") in v6.4-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9065693dcc13f287b9e4991f43aee70cf5538fdd]
stable/6.6: [8246bbf818ed7b8d5afc92b951e6d562b45c2450]

CVE-2024-41036: net: ks8851: Fix deadlock with the SPI chip variant

Announce: https://lore.kernel.org/linux-cve-announce/2024072923-CVE-2024-41036-65a8@gregkh/

Introduced by commit 3dc5d44 ("net: ks8851: Fix TX stall caused by TX
buffer overrun") in v6.7-rc7.
Fixed in v6.10.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [0913ec336a6c0c4a2b296bd9f74f8e41c4c83c8c]
stable/6.1: [a0c69c492f4a8fad52f0a97565241c926160c9a4]
stable/6.6: [80ece00137300d74642f2038c8fe5440deaf9f05]

CVE-2024-41035: USB: core: Fix duplicate endpoint bug by clearing
reserved bits in the descriptor

Announce: https://lore.kernel.org/linux-cve-announce/2024072922-CVE-2024-41035-5e6b@gregkh/

Introduced by commit 0a8fd13 ("USB: fix problems with duplicate
endpoint addresses") in v4.10-rc3.
Fixed in v6.10.
Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [a368ecde8a5055b627749b09c6218ef793043e47]
stable/4.19: [d8418fd083d1b90a6c007cf8dcf81aeae274727b]
stable/5.10: [d09dd21bb5215d583ca9a1cb1464dbc77a7e88cf]
stable/5.15: [2bd8534a1b83c65702aec3cab164170f8e584188]
stable/5.4: [60abea505b726b38232a0ef410d2bd1994a77f78]
stable/6.1: [9edcf317620d7c6a8354911b69b874cf89716646]
stable/6.6: [647d61aef106dbed9c70447bcddbd4968e67ca64]

CVE-2024-41034: nilfs2: fix kernel bug on rename operation of broken directory

Announce: https://lore.kernel.org/linux-cve-announce/2024072922-CVE-2024-41034-7593@gregkh/

Introduced by commit 2ba466d ("nilfs2: directory entry operations") in
v2.6.30-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9e1ddc09ca55746079cc479aa3eb6411f0d99d4]
stable/4.19: [ff9767ba2cb949701e45e6e4287f8af82986b703]
stable/5.10: [a9a466a69b85059b341239766a10efdd3ee68a4b]
stable/5.15: [7000b438dda9d0f41a956fc9bffed92d2eb6be0d]
stable/5.4: [24c1c8566a9b6be51f5347be2ea76e25fc82b11e]
stable/6.1: [1a8879c0771a68d70ee2e5e66eea34207e8c6231]
stable/6.6: [60f61514374e4a0c3b65b08c6024dd7e26150bfd]

CVE-2024-41033: cachestat: do not flush stats in recency check

Announce: https://lore.kernel.org/linux-cve-announce/2024072922-CVE-2024-41033-d23e@gregkh/

Introduced by commit b006847 ("mm: workingset: move the stats flush
into workingset_test_recent()") in v6.8-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a4d8944d6b1e1aaaa83ea42c116b520b4ed0394]

CVE-2024-41032: mm: vmalloc: check if a hash-index is in cpu_possible_mask

Announce: https://lore.kernel.org/linux-cve-announce/2024072922-CVE-2024-41032-6284@gregkh/

Introduced by commit 062eacf ("mm: vmalloc: remove a global
vmap_blocks xarray") in v6.4-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a34acf30b19bc4ee3ba2f1082756ea2604c19138]
stable/6.6: [28acd531c9a365dac01b32e6bc54aed8c1429bcb]

CVE-2024-41031: mm/filemap: skip to create PMD-sized page cache if needed

Announce: https://lore.kernel.org/linux-cve-announce/2024072921-CVE-2024-41031-6286@gregkh/

Introduced by commit 4687fdb ("mm/filemap: Support VM_HUGEPAGE for
file mappings") in v5.18-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3390916aca7af1893ed2ebcdfee1d6fdb65bb058]
stable/6.6: [06b5a69c27ec405a3c3f2da8520ff1ee70b94a21]

CVE-2024-41029: nvmem: core: limit cell sysfs permissions to main attribute ones

Announce: https://lore.kernel.org/linux-cve-announce/2024072921-CVE-2024-41029-18c6@gregkh/

Introduced by commit 0331c61 ("nvmem: core: Expose cells through
sysfs") in v6.8-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6bef98bafd82903a8d461463f9594f19f1fd6a85]

CVE-2024-41028: platform/x86: toshiba_acpi: Fix array out-of-bounds access

Announce: https://lore.kernel.org/linux-cve-announce/2024072920-CVE-2024-41028-d1bd@gregkh/

Introduced by commit 3cb1f40 ("drivers/platform: toshiba_acpi: Call
HCI_PANEL_POWER_ON on resume on some models") in v6.1-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6e02c6b0377d4339986e07aeb696c632cd392aa]
stable/6.1: [e030aa6c972641cb069086a8c7a0f747653e472a]
stable/6.6: [639868f1cb87b683cf830353bbee0c4078202313]

CVE-2024-41027: Fix userfaultfd_api to return EINVAL as expected

Announce: https://lore.kernel.org/linux-cve-announce/2024072920-CVE-2024-41027-24c4@gregkh/

Introduced by commit e06f1e1 ("userfaultfd: wp: enabled write
protection in userfaultfd API") in v5.7-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1723f04caacb32cadc4e063725d836a0c4450694]
stable/5.15: [519547760f16eae7803d2658d9524bc5ba7a20a7]
stable/6.1: [14875fd5f9bcf60ac5518c63bfb676ade44aa7c6]
stable/6.6: [cd94cac4069a763ab5206be2c64c9a8beae590ba]

CVE-2024-41026: mmc: davinci_mmc: Prevent transmitted data size from
exceeding sgm's length

Announce: https://lore.kernel.org/linux-cve-announce/2024072920-CVE-2024-41026-8de7@gregkh/

Introduced by commit ed01d21 ("mmc: davinci_mmc: Use sg_miter for
PIO") in v6.9-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16198eef11c1929374381d7f6271b4bf6aa44615]

CVE-2024-41025: misc: fastrpc: Fix memory leak in audio daemon attach operation

Announce: https://lore.kernel.org/linux-cve-announce/2024072919-CVE-2024-41025-0e03@gregkh/

Introduced by commit 0871561 ("misc: fastrpc: Add support for
audiopd") in v6.2-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad0bd973a033003ca578c42a760d1dc77aeea15e]
stable/6.6: [8b8b82dcf393ceaca8c88939338fd4c30b5b11b2]

CVE-2024-41024: misc: fastrpc: Restrict untrusted app to attach to privileged PD

Announce: https://lore.kernel.org/linux-cve-announce/2024072919-CVE-2024-41024-be39@gregkh/

Introduced by commit 0871561 ("misc: fastrpc: Add support for
audiopd") in v6.2-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bab2f5e8fd5d2f759db26b78d9db57412888f187]
stable/6.6: [5e305b5986dc52122a9368a1461f0c13e1de3fd6]

CVE-2024-41023: sched/deadline: Fix task_struct reference leak

Announce: https://lore.kernel.org/linux-cve-announce/2024072917-CVE-2024-41023-32a0@gregkh/

Introduced by commit feff2e6 ("sched/deadline: Unthrottle PI boosted
threads while enqueuing") in v5.10-rc1.
Fixed in v6.10.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19 stable/5.4

Fixed status
mainline: [b58652db66c910c2245f5bee7deca41c12d707b9]

CVE-2024-41022: drm/amdgpu: Fix signedness bug in sdma_v4_0_process_trap_irq()

Announce: https://lore.kernel.org/linux-cve-announce/2024072929-CVE-2024-41022-5696@gregkh/

Introduced by commit 8b2faf1 ("drm/amdgpu: add error handle to avoid
out-of-bounds") in v6.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/5.4
stable/6.1 stable/6.6

Fixed status
mainline: [6769a23697f17f9bf9365ca8ed62fe37e361a05a]
stable/5.10: [a5224e2123ce21102f346f518db80f004d5053a7]
stable/5.15: [544fa213f15d27f0370795845d55eeb3e00080d2]
stable/5.4: [3dd9734878a9042f0358301d19a2b006a0fc4d06]
stable/6.1: [e8dfbf83a82bbfb9680921719fbe65e535af59ea]
stable/6.6: [4edb0a84e6b32e75dc9bd6dd085b2c2ff19ec287]

CVE-2024-41021: s390/mm: Fix VM_FAULT_HWPOISON handling in do_exception()

Announce: https://lore.kernel.org/linux-cve-announce/2024072929-CVE-2024-41021-f857@gregkh/

Introduced by commit af19487 ("mm: make PTE_MARKER_SWAPIN_ERROR more
general") in v6.6-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [df39038cd89525d465c2c8827eb64116873f141a]

CVE-2024-41020: filelock: Fix fcntl/close race recovery compat path

Announce: https://lore.kernel.org/linux-cve-announce/2024072927-CVE-2024-41020-52c6@gregkh/

Introduced by commit c293621 ("[PATCH] stale POSIX lock handling") in v2.6.13.4.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8138f2ad2f745b9a1c696a05b749eabe44337ea]
stable/4.19: [a561145f3ae973ebf3e0aee41624e92a6c5cb38d]
stable/5.10: [911cc83e56a2de5a40758766c6a70d6998248860]
stable/5.15: [53e21cfa68a7d12de378b7116c75571f73e0dfa2]
stable/5.4: [4c43ad4ab41602201d34c66ac62130fe339d686f]
stable/6.1: [f4d0775c6e2f1340ca0725f0337de149aaa989ca]
stable/6.6: [73ae349534ebc377328e7d21891e589626c6e82c]

CVE-2024-41018: fs/ntfs3: Add a check for attr_names and oatbl

Announce: https://lore.kernel.org/linux-cve-announce/2024072911-CVE-2024-41018-3001@gregkh/

Introduced by commit 865e7a7 ("fs/ntfs3: Reduce stack usage") in v6.8-rc4.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [702d4930eb06dcfda85a2fa67e8a1a27bfa2a845]
stable/6.6: [f3124d51e4e7b56a732419d8dc270e807252334f]

CVE-2023-52887: net: can: j1939: enhanced error handling for tightly
received RTS messages in xtp_rx_rts_session_new

Announce: https://lore.kernel.org/linux-cve-announce/2024072950-CVE-2023-52887-b839@gregkh/

Introduced by commit 9d71dd0 ("can: add support of SAE J1939
protocol") in v5.4-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3e2904f71ea0fe7eaff1d68a2b0363c888ea0fb]
stable/5.10: [f6c839e717901dbd6b1c1ca807b6210222eb70f6]
stable/5.15: [1762ca80c2b72dd1b5821c5e347713ae696276ea]
stable/5.4: [ed581989d7ea9df6f8646beba2341e32cd49a1f9]
stable/6.1: [26b18dd30e63d4fd777be429148e8e4ed66f60b2]
stable/6.6: [177e33b655d35d72866b50aec84307119dc5f3d4]

CVE-2024-41083: netfs: Fix netfs_page_mkwrite() to check folio->mapping is valid

Announce: https://lore.kernel.org/linux-cve-announce/2024072946-CVE-2024-41083-a1d3@gregkh/

Introduced by commit 102a7e2 ("netfs: Allow buffered shared-writeable
mmap through netfs_page_mkwrite()") in v6.8-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a81c98bfa40c11f8ea79b5a9b3f5fda73bfbb4d2]

CVE-2024-41084: cxl/region: Avoid null pointer dereference in region lookup

Announce: https://lore.kernel.org/linux-cve-announce/2024072951-CVE-2024-41084-c144@gregkh/

Introduced by commit 0a105ab ("cxl/memdev: Warn of poison inject or
clear to a mapped region") in v6.4-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [285f2a08841432fc3e498b1cd00cce5216cdf189]
stable/6.6: [a9e099e29e925f8b31cfe53e8a786b9796f8e453]

CVE-2024-41085: cxl/mem: Fix no cxl_nvd during pmem region auto-assembling

Announce: https://lore.kernel.org/linux-cve-announce/2024072951-CVE-2024-41085-9bbd@gregkh/

Introduced by commit f17b558 ("cxl/pmem: Refactor nvdimm device
registration, delete the workqueue") in v6.2-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84ec985944ef34a34a1605b93ce401aa8737af96]

CVE-2024-41086: bcachefs: Fix sb_field_downgrade validation

Announce: https://lore.kernel.org/linux-cve-announce/2024072951-CVE-2024-41086-0dba@gregkh/

Introduced by commit 84f1638 ("bcachefs: bch_sb_field_downgrade") in v6.7.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [692aa7a54b2b28d59f24b3bf8250837805484b99]

CVE-2024-41087: ata: libata-core: Fix double free on error

Announce: https://lore.kernel.org/linux-cve-announce/2024072952-CVE-2024-41087-7924@gregkh/

Introduced by commit dafd6c4 ("libata: ensure host is free'd on error
exit paths") in v4.17-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab9e0c529eb7cafebdd31fe1644524e80a48b05d]
stable/4.19: [290073b2b557e4dc21ee74a1e403d9ae79e393a2]
stable/5.10: [010de9acbea58fbcbda08e3793d6262086a493fe]
stable/5.15: [5dde5f8b790274723640d29a07c5a97d57d62047]
stable/5.4: [56f1c7e290cd6c69c948fcd2e2a49e6a637ec38f]
stable/6.1: [702c1edbafb2e6f9d20f6d391273b5be09d366a5]
stable/6.6: [062e256516d7db5e7dcdef117f52025cd5c456e3]

CVE-2024-41088: can: mcp251xfd: fix infinite loop when xmit fails

Announce: https://lore.kernel.org/linux-cve-announce/2024072952-CVE-2024-41088-281e@gregkh/

Introduced by commit 55e5b97 ("can: mcp25xxfd: add driver for
Microchip MCP25xxFD SPI CAN") in v5.10-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d8fb63e46c884c898a38f061c2330f7729e75510]
stable/6.1: [f926c022ebaabf7963bebf89a97201d66978a025]
stable/6.6: [3e72558c1711d524e3150103739ddd06650e291b]

CVE-2024-41092: drm/i915/gt: Fix potential UAF by revoke of fence registers

Announce: https://lore.kernel.org/linux-cve-announce/2024072953-CVE-2024-41092-8bd7@gregkh/

Introduced by commit 0d86ee3 ("drm/i915/gt: Make fence revocation
unequivocal") in v5.8-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [996c3412a06578e9d779a16b9e79ace18125ab50]
stable/5.10: [f771b91f21c46ad1217328d05e72a2c7e3add535]
stable/5.15: [29c0fdf49078ab161570d3d1c6e13d66f182717d]
stable/6.1: [ca0fabd365a27a94a36e68a7a02df8ff3c13dac6]
stable/6.6: [06dec31a0a5112a91f49085e8a8fa1a82296d5c7]

CVE-2024-41094: drm/fbdev-dma: Only set smem_start is enable per module option

Announce: https://lore.kernel.org/linux-cve-announce/2024072953-CVE-2024-41094-374d@gregkh/

Introduced by commit a51c766 ("drm/fb-helper: Consolidate
CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM") in v6.4-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d92a7580392ad4681b1d4f9275d00b95375ebe01]
stable/6.6: [f29fcfbf6067c0d8c83f84a045da9276c08deac5]

CVE-2024-41096: PCI/MSI: Fix UAF in msi_capability_init

Announce: https://lore.kernel.org/linux-cve-announce/2024072954-CVE-2024-41096-4ed0@gregkh/

Introduced by commit bf6e054 ("genirq/msi: Provide
msi_device_populate/destroy_sysfs()") in v5.17-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9eee5330656bf92f51cb1f09b2dc9f8cf975b3d1]
stable/6.6: [ff1121d2214b794dc1772081f27bdd90721a84bc]

CVE-2024-41097: usb: atm: cxacru: fix endpoint checking in cxacru_bind()

Announce: https://lore.kernel.org/linux-cve-announce/2024072954-CVE-2024-41097-248c@gregkh/

Introduced by commit 902ffc3 ("USB: cxacru: Use a bulk/int URB to
access the command endpoint") in v2.6.36-rc4.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2eabb655a968b862bc0c31629a09f0fbf3c80d51]
stable/4.19: [5159a81924311c1ec786ad9fdef784ead8676a6a]
stable/5.10: [75ddbf776dd04a09fb9e5267ead5d0c989f84506]
stable/5.15: [1aac4be1aaa5177506219f01dce5e29194e5e95a]
stable/5.4: [23926d316d2836315cb113569f91393266eb5b47]
stable/6.1: [5584c776a1af7807ca815ee6265f2c1429fc5727]
stable/6.6: [f536f09eb45e4de8d1b9accee9d992aa1846f1d4]

CVE-2024-41098: ata: libata-core: Fix null pointer dereference on error

Announce: https://lore.kernel.org/linux-cve-announce/2024072954-CVE-2024-41098-eeec@gregkh/

Introduced by commit 633273a ("libata-pmp: hook PMP support and enable
it") in v2.6.24-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d92c7c566dc76d96e0e19e481d926bbe6631c1e]
stable/6.6: [119c97ace2a9ffcf4dc09a23bb057d6c281aff28]

CVE-2024-42069: net: mana: Fix possible double free in error handling path

Announce: https://lore.kernel.org/linux-cve-announce/2024072952-CVE-2024-42069-a6b7@gregkh/

Introduced by commit a69839d ("net: mana: Add support for auxiliary
device") in v6.2-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1864b8224195d0e43ddb92a8151f54f6562090cc]
stable/6.6: [3243e64eb4d897c3eeb48b2a7221ab5a95e1282a]

CVE-2024-42070: netfilter: nf_tables: fully validate NFT_DATA_VALUE on
store to data registers

Announce: https://lore.kernel.org/linux-cve-announce/2024072952-CVE-2024-42070-b271@gregkh/

Introduced by commit 9651851 ("netfilter: add nftables") in v3.13-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7931d32955e09d0a11b1fe0b6aac1bfa061c005c]
stable/4.19: [40188a25a9847dbeb7ec67517174a835a677752f]
stable/5.10: [5d43d789b57943720dca4181a05f6477362b94cf]
stable/5.15: [461302e07f49687ffe7d105fa0a330c07c7646d8]
stable/5.4: [23752737c6a618e994f9a310ec2568881a6b49c4]
stable/6.1: [efb27ad05949403848f487823b597ed67060e007]
stable/6.6: [952bf8df222599baadbd4f838a49c4fef81d2564]

CVE-2024-42071: ionic: use dev_consume_skb_any outside of napi

Announce: https://lore.kernel.org/linux-cve-announce/2024072952-CVE-2024-42071-1749@gregkh/

Introduced by commit 386e698 ("ionic: Make use napi_consume_skb") in v6.9-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84b767f9e34fdb143c09e66a2a20722fc2921821]

CVE-2024-42072: bpf: Fix may_goto with negative offset.

Announce: https://lore.kernel.org/linux-cve-announce/2024072953-CVE-2024-42072-d6af@gregkh/

Introduced by commit 011832b ("bpf: Introduce may_goto instruction")
in v6.9-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b2efe1937ca9f8815884bd4dcd5b32733025103]

CVE-2024-42073: mlxsw: spectrum_buffers: Fix memory corruptions on
Spectrum-4 systems

Announce: https://lore.kernel.org/linux-cve-announce/2024072953-CVE-2024-42073-3453@gregkh/

Introduced by commit f8538ae ("mlxsw: Add support for more than 256
ports in SBSR register") in v5.17-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c28947de2bed40217cf256c5d0d16880054fcf13]
stable/6.1: [bfa86a96912faa0b6142a918db88cc0c738a769e]
stable/6.6: [942901e0fc74ad4b7992ef7ca9336e68d5fd6d36]

CVE-2024-42074: ASoC: amd: acp: add a null check for chip_pdev structure

Announce: https://lore.kernel.org/linux-cve-announce/2024072953-CVE-2024-42074-a913@gregkh/

Introduced by commit 088a409 ("ASoC: amd: acp: add pm ops support for
acp pci driver") in v6.6-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98d919dfee1cc402ca29d45da642852d7c9a2301]
stable/6.6: [e158ed266fc1adfa456880fb6dabce2e5623843b]

CVE-2024-42075: bpf: Fix remap of arena.

Announce: https://lore.kernel.org/linux-cve-announce/2024072954-CVE-2024-42075-febc@gregkh/

Introduced by commit 3174603 ("bpf: Introduce bpf_arena.") in v6.9-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b90d77e5fd784ada62ddd714d15ee2400c28e1cf]

CVE-2024-42076: net: can: j1939: Initialize unused data in j1939_send_one()

Announce: https://lore.kernel.org/linux-cve-announce/2024072954-CVE-2024-42076-a9bd@gregkh/

Introduced by commit 9d71dd0 ("can: add support of SAE J1939
protocol") in v5.4-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7cdf1dd5d2a2d8200efd98d1893684db48fe134]
stable/5.10: [a2a0ebff7fdeb2f66e29335adf64b9e457300dd4]
stable/5.15: [4c5dc3927e17489c1cae6f48c0d5e4acb4cae01f]
stable/5.4: [5e4ed38eb17eaca42de57d500cc0f9668d2b6abf]
stable/6.1: [f97cbce633923588307049c4aef9feb2987e371b]
stable/6.6: [ab2a683938ba4416d389c2f5651cbbb2c41b779f]

CVE-2024-42077: ocfs2: fix DIO failure due to insufficient transaction credits

Announce: https://lore.kernel.org/linux-cve-announce/2024072954-CVE-2024-42077-ff2b@gregkh/

Introduced by commit c15471f ("ocfs2: fix sparse file & data ordering
issue in direct io") in v4.6-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be346c1a6eeb49d8fda827d2a9522124c2f72f36]
stable/5.10: [a68b896aa56e435506453ec8835bc991ec3ae687]
stable/5.15: [320273b5649bbcee87f9e65343077189699d2a7a]
stable/6.1: [9ea2d1c6789722d58ec191f14f9a02518d55b6b4]
stable/6.6: [c05ffb693bfb42a48ef3ee88a55b57392984e111]

CVE-2024-42078: nfsd: initialise nfsd_info.mutex early.

Announce: https://lore.kernel.org/linux-cve-announce/2024072954-CVE-2024-42078-bd37@gregkh/

Introduced by commit 7b207cc ("svc: don't hold reference for
poolstats, only mutex.") in v6.8-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0011bca603c101f2a3c007bdb77f7006fa78fb1]

CVE-2024-42082: xdp: Remove WARN() from __xdp_reg_mem_model()

Announce: https://lore.kernel.org/linux-cve-announce/2024072956-CVE-2024-42082-8411@gregkh/

Introduced by commit 8d5d885 ("xdp: rhashtable with allocator ID to
pointer mapping") in v4.18-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e9f79428372c6eab92271390851be34ab26bfb4]
stable/5.10: [1095b8efbb13a6a5fa583ed373ee1ccab29da2d0]
stable/5.15: [1d3e3b3aa2cbe9bc7db9a7f8673a9fa6d2990d54]
stable/6.1: [4e0c539ee265d5c6e7fa7d229cd4aa7bc01816e2]
stable/6.6: [14e51ea78b4ccacb7acb1346b9241bb790a2054c]

CVE-2024-42083: ionic: fix kernel panic due to multi-buffer handling

Announce: https://lore.kernel.org/linux-cve-announce/2024072947-CVE-2024-42083-9d35@gregkh/

Introduced by commit 5377805 ("ionic: implement xdp frags support") in v6.9-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3f02f32a05009a688a87f5799e049ed6b55bab5]

CVE-2024-42084: ftruncate: pass a signed offset

Announce: https://lore.kernel.org/linux-cve-announce/2024072942-CVE-2024-42084-9283@gregkh/

Introduced by commit 3f6d078 ("fix compat truncate/ftruncate") in v3.9-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b8e88e563b5f666446d002ad0dc1e6e8e7102b0]
stable/4.19: [c329760749b5419769e57cb2be80955d2805f9c9]
stable/5.10: [84bf6b64a1a0dfc6de7e1b1c776d58d608e7865a]
stable/5.15: [dbb226d81cd02cee140139c2369791e6f61f2007]
stable/5.4: [f531d4bc6c5588d713359e42ed65e46816d841d8]
stable/6.1: [5ae6af68410bdad6181ec82104bb9985a7a6a0fa]
stable/6.6: [836359247b0403e0634bfbc83e5bb8063fad287a]

CVE-2024-42085: usb: dwc3: core: remove lock of otg mode during gadget
suspend/resume to avoid deadlock

Announce: https://lore.kernel.org/linux-cve-announce/2024072944-CVE-2024-42085-c342@gregkh/

Introduced by commit 5265397 ("usb: dwc3: Remove DWC3 locking during
gadget suspend/resume") in v6.1-rc1.
Fixed in v6.10-rc6.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [7838de15bb700c2898a7d741db9b1f3cbc86c136]
stable/5.15: [7026576e89094aa9a0062aa6d10cba18aa99944c]
stable/6.1: [d77e2b5104c51d3668b9717c825a4a06998efe63]
stable/6.6: [17e2956633ca560b95f1cbbb297cfc2adf650649]

CVE-2024-42086: iio: chemical: bme680: Fix overflows in compensate() functions

Announce: https://lore.kernel.org/linux-cve-announce/2024072944-CVE-2024-42086-18b8@gregkh/

Introduced by commit 1b3bd85 ("iio: chemical: Add support for Bosch
BME680 sensor") in v4.19-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fdd478c3ae98c3f13628e110dce9b6cfb0d9b3c8]
stable/4.19: [6fa31bbe2ea8665ee970258eb8320cbf231dbe9e]
stable/5.10: [c326551e99f5416986074ce78bef94f6a404b517]
stable/5.15: [7a13d1357658d3a3c1cd7b3b9543c805a6e5e6e9]
stable/5.4: [b0af334616ed425024bf220adda0f004806b5feb]
stable/6.1: [ba1bb3e2a38a7fef1c1818dd4f2d9abbfdde553a]
stable/6.6: [b5967393d50e3c6e632efda3ea3fdde14c1bfd0e]

CVE-2024-42088: ASoC: mediatek: mt8195: Add platform entry for
ETDM1_OUT_BE dai link

Announce: https://lore.kernel.org/linux-cve-announce/2024072945-CVE-2024-42088-b65a@gregkh/

Introduced by commit e70b8dd ("ASoC: mediatek: mt8195: Remove afe-dai
component and rework codec link") in v6.8-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [282a4482e198e03781c152c88aac8aa382ef9a55]

CVE-2024-42089: ASoC: fsl-asoc-card: set priv->pdev before using it

Announce: https://lore.kernel.org/linux-cve-announce/2024072945-CVE-2024-42089-811c@gregkh/

Introduced by commit 708b435 ("ASoC: fsl: Add Freescale Generic ASoC
Sound Card with ASRC support") in v3.18-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90f3feb24172185f1832636264943e8b5e289245]
stable/4.19: [ae81535ce2503aabc4adab3472f4338070cdeb6a]
stable/5.10: [3662eb2170e59b58ad479982dc1084889ba757b9]
stable/5.15: [544ab46b7ece6d6bebbdee5d5659c0a0f804a99a]
stable/5.4: [8896e18b7c366f8faf9344abfd0971435f1c723a]
stable/6.1: [8faf91e58425c2f6ce773250dfd995f1c2d461ac]
stable/6.6: [29bc9e7c75398b0d12fc30955f2e9b2dd29ffaed]

CVE-2024-42090: pinctrl: fix deadlock in create_pinctrl() when
handling -EPROBE_DEFER

Announce: https://lore.kernel.org/linux-cve-announce/2024072946-CVE-2024-42090-5687@gregkh/

Introduced by commit 42fed7b ("pinctrl: move subsystem mutex to
pinctrl_dev struct") in v3.10-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [adec57ff8e66aee632f3dd1f93787c13d112b7a1]
stable/4.19: [e65a0dc2e85efb28e182aca50218e8a056d0ce04]
stable/5.10: [b813e3fd102a959c5b208ed68afe27e0137a561b]
stable/5.15: [01fe2f885f7813f8aed5d3704b384a97b1116a9e]
stable/5.4: [420ce1261907e5dbeda1e4daffd5b6c76f8188c0]
stable/6.1: [b36efd2e3e22a329444b6b24fa48df6d20ae66e6]
stable/6.6: [4038c57bf61631219b31f1bd6e92106ec7f084dc]

CVE-2024-42092: gpio: davinci: Validate the obtained number of IRQs

Announce: https://lore.kernel.org/linux-cve-announce/2024072906-CVE-2024-42092-8375@gregkh/

Introduced by commit eb3744a ("gpio: davinci: Do not assume continuous
IRQ numbering") in v4.19-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7aa9b96e9a73e4ec1771492d0527bd5fc5ef9164]
stable/4.19: [a8d78984fdc105bc1a38b73e98d32b1bc4222684]
stable/5.10: [e44a83bf15c4db053ac6dfe96a23af184c9136d9]
stable/5.15: [70b48899f3f23f98a52c5b1060aefbdc7ba7957b]
stable/5.4: [cd75721984337c38a12aeca33ba301d31ca4b3fd]
stable/6.1: [89d7008af4945808677662a630643b5ea89c6e8d]
stable/6.6: [2d83492259ad746b655f196cd5d1be4b3d0a3782]

CVE-2024-42095: serial: 8250_omap: Implementation of Errata i2310

Announce: https://lore.kernel.org/linux-cve-announce/2024072911-CVE-2024-42095-9b55@gregkh/

Introduced by commit b67e830 ("serial: 8250: 8250_omap: Fix possible
interrupt storm on K3 SoCs") in v5.14-rc1.
Fixed in v6.10-rc6.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [9d141c1e615795eeb93cd35501ad144ee997a826]
stable/5.10: [cb879300669881970eabebe64bd509dbbe42b9de]
stable/5.15: [87257a28271c828a98f762bf2dd803c1793d2b5b]
stable/6.1: [98840e410d53329f5331ecdce095e740791963d0]
stable/6.6: [e67d7f38008e56fb691b6a72cadf16c107c2f48b]

CVE-2024-41013: xfs: don't walk off the end of a directory data block

Announce: https://lore.kernel.org/linux-cve-announce/2024072908-CVE-2024-41013-2996@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [0c7fcdb6d06cdf8b19b57c17605215b06afa864a]

CVE-2024-41014: xfs: add bounds checking to xlog_recover_process_data

Announce: https://lore.kernel.org/linux-cve-announce/2024072910-CVE-2024-41014-9186@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if 4.4 is affected too.

Fixed status
mainline: [fb63435b7c7dc112b1ae1baea5486e0a6e27b196]

CVE-2024-41015: ocfs2: add bounds checking to ocfs2_check_dir_entry()

Announce: https://lore.kernel.org/linux-cve-announce/2024072910-CVE-2024-41015-e5c0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [255547c6bb8940a97eea94ef9d464ea5967763fb]
stable/4.19: [13d38c00df97289e6fba2e54193959293fd910d2]
stable/5.10: [77495e5da5cb110a8fed27b052c77853fe282176]
stable/5.15: [53de17ad01cb5f6f8426f597e9d5c87d4cf53bb7]
stable/5.4: [564d23cc5b216211e1694d53f7e45959396874d0]
stable/6.1: [fd65685594ee707cbf3ddf22ebb73697786ac114]
stable/6.6: [e05a24289db90f76ff606086aadd62d068a88dcd]

CVE-2024-41016: ocfs2: strict bound check before memcmp in
ocfs2_xattr_find_entry()

Announce: https://lore.kernel.org/linux-cve-announce/2024072910-CVE-2024-41016-fcf9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [af77c4fc1871847b528d58b7fdafb4aa1f6a9262]

CVE-2024-41017: jfs: don't walk off the end of ealist

Announce: https://lore.kernel.org/linux-cve-announce/2024072911-CVE-2024-41017-f367@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [d0fa70aca54c8643248e89061da23752506ec0d4]
stable/4.19: [7f91bd0f2941fa36449ce1a15faaa64f840d9746]
stable/5.10: [6386f1b6a10e5d1ddd03db4ff6dfc55d488852ce]
stable/5.15: [7e21574195a45fc193555fa40e99fed16565ff7e]
stable/5.4: [fc16776a82e8df97b6c4f9a10ba95aa44cef7ba5]
stable/6.1: [4e034f7e563ab723b93a59980e4a1bb33198ece8]
stable/6.6: [17440dbc66ab98b410514b04987f61deedb86751]

CVE-2024-41019: fs/ntfs3: Validate ff offset

Announce: https://lore.kernel.org/linux-cve-announce/2024072911-CVE-2024-41019-bf1d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
The fs/ntfs3/fslog.c was added by commit b46acd6 ("fs/ntfs3: Add NTFS journal")
in 5.15-rc1.

Fixed status
mainline: [50c47879650b4c97836a0086632b3a2e300b0f06]
stable/5.15: [35652dfa8cc9a8a900ec0f1e0395781f94ffc5f0]
stable/6.1: [818a257428644b8873e79c44404d8fb6598d4440]
stable/6.6: [6ae7265a7b816879fd0203e83b5030d3720bbb7a]

CVE-2024-41030: ksmbd: discard write access to the directory open

Announce: https://lore.kernel.org/linux-cve-announce/2024072921-CVE-2024-41030-301a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10.
Affected file fs/smb/server/smb2pdu.c was introduced by commit e2f34481b2
("cifsd: add server-side procedures for SMB3") in 5.15-rc1.

Fixed status
mainline: [e2e33caa5dc2eae7bddf88b22ce11ec3d760e5cd]
stable/6.1: [66cf853e1c7a2407f15d9f7aaa3e47d61745e361]
stable/6.6: [9e84b1ba5c98fb5c9f869c85db1d870354613baa]

CVE-2024-41052: vfio/pci: Init the count variable in collecting
hot-reset devices

Announce: https://lore.kernel.org/linux-cve-announce/2024072927-CVE-2024-41052-1a10@gregkh/

Introduced by commit f6944d4a0b87 ("vfio/pci: Collect hot-reset
devices to local buffer")
in 6.10-rc1..
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [5a88a3f67e37e39f933b38ebb4985ba5822e9eca]
stable/6.6: [f476dffc52ea70745dcabf63288e770e50ac9ab3]

CVE-2024-41059: hfsplus: fix uninit-value in copy_name

Announce: https://lore.kernel.org/linux-cve-announce/2024072905-CVE-2024-41059-30cc@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10.

Fixed status
mainline: [0570730c16307a72f8241df12363f76600baf57d]
stable/4.19: [72805debec8f7aa342da194fe0ed7bc8febea335]
stable/5.10: [34f8efd2743f2d961e92e8e994de4c7a2f9e74a0]
stable/5.15: [d02d8c1dacafb28930c39e16d48e40bb6e4cbc70]
stable/5.4: [c733e24a61cbcff10f660041d6d84d32bb7e4cb4]
stable/6.1: [22999936b91ba545ce1fbbecae6895127945e91c]
stable/6.6: [f08956d8e0f80fd0d4ad84ec917302bb2f3a9c6a]

CVE-2024-41060: drm/radeon: check bo_va->bo is non-NULL before using it

Announce: https://lore.kernel.org/linux-cve-announce/2024072905-CVE-2024-41060-b7de@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc7.

Fixed status
mainline: [6fb15dcbcf4f212930350eaee174bb60ed40a536]
stable/5.15: [a2b201f83971df03c8e81a480b2f2846ae8ce1a3]
stable/6.1: [a9100f17428cb733c4f6fbb132d98bed76318342]
stable/6.6: [f13c96e0e325a057c03f8a47734adb360e112efe]

CVE-2024-41061: drm/amd/display: Fix array-index-out-of-bounds in
dml2/FCLKChangeSupport

Announce: https://lore.kernel.org/linux-cve-announce/2024072906-CVE-2024-41061-5ea5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc7.
The dml2_utils.c was added by commit 7966f319c ("drm/amd/display:
Introduce DML2")
in 6.7-rc1.

Fixed status
mainline: [0ad4b4a2f6357c45fbe444ead1a929a0b4017d03]

CVE-2024-41062: bluetooth/l2cap: sync sock recv cb and release

Announce: https://lore.kernel.org/linux-cve-announce/2024072906-CVE-2024-41062-cb85@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc7.

Fixed status
mainline: [89e856e124f9ae548572c56b1b70c2255705f8fe]
stable/6.1: [605572e64cd9cebb05ed609d96cff05b50d18cdf]
stable/6.6: [b803f30ea23e0968b6c8285c42adf0d862ab2bf6]

CVE-2024-41063: Bluetooth: hci_core: cancel all works upon hci_unregister_dev()

Announce: https://lore.kernel.org/linux-cve-announce/2024072906-CVE-2024-41063-b9bd@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc7.

Fixed status
mainline: [0d151a103775dd9645c78c97f77d6e2a5298d913]
stable/4.19: [48542881997e17b49dc16b93fe910e0cfcf7a9f9]
stable/5.10: [ddeda6ca5f218b668b560d90fc31ae469adbfd92]
stable/5.15: [d2ce562a5aff1dcd0c50d9808ea825ef90da909f]
stable/5.4: [9cfc84b1d464cc024286f42a090718f9067b80ed]
stable/6.1: [96600c2e5ee8213dbab5df1617293d8e847bb4fa]
stable/6.6: [d6cbce18370641a21dd889e8613d8153df15eb39]

CVE-2024-41064: powerpc/eeh: avoid possible crash when edev->pdev changes

Announce: https://lore.kernel.org/linux-cve-announce/2024072907-CVE-2024-41064-6ecb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc7.
CIP does not support powerpc.

Fixed status
mainline: [a1216e62d039bf63a539bbe718536ec789a853dd]
stable/5.10: [033c51dfdbb6b79ab43fb3587276fa82d0a329e1]
stable/5.15: [4fad7fef847b6028475dd7b4c14fcb82b3e51274]
stable/5.4: [8836e1bf5838ac6c08760e0a2dd7cf6410aa7ff3]
stable/6.1: [4bc246d2d60d071314842fa448faa4ed39082aff]
stable/6.6: [f23c3d1ca9c4b2d626242a4e7e1ec1770447f7b5]

CVE-2024-41065: powerpc/pseries: Whitelist dtl slub object for copying
to userspace

Announce: https://lore.kernel.org/linux-cve-announce/2024072907-CVE-2024-41065-2501@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc7.
CIP does not support powerpc

Fixed status
mainline: [1a14150e1656f7a332a943154fc486504db4d586]
stable/5.10: [6b16098148ea58a67430d90e20476be2377c3acd]
stable/5.15: [e59822f9d700349cd17968d22c979db23a2d347f]
stable/5.4: [a7b952941ce07e1e7a2cafd08c64a98e14f553e6]
stable/6.1: [1ee68686d1e2a5da35d5650be0be1ce06fe2ceb2]
stable/6.6: [e512a59b472684d8585125101ab03b86c2c1348a]

CVE-2024-41066: ibmvnic: Add tx check to prevent skb leak

Announce: https://lore.kernel.org/linux-cve-announce/2024072907-CVE-2024-41066-0a52@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc6.
This driver was added by commit 032c5e82 ("Driver for IBM System i/p
VNIC protocol")
in 4.5-rc1. No CIP member enables IBMVNIC.

Fixed status
mainline: [0983d288caf984de0202c66641577b739caad561]
stable/6.1: [16ad1557cae582e79bb82dddd612d9bdfaa11d4c]
stable/6.6: [267c61c4afed0ff9a2e83462abad3f41d8ca1f06]

CVE-2024-41067: btrfs: scrub: handle RST lookup error correctly

Announce: https://lore.kernel.org/linux-cve-announce/2024072907-CVE-2024-41067-bc18@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc6.

Fixed status
mainline: [2c49908634a2b97b1c3abe0589be2739ac5e7fd5]

CVE-2024-41068: s390/sclp: Fix sclp_init() cleanup on failure

Announce: https://lore.kernel.org/linux-cve-announce/2024072908-CVE-2024-41068-ed71@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc6.
CIP does not support s390.

Fixed status
mainline: [6434b33faaa063df500af355ee6c3942e0f8d982]
stable/4.19: [a778987afc36d5dc02a1f82d352a81edcaf7eb83]
stable/5.10: [2e51db7ab71b89dc5a17068f5e201c69f13a4c9a]
stable/5.15: [cf521049fcd07071ed42dc9758fce7d5ee120ec6]
stable/5.4: [455a6653d8700a81aa8ed2b6442a3be476007090]
stable/6.1: [79b4be70d5a160969b805f638ac5b4efd0aac7a3]
stable/6.6: [0a31b3fdc7e735c4f8c65fe4339945c717ed6808]

CVE-2024-41069: ASoC: topology: Fix references to freed memory

Announce: https://lore.kernel.org/linux-cve-announce/2024072908-CVE-2024-41069-31e3@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc6.

Fixed status
mainline: [97ab304ecd95c0b1703ff8c8c3956dc6e2afe8e1]
stable/6.1: [b188d7f3dfab10e332e3c1066e18857964a520d2]
stable/6.6: [ab5a6208b4d6872b1c6ecea1867940fc668cc76d]

CVE-2024-41070: KVM: PPC: Book3S HV: Prevent UAF in
kvm_spapr_tce_attach_iommu_group()

Announce: https://lore.kernel.org/linux-cve-announce/2024072908-CVE-2024-41070-ad39@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc5.
CIP does not support powerpc

Fixed status
mainline: [a986fa57fd81a1430e00b3c6cf8a325d6f894a63]
stable/5.10: [4cdf6926f443c84f680213c7aafbe6f91a5fcbc0]
stable/5.15: [b26c8c85463ef27a522d24fcd05651f0bb039e47]
stable/5.4: [be847bb20c809de8ac124431b556f244400b0491]
stable/6.1: [5f856023971f97fff74cfaf21b48ec320147b50a]
stable/6.6: [82c7a4cf14aa866f8f7f09e662b02eddc49ee0bf]

CVE-2024-41071: wifi: mac80211: Avoid address calculations via out of
bounds array indexing

Announce: https://lore.kernel.org/linux-cve-announce/2024072909-CVE-2024-41071-4eb6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc5.

Fixed status
mainline: [2663d0462eb32ae7c9b035300ab6b1523886c718]

CVE-2024-41072: wifi: cfg80211: wext: add extra SIOCSIWSCAN data check

Announce: https://lore.kernel.org/linux-cve-announce/2024072909-CVE-2024-41072-86de@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc5.

Fixed status
mainline: [6ef09cdc5ba0f93826c09d810c141a8d103a80fc]
stable/4.19: [b02ba9a0b55b762bd04743a22f3d9f9645005e79]
stable/5.10: [6295bad58f988eaafcf0e6f8b198a580398acb3b]
stable/5.15: [a43cc0558530b6c065976b6b9246f512f8d3593b]
stable/5.4: [de5fcf757e33596eed32de170ce5a93fa44dd2ac]
stable/6.1: [001120ff0c9e3557dee9b5ee0d358e0fc189996f]
stable/6.6: [fe9644efd86704afe50e56b64b609de340ab7c95]

CVE-2024-41073: nvme: avoid double free special payload

Announce: https://lore.kernel.org/linux-cve-announce/2024072909-CVE-2024-41073-1fb9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc4.
Affected function nvme_cleanup_cmd() was added by commit f7f1fc363a
("nvme: use blk API to remap ref tags for IOs with metadata") in 4.19-rc1.

Fixed status
mainline: [e5d574ab37f5f2e7937405613d9b1a724811e5ad]
stable/5.15: [c5942a14f795de957ae9d66027aac8ff4fe70057]
stable/6.1: [f3ab45aacd25d957547fb6d115c1574c20964b3b]
stable/6.6: [ae84383c96d6662c24697ab6b44aae855ab670aa]

CVE-2024-41074: cachefiles: Set object to close if ondemand_id < 0 in copen

Announce: https://lore.kernel.org/linux-cve-announce/2024072910-CVE-2024-41074-e5d9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc4.
Affected file fs/cachefiles/ondemand.c was added by commit c83830545
("cachefiles: notify the user daemon when looking up cookie") in
5.19-rc1.

Fixed status
mainline: [4f8703fb3482f92edcfd31661857b16fec89c2c0]
stable/6.1: [703bea37d13e4ccdafd17ae7c4cb583752ba7663]
stable/6.6: [c32ee78fbc670e6f90989a45d340748e34cad333]

CVE-2024-41075: cachefiles: add consistency check for copen/cread

Announce: https://lore.kernel.org/linux-cve-announce/2024072910-CVE-2024-41075-7f07@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc4.
Affected file fs/cachefiles/ondemand.c was added by commit c83830545
("cachefiles: notify the user daemon when looking up cookie") in
5.19-rc1.

Fixed status
mainline: [a26dc49df37e996876f50a0210039b2d211fdd6f]
stable/6.1: [3b744884c0431b5a62c92900e64bfd0ed61e8e2a]
stable/6.6: [36d845ccd7bf527110a65fe953886a176c209539]

CVE-2024-41076: NFSv4: Fix memory leak in nfs4_set_security_label

Announce: https://lore.kernel.org/linux-cve-announce/2024072910-CVE-2024-41076-6124@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc4.

Fixed status
mainline: [aad11473f8f4be3df86461081ce35ec5b145ba68]
stable/6.1: [899604a7c958771840941caff9ee3dd8193d984c]
stable/6.6: [b98090699319e64f5de1e8db5bb75870f1eb1c6e]

CVE-2024-41077: null_blk: fix validation of block size

Announce: https://lore.kernel.org/linux-cve-announce/2024072910-CVE-2024-41077-9c88@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc3.
It seems as if commit cedcafad ("nullb: add interface to power on disk")
in 4.14-rc1.

Fixed status
mainline: [c462ecd659b5fce731f1d592285832fd6ad54053]
stable/5.10: [9625afe1dd4a158a14bb50f81af9e2dac634c0b1]
stable/5.15: [9b873bdaae64bddade9d8c6df23c8a31948d47d0]
stable/6.1: [2772ed2fc075eef7df3789906fc9dae01e4e132e]
stable/6.6: [08f03186b96e25e3154916a2e70732557c770ea7]

CVE-2024-41078: btrfs: qgroup: fix quota root leak after quota disable failure

Announce: https://lore.kernel.org/linux-cve-announce/2024072925-CVE-2024-41078-ab5c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc6.
According to the commit log, this bug was introduced by commit
bed92eae ("Btrfs: qgroup implementation and prototypes") in 3.6-rc1.

Fixed status
mainline: [a7e4c6a3031c74078dba7fa36239d0f4fe476c53]
stable/5.10: [94818bdb00ef34a996a06aa63d11f591074cb757]
stable/5.15: [8a69529f22590b67bb018de9acbcf94abc8603cf]
stable/6.1: [5ef3961682e5310f2221bae99bcf9f5d0f4b0d51]
stable/6.6: [f88aeff5a173e8ba3133314eb4b964236ef3589d]

CVE-2024-41079: nvmet: always initialize cqe.result

Announce: https://lore.kernel.org/linux-cve-announce/2024072925-CVE-2024-41079-09c3@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc4.
The fabrics-cmd-auth.c was added by commit db1312dd95 ("nvmet:
implement basic In-Band Authentication")
in 6.0-rc1. The fabrics-cmd.c was added by commit a07b4970f4 ("nvmet:
add a generic NVMe target") in
4.8-rc1.

Fixed status
mainline: [cd0c1b8e045a8d2785342b385cb2684d9b48e426]
stable/6.1: [30d35b24b7957922f81cfdaa66f2e1b1e9b9aed2]
stable/6.6: [10967873b80742261527a071954be8b54f0f8e4d]

CVE-2024-41080: io_uring: fix possible deadlock in
io_register_iowq_max_workers()

Announce: https://lore.kernel.org/linux-cve-announce/2024072926-CVE-2024-41080-6385@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc3.

Fixed status
mainline: [73254a297c2dd094abec7c9efee32455ae875bdf]

CVE-2024-41081: ila: block BH in ila_output()

Announce: https://lore.kernel.org/linux-cve-announce/2024072926-CVE-2024-41081-2552@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc3.

Fixed status
mainline: [cf28ff8e4c02e1ffa850755288ac954b6ff0db8c]
stable/4.19: [7435bd2f84a25aba607030237261b3795ba782da]
stable/5.10: [a0cafb7b0b94d18e4813ee4b712a056f280e7b5a]
stable/5.15: [feac2391e26b086f73be30e9b1ab215eada8d830]
stable/5.4: [96103371091c6476eb07f4c66624bdd1b42f758a]
stable/6.1: [b4eb25a3d70df925a9fa4e82d17a958a0a228f5f]
stable/6.6: [522c3336c2025818fa05e9daf0ac35711e55e316]

CVE-2024-41082: nvme-fabrics: use reserved tag for reg read/write command

Announce: https://lore.kernel.org/linux-cve-announce/2024072926-CVE-2024-41082-6e0a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc3.
It seems as if this bug was introduced by commit 07bfcd09a
("nvme-fabrics: add a generic NVMe over Fabrics library") in 4.8-rc1.

Fixed status
mainline: [7dc3bfcb4c9cc58970fff6aaa48172cb224d85aa]

CVE-2024-41089: drm/nouveau/dispnv04: fix null pointer dereference in
nv17_tv_get_hd_modes

Announce: https://lore.kernel.org/linux-cve-announce/2024072952-CVE-2024-41089-5d63@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc6.

Fixed status
mainline: [6d411c8ccc0137a612e0044489030a194ff5c843]
stable/4.19: [ffabad4aa91e33ced3c6ae793fb37771b3e9cb51]
stable/5.10: [56fc4d3b0bdef691831cd95715a7ca3ebea98b2d]
stable/5.15: [5eecb49a6c268dc229005bf6e8167d4001dc09a0]
stable/5.4: [1c9f2e60150b4f13789064370e37f39e6e060f50]
stable/6.1: [30cbf6ffafbbdd8a6e4e5f0a2e9a9827ee83f3ad]
stable/6.6: [7ece609b0ce7a7ea8acdf512a77d1fee26621637]

CVE-2024-41093: drm/amdgpu: avoid using null object of framebuffer

Announce: https://lore.kernel.org/linux-cve-announce/2024072953-CVE-2024-41093-9d6c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc6.
It seems as if this bug was introduced by commit 84ec374b
("drm/amdgpu: create amdgpu_vkms (v4)") in 5.15-rc1.

Fixed status
mainline: [bcfa48ff785bd121316592b131ff6531e3e696bb]
stable/5.15: [7f35e01cb0ea4d295f5c067bb5c67dfcddaf05bc]
stable/6.1: [6ce0544cabaa608018d5922ab404dc656a9d8447]
stable/6.6: [330c8c1453848c04d335bad81371a66710210800]

CVE-2024-41095: drm/nouveau/dispnv04: fix null pointer dereference in
nv17_tv_get_ld_modes

Announce: https://lore.kernel.org/linux-cve-announce/2024072954-CVE-2024-41095-7b63@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc6.

Fixed status
mainline: [66edf3fb331b6c55439b10f9862987b0916b3726]
stable/4.19: [9289cd3450d1da3e271ef4b054d4d2932c41243e]
stable/5.10: [259549b2ccf795b7f91f7b5aba47286addcfa389]
stable/5.15: [0d17604f2e44b3df21e218fe8fb3b836d41bac49]
stable/5.4: [dbd75f32252508ed6c46c3288a282c301a57ceeb]
stable/6.1: [f95ed0f54b3d3faecae1140ddab854f904a6e7c8]
stable/6.6: [cb751e48bbcffd292090f7882b23b215111b3d72]

CVE-2024-42063: bpf: Mark bpf prog stack with kmsan_unposion_memory in
interpreter mode

Announce: https://lore.kernel.org/linux-cve-announce/2024072950-CVE-2024-42063-d3a5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
The PROG_NAME was added by commit b870aa901f4 ("bpf: use different interpreter
depending on required stack size") in 4.13-rc1. The PROG_NAME_ARGS was added by
commit 1ea47e01ad6 ("bpf: add support for bpf_call to interpreter") in 4.16-rc1.

Fixed status
mainline: [e8742081db7d01f980c6161ae1e8a1dbc1e30979]
stable/6.1: [b30f3197a6cd080052d5d4973f9a6b479fd9fff5]
stable/6.6: [d812ae6e02bd6e6a9cd1fdb09519c2f33e875faf]

CVE-2024-42064: drm/amd/display: Skip pipe if the pipe idx not set properly

Announce: https://lore.kernel.org/linux-cve-announce/2024072950-CVE-2024-42064-5fc8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
Affected file was added by commit 7966f31 ("drm/amd/display: Introduce DML2")
in 6.7-rc1.

Fixed status
mainline: [af114efe8d24b5711cfbedf7180f2ac1a296c24b]

CVE-2024-42065: drm/xe: Add a NULL check in xe_ttm_stolen_mgr_init

Announce: https://lore.kernel.org/linux-cve-announce/2024072951-CVE-2024-42065-e084@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
Affected file was added by commit d8b52a02c ("drm/xe: Implement stolen memory.")
in 6.8-rc1.

Fixed status
mainline: [a6eff8f9c7e844cb24ccb188ca24abcd59734e74]

CVE-2024-42066: drm/xe: Fix potential integer overflow in page size calculation

Announce: https://lore.kernel.org/linux-cve-announce/2024072951-CVE-2024-42066-0625@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
Affected file was added by commit dd08ebf6 ("drm/xe: Introduce a new
DRM driver for Intel GPUs")
in 6.8-rc1.

Fixed status
mainline: [4f4fcafde343a54465f85a2909fc684918507a4b]

CVE-2024-42067: bpf: Take return from set_memory_rox() into account
with bpf_jit_binary_lock_ro()

Announce: https://lore.kernel.org/linux-cve-announce/2024072951-CVE-2024-42067-c8ef@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.

Fixed status
mainline: [e60adf513275c3a38e5cb67f7fd12387e43a3ff5]
stable/6.6: [9fef36cad60d4226f9d06953cd56d1d2f9119730]

CVE-2024-42068: bpf: Take return from set_memory_ro() into account
with bpf_prog_lock_ro()

Announce: https://lore.kernel.org/linux-cve-announce/2024072951-CVE-2024-42068-9265@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.

Fixed status
mainline: [7d2cc63eca0c993c99d18893214abf8f85d566d8]
stable/5.15: [a359696856ca9409fb97655c5a8ef0f549cb6e03]
stable/6.1: [e4f602e3ff749ba770bf8ff10196e18358de6720]
stable/6.6: [e3540e5a7054d6daaf9a1415a48aacb092112a89]

CVE-2024-42079: gfs2: Fix NULL pointer dereference in gfs2_log_flush

Announce: https://lore.kernel.org/linux-cve-announce/2024072955-CVE-2024-42079-a13c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.

Fixed status
mainline: [35264909e9d1973ab9aaa2a1b07cda70f12bb828]
stable/6.6: [3429ef5f50909cee9e498c50f0c499b9397116ce]

CVE-2024-42080: RDMA/restrack: Fix potential invalid address access

Announce: https://lore.kernel.org/linux-cve-announce/2024072955-CVE-2024-42080-d848@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
Affected file was added by commit 02d8883f520 ("RDMA/restrack: Add general
infrastructure to track RDMA resources") in 4.16-rc1.

Fixed status
mainline: [ca537a34775c103f7b14d7bbd976403f1d1525d8]
stable/5.15: [8656ef8a9288d6c932654f8d3856dc4ab1cfc6b5]
stable/6.1: [782bdaf9d01658281bc813f3f873e6258aa1fd8d]
stable/6.6: [8ac281d42337f36cf7061cf1ea094181b84bc1a9]

CVE-2024-42081: drm/xe/xe_devcoredump: Check NULL before assignments

Announce: https://lore.kernel.org/linux-cve-announce/2024072955-CVE-2024-42081-f144@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
Affected file was added by commit e799485044 ("drm/xe: Introduce the
dev_coredump infrastructure."
in 6.8-rc1.

Fixed status
mainline: [b15e65349553b1689d15fbdebea874ca5ae2274a]

CVE-2024-42087: drm/panel: ilitek-ili9881c: Fix warning with GPIO
controllers that sleep

Announce: https://lore.kernel.org/linux-cve-announce/2024072945-CVE-2024-42087-2684@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It looks as if this bug was introduced by commit 26aec2559 ("drm/panel: Add
Ilitek ILI9881c panel driver") in 4.19-rc1.

Fixed status
mainline: [ee7860cd8b5763017f8dc785c2851fecb7a0c565]
stable/4.19: [b71348be1236398be2d04c5e145fd6eaae86a91b]
stable/5.10: [cae52f61fda0f5d2949dc177f984c9e187d4c6a0]
stable/5.15: [489f38de3375ab84b3d269d0a1d64d6ee95d7044]
stable/5.4: [98686ec1824728ff41d7b358131f7d0227c2ba2a]
stable/6.1: [5f41401219fbe7663b3cf65ebd4ed95ebbb8ffb9]
stable/6.6: [1618f7a875ffd916596392fd29880c0429b8af60]

CVE-2024-42091: drm/xe: Check pat.ops before dumping PAT settings

Announce: https://lore.kernel.org/linux-cve-announce/2024072904-CVE-2024-42091-597d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
This bug was introduced by commit 34803f9a4 ("drm/xe/pat: Add debugfs
node to dump PAT")
in 6.8-rc1.

Fixed status
mainline: [a918e771e6fbe1fa68932af5b0cdf473e23090cc]

CVE-2024-42093: net/dpaa2: Avoid explicit cpumask var allocation on stack

Announce: https://lore.kernel.org/linux-cve-announce/2024072910-CVE-2024-42093-9646@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It seems as if this bug was introduced by commit 06d5b179
("dpaa2-eth: Refactor xps code") in 5.3-rc1.

Fixed status
mainline: [d33fe1714a44ff540629b149d8fab4ac6967585c]
stable/5.10: [763896ab62a672d728f5eb10ac90d98c607a8509]
stable/5.15: [a55afc0f5f20ba30970aaf7271929dc00eee5e7d]
stable/5.4: [b2262b3be27cee334a2fa175ae3afb53f38fb0b1]
stable/6.1: [48147337d7efdea6ad6e49f5b8eb894b95868ef0]
stable/6.6: [69f49527aea12c23b78fb3d0a421950bf44fb4e2]

CVE-2024-42094: net/iucv: Avoid explicit cpumask var allocation on stack

Announce: https://lore.kernel.org/linux-cve-announce/2024072911-CVE-2024-42094-135f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It seems as if this bug was introduced by commit 38b48292
("net/iucv: Convert to hotplug state machine") in 4.10-rc1.

Fixed status
mainline: [be4e1304419c99a164b4c0e101c7c2a756b635b9]
stable/4.19: [2b085521be5292016097b5e7ca81b26be3f7098d]
stable/5.10: [9dadab0db7d904413ea1cdaa13f127da05c31e71]
stable/5.15: [0af718a690acc089aa1bbb95a93df833d864ef53]
stable/5.4: [842afb47d84536fc976fece8fb6c54bea711ad1a]
stable/6.1: [d85ca8179a54ff8cf1e1f8c3c9e3799831319bae]
stable/6.6: [724e7965af054079242b8d6f7e50ee226730a756]

CVE-2024-42096: x86: stop playing stack games in profile_pc()

Announce: https://lore.kernel.org/linux-cve-announce/2024072911-CVE-2024-42096-67f3@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc6.

Fixed status
mainline: [093d9603b60093a9aaae942db56107f6432a5dca]
stable/4.19: [65ebdde16e7f5da99dbf8a548fb635837d78384e]
stable/5.10: [49c09ca35a5f521d7fa18caf62fdf378f15e8aa4]
stable/5.15: [2d07fea561d64357fb7b3f3751e653bf20306d77]
stable/5.4: [27c3be840911b15a3f24ed623f86153c825b6b29]
stable/6.1: [161cef818545ecf980f0e2ebaf8ba7326ce53c2b]
stable/6.6: [16222beb9f8e5ceb0beeb5cbe54bef16df501a92]

CVE-2024-42097: ALSA: emux: improve patch ioctl data validation

Announce: https://lore.kernel.org/linux-cve-announce/2024072911-CVE-2024-42097-5a6a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.

Fixed status
mainline: [89b32ccb12ae67e630c6453d778ec30a592a212f]
stable/4.19: [40d7def67841343c10f8642a41031fecbb248bab]
stable/5.10: [d23982ea9aa438f35a8c8a6305943e98a8db90f6]
stable/5.15: [7a18293fd8d8519c2f7a03753bc1583b18e3db69]
stable/5.4: [79d9a000f0220cdaba1682d2a23c0d0c61d620a3]
stable/6.1: [d0ff2443fcbb472206d45a5d2a90cc694065804e]
stable/6.6: [d8f5ce3cb9adf0c72e2ad6089aba02d7a32469c2]

CVE-2024-42098: crypto: ecdh - explicitly zeroize private_key

Announce: https://lore.kernel.org/linux-cve-announce/2024072912-CVE-2024-42098-fe86@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
Affected file was added by commit 3c4b23901a0 ("crypto: ecdh - Add ECDH
software support") in 4.8-rc1.

Fixed status
mainline: [73e5984e540a76a2ee1868b91590c922da8c24c9]
stable/5.15: [39173b04abda87872b43c331468a4a14f8f05ce8]
stable/6.1: [fd7ef325911eba1b7191b83cb580463242f2090d]
stable/6.6: [80575b252ab0358b7e93895b2a510beb3cb3f975]

CVE-2024-42099: s390/dasd: Fix invalid dereferencing of indirect CCW
data pointer

Announce: https://lore.kernel.org/linux-cve-announce/2024073018-CVE-2024-42099-d7b7@gregkh/

Introduced by commit c0bd396 ("s390/dasd: use new address translation
helpers") in v6.9-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3a58f3b90f564f42a5c35778d8c5107b2c2150b]

CVE-2024-42100: clk: sunxi-ng: common: Don't call hw_to_ccu_common on
hw without common

Announce: https://lore.kernel.org/linux-cve-announce/2024073018-CVE-2024-42100-bc58@gregkh/

Introduced by commit b914ec3 ("clk: sunxi-ng: common: Support minimum
and maximum rate") in v6.9-rc7.
Fixed in v6.10-rc7.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [ea977d742507e534d9fe4f4d74256f6b7f589338]
stable/6.6: [14c78d69dbca6a28af14095f639ec4318ec07fdc]

CVE-2024-42101: drm/nouveau: fix null pointer dereference in
nouveau_connector_get_modes

Announce: https://lore.kernel.org/linux-cve-announce/2024073018-CVE-2024-42101-f246@gregkh/

Introduced by commit 6ee7386 ("drm/nouveau: Add DRM driver for NVIDIA
GPUs") in v2.6.33-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [80bec6825b19d95ccdfd3393cf8ec15ff2a749b4]
stable/4.19: [9baf60323efa992b7c915094529f0a1882c34e7e]
stable/5.10: [274cba8d2d1b48c72d8bd90e76c9e2dc1aa0a81d]
stable/5.15: [f48dd3f19614022f2e1b794fbd169d2b4c398c07]
stable/5.4: [e36364f5f3785d054a94e57e971385284886d41a]
stable/6.1: [1f32535238493008587a8c5cb17eb2ca097592ef]
stable/6.6: [744b229f09134ccd091427a6f9ea6d97302cfdd9]

CVE-2024-42102: Revert "mm/writeback: fix possible divide-by-zero in
wb_dirty_limits(), again"

Announce: https://lore.kernel.org/linux-cve-announce/2024073019-CVE-2024-42102-bcee@gregkh/

Introduced by commit 9319b64 ("mm/writeback: fix possible
divide-by-zero in wb_dirty_limits(), again") in v6.8-rc3.
Fixed in v6.10-rc7.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19 stable/5.10 stable/5.15
stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [30139c702048f1097342a31302cbd3d478f50c63]
stable/4.19: [253f9ea7e8e53a5176bd80ceb174907b10724c1a]
stable/5.10: [145faa3d03688cbb7bbaaecbd84c01539852942c]
stable/5.15: [2820005edae13b140f2d54267d1bd6bb23915f59]
stable/5.4: [23a28f5f3f6ca1e4184bd0e9631cd0944cf1c807]
stable/6.1: [cbbe17a324437c0ff99881a3ee453da45b228a00]
stable/6.6: [f6620df12cb6bdcad671d269debbb23573502f9d]

CVE-2024-42106: inet_diag: Initialize pad field in struct inet_diag_req_v2

Announce: https://lore.kernel.org/linux-cve-announce/2024073020-CVE-2024-42106-a042@gregkh/

Introduced by commit 432490f ("net: ip, diag -- Add diag interface for
raw sockets") in v4.10-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61cf1c739f08190a4cbf047b9fbb192a94d87e3f]
stable/4.19: [7094a5fd20ab66028f1da7f06e0f2692d70346f9]
stable/5.10: [7ef519c8efde152e0d632337f2994f6921e0b7e4]
stable/5.15: [8366720519ea8d322a20780debdfd23d9fc0904a]
stable/5.4: [0184bf0a349f4cf9e663abbe862ff280e8e4dfa2]
stable/6.1: [d6f487e0704de2f2d15f8dd5d7d723210f2b2fdb]
stable/6.6: [76965648fe6858db7c5f3c700fef7aa5f124ca1c]

CVE-2024-42107: ice: Don't process extts if PTP is disabled

Announce: https://lore.kernel.org/linux-cve-announce/2024073020-CVE-2024-42107-65cc@gregkh/

Introduced by commit 172db5f ("ice: add support for auxiliary
input/output pins") in v5.14-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [996422e3230e41468f652d754fefd1bdbcd4604e]

CVE-2024-42108: net: rswitch: Avoid use-after-free in rswitch_poll()

Announce: https://lore.kernel.org/linux-cve-announce/2024073021-CVE-2024-42108-7e70@gregkh/

Introduced by commit 271e015 ("net: rswitch: Add unmap_addrs instead
of dma address in each desc") in v6.8-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a0c28efeec6383ef22e97437616b920e7320b67]

CVE-2024-42109: netfilter: nf_tables: unconditionally flush pending
work before notifier

Announce: https://lore.kernel.org/linux-cve-announce/2024073021-CVE-2024-42109-2531@gregkh/

Introduced by commit 2c9f029 ("netfilter: nf_tables: flush pending
destroy work before netlink notifier") in v6.5.
Fixed in v6.10-rc7.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [9f6958ba2e902f9820c594869bd710ba74b7c4c0]
stable/5.15: [3325628cb36b7f216c5716e7b5124d9dc81199e4]
stable/6.1: [4c06c13317b9a08decedcd7aaf706691e336277c]
stable/6.6: [55a40406aac555defe9bdd0adec9508116ce7cb1]

CVE-2024-42110: net: ntb_netdev: Move ntb_netdev_rx_handler() to call
netif_rx() from __netif_rx()

Announce: https://lore.kernel.org/linux-cve-announce/2024073021-CVE-2024-42110-4b28@gregkh/

Introduced by commit 548c237 ("net: Add support for NTB virtual
ethernet device") in v3.9-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e15a5d821e5192a3769d846079bc9aa380139baf]
stable/6.1: [4b3b6c7efee69f077b86ef7f088fb96768e46e1f]
stable/6.6: [e3af5b14e7632bf12058533d69055393e2d126c9]

CVE-2024-42111: btrfs: always do the basic checks for
btrfs_qgroup_inherit structure

Announce: https://lore.kernel.org/linux-cve-announce/2024073021-CVE-2024-42111-034c@gregkh/

Introduced by commit b5357cb ("btrfs: qgroup: do not check qgroup
inherit if qgroup is disabled") in v6.9.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [724d8042cef84496ddb4492dc120291f997ae26b]

CVE-2024-42112: net: txgbe: free isb resources at the right time

Announce: https://lore.kernel.org/linux-cve-announce/2024073022-CVE-2024-42112-ee07@gregkh/

Introduced by commit aefd013 ("net: txgbe: use irq_domain for
interrupt controller") in v6.9-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [935124dd5883b5de68dc5a94f582480a10643dc9]

CVE-2024-42113: net: txgbe: initialize num_q_vectors for MSI/INTx interrupts

Announce: https://lore.kernel.org/linux-cve-announce/2024073022-CVE-2024-42113-be53@gregkh/

Introduced by commit 3f70318 ("net: libwx: Add irq flow functions") in v6.3-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c36711a2cd8059c2d24f5e5c1d76e8ea2d5613c]
stable/6.6: [9edc7a83cd40ac96ff14fe3a17a38f7ace6611df]

CVE-2024-42114: wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM values

Announce: https://lore.kernel.org/linux-cve-announce/2024073022-CVE-2024-42114-4585@gregkh/

Introduced by commit 52539ca ("cfg80211: Expose TXQ stats and
parameters to userspace") in v4.18-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1cba2ea8121e7fdbe1328cea782876b1dd80993]

CVE-2024-42132: bluetooth/hci: disallow setting handle bigger than
HCI_CONN_HANDLE_MAX

Announce: https://lore.kernel.org/linux-cve-announce/2024073028-CVE-2024-42132-49bf@gregkh/

Introduced by commit 181a42e ("Bluetooth: Make handle of hci_conn be
unique") in v6.7-rc1.
Fixed in v6.10-rc7.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [1cc18c2ab2e8c54c355ea7c0423a636e415a0c23]
stable/6.6: [4970e48f83dbd21d2a6a7cdaaafc2a71f7f45dc4]

CVE-2024-42133: Bluetooth: Ignore too large handle values in BIG

Announce: https://lore.kernel.org/linux-cve-announce/2024073028-CVE-2024-42133-07c4@gregkh/

Introduced by commit 181a42e ("Bluetooth: Make handle of hci_conn be
unique") in v6.7-rc1.
Fixed in v6.10-rc7.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [015d79c96d62cd8a4a359fcf5be40d58088c936b]
stable/6.6: [38263088b845abeeeb98dda5b87c0de3063b6dbb]

CVE-2024-42137: Bluetooth: qca: Fix BT enable failure again for
QCA6390 after warm reboot

Announce: https://lore.kernel.org/linux-cve-announce/2024073029-CVE-2024-42137-3637@gregkh/

Introduced by commit 272970b ("Bluetooth: hci_qca: Fix driver shutdown
on closed serdev") in v6.2-rc5.
Fixed in v6.10-rc7.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [88e72239ead9814b886db54fc4ee39ef3c2b8f26]
stable/5.10: [215a26c2404fa34625c725d446967fa328a703eb]
stable/5.15: [4ca6013cd18e58ac1044908c40d4006a92093a11]
stable/6.1: [e6e200b264271f62a3fadb51ada9423015ece37b]
stable/6.6: [e2d8aa4c763593704ac21e7591aed4f13e32f3b5]

CVE-2024-42138: mlxsw: core_linecards: Fix double memory deallocation
in case of invalid INI file

Announce: https://lore.kernel.org/linux-cve-announce/2024073029-CVE-2024-42138-afe8@gregkh/

Introduced by commit b217127 ("mlxsw: core_linecards: Add line card
objects and implement provisioning") in v5.19-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ce34dccbe8fa7d2ef86f2d8e7db2a9b67cabfc3]
stable/6.1: [ab557f5cd993a3201b09593633d04b891263d5c0]
stable/6.6: [f8b55a465b0e8a500179808166fe9420f5c091a1]

CVE-2024-42139: ice: Fix improper extts handling

Announce: https://lore.kernel.org/linux-cve-announce/2024073030-CVE-2024-42139-f8ef@gregkh/

Introduced by commit 172db5f ("ice: add support for auxiliary
input/output pins") in v5.14-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00d3b4f54582d4e4a02cda5886bb336eeab268cc]

CVE-2024-42140: riscv: kexec: Avoid deadlock in kexec crash path

Announce: https://lore.kernel.org/linux-cve-announce/2024073030-CVE-2024-42140-65eb@gregkh/

Introduced by commit b17d19a ("riscv: kexec: Fixup irq controller
broken in kexec crash path") in v6.1-rc8.
Fixed in v6.10-rc7.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [c562ba719df570c986caf0941fea2449150bcbc4]
stable/5.15: [bb80a7911218bbab2a69b5db7d2545643ab0073d]
stable/6.1: [653deee48a4682ea17a05b96fb6842795ab5943c]
stable/6.6: [7692c9b6baacdee378435f58f19baf0eb69e4155]

CVE-2024-42141: Bluetooth: ISO: Check socket flag instead of hcon

Announce: https://lore.kernel.org/linux-cve-announce/2024073030-CVE-2024-42141-9017@gregkh/

Introduced by commit fbdc4bc ("Bluetooth: ISO: Use defer setup to
separate PA sync and BIG sync") in v6.6-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [596b6f081336e77764ca35cfeab66d0fcdbe544e]
stable/6.6: [045669710464a21c67e690ef14698fd71857cb11]

CVE-2024-42142: net/mlx5: E-switch, Create ingress ACL when needed

Announce: https://lore.kernel.org/linux-cve-announce/2024073031-CVE-2024-42142-a3a2@gregkh/

Introduced by commit 1749c4c ("net/mlx5: E-switch, add drop rule
support to ingress ACL") in v5.18-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b20c2fb45470d0c7a603613c9cfa5d45720e17f2]
stable/6.1: [bc3ff8d3c05044de57865ebbb78cca8f7da3e595]
stable/6.6: [3e3551f8702978cd2221d2614ca6d6727e785324]

CVE-2024-42148: bnx2x: Fix multiple UBSAN array-index-out-of-bounds

Announce: https://lore.kernel.org/linux-cve-announce/2024073032-CVE-2024-42148-a8e8@gregkh/

Introduced by commit 50f0a56 ("bnx2x: add fcoe statistics") in v3.3-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [134061163ee5ca4759de5c24ca3bd71608891ba7]
stable/4.19: [cfb04472ce33bee2579caf4dc9f4242522f6e26e]
stable/5.10: [8b17cec33892a66bbd71f8d9a70a45e2072ae84f]
stable/5.15: [0edae06b4c227bcfaf3ce21208d49191e1009d3b]
stable/5.4: [cbe53087026ad929cd3950508397e8892a6a2a0f]
stable/6.1: [9504a1550686f53b0bab4cab31d435383b1ee2ce]
stable/6.6: [f1313ea92f82451923e28ab45a4aaa0e70e80b98]

CVE-2024-42149: fs: don't misleadingly warn during thaw operations

Announce: https://lore.kernel.org/linux-cve-announce/2024073033-CVE-2024-42149-c08b@gregkh/

Introduced by commit 49ef883 ("bdev: implement freeze and thaw holder
operations") in v6.8-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ae4db5647d807efb6a87c09efaa6d1db9c905d7]

CVE-2024-42150: net: txgbe: remove separate irq request for MSI and INTx

Announce: https://lore.kernel.org/linux-cve-announce/2024073033-CVE-2024-42150-6a7d@gregkh/

Introduced by commit aefd013 ("net: txgbe: use irq_domain for
interrupt controller") in v6.9-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd07a98178462e7a02ed2bf7dec90a00944c1da5]

CVE-2024-42153: i2c: pnx: Fix potential deadlock warning from
del_timer_sync() call in isr

Announce: https://lore.kernel.org/linux-cve-announce/2024073034-CVE-2024-42153-c515@gregkh/

Introduced by commit 41561f2 ("i2c: New Philips PNX bus driver") in v2.6.20.16.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f63b94be6942ba82c55343e196bd09b53227618e]
stable/4.19: [a349e5ab4dc9954746e836cd10b407ce48f9b2f6]
stable/5.10: [2849a1b747cf37aa5b684527104d3a53f1e296d2]
stable/5.15: [3503372d0bf7b324ec0bd6b90606703991426176]
stable/5.4: [effe0500afda017a86c94482b1e36bc37586c9af]
stable/6.1: [3d32327f5cfc087ee3922a3bcdcc29880dcdb50f]
stable/6.6: [92e494a7568b60ae80d57fc0deafcaf3a4029ab3]

CVE-2024-42154: tcp_metrics: validate source addr length

Announce: https://lore.kernel.org/linux-cve-announce/2024073034-CVE-2024-42154-cf82@gregkh/

Introduced by commit 3e7013d ("tcp: metrics: Allow selective get/del
of tcp-metrics based on src IP") in v3.14-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66be40e622e177316ae81717aa30057ba9e61dff]
stable/4.19: [19d997b59fa1fd7a02e770ee0881c0652b9c32c9]
stable/5.10: [cdffc358717e436bb67122bb82c1a2a26e050f98]
stable/5.15: [ef7c428b425beeb52b894e16f1c4b629d6cebfb6]
stable/5.4: [2a2e79dbe2236a1289412d2044994f7ab419b44c]
stable/6.1: [31f03bb04146c1c6df6c03e9f45401f5f5a985d3]
stable/6.6: [8c2debdd170e395934ac0e039748576dfde14e99]

CVE-2024-42230: powerpc/pseries: Fix scv instruction crash with kexec

Announce: https://lore.kernel.org/linux-cve-announce/2024073039-CVE-2024-42230-a46d@gregkh/

Introduced by commit 7fa95f9 ("powerpc/64s: system call support for
scv/rfscv instructions") in v5.9-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21a741eb75f80397e5f7d3739e24d7d75e619011]
stable/6.1: [c550679d604798d9fed8a5b2bb5693448a25407c]
stable/6.6: [d10e3c39001e9194b9a1bfd6979bd3fa19dccdc5]

CVE-2024-42231: btrfs: zoned: fix calc_available_free_space() for zoned mode

Announce: https://lore.kernel.org/linux-cve-announce/2024073039-CVE-2024-42231-db41@gregkh/

Introduced by commit cb6cbab ("btrfs: adjust overcommit logic when
very close to full") in v6.7-rc1.
Fixed in v6.10-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64d2c847ba380e07b9072d65a50aa6469d2aa43f]

CVE-2023-52888: media: mediatek: vcodec: Only free buffer VA that is not NULL

Announce: https://lore.kernel.org/linux-cve-announce/2024073015-CVE-2023-52888-51c6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
The h264_enc_free_work_buf() was added by commit 2cc93862d ("[media]
vcodec: mediatek:
Add Mediatek H264 Video Encoder Driver") in 4.8-rc1. The
vdec_av1_slice_free_working_buffer()
was added by commit 2f5d0aef37 ("media: mediatek: vcodec: support
stateless AV1 decoder")
in 6.5-rc1.

Fixed status
mainline: [eb005c801ec70ff4307727bd3bd6e8280169ef32]
stable/6.6: [5c217253c76c94f76d1df31d0bbdcb88dc07be91]

CVE-2024-42103: btrfs: fix adding block group to a reclaim list and
the unused list during reclaim

Announce: https://lore.kernel.org/linux-cve-announce/2024073019-CVE-2024-42103-9e8c@gregkh/

Introduced by commit 4eb4e85 ("btrfs: retry block group reclaim without infinite
loop") in 6.10-rc5. Fixed in 6.10-rc7.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [48f091fd50b2eb33ae5eaea9ed3c4f81603acf38]
stable/5.15: [522b39bd7163e8dc49f8cf10b9b782218ac48746]
stable/6.1: [aa1d8cc0cc500e06b316cd6732d4e6c1388fe33c]
stable/6.6: [f8e960be923f74a273c62478c9cab9523936752b]

CVE-2024-42104: nilfs2: add missing check for inode numbers on directory entries

Announce: https://lore.kernel.org/linux-cve-announce/2024073019-CVE-2024-42104-7aa4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc7.
The nilfs_check_folio() was renamed from nilfs_check_page() by commit
75ad5db66 ("nilfs2: add nilfs_get_folio()") in 6.8-rc1.

Fixed status
mainline: [bb76c6c274683c8570ad788f79d4b875bde0e458]
stable/4.19: [c33c2b0d92aa1c2262d999b2598ad6fbd53bd479]
stable/5.10: [2f2fa9cf7c3537958a82fbe8c8595a5eb0861ad7]
stable/5.15: [b11e8fb93ea5eefb2e4e719497ea177a58ff6131]
stable/5.4: [07c176e7acc5579c133bb923ab21316d192d0a95]
stable/6.1: [1b7d549ed2c1fa202c751b69423a0d3a6bd5a180]
stable/6.6: [3ab40870edb883b9633dc5cd55f5a2a11afa618d]

CVE-2024-42105: nilfs2: fix inode number range checks

Announce: https://lore.kernel.org/linux-cve-announce/2024073020-CVE-2024-42105-276f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc7.

Fixed status
mainline: [e2fec219a36e0993642844be0f345513507031f4]
stable/4.19: [57235c3c88bb430043728d0d02f44a4efe386476]
stable/5.10: [731011ac6c37cbe97ece229fc6daa486276052c5]
stable/5.15: [3be4dcc8d7bea52ea41f87aa4bbf959efe7a5987]
stable/5.4: [08cab183a624ba71603f3754643ae11cab34dbc4]
stable/6.1: [fae1959d6ab2c52677b113935e36ab4e25df37ea]
stable/6.6: [9194f8ca57527958bee207919458e372d638d783]

CVE-2024-42115: jffs2: Fix potential illegal address access in jffs2_free_inode

Announce: https://lore.kernel.org/linux-cve-announce/2024073023-CVE-2024-42115-d99a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.

Fixed status
mainline: [af9a8730ddb6a4b2edd779ccc0aceb994d616830]
stable/4.19: [b6c8b3e31eb88c85094d848a0bd8b4bafe67e4d8]
stable/5.10: [6d6d94287f6365282bbf41e9a5b5281985970789]
stable/5.15: [5ca26334fc8a3711fed14db7f9eb1c621be4df65]
stable/5.4: [0b3246052e01e61a55bb3a15b76acb006759fe67]
stable/6.1: [751987a5d8ead0cc405fad96e83ebbaa51c82dbc]
stable/6.6: [d0bbbf31462a400bef4df33e22de91864f475455]

CVE-2024-42116: igc: fix a log entry using uninitialized netdev

Announce: https://lore.kernel.org/linux-cve-announce/2024073023-CVE-2024-42116-b420@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It seems as if this bug was introduced by commit 3cda505a ("igc: Fix PTP
initialization") in 5.9-rc2.

Fixed status
mainline: [86167183a17e03ec77198897975e9fdfbd53cb0b]
stable/5.15: [96839f3f588236593de36465f142b0126267f8b6]
stable/6.1: [98c8958980e829f023a490b9a9816ca1fe2f8b79]
stable/6.6: [991f036cabc3d13e886a37faeea1b6800181fdda]

CVE-2024-42117: drm/amd/display: ASSERT when failing to find index by
plane/stream id

Announce: https://lore.kernel.org/linux-cve-announce/2024073023-CVE-2024-42117-25fd@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It seems as if this bug was introduced by commit 7966f31 ("drm/amd/display:
Introduce DML2") in 6.7-rc1.

Fixed status
mainline: [01eb50e53c1ce505bf449348d433181310288765]

CVE-2024-42118: drm/amd/display: Do not return negative stream id for array

Announce: https://lore.kernel.org/linux-cve-announce/2024073024-CVE-2024-42118-537b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It seems as if this bug was introduced by commit 5db346c ("drm/amd/display:
update pipe topology log to support subvp") in 6.10-rc1.

Fixed status
mainline: [3ac31c9a707dd1c7c890b95333182f955e9dcb57]

CVE-2024-42119: drm/amd/display: Skip finding free audio for unknown engine_id

Announce: https://lore.kernel.org/linux-cve-announce/2024073024-CVE-2024-42119-abc5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
The id variable was passwd since commit cfb071f7 ("drm/amd/display: try
to find matching audio inst for enc inst first") in 4.15-rc2.

Fixed status
mainline: [1357b2165d9ad94faa4c4a20d5e2ce29c2ff29c3]
stable/4.19: [9eb4db08a808e3a3ba59193aeb84a57a6dc4d8c9]
stable/5.10: [ffa7bd3ca9cfa902b857d1dc9a5f46fededf86c8]
stable/5.15: [afaaebdee9bb9f26d9e13cc34b33bd0a7bf59488]
stable/5.4: [eacca028a623f608607d02457122ee5284491e18]
stable/6.1: [874261358d31fc772f2823604167e670983cc1ca]
stable/6.6: [95ad20ee3c4efbb91f9a4ab08e070aa3697f5879]

CVE-2024-42120: drm/amd/display: Check pipe offset before setting vblank

Announce: https://lore.kernel.org/linux-cve-announce/2024073024-CVE-2024-42120-c2ff@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It looks as if this bug was introduced by commit 667e1498 ("drm/amd/display:
use CRTC_VERTICAL_INTERRUPT0 as VBLANK trigger.") in 4.15-rc1.

Fixed status
mainline: [5396a70e8cf462ec5ccf2dc8de103c79de9489e6]
stable/5.10: [b2e9abc95583ac7bbb2c47da4d476a798146dfd6]
stable/5.15: [0b3702f9d43d163fd05e43b7d7e22e766dbef329]
stable/6.1: [d2c3645a4a5ae5d933b4116c305d9d82b8199dbf]
stable/6.6: [96bf81cc1bd058bb8af6e755a548e926e934dfd1]

CVE-2024-42121: drm/amd/display: Check index msg_id before read or write

Announce: https://lore.kernel.org/linux-cve-announce/2024073024-CVE-2024-42121-2b28@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It seems as if this bug was introduced by commit 4c283fda ("drm/amd/display:
Add HDCP module") in 5.5-rc1.

Fixed status
mainline: [59d99deb330af206a4541db0c4da8f73880fba03]
stable/5.10: [b5b8837d066cc182ff69fb5629ad32ade5484567]
stable/5.15: [fbb0701af9734cff13917a4b98b5ee9da2fde48d]
stable/6.1: [ae91ffbc8b8d942e3e7f188728cad557b7ed5ee4]
stable/6.6: [9933eca6ada0cd612e19522e7a319bcef464c0eb]

CVE-2024-42122: drm/amd/display: Add NULL pointer check for kzalloc

Announce: https://lore.kernel.org/linux-cve-announce/2024073025-CVE-2024-42122-2f70@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.

Fixed status
mainline: [8e65a1b7118acf6af96449e1e66b7adbc9396912]

CVE-2024-42123: drm/amdgpu: fix double free err_addr pointer warnings

Announce: https://lore.kernel.org/linux-cve-announce/2024073025-CVE-2024-42123-056d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It looks as if this bug was introduced by commit 87d2b92f1 ("drm/amdgpu:
save umc error records") in 5.5-rc1.

Fixed status
mainline: [506c245f3f1cd989cb89811a7f06e04ff8813a0d]

CVE-2024-42124: scsi: qedf: Make qedf_execute_tmf() non-preemptible

Announce: https://lore.kernel.org/linux-cve-announce/2024073025-CVE-2024-42124-e4ad@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It looks as if this bug was introduced by commit 61d8658b ("scsi: qedf: Add
QLogic FastLinQ offload FCoE driver framework.") in 4.11-rc1.

Fixed status
mainline: [0d8b637c9c5eeaa1a4e3dfb336f3ff918eb64fec]
stable/5.10: [5ceb40cdee721e13cbe15a0515cacf984e11236b]
stable/5.15: [0a8a91932b2772e75bf3f6d133ca4225d1d3e920]
stable/5.4: [4f314aadeed8cdf42c8cf30769425b5e44702748]
stable/6.1: [fa49c65a1cec6a3901ef884fdb24d98068b63493]
stable/6.6: [b6ded5316ec56e973dcf5f9997945aad01a9f062]

CVE-2024-42125: wifi: rtw89: fw: scan offload prohibit all 6 GHz
channel if no 6 GHz sband

Announce: https://lore.kernel.org/linux-cve-announce/2024073026-CVE-2024-42125-b515@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It looks as if this bug was introduced by commit 4ba24331c
("wifi: rtw89: 8922a: add ieee80211_ops::hw_scan") in 6.9-rc1.

Fixed status
mainline: [bb38626f3f97e16e6d368a9ff6daf320f3fe31d9]

CVE-2024-42126: powerpc: Avoid nmi_enter/nmi_exit in real mode interrupt.

Announce: https://lore.kernel.org/linux-cve-announce/2024073026-CVE-2024-42126-fdab@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
CIP does not support powerpc

Fixed status
mainline: [0db880fc865ffb522141ced4bfa66c12ab1fbb70]
stable/6.1: [8d3f83dfb23674540c827a8d65fba20aa300b252]
stable/6.6: [0f37946c62c48a907625348cbc720a7a0c547d1e]

CVE-2024-42127: drm/lima: fix shared irq handling on driver remove

Announce: https://lore.kernel.org/linux-cve-announce/2024073026-CVE-2024-42127-c29c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It seems as if this bug was introduced by commit a1d2a633 ("drm/lima:
driver for ARM Mali4xx GPUs") in 5.2-rc1.

Fixed status
mainline: [a6683c690bbfd1f371510cb051e8fa49507f3f5e]
stable/5.10: [25d0d9b83d855cbc5d5aa5ae3cd79d55ea0c84a8]
stable/5.15: [17fe8b75aaf0bb1bdc31368963446b421c22d0af]
stable/5.4: [0d60c43df59ef01c08dc7b0c45495178f9d05a13]
stable/6.1: [0a487e977cb8897ae4c51ecd34bbaa2b005266c9]
stable/6.6: [04d531b9a1875846d4f89953b469ad463aa7a770]

CVE-2024-42128: leds: an30259a: Use devm_mutex_init() for mutex initialization

Announce: https://lore.kernel.org/linux-cve-announce/2024073026-CVE-2024-42128-9ac9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It seems as if this bug was introduced by commit 2d00f35c5 ("leds:
add Panasonic AN30259A support") in 4.20-rc1.

Fixed status
mainline: [c382e2e3eccb6b7ca8c7aff5092c1668428e7de6]
stable/6.6: [3ead19aa341de89a8c3d88a091d8093ebea622e8]

CVE-2024-42129: leds: mlxreg: Use devm_mutex_init() for mutex initialization

Announce: https://lore.kernel.org/linux-cve-announce/2024073027-CVE-2024-42129-576e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It seems as if this bug was introduced by commit 386570d7 (" leds:
add driver for support Mellanox regmap LEDs for BMC and x86 platform")
in 4.17-rc1.

Fixed status
mainline: [efc347b9efee1c2b081f5281d33be4559fa50a16]

CVE-2024-42130: nfc/nci: Add the inconsistency check between the input
data length and count

Announce: https://lore.kernel.org/linux-cve-announce/2024073027-CVE-2024-42130-f6ce@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc2.
It seems as if this bug was introduced by commit e624e6c3e77
("nfc: Add a virtual nci device driver") in 5.12-rc1-dontuse.

Fixed status
mainline: [068648aab72c9ba7b0597354ef4d81ffaac7b979]
stable/5.15: [f07bcd8bba803c9e6ad2048543185d6c56587a2f]
stable/6.1: [41f5e2840cd0629f049ce5ce2f8dd10a8299de42]
stable/6.6: [056478b4321b36ca33567089d39ac992f6c9c37a]

CVE-2024-42131: mm: avoid overflows in dirty throttling logic

Announce: https://lore.kernel.org/linux-cve-announce/2024073027-CVE-2024-42131-2f7f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc7.

Fixed status
mainline: [385d838df280eba6c8680f9777bfa0d0bfe7e8b2]
stable/5.10: [7a49389771ae7666f4dc3426e2a4594bf23ae290]
stable/5.15: [a25e8536184516b55ef89ab91dd2eea429de28d2]
stable/6.1: [c83ed422c24f0d4b264f89291d4fabe285f80dbc]
stable/6.6: [bd16a7ee339aef3ee4c90cb23902afb6af379ea0]

CVE-2024-42134: virtio-pci: Check if is_avq is NULL

Announce: https://lore.kernel.org/linux-cve-announce/2024073028-CVE-2024-42134-99d7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It looks as if this bug was introduced by commit fd27ef6b44
("virtio-pci: Introduce admin virtqueue") in 6.8-rc1.

Fixed status
mainline: [c8fae27d141a32a1624d0d0d5419d94252824498]

CVE-2024-42135: vhost_task: Handle SIGKILL by flushing work and exiting

Announce: https://lore.kernel.org/linux-cve-announce/2024073029-CVE-2024-42135-0694@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.

Fixed status
mainline: [db5247d9bf5c6ade9fd70b4e4897441e0269b233]
stable/6.6: [abe067dc3a662eef7d5cddbbc41ed50a0b68b0af]

CVE-2024-42136: cdrom: rearrange last_media_change check to avoid
unintentional overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024073029-CVE-2024-42136-5f6e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It seems as if this bug was introduced by commit 67f1e027c2 ("drivers/cdrom:
improved ioctl for media change detection") in 5.16-rc1.

Fixed status
mainline: [efb905aeb44b0e99c0e6b07865b1885ae0471ebf]
stable/6.1: [0c97527e916054acc4a46ffb02842988acb2e92b]
stable/6.6: [3ee21e14c8c329168a0b66bab00ecd18f5d0dee3]

CVE-2024-42143: orangefs: fix out-of-bounds fsid access

Announce: https://lore.kernel.org/linux-cve-announce/2024073031-CVE-2024-42143-5cec@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It looks as if this bug was introduced by commit 1182fca3 ("Orangefs:
kernel client part 5") in 4.6-rc1.

Fixed status
mainline: [53e4efa470d5fc6a96662d2d3322cfc925818517]
stable/4.19: [b90176a9553775e23966650e445b1866e62e4924]
stable/5.10: [1617249e24bd04c8047956afb43feec4876d1715]
stable/5.15: [137a06dc0ff8b2d2069c2345d015ef0fa71df1ed]
stable/5.4: [556edaa27c27db24a0f34c78cebef90e5bb6e167]
stable/6.1: [74159d409da82269311a60256aad8ae8753da450]
stable/6.6: [6a3cacf6d3cf0278aa90392aef2fc3fe2717a047]

CVE-2024-42144: thermal/drivers/mediatek/lvts_thermal: Check NULL ptr
on lvts_data

Announce: https://lore.kernel.org/linux-cve-announce/2024073031-CVE-2024-42144-f412@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It seems as if this bug was introduced by commit f5f633b18
("thermal/drivers/mediatek:
Add the Low Voltage Thermal Sensor driver") in 6.3-rc1.

Fixed status
mainline: [a1191a77351e25ddf091bb1a231cae12ee598b5d]
stable/6.6: [79ef1a5593fdb8aa4dbccf6085c48f1739338bc9]

CVE-2024-42145: IB/core: Implement a limit on UMAD receive List

Announce: https://lore.kernel.org/linux-cve-announce/2024073032-CVE-2024-42145-5c7b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.

Fixed status
mainline: [ca0b44e20a6f3032224599f02e7c8fb49525c894]
stable/4.19: [1288cf1cceb0e6df276e182f5412370fb4169bcb]
stable/5.10: [62349fbf86b5e13b02721bdadf98c29afd1e7b5f]
stable/5.15: [d73cb8862e4d6760ccc94d3b57b9ef6271400607]
stable/5.4: [b4913702419d064ec4c4bbf7270643c95cc89a1b]
stable/6.1: [63d202d948bb6d3a28cd8e8b96b160fa53e18baa]
stable/6.6: [b8c5f635997f49c625178d1a0cb32a80ed33abe6]

CVE-2024-42146: drm/xe: Add outer runtime_pm protection to
xe_live_ktest@xe_dma_buf

Announce: https://lore.kernel.org/linux-cve-announce/2024073032-CVE-2024-42146-cbd0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It seems as if this bug was introduced by commit dd08ebf ("drm/xe
Introduce a new DRM driver for Intel GPUs") in 6.8-rc1.

Fixed status
mainline: [f9116f658a6217b101e3b4e89f845775b6fb05d9]

CVE-2024-42147: crypto: hisilicon/debugfs - Fix debugfs uninit process issue

Announce: https://lore.kernel.org/linux-cve-announce/2024073032-CVE-2024-42147-805a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It looks as if this bug was introduced by commit 94476b2b6d ("crypto:
hisilicon/qm - split a debugfs.c from qm") in 6.2-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [8be0913389718e8d27c4f1d4537b5e1b99ed7739]
stable/6.1: [eda60520cfe3aba9f088c68ebd5bcbca9fc6ac3c]
stable/6.6: [7fc8d9a525b5c3f8dfa5ed50901e764d8ede7e1e]

CVE-2024-42151: bpf: mark bpf_dummy_struct_ops.test_1 parameter as nullable

Announce: https://lore.kernel.org/linux-cve-announce/2024073033-CVE-2024-42151-b34a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It looks as if this bug was introduced by commit 2cd3e377 ("x86/cfi,bpf:
Fix bpf_struct_ops CFI") in 6.8-rc1.

Fixed status
mainline: [1479eaff1f16983d8fda7c5a08a586c21891087d]

CVE-2024-42152: nvmet: fix a possible leak when destroy a ctrl during
qp establishment

Announce: https://lore.kernel.org/linux-cve-announce/2024073034-CVE-2024-42152-c248@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc2.
It seems as if this bug was intrdocued by commit 0f5be6a4 ("nvmet: update
AEN list and array at one place") in 5.6-rc1.

Fixed status
mainline: [c758b77d4a0a0ed3a1292b3fd7a2aeccd1a169a4]
stable/5.10: [2f3c22b1d3d7e86712253244797a651998c141fa]
stable/5.15: [b4fed1443a6571d49c6ffe7d97af3bbe5ee6dff5]
stable/6.1: [940a71f08ef153ef807f751310b0648d1fa5d0da]
stable/6.6: [5502c1f1d0d7472706cc1f201aecf1c935d302d1]

CVE-2024-42155: s390/pkey: Wipe copies of protected- and secure-keys

Announce: https://lore.kernel.org/linux-cve-announce/2024073035-CVE-2024-42155-5ccb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
CIP does not support s390

Fixed status
mainline: [f2ebdadd85af4f4d0cae1e5d009c70eccc78c207]

CVE-2024-42156: s390/pkey: Wipe copies of clear-key structures on failure

Announce: https://lore.kernel.org/linux-cve-announce/2024073035-CVE-2024-42156-1f82@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
CIP does not support s390

Fixed status
mainline: [d65d76a44ffe74c73298ada25b0f578680576073]

CVE-2024-42157: s390/pkey: Wipe sensitive data on failure

Announce: https://lore.kernel.org/linux-cve-announce/2024073035-CVE-2024-42157-ca67@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
CIP does not support s390

Fixed status
mainline: [1d8c270de5eb74245d72325d285894a577a945d9]
stable/4.19: [6e2e374403bf73140d0efc9541cb1b3bea55ac02]
stable/5.10: [93c034c4314bc4c4450a3869cd5da298502346ad]
stable/5.15: [4889f117755b2f18c23045a0f57977f3ec130581]
stable/5.4: [b5eb9176ebd4697bc248bf8d145e66d782cf5250]
stable/6.1: [c51795885c801b6b7e976717e0d6d45b1e5be0f0]
stable/6.6: [90a01aefb84b09ccb6024d75d85bb8f620bd3487]

CVE-2024-42158: s390/pkey: Use kfree_sensitive() to fix Coccinelle warnings

Announce: https://lore.kernel.org/linux-cve-announce/2024073035-CVE-2024-42158-3d50@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
CIP does not support s390

Fixed status
mainline: [22e6824622e8a8889df0f8fc4ed5aea0e702a694]

CVE-2024-42159: scsi: mpi3mr: Sanitise num_phys

Announce: https://lore.kernel.org/linux-cve-announce/2024073036-CVE-2024-42159-c19e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It looks as if this bug was introduced by commit 42fc9fee ("scsi: mpi3mr:
Add helper functions to manage device's port") in 6.1-rc1.

Fixed status
mainline: [3668651def2c1622904e58b0280ee93121f2b10b]
stable/6.1: [b869ec89d2ee923d46608b76e54c006680c9b4df]
stable/6.6: [586b41060113ae43032ec6c4a16d518cef5da6e0]

CVE-2024-42160: f2fs: check validation of fault attrs in f2fs_build_fault_attr()

Announce: https://lore.kernel.org/linux-cve-announce/2024073036-CVE-2024-42160-c733@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.

Fixed status
mainline: [4ed886b187f47447ad559619c48c086f432d2b77]
stable/6.1: [bc84dd2c33e0c10fd90d60f0cfc0bfb504d4692d]
stable/6.6: [44958ca9e400f57bd0478115519ffc350fcee61e]

CVE-2024-42161: bpf: Avoid uninitialized value in BPF_CORE_READ_BITFIELD

Announce: https://lore.kernel.org/linux-cve-announce/2024073036-CVE-2024-42161-7104@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
Affected file is introduced by commit 7db3822ab9 ("libbpf:
Add BPF_CORE_READ/BPF_CORE_READ_INTO helpers") in 5.5-rc1.

Fixed status
mainline: [009367099eb61a4fc2af44d4eb06b6b4de7de6db]
stable/5.10: [b694989bb13ed5f166e633faa1eb0f21c6d261a6]
stable/5.15: [3364c2ed1c241989847f19cf83e3db903ce689e3]
stable/6.1: [a21d76bd0b0d39518e9a4c19f6cf7c042a974aff]
stable/6.6: [7e5471b5efebc30dd0bc035cda86693a5c73d45f]

CVE-2024-42162: gve: Account for stopped queues when reading NIC stats

Announce: https://lore.kernel.org/linux-cve-announce/2024073037-CVE-2024-42162-ea68@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
Affected file was added by commit e5b845dc79 ("gve: Add ethtool support")
in 5.3-rc1.

Fixed status
mainline: [af9bcf910b1f86244f39e15e701b2dc564b469a6]

CVE-2024-42223: media: dvb-frontends: tda10048: Fix integer overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024073037-CVE-2024-42223-3653@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.

Fixed status
mainline: [1aa1329a67cc214c3b7bd2a14d1301a795760b07]
stable/4.19: [8167e4d7dc086d4f7ca7897dcff3827e4d22c99a]
stable/5.10: [e1ba22618758e95e09c9fd30c69ccce38edf94c0]
stable/5.15: [bd5620439959a7e02012588c724c6ff5143b80af]
stable/5.4: [5c72587d024f087aecec0221eaff2fe850d856ce]
stable/6.1: [1663e2474e4d777187d749a5c90ae83232db32bd]
stable/6.6: [8ac224e9371dc3c4eb666033e6b42d05cf5184a1]

CVE-2024-42224: net: dsa: mv88e6xxx: Correct check for empty list

Announce: https://lore.kernel.org/linux-cve-announce/2024073037-CVE-2024-42224-863a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
According to the commit log this bug was introduced by commit
a3c53be ("net: dsa: mv88e6xxx: Support multiple MDIO busses")
in 4.11-rc1.

Fixed status
mainline: [4c7f3950a9fd53a62b156c0fe7c3a2c43b0ba19b]
stable/4.19: [47d28dde172696031c880c5778633cdca30394ee]
stable/5.10: [2a2fe25a103cef73cde356e6d09da10f607e93f5]
stable/5.15: [8c2c3cca816d074c75a2801d1ca0dea7b0148114]
stable/5.4: [3bf8d70e1455f87856640c3433b3660a31001618]
stable/6.1: [aa03f591ef31ba603a4a99d05d25a0f21ab1cd89]
stable/6.6: [3f25b5f1635449036692a44b771f39f772190c1d]

CVE-2024-42225: wifi: mt76: replace skb_put with skb_put_zero

Announce: https://lore.kernel.org/linux-cve-announce/2024073038-CVE-2024-42225-bdfa@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
The mcu.c was added by commit e57b790146 ("mt76: add mac80211 driver
for MT7915 PCIe-based chipsets") in 5.8-rc1. The mt76_connac_mcu.c
was added by commit d0e274af2f2 ("mt76: mt76_connac: create mcu library")
in 5.12-rc1-dontuse.

Fixed status
mainline: [7f819a2f4fbc510e088b49c79addcf1734503578]
stable/5.15: [dc7f14d00d0c4c21898f3504607f4a31079065a2]
stable/6.1: [22ea2a7f0b64d323625950414a4496520fb33657]
stable/6.6: [ff6b26be13032c5fbd6b6a0b24358f8eaac4f3af]

CVE-2024-42226: usb: xhci: prevent potential failure in
handle_tx_event() for Transfer events without TRB

Announce: https://lore.kernel.org/linux-cve-announce/2024073038-CVE-2024-42226-fa39@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It seems as if this bug was introduced by commit ade2e3a14 ("xhci: handle
transfer events without TRB pointer") in 4.13-rc1.

Fixed status
mainline: [66cb618bf0bb82859875b00eeffaf223557cb416]
stable/6.1: [1f4a10cb826fdec5cd442df010bcb3043bfd6464]
stable/6.6: [69bed24c82139bbad0a78a075e1834a2ea7bd064]

CVE-2024-42227: drm/amd/display: Fix overlapping copy within
dml_core_mode_programming

Announce: https://lore.kernel.org/linux-cve-announce/2024073038-CVE-2024-42227-cdd1@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It looks as if this bug was introduced by commit 7966f319c
("drm/amd/display: Introduce DML2") in 6.7-rc1.

Fixed status
mainline: [f1fd8a0a54e6d23a6d16ee29159f247862460fd1]

CVE-2024-42228: drm/amdgpu: Using uninitialized value *size when
calling amdgpu_vce_cs_reloc

Announce: https://lore.kernel.org/linux-cve-announce/2024073038-CVE-2024-42228-86f5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It looks as if this bug was introduced by commit ("drm/amdgpu:
check VCE relocation buffer range") in 4.2-rc1.

Fixed status
mainline: [88a9a467c548d0b3c7761b4fd54a68e70f9c0944]
stable/6.6: [855ae72c20310e5402b2317fc537d911e87537ef]

CVE-2024-42229: crypto: aead,cipher - zeroize key buffer after use

Announce: https://lore.kernel.org/linux-cve-announce/2024073039-CVE-2024-42229-8a13@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
The kfree_sensitive() was renamed from kzfree() by commit 453431a5
("mm, treewide:
rename kzfree() to kfree_sensitive()") in 5.9-rc1.

Fixed status
mainline: [23e4099bdc3c8381992f9eb975c79196d6755210]
stable/5.10: [9db8c299a521813630fcb4154298cb60c37f3133]
stable/5.15: [71dd428615375e36523f4d4f7685ddd54113646d]
stable/6.1: [28c8d274848feba552e95c5c2a7e3cfe8f15c534]
stable/6.6: [b502d4a08875ea2b4ea5d5b28dc7c991c8b90cfb]

* Updated CVEs

CVE-2024-41012: filelock: Remove locks reliably when fcntl/close race
is detected

stable 6.1 and 6.6 were fixed.

Fixed status
mainline: [3cad1bc010416c6dd780643476bc59ed742436b9]
stable/6.1: [ef8fc41cd6f95f9a4a3470f085aecf350569a0b3]
stable/6.6: [5f5d0799eb0a01d550c21b7894e26b2d9db55763]
stable/6.9: [b6d223942c34057fdfd8f149e763fa823731b224]

CVE-2024-36484: net: relax socket state check at accept time.

stable/4.19, stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/4.19: [7de00adc9bd035d861ba4177848ca0bfa5ed1e04]
stable/5.10: [6e03006548c66b979f4e5e9fc797aac4dad82822]
stable/5.15: [21c14c556cccd0cb54b71ec5e901e64ba84c7165]
stable/5.4: [59801e88c99f7c3f44a4d20af6ba6417aa359b5d]
stable/6.1: [c09ddc605893df542c6cf8dde6a57a93f7cf0adb]
stable/6.6: [87bdc9f6f58b4417362d6932b49b828e319f97dc]
stable/6.9: [5f9a04a94fd1894d7009055ab8e5832a0242dba3]

CVE-2024-36938: bpf, skmsg: Fix NULL pointer dereference in
sk_psock_skb_ingress_enqueue

stable/5.10 was fixed.

Fixed status
stable/5.10: [c0809c128dad4c3413818384eb06a341633db973]
stable/5.15: [5965bc7535fb87510b724e5465ccc1a1cf00916d]
stable/6.1: [39dc9e1442385d6e9be0b6491ee488dddd55ae27]
stable/6.6: [b397a0ab8582c533ec0c6b732392f141fc364f87]

CVE-2024-41009: bpf: Fix overrunning reservations in ringbuf

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [be35504b959f2749bab280f4671e8df96dcf836f]
stable/5.15: [0f98f40eb1ed52af8b81f61901b6c0289ff59de4]
stable/6.1: [d1b9df0435bc61e0b44f578846516df8ef476686]
stable/6.6: [511804ab701c0503b72eac08217eabfd366ba069]
stable/6.9: [47416c852f2a04d348ea66ee451cbdcf8119f225]

CVE-2024-41012: filelock: Remove locks reliably when fcntl/close race
is detected

stable/4.19, stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/4.19: [d30ff33040834c3b9eee29740acd92f9c7ba2250]
stable/5.10: [5661b9c7ec189406c2dde00837aaa4672efb6240]
stable/5.15: [52c87ab18c76c14d7209646ccb3283b3f5d87b22]
stable/5.4: [dc2ce1dfceaa0767211a9d963ddb029ab21c4235]
stable/6.1: [ef8fc41cd6f95f9a4a3470f085aecf350569a0b3]
stable/6.6: [5f5d0799eb0a01d550c21b7894e26b2d9db55763]
stable/6.9: [b6d223942c34057fdfd8f149e763fa823731b224]

CVE-2024-41090: tap: add missing verification for short frame

stable/5.10, stable/5.15, stable/5.4, stable/6.1, stable/6.10,
stable/6.6, stable/6.9 were fixed.

Fixed status
stable/5.10: [7431144b406ae82807eb87d8c98e518475b0450f]
stable/5.15: [e5e5e63c506b93b89b01f522b6a7343585f784e6]
stable/5.4: [8be915fc5ff9a5e296f6538be12ea75a1a93bdea]
stable/6.1: [ee93e6da30377cf2a75e16cd32bb9fcd86a61c46]
stable/6.10: [e1a786b9bbb767fd1c922d424aaa8078cc542309]
stable/6.6: [aa6a5704cab861c9b2ae9f475076e1881e87f5aa]
stable/6.9: [73d462a38d5f782b7c872fe9ae8393d9ef5483da]

CVE-2024-41091: tun: add missing verification for short frame

stable/5.10, stable/5.15, stable/5.4, stable/6.1, stable/6.10,
stable/6.6, stable/6.9 were fixed.

Fixed status
stable/5.10: [6100e0237204890269e3f934acfc50d35fd6f319]
stable/5.15: [589382f50b4a5d90d16d8bc9dcbc0e927a3e39b2]
stable/5.4: [32b0aaba5dbc85816898167d9b5d45a22eae82e9]
stable/6.1: [ad6b3f622ccfb4bfedfa53b6ebd91c3d1d04f146]
stable/6.10: [8418f55302fa1d2eeb73e16e345167e545c598a5]
stable/6.6: [d5ad89b7d01ed4e66fd04734fc63d6e78536692a]
stable/6.9: [a9d1c27e2ee3b0ea5d40c105d6e728fc114470bb]

CVE-2024-41023: sched/deadline: Fix task_struct reference leak

stable/6.10 was fixed.

Fixed status
stable/6.10: [b58652db66c910c2245f5bee7deca41c12d707b9]

CVE-2024-41024: misc: fastrpc: Restrict untrusted app to attach to privileged PD

stable/6.10 was fixed.

Fixed status
stable/6.10: [bab2f5e8fd5d2f759db26b78d9db57412888f187]
stable/6.6: [5e305b5986dc52122a9368a1461f0c13e1de3fd6]

CVE-2024-41025: misc: fastrpc: Fix memory leak in audio daemon attach operation

stable/6.10 was fixed.

Fixed status
stable/6.10: [ad0bd973a033003ca578c42a760d1dc77aeea15e]
stable/6.6: [8b8b82dcf393ceaca8c88939338fd4c30b5b11b2]

CVE-2024-41026: mmc: davinci_mmc: Prevent transmitted data size from
exceeding sgm's length

stable/6.10 was fixed.

Fixed status
stable/6.10: [16198eef11c1929374381d7f6271b4bf6aa44615]

CVE-2024-41027: Fix userfaultfd_api to return EINVAL as expected

stable/6.10 was fixed.

Fixed status
stable/5.15: [519547760f16eae7803d2658d9524bc5ba7a20a7]
stable/6.1: [14875fd5f9bcf60ac5518c63bfb676ade44aa7c6]
stable/6.10: [1723f04caacb32cadc4e063725d836a0c4450694]
stable/6.6: [cd94cac4069a763ab5206be2c64c9a8beae590ba]

CVE-2024-41028: platform/x86: toshiba_acpi: Fix array out-of-bounds access

stable/6.10 was fixed.

Fixed status
stable/6.1: [e030aa6c972641cb069086a8c7a0f747653e472a]
stable/6.10: [b6e02c6b0377d4339986e07aeb696c632cd392aa]
stable/6.6: [639868f1cb87b683cf830353bbee0c4078202313]

CVE-2024-41029: nvmem: core: limit cell sysfs permissions to main attribute ones

stable/6.10 was fixed.

Fixed status
stable/6.10: [6bef98bafd82903a8d461463f9594f19f1fd6a85]

CVE-2024-41031: mm/filemap: skip to create PMD-sized page cache if needed

stable/6.10 was fixed.

Fixed status
stable/6.10: [3390916aca7af1893ed2ebcdfee1d6fdb65bb058]
stable/6.6: [06b5a69c27ec405a3c3f2da8520ff1ee70b94a21]

CVE-2024-41032: mm: vmalloc: check if a hash-index is in cpu_possible_mask

stable/6.10 was fixed.

Fixed status
stable/6.10: [a34acf30b19bc4ee3ba2f1082756ea2604c19138]
stable/6.6: [28acd531c9a365dac01b32e6bc54aed8c1429bcb]

CVE-2024-41033: cachestat: do not flush stats in recency check

stable/6.10 was fixed.

Fixed status
stable/6.10: [5a4d8944d6b1e1aaaa83ea42c116b520b4ed0394]

CVE-2024-41034: nilfs2: fix kernel bug on rename operation of broken directory

stable/6.10 was fixed.

Fixed status
stable/4.19: [ff9767ba2cb949701e45e6e4287f8af82986b703]
stable/5.10: [a9a466a69b85059b341239766a10efdd3ee68a4b]
stable/5.15: [7000b438dda9d0f41a956fc9bffed92d2eb6be0d]
stable/5.4: [24c1c8566a9b6be51f5347be2ea76e25fc82b11e]
stable/6.1: [1a8879c0771a68d70ee2e5e66eea34207e8c6231]
stable/6.10: [a9e1ddc09ca55746079cc479aa3eb6411f0d99d4]
stable/6.6: [60f61514374e4a0c3b65b08c6024dd7e26150bfd]

CVE-2024-41035: USB: core: Fix duplicate endpoint bug by clearing
reserved bits in the descriptor

stable/6.10 was fixed.

Fixed status
stable/4.19: [d8418fd083d1b90a6c007cf8dcf81aeae274727b]
stable/5.10: [d09dd21bb5215d583ca9a1cb1464dbc77a7e88cf]
stable/5.15: [2bd8534a1b83c65702aec3cab164170f8e584188]
stable/5.4: [60abea505b726b38232a0ef410d2bd1994a77f78]
stable/6.1: [9edcf317620d7c6a8354911b69b874cf89716646]
stable/6.10: [a368ecde8a5055b627749b09c6218ef793043e47]
stable/6.6: [647d61aef106dbed9c70447bcddbd4968e67ca64]

CVE-2024-41036: net: ks8851: Fix deadlock with the SPI chip variant

stable/6.10 was fixed.

Fixed status
stable/6.1: [a0c69c492f4a8fad52f0a97565241c926160c9a4]
stable/6.10: [0913ec336a6c0c4a2b296bd9f74f8e41c4c83c8c]
stable/6.6: [80ece00137300d74642f2038c8fe5440deaf9f05]

CVE-2024-41037: ASoC: SOF: Intel: hda: fix null deref on system suspend entry

stable/6.10 was fixed.

Fixed status
stable/6.10: [9065693dcc13f287b9e4991f43aee70cf5538fdd]
stable/6.6: [8246bbf818ed7b8d5afc92b951e6d562b45c2450]

CVE-2024-41038: firmware: cs_dsp: Prevent buffer overrun when
processing V2 alg headers

stable/6.10 was fixed.

Fixed status
stable/6.1: [6619aa48a011364e9f29083cc76368e6acfe5b11]
stable/6.10: [2163aff6bebbb752edf73f79700f5e2095f3559e]
stable/6.6: [76ea8e13aaefdfda6e5601323d6ea5340359dcfa]

CVE-2024-41039: firmware: cs_dsp: Fix overflow checking of wmfw header

stable/6.10 was fixed.

Fixed status
stable/6.1: [fd035f0810b33c2a8792effdb82bf35920221565]
stable/6.10: [3019b86bce16fbb5bc1964f3544d0ce7d0137278]
stable/6.6: [9c9877a96e033bf6c6470b3b4f06106d91ace11e]

CVE-2024-41040: net/sched: Fix UAF when resolving a clash

stable/6.10 was fixed.

Fixed status
stable/5.10: [b81a523d54ea689414f67c9fb81a5b917a41ed55]
stable/5.15: [2b4d68df3f57ea746c430941ba9c03d7d8b5a23f]
stable/6.1: [4e71b10a100861fb27d9c5755dfd68f615629fae]
stable/6.10: [26488172b0292bed837b95a006a3f3431d1898c3]
stable/6.6: [799a34901b634008db4a7ece3900e2b971d4c932]

CVE-2024-41041: udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().

stable/6.10 was fixed.

Fixed status
stable/5.10: [9f965684c57c3117cfd2f754dd3270383c529fba]
stable/5.15: [ddf516e50bf8a7bc9b3bd8a9831f9c7a8131a32a]
stable/5.4: [7a67c4e47626e6daccda62888f8b096abb5d3940]
stable/6.1: [a6db0d3ea6536e7120871e5448b3032570152ec6]
stable/6.10: [5c0b485a8c6116516f33925b9ce5b6104a6eadfd]
stable/6.6: [c5fd77ca13d657c6e99bf04f0917445e6a80231e]

CVE-2024-41042: netfilter: nf_tables: prefer nft_chain_validate

stable/6.10 was fixed.

Fixed status
stable/6.10: [cff3bd012a9512ac5ed858d38e6ed65f6391008c]

CVE-2024-41043: netfilter: nfnetlink_queue: drop bogus WARN_ON

stable/6.10 was fixed.

Fixed status
stable/6.10: [631a4b3ddc7831b20442c59c28b0476d0704c9af]

CVE-2024-41044: ppp: reject claimed-as-LCP but actually malformed packets

stable/6.10 was fixed.

Fixed status
stable/4.19: [97d1efd8be26615ff680cdde86937d5943138f37]
stable/5.10: [3ba12c2afd933fc1bf800f6d3f6c7ec8f602ce56]
stable/5.15: [ebc5c630457783d17d0c438b0ad70b232a64a82f]
stable/5.4: [6e8f1c21174f9482033bbb59f13ce1a8cbe843c3]
stable/6.1: [3134bdf7356ed952dcecb480861d2afcc1e40492]
stable/6.10: [f2aeb7306a898e1cbd03963d376f4b6656ca2b55]
stable/6.6: [099502ca410922b56353ccef2749bc0de669da78]

CVE-2024-41045: bpf: Defer work in bpf_timer_cancel_and_free

stable/6.10 was fixed.

Fixed status
stable/6.10: [a6fcd19d7eac1335eb76bc16b6a66b7f574d1d69]

CVE-2024-41046: net: ethernet: lantiq_etop: fix double free in detach

stable/6.10 was fixed.

Fixed status
stable/4.19: [1a2db00a554cfda57c397cce79b2804bf9633fec]
stable/5.10: [22b16618a80858b3a9d607708444426948cc4ae1]
stable/5.15: [69ad5fa0ce7c548262e0770fc2b726fe7ab4f156]
stable/5.4: [907443174e76b854d28024bd079f0e53b94dc9a1]
stable/6.1: [c2b66e2b3939af63699e4a4bd25a8ac4a9b1d1b3]
stable/6.10: [e1533b6319ab9c3a97dad314dd88b3783bc41b69]
stable/6.6: [9d23909ae041761cb2aa0c3cb1748598d8b6bc54]

CVE-2024-41047: i40e: Fix XDP program unloading while removing the driver

stable/6.10 was fixed.

Fixed status
stable/5.15: [b399a68054dfb36eed121846ef5fcddba40b7740]
stable/6.1: [4bc336b2345f1485438c0eb7246d9c8a8d09f8ff]
stable/6.10: [01fc5142ae6b06b61ed51a624f2732d6525d8ea3]
stable/6.6: [5266302cb2c74d8ab0e9a69d5752fffaea70496e]

CVE-2024-41048: skmsg: Skip zero length skb in sk_msg_recvmsg

stable/6.10 was fixed.

Fixed status
stable/5.15: [195b7bcdfc5adc5b2468f279dd9eb7eebd2e7632]
stable/6.1: [fb61d7b9fb6ef0032de469499a54dab4c7260d0d]
stable/6.10: [f0c18025693707ec344a70b6887f7450bf4c826b]
stable/6.6: [b180739b45a38b4caa88fe16bb5273072e6613dc]

CVE-2024-41049: filelock: fix potential use-after-free in posix_lock_inode

stable/6.10 was fixed.

Fixed status
stable/5.10: [7d4c14f4b511fd4c0dc788084ae59b4656ace58b]
stable/5.15: [02a8964260756c70b20393ad4006948510ac9967]
stable/5.4: [1cbbb3d9475c403ebedc327490c7c2b991398197]
stable/6.1: [5cb36e35bc10ea334810937990c2b9023dacb1b0]
stable/6.10: [1b3ec4f7c03d4b07bad70697d7e2f4088d2cfe92]
stable/6.6: [432b06b69d1d354a171f7499141116536579eb6a]

CVE-2024-41050: cachefiles: cyclic allocation of msg_id to avoid reuse

stable/6.10 was fixed.

Fixed status
stable/6.1: [35710c6c4a1c64478ec1b5e0e81d386c0844dec6]
stable/6.10: [19f4f399091478c95947f6bd7ad61622300c30d9]
stable/6.6: [de045a82e1a4e04be62718d3c2981a55150765a0]

CVE-2024-41051: cachefiles: wait for ondemand_object_worker to finish
when dropping object

stable/6.10 was fixed.

Fixed status
stable/6.1: [ec9289369259d982e735a71437e32e6b4035290c]
stable/6.10: [12e009d60852f7bce0afc373ca0b320f14150418]
stable/6.6: [d3179bae72b1b5e555ba839d6d9f40a350a4d78a]

CVE-2024-41053: scsi: ufs: core: Fix ufshcd_abort_one racing issue

stable/6.10 was fixed.

Fixed status
stable/6.10: [74736103fb4123c71bf11fb7a6abe7c884c5269e]
stable/6.6: [c3111b3cf3889bfa7b73ebff83d7397db9b7e5e0]

CVE-2024-41054: scsi: ufs: core: Fix ufshcd_clear_cmd racing issue

stable/6.10 was fixed.

Fixed status
stable/6.10: [9307a998cb9846a2557fdca286997430bee36a2a]
stable/6.6: [bed0896008334eeee4b4bfd7150491ca098cbf72]

CVE-2024-41055: mm: prevent derefencing NULL ptr in pfn_section_valid()

stable/6.10 was fixed.

Fixed status
stable/5.10: [0100aeb8a12d51950418e685f879cc80cb8e5982]
stable/5.15: [bc17f2377818dca643a74499c3f5333500c90503]
stable/6.1: [941e816185661bf2b44b488565d09444ae316509]
stable/6.10: [82f0b6f041fad768c28b4ad05a683065412c226e]
stable/6.6: [797323d1cf92d09b7a017cfec576d9babf99cde7]

CVE-2024-41056: firmware: cs_dsp: Use strnlen() on name fields in V1 wmfw files

stable/6.10 was fixed.

Fixed status
stable/6.1: [16d76857d6b5426f41b587d0bb925de3f25bfb21]
stable/6.10: [680e126ec0400f6daecf0510c5bb97a55779ff03]
stable/6.6: [392cff2f86a25a4286ff3151c7739143c61c1781]

CVE-2024-41057: cachefiles: fix slab-use-after-free in
cachefiles_withdraw_cookie()

stable/6.10 was fixed.

Fixed status
stable/6.1: [8de253177112a47c9af157d23ae934779188b4e1]
stable/6.10: [5d8f805789072ea7fd39504694b7bd17e5f751c4]
stable/6.6: [9e67589a4a7b7e5660b524d1d5fe61242bcbcc11]

CVE-2024-41058: cachefiles: fix slab-use-after-free in fscache_withdraw_volume()

stable/6.10 was fixed.

Fixed status
stable/6.1: [90f17e47f1e209c6a3c92a1d038a0a80c95c460e]
stable/6.10: [522018a0de6b6fcce60c04f86dfc5f0e4b6a1b36]
stable/6.6: [9dd7f5663899ea13a6a73216106d9c13c37453e3]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

