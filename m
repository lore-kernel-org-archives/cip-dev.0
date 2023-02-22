Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBC5C636D6
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 23:34:33 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.web10.2908.1677108870388644691
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Feb 2023 15:34:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=WUEAHTsE;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.177, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f177.google.com with SMTP id bi17so9691447oib.3
        for <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 15:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0/1coMypE5BzRBeNIjLhUxCdyjV1vTsTxJzPwA5x+Xk=;
        b=WUEAHTsE9e0bXhI4S3+CraQ9SDG+Uypef8u8vMKQbLuL8bQABbk77Y6Ifc3RDQR/t3
         wPivakobKGQzavYQMrv4NtWGDqOK7KNg8IlLRJmBT5C/fzK3KEajHG7mmwxIjQm0L44B
         797GwI52emXuUHzlSFi4sAXH3iQPyF+MA+DOqtx+bRbFXYZXwvQZHJ6hqXuHBSFuaWl2
         P3HuJqe5uYxZlh74PSkzlC1OJpho/y/uY8qhx7Z19dnr/5b8I7J9IyEKz5doQMoHMkC1
         hbT5MLOC9xhy4PF5VU1QJBu4aVkum43cMKTOcZu5GOjl5EA6OMJvtNhUyf55JV3p2v8D
         FOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/1coMypE5BzRBeNIjLhUxCdyjV1vTsTxJzPwA5x+Xk=;
        b=mvQrbo+X7hGUUAy3u9JYwYM4FwmszuIBAJ6b6+R1VzoO+NK/mWng/syZZzO9oNEXqI
         FUi6oOXhUCqMdlAHpd1RfzA6j/lOkk7kMT54FTRFL/LLAknmK+q2I9E6Egm+atdoZEIS
         ikAM+soq/24lEH/Mhj/jgN/Z1hCOcKTkhz8ZjkeLyjY6wTDIv/UaIOICkqjcJIGHVy1Q
         2XOtBHpSGXqd59hCw43Pe7jqA8ciazW3swO6Gs6V010Jjk7F/P762A8lDAY9TZSDyYA2
         OsVANOu6FyMasHzzSGdOIhFsNvjX/k8/KiWAa3GAWJFMJ7bTn71V9+PUzEJgIMIwUnQY
         NuhQ==
X-Gm-Message-State: AO0yUKVGCGn1P3tKyuK/f7ex0tjSIzxOnfdAglIYxmLwyY5LkleWMJeB
	wyYFtv9wqYPacjZjtT34epHljnJyzqD77TKHPGveGGuS4lXCvuaj
X-Google-Smtp-Source: AK7set81HDzw8gt88V0Dfe9PngJ0YN3XgCTnSB8F9sUZ/KdW4b9hMoCFEq5ub0R5DYRVi7WveRkD30B+LXR5c1bvUKM=
X-Received: by 2002:a05:6808:189e:b0:383:b21e:ad41 with SMTP id
 bi30-20020a056808189e00b00383b21ead41mr631634oib.58.1677108869113; Wed, 22
 Feb 2023 15:34:29 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 23 Feb 2023 08:33:52 +0900
Message-ID: <CAODzB9qbDPvJAiMk5Jk1s0YqQ6fDxq6xms45Cc26KsxHvtBarg@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 23:34:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10795

Hi !

It's this week's CVE report.

This week reported 4 new CVEs and 0 updated CVEs.

* New CVEs

CVE-2022-36397:  Incorrect default permissions causes Escalation of
Privilege bug in Intel=C2=AE QuickAssist Technology (QAT) drivers

CVSS v3 score is not provided (NVD)
CVSS v3 score is 7.3 HIGH (CNA)

Incorrect default permissions in the software installer for some
Intel(R) QAT drivers for Linux before version 4.17 (which means QAT
driver version 4.17 not Linux kernel 4.17) may allow an authenticated
user to potentially enable escalation of privilege via local access.

This bug is in the Intel QAT driver before version 4.17 so that is not
Linux kernel bug.

Fixed status
 Not a kernel bug

CVE-2023-23586: memory leak/use-after-free bug is found in io_uring
subsystem in linux 5.10.y

CVSS v3 score is not provided (NVD)
CVSS v3 score is 5.5 MEDIUM (CNA)

Due to a vulnerability in the io_uring subsystem, it is possible to
leak kernel memory information to the user process. timens_install
calls current_is_single_threaded to determine if the current process
is single-threaded, but this call does not consider io_uring's
io_worker threads, thus it is possible to insert a time namespace's
vvar page to process's memory space via a page fault. When this time
namespace is destroyed, the vvar page is also freed, but not removed
from the process' memory, and a next page allocated by the kernel will
be still available from the user-space process and can leak memory
contents via this (read-only) use-after-free vulnerability. We
recommend upgrading past version 5.10.161 or commit
788d0824269bef539fe31a785b1517882eafed93
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/io_=
uring

This bug is in kernel 5.10.y. Its fix is the same as CVE-2023-0240
which backport io_uring codebase from 5.15.

Fixed status
stable/5.10: [788d0824269bef539fe31a785b1517882eafed93]

CVE-2023-26242: fpga: dfl-afu-region: Add overflow checks for region
size and offset

CVSS v3 score is not provided

afu_mmio_region_get_by_offset in drivers/fpga/dfl-afu-region.c in the
Linux kernel through 6.1.12 has an integer overflow.
According to the comment
(https://patchwork.kernel.org/project/linux-fpga/patch/20230206054326.89323=
-1-k1rh4.lee@gmail.com/),
it might be false positive.

No CIP member enables CONFIG_FPGA_DFL_AFU.

Fixed status
Not fixed yet

CVE-2023-0461: A use-after-free bug was found is Upper Level
Protocol(ULP) subsystem

CVSS v3 score is not provided

A use-after-free bug was found in the Upper Level Protocol(ULP)
subsystem which will cause a system crash or execute arbitrary code.
It was introduced by commit 734942c ("tcp: ULP infrastructure") in
4.13-rc1, so 4.4.y kernels are not affected by this issue.

Fixed status
mainline: [2c02d41d71f90a5168391b6a5f2954112ba2307c]
stable/4.14: [b689125d04949841337dfa730d48dd91ada9ce3a]
stable/4.19: [755193f2523ce5157c2f844a4b6d16b95593f830]
stable/5.10: [f8ed0a93b5d576bbaf01639ad816473bdfd1dcb0]
stable/5.15: [dadd0dcaa67d27f550131de95c8e182643d2c9d6]
stable/5.4: [c6d29a5ffdbc362314853462a0e24e63330a654d]
stable/6.1: [7d242f4a0c8319821548c7176c09a6e0e71f223c]

* Updated CVEs

No update this week.

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.

Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

