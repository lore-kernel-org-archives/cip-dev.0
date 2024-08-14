Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7B2C52D7D
	for <webhook@archiver.kernel.org>; Wed, 14 Aug 2024 22:51:44 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
 by mx.groups.io with SMTP id smtpd.web10.111144.1723675896175325295
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Aug 2024 15:51:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=0o3r9KfR;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.54, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5d5f24d9df8so239527eaf.2
        for <cip-dev@lists.cip-project.org>; Wed, 14 Aug 2024 15:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1723675895; x=1724280695; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5UmRmdBq8ZYAn4cWi6efxOl+UZQcoa4qBhR82VOA4NE=;
        b=0o3r9KfRIUGjtN+QOP631H82iWd1cCVvPtJU5y9txdVGUQ4xikdqfQdRBqmBpLzVes
         c5kF+AOM1NBbhHQ/9m9P3NF53zTy0vZlo7QYSug6WjpqI7J+7/bq/Y7Qg052RoJezYl8
         /c2kvcXl1KMdPctWF2SX21q9XejNzuDYnCSKvLcoPytF1ZuNYWMldk85u1r3/yB1Q+f9
         Gn+LypBiF4+QC7sMhn2oVv1T/49GQpdFNkKA6+Rca7ZqGTlqBukpww8/C5Owib3Kyxi6
         TR29RLRn/lfIVxZoplrR9IXLtFrXr0F5bL00T9tgY+uT7Kme6uVk+Tj9pNW1agioxZ1t
         f7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723675895; x=1724280695;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5UmRmdBq8ZYAn4cWi6efxOl+UZQcoa4qBhR82VOA4NE=;
        b=ao14Ka4Y1XMnLGTvXxxPP2ONBNstf2+TMjcfpzsE+BwyqU9CEZ7V6wx7wKs/t9GoE4
         +xBPyYuFOUxLACJ8Gy804fEUFbjrEwum8Rm+WbC8Ecvz/MofSgGHWK0alRD+CX++j2Om
         g2foqDxdVYs1JYujUmpNooMlMgqQAtIKZ/SqRCFvLtfmOJgzSlCxpOjn3tJ8Tdnrtrdw
         q3yA2fUHZeJpad5ZRJIvszq8/Fdq1vJMsM4aiEdGQEdvpmsU+4u2FlWkmQRHZkAFaDsa
         PuJpe3ZCPpwOmn5HGNiNP1DlY8QzPWYBrDeI1mXMleqsmqNYoUzEhTLHJfQBmXBt3JcL
         YlOA==
X-Gm-Message-State: AOJu0YwPQ+CqL0eI0ytARUgttOwBC21HixoPzEXj11175IGdFmzu34RY
	KizeMIeUjEOna0kAF6n9DR+CVE7iIucgVwk8c839nSo8RupoR2Cc3sy4yOH65D65QhMIgkl0YPG
	QLbBTmhfZaEzeFAmyGeAcURPT+BqOgT+eX8qkXoVoYmraJN3CpVw=
X-Google-Smtp-Source: AGHT+IGuh/Q/XyWa0HCLjtLTiY6yDhI4J0hJ5D4qnYxn59CdVWLwLtj4V1fC3vytM6HtLpzslxkoYFJs0jqzKbebJPQ=
X-Received: by 2002:a05:6820:60c:b0:5c4:57d:691e with SMTP id
 006d021491bc7-5da7c68f3acmr5564071eaf.2.1723675894965; Wed, 14 Aug 2024
 15:51:34 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 15 Aug 2024 07:50:58 +0900
Message-ID: <CAODzB9r0+B=YgU2Wp4oEiiLzFa2oAVPKdD=dOqDQ8Kd=UgaMzA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Aug 2024 22:51:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16788

Hi!

It's this week's CVE report.

This week reported 9 new CVEs and 4 updated CVEs.

* New CVEs
CVE-2024-42251: mm: page_ref: remove folio_try_get_rcu()

Announce: https://lore.kernel.org/linux-cve-announce/2024080832-CVE-2024-42251-6848@gregkh/

Introduced by commit 57edfcf ("mm/gup: accelerate thp gup even for
"pages != NULL"") in v6.6-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa2690af573dfefb47ba6eef888797a64b6b5f3c]
stable/6.6: [16380f52b72166d6a33b508cc2509716f436253f]

CVE-2024-42252: closures: Change BUG_ON() to WARN_ON()

Announce: https://lore.kernel.org/linux-cve-announce/2024080835-CVE-2024-42252-f46f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc5.
It looks as if this bug was introduced by commit cafe56359 ("bcache:
A block layer cache") in 3.10-rc1.

Fixed status
mainline: [339b84ab6b1d66900c27bd999271cb2ae40ce812]

CVE-2024-42253: gpio: pca953x: fix pca953x_irq_bus_sync_unlock race

Announce: https://lore.kernel.org/linux-cve-announce/2024080835-CVE-2024-42253-0c21@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc6.

Fixed status
mainline: [bfc6444b57dc7186b6acc964705d7516cbaf3904]
stable/6.1: [58a5c93bd1a6e949267400080f07e57ffe05ec34]
stable/6.6: [e2ecdddca80dd845df42376e4b0197fe97018ba2]

CVE-2024-42254: io_uring: fix error pbuf checking

Announce: https://lore.kernel.org/linux-cve-announce/2024080819-CVE-2024-42254-7566@gregkh/

Introduced by commit 87585b0 ("io_uring/kbuf: use vm_insert_pages()
for mmap'ed pbuf ring") in v6.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bcc87d978b834c298bbdd9c52454c5d0a946e97e]

CVE-2024-42255: tpm: Use auth only after NULL check in
tpm_buf_check_hmac_response()

Announce: https://lore.kernel.org/linux-cve-announce/2024080819-CVE-2024-42255-b73c@gregkh/

Introduced by commit 7ca110f ("tpm: Address !chip->auth in
tpm_buf_append_hmac_session*()") in v6.10-rc7.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dc357d343f134bf59815ff6098b93503ec8a23b]

CVE-2024-42256: cifs: Fix server re-repick on subrequest retry

Announce: https://lore.kernel.org/linux-cve-announce/2024080820-CVE-2024-42256-afbb@gregkh/

Introduced by commit 3ee1a1f ("cifs: Cut over to using netfslib") in v6.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de40579b903883274fe203865f29d66b168b7236]

CVE-2024-42257: ext4: use memtostr_pad() for s_volume_name

Announce: https://lore.kernel.org/linux-cve-announce/2024080839-CVE-2024-42257-8823@gregkh/

Introduced by commit 744a563 ("ext4: replace deprecated strncpy with
alternatives") in v6.10-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be27cd64461c45a6088a91a04eba5cd44e1767ef]

CVE-2024-42258: mm: huge_memory: use !CONFIG_64BIT to relax huge page
alignment on 32 bit machines

Announce: https://lore.kernel.org/linux-cve-announce/2024081216-CVE-2024-42258-e3f3@gregkh/

Introduced by commit 4ef9ad1 ("mm: huge_memory: don't force huge page
alignment on 32 bit") in v6.8-rc3.
Fixed in v6.11-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [d9592025000b3cf26c742f3505da7b83aedc26d5]
stable/6.1: [89f2914dd4b47d2fad3deef0d700f9526d98d11f]
stable/6.6: [a5c399fe433a115e9d3693169b5f357f3194af0a]

CVE-2024-42259: drm/i915/gem: Fix Virtual Memory mapping boundaries calculation

Announce: https://lore.kernel.org/linux-cve-announce/2024081452-CVE-2024-42259-4cef@gregkh/

Introduced by commit c58305a ("drm/i915: Use remap_io_mapping() to
prefault all PTE in a single pass") in v4.9-rc1.
Fixed in v6.11-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bdd9ef7e9b1b2a73e394712b72b22055e0e26c3]
stable/6.6: [4b09513ce93b3dcb590baaaff2ce96f2d098312d]

* Updated CVEs

CVE-2024-35894: mptcp: prevent BPF accessing lowat from a subflow socket.

stable/6.6 was fixed.

Fixed status
mainline: [fcf4692fa39e86a590c14a4af2de704e1d20a3b5]
stable/6.6: [ee3c845787b621cfe82c2e52c513024a9d7a78f5]
stable/6.8: [3ffb1ab698376f09cc33101c07c1be229389fe29]

CVE-2024-26621: mm: huge_memory: don't force huge page alignment on 32 bit

stable/6.6 was fixed.

Fixed status
stable/6.1: [87632bc9ecff5ded93433bc0fca428019bdd1cfe]
stable/6.6: [6ea9aa8d97e6563676094cb35755884173269555]
stable/6.7: [7432376c913381c5f24d373a87ff629bbde94b47]

CVE-2024-39472: xfs: fix log recovery buffer allocation for the legacy
h_size fixup

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [57835c0e7152e36b03875dd6c56dfeed685c1b1f]
stable/6.6: [c2389c074973aa94e34992e7f66dac0de37595b5]

CVE-2024-41042: netfilter: nf_tables: prefer nft_chain_validate

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [b6b6e430470e1c3c5513311cb35a15a205595abe]
stable/6.10: [cff3bd012a9512ac5ed858d38e6ed65f6391008c]
stable/6.6: [717c91c6ed73e248de6a15bc53adefb81446c9d0]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

