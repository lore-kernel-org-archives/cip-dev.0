X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web10.49.1652717115542758398
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 16 May 2022 09:05:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=coyKVaQ2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id w17-20020a17090a529100b001db302efed6so14828254pjh.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 16 May 2022 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=sd70ejDmoqGji3MQWfatidCnHWGauVRdQjM3GaFyV8g=;
        b=coyKVaQ2np4ZEI1KLq24owiVpnb0wBecG1JUctMYTJ18JDcPz7lqIobD5O+iIzMIEH
         LRTpuAGusDZDysCMhhJ2fn0sskrHEjVpihvjPIvkjozMqo5oV+Ofk1qIVks+iIubbsoB
         /p+n9108nQ2d8bc9CE8wdATbeN9fWhbOlPtYo59Qb6SYUyoM7636RzL57cVDEuFHc2hd
         60B7FyFLJnnLF8N9TjYQaoBIhGElxQo9Xh4vPgHxSnuDPfxll3KcgDVTd/LnzrvRDhT5
         N+7I7ceC/EAV0OElYcu1zfmQMDZplswtAL76u4Z3iTx0b/QMxkszOdM4NxyjaZyyznu6
         Nu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=sd70ejDmoqGji3MQWfatidCnHWGauVRdQjM3GaFyV8g=;
        b=FQcJXYzxuQ1elNSZJdHTjn4lMumW7xHBVaLrIq7Kp8LXnZnoi30TYR9Jmq9dykplsk
         snLxOvQAVlPjTH1rHCQNPd9AwBLENFzWVTCOTQ6D35ruRnx9WWVJxXivB11hVhookIwG
         dcM4KnUExP0FckOLhnxcBw0hSk2ABDTihkHGfPLcfq0VelKSxXlc8P/TOS9W+Ef9xRtj
         6AD4hl0n65KcXRfLSr9IajrOzZmJGvuxs+G9ix6jaVU4JI4sxkKlSmLh8ZJXK68mCUTm
         MPbLoKNnnXwnz528/mShycuMOJ3S/YtX0ehX1klmtGtDvZQjp9W8DrYNK8lx8hatzR6p
         O/6w==
X-Gm-Message-State: AOAM531SISFfm4h6DceAdQLGLgdD1uU7fKT3uggbjEU1oNubtPZYKvsW
	PlVRltzimyMvdFC4jurLzS8TkdPmf6JCoVPzhkU=
X-Google-Smtp-Source: ABdhPJz8jIHVplbW/wmT/GwJWMQ2ShhSTF/aqlTF699hrO0TVldYodn5sfPUYt2+k2jcRYDo6jn/1Q==
X-Received: by 2002:a17:902:c411:b0:161:929f:b0d1 with SMTP id k17-20020a170902c41100b00161929fb0d1mr2629621plk.3.1652717114728;
        Mon, 16 May 2022 09:05:14 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c22-20020a631c56000000b003c2677c9c9esm6788341pgm.67.2022.05.16.09.05.14
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 09:05:14 -0700 (PDT)
Message-ID: <6282763a.1c69fb81.2d2a5.0426@mx.google.com>
Date: Mon, 16 May 2022 09:05:14 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-208-g5e70bc68d09e
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs, 4 regressions (v4.4-st5-208-g5e70bc68d09e) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs, 4 regressions (v4.4-st5-208-=
g5e70bc68d09e)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-208-g5e70bc68d09e/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-208-g5e70bc68d09e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      5e70bc68d09e77ff437512cfdec26dcf5710d90e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  17e9ae697a340242c49188ace12a60cd3bc95a53 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62826cd04d64d1dfd28f5750

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62826cd04d64d1dfd28f5751
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6282681ab5be6e44238f575e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6282681ab5be6e44238f575f
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62826c5413a4603d6c8f572a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62826c5413a4603d6c8f572b
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62826fafa72f3edf2c8f5a64

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-mm-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-mm-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62826fafa72f3edf2c8f5a65
        failing since 34 days (last pass: v5.10.106-cip4-69-g05f5682c2c593,=
 first fail: v4.4-st5-2498-g49524d978f8eb) =

 =20

