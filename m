Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B555FD45FA
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 22:30:26 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.57696.1772058616607941954
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 14:30:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=kCW0tBdz;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.181, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7982c3b7dfcso1937877b3.0
        for <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 14:30:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772058615; cv=none;
        d=google.com; s=arc-20240605;
        b=FA0oNpJ5gQNwTF1YTHCkgndST7PAkPpMraBfG2ioI73RKV45oH1aQuABeR/aZB2Lam
         PplYTovMW8GQzSe9PawsgnoX/FZawW215DhgiIGAXlR6tt7S3b4z8T6KOGImItPIxj8p
         rUPk+oeFqysEdh0IatUSM6lIoYdNGuv2GL/lABvspzEnqazT8DshJwxjEdXmCE2PprFb
         Uc+faqKF8ghllxG2NgkyqdXxE9JQnvVB8308q6pPZTCBheBlWKZSQ5HKYl6ldoEYiz5U
         Tg1BX16iZcQuddL6vwQqylZMn1a7+O51rHm/Bc1uKMnO0jHlEuZewMjrbXqSxvggIhQq
         waEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=8qNO32L+dUVLvzhD1IJL17eYm4uw/4YT6fH+0CJPa/k=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=E/6RpQ8Z9DigMRRFxa2EDUTnTCjJhA+YftyBUinmxM4+tIF7kim1j/NUvIWLCl/Hdy
         g77inA5F9yoBldCbr9A8MTXuBumPsXzfd1SrMX4bxpeevQ3REXWKiYjylO2a/BYG61wD
         3+lTgD+6I8rlpk5pAds2qeqGSIPJipAfI8sdK5syr6YUY8ZnyiioYNjF7JtzdhOBf+D9
         e7LWN+CNbghsiQqLSivEsJC/uplI3TyvNEWGcTXyPZV2JWbesBwpb0hT+okB1KiABW7m
         1YzAvNHmhc/diUMz4wCpUXoWOtLU2+0CDln7Gn3dmxKI9+6wceRZXQ6y7/jYnoORaJKv
         2P4Q==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1772058615; x=1772663415; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8qNO32L+dUVLvzhD1IJL17eYm4uw/4YT6fH+0CJPa/k=;
        b=kCW0tBdzwngSvUKrlPNJkas4BX1bGD+5u5HppscfvfBk/TYVedJu1YNeqJPE+A9G5i
         09gQg2o4ygy0iUXJFSy/kcG0E6Ns6KGpJzvpRbbX+XT/xmJ4xqq0PIPf5fI7dkl4fOZD
         cGsMwSUWIHdbNGCs589DTdlNxD429d4blQtQZSM/bf/cvUijca3Vo1ttpUHGW34WEFGs
         r2WcIrvk5aZgc0dAhwU6+Pjv4Y0em7CAGSnmNNyqob4HiExd4PotOwDBx+Yhg3pvLNzW
         LDxRt6K9fjX+x1jE1oAjMvq/CfHSTURMiA0XrFF6W/VV6nnNsI2p+0ymJIGwfVXyI9EG
         VGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772058615; x=1772663415;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qNO32L+dUVLvzhD1IJL17eYm4uw/4YT6fH+0CJPa/k=;
        b=dG58w/ngSmtcRM2CvpFiKpMxUeLyLMjmeeRUZiGvZ5vgVW3i5TMq7srQg2H2JCO/XD
         nNcW5mO6ZpNYLw176UcZagvVi1Pm4LB62ktago/gQX8XujYpYFU7+0WnUe2tfPwj14yY
         /WPpTY65smErJKLbRcZg/ZqVfN0D4vuMo3zlZ7v6xGp1+/zt40EGTGNyGb0AdMV7ha2x
         oLILLgTomcVN5bKmsfLGi6wLu525jDwoW4EB3g7Ej5obV6w5Ye/t/LUtBvjt5fGUKEUk
         BtDQ+PSqrhdwZhJx5qUBYzo7qqaTW3O6M2uSJHubezaku8YZOFTZyrHLR+uiXbvqK/UU
         5UvA==
X-Gm-Message-State: AOJu0YyLJENk2cqdU8hwUz1pbwsxr5Npf4JsGS65DOnDN7NBjXUUWGX/
	BQqId/Gq6D4EOqtVAYit3x2DQvuSRxa2s7dLPi6Z/AeHt9kH4ZNo9LwFuud8M6eb8XNtvQXxXuY
	Ht9bHHfCU+6b4t24imwTpZyzDLTjY85VpiavbXs7mGgLKlm53QG+K978=
X-Gm-Gg: ATEYQzzIxPOldWb8TMf+9BVwf3BsHTTR086nsAzuIfzMrYy+21GcPp0+pFxtrwVHXEp
	PSdG5siNpTmSjsJYywbEtNChg94vuR0M/Pn1ND27R7Q+UvGsV/G2iMtpdU3lS7NESJ6VAKntMZI
	tEW/UHirz6r4SQ6wuNv0ny4KYcM4Uniw634bUn2yfXhVJKus94DZoSLQZfD3aFwNUib6c/+ePY2
	xByv2P5md3WcspoLhNn2l9AzQoeVBN1L+mUgetfH+E0BPT0hZAFBvcXxBVduYNIogGGaR8VQR9v
	Gkz4pvGl
X-Received: by 2002:a05:690c:60c7:b0:797:d286:2cd with SMTP id
 00721157ae682-79828f2777fmr152683947b3.18.1772058615074; Wed, 25 Feb 2026
 14:30:15 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 26 Feb 2026 07:29:39 +0900
X-Gm-Features: AaiRm509nv2vxM5Go9eai_cWCY-WXFC7qWFGZiV2RbEb74aZE2jwdVb6FoNCWUM
Message-ID: <CAODzB9q3V0hOnEyYHC14ybeykBmNjVEX=e3c4H=jh2iOU9hqhg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 22:30:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21988

Hi!

It's this week's CVE report.

This week reported 0 new CVEs and 26 updated CVEs.

* New CVEs

No new CVEs.

* Updated CVEs

CVE-2022-50516: fs: dlm: fix invalid derefence of sb_lvbptr

stable/5.10 was fixed.

Fixed status
stable/5.10: [ef3033b435a6bac547166b793025578fab2f9df3]

CVE-2023-53424: clk: mediatek: fix of_iomap memory leak

stable/6.1 was fixed.

Fixed status
stable/6.1: [847d5dd788ce05f0aaaa36ea174f7f0b9cf86f7d]

CVE-2024-26822: smb: client: set correct id, uid and cruid for
multiuser automounts

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [4a6e4c56721a3e6e2550b72ec56aab306c4607a7]
stable/6.1: [2ceba8ae1bd1f5589548cb722a5c583ca3a2dede]

CVE-2024-57895: ksmbd: set ATTR_CTIME flags when setting mtime

stable/6.1 was fixed.

Fixed status
stable/6.1: [c7ab587bd33ce45e2aa6b6d2d36be7ef0bd16614]

CVE-2025-22026: nfsd: don't ignore the return code of svc_proc_register()

stable/6.1 was fixed.

Fixed status
stable/6.1: [51da899c209a9624e48be416bd30e7ed5cd6c3d8]

CVE-2025-23155: net: stmmac: Fix accessing freed irq affinity_hint

stable/6.1 was fixed.

Fixed status
stable/6.1: [2fbf67ddb8a0d0efc00d2df496a9843ec318d48b]

CVE-2025-37786: net: dsa: free routing table on probe failure

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [51df5513cca6349d0bea01bab95cd96cf869976e]
stable/6.1: [6c20894d21600ca1e8549086dfbb986e277bf8a6]

CVE-2025-37920: xsk: Fix race condition in AF_XDP generic RX path

stable/6.1 was fixed.

Fixed status
stable/6.1: [975b372313dc018b9bd6cc0d85d188787054b19e]

CVE-2025-38643: wifi: cfg80211: Add missing lock in cfg80211_check_and_end_cac()

stable/6.1 was fixed.

Fixed status
stable/6.1: [defe9ce121160788547e8e6ec4438ad8a14f40dd]

CVE-2025-39763: ACPI: APEI: send SIGBUS to current task if synchronous
memory error not recovered

stable/6.1 was fixed.

Fixed status
stable/6.1: [2fbc85da9ac9386bd89fcc94e0aadaea19d47784]

CVE-2025-40251: devlink: rate: Unset parent pointer in devl_rate_nodes_destroy

stable/6.1 was fixed.

Fixed status
stable/6.1: [90e51e20bcec9bff5b2421ce1bd95704764655f5]

CVE-2025-68358: btrfs: fix racy bitfield write in btrfs_clear_space_info_full()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [b0bb67385480a3aa4c54b139e4f371ddd06b5150]
stable/6.1: [55835646da78e83e7ad06abd741ca8fd8c0b0ea7]

CVE-2025-71144: mptcp: ensure context reset on disconnect()

stable/6.1 was fixed.

Fixed status
stable/6.1: [226fff52e7ed9fc8cd63327133739b3d92537ffd]

CVE-2025-71232: scsi: qla2xxx: Free sp in error path to fix system crash

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b410ab8b9431d6d63d04caa1d69909fcc8b25eae]
stable/5.15: [b74408de1f2264220979f0c6a5a9d5e50b5b534b]
stable/6.1: [8e7597b4efee6143439641bc6522f247d585e060]

CVE-2025-71233: PCI: endpoint: Avoid creating sub-groups asynchronously

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [fa9fb38f5fe9c80094c2138354d45cdc8d094d69]
stable/6.1: [5f609b3bffd4207cf9f2c9b41e1978457a5a1ea9]
stable/6.6: [8cb905eca73944089a0db01443c7628a9e87012d]

CVE-2025-71235: scsi: qla2xxx: Delay module unload while fabric scan in progress

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d8af012f92eee021c6ebb7093e65813c926c336b]
stable/5.15: [891f9969a29e9767a453cef4811c8d2472ccab49]
stable/6.1: [984dc1a51bf6fc3ca4e726abe790ec38952935d8]

CVE-2025-71236: scsi: qla2xxx: Validate sp before freeing associated memory

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [85c0890fea6baeba9c4ae6ae090182cbb1a93fb2]
stable/5.15: [a46f81c1e627437de436e517f5fd4b725c15a1e6]
stable/6.1: [044131fce27749cb6ea986baf861fbe63c6d8a17]

CVE-2025-71237: nilfs2: Fix potential block overflow that cause system hang

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6457d3ee41a4c15082ac49c5aa7fb933b4a043f3]
stable/5.15: [ba18e5f22f26aa4ef78bc3e81f639d1d4f3845e6]
stable/6.1: [2438982f635e6cc2009be68ba2efb2998727d8d4]

CVE-2026-23100: mm/hugetlb: fix hugetlb_pmd_shared()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [3a18b452dd5f7f1652c2e92f8ae769aa17a66c9e]
stable/6.6: [51dcf459845fd28f5a0d83d408a379b274ec5cc5]

CVE-2026-23169: mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [338d40bab283da2639780ee3e458fb61f1567d8c]
stable/6.1: [7896dbe990d56d5bb8097863b2645355633665eb]

CVE-2026-23220: ksmbd: fix infinite loop caused by
next_smb2_rcv_hdr_off reset in error paths

stable/6.1 was fixed.

Fixed status
stable/6.1: [fb3b66bd72deb5543addaefa67963b34fb163a7b]

CVE-2026-23221: bus: fsl-mc: fix use-after-free in driver_override_show()

stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.15: [c71dfb7833db7af652ee8f65011f14c97c47405d]
stable/6.1: [c424e72cfa67e7e1477035058a8a659f2c0ea637]
stable/6.12: [dd8ba8c0c3f3916d4ee1e3a09da9cd5caff5d227]
stable/6.6: [b1983840287303e0dfb401b1b6cecc5ea7471e90]

CVE-2026-23222: crypto: omap - Allocate OMAP_CRYPTO_FORCE_COPY
scatterlists correctly

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [953c81941b0ad373674656b8767c00234ebf17ac]
stable/5.15: [31aff96a41ae6f1f1687c065607875a27c364da8]
stable/6.1: [79f95b51d4278044013672c27519ae88d07013d8]

CVE-2026-23228: smb: server: fix leak of active_num_conn in
ksmbd_tcp_new_connection()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [6dd2645cf080a75be31fa66063c7332b291f46f0]
stable/6.1: [7ddd69cd1338c6197e1b6b19cec60d99c8633e4f]

CVE-2026-23229: crypto: virtio - Add spinlock protection with
virtqueue notification

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [552475d0b6cece73a52c0fa5faa0ce45e99df74b]
stable/5.15: [8ee8ccfd60bf17cbdab91069d324b5302f4f3a30]
stable/6.1: [c9e594194795c86ca753ad6ed64c2762e9309d0d]

CVE-2026-23230: smb: client: split cached_fid bitfields to avoid
shared-byte RMW races

stable/6.1 was fixed.

Fixed status
stable/6.1: [569fecc56bfe4df66f05734d67daef887746656b]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

