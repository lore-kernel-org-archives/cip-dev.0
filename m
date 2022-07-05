Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453D8CCA47B
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 21:10:43 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web12.266.1657055437832819965
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Jul 2022 14:10:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Rilixob7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id 145so12416810pga.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Jul 2022 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=bGNHp+FAZR8umSRMrr9r9XpfwQwWikGXM+8dEEK6LpQ=;
        b=Rilixob73P9Qad7HLg60gM2CvI4t4HCcHippWxnLzQ41my0fcxA4dEi/XxAGgLeCL9
         qAmSdV2r3SVIICjS58m/XzmGk0Lj7arE/3zGXhzCbDhmqfUarHMaAEiZ7q98/hTVdWzr
         S5rAIq61AUINQfh+diM1/ZKTD3ZOpxW8HreJ5SxiIkv3Mx38kOYdooVCjwmQ2/UBCvsG
         burma3BpXrWfFFCp2AyS7sQG1IcBkqAVev9s+ttUXVtJWk7t/besD18bH1i3mP5HseER
         ZNxtbaAQTyEGmtJ4hWdvfNDq/8e9YBKEZYx7lHJ9RdXrYqid7zH1CxqXGK5+CB6koMWy
         cj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=bGNHp+FAZR8umSRMrr9r9XpfwQwWikGXM+8dEEK6LpQ=;
        b=JadcMCmi855WwAqfM16PcjefUrsuUuh1tpdeMfZZJyBFEXes+FSHyLjZrviNGbYxlX
         7zNGDmx7tZOx6nTAchEqW3dYySXVKDPdT/OqtKpA4X7qW2PP7yyT3clA85i8MK6vD2i/
         k2x/04X/p/EM7srr+emWzcGLsm72cNHb7/lrdPFkmUXRLVCVuWE6xRKBIKnm0Vrec64a
         f8eYMBa4/WbDAr1D+mY38P3k37WXxAHuksTexExbjIAJ08oy707BEzEmCoIYuGY2YPpT
         poNqw+NivbtNEld5kCZfXec2yxX7ZoSeEBSMjgj0xsANyUaeEByLQSceYGasjI0tfm6L
         6YRw==
X-Gm-Message-State: AJIora8wNdr3ELAAd9znXPRcKRDVJZ00hmREe5tAxPvGky9firtwMd7m
	6qFJ/s8pxc2L1b9Vlc0poWItQXtjIv4i33Yl
X-Google-Smtp-Source: 
 AGRyM1uGTEjv5BylrAA2q0CTfLjwm+xBdD+Azhcc9X1z6P97C8vYaAhEZ2SojlbNTDUc4I8+bWXDXQ==
X-Received: by 2002:a63:1360:0:b0:410:702f:d1d4 with SMTP id
 32-20020a631360000000b00410702fd1d4mr30979703pgt.625.1657055437143;
        Tue, 05 Jul 2022 14:10:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 4-20020aa79244000000b005252a06750esm15812959pfp.182.2022.07.05.14.10.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:10:36 -0700 (PDT)
Message-ID: <62c4a8cc.1c69fb81.5e875.6fbb@mx.google.com>
Date: Tue, 05 Jul 2022 14:10:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11-1-gc5218dc69ff1
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 6 runs,
 2 regressions (v5.10.126-cip11-1-gc5218dc69ff1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 21:10:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8692

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 6 runs, 2 regre=
ssions (v5.10.126-cip11-1-gc5218dc69ff1)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.126-cip11-1-gc5218dc69ff1/plan/kselftest-=
lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.126-cip11-1-gc5218dc69ff1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c5218dc69ff1f0703b893c079a21669841b479e1 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c498d17b185f7500a39be7

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/x86_64/x86_64_defconfig+x86-ch=
romebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-=
rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/x86_64/x86_64_defconfig+x86-ch=
romebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-=
rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62c498d17b185f7500a39bed
        failing since 11 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c49364ec2b0292a7a39c1e

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/x86_64/x86_64_defconfig+x86-ch=
romebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.=
txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/x86_64/x86_64_defconfig+x86-ch=
romebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62c49364ec2b0292a7a39c24
        failing since 11 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =20

