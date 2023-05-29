Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6A9C7EE2C
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 00:57:10 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.40704.1685321821912269503
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 28 May 2023 17:57:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=PS8yMUL2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-64d2f99c8c3so2044814b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 28 May 2023 17:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685321820; x=1687913820;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=axuoNrVsfXU2Xzn295NXPstkKlYv6UUoUVPcd4KgxXI=;
        b=PS8yMUL2teKXMbnmrqh3HkNlSxzTR+MQHJ33wkKJoMaj4A6aGN2N6bubhKWM9WZjUF
         X7wtHgkkrh89nFzi2X8BzDdeOqYskb8+HaNT+GNPXS7O3CmwSrwQYTtCJeHxCtmlzvsg
         rl8ZakIjVjGXuU3dn1WIJHpruitIznIk2lk9UGfTLy8jiqwob1V+dab5dD00f3LIIvb4
         2BJ1W/ASJWEde1Qsk5w5YhXCRGnUdzNNYqbhnaZYyjT5/LWgtn47tha3cwQKYhkLPYG8
         qOvUuRO8p8XIqr1pPrTDj3bOqyAs8hBBYmQ5XYekeA9YB8wSsgJueypVePJUPfdgCWx3
         d3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685321820; x=1687913820;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axuoNrVsfXU2Xzn295NXPstkKlYv6UUoUVPcd4KgxXI=;
        b=cvZXnsDnjtO2Jwt/IDqSSt1M874huv8rFuO7eQjaP9yOIlmcSxjwqEOLb74cLcQMHJ
         EBqxSAQjH/XfTamX1s1T9rGZ5LWqXrj6idXdiyHvok+jSpdfECQ4N+tKLi9DA9d3/LiX
         UGUMm8f0CdTRcL1IvBoihRonDSGz8gjZj+DVH0PvVMtjTSRVVeHZixXloswLL1WH2V4h
         CV2TtEMTLifKTeHbPnh2TNgXA8KMcUyTPMV/bxp/HqhgTdZcAIa2Zoo8XCWnCOA1FCVv
         Gx6uozeR8O8K38TCa1AnYvvdKvXHkVcQvs00H6aKGaEeZ409bMa5RKY6Zv9lDa3BSnqh
         9bHQ==
X-Gm-Message-State: AC+VfDy7K5Lrm9HiF46BdediVjEGJ4kpaSqkXNv1bpqw+snkTS5b6pSV
	F4pnOdYhRsy3eDIi8Pin2ZBhIzVuJzEcuBeuOwzKww==
X-Google-Smtp-Source: ACHHUZ6gK6GOfw1iL0qPFgLZ89OsRj5FNcdIKih+VW/p5HVss2pl9GEQQjIDd1cYE7zG3zxKPfcbYw==
X-Received: by 2002:a05:6a00:190e:b0:63b:8afe:a4dc with SMTP id y14-20020a056a00190e00b0063b8afea4dcmr11595244pfi.30.1685321820517;
        Sun, 28 May 2023 17:57:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x7-20020a056a00270700b0062bc045bf4fsm5865884pfv.19.2023.05.28.17.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 17:56:59 -0700 (PDT)
Message-ID: <6473f85b.050a0220.81dba.bfb5@mx.google.com>
Date: Sun, 28 May 2023 17:56:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33-21-g8eb0cdf459a2
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 16 runs,
 20 regressions (v5.10.180-cip33-21-g8eb0cdf459a2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 00:57:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11678

cip/linux-5.10.y-cip ltp-timers: 16 runs, 20 regressions (v5.10.180-cip33-2=
1-g8eb0cdf459a2)

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

qemu_riscv64             | riscv  | lab-broonie   | gcc-10   | defconfig   =
                 | 2          =

qemu_riscv64             | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 2          =

qemu_smp8_riscv64        | riscv  | lab-broonie   | gcc-10   | defconfig   =
                 | 2          =

qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 2          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 2          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33-21-g8eb0cdf459a2/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33-21-g8eb0cdf459a2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8eb0cdf459a2bb2971bbf3eecc4f894d2717cff9

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  04e8f2f4fd9493f595b34320403cf6b4f1f6789d =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6473e74f14cfb2da852e8605

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473e74f14c=
fb2da852e860a
        failing since 12 days (last pass: v5.10.177-cip31, first fail: v5.1=
0.179-cip32-4-gd8c029e4780f) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473e74f14c=
fb2da852e860a
        failing since 12 days (last pass: v5.10.177-cip31, first fail: v5.1=
0.179-cip32-4-gd8c029e4780f) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6473eb206849f656a42e85ea

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473eb20684=
9f656a42e85ef
        failing since 107 days (last pass: v5.10.165-cip25, first fail: v5.=
10.167-cip26) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473eb20684=
9f656a42e85ef
        failing since 107 days (last pass: v5.10.165-cip25, first fail: v5.=
10.167-cip26) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6473eca6a15336d5952e862c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473eca6a15=
336d5952e8631
        failing since 205 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473eca6a15=
336d5952e8631
        failing since 205 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_riscv64             | riscv  | lab-broonie   | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/6473f7a2ee0c6529ad2e860d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30519.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473f7a2ee0=
c6529ad2e860f
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473f7a2ee0=
c6529ad2e860f
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_riscv64             | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/6473e7c8b52a49f0822e85f9

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qem=
u_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qem=
u_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30519.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473e7c8b52=
a49f0822e85fe
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-28T23:45:51.247817  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473e7c8b52=
a49f0822e85fe
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-28T23:45:51.247817  =

   =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_smp8_riscv64        | riscv  | lab-broonie   | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/6473f77a18611e05572e860f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30519.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473f77a186=
11e05572e8614
        failing since 5 days (last pass: v5.10.180-cip33, first fail: v5.10=
.180-cip33-11-gfea7994097935) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473f77a186=
11e05572e8614
        failing since 5 days (last pass: v5.10.180-cip33, first fail: v5.10=
.180-cip33-11-gfea7994097935) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/6473e6a566d1afed212e862f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qem=
u_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qem=
u_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30519.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473e6a566d=
1afed212e8634
        failing since 5 days (last pass: v5.10.180-cip33, first fail: v5.10=
.180-cip33-11-gfea7994097935)

    2023-05-28T23:41:13.478599  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473e6a566d=
1afed212e8634
        failing since 5 days (last pass: v5.10.180-cip33, first fail: v5.10=
.180-cip33-11-gfea7994097935)

    2023-05-28T23:41:13.478599  =

   =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6473e9dce9e71cdb312e865e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473e9dce9e=
71cdb312e8669
        failing since 9 days (last pass: v5.10.179-cip32-4-gd8c029e4780f, f=
irst fail: v5.10.180-cip33) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473e9dce9e=
71cdb312e8669
        failing since 9 days (last pass: v5.10.179-cip32-4-gd8c029e4780f, f=
irst fail: v5.10.180-cip33) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/6473ee77aaedbdf0e82e85ed

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-=
hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-=
hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473ee77aae=
dbdf0e82e85f8
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473ee77aae=
dbdf0e82e85f8
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6473ec518bbfe955092e85e6

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473ec518bb=
fe955092e85eb
        failing since 205 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6473ec518bb=
fe955092e85eb
        failing since 205 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =

 =20

