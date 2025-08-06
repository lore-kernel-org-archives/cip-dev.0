Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C050EC87FD3
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 22:03:25 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
 by mx.groups.io with SMTP id smtpd.web11.37444.1754517798373612686
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 15:03:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=CpIzHKw2;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.173, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71a4742d81aso3427307b3.2
        for <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 15:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1754517797; x=1755122597; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fQJcfRftohyDGrJ9UXuims9qODrOHFFBv2a/7USl3ZA=;
        b=CpIzHKw2MYupz3FgEsDdg/FhFhAYjCfs1tZ8ou6Ojz9jYh1sSv1QE3nwGlP88Mg2Hl
         oIl0Xlr4Y9bLgS9ifggilgjXgURRzdyS2d/fPXupqfTdP9pn+tzcklSi59CpLuidHAY6
         ZXsIfpdzwOSzZR8MG1KbNTRkF3nopQ7kHJWKncS3o2FirH2nHMWipj3x+xa0eDf7TnYn
         rJ3GEF7TVBvJSqj0qhURAWYdkvUZm631aOVR+Ca0y3xMDhN+8PeF1Kb1WMo/D7l6kHpc
         rVagKc3SxHB+njZ8felMrlIg0NSsx/rHXVKNCEjjKWipWTTQ43fGmZR3gnZpHiLWnV/C
         VtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517797; x=1755122597;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQJcfRftohyDGrJ9UXuims9qODrOHFFBv2a/7USl3ZA=;
        b=onVd0J6qmuMFrVrrr14undIwvH9/ZuoTDse/YsW05OiphE5TmSnweGoTl6Yd6hzd//
         kg7Vil+MTsglhE2gZeTKvZjCYueRUJiiM+B2a0CM8t0rYTOt4Ca9FVqwSwlz0dzGn4iB
         PW/6qZZ84JE41liYORje43vYK9MewlRUIHWqScyr0pmofXBotCrqsG1FLkgqhiKp6sEJ
         YcAp8uSLZ/EB2bPFGEUHohRM/HLQe5BYCzUvoT6/JQcNoretG845QKBCCTOBA5mBnSo6
         SExEX4/AzgoQcMuPY05pgCDdteUVkpJrAKoKbCLTmEPAnPIsgyqMdm1NR/dkRTclgt5e
         lmEA==
X-Gm-Message-State: AOJu0YyG0ys5rrRDsCQPDhOc02lMDKzRakAQqsBPGv6dx5y8Q8DkOglH
	1uhiSC7zqZCi3SdB75jtTXm7bChFc9nPFXJAcB6bKTbyLY/Xx9QMP5jjpbbSpYPrxEo/dja02gP
	r+wcweQKW1UC/YCaoqMUwxifzgM0cZ/Wdzxp5eJKDD/PNEwyGZpq8B/c=
X-Gm-Gg: ASbGncsEKOrrJ85LkYPx+AiQbHmG5JHL2kC+xxpoJJJlnPKP8Ngxsd9EP/q7YtHqoYV
	AJQQRjfG7fqMcngQ50lBKB9EcdYGQBgmohXb8az7rlnZCKOloTVb+ZQ75hYdC4r+Bhi5iplCNQC
	9V92tv04sHgZoHAsM057RK0xSI5wYgvbApTtL3ayGxR+aJziGYBU7dt+Pos+klMBYiOg2kYqV3L
	c6vFEme
X-Google-Smtp-Source: AGHT+IEicKcJcL+zblP+vcUY+lwsFevP0l5WSXJxSSEd5hrXKNa1kZVUEMPnxu/wwcubzm0KDk42IYwgK/m+zsp0M9A=
X-Received: by 2002:a05:690c:e1e:b0:71a:403d:1aac with SMTP id
 00721157ae682-71bcc88e7e5mr56791187b3.31.1754517797174; Wed, 06 Aug 2025
 15:03:17 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 7 Aug 2025 07:02:40 +0900
X-Gm-Features: Ac12FXzk2cfEqbTK-iv66RDFyIOZ7pHnQSfcN7nfcR5nYo0pDOlCAKNFkSNl9bw
Message-ID: <CAODzB9r4o84OUkoFepZzX0u9YMK-pbVXitP_iiz1bd8vO_=w8w@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 22:03:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19697

Hi!

It's this week's CVE report.

This week reported 4 new CVEs and 8 updated CVEs.

* New CVEs
CVE-2023-32251: ksmbd: block asynchronous requests when making a delay
on session setup

Announce: https://www.cve.org/CVERecord?id=CVE-2023-32251

The 5 seconds delay was added by 621be84 ("ksmbd: throttle session setup
failures to avoid dictionary attacks") in 5.15-rc7
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b096d97f47326b1e2dbdef1c91fab69ffda54d17]
stable/5.15: [dff87902d96082e6e271385b14adda8f65fc3e03]
stable/6.1: [502cf9709036d9305495876fa8c33c8a52541b15]

CVE-2023-32256: ksmbd: fix racy issue from smb2 close and logoff with
multichannel

Announce: https://www.cve.org/CVERecord?id=CVE-2023-32256

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abcc506a9a71976a8b4c9bf3ee6efd13229c1e19]
stable/5.15: [ae06b798f72d6cc792cfa1745490be65da90eb03]
stable/6.1: [4aba9ab6a007e41182454f84f95c0bddf7d6d7e1]

CVE-2023-32253: ksmbd: fix deadlock in ksmbd_find_crypto_ctx()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-32253

It looks as if this bug was introduced by e2f3448 ("cifsd: add
server-side procedures for SMB3") in 5.15-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b4323373d844954bb76e0e9f39c4e5fc785fa7b]
stable/5.15: [4f9baa06674910876ce3e0b5fbe23214690d731d]
stable/6.1: [18973b73fa5177b5ac3c0eb81d2fe093452ecaa9]

CVE-2023-32255: ksmbd: fix memleak in session setup

Announce: https://www.cve.org/CVERecord?id=CVE-2023-32255

It looks as if this bug was introduced by e2f3448 ("cifsd: add
server-side procedures for SMB3") in 5.15-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d7cb549c2ca20e1f07593f15e936fd54b763028]
stable/5.15: [671f21fbcb47517448dd519389a21989063a5847]
stable/6.1: [c3a3259675a6c9626bb9fbd2d84f15bae16ffed4]

* Updated CVEs

CVE-2025-37777: ksmbd: fix use-after-free in __smb2_lease_break_noti()

stable/6.6 was fixed.

Fixed status
stable/6.6: [1da8bd9a10ecd718692732294d15fd801c0eabb5]

CVE-2025-37925: jfs: reject on-disk inodes of an unsupported type

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [28419a4f3a1eeee33472a1b3856ae62aaa5a649b]
stable/6.6: [45fd8421081ec79e661e5f3ead2934fdbddb4287]

CVE-2025-38221: ext4: fix out of bounds punch offset

stable/6.12 was fixed.

Fixed status
stable/6.12: [a4d60ba277ecd8a98c5a593cbc0ef2237c20a541]

CVE-2025-38322: perf/x86/intel: Fix crash in icl_update_topdown_event()

stable/6.6 was fixed.

Fixed status
stable/6.6: [79e2dd573116d3338507c311460da9669095c94d]

CVE-2025-38325: ksmbd: add free_transport ops in ksmbd connection

stable/6.6 was fixed.

Fixed status
stable/6.6: [52f5a52dc17a4a7b4363ac03fe2c4ef26f020dc6]

CVE-2025-38335: Input: gpio-keys - fix a sleep while atomic with PREEMPT_RT

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [a7b79db25846459de63ca8974268f0c41c734c4b]
stable/6.6: [fa53beab4740c4e5fe969f218a379f9558be33dc]

CVE-2025-38351: KVM: x86/hyper-v: Skip non-canonical addresses during
PV TLB flush

stable/6.12 was fixed.

Fixed status
stable/6.12: [f1b3ad11ec11c88ba9f79a73d27d4cda3f80fb24]

CVE-2025-38491: mptcp: make fallback action and fallback decision atomic

stable/6.6 was fixed.

Fixed status
stable/6.6: [75a4c9ab8a7af0d76b31ccd1188ed178c38b35d2]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

