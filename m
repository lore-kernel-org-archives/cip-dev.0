Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7981BC433EF
	for <webhook@archiver.kernel.org>; Wed, 16 Mar 2022 23:34:41 +0000 (UTC)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com
 [209.85.219.174])
 by mx.groups.io with SMTP id smtpd.web12.4052.1647473679910163242
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Mar 2022 16:34:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=eMwqwD1i;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.174,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f174.google.com with SMTP id j2so7364679ybu.0
        for <cip-dev@lists.cip-project.org>;
 Wed, 16 Mar 2022 16:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=H9HRtqhwN/BbsaTFRPqx506ALvYdEYVw+t9B2RH1R2w=;
        b=eMwqwD1ijKRwUiN5nVom8hFUybIZWd+QMtKxHYQk5QIN32JRP5AGjUlKfhwoAnzCF1
         4TAGrkeQZkUMmNXr+c86ARcaoTzNWgu2lwJi11ZWcwYJFM3lkOtgfRs/7rIHMhauJ/Gq
         q5Reoudw2TuD+fymwsgug4snTnk/24TrMUof/e373J2jXsJAz4vqlfJ2ymfHR/tFajy3
         AZxF4p8hMUVl6JrSQKs9JR0gnQI5st3xIeiGbcdPpmmkeV3A2yK8jtgAL6nerW0FPIY+
         i5YyZnhutSAMySTUZGuRNoJR9yj26v6cx5A7x/n1DA5tI42hCYI2Gth7xgDLnQ1KMCfD
         qVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=H9HRtqhwN/BbsaTFRPqx506ALvYdEYVw+t9B2RH1R2w=;
        b=G7outJY9DuuabmuJlER8t9bMJYg1E6pvUIXmnL/lC2G6Wtab+Cp64RBGCS1/QcUpI/
         qS5lyss0gZOqYNzLnYhTYaCkCi5pXpi6O7IUj37+FzeqYfzs6fU9XCafSVEbESWUAOB3
         3RKUihpkY9SwJ78JC04ItvteI8Yak1tXWFlcWUoqnpvWpwi0xYc6CktpsS5nqLA2B6ek
         OpXA4/MQCp5un9GJdO0ateC0hJpRqaZR2T6jNeouJXQFjy8EK8EChgz0DT1gXeDOKc0a
         ZUQciZmeD853C+nKgtNOIpdt07pch/ZZHwsLRsHV+7yIVYaZyxXP940fSVmI59OHgdOQ
         M0pQ==
X-Gm-Message-State: AOAM531SL2Ob1hwEplUz230e4+hP2/Iv5MHe4dBc+cEd+kqlIYHv09Xb
	SaNOSqqOP6A+CUGmjEUOZq/C0hKIA/J6r5dWzOVyW8UV2p0mzg==
X-Google-Smtp-Source: 
 ABdhPJx5dTiqE4g5H9DiK1GcEJArNaTxitSiPPUx9ONsKxTzgqHuwPazO9+H7VjhbyhCSRamBarrxyw8lqwhPUKhjro=
X-Received: by 2002:a05:6902:552:b0:633:7c3b:a2b5 with SMTP id
 z18-20020a056902055200b006337c3ba2b5mr2359980ybs.501.1647473678147; Wed, 16
 Mar 2022 16:34:38 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 17 Mar 2022 08:34:02 +0900
Message-ID: 
 <CAODzB9raARAuNHKB26Jt5MZ+JXfn4+64cb2RW5q6qwi6UbzYMw@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Mar 2022 23:34:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7763

Hi !

It's this week's CVE report.

This week reported 11 new CVEs and 5 updated CVE.
Seven of eleven new CVEs are Xen's vulnerabilities.

* New CVEs

CVE-2022-23036, CVE-2022-23037, CVE-2022-23038, CVE-2022-23039,
CVE-2022-23040 : Xen: fix race conditions, resulting in potential data
leaks, data corruption, DoS by malicious backends

CVSS v3 score is not provided

CVE-2022-23036, CVE-2022-23037, CVE-2022-23038, CVE-2022-23039, and
CVE-2022-23040 are kind of group. These CVEs are Xen's vulnerability.
These vulnerability will cause race conditions, resulting in potential
data leaks, data corruption, DoS by malicious backends(blkfront,
netfront, scsifront, gntalloc, xenbus).

Xen advisory said that "blkfront, netfront, scsifront and the gntalloc
driver are testing
whether a grant reference is still in use. If this is not the case,
they assume that a following removal of the granted access will always
succeed, which is not true in case the backend has mapped the granted
page between those two operations. As a result the backend can keep
access to the memory page of the guest no matter how the page will be
used after the frontend I/O has finished. The xenbus driver has a
similar problem, as it doesn't check the success of removing the
granted access of a shared ring buffer."

Each CVE is assigned to each backend.

CVE-2022-23036 : blkfront
CVE-2022-23037 : netfront
CVE-2022-23038 : scsifront
CVE-2022-23039 : gntalloc
CVE-2022-23040 : xenbus

For 4.4.

6b1775f: can be applied
abf1fd5: backport 3df0e50 ("xen/blkfront: pseudo support for multi
hardware queues/rings") or modify abf1fd5 is needed
31185df: can be applied
33172ab: can be applied with a small modification
d3b6372: can be applied

Fixed status

CVE-2022-23036:
mainline: [6b1775f26a2da2b05a6dc8ec2b5d14e9a4701a1a,
abf1fd5919d6238ee3bc5eb4a9b6c3947caa6638]
stable/4.19: [17659846fe336366b1663194f5669d10f5947f53,
423a3a50dce9a48d10d2d2a70cd2f78064c13703]
stable/4.9: [73e1d9b33f2bd93ce30719dfc8990b6328243b7e,
f306575016dcf47ed6cd40e1fe872a4d8c665a8b]
stable/5.10: [3d81e85f30a8f712c3e4f2a507553d9063a20ed6,
96219af4e504d0e96a231a0ba86062ec5b3af979]

CVE-2022-23037:
mainline: [31185df7e2b1d2fa1de4900247a12d7b9c7087eb]
stable/4.19: [927e4eb8ddf4968b6a33be992b28063f84552c72]
stable/4.9: [1112bb311ec13e7e6e7045ae4a0b7091bedc6b7a]
stable/5.10: [f6690dd9446a2a4bd9b024f00f71dd827a98317f]

CVE-2022-23038:
mainline: [6b1775f26a2da2b05a6dc8ec2b5d14e9a4701a1a,
33172ab50a53578a95691310f49567c9266968b0]
stable/4.9: [73e1d9b33f2bd93ce30719dfc8990b6328243b7e,
98bdfdf89e987406f4afdc7694cbdbb715383d8e]
stable/5.10: [3d81e85f30a8f712c3e4f2a507553d9063a20ed6,
3047255182774266950b22acc29c22a2d76e859e]

CVE-2022-23039:
mainline: [d3b6372c5881cb54925212abb62c521df8ba4809]
stable/4.19: [fbc57368ea527dcfa909908fc47a851a56e4e5ce]
stable/4.9: [97b835c6de03a24db79d374b02d532f0b562fd38]
stable/5.10: [5f36ae75b847e7f87e4144602f418a624ca074b7]

CVE-2022-23040:
mainline: [3777ea7bac3113005b7180e6b9dadf16d19a5827]
stable/4.19: [8d521d960aef22781ff499e16899c30af899de8d]
stable/4.9: [8f80d12f6946a6fe7c64bfc204c062a57f83c7f8]
stable/5.10: [5c600371b8fd02cbbb0eb83a9f664e3f0b75c28e]

CVE-2022-23041: Xen: fix race conditions, resulting in potential data
leaks, data corruption, DoS by malicious backends

CVSS v3 score is not provided

Xen advisory said that "blkfront, netfront, scsifront, usbfront,
dmabuf, xenbus, 9p, kbdfront,
and pvcalls are using a functionality to delay freeing a grant reference
until it is no longer in use, but the freeing of the related data page
is not synchronized with dropping the granted access. As a result the
backend can keep access to the memory page even after it has been freed
and then re-used for a different purpose."

for 4.4
5cadd4b: Patch to net/9p/trans_xen.c but 4.4.302 doesn't have it. may be ig=
nored
b0576cc: Patch to drivers/xen/pvcalls-front. but 4.4.302 doesn't have
it. can be ignored
42baefa: can be applied with modification

Fixed status

mainline: [5cadd4bb1d7fc9ab201ac14620d1a478357e4ebd,
b0576cc9c6b843d99c6982888d59a56209341888,
  42baefac638f06314298087394b982ead9ec444b]
stable/4.19: [2466bed361f3274e3e0ca9d8e539532481c06fea,
f85d03f0f482cc28a2ee15a1fed2ae57ae359412,
  92dc0e4a219602242407dedd987dc9c8263c959b]
stable/4.9: [ae6f8a67b98144827e78874c8dba41cccb02be5b]
stable/5.10: [8357d75bfdb85ea63253cf369f405830c7b13d78,
c4b16486d6023f6365a4f8671351961e97428f2d,
  39c00d09286c67567cdf23ebc8e00e47722ef769]

CVE-2022-23042: Xen: fix race conditions, resulting in potential data
leaks, data corruption, DoS by malicious backends

CVSS v3 score is not provided

Xen advisory said that "netfront will fail a BUG_ON() assertion if it
fails to revoke access in
the rx path. This will result in a Denial of Service (DoS) situation of
the guest which can be triggered by the backend."

for 4.4
66e3531: need to modify

Fixed status

mainline: [66e3531b33ee51dad17c463b4d9c9f52e341503d]
stable/4.19: [c307029d811e03546d18d0e512fe295b3103b8e5]
stable/4.9: [c4497b057b14274e159434f0ed70439a21f3d2a9]
stable/5.10: [206c8e271ba2630f1d809123945d9c428f93b0f0]

CVE-2022-26878: Bluetooth: virtio_bt: fix memory leak in virtbt_rx_handle()

CVSS v3 score is not provided

This bug was introduced since 5.13-rc1, so before this versions aren't
affected by this issue.
The mainline and all stable kernels are already fixed.

Fixed status

mainline: [1d0688421449718c6c5f46e458a378c9b530ba18]
stable/5.15: [1f2270e161f978912100dd7acdfe1894bebcd4f6]
stable/5.16: [ad7cb5f6fa5f7ea37208c98a9457dd98025a89ca]

CVE-2022-26966: sr9700: sanity check for packet length

CVSS v3 score is not provided

This bug will cause heap data leak to user space.
The mainline and all stable kernels are already fixed.

for 4.4
4.4 kernel doesn't check packet length. Therefore 4.4 has same issue.
Patch can be applied to 4.4.

Fixed status

mainline: [e9da0b56fe27206b49f39805f7dcda8a89379062]
stable/4.14: [fbc3c962b6eb42b1483d00d8ea28b61b9f2fff26]
stable/4.19: [dde5ddf02a47487dd6efcc7077307f1d4e1ba337]
stable/4.9: [89260e0e191e8a3a9872f72836bdf0641853c87f]
stable/5.10: [4f5f5411f0c14ac0b61d5e6a77d996dd3d5b5fd3]
stable/5.15: [9f2d614779906f3d8ad4fb882c5b3e5ad6150bbe]
stable/5.16: [639f72dce8667a3d601561e0e47d53ad999e7f8a]
stable/5.4: [b95d71abeb7d31d4d51cd836d80f99fd783fd6d5]

CVE-2022-0742: A memory leak flaw was found in the Linux kernel=E2=80=99s
ICMPv6 networking protocol

CVSS v3 score is not provided

A remote attacker can crash victim host via malicious ICMP6 packet.
This vulnerability was introduced at commit f185de2 ("mld: add new
workqueues for process mld events").
This commit was merged in 5.13-rc1, so before this versions are not
affected by this issue.
The mainline and stable kernels are fixed.

Fixed status

mainline: [2d3916f3189172d5c69d33065c3c21119fe539fc]
stable/5.15: [771aca9bc70709771f66c3e7c00ce87339aa1790]
stable/5.16: [5ed9983ce67341b405cf6fda826e29aed26a7371]

CVE-2022-27223: USB: gadget: validate endpoint index for xilinx udc

The endpoint index is not validated and might be manipulated by the
host for out-of-array access.

For 4.4
Patch can be applied to 4.4 without modification.

Fixed status

mainline: [7f14c7227f342d9932f9b918893c8814f86d2a0d]
stable/4.14: [fdc22192d49fa577d8397b39f8ef8141cb1d62aa]
stable/4.19: [ebc465e894890a534ce05e035eae4829a2a47ba1]
stable/4.9: [958b6ab4d70bf991e8c90233504d4cb863aaef8a]
stable/5.10: [bfa8ffbaaaaf9752f66bc7cabcef2de715e7621f]
stable/5.15: [2c775ad1fd5e014b35e483da2aab8400933fb09d]
stable/5.16: [3221ef49ba18924e55a4d42a2ea4080cfea12c6c]
stable/5.4: [6b23eda989236fd75b4a9893cc816cd690c29dfc]

* Updated CVEs

CVE-2022-0001: Sharing of branch predictor selectors between contexts
on Intel CPUs

Stable 4.14, 4.19, 4.9, 5.10, 5.15, 5.16, and 5.4 kernels were updated.

Fixed status

mainline: [d45476d9832409371537013ebdd8dc1a7781f97a,
1e19da8522c81bf46b335f84137165741e0d82b7,
  5ad3eb1132453b9795ce5fd4572b1c18b292cca9,
44a3918c8245ab10c6c9719dd12e7a8d291980d8,
  244d00b5dd4755f8df892c86cab35fb2cfd4f14b,
e9b6013a7ce31535b04b02ba99babefe8a8599fa,
  eafd987d4a82c7bb5aa12f0e3b4f8f3dea93e678,
0de05d056afdb00eca8c7bbb0c79a3438daf700c]
stable/4.14: [35c13d13becb5b951ea0fc708dda03fe900cf879,
716c06c7196f2ff22777b5bb3c713094ec677a93,
  d2109c347ec237f6a4cf4d44336abdeeab82ec8f,
383973dc1a9dfc7baf12652b9e75498bef16aed9,
  85938688be23ecd36a06757096896b2779b80d97,
416ec8f017b368ab953f624b075a7b0ffd296b9e,
  2b871b5fedb85c1962ccab26c64bef9bf6f377d4,
38c557efd4cd5e59dee1d021009278b491523fee]
stable/4.19: [25440a8c77dd2fde6a8e9cfc0c616916febf408e,
3f66bedb96ff4c064a819e68499f79b38297ba26,
  7af95ef3ec6248696300fce5c68f6c8c4f50e4a4,
995629e1d8e6751936c6e2b738f70b392b0461de,
  d3cb3a6927222268a10b2f12dfb8c9444f7cc39e,
c034d344e733a3ac574dd09e39e911a50025c607,
  8bfdba77595aee5c3e83ed1c9994c35d6d409605,
9711b12a3f4c0fc73dd257c1e467e6e42155a5f1]
stable/4.9: [a771511caa8e31cb5cac4fa39165ebbca3e62795,
d0ba50275860b456ff570edf3dcc2db5d2eb9eb8,
  f9238d33710d74ac3dd668abaa53b2274f8e6fe6,
6481835a9a5b74e349e5c20ae8a9cb10a2e907fa,
  b6a1aec08a84ccb331ce526c051df074150cf3c5,
0db1c4307aded2c5e618654f9341a249e0c1051f,
  8edabefdc13294a9b15671937d165b948cf34d69,
0753760184745250e39018bb25ba77557390fe91]
stable/5.10: [f38774bb6e231d647d40ceeb8ddf9082eabde667,
a6a119d647ad1f73067d3cffb43104df3f920bcc,
  071e8b69d7808d96f388d7c5ed606e75fd3d518d,
afc2d635b5e18e2b33116d8e121ee149882e33eb,
  2fdf67a1d215574c31b1a716f80fa0fdccd401d7,
e335384560d1e106b609e8febd7e0427075a8938,
  cc9e3e55bde71b2fac1494f503d5ffc560c7fb8d,
d04937ae94903087279e4a016b7741cdee59d521]
stable/5.15: [f150b6fccf7fa0e7e7275f0785798547db832c7b,
d7771f380c90e53a7b22f8e8a20b09c09e3583c7,
  eb459641775636c3b4382ecc43ba3d6aa16892d5,
316e4a16524a2d2ce321f57c1abe4df9ef90f950,
  a56566d7a957c34811384d6300a53a97be94cd20,
36fbbd78471c319a3a6f6402b99447c6d4686c69,
  074d7260463962b44a8b8a61dcdd6ef513022e88,
bf048d1921b6cdc50bfc5a1b21b6fdd2d22e1fe1]
stable/5.16: [56829c19c8171303faca18d6ab3511ecdf3e7e23,
9b629eeb33222615a367eee8f038db907a797d3f,
  227649a0a673da2c87c02c26c476a8599989a4d8,
6710bd548ec701bfedc175d145323cbf6930decb,
  1984feb9872b905420af97d471d60051b6dd5851,
23cc87c04704f7ed978c85a4ec5901719fd26580,
  19b78a9a32286216ec4aa64924d39ba5748b506d,
db3eaccf6e16c2d15d3fc8dc7c430d7df7c7bcc4]
stable/5.4: [41b50510e593541e2ee1537614652e91e71f6bf5,
96b3d45aeae03092637bd278ec4daadb48441906,
  327a4da9b0ef89628a1d2aa825ce709049a402f1,
1e47ab3df908bbe1b6114374003c7a070ef35f01,
  b1bacf22a847d21a12900bd6a1eacaecb5bca253,
865da3868b56a39b98003dcaa44cfbcdef0995fe,
  7c7702569422ed49d66917e163df81dba763e983,
6c1599fd1bf8782f2b368e9eacc55571a7c3dd54]

CVE-2022-0002: Sharing of branch predictor selectors in same context
on Intel CPUs

Stable 4.14, 4.19, 4.9, 5.10, 5.15, 5.16, and 5.4 kernels were updated.

Fixed status

mainline: [d45476d9832409371537013ebdd8dc1a7781f97a,
1e19da8522c81bf46b335f84137165741e0d82b7,
  5ad3eb1132453b9795ce5fd4572b1c18b292cca9,
44a3918c8245ab10c6c9719dd12e7a8d291980d8,
  244d00b5dd4755f8df892c86cab35fb2cfd4f14b,
e9b6013a7ce31535b04b02ba99babefe8a8599fa,
  eafd987d4a82c7bb5aa12f0e3b4f8f3dea93e678,
0de05d056afdb00eca8c7bbb0c79a3438daf700c]
stable/4.14: [35c13d13becb5b951ea0fc708dda03fe900cf879,
716c06c7196f2ff22777b5bb3c713094ec677a93,
  d2109c347ec237f6a4cf4d44336abdeeab82ec8f,
383973dc1a9dfc7baf12652b9e75498bef16aed9,
  85938688be23ecd36a06757096896b2779b80d97,
416ec8f017b368ab953f624b075a7b0ffd296b9e,
  2b871b5fedb85c1962ccab26c64bef9bf6f377d4,
38c557efd4cd5e59dee1d021009278b491523fee]
stable/4.19: [25440a8c77dd2fde6a8e9cfc0c616916febf408e,
3f66bedb96ff4c064a819e68499f79b38297ba26,
  7af95ef3ec6248696300fce5c68f6c8c4f50e4a4,
995629e1d8e6751936c6e2b738f70b392b0461de,
  d3cb3a6927222268a10b2f12dfb8c9444f7cc39e,
c034d344e733a3ac574dd09e39e911a50025c607,
  8bfdba77595aee5c3e83ed1c9994c35d6d409605,
9711b12a3f4c0fc73dd257c1e467e6e42155a5f1]
stable/4.9: [a771511caa8e31cb5cac4fa39165ebbca3e62795,
d0ba50275860b456ff570edf3dcc2db5d2eb9eb8,
  f9238d33710d74ac3dd668abaa53b2274f8e6fe6,
6481835a9a5b74e349e5c20ae8a9cb10a2e907fa,
  b6a1aec08a84ccb331ce526c051df074150cf3c5,
0db1c4307aded2c5e618654f9341a249e0c1051f,
  8edabefdc13294a9b15671937d165b948cf34d69,
0753760184745250e39018bb25ba77557390fe91]
stable/5.10: [f38774bb6e231d647d40ceeb8ddf9082eabde667,
a6a119d647ad1f73067d3cffb43104df3f920bcc,
  071e8b69d7808d96f388d7c5ed606e75fd3d518d,
afc2d635b5e18e2b33116d8e121ee149882e33eb,
  2fdf67a1d215574c31b1a716f80fa0fdccd401d7,
e335384560d1e106b609e8febd7e0427075a8938,
  cc9e3e55bde71b2fac1494f503d5ffc560c7fb8d,
d04937ae94903087279e4a016b7741cdee59d521]
stable/5.15: [f150b6fccf7fa0e7e7275f0785798547db832c7b,
d7771f380c90e53a7b22f8e8a20b09c09e3583c7,
  eb459641775636c3b4382ecc43ba3d6aa16892d5,
316e4a16524a2d2ce321f57c1abe4df9ef90f950,
  a56566d7a957c34811384d6300a53a97be94cd20,
36fbbd78471c319a3a6f6402b99447c6d4686c69,
  074d7260463962b44a8b8a61dcdd6ef513022e88,
bf048d1921b6cdc50bfc5a1b21b6fdd2d22e1fe1]
stable/5.16: [56829c19c8171303faca18d6ab3511ecdf3e7e23,
9b629eeb33222615a367eee8f038db907a797d3f,
  227649a0a673da2c87c02c26c476a8599989a4d8,
6710bd548ec701bfedc175d145323cbf6930decb,
  1984feb9872b905420af97d471d60051b6dd5851,
23cc87c04704f7ed978c85a4ec5901719fd26580,
  19b78a9a32286216ec4aa64924d39ba5748b506d,
db3eaccf6e16c2d15d3fc8dc7c430d7df7c7bcc4]
stable/5.4: [41b50510e593541e2ee1537614652e91e71f6bf5,
96b3d45aeae03092637bd278ec4daadb48441906,
  327a4da9b0ef89628a1d2aa825ce709049a402f1,
1e47ab3df908bbe1b6114374003c7a070ef35f01,
  b1bacf22a847d21a12900bd6a1eacaecb5bca253,
865da3868b56a39b98003dcaa44cfbcdef0995fe,
  7c7702569422ed49d66917e163df81dba763e983,
6c1599fd1bf8782f2b368e9eacc55571a7c3dd54]

CVE-2022-23960: Arm cpus BHI problem

Stable 4.19, 4.9, 5.10, 5.15, and 5.16 kernels were updated.

Fixed status

mainline: [9dd78194a3722fa6712192cdd4f7032d45112a9a,
04e91b7324760a377a725e218b5ee783826d30f5,
  8d9d651ff2270a632e9dc497b142db31e8911315,
b9baf5c8c5c356757f4f9d8180b5e9d234065bc3,
  25875aa71dfefd1959f07e626c4d285b88b27ac2,
4330e2c5c04c27bebf89d34e0bc14e6943413067,
  1b33d4860deaecf1d8eec3061b7e7ed7ab0bae8d,
5bdf3437603d4af87f9c7f424b0c8aeed2420745,
  d739da1694a0eaef0358a42b76904b611539b77b,
03aff3a77a58b5b52a77e00537a42090ad57b80b,
  c091fb6ae059cda563b2a4d93fdbc548ef34e1d6,
6c5bf79b69f911560fbf82214c0971af6e58e682,
  ed50da7764535f1e24432ded289974f2bf2b0c5a,
13d7a08352a83ef2252aeb464a5e08dfc06b5dfd,
  c47e4d04ba0f1ea17353d85d45f611277507e07a,
a9c406e6462ff14956d690de7bbe5131a5677dc9,
  aff65393fa1401e034656e349abd655cfe272de0,
ba2689234be92024e5635d30fe744f4853ad97db,
  b28a8eebe81c186fdb1a0078263b30576c8e1f42,
bd09128d16fac3c34b80bd6a29088ac632e8ce09,
  dee435be76f4117410bbd90573a881fd33488f37,
558c303c9734af5a813739cd284879227f7297d2,
  a5905d6af492ee6a4a2205f0d550b3f931b03d03,
228a26b912287934789023b4132ba76065d9491c,
  58c9a5060cb7cd529d49c93954cdafe81c1d642a]
stable/4.19: [dc64af755099d1e51fd64e99fe3a59b75595814a,
45c25917ceb7a5377883ef4c3a675276fba8a268,
  67e1f18a972be16363c6e88d7b29cde880774164,
99e14db3b711c27f93079ba9d7f2fff169916d5f,
  29db7e4b67fccf5e1fe28ec89f2add90ce74d77b]
stable/4.9: [b24d4041cfb6dab83f9edf40573375bd1365e619,
dfea9912129157ba3c5a9d060e58df17fb688e72,
  964aafb29a07cb7cdea71ef41a75394e879f529c,
da3dfb69bbc3fdfeb3e5930fe28bcd689751a594,
  48b1aa98e19d189703d518166ddb2520164b3164]
stable/5.10: [b7f1e73c4ddf2044530091e69114a5fc1a1229d0,
46deb224680bb33c8e87440a7b909d16e5a7d7c5,
  29d9b56df1e18a8ff2e669b79e511163972a8b65,
3f9c958e3572b19b1cfb9d28eeb15be0a5d80193,
  302754d023a06171113e8fb20c7b2a18ebf9088f,
dc5b630c0d532140e194997d350f587dbcc78bfb,
  7048a21086fb16ec67287a25b62e88b0cd17c8c3,
192023e6baf7cce7fb76ff3a5c24c55968c774ff,
  5242d6971e106be115d9dace9c1441f4a2e1cb25,
d93b25a6654812e0511b71a6d4a207f6b1ce5dfe,
  bda89602814c69e6f027878209b0b9453133ada2,
5275fb5ea5f573ce1ecd2bf0bcd928abb916b43d,
  e55025063276fcf7b07e9340c38d70b04aa8a7b9,
8c691e5308c531deede16bef4f2d933d5f859ce7,
  73ee716a1f6356ca86d16d4ffc97fcfc7961d3ef,
26211252c1c104732a0fea6c37645f1b670587f5,
  49379552969acee3237387cc258848437e127d98,
3f21b7e355237aa2f8196ad44c2b7456a739518d,
  56cf5326bdf9c20de9a45e4a7a4c0ae16833e561,
1f63326a5211208e2c5868650e47f13a9072afde,
  13a807a0a080383ceab6c40e53c0228108423e51,
e192c8baa69ac8a5585d61ac535aa1e5eb795e80,
  38c26bdb3cc53f219d6ab75ac1a95436f393c60f,
551717cf3b58f11311d10f70eb027d4b275135de,
  b65b87e718c33caa46d5246d8fbeda895aa9cf5b,
f3c12fc53e0a1fffbe102a9501c7bb6efdabbe99,
  fc8070a9c5ad3e0ac343532df7d4d2d709b173a8,
86171569312b5870aaedc74b4b28d444c0f72105,
  b19eaa004f2eeae94a4fcf5f0cadac35cc579a72,
7ae8127e412361025e7b4a0e6347ca9e8f3ed109,
  dbcfa98539531bff0d7e4d6087741702dfa50f06,
162aa002ec1a78e91cf2f0b8e7450e2770b2941f,
  97d8bdf33182494b7cb327ed555313d17d80c639]
stable/5.15: [f02cab2bed1a3493a230e54d83ff117bc59f480e,
878ad97f745ebc6b135d87b6901dbe93d07745d3,
  2dca61693e6cb6d163e5ba2cf18f2c3270d7ec30,
576548846f1ee53a4d04fa5f91e6a088adbfe3f8,
  842f2d498ee1e75fc9bf78555ee5b59c894c071b,
b7beeab84f02091124b176ba34c71a601762d1de,
  44adac5908ff712e0fee34e3472f884c17af8025,
368a1fd8c4a600ed8ae605afa27904f359a57161,
  479c9bb741bf6e1ac300d2f3c2797c7fbce117c0,
4a691bbf56a186f9df432b0bfd666dc2e82e4334,
  e25a9dced2bdbace585d613444f2cf317b84cda5,
2e09754a03a7e54eae6017d94fb9c265217288f1,
  be9c5526aad63ab0b13d72978206aec12ede9d76,
a40472d463f9ab6f971850989aa5a21f704b5cfd,
  6895584a92eeaa0702afc47c9758b7fca6345fec,
517f988ee0500688ac23e011bc3bbbf502e76a23,
  ffb8a34c0fd81fdcf677bc8e9af251ea526e8c49,
50e700a117669e072fb9e47ff3ea49e4a8cacf04,
  cfd0c38125aa27a15617473d053897eb7967ab1c,
d7066114dcd6a295122c5942791025e16a33f89f,
  8e55b9b0e76575e3755919820848b9ca53d82381,
4bbfd0c280254b273c564767021bb9b0f945148e,
  fb2bb2ec137c3a8afbd91c949d9384d9e8a913c9,
8979720ac64c70af1395ce78e5c6ffb546b43e0d,
  3317d21b84e91be72df14744040513a280b88946]
stable/5.16: [f5eb0f1dcde4b7c2b5ee920ae53bcecaaba03947,
0f0fd6ef76dee10aae861c69635c42b1c427e577,
  21ceffd3628edfc775d33851cf56ea1d85c528fc,
9fd1d31810ccf6b4e4df8ccf2e68bbdcf528d186,
  680e356c1be19a7663d8077be12e0ab048430ebd,
d1e3d6d26d9eab22548c3b7373ec12bbfecc765f,
  346793c01582f62f4a5536c325a3dfc627ca543a,
46af6fc4f7a22ada597982ff01db34fb4bdba6a3,
  7b63df956358d183c25178e970f6ed304cd0f659,
57e9a5fbd1f8b8ac5b7f849715fcdf5a32dda040,
  62cfcf8d06ca7786e781e1b60f57b67f43448868,
5da0c4bbae492434b534ffd39aac5d5610190491,
  dfb25997bdefca7a3cd69c1dea872ba52133d31f,
e0077b0a66f14998c0d18508bf945a40a0d3ebab,
  984e7e3ebac334d7af0069a4d3636cf2338525df,
483fa5319f16b627e7873c1079e35ebbfb04cf45,
  448a95af1b7ae205eb762c2c1fb35b290cc3032e,
d535ca624f6d439424aeeb0a3cc4a426cfd9a993,
  b9c29587c533faaa0aefeaaf7a4a4ff834975ba4,
d4293ed32d390ce363d964a9216ce9ab0ff9d74c,
  f0567fc3fb835499eda68f20e30ce16f9b83d774,
0b2bf1b37b5ebd90e69e30d8c2d6e1cd0c1f37b4,
  e1e87704621efcf0310bd1543a8e6352156a43bd,
2df4d0aba0e673d37be14901e853d1d540b19bbd,
  80d1978b8062cbad01cbea2aec2a5aac8f61c366]

CVE-2020-26555: BR/EDR pin code pairing broken

The commit 6d19628f ("Bluetooth: SMP: Fail if remote and local public
keys are identical") was merged in 5.13-rc1.
All stable kernels are fixed.

Fixed status

mainline: [6d19628f539fccf899298ff02ee4c73e4bf6df3f]
stable/4.14: [4555cee33f7d75c1ee69902c872c9d1e9568ebd5]
stable/4.19: [30126d4ba73119565f1748b116b9869ac6bbda6b]
stable/4.4: [75523bbfb0eaead670c97fbcf096ca2ab556f0c0]
stable/4.9: [6555a006b21ab49090b9a7b36e92d0421db19328]
stable/5.10: [d8d261c7cfb3a5dd921b4aeeb944718afc3f3961]
stable/5.4: [f97257cde764ad6979a7dbeb460b9fb69276342e]

CVE-2021-4149: description: Improper lock operation in btrfs

4.14, 4.19, and 4.9 kernels were fixed.

For 4.4
This patch can be applied to 4.4.

Fixed status

mainline: [19ea40dddf1833db868533958ca066f368862211]
stable/4.14: [e0956dd95ddd6b02b7eb084d127b926a509ae8e7]
stable/4.19: [73d55fa1b9310573f623195a4f7ab3170bbaf248]
stable/4.9: [43bfa08ba62a1ca7a22365c7092e491e04327efb]
stable/5.10: [206868a5b6c14adc4098dd3210a2f7510d97a670]
stable/5.4: [005a07c9acd6cf8a40555884f0650dfd4ec23fbe]
ubuntu/focal: [d1866774f0ef5d586ed62017838dd89869fe5dbb]

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
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

