Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3065C3F6B0
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 11:22:05 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web12.9461.1660303321005593448
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 04:22:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=SoFuxSml;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id pm17so726159pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=kjW8Kem2Zb9KfkpjmJrz6JhMPRjzzPoEm2BOPstelGY=;
        b=SoFuxSml6VjeElJmfGmKQ/Ruy/OuGfbzY1y2cAlgtVvTl9Re9wht3i8pUXeeSgJxiG
         agfrB6i4EP7YjEOXVmf2gaPrceEQuWYZNxSgmSqbkPSgpZx6gm1UsjoZ5u4/HUiHYLnT
         he5ZQCrp0hgrvENeMRwBJJ+U8XYnKHRZCrzyTQyIHzPLAaafrSXMxr6jon8NfOxdUyDv
         PN0Tdg9w95AFmwaGrr7DQBHIUDW9KY6z+cu6oC5d1aYo+nxaqeVix06twozwYFuHSzMk
         uHHJdg8siagdzbICC7aqsNKXHZfrd/XcywGupDv2oBLcpuRJ1xOYaP8DfTo3hBkuVm21
         +PFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=kjW8Kem2Zb9KfkpjmJrz6JhMPRjzzPoEm2BOPstelGY=;
        b=L8KunDjKi8dA1XW4MqmX8uUsy9menS/JgA706WhjppiEwvK6HmM/ZVu4G5k+wA+Xgr
         bshif27A6cuGpL7dY/9txqCJ5FDVBf6GXzlA/5X2sWzFvc5K1dkEwO4tsfiJkoYJya9t
         p80y8jY7JYw9wmWFNweKZUoj9cUZ7bLIYxW6BLRZ5r7zqGiRNuuPsEW022OY2pJTvVHj
         XFHIbgjb54ckktH+NWEQqz6d7yo15OSZVEXs9BwxG2NUBAfxIEDlWqLyW92al5bJbFgY
         9vgQpd1S6x4yUTKSjxI2+RXC5WtjSB7hp6ex4yd8sWjlprFEIzuXOAh7+qdbgqi9yZQJ
         SIDw==
X-Gm-Message-State: ACgBeo1ShdKfY3ruo+iP2psW+BSUyrw3tXiJQ9mknMrRJ2as86y6l4wQ
	S1MeibENw+1sW3I/OaFZYYEmMyMELW3DTU+x
X-Google-Smtp-Source: 
 AA6agR6FzJQDSy/wCOEQhSfrorpaM/waUI/cu/1rywsl3QTOhmIitK28G2KcoQJ0OaFI7JlsiQ32Xw==
X-Received: by 2002:a17:902:e154:b0:171:4355:3b9b with SMTP id
 d20-20020a170902e15400b0017143553b9bmr3715951pla.128.1660303319813;
        Fri, 12 Aug 2022 04:21:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 c14-20020a170903234e00b0016d1b70872asm1450885plh.134.2022.08.12.04.21.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 04:21:59 -0700 (PDT)
Message-ID: <62f637d7.170a0220.22624.2890@mx.google.com>
Date: Fri, 12 Aug 2022 04:21:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-96-g74ff989472f09
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 5 runs,
 4 regressions (v4.4-st20-96-g74ff989472f09)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 11:22:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9189

cip-gitlab/ci/pavel/linux-test kselftest-futex: 5 runs, 4 regressions (v4.4=
-st20-96-g74ff989472f09)

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
nux-test/kernel/v4.4-st20-96-g74ff989472f09/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-96-g74ff989472f09
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      74ff989472f092eb06514e780a28645e8310d183 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f6243fecf9ba171edaf067

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220805.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62f6243fecf9ba=
171edaf068
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f62248a24546e62bdaf06e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220805.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62f62248a24546=
e62bdaf06f
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f621d8f64cd1bc9ddaf07d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220805.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62f621d8f64cd1=
bc9ddaf07e
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f6242c48203bfc03daf05b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220805.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62f6242c48203b=
fc03daf05c
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =20

