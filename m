Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9715D59F7D
	for <webhook@archiver.kernel.org>; Wed,  6 Nov 2024 22:35:19 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
 by mx.groups.io with SMTP id smtpd.web11.58896.1730932516935066959
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Nov 2024 14:35:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=a0OJlODK;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.182, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e30d212b6b1so318472276.0
        for <cip-dev@lists.cip-project.org>; Wed, 06 Nov 2024 14:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1730932516; x=1731537316; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HqVMGE2Z7IqKjWPITwDwGrEvSnosPLJ7IfsWCzKD01Q=;
        b=a0OJlODKZShKq/oDhzjQxz8awQyvarkvybl6EZIzt8Zf5Pj7X/o8CqGRBntpuXFaTr
         ZdwTHxYnnoXsEaP+1eKgsR7qg0ifQKb7vx/N8e+TJaRL46n6KYsCDv+FnGHXxqqynOIQ
         8MKEkzKS8ZwvbEntMxkr7ykdCTPcii5Z9Coz/xHUBfpVmsjtCcSl8QzKSRfI9X7kSQSM
         s3h8zAn77KfF52/t9rmWqBXAIK5t4Lv88awnS49XDZLj1Ca+CVRaMO8DnrmfK/G16O9N
         DNJcb7hKwcWutBoEb/2Zb9DosIxrHrNPJd6YT6RIvmlBXRdciUglOi+JFuTgEYmdjrxy
         IRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730932516; x=1731537316;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqVMGE2Z7IqKjWPITwDwGrEvSnosPLJ7IfsWCzKD01Q=;
        b=VCLqr7ZL82N1IoOSf9+xjP5OVhWanWO3SdcNPdyHDdjc1QKMqA3klqBGYMzbz9sZim
         cxDUlwPDlDChEk4wxKgeGu1hkMNfH7NeaoQs7tKYCDIV7pS1gru3y352Ut3P1sAgI6qi
         ngZf1YBYRJYtZiZxgvf9tXCDDr9OhaY8Y9w61azvome45CfSRwO8fMgg4ati2mpeVd1m
         yFfhL4mB8YHHovvmSPd2u1LUVo6w9A4rcYSWHEfGYmbTpdsxsLyiCimzyUat5siqgSKU
         XakV5RXbqVKJo/CFMr9tUwp5GSbZYISk66QV+b+ZCiJ5n/d4KTupF/ijYq+9igUFzfDp
         blIA==
X-Gm-Message-State: AOJu0YyUf2ogSi3GHzHfuCb25j4fj0zn1/EwQUjQxS2JpmSGAz0pN7SU
	P5PClIOVIsNmg27m6uNoBkjFke4n19h14HAWpnEXkt1ZgPKWkTagual1unFZIHK7SK8xb7V1nnN
	CdmgBcGeWxVX2KDZ4kfQtuqwQjJCrLeGIZxqDePIM+E2sM4R/JlU=
X-Google-Smtp-Source: AGHT+IEn4icdNMiS3FGzws6/QzdWEP/NKl0KFZNdY7s5Mwkkp+F3UllGJnmhEIUseVednKbIsMg8WxEaD1u14tlj2zQ=
X-Received: by 2002:a05:690c:9683:b0:6ea:916f:e897 with SMTP id
 00721157ae682-6ea916fee3dmr119844907b3.29.1730932515074; Wed, 06 Nov 2024
 14:35:15 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 7 Nov 2024 07:34:39 +0900
Message-ID: <CAODzB9qK0sDqKjmw7fsXd_MXNNTreig4nLKUKDRY=ZOVKS34ZQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Nov 2024 22:35:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17192

Hi!

It's this week's CVE report.

This week reported 51 new CVEs and 0 updated CVEs.

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

No updated CVEs.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

