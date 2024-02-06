Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28D9C48BC0
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 00:24:51 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.10661.1707179087328555301
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 16:24:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=dg/cn46d;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e0507eb60cso610074b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 16:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707179086; x=1707783886; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa6cXb6gNKKRl3WFZ5BSmV5ovuM4pIqZx5kyzK2kKfs=;
        b=dg/cn46dt8tcwp8WInr39VSzYMbpXCkC2+mbA4bSfU9XXuSb0jYkeZOCgUMPvsklty
         OVdusFo4f3zylvT6YqL8FZvMMdizEobjrXmKh0v5jNhnZtETFBq4GCiPEhm7cuOmxMn8
         lYG/Eb5185SBakLc9q+pKFynXUXzmbJuUphPrSwZfU4M1Dvlcq93XDxycZGLcspoXVOn
         nF288KXdYruKPFJnvkfLPw8MbVbPCI1y0ieprFfHHEru4lxqlPjG+ZJ0GA7RFULsZaKm
         6yaaJ5L3d72XJ0H24w8N9Am3fZYnWbLmpFCUcrvVAf1R6KOrt8D/HqP3qFeAVywoDe9d
         Q1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707179086; x=1707783886;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fa6cXb6gNKKRl3WFZ5BSmV5ovuM4pIqZx5kyzK2kKfs=;
        b=HrekDPlRn7Xa3ERLcm9FMTktZwsU+CcE+3JPzQ2qsZvzJUmpswhjPE2fFAoCuMBMrd
         MOYUjr4O2cSRFsvGpxsg1HUBIDXocP+AvMb935YrAxDFkfHNP2CriXPLgN2Gse93Hc/e
         G3AgWE4ZRQUCdWvVZMzncyHayKj+MfZ3NPgixLuEuMboYS++BxezeKGjvuNuMrZgoOGT
         vP+KGfa89pqFMD79TPZqGmn5f/BtYHlwEV6Ixtu7VhxpHlbU3Uj4MVlfsFGQwowrk+EE
         Jd86JXpx50n787BgtvdvqNsCNBd/8c8JmWF8aGNCevibEAS3ABa+AvBpFqmsTi8de7eL
         T9Qg==
X-Gm-Message-State: AOJu0YyHpzNtz/Bo9YL4COTFY6Gx0p6mKIRb/taSb8VOt2+5Ov0ZR2Xa
	UxQeEfCFkr0y24BtgtUQ6eAO8eEbywI35uyVlkYIpSFPw2NLN0vx6g0Zr37XBSLHkaOVw8iDd1O
	p
X-Google-Smtp-Source: AGHT+IEsf0fK0dRAw339GWEXCbG86y8FT2m3u1i3kRiKpAidUa0PZDE7E1eDh95y0bUwIA/nsxggoQ==
X-Received: by 2002:aa7:864d:0:b0:6e0:2fa2:5279 with SMTP id a13-20020aa7864d000000b006e02fa25279mr703000pfo.20.1707179085816;
        Mon, 05 Feb 2024 16:24:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ei41-20020a056a0080e900b006ddcadb1e2csm496377pfb.29.2024.02.05.16.24.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 16:24:45 -0800 (PST)
Message-ID: <65c17c4d.050a0220.8e94d.2eb9@mx.google.com>
Date: Mon, 05 Feb 2024 16:24:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-526-gbbb905888ca85
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 20 runs,
 10 regressions (v5.10.209-cip44-526-gbbb905888ca85)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 00:24:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14764

cip-gitlab/ci/pavel/linux-test ltp-timers: 20 runs, 10 regressions (v5.10.2=
09-cip44-526-gbbb905888ca85)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 2          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 2          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

qemu_riscv64                 | riscv  | lab-broonie   | gcc-10   | defconfi=
g                  | 2          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-526-gbbb905888ca85/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-526-gbbb905888ca85
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      bbb905888ca85ace83da9e4113b4957345c47d70

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 2          =


  Details:     https://kernelci.org/test/plan/id/65c16bdd4307f71d9200a0e8

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c16bdd430=
7f71d9200a0ed
        new failure (last pass: v5.10.209-cip44-rebase) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c16bdd430=
7f71d9200a0ed
        new failure (last pass: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 2          =


  Details:     https://kernelci.org/test/plan/id/65c16acfd4075ed76300a040

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c16acfd40=
75ed76300a045
        failing since 1 day (last pass: v6.1.72-cip13-32-gf60d2e8cb51c, fir=
st fail: v6.1.75-cip14-132-g6e54756fbd6c2) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c16acfd40=
75ed76300a045
        failing since 1 day (last pass: v6.1.72-cip13-32-gf60d2e8cb51c, fir=
st fail: v6.1.75-cip14-132-g6e54756fbd6c2) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c16edc4c92111d6f00a040

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/ltp-timers-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/ltp-timers-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c16edc4c92111d6f0=
0a041
        new failure (last pass: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c16d6a3b50dca38e00a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-timers-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-timers-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c16d6a3b50dca38e0=
0a03a
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_riscv64                 | riscv  | lab-broonie   | gcc-10   | defconfi=
g                  | 2          =


  Details:     https://kernelci.org/test/plan/id/65c1692439bfbada1200a048

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/riscv/defconfig/gcc-10/lab-broonie/ltp-=
timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/riscv/defconfig/gcc-10/lab-broonie/ltp-=
timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c1692439b=
fbada1200a04d
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c1692439b=
fbada1200a04d
        failing since 0 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c16c99a646d1613100a0bc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-cip/ltp-time=
rs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig/gcc-10/lab-cip/ltp-time=
rs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c16c99a646d161310=
0a0bd
        failing since 5 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1751be4d747bed500a040

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-526-gbbb905888ca85/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c1751be4d747bed50=
0a041
        new failure (last pass: v5.10.209-cip44-rebase) =

 =20

