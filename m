Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA3AC77B73
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 11:26:40 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.6440.1686050795065026051
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 04:26:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Xnp7l5iQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2563a4b6285so2754474a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 04:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686050793; x=1688642793;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yISGm0iQCeYFyh7IhyPkNHrhkFU5UP98h8wnei+VxsA=;
        b=Xnp7l5iQzBuajYyMqQOseMSUrc/6SCKxsyMhiXSu3Gi7vibHzKFeH54RUC2TEM6YBo
         zkXiG7QedtbBkZwe2M6/Iv5Ko1oA2TehwcR6pZ07piWNJy7XkNi+Jphfw2b3QReNqxHo
         pIUXccQsUkO35wnFjqD+WvfxnuXcN8sZkeTkXew01Eye1s93mzgPHlatL0MoLqG77T7P
         lwfMtc/feUWICEngeVcPQ6ZtwxYDy4PDG+oXtse+EFFInCKYakN/mZiy6oAyIkKc1nKh
         UtvJomlU0gEALtpWDAihqFy9r6RyJMcj3gJW6xRcGE2gHrtURzblMksIzuFbBKlZRgl4
         4cxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686050793; x=1688642793;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yISGm0iQCeYFyh7IhyPkNHrhkFU5UP98h8wnei+VxsA=;
        b=U8FryyKN0VH9EpE10fB++x8jtClQw/3U4xcZelbPSVyzat4aMFc6O+wtJD5RQPrDV2
         nKM04Hm87cQwBr+PzCh38DcKvlLdJFWREJle0LsRz78pjw9dAL3eAUs7OgOBrSEIHc1M
         qZ1JV7AVb0qP/kS9Aagcdh1+Ojc848iGuWxYu8IMfO3rh5RhZ0m+qs0kD7vNSenn56cJ
         f1ujyfJKZ/KgufcvC3eWQRC2681gLVQr4QQ74cHQBvuBdJfMrH3EVdqQKgNzXb/K8Kab
         wLUpIRgdpefijXyOTm1LnTM1Isn45Ng9fBMwggRSzVOrF2w8cZzmxyt6OVt19q74OIYO
         DE3Q==
X-Gm-Message-State: AC+VfDxuPZsrXW0dxMIyTfTRpqs3WIrqPiEuKQIEHsMjruip7AnWd1t/
	bvnI7dE2xbk/X2zdU+Stq1t+Vp+Eq4HGla9yUZ+JaQ==
X-Google-Smtp-Source: ACHHUZ6Ivq0JuSTRmHOisZHYDPhBVnosacqkNM9wSIjhCcAvUMZZ7aTVMV7N6+Wl7D69wZvF6EPROg==
X-Received: by 2002:a17:903:22c4:b0:1ad:fcdc:2a9f with SMTP id y4-20020a17090322c400b001adfcdc2a9fmr1405501plg.51.1686050792874;
        Tue, 06 Jun 2023 04:26:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b0019ee045a2b3sm8367030plb.308.2023.06.06.04.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:26:31 -0700 (PDT)
Message-ID: <647f17e7.170a0220.ef364.f253@mx.google.com>
Date: Tue, 06 Jun 2023 04:26:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-26-g462b2292d23e6
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-timers: 10 runs,
 10 regressions (v5.10.180-cip34-26-g462b2292d23e6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 11:26:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11872

cip/linux-5.10.y-cip ltp-timers: 10 runs, 10 regressions (v5.10.180-cip34-2=
6-g462b2292d23e6)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

qemu_riscv64             | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 2          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34-26-g462b2292d23e6/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34-26-g462b2292d23e6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      462b2292d23e6b1dc941676861a2951dd3a98d13

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/647f05ab204ba97cc3f5de3f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f05ab204=
ba97cc3f5de44
        failing since 20 days (last pass: v5.10.177-cip31, first fail: v5.1=
0.179-cip32-4-gd8c029e4780f) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f05ab204=
ba97cc3f5de44
        failing since 20 days (last pass: v5.10.177-cip31, first fail: v5.1=
0.179-cip32-4-gd8c029e4780f) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/647f070a15e751b7d9f5de35

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f070a15e=
751b7d9f5de3a
        failing since 115 days (last pass: v5.10.165-cip25, first fail: v5.=
10.167-cip26) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f070a15e=
751b7d9f5de3a
        failing since 115 days (last pass: v5.10.165-cip25, first fail: v5.=
10.167-cip26) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/647f06936d02124c7ff5de36

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f06936d0=
2124c7ff5de3b
        failing since 214 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f06936d0=
2124c7ff5de3b
        failing since 214 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_riscv64             | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/647f06aa2b336ff30cf5de26

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qe=
mu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qe=
mu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f06aa2b3=
36ff30cf5de2b
        failing since 0 day (last pass: v5.10.180-cip34, first fail: v5.10.=
180-cip34-19-gf0f6960f132cd) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f06aa2b3=
36ff30cf5de2b
        failing since 0 day (last pass: v5.10.180-cip34, first fail: v5.10.=
180-cip34-19-gf0f6960f132cd) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647f0be7524f6b9802f5de26

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f0be7524=
f6b9802f5de2b
        failing since 214 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f0be7524=
f6b9802f5de2b
        failing since 214 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =

 =20

