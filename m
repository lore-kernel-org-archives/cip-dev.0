Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D4BC77B75
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 13:20:22 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web11.11377.1682083212601233521
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 21 Apr 2023 06:20:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=wJo8se8X;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-247048f86c7so1565288a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 21 Apr 2023 06:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682083212; x=1684675212;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl/V1YKPW5x2VwgTMffzQYkStP7qZOxNVHCkobXVEA8=;
        b=wJo8se8XgtM5gNPwXMGRbbjxxeXxVD+MkFrsUOo+hzmkQQhzBvslkfBMVCyXYSh98V
         9JYBbIMk7x1vYI0RYWys6bIqOdJEOJMNn7cgN2Wf/YWsrq9aN3IcbIJt+fVAelEzO820
         uod4v0ZGTZeDNffYzrhx9z7k0cpALyJ6XNbq+ShTIL5Q4zjP0Y1owDZcrp4Y377F02v2
         PQ01/tFY0IdeaHAjQEKWHHn5ezH/SkACG15S7jZ41qi78cLVi0pmGcNJGolg9Ut1+E0u
         a73fUzuVSi2Ys4REgWM/AQ8ydNFWvff5OPRC+RPTij9YdXAMlRzu45Jyc2uOqHDNPIMD
         dgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682083212; x=1684675212;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rl/V1YKPW5x2VwgTMffzQYkStP7qZOxNVHCkobXVEA8=;
        b=jWQGzSyMnHo+e+ZtzPo+iKu/rjbjSHAenVM8SADyE00YP0PpiTBuMHMOH6JYXsyNHK
         B9EmTcHnKIN8Kkb1PguPKNn02xcWlR490lEfQwr5PvVeUlUN5v612tMZvBBUjxhNKvTm
         p3STDbb0DFqWgA/HpvTmTvxOZtmQ4AsiCvr/unLb/rMazTE2DU1GyqAC1xrr2m7wVWYE
         4RPC9sku5m6GDgKL2bwi7dTA/0Ij7rRJqpTs/MW2DslDf589OS5Hx3pRUWeXl0JLpjsZ
         QORb5o0fiaG2Uj8iZZTZ96E6+KAYQMTuZmUDQGH1SjA3AblvJAYT+Z9fZp8HrhbhtXJ4
         FYLQ==
X-Gm-Message-State: AAQBX9c5Qum8KXgyvs4hoX3YRLGEsn2svkaxXA8GY6MfULV/wf4AIsHW
	O1cjGDX9xOSlPg9W2WLEmvKzLNOszl3wvfstiqEeKxNV
X-Google-Smtp-Source: AKy350bp0KtH4EvaTfjxusLMdhNkUz9jze3v5ijtZIU8UVAw8u6qOH0Ldzan2p+dhsXQGJwk/XKPwA==
X-Received: by 2002:a17:90a:a904:b0:246:896a:408d with SMTP id i4-20020a17090aa90400b00246896a408dmr5022280pjq.14.1682083211505;
        Fri, 21 Apr 2023 06:20:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 145-20020a630797000000b0051815eae23esm2659413pgh.27.2023.04.21.06.20.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 06:20:11 -0700 (PDT)
Message-ID: <64428d8b.630a0220.57b4f.5b4d@mx.google.com>
Date: Fri, 21 Apr 2023 06:20:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.177-cip31-33-gd59f246891e73
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 11 runs,
 7 regressions (v5.10.177-cip31-33-gd59f246891e73)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 13:20:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11313

cip-gitlab/ci/pavel/linux-test ltp-timers: 11 runs, 7 regressions (v5.10.17=
7-cip31-33-gd59f246891e73)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_riscv64             | riscv | lab-collabora | gcc-10   | defconfig    =
              | 2          =

qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig    =
              | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 2          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.177-cip31-33-gd59f246891e73/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.177-cip31-33-gd59f246891e73
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d59f246891e73b9c221f394dd91c309755c3e8ce

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  458f3554675aace42e9750086d26799e82829f11 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_riscv64             | riscv | lab-collabora | gcc-10   | defconfig    =
              | 2          =


  Details:     https://kernelci.org/test/plan/id/64428157eab581c5d02e85e6

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/riscv/defconfig/gcc-10/lab-collabora/ltp=
-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/riscv/defconfig/gcc-10/lab-collabora/ltp=
-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30414.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64428157eab=
581c5d02e85f1
        failing since 29 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.175-cip29-rt12)

    2023-04-21T12:27:57.134091  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64428157eab=
581c5d02e85f1
        failing since 29 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.175-cip29-rt12)

    2023-04-21T12:27:57.134091  =

   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/6442846328af60bf382e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/riscv/defconfig/gcc-10/lab-collabora/ltp=
-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/riscv/defconfig/gcc-10/lab-collabora/ltp=
-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30414.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6442846328af60bf382=
e85ea
        failing since 29 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.175-cip29-rt12) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 2          =


  Details:     https://kernelci.org/test/plan/id/64427ebd6ad24554b72e8615

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig/gcc-10/lab-cip/ltp-timer=
s-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig/gcc-10/lab-cip/ltp-timer=
s-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64427ebd6ad=
24554b72e8620
        failing since 156 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f=
6, first fail: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64427ebd6ad=
24554b72e8620
        failing since 156 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f=
6, first fail: v4.19.265-cip85-rt27) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6442821942607850592e8646

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64428219426=
07850592e8651
        failing since 30 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64428219426=
07850592e8651
        failing since 30 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =20

