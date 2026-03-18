Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99A81088E54
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 23:11:34 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27873.1773875484016271527
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2026 16:11:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=sgVsZeWp;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.177, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a51edef1fso23463787b3.1
        for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 16:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773875483; cv=none;
        d=google.com; s=arc-20240605;
        b=d+Z4htalX8SbVIpea6klXs0G2R0guJl1p8KB3UXcmqSrRR91OC90Oxxcfc7Y1o0omO
         6i28mTp/FUdCtPn3kbZbi8IvVnpT9BzeFP9Q8XgcAaw96C38c2V49Yeqoe1djDAy/i5K
         h1HQjLETFNxdoQrk/LAKkSt55UPtTyNT7wqJ7rrAFI9BJaA1QuAca5cTka+LoMUs8Jsr
         Ncg/0ZzSUDTCYDkxxQzk6+KDiDMEYo0/Ewmnww2ooudAsgJlbMGRCGOAtxQ6EyaQbqIH
         i510IGcdtPqwdjiGvwc2h2zkLNLmeVrzyqxG0nEFi4opDQxQsCi4TA1khdNvQG8Oqhst
         pv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=zZaQ8geArCwt2QHlwj0z+p4iZ46cFRtQF7aqQVQyWGI=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=lK5TMS+/Qhu7S21mX6pirBXfv0CNfDHZgoD5XWv8pC3lBt5ygqzPNn65UBMwGJnI+9
         /PrQIv8zR1PO9oOQwuTzH69/QbMtCGH0scjw0SrSqjc1RmoTjyYLXrH3pFeVI5ZIjyyJ
         8rj9nKxbwxVdQegxW1rSnw4VuqdPhqbsMI8nDf6SUe0SOz65ULkwZazwnTeR9U6PCCFL
         Pfz2YRvUv2feZEA4budQqOSFajTMWOhCUigmo6Pom28pQpebJDWDCO28EnVQOHHl8cnu
         8D+8B6kqhFyCsFteYIEy8CybvxhF+Pf4zMWxqCvt+lg1ppgfICtXBl4apRrAuhWYLt3h
         EK1Q==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1773875483; x=1774480283; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zZaQ8geArCwt2QHlwj0z+p4iZ46cFRtQF7aqQVQyWGI=;
        b=sgVsZeWp/zpaoEgLDDwktpqX0IoUWEuwb2yVkf8jxiJjIbGUfyQ6japi9I8EiIfdwM
         hU6MMaQRBrA4No2rl1Iwm4XsoSrYFWZdf5Zms7A6KUF0W3H7YXrQIgrMXt3sof8l3xqp
         szvTu5p7iJQ6KR+zmgDioIwwjvsPpda/YTXvA57rvSJhIxwPYsTtGG4dYcqemzn3urgl
         WClSNo4BJdC+yhskwybAmkUnqgdO9R2ioLxxSLYGlkGfJEXS3QuJpt9E3t4Nmnwa7roq
         DZEU0JQguFskM3NcAZcQoeJk14VgtNeZ96eKb+WraKtb7b9Aar6EHgtdLAv8iqrZKUC1
         yLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773875483; x=1774480283;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZaQ8geArCwt2QHlwj0z+p4iZ46cFRtQF7aqQVQyWGI=;
        b=ZbQ+7ROXkc2cJlq7bq6ad/PFYbIfB3ALzkDSrKmsf9BePfnrP/8Z3aE74IR1k1Tlyy
         LE4m8mEg7J89XNS4yghGwsBc+DZaxN5pOkImdpKjvN3UZzy2Rq93gZU5hQ5IuHO5KtmS
         vH93R71GaNCZlXqtxHfwPPf4ODkL6bJb5A9dNE9q/Fu2XtfQbj4a2ksUjmsvuOJF7u/o
         Yi+7rJiC5qiQOXL3NyhKvL3dt1U05A0V+yU3Nt5Q0cQ3GfSai8GPXJz2DsZZgR8ooHwn
         AjU804aATt3YcgevVqlvvbD25fL9CbA4PGu8GM0WbxbBMDLmarJl5fmjEJibcPuyRNvF
         mFfg==
X-Gm-Message-State: AOJu0Yz1JLAqRmnF/+NLgwyi87+4efkcDV3miKVMcWf6lX0DWHCPnZI2
	+NjzqsRMKDHGRFcCCqhR3BX2v8qZs55grtVH1XjiFwgcB7H1oTx0eCbyRW0SSKyE+c5so7K7PFR
	vh/J+tf59FZ7QZ7cu26uHsvUn5CCbG65qlaoyf/V9wtGXmYIKOoKVbTg=
X-Gm-Gg: ATEYQzxgxqthnUrN92DazTrMY+640BhEr5QZqIpfHPJlhG1lOmguTDf9I0Zc3aEUAJw
	3o4Iu84iqHANrFrezzGjB8GSodTyWSliTAlZggrZW95RVDJq4QDN6uCXVhjCMxqkAiOQrfpwBUj
	jFpsuc3Xp4fnoAKkkLdQm5FSFyy1P1E+9+jNg5OVzES+YpLZQyI0r2FUElohYfe29sLqTGHKoco
	1x7e90HMABmc6DX+9vWxpFBEF2c35gQE8JTrHU3W26JzhNM8axHNgdRI7/SGiOSbmMt6qiC8EQq
	XDDP5MQo
X-Received: by 2002:a05:690c:397:b0:79a:2047:2c3c with SMTP id
 00721157ae682-79a81a908b4mr14203127b3.13.1773875482574; Wed, 18 Mar 2026
 16:11:22 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 19 Mar 2026 08:10:45 +0900
X-Gm-Features: AaiRm53OYN0xUHE2x4jDaPtwe7JjDqHfnId0zfn43K_7IDiBKo8FjyckHer-aRk
Message-ID: <CAODzB9qBL-xF=FbMpgt+mvQvadFP++LKuf+QpZt0oqXLQC9-Tw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 23:11:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22506

Hi!

It's this week's CVE report.

This week reported 37 new CVEs and 4 updated CVEs.

* New CVEs
CVE-2025-71239: audit: add fchmodat2() to change attributes class

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71239

According to the .vulnerable file, this bug was introduced by commit
09da082 in v6.6-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f493a6079b588cf1f04ce5ed6cdad45ab0d53dc]
stable/5.10: [f714315d7d68898d03093f67285256a8770f903c]
stable/5.15: [3ee75b13ea5f05ff9adc784b2464825bd70eb119]
stable/6.1: [57489a89657cc94bf6ad8427d1902daba9156aa1]
stable/6.12: [3e762a03713e8c25ca0108c075d662c897fc0623]
stable/6.18: [4fed776ca86378da7dd743a7b648e20b025ba8ef]
stable/6.19: [c4334c0d0e7d6f02ed93756fd4ba807e3d00c05f]
stable/6.6: [91e27bc79c3bca93c06bf5a471d47df9a35b3741]

CVE-2026-23241: audit: add missing syscalls to read class

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23241

According to the .vulnerable file, this bug was introduced by commit
6140be9 in v6.13-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bcb90a2834c7393c26df9609b889a3097b7700cd]
stable/5.10: [ed8efd623a5738e03de09dd74b505d0fb77b09f3]
stable/5.15: [ada4bba3afefee1fa68aa6bd1fd597ea4b11a16e]
stable/6.1: [33cdef7ecf6e5d2cf46a35ec26befce072a1aa07]
stable/6.12: [5632d14b2f2a0ade2d0068e12676ebed67e3bb2a]
stable/6.18: [a2e8c144299c31d3972295ed80d4cb908daf4f6f]
stable/6.19: [ad37505ce869a8100ff23f24eea117de7a7516bf]
stable/6.6: [f5d27ad99fcaa7d965b344dd0b00d9413585c3cb]

CVE-2025-71265: fs: ntfs3: fix infinite loop in attr_load_runs_range
on inconsistent metadata

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71265

According to the .vulnerable file, this bug was introduced by commit
be71b5c in v5.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b90f16e4bb5607fb35e7802eb67874038da4640]
stable/5.15: [6f07a590616ff5f57f7c041d98e463fad9e9f763]
stable/6.1: [a89bc96d5abd8a4a8d5d911884ea347efcdf460b]
stable/6.12: [78b61f7eac37a63284774b147f38dd0be6cad43c]
stable/6.18: [c0b43c45d45f59e7faad48675a50231a210c379b]
stable/6.19: [3c3a6e951b9b53dab2ac460a655313cf04c4a10a]
stable/6.6: [af839013c70a24779f9d1afb1575952009312d38]

CVE-2025-71266: fs: ntfs3: check return value of indx_find to avoid
infinite loop

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71266

According to the .vulnerable file, this bug was introduced by commit
82cae26 in v5.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1732053c8a6b360e2d5afb1b34fe9779398b072c]
stable/5.15: [14c3188afbedfd5178bbabb8002487ea14b37b56]
stable/6.1: [435d34719db0e130f6f0c621d67ed524cc1a7d10]
stable/6.12: [398e768d1accd1f5645492ab996005d7aa84a5b0]
stable/6.18: [b0ea441f44ce64fa514a415d4a9e6e2b06e7946c]
stable/6.19: [0ad7a1be44479503dbe5c699759861ef5b8bd70c]
stable/6.6: [68e32694be231c1cdb99b7637a657314e88e1a96]

CVE-2025-71267: fs: ntfs3: fix infinite loop triggered by zero-sized ATTR_LIST

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71267

According to the .vulnerable file, this bug was introduced by commit
be71b5c in v5.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06909b2549d631a47fcda249d34be26f7ca1711d]
stable/5.15: [9267d99fade76d44d4a133599524031fe684156e]
stable/6.1: [976e6a7c51fabf150478decbe8ef5d9a26039b7c]
stable/6.12: [7ef219656febf5ae06ae56b1fce47ebd05f92b68]
stable/6.18: [9779a6eaaabdf47aa57910d352b398ad742e6a5f]
stable/6.19: [fd508939dbca5eceefb2d0c2564beb15469572f2]
stable/6.6: [8d8c70b57dbeda3eb165c0940b97e85373ca9354]

CVE-2025-71268: btrfs: fix reservation leak in some error paths when
inserting inline extent

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71268

Introduced commit is not determined.Fixed in v6.19-rc5.


Fixed status
mainline: [c1c050f92d8f6aac4e17f7f2230160794fceef0c]
stable/6.1: [f7156512c8166d385f574b9ec030479aa7b1e8c9]
stable/6.12: [f3ee1732851aec6fe6b2cec2ef1b32d4e71d9913]
stable/6.18: [28768bd3abf9995a93f6e01bfce01c60622964dd]
stable/6.6: [28b97fcbbf523779688e8de5fe55bf2dae3859f6]

CVE-2025-71269: btrfs: do not free data reservation in fallback from
inline due to -ENOSPC

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71269

Introduced commit is not determined.Fixed in v6.19-rc5.


Fixed status
mainline: [f8da41de0bff9eb1d774a7253da0c9f637c4470a]
stable/6.18: [6de3a371a8b9fd095198b1aa68c22cc10a4c6961]

CVE-2025-71270: LoongArch: Enable exception fixup for specific ADE subcode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71270

Introduced commit is not determined.Fixed in v6.19-rc4.
LoongArch architecture  was introduced by fa96b57 ("LoongArch: Add
build infrastructure") in v5.19-rc1.

Fixed status
mainline: [9bdc1ab5e4ce6f066119018d8f69631a46f9c5a0]
stable/6.1: [b9d9a221bd14ed4b01d113701976fa376762c544]
stable/6.12: [c49a28068363f3dca439aa5fe4d3b1f8159809fe]
stable/6.18: [c2ed4f71e9288f21d5c53ff790270758e60fa5f9]
stable/6.6: [73ede654d9daa2ee41bdd17bc62946fc5a0258cb]

CVE-2026-23242: RDMA/siw: Fix potential NULL pointer dereference in
header processing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23242

Introduced by commit 8b6a361 ("rdma/siw: receive path") in v5.3-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14ab3da122bd18920ad57428f6cf4fade8385142]
stable/5.10: [ab61841633d10e56a58c1493a262f0d02dba2f5e]
stable/5.15: [8564dcc12fbb372d984ab45768cae9335777b274]
stable/6.1: [ab957056192d6bd068b3759cb2077d859cca01f0]
stable/6.12: [87b7a036d2c73d5bb3ae2d47dee23de465db3355]
stable/6.18: [714c99e1dc8f85f446e05be02ba83972e981a817]
stable/6.19: [ce025f7f5d070596194315eb2e4e89d568b8a755]
stable/6.6: [ffba40b67663567481fa8a1ed5d2da36897c175d]

CVE-2026-23243: RDMA/umad: Reject negative data_len in ib_umad_write

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23243

Introduced by commit 2be8e3e ("IB/umad: Add P_Key index support") in
v2.6.24-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5551b02fdbfd85a325bb857f3a8f9c9f33397ed2]
stable/5.10: [1371ef6b1ecf3676b8942f5dfb3634fb0648128e]
stable/5.15: [362e45fd9069ffa1523f9f1633b606ebf72060d7]
stable/6.1: [6eb2919474ca105c5b13d19574e25f0ddcf19ca2]
stable/6.12: [9c80d688f402539dfc8f336de1380d6b4ee14316]
stable/6.18: [205955f29c26330b1dc7fdeadd5bb97c38e26f56]
stable/6.19: [52ab82cc5cf8ada5c3fb6ffe8f32fdb2fc27a34b]
stable/6.6: [a6a3e4af10993cb9e4b8f0548680aba0ab5f3b0d]

CVE-2026-23244: nvme: fix memory allocation in nvme_pr_read_keys()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23244

Introduced by commit 5fd96a4 (nvme: Add pr_ops read_keys support) in v6.5-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3320153769f05fd7fe9d840cb555dd3080ae424]
stable/6.12: [15fb6d627484ee39ed73e202ef4720e1fa5c898e]
stable/6.18: [5a501379a010690ae9ae88bef62a1bae1aca32e6]
stable/6.19: [baef52d80093bd686e70b3cb7e0512a40ae76705]

CVE-2026-23245: net/sched: act_gate: snapshot parameters with RCU on replace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23245

Introduced by commit a51c328 ("net: qos: introduce a gate control flow
action") in v5.8-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62413a9c3cb183afb9bb6e94dd68caf4e4145f4c]
stable/6.18: [04d75529dc0f9be78786162ebab7424af4644df2]
stable/6.19: [58b162e318d0243ad2d7d92456c0873f2494c351]

CVE-2026-23246: wifi: mac80211: bounds-check link_id in
ieee80211_ml_reconfiguration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23246

Introduced by commit 8eb8dd2 ("wifi: mac80211: Support link removal
using Reconfiguration ML element") in v6.5-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [162d331d833dc73a3e905a24c44dd33732af1fc5]
stable/6.12: [bfde158d5d1322c0c2df398a8d1ccce04943be2e]
stable/6.18: [f35ceec54d48e227fa46f8f97fd100a77b8eab15]
stable/6.19: [d58d71c2167601762351962b9604808d3be94400]

CVE-2026-23247: tcp: secure_seq: add back ports to TS offset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23247

Introduced by commit 28ee1b7 ("secure_seq: downgrade to per-host
timestamp offsets") in v4.11-rc6.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [165573e41f2f66ef98940cf65f838b2cb575d9d1]
stable/6.18: [eae2f14ab2efccdb7480fae7d42c4b0116ef8805]
stable/6.19: [46e5b0d7cf55821527adea471ffe52a5afbd9caf]

CVE-2026-23248: perf/core: Fix refcount bug and potential UAF in perf_mmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23248

According to the .vulnerable file, this bug was introduced by commit
b709eb8 in v6.14-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [77de62ad3de3967818c3dbe656b7336ebee461d2]
stable/6.18: [c27dea9f50ed525facb62ef647dddc4722456e07]
stable/6.19: [ac7ecb65af170a7fc193e7bd8be15dac84ec6a56]

CVE-2026-23249: xfs: check for deleted cursors when revalidating two btrees

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23249

Introduced by commit dbfbf3b ("xfs: repair inode btrees") in v6.8-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55e03b8cbe2783ec9acfb88e8adb946ed504e117]
stable/6.12: [d69de525bc7ab27713342080bf50826df3f6a68f]
stable/6.18: [b04baa848c0543b240b1bd8aecff470382f6f154]
stable/6.19: [5991e96f2ae82df60a3e4ed00f3432d9f3502a99]

CVE-2026-23250: xfs: check return value of xchk_scrub_create_subord

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23250

Introduced by commit 1a5f6e0 ("xfs: create subordinate scrub contexts
for xchk_metadata_inode_subtype") in v6.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca27313fb3f23e4ac18532ede4ec1c7cc5814c4a]
stable/6.12: [d6f3f7d4dd8a179394cef03c00993d57f5f68601]
stable/6.18: [2b658d1249666cc55af9484dcf5f45ca438d4ecc]
stable/6.19: [b2df809edd8cb7d1c3e19d9f6aabc2bd55d2bfb6]

CVE-2026-23251: xfs: only call xf{array,blob}_destroy if we have a valid pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23251

Introduced by commit ab97f4b ("xfs: repair AGI unlinked inode bucket
lists") in v6.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba408d299a3bb3c5309f40c5326e4fb83ead4247]
stable/6.12: [5de5be3ed7e7fa4ebde4f4b58fb9a629644f9202]
stable/6.18: [c9ccefacae0d8091683447bc338bd7741417039d]
stable/6.19: [d827612c81a26cc1dd83a211cfcb5ad8765da0c4]

CVE-2026-23252: xfs: get rid of the xchk_xfile_*_descr calls

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23252

Introduced by commit ab97f4b ("xfs: repair AGI unlinked inode bucket
lists") in v6.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60382993a2e18041f88c7969f567f168cd3b4de3]
stable/6.18: [18e9cf2259b4157fd282b323514375f2f6a59edb]
stable/6.19: [2d8afee89262762fe0e5547772708c75f320c957]

CVE-2026-23253: media: dvb-core: fix wrong reinitialization of
ringbuffer on reopen

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23253

Introduced by commit 34731df ("V4L/DVB (3501): Dmxdev: use
dvb_ringbuffer") in v2.6.20.16.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfbc0b5b32a8f28ce284add619bf226716a59bc0]
stable/6.12: [d71781bad59b1c9d60d7068004581f9bf19c0c9d]
stable/6.18: [cfd94642025e6f71c8f754bdec0800ee95e4f3dd]
stable/6.19: [32eb8e4adc207ef31bc6e5ae56bab940b0176066]

CVE-2026-23254: net: gro: fix outer network offset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23254

Introduced by commit 5ef31ea ("net: gro: fix udp bad offset in socket
lookup by adding {inner_}network_offset to napi_gro_cb") in v6.9-rc7.
Fixed in v6.19.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [5c2c3c38be396257a6a2e55bd601a12bb9781507]
stable/6.12: [b83557bc6f560433fe5d727e241069f8db5ba709]
stable/6.18: [2e5edb69e5d0e23ef248c56fc977039268c77a7b]
stable/6.6: [9d40a85138568696387ef04cd004c64612a70874]

CVE-2026-23255: net: add proper RCU protection to /proc/net/ptype

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23255

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Introduced by commit 1d10f8a ("net-procfs: show net devices bound
packet types") in v5.17-rc2.
Introduced by commit c353e89 ("net: introduce per netns packet
chains") in v6.15-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f613e8b4afea0cd17c7168e8b00e25bc8d33175d]
stable/6.18: [589a530ae44d0c80f523fcfd1a15af8087f27d35]

CVE-2026-23256: net: liquidio: Fix off-by-one error in VF
setup_nic_devices() cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23256

Introduced by commit 846b468 ("liquidio CN23XX: VF offload features")
in v4.10-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6cbba46934aefdfb5d171e0a95aec06c24f7ca30]
stable/5.10: [bd680e56e316be92c01568be98d85d7a6c9bd92c]
stable/5.15: [01fbca1e93ec3f39f76c31a8f9afa32ce00da48a]
stable/6.1: [71a56b89203ec7e5670d94a61a9b4ae617eca804]
stable/6.12: [52b19b3a22306fe452ec9e8ff96063f4bfb77b99]
stable/6.18: [4640fa5ad5e1a0dbd1c2d22323b7d70a8107dcfd]
stable/6.6: [3bf519e39b51cb08a93c0599870b35a23db1031e]

CVE-2026-23257: net: liquidio: Fix off-by-one error in PF
setup_nic_devices() cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23257

Introduced by commit f21fb3e ("Add support of Cavium Liquidio ethernet
adapters") in v4.2-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8558aef4e8a1a83049ab906d21d391093cfa7e7f]
stable/5.10: [af38d9a5cb49fe9d0d282b44f17fdc1f3270d99d]
stable/5.15: [d86c58eb005eb99da402452f3db7a6e0eae32815]
stable/6.1: [f1216b80c9040a904d2ad7c8cd24ca0ff1f36932]
stable/6.12: [f86bd16280a0f88b538394e0565c56ce4756da99]
stable/6.18: [293eaad0d6d6b2a37a458c7deb7be345349cd963]
stable/6.6: [a0d2389c8cdc1f05de5eb8663bffe9ed05dca769]

CVE-2026-23258: net: liquidio: Initialize netdev pointer before queue setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23258

Introduced by commit c33c997 ("liquidio: enhanced ethtool
--set-channels feature") in v4.18-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [062613bc057b333ae9ba721f6527f2d9d2ca9d8a]
mainline: [926ede0c85e1e57c97d64d9612455267d597bb2c]
stable/5.10: [be109646cdaecab262f6276303b1763468c94378]
stable/5.15: [c81a8515fb8c8fb5d0dbc21f48337494bf1d60df]
stable/6.1: [a0e57c0b68c9e6f9a8fd7c1167861a5a730eb2f4]
stable/6.12: [1d4590fde856cb94bd9a46e795c29d8288c238fc]
stable/6.18: [d028147ae06407cb355245db1774793600670169]
stable/6.6: [c0ed6c77ec34050971fd0df2a94dfdea66d09331]

CVE-2026-23259: io_uring/rw: free potentially allocated iovec on cache
put failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23259

Introduced commit is not determined.Fixed in v6.19-rc7.


Fixed status
mainline: [4b9748055457ac3a0710bf210c229d01ea1b01b9]
stable/6.18: [1d5f2329ab4df65c2ee011b986d8a6e05ad0f67c]

CVE-2026-23260: regmap: maple: free entry on mas_store_gfp() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23260

Introduced commit is not determined.Fixed in v6.19-rc7.


Fixed status
mainline: [f3f380ce6b3d5c9805c7e0b3d5bc28d9ec41e2e8]
stable/6.12: [811b45e2d795d955bb7fd9c816b40036f4fde350]
stable/6.18: [f08f2d2907675926ac5657b25f86d921f269602a]
stable/6.6: [d61171cf097156030142643942c217759a9cc806]

CVE-2026-23261: nvme-fc: release admin tagset if init fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23261

Introduced commit is not determined.Fixed in v6.19-rc6.
Affected file was added by e399441 ("nvme-fabrics: Add host support
for FC transport") in v4.10-rc1.

Fixed status
mainline: [d1877cc7270302081a315a81a0ee8331f19f95c8]
stable/6.1: [b134dead095bc5a58fa2b98b90ae93428cb4b328]
stable/6.12: [fa301aef50e3f3b5be6ee53457608beae5aa7a01]
stable/6.18: [e810b290922c535feb34bc90ab549446fe94d2a3]
stable/6.6: [7c54d3f5ebbc5982daaa004260242dc07ac943ea]

CVE-2026-23262: gve: Fix stats report corruption on queue count change

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23262

Introduced by commit 24aeb56 ("gve: Add Gvnic stats AQ command and
ethtool show/set-priv-flags.") in v5.10-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b9ebcce0296e104a0d82a6b09d68564806158ff]
stable/5.10: [f432f7613c220db32c2c6942420daf7b3f2e7d7e]
stable/5.15: [9d93332397405b62a3300b22d04ac65d990b91ff]
stable/6.1: [837c662f47dac43efa1aef2dd433c6b4b4c073af]
stable/6.12: [9fa0a755db3e1945fe00f73fe27d85ef6c8818b7]
stable/6.18: [11f8311f69e4c361717371b4901ff92daeb76e9c]
stable/6.6: [df54838ab61826ecc1a562ffa5e280c3ab7289a7]

CVE-2026-23263: io_uring/zcrx: fix page array leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23263

Introduced by commit b84621d ("io_uring/zcrx: allocate sgtable for
umem areas") in v6.17-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ae91d8ab70922fb74c22c20bedcb69459579b1c]
stable/6.18: [64cf3016234ce8a6e4195ed1b2d9e2a1ae41b57d]

CVE-2026-23264: Revert "drm/amd: Check if ASPM is enabled from PCIe subsystem"

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23264

Introduced by commit 0ab5d71 ("drm/amd: Refactor `amdgpu_aspm` to be
evaluated per device") in v5.18-rc1.
Fixed in v6.19.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [243b467dea1735fed904c2e54d248a46fa417a2d]
stable/6.1: [f02c9052aaa031ef3c2285d86a155d4263180ddd]
stable/6.12: [5b794951541e84d2968980a68dd1ac38420f75f3]
stable/6.18: [5f645222eb30c91135119e12eccfd1b8ea88140e]
stable/6.6: [d2bddc2da2b3ba5d738877c476bf97932dba32e8]

CVE-2026-23265: f2fs: fix to do sanity check on node footer in
{read,write}_end_io

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23265

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [50ac3ecd8e05b6bcc350c71a4307d40c030ec7e4]
stable/6.18: [855c54f1803e3ebc613677b4f389c7f92656a1fc]
stable/6.19: [c386753db52b3a80afa6612bfdcb925aa5ca260f]

CVE-2026-23266: fbdev: rivafb: fix divide error in nv3_arb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23266

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [8fc5b6b996f1ba34821d6bfd9130ba2a7d0a5089]
cip/4.4-st: [120d1f6e5192ecdc87f998b12ece503622f34f0c]
mainline: [0209e21e3c372fa2da04c39214bec0b64e4eb5f4]
stable/5.10: [ec5a58f4fd581875593ea92a65485e1906a53c0f]
stable/5.15: [52916878db2b8e3769743a94484729f0844352df]
stable/6.1: [526460a96c5443e2fc0fd231edd1f9c49d2de26b]
stable/6.12: [9efa0dc46270a8723c158c64afbcf1dead72b28c]
stable/6.18: [3e4cbd1d46c246dfa684c8e9d8c20ae0b960c50a]
stable/6.19: [73f0391e92d404da68f7484e57c106c5e673dc7e]
stable/6.6: [78daf5984d96edec3b920c72a93bd6821b8710b7]

CVE-2026-23267: f2fs: fix IS_CHECKPOINTED flag inconsistency issue
caused by concurrent atomic commit and checkpoint writes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23267

Introduced by commit 608514d ("f2fs: set fsync mark only for the last
dnode") in v4.7-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7633a7387eb4d0259d6bea945e1d3469cd135bbc]
stable/6.1: [32bc3c9fe18881d50dd51fd5f26d19fe1190dc0d]
stable/6.12: [962c167b0f262b9962207fbeaa531721d55ea00e]
stable/6.18: [bd66b4c487d5091d2a65d6089e0de36f0c26a4c7]
stable/6.19: [ed81bc5885460905f9160e7b463e5708fd056324]
stable/6.6: [75e19da068adf0dc5dd269dd157392434b9117d4]

CVE-2026-23268: apparmor: fix unprivileged local user can do
privileged policy management

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23268

Introduced by commit b7fd2c0 ("apparmor: add per policy ns .load,
.replace, .remove interface files") in v4.11-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6601e13e82841879406bf9f369032656f441a425]
stable/6.12: [0fc63dd9170643d15c25681fca792539e23f4640]
stable/6.18: [b60b3f7a35c46b2e0ca934f9c988b8fca06d76c6]
stable/6.19: [b6a94eeca9c6c8f7c55ad44c62c98324f51ec596]

CVE-2026-23269: apparmor: validate DFA start states are in bounds in unpack_pdb

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23269

Introduced by commit ad5ff3d ("AppArmor: Add ability to load extended
policy") in v3.4-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9063d7e2615f4a7ab321de6b520e23d370e58816]
stable/6.12: [15c3eb8916e7db01cb246d04a1fe6f0fdc065b0c]
stable/6.18: [0baadb0eece2c4d939db10d3c323b4652ac79a58]
stable/6.19: [3bb7db43e32190c973d4019037cedb7895920184]

CVE-2026-23270: net/sched: Only allow act_ct to bind to clsact/ingress
qdiscs and shared blocks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23270

Introduced by commit 3f14b37 ("net/sched: act_ct: fix skb leak and
crash on ooo frags") in v6.8-rc1.
Fixed in v7.0-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [11cb63b0d1a0685e0831ae3c77223e002ef18189]
stable/6.12: [524ce8b4ea8f64900b6c52b6a28df74f6bc0801e]
stable/6.18: [380ad8b7c65ea7aa10ef2258297079ed5ac1f5b6]
stable/6.19: [9deda0fcda5c1f388c5e279541850b71a2ccfcf4]


* Updated CVEs

CVE-2024-14027: xattr: switch to CLASS(fd)

stable/6.12 was fixed.

Fixed status
stable/6.12: [d151b94967c8247005435b63fc60f8f4baa320da]

CVE-2025-40119: ext4: fix potential null deref in ext4_mb_init()

stable/6.12 was fixed.

Fixed status
stable/6.12: [08d9175578d6a8e9b81921898fbf01aa669cd2be]

CVE-2026-23226: ksmbd: add chann_lock to protect ksmbd_chann_list xarray

stable/6.12 was fixed.

Fixed status
stable/6.12: [4c2ca31608521895dd742a43beca4b4d29762345]

CVE-2026-23227: drm/exynos: vidi: use ctx->lock to protect struct
vidi_context member variables related to memory alloc/free

stable/6.12 was fixed.

Fixed status
stable/6.12: [abfdf449fb3d7b42e85a1ad1c8694b768b1582f4]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

