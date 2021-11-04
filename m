Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1918EC433EF
	for <webhook@archiver.kernel.org>; Thu,  4 Nov 2021 01:12:03 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web12.5824.1635988320771646216
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Nov 2021 18:12:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=iAiGcyKG;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.46,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f46.google.com with SMTP id
 w29-20020a056830411d00b0055abaca9349so5991757ott.13
        for <cip-dev@lists.cip-project.org>;
 Wed, 03 Nov 2021 18:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=YKw6By9BCe+jQsTpIb+fDK9VMQJW0F04b2/HJxX8ZJs=;
        b=iAiGcyKGwxrlYmxsiAJMf/ge/saRpt7C0W+Djwow7+ATwolIihSv6Lbmv9RMcKfADo
         RVu35a8L5J5/P852LTiGLXaKxwcyHYo7WnaCOQIKmpxXV0GBHg/G/CLCoK8HY7BexpRM
         Z/91Pv9sBne+rFy9iiIPMReUu39Ku5D+amhp3fn4CAZgHb2NR3zZqBZH1DpXUJKVqpg0
         RBJyYj5XaN1odGT4cfFvq/lCCvhVW4xhOTbu7XLhfhcURcOU7y9Q0bfqCeqMjt4T3s1y
         Pa1/6DB9h18+9eaYv0iJ58ygc1M0ChglXhTp728Ptt6s0+c3C8DZiq+JNjWa7MfHdrN+
         j9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YKw6By9BCe+jQsTpIb+fDK9VMQJW0F04b2/HJxX8ZJs=;
        b=eemsjO5w9iQvv/sJ0RKEjKyu9Q6QmhiEnL+5NDx4L+GNc/vnzLb88E4ZeTUUJi7z4s
         Kc0L28xGyo36GNNLEd13gs5PKnWKFZc4BQ3lshiTylAARgQoNPVN7HUZrkfpVPP1DQq4
         HVqO1zweW2L2D+bTJ7zi44nJSrIdCE+QhjIfnaR8yC+7+EmZlzJUTns+oo4afQJE7J8k
         1hb5nVrfO6Rmin9dPV3mds+ZNbdMktnd6QlARWXDwQwE/ElnAH4i+E5SlMN2GgJqp/QK
         N0GEAf0Qtkz9DuhUNkugFxyRckDCGKViSVL5YpfpPURoGXGO+ZRTsyk/2Q4A80c7Rlrx
         Bh9g==
X-Gm-Message-State: AOAM532akCNYDYmPLYtHAr+/QKqpk5WxNkJfy4RDh5yb78FTgyokxYwl
	OayukU6uLYh+Rf1ay9iABOco1AcszpJgwciH42rnEWv1t5LbkQ==
X-Google-Smtp-Source: 
 ABdhPJzAWmWoGukVipExHvwxHJH6UO4LK9DfeBjacafDL0rxItayPJpPNQzflBrbuJxzyUxrnRQRg48Ho3SjATD97sg=
X-Received: by 2002:a05:6830:2aa7:: with SMTP id
 s39mr11686850otu.67.1635988319525;
 Wed, 03 Nov 2021 18:11:59 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 4 Nov 2021 10:11:23 +0900
Message-ID: 
 <CAODzB9rc8Y_kUnMfYebK_sHt5tOSvf+qr0pgYkZy+N0zqudu4g@mail.gmail.com>
Subject: New CVE Entries in this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Nov 2021 01:12:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6858

Hi !

It's this week's CVE report.

This week reported 4 new CVEs.

* New CVEs

CVE-2021-43057: selinux,smack: fix subjective/objective credential use mixups

CVSS v3 score is "7.8 HIGH".

selinux and smack have UFA bug which cause a local attacker can
escalates privileges.
This bug was introduced since 5.13-rc1 so before 5.13 kernel isn't affected.
All stable kernels are fixed.

Fixed status

mainline: [a3727a8bac0a9e77c70820655fd8715523ba3db7]
stable/5.14: [bef2b32a149030babba8ad5d2b6c121638fb911d]

CVE-2021-3892: memory leak in fib6_rule_suppress could result in DoS

CVSS v3 score is not provided.

According to the red hat
bugzilla(https://bugzilla.redhat.com/show_bug.cgi?id=2014623) it said
that "The kernel leaks memory when firewalld IPv6_rpfilter is enabled
and a suppress_prefix rule is present in the IPv6 routing rules (used
by certain tools such as wg-quick). In such scenarios, every incoming
packet will leak an allocation in ip6_dst_cache slab cache." It seems
like this CVE can do remote DoS attack, however it requires some
conditions to do it.

Fixed status

Not fixed yet.

CVE-2021-34981: Bluetooth CMTP Module Double Free Privilege Escalation
Vulnerability

This CVE is fixed in 5.14-rc1.

Fixed status

mainline: [3cfdf8fcaafa62a4123f92eb0f4a72650da3a479]
stable/4.19: [f8be26b9950710fe50fb45358df5bd01ad18efb7]
stable/4.9: [77c559407276ed4a8854dafc4a5efc8608e51906]
stable/5.10: [1b364f8ede200e79e25df0df588fcedc322518fb]
stable/5.4: [fe201316ac36c48fc3cb2891dfdc8ab68058734d]

CVE-2021-43267: tipc: fix size validations for the MSG_CRYPTO type

This vulnerability was introduced since 5.1-rc1 so before 5.10 kernels
aren't affected by this issue.
The mainline and stable kernels have been fixed.

Fixed status

mainline: [fa40d9734a57bcbfa79a280189799f76c88f7bb0]
stable/5.10: [0b1b3e086b0af2c2faa9938c4db956fe6ce5c965]
stable/5.14: [e029c9828c5b503b11a609fcc7c5840de2db3fb4]

* Updated CVEs

CVE-2021-3772: Invalid chunks may be used to remotely remove existing
associations

This bug is in SCTP stack that attacker may be able to send packet
with spoofed IP address if attacker knows IP address and port number
being used.

Below is a list for backported status in each patch.

* 4f7019c7eb33 ("sctp: use init_tag from inithdr for ABORT chunk")
stable/4.4: backported
stable/4.19: backported
stable/4.9: backported
stable/5.10: backported
stable/5.4: backported

* eae578390804 ("sctp: fix the processing for INIT chunk")
stable/4.4: not yet
stable/4.19: not yet
stable/4.9: not yet
stable/5.10: not yet
stable/5.4: not yet

* 438b95a7c98f ("sctp: fix the processing for INIT_ACK chunk")
stable/4.4: not yet
stable/4.19: not yet
stable/4.9: not yet
stable/5.10: backported
stable/5.4: backported

* a64b341b8695 ("sctp: fix the processing for COOKIE_ECHO chunk")
stable/4.4: not yet
stable/4.19: backported
stable/4.9: not yet
stable/5.10: backported
stable/5.4: backported

* aa0f697e4528 ("sctp: add vtag check in sctp_sf_violation")
stable/4.4: backported
stable/4.19: backported
stable/4.9: backported
stable/5.10: backported
stable/5.4: backported

* ef16b1734f0a ("sctp: add vtag check in sctp_sf_do_8_5_1_E_sa")
stable/4.4: not yet
stable/4.19: backported
stable/4.9: not yet
stable/5.10: backported
stable/5.4: backported

* 9d02831e517a ("sctp: add vtag check in sctp_sf_ootb")
stable/4.4: not yet
stable/4.19: backported
stable/4.9: not yet
stable/5.10: backported
stable/5.4: backported

Fixed status

mainline: [4f7019c7eb33967eb87766e0e4602b5576873680,
eae5783908042a762c24e1bd11876edb91d314b1,
  438b95a7c98f77d51cbf4db021f41b602d750a3f,
a64b341b8695e1c744dd972b39868371b4f68f83,
  aa0f697e45286a6b5f0ceca9418acf54b9099d99,
ef16b1734f0a176277b7bb9c71a6d977a6ef3998,
  9d02831e517aa36ee6bdb453a0eb47bd49923fe3]
stable/4.19: [1f52dfacca7bb315d89f5ece5660b0337809798e,
86044244fc6f9eaec0070cb668e0d500de22dbba,
  aa0f697e45286a6b5f0ceca9418acf54b9099d99,
ef16b1734f0a176277b7bb9c71a6d977a6ef3998,
  9d02831e517aa36ee6bdb453a0eb47bd49923fe3, ]
stable/4.4: [629d2823abf957bcbcba32154f1f6fd49bdb850c,
c0b5302e3a74997b57985b561e776269d1951ac7]
stable/4.9: [42ce7a69f8140783bab908dc29a93c0bcda315d5,
16d0bfb045abf587c72d46dfea56c20c4aeda927]
stable/5.10: [a7112b8eeb14b3db21bc96abc79ca7525d77e129,
c2442f721972ea7c317fbfd55c902616b3151ad5,
  14c1e02b11c2233343573aff90766ef8472f27e7,
dad2486414b5c81697aa5a24383fbb65fad13cae,
  8c50693d25e4ab6873b32bc3cea23b382a94d05f,
ad111d4435d85fd3eeb2c09692030d89f8862401]
stable/5.14: [332933f9ae0a17f6e362ec0f35ed51e7bc8e76d6,
6277d424ead2702798e8b981fb6f51b8ec2304ec,
  7975f42f10380ff9743a7ee94ef3cb81f1a8275d,
44ef3ecbc24a532fde6a8c7b87b3e55d4ad1c1d1,
  dd82b3a345abf6fc325e748469d9d7f477a0b718,
1c255b5f68f4dac3f1f0f24741575aac2325470a,
  0717c71deae69aa3511492c302dd44a2f3722184]
stable/5.4: [5953ee99bab134d74c805a00eaa20fed33f54255,
5fe74d5e4d58262e4adde277ef773032c57e873d,
  d6470c2200253da67a439aa18c9ce32a127c5a61,
0aa322b5fe70204d3d7f9d1d4cd265fdff2e5a1f,
  df527764072c5fb7ede93a41cc8f3acbf41dde8c,
0f5b4c57dc8573bdb9926b17748065ac2104b1d1]

CVE-2021-42327: drm/amdgpu: fix out of bounds write

The parse_write_buffer_into_params() was introduced since 5.9 so
before 5.9 kernels aren't affected by this vulnerability.

This CVE was fixed by 5afa7898ab7a ("drm/amdgpu: fix out of bounds
write"), however next commit 3f4e54bd312d ("drm/amdgpu: Fix even more
out of bound writes from debugfs") said that amdgpu_dm_debugfs.c
contains same issues so it'd be nice to apply 3f4e54bd312d
("drm/amdgpu: Fix even more out of bound writes from debugfs") too.

Fixed status

mainline: [5afa7898ab7a0ec9c28556a91df714bf3c2f725e]
stable/5.10: [eb3b6805e3e9d98b2507201fd061a231988ce623]
stable/5.14: [d3ed72495a59fbfb9377450c8dfe94389a6509a7]

CVE-2021-20322: new DNS Cache Poisoning Attack based on ICMP fragment
needed packets replies

Update stable/5.4 and stable/4.19 fixed revisions.
It seems like stable/4.4 and stable/4.9 need backport following patches.
- 4785305c05b2 ("ipv6: use siphash in rt6_exception_hash()")
- a00df2caffed ("ipv6: make exception cache less predictible")
- 6457378fe796 ("ipv4: use siphash instead of Jenkins in fnhe_hashfun()")

Fixed status

mainline: [4785305c05b25a242e5314cc821f54ade4c18810,
6457378fe796815c973f631a1904e147d6ee33b1,
  a00df2caffed3883c341d5685f830434312e4a43,
67d6d681e15b578c1725bad8ad079e05d1c48a8e]
stable/4.19: [3e6bd2b583f18da9856fc9741ffa200a74a52cba,
6e2856767eb1a9cfcfcd82136928037f04920e97,
  ad829847ad59af8e26a1f1c345716099abbc7a58,
c6d0d68d6da68159948cad3d808d61bb291a0283]
stable/4.4: [bed8941fbdb72a61f6348c4deb0db69c4de87aca]
stable/4.9: [f10ce783bcc4d8ea454563a7d56ae781640e7dcb]
stable/5.10: [8692f0bb29927d13a871b198adff1d336a8d2d00,
5867e20e1808acd0c832ddea2587e5ee49813874,
  dced8347a727528b388f04820f48166f1e651af6,
beefd5f0c63a31a83bc5a99e6888af884745684b]
stable/5.14: [4785305c05b25a242e5314cc821f54ade4c18810,
6457378fe796815c973f631a1904e147d6ee33b1,
  55938482a1461a35087c6f3051f8447662889ea8,
4589a12dcf80af31137ef202be1ff4a321707a73]
stable/5.4: [3f439c231a035bab056a5e20b1fd16f4c4c483c1,
4ba6c163fe64e0836acd0708962fb30cf78dbd42,
  f73cbdd1b8e7ea32c66138426f826c8734b70c18,
e46e23c289f62ccd8e2230d9ce652072d777ff30]

CVE-2021-42739: media: firewire: firedtv-avc: fix a buffer overflow in
avc_ca_pmt()

According to the cip-kernel-config repo, no CIP member uses firewire driver.

Fixed status

mainline: [35d2969ea3c7d32aee78066b1f3cf61a0d935a4e]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2021-3640: UAF in sco_send_frame function

Fixed in bluetooth-next tree.

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/net/bluetooth/sco.c?id=99c23da0eed4fd20cae8243f2b51e10e66aa0951

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
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

