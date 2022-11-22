Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16D2C433FE
	for <webhook@archiver.kernel.org>; Tue, 22 Nov 2022 12:01:29 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.17109.1669118489323139723
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Nov 2022 04:01:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=3oNa74wy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id k15so14174875pfg.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Nov 2022 04:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KkuAuojxupDbjaXFWHnN4GQ1FOzDIcCIMlfZToJYux4=;
        b=3oNa74wyvIiz9mG0W4hUvEgr7XdG9w83XY4DLyoN6+9QBIlLY8ASYyiSo6tuY2JtuA
         eIhq/43Pq7ej7X80142xCNvWefWi7wB+Nw6TiXTp3NaMkSWk5EzP6yFoWzM7xIMBd9ZA
         SkUsKN3fj1xC1epkMj1KdiJlbJW8RBcBxsJQPqsOSfYKujq5vX46qmKjcrnLuKnGlY2k
         xAMYwAHDPNYcM13+vj9S6WHp7Z4PJ4rKndV8cIly4qYz06+2hna1vVyBXfGSol6AgocU
         Drt8zvwFtWVtzzY+csNzaHItI8Mu3TwEpCElbQUsK8clQ9feuIa9uUWyKGNBeTzbBw16
         Ecig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkuAuojxupDbjaXFWHnN4GQ1FOzDIcCIMlfZToJYux4=;
        b=Z/NRhe12cijlPa7q38JdsK8XVqQm5OsKvyUj4cpAJM7W/Doq6D51Xm3E8JGJxlhMRp
         X7XBZyhkb282yEwjXnK6t553wX0H2micau09tLI5mmWMrTeCHZGdhY/Gr7mxgWXvwomt
         K3Fzt0FKkBG/jnJe/8FBR16aeaWxRbF/P+gTnYOmKWc2l+jQEO+rAFIYHJx4vQeUaFYW
         q1BliXaSGw1ZGQWHnXBXxIK62k4hQJxeUATVtoiUMV4gOrmlpFbZ8Om6g92hTvhDrjmF
         8OAzeR+3bBTjZf+N3VQWCCNtNoreZyHFRmNaUCBvb00wT/mEuysyhlWtPAgKs4xLajtH
         iB1Q==
X-Gm-Message-State: ANoB5pn1/XzXi1crYEvH4ezD4HywPM5u2wXwHsywwYPhGLsGV8wusR49
	DGdj2tMow2ho+UmFyMbwryLIVk3o4ud9xSqmg7s=
X-Google-Smtp-Source: AA0mqf4GJV2HOzJLyps6ONNyQSI3J0p+4FXIRJ2uGk5yV+gKToahxmA0FgsSognQ7HOnmA1TnirC8w==
X-Received: by 2002:aa7:880c:0:b0:573:3397:f804 with SMTP id c12-20020aa7880c000000b005733397f804mr7968778pfo.86.1669118488167;
        Tue, 22 Nov 2022 04:01:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902d50700b00174f61a7d09sm11816654plg.247.2022.11.22.04.01.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 04:01:27 -0800 (PST)
Message-ID: <637cba17.170a0220.e9764.19e7@mx.google.com>
Date: Tue, 22 Nov 2022 04:01:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip70-236-g69445bc0d4209
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 5 runs,
 4 regressions (v4.4.302-cip70-236-g69445bc0d4209)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Nov 2022 12:01:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10078

cip-gitlab/ci/pavel/linux-test kselftest-futex: 5 runs, 4 regressions (v4.4=
.302-cip70-236-g69445bc0d4209)

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
nux-test/kernel/v4.4.302-cip70-236-g69445bc0d4209/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip70-236-g69445bc0d4209
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      69445bc0d4209b0634d1f43657fd58f708cadf81 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cacd8a8de38b3272abd0c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/637cacd8a8de38=
b3272abd0d
        failing since 6 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6,=
 first fail: v4.19.265-cip85-rt27) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cb249df3c52420a2abd0d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/637cb249df3c52=
420a2abd0e
        new failure (last pass: v4.19.265-cip85-rt27) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cabb6fd6f8d38e22abd00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/637cabb6fd6f8d=
38e22abd01
        new failure (last pass: v4.19.265-cip85-rt27) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637caed57b1d5827152abd21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-futex-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-futex-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/637caed57b1d58=
27152abd22
        new failure (last pass: v4.19.265-cip85-rt27) =

 =20

