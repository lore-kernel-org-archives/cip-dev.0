Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ECBC636D4
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 08:15:59 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.78716.1675757754849895583
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 07 Feb 2023 00:15:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=nB4hUsqC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id o13so14212013pjg.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 07 Feb 2023 00:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D+FOsmOFEjanE/B1ukE9hqSAzADWcBgje4Ma8Z6gng0=;
        b=nB4hUsqCj6Nu4Ei8sCBf/AIwT0uVmvgaQ/68JLLSt2A5tusqk4HnSUFIjRDeG41YXB
         raLTiPaDiqbGQywEFgXhK1Pkwp6oUukAWT/NpSw/+Ja7aHemJ/RRMyuHaL2Q2Fj41Bc8
         BDVDiDo8A/zW6pqisctYVQbxsdoXq32A73PKikRAEiklCwKmmJ3K5HV+LlfrrtnRpwZf
         mwjgdvyKUivbxu95boP7tX18+o+4CllbliEomHwZvjfUaRXL0FszgujbeBMH00tCl4Rw
         w+/SlWelgp4RYNRN7CxadUwSbDWOrFBaaHtjKvVnV06iFbtnx7NFLkPj6/8+Rz/mQzJ8
         ooeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+FOsmOFEjanE/B1ukE9hqSAzADWcBgje4Ma8Z6gng0=;
        b=V9QVCfIzxkmdFATMLHky9Sf432d3VCDtvu8lCaa7ZMft0pY04xhE02JATuvFgKAW1+
         QJNQ4sLPSWSqvGiT0akfm8oR/IvXOafLNwSII51CRp1ooxDDdQzLAY66KBE7zKPsALU6
         pK6xLEqC6U/sTgLd5zR2WppVQ7GbpMgx5SqEYMnjHTeTPFbgmfeQAjmiRn+xdtF5B64O
         /2dPvUGwlOcBTT064FjEzx9Dvasjea85jYRRt5opmSyD41oJgnlGucWh6d/UJMqSr0EQ
         INl/9ds+7ZRsHGmUMLUX56Z2ev/UlVLT/NxNy8g6Kk2oOA9meqS1UuyAMzTfzoKa2CGb
         WnKQ==
X-Gm-Message-State: AO0yUKUxW6kNFonafseoEqoNw0u8q4DEq9Cwia8Kh4JRVHRaikYzKGVm
	L7vwbZ3vc/5Iu9y8Ow759NMR1cG8WFwxi8YPy7Y96w==
X-Google-Smtp-Source: AK7set9aqx1cs4Vo/JxsVOxVDOYEVbmsBltSS8Xy6UDFubLNyQt9VAtK8BytuO0+IOqnQyuysxrjfQ==
X-Received: by 2002:a17:902:d0d2:b0:199:1f12:87d2 with SMTP id n18-20020a170902d0d200b001991f1287d2mr1550719pln.42.1675757753756;
        Tue, 07 Feb 2023 00:15:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d24-20020a170902729800b00192c5327021sm8196482pll.200.2023.02.07.00.15.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 00:15:53 -0800 (PST)
Message-ID: <63e208b9.170a0220.e91c4.e334@mx.google.com>
Date: Tue, 07 Feb 2023 00:15:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.4.302-cip72-rt42
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 4 runs,
 4 regressions (v4.4.302-cip72-rt42)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Feb 2023 08:15:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10617

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 4 runs, 4 regressions=
 (v4.4.302-cip72-rt42)

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
nux-test/kernel/v4.4.302-cip72-rt42/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-rt42
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fe1cf8ef6e9d76107c4a6e1bf8cc27263abe6698 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1fab6992a196f2a8c8632

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230203.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63e1fab6=
992a196f2a8c8633
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1fae898d9d83f778c86e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-filesystems-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-filesystems-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230203.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63e1fae8=
98d9d83f778c86e9
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1fbcebe1c8f003d8c863f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-filesystems-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-filesystems-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230203.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63e1fbce=
be1c8f003d8c8640
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1fc3ba6dac2a2608c8647

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230203.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63e1fc3b=
a6dac2a2608c8648
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =20

