Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40C1CF648B
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 22:59:41 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20310.1763593180566321444
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Nov 2025 14:59:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=MgDqyAu6;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.177, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-787da30c53dso2609567b3.0
        for <cip-dev@lists.cip-project.org>; Wed, 19 Nov 2025 14:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1763593179; x=1764197979; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DjslKxb47o+A9yJb9nDWgZdudJmw91zdWJlLCN3DQXg=;
        b=MgDqyAu6MiZ3fUqinuN9OwY/dyaN7oRP0Osvom88mrY/dAo1+AlCeKcR1I/CVCdK08
         SuNiM808e6qF4Y737d09c2JZIEzEHGU1wXrgTo34Bv6Nqz3CLKbi5VjK7UHTQfrnPfcR
         ge09V845yEiLm0N6WtjfAEB+Hr9pSAf6+TvzwVdtQksC8moAYLXDGiJBkr2LPmwoxTvw
         XOLaeXYnR3N6n1juOXcICJZ9Ok8fukKICEw5j594a5v6uy3AL1ILVyCfYVrqXWocvjib
         KPfTktXrvHT55kVhf3TgpM6S7m8eumS1vQD3k2rlbUehSP0q7syA9F5pag4shPSpRDiH
         XPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763593179; x=1764197979;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjslKxb47o+A9yJb9nDWgZdudJmw91zdWJlLCN3DQXg=;
        b=vR1Bc+aIOC2nDeXI5YpYSkIvDnfumXJBkb6ZrqoHQT8lr3yaxTXhUFW0xAD5arcpCY
         e9XHycaqXdT+UcBrIBa7h8rhbCVLxTwBR7uidCPlGKHkP9fDwguT8BiWmhWHT+gb4vrP
         E1mdfKHMiDjuv/jtnhJfHYNuv8Q5orh3ocCA4qzI/mrAr/tHM8TNkm4Ol3yOWB/5FOrB
         cq37V1rAF2EQVmYfUGxKp5ABqWjglvZJzDOH5GHxAaXrb163AayYHbtcSYnjIOXeD70w
         jEOeXVmSnHVnWFM2/B3B+W5tIpcPb/q32E/XLK5W90xQ2P8+D3TCOb/rAXpez65guNHf
         uKhg==
X-Gm-Message-State: AOJu0YxVEoqsfmdqzHch+S7ZMGAzAv6ZjHWMWtZCgT4v3Zb2HfUg4ovT
	P52FmGCV85us8zPVYCKql0NlQ1+YlDorKGGN9FGcsVtZ81HPWareVSHAtB012r0fVoqlvMvsADQ
	Ogs7Nvfo+YVGzAEWy7zxIQ0OFKVRwmyxrfBnqXsSUmbUBFI03pnICj54=
X-Gm-Gg: ASbGncupg0x1d22PWafEIGle1n862kSR73wEj8icpSOxT1hgV5ZTyyrnRcHlzIw1l9L
	65DMHCUUTgOAJ+wp7GpUy8OcstDd/M0mgUm20KSkp/DmoIW4N4zlkeGB6vYT5UCwoMmK+fYNfK/
	w8ksT9tfuWzZ3DhrfRqHUdvL0j9NslADumMHzu+3sHGLsUOJKqvj06gbQp4ufE+riMLKTcvgRk3
	QHvOwlXD7k9tfBZzyngjVNp9c8Q/RII1bL9MlIbAl9F+OuH9SBiYsNeK84zdg6qEXGlm+jg
X-Google-Smtp-Source: AGHT+IFmoVh2ObwPbBEHIVo/f04v296/yo11dKtVFOUGadzQsN5FxkIA3ITpzIUF+iQkbjfBWIVMO1TxirNgyt753U8=
X-Received: by 2002:a05:690c:e3ce:b0:788:bda:47d7 with SMTP id
 00721157ae682-78a7ab693afmr4994927b3.20.1763593179190; Wed, 19 Nov 2025
 14:59:39 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 20 Nov 2025 07:59:03 +0900
X-Gm-Features: AWmQ_bmd-azW2md8SnpIJDz6RpRv1OQX2mPI5guu8EJ-L8gJO-Lq8BiLq8c42zU
Message-ID: <CAODzB9pnJbE1Twg11isUOW4gK4BjU4EbJwQQgfNiTRvj=Yrs6w@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Nov 2025 22:59:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20628

Hi!

It's this week's CVE report.

This week reported 31 new CVEs and 0 updated CVEs.

* New CVEs
CVE-2025-40178: pid: Add a judgment for ns null in pid_nr_ns

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40178

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected function was added by 7af5729 ("pid namespaces: helpers to
obtain pid numbers") in v2.6.24-rc1.

Fixed status
mainline: [006568ab4c5ca2309ceb36fa553e390b4aa9c0c7]
stable/5.10: [c2d09d724856b6f82ab688f65fc1ce833bb56333]
stable/5.15: [c3b654021931dc806ba086c549e8756c3f204a67]
stable/5.4: [75dbc029c5359438be4a6f908bfbfdab969af776]
stable/6.1: [e10c36a771c5cc910abd9fe4aa9033ee32a47c38]
stable/6.12: [2076b916bf41be48799d1443df0f8fc75d12ccd0]
stable/6.6: [09d227c59d97efda7d5cc878a4335a6b2bb224c2]

CVE-2025-40179: ext4: verify orphan file size is not too big

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40179

Introduced by commit 02f310f ("ext4: Speedup ext4 orphan inode
handling") in v5.15-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a6ce20c156442a4ce2a404747bb0fb05d54eeb3]
stable/5.15: [95a21611b14ae0a401720645245a8db16f040995]
stable/6.1: [566a1d6084563bd07433025aa23bcea4427de107]
stable/6.12: [a2d803fab8a6c6a874277cb80156dc114db91921]
stable/6.6: [304fc34ff6fc8261138fd81f119e024ac3a129e9]

CVE-2025-40180: mailbox: zynqmp-ipi: Fix out-of-bounds access in
mailbox cleanup loop

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40180

Introduced by commit 4981b82 ("mailbox: ZynqMP IPI mailbox
controller") in v5.1-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0aead8197fc1a85b0a89646e418feb49a564b029]
stable/6.12: [cd0cbf2713f6e027ebba867cb7409ae345a31312]

CVE-2025-40181: x86/kvm: Force legacy PCI hole to UC when overriding
MTRRs for TDX/SNP

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40181

Introduced by commit 8e690b8 ("x86/kvm: Override default caching mode
for SEV-SNP and TDX") in v6.12-rc5.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0dccbc75e18df85399a71933d60b97494110f559]
stable/6.12: [34ff466f74d0fe1db8956f9c245e2bb2c67f67bf]

CVE-2025-40182: crypto: skcipher - Fix reqsize handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40182

Introduced by commit afddce1 ("crypto: api - Add reqsize to
crypto_alg") in v6.16-rc1.
Introduced by commit 52f641b ("crypto: ti - Add driver for DTHE V2 AES
Engine (ECB, CBC)") in v6.18-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [229c586b5e86979badb7cb0d38717b88a9e95ddd]

CVE-2025-40183: bpf: Fix metadata_dst leak __bpf_redirect_neigh_v{4,6}

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40183

Introduced by commit b4ab314 ("bpf: Add redirect_neigh helper as
redirect drop-in") in v5.10-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23f3770e1a53e6c7a553135011f547209e141e72]
stable/5.10: [3fba965a9aac0fa3cbd8138436a37af9ab466d79]
stable/5.15: [057764172fcc6ee2ccb6c41351a55a9f054dc8fd]
stable/6.1: [2e67c2037382abb56497bb9d7b7e10be04eb5598]
stable/6.12: [f36a305d30f557306d87c787ddffe094ac5dac89]
stable/6.6: [b6bfe44b6dbb14a31d86c475cdc9c7689534fb09]

CVE-2025-40184: KVM: arm64: Fix debug checking for np-guests using huge mappings

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40184

Introduced by commit f28f1d0 ("KVM: arm64: Add a range to
__pkvm_host_unshare_guest()") in v6.16-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ba972bf71cb71d2127ec6c3db1ceb6dd0c73173]

CVE-2025-40185: ice: ice_adapter: release xa entry on adapter allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40185

Introduced by commit 0f0023c ("ice: do not init struct ice_adapter
more times than needed") in v6.11-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2db687f3469dbc5c59bc53d55acafd75d530b497]
stable/6.12: [7b9269de9815fc34d93dab90bd5169bacbe78e70]

CVE-2025-40186: tcp: Don't call reqsk_fastopen_remove() in tcp_conn_request().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40186

Introduced by commit 45c8a6c ("tcp: Clear tcp_sk(sk)->fastopen_rsk in
tcp_disconnect().") in v6.17-rc7.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12
stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [2e7cbbbe3d61c63606994b7ff73c72537afe2e1c]
stable/5.10: [ff6a8883f96a5bc74241ce5b3d431a6dcfa2124d]
stable/5.15: [eb85ad5f23268d64b037bfb545cbcba3752f90c7]
stable/5.4: [e359b742eac1eac75cff4e38ee2e8cea492acd9b]
stable/6.1: [643a94b0cf767325e953591c212be2eb826b9d7f]
stable/6.12: [c11ace909e873118295e9eb22dc8c58b0b50eb32]
stable/6.6: [422c1c173c39bbbae1e0eaaf8aefe40b2596233b]

CVE-2025-40187: net/sctp: fix a null dereference in sctp_disposition
sctp_sf_do_5_1D_ce()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40187

Introduced by commit 30f6ebf ("sctp: add SCTP_AUTH_NO_AUTH type for
AUTHENTICATION_EVENT") in v4.17-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f3119686ef50319490ccaec81a575973da98815]
stable/5.10: [7f702f85df0266ed7b5bab81ba50394c92f3c928]
stable/5.15: [dbceedc0213e75bf3e9f9f9e2f66b10699d004fe]
stable/5.4: [1014b83778c8677f1d7a57c26dc728baa801ac62]
stable/6.1: [025419f4e216a3ae0d0cec622262e98e8078c447]
stable/6.12: [d0e8f1445c19b1786759ba72a38267e1449bab7e]
stable/6.6: [c21f45cfa4a9526b34d76b397c9ef080668b6e73]

CVE-2025-40188: pwm: berlin: Fix wrong register in suspend/resume

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40188

Introduced by commit bbf0722 ("pwm: berlin: Add suspend/resume
support") in v4.9-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a4b9d027e4061766f618292df91760ea64a1fcc]
stable/5.10: [5419c86ea134b8a5b8126f55fa5bc1ad7b3ca444]
stable/5.15: [9ee5eb3d09217f115f63b7c102d110ccdb1b26af]
stable/5.4: [da3cadb8b0f35d845b3e2fbb7d978cf6473fd221]
stable/6.1: [fd017aabd4273216ed4223f17991fc087163771f]
stable/6.12: [d9457e6258750692c3b27f80880a613178053c25]
stable/6.6: [dc3a1c6237e7f8046e6d4109bcf1998452ccafad]

CVE-2025-40189: net: usb: lan78xx: Fix lost EEPROM read timeout
error(-ETIMEDOUT) in lan78xx_read_raw_eeprom

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40189

Introduced by commit 8b1b2ca ("net: usb: lan78xx: Improve error
handling in EEPROM and OTP operations") in v6.14-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49bdb63ff64469a6de8ea901aef123c75be9bbe7]

CVE-2025-40190: ext4: guard against EA inode refcount underflow in xattr update

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40190



Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57295e835408d8d425bef58da5253465db3d6888]
stable/5.10: [1cfb3e4ddbdc8e02e637b8852540bd4718bf4814]
stable/5.15: [505e69f76ac497e788f4ea0267826ec7266b40c8]
stable/5.4: [ea39e712c2f5ae148ee5515798ae03523673e002]
stable/6.1: [3d6269028246f4484bfed403c947a114bb583631]
stable/6.12: [6b879c4c6bbaab03c0ad2a983953bd1410bb165e]
stable/6.6: [79ea7f3e11effe1bd9e753172981d9029133a278]

CVE-2025-40191: drm/amdkfd: Fix kfd process ref leaking when userptr unmapping

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40191

Introduced by commit 2d274bf ("amd/amdkfd: Trigger segfault for early
userptr unmmapping") in v6.16-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58e6fc2fb94f0f409447e5d46cf6a417b6397fbc]

CVE-2025-40192: Revert "ipmi: fix msg stack when IPMI is disconnected"

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40192

Introduced commit is not determined.Fixed in v6.18-rc1.
This fix reverts commit c608966 ("ipmi: fix msg stack when IPMI is
disconnected") in v6.2-rc1.

Fixed status
mainline: [5d09ee1bec870263f4ace439402ea840503b503b]
stable/6.12: [b9cc7155e65f6feca51bfedd543b9bd300e2be2b]
stable/6.6: [f4aab940ae9eb3ba32e5332b35703673f00d7f37]

CVE-2025-40193: xtensa: simdisk: add input size check in proc_write_simdisk

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40193

Introduced by commit b6c7e87 ("xtensa: ISS: add host file-based
simulated disk") in v3.9-rc1.
Introduced by commit 16e5c1f ("convert a bunch of open-coded instances
of memdup_user_nul()") in v4.5-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d5f08fd0cd970184376bee07d59f635c8403f63]
stable/6.1: [f40405ccfb87b71175f2d5d004c0b8a0aebcc2cf]
stable/6.12: [d381de7fd4cdc928ede96987dc64b133e6480dd6]
stable/6.6: [151bd88859474cdaccc1e4c8b21fbf72dbba2ab4]

CVE-2025-40194: cpufreq: intel_pstate: Fix object lifecycle issue in
update_qos_request()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40194

Introduced by commit da5c504 ("cpufreq: intel_pstate: Implement QoS
supported freq constraints") in v5.4-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69e5d50fcf4093fb3f9f41c4f931f12c2ca8c467]
stable/5.10: [bc26564bcc659beb6d977cd6eb394041ec2f2851]
stable/5.15: [ad4e8f9bdbef11a19b7cb93e7f313bf59bdcc3b4]
stable/5.4: [15ac9579ebdaf22a37d7f60b3a8efc1029732ef9]
stable/6.1: [0a58d3e77b22b087a57831c87cafd360e144a5bd]
stable/6.12: [ba63d4e9857a72a89e71a4eff9f2cc8c283e94c3]
stable/6.6: [69a18ff6c60e8e113420f15355fad862cb45d38e]

CVE-2025-40195: mount: handle NULL values in mnt_ns_release()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40195

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected function was added by 1901c92 ("fs: keep an index of current
mount namespaces") in v6.11-rc1.

Fixed status
mainline: [6c7ca6a02f8f9549a438a08a23c6327580ecf3d6]
stable/6.12: [2d68f8a7379d9c61005e982600c61948d4d019bd]

CVE-2025-40196: fs: quota: create dedicated workqueue for quota_release_work

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40196

Introduced by commit ac6f420 ("quota: flush quota_release_work upon
quota writeback") in v6.13-rc2.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/5.4 stable/6.1
stable/6.12 stable/6.6

Fixed status
mainline: [72b7ceca857f38a8ca7c5629feffc63769638974]
stable/6.12: [f12039df1515d5daf7d92e586ece5cefeb39561b]
stable/6.6: [f846eacde280ecc3daedfe001580e3033565179e]

CVE-2025-40197: media: mc: Clear minor number before put device

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40197

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [8cfc8cec1b4da88a47c243a11f384baefd092a50]
stable/5.10: [64dbc6f50ce92b7da203b1bcdd96a370bbc9b74d]
stable/5.15: [5d327391f9fafeb0938be4fc538dd0bd54a0b2ef]
stable/5.4: [dd156f44ea82cc249f46c519eed3b2f8983c8002]
stable/6.1: [8f52c7f38f0f2ee2afc331e6b873acba5e9490a8]
stable/6.12: [7db47e737128b3585ae679b709b85f3f44cd8750]
stable/6.6: [7bd4e5367d0940ccec4d7546bb6bd019ab2c71aa]

CVE-2025-40198: ext4: avoid potential buffer over-read in
parse_apply_sb_mount_options()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40198

Introduced by commit 8b67f04 ("ext4: Add mount options in superblock")
in v2.6.36-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ecb790ea8c3fc69e77bace57f14cf0d7c177bd8]
stable/5.10: [b2bac84fde28fb6a88817b8b761abda17a1d300b]
stable/5.4: [7bf46ff83a0ef11836e38ebd72cdc5107209342d]
stable/6.1: [e651294218d2684302ee5ed95ccf381646f3e5b4]
stable/6.12: [2a0cf438320cdb783e0378570744c0ef0d83e934]
stable/6.6: [01829af7656b56d83682b3491265d583d502e502]

CVE-2025-40199: page_pool: Fix PP_MAGIC_MASK to avoid crashing on some
32-bit arches

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40199

Introduced by commit ee62ce7 ("page_pool: Track DMA-mapped pages and
unmap them when destroying the pool") in v6.16-rc1.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [95920c2ed02bde551ab654e9749c2ca7bc3100e0]
stable/6.12: [15b8a5b4cdc16e9a8bb2a548e12a0fd92997605a]

CVE-2025-40200: Squashfs: reject negative file sizes in squashfs_read_inode()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40200

Introduced by commit 6545b24 ("Squashfs: inode operations") in v2.6.29-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f1c14c1de1bdde395f6cc893efa4f80a2ae3b2b]
stable/5.10: [2871c74caa3f4f05b429e6bfefebac62dbf1b408]
stable/5.15: [fbfc745db628de31f5c089147deeb87e95b89e66]
stable/5.4: [54170057a5fadd24a37b70de41e61d39284d9bd7]
stable/6.1: [8118f66124895829443d09c207e654adcb2f9321]
stable/6.12: [875fb3f87ae0225b881319ba016a1a8c4ffd5812]
stable/6.6: [8c7aad76751816207fee556d44aa88a710824810]

CVE-2025-40201: kernel/sys.c: fix the racy usage of
task_lock(tsk->group_leader) in sys_prlimit64() paths

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40201

Introduced by commit 18c91bb ("prlimit: do not grab the
tasklist_lock") in v5.18-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a15f37a40145c986cdf289a4b88390f35efdecc4]
stable/6.1: [1bc0d9315ef5296abb2c9fd840336255850ded18]
stable/6.12: [19b45c84bd9fd42fa97ff80c6350d604cb871c75]
stable/6.6: [132f827e7bac7373e1522e89709d70b43cae5342]

CVE-2025-40202: ipmi: Rework user message limit handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40202

Introduced by commit 8e76741 ("ipmi: Add a limit on the number of
users that may use IPMI") in v5.19-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b52da4054ee0bf9ecb44996f2c83236ff50b3812]
stable/6.1: [f63723ca7d7623f9dae1990973cd158671f03c56]
stable/6.12: [53d6e403affbf6df2c859a0ea00ccfc1e72090ca]
stable/6.6: [348121b29594d42d1635648fd3ed31dfa25351d5]

CVE-2025-40203: listmount: don't call path_put() under namespace semaphore

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40203

Introduced by commit b4c2bea ("add listmount(2) syscall") in v6.8-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1f86d0ac322c7e77f6f8dbd216c65d39358ffc0]
stable/6.12: [659874b7ee4976ad9ce476e07fd36bc67b3537f1]

CVE-2025-40204: sctp: Fix MAC comparison to be constant-time

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40204

Introduced by commit bbd0d59 ("[SCTP]: Implement the receive and
verification of AUTH chunk") in v2.6.24-rc1.
Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd91c79e4f58fbe2898dac84858033700e0e99fb]
stable/5.10: [0e8b8c326c2a6de4d837b1bb034ea704f4690d77]
stable/5.15: [1cd60e0d0fb8f0e62ec4499138afce6342dc9d4c]
stable/5.4: [b93fa8dc521d00d2d44bf034fb90e0d79b036617]
stable/6.1: [9c05d44ec24126fc283835b68f82dba3ae985209]
stable/6.12: [8019b3699289fce3f10b63f98601db97b8d105b0]
stable/6.6: [ed3044b9c810c5c24eb2830053fbfe5fd134c5d4]

CVE-2025-40205: btrfs: avoid potential out-of-bounds in btrfs_encode_fh()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40205

Introduced by commit be6e8dc ("NFS support for btrfs - v3") in v2.6.29-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dff4f9ff5d7f289e4545cc936362e01ed3252742]
stable/5.10: [742b44342204e5dfe3926433823623c1a0c581df]
stable/5.15: [d3a9a8e1275eb9b87f006b5562a287aea3f6885f]
stable/5.4: [60de2f55d2aca53e81b4ef2a67d7cc9e1eb677db]
stable/6.1: [d91f6626133698362bba08fbc04bd72c466806d3]
stable/6.12: [361d67276eb8ec6be8f27f4ad6c6090459438fee]
stable/6.6: [0276c8582488022f057b4cec21975a5edf079f47]

CVE-2025-40206: netfilter: nft_objref: validate objref and objrefmap expressions

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40206

Introduced by commit ee394f9 ("netfilter: nft_synproxy: add synproxy
stateful object support") in v5.4-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f359b809d54c6e3dd1d039b97e0b68390b0e53e4]
stable/6.12: [7ea55a44493a5a36c3b3293b88bbe4841f9dbaf0]
stable/6.6: [0028e0134c64d9ed21728341a74fcfc59cd0f944]

CVE-2025-40207: media: v4l2-subdev: Fix alloc failure check in
v4l2_subdev_call_state_try()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40207

Introduced by commit 982c048 ("media: subdev: Add
v4l2_subdev_call_state_try() macro") in v6.0-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f37df9a0eb5e43fcfe02cbaef076123dc0d79c7e]
stable/6.1: [5b0057459cdc243ffb35617603142dcace09c711]
stable/6.12: [94e6336dc1f06a06f5b4cd04d4a012bba34f2857]
stable/6.6: [ed30811fbed40751deb952bde534aa2632dc0bf7]

CVE-2025-40208: media: iris: fix module removal if firmware download failed

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40208

Introduced by commit d7378f8 ("media: iris: introduce iris core state
management with shared queues") in v6.15-rc1.
Introduced by commit d19b163 ("media: iris: implement video firmware
load/unload") in v6.15-rc1.
Introduced by commit bb8a95a ("media: iris: implement power
management") in v6.15-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fde38008fc4f43db8c17869491870df24b501543]

* Updated CVEs

no update.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

