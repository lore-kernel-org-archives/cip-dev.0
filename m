Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039CEC433EF
	for <webhook@archiver.kernel.org>; Wed,  9 Mar 2022 23:55:59 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by mx.groups.io with SMTP id smtpd.web09.3970.1646870157561090913
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Mar 2022 15:55:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=z63i7+bs;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.176,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f176.google.com with SMTP id n7so4328600oif.5
        for <cip-dev@lists.cip-project.org>;
 Wed, 09 Mar 2022 15:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=7atoMPKhMJ7HkUgNkYgxEDZzJ+BvnVE2ukRcLE4b1oo=;
        b=z63i7+bs1E7xtyi2f9m/ZEv8InD8JDHVA9I1nlyL9zTm+50eLam3ge2DPlKwTbGF+o
         W9/2stenryUiIwus0J0yXdefN3o1cTClkliKMZ0NzldOErpFcuxnbvlXednDblDkCrh2
         8gIT9NbssDFSPH+s6VMrrxJ5PN6VeqZ7NuGHPWOgoMtEoOErNouhi+kLQtBkOBQlp3La
         +nFCojfcJHY4xt6WTeVf+mHIZBbQBKOwERINuuo9ecFOvJ0a8gXw46WEEFWVcHfK6f1R
         reqYyBaewc2B8tVhyIKkm9qrH7ovrGUmsjP1M8UpUO3MUJ6Y47W4kFjwZzpDQM9P5ZXg
         qlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7atoMPKhMJ7HkUgNkYgxEDZzJ+BvnVE2ukRcLE4b1oo=;
        b=YW6jhMHT32qMAw5+mDzxevS3aj8n0Q72tfe2dMzhzW4cxp6TUzZDtwRYtQciHc2bU4
         FPyc0WVsx75ujNK1sNSa6thPWlGX4a615UQn3wansMXvWhWIu8ox9XrJmtSDHEJPPkZa
         fXOJn2f40myWIJXcOn2yRJkmMgIcirvCHZ9ANLcCJM9xr8/jTKQSQhzGUXLlO8+93OeL
         Xv4Va5OGgSa8cSMnxGa8o7CJbEgmGVd9tPCFT0lcpQmC/lX8v/M4+Qf1JDdTwqL/dv+G
         +KdlvgjG2g/xvNa+va5vlx9gjcXR+sV2bRMzlUxvYnXQwWPmWAN7Ro8MtyllukUv3/kx
         DkGQ==
X-Gm-Message-State: AOAM530s3w7g8gDtxl8PlwVproPf+J0r9M5bUgMiZ3eVHyaBRtpeysvD
	ZBvUEFfKlB4I2RovsGllWngmqEf2bn1fllcU9HUuSTUiON9z7A==
X-Google-Smtp-Source: 
 ABdhPJxKxQUlLNA0X1nZRaSJAORdLWBtVmDK3DnWXIUIr09aRU66Cxt0ZGVw1kRPC5PfCDL4vPyNxzQrg4s4rFy4crA=
X-Received: by 2002:a05:6808:1304:b0:2d5:4170:e084 with SMTP id
 y4-20020a056808130400b002d54170e084mr1348176oiv.19.1646870156242; Wed, 09 Mar
 2022 15:55:56 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 10 Mar 2022 08:55:20 +0900
Message-ID: 
 <CAODzB9qc8CMpwWAVX8JuxsCrA9rwYMors8g7vsShL_OeWuTwwg@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Mar 2022 23:55:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7685

Hi !

It's this week's CVE report.

This week reported 12 new CVEs and 3 updated CVEs.

CVE-2022-0847 is Dirty Pipe.
CVE-2022-0001, CVE-2022-0002, and 2022-23960 are BHI(Spectre-V2 variant).

* New CVEs

CVE-2022-26490 : nfc: st21nfca: Fix potential buffer overflows in
EVT_TRANSACTION

CVSS v3 score is not provided

st21nfca_connectivity_event_received in drivers/nfc/st21nfca/se.c in
the Linux kernel through 5.16.12 has EVT_TRANSACTION buffer overflows
because of untrusted length parameters.

Patch can be applied to 4.4.y without any conflict.

Fixed status

mainline: [4fbcc1a4cb20fe26ad0225679c536c80f1648221]

CVE-2022-0847: lib/iov_iter: initialize "flags" in new pipe_buffer

CVSS v3 score is not provided

A flaw was found in the way the "flags" member of the new pipe buffer
structure was lacking proper initialization in copy_page_to_iter_pipe
and push_pipe functions in the Linux kernel and could thus contain
stale values. An unprivileged local user could use this flaw to write
to pages in the page cache backed by read only files and as such
escalate their privileges on the system. This flaw affects Linux
kernel versions prior to 5.17-rc6.

This uninitialized bug was introduced by commit 241699cd ("new
iov_iter flavour: pipe-backed") that was merged at 4.9.
However, the commit f6dd975583bd ("pipe: merge anon_pipe_buf*_ops")
that was merged at 5.8-rc1 made this bug become exploitable.

4.4.y isn't affected by this issue.

fixed status

mainline: [9d2231c5d74e13b2a0546fee6737ee4446017903]
stable/4.14: [a162b11c975ef9a03a75027c04052906ed7710da]
stable/4.19: [d46c42d8d2742742eddf9290e72df4b563f2e301]
stable/4.9: [c460ef6e0596eb5ca844c45338c20f6023f1e43c]
stable/5.10: [b19ec7afa9297d862ed86443e0164643b97250ab]
stable/5.15: [114e9f141822e6977633d322c1b03e89bd209932]
stable/5.16: [eddef98207d678f21261c2bd07da55938680df4e]
stable/5.4: [87c575d2a238febe8a04241008f18252fe5d093d]

CVE-2021-39686: A race condition bug was found in Android Binder driver

CVSS v3 score is not provided

According to the commit message, there was a race condition bug in
Android Binder driver. Commit 29bc22a and c21a80c mentioned that these
patches fix kernel 4.4 as well.
It seems no CIP member enables this driver.

Fixed status

mainline: [29bc22ac5e5bc63275e850f0c8fc549e3d0e306b,
52f88693378a58094c538662ba652aff0253c4fe,
  4d5b5539742d2554591751b4248b0204d20dcc9d,
c21a80ca0684ec2910344d72556c816cb8940c01]
stable/4.19: [5d40061285b81a7e213dc9b37acc4a0545eedf32,
e82f3f9638f17d58e9a217bce127e2376aefcb9d,
  c3b9f29fca6682550d731c80745b421415c1e0af]
stable/4.9: [443fc43d2fdbf55be7aa86faae1f7655e761e683,
22d4a6dacee058b58640ef8109b0c8fc5d1b80e2,
  404fb1097298690b1d7d1c59eab806bbdd757267]
stable/5.10: [bd9cea41ac6e08f615030dea28b23e12b7a2674f,
0d9f4ae7cd6f5283dd0e343265268c695ef592b0,
  afbec52fbce006a775edb21f87ccae713bc0e7d6,
4402cf0402526f7c5befa97481be13b131797838]
stable/5.15: [ff1bd01f490ba60d82c765100d95d13cc00c1625,
3f3c31dd0f8cfdc4ce301a4a605488fb73602ea5,
  6e8813eadf8bcf0ea26360658b1679971d0a501c,
849d86e85951ea409b09e384d1f0060a3adfdb58]
stable/5.4: [28a1e470b000d45bcf6c05f18a01d07cdc0b3235,
fc9c470cd519e5bb37cf4c92603b2d4e604f5b71,
  db39f49ee7d50e68bf46796c05d9deae256ce986,
aaa83768ba39586fe0abe2fb1825b89f3bf6270c]

CVE-2021-39711: bpf: fix panic due to oob in bpf_prog_test_run_skb

CVSS v3 score is not provided

OOB bug in bpf BPF_PROG_TEST_RUN command.
This bug was introduced by commit 1cf1cae ("bpf: introduce
BPF_PROG_TEST_RUN command") which was merged at 4.12-rc1.
This bug was fixed in v4.18-rc6. So, only stable/4.14 is affected by this issue.

Fixed status

mainline: [6e6fddc78323533be570873abb728b7e0ba7e024]
stable/4.14: [20fdf274472998123a8d173ba4cb6282ff6b63bd]

CVE-2021-39698: binder: use wake_up_pollfree()

CVSS v3 score is not provided

There is no details. However, one of commits a880b28 ("binder: use
wake_up_pollfree()") fixes the Android Binder driver so it seems a
vulnerability will be in this driver.

From the commit message, it said added wake_up_pollfree() function to
wake up all exclusive waiters. The epoll and aio poll may not be
affected by this issue but it's very fragile.
Therefore this patches series contains aio and epoll patches.

The commit a880b28 ("binder: use wake_up_pollfree()") fixes f5cb779
("ANDROID: binder: remove waitqueue when thread exits.") that was
merged at 4.16-rc1.

The commit 9537bae ("signalfd: use wake_up_pollfree()") fixes d80e731
("epoll: introduce POLLFREE to flush ->signalfd_wqh before kfree() ")
that was merged at 3.3-rc5.

The commit 363bee2 ("aio: keep poll requests on waitqueue until
completed") fixes commit 2c14fa8 ("aio: implement IOCB_CMD_POLL") that
was merged at 4.18-rc1.

The commit 50252e4 ("aio: fix use-after-free due to missing POLLFREE
handling") fixes commit 2c14fa8 ("aio: implement IOCB_CMD_POLL") that
was merged at 4.18-rc1.

Fixed status

mainline: [42288cb44c4b5fff7653bc392b583a2b8bd6a8c0,
a880b28a71e39013e357fd3adccd1d8a31bc69a8,
  9537bae0da1f8d1e2361ab6d0479e8af7824e160,
363bee27e25804d8981dd1c025b4ad49dc39c530,
  50252e4b5e989ce64555c7aef7516bdefc2fea72]
stable/4.19: [8dd7c46a59756bdc29cb9783338b899cd3fb4b83,
32288f504035b6c359cc33ee615f74f14be2e38a,
  f226fdd855b7d9c1f2a6e878d82eb3e1fbc880e9,
580c7e023303ce3a187adcaa40868bfc740725d2,
  321fba81ec034f88aea4898993c1bf15605c023f]
stable/4.9: [0e92a7e47a0411d5208990c83a3d200515e314e8,
0487ea896e62b5a90a81ac6e73c35e595d77f499,
  5ecb4e93d70a21f3b7094029986ef0c3e321f56c]
stable/5.10: [8e04c8397bf98235b1aa41153717de7a05e652a2,
9f3acee7eac8d8690134b09ba55e2c12164d24ae,
  fc2f636ffc446d8e9530e441897f877922269051,
e4d19740bccab792f16c7ca6fd1f9aea06193cb2,
  47ffefd88abfffe8a040bcc1dd0554d4ea6f7689]
stable/5.15: [1ebb6cd8c754bfe1a5f9539027980756bce7cb08,
f12d997683a7a97e7af834d3181fad61ad67df47,
  8d6760fd5d1604df29dd7651033167ef99a7698d,
924f51534d428e91c98ea309ab16270f5e8289c6,
  60d311f9e6381d779d7d53371f87285698ecee24]
stable/5.4: [e0c03d15cd03476dd698c1ae7fb32a16d3e87f5c,
1a478a0522e5618480ee298e886eed18dcac1459,
  aac8151624b6376e42b2c60410fe7e3aba3a3d1b,
380185111fa881fa68382ecf7328c608212218dd,
  4105e6a128e8a98455dfc9e6dbb2ab0c33c4497f]

CVE-2021-39713: locking issue in net/sched module

CVSS v3 score is not provided

There is no details. These patch series modified locking strategies
that use Qdisc rcu API instead of rtnl lock.

All patches were merged at 4.20-rc1 in the mainline.

Fixed status

mainline: [e368fdb61d8e7c67ac70791b23345b26d7bbc661,
9d7e82cec35c027756ec97e274f878251f271181,
  3a7d0d07a386716b459b00783b11a8211cefcc0f,
86bd446b5cebd783187ea3772ff258210de77d99,
  6f99528e9797794b91b43321fbbc93fe772b0803]
stable/4.19: [ae214e04b95ff64a4b0e9aab6742520bfde6ff0c,
da1d324088c40fa0a382224c466175fc5c704106,
  f602ed9f8574512e7ea1ab65c3db7ba71053bf27,
92833e8b5db6c209e9311ac8c6a44d3bf1856659,
  cd25f1099284a0cbe916344fc1e6c1ffed6c5306]

CVE-2021-39714: staging: android: ion: Drop ion_map_kernel interface

CVSS v3 score is not provided

There is no details. This patch removes some functions in
drivers/staging/android/ion/ion.c.
The ion driver was removed from the mainline in 5.11-rc1.
This fix was merged in 4.12-rc1.

The patch removes ion_handle_kmap_get(), ion_map_kernel(), and
ion_unmap_kernel().

For 4.4, ion_handle_kmap_get() is called from ion_map_kernel() but it
looks ion_map_kernel() isn't called from anywhere.
So, It seems to be okay to remove these functions from 4.4.y.

Fixed status

mainline: [e3b914bc7eb6bcecc5b597ee6e31fc40442c291f]
stable/4.9: [16b34e53eaadda6cbb1f0452fd99700c44db23be]

CVE-2022-0850: kernel: information leak in copy_page_to_iter() in iov_iter.c

CVSS v3 score is not provided

This is an information leak bug in ext4 file system.
The mainline and stable kernels, and 4.4 kernels are already fixed.
This bug was fixed in 5.14-rc1.

Fixed status

cip/4.4: [ce14bff239a107344b153bd6504a2f8165f672e9]
cip/4.4-rt: [ce14bff239a107344b153bd6504a2f8165f672e9]
mainline: [ce3aba43599f0b50adbebff133df8d08a3d5fffe]
stable/4.14: [29d882f9a6a6219a1c59729e1f43fa40663903e4]
stable/4.19: [9ed3a3d3a8d2cbe99d9e4386a98856491f0eade0]
stable/4.9: [25dcc64fa0c9399653e1fd1a4bad6c1e8cb31f3f]
stable/5.10: [ea5466f1a77720217a25a859b5a58b618aaba544]
stable/5.4: [ed628b2531196cc76d7c9b730abe4020cad26b0b]

CVE-2022-20003: net/packet: rx_owner_map depends on pg_vec

CVSS v3 score is not provided

The commit ec6af09 ("net/packet: rx_owner_map depends on pg_vec") also
fixes CVE-2021-22600. It may be a duplicate of the CVE-2021-22600 or
different symptom but same root cause.

4.9 and 4.4 kernels aren't affected by CVE-2021-22600 so if
CVE-2022-20003 and CVE-2021-22600 have the same issue, we don't have
to take care of these kernels.

Fixed status

mainline: [ec6af094ea28f0f2dda1a6a33b14cd57e36a9755]
stable/4.14: [a829ff7c8ec494eca028824628a964cde543dc76]
stable/4.19: [18c73170de6719491f79b04c727ea8314c246b03]
stable/5.10: [7da349f07e457cad135df0920a3f670e423fb5e9]
stable/5.15: [feb116a0ecc5625d6532c616d9a10ef4ef81514b]
stable/5.4: [027a13973dadb64ef4f19db56c9b619ee82c3375]

CVE-2022-0001 and CVE-2022-0002: Sharing of branch predictor selectors
between contexts on Intel CPUs

CVSS v3 score is not provided

It is called BHI(or Spectre-BHB) which is a Spectre V2 variant. This
CVE is tracked by BHI for Intel cpus.
One of the mitigation methods is to disable unprivileged eBPF.

Fixed in mainline as of 2022/03/09 but not released yet.

Fixed status

mainline: [d45476d9832409371537013ebdd8dc1a7781f97a,
1e19da8522c81bf46b335f84137165741e0d82b7,
  5ad3eb1132453b9795ce5fd4572b1c18b292cca9,
44a3918c8245ab10c6c9719dd12e7a8d291980d8,
  244d00b5dd4755f8df892c86cab35fb2cfd4f14b,
e9b6013a7ce31535b04b02ba99babefe8a8599fa,
  eafd987d4a82c7bb5aa12f0e3b4f8f3dea93e678,
0de05d056afdb00eca8c7bbb0c79a3438daf700c]

CVE-2022-23960: Arm cpus BHI problem

CVSS v3 score is not provided

It is called BHI(or Spectre-BHB) which is a Spectre V2 variant. This
CVE is tracked by BHI for Arm cpus.
It also disables unprivileged eBPF is recommended.

Fixed in mainline as of 2022/03/09 but not released yet.

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

* Updated CVEs

CVE-2022-25636: netfilter: nf_tables_offload: incorrect flow offload
action array size

This issue was introduced by commit be2861d ("netfilter:
nft_{fwd,dup}_netdev: add offload support") that was merged since
5.4-rc1.
This week, stable/5.x series were fixed.

Fixed status

mainline: [b1a5983f56e371046dcf164f90bfaf704d2b89f6]
stable/5.10: [68f19845f580a1d3ac1ef40e95b0250804e046bb]
stable/5.15: [6c5d780469d6c3590729940e2be8a3bd66ea4814]
stable/5.16: [6bff27caef1ee07a8b190f34cf32c99d6cc37a33]
stable/5.4: [49c011a44edd14adb555dbcbaf757f52b1f2f748]

CVE-2020-36310: KVM: SVM: avoid infinite loop on NPF from bad address

This bug was introduced in v4.16-rc1 and fixed in v5.8-rc1.
Fix commit e72436b ("KVM: SVM: avoid infinite loop on NPF from bad
address") wasn't fixed enough. So 55467fc ("KVM: SVM: Never reject
emulation due to SMAP errata for !SEV guests") is a new commit to fix
CVE-2020-36310.

Fixed status

mainline: [55467fcd55b89c622e62b4afe60ac0eb2fae91f2]
stable/5.10: [9dcedbe943be8c93722c1ed68b59001b28b0d889]
stable/5.15: [3470722fac229594182d7c2b46041323560b1924]
stable/5.16: [0b0dd3ef2d3586cc6518fe2430aa29a208ded295]

CVE-2022-24958: drivers/usb/gadget/legacy/inode.c mishandles dev->buf release

Stable kernels were fixed this week.

Fixed status

mainline: [89f3594d0de58e8a57d92d497dea9fee3d4b9cda,
501e38a5531efbd77d5c73c0ba838a889bfc1d74]
stable/4.14: [6936d1097e9cb891e1daaa8aab1b9c080f5e59a2,
70959fa1a003cb7c6ed2fd0e0f887125d08b8bf6]
stable/4.19: [70196d12856306a17ddc3eae0f022b9c1d748e52,
6b432b7b5a77e8bfd041da0ba00c98fa31097c4e]
stable/4.9: [be1bb345f180482b0e57768d967ef020d7cba592,
e09100044e658fb7906494ed5109323ba64f3e7a]
stable/5.10: [c13159a588818a1d2cd6519f4d3b6f7e17a9ffbd,
fdd64084e405544c5c11841ca9261785c988e2a1]
stable/5.15: [07de9a494b5ae41b9253411a8e9576d7fceedcc3,
ab3656acb7b4f33a30970a920ed90f0db36d940b]
stable/5.16: [9e5c16b2a9812cd250f0de0b77391c2d63adf2f2,
030b335a1dd1f306da6cee0514f22e602576389e]
stable/5.4: [ba6fdd55b16677dcc1d7011270c140d2a37e5f35,
58b419d16e8791e16f8865463aa28bbcef726e26]

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
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

