Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D29C25B4E
	for <webhook@archiver.kernel.org>; Tue, 24 Jan 2023 13:36:29 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.14838.1674567384628387327
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 24 Jan 2023 05:36:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=skbo5gDP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id k13so14794003plg.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 24 Jan 2023 05:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AFmg53ftHNl2FFKHgs/s1LmR6ZCgzkLoSn98xZaqyyo=;
        b=skbo5gDP4O51BBmia6neDP0FIhR0a7yT01ZucS1w/29HT5k4aXAMNZJjeqf/zgoXr9
         pd3JC59/nDdsMHX5ze4FdZgLMhmBmPmrgzEYYMJ0Wd8TIp6rjiZFJJoyOHPT2c8JMf9J
         yKHHYKV4zMVRXtyqghrh15mqYDHAqKtSRM/QYsPCwcHNEdavuJpMwNBy1VW3RtebtKJZ
         x5A2MnbnHJPGt0zat5iATf1imLqg5azHuOr8URSlneqcJB6K+UTLrZ6jcl4dtoryr4ov
         NhsYWIs7wf1SynECwaRVi3bQ4copsNAJXKU6WsJGwFtuEW2UCZ095mw42HJ3mbLyiWcJ
         6SAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFmg53ftHNl2FFKHgs/s1LmR6ZCgzkLoSn98xZaqyyo=;
        b=OUtgWG4p4TznArK123tfyX7ySRewyXBZjJ4IJOJU2rm1SOHHOsduq8/lBfZlpH3CNT
         90cQhF6UjZomWmP1pyotUHwkYfWPCCIHBU1MOfy8g1IH+8cHGm6+dDsNL3p3V/QecFjw
         4enZDmplPNqbEn7dNcYbvl0yg8kSn+1Ggc1zvs7ad+9o28NeQnamh8uIeWq+sZ3nHoDB
         dmLpu6BGpa7PosUcsGEThr5eyanL701sXN8RXkC241cui7Wd07FB2cAU1LyCigq7Tn/e
         cjCDMsjvgXP/MgY86ZZt/AXsbgX8l7KnWSe3s+UkuPu+tsc7I1wE6Z3NG8M1b6HbeDmI
         mwig==
X-Gm-Message-State: AFqh2kqmCZlnAhVoV9D0VB5U0p81KII2qpLulpvx2eTSCS/IwNQxGFQh
	1vvylCyczO12Xt1JMBJBTcKIUxPDnnfp976I/VA=
X-Google-Smtp-Source: AMrXdXsypZ16cmAoM/qSjhQtouEpT7xskk45++xTIQP9FrM8hIZ9KbZnTHxQ8KLwuNG31iWxwsZAeQ==
X-Received: by 2002:a17:90b:3c90:b0:229:32de:981e with SMTP id pv16-20020a17090b3c9000b0022932de981emr29955251pjb.10.1674567383678;
        Tue, 24 Jan 2023 05:36:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090ac08900b0022be7a9e196sm1624488pjs.1.2023.01.24.05.36.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:36:23 -0800 (PST)
Message-ID: <63cfded7.170a0220.fe3a9.2e3e@mx.google.com>
Date: Tue, 24 Jan 2023 05:36:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.270-cip89-39-g43ce130174aa
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 7 runs,
 8 regressions (v4.19.270-cip89-39-g43ce130174aa)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Jan 2023 13:36:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10468

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 7 runs, 8 regression=
s (v4.19.270-cip89-39-g43ce130174aa)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.270-cip89-39-g43ce130174aa/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.270-cip89-39-g43ce130174aa
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      43ce130174aa6b725d4f63d43ad3736296ef2736

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  d042c168dd037bb0128b86ee4ac4f5c526eddc7b =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63cfcd1f47e322515a915ee5

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63cfcd1f47e=
322515a915eea
        failing since 81 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a)

    2023-01-24T12:20:31.864888     =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63cfcd1f47e=
322515a915eea
        failing since 81 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a)

    2023-01-24T12:20:31.864888     =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63cfcd210bd9d250f3915edb

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63cfcd210bd=
9d250f3915ee0
        failing since 81 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63cfcd210bd=
9d250f3915ee0
        failing since 81 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63cfcc3cb566f66414915ee5

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63cfcc3cb56=
6f66414915eea
        failing since 81 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63cfcc3cb56=
6f66414915eea
        failing since 81 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63cfcd93fa09c66a55915ec2

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63cfcd93fa0=
9c66a55915ec7
        failing since 62 days (last pass: v4.19.264-cip84-50-g1e56b70eaf66,=
 first fail: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-24T12:22:21.233243     =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63cfcd93fa0=
9c66a55915ec7
        failing since 62 days (last pass: v4.19.264-cip84-50-g1e56b70eaf66,=
 first fail: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-24T12:22:21.233243     =

 =20

