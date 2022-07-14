Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B9EC43334
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 00:54:58 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44])
 by mx.groups.io with SMTP id smtpd.web09.2233.1657760094981713387
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jul 2022 17:54:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=vYwOG0x3;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.44,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-10c0430e27dso704503fac.4
        for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jul 2022 17:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=crGN5UGxTPzXUb2OgNyfGzVdYKTOsQmbyWNRgdH+aH8=;
        b=vYwOG0x38GYhE8GExzgjWFHQ+X1MrBwDxWDYwn+8cMjVqTfRveAznSqgFJcylfhJwM
         2V8Kleybc4M1tyzkSNxuxYzMeyGPHgJ4u9Wt9OaGq01tTxbNuSc7lt+XFRyMwyIe3udz
         WUscxVdJwBD9COVqQOLD/QqJuyaJKrIU5KQKteqO12uD+f+0pSE1P93onwbJIA0ubNJX
         o8WYMcjEWcbCfaiqRT3hoNSaycKhqiGwV755KJ0zXRs6sNLLxMBqwjFhi3Ep8Xzd7nwV
         2HoOmT8wuU0i91vPg7FaO8Qrz0XILMIqQ9yPEeysKGYA3NbJt+PzZ1kMBvo9jvZFDeL0
         HlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=crGN5UGxTPzXUb2OgNyfGzVdYKTOsQmbyWNRgdH+aH8=;
        b=61CDvoERaWfrGBRWnXDsaw/s8usbKtjUxHcjH9zl0USM1PDFuLqE/L4CCuP0hlC5FK
         NJUgyuGPhAl4nQOcWf1dXxsr/aG+mLCpXR/8dpzPQPO1VP9mJHYSL+n2fLXyAt1PyuRg
         xP+MPdDrJ40WHb7mYYv4B2D5YDCGFeAltzu8ixiGU86XbBLl4VGLNA+Y+gbEpdzdP8sl
         p8RzGsNQctcefPzSx+dSoUxtguej/vhH7j55TlDEEHWaN7DFiDAVcQR0BlN/ccWpgspV
         VKrkFk63rO0awbJv8j9Y9StHQMCysLBpBRXzdcvrUXYpUN8MgcaINARqeofrBLUei68d
         7EyQ==
X-Gm-Message-State: AJIora9leXQ70OzGZYO1l+OqCxYQddQqFCXPAHHTgTPX4WqNXcNPGBVp
	UbNFSX45HrwZbrZxG5zCsnWqB09x8tWqLr2F9WZuyEaFi2v1Sw==
X-Google-Smtp-Source: 
 AGRyM1tgvcFGb2F7Ss08oY40cT3KM4W694+pk/DYLmQPE8okDukzTPrKM7t4EcGdStOG0zxuuX9daDn6YmlQZyfb5GA=
X-Received: by 2002:a05:6870:c889:b0:10c:7f1:c6b8 with SMTP id
 er9-20020a056870c88900b0010c07f1c6b8mr3199989oab.280.1657760093539; Wed, 13
 Jul 2022 17:54:53 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 14 Jul 2022 09:54:17 +0900
Message-ID: 
 <CAODzB9qH9WhxQ0eB+mNvmsn64bHXUVppuSTMDGJekYOPCwk-HA@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Jul 2022 00:54:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8752

Hi !

It's this week's CVE report.

This week reported 8 CVEs and 8 updated CVEs.
As you may know, there was another speculative execution attacks
bug(Retbleed) was published this week.
CNA and Intel provided CVSS base scores for Retbleed. They set medium
level score to it.

* New CVEs

CVE-2022-34494: rpmsg_virtio_add_ctrl_dev in
drivers/rpmsg/virtio_rpmsg_bus.c in the Linux kernel before 5.18.4 has
a double free

CVSS v3 score is not assigned.

A double free bug in rpmsg_virtio_add_ctrl_dev() which will cause system crash.

CVE-2022-34494 and CVE-2022-34495 were introduced by commit c486682
("rpmsg: virtio: Register the rpmsg_char device") which was merged in
5.13-rc1.
This commit wasn't backported to stable kernels, so 5.12 or earlier
kernels aren't affected by this bug.

Fixed status
mainline: [1680939e9ecf7764fba8689cfb3429c2fe2bb23c]
stable/5.15: [b94d40c792de7f0ceda6a2fd8a8dc0597eca6d22]
stable/5.18: [d51720ac069d465101d937273acecde1f71ea411]

CVE-2022-34495: rpmsg_probe in drivers/rpmsg/virtio_rpmsg_bus.c in the
Linux kernel before 5.18.4 has a double free.

CVSS v3 score is not assigned.

A double free bug in rpmsg_probe() which will cause system crash.

CVE-2022-34494 and CVE-2022-34495 were introduced by commit c486682
("rpmsg: virtio: Register the rpmsg_char device") which was merged in
5.13-rc1.
This commit wasn't backported to stable kernels, so 5.12 or earlier
kernels aren't affected by this bug.

Fixed status
mainline: [c2eecefec5df1306eafce28ccdf1ca159a552ecc]
stable/5.15: [eaf37bb6b4f7c48a5adaf1be4879107daf4d6024]
stable/5.18: [b7e88e4bb41dea89b1dadf7a985d7aff53720629]

CVE-2022-2380: video: fbdev: sm712fb: Fix crash in smtcfb_read()

CVSS v3 score is not assigned.

A crash occured when reading data framebuffer.
The mainline, stable kernels, and cip kernels(includes 4.4) have been fixed

Fixed status
mainline: [bd771cf5c4254511cc4abb88f3dab3bd58bdf8e8]
stable/4.14: [2a616cc4513217c850865482cbc0bc6e7188580c]
stable/4.19: [1caa40af491dcfe17b3ae870a854388d8ea01984]
stable/4.9: [e6766bb02614ad69218dcd849668524e46916e11]
stable/5.10: [72af8810922eb143ed4f116db246789ead2d8543]
stable/5.15: [46cdbff26c88fd75dccbf28df1d07cbe18007eac]
stable/5.4: [478154be3a8c21ff106310bb1037b1fc9d81dc62]

CVE-2022-23825: Aliases in the branch predictor may cause some AMD processors to
predict the wrong branch type potentially leading to information disclosure

CVSS v3 score is not assigned by NVD.
Intel gives CVSS Base score as 4.7 Medium.

This CVE affects to AMD processors.

Fixed status
Not fixed yet.

CVE-2022-28693: Unprotected alternative channel of return branch
target prediction in some Intel(R) Processors may allow an authorized
user to potentially enable information disclosure via local access.

CVSS v3 score is not assigned.

This CVE affects to Intel processors.

Fixed status
Not fixed yet.

CVE-2022-23816: Mis-trained branch predictions for return instructions
may allow arbitrary speculative code execution under certain
microarchitecture-dependent conditions on some AMD processors
CVE-2022-29900: Information leak through mispredicted returns on AMD processors
CVE-2022-29901: Information leak through mispredicted returns on Intel
processors

According to the openwall mailing
list(https://www.openwall.com/lists/oss-security/2022/07/13/1),
CVE-2022-23816 and CVE-2022-29900 are duplite each other.

CVSS v3 score is not assigned by NVD.
CVESS Base Score 5.6 MEDIUM by CNA.
CVESS Base Score 4.7 MEDIUM by Intel.

This is RETbleed bug(https://comsec.ethz.ch/research/microarch/retbleed/).

CVE-2022-29900 affect to AMD processors. According to the
cve.mitre.org, it described that "AMD microprocessor families 15h to
18h are affected by a new Spectre variant that is able to bypass their
retpoline mitigation in the kernel to leak arbitrary data. An attacker
with unprivileged user access can hijack return instructions to
achieve arbitrary speculative code execution under certain
microarchitecture-dependent conditions."

CVE-2022-29901 affects to Intel processors. According to the
cve.mitre.org, it described that "Intel microprocessor generations 6
to 8 are affected by a new Spectre variant that is able to bypass
their retpoline mitigation in the kernel to leak arbitrary data. An
attacker with unprivileged user access can hijack return instructions
to achieve arbitrary speculative code execution under certain
microarchitecture-dependent conditions."

The mainline has 55 commits to fix this CVEs.

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

* Updated CVEs

CVE-2022-2318: UAF vulnerabilities in rose protocol

The mainline and stable kernels were fixed.

Fixed status
mainline: [9cc02ede696272c5271a401e4f27c262359bc2f6]
stable/4.14: [597b3bbe230caca60c321eeb08de14b9bc4d47c0]
stable/4.19: [2661f2d88f40e35791257d73def0319b4560b74b]
stable/4.9: [3ab68a9528780870b84200bbd91efaa47a586a3c]
stable/5.10: [8f74cb27c2b4872fd14bf046201fa7b36a46885e]
stable/5.15: [659d39545260100628d8a30020d09fb6bf63b915]
stable/5.18: [570b99c2e1508708c4a32a58f98071fbc3c2c351]
stable/5.4: [bb91556d2af066f8ca2e7fd8e334d652e731ee29]

CVE-2022-26365: Xen Linux disk/nic frontends data leaks

Stable kernels were fixed.

Fixed status
mainline: [2f446ffe9d737e9a844b97887919c4fda18246e7]
stable/4.14: [44dc5bcac4b0ec4e876110a69ead25a9b130234b]
stable/4.19: [f4a1391185e30c977bfe1648435c152f806211c7]
stable/4.9: [4fbda9d1fc771b44e96ee4cea58f37d926010ffc]
stable/5.10: [cfea428030be836d79a7690968232bb7fa4410f1]
stable/5.15: [7ed65a4ad8fa9f40bc3979b32c54243d6a684ec9]
stable/5.18: [62b5d188a270a25138a88c18409c596c1406b993]
stable/5.4: [42112e8f94617d83943f8f3b8de2b66041905506]

CVE-2022-33740: Xen Linux disk/nic frontends data leaks

Stable kernels were fixed.

Fixed status
mainline: [307c8de2b02344805ebead3440d8feed28f2f010]
stable/4.14: [f2c6f208a52df7e201f9fc34ae5efd7f9f40133e]
stable/4.19: [3650ac3218c1640a3d597a8cee17d8e2fcf0ed4e]
stable/4.9: [d1d69e0c838c2df7089357ec27000942086325c4]
stable/5.10: [728d68bfe68d92eae1407b8a9edc7817d6227404]
stable/5.15: [5dd0993c36832d33820238fc8dc741ba801b7961]
stable/5.18: [6d98cf6e58b5867225c3b4ea49bc431895ef33f0]
stable/5.4: [04945b5beb73019145ac17a2565526afa7293c14]

CVE-2022-33741: Xen Linux disk/nic frontends data leaks

Stable kernels were fixed.

Fixed status
mainline: [4491001c2e0fa69efbb748c96ec96b100a5cdb7e]
stable/4.14: [019eaffbb7cfdbe01b1b4e1b61e7f91688c76c2a]
stable/4.19: [4b67d8e42dbba42cfafe22ac3e4117d9573fdd74]
stable/4.9: [c6e941364608d911ac7b055d27d86e360fd94aed]
stable/5.10: [4923217af5742a796821272ee03f8d6de15c0cca]
stable/5.15: [ed3cfc690675d852c3416aedb271e0e7d179bf49]
stable/5.18: [3893cd0fec5e80e8d1c681794ee43167eb799e4d]
stable/5.4: [ede57be88a5fff42cd00e6bcd071503194d398dd]

CVE-2022-33742: Xen Linux disk/nic frontends data leaks

Stable kernels were fixed.

Fixed status
mainline: [2400617da7eebf9167d71a46122828bc479d64c9]
stable/4.14: [0b06590646e0857a804c9a08545791feb2278ab6]
stable/4.19: [981de55fb6b5253fa7ae345827c6c3ca77912e5c]
stable/4.9: [8dad9a67100245295373523375610be850999b37]
stable/5.10: [cbbd2d2531539212ff090aecbea9877c996e6ce6]
stable/5.15: [6d0a9127279a4533815202e30ad1b3a39f560ba3]
stable/5.18: [3ebaa2c13f680889c4fb9f090b243499d25017d0]
stable/5.4: [60ac50daad36ef3fe9d70d89cfe3b95d381db997]

CVE-2022-33743: Xen network backend may cause Linux netfront to use freed SKBs

stable/5.10, 5.15, and 5.18 were fixed.

Fixed status
mainline: [f63c2c2032c2e3caad9add3b82cc6e91c376fd26]
stable/5.10: [547b7c640df545a344358ede93e491a89194cdfa]
stable/5.15: [1052fc2b7391a43b25168ae69ad658fff5170f04]
stable/5.18: [a74adaffc8db86b4dbdd98762deff70b155b0f4d]

CVE-2022-33744: Xen Arm guests can cause Dom0 DoS via PV devices

Stable kernels were fixed.

Fixed status
mainline: [b75cd218274e01d026dc5240e86fdeb44bbed0c8]
stable/4.14: [01b86faa64b1f5aa04c0b3ca2001b0a8474f3006]
stable/4.19: [274cb74da15ed13292fcec9097f04332eb3eea17]
stable/4.9: [856d1b8e6e826b5087f1ea3fdbabda3557d73599]
stable/5.10: [43c8d33ce353091f15312cb6de3531517d7bba90]
stable/5.15: [9f83c8f6ab14bbf4311b70bf1b7290d131059101]
stable/5.18: [efd9826d4c08abac7e8840757e3e1bfcf2876f70]
stable/5.4: [5c03cad51b84fb26ccea7fd99130d8ec47949cfc]

CVE-2022-34918: netfilter: nf_tables: stricter validation of element data

stable 5.10, 5.15, and 5.18 were fixed.

Fixed status
mainline: [7e6bc1f6cabcd30aba0b11219d8e01b952eacbb6]
stable/5.10: [0a5e36dbcb448a7a8ba63d1d4b6ade2c9d3cc8bf]
stable/5.15: [c1784d2075138992b00c17ab4ffc6d855171fe6d]
stable/5.18: [6b7488071ea8ed6265a39afebd5a5920f6975d02]

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

