Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5005BEB64DD
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 10:38:10 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.14944.1686825486744839104
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 15 Jun 2023 03:38:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=DH0dpuCL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6664a9f0b10so1241848b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 15 Jun 2023 03:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686825486; x=1689417486;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gT5VASSi0D9dAqW/H7uapPlEv8+/OU0U2RL2N0BEBxw=;
        b=DH0dpuCLGNVGU6cEAnQuNUjw4lE7YYNLpCzAchG+e4nPJGvqstcKHMDBfphtPm2Pib
         e5sAIyhrs6JUzUYu1RsVDtsCSWk0YzxHmQ+0G22dR9o5qH3ZZSIEMAo0NoN/F0NHbbX0
         7IpiW/mafuiiYo8GiY8Ni59sS1fr6Q2G++LdDKZwPWiHTuqha1MTunPL3iUUt+eMY0JO
         ypHqMlRcI5HuEb5aZhRUIITVSqdtg+CboKInddeLj86hEE/4nnj4x9p/v/XXYkyQai6P
         9a6Aj1blxhYxrv8lhhmru5BoXfDdTnSRzgeiFcf/VWD4UVgYJKC+RvoMeKds3K4mGaxy
         /89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686825486; x=1689417486;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gT5VASSi0D9dAqW/H7uapPlEv8+/OU0U2RL2N0BEBxw=;
        b=TLaRle1ORQ7Y7Xe1Kyi4v/Y1KiUS5z0Db3pbUdLV0Jgl/W7u/AVxue1GDnM+2l6q7S
         bn0CiFWJYFfiQfHZJDU2D/Ab42RheoAiBJqsTKE7hc4xiw2e4PnntX9Gv1f1XcZu3DZC
         ap0Zy1s2tmhsCVOXJGs6RmwqFZ5wLymxL+1qw+0CJdUR6yoOnDxcGdF7K4j73XXhSGIZ
         iQ5aB8jh3G7SzrHEFPN70cZ8ZsoibMGejECv6GrzmZD/zNHPeKnmhfv2Hiq9fxGVvd0Y
         FzASPE5z4dk40LAXpKLjJ/jZLObNQLi7rAtyY5IujFnt7da3R/SGB1Hc1VfeVD+rDXCb
         6lTA==
X-Gm-Message-State: AC+VfDxDpWKPqndz1ZBDuY1Oob9Of/PpIW6JiUJ3tnpc9KD+bTAaCD18
	FaxLYbsjLbs2J3WwNd4tvzyMCGkUVaica+6p82Pa5g==
X-Google-Smtp-Source: ACHHUZ5ckR1YHKUyw8VFnm6SKn5V9TnXfbbasoPaCjHzs7nCRItBeKp/tgZp35GeN2HGSx36crwQOw==
X-Received: by 2002:a05:6a00:1903:b0:65d:98a2:8876 with SMTP id y3-20020a056a00190300b0065d98a28876mr4949874pfi.2.1686825485860;
        Thu, 15 Jun 2023 03:38:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j24-20020a62b618000000b00643889e30c2sm11747903pff.180.2023.06.15.03.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:38:03 -0700 (PDT)
Message-ID: <648aea0b.620a0220.5969d.753f@mx.google.com>
Date: Thu, 15 Jun 2023 03:38:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-gdba81ae6f2be
Subject: cip/linux-5.10.y-cip ltp-timers: 15 runs,
 10 regressions (v5.10.182-cip35-8-gdba81ae6f2be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 10:38:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12055

cip/linux-5.10.y-cip ltp-timers: 15 runs, 10 regressions (v5.10.182-cip35-8=
-gdba81ae6f2be)

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35-8-gdba81ae6f2be/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35-8-gdba81ae6f2be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dba81ae6f2be7f7d87f3a29a8566758d2e0017ae

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/648ad932b0d57d23aa30613e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648ad932b0d=
57d23aa306143
        failing since 29 days (last pass: v5.10.177-cip31, first fail: v5.1=
0.179-cip32-4-gd8c029e4780f) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648ad932b0d=
57d23aa306143
        failing since 29 days (last pass: v5.10.177-cip31, first fail: v5.1=
0.179-cip32-4-gd8c029e4780f) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/648ada86dfcb04d28d306160

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648ada86dfc=
b04d28d306165
        failing since 124 days (last pass: v5.10.165-cip25, first fail: v5.=
10.167-cip26) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648ada86dfc=
b04d28d306165
        failing since 124 days (last pass: v5.10.165-cip25, first fail: v5.=
10.167-cip26) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/648ada54e85f58616c306139

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648ada54e85=
f58616c30613e
        failing since 223 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648ada54e85=
f58616c30613e
        failing since 223 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_riscv64             | riscv  | lab-broonie   | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/648ad99d29ee6a87be306132

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_r=
iscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_r=
iscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30609.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648ad99d29e=
e6a87be306137
        new failure (last pass: v5.10.182-cip35-1-g7cde3fba93966) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648ad99d29e=
e6a87be306137
        new failure (last pass: v5.10.182-cip35-1-g7cde3fba93966) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_riscv64             | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/648ad8cf34cefe19e030616b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu=
_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu=
_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30609.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648ad8cf34c=
efe19e0306170
        new failure (last pass: v5.10.182-cip35-1-g7cde3fba93966)

    2023-06-15T09:24:18.884982  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648ad8cf34c=
efe19e0306170
        new failure (last pass: v5.10.182-cip35-1-g7cde3fba93966)

    2023-06-15T09:24:18.884982  =

   =

 =20

