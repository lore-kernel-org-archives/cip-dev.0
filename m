Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06B1C61DD6
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 22:27:56 +0000 (UTC)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7772.1788388068604017287
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 15:27:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=z8XGeKbb;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.53, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66cf1f9965dso1332764d50.1
        for <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 15:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788388067; cv=none;
        d=google.com; s=arc-20260327;
        b=TVfDZMqr1U7vLWuujTm5SifiibUVtJRVc9r5z41T5dYrtxNp+2EIaLfgZfXV5PARev
         yNsyesk1h/NdHuusmbPs46ONwQZ60Z9WA35dgL+dRSGHaFkoZb0wK4XIQbII8M/RBS98
         at2qAcqgaGGSFzYgggljV0hzKftkaCFoTddjfL+rPCbJ4VkboELZxnMuNyPbkcrllukm
         wa8M4bG03os+Rn0ptmjtxwJKndPBGyYe/5UpSS66LufQ8N6JLkYsfoN4biT/qL33xqJ3
         39sIGTcxWl8bgaGK+0fXSMJ93TG16PhBmfTdL446db/5nFdnCpX6mBYuuGUvbyjArot3
         q4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DUYZSY4GGrammHfAqlTAVKt7uYdzD7jQlQem5BPuCO0=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=kK2oYEgpo1dT10LKu41kzQK+iT/gcSYVzieVuBa1IVYKLi5Bbsw/hX9JNe/PuI84ur
         VWwwT1QAGK6XZ0MUCOMrVXZEGtWlEhQRxnqWO4PWxoBlGLfUAQt5Ev9tB1QLK6TlGUzb
         HvyQbna7bIwqaCv3mNf4ZM032oQKsuN0EYJZwrjkyqV22Ph5mzZkLbMtMGiVXX2S7tCk
         FolfV3GW7l0x2fPCWoFyoLDpoNEtIwq1sqH2o6ZqndUbftmA4dLIzi0PQ5rRTSNFdpPX
         NmAqvvIuDjlHY0xf2pgu/1s1U5rZKaYUMWNvDgGIR2grWlDfM16jnKZLYEk/ZAx1SG5s
         nELA==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1788388067; x=1788992867; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DUYZSY4GGrammHfAqlTAVKt7uYdzD7jQlQem5BPuCO0=;
        b=z8XGeKbbGIFkP7EMaDrk/ZIZx6LKb7drFyTfnTPAySF40eEMnT+kLloz8dqAIATXhM
         k0dlR0Xq+cWLiwlYrbhej32JIb4cNdUGiwy5/qN+QrXMtwMtUc7BOE3lywIl9/PCNUqE
         ZzxXefCgm9Muep7uayZ/rQWNUouR4iCAHALJqGB36JTOeql9K06tLMEiHtYnE61Enu3h
         5q+8brdpRNZ5eGLlF3cxKVXB8yVjtHskBqTkqHMc5YP0qdXRAJo7NI9ZPTv+JlW45E0C
         EINvg2vszOw6OnyzsasMe2uluiwut6GUbqE/ZyBGjZF3fzu4KZczPPauI2lOWuugf3ZP
         bcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788388067; x=1788992867;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DUYZSY4GGrammHfAqlTAVKt7uYdzD7jQlQem5BPuCO0=;
        b=fl9HrKT0NWJGKtzpUYQqLtLF2l3CIFfjGlflzaw1z2JrOvcNABQu8j89V8Ma6d1rN7
         cfnSloeCRMo1JlkmF7gEmNYtPgQObaRMYrYvGiyKzkwHfukw32Mw+8noBXerqQ9z2HVV
         50Ndp0x0AsW1QmsYuJdqavesGMquSmle98IxGjTeObocCtmF7L72nz345Pg2gM/eiDyB
         sT4kkvBWhiD4T3/kcpI8vXNjcji+6SdSu4UJCTmthLE5uT3V3QeqKbsdPiZHBqilRINk
         P2ihX9FQtcjG/gptUECFDmHGkdV9XuJz6WgI3geXd2JbEyboD+i+XQDS6PhAEAjpVp2Q
         7BEQ==
X-Gm-Message-State: AFuF++nk1J882rbffap8hqPir/YB1SSEVIj5nimV7EGy/HgxyL4hwUoK
	PcYH5fevs5Eto6+WyfRawp4zcF6mscmc97RoF71y5vzQKJrXDxmAPA0r5qieLRUyKX+wXQsVAKa
	HPzKCQIPkQTn/6UNocx6NaBLRD0cRlYh8BvIcWAyXysGKaraEMouDKrzfFA==
X-Gm-Gg: AYBFou0ieKccF0nuzNg2tYyiK1BH6DmobjAW+wBBO32UWnvqAIuKcsuY4hqBFvTFTmn
	arI1K+DH1xuZFD1h42wtK2vB6nuUZMfoahe1FzvIolpoP7LwZv/OaeKLDmGnv30wPLPkJFUHnaw
	VKn1RSgdSXNrZSoVZGGdcd+Fy6sh+V8rDFIL4uJQVMuHdABigSeb4b1SJBJkEJwP65UlinUrcoK
	IiZV2mU1tFxsgulYnhUdkg00BrdJobT172B6csTP9U2ransPwvmNJUUJD0n3hTaGt+JIfcqNMJ8
	NXKvfeUFksuTSPkpI0kd4IuH2HW/8dnAUj3ivYrg21n8r7VTZndGqFwhA2CvfrOgxCOrP/jBySt
	kpHwqHkzrHc6sFzgNqYoLtFp2sPM=
X-Received: by 2002:a53:df4e:0:b0:66d:1a5a:1d27 with SMTP id
 956f58d0204a3-66f9bb9f915mr2414684d50.12.1788388065275; Wed, 02 Sep 2026
 15:27:45 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 3 Sep 2026 07:27:09 +0900
X-Gm-Features: AcwNN1X9CTCS1bZcbCQgu6PxwGIovNvMQ9wab97lfNbsUmKscCiyPOXaThkhgjM
Message-ID: <CAODzB9qMU5a96VMyzd8xzZTbBHKtGAWwQWCWsbTehMK7+K6ncw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 22:27:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24084

Hi!

It's this week's CVE report.

This week reported 136 new CVEs and 69 updated CVEs.

* New CVEs
CVE-2026-80590: inet: frags: strip GSO state from fragments before reassembly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80590

Introduced by commit f43798c ("tun: Allow GSO using virtio_net_hdr").
Fixed by d5dc1e6 ("inet: frags: strip GSO state from fragments before
reassembly") in master.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5dc1e69fd7258ea605c9952e5d5947539159ae3]
stable/5.10: [cfdbc8c2e6f9ef5d8b8e54859da03dfe682b0bee]
stable/5.15: [29dda278a5ed272f2230ff4eaa23cf403107bba0]
stable/6.1: [14a8f3e10fa9a5abd6cedcdaa0c0b7ea9a09f234]
stable/6.12: [dec2edb7aaf12a8878b3a03172ea8fc277b8eaad]
stable/6.18: [c49f04e8d2b94dbb8d9fd99731dd3f00589c8ace]
stable/6.6: [3edf721bb4b99d272c336631b44e3d8ff9a4f31b]
stable/7.1: [69b73b74d9eb45f5560a8fe4fa406ada580e1340]
stable/7.2: [da857e448322a2e871ce3ecc2900027041160d43]

CVE-2026-80591: f2fs: fix listxattr handling of corrupted xattr entries

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80591

Introduced by commit 688078e ("f2fs: fix to avoid memory leakage in
f2fs_listxattr") in v5.5-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [5ef5bc304f23c3fe255d4936472378dcb74d0e94]
stable/5.10: [7dfac47e4189692f35230f3064acf2540e6d75fe]
stable/5.15: [c8a10f174316e80d577e6549099b71a7a2111f3f]
stable/6.1: [dfa4891c27bccbd83d511a065721e85621f275a1]
stable/6.12: [7dd01f7d0291583e3e5420c95c7d584e114899bd]
stable/6.18: [ec9f79c8d5b28a928e65b67cd138c841571cf502]
stable/6.6: [2770041f34b52334ea63351ffb1cc2007a9de46e]
stable/7.1: [3c0dbfecd859fd02fe9008f33a83146102ccd9ba]

CVE-2026-80592: samples/damon/mtier: fail early if address range
parameters are invalid

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80592

Introduced by commit 82a08bd ("samples/damon: implement a DAMON module
for memory tiering") in v6.16-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7746d72c64054976887928d64d2caf25c5a6dcc0]
stable/6.18: [9d360fb820a3b9576d155e720ec44fef54d2efb5]
stable/7.1: [db20589d7b248211f63f4a7f642a49c0832b13ae]

CVE-2026-80593: hwmon: (asus_atk0110) Check package count before
accessing element

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80593

Introduced by commit 9e6eba6 ("hwmon: (asus_atk0110) Enable the EC")
in v2.6.32-rc4.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2735b39f044bad7bf2017aef248935525bc0b97]
stable/5.10: [2a137124664aad1e36d8d74e8e2207365a04737f]
stable/5.15: [459b0a0439ea65b2b612aa572eb62a2e26d05618]
stable/6.1: [768f20e7bb48d723b82cb142120263d0806fbeb8]
stable/6.12: [981a8a2e3773dc7e704943388a1fb97970b23275]
stable/6.18: [d8d4fa0c4f818e30b6f6737bdd989b7e2b511cae]
stable/6.6: [76392d35c8df471b288cfc6536bd092b3c8ee2cf]
stable/7.1: [b770fcfcdced569bcf7c6982aeea8c3d11a21c2b]

CVE-2026-80594: Input: ims-pcu - fix potential infinite loop in CDC
union descriptor parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80594

Introduced by commit 628329d (Input: add IMS Passenger Control Unit
driver) in v3.10-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4579af29e67ca8722db0a1194227f8015c8981d]
stable/5.10: [67a038c5a7c9bd8aabe6fba8ac9d2e31c0bd5a28]
stable/5.15: [6314bd9e2a6b3362998dc85485dd4b0f133a3532]
stable/6.1: [76eeeb3a8e3c13d5c0ef28666b57dcb5cc101a32]
stable/6.12: [b847f2725ef47a26b3d01eca3d54fd811e5a544d]
stable/6.18: [383934c249a9817d242d02d30bfbc8defbf0d533]
stable/6.6: [e3f93d63dcd48c1f0ba9041f2ffa8aea7170e295]
stable/7.1: [bbbe31486cf2d12177462e4a814244c2597c9849]

CVE-2026-80595: Input: ims-pcu - add response length checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80595

Introduced by commit 628329d ("Input: add IMS Passenger Control Unit
driver") in v3.10-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48c9d92fd4ee3a8f5d2cb46c802a0eff8e67c79c]
stable/5.10: [bbafb75cd9da50d86335cbd98b8b3492bb5e42a6]
stable/5.15: [3e0e8d7f8139a9496e389e7372e3f8b57b3e4e3e]
stable/6.1: [89cf4d18ff87efa5c47ba38de36aea5c03f98b05]
stable/6.12: [dc9fdb538ce5b7f32540991f4a25ab63fab7ba07]
stable/6.18: [f28c5cabb2df09ad1fcfb7cdb2b3ed2f690d81f0]
stable/6.6: [f7f5afeed31baaca0b027c2d46a25ee86fb4c9da]
stable/7.1: [f3c63aecca90be42b66cdc66de7c4a6104104d17]

CVE-2026-80596: Input: ims-pcu - only expose sysfs attributes on
control interface

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80596

Introduced by commit 204d18a ("Input: ims-pcu - use driver core to
instantiate device attributes") in v6.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [001428ea4d2c371107cb984108e266adf99f1f1e]
stable/6.12: [7d5e7c8d48f0aaeb9ec90a9a4f450f3c5e422431]
stable/6.18: [87e2f89dea078572fb9e13864cec2b1bd8e89b71]
stable/7.1: [73e6687be0c1c323a8ec5b733f29440a93e08ff2]

CVE-2026-80597: mtd: maps: vmu-flash: fix NULL pointer dereference in
initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80597

Introduced by commit 47a7268 ("mtd: flash mapping support for
Dreamcast VMU.") in v2.6.30-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [357e3b8e3a8769ba36eb8ec5e053e4825f1a9329]
stable/5.10: [ff6453502c722437e37238900c9e45a1fec34455]
stable/5.15: [c60a627edbbd66bfbb0a0f564e64084c23c7ce98]
stable/6.1: [0db62da830ec57ad3efe24337763c8bf5442c6be]
stable/6.12: [b80a7b8f1a10e9270160b9d33f1253da2195c827]
stable/6.18: [9ac007affa77c3dc3def53760e3d69c350fc9967]
stable/6.6: [44c6abf5d823de796319d6e23c282ed5b68dc41b]
stable/7.1: [f4599793240dd60a0a708ef1fe116223f47aa105]

CVE-2026-80598: ntfs3: fix out-of-bounds read in decompress_lznt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80598

According to the .vulnerable file, this bug was introduced by commit
522e010 in v5.15-rc1.
Fixed in v7.2-rc1.
Affected file was added by 522e010 ("fs/ntfs3: Add compression") in v5.15-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7160a57192fb16d7a6fa9b7f5c7ac341d2444a89]
stable/5.15: [1113fa5b01a47a1a4cdbb9c695197ca6215f02a8]
stable/6.1: [61415ffa365d2eca6986914afd0d1412444aa1dd]
stable/6.12: [c694f8ea2611e7413b3f04ee47e04a9b7b45817b]
stable/6.18: [ff05a98150ebb2b03919a9c05c576681e86abbb7]
stable/6.6: [bd77afca2ae9b6d44d37902e3ad672ebb028b070]
stable/7.1: [a93980141253c932aa6ae5d4422d90e0162dc774]

CVE-2026-80599: batman-adv: dat: ensure accessible eth_hdr proto field

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80599

Introduced by commit be1db4f ("batman-adv: make the Distributed ARP
Table vlan aware") in v3.13-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26560c4a03dc4d607331600c187f59ab2df5f341]
stable/5.10: [da3677b5ed362742d30ceab31bfafcdc74dc2642]
stable/5.15: [6d3ea37074bb747f745d28138f87745ba9bd97c5]
stable/6.1: [7913935d41f166c367bbf7cc76a79e50044388e8]
stable/6.12: [5836a050d02e9598fa0f71e88dde28b63dfa35e3]
stable/6.18: [8f76277d02176cd739945bba3379448e2e22e799]
stable/6.6: [3c62694c31f043568c3f4784b8d247cc3bea6b4c]
stable/7.1: [4407ff3af469356f9641c4a6e7072309bae86bea]

CVE-2026-80600: batman-adv: dat: acquire ARP hw source only after skb realloc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80600

Introduced by commit b61ec31 ("batman-adv: Snoop DHCPACKs for DAT") in v5.1-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48067b2ae4504500a7093d9e1e16b42e70330480]
stable/5.10: [a82fc217cb7a447313c76ebf9f09b100771b0ddf]
stable/5.15: [86aa79b43e5b561fd3648891165bd7313b541315]
stable/6.1: [d755cd001fa2c248e186c1fc3df3d11d97dc843c]
stable/6.12: [01678c53a7717a748aee388b6839e7b9761d641c]
stable/6.18: [3b4c70c40f2e135a50cd38fc61c7d23a296a9981]
stable/6.6: [3404be97b940a9b1ae1aea5fdbc6cdbbe9cd5146]
stable/7.1: [059a70e1d12d6d99310e0599d37b0323557569a8]

CVE-2026-80601: batman-adv: gw: acquire ethernet header only after skb realloc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80601

Introduced by commit 6c413b1 ("batman-adv: send every DHCP packet as
bat-unicast") in v3.14-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [77880a3be88d378d60cc1e8f8ec70430e2ed0518]
stable/5.10: [2760b38222c8828b075802342fe3b91eb823d542]
stable/5.15: [6c37f1166549c999ccd164b0cb6462d1ae68f8f6]
stable/6.1: [b79884a5567bf788fb76c30832467cf6a56f3c0d]
stable/6.12: [e3f4325e35dd6e76b80665f3510738ce34819753]
stable/6.18: [e6b43acd34b219b807e65096ce207b087942779d]
stable/6.6: [afac8096bde4948e3caa7e4dd733867cfbd3018e]
stable/7.1: [916dac5f2944f63f07f7b501acbea6737dbbed0e]

CVE-2026-80602: perf/x86/amd/lbr: Fix kernel address leakage

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80602

Introduced by commit f4f925d ("perf/x86/amd/lbr: Add LbrExtV2 hardware
branch filter support") in v6.1-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a892294b83f541115c94b0bb637f39bef187657]
stable/6.12: [208ecca408b1707ad86ea247d3d3e09d3606fc13]
stable/6.18: [5ab0eba9c8819506bcb72348fd701f8a9006f95e]
stable/6.6: [5be478c1e08981ca91b34de310d7e2638171d9d8]
stable/7.1: [fb3b76b5ad2ebad63dd76f8b65b624eaf638b73f]

CVE-2026-80603: netfilter: nf_conntrack_irc: fix parse_dcc() off-by-one OOB read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80603

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef6400ca25a13fd6dedbe8ef4a1d0979bbbfe88a]
stable/5.10: [abb8c32b88ea3f46beb68c34fe9a3ac8ed664e7e]
stable/5.15: [437e0a3854b3a44ec15afa9ab88ec215adf3a2fd]
stable/6.1: [910c33e4a8c046c3cc1fa5a465a4d41a1bb398f1]
stable/6.12: [2393f0bd7a467ad475598f3a5b9de27ca36e3037]
stable/6.18: [aff589556ed772cb1c0c2d7b4d91ec45c0c39416]
stable/6.6: [2b70f61f569bb29acb380e6f616a1bbdee15668f]
stable/7.1: [eeef3b81f449560653662df2dde6f6fe247c5365]

CVE-2026-80604: HID: core: Fix OOB read in hid_get_report for numbered reports

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80604

Introduced by commit 2c85c61 ("HID: pass the buffer size to
hid_report_raw_event") in v7.1-rc4.
Fixed in v7.2-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [af1a9b65ebe8a948eda805c14b78d4d0767cb1b5]
stable/5.10: [f8896b684e246f3f00f45ba2b6803ae59b9cc768]
stable/5.15: [30ff978af92cb51c9ba99f96fc4f4ac80d7001ba]
stable/6.1: [c39f5765ad840b71ff8db812d0210f216cca96e4]
stable/6.12: [c1fc0d3aff26ec9ff885b3e4c92eba98cf349678]
stable/6.18: [dd395744e4ed87956fcbf81ecc6a20c51e35fa4e]
stable/6.6: [c973d53bcd420b58c4a34c68198746286d77e9fa]
stable/7.1: [f7e8117e42b20c30d2a5edab82c944a5e381d791]

CVE-2026-80605: HID: picolcd: prevent NULL pointer dereference in
picolcd_send_and_wait()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80605

Introduced by commit fabdbf2 ("HID: picoLCD: split driver code") in v3.7-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0021eb09041f021c079be1022934a280f7f176c0]
stable/5.10: [42dc0b7b55fe0499fc09183f34a1c46d1dcccf77]
stable/5.15: [48caee2c106b03301c72fe389ebff00d852c58d5]
stable/6.1: [dc176447c7279435c46735db7da81aed1ec25cc2]
stable/6.12: [e4edeefb8d5bfceb2058e2b3291f4ae1e5a76e61]
stable/6.18: [d354e523c6f740db758cafcd4c11bb7913285ed8]
stable/6.6: [a02d5d7ad7ae5fa3756b8332f7350e973085dcb3]
stable/7.1: [ef649703dce0df1364fcec3cdad9b32d1c522939]

CVE-2026-80606: drm/xe/userptr: Hold notifier_lock for write on inject test path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80606

Introduced by commit 9e97874 ("drm/xe/userptr: replace xe_hmm with
gpusvm") in v6.18-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dca6e08c923a44d2d66b955e03dd57a3a38c2b94]
stable/6.18: [f9a9abd7bbdab3dfe1b1155e1457dc02b5e14ea5]
stable/7.1: [ab9ea5c943c7e780124e75b7ffad9f1c752b2579]

CVE-2026-80607: tracing/probes: Remove WARN_ON_ONCE from parse_btf_arg

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80607

Introduced by commit b576e09 ("tracing/probes: Support function
parameters if BTF is available") in v6.5-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [251a8fe1b9aedccd298b77bc28426d564c5a923f]
stable/6.18: [f148f86c65b8f9ef2466ad8506e721749e4957fb]
stable/7.1: [8a662d8c05e2cf16f7a047c81bc1eb5d3b29bacd]

CVE-2026-80608: accel/amdxdna: Fix iommu domain lifetime race during
device removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80608

Introduced by commit ece3e89 ("accel/amdxdna: Allow forcing IOVA-based
DMA via module parameter") in v7.1-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4a0500fdf6e61a6c5f92ff2e61bc91578075803]
stable/7.1: [65e7e2b8d71b418439ebc68e80ed3e5a325375d6]

CVE-2026-80609: qede: fix out-of-bounds check for cqe->len_list[]

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80609

Introduced by commit 896f1a2 ("net: qlogic/qede: fix potential
out-of-bounds read in qede_tpa_cont() and qede_tpa_end()") in
v6.18-rc7.
Fixed in v7.2-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [f9ba47fce5932c15891c89c60e76dfaca919cb8d]
stable/5.15: [6d203bdd227fca1787f8a80cf84b990936633c5a]
stable/6.1: [bd3a6a083b408e96437dbd86ff543ba9ec3a788b]
stable/6.12: [1aacefd074b5dcc99b8dbcd73e1c963ed5010110]
stable/6.18: [b17751a2ebc4aef3ce6be6f71ee8df92bf5ddfcd]
stable/6.6: [e30af53dca803893a29eb3bbe0539752ba435410]
stable/7.1: [6d46ab395803f162cdc50e8d346e5f1a4e766771]

CVE-2026-80610: net: enetc: fix potential divide-by-zero when num_vsi is zero

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80610

Introduced by commit 2d673b0 ("net: enetc: add standalone ENETC
support for i.MX94") in v6.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5da65537792b68b6052ffcab65e04c27aea6dfe4]
stable/7.1: [cd37bcb67f909a8683cc8c38a63ac7367a7f6161]

CVE-2026-80611: ACPI: processor_idle: Mark LPI enter functions as __cpuidle

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80611

Introduced by commit a36a7fe ("ACPI / processor_idle: Add support for
Low Power Idle(LPI) states") in v4.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [956ca5d72c76504824c8eb601879da9476973e15]
stable/6.12: [10f675902a5fc88ccfe34bb8aa37de50806b03b1]
stable/6.18: [5b6165d7ec38477e8cfa41bfa464959957953822]
stable/7.1: [8bbe4dd7964552f74c271c3a8d95a4331a8ab5f9]

CVE-2026-80612: net: lwtunnel: Drop skb metadata before LWT encapsulation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80612

Introduced by commit 8989d32 ("net: Helper to move packet data and
metadata after skb_push/pull") in v6.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c00320b0e355c4bf0ae4743a53b4180fea237546]
stable/7.1: [19eec11f3ab5dd29ba58f5f209c24e946c95ef12]

CVE-2026-80613: veth: fix NAPI leak in XDP enable error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80613

Introduced by commit b02e5a0 ("xsk: Propagate napi_id to XDP socket Rx
path") in v5.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6739027cb72da26890edd424c77080d187b2a92e]
stable/5.15: [fc51373345e7e6ea73da2650cb497309c50b077a]
stable/6.1: [4559770b2a241344d762719e674241fcc8528f02]
stable/6.12: [d3eb258ad398cc9402bab3a5e730cd7c5b34efad]
stable/6.18: [a9e6707322ef215d39d4655b176c094f45f0ab52]
stable/6.6: [83090f5e7b54721d71875a6c224d2490b9e73050]
stable/7.1: [4bd2e5dbe62334aae1182d0f0d260f334a49d739]

CVE-2026-80614: net: emac: Fix NULL pointer dereference in emac_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80614

Introduced by commit dcc34ef ("net: ibm: emac: manage emac_irq with
devm") in v6.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f623d38fe6c4e8c40b23f42cc6fe6963fa49997b]
stable/6.18: [a103cdb0681e7185d1b0a12ce6a7c5416c208ccd]
stable/7.1: [44068b6863fbda78fc810921ddf61642c377b3ca]

CVE-2026-80615: net: dst_metadata: fix false-positive memcpy overflow
in tun_dst_unclone

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80615

Introduced by commit 69050f8 ("treewide: Replace kmalloc with
kmalloc_obj for non-scalar types") in v7.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c6d43db2a4d2cef3921e885cf34798f790d34ea]
stable/7.1: [7ce31739fe88a558370135db95bbeec1e7ddfc29]

CVE-2026-80616: ieee802154: Avoid calling WARN_ON() on -ENOMEM in
cfg802154_switch_netns()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80616

Introduced by commit 66e5c26 ("ieee802154: add netns support") in v4.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0569f67ed6a7af838e2141da93c68e6b6013f483]
stable/6.18: [f4860dd988b1041d70595f2ed84de80f90cb7ebc]
stable/7.1: [6fcba77571c53f656a2f109259601a7570d4c74a]

CVE-2026-80617: net: airoha: fix foe_check_time allocation size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80617

Introduced by commit 6d5b601 ("net: airoha: ppe: Dynamically allocate
foe_check_time array in airoha_ppe struct") in v6.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [5c121ee635680c93d7074becf14cfbaac140f80d]
stable/6.18: [112b5eff24e044561ee9599a0d34e0fcea1df4e0]
stable/7.1: [9f7cd1e26d2f1766438edc9b9254f2c618f9ae98]

CVE-2026-80618: drm/amdkfd: Avoid double-unpin of DOORBELL/MMIO BOs on free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80618

Introduced by commit d25e35b ("drm/amdgpu: Pin MMIO/DOORBELL BO's in
GTT  domain") in v5.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f0cc1735273a57c5116710cf0202e12152f59cc]
stable/6.1: [461ae406ae12107ebb321cabe561434c27aaea58]
stable/6.12: [c055a2088b719e9a4b580685e0ca97f9554a41a8]
stable/6.18: [0e27d92f69b8e4c750a4b181cc05a86b9338c4f5]
stable/6.6: [283e77af49fda96aaa57709fc5408b55ffec075e]
stable/7.1: [1d12ae8b079e173107abec0e5817332954c8e95f]

CVE-2026-80619: apparmor: fix potential UAF in aa_replace_profiles

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80619

Introduced by commit 5ac8c35 ("apparmor: allow introspecting the
loaded policy pre internal transform") in v4.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b42f95813dc9ceb6bda35afcf914630909a19f9]
stable/5.10: [9d8e47cbce7536f19c96e37d0685a042010187ee]
stable/5.15: [9d37dc6376e336dc4b4f39a7ad0d069aa70e9495]
stable/6.1: [c0f3a3fda617beeec58708720304dd026a1a4dd7]
stable/6.12: [c44de0880b7ccc15c70a6352b5e107677d32b061]
stable/6.18: [57b1bd4486d56254bb8af1a8f3d4445bbe505290]
stable/6.6: [5cba148eae6e8550c2889f5c0f94d72bed864321]
stable/7.1: [dd5f1202f45a2dbe2c7dd10093f5c6bb2d8ac5bb]

CVE-2026-80620: Revert "PCI/MSI: Unmap MSI-X region on error"

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80620

Introduced by commit 1a8d4c6 ("PCI/MSI: Unmap MSI-X region on error")
in v7.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [f64e03da0d83cb173743888bff4a7e61476a8fc2]
stable/6.1: [82e120a7dd566c476ba923d30e3fb78e8118a1dd]
stable/6.12: [0a2aeb02894b839ecc3ece6dc7e5c3d6c3def16f]
stable/6.18: [f79519f636059b007d6abc91652f36dea4f54a20]
stable/6.6: [6848ca381edff84f87dd1b6973848c271541e813]
stable/7.1: [3691a82be2095abaf3326a1cbf7b25858a1d959c]

CVE-2026-80621: PCI: dwc: Avoid dwc_pcie_rasdes_debugfs_deinit() NULL
dereference when no RAS DES capability

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80621

Introduced by commit 4fbfa17 ("PCI: dwc: Add debugfs based Silicon
Debug support for DWC") in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26b67fa10ef84ea667942491b50e6261a45f098d]
stable/6.18: [514b84b1bf30f75f32c2fa66734dc1a177abb73e]
stable/7.1: [855870e8c59b97fd424e8fa3543c9e289bb48fac]

CVE-2026-80622: char: tlclk: fix use-after-free in tlclk_cleanup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80622

Introduced by commit 1a80ba8 ("[PATCH] Telecom Clock Driver for
MPCBL0010 ATCA computer blade") in v2.6.20.16.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbf003b7794d6ad6f939fdd29f1f1bde8ac554c1]
stable/5.10: [09d8d2a46a9ec9ff728f3159a174a2ab25dd0f0a]
stable/5.15: [96902299a22d126ef5eb3f45cd5d8ceea9e6a735]
stable/6.1: [166dd1d5265e067459e674c11688919901813ec2]
stable/6.12: [c3f0cd76561ae611c2d247ee96dfd559e4197cb7]
stable/6.18: [3d5e4cc0d9dce79b0429da3134ac7b072ab9009f]
stable/6.6: [764723bd67a6c8f53a8d8309211fb039e2ebcf49]
stable/7.1: [42223445607a9a5df3cb1c4729abfe3a5085e7ce]

CVE-2026-80623: coresight: ete: Always save state on power down

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80623

Introduced by commit 35e1c91 ("coresight: ete: Add support for ETE
tracing") in v5.13-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ab4645fe4206c142a5f1491e191c906279686cf]
stable/6.18: [65d87f28daec31903fc39fee0744f7a0059c19f2]
stable/7.1: [293dacd5b6a9f1275d92ca6c4fd874e54b2c8319]

CVE-2026-80624: mfd: cs42l43: Sanity check firmware size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80624

Introduced by commit ace6d14 ("mfd: cs42l43: Add support for cs42l43
core driver") in v6.6-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6ef1a74b3ec254f87a6a3c554fe8f8083ebd37c]
stable/6.12: [197a4c54d8a94fe2fb7829661b29f0859c10feb5]
stable/6.18: [d35e4032f16d7621468c8b56816e7935ebf590a7]
stable/6.6: [2ce02059ceb6311a33026b62e6e4dc4ed22a3aef]
stable/7.1: [17d79248b4f370663f9d351409a130fc1ed9416d]

CVE-2026-80625: RDMA/hns: Fix memory leak of bonding resources

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80625

Introduced by commit b37ad2e ("RDMA/hns: Initialize bonding
resources") in v6.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0bd03b850d81a8914168d87ddf7f6ffa58875ef]
stable/7.1: [bc4caea7a82bbcf94a34eff7094e7f9b501680ab]

CVE-2026-80626: powerpc/perf: fix preempt count underflow in fsl_emb_pmu_del

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80626

Introduced by commit a111065 ("powerpc/perf: e500 support") in v2.6.34-rc2.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81e3a86030462824a67d697739cf3f387f4ba350]
stable/5.10: [c0c7722308c5f303117d8bd555290fdf26b098da]
stable/5.15: [67aeb1eb93d4ffd898a3e74a7f3fe46ee71feb28]
stable/6.1: [9a515e00b00132b6fc3f1dd62dc5204bbda8cb10]
stable/6.12: [b89477077c834d94381c7bf07d81193bebefcff9]
stable/6.18: [73711688479df333acc134e3730fff1acba1843e]
stable/6.6: [5397142d60aa29dcf636f5459d960bfc4f97c42a]
stable/7.1: [b504fd953664c3f4d176ae8cb594adb3fda9d577]

CVE-2026-80627: MIPS: mm: Fix out-of-bounds write in maar_res_walk()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80627

Introduced by commit a5718fe ("MIPS: mm: Drop boot_mem_map") in v5.4-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b001b16bc88f3f7817e228acfd91ee01bdcfcce]
stable/5.10: [a594100e147a6a67eb29189170f1df3645cda12b]
stable/5.15: [8b3e0c1c63015deaf084286899f5b2d0526715de]
stable/6.1: [44c1d902cf0798b60762a7a98be992b9f5ded7dd]
stable/6.12: [431812eb88c200bc3ec33b88782c8cc415842074]
stable/6.18: [92f38fe85198ace9b211bc7712b7951acfb94560]
stable/6.6: [ac7385af1dca86a5ea704c80ca4dc822083ff9e2]
stable/7.1: [038f068cced8e9c49e8c419f3112d909ad366a3a]

CVE-2026-80628: ALSA: seq: oss: Serialize readq reset state with q->lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80628

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49ce92d207820f588b0406add82f053decfbe5d9]
stable/6.18: [287d506d4e0865918cec82bb1361f283a08c979b]
stable/7.1: [43e10709b1ba288bcbabb9b9cb6e518b2a5d8506]

CVE-2026-80629: octeontx2-af: npc: Fix size of entry2cntr_map

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80629

Introduced by commit 55307fc ("octeontx2-af: Add mbox messages to
install and delete MCAM rules") in v5.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9cd6fabe0e7c7f6fc30c6c192c7ed72aba37232]
stable/6.12: [de8e3a4004c5df9461974352e9d7ff0f8313c508]
stable/6.18: [1d072cc3ba4338d6b2acb85d50a3af5cf2b12a3e]
stable/7.1: [2477c523c6e69733d51101ae9bd2dfc0a054b13d]

CVE-2026-80630: net/sched: sch_fq_codel: Do not call
qdisc_tree_reduce_backlog during peek before restoring qlen

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80630

Introduced by commit 342debc ("codel: remove sch->q.qlen check before
qdisc_tree_reduce_backlog()") in v6.15-rc2.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [097f6fc7b1ae362dd7a9444b2572162fda73b284]
stable/5.10: [3e515188393e62a718ccebee651ee74514104ff6]
stable/5.15: [20dd591d8f951e1e6aca5052be8785e6181055e2]
stable/6.1: [94a5f1efdefb01f82cd228bf4e7ef1e8fc075c80]
stable/6.12: [7c09843fd2b44d9bf0de798683861d1aecd62a08]
stable/6.18: [0500af8630c3253f0dde879bd3a73a06bb2f2b3f]
stable/6.6: [acc08a0c7f37ebb1901144e03a7cba7d4afd9203]
stable/7.1: [af54df2f44d9605614bc7ed96640302a240a9a62]

CVE-2026-80631: btrfs: lzo: reject compressed segment that overflows
the compressed input

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80631

Introduced by commit a6e66e6 ("btrfs: rework lzo_decompress_bio() to
make it subpage compatible") in v5.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0d27d43791b7a3057c3c4aedf9b4aa033d37c46]
stable/7.1: [1641d058adfbd50cf95d54581ed5d142ee82c07f]

CVE-2026-80632: wifi: mt76: mt7996: Fix NULL pointer dereference in
mt7996_init_tx_queues()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80632

Introduced by commit cd7951f ("wifi: mt76: mt7996: Integrate MT7990
dma configuration for NPU") in v7.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6794edb55b5f5ef834e03b0b241b1a8b725f82c0]
stable/7.1: [93f3f9a9e955569ab7c3f02f0486d3aaf2314a56]

CVE-2026-80633: iommufd: Take dma_resv lock before dma_buf_unpin() in
release path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80633

Introduced by commit 8c5f964 ("iommufd: Add dma_buf_pin()") in v7.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e745cd2c749e557c14a15ac931761c3f58c24489]
stable/7.1: [cc69d0332421fd2943b66dbe5e597bf4fd5af126]

CVE-2026-80634: netfilter: flowtable: avoid num_encaps underflow on
bridge VLAN untag

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80634

Introduced by commit e990cef ("netfilter: flowtable: add bridge vlan
filtering support") in v5.13-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e052f920773b73be49eb4d8702a9f85de7464363]
stable/7.1: [2f55fa28011c97d6495d5787808db10a8c2d690d]

CVE-2026-80635: wifi: wcn36xx: fix OOB read from short trigger BA
firmware response

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80635

Introduced by commit 16be1ac ("wcn36xx: Parse trigger_ba response
properly") in v4.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5e6f21923ca89d90256e7346301056f6502691e]
stable/6.1: [04aba50212f9f274e1a726fb3873b5ce8da2d821]
stable/6.12: [d0b57bcd0dac6e2c9a3e474ec280e7db0b3edf35]
stable/6.18: [af8f0ea1f0a3a5fb5ed2b8fed3f1501d644597ee]
stable/6.6: [c07aa0534d50361183833e3803204044cf1d0476]
stable/7.1: [d0cafe6ed8d1f6d0097eda31d85f5760d4f359c2]

CVE-2026-80636: netfilter: conntrack: revert ct extension genid infrastructure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80636

Introduced by commit c56716c ("netfilter: extensions: introduce
extension genid count") in v5.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35e21a4dccc5c255ba59ccfbfeb4629ed21da972]
stable/6.12: [61eab1d0237eb513fe73e391a5926ee70092c325]
stable/6.18: [d53eecbca16f056abba274075cb15120ab062518]
stable/6.6: [6bba4846f196d081bf553391d12b5a73dcc48685]
stable/7.1: [a052a94bcc629acaecc2ce42a4af77f8fa399757]

CVE-2026-80637: netfilter: synproxy: fix unaligned memory access in
timestamp adjustment

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80637

Introduced by commit 48b1de4 ("netfilter: add SYNPROXY core/target")
in v3.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [992c20bc8a4aba220c8b95b467d049289778dad6]
stable/6.12: [2b8e7aaa38002d8ee2f48d87b1f392eadd8e98c4]
stable/6.18: [5c9c67cf7a3d16051dfb90e98836f530964dfb8e]
stable/7.1: [ea3d2caa5bfacf5db5c1cad521ca5d9144edd9a7]

CVE-2026-80638: ocfs2: fix out-of-bounds write in ocfs2_remove_refcount_extent

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80638

Introduced by commit 2f26f58 ("ocfs2: annotate flexible array members
with __counted_by_le()") in v6.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1ec3cca2d8b6b9ff6584ca626d4c8918bbf48d44]
stable/7.1: [f5255516ec7add3a6d5d37853ad5a9a9ddb14305]

CVE-2026-80639: cxl/test: Fix __fortify_panic

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80639

Introduced by commit 06377c5 ("cxl/test: Add cxl_translate module for
address translation testing") in v6.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08326b92c7a414a73b5b308d1daf0e91e0134dfc]
stable/7.1: [8c4f27a7f364eab514d2fa55c11f39d505122f1b]

CVE-2026-80640: cxl/fwctl: Fix __fortify_panic

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80640

Introduced by commit 4d1c09c ("cxl: Add support for fwctl RPC command
to enable CXL feature commands") in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c9d2e87df40d606f1c85143e9acb1ecff463d5e]
stable/6.18: [b8d15e85596ad8993d42e0703a9741961a2f03eb]
stable/7.1: [18c67ecc5dafe14055edcea53f36f4e31df1816b]

CVE-2026-80641: wifi: wlcore: enable the right set of ciphers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80641

Introduced by commit c34dbc5 ("wifi: wlcore: Add support for IGTK
key") in v7.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7495adaa0e45e180f4b6b7436675c6266edff1ff]
stable/7.1: [ff9748200698e9641f41ba922ffef728167807c2]

CVE-2026-80642: liveupdate: Reference count incoming FLB data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80642

Introduced by commit cab056f ("liveupdate: luo_flb: introduce
File-Lifecycle-Bound global state") in v7.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d8e47bd066d7e626f9f45d416182d585b7e18b9b]
stable/7.1: [725ada0273a0f48a67fd59cc518d7f8055fe3d5c]

CVE-2026-80643: EDAC/igen6: Fix call trace due to missing release()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80643

Introduced by commit 10590a9 ("EDAC/igen6: Add EDAC driver for Intel
client SoCs using IBECC") in v5.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab1f9d466c7d83ab0d2a529e07984e53b5960dcd]
stable/6.18: [9a84ced0243c74aa431ec287555054c69e6167d1]
stable/7.1: [a341302c5126ef96bb45286224d67ef60a24281e]

CVE-2026-80644: ocfs2: don't BUG_ON an invalid journal dinode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80644

Introduced by commit 10995aa ("ocfs2: Morph the haphazard
OCFS2_IS_VALID_DINODE() checks.") in v2.6.29-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0438198c28b1d22c272751af5e717c11d9fa8dd]
stable/5.10: [bf1d59cf2ac8a1730607ebaa0bc0dc6d00f197d0]
stable/5.15: [86509c5296fe46ad6bcdd83931a53c2c6b7913a8]
stable/6.1: [12c32a7350b670aaaaf2e01583d8648ec0c9755c]
stable/6.12: [a06eec15596e5801bad59ad16cd2bf4f0fa839a1]
stable/6.18: [3852478d34c7baa490ba9c7374ee901a56eea577]
stable/6.6: [b460f8d01a12061853d02c8fb693fb42450acd7d]
stable/7.1: [5b33f99f3e48465bd93219495381a5aef4fa967f]

CVE-2026-80645: rapidio/tsi721: prevent a bad dereference in tsi721_db_dpc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80645

Introduced by commit 48618fb ("RapidIO: add mport driver for Tsi721
bridge") in v3.2-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc15e3a30ddd950f009c76765331783b9af94a87]
stable/5.10: [9e775c3199903d7c09a52530042b1198eab705bd]
stable/5.15: [81c06ef66c3ab6eeaa72eb790c90ae043cdb3d43]
stable/6.1: [13092966ba5d8fb214a4efeddc87f9ed0fd2f945]
stable/6.12: [3b5c66e922aa6a3331915a14520848a5b3beccc7]
stable/6.18: [070f356ea4f419e4e85e4089381f4477f41d969e]
stable/6.6: [acd54f42abbbd806464468838dbc04efd203d2be]
stable/7.1: [dc28a14f3e4546b2b06098d24177942540581a5f]

CVE-2026-80646: ipv6: guard against possible NULL deref in __in6_dev_stats_get()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80646

Introduced by commit e1ae5c2 ("vrf: Increment Icmp6InMsgs on the
original netdev") in v5.2-rc6.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [507541c2a8eeb76c02bd2511958f73a8cfa3e1bc]
stable/5.10: [a23f2c68c6635e41404f189f8f7ae910738cebdb]
stable/5.15: [e14db43677946bf2095febd294bb3c13ab375ab7]
stable/6.1: [1a4adfbeb47a212a64539137411f1ca168474d33]
stable/6.12: [952426a83ca75cea25c09d58944abafaa3ebd242]
stable/6.18: [0db1949084e85a72d174a7dea3259b94fe5a9305]
stable/6.6: [1e3db30a88815bae6e9d5db6f64ac735e615a07e]
stable/7.1: [fc920c0659cdea5afd8721c1155a51564859e075]

CVE-2026-80647: RDMA/hns: Fix warning in poll cq direct mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80647

Introduced by commit f295e4c ("RDMA/hns: Delete unnecessary callback
functions for cq") in v5.5-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f19c2a3852e6ba75f3e92dd5edc4e07f3d07f4a]
stable/5.10: [95b2e44bc1e5c5d93bb58e178d914dd99a3baa6f]
stable/5.15: [e7d363c0ffa836ac1d89657686cad241392c5eb2]
stable/6.1: [c028c1977b6e61eee26bb69332453efb6513f83b]
stable/6.12: [9f05319149c14acedb83e2c2842ec4b38992ad9f]
stable/6.18: [16138ea9833d6bb1bed37a3321f282242704bf02]
stable/6.6: [a075a7acd155ffdd058e72eb3f4cce1207ebafa1]
stable/7.1: [1e56f8886d64288cf88d80af44c7b9148aeaa98b]

CVE-2026-80648: pinctrl: spacemit: fix NULL check in spacemit_pin_set_config

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80648

Introduced by commit a83c29e ("pinctrl: spacemit: add support for
SpacemiT K1 SoC") in v6.13-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [09c816e5c4d3a8d6d6e4b7537433e5e98505d934]
stable/6.18: [7a551951ebeb5b3f05bdb04a73d4593869c984c4]
stable/7.1: [d3b53f0eda26e442ff97016ad4a0724db8fd3781]

CVE-2026-80649: firmware: arm_scmi: Fix OOB in scmi_power_name_get()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80649

Introduced by commit 76a6550 ("firmware: arm_scmi: add initial support
for power protocol") in v4.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9ef3f66f4b18078e464b7606f9497e4dbeb9905]
stable/5.15: [01613f5e4ff6c080260615392338e92e261d109b]
stable/6.1: [ca94597440fa546e56293abe9d0af6c73535d44e]
stable/6.12: [0db2bb3c948ef8b7364768554d6ab5e1544dc441]
stable/6.18: [11daac2817dca75e3eabb2050bc620c29e686fcd]
stable/6.6: [30aa348494531adfb043b2e883afc0439e5fcdca]
stable/7.1: [11bb771f3c55b4cef3879e69da4ddecd6085569c]

CVE-2026-80650: media: atomisp: gc2235: fix UAF and memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80650

Introduced by commit a49d253 ("staging/atomisp: Add support for the
Intel IPU v2") in v4.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [628f763aee0047ff44974388d6f70f75a763026b]
stable/6.12: [fdbb8e55578b4ab647fa58827a9dd8730d7f4add]
stable/6.18: [d57e67ea48e4d095052f2b14d8dd7593621f862f]
stable/7.1: [f614bf0a64aa1cb7444d152a96798a6bf1d49e1f]

CVE-2026-80651: crypto: ccp/sev-dev-tsm - bail out early when pdev->bus is NULL

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80651

Introduced by commit 4be4235 ("crypto/ccp: Implement SEV-TIO PCIe IDE
(phase1)") in v6.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [930d9d36ea618a775985446a125aedeb401db522]
stable/7.1: [6bafd740095fb3d0e9a00540bc8f3484c38e6f85]

CVE-2026-80652: crypto: ccp - Treat zero-length cert chain as query
for blob lengths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80652

Introduced by commit 76a2b52 ("crypto: ccp: Implement
SEV_PDH_CERT_EXPORT ioctl command") in v4.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef8c9dacda2871accd64e3eda951fef6b788b1ea]
stable/5.10: [1c587f30c6242cc37b3d6ee6d91daef84e51633f]
stable/5.15: [13b4d5e055d344e34b864bced0a591ceaac7ad81]
stable/6.1: [94344bc7c9d70b04be718d841b92873aa3ea8191]
stable/6.12: [ee717e73ab47253c82c134c342e32fcdfcfccd87]
stable/6.18: [21650fe221ea9b72809140b691589dde8bff3eab]
stable/6.6: [50c3c7df4f26d36b30bc950a7d780f7029fd52f8]
stable/7.1: [d88071a6ce091272726bedda26c105b85b23705f]

CVE-2026-80653: scsi: hisi_sas: Add slave_destroy interface for v3 hw

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80653

Introduced by commit 16fd4a7 ("scsi: hisi_sas: Add device link between
SCSI devices and hisi_hba") in v5.10-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67b85a88265df19f049241d8c00571a5408f4eeb]
stable/6.18: [cb414aff28e18e6f5cff9f87ea31376ed8af317b]
stable/7.1: [4867dba229292e13fc19ed865ec1839661952ff9]

CVE-2026-80654: soc: xilinx: Shutdown and free rx mailbox channel

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80654

Introduced by commit ffdbae2 ("drivers: soc: xilinx: Use mailbox IPI
callback") in v5.6-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fdee7c66c0d7b6869c36b9f9a915abf29ab5b550]
stable/6.12: [b0f748c563921a7918c78e6a599cefd54de7d688]
stable/6.18: [a83e77d1e52c01c50096e6e97c57d34e0590d628]
stable/7.1: [b5d2240c2c7bc8370e7ba54a2e1fe3919f55aee5]

CVE-2026-80655: soc: xilinx: Fix race condition in event registration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80655

Introduced by commit fcf544a ("soc: xilinx: Add cb event for subsystem
restart") in v6.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb445935338405110baca8f541a2df3b4cb8d712]
stable/7.1: [d349aa118ff5e4cab88424ce1b16e08edd70f8bb]

CVE-2026-80656: hfsplus: Add a sanity check for btree node size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80656

Introduced by commit 8ad2c6a ("hfsplus: validate b-tree node 0 bitmap
at mount time") in v7.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f95e2661574ff13f099dd13456751933c280628]
stable/7.1: [306265eb9384d2c224f1b14d83a29323f0eab6d1]

CVE-2026-80657: accel/amdxdna: Guard management mailbox channel
cleanup against NULL pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80657

Introduced by commit b87f920 ("accel/amdxdna: Support hardware
mailbox") in v6.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [506255d46bdb93a281cf39e72abbca124f5c7a1b]
stable/7.1: [83d6d375f357ed2702b28d739511aad56d485de7]

CVE-2026-80658: drm/rockchip: dw_dp: Fix null-ptr-deref in dw_dp_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80658

Introduced by commit d68ba7b ("drm/rockchip: Add RK3588 DPTX output
support") in v6.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9456381d8b60bb7dd42f2f04afe5ee4ce6e0bc12]
stable/6.18: [b3ec263a719e0d499bd95d20012d90d7e8641655]
stable/7.1: [33bc9fba3ae05863fabe3436ddca2ca4f4939c5e]

CVE-2026-80659: mmc: vub300: defer reset until cmd_mutex is unlocked

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80659

Introduced by commit 88095e7 ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC
driver") in v3.0-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee5fb641c4ccac8406c668d3e947eb20ce44f233]
stable/5.10: [8672b8bdbd2063b3fcbd75f729e4706fcdad2257]
stable/5.15: [8344611477c9241f45f20981990780fc5f0996f8]
stable/6.1: [2e6b9a394206c76dd417c991312f349435ef35e6]
stable/6.12: [9f5e04235a0b59e6e30af9f45511addf2604d757]
stable/6.18: [bf9848a22a8e50d39d5e8d871581f0a8110f16b3]
stable/6.6: [7ee7a77ec2f446109ab52cc80ace7acc22ab6211]
stable/7.1: [c2e1d33929565fa14c48d8a5a45edc3ebfc941b2]

CVE-2026-80660: hwmon: (occ) unregister sysfs devices outside occ lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80660

Introduced by commit 849b015 ("hwmon: (occ) Delay hwmon registration
until user request") in v5.19-rc1.
Introduced by commit ac6888a ("hwmon: (occ) Lock mutex in shutdown to
prevent race with occ_active") in v5.19-rc3.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e31408734332b8cc611342cdaaab6ba492180156]
stable/6.1: [2a4c80ff3571498ec6a916273304b6650026b1b0]
stable/6.12: [2092952f22a7da98e76e84139ae202b1fc7ba899]
stable/6.18: [f0aad157576da199c146c1bb266442befa7912ca]
stable/6.6: [e7fd81e9fb1fe476d2131fec66c1138457810ed4]
stable/7.1: [7ee43ec8e6774774abbe9dc3027225e01bc964a5]

CVE-2026-80661: ufs: core: tracing: Do not dereference pointers in TP_printk()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80661

Introduced by commit 583e518 ("scsi: ufs: core: Add hba parameter to
trace events") in v6.15-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [535fcf4b8a261fbb8cc4f91e4597343c135a90f2]
stable/6.18: [e497fef9ad7e913f52de6f97e818f56915e96164]
stable/7.1: [2510434307a224078302019e52ab3c863fbe87fb]

CVE-2026-80662: cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80662

Introduced by commit 36f257e ("acpi/ghes, cxl/pci: Process CXL CPER
Protocol Errors") in v6.15-rc1.
Introduced by commit 2905cb5 ("cxl/pci: Add (hopeful) error handling
support") in v6.2-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c268f949e219f9e179558e836f457f6c5fbec416]
stable/6.18: [6fc1919a6f2ed541484dd1f6cd93374044f8fd3d]
stable/7.1: [fc5eb0962a5e50d64e711817cc24d67df2d90528]

CVE-2026-80663: tools/power/x86/intel-speed-select: Harden daemon pidfile open

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80663

Introduced by commit 7fd786d ("tools/power/x86/intel-speed-select: OOB
daemon mode") in v5.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [607af438e6430893a822964c841a1994b33acccc]
stable/6.1: [905493a6338c82a70da16f86e0a6215db5a3d73d]
stable/6.12: [72a07abc6b9046f07a08bba353cad7667bcc9dce]
stable/6.18: [19ffeb30fdfce63f8d6aca71bcdddb3f69d46278]
stable/6.6: [db938eb9a3c1317596c28e94413b33426508d51b]
stable/7.1: [e8adac69d1bdf035ef97cc914e845acd4ef08e28]

CVE-2026-80664: netfilter: xt_nat: reject unsupported target families

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80664

Introduced by commit c7232c9 ("netfilter: add protocol independent NAT
core") in v3.7-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d1a2240935ea47e2673d0ea17fdb058e4dc91dd]
stable/5.10: [49abe564391411057a26a9a943c8e17867c3b9b4]
stable/5.15: [0afc9ad987c0faa80ab5f8d6e7815085ac8dbb82]
stable/6.1: [4fbc2bac02edabb665beb2aa87ca6f1e1d4c4777]
stable/6.12: [e35c048d7511e9d4c2a537b8a231c49606e97c16]
stable/6.18: [679ced28a9dc2f6dc679eb05027d779693e60902]
stable/6.6: [a842dab87cab29f2a5798a47b2dc5e6a449950bf]
stable/7.1: [ec88fa71c82072e9189983b05b499d3507550271]

CVE-2026-80665: KVM: arm64: nv: Inject SEA if kvm_translate_vncr()
can't resolve PFN

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80665

Introduced by commit 2a359e0 ("KVM: arm64: nv: Handle mapping of
VNCR_EL2 at EL2") in v6.16-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f3e83345a56280efffe235c65593c7e544c0fcc]
stable/6.18: [4ead4def04659739c399bfcb063f8a906194c79f]
stable/7.1: [53804b6839573c9c6fff5f4cf075d6746267345e]

CVE-2026-80666: Bluetooth: sco: Fix a race condition in sco_sock_timeout()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80666

Introduced by commit e672077 ("Bluetooth: SCO: Use kref to track
lifetime of sco_conn") in v6.13-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f8a5dcc66648b6e1458a9f3ba4c5a0463a228fc]
stable/6.18: [da4d8eea0c5f33ea35c0e1d9e5f3e439f3b987ce]
stable/7.1: [a50da115b5888062d32c86a548a29b4e2559d7ec]

CVE-2026-80667: net/mlx5: LAG, MPESW, Fix missing complete() on devcom error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80667

Introduced by commit b430c1b ("net/mlx5: Replace global mlx5_intf_lock
with HCA devcom component lock") in v6.7-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4b85f9a668b9c44216bb78daf4ec1a915cc92d1]
stable/6.12: [68cdbe498da8475cfd49591954e3db8fc6582eda]
stable/6.18: [6a802de97a8bf8d5f1e4a048c67de9a8c2d2f9eb]
stable/7.1: [4d720c6c60e1852253b68aeee3044ebed5243adb]

CVE-2026-80668: netfilter: nf_conntrack_expect: use conntrack GC to
reap expectations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80668

Introduced by commit bffcaad ("netfilter: ctnetlink: ensure safe
access to master conntrack") in v7.0-rc6.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [b8b09dc2bf35a00d4e0556b5d6308c7b917ebda2]
stable/7.1: [7ec786f4230c2a9b2eaf97a2d45368933b49d2b2]

CVE-2026-80669: bpf: Disable xfrm_decode_session hook attachment

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80669

Introduced by commit 9e4e01d ("bpf: lsm: Implement attach, detach and
execution") in v5.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12091470c6b4c1c14b2de12dcbae2ada6cb6d20b]
stable/6.1: [aa265d47308775c5501073b08133623bcb5421f9]
stable/6.12: [4ae780d173ef40d4f7cb76935dc2d55fbf380009]
stable/6.18: [49fa1be621dde8f526d36e5791aded8fafda1e9c]
stable/6.6: [6b44c6660aa1c9b843e450a623ac4a8484919dce]
stable/7.1: [1bb3b6a5c3c5cc814eae4ff0212fdced36f8bce9]

CVE-2026-80670: perf tools: Use perf_env__get_cpu_topology() in
machine__resolve()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80670

Introduced by commit 0c4c4de ("perf tools: Add processor socket info
to hist_entry and addr_location") in v4.4-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5484b43a0ec8231c36fba6ead654cb72dbba8b8f]
stable/6.18: [b9e8406651dcc1c19238aad11861a758683525b4]
stable/7.1: [eb266a14c16a93eb4db7b56a452d6be93f8bdcd4]

CVE-2026-80671: perf sched: Fix register_pid() overflow, strcpy, and BUG_ON

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80671

Introduced by commit ec15676 ("perf sched: Import schedbench.c") in v2.6.32-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5949d339f5ec98752d56dcd4e36f619a59d513a5]
stable/6.18: [652cea73b7b7b7c622a2be670e44e3c499c6d49f]
stable/7.1: [5ea1dcc9418c4e06ce29ed5170596f497ba86872]

CVE-2026-80672: ntfs: fix u16 truncation of restart-area length check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80672

Introduced by commit 1e9ea7e ("Revert "fs: Remove NTFS classic"") in v7.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [390936fb15053d8d8991ca3a22776e251a5a7f2f]
stable/7.1: [07a4751ef3ccc8bfd17bfbb16e5003c03161790d]

CVE-2026-80673: ntfs: bound the look-ahead attribute-list entry in
ntfs_external_attr_find()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80673

Introduced by commit 1e9ea7e ("Revert "fs: Remove NTFS classic"") in v7.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [344b18f389f9934d59c7b0cf3d20541ea2e0da58]
stable/7.1: [44885c9b45eb4082fb7f558590d84bb254a08e94]

CVE-2026-80674: ntfs: validate resident attribute lists and harden the validator

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80674

Introduced by commit 1e9ea7e ("Revert "fs: Remove NTFS classic"") in v7.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d19e1ffee084c4f7d321a360c14ba43404f7cc8]
stable/7.1: [55e97648f7753c6097cb682d24d1abcfe878e812]

CVE-2026-80675: libbpf: Reject non-exclusive metadata maps in the signed loader

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80675

Introduced by commit fb2b0e2 ("libbpf: Update light skeleton for
signing") in v6.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0fb6c9ed6493b4af01be8bb0a384574eba7df636]
stable/6.18: [b6862b6a25c6a925fb0b0e549ee4a52a8d2966fb]
stable/7.1: [0dad5adeb34b6f78a883e8faa6a1c947a240e7c9]

CVE-2026-80676: Drivers: hv: vmbus: use generic driver_override infrastructure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80676

Introduced by commit d765edb ("vmbus: add driver_override support") in
v4.20-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [331d8900121a1d74ecd45cd2db742ddcb5a0a565]
stable/6.12: [d1cb12ae81d2f7a58b0b1cfb51862afca98e6058]
stable/6.18: [0e2f0833556c8c5269deb457b89d538644a3b747]
stable/7.1: [2fb010ea7ca98cd09a6d365260b769f627e73a76]

CVE-2026-80677: driver core: use READ_ONCE() for dev->driver in
dev_has_sync_state()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80677

Introduced by commit ac338ac ("driver core: Add dev_has_sync_state()")
in v5.6-rc5.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9506871a8ea304cde48ff4a57226df2aadddae3]
stable/5.10: [89789e4c141904506163dcb91c7289a074573931]
stable/5.15: [51b3e1de53ee5b7775c7ff90e67fdb2665fce938]
stable/6.1: [358697929351f619143f59c6a8a15a4994748b79]
stable/6.12: [860885fcd2611bca8c28dac8b2c1c7ff160f763e]
stable/6.18: [cc77f0d91e3214e4292208f02a1dc09a31f9aac7]
stable/6.6: [5e79e0180515b31b2e2244dc3d256fd8b5a07021]
stable/7.1: [9b0f4082a09760939588135d60a8e9cc994bfa3e]

CVE-2026-80678: i2c: imx: Fix slave registration race and error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80678

Introduced by commit f7414cd ("i2c: imx: support slave mode for imx
I2C driver") in v5.11-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d64ec362c369bbc33833f7936d5f3a706b0d5c45]
stable/5.15: [754bc62f72fd64b202462367134ac8ce95b005de]
stable/6.1: [cfdf6e13518589f911b7eace6ccb788e4ed87397]
stable/6.12: [d6748f6802f3eebafaa16a5e5dcfbfb9b3bc173f]
stable/6.18: [12a4f0950a158d98552cbaeacc35edccd8d975fa]
stable/6.6: [b9f6f4883b9ac86654e75899d0dbf8a7a96ad5d8]
stable/7.1: [614ca6594e301ff682999797c2216e9685558a2b]

CVE-2026-80679: s390/dasd: Fix potential NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80679

Introduced by commit 91dc4a1 ("s390/dasd: Add new ioctl to release
space") in v5.3-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9973026f572db6b67570cadc30942f3014e41079]
stable/5.10: [dbf2ae34d2f1390a9fc1abf3dce7f809e022caae]
stable/5.15: [3000367a512b1283ca52230bf21f8c91dfbec45b]
stable/6.1: [cdc7b73d0c5a9cd6360b4f8c36eae23b02097e4c]
stable/6.12: [3453a993a3f14c1684560ecf26585046976f6ac6]
stable/6.18: [86cdfd061509bcde84f3145f7221ba64e3e53b1f]
stable/6.6: [e156c70c505c6c9adce3b7be5a82025f00544709]
stable/7.1: [96b8e09b09539f252a5eeea6baebd93c2e3779bd]

CVE-2026-80680: i2c: amd-mp2: Unregister callback on adapter add failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80680

Introduced by commit 529766e ("i2c: Add drivers for the AMD PCIe MP2
I2C controller") in v5.2-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82048795242f04275a3f49ffc66ad851b6120954]
stable/5.10: [9142a3dcff0d80a3a24ce159aee19ddc869d9784]
stable/5.15: [2f7789b3a9628819ebf90bcba8f9da3c139f8687]
stable/6.1: [4786d4d70dcd1e6b7e044f2348e00f201947b69c]
stable/6.12: [cf107c5983dc70fcf932a305581a5f976d908ff1]
stable/6.18: [1883a09a37fed497b9efacf736c23624a472246b]
stable/6.6: [b7c2c5c8868737926410b93d1223ada17625ead3]
stable/7.1: [8bf719659406e4a1b56d441e0c7da2085d891d96]

CVE-2026-80681: vxlan: re-fetch eth header after route_shortcircuit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80681

Introduced by commit ae88408 ("VXLAN: Allow L2 redirection with L3
switching") in v3.10-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1395a676ec15a0a02a2a6d86602324f2d5fd41d5]
stable/5.10: [6375093eb45cd7d89f1945f939eeae3b29d79f56]
stable/5.15: [1b7f7b653e3557690047c62f03b80a24ea5a58a5]
stable/6.1: [bf045341dfb3e767f0ff94cf240ce3c371973bd4]
stable/6.12: [1511631b7cfc4152b10a0a9d04c7a0bf2ddf4585]
stable/6.18: [1235e017aa11cf01e91b613c4c5ed6aa28934fff]
stable/6.6: [2355c8c26d2aa1b4385b369e67202e47d460d555]
stable/7.1: [c9dceac9e1c7c772c43c732fc0d325e72835801a]

CVE-2026-80682: riscv/mm: use physical alignment for vmemmap_start_pfn

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80682

Introduced by commit 476849b ("riscv/mm: align vmemmap to maximal
folio size") in v7.1-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45ebe4540817cb540a59e4dc04014ac5dddc9990]
stable/7.1: [11ad86830a78ea4e1942afc73c10e4ca8e69e03f]

CVE-2026-80683: Bluetooth: SCO: give the socket its own sco_conn reference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80683

Introduced by commit e672077 ("Bluetooth: SCO: Use kref to track
lifetime of sco_conn") in v6.13-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abd93c85c8667add738ee82aeab95dd9fc8265a2]
stable/6.18: [a33bc07b4730b6cd5681ac77d18ae0de3e739690]
stable/7.1: [8fe627192fa5da7157f9a48608f13c04b6373e43]

CVE-2026-80684: KVM: s390: pci: Fix NULL dereference on AIBV allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80684

Introduced by commit 3c5a1b6 ("KVM: s390: pci: provide routines for
enabling/disabling interrupt forwarding") in v6.0-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bf09b9b7d3232806df95f409581f8a9fd99a3fa]
stable/6.1: [96099486b63985801c9c6ef22505e9aa635b2d20]
stable/6.12: [df947d85e164a50a29d43a96e814f69ab1d0f7ed]
stable/6.18: [e137d082325bbcae780087b57501d38585e625d9]
stable/6.6: [0a95abe964400771ad82b027d7b84a0d183cd0db]
stable/7.1: [d1a103dc9016c25e7423ce5841a5cc2df76d59f3]

CVE-2026-80685: mm/util: don't read __page_2 for order-1 folios in
snapshot_page()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80685

Introduced by commit 31a31da ("mm: move _pincount in folio to page[2]
on 32bit") in v6.15-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7441d6348c70738e9ed307510db171c7a9b3f4bf]
stable/6.18: [9668ffe0e2a5e2399dce281620198a2e415871fc]
stable/7.1: [c649324571206a30949765320b91ccdb4c1722dc]

CVE-2026-80686: mm: migrate_device: fix pte_pfn/pte_dirty called on
non-present PTE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80686

Introduced by commit fd35ca3 ("mm/migrate_device.c: copy pte dirty bit
to page") in v6.0.
Introduced by commit 6c28760 ("mm: remember exclusively mapped
anonymous pages with PG_anon_exclusive") in v5.19-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63867c82d0c0c2d182016a32b1cc0103116b0ea5]
stable/6.1: [26f9ca8ed42cba25d2c75daff13561cce6019395]
stable/6.12: [86d55447de3738620b9a8272ff167ce97e7f7203]
stable/6.18: [2be94d6b20789b8865b1864dae5fe458ca85e019]
stable/6.6: [5b948706f11a950bc73c5304630d0a7eafc40daf]
stable/7.1: [42f30fa5481a1f90571ccdfbb20d2e25e47ae76e]

CVE-2026-80687: iommufd/viommu: Release the igroup lock on the
vdevice_size error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80687

Introduced by commit ed42eee ("iommufd/viommu: Add driver-defined
vDEVICE support") in v6.17-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [339bd11591593ab7ce88136ab7fd01ef3813b724]
stable/6.18: [294b464b2be7e57872864cb6936e1d9c7294f89d]
stable/7.1: [ca9e49e1c8931a4e6e743a1f1d2e7f977f774b86]

CVE-2026-80688: riscv: drop __init from
vec_check_unaligned_access_speed_all_cpus

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80688

Introduced by commit a00e022 ("riscv: Annotate unaligned access init
functions") in v6.15-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f51fed61eea0daba2f95f1a6074085e4cd513c7b]
stable/6.18: [01bd01b61ad9ea917e5629a7f14f57a8af0543bb]
stable/7.1: [25f228e6ac573884a3d7078cc2b3312b8db59eea]

CVE-2026-80689: tracing/mmiotrace: Add NULL check for mmio_trace_array
in logging functions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80689

Introduced by commit f984b51 ("ftrace: add mmiotrace plugin") in v2.6.27-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12b80cdbc54cf615b4717a4e8180063408091ea2]
stable/6.12: [876014b4eeb927146430e7591cf959a7ceb8d64a]
stable/6.18: [a20a0010eb6485f60cd64e15ebc85a4bd388642e]
stable/7.1: [60234845142fddb27db89ebc00a65178421fb3a4]

CVE-2026-80690: scsi: ufs: core: Initialize hba->rpmbs list in ufshcd

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80690

Introduced by commit b06b8c4 ("scsi: ufs: core: Add OP-TEE based RPMB
driver for UFS devices") in v6.19-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0279fd451a9971c0d5b959fc59f3e11b55e1694e]
stable/7.1: [a29db0c7f69572b048a63698e1214842d72221e1]

CVE-2026-80691: scsi: target: iblock: Fix wrong PR ops NULL check for
PREEMPT/RELEASE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80691

Introduced by commit 394f811 ("scsi: target: Add block PR support to
iblock") in v6.5-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c33222bd387312874fbe36ca8002e5c945b9653]
stable/6.12: [a326b19cfb7775378b50acaa8d836ba44e29b4c2]
stable/6.18: [bdd8a1297ef101bb5ac57e53b4fbe5e364afd8b1]
stable/6.6: [3c60a8b4037dc35e365658fcbcb349a5d742ff49]
stable/7.1: [f15bcf9a99b1b2683fcfa005b9b3680b5600581f]

CVE-2026-80692: Bluetooth: hci_sync: hold conn in
hci_connect_acl/le_sync() callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80692

Introduced by commit 881559a ("Bluetooth: hci_sync: Attempt to dequeue
connection attempt") in v6.9-rc1.
Fixed in v7.2-rc6.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [2f5d635ad5906b0235bc0c870e8beba3116e1e98]
stable/7.1: [9a77f296aff4b2ca5f2928ab3a3220c82d8b4074]

CVE-2026-80693: idpf: bound interrupt-vector register fill to the
allocated array

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80693

Introduced by commit d4d5587 ("idpf: initialize interrupts and enable
vport") in v6.7-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f7007ee9858c99aa43101bc8352c672fee85644]
stable/7.1: [41bb8748124d0d8ee5d8e1eace9dfbc874bc9564]

CVE-2026-80694: net: ethernet: mtk_eth_soc: pass eth to
mtk_handle_irq_rx in poll_controller

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80694

Introduced by commit 8186f6e ("net-next: mediatek: fix compile error
inside mtk_poll_controller()") in v4.8-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e095f249e2209674f6366f6db0383a2b96e19239]
stable/6.12: [3bd58ac9ca0c552651f533c1bd280dd19ae7d4e8]
stable/6.18: [276f1f180f55d56cf5992a581e20ed2b3dfa6ced]
stable/7.1: [7eb46318d53940dab63dea7130e720b67a656104]

CVE-2026-80695: hwmon: (sht3x) Fix unaligned accesses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80695

Introduced by commit 7c84f7f ("hwmon: add support for Sensirion SHT3x
sensors") in v4.8-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f46d5ab43a572b84773015a76966f5da56fc1748]
stable/6.12: [81529add4a2e3cca9240e0e2342973d62f88f02e]
stable/6.18: [c498adfd4c3e85306ccdc19b76e639bfc215f0e7]
stable/7.1: [1fb41650bc3e14d2a5ddb4bb25e96811e5afe881]

CVE-2026-80696: hwmon: (ltc4282) Fix reading the minimum alarm voltage

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80696

Introduced by commit cbc2953 ("hwmon: Add driver for LTC4282") in v6.9-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00feb1cce93dab948a299b69753d99c681d45a0b]
stable/6.12: [338d655fe09b95a88788c6ac8b1651ca8db9ae51]
stable/6.18: [08aee6d45eefc9e0b94c21bd442f47b21d64fa2c]
stable/7.1: [a0668ac20feaa3fff9e0c0548556368dbbd2d439]

CVE-2026-80697: erofs: ensure valid f_path for page cache sharing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80697

According to the .vulnerable file, this bug was introduced by commit
5ef3208 in v7.0-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96b2dbbe58a1ea5df8d29c2fe24b5f04715f4443]
stable/7.1: [3879657c4ffd81b9a42cf575fc6cb60201032587]

CVE-2026-80698: dmaengine: idxd: fix double free of wq, engine, and
group structs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80698

Introduced by commit 7c5dd23 ("dmaengine: idxd: fix wq conf_dev
'struct device' lifetime") in v5.13-rc1.
Introduced by commit 75b9113 ("dmaengine: idxd: fix engine conf_dev
lifetime") in v5.13-rc1.
Introduced by commit defe49f ("dmaengine: idxd: fix group conf_dev
lifetime") in v5.13-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec2d428b2e32dd157de8f86a86dd85c5b2c8f45c]
stable/7.1: [c93a9f652b7373ac8ee5bfcc18a9af76959b6c6c]

CVE-2026-80699: KVM: arm64: vgic: Avoid double-deactivate of IRQs in
the nested context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80699

Introduced by commit 6dd333c ("KVM: arm64: GICv3: nv: Plug L1 LR sync
into deactivation primitive") in v6.19-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a570b19b4b16a8a3b5ffa2b332bd5613110b2d8]
stable/7.1: [f78f08b38a7f121c7d6b3e41002d9de7fd3c9189]

CVE-2026-80700: drm/vmwgfx: validate external BO copy bounds for both
stride paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80700

Introduced by commit 50f1199 ("drm/vmwgfx: Fix prime with external
buffers") in v6.11-rc6.
Fixed in v7.2-rc6.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [706c93c5813caabbb0d0a576c017d15aeec2c113]
stable/6.12: [e7b25a6011781ebfdbc458552cae6d4156732771]
stable/6.18: [042ca38779554687fc32b66a28328e0d9a36c58f]
stable/6.6: [4e0f669e2951b742239c6fe847fcc406fe78748d]
stable/7.1: [5e4a2d15637a906cbd9bc98e0bf969f5f713e344]

CVE-2026-80701: drm/vmwgfx: enforce cursor size limits for MOB cursors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80701

Introduced by commit 9655441 ("drm/vmwgfx: Refactor cursor handling")
in v6.16-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5ed8749168ad13c0dbaa8300f68d854b6076966]
stable/6.18: [1eb4f796695be39e0b5c4383350033ced9ade703]
stable/7.1: [9109b7935b9c058b75348610ef8437c52f9020e3]

CVE-2026-80702: drm/vmwgfx: fix guest_memory_dirty bitfield clobbered as size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80702

Introduced by commit 668b206 ("drm/vmwgfx: Stop using raw
ttm_buffer_object's") in v6.4-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83195b778f2d109a3a4f3ffaba4dce7e4cdb58aa]
stable/6.12: [9d6cbb76fe9cd760351f6b0b20f1bf788eab8fa6]
stable/6.18: [282f261cb035e5f01a486f76d356b7e9dbfba73f]
stable/6.6: [21bbe38faee4a195d33a93e3908e307807f7745d]
stable/7.1: [3b2bb16a5b622867140d69925db411ac8ecb3b2b]

CVE-2026-80703: drm/amdkfd: Fix missing authorization check in
KFD_IOC_DBG_TRAP_DISABLE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80703

According to the .vulnerable file, this bug was introduced by commit
0ab2d75 in v6.5-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99b2fe4f19e3be0a8d0a0b5ea98d855970889653]
stable/6.12: [b8c05061997408bf81759f2dd31cd5f66771d15f]
stable/6.18: [9e52212aff8ed1fd9087728f61243ce3efd9d0ac]
stable/6.6: [ce813614f63b020a826071276a92f2cfae7cba79]
stable/7.1: [4070909ac042f44654aac72f7986ea550c96f591]

CVE-2026-80704: drm/amd/display: use proper context for logging

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80704

Introduced by commit 1296423 ("drm/amd/display: define DC_LOGGER for
logger") in v4.17-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [114b42507b6a23d9d24e24e4ef165233332c64d4]
stable/6.12: [a94e62b7c7018fcfe0251e53fa96af30f12d923a]
stable/6.18: [02647d98340738f918690ed227fdcf154db1b84a]
stable/7.1: [f556bc844cc4423e5ad41ae41a4c24f1cf75b978]

CVE-2026-80705: drm/amd/display: check if dml21_add_phantom_plane() is
successful

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80705

Introduced by commit 70839da ("drm/amd/display: Add new DCN401
sources") in v6.11-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [000acb4ce7fb9feba3072ce468ad681f6585cd5d]
stable/7.1: [062cfd6c678f6647c8841f684d6dadab08d95512]

CVE-2026-80706: can: softing: fw_parse(): validate firmware record spans

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80706

Introduced by commit 03fd3cf ("can: add driver for Softing card") in
v2.6.38-rc3.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [856d6cb04e5407523566b075841dcd6423757d1c]
stable/5.10: [f6d9a6a9512430b395a1940d7b216394fd02d30b]
stable/5.15: [84c850b08fc0d671c245144b619683129b55690a]
stable/6.1: [d0eac0ea7cf493e787fd7b4a556e43ef03cb4b50]
stable/6.12: [ad331e26fd213a19fee0de18cdacd67b7ff5b478]
stable/6.18: [2ee477e541a6d5e434d6a4041c6b677ab42e1d82]
stable/6.6: [ae588e5b9cc268de1aabf30f939f0870717ca164]
stable/7.1: [808ed899dcf8bdef66894fda5eb7ee4bb0eb8dc1]

CVE-2026-80707: can: j1939: transport: j1939_session_fresh_new():
initialize receive buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80707

Introduced by commit 9d71dd0 ("can: add support of SAE J1939
protocol") in v5.4-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb96c58907922546e415e545fe9a14ea63b02719]
stable/5.10: [348818277a3646d5b9fa60c9d20c00dc4bc86832]
stable/5.15: [f3e120a34b336079479fa10f706f0636eaa6e751]
stable/6.1: [bbfa49d1e287de44994955b44d19281be3195b44]
stable/6.12: [038bad8e16c2e28acf31f0b527a816fb23a57269]
stable/6.18: [8604a3b81b9d0ceaf04fee5f52e701f623a179f9]
stable/6.6: [194d67e92197eb820f4c2c6605d9721333b3eba0]
stable/7.1: [d5b3613c7d69d8dcb4dd6704f1f463198ce9f6cf]

CVE-2026-80708: s390/zcrypt: Fix missing mem scrub at clear key import
in cca_clr2cipherkey()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80708

Introduced by commit 4bc123b ("s390/zcrypt: Add low level functions
for CCA AES cipher keys") in v5.4-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01476391aecef36a3b789ee844357b22fbc90665]
stable/5.10: [8e1c0def77b7450be0ed607ed0d7bae629d30020]
stable/5.15: [be7ae07fb745d1cf575b03a178a055b0a2859364]
stable/6.1: [4e26d0d72bfdec311f12acfa0c6b7fbeb6a343d3]
stable/6.12: [b453003ae6a869f5bdf025b5519cbb38295ae4f1]
stable/6.18: [fbb0410986e8ad214121e51a4a28c3d0a10b7644]
stable/6.6: [7dd6e556dbfc91d3d511cfd1015d2dad42608010]
stable/7.1: [ebfbb9ac7adbb1e3556100b54a27e8a9b102feac]

CVE-2026-80709: s390/zcrypt: Fix wrong domain value verification with EP11 CPRBs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80709

Introduced by commit cfd68b3 ("s390/zcrypt: Filter admin CPRBs on
custom devices") in v5.18-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [983279d7f86ade73db86f886e09172dd567031b5]
stable/6.1: [4589f742718d0256ea6dd1f5a78be6e689bdb8aa]
stable/6.12: [13e53d6ae1c3b2ff1be75b9ef09be26f4ec3ce15]
stable/6.18: [672b12940e3f1336dfed5287412a71500adf2a76]
stable/6.6: [b505dcc8307d64468b463dfad45a03bf865c637e]
stable/7.1: [1223477ca88e2396eca440919d0ca8754df79bd5]

CVE-2026-80710: s390/dasd: Fix undersized format-check buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80710

Introduced by commit 8fd5752 ("s390/dasd: Add new ioctl
BIODASDCHECKFMT") in v4.7-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f40b346462f563a0d6e841a77b5163d2a882a04]
stable/6.12: [9f88dda2f22927d22498801a92cab6a9424eaf86]
stable/6.18: [e16e0fc54120cee3c6f0362de95aab6792865857]
stable/6.6: [aca18289c86f22d3fc2f3f6ff615286e7b1702f6]
stable/7.1: [87f3389cd3920714c53e704778f7ca7f1cf0c39c]

CVE-2026-80711: power: supply: max17040: handle missing status supplier

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80711

Introduced by commit f4b782a ("power: max17040: pass status property
from supplier") in v6.7-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [725668c6b6aa3971fe850659102c250d0d676e18]
stable/6.12: [91ac995a6f4ddf4f92b231b080544abf23a9b871]
stable/6.18: [b039f13e095d28a64ca6b21d0ee5440d8b048f37]
stable/7.1: [ee2ea0c452edc0930e7395b080dccd5a1cb965e1]

CVE-2026-80712: spi: spi-qpic-snand: write the feature value before
executing SET_FEATURE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80712

Introduced by commit 7304d19 ("spi: spi-qpic: add driver for QCOM SPI
NAND flash Interface") in v6.15-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8fd62901d6bf03f274a49dd0060793cc07dd51b0]
stable/6.18: [581e5166f0780103dc91c0d8ebc801f9af4824b0]
stable/7.1: [3ba021079ef2ac6e21e3547328496ac42d22b56a]

CVE-2026-80713: io_uring: preserve task restrictions across exec

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80713

Introduced by commit ed82f35 ("io_uring: allow registration of
per-task restrictions") in v7.0-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc0e8faf90e776a2f1f3967a04e8091e6bdb4977]
stable/7.1: [fcef9325afeecced693a7438e975e4a3f8e2716f]

CVE-2026-80714: ipvs: do not propagate one-packet flag to synced conns

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80714

Introduced by commit 26ec037 ("IPVS: one-packet scheduling") in v2.6.36-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a63d2dbaeb50a85d4c976b15a36e6b0c7113db5b]
stable/5.10: [06d1d9b56ef8132fbf85006885eb43d9510b8b02]
stable/5.15: [acbdc276091b308ca7794acb86e761f8203e2f59]
stable/6.1: [300348e3ba1521b003d59825f97e24f9a6859688]
stable/6.12: [4649e6faeecdc2d44bfa6ccbe405eef27e55d816]
stable/6.18: [b5ee5b266f833601ac4817f6df0bc496fc376a28]
stable/6.6: [44af98cc7d5ef8e730488d5df1eecd5deeaa5947]
stable/7.1: [e7acfc990c29890c883d0d0ce3f737d003a43b44]

CVE-2026-80715: igc: remove napi_synchronize() in igc_down()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80715

Introduced by commit fc9df2a ("igc: Enable RX via AF_XDP zero-copy")
in v5.14-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ffab5b9589c50e4cfc0cf36ffd76c89422d4019]
stable/5.15: [ad6e0df267dc96edb7de1fa0a2fb2a70645bff86]
stable/6.1: [605585a8d89aaeb0122e9016fdaa92376897a705]
stable/6.12: [f929a6fe5b7ae1e72d2c6d18cd69ab90dcf689d2]
stable/6.18: [3b5aee6fcbf6b58112d40d19c8d31fa3f78ee668]
stable/6.6: [a0f16c337691813f8d8f014c01fff5a368e08898]
stable/7.1: [9a2b637aef4e515c2179774888441d00e8a5ae95]

CVE-2026-80716: ALSA: pcm: wake linked drain waiters on unlink

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80716

Introduced by commit f57f3df ("ALSA: pcm: More fine-grained PCM link
locking") in v5.1-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f495b6c4c8594122918552c9be2b51eb71647cd9]
stable/5.10: [c172e4c53321ee6429955295ea133bc3597a3ca9]
stable/5.15: [3035bb784cea3f338934f5042dd3f35225a51b2e]
stable/6.1: [1c1b7e8e545ce65e40f65b55c432765e058ea98f]
stable/6.12: [e8315330e4ec09c0cac625515400e13d0ee22b81]
stable/6.18: [2940cc3cf43c72126b74ee6376314c195382023a]
stable/6.6: [e8b784a3f4fba3ea9c4d05138ecfa784a069627f]
stable/7.1: [db09bc4ab19ce548a078240d2374792523953500]

CVE-2026-80717: sctp: validate Adaptation Indication parameter length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80717

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74b21f52c5c5a71a05c0ff70e513f4f04ff28b17]
stable/5.10: [fa7861ddbe3b525b5d541c15c3953d3569e6eb0e]
stable/5.15: [4c92c601c061e5602db2edeea54fef74aa304027]
stable/6.1: [7b7e4e3640d57bd8857f0052c8b0d8ed4e5e954a]
stable/6.12: [5fd7cfc708dfc988ae9920c21075e6121bc89926]
stable/6.18: [17b412468c7a44f66a385bda48cdc1e94e39bd6d]
stable/6.6: [93942b5772e0eee4147d4799cc1b936ae12fa615]
stable/7.1: [bfa28cf99eb4d096c87da939f54233444d209ca5]

CVE-2026-80718: mm/percpu-km: fix bitmap overflow and accounting in
pcpu_create_chunk()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80718

Introduced by commit a63d4ac ("percpu: make percpu-km set
chunk->populated bitmap properly") in v3.18-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [89b1b79c308818a715e75f28744b70d8940a07c9]
stable/5.10: [5f43d2c1bea280dcdfabaf156c25e7402fb8039f]
stable/5.15: [92c43ac3c2b09eb16162e8144e73c00b7c3e29d6]
stable/6.1: [6fc7da2a052f2825fff785e860e67183f5acaaba]
stable/6.12: [a6940b84c8c035da465b7165fdfcfb005545724e]
stable/6.18: [32134cf9211b83bed9076d0739c5906fbea4c763]
stable/6.6: [01504da375f5b19df195cb1cb1cf1dd184318f97]
stable/7.1: [5c7fc39bf19abb38a996aaad77b3e3a8f48581c3]

CVE-2026-80719: mm: mglru: fix stale batch updates after memcg reparenting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80719

Introduced by commit f304652 ("mm: vmscan: prepare for reparenting
MGLRU folios") in v7.1-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de4660898b7aa7e03d3b120a6bfa6b26211e4e77]
stable/7.1: [fceb6b7f3ddec6ea9fc11577f4cf1b2da73a3101]

CVE-2026-80720: iomap: add a separate bio_set for iomap_split_ioend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80720

Introduced by commit 5fcbd55 ("iomap: split bios to zone append limits
in the submission handlers") in v6.15-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c679ce3be6cb63763d68ab9b5d9d73ddc0a40762]
stable/6.18: [cfc686a1174aa904dcad9b9a7c5e46b484d27e4e]
stable/7.1: [4a869be56e9f6ce7462abcf324ebdefc5de051be]

CVE-2026-80721: Bluetooth: ISO: ensure no dangling hcon references in iso_conn

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80721

According to the .vulnerable file, this bug was introduced by commit
dc26097 in v6.13-rc1.
Fixed in v7.2-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [aa9f7cb2bd3a2be998ceb739fc9a2f986eba43eb]
stable/6.18: [e941799c31f68e67ce0976efb38a79101f921b64]
stable/7.1: [cdce8af9291d8a1f8916c271de029bf558d9e8ec]

CVE-2026-80722: wifi: mac80211: validate individual TWT params before
driver setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80722

Introduced by commit f5a4c24 ("mac80211: introduce individual TWT
support in AP mode") in v5.15-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0502d5077e419427d80f4d46ba95d0067f5fb916]
stable/5.15: [92fcd0f30dc8e51f252589b082d46851d295cc1a]
stable/6.1: [09d60d1f72e6598241490eb6c4e97245af895c09]
stable/6.12: [ade9e2f0f7f4d3089600ac2af8ef0b91746f923b]
stable/6.18: [b558e07708d886acfcf4b0391ed7a8546e81d326]
stable/6.6: [ff558072d199c1d641d1561da622e67f780514de]
stable/7.1: [47fb04c3826e1f90271d405523043d6708b9072a]

CVE-2026-80723: of: reserved_mem: prevent OOB when too many dynamic
regions are defined

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80723

Introduced by commit 8a6e02d ("of: reserved_mem: Restructure how the
reserved memory regions are processed") in v6.13-rc1.
Fixed in v7.2-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [db3dbdfea1b8f38774419c5c2c14e4b81c48708d]
stable/6.12: [68d27250c9e81ab7764603e346c2b1017cb53adf]
stable/6.18: [cfa7e2734877330d6c10e0f33953905486c4530c]
stable/7.1: [de8ccbd6bf4efe7a059e2c483789936009e10f42]

CVE-2026-80724: ptp: vmclock: prevent read-only mappings from becoming writable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80724

Introduced by 2050327 ("ptp: Add support for the AMZNC10C 'vmclock'
device") in v6.13-rc1. Fixed by a5edadb ("ptp: vmclock: prevent
read-only mappings from becoming writable") in master.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5edadbae57e2298a56cf7a4e774a027905a331f]
stable/6.18: [5b4f2bec7bea6c04084d720d731bedee7caf878d]
stable/7.1: [2496e141827102d6af512950057d402a2cfb2bfc]
stable/7.2: [2e596e7814ba38cdc129991058b6c254ed37cb11]

CVE-2026-80725: net: gro: properly validate BIG TCP aggregation criteria

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80725

Introduced by 0fe79f2 ("net: allow gro_max_size to exceed 65536") in
v5.19-rc1. Fixed by 81be30c ("net/ipv6: Drop HBH for BIG TCP on RX
side") in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81be30c1f5f2bffda1f04c0efd0746af10b9643a]
stable/6.1: [37a5dcd6837fc2afc44a7bc3ed8af4e983783d46]
stable/6.12: [03cb8cc2961f5f781d12e903782cb3815ed84b1c]
stable/6.18: [3ce832e2bd431d0c12ba525ed73ad8fbc4191da5]
stable/6.6: [e907bf694ed55bdfe421be99dba35751a655df25]


* Updated CVEs

CVE-2024-46741: misc: fastrpc: Fix double free of 'buf' in error path

stable/6.1 was fixed.

Fixed status
stable/6.1: [4753cc37b6606ef9a7ec22861d380d45e2707f9a]

CVE-2025-38616: tls: handle data disappearing from under the TLS ULP

stable/6.1 was fixed.

Fixed status
stable/6.1: [ef50eaab631f9bf519ddbdfa42ccb0528adc1fc8]

CVE-2025-40074: ipv4: start using dst_dev_rcu()

stable/6.12 was fixed.

Fixed status
stable/6.12: [684efb2c86c887685f9aa65e1a21b3df6c1f822d]

CVE-2025-68794: iomap: adjust read range correctly for
non-block-aligned positions

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ce20f49ac9194cf81a77f01d1c316d7c17ae753c]
stable/5.15: [275b37a1e5c2c8abd313e8075f6aec9a349f291b]
stable/6.1: [b8c9f25fd84328c5fcc4f70c6d1e8f1d4787eaac]

CVE-2026-45839: bpf: reject negative CO-RE accessor indices in
bpf_core_parse_spec()

stable/5.10 was fixed.

Fixed status
stable/5.10: [c8e49b79c4b48bd687706ff6e9c82638dc81ef80]

CVE-2026-46158: mptcp: pm: ADD_ADDR rtx: always decrease sk refcount

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [e9ba34301d2e90f63f97c76ad9eb98e5250fe961]
stable/6.1: [81d8142148164176385c279c7c1e1d581867423d]

CVE-2026-46170: mptcp: pm: ADD_ADDR rtx: free sk if last

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [1f26487e83e69462540bb1047139472957c913c6]
stable/6.1: [5da972efed3dc7599da6e2b5e8d906d1b7b1a728]

CVE-2026-64216: netfs: Fix potential UAF in netfs_unlock_abandoned_read_pages()

stable/6.12 was fixed.

Fixed status
stable/6.12: [d4ae8dba90b89e7bb4d1045d1cb26afbaf13ee5c]

CVE-2026-64561: KVM: x86: Check for invalid/obsolete root *after*
making MMU pages available

stable/5.15 was fixed.

Fixed status
stable/5.15: [62ef67af1878fa2cd066642f2f59e33ade95f637]

CVE-2026-64581: xfrm: fix sk_dst_cache double-free in xfrm_user_policy()

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.18,
stable/6.6 were fixed.

Fixed status
stable/5.10: [e8686fd8d18b99f3a9038683045b2f2338a7706d]
stable/5.15: [a9340ebdc13f8bb5063c0bc0b037ee7e640d4ae9]
stable/6.1: [f833821e4b52ab6335d443ede5fb79c38e61d19a]
stable/6.12: [8dd8929b71c4f06c614f8f54c2cc070453faae16]
stable/6.18: [0ea8f06454012d9e7f9c6e6253df710949bf6294]
stable/6.6: [f0ab9a71167bae308e05ab13b65e2007504a603f]

CVE-2026-74509: Bluetooth: hci_sync: Fix advertising data UAFs

stable/6.6 was fixed.

Fixed status
stable/6.6: [c4cec575a6d6f7c36808a3a0017b0675968bb06b]

CVE-2026-74582: packet: use consistent hard_header_len in non-ring send paths

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [bcd4df60ac9481b1ceffdfe5ec38fe51dcaae812]
stable/5.15: [78a47127e33c340bc6d38dcc4552a094b4f5cc77]
stable/6.1: [142e287b3a25cfe909215177c23243e7fc5ae2b1]

CVE-2026-74626: NTB: ntb_netdev: Preserve RX queue depth on allocation failure

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [6d7f8a23c130d768c0976c2578b214353674e18f]
stable/5.15: [18781cc0bfb5c7f2a51ac6d678a28f101b7c35c5]
stable/6.1: [272df0fbe6f3e04e22bc67fbdd9ac24586b942f4]
stable/6.12: [3f2a15f33f86f7bd5b920669fd40c06725d72a1e]
stable/6.6: [fcaf8ba7e56bb73319ac107a63b907d59536192c]

CVE-2026-74628: net/x25: fix use-after-free of the socket by its timers

stable/5.10 was fixed.

Fixed status
stable/5.10: [ba925a2e98ce967a0e71c5bcbcf5dbd3facaf0c8]

CVE-2026-74632: mm/huge_memory: fix huge_zero_pfn race

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [9c0fd1802ce06d7709f0bae4edeb085288f28764]
stable/5.15: [b7041ba61c5da4e0b56f9be58cfb87d7689724e4]

CVE-2026-74637: perf/core: Fix group leader use-after-free after sibling detach

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [8f867c0e8da4c2303d91adf45acb6b1820966c27]
stable/5.15: [8e92e03984364d93e0d5b0acd81c95eca773f034]
stable/6.1: [f8a07021679aadfb6d63b209207ccc41f26982d1]
stable/6.6: [80c6054a4c40a0ffad82acef9f9a0dee108d152a]

CVE-2026-74647: misc: fastrpc: Remove buffer from list prior to unmap operation

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [1edb654b2b41baee2ab5cf418baaf6e57dfbd802]
stable/5.15: [4716c23c206a2f99ca54ebfdd8b5ba9dd0102240]
stable/6.1: [99f8de36c84cb9b872157aa6c3578c2480cee4b8]

CVE-2026-74650: staging: rtl8723bs: fix OOB read in WMM_param_handler()

stable/5.10 was fixed.

Fixed status
stable/5.10: [5df2fd06567df5f178c8faae0bdaefd203618d21]

CVE-2026-74653: serial: 8250_of: clear stuck empty-FIFO RX-timeout on LPC32xx

stable/6.12 was fixed.

Fixed status
stable/6.12: [c321dc5172c8c66e21ffbeeb7a2ebb88ae6fd4c3]

CVE-2026-74655: serial: qcom-geni: fix TX DMA buffer flush

stable/6.6 was fixed.

Fixed status
stable/6.6: [1606abb7ce8c0cfef98c7e556b83c14e5d73c1bf]

CVE-2026-74657: ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops

stable/5.10 was fixed.

Fixed status
stable/5.10: [57195f0ab5cfbb5ee0864e5aff15ceb48f5a5e28]

CVE-2026-74662: inet: frags: publish queues before arming timer

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [f4e4dab62181b7fe7c011bed6fbef9fc3d48c769]
stable/5.15: [4ed0681dc2c1e0538b79d2fc56190ffcb369dacd]
stable/6.1: [08a04d7bfb9c103432561aff8a62b6872e694a6a]
stable/6.12: [39c6c4b267b65f00e0b0335a2ae00cbe9e3174f0]
stable/6.6: [d3ffb89b2944672cf7bdd8e9ee577d2043b4a956]

CVE-2026-74663: net/sched: reject overly deep qdisc hierarchies

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [08dc49df1527b09d9ea225a7265bbf6c237097bf]
stable/5.15: [a627d36c2a94e18c8c105ae68008786dfd85592e]

CVE-2026-74666: packet: synchronize pressure clearing with ring reconfiguration

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [bf3c8e86bc8ad111be3f3136125e255344bcb3da]
stable/5.15: [8cfb2e71926a682f36c4240067d424074dd8f70f]
stable/6.1: [f015c9de92b731814059a343b765c60c0196225c]

CVE-2026-74668: packet: use consistent hard_header_len in TX_RING send path

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [9c7e8ff48c377bef18c3d178748aea0575b69ede]
stable/5.15: [2a73b2c37ee3060a880b53cd24783d93fc7be5f8]
stable/6.1: [e79f59a8527a49078cfaf8fe8fb5fcefc20c76d2]

CVE-2026-80534: xfs: fix ilock leak on error in xfs_dq_get_next_id

stable/5.10 was fixed.

Fixed status
stable/5.10: [e4c05ebd01e910bccd4f7e9517c7353982e27763]

CVE-2026-80536: xfs: bounds-check buffer log item's dirty bitmap

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [acb4e26295e7f0e685815a3fd3d70bd8329cefa1]
stable/5.15: [f3859c35a4fbc1c1c58431f684f808e43696891d]
stable/6.1: [f7b5fa83e2c192be922121b764415fa8c7549ea1]
stable/6.12: [7e32d4eebae6ca24f8a673c107fd7eca1f47afc2]
stable/6.6: [b7528b42813f02724a78fce1da24d69d1bfc4d38]

CVE-2026-80539: drm/amdgpu: disallow multiple FENCE chunks in one submit

stable/6.1 was fixed.

Fixed status
stable/6.1: [7e9954e7212042ec808b06181b365b14f00c6f0a]

CVE-2026-80547: s390/vfio_ccw: Implement a crw lock

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [3c94d4179bcc19e01b28db634c07a58b28116209]
stable/6.1: [0edd222730a9d7ec98368aaf1d40ee2d8d862e61]
stable/6.6: [a3d60ae24183eee352c8e87a0ff94c97cd87f156]

CVE-2026-80548: s390/vfio_ccw: Selectively expand io_mutex

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [dab6a6627b0b0cce23653e99c7b0bf8c6cfd82e0]
stable/6.1: [56d7488533ceac4e986e96e15c9e487a2245bc01]

CVE-2026-80549: s390/vfio_ccw: Move cp cleanup out of not operational

stable/6.1 was fixed.

Fixed status
stable/6.1: [c9b85aa2cf73ea645e55e2c2670e0ddebfe1589b]

CVE-2026-80551: s390/vfio_ccw: Ensure first IDAW remains constant

stable/6.6 was fixed.

Fixed status
stable/6.6: [460b977a4e71cc319fdadf91c193ec3beaa57263]

CVE-2026-80552: s390/vfio_ccw: Ensure index for read/write regions are
within range

stable/5.15 was fixed.

Fixed status
stable/5.15: [3acbedf5c0b8e0971f0de423c05cc02bbf6ddb99]

CVE-2026-80553: s390/vfio_ccw: Cancel existing workqueues

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [87d569cb35a541b31a184faf982540694d4c9a89]
stable/5.15: [7492ca2d0c5d59add01e267be9f5a6eeb8076fd7]
stable/6.1: [b94b28c1f0fae53b2f2d6180ae6442c9a1558f67]

CVE-2026-80555: s390/vfio_ccw: Free all memory if cp_init() fails

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [276bd7ed34d56c48c65c43c0b08f2ee77029b2fa]
stable/5.15: [f9bcff265556796834122f95de16d52a8375206c]
stable/6.1: [17e01e342af74de12899c206dcc9ec90684703aa]
stable/6.6: [152fcb74a26804b70909381c6acc90595a0ae1c1]

CVE-2026-80557: libceph: fix OOB read in decode_watchers() via missing
bounds check

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.18,
stable/6.6 were fixed.

Fixed status
stable/5.10: [85479b7d65b4ebcb07fbbe57230976793974ab4a]
stable/5.15: [1c824e7c75bb4adf19553dd4ea944a5d83096be8]
stable/6.1: [f161be39201eb5f9b1f58fb8f90b8a9cd3931eb6]
stable/6.12: [c59219a6b62d74936963983e5815524c3de8dd79]
stable/6.18: [cb8246e5846dbbe34930903a90c7a90dd8e5910b]
stable/6.6: [eab3eeb68bfc639d74f27256f05546af5c4f787d]

CVE-2026-80562: gpio: ml-ioh: use raw_spinlock_t for the register lock

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [431b10133113537660a6090a2856b0d74d1b06de]
stable/5.15: [359e6b1168c9a62a7bd214ace476aaa2d57eebe8]
stable/6.1: [63d2230e5076c12f93d2a1d1bff2fbbf6cf32f3c]
stable/6.12: [84be002b40d30c56a91873b236e2d9001bbee363]
stable/6.6: [b6505a4cea45dd92eb753581b1ad9b524b5fcc34]

CVE-2026-80572: Input: byd - synchronize timer deletion before freeing
private data

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [84b205297fa15f97510342221d8c9a0119711478]
stable/6.12: [ee944a706a18322b4a2599eebe8040a2994e928f]
stable/6.6: [28d984a66b9e14be74986167b6ad40b5e0daf19a]

CVE-2026-80581: ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in
case of IPC timeout

stable/6.6 was fixed.

Fixed status
stable/6.6: [4931c09d83877dc350106bae745321c3f295129b]

CVE-2026-80583: ASoC: codecs: lpass-tx-macro: Fix enum kcontrol accesses

stable/5.15, stable/6.1, stable/6.12, stable/6.18, stable/6.6 were fixed.

Fixed status
stable/5.15: [dbc81b518f6936131bfd858be71cd4295136809c]
stable/6.1: [f84f2c81d792cf1e65571108a3bdd2c29e09e995]
stable/6.12: [2ed3601e9db08fbdb071bd3d7bd8f115d6d871b0]
stable/6.18: [b6baab796d11fb84c0e9444ffca91af5eab22c25]
stable/6.6: [48b76879f5bfc8584b99052510ac645c6ade8d2b]

CVE-2026-80587: mptcp: avoid combining some incoming suboptions

stable/5.15 was fixed.

Fixed status
stable/5.15: [0e2210af439755a2af352eea4178261dcf61742e]

CVE-2023-54141: wifi: ath11k: Add missing hw_ops->get_ring_selector()
for IPQ5018

stable/6.1 was fixed.

Fixed status
stable/6.1: [d49d420e4833fdf6d7c506de23884a0cb9b08e0a]

CVE-2023-54263: drm/nouveau/kms/nv50-: init hpd_irq_lock for PIOR DP

stable/6.1 was fixed.

Fixed status
stable/6.1: [a63fa556ac5772d004025c1164b7bd5a8b95eaef]

CVE-2024-27010: net/sched: Fix mirred deadlock on device recursion

stable/6.6 was fixed.

Fixed status
stable/6.6: [524323f52cbfbac4fe3f8a33a8cc405fafba0d33]

CVE-2024-39478: crypto: starfive - Do not free stack buffer

stable/6.6 was fixed.

Fixed status
stable/6.6: [bfd861dadd3a45de257b3d328bf49b64a6f9c5f1]

CVE-2024-46754: bpf: Remove tst_run from lwt_seg6local_prog_ops.

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [ea3fae6984ba0f054550e4da22219489c12cd8d4]
stable/5.15: [a675524cfbe88fd49c05ff8807a08646983e687c]
stable/6.1: [b05c2e25a5c168dbb46b6f7fcb741fd4e4f3b54a]
stable/6.6: [e217492f6fa2228ad703ee3006d8fc4e5969fbd4]

CVE-2024-58094: jfs: add check read-only before truncation in
jfs_truncate_nolock()

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [b98506e61e1bb6764c6711198cfab826df8ca952]
stable/5.15: [1fee021d6cf1d41b3f6e3fd028939be8f5d5c5db]
stable/6.1: [b57a8983916fc2cf54fd8de3afc733c6b3d1c0e5]
stable/6.12: [77038187890ea82d237b05c8a9c4e08a38b1efcb]
stable/6.6: [41da1715cd24e177678f93ee27f737b095fc838b]

CVE-2024-58095: jfs: add check read-only before txBeginAnon() call

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [97ac32b08442f5327867ad7d70d6ac6ebaa2a41a]
stable/5.15: [93f11ab37f1c657f4265228ba3c2ff66bbefa24d]
stable/6.1: [469bd67fc338e77d7585e4f20d4212afd44fefdc]
stable/6.12: [939dba7a6404d4ac88e2539cb21ac659f5757fd9]
stable/6.6: [47a99881ecc50ff2bf4e7a6c3058fe1704073df9]

CVE-2025-22104: ibmvnic: Use kernel helpers for hex dumps

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [19efa170e01207c8ada726f3f6c65b31fcba2a73]
stable/6.12: [005fee039dd845122d313ac8f2122b0d09dc5d7b]
stable/6.6: [9bc078818ec76344c2e06b81d7aee2df3adecfbf]

CVE-2025-38203: jfs: Fix null-ptr-deref in jfs_ioc_trim

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [4a2de0f5b8d7f218bea5bd43d30b466e8b272b8d]
stable/6.12: [233340626cf1b1887dca181f9f811db60c73f802]
stable/6.6: [a39f811a9f5edb6d97bede8e6fe730393d3c8537]

CVE-2025-38206: exfat: fix double free in delayed_free

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [ea27703eb0efbadcd45b9949526160ed90536a72]
stable/6.12: [29abaf93357f4a7d083cf399d4306999e20db31d]
stable/6.6: [ac65f76db9b2ff3fbc9e198c0e9aaf81b111b7d0]

CVE-2025-38237: media: platform: exynos4-is: Add hardware sync wait to
fimc_is_hw_change_mode()

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [9b03c3ce32a685f9cb82d33c63fc18bfcee0ba1b]
stable/6.12: [2fbe83fe23f541798bcdd7d6b56a08d4ac205bad]
stable/6.6: [71209954f1e8ff0f0ba944c8d3b64bbed83d400c]

CVE-2025-39833: mISDN: hfcpci: Fix warning when deleting uninitialized timer

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [d8be1288e398ccda2dc590fdaa0551f192f6a1c6]
stable/6.12: [544ffd62ddd093c71150e4d4c542f98153fb8e46]
stable/6.6: [75194165e65018c581b128379b91b0b2d64638d9]

CVE-2025-39925: can: j1939: implement NETDEV_UNREGISTER notification handler

stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.15: [479d8a2aedcc1db16f14c1a8a9c74b5bdf18b9ac]
stable/6.1: [2c88069fac2c792e228e6a4ae71c9b9b5b9a87a6]
stable/6.12: [4e154cb5e7681c2910e2dfa09f05e3469e333745]
stable/6.6: [76957b618ce729c3bd1e782fbc9d9991af653925]

CVE-2025-40064: smc: Fix use-after-free in __pnet_find_base_ndev().

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [005a7173d8e4710646043a681af36f79ce05a29b]
stable/6.12: [08aca586482e88aab9616a3e81bc36cad22674a5]
stable/6.6: [302dbed4760bcd19a661cc1c282d91bb7481307e]

CVE-2025-40102: KVM: arm64: Prevent access to vCPU events before init

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [b0ab34a9e4cd5b88b522cc156e792cefe3085334]
stable/5.15: [d64461d38972302f0243498ff409b0d54e14e106]
stable/6.1: [b498f0da45a388b40195f7198455c62fe366a372]
stable/6.12: [c0fcd72e7eb50205dc20731033b0b1c67ecbe4dc]
stable/6.6: [7b854e68365a84dfa984ee81268e10b9311ac9d2]

CVE-2025-40139: smc: Use __sk_dst_get() and dst_dev_rcu() in in
smc_clc_prfx_set().

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [5a2fccc4b32c13ddde3676f9e15e1a9baa7d6fde]
stable/6.12: [956c57daba55cf9ed25d9f2512883b8a1a927599]
stable/6.6: [80d1fd39f4e37d836655e9f7ffccaf78925049bf]

CVE-2025-40168: smc: Use __sk_dst_get() and dst_dev_rcu() in
smc_clc_prfx_match().

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [3f119c37aa293af41400cccb3d89fab8dcf774b0]
stable/6.12: [326e5cf301d0bec0a672aa834d8254c4f9df6255]
stable/6.6: [4f5f52a5842937f945582a93cb9daed9ea526fee]

CVE-2026-43437: ALSA: pcm: fix use-after-free on linked stream runtime
in snd_pcm_drain()

stable/5.15 was fixed.

Fixed status
stable/5.15: [f2cb2e0d27fb925c73a78f0ce7d6dbf68d3747c1]

CVE-2026-45963: ASoC: nau8821: Cancel delayed work on component remove

stable/6.1, stable/6.12, stable/6.18, stable/6.6 were fixed.

Fixed status
stable/6.1: [cd6b991de3e0b68560fe98dc739672747d2e4204]
stable/6.12: [9210ae708ddead67f55610342ea03fe9d4de6005]
stable/6.18: [13d20517bee1c9b69c7750026c61e7ec021080a4]
stable/6.6: [36fb28fa033f6544d81f1cc056b27d0c0bf26d4f]

CVE-2026-46266: inet: RAW sockets using IPPROTO_RAW MUST drop incoming ICMP

stable/6.1 was fixed.

Fixed status
stable/6.1: [47276297140ee6712646f9b19fb04fe26daedd01]

CVE-2026-53089: bpf: Fix use-after-free in offloaded map/prog info fill

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.18,
stable/6.6 were fixed.

Fixed status
stable/5.10: [43d6848a2a6c92ccfd614d9f0bb6fd85b95dfa9d]
stable/5.15: [642943ae5bdacabc8109dc4a5e0ebb4a6b99ef3e]
stable/6.1: [fea55b034328feaafef75aee252f305e6f85a991]
stable/6.12: [1a2dc103e16448d022a77ad5fc3234641436c4b7]
stable/6.18: [85dc711f742b192eb97c0e00b521312f5a7a415e]
stable/6.6: [5662dac41a3442aa378d7c405164903eb109fc05]

CVE-2026-53242: ALSA: PCM: Fix wait queue list corruption in
snd_pcm_drain() on linked streams

stable/5.15 was fixed.

Fixed status
stable/5.15: [06eca2235a3fd281dddf25b0a97772b25b5bb573]

CVE-2026-53275: ipv6: mcast: Fix use-after-free when processing MLD queries

stable/5.10 was fixed.

Fixed status
stable/5.10: [dfaf1f5e7eb81be87582bd6a57d34e61a57d5dea]

CVE-2026-64070: powerpc/hv-gpci: fix preempt count leak in sysfs show paths

stable/6.12, stable/6.18, stable/6.6 were fixed.

Fixed status
stable/6.12: [45afabe7f99c5d8746434ee41c86584c01d70147]
stable/6.18: [b61ebb2826ca1852c2bbd92a676fb622c358cab4]
stable/6.6: [b300312562fd6e4729697adb9f777f00ca0429f3]

CVE-2026-64082: riscv: Fix register corruption from uninitialized cregs on error

stable/6.1, stable/6.12, stable/6.18, stable/6.6 were fixed.

Fixed status
stable/6.1: [f2d88b0d7aebfa4643fc58bbae57210c6daff9c6]
stable/6.12: [2a7d1daf2674fe7d5b1cc99a4e3b5f0f72d5958f]
stable/6.18: [0599aa23734c48de9bce36d043a9ec90c23945a1]
stable/6.6: [66dedb6028c3df6c6a3372dd935b823917e150d5]

CVE-2026-68476: ipvs: reload ip header after head reallocation

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [4f2d1151421520d7ae16ca8d367d0ca09f5dfbd7]
stable/5.15: [657118cad620172dfd8f6ed5717fd75c0d1f7a5a]
stable/6.1: [a10f5080afbed242640f2984328de25f84557da1]

CVE-2026-72323: ipv4: igmp: Fix potential UAF in igmp_gq_start_timer()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [7265c747eec415ca3109a6a14a419f7ae433b780]
stable/5.15: [d107b4c4f8274763b7ea5ab05d45cef78e4b81ba]
stable/6.1: [74b301f7f197517016befb5f5dfab01f7bc64be5]

CVE-2026-74753: perf: Reject exited events as group leaders

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [e593031ff19a9484e8a00bc47edd447187721846]
stable/6.6: [ce12e1170c0c78dffb9b28af6d287492ae7dd99d]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

