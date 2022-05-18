X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web09.1758.1652855032206506096
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 17 May 2022 23:23:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=oH6uo17u;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id i24so1229437pfa.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 17 May 2022 23:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=aPkuSqObDaNruERhK8B6fMhv4OD+zeokYakhSI1z+GY=;
        b=oH6uo17u1DPMfYkE95TVm7+8JHtSw4YniWHkfGDM8V3oNrl+K2JpMQg8nv77CKJ4dJ
         y9rEuIxHBAno0BJMnEI4wyWjYCL2vZj967oIjsQ6mLqWgnYGEO1k3D/zqMjg1dVn6Rb7
         pQXLoJxmdoQoot5oJsfsste41NVvgHbji5hpDJ9fyWf3WYKVx4+62ZfFtXJBs0zf9skI
         J5EqnK2b65PWTQKuvMcpf9zoxiQenvPxvGg5Yb7mCtBnDi5FOu5P4dOnX1MRtUvI+iZW
         DcjiKRrNVaQHxPrdCVJulcBdDWflE+G4mqH30c4A79gQi9ebzSf6ZBSQv8Taug8sHWh3
         /rqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=aPkuSqObDaNruERhK8B6fMhv4OD+zeokYakhSI1z+GY=;
        b=5Zrnk0LDrDMN5Eb7IqHUjcxaZATz+PhHlnFZGf5oB/BNaKvz/aXHxFluzHb8/mgOkp
         OwGXpzl5BSKc3ZXKKvpfhoeE1OP9X1m5MN3TWzIAoEc1e0z3xCdQHjUdRCYJcVd9iz1J
         e5mejskUPDycXYKUuM2UHUChB3E+tTX6RnkC8V7xFexL74dtiR3rgWc+o6hNKcIpAHDF
         sWStEIwdP8AULwSsNdpOe0BbzyDTDpt+fBRRwq881cqZB/Z6o0pdYGFs+7a584i3WBUR
         +yu6KvTdtb9TwZ3EZc50UAzRJ4UjVHUhKDKtH67omYbVfSQthykiWpt9ZZIfdOgzszxP
         9OCA==
X-Gm-Message-State: AOAM531l9+vR0pFzIIiCfe1ypvq4OR2L6dxTt1/SU1wkrQ9jQ+LnHUeB
	D4P41+1tRS4yiQj31mlVP0tN8Wvjn8Iv9HH7jaM=
X-Google-Smtp-Source: ABdhPJz9ycYTP3txaT//9NGATmBETLlPa47w6xzni5xz0RvO337V6rufLWfLsKfryJ+qfuARbBooxg==
X-Received: by 2002:a63:311:0:b0:3f5:fc27:664f with SMTP id 17-20020a630311000000b003f5fc27664fmr1865820pgd.606.1652855033895;
        Tue, 17 May 2022 23:23:53 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902684600b0016156e0c3cbsm708083pln.156.2022.05.17.23.23.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 23:23:53 -0700 (PDT)
Message-ID: <628490f9.1c69fb81.b55a3.21e7@mx.google.com>
Date: Tue, 17 May 2022 23:23:53 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip69-296-g52de9431d314
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4.302-cip69-296-g52de9431d314) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4.302-cip=
69-296-g52de9431d314)

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
nux-test/kernel/v4.4.302-cip69-296-g52de9431d314/plan/ltp-pty/

  Test:     ltp-pty
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


  Details:     https://kernelci.org/test/plan/id/628417421ed878445aa39bce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/628417421ed878445aa39b=
cf
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628419a0c78c02824ba39bda

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/628419a0c78c02824ba39b=
db
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62841db90582765107a39bd5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62841db90582765107a39b=
d6
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

