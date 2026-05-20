Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A22CD4F3D
	for <webhook@archiver.kernel.org>; Wed, 20 May 2026 22:19:59 +0000 (UTC)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24212.1779315592251127162
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 May 2026 15:19:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=Vj2jlmpJ;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.44, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-651bf695701so5241357d50.2
        for <cip-dev@lists.cip-project.org>; Wed, 20 May 2026 15:19:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779315591; cv=none;
        d=google.com; s=arc-20240605;
        b=AGSP/EEbwbkXixoV96SsHN6CNuYiE/XBHzxU6Xl/HgGqiOK0zB9Y9LXGXY816ypn7e
         lVMnpE0Z0E6UqoHTyGJAmS/aW9i7LuSdY2b+kPOqFkwCmg29hQtrxi0IfAuH2fvlfguv
         p19QppVp/3QDHS3O0GTJv0TjV5BiG8mDY4Nw6Hl5QH1vkMSOOkHVdPItyTNCmxx0MfTa
         9WSqtM6ExAMELShz3++gI81d1XhPhAL6dWi5ELqOB4Pv+Z84s6BhSOFBbC6fCOYRS9LH
         1cbKBcdmD/M9FIhh/9JumLWWUtMso994afk7kfKybjI7Vz2RgAqcLE413MZe6JpSEwBU
         2CJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Di+XIHc9EUc5OIxd5E8pqEzU3YtFGN+FkYMckQZrdO8=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=L03c6iVDv39lvbYZsE/O12N4rJwoAiywPAHCam2LeBFFM5sPifXc13R3i/Qz4C2Ec0
         A0Vt6ZUZwufNyuTUem7inby5JKo19Om+tZLAGYSk+qE98u0twygM33LYHN3ZTxVlWc4S
         LmL8wA1wva7H8RLdCLqpliCc48lzK76sI6fkHTUEvTa11vWS7mhVYlGn3UpBbMui1O9k
         I1oENlG7C9TRakz8vSgRV7hNDA5AeMJ1Fji+Wx5KqGCXEE/Am0ztY3pC7IxMVYQ60Kpy
         BM1EeCwupk1Qgi55/cEDnxl66L7xdDOyjbdeT+/Mot16KudcZUgfvIfzzQiTnu/xAbph
         +iqw==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1779315591; x=1779920391; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Di+XIHc9EUc5OIxd5E8pqEzU3YtFGN+FkYMckQZrdO8=;
        b=Vj2jlmpJAQe/LmONUIGd5E2XHltSUNkFIbaNzMm8LcxVrdQI6iOwP5zH5pxI37muPI
         GvniVI0dJUTtdGAH1Mheqw+GbRn0OkGWdiI114W2qzyavbU4pX8WsEl51uILK1xlZ2Vp
         UlEzdsaQHIZu9MotiVCBDJBJtjMi78qE56MA92IHRDDjWa//N2I3SgnbPrF3ncfnrrB1
         PiMVlbgSFOj4y94R59dkIMluRSTk6KwUL4srJh8pAxnRrmorzm86UgvP0zoXunRbZOv9
         LwnzMM5SpSlG/aFJ0SbbZWtH8DmNCQcspkv9HEiO9W7It5Z94LMCAomME5ga3Cc4oAeB
         ep0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315591; x=1779920391;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Di+XIHc9EUc5OIxd5E8pqEzU3YtFGN+FkYMckQZrdO8=;
        b=S2EUKAx2wCYpyvT9vJ05BAfAKXpiWTA6FF2QfP/3gJRvFP7orEhJItB4U/ynBfUasg
         3PfG5nROmPUym8KZL9XslzWQ194uerHsdWjthH6MybVq+XixDB1QDPnfrkzaFBJBGm16
         k2bczjDy3mQCZpZoiAPZpxotdvvEhM1stnf0huuVL1urC3hcwXqd7KfWuRNeKNZUNTpG
         TMWkPe/OK4JGm5gLRwFglnx5KUuTKrFjwvjFygO1BvdqQZfmMihrnuv76+lsYyOX8epn
         yODyMMZVjPDBW7F3j3myN3bE3yko2jvFsM6XW7YfTr5kn4l64zjmotI92HeFwxMgfhXT
         tqnA==
X-Gm-Message-State: AOJu0YwOpaJHXZMGjQeziV3GaCDfsoLrNxTiideMfciYIoesK6wnCbSz
	h8eOjmpwThbzfqLm0gsutG3xENzhBUASglxBpjiaTMkTR/cXUKtyJ0MrBPVwYFSSK89LUo1GxLp
	2H1cSeFVb8LZaZpbN+S8ygCyyGGJOOt0QwbvuHed6bbGXDeMcgMcpjLDtDQ==
X-Gm-Gg: Acq92OE7Z2C5ehqGA8Ti8jJh3EF9NrTSojiqDlKr3yVhiMrCOBWi6tbUsIiVKWbb9Mr
	2SKL7uDQW1oQ7k2Z784GSVWlsF4ly9hTTSWsXJiJuqstwhO5UB177Ppb0b6rQJ2FF8y8NtptaPk
	9ptz4SkxqOVwBsLW5zcQ3mCaCBO0CXgpiYr0EsDmeJhkC1l4RAlZmjWZTbABMf5MG8JXjnn2pDH
	/lcPEF4skwUVz5cTxHqNt4zp/j248/NKTB1Ox9yN0LmTxmMKQAsB7V3kGjc38j9uysHD9wNAH64
	8BzX3Y/+
X-Received: by 2002:a05:690e:4193:b0:65c:5b88:84b5 with SMTP id
 956f58d0204a3-65eadf343b1mr114826d50.6.1779315590954; Wed, 20 May 2026
 15:19:50 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 21 May 2026 07:19:14 +0900
X-Gm-Features: AVHnY4JWl3ZteOeLOvuSUgQFUf6Jf41p-TD636BbT-OzI_A8BvAhix4s0WymwQs
Message-ID: <CAODzB9oq_mRaQUc2fyu8CYVd40iPc_mqa03xg0F5kKB0sBWwmA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 May 2026 22:19:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22985

Hi!

It's this week's CVE report.

This week reported 4 new CVEs and 25 updated CVEs.

* New CVEs
CVE-2026-46333: ptrace: slightly saner 'get_dumpable()' logic

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46333


Introduced by commit bfedb58 ("mm: Add a user_ns owner to mm_struct
and fix ptrace permission checks") in 4.10-rc1. Fixed in mainline.
Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [31e62c2ebbfdc3fe3dbdf5e02c92a9dc67087a3a]
stable/5.10: [93d4ba49d18e3d7fb41a9927c2d0cca5e9dfefd6]
stable/5.15: [15b828a46f305ae9f05a7c16914b3ce273474205]
stable/6.1: [4709234fd1b95136ceb789f639b1e7ea5de1b181]
stable/6.12: [6e5b51e74a40d377bcd3081dd33fbaa0e1aa7e3d]
stable/6.18: [2a93a4fac7b6051d3be7cd1b015fe7320cd0404d]
stable/6.6: [8f907d345bae8f4b3f004c5abc56bf2dfb851ea7]
stable/7.0: [01363cb3fbd0238ffdeb09f53e9039c9edf8a730]

CVE-2026-43491: net: qrtr: ns: Limit the maximum server registration per node

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43491

Introduced by commit 0c2204a ("net: qrtr: Migrate nameservice to
kernel from userspace") in v5.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5ee2ff98322337951c56398e79d51815acbf955]
stable/6.12: [3efaad55cad1ded429e3a873bfece389058a526b]
stable/6.18: [35fb4a0c077c5d1049c2628b769e0a1b1e65df0d]
stable/6.6: [e6f6cd501fb54060940a6eb3f4103eeb5e426ae7]
stable/7.0: [868202aa2adae427060a42d5bd663b4d782ec02c]

CVE-2026-43492: lib/crypto: mpi: Fix integer underflow in
mpi_read_raw_from_sgl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43492

Introduced by commit 2d4d1ee ("lib/mpi: Add mpi sgl helpers") in v4.4-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c2f1288250a90a4b5cabed5d888d7e3aeed4035]
stable/6.12: [26d3a97ad46c7a9226ec04d4bf35bd4998a97d16]
stable/6.18: [8637dfb4c1d8a7026ef681f2477c6de8b71c4003]
stable/6.6: [2aa77a18dc7f2670497fe3ee5acbeda0b57659e5]
stable/7.0: [30e513e755bb381afce6fb57cdc8694136193f22]

CVE-2026-43493: crypto: pcrypt - Fix handling of MAY_BACKLOG requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43493

Introduced by commit 5a1436b ("crypto: pcrypt - call the complete
function on error") in v2.6.34-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [915b692e6cb723aac658c25eb82c58fd81235110]
stable/6.12: [eb34e243df57e32f4c08fa191f3602ea19076276]
stable/6.18: [77d55bc8675ee851ed639dc9be77325a8024cf67]
stable/6.6: [9f1cbca178c03188e201ed175251372149bb25f2]
stable/7.0: [46271895ddfb1ba41f89f7e0dffbe9c2bcf7380a]



* Updated CVEs
CVE-2026-31499: Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
CVE-2026-43490: "ksmbd: validate inherited ACE SID length"

stable/6.12 was fixed.

Fixed status
stable/6.12: [f7f35a4f7fd574f5889bb2e4b397e14cbb83f6da]

CVE-2026-43088: net: af_key: zero aligned sockaddr tail in PF_KEY exports

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [11cbf294bac623bd57296f231199193087f57b4a]
stable/6.18: [edd446ee7cd3d02cac246168063d5b3e9ea68460]

CVE-2026-43109: x86: shadow stacks: proper error handling for mmap lock

stable/6.12 and stable/6.6 were fixed.

Fixed status
stable/6.12: [1a30468eff661937d978495644d2e5ebfeef5ce6]
stable/6.6: [c79cf42321600e931933e11f94aba8b245d4cd66]

CVE-2026-43220: iommu/amd: serialize sequence allocation under
concurrent TLB invalidations

stable/6.12 and stable/6.6 were fixed.

Fixed status
stable/6.12: [fca7aa0264ae99e5ff287d0ced5af0b82b121c4f]
stable/6.6: [d51bf43193b1e95dc4e34e540dc76e19def2ae5a]

CVE-2026-43500: rxrpc: Also unshare DATA/RESPONSE packets when paged
frags are present

stable/6.12 and stable/6.6 were fixed.

Fixed status
stable/6.12: [3711382a77342a9a1c3d2e7330dcfc7ea927f568]
stable/6.6: [7c504ffab3efce8f7e4f463b314ae31030bdf18b]

CVE-2024-56647: net: Fix icmp host relookup triggering ip_rt_bug

stable/6.6 was fixed.

Fixed status
stable/6.6: [da54b3039d436227deebbc202cefea63bd318a38]

CVE-2025-21845: mtd: spi-nor: sst: Fix SST write failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [f7c14993dc2f1eca661975c0ff90a6e2098ecd41]

CVE-2025-38584: padata: Fix pd UAF once and for all

stable/6.6 was fixed.

Fixed status
stable/6.6: [a11a12a9880ab37342b73c93cfe1a3ada02ff0db]

CVE-2025-39981: Bluetooth: MGMT: Fix possible UAFs

stable/6.6 was fixed.

Fixed status
stable/6.6: [0b60eb04b8524e1b4b3f07fea0d16fda9a677d9a]

CVE-2025-68315: f2fs: fix to detect potential corrupted nid in free_nid_list

stable/6.6 was fixed.

Fixed status
stable/6.6: [9337ed5e777e1c19854928cba7a8131dd00e611b]

CVE-2026-23151: Bluetooth: MGMT: Fix memory leak in set_ssp_complete

stable/6.6 was fixed.

Fixed status
stable/6.6: [d7e42dc47beb48851bc0008c1e1b79126de9d975]

CVE-2026-23171: bonding: fix use-after-free due to enslave fail after
slave array update

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [2889d92c5f728351c9930c7996d22fe6e906e785]
stable/6.6: [172dcb67dd35b162357df229d7806acc724cd469]

CVE-2026-23468: drm/amdgpu: Limit BO list entry count to prevent
resource exhaustion

stable/6.6 was fixed.

Fixed status
stable/6.6: [e620378aab78d415bd8a15a2f91c145906520288]

CVE-2026-23473: [REJECTED]: io_uring/poll: fix multishot recv missing
EOF on wakeup race

stable/6.6 was fixed.

Fixed status
stable/6.6: [8bbed28f6b4259e06278e19734d5855a681a2cf4]

CVE-2026-31440: dmaengine: idxd: Fix leaking event log memory

stable/6.6 was fixed.

Fixed status
stable/6.6: [695b491dc3f20365fd5821f22e25dbe3c1c20cbc]

CVE-2026-31443: dmaengine: idxd: Fix crash when the event log is disabled

stable/6.6 was fixed.

Fixed status
stable/6.6: [5ba95b119aa700daf5686609b8e2766571cad097]

CVE-2026-31449: ext4: validate p_idx bounds in ext4_ext_correct_indexes

stable/6.6 was fixed.

Fixed status
stable/6.6: [4d08401aa13f1531216f1a7ae281ca4806e90a5c]

CVE-2026-31488: drm/amd/display: Do not skip unrelated mode changes in
DSC validation

stable/6.6 was fixed.

Fixed status
stable/6.6: [21159d8b335a6b9f44cbb506733013a902ae2da4]

CVE-2026-31489: spi: meson-spicc: Fix double-put in remove path

stable/6.6 was fixed.

Fixed status
stable/6.6: [0d645c6d13fa0597935d3d16b09a7ba5d24ed284]

CVE-2026-31511: Bluetooth: MGMT: Fix dangling pointer on
mgmt_add_adv_patterns_monitor_complete

stable/6.6 was fixed.

Fixed status
stable/6.6: [2074dfffad76981ca451cb7fc98703d04ac562fe]

CVE-2026-31709: smb: client: validate the whole DACL before rewriting
it in cifsacl

stable/6.6 was fixed.

Fixed status
stable/6.6: [8e47d297e7cf9a6029a0d38e7b22faba7d7aaf12]

CVE-2026-31712: ksmbd: require minimum ACE size in smb_check_perm_dacl()

stable/6.6 was fixed.

Fixed status
stable/6.6: [325d4ac11f526cb8964cff14548ccf02d8c756d8]

CVE-2026-31715: f2fs: fix UAF caused by decrementing sbi->nr_pages[]
in f2fs_write_end_io()

stable/6.6 was fixed.

Fixed status
stable/6.6: [1171f329cf1c175321251ac40fd126150d7ad1e8]

CVE-2026-31718: ksmbd: fix use-after-free in __ksmbd_close_fd() via
durable scavenger

stable/6.6 was fixed.

Fixed status
stable/6.6: [0000a7780e0e446a28a273572f6ea8f7f582f694]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

