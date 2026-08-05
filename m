Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0F8C55174
	for <webhook@archiver.kernel.org>; Wed,  5 Aug 2026 22:12:51 +0000 (UTC)
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7049.1785967965373080394
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Aug 2026 15:12:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=K3dIxJpG;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.52, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-668296d0ff3so2098067d50.0
        for <cip-dev@lists.cip-project.org>; Wed, 05 Aug 2026 15:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785967964; cv=none;
        d=google.com; s=arc-20260327;
        b=oG/Rf0DeRXVl0yDoIlQLC3OU/9Bk6SefS9EWshVEgEdydslewbzOywcQO8pT9Kr5f5
         88iJxkKgbckgPzCBOPxjQlClusovvUzGyxT06izm1N1z0QIUm/l5Riw2xnxrbk6K5vcU
         EIHIdUHCscLYT4IWQyUGog7qbg6AMui3aADYoj6Vqpd3hHq++x3Ko8Dr0Qcu0q7K5d+4
         xP3jThdcKiPHk7ajG3ZF6khYURm0yWty4VavM1xBfTHejjA1bbMY4DV2uRDr5Hf/+V16
         czlNvY6EtQvCFt35JVk7CGY9CiL/Bu2yWja74EYpQxRD7WsgOn5Uie9TaCdhMRhnmbAf
         rIYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gYmbI2SIs9c+4Lp9Zp6uwPmw1lB2BfJ/zjO9lShXlIg=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=lWZ4trVv95RdryD3HIxHNU+Q3TTiLB55ydAfgSYpNk9aTZv6Xhr7SjBm5LdOQyernL
         9FicPMkMRVSToQtD7wIMbJcFL0QDJipPAQerUZ1K7/6vM7L9/PIVy4cigPpfzwVMWnmQ
         PZbfYXEfi7oeZm1GKJE0NwZ3aVRGCiAOo2Y9nTd233d2+uqo7QiGR+az5iib6fLTNfP3
         9VbC/lmMAbAkgvrl90g3CCPbPqsEnpF6mvPl411tuOaoC2CltFaHnbLt2m8XOtjn7wEb
         rwjpT7S44oUEcTZ8i9zE86Ktj9YWrMSCPJFoHZG3y/7Wqg88/A0+qNqvp4PpzC+lu/7y
         f4cg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1785967964; x=1786572764; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gYmbI2SIs9c+4Lp9Zp6uwPmw1lB2BfJ/zjO9lShXlIg=;
        b=K3dIxJpGro0l+Ww3KIY5pv43SOHXdeS21LdZdV+fpgevqag0/uhhlyu+vy6sBfwuAm
         tNKQnc3IM5ubgBK3vqTGlgxFIeLtFLPQEv1u+BFCXwOAMCagJupPxgm9UN0RSfuYOrGe
         wOLAdZbJzL3Rvn3tagAu4R3lqKkEghNZibWVWcIYuKyGSs8UPv9nYmXHdmLaUfkB1+8L
         QDEkolLdW7yxtinvjAJyKewpKQfDnWuDGdvBEIgnESzH957xxqZgd0SvrTC6lPYs1RPB
         NX4gh6xpMbL642+9xtZfQi8vVGk+4fHZxnltVByJkVDg+LKuvlPOTPxXLww53xbjz9//
         QVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785967964; x=1786572764;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gYmbI2SIs9c+4Lp9Zp6uwPmw1lB2BfJ/zjO9lShXlIg=;
        b=aBd8h9OMmQzFNzScR8IjgKOn9mjPVz9AyRJI3WMayR7Ibr0Cp1X8raKKWvRGm0h2Hv
         DSP5wEmYQKm2TpUOjDpLiLGJhFX/JS3oNe9VmfwQbYM1dhlI//K1K3VU2ABFxaRu3p2i
         CcAv1l5gfO3B0LHuyzKRGp9OWRpH8Z5imTnyzLKFpv7YbQz6qXg5vYLT2QUjMOqxUVc7
         8lMdM1kz1nX2CDWsr06mrUQZsKes+aFG3EvSumcurD/b2iglDtG0jT+Eloqmj2TFb05Q
         Db262xtfK0kWNnWjYR+XDf1WAPWIs1zG6aXyeLYSbe9yqvXzwO76UDlhx1/ibYceNOdd
         Lt6Q==
X-Gm-Message-State: AOJu0Yzo4g107/tH4NIl6X/qNkXgMDH/64jG1WYYBUf2bizTpNoMzyOh
	riYbOt3wUJ7F5QY4neaCfYU/Sn5HOmWAQdliRIB/zBqtJHtqVgZlupbffP78IjtwqKTHry4Tx+5
	TXarrrElkmddmEyq1LL74LgYpJqNnMATMb3TZGzNMgOOjbwRIxdPPn1qmpg==
X-Gm-Gg: AR+sD11I5eK3GPThZ2zK8vupTeK3S7+n7hHi2dWzYblCL3OOq+brS1PnQybqK/fEMQc
	tGyWqJvk3fhU9kO8y7wdLTJWAY6JtDm4xcDwDejhUsx/JNjh+to9ozO+8RfqORcHdUqpIna4vkc
	gI5BBGTl8hK5E+GVeJvh/DNvxonWppSQdY6zb8NX2IczGBMtA7LYoWXGnNz+9e3LeFTtZR8Qhl5
	NrXe+tkl5Hq0jBEYE0uK5jpwxixPdfPJURV0Bqmwhbp7AOW6wTBSQJxcOeBJLiK3LBRLoYsSx7W
	90CIo40QKrIYL4Kd2SSKGx9VUHeLAvLXTNZyIQPMXd8kQ4awcR+8gh9JHEpuuXkN4CLnoF5mDTr
	f+rV3hoNsrLfA6aEt1Q==
X-Received: by 2002:a05:690e:4804:b0:667:7dae:7809 with SMTP id
 956f58d0204a3-6699a96784bmr5115234d50.21.1785967963899; Wed, 05 Aug 2026
 15:12:43 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 6 Aug 2026 07:12:08 +0900
X-Gm-Features: AUfX_myNsvU0HVtOmYpzw-rOlVmPM0gO8dOXl9rdi5r_ObWFnCpdn7YTNwZn-AI
Message-ID: <CAODzB9qoH429pcuF0ODdxZFTsj2g7KA8zKz3wJKK1mU5s-ULGw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Aug 2026 22:12:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23869

Hi!

It's this week's CVE report.

This week reported 23 new CVEs and 19 updated CVEs.

* New CVEs
CVE-2022-4994: KVM: x86: wean fast IN from emulator_pio_in

Announce: https://www.cve.org/CVERecord?id=CVE-2022-4994

According to the .vulnerable file, this bug was introduced by commit
8370c3d in v4.10-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc7a4bfde507ffe1d8bef49aba1322f1d20c2cb3]

CVE-2026-64561: KVM: x86: Check for invalid/obsolete root *after*
making MMU pages available

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64561

Introduced by commit f95eec9 ("KVM: x86/mmu: Don't put invalid SPs
back on the list of active pages") in v5.9-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2abd5287f08319fa35764566b15c6e22cb1068db]
stable/6.12: [0026dbb7de8ea76e97d6edf42fc3cc084564e2bf]
stable/6.18: [f3477a6a4164f15287444eda685b5f6405dbd1e5]
stable/6.6: [35e77467610c4a37cb0ff54ee56b85f73b1f5700]
stable/7.1: [bce0d3c26e2c761a4bf43c8949f333fc7374eb2d]

CVE-2026-64562: KVM: nVMX: Hide shadow VMCS right after VMCLEAR

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64562

Introduced by commit 355f4fb ("kvm: nVMX: VMCLEAR an active shadow
VMCS after last use") in v4.9-rc4.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [622ebfac01ba4f9c0060cebd41257fe46fc4a0b3]
stable/6.12: [589419470030a89f16cf19300658b6dc644ca946]
stable/6.18: [8001d2ce9d9bd09118ce523aef595aa094573ae3]
stable/6.6: [af56298e9d86e6098cd1d2e155cb2949b7c45412]
stable/7.1: [1dabef6e206568bf9d9ade74f6e56a48ea35695d]

CVE-2026-64563: rhashtable: clear stale iter->p on table restart

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64563

Introduced by commit 5d240a8 ("rhashtable: improve rhashtable_walk
stability when stop/start used.") in v4.18-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8173f7e2ce67e6ca1d4763f3da14e5b01ce77456]
stable/6.18: [3ff7c1dbf722cf3fa538672452ba182318e0fcc3]
stable/7.1: [4169d9fb92f313ff8e7e83d733c1ecdcc93eebd3]

CVE-2026-64564: sctp: don't free the ASCONF's own transport in DEL-IP processing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64564

Introduced by commit 42e30bf ("[SCTP]: Handle the wildcard ADD-IP
Address parameter") in v2.6.25-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b2854f86f0b56e9027d68e7a3fc909d1a9b566f]
stable/6.12: [74e8f3e7114f0e26d1b2c4c048044db9fcc27603]
stable/6.18: [85aca407c560aba81b5ce9d3d6cf94c74077d19b]
stable/6.6: [fedeb4468987bcaff85fe3061de5ae052d414740]
stable/7.1: [d136b29bf91dd8e3161281b87de597b7311d9462]

CVE-2026-64565: Input: ims-pcu - fix heap-buffer-overflow in
ims_pcu_process_data()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64565

Introduced by commit 628329d ("Input: add IMS Passenger Control Unit
driver") in v3.10-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [875115b82c295277b81b6dfee7debc725f44e854]
stable/6.12: [ca9f8c09845fb8c51b6d447f6428eecd1b8b0a49]
stable/6.18: [d03a740e087de7dcb2a26dc1123377bd3d1d84ca]
stable/6.6: [40bbbf2e91fd60715525bf0405c67876af817edf]

CVE-2026-64566: xfrm: iptfs: propagate SKBFL_SHARED_FRAG in
iptfs_skb_add_frags()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64566

Introduced by commit 5f2b6a9 ("xfrm: iptfs: add skb-fragment sharing
code") in v6.14-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [430ea57d6daf765e88f90046afbfd1e071cb7200]
stable/6.18: [d8aaf06b29f5a0b6186cf68d21c7d63678ee3891]
stable/7.1: [ffd64e0717efd83fbf3396ab4e5ac6d795dac4d0]

CVE-2026-64567: btrfs: reject free space cache with more entries than pages

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64567

Introduced by commit 5b0e95b ("Btrfs: inline checksums into the disk
free space cache") in v3.2-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2d8d5647ed854e38f941741aea45b9eb15a6350]
stable/6.12: [404a0b986e0b6e79738fdf1f0ebbbc43b9acd2a2]
stable/6.18: [5e1b2ca6b34939e70fb0785e8222b53cf060016f]
stable/6.6: [33878ba25e2638bc0c61623d7a05c9ca2b74c039]
stable/7.1: [f9fef131fa3f59b857217f522fa5ea430d1b707c]

CVE-2026-64568: wifi: mac80211: fix unsol_bcast_probe_resp double free
on alloc failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64568

Introduced by commit 3b1c256 ("wifi: mac80211: fixes in FILS discovery
updates") in v6.7-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d067abcd37062426c59ec73dbc4e87a63f33fea]
stable/6.12: [ca27a81cd77b698e5eb586a011bee6800c7ee4bd]
stable/6.18: [d62b55b7c7dc62887d7fd5648fb38f0bfaef53ae]
stable/7.1: [0ace76e410d7f7d813b605825a3e593a79c3958f]

CVE-2026-64569: mpls: fix NULL deref in mpls_valid_fib_dump_req() on
CONFIG_INET=n

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64569

Introduced by commit 196cfeb ("net/mpls: Handle kernel side filtering
of route dumps") in v4.20-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56d96fededd61192cd7cc8d2b0f36adfd59036c3]
stable/6.12: [ad6284ced6a15e4abd57ca4d0793b7bd15ca52ce]
stable/6.18: [5f6e7b32bd1fbde10fd31a4143260735ea535b8a]
stable/6.6: [d6eee7cd078aaf9dd75efc801f6c9b608a37cd71]
stable/7.1: [06db79411a280707c7e4bf4b221ff4e664b51502]

CVE-2026-64570: wifi: mac80211: fix fils_discovery double free on alloc failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64570

Introduced by commit 3b1c256 ("wifi: mac80211: fixes in FILS discovery
updates") in v6.7-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [286e52a799fa158bdbd77da1426c4d93f9a6e7ad]
stable/6.12: [e2c55079155a953db669ca1986a985fa286bad95]
stable/6.18: [5baaa1042f71dd4b8e418f2cdd516808702d229b]
stable/7.1: [1981fba71797ec95e6755fb882cad88899a2a84f]

CVE-2026-64571: wifi: p54: validate RX frame length in p54_rx_eeprom_readback()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64571

Introduced by commit 7cb7707 ("p54: move eeprom code into common
library") in v2.6.28-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ebd6d37fa94bee929e0b4c9ca19fdf9b1dcf6cea]
stable/6.12: [f46f8f9c43fd02f4dd5f716d4bda296a523c04f0]
stable/6.18: [d38f5d868a0a4770e3bcd0925e16c46acdbc9509]
stable/6.6: [25c3b85af3fc4f8043159b14e65790fc3bbdaf48]
stable/7.1: [9096e1f7014174067239a63df18ae5f28301990d]

CVE-2026-64572: ipv4: fib: free fib_alias with kfree_rcu() on insert error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64572

Introduced by commit a6c76c1 ("ipv4: Notify route after insertion to
the routing table") in v5.6-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2f152e94a67bc746afaf05a1b2702c195553112]
stable/6.12: [d007056868723de9c0cc3f5ffaad47a8d468b9a4]
stable/6.18: [cb8be318b4432abd88d3172ec157330f27a5f7a7]
stable/6.6: [8150b5365f026e72250cacc527ea00be30f40105]
stable/7.1: [b8d2ea75c76abcd0d72679c2f488271f573e32fb]

CVE-2026-64573: Bluetooth: qca: fix NVM tag length underflow in TLV parser

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64573

Introduced by commit 2e4edfa ("Bluetooth: qca: add missing firmware
sanity checks") in v6.9.
Fixed in v7.2-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [c90164ca0f7036942ba088eb7ea8d3f6c2352020]
stable/6.12: [59fd2f075bca94f030c7c78e94878ea0803d7690]
stable/6.18: [a087ed960fce54e9302796229e9d545bbc9bcd4a]
stable/6.6: [70354dbb5f72d9a76da7b031de3cbaf6c7d8fc24]
stable/7.1: [4fcfb5b2c736785464ff9745f94c6726c5ee2d85]

CVE-2026-64574: wifi: mac80211: tear down new links on vif update error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64574

Introduced by commit 170cd6a ("wifi: mac80211: add netdev per-link
debugfs data and driver hook") in v6.4-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [952c02b33f56207a160421bcd61e7ac53c9c59ae]
stable/6.12: [c57d97f381306bbfba174e8f708419e007824e0c]
stable/6.18: [0f7eaeb950adb77f71beb546e5ab30f90b41fe6f]
stable/6.6: [329589417214d3b7221432e5b266ed2bba7ff674]
stable/7.1: [901a73523e093beff123b54b1ceaf3113f18acc9]

CVE-2026-64575: bpf: tcp: fix double sock release on batch realloc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64575

Introduced by commit cdec67a ("bpf: tcp: Make sure iter->batch always
contains a full bucket snapshot") in v6.17-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [980a813452754f8001704744e92f7aa697c53dd3]
stable/6.18: [9f27c4f0ae35b5390ce4f7a54d3501144e41a54d]
stable/7.1: [8a726e9585ffe7bfbfad2b5279277a00973970f3]

CVE-2026-64576: nexthop: initialize extack in nh_res_bucket_migrate()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64576

Introduced by commit 7c37c7e ("nexthop: Implement notifiers for
resilient nexthop groups") in v5.13-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6347c5314cee49f364aaf2e40ff15415a57a116e]
stable/6.12: [3081702ea5aca0aeed9c1ade8eadf6cde8db6b7d]
stable/6.18: [d536bf205c71f700f6de2086038c3e1d77724715]
stable/6.6: [c0936c131a71657afc635d0db2ab096d15d473e1]
stable/7.1: [18506d7263768d76ac8e057ba55a4d9da50aad66]

CVE-2026-64577: gtp: check skb_pull_data() return in gtp1u_send_echo_resp()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64577

Introduced by commit 9af41cc ("gtp: Implement GTP echo response") in v5.18-rc1.
Fixed in v7.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd170f051dba9ac146fabcd1b91726487c0cb9fa]
stable/6.12: [4fc7923871d176ce0e5fecf4a9b7bb915af790ed]
stable/6.18: [961e9b1e33445f8e42859ecc020c9f60d8b69a8b]
stable/6.6: [b3c733eaae7f362601c28ac1533d47a961cd3e1c]
stable/7.1: [cf45d748e437b8dd2dd987f27ee79c8c86f95c88]

CVE-2026-64578: ksmbd: validate compound request size before reading
StructureSize2

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64578

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15b38176fd1530372905c602fde51fe89ec8c877]
stable/6.12: [f7550a91ab211726f59cb137523b7a9eae1ac6eb]
stable/6.18: [f0e337e7db67cc1c832958bbb6c4026bdceacfdb]
stable/6.6: [2c307126ed8e7adddab82b8e31d962d3a2156ab1]
stable/7.1: [ea128f06d2fb2186f0cac0c9f3e953e4d1f5c29a]

CVE-2026-64579: xfrm: policy: preallocate inexact bins before
xfrm_hash_rebuild reinsert

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64579

Introduced by commit 24969fa ("xfrm: policy: store inexact policies in
an rhashtable") in v5.0-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f38f8cce2f7e79775b3db7e8a5eacda04ac908e4]
stable/6.12: [94c00391a5117530188334f740ce26d3f1256190]
stable/6.18: [7acc5ed2f33608a3d83b64f50a5766843b6e2485]
stable/6.6: [d9d9cc21cc90014724a14c447e3d587be9447107]
stable/7.1: [6aa3796d18a9fda953ad76a62b57bf6c145cb9ef]

CVE-2026-64580: xfrm6: clear dst.dev on error to avoid double
netdev_put in xfrm6_fill_dst()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64580

Introduced by commit 84c4a9d ("xfrm6: release dev before returning
error") in v3.10-rc2.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [136992de9bb91871084ae52d172610541c76e4d2]
stable/6.12: [43de8a49335e611adb271bbd52e84dfbc11fc185]
stable/6.18: [ff636d7b7cba6dea82ecf580415ea57f2c1a11b6]
stable/6.6: [df6856c2dda9187601d29b5fbd7a81b3b178cedf]
stable/7.1: [e078da1b4e11390cff3201c19a9a1fe70c5b934f]

CVE-2026-64581: xfrm: fix sk_dst_cache double-free in xfrm_user_policy()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64581

Introduced by commit 2b06cdf ("xfrm: Clear sk_dst_cache when applying
per-socket policy.") in v4.14-rc8.
Introduced by commit be8f828 ("net: xfrm: allow clearing socket xfrm
policies.") in v4.16-rc1.
Fixed in v7.2-rc4.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [c283e9ada7fcb7dd4b10592623086b2e6d2f9925]
stable/7.1: [96b678d08268b5f5c6fc99d4289d9b7e334fc683]

CVE-2026-64582: RDMA/rxe: Fix a use-after-free problem in rxe_mmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64582

Introduced by commit 8700e3e ("Soft RoCE driver") in v4.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35744ab3d03c5fca8c1752f53fc8fc674e14c561]
stable/6.12: [e038d42cc09ca1da9d3568ce8ae062b2bfb3bc0e]
stable/6.18: [e59a6aa89e0fcd1d0707832eb4654fd9ae7d31e6]
stable/6.6: [665fb7d22a700c66a78db0cf88c6e6a649aba9d0]
stable/7.1: [3525987a392536f31a484833af258971af63b24c]

* Updated CVEs

CVE-2026-64560: posix-cpu-timers: Prevent UAF caused by non-leader exec() race

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.18,
stable/6.6 were fixed.

Fixed status
stable/5.10: [67aa823e3e8c229c6d374df79c804f6721cb83b6]
stable/5.15: [d8bcb28abad857f1415da7656f19b2ada90af04f]
stable/6.1: [cc35ddbc497311e0b6b9a6a6a4f4d1217d6ab1aa]
stable/6.12: [e74443f5db0037c556ef436fa64b88bf4ea08f83]
stable/6.18: [6a7ecc25abe6f0fecc6e62a05096987200edbd02]
stable/6.6: [12a891c773aeb5823d63dbd0cb2ab931d6c21c9b]

CVE-2024-42088: ASoC: mediatek: mt8195: Add platform entry for
ETDM1_OUT_BE dai link

stable/6.6 was fixed.

Fixed status
stable/6.6: [62f61129621ce7e05a6d24584660f79bf081b483]

CVE-2025-38299: ASoC: mediatek: mt8195: Set ETDM1/2 IN/OUT to COMP_DUMMY()

stable/6.6 was fixed.

Fixed status
stable/6.6: [45bd023c7a4ec12059912a631a74723746145e7e]

CVE-2025-39901: i40e: remove read access to debugfs files

stable/6.6 was fixed.

Fixed status
stable/6.6: [ef40d9411469306e524e7887c51b709377e6ef65]

CVE-2025-40098: ALSA: hda: cs35l41: Fix NULL pointer dereference in
cs35l41_get_acpi_mute_state()

stable/6.12 was fixed.

Fixed status
stable/6.12: [19129a365d2bd019fb60662b36b2655931997f12]

CVE-2025-40307: exfat: validate cluster allocation bits of the allocation bitmap

stable/6.6 was fixed.

Fixed status
stable/6.6: [67ce8034dc0278ddd88cad93d4218a945180dddd]

CVE-2025-68299: afs: Fix delayed allocation of a cell's anonymous key

stable/6.12 was fixed.

Fixed status
stable/6.12: [bd18d2cbc9377c6b270c0b7ea44b0e6ed1d99c07]

CVE-2026-45897: netfilter: nft_counter: serialize reset with spinlock

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [48cf7918d10c66cb6b05226fa3fa5daf0c891089]
stable/6.18: [cd968dcdec6aee79a2d399e4f6e0eca63c3b45e1]

CVE-2026-45901: netfilter: nf_tables: revert commit_mutex usage in reset path

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [d66bedfe97a2bc321fa8118e669aae988038f729]
stable/6.18: [f6410d18c1e2da325df02be989d5bca5ed38b086]

CVE-2026-46130: dm-verity-fec: fix reading parity bytes split across
blocks (take 3)

stable/6.18 was fixed.

Fixed status
stable/6.18: [d47281b9a4472cfd73122393e79fbe76b651e46a]

CVE-2026-53078: bpf: Fix same-register dst/src OOB read and pointer
leak in sock_ops

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [2a2c98141e0a75f2d4a7d78b0316c88b3da784ac]
stable/6.18: [22400725de070b787cd6d806c5795370ab46d269]

CVE-2026-53090: bpf: Fix ld_{abs,ind} failure path analysis in subprogs

stable/6.12, stable/6.18, stable/6.6 were fixed.

Fixed status
stable/6.12: [8674e2db06cff6b50f2216eed9a761d15425bb34]
stable/6.18: [ce01a4e5cfac7adbe0be565f90cd32ecbb2f8337]
stable/6.6: [37ad2bb11e9de92cb7b94548705eeedd87f7d392]

CVE-2026-53364: Bluetooth: hci_conn: Fix memory leak in hci_le_big_terminate()

stable/6.12 was fixed.

Fixed status
stable/6.12: [488e808e3fa53200f3ef3324c45fcba4ae9f4972]

CVE-2026-63923: octeontx2-af: validate body pcifunc in
rvu_mbox_handler_rep_event_notify

stable/6.18 was fixed.

Fixed status
stable/6.18: [4467fa514482bbce82f73788943c815f3d126ab3]

CVE-2026-64192: bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF
LSM is uninitialized

stable/6.6 was fixed.

Fixed status
stable/6.6: [5337eebdf8c5d4810b1913047f078d2815d5645f]

CVE-2026-64205: i2c: i801: fix hardware state machine corruption in error path

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [ef5a347532932f58748dad485c15039f5168c377]
stable/6.6: [2ef69871b313aa0f02182795f5e0f5aa455f203c]

CVE-2026-64280: fpga: dfl-afu: validate DMA mapping length in
afu_dma_map_region()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [b50e6cd2395cde615f59b624819998d28c0668d6]
stable/6.6: [16381bda90b261a656ded0568630c1b857b2ebc8]

CVE-2026-64290: iommufd: Break the loop on failure in iommufd_fault_fops_read()

stable/6.12 was fixed.

Fixed status
stable/6.12: [a38e0714affc5c0bbb40cba5a65d6d32a5e72a71]

CVE-2026-64542: ipv6: ndisc: fix NULL deref in accept_untracked_na()

stable/6.6 was fixed.

Fixed status
stable/6.6: [160d3f0d7a556ceae505dcab521a37057b4ce28f]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

