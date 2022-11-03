Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AB6C43217
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 10:33:51 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web09.17845.1667471625603194886
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 03 Nov 2022 03:33:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=zlAPcGD/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id j12so1505439plj.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 03 Nov 2022 03:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=srjhEkEaICMOMn07/0xPXNU312YiaXsr+8BOO8P7vAM=;
        b=zlAPcGD/l13+bzEQ1nUs9Y57npce8fvlk0u1SfP/KfHRTwuyxAWIRsfSAz3QL7yTU9
         TelwoR/j8F46ee0aGaZUrv7ysxbzVKBw0hDsCFyLnlVG+vgPchTQJH6sBg07jvnzYfIK
         H63toQNj4IRstvsb9RIqKX9BoVMm6iXea5kIQti/Q6tWEeP4AzVHeT0FbrnNn3az91Kn
         c+zBMDLjrmN7D76I5ptmR2M+oW+VmCqBftVkd2xD32ub0djFb+yaW21zUkPVwvTH/BVO
         xzxOAjAsm9Ks4cngKB9ZzOg/C/pMex4FkkOYwhH9tdkpPo2R0jXImpC5/KZAi4Mdt3nD
         qhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srjhEkEaICMOMn07/0xPXNU312YiaXsr+8BOO8P7vAM=;
        b=xZcPogqL/vzCBW/cfom/Kd1IsYCwSLjwTgYrBC9faMS9zo6akciTIULaoG8Z8TPy6K
         BsRKk0vi9gqIXDkig9q+TGDBHYSigpyg41bo8fuO8g1vWFdrvNT7vElmBzRLnOYUnqt1
         9r6uWmblnMaDTJvqIMk9uw4IKmTldgnWo9CH6mNGU2AW99j5vNu5DZ49ByJzUlb6GY3T
         th2EjBhLhsBywicU6hIRtBRSf+6n6+eMY0a7+Fh+Va10Bc8+Cg72d6E7wO4EMaBeynsx
         rgqlEW7rznpV6/yGtyFcHTztUNVOOrZYT8RqWUabyhdlIrwQuskLg3KUSgJU9xr6D4Pu
         bTVw==
X-Gm-Message-State: ACrzQf2RI3GAtbjrVNL6+BS3tWWKAZ3X4UCIAQSye3sesmvd36N35s9H
	uBCMP1uWW9c9Sbht0QMp5Hi1SIQK5ZbEDV04
X-Google-Smtp-Source: AMsMyM6pDGX5fJHG9TMb8yR3zopJcRoKLI1PfcebKslugM8NnC86ZPZXF92XtIwN8u8vi3vWe//2rA==
X-Received: by 2002:a17:90a:d493:b0:213:ce33:4a4d with SMTP id s19-20020a17090ad49300b00213ce334a4dmr23922597pju.140.1667471624705;
        Thu, 03 Nov 2022 03:33:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902868600b001866049ddb1sm290045plo.161.2022.11.03.03.33.44
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 03:33:44 -0700 (PDT)
Message-ID: <63639908.170a0220.4b7a.0629@mx.google.com>
Date: Thu, 03 Nov 2022 03:33:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-gcb2b164780be
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 8 regressions (v5.10.147-cip18-12-gcb2b164780be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 10:33:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9909

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 8 regressions (v5.10.147=
-cip18-12-gcb2b164780be)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.147-cip18-12-gcb2b164780be/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.147-cip18-12-gcb2b164780be
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cb2b164780beff6c4be7ccfd9020e39c07c44f3c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b79157c8375cfdd2abfc59f63afe8ea09eaa8c5d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/636387b2d067e590f6e7dc22

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636387b2d06=
7e590f6e7dc27
        new failure (last pass: v5.10.147-cip18-11-ge6d27ea102c3b) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636387b2d06=
7e590f6e7dc27
        new failure (last pass: v5.10.147-cip18-11-ge6d27ea102c3b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/636389f7d93f879535e7db8a

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636389f7d93=
f879535e7db8f
        new failure (last pass: v5.10.147-cip18-11-ge6d27ea102c3b) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636389f7d93=
f879535e7db8f
        new failure (last pass: v5.10.147-cip18-11-ge6d27ea102c3b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63638dbffdeff91e96e7db59

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63638dbffde=
ff91e96e7db5e
        new failure (last pass: v5.10.147-cip18-11-ge6d27ea102c3b) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63638dbffde=
ff91e96e7db5e
        new failure (last pass: v5.10.147-cip18-11-ge6d27ea102c3b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63638b876b5f4e6affe7db71

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63638b876b5=
f4e6affe7db76
        new failure (last pass: v5.10.147-cip18-11-ge6d27ea102c3b) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63638b876b5=
f4e6affe7db76
        new failure (last pass: v5.10.147-cip18-11-ge6d27ea102c3b) =

 =20

