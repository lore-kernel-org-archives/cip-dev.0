Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD7FC43334
	for <webhook@archiver.kernel.org>; Wed, 22 Jun 2022 23:48:35 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52])
 by mx.groups.io with SMTP id smtpd.web09.1597.1655941707131906232
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jun 2022 16:48:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=HRNExvRJ;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.52,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-1048b8a38bbso7810446fac.12
        for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jun 2022 16:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=GvxOLEadd2Wa5rvc2/NsyZDWaK/KFlJzwZEbs6J1A7M=;
        b=HRNExvRJvf4AoT0W+7VMjroDCqIdaJ67C4FPmKkCoOPHHJKsekcken1OQ42X/Fk+AE
         hQaivjqQj9uuezWSERdJ9x/MBLbp1AG2EWmsivEpx4WXmU0bD1OSdeZvnV6aMEWSzY/X
         23rlrQWwaeZu6J5hZH85/hRdt53fB7m6bKO04qxenl6w6d+ZotNbgTxWUlJjNZDoe+nz
         OtQ4an2eo1TaYoMZgIOpCb5jfXeVOSGFNc8Zwr3NkQbRYScZbek101rBTtzJFQvmCCyN
         r1Uw+952SjhDT9tCaopKNLjQS9Tixb4BzRIibHeJ/8dsNSTBxULInIUPc+mjBUWEL5D/
         PUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GvxOLEadd2Wa5rvc2/NsyZDWaK/KFlJzwZEbs6J1A7M=;
        b=vyKzSfSYMSfn1go3UVTHVm7p/X+yZGFEH9SQJ8cYyPoUKfBAwtr2sqeq573w0LDYjT
         sqquBXlKf9f3XCPg+ceBkwhBnMz/1Uc67mXfgVg/3OY16oKmineQFBWc3k61lSPB/wKH
         KslVxmCTf1yNjk1mxZUGheWvTxZ/ivJMtfaVi/5kvSBjqP+RTbsBW3Im3bE3j4MD8SgC
         E2w6A/U2JpWEynvyNAyeBdFY9X6IWDs4JTiHJZ8hq6dS7OoobAxFkAyicDVtGZq1ELiO
         hiEcAahJ7/7mJ9XtdF8upDrXXcLy4tKmG9d4c9unKazeoR66jPWdb/qiHuuUqKgwqzyy
         Vl8g==
X-Gm-Message-State: AJIora8CoOggokL1OSmdDIKijD9P2HmIz4Uv98UbvRVtIEq1EjOhNQcr
	vuDh+ghDjK+r/a9uJZXVF6QsQa2E5WlitbQbKZaHMGm3B359cKkx
X-Google-Smtp-Source: 
 AGRyM1v7wBlWn4ceNbahLyjsJmr3eo6zgYHb1vWMyrE50SkHxi164IrKx7lqDZ1RfduxkP16pBtpffJyNT1uUZp5YTA=
X-Received: by 2002:a05:6870:9a18:b0:101:3954:9730 with SMTP id
 fo24-20020a0568709a1800b0010139549730mr581181oab.253.1655941706011; Wed, 22
 Jun 2022 16:48:26 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 23 Jun 2022 08:47:50 +0900
Message-ID: 
 <CAODzB9r=+_3kvTpbXWznSGfsc4GT5X17JT0u_o+2q228jqDXkw@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jun 2022 23:48:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8584

Hi !

It's this week's CVE report.

This week reported 6 new CVEs and 4 updated CVEs.

* New CVEs

CVE-2022-2078: Add several sanity checks for nft_set_desc_concat_parse().

CVSS v3 score is not assigned.

A buffer overflow bug was found in nft_set_desc_concat_parse(). This
bug allows an attacker to system crash or possibly execute run code.
This issue was introduced by commit f3a2181 ("netfilter: nf_tables:
Support for sets with multiple ranged fields") in 5.6-rc1. This commit
isn't backported to earlier than 5.6 kernels.

Fixed status
mainline: [fecf31ee395b0295f2d7260aa29946b7605f7c85]
stable/5.10: [c0aff1faf66b6b7a19103f83e6a5d0fdc64b9048]
stable/5.15: [89ef50fe03a55feccf5681c237673a2f98161161]
stable/5.18: [c9a46a3d549286861259c19af4747e12cfaeece9]

CVE-2022-21166: Device Register Partial Write (DRPW)
CVE-2022-21125: Shared Buffers Data Sampling (SBDS)
CVE-2022-21123: Shared Buffers Data Read (SBDR)

CVSS v3 score is not assigned.

CVE-2022-21166, CVE-2022-21125, and CVE-2022-21123 are related to
"Processor MMIO Stale Data Vulnerabilities are a class of
memory-mapped I/O (MMIO) vulnerabilities".
Please refer to the document
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
 for more details.

These vulnerabilities were fixd in a merge commit
https://github.com/torvalds/linux/commit/8e8afafb0b5571b7cb10b529dc60cadb7241bed4
.
This merge commit includes 11 commits. All of them were applied to all
stable kernels.

Fixed status
mainline: [4419470191386456e0b8ed4eb06a70b0021798a6,
51802186158c74a0304f51ab963e7c2b3a2b046f,
  f52ea6c26953fed339aa4eae717ee5c2133c7ff2,
8cb861e9e3c9a55099ad3d08e1a3b653d29c33ca,
  e5925fb867290ee924fcf2fe3ca887b792714366,
99a83db5a605137424e1efe29dc0573d6a5b6316,
  8d50cdf8b8341770bc6367bce40c0c1bb0e1d5b3,
22cac9c677c95f3ac5c9244f8ca0afdc7c8afb19,
  a992b8a4682f119ae035a01b40d4d0665c4a2875,
027bbb884be006b05d9c577d6401686053aa789e,
  1dc6ff02c8bf77d71b9b5d11cbc9df77cfb28626]
stable/4.14: [62cf367c5fd1af75e005495ddcacde0f5eab85f0,
c00f2194c05c30a5f2f6a38d1555a8c6a9694cff,
  ba0a1237c5ef0479d8799f9435ba04c4e022bbd8,
d6087dda37d3ffa3c8efe6385757d73d9ed173c5,
  87e9881d5ad3d06cb8278062ecdafb4a5b5f423b,
e0fccc13ebe3ed1205f69d119d49789ef039c1fd,
  ae620928044d93e1ab9b785e931854ee033e52c7,
ed4fa7697ca4039eed5142c983c5905e46039c36,
  532c3a51316b6b1fdc6cb01926e2d139ef7e25da,
ac87ab4460f35b5064b2b9db1be146def2941fee,
  66b7fb8b6de97d02255611eb83a0a64d88f01710]
stable/4.19: [2bb1c263b6797e2701a5f4ffe503a8ce15c0167e,
9277b11cafd0472db9e7d634de52d7c5d8d25462,
  d03de576a604899741a0ebadcfe2a4a19ee53ba3,
9f2ce43ebc33713ba02a89a66bd5f93c2f3a82cf,
  54974c8714283feb5bf64df3bfe0f44267db5a3c,
8b42145e8c9903d4805651e08f4fca628e166642,
  f2983fbba1cccac611d4966277f0336374fad0be,
3ecb6dbad25b448ed8240f0ec2c7a8ff5155b7ea,
  0e94464009ee37217a7e450c96ea1f8d42d3a6b5,
e0d1437042f0b491bf2cb7880628b0bd7783f80d,
  0255c936bfaa1887f7043b995f1c9e1049bb25f1]
stable/4.9: [63c10e92b86a6cddd5294cda9f80eb7961cb1046,
19aa53c9eb2cf3a78ee44800e20bb34babe60f45,
  91ab1073814aa5d44fb3d8e2423ffdc61a421cac,
a11f2f05f5c605d1f6573b0cdcd2a6f38667fda1,
  5da4d16872d3d15dac54b5a6f83f54e28bc3a477,
6ecdbc9dc777a5b66a9ec293af88ab330dd644a2,
  8acd4bf9427eaf18a801db3f2508a2d89914d51d,
48e40e2cccb37c1f9c345014ca55c41bb8baee66,
  b7efb3a62fffa509e21d076aa2e75331c79fe36d,
da06c60d1dfef826512068d09aed3b6a70b5e5c9,
  71078b82164e36c893dc0764866e3783b1988fb4]
stable/5.10: [f8a85334a57e7842320476ff27be3a5f151da364,
e66310bc96b74ed3df9993e5d835ef3084d62048,
  f83d4e5be4a3955a6c8af61ecec0934d0ece40c0,
26f6f231f6a5a79ccc274967939b22602dec76e8,
  56f0bca5e9c8456b7bb7089cbb6de866a9ba6da9,
3eb1180564fa0ecedc33b44029da7687c0a9fbf5,
  001415e4e626403c9ff35f2498feb0021d0c8328,
cf1c01a5e4c3e269b9211ae2ef0a57f8c9474bfc,
  6df693dca31218f76c63b6fd4aa7b7db3bd6e049,
bde15fdcce44956278b4f50680b7363ca126ffb9,
  aa238a92cc94a15812c0de4adade86ba8f22707a]
stable/5.15: [1fcc3d646f0b719a2571aa68e4983c7a96fdc806,
d822b10f97f6bf83fcde3ed56caa58cde562eedd,
  8b9521e711799f6260765209d5562fe6e6fbf3fc,
d74f4eb1ddf076a55ff0682a89e66af5c1974321,
  407d97b99f276c7a761b905891a9d7a0fb727730,
2044838ab2283c23869ffa7b062e5f388136e432,
  531eb5fe3171f11cece79c7aac28bb5a085fb3fa,
30120b433c1f53cd0a081e6e86fe016a60a423fc,
  ebd0f558b48082c265fd594ffb205ae5350bfe79,
59d665a709b0446957261e8875ac9f7eb1bb1e96,
  147ae04a7c52e8cec0b81b1057c13fc29dab143a]
stable/5.18: [2a00e432ef05d813956e811718e828076b3f3027,
d88769c6dd78a77c049a55d4d39542648740321f,
  647afa778f7a98be3c690e579211d26d051fabfc,
bc4d37b2338a32a6668d94803feebc9cbc85572e,
  e3718d0753ff30f93e3cb9dccc26b0452f90c6b1,
8547d4ae6a95543b69d523f3706dbf887496e9f3,
  1baf738f30ee91be35003b0d106190ba8bfa8f1c,
bafc2b2727b4ebd219b112e87143cf0cf136d3fa,
  dce28a791e9632f96ba018f2ef708e012edb4133,
0b4bd3f44c674ba215f8f7918e4145d045bf5396,
  4064fc1ce85e4066a5aa97186766b71fe5f303d1]
stable/5.4: [91f8147c8371cb228bef738641abcd183d7adaf1,
814ccb6730358c2e30e00cb81fb84f4d480ff34f,
  ae649e0cbf76c665cf3a92dc16ddef27789b0447,
0800f1b45bf6d85e5a168db9ae91fb816f0a8c34,
  7f898baa2044094accfbe49c846f50fecc58e043,
8d25482fc96aa2cb24a221295fdd498f40565415,
  020ce7495cfccec17693bf58b42282707dece24d,
bc64f38b5a3839f14896cb9e2de7614d47151fc3,
  d961592635932bd1ea32a534412a41fb794e2212,
d49c22094e6f698a86dfdfd8f22b2a220e797bd4,
  4cc40b1022bbfe6da2dda489006b7ab6548bcd61]

CVE-2022-33981: floppy: disable FDRAWCMD by default

CVSS v3 score is not assigned.

It is duplicated of CVE-2022-1836.
A use-after-free bug was found in drivers/block/floppy.c which will
result denial of service.

Fixed status
mainline: [233087ca063686964a53c829d547c7571e3f67bf]
stable/4.14: [b7fa84ae1171a3c5ea5d710899080a6e63cfe084]
stable/4.19: [0e535976774504af36fab1dfb54f3d4d6cc577a9]
stable/4.9: [0dd02ff72c6daf4e7800fb5dd1109fbacdde97dc]
stable/5.10: [54c028cfc49624bfc27a571b94edecc79bbaaab4]
stable/5.15: [e52da8e4632f9c8fe78bf1c5881ce6871c7e08f3]
stable/5.4: [7dea5913000c6a2974a00d9af8e7ffb54e47eac1]

CVE-2022-2153: KVM: NULL pointer dereference in kvm_irq_delivery_to_apic_fast()

CVSS v3 score is not assigned.

This vulnerability was introduced by commit 1e08ec4 ("KVM: optimize
apic interrupt delivery") that was merged in 3.7-rc1.
There is a NULL pointer dereference bug in
kvm_irq_delivery_to_apic_fast() that triggers local DoS.

Commit 7ec37d1 (KVM: x86: Check lapic_in_kernel() before attempting to
set a SynIC irq) and commit 00b5f37("KVM: x86: Avoid theoretical NULL
pointer dereference in kvm_irq_delivery_to_apic_fast()") are failed to
apply to 4.14, 4.19, 4.9, 5.4, and 5.10.

Fixed status
mainline: [7ec37d1cbe17d8189d9562178d8b29167fe1c31a,
00b5f37189d24ac3ed46cb7f11742094778c46ce,
  b1e34d325397a33d97d845e312d7cf2a8b646b44]
stable/4.19: [2f4835b5188f3b73b2b048a761ae2553e845b027]
stable/4.9: [95d51d058680766130098287f680474bc55f1679]
stable/5.10: [09c771c45c1243e295470225aaee726693fdc242]
stable/5.15: [569a229142e95610adc1041ae9ca1f417c4c6a3e,
0e5dbc0540baa89faf4c04ccc7e9c4fe6b1d7bf4,
  ba6e8c2df52047a32953588b49d9addbd843a098]

* Updated CVEs

CVE-2022-1353: af_key: add __GFP_ZERO flag for compose_sadb_supported
in function pfkey_register

stable/4.9 was fixed this week.

Fixed status
mainline: [9a564bccb78a76740ea9d75a259942df8143d02c]
stable/4.14: [fcdaaeb7eb5d52941ceb2fdcec0e2170c9bf3031]
stable/4.19: [693fe8af9a2625139de07bd1ae212a7d89c37795]
stable/4.9: [7b0e01a9b7f2aaeb6fa73b35864b1d7dc6e795c4]
stable/5.10: [8d3f4ad43054619379ccc697cfcbdb2c266800d8]
stable/5.15: [d06ee4572fd916fbb34d16dc81eb37d1dff83446]
stable/5.4: [ef388db2fe351230ff7194b37d507784bef659ec]

CVE-2022-1976: io_uring: reinstate the inflight tracking

stable/5.18 was fixed this week.

Fixed status
mainline: [9cae36a094e7e9d6e5fe8b6dcd4642138b3eb0c7]
stable/5.18: [bba36a27c38650eefc79d18c33a0acd0dcbeabb8]

CVE-2022-1508: io_uring: reexpand under-reexpanded iters

Added fixed commit to stable/5.10.

Fixed status
mainline: [89c2b3b74918200e46699338d7bcc19b1ea12110,
2112ff5ce0c1128fe7b4d19cfe7f2b8ce5b595fa]
stable/5.10: [8adb751d294ed3b668f1c7e41bd7ebe49002a744]

CVE-2022-1184: use-after-free and memory errors in ext4 when mounting
and operating on a corrupted image

The mainline and stable kernels were fixed this week.

Fixed status
mainline: [46c116b920ebec58031f0a78c5ea9599b0d2a371,
3ba733f879c2a88910744647e41edeefbc0d92b2]
stable/4.14: [d27d3caddbeff10871982d5e25e6557be0fdc29a,
24b8206fec1db21d7e82f21f0b2ff5e5672cf5b3]
stable/4.19: [78398c2b2cc14f9a9c8592cf6d334c5a479ed611,
b3ad9ff6f06c1dc6abf7437691c88ca3d6da3ac0]
stable/4.9: [93bbf0498ba20eadcd7132bd3cfdaff54eb72751]
stable/5.10: [da2f05919238c7bdc6e28c79539f55c8355408bb,
ff4cafa51762da3824881a9000ca421d4b78b138]
stable/5.15: [ca17db384762be0ec38373a12460081d22a8b42d,
3a3ce941645407cd0b0b7f01ad9e2ea3770f46cc]
stable/5.18: [298659c0e7074f774a794fc293df4014617b87be,
6084240bfc44bf265ab6ae7d96980469b05be0f1]
stable/5.4: [17034d45ec443fb0e3c0e7297f9cd10f70446064,
e157c8f87e8fac112d6c955e69a60cdb9bc80a60]

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

