Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBBAC43334
	for <webhook@archiver.kernel.org>; Mon,  4 Jul 2022 08:22:49 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web10.70001.1656922964536682343
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 01:22:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=A9T9AUpy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id q82so1116880pgq.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 01:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=IvZs0RILlXbHh8QRAJP2KM99jWALwmccVoM4Hin31kE=;
        b=A9T9AUpyAQGM8+gwlSBYoA6ibzQMZxt/uO1+gpf0eT65AdcGJ+dwHmrs+LoaALBQ5y
         w2WtHTT1I5oMh3lOqw91jjTqKKqY75Xdml4ILa9KiOnGDydV22FvvsJUdwZswhiv8QJr
         JYn3vdk36jAIjhNoeY8+ZOT4TmY8NmFCx31YANQWPJp/FyUvZ/oWlIEO88yqKIiRqDN0
         H6m4+e+UAz7GUWMzInx5UzybsT8L/zNqyE6jpC0jKf7yMLR8Nut8PmId3Z9RtxEMZiO5
         B9TgjaGd5LiY0a2y1whz4ccLhtSOW7Gp+//mEFn9LWIi9isaRmN9pLYvRBtOvuCr7z6E
         V18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=IvZs0RILlXbHh8QRAJP2KM99jWALwmccVoM4Hin31kE=;
        b=slkPPpGb+/gGq6dNgdQRqNx/ZKPU9pcRDvHdHR9pak4dM1ySi5MFIkqHweKxq1OXc1
         RaPZHkLNyC2nP9zhTV8m58/Bc8FnvU3oW+KKHa/h0Mf/p8hq5cDRFYJfxbLj07xmYif5
         DwBGS+hdAdZGZpbLY0ILfZWe7UzFgZ2t94SUvFyvQX5DiCJ94ac0UMN87htmYJSm0o5V
         J5hpp7UEqBc5MJv2uhEnpQfoR3Xy8xoRiO+8CuxSnJjLHm8T+EUlJAwXqqP5tzH/JEXq
         EG1aB4PmlT9Ej+0QHYqizaldeV+h4pZqmgf9mVETzoodjPGrgjmpscABfYCEcqodlwx3
         U1QA==
X-Gm-Message-State: AJIora+ptxvEVlGge74VDWSJb9u3Y2hoXToY1iva3paGZXr80w2JH5WU
	Nse4y+qAFL1/pWTmn76LkzHyNp1XVGeA8wsC
X-Google-Smtp-Source: 
 AGRyM1vJV7qKeSNxamB5kpZehM0oPNF4AgVaq47KE3yoLj/DwN3I3CCRWiiM+X0O1ZODosBBl+lWrA==
X-Received: by 2002:a63:2cf:0:b0:411:eb00:9026 with SMTP id
 198-20020a6302cf000000b00411eb009026mr13394382pgc.458.1656922963876;
        Mon, 04 Jul 2022 01:22:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 u2-20020a17090341c200b00163e06e1a99sm4632195ple.120.2022.07.04.01.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:22:43 -0700 (PDT)
Message-ID: <62c2a353.1c69fb81.e5205.61f4@mx.google.com>
Date: Mon, 04 Jul 2022 01:22:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 6 runs,
 4 regressions (v5.10.126-cip11)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Jul 2022 08:22:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8646

cip/linux-5.10.y-cip kselftest-lkdtm: 6 runs, 4 regressions (v5.10.126-cip1=
1)

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

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.126-cip11/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.126-cip11
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      400500e48ef52304feac8a819c6c911660ce59d8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c292fc90c903541da39bce

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62c292fc90c903541da39bd4
        failing since 6 days (last pass: v5.10.121-cip9, first fail: v5.10.=
125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c29503a10acf44eea39c63

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62c29503a10acf44eea39c91
        failing since 6 days (last pass: v5.10.121-cip9, first fail: v5.10.=
125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c28f0f6b96d3985da39be1

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62c28f0f6b96d3985da39be7
        failing since 6 days (last pass: v5.10.121-cip9, first fail: v5.10.=
125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/62c29b87f9eeae8bb5a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/62c29b87f9eeae=
8bb5a39bce
        new failure (last pass: v5.10.125-cip10) =

 =20

