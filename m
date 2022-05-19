Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBB4C433EF
	for <webhook@archiver.kernel.org>; Thu, 19 May 2022 00:22:05 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web11.1843.1652919717760590893
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 May 2022 17:21:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=SjsIaRR0;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.180,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f180.google.com with SMTP id m25so4695362oih.2
        for <cip-dev@lists.cip-project.org>;
 Wed, 18 May 2022 17:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=vmu9twL14xoTM9DnW0szXzexYfgmh0fYINXP0UUfmm4=;
        b=SjsIaRR0eYWLYKx5dH6rYtV8/Q4WrnjJHvaocVtedbiDzVWFtXAq1SHd9ytFXI0PoW
         RAc7wxLNldVgcJv8uxuqUCXp1GH1C/klbb/vQA1qQbeLuho1p60ChmXrk5HqLCm35L0I
         WeZXoisA6nHYpiI7zwz2vRaUN0NJhy6ISrz0gzNe8LuoKbEWxVYQoLyGR6fNFDpp+h6N
         CtG6CY6I4A3e/JP/R2GG4Z1NrV9d648kmiIWm91L4wH/UJP5TOsMOHKXUIx51aYHtsZo
         Ovx2qegz9mBGqDQVz3dceTEe5OwwnJsg3W1EZVNKk7QpTp1UeSaZLSq79KPz2DMkHory
         L7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vmu9twL14xoTM9DnW0szXzexYfgmh0fYINXP0UUfmm4=;
        b=43Kwuo+1tSsR+jmfApSbgtrzNiZgJMVU7JbymhEG0x12BBWoX0r68eaAH5XfNz1m9K
         inDTvysb82k/RZmJLwvnntYcE/StnV2DtIcWMphEujgDlg9olgQVtaKkxHvAvLPxMUMR
         9T0A0ibpxyfPRe9auUHd9Bft9ULml9KYTe6Ehx6oxMdvCRs47rJSZyrK96tqhEwqBoxi
         vBYLonjAT1Y+VYdcZbTSG7jKARxeT5/FqmVr56mFG4GmvJnu4tOqrTNeSxtE4ri/awcX
         xg3eUcyz3opS+pofbZPH9+bjvBZGQFOK6AhRDzKh056ivI808s20QDt9qPsXZqEjFGK2
         09TA==
X-Gm-Message-State: AOAM532WeURCQuNSo5BVzoYThu8xOxeWzCU2O52MbkCibJjKKFaNv9Om
	LSvmck211wHy20wDmQlT4kcyZUYzBMWb0SA3OxUnSnkJOIXeFQ==
X-Google-Smtp-Source: 
 ABdhPJx+unNKm+tJFabRSF87NT3O9nX7pIaxmB7BSCMH+5BRP+FXIANWmBsH8SREae7MHf07l5J6mBp02EHcBaee1fs=
X-Received: by 2002:a54:4f87:0:b0:324:ea60:b97d with SMTP id
 g7-20020a544f87000000b00324ea60b97dmr1506318oiy.87.1652919716475; Wed, 18 May
 2022 17:21:56 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 19 May 2022 09:21:20 +0900
Message-ID: 
 <CAODzB9rW7E3W75GsNMZPqL5O1a_6tfZHALcLeYcSwwTA-ZVd=g@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 May 2022 00:22:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8411

Hi !

It's this week's CVE report.

This week reported 9 new CVEs and 10 updated CVEs.

* New CVEs

CVE-2022-0171: KVM: cache incoherence issue in SEV API may lead to kernel crash

CVSS v3 score is not assigned.

Bug was found in KVM SEV API that non-root users crash the host kernel
by creating a confidential guest vm instance in AMD CPU that supports
AMD's SEV.

Introduced by commit f980f9c ("x86/sev-es: Compile early handler code
into kernel image") which was merged in 5.10-rc1.
Kernel versions less than 5.10 are not affected.

Fixed status

mainline: [683412ccf61294d727ead4a73d97397396e69a6b]

CVE-2022-1247: kernel: A race condition bug in rose_connect()

CVSS v3 score is not assigned.

A race condition bug was found in the rose driver(Amateur Radio X.25
PLP (Rose)).
No CIP member enables CONFIG_ROSE.

Fixed status

Not fixed yet.

CVE-2022-1679: Use-After-Free in ath9k_htc_probe_device() could cause
an escalation of privileges

CVSS v3 score is not assigned.

An UAF bug was found in ath9k_htc_probe_device() in the ath9k driver.
This vulnerability allows a local attacker to crash system or
potentially escalate their privileges on the system
Patch is available(https://lore.kernel.org/lkml/87ilqc7jv9.fsf@kernel.org/t/)
but not merged into the mainline yet.

This issue was introduced by commit fb9987d ("ath9k_htc: Support for
AR9271 chipset.") which was merged in 2.6.35-rc1.

Fixed status

Not fixed yet.

CVE-2022-30594: ptrace: Check PTRACE_O_SUSPEND_SECCOMP permission on
PTRACE_SEIZE

CVSS v3 score is not assigned.

Missing permission check bug was found in the seccomp module by using
the PTRACE_SEIZE flag.
This bug was introduced by commit 13c4a90 ("seccomp: add ptrace
options for suspend/resume") that was merged in 4.3-rc1.

Fixed status

mainline: [ee1fee900537b5d9560e9f937402de5ddc8412f3]
stable/4.14: [f1442ed84c43610ca8ab77deb9ca991e7354746c]
stable/4.19: [b1f438f872dcda10a79e6aeaf06fd52dfb15a6ab]
stable/4.9: [4f96b94a8342fac058117962f1a76fc7ebd1c245]
stable/5.10: [5a41a3033a9344d7683340e3d83f5435ffb06501]
stable/5.15: [b6d75218ff65f4d63c9cf4986f6c55666fb90a1a]
stable/5.17: [4d51bbc8a3799febf50471eb6888b1b58e87111e]
stable/5.4: [2458ecd21f29a3e5571d7d97764c043083deed5e]

CVE-2022-1734: nfc: nfcmrvl: main: reorder destructive operations in
nfcmrvl_nci_unregister_dev to avoid bug

CVSS v3 score is not assigned.

A reorder destructive operations bug found in the nfc module which
leads to double free/UAF/null pointer dereference bugs.
This bug was introduced by commit 194c68 ("NFC: nfcmrvl: add firmware
download support") that was merged in 4.4.
No CIP member enables CONFIG_NFC_MRVL.

Fixed status

mainline: [d270453a0d9ec10bb8a802a142fb1b3601a83098]
stable/4.14: [ced30680fb1c7c1daae39a9384d23cd1a022585f]
stable/4.19: [b266f492b2af82269aaaab871ac3949420ae678c]
stable/4.9: [4721695be941626e4b18b89e0641e36fc385cfd8]
stable/5.10: [1961c5a688edb53fe3bc25cbda57f47adf12563c]
stable/5.15: [b8f2b836e7d0a553b886654e8b3925a85862d2eb]
stable/5.17: [f4bfbac45121c8638db5eacb1ebbb61ee956c668]
stable/5.4: [33d3e76fc7a7037f402246c824d750542e2eb37f]

CVE-2022-29581: net/sched: cls_u32: fix netns refcount changes in u32_change()

CVSS v3 score is 7.8 HIGH.

Improper update of reference count bug was found in net/sched module.
This bug allows a local attacker to cause privilege escalation.

The mainline and cip kernels, and stable kernels were fixed.
This bug was introduced by commit 35c55fc156d8 ("cls_u32: use
tcf_exts_get_net() before call_rcu()" in 4.14.

Fixed status

mainline: [3db09e762dc79584a69c10d74a6b98f89a9979f8]
stable/4.14: [0511cdd41a03ab396602dded4e778c5edcd8dcd1]
stable/4.19: [75b0cc7904da7b40c6e8f2cf3ec4223b292b1184]
stable/5.10: [43ce33a68e2bcc431097e1075aad5393d0bf53ba]
stable/5.15: [ba9e9a794fd1689bf7e8a7452c55f3d3cbda7728]
stable/5.17: [64c87076791198b23da730186b0c141d9a6ce80c]
stable/5.4: [5a4f3eba211a532b2eb5045102ad3ceea5e9f0f9]

CVE-2022-1116: Integer Overflow or Wraparound vulnerability in io_uring

CVSS v3 score is 7.8 HIGH.

This bug is the 5.4 kernel specific issue. The commit cac68d1
("io_uring: grab ->fs as part of async offload") introduced this
issue.

Fixed status

stable/5.4: [1a623d361ffe5cecd4244a02f449528416360038]

CVE-2022-1671: A NULL pointer dereference flaw was found in
rxrpc_preparse_s in net/rxrpc/server_key.c

CVSS v3 score is not assigned.

A null pointer dereference bug in net/rxrpc/server_key.c in
rxrpc_preparse_s. This bug allows a local attacker to crash the system
or leak internal kernel information.

This vulnerability was introduced by 12da59f ("rxrpc: Hand server key
parsing off to the security class") which was merged in 5.11-rc1.
Linux kernel versions less than 5.11 are not affected.

Fixed status

mainline: [ff8376ade4f668130385839cef586a0990f8ef87]
stable/5.15: [432297011caf71dbc95c3365a65adf365e79aff3]
stable/5.17: [4e1f670e1b440dc783dbeb881d575bca31474f73]

* Updated CVEs

CVE-2021-26401: The speculative execution window of AMD LFENCE/JMP
mitigation (MITIGATION V2-2) may be large enough to be exploited on
AMD CPUs.

Added more patches to mainline, 4.19, 4.9, and 5.10.

Fixed status

mainline: [244d00b5dd4755f8df892c86cab35fb2cfd4f14b,
e9b6013a7ce31535b04b02ba99babefe8a8599fa,
  eafd987d4a82c7bb5aa12f0e3b4f8f3dea93e678,
0de05d056afdb00eca8c7bbb0c79a3438daf700c]
stable/4.14: [85938688be23ecd36a06757096896b2779b80d97]
stable/4.19: [d3cb3a6927222268a10b2f12dfb8c9444f7cc39e,
c034d344e733a3ac574dd09e39e911a50025c607,
  8bfdba77595aee5c3e83ed1c9994c35d6d409605,
9711b12a3f4c0fc73dd257c1e467e6e42155a5f1]
stable/4.9: [b6a1aec08a84ccb331ce526c051df074150cf3c5,
0db1c4307aded2c5e618654f9341a249e0c1051f,
  8edabefdc13294a9b15671937d165b948cf34d69,
0753760184745250e39018bb25ba77557390fe91]
stable/5.10: [2fdf67a1d215574c31b1a716f80fa0fdccd401d7,
e335384560d1e106b609e8febd7e0427075a8938,
  cc9e3e55bde71b2fac1494f503d5ffc560c7fb8d,
d04937ae94903087279e4a016b7741cdee59d521]
stable/5.15: [a56566d7a957c34811384d6300a53a97be94cd20]
stable/5.4: [b1bacf22a847d21a12900bd6a1eacaecb5bca253]

CVE-2022-0494: block-map: add __GFP_ZERO flag for alloc_page in
function bio_copy_kern

5.10 and 5.4 were fixed this week.

Fixed status

mainline: [cc8f7fe1f5eab010191aa4570f27641876fa1267]
stable/5.10: [a439819f4797f0846c7cffa9475f44aef23c541f]
stable/5.15: [a1ba98731518b811ff90009505c1aebf6e400bc2]
stable/5.16: [f8c61361a4f52c2a186269982587facc852dba62]
stable/5.4: [c7337efd1d11acb6f84c68ffee57d3f312e87b24]

CVE-2022-1048: race condition in snd_pcm_hw_free leading to use-after-free

5.4 was fixed this week

Fixed status

mainline: [92ee3c60ec9fe64404dc035e7c41277d74aa26cb,
dca947d4d26dbf925a64a6cfb2ddbc035e831a3d,
 3c3201f8c7bb77eb53b08a3ca8d9a4ddc500b4c0,
69534c48ba8ce552ce383b3dfdb271ffe51820c3]
stable/5.10: [0f6947f5f5208f6ebd4d76a82a4757e2839a23f8,
8527c8f052fb42091c6569cb928e472376a4a889,
  a38440f006974e693f92a1ea10f819eccc4dcc37,
b560d670c87d7d40b3cf6949246fa4c7aa65a00a]
stable/5.15: [33061d0fba51d2bf70a2ef9645f703c33fe8e438,
47711ff10c7e126702cfa725f6d86ef529d15a5f,
  cb6a39c5ebd0a125c420c5a10999813daaece019,
51fce708ab8986a9879ee5da946a2cc120f1036d]
stable/5.16: [0090c13cbbdffd7da079ac56f80373a9a1be0bf8,
4d1b0ace2d56dc27cc4921eda7fae57f77f03eb5,
  e1ff3a347ed1531eec40a24c47eab15f0efbf835,
a21d2f323b5a978dedf9ff1d50f101f85e39b3f2]
stable/5.17: [1bbf82d9f961414d6c76a08f7f843ea068e0ab7b,
dd2f8c684da3e226e5ec7a81c89ff5fd4a957a03,
  e9d05532252ec41d000021d3cf40f3a2084fd5f9,
5ed8f8e3c4e59d0396b9ccf2e639711e24295bb6]
stable/5.4: [fbeb492694ce0441053de57699e1e2b7bc148a69,
08d1807f097a63ea00a7067dad89c1c81cb2115e,
  2a559eec81acf4836d190d32b1e965d0c587c7ae,
37b12c16beb6f6c1c3c678c1aacbc46525c250f7]

CVE-2022-1195: kernel: A possible race condition (use-after-free) in
drivers/net/hamradio/6pack ( mkiss.c) after unregister_netdev

4.14 was fixed this week.

Fixed status

mainline: [3e0588c291d6ce225f2b891753ca41d45ba42469,
0b9111922b1f399aba6ed1e1b8f2079c3da1aed8,
  81b1d548d00bcd028303c4f3150fa753b9b8aa71,
b2f37aead1b82a770c48b5d583f35ec22aabb61e]
stable/4.14: [eaa816a86e629cbcc0a94f38391fee09231628c7,
feb3d627facbf5df5cc0fc3dd4b64c5b8cb7ceff,
  1a15c23af256aacd9284194bee4c9327ce657ff9,
a7b0ae2cc486fcb601f9f9d87d98138cc7b7f7f9]
stable/4.19: [896193a02a2981e60c40d4614fd095ce92135ccd,
b68f41c6320b2b7fbb54a95f07a69f3dc7e56c59,
  9d2a1b180f0d5fdf0844cb4c740fafd67bebb9d2,
3befa9b67f2205f10c3b01cc687672e3969be569]
stable/4.9: [8a1a314965a17c62084a056b4f2cb7a770854c90,
83ba6ec97c74fb1a60f7779a26b6a94b28741d8a]
stable/5.10: [450121075a6a6f1d50f97225d3396315309d61a1,
7dd52af1eb5798f590d9d9e1c56ed8f5744ee0ca,
  80a4df14643f78b14f1e8e2c7f9ca3da41b01654,
cfa98ffc42f16a432b77e438e2fefcdb942eeb04]
stable/5.15: [cb6c99aedd2c843056a598a8907a6128cb07603b,
c799c18a287e024e1c885da329aad8f719b255c3,
  9873fe0f3857c500fa21f92fe43b2a177e8de208,
03d00f7f1815ec00dab5035851b3de83afd054a8]
stable/5.4: [ef5f7bfa19e3fc366f4c6d1a841ceaddf7a9f5d4,
7361a35bf33064da203e521357acc4fccb8927e5,
  c9af90f0c6b8c461426abfe50f495dc5608399ba,
a5c6a13e9056d87805ba3042c208fbd4164ad22b]

CVE-2022-1419: drm/vgem: Close use-after-free race in vgem_gem_create

4.14 and 4.19 were fixed this week.

Fixed status

mainline: [4b848f20eda5974020f043ca14bacf7a7e634fc8]
stable/4.14: [d2b8e8fbac9f175388d2808ade90d86402642b01]
stable/4.19: [df2c1f38939aabb8c6beca108f08b90f050b9ebc]
stable/5.4: [3ea7f138cec139be98f8bb9fc1a6b432003f834e]

CVE-2021-39713: locking issue in net/sched module

4.9 was fixed this week.

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
stable/4.9: [2b29404f4eea7da878a8a8c5b301d9adf6f56d55]

CVE-2022-1012: secure_seq: use the 64 bits of the siphash for port
offset calculation

The mainline was fixed this week. Fixed in the mainline in 5.18-rc6.
This issue was introduced by commit 7cd23e5 ("secure_seq: use SipHash
in place of MD5") which was merged in 4.11-rc1.

Added fixed commits to 4.19, 5.10, 5.15, and 5.17 this week.

Fixed status

mainline: [b2d057560b8107c633b39aabe517ff9d93f285e3,
9e9b70ae923baf2b5e8a0ea4fd0c8451801ac526,
  4dfa9b438ee34caca4e6a4e5e961641807367f6f,
ca7af0402550f9a0b3316d5f1c30904e42ed257d,
  e9261476184be1abd486c9434164b2acbe0ed6c2,
4c2c8f03a5ab7cb04ec64724d7d176d00bcc91e5,
  e8161345ddbb66e449abde10d2fdce93f867eba9]
stable/4.19: [abcf4e1277d169b82dd7ee290006487ed16016ce]
stable/5.10: [d254309aab27fdcdc68e6bc9c663e51f3e7b37dc]
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

CVE-2022-1048: race condition in snd_pcm_hw_free leading to use-after-free

4.14 and 4.19 were fixed this week.

Fixed status

mainline: [92ee3c60ec9fe64404dc035e7c41277d74aa26cb,
dca947d4d26dbf925a64a6cfb2ddbc035e831a3d,
  3c3201f8c7bb77eb53b08a3ca8d9a4ddc500b4c0,
69534c48ba8ce552ce383b3dfdb271ffe51820c3]
stable/4.14: [a42aa926843acca96c0dfbde2e835b8137f2f092,
73867cb2bc7dfa7fbd219e53a0b68d253d8fda09,
  a1d54f97da10f7eea4817d8aae09cf20c40fa111,
e7786c445bb67a9a6e64f66ebd6b7215b153ff7d]
stable/4.19: [9cb6c40a6ebe4a0cfc9d6a181958211682cffea9,
b3830197aa7413c65767cf5a1aa8775c83f0dbf7,
  47cef5937a43a412405ea54ad6e0a91d2890493e,
e14dca613e0a6ddc2bf6e360f16936a9f865205b]
stable/5.10: [0f6947f5f5208f6ebd4d76a82a4757e2839a23f8,
8527c8f052fb42091c6569cb928e472376a4a889,
  a38440f006974e693f92a1ea10f819eccc4dcc37,
b560d670c87d7d40b3cf6949246fa4c7aa65a00a]
stable/5.15: [33061d0fba51d2bf70a2ef9645f703c33fe8e438,
47711ff10c7e126702cfa725f6d86ef529d15a5f,
  cb6a39c5ebd0a125c420c5a10999813daaece019,
51fce708ab8986a9879ee5da946a2cc120f1036d]
stable/5.16: [0090c13cbbdffd7da079ac56f80373a9a1be0bf8,
4d1b0ace2d56dc27cc4921eda7fae57f77f03eb5,
  e1ff3a347ed1531eec40a24c47eab15f0efbf835,
a21d2f323b5a978dedf9ff1d50f101f85e39b3f2]
stable/5.17: [1bbf82d9f961414d6c76a08f7f843ea068e0ab7b,
dd2f8c684da3e226e5ec7a81c89ff5fd4a957a03,
  e9d05532252ec41d000021d3cf40f3a2084fd5f9,
5ed8f8e3c4e59d0396b9ccf2e639711e24295bb6]
stable/5.4: [fbeb492694ce0441053de57699e1e2b7bc148a69,
08d1807f097a63ea00a7067dad89c1c81cb2115e,
  2a559eec81acf4836d190d32b1e965d0c587c7ae,
37b12c16beb6f6c1c3c678c1aacbc46525c250f7]

CVE-2022-28893: SUNRPC: Ensure we flush any closed sockets before xs_xprt_free()

5.10 and 5.15 were fixed this week. all stable kernels are fixed.

Fixed status

mainline: [f00432063db1a0db484e85193eccc6845435b80e]
stable/5.10: [e68b60ae29de10c7bd7636e227164a8dbe305a82]
stable/5.15: [54f6834b283d9b4d070b0639d9ef5e1d156fe7b0]
stable/5.16: [7a0921a23cae42e9fa5ce964f6907181b6dc80d8]
stable/5.17: [d21287d8a4589dd8513038f887ece980fbc399cf]

CVE-2022-1652: A concurrency use-after-free in bad_flp_intr

An UAF bug in floppy driver. The mainline was fixed this week.

Fixed status

mainline: [f71f01394f742fc4558b3f9f4c7ef4c4cf3b07c8]

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

