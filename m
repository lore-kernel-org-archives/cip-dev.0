Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60C6C6379F
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 08:15:59 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.78898.1675757757466092302
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 07 Feb 2023 00:15:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=RsdXWjlI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id k13so14914453plg.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 07 Feb 2023 00:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0imRXhNxqxAvZ3N0WG76RK+61vWOMezERMEt8F/t1Gs=;
        b=RsdXWjlIxaWWq2OiDbNmgTQ3dnCN1v7vdMvIcprm1JtL6GXkvyAIw7bBJIvE/iOMGX
         eBVVfhe3mPK5gU/eLfC1HywFt6/G1yZgJbvaIQUg4nO5yZk0GlOmY8QnWMhcrL0kOz7m
         O14smd6NTX4TRob+BrFf0Wr03rCZe6rBTAiJ/A8rbYp2vMq/XhLG9HT7P9HzZizmBQYM
         F8/dI/CbhLvCrWya7hxljMxwN8Dy3Oq0gclb0rFgsDXtdYiewdpF3zoC4yyOftLOWjFv
         Ce4/8t5UiYTLqsM7d3uHcv3bktDs7AC1kFXPkc+5mI3XBWhmq9MS5DvcW/QPMBBEOdRH
         twnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0imRXhNxqxAvZ3N0WG76RK+61vWOMezERMEt8F/t1Gs=;
        b=jnKuEkHeDVih8gb68p2yn5t3h8m6EFqCccawIik8ZtVyYLm89CmOJCeL4QPq0NYetk
         OBcE/CXMqp5WTPoeUjcz89+bL0hbvMrm4Vv5eimxcwAuhpGJvX9BEpUO/vUcaYV6nVCX
         XOHO5EGgT209CCJuFknufEi50ypbAEStlZH+ZJHICKgl8SV4C9X2TM41In9loe55K4uG
         Zl0943klJ2ihSdIRf2la2pczdESlYDCoAE7eqfKqDmTIkbl2CvzmOdzR/RmkixsSrfXI
         3CYhGW32GWkivJCk88QUpPyZSFfyyWaax5VJUtTtuT4bl8BLvxhoPijLQG3zAHL07lM/
         bw4A==
X-Gm-Message-State: AO0yUKWYWP9W+gYwS+yiok5u9Jd6ZDgul/EXHMdcHTOAJVu7DR4htw7H
	e+sWJnV4t/cazq7hvaGjMT0GFw/5HRHsdlsrDqID4w==
X-Google-Smtp-Source: AK7set9DpX2r6eezY4GPdZm3fXc6n7/O+kYFeACZjhDh3TW34OI2pxbZg9OshnciQFLhZnP9L8bXJg==
X-Received: by 2002:a17:90b:3ece:b0:230:8452:679e with SMTP id rm14-20020a17090b3ece00b002308452679emr3036271pjb.27.1675757756727;
        Tue, 07 Feb 2023 00:15:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x4-20020a17090a6c0400b0022bfaf41662sm5419297pjj.46.2023.02.07.00.15.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 00:15:55 -0800 (PST)
Message-ID: <63e208bb.170a0220.4d232.8415@mx.google.com>
Date: Tue, 07 Feb 2023 00:15:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.4.302-cip72-rt42
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs,
 3 regressions (v4.4.302-cip72-rt42)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Feb 2023 08:15:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10622

cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4.302-cip=
72-rt42)

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
nux-test/kernel/v4.4.302-cip72-rt42/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-rt42
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fe1cf8ef6e9d76107c4a6e1bf8cc27263abe6698

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  7b5ee038995273bcb614321dd1112311e3b7e8eb =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f9a81789bdf0998c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230203.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/63e1f9a81789bdf0998c86=
30
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1fd8e478dfd1a498c865f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230203.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/63e1fd8e478dfd1a498c86=
60
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e200e390182179418c8637

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230203.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/63e200e390182179418c86=
38
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =20

