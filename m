Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C762C3F6B0
	for <webhook@archiver.kernel.org>; Thu, 25 Aug 2022 01:19:26 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by mx.groups.io with SMTP id smtpd.web11.18956.1661390359349536256
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Aug 2022 18:19:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=cYf9A5EP;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.178,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f178.google.com with SMTP id n124so10561582oih.7
        for <cip-dev@lists.cip-project.org>;
 Wed, 24 Aug 2022 18:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=qp3A2efZzSVvS6mk69rdD8GfuCLWhAWeTWEWtViI/ZU=;
        b=cYf9A5EPTxtzana9+KeRIwsYrYgK3vWOMgo/ZNCoY+s9jamoyARNoA6wOfWI/gAmTI
         i7hMnXRAqylMdFzlMlYEpcJKNu3nw1pr2011VDi3yEC9UeON6l6mIRZS64RBdM9CDIk6
         IczeS2vOtRXWVpIGEnu1KYX+SotdvXS1i4NyXEsda/fLhZbKI3k+2xcM5bHdYEp6Bnf0
         7xiMLMhxVwaCBzh4a3tMPwmr/xW5q7FfQ/0Ay5Q7mux4n4bXoM9oM1QVqvukQ24dfDyz
         e0/KD404F8OhvXdCjuFlcjFrroqzduNKD+ez5glIdWvHR0LiuBrBXyPAtcSAGeLNbgeO
         0zGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=qp3A2efZzSVvS6mk69rdD8GfuCLWhAWeTWEWtViI/ZU=;
        b=hwrnKFW2VLTi0tqx4puLi3b8T/XAJSjZfb4aZmyOPpgKD5n8UHUhRzTZBCKvqHS1BR
         zkq8zDiYLGbJUwUzXHMrzmu+iea7RPyvK0uGp8mfWrteb9c3rwZn7uJa9L8G+8K5Fgjf
         B/GlgOygRKaTd4MiEP4rcJm58612sjEq6ZaazU3w9PyF82yzB9L95M0p2Zj1PAUU9f8I
         fGM2Ktpx3hsVeqCAZ1RM5LlCwl/0bpyOoIxtNSBI+yt5r6hYpP8929YckGbthZV46YIG
         577CoWrNAfM7ZR7EdBu8mtADDhS0/r4XwpXJeFD0mVH31SXiGc+n8xvCFyle6iBzmCrR
         fq/w==
X-Gm-Message-State: ACgBeo2Q8PtvYhIeqsQSpnsQDJRnUdXwt9bV2GKHFSwFLkPIZ0cgGYi6
	3ZERIdgjKsMmiJBi7g8XOuS1ha81IGLjX11XvDt+7+hwAwEaxA==
X-Google-Smtp-Source: 
 AA6agR4paYx2bnM2+8L6hbcy2Ao5I6k4guO8JxZfP0G/nLR/5oIvb8IrzobK+uFW8wTmHtSgJWEFO2CMAOMcUTxyOyc=
X-Received: by 2002:a05:6808:238e:b0:344:848c:e573 with SMTP id
 bp14-20020a056808238e00b00344848ce573mr4418573oib.94.1661390358039; Wed, 24
 Aug 2022 18:19:18 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 25 Aug 2022 10:18:42 +0900
Message-ID: 
 <CAODzB9qAyEL=W2rZjz+5f2n7YmmkpRsw+cQm4=OtAPcCeJqhOw@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Aug 2022 01:19:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9319

Hi !

It's this week's CVE report.

This week reported 5 new CVEs and 8 updated CVEs.

* New CVEs

CVE-2022-2308: undefined behavior or data leak in Virtio drivers with VDUSE

CVSS v3 score is not assigned.

The vDPA Device in Userspace returns uninitialized memory in
vduse_vdpa_get_config() if size of device config space is not valid.
It could cause undefined behavior or data leaks in Virtio drivers.

VDUSE has been introduced since 5.15-rc1. So following kernels aren't
affected by this issue.

- 4.4, 4.9, 4.19, 4.14
- 5.4, 5.10

Fixed status
Not fixed yet.

CVE-2022-2873: an out-of-bounds vulnerability in i2c-ismt driver

CVSS v3 score is not assigned.

An i2c_smbus_data union data structure has block member defined as
__u8 which value can be 0 to 255.
However, there was missing a check its upper limit. When
data->block[0] is bigger than I2C_SMBUS BLOCK MAX a DMA buffer will be
overwritten.

This issues was introduced by commit 5e9a97b ("i2c: ismt: Adding
support for I2C_SMBUS_BLOCK_PROC_CALL") in 5.11-rc1.
Following kernels aren't affected by this issue.

- 4.4, 4.9, 4.19, 4.14
- 5.4, 5.10

Fixed status
mainline: [690b2549b19563ec5ad53e5c82f6a944d910086e]
stable/5.15: [24c6fc6e7453f64cf6cbb4218c62aafdecc16ee1]

CVE-2022-2938: psi: Fix uaf issue when psi trigger is destroyed while
being polled

CVSS v3 score is not assigned.

A Use-after-free bug was found in psi feature that allows attacker to
trigger system crash or memory corruption.

Commit 0e94682 ("psi: introduce psi monitor") introduced this issue.
This commit was merged in 5.2-rc1 so less than 5.4 kernels aren't
affected by this issue.

Fixed status
mainline: [a06247c6804f1a7c86a2e5398a4c1f1db1471848]
stable/5.10: [d4e4e61d4a5b87bfc9953c306a11d35d869417fd]
stable/5.15: [d3e4c61e143e69671803ef3f52140cf7a7258ee7]
stable/5.4: [2fd752ed77ab9880da927257b73294f29a199f1a]

CVE-2022-2961: race condition in rose_bind()

CVSS v3 score is not assigned.

A use-after-free bug was found in the Amateur Radio X.25 Packet Layer
Protocol (PLP Rose).
There is a race condition bug in rose_bind(). If an attacker succeeded
race, it will case use-after-free bug.

No CIP member enables CONFIG_ROSE.

Fixed status
Not fixed yet.

CVE-2022-2978: fs: fix UAF/GPF bug in nilfs_mdt_destroy

CVSS v3 score is not assigned.

A freeing uninitialized memory bug was found in nilfs_mdt_destroy().
This bug occurs in an error path. If allocating memory for inode is
failed in inode_init_always(), it returns ENOMEM. Then
nilfs_mdt_destroy() is called which frees uninialized data.

It looks 4.4 kernel is affected this bug too.
btw, nilfs_i_callback() was renamed to nilfs_free_inode() since 5.2-rc.1

Patch was sent to linux-fsdevel but it's not merged yet.

Fixed status
Not fixed yet.

* Updated CVEs

CVE-2022-1882: fs/pipe: Deinitialize the watch_queue when pipe is freed

The mainline, 5.10, 5.15, 5.18 were fixed. 4.x and 5.4 kernels were
not vulnerable so all stable kernels were fixed.

Fixed status
mainline: [353f7988dd8413c47718f7ca79c030b6fb62cfe5]
stable/5.10: [0adf21eec59040b31af113e626efd85eb153c728]
stable/5.15: [ba3a8af8a21a81cfd0c8c689a81261caba934f97]
stable/5.18: [49cbb4820e4f1895130755732485afb2d18508f9]

CVE-2022-2585: Linux kernel POSIX CPU timer UAF

The mainline, 5.15, 5.18, 5.19 were fixed but 5.10 is not fixed yet.
4.x and 5.4 kernels were not vulnerable.

Fixed status
mainline: [e362359ace6f87c201531872486ff295df306d13]
stable/5.10: [541840859ace9c2ccebc32fa9e376c7bd3def490]
stable/5.15: [9e255ed238fc67058df87b0388ad6d4b2ef3a2bd]
stable/5.18: [e8cb6e8fd9890780f1bfcf5592889e1b879e779c]
stable/5.19: [b2fc1723eb65abb83e00d5f011de670296af0b28]

CVE-2022-2586: Linux kernel nf_tables cross-table reference UAF

stable/5.10 was fixed this week.

Fixed status
mainline: [470ee20e069a6d05ae549f7d0ef2bdbcee6a81b2]
stable/5.10: [1a4b18b1ff11ba26f9a852019d674fde9d1d1cff]
stable/5.15: [faafd9286f1355c76fe9ac3021c280297213330e]
stable/5.18: [f4fa03410f7c5f5bd8f90e9c11e9a8c4b526ff6f]
stable/5.19: [0d07039397527361850c554c192e749cfc879ea9]

CVE-2022-2588: Linux kernel cls_route UAF

stable/5.10 was fixed this week. Patch was backported to 4.9, 4.14,
4.19, and 5.4 but it hasn't been released yet.

Fixed status
mainline: [9ad36309e2719a884f946678e0296be10f0bb4c1]
stable/5.10: [7018f03d97daf344e49b16200caf4363a1407cab]
stable/5.15: [57bbb691a93bd39d0644c5c879b354232d0e0eed]
stable/5.18: [e832c26e7edfa2ddbd2dcdd48016d13d747de6da]
stable/5.19: [ee3f18d90e80e79449d575fa3e7a6b775e9fc35e]

CVE-2022-2153: KVM: NULL pointer dereference in kvm_irq_delivery_to_apic_fast()

Commit ac7de8c ("KVM: x86: Avoid theoretical NULL pointer dereference
in kvm_irq_delivery_to_apic_fast()") was added to stable/5.10.

Fixed status
mainline: [7ec37d1cbe17d8189d9562178d8b29167fe1c31a,
00b5f37189d24ac3ed46cb7f11742094778c46ce,
  b1e34d325397a33d97d845e312d7cf2a8b646b44]
stable/4.19: [2f4835b5188f3b73b2b048a761ae2553e845b027]
stable/4.9: [95d51d058680766130098287f680474bc55f1679]
stable/5.10: [09c771c45c1243e295470225aaee726693fdc242,
ac7de8c2ba1292856fdd4a4c0764669b9607cf0a]
stable/5.15: [569a229142e95610adc1041ae9ca1f417c4c6a3e,
0e5dbc0540baa89faf4c04ccc7e9c4fe6b1d7bf4,
  ba6e8c2df52047a32953588b49d9addbd843a098]

CVE-2022-1462: kernel: possible race condition in drivers/tty/tty_buffers.c

The mainline was fixed in v5.19-rc7. The mainline and all stable
kernels have been fixed.

Fixed status
mainline: [a501ab75e7624d133a5a3c7ec010687c8b961d23]
stable/4.14: [e9274a2732e1de3ca36076126284b4e5ffe6d587]
stable/4.19: [eb059bf8c237fe41fbaed4a6cccacce687b83222]
stable/4.9: [41ce14090db93fc2f0c8a27ce8a324b0192da7b5]
stable/5.10: [08afa87f58d83dfe040572ed591b47e8cb9e225c]
stable/5.15: [b2d1e4cd558cffec6bfe318f5d74e6cffc374d29]
stable/5.4: [f7785092cb7f022f59ebdaa181651f7c877df132]

CVE-2022-1679: Use-After-Free in ath9k_htc_probe_device() could cause
an escalation of privileges

The mainline, 5.10, 5.15, and 5.19 have been fixed this week.

Fixed status
mainline: [0ac4827f78c7ffe8eef074bc010e7e34bc22f533]
stable/5.10: [eccd7c3e2596b574241a7670b5b53f5322f470e5]
stable/5.15: [03ca957c5f7b55660957eda20b5db4110319ac7a]
stable/5.19: [b66ebac40f64336ae2d053883bee85261060bd27]

CVE-2022-23816: Mis-trained branch predictions for return instructions
may allow speculative code execution under certain microarchitecture-
dependent conditions on some AMD processors

5.10 was fixed this week.

Fixed status
mainline: [742ab6df974ae8384a2dd213db1a3a06cf6d8936,
a883d624aed463c84c22596006e5a96f5b44db31,
  369ae6ffc41a3c1137cab697635a84d0cc7cdcea,
00e1533325fd1fb5459229fe37f235462649f668,
  0b53c374b9eff2255a386f1f1cfb9a928e52a5ae,
15e67227c49a57837108acfe1c80570e1bd9f962,
  d9e9d2300681d68a775c28de6aa6e5290ae17796,
ee88d363d15617ff50ac24fab0ffec11113b2aeb,
  1f001e9da6bbf482311e45e48f53c2bd2179e59c,
d77cfe594ad50e0bf95d457e02ccd578791b2a15,
  af2e140f34208a5dfb6b7a8ad2d56bda88f0524d,
15583e514eb16744b80be85dea0774ece153177d,
  0ee9073000e8791f8b134a8ded31bcc767f7f232,
aa3d480315ba6c3025a60958e1981072ea37c3df,
  7c81c0c9210c9bfab2bae76aab2999de5bad27db,
951ddecf435659553ed15a9214e153a3af43a9a1,
  a149180fbcf336e97ce4eb2cdc13672727feb94d,
6b80b59b3555706508008f1f127b5412c89c7fd8,
  7fbf47c7ce50b38a64576b150e7011ae73d54669,
e8ec1b6e08a2102d8755ccb06fa26d540f26a2fa,
  caa0ff24d5d0e02abce5e65c3d2b7f20a6617be5,
2dbb887e875b1de3ca8f40ddf26bcfe55798c609,
  c779bc1a9002fa474175b80e72b85c9bf628abb0,
7c693f54c873691a4b7da05c7e0f74e67745d144,
  166115c08a9b0b846b783088808a27d739be6e8d,
6ad0ad2bf8a67e27d1f9d006a1dabb0e1c360cc3,
  bf5835bcdb9635c97f85120dba9bfa21e111130f,
9bb2ec608a209018080ca262f771e6a9ff203b6f,
  b75b7f8ef1148be1b9321ffc2f6c19238904b438,
d147553b64bad34d2f92cb7d8ba454ae95c3baac,
  3ebc170068885b6fc7bedda6c667bb2c4d533159,
0fe4aeea9c01baabecc8c3afc7889c809d939bc2,
  a09a6e2399ba0595c3042b3164f3ca68a3cff33e,
d7caac991feeef1b871ee6988fd2c9725df09039,
  b2620facef4889fefcbf2e87284f34dcd4189bce,
e6aa13622ea8283cc699cac5d018cc40a2ba2010,
  56aa4d221f1ee2c3a49b45b800778ec6e0ab73c5,
bbb69e8bee1bd882784947095ffb2bfe0f7c9470,
  acac5e98ef8d638a411cfa2ee676c87e1973f126,
8faea26e611189e933ea2281975ff4dc7c1106b6,
  8bd200d23ec42d66ccd517a72dd0b9cc6132d2fd,
bb06650634d3552c0f8557e9d16aa1a408040e28,
  fc02735b14fff8c6678b521d324ade27b1a3d4cf,
bea7e31a5caccb6fe8ed989c065072354f0ecb52,
  9756bba28470722dacb79ffce554336dd1f6a6cd,
07853adc29a058c5fd143c14e5ac528448a72ed9,
  7a05bc95ed1c5a59e47aaade9fb4083c27de9e62,
26aae8ccbc1972233afd08fb3f368947c0314265,
  f43b9876e857c739d407bc56df288b0ebe1a9164,
f54d45372c6ac9c993451de5e51312485f7d10bc,
  2c08b9b38f5b0f4a6c2d29be22b695e4ec4a556b,
2259da159fbe5dba8ac00b560cf00b6a6537fa18,
  697977d8415d61f3acbc4ee6d564c9dcf0309507,
4ad3278df6fe2b0852b00d5757fc2ccd8e92c26e,
  c27c753ea6fd1237f4f96abf8b623d7bab505513]
stable/5.10: [7070bbb66c5303117e4c7651711ea7daae4c64b5,
feec5277d5aa9780d4814084262b98af2b1a2242,
  6a2b142886c52244a9c1dfb0a36971daa963541a,
3e519ed8d509f5f2e1c67984f3cdf079b725e724,
  37b9bb094123a14a986137d693b5aa18a240128b,
270de63cf4a380fe9942d3e0da599c0e966fad78,
  716410960ba0a2d2c3f59cb46315467c9faf59b2,
8bdb25f7aee312450e9c9ac21ae209d9cf0602e5,
  446eb6f08936e6f87bea9f35be05556a7211df9b,
7723edf5edfdfdabd8234e45142be86598a04cad,
  00b136bb6254e0abf6aaafe62c4da5f6c4fea4cb,
e0e06a922706204df43d50032c05af75d8e75f8e,
  ee4996f07d868ee6cc7e76151dfab9a2344cdeb0,
d6eb50e9b7245a238872a9a969f84993339780a5,
  5b2edaf709b50c81b3c6ddb745c8a76ab6632645,
c9eb5dcdc8f4a848b45b97725f5a2b8d324bb31a,
  c70d6f82141b89db6c076b0cbf9a7a2edc29e46d,
df748593c55389892902aecb8691080ad5e8cff5,
  876750cca4f043bd626a3ac760ce887dda3b6ec7,
3f29791d56d32a610a2b57a9b700b1bc1912e41f,
  a989e75136192036d47e4dc4fe87ff9c961d6b46,
9e727e0d9486121de5c21cbb65fcc0c907834b17,
  3dddacf8c3cc29b9b37d8c4353f746e510ad1371,
6d7e13ccc4d73e5c88cc015bc0154b7d08f65038,
  dabc2a1b406ae0ff5286c91f7519b3e20ec2aa63,
a0f8ef71d762501769df69e35c4c4e7496866d90,
  e8142e2d6cb6b39fdd78bc17199429f79bcd051c,
55bba093fd91a76971134e3a4e3576e536c08f5c,
  28aa3fa0b2c9d0cd7bdac42d9eb7fe3d5f6c79e8,
f728eff26339d85825e588d461f0e55267bc6c3f,
  c8845b875437b8ea9cd023f15b44c436c9c5b62d,
fbab1c94eb1a3139d7ac0620dc6d7d6a33f3b255,
  0d1a8a16e62c8048f2ff7f9c6f448bf595d2a2a8,
ea1aa926f423a8cf1b2416bb909bfbea37d12b11,
  f1b01ace814b0a8318041e3aea5fd36cc74f09b0,
d29c07912a49fce965228f73a293e2c899bc7e35,
  aad83db22e9950577b5b827f57ed7108b3ca5553,
ce11f91b21c25dda8b06988817115bef1c636434,
  1dbefa57725204be0348351ea4756c52b10b3504,
df93717a32f57e1b033dbfa2a78809d7d4000648,
  07401c2311f6fddd3c49a392eafc2c28a899f768,
84061fff2ad98a7809f00e88a54f584f84830388,
  5269be9111e2b66572e78647f2e8948f7fc96466,
47ae76fb27398e867980d63789058ff7c4f12a35,
  4d7f72b6e1bc630bec7e4cd51814bc2b092bf153,
a74f5d23e68d9687ed06bd462d344867824707d8,
  f7851ed697be2ce86bd8baf29111762b7b3ff6cc,
b24fdd0f1c3328cf8ee0c518b93a7187f8cee097,
  609336351d08699395be24860902e6e0b7860e2b,
51552b6b52fc865f37ef3ddacd27d807a36695ac,
  c2ca992144281917cfae19d231b1195c02906a4e,
eb38964b6ff864b8bdf87c9cf6221d0b0611a990,
  c035ca88b0742952150b1671bb5d26b96f921245]
stable/5.18: [e492002673b03c636d2297fb869d68ae545c41c4,
e0ed7445cbb5a10bebec4f582894460453b3c0f6,
  079c71b6e380c40ee870bc59f176b36d93786db5,
7ce2011c8b28a44ae80d7081dc634eec174650ca,
  86fbd2844858c5aef57a28ebc3d53d298f37cc67,
e0c27dc584f6395e57d67f5c60b3ee2347a45590,
  262941a05615d39d66dcf47909d6e67ea69d371d,
eb84031e5c599a4b218ede3e10e7b5fd8ccc391a,
  0d15b9c30cb222d0e5ac2ff9ba7b93bd9af82d05,
ebe3ceb43f5b5b88062ffd62c08d19a57f5fa44b,
  3525abdb3a63680b8623b0294bd9614b2352ccce,
2fc0ed17c526b032c1c416d77ebc491f446f1269,
  a302187fb8f6d2707aaadf5e8a558ff046378a80,
a05146b2ac6ab1deff475a06441b825d176b320e,
  df777869fe2de25b60195561d3b674c9084aaeca,
9d75af6b406702b0af616cee49ae11ec0b2abe3a,
  64a98375f389bf695e2a2f199175b7a5ece44f45,
a70ed95a0b0a15cfa86b1df4004d47f074de7de2,
  f88b40812b6b3d483fb5de11b72aeb0c2bb73c59,
c85b5f77d3b224975d5caa329f28b22b7ea5addc,
  409586fb4a6e7b2331ecb4edec71e34e21750e05,
47e51d66d93d70d60e478cc81504deb0f4ff67ad,
  2c0d8e35807a6086542919e2d044cfa6683476de,
e604d260c633926089e81f8e52c90c91bd797f12,
  fb32593f8f383e32bb82fd85cc3dd372c89566ac,
5a3037b4de4dd52504c0842aac5f9498b3d450af,
  7b2649892c7728d4ad662d75a887f8b43a209189,
6864df0932578931f13c8de5006975345f8cea0d,
  4a691f1e69163dcfb7b064a25a082071da0bb633,
b75fada7f3cbbaf78beceb1bb71b67c2db3b473d,
  bbcfdf144d2d9394e3f4aa129463dec8f53bd3b1,
4c7f90f8a9554dd6a7e614529b3d7450a8dc84e2,
  a8a370f08eb55359980fe29165569333b1e0c54d,
80f8a9e9d530fec6094641b96fe3e5b5acb44830,
  3d6bdd768577847ae680b27bfb50c6de2037afe7,
3e89c42462722bbf778ac1e97236dca518fabbf9,
  ff110fe719555fd358ac9e0bd0ca549fae3e26e9,
8a95fadc8f3264dc98376d0de66ec59dd9eafb6f,
  7377eea29dbcad2ad042eee66df17c11b8421654,
43827446da732ed012c9008c429424f81e36331b,
  bcb9508413dc8a73cb8abd761a85dc5c6f9bd911,
245800423a576925d0bd571eacf09cc12e94a9ff,
  d58141112c9965092a0f39d354b22394882585b4,
48fe9931c7ddf18063aa0c8d16c3831f9d9a16c4,
  8c38306e2e9257af4af2819aa287a4711ff36329,
afd743f6dde87296c6f3414706964c491bb85862,
  373e6942143b5ca27b24ee953ae450dd26a0dbfb,
409f6047a43315f2b9661149cb29d6f2ef2440fe,
  813423f90f0553c81c5fb4d531fc688a5d506b24,
ee02cbcebb0985394910d8868c6eef49184b20f7,
  df6fc784e8db07b8fe5aa1c624411f381f3abeaa,
e2fe046fe230c5159660257712566a849847cffa,
  845351c56ca069162433cf935afb2257a4c021d1,
ffdd31e8db4e94f399e68727fadf776fc0a2d1ba,
  6461cc8f22a1266498290b122b56f040d51d9224]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

