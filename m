Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22245C6FD18
	for <webhook@archiver.kernel.org>; Wed, 29 Mar 2023 16:00:26 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.280.1680105625285365070
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 29 Mar 2023 09:00:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=JESo6Uud;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id w4so15359194plg.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 29 Mar 2023 09:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680105624;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=16HX6Wd9REGJdjdpFa0GT6XYW/acV7ipeW1XGxjP8rM=;
        b=JESo6UudVx8JWP73pO6dSPt/c7H2vVxm4Lc9dO0E+dxSSdSRBcOeP5LiraEbbr1aFe
         xjMaeY9a74F4m7Vv9xIdIJW/z/sB74FEmfntki3ogLS5uousJwuoS3GtLnJIh/FoQ0xo
         5zTinRldTXcwF0oqofc7vnsS6wuEoNXj5Vzo/kOZvNQMdE5z3h+s+0/yYV1pd3sFkgFJ
         3jz5IYIJWzeKn/jDOnF6YbKJnV3kDof3Q07d0+wjMAdIy47EsycZmAAJ5Es0wDYjEEZl
         nMUNxYz1DQRVE68t4MNcYGMacLDs/0u7ARp02d9F+6XeZcDJlwyKG8dJuPzTZctW7JsM
         JVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105624;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16HX6Wd9REGJdjdpFa0GT6XYW/acV7ipeW1XGxjP8rM=;
        b=TBC6qqfrKysCe+twYK3df3QQ6vuBqk+/XsBAZxpo6qaR8O8UJVgwSjhgDiylqXLUPp
         5k+P4nT1ejVdhJoOoZx0c+lkfq2+DIQveUgYzQr3C2lXJhUM0ekJ6JFpU9Uhkh5v8x3X
         ZcwqVwQKEt6ifaoRtEUqevQ+rBRCv4zAwCST7z9PMdY9+i5/78PMTCJUZFqiWbm40aFe
         UO5a2kwu8mogxSkP8N7AcOJyizFraAK1g3ydKPHVlTTbbgJPJ/GozQ7kElSE+L2jqSiJ
         8hTzt4PNjDG301d72QWhEedwPGOa6OYvLm9OVBinVmZqSjtgCmoVzsUI0PPgc9MEw1AV
         1WBw==
X-Gm-Message-State: AAQBX9f+FS0AwqUg3yybahGSbwNNqJPeADVl6G9uroWSP5WdB/ossRbD
	tin1XoZyXdnCLHmbjJe1OKYG/yu9dns2jYEv1eoWTw==
X-Google-Smtp-Source: AKy350bCo+GYOQdkk8xT1cL+HBBg3J8l5UAsMhzLHoNyteb80sAhgEUL6rQvzAkAyQjSfxqi8G59eQ==
X-Received: by 2002:a17:903:110d:b0:1a2:4777:b90a with SMTP id n13-20020a170903110d00b001a24777b90amr13426505plh.25.1680105624226;
        Wed, 29 Mar 2023 09:00:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jg18-20020a17090326d200b001898ee9f723sm23327183plb.2.2023.03.29.09.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:00:23 -0700 (PDT)
Message-ID: <64246097.170a0220.d392.a6fa@mx.google.com>
Date: Wed, 29 Mar 2023 09:00:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1097-gd51b0e04681f
Subject: cip/linux-4.4.y-st-rc baseline-nfs: 24 runs,
 2 regressions (v4.4-st20-1097-gd51b0e04681f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Mar 2023 16:00:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11126

cip/linux-4.4.y-st-rc baseline-nfs: 24 runs, 2 regressions (v4.4-st20-1097-=
gd51b0e04681f)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1097-gd51b0e04681f/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1097-gd51b0e04681f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d51b0e04681f73604e7ebc991f6a63833a70d3c5 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642453acf39e4a180262f77c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-gd51b0e04681f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-gd51b0e04681f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230324.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642453acf39e4a180=
262f77d
        failing since 78 days (last pass: v4.4-st20-234-g4e6ec7162c8e, firs=
t fail: v4.4-st20-799-g1229c813bcd9) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64245299662a5d50a162f793

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-gd51b0e04681f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-gd51b0e04681f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230324.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64245299662a5d50a=
162f794
        failing since 78 days (last pass: v4.4-st20-234-g4e6ec7162c8e, firs=
t fail: v4.4-st20-799-g1229c813bcd9) =

 =20

