Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEA4E77188
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 22:22:58 +0000 (UTC)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
 by mx.groups.io with SMTP id smtpd.web10.117318.1734560573414018353
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 14:22:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=f70IOeCz;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.177, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso188776276.0
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 14:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1734560572; x=1735165372; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+VmZU3oonFDyAKURIX9+DpKy4wJDAkngTnEHGw+0NyI=;
        b=f70IOeCzilFOi5x6gg7u/ITOLxZPtBRtLx9cWCozfFaPuJx0LHR+tirSaWA1DM/bhx
         BmHpbEpdRxAu06xGo5zaeUXV8mimPwtOTjQAh/jRuVdws3/IvFpPfbowfdwVUMQccmA2
         LEJtuQJhcXNYovwg4FI4ZB6YGT9WTvNpqNCcYiWlXvGek6bw/5Ggdq4r8dFWciHo8sjK
         TDx7dK1ou15JtsW7cHBy7b89qiIGrJZamy86mXdcdR3pJ65PZ4VufqRde42sNYi24VsZ
         EaqkcOzwiyohhBNFeVhD1l4I29r5RbJUkbM1zE6o7ZJohMHdGwPkE10zzYbjwq37EpHt
         MbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734560572; x=1735165372;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+VmZU3oonFDyAKURIX9+DpKy4wJDAkngTnEHGw+0NyI=;
        b=oeLZjHUdaJjyGZHBhqcojmGj3tdzBdpodBRVpYRm6cfUrNyJLP+cKZ6k86pMmXpFP5
         mbMnJ4krT7UXHBc8ux+IYNB1WXkYwKNRGnsPQW6TfGpNETUO3oebfqKnw446HYJcPAB+
         eVuhhsNAMWbeH/azjJtIH1xctGxtDFz3c10LHldupVfZCx6IisaKCLSEthGkbMjlT8IR
         iMC4fhp/aNfcpbS++O+KnBUOkS1FJZY/3VKzuliNMhwMhFydHMf/pjavC6BFtJshZSyH
         VphAJf5oBp7oyWjhpZFw7um5eBFv0ZnclPrpLs5/DEUDx1Pbu6X6SxYIh/fKPLYAg0Xz
         Sutw==
X-Gm-Message-State: AOJu0YxkUMCq0c5OFEX586HObRpFlKineFZ5GtCLa7FUskt+QjUOY6Qr
	t6DVUltOVCNnimnaql1p+74DvXQN3nwKSQcBJQpZLZ6O3QJTYYPGZVVh+UWapPBZDwEu6qij1ZK
	MORjIbdD16mgTm3NGOUv8+ogqUFDK/p7Hn1GPF7iTDSp4+9PB2Fo=
X-Gm-Gg: ASbGncuVcAtL7Fflisnv6KHP2Xjghh5rRADLUsuwYcS1UwKujQBr7BlsQIRHFTcHex6
	AcDyjr5ux2mo4eW5ZI2qpcGPfT1apXI5z+ykfYxw=
X-Google-Smtp-Source: AGHT+IEAFBihZuJT1rF0Qb4CUjy/m/x6R2sglfPUxbfYit5+jwNgq+LwLYPN5qxCTVS5ANhm1M/89a769bM8XcI6P58=
X-Received: by 2002:a05:6902:248d:b0:e38:8263:7990 with SMTP id
 3f1490d57ef6-e53622618bamr4743820276.48.1734560571926; Wed, 18 Dec 2024
 14:22:51 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 19 Dec 2024 07:22:16 +0900
Message-ID: <CAODzB9pbg4b5m2YkE0RP=ZbHreFARcrG=mrXYq=rY_6sPD_uFQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 22:22:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17471

Hi!

It's this week's CVE report.

This week reported 3 new CVEs and 61 updated CVEs.

* New CVEs
CVE-2024-53240: Backend can crash Linux netfront

Announce: https://www.cve.org/CVERecord?id=CVE-2024-53240

Introduced by commit d50b791 ("xen-netfront: Fix NULL sring
after live migration") in 6.1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [f9244fb55f37356f75c739c57323d9422d7aa0f8]

CVE-2024-53241: Xen hypercall page unsafe against speculative attacks

Announce: https://www.cve.org/CVERecord?id=CVE-2024-53241

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [efbcd61d9bebb771c836a3b8bfced8165633db7c,
dda014ba59331dee4f3b773a020e109932f4bd24,
  0ef8047b737d7480a5d4c46d956e97c190f13050,
a2796dff62d6c6bfc5fbebdf2bee0d5ac0438906,
  b4845bb6383821a9516ce30af3a27dc873e37fd4,
b1c2cb86f4a7861480ad54bb9a58df3cbebf8e92,
  7fa0da5373685e7ed249af3fa317ab1e1ba8b0a6]

CVE-2024-53144: Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE

Announce: https://www.cve.org/CVERecord?id=CVE-2024-53144

Introduced by commit ba15a58 ("Bluetooth: Fix SSP acceptor just-works
confirmation without MITM") in 3.16-rc3. Fixed in 6.12-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b25e11f978b63cb7857890edb3a698599cddb10e]
stable/6.1: [d17c631ba04e960eb6f8728b10d585de20ac4f71]
stable/6.6: [830c03e58beb70b99349760f822e505ecb4eeb7e]


* Updated CVEs

CVE-2023-52916: media: aspeed: Fix memory overwrite if timing is 1600x900

stable/6.1 was fixed.

Fixed status
stable/6.1: [4c823e4027dd1d6e88c31028dec13dd19bc7b02d]

CVE-2024-26595: mlxsw: spectrum_acl_tcam: Fix NULL pointer dereference
in error path

stable/6.1 was fixed.

Fixed status
stable/6.1: [75fa2d8b3c0175b519c99ace54ab8474cfd0077e]
stable/6.6: [817840d125a370626895df269c50c923b79b0a39]
stable/6.7: [d0a1efe417c97a1e9b914056ee6b86f1ef75fe1f]

CVE-2024-27407: fs/ntfs3: Fixed overflow check in mi_enum_attr()

stable/6.1 was fixed.

Fixed status
stable/6.1: [e99faa97359654b6e4e769246c72cf50a57e05b2]
stable/6.6: [8c77398c72618101d66480b94b34fe9087ee3d08]

CVE-2024-35956: btrfs: qgroup: fix qgroup prealloc rsv leak in
subvolume operations

stable/6.1 was fixed.

Fixed status
stable/6.1: [945559be6e282a812dc48f7bcd5adc60901ea4a0]
stable/6.6: [14431815a4ae4bcd7c7a68b6a64c66c7712d27c9]
stable/6.8: [6c95336f5d8eb9ab79cd7306d71b6d0477363f8c]

CVE-2024-36479: fpga: bridge: add owner module and take its refcount

stable/6.1 was fixed.

Fixed status
stable/6.1: [18dc8366abb6cadcb77668b1a16434654e355d49]
stable/6.6: [d7c4081c54a1d4068de9440957303a76f9e5c95b]
stable/6.9: [6896b6b2e2d9ec4e1b0acb4c1698a75a4b34d125]

CVE-2024-37021: fpga: manager: add owner module and take its refcount

stable/6.1 was fixed.

Fixed status
stable/6.1: [304f8032d601d4f9322ca841cd0b573bd1beb158]
stable/6.6: [2da62a139a6221a345db4eb9f4f1c4b0937c89ad]
stable/6.9: [62ac496a01c9337a11362cea427038ba621ca9eb]

CVE-2024-39494: ima: Fix use-after-free on a dentry's dname.name

stable/5.15 was fixed.

Fixed status
stable/5.15: [0b31e28fbd773aefb6164687e0767319b8199829]
stable/6.1: [7fb374981e31c193b1152ed8d3b0a95b671330d4]
stable/6.6: [dd431c3ac1fc34a9268580dd59ad3e3c76b32a8c]
stable/6.9: [a78a6f0da57d058e2009e9958fdcef66f165208c]

CVE-2024-41014: xfs: add bounds checking to xlog_recover_process_data

stable/6.1 was fixed.

Fixed status
stable/6.1: [d1e3efe783365db59da88f08a2e0bfe1cc95b143]
stable/6.6: [7cd9f0a33e738cd58876f1bc8d6c1aa5bc4fc8c1]

CVE-2024-42252: closures: Change BUG_ON() to WARN_ON()

stable/6.1 was fixed.

Fixed status
stable/6.1: [c894a74756478bb7aec894bcc513add3d554c0cf]
stable/6.6: [ecb4aaa658da760fb83afd79cc5fd4360aa60635]

CVE-2024-42319: mailbox: mtk-cmdq: Move
devm_mbox_controller_register() after devm_pm_runtime_enable()

stable/6.1 was fixed.

Fixed status
stable/6.1: [1403991a40b94438a2acc749bf05c117abdb34f9]
stable/6.10: [11fa625b45faf0649118b9deaf2d31c86ac41911]
stable/6.6: [d00df6700ad10974a7e20646956f4ff22cdbe0ec]

CVE-2024-44940: fou: remove warn in gue_gro_receive on unsupported protocol

stable/5.15 was fixed.

Fixed status
stable/5.15: [b1453a5616c7bd8acd90633ceba4e59105ba3b51]
stable/6.1: [5a2e37bc648a2503bf6d687aed27b9f4455d82eb]
stable/6.10: [440ab7f97261bc28501636a13998e1b1946d2e79]
stable/6.6: [3db4395332e7050ef9ddeb3052e6b5019f2a2a59]

CVE-2024-44949: parisc: fix a possible DMA corruption

stable/5.15 was fixed.

Fixed status
stable/5.15: [dadac97f066a67334268132c1e2d0fd599fbcbec]
stable/6.1: [00baca74fb5879e5f9034b6156671301f500f8ee]
stable/6.10: [533de2f470baac40d3bf622fe631f15231a03c9f]
stable/6.6: [642a0b7453daff0295310774016fcb56d1f5bc7f]

CVE-2024-44950: serial: sc16is7xx: fix invalid FIFO access with
special register set

stable/6.1 was fixed.

Fixed status
stable/6.1: [cc6a3f35bc9b3a8da1b195420a2e8d9fdadfa831]
stable/6.10: [6a6730812220a9a5ce4003eb347da1ee5abd06b0]
stable/6.6: [dc5ead0e8fc5ef53b8553394d4aab60c277976b3]

CVE-2024-46809: drm/amd/display: Check BIOS images before it is used

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [4fcd903a5d9e897420d7d8b3ca55c6e5dbb47379]
stable/5.15: [c5cb98554c4c6265b494d040c1c62f1db2fa28a6]
stable/6.1: [eef7301e674438913134539e77dd887960949f20]
stable/6.10: [e46b70a7cfed71cb84e985c785c39c16df5c28cb]
stable/6.6: [e50bec62acaeec03afc6fa5dfb2426e52d049cf5]

CVE-2024-46841: btrfs: don't BUG_ON on ENOMEM from
btrfs_lookup_extent_info() in walk_down_proc()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c1406d8329f500e4594cd9730cd313aebc3a4333]
stable/5.15: [6a0648f96c3ca647c71c6c1ddbc7c353bab79f64]
stable/6.1: [44a2c518ab221c0cadcb8c45ca86f83a52dd4da6]
stable/6.10: [704c359b4093a2af650a20eaa030c435d7c30f91]
stable/6.6: [135b4819f6fba87fd5a2693023133e78ac73f1d3]

CVE-2024-46871: drm/amd/display: Correct the defined value for
AMDGPU_DMUB_NOTIFICATION_MAX

stable/5.15 was fixed.

Fixed status
stable/5.15: [e1896f381d27466c26cb44b4450eae05cd59dfd0]
stable/6.1: [9f404b0bc2df3880758fb3c3bc7496f596f347d7]
stable/6.10: [c592b6355b9b57b8e59fc5978ce1e14f64488a98]
stable/6.6: [800a5ab673c4a61ca220cce177386723d91bdb37]

CVE-2024-47730: crypto: hisilicon/qm - inject error before stopping queue

stable/5.15 was fixed.

Fixed status
stable/5.15: [801d64177faaec184cee1e1aa4d8487df1364a54]
stable/6.1: [98d3be34c9153eceadb56de50d9f9347e88d86e4]
stable/6.11: [c5f5b813e546f7fe133539c3d7a5086cc8dd2aa1]
stable/6.6: [aa3e0db35a60002fb34ef0e4ad203aa59fd00203]

CVE-2024-47745: mm: call the security_mmap_file() LSM hook in remap_file_pages()

stable/6.1 was fixed.

Fixed status
stable/6.1: [0f910dbf2f2a4a7820ba4bac7b280f7108aa05b1]
stable/6.11: [ce14f38d6ee9e88e37ec28427b4b93a7c33c70d3]
stable/6.6: [49d3a4ad57c57227c3b0fd6cd4188b2a5ebd6178]

CVE-2024-49861: bpf: Fix helper writes to read-only maps

stable/6.1 was fixed.

Fixed status
stable/6.1: [988e55abcf7fdb8fc9a76a7cf3f4e939a4d4fb3a]
stable/6.11: [1e75d25133158b525e0456876e9bcfd6b2993fd5]
stable/6.6: [a2c8dc7e21803257e762b0bf067fd13e9c995da0]

CVE-2024-49874: i3c: master: svc: Fix use after free vulnerability in
svc_i3c_master Driver Due to Race Condition

stable/6.1 was fixed.

Fixed status
stable/6.1: [56bddf543d4d7ddeff3f87b554ddacfdf086bffe]
stable/6.11: [27b55724d3f781dd6e635e89dc6e2fd78fa81a00]
stable/6.6: [4ac637122930cc4ab7e2c22e364cf3aaf96b05b1]

CVE-2024-49891: scsi: lpfc: Validate hdwq pointers before
dereferencing in reset/errata paths

stable/6.1 was fixed.

Fixed status
stable/6.1: [5873aa7f814754085d418848b2089ef406a02dd0]
stable/6.11: [fd665c8dbdb19548965b0ae80c490de00e906366]
stable/6.6: [232a138bd843d48cb2368f604646d990db7640f3]

CVE-2024-49897: drm/amd/display: Check phantom_stream before it is used

stable/6.1 was fixed.

Fixed status
stable/6.1: [db1d7e1794fed62ee16d6a72a85997bb069e2e27]
stable/6.11: [3ba1219e299ab5462b5cb374c2fa2a67af0ea190]
stable/6.6: [d247af7c5dbf143ad6be8179bb1550e76d6af57e]

CVE-2024-49898: drm/amd/display: Check null-initialized variables

stable/6.1 was fixed.

Fixed status
stable/6.1: [26d262b79a3587aaa84368586a55e9026c67841b]
stable/6.11: [115b1a3b0944b4d8ef0b4b0c5a625bdd9474131f]
stable/6.6: [c3a3b6d9a9383e3c1a4a08878ba5046e68647595]

CVE-2024-49899: drm/amd/display: Initialize denominators' default to 1

stable/6.1 was fixed.

Fixed status
stable/6.1: [9be768f08b16f020da376538b08463ac3a2ce8cd]
stable/6.11: [7f8e93b862aba08d540f1e9e03e0ceb4d0cfd5fb]
stable/6.6: [9f35cec5e4b9759b38c663d18eae4eaf30f36527]

CVE-2024-49909: drm/amd/display: Add NULL check for function pointer
in dcn32_set_output_transfer_func

stable/6.1 was fixed.

Fixed status
stable/6.1: [e087c9738ee1cdeebde346f4dfc819e5f7057e90]
stable/6.11: [5298270bdabe97be5b8236e544c9e936415fe1f2]
stable/6.6: [f38b09ba6a335c511eb27920bb9bb4a1b2c20084]

CVE-2024-49911: drm/amd/display: Add NULL check for function pointer
in dcn20_set_output_transfer_func

stable/6.1 was fixed.

Fixed status
stable/6.1: [e8a24767899c86f4c5f1e4d3b2608942d054900f]
stable/6.11: [827380b114f83c30b3e56d1a675980b6d65f7c88]
stable/6.6: [8c854138b593efbbd8fa46a25f3288c121c1d1a1]

CVE-2024-49915: drm/amd/display: Add NULL check for clk_mgr in dcn32_init_hw

stable/6.1 was fixed.

Fixed status
stable/6.1: [0d94d9cbd9fec7344d230c4f7b781826f7799c60]
stable/6.11: [7d1854c86d02cea8f8a0c0ca05f4ab14292baf3d]
stable/6.6: [ec1be3c527b4a5fc85bcc1b0be7cec08bf60c796]

CVE-2024-49917: drm/amd/display: Add NULL check for clk_mgr and
clk_mgr->funcs in dcn30_init_hw

stable/6.1 was fixed.

Fixed status
stable/6.1: [23cb6139543580dc36743586ca86fbb3f7ab2c9d]
stable/6.11: [56c326577971adc3a230f29dfd3aa3abdd505f5d]
stable/6.6: [205e3b96cc9aa9211fd2c849a16245cf236b2d36]

CVE-2024-49925: fbdev: efifb: Register sysfs groups through driver core

stable/6.1 was fixed.

Fixed status
stable/6.1: [2a9c40c72097b583b23aeb2a26d429ccfc81fbc1]
stable/6.11: [4684d69b9670a83992189f6271dc0fcdec4ed0d7]
stable/6.6: [36bfefb6baaa8e46de44f4fd919ce4347337620f]

CVE-2024-49926: rcu-tasks: Fix access non-existent percpu rtpcp
variable in rcu_tasks_need_gpcb()

stable/6.1 was fixed.

Fixed status
stable/6.1: [224fd631c41b81697aa622d38615bfbf446b91cf]
stable/6.11: [05095271a4fb0f6497121a057f9a2edf386d5d96]
stable/6.6: [b3b2431ed27f4ebc28e26cdf005c1de42dc60bdf]

CVE-2024-49929: wifi: iwlwifi: mvm: avoid NULL pointer dereference

stable/6.1 was fixed.

Fixed status
stable/6.1: [cbc6fc9cfcde151ff5eadaefdc6155f99579384f]
stable/6.11: [c0b4f5d94934c290479180868a32c15ba36a6d9e]
stable/6.6: [6dcadb2ed3b76623ab96e3e7fbeda1a374d01c28]

CVE-2024-49934: fs/inode: Prevent dump_mapping() accessing invalid
dentry.d_name.name

stable/6.1 was fixed.

Fixed status
stable/6.1: [1a4159138e718db6199f0abf376ad52f726dcc5c]
stable/6.11: [ef921bc72328b577cb45772ff7921cba4773b74a]
stable/6.6: [e0f6ee75f50476607ca82fc7c3711c795ce09b52]

CVE-2024-49939: wifi: rtw89: avoid to add interface to list twice when SER

stable/6.1 was fixed.

Fixed status
stable/6.1: [b04650b5a9990cf5c0de480e62c68199f1396a04]
stable/6.11: [490eddc836b2a6ec286e5df14bed4c7cf5e1f475]
stable/6.6: [fdc73f2cfbe897f4733156df211d79ced649b23c]

CVE-2024-49950: Bluetooth: L2CAP: Fix uaf in l2cap_connect

stable/5.15 was fixed.

Fixed status
stable/5.15: [686e05c9dbd68766c6bda5f31f7e077f36a7fb29]
stable/6.1: [b22346eec479a30bfa4a02ad2c551b54809694d0]
stable/6.11: [a1c6174e23df10b8e5770e82d63bc6e2118a3dc7]
stable/6.6: [b90907696c30172b809aa3dd2f0caffae761e4c6]

CVE-2024-49951: Bluetooth: MGMT: Fix possible crash on mgmt_index_removed

stable/6.1 was fixed.

Fixed status
stable/6.1: [19b40ca62607cef78369549d1af091f2fd558931]
stable/6.11: [8c3f7943a29145d8a2d8e24893762f7673323eae]
stable/6.6: [4883296505aa7e4863c6869b689afb6005633b23]

CVE-2024-49974: NFSD: Limit the number of concurrent async COPY operations

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [9e52ff544e0bfa09ee339fd7b0937ee3c080c24e]
stable/5.15: [43e46ee5efc03990b223f7aa8b77aa9c3d3acfdf]
stable/6.1: [7ea9260874b779637aff6d24c344b8ef4ac862a0]
stable/6.11: [6a488ad7745b8f64625c6d3a24ce7e448e83f11b]
stable/6.6: [ae267989b7b7933dfedcd26468d0a88fc3a9da9e]

CVE-2024-49996: cifs: Fix buffer overflow when parsing NFS reparse points

stable/5.10, stable/5.15, stable/5.4, stable/6.1 were fixed.

Fixed status
stable/5.10: [73b078e3314d4854fd8286f3ba65c860ddd3a3dd]
stable/5.15: [01cdddde39b065074fd48f07027757783cbf5b7d]
stable/5.4: [7b222d6cb87077faf56a687a72af1951cf78c8a9]
stable/6.1: [ec79e6170bcae8a6036a4b6960f5e7e59a785601]
stable/6.11: [c173d47b69f07cd7ca08efb4e458adbd4725d8e9]
stable/6.6: [c6db81c550cea0c73bd72ef55f579991e0e4ba07]

CVE-2024-50055: driver core: bus: Fix double free in driver API bus_register()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [5be4bc1c73ca389a96d418a52054d897c6fe6d21]
stable/5.15: [4797953712214ea57a437443bb0ad6d1e0646d70]
stable/6.1: [fc1f391a71a3ee88291e205cffd673fe24d99266]
stable/6.11: [9ce15f68abedfae7ae0a35e95895aeddfd0f0c6a]
stable/6.6: [d885c464c25018b81a6b58f5d548fc2e3ef87dd1]

CVE-2024-50241: NFSD: Initialize struct nfsd4_copy earlier

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [059434d23c4578d9d02efb92d848ea21bc640112]
stable/5.15: [7267625baf365a969f1b25ded6f07b64bc90ec5b]
stable/6.1: [c3074003fa6837c2b89a34d8d12d9463b59d22d6]
stable/6.11: [e30a9a2f69c34a00a3cb4fd45c5d231929e66fb1]
stable/6.6: [421f1a2a1afb47d88de09457ef7687e1df7bc997]

CVE-2024-50248: ntfs3: Add bounds checking to mi_enum_attr()

stable/6.1 was fixed.

Fixed status
stable/6.1: [386613a44b858304a88529ade2ccc1e079a5fc56]
stable/6.11: [809f9b419c75f8042c58434d2bfe849140643e9d]
stable/6.6: [22cdf3be7d34f61a91b9e2966fec3a29f3871398]

CVE-2024-50258: net: fix crash when config small gso_max_size/gso_ipv4_max_size

stable/6.1 was fixed.

Fixed status
stable/6.1: [e9365368b483328639c03fc730448dccd5a25b6b]
stable/6.11: [e72fd1389a5364bc6aa6312ecf30bdb5891b9486]
stable/6.6: [ac5977001eee7660c643f8e07a2de9001990b7b8]

CVE-2024-50275: arm64/sve: Discard stale CPU state when handling SVE traps

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [51d3d80a6dc314982a9a0aeb0961085922a1aa15]
stable/6.1: [de529504b3274d57caf8f66800b714b0d3ee235a]
stable/6.11: [fa9ce027b3ce37a2bb173bf2553b5caa438fd8c9]
stable/6.6: [51d11ea0250d6ee461987403bbfd4b2abb5613a7]

CVE-2024-50283: ksmbd: fix slab-use-after-free in smb3_preauth_hash_rsp

stable/5.15 was fixed.

Fixed status
stable/5.15: [cb645064e0811053c94e86677f2e58ed29359d62]
stable/6.1: [f7557bbca40d4ca8bb1c6c940ac6c95078bd0827]
stable/6.11: [1b6ad475d4ed577d34e0157eb507be00c588bf5c]
stable/6.6: [c6cdc08c25a868a08068dfc319fa9fce982b8e7f]

CVE-2024-53073: NFSD: Never decrement pending_async_copies on error

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [ed98d26021db0fe62c327aa9f5e57a90bff3fa94]
stable/5.15: [9467c49437e948c541569007cd412d577942e635]
stable/6.1: [949ee5d44d1fd95119b29b3382a933cdc617bf9e]
stable/6.11: [1421883aa30c5d26bc3370e2d19cb350f0d5ca28]
stable/6.6: [fb79d68a36e21960341ccab07d1ac06d93830321]

CVE-2024-53096: mm: resolve faulty mmap_region() error path behaviour

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [43323a4e5b3f8ccc08e2f835abfdc7ee9da8f6ed]
stable/5.15: [44f48eb9a6051826227bbd375446064fb2a43c6c]
stable/6.1: [52c81fd0f5a8bf8032687b94ccf00d13b44cc5c8]
stable/6.6: [bdc136e2b05fabcd780fe5f165d154eb779dfcb0]

CVE-2024-53105: mm: page_alloc: move mlocked flag clearance into
free_pages_prepare()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [2521664c1fc0fcea825ef0b4d8e2dfb622bc0f9a]
stable/6.11: [7873d11911cd1d21e25c354eb130d8c3b5cb3ca5]
stable/6.6: [81ad32b87eb91b627a4b0d8760434e5fac4b993a]

CVE-2024-53112: ocfs2: uncache inode which has failed entering the group

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/4.19: [ac0cfe8ac35cf1be54131b90d114087b558777ca]
stable/5.10: [28d4ed71ae0b4baedca3e85ee6d8f227ec75ebf6]
stable/5.15: [0e04746db2ec4aec04cef5763b9d9aa32829ae2f]
stable/5.4: [5ae8cc0b0c027e9cab22596049bc4dd1cbc37ee4]
stable/6.1: [620d22598110b0d0cb97a3fcca65fc473ea86e73]
stable/6.11: [b751c50e19d66cfb7360c0b55cf17b0722252d12]
stable/6.6: [843dfc804af4b338ead42331dd58081b428ecdf8]

CVE-2024-53113: mm: fix NULL pointer dereference in alloc_pages_bulk_noprof

stable/5.15 was fixed.

Fixed status
stable/5.15: [903d896448c2e50e8652aaba529a30d4d1eaa0e5]
stable/6.1: [6addb2d9501ec866d7b3a3b4e665307c437e9be2]
stable/6.11: [31502374627ba9ec3e710dbd0bb00457cc6d2c19]
stable/6.6: [d0f16cec79774c3132df006cf771eddd89d08f58]

CVE-2024-53120: net/mlx5e: CT: Fix null-ptr-deref in add rule err flow

stable/5.15 was fixed.

Fixed status
stable/5.15: [882f392d9e3649557e71efd78ae20c86039ffb7c]
stable/6.1: [0c7c70ff8b696cfedba350411dca736361ef9a0f]
stable/6.11: [6030f8bd7902e9e276a0edc09bf11979e4e2bc2e]
stable/6.6: [06dc488a593020bd2f006798557d2a32104d8359]

CVE-2024-53121: net/mlx5: fs, lock FTE when checking if active

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [a508c74ceae2f5a4647f67c362126516d6404ed9]
stable/5.15: [5b47c2f47c2fe921681f4a4fe2790375e6c04cdd]
stable/5.4: [0d568258f99f2076ab02e9234cbabbd43e12f30e]
stable/6.1: [bfba288f53192db08c68d4c568db9783fb9cb838]
stable/6.11: [933ef0d17f012b653e9e6006e3f50c8d0238b5ed]
stable/6.6: [094d1a2121cee1e85ab07d74388f94809dcfb5b9]

CVE-2024-53122: mptcp: cope racing subflow creation in mptcp_rcv_space_adjust

stable/5.15 was fixed.

Fixed status
stable/5.15: [0a9a182ea5c7bb0374e527130fd85024ace7279b]
stable/6.1: [24995851d58c4a205ad0ffa7b2f21e479a9c8527]
stable/6.11: [aad6412c63baa39dd813e81f16a14d976b3de2e8]
stable/6.6: [ff825ab2f455299c0c7287550915a8878e2a66e0]

CVE-2024-53127: Revert "mmc: dw_mmc: Fix IDMAC operation with pages
bigger than 4K"

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/4.19: [00bff71745bc3583bd5ca59be91e0ee1d27f1944]
stable/5.10: [938c13740f8b555986e53c0fcbaf00dcd1fabd4c]
stable/5.15: [f701eb601470bfc0a551913ce5f6ebaa770f0ce0]
stable/5.4: [47693ba35bccaa16efa465159a1c12d78258349e]
stable/6.1: [8f9416147d7ed414109d3501f1cb3d7a1735b25a]
stable/6.11: [a4685366f07448420badb710ff5c12aaaadf63ad]
stable/6.6: [56de724c58c07a7ca3aac027cfd2ccb184ed9e4e]

CVE-2024-53129: drm/rockchip: vop: Fix a dereferenced before check warning

stable/5.15 was fixed.

Fixed status
stable/5.15: [4e47b99a7764b23a431bff6a3f91dfe77d294765]
stable/6.1: [656dbd1c21c2c088c70059cdd43ec83e7d54ec4d]
stable/6.11: [bbf8bc7e75863942028131ae39c23118f62de6c0]
stable/6.6: [1e53059729691ca4d905118258b9fbd17d854174]

CVE-2024-53130: nilfs2: fix null-ptr-deref in block_dirty_buffer tracepoint

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/4.19: [7af3309c7a2ef26831a67125b11c34a7e01c1b2a]
stable/5.10: [0a5014ad37c77ac6a2c525137c00a0e1724f6020]
stable/5.15: [d904e4d845aafbcfd8a40c1df7d999f02f062be8]
stable/5.4: [0ce59fb1c73fdd5b6028226aeb46259a0cdc0957]
stable/6.1: [86b19031dbc79abc378dfae357f6ea33ebeb0c95]
stable/6.11: [ffc440a76a0f476a7e6ea838ec0dc8e9979944d1]
stable/6.6: [b0e4765740040c44039282057ecacd7435d1d2ba]

CVE-2024-53131: nilfs2: fix null-ptr-deref in block_touch_buffer tracepoint

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/4.19: [085556bf8c70e2629e02e79268dac3016a08b8bf]
stable/5.10: [b017697a517f8779ada4e8ce1c2c75dbf60a2636]
stable/5.15: [19c71cdd77973f99a9adc3190130bc3aa7ae5423]
stable/5.4: [6438f3f42cda825f6f59b4e45ac3a1da28a6f2c9]
stable/6.1: [3b2a4fd9bbee77afdd3ed5a05a0c02b6cde8d3b9]
stable/6.11: [77e47f89d32c2d72eb33d0becbce7abe14d061f4]
stable/6.6: [59b49ca67cca7b007a5afd3de0283c8008157665]

CVE-2024-53135: KVM: VMX: Bury Intel PT virtualization (guest/host
mode) behind CONFIG_BROKEN

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [d4b42f926adcce4e5ec193c714afd9d37bba8e5b]
stable/5.15: [b8a1d572478b6f239061ee9578b2451bf2f021c2]
stable/5.4: [c3742319d021f5aa3a0a8c828485fee14753f6de]
stable/6.1: [e6716f4230a8784957273ddd27326264b27b9313]
stable/6.11: [b91bb0ce5cd7005b376eac690ec664c1b56372ec]
stable/6.6: [d28b059ee4779b5102c5da6e929762520510e406]

CVE-2024-53136: mm: revert "mm: shmem: fix data-race in shmem_getattr()"

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/4.19: [36b537e8f302f670c7cf35d88a3a294443e32d52]
stable/5.10: [57cc8d253099d1b8627f0fb487ee011d9158ccc9]
stable/5.15: [d3f9d88c2c03b2646ace336236adca19f7697bd3]
stable/5.4: [a3c65022d89d5baa2cea8e87a6de983ea305f14c]
stable/6.1: [5874c1150e77296565ad6e495ef41fbf87570d14]
stable/6.11: [901dc2ad7c3789fa87dc3956f6697c5d62d5cf7e]
stable/6.6: [64e67e8694252c1bf01b802ee911be3fee62c36b]

CVE-2024-53138: net/mlx5e: kTLS, Fix incorrect page refcounting

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [ffad2ac8c859c1c1a981fe9c4f7ff925db684a43]
stable/5.15: [c7b97f9e794d8e2bbaa50e1d6c230196fd214b5e]
stable/5.4: [a0ddb20a748b122ea86003485f7992fa5e84cc95]
stable/6.1: [69fbd07f17b0fdaf8970bc705f5bf115c297839d]
stable/6.11: [2723e8b2cbd486cb96e5a61b22473f7fd62e18df]
stable/6.6: [93a14620b97c911489a5b008782f3d9b0c4aeff4]

CVE-2024-53140: netlink: terminate outstanding dump on socket close

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/4.19: [114a61d8d94ae3a43b82446cf737fd757021b834]
stable/5.10: [6e3f2c512d2b7dbd247485b1dd9e43e4210a18f4]
stable/5.15: [d2fab3d66cc16cfb9e3ea1772abe6b79b71fa603]
stable/5.4: [598c956b62699c3753929602560d8df322e60559]
stable/6.1: [4e87a52133284afbd40fb522dbf96e258af52a98]
stable/6.11: [176c41b3ca9281a9736b67c6121b03dbf0c8c08f]
stable/6.6: [bbc769d2fa1b8b368c5fbe013b5b096afa3c05ca]

CVE-2024-53141: netfilter: ipset: add missing range check in bitmap_ip_uadt

stable/5.10, stable/5.15, stable/5.4, stable/6.1 were fixed.

Fixed status
stable/4.19: [3c20b5948f119ae61ee35ad8584d666020c91581]
stable/5.10: [2e151b8ca31607d14fddc4ad0f14da0893e1a7c7]
stable/5.15: [e67471437ae9083fa73fa67eee1573fec1b7c8cf]
stable/5.4: [78b0f2028f1043227a8eb0c41944027fc6a04596]
stable/6.1: [7ffef5e5d5eeecd9687204a5ec2d863752aafb7e]
stable/6.12: [15794835378ed56fb9bacc6a5dd3b9f33520604e]
stable/6.6: [856023ef032d824309abd5c747241dffa33aae8c]

CVE-2024-53142: initramfs: avoid filename buffer overrun

stable/5.10, stable/5.15, stable/5.4, stable/6.1 were fixed.

Fixed status
stable/4.19: [bb7ac96670ab1d8d681015f9d66e45dad579af4d]
stable/5.10: [d3df9f26cff97beaa5643e551031795d5d5cddbe]
stable/5.15: [6983b8ac787b3add5571cda563574932a59a99bb]
stable/5.4: [c509b1acbd867d9e09580fe059a924cb5825afb1]
stable/6.1: [f892ddcf9f645380c358e73653cb0900f6bc9eb8]
stable/6.12: [fb83b093f75806333b6f4ae29b158d2e0e3ec971]
stable/6.6: [1a423bbbeaf9e3e20c4686501efd9b661fe834db]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

