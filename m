Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8312FCCFA0D
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 22:19:42 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1132.1762381171686802624
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Nov 2025 14:19:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=NEZiM3LW;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.169, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-784966ad073so3177627b3.1
        for <cip-dev@lists.cip-project.org>; Wed, 05 Nov 2025 14:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1762381171; x=1762985971; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1d1neUCfvMi+9Cw1p3Mx6aDSkhb95AcD0tFcHAIU1Sw=;
        b=NEZiM3LWIFZY55mxxVTR/qqYL10Bl+9l4oUuIpeDhkt5KDEu3UQ0/H8buh5utkvyPH
         p0gTBfgT6LBIpxkwVibmlOnYS9Xsv9NlgT6YpM5YOpo1r4N2soVQ2g7sgvWojbqP77np
         SuCEutduQWthBHfNp/gcezTFEAMRJf9WxOROWUV/LKp91Bq8DHwr6AL65/deietZhnAo
         PCWdzXfnoJl2KFYu/ixfn5v00BTUTCpmx+Xf/Vhnvb+oFvk402344GKozdBnAgHEebTJ
         Y1UlQtv3ig3GQpUH/1MrjsZhf1RMbwetAU2fAXq6nRzK9zDw/YzdnfNngnUkLUqPLJuK
         xGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762381171; x=1762985971;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1d1neUCfvMi+9Cw1p3Mx6aDSkhb95AcD0tFcHAIU1Sw=;
        b=v8ZXkYCyTMhuKCHm2H5KAc/GyKRDReR4XeZgoY2cUVBW13h2K5Rjioi/klyVM0jnGY
         YK3+5naQ9A9VSVjGPSt2JPRhqzEyKfI2GN5SO9fJ3j3ptyDwqk+4Zn36zEHkHN9+4Vrw
         bZi+//+s3EjkaNkkKxGi1Dq7i+K9YrUW4yv4Frs0S02lInBA7d9aia5X26hEK7bgEXQR
         vcjE+UJpjdBUwQaxPf5gSAa9uQj50ShouHcsukxIGY30Ka6dv8PLmMKDpjls9lhqN/2d
         AHKVmvusTbUf/a/Svzx4jV8N9dkl16xZMErr++IZPkxWiJJ7ciX7UtzbjrazjfRs0FGQ
         xtaw==
X-Gm-Message-State: AOJu0YwMNxorHbHq7TuCCM00KZzZnaREaNXAg3V6sxd0w//qIlpii3qk
	B9NM97x6XI/o49Mm3HdLl+FZmcyRUF3NHySS7lKf/Myq7O8fucSyr4R3vqRimebwy1Pj3xv3zJL
	gVh5+0i4pARajg+o77LlGgi9ZcHqNKQgM1hs3I94qNLjNPEuvSCBwn4c=
X-Gm-Gg: ASbGnctPnbVMYcq4psbMv+BI+o5M8wJrz6y/KtgSjHISSCEOdn2mGa2uJkrely8lz+J
	AE9e4/Kst3U1XTxuCX03q2KluuT97gi6ZTHbFVAZ7H7d35rff8ox+LPfVwMXzmFFN+wrBCyN/zH
	RXzUfxUn1HkvPGnD3piQ3BkBj8DPOrS5mYFMKul+dhlXa1tFl2C1krbMGoC3fXPMcxVPYsqA+EB
	a8OQmuCNEgGn3cRlGq6qoytfH0gKFuqw5XtJpjWlCk2dwD2YJykjo0Pt0E7UA==
X-Google-Smtp-Source: AGHT+IFsukaQ5tj4vv/9otiZDPlxiQQpZHb+sI4usQG9F0kBPhW0vNKkTNZi5tSmjQtA5fGYpEkYyYA1x7pLVbGp1D0=
X-Received: by 2002:a05:690e:1517:b0:63e:e04:fc31 with SMTP id
 956f58d0204a3-63fd355c3f4mr3504341d50.43.1762381170267; Wed, 05 Nov 2025
 14:19:30 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 6 Nov 2025 07:18:54 +0900
X-Gm-Features: AWmQ_bn9llH7cUzoBpf2YtN89nbSURd8uUVA1PqIlktkZFxCC-IFHfzSNz5w8t8
Message-ID: <CAODzB9o1NhFiv4OkkSbwFQNCj4h8v39N2hXaHJmRHZYh5cu8PQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Nov 2025 22:19:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20367

Hi!

It's this week's CVE report.

This week reported 22 new CVEs and 8 updated CVEs.

* New CVEs
CVE-2025-40086: drm/xe: Don't allow evicting of BOs in same VM in
array of VM binds

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40086

Introduced by commit 774b5fa ("drm/xe: Avoid evicting object of the
same vm in none fault mode") in v6.14-rc1.
Introduced by commit 77f2ef3 ("drm/xe: Lock all gpuva ops during VM
bind IOCTL") in v6.11-rc1.
Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ac74613e5f2ef3450f44fd2127198662c2563a9]

CVE-2025-40087: NFSD: Define a proc_layoutcommit for the FlexFiles layout type

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40087

Introduced by commit 9b9960a ("nfsd: Add a super simple flex file
server") in v4.8-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b47a8601b71ad98833b447d465592d847b4dc77]
stable/5.10: [34d187e020cbda112a6c6f094f0ca5e6a8672b75]
stable/5.15: [ba88a53d7f5df4191583abf214214efe0cda91d2]
stable/5.4: [a75994dd879401c3e24ff51c2536559f1a53ea27]
stable/6.1: [da9129ef77786839a3ccd1d7afeeab790bceaa1d]
stable/6.12: [a156af6a4dc38c2aa7c98e89520a70fb3b3e7df4]
stable/6.6: [f7353208c91ab004e0179c5fb6c365b0f132f9f0]

CVE-2025-40088: hfsplus: fix slab-out-of-bounds read in hfsplus_strcasecmp()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40088

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [42520df65bf67189541a425f7d36b0b3e7bd7844]
stable/5.10: [ef250c3edd995d7bb5a5e5122ffad1c28a8686eb]
stable/5.15: [7ab44236b32ed41eb0636797e8e8e885a2f3b18a]
stable/5.4: [603158d4efa98a13a746bd586c20f194f4a31ec8]
stable/6.1: [b47a75b6f762321f9eb6f31aab7bce47a37063b7]
stable/6.12: [586c75dfd1d265c4150f6529debb85c9d62e101f]
stable/6.6: [4f5ab4a9c6abd8b0d713cc2b7b041bc10d70f241]

CVE-2025-40089: cxl/features: Add check for no entries in cxl_feature_info

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40089

Introduced by commit eb5dfcb ("cxl: Add support to handle user feature
commands for set feature") in v6.15-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a375246fcf2bbdaeb1df7fa7ee5a8b884a89085e]

CVE-2025-40090: ksmbd: fix recursive locking in RPC handle list access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40090

Introduced by commit 305853c ("ksmbd: Fix race condition in RPC handle
list access") in v6.18-rc1.
Fixed in v6.18-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.17

Fixed status
mainline: [88f170814fea74911ceab798a43cbd7c5599bed4]
stable/6.12: [4602b8cee1481dbb896182e5cb1e8cf12910e9e7]

CVE-2025-40091: ixgbe: fix too early devlink_free() in ixgbe_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40091

Introduced by commit a028523 ("ixgbe: add initial devlink support") in
v6.16-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5feef67b646d8f5064bac288e22204ffba2b9a4a]

CVE-2025-40092: usb: gadget: f_ncm: Refactor bind path to use __free()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40092

Introduced by commit 9f6ce42 ("usb: gadget: f_ncm.c added") in v2.6.38-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75a5b8d4ddd4eb6b16cb0b475d14ff4ae64295ef]
stable/5.15: [185193a4714aa9c78437a7a1858fbe5771f0f45c]
stable/6.1: [f37de8dec6a4c379b4b8486003a1de00ff8cff3b]
stable/6.12: [d3fe7143928d8dfa2ec7bac9f906b48bc75b98ee]
stable/6.6: [1cde4516295a030cb8ab4c93114ca3b6c3c6a1e2]

CVE-2025-40093: usb: gadget: f_ecm: Refactor bind path to use __free()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40093

Introduced by commit da741b8 ("usb ethernet gadget: split CDC Ethernet
function") in v2.6.27-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [42988380ac67c76bb9dff8f77d7ef3eefd50b7b5]
stable/6.1: [d3745aaef19198d0c81637a7dd50ef53c4f879b7]
stable/6.12: [15b9faf53ba8719700596e7ef78879ce200e8c2e]
stable/6.6: [070f341d86cf2c098d63e484a86c7c1d2696a868]

CVE-2025-40094: usb: gadget: f_acm: Refactor bind path to use __free()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40094

Introduced by commit 1f1ba11 ("usb gadget: issue notifications from
ACM function") in v2.6.27-rc4.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47b2116e54b4a854600341487e8b55249e926324]
stable/5.15: [c5d116862dd3ed162d079738a5ebddf9fceea850]
stable/6.1: [2b1546f7c5fc6c44555a8e7a2b34229d1dcd2175]
stable/6.12: [201a66d8e6630762e760e1d78f1d149da1691e7b]
stable/6.6: [e348d18fb0124b662cfefb3001733b49da428215]

CVE-2025-40095: usb: gadget: f_rndis: Refactor bind path to use __free()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40095

Introduced by commit 45fe3b8 ("usb ethernet gadget: split RNDIS
function") in v2.6.27-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08228941436047bdcd35a612c1aec0912a29d8cd]
stable/6.1: [ef81226bb1f8b6e761cd0b53d2696e9c1bc955d1]
stable/6.12: [380353c3a92be7d928e6f973bd065c5b79755ac3]
stable/6.6: [5f65c8ad8c7292ed7e3716343fcd590a51818cc3]

CVE-2025-40096: drm/sched: Fix potential double free in
drm_sched_job_add_resv_dependencies

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40096

Introduced by commit 963d0b3 ("drm/scheduler: fix
drm_sched_job_add_implicit_dependencies harder") in v5.16-rc2.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5801e65206b065b0b2af032f7f1eef222aa2fd83]
stable/6.1: [4c38a63ae12ecc9370a7678077bde2d61aa80e9c]
stable/6.12: [e5e3eb2aff92994ee81ce633f1c4e73bd4b87e11]
stable/6.6: [57239762aa90ad768dac055021f27705dae73344]

CVE-2025-40097: ALSA: hda: Fix missing pointer check in
hda_component_manager_init function

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40097

Introduced by commit ae7abe3 ("ALSA: hda/realtek: Add CS35L41 support
for Thinkpad laptops") in v5.17-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1cf11d80db5df805b538c942269e05a65bcaf5bc]

CVE-2025-40098: ALSA: hda: cs35l41: Fix NULL pointer dereference in
cs35l41_get_acpi_mute_state()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40098

Introduced by commit 447106e ("ALSA: hda: cs35l41: Support mute
notifications for CS35L41 HDA") in v6.7-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8527bbb33936340525a3504a00932b2f8fd75754]

CVE-2025-40099: cifs: parse_dfs_referrals: prevent oob on malformed input

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40099

Introduced commit is not determined.Fixed in v6.18-rc2.


Fixed status
mainline: [6447b0e355562a1ff748c4a2ffb89aae7e84d2c9]
stable/6.1: [cfacc7441f760e4a73cc71b6ff1635261d534657]
stable/6.12: [8bc4a8d39bac23d8b044fd3e2dbfd965f1d9b058]
stable/6.6: [15c73964da9df994302f579ed14ee5fdbce7a332]

CVE-2025-40100: btrfs: do not assert we found block group item when
creating free space tree

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40100

Introduced by commit a5ed918 ("Btrfs: implement the free space
B-tree") in v4.5-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5a51bf4e9b7354ce7cd697e610d72c1b33fd949]
stable/6.1: [4f4b9ca73f84130d9fbb0fc02306ce94ce8bdbe6]
stable/6.12: [3fdcfd91b93f930d87843156c7c8cc5fbcf9b144]
stable/6.6: [289498da343b05c886f19b4269429606f86dd17b]

CVE-2025-40101: btrfs: fix memory leaks when rejecting a non SINGLE
data profile without an RST

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40101

Introduced by commit 5906333 ("btrfs: zoned: don't skip block group
profile checks on conventional zones") in v6.8-rc7.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fec9b9d3ced39f16be8d7afdf81f4dd2653da319]
stable/6.12: [187333e6d484c6630286bfdd07c79d6815a63887]

CVE-2025-40102: KVM: arm64: Prevent access to vCPU events before init

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40102

Introduced by commit b7b27fa ("arm/arm64: KVM: Add
KVM_GET/SET_VCPU_EVENTS") in v4.19-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0aa1b76fe1429629215a7c79820e4b96233ac4a3]

CVE-2025-40103: smb: client: Fix refcount leak for cifs_sb_tlink

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40103

Introduced by commit 8ceb984 ("CIFS: Move rename to ops struct") in v3.7-rc1.
Introduced by commit 2f1afe2 ("cifs: Use smb 2 - 3 and cifsacl mount
options getacl functions") in v4.13-rc1.
Introduced by commit 366ed84 ("cifs: Use smb 2 - 3 and cifsacl mount
options setacl function") in v4.13-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2b77f42205ef485a647f62082c442c1cd69d3fc]
stable/6.1: [790282abe9d805f08618c1c24ea2529e7259b692]
stable/6.12: [e15605b68b490186da2ad8029c0351a9cfb0b9af]
stable/6.6: [d7dd034c14928306db1b46be277ae439b84dacf9]

CVE-2025-40104: ixgbevf: fix mailbox API compatibility by negotiating
supported features

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40104

Introduced by commit 0062e7c ("ixgbevf: add VF IPsec offload code") in
v4.20-rc1.
Introduced by commit 339f289 ("ixgbevf: Add support for new mailbox
communication between PF and VF") in v5.17-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7075f501bd33c93570af759b6f4302ef0175168]
stable/6.1: [871ac1cd4ce4804defcb428cbb003fd84c415ff4]
stable/6.12: [bf580112ed61736c2645a893413a04732505d4b1]
stable/6.6: [2e0aab9ddaf1428602c78f12064cd1e6ffcc4d18]

CVE-2025-40105: vfs: Don't leak disconnected dentries on umount

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40105

Introduced by commit f1ee616 ("VFS: don't keep disconnected dentries
on d_anon") in v4.16-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56094ad3eaa21e6621396cc33811d8f72847a834]
stable/5.10: [20863bb7fbb016379f8227122edfabc5c799bc79]
stable/5.15: [8004d4b8cbf1bd68a23c160d57287e177c82cc69]
stable/5.4: [b5abafd0aa8d7bcb935c8f91e4cfc2f2820759e4]
stable/6.1: [7e0c8aaf4e28918abded547a5147c7d52c4af7d2]
stable/6.12: [620f3b0ede9c5cb4976cd0457d0b04ad551e5d6b]
stable/6.6: [cebfbf40056a4d858b2a3ca59a69936d599bd209]

CVE-2025-40106: comedi: fix divide-by-zero in comedi_buf_munge()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40106

Introduced commit is not determined.Fixed in v6.18-rc3.


Fixed status
mainline: [87b318ba81dda2ee7b603f4f6c55e78ec3e95974]
stable/5.10: [8f3e4cd9be4b47246ea73ce5e3e0fa2f57f0d10c]
stable/5.15: [2670932f2465793fea1ef073e40883e8390fa4d9]
stable/5.4: [4ffea48c69cb2b96a281cb7e5e42d706996631db]
stable/6.1: [6db19822512396be1a3e1e20c16c97270285ba1a]
stable/6.12: [a4bb5d1bc2f238461bcbe5303eb500466690bb2c]
stable/6.6: [d4854eff25efb06d0d84c13e7129bbdba4125f8c]

CVE-2025-40107: can: hi311x: fix null pointer dereference when
resuming from sleep before interface was enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40107

Introduced commit is not determined.Fixed in v6.17.
Affected driver was added by 57e83fb ("can: hi311x: Add Holt HI-311x
CAN driver") in 4.12-rc1.

Fixed status
mainline: [6b696808472197b77b888f50bc789a3bae077743]
stable/6.1: [d1fc4c041459e2d4856c1b2501486ba4f0cbf96b]
stable/6.12: [1d2ef21f02baff0c109ad78b9e835fb4acb14533]
stable/6.6: [e93af787187e585933570563c643337fa731584a]


* Updated CVEs
CVE-2024-57995: wifi: ath12k: fix read pointer after free in
ath12k_mac_assign_vif_to_vdev()

stable/6.12 was fixed.

Fixed status
stable/6.12: [57100b87c77818cb0d582a92e5cb32fff85c757d]

CVE-2025-21833: iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE

stable/6.12 was fixed.

Fixed status
stable/6.12: [68ec78beb4a3fb0877cbaaf49758c85410c05977]

CVE-2025-22105: bonding: check xdp prog when set bond mode

stable/6.12 was fixed.

Fixed status
stable/6.12: [6f3af8055ee7ab69d1451f056fcd890df99c167e]

CVE-2025-23130: f2fs: fix to avoid panic once fallocation fails for pinfile

stable/6.12 was fixed.

Fixed status
stable/6.12: [2dda0930fb79b847b4bfceb737577d0f6bc24d7d]

CVE-2025-37803: udmabuf: fix a buf size overflow issue during udmabuf creation

stable/6.12 was fixed.

Fixed status
stable/6.12: [29b65a3171a49c9b69f31035146be966cec40b7a]

CVE-2025-37860: sfc: fix NULL dereferences in ef100_process_design_param()

stable/6.12 was fixed.

Fixed status
stable/6.12: [f21623b8446735b5e2ac5f8ee69b8743177d7b19]

CVE-2025-38643: wifi: cfg80211: Add missing lock in cfg80211_check_and_end_cac()

stable/6.12 was fixed.

Fixed status
stable/6.12: [4a63523d3541eef4cf504a9682e6fbe94ffe79a6]

CVE-2025-40083: net/sched: sch_qfq: Fix null-deref in agg_dequeue

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [6ff8e74c8f8a68ec07ef837b95425dfe900d060f]
stable/6.6: [6ffa9d66187188e3068b5a3895e6ae1ee34f9199]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

