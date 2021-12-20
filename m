X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web12.1935.1639976360468564886
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 19 Dec 2021 20:59:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=PWN2+1j4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id k4so8303945pgb.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 19 Dec 2021 20:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Wy6EhEUQLnhHXNdlSTBMniE1noDNWn2JGCznhvpDluk=;
        b=PWN2+1j4Tiwto+CShxiEeVzLWXC7sJWU/RAcCM43SRle5Fg5+CUHyFmxmpQF8Fqapb
         hd5y1icsTSZK1pkyOItz5Aj6gEzsdNSm5xqh0R3UEkHOdF/P2rbXvqP5DzoBkVt59M0s
         1PYkACmmLCbk2Eku+w1HqfMZhKoq3/Tlyv/wphEjMZXcIM4ArN1LC1iBjdFTOIkIafcG
         WZ5o35u6YcVHOpNUwRISqgH6lNYMDaEECB1x41KtI/LQL2TMUshuSwOSMi+woApjjI6V
         5FzLJFS+JXZHjebR7R+2R9DVJhFm35W9FHWnyudz4jZ5QQO1redNekiL1WzQ2S+YHRKJ
         mgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Wy6EhEUQLnhHXNdlSTBMniE1noDNWn2JGCznhvpDluk=;
        b=ZQ4hAsGOoVyG5J+xxvv+7Dz8GckYZtXAcAm3+KQGm+B1ozBO7GmMQ7jV2lCF3vdl4c
         qZXcl60NRa4LC9Un2YsQN40oN3BmuwK6sk44aeIb3Cs/C3yLJn0eiSlK9mjLmEK3oleZ
         PuNGDS1zGXOn0O1m7q9L9RRbP09gQd558mbUGUQQ5whhMWd8a4tRh9V9F4SXq+DyK3NM
         Di4E+5nsqcOA4hoY6DKqznR/onY5O4aE3GMrOtvHtRnnGmrKcmm0VHxBCIPQy3gaLK/o
         foAJgaE705LLn+ja6PIOMk5ihA3aG7zghsNtvlCgfEXBFTOq2gwN9KtjBbYVtkZQnoZB
         1xRg==
X-Gm-Message-State: AOAM531lguvdz8UUuLn2wFLx9oBIN3WCS8SCm6hn+FixUeM8wsW6e/kU
	Ybo91R1YQLfLJ8NByiQvx1qN0oYTB/ZDTn8Z
X-Google-Smtp-Source: ABdhPJzguCgGyhaSC03ZG3ysBQ8p8ADnhA0xsMK/KjRfHcMx9byrHiru8c13AMWso7tw2tkeFfVL+Q==
X-Received: by 2002:a05:6a00:21c3:b0:4a7:ffeb:ec1f with SMTP id t3-20020a056a0021c300b004a7ffebec1fmr14704667pfj.60.1639976359905;
        Sun, 19 Dec 2021 20:59:19 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p16sm18576496pfh.97.2021.12.19.20.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 20:59:19 -0800 (PST)
Message-ID: <61c00da7.1c69fb81.efb96.3b64@mx.google.com>
Date: Sun, 19 Dec 2021 20:59:19 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.83-cip1-31-gdcbef6602957
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline: 109 runs, 2 regressions (v5.10.83-cip1-31-gdcbef6602957) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip baseline: 109 runs, 2 regressions (v5.10.83-cip1-31-gd=
cbef6602957)

Regressions Summary
-------------------

platform                 | arch | lab          | compiler | defconfig      =
    | regressions
-------------------------+------+--------------+----------+----------------=
----+------------
imx6q-var-dt6customboard | arm  | lab-baylibre | gcc-10   | multi_v7_defcon=
fig | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.83-cip1-31-gdcbef6602957/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.83-cip1-31-gdcbef6602957
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dcbef66029571fbada7522b2db0790e5ff054c66 =



Test Regressions
---------------- =



platform                 | arch | lab          | compiler | defconfig      =
    | regressions
-------------------------+------+--------------+----------+----------------=
----+------------
imx6q-var-dt6customboard | arm  | lab-baylibre | gcc-10   | multi_v7_defcon=
fig | 2          =


  Details:     https://kernelci.org/test/plan/id/61c000de73fbbedc58397167

  Results:     4 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-31-gdcbef6602957/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-i=
mx6q-var-dt6customboard.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-31-gdcbef6602957/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-i=
mx6q-var-dt6customboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20211210.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/61c000de73fbbed=
c5839716b
        new failure (last pass: v5.10.83-cip1-7-geb3270fae08d)
        4 lines

    2021-12-20T04:04:33.243932  kern  :alert : 8<--- cut here ---
    2021-12-20T04:04:33.274851  kern  :alert : Unhandled fault: alignment e=
xception (0x001) at 0xcec60217
    2021-12-20T04:04:33.275174  kern  :alert : pgd =3D (ptrval)
    2021-12-20T04:04:33.276227  kern  :alert : [<8>[   39.611060] <LAVA_SIG=
NAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREMENT=
=3D4>
    2021-12-20T04:04:33.276532  cec60217] *pgd=3D1ec1141e(bad)   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/61c000de73fbbed=
c5839716c
        new failure (last pass: v5.10.83-cip1-7-geb3270fae08d)
        26 lines

    2021-12-20T04:04:33.326868  kern  :emerg : Internal error: : 1 [#1] SMP=
 ARM
    2021-12-20T04:04:33.327450  kern  :emerg : Process kworker/3:0 (pid: 26=
, stack limit =3D 0x(ptrval))
    2021-12-20T04:04:33.327728  kern  :emerg : Stack: (0xc2157eb0 to<8>[   =
39.657661] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=
=3Dlines MEASUREMENT=3D26>
    2021-12-20T04:04:33.327988   0xc2158000)
    2021-12-20T04:04:33.328235  kern  :emerg : 7ea0<8>[   39.669102] <LAVA_=
SIGNAL_ENDRUN 0_dmesg 1289958_1.5.2.4.1>
    2021-12-20T04:04:33.328479  :                                     c2735=
400 c1762700 c2156000 cec60217   =

 =20

