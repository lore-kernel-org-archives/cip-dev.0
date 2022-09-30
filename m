Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E408C4332F
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 15:52:08 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web12.565.1664553126833582893
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 08:52:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=wCbF3WA6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id h10so1601454plb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=C+MmkIwWGPogosFqGwhefRSGxpAXpXCg1Xzdlh4jWJs=;
        b=wCbF3WA61dKR9tNwrlvSYyc4xTAKMgi3U495iyt8TudNb9HF1M7bCkBR08S5OO/VCf
         MRFWIKH6of5D/a94rYUwiAPJP/BtdLU6NeBOXgAcSRrQplrH8JIK0bXxvtX8SPVo62nx
         Awk5GaIhPCX42gz7E9UemUjcWYgGIvzGK/RhSAXreUh1LJZis6bGpf7t6L5osbvlWvlz
         1Ck/PAk/QemCLxXaenPWe/B94cjej+1ete8JtduGZsM3q1RPLulYXideHwKapWvPsykz
         JyjkkBn0+1oNH+hnSzwbmuf6MPO8cIouOWhIU8JMf1QhXVQuUa7cuwlZoGyv/7o3thY2
         0CoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=C+MmkIwWGPogosFqGwhefRSGxpAXpXCg1Xzdlh4jWJs=;
        b=0hccn+f4akd+v618TaCJk8c4X/p70yHJqk1fOJbGNeychrgT4u7aqbVMNnVlEhGBKE
         DSrueKqKobgKn3S3qNQ4VuhEvU+lenGaWxQsf80+j8UeTDVXVbTZ0yXXG95vIEo7EBCD
         IlTZISaRXk+9P7sCxLxkqGxMR5GcD7xJzkFdIgbeYSosmfFeDUnHxk0F1V+M2cjtyY3C
         wEFND5RW+AQmwIVgrKEoBvRsELF1Apdl6wqGKdIJIl89R06nejN65qcx2qIRCjg7Z6Qs
         cLaKSTpddfQ/vljHTxhyQSfD/VyHbjF1J4hsF6RBqwG4CZ3nnvRxjnVFOGnCYRGAFlOA
         Xl0A==
X-Gm-Message-State: ACrzQf2gcTevibO1U64a6FqAYWIr9l+OsWd4r/VeN0H9Sbm2e8ZepujY
	YafzgGwHhpSvO09ynscbzcRt/i8anRdk8O6qpP4=
X-Google-Smtp-Source: 
 AMsMyM44Z9HmVx8Ltkwn0fms7HzBRBam6GuE7FE/Mk5I0ZTEQFBKseA1xC2SdiMxrDmJ3dpDnTePng==
X-Received: by 2002:a17:902:e54b:b0:177:e29e:a0c0 with SMTP id
 n11-20020a170902e54b00b00177e29ea0c0mr9663531plf.66.1664553126144;
        Fri, 30 Sep 2022 08:52:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 f184-20020a6251c1000000b00537b6bfab7fsm2018180pfb.177.2022.09.30.08.52.04
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 08:52:05 -0700 (PDT)
Message-ID: <633710a5.620a0220.9fbe7.3777@mx.google.com>
Date: Fri, 30 Sep 2022 08:52:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip70-98-gb2bfffe124dae
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs,
 3 regressions (v4.4.302-cip70-98-gb2bfffe124dae)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 15:52:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9598

cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4.302-cip=
70-98-gb2bfffe124dae)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip70-98-gb2bfffe124dae/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip70-98-gb2bfffe124dae
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b2bfffe124dae9fd793da3a9d45f286a98412d6b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6337064be9bb6e5af5ec4eaa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6337064be9bb6e5af5ec4e=
ab
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63370947b10f11656aec4efd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/63370947b10f11656aec4e=
fe
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/633706ee286d575839ec4eb1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/633706ee286d575839ec4e=
b2
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =20

