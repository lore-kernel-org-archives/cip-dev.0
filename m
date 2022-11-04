Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A81C43219
	for <webhook@archiver.kernel.org>; Fri,  4 Nov 2022 09:23:49 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web09.9151.1667553825404247298
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 04 Nov 2022 02:23:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=s7zIUSbo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id k7so4348659pll.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 04 Nov 2022 02:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7zO7cS0vze7Vq/q0JlIAkcjAHSyAYQ/mUrO7e4S8+8g=;
        b=s7zIUSbop5ttjAqIQp2RxOyHOVOnOU/lWSWYKVAxmFy/wdiYzK3LdK5EKPhCnkfYDJ
         gDGRv0s4efoRmM3/mNB1WBNWmP6GMFq+mtDRuMagZbQUB6cscVhS5jO2kMa2sYVa3w4F
         /VwstlfODBpKFa0PTDtehgHxwFF8IcDkehqnYNgyGtunO7UXNR4jCHE4dHtYe9xsKayj
         HLBv3kHk6l684pgB7IqpDeGSIfrlqs7ImPWQEr60RoF210rlIMDeyOjSY9IqqtLUhGos
         N5Ebe0Dw0QtOQhe4qZw65vSZBSz7g6EsDRo17KpgDc8f5WNQnmnJVuOrDQVFh5XAa+pw
         m9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zO7cS0vze7Vq/q0JlIAkcjAHSyAYQ/mUrO7e4S8+8g=;
        b=5GAeWB3lsNUbVhRTKOVmb5mroZhSiGJQOlK+iLSUgjPtfnVnlmpq9akqdQpEE5cxF6
         ZmcnUK+nGBczpldC+Heqqsg3NGqurXvzqT3jBBeqrRfYF2ytSmGEGjCw4FlrqwmHJJ4u
         dNToWplsKgWSxmPXEQL/FaewzVP/b5wETL3zV36Rof7n4hI2Jyttb/mx7CPM6zv5FMNi
         PxPOGJXhVpt7i23TPmbe1ycVvxUbEuDjCcRDs9e9+ambuTtepzV+g8PJ3lkMVmewBm3A
         Bm4GC4MxqFubEKyuJ3CyJOvsqZk0AhbEwrQYPq/gze87u9Tf9hf+bVIe4jmV4U87mdK3
         6RzQ==
X-Gm-Message-State: ACrzQf3ErpQhciIU+b1PlnELNo7W2Edbv4GaIInhhfw03+RhDL5u2ocr
	EQeThLRshrA5JcyaoVn+P0b3hHmwp2y71A==
X-Google-Smtp-Source: AMsMyM7xmbRDCdD0CNB67p6JhgpkMCVRssqMhWmF0oIEEzdNfJeOcsXutuMhS5IlzK34mX+a30XHUQ==
X-Received: by 2002:a17:90a:8a16:b0:213:bc0c:74cd with SMTP id w22-20020a17090a8a1600b00213bc0c74cdmr30858753pjn.28.1667553824823;
        Fri, 04 Nov 2022 02:23:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n184-20020a6227c1000000b0056b9df2a15esm2225787pfn.62.2022.11.04.02.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 02:23:44 -0700 (PDT)
Message-ID: <6364da20.620a0220.a0bd1.43f8@mx.google.com>
Date: Fri, 04 Nov 2022 02:23:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-gcb2b164780be
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 3 runs,
 3 regressions (v5.10.147-cip18-12-gcb2b164780be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Nov 2022 09:23:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9930

cip/linux-5.10.y-cip kselftest-lkdtm: 3 runs, 3 regressions (v5.10.147-cip1=
8-12-gcb2b164780be)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.147-cip18-12-gcb2b164780be/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.147-cip18-12-gcb2b164780be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cb2b164780beff6c4be7ccfd9020e39c07c44f3c =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6364c45f46855ca58ae7db73

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gc=
c-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gc=
c-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/6364c45f46855ca58ae7db79
        failing since 129 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6364c49984d8deba18e7dbd0

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gc=
c-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gc=
c-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/6364c49984d8deba18e7dbd6
        failing since 129 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6364c48484d8deba18e7db5d

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gc=
c-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gc=
c-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/6364c48484d8deba18e7db63
        failing since 129 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =20

