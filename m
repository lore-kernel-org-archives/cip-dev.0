Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD6DC4167E
	for <webhook@archiver.kernel.org>; Tue, 22 Nov 2022 12:01:39 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web11.17112.1669118491434555982
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Nov 2022 04:01:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=hqak1ymL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id b62so13934372pgc.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Nov 2022 04:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HPxq4eR8IR0GU+WxLC2wCocdhGmuFUuJIzeU4X5Dn8I=;
        b=hqak1ymLjVypKEHirvIwqxbJldikBhOo8f8MVLONVr5Gh6n/uRFBBkJp6XeMnJws9y
         26PZKqcbMYBTqKzSniIexpFn2rDF+KYVRISrnebIlfVHremVg0me/mKB+7WW53AqJjfE
         m/3B3szHvd36vDVXz9f9abnk3E+u6bH9V0fVhQah22bYthDclDkfYGhiGVoLpFODTZhL
         1/JWmljo0SrOX08rkNKAp2lQSc+y5FWCT6k7BChsO4VA5qN/Y5jAIj3M0YhUP+aHPrMs
         vmVvCNZs2I4FraI3jTcwVqrKF4FAXe2agNpfs2ScF7TU9rXDQVxE1zLUJUShSDqT4/gQ
         sRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPxq4eR8IR0GU+WxLC2wCocdhGmuFUuJIzeU4X5Dn8I=;
        b=8Dc1LPSxdbEiZCkTCvQ/0NxBL6SkYM4955vcFiAhIpic9bRvUof4/kTq4+pjEZ6ug7
         g6972JN8WzzrAiaFykCm29DzjlnvJaNuoM+LvfeXJvZbiu/HcQTnqW0nCKykKcdC8pMV
         Xd1IwNmNPcR3bzKg3qSCD01EmBhztdWk/F54zwrSlqcG/1uxjk2zGJ1/RdZ6v3GLuc9J
         0Q0g+9IK+4boLx/8iqLjsWAd+3EYzHzCCWmGAbS6BBJXwwBs7pUTP1JIyMwzG9fYORIV
         dwsCVlDbIQ8u0gx9Hcy5TO0zVscLrLOjZ9fUzpUjBWamR4/DhwatkmMUbyhp5jUyg26k
         47pQ==
X-Gm-Message-State: ANoB5pmQJw4vIU3yN7Z/DtfdGAtPRqL6DkuUGbI3SInRZ7N+Oi6NsEWU
	Ebvo3bdj16R8RpRCuW28ol1nyBKI74gfF8stRMM=
X-Google-Smtp-Source: AA0mqf5CQMMGU+fVGz1kLxWdn52ribBWf3rJyQJcdI40lGx8o7pOysO6k81UNxLXDIOuXAuSMjDQFg==
X-Received: by 2002:a62:148f:0:b0:560:ee47:81e1 with SMTP id 137-20020a62148f000000b00560ee4781e1mr7907919pfu.63.1669118490418;
        Tue, 22 Nov 2022 04:01:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n62-20020a622741000000b0056b88187374sm10426614pfn.85.2022.11.22.04.01.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 04:01:29 -0800 (PST)
Message-ID: <637cba19.620a0220.3892a.fa5d@mx.google.com>
Date: Tue, 22 Nov 2022 04:01:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip70-236-g69445bc0d4209
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 7 runs,
 5 regressions (v4.4.302-cip70-236-g69445bc0d4209)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Nov 2022 12:01:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10081

cip-gitlab/ci/pavel/linux-test ltp-ipc: 7 runs, 5 regressions (v4.4.302-cip=
70-236-g69445bc0d4209)

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

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip70-236-g69445bc0d4209/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip70-236-g69445bc0d4209
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      69445bc0d4209b0634d1f43657fd58f708cadf81

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cae5408bd95419c2abd13

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/637cae5408bd95419c2abd=
14
        failing since 6 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6,=
 first fail: v4.19.265-cip85-rt27) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cb194ce1f4ccf162abd1d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/637cb194ce1f4ccf162abd=
1e
        new failure (last pass: v4.19.265-cip85-rt27) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cac449bd41f94542abd0c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/637cac449bd41f94542abd=
0d
        failing since 6 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6,=
 first fail: v4.19.265-cip85-rt27) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cabd4b191eb2ef52abd43

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/637cabd4b191eb2ef52abd=
44
        new failure (last pass: v4.19.265-cip85-rt27) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cb107d499c6a23d2abcfa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-ipc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-ipc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/637cb107d499c6a23d2abc=
fb
        new failure (last pass: v4.19.265-cip85-rt27) =

 =20

