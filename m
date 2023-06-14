Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD832EB64DC
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 13:22:45 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web11.11597.1686748961014406310
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 06:22:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=X2XqV2it;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-54f85f8b961so2620152a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686748960; x=1689340960;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UctZbLS2g8qOYuPSCxPOALkrmMeMxVZuTeCtu9PvLlE=;
        b=X2XqV2itiiJKjFLmx74ATX6trWCWRhlBkHldE4X03pvBymU7n097COe4YkPmguUdag
         czGvhsjzDeMDNXWs+Sx1XPlhlT3KsBxF+zqHvBQALAtuFYJCQMCZKvl+5oTuup7/p9qy
         R7CBTnpViOF0XAsN9dzslX4a6EQZA53mb5EfY5yzWNpZ3UlHQtxk/aavnoGM6QcFVVjc
         qKylPcL1d2PXsViW0dIT5QLfNW+W8aXXMM6NudjW9Eiia3LSAdO5z+Qphob5WTVrrhyT
         rgsyuxXKcdBMFjdc8AP4x/FeSBQXKuXQDHUUtsZgeXulF4QiINkBw7uoUyiGnfEDc8vo
         hCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686748960; x=1689340960;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UctZbLS2g8qOYuPSCxPOALkrmMeMxVZuTeCtu9PvLlE=;
        b=G2H0RFcJ5DGRPC0OytbgvEDQ/56knO2AqSuKFUxHS4y1ybklRZgfUZ4Jd3z/4IH11b
         8OkSciRSBGW1xPB3+3nb8LOjMEOwUtw9dDCAzuz2Yh2W5+DBgfPmk3IVqt4nRPu5FoG+
         QAZELjIgpZwGcZejQ4X89jvyBZNgAMNbWpa64BFQeZ0W/K6eTdhMnhONlt65yzbgLK3R
         IGhmlMS8frhayw7ADxCQ4yICK4dq1er2o6lfQ7wYparztnp2hiMRpXUcSOCQuXvghaSw
         v+Wv/0KucZ8J89tFU9++7lxO0w1gMSfRgulHKPvcfE4GDgwW1eDLsOqZWxLOmU0EWnT4
         v04Q==
X-Gm-Message-State: AC+VfDxSERRA+rVyDatuWI8AzEN/TSS0MFkUTMAdJxR0tpEcN/cpSsi/
	Y1iZiSEpopjUYBPqLUbuOOrm9eIsQkpvL7nXE/Qfvw==
X-Google-Smtp-Source: ACHHUZ5QooQbs9Qrw4hKKf9ciJezs1Os+AKnVOY9ThRZqyMon9Y/kUFjBW91El1IT8Jg1jkNAMd9xw==
X-Received: by 2002:a17:90a:13:b0:256:7000:3789 with SMTP id 19-20020a17090a001300b0025670003789mr1561545pja.9.1686748959742;
        Wed, 14 Jun 2023 06:22:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a19db00b002568f2f8102sm13650249pjj.30.2023.06.14.06.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:22:38 -0700 (PDT)
Message-ID: <6489bf1e.170a0220.c9ab3.c2b2@mx.google.com>
Date: Wed, 14 Jun 2023 06:22:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-1-g7cde3fba93966
Subject: cip/linux-5.10.y-cip ltp-timers: 9 runs,
 5 regressions (v5.10.182-cip35-1-g7cde3fba93966)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 13:22:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12027

cip/linux-5.10.y-cip ltp-timers: 9 runs, 5 regressions (v5.10.182-cip35-1-g=
7cde3fba93966)

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

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35-1-g7cde3fba93966/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35-1-g7cde3fba93966
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7cde3fba93966b9614ca285f91928a57a79f7f3f

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


  Details:     https://kernelci.org/test/plan/id/6489b0543af022f3d93061a6

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489b0543af=
022f3d93061ab
        failing since 28 days (last pass: v5.10.177-cip31, first fail: v5.1=
0.179-cip32-4-gd8c029e4780f) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489b0543af=
022f3d93061ab
        failing since 28 days (last pass: v5.10.177-cip31, first fail: v5.1=
0.179-cip32-4-gd8c029e4780f) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6489b1b59d956ae75130615f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489b1b59d9=
56ae751306164
        failing since 123 days (last pass: v5.10.165-cip25, first fail: v5.=
10.167-cip26) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489b1b59d9=
56ae751306164
        failing since 123 days (last pass: v5.10.165-cip25, first fail: v5.=
10.167-cip26) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489ba87172754621230613d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6489ba8717275462123=
0613e
        new failure (last pass: v5.10.180-cip34-26-g462b2292d23e6) =

 =20

