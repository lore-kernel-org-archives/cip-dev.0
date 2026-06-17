Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14817CD98ED
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 22:24:08 +0000 (UTC)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6875.1781735038477261241
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 15:23:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=sI0msuoZ;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.43, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-662bb8b1f93so272721d50.1
        for <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 15:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781735037; cv=none;
        d=google.com; s=arc-20240605;
        b=Spq4HLkHFOBiX5/ozZFnmr79WQQQe82S5/bbLziM1pa1OJpYwumDo6upq5myvNWXeN
         fNfkO4n+/sCFHMFc821TjqN0LipR6sme2XTS9dkIxsa6ESXErmwKP18yyk7Jtz1vcDFL
         a9CZdv6HGmm+4cKOLYH9cF969gXB5ICjiaJZnEIWCBlyJ5VpT+3alHlBC3HDg/ex3/Nn
         TehB/q8AHAFD5bu2NadCEiRfrQ8q1KfnocGaSa/oZqgFcSVqAUSZmpb0dA5MfkQoGSkK
         RgXex+WnNg+APKV7Jm1jt9ZYILiQ4T63BOYflcmfeG9Eb4M4GGogRqaxal93gunQPgtd
         6vhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=EX2+rkC7s0acGQ/c4u8LfpoXOc+PSEwiC3oPBH5u358=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=W0KoGC6feWBa8KE176GMyLMfFD3PHQyzzCgmUxbQV5S9xpcjoaGBGoPqJuwCKqtUlD
         w9s7eLM/pHKQTna4iI2k9IaQOcjUkTESHjCNXXvEvUxgU//YkESDLbVmrb3o+ieUuMth
         DSZdmTnBmQVPIqihM/13wNiVjt8HIGP1KFqWIP5wAWWbI4CaYvXCbwykpAfxLORuQboo
         PjmobvsR64etWMlgwlZTWyyAnBDT6lCK64ay2B2Ops45xa/DRXBAy+isUY0c3zxwLZ57
         p3KjC+5l95oO86oNpGDBDZnN3NXgMCGLOasIWcci7Yg8Fhu2+nfDibVueCY1CMsI7zbl
         KqTw==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1781735037; x=1782339837; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EX2+rkC7s0acGQ/c4u8LfpoXOc+PSEwiC3oPBH5u358=;
        b=sI0msuoZdOdJmQ1TrqXHY4B1JFjRAJyxj1j+Na2FFwL9cOlV7qB+3kXIZBgqEo/nE4
         XlbnsUa5IBDit8UiQHW53wSzLFbhRb3xRalaD+PKkfZ3AmtVmmfID9oQ3Yt1mx1n6YKC
         7uqFTC6P0WzkZGCDTmBx5BR+BEeY3yAXg+xg38JZrkJoSFk4FgAoYo5YU+wBeoxyEdtl
         ZEkCgge+gTsyVzOwbGTNNGWdYOXfiFBYQEY5FsuippJE0BvFgo/aZ1+su14AAK+eSH46
         negmYs+El2M+/mh4RlujCx39dMmF09pW2qoLl7eEHpFjC/fjTBTqScScukua72n72uQH
         Gi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781735037; x=1782339837;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EX2+rkC7s0acGQ/c4u8LfpoXOc+PSEwiC3oPBH5u358=;
        b=cFVWU+JVCJIG+Ma9IAScJhWnG/dYK7rGTDFpXASJXbYYvDAQtzAYld1Srr5VPuG9JJ
         WBDUpNPko7IA1UND6sv64fGR0ICpqeTX84rahUQ/5ik2SsWzZVxs/LuLKIPI/VfKKmwZ
         6rdcEHdJLHPNNtr2WEoj62guMy4+5xd6cYfTj7jkPsCDm/Agu4NO9cHTR/r5Vrpv8uzI
         27nJi53PL4K0ndr6psSy4f6mbU7sJACoX2GUWp54L8GhaTyHQh5HtUy8RaOWOD5o9fVf
         0BZbu3TuShikQ+7W6pXgxOVClbBQ5nxYkderiJ7gTeke2//Yd1lciL8zdbX9VN9HgiSK
         d97Q==
X-Gm-Message-State: AOJu0YxhlpzbgzlkSLXsJi+3lVW9C3kWIlYbXgc/E9+oNnV7bOuU9NUY
	O62EPAL6jn1CVdr8soAqDbY/6DPftL3N8vY03j0nk1nR4ufwplsVNMMJoJSk37AC49RMs0VmY7n
	wkMth6blwhi8O0zLG/e96MhwnV/lWOmrxJ+8YCzMy2nohEwD6L9HH3OUAoA==
X-Gm-Gg: AfdE7cm/tXe47FRxlrul3YKYzeEKf9PtyaXVsY7w0ddoic6NklQIYir+66drSoeQpLX
	Au3KEQAZzEXtiy5c6oWraQtwRj1CON3fsJyqD9pSbSRYGhnNHpUXVgjJmuLxuvoa5kBYZgdm7Ct
	ms86WLIPxZHXFU3t46BUXVimf2uOz+Ugkspwca3GwQ08gWmh4thlOK6OoM+Je1jnJsGIm0xTC9c
	9iHkDZEXHvUBt0+QbYtqqaXgF7ZnEDUOnoL5bz7HhQHRLw/UmUlfjsDVTtzfmq81cVi0rXMFw==
X-Received: by 2002:a53:d00a:0:b0:650:1bf0:ca62 with SMTP id
 956f58d0204a3-662cd4b1134mr5065491d50.6.1781735037351; Wed, 17 Jun 2026
 15:23:57 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 18 Jun 2026 07:23:21 +0900
X-Gm-Features: AVVi8CfmFC1wFKieqo7RCAYxGAIK46daxYfoxQ2HeaVNir63q0b0IKYQ2dXTGA8
Message-ID: <CAODzB9qUTw5TzwkbDd7aXXJkN+3SH4Y4cr+RLzTF5S1fje0pSQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 22:24:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23217

Hi!

It's this week's CVE report.

This week reported 1 new CVEs and 0 updated CVEs.

* New CVEs
CVE-2026-46331: net/sched: fix pedit partial COW leading to page cache
corruption

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46331

Introduced by commit 8b79647 ("net/sched: act_pedit: really ensure the
skb is writable") in v5.18-rc7.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [899ee91156e57784090c5565e4f31bd7dbffbc5a]

* Updated CVEs

No updated CVEs.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

