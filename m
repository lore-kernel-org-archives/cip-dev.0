X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web12.1924.1646354187522310075
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 03 Mar 2022 16:36:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=xq3OWrF4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d187so6170858pfa.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 03 Mar 2022 16:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=GDFhdMPjyeGWnLU3u8/YYiuJtAUzrzYVesxNIgrlEg4=;
        b=xq3OWrF4mGXxj+KZieb+HgiTJmdd0Sw4WCXu/VMRmfC+1PBIVrHpm/NK70fAfqd4z9
         RitjjpYCO0qooUGbNLbvJRti+eKW0ca9NbKV4MCt7I0chyrH1d8q7m+afYPAsS/k8dp2
         MAXjOwQCZ23MvVNaR+egRf/JzH891iI5irxAzrlQtuy8Yh9I0HhKWk0WNobjjlZfJjRk
         ipioZgHb9/ELqciv3YEnMBo8abRR3iwvQPePouvEsR4cNvxJ6slWDL3k6dDcnmA2BweI
         qmPUphG9/41IUgrVZSCmIHOkDBe6WnDD3TK9fT/XOV1uqdslvZ2jaUyG1aAEtzZCoXSK
         1p3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=GDFhdMPjyeGWnLU3u8/YYiuJtAUzrzYVesxNIgrlEg4=;
        b=w28NGzWcuMrseCbUXenSJnqTiiPoRPpvH5nX96pnHgdvGHBm1ALD+dN6Vtppt5JPiN
         HhbWMlE4tuBRic2YR8Ddrbk5wtGljTh8jA5OmhYjHksI9ENcS56l5Xxa0z9sp5BVKMN/
         tJyKUB1Umklu8ntutEujRpP6PvGl80QJn8FLSkrw/2CsiE1i6R5jK7c9nGpfg0wFpjyJ
         jFU+FM0m2b8N10fUwbB3TU/Pq52uECpV4Q5jWbbDEzo3xKkjJ0XtY4GknHOU1++jFIxl
         +4UV32xFnnxOON/GV5XJM9VZkti+eKpvB4xVxFddTc1QnW42QHkS10e2m84bN9RyyMCT
         kqRQ==
X-Gm-Message-State: AOAM531OrpIa3n/dvmw5u+huQRFu+tYDpGFDoamuwqfNmZgIcIcAVAKX
	nGS58Px71CqFYY9nVL+WP1NjeZog2flQ1Fj1+Ng=
X-Google-Smtp-Source: ABdhPJwplznG0WVxaqYENobPXeyDfBYKoZALZHYEXJXJvmIc2e1jH6J6UGkb5L9tq5Wv6r+fMohiXg==
X-Received: by 2002:a63:8548:0:b0:37c:945e:2603 with SMTP id u69-20020a638548000000b0037c945e2603mr935159pgd.124.1646354186805;
        Thu, 03 Mar 2022 16:36:26 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g22-20020a056a0023d600b004c0ef29dd5bsm3702263pfc.107.2022.03.03.16.36.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:36:26 -0800 (PST)
Message-ID: <62215f0a.1c69fb81.549f2.a6f4@mx.google.com>
Date: Thu, 03 Mar 2022 16:36:26 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.100-cip2-319-gcbff87047566
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 9 runs, 2 regressions (v5.10.100-cip2-319-gcbff87047566) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 9 runs, 2 regression=
s (v5.10.100-cip2-319-gcbff87047566)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 2      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.100-cip2-319-gcbff87047566/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.100-cip2-319-gcbff87047566
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cbff870475669d78815941c2e765cc5a8b6078f0

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  faffae0b7edd5385c0c5ba08ff03e158aa9c1a1c =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 2      =
    =


  Details:     https://kernelci.org/test/plan/id/62214ec66580a8433ac6298d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-319-gcbff87047566/arm64/defconfig/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-319-gcbff87047566/arm64/defconfig/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220218.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/62214ec6658=
0a8433ac62998
        new failure (last pass: v5.10.100-cip2-239-g01aa183a119a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/62214ec6658=
0a8433ac62998
        new failure (last pass: v5.10.100-cip2-239-g01aa183a119a) =

 =20

