Return-Path: <iwamatsu@nigauri.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7CDC10DCE
	for <webhook@archiver.kernel.org>; Fri,  1 Dec 2023 20:43:50 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.3699.1701463425751911219
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Dec 2023 12:43:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nigauri-org.20230601.gappssmtp.com header.s=20230601 header.b=oqAdS8Oo;
 spf=none, err=permanent DNS error (domain: nigauri.org, ip: 209.85.208.52, mailfrom: iwamatsu@nigauri.org)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-54af4f2838dso3098778a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 01 Dec 2023 12:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1701463424; x=1702068224; darn=lists.cip-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2LiKdsuW8pRKOjFrpcibTIF9FE2izwy4daB+H4JYnY8=;
        b=oqAdS8OoO+3gnnweRrVq9R1slijOByG1SK3NS07361y5oAS06tRbdQXkwjXZpswHDQ
         j4A3Mc9ZCwJfDvjtKWLGOqx0ZXmEwXs718KF+8j3U5stAfYE6lEZfewoiYYEd6F+sGAp
         36tBDSy42jexhthOwO6XCJ7SrDIrtwgkjYRp8DaDSFYZMO/UgJMg5CK7dNVGGfbnZ2tQ
         kvNDTnqaNwhvNKDbsZuEU1M17OqQsuvAEPXEsPFDV+RKo1/jp9VytOLDMwdX+3fnCv5R
         azmavor89E4LJ47HT2rphbXMTxGkYG/7E+7rbKg8rhACxZ829KN9UALXfGKfl5be85CN
         mhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701463424; x=1702068224;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2LiKdsuW8pRKOjFrpcibTIF9FE2izwy4daB+H4JYnY8=;
        b=ME3ANjJcBmAr94mL/dtjSHoLZhJ8IiOszJJ+uI9ffN/KLuqyBHXSdiyxGwNstMrZmt
         9AV5xC6fVhm+lPcFGNeCS4ZaJVvVwipTb1C91TVw52C9dR6HF8L1a6OtTiCzd9ZBxMRm
         zjNOFuk5ZuTtb13/H7uSTH3toNgqN/kqwZVaIXwhjr++wiGCqafCAMYXZXV9EahRx1X2
         XItuCTpAr2N1GAtQV5pl/6ib9qLsdIb281ftG2UrI31dvL8RGyCGbUnxCkZ3O3wt+E3T
         9KvpQbU9uaaKUIq7RvNkoPVouN+qXcd9f9CHlrTaTuuLwhtaLIreEfTFcGf+gJxmcVl5
         dU0A==
X-Gm-Message-State: AOJu0YwvcoG+wkPgpodLCh5pf5bhry1ncUu5NwCtGQ6ArZcm015YaDBf
	K2I3/8vQ7WW13liMo3WuN6+m2V9LO1aL7ICD6bZwKxGtmb79e9kj8g==
X-Google-Smtp-Source: AGHT+IHvZq9a+bx9GZ6YiFvTv8S8ZT4OQJ/9IMDC7COS/mrUJReH0rtMOqO5ZvUBz/E0PUVeNyXfI9HxOm7s7OH0H+g=
X-Received: by 2002:a17:906:714:b0:a14:d6e2:fb1f with SMTP id
 y20-20020a170906071400b00a14d6e2fb1fmr1216726ejb.10.1701463423266; Fri, 01
 Dec 2023 12:43:43 -0800 (PST)
MIME-Version: 1.0
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Sat, 2 Dec 2023 05:43:16 +0900
Message-ID: <CABMQnVKJPjmZBeNrr=faDPcwM7Z6YkB8ewJ9PtX31LXYPf0Gcg@mail.gmail.com>
Subject: [ANNOUNCE] Release v6.1.64-cip10
To: cip-dev@lists.cip-project.org
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, Chris Paterson <Chris.Paterson2@renesas.com>, 
	Pavel Machek <pavel@denx.de>, uli@fpond.eu, masami.ichikawa@cybertrust.co.jp
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Dec 2023 20:43:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13768

Hi all,

CIP kernel team has released Linux kernel v6.1.64-cip10.
The linux-6.1.y-cip tree has been updated base version from v6.1.62 to v6.1.64.
This release also applies clock driver (versa3) fixes for the Renesas arm64 SoC.

You can get this release via the git tree at:

  v6.1.64-cip10:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      6eab166db6d4f9b10eb2993de0fcd289a09024bd
    Fixed CVEs:
      CVE-2023-6111: netfilter: nf_tables: remove catchall element in
GC sync path
    added commits:
      CIP: Bump version suffix to -cip10 after merge from stable
      arm64: dts: renesas: rz-smarc: Use versa3 clk for audio mclk
      clk: vc3: Make vc3_clk_mux enum values based on vc3_clk enum
      clk: vc3: Fix output clock mapping
      clk: vc3: Fix 64 by 64 division
      clk: Add support for versa3 clock driver
      clk: Introduce clk_hw_determine_rate_no_reparent()
      clk: Move no reparent case into a separate function
      dt-bindings: clock: versaclock3: Add description for #clock-cells property
      dt-bindings: clock: Add Renesas versa3 clock generator bindings
      dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs
      dt-bindings: timer: renesas,rz-mtu3: Improve documentation
      dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow
interrupt names

Best regards,
   Nobuhiro

Nobuhiro Iwamatsu (Toshiba)

