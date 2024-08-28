Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31089C71150
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 22:31:43 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
 by mx.groups.io with SMTP id smtpd.web10.999.1724884295089658755
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Aug 2024 15:31:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=VPtj8S/R;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.44, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5df9dec9c0eso15089eaf.2
        for <cip-dev@lists.cip-project.org>; Wed, 28 Aug 2024 15:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1724884294; x=1725489094; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gHyUt67WjKa9YNIs0boO/P6S3KJiX7cUCm0dx+K69Q8=;
        b=VPtj8S/RNZlYsawQuc0D6YL61f3Iu3UOxcXWAiCtYwAYY884vwCf7GgvthhtnM6s7g
         RoeP803pl8cHL0lro6d2A0dC/sCAtZN2IX4j1m0PugGTa/fYRUF6c9Dif5tgxs7tqkPf
         oQMxjNESY9P9T40EhuSS38Hre8dbztqsvP8hCkXFvm9FBwvA/R2FAGc6ugIR9V19q88X
         I5YLOoIuZA9ses/oyZDCoId0iTsw/IehwlQXZFDgT8MS0HiEwoRR5d3uKGM5LTaDJEaB
         RJAG8tsd8zPWwymAIxlTrN+PHG6lenyIa3y727oGRsNP+kKls89d6nZ3fxtYD5FoDMGr
         Q9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724884294; x=1725489094;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHyUt67WjKa9YNIs0boO/P6S3KJiX7cUCm0dx+K69Q8=;
        b=Uk9Oy52W4j9a53hDw3wL+rMvdal8wI2OgZu3UPp6am7SEWIFUrQZxf2BkkRy+fpMRu
         UsHQBlxD0e1Vpm1t5g6SP8L3dgVqZ6UyM8OaXQOyB2eOvDIDw/SW1HecX8p6G8HP62lr
         dwZPePVjaa9kdjJtQHmVd81RwybVgDmUKRTIbt9p0e6FUaptbuojAe8V0/7WKjwUhN/4
         VRPjwp1XDyF5J6eohhBzPkvmn4fP8LIC08iqI/vW8NYUaG1S5O7vpHyn2Gr+LE4vKxrb
         Ho17DrKWcLkE+WQstUTTB4PrzevtAFTtiS1+hM372L1Yiu7qhI3JfCLGDu9Y5zV3S0NP
         8Dew==
X-Gm-Message-State: AOJu0Yz+VoiSmKd5rKLlxncMtim3cix7LYRqlRmHefwPt/aX+2fDjpMJ
	VKyUm/NQdIem3dYNr7j/BN1sJlaJIS+9Py+I5ubIGQQjEyHSyvqnWj7U4UF4YE+WvG3JX80POwY
	ZiOuo381kcFAAm1Yxtbbf+SjmNLJBvAnSond4pPO5JbJypU9v3K0=
X-Google-Smtp-Source: AGHT+IG5jWQgKY41jwjNljHvW7VfumzwiA0GEXS3uScvn3hq1yK2wSh63wGDncKl1d7vd6m7T50Uuomql+K6NYv58Mc=
X-Received: by 2002:a05:6870:a70d:b0:260:e678:b660 with SMTP id
 586e51a60fabf-277903c5aaemr1015165fac.51.1724884291405; Wed, 28 Aug 2024
 15:31:31 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 29 Aug 2024 07:30:55 +0900
Message-ID: <CAODzB9pV6wf1Pdm3jYcNbjopB-3HzYfRkDLLMyHzLtH0Hcd3RQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Aug 2024 22:31:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16829

Hi!

It's this week's CVE report.

This week reported 90 new CVEs and 1 updated CVEs.

* New CVEs
CVE-2023-52889: apparmor: Fix null pointer deref when receiving skb
during sock creation

Announce: https://lore.kernel.org/linux-cve-announce/2024081739-CVE-2023-52889-cdd0@gregkh/

Introduced by commit ab9f211 ("apparmor: Allow filtering based on
secmark policy") in v4.20-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fce09ea314505a52f2436397608fa0a5d0934fb1]
stable/5.10: [347dcb84a4874b5fb375092c08d8cc4069b94f81]
stable/5.15: [290a6b88e8c19b6636ed1acc733d1458206f7697]
stable/5.4: [0abe35bc48d4ec80424b1f4b3560c0e082cbd5c1]
stable/6.1: [ead2ad1d9f045f26fdce3ef1644913b3a6cd38f2]
stable/6.6: [6c920754f62cefc63fccdc38a062c7c3452e2961]

CVE-2024-42260: drm/v3d: Validate passed in drm syncobj handles in the
performance extension

Announce: https://lore.kernel.org/linux-cve-announce/2024081734-CVE-2024-42260-0ce0@gregkh/

Introduced by commit bae7cb5 ("drm/v3d: Create a CPU job extension for
the reset performance query job") in v6.8-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ecc24a84d7e0254efd150ec23e0b89638386516]

CVE-2024-42261: drm/v3d: Validate passed in drm syncobj handles in the
timestamp extension

Announce: https://lore.kernel.org/linux-cve-announce/2024081736-CVE-2024-42261-f6a2@gregkh/

Introduced by commit 9ba0ff3 ("drm/v3d: Create a CPU job extension for
the timestamp query job") in v6.8-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [023d22e8bb0cdd6900382ad1ed06df3b6c2ea791]

CVE-2024-42262: drm/v3d: Fix potential memory leak in the performance extension

Announce: https://lore.kernel.org/linux-cve-announce/2024081736-CVE-2024-42262-7156@gregkh/

Introduced by commit bae7cb5 ("drm/v3d: Create a CPU job extension for
the reset performance query job") in v6.8-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32df4abc44f24dbec239d43e2b26d5768c5d1a78]

CVE-2024-42263: drm/v3d: Fix potential memory leak in the timestamp extension

Announce: https://lore.kernel.org/linux-cve-announce/2024081737-CVE-2024-42263-31b3@gregkh/

Introduced by commit 9ba0ff3 ("drm/v3d: Create a CPU job extension for
the timestamp query job") in v6.8-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e50fcc20bd87584840266e8004f9064a8985b4f]

CVE-2024-42264: drm/v3d: Prevent out of bounds access in performance
query extensions

Announce: https://lore.kernel.org/linux-cve-announce/2024081737-CVE-2024-42264-5d23@gregkh/

Introduced by commit bae7cb5 ("drm/v3d: Create a CPU job extension for
the reset performance query job") in v6.8-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ce9efd12ae81cf46bf44eb0348594558dfbb9d2]

CVE-2024-42265: protect the fetch of ->fd[fd] in do_dup2() from mispredictions

Announce: https://lore.kernel.org/linux-cve-announce/2024081737-CVE-2024-42265-a943@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc2.
It seems as if all stable kernels are affected.

Fixed status
mainline: [8aa37bde1a7b645816cda8b80df4753ecf172bf1]
stable/4.19: [ed42e8ff509d2a61c6642d1825032072dab79f26]
stable/5.10: [08775b3d6ed117cf4518754ec7300ee42b6a5368]
stable/5.15: [3f480493550b6a23d3a65d095d6569d4a7f56a0f]
stable/5.4: [41a6c31df77bd8e050136b0a200b537da9e1084a]
stable/6.1: [5db999fff545b924b24c9afd368ef5c17279b176]
stable/6.6: [da72e783afd27d9f487836b2e6738146c0edd149]

CVE-2024-42266: btrfs: make cow_file_range_inline() honor locked_page on error

Announce: https://lore.kernel.org/linux-cve-announce/2024081738-CVE-2024-42266-529f@gregkh/

Introduced by commit 0586d0a ("btrfs: move extent bit and page cleanup
into cow_file_range_inline") in v6.10-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [478574370bef7951fbd9ef5155537d6cbed49472]

CVE-2024-42267: riscv/mm: Add handling for VM_FAULT_SIGSEGV in mm_fault_error()

Announce: https://lore.kernel.org/linux-cve-announce/2024081738-CVE-2024-42267-9f79@gregkh/

Introduced by commit 07037db ("RISC-V: Paging and MMU") in v4.15-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c710050c47d45eb77b28c271cddefc5c785cb40]
stable/5.10: [59be4a167782d68e21068a761b90b01fadc09146]
stable/5.15: [20dbdebc5580cd472a310d56a6e252275ee4c864]
stable/6.1: [d7ccf2ca772bfe33e2c53ef80fa20d2d87eb6144]
stable/6.6: [917f598209f3f5e4ab175d5079d8aeb523e58b1f]

CVE-2024-42268: net/mlx5: Fix missing lock on sync reset reload

Announce: https://lore.kernel.org/linux-cve-announce/2024081738-CVE-2024-42268-2084@gregkh/

Introduced by commit 84a433a ("net/mlx5: Lock mlx5 devlink reload
callbacks") in v6.0-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [572f9caa9e7295f8c8822e4122c7ae8f1c412ff9]
stable/6.1: [5d07d1d40aabfd61bab21115639bd4f641db6002]
stable/6.6: [98884e89c90d077f6fe6ba18e6cf6f914642f04e]

CVE-2024-42269: netfilter: iptables: Fix potential null-ptr-deref in
ip6table_nat_table_init().

Announce: https://lore.kernel.org/linux-cve-announce/2024081739-CVE-2024-42269-7d0a@gregkh/

Introduced by commit fdacd57 ("netfilter: x_tables: never register
tables by default") in v5.15-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c22921df777de5606f1047b1345b8d22ef1c0b34]
stable/5.15: [419ee6274c5153b89c4393c1946faa4c3cad4f9e]
stable/6.1: [91b6df6611b7edb28676c4f63f90c56c30d3e601]
stable/6.6: [e85b9b6a87be4cb3710082038b677e97f2389003]

CVE-2024-42270: netfilter: iptables: Fix null-ptr-deref in
iptable_nat_table_init().

Announce: https://lore.kernel.org/linux-cve-announce/2024081739-CVE-2024-42270-c752@gregkh/

Introduced by commit fdacd57 ("netfilter: x_tables: never register
tables by default") in v5.15-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5830aa863981d43560748aa93589c0695191d95d]
stable/5.15: [b98ddb65fa1674b0e6b52de8af9103b63f51b643]
stable/6.1: [95590a4929027769af35b153645c0ab6fd22b29b]
stable/6.6: [70014b73d7539fcbb6b4ff5f37368d7241d8e626]

CVE-2024-42271: net/iucv: fix use after free in iucv_sock_close()

Announce: https://lore.kernel.org/linux-cve-announce/2024081739-CVE-2024-42271-c501@gregkh/

Introduced by commit 7d316b9 ("af_iucv: remove IUCV-pathes
completely") in v3.4-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f558120cd709682b739207b48cf7479fd9568431]
stable/4.19: [84f40b46787ecb67c7ad08a5bb1376141fa10c01]
stable/5.10: [c65f72eec60a34ace031426e04e9aff8e5f04895]
stable/5.15: [ac758e1f663fe9bc64f6b47212a2aa18697524f5]
stable/5.4: [37652fbef9809411cea55ea5fa1a170e299efcd0]
stable/6.1: [8b424c9e44111c5a76f41c6b741f8d4c4179d876]
stable/6.6: [01437282fd3904810603f3dc98d2cac6b8b6fc84]

CVE-2024-42272: sched: act_ct: take care of padding in struct zones_ht_key

Announce: https://lore.kernel.org/linux-cve-announce/2024081739-CVE-2024-42272-c687@gregkh/

Introduced by commit 88c67ae ("sched: act_ct: add netns into the key
of tcf_ct_flow_table") in v6.10-rc5.
Fixed in v6.11-rc2.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [2191a54f63225b548fd8346be3611c3219a24738]
stable/5.10: [7c03ab555eb1ba26c77fd7c25bdf44a0ac23edee]
stable/5.15: [3ddefcb8f75e312535e2e7d5fef9932019ba60f2]
stable/6.1: [d06daf0ad645d9225a3ff6958dd82e1f3988fa64]
stable/6.6: [d7cc186d0973afce0e1237c37f7512c01981fb79]

CVE-2024-42273: f2fs: assign CURSEG_ALL_DATA_ATGC if blkaddr is valid

Announce: https://lore.kernel.org/linux-cve-announce/2024081740-CVE-2024-42273-9b87@gregkh/

Introduced by commit 4961acd ("f2fs: fix to tag gcing flag on page
during block migration") in v6.8-rc1.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [8cb1f4080dd91c6e6b01dbea013a3f42341cb6a1]
stable/6.1: [5fd057160ab240dd816ae09b625395d54c297de1]
stable/6.6: [4239571c5db46a42f723b8fa8394039187c34439]

CVE-2024-42274: Revert "ALSA: firewire-lib: operate for period elapse
event in process context"

Announce: https://lore.kernel.org/linux-cve-announce/2024081740-CVE-2024-42274-9dc6@gregkh/

Introduced by commit 7ba5ca3 ("ALSA: firewire-lib: operate for period
elapse event in process context") in v5.14-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3dab73ab925a51ab05543b491bf17463a48ca323]
stable/5.15: [7c07220cf634002f93a87ca2252a32766850f2d1]
stable/6.1: [b239a37d68e8bc59f9516444da222841e3b13ba9]
stable/6.6: [f5043e69aeb2786f32e84132817a007a6430aa7d]

CVE-2024-42275: drm/client: Fix error code in drm_client_buffer_vmap_local()

Announce: https://lore.kernel.org/linux-cve-announce/2024081740-CVE-2024-42275-8f91@gregkh/

Introduced by commit b4b0193 ("drm/fbdev-generic: Fix locking with
drm_client_buffer_vmap_local()") in v6.10-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5fbf924f125ba3638cfdc21c0515eb7e76264ca]

CVE-2024-42276: nvme-pci: add missing condition check for existence of
mapped data

Announce: https://lore.kernel.org/linux-cve-announce/2024081741-CVE-2024-42276-cb0a@gregkh/

Introduced by commit 4aedb70 ("nvme-pci: split metadata handling from
nvme_map_data / nvme_unmap_data") in v5.2-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c31fad1470389666ac7169fe43aa65bf5b7e2cfd]
stable/5.10: [be23ae63080e0bf9e246ab20207200bca6585eba]
stable/5.15: [7cc1f4cd90a00b6191cb8cda2d1302fdce59361c]
stable/5.4: [3f8ec1d6b0ebd8268307d52be8301973fa5a01ec]
stable/6.1: [d135c3352f7c947a922da93c8e763ee6bc208b64]
stable/6.6: [77848b379e9f85a08048a2c8b3b4a7e8396f5f83]

CVE-2024-42277: iommu: sprd: Avoid NULL deref in sprd_iommu_hw_en

Announce: https://lore.kernel.org/linux-cve-announce/2024081741-CVE-2024-42277-997a@gregkh/

Introduced by commit 9afea57 ("iommu/sprd: Release dma buffer to avoid
memory leak") in v6.4-rc1.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [630482ee0653decf9e2482ac6181897eb6cde5b8]
stable/5.15: [8c79ceb4ecf823e6ec10fee6febb0fca3de79922]
stable/6.1: [dfe90030a0cfa26dca4cb6510de28920e5ad22fb]
stable/6.6: [b62841e49a2b7938f6fdeaaf93fb57e4eb880bdb]

CVE-2024-42278: ASoC: TAS2781: Fix tasdev_load_calibrated_data()

Announce: https://lore.kernel.org/linux-cve-announce/2024081742-CVE-2024-42278-e639@gregkh/

Introduced by commit b195acf ("ASoC: tas2781: Fix wrong loading
calibrated data sequence") in v6.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [92c78222168e9035a9bfb8841c2e56ce23e51f73]
stable/6.6: [6d98741dbd1309a6f2d7cffbb10a8f036ec3ca06]

CVE-2024-42279: spi: microchip-core: ensure TX and RX FIFOs are empty
at start of a transfer

Announce: https://lore.kernel.org/linux-cve-announce/2024081742-CVE-2024-42279-91b0@gregkh/

Introduced by commit 9ac8d17 ("spi: add support for microchip fpga spi
controllers") in v6.0-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cf71eb0faef4bff01df4264841b8465382d7927]
stable/6.6: [3feda3677e8bbe833c3a62a4091377a08f015b80]

CVE-2024-42280: mISDN: Fix a use after free in hfcmulti_tx()

Announce: https://lore.kernel.org/linux-cve-announce/2024081742-CVE-2024-42280-b97c@gregkh/

Introduced by commit af69fb3 ("Add mISDN HFC multiport driver") in v2.6.27-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61ab751451f5ebd0b98e02276a44e23a10110402]
stable/4.19: [70db2c84631f50e02e6b32b543700699dd395803]
stable/5.10: [9460ac3dd1ae033bc2b021a458fb535a0c36ddb2]
stable/5.15: [8f4030277dfb9dbe04fd78566b19931097c9d629]
stable/5.4: [d3e4d4a98c5629ccdcb762a0ff6c82ba9738a0c3]
stable/6.1: [4d8b642985ae24f4b3656438eb8489834a17bb80]
stable/6.6: [ddc79556641ee070d36be0de4a1f0a16a71f1fc7]

CVE-2024-42281: bpf: Fix a segment issue when downgrading gso_size

Announce: https://lore.kernel.org/linux-cve-announce/2024081743-CVE-2024-42281-780b@gregkh/

Introduced by commit 2be7e21 ("bpf: add bpf_skb_adjust_room helper")
in v4.13-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa5ef655615a01533035c6139248c5b33aa27028]
stable/5.10: [dda518dea60d556a2d171c0122ca7d9fdb7d473a]
stable/5.15: [f6bb8c90cab97a3e03f8d30e3069efe6a742e0be]
stable/5.4: [a689f5eb13a90f892a088865478b3cd39f53d5dc]
stable/6.1: [11ec79f5c7f74261874744039bc1551023edd6b2]
stable/6.6: [c3496314c53e7e82ddb544c825defc3e8c0e45cf]

CVE-2024-42282: net: mediatek: Fix potential NULL pointer dereference
in dummy net_device handling

Announce: https://lore.kernel.org/linux-cve-announce/2024081743-CVE-2024-42282-85ea@gregkh/

Introduced by commit b209bd6 ("net: mediatek: mtk_eth_sock: allocate
dummy net_device dynamically") in v6.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16f3a28cf5f876a7f3550d8f4c870a7b41bcfaef]

CVE-2024-42283: net: nexthop: Initialize all fields in dumped nexthops

Announce: https://lore.kernel.org/linux-cve-announce/2024081743-CVE-2024-42283-15a5@gregkh/

Introduced by commit 430a049 ("nexthop: Add support for nexthop
groups") in v5.3-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d745cd0e9720282cd291d36b9db528aea18add2]
stable/5.10: [5cc4d71dda2dd4f1520f40e634a527022e48ccd8]
stable/5.15: [9e8f558a3afe99ce51a642ce0d3637ddc2b5d5d0]
stable/5.4: [fd06cb4a5fc7bda3dea31712618a62af72a1c6cb]
stable/6.1: [1377de719652d868f5317ba8398b7e74c5f0430b]
stable/6.6: [7704460acd7f5d35eb07c52500987dc9b95313fb]

CVE-2024-42284: tipc: Return non-zero value from tipc_udp_addr2str() on error

Announce: https://lore.kernel.org/linux-cve-announce/2024081743-CVE-2024-42284-bbfa@gregkh/

Introduced by commit d0f9193 ("tipc: add ip/udp media type") in v4.1-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa96c6baef1b5385e2f0c0677b32b3839e716076]
stable/4.19: [7ec3335dd89c8d169e9650e4bac64fde71fdf15b]
stable/5.10: [aa38bf74899de07cf70b50cd17f8ad45fb6654c8]
stable/5.15: [5eea127675450583680c8170358bcba43227bd69]
stable/5.4: [253405541be2f15ffebdeac2f4cf4b7e9144d12f]
stable/6.1: [728734352743a78b4c5a7285b282127696a4a813]
stable/6.6: [76ddf84a52f0d8ec3f5db6ccce08faf202a17d28]

CVE-2024-42285: RDMA/iwcm: Fix a use-after-free related to destroying CM IDs

Announce: https://lore.kernel.org/linux-cve-announce/2024081744-CVE-2024-42285-37ec@gregkh/

Introduced by commit 59c68ac ("iw_cm: free cm_id resources on the last
deref") in v4.8-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aee2424246f9f1dadc33faa78990c1e2eb7826e4]
stable/4.19: [d91d253c87fd1efece521ff2612078a35af673c6]
stable/5.10: [94ee7ff99b87435ec63211f632918dc7f44dac79]
stable/5.15: [557d035fe88d78dd51664f4dc0e1896c04c97cf6]
stable/5.4: [7f25f296fc9bd0435be14e89bf657cd615a23574]
stable/6.1: [dc8074b8901caabb97c2d353abd6b4e7fa5a59a5]
stable/6.6: [ff5bbbdee08287d75d72e65b72a2b76d9637892a]

CVE-2024-42286: scsi: qla2xxx: validate nvme_local_port correctly

Announce: https://lore.kernel.org/linux-cve-announce/2024081744-CVE-2024-42286-e856@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit 8777e43 ("scsi:
qla2xxx: Migrate
NVME N2N handling into state machine") in 4.19-rc1.

Fixed status
mainline: [eb1d4ce2609584eeb7694866f34d4b213caa3af9]
stable/4.19: [549aac9655320c9b245a24271b204668c5d40430]
stable/5.10: [a3ab508a4853a9f5ae25a7816a4889f09938f63c]
stable/5.15: [cde43031df533751b4ead37d173922feee2f550f]
stable/5.4: [e1f010844443c389bc552884ac5cfa47de34d54c]
stable/6.1: [7cec2c3bfe84539c415f5e16f989228eba1d2f1e]
stable/6.6: [f6be298cc1042f24d521197af29c7c4eb95af4d5]

CVE-2024-42287: scsi: qla2xxx: Complete command early within lock

Announce: https://lore.kernel.org/linux-cve-announce/2024081744-CVE-2024-42287-d635@gregkh/

Introduced by commit 0367076 ("scsi: qla2xxx: Perform lockless command
completion in abort path") in v6.3-rc4.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [4475afa2646d3fec176fc4d011d3879b26cb26e3]
stable/5.10: [57ba7563712227647f82a92547e82c96cd350553]
stable/5.15: [9117337b04d789bd08fdd9854a40bec2815cd3f6]
stable/5.4: [af46649304b0c9cede4ccfc2be2561ce8ed6a2ea]
stable/6.1: [814f4a53cc86f7ea8b501bfb1723f24fd29ef5ee]
stable/6.6: [314efe3f87949a568f512f05df20bf47b81cf232]

CVE-2024-42288: scsi: qla2xxx: Fix for possible memory corruption

Announce: https://lore.kernel.org/linux-cve-announce/2024081745-CVE-2024-42288-c59b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit 0645cb83 ("scsi: qla2xxx:
Add mode control for each physical port") in 4.20-rc1.

Fixed status
mainline: [c03d740152f78e86945a75b2ad541bf972fab92a]
stable/5.10: [87db8d7b7520e99de71791260989f06f9c94953d]
stable/5.15: [b0302ffc74123b6a99d7d1896fcd9b2e4072d9ce]
stable/5.4: [dae67169cb35a37ecccf60cfcd6bf93a1f4f5efb]
stable/6.1: [2a15b59a2c5afac89696e44acf5bbfc0599c6c5e]
stable/6.6: [571d7f2a08836698c2fb0d792236424575b9829b]

CVE-2024-42289: scsi: qla2xxx: During vport delete send async logout explicitly

Announce: https://lore.kernel.org/linux-cve-announce/2024081745-CVE-2024-42289-fe68@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit efa93f4 ("scsi: qla2xxx:
Fix NPIV deletion by calling wait_for_sess_deletion") in 4.18-rc8.

Fixed status
mainline: [76f480d7c717368f29a3870f7d64471ce0ff8fb2]
stable/4.19: [086489256696eb774654a5410e86381c346356fe]
stable/5.10: [e5ed6a26ffdec0c91cf0b6138afbd675c00ad5fc]
stable/5.15: [b12c54e51ba83c1fbc619d35083d7872e42ecdef]
stable/5.4: [171ac4b495f9473bc134356a00095b47e6409e52]
stable/6.1: [d28a2075bb530489715a3b011e1dd8765ba20313]
stable/6.6: [87c25fcb95aafabb6a4914239f4ab41b07a4f9b7]

CVE-2024-42290: irqchip/imx-irqsteer: Handle runtime power management correctly

Announce: https://lore.kernel.org/linux-cve-announce/2024081745-CVE-2024-42290-c966@gregkh/

Introduced by commit 0136afa ("irqchip: Add driver for imx-irqsteer
controller") in v5.0-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33b1c47d1fc0b5f06a393bb915db85baacba18ea]
stable/5.10: [3a2884a44e5cda192df1b28e9925661f79f599a1]
stable/5.15: [fa1803401e1c360efe6342fb41d161cc51748a11]
stable/5.4: [a590e8dea3df2639921f874d763be961dd74e8f9]
stable/6.1: [58c56735facb225a5c46fa4b8bbbe7f31d1cb894]
stable/6.6: [21bd3f9e7f924cd2fc892a484e7a50c7e1847565]

CVE-2024-42291: ice: Add a per-VF limit on number of FDIR filters

Announce: https://lore.kernel.org/linux-cve-announce/2024081746-CVE-2024-42291-6f31@gregkh/

Introduced by commit 1f7ea1c ("ice: Enable FDIR Configure for AVF") in
v5.13-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ebbe97a488179f5dc85f2f1e0c89b486e99ee97]
stable/6.1: [8e02cd98a6e24389d476e28436d41e620ed8e559]
stable/6.6: [d62389073a5b937413e2d1bc1da06ccff5103c0c]

CVE-2024-42292: kobject_uevent: Fix OOB access within zap_modalias_env()

Announce: https://lore.kernel.org/linux-cve-announce/2024081746-CVE-2024-42292-5387@gregkh/

Introduced by commit 9b3fa47 ("kobject: fix suppressing modalias in
uevents delivered over netlink") in v4.15-rc6.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd6e9894b451e7c85cceb8e9dc5432679a70e7dc]
stable/4.19: [81a15d28f32af01493ae8c5457e0d55314a4167d]
stable/5.10: [648d5490460d38436640da0812bf7f6351c150d2]
stable/5.15: [c5ee8adc8d98a49703320d13878ba2b923b142f5]
stable/5.4: [b59a5e86a3934f1b6a5bd1368902dbc79bdecc90]
stable/6.1: [68d63ace80b76395e7935687ecdb86421adc2168]
stable/6.6: [57fe01d3d04276875c7e3a6dc763517fc05b8762]

CVE-2024-42293: arm64: mm: Fix lockless walks with static and dynamic
page-table folding

Announce: https://lore.kernel.org/linux-cve-announce/2024081746-CVE-2024-42293-0660@gregkh/

Introduced by commit 0dd4f60 ("arm64: mm: Add support for folding PUDs
at runtime") in v6.9-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36639013b3462c06ff8e3400a427f775b4fc97f5]

CVE-2024-42294: block: fix deadlock between sd_remove & sd_release

Announce: https://lore.kernel.org/linux-cve-announce/2024081746-CVE-2024-42294-0145@gregkh/

Introduced by commit eec1be4 ("block: delete partitions later in
del_gendisk") in v6.5-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e04da2dc7013af50ed3a2beb698d5168d1e594b]
stable/6.6: [5a5625a83eac91fdff1d5f0202ecfc45a31983c9]

CVE-2024-42295: nilfs2: handle inconsistent state in nilfs_btnode_create_block()

Announce: https://lore.kernel.org/linux-cve-announce/2024081747-CVE-2024-42295-4f43@gregkh/

Introduced by commit a60be98 ("nilfs2: B-tree node cache") in v2.6.30-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4811f7af6090e8f5a398fbdd766f903ef6c0d787]
stable/4.19: [19cce46238ffe3546e44b9c74057103ff8b24c62]
stable/5.10: [5f0a6800b8aec1b453c7fe4c44fcaac5ffe9d52e]
stable/5.15: [e34191cce3ee63dfa5fb241904aaf2a042d5b6d8]
stable/5.4: [02b87e6334a38c65eef49848d3f1ac422f0b2a44]
stable/6.1: [012be828a118bf496e666ef1fc47fc0e7358ada2]
stable/6.6: [be56dfc9be0604291267c07b0e27a69a6bda4899]

CVE-2024-42296: f2fs: fix return value of f2fs_convert_inline_inode()

Announce: https://lore.kernel.org/linux-cve-announce/2024081747-CVE-2024-42296-3f50@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit ec2ddf4 ("f2fs: don't allow
any writes on readonly mount") in 5.11-rc1.

Fixed status
mainline: [a8eb3de28e7a365690c61161e7a07a4fc7c60bbf]
stable/5.15: [70f5ef5f33c333cfb286116fa3af74ac9bc84f1b]
stable/6.1: [47a8ddcdcaccd9b891db4574795e46a33a121ac2]
stable/6.6: [077f0e24b27c4b44841593c7edbd1993be9eecb5]

CVE-2024-42297: f2fs: fix to don't dirty inode for readonly filesystem

Announce: https://lore.kernel.org/linux-cve-announce/2024081747-CVE-2024-42297-fcec@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
The f2fs_mark_inode_dirty_sync() was introduced by commit b56ab837 ("f2fs:
avoid mark_inode_dirty") in 4.8-rc1. so 4.4 is not affected.

Fixed status
mainline: [192b8fb8d1c8ca3c87366ebbef599fa80bb626b8]
stable/4.19: [2d2916516577f2239b3377d9e8d12da5e6ccdfcf]
stable/5.10: [54bc4e88447e385c4d4ffa85d93e0dce628fcfa6]
stable/5.15: [ec56571b4b146a1cfbedab49d5fcaf19fe8bf4f1]
stable/5.4: [54162974aea37a8cae00742470a78c7f6bd6f915]
stable/6.1: [9ce8135accf103f7333af472709125878704fdd4]
stable/6.6: [e62ff092a42f4a1bae3b310cf46673b4f3aac3b5]

CVE-2024-42298: ASoC: fsl: fsl_qmc_audio: Check devm_kasprintf() returned value

Announce: https://lore.kernel.org/linux-cve-announce/2024081748-CVE-2024-42298-d6a1@gregkh/

Introduced by commit 075c712 ("ASoC: fsl: Add support for QMC audio")
in v6.4-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e62599902327d27687693f6e5253a5d56583db58]
stable/6.6: [b4205dfcfe96182118e54343954827eda51b2135]

CVE-2024-42299: fs/ntfs3: Update log->page_{mask,bits} if log->page_size changed

Announce: https://lore.kernel.org/linux-cve-announce/2024081748-CVE-2024-42299-a588@gregkh/

Introduced by commit b46acd6 ("fs/ntfs3: Add NTFS journal") in v5.15-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2fef55d8f78383c8e6d6d4c014b9597375132696]
stable/5.15: [0484adcb5fbcadd9ba0fd4485c42630f72e97da9]
stable/6.1: [b90ceffdc975502bc085ce8e79c6adeff05f9521]
stable/6.6: [2cac0df3324b5e287d8020bc0708f7d2dec88a6f]

CVE-2024-42300: erofs: fix race in z_erofs_get_gbuf()

Announce: https://lore.kernel.org/linux-cve-announce/2024081748-CVE-2024-42300-0b29@gregkh/

Introduced by commit f36f301 ("erofs: rename per-CPU buffers to global
buffer pool and make it configurable") in v6.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dc5537c3f8be87e005f0844a7626c987914f8fd]

CVE-2024-42301: dev/parport: fix the array out-of-bounds risk

Announce: https://lore.kernel.org/linux-cve-announce/2024081749-CVE-2024-42301-4026@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug is affected to all stable kernels.

Fixed status
mainline: [ab11dac93d2d568d151b1918d7b84c2d02bacbd5]
stable/4.19: [166a0bddcc27de41fe13f861c8348e8e53e988c8]
stable/5.10: [a44f88f7576bc1916d8d6293f5c62fbe7cbe03e0]
stable/5.15: [c719b393374d3763e64900ee19aaed767d5a08d6]
stable/5.4: [47b3dce100778001cd76f7e9188944b5cb27a76d]
stable/6.1: [7f4da759092a1a6ce35fb085182d02de8cc4cc84]
stable/6.6: [b579ea3516c371ecf59d073772bc45dfd28c8a0e]

CVE-2024-42302: PCI/DPC: Fix use-after-free on concurrent DPC and hot-removal

Announce: https://lore.kernel.org/linux-cve-announce/2024081749-CVE-2024-42302-c0d9@gregkh/

Introduced by commit 53b54ad ("PCI/DPC: Await readiness of secondary
bus after reset") in v6.3-rc1.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [11a1f4bc47362700fcbde717292158873fb847ed]
stable/5.10: [c52f9e1a9eb40f13993142c331a6cfd334d4b91d]
stable/5.15: [2c111413f38ca5cf87557cab89f6d82b0e3433e7]
stable/6.1: [f63df70b439bb8331358a306541893bf415bf1da]
stable/6.6: [2cc8973bdc4d6c928ebe38b88090a2cdfe81f42f]

CVE-2024-42303: media: imx-pxp: Fix ERR_PTR dereference in pxp_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024081749-CVE-2024-42303-4d12@gregkh/

Introduced by commit 4e5bd3f ("media: imx-pxp: convert to regmap") in v6.3-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57e9ce68ae98551da9c161aaab12b41fe8601856]
stable/6.6: [358bc85269d6a359fea597ef9fbb429cd3626e08]

CVE-2024-42304: ext4: make sure the first directory block is not a hole

Announce: https://lore.kernel.org/linux-cve-announce/2024081749-CVE-2024-42304-d0e4@gregkh/

Introduced by commit 4e19d6b ("ext4: allow directory holes") in v5.3-rc1.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19

Fixed status
mainline: [f9ca51596bbfd0f9c386dd1c613c394c78d9e5e6]
stable/4.19: [d81d7e347d1f1f48a5634607d39eb90c161c8afe]
stable/5.10: [de2a011a13a46468a6e8259db58b1b62071fe136]
stable/5.15: [9771e3d8365ae1dd5e8846a204cb9af14e3e656a]
stable/5.4: [e02f9941e8c011aa3eafa799def6a134ce06bcfa]
stable/6.1: [b609753cbbd38f8c0affd4956c0af178348523ac]
stable/6.6: [c3893d9de8ee153baac56d127d844103488133b5]

CVE-2024-42305: ext4: check dot and dotdot of dx_root before making dir indexed

Announce: https://lore.kernel.org/linux-cve-announce/2024081750-CVE-2024-42305-94ed@gregkh/

Introduced by commit ac27a0e ("[PATCH] ext4: initial copy of files
from ext3") in v2.6.20.16.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50ea741def587a64e08879ce6c6a30131f7111e7]
stable/4.19: [b80575ffa98b5bb3a5d4d392bfe4c2e03e9557db]
stable/5.10: [42d420517072028fb0eb852c358056b7717ba5aa]
stable/5.15: [8afe06ed3be7a874b3cd82ef5f8959aca8d6429a]
stable/5.4: [19e13b4d7f0303186fcc891aba8d0de7c8fdbda8]
stable/6.1: [abb411ac991810c0bcbe51c2e76d2502bf611b5c]
stable/6.6: [9d241b7a39af192d1bb422714a458982c7cc67a2]

CVE-2024-42306: udf: Avoid using corrupted block bitmap buffer

Announce: https://lore.kernel.org/linux-cve-announce/2024081750-CVE-2024-42306-647c@gregkh/

Introduced by commit 1e0d4ad ("udf: Check consistency of Space Bitmap
Descriptor") in v6.3-rc1.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19 stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [a90d4471146de21745980cba51ce88e7926bcc4f]
stable/5.10: [2199e157a465aaf98294d3932797ecd7fce942d5]
stable/5.15: [6a43e3c210df6c5f00570f4be49a897677dbcb64]
stable/5.4: [cae9e59cc41683408b70b9ab569f8654866ba914]
stable/6.1: [271cab2ca00652bc984e269cf1208699a1e09cdd]
stable/6.6: [57053b3bcf3403b80db6f65aba284d7dfe7326af]

CVE-2024-42307: cifs: fix potential null pointer use in
destroy_workqueue in init_cifs error path

Announce: https://lore.kernel.org/linux-cve-announce/2024081750-CVE-2024-42307-7c2c@gregkh/

Introduced by commit 173217b ("smb3: retrying on failed server close")
in v6.9-rc3.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [193cc89ea0ca1da311877d2b4bb5e9f03bcc82a2]
stable/6.1: [6018971710fdc7739f8655c1540832b4bb903671]
stable/6.6: [160235efb4f9b55212dedff5de0094c606c4b303]

CVE-2024-42308: drm/amd/display: Check for NULL pointer

Announce: https://lore.kernel.org/linux-cve-announce/2024081751-CVE-2024-42308-562d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit 128c075 ("drm/amd/display:
Set flip pending for pipe split") in 5.2-rc1.

Fixed status
mainline: [4ab68e168ae1695f7c04fae98930740aaf7c50fa]
stable/5.10: [9ce89824ff04d261fc855e0ca6e6025251d9fa40]
stable/5.15: [6b5ed0648213e9355cc78f4a264d9afe8536d692]
stable/5.4: [71dbf95359347c2ecc5a6dfc02783fcfccb2e9fb]
stable/6.1: [f068494430d15b5fc551ac928de9dac7e5e27602]
stable/6.6: [4ccd37085976ea5d3c499b1e6d0b3f4deaf2cd5a]

CVE-2024-42309: drm/gma500: fix null pointer dereference in
psb_intel_lvds_get_modes

Announce: https://lore.kernel.org/linux-cve-announce/2024081751-CVE-2024-42309-9560@gregkh/

Introduced by commit 89c7813 ("gma500: Add Poulsbo support") in v3.3-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2df7aac81070987b0f052985856aa325a38debf6]
stable/4.19: [13b5f3ee94bdbdc4b5f40582aab62977905aedee]
stable/5.10: [6735d02ead7dd3adf74eb8b70aebd09e0ce78ec9]
stable/5.15: [7e52c62ff029f95005915c0a11863b5fb5185c8c]
stable/5.4: [d6ad202f73f8edba0cbc0065aa57a79ffe8fdcdc]
stable/6.1: [f70ffeca546452d1acd3a70ada56ecb2f3e7f811]
stable/6.6: [46d2ef272957879cbe30a884574320e7f7d78692]

CVE-2024-42310: drm/gma500: fix null pointer dereference in
cdv_intel_lvds_get_modes

Announce: https://lore.kernel.org/linux-cve-announce/2024081751-CVE-2024-42310-58b0@gregkh/

Introduced by commit 6a227d5 ("gma500: Add support for Cedarview") in v3.3-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb520c3f366c77e8d69e4e2e2781a8ce48d98e79]
stable/4.19: [f392c36cebf4c1d6997a4cc2c0f205254acef42a]
stable/5.10: [b6ac46a00188cde50ffba233e6efb366354a1de5]
stable/5.15: [08f45102c81ad8bc9f85f7a25e9f64e128edb87d]
stable/5.4: [a658ae2173ab74667c009e2550455e6de5b33ddc]
stable/6.1: [e74eb5e8089427c8c49e0dd5067e5f39ce3a4d56]
stable/6.6: [2d209b2f862f6b8bff549ede541590a8d119da23]

CVE-2024-42311: hfs: fix to initialize fields of hfs_inode_info after
hfs_alloc_inode()

Announce: https://lore.kernel.org/linux-cve-announce/2024081752-CVE-2024-42311-f825@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [26a2ed107929a855155429b11e1293b83e6b2a8b]
stable/4.19: [f7316b2b2f11cf0c6de917beee8d3de728be24db]
stable/5.10: [10f7163bfb5f8b4e0c9c05a939f20b8540e33c65]
stable/5.15: [d55aae5c1730d6b70d5d8eaff00113cd34772ea3]
stable/5.4: [4a52861cd76e79f1a593beb23d096523eb9732c2]
stable/6.1: [58d83fc160505a7009c39dec64effaac5129b971]
stable/6.6: [9c4e40b9b731220f9464975e49da75496e3865c4]

CVE-2024-42312: sysctl: always initialize i_uid/i_gid

Announce: https://lore.kernel.org/linux-cve-announce/2024081752-CVE-2024-42312-bddc@gregkh/

Introduced by commit 5ec27ec ("fs/proc/proc_sysctl.c: fix the default
values of i_uid/i_gid on /proc/sys inodes.") in v5.3-rc1.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19

Fixed status
mainline: [98ca62ba9e2be5863c7d069f84f7166b45a5b2f4]
stable/5.10: [b2591c89a6e2858796111138c38fcb6851aa1955]
stable/5.15: [34a86adea1f2b3c3f9d864c8cce09dca644601ab]
stable/6.1: [1deae34db9f4f8e0e03f891be2e2e15c15c8ac05]
stable/6.6: [ffde3af4b29bf97d62d82e1d45275587e10a991a]

CVE-2024-42313: media: venus: fix use after free in vdec_close

Announce: https://lore.kernel.org/linux-cve-announce/2024081752-CVE-2024-42313-09b9@gregkh/

Introduced by commit af2c383 ("[media] media: venus: adding core part
and helper functions") in v4.13-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0157b5aa34eb43ec4c5510f9c260bbb03be937e]
stable/4.19: [ad8cf035baf29467158e0550c7a42b7bb43d1db6]
stable/5.10: [4c9d235630d35db762b85a4149bbb0be9d504c36]
stable/5.15: [f8e9a63b982a8345470c225679af4ba86e4a7282]
stable/5.4: [72aff311194c8ceda934f24fd6f250b8827d7567]
stable/6.1: [da55685247f409bf7f976cc66ba2104df75d8dad]
stable/6.6: [66fa52edd32cdbb675f0803b3c4da10ea19b6635]

CVE-2024-42314: btrfs: fix extent map use-after-free when adding pages
to compressed bio

Announce: https://lore.kernel.org/linux-cve-announce/2024081752-CVE-2024-42314-de1f@gregkh/

Introduced by commit 6a40491 ("btrfs: subpage: make add_ra_bio_pages()
compatible") in v5.16-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e7860543a94784d744c7ce34b78a2e11beefa5c]
stable/6.6: [c205565e0f2f439f278a4a94ee97b67ef7b56ae8]

CVE-2024-42315: exfat: fix potential deadlock on __exfat_get_dentry_set

Announce: https://lore.kernel.org/linux-cve-announce/2024081753-CVE-2024-42315-a707@gregkh/

Introduced by commit a3ff29a ("exfat: support dynamic allocate bh for
exfat_entry_set_cache") in v6.2-rc1.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [89fc548767a2155231128cb98726d6d2ea1256c9]
stable/6.6: [a7ac198f8dba791e3144c4da48a5a9b95773ee4b]

CVE-2024-42316: mm/mglru: fix div-by-zero in vmpressure_calc_level()

Announce: https://lore.kernel.org/linux-cve-announce/2024081753-CVE-2024-42316-8b49@gregkh/

Introduced by commit 359a5e1 ("mm: multi-gen LRU: retry folios written
back while isolated") in v6.1-rc7.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b671fe1a879923ecfb72dda6caf01460dd885ef]
stable/6.1: [8de7bf77f21068a5f602bb1e59adbc5ab533509d]
stable/6.6: [d6510f234c7d117790397f9bb150816b0a954a04]

CVE-2024-42317: mm/huge_memory: avoid PMD-size page cache if needed

Announce: https://lore.kernel.org/linux-cve-announce/2024081753-CVE-2024-42317-cf87@gregkh/

Introduced by commit 6b24ca4 ("mm: Use multi-index entries in the page
cache") in v5.17-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d659b715e94ac039803d7601505d3473393fc0be]

CVE-2024-42318: landlock: Don't lose track of restrictions on cred_transfer

Announce: https://lore.kernel.org/linux-cve-announce/2024081754-CVE-2024-42318-f0c9@gregkh/

Introduced by commit 385975d ("landlock: Set up the security framework
and manage credentials") in v5.13-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39705a6c29f8a2b93cf5b99528a55366c50014d1]
stable/5.15: [916c648323fa53b89eedb34a0988ddaf01406117]
stable/6.1: [0d74fd54db0bd0c0c224bef0da8fc95ea9c9f36c]
stable/6.6: [16896914bace82d7811c62f3b6d5320132384f49]

CVE-2024-42319: mailbox: mtk-cmdq: Move
devm_mbox_controller_register() after devm_pm_runtime_enable()

Announce: https://lore.kernel.org/linux-cve-announce/2024081754-CVE-2024-42319-ec7c@gregkh/

Introduced by commit 623a614 ("mailbox: mediatek: Add Mediatek CMDQ
driver") in v4.19-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a8bd68e4329f9a0ad1b878733e0f80be6a971649]

CVE-2024-42320: s390/dasd: fix error checks in dasd_copy_pair_store()

Announce: https://lore.kernel.org/linux-cve-announce/2024081754-CVE-2024-42320-cdea@gregkh/

Introduced by commit a91ff09 ("s390/dasd: add copy pair setup") in v6.1-rc1.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [8e64d2356cbc800b4cd0e3e614797f76bcf0cdb8]
stable/6.1: [cc8b7284d5076722e0b8062373b68d8e47c3bace]
stable/6.6: [e511167e65d332d07b3c7a3d5a741ee9c19a8c27]

CVE-2024-42321: net: flow_dissector: use DEBUG_NET_WARN_ON_ONCE

Announce: https://lore.kernel.org/linux-cve-announce/2024081755-CVE-2024-42321-4b46@gregkh/

Introduced by commit 9b52e3f ("flow_dissector: handle no-skb use
case") in v5.2-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [120f1c857a73e52132e473dee89b340440cb692b]
stable/6.1: [eb03d9826aa646577342a952d658d4598381c035]
stable/6.6: [4afbac11f2f629d1e62817c4e210bdfaa7521107]

CVE-2024-42322: ipvs: properly dereference pe in ip_vs_add_service

Announce: https://lore.kernel.org/linux-cve-announce/2024081755-CVE-2024-42322-e2ef@gregkh/

Introduced by commit 39b9722 ("ipvs: handle connections started by
real-servers") in v4.7-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbd070a4ae62f119058973f6d2c984e325bce6e7]
stable/6.6: [3dd428039e06e1967ce294e2cd6342825aaaad77]

CVE-2024-43815: crypto: mxs-dcp - Ensure payload is zero when using key slot

Announce: https://lore.kernel.org/linux-cve-announce/2024081720-CVE-2024-43815-38e7@gregkh/

Introduced by commit 3d16af0 ("crypto: mxs-dcp: Add support for
hardware-bound keys") in v6.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd52b5eeb0f70893f762da7254e923fd23fd1379]

CVE-2024-43816: scsi: lpfc: Revise lpfc_prep_embed_io routine with
proper endian macro usages

Announce: https://lore.kernel.org/linux-cve-announce/2024081723-CVE-2024-43816-293f@gregkh/

Introduced by commit af20bb7 ("scsi: lpfc: Add support for 32 byte
CDBs") in v6.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bc7c617642db6d8d20ee671fb6c4513017e7a7e]

CVE-2024-43817: net: missing check virtio

Announce: https://lore.kernel.org/linux-cve-announce/2024081723-CVE-2024-43817-2e95@gregkh/

Introduced by commit 0f6925b ("virtio_net: Do not pull payload in
skb->head") in v5.12-rc7.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10 stable/5.4

Fixed status
mainline: [e269d79c7d35aa3808b1f3c1737d63dab504ddc8]
stable/5.15: [27874ca77bd2b05a3779c7b3a5c75d8dd7f0b40f]
stable/6.1: [5b1997487a3f3373b0f580c8a20b56c1b64b0775]
stable/6.6: [90d41ebe0cd4635f6410471efc1dd71b33e894cf]

CVE-2024-43818: ASoC: amd: Adjust error handling in case of absent codec device

Announce: https://lore.kernel.org/linux-cve-announce/2024081723-CVE-2024-43818-71ec@gregkh/

Introduced by commit 02527c3 ("ASoC: amd: add Machine driver for
Jadeite platform") in v6.0-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5080808c3339de2220c602ab7c7fa23dc6c1a5a3]
stable/6.1: [1ba9856cf7f6492b47c1edf853137f320d583db5]
stable/6.6: [99b642dac24f6d09ba3ebf1d690be8aefff86164]

CVE-2024-43819: kvm: s390: Reject memory region operations for ucontrol VMs

Announce: https://lore.kernel.org/linux-cve-announce/2024081723-CVE-2024-43819-88ce@gregkh/

Introduced by commit 27e0393 ("KVM: s390: ucontrol: per vcpu address
spaces") in v3.4-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7816e58967d0e6cadce05c8540b47ed027dc2499]

CVE-2024-43820: dm-raid: Fix WARN_ON_ONCE check for sync_thread in raid_resume

Announce: https://lore.kernel.org/linux-cve-announce/2024081724-CVE-2024-43820-1bd6@gregkh/

Introduced by commit 16c4770 ("dm-raid: really frozen sync_thread
during suspend") in v6.9-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3199a34bfaf7561410e0be1e33a61eba870768fc]

CVE-2024-43821: scsi: lpfc: Fix a possible null pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024081724-CVE-2024-43821-6ffc@gregkh/

Introduced by commit 479b091 ("scsi: lpfc: Create a sysfs entry called
lpfc_xcvr_data for transceiver info") in v6.2-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e0bf3e8aec2cbc51123f84b29aaacbd91fc56fa]
stable/6.6: [57600a7dd2b52c904f7c8d2cac0fd8c23868e680]

CVE-2024-43822: ASoc: PCM6240: Return directly after a failed
devm_kzalloc() in pcmdevice_i2c_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024081724-CVE-2024-43822-6511@gregkh/

Introduced by commit 1324eaf ("ASoc: PCM6240: Create PCM6240 Family
driver code") in v6.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3722873d49a1788d5420894d4f6f63e35f5c1f13]

CVE-2024-43823: PCI: keystone: Fix NULL pointer dereference in case of
DT error in ks_pcie_setup_rc_app_regs()

Announce: https://lore.kernel.org/linux-cve-announce/2024081725-CVE-2024-43823-4bdd@gregkh/

Introduced by commit 0f71c60 ("PCI: dwc: Remove storing of PCI
resources") in v5.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a231707a91f323af1e5d9f1722055ec2fc1c7775]
stable/6.1: [bbba48ad67c53feea05936ea1e029dcca8057506]
stable/6.6: [0a6f1b5fe8ef8268aaa069035639968ceeea0a23]

CVE-2024-43824: PCI: endpoint: pci-epf-test: Make use of cached
'epc_features' in pci_epf_test_core_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024081725-CVE-2024-43824-fc04@gregkh/

Introduced by commit 5e50ee2 ("PCI: pci-epf-test: Add support to defer
core initialization") in v5.7-rc1.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt

Fixed status
mainline: [5a5095a8bd1bd349cce1c879e5e44407a34dda8a]

CVE-2024-43825: iio: Fix the sorting functionality in
iio_gts_build_avail_time_table

Announce: https://lore.kernel.org/linux-cve-announce/2024081725-CVE-2024-43825-20fc@gregkh/

Introduced by commit 38416c2 ("iio: light: Add gain-time-scale
helpers") in v6.4-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5acc3f971a01be48d5ff4252d8f9cdb87998cdfb]
stable/6.6: [31ff8464ef540785344994986a010031410f9ff3]

CVE-2024-43826: nfs: pass explicit offset/count to trace events

Announce: https://lore.kernel.org/linux-cve-announce/2024081726-CVE-2024-43826-2a5f@gregkh/

Introduced by commit eb5654b ("NFS: Enable tracing of
nfs_invalidate_folio() and nfs_launder_folio()") in v6.3-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fada32ed6dbc748f447c8d050a961b75d946055a]

CVE-2024-43827: drm/amd/display: Add null check before access structs

Announce: https://lore.kernel.org/linux-cve-announce/2024081726-CVE-2024-43827-6486@gregkh/

Introduced by commit 09a4ec5 ("drm/amd/display: Refactor dc_state
interface") in v6.8-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c96140000915b610d86f941450e15ca552de154a]

CVE-2024-43828: ext4: fix infinite loop when replaying fast_commit

Announce: https://lore.kernel.org/linux-cve-announce/2024081726-CVE-2024-43828-6bcb@gregkh/

Introduced by commit 8016e29 ("ext4: fast commit recovery path") in v5.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [907c3fe532253a6ef4eb9c4d67efb71fab58c706]
stable/5.10: [5ed0496e383cb6de120e56991385dce70bbb87c1]
stable/5.15: [0619f7750f2b178a1309808832ab20d85e0ad121]
stable/6.1: [181e63cd595c688194e07332f9944b3a63193de2]
stable/6.6: [c6e67df64783e99a657ef2b8c834ba2bf54c539c]

CVE-2024-43829: drm/qxl: Add check for drm_cvt_mode

Announce: https://lore.kernel.org/linux-cve-announce/2024081726-CVE-2024-43829-72cb@gregkh/

Introduced by commit 1b04367 ("drm/qxl: add qxl_add_mode helper
function") in v5.1-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7bd09a2db0f617377027a2bb0b9179e6959edff3]
stable/5.10: [4e87f592a46bb804d8f833da6ce702ae4b55053f]
stable/5.15: [3efe34f95b1ac8c138a46b14ce75956db0d6ee7c]
stable/5.4: [62ef8d7816c8e4a6088275553818b9afc0ffaa03]
stable/6.1: [f28b353c0c6c7831a70ccca881bf2db5e6785cdd]
stable/6.6: [4b1f303bdeceac049e56e4b20eb5280bd9e02f4f]

CVE-2024-43830: leds: trigger: Unregister sysfs attributes before
calling deactivate()

Announce: https://lore.kernel.org/linux-cve-announce/2024081727-CVE-2024-43830-3b85@gregkh/

Introduced by commit a7e7a31 ("leds: triggers: add device attribute
support") in v4.19-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0dc9adf9474ecb7106e60e5472577375aedaed3]
stable/4.19: [c3b7a650c8717aa89df318364609c86cbc040156]
stable/5.10: [09c1583f0e10c918855d6e7540a79461a353e5d6]
stable/5.15: [3fb6a9d67cfd812a547ac73ec02e1077c26c640d]
stable/5.4: [d1415125b701ef13370e2761f691ec632a5eb93a]
stable/6.1: [734ba6437e80dfc780e9ee9d95f912392d12b5ea]
stable/6.6: [cb8aa9d2a4c8a15d6a43ccf901ef3d094aa60374]

CVE-2024-43831: media: mediatek: vcodec: Handle invalid decoder vsi

Announce: https://lore.kernel.org/linux-cve-announce/2024081727-CVE-2024-43831-b13e@gregkh/

Introduced by commit 590577a ("[media] vcodec: mediatek: Add Mediatek
V4L2 Video Decoder Driver") in v4.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59d438f8e02ca641c58d77e1feffa000ff809e9f]
stable/6.6: [1c109f23b271a02b9bb195c173fab41e3285a8db]

CVE-2024-43832: s390/uv: Don't call folio_wait_writeback() without a
folio reference

Announce: https://lore.kernel.org/linux-cve-announce/2024081727-CVE-2024-43832-7746@gregkh/

Introduced by commit 214d9bb ("s390/mm: provide memory management
functions for protected KVM guests") in v5.7-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f29f6537f54d74e64bac0a390fb2e26da25800d]
stable/6.1: [1a1eb2f3fc453dcd52726d13e863938561489cb7]
stable/6.6: [8736604ef53359a718c246087cd21dcec232d2fb]

CVE-2024-43833: media: v4l: async: Fix NULL pointer dereference in
adding ancillary links

Announce: https://lore.kernel.org/linux-cve-announce/2024081728-CVE-2024-43833-4e73@gregkh/

Introduced by commit aa4faf6 ("media: v4l2-async: Create links during
v4l2_async_match_notify()") in v5.19-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b4667ea67854f0b116fe22ad11ef5628c5b5b5f]
stable/6.1: [fe0f92fd5320b393e44ca210805e653ea90cc982]
stable/6.6: [249212ceb4187783af3801c57b92a5a25d410621]

CVE-2024-43834: xdp: fix invalid wait context of page_pool_destroy()

Announce: https://lore.kernel.org/linux-cve-announce/2024081728-CVE-2024-43834-0140@gregkh/

Introduced by commit c3f812c ("page_pool: do not release pool until
inflight == 0.") in v5.5-rc1.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [59a931c5b732ca5fc2ca727f5a72aeabaafa85ec]
stable/5.10: [be9d08ff102df3ac4f66e826ea935cf3af63a4bd]
stable/5.15: [6c390ef198aa69795427a5cb5fd7cb4bc7e6cd7a]
stable/6.1: [3fc1be360b99baeea15cdee3cf94252cd3a72d26]
stable/6.6: [bf0ce5aa5f2525ed1b921ba36de96e458e77f482]

CVE-2024-43835: virtio_net: Fix napi_skb_cache_put warning

Announce: https://lore.kernel.org/linux-cve-announce/2024081728-CVE-2024-43835-5f11@gregkh/

Introduced by commit df133f3 ("virtio_net: bulk free tx skbs") in v5.0-rc3.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8321fa75102246d7415a6af441872f6637c93ab]

CVE-2024-43836: net: ethtool: pse-pd: Fix possible null-deref

Announce: https://lore.kernel.org/linux-cve-announce/2024081729-CVE-2024-43836-d81d@gregkh/

Introduced by commit 4d18e3d ("net: ethtool: pse-pd: Expand pse
commands with the PSE PoE interface") in v6.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cddb0f15ea9c62f81b4889ea69a99368cc63a86]

CVE-2024-43837: bpf: Fix null pointer dereference in
resolve_prog_type() for BPF_PROG_TYPE_EXT

Announce: https://lore.kernel.org/linux-cve-announce/2024081729-CVE-2024-43837-63d2@gregkh/

Introduced by commit 4a9c7bb ("bpf: Resolve to
prog->aux->dst_prog->type only for BPF_PROG_TYPE_EXT") in v5.18-rc2.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7866c35873377313ff94398f17d425b28b71de1]
stable/6.1: [fcac5feb06f31ee4c88bca9bf98d8bc3ca7d2615]
stable/6.6: [9d40fd516aeae6779e3c84c6b96700ca76285847]

CVE-2024-43838: bpf: fix overflow check in adjust_jmp_off()

Announce: https://lore.kernel.org/linux-cve-announce/2024081729-CVE-2024-43838-968a@gregkh/

Introduced by commit 5337ac4 ("bpf: Fix the corner case with may_goto
and jump to the 1st insn.") in v6.10-rc6.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a04b4f0de59dd5c621e78f15803ee0b0544eeb8]

CVE-2024-43839: bna: adjust 'name' buf size of bna_tcb and bna_ccb structures

Announce: https://lore.kernel.org/linux-cve-announce/2024081729-CVE-2024-43839-ea03@gregkh/

Introduced by commit 8b230ed ("bna: Brocade 10Gb Ethernet device
driver") in v2.6.37-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9741a03dc8e491e57b95fba0058ab46b7e506da]
stable/4.19: [f121740f69eda4da2de9a20a6687a13593e72540]
stable/5.10: [6ce46045f9b90d952602e2c0b8886cfadf860bf1]
stable/5.15: [6d20c4044ab4d0e6a99aa35853e66f0aed5589e3]
stable/5.4: [c90b1cd7758fd4839909e838ae195d19f8065d76]
stable/6.1: [ab748dd10d8742561f2980fea08ffb4f0cacfdef]
stable/6.6: [b0ff0cd0847b03c0a0abe20cfa900eabcfcb9e43]

CVE-2024-43840: bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG

Announce: https://lore.kernel.org/linux-cve-announce/2024081730-CVE-2024-43840-69cb@gregkh/

Introduced by commit efc9909 ("bpf, arm64: Add bpf trampoline for
arm64") in v6.0-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19d3c179a37730caf600a97fed3794feac2b197b]

CVE-2024-43841: wifi: virt_wifi: avoid reporting connection success
with wrong SSID

Announce: https://lore.kernel.org/linux-cve-announce/2024081730-CVE-2024-43841-8143@gregkh/

Introduced by commit c7cdba3 ("mac80211-next: rtnetlink wifi
simulation device") in v5.0-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5d14b0c6716fad7f0c94ac6e1d6f60a49f985c7]
stable/5.10: [05c4488a0e446c6ccde9f22b573950665e1cd414]
stable/5.15: [93e898a264b4e0a475552ba9f99a016eb43ef942]
stable/5.4: [994fc2164a03200c3bf42fb45b3d49d9d6d33a4d]
stable/6.1: [d3cc85a10abc8eae48988336cdd3689ab92581b3]
stable/6.6: [36e92b5edc8e0daa18e9325674313802ce3fbc29]

CVE-2024-43842: wifi: rtw89: Fix array index mistake in
rtw89_sta_info_get_iter()

Announce: https://lore.kernel.org/linux-cve-announce/2024081730-CVE-2024-43842-31e7@gregkh/

Introduced by commit e3ec701 ("rtw89: add Realtek 802.11ax driver") in
v5.16-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85099c7ce4f9e64c66aa397cd9a37473637ab891]
stable/6.1: [a2a095c08b95372d6d0c5819b77f071af5e75366]
stable/6.6: [7a0edc3d83aff3a48813d78c9cad9daf38decc74]

CVE-2024-43843: riscv, bpf: Fix out-of-bounds issue when preparing
trampoline image

Announce: https://lore.kernel.org/linux-cve-announce/2024081731-CVE-2024-43843-e436@gregkh/

Introduced by commit 26ef208 ("bpf: Use arch_bpf_trampoline_size") in v6.8-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f1e16fb1fc9826001c69e0551d51fbbcd2d74e9]

CVE-2024-43844: wifi: rtw89: wow: fix GTK offload H2C skbuff issue

Announce: https://lore.kernel.org/linux-cve-announce/2024081731-CVE-2024-43844-97ea@gregkh/

Introduced by commit ed9a3c0 ("wifi: rtw89: wow: construct EAPoL
packet for GTK rekey offload") in v6.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dda364c345913fe03ddbe4d5ae14a2754c100296]

CVE-2024-43845: udf: Fix bogus checksum computation in udf_rename()

Announce: https://lore.kernel.org/linux-cve-announce/2024081731-CVE-2024-43845-a85d@gregkh/

Introduced by commit e9109a9 ("udf: Convert udf_rename() to new
directory iteration code") in v6.3-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27ab33854873e6fb958cb074681a0107cc2ecc4c]
stable/6.6: [fe2ead240c31e8d158713beca9d0681a6e6a53ab]

CVE-2024-43846: lib: objagg: Fix general protection fault

Announce: https://lore.kernel.org/linux-cve-announce/2024081732-CVE-2024-43846-2bd0@gregkh/

Introduced by commit 9069a38 ("lib: objagg: implement optimization
hints assembly and use hints for object creation") in v5.1-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4a3a89fffcdf09702b1f161b914e52abca1894d]
stable/5.10: [22ae17a267f4812861f0c644186c3421ff97dbfc]
stable/5.15: [565213e005557eb6cc4e42189d26eb300e02f170]
stable/5.4: [8161263362154cbebfbf4808097b956a6a8cb98a]
stable/6.1: [5adc61d29bbb461d7f7c2b48dceaa90ecd182eb7]
stable/6.6: [1936fa05a180834c3b52e0439a6bddc07814d3eb]

CVE-2024-43847: wifi: ath12k: fix invalid memory access while
processing fragmented packets

Announce: https://lore.kernel.org/linux-cve-announce/2024081732-CVE-2024-43847-6828@gregkh/

Introduced by commit d889913 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in v6.3-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [073f9f249eecd64ab9d59c91c4a23cfdcc02afe4]
stable/6.6: [8126f82dab7bd8b2e04799342b19fff0a1fd8575]

CVE-2024-43848: wifi: mac80211: fix TTLM teardown work

Announce: https://lore.kernel.org/linux-cve-announce/2024081732-CVE-2024-43848-4e24@gregkh/

Introduced by commit a17a58a ("wifi: mac80211: add support for tearing
down negotiated TTLM") in v6.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2fe0a605d083b884490ee4de02be071b5b4291b1]

CVE-2024-43849: soc: qcom: pdr: protect locator_addr with the main mutex

Announce: https://lore.kernel.org/linux-cve-announce/2024081732-CVE-2024-43849-fef0@gregkh/

Introduced by commit fbe639b ("soc: qcom: Introduce Protection Domain
Restart helpers") in v5.7-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [107924c14e3ddd85119ca43c26a4ee1056fa9b84]
stable/5.10: [eab05737ee22216250fe20d27f5a596da5ea6eb7]
stable/5.15: [d0870c4847e77a49c2f91bb2a8e0fa3c1f8dea5c]
stable/6.1: [475a77fb3f0e1d527f56c60b79f5879661df5b80]
stable/6.6: [3e815626d73e05152a8142f6e44aecc4133e6e08]

CVE-2024-43850: soc: qcom: icc-bwmon: Fix refcount imbalance seen
during bwmon_remove

Announce: https://lore.kernel.org/linux-cve-announce/2024081733-CVE-2024-43850-4eec@gregkh/

Introduced by commit 0276f69 ("soc: qcom: icc-bwmon: Set default
thresholds dynamically") in v6.6-rc1.
Introduced by commit b9c2ae6 ("soc: qcom: icc-bwmon: Add bandwidth
monitoring driver") in v6.0-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24086640ab39396eb1a92d1cb1cd2f31b2677c52]
stable/6.6: [aad41f4c169bcb800ae88123799bdf8cdec3d366]

CVE-2024-43851: soc: xilinx: rename cpu_number1 to dummy_cpu_number

Announce: https://lore.kernel.org/linux-cve-announce/2024081733-CVE-2024-43851-26f9@gregkh/

Introduced by commit daed80e ("soc: xilinx: Fix for call trace due to
the usage of smp_processor_id()") in v6.8-rc1.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [4a95449dd975e2ea6629a034f3e74b46c9634916]
stable/6.1: [a5e507fadab76393cbc12344ebd65a417a09aa46]
stable/6.6: [a96e60a6ea6818fd37b1853283a512c49af38cf5]

CVE-2024-43852: hwmon: (ltc2991) re-order conditions to fix off by one bug

Announce: https://lore.kernel.org/linux-cve-announce/2024081733-CVE-2024-43852-61e2@gregkh/

Introduced by commit 2b9ea42 ("hwmon: Add driver for ltc2991") in v6.7-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99bf7c2eccff82760fa23ce967cc67c8c219c6a6]

CVE-2024-43853: cgroup/cpuset: Prevent UAF in proc_cpuset_show()

Announce: https://lore.kernel.org/linux-cve-announce/2024081734-CVE-2024-43853-da5b@gregkh/

Introduced by commit a79a908 ("cgroup: introduce cgroup namespaces")
in v4.6-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1be59c97c83ccd67a519d8a49486b3a8a73ca28a]
stable/6.1: [29a8d4e02fd4840028c38ceb1536cc8f82a257d4]
stable/6.6: [96226fbed566f3f686f53a489a29846f2d538080]

CVE-2024-43854: block: initialize integrity buffer to zero before
writing it to media

Announce: https://lore.kernel.org/linux-cve-announce/2024081734-CVE-2024-43854-5586@gregkh/

Introduced by commit 7ba1ba1 ("block: Block layer data integrity
support") in v2.6.27-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [899ee2c3829c5ac14bfc7d3c4a5846c0b709b78f]
stable/5.15: [cf6b45ea7a8df0f61bded1dc4a8561ac6ad143d2]
stable/6.1: [d418313bd8f55c079a7da12651951b489a638ac1]
stable/6.6: [23a19655fb56f241e592041156dfb1c6d04da644]

CVE-2024-43855: md: fix deadlock between mddev_suspend and flush bio

Announce: https://lore.kernel.org/linux-cve-announce/2024081734-CVE-2024-43855-b78a@gregkh/

Introduced by commit fa2bbff ("md: synchronize flush io with array
reconfiguration") in v6.8-rc1.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [611d5cbc0b35a752e657a83eebadf40d814d006b]
stable/6.1: [32226070813140234b6c507084738e8e8385c5c6]
stable/6.6: [2d0738a8322bf4e5bfe693d16b3111928a9ccfbf]

CVE-2024-43856: dma: fix call order in dmam_free_coherent

Announce: https://lore.kernel.org/linux-cve-announce/2024081732-CVE-2024-43856-9087@gregkh/

Introduced by commit 9ac7849 ("devres: device resource management") in
v2.6.21-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [28e8b7406d3a1f5329a03aa25a43aa28e087cb20]
stable/4.19: [fe2d246080f035e0af5793cb79067ba125e4fb63]
stable/5.10: [257193083e8f43907e99ea633820fc2b3bcd24c7]
stable/5.15: [87b34c8c94e29fa01d744e5147697f592998d954]
stable/5.4: [2f7bbdc744f2e7051d1cb47c8e082162df1923c9]
stable/6.1: [f993a4baf6b622232e4c190d34c220179e5d61eb]
stable/6.6: [1fe97f68fce1ba24bf823bfb0eb0956003473130]

CVE-2024-43857: f2fs: fix null reference error when checking end of zone

Announce: https://lore.kernel.org/linux-cve-announce/2024081733-CVE-2024-43857-b71b@gregkh/

Introduced by commit e067dc3 ("f2fs: maintain six open zones for zoned
devices") in v6.5-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c82bc1ab2a8a5e73d9728e80c4c2ed87e8921a38]

CVE-2024-43858: jfs: Fix array-index-out-of-bounds in diFree

Announce: https://lore.kernel.org/linux-cve-announce/2024081733-CVE-2024-43858-0d3e@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f73f969b2eb39ad8056f6c7f3a295fa2f85e313a]
stable/4.19: [55b732c8b09b41148eaab2fa8e31b0af47671e00]
stable/5.10: [538a27c8048f081a5ddd286f886eb986fbbc7f80]
stable/5.15: [63f7fdf733add82f126ea00e2e48f6eba15ac4b9]
stable/5.4: [9b3a4345957f5372041bc4f59de322f62653e862]
stable/6.1: [8d8f9a477de0d7962342eedf2a599215b7c63d28]
stable/6.6: [ff14eadc278663cac69d57d3ca7fb2f394e1f8a7]

CVE-2024-43859: f2fs: fix to truncate preallocated blocks in f2fs_file_open()

Announce: https://lore.kernel.org/linux-cve-announce/2024081733-CVE-2024-43859-62b4@gregkh/

Introduced by commit d4dd19e ("f2fs: do not expose unwritten blocks to
user by DIO") in v5.17-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [298b1e4182d657c3e388adcc29477904e9600ed5]
stable/6.6: [f44a25a8bfe0c15d33244539696cd9119cf44d18]

CVE-2024-43860: remoteproc: imx_rproc: Skip over memory region when
node value is NULL

Announce: https://lore.kernel.org/linux-cve-announce/2024081734-CVE-2024-43860-d72f@gregkh/

Introduced by commit a0ff4aa ("remoteproc: imx_rproc: add a
NXP/Freescale imx_rproc driver") in v4.14-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2fa26ca8b786888673689ccc9da6094150939982]
stable/4.19: [6884fd0283e0831be153fb8d82d9eda8a55acaaa]
stable/5.10: [6b50462b473fdccdc0dfad73001147e40ff19a66]
stable/5.15: [4e13b7c23988c0a13fdca92e94296a3bc2ff9f21]
stable/5.4: [84beb7738459cac0ff9f8a7c4654b8ff82a702c0]
stable/6.1: [9a17cf8b2ce483fa75258bc2cdcf628f24bcf5f8]
stable/6.6: [6c9ea3547fad252fe9ae5d3ed7e066e2085bf3a2]

CVE-2024-43861: net: usb: qmi_wwan: fix memory leak for not ip packets

Announce: https://lore.kernel.org/linux-cve-announce/2024082156-CVE-2024-43861-1958@gregkh/

Introduced by commit c6adf77 ("net: usb: qmi_wwan: add qmap mux
protocol support") in v4.12-rc1.
Fixed in v6.11-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ab107544b777c3bd7feb9fe447367d8edd5b202]
stable/4.19: [3c90a69533b5bba73401ef884d033ea49ee99662]
stable/5.10: [e87f52225e04a7001bf55bbd7a330fa4252327b5]
stable/5.15: [c4251a3deccad852b27e60625f31fba6cc14372f]
stable/5.4: [37c093449704017870604994ba9b813cdb9475a4]
stable/6.1: [da518cc9b64df391795d9952aed551e0f782e446]
stable/6.6: [f2c353227de14b0289298ffc3ba92058c4768384]

CVE-2022-48867: dmaengine: idxd: Prevent use after free on completion memory

Announce: https://lore.kernel.org/linux-cve-announce/2024082103-CVE-2022-48867-a428@gregkh/

Introduced by commit 63c14ae ("dmaengine: idxd: refactor wq driver
enable/disable operations") in v5.19-rc1.
Fixed in v6.2-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1beeec45f9ac31eba52478379f70a5fa9c2ad005]
stable/6.1: [b9e8e3fcfec625fc1c2f68f684448aeeb882625b]

CVE-2022-48868: dmaengine: idxd: Let probe fail when workqueue cannot be enabled

Announce: https://lore.kernel.org/linux-cve-announce/2024082105-CVE-2022-48868-866e@gregkh/

Introduced by commit 1f2bb40 ("dmaengine: idxd: move wq_enable() to
device.c") in v5.15-rc1.
Fixed in v6.2-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b51b75f0604f17c0f6f3b6f68f1a521a5cc6b04f]
stable/5.15: [0f150134dd795ffcd60b798a85ab737d8d010fb7]
stable/6.1: [99dc4520b74e7ca8e9dc9abe37a0b10b49467960]

CVE-2022-48869: USB: gadgetfs: Fix race between mounting and unmounting

Announce: https://lore.kernel.org/linux-cve-announce/2024082105-CVE-2022-48869-bfe9@gregkh/

Introduced by commit e5d82a7 ("vfs: Convert gadgetfs to use the new
mount API") in v5.3-rc1.
Fixed in v6.2-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d18dcfe9860e842f394e37ba01ca9440ab2178f4]
stable/5.10: [856e4b5e53f21edbd15d275dde62228dd94fb2b4]
stable/5.15: [a2e075f40122d8daf587db126c562a67abd69cf9]
stable/5.4: [9a39f4626b361ee7aa10fd990401c37ec3b466ae]
stable/6.1: [616fd34d017000ecf9097368b13d8a266f4920b3]

CVE-2022-48870: tty: fix possible null-ptr-defer in spk_ttyio_release

Announce: https://lore.kernel.org/linux-cve-announce/2024082105-CVE-2022-48870-3fcb@gregkh/

Introduced by commit 4f2a81f ("speakup: Reference synth from tty and
tty from synth") in v5.12-rc1.
Fixed in v6.2-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5abbeebd8296c2301023b8dc4b5a6c0d5229b4f5]
stable/5.15: [2da67bff29ab49caafb0766e8b8383b735ff796f]
stable/6.1: [64152e05a4de3ebf59f1740a0985a6d5fba0c77b]

CVE-2022-48871: tty: serial: qcom-geni-serial: fix slab-out-of-bounds
on RX FIFO buffer

Announce: https://lore.kernel.org/linux-cve-announce/2024082105-CVE-2022-48871-93c2@gregkh/

Introduced by commit f9d690b ("tty: serial: qcom_geni_serial: Allocate
port->rx_fifo buffer in probe") in v5.7-rc1.
Fixed in v6.2-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b8caf69a6946e18ffebad49847e258f5b6d52ac2]
stable/5.10: [894681682dbefdad917b88f86cde1069140a047a]
stable/5.15: [cb53a3366eb28fed67850c80afa52075bb71a38a]
stable/6.1: [fd524ca7fe45b8a06dca2dd546d62684a9768f95]

CVE-2022-48872: misc: fastrpc: Fix use-after-free race condition for maps

Announce: https://lore.kernel.org/linux-cve-announce/2024082106-CVE-2022-48872-6010@gregkh/

Introduced by commit c68cfb7 ("misc: fastrpc: Add support for context
Invoke method") in v5.1-rc1.
Fixed in v6.2-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96b328d119eca7563c1edcc4e1039a62e6370ecb]
stable/5.10: [b171d0d2cf1b8387c72c8d325c5d5746fa271e39]
stable/5.15: [61a0890cb95afec5c8a2f4a879de2b6220984ef1]
stable/5.4: [556dfdb226ce1e5231d8836159b23f8bb0395bf4]
stable/6.1: [079c78c68714f7d8d58e66c477b0243b31806907]

CVE-2022-48873: misc: fastrpc: Don't remove map on creater_process and
device_release

Announce: https://lore.kernel.org/linux-cve-announce/2024082106-CVE-2022-48873-dc18@gregkh/

Introduced by commit b49f6d8 ("misc: fastrpc: Fix a possible double
free") in v5.2-rc1.
Fixed in v6.2-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5bb96c8f9268e2fdb0e5321cbc358ee5941efc15]
stable/5.10: [193cd853145b63e670bd73740250983af1475330]
stable/5.15: [1b7b7bb400dd13dcb03fc6e591bb7ca4664bbec8]
stable/5.4: [4b5c44e924a571d0ad07054de549624fbc04e4d7]
stable/6.1: [35ddd482345c43d9eec1f3406c0f20a95ed4054b]

CVE-2022-48874: misc: fastrpc: Fix use-after-free and race in fastrpc_map_find

Announce: https://lore.kernel.org/linux-cve-announce/2024082106-CVE-2022-48874-e8a4@gregkh/

Introduced by commit 8f6c1d8 ("misc: fastrpc: Add fdlist
implementation") in v5.18-rc1.
Fixed in v6.2-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9446fa1683a7e3937d9970248ced427c1983a1c5]
stable/6.1: [a50c5c25b6e7d2824698c0e6385f882a18f4a498]

CVE-2022-48875: wifi: mac80211: sdata can be NULL during AMPDU start

Announce: https://lore.kernel.org/linux-cve-announce/2024082106-CVE-2022-48875-b68f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc5.
4.x might be affected.

Fixed status
mainline: [69403bad97aa0162e3d7911b27e25abe774093df]
stable/5.10: [187523fa7c2d4c780f775cb869216865c4a909ef]
stable/5.15: [a12fd43bd175fa52c82f9740179d38c34ca1b62e]
stable/6.1: [c838df8461a601b20dc1b9fb1834d2aad8e2f949]

CVE-2022-48876: wifi: mac80211: fix initialization of rx->link and rx->link_sta

Announce: https://lore.kernel.org/linux-cve-announce/2024082106-CVE-2022-48876-83f8@gregkh/

Introduced by commit ccdde7c ("wifi: mac80211: properly implement MLO
key handling") in v6.1-rc1.
Introduced by commit b320d6c ("wifi: mac80211: use correct rx link_sta
instead of default") in v6.1-rc1.
Fixed in v6.2-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e66b7920aa5ac5b1a1997a454004ba9246a3c005]
stable/6.1: [a57c981d9f24d2bd89eaa76dc477e8ca252e22e8]

CVE-2022-48877: f2fs: let's avoid panic if extent_tree is not created

Announce: https://lore.kernel.org/linux-cve-announce/2024082107-CVE-2022-48877-6196@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc3.

Fixed status
cip/4.4: [dab337652c1529445475bd8286730466c37b4b3f]
cip/4.4-rt: [dab337652c1529445475bd8286730466c37b4b3f]
cip/4.4-st: [dab337652c1529445475bd8286730466c37b4b3f]
mainline: [df9d44b645b83fffccfb4e28c1f93376585fdec8]
stable/4.19: [ff85a1dbd90d29f73033177ff8d8de4a27d9721c]
stable/5.10: [72009139a661ade5cb1da4239734ed02fa1cfff0]
stable/5.15: [2c129e868992621a739bdd57a5bffa3985ef1b91]
stable/5.4: [557e85ff9afef6d45020b6f09357111d38033c31]
stable/6.1: [1c38cdc747f00daf7394535eae5afc4c503c59bb]

CVE-2022-48878: Bluetooth: hci_qca: Fix driver shutdown on closed serdev

Announce: https://lore.kernel.org/linux-cve-announce/2024082107-CVE-2022-48878-5802@gregkh/

Introduced by commit 7e7bbdd ("Bluetooth: hci_qca: Fix qca6390 enable
failure after warm reboot") in v5.8-rc1.
Fixed in v6.2-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [272970be3dabd24cbe50e393ffee8f04aec3b9a8]
stable/5.10: [e84ec6e25df9bb0968599e92eacedaf3a0a5b587]
stable/5.15: [908d1742b6e694e84ead5c62e4b7c1bfbb8b46a3]
stable/6.1: [ea3ebda47dd56f6e1c62f2e0e1b6e1b0a973e447]

CVE-2022-48879: efi: fix NULL-deref in init error path

Announce: https://lore.kernel.org/linux-cve-announce/2024082107-CVE-2022-48879-63f6@gregkh/

Introduced by commit 98086df ("efi: add missed destroy_workqueue when
efisubsys_init fails") in v5.9-rc2.
Fixed in v6.2-rc4.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19 stable/5.4

Fixed status
mainline: [703c13fe3c9af557d312f5895ed6a5fda2711104]
stable/4.19: [585a0b2b3ae7903c6abee3087d09c69e955a7794]
stable/5.10: [4ca71bc0e1995d15486cd7b60845602a28399cb5]
stable/5.15: [e2ea55564229e4bea1474af15b111b3a3043b76f]
stable/5.4: [5fcf75a8a4c3e7ee9122d143684083c9faf20452]
stable/6.1: [adc96d30f6503d30dc68670c013716f1d9fcc747]

CVE-2022-48880: platform/surface: aggregator: Add missing call to
ssam_request_sync_free()

Announce: https://lore.kernel.org/linux-cve-announce/2024082107-CVE-2022-48880-ede2@gregkh/

Introduced by commit c167b9c ("platform/surface: Add Surface
Aggregator subsystem") in v5.12-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c965daac370f08a9b71d573a71d13cda76f2a884]
stable/5.15: [d2dc110deabe7142b60ebeed689e67f92795ee24]
stable/6.1: [50b3cdf8239b11545f311c4f7b89e0092e4feedb]

CVE-2022-48881: platform/x86/amd: Fix refcount leak in amd_pmc_probe

Announce: https://lore.kernel.org/linux-cve-announce/2024082107-CVE-2022-48881-5129@gregkh/

Introduced by commit 3d7d407 ("platform/x86: amd-pmc: Add support for
AMD Spill to DRAM STB feature") in v5.18-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ccb32e2be14271a60e9ba89c6d5660cc9998773c]
stable/6.1: [3944162821295993ec89992dec98ab6be6306cc0]

CVE-2022-48882: net/mlx5e: Fix macsec possible null dereference when
updating MAC security entity (SecY)

Announce: https://lore.kernel.org/linux-cve-announce/2024082108-CVE-2022-48882-2b80@gregkh/

Introduced by commit 4411a6c ("net/mlx5e: Support MACsec offload
extended packet number (EPN)") in v6.1-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9828994ac492e8e7de47fe66097b7e665328f348]
stable/6.1: [514d9c6a39213d8200884e70f60ce7faef1ee597]

CVE-2022-48883: net/mlx5e: IPoIB, Block PKEY interfaces with less rx
queues than parent

Announce: https://lore.kernel.org/linux-cve-announce/2024082108-CVE-2022-48883-4df4@gregkh/

Introduced by commit be98737 ("net/mlx5e: Use dynamic per-channel
allocations in stats") in v5.17-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31c70bfe58ef09fe36327ddcced9143a16e9e83d]
stable/6.1: [5844a46f09f768da866d6b0ffbf1a9073266bf24]

CVE-2022-48884: net/mlx5: Fix command stats access after free

Announce: https://lore.kernel.org/linux-cve-announce/2024082108-CVE-2022-48884-b273@gregkh/

Introduced by commit 34f46ae ("net/mlx5: Add command failures data to
debugfs") in v5.18-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da2e552b469a0cd130ff70a88ccc4139da428a65]
stable/6.1: [ddf458641a511e7dff19f3bf0cbbc5dd9fe08ce5]

CVE-2022-48885: ice: Fix potential memory leak in ice_gnss_tty_write()

Announce: https://lore.kernel.org/linux-cve-announce/2024082108-CVE-2022-48885-c422@gregkh/

Introduced by commit d6b98c8 ("ice: add write functionality for GNSS
TTY") in v6.0-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f58985620f55580a07d40062c4115d8c9cf6ae27]
stable/6.1: [500ca1da9d0876244eb4d1b0ece6fa0e9968d45d]

CVE-2022-48886: ice: Add check for kzalloc

Announce: https://lore.kernel.org/linux-cve-announce/2024082108-CVE-2022-48886-0228@gregkh/

Introduced by commit d6b98c8 ("ice: add write functionality for GNSS
TTY") in v6.0-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40543b3d9d2c13227ecd3aa90a713c201d1d7f09]
stable/6.1: [96a9873188552ebb2afe76033d7329a5ecabef6e]

CVE-2022-48887: drm/vmwgfx: Remove rcu locks from user resources

Announce: https://lore.kernel.org/linux-cve-announce/2024082109-CVE-2022-48887-4019@gregkh/

Introduced by commit e14c02e ("drm/vmwgfx: Look up objects without
taking a reference") in v4.20-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a309c7194e8a2f8bd4539b9449917913f6c2cd50]
stable/6.1: [7ac9578e45b20e3f3c0c8eb71f5417a499a7226a]

CVE-2022-48888: drm/msm/dpu: Fix memory leak in msm_mdss_parse_data_bus_icc_path

Announce: https://lore.kernel.org/linux-cve-announce/2024082109-CVE-2022-48888-bf04@gregkh/

Introduced by commit b9364ee ("drm/msm/dpu: Move min BW request and
full BW disable back to mdss") in v5.19-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45dac1352b55b1d8cb17f218936b2bc2bc1fb4ee]
stable/6.1: [c6fa1de83fd87267ab24359e6fa52f98f5cee3f9]

CVE-2022-48889: ASoC: Intel: sof-nau8825: fix module alias overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024082109-CVE-2022-48889-c929@gregkh/

Introduced by commit 8d0872f ("ASoC: Intel: add sof-nau8825 machine
driver") in v5.17-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e78986a840d59dd27e636eae3f52dc11125c835]
stable/6.1: [fba1b23befd88366fe646787b3797e64d7338fd2]

CVE-2022-48890: scsi: storvsc: Fix swiotlb bounce buffer leak in confidential VM

Announce: https://lore.kernel.org/linux-cve-announce/2024082109-CVE-2022-48890-7f36@gregkh/

Introduced by commit 743b237 ("scsi: storvsc: Add Isolation VM support
for storvsc driver") in v5.17-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67ff3d0a49f3d445c3922e30a54e03c161da561e]
stable/6.1: [87c71e88f6a6619ffb1ff88f84dff48ef6d57adb]

CVE-2022-48891: regulator: da9211: Use irq handler when ready

Announce: https://lore.kernel.org/linux-cve-announce/2024082109-CVE-2022-48891-e463@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc4.

Fixed status
cip/4.4: [9d7f70d31e231c86d96c193cfd54ac94a52f5379]
cip/4.4-rt: [9d7f70d31e231c86d96c193cfd54ac94a52f5379]
cip/4.4-st: [9d7f70d31e231c86d96c193cfd54ac94a52f5379]
mainline: [02228f6aa6a64d588bc31e3267d05ff184d772eb]
stable/4.19: [f75cde714e0a67f73ef169aa50d4ed77d04f7236]
stable/5.10: [d4aa749e046435f054e94ebf50cad143d6229fae]
stable/5.15: [470f6a9175f13a53810734658c35cc5bba33be01]
stable/5.4: [d443308edbfb6e9e757b478af908515110d1efd5]
stable/6.1: [ad1336274f733a7cb1f87b5c5908165a2c14df53]

CVE-2022-48892: sched/core: Fix use-after-free bug in dup_user_cpus_ptr()

Announce: https://lore.kernel.org/linux-cve-announce/2024082110-CVE-2022-48892-3458@gregkh/

Introduced by commit 07ec77a ("sched: Allow task CPU affinity to be
restricted on asymmetric systems") in v5.15-rc1.
Introduced by commit 851a723 ("sched: Always clear user_cpus_ptr in
do_set_cpus_allowed()") in v6.2-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87ca4f9efbd7cc649ff43b87970888f2812945b8]
stable/5.15: [b22faa21b6230d5eccd233e1b7e0026a5002b287]
stable/6.1: [7b5cc7fd1789ea5dbb942c9f8207b076d365badc]

CVE-2022-48893: drm/i915/gt: Cleanup partial engine discovery failures

Announce: https://lore.kernel.org/linux-cve-announce/2024082110-CVE-2022-48893-8d4c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc1.
Affected file is not present in 4.4.

Fixed status
mainline: [78a033433a5ae4fee85511ee075bc9a48312c79e]
stable/6.1: [5c855bcc730656c4b7d30aaddcd0eafc7003e112]

CVE-2022-48894: iommu/arm-smmu-v3: Don't unregister on shutdown

Announce: https://lore.kernel.org/linux-cve-announce/2024082110-CVE-2022-48894-7997@gregkh/

Introduced by commit 57365a0 ("iommu: Move bus setup to IOMMU device
registration") in v6.1-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32ea2c57dc216b6ad8125fa680d31daa5d421c95]
stable/6.1: [ead3e6c79479890444c777fd329afc125fecde48]

CVE-2022-48895: iommu/arm-smmu: Don't unregister on shutdown

Announce: https://lore.kernel.org/linux-cve-announce/2024082110-CVE-2022-48895-1370@gregkh/

Introduced by commit 57365a0 ("iommu: Move bus setup to IOMMU device
registration") in v6.1-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce31e6ca68bd7639bd3e5ef97be215031842bbab]
stable/6.1: [a1b9c7b1978aacf4b2f33e34bde1e2bb80b8497a]

CVE-2022-48896: ixgbe: fix pci device refcount leak

Announce: https://lore.kernel.org/linux-cve-announce/2024082110-CVE-2022-48896-7c80@gregkh/

Introduced by commit 8fa10ef ("ixgbe: register a mdiobus") in v5.0-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b93fb4405fcb5112c5739c5349afb52ec7f15c07]
stable/5.10: [112df4cd2b09acd64bcd18f5ef83ba5d07b34bf0]
stable/5.15: [4c93422a54cd6a349988f42e1c6bf082cf4ea9d8]
stable/5.4: [53cefa802f070d46c0c518f4865be2c749818a18]
stable/6.1: [c49996c6aa03590e4ef5add8772cb6068d99fd59]

CVE-2022-48897: arm64/mm: fix incorrect file_map_count for invalid pmd

Announce: https://lore.kernel.org/linux-cve-announce/2024082110-CVE-2022-48897-5547@gregkh/

Introduced by commit 42b2547 ("arm64/mm: enable
ARCH_SUPPORTS_PAGE_TABLE_CHECK") in v5.19-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74c2f81054510d45b813548cb0a1c4ebf87cdd5f]
stable/6.1: [21e5eca0ac9046da9918a919bc92b7b5a78d27e7]

CVE-2022-48898: drm/msm/dp: do not complete dp_aux_cmd_fifo_tx() if
irq is not for aux transfer

Announce: https://lore.kernel.org/linux-cve-announce/2024082111-CVE-2022-48898-0522@gregkh/

Introduced by commit c943b49 ("drm/msm/dp: add displayPort driver
support") in v5.10-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1cba0d150fa102439114a91b3e215909efc9f169]
stable/5.10: [785607e5e6fb52caf141e4580de40405565f04f1]
stable/5.15: [984ad875db804948c86ca9e1c2e784ae8252715a]
stable/6.1: [b7dcbca46db3c77fdb02c2a9d6239e5aa3b06a59]

CVE-2022-48899: drm/virtio: Fix GEM handle creation UAF

Announce: https://lore.kernel.org/linux-cve-announce/2024082111-CVE-2022-48899-f3e8@gregkh/

Introduced by commit 62fb7a5 ("virtio-gpu: add 3d/virgl support") in v4.4-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52531258318ed59a2dc5a43df2eaf0eb1d65438e]
stable/4.19: [19ec87d06acfab2313ee82b2a689bf0c154e57ea]
stable/5.10: [68bcd063857075d2f9edfed6024387ac377923e2]
stable/5.15: [011ecdbcd520c90c344b872ca6b4821f7783b2f8]
stable/5.4: [d01d6d2b06c0d8390adf8f3ba08aa60b5642ef73]
stable/6.1: [adc48e5e408afbb01d261bd303fd9fbbbaa3e317]

CVE-2023-52893: gsmi: fix null-deref in gsmi_get_variable

Announce: https://lore.kernel.org/linux-cve-announce/2024082111-CVE-2023-52893-02b9@gregkh/

Introduced by commit 74c5b31 ("driver: Google EFI SMI") in v3.0-rc1.
Fixed in v6.2-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [d560deb85203aae4c622edf9012004aca54c99f6]
cip/4.4-rt: [d560deb85203aae4c622edf9012004aca54c99f6]
cip/4.4-st: [d560deb85203aae4c622edf9012004aca54c99f6]
mainline: [a769b05eeed7accc4019a1ed9799dd72067f1ce8]
stable/4.19: [32313c11bdc8a02c577abaf865be3664ab30410a]
stable/5.10: [ae2a9dcc8caa60b1e14671294e5ec902ea5d1dfd]
stable/5.15: [eb0421d90f916dffe96b4c049ddf01c0c50620d2]
stable/5.4: [ffef77794fb5f1245c3249b86342bad2299accb5]
stable/6.1: [6646d769fdb0ce4318ef9afd127f8526d1ca8393]

CVE-2023-52894: usb: gadget: f_ncm: fix potential NULL ptr deref in
ncm_bitrate()

Announce: https://lore.kernel.org/linux-cve-announce/2024082111-CVE-2023-52894-c8ee@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc5.

Fixed status
cip/4.4: [2d0444bd77aa51c699120abceb339b5e63e969d0]
cip/4.4-rt: [2d0444bd77aa51c699120abceb339b5e63e969d0]
cip/4.4-st: [2d0444bd77aa51c699120abceb339b5e63e969d0]
mainline: [c6ec929595c7443250b2a4faea988c62019d5cd2]
stable/4.19: [63d161f29cd39c050e8873aa36e0c9fc013bb763]
stable/5.10: [e92c70059178da751e5af7de02384b7dfadb5ec7]
stable/5.15: [a69c8dfb85b44be9cc223be07d35cc3a9baefbea]
stable/5.4: [a21da7f7aae618c785f7e4a275d43c06dc8412b6]
stable/6.1: [09e4507ec8ef2d44da6ba4092b8ee2d81f216497]

CVE-2023-52895: io_uring/poll: don't reissue in case of poll race on
multishot request

Announce: https://lore.kernel.org/linux-cve-announce/2024082111-CVE-2023-52895-5be2@gregkh/

This bug was introduced by commit 6e5aedb ("io_uring/poll: attempt request
issue after racy poll wakeup") in 6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8caa03f10bf92cb8657408a6ece6a8a73f96ce13]
stable/6.1: [36fc7317cdb16cfeae0f879916995037bb615ac4]

CVE-2023-52896: btrfs: fix race between quota rescan and disable
leading to NULL pointer deref

Announce: https://lore.kernel.org/linux-cve-announce/2024082112-CVE-2023-52896-d795@gregkh/

Introduced by commit e804861 ("btrfs: fix deadlock between quota
disable and qgroup rescan worker") in v5.17-rc3.
Fixed in v6.2-rc5.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [b7adbf9ada3513d2092362c8eac5cddc5b651f5c]
stable/5.10: [3bd43374857103ba3cac751d6d4afa8d83b5d92a]
stable/5.15: [64287cd456a22373053998c1fccf14b651e9cbbd]
stable/5.4: [89ac597e3e807b91e2ebd6a7c36fec7b97290233]
stable/6.1: [1004fc90f0d79a4b7d9e3d432729914f472f9ad1]

CVE-2023-52897: btrfs: qgroup: do not warn on record without old_roots populated

Announce: https://lore.kernel.org/linux-cve-announce/2024082112-CVE-2023-52897-e4ef@gregkh/

Introduced by commit e15e9f4 ("btrfs: introduce
BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting") in
v6.1-rc1.
Fixed in v6.2-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75181406b4eafacc531ff2ee5fb032bd93317e2b]
stable/6.1: [bb2c2e62539f2b63c5e0beb51501d328260c7595]

CVE-2023-52898: xhci: Fix null pointer dereference when host dies

Announce: https://lore.kernel.org/linux-cve-announce/2024082112-CVE-2023-52898-f25e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc5.
4.4 does not call xhci_free_virt_device() in the xhci_free_dev() so it might not
be affected.

Fixed status
mainline: [a2bc47c43e70cf904b1af49f76d572326c08bca7]
stable/4.19: [6fac4b5cecb3928a0a81069aaa815a2edc8dd5a1]
stable/5.10: [081105213ff6f661c114781d469233c7d0e09c2e]
stable/5.15: [c462ac871f49753eca86bb960f573b993976a5ea]
stable/5.4: [133b902378e4acbd824c29dd0d48570ad596e368]
stable/6.1: [ea2ee5e9991caf74e0604f994c1831a5867055b2]

CVE-2023-52899: Add exception protection processing for vd in
axi_chan_handle_err function

Announce: https://lore.kernel.org/linux-cve-announce/2024082112-CVE-2023-52899-f644@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc5.
Affected file was added by commit 1fe20f1 ("dmaengine: Introduce DW
AXI DMAC driver") in 4.17-rc1.

Fixed status
mainline: [57054fe516d59d03a7bcf1888e82479ccc244f87]
stable/4.19: [f534dc438828cc3f1f8c6895b8bdfbef079521fb]
stable/5.10: [20d0a6d17e85a8a816a64fa7d7cae616f1617833]
stable/5.15: [5054d001ffaf76155637c5e5b922c11016cd6a5d]
stable/5.4: [53dd833fd0a2d8f0118d01ea063a70652689d31e]
stable/6.1: [51a7ad5b60efac65691729d10745c28fa1016b96]

CVE-2023-52900: nilfs2: fix general protection fault in nilfs_btree_insert()

Announce: https://lore.kernel.org/linux-cve-announce/2024082112-CVE-2023-52900-32f2@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc5.

Fixed status
cip/4.4: [42d444a8929e760657ea9dacfaa2c9a96e721e5e]
cip/4.4-rt: [42d444a8929e760657ea9dacfaa2c9a96e721e5e]
cip/4.4-st: [42d444a8929e760657ea9dacfaa2c9a96e721e5e]
mainline: [7633355e5c7f29c049a9048e461427d1d8ed3051]
stable/4.19: [d9fde9eab1766170ff2ade67d09178d2cfd78749]
stable/5.10: [712bd74eccb9d3626a0a236641962eca8e11a243]
stable/5.15: [45627a1a6450662e1e0f8174ef07b05710a20062]
stable/5.4: [b0ba060d3287108eba17603bee3810e4cf2c272d]
stable/6.1: [0bf463939c09e5b2c35c71ed74a5fd60a74d6a04]

CVE-2023-52901: usb: xhci: Check endpoint is valid before dereferencing it

Announce: https://lore.kernel.org/linux-cve-announce/2024082113-CVE-2023-52901-c9fb@gregkh/

Introduced by commit 50e8725 ("xhci: Refactor command watchdog and fix
split string.") in v3.15-rc1.
Fixed in v6.2-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8fb5bc76eb86437ab87002d4a36d6da02165654]
stable/4.19: [2d2820d5f375563690c96e60676855205abfb7f5]
stable/5.10: [66fc1600855c05c4ba4e997184c91cf298e0405c]
stable/5.15: [f39c813af0b64f44af94e435c07bfa1ddc2575f5]
stable/5.4: [9891e5c73cab3fd9ed532dc50e9799e55e974766]
stable/6.1: [08864dc14a6803f0377ca77b9740b26db30c020f]

CVE-2023-52902: nommu: fix memory leak in do_mmap() error path

Announce: https://lore.kernel.org/linux-cve-announce/2024082113-CVE-2023-52902-d3fa@gregkh/

Introduced by commit 8220543 ("nommu: remove uses of VMA linked list")
in v6.1-rc1.
Fixed in v6.2-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f31cced5724e6d414fe750aa1cd7e7b578ec22f]
stable/6.1: [1442d51026c58e7c11dd5f9b19650632a48676d4]

CVE-2023-52903: io_uring: lock overflowing for IOPOLL

Announce: https://lore.kernel.org/linux-cve-announce/2024082113-CVE-2023-52903-ad59@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc4.

Fixed status
mainline: [544d163d659d45a206d8929370d5a2984e546cb7]
stable/5.10: [de77faee280163ff03b7ab64af6c9d779a43d4c4]
stable/5.15: [ed4629d1e968359fbb91d0a3780b1e86a2c08845]
stable/6.1: [7fc3990dad04a677606337ebc61964094d6cb41b]

CVE-2023-52904: ALSA: usb-audio: Fix possible NULL pointer dereference
in snd_usb_pcm_has_fixed_rate()

Announce: https://lore.kernel.org/linux-cve-announce/2024082113-CVE-2023-52904-b85a@gregkh/

None
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92a9c0ad86d47ff4cce899012e355c400f02cfb8]
stable/6.1: [a474d4ad59cd4642d1b7e3a6c08cef9eca0992c8]

CVE-2023-52905: octeontx2-pf: Fix resource leakage in VF driver unbind

Announce: https://lore.kernel.org/linux-cve-announce/2024082113-CVE-2023-52905-53fd@gregkh/

Introduced by commit 2da4894 ("octeontx2-pf: devlink params support to
set mcam entry count") in v5.15-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53da7aec32982f5ee775b69dce06d63992ce4af3]
stable/6.1: [c8ca0ad10df08ea36bcac1288062d567d22604c9]

CVE-2023-52906: net/sched: act_mpls: Fix warning during failed
attribute validation

Announce: https://lore.kernel.org/linux-cve-announce/2024082114-CVE-2023-52906-7967@gregkh/

Introduced by commit 2a2ea50 ("net: sched: add mpls manipulation
actions to TC") in v5.3-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e17f99220d111ea031b44153fdfe364b0024ff2]
stable/5.10: [453277feb41c2235cf2c0de9209eef962c401457]
stable/5.15: [9e2c38827cdc6fdd3bb375c8607fc04d289756f9]
stable/5.4: [2b157c3c5d6b8ddca48d53c9e662032f65af8d61]
stable/6.1: [8a97b544b98e44f596219ebb290fd2ba2fd5d644]

CVE-2023-52907: nfc: pn533: Wait for out_urb's completion in
pn533_usb_send_frame()

Announce: https://lore.kernel.org/linux-cve-announce/2024082114-CVE-2023-52907-faaf@gregkh/

Introduced by commit c46ee38 ("NFC: pn533: add NXP pn533 nfc device
driver") in v3.1-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9dab880d675b9d0dd56c6428e4e8352a3339371d]
stable/4.19: [321db5131c92983dac4f3338e8fbb6df214238c0]
stable/5.10: [0ca78c99656f5c448567db1e148367aa3b01c80a]
stable/5.15: [39ae73e581112cfe27ba50aecb1c891ce57cecb1]
stable/5.4: [9424d2205fe94a095fb9365ec0c6137f0b394a2b]
stable/6.1: [8998db5021a28ad67aa8d627bdb4226e4046ccc4]

CVE-2023-52908: drm/amdgpu: Fix potential NULL dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024082114-CVE-2023-52908-537f@gregkh/

Introduced by commit 7554886 ("drm/amdgpu: Fix size validation for non-exclusive
domains (v4)") in 6.2-rc1. Fixed in 6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0be7ed8e7eb15282b5d0f6fdfea884db594ea9bf]
stable/6.1: [f2faf0699af78968a27ca154bf76e94247f8c471]

CVE-2023-52909: nfsd: fix handling of cached open files in nfsd4_open codepath

Announce: https://lore.kernel.org/linux-cve-announce/2024082114-CVE-2023-52909-f80d@gregkh/

Introduced by commit fb70bf1 ("NFSD: Instantiate a struct file when
creating a regular NFSv4 file") in v5.19-rc1.
Fixed in v5.15.154.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [0b778361998d6c6356b8d2fc7ddf025fb3224654]
stable/5.10: [45c08a752982116f3287afcd1bd9c50f4fab0c28]
stable/6.1: [45c08a752982116f3287afcd1bd9c50f4fab0c28]

CVE-2023-52910: iommu/iova: Fix alloc iova overflows issue

Announce: https://lore.kernel.org/linux-cve-announce/2024082115-CVE-2023-52910-3067@gregkh/

Introduced by commit 4e89dce ("iommu/iova: Retry from last rb tree
node if iova search fails") in v5.11-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dcdb3ba7e2a8caae7bfefd603bc22fd0ce9a389c]
stable/5.15: [c929a230c84441e400c32e7b7b4ab763711fb63e]
stable/6.1: [61cbf790e7329ed78877560be7136f0b911bba7f]

CVE-2023-52911: drm/msm: another fix for the headless Adreno GPU

Announce: https://lore.kernel.org/linux-cve-announce/2024082115-CVE-2023-52911-28fa@gregkh/

Introduced by commit 0a58d2a ("drm/msm: Make .remove and .shutdown HW
shutdown consistent") in v6.1-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00dd060ab3cf95ca6ede7853bc14397014971b5e]
stable/6.1: [b107b08c41b3076a508113fbaaffe15ce1fe7f65]

CVE-2023-52912: drm/amdgpu: Fixed bug on error when unloading amdgpu

Announce: https://lore.kernel.org/linux-cve-announce/2024082115-CVE-2023-52912-a6c0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc4.
Affected file was introduced by commit 6a7f76e70fac ("drm/amdgpu: add
VRAM manager v2") in 4.10-rc1.

Fixed status
mainline: [99f1a36c90a7524972be5a028424c57fa17753ee]
stable/6.1: [9196eb7c52e55749a332974f0081f77d53d60199]

CVE-2023-52913: drm/i915: Fix potential context UAFs

Announce: https://lore.kernel.org/linux-cve-announce/2024082115-CVE-2023-52913-5347@gregkh/

Introduced by commit eb4deda ("drm/i915/gem: Delay tracking the GEM
context until it is registered") in v5.10-rc1.
Introduced by commit a4c1cdd ("drm/i915/gem: Delay context creation
(v3)") in v5.15-rc1.
Introduced by commit 49bd54b ("drm/i915: Track all user contexts per
client") in v5.19-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [afce71ff6daa9c0f852df0727fe32c6fb107f0fa]
stable/6.1: [b696c627b3f56e173f7f70b8487d66da8ff22506]

CVE-2023-52914: io_uring/poll: add hash if ready poll request can't
complete inline

Announce: https://lore.kernel.org/linux-cve-announce/2024082115-CVE-2023-52914-473c@gregkh/

Introduced by commit 49f1c68 ("io_uring: optimise submission side
poll_refs") in v6.0-rc1.
Fixed in v6.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [febb985c06cb6f5fac63598c0bffd4fd823d110d]
stable/6.1: [4ad6c063541665c407d17e1faf2fe4f04e947dcc]

CVE-2024-43862: net: wan: fsl_qmc_hdlc: Convert carrier_lock spinlock to a mutex

Announce: https://lore.kernel.org/linux-cve-announce/2024082154-CVE-2024-43862-636a@gregkh/

Introduced by commit 5476291 ("net: wan: fsl_qmc_hdlc: Add framer
support") in v6.9-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4d6a347ba7babdf9d90a0eb24048c266cae0532]

CVE-2024-43863: drm/vmwgfx: Fix a deadlock in dma buf fence polling

Announce: https://lore.kernel.org/linux-cve-announce/2024082156-CVE-2024-43863-9124@gregkh/

Introduced by commit 2298e80 ("drm/vmwgfx: rework to new fence
interface, v2") in v3.18-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e58337100721f3cc0c7424a18730e4f39844934f]
stable/5.15: [9e20d028d8d1deb1e7fed18f22ffc01669cf3237]
stable/6.1: [3b933b16c996af8adb6bc1b5748a63dfb41a82bc]
stable/6.6: [a8943969f9ead2fd3044fc826140a21622ef830e]

CVE-2024-43864: net/mlx5e: Fix CT entry update leaks of modify header context

Announce: https://lore.kernel.org/linux-cve-announce/2024082156-CVE-2024-43864-81ad@gregkh/

Introduced by commit 94ceffb ("net/mlx5e: Implement CT entry update")
in v6.3-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [025f2b85a5e5a46df14ecf162c3c80a957a36d0b]
stable/6.6: [daab2cc17b6b6ab158566bba037e9551fd432b59]

CVE-2024-43865: s390/fpu: Re-add exception handling in load_fpu_state()

Announce: https://lore.kernel.org/linux-cve-announce/2024082156-CVE-2024-43865-743d@gregkh/

Introduced by commit 8c09871 ("s390/fpu: limit save and restore to
used registers") in v6.9-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4734406c39238cbeafe66f0060084caa3247ff53]

CVE-2024-43866: net/mlx5: Always drain health in shutdown callback

Announce: https://lore.kernel.org/linux-cve-announce/2024082157-CVE-2024-43866-66ed@gregkh/

Introduced by commit 1958fc2 ("net/mlx5: SF, Add auxiliary device
driver") in v5.12-rc1.
Introduced by commit d2aa060 ("net/mlx5: Cancel health poll before
sending panic teardown command") in v4.14.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b75da22ed1e6171e261bc9265370162553d5393]
stable/6.6: [6b6c2ebd83f2bf97e8f221479372aaca97a4a9b2]

CVE-2024-43867: drm/nouveau: prime: fix refcount underflow

Announce: https://lore.kernel.org/linux-cve-announce/2024082157-CVE-2024-43867-0620@gregkh/

Introduced by commit ab9ccb9 ("drm/nouveau: use prime helpers") in v3.9-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9bf3efc33f1fbf88787a277f7349459283c9b95]
stable/5.10: [906372e753c5027a1dc88743843b6aa2ad1aaecf]
stable/5.15: [16998763c62bb465ebc409d0373b9cdcef1a61a6]
stable/5.4: [3bcb8bba72ce89667fa863054956267c450c47ef]
stable/6.1: [ebebba4d357b6c67f96776a48ddbaf0060fa4c10]
stable/6.6: [f23cd66933fe76b84d8e282e5606b4d99068c320]

CVE-2024-43868: riscv/purgatory: align riscv_kernel_entry

Announce: https://lore.kernel.org/linux-cve-announce/2024082157-CVE-2024-43868-9a44@gregkh/

Introduced by commit 736e30a ("RISC-V: Add purgatory") in v5.19-rc1.
Fixed in v6.11-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb197c5d2fd24b9af3d4697d0cf778645846d6d5]

CVE-2024-43869: perf: Fix event leak upon exec and file release

Announce: https://lore.kernel.org/linux-cve-announce/2024082133-CVE-2024-43869-26aa@gregkh/

Introduced by commit 517e6a3 ("perf: Fix perf_pending_task() UaF") in v6.1-rc8.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [3a5465418f5fd970e86a86c7f4075be262682840]
stable/5.15: [9ad46f1fef421d43cdab3a7d1744b2f43b54dae0]
stable/6.1: [ed2c202dac55423a52d7e2290f2888bf08b8ee99]
stable/6.6: [104e258a004037bc7dba9f6085c71dad6af57ad4]

CVE-2024-43870: perf: Fix event leak upon exit

Announce: https://lore.kernel.org/linux-cve-announce/2024082135-CVE-2024-43870-2b6f@gregkh/

Introduced by commit 517e6a3 ("perf: Fix perf_pending_task() UaF") in v6.1-rc8.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [2fd5ad3f310de22836cdacae919dd99d758a1f1b]
stable/5.15: [67fad724f1b568b356c1065d50df46e6b30eb2f7]
stable/6.1: [70882d7fa74f0731492a0d493e8515a4f7131831]
stable/6.6: [05d3fd599594abf79aad4484bccb2b26e1cb0b51]

CVE-2024-43871: devres: Fix memory leakage caused by driver API
devm_free_percpu()

Announce: https://lore.kernel.org/linux-cve-announce/2024082136-CVE-2024-43871-c2cd@gregkh/

Introduced by commit ff86aae ("devres: add devm_alloc_percpu()") in v4.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd50a974097bb82d52a458bd3ee39fb723129a0c]
stable/4.19: [700e8abd65b10792b2f179ce4e858f2ca2880f85]
stable/5.10: [ef56dcdca8f2a53abc3a83d388b8336447533d85]
stable/5.15: [3047f99caec240a88ccd06197af2868da1af6a96]
stable/5.4: [b044588a16a978cd891cb3d665dd7ae06850d5bf]
stable/6.1: [3dcd0673e47664bc6c719ad47dadac6d55d5950d]
stable/6.6: [b67552d7c61f52f1271031adfa7834545ae99701]

CVE-2024-43872: RDMA/hns: Fix soft lockup under heavy CEQE load

Announce: https://lore.kernel.org/linux-cve-announce/2024082136-CVE-2024-43872-c87e@gregkh/

Introduced by commit a5073d6 ("RDMA/hns: Add eq support of hip08") in v4.16-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2fdf34038369c0a27811e7b4680662a14ada1d6b]

CVE-2024-43873: vhost/vsock: always initialize seqpacket_allow

Announce: https://lore.kernel.org/linux-cve-announce/2024082136-CVE-2024-43873-c547@gregkh/

Introduced by commit ced7b71 ("vhost/vsock: support SEQPACKET for
transport"). in v5.14-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e1fdcbdde3b7663e5d8faeb2245b9b151417d22]
stable/5.15: [ea558f10fb05a6503c6e655a1b7d81fdf8e5924c]
stable/6.1: [3062cb100787a9ddf45de30004b962035cd497fb]
stable/6.6: [30bd4593669443ac58515e23557dc8cef70d8582]

CVE-2024-43874: crypto: ccp - Fix null pointer dereference in
__sev_snp_shutdown_locked

Announce: https://lore.kernel.org/linux-cve-announce/2024082136-CVE-2024-43874-edda@gregkh/

Introduced by commit 1ca5614 ("crypto: ccp: Add support to initialize
the AMD-SP for SEV-SNP") in v6.9-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [468e3295774d0edce15f4ae475913b5076dd4f40]

CVE-2024-43875: PCI: endpoint: Clean up error handling in vpci_scan_bus()

Announce: https://lore.kernel.org/linux-cve-announce/2024082136-CVE-2024-43875-1257@gregkh/

Introduced by commit e35f56b ("PCI: endpoint: Support NTB transfer
between RC and EP") in v6.0-rc1.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [8e0f5a96c534f781e8c57ca30459448b3bfe5429]
stable/5.15: [24414c842a24d0fd498f9db6d2a762a8dddf1832]
stable/6.1: [7d368de78b60088ec9031c60c88976c0063ea4c0]
stable/6.6: [0e27e2e8697b8ce96cdef43f135426525d9d1f8f]

CVE-2024-43876: PCI: rcar: Demote WARN() to dev_warn_ratelimited() in
rcar_pcie_wakeup()

Announce: https://lore.kernel.org/linux-cve-announce/2024082137-CVE-2024-43876-793b@gregkh/

Introduced by commit 84b5761 ("PCI: rcar: Finish transition to L1
state in rcar_pcie_config_access()") in v5.18-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c93637e6a4c4e1d0e85ef7efac78d066bbb24d96]
stable/6.1: [2ae4769332dfdb97f4b6f5dc9ac8f46d02aaa3df]
stable/6.6: [526a877c6273d4cd0d0aede84c1d620479764b1c]

CVE-2024-43877: media: pci: ivtv: Add check for DMA map result

Announce: https://lore.kernel.org/linux-cve-announce/2024082137-CVE-2024-43877-e8e4@gregkh/

Introduced by commit 1932dc2 ("media: pci/ivtv: switch from 'pci_' to
'dma_' API") in v5.16-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [629913d6d79508b166c66e07e4857e20233d85a9]
stable/6.1: [24062aa7407091dee3e45a8e8037df437e848718]
stable/6.6: [3d8fd92939e21ff0d45100ab208f8124af79402a]

CVE-2024-43878: xfrm: Fix input error path memory access

Announce: https://lore.kernel.org/linux-cve-announce/2024082137-CVE-2024-43878-2b2b@gregkh/

Introduced by commit 304b44f ("xfrm: Add dir validation to "in" data
path lookup") in v6.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [54fcc6189dfb822eea984fa2b3e477a02447279d]

CVE-2024-43879: wifi: cfg80211: handle 2x996 RU allocation in
cfg80211_calculate_bitrate_he()

Announce: https://lore.kernel.org/linux-cve-announce/2024082137-CVE-2024-43879-95cb@gregkh/

Introduced by commit c4cbaf7 ("cfg80211: Add support for HE") in v4.19-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bcbd771cd5d68c0c52567556097d75f9fc4e7cd6]
stable/4.19: [45d20a1c54be4f3173862c7b950d4468447814c9]
stable/5.10: [2e201b3d162c6c49417c438ffb30b58c9f85769f]
stable/5.15: [576c64622649f3ec07e97bac8fec8b8a2ef4d086]
stable/5.4: [b289ebb0516526cb4abae081b7ec29fd4fa1209d]
stable/6.1: [16ad67e73309db0c20cc2a651992bd01c05e6b27]
stable/6.6: [67b5f1054197e4f5553047759c15c1d67d4c8142]

CVE-2024-43880: mlxsw: spectrum_acl_erp: Fix object nesting warning

Announce: https://lore.kernel.org/linux-cve-announce/2024082137-CVE-2024-43880-78ec@gregkh/

Introduced by commit 9069a38 ("lib: objagg: implement optimization
hints assembly and use hints for object creation") in v5.1-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97d833ceb27dc19f8777d63f90be4a27b5daeedf]
stable/5.10: [36a9996e020dd5aa325e0ecc55eb2328288ea6bb]
stable/5.15: [9a5261a984bba4f583d966c550fa72c33ff3714e]
stable/5.4: [4dc09f6f260db3c4565a4ec52ba369393598f2fb]
stable/6.1: [25c6fd9648ad05da493a5d30881896a78a08b624]
stable/6.6: [0e59c2d22853266704e127915653598f7f104037]

CVE-2024-43881: wifi: ath12k: change DMA direction while mapping
reinjected packets

Announce: https://lore.kernel.org/linux-cve-announce/2024082138-CVE-2024-43881-ead4@gregkh/

Introduced by commit d889913 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in v6.3-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33322e3ef07409278a18c6919c448e369d66a18e]
stable/6.6: [e99d9b16ff153de9540073239d24adc3b0a3a997]

CVE-2024-43882: exec: Fix ToCToU between perm check and set-uid/gid usage

Announce: https://lore.kernel.org/linux-cve-announce/2024082152-CVE-2024-43882-4fa4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc4.

Fixed status
mainline: [f50733b45d865f91db90919f8311e2127ce5a0cb]
stable/4.19: [d5c3c7e26275a2d83b894d30f7582a42853a958f]
stable/5.10: [15469d46ba34559bfe7e3de6659115778c624759]
stable/5.15: [9b424c5d4130d56312e2a3be17efb0928fec4d64]
stable/5.4: [368f6985d46657b8b466a421dddcacd4051f7ada]
stable/6.1: [f6cfc6bcfd5e1cf76115b6450516ea4c99897ae1]
stable/6.6: [d2a2a4714d80d09b0f8eb6438ab4224690b7121e]


* Updated CVEs

CVE-2024-22386: NULL pointer dereference bug was found in drm/exynos
device driver

stable/4.19, stable/5.10, stable/5.15, stable/5.4, stable/6.1 were fixed.

Fixed status
stable/4.19: [9ac69bda79677028972098c56fa2e1a5031e1182]
stable/5.10: [5475b8bea1489403a4e6c2d102fcb5dde310acb3]
stable/5.15: [3157aa794c7540502d458b731efd6bd5d2827e3f]
stable/5.4: [279e32b79d03a9f6189bbf05b253003fdb261a14]
stable/6.1: [edddbdb8122e82a2427c1b9c9df4497f3aacc0bc]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

