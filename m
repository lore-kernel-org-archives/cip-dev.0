Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECABDC004C0
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 18:39:30 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web11.62481.1697827162116415555
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 20 Oct 2023 11:39:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=vSJidzae;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5a9bf4fbd3fso843777a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 20 Oct 2023 11:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697827160; x=1698431960; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a2k5wDt48+OFbrEwCvlC1jnz6Qoxzin1HsLDCWbARJc=;
        b=vSJidzaeoygn7Rmd/cUFjjBjsV7Y516UPw5J/ysGkLQquPIty1Yq9epBdVYYjhplGI
         23crUFr+1edQv5qAV8EizpOv7N0/cfb8rnhZ1IfX0DEhpRKzO3oP0fB5uy9Wuo+zHQIU
         JOlVwX7rou7t7Rup0ODmuxeKSTu7yQcZxxwJoZ2RM/lfZWPfOzAgoEDHa9LOUTIONde+
         Ivc4cn6HkWIceJOQDhmwEYdCONY0kyfDFpwr2hk5t3zFD1GbDbykP81II5g8pcxlU7+8
         hZ8JnPBy4N1e9LFhpHmd1Hh5A1WXkys+JyVbAprGpY/ONqW162fr//T0P+aJnIY+dH/K
         O19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697827160; x=1698431960;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2k5wDt48+OFbrEwCvlC1jnz6Qoxzin1HsLDCWbARJc=;
        b=egdsMK1PYAyBfA83dEsfSAdqoosl7+JqyknNf8emTvbI1WRJZ8kEbI8/YrrEE142Y9
         3UMYF4Dvvj0vxr1vWKOtiPf7c3csoalcZ86xVEgXmJPMfUGE3eAGsshF66pBFh04rJiz
         CwNtftajPuQZSgGaKLS3uKiOYRtNPXVCfEcKFd6L410a4CZ3AlB8B9/UcawgdnvMQOnR
         EDRWSddWfUQ2m6UZ3tEEmRTA7PxlcjgT4L/2jhlTDOJnwe15+SK6ye1QVpSWSP06gahm
         wQimw/kjC5UiXwDxKyfm57pdtS458QQWSSeE/RoDP0BCGVtm+EWMUjnHb5eSFj7hly3k
         ClSg==
X-Gm-Message-State: AOJu0Yy0/nNFJEm+PMYKgbLiLLWMcqsJ6KbRduy7Q0I7+DBvKq2VcZuH
	8AiSsqp4mZHjGpNA2RFFYHDBCj0sYzL55BVTqhJC8Q==
X-Google-Smtp-Source: AGHT+IGaMGC/P4Qrb6ja8p80l3vitt4lvgtqQ+SfE18zRE/wzIMGok//UuMCxl/V4GHMPvoLyIN2gQ==
X-Received: by 2002:a17:902:dac5:b0:1c9:e0f9:a668 with SMTP id q5-20020a170902dac500b001c9e0f9a668mr3178035plx.18.1697827159642;
        Fri, 20 Oct 2023 11:39:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001c60635c13esm1827878plg.115.2023.10.20.11.39.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:39:10 -0700 (PDT)
Message-ID: <6532c94e.170a0220.57920.6da0@mx.google.com>
Date: Fri, 20 Oct 2023 11:39:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.302-cip78-rt45-338-gf468de833aa13
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 4 regressions (v4.4.302-cip78-rt45-338-gf468de833aa13)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 18:39:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13431

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 4 regressions (v4.4.302-=
cip78-rt45-338-gf468de833aa13)

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip78-rt45-338-gf468de833aa13/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip78-rt45-338-gf468de833aa13
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f468de833aa13aa639d147055db4edf9931b6811

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bd3fdc8c29222cefcff1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6532bd3fdc8c29222ce=
fcff2
        failing since 10 days (last pass: v5.10.194-cip39-552-gc89b2c57483f=
0, first fail: v5.10.194-553-gd498c00818b88) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532c090d5e2d8dbabefcf00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6532c090d5e2d8dbabe=
fcf01
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532c67fe08052e219efcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6532c67fe08052e219e=
fcef6
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bee071f2fc7059efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6532bee071f2fc7059e=
fcef4
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =20

