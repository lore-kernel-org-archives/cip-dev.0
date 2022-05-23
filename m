X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web08.31100.1653329245156801897
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 23 May 2022 11:07:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=mmPY7sWa;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id s14so13793775plk.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 23 May 2022 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=cPPWIvXbJLFEN4ua7xq/Cy9I+oWqfCDf7dncf2wYCec=;
        b=mmPY7sWaL3alo3WGVMt2X9kg+oMM44G4r9aShAor+4yLn/Hbv8QKLJ0au5grln85oc
         DuNEvhyABvsVeAKAfnp4xVtGNh7KchxTku6rLEEdCBLNv+oiZYgPSr3nBQePVf4gHQrk
         0HRKfTVlo3b4A6raBKqsOltbrAS0ZhpuesoBTUIUSvZzo7H62vrbvVAuqkUSKvLs8mZV
         0Kdp8qhEVkSy/g0oixMI/BuoeH2IQzYkzCrprsXZLHWWzrlRv5zZlerqZCbbh+FAD81C
         95np7slJGQEYOb0We46+um/tGiEjHY2LpYYFQHLO2fQFaoE/OAWa9ZCHpruHm42dv1JO
         XbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=cPPWIvXbJLFEN4ua7xq/Cy9I+oWqfCDf7dncf2wYCec=;
        b=0hg0gZAwED8ZKW7nhK9nzqv0zZ7gd3V1AhJB9icydr7NIcQXpo64YTPXBrEZ/Dcggf
         rUiXaKKcqhCm7ZX62B/Zh9HF715/BMHX9VAVjFHvNfz5gPiIXEHh3O3qiRiAf9TA7WxU
         pkVc4c2d0TzqcQs/DkaG71By1d6m1yjHf4ySOappiunFoaM5OUJ+p3dbiasXbgNXfuR2
         4Z3YhyD4Pc4uk1FPywB1MlphKsqFJT8DK2ShMOoKeWb/0ir985x1OaqsgS1bCHOv48XS
         uDl1jLtHdXxOVkEYAKopD0sy//FoXK2uC4jZ5j/fx6LGT9dac5WB52SnuBt7SLXMADQL
         4Hwg==
X-Gm-Message-State: AOAM531yckURI1znh3VOiSknzzDB26oJquC2z1UKSNpn3kAhJkhnuT+L
	6Godyc8fz+N+AZO8TBKzzaZbIWNaxmVhNQzgpf0=
X-Google-Smtp-Source: ABdhPJyrjrffBayXn3ULK6nUhRqqpuH7crdR1n+rqC2Df1HiFdxxS8SVZJx7SKlVUdm9E4cqy57swA==
X-Received: by 2002:a17:90b:4c09:b0:1df:b7a0:e5f9 with SMTP id na9-20020a17090b4c0900b001dfb7a0e5f9mr257359pjb.76.1653329245715;
        Mon, 23 May 2022 11:07:25 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b184-20020a621bc1000000b0051826824d90sm7720382pfb.177.2022.05.23.11.07.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 11:07:24 -0700 (PDT)
Message-ID: <628bcd5c.1c69fb81.b9fb3.1da2@mx.google.com>
Date: Mon, 23 May 2022 11:07:24 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-1797-gb2b8419761095
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 5 runs, 3 regressions (v4.4-st5-1797-gb2b8419761095) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-timers: 5 runs, 3 regressions (v4.4-st5-=
1797-gb2b8419761095)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-1797-gb2b8419761095/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-1797-gb2b8419761095
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b2b8419761095643d782c4cb4a982131b3efb6b8

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
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628bb746e8e67f6996a39bd9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/628bb746e8e67f6996a=
39bda
        failing since 12 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628bbb3c0d18c63212a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/628bbb3c0d18c63212a=
39bce
        failing since 12 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628bbd8654f4d1fb5ea39bea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/628bbd8654f4d1fb5ea=
39beb
        failing since 12 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

