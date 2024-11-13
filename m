Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE9DD637CE
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 22:16:34 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
 by mx.groups.io with SMTP id smtpd.web10.24451.1731536192074024798
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Nov 2024 14:16:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=wKkxtq1a;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.173, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e34339d41bso37597b3.0
        for <cip-dev@lists.cip-project.org>; Wed, 13 Nov 2024 14:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1731536191; x=1732140991; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xwGd/s+EiAE+Nw2TLtXSiBrROekifNsJSyVEf+Z+ecE=;
        b=wKkxtq1am2l1fsXoTDIwJeyFNnR/cpf5MWNTHQbc46JQqn2pqc/OPwO38H6Z2WjBJq
         HAris1I0CCNsqTqdQ9nm2tHDiLobTTKKggcg8NPtaQMAeOw9blKaHV+YyLCJ/pNezlKy
         vwTYldKYKVPtVERfSdAzgbaFDcPioQRdCL0yNeMp0qcs7TMn9xDHYf2sP1dbHNhyEWjZ
         hi6pask7qi52DF00dWjiF+LhELa4aKhzPn5b+HPB3TYa6mrxrLfhtVS0SJRTt7oeiZm6
         +zzstOnBYqpqKMdCqOGLSYigEVVyGSj0/mx7tkpfS0+yguLad72v5NRjC/GkKiDjNOZd
         Y0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731536191; x=1732140991;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xwGd/s+EiAE+Nw2TLtXSiBrROekifNsJSyVEf+Z+ecE=;
        b=CEeMHr65pPB6kMnO/Bk1RqH28jNBs0rIdt4/3C8nwe2ktDZ9OAqdrAyEJMUvjLYh46
         KmHCxw5NwvPF78C4SSGTZ0pBgkKgolrlFm/fd1djeP0PxKo/z7xVIksx/A0eI1+RUcdy
         lpk08PTQ6q6ahA8v0lIqPkxvBkoLMUEXwUDZwLz8Nft3Q1S+krZe8O4RjJSsX0WUFWku
         85CRoB3q5yV1oAjDqDnOSFvrf3b6079d3MZzEAnviFb1NSLo85LDUqQsbouctUQw4yRn
         BSO21mGxEZYyrIs2PX2Vdy8NMhu6kEdP3ObY8BLC6YrPo54IznQTlJGRMs92ziGmWJBO
         MrTw==
X-Gm-Message-State: AOJu0YwUv7MavMPo4gMD2XNJnh1kGGLta2Gp/QkSUx/zeEXUNjWLLWfr
	eoKuZ0CT1/SeSdwVdV5K8wtg82SOLwNzJzZ3lQEmeKHiPo4pE5JrN3ufjglIqlKFDI//7MU3YbJ
	6SKaXu0GR4j29XbvtT23Dpo4zjWT3G03N2bhZwUA+Ry/XVHxDU4g=
X-Google-Smtp-Source: AGHT+IGvH6WvpN5/+kJynWO0io+7qLCbQHP38X3CNy/CwZLu5EaMmgZvQyhxAdkQxzZkjeeul2SzMVOe235qGusRCyk=
X-Received: by 2002:a05:690c:620a:b0:6e3:420f:a2d1 with SMTP id
 00721157ae682-6eadddb0f82mr220635387b3.23.1731536188797; Wed, 13 Nov 2024
 14:16:28 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 14 Nov 2024 07:15:52 +0900
Message-ID: <CAODzB9rd5-GFse9vg0ton5OsWyip2EGr-Y+n1G-JRd1sbJFqWw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Nov 2024 22:16:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17249

Hi!

It's this week's CVE report.

This week reported 51 new CVEs and 131 updated CVEs.

* New CVEs
CVE-2023-52920: bpf: support non-r10 register spill/fill to/from stack
in precision tracking

Announce: https://lore.kernel.org/linux-cve-announce/2024110518-CVE-2023-52920-17f6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.8-rc1.

Fixed status
mainline: [41f6f64e6999a837048b1bd13a2f8742964eca6b]

CVE-2024-50089: unicode: Don't special case ignorable code points

Announce: https://lore.kernel.org/linux-cve-announce/2024110548-CVE-2024-50089-d96d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc3.

Fixed status
mainline: [5c26d2f1d3f5e4be3e196526bead29ecb139cf91]
stable/5.10: [39fffca572844d733b137a0ff9eacd67b9b0c8e3]
stable/5.15: [651b954cd8d5b0a358ceb47c93876bb6201224e4]
stable/6.1: [21526498d25e54bda3c650f756493d63fd9131b7]
stable/6.6: [ac20736861f3c9c8e0a78273a4c57e9bcb0d8cc6]

CVE-2024-50090: drm/xe/oa: Fix overflow in oa batch buffer

Announce: https://lore.kernel.org/linux-cve-announce/2024110551-CVE-2024-50090-2727@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
The drm/xe driver was added by commit dd08ebf6c ("drm/xe: Introduce a new DRM
driver for Intel GPUs") in 6.8-rc1.

Fixed status
mainline: [6c10ba06bb1b48acce6d4d9c1e33beb9954f1788]

CVE-2024-50091: dm vdo: don't refer to dedupe_context after releasing it

Announce: https://lore.kernel.org/linux-cve-announce/2024110551-CVE-2024-50091-0c7e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.
Affected file was added by commit cfaf07fae7a2 ("dm vdo: add hash locks and
hash zones") in 6.9-rc1.

Fixed status
mainline: [0808ebf2f80b962e75741a41ced372a7116f1e26]

CVE-2024-50092: net: netconsole: fix wrong warning

Announce: https://lore.kernel.org/linux-cve-announce/2024110551-CVE-2024-50092-b565@gregkh/

Introduced by commit 1ec9daf ("net: netconsole: append userdata to
fragmented netconsole messages") in v6.9-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d94785bb46b6167382b1de3290eccc91fa98df53]

CVE-2024-50093: thermal: intel: int340x: processor: Fix warning during
module unload

Announce: https://lore.kernel.org/linux-cve-announce/2024110551-CVE-2024-50093-2811@gregkh/

Introduced by commit acd65d5
("thermal/drivers/int340x/processor_thermal: Add PCI MMIO based
thermal driver") in v5.14-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99ca0b57e49fb73624eede1c4396d9e3d10ccf14]
stable/5.15: [8403021b6f32d68a7e3a6b8428ecaf5c153a9974]
stable/6.1: [b4ab78f4adeaf6c98be5d375518dd4fb666eac5e]
stable/6.6: [dd64ea03375618684477f946be4f5e253f8676c2]

CVE-2024-50094: sfc: Don't invoke xdp_do_flush() from netpoll.

Announce: https://lore.kernel.org/linux-cve-announce/2024110551-CVE-2024-50094-5963@gregkh/

Introduced by commit 401cb7d ("net: Reference bpf_redirect_info via
task_struct on PREEMPT_RT.") in v6.11-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55e802468e1d38dec8e25a2fdb6078d45b647e8c]

CVE-2024-50095: RDMA/mad: Improve handling of timed out WRs of mad agent

Announce: https://lore.kernel.org/linux-cve-announce/2024110551-CVE-2024-50095-7abe@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc1.

Fixed status
mainline: [2a777679b8ccd09a9a65ea0716ef10365179caac]
stable/5.10: [713adaf0ecfc49405f6e5d9e409d984f628de818]
stable/5.15: [7022a517bf1ca37ef5a474365bcc5eafd345a13a]
stable/6.1: [e80eadb3604a92d2d086e956b8b2692b699d4d0a]
stable/6.6: [a195a42dd25ca4f12489687065d00be64939409f]

CVE-2024-50096: nouveau/dmem: Fix vulnerability in migrate_to_ram upon
copy error

Announce: https://lore.kernel.org/linux-cve-announce/2024110552-CVE-2024-50096-daf5@gregkh/

Introduced by commit 5be73b6 ("drm/nouveau/dmem: device memory helpers
for SVM") in v5.1-rc1.
Fixed in v6.12-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [835745a377a4519decd1a36d6b926e369b3033e2]
stable/5.10: [73f75d2b5aee5a735cf64b8ab4543d5c20dbbdd9]
stable/5.15: [8c3de9282dde21ce3c1bf1bde3166a4510547aa9]
stable/6.1: [614bfb2050982d23d53d0d51c4079dba0437c883]
stable/6.6: [697e3ddcf1f8b68bd531fc34eead27c000bdf3e1]

CVE-2024-50097: net: fec: don't save PTP state if PTP is unsupported

Announce: https://lore.kernel.org/linux-cve-announce/2024110552-CVE-2024-50097-39b6@gregkh/

Introduced by commit a1477dc ("net: fec: Restart PPS after link state
change") in v6.12-rc2.
Fixed in v6.12-rc3.
Bug introduced commit was backported to following branches.
stable/6.11 stable/6.6

Fixed status
mainline: [6be063071a457767ee229db13f019c2ec03bfe44]
stable/6.6: [7745e14f4c036ce94a5eb05d06e49b0d84b306f9]

CVE-2024-50098: scsi: ufs: core: Set SDEV_OFFLINE when UFS is shut down

Announce: https://lore.kernel.org/linux-cve-announce/2024110526-CVE-2024-50098-82f2@gregkh/

Introduced by commit b294ff3 ("scsi: ufs: core: Enable power
management for wlun") in v5.14-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19a198b67767d952c8f3d0cf24eb3100522a8223]
stable/6.1: [7de759fceacff5660abf9590d11114215a9d5f3c]
stable/6.6: [7bd9af254275fad7071d85f04616560deb598d7d]

CVE-2024-50099: arm64: probes: Remove broken LDR (literal) uprobe support

Announce: https://lore.kernel.org/linux-cve-announce/2024110526-CVE-2024-50099-1758@gregkh/

Introduced by commit 9842cea ("arm64: Add uprobe support") in v4.10-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [acc450aa07099d071b18174c22a1119c57da8227]
stable/5.10: [3728b4eb27910ffedd173018279a970705f2e03a]
stable/5.15: [ad4bc35a6d22e9ff9b67d0d0c38bce654232f195]
stable/6.1: [bae792617a7e911477f67a3aff850ad4ddf51572]
stable/6.6: [9f1e7735474e7457a4d919a517900e46868ae5f6]

CVE-2024-50100: USB: gadget: dummy-hcd: Fix "task hung" problem

Announce: https://lore.kernel.org/linux-cve-announce/2024110526-CVE-2024-50100-be1f@gregkh/

Introduced by commit a7f3813 ("usb: gadget: dummy_hcd: Switch to
hrtimer transfer scheduler") in v6.10-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5189df7b8088268012882c220d6aca4e64981348]

CVE-2024-50101: iommu/vt-d: Fix incorrect pci_for_each_dma_alias() for
non-PCI devices

Announce: https://lore.kernel.org/linux-cve-announce/2024110526-CVE-2024-50101-d1bb@gregkh/

Introduced by commit 9a16ab9 ("iommu/vt-d: Make context clearing
consistent with context mapping") in v6.7-rc4.
Fixed in v6.12-rc4.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [6e02a277f1db24fa039e23783c8921c7b0e5b1b3]
stable/5.15: [0bd9a30c22afb5da203386b811ec31429d2caa78]
stable/6.1: [cbfa3a83eba05240ce37839ed48280a05e8e8f6c]
stable/6.6: [fe2e0b6cd00abea3efac66de1da22d844364c1b0]

CVE-2024-50102: x86: fix user address masking non-canonical speculation issue

Announce: https://lore.kernel.org/linux-cve-announce/2024110553-CVE-2024-50102-3d1e@gregkh/

Introduced by commit 2865baf ("x86: support user address masking
instead of non-speculative conditional") in v6.12-rc1.
Introduced by commit 6014bc2 ("x86-64: make access_ok() independent of
LAM") in v6.4-rc1.
Introduced by commit b19b74b ("x86/mm: Rework address range check in
get_user() and put_user()") in v6.4-rc1.
Fixed in v6.12-rc5.
Bug introduced commit was backported to following branches.
stable/6.11

Fixed status
mainline: [86e6b1547b3d013bc392adf775b89318441403c2]

CVE-2024-50103: ASoC: qcom: Fix NULL Dereference in
asoc_qcom_lpass_cpu_platform_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024110553-CVE-2024-50103-3541@gregkh/

Introduced by commit b5022a3 ("ASoC: qcom: lpass: Use regmap_field for
i2sctl and dmactl registers") in v5.10-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49da1463c9e3d2082276c3e0e2a8b65a88711cd2]
stable/5.15: [a8e691fe1894c8bdf815a6171ee22ae7da8b18aa]
stable/6.1: [e19bf49e903337641fc230d430d49813e3199902]
stable/6.6: [73cc3f905ca9aa95694eea3dfa1acadc90686368]

CVE-2024-50104: ASoC: qcom: sdm845: add missing soundwire runtime stream alloc

Announce: https://lore.kernel.org/linux-cve-announce/2024110553-CVE-2024-50104-a729@gregkh/

Introduced by commit 15c7fab ("ASoC: qcom: Move Soundwire runtime
stream alloc to soundcards") in v6.8-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0e806b0cc6260b59c65e606034a63145169c04c]

CVE-2024-50105: ASoC: qcom: sc7280: Fix missing Soundwire runtime stream alloc

Announce: https://lore.kernel.org/linux-cve-announce/2024110553-CVE-2024-50105-6efa@gregkh/

Introduced by commit 15c7fab ("ASoC: qcom: Move Soundwire runtime
stream alloc to soundcards") in v6.8-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db7e59e6a39a4d3d54ca8197c796557e6d480b0d]

CVE-2024-50106: nfsd: fix race between laundromat and free_stateid

Announce: https://lore.kernel.org/linux-cve-announce/2024110553-CVE-2024-50106-c095@gregkh/

Introduced by commit 2d4a532 ("nfsd: ensure that clp->cl_revoked list
is protected by clp->cl_lock") in v3.17-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8dd91e8d31febf4d9cca3ae1bb4771d33ae7ee5a]

CVE-2024-50107: platform/x86/intel/pmc: Fix pmc_core_iounmap to call
iounmap for valid addresses

Announce: https://lore.kernel.org/linux-cve-announce/2024110554-CVE-2024-50107-6bdf@gregkh/

Introduced by commit a01486d ("platform/x86/intel/pmc: Cleanup SSRAM
discovery") in v6.8-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48771da48072823956b271dddd568492c13d8170]

CVE-2024-50108: drm/amd/display: Disable PSR-SU on Parade 08-01 TCON too

Announce: https://lore.kernel.org/linux-cve-announce/2024110554-CVE-2024-50108-e842@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc5.
Affected function was added by commit 9dd941015 ("drm/amd/display: implement
shared PSR-SU sink validation helper") in 5.19-rc1.

Fixed status
mainline: [ba1959f71117b27f3099ee789e0815360b4081dd]
stable/6.1: [5660bcc4dd533005248577d5042f1c48cce2b443]
stable/6.6: [c79e0a18e4b301401bb745702830be9041cfbf04]

CVE-2024-50109: md/raid10: fix null ptr dereference in raid10_size()

Announce: https://lore.kernel.org/linux-cve-announce/2024110554-CVE-2024-50109-b93c@gregkh/

Introduced by commit 3d8466b ("md/raid10: use the atomic queue limit
update APIs") in v6.9-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [825711e00117fc686ab89ac36a9a7b252dc349c6]

CVE-2024-50110: xfrm: fix one more kernel-infoleak in algo dumping

Announce: https://lore.kernel.org/linux-cve-announce/2024110554-CVE-2024-50110-b4aa@gregkh/

Introduced by commit c7a5899 ("xfrm: redact SA secret with lockdown
confidentiality") in v5.11-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6889cd2a93e1e3606b3f6e958aa0924e836de4d2]
stable/5.15: [610d4cea9b442b22b4820695fc3335e64849725e]
stable/6.1: [dc2ad8e8818e4bf1a93db78d81745b4877b32972]
stable/6.6: [c73bca72b84b453c8d26a5e7673b20adb294bf54]

CVE-2024-50111: LoongArch: Enable IRQ if do_ale() triggered in
irq-enabled context

Announce: https://lore.kernel.org/linux-cve-announce/2024110554-CVE-2024-50111-fc9b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc5.
LoongArch is not supported by CIP.

Fixed status
mainline: [69cc6fad5df4ce652d969be69acc60e269e5eea1]
stable/6.6: [8915ed160dbd32b5ef5864df9a9fc11db83a77bb]

CVE-2024-50112: x86/lam: Disable ADDRESS_MASKING in most cases

Announce: https://lore.kernel.org/linux-cve-announce/2024110555-CVE-2024-50112-37de@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc5.

Fixed status
mainline: [3267cb6d3a174ff83d6287dcd5b0047bbd912452]
stable/6.6: [60a5ba560f296ad8da153f6ad3f70030bfa3958f]

CVE-2024-50113: firewire: core: fix invalid port index for parent device

Announce: https://lore.kernel.org/linux-cve-announce/2024110555-CVE-2024-50113-fc8e@gregkh/

Introduced by commit 24b7f8e ("firewire: core: use helper functions
for self ID sequence") in v6.11-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6a6780e0b9bbcf311a727afed06fee533a5e957]

CVE-2024-50114: KVM: arm64: Unregister redistributor for failed vCPU creation

Announce: https://lore.kernel.org/linux-cve-announce/2024110555-CVE-2024-50114-80e0@gregkh/

Introduced by commit f616506 ("KVM: arm64: vgic: Don't hold
config_lock while unregistering redistributors") in v6.11-rc5.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae8f8b37610269009326f4318df161206c59843e]

CVE-2024-50115: KVM: nSVM: Ignore nCR3[4:0] when loading PDPTEs from memory

Announce: https://lore.kernel.org/linux-cve-announce/2024110555-CVE-2024-50115-9fae@gregkh/

Introduced by commit e4e517b ("KVM: MMU: Do not unconditionally read
PDPTE from guest memory") in v3.2-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f559b2e9c5c5308850544ab59396b7d53cfc67bd]
stable/5.15: [58cb697d80e669c56197f703e188867c8c54c494]
stable/6.1: [6876793907cbe19d42e9edc8c3315a21e06c32ae]
stable/6.6: [2c4adc9b192a0815fe58a62bc0709449416cc884]

CVE-2024-50116: nilfs2: fix kernel bug due to missing clearing of
buffer delay flag

Announce: https://lore.kernel.org/linux-cve-announce/2024110555-CVE-2024-50116-64fb@gregkh/

Introduced by commit 8c26c4e ("nilfs2: fix issue with flush kernel
thread after remount in RO mode because of driver's internal error or
metadata corruption") in v3.10-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ed469df0bfbef3e4b44fca954a781919db9f7ab]
stable/5.15: [822203f6355f4b322d21e7115419f6b98284be25]
stable/6.1: [27524f65621f490184f2ace44cd8e5f3685af4a3]
stable/6.6: [743c78d455e784097011ea958b27396001181567]

CVE-2024-50117: drm/amd: Guard against bad data for ATIF ACPI method

Announce: https://lore.kernel.org/linux-cve-announce/2024110555-CVE-2024-50117-83b1@gregkh/

Introduced by commit d38ceaf ("drm/amdgpu: add core driver (v4)") in v4.2-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf58f03931fdcf7b3c45cb76ac13244477a60f44]
stable/5.15: [6032287747f874b52dc8b9d7490e2799736e035f]
stable/6.1: [cd67af3c1762de4c2483ae4dbdd98f9ea8fa56e3]
stable/6.6: [975ede2a7bec52b5da1428829b3439667c8a234b]

CVE-2024-50118: btrfs: reject ro->rw reconfiguration if there are hard
ro requirements

Announce: https://lore.kernel.org/linux-cve-announce/2024110556-CVE-2024-50118-498e@gregkh/

Introduced by commit f044b31 ("btrfs: handle the ro->rw transition for
mounting different subvolumes") in v6.8-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c36a72c1d27de6618c1c480c793d9924640f5bb]

CVE-2024-50119: cifs: fix warning when destroy 'cifs_io_request_pool'

Announce: https://lore.kernel.org/linux-cve-announce/2024110556-CVE-2024-50119-7e13@gregkh/

Introduced by commit edea94a ("cifs: Add mempools for cifs_io_request
and cifs_io_subrequest structs") in v6.10-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ce1007f42b8a6a0814386cb056feb28dc6d6091]

CVE-2024-50120: smb: client: Handle kstrdup failures for passwords

Announce: https://lore.kernel.org/linux-cve-announce/2024110556-CVE-2024-50120-07e2@gregkh/

Introduced by commit c1eb537 ("cifs: allow changing password during
remount") in v6.9-rc1.
Fixed in v6.12-rc5.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [9a5dd61151399ad5a5d69aad28ab164734c1e3bc]
stable/6.6: [35dbac8c328d6afe937cd45ecd41d209d0b9f8b8]

CVE-2024-50121: nfsd: cancel nfsd_shrinker_work using sync mode in
nfs4_state_shutdown_net

Announce: https://lore.kernel.org/linux-cve-announce/2024110556-CVE-2024-50121-2a0a@gregkh/

Introduced by commit 7c24fa2 ("NFSD: replace delayed_work with
work_struct for nfsd_client_shrinker") in v6.2-rc5.
Fixed in v6.12-rc5.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [d5ff2fb2e7167e9483846e34148e60c0c016a1f6]
stable/6.6: [f965dc0f099a54fca100acf6909abe52d0c85328]

CVE-2024-50122: PCI: Hold rescan lock while adding devices during host probe

Announce: https://lore.kernel.org/linux-cve-announce/2024110556-CVE-2024-50122-c520@gregkh/

Introduced by commit 4565d26 ("PCI/pwrctl: Add PCI power control core
code") in v6.11-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d59d474e1cb7d4fdf87dfaf96f44647f13ea590]

CVE-2024-50123: bpf: Add the missing BPF_LINK_TYPE invocation for sockmap

Announce: https://lore.kernel.org/linux-cve-announce/2024110556-CVE-2024-50123-5370@gregkh/

Introduced by commit 699c23f ("bpf: Add bpf_link support for sk_msg
and sk_skb progs") in v6.10-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2f803052bc7a7feb2e03befccc8e49b6ff1f5f5]

CVE-2024-50124: Bluetooth: ISO: Fix UAF on iso_sock_timeout

Announce: https://lore.kernel.org/linux-cve-announce/2024110557-CVE-2024-50124-caf8@gregkh/

Introduced by commit ccf74f2 ("Bluetooth: Add BTPROTO_ISO socket
type") in v6.0-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [246b435ad668596aa0e2bbb9d491b6413861211a]
stable/6.1: [876ac72d535fa94f4ac57bba651987c6f990f646]
stable/6.6: [14bcb721d241e62fdd18f6f434a2ed2ab6e71a9b]

CVE-2024-50125: Bluetooth: SCO: Fix UAF on sco_sock_timeout

Announce: https://lore.kernel.org/linux-cve-announce/2024110557-CVE-2024-50125-5fd3@gregkh/

Introduced by commit ba316be ("Bluetooth: schedule SCO timeouts with
delayed_work") in v5.15-rc1.
Fixed in v6.12-rc5.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10 stable/5.4

Fixed status
mainline: [1bf4470a3939c678fb822073e9ea77a0560bc6bb]
stable/6.1: [9ddda5d967e84796e7df1b54a55f36b4b9f21079]
stable/6.6: [d30803f6a972b5b9e26d1d43b583c7ec151de04b]

CVE-2024-50126: net: sched: use RCU read-side critical section in taprio_dump()

Announce: https://lore.kernel.org/linux-cve-announce/2024110557-CVE-2024-50126-733b@gregkh/

Introduced by commit 18cdd2f ("net/sched: taprio: taprio_dump and
taprio_change are protected by rtnl_mutex") in v6.1-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b22db8b8befe90b61c98626ca1a2fbb0505e9fe3]
stable/6.6: [5d282467245f267c0b9ada3f7f309ff838521536]

CVE-2024-50127: net: sched: fix use-after-free in taprio_change()

Announce: https://lore.kernel.org/linux-cve-announce/2024110557-CVE-2024-50127-c0b5@gregkh/

Introduced by commit a3d43c0 ("taprio: Add support adding an admin
schedule") in v5.2-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f504465970aebb2467da548f7c1efbbf36d0f44b]
stable/5.15: [999612996df28d81f163dad530d7f8026e03aec6]
stable/6.1: [fe371f084073e8672a2d7d46b335c3c060d1e301]
stable/6.6: [0d4c0d2844e4eac3aed647f948fd7e60eea56a61]

CVE-2024-50128: net: wwan: fix global oob in wwan_rtnl_policy

Announce: https://lore.kernel.org/linux-cve-announce/2024110557-CVE-2024-50128-0fd8@gregkh/

Introduced by commit 88b7105 ("wwan: add interface creation support")
in v5.14-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47dd5447cab8ce30a847a0337d5341ae4c7476a7]
stable/5.15: [c9a0aed51977198df005d0a623090e38e2d77d7b]
stable/6.1: [9683804e36668f6093fb06e202eed2f188ba437e]
stable/6.6: [69076f8435c1c5dae5f814eaf4c361d1f00b22a3]

CVE-2024-50129: net: pse-pd: Fix out of bound for loop

Announce: https://lore.kernel.org/linux-cve-announce/2024110558-CVE-2024-50129-e68c@gregkh/

Introduced by commit 9be9567 ("net: pse-pd: Add support for PSE PIs")
in v6.10-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2767a41959e60763949c73ee180e40c686e807e]

CVE-2024-50130: netfilter: bpf: must hold reference on net namespace

Announce: https://lore.kernel.org/linux-cve-announce/2024110558-CVE-2024-50130-7580@gregkh/

Introduced by commit 84601d6 ("bpf: add bpf_link support for
BPF_NETFILTER programs") in v6.4-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1230fe7ad3974f7bf6c78901473e039b34d4fb1f]
stable/6.6: [f41bd93b3e0508edc7ba820357f949071dcc0acc]

CVE-2024-50131: tracing: Consider the NULL character when validating
the event length

Announce: https://lore.kernel.org/linux-cve-announce/2024110558-CVE-2024-50131-0e78@gregkh/

Introduced by commit dec65d7 ("tracing/probe: Check event name length
correctly") in v5.1-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b6e2e22cb23105fcb171ab92f0f7516c69c8471]
stable/5.15: [b86b0d6eea204116e4185acc35041ca4ff11a642]
stable/6.1: [f4ed40d1c669bba1a54407d8182acdc405683f29]
stable/6.6: [a14a075a14af8d622c576145455702591bdde09d]

CVE-2024-50132: tracing/probes: Fix MAX_TRACE_ARGS limit handling

Announce: https://lore.kernel.org/linux-cve-announce/2024110558-CVE-2024-50132-3221@gregkh/

Introduced by commit 035ba76 ("tracing/probes: cleanup: Set
trace_probe::nr_args at trace_probe_init") in v6.9-rc1.
Fixed in v6.11.6.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [08ccd1a57c4d3882e9a877eb2dcc66e50a3b0279]
stable/6.6: [6bc24db74fe4788cc7c2f30a113fc6aafba225a3]

CVE-2024-50133: LoongArch: Don't crash in stack_top() for tasks without vDSO

Announce: https://lore.kernel.org/linux-cve-announce/2024110558-CVE-2024-50133-3d60@gregkh/

Introduced by commit 803b0fc ("LoongArch: Add process management") in v5.19-rc1.
Fixed in v6.12-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [134475a9ab8487527238d270639a8cb74c10aab2]
stable/6.1: [a67d4a02bf43e15544179895ede7d5f97b84b550]
stable/6.6: [a94c197d4d749954dfaa37e907fcc8c04e4aad7e]

CVE-2024-50134: drm/vboxvideo: Replace fake VLA at end of
vbva_mouse_pointer_shape with real VLA

Announce: https://lore.kernel.org/linux-cve-announce/2024110558-CVE-2024-50134-53ce@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.12-rc2.
Affected function was added by commit dd55d44f4 ("staging: vboxvideo:
Add vboxvideo
to drivers/staging") in 4.13-rc2.

Fixed status
mainline: [d92b90f9a54d9300a6e883258e79f36dab53bfae]
stable/5.15: [34a422274b693507025a7db21519865d1862afcb]
stable/6.1: [7458a6cdaebb3dc59af8578ee354fae78a154c4a]
stable/6.6: [9eb32bd23bbcec44bcbef27b7f282b7a7f3d0391]

CVE-2024-50135: nvme-pci: fix race condition between reset and
nvme_dev_disable()

Announce: https://lore.kernel.org/linux-cve-announce/2024110559-CVE-2024-50135-d177@gregkh/

Introduced by commit 949928c ("NVMe: Fix possible queue use after
freed") in v4.6-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26bc0a81f64ce00fc4342c38eeb2eddaad084dd2]
stable/6.6: [4ed32cc0939b64e3d7b48c8c0d63ea038775f304]

CVE-2024-50136: net/mlx5: Unregister notifier on eswitch init failure

Announce: https://lore.kernel.org/linux-cve-announce/2024110559-CVE-2024-50136-183b@gregkh/

Introduced by commit 7624e58 ("net/mlx5: E-switch, register event
handler before arming the event") in v6.6-rc7.
Fixed in v6.12-rc4.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [1da9cfd6c41c2e6bbe624d0568644e1521c33e12]
stable/6.1: [e58fb7ddbab6635191c26dea1af26b91cce00866]
stable/6.6: [9f2ccb6f3888bec45c00121ee43e4e72423b12c1]

CVE-2024-50137: reset: starfive: jh71x0: Fix accessing the empty
member on JH7110 SoC

Announce: https://lore.kernel.org/linux-cve-announce/2024110559-CVE-2024-50137-22a1@gregkh/

Introduced by commit 82327b1 ("reset: starfive: Add StarFive JH7110
reset driver") in v6.4-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2cf59663660799ce16f4dfbed97cdceac7a7fa11]

CVE-2024-50138: bpf: Use raw_spinlock_t in ringbuf

Announce: https://lore.kernel.org/linux-cve-announce/2024110559-CVE-2024-50138-a1d5@gregkh/

Introduced by commit 457f443 ("bpf: Implement BPF ring buffer and
verifier support for it") in v5.8-rc1.
Fixed in v6.12-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b62645b09f870d70c7910e7550289d444239a46]
stable/6.1: [5eb34999d118e69a20dc0c6556f315fcb0a1f8d3]

* Updated CVEs
CVE-2021-38206: mac80211: Fix NULL ptr deref for injected rate info

stable/5.4 was fixed.

Fixed status
stable/5.10: [f74df6e086083dc435f7500bdbc86b05277d17af]
stable/5.4: [7526339f91ddcd1d4db64a3905d611282ca36bf1]

CVE-2022-20158: mm: backing-dev: Take a reference to the bdi in use to
prevent UAF

stable/5.4 was fixed.

Fixed status
stable/5.10: [9722aa53fa234ff04c7c50df225b4fbf032c6d61]
stable/5.15: [b6a9b12e8c724931bf9a7f7afeb3fb14d2b9696b]
stable/5.4: [92738aab2f2441be056c89148157cffd58deabd0]

CVE-2022-48910: net: ipv6: ensure we call ipv6_mc_down() at most once

stable/4.19 was fixed.

Fixed status
stable/4.19: [24888915364cfa410de62d8abb5df95c3b67455d]
stable/5.10: [f4c63b24dea9cc2043ff845dcca9aaf8109ea38a]
stable/5.15: [b11781515208dd31fbcd0b664078dce5dc44523f]
stable/5.4: [9588ac2eddc2f223ebcebf6e9f5caed84d32922b]

CVE-2022-48938: CDC-NCM: avoid overflow in sanity checking

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [a612395c7631918e0e10ea48b9ce5ab4340f26a6]
stable/5.10: [69560efa001397ebb8dc1c3e6a3ce00302bb9f7f]
stable/5.15: [49909c9f8458cacb5b241106cba65aba5a6d8f4c]
stable/5.4: [9957fbf34f52a4d8945d1bf39aae400ef9a11246]

CVE-2023-52497: erofs: fix lz4 inplace decompression

stable/5.4 was fixed.

Fixed status
stable/5.10: [a0180e940cf1aefa7d516e20b259ad34f7a8b379]
stable/5.15: [77cbc04a1a8610e303a0e0d74f2676667876a184]
stable/5.4: [9ff2d260b25df6fe1341a79113d88fecf6bd553e]
stable/6.1: [33bf23c9940dbd3a22aad7f0cda4c84ed5701847]
stable/6.6: [f36d200a80a3ca025532ed60dd1ac21b620e14ae]
stable/6.7: [bffc4cc334c5bb31ded54bc3cfd651735a3cb79e]

CVE-2023-52530: wifi: mac80211: fix potential key use-after-free

stable/5.4 was fixed.

Fixed status
stable/5.10: [e8e599a635066c50ac214c3e10858f1d37e03022]
stable/5.15: [e8a834eb09bb95c2bf9c76f1a28ecef7d8c439d0]
stable/5.4: [2408f491ff998d674707725eadc47d8930aced09]
stable/6.1: [2f4e16e39e4f5e78248dd9e51276a83203950b36]

CVE-2023-52913: drm/i915: Fix potential context UAFs

stable/5.15 was fixed.

Fixed status
stable/5.15: [ae278887193110dfeb857ea63e243a3851fbb0bc]
stable/6.1: [b696c627b3f56e173f7f70b8487d66da8ff22506]

CVE-2023-52917: ntb: intel: Fix the NULL vs IS_ERR() bug for
debugfs_create_dir()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [20cbc281033ef5324f67f2d54bc539968f937255]
stable/5.10: [ef7e34237e2612b116a84c9640628a6f7a0d693e]
stable/5.15: [a429158f2e0a7a03eb67fd5e204e1f6735c725aa]
stable/5.4: [4b2fbba4e44630a59b09d32627b63c4ffdf70f78]
stable/6.1: [7cbd6d7fb9ba2be03978809c848e2e50eaeead2c]
stable/6.11: [babba8595d1e5d57313a6187f3e51aceacc6881a]
stable/6.6: [16e5bed6c1883b19f9fcbdff996aa3381954d5f3]

CVE-2024-26885: bpf: Fix DEVMAP_HASH overflow check on 32-bit arches

stable/5.4 was fixed.

Fixed status
stable/5.10: [225da02acdc97af01b6bc6ce1a3e5362bf01d3fb]
stable/5.15: [c826502bed93970f2fd488918a7b8d5f1d30e2e3]
stable/5.4: [1f5e352b9088211fa5eb4e1639cd365f4f7d2f65]
stable/6.1: [edf7990baa48de5097daa9ac02e06cb4c798a737]
stable/6.6: [250051acc21f9d4c5c595e4fcb55986ea08c4691]
stable/6.8: [e89386f62ce9a9ab9a94835a9890883c23d9d52c]

CVE-2024-26921: inet: inet_defrag: prevent sk release while still in use

stable/5.4 was fixed.

Fixed status
stable/5.10: [9705f447bf9a6cd088300ad2c407b5e1c6591091]
stable/5.15: [4318608dc28ef184158b4045896740716bea23f0]
stable/5.4: [1b6de5e6575b56502665c65cf93b0ae6aa0f51ab]
stable/6.1: [7d0567842b78390dd9b60f00f1d8f838d540e325]
stable/6.6: [f4877225313d474659ee53150ccc3d553a978727]
stable/6.8: [e09cbe017311508c21e0739e97198a8388b98981]

CVE-2024-36914: drm/amd/display: Skip on writeback when it's not applicable

stable/6.1 was fixed.

Fixed status
stable/6.1: [87de0a741ef6d93fcb99983138a0d89a546a043c]
stable/6.6: [951a498fa993c5501994ec2df97c9297b02488c7]

CVE-2024-38544: RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt

stable/5.4 was fixed.

Fixed status
stable/5.10: [de5a059e36657442b5637cc16df5163e435b9cb4]
stable/5.15: [e0e14dd35d4242340c7346aac60c7ff8fbf87ffc]
stable/5.4: [c91fb72a2ca6480d8d77262eef52dc5b178463a3]
stable/6.1: [faa8d0ecf6c9c7c2ace3ca3e552180ada6f75e19]
stable/6.6: [21b4c6d4d89030fd4657a8e7c8110fd941049794]
stable/6.9: [30df4bef8b8e183333e9b6e9d4509d552c7da6eb]

CVE-2024-39497: drm/shmem-helper: Fix BUG_ON() on mmap(PROT_WRITE, MAP_PRIVATE)

stable/5.10 was fixed.

Fixed status
stable/5.10: [a508a102edf8735adc9bb73d37dd13c38d1a1b10]
stable/5.15: [3ae63a8c1685e16958560ec08d30defdc5b9cca0]
stable/6.1: [2219e5f97244b79c276751a1167615b9714db1b0]
stable/6.6: [1b4a8b89bf6787090b56424d269bf84ba00c3263]
stable/6.9: [03c71c42809ef4b17f5d874cdb2d3bf40e847b86]

CVE-2024-40953: KVM: Fix a data race on last_boosted_vcpu in kvm_vcpu_on_spin()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [11a772d5376aa6d3e2e69b5b5c585f79b60c0e17]
stable/5.10: [71fbc3af3dacb26c3aa2f30bb3ab05c44d082c84]
stable/5.15: [82bd728a06e55f5b5f93d10ce67f4fe7e689853a]
stable/5.4: [4c141136a28421b78f34969b25a4fa32e06e2180]
stable/6.1: [92c77807d938145c7c3350c944ef9f39d7f6017c]
stable/6.6: [a937ef951bba72f48d2402451419d725d70dba20]
stable/6.9: [95c8dd79f3a14df96b3820b35b8399bd91b2be60]

CVE-2024-41016: ocfs2: strict bound check before memcmp in
ocfs2_xattr_find_entry()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [e2b3d7a9d019d4d1a0da6c3ea64a1ff79c99c090]
stable/5.10: [57a3d89831fcaa2cdbe024b47c7c36d5a56c3637]
stable/5.15: [c031d286eceb82f72f8623b7f4abd2aa491bfb5e]
stable/5.4: [e8f9c4af7af7e9e4cd09c0251c7936593147419f]
stable/6.1: [cfb926051fab19b10d1e65976211f364aa820180]
stable/6.10: [e4ffea01adf3323c821b6f37e9577d2d400adbaa]
stable/6.6: [c726dea9d0c806d64c26fcef483b1fb9474d8c5e]

CVE-2024-42229: crypto: aead,cipher - zeroize key buffer after use

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [89b9b6fa4463daf820e6a5ef65c3b0c2db239513]
stable/5.10: [9db8c299a521813630fcb4154298cb60c37f3133]
stable/5.15: [71dd428615375e36523f4d4f7685ddd54113646d]
stable/5.4: [b716e9c3603ee95ed45e938fe47227d22cf3ec35]
stable/6.1: [28c8d274848feba552e95c5c2a7e3cfe8f15c534]
stable/6.6: [b502d4a08875ea2b4ea5d5b28dc7c991c8b90cfb]

CVE-2024-43904: drm/amd/display: Add null checks for 'stream' and
'plane' before dereferencing

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [5e84eda48ffb2363437db44bbd0235594f8a58f9]
stable/6.10: [16a8a2a839d19c4cf7253642b493ffb8eee1d857]
stable/6.6: [10c20d79d59cadfe572480d98cec271a89ffb024]

CVE-2024-43911: wifi: mac80211: fix NULL dereference at band check in
starting tx ba session

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [0acaf4a5025d6dafb7da787d2d4c47ed95e46ed6]
stable/6.10: [a5594c1e03b0df3908b1e1202a1ba34422eed0f6]
stable/6.6: [a53c2d847627b790fb3bd8b00e02c247941b17e0]

CVE-2024-44931: gpio: prevent potential speculation leaks in
gpio_device_get_desc()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [18504710442671b02d00e6db9804a0ad26c5a479]
stable/5.10: [9d682e89c44bd5819b01f3fbb45a8e3681a4b6d0]
stable/5.15: [c65ab97efcd438cb4e9f299400f2ea55251f3a67]
stable/5.4: [9ae2d8e75b741dbcb0da374753f972410e83b5f3]
stable/6.1: [672c19165fc96dfad531a5458e0b3cdab414aae4]
stable/6.10: [d776c0486b03a5c4afca65b8ff44573592bf93bb]
stable/6.6: [1b955f786a4bcde8c0ccb2b7d519def2acb6f3cc]

CVE-2024-44988: net: dsa: mv88e6xxx: Fix out-of-bound access

stable/4.19 was fixed.

Fixed status
stable/4.19: [4a88fca95c8df3746b71e31f44a02d35f06f9864]
stable/5.10: [050e7274ab2150cd212b2372595720e7b83a15bd]
stable/5.15: [a10d0337115a6d223a1563d853d4455f05d0b2e3]
stable/5.4: [d39f5be62f098fe367d672b4dd4bc4b2b80e08e7]
stable/6.1: [18b2e833daf049223ab3c2efdf8cdee08854c484]
stable/6.10: [f87ce03c652dba199aef15ac18ade3991db5477e]
stable/6.6: [f7d8c2fabd39250cf2333fbf8eef67e837f90a5d]

CVE-2024-46849: ASoC: meson: axg-card: fix 'use-after-free'

stable/5.4 was fixed.

Fixed status
stable/5.10: [5a2cc2bb81399e9ebc72560541137eb04d61dc3d]
stable/5.15: [fb0530025d502cb79d2b2801b14a9d5261833f1a]
stable/5.4: [a33145f494e6cb82f3e018662cc7c4febf271f22]
stable/6.1: [e1a199ec31617242e1a0ea8f312341e682d0c037]
stable/6.10: [7d318166bf55e9029d56997c3b134f4ac2ae2607]
stable/6.6: [e43364f578cdc2f8083abbc0cb743ea55e827c29]

CVE-2024-46853: spi: nxp-fspi: fix the KASAN report out-of-bounds bug

stable/5.4 was fixed.

Fixed status
stable/5.10: [609260542cf86b459c57618b8cdec8020394b7ad]
stable/5.15: [491f9646f7ac31af5fca71be1a3e5eb8aa7663ad]
stable/5.4: [aa05db44db5f409f6d91c27b5737efb49fb45d9f]
stable/6.1: [09af8b0ba70072be831f3ec459f4063d570f9e24]
stable/6.10: [d1a1dfcec77c57b1181da93d11a3db1bc4eefa97]
stable/6.6: [af9ca9ca3e44f48b2a191e100d452fbf850c3d87]

CVE-2024-46854: net: dpaa: Pad packets to ETH_ZLEN

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [cd5b9d657ecd44ad5f254c3fea3a6ab1cf0e2ef7]
stable/5.10: [1f31f51bfc8214a6deaac2920e6342cb9d019133]
stable/5.15: [38f5db5587c0ee53546b28c50ba128253181ac83]
stable/5.4: [dc43a096cfe65b5c32168313846c5cd135d08f1d]
stable/6.1: [f43190e33224c49e1c7ebbc25923ff400d87ec00]
stable/6.10: [ce8eabc912fe9b9a62be1a5c6af5ad2196e90fc2]
stable/6.6: [34fcac26216ce17886af3eb392355b459367af1a]

CVE-2024-47663: staging: iio: frequency: ad9834: Validate frequency
parameter value

stable/4.19 was fixed.

Fixed status
stable/4.19: [5edc3a45ef428501000a7b23d0e1777a548907f6]
stable/5.10: [41cc91e3138fe52f8da92a81bebcd0e6cf488c53]
stable/5.15: [d8b09a5edc4a634373158c1a405491de3c52e58a]
stable/5.4: [0e727707a239d5c519fc9abc2f0fd913516a7e47]
stable/6.1: [3ba9abfcaa9e16bb91ed7e0e2b42e94a157a953e]
stable/6.10: [8961b245e8f92bccbaacfbbdf69eba60e3e7c227]
stable/6.6: [dc12e49f970b08d8b007b8981b97e2eb93c0e89d]

CVE-2024-47670: ocfs2: add bounds checking to ocfs2_xattr_find_entry()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [b49a786beb11ff740cb9e0c20b999c2a0e1729c2]
stable/5.10: [34759b7e4493d7337cbc414c132cef378c492a2c]
stable/5.15: [5bbe51eaf01a5dd6fb3f0dea81791e5dbc6dc6dd]
stable/5.4: [60c0d36189bad58b1a8e69af8781d90009559ea1]
stable/6.1: [9b32539590a8e6400ac2f6e7cf9cbb8e08711a2f]
stable/6.10: [8e7bef408261746c160853fc27df3139659f5f77]
stable/6.6: [1f6e167d6753fe3ea493cdc7f7de8d03147a4d39]

CVE-2024-47671: USB: usbtmc: prevent kernel-usb-infoleak

stable/5.4 was fixed.

Fixed status
stable/5.10: [16e0ab9ed3ae7d19ca8ee718ba4e09d5c0f909ca]
stable/5.15: [0c927dfc0b9bd177f7ab6ee59ef0c4ea06c110a7]
stable/5.4: [fa652318887da530f2f9dbd9b0ea4a087d05ee12]
stable/6.1: [ba6269e187aa1b1f20faf3c458831a0d6350304b]
stable/6.10: [e872738e670ddd63e19f22d0d784f0bdf26ecba5]
stable/6.11: [6c7fc36da021b13c34c572a26ba336cd102418f8]
stable/6.6: [51297ef7ad7824ad577337f273cd092e81a9fa08]

CVE-2024-47672: wifi: iwlwifi: mvm: don't wait for tx queues if firmware is dead

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [ad2fcc2daa203a6ad491f00e9ae3b7867e8fe0f3]
stable/5.10: [de46b1d24f5f752b3bd8b46673c2ea4239661244]
stable/5.15: [1afed66cb271b3e65fe9df1c9fba2bf4b1f55669]
stable/5.4: [16c1e5d5228f26f120e12e6ca55c59c3a5e6dece]
stable/6.1: [1b0cd832c9607f41f84053b818e0b7908510a3b9]
stable/6.10: [7188b7a72320367554b76d8f298417b070b05dd3]
stable/6.6: [4d0a900ec470d392476c428875dbf053f8a0ae5e]

CVE-2024-47674: mm: avoid leaving partial pfn mappings around in error case

stable/5.10 was fixed.

Fixed status
stable/5.10: [35770ca6180caa24a2b258c99a87bd437a1ee10f]
stable/5.15: [5b2c8b34f6d76bfbd1dd4936eb8a0fbfb9af3959]
stable/6.1: [65d0db500d7c07f0f76fc24a4d837791c4862cd2]
stable/6.6: [a95a24fcaee1b892e47d5e6dcc403f713874ee80]

CVE-2024-47679: vfs: fix race between evice_inodes() and find_inode()&iput()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [6cc13a80a26e6b48f78c725c01b91987d61563ef]
stable/5.10: [47a68c75052a660e4c37de41e321582ec9496195]
stable/5.15: [3721a69403291e2514d13a7c3af50a006ea1153b]
stable/5.4: [489faddb1ae75b0e1a741fe5ca2542a2b5e794a5]
stable/6.1: [540fb13120c9eab3ef203f90c00c8e69f37449d1]
stable/6.11: [6c857fb12b9137fee574443385d53914356bbe11]
stable/6.6: [0eed942bc65de1f93eca7bda51344290f9c573bb]

CVE-2024-47684: tcp: check skb is non-NULL in tcp_rto_delta_us()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [ad4f0a14d6856e68f023fc4e5017cfd881a3dfbc]
stable/5.10: [ec31cf42fc4e35bb1248ce6eb1de6de9f851ac86]
stable/5.15: [5c4c03288a4aea705e36aa44119c13d7ee4dce99]
stable/5.4: [16e0387d87fc858e34449fdf2b14ed5837f761db]
stable/6.1: [96c4983eab2a5da235f7fff90beaf17b008ba029]
stable/6.11: [09aea49fbc7e755a915c405644f347137cdb62b0]
stable/6.6: [570f7d8c9bf14f041152ba8353d4330ef7575915]

CVE-2024-47685: netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [872eca64c3267dbc5836b715716fc6c03a18eda7]
stable/5.10: [dcf48ab3ca2c55b09c8f9c8de0df01c1943bc4e5]
stable/5.15: [fbff87d682e57ddbbe82abf6d0a1a4a36a98afcd]
stable/5.4: [7bcbc4cda777d26c88500d973fad0d497fc8a82e]
stable/6.1: [7ea2bcfd9bf4c3dbbf22546162226fd1c14d8ad2]
stable/6.11: [10210658f827ad45061581cbfc05924b723e8922]
stable/6.6: [af4b8a704f26f38310655bad67fd8096293275a2]

CVE-2024-47692: nfsd: return -EINVAL when namelen is 0

stable/5.4 was fixed.

Fixed status
stable/5.10: [0f1d007bbea38a61cf9c5392708dc70ae9d84a3d]
stable/5.15: [b7b7a8df41ef18862dd6b22289fb46c2c12398af]
stable/5.4: [6d07040ae5c2214e39c7444d898039c9e655a79a]
stable/6.1: [84a563d136faf514fdad1ade28d7a142fd313cb8]
stable/6.11: [1ff8be8d008b9ddc8e7043fbddd37d5d451b271b]
stable/6.6: [318f70857caab3da9a6ada9bc8c1f4f7591b695e]

CVE-2024-47696: RDMA/iwcm: Fix
WARNING:at_kernel/workqueue.c:#check_flush_dependency

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [da2708a19f45b4a7278adf523837c8db21d1e2b5]
stable/5.10: [2efe8da2ddbf873385b4bc55366d09350b408df6]
stable/5.15: [da0392698c62397c19deb1b9e9bdf2fbb5a9420e]
stable/5.4: [29b3bbd912b8db86df7a3c180b910ccb621f5635]
stable/6.1: [a64f30db12bdc937c5108158d98c8eab1925c548]
stable/6.11: [a09dc967b3c58899e259c0aea092f421d22a0b04]
stable/6.6: [8b7df76356d098f85f3bd2c7cf6fb43f531893d7]

CVE-2024-47697: drivers: media: dvb-frontends/rtl2830: fix an
out-of-bounds write error

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [8ffbe7d07b8e76193b151107878ddc1ccc94deb5]
stable/5.10: [badbd736e6649c4e6d7b4ff7e2b9857acfa9ea94]
stable/5.15: [86d920d2600c3a48efc2775c1666c1017eec6956]
stable/5.4: [883f794c6e498ae24680aead55c16f66b06cfc30]
stable/6.1: [3dba83d3c81de1368d15a39f22df7b53e306052f]
stable/6.11: [042b101d7bf70616c4967c286ffa6fcca65babfb]
stable/6.6: [58f31be7dfbc0c84a6497ad51924949cf64b86a2]

CVE-2024-47698: drivers: media: dvb-frontends/rtl2832: fix an
out-of-bounds write error

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [7065c05c6d58b9b9a98127aa14e9a5ec68173918]
stable/5.10: [6ae3b9aee42616ee93c4585174f40c767828006d]
stable/5.15: [a879b6cdd48134a3d58949ea4f075c75fa2d7d71]
stable/5.4: [49b33c38d202d3327dcfd058e27f541dcc308b92]
stable/6.1: [15bea004e939d938a6771dfcf2a26cc899ffd20a]
stable/6.11: [bedd42e07988dbdd124b23e758ffef7a681b9c60]
stable/6.6: [527ab3eb3b0b4a6ee00e183c1de6a730239e2835]

CVE-2024-47699: nilfs2: fix potential null-ptr-deref in nilfs_btree_insert()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [2b78e9df10fb7f4e9d3d7a18417dd72fbbc1dfd0]
stable/5.10: [24bf40740a3da6b4056721da34997ae6938f3da1]
stable/5.15: [73d23ecf234b7a6d47fb883f2dabe10e3230b31d]
stable/5.4: [1d94dbdfbb64cc48d10dec65cc3c4fbf2497b343]
stable/6.1: [f68523e0f26faade18833fbef577a4295d8e2c94]
stable/6.11: [3644554d308ddf2669e459a1551a7edf60b2d62b]
stable/6.6: [21839b6fbc3c41b3e374ecbdb0cabbbb2c53cf34]

CVE-2024-47701: ext4: avoid OOB when system.data xattr changes
underneath the filesystem

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [5b076d37e8d99918e9294bd6b35a8bbb436819b0]
stable/5.10: [7fc22c3b3ffc0e952f5e0062dd11aa6ae76affba]
stable/5.15: [be2e9b111e2790962cc66a177869b4e9717b4e29]
stable/5.4: [8adf0eb4e361a9e060d54f4bd0ac9c5d85277d20]
stable/6.1: [ea32883e4a03ed575a2eb7a66542022312bde477]
stable/6.11: [ccb8c18076e2e630fea23fbec583cdad61787fc5]
stable/6.6: [2a6579ef5f2576a940125729f7409cc182f1c8df]

CVE-2024-47706: block, bfq: fix possible UAF for bfqq->bic with merge chain

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [a9bdd5b36887d2bacb8bc777fd18317c99fc2587]
stable/5.10: [e1277ae780cca4e69ef5468d4582dfd48f0b8320]
stable/5.15: [8aa9de02a4be2e7006e636816ce19b0d667ceaa3]
stable/5.4: [bc2140534b2aae752e4f7cb4489642dbb5ec4777]
stable/6.1: [ddbdaad123254fb53e32480cb74a486a6868b1e0]
stable/6.11: [6d130db286ad0ea392c96ebb2551acf0d7308048]
stable/6.6: [7faed2896d78e48ec96229e73b30b0af6c00a9aa]

CVE-2024-47709: can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [f5059fae5ed518fc56494ce5bdd4f5360de4b3bc]
stable/5.10: [5cc00913c1fdcab861c4e65fa20d1f1e1bbbf977]
stable/5.15: [9550baada4c8ef8cebefccc746384842820b4dff]
stable/5.4: [a833da8eec20b51af39643faa7067b25c8b20f3e]
stable/6.1: [7a145d6ec2124bdb94bd6fc436b342ff6ddf2b70]
stable/6.11: [b02ed2f01240b226570b4a19b5041d61f5125784]
stable/6.6: [c3d941cc734e0c8dc486c062926d5249070af5e4]

CVE-2024-47710: sock_map: Add a cond_resched() in sock_hash_free()

stable/5.4 was fixed.

Fixed status
stable/5.10: [1a11a1a53255ddab8a903cdae01b9d3eb2c1a47b]
stable/5.15: [984648aac87a6a1c8fd61663bec3f7b61eafad5e]
stable/5.4: [bc05f6855642cff3c0eeb63060b35d8c4f8a851d]
stable/6.1: [04f62c012e0e4683e572b30baf6004ca0a3f6772]
stable/6.11: [cd10abf41bae55c9d2b93f34a516dbf52626bcb7]
stable/6.6: [80bd490ac0a3b662a489e17d8eedeb1e905a3d40]

CVE-2024-47712: wifi: wilc1000: fix potential RCU dereference issue in
wilc_parse_join_bss_param

stable/5.4 was fixed.

Fixed status
stable/5.10: [557418e1704605a81c9e26732449f71b1d40ba1e]
stable/5.15: [bf090f4fe935294361eabd9dc5a949fdd77d3d1b]
stable/5.4: [5a24cedc243ace5ed7c1016f52a7bfc8f5b07815]
stable/6.1: [b040b71d99ee5e17bb7a743dc01cbfcae8908ce1]
stable/6.11: [79510414a7626317f13cc9073244ab7a8deb3192]
stable/6.6: [84398204c5df5aaf89453056cf0647cda9664d2b]

CVE-2024-47713: wifi: mac80211: use two-phase skb reclamation in
ieee80211_do_stop()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [07eb0bd7b0a8abed9d45e0f567c9af1dc83e5268]
stable/5.10: [f232916fab67ca1c3425926df4a866e59ff26908]
stable/5.15: [acb53a716e492a02479345157c43f21edc8bc64b]
stable/5.4: [04f75f5bae33349283d6886901d9acd2f110c024]
stable/6.1: [db5ca4b42ccfa42d2af7b335ff12578e57775c02]
stable/6.11: [ad4b7068b101fbbb4a9ca4b99b25eb051a9482ec]
stable/6.6: [058c9026ad79dc98572442fd4c7e9a36aba6f596]

CVE-2024-47723: jfs: fix out-of-bounds in dbNextAG() and diAlloc()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [d1017d2a0f3f16dc1db5120e7ddbe7c6680425b0]
stable/5.10: [0338e66cba272351ca9d7d03f3628e390e70963b]
stable/5.15: [ead82533278502428883085a787d5a00f15e5eb9]
stable/5.4: [5ad6284c8d433f8a213111c5c44ead4d9705b622]
stable/6.1: [6ce8b6ab44a8b5918c0ee373d4ad19d19017931b]
stable/6.11: [96855f40e152989c9e7c20c4691ace5581098acc]
stable/6.6: [c1ba4b8ca799ff1d99d01f37d7ccb7d5ba5533d2]

CVE-2024-47737: nfsd: call cache_put if xdr_reserve_space returns NULL

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [3e8081ebff12bec1347deaceb6bce0765cce54df]
stable/5.10: [9f03f0016ff797932551881c7e06ae50e9c39134]
stable/5.15: [9803ab882d565a8fb2dde5999d98866d1c499dfd]
stable/5.4: [c6b16e700cf4d959af524bd9d3978407ff7ce462]
stable/6.1: [81821617312988096f5deccf0f7da6f888e98056]
stable/6.11: [8d0765f86135e27f0bb5c950c136495719b4c834]
stable/6.6: [a1afbbb5276f943ad7173d0b4c626b8c75a260da]

CVE-2024-47740: f2fs: Require FMODE_WRITE for atomic write ioctls

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [700f3a7c7fa5764c9f24bbf7c78e0b6e479fa653]
stable/5.10: [000bab8753ae29a259feb339b99ee759795a48ac]
stable/5.15: [88ff021e1fea2d9b40b2d5efd9013c89f7be04ac]
stable/5.4: [4ce87674c3a6b4d3b3d45f85b584ab8618a3cece]
stable/6.1: [32f348ecc149e9ca70a1c424ae8fa9b6919d2713]
stable/6.11: [4583290898c13c2c2e5eb8773886d153c2c5121d]
stable/6.6: [5e0de753bfe87768ebe6744d869caa92f35e5731]

CVE-2024-47742: firmware_loader: Block path traversal

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [d1768e5535d3ded59f888637016e6f821f4e069f]
stable/5.10: [c30558e6c5c9ad6c86459d9acce1520ceeab9ea6]
stable/5.15: [a77fc4acfd49fc6076e565445b2bc5fdc3244da4]
stable/5.4: [9b1ca33ebd05b3acef5b976c04e5e791af93ce1b]
stable/6.1: [3d2411f4edcb649eaf232160db459bb4770b5251]
stable/6.11: [6c4e13fdfcab34811c3143a0a03c05fec4e870ec]
stable/6.6: [7420c1bf7fc784e587b87329cc6dfa3dca537aa4]

CVE-2024-47747: net: seeq: Fix use after free vulnerability in ether3
Driver Due to Race Condition

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [25d559ed2beec9b34045886100dac46d1ad92eba]
stable/5.10: [338a0582b28e69460df03af50e938b86b4206353]
stable/5.15: [822c7bb1f6f8b0331e8d1927151faf8db3b33afd]
stable/5.4: [b5a84b6c772564c8359a9a0fbaeb2a2944aa1ee9]
stable/6.1: [1c57d61a43293252ad732007c7070fdb112545fd]
stable/6.11: [77a77331cef0a219b8dd91361435eeef04cb741c]
stable/6.6: [d2abc379071881798d20e2ac1d332ad855ae22f3]

CVE-2024-47749: RDMA/cxgb4: Added NULL check for lookup_atid

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [b12e25d91c7f97958341538c7dc63ee49d01548f]
stable/5.10: [dd598ac57dcae796cb58551074660c39b43fb155]
stable/5.15: [b11318dc8a1ec565300bb1a9073095af817cc508]
stable/5.4: [4e1fe68d695af367506ea3c794c5969630f21697]
stable/6.1: [39cb9f39913566ec5865581135f3e8123ad1aee1]
stable/6.11: [b9c94c8ba5a713817cffd74c4bacc05187469624]
stable/6.6: [0d50ae281a1712b9b2ca72830a96b8f11882358d]

CVE-2024-47756: PCI: keystone: Fix if-statement expression in ks_pcie_quirk()

stable/5.4 was fixed.

Fixed status
stable/5.10: [c289903b7a216df5ea6e1850ddf1b958eea9921d]
stable/5.15: [dc5aeba07395c8dfa29bb878c8ce4d5180427221]
stable/5.4: [9c9afc3e75069fcfb067727973242cfbf00dd7eb]
stable/6.1: [23838bef2adb714ec37b2d6141dccf4a3a70bdef]
stable/6.11: [2171c5cb2fbc3e03af7e8116cd58736c09328655]
stable/6.6: [e85ab507882db165c10a858d7f685a0a38f0312e]

CVE-2024-47757: nilfs2: fix potential oob read in nilfs_btree_check_delete()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [f3a9859767c7aea758976f5523903d247e585129]
stable/5.10: [d20674f31626e0596ae4c1d9401dfb6739b81b58]
stable/5.15: [c4f8554996e8ada3be872dfb8f60e93bcf15fb27]
stable/5.4: [ed76d381dae125b81d09934e365391a656249da8]
stable/6.1: [a8abfda768b9f33630cfbc4af6c4214f1e5681b0]
stable/6.11: [c4cbcc64bb31e67e02940ce060cc77f7180564cf]
stable/6.6: [257f9e5185eb6de83377caea686c306e22e871f2]

CVE-2024-49851: tpm: Clean up TPM space after command failure

stable/5.4 was fixed.

Fixed status
stable/5.10: [2c9b228938e9266a1065a3f4fe5c99b7235dc439]
stable/5.15: [ebc4e1f4492d114f9693950621b3ea42b2f82bec]
stable/5.4: [87e8134c18977b566f4ec248c8a147244da69402]
stable/6.1: [c84ceb546f30432fccea4891163f7050f5bee5dd]
stable/6.11: [3f9f72d843c92fb6f4ff7460d774413cde7f254c]
stable/6.6: [82478cb8a23bd4f97935bbe60d64528c6d9918b4]

CVE-2024-49860: ACPI: sysfs: validate return type of _STR method

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [92fd5209fc014405f63a7db79802ca4b01dc0c05]
stable/5.10: [4b081991c4363e072e1748efed0bbec8a77daba5]
stable/5.15: [0cdfb9178a3bba843c95c2117c82c15f1a64b9ce]
stable/5.4: [2364b6af90c6b6d8a4783e0d3481ca80af699554]
stable/6.1: [5c8d007c14aefc3f2ddf71e4c40713733dc827be]
stable/6.11: [f51f711d36e61fbb87c67b524fd200e05172668d]
stable/6.6: [f0921ecd4ddc14646bb5511f49db4d7d3b0829f0]

CVE-2024-49867: btrfs: wait for fixup workers before stopping cleaner
kthread during umount

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [cd686dfff63f27d712877aef5b962fbf6b8bc264]
stable/5.10: [70b60c8d9b42763d6629e44f448aa5d8ae477d61]
stable/5.15: [4c98fe0dfa2ae83c4631699695506d8941db4bfe]
stable/5.4: [a71349b692ab34ea197949e13e3cc42570fe73d9]
stable/6.1: [9da40aea63f8769f28afb91aea0fac4cf6fbbb65]
stable/6.11: [65d11eb276836d49003a8060cf31fa2284ad1047]
stable/6.6: [ed87190e9d9c80aad220fb6b0b03a84d22e2c95b]

CVE-2024-49868: btrfs: fix a NULL pointer dereference when failed to
start a new trasacntion

stable/5.4 was fixed.

Fixed status
stable/5.10: [d73d48acf36f57362df7e4f9d76568168bf5e944]
stable/5.15: [37fee9c220b92c3b7bf22b51c51dde5364e7590b]
stable/5.4: [1282f001cbf56e5dd6e90a18e205a566793f4be0]
stable/6.1: [d13249c0df7aab885acb149695f82c54c0822a70]
stable/6.11: [39356ec0e319ed07627b3a0f402d0608546509e6]
stable/6.6: [7ad0c5868f2f0418619089513d95230c66cb7eb4]

CVE-2024-49877: ocfs2: fix possible null-ptr-deref in ocfs2_set_buffer_uptodate

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [190d98bcd61117a78fe185222d162180f061a6ca]
stable/5.10: [61b84013e560382cbe7dd56758be3154d43a3988]
stable/5.15: [df944dc46d06af65a75191183d52be017e6b9dbe]
stable/5.4: [e68c8323355e8cedfbe0bec7d5a39009f61640b6]
stable/6.1: [01cb2e751cc61ade454c9bc1aaa2eac1f8197112]
stable/6.11: [4846e72ab5a0726e49ad4188b9d9df091ae78c64]
stable/6.6: [d52c5652e7dcb7a0648bbb8642cc3e617070ab49]

CVE-2024-49878: resource: fix region_intersects() vs add_memory_driver_managed()

stable/5.4 was fixed.

Fixed status
stable/5.10: [1d5f85f1b7db79c75c9e07d6571ce2a7bdf725c4]
stable/5.15: [8a6fef7d22a1d952aed68584d3fcc0d018d2bdc3]
stable/5.4: [333fbaf6864a4ca031367eb947961a1f3484d337]
stable/6.1: [4b90d2eb451b357681063ba4552b10b39d7ad885]
stable/6.11: [927abc5b7d6d2c2e936bec5a2f71d9512c5e72f7]
stable/6.6: [393331e16ce205e036e58b3d8ca4ee2e635f21d9]

CVE-2024-49879: drm: omapdrm: Add missing check for alloc_ordered_workqueue

stable/5.4 was fixed.

Fixed status
stable/5.10: [2bda89735199683b03f55b807bd1e31a3857520b]
stable/5.15: [e60b0d3b5aa2e8d934deca9e11215af84e632bc9]
stable/5.4: [c17a4f52fa3c3dac2dd6a3c38f2de7342d97d74c]
stable/6.1: [f37a1d9e5e22d5489309c3cd2db476dcdcc6530c]
stable/6.11: [334de68eda2b99892ba869c15cb59bc956fd9f42]
stable/6.6: [b57b53e8ffcdfda87d954fc4187426a54fe75a3d]

CVE-2024-49881: ext4: update orig_path in ext4_find_extent()

stable/4.19 was fixed.

Fixed status
stable/4.19: [ec0c0beb9b777cdd1edd7df9b36e0f3e67e2bdff]
stable/5.10: [6766937d0327000ac1b87c97bbecdd28b0dd6599]
stable/5.15: [a9fcb1717d75061d3653ed69365c8d45331815cd]
stable/6.1: [6801ed1298204d16a38571091e31178bfdc3c679]
stable/6.11: [11b230100d6801c014fab2afabc8bdea304c1b96]
stable/6.6: [f55ecc58d07a6c1f6d6d5b5af125c25f8da0bda2]

CVE-2024-49882: ext4: fix double brelse() the buffer of the extents path

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [d4574bda63906bf69660e001470bfe1a0ac524ae]
stable/5.10: [b6c29c8f3d7cb67b505f3b2f6c242d52298d1f2e]
stable/5.15: [32bbb59e3f18facd7201bef110010bf35819b8c3]
stable/5.4: [f9fd47c9d9548f9e47fa60098eab99dde175401d]
stable/6.1: [78bbc3d15b6f443acb26e94418c445bac940d414]
stable/6.11: [230ee0535d01478bad9a3037292043f39b9be10b]
stable/6.6: [68a69cf60660c73990c1875f94a5551600b04775]

CVE-2024-49883: ext4: aovid use-after-free in ext4_ext_insert_extent()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [e17ebe4fdd7665c93ae9459ba40fcdfb76769ac1]
stable/5.10: [5e811066c5ab709b070659197dccfb80ab650ddd]
stable/5.15: [9df59009dfc6d9fc1bd9ddf6c5ab6e56d6ed887a]
stable/5.4: [975ca06f3fd154c5f7742083e7b2574c57d1c0c3]
stable/6.1: [51db04892a993cace63415be99848970a0f15ef2]
stable/6.11: [bfed082ce4b1ce6349b05c09a0fa4f3da35ecb1b]
stable/6.6: [8162ee5d94b8c0351be0a9321be134872a7654a1]

CVE-2024-49884: ext4: fix slab-use-after-free in ext4_split_extent_at()

stable/4.19 was fixed.

Fixed status
stable/4.19: [393a46f60ea4f249dc9d496d4eb2d542f5e11ade]
stable/5.10: [e52f933598b781d291b9297e39c463536da0e185]
stable/5.15: [cafcc1bd62934547c76abf46c6d0d54f135006fe]
stable/6.1: [a5401d4c3e2a3d25643c567d26e6de327774a2c9]
stable/6.11: [915ac3630488af0ca194dc63b86d99802b4f6e18]
stable/6.6: [8fe117790b37c84c651e2bad9efc0e7fda73c0e3]

CVE-2024-49892: drm/amd/display: Initialize get_bytes_per_element's default to 1

stable/5.4 was fixed.

Fixed status
stable/5.10: [f921335123f6620c3dce5c96fbb95f18524a021c]
stable/5.15: [1f9f8186e239222f1c8d3dd73bf3bc6ae86c5e76]
stable/5.4: [8f0abb39c16e719129de10596b3ae3363fa178b4]
stable/6.1: [a23d6029e730f8a151b1a34afb169baac1274583]
stable/6.11: [3334ab72cbba55a632f24579cd47c4a4e5e69cda]
stable/6.6: [c7630935d9a4986e8c0ed91658a781b7a77d73f7]

CVE-2024-49894: drm/amd/display: Fix index out of bounds in degamma
hardware format translation

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [b3dfa878257a7e98830b3009ca5831a01d8f85fc]
stable/5.10: [c130a3c09e3746c1a09ce26c20d21d449d039b1d]
stable/5.15: [c6979719012a90e5b8e3bc31725fbfdd0b9b2b79]
stable/5.4: [f5f6d90087131812c1e4b9d3103f400f1624396d]
stable/6.1: [2495c8e272d84685403506833a664fad932e453a]
stable/6.11: [07078fa5d589a7fbce8f81ea8acf7aa0021ab38e]
stable/6.6: [122e3a7a8c7bcbe3aacddd6103f67f9f36bed473]

CVE-2024-49896: drm/amd/display: Check stream before comparing them

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [3944d226f55235a960d8f1135927f95e9801be12]
stable/5.10: [0167d570f6a0b38689c4a0e50bf79c518d827500]
stable/5.15: [14db8692afe1aa2143b673856bb603713d8ea93f]
stable/5.4: [471c53350ab83e47a2a117c2738ce0363785976e]
stable/6.1: [e8da54b7f8a17e44e67ea6d1037f35450af28115]
stable/6.11: [e41a291e1bef1153bba091b6580ecc7affc53c82]
stable/6.6: [42d31a33643813cce55ee1ebbad3a2d0d24a08e0]

CVE-2024-49900: jfs: Fix uninit-value access of new_ea in ea_buffer

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [7b24d41d47a6805c45378debf8bd115675d41da8]
stable/5.10: [8b1dcf25c26d42e4a68c4725ce52a0543c7878cc]
stable/5.15: [d7444f91a9f93eaa48827087ed0f3381c194181d]
stable/5.4: [dac398ed272a378d2f42ac68ae408333a51baf52]
stable/6.1: [6041536d18c5f51a84bc37cd568cbab61870031e]
stable/6.11: [8ad8b531de79c348bcb8133e7f5e827b884226af]
stable/6.6: [c076b3746224982eebdba5c9e4b1467e146c0d64]

CVE-2024-49902: jfs: check if leafidx greater than num leaves per dmap tree

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [d76b9a4c283c7535ae7c7c9b14984e75402951e1]
stable/5.10: [2451e5917c56be45d4add786e2a059dd9c2c37c4]
stable/5.15: [25d2a3ff02f22e215ce53355619df10cc5faa7ab]
stable/5.4: [35b91f15f44ce3c01eba058ccb864bb04743e792]
stable/6.1: [058aa89b3318be3d66a103ba7c68d717561e1dc6]
stable/6.11: [4a7bf6a01fb441009a6698179a739957efd88e38]
stable/6.6: [7fff9a9f866e99931cf6fa260288e55d01626582]

CVE-2024-49903: jfs: Fix uaf in dbFreeBits

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [4ac58f7734937f3249da734ede946dfb3b1af5e4]
stable/5.10: [fd026b6b6758d5569705c02540b40f3bbf822b9a]
stable/5.15: [e7ae14f7ee76c6ef5a48aebab1a278ad78f42619]
stable/5.4: [3126ccde51f51b0648c8cdccaf916e8bd062e972]
stable/6.1: [0c238da83f56bb895cab1e5851d034ac45b158d1]
stable/6.11: [95accb7183badca387f7a8d19a2475cf3089f148]
stable/6.6: [4218b31ecc7af7e191768d32e32ed4386d8f9b76]

CVE-2024-49924: fbdev: pxafb: Fix possible use after free in pxafb_task()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [e657fa2df4429f3805a9b3e47fb1a4a1b02a72bd]
stable/5.10: [e6897e299f57b103e999e62010b88e363b3eebae]
stable/5.15: [4cda484e584be34d55ee17436ebf7ad11922b97a]
stable/5.4: [6d0a07f68b66269e167def6c0b90a219cd3e7473]
stable/6.1: [3c0d416eb4bef705f699213cee94bf54b6acdacd]
stable/6.11: [a3a855764dbacbdb1cc51e15dc588f2d21c93e0e]
stable/6.6: [fdda354f60a576d52dcf90351254714681df4370]

CVE-2024-49926: rcu-tasks: Fix access non-existent percpu rtpcp
variable in rcu_tasks_need_gpcb()

stable/6.6 was fixed.

Fixed status
stable/6.11: [05095271a4fb0f6497121a057f9a2edf386d5d96]
stable/6.6: [b3b2431ed27f4ebc28e26cdf005c1de42dc60bdf]

CVE-2024-49938: wifi: ath9k_htc: Use __skb_set_length() for resetting
urb before resubmit

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [e6b9bf32e0695e4f374674002de0527d2a6768eb]
stable/5.10: [b02eb7c86ff2ef1411c3095ec8a52b13f68db04f]
stable/5.15: [012ae530afa0785102360de452745d33c99a321b]
stable/5.4: [d1f2fbc6a769081503f6ffedbb5cd1ac497f0e77]
stable/6.1: [6a875220670475d9247e576c15dc29823100a4e4]
stable/6.11: [a9f4e28e8adaf0715bd4e01462af0a52ee46b01f]
stable/6.6: [e37e348835032d6940ec89308cc8996ded691d2d]

CVE-2024-49944: sctp: set sk_state back to CLOSED if autobind fails in
sctp_listen_start

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [89bbead9d897c77d0b566349c8643030ff2abeba]
stable/5.10: [dd70c8a89ef99c3d53127fe19e51ef47c3f860fa]
stable/5.15: [e7a8442195e8ebd97df467ce4742980ab57edcce]
stable/5.4: [0e4e2e60556c6ed00e8450b720f106a268d23062]
stable/6.1: [9230a59eda0878d7ecaa901d876aec76f57bd455]
stable/6.11: [e914bf68dab88815a7ae7b7a3a5e8913c8ff14a5]
stable/6.6: [7f64cb5b4d8c872296eda0fdce3bcf099eec7aa7]

CVE-2024-49948: net: add more sanity checks to qdisc_pkt_len_init()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [d7d1a28f5dd57b4d83def876f8d7b4403bd37df9]
stable/5.10: [566a931a1436d0e0ad13708ea55479b95426213c]
stable/5.15: [2415f465730e48b6e38da1c7c097317bf5dd2d20]
stable/5.4: [473426a1d53a68dd1e718e6cd00d57936993fa6c]
stable/6.1: [27a8fabc54d2f960d47bdfbebf2bdc6e8a92a4c4]
stable/6.11: [1eebe602a8d8264a12e35e39d0645fa88dbbacdd]
stable/6.6: [9b0ee571d20a238a22722126abdfde61f1b2bdd0]

CVE-2024-49949: net: avoid potential underflow in qdisc_pkt_len_init() with UFO

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [d70ca7598943572d5e384227bd268acb5109bf72]
stable/5.10: [ba26060a29d3ca1bfc737aa79f7125128f35147c]
stable/5.15: [939c88cbdc668dadd8cfa7a35d9066331239041c]
stable/5.4: [1598d70ad9c7d0a4d9d54b82094e9f45908fda6d]
stable/6.1: [d6114993e0a89fde84a60a60a8329a571580b174]
stable/6.11: [81fd007dcd47c34471766249853e4d4bce8eea4b]
stable/6.6: [25ab0b87dbd89cecef8a9c60a02bb97832e471d1]

CVE-2024-49952: netfilter: nf_tables: prevent nf_skb_duplicated corruption

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [50067d8b3f48e4cd4c9e817d3e9a5b5ff3507ca7]
stable/5.10: [531754952f5dfc4b141523088147071d6e6112c4]
stable/5.15: [38e3fd0c4a2616052eb3c8f4e6f32d1ff47cd663]
stable/5.4: [c0add6ed2cf1c4733cd489efc61faeccd3433b41]
stable/6.1: [b40b027a0c0cc1cb9471a13f9730bb2fff12a15b]
stable/6.11: [752e1924604254f1708f3e3700283a86ebdd325d]
stable/6.6: [4e3542f40f3a94efa59ea328e307c50601ed7065]

CVE-2024-49955: ACPI: battery: Fix possible crash when unregistering a
battery hook

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [76fb2cbf01571926da8ecf6876cc8cb07d3f5183]
stable/5.10: [da964de4c18199e14b961b5b2e5e6570552a313c]
stable/5.15: [07b98400cb0285a6348188aa8c5ec6a2ae0551f7]
stable/5.4: [c47843a831e0eae007ad7e848d208e675ba4c132]
stable/6.1: [ca1fb7942a287b40659cc79551a1de54a2c2e7d5]
stable/6.11: [9f469ef1c79dac7f9ac1518643a33703918f7e13]
stable/6.6: [ce31847f109c3a5b2abdd19d7bcaafaacfde53de]

CVE-2024-49957: ocfs2: fix null-ptr-deref when journal load failed.

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [fd89d92c1140cee8f59de336cb37fa65e359c123]
stable/5.10: [bf605ae98dab5c15c5b631d4d7f88898cb41b649]
stable/5.15: [ff55291fb36779819211b596da703389135f5b05]
stable/5.4: [703b2c7e0798d263154dc8593dc2345f75dc077f]
stable/6.1: [82dfdd1e31e774578f76ce6dc90c834f96403a0f]
stable/6.11: [387bf565cc03e2e8c720b8b4798efea4aacb6962]
stable/6.6: [86a89e75e9e4dfa768b97db466ad6bedf2e7ea5b]

CVE-2024-49958: ocfs2: reserve space for inline xattr before attaching
reflink tree

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [5c9807c523b4fca81d3e8e864dabc8c806402121]
stable/5.10: [aac31d654a0a31cb0d2fa36ae694f4e164a52707]
stable/5.15: [020f5c53c17f66c0a8f2d37dad27ace301b8d8a1]
stable/5.4: [74364cb578dcc0b6c9109519d19cbe5a56afac9a]
stable/6.1: [5c2072f02c0d75802ec28ec703b7d43a0dd008b5]
stable/6.11: [96ce4c3537114d1698be635f5e36c62dc49df7a4]
stable/6.6: [637c00e06564a945e9d0edb3d78d362d64935f9f]

CVE-2024-49959: jbd2: stop waiting for space when
jbd2_cleanup_journal_tail() returns error

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [801a35dfef6996f3d5eaa96a59caf00440d9165e]
stable/5.10: [481e8f18a290e39e04ddb7feb2bb2a2cc3b213ed]
stable/5.15: [ec7f8337c98ad281020ad1f11ba492462d80737a]
stable/5.4: [d5dc65370a746750dbb2f03eabcf86b18db65f32]
stable/6.1: [70bae48377a2c4296fd3caf4caf8f11079111019]
stable/6.11: [c6bf043b210eac67d35a114e345c4e5585672913]
stable/6.6: [1c62dc0d82c62f0dc8fcdc4843208e522acccaf5]

CVE-2024-49962: ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in
acpi_db_convert_to_package()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [4669da66ebc5b09881487f30669b0fcdb462188e]
stable/5.10: [cbb67e245dacd02b5e1d82733892647df1523982]
stable/5.15: [1c9b8775062f8d854a80caf186af57fc617d454c]
stable/5.4: [402b4c6b7500c7cca6972d2456a4a422801035b5]
stable/6.1: [f282db38953ad71dd4f3f8877a4e1d37e580e30a]
stable/6.11: [ae5d4c7e76ba393d20366dfea1f39f24560ffb1d]
stable/6.6: [4588ea78d3904bebb613b0bb025669e75800f546]

CVE-2024-49963: mailbox: bcm2835: Fix timeout during suspend mode

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [4e1e03760ee7cc4779b6306867fe0fc02921b963]
stable/5.10: [32ee78823dea2d54adaf6e05f86622eba359e091]
stable/5.15: [df293ea78740a41384d648041f38f645700288e1]
stable/5.4: [b0de20de29b13950493a36bd4cf531200eb0e807]
stable/6.1: [90320cfc07b7d6e7a58fd8168f6380ec52ff0251]
stable/6.11: [dfeb67b2194ecc55ef8065468c5adda3cdf59114]
stable/6.6: [10a58555e0bb5cc4673c8bb73b8afc5fa651f0ac]

CVE-2024-49965: ocfs2: remove unreasonable unlock in ocfs2_read_blocks

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [5245f109b4afb6595360d4c180d483a6d2009a59]
stable/5.10: [3f1ca6ba5452d53c598a45d21267a2c0c221eef3]
stable/5.15: [f55a33fe0fb5274ef185fd61947cf142138958af]
stable/5.4: [9753bcb17b36c9add9b32c61766ddf8d2d161911]
stable/6.1: [81aba693b129e82e11bb54f569504d943d018de9]
stable/6.11: [39a88623af3f1c686bf6db1e677ed865ffe6fccc]
stable/6.6: [84543da867c967edffd5065fa910ebf56aaae49d]

CVE-2024-49966: ocfs2: cancel dqi_sync_work before freeing oinfo

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [fc5cc716dfbdc5fd5f373ff3b51358174cf88bfc]
stable/5.10: [14114d8148db07e7946fb06b56a50cfa425e26c7]
stable/5.15: [4173d1277c00baeedaaca76783e98b8fd0e3c08d]
stable/5.4: [89043e7ed63c7fc141e68ea5a79758ed24b6c699]
stable/6.1: [bbf41277df8b33fbedf4750a9300c147e8f104eb]
stable/6.11: [0d707a33c84b371cb66120e198eed3374726ddd8]
stable/6.6: [ef768020366f47d23f39c4f57bcb03af6d1e24b3]

CVE-2024-49967: ext4: no need to continue when the number of entries is 1

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [64c8c484242b141998f7408596ddb2dc6da4b1d3]
stable/5.10: [133ff0d78f1b160de011647bb65807195ca5d1ca]
stable/5.15: [aca593e6070e21979430c344e9cb0b272a9e7e10]
stable/5.4: [cdfd6ef391df332c9abb854f4530dd7bfbd71dc4]
stable/6.1: [a02d7f5b24193aed451ac67aad3453472e79dc78]
stable/6.11: [9d4b2e4c36bb88d57018c1cbc8b6a0c4b44a7f42]
stable/6.6: [2d64e7dada22ab589d1ac216a3661074d027f25e]

CVE-2024-49973: r8169: add tally counter fields added with RTL8125

stable/5.4 was fixed.

Fixed status
stable/5.10: [991e8b0bab669b7d06927c3e442b3352532e8581]
stable/5.15: [21950321ad33d7613b1453f4c503d7b1871deb61]
stable/5.4: [64648ae8c97ec5a3165021627f5a1658ebe081ca]
stable/6.1: [fe44b3bfbf0c74df5712f44458689d0eccccf47d]
stable/6.11: [585c048d15ed559f20cb94c8fa2f30077efa4fbc]
stable/6.6: [1c723d785adb711496bc64c24240f952f4faaabf]

CVE-2024-49975: uprobes: fix kernel info leak via "[uprobes]" vma

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [f31f92107e5a8ecc8902705122c594e979a351fe]
stable/5.10: [f561b48d633ac2e7d0d667020fc634a96ade33a0]
stable/5.15: [21cb47db1ec9765f91304763a24565ddc22d2492]
stable/5.4: [fe5e9182d3e227476642ae2b312e2356c4d326a3]
stable/6.1: [24141df5a8615790950deedd926a44ddf1dfd6d8]
stable/6.11: [9634e8dc964a4adafa7e1535147abd7ec29441a6]
stable/6.6: [5b981d8335e18aef7908a068529a3287258ff6d8]

CVE-2024-49981: media: venus: fix use after free bug in venus_remove
due to race condition

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [5098b9e6377577fe13d03e1d8914930f014a3314]
stable/5.10: [60b6968341a6dd5353554f3e72db554693a128a5]
stable/5.15: [bf6be32e2d39f6301ff1831e249d32a8744ab28a]
stable/5.4: [63bbe26471ebdcc3c20bb4cc3950d666279ad658]
stable/6.1: [2a541fcc0bd2b05a458e9613376df1289ec11621]
stable/6.11: [10941d4f99a5a34999121b314afcd9c0a1c14f15]
stable/6.6: [b0686aedc5f1343442d044bd64eeac7e7a391f4e]

CVE-2024-49982: aoe: fix the potential use-after-free problem in more places

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [12f7b89dd72b25da4eeaa22097877963cad6418e]
stable/5.10: [f63461af2c1a86af4217910e47a5c46e3372e645]
stable/5.15: [07b418d50ccbbca7e5d87a3a0d41d436cefebf79]
stable/5.4: [a786265aecf39015418e4f930cc1c14603a01490]
stable/6.1: [bc2cbf7525ac288e07d465f5a1d8cb8fb9599254]
stable/6.11: [8253a60c89ec35c8f36fb2cc08cdf854c7a3eb58]
stable/6.6: [acc5103a0a8c200a52af7d732c36a8477436a3d3]

CVE-2024-49985: i2c: stm32f7: Do not prepare/unprepare clock during
runtime suspend/resume

stable/5.4 was fixed.

Fixed status
stable/5.10: [9b8bc33ad64192f54142396470cc34ce539a8940]
stable/5.15: [1883cad2cc629ded4a3556c0bbb8b42533ad8764]
stable/5.4: [d6f1250a4d5773f447740b9fe37b8692105796d4]
stable/6.1: [c2024b1a583ab9176c797ea1e5f57baf8d5e2682]
stable/6.11: [894cd5f5fd9061983445bbd1fa3d81be43095344]
stable/6.6: [22a1f8a5b56ba93d3e8b7a1dafa24e01c8bb48ba]

CVE-2024-49995: tipc: guard against string buffer overrun

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [8298b6e45fb4d8944f356b08e4ea3e54df5e0488]
stable/5.10: [e2b2558971e02ca33eb637a8350d68a48b3e8e46]
stable/5.15: [54dae0e9063ed23c9acf8d5ab9b18d3426a8ac18]
stable/5.4: [c79768ffba5b6e95569a463a69b3101c95694867]
stable/6.1: [80c0be7bcf940ce9308311575c3aff8983c9b97a]
stable/6.11: [a18c7b239d02aafb791ae2c45226f6bb40641792]
stable/6.6: [12d26aa7fd3cbdbc5149b6e516563478d575026e]

CVE-2024-49997: net: ethernet: lantiq_etop: fix memory disclosure

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [905f06a34f960676e7dc77bea00f2f8fe18177ad]
stable/5.10: [185df159843d30fb71f821e7ea4368c2a3bfcd36]
stable/5.15: [469856f76f4802c5d7e3d20e343185188de1e2db]
stable/5.4: [60c068444c20bf9a3e22b65b5f6f3d9edc852931]
stable/6.1: [2bf4c101d7c99483b8b15a0c8f881e3f399f7e18]
stable/6.11: [431b122933b197820d319eb3987a67d04346ce9e]
stable/6.6: [e66e38d07b31e177ca430758ed97fbc79f27d966]

CVE-2024-50006: ext4: fix i_data_sem unlock order in ext4_ind_migrate()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [4192adefc9c570698821c5eb9873320eac2fcbf1]
stable/5.10: [53b1999cfd2c7addf2e581a32865fe8835467b44]
stable/5.15: [ef05572da0c0eb89614ed01cc17d3c882bdbd1ff]
stable/5.4: [3c46d6060d3e38de22196c1fe7706c5a3c696285]
stable/6.1: [9fedf51ab8cf7b69bff08f37fe0989fec7f5d870]
stable/6.11: [d58a00e981d3118b91d503da263e640b7cde6729]
stable/6.6: [d43776b907659affef1de888525847d64b244194]

CVE-2024-50007: ALSA: asihpi: Fix potential OOB array access

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [a6bdb691cf7b66dcd929de1a253c5c42edd2e522]
stable/5.10: [219587bca2678e31700ef09ecec178ba1f735674]
stable/5.15: [36ee4021bcc37b834996e79740d095d6f8dd948f]
stable/5.4: [ce2953e44829ec54bcbb57e9d890fc8af0900c80]
stable/6.1: [e658227d9d4f4e122d81690fdbc0d438b10288f5]
stable/6.11: [876d04bf5a8ac1d6af5afd258cd37ab83ab2cf3d]
stable/6.6: [7a55740996701f7b2bc46dc988b60ef2e416a747]

CVE-2024-50008: wifi: mwifiex: Fix memcpy() field-spanning write
warning in mwifiex_cmd_802_11_scan_ext()

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [b55c8848fdc81514ec047b2a0ec782ffe9ab5323]
stable/5.10: [1756918f51e9ab247a0f4782cc28853c2bb457c1]
stable/5.15: [e59bdb1ba594104cd0ee0af3ee9e4435d842a8fe]
stable/5.4: [f9310a6704bf52e2493480edea896e1f9b795d40]
stable/6.1: [17199b69a84798efffc475040fbef44374ef1de1]
stable/6.11: [a3a12c30f9510f3753286fadbc6cdb7dad78c1d5]
stable/6.6: [fef7b51f22cf2049b0ca6740adeb0ba6f2e671dc]

CVE-2024-50010: exec: don't WARN for racy path_noexec check

stable/5.10 was fixed.

Fixed status
stable/5.10: [c9b77438077d5a20c79ead95bcdaf9bd4797baaf]
stable/5.15: [b723f96407a0a078cf75970e4dbf16b46d286a61]
stable/6.1: [0bdf77be2330062b3a64f2bec39f62ab874a6796]
stable/6.11: [d62ba2a5536df83473a2ac15ab302258e3845251]
stable/6.6: [0d16f53c91111cec914f0811fcc526a2ba77b20d]

CVE-2024-50012: cpufreq: Avoid a bad reference count on CPU node

stable/6.1 was fixed.

Fixed status
stable/6.1: [6c3d8387839252f1a0fc6367f314446e4a2ebd0b]
stable/6.11: [47cb1d9278f179df8250304ec41009e3e836a926]
stable/6.6: [0f41f383b5a61a2bf6429a449ebba7fb08179d81]

CVE-2024-50024: net: Fix an unsafe loop on the list

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [464801a0f6ccb52b21faa33bac6014fd74cc5e10]
stable/5.10: [68ad5da6ca630a276f0a5c924179e57724d00013]
stable/5.15: [1cdec792b2450105b1314c5123a9a0452cb2c2f0]
stable/5.4: [8e0766fcf37ad8eed289dd3853628dd9b01b58b0]
stable/6.1: [5f03a7f601f33cda1f710611625235dc86fd8a9e]
stable/6.11: [49f9b726bf2bf3dd2caf0d27cadf4bc1ccf7a7dd]
stable/6.6: [3be342e0332a7c83eb26fbb22bf156fdca467a5d]

CVE-2024-50027: thermal: core: Free tzp copy along with the thermal zone

stable/6.6 was fixed.

Fixed status
stable/6.11: [bdb0d40507c85bee33c2a71fde7b2e857346f112]
stable/6.6: [eabe285e1c629a719d6e68fc319939c63b83bf22]

CVE-2024-50033: slip: make slhc_remember() more robust against malicious packets

stable/5.4 was fixed.

Fixed status
stable/5.10: [36b054324d18e51cf466134e13b6fbe3c91f52af]
stable/5.15: [5e336384cc9b608e0551f99c3d87316ca3b0e51a]
stable/5.4: [ba6501ea06462d6404d57d5644cf2854db38e7d7]
stable/6.1: [ff5e0f895315706e4ca5a19df15be6866cee4f5d]
stable/6.11: [29e8d96d44f51cf89a62dd042be35d052833b95c]
stable/6.6: [8bb79eb1db85a10865f0d4dd15b013def3f2d246]

CVE-2024-50035: ppp: fix ppp_async_encode() illegal access

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [4151ec65abd755133ebec687218fadd2d2631167]
stable/5.10: [30d91a478d58cbae3dbaa8224d17d0d839f0d71b]
stable/5.15: [fadf8fdb3110d3138e05c3765f645535434f8d76]
stable/5.4: [8dfe93901b410ae41264087427f3b9f389388f83]
stable/6.1: [ce249a4c68d0ce27a8c5d853338d502e2711a314]
stable/6.11: [c007a14797240607038bd3464501109f408940e2]
stable/6.6: [8fe992ff3df493d1949922ca234419f3ede08dff]

CVE-2024-50039: net/sched: accept TCA_STAB only for root qdisc

stable/5.4 was fixed.

Fixed status
stable/5.10: [adbc3eef43fc94c7c8436da832691ae02333a972]
stable/5.15: [8fb6503592d39065316f45d267c5527b4e7cd995]
stable/5.4: [2acbb9539bc2284e30d2aeb789c3d96287014264]
stable/6.1: [76feedc74b90270390fbfdf74a2e944e96872363]
stable/6.11: [3dc6ee96473cc2962c6db4297d4631f261be150f]
stable/6.6: [1edf039ee01788ffc25625fe58a903ae2efa213e]

CVE-2024-50040: igb: Do not bring the device up after non-fatal error

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [dca2ca65a8695d9593e2cf1b40848e073ad75413]
stable/5.10: [d79af3af2f49c6aae9add3d492c04d60c1b85ce4]
stable/5.15: [0a94079e3841d00ea5abb05e3233d019a86745f6]
stable/5.4: [c92cbd283ddcf55fd85a9a9b0ba13298213f3dd7]
stable/6.1: [6a39c8f5c8aae74c5ab2ba466791f59ffaab0178]
stable/6.11: [500be93c5d53b7e2c5314292012185f0207bad0c]
stable/6.6: [57c5053eaa5f9a8a99e34732e37a86615318e464]

CVE-2024-50044: Bluetooth: RFCOMM: FIX possible deadlock in
rfcomm_sk_state_change

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [b77b3fb12fd483cae7c28648903b1d8a6b275f01]
stable/5.10: [ef44274dae9b0a90d1a97ce8b242a3b8243a7745]
stable/5.15: [496b2ab0fd10f205e08909a125485fdc98843dbe]
stable/5.4: [869c6ee62ab8f01bf2419e45326642be5c9b670a]
stable/6.1: [ced98072d3511b232ae1d3347945f35f30c0e303]
stable/6.11: [4cb9807c9b53bf1e5560420d26f319f528b50268]
stable/6.6: [38b2d5a57d125e1c17661b8308c0240c4a43b534]

CVE-2024-50045: netfilter: br_netfilter: fix panic with metadata_dst skb

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [f07131239a76cc10d5e82c19d91f53cb55727297]
stable/5.10: [cce8419b8168f6e7eb637103a47f916f3de8bc81]
stable/5.15: [95c0cff5a1a5d28bf623b92eb5d1a8f56ed30803]
stable/5.4: [75dfcb758015c97e1accd6340691fca67d363bed]
stable/6.1: [78ed917133b118661e1fe62d4a85d5d428ee9568]
stable/6.11: [915717e0bb9837cc5c101bc545af487bd787239e]
stable/6.6: [3453f5839420bfbb85c86c61e49f49ffd0f041c4]

CVE-2024-50058: serial: protect uart_port_dtr_rts() in uart_shutdown() too

stable/5.10 was fixed.

Fixed status
stable/5.10: [2fe399bb8efd0d325ab1138cf8e3ecf23a39e96d]
stable/5.15: [399927f0f875b93f3d5a0336d382ba48b8671eb2]
stable/6.1: [d7b5876a6e74cdf8468a478be6b23f2f5464ac7a]
stable/6.11: [76ed24a34223bb2c6b6162e1d8389ec4e602a290]
stable/6.6: [e418d91195d29d5f9c9685ff309b92b04b41dc40]

CVE-2024-50059: ntb: ntb_hw_switchtec: Fix use after free
vulnerability in switchtec_ntb_remove due to race condition

stable/5.4 was fixed.

Fixed status
stable/5.10: [b650189687822b705711f0567a65a164a314d8df]
stable/5.15: [92728fceefdaa2a0a3aae675f86193b006eeaa43]
stable/5.4: [5126d8f5567f49b52e21fca320eaa97977055099]
stable/6.1: [3ae45be8492460a35b5aebf6acac1f1d32708946]
stable/6.11: [177925d9c8715a897bb79eca62628862213ba956]
stable/6.6: [fa840ba4bd9f3bad7f104e5b32028ee73af8b3dd]

CVE-2024-50072: x86/bugs: Use code segment selector for VERW operand

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [bfd1d223d80cb29a210caa1bd5e21f0816d58f02]
stable/5.15: [ada431c6c31a2c8c37991c46089af5caa23a9c6e]
stable/6.1: [38c5fe74f3bef98f75d16effa49836d50c9b6097]
stable/6.11: [bc576fbaf82deded606e69a00efe9752136bf91d]
stable/6.6: [481b477ab63c7245715a3e57ba79eb87c2dc0d02]

CVE-2024-50074: parport: Proper fix for array out-of-bounds access

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [8aadef73ba3b325704ed5cfc4696a25c350182cf]
stable/5.10: [1826b6d69bbb7f9ae8711827facbb2ad7f8d0aaa]
stable/5.15: [440311903231c6e6c9bcf8acb6a2885a422e00bc]
stable/5.4: [b0641e53e6cb937487b6cfb15772374f0ba149b3]
stable/6.1: [fca048f222ce9dcbde5708ba2bf81d85a4a27952]
stable/6.11: [2a8b26a09c8e3ea03da1ef3cd0ef6b96e559fba6]
stable/6.6: [66029078fee00646e2e9dbb8f41ff7819f8e7569]

CVE-2024-50076: vt: prevent kernel-infoleak in con_font_get()

stable/4.19, stable/5.10, stable/5.15, stable/5.4, stable/6.1 were fixed.

Fixed status
stable/4.19: [efc67cee700b89ffbdb74a0603a083ec1290ae31]
stable/5.10: [1e5a17dc77d8a8bbe67040b32e2ef755901aba44]
stable/5.15: [b3959d5eca136e0588f9af3867b34032160cb826]
stable/5.4: [dc794e878e6d79f75205be456b1042a289c5759d]
stable/6.1: [23c4cb8a56978e5b1baa171d42e616e316c2039d]
stable/6.11: [adb1f312f38f0d2c928ceaff089262798cc260b4]
stable/6.6: [dc2d5f02636c7587bdd6d1f60fc59c55860b00a4]

CVE-2024-50082: blk-rq-qos: fix crash on rq_qos_wait vs.
rq_qos_wake_function race

stable/5.4 was fixed.

Fixed status
stable/5.10: [3bc6d0f8b70a9101456cf02ab99acb75254e1852]
stable/5.15: [455a469758e57a6fe070e3e342db12e4a629e0eb]
stable/5.4: [d04b72c9ef2b0689bfc1057d21c4aeed087c329f]
stable/6.1: [b5e900a3612b69423a0e1b0ab67841a1fb4af80f]
stable/6.11: [04f283fc16c8d5db641b6bffd2d8310aa7eccebc]
stable/6.6: [4c5b123ab289767afe940389dbb963c5c05e594e]

CVE-2024-50086: ksmbd: fix user-after-free from session log off

stable/5.15 was fixed.

Fixed status
stable/5.15: [0f62358ce85b2d4c949ef1b648be01b29cec667a]
stable/6.1: [a9839c37fd813b432988f58a9d9dd59253d3eb2c]
stable/6.11: [ee371898b53a9b9b51c02d22a8c31bfb86d45f0d]
stable/6.6: [5511999e9615e4318e9142d23b29bd1597befc08]

CVE-2024-50089: unicode: Don't special case ignorable code points

stable/5.4 was fixed.

Fixed status
stable/5.10: [39fffca572844d733b137a0ff9eacd67b9b0c8e3]
stable/5.15: [651b954cd8d5b0a358ceb47c93876bb6201224e4]
stable/5.4: [18b5f47e7da46d3a0d7331e48befcaf151ed2ddf]
stable/6.1: [21526498d25e54bda3c650f756493d63fd9131b7]
stable/6.11: [876d3577a5b353e482d9228d45fa0d82bf1af53a]
stable/6.6: [ac20736861f3c9c8e0a78273a4c57e9bcb0d8cc6]

CVE-2024-50096: nouveau/dmem: Fix vulnerability in migrate_to_ram upon
copy error

stable/5.4 was fixed.

Fixed status
stable/5.10: [73f75d2b5aee5a735cf64b8ab4543d5c20dbbdd9]
stable/5.15: [8c3de9282dde21ce3c1bf1bde3166a4510547aa9]
stable/5.4: [fd9bb7e996bab9b9049fffe3f3d3b50dee191d27]
stable/6.1: [614bfb2050982d23d53d0d51c4079dba0437c883]
stable/6.11: [ab4d113b6718b076046018292f821d5aa4b844f8]
stable/6.6: [697e3ddcf1f8b68bd531fc34eead27c000bdf3e1]

CVE-2024-50099: arm64: probes: Remove broken LDR (literal) uprobe support

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [cc86f2e9876c8b5300238cec6bf0bd8c842078ee]
stable/5.10: [3728b4eb27910ffedd173018279a970705f2e03a]
stable/5.15: [ad4bc35a6d22e9ff9b67d0d0c38bce654232f195]
stable/5.4: [ae743deca78d9e4b7f4f60ad2f95e20e8ea057f9]
stable/6.1: [bae792617a7e911477f67a3aff850ad4ddf51572]
stable/6.11: [20cde998315a3d2df08e26079a3ea7501abce6db]
stable/6.6: [9f1e7735474e7457a4d919a517900e46868ae5f6]

CVE-2024-50100: USB: gadget: dummy-hcd: Fix "task hung" problem

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [cf7ee2291da551fc4b109fda1f6a332cb8212065]
stable/6.11: [f828205ee3e4ddc712a13fba6c9902d51e91ddaf]
stable/6.6: [7d85884576a3be3616c260fc1fa862a59579d1ab]

CVE-2024-50103: ASoC: qcom: Fix NULL Dereference in
asoc_qcom_lpass_cpu_platform_probe()

stable/5.10 was fixed.

Fixed status
stable/5.10: [03c9c2c2d2d0fe203dfe8f56bedbcf04e303d7c4]
stable/5.15: [a8e691fe1894c8bdf815a6171ee22ae7da8b18aa]
stable/6.1: [e19bf49e903337641fc230d430d49813e3199902]
stable/6.11: [1e235d02d803660777ec911a2c467ae41f8539f5]
stable/6.6: [73cc3f905ca9aa95694eea3dfa1acadc90686368]

CVE-2024-50115: KVM: nSVM: Ignore nCR3[4:0] when loading PDPTEs from memory

stable/5.10 was fixed.

Fixed status
stable/5.10: [76ce386feb14ec9a460784fcd495d8432acce7a5]
stable/5.15: [58cb697d80e669c56197f703e188867c8c54c494]
stable/6.1: [6876793907cbe19d42e9edc8c3315a21e06c32ae]
stable/6.11: [426682afec71ea3f889b972d038238807b9443e4]
stable/6.6: [2c4adc9b192a0815fe58a62bc0709449416cc884]

CVE-2024-50116: nilfs2: fix kernel bug due to missing clearing of
buffer delay flag

stable/4.19, stable/5.10, stable/5.4 were fixed.

Fixed status
stable/4.19: [033bc52f35868c2493a2d95c56ece7fc155d7cb3]
stable/5.10: [9f2ab98371c2f2488bf3bf3f9b2a73510545e9c1]
stable/5.15: [822203f6355f4b322d21e7115419f6b98284be25]
stable/5.4: [412a30b1b28d6073ba29c46a2b0f324c5936293f]
stable/6.1: [27524f65621f490184f2ace44cd8e5f3685af4a3]
stable/6.11: [c6f58ff2d4c552927fe9a187774e668ebba6c7aa]
stable/6.6: [743c78d455e784097011ea958b27396001181567]

CVE-2024-50117: drm/amd: Guard against bad data for ATIF ACPI method

stable/4.19, stable/5.10, stable/5.4 were fixed.

Fixed status
stable/4.19: [58556dcbd5606a5daccaee73b2130bc16b48e025]
stable/5.10: [234682910971732cd4da96fd95946e296e486b38]
stable/5.15: [6032287747f874b52dc8b9d7490e2799736e035f]
stable/5.4: [43b4fa6e0e238c6e2662f4fb61d9f51c2785fb1d]
stable/6.1: [cd67af3c1762de4c2483ae4dbdd98f9ea8fa56e3]
stable/6.11: [1d7175f9c57b1abf9ecfbdfd53ea760761f52ffe]
stable/6.6: [975ede2a7bec52b5da1428829b3439667c8a234b]

CVE-2024-50127: net: sched: fix use-after-free in taprio_change()

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [8a283a19026aaae8a773fd8061263cfa315b127f]
stable/5.15: [999612996df28d81f163dad530d7f8026e03aec6]
stable/5.4: [2f868ce6013548a713c431c679ef73747a66fcf3]
stable/6.1: [fe371f084073e8672a2d7d46b335c3c060d1e301]
stable/6.11: [2240f9376f20f8b6463232b4ca7292569217237f]
stable/6.6: [0d4c0d2844e4eac3aed647f948fd7e60eea56a61]

CVE-2024-50131: tracing: Consider the NULL character when validating
the event length

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [02874ca52df2ca2423ba6122039315ed61c25972]
stable/5.15: [b86b0d6eea204116e4185acc35041ca4ff11a642]
stable/5.4: [5e3231b352725ff4a3a0095e6035af674f2d8725]
stable/6.1: [f4ed40d1c669bba1a54407d8182acdc405683f29]
stable/6.11: [5fd942598ddeed9a212d1ff41f9f5b47bcc990a7]
stable/6.6: [a14a075a14af8d622c576145455702591bdde09d]

CVE-2024-50134: drm/vboxvideo: Replace fake VLA at end of
vbva_mouse_pointer_shape with real VLA

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [75f828e944dacaac8870418461d3d48a1ecf2331]
stable/5.15: [34a422274b693507025a7db21519865d1862afcb]
stable/5.4: [02c86c5d5ef4bbba17d38859c74872825f536617]
stable/6.1: [7458a6cdaebb3dc59af8578ee354fae78a154c4a]
stable/6.11: [fae9dc12c61ce23cf29d09824a741b7b1ff8f01f]
stable/6.6: [9eb32bd23bbcec44bcbef27b7f282b7a7f3d0391]

CVE-2024-50141: ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM
handler and context

stable/5.15 was fixed.

Fixed status
stable/5.15: [8df52929530839e878e6912e33348b54101e3250]
stable/6.1: [8ce081ad842510f0e70fa6065a401660eac876d4]
stable/6.11: [20e9fafb8bb6f545667d7916b0e81e68c0748810]
stable/6.6: [795b080d9aa127215a5baf088a22fa09341a0126]

CVE-2024-50142: xfrm: validate new SA's prefixlen using SA family when
sel.family is unset

stable/4.19, stable/5.10, stable/5.4 were fixed.

Fixed status
stable/4.19: [f31398570acf0f0804c644006f7bfa9067106b0a]
stable/5.10: [8df5cd51fd70c33aa1776e5cbcd82b0a86649d73]
stable/5.15: [2d08a6c31c65f23db71a5385ee9cf9d8f9a67a71]
stable/5.4: [401ad99a5ae7180dd9449eac104cb755f442e7f3]
stable/6.1: [bce1afaa212ec380bf971614f70909a27882b862]
stable/6.11: [e68dd80ba498265d2266b12dc3459164f4ff0c4a]
stable/6.6: [7d9868180bd1e4cf37e7c5067362658971162366]

CVE-2024-50143: udf: fix uninit-value use in udf_get_fileshortad

stable/4.19, stable/5.4 were fixed.

Fixed status
stable/4.19: [5eb76fb98b3335aa5cca6a7db2e659561c79c32b]
stable/5.15: [4fc0d8660e391dcd8dde23c44d702be1f6846c61]
stable/5.4: [417bd613bdbe791549f7687bb1b9b8012ff111c2]
stable/6.1: [72e445df65a0aa9066c6fe2b8736ba2fcca6dac7]
stable/6.11: [e52e0b92ed31dc62afbda15c243dcee0bb5bb58d]
stable/6.6: [1ac49babc952f48d82676979b20885e480e69be8]

CVE-2024-50148: Bluetooth: bnep: fix wild-memory-access in proto_unregister

stable/4.19, stable/5.10, stable/5.4 were fixed.

Fixed status
stable/4.19: [e232728242c4e98fb30e4c6bedb6ba8b482b6301]
stable/5.10: [6c151aeb6dc414db8f4daf51be072e802fae6667]
stable/5.15: [fa58e23ea1359bd24b323916d191e2e9b4b19783]
stable/5.4: [2c439470b23d78095a0d2f923342df58b155f669]
stable/6.1: [03015b6329e6de42f03ec917c25c4cf944f81f66]
stable/6.11: [20c424bc475b2b2a6e0e2225d2aae095c2ab2f41]
stable/6.6: [d10cd7bf574ead01fae140ce117a11bcdacbe6a8]

CVE-2024-50150: usb: typec: altmode should keep reference to parent

stable/4.19, stable/5.10, stable/5.4 were fixed.

Fixed status
stable/4.19: [2b0b33e8a58388fa9078f0fbe9af1900e6b08879]
stable/5.10: [6af43ec3bf40f8b428d9134ffa7a291aecd60da8]
stable/5.15: [87474406056891e4fdea0794e1f632b21b3dfa27]
stable/5.4: [2c15c4133d00f5da632fce60ed013fc31aa9aa58]
stable/6.1: [bee1b68cb8bcee4fd3a8bde3a4886e0b1375dc4d]
stable/6.11: [68a7c7fe322546be1464174c8d85874b8161deda]
stable/6.6: [1ded6b12499e6dee9b0e1ceac633be36538f6fc2]

CVE-2024-50151: smb: client: fix OOBs when building SMB2_IOCTL request

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [ed31aba8ce93472d9e16f5cff844ae7c94e9601d]
stable/5.15: [e07d05b7f5ad9a503d9cab0afde2ab867bb65470]
stable/5.4: [6f0516ef1290da24b85461ed08a0938af7415e49]
stable/6.1: [2ef632bfb888d1a14f81c1703817951e0bec5531]
stable/6.11: [fe92ddc1c32d4474e605e3a31a4afcd0e7d765ec]
stable/6.6: [b209c3a0bc3ac172265c7fa8309e5d00654f2510]

CVE-2024-50153: scsi: target: core: Fix null-ptr-deref in target_alloc_device()

stable/5.10 was fixed.

Fixed status
stable/5.10: [8c1e6717f60d31f8af3937c23c4f1498529584e1]
stable/5.15: [39e02fa90323243187c91bb3e8f2f5f6a9aacfc7]
stable/6.1: [895ab729425ef9bf3b6d2f8d0853abe64896f314]
stable/6.11: [14a6a2adb440e4ae97bee73b2360946bd033dadd]
stable/6.6: [b80e9bc85bd9af378e7eac83e15dd129557bbdb6]

CVE-2024-50167: be2net: fix potential memory leak in be_xmit()

stable/4.19, stable/5.10, stable/5.4 were fixed.

Fixed status
stable/4.19: [941026023c256939943a47d1c66671526befbb26]
stable/5.10: [77bc881d370e850b7f3cd2b5eae67d596b40efbc]
stable/5.15: [919ab6e2370289a2748780f44a43333cd3878aa7]
stable/5.4: [6b7ce8ee01c33c380aaa5077ff25215492e7eb0e]
stable/6.1: [4c5f170ef4f85731a4d43ad9a6ac51106c0946be]
stable/6.11: [e86a79b804e26e3b7f1e415b22a085c0bb7ea3d3]
stable/6.6: [641c1beed52bf3c6deb0193fe4d38ec9ff75d2ae]

CVE-2024-50168: net/sun3_82586: fix potential memory leak in
sun3_82586_send_packet()

stable/4.19, stable/5.10, stable/5.4 were fixed.

Fixed status
stable/4.19: [137010d26dc5cd47cd62fef77cbe952d31951b7a]
stable/5.10: [db755e55349045375c5c7036e8650afb3ff419d8]
stable/5.15: [9c6ce55e6f0bd1541f112833006b4052614c7d94]
stable/5.4: [8d5b20fbc548650019afa96822b6a33ea4ec8aa5]
stable/6.1: [1a17a4ac2d57102497fac53b53c666dba6a0c20d]
stable/6.11: [84f2bac74000dbb7a177d9b98a17031ec8d07ec5]
stable/6.6: [6dc937a3086e344f965ca5c459f8f3eb6b68d890]

CVE-2024-50171: net: systemport: fix potential memory leak in bcm_sysport_xmit()

stable/4.19, stable/5.10, stable/5.4 were fixed.

Fixed status
stable/4.19: [8e81ce7d0166a2249deb6d5e42f28a8b8c9ea72f]
stable/5.10: [b6321146773dcbbc372a54dbada67e0b50e0a25c]
stable/5.15: [5febfc545389805ce83d37f9f4317055b26dd7d7]
stable/5.4: [31701ef0c4547973991ff63596c927f841dfd133]
stable/6.1: [533d2f30aef272dade17870a509521c3afc38a03]
stable/6.11: [7d5030a819c3589cf9948b1eee397b626ec590f5]
stable/6.6: [4b70478b984af3c9d0279c121df5ff94e2533dbd]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

