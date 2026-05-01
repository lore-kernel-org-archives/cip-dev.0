Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C89FFF886F
	for <webhook@archiver.kernel.org>; Fri,  1 May 2026 02:27:46 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6458.1777602462609821101
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Apr 2026 19:27:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=fGH7QdZY;
 spf=pass (domain: gmail.com, ip: 209.85.222.174, mailfrom: iwamatsu@gmail.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8eae9229110so252115685a.1
        for <cip-dev@lists.cip-project.org>; Thu, 30 Apr 2026 19:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777602461; cv=none;
        d=google.com; s=arc-20240605;
        b=JWNHL8cM9wQ8t4T/FdvC3X/6WX1CZWNn1hgm9lN8aduZHPCXTJtGDrb0D5HJ3RiC0/
         pzMkuzMS7WRWVNYp1x1Q1iWPzt4vzanvcPg7yqtiv83CB+nabJWCDuKFJEya5WKgwxWe
         M7aFzzSgYaFrf5kHTam8u++lpFwdLSRm2IYSoWvUOw8Qj90uFR7We5eC4AP55qeP6OVA
         UGvjC4HgIqVTE7wyaNbanh0w/cEN6+LOmWso/9MYlLUJFOh/1HF3l9XVMU3OLk5gUyie
         40Pdm4LThFwhmMp15+lpRJyxoVYQup+kJNs0i8SyJloI03LZrRmU46CY007rVdGGiVS6
         /DNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=PIMRHK8L306hKVWjp8yBl01XPCpjze6dzkE8ahfzD80=;
        fh=R1re4oGiqLrpPbOGkDxSnQphxRWRGB/tnIY+qQLbkao=;
        b=lJ98nm9kNekQmdZCBdXVd4haLgGCNm11eljctCga53UgYM87o9Zb2Baj2cARhpnIhM
         H3laof5W55t6DSePGrOKK3MptqY93nn8y1S47FTEJ7Sjl7JunpEtkaPNKnCprfGz42Qk
         xisnEHTp5JIT7o6Mayk4DcoOAgjtPq7JMpCFvz4nBHX+/V0vLBwg0+ne2tuqthsq7oj0
         CQISf2fdLLCXR3Xjz5RaGc5qhr327e0FEy4ZV6YMnyO9Y9IMtRpyHDN+vKxfNpEhEy+G
         CuZ2zegXn2E9YUi+6FEf0AgLLY2vki7Nf3JjKtbAnnvmYHVSujtMgV5JFckaYLLntDz7
         wKHA==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777602461; x=1778207261; darn=lists.cip-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PIMRHK8L306hKVWjp8yBl01XPCpjze6dzkE8ahfzD80=;
        b=fGH7QdZYsm8eu1qY//hs61uBXSyF/VStBLzcr9QgVQ4hjBjxnDb+eC9dqYQfkbi7ha
         V54BM+pBBHW1JfFG4XAK+I046GvupxNugD7yN3Y8xs5if6Fpq/9cp7D+lCxOA2vFxwLS
         ClVkDF6z+L5+H4gir0D0+Y/0Rarirl2UESoiFzY39UnFRlkxgrZU/WgaHxGK6ptp8hRk
         7iiHoQpBG8U1sQ2mxQM4s1BRWg8hw3qR//x/781CqF4XUSA4MeDQUAZNOSaQMEDagNWq
         8iSEwiK9wvFiaqpqc0XW0wPOGJNpdxcRziwiPI0VhGtpNTywyXl82CPwd6F17uJ5gfOp
         wbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777602461; x=1778207261;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIMRHK8L306hKVWjp8yBl01XPCpjze6dzkE8ahfzD80=;
        b=cP+srbxtd6J6Dv2KBOwhhv9o9VjhD3Ksm69pRU4pPHQmh87I3uOjLk6t0f0LjqnPsA
         QB9bh8rXzEvsnPGpkTlhDQG0a7IHET+GRAzimCL0TiEpZTwIw1GHqc+APiDx/14svUry
         1Sc9411l/wUbfh5aprwC+JbxStWdYZElfN28/pw1HTFsZ9p/a7ALL7DRHri4kTkcp93i
         xssnAt9AWx2UkXoCRvKdii6cOb13gkenO/t6Nho5L4B122DsLcwafvxzGhuEoJyHH6bN
         YXJvPtvU2EGNaWXtvLGRpvDhG9oJplZ3heVCMv9G/sAjdHfPBIhfhsip5fi+mbypuQqX
         V/tQ==
X-Gm-Message-State: AOJu0Yxlswpwt1EL6OR4XQ7XmuvHxzHchfWtncvtVwLG6Vz8WmnBH/Am
	i59rU3zHYlPcjI2bY4jIDXf7iIhAvxyTOAZkZyX5IOGNIXtXVy2ygDF59L9mPaZ6NjRYShi+qBj
	H+o5SZ6UUl9LMuCZ8vKsAfskqhWRKioNkHtc9
X-Gm-Gg: AeBDiesEjMHEX0VUW77ewrSIZJDBs9+T+FRrtOHnNxs+4of6KQW3ae2/wFapV5wJ2Iu
	+cutlaPjplVpuTycoF2LNb7ar71YrucYzcGUpqSZZaOKXBD2MPG2JxRZLk42LVyt6jHMnAJMNEO
	3OUD4FTy2DxF0CivGcbKcylZxsB79k1Ox42HvLBNvewLp5XJjA+S9zUxGqENWySoN59QKWWQvvi
	O9269hMPsft5MBI/eASf7ZFslooJpE/zmQcx3r9q3lgvTSg5l1eFA7RKpdqu2wdXxrQWSac/hre
	PS7TXdaAEVaFPVw=
X-Received: by 2002:a05:620a:a19a:20b0:8ee:b817:99fb with SMTP id
 af79cd13be357-8fa86db71famr630111485a.20.1777602461279; Thu, 30 Apr 2026
 19:27:41 -0700 (PDT)
MIME-Version: 1.0
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Fri, 1 May 2026 11:27:30 +0900
X-Gm-Features: AVHnY4L2cFGl8TS_GfHxb21uVpd_7pVmouM64EnBLzz80Btsqi9RmdNXNedP89o
Message-ID: <CACe6DC6=i5oQJyfyfSsWeTo85udWFvXGt0H3swwTVS6QCRcrRA@mail.gmail.com>
Subject: [ANNOUNCE] Release v6.1.170-cip55
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Pavel Machek <pavel@nabladev.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	masami.ichikawa@cybertrust.co.jp, 
	Chris Paterson <Chris.Paterson2@renesas.com>, uli@fpond.eu
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 May 2026 02:27:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22833

Hi all,

CIP kernel team has released Linux kernel v6.1.170-cip55.
The linux-6.1.y-cip tree has been updated base version from v6.1.169
to v6.1.170.
And this is early due to CVE-2026-31431.

Information about this release is as follows:

  v6.1.170-cip55:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      bac90ef5ad2977cd638758b0d1662cdec7253d71
    fixed CVEs:
      CVE-2026-31431: crypto: algif_aead - Revert to operating out-of-place
      CVE-2026-31786: Buffer overflow in drivers/xen/sys-hypervisor.c
      CVE-2026-31787: xen/privcmd: fix double free via VMA splitting
    added commits:
      CIP: Bump version suffix to -cip55 after merge from stable

Best regards,
  Nobuhiro


--
Nobuhiro Iwamatsu

