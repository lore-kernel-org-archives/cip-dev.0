Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B803DC83003
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 15:24:25 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
 by mx.groups.io with SMTP id smtpd.web10.998.1686151461906658332
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Jun 2023 08:24:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=nXh5Ceq1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.49, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6af93a6166fso6895425a34.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Jun 2023 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686151460; x=1688743460;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5+o2ZZAJu0/NOhUgy3djnX6Y6SPPBtqPjl0oAQL5eqs=;
        b=nXh5Ceq1+IbJUojjSzEtRNgqchW0l6SBEn4M95H9OUbzFt6Tltv3sX43g97i3mH7Bb
         V5009dRLbawQOE9/NXK682MHfgL5ktN0cfxzL4+1szlRYv+a5TYWpOkSwgQCQaYsL1kK
         JZGIiLsyFW03x358IbA+g65H2YMUgrEOIyo047RPPW94GigPlNUpmZ5Yxs7MAYGJz+VJ
         jPvATMHCXMW2ZB7ODKroEGSgUVBYHhGxhbm8xYjabTVzihHisdEdvKCl9tooJ2/WLkAU
         t8hnlzw+AxVvITD2UdKW9RJJVGY4WJM/YVI34bqJtWLIZJLNKhGqHn8ZisoMQDXpjr8J
         jwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151460; x=1688743460;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+o2ZZAJu0/NOhUgy3djnX6Y6SPPBtqPjl0oAQL5eqs=;
        b=S5MldYFAS6mfWlOazC/fyC1RbFctdK+6ja6wDJTZza4SzEaSau0lfLGkLSZdkzh5wm
         zjAP5aX3W5zyMhuZgaXgWgYOosjBahj5ML7EZQE0ZwPYtsyLtDZuVRogrcaDBdpdhxK5
         IK+LX+8q7lRraacdAGoXKLrRr5f6151scqqNSF4Lk829KE1SUmY8FrkdCzf2NARq3J6y
         Flv6zK3tn3P7KdO4+yMp4zIOGOgO0VJxI83GBRmpLfJw60SMlxnCP1IA1KOU2a7zQlVy
         +f6MXpOg9k+kEAyK4kOfAbR7LRB+bV6YYd3kIapyF77xiUUwixgueEmfpXUmWIPwFHJ3
         m4FA==
X-Gm-Message-State: AC+VfDyuy3zw8TmGE9Hx7w7+RjJx3DoFd2RP8AIN3DhAm7xuCZenWpXC
	2WVZx1QfSAoMBcP+l4nfdotISexdFPIhK15uRV9y3g==
X-Google-Smtp-Source: ACHHUZ5z3petXvcC/4P5YVWXTTAe47K8k/HTMpXMy1/Tcir858GgQSzqRcTjEQKVTdgd47l/wpUL0A==
X-Received: by 2002:a05:6359:c13:b0:129:c21f:d788 with SMTP id gn19-20020a0563590c1300b00129c21fd788mr4303890rwb.9.1686151460420;
        Wed, 07 Jun 2023 08:24:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c21-20020a631c55000000b0051b7d83ff22sm9309483pgm.80.2023.06.07.08.24.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:24:19 -0700 (PDT)
Message-ID: <6480a123.630a0220.c88c3.1ce9@mx.google.com>
Date: Wed, 07 Jun 2023 08:24:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43-218-g246f4be89a77
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 5 runs,
 4 regressions (v4.4.302-cip74-rt43-218-g246f4be89a77)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 15:24:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11920

cip-gitlab/ci/pavel/linux-test kselftest-futex: 5 runs, 4 regressions (v4.4=
.302-cip74-rt43-218-g246f4be89a77)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip74-rt43-218-g246f4be89a77/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip74-rt43-218-g246f4be89a77
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      246f4be89a7760f90649094cbfabcccfce7dafd1 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091bd08562f963c30614f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/648091bd08562f=
963c306150
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64809299722445528e30619d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/64809299722445=
528e30619e
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091c265a368c4da306170

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/648091c265a368=
c4da306171
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648094d4fc7f64000630613e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/kselftest-futex-hp-x360-12b-ca0010nr-n4020-octopus.=
txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/kselftest-futex-hp-x360-12b-ca0010nr-n4020-octopus.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/648094d4fc7f64=
000630613f
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =20

