Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C453AC04A68
	for <webhook@archiver.kernel.org>; Wed, 27 Jul 2022 23:46:03 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web11.26924.1658965556774202748
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Jul 2022 16:45:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=FdK1ZVso;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.51,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f51.google.com with SMTP id
 y10-20020a9d634a000000b006167f7ce0c5so160786otk.0
        for <cip-dev@lists.cip-project.org>;
 Wed, 27 Jul 2022 16:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=HLlYq+6K09CnlQj+BHRmPxl2WUzlTBOcRGPeo46/RH4=;
        b=FdK1ZVsoTKUOjooVARpaO8V+YtQzejJBDRKBZfxjefHARrTzCarkz1Irf5n8Gd+5Od
         6eEeUcAOExLcGX3vK9Z32yCuDpwTS1dzVFaGYyfqcOhsV2L/3Pf760euzs+UMTM0GTLY
         ROefsFMvyzB6VxmE3pCHZAXZgnQB/YTIulacVpqtjxOQpTrI02ZZQXp/w8Q8Wfkbu6Mz
         tn0qkg4Y3YSc0aBrah5Os32yUt6veDDtgFG/vyXZFWKECPk9XdRQKGzGaakglP3W35bN
         XWqsiyR41yle9+HZKn1NDdb8TnjYznC8NaG40HccxQQ9oUmwm8eG2xRtb4W+cv3eX97s
         2yWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=HLlYq+6K09CnlQj+BHRmPxl2WUzlTBOcRGPeo46/RH4=;
        b=k+T75aCnimf83oDlcF8W4wfQxV+gw+vH+9J6yTsWzb6ywU+ybEhDpL/Rdfs64kBKuL
         DfR10Mf++pcxJxgsiK9D3qoPs6Lr4JhcXoHmdqO706j1DJqb9Zvv02zMCoMgJwMXmK0D
         QCZ4RL64DqdAWIUyxvrRrHmo+vP+QpQgsAvEq3YxKGX+OAGJqLJThFd6GYn1gdOPOQbv
         8Fbf8IK9EAaLRlpuVoZWM9qFHy9I4A2gm1EPmdOrOdPYsqBKspDsRrhvb+hu3iGzwOhe
         O9q9EY/NoiEgCoTrJGp3c45nwu3rVku6KrOHWCh+ge4yGcXk6nOJF1KrP4+YQwuimXiM
         wEug==
X-Gm-Message-State: AJIora9YC4DBxMzmCysHQVMKePBs3yKQW1u6sZGWKPC1eKaUBOB0S8Sy
	7JxiZgjQL0cBVMK7jrxHQfiywC31G2n24pgWMMPxBrNT0fh9EQ==
X-Google-Smtp-Source: 
 AGRyM1s4lcsQeUFszLztGmutsrZJX+TOTyTpnR2pgNknu/l7DFP//g6XEXsclSvSHoOLU9j2i7cdLBTqwzzDOSBZkFk=
X-Received: by 2002:a9d:4902:0:b0:61c:cd51:4f8b with SMTP id
 e2-20020a9d4902000000b0061ccd514f8bmr9409683otf.96.1658965555407; Wed, 27 Jul
 2022 16:45:55 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 28 Jul 2022 08:45:19 +0900
Message-ID: 
 <CAODzB9rEkvU-Cznm2TJQpikRp-rUTcMt+B4Ztbs+ELtt-ENgNw@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Jul 2022 23:46:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8956

Hi !

It's this week's CVE report.

This week reported 5 new CVEs and 5 updated CVEs.

* New CVEs

CVE-2020-36557: A race condition in the Linux kernel before 5.6.2
between the VT_DISALLOCATE ioctl and closing/opening of ttys could
lead to a use-after-free.

CVSS v3 score is not assigned.

When a user passes VT_DISALLOCATE command via ioctl() while
tty_release() is still running, causing a use-after-free in
con_shutdown().

This vulnerability was fixed by commit ca4463b ("vt: vt_ioctl: fix
VT_DISALLOCATE freeing in-use virtual console") which was merged in
5.7-rc1.

Fixed status
mainline: [ca4463bf8438b403596edd0ec961ca0d4fbe0220]
stable/4.14: [b9eb60a0ef3971101c94f9cddb09708c2f900b35]
stable/4.19: [54584f79579b9f6ed49b93cadcd2361223ecce28]
stable/4.9: [6bc9bf78618edf42b31cb7551fb0c83af340c54f]
stable/5.4: [acf0e94019310a9e1c4b6807c208f49a25f74573]

CVE-2020-36558: vt: vt_ioctl: fix race in VT_RESIZEX

CVSS v3 score is not assigned.

There was a race condition bug in vt_ioctl() while processing
VT_RESIZEX ioctl command. This race condition bug could lead system
crash because of a Null pointer dereference.

This vulnerability was fixed by commit 6cd1ed5 ("vt: vt_ioctl: fix
race in VT_RESIZEX") which was merged in 5.6-rc3.

Fixed status
mainline: [6cd1ed50efd88261298577cd92a14f2768eddeeb]
stable/4.14: [69931c044c9de837602cfd4bcfc28123ce4987e2]
stable/4.19: [ec9645f1a77eab98951944273754307e192e69ae]
stable/4.9: [160fbca8d5d74c1a4cec4b666f36b3e614c19f4f]
stable/5.4: [897d5aaf3397e64a56274f2176d9e1b13adcb92e]

CVE-2022-2209: A use-after-free bug was found when executing IORING_OP
CVE-2022-2327: A double free bug was found when executing IORING_OP

CVE-2022-2209 and CVE-2022-2327 were fixed by commit df3f3bb
("io_uring: add missing item types for various requests").

CVE-2022-2209
NIST: CVSSv3 Score is not assigned.
CNA: 7.8 HIGH

CVE-2022-2327
NIST: CVSSv3 Score is not assigned.
CNA: 7.5 HIGH

It seems as if CVE-2022-2209 and CVE-2022-2327 have same root cuase
that is why they were fixed by commit ("io_uring: add missing item
types for various requests"). The flag IO_WQ_WORK_FILES was merged in
5.10-rc1 commit 0f20376 ("io_uring: pass required context in as
flags") and has been removed since 5.12-rc1dontuse commit 44526be
("io_uring: remove any grabbing of context") so 5.10  kernel was only
affected by this vulnerability.

The commit df3f3bb ("io_uring: add missing item types for various
requests") had kernel panic bug. This kernel panic bug was fixed by
commit fb2fbb3 ("io_uring: use separate list entry for iopoll
requests").
The io_uring feature has merged since 5.1 so 4.X kernels are not affected.

Fixed status
stable/5.10: [df3f3bb5059d20ef094d6b2f0256c4bf4127a859]

CVE-2022-36879: xfrm: xfrm_policy: fix a possible double
xfrm_pols_put() in xfrm_bundle_lookup()

CVSSv3 Score is not assigned

The xfrm_pols_put() put policies via xfrm_pols_put() when
xfrm_expand_policies() returns error. However, xfrm_expand_policies()
already called xfrm_pols_put().

Fixed status
mainline: [f85daf0e725358be78dfd208dea5fd665d8cb901]

* Updated CVEs

CVE-2021-33655: When sending malicous data to kernel by ioctl cmd
FBIOPUT_VSCREENINFO,kernel will write memory out of bounds

Added patch to 4.19 and add more patches to 5.10.

Fixed status
mainline: [e64242caef18b4a5840b0e7a9bff37abd4f4f933,
65a01e601dbba8b7a51a2677811f70f783766682,
  6c11df58fd1ac0aefcb3b227f72769272b939e56]
stable/4.19: [eae522ed28fe1c00375a8a0081a97dce7996e4d8]
stable/5.10: [cecb806c766c78e1be62b6b7b1483ef59bbaeabe,
b727561ddc9360de9631af2d970d8ffed676a750,
  b81212828ad19ab3eccf00626cd04099215060bf]
stable/5.15: [9c9e44bb3dd5233232f2379c2dde0e403b1fd642]
stable/5.18: [365b729e36ca942f4d2d184afc8486017504a597]
stable/5.4: [af93e821973426ded00158ea66a977039483997e]

CVE-2022-21505: Fix kexec lockdown bypass with ima policy

The mainline was fixed this week.

Fixed status
mainline: [543ce63b664e2c2f9533d089a4664b559c3e6b5b]

CVE-2022-23816: Mis-trained branch predictions for return instructions
may allow speculative code execution under certain microarchitecture-
dependent conditions on some AMD processors..

5.18 was fixed this week.

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

CVE-2022-29900: Information leak through mispredicted returns on AMD processors

stable/5.18 was fixed this week.

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

stable/5.18 was fixed this week.

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

