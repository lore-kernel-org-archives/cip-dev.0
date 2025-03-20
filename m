Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51165C35FFA
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 00:43:16 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
 by mx.groups.io with SMTP id smtpd.web11.2253.1742431389538616128
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 17:43:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=Aj2J8X6K;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.179, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f74b78df93so2924847b3.0
        for <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 17:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1742431388; x=1743036188; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7BW8VxDWocNNlUqzF9Y7acnIhXDgNe77zkoD3DFhk9c=;
        b=Aj2J8X6KTVRGlPcvcZGrle7QnirC8PHnuJ6LwQzd6/K5pugiQsinyrP9kzH5OC1acu
         KHUDVIai/FJqtydWWSJdZ/eNOv05jKDLhU72qZbWXUDNrDxRkraPMigfiI9/g6c93x3d
         Z3d3TLs6YrR9izCvOX19EjtdqSeM0Hk4haLM1mzUzw+eetSZaqa4lG+EyOwzG3nV/pee
         4pP2T7LfIPGhMlzpvaqbmjVS1QBoudncoR7JLCpmU6rpMGJMoc9BBzwWIm+TttywXj7F
         YWs3W9FmQbsy7Au6fy6nvU2pqZWv835JivGSFNR4UAr0MMxzUBRzZarT39S6AAGCo4Oc
         XDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742431388; x=1743036188;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7BW8VxDWocNNlUqzF9Y7acnIhXDgNe77zkoD3DFhk9c=;
        b=OgvPBWEF2G+YmkszPyATF7e1V7yj6PqqcdZTGxlRgcei+USEWAMDl9i4pmo1/ZEmXR
         jP+mKeHnxlRI2mw9LAoyd8HnDP5SENYpekPzjK1+xW9FOmOZl/V1Srv9HXCm+0uVEX2M
         jhg190RG+zAXhwK0DRlDDur684heAPTM+z/8vgI1GnqEUdD+wrhHdQ2BW6Qho1qV3U18
         lIowAAHeB47PmA6KbAbuuc0XacXPaVGPpcAVnNbzO2G0XOIlgINM90EKtO3anOJeApn5
         LTVB6dcaQ+I9uAva424YA5U/Pd24sZcYEh8lBSAimxjmriJAXcMX6OmEe5260ofBNxMS
         moxA==
X-Gm-Message-State: AOJu0YzdaLtLC5QMmt3yLvPhUJTq2PxyH/fR39gwM8KBjcubDrdaZCD2
	WpC1/lPL7Iqxp+ZlweY/m5NkdS9jOkSLo3GZ1YNX7j3cf4u2pWLuLPonOCd9z/DKlktPbyLPG7O
	30bo7RnveQM8C9HR2P0X9+FQZWhln1S51UsF8QF+3I0JJUIt4gZs=
X-Gm-Gg: ASbGncuNJa7s0TI+xsHhXoBtvMXJlQTlzivc72HFqEzxsYH8je21AVfZgaCEGlB87uE
	RTXa7XILpFlQUOm3+u9AaxmD75UcKYK96BP9Y4SirV/2m9I7HMN9TXm+uZZoKC+xcaa0bOGyotW
	xQm61hOcOaFdB7JUf4qnJuvKr1Z/XwExxS50evBQ==
X-Google-Smtp-Source: AGHT+IESJpGSIWVEePXAKfTOzbIQ8Sdomg2Nx/wdXQcqGvhtezAzWLxYHDDtKaY8JJisAskWSmYvT+I+phv/is6u2tA=
X-Received: by 2002:a05:690c:9b13:b0:6fb:9786:5871 with SMTP id
 00721157ae682-700ac594880mr16525197b3.7.1742431387445; Wed, 19 Mar 2025
 17:43:07 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 20 Mar 2025 09:42:31 +0900
X-Gm-Features: AQ5f1Jr4MqJezDbSiV7lpwfgfNDoY4AcM5iVzU49gaiDR6Qj1PWKymhPfo7cDHM
Message-ID: <CAODzB9rLda1v-H1-McndnBZOxNg9H4b5ozptoSZRone8f9+VKA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 00:43:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18281

Hi!

It's this week's CVE report.

This week reported 2 new CVEs and 110 updated CVEs.

* New CVEs

CVE-2023-52927: netfilter: allow exp not to be removed in nf_ct_find_expectation

Announce: https://lore.kernel.org/linux-cve-announce/2025031432-CVE-2023-52927-b600@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.6-rc1.

Fixed status
mainline: [4914109a8e1e494c6aa9852f9e84ec77a5fc643f]
stable/6.1: [3fa58a6fbd1e9e5682d09cdafb08fba004cb12ec]

CVE-2025-2312: cifs-utils: cifs.upcall makes an upcall to the wrong namespace in
containerized environments

Announce: https://www.cve.org/CVERecord?id=CVE-2025-2312

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db363b0a1d9e6b9dc556296f1b1007aeb496a8cf]

* Updated CVEs
CVE-2024-24855: NULL pointer dereference bug was found in scsi device driver

stable/6.1 was fixed.

Fixed status
stable/6.1: [30652c8ceb9a1e6c13c03f9e570d560f86022d75]

CVE-2024-26982: Squashfs: check the inode number is not the invalid
value of zero

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [4a1b6f89825e267e156ccaeba3d235edcac77f94]
stable/5.15: [cf46f88b92cfc0e32bd8a21ba1273cff13b8745f]
stable/5.4: [32c114a58236fe67141634774559f21f1dc96fd7]
stable/6.1: [5b99dea79650b50909c50aba24fbae00f203f013]
stable/6.6: [be383effaee3d89034f0828038f95065b518772e]
stable/6.8: [7def00ebc9f2d6a581ddf46ce4541f84a10680e5]

CVE-2024-39494: ima: Fix use-after-free on a dentry's dname.name

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [edf287bc610b18d7a9c0c0c1cb2e97b9348c71bb]
stable/5.15: [0b31e28fbd773aefb6164687e0767319b8199829]
stable/5.4: [480afcbeb7aaaa22677d3dd48ec590b441eaac1a]
stable/6.1: [7fb374981e31c193b1152ed8d3b0a95b671330d4]
stable/6.6: [dd431c3ac1fc34a9268580dd59ad3e3c76b32a8c]
stable/6.9: [a78a6f0da57d058e2009e9958fdcef66f165208c]

CVE-2024-43831: media: mediatek: vcodec: Handle invalid decoder vsi

stable/6.1 was fixed.

Fixed status
stable/6.1: [dbd3e4adb98e50ede74f00b3fa956fa29ef95e6c]
stable/6.10: [cdf05ae76198c513836bde4eb55f099c44773280]
stable/6.6: [1c109f23b271a02b9bb195c173fab41e3285a8db]

CVE-2024-47726: f2fs: fix to wait dio completion

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [7be13b73409b553d9d9a6cbb042b4d19e2631cc7]
stable/5.15: [3aa5254d80969cb576601fb9fec7a188cc8dc169]
stable/6.1: [f81302decd64245bb1bd154ecae0f65a9ee21f04]
stable/6.11: [e3db757ff9b7101ae68650ac5f6dd5743b68164e]
stable/6.6: [c2a7fc514637f640ff55c3f3e3ed879970814a3f]

CVE-2024-47730: crypto: hisilicon/qm - inject error before stopping queue

stable/5.10 was fixed.

Fixed status
stable/5.10: [85e81103033324d7a271dafb584991da39554a89]
stable/5.15: [801d64177faaec184cee1e1aa4d8487df1364a54]
stable/6.1: [98d3be34c9153eceadb56de50d9f9347e88d86e4]
stable/6.11: [c5f5b813e546f7fe133539c3d7a5086cc8dd2aa1]
stable/6.6: [aa3e0db35a60002fb34ef0e4ad203aa59fd00203]

CVE-2024-50055: driver core: bus: Fix double free in driver API bus_register()

stable/5.4 was fixed.

Fixed status
stable/5.10: [5be4bc1c73ca389a96d418a52054d897c6fe6d21]
stable/5.15: [4797953712214ea57a437443bb0ad6d1e0646d70]
stable/5.4: [87bc3cb23c56de2c5e14a58d87cf953e7a2508f8]
stable/6.1: [fc1f391a71a3ee88291e205cffd673fe24d99266]
stable/6.11: [9ce15f68abedfae7ae0a35e95895aeddfd0f0c6a]
stable/6.6: [d885c464c25018b81a6b58f5d548fc2e3ef87dd1]

CVE-2024-50246: fs/ntfs3: Add rough attr alloc_size check

stable/6.1 was fixed.

Fixed status
stable/6.1: [effac690913af9a6c3d6cd967281a34e47ed3e4c]
stable/6.11: [2fcae4c2014a40c8ae0fc3d8cca3ba9e168308de]
stable/6.6: [e91fbb21f248bdd8140f343dac32b77b9bc10fec]

CVE-2024-53075: riscv: Prevent a bad reference count on CPU nodes

stable/6.6 was fixed.

Fixed status
stable/6.11: [303846a3dc275e35fbb556d72f1e356ba669e4f8]
stable/6.6: [80aec5a855106c668b5978c48e789f010198b832]

CVE-2024-57834: media: vidtv: Fix a null-ptr-deref in vidtv_mux_stop_thread

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [52d3512f9a7a52ef92864679b1e8e8aa16202c6a]
stable/5.15: [59a707ad952eb2ea8d59457d662b6f4138f17b08]
stable/6.1: [86307e443c5844f38e1b98e2c51a4195c55576cd]
stable/6.12: [95432a37778c9c5dd105b7b9f19e9695c9e166cf]
stable/6.13: [904a8323cc8afa7eb9ce3e67303a2b3f2f787306]
stable/6.6: [2c5601b99d79d196fe4a37159e3dfb38e778ea18]

CVE-2024-57973: rdma/cxgb4: Prevent potential integer overflow on 32bit

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [d64148a10a85952352de6091ceed99fb9ce2d3ee]
stable/5.15: [e53ca458f543aa352d09b484550de173cb9085c2]
stable/5.4: [2b759f78b83221f4a1cae3aeb20b500e375f3ee6]
stable/6.1: [4422f452d028850b9cc4fd8f1cf45a8ff91855eb]
stable/6.12: [dd352107f22bfbecbbf3b74bde14f3f932296309]
stable/6.13: [aeb814484387811b3579d5c78ad4eb301e3bf1c8]
stable/6.6: [de8d88b68d0cfd41152a7a63d6aec0ed3e1b837a]

CVE-2024-57977: memcg: fix soft lockup in the OOM process

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [110399858194c71f11afefad6e7be9e3876b284f]
stable/5.15: [a9042dbc1ed4bf25a5f5c699d10c3d676abf8ca2]
stable/5.4: [72f2c0b7c152c2983ed51d48c3272cab4f34d965]
stable/6.1: [0a09d56e1682c951046bf15542b3e9553046c9f6]
stable/6.12: [c3a3741db8c1202aa959c77df3a4c361612d1eb1]
stable/6.13: [46576834291869457d4772bb7df72d7c2bb3d57f]
stable/6.6: [972486d37169fe85035e81b8c5dff21f70df1173]

CVE-2024-57978: media: imx-jpeg: Fix potential error pointer
dereference in detach_pm()

stable/5.15 was fixed.

Fixed status
stable/5.15: [a32ba399a030853f2db45a90ba5474fdd3494aad]
stable/6.1: [fde89fe11b44500bfcb2d405825b69a5df805d19]
stable/6.12: [6e601a64f7777e2f78c02db1a8b5ba3b7c5e9e31]
stable/6.13: [f0b8535a7885ed4fd0b11625addb5476cae0f845]
stable/6.6: [1b2af918bb714937a8be6cb637f528585461cd98]

CVE-2024-57979: pps: Fix a use-after-free

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [1a7735ab2cb9747518a7416fb5929e85442dec62]
stable/5.15: [c4041b6b0a7a3def8cf3f3d6120ff337bc4c40f7]
stable/5.4: [785c78ed0d39d1717cca3ef931d3e51337b5e90e]
stable/6.1: [91932db1d96b2952299ce30c1c693d834d10ace6]
stable/6.12: [7e5ee3281dc09014367f5112b6d566ba36ea2d49]
stable/6.13: [85241f7de216f8298f6e48540ea13d7dcd100870]
stable/6.6: [cd3bbcb6b3a7caa5ce67de76723b6d8531fb7f64]

CVE-2024-57980: media: uvcvideo: Fix double free in error path

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [87522ef165e5b6de8ef98cc318f3335166a1512c]
stable/5.15: [3ba8884a56a3eb97c22f0ce0e4dd410d4ca4c277]
stable/5.4: [d6e5ba2516c5bef87c1fcb8189b6f3cad7c64b2d]
stable/6.1: [9232719ac9ce4d5c213cebda23d72aec3e1c4c0d]
stable/6.12: [d1f8e69eec91d5a75ef079778a5d0151db2a7f22]
stable/6.13: [d8e63dd7b6683969d3d47c7b8e9635f96d554ad4]
stable/6.6: [6c36dcd662ec5276782838660f8533a7cb26be49]

CVE-2024-57981: usb: xhci: Fix NULL pointer dereference on certain
command aborts

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [b44253956407046e5907d4d72c8fa5b93ae94485]
stable/5.15: [cf30300a216a4f8dce94e11781a866a09d4b50d4]
stable/5.4: [fd8bfaeba4a85b14427899adec0efb3954300653]
stable/6.1: [4ff18870af793ce2034a6ad746e91d0a3d985b88]
stable/6.12: [ae069cd2ba09a2bd6a87a68c59ef0b7ea39cd641]
stable/6.13: [0ce5c0dac768be14afe2426101b568a0f66bfc4d]
stable/6.6: [b649f0d5bc256f691c7d234c3986685d54053de1]

CVE-2024-57986: HID: core: Fix assumption that Resolution Multipliers
must be in Logical Collections

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [05dd7d10675b540b8b7b31035c0a8abb6e6f3b88]
stable/5.15: [a32ea3f982b389ea43a41ce77b6fb70d74006d9b]
stable/5.4: [3a002e4029230d9a6be89f869b2328b258612f5c]
stable/6.1: [bebf542e8d7c44a18a95f306b1b5dc160c823506]
stable/6.12: [ebaeca33d32c8bdb705a8c88267737a456f354b1]
stable/6.13: [a5498f1f864ea26f4c613c77f54409c776a95a90]
stable/6.6: [ed3d3883476423f337aac0f22c521819b3f1e970]

CVE-2024-58001: ocfs2: handle a symlink read error correctly

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [afa8003f8db62e46c4b171cbf4cec2824148b4f7]
stable/5.15: [8aee4184c5b79e486598c15aa80687c77f6f6e6e]
stable/5.4: [cd3e22b206189cbb4a94229002141e1529f83746]
stable/6.1: [6e143eb4ab83c24e7ad3e3d8e7daa241d9c38377]
stable/6.12: [52a326f93ceb9348264fddf7bab6e345db69e08c]
stable/6.13: [5e3b3ec7c3cb5ba5629a766e4f0926db72cf0a1f]
stable/6.6: [b6833b38984d1e9f20dd80f9ec9050c10d687f30]

CVE-2024-58002: media: uvcvideo: Remove dangling pointers

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [653993f46861f2971e95e9a0e36a34b49dec542c]
stable/5.15: [117f7a2975baa4b7d702d3f4830d5a4ebd0c6d50]
stable/5.4: [2a29413ace64627e178fd422dd8a5d95219a2c0b]
stable/6.1: [ac18d781466252cd35a3e311e0a4b264260fd927]
stable/6.12: [438bda062b2c40ddd7df23b932e29ffe0a448cac]
stable/6.13: [9edc7d25f7e49c33a1ce7a5ffadea2222065516c]
stable/6.6: [4dbaa738c583a0e947803c69e8996e88cf98d971]

CVE-2024-58005: tpm: Change to kvalloc() in eventlog/acpi.c

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [a676c0401de59548a5bc1b7aaf98f556ae8ea6db]
stable/5.15: [0621d2599d6e02d05c85d6bbd58eaea2f15b3503]
stable/6.1: [77779d1258a287f2c5c2c6aeae203e0996209c77]
stable/6.12: [422d7f4e8d817be467986589c7968d3ea402f7da]
stable/6.13: [4c8bfe643bbd00b04ee8f9545ef33bf6a68c38db]
stable/6.6: [50365a6304a57266e8f4d3078060743c3b7a1e0d]

CVE-2024-58007: soc: qcom: socinfo: Avoid out of bounds read of serial number

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [2495c6598731b6d7f565140f2bd63ef4bc36ce7d]
stable/5.15: [2d09d3c9afa2fc422ac3df7c9b8534f350ee19dd]
stable/5.4: [7445fa05317534bbd8b373c0eff8319187916030]
stable/6.1: [9c88b3a3fae4d60641c3a45be66269d00eff33cd]
stable/6.12: [407c928305c1a37232a63811c400ef616f85ccbc]
stable/6.13: [0a92feddae0634a0b87c04b19d343f6af97af700]
stable/6.6: [47470acd719d45c4c8c418c07962f74cc995652b]

CVE-2024-58009: Bluetooth: L2CAP: handle NULL sock pointer in l2cap_sock_alloc

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [8e605f580a97530e5a3583beea458a3fa4cbefbd]
stable/5.15: [cf601a24120c674cd7c907ea695f92617af6abd0]
stable/5.4: [a9a7672fc1a0fe18502493936ccb06413ab89ea6]
stable/6.1: [297ce7f544aa675b0d136d788cad0710cdfb0785]
stable/6.12: [691218a50c3139f7f57ffa79fb89d932eda9571e]
stable/6.13: [49c0d55d59662430f1829ae85b969619573d0fa1]
stable/6.6: [245d48c1ba3e7a1779c2f4cbc6f581ddc8a78e22]

CVE-2024-58010: binfmt_flat: Fix integer overflow bug on 32 bit systems

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [6fb98e0576ea155267e206286413dcb3a3d55c12]
stable/5.15: [bc8ca18b8ef4648532c001bd6c8151143b569275]
stable/5.4: [0b6be54d7386b7addbf9e5947366f94aad046938]
stable/6.1: [95506c7f33452450346fbe2975c1359100f854ca]
stable/6.12: [a009378af674b808efcca1e2e67916e79ce866b3]
stable/6.13: [8e8cd712bb06a507b26efd2a56155076aa454345]
stable/6.6: [d17ca8f2dfcf423c439859995910a20e38b86f00]

CVE-2024-58014: wifi: brcmsmac: add gain range check to
wlc_phy_iqcal_gainparams_nphy()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [13ef16c4fe384b1e70277bbe1d87934ee6c81e12]
stable/5.15: [d280a12e9b87819a8a209639d600b48a2d6d65dc]
stable/5.4: [0a457223cb2b9ca46bae7de387d0f4c093b0220d]
stable/6.1: [ada9df08b3ef683507e75b92f522fb659260147f]
stable/6.12: [c27ce584d274f6ad3cba2294497de824a3c66646]
stable/6.13: [6f6e293246dc1f5b2b6b3d0f2d757598489cda79]
stable/6.6: [093286c33409bf38896f2dab0c0bb6ca388afb33]

CVE-2024-58016: safesetid: check size of policy writes

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [976284b94f2021df09829e37a367e19b84d9e5f3]
stable/5.15: [ecf6a4a558097920447a6fb84dfdb279e2ac749a]
stable/6.1: [a0dec65f88c8d9290dfa1d2ca1e897abe54c5881]
stable/6.12: [36b385d0f2b4c0bf41d491e19075ecd990d2bf94]
stable/6.13: [c71d35676d46090c891b6419f253fb92a1a9f4eb]
stable/6.6: [96fae5bd1589731592d30b3953a90a77ef3928a6]

CVE-2024-58017: printk: Fix signed integer overflow when defining
LOG_BUF_LEN_MAX

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [dfb7b179741ee09506dc7719d92f9e1cea01f10e]
stable/5.15: [bb8ff054e19fe27f4e5eaac1b05e462894cfe9b1]
stable/5.4: [54c14022fa2ba427dc543455c2cf9225903a7174]
stable/6.1: [9a6d43844de2479a3ff8d674c3e2a16172e01598]
stable/6.12: [404e5fd918a0b14abec06c7eca128f04c9b98e41]
stable/6.13: [4a2c4e7265b8eed83c25d86d702cea06493cab18]
stable/6.6: [4acf6bab775dbd22a9a799030a808a7305e01d63]

CVE-2024-58020: HID: multitouch: Add NULL check in mt_input_configured

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [a6bfd3856e9f3da083f177753c623d58ba935e0a]
stable/5.15: [2052b44cd0a62b6fdbe3371e5ba6029c56c400ca]
stable/5.4: [a04d96ef67a42165f93194eef22a270acba4b74c]
stable/6.1: [4e7113f591163d99adc7cbcd7295030c8c5d3fc7]
stable/6.12: [aa879ef6d3acf96fa2c7122d0632061d4ea58d48]
stable/6.13: [97c09cc2e72769edb6994b531edcfa313b96bade]
stable/6.6: [62f8bf06262b6fc55c58f4c5256140f1382f3b01]

CVE-2024-58034: memory: tegra20-emc: fix an OF node reference bug in
tegra_emc_find_node_by_ram_code()

stable/5.15 was fixed.

Fixed status
stable/5.15: [c3def10c610ae046aaa61d00528e7bd15e4ad8d3]
stable/6.1: [e9d07e91de140679eeaf275f47ad154467cb9e05]
stable/6.12: [3b02273446e23961d910b50cc12528faec649fb2]
stable/6.13: [755e44538c190c31de9090d8e8821d228fcfd416]
stable/6.6: [c144423cb07e4e227a8572d5742ca2b36ada770d]

CVE-2024-58051: ipmi: ipmb: Add check devm_kasprintf() returned value

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [caac520350546e736894d14e051b64a9edb3600c]
stable/5.15: [eb288ab33fd87579789cb331209ff09e988ff4f7]
stable/5.4: [1a8a17c5ce9cb5a82797602bff9819ac732d2ff5]
stable/6.1: [312a6445036d692bc5665307eeafa4508c33c4b5]
stable/6.12: [e529fbcf1f35f5fc3c839df7f06c3e3d02579715]
stable/6.13: [a63284d415d4d114abd8be6e66a9558f3ca0702d]
stable/6.6: [4c9caf86d04dcb10e9fd8cd9db8eb79b5bfcc4d8]

CVE-2024-58052: drm/amdgpu: Fix potential NULL pointer dereference in
atomctrl_get_smc_sclk_range_table

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [c47066ed7c8f3b320ef87fa6217a2b8b24e127cc]
stable/5.15: [2396bc91935c6da0588ce07850d07897974bd350]
stable/5.4: [a713ba7167c2d74c477dd7764dbbdbe3199f17f4]
stable/6.1: [ae522ad211ec4b72eaf742b25f24b0a406afcba1]
stable/6.12: [0b97cd8a61b2b40fd73cf92a4bb2256462d22adb]
stable/6.13: [396350adf0e5ad4bf05f01e4d79bfb82f0f6c41a]
stable/6.6: [6a30634a2e0f1dd3c6b39fd0f114c32893a9907a]

CVE-2024-58055: usb: gadget: f_tcm: Don't free command immediately

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [38229c35a6d7875697dfb293356407330cfcd23e]
stable/5.15: [bbb7f49839b57d66ccaf7b5752d9b63d3031dd0a]
stable/5.4: [7cb72dc08ed8da60fd6d1f6adf13bf0e6ee0f694]
stable/6.1: [f0c33e7d387ccbb6870e73a43c558fefede06614]
stable/6.12: [929b69810eec132b284ffd19047a85d961df9e4d]
stable/6.13: [e6693595bd1b55af62d057a4136a89d5c2ddf0e9]
stable/6.6: [16907219ad6763f401700e1b57b2da4f3e07f047]

CVE-2024-58058: ubifs: skip dumping tnc tree when zroot is null

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [6211c11fc20424bbc6d79c835c7c212b553ae898]
stable/5.15: [1787cd67bb94b106555ffe64f887f6aa24b47010]
stable/5.4: [428aff8f7cfb0d9a8854477648022cef96bcab28]
stable/6.1: [e01b55f261ccc96e347eba4931e4429d080d879d]
stable/6.12: [77e5266e3d3faa6bdcf20d9c68a8972f6aa06522]
stable/6.13: [2a987950df825d0144370e700dc5fb337684ffba]
stable/6.6: [40e25a3c0063935763717877bb2a814c081509ff]

CVE-2024-58063: wifi: rtlwifi: fix memory leaks and invalid access at
probe error path

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [455e0f40b5352186a9095f2135d5c89255e7c39a]
stable/5.15: [b96371339fd9cac90f5ee4ac17ee5c4cbbdfa6f7]
stable/5.4: [85b67b4c4a0f8a6fb20cf4ef7684ff2b0cf559df]
stable/6.1: [ee0b0d7baa8a6d42c7988f6e50c8f164cdf3fa47]
stable/6.12: [32acebca0a51f5e372536bfdc0d7d332ab749013]
stable/6.13: [6b76bab5c257463302c9e97f5d84d524457468eb]
stable/6.6: [624cea89a0865a2bc3e00182a6b0f954a94328b4]

CVE-2024-58069: rtc: pcf85063: fix potential OOB write in PCF85063 NVMEM read

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [6f2a8ca9a0a38589f52a7f0fb9425b9ba987ae7c]
stable/5.15: [e5536677da803ed54a29a446515c28dce7d3d574]
stable/5.4: [21cd59fcb9952eb7505da2bdfc1eb9c619df3ff4]
stable/6.1: [c72b7a474d3f445bf0c5bcf8ffed332c78eb28a1]
stable/6.12: [e5e06455760f2995b16a176033909347929d1128]
stable/6.13: [517aedb365f2c94e2d7e0b908ac7127df76203a1]
stable/6.6: [9adefa7b9559d0f21034a5d5ec1b55840c9348b9]

CVE-2024-58071: team: prevent adding a device which is already a team
device lower

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [62ff1615815d565448c37cb8a7a2a076492ec471]
stable/5.15: [bd099a2fa9be983ba0e90a57a59484fe9d520ba8]
stable/5.4: [0a7794b9ca78c8e7d001c583bf05736169de3f20]
stable/6.1: [adff6ac889e16d97abd1e4543f533221127e978a]
stable/6.12: [1bb06f919fa5bec77ad9b6002525c3dcc5c1fd6c]
stable/6.13: [d9bce1310c0e2a55888e3e08c9f69d8377b3a377]
stable/6.6: [184a564e6000b41582f160a5be9a9b5aabe22ac1]

CVE-2024-58072: wifi: rtlwifi: remove unused check_buddy_priv

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [1b9cbd8a9ae68b32099fbb03b2d5ffa0c5e0dcc9]
stable/5.15: [8e2fcc68fbaab3ad9f5671fee2be0956134b740a]
stable/5.4: [f801e754efa21bd61b3cc15ec7565696165b272f]
stable/6.1: [1e39b0486cdb496cdfba3bc89886150e46acf6f4]
stable/6.12: [543e3e9f2e9e47ded774c74e680f28a0ca362aee]
stable/6.13: [006e803af7408c3fc815b0654fc5ab43d34f0154]
stable/6.6: [465d01ef6962b82b1f0ad1f3e58b398dbd35c1c1]

CVE-2024-58076: clk: qcom: gcc-sm6350: Add missing parent_map for two clocks

stable/5.15 was fixed.

Fixed status
stable/5.15: [175af15551ed5aa6af16ff97aff75cfffb42da21]
stable/6.1: [39336edd14a59dc086fb19957655e0f340bb28e8]
stable/6.12: [b6fe13566bf5676b1e3b72d2a06d875733e93ee6]
stable/6.13: [3e567032233a240b903dc11c9f18eeb3faa10ffa]
stable/6.6: [08b77ed7cfaac62bba51ac7a0487409ec9fcbc84]

CVE-2024-58079: media: uvcvideo: Fix crash during unbind if gpio unit is in use

stable/5.15 was fixed.

Fixed status
stable/5.15: [0fdd7cc593385e46e92e180b71e264fc9c195298]
stable/6.1: [3c00e94d00ca079bef7906d6f39d1091bccfedd3]
stable/6.12: [d2eac8b14ac690aa73052aa6d4ba69005715367e]
stable/6.13: [5d2e65cbe53d0141ed095cf31c2dcf3d8668c11d]
stable/6.6: [0b5e0445bc8384c18bd35cb9fe87f6258c6271d9]

CVE-2024-58083: KVM: Explicitly verify target vCPU is online in kvm_get_vcpu()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [09d50ccf0b2d739db4a485b08afe7520a4402a63]
stable/5.15: [7c4899239d0f70f88ac42665b3da51678d122480]
stable/5.4: [5cce2ed69b00e022b5cdf0c49c82986abd2941a8]
stable/6.1: [d817e510662fd1c9797952408d94806f97a5fffd]
stable/6.12: [f2f805ada63b536bc192458a7098388286568ad4]
stable/6.13: [ca8da90ed1432ff3d000de4f1e2275d4e7d21b96]
stable/6.6: [125da53b3c0c9d7f58353aea0076e9efd6498ba7]

CVE-2024-58085: tomoyo: don't emit warning in tomoyo_write_control()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [f6b37b3e12de638753bce79a2858070b9c4a4ad3]
stable/5.15: [b2bd5857a0d6973ebbcb4d9831ddcaebbd257be1]
stable/5.4: [c67efabddc73171c7771d3ffe4ffa1e503ee533e]
stable/6.1: [a01c200fa7eb59da4d2dbbb48b61f4a0d196c09f]
stable/6.12: [c9382f380e8d09209b8e5c0def0545852168be25]
stable/6.13: [414705c0303350d139b1dc18f329fe47dfb642dd]
stable/6.6: [fe1c021eb03dae0dc9dce55e81f77a60e419a27a]

CVE-2024-58086: drm/v3d: Stop active perfmon if it is being destroyed

stable/5.15 was fixed.

Fixed status
stable/5.15: [22e19c8c5f6b709f4ae40227392a30d57bac187d]
stable/6.1: [95036d4c01167568166108d42c2b0e9f8dbd7d2b]
stable/6.12: [1c5673a2c8926adbb61f340c779b28e18188a8cd]
stable/6.13: [f8805b12f477bd964e2820a87921c7b58cc2dee3]
stable/6.6: [eb0e0eca0eab93f310c6c37b8564049366704691]

CVE-2025-21647: sched: sch_cake: add bounds checks to host bulk flow
fairness counts

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [b1a1743aaa4906c41c426eda97e2e2586f79246d]
stable/5.15: [bb0245fa72b783cb23a9949c5048781341e91423]
stable/5.4: [44fe1efb4961c1a5ccab16bb579dfc6b308ad58b]
stable/6.1: [a777e06dfc72bed73c05dcb437d7c27ad5f90f3f]
stable/6.12: [91bb18950b88f955838ec0c1d97f74d135756dc7]
stable/6.6: [27202e2e8721c3b23831563c36ed5ac7818641ba]

CVE-2025-21684: gpio: xilinx: Convert gpio_lock to raw spinlock

stable/5.15 was fixed.

Fixed status
stable/5.15: [d25041d4a3b2af64c888cf762362b2528ba59294]
stable/6.1: [f0ed2d0abc021f56fa27dc6d0770535c1851a43b]
stable/6.12: [9c035105c5537d2ecad6b9415e9417a1ffbd0a62]
stable/6.6: [b0111650ee596219bb5defa0ce1a1308e6e77ccf]

CVE-2025-21700: net: sched: Disallow replacing of child qdisc from one
parent to another

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [fe18c21d67dc7d1bcce1bba56515b1b0306db19b]
stable/5.15: [38646749d6e12f9d80a08d21ca39f0beca20230d]
stable/5.4: [cd796e269123e1994bfc4e99dd76680ba0946a97]
stable/6.1: [deda09c0543a66fa51554abc5ffd723d99b191bf]
stable/6.12: [73c7e1d6898ccbeee126194dcc05f58b8a795e70]
stable/6.13: [46c59ec33ec98aba20c15117630cae43a01404cc]
stable/6.6: [7e2bd8c13b07e29a247c023c7444df23f9a79fd8]

CVE-2025-21701: net: avoid race between device unregistration and ethnl ops

stable/5.15 was fixed.

Fixed status
stable/5.15: [26bc6076798aa4dc83a07d0a386f9e57c94e8517]
stable/6.1: [b1cb37a31a482df3dd35a6ac166282dac47664f4]
stable/6.12: [b382ab9b885cbb665e0e70a727f101c981b4edf3]
stable/6.13: [4dc880245f9b529fa8f476b5553c799d2848b47b]
stable/6.6: [2f29127e94ae9fdc7497331003d6860e9551cdf3]

CVE-2025-21702: pfifo_tail_enqueue: Drop new packet when sch->limit == 0

stable/5.10, stable/5.15, stable/5.4, stable/6.6 were fixed.

Fixed status
stable/5.10: [7a9723ec27aff5674f1fd4934608937f1d650980]
stable/5.15: [a56a6e8589a9b98d8171611fbcc1e45a15fd2455]
stable/5.4: [78285b53266d6d51fa4ff504a23df03852eba84e]
stable/6.1: [020ecb76812a0526f4130ab5aeb6dc7c773e7ab9]
stable/6.12: [e40cb34b7f247fe2e366fd192700d1b4f38196ca]
stable/6.13: [b6a079c3b6f95378f26e2aeda520cb3176f7067b]
stable/6.6: [79a955ea4a2e5ddf4a36328959de0de496419888]

CVE-2025-21703: netem: Update sch->q.qlen before qdisc_tree_reduce_backlog()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [7f31d74fcc556a9166b1bb20515542de7bb939d1]
stable/5.15: [98a2c685293aae122f688cde11d9334dddc5d207]
stable/5.4: [e395fec75ac2dbffc99b4bce57b7f1f3c5449f2c]
stable/6.1: [7b79ca9a1de6a428d486ff52fb3d602321c08f55]
stable/6.12: [6312555249082d6d8cc5321ff725df05482d8b83]
stable/6.13: [839ecc583fa00fab785fde1c85a326743657fd32]
stable/6.6: [1f8e3f4a4b8b90ad274dfbc66fc7d55cb582f4d5]

CVE-2025-21704: usb: cdc-acm: Check control transfer buffer size before access

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [90dd2f1b7342b9a671a5ea4160f408037b92b118]
stable/5.15: [871619c2b78fdfe05afb4e8ba548678687beb812]
stable/5.4: [a4e1ae5c0533964170197e4fb4f33bc8c1db5cd2]
stable/6.1: [7828e9363ac4d23b02419bf2a45b9f1d9fb35646]
stable/6.12: [f64079bef6a8a7823358c3f352ea29a617844636]
stable/6.13: [383d516a0ebc8641372b521c8cb717f0f1834831]
stable/6.6: [6abb510251e75f875797d8983a830e6731fa281c]

CVE-2025-21707: mptcp: consolidate suboption status

stable/5.15 was fixed.

Fixed status
stable/5.15: [3a7fda57b0f91f7ea34476b165f91a92feb17c96]
stable/6.1: [3b5332d416d151a15742d1b16e7319368e3cc5c6]
stable/6.12: [6169e942370b4b6f9442d35c51519bf6c346843b]
stable/6.13: [ba0518f9e8688cd4fcb569e8df2a74874b4f3894]
stable/6.6: [7f6c72b8ef8130760710e337dc8fbe7263954884]

CVE-2025-21708: net: usb: rtl8150: enable basic endpoint checking

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [8f78a2b9ed4cb1e62c60d0a8905d9a37bc18c20d]
stable/5.15: [d42168f109f96b5d18812a789086015a435ee667]
stable/5.4: [431be4f78220d34ce21d67a6b843b7ca81bd82e9]
stable/6.1: [e10b392a7495a5dbbb25247e2c17d380d9899263]
stable/6.12: [f395b7efcee8df54309eb2d4a624ef13f5d88b66]
stable/6.13: [c843515ad2be7349dd6b60e5fd299d0da0b8458b]
stable/6.6: [3c706829ceb6e347bd4ddfd17f1d3048acd69da2]

CVE-2025-21711: net/rose: prevent integer overflows in rose_setsockopt()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [4bdd449977e2364a53d0b2a5427e71beb1cd702d]
stable/5.15: [b8583b54455cbec2fc038fa32b6700890b369815]
stable/6.1: [9bdee49ad6bbd26ab5e13cc6731e54fb1b6c1dca]
stable/6.12: [d08f4074f9c69f7e95502587eb1b258a965ba7f0]
stable/6.13: [e5338930a29d0ab2a5af402f5f664aeba0d1a676]
stable/6.6: [352daa50946c3bbb662432e8daf54d6760796589]

CVE-2025-21715: net: davicom: fix UAF in dm9000_drv_remove

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [a53cb72043443ac787ec0b5fa17bb3f8ff3d462b]
stable/5.15: [7d7d201eb3b766abe590ac0dda7a508b7db3e357]
stable/5.4: [db79e982c5f9e39ab710cbce55b05f2f5e6f1ca9]
stable/6.1: [c94ab07edc2843e2f3d46dbd82e5c681503aaadf]
stable/6.12: [5a54367a7c2378c65aaa4d3cfd952f26adef7aa7]
stable/6.13: [2013c95df6752d9c88221d0f0f37b6f197969390]
stable/6.6: [c411f9a5fdc9158e8f7c57eac961d3df3eb4d8ca]

CVE-2025-21718: net: rose: fix timer races against user threads

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [0d5bca3be27bfcf8f980f2fed49b6cbb7dafe4a1]
stable/5.15: [1409b45d4690308c502c6caf22f01c3c205b4717]
stable/5.4: [52f5aff33ca73b2c2fa93f40a3de308012e63cf4]
stable/6.1: [f55c88e3ca5939a6a8a329024aed8f3d98eea8e4]
stable/6.12: [1992fb261c90e9827cf5dc3115d89bb0853252c9]
stable/6.13: [58051a284ac18a3bb815aac6289a679903ddcc3f]
stable/6.6: [51c128ba038cf1b79d605cbee325919b45ab95a5]

CVE-2025-21719: ipmr: do not call mr_mfc_uses_dev() for unres entries

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [53df27fd38f84bd3cd6b004eb4ff3c4903114f1d]
stable/5.15: [547ef7e8cbb98f966c8719a3e15d4e078aaa9b47]
stable/5.4: [71a0fcb68c0a5f3ec912b540cd5d72148e6ee5f1]
stable/6.1: [57177c5f47a8da852f8d76cf6945cf803f8bb9e5]
stable/6.12: [a099834a51ccf9bbba3de86a251b3433539abfde]
stable/6.13: [26bb7d991f04eeef47dfad23e533834995c26f7a]
stable/6.6: [b379b3162ff55a70464c6a934ae9bf0497478a62]

CVE-2025-21721: nilfs2: handle errors that nilfs_prepare_chunk() may return

stable/5.10, stable/5.15, stable/5.4, stable/6.1 were fixed.

Fixed status
stable/5.10: [f70bd2d8ca454e0ed78970f72147ca321dbaa015]
stable/5.15: [607dc724b162f4452dc768865e578c1a509a1c8c]
stable/5.4: [b38c6c260c2415c7f0968871305e7a093daabb4c]
stable/6.1: [1ee2d454baa361d2964e3e2f2cca9ee3f769d93c]
stable/6.12: [eddd3176b8c4c83a46ab974574cda7c3dfe09388]
stable/6.13: [481136234dfe96c7f92770829bec6111c7c5f5dd]
stable/6.6: [7891ac3b0a5c56f7148af507306308ab841cdc31]

CVE-2025-21722: nilfs2: do not force clear folio if buffer is referenced

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [4d042811c72f71be7c14726db2c72b67025a7cb5]
stable/5.15: [f51ff43c4c5a6c8e72d0aca89e4d5e688938412f]
stable/5.4: [7d0544bacc11d6aa26ecd7debf9353193c7a3328]
stable/6.1: [19296737024cd220a1d6590bf4c092bca8c99497]
stable/6.12: [1098bb8d52419d262a3358d099a1598a920b730f]
stable/6.13: [557ccf5e49f1fb848a29698585bcab2e50a597ef]

CVE-2025-21726: padata: avoid UAF for reorder_work

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [f4f1b1169fc3694f9bc3e28c6c68dbbf4cc744c0]
stable/5.15: [4c6209efea2208597dbd3e52dc87a0d1a8f2dbe1]
stable/6.1: [7000507bb0d2ceb545c0a690e0c707c897d102c2]
stable/6.12: [8ca38d0ca8c3d30dd18d311f1a7ec5cb56972cac]
stable/6.13: [a54091c24220a4cd847d5b4f36d678edacddbaf0]
stable/6.6: [6f45ef616775b0ce7889b0f6077fc8d681ab30bc]

CVE-2025-21727: padata: fix UAF in padata_reorder

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [f78170bee51469734b1a306a74fc5f777bb22ba6]
stable/5.15: [f3e0b9f790f8e8065d59e67b565a83154d9f3079]
stable/6.1: [0ae2f332cfd2d74cf3ce344ec9938cf3e29c3ccd]
stable/6.12: [573ac9c70bf7885dc85d82fa44550581bfc3b738]
stable/6.13: [80231f069240d52e98b6a317456c67b2eafd0781]
stable/6.6: [bbccae982e9fa1d7abcb23a5ec81cb0ec883f7de]

CVE-2025-21728: bpf: Send signals asynchronously if !preemptible

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [ce51eab2070e295d298f42a2f1db269cd1b56d55]
stable/5.15: [e306eaaa3d78b462db5f5b11e0171f9d2b6ca3f4]
stable/5.4: [feba1308bc5e8e04cee751d39fae8a9b407a9034]
stable/6.1: [be42a09fe898635b0093c0c8dac1bfabe225c240]
stable/6.12: [78b97783496b454435639937db3303e900a24d3f]
stable/6.13: [092fc76b7ab4163e008f9cde596a58dad2108260]
stable/6.6: [eeef8e65041a031bd8a747a392c14b76a123a12c]

CVE-2025-21731: nbd: don't allow reconnect after disconnect

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [6bef6222a3f6c7adb6396f77f25a3579d821b09a]
stable/5.15: [e3be8862d73cac833e0fb7602636c19c6cb94b11]
stable/5.4: [e70a578487a47d7cf058904141e586684d1c3381]
stable/6.1: [e7343fa33751cb07c1c56b666bf37cfca357130e]
stable/6.12: [a8ee6ecde2b7bfb58c8a3afe8a9d2b848f580739]
stable/6.13: [9793bd5ae4bdbdb2dde401a3cab94a6bfd05e302]
stable/6.6: [d208d2c52b652913b5eefc8ca434b0d6b757f68f]

CVE-2025-21735: NFC: nci: Add bounds checking in nci_hci_create_pipe()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [674e17c5933779a8bf5c15d596fdfcb5ccdebbc2]
stable/5.15: [10b3f947b609713e04022101f492d288a014ddfa]
stable/5.4: [bd249109d266f1d52548c46634a15b71656e0d44]
stable/6.1: [d5a461c315e5ff92657f84d8ba50caa5abf5c22a]
stable/6.12: [2ae4bade5a64d126bd18eb66bd419005c5550218]
stable/6.13: [59c7ed20217c0939862fbf8145bc49d5b3a13f4f]
stable/6.6: [172cdfc3a5ea20289c58fb73dadc6fd4a8784a4e]

CVE-2025-21736: nilfs2: fix possible int overflows in nilfs_fiemap()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [58b1c6881081f5ddfb9a14dc241a74732c0f855c]
stable/5.15: [8f41df5fd4c11d26e929a85f7239799641f92da7]
stable/5.4: [7649937987fed51ed09985da4019d50189fc534e]
stable/6.1: [f3d80f34f58445355fa27b9579a449fb186aa64e]
stable/6.12: [b9495a9109abc31d3170f7aad7d48aa64610a1a2]
stable/6.13: [250423300b4b0335918be187ef3cade248c06e6a]
stable/6.6: [f2bd0f1ab47822fe5bd699c8458b896c4b2edea1]

CVE-2025-21744: wifi: brcmfmac: fix NULL pointer dereference in
brcmf_txfinalize()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [59ff4fa653ff6db07c61152516ffba79c2a74bda]
stable/5.15: [61541d9b5a23df33934fcc620a3a81f246b1b240]
stable/5.4: [2326e19190e176fd72bb542b837a9d2b7fcb8693]
stable/6.1: [4e51d6d093e763348916e69d06d87e0a5593661b]
stable/6.12: [fbbfef2a5b858eab55741a58b2ac9a0cc8d53c58]
stable/6.13: [a2beefc4fa49ebc22e664dc6b39dbd054f8488f9]
stable/6.6: [3877fc67bd3d5566cc12763bce39710ceb74a97d]

CVE-2025-21745: blk-cgroup: Fix class @block_class's subsystem refcount leakage

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [ffb494f1e7a047bd7a41b13796fcfb08fe5beafb]
stable/5.15: [38287f779b34dfe959b4b681e909f2d3d52b88be]
stable/6.1: [431b6ef2714be4d5babb802114987541a88b43b0]
stable/6.12: [2ce09aabe009453d641a2ceb79e6461a2d4f3876]
stable/6.13: [67c7f213e052b1aa6caba4a7e25e303bc6997126]
stable/6.6: [993121481b5a87829f1e8163f47158b72679f309]

CVE-2025-21748: ksmbd: fix integer overflows on 32 bit systems

stable/5.15 was fixed.

Fixed status
stable/5.15: [f3b9fb2764591d792d160f375851013665a9e820]
stable/6.1: [760568c1f62ea874e8fb492f9cfa4f47b4b8391e]
stable/6.12: [b4b902737746c490258de5cb55cab39e79927a67]
stable/6.13: [ecb9947fa7c99a77b04d43404c6988a0d326e4a0]
stable/6.6: [82f59d64e6297f270311b16b5dcf65be406d1ea3]

CVE-2025-21749: net: rose: lock the socket in rose_bind()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [ed00c5f907d08a647b8bf987514ad8c6b17971a7]
stable/5.15: [d308661a0f4e7c8e86dfc7074a55ee5894c61538]
stable/5.4: [b8bf5c3fb778bbb1f3ff7d98ec577c969f687513]
stable/6.1: [667f61b3498df751c8b3f0be1637e7226cbe3ed0]
stable/6.12: [970cd2ed26cdab2b0f15b6d90d7eaa36538244a5]
stable/6.13: [4c04b0ab3a647e76d0e752b013de8e404abafc63]
stable/6.6: [e0384efd45f615603e6869205b72040c209e69cc]

CVE-2025-21753: btrfs: fix use-after-free when attempting to join an
aborted transaction

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [c7a53757717e68af94a56929d57f1e6daff220ec]
stable/5.15: [7e954b6bb95d67ae4d1a20e9cfd83c182cf929bc]
stable/5.4: [cee55b1219568c80bf0d5dc55066e4a859baf753]
stable/6.1: [6ba4663ada6c6315af23a6669d386146634808ec]
stable/6.12: [86d71a026a7f63da905db9add845c8ee88801eca]
stable/6.13: [ce628048390dad80320d5a1f74de6ca1e1be91e7]
stable/6.6: [8f5cff471039caa2b088060c074c2bf2081bcb01]

CVE-2025-21756: vsock: Keep the binding until socket destruction

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e7754d564579a5db9c5c9f74228df5d6dd6f1173]
stable/5.15: [e48fcb403c2d0e574c19683f09399ab4cf67809c]
stable/6.1: [42b33381e5e1f2b967dc4fb4221ddb9aaf10d197]
stable/6.12: [645ce25aa0e67895b11d89f27bb86c9d444c40f8]
stable/6.13: [b1afd40321f1c243cffbcf40ea7ca41aca87fa5e]
stable/6.6: [3f43540166128951cc1be7ab1ce6b7f05c670d8b]

CVE-2025-21758: ipv6: mcast: add RCU protection to mld_newpack()

stable/5.15 was fixed.

Fixed status
stable/5.15: [29fa42197f26a97cde29fa8c40beddf44ea5c8f3]
stable/6.1: [e8af3632a7f2da83e27b083f787bced1faba00b1]
stable/6.12: [25195f9d5ffcc8079ad743a50c0409dbdc48d98a]
stable/6.13: [d60d493b0e65647e0335e6a7c4547abcea7df8e9]
stable/6.6: [1b91c597b0214b1b462eb627ec02658c944623f2]

CVE-2025-21760: ndisc: extend RCU protection in ndisc_send_skb()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [4d576202b90b1b95a7c428a80b536f91b8201bcc]
stable/5.15: [e24d225e4cb8cf108bde00b76594499b98f0a74d]
stable/5.4: [10a1f3fece2f0d23a3a618b72b2b4e6f408ef7d1]
stable/6.1: [a9319d800b5701e7f5e3fa71a5b7c4831fc20d6d]
stable/6.12: [789230e5a8c1097301afc802e242c79bc8835c67]
stable/6.13: [04e05112f10354ffc3bb6cc796d553bab161594c]
stable/6.6: [ae38982f521621c216fc2f5182cd091f4734641d]

CVE-2025-21761: openvswitch: use RCU protection in ovs_vport_cmd_fill_info()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [a8816b3f1f151373fd30f1996f00480126c8bb11]
stable/5.15: [a884f57600e463f69d7b279c4598b865260b62a1]
stable/5.4: [e85a25d1a9985645e796039e843d1de581d2de1e]
stable/6.1: [7e01abc34e87abd091e619161a20f54ed4e3e2da]
stable/6.12: [a849a10de5e04d798f7f286a2f1ca174719a617a]
stable/6.13: [5828937742af74666192835d657095d95c53dbd0]
stable/6.6: [8ec57509c36c8b9a23e50b7858dda0c520a2d074]

CVE-2025-21762: arp: use RCU protection in arp_xmit()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [307cd1e2d3cb1cbc6c40c679cada6d7168b18431]
stable/5.15: [d9366ac2f956a1948b68c0500f84a3462ff2ed8a]
stable/5.4: [10f555e3f573d004ae9d89b3276abb58c4ede5c3]
stable/6.1: [f189654459423d4d48bef2d120b4bfba559e6039]
stable/6.12: [01d1b5c9abcaff29a43f1d17a19c33eec92c7dbe]
stable/6.13: [2c331718d3389b6c5f6855078ab7171849e016bd]
stable/6.6: [e9f4dee534eb1b225b0a120395ad9bc2afe164d3]

CVE-2025-21763: neighbour: use RCU protection in __neigh_notify()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [8666e9aab801328c1408a19fbf4070609dc0695a]
stable/5.15: [40d8f2f2a373b6c294ffac394d2bb814b572ead1]
stable/5.4: [e1aed6be381bcd7f46d4ca9d7ef0f5f3d6a1be32]
stable/6.1: [784eb2376270e086f7db136d154b8404edacf97b]
stable/6.12: [cdd5c2a12ddad8a77ce1838ff9f29aa587de82df]
stable/6.13: [559307d25235e24b5424778c7332451b6c741159]
stable/6.6: [1cbb2aa90cd3fba15ad7efb5cdda28f3d1082379]

CVE-2025-21764: ndisc: use RCU protection in ndisc_alloc_skb()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [c30893ef3d9cde8e7e8e4fd06b53d2c935bbccb1]
stable/5.15: [b870256dd2a5648d5ed2f22316b3ac29a7e5ed63]
stable/5.4: [96fc896d0e5b37c12808df797397fb16f3080879]
stable/6.1: [3c2d705f5adf5d860aaef90cb4211c0fde2ba66d]
stable/6.12: [bbec88e4108e8d6fb468d3817fa652140a44ff28]
stable/6.13: [cd1065f92eb7ff21b9ba5308a86f33d1670bf926]
stable/6.6: [9e0ec817eb41a55327a46cd3ce331a9868d60304]

CVE-2025-21765: ipv6: use RCU protection in ip6_default_advmss()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [d02f30d220ef9511568a48dba8a9004c65f8d904]
stable/5.15: [28de355b63ad42309ed5a03ee7c436c90512265b]
stable/5.4: [78ad057472d8c76e0602402269222f9f9c698790]
stable/6.1: [84212387caadb211cd9dadd6fd5563bd37dc1f5e]
stable/6.12: [713a40c892f40300d63691d9f85b2a23b48fe1e8]
stable/6.13: [550ed693f47370502a71b85382e7f9e6417300b8]
stable/6.6: [4176a68b0db8fc74ac14fcd00ba8231371051dc2]

CVE-2025-21766: ipv4: use RCU protection in __ip_rt_update_pmtu()

stable/5.15 was fixed.

Fixed status
stable/5.15: [ce3c6165fce0f06305c806696882a3ad4b90e33f]
stable/6.1: [ea07480b23225942208f1b754fea1e7ec486d37e]
stable/6.12: [4583748b65dee4d61bd50a2214715b4237bc152a]
stable/6.13: [a39f61d212d822b3062d7f70fa0588e50e55664e]
stable/6.6: [9b1766d1ff5fe496aabe9fc5f4e34e53f35c11c4]

CVE-2025-21767: clocksource: Use migrate_disable() to avoid calling
get_random_u32() in atomic context

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [d9c217fadfcff7a8df58567517d1e4253f3fd243]
stable/5.15: [60f54f0d4ea530950549a8263e6fdd70a40490a4]
stable/6.1: [852805b6cbdb69c298a8fc9fbe79994c95106e04]
stable/6.12: [cc3d79e7c806cb57d71c28a4a35e7d7fb3265faa]
stable/6.13: [0fb534187d2355f6c8f995321e76d1ccd1262ac1]
stable/6.6: [8783ceeee797d9aa9cfe150690fb9d0bac8cc459]

CVE-2025-21772: partitions: mac: fix handling of bogus partition table

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [213ba5bd81b7e97ac6e6190b8f3bc6ba76123625]
stable/5.15: [40a35d14f3c0dc72b689061ec72fc9b193f37d1f]
stable/5.4: [a3e77da9f843e4ab93917d30c314f0283e28c124]
stable/6.1: [27a39d006f85e869be68c1d5d2ce05e5d6445bf5]
stable/6.12: [6578717ebca91678131d2b1f4ba4258e60536e9f]
stable/6.13: [7fa9706722882f634090bfc9af642bf9ed719e27]
stable/6.6: [92527100be38ede924768f4277450dfe8a40e16b]

CVE-2025-21776: USB: hub: Ignore non-compliant devices with too many
configs or interfaces

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [d343fe0fad5c1d689775f2dda24a85ce98e29566]
stable/5.15: [d3a67adb365cdfdac4620daf38a82e57ca45806c]
stable/5.4: [49f077106fa07919a6a6dda99bb490dd1d1a8218]
stable/6.1: [c3720b04df84b5459050ae4e03ec7d545652f897]
stable/6.12: [62d8f4c5454dd39aded4f343720d1c5a1803cfef]
stable/6.13: [5b9778e1fe715700993ce436c152dc3b7df0b490]
stable/6.6: [e905a0fca7bff0855d312c16f71e60e1773b393e]

CVE-2025-21779: KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if
local APIC isn't in-kernel

stable/5.15 was fixed.

Fixed status
stable/5.15: [45fa526b0f5a34492ed0536c3cdf88b78380e4de]
stable/6.1: [5393cf22312418262679eaadb130d608c75fe690]
stable/6.12: [aca8be4403fb90db7adaf63830e27ebe787a76e8]
stable/6.13: [ca29f58ca374c40a0e69c5306fc5c940a0069074]
stable/6.6: [874ff13c73c45ecb38cb82191e8c1d523f0dc81b]

CVE-2025-21781: batman-adv: fix panic during interface removal

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [ce3f1545bf8fa28bd05ec113679e8e6cd23af577]
stable/5.15: [f0a16c6c79768180333f3e41ce63f32730e3c3af]
stable/5.4: [167422a07096a6006599067c8b55884064fa0b72]
stable/6.1: [7eb5dd201695645af071592a50026eb780081a72]
stable/6.12: [2c3fb7df4cc6d043f70d4a8a10f8b915bbfb75e7]
stable/6.13: [522b1596ea19e327853804da2de60aeb9c5d6f42]
stable/6.6: [072b2787321903287a126c148e8db87dd7ef96fe]

CVE-2025-21782: orangefs: fix a oob in orangefs_debug_write

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [09d472a18c0ee1d5b83612cb919e33a1610fea16]
stable/5.15: [8725882b0f691f8113b230aea9df0256030a63a6]
stable/5.4: [18b7f841109f697840fe8633cf7ed7d32bd3f91b]
stable/6.1: [1da2697307dad281dd690a19441b5ca4af92d786]
stable/6.12: [897f496b946fdcfab5983c983e4b513ab6682364]
stable/6.13: [1c5244299241cf49d8ae7b5054e299cc8faa4e09]
stable/6.6: [2b84a231910cef2e0a16d29294afabfb69112087]

CVE-2025-21785: arm64: cacheinfo: Avoid out-of-bounds write to cacheinfo array

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [e4fde33107351ec33f1a64188612fbc6ca659284]
stable/5.15: [88a3e6afaf002250220793df99404977d343db14]
stable/5.4: [4371ac7b494e933fffee2bd6265d18d73c4f05aa]
stable/6.1: [4ff25f0b18d1d0174c105e4620428bcdc1213860]
stable/6.12: [715eb1af64779e1b1aa0a7b2ffb81414d9f708e5]
stable/6.13: [67b99a2b5811df4294c2ad50f9bff3b6a08bd618]
stable/6.6: [ab90894f33c15b14c1cee6959ab6c8dcb09127f8]

CVE-2025-21787: team: better TEAM_OPTION_TYPE_STRING validation

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [7f5af50f3aa0af8cbef9fb76fffeed69e8143f59]
stable/5.15: [f443687ad20c70320d1248f35f57bf46cac8df0a]
stable/5.4: [7c30483d0f6bdb2230e10e3e4be5167927eac7a0]
stable/6.1: [4512482e4805dd30bc77dec511f2a2edba5cb868]
stable/6.12: [4236bf4716589558cc0f3c3612642b2c2141b04e]
stable/6.13: [8401cade1918281177974b32c925afdce750d292]
stable/6.6: [d071a91fa614ecdf760c29f61f6a7bfb7df796d6]

CVE-2025-21791: vrf: use RCU protection in l3mdev_l3_out()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [20a3489b396764cc9376e32a9172bee26a89dc3b]
stable/5.15: [5bb4228c32261d06e4fbece37ec3828bcc005b6b]
stable/5.4: [6ccaa5797f5362a2aad6baa6ddaf4715ac2dd51e]
stable/6.1: [c7574740be8ce68a57d0aece24987b9be2114c3c]
stable/6.12: [022cac1c693add610ae76ede03adf4d9d5a2cf21]
stable/6.13: [7b81425b517accefd46bee854d94954f5c57e019]
stable/6.6: [c40cb5c03e37552d6eff963187109e2c3f78ef6f]

CVE-2025-21795: NFSD: fix hang in nfsd4_shutdown_callback

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [abed68027ea3ab893ac85cc46a00e2e64a324239]
stable/5.15: [efa8a261c575f816c7e79a87aeb3ef8a0bd6b221]
stable/6.1: [38d345f612503b850c2973e5a879f88e441b34d7]
stable/6.12: [cedfbb92cf97a6bff3d25633001d9c44442ee854]
stable/6.13: [e88d2451cd42e025465d6b51fd716a47b0b3800d]
stable/6.6: [23ad7797c74cd8f7f90617f1e59a8703e2b43908]

CVE-2025-21796: nfsd: clear acl_access/acl_default after releasing them

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [8a1737ae42c928384ab6447f6ee1a882510e85fa]
stable/5.15: [6f7cfee1a316891890c505563aa54f3476db52fd]
stable/6.1: [2e59b2b68782519560b3d6a41dd66a3d01a01cd3]
stable/6.12: [f8d871523142f7895f250a856f8c4a4181614510]
stable/6.13: [1fd94884174bd20beb1773990fd3b1aa877688d9]
stable/6.6: [55d947315fb5f67a35e4e1d3e01bb886b9c6decf]

CVE-2025-21799: net: ethernet: ti: am65-cpsw: fix freeing IRQ in
am65_cpsw_nuss_remove_tx_chns()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [321990fdf4f1bb64e818c7140688bf33d129e48d]
stable/5.15: [ed8c0300f302338c36edb06bca99051e5be6fb2f]
stable/6.1: [aea5cca681d268f794fa2385f9ec26a5cce025cd]
stable/6.12: [8448c87b3af68bebca21e3136913f7f77e363515]
stable/6.13: [8aae91ae1c65782a169ec070e023d4d269e5d6e6]
stable/6.6: [88fd5db8c0073bd91d18391feb5741aeb0a2b475]

CVE-2025-21802: net: hns3: fix oops when unload drivers paralleling

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [622d92a67656e5c4d2d6ccac02d688ed995418c6]
stable/5.15: [8c640dd3d900cc8988a39c007591f1deee776df4]
stable/6.1: [e876522659012ef2e73834a0b9f1cbe3f74d5fad]
stable/6.12: [82736bb83fb0221319c85c2e9917d0189cd84e1e]
stable/6.13: [cafe9a27e22736d4a01b3933e36225f9857c7988]
stable/6.6: [b5a8bc47aa0a4aa8bca5466dfa2d12dbb5b3cd0c]

CVE-2025-21804: PCI: rcar-ep: Fix incorrect variable used when calling
devm_request_mem_region()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [7a47e14c5fb0b6dba7073be7b0119fb8fe864e01]
stable/5.15: [6987e021b64cbb49981d140bb72d9d1466f191c4]
stable/6.1: [24576899c49509c0d533bcf569139f691d8f7af7]
stable/6.12: [9ff46b0bfeb6e0724a4ace015aa7a0b887cdb7c1]
stable/6.13: [44708208c2a4b828a57a2abe7799c9d3962e7eaa]
stable/6.6: [2c54b9fca1755e80a343ccfde0652dc5ea4744b2]

CVE-2025-21806: net: let net.core.dev_weight always be non-zero

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [c337c08819a4ec49edfdcd8fc46fbee120d8a5b2]
stable/5.15: [0e2f1d93d287d544d26f8ff293ea820a8079b9f8]
stable/5.4: [d0e0f9c8218826926d7692980c98236d9f21fd3c]
stable/6.1: [5860abbf15eeb61838b5e32e721ba67b0aa84450]
stable/6.12: [33e2168788f8fb5cb8bd4f36cb1ef37d1d34dada]
stable/6.13: [1489824e5226a26841c70639ebd2d1aed390764b]
stable/6.6: [6ce38b5a6a49e65bad163162a54cb3f104c40b48]

CVE-2025-21811: nilfs2: protect access to buffers with no active references

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [72cf688d0ce7e642b12ddc9b2a42524737ec1b4a]
stable/5.15: [d8ff250e085a4c4cdda4ad1cdd234ed110393143]
stable/5.4: [e1fc4a90a90ea8514246c45435662531975937d9]
stable/6.1: [58c27fa7a610b6e8d44e6220e7dbddfbaccaf439]
stable/6.12: [4b08d23d7d1917bef4fbee8ad81372f49b006656]
stable/6.13: [c437dfac9f7a5a46ac2a5e6d6acd3059e9f68188]
stable/6.6: [8e1b9201c9a24638cf09c6e1c9f224157328010b]

CVE-2025-21814: ptp: Ensure info->enable callback is always set

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [9df3a9284f39bfd51a9f72a6a165c79e2aa5066b]
stable/5.15: [1334c64a5d1de6666e0c9f984db6745083df1eb4]
stable/5.4: [fdc1e72487781dd7705bcbe30878bee7d5d1f3e8]
stable/6.1: [5d1041c76de656f9f8d5a192218039a9acf9bd00]
stable/6.12: [8441aea46445252df5d2eed6deb6d5246fc24002]
stable/6.13: [755caf4ee1c615ee5717862e427124370f46b1f3]
stable/6.6: [81846070cba17125a866e8023c01d3465b153339]

CVE-2025-21818: [REJECTED]: x86/xen: fix xen_hypercall_hvm() to not clobber %rbx

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [d80e4842a2dbd325d4a9b923d86d54abd50cc2c9]
stable/5.15: [aaa15fc4291b0c0c6259ca72a95420feea2f0649]
stable/6.1: [522d726824cc570e0b6bf0b3af4d5a826f1b17c5]
stable/6.12: [4890a0858c09d96f3234a8f94663de80a7201bc4]
stable/6.13: [23f6f420cd727d641f95478fcf3bbbee41e4e5d6]
stable/6.6: [242f7584da3ad041a9db809d33d27a8be8eccc29]

CVE-2025-21820: tty: xilinx_uartps: split sysrq handling

stable/5.15 was fixed.

Fixed status
stable/5.15: [e22a97700901ba5e8bf8db68056a0d50f9440cae]
stable/6.1: [de5bd24197bd9ee37ec1e379a3d882bbd15c5065]
stable/6.12: [9b88a7c4584ba67267a051069b8abe44fc9595b2]
stable/6.13: [4410dba9807a17a93f649a9f5870ceaf30a675a3]
stable/6.6: [8ea0e7b3d7b8f2f0fc9db491ff22a0abe120801c]

CVE-2025-21823: batman-adv: Drop unmanaged ELP metric worker

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [a0019971f340ae02ba54cf1861f72da7e03e6b66]
stable/5.15: [3c0e0aecb78cb2a2ca1dc701982d08fedb088dc6]
stable/5.4: [1c334629176c2d644befc31a20d4bf75542f7631]
stable/6.1: [781a06fd265a8151f7601122d9c2e985663828ff]
stable/6.12: [0fdc3c166ac17b26014313fa2b93696354511b24]
stable/6.13: [af264c2a9adc37f4bdf88ca7f3affa15d8c7de9e]
stable/6.6: [a7aa2317285806640c844acd4cd2cd768e395264]

CVE-2025-21826: netfilter: nf_tables: reject mismatching sum of
field_len with set key length

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [6b467c8feac759f4c5c86d708beca2aa2b29584f]
stable/5.15: [5083a7ae45003456c253e981b30a43f71230b4a3]
stable/6.1: [2ac254343d3cf228ae0738b2615fedf85d000752]
stable/6.12: [49b7182b97bafbd5645414aff054b4a65d05823d]
stable/6.13: [ab50d0eff4a939d20c37721fd9766347efcdb6f6]
stable/6.6: [82e491e085719068179ff6a5466b7387cc4bbf32]

CVE-2025-21830: landlock: Handle weird files

stable/5.15 was fixed.

Fixed status
stable/5.15: [a1fccf6b72b56343dd4f2d96b008147f9951eebd]
stable/6.1: [7d6121228959ddf44a4b9b6a177384ac7854e2f9]
stable/6.12: [2569e65d2eb6ac1afe6cb6dfae476afee8b6771a]
stable/6.13: [0fde195a373ab1267e60baa9e1a703a97e7464cd]
stable/6.6: [39bb3d56f1c351e76bb18895d0e73796e653d5c1]

CVE-2025-21835: usb: gadget: f_midi: fix MIDI Streaming descriptor lengths

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [9f36a89dcb78cb7e37f487b04a16396ac18c0636]
stable/5.15: [d8e86700c8a8cf415e300a0921acd6a8f9b494f8]
stable/5.4: [3a983390d14e8498f303fc5cb23ab7d696b815db]
stable/6.1: [9f6860a9c11301b052225ca8825f8d2b1a5825bf]
stable/6.12: [6b16761a928796e4b49e89a0b1ac284155172726]
stable/6.13: [a2d0694e1f111379c1efdf439dadd3cfd959fe9d]
stable/6.6: [6ae6dee9f005a2f3b739b85abb6f14a0935699e0]

CVE-2025-21844: smb: client: Add check for next_buffer in
receive_encrypted_standard()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [f277e479eea3d1aa18bc712abe1d2bf3dece2e30]
stable/5.15: [f618aeb6cad2307e48a641379db610abcf593edf]
stable/6.1: [24e8e4523d3071bc5143b0db9127d511489f7b3b]
stable/6.12: [a9b0b4b29877cb4dc5d0842b59b5ccbacddb85bd]
stable/6.13: [554736b583f529ee159aa95af9a0cbc12b5ffc96]
stable/6.6: [9e5d99a4cf2e23c716b44862975548415fae5391]

CVE-2025-21846: acct: perform last write from workqueue

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [b03782ae707cc45e65242c7cddd8e28f1c22cde5]
stable/5.15: [5d5b936cfa4b0d5670ca7420ef165a074bc008eb]
stable/5.4: [8acbf4a88c6a98c8ed00afd1a7d1abcca9b4735e]
stable/6.1: [5ee8da9bea70dda492d61f075658939af33d8410]
stable/6.12: [5a59ced8ffc71973d42c82484a719c8f6ac8f7f7]
stable/6.13: [a8136afca090412a36429cb6c2543c714d9c0f84]
stable/6.6: [5c928e14a2ccd99462f2351ead627b58075bb736]

CVE-2025-21848: nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [e976ea6c5e1b005c64467cbf94a8577aae9c7d81]
stable/5.15: [924b239f9704566e0d86abd894d2d64bd73c11eb]
stable/5.4: [d64c6ca420019712e194fe095b55f87363e22a9a]
stable/6.1: [1358d8e07afdf21d49ca6f00c56048442977e00a]
stable/6.12: [897c32cd763fd11d0b6ed024c52f44d2475bb820]
stable/6.13: [bd97f60750bb581f07051f98e31dfda59d3a783b]
stable/6.6: [29ccb1e4040da6ff02b7e64efaa2f8e6bf06020d]

CVE-2025-21858: geneve: Fix use-after-free in geneve_find_dev().

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [5a0538ac6826807d6919f6aecbb8996c2865af2c]
stable/5.15: [f74f6560146714241c6e167b03165ee77a86e316]
stable/5.4: [d5e86e27de0936f3cb0a299ce519d993e9cf3886]
stable/6.1: [904e746b2e7fa952ab8801b303ce826a63153d78]
stable/6.12: [da9b0ae47f084014b1e4b3f31f70a0defd047ff3]
stable/6.13: [788dbca056a8783ec063da3c9d49a3a71c76c283]
stable/6.6: [3ce92ca990cfac88a87c61df3cc0b5880e688ecf]

CVE-2025-21859: USB: gadget: f_midi: f_midi_complete to call queue_work

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [1f10923404705a94891e612dff3b75e828a78368]
stable/5.15: [b09957657d7767d164b3432af2129bd72947553c]
stable/5.4: [727dee0857946b85232526de4f5a957fe163e89a]
stable/6.1: [24a942610ee9bafb2692a456ae850c5b2e409b05]
stable/6.12: [e9fec6f42c45db2f62dc373fb1a10d2488c04e79]
stable/6.13: [8aa6b4be1f4efccbfc533e6ec8841d26e4fa8dba]
stable/6.6: [deeee3adb2c01eedab32c3b4519337689ad02e8a]

CVE-2025-21862: drop_monitor: fix incorrect initialization order

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [29f9cdcab3d96d5207a5c92b52c40ad75e5915d8]
stable/5.15: [872c7c7e57a746046796ddfead529c9d37b9f6b4]
stable/5.4: [6e9e0f224ffd8b819da3ea247dda404795fdd182]
stable/6.1: [fcfc00bfec7bb6661074cb21356d05a4c9470a3c]
stable/6.12: [b7859e8643e75619b2705b4fcac93ffd94d72b4a]
stable/6.13: [219a47d0e6195bd202f22855e35f25bd15bc4d58]
stable/6.6: [0efa6c42f81c60d8f72ba7f5ed8d4fec8c526282]

CVE-2025-21865: gtp: Suppress list corruption splat in
gtp_net_exit_batch_rtnl().

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [33eb925c0c26e86ca540a08254806512bf911f22]
stable/5.15: [cb15bb1bde0ba97cbbed9508e45210dcafec3657]
stable/5.4: [7f86fb07db65a470d0c11f79da551bd9466357dc]
stable/6.1: [b70fa591b066d52b141fc430ffdee35b6cc87a66]
stable/6.12: [ff81b14010362f6188ca26fec22ff05e4da45595]
stable/6.13: [37e7644b961600ef0beb01d3970c3034a62913af]
stable/6.6: [9d03e7e37187ae140e716377599493987fb20c5b]

CVE-2025-21866: powerpc/code-patching: Fix KASAN hit by not flagging
text patching area as VM_ALLOC

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [f8d4c5b653c1bc0df56e15658bbf64fc359adc4e]
stable/5.15: [6847b3e40bb963e57b61d1cc6fe84cb37b9d3d4c]
stable/5.4: [97de5852058a299ba447cd9782fe96488d30108b]
stable/6.1: [c905a3053518212a1017e50bd2be3bee59305bb0]
stable/6.12: [8d06e9208184b2851fa79a3a39d6860320c8bdf8]
stable/6.13: [2e6c80423f201405fd65254e52decd21663896f3]
stable/6.6: [2d542f13d26344e3452eee77613026ce9b653065]

CVE-2025-23126: [REJECTED]: x86/xen: fix xen_hypercall_hvm() to not clobber %rbx

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [d80e4842a2dbd325d4a9b923d86d54abd50cc2c9]
stable/5.15: [aaa15fc4291b0c0c6259ca72a95420feea2f0649]
stable/6.1: [522d726824cc570e0b6bf0b3af4d5a826f1b17c5]
stable/6.12: [4890a0858c09d96f3234a8f94663de80a7201bc4]
stable/6.13: [23f6f420cd727d641f95478fcf3bbbee41e4e5d6]
stable/6.6: [242f7584da3ad041a9db809d33d27a8be8eccc29]

CVE-2025-23127: [REJECTED]: x86/xen: fix xen_hypercall_hvm() to not clobber %rbx

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [d80e4842a2dbd325d4a9b923d86d54abd50cc2c9]
stable/5.15: [aaa15fc4291b0c0c6259ca72a95420feea2f0649]
stable/6.1: [522d726824cc570e0b6bf0b3af4d5a826f1b17c5]
stable/6.12: [4890a0858c09d96f3234a8f94663de80a7201bc4]
stable/6.13: [23f6f420cd727d641f95478fcf3bbbee41e4e5d6]
stable/6.6: [242f7584da3ad041a9db809d33d27a8be8eccc29]

CVE-2025-23128: [REJECTED]: x86/xen: fix xen_hypercall_hvm() to not clobber %rbx

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [d80e4842a2dbd325d4a9b923d86d54abd50cc2c9]
stable/5.15: [aaa15fc4291b0c0c6259ca72a95420feea2f0649]
stable/6.1: [522d726824cc570e0b6bf0b3af4d5a826f1b17c5]
stable/6.12: [4890a0858c09d96f3234a8f94663de80a7201bc4]
stable/6.13: [23f6f420cd727d641f95478fcf3bbbee41e4e5d6]
stable/6.6: [242f7584da3ad041a9db809d33d27a8be8eccc29]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

