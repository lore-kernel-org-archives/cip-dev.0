X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web12.334.1647455410376629923
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Mar 2022 11:30:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=elvylMbw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id w4so2470274ply.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Mar 2022 11:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=aijs3uAoH8Qw4XZAu08w5+TWlbcSMhhrbvnaywN3yzg=;
        b=elvylMbwcar5psrtWazLiikZBHLHfIxyZTtBeR8NMr/w/WMlmgAO3xUlH4q5rtKUkk
         VM+GZ/aTNZ6i9EKTOoddmIRRAWD+TCjodf19wKcYES14/Ob5RDCpnMhwdYIbDtrPgbwA
         Kjlt71jKcrO/lRsJqtSaS1nfBagNdiIh4ZVki71bf5B3zEs35cJb8Y8Qi2fNRrZuVF85
         xGfLqbjll0DuX6pQRpiZFN8jCNxysYOLrjWKUiHZvxsBtRgi0U8nR5y51I8zoGDcRFs/
         oi7C/xDoFfMOF/LIiG/Cm5bVnaBQAz3XqtsXx+IUnuM1lu7pM0bu7PBvl74WlXTFgVHW
         8nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=aijs3uAoH8Qw4XZAu08w5+TWlbcSMhhrbvnaywN3yzg=;
        b=RamsfrlKg/KBPbxeemhx/BjpQxmC9g8AlvR0bWM+9U9djUltMkPVbtUN/QMozAtgk2
         6IiF5bYs6vWUyuPeXUe+hg/SxMDR2tIlQmMIOUu8azlCzWH/Drf0qYMd9fxpFvieUaZw
         zJgx3ZrmpdqjXYDb+gBHGHMqNxbWCdBjobx/CAxJ++CMCSWeoNkARKdGDstWGnkYfAcQ
         6sykcvg+UZ82s3LO/3oQ4uMa8hm8BOdDDGqQONJV5marJrmb7yAO/QSobev5oP/OQ3r3
         90/EeuZ//Ip7q7PtHFl8V5wX1r+Io/FAv3c6sTcoq+K+Fdv36bBoYV9Oajpir8V/YNye
         ICUw==
X-Gm-Message-State: AOAM533P4fd7P8fBolTjNahCvY9huKHXSj4mnRb1aeh5j14z+WPenGov
	khH8Ysli9a9J5pk4PYkU8EvqnXMsJHvWdCfjmdk=
X-Google-Smtp-Source: ABdhPJy7r3tp7qsHx+GH5SG2epQYM+ddV0E9xF49dJbXKIicet4+p+LvQK/loPhpTfkKnGL//s38Eg==
X-Received: by 2002:a17:903:41c8:b0:153:c17d:caa3 with SMTP id u8-20020a17090341c800b00153c17dcaa3mr744065ple.109.1647455409508;
        Wed, 16 Mar 2022 11:30:09 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d19-20020a056a00199300b004f7b7bb0733sm3982881pfl.60.2022.03.16.11.30.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 11:30:09 -0700 (PDT)
Message-ID: <62322cb1.1c69fb81.32fcd.980f@mx.google.com>
Date: Wed, 16 Mar 2022 11:30:09 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.233-cip69-62-g10346bfb0fd8
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 7 runs, 6 regressions (v4.19.233-cip69-62-g10346bfb0fd8) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 7 runs, 6 regression=
s (v4.19.233-cip69-62-g10346bfb0fd8)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.233-cip69-62-g10346bfb0fd8/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.233-cip69-62-g10346bfb0fd8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      10346bfb0fd860c9b121a80924fa29d4100b7e49

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  67eccca54eb68a1bc91cf1f140fc43fa8085d8ed =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/62321c893f633ab6cec62975

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-62-g10346bfb0fd8/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-62-g10346bfb0fd8/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/62321c893f6=
33ab6cec6297a
        failing since 7 days (last pass: v4.19.231-cip68-36-g01a8d14a9290, =
first fail: v4.19.231-cip68-89-gd39fc5cc85ff) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/62321c893f6=
33ab6cec6297a
        failing since 7 days (last pass: v4.19.231-cip68-36-g01a8d14a9290, =
first fail: v4.19.231-cip68-89-gd39fc5cc85ff) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/62321cee1e84d4ea2fc62989

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-62-g10346bfb0fd8/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-62-g10346bfb0fd8/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/62321cee1e8=
4d4ea2fc6299c
        new failure (last pass: v4.19.231-cip68-89-gd39fc5cc85ff) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/62321cee1e8=
4d4ea2fc6299c
        new failure (last pass: v4.19.231-cip68-89-gd39fc5cc85ff) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/623224cb2d061bb78bc62968

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-62-g10346bfb0fd8/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-62-g10346bfb0fd8/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/623224cb2d0=
61bb78bc62973
        new failure (last pass: v4.19.231-cip68-123-g92e3e7f3d4df) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/623224cb2d0=
61bb78bc62973
        new failure (last pass: v4.19.231-cip68-123-g92e3e7f3d4df) =

 =20

