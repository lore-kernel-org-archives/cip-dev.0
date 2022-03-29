X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web08.5033.1648551017245436761
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Mar 2022 03:50:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Ec2i363F;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id m18so12374460plx.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Mar 2022 03:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=J0xxIAzWeWg/bxwXETGIHEmSNeXHCJeABvs0AU8jgRU=;
        b=Ec2i363FjZoTD9Uu9XiAUpKbtrD2sB8QSgVKpp+TFsnBiU42NcHgui/xJ4Er+0cHD0
         mjoS9oBmywnusHfTrLhesKm7jzm/KpuhkDUvdaBf2PSSV4mbZBGFWIxMfdbHuM/dTXhI
         o6xZCCVBX/swqR9uvNZoS3dTMBhNPvwKpwGRhhRx5U34RT0TX8RKgrIXHufXBQp95Jof
         T7xjRvo12G4BmT12n1JB9lXCxkqmtCZ9rNZ6tDVNDm50/Fyb6os2lJUdr8XAEl1YckG7
         gv0V9M9wLQYfvsetMV7Lq7nLXaJBLA5O/QJpW5LLlWuPS3ivnq/SyXZVtaGt2ccye85W
         I98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=J0xxIAzWeWg/bxwXETGIHEmSNeXHCJeABvs0AU8jgRU=;
        b=4FwjIuJR4RZyJJ+msnrWc55Buvpco5hQixDH34HG+2OyG8S6tvYJRkMv72AhI+P8PN
         92HplJeZAwa/x1hx0l/br5AA0LIAkaD0EvakMDzu0i91f1fTTZseGG56FEOx0kZE1Bl9
         Q1BWYEPawc19kh5GsRRGmqrAfpkbsNRliYaTqhuvyBS4UTTC/43fVV5xUcv6IctOx9+H
         4QaafW1wkfRZDGZSNcfSlVTQL7Q+ncL1uD/4L/idZiv7biUIvZetBuQQYdjeq6OAO0/R
         VvRG6tUBr7Afk3Z0vSQXRmVcFJJff3GwnkRm4TJaGDXDmJY5qar+YIuLBQXJ8sEGl0YG
         w4XQ==
X-Gm-Message-State: AOAM531/dM9t7NjAGtq2JvZWdofKODTnZcS0eymLxVTCE7Ljebu4bwmA
	5O2IL3sVexNWyYcYLFARVokkq0QZQykF99s5/nY=
X-Google-Smtp-Source: ABdhPJzaog9ycouPJeJZ2UBK21fne2Klwuk3H2+guKAuTKP2xwq2nBRtb+qzojxbAXbEDcjqOuSVtg==
X-Received: by 2002:a17:902:9b96:b0:14d:b42c:d4d3 with SMTP id y22-20020a1709029b9600b0014db42cd4d3mr29986005plp.33.1648551016649;
        Tue, 29 Mar 2022 03:50:16 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bx22-20020a056a00429600b004fa936a64b0sm18359998pfb.196.2022.03.29.03.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 03:50:16 -0700 (PDT)
Message-ID: <6242e468.1c69fb81.311d0.01f2@mx.google.com>
Date: Tue, 29 Mar 2022 03:50:16 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.235-cip70
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-timers: 6 runs, 2 regressions (v4.19.235-cip70) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip ltp-timers: 6 runs, 2 regressions (v4.19.235-cip70)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.235-cip70/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.235-cip70
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      91567a6adc2cb5217b6d7aabf7da3ac9ae6f1a79

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dc836ec4cd4e02e1346001f828c1f1988a8d7d54 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6242dd9267b43ebba7ae0696

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.235=
-cip70/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.235=
-cip70/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6242dd9267b=
43ebba7ae06a6
        new failure (last pass: v4.19.233-cip69) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6242dd9267b=
43ebba7ae06a6
        new failure (last pass: v4.19.233-cip69) =

 =20

