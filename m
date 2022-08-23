Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB48DC32796
	for <webhook@archiver.kernel.org>; Tue, 23 Aug 2022 06:01:19 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web08.28468.1661234470149159761
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 23:01:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=KvxflcUB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id 1so5304997pfu.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 23:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=ADLzSUFhX2X1PEOoc7zLndPRdaZ6FXOb2r1g7fiZmyw=;
        b=KvxflcUBVvdPNQcyjFAF5F6ahBCGNYIzoGH3MP6dfG/DMsF2JHHusLep4I+NhCluhk
         YlS9WjB+NIJqOtXPsNXdqDjzptmz1odQO4AL9VtIYlisv9OL6QKx5xc/1Fg3ZAtSz7Vd
         LHwtB37YDjNvdnfTR3LSwXV6/glJZNw5EzrdtwQg+lNzciYHZF7zuk2atBklTi3l2gor
         M+tfhvOKIP1ME70MS0LxXicWwEu90A4GHzFmB0pl++4r/86M6z5b+es8OeTZRPkS+THX
         k4vbGWC9Q0PzmFnSP72Djr+8LxzFVX3V8Lu6xW6wKnkr6A9qLtH/iNfHtM0cBQbtE4Cv
         ocaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=ADLzSUFhX2X1PEOoc7zLndPRdaZ6FXOb2r1g7fiZmyw=;
        b=I0t7rDFlFpejhpNpTj48T4MX23liOV7ctdzBEil60MRl5o7qpLtSETVuaKjYDembM1
         zxY8mcZsdKe0luJ1Wt0Z/vYlEsPiO2uGrsRMMpRbI+BKJMstlanq4zCCn58Chkc9KJyZ
         4ZNEo8/wgU9EIlPuF+3i8XaIaSmkdeXMyB7iI/trycsS4ceoyTXGsDzxjuFtmwmei+NM
         yqnFnyEIVohzDTcfwSDqRX306Xu7Cl0crHFE4c2AKIo11h2J6E+sbSyegr4+4y7afvhl
         qvWyDjDN60pram2oCsgznWCuTK3v3EUV5jfB1VdpVsci+l6VTSG6druFSTf/zz1Y20O8
         tKAg==
X-Gm-Message-State: ACgBeo1/Iy3ERWf4R8rWSfvo032V3QguAlITaF7dcRsx1t6HHqsySl8N
	jxhinFsRAA9DmxRZGekD9AmG+UxRqctdZmD5
X-Google-Smtp-Source: 
 AA6agR5lyhe6P2CNUMbHm8YI8Rz45x0BOsmYNVP3gSfACiUUT0InXBZGAd7LNn04R0SD0Ayt2nN8hw==
X-Received: by 2002:a63:fc50:0:b0:41b:bbb8:ee36 with SMTP id
 r16-20020a63fc50000000b0041bbbb8ee36mr19018264pgk.20.1661234469118;
        Mon, 22 Aug 2022 23:01:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 22-20020a630d56000000b0041c66a66d41sm8358719pgn.45.2022.08.22.23.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 23:01:08 -0700 (PDT)
Message-ID: <63046d24.630a0220.64b9.e8c8@mx.google.com>
Date: Mon, 22 Aug 2022 23:01:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.255-cip79
Subject: cip/linux-4.19.y-cip smc: 8 runs, 4 regressions (v4.19.255-cip79)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Aug 2022 06:01:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9312

cip/linux-4.19.y-cip smc: 8 runs, 4 regressions (v4.19.255-cip79)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.255-cip79/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.255-cip79
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d48af81b093ff24e12907e79ce476e6efc4f7e4f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63045e691f75444af4355655

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/63045e691f75444af4=
355661
        failing since 45 days (last pass: v4.19.249-cip76, first fail: v4.1=
9.251-cip77)

    2022-08-23T04:58:04.683934  <8>[   11.060060] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/63045e691f75444af4=
355662
        failing since 45 days (last pass: v4.19.249-cip76, first fail: v4.1=
9.251-cip77)

    2022-08-23T04:58:04.672856  <8>[   11.049193] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/630462155cdc14470b35566f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/630462155cdc14470b355670
        new failure (last pass: v4.19.226-cip66) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/630462f25315fffb37355670

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/smc-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/smc-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/630462f25315fffb37355671
        new failure (last pass: v4.19.226-cip66) =

 =20

