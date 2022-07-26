Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688B1C04A68
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 15:59:14 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web10.8544.1658851151192513501
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:59:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=yMLbn80N;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id
 p6-20020a17090a680600b001f2267a1c84so16016164pjj.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=X4X+/4Wc5ShmyjDMuq9u1QLYIkqqH7hgFRPFWhBXdbw=;
        b=yMLbn80NWiYNEfbk4UvfNxEqDueqVMRYJ7yHQl6GqvWve8u+qWrfXUY7bUxYfVhHZK
         dT7faDa+AJ6Ts0PX/+VoH8dKepYvva/Ig+/MZC+Gbv12J2Y5nREy5aKjqVeZVMd45IBZ
         ejIfBdfKi+sf7jBZreDveHv9tgf9uB6SVDew6/+1150VlDswy0ffjG5h4wybrHGF3Sui
         CeynfeCkMdc8+16sYdSJhjFb8pmGOjBDLZLNjfttU2k4bjQsk5H9XVsnT8458CqV572W
         crdQ4W0n0XL4XStUfQvQwRLUu8qRXjRHNN05oPyLCazmHVi9EwWmBSLl6lkyBv03Pse0
         5i4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=X4X+/4Wc5ShmyjDMuq9u1QLYIkqqH7hgFRPFWhBXdbw=;
        b=AU4yAaJ2nJLcNA5C0ACBvMVQl7bkqWlKrs1KK5OMlmNMmhG2SbSafNqFwz+qZ8m7tk
         QJA4ZPDCgGmZmbQGiPK9CpTe3y+1SBJLAv20F5FdokvvnA7UeVcdBCmazU1j/Lgqx/qI
         kr5mRxPS1YS+w21hBx4OEP/YBILZ/8y79lT7mnplIgfBPMXy8PCLyJoVaNzyv0gg4C2h
         XudwnG3r8/tJ1nAt/FZkHswYadqgTjgJky3EVRp0DY7Jqwd5fK9Y+lLpRjSQHn0Pn7Dl
         OdRhVdGrH9nYvEZxIisa5uzLane/gGLy3rPD2zuH2EZcoT65U6ewdfNL27xdJ5p24v6S
         kitQ==
X-Gm-Message-State: AJIora+4jhSha5VAAwxvZF0aEJa5wbNhZHycrh4ENdpsGfWDTqQg4cMS
	wQUyAPqpmeufwduEuP7UVKw/u4r278vk7+WB
X-Google-Smtp-Source: 
 AGRyM1toqKcPe5NzIch3RMeSmOPkLQtPZXHokxMidWnsWa/pz0YX5AVMW2wt3ccx4JVBYrV/aVBMPw==
X-Received: by 2002:a17:902:d581:b0:16c:91e7:cfe1 with SMTP id
 k1-20020a170902d58100b0016c91e7cfe1mr17042228plh.92.1658851150356;
        Tue, 26 Jul 2022 08:59:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 o5-20020a17090ad20500b001f2f64eada6sm1533360pju.51.2022.07.26.08.59.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:59:09 -0700 (PDT)
Message-ID: <62e00f4d.1c69fb81.17580.25db@mx.google.com>
Date: Tue, 26 Jul 2022 08:59:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-586-geb97410e0086c
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 4 runs,
 3 regressions (v4.4-st5-586-geb97410e0086c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 15:59:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8944

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 4 runs, 3 regressions=
 (v4.4-st5-586-geb97410e0086c)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-586-geb97410e0086c/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-586-geb97410e0086c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      eb97410e0086c865c804bdc822e061764810486c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e001cf7d529f72cadaf05f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62e001cf=
7d529f72cadaf060
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0063191639d1bd3daf092

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62e00631=
91639d1bd3daf093
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0025adb6991cdf8daf062

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62e0025a=
db6991cdf8daf063
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =20

