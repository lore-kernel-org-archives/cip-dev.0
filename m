Return-Path: <masami256@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90382C433EF
	for <webhook@archiver.kernel.org>; Wed, 29 Dec 2021 23:29:42 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web08.58559.1640820580965315944
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Dec 2021 15:29:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=KBkWWirw;
 spf=pass (domain: gmail.com, ip: 209.85.167.51,
 mailfrom: masami256@gmail.com)
Received: by mail-lf1-f51.google.com with SMTP id g26so50847540lfv.11
        for <cip-dev@lists.cip-project.org>;
 Wed, 29 Dec 2021 15:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=9+8DJbQXapkGzjQgCvD4DZbD+HmCqufz1wWT4vaP0mA=;
        b=KBkWWirwJ1FarUY9dBW8jyoOatYapBs/PiF5zO/Me6FvLnQwPM1fmHSdmofo/vCgBY
         cW4Zu+xu5ybygcA6CHlO6Ld1itJfekOyiLbQqeASy3Y4eBx3CJi9HGXq1dOVM2ATxvMs
         c3qlg8WTGfstVX6/NbJK56KmzlJQGmANS8hSSuc3C6wGPkqo3otxwq3gvGprQ9UC2esH
         /grUbm7yUIrl1d2LJyLW8pNg/yiJBy+dsliD5mzVxFYZa+RIstludT5k3GALkkyfunEq
         2DZAURbRTpxRlFMK1SD8LvMC5DHjDAunIQMpS9uwY7qhkTHaSCpD1YHVUE5AakixkJ+V
         shWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9+8DJbQXapkGzjQgCvD4DZbD+HmCqufz1wWT4vaP0mA=;
        b=CkoiG5y7sWeafmeE9P0CVk+ELvLB7v0Q2dIWujRudugS50FiTLfeCHw8HMc29Irsc1
         /HQaUOATWBZ9BH9yKiDQtlfFDAHSgC5y29P1Pb3ABIoMEi3EAZto3wYVw0NOyPijOSwG
         XYnyjEDA7gwDEmMREZKbVbNRsZCZDhaoSTZn4HroWByOFKlxu8KeSApZfMWFAGfOWPbP
         azo8lgblwRwbah5XiVyXfBK+/YAV/QKJg9TtR9A2hBPTaMaNyVz9bKH5qpbPK66+8bek
         dj9lYbjO6pWG6c/xx/0SFCEgOqM2eZo6GOujfTDKZyB9/0RyxZ1QZ6IQGFxy6nuTMEaC
         Ziwg==
X-Gm-Message-State: AOAM531b2+sLX+WuE2SOUfEfFsUn2bCmC9k9pVUSGQKe7Kb4TNG6uHOu
	D1vsbT70LODnFsr/ARwJ0K9aL4Xfn7IMnPDpWRNqdNGUX64=
X-Google-Smtp-Source: 
 ABdhPJyDjusXJQlstXikQHI5re8P7oiHPP4ydFPytFaAKq5Ffd5XNJsc3LIHY+6NiP2SdgcqbT/QYa6bhJJhedCTo3k=
X-Received: by 2002:a05:6512:159e:: with SMTP id
 bp30mr24957130lfb.572.1640820578533;
 Wed, 29 Dec 2021 15:29:38 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami256@gmail.com>
Date: Thu, 30 Dec 2021 08:29:27 +0900
Message-ID: 
 <CACOXgS9X11kXTPC+ukH2aommTWahwWSuAcuqXveZPpT2YiNBZw@mail.gmail.com>
Subject: New CVE entries in this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Dec 2021 23:29:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7309

Hi !

It's this week's CVE report.

This week reported six new CVEs.

* New CVEs

CVE-2021-45469: f2fs: fix to do sanity check on last xattr entry in
__f2fs_setxattr()

CVSS v3 score is not provided

OOB access bug in  __f2fs_setxattr().

Although it is fixed in stable trees, the patch isn't merged in the
mainline yet at 2021/12/30. The commit 5598b24 ("f2fs: fix to do
sanity check on last xattr entry in __f2fs_setxattr()") is in
https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=dev&id=5598b24efaf4892741c798b425d543e4bed357a1
but not in the mainline.

Fixed status

stable/4.19: [f9dfa44be0fb5e8426183a70f69a246cf5827f49]
stable/5.10: [fffb6581a23add416239dfcf7e7f3980c6b913da]

CVE-2021-4154: cgroup: verify that source is a string

CVSS v3 score is not provided

UAF bug was found in cgroup v1 code which was introduced by commit
8d2451f4994f ("cgroup1: switch to option-by-option parsing"). This
commit was merged at 5.1-rc1. This bug will cause local DoS.
The mainline and stable kernels are fixed.

Fixed status

mainline: [3b0462726e7ef281c35a7a4ae33e93ee2bc9975b]
stable/5.10: [811763e3beb6c922d168e9f509ec593e9240842e]
stable/5.4: [c17363ccd620c1a57ede00d5c777f0b8624debe6]

CVE-2021-4157: pNFS/flexfiles: fix incorrect size check in decode_nfs_fh()

CVSS v3 score is not provided

This OOB write bug was introduced by commit d67ae82 ("pnfs/flexfiles:
Add the FlexFile Layout Driver") which was merged at 4.0-rc1. A local
attacker could do system crash or escalate privileges on the system.
The mainline and stable kernels are fixed.

Fixed status

mainline: [ed34695e15aba74f45247f1ee2cf7e09d449f925]
stable/4.14: [40286f0852d2ecfa713438199557c706dc6a8db3]
stable/4.19: [f27638a92f77d8107efbaf48a0d3bfa24da8cdad]
stable/4.4: [0c5ccd5e2a2e291774618c24c459fa397fd1b7da]
stable/4.9: [c621f3654bba1096ec913d0942e27bd032bb6090]
stable/5.10: [1fbea60ea658ab887fb899532d783732b04e53e6]
stable/5.4: [89862bd77e9cf511628eb7a97fe7f8d246192eec]

CVE-2021-45480: rds: memory leak in __rds_conn_create()

CVSS v3 score is not provided

This bug was introdued by commit aced3ce57cd3 ("RDS tcp loopback
connection can hang") which was merged at 5.13-rc4.

Fixed status

mainline: [5f9562ebe710c307adc5f666bf1a2162ee7977c0]
stable/4.19: [1ed173726c1a0082e9d77c7d5a85411e85bdd983]
stable/5.10: [74dc97dfb276542f12746d706abef63364d816bb]
stable/5.15: [68014890e4382ff9192e1357be39b7d0455665fa]
stable/5.4: [166f0adf7e7525c87595ceadb21a91e2a9519a1e]

CVE-2021-45485: ipv6: use prandom_u32() for ID generation

CVSS v3 score is not provided

CVE-2021-45485 and CVE-2021-45486 are related issue. A bug fixed
commit 62f20e0 is a complement to aa6dd21 ("inet: use bigger hash
table for IP ID generation") which is CVE-2021-45486.
The mainline and stable kernels are fixed.

Fixed status

mainline: [62f20e068ccc50d6ab66fdb72ba90da2b9418c99]
stable/4.14: [4b55d7b3106a410cdab4ea60f5e55ca0668c6a09]
stable/4.19: [f0be58ec9931907e980cf21737e51d369808eb95]
stable/4.4: [c43fa9ee9f1de295474a28903607f84209d7e611]
stable/4.9: [3fc852e59c0a48094cc0f1b2e866604986bbcd31]
stable/5.10: [8f939b79579715b195dc3ad36669707fce6853ee]
stable/5.4: [ccde03a6a0fbdc3c0ba81930e629b8b14974cce4]

CVE-2021-45486: inet: use bigger hash table for IP ID generation

CVE-2021-45485 and CVE-2021-45486 are related issue. This CVE fixes
commit 73f156a ("inetpeer: get rid of ip_id_count").  The commit
73f156a was merged at 3.16-rc1.
The mainline and stable kernels are fixed.

Fixed status

mainline: [aa6dd211e4b1dde9d5dc25d699d35f789ae7eeba]
stable/4.14: [3ba51ed2c3ac36aa947d0b250d318de6ed7cf552]
stable/4.19: [7f7e23df8509e072593200400a4b094cc44376d2]
stable/4.4: [8fb8c138b5d69128964e54e1b5ee49fc395f011c]
stable/4.9: [0889f0a3bb2de535f48424491d8f9d5954a3cde8]
stable/5.10: [a273c27d7255fc527023edeb528386d1b64bedf5]
stable/5.4: [fee81285bd09ec2080ce2cbb5063aad0e58eb272]

* Updated CVEs

no updated CVEs.

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26555: BR/EDR pin code pairing broken

No fix information

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
/**
* Masami Ichikawa
* personal: masami256@gmail.com
* fedora project: masami@fedoraproject.org
*/

