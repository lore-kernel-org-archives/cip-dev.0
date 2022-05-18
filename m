X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web09.1757.1652855031428636680
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 17 May 2022 23:23:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=OSU0eUw3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id w17-20020a17090a529100b001db302efed6so1061050pjh.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 17 May 2022 23:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=m/oV9W2Has5KyVcbPsbZ/bkW12mt0hMR8M3DxnKJJn0=;
        b=OSU0eUw3NFV1ZRj34yO//aquAB8gsS1XyrtUYWBlmaHt2/WfnDytuFeN9tz7J6z9OD
         rhACfp6GrrmnsJZUmazQw8wNuLvPc9Kwj+FWAMEmAG7keneCEYYjgx/8DpNNMVR/HDQ6
         2QoXsqBrN4ZIkIOaKIPLYADKugNlVlaSduxDjqaV99zv7Z0z1QuMpi+UV4yPSih7T4oC
         0T7nvbBlokmI/VLwZFeJCCgb1DYUFOPFyyh45C/r2rm6mLkMjPL/ihQLp2C67SM8hYw9
         TjxyLH6JOaQSfVF1TnKGpsBbPBZJzOedNwMlMz+vJ75SuahDAGUOChYiQvop0LOYUe6R
         u1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=m/oV9W2Has5KyVcbPsbZ/bkW12mt0hMR8M3DxnKJJn0=;
        b=ib5+DW59JRSTbx11XzbD+PHM/qM2YUGNIbHXouBSdqH+SXM6BH1qdlV2baRSAJVvLK
         4A6GsEc3SVaPi9IYOFJq+WRh++keoA/M7WaJb/J4v7zJY7S7FYSsv9CsATfgtubiZ2CP
         Nd3FsZJtcYXcVGPsJZW5Z2m8UMtcmI7h0XhoMsiB15nMpbFqDp5KA5sGhrsgXmKVlQ1g
         NIZHMr+u5Amd9qcrdUgOITOBvhiDhcQPzqLKK/3tAIz1rIVQ/S9VEtpypDM9RaouQmnF
         cYU4RZO+DFZjgkpgnKIAtv9vJIdvCs/ybJtrbtW7Vmu+pNKWGgtwdvcDzpXsmKQNAny/
         pNXQ==
X-Gm-Message-State: AOAM5315zvwZtvL/yZkKrsoonLurHXJ+7XNAl48Nn31W6bukStqahUV8
	VFG3d6nro/bIhVVKW2oXRRetXWYhMr0fMGhciRw=
X-Google-Smtp-Source: ABdhPJwAQpWB5Rtx1R/oX0gxz1IT/RBxLXeEmcBcuUgoKKk938atYxnSQw5HCY8M8lC0zZD4xiRhIQ==
X-Received: by 2002:a17:90b:3901:b0:1dc:5a24:691 with SMTP id ob1-20020a17090b390100b001dc5a240691mr40400012pjb.40.1652855034309;
        Tue, 17 May 2022 23:23:54 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p10-20020a62b80a000000b0050dc76281b5sm905483pfe.143.2022.05.17.23.23.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 23:23:53 -0700 (PDT)
Message-ID: <628490f9.1c69fb81.64bdc.2ba0@mx.google.com>
Date: Tue, 17 May 2022 23:23:53 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip69-296-g52de9431d314
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs, 5 regressions (v4.4.302-cip69-296-g52de9431d314) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs, 5 regressions (v4.4.302-=
cip69-296-g52de9431d314)

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
nux-test/kernel/v4.4.302-cip69-296-g52de9431d314/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip69-296-g52de9431d314
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      52de9431d314a28c4aa66d8f81144c9958c11168

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


  Details:     https://kernelci.org/test/plan/id/628417aeb264ef5c19a39bda

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/628417aeb264ef5c19a=
39bdb
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62841cad9e03d25ecba39bd0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62841cad9e03d25ecba=
39bd1
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62841933f4b39b6034a39c01

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62841933f4b39b6034a=
39c02
        failing since 3 days (last pass: v4.4-st5-49-g02cbcd6511d4, first f=
ail: v4.4.302-cip69-50-gba851b77071ca) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62841d5e0637d20df4a39bdb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62841d5e0637d20df4a=
39bdc
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62847a6a90c977553ba39bf8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/ltp-timers-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/ltp-timers-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/armhf/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62847a6a90c977553ba=
39bf9
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff) =

 =20

