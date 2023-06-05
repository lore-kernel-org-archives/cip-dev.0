Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53F8C77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 12:00:12 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web11.5687.1685966407790402693
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 05:00:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=1/EhJ1wN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-528cdc9576cso2329817a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685966407; x=1688558407;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1nQ9iLW++Ls74rhBC5n5gDjefbTmpX0SijeCKT/sFQ=;
        b=1/EhJ1wNFEaUTLe9+3+tEKMUigLAzn5SqE7M5v1b7KA+g+3zymB2ODtQHfUYa3LJjX
         jV3KfDb120tm3kdi9E0LoWqAks5dzy4s8M648JtDH4qXPnZiDuDms1xhsLGdq3UyKDu/
         HgrVKY4zekem3X8j9yLwnRgydGWY5kJM0lru5qfaWAFAXBQbe5UHt7glIBFzIFJlWqSg
         ae8+lL3XRgV6ymby+lGoi+GT66GQP+0k7DoMKxKEeYnF5vX5rOxEztztjQ38naIjLaJp
         Fismcw9UiYyWDCXlntpaHo7EX+38cRXags9JUtHMMtPNzp5lhR2UU+fPAGSdZeR2ALly
         xHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685966407; x=1688558407;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1nQ9iLW++Ls74rhBC5n5gDjefbTmpX0SijeCKT/sFQ=;
        b=GNqSPkkLXhopP8HV4wlXdQ/f8swviqJHuZkU2iGBI0a9STfeL67VdAtEH+FO727LCS
         +/lSwE7NPsJORMvcUzbR6pGH9IvCZ/ra89SpzedPzJ7DUNBV6bliBaWyqExAk3Cf+oLT
         /CgXt35BSzX42g8pcZn60brb9XXi2sYWxXlN0VkMM6hbtB9ClLBmXAsAYag7pcqNINrA
         5w4mkhl4bl54VHSkd2TNNwvsicxTZvF4jmjr7k/thWudmDoti1q/FurYeopPfGi3cbrB
         7ywrgFIL60XBvPZNuwOXwm2Z5HaXyc2GEra2ACPAN5Tf4EGxBc5Jmbx+JPXVukatAZ3J
         VRRA==
X-Gm-Message-State: AC+VfDxTv/0InnXdAf4KSnWnZzfMUIckEQs+LomqYSKWRwK5mY1OaNrV
	igzJM/jbTWCKQbHq8sL3pD4yrd2BqL3CcUsg0vxsYw==
X-Google-Smtp-Source: ACHHUZ4uuFlJhQgCC1s5qXrUt7ERYjYMTrS324XI0OP12nY1jUBYeJoZi0J19FaavsGbltLpUari8A==
X-Received: by 2002:a05:6a20:841a:b0:10f:f672:6e88 with SMTP id c26-20020a056a20841a00b0010ff6726e88mr2689832pzd.4.1685966406572;
        Mon, 05 Jun 2023 05:00:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902cec900b0019f3cc463absm6411070plg.0.2023.06.05.05.00.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 05:00:06 -0700 (PDT)
Message-ID: <647dce46.170a0220.b0ea1.ab14@mx.google.com>
Date: Mon, 05 Jun 2023 05:00:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1298-g61395b9756bd5
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 11 runs,
 4 regressions (v6.1.26-1298-g61395b9756bd5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 12:00:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11810

cip-gitlab/ci/pavel/linux-test ltp-timers: 11 runs, 4 regressions (v6.1.26-=
1298-g61395b9756bd5)

Regressions Summary
-------------------

platform     | arch   | lab           | compiler | defconfig        | regre=
ssions
-------------+--------+---------------+----------+------------------+------=
------
qemu_riscv64 | riscv  | lab-collabora | gcc-10   | defconfig        | 2    =
      =

qemu_x86_64  | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 2    =
      =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1298-g61395b9756bd5/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1298-g61395b9756bd5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      61395b9756bd5614e204ba22b9c75fd47c24a999

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform     | arch   | lab           | compiler | defconfig        | regre=
ssions
-------------+--------+---------------+----------+------------------+------=
------
qemu_riscv64 | riscv  | lab-collabora | gcc-10   | defconfig        | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/647dc080ba5d69d04af5df6d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/riscv/defconfig/gcc-10/lab-collabora/ltp-timer=
s-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/riscv/defconfig/gcc-10/lab-collabora/ltp-timer=
s-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dc080ba5=
d69d04af5df72
        new failure (last pass: v6.1.26-1302-g2631206dd75c2)

    2023-06-05T11:00:55.373264  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dc080ba5=
d69d04af5df72
        new failure (last pass: v6.1.26-1302-g2631206dd75c2)

    2023-06-05T11:00:55.373264  =

   =

 =



platform     | arch   | lab           | compiler | defconfig        | regre=
ssions
-------------+--------+---------------+----------+------------------+------=
------
qemu_x86_64  | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/647dbfc63c266169a2f5de9c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig/gcc-10/lab-collabora/l=
tp-timers-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig/gcc-10/lab-collabora/l=
tp-timers-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dbfc63c2=
66169a2f5dea1
        new failure (last pass: v6.1.26-1302-g2631206dd75c2)

    2023-06-05T10:57:51.754105  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dbfc63c2=
66169a2f5dea1
        new failure (last pass: v6.1.26-1302-g2631206dd75c2)

    2023-06-05T10:57:51.754105  =

   =

 =20

