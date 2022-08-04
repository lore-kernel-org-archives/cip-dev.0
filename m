Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15156C19F29
	for <webhook@archiver.kernel.org>; Thu,  4 Aug 2022 00:30:27 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43])
 by mx.groups.io with SMTP id smtpd.web08.815.1659573016956453216
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 17:30:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=rvBo3h6n;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.43,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-10ee900cce0so10664017fac.5
        for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 17:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=hNIKhmg4+3HAAPTbDO1AN5Dz+XMGrsN0sJq2Vyd94/s=;
        b=rvBo3h6nDMOumk2jPFVeXhMagcjHfNyj5JAALo6JEZoL+wMiCfOGVfRIL4FOMgrO1f
         TPHGfOndhqpuVFzQiPGhWs4V+z8wWM174QNeU279GljFjbTImPYcXoLL9+051ICRyBnW
         PyrDxO7H4Yg90k64Ps7vn46u4hD5bPw7HgyIN9sdzHmStVeqL3XMh6c0DwOxzciezJ2B
         TF3B6D0QRjNy7UrbzneRCRlkA3OtIBark/bhJh8v6zAhQVV0ShNjC3/WW+oZqKSG0LW6
         ORtuPfrwN7X/RmsBVB1wu8e1wyWQjwUIgI6k9Jde1mRocnvXAbk3mrbXvJxMs33IOhCn
         ghdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=hNIKhmg4+3HAAPTbDO1AN5Dz+XMGrsN0sJq2Vyd94/s=;
        b=PcVlzo8BRzDkLHelmExDSiATbigJkLFpAQORjto/NeCPPOQx1wecc+enCvO/GzcHo0
         9pS8ivNeHF3XVrrSeFVy2fvEyINlZUPPs0r3Dq0hazKPaKKPDBspRm2seNazBg9FxSnU
         CnbPy7x9qE9Tu6qMtwUR9w9gZjbwrgH/9oawcciD8nBdgI44JyZlVW+IHzaLUO/JIdDh
         TozRNdx/91oln+tUtw6A7pC9wSElq25Yi+0WNlpcK4osDgwy6HdKRdCiUd4zr4IWCMNO
         wXQ8sO1ALzWI7c1FqeAUw1p25F0vUAzcZ7UUB92wVWT90oy9FJLkCmeEdot8uS2DYKVT
         Yn+g==
X-Gm-Message-State: ACgBeo0brRYrR5BFRQexEE8VPVVMwDZJ1WHTiFjG1wyJbbUERssDZsJt
	iN/GZGIb0ruPOtvv86bOtxb6h4KP4yYP6IUSWENJxz5aFjjKdA==
X-Google-Smtp-Source: 
 AA6agR5Qf5d8TLm0/BNMvbHs9c7nnNm+fYxJfO7yzWcfgmlxGnUu6OH1R6iUiC+1f/Ff0kVqh4J2DVSrSW0k/O4zjxA=
X-Received: by 2002:a05:6870:e313:b0:10e:757c:d388 with SMTP id
 z19-20020a056870e31300b0010e757cd388mr2928798oad.280.1659573015585; Wed, 03
 Aug 2022 17:30:15 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 4 Aug 2022 09:29:39 +0900
Message-ID: 
 <CAODzB9rgMexvLjE=WuTm+SN8SfUggaZgWG-aBcy6cotppju6mw@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Aug 2022 00:30:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9105

Hi !

It's this week's CVE report.

This week reported 5 new CVEs and 4 updated CVEs.

* New CVEs

CVE-2022-36946: kernel panic when sending nf_queue verdict with 1-byte
nfta_payload attribute

CVSS v3 score is not assigned.

A remote attacker to cause DoS when sending nf_queue verdict with
1-byte nfta_payload attribute.
In the nfqnl_mangle(), there was an insufficient data length check
that will result a kernel panic.

Fixed status
mainline: [99a63d36cb3ed5ca3aa6fcb64cffbeaf3b0fb164]
stable/5.10: [440dccd80f627e0e11ceb0429e4cdab61857d17e]
stable/5.15: [91c11008aab0282957b8b8ccb0707d90e74cc3b9]
stable/5.18: [883c20911d6261fc651820b63a77327b8c020264]
stable/5.4: [52be29e8b6455788a4d0f501bd87aa679ca3ba3c]

CVE-2022-36123: x86: Clear .brk area at early boot

CVSS v3 score is not assigned.

Kernel is vulnerable if kernel contains commit 8b87d8c
("x86/entry,xen: Early rewrite of
restore_regs_and_return_to_kernel()").
This vulnerability was affected to Xen PV guest.

Fixed status
mainline: [38fa5479b41376dc9d7f57e71c83514285a25ca0]
stable/4.14: [a24eebede57ff42d5123cca948c5077ccddbffcb]
stable/4.19: [36e2f161fb01795722f2ff1a24d95f08100333dd]
stable/4.9: [b3d7c509bcbd4384d4964dcdf028b3c3e0adb7f7]
stable/5.10: [136d7987fcfdeca73ee3c6a29e48f99fdd0f4d87]
stable/5.15: [26bb7afc027ce6ac8ab6747babec674d55689ff0]
stable/5.18: [2334bdfc2da469c9807767002a2831274b82c39a]
stable/5.4: [a3c7c1a726a4c6b63b85e8c183f207543fd75e1b]

CVE-2022-20158: mm: backing-dev: Take a reference to the bdi in use to
prevent UAF

CVSS v3 score is not assigned.

AOSP kernel 4.14 contains following 2 patches.
- 69e8f03c5ced3e4e6fb4181f4dac185104e3420b ("mm: backing-dev: Take a
reference to the bdi in use to prevent UAF")
- 80d91b86a199798ee2321a0ab0f09e6e12764678 ("fs: explicitly unregister
per-superblock BDIs")

The first commit 69e8f03("mm: backing-dev: Take a reference to the bdi
in use to prevent UAF") is not merged in the mainline and stable
kernels.
Commit 80d91b8 was merged in 5.16-rc1(commit hash is
0b3ea0926afb8dde70cfab00316ae0a70b93a7cc) which requires commit
c6fd3ac ("mm: export bdi_unregister") that exports symbol of
bdi_unregister().

Fixed status
mainline: [0b3ea0926afb8dde70cfab00316ae0a70b93a7cc]

CVE-2022-20368: net/packet: fix slab-out-of-bounds access in packet_recvmsg()

CVSS v3 score is not assigned.

This bug was introduced by commit 0fb375f ("[AF_PACKET]: Allow for > 8
byte hardware addresses.") which was merged in v2.6.14-rc3.
So, 4.4 kernel will be affected by this bug too.

Fixed status
mainline: [c700525fcc06b05adfea78039de02628af79e07a]
stable/4.14: [b1e27cda1e3c12b705875bb7e247a97168580e33]
stable/4.19: [a33dd1e6693f80d805155b3f69c18c2f642915da]
stable/4.9: [b9d5772d60f8e7ef34e290f72fc20e3a4883e7d0]
stable/5.10: [70b7b3c055fd4a464da8da55ff4c1f84269f9b02]
stable/5.15: [a055f5f2841f7522b44a2b1eccb1951b4b03d51a]
stable/5.4: [268dcf1f7b3193bc446ec3d14e08a240e9561e4d]

CVE-2022-20369: media: v4l2-mem2mem: Apply DST_QUEUE_OFF_BASE on MMAP
buffers across ioctls

CVSS v3 score is not assigned.

This issue was introduced in 2.6 era.
Patch is not backported to 4.x series yet. Applying the patch was
failed to 4.x series.

Fixed status
mainline: [8310ca94075e784bbb06593cd6c068ee6b6e4ca6]
stable/5.10: [8a83731a09a5954b85b1ce49c01ff5c2a3465cb7]
stable/5.15: [48d00e24822e4384edcee3aae03d54c1b7982eba]

* Updated CVEs

CVE-2022-21505: Kernel lockdown bypass bug

Stable 5.10, 5.15, 5.18, and 5.4 kernels were fixed. 4.x series are
not affected this issue.

Fixed status
mainline: [543ce63b664e2c2f9533d089a4664b559c3e6b5b]
stable/5.10: [ab5050fd7430dde3a9f073129036d3da3facc8ec]
stable/5.15: [0e66932a9dc9ba47e60405b392e3782a332bc44e]
stable/5.18: [f67ff524f283183c52d2575b11beec00cc4d5092]
stable/5.4: [ed3fea55066b4e054c4d212e54f9965abcac9685]

CVE-2022-29900: Information leak through mispredicted returns on AMD processors

Kernel 5.10 was fixed this week.

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

CVE-2022-29901: Information leak through mispredicted returns on Intel
processors

Kernel 5.10 was fixed this week.

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

CVE-2022-36879: xfrm: xfrm_policy: fix a possible double
xfrm_pols_put() in xfrm_bundle_lookup()

Stable 4.14, 4.19, 4.9, 5.10, 5.15, 5.18, and 5.4 kernels were fixed this week.

Fixed status

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

