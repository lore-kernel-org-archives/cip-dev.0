X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web12.630.1639330413887162266
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 12 Dec 2021 09:33:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Grvn85NF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id p13so13020028pfw.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 12 Dec 2021 09:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=pSEQKd2jT3Sqdd7zaBIEQPpBWOJif0Xi66xJrqD27Hk=;
        b=Grvn85NFOSV0JVfENJ5F2t1zoRDzqfhStf9kIo6mqUlaA8E7nYn8ZgQUavDPz3w1q0
         iXJ4iDo80I6l9oOAPS7d+ykK7rQINFmkYk1B3/G6d4Urnb4xgmI6C4vy+4kZnK4vHYHI
         5DN441nPbcBaREIi0LcccvpUetFZFsf3KVgDcpQuu1voXOZOaOIe4sPoqsCMLSFlo2Bt
         Q8iVM+KNBfI2FjJ0umxHUJIDvlu8q2RYH6Nbz3sIa5ERROrCYBouW5xuUhiBCFv1FG6C
         TL7M0f9Lye8qxpd0Va20GvWj31VzIm2ypWnJfaMYgiqRXeZgDLvBojiONHqIhNeyGxU5
         w9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=pSEQKd2jT3Sqdd7zaBIEQPpBWOJif0Xi66xJrqD27Hk=;
        b=iYVk0j53V6c023kZDXiCllc3VxEGefM9mtib0u9aLGc0gOUdOXUhLrpnEodfF6pavT
         v3vSqP6YEsvJtMSCBN3+h+SaPZezyhXk5zUFkHc26Tnx7pvsuTF8ncDBRj3SqEi3Z5kE
         XO4G/jhIYuMWadn0gMwE9ve0E6C/hwhqAJiUHLwSwC0fdjpAD297/HdtXBbdkgQKiPGQ
         P9t2X8yhf35A0FHUZNvZguIxfWc0gRdJl3po2rWouwQAaZfHGrUvuziGn7q9MnIByBEC
         WVobF8++PtsjvRYJeGxQeQv7ca1Hv8XlJ7ePal4uDv2S9Mifa/PrFw/jJdXpzo8JCw+3
         o6lA==
X-Gm-Message-State: AOAM533vqqhMY4aaE66U8Jbh4HUggQqAxiBJy7EuDVofgfY62JFh3l+5
	KiCGNSMTmLuqlUV9UXn0UVZT1Gn8XPxPwxj7
X-Google-Smtp-Source: ABdhPJyIDqM1CALuC88Lrz51e9ENiMDdpWBJQ6q3ON8febVZ18MsXFOUWiL2ZhXrMukEDbswc5U4/g==
X-Received: by 2002:a63:d907:: with SMTP id r7mr6363009pgg.406.1639330413175;
        Sun, 12 Dec 2021 09:33:33 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id lr3sm2619645pjb.34.2021.12.12.09.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 09:33:32 -0800 (PST)
Message-ID: <61b6326c.1c69fb81.5c7c8.75fd@mx.google.com>
Date: Sun, 12 Dec 2021 09:33:32 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.220-cip63
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip baseline: 137 runs, 4 regressions (v4.19.220-cip63) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip baseline: 137 runs, 4 regressions (v4.19.220-cip63)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
da850-lcdk               | arm    | lab-baylibre  | gcc-10   | davinci_all_=
defconfig        | 2          =

minnowboard-turbot-E3826 | x86_64 | lab-collabora | gcc-10   | cip://4.19.y=
-...mu_defconfig | 1          =

panda                    | arm    | lab-collabora | gcc-10   | omap2plus_de=
fconfig          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.220-cip63/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.220-cip63
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      bc72f654ae48bf3e6e3cac96d5ca8bdeebd47330 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
da850-lcdk               | arm    | lab-baylibre  | gcc-10   | davinci_all_=
defconfig        | 2          =


  Details:     https://kernelci.org/test/plan/id/61b6285da4114cb890397133

  Results:     4 PASS, 2 FAIL, 0 SKIP
  Full config: davinci_all_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.220=
-cip63/arm/davinci_all_defconfig/gcc-10/lab-baylibre/baseline-da850-lcdk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.220=
-cip63/arm/davinci_all_defconfig/gcc-10/lab-baylibre/baseline-da850-lcdk.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/61b6285da4114cb=
890397137
        new failure (last pass: v4.19.217-cip62)
        3 lines

    2021-12-12T16:50:27.837947  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3400
    2021-12-12T16:50:27.838197  kern  :alert : raw: 00000000 00000100 00000=
200 00000000 00000004 0000000a ffffff7f 00000000
    2021-12-12T16:50:27.838333  kern  :alert : page dumped because: nonzero=
 mapcount
    2021-12-12T16:50:27.895930  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D3>   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/61b6285da4114cb=
890397138
        new failure (last pass: v4.19.217-cip62)
        2 lines

    2021-12-12T16:50:28.030733  kern  :emerg : page:c6f51000 count:0 mapcou=
nt:-128 mapping:00000000 index:0x4
    2021-12-12T16:50:28.031076  kern  :emerg : flags: 0x0()
    2021-12-12T16:50:28.115556  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deme=
rg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>
    2021-12-12T16:50:28.115901  + set +x
    2021-12-12T16:50:28.116079  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 1231516_1.5.=
2.4.1>   =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
minnowboard-turbot-E3826 | x86_64 | lab-collabora | gcc-10   | cip://4.19.y=
-...mu_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/61b629981d24e7b5f939711f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: cip://4.19.y-cip/x86/cip_qemu_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.220=
-cip63/x86_64/cip---4.19.y-cip-x86-cip_qemu_defconfig/gcc-10/lab-collabora/=
baseline-minnowboard-turbot-E3826.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.220=
-cip63/x86_64/cip---4.19.y-cip-x86-cip_qemu_defconfig/gcc-10/lab-collabora/=
baseline-minnowboard-turbot-E3826.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/x86/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/61b629981d24e7b5f9397=
120
        new failure (last pass: v4.19.216-cip61) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
panda                    | arm    | lab-collabora | gcc-10   | omap2plus_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/61b6286030fb73729d397131

  Results:     5 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.220=
-cip63/arm/omap2plus_defconfig/gcc-10/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.220=
-cip63/arm/omap2plus_defconfig/gcc-10/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/61b6286030fb737=
29d397134
        failing since 12 days (last pass: v4.19.216-cip61, first fail: v4.1=
9.217-cip62)
        2 lines

    2021-12-12T16:50:23.768700  <8>[   21.114593] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dalert RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2021-12-12T16:50:23.816773  kern  :emerg : BUG: spinlock bad magic on C=
PU#0, udevd/105
    2021-12-12T16:50:23.827331  kern  :emerg :  lock: emif_lock+0x0/0xffffe=
cfc [emif], .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1   =

 =20

