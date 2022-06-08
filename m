Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D0EC43334
	for <webhook@archiver.kernel.org>; Wed,  8 Jun 2022 23:45:18 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web09.4564.1654731912310052787
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jun 2022 16:45:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=k/+Obn8W;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.180,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f180.google.com with SMTP id k11so29967626oia.12
        for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jun 2022 16:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FNCDsh5HYiv8jfPycZx8rVN7X/VVfhFhFlpqgMqelwI=;
        b=k/+Obn8WH0u11b6N2ZSLabcCZJ4krNRit2hocCrQWponUXRVF6fZPLc9JeHmFklMp6
         rl6+d1N+JhC9E7fjqpVcRSCxOfEBdP5EP8XKquhxKXureOKfzWBNapEUFLQJaTkQzQMN
         Yd5UjczONg1S2JCGptEiysAn9301JJYDeW3HegmYF0UyPZ8B6TaCmRWS+PHx9wyYJ2HW
         c9Hp9Gmegy18uUBlgt6k72wcDpOV3gM46NfCEPpx+FH4/5M8yiqGbaez7q3XaVm8NEvF
         d9LEisuo912Gmj0EmAq764zNO/JvZMuoCYXdlynKre3QC9uKUe2TQADLblHn4AmX3BW7
         Ebnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FNCDsh5HYiv8jfPycZx8rVN7X/VVfhFhFlpqgMqelwI=;
        b=o/uKpPFq7WtoASElKTKx+elnkq5MzY1gJOdJJ6dLLTmPMN5umYbOlbKYuFlo6WV4q2
         +jma8iayeml5QUU7J4XFrpwwQK2Wuea2zZgd7WiLCpqGEMxMfN+jDJ4e5dGrHTQHZ6hu
         iqHlf9hiI1FUHC1T4jo+ouQ0AQ1MCRQ9XC+fn0lAAXHyX7N4JxeJzjxvM5EJ73jaqtgi
         I+D3A2g28WHCCf2WWnd3pRZi225NdLoQRuETDT4Jsy9miQMHD6tR7vWu0e0on1tMGbWm
         j2KEndxS6O2FQxYtYd/WiDcNQzdIcdi5qdPBF/5sOoGwX+cS8l3kO93j5KdWRjopQ8nU
         +eQw==
X-Gm-Message-State: AOAM532pas8NahcJ572XHOmUCUFcdr4b4tmYKKbXrg3TOwGcHCnYIxuB
	fZjKjxGV6iY5ILWJl8R8Muu/+WbiWiFceCtPo5Aq4JeqmEzM+g==
X-Google-Smtp-Source: 
 ABdhPJwtNofYjJ33zJeyxtIl+XqHZGW7tTlXgVgTENpUOFqvVtz2n9rvAOAPdxtXlqQ/8dsGIk1+IxH94DFp5pi47kA=
X-Received: by 2002:a05:6808:128a:b0:32c:132a:9d87 with SMTP id
 a10-20020a056808128a00b0032c132a9d87mr250141oiw.87.1654731910938; Wed, 08 Jun
 2022 16:45:10 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 9 Jun 2022 08:44:34 +0900
Message-ID: 
 <CAODzB9proCGmsbhFuuOhx=pgwqsGsXEjz2Smd+S97_gFL-A5Dw@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jun 2022 23:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8519

Hi !

It's this week's CVE report.

This week reported 12 new CVEs and 5 updated CVEs.

* New CVEs

CVE-2022-1972: nf_tables: sanitize nft_set_desc_concat_parse()

CVSS v3 score is not assigned.

An OOB write bug was found in the netfilter module.
This bug was introduced by commit f3a2181 ("netfilter: nf_tables:
Support for sets with multiple ranged fields") in 5.6-rc1.
This commit wasn't backported to 5.4 and prior kernels so these
kernels aren't affected by this vulnerability.

Fixed status
mainline: [fecf31ee395b0295f2d7260aa29946b7605f7c85]
stable/5.10: [c0aff1faf66b6b7a19103f83e6a5d0fdc64b9048]
stable/5.15: [89ef50fe03a55feccf5681c237673a2f98161161]
stable/5.17: [c88f3e3d243d701586239c5b69356ec2b1fd05f1]
stable/5.18: [c9a46a3d549286861259c19af4747e12cfaeece9]

CVE-2022-1974: nfc: replace improper check device_is_registered() in
netlink related functions

CVSS v3 score is not assigned.

An UAF bug was found in /net/nfc/core.c that allow an attacker to
crash linux kernel by simulating nfc device from user-space.

Fixed status
cip/4.4: [0630ce232266d13644cd7a86dd7911d4825324b4]
cip/4.4-st: [0630ce232266d13644cd7a86dd7911d4825324b4]
mainline: [da5c0f119203ad9728920456a0f52a6d850c01cd]
stable/4.14: [6f0ac4cd0377ab4e0b49b8f6efd37057c21336a9]
stable/4.19: [7deebb94a311da0e02e621e765c3aef3d5936572]
stable/4.9: [fa2217b66467917a623993c14d671661ad625fb6]
stable/5.10: [8a9e7c64f4a02c4c397e55ba379609168ec7df4a]
stable/5.15: [a2168fb3128a576d0175443403c15dcf8bf128f6]
stable/5.17: [8b58d6e565d83443c51b3fc076bd4472674aca0c]
stable/5.4: [85aecdef77f9c5b5c0d8988db6681960f0d46ab3]

CVE-2022-1975: NFC: netlink: fix sleep in atomic bug when firmware
download timeout

When the nlmsg_new() is called from fw_dnld_timeout() which is a timer
handler, nlmsg_new() allocates memory with GFP_KERNEL . So,
nlmsg_new() may sleep to allocate memory.  If nlmsg_new() sleeps in
the context, it will cause a kernel panic.

CVSS v3 score is not assigned.

Fixed status
cip/4.4: [12ddd94e76f674056ee706557e6ce5be43bc06e8]
cip/4.4-st: [12ddd94e76f674056ee706557e6ce5be43bc06e8]
mainline: [4071bf121d59944d5cd2238de0642f3d7995a997]
stable/4.14: [c33b2afffe8ae90e0bd4790e0505edd92addf14c]
stable/4.19: [d360fc8df363ecd7892d755d69ffc8c61d699e38]
stable/4.9: [a93ea9595fde438996d7b9322749d4d1921162f7]
stable/5.10: [879b075a9a364a325988d4484b74311edfef82a1]
stable/5.15: [7bd81a05d48942ef2c48630e5e7963b187e95727]
stable/5.17: [63a545103b77091f2309b44a8975cdf255bb99b2]
stable/5.4: [01d4363dd7176fd780066cd020f66c0f55c4b6f9]

CVE-2022-32296: tcp: increase source port perturb table to 2^16

CVSS v3 score is not assigned.

The Linux kernel before 5.17.9 allows TCP servers to identify clients
by observing what source ports are used.
The INET_TABLE_PERTURB_SHIFT macro was introduced by commmit 190cc82
("tcp: change source port randomizarion at connect() time") in
5.12-rc1-dontuse. This commit has been backported to 4.14, 4.19, and
5.10 so these kernels affected by this vulnerability. This backport
was done recently.

Fixed status
mainline: [4c2c8f03a5ab7cb04ec64724d7d176d00bcc91e5]
stable/5.15: [952a238d779eea4ecb2f8deb5004c8f56be79bc9]
stable/5.17: [e3ee7bb47d6509c3e8a3e96e5d8e3bf21549b6e8]

CVE-2022-20132: vulnerability in USB HID subsystem

CVSS v3 score is not assigned.

No vunerability details yet.
According to the
https://source.android.com/security/bulletin/2022-06-01, this
vulnerability causes information disclosure.

It looks as if following commits fix related to vulnerability.
- f83baa0 ("HID: add hid_is_usb() function to make it simpler for USB
detection")
- 918aa1e ("HID: bigbenff: prevent null pointer dereference")
- 720ac46 ("HID: wacom: fix problems when device is not a valid USB device"=
)
- 9302095 ("HID: check for valid USB device for many HID drivers")

Following commits fix build error.
- 30cb3c2 ("HID: add USB_HID dependancy to hid-prodikeys")
- d080811 ("HID: add USB_HID dependancy to hid-chicony")
- f237d90 ("HID: add USB_HID dependancy on some USB HID drivers")

Fixed status
mainline: [f83baa0cb6cfc92ebaf7f9d3a99d7e34f2e77a8a,
30cb3c2ad24b66fb7639a6d1f4390c74d6e68f94,
  d080811f27936f712f619f847389f403ac873b8f,
f237d9028f844a86955fc9da59d7ac4a5c55d7d5,
  918aa1ef104d286d16b9e7ef139a463ac7a296f0,
720ac467204a70308bd687927ed475afb904e11b,
  93020953d0fa7035fd036ad87a47ae2b7aa4ae33]
stable/4.19: [b1efa723b986a84f84a95b6907cffe3a357338c9,
cb54ea86f247a28ce5d8ec147e58c13de669d04a,
  de8ac0cf03f1124ef39debb337811e54f3e2f55c,
b0f286d9b1f8a2448373aa45ac8333645c48ea85,
  945e3464ba6671692d0692d4b4325ec003db18c5,
128074f16e32c188fa2ed6edac625067c842606e]
stable/4.9: [28d8244f3ec961a11bfb4ad83cdc48ff9b8c47a7,
5b8d74ff145de1b5adb133895fd63cd533d68422,
  4435bc144fb6295db371e9753305a96f0c19b2ef,
c57e3b8082a4860f31f71d113b3e66bb64b4eb0a,
  1309eb2ef1001c4cc7e07b867ad9576d2cfeab47,
10d0f0aaa5cde52bd5685ee8d0adc02f1efb1983]
stable/5.10: [61144329606cb9518642b7d2e940b21eb3214204,
28989ed4d79e95dc59de6143c81c5826251b85e4,
  a7e9c5ddf562cf1923b21e5a085567807a059046,
d877651afd60dcbbcdc31f9efded3c27813afd1a,
  918aa1ef104d286d16b9e7ef139a463ac7a296f0,
889c39113f7e2219da49446b7e8772d1f62d0dca,
  89f3edc98ffe48557405ecfd9520f73244d099c9]
stable/5.15: [e1e21632a4c4d2f85587e204939883ce59d18447,
10b05037d7a831249bd513ba125e88b242c35a4b,
  8c765cf5f1bccf6d6f945db9c9e3a7602ad8bb46,
30d3150d909431fd7424ab8ff4c4c2c795554e30,
  58f15f5ae7786c824868f3a7e093859b74669ce7,
05ca95256abaf3971f73fdcf61a1f6091957f8fb,
  a579510a64ed15463a69cd6fe1a3339bf9ded33b]
stable/5.4: [6e1e0a01425810494ce00d7b800b69482790b198,
ee8477d1dbcee286e4f88ac9187b2f2fd0d0e156,
  f8a6538587b49ad48e0aa45e50d4fa3f7253c2ee,
31520ec149d28845f34c527a4e861502ea290a53,
  8e0ceff632f48175ec7fb4706129c55ca8a7c7bd,
e9114b9dc8ea3826b9d1b9af2462debeb91ed294,
  a7944962ee1f867711642fcdd8acd574a00dcdf7]

CVE-2022-20141: igmp: Add ip_mc_list lock in ip_check_mc_rcu

CVSS v3 score is not assigned.

An UAF bug was found in ip_check_mc_rcu() in net/ipv4/igmp.c.
According to the
https://source.android.com/security/bulletin/2022-06-01, this
vulnerability causes privilege escalation.
Fixed status
cip/4.4: [b24065948ae6c48c9e20891f8cfe9850f1d748be]
cip/4.4-rt: [b24065948ae6c48c9e20891f8cfe9850f1d748be]
mainline: [23d2b94043ca8835bd1e67749020e839f396a1c2]
stable/4.14: [78967749984cf3614de346c90f3e259ff8272735]
stable/4.19: [4768973dffed4d0126854514335ed4fe87bec1ab]
stable/4.9: [e9924c4204ede999b0515fd31a370a1e27f676bc]
stable/5.10: [ddd7e8b7b84836c584a284b98ca9bd7a348a0558]
stable/5.4: [d84708451d9041dff8a81e3718f821f12d2eb6c5]

CVE-2022-20148: An UAF bug was found in f2fs

CVSS v3 score is not assigned.

According to the
https://source.android.com/security/bulletin/pixel/2022-06-01, this
vulnerability causes privilege escalation.

Commit 5429c9d ("f2fs: fix UAF in f2fs_available_free_memory") fixes
an UAF bug which was introduced by commit d6d2b49 ("f2fs: allow to
change discard policy based on cached discard cmds") in v5.13-rc1. The
commit d6d2b49 isn't backported to stable kernels.

Fixed status
mainline: [d6d2b491a82e1e411a6766fbfb87c697d8701554,
5429c9dbc9025f9a166f64e22e3a69c94fd5b29b]
stable/5.15: [d6d2b491a82e1e411a6766fbfb87c697d8701554,
5e1b901dd470659bcfeaa76811d2af9165579d77]

CVE-2022-20153: io_uring: return back safer resurrect

CVSS v3 score is not assigned.

According to the
https://source.android.com/security/bulletin/pixel/2022-06-01, this
vulnerability causes privilege escalation.
This fix reverts commit cb5e1b8 ("Revert "io_uring: wait potential
->release() on resurrect"") that is merged in 5.12-rc1-dontuse.
Earlier than 5.1 kernels aren't affected by this issue because
io_uring was introduced since 5.1.

Fixed status
mainline: [f70865db5ff35f5ed0c7e9ef63e7cca3d4947f04]
stable/5.10: [dc1163203ae6e24b86168390fe5b4a3295fcba7f]

CVE-2022-20154: sctp: use call_rcu to free endpoint

CVSS v3 score is not assigned.

An UAF bug was found in sctp_sock_dump() in net/sctp subsystem.
According to the
https://source.android.com/security/bulletin/pixel/2022-06-01, this
vulnerability causes privilege escalation.
This commit fixes commit d25adbe ("sctp: fix an use-after-free issue
in sctp_sock_dump") which introduced in 4.14-rc1.
The commit d25adbe isn't backported to 4.4.y so 4.4.y kernel isn't
affected by this issue.

Fixed status
mainline: [5ec7d18d1813a5bead0b495045606c93873aecbb]
stable/4.14: [8873140f95d4977bf37e4cf0d5c5e3f6e34cdd3e]
stable/4.19: [af6e6e58f7ebf86b4e7201694b1e4f3a62cbc3ec]
stable/5.10: [769d14abd35e0e153b5149c3e1e989a9d719e3ff]
stable/5.15: [75799e71df1da11394740b43ae5686646179561d]

CVE-2022-20166: drivers core: Use sysfs_emit and sysfs_emit_at for
show(device *...) functions

CVSS v3 score is not assigned.

No vunerability details yet.
This fix changes from using sprintf() to sysfs_emit(), so it looks it
prevents buffer overflow bug.
According to the
https://source.android.com/security/bulletin/pixel/2022-06-01, this
vulnerability causes privilege escalation.
The commit aa83889 ("drivers core: Use sysfs_emit and sysfs_emit_at
for show(device *...) =E2=80=A6=E2=80=A6functions") was merged in 5.10-rc1.
This commit isn't backported to 4.x kernels. So, if backporting the
commit CVE-2022-20166 to 4.x series, commit aa83889 is required.

Fixed status
mainline: [aa838896d87af561a33ecefea1caa4c15a68bc47]
stable/5.4: [9e9241d3345af3f2a78a5b60701a9cf0d15bf942]

CVE-2022-1973: fs/ntfs3: Fix invalid free in log_replay

CVSS v3 score is not assigned.

An invalid free pointer in log_replay() ntfs3 subsystem. When
log_read_rst() returns ENOMEM error, it accesses uninitialized value
and
attempts call kfree that cause kernel crash. The ntfs3 subsystem was
introduced in 5.15 so earlier than this versions aren't affected by
this issue.

Fixed status
mainline: [f26967b9f7a830e228bb13fb41bd516ddd9d789d]

CVE-2022-1998: fanotify: Fix stale file descriptor in copy_event_to_user()

CVSS v3 score is not assigned.

An UAF vulnerability was found in fanotify subsystem. To exploit this
vulnerability, an attacker need to have CAP_SYS_ADMIN capability.

This vulnerability was introduced by commit f644bc4 ("fanotify: fix
copy_event_to_user() fid error clean up") in 5.13-rc7.
The commit f644bc4 isn't backported to earlier than 5.10 kernels.

Fixed status
mainline: [ee12595147ac1fbfb5bcb23837e26dd58d94b15d]
stable/5.10: [7b4741644cf718c422187e74fb07661ef1d68e85]
stable/5.15: [60765e43e40fbf7a1df828116172440510fcc3e4]

* Updated CVEs

CVE-2022-1966: netfilter: nf_tables: disallow non-stateful expression
in sets earlier

The mainline, 5.10, 5.15, 5.17, and 5.18 were fixed this week.

Fixed status
mainline: [520778042ccca019f3ffa136dd0ca565c486cedd]
stable/5.10: [ea62d169b6e731e0b54abda1d692406f6bc6a696]
stable/5.15: [f692bcffd1f2ce5488d24fbcb8eab5f351abf79d]
stable/5.17: [d8db0465bcc4d4b54ecfb67b820ed26eb1440da7]
stable/5.18: [8f44c83e51b4ca49c815f8dd0d9c38f497cdbcb0]

CVE-2022-21499: lockdown: also lock down previous kgdb use

5.4 was fixed this week.

Fixed status
mainline: [eadb2f47a3ced5c64b23b90fd2a3463f63726066]
stable/5.10: [a8f4d63142f947cd22fa615b8b3b8921cdaf4991]
stable/5.15: [69c5d307dce1560fafcb852f39d7a1bf5e266641]
stable/5.17: [281d356a035132f2603724ee0f04767d70e2e98e]
stable/5.18: [eca56bf0066ef2f1e7be0e3fa7564b85a309872c]
stable/5.4: [8bb828229da903bb5710d21065e0a29f9afd30e0]

CVE-2022-0494: block-map: add __GFP_ZERO flag for alloc_page in
function bio_copy_kern

4.14, 4.19, and 4.9 kernels were fixed this week.

Fixed status
mainline: [cc8f7fe1f5eab010191aa4570f27641876fa1267]
stable/4.14: [4f3ea768c56e8dce55ae538f18b37420366c5c22]
stable/4.19: [18243d8479fd77952bdb6340024169d30b173a40]
stable/4.9: [d59073bedb7cf752b8cd4027dd0f67cf7ac4330f]
stable/5.10: [a439819f4797f0846c7cffa9475f44aef23c541f]
stable/5.15: [a1ba98731518b811ff90009505c1aebf6e400bc2]
stable/5.16: [f8c61361a4f52c2a186269982587facc852dba62]

CVE-2022-1012: secure_seq: use the 64 bits of the siphash for port
offset calculation

Commit 695309c5 ("secure_seq: use the 64 bits of the siphash for port
offset calculation") was added to 4.19.

Fixed status
mainline: [b2d057560b8107c633b39aabe517ff9d93f285e3,
9e9b70ae923baf2b5e8a0ea4fd0c8451801ac526,
  4dfa9b438ee34caca4e6a4e5e961641807367f6f,
ca7af0402550f9a0b3316d5f1c30904e42ed257d,
  e9261476184be1abd486c9434164b2acbe0ed6c2,
4c2c8f03a5ab7cb04ec64724d7d176d00bcc91e5,
  e8161345ddbb66e449abde10d2fdce93f867eba9]
stable/4.19: [abcf4e1277d169b82dd7ee290006487ed16016ce,
695309c5c71526d32f5539f008bbf20ed2218528]
stable/5.10: [d254309aab27fdcdc68e6bc9c663e51f3e7b37dc,
a5c68f457fbf52c5564ca4eea03f84776ef14e41]
stable/5.15: [1a8ee547da2b64d6a2aedbd38a691578eff14718,
ff01554d8755bdbe2aec2e2cff322d95f328cb89,
  f41f6336bfc43500e4e94ada703cd5aebb91789e,
b763fce193b42048444afd85d066b136288ad2c8,
  4a3eefa399e675c4a5239497832a72733281a20f,
952a238d779eea4ecb2f8deb5004c8f56be79bc9,
  f26c6f9404e1d6f3bfc9780ffba82a01a595d147]
stable/5.17: [6976724355f5fdada89de528730f9a7b4928f2e3,
27003fa8b581098aa9768bc03f82d5654368cb02,
  3a8081f81323e1550c241157244318db166b660e,
c2cef1db8f8aa81330fee4538a1158e1f6fd5bd1,
  01e16c23823a057667feb5cf26ba0c963fef6afd,
e3ee7bb47d6509c3e8a3e96e5d8e3bf21549b6e8,
  5034cbb361e1c447911a15b1d3982d5df7aa17b9]

CVE-2022-1852: KVM: x86: avoid calling x86 emulator without a decoded
instruction

5.10, 5.15, 5.17, and 5.18 were fixed this week.

Fixed status
mainline: [fee060cd52d69c114b62d1a2948ea9648b5131f9]
stable/5.10: [3d8fc6e28f321d753ab727e3c3e740daf36a8fa3]
stable/5.15: [531d1070d864c78283b7597449e60ddc53319d88]
stable/5.17: [dca5ea67a3e627a3022fe58722a2807c1ef61c29]
stable/5.18: [02ea15c02befea2539d5f0d6b60ce8df88de418b]

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

