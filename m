Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A741BC4332F
	for <webhook@archiver.kernel.org>; Wed, 16 Nov 2022 04:16:21 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.3058.1668572173076971863
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 15 Nov 2022 20:16:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=XhDgM4dA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id k5so15420098pjo.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 15 Nov 2022 20:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mn7rWN7nP688AWFfEFBSE2JhCu7DcyYwCB7efcFg9sA=;
        b=XhDgM4dA1y5Wk6DEj384RqRnrSY120qN9eAo6hCawijL+nko1eDAFmgMi2bZiWsXov
         tYYHUhrdA0DDZmgdZUof3On1yCn4ciwb28PPbJVP/mPrP424Dv7zswldmnSZQ+koJLMB
         ZK5Np2fkUUVCRDlrwGAXjtEGz8dFONf3p2GDwvJRw0aultxSL7tCm9nB8qczevzA+/pY
         IrlafjE6RcRl16H8yEDK3AHD8eg3co06RjJBZS93GWHfHEcnGwa4Ea+PRfUQbGApfUWA
         BHArijFKbwIe2NeV3lFr2VvrHmYpaw6cxqWI6EoaiNvoKzZ7TjJHM3QYvCghzQV/AcTO
         bTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mn7rWN7nP688AWFfEFBSE2JhCu7DcyYwCB7efcFg9sA=;
        b=kuizhxL1atr6fqWZvy2TY5AyXXpgHlnCQU6oCcTYXwkMZ6dIBhPT7UM6+Y13K5q3Uo
         COySf8/M2oD9HoSOGp9qQc3vdm6VcYMDBJmJ0LmiCjHr2+JeL4GDJCsyWY5Bv3ErNq0X
         eLI+r6nOTuI+H9bYshT1wN32CiaF//ZI7YGUPDuM7Rm384ydjTY8hexEZgZ6MdDk13NC
         WzB+k/oNnQQ3nEzNayUW8YZMFLm4Y6GoqRXe8gm1VgkIr/LWz/HQpN5qhyYRHIaWDOL2
         JpHDCioYokjlRJGZ7oB0argo1o4HZaqjuohHl9bvPL3uASVfmTd3fvrAZC9lqCx/YCpg
         JKww==
X-Gm-Message-State: ANoB5pnd4/kQQ9nBpeZnUx0/U6WOHhL7h+36KcOUt3ehL9lj3o1BeU5r
	14l537TnxZMly6/WZnXgC/XY5C2zjp8Vmvj2+OA=
X-Google-Smtp-Source: AA0mqf7SjnbHKjYKSfJ4qxfuGBGedbYnnbVKo2DVkvt7uvFL4V5vt+j7/YUGifFKM8AcbZkGHzpzOA==
X-Received: by 2002:a17:90a:d154:b0:213:4f59:4783 with SMTP id t20-20020a17090ad15400b002134f594783mr1879989pjw.28.1668572172348;
        Tue, 15 Nov 2022 20:16:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b17-20020a63cf51000000b0046ece12f042sm8486670pgj.15.2022.11.15.20.16.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 20:16:12 -0800 (PST)
Message-ID: <6374640c.630a0220.1b3c1.ce00@mx.google.com>
Date: Tue, 15 Nov 2022 20:16:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.265-cip85-rt27
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 3 runs,
 1 regressions (v4.19.265-cip85-rt27)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Nov 2022 04:16:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10042

cip-gitlab/ci/pavel/linux-test ltp-mm: 3 runs, 1 regressions (v4.19.265-cip=
85-rt27)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.265-cip85-rt27/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.265-cip85-rt27
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7b2b3defe99e6a33cd295c5120b96288f81f8bd7

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6374639ad5e32979d42abd1a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6374639ad5e32979d42abd1b
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =20

