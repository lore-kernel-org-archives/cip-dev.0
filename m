Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD029C25B0E
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 11:22:05 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web08.9449.1660303323415340935
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 04:22:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=uEN/eBMX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id
 q7-20020a17090a7a8700b001f300db8677so618905pjf.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 04:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=fBGAU8Q3TvK+6tl5tGG8tYwr0W+nM8g87vqfLg1Z1mg=;
        b=uEN/eBMXWO79ckn2JnDSLPLerjRWwTslYhDTeBbHbWRGqlNHe8mOQU7v2NWUx01sJH
         M0qQPKAJ2g5qtzvL3/mOOIDXiYeeXsQC2YLkzvdMO3EAT6nqX6AKOecIUfLje0my3e7u
         njf1fJCN1MPmn7I3mSS40SzLPOlh6FDS8RDDgc1/TaQ6X0XdJkG1/0sNyN4kNASI0l5S
         dxgtj3ySw8Hm5A2uLT61wRi2vQIX5pDMTljQDxMyWhAkGPhUaJ39ZGrteH1FjpKbPFzK
         Xg67of8YgJQy+rhxbtkLs5XIqPGnebYZkuo9m43yn4KBA7wrk0ecBntd3ETklXGT3mu8
         kbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=fBGAU8Q3TvK+6tl5tGG8tYwr0W+nM8g87vqfLg1Z1mg=;
        b=Z7qnAlcyyvVBVUSQLR56ze9x/2zVtxBhenBbKqUHGvasUv5QxhZV5nxiFuIrDXVXpF
         kNkmGUe361ApgINyJCH/YK1SHV0r9lOlksBW84wuOvKeKpsEKOZiPfQcjkTM+uRn42En
         LJXHfQN6y/0bykNRYUAws3PdwlvfhNwlTfFBMmipA1hji62drkj1dAr/8IHmhh2aXUbM
         LCI4t8GiEFdJ7yaycFG2wBJGjqc/3FerY5J81Cy2QE1aQA69sJnrPUVmcOqsnasimLpK
         igGR9zFfHJ7rE9YB0vxs6jloCUV77k7zHQPpq+3w9/JIwxWhfJ4FU+yatjjUUTzO9LEh
         2+FQ==
X-Gm-Message-State: ACgBeo2yoMSDI5VLl8iUQazuUKzkIp64SXS7KaB7tEp1vx/eUaLrcpCV
	isEXiYU5V+MXF9nOZp+p8eaj3BFyY5NT5SXR
X-Google-Smtp-Source: 
 AA6agR50xQgIZEutRhLUmArX0IZ5EQq/Ljxo8O7kwuYi9bEdYDlMVUW97UI9/8BAB4KnsGjk68mxUw==
X-Received: by 2002:a17:90b:3a8b:b0:1f5:2048:cbab with SMTP id
 om11-20020a17090b3a8b00b001f52048cbabmr3568464pjb.196.1660303322742;
        Fri, 12 Aug 2022 04:22:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q11-20020a170902dacb00b0017128185043sm1479897plx.191.2022.08.12.04.22.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 04:22:02 -0700 (PDT)
Message-ID: <62f637da.170a0220.9f1f2.27a2@mx.google.com>
Date: Fri, 12 Aug 2022 04:22:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-96-g74ff989472f09
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 9 runs,
 5 regressions (v4.4-st20-96-g74ff989472f09)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 11:22:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9194

cip-gitlab/ci/pavel/linux-test ltp-timers: 9 runs, 5 regressions (v4.4-st20=
-96-g74ff989472f09)

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

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-96-g74ff989472f09/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-96-g74ff989472f09
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      74ff989472f092eb06514e780a28645e8310d183

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  7e71b2c4b9a136602d9774c13097f5e06f6f04a9 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f62226335bc8adfadaf088

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220805.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62f62226335bc8adfad=
af089
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f622d753d9cd9a0bdaf08c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220805.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62f622d753d9cd9a0bd=
af08d
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f6292e474f07f7e5daf078

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220805.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62f6292e474f07f7e5d=
af079
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f621d6be7961fd96daf06c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220805.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62f621d6be7961fd96d=
af06d
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62f6236ff075de92efdaf063

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/arm/multi_v7_defconfig/gcc-10/lab-collabora/lt=
p-timers-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/arm/multi_v7_defconfig/gcc-10/lab-collabora/lt=
p-timers-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220805.0/armhf/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62f6236ff075de92efd=
af064
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =20

