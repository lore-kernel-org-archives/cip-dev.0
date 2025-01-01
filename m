Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E139EE7718B
	for <webhook@archiver.kernel.org>; Wed,  1 Jan 2025 22:43:30 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
 by mx.groups.io with SMTP id smtpd.web11.23892.1735771401803539376
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Jan 2025 14:43:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=EwWIWNmN;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.176, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso16263199276.0
        for <cip-dev@lists.cip-project.org>; Wed, 01 Jan 2025 14:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1735771401; x=1736376201; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z8G/cBk/H/gq/UQ3eyubZARxNsmgq3fn/+CUxbUOwzc=;
        b=EwWIWNmNqFEuDFU7ZzsiClKW5lZSmzGn8xGZKMBAWSzE6zzCIPgEmJj1S1xJ3+T/th
         GcbGc9W9in41Z2YYxMiZ0Asr2DDyHROWB/OSqY7JFiusxCpy/yKYEutuJLO+aEjmjbU6
         CfzClHdIlcaFLNVgIbbEJ+Tz1zTpCH+MKJHWMNgsbqFUWrSgdwrsfyG4Rlv9nDj7uRu4
         E6iCsGZbXPlLJmZ9vLDsyK/uI4TX1C7GUQOCiVPkv4aYtHZOGr6W0qWSAgnq04eDP5YX
         7dxKLYGSvkfLmFBedp5idJ7u6Nqh6t/AFNJ0TDXjqgAYfid5XPY7YVLKte/aokHAB2n2
         fyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735771401; x=1736376201;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z8G/cBk/H/gq/UQ3eyubZARxNsmgq3fn/+CUxbUOwzc=;
        b=sfy2FmK0D8En5vjYNbYZur9qRXjtwwBHWX5CyRNODeuRwqLZwFJYY8AdPIkqzEmEj5
         PBD6KIMuddVszCtWl+KJ56HkZZR/CkqyC/kRk/lxP6tuQicZKG5TFi4tjjlwY/39720M
         oaBluuMsoMqifICH4HvYOHbwRNMPZr2xvloKR3/e0tr/hDU7vcU7NrELOFuxNA74BV+Z
         2CgaQlNRK/N5TNL3m0TkH4ck43P1+LTRIbyIINnqLogrcKmf917zbxzJ5yZcND1/tlxZ
         zbIjSauEc/oGDv69bEur/AV02111C8vq/JrvqHijeZSWmDpAgMX9S45T8m3s+QlsuakR
         N0mw==
X-Gm-Message-State: AOJu0YxS/0fSk3ztU+fBL0cEt9q/MfgtfNQDk37BbJGtpdE9nAg0+TKB
	+3UX8NluhWPJT5G2TonlYh+MTfLN6GZ6gdTBFQYYqo88+YdV9pzv3TFQ47zowi8UfAYkmgYeAC1
	7d+LtEfPgBOGktuMG4m3H+eGLh5msd7PZWWe1Va25z9HUQKmT4qU=
X-Gm-Gg: ASbGncuKLxaw5nJOriZqjuL8epfNUi0tY+t8TpS04eb4y4D3ZcEbT7azZo8sMfiNPpH
	hQTkJR24g1bsHyxUFSAJl6sFB/REvC0MPjwgScBVB
X-Google-Smtp-Source: AGHT+IEXHucY8xbofbdC8CAiMbnRkBr6m4ziU/BeUHVNFhQdYniTwYBiscVdPnhfoFZ6UZcInywTkjQegGk6mXxI3fw=
X-Received: by 2002:a05:690c:6990:b0:6ef:910d:7846 with SMTP id
 00721157ae682-6f3f80d60b2mr327368397b3.1.1735771398441; Wed, 01 Jan 2025
 14:43:18 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 2 Jan 2025 07:42:42 +0900
Message-ID: <CAODzB9qRYYX6aLn_h2zk5tt2KRiX=_RK4Brp0EfsJ1bAzprTCg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Jan 2025 22:43:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17500

Hi!

It's this week's CVE report.

This week reported 295 new CVEs and 1 updated CVEs.

* New CVEs

CVE-2022-49034: sh: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK

Announce: https://lore.kernel.org/linux-cve-announce/2024122709-CVE-2022-49034-9cc5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
This bug is sh architecture specific.

Fixed status
cip/4.4: [a118a718a7a97b123c3ea41a526907e9a691ec30]
cip/4.4-st: [a118a718a7a97b123c3ea41a526907e9a691ec30]
mainline: [3c891f7c6a4e90bb1199497552f24b26e46383bc]
stable/4.19: [8fbb57eabfc8ae67115cb47f904614c99d626a89]
stable/5.10: [77755dc95ff2f9a3e473acc1e039f498629949ea]
stable/5.15: [e2b91997db286a5dd3cca6d5d9c20004851f22eb]
stable/5.4: [f8f26cf69003a37ffa947631fc0e6fe6daee624a]
stable/6.1: [2b6b8e011fab680a223b5e07a3c64774156ec6fe]
stable/6.6: [09faf32c682ea4a547200b8b9e04d8b3c8e84b55]

CVE-2024-53164: net: sched: fix ordering of qlen adjustment

Announce: https://lore.kernel.org/linux-cve-announce/2024122746-CVE-2024-53164-752a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc2.


Fixed status
mainline: [5eb7de8cd58e73851cd37ff8d0666517d9926948]
stable/6.1: [489422e2befff88a1de52b2acebe7b333bded025]
stable/6.6: [97e13434b5da8e91bdf965352fad2141d13d72d3]

CVE-2024-53165: sh: intc: Fix use-after-free bug in register_intc_controller()

Announce: https://lore.kernel.org/linux-cve-announce/2024122714-CVE-2024-53165-c311@gregkh/

Introduced by commit 2dcec7a ("sh: intc: set_irq_wake() support") in
v2.6.30-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [99eada71e3351be7839b7e074f17d7188b4033cc]
cip/4.4-st: [99eada71e3351be7839b7e074f17d7188b4033cc]
mainline: [63e72e551942642c48456a4134975136cdcb9b3c]
stable/4.19: [3c7c806b3eafd94ae0f77305a174d63b69ec187c]
stable/5.10: [971b4893457788e0e123ea552f0bb126a5300e61]
stable/5.15: [c3f4f4547fb291982f5ef56c048277c4d5ccc4e4]
stable/5.4: [d8de818df12d86a1a26a8efd7b4b3b9c6dc3c5cc]
stable/6.1: [c43df7dae28fb9fce96ef088250c1e3c3a77c527]
stable/6.6: [b8b84dcdf3ab1d414304819f824b10efba64132c]

CVE-2024-53166: block, bfq: fix bfqq uaf in bfq_limit_depth()

Announce: https://lore.kernel.org/linux-cve-announce/2024122714-CVE-2024-53166-8beb@gregkh/

Introduced by commit 76f1df8 ("bfq: Limit number of requests consumed
by each cgroup") in v5.17-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8b8344de3980709080d86c157d24e7de07d70ad]
stable/6.6: [906cdbdd3b018ff69cc830173bce277a847d4fdc]

CVE-2024-53167: nfs/blocklayout: Don't attempt unregister for invalid
block device

Announce: https://lore.kernel.org/linux-cve-announce/2024122715-CVE-2024-53167-aea5@gregkh/

Introduced by commit d869da9 ("nfs/blocklayout: Fix premature PR key
unregistration") in v6.11-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a4ce14d9a6b868e0787e4582420b721c04ee41e]

CVE-2024-53168: sunrpc: fix one UAF issue caused by sunrpc kernel tcp socket

Announce: https://lore.kernel.org/linux-cve-announce/2024122715-CVE-2024-53168-dc92@gregkh/

Introduced by commit 26abe14 ("net: Modify sk_alloc to not reference
count the netns of kernel sockets.") in v4.2-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f23f96528e8fcf8619895c4c916c52653892ec1]
stable/6.6: [0ca87e5063757132a044d35baba40a7d4bb25394]

CVE-2024-53169: nvme-fabrics: fix kernel crash while shutting down controller

Announce: https://lore.kernel.org/linux-cve-announce/2024122715-CVE-2024-53169-0f8f@gregkh/

Introduced by commit a54a93d ("nvme: move stopping keep-alive into
nvme_uninit_ctrl()") in v6.11-rc5.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9869c85c81168a1275f909d5972a3fc435304be]

CVE-2024-53170: block: fix uaf for flush rq while iterating tags

Announce: https://lore.kernel.org/linux-cve-announce/2024122716-CVE-2024-53170-0908@gregkh/

Introduced by commit 6cfeadb ("blk-mq: don't clear flush_rq from
tags->rqs[]") in v5.19-rc3.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3802f73bd80766d70f319658f334754164075bc3]

CVE-2024-53171: ubifs: authentication: Fix use-after-free in
ubifs_tnc_end_commit

Announce: https://lore.kernel.org/linux-cve-announce/2024122716-CVE-2024-53171-7a80@gregkh/

Introduced by commit 16a26b2 ("ubifs: authentication: Add hashes to
index nodes") in v4.20-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4617fb8fc15effe8eda4dd898d4e33eb537a7140]
stable/5.10: [8d8b3f5f4cbfbf6cb0ea4a4d5dc296872b4151eb]
stable/5.15: [4d9807048b851d7a58d5bd089c16254af896e4df]
stable/5.4: [daac4aa1825de0dbc1a6eede2fa7f9fc53f14223]
stable/6.1: [74981f7577d183acad1cd58f74c10d263711a215]
stable/6.6: [01d3a2293d7e4edfff96618c15727db7e51f11b6]

CVE-2024-53172: ubi: fastmap: Fix duplicate slab cache names while attaching

Announce: https://lore.kernel.org/linux-cve-announce/2024122716-CVE-2024-53172-217d@gregkh/

Introduced by commit d2158f6 ("UBI: Remove alloc_ai() slab name from
parameter list") in v4.1-rc1.
Introduced by commit fdf10ed ("ubi: Rework Fastmap attach base code")
in v4.8-rc1.
Fixed in v6.13-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.4: [1e89c7b61be8019ad8894ddee834a2618670b4a3]
cip/4.4-st: [1e89c7b61be8019ad8894ddee834a2618670b4a3]
mainline: [bcddf52b7a17adcebc768d26f4e27cf79adb424c]
stable/4.19: [ef52b7191ac41e68b1bf070d00c5b04ed16e4920]
stable/5.10: [04c0b0f37617099479c34e207c5550d081f585a6]
stable/5.15: [b1ee0aa4945c49cbbd779da81040fcec4de80fd1]
stable/5.4: [871c148f8e0c32e505df9393ba4a303c3c3fe988]
stable/6.1: [6afdcb285794e75d2c8995e3a44f523c176cc2de]
stable/6.6: [612824dd0c9465ef365ace38b056c663d110956d]

CVE-2024-53173: NFSv4.0: Fix a use-after-free problem in the asynchronous open()

Announce: https://lore.kernel.org/linux-cve-announce/2024122717-CVE-2024-53173-b3c7@gregkh/

Introduced by commit 24ac23a ("NFSv4: Convert open() into an
asynchronous RPC call") in v2.6.20.16.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [edad2588fb7d0bb82855476170abac5597efd6b6]
cip/4.4-st: [edad2588fb7d0bb82855476170abac5597efd6b6]
mainline: [2fdb05dc0931250574f0cb0ebeb5ed8e20f4a889]
stable/4.19: [1cfae9575296f5040cdc84b0730e79078c081d2d]
stable/5.10: [5237a297ffd374a1c4157a53543b7a69d7bbbc03]
stable/5.15: [2ab9639f16b05d948066a6c4cf19a0fdc61046ff]
stable/5.4: [7bf6bf130af8ee7d93a99c28a7512df3017ec759]
stable/6.1: [ba6e6c04f60fe52d91520ac4d749d372d4c74521]
stable/6.6: [229a30ed42bb87bcb044c5523fabd9e4f0e75648]

CVE-2024-53174: SUNRPC: make sure cache entry active before cache_show

Announce: https://lore.kernel.org/linux-cve-announce/2024122717-CVE-2024-53174-d29a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [2862eee078a4d2d1f584e7f24fa50dddfa5f3471]
stable/5.10: [02999e135b013d85c6df738746e8e24699befee4]
stable/5.15: [c7dac3af57e38b2054f990e573256d90bf887958]
stable/5.4: [e9be26735d055c42543a4d047a769cc6d0fb1504]
stable/6.1: [068c0b50f3f700b94f78850834cd91ae3b34c2c1]
stable/6.6: [acfaf37888e0f0732fb6a50ff093dce6d99994d0]

CVE-2024-53175: ipc: fix memleak if msg_init_ns failed in create_ipc_ns

Announce: https://lore.kernel.org/linux-cve-announce/2024122717-CVE-2024-53175-6ebd@gregkh/

Introduced by commit 72d1e61 ("ipc/msg: mitigate the lock contention
with percpu counter") in v6.1-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc8f5921cd69188627c08041276238de222ab466]
stable/6.1: [3d230cfd4b9b0558c7b2039ba1def2ce6b6cd158]
stable/6.6: [10209665b5bf199f8065b2e7d2b2dc6cdf227117]

CVE-2024-53176: smb: During unmount, ensure all cached dir instances
drop their dentry

Announce: https://lore.kernel.org/linux-cve-announce/2024122718-CVE-2024-53176-85e0@gregkh/

Introduced by commit ebe98f1 ("cifs: enable caching of directories for
which a lease is held") in v6.1-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3fa640d035e5ae526769615c35cb9ed4be6e3662]
stable/6.6: [73934e535cffbda1490fa97d82690a0f9aa73e94]

CVE-2024-53177: smb: prevent use-after-free due to open_cached_dir error paths

Announce: https://lore.kernel.org/linux-cve-announce/2024122718-CVE-2024-53177-92af@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [a9685b409a03b73d2980bbfa53eb47555802d0a9]
stable/6.6: [791f833053578b9fd24252ebb7162a61bc3f805b]

CVE-2024-53178: smb: Don't leak cfid when reconnect races with open_cached_dir

Announce: https://lore.kernel.org/linux-cve-announce/2024122718-CVE-2024-53178-07bf@gregkh/

Introduced by commit ebe98f1 ("cifs: enable caching of directories for
which a lease is held") in v6.1-rc1.
Introduced by commit 5c86919 ("smb: client: fix use-after-free in
smb2_query_info_compound()") in v6.7-rc1.
Fixed in v6.13-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [7afb86733685c64c604d32faf00fa4a1f22c2ab1]
stable/6.6: [31fabf70d58388d5475e48ca8a6b7d2847b36678]

CVE-2024-53179: smb: client: fix use-after-free of signing key

Announce: https://lore.kernel.org/linux-cve-announce/2024122719-CVE-2024-53179-2179@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [343d7fe6df9e247671440a932b6a73af4fa86d95]

CVE-2024-53180: ALSA: pcm: Add sanity NULL check for the default mmap
fault handler

Announce: https://lore.kernel.org/linux-cve-announce/2024122719-CVE-2024-53180-78ed@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
It seems as if this bug was introduced by commit d371588 ("ALSA: pcm: Fix
mmap without buffer preallocation") in 5.14-rc3.

Fixed status
mainline: [d2913a07d9037fe7aed4b7e680684163eaed6bc4]
stable/5.15: [8799f4332a9fd812eadfbc32fc5104d6292f754f]
stable/6.1: [832efbb74b1578e3737d593a204d42af8bd1b81b]
stable/6.6: [bc200027ee92fba84f1826494735ed675f3aa911]

CVE-2024-53181: um: vector: Do not use drvdata in release

Announce: https://lore.kernel.org/linux-cve-announce/2024122719-CVE-2024-53181-9b1e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [51b39d741970742a5c41136241a9c48ac607cf82]
stable/4.19: [8ed7793f6f589b4e1f0b38f8448578d2a48f9c82]
stable/5.10: [35f8f72b45791a6a71b81140c59d02a6183b6f3b]
stable/5.15: [bef9a2835011668c221851a7572b6c8433087f85]
stable/5.4: [376c7f0beb8f6f3800fc3013ef2f422d0cbfbf92]
stable/6.1: [dc5251b1af5c9a0749322bf58bd5aa673f545fe2]
stable/6.6: [8204dd589c4f25a7618eece5da3f0871e02af8ae]

CVE-2024-53182: Revert "block, bfq: merge bfq_release_process_ref()
into bfq_put_cooperator()"

Announce: https://lore.kernel.org/linux-cve-announce/2024122720-CVE-2024-53182-8a61@gregkh/

Introduced by commit bc3b1e9 ("block, bfq: merge
bfq_release_process_ref() into bfq_put_cooperator()") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf5a60d971c7b59efb89927919404be655a9e35a]

CVE-2024-53183: um: net: Do not use drvdata in release

Announce: https://lore.kernel.org/linux-cve-announce/2024122720-CVE-2024-53183-9efa@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
cip/4.4: [4f750840c476695724b79373cb1ccc30c039ab70]
cip/4.4-st: [4f750840c476695724b79373cb1ccc30c039ab70]
mainline: [d1db692a9be3b4bd3473b64fcae996afaffe8438]
stable/4.19: [b174ab33aaafd556a1ead72fa8e35d70b6fb1e39]
stable/5.10: [6be99d4c117b9642a44d9f54f034b67615be2b2b]
stable/5.15: [1635d9a0ff1b8bd7aa4767d4ea7b3de72cd36f28]
stable/5.4: [8d9d174d3f55daaf5e7b48e9d7f53c723adbed86]
stable/6.1: [160cd5f956d191eb97664afd31ca59284c08d876]
stable/6.6: [cdbd5a1dcdc2c27ac076f91b03b9add3fefa1a82]

CVE-2024-53184: um: ubd: Do not use drvdata in release

Announce: https://lore.kernel.org/linux-cve-announce/2024122720-CVE-2024-53184-1a1c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
cip/4.4: [f1b8e70623559f2a5d6273aa638a257913dfbbae]
cip/4.4-st: [f1b8e70623559f2a5d6273aa638a257913dfbbae]
mainline: [5bee35e5389f450a7eea7318deb9073e9414d3b1]
stable/4.19: [23d742a3fcd4781eed015a3a93e6a0e3ab1ef2a8]
stable/5.10: [509ba8746f812e45a05034ba18b73db574693d11]
stable/5.15: [5727343348f34e11a7c5a2a944d5aa505731d876]
stable/5.4: [300e277e463e6326938dd55ea560eafa0f5c88a5]
stable/6.1: [a5a75207efae4b558aaa34c288de7d6f2e926b4b]
stable/6.6: [2d194d951895df214e066d08146e77cb6e02c1d4]

CVE-2024-53185: smb: client: fix NULL ptr deref in crypto_aead_setkey()

Announce: https://lore.kernel.org/linux-cve-announce/2024122721-CVE-2024-53185-16d6@gregkh/

Introduced by commit b0abcd6 ("smb: client: fix UAF in async
decryption") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [4bdec0d1f658f7c98749bd2c5a486e6cfa8565d2]
stable/6.6: [46f8e25926817272ec8d5bfbd003569bdeb9a8c8]

CVE-2024-53186: ksmbd: fix use-after-free in SMB request handling

Announce: https://lore.kernel.org/linux-cve-announce/2024122721-CVE-2024-53186-7c05@gregkh/

Introduced by commit ee426bf ("ksmbd: add refcnt to ksmbd_conn
struct") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [9a8c5d89d327ff58e9b2517f8a6afb4181d32c6e]
stable/6.6: [a96f9eb7add30ba0fafcfe7b7aca090978196800]

CVE-2024-53187: io_uring: check for overflows in io_pin_pages

Announce: https://lore.kernel.org/linux-cve-announce/2024122722-CVE-2024-53187-909e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [0c0a4eae26ac78379d0c1db053de168a8febc6c9]

CVE-2024-53188: wifi: ath12k: fix crash when unbinding

Announce: https://lore.kernel.org/linux-cve-announce/2024122722-CVE-2024-53188-be4e@gregkh/

Introduced by commit d889913 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in v6.3-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1304446f67863385dc4c914b6e0194f6664ee764]
stable/6.6: [81da9c0854545c3188ca2a09afe7cb65f9c012b5]

CVE-2024-53189: wifi: nl80211: fix bounds checker error in
nl80211_parse_sched_scan

Announce: https://lore.kernel.org/linux-cve-announce/2024122722-CVE-2024-53189-1b90@gregkh/

Introduced by commit aa4ec06 ("wifi: cfg80211: use __counted_by where
appropriate") in v6.11-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c46a3a5b394d6d123866aa44436fc2cd342eb0d]

CVE-2024-53190: wifi: rtlwifi: Drastically reduce the attempts to read
efuse in case of failures

Announce: https://lore.kernel.org/linux-cve-announce/2024122723-CVE-2024-53190-fdeb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [5c1b544563005a00591a3aa86ecff62ed4d11be3]
stable/6.1: [c386fb76f01794f1023d01a6ec5f5c93d00acd3b]
stable/6.6: [8f3551f67991652c83469c7dd51d7b9b187b265f]

CVE-2024-53191: wifi: ath12k: fix warning when unbinding

Announce: https://lore.kernel.org/linux-cve-announce/2024122723-CVE-2024-53191-df03@gregkh/

Introduced by commit d889913 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in v6.3-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca68ce0d9f4bcd032fd1334441175ae399642a06]
stable/6.6: [223b546c6222d42147eff034433002ca5e2e7e09]

CVE-2024-53192: clk: clk-loongson2: Fix potential buffer overflow in
flexible-array member access

Announce: https://lore.kernel.org/linux-cve-announce/2024122723-CVE-2024-53192-2fd5@gregkh/

Introduced by commit 9796ec0 ("clk: clk-loongson2: Refactor driver for
adding new platforms") in v6.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [02fb4f0084331ef72c28d0c70fcb15d1bea369ec]

CVE-2024-53193: clk: clk-loongson2: Fix memory corruption bug in
struct loongson2_clk_provider

Announce: https://lore.kernel.org/linux-cve-announce/2024122724-CVE-2024-53193-1575@gregkh/

Introduced by commit 9796ec0 ("clk: clk-loongson2: Refactor driver for
adding new platforms") in v6.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e4bf018bb040955da53dae9f8628ef8fcec2dbe]

CVE-2024-53194: PCI: Fix use-after-free of slot->bus on hot remove

Announce: https://lore.kernel.org/linux-cve-announce/2024122724-CVE-2024-53194-9edf@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
cip/4.4: [8ff628bea1981f9c7c051ef3fd2e97285bb43d8a]
cip/4.4-st: [8ff628bea1981f9c7c051ef3fd2e97285bb43d8a]
mainline: [c7acef99642b763ba585f4a43af999fcdbcc3dc4]
stable/4.19: [50473dd3b2a08601a078f852ea05572de9b1f86c]
stable/5.10: [da6e6ff1f6c57f16e07af955e0e997fc90dd1e75]
stable/5.15: [41bbb1eb996be1435815aa1fbcc9ffc45b84cc12]
stable/5.4: [d0ddd2c92b75a19a37c887154223372b600fed37]
stable/6.1: [20502f0b3f3acd6bee300257556c27a867f80c8b]
stable/6.6: [e5d5c04aac71bf1476dc44b56f2206a4c2facca8]

CVE-2024-53195: KVM: arm64: Get rid of userspace_irqchip_in_use

Announce: https://lore.kernel.org/linux-cve-announce/2024122724-CVE-2024-53195-772a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [38d7aacca09230fdb98a34194fec2af597e8e20d]
stable/6.6: [dd2f9861f27571d47998d71e7516bf7216db0b52]

CVE-2024-53196: KVM: arm64: Don't retire aborted MMIO instruction

Announce: https://lore.kernel.org/linux-cve-announce/2024122725-CVE-2024-53196-758a@gregkh/

Introduced by commit da34517 ("KVM: arm/arm64: Allow user injection of
external data aborts") in v5.5-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e735a5da64420a86be370b216c269b5dd8e830e2]
stable/6.1: [6af853cf5f897d55f42e9166f4db50e84e404fb3]
stable/6.6: [ea6b5d98fea4ee8cb443ea98fda520909e90d30e]

CVE-2024-53197: ALSA: usb-audio: Fix potential out-of-bound accesses
for Extigy and Mbox devices

Announce: https://lore.kernel.org/linux-cve-announce/2024122725-CVE-2024-53197-6aef@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [e3de0e90daf12ce229f5744dc686c6f035840ee5]
cip/4.4-st: [e3de0e90daf12ce229f5744dc686c6f035840ee5]
mainline: [b909df18ce2a998afef81d58bbd1a05dc0788c40]
stable/4.19: [0b4ea4bfe16566b84645ded1403756a2dc4e0f19]
stable/5.10: [62dc01c83fa71e10446ee4c31e0e3d5d1291e865]
stable/5.15: [9887d859cd60727432a01564e8f91302d361b72b]
stable/5.4: [9b8460a2a7ce478e0b625af7c56d444dc24190f7]
stable/6.1: [920a369a9f014f10ec282fd298d0666129379f1b]
stable/6.6: [b8f8b81dabe52b413fe9e062e8a852c48dd0680d]

CVE-2024-53198: xen: Fix the issue of resource not being properly
released in xenbus_dev_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024122725-CVE-2024-53198-ce0e@gregkh/

Introduced by commit 4bac07c ("xen: add the Xenbus sysfs and virtual
device hotplug driver") in v2.6.23-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [afc545da381ba0c651b2658966ac737032676f01]
stable/5.10: [0aa9e30b5b4af5dd504801689d6d84c584290a45]
stable/5.15: [e8823e6ff313465910edea07581627d85e68d9fd]
stable/5.4: [87106169b4ce26f85561f953d13d1fd86d99b612]
stable/6.1: [3fc0996d2fefe61219375fd650601724b8cf2d30]
stable/6.6: [804b96f8d0a02fa10b92f28b2e042f9128ed3ffc]

CVE-2024-53199: ASoC: imx-audmix: Add NULL check in imx_audmix_probe

Announce: https://lore.kernel.org/linux-cve-announce/2024122726-CVE-2024-53199-3a00@gregkh/

Introduced by commit 05d996e ("ASoC: imx-audmix: Split capture device
for audmix") in v6.11-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e038f43edaf0083f6aa7c9415d86cf28dfd152f9]

CVE-2024-53200: drm/amd/display: Fix null check for
pipe_ctx->plane_state in hwss_setup_dpp

Announce: https://lore.kernel.org/linux-cve-announce/2024122726-CVE-2024-53200-1320@gregkh/

Introduced by commit 0baae62 ("drm/amd/display: Refactor fast update
to use new HWSS build sequence") in v6.5-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2bc96c95070571c6c824e0d4c7783bee25a37876]
stable/6.6: [020002c76147ecfdafe95c44abd3240e216b6316]

CVE-2024-53201: drm/amd/display: Fix null check for
pipe_ctx->plane_state in dcn20_program_pipe

Announce: https://lore.kernel.org/linux-cve-announce/2024122726-CVE-2024-53201-2534@gregkh/

Introduced by commit 8e4ed3c ("drm/amd/display: Add null check for
pipe_ctx->plane_state in dcn20_program_pipe") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [6a057072ddd127255350357dd880903e8fa23f36]

CVE-2024-53202: firmware_loader: Fix possible resource leak in
fw_log_firmware_info()

Announce: https://lore.kernel.org/linux-cve-announce/2024122727-CVE-2024-53202-f699@gregkh/

Introduced by commit 02fe26f ("firmware_loader: Add debug message with
checksum for FW file") in v6.4-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [369a9c046c2fdfe037f05b43b84c386bdbccc103]
stable/6.6: [789a72498d32f88d24371c10985aceb46397056c]

CVE-2024-53203: usb: typec: fix potential array underflow in
ucsi_ccg_sync_control()

Announce: https://lore.kernel.org/linux-cve-announce/2024122727-CVE-2024-53203-80fc@gregkh/

Introduced by commit 170a672 ("usb: typec: ucsi: add support for
separate DP altmode devices") in v5.6-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e56aac6e5a25630645607b6856d4b2a17b2311a5]

CVE-2024-53204: phy: realtek: usb: fix NULL deref in rtk_usb3phy_probe

Announce: https://lore.kernel.org/linux-cve-announce/2024122727-CVE-2024-53204-0f6e@gregkh/

Introduced by commit adda6e8 ("phy: realtek: usb: Add driver for the
Realtek SoC USB 3.0 PHY") in v6.6-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf373d2919d98f3d1fe1b19a0304f72fe74386d9]

CVE-2024-53205: phy: realtek: usb: fix NULL deref in rtk_usb2phy_probe

Announce: https://lore.kernel.org/linux-cve-announce/2024122728-CVE-2024-53205-1be1@gregkh/

Introduced by commit 134e6d2 ("phy: realtek: usb: Add driver for the
Realtek SoC USB 2.0 PHY") in v6.6-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04e3e9188291a183b27306ddb833722c0d083d6a]

CVE-2024-53206: tcp: Fix use-after-free of nreq in reqsk_timer_handler().

Announce: https://lore.kernel.org/linux-cve-announce/2024122728-CVE-2024-53206-d85d@gregkh/

Introduced by commit e8c526f ("tcp/dccp: Don't use timer_pending() in
reqsk_queue_unlink().") in v6.12-rc4.
Fixed in v6.13-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [c31e72d021db2714df03df6c42855a1db592716c]
stable/5.15: [2dcc86fefe09ac853158afd96b60d544af115dc5]
stable/6.1: [9a3c1ad93e6fba67b3a637cfa95a57a6685e4908]
stable/6.6: [65ed89cad1f57034c256b016e89e8c0a4ec7c65b]

CVE-2024-53207: Bluetooth: MGMT: Fix possible deadlocks

Announce: https://lore.kernel.org/linux-cve-announce/2024122728-CVE-2024-53207-72f7@gregkh/

Introduced by commit f53e1c9 ("Bluetooth: MGMT: Fix possible crash on
mgmt_index_removed") in v6.12-rc2.
Fixed in v6.12.2.

Bug introduced commit was backported to following branches.
cip/6.1 stable/6.1 stable/6.6

Fixed status
mainline: [cac34e44281f1f1bd842adbbcfe3ef9ff0905111]
stable/6.1: [c3f594a3473d6429a0bcf2004cb2885368741b79]
stable/6.6: [c3f594a3473d6429a0bcf2004cb2885368741b79]

CVE-2024-53208: Bluetooth: MGMT: Fix slab-use-after-free Read in
set_powered_sync

Announce: https://lore.kernel.org/linux-cve-announce/2024122729-CVE-2024-53208-dff3@gregkh/

Introduced by commit 275f3f6 ("Bluetooth: Fix not checking MGMT cmd
pending queue") in v5.17-rc7.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b882940665ca2849386ee459d4331aa2f8c4e7d]
stable/6.1: [cdfc818ffdfeb8266351ed59b6d884056009a095]
stable/6.6: [95f7a972194ad20696c36523b54c19a3567e0697]

CVE-2024-53209: bnxt_en: Fix receive ring space parameters when XDP is active

Announce: https://lore.kernel.org/linux-cve-announce/2024122729-CVE-2024-53209-b6b2@gregkh/

Introduced by commit 08450ea ("bnxt_en: Fix max_mtu setting for
multi-buf XDP") in v6.5-rc5.
Fixed in v6.13-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [3051a77a09dfe3022aa012071346937fdf059033]

CVE-2024-53210: s390/iucv: MSG_PEEK causes memory leak in iucv_sock_destruct()

Announce: https://lore.kernel.org/linux-cve-announce/2024122729-CVE-2024-53210-c51c@gregkh/

Introduced by commit eac3731 ("[S390]: Add AF_IUCV socket support") in
v2.6.21-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ebaf81317e42aa990ad20b113cfe3a7b20d4e937]
stable/6.1: [934326aef7ac4652f81c69d18bf44eebaefc39c3]
stable/6.6: [42251c2d1ef1cb0822638bebb87ad9120c759673]

CVE-2024-53211: net/l2tp: fix warning in l2tp_exit_net found by syzbot

Announce: https://lore.kernel.org/linux-cve-announce/2024122730-CVE-2024-53211-9837@gregkh/

Introduced by commit 73d33bd ("l2tp: avoid using drain_workqueue in
l2tp_pre_exit_net") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d066766c5f1252f98ff859265bcd1a5b52ac46c]

CVE-2024-53212: netlink: fix false positive warning in extack during dumps

Announce: https://lore.kernel.org/linux-cve-announce/2024122730-CVE-2024-53212-495a@gregkh/

Introduced by commit 8af4f60 ("netlink: support all extack types in
dumps") in v6.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3bf39fa849ab8ed52abb6715922e6102d3df9f97]

CVE-2024-53213: net: usb: lan78xx: Fix double free issue with
interrupt buffer allocation

Announce: https://lore.kernel.org/linux-cve-announce/2024122730-CVE-2024-53213-baa6@gregkh/

Introduced by commit a6df95c ("lan78xx: Fix memory allocation bug") in
v5.17-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [03819abbeb11117dcbba40bfe322b88c0c88a6b6]
stable/6.1: [977128343fc2a30737399b58df8ea77e94f164bd]
stable/6.6: [a422ebec863d99d5607fb41bb7af3347fcb436d3]

CVE-2024-53214: vfio/pci: Properly hide first-in-list PCIe extended capability

Announce: https://lore.kernel.org/linux-cve-announce/2024122731-CVE-2024-53214-5fbf@gregkh/

Introduced by commit 89e1f7d ("vfio: Add PCI device driver") in v3.6-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [f8fe313711e3451c700f04872f8f4d22f4919360]
cip/4.4-st: [f8fe313711e3451c700f04872f8f4d22f4919360]
mainline: [fe4bf8d0b6716a423b16495d55b35d3fe515905d]
stable/4.19: [4464e5aa3aa4574063640f1082f7d7e323af8eb4]
stable/5.10: [0918f5643fc6c3f7801f4a22397d2cc09ba99207]
stable/5.15: [9567bd34aa3b986736c290c5bcba47e0182ac47a]
stable/5.4: [7d121f66b67921fb3b95e0ea9856bfba53733e91]
stable/6.1: [6c6502d944168cbd7e03a4a08ad6488f78d73485]
stable/6.6: [06f2fcf49854ad05a09d09e0dbee6544fff04695]

CVE-2024-53215: svcrdma: fix miss destroy percpu_counter in svc_rdma_proc_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024122731-CVE-2024-53215-7de4@gregkh/

Introduced by commit 1e7e557 ("svcrdma: Restore read and write stats")
in v5.12-rc1.
Introduced by commit 22df5a2 ("svcrdma: Convert rdma_stat_sq_starve to
a per-CPU counter") in v5.12-rc1.
Introduced by commit df971cd ("svcrdma: Convert rdma_stat_recv to a
per-CPU counter") in v5.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce89e742a4c12b20f09a43fec1b21db33f2166cd]
stable/5.15: [a12c897adf40b6e2b4a56e6912380c31bd7b2479]
stable/6.1: [94d2d6d398706ab7218a26d61e12919c4b498e09]
stable/6.6: [1c9a99c89e45b22eb556fd2f3f729f2683f247d5]

CVE-2024-53216: nfsd: release svc_expkey/svc_export with rcu_work

Announce: https://lore.kernel.org/linux-cve-announce/2024122732-CVE-2024-53216-ba8b@gregkh/

Introduced by commit 9ceddd9 ("knfsd: Allow lockless lookups of the
exports") in v4.20-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8c989a0c89a75d30f899a7cabdc14d72522bb8d]
stable/6.6: [bd8524148dd8c123334b066faa90590ba2ef8e6f]

CVE-2024-53217: NFSD: Prevent NULL dereference in nfsd4_process_cb_update()

Announce: https://lore.kernel.org/linux-cve-announce/2024122732-CVE-2024-53217-4f05@gregkh/

Introduced by commit dcbeaa6 ("nfsd4: allow backchannel recovery") in
v2.6.38-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [d8230092f5a8052bd34c01ece73b794fb1549eba]
cip/4.4-st: [d8230092f5a8052bd34c01ece73b794fb1549eba]
mainline: [1e02c641c3a43c88cecc08402000418e15578d38]
stable/4.19: [d9a0d1f6e15859ea7a86a327f28491e23deaaa62]
stable/5.10: [752a75811f27300fe8131b0a1efc91960f6f88e7]
stable/5.15: [c5d90f9302742985a5078e42ac38de42c364c44a]
stable/5.4: [cac1405e3ff6685a438e910ad719e0cf06af90ee]
stable/6.1: [0c3b0e326f838787d229314d4de83af9c53347e8]
stable/6.6: [eb51733ae5fc73d95bd857d5da26f9f65b202a79]

CVE-2024-53218: f2fs: fix race in concurrent f2fs_stop_gc_thread

Announce: https://lore.kernel.org/linux-cve-announce/2024122732-CVE-2024-53218-4330@gregkh/

Introduced by commit 7950e9a ("f2fs: stop gc/discard thread after fs
shutdown") in v4.16-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b0033dbc48340a1c1c3f12448ba17d6587ca092]
stable/6.6: [794fa8792d4eacac191f1cbcc2e81b7369e4662a]

CVE-2024-53219: virtiofs: use pages instead of pointer for kernel direct IO

Announce: https://lore.kernel.org/linux-cve-announce/2024122733-CVE-2024-53219-1a04@gregkh/

Introduced by commit a62a8ef ("virtio-fs: add virtiofs filesystem") in v5.4-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41748675c0bf252b3c5f600a95830f0936d366c1]

CVE-2024-53220: f2fs: fix to account dirty data in __get_secs_required()

Announce: https://lore.kernel.org/linux-cve-announce/2024122733-CVE-2024-53220-3664@gregkh/

Introduced by commit 4354994 ("f2fs: checkpoint disabling") in v4.20-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1acd73edbbfef2c3c5b43cba4006a7797eca7050]
stable/6.1: [6e58b2987960efcd917bc42da781cee256213618]
stable/6.6: [f1b8bfe8d2f2fdf905d37c174d5bc1cd2b6910c5]

CVE-2024-53221: f2fs: fix null-ptr-deref in f2fs_submit_page_bio()

Announce: https://lore.kernel.org/linux-cve-announce/2024122733-CVE-2024-53221-d8b2@gregkh/

Introduced by commit f543805 ("f2fs: introduce private bioset") in v5.6-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7d0a97b28083084ebdd8e5c6bccd12e6ec18faa]

CVE-2024-53222: zram: fix NULL pointer in comp_algorithm_show()

Announce: https://lore.kernel.org/linux-cve-announce/2024122734-CVE-2024-53222-6c79@gregkh/

Introduced by commit 7ac07a2 ("zram: preparation for multi-zcomp
support") in v6.2-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f364cdeb38938f9d03061682b8ff3779dd1730e5]

CVE-2024-53223: clk: ralink: mtmips: fix clocks probe order in oldest
ralink SoCs

Announce: https://lore.kernel.org/linux-cve-announce/2024122734-CVE-2024-53223-7669@gregkh/

Introduced by commit 6f3b155 ("clk: ralink: add clock and reset driver
for MTMIPS SoCs") in v6.5-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d34db686a3d74bd564bfce2ada15011c556269fc]
stable/6.6: [fbb13732c6ffa9d58cedafabcd5ce8fd7ef8ae5a]

CVE-2024-53224: RDMA/mlx5: Move events notifier registration to be
after device registration

Announce: https://lore.kernel.org/linux-cve-announce/2024122734-CVE-2024-53224-2509@gregkh/

Introduced by commit 7722f47 ("IB/mlx5: Create GSI transmission QPs
when P_Key table is changed") in v4.6-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ede132a5cf559f3ab35a4c28bac4f4a6c20334d8]
stable/6.6: [921fcf2971a1e8d3b904ba2c2905b96f4ec3d4ad]

CVE-2024-53225: iommu/tegra241-cmdqv: Fix alignment failure at max_n_shift

Announce: https://lore.kernel.org/linux-cve-announce/2024122735-CVE-2024-53225-8deb@gregkh/

Introduced by commit 918eb5c ("iommu/arm-smmu-v3: Add in-kernel
support for NVIDIA Tegra241 (Grace) CMDQV") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3799717b881aa0f4e722afb70e7b8ba84ae4f36]

CVE-2024-53226: RDMA/hns: Fix NULL pointer derefernce in hns_roce_map_mr_sg()

Announce: https://lore.kernel.org/linux-cve-announce/2024122735-CVE-2024-53226-5c23@gregkh/

Introduced by commit d387d4b ("RDMA/hns: Fix missing pagesize and
alignment check in FRMR") in v6.11-rc1.
Fixed in v6.13-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [6b526d17eed850352d880b93b9bf20b93006bd92]
stable/5.10: [bd715e191d444992d6ed124f15856da5c1cae2de]
stable/5.15: [35f5b68f63aac61d30ce0b0c6beb09b8845a3e65]
stable/6.1: [52617e76f4963644db71dc0a17e998654dc0c7f4]
stable/6.6: [6b0d7d6e6883d0ec70cd7b5a02c47c003d5defe7]

CVE-2024-53227: scsi: bfa: Fix use-after-free in bfad_im_module_exit()

Announce: https://lore.kernel.org/linux-cve-announce/2024122735-CVE-2024-53227-d872@gregkh/

Introduced by commit 7725ccf ("[SCSI] bfa: Brocade BFA FC SCSI
driver") in v2.6.32-rc4.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [039b4352a94872605b62654a0a5f39e70afa1e7e]
cip/4.4-st: [039b4352a94872605b62654a0a5f39e70afa1e7e]
mainline: [178b8f38932d635e90f5f0e9af1986c6f4a89271]
stable/4.19: [0ceac8012d3ddea3317f0d82934293d05feb8af1]
stable/5.10: [ef2c2580189ea88a0dcaf56eb3a565763a900edb]
stable/5.15: [e76181a5be90abcc3ed8a300bd13878aa214d022]
stable/5.4: [3932c753f805a02e9364a4c58b590f21901f8490]
stable/6.1: [8f5a97443b547b4c83f876f1d6a11df0f1fd4efb]
stable/6.6: [c28409f851abd93b37969cac7498828ad533afd9]

CVE-2024-53228: riscv: kvm: Fix out-of-bounds array access

Announce: https://lore.kernel.org/linux-cve-announce/2024122736-CVE-2024-53228-0c5f@gregkh/

Introduced by commit 56d8a38 ("RISC-V: KVM: Allow some SBI extensions
to be disabled by default") in v6.7-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [332fa4a802b16ccb727199da685294f85f9880cb]

CVE-2024-53229: RDMA/rxe: Fix the qp flush warnings in req

Announce: https://lore.kernel.org/linux-cve-announce/2024122736-CVE-2024-53229-f5cc@gregkh/

Introduced by commit ae720bd ("RDMA/rxe: Generate error completion for
error requester QP state") in v6.0-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea4c990fa9e19ffef0648e40c566b94ba5ab31be]
stable/6.6: [31978d5c5aef034d96fc53b4a9cb3c6e11dbb94d]

CVE-2024-53230: cpufreq: CPPC: Fix possible null-ptr-deref for
cppc_get_cpu_cost()

Announce: https://lore.kernel.org/linux-cve-announce/2024122736-CVE-2024-53230-5851@gregkh/

Introduced by commit 740fcdc ("cpufreq: CPPC: Register EM based on
efficiency class information") in v5.19-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a1374bb8c5926674973d849feed500bc61ad535]
stable/6.1: [1975b481f644f8f841d9c188e3c214fce187f18b]
stable/6.6: [f05ef81db63889f6f14eb77fd140dac6cedb6f7f]

CVE-2024-53231: cpufreq: CPPC: Fix possible null-ptr-deref for
cpufreq_cpu_get_raw()

Announce: https://lore.kernel.org/linux-cve-announce/2024122737-CVE-2024-53231-fe0f@gregkh/

Introduced by commit 740fcdc ("cpufreq: CPPC: Register EM based on
efficiency class information") in v5.19-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a78e7207564258db6e373e86294a85f9d646d35a]
stable/6.1: [a357b63fd21e4b2791008c2175ba7a8c235ebce1]
stable/6.6: [e07570a8f2cfc51260c6266cb8e1bd4777a610d6]

CVE-2024-53232: iommu/s390: Implement blocking domain

Announce: https://lore.kernel.org/linux-cve-announce/2024122737-CVE-2024-53232-6919@gregkh/

Introduced by commit c76c067 ("s390/pci: Use dma-iommu layer") in v6.7-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ecda483339a5151e3ca30d6b82691ef6f1d17912]

CVE-2024-53233: unicode: Fix utf8_load() error path

Announce: https://lore.kernel.org/linux-cve-announce/2024122737-CVE-2024-53233-ab02@gregkh/

Introduced by commit 2b3d047 ("unicode: Add utf8-data module") in v5.17-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [156bb2c569cd869583c593d27a5bd69e7b2a4264]
stable/6.1: [4387cef540f36c2c9297460758cc2438305a24a0]
stable/6.6: [c4b6c1781f6cc4e2283120ac8d873864b8056f21]

CVE-2024-53234: erofs: handle NONHEAD !delta[1] lclusters gracefully

Announce: https://lore.kernel.org/linux-cve-announce/2024122738-CVE-2024-53234-4ee6@gregkh/

Introduced by commit d95ae5e ("erofs: add support for the full
decompressed length") in v5.15-rc1.
Introduced by commit 001b8cc ("erofs: fix compact 4B support for 16k
block size") in v6.5-rc1.
Fixed in v6.13-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [0bc8061ffc733a0a246b8689b2d32a3e9204f43c]
stable/6.6: [f466641debcbea8bdf78d1b63a6270aadf9301bf]

CVE-2024-53235: erofs: fix file-backed mounts over FUSE

Announce: https://lore.kernel.org/linux-cve-announce/2024122738-CVE-2024-53235-80a9@gregkh/

Introduced by commit fb17675 ("erofs: add file-backed mount support")
in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a23787ca8756920d65fda39f41353a4be1d1642]

CVE-2024-53236: xsk: Free skb when TX metadata options are invalid

Announce: https://lore.kernel.org/linux-cve-announce/2024122738-CVE-2024-53236-0ab4@gregkh/

Introduced by commit 48eb03d ("xsk: Add TX timestamp and TX checksum
offload support") in v6.8-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c0d0f42ffa6ac94cd79893b7ed419c15e1b45de]

CVE-2024-53237: Bluetooth: fix use-after-free in device_for_each_child()

Announce: https://lore.kernel.org/linux-cve-announce/2024122739-CVE-2024-53237-2fa6@gregkh/

Introduced by commit a85fb91 ("Bluetooth: Fix double free in
hci_conn_cleanup") in v6.7-rc1.
Fixed in v6.13-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt
stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [27aabf27fd014ae037cc179c61b0bee7cff55b3d]
stable/5.10: [fb91ce37dc9a37ea23cf32b6d7b667004e93d4c5]
stable/5.15: [a9584c897d1cba6265c78010bbb45ca5722c88bc]
stable/6.1: [0f67ca2a80acf8b207240405b7f72d660665d3df]
stable/6.6: [de5a44f351ca7efd9add9851b218f5353e2224b7]

CVE-2024-53238: Bluetooth: btmtk: adjust the position to init iso data anchor

Announce: https://lore.kernel.org/linux-cve-announce/2024122739-CVE-2024-53238-ea1c@gregkh/

Introduced by commit ceac1cb ("Bluetooth: btusb: mediatek: add ISO
data transmission functions") in v6.11-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61c5a3def90ac729a538e5ca5ff7f461cff72776]

CVE-2024-53239: ALSA: 6fire: Release resources at card release

Announce: https://lore.kernel.org/linux-cve-announce/2024122740-CVE-2024-53239-b661@gregkh/

Introduced by commit c6d43ba ("ALSA: usb/6fire - Driver for TerraTec
DMX 6Fire USB") in v2.6.39-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0810c3d6dd2d29a9b92604d682eacd2902ce947]
stable/4.19: [74357d0b5cd3ef544752bc9f21cbeee4902fae6c]
stable/5.10: [f2d06d4e129e2508e356136f99bb20a332ff1a00]
stable/5.15: [b889a7d68d7e76b8795b754a75c91a2d561d5e8c]
stable/5.4: [273eec23467dfbfbd0e4c10302579ba441fb1e13]
stable/6.1: [ea8cc56db659cf0ae57073e32a4735ead7bd7ee3]
stable/6.6: [b754e831a94f82f2593af806741392903f359168]

CVE-2024-56531: ALSA: caiaq: Use snd_card_free_when_closed() at disconnection

Announce: https://lore.kernel.org/linux-cve-announce/2024122721-CVE-2024-56531-6a91@gregkh/

Introduced by commit 523f1dc ("[ALSA] Add Native Instrument usb audio
device support") in v2.6.22-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [e20d33e6dac5c0972e3eb2f6b1a70497d0981176]
cip/4.4-st: [e20d33e6dac5c0972e3eb2f6b1a70497d0981176]
mainline: [b04dcbb7f7b1908806b7dc22671cdbe78ff2b82c]
stable/4.19: [3993edf44d3df7b6e8c753eac6ac8783473fcbab]
stable/5.10: [4dd821dcbfcecf7af6a08370b0b217cde2818acf]
stable/5.15: [cadf1d8e9ddcd74584ec961aeac14ac549b261d8]
stable/5.4: [ebad462eec93b0f701dfe4de98990e7355283801]
stable/6.1: [237f3faf0177bdde728fa3106d730d806436aa4d]
stable/6.6: [4507a8b9b30344c5ddd8219945f446d47e966a6d]

CVE-2024-56532: ALSA: us122l: Use snd_card_free_when_closed() at disconnection

Announce: https://lore.kernel.org/linux-cve-announce/2024122724-CVE-2024-56532-6931@gregkh/

Introduced by commit 030a07e ("ALSA: Add USB US122L driver") in v2.6.28-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [59bcecf8434989a2f32687ac215f6967b37bb433]
cip/4.4-st: [59bcecf8434989a2f32687ac215f6967b37bb433]
mainline: [b7df09bb348016943f56b09dcaafe221e3f73947]
stable/4.19: [020cbc4d7414f0962004213e2b7bc5cc607e9ec7]
stable/5.10: [bf0aa35a7cb8602cccf2387712114e836f65c154]
stable/5.15: [9a48bd2184b142c92a4e17eac074c61fcf975bc9]
stable/5.4: [75f418b249d84021865eaa59515d3ed9b75ce4d6]
stable/6.1: [bc778ad3e495333eebda36fe91d5b2c93109cc16]
stable/6.6: [2938dd2648522336133c151dd67bb9bf01cbd390]

CVE-2024-56533: ALSA: usx2y: Use snd_card_free_when_closed() at disconnection

Announce: https://lore.kernel.org/linux-cve-announce/2024122724-CVE-2024-56533-5de6@gregkh/

Introduced by commit 230cd5e ("[ALSA] prevent oops & dead keyboard on
usb unplugging while the device is be ing used") in v2.6.13-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dafb28f02be407e07a6f679e922a626592b481b0]
stable/5.10: [24fe9f7ca83ec9acf765339054951f5cd9ae5c5d]
stable/5.15: [befcca1777525e37c659b4129d8ac7463b07ef67]
stable/6.1: [7bd8838c0ea886679a32834fdcacab296d072fbe]
stable/6.6: [e07605d855c4104d981653146a330ea48f6266ed]

CVE-2024-56534: isofs: avoid memory leak in iocharset

Announce: https://lore.kernel.org/linux-cve-announce/2024122724-CVE-2024-56534-6e4d@gregkh/

Introduced by commit 1b17a46 ("isofs: convert isofs to use the new
mount API") in v6.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b5bbeee4de616a268db77e2f40f19ab010a367b]

CVE-2024-56535: wifi: rtw89: coex: check NULL return of kmalloc in
btc_fw_set_monreg()

Announce: https://lore.kernel.org/linux-cve-announce/2024122725-CVE-2024-56535-4683@gregkh/

Introduced by commit b952cb0 ("wifi: rtw89: coex: Add register monitor
report v7 format") in v6.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81df5ed446b448bdc327b7c7f0b50121fc1f4aa2]

CVE-2024-56536: wifi: cw1200: Fix potential NULL dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024122725-CVE-2024-56536-a7c4@gregkh/

Introduced by commit 2719a9e ("wifi: cw1200: Convert to GPIO
descriptors") in v6.9-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b94751626a6d49bbe42a19cc1503bd391016bd5]

CVE-2024-56537: drm: xlnx: zynqmp_disp: layer may be null while releasing

Announce: https://lore.kernel.org/linux-cve-announce/2024122725-CVE-2024-56537-59f7@gregkh/

Introduced by commit 1836fd5 ("drm: xlnx: zynqmp_dpsub: Minimize usage
of global flag") in v6.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [223842c7702b52846b1c5aef8aca7474ec1fd29b]

CVE-2024-56538: drm: zynqmp_kms: Unplug DRM device before removal

Announce: https://lore.kernel.org/linux-cve-announce/2024122726-CVE-2024-56538-379d@gregkh/

Introduced by commit d76271d ("drm: xlnx: DRM/KMS driver for Xilinx
ZynqMP DisplayPort Subsystem") in v5.9-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e07c88914fc5289c21820b1aa94f058feb38197]
stable/6.6: [a17b9afe58c474657449cf87e238b1788200576b]

CVE-2024-56539: wifi: mwifiex: Fix memcpy() field-spanning write
warning in mwifiex_config_scan()

Announce: https://lore.kernel.org/linux-cve-announce/2024122726-CVE-2024-56539-4d60@gregkh/

Introduced by commit 5e6e3a9 ("wireless: mwifiex: initial commit for
Marvell mwifiex driver") in v3.0-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [4f015eb9a050496db537117a1c048f1d7d7e84e6]
cip/4.4-st: [4f015eb9a050496db537117a1c048f1d7d7e84e6]
mainline: [d241a139c2e9f8a479f25c75ebd5391e6a448500]
stable/4.19: [a09760c513ae0f98c7082a1deace7fb6284ee866]
stable/5.10: [5fa329c44e1e635da2541eab28b6cdb8464fc8d1]
stable/5.15: [581261b2d6fdb4237b24fa13f5a5f87bf2861f2c]
stable/5.4: [1de0ca1d7320a645ba2ee5954f64be08935b002a]
stable/6.1: [b466746cfb6be43f9a1457bbee52ade397fb23ea]
stable/6.6: [c4698ef8c42e02782604bf4f8a489dbf6b0c1365]

CVE-2024-56540: accel/ivpu: Prevent recovery invocation during probe and resume

Announce: https://lore.kernel.org/linux-cve-announce/2024122726-CVE-2024-56540-d2f7@gregkh/

Introduced by commit 45e4536 ("accel/ivpu: Introduce
ivpu_ipc_send_receive_active()") in v6.8-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5eaa497411197c41b0813d61ba3fbd6267049082]

CVE-2024-56541: wifi: ath12k: fix use-after-free in ath12k_dp_cc_cleanup()

Announce: https://lore.kernel.org/linux-cve-announce/2024122727-CVE-2024-56541-1c83@gregkh/

Introduced by commit 24de1b7 ("wifi: ath12k: fix flush failure in
recovery scenarios") in v6.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bdb281103373fd80eb5c91cede1e115ba270b4e9]

CVE-2024-56542: drm/amd/display: fix a memleak issue when driver is removed

Announce: https://lore.kernel.org/linux-cve-announce/2024122727-CVE-2024-56542-d3dc@gregkh/

Introduced by commit f59549c ("drm/amd/display: free bo used for dmub
bounding box") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4f36e5fd800de7db74c1c4e62baf24a091a5ff6]

CVE-2024-56543: wifi: ath12k: Skip Rx TID cleanup for self peer

Announce: https://lore.kernel.org/linux-cve-announce/2024122727-CVE-2024-56543-a959@gregkh/

Introduced by commit d889913 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in v6.3-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a0c640ce1cdcde3eb131a0c1e70ca1ed7cf27cb]
stable/6.6: [d73da0dd2853887b7aab71f0d572fd3314dafafe]

CVE-2024-56544: udmabuf: change folios array from kmalloc to kvmalloc

Announce: https://lore.kernel.org/linux-cve-announce/2024122728-CVE-2024-56544-42cf@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
It seems as if this bug was introduced by commit 5e72b2b ("udmabuf: convert
udmabuf driver to use folios") in 6.11-rc1.

Fixed status
mainline: [1c0844c6184e658064e14c4335885785ad3bf84b]

CVE-2024-56545: HID: hyperv: streamline driver probe to avoid devres issues

Announce: https://lore.kernel.org/linux-cve-announce/2024122728-CVE-2024-56545-0bfa@gregkh/

Introduced by commit 62c68e7 ("HID: ensure timely release of
driver-allocated resources") in v6.5-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66ef47faa90d838cda131fe1f7776456cc3b59f2]
stable/6.6: [b03e713a400aeb5f969bab4daf47a7402d0df814]

CVE-2024-56546: drivers: soc: xilinx: add the missing kfree in
xlnx_add_cb_for_suspend()

Announce: https://lore.kernel.org/linux-cve-announce/2024122729-CVE-2024-56546-3138@gregkh/

Introduced by commit 05e5ba4 ("driver: soc: xilinx: Add support of
multiple callbacks for same event in event management driver") in
v5.19-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44ed4f90a97ff6f339e50ac01db71544e0990efc]
stable/6.1: [272168927f38bda46f6c1ed5f40de97689e7a5d2]
stable/6.6: [882d7afaa4b82c20a7be7a3a039532a80ebacd23]

CVE-2024-56547: rcu/nocb: Fix missed RCU barrier on deoffloading

Announce: https://lore.kernel.org/linux-cve-announce/2024122729-CVE-2024-56547-c340@gregkh/

Introduced by commit 1fcb932 ("rcu/nocb: Simplify (de-)offloading
state machine") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2996980e20b7a54a1869df15b3445374b850b155]

CVE-2024-56548: hfsplus: don't query the device logical block size
multiple times

Announce: https://lore.kernel.org/linux-cve-announce/2024122729-CVE-2024-56548-8bfd@gregkh/

Introduced by commit 6596528 ("hfsplus: ensure bio requests are not
smaller than the hardware sectors") in v3.1-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [5f6a5da8952eee2b8b6b92d7386482fc9b345968]
cip/4.4-st: [5f6a5da8952eee2b8b6b92d7386482fc9b345968]
mainline: [1c82587cb57687de3f18ab4b98a8850c789bedcf]
stable/4.19: [baccb5e12577b7a9eff54ffba301fdaa0f3ee5a8]
stable/5.10: [e8a2b1c1c2ea85e9a5a2d0c5a5a7e7c639feb866]
stable/5.15: [06cbfbb13ac88f4154c2eb4bc4176f9d10139847]
stable/5.4: [f57725bcc5816425e25218fdf5fb6923bc578cdf]
stable/6.1: [3d7bda75e1a6239db053c73acde17ca146317824]
stable/6.6: [21900e8478126ff6afe3b66679f676e74d1f8830]

CVE-2024-56549: cachefiles: Fix NULL pointer dereference in object->file

Announce: https://lore.kernel.org/linux-cve-announce/2024122730-CVE-2024-56549-ebcd@gregkh/

Introduced by commit c838305 ("cachefiles: notify the user daemon when
looking up cookie") in v5.19-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31ad74b20227ce6b40910ff78b1c604e42975cf1]

CVE-2024-56550: s390/stacktrace: Use break instead of return statement

Announce: https://lore.kernel.org/linux-cve-announce/2024122701-CVE-2024-56550-68f3@gregkh/

Introduced by commit ebd912f ("s390/stacktrace: Merge
perf_callchain_user() and arch_stack_walk_user()") in v6.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [588a9836a4ef7ec3bfcffda526dfa399637e6cfc]

CVE-2024-56551: drm/amdgpu: fix usage slab after free

Announce: https://lore.kernel.org/linux-cve-announce/2024122709-CVE-2024-56551-4ad2@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [b61badd20b443eabe132314669bb51a263982e5c]
stable/6.6: [3990ef742c064e22189b954522930db04fc6b1a7]

CVE-2024-56552: drm/xe/guc_submit: fix race around suspend_pending

Announce: https://lore.kernel.org/linux-cve-announce/2024122710-CVE-2024-56552-aca0@gregkh/

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87651f31ae4e6e6e7e6c7270b9b469405e747407]

CVE-2024-56553: binder: fix memleak of proc->delivered_freeze

Announce: https://lore.kernel.org/linux-cve-announce/2024122710-CVE-2024-56553-e097@gregkh/

Introduced by commit d579b04 ("binder: frozen notification") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1db76ec2b4b206ff943e292a0b55e68ff3443598]

CVE-2024-56554: binder: fix freeze UAF in binder_release_work()

Announce: https://lore.kernel.org/linux-cve-announce/2024122710-CVE-2024-56554-9ee7@gregkh/

Introduced by commit d579b04 ("binder: frozen notification") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e20434cbca814cb91a0a261ca0106815ef48e5f]

CVE-2024-56555: binder: fix OOB in binder_add_freeze_work()

Announce: https://lore.kernel.org/linux-cve-announce/2024122711-CVE-2024-56555-6abc@gregkh/

Introduced by commit d579b04 ("binder: frozen notification") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [011e69a1b23011c0db3af4b8293fdd4522cc97b0]

CVE-2024-56556: binder: fix node UAF in binder_add_freeze_work()

Announce: https://lore.kernel.org/linux-cve-announce/2024122711-CVE-2024-56556-96b8@gregkh/

Introduced by commit d579b04 ("binder: frozen notification") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc8aea47b928cc153b591b3558829ce42f685074]

CVE-2024-56557: iio: adc: ad7923: Fix buffer overflow for tx_buf and ring_xfer

Announce: https://lore.kernel.org/linux-cve-announce/2024122711-CVE-2024-56557-7440@gregkh/

Introduced by commit 851644a ("iio: adc: ad7923: Add support for the
ad7908/ad7918/ad7928") in v5.6-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a4187ec454e19903fd15f6e1825a4b84e59a4cd]
stable/6.1: [00663d3e000c31d0d49ef86a809f5c107c2d09cd]
stable/6.6: [e5cac32721997cb8bcb208a29f4598b3faf46338]

CVE-2024-56558: nfsd: make sure exp active before svc_export_show

Announce: https://lore.kernel.org/linux-cve-announce/2024122712-CVE-2024-56558-9fd9@gregkh/

Introduced by commit bf18f16 ("NFSD: Using exp_get for export
getting") in v3.17-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be8f982c369c965faffa198b46060f8853e0f1f0]
stable/5.10: [7fd29d284b55c2274f7a748e6c5f25b4758b8da5]
stable/5.15: [6cefcadd34e3c71c81ea64b899a0daa86314a51a]
stable/5.4: [e2fa0d0e327279a8defb87b263cd0bf288fd9261]
stable/6.1: [7d8f7816bebcd2e7400bb4d786eccb8f33c9f9ec]
stable/6.6: [1cecfdbc6bfc89c516d286884c7f29267b95de2b]

CVE-2024-56559: mm/vmalloc: combine all TLB flush operations of KASAN
shadow virtual address into one operation

Announce: https://lore.kernel.org/linux-cve-announce/2024122712-CVE-2024-56559-b560@gregkh/

Introduced by commit 282631c ("mm: vmalloc: remove global
purge_vmap_area_root rb-tree") in v6.9-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e9e085effe9b7e342138fde3cf8577d22509932]

CVE-2024-56560: slab: Fix too strict alignment check in create_cache()

Announce: https://lore.kernel.org/linux-cve-announce/2024122712-CVE-2024-56560-e044@gregkh/

Introduced by commit aaa736b ("io_uring: specify freeptr usage for
SLAB_TYPESAFE_BY_RCU io_kiocb cache") in v6.13-rc1.
Introduced by commit d345bd2 ("mm: add kmem_cache_create_rcu()") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9008fe8fad8255edfdbecea32d7eb0485d939d0d]

CVE-2024-56561: PCI: endpoint: Fix PCI domain ID release in pci_epc_destroy()

Announce: https://lore.kernel.org/linux-cve-announce/2024122713-CVE-2024-56561-a041@gregkh/

Introduced by commit 0328947 ("PCI: endpoint: Assign PCI domain number
for endpoint controllers") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4acc902ed3743edd4ac2d3846604a99d17104359]

CVE-2024-56562: i3c: master: Fix miss free init_dyn_addr at
i3c_master_put_i3c_addrs()

Announce: https://lore.kernel.org/linux-cve-announce/2024122713-CVE-2024-56562-9fd5@gregkh/

Introduced by commit 3a379bb ("i3c: Add core I3C infrastructure") in v5.0-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3082990592f7c6d7510a9133afa46e31bbe26533]
stable/5.10: [093ecc6d82ff1d2e0cbf6f2000438b6c698145cb]
stable/5.15: [0cb21f1ea3a2e19ee314a8fcf95461b5c453c59e]
stable/5.4: [c2f0ce241154b04f2fc150ff16ad82d9b8fdfa4a]
stable/6.1: [991e33a99fd3b5d432f0629565f532f563fe019a]
stable/6.6: [ce30d11b39e8d637fed4704a5b43e9d556990475]

CVE-2024-56563: ceph: fix cred leak in ceph_mds_check_access()

Announce: https://lore.kernel.org/linux-cve-announce/2024122714-CVE-2024-56563-148f@gregkh/

Introduced by commit 596afb0 ("ceph: add ceph_mds_check_access()
helper") in v6.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5cf420303256dcd6ff175643e9e9558543c2047]

CVE-2024-56564: ceph: pass cred pointer to ceph_mds_auth_match()

Announce: https://lore.kernel.org/linux-cve-announce/2024122714-CVE-2024-56564-7587@gregkh/

Introduced by commit 596afb0 ("ceph: add ceph_mds_check_access()
helper") in v6.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23426309a4064b25a961e1c72961d8bfc7c8c990]

CVE-2024-56565: f2fs: fix to drop all discards after creating snapshot
on lvm device

Announce: https://lore.kernel.org/linux-cve-announce/2024122714-CVE-2024-56565-1a08@gregkh/

Introduced by commit 35ec7d5 ("f2fs: split discard command in prior to
block layer") in v4.19-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc8aeb04fd80cb8cfae3058445c84410fd0beb5e]
stable/6.6: [ed24ab98242f8d22b66fbe0452c97751b5ea4e22]

CVE-2024-56566: mm/slub: Avoid list corruption when removing a slab
from the full list

Announce: https://lore.kernel.org/linux-cve-announce/2024122715-CVE-2024-56566-0a7e@gregkh/

Introduced by commit 643b113 ("slub: enable tracking of full slabs")
in v2.6.22-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dbc16915279a548a204154368da23d402c141c81]
stable/6.6: [33a213c04faff6c3a7fe77e947db81bc7270fe32]

CVE-2024-56567: ad7780: fix division by zero in ad7780_write_raw()

Announce: https://lore.kernel.org/linux-cve-announce/2024122715-CVE-2024-56567-a306@gregkh/

Introduced by commit 9085daa ("staging: iio: ad7780: add gain & filter
gpio support") in v5.2-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c174b53e95adf2eece2afc56cd9798374919f99a]
stable/5.10: [afc1e3c00b3f5f0b4f1bc3e974fb9803cb938a90]
stable/5.15: [68e79b848196a0b0ec006009cc69da1f835d1ae8]
stable/5.4: [18fb33df1de83a014d7f784089f9b124facc157f]
stable/6.1: [022e13518ba6cc1b4fdd291f49e4f57b2d5718e0]
stable/6.6: [7e3a8ea3d1ada7f707de5d9d504774b4191eab66]

CVE-2024-56568: iommu/arm-smmu: Defer probe of clients after smmu device bound

Announce: https://lore.kernel.org/linux-cve-announce/2024122715-CVE-2024-56568-76a5@gregkh/

Introduced by commit 021bb84 ("iommu/arm-smmu: Wire up generic
configuration support") in v4.9-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [229e6ee43d2a160a1592b83aad620d6027084aad]
stable/5.10: [c2527d07c7e9cda2c6165d5edccf74752baac1b0]
stable/5.15: [dc02407ea952e20c544a078a6be2e6f008327973]
stable/6.1: [f8f794f387ad21c4696e5cd0626cb6f8a5f6aea5]
stable/6.6: [4a9485918a042e3114890dfbe19839a1897f8b2c]

CVE-2024-56569: ftrace: Fix regression with module command in stack_trace_filter

Announce: https://lore.kernel.org/linux-cve-announce/2024122716-CVE-2024-56569-cc71@gregkh/

Introduced by commit 04ec7bb ("tracing: Have the trace_array hold the
list of registered func probes"); in v4.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45af52e7d3b8560f21d139b3759735eead8b1653]
stable/5.10: [5dabb7af57bc72308a6e2e81a5dd756eef283803]
stable/5.15: [885109aa0c70639527dd6a65c82e63c9ac055e3d]
stable/5.4: [43ca32ce12888fb0eeb2d74dfc558dea60d3473e]
stable/6.1: [7ae27880de3482e063fcc1f72d9a298d0d391407]
stable/6.6: [8a92dc4df89c50bdb26667419ea70e0abbce456e]

CVE-2024-56570: ovl: Filter invalid inodes with missing lookup function

Announce: https://lore.kernel.org/linux-cve-announce/2024122716-CVE-2024-56570-7580@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [c8b359dddb418c60df1a69beea01d1b3322bfe83]
stable/5.10: [5f86e79c0b2287ffdabe6c1b305a36c4e0f40fe3]
stable/5.15: [749eac5a6687ec99116e0691d0d71225254654e3]
stable/5.4: [f9248e2f73fb4afe08324485e98c815ac084d166]
stable/6.1: [ff43d008bbf9b27ada434d6455f039a5ef6cee53]
stable/6.6: [065bf5dd21639f80e68450de16bda829784dbb8c]

CVE-2024-56571: media: uvcvideo: Require entities to have a non-zero unique ID

Announce: https://lore.kernel.org/linux-cve-announce/2024122716-CVE-2024-56571-2bbc@gregkh/

Introduced by commit a3fbc2e ("media: mc-entity.c: use WARN_ON,
validate link pads") in v5.7-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3dd075fe8ebbc6fcbf998f81a75b8c4b159a6195]
stable/5.10: [bde4e7c1527151b596089b3f984818ab537eeb7f]
stable/5.15: [72ed66623953106d15825513c82533a03ba29ecd]
stable/6.1: [19464d73225224dca31e2fd6e7d6418facf5facb]
stable/6.6: [b11813bc2f4eee92695075148c9ba996f54feeba]

CVE-2024-56572: media: platform: allegro-dvt: Fix possible memory leak
in allocate_buffers_internal()

Announce: https://lore.kernel.org/linux-cve-announce/2024122717-CVE-2024-56572-b0fd@gregkh/

Introduced by commit f20387d ("media: allegro: add Allegro DVT video
IP core driver") in v5.3-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f514068fbc5d4d189c817adc7c4e32cffdc2e47]
stable/5.10: [74a65313578b35e1239966adfa7ac2bdd60caf00]
stable/5.15: [64f72a738864b506ab50b4a6cb3ce3c3e04b71af]
stable/5.4: [cf642904be39ae0d441dbdfa8f485e0a46260be4]
stable/6.1: [17e5613666209be4e5be1f1894f1a6014a8a0658]
stable/6.6: [6712a28a4f923ffdf51cff267ad05a634ee1babc]

CVE-2024-56573: efi/libstub: Free correct pointer on failure

Announce: https://lore.kernel.org/linux-cve-announce/2024122717-CVE-2024-56573-f5d2@gregkh/

Introduced by commit 42c8ea3 ("efi: libstub: Factor out EFI stub
entrypoint ...") in v6.2-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06d39d79cbd5a91a33707951ebf2512d0e759847]
stable/6.6: [d173aee5709bd0994d216d60589ec67f8b11376a]

CVE-2024-56574: media: ts2020: fix null-ptr-deref in ts2020_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024122717-CVE-2024-56574-68a1@gregkh/

Introduced by commit dc245a5 ("[media] ts2020: implement I2C client
bindings") in v4.1-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a058b34b52ed3feb1f3ff6fd26aefeeeed20cba]
stable/5.10: [5a53f97cd5977911850b695add057f9965c1a2d6]
stable/5.15: [b6208d1567f929105011bcdfd738f59a6bdc1088]
stable/5.4: [ced1c04e82e3ecc246b921b9733f0df0866aa50d]
stable/6.1: [dc03866b5f4aa2668946f8384a1e5286ae53bbaa]
stable/6.6: [a2ed3b780f34e4a6403064208bc2c99d1ed85026]

CVE-2024-56575: media: imx-jpeg: Ensure power suppliers be suspended
before detach them

Announce: https://lore.kernel.org/linux-cve-announce/2024122718-CVE-2024-56575-5f0b@gregkh/

Introduced by commit 2db16c6 ("media: imx-jpeg: Add V4L2 driver for
i.MX8 JPEG Encoder/Decoder") in v5.13-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd0af4cd35da0eb550ef682b71cda70a4e36f6b9]
stable/5.15: [f3c4e088ec01cae45931a18ddf7cae0f4d72e1c5]
stable/6.1: [12914fd765ba4f9d6a9a50439e8dd2e9f91423f2]
stable/6.6: [b7a830bbc25da0f641e3ef2bac3b1766b2777a8b]

CVE-2024-56576: media: i2c: tc358743: Fix crash in the probe error
path when using polling

Announce: https://lore.kernel.org/linux-cve-announce/2024122718-CVE-2024-56576-9756@gregkh/

Introduced by commit 4e66a52 ("[media] tc358743: Add support for
platforms without IRQ line") in v4.13-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [869f38ae07f7df829da4951c3d1f7a2be09c2e9a]
stable/5.10: [5c9ab34c87af718bdbf9faa2b1a6ba41d15380ea]
stable/5.15: [815d14147068347e88c258233eb951b41b2792a6]
stable/5.4: [13193a97ddd5a6a5b11408ddbc1ae85588b1860c]
stable/6.1: [34a3466a92f50c51d984f0ec2e96864886d460eb]
stable/6.6: [b59ab89bc83f7bff67f78c6caf484a84a6dd30f7]

CVE-2024-56577: media: mtk-jpeg: Fix null-ptr-deref during unload module

Announce: https://lore.kernel.org/linux-cve-announce/2024122718-CVE-2024-56577-42c4@gregkh/

Introduced by commit 09aea13 ("media: mtk-jpeg: refactor some
variables") in v6.4-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [17af2b39daf12870cac61ffc360e62bc35798afb]
stable/6.6: [0ba08c21c6a92e6512e73644555120427c9a49d4]

CVE-2024-56578: media: imx-jpeg: Set video drvdata before register video device

Announce: https://lore.kernel.org/linux-cve-announce/2024122719-CVE-2024-56578-48e7@gregkh/

Introduced by commit 2db16c6 ("media: imx-jpeg: Add V4L2 driver for
i.MX8 JPEG Encoder/Decoder") in v5.13-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2b7ecc26bd5406d5ba927be1748aa99c568696c]
stable/5.15: [f68bb1210fbea252552d97242757f69a219e942b]
stable/6.1: [b88556e82dc18cb708744d062770853a2d5095b2]
stable/6.6: [68efeff2f7fccdfedc55f92e92be32997127d16e]

CVE-2024-56579: media: amphion: Set video drvdata before register video device

Announce: https://lore.kernel.org/linux-cve-announce/2024122719-CVE-2024-56579-6134@gregkh/

Introduced by commit 3cd0845 ("media: amphion: add vpu v4l2 m2m
support") in v5.18-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8cbb1a7bd5973b57898b26eb804fe44af440bb63]
stable/6.1: [cfe96c7c3382293179e291f66644d789e39e99f3]
stable/6.6: [988cc10ddbdee0369fe1f193d389da38ad760492]

CVE-2024-56580: media: qcom: camss: fix error path on configuration of
power domains

Announce: https://lore.kernel.org/linux-cve-announce/2024122720-CVE-2024-56580-40b9@gregkh/

Introduced by commit 23aa4f0 ("media: qcom: camss: Move VFE
power-domain specifics into vfe.c") in v6.8-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f45d65b781499d2a79eca12155532739c876aa2]

CVE-2024-56581: btrfs: ref-verify: fix use-after-free after invalid ref action

Announce: https://lore.kernel.org/linux-cve-announce/2024122720-CVE-2024-56581-501d@gregkh/

Introduced by commit fd708b8 ("Btrfs: add a extent ref verify tool")
in v4.15-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c4e39f9d2af4abaf82ca0e315d1fd340456620f]
stable/5.10: [6fd018aa168e472ce35be32296d109db6adb87ea]
stable/5.15: [d2b85ce0561fde894e28fa01bd5d32820d585006]
stable/5.4: [dfb9fe7de61f34cc241ab3900bdde93341096e0e]
stable/6.1: [6370db28af9a8ae3bbdfe97f8a48f8f995e144cf]
stable/6.6: [4275ac2741941c9c7c2293619fdbacb9f70ba85b]

CVE-2024-56582: btrfs: fix use-after-free in btrfs_encoded_read_endio()

Announce: https://lore.kernel.org/linux-cve-announce/2024122720-CVE-2024-56582-17af@gregkh/

Introduced by commit 1881fba ("btrfs: add BTRFS_IOC_ENCODED_READ
ioctl") in v5.18-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05b36b04d74a517d6675bf2f90829ff1ac7e28dc]

CVE-2024-56583: sched/deadline: Fix warning in migrate_enable for boosted tasks

Announce: https://lore.kernel.org/linux-cve-announce/2024122754-CVE-2024-56583-b1dc@gregkh/

Introduced by commit 295d6d5 ("sched/deadline: Fix switching to
-deadline") in v4.15-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0664e2c311b9fa43b33e3e81429cd0c2d7f9c638]
stable/6.6: [b600d30402854415aa57548a6b53dc6478f65517]

CVE-2024-56584: io_uring/tctx: work around xa_store() allocation error issue

Announce: https://lore.kernel.org/linux-cve-announce/2024122757-CVE-2024-56584-dad9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [7eb75ce7527129d7f1fee6951566af409a37a1c4]
stable/6.1: [94ad56f61b873ffeebcc620d451eacfbdf9d40f0]
stable/6.6: [42882b583095dcf747da6e3af1daeff40e27033e]

CVE-2024-56585: LoongArch: Fix sleeping in atomic context for PREEMPT_RT

Announce: https://lore.kernel.org/linux-cve-announce/2024122757-CVE-2024-56585-ad56@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [88fd2b70120d52c1010257d36776876941375490]
stable/6.1: [08715b741f9b2a925d6485491e4907f3b29bac70]
stable/6.6: [c5f89458a2ea0800866b9fc690d3fa8367dc8f8d]

CVE-2024-56586: f2fs: fix f2fs_bug_on when uninstalling filesystem
call f2fs_evict_inode.

Announce: https://lore.kernel.org/linux-cve-announce/2024122757-CVE-2024-56586-bece@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [d5c367ef8287fb4d235c46a2f8c8d68715f3a0ca]
stable/5.10: [dff561e4060d28edc9a2960d4a87f3c945a96aa3]
stable/5.15: [a365de2fbfbe1e6740bfb75ab5c3245cf7bbe4d7]
stable/5.4: [ac8aaf78bd039fa1be0acaa8e84a56499f79d721]
stable/6.1: [ef517d2d21c3d8e2ad35b2bb728bd1c90a31e617]
stable/6.6: [9669b28f81e0ec6305af7773846fbe2cef1e7d61]

CVE-2024-56587: leds: class: Protect brightness_show() with
led_cdev->led_access mutex

Announce: https://lore.kernel.org/linux-cve-announce/2024122758-CVE-2024-56587-1786@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [4ca7cd938725a4050dcd62ae9472e931d603118d]
stable/5.10: [ddcfc5708da9972ac23a9121b3d819b0a53d6f21]
stable/5.15: [b8283d52ed15c02bb2eb9b1b8644dcc34f8e98f1]
stable/5.4: [84b42d5b5fcd767c9b7f30b0b32065ed949fe804]
stable/6.1: [50d9f68e4adf86901cbab1bd5b91f710aa9141b9]
stable/6.6: [f6d6fb563e4be245a17bc4261a4b294e8bf8a31e]

CVE-2024-56588: scsi: hisi_sas: Create all dump files during debugfs
initialization

Announce: https://lore.kernel.org/linux-cve-announce/2024122758-CVE-2024-56588-87ae@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
Affected file was added by commit 92f61e3b ("scsi: hisi_sas: add skeleton
v3 hw driver") in 4.13-rc1.

Fixed status
mainline: [9f564f15f88490b484e02442dc4c4b11640ea172]

CVE-2024-56589: scsi: hisi_sas: Add cond_resched() for no forced
preemption model

Announce: https://lore.kernel.org/linux-cve-announce/2024122758-CVE-2024-56589-5cce@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [2233c4a0b948211743659b24c13d6bd059fa75fc]
stable/5.10: [3dd2c5cb2c698a02a4ed2ea0acb7c9909374a8bf]
stable/5.15: [2174bbc235f79fce88ea71fd08cf836568fcad5f]
stable/6.1: [2991a023896b79e6753813ed88fbc98979713c73]
stable/6.6: [50ddf4b0e1a4cb5e9ca0aac3d0a73202b903c87f]

CVE-2024-56590: Bluetooth: hci_core: Fix not checking skb length on
hci_acldata_packet

Announce: https://lore.kernel.org/linux-cve-announce/2024122759-CVE-2024-56590-d4ba@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [3fe288a8214e7dd784d1f9b7c9e448244d316b47]
stable/5.15: [219960a48771b35a3857a491b955c31d6c33d581]
stable/6.1: [559b1c7ac2e212a23b3833d3baf3bd957771d02e]
stable/6.6: [5e50d12cc6e95e1fde08f5db6992b616f714b0fb]

CVE-2024-56591: Bluetooth: hci_conn: Use disable_delayed_work_sync

Announce: https://lore.kernel.org/linux-cve-announce/2024122759-CVE-2024-56591-eaf9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [2b0f2fc9ed62e73c95df1fa8ed2ba3dac54699df]

CVE-2024-56592: bpf: Call free_htab_elem() after htab_unlock_bucket()

Announce: https://lore.kernel.org/linux-cve-announce/2024122700-CVE-2024-56592-d4b2@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [b9e9ed90b10c82a4e9d4d70a2890f06bfcdd3b78]
stable/6.6: [10e8a2dec9ff1b81de8e892b0850924038adbc6d]

CVE-2024-56593: wifi: brcmfmac: Fix oops due to NULL pointer
dereference in brcmf_sdiod_sglist_rw()

Announce: https://lore.kernel.org/linux-cve-announce/2024122700-CVE-2024-56593-3974@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [857282b819cbaa0675aaab1e7542e2c0579f52d7]
stable/5.10: [7522d7d745d13fbeff3350fe6aa56c8dae263571]
stable/5.15: [dfb3f9d3f602602de208da7bdcc0f6d5ee74af68]
stable/5.4: [342f87d263462c2670b77ea9a32074cab2ac6fa1]
stable/6.1: [67a25ea28f8ec1da8894f2f115d01d3becf67dc7]
stable/6.6: [07c020c6d14d29e5a3ea4e4576b8ecf956a80834]

CVE-2024-56594: drm/amdgpu: set the right AMDGPU sg segment limitation

Announce: https://lore.kernel.org/linux-cve-announce/2024122700-CVE-2024-56594-3c24@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [e2e97435783979124ba92d6870415c57ecfef6a5]
stable/5.10: [13c3a54f48a612a117dfd82a9dd91732261e869d]
stable/5.15: [76581147b05c2adb6b47bbc697521725f10224e4]
stable/5.4: [b5807a08954fdf914ef80b49aaa6cda965ecc95c]
stable/6.1: [ff0346a74627a5f607a33a3852586f8c7f678329]
stable/6.6: [b9e52a96ec92245bf15dabba1d3d862d7a03efb8]

CVE-2024-56595: jfs: add a check to prevent array-index-out-of-bounds
in dbAdjTree

Announce: https://lore.kernel.org/linux-cve-announce/2024122701-CVE-2024-56595-0584@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [a174706ba4dad895c40b1d2277bade16dfacdcd9]
stable/5.10: [368a533152220b0a6f1142327d96c6b6361f3002]
stable/5.15: [a3d408870bc19b794646871bc4c3a5daa66f91c5]
stable/5.4: [b15000bcbecf27e0f7c0f149a409e5b865e28ca2]
stable/6.1: [491487eeddccc4bb49f2e59d8c8f35bec89c15ca]
stable/6.6: [3b5d21b56c3774bc84eab0a93aaac22a4475e2c4]

CVE-2024-56596: jfs: fix array-index-out-of-bounds in jfs_readdir

Announce: https://lore.kernel.org/linux-cve-announce/2024122701-CVE-2024-56596-2add@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [839f102efb168f02dfdd46717b7c6dddb26b015e]
stable/5.10: [97e693593162eef6851d232f0c8148169ed46a5c]
stable/5.15: [9efe72eefd4c4a7ce63b3e4d667d766d2b360cb4]
stable/5.4: [b62f41aeec9d250144c53875b507c1d45ae8c8fc]
stable/6.1: [ff9fc48fab0e1ea0d423c23c99b91bba178f0b05]
stable/6.6: [e7d376f94f72b020f84e77278b150ec1cc27502c]

CVE-2024-56597: jfs: fix shift-out-of-bounds in dbSplit

Announce: https://lore.kernel.org/linux-cve-announce/2024122701-CVE-2024-56597-d77b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [a5f5e4698f8abbb25fe4959814093fb5bfa1aa9d]
stable/5.10: [df7c76636952670b31bd6c12b3aed3c502122273]
stable/5.15: [6676034aa753aa448beb30dbd75630927ba7cd96]
stable/5.4: [bbb24ce7f06ef9b7c05beb9340787cbe9fd3d08e]
stable/6.1: [51a203470f502a64a3da8dcea51c4748e8267a6c]
stable/6.6: [c56245baf3fd1f79145dd7408e3ead034b74255c]

CVE-2024-56598: jfs: array-index-out-of-bounds fix in dtReadFirst

Announce: https://lore.kernel.org/linux-cve-announce/2024122702-CVE-2024-56598-3955@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [ca84a2c9be482836b86d780244f0357e5a778c46]
stable/5.10: [8c97a4d5463a1c972ef576ac499ea9b05f956097]
stable/5.15: [823d573f5450ca6be80b36f54d1902ac7cd23fb9]
stable/5.4: [25f1e673ef61d6bf9a6022e27936785896d74948]
stable/6.1: [2eea5fda5556ef03defebf07b0a12fcd2c5210f4]
stable/6.6: [fd993b2180b4c373af8b99aa28d4dcda5c2a8f10]

CVE-2024-56599: wifi: ath10k: avoid NULL pointer error during sdio remove

Announce: https://lore.kernel.org/linux-cve-announce/2024122702-CVE-2024-56599-54af@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
It seems as if this bug was introduced by commit 3ed39f8 ("ath10k: destroy
sdio workqueue while remove sdio module") in 5.3-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt

Fixed status
mainline: [95c38953cb1ecf40399a676a1f85dfe2b5780a9a]

CVE-2024-56600: net: inet6: do not leave a dangling sk pointer in inet6_create()

Announce: https://lore.kernel.org/linux-cve-announce/2024122702-CVE-2024-56600-7867@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [9df99c395d0f55fb444ef39f4d6f194ca437d884]
stable/5.10: [35360255ca30776dee34d9fa764cffa24d0a5f65]
stable/5.15: [276a473c956fb55a6f3affa9ff232e10fffa7b43]
stable/5.4: [f2709d1271cfdf55c670ab5c5982139ab627ddc7]
stable/6.1: [79e16a0d339532ea832d85798eb036fc4f9e0cea]
stable/6.6: [706b07b7b37f886423846cb38919132090bc40da]

CVE-2024-56601: net: inet: do not leave a dangling sk pointer in inet_create()

Announce: https://lore.kernel.org/linux-cve-announce/2024122703-CVE-2024-56601-2150@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [9365fa510c6f82e3aa550a09d0c5c6b44dbc78ff]
stable/5.10: [2bc34d8c8898ae9fddf4612501aabb22d76c2b2c]
stable/5.15: [3e8258070b0f2aba66b3ef18883de229674fb288]
stable/5.4: [f8a3f255f7509a209292871715cda03779640c8d]
stable/6.1: [b4513cfd3a10c03c660d5d3d26c2e322efbfdd9b]
stable/6.6: [25447c6aaa7235f155292b0c58a067347e8ae891]

CVE-2024-56602: net: ieee802154: do not leave a dangling sk pointer in
ieee802154_create()

Announce: https://lore.kernel.org/linux-cve-announce/2024122703-CVE-2024-56602-d030@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [b4fcd63f6ef79c73cafae8cf4a114def5fc3d80d]
stable/5.10: [14959fd7538b3be6d7617d9e60e404d6a8d4fd1f]
stable/5.15: [2b46994a6e76c8cc5556772932b9b60d03a55cd8]
stable/5.4: [1d5fe782c0ff068d80933f9cfd0fd39d5434bbc9]
stable/6.1: [e8bd6c5f5dc2234b4ea714380aedeea12a781754]
stable/6.6: [b4982fbf13042e3bb33e04eddfea8b1506b5ea65]

CVE-2024-56603: net: af_can: do not leave a dangling sk pointer in can_create()

Announce: https://lore.kernel.org/linux-cve-announce/2024122703-CVE-2024-56603-3db8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [811a7ca7320c062e15d0f5b171fe6ad8592d1434]
stable/5.10: [ce39b5576785bb3e66591145aad03d66bc3e778d]
stable/5.15: [1fe625f12d090d69f3f084990c7e4c1ff94bfe5f]
stable/5.4: [884ae8bcee749be43a071d6ed2d89058dbd2425c]
stable/6.1: [5947c9ac08f0771ea8ed64186b0d52e9029cb6c0]
stable/6.6: [db207d19adbac96058685f6257720906ad41d215]

CVE-2024-56604: Bluetooth: RFCOMM: avoid leaving dangling sk pointer
in rfcomm_sock_alloc()

Announce: https://lore.kernel.org/linux-cve-announce/2024122704-CVE-2024-56604-8494@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [3945c799f12b8d1f49a3b48369ca494d981ac465]
stable/6.1: [ac3eaac4cf142a15fe67be747a682b1416efeb6e]
stable/6.6: [6021ccc2471b7b95e29b7cfc7938e042bf56e281]

CVE-2024-56605: Bluetooth: L2CAP: do not leave dangling sk pointer on
error in l2cap_sock_create()

Announce: https://lore.kernel.org/linux-cve-announce/2024122704-CVE-2024-56605-d424@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [7c4f78cdb8e7501e9f92d291a7d956591bf73be9]
stable/5.10: [daa13175a6dea312a76099066cb4cbd4fc959a84]
stable/5.15: [a8677028dd5123e5e525b8195483994d87123de4]
stable/5.4: [f6ad641646b67f29c7578dcd6c25813c7dcbf51e]
stable/6.1: [bb2f2342a6ddf7c04f9aefbbfe86104cd138e629]
stable/6.6: [8ad09ddc63ace3950ac43db6fbfe25b40f589dd6]

CVE-2024-56606: af_packet: avoid erroring out after sock_init_data()
in packet_create()

Announce: https://lore.kernel.org/linux-cve-announce/2024122704-CVE-2024-56606-bf3b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [46f2a11cb82b657fd15bab1c47821b635e03838b]
stable/5.10: [1dc1e1db927056cb323296e2294a855cd003dfe7]
stable/5.15: [132e615bb1d7cdec2d3cfbdec2efa630e923fd21]
stable/5.4: [71b22837a5e55ac27d6a14b9cdf2326587405c4f]
stable/6.1: [a6cf750b737374454a4e03a5ed449a3eb0c96414]
stable/6.6: [157f08db94123e2ba56877dd0ac88908b13a5dd0]

CVE-2024-56607: wifi: ath12k: fix atomic calls in
ath12k_mac_op_set_bitrate_mask()

Announce: https://lore.kernel.org/linux-cve-announce/2024122705-CVE-2024-56607-031e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
Affected file was added by commit d889913 ("wifi: ath12k: driver for Qualcomm
Wi-Fi 7 devices") in 6.3-rc1.

Fixed status
mainline: [8fac3266c68a8e647240b8ac8d0b82f1821edf85]

CVE-2024-56608: drm/amd/display: Fix out-of-bounds access in
'dcn21_link_encoder_create'

Announce: https://lore.kernel.org/linux-cve-announce/2024122705-CVE-2024-56608-30fb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
It seems as if this bug was introduced by commit 91c665bd ("drm/amd/display:
create dcn21_link_encoder files") in 5.5-rc1.

Fixed status
mainline: [63de35a8fcfca59ae8750d469a7eb220c7557baf]

CVE-2024-56609: wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb

Announce: https://lore.kernel.org/linux-cve-announce/2024122706-CVE-2024-56609-7fe3@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [3e5e4a801aaf4283390cc34959c6c48f910ca5ea]

CVE-2024-56610: kcsan: Turn report_filterlist_lock into a raw_spinlock

Announce: https://lore.kernel.org/linux-cve-announce/2024122706-CVE-2024-56610-905f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.
Affected file was added by commit dfd402a ("kcsan: Add Kernel Concurrency
Sanitizer infrastructure") in 5.8-rc1.

Fixed status
mainline: [59458fa4ddb47e7891c61b4a928d13d5f5b00aa0]
stable/5.10: [f4f2ef66d288ea796ddb8ecbdc2df074ab2d5f4d]
stable/5.15: [ea6588abcc15d68fdeae777ffe3dd74c02eab407]
stable/6.1: [0ab4951c1473c7d1ceaf1232eb927109cd1c4859]
stable/6.6: [dca4e74a918586913d251c0b359e8cc96a3883ea]

CVE-2024-56611: mm/mempolicy: fix migrate_to_node() assuming there is
at least one VMA in a MM

Announce: https://lore.kernel.org/linux-cve-announce/2024122706-CVE-2024-56611-262a@gregkh/

Introduced by commit 3974388 ("[PATCH] Swap Migration V5:
sys_migrate_pages interface") in v2.6.20.16.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [091c1dd2d4df6edd1beebe0e5863d4034ade9572]
stable/6.6: [a13b2b9b0b0b04612c7d81e3b3dfb485c5f7abc3]

CVE-2024-56612: mm/gup: handle NULL pages in unpin_user_pages()

Announce: https://lore.kernel.org/linux-cve-announce/2024122707-CVE-2024-56612-a24e@gregkh/

Introduced by commit 94efde1 ("mm/gup: avoid an unnecessary allocation
call for FOLL_LONGTERM cases") in v6.12.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1268be280d8e484ab3606d7476edd0f14bb9961]

CVE-2024-56613: sched/numa: fix memory leak due to the overwritten
vma->numab_state

Announce: https://lore.kernel.org/linux-cve-announce/2024122707-CVE-2024-56613-0897@gregkh/

Introduced by commit ef6a22b ("sched/numa: apply the scan delay to
every new vma") in v6.4-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f1b64e9a9b7ee9cfd32c6b2fab796e29bfed075]
stable/6.6: [8f149bcc4d91ac92b32ff4949b291e6ed883dc42]

CVE-2024-56614: xsk: fix OOB map writes when deleting elements

Announce: https://lore.kernel.org/linux-cve-announce/2024122707-CVE-2024-56614-17c4@gregkh/

Introduced by commit fbfc504 ("bpf: introduce new bpf AF_XDP map type
BPF_MAP_TYPE_XSKMAP") in v4.18-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32cd3db7de97c0c7a018756ce66244342fd583f0]
stable/5.15: [4d03f705e9d7aabebc6bfa5810f8aab6d176cbb7]
stable/6.1: [ed08c93d5a9801cc8f224a046411fd603c538d07]
stable/6.6: [f8abd03f83d5fe81e76eb93e2c4373eb9f75fd8a]

CVE-2024-56615: bpf: fix OOB devmap writes when deleting elements

Announce: https://lore.kernel.org/linux-cve-announce/2024122708-CVE-2024-56615-5148@gregkh/

Introduced by commit 546ac1f ("bpf: add devmap, a map for storing net
device references") in v4.14-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab244dd7cf4c291f82faacdc50b45cc0f55b674d]
stable/5.10: [70f3de869865f9c3da0508a5ea29f6f4c1889057]
stable/5.15: [ad34306ac6836e5dd096b7d0ad4aa20cb7c8d9e5]
stable/5.4: [0f170e91d3063ca60baec4bd9f544faf3bfe29eb]
stable/6.1: [98c03d05936d846073df8f550e9e8bf0dde1d77f]
stable/6.6: [8e858930695d3ebec423e85384c95427258c294f]

CVE-2024-56616: drm/dp_mst: Fix MST sideband message body length check

Announce: https://lore.kernel.org/linux-cve-announce/2024122708-CVE-2024-56616-ae89@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc2.


Fixed status
mainline: [bd2fccac61b40eaf08d9546acc9fef958bfe4763]
stable/6.1: [780fa184d4dc38ad6c4fded345ab8f9be7a63e96]
stable/6.6: [c58947a8d4a500902597ee1dbadf0518d7ff8801]

CVE-2024-56617: cacheinfo: Allocate memory during CPU hotplug if not
done from the primary CPU

Announce: https://lore.kernel.org/linux-cve-announce/2024122708-CVE-2024-56617-7f21@gregkh/

Introduced by commit 6539cff ("cacheinfo: Add arch specific early
level initializer") in v6.4-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3fce429a1e030b50c1c91351d69b8667eef627b]
stable/6.6: [23b5908b11b77ff8d7b8f7b8f11cbab2e1f4bfc2]

CVE-2024-56618: pmdomain: imx: gpcv2: Adjust delay after power up handshake

Announce: https://lore.kernel.org/linux-cve-announce/2024122709-CVE-2024-56618-44a1@gregkh/

Introduced by commit e8dc41a ("pmdomain: imx: gpcv2: Add delay after
power up handshake") in v6.10-rc2.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2379fb937de5333991c567eefd7d11b98977d059]

CVE-2024-56619: nilfs2: fix potential out-of-bounds memory access in
nilfs_find_entry()

Announce: https://lore.kernel.org/linux-cve-announce/2024122709-CVE-2024-56619-501d@gregkh/

Introduced by commit 2ba466d ("nilfs2: directory entry operations") in
v2.6.30-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [985ebec4ab0a28bb5910c3b1481a40fbf7f9e61d]
stable/5.10: [e3732102a9d638d8627d14fdf7b208462f0520e0]
stable/5.15: [48eb6e7404948032bbe811c5affbe39f6b316951]
stable/5.4: [09d6d05579fd46e61abf6e457bb100ff11f3a9d3]
stable/6.1: [5af8366625182f01f6d8465c9a3210574673af57]
stable/6.6: [c3afea07477baccdbdec4483f8d5e59d42a3f67f]

CVE-2024-56620: scsi: ufs: qcom: Only free platform MSIs when ESI is enabled

Announce: https://lore.kernel.org/linux-cve-announce/2024122709-CVE-2024-56620-d1a8@gregkh/

Introduced by commit 519b627 ("scsi: ufs: qcom: Add MCQ ESI config
vendor specific ops") in v6.3-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64506b3d23a337e98a74b18dcb10c8619365f2bd]

CVE-2024-56621: scsi: ufs: core: Cancel RTC work during ufshcd_remove()

Announce: https://lore.kernel.org/linux-cve-announce/2024122710-CVE-2024-56621-98bf@gregkh/

Introduced by commit 6bf999e ("scsi: ufs: core: Add UFS RTC support")
in v6.8-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1695c4361d35b7bdadd7b34f99c9c07741e181e5]

CVE-2024-56622: scsi: ufs: core: sysfs: Prevent div by zero

Announce: https://lore.kernel.org/linux-cve-announce/2024122710-CVE-2024-56622-cee7@gregkh/

Introduced by commit 1d8613a ("scsi: ufs: core: Introduce HBA
performance monitor sysfs nodes") in v5.14-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb48e9fc0028bed94a40a9352d065909f19e333c]
stable/5.15: [87bf3ea841a5d77beae6bb85af36b2b3848407ee]
stable/6.1: [7b21233e5f72d10f08310689f993c1dbdfde9f2c]
stable/6.6: [0069928727c2e95ca26c738fbe6e4b241aeaaf08]

CVE-2024-56623: scsi: qla2xxx: Fix use after free on unload

Announce: https://lore.kernel.org/linux-cve-announce/2024122710-CVE-2024-56623-e4c7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc2.


Fixed status
mainline: [07c903db0a2ff84b68efa1a74a4de353ea591eb0]
stable/5.10: [12f04fc8580eafb0510f805749553eb6213f323e]
stable/5.15: [ca36d9d53745d5ec8946ef85006d4da605ea7c54]
stable/6.1: [b3e6f25176f248762a24d25ab8cf8c5e90874f80]
stable/6.6: [15369e774f27ec790f207de87c0b541e3f90b22d]

CVE-2024-56624: iommufd: Fix out_fput in iommufd_fault_alloc()

Announce: https://lore.kernel.org/linux-cve-announce/2024122711-CVE-2024-56624-35f7@gregkh/

Introduced by commit 07838f7 ("iommufd: Add iommufd fault object") in v6.11-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af7f4780514f850322b2959032ecaa96e4b26472]

CVE-2024-56625: can: dev: can_set_termination(): allow sleeping GPIOs

Announce: https://lore.kernel.org/linux-cve-announce/2024122711-CVE-2024-56625-82a7@gregkh/

Introduced by commit 6e86a15 ("can: dev: provide optional GPIO based
termination support") in v5.15-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee1dfbdd8b4b6de85e96ae2059dc9c1bdb6b49b5]
stable/5.15: [faa0a1975a6fbce30616775216606eb8d6388ea1]
stable/6.1: [46637a608fb1ee871a0ad8bf70d917d5d95ac251]
stable/6.6: [1ac442f25c19953d2f33b92549628b0aeac83db6]

CVE-2024-56626: ksmbd: fix Out-of-Bounds Write in ksmbd_vfs_stream_write

Announce: https://lore.kernel.org/linux-cve-announce/2024122712-CVE-2024-56626-f2f9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc2.
It seems as if this bug was introduced by commit 7a84399e ("ksmbd: fix wrong
smbd max read/write size check") in 5.19-rc1.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [313dab082289e460391c82d855430ec8a28ddf81]
stable/6.1: [8cd7490fc0f268883e86e840cda5311257af69ca]
stable/6.6: [164d3597d26d9acff5d5b8bc3208bdcca942dd6a]

CVE-2024-56627: ksmbd: fix Out-of-Bounds Read in ksmbd_vfs_stream_read

Announce: https://lore.kernel.org/linux-cve-announce/2024122712-CVE-2024-56627-f398@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc2.
It seems as if this bug was introduced by commit e2f3448 ("cifsd: add
server-side procedures for SMB3") in 5.15-rc1.

Fixed status
mainline: [fc342cf86e2dc4d2edb0fc2ff5e28b6c7845adb9]
stable/6.1: [de4d790dcf53be41736239d7ee63849a16ff5d10]
stable/6.6: [27de4295522e9a33e4a3fc72f7b8193df9eebe41]

CVE-2024-56628: LoongArch: Add architecture specific huge_pte_clear()

Announce: https://lore.kernel.org/linux-cve-announce/2024122712-CVE-2024-56628-c347@gregkh/

Introduced by commit 09cfefb ("LoongArch: Add memory management") in v5.19-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7cd1f5f77925ae905a57296932f0f9ef0dc364f8]
stable/6.1: [dba3c45e333a3a2a01395b5f5e5f88f8baba74e4]
stable/6.6: [7dfbf011a57b9e1a40f5ce8080a53c497e105c6c]

CVE-2024-56629: HID: wacom: fix when get product name maybe null pointer

Announce: https://lore.kernel.org/linux-cve-announce/2024122713-CVE-2024-56629-83fb@gregkh/

Introduced by commit 09dc28a ("HID: wacom: Improve generic name
generation") in v4.14-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59548215b76be98cf3422eea9a67d6ea578aca3d]
stable/5.10: [5912a921289edb34d40aeab32ea6d52d41e75fed]
stable/5.15: [2ed3e3a3ac06af8a6391c3d6a7791b7967d7d43a]
stable/5.4: [d031eef3cc2e3bf524509e38fb898e5335c85c96]
stable/6.1: [2cd323c55bd3f356bf23ae1b4c20100abcdc29d6]
stable/6.6: [a7f0509556fa2f9789639dbcee9eed46e471ccef]

CVE-2024-56630: ocfs2: free inode when ocfs2_get_init_inode() fails

Announce: https://lore.kernel.org/linux-cve-announce/2024122713-CVE-2024-56630-c856@gregkh/

Introduced by commit 9c89fe0 ("ocfs2: Handle error from
dquot_initialize()") in v4.3-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [965b5dd1894f4525f38c1b5f99b0106a07dbb5db]
stable/5.10: [9c19ea59965ebb482e227532f7bbb01792fb028c]
stable/5.15: [c5327720a4655303ffa3f632d86ee205dd783f32]
stable/5.4: [911fcc95b530615b484e8920741fc5e4bc4e684a]
stable/6.1: [67c2c6d0564ca05348ba4f8f6eaf7a0713f56c15]
stable/6.6: [a84d507d3290aca249b44ae992af9e10590cc5f6]

CVE-2024-56631: scsi: sg: Fix slab-use-after-free read in sg_release()

Announce: https://lore.kernel.org/linux-cve-announce/2024122731-CVE-2024-56631-548f@gregkh/

Introduced by commit cc833ac ("sg: O_EXCL and other lock handling") in
v3.17-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f10593ad9bc36921f623361c9e3dd96bd52d85ee]
stable/6.6: [59b30afa578637169e2819536bb66459fdddc39d]

CVE-2024-56632: nvme-tcp: fix the memleak while create new ctrl failed

Announce: https://lore.kernel.org/linux-cve-announce/2024122733-CVE-2024-56632-ea20@gregkh/

Introduced by commit fd1418d ("nvme-tcp: avoid open-coding
nvme_tcp_teardown_admin_queue()") in v6.7-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fec55c29e54d3ca6fe9d7d7d9266098b4514fd34]

CVE-2024-56633: tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg

Announce: https://lore.kernel.org/linux-cve-announce/2024122734-CVE-2024-56633-ac1d@gregkh/

Introduced by commit 604326b ("bpf, sockmap: convert to generic sk_msg
interface") in v4.20-rc1.
Introduced by commit 8ec95b9 ("bpf, sockmap: Fix the
sk->sk_forward_alloc warning of sk_stream_kill_queues") in v6.1-rc5.
Fixed in v6.13-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [ca70b8baf2bd125b2a4d96e76db79375c07d7ff2]
stable/5.10: [dbedc7e142df5ea238a46fdd7462c1c42cd36a10]
stable/5.15: [0d6cd1151e26fc7c2d5daa85e8984aaa685a1a12]
stable/5.4: [905d82e6e77d16ec3e089c92b7b59a14899dfc1a]
stable/6.1: [456f08d24afa51b5eb816c42e4ca1c44a247bd42]
stable/6.6: [206d56f41a1509cadd06e2178c26cb830e45057d]

CVE-2024-56634: gpio: grgpio: Add NULL check in grgpio_probe

Announce: https://lore.kernel.org/linux-cve-announce/2024122734-CVE-2024-56634-f6d5@gregkh/

Introduced by commit 7eb6ce2 ("gpio: Convert to using %pOF instead of
full_name") in v4.14-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [050b23d081da0f29474de043e9538c1f7a351b3b]
stable/5.10: [4733f68e59bb7b9e3d395699abb18366954b9ba7]
stable/5.15: [ad4dfa7ea7f5f7e9a3c78627cfc749bc7005ca7a]
stable/5.4: [53ff0caa6ad57372d426b4f48fc0f66df43a731f]
stable/6.1: [09adf8792b61c09ae543972a1ece1884ef773848]
stable/6.6: [8d2ca6ac3711a4f4015d26b7cc84f325ac608edb]

CVE-2024-56635: net: avoid potential UAF in default_operstate()

Announce: https://lore.kernel.org/linux-cve-announce/2024122734-CVE-2024-56635-3014@gregkh/

Introduced by commit 8c55fac ("net: linkwatch: only report
IF_OPER_LOWERLAYERDOWN if iflink is actually down") in v6.2-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [750e51603395e755537da08f745864c93e3ce741]
stable/6.6: [3265aab0736f78bb218200b06b1abb525c316269]

CVE-2024-56636: geneve: do not assume mac header is set in geneve_xmit_skb()

Announce: https://lore.kernel.org/linux-cve-announce/2024122735-CVE-2024-56636-cdeb@gregkh/

Introduced by commit a025fb5 ("geneve: Allow configuration of DF
behaviour") in v5.0-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8588c99c7d47448fcae39e3227d6e2bb97aad86d]
stable/5.10: [d9fa09ca004befe9cf826d6820439cb6f93cecd7]
stable/5.15: [b65958284401016b983078c68f70b047537f4aba]
stable/6.1: [2ee7bdc7cb40abfe658a71fbd10c7db2f4fc4f9a]
stable/6.6: [97ce3a4ec55eac6b5e2949ffb04028d604afda3b]

CVE-2024-56637: netfilter: ipset: Hold module reference while
requesting a module

Announce: https://lore.kernel.org/linux-cve-announce/2024122735-CVE-2024-56637-23bb@gregkh/

Introduced by commit a7b4f98 ("netfilter: ipset: IP set core support")
in v2.6.39-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [456f010bfaefde84d3390c755eedb1b0a5857c3c]
stable/5.10: [6099b5d3e37145484fac4b8b4070c3f1abfb3519]
stable/5.15: [0e67805e805c1f3edd6f43adbe08ea14b552694b]
stable/5.4: [e5e2d3024753fdaca818b822e3827614bacbdccf]
stable/6.1: [5bae60a933ba5d16eed55c6b279be51bcbbc79b0]
stable/6.6: [90bf312a6b6b3d6012137f6776a4052ee85e0340]

CVE-2024-56638: netfilter: nft_inner: incorrect percpu area handling
under softirq

Announce: https://lore.kernel.org/linux-cve-announce/2024122735-CVE-2024-56638-3a3d@gregkh/

Introduced by commit 3a07327 ("netfilter: nft_inner: support for inner
tunnel header matching") in v6.2-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b1d83da254be3bf054965c8f3b1ad976f460ae5]
stable/6.6: [53c7314208c865086d78b4e88da53bc33da0b603]

CVE-2024-56639: net: hsr: must allocate more bytes for RedBox support

Announce: https://lore.kernel.org/linux-cve-announce/2024122736-CVE-2024-56639-809a@gregkh/

Introduced by commit 5055ccc ("net: hsr: Provide RedBox support
(HSR-SAN)") in v6.10-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af8edaeddbc52e53207d859c912b017fd9a77629]

CVE-2024-56640: net/smc: fix LGR and link use-after-free issue

Announce: https://lore.kernel.org/linux-cve-announce/2024122736-CVE-2024-56640-ef22@gregkh/

Introduced by commit 3b2dec2 ("net/smc: restructure client and server
code in af_smc") in v4.18-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c7f14ed9c19ec0f149479d1c2842ec1f9bf76d7]
stable/5.15: [f502a88fdd415647a1f2dc45fac71b9c522a052b]
stable/6.1: [0cf598548a6c36d90681d53c6b77d52363f2f295]
stable/6.6: [673d606683ac70bc074ca6676b938bff18635226]

CVE-2024-56641: net/smc: initialize close_work early to avoid warning

Announce: https://lore.kernel.org/linux-cve-announce/2024122736-CVE-2024-56641-5492@gregkh/

Introduced by commit 46c28db ("net/smc: no socket state changes in
tasklet context") in v4.12-rc1.
Introduced by commit 4134984 ("net/smc: add SMC-D support in af_smc")
in v4.19-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0541db8ee32c09463a72d0987382b3a3336b0043]
stable/6.6: [f0c37002210aaede10dae849d1a78efc2243add2]

CVE-2024-56642: tipc: Fix use-after-free of kernel socket in cleanup_bearer().

Announce: https://lore.kernel.org/linux-cve-announce/2024122737-CVE-2024-56642-71ee@gregkh/

Introduced by commit 26abe14 ("net: Modify sk_alloc to not reference
count the netns of kernel sockets.") in v4.2-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a2fa13312e51a621f652d522d7e2df7066330b6]
stable/5.10: [650ee9a22d7a2de8999fac2d45983597a0c22359]
stable/5.15: [d2a4894f238551eae178904e7f45af87577074fd]
stable/5.4: [4e69457f9dfae67435f3ccf29008768eae860415]
stable/6.1: [d62d5180c036eeac09f80660edc7a602b369125f]
stable/6.6: [d00d4470bf8c4282617a3a10e76b20a9c7e4cffa]

CVE-2024-56643: dccp: Fix memory leak in dccp_feat_change_recv

Announce: https://lore.kernel.org/linux-cve-announce/2024122737-CVE-2024-56643-8470@gregkh/

Introduced by commit e77b836 ("dccp: Process incoming Change
feature-negotiation options") in v2.6.29-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22be4727a8f898442066bcac34f8a1ad0bc72e14]
stable/5.10: [c99507fff94b926fc92279c92d80f229c91cb85d]
stable/5.15: [bc3d4423def1a9412a0ae454cb4477089ab79276]
stable/5.4: [623be080ab3c13d71570bd32f7202a8efa8e2252]
stable/6.1: [6ff67909ee2ffad911e3122616df41dee23ff4f6]
stable/6.6: [d3ec686a369fae5034303061f003cd3f94ddfd23]

CVE-2024-56644: net/ipv6: release expired exception dst cached in socket

Announce: https://lore.kernel.org/linux-cve-announce/2024122737-CVE-2024-56644-83c2@gregkh/

Introduced by commit 92f1655 ("net: fix __dst_negative_advice() race")
in v6.10-rc2.
Introduced by commit 54c1a85 ("ipv6: Don't drop cache route entry
unless timer actually expired.") in v2.6.34-rc3.
Fixed in v6.13-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt
stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [3301ab7d5aeb0fe270f73a3d4810c9d1b6a9f045]
stable/5.10: [b90d061345bb8cd51fece561a800bae1c95448a6]
stable/5.15: [0b8903e6c881f72c6849d4952de742c656eb5ab9]
stable/5.4: [a95808252e8acc0123bacd2dff8b9af10bc145b7]
stable/6.1: [535add1e9f274502209cb997801208bbe1ae6c6f]
stable/6.6: [f43d12fd0fa8ee5b9caf8a3927e10d06431764d2]

CVE-2024-56645: can: j1939: j1939_session_new(): fix skb reference counting

Announce: https://lore.kernel.org/linux-cve-announce/2024122738-CVE-2024-56645-bc11@gregkh/

Introduced by commit 9d71dd0 ("can: add support of SAE J1939
protocol") in v5.4-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a8c695005bfe6569acd73d777ca298ddddd66105]
stable/5.10: [b3282c2bebeeb82ceec492ee4972f51ee7a4a132]
stable/5.15: [4199dd78a59896e091d3a7a05a77451aa7fd724d]
stable/5.4: [224e606a8d8e8c7db94036272c47a37455667313]
stable/6.1: [f117cba69cbbd496babb3defcdf440df4fd6fe14]
stable/6.6: [426d94815e12b6bdb9a75af294fbbafb9301601d]

CVE-2024-56646: ipv6: avoid possible NULL deref in modify_prefix_route()

Announce: https://lore.kernel.org/linux-cve-announce/2024122738-CVE-2024-56646-e78e@gregkh/

Introduced by commit 5eb902b ("net/ipv6: Remove expired routes with a
separated list of routes.") in v6.9-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a747e02430dfb3657141f99aa6b09331283fa493]

CVE-2024-56647: net: Fix icmp host relookup triggering ip_rt_bug

Announce: https://lore.kernel.org/linux-cve-announce/2024122738-CVE-2024-56647-d71f@gregkh/

Introduced by commit 8b7817f ("[IPSEC]: Add ICMP host relookup
support") in v2.6.25-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c44daa7e3c73229f7ac74985acb8c7fb909c4e0a]

CVE-2024-56648: net: hsr: avoid potential out-of-bound access in
fill_frame_info()

Announce: https://lore.kernel.org/linux-cve-announce/2024122739-CVE-2024-56648-5623@gregkh/

Introduced by commit 48b491a ("net: hsr: fix mac_len checks") in v5.13-rc4.
Fixed in v6.13-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [b9653d19e556c6afd035602927a93d100a0d7644]
stable/5.10: [aa632691c722a123e47ccd05a3afdd5f87a36061]
stable/5.15: [c6e778901d0055356c4fb223058364cae731494a]
stable/6.1: [6bb5c8ebc99f0671dbd3c9408ebaf935c3951186]
stable/6.6: [3c215663b3e27a3b08cefcaea623ff54c70c8035]

CVE-2024-56649: net: enetc: Do not configure preemptible TCs if SIs do
not support

Announce: https://lore.kernel.org/linux-cve-announce/2024122739-CVE-2024-56649-33a6@gregkh/

Introduced by commit 8271453 ("net: enetc: only commit preemptible TCs
to hardware when MM TX is active") in v6.4-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2420b8c81ec674552d00c55d46245e5c184b260]
stable/6.6: [66127f0d1ecf00604aeab71132bde398fd9ec7c9]

CVE-2024-56650: netfilter: x_tables: fix LED ID check in led_tg_check()

Announce: https://lore.kernel.org/linux-cve-announce/2024122740-CVE-2024-56650-4d51@gregkh/

Introduced by commit 268cb38 ("netfilter: x_tables: add LED trigger
target") in v2.6.30-rc1.
Fixed in v6.13-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04317f4eb2aad312ad85c1a17ad81fe75f1f9bc7]
stable/5.10: [ad28612ebae1fcc1104bd432e99e99d87f6bfe09]
stable/5.15: [36a9d94dac28beef6b8abba46ba8874320d3e800]
stable/5.4: [147a42bb02de8735cb08476be6d0917987d022c2]
stable/6.1: [ab9916321c95f5280b72b4c5055e269f98627efe]
stable/6.6: [a9bcc0b70d9baf3ff005874489a0dc9d023b54c3]

CVE-2024-56651: can: hi311x: hi3110_can_ist(): fix potential use-after-free

Announce: https://lore.kernel.org/linux-cve-announce/2024122740-CVE-2024-56651-2d22@gregkh/

Introduced by commit a22bd63 ("can: hi311x: do not report txerr and
rxerr during bus-off") in v6.0-rc1.
Fixed in v6.13-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [9ad86d377ef4a19c75a9c639964879a5b25a433b]
stable/6.1: [4ad77eb8f2e07bcfa0e28887d3c7dbb732d92cc1]
stable/6.6: [1128022009444faf49359bd406cd665b177cb643]

CVE-2024-56652: drm/xe/reg_sr: Remove register pool

Announce: https://lore.kernel.org/linux-cve-announce/2024122748-CVE-2024-56652-31db@gregkh/

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7b028656c29b22fcde1c6ee1df5b28fbba987b5]

CVE-2024-56653: Bluetooth: btmtk: avoid UAF in btmtk_process_coredump

Announce: https://lore.kernel.org/linux-cve-announce/2024122749-CVE-2024-56653-bb35@gregkh/

Introduced by commit 0b70151 ("Bluetooth: btusb: mediatek: add
MediaTek devcoredump support") in v6.6-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b548f5e9456c568155499d9ebac675c0d7a296e8]
stable/6.6: [ecdcaea0e4057171ea4c3783e1cc1c900ad99125]

CVE-2024-56654: Bluetooth: hci_event: Fix using rcu_read_(un)lock
while iterating

Announce: https://lore.kernel.org/linux-cve-announce/2024122749-CVE-2024-56654-66a1@gregkh/

Introduced by commit a0bfde1 ("Bluetooth: ISO: Add support for
connecting multiple BISes") in v6.6-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [581dd2dc168fe0ed2a7a5534a724f0d3751c93ae]
stable/6.6: [0108132d7d76d884e443d18b4f067cdf2811911b]

CVE-2024-56655: netfilter: nf_tables: do not defer rule destruction via call_rcu

Announce: https://lore.kernel.org/linux-cve-announce/2024122749-CVE-2024-56655-e94f@gregkh/

Introduced by commit c03d278 ("netfilter: nf_tables: wait for rcu
grace period on net_device removal") in v6.12-rc7.
Fixed in v6.13-rc3.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [b04df3da1b5c6f6dc7cdccc37941740c078c4043]
stable/6.6: [27f0574253f6c24c8ee4e3f0a685b75ed3a256ed]

CVE-2024-56656: bnxt_en: Fix aggregation ID mask to prevent oops on 5760X chips

Announce: https://lore.kernel.org/linux-cve-announce/2024122750-CVE-2024-56656-84a9@gregkh/

Introduced by commit 13d2d3d ("bnxt_en: Add new P7 hardware interface
definitions") in v6.8-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24c6843b7393ebc80962b59d7ae71af91bf0dcc1]

CVE-2024-56657: ALSA: control: Avoid WARN() for symlink errors

Announce: https://lore.kernel.org/linux-cve-announce/2024122750-CVE-2024-56657-4f33@gregkh/

Introduced by commit a135dfb ("ALSA: led control - add sysfs kcontrol
LED marking layer") in v5.13-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2e538a9827dd04ab5273bf4be8eb2edb84357b0]
stable/6.6: [d5a1ca7b59804d6779644001a878ed925a4688ca]

CVE-2024-56658: net: defer final 'struct net' free in netns dismantle

Announce: https://lore.kernel.org/linux-cve-announce/2024122750-CVE-2024-56658-01fc@gregkh/

Introduced by commit a8a572a ("xfrm: dst_entries_init() per-net
dst_ops") in v4.4-rc8.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f6ede9fbc747e2553612271bce108f7517e7a45]
stable/6.1: [3267b254dc0a04dfa362a2be24573cfa6d2d78f5]
stable/6.6: [b7a79e51297f7b82adb687086f5cb2da446f1e40]

CVE-2024-56659: net: lapb: increase LAPB_HEADER_LEN

Announce: https://lore.kernel.org/linux-cve-announce/2024122751-CVE-2024-56659-6675@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6d75ecee2bf828ac6a1b52724aba0a977e4eaf4]
stable/5.10: [76d856f03d0290cf5392364ecdf74c15ee16b8fd]
stable/5.15: [c21c7c1c00bcc60cf752ec491bdfd47693f4d3c7]
stable/5.4: [3aa2ef7ffd0451e8f81c249d2a2a68283c6bc700]
stable/6.1: [f0949199651bc87c5ed2c12a7323f441f1af6fe9]
stable/6.6: [03e661b5e7aa1124f24054df9ab2ee5cb2178973]

CVE-2024-56660: net/mlx5: DR, prevent potential error pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024122751-CVE-2024-56660-fb9d@gregkh/

Introduced by commit 11a45de ("net/mlx5: DR, Add support for SF
vports") in v5.16-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11776cff0b563c8b8a4fa76cab620bfb633a8cb8]
stable/6.1: [61f720e801443d4e2a3c0261eda4ad8431458dca]
stable/6.6: [325cf73a1b449fea3158ab99d03a7a717aad1618]

CVE-2024-56661: tipc: fix NULL deref in cleanup_bearer()

Announce: https://lore.kernel.org/linux-cve-announce/2024122751-CVE-2024-56661-a403@gregkh/

Introduced by commit 6a2fa13 ("tipc: Fix use-after-free of kernel
socket in cleanup_bearer().") in v6.13-rc2.
Fixed in v6.13-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [b04d86fff66b15c07505d226431f808c15b1703c]
stable/5.10: [a771f349c95d3397636861a0a6462d4a7a7ecb25]
stable/5.15: [07b569eda6fe6a1e83be5a587abee12d1303f95e]
stable/5.4: [d1d4dfb189a115734bff81c411bc58d9e348db7d]
stable/6.1: [754ec823ee53422361da7958a8c8bf3275426912]
stable/6.6: [89ecda492d0a37fd00aaffc4151f1f44c26d93ac]

CVE-2024-56662: acpi: nfit: vmalloc-out-of-bounds Read in acpi_nfit_ctl

Announce: https://lore.kernel.org/linux-cve-announce/2024122752-CVE-2024-56662-b7e7@gregkh/

Introduced by commit ebe9f6f ("acpi/nfit: Fix bus command validation")
in v5.1-rc1.
Fixed in v6.13-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt

Fixed status
mainline: [265e98f72bac6c41a4492d3e30a8e5fd22fe0779]
stable/5.10: [616aa5f3c86e0479bcbb81e41c08c43ff32af637]
stable/5.15: [bbdb3307f609ec4dc9558770f464ede01fe52aed]
stable/6.1: [143f723e9eb4f0302ffb7adfdc7ef77eab3f68e0]
stable/6.6: [e08dc2dc3c3f7938df0e4476fe3e6fdec5583c1d]

CVE-2024-56663: wifi: nl80211: fix NL80211_ATTR_MLO_LINK_ID off-by-one

Announce: https://lore.kernel.org/linux-cve-announce/2024122752-CVE-2024-56663-66d7@gregkh/

Introduced by commit 7b0a0e3 ("wifi: cfg80211: do some rework towards
MLO link APIs") in v6.0-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e3dbf938656986cce73ac4083500d0bcfbffe24]
stable/6.1: [29e640ae641b9f5ffc666049426d2b16c98d9963]
stable/6.6: [f3412522f78826fef1dfae40ef378a863df2591c]

CVE-2024-56664: bpf, sockmap: Fix race between element replace and close()

Announce: https://lore.kernel.org/linux-cve-announce/2024122752-CVE-2024-56664-9dc6@gregkh/

Introduced by commit 604326b ("bpf, sockmap: convert to generic sk_msg
interface") in v4.20-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed1fc5d76b81a4d681211333c026202cad4d5649]
stable/6.6: [b015f19fedd2e12283a8450dd0aefce49ec57015]

CVE-2024-56665: bpf,perf: Fix invalid prog_array access in
perf_event_detach_bpf_prog

Announce: https://lore.kernel.org/linux-cve-announce/2024122753-CVE-2024-56665-5df3@gregkh/

Introduced by commit 0ee288e ("bpf,perf: Fix
perf_event_detach_bpf_prog error handling") in v6.12-rc5.
Fixed in v6.13-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [978c4486cca5c7b9253d3ab98a88c8e769cb9bbd]
stable/6.1: [842e5af282453983586e2eae3c8eaf252de5f22f]
stable/6.6: [c2b6b47662d5f2dfce92e5ffbdcac8229f321d9d]

CVE-2024-56666: drm/amdkfd: Dereference null return value

Announce: https://lore.kernel.org/linux-cve-announce/2024122753-CVE-2024-56666-93aa@gregkh/

Introduced by commit fb91065 ("drm/amdkfd: Refactor queue wptr_bo GART
mapping") in v6.12-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a592bb19abdc2072875c87da606461bfd7821b08]

CVE-2024-56667: drm/i915: Fix NULL pointer dereference in capture_engine

Announce: https://lore.kernel.org/linux-cve-announce/2024122753-CVE-2024-56667-3c3f@gregkh/

Introduced by commit e8a3319 ("drm/i915: Allow error capture without a
request") in v6.3-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da0b986256ae9a78b0215214ff44f271bfe237c1]
stable/6.6: [e07f9c92bd127f8835ac669d83b5e7ff59bbb40f]

CVE-2024-56668: iommu/vt-d: Fix qi_batch NULL pointer with nested parent domain

Announce: https://lore.kernel.org/linux-cve-announce/2024122754-CVE-2024-56668-0d8d@gregkh/

Introduced by commit 705c1cd ("iommu/vt-d: Introduce batched cache
invalidation") in v6.12-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74536f91962d5f6af0a42414773ce61e653c10ee]

CVE-2024-56669: iommu/vt-d: Remove cache tags before disabling ATS

Announce: https://lore.kernel.org/linux-cve-announce/2024122754-CVE-2024-56669-2ea9@gregkh/

Introduced by commit 3b1d9e2 ("iommu/vt-d: Add cache tag assignment
interface") in v6.10-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f2557e08a617a4b5e92a48a1a9a6f86621def18]

CVE-2024-56670: usb: gadget: u_serial: Fix the issue that gs_start_io
crashed due to accessing null pointer

Announce: https://lore.kernel.org/linux-cve-announce/2024122755-CVE-2024-56670-929d@gregkh/

Introduced by commit c1dca56 ("usb gadget: split out serial core") in
v2.6.27-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cfbca86f6a8b801f3254e0e3c8f2b1d2d64be2b]
stable/5.10: [28b3c03a6790de1f6f2683919ad657840f0f0f58]
stable/5.15: [1247e1df086aa6c17ab53cd1bedce70dd7132765]
stable/5.4: [4efdfdc32d8d6307f968cd99f1db64468471bab1]
stable/6.1: [c83213b6649d22656b3a4e92544ceeea8a2c6c07]
stable/6.6: [8ca07a3d18f39b1669927ef536e485787e856df6]

CVE-2024-56671: gpio: graniterapids: Fix vGPIO driver crash

Announce: https://lore.kernel.org/linux-cve-announce/2024122755-CVE-2024-56671-89d8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc3.
It seems as if this bug was introduced by commit ecc4b1418e ("gpio: Add Intel
Granite Rapids-D vGPIO driver") in 6.10-rc1.

Fixed status
mainline: [eb9640fd1ce666610b77f5997596e9570a36378f]

CVE-2024-56672: blk-cgroup: Fix UAF in blkcg_unpin_online()

Announce: https://lore.kernel.org/linux-cve-announce/2024122755-CVE-2024-56672-8d29@gregkh/

Introduced by commit 4308a43 ("blkcg: don't offline parent blkcg
first") in v5.7-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86e6ca55b83c575ab0f2e105cf08f98e58d3d7af]
stable/6.1: [64afc6fe24c9896c0153e5a199bcea241ecb0d5c]
stable/6.6: [5baa28569c924d9a90d036c2aaab79f791fedaf8]

CVE-2024-56673: riscv: mm: Do not call pmd dtor on vmemmap page table teardown

Announce: https://lore.kernel.org/linux-cve-announce/2024122756-CVE-2024-56673-1ce5@gregkh/

Introduced by commit c75a74f ("riscv: mm: Add memory hotplugging
support") in v6.11-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21f1b85c8912262adf51707e63614a114425eb10]

CVE-2024-56674: virtio_net: correct netdev_tx_reset_queue() invocation point

Announce: https://lore.kernel.org/linux-cve-announce/2024122756-CVE-2024-56674-8005@gregkh/

Introduced by commit c8bd1f7 ("virtio_net: add support for Byte Queue
Limits") in v6.11-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ddccbefebdbe0c4c72a248676e4d39ac66a8e26]

CVE-2024-56675: bpf: Fix UAF via mismatching bpf_prog/attachment RCU flavors

Announce: https://lore.kernel.org/linux-cve-announce/2024122756-CVE-2024-56675-e996@gregkh/

Introduced by commit 8c7dcb8 ("bpf: implement sleepable uprobes by
chaining gps") in v6.0-rc1.
Fixed in v6.13-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef1b808e3b7c98612feceedf985c2fbbeb28f956]
stable/6.1: [9245459a992d22fe0e92e988f49db1fec82c184a]
stable/6.6: [f9f85df30118f3f4112761e6682fc60ebcce23e5]

CVE-2024-56676: thermal: testing: Initialize some variables annoteded
with _free()

Announce: https://lore.kernel.org/linux-cve-announce/2024122829-CVE-2024-56676-0d17@gregkh/

Introduced by commit f6a034f ("thermal: Introduce a debugfs-based
testing facility") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0104dcdaad3a7afd141e79a5fb817a92ada910ac]

CVE-2024-56677: powerpc/fadump: Move fadump_cma_init to setup_arch()
after initmem_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024122831-CVE-2024-56677-f922@gregkh/

Introduced by commit 11ac3e8 ("mm: cma: use pageblock_order as the
single alignment") in v5.19-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05b94cae1c47f94588c3e7096963c1007c4d9c1d]
stable/6.1: [aabef6301dcf410dfd2b8759cd413b2a003c7e3f]
stable/6.6: [c5c1d1ef70834013fc3bd12b6a0f4664c6d75a74]

CVE-2024-56678: powerpc/mm/fault: Fix kfence page fault reporting

Announce: https://lore.kernel.org/linux-cve-announce/2024122832-CVE-2024-56678-977d@gregkh/

Introduced by commit 90cbac0 ("powerpc: Enable KFENCE for PPC32") in v5.13-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06dbbb4d5f7126b6307ab807cbf04ecfc459b933]
stable/5.15: [e0a470b5733c1fe068d5c58b0bb91ad539604bc6]
stable/6.1: [4d2655754e94741b159aa807b72ea85518a65fd5]
stable/6.6: [9ea8d8bf9b625e8ad3be6b0432aecdc549914121]

CVE-2024-56679: octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_common.c

Announce: https://lore.kernel.org/linux-cve-announce/2024122832-CVE-2024-56679-02b5@gregkh/

Introduced by commit ab58a41 ("octeontx2-pf: cn10k: Get max mtu
supported from admin function") in v5.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0fbc7a5027c6f7f2c785adae3dcec22b2f2b69b3]
stable/5.15: [785c6758ea32aca73ba9331f7d902f7ce9a25757]
stable/6.1: [9265b6ee754226f61bd122ec57141a781d4e0dcb]
stable/6.6: [52c63a6a27d3178fab533fcfb4baa2ed5b8608a3]

CVE-2024-56680: media: intel/ipu6: do not handle interrupts when
device is disabled

Announce: https://lore.kernel.org/linux-cve-announce/2024122832-CVE-2024-56680-fac9@gregkh/

Introduced by commit ab29a24 ("media: intel/ipu6: add IPU6 buttress
interface driver") in v6.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1429826883bb18847092b2e04c6598ef34bae1d4]

CVE-2024-56681: crypto: bcm - add error check in the ahash_hmac_init function

Announce: https://lore.kernel.org/linux-cve-announce/2024122832-CVE-2024-56681-d0c0@gregkh/

Introduced by commit 9d12ba8 ("crypto: brcm - Add Broadcom SPU
driver") in v4.11-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19630cf57233e845b6ac57c9c969a4888925467b]
stable/4.19: [8f1a9a960b1107bd0e0ec3736055f5ed0e717edf]
stable/5.10: [28f8ffa945f7d7150463e15097ea73b19529d6f5]
stable/5.15: [4ea3e3b761e371102bb1486778e2f8dbc9e37413]
stable/5.4: [75e1e38e5d80d6d9011b7322698ffba3dd3db30a]
stable/6.1: [05f0a3f5477ecaa1cf46448504afe9e7c2e96fcc]
stable/6.6: [ae5253313e0ea5f00c06176074592b7f493c8546]

CVE-2024-56682: irqchip/riscv-aplic: Prevent crash when MSI domain is missing

Announce: https://lore.kernel.org/linux-cve-announce/2024122833-CVE-2024-56682-3219@gregkh/

Introduced by commit ca8df97 ("irqchip/riscv-aplic: Add support for
MSI-mode") in v6.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f181d1cda56c2fbe379c5ace1aa1fac6306669e]

CVE-2024-56683: drm/vc4: hdmi: Avoid hang with debug registers when suspended

Announce: https://lore.kernel.org/linux-cve-announce/2024122833-CVE-2024-56683-14c3@gregkh/

Introduced by commit 25eb441 ("drm/vc4: hdmi: Add all the vc5 HDMI
registers into the debugfs dumps") in v6.0-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [223ee2567a55e4f80315c768d2969e6a3b9fb23d]
stable/6.1: [0ea29bd7d9400d3629683244d609358ed1b12075]
stable/6.6: [c7d474974954d9af7e0092021223d58f2de128df]

CVE-2024-56684: mailbox: mtk-cmdq: fix wrong use of sizeof in cmdq_get_clocks()

Announce: https://lore.kernel.org/linux-cve-announce/2024122833-CVE-2024-56684-55a3@gregkh/

Introduced by commit aa1609f ("mailbox: mtk-cmdq: Dynamically allocate
clk_bulk_data structure") in v6.11-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [271ee263cc8771982809185007181ca10346fe73]

CVE-2024-56685: ASoC: mediatek: Check num_codecs is not zero to avoid
panic during probe

Announce: https://lore.kernel.org/linux-cve-announce/2024122833-CVE-2024-56685-f49e@gregkh/

Introduced by commit 13f5826 ("ASoC: soc.h: don't create dummy
Component via COMP_DUMMY()") in v6.8-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f2020327cc8561d7c520d2f2d9acea84fa7b3a3]

CVE-2024-56686: ext4: fix race in buffer_head read fault injection

Announce: https://lore.kernel.org/linux-cve-announce/2024122833-CVE-2024-56686-b432@gregkh/

Introduced by commit 46f870d ("ext4: simulate various I/O and checksum
errors when reading metadata") in v5.6-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f3d93e210b9c2866c8b3662adae427d5bf511ec]
stable/6.6: [77035e4d27e15f87ea55929c8bb8fb1970129e2f]

CVE-2024-56687: usb: musb: Fix hardware lockup on first Rx endpoint request

Announce: https://lore.kernel.org/linux-cve-announce/2024122834-CVE-2024-56687-99e2@gregkh/

Introduced by commit baebdf4 ("net: dev: Makes sure netif_rx() can be
invoked in any context.") in v5.18-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3fc137386c4620305bbc2a216868c53f9245670a]
stable/6.1: [c749500b28cae67410792096133ee7f282439c51]
stable/6.6: [5906ee3693674d734177df13a519a21bb03f730d]

CVE-2024-56688: sunrpc: clear XPRT_SOCK_UPD_TIMEOUT when reset transport

Announce: https://lore.kernel.org/linux-cve-announce/2024122834-CVE-2024-56688-4e02@gregkh/

Introduced by commit 7196dbb ("SUNRPC: Allow changing of the TCP
timeout parameters on the fly") in v4.11-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4db9ad82a6c823094da27de4825af693a3475d51]
stable/5.10: [86a1f9fa24804cd7f9d7dd3f24af84fc7f8ec02e]
stable/5.15: [fe6cbf0b2ac3cf4e21824a44eaa336564ed5e960]
stable/5.4: [cc91d59d34ff6a6fee1c0b48612081a451e05e9a]
stable/6.1: [87a95ee34a48dfad198a2002e4966e1d63d53f2b]
stable/6.6: [3811172e8c98ceebd12fe526ca6cb37a1263c964]

CVE-2024-56689: PCI: endpoint: epf-mhi: Avoid NULL dereference if DT
lacks 'mmio'

Announce: https://lore.kernel.org/linux-cve-announce/2024122834-CVE-2024-56689-69ca@gregkh/

Introduced by commit 1bf5f25 ("PCI: endpoint: Add PCI Endpoint
function driver for MHI bus") in v6.5-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5089b3d874e9933d9842e90410d3af1520494757]
stable/6.6: [242ee2b0ad9b23f47084904fce3f9f228068a1f9]

CVE-2024-56690: crypto: pcrypt - Call crypto layer directly when
padata_do_parallel() return -EBUSY

Announce: https://lore.kernel.org/linux-cve-announce/2024122834-CVE-2024-56690-b77f@gregkh/

Introduced by commit 8f4f68e ("crypto: pcrypt - Fix hungtask for
PADATA_RESET") in v6.7-rc1.
Fixed in v6.13-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/5.4
stable/6.1 stable/6.6

Fixed status
cip/4.4: [55d7ec4e96941122c593acb4710c8790cc6faf68]
cip/4.4-st: [55d7ec4e96941122c593acb4710c8790cc6faf68]
mainline: [662f2f13e66d3883b9238b0b96b17886179e60e2]
stable/4.19: [dd8bf8eb5beba1e7c3b11a9a5a58ccbf345a69e6]
stable/5.10: [a92ccd3618e42333ac6f150ecdac14dca298bc7a]
stable/5.15: [96001f52ae8c70e2c736d3e1e5dc53d5b521e5ca]
stable/5.4: [fca8aed12218f96b38e374ff264d78ea1fbd23cc]
stable/6.1: [92834692a539b5b7f409e467a14667d64713b732]
stable/6.6: [5edae7a9a35606017ee6e05911c290acee9fee5a]

CVE-2024-56691: mfd: intel_soc_pmic_bxtwc: Use IRQ domain for USB Type-C device

Announce: https://lore.kernel.org/linux-cve-announce/2024122834-CVE-2024-56691-c981@gregkh/

Introduced by commit 9c6235c ("mfd: intel_soc_pmic_bxtwc: Add
bxt_wcove_usbc device") in v4.9-rc1.
Introduced by commit d2061f9 ("usb: typec: add driver for Intel
Whiskey Cove PMIC USB Type-C PHY") in v4.12-rc1.
Introduced by commit 5712904 ("mfd: intel_soc_pmic_bxtwc: Use chained
IRQs for second level IRQ chips") in v4.13-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [686fb77712a4bc94b76a0c5ae74c60118b7a0d79]
stable/5.10: [0b648968bfa4f5c9c4983bca9f2de17626ed6fb6]
stable/5.15: [23230ac3c5ca3f154b64849d1cf50583b4e6b98c]
stable/5.4: [0997e77c51330c2866a4f39480e762cca92ad953]
stable/6.1: [c310e6916c0b297011d0fec03f168a6b24e9e984]
stable/6.6: [e1ef62e8d262e3f27446d26742208c1c81e9ee18]

CVE-2024-56692: f2fs: fix to do sanity check on node blkaddr in truncate_node()

Announce: https://lore.kernel.org/linux-cve-announce/2024122835-CVE-2024-56692-e6ad@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc1.


Fixed status
mainline: [6babe00ccd34fc65b78ef8b99754e32b4385f23d]
stable/6.6: [27d6e7eff07f8cce8e83b162d8f21a07458c860d]

CVE-2024-56693: brd: defer automatic disk creation until module
initialization succeeds

Announce: https://lore.kernel.org/linux-cve-announce/2024122835-CVE-2024-56693-b3c6@gregkh/

Introduced by commit 7f9b348 ("brd: convert to
blk_alloc_disk/blk_cleanup_disk") in v5.14-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [826cc42adf44930a633d11a5993676d85ddb0842]
stable/5.15: [41219c147df8bbd6591f59af5d695fb6c9a1cbff]
stable/6.1: [259bf925583ec9e3781df778cadf00594095090d]
stable/6.6: [410896624db639500f24f46478b4bfa05c76bf56]

CVE-2024-56694: bpf: fix recursive lock when verdict program return SK_PASS

Announce: https://lore.kernel.org/linux-cve-announce/2024122835-CVE-2024-56694-c701@gregkh/

Introduced by commit 6648e61 ("bpf, skmsg: Fix NULL pointer
dereference in sk_psock_skb_ingress_enqueue") in v6.9-rc7.
Fixed in v6.13-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [8ca2a1eeadf09862190b2810697702d803ceef2d]
stable/5.15: [6694f7acd625ed854bf6342926e771d65dad7f69]
stable/6.1: [386efa339e08563dd33e83bc951aea5d407fe578]
stable/6.6: [da2bc8a0c8f3ac66fdf980fc59936f851a083561]

CVE-2024-56695: drm/amdkfd: Use dynamic allocation for CU occupancy
array in 'kfd_get_cu_occupancy()'

Announce: https://lore.kernel.org/linux-cve-announce/2024122835-CVE-2024-56695-110a@gregkh/

Introduced by commit 6ae9e1a ("drm/amdkfd: Update logic for CU
occupancy calculations") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [922f0e00017b09d9d47e3efac008c8b20ed546a0]

CVE-2024-56696: ALSA: core: Fix possible NULL dereference caused by
kunit_kzalloc()

Announce: https://lore.kernel.org/linux-cve-announce/2024122836-CVE-2024-56696-2b90@gregkh/

Introduced by commit 3e39acf ("ALSA: core: Add sound core KUnit test")
in v6.9-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ad467a2b2716d4ed12f003b041aa6c776a13ff5]

CVE-2024-56697: drm/amdgpu: Fix the memory allocation issue in
amdgpu_discovery_get_nps_info()

Announce: https://lore.kernel.org/linux-cve-announce/2024122836-CVE-2024-56697-062c@gregkh/

Introduced by commit b194d21 ("drm/amdgpu: Use NPS ranges from
discovery table") in v6.11-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1144da794adedb9447437c57d69add56494309d]

CVE-2024-56698: usb: dwc3: gadget: Fix looping of queued SG entries

Announce: https://lore.kernel.org/linux-cve-announce/2024122836-CVE-2024-56698-6b0b@gregkh/

Introduced by commit c96e672 ("usb: dwc3: gadget: Correct the logic
for queuing sgs") in v4.18-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7fc65f5141c24785dc8c19249ca4efcf71b3524]
stable/5.10: [8ceb21d76426bbe7072cc3e43281e70c0d664cc7]
stable/5.15: [0247da93bf62d33304b7bf97850ebf2a86e06d28]
stable/6.1: [c9e72352a10ae89a430449f7bfeb043e75c255d9]
stable/6.6: [1534f6f69393aac773465d80d31801b554352627]

CVE-2024-56699: s390/pci: Fix potential double remove of hotplug slot

Announce: https://lore.kernel.org/linux-cve-announce/2024122836-CVE-2024-56699-a3d3@gregkh/

Introduced by commit 6ee600b ("s390/pci: remove hotplug slot when
releasing the device") in v6.9-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4a585e952ca403a370586d3f16e8331a7564901]

CVE-2024-56700: media: wl128x: Fix atomicity violation in fmc_send_cmd()

Announce: https://lore.kernel.org/linux-cve-announce/2024122836-CVE-2024-56700-d3d1@gregkh/

Introduced by commit e8454ff ("[media] drivers:media:radio: wl128x: FM
Driver Common sources") in v2.6.39-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [d7910da3ecc08a2b96ecf06063c3f916d69c8d06]
cip/4.4-st: [d7910da3ecc08a2b96ecf06063c3f916d69c8d06]
mainline: [ca59f9956d4519ab18ab2270be47c6b8c6ced091]
stable/4.19: [d16109c9fdc1b8cea4fe63b42e06e926c3f68990]
stable/5.10: [d7408a052aa1b4f6fb6f1c7a8877b84017a07ac9]
stable/5.15: [ed228b74d8a500380150965d5becabf9a1e33141]
stable/5.4: [3c818ad07e964bca3d27adac1e1f50e1e3c9180e]
stable/6.1: [372dc9509122e5d45d4c12978e31c3c7d00aaca4]
stable/6.6: [378ce4e08ca2b1ac7bbf1d57b68643ca4226c5f8]

CVE-2024-56701: powerpc/pseries: Fix dtl_access_lock to be a rw_semaphore

Announce: https://lore.kernel.org/linux-cve-announce/2024122837-CVE-2024-56701-d424@gregkh/

Introduced by commit 06220d7 ("powerpc/pseries: Introduce rwlock to
gatekeep DTLB usage") in v5.3-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cadae3a45d23aa4f6485938a67cbc47aaaa25e38]
stable/5.10: [6956c0e7346ce1bbfc726755aa8da10d26e84276]
stable/5.15: [f6ec133668757f84e5143f1eb141fd0b83778b9e]
stable/6.1: [fa5b5ea257135e771b489c83a2e93b5935d0108e]
stable/6.6: [a246daa26b717e755ccc9061f47f7cd1c0b358dd]

CVE-2024-56702: bpf: Mark raw_tp arguments with PTR_MAYBE_NULL

Announce: https://lore.kernel.org/linux-cve-announce/2024122837-CVE-2024-56702-172d@gregkh/

Introduced by commit 3f00c52 ("bpf: Allow trusted pointers to be
passed to KF_TRUSTED_ARGS kfuncs") in v6.2-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb4158ce8ec8a5bb528cc1693356a5eb8058094d]

CVE-2024-56703: ipv6: Fix soft lockups in fib6_select_path under high
next hop churn

Announce: https://lore.kernel.org/linux-cve-announce/2024122837-CVE-2024-56703-683a@gregkh/

Introduced by commit 66f5d6c ("ipv6: replace rwlock with rcu and
spinlock in fib6_table") in v4.15-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9ccb18f83ea2bb654289b6ecf014fd267cc988b]

CVE-2024-56704: 9p/xen: fix release of IRQ

Announce: https://lore.kernel.org/linux-cve-announce/2024122837-CVE-2024-56704-881e@gregkh/

Introduced by commit 71ebd71 ("xen/9pfs: connect to the backend") in v4.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e43c608f40c065b30964f0a806348062991b802d]
stable/4.19: [692eb06703afc3e24d889d77e94a0e20229f6a4a]
stable/5.10: [7f5a2ed5c1810661e6b03f5a4ebf17682cdea850]
stable/5.15: [4950408793b118cb8075bcee1f033b543fb719fa]
stable/5.4: [d74b4b297097bd361b8a9abfde9b521ff464ea9c]
stable/6.1: [b9e26059664bd9ebc64a0e8f5216266fc9f84265]
stable/6.6: [2bb3ee1bf237557daea1d58007d2e1d4a6502ccf]

CVE-2024-56705: media: atomisp: Add check for rgby_data memory
allocation failure

Announce: https://lore.kernel.org/linux-cve-announce/2024122837-CVE-2024-56705-049b@gregkh/

Introduced by commit a49d253 ("staging/atomisp: Add support for the
Intel IPU v2") in v4.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed61c59139509f76d3592683c90dc3fdc6e23cd6]
stable/5.10: [0c24b82bc4d12c6a58ceacbf2598cd4df63abf9a]
stable/5.15: [4676e50444046b498555b849e6080a5c78cdda9b]
stable/6.1: [02a97d9d7ff605fa4a1f908d1bd3ad8573234b61]
stable/6.6: [8066badaf7463194473fb4be19dbe50b11969aa0]

CVE-2024-56706: s390/cpum_sf: Fix and protect memory allocation of
SDBs with mutex

Announce: https://lore.kernel.org/linux-cve-announce/2024122838-CVE-2024-56706-d292@gregkh/

Introduced by commit 8a6fe8f ("s390/cpum_sf: Use refcount_t instead of
atomic_t") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f55bd479d8663a4a4e403b3d308d3d1aa33d92df]

CVE-2024-56707: octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dmac_flt.c

Announce: https://lore.kernel.org/linux-cve-announce/2024122838-CVE-2024-56707-783f@gregkh/

Introduced by commit 79d2be3 ("octeontx2-pf: offload DMAC filters to
CGX/RPM block") in v5.14-rc2.
Introduced by commit fa5e0cc ("octeontx2-pf: Add support for exact
match table.") in v6.0-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5b942e6c54b13246ee49d42dcfb71b7f29e3c64]
stable/6.1: [1611b1ea7cf8d07dff091a45389b10401bb6d5b3]
stable/6.6: [3ccbc7a518868eff1d5a198b9e454e182b651e00]

CVE-2024-56708: EDAC/igen6: Avoid segmentation fault on module unload

Announce: https://lore.kernel.org/linux-cve-announce/2024122838-CVE-2024-56708-2702@gregkh/

Introduced by commit 10590a9 ("EDAC/igen6: Add EDAC driver for Intel
client SoCs using IBECC") in v5.11-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fefaae90398d38a1100ccd73b46ab55ff4610fba]
stable/5.15: [029ac07bb92d2f7502d47a4916f197a8445d83bf]
stable/6.1: [2a80e710bbc088a2511c159ee4d910456c5f0832]
stable/6.6: [830cabb61113d92a425dd3038ccedbdfb3c8d079]

CVE-2024-56709: io_uring: check if iowq is killed before queuing

Announce: https://lore.kernel.org/linux-cve-announce/2024122918-CVE-2024-56709-655c@gregkh/

Introduced by commit 50c5225 ("block: implement async io_uring discard
cmd") in v6.12-rc1.
Introduced by commit 773af69 ("io_uring: always reissue from task_work
context") in v5.14-rc4.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dbd2ca9367eb19bc5e269b8c58b0b1514ada9156]
stable/6.1: [534d59ab38010aada88390db65985e65d0de7d9e]
stable/6.6: [2ca94c8de36091067b9ce7527ae8db3812d38781]

CVE-2024-56710: ceph: fix memory leak in ceph_direct_read_write()

Announce: https://lore.kernel.org/linux-cve-announce/2024122913-CVE-2024-56710-78af@gregkh/

Introduced by commit 03bc06c ("ceph: add new mount option to enable
sparse reads") in v6.6-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66e0c4f91461d17d48071695271c824620bed4ef]

CVE-2024-56711: drm/panel: himax-hx83102: Add a check to prevent NULL
pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024122913-CVE-2024-56711-d4f9@gregkh/

Introduced by commit 0ef9455 ("drm/panel: himax-hx83102: Break out as
separate driver") in v6.11-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1e1af9148dc4c866eda3fb59cd6ec3c7ea34b1d]

CVE-2024-56712: udmabuf: fix memory leak on last export_udmabuf() error path

Announce: https://lore.kernel.org/linux-cve-announce/2024122914-CVE-2024-56712-d62a@gregkh/

Introduced by commit fbb0de7 ("Add udmabuf misc device") in v4.20-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f49856f525acd5bef52ae28b7da2e001bbe7439e]

CVE-2024-56713: net: netdevsim: fix nsim_pp_hold_write()

Announce: https://lore.kernel.org/linux-cve-announce/2024122914-CVE-2024-56713-f78a@gregkh/

Introduced by commit 1580cbc ("net: netdevsim: add some fake page pool
use") in v6.10-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b9b8301d369b4c876de5255dbf067b19ba88ac71]

CVE-2024-56714: ionic: no double destroy workqueue

Announce: https://lore.kernel.org/linux-cve-announce/2024122914-CVE-2024-56714-0de2@gregkh/

Introduced by commit 9e25450 ("ionic: add private workqueue
per-device") in v6.11-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [746e6ae2e202b062b9deee7bd86d94937997ecd7]

CVE-2024-56715: ionic: Fix netdev notifier unregister on failure

Announce: https://lore.kernel.org/linux-cve-announce/2024122915-CVE-2024-56715-7db1@gregkh/

Introduced by commit 30b87ab ("ionic: remove lif list concept") in v5.10-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9590d32e090ea2751e131ae5273859ca22f5ac14]
stable/6.1: [da93a12876f8b969df7316dc93aac7e725f88252]
stable/6.6: [da5736f516a664a9e1ff74902663c64c423045d2]

CVE-2024-56716: netdevsim: prevent bad user input in
nsim_dev_health_break_write()

Announce: https://lore.kernel.org/linux-cve-announce/2024122915-CVE-2024-56716-7a52@gregkh/

Introduced by commit 82c93a8 ("netdevsim: implement couple of testing
devlink health reporters") in v5.5-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee76746387f6233bdfa93d7406990f923641568f]
stable/6.1: [d10321be26ff9e9e912697e9e8448099654ff561]
stable/6.6: [470c5ecbac2f19b1cdee2a6ce8d5650c3295c94b]

CVE-2024-56717: net: mscc: ocelot: fix incorrect IFH SRC_PORT field in
ocelot_ifh_set_basic()

Announce: https://lore.kernel.org/linux-cve-announce/2024122915-CVE-2024-56717-546c@gregkh/

Introduced by commit e1b9e80 ("net: mscc: ocelot: fix QoS class for
injected packets with "ocelot-8021q"") in v6.11-rc5.
Fixed in v6.13-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [2d5df3a680ffdaf606baa10636bdb1daf757832e]
stable/6.1: [59c4ca8d8d7918eb6e2df91d2c254827264be309]
stable/6.6: [2f3c62ffe88116cd2a39cd73e01103535599970f]

CVE-2024-56718: net/smc: protect link down work from execute after lgr freed

Announce: https://lore.kernel.org/linux-cve-announce/2024122915-CVE-2024-56718-be98@gregkh/

Introduced by commit 541afa1 ("net/smc: add smcr_port_err() and
smcr_link_down() processing") in v5.8-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b33eb8f1b3e8c2f87cfdbc8cc117f6bdfabc6ec]
stable/6.1: [bec2f52866d511e94c1c37cd962e4382b1b1a299]
stable/6.6: [2627c3e8646932dfc7b9722c88c2e1ffcf7a9fb2]

CVE-2024-56719: net: stmmac: fix TSO DMA API usage causing oops

Announce: https://lore.kernel.org/linux-cve-announce/2024122916-CVE-2024-56719-609b@gregkh/

Introduced by commit 66600fa ("net: stmmac: TSO: Fix unbalanced DMA
map/unmap for non-paged SKB data") in v6.12-rc6.
Fixed in v6.13-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [4c49f38e20a57f8abaebdf95b369295b153d1f8e]
stable/6.6: [db3667c9bbfbbf5de98e6c9542f7e03fb5243286]

CVE-2024-56720: bpf, sockmap: Several fixes to bpf_msg_pop_data

Announce: https://lore.kernel.org/linux-cve-announce/2024122920-CVE-2024-56720-614a@gregkh/

Introduced by commit 7246d8e ("bpf: helper to pop data from messages")
in v5.0-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d609ba262475db450ba69b8e8a557bd768ac07a]
stable/5.10: [d26d977633d1d0b8bf9407278189bd0a8d973323]
stable/5.15: [e1f54c61c4c9a5244eb8159dce60d248f7d97b32]
stable/5.4: [d3f5763b3062514a234114e97bbde74d8d702449]
stable/6.1: [f58d3aa457e77a3d9b3df2ab081dcf9950f6029f]
stable/6.6: [98c7ea7d11f2588e8197db042e0291e4ac8f8346]

CVE-2024-56721: x86/CPU/AMD: Terminate the erratum_1386_microcode array

Announce: https://lore.kernel.org/linux-cve-announce/2024122922-CVE-2024-56721-aaac@gregkh/

Introduced by commit 29ba89f ("x86/CPU/AMD: Improve the erratum 1386
workaround") in v6.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff6cdc407f4179748f4673c39b0921503199a0ad]

CVE-2024-56722: RDMA/hns: Fix cpu stuck caused by printings during reset

Announce: https://lore.kernel.org/linux-cve-announce/2024122923-CVE-2024-56722-5594@gregkh/

Introduced by commit 9a44353 ("IB/hns: Add driver files for hns RoCE
driver") in v4.9-rc1.
Introduced by commit c7bcb13 ("RDMA/hns: Add SRQ support for hip08
kernel mode") in v5.0-rc1.
Introduced by commit 70f9252 ("RDMA/hns: Use the reserved loopback QPs
to free MR before destroying MPT") in v5.18-rc1.
Introduced by commit 926a01d ("RDMA/hns: Add QP operations support for
hip08 SoC") in v4.15-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [323275ac2ff15b2b7b3eac391ae5d8c5a3c3a999]
stable/6.1: [31c6fe9b79ed42440094f2367897aea0c0ce96ec]
stable/6.6: [b4ba31e5aaffbda9b22d9a35c40b16dc39e475a6]

CVE-2024-56723: mfd: intel_soc_pmic_bxtwc: Use IRQ domain for PMIC devices

Announce: https://lore.kernel.org/linux-cve-announce/2024122923-CVE-2024-56723-f74b@gregkh/

Introduced by commit 5712904 ("mfd: intel_soc_pmic_bxtwc: Use chained
IRQs for second level IRQ chips") in v4.13-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0350d783ab888cb1cb48ced36cc28b372723f1a4]
stable/5.10: [61d590d7076b50b6ebdea1f3b83bb041c01fc482]
stable/5.15: [bb6642d4b3136359b5b620049f76515876e6127e]
stable/5.4: [6ea17c03edc7ed0aabb1431eb26e2f94849af68a]
stable/6.1: [7ba45b8bc62e64da524d45532107ae93eb33c93c]
stable/6.6: [d4cc78bd6a25accb7ae2ac9fc445d1e1deda4a62]

CVE-2024-56724: mfd: intel_soc_pmic_bxtwc: Use IRQ domain for TMU device

Announce: https://lore.kernel.org/linux-cve-announce/2024122923-CVE-2024-56724-a800@gregkh/

Introduced by commit 957ae50 ("platform/x86: Add Whiskey Cove PMIC TMU
support") in v4.10-rc1.
Introduced by commit 5712904 ("mfd: intel_soc_pmic_bxtwc: Use chained
IRQs for second level IRQ chips") in v4.13-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b79d59e6b2b515eb9a22bc469ef7b8f0904fc73]
stable/5.10: [c472b55cc0bc3df805db6a14f50a084884cf18ee]
stable/5.15: [da498e02c92e6d82df8001438dd583b90c570815]
stable/5.4: [b7c7c400de85d915e0da7c2c363553a801c47349]
stable/6.1: [56acf415772ee7e10e448b371f52b249aa2d0f7b]
stable/6.6: [1b734ad0e33648c3988c6a37c2ac16c2d63eda06]

CVE-2024-56725: octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dcbnl.c

Announce: https://lore.kernel.org/linux-cve-announce/2024122923-CVE-2024-56725-af15@gregkh/

Introduced by commit 8e67558 ("octeontx2-pf: PFC config support with
DCBx") in v5.18-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69297b0d3369488af259e3a7cf53d69157938ea1]
stable/6.1: [b94052830e3cd3be7141789a5ce6e62cf9f620a4]
stable/6.6: [b99db02209ca4c2e2f53b82049ea3cbc82b54895]

CVE-2024-56726: octeontx2-pf: handle otx2_mbox_get_rsp errors in cn10k.c

Announce: https://lore.kernel.org/linux-cve-announce/2024122924-CVE-2024-56726-3a9e@gregkh/

Introduced by commit 2ca89a2 ("octeontx2-pf: TC_MATCHALL ingress
ratelimiting offload") in v5.14-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac9183023b6a9c09467516abd8aab04f9a2f9564]
stable/5.15: [a374e7e79fbdd7574bd89344447b0d4b91ba9801]
stable/6.1: [856ad633e11869729be698df2287ecfe6ec31f27]
stable/6.6: [c5a6c5af434671aea739a5a41c849819144f02c9]

CVE-2024-56727: octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c

Announce: https://lore.kernel.org/linux-cve-announce/2024122924-CVE-2024-56727-41d8@gregkh/

Introduced by commit 9917060 ("octeontx2-pf: Cleanup flow rule
management") in v5.14-rc1.
Introduced by commit f0a1913 ("octeontx2-pf: Add support for ethtool
ntuple filters") in v5.11-rc1.
Introduced by commit 674b3e1 ("octeontx2-pf: Add additional checks
while configuring ucast/bcast/mcast rules") in v6.2-rc1.
Fixed in v6.13-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [bd3110bc102ab6292656b8118be819faa0de8dd0]
stable/6.1: [8c9f8b35dc3d4ad8053a72bc0c5a7843591f6b75]
stable/6.6: [c4eae7bac880edd88aaed6a8ec2997fa85e259c7]

CVE-2024-56728: octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_ethtool.c

Announce: https://lore.kernel.org/linux-cve-announce/2024122924-CVE-2024-56728-68d7@gregkh/

Introduced by commit 75f3627 ("octeontx2-pf: Support to enable/disable
pause frames via ethtool") in v5.7-rc1.
Introduced by commit d0cf950 ("octeontx2-pf: ethtool fec mode
support") in v5.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit was backported to following branches.
stable/5.10

Fixed status
mainline: [e26f8eac6bb20b20fdb8f7dc695711ebce4c7c5c]
stable/5.10: [5ff9de1f2712cbca53da2e37d831eea7ffcb43b6]
stable/5.15: [55c41b97001a09bb490ffa2e667e251d75d15ab1]
stable/6.1: [05a6ce174c0c724e5914e1e5efd826bab8f382b4]
stable/6.6: [c0f64fd73b60aee85f88c270c9d714ead27a7b7a]

CVE-2024-56729: smb: Initialize cfid->tcon before performing network ops

Announce: https://lore.kernel.org/linux-cve-announce/2024122924-CVE-2024-56729-8f1c@gregkh/

Introduced by commit ebe98f1 ("cifs: enable caching of directories for
which a lease is held") in v6.1-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c353ee4fb119a2582d0e011f66a76a38f5cf984d]
stable/6.6: [625e2357c8fcfae6e66dcc667dc656fe390bab15]

CVE-2024-56730: net/9p/usbg: fix handling of the failed kzalloc()
memory allocation

Announce: https://lore.kernel.org/linux-cve-announce/2024122924-CVE-2024-56730-3e54@gregkh/

Introduced by commit a3be076 ("net/9p/usbg: Add new usb gadget
function transport") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff1060813d9347e8c45c8b8cff93a4dfdb6726ad]

CVE-2024-56739: rtc: check if __rtc_read_time was successful in
rtc_timer_do_work()

Announce: https://lore.kernel.org/linux-cve-announce/2024122925-CVE-2024-56739-0a67@gregkh/

Introduced by commit 6610e08 ("RTC: Rework RTC code to use timerqueue
for events") in v2.6.38-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [c5d39584d41724eb20b35999bcd3296a3bcefeae]
cip/4.4-st: [c5d39584d41724eb20b35999bcd3296a3bcefeae]
mainline: [e8ba8a2bc4f60a1065f23d6a0e7cbea945a0f40d]
stable/4.19: [39ad0a1ae17b54509cd9e93dcd8cec16e7c12d3f]
stable/5.10: [0d68e8514d9040108ff7d1b37ca71096674b6efe]
stable/5.15: [246f621d363988e7040f4546d20203dc713fa3e1]
stable/5.4: [44b3257ff705d63d5f00ef8ed314a0eeb7ec37f2]
stable/6.1: [fde56535505dde3336df438e949ef4742b6d6d6e]
stable/6.6: [dd4b1cbcc916fad5d10c2662b62def9f05e453d4]

CVE-2024-56740: nfs/localio: must clear res.replen in nfs_local_read_done

Announce: https://lore.kernel.org/linux-cve-announce/2024122925-CVE-2024-56740-6b7b@gregkh/

Introduced by commit 70ba381 ("nfs: add LOCALIO support") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [650703bc4ed3edf841e851c99ab8e7ba9e5262a3]

CVE-2024-56741: apparmor: test: Fix memory leak for aa_unpack_strdup()

Announce: https://lore.kernel.org/linux-cve-announce/2024122925-CVE-2024-56741-3dbc@gregkh/

Introduced by commit 4d944bc ("apparmor: add AppArmor KUnit tests for
policy unpack") in v5.6-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7290f59231910ccba427d441a6e8b8c6f6112448]
stable/5.10: [f856246ff6da25c4f8fdd73a9c875e878b085e9f]
stable/5.15: [5354599855a9b5568e05ce686119ee3ff8b19bd5]
stable/6.1: [89265f88701e54dde255ddf862093baeca57548c]
stable/6.6: [2a9b68f2dc6812bd1b8880b5c00e60203d6f61f6]

CVE-2024-56742: vfio/mlx5: Fix an unwind issue in mlx5vf_add_migration_pages()

Announce: https://lore.kernel.org/linux-cve-announce/2024122925-CVE-2024-56742-b3d2@gregkh/

Introduced by commit 6fadb02 ("vfio/mlx5: Implement vfio_pci driver
for mlx5 devices") in v5.18-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22e87bf3f77c18f5982c19ffe2732ef0c7a25f16]

CVE-2024-56743: nfs_common: must not hold RCU while calling nfsd_file_put_local

Announce: https://lore.kernel.org/linux-cve-announce/2024122925-CVE-2024-56743-39a5@gregkh/

Introduced by commit 65f2a5c ("nfs_common: fix race in NFS calls to
nfsd_file_put_local() and nfsd_serv_put()") in v6.12-rc3.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c840b8e1f039e90f97ca55525667eb961422f86c]

CVE-2024-56744: f2fs: fix to avoid potential deadlock in
f2fs_record_stop_reason()

Announce: https://lore.kernel.org/linux-cve-announce/2024122926-CVE-2024-56744-fc8b@gregkh/

Introduced by commit b62e71b ("f2fs: support
errors=remount-ro|continue|panic mountoption") in v6.5-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f10a890308a7cd8794e21f646f09827c6cb4bf5d]
stable/6.6: [ecf4e6782b01fd578b565b3dd2be7bb0ac91082e]

CVE-2024-56745: PCI: Fix reset_method_store() memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2024122926-CVE-2024-56745-b06b@gregkh/

Introduced by commit d88f521 ("PCI: Allow userspace to query and set
device reset mechanism") in v5.15-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2985b1844f3f3447f2d938eff1ef6762592065a5]
stable/5.15: [403efb4457c0c8f8f51e904cc57d39193780c6bd]
stable/6.1: [931d07ccffcc3614f20aaf602b31e89754e21c59]
stable/6.6: [8e098baf6bc3f3a6aefc383509aba07e202f7ee0]

CVE-2024-56746: fbdev: sh7760fb: Fix a possible memory leak in
sh7760fb_alloc_mem()

Announce: https://lore.kernel.org/linux-cve-announce/2024122926-CVE-2024-56746-d329@gregkh/

Introduced by commit 4a25e41 ("video: sh7760fb: SH7760/SH7763 LCDC
framebuffer driver") in v2.6.27-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [b4ba45b0350ad974251c55d3f9c487377cd6f3c6]
cip/4.4-st: [b4ba45b0350ad974251c55d3f9c487377cd6f3c6]
mainline: [f89d17ae2ac42931be2a0153fecbf8533280c927]
stable/4.19: [0d3fb3b3e9d66f7b6346e3b90bc0ff48683539ce]
stable/5.10: [29216bb390e36daeebef66abaa02d9751330252b]
stable/5.15: [f4fbd70e15fafe36a7583954ce189aaf5536aeec]
stable/5.4: [d48cbfa90dce506030151915fa3346d67f964af4]
stable/6.1: [40f4326ed05a3b3537556ff2a844958b9e779a98]
stable/6.6: [3dd9df8e5f34c6fc4217a7498c1fb3c352d4afc2]

CVE-2024-56747: scsi: qedi: Fix a possible memory leak in
qedi_alloc_and_init_sb()

Announce: https://lore.kernel.org/linux-cve-announce/2024122926-CVE-2024-56747-7c03@gregkh/

Introduced by commit ace7f46 ("scsi: qedi: Add QLogic FastLinQ offload
iSCSI driver framework.") in v4.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95bbdca4999bc59a72ebab01663d421d6ce5775d]
stable/4.19: [4e48e5b26b3edc0e1dd329201ffc924a7a1f9337]
stable/5.10: [a4d2011cbe039b25024831427b60ab91ee247066]
stable/5.15: [bb8b45883eb072adba297922b67d1467082ac880]
stable/5.4: [eaf92fad1f21be63427920c12f22227e5f757424]
stable/6.1: [b778b5240485106abf665eb509cc01779ed0cb00]
stable/6.6: [10a6fc486ac40a410f0fb84cc15161238eccd20a]

CVE-2024-56748: scsi: qedf: Fix a possible memory leak in
qedf_alloc_and_init_sb()

Announce: https://lore.kernel.org/linux-cve-announce/2024122927-CVE-2024-56748-eb85@gregkh/

Introduced by commit 61d8658 ("scsi: qedf: Add QLogic FastLinQ offload
FCoE driver framework.") in v4.11-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c62c30429db3eb4ced35c7fcf6f04a61ce3a01bb]
stable/5.10: [a56777a3ef5b35e24a20c4418bcf88bad033807a]
stable/5.15: [64654bf5efb3f748e6fc41227adda689618ce9c4]
stable/5.4: [97384449ddfc07f12ca75f510eb070020d7abb34]
stable/6.1: [b514f45e0fe18d763a1afc34401b1585333cb329]
stable/6.6: [7c1832287b21ff68c4e3625e63cc7619edf5908b]

CVE-2024-56749: dlm: fix dlm_recover_members refcount on error

Announce: https://lore.kernel.org/linux-cve-announce/2024122927-CVE-2024-56749-14d1@gregkh/

Introduced by commit 3a747f4 ("dlm: move rsb root_list to ls_recover()
stack") in v6.10-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [200b977ebbc313a59174ba971006a231b3533dc5]

CVE-2024-56750: erofs: fix blksize < PAGE_SIZE for file-backed mounts

Announce: https://lore.kernel.org/linux-cve-announce/2024122927-CVE-2024-56750-db4d@gregkh/

Introduced by commit fb17675 ("erofs: add file-backed mount support")
in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bae0854160939a64a092516ff1b2f221402b843b]

CVE-2024-56751: ipv6: release nexthop on device removal

Announce: https://lore.kernel.org/linux-cve-announce/2024122927-CVE-2024-56751-bcf3@gregkh/

Introduced by commit f88d8ea ("ipv6: Plumb support for nexthop object
in a fib6_info") in v5.3-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb02688c5c45c3e7af7e71f036a7144f5639cbfe]
stable/6.1: [b2f26a27ea3f72f75d18330f76f5d1007c791848]
stable/6.6: [43e25adc80269f917d2a195f0d59f74cdd182955]

CVE-2024-56752: drm/nouveau/gr/gf100: Fix missing unlock in gf100_gr_chan_new()

Announce: https://lore.kernel.org/linux-cve-announce/2024122927-CVE-2024-56752-09d2@gregkh/

Introduced by commit ca081ff ("drm/nouveau/gr/gf100-: generate golden
context during first object alloc") in v6.2-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2f599046c671d6b46d93aed95b37241ce4504cf]
stable/6.6: [237f2dbfa00576bb1aa8dc2dce403c64e53270e6]

CVE-2024-56753: drm/amdgpu/gfx9: Add Cleaner Shader Deinitialization
in gfx_v9_0 Module

Announce: https://lore.kernel.org/linux-cve-announce/2024122927-CVE-2024-56753-32df@gregkh/

Introduced by commit c2e70d3 ("drm/amdgpu/gfx9: Implement cleaner
shader support for GFX9 hardware") in v6.12-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e47cb9d2533200d49dd5364d4a148119492f8a3d]

CVE-2024-56754: crypto: caam - Fix the pointer passed to caam_qi_shutdown()

Announce: https://lore.kernel.org/linux-cve-announce/2024122928-CVE-2024-56754-9c9d@gregkh/

Introduced by commit f414de2 ("crypto: caam - use devres to
de-initialize QI") in v5.5-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad980b04f51f7fb503530bd1cb328ba5e75a250e]
stable/5.10: [cc386170b3312fd7b5bc4a69a9f52d7f50814526]
stable/5.15: [6187727e57aec122c8a99c464c74578c810cbe40]
stable/6.1: [66eddb8dcb61065c53098510165f14b54232bcc2]
stable/6.6: [1f8e2f597b918ca5827a5c6d00b819d064264d1c]

CVE-2024-56755: netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING

Announce: https://lore.kernel.org/linux-cve-announce/2024122928-CVE-2024-56755-b189@gregkh/

Introduced by commit bfa22da ("fscache: Provide and use cache methods
to lookup/create/free a volume") in v5.17-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22f9400a6f3560629478e0a64247b8fcc811a24d]
stable/6.1: [ddab02607eed9e415dc62fde421d4329e5345315]
stable/6.6: [539fabba965e119b98066fc6ba5257b5eaf4eda2]

CVE-2024-56756: nvme-pci: fix freeing of the HMB descriptor table

Announce: https://lore.kernel.org/linux-cve-announce/2024122928-CVE-2024-56756-32fb@gregkh/

Introduced by commit 87ad72a ("nvme-pci: implement host memory buffer
support") in v4.13-rc1.
Fixed in v6.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c2fb1ca8086eb139b2a551358137525ae8e0d7a]
stable/5.10: [452f9ddd12bebc04cef741e8ba3806bf0e1fd015]
stable/5.15: [869cf50b9c9d1059f5223f79ef68fc0bc6210095]
stable/5.4: [ac22240540e0c5230d8c4138e3778420b712716a]
stable/6.1: [fb96d5cfa97a7363245b3dd523f475b04296d87b]
stable/6.6: [cee3bff51a35cab1c5d842d409a7b11caefe2386]


* Updated CVEs

CVE-2024-41013: xfs: don't walk off the end of a directory data block

stable/6.6 was fixed.

Fixed status
stable/6.6: [ca96d83c93071f95cf962ce92406621a472df31b]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

