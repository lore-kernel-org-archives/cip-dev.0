Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1BBC71135
	for <webhook@archiver.kernel.org>; Wed, 11 Jun 2025 22:07:29 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
 by mx.groups.io with SMTP id smtpd.web10.7732.1749679645712862483
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Jun 2025 15:07:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=grCIetml;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.182, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e81a6da56b2so204572276.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Jun 2025 15:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1749679645; x=1750284445; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0hZ5+ey9al7dXJq0HlDVKzewdGwzVp44Itg/s3Fa8JE=;
        b=grCIetml+oup2XeHX+Ot/NSrNi5hNETfNMz2vLgO2vmJbDlZPzY+DlVBp1gmPXEQZM
         TSIs0dron2qSJQ7Pqr6KK0ByY4BXB93gOPFOLb16YjLgyCUXOeesnQ418NX+nhKrSCay
         jZFlOIhP6Cvt/4nA7+YE1Q3KJmzoWeu1t36VbROy51kjN9aM6SgpNpJgHukfhfuQl/k0
         iZRJTH6JqFYlC/HRQevcOZxRy/ANyTWcqeWuuE0ni1k0nJmdxkaK9e9Plv7bO69A844m
         j8SNtr32/00Fv9KLu69UYPLsNqDXlwuZe2AB1uaYKPE1QzHiUU5erdlcbjV72nNKKl3s
         65hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749679645; x=1750284445;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hZ5+ey9al7dXJq0HlDVKzewdGwzVp44Itg/s3Fa8JE=;
        b=gqKfRe7z9W6Wwg7L1IlhIlyxKFnMJYnY4GiNp93Vxvl9nW5srCutTFWh+uAuHfCxl5
         sM1xR3uHVxd3tC8q3tVngmMCGkCtfxN+hLblETLUDDB1oU9XY9E3Fj7snMjonmzQ4/ey
         1TdAUHuubfaN3/CQR7evOu6qZd1cOX8mr3gncErKuyluQEJOGVAXeJrvVCQSrg7bPPp3
         mKZH8iim4HTUFYBSycnAqoIRZCqPYbpmFfSzR7uStomBahhrj6q5TQbpU/bMXvKkucEB
         NRmud05QY+CLsdBnrtA8sql31ZeaR7dVpNOPCRunI6KKdJLRhKHOz+YwkaPKFpiPKdMO
         G6FQ==
X-Gm-Message-State: AOJu0YxRihPfSI0LJO0h+03ZnWEDaTXqhHcbLko6AZVXfa0ia8gk3hju
	QjM4VicnKoBORJ8rr+sYa0BEjxaMMyN6J4OS3GsHz8hCp3zs/tWKVxaM11I8bs2i0XgPCWJ5Q3v
	DD+jImsUkZnnoXvjHuERapZm0aPXS5H1jFqpM1U0dvzQbryv8y8qfkQ8=
X-Gm-Gg: ASbGncsvMjxaS223SsFwfV3VmOfeoGnuwc8ihquQwDzoX6kzKOelDGq6N5+qTuw32g6
	bqNCoe6HtwGdkpfW+9IegcgjaB03L4fj9FP6jZK50QTwHXKQTguCkN/W4ZFIVk7O+fT6p/+x4ln
	+HNnyW1P+sA7bOSTbbuDzZTkrMfu76/TqVK8Kh3mYa2hLYOLaudalCO7g=
X-Google-Smtp-Source: AGHT+IHrj/mBCAZ881VG58BmfQ5UKwtsXZNFYoKwqueOt+t3ayR7zI9zrtUz2GJx3x+Jz1af9n6Xkq0IuzjN4ajJlXA=
X-Received: by 2002:a05:690c:690a:b0:70d:ed5d:b4b2 with SMTP id
 00721157ae682-7115098f4b6mr14488527b3.13.1749679644523; Wed, 11 Jun 2025
 15:07:24 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 12 Jun 2025 07:06:48 +0900
X-Gm-Features: AX0GCFuXUUbYv_KS-50KbLJIQR5iQCAgqlezG7f_CZSbl6B2yDSK7Fx2zRKa9C0
Message-ID: <CAODzB9oho334Pt+7DSr1YPoftCaxiM3KWmCzEKcM3QTc=eP2SQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Jun 2025 22:07:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19035

Hi!

It's this week's CVE report.

This week reported 5 new CVEs and 2 updated CVEs.

* New CVEs
CVE-2025-38000: sch_hfsc: Fix qlen accounting bug when using peek in
hfsc_enqueue()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38000

Introduced by commit 12d0ad3 ("net/sched/sch_hfsc.c: handle corner
cases where head may change invalidating calculated deadline") in
v4.8-rc1.
Fixed in v6.15.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f981138109f63232a5fb7165938d4c945cc1b9d]
stable/5.10: [f9f593e34d2fb67644372c8f7b033bdc622ad228]
stable/5.15: [89c301e929a0db14ebd94b4d97764ce1d6981653]
stable/5.4: [1034e3310752e8675e313f7271b348914008719a]
stable/6.1: [f1dde3eb17dc1b8bd07aed00004b1e05fc87a3d4]
stable/6.12: [49b21795b8e5654a7df3d910a12e1060da4c04cf]
stable/6.6: [93c276942e75de0e5bc91576300d292e968f5a02]

CVE-2025-38001: net_sched: hfsc: Address reentrant enqueue adding
class to eltree twice

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38001

Introduced by commit 37d9cf1 ("sched: Fix detection of empty queues in
child qdiscs")
in 5.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac9fe7dd8e730a103ae4481147395cc73492d786]
stable/5.10: [6672e6c00810056acaac019fe26cdc26fee8a66c]
stable/5.15: [2c928b3a0b04a431ffcd6c8b7d88a267124a3a28]
stable/5.4: [e5bee633cc276410337d54b99f77fbc1ad8801e5]
stable/6.1: [a0ec22fa20b252edbe070a9de8501eef63c17ef5]
stable/6.12: [2f2190ce4ca972051cac6a8d7937448f8cb9673c]
stable/6.6: [295f7c579b07b5b7cf2dffe485f71cc2f27647cb]

CVE-2025-38002: io_uring/fdinfo: grab ctx->uring_lock around
io_uring_show_fdinfo()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38002

Introduced by commit 79cfe9e ("io_uring/register: add
IORING_REGISTER_RESIZE_RINGS") in v6.13-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d871198ee431d90f5308d53998c1ba1d5db5619a]

CVE-2025-38003: can: bcm: add missing rcu read protection for procfs content

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38003

Introduced by commit f1b4e32 ("can: bcm: use call_rcu() instead of
costly synchronize_rcu()") in v5.19-rc6.
Fixed in v6.15.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
mainline: [dac5e6249159ac255dad9781793dbe5908ac9ddb]
stable/5.10: [659701c0b954ccdb4a916a4ad59bbc16e726d42c]
stable/5.15: [0622846db728a5332b917c797c733e202c4620ae]
stable/5.4: [19f553a1ddf260da6570ed8f8d91a8c87f49b63a]
stable/6.1: [6d7d458c41b98a5c1670cbd36f2923c37de51cf5]
stable/6.12: [63567ecd99a24495208dc860d50fb17440043006]
stable/6.6: [1f912f8484e9c4396378c39460bbea0af681f319]

CVE-2025-38004: can: bcm: add locking for bcm_op runtime updates

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38004

Introduced by commit ffd980f ("[CAN]: Add broadcast manager (bcm)
protocol") in v2.6.25-rc1.
Fixed in v6.15.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2aba69d0c36a496ab4f2e81e9c2b271f2693fd7]
stable/5.10: [7595de7bc56e0e52b74e56c90f7e247bf626d628]
stable/5.15: [fbd8fdc2b218e979cfe422b139b8f74c12419d1f]
stable/5.4: [8f1c022541bf5a923c8d6fa483112c15250f30a4]
stable/6.1: [2a437b86ac5a9893c902f30ef66815bf13587bf6]
stable/6.12: [cc55dd28c20a6611e30596019b3b2f636819a4c0]
stable/6.6: [76c84c3728178b2d38d5604e399dfe8b0752645e]


* Updated CVEs

CVE-2025-22122: block: fix adding folio to bio

stable/6.12 was fixed.

Fixed status
stable/6.12: [0c60158ff14df04c92792dd9b1809372b095040f]
stable/6.14: [b96e0af1b1c99cb7e6188b6fa4963a4e47beb01e]

CVE-2025-22123: f2fs: fix to avoid accessing uninitialized curseg

stable/6.12 was fixed.

Fixed status
stable/6.12: [bf49527089ec1ba894c6e587affabbfb2329f52e]
stable/6.14: [7f90e5d423cd2d4c74b2abb527872f335108637f]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

