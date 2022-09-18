Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A475C32771
	for <webhook@archiver.kernel.org>; Sun, 18 Sep 2022 15:47:02 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.9868.1663516012177855727
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 18 Sep 2022 08:46:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=JAuF6pTZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id b23so25807773pfp.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 18 Sep 2022 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=wZ4QsRfE1wB7sxaNxbKjOwf/rDapMVQD0VlJ8uKJLd0=;
        b=JAuF6pTZ/ONZqEsFp+VHZswmBP0ots7PtVQL9xl8Lyq6saeo2xWL+md7IFBGPgUJOw
         0JP+8ccJx/Gc8T801uN0Gv9uyblFZAo27YSG4Tl/RbCWqk1bdVYBh6crc8iX6j2dmQe0
         XRmmAgtJ/eFdNb5VJwAogiIoWUyxLRNTKIykgo6r6PH3cizLHD5NZr2ZqYgwv8/9jQ4I
         rJdp0e6EJMFR+ZJc0bFBeHEBx43qyJjGQmF9TQj2ubm6x4VgVZLqEq9a3sNi2pInRC26
         cGyKK9FR4vFLxYvn4fNLD96nqhwnVNaWhf9/yUckH8INPdfkR4Uab5Se8QYW2NKu36FB
         1kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=wZ4QsRfE1wB7sxaNxbKjOwf/rDapMVQD0VlJ8uKJLd0=;
        b=GFu2VcnVNWmVDrNFb9Aw/eaZaBMzWfEJH+c2Bjl4nSmk5sof7yl7bs4/aohKG7HDLS
         oNjA7lGEy4JhFxreCWmD4US01oltJ3BgwRTNdzPIxosW1MbNsX7adnaWfb+ElXGwmn9E
         NyDq4xQAnokdXh7b/THKJeRePlHiJGz7op5mweaIw7Tvh8aaeKebRV4Bfpl3+1hiV3NF
         LoCOEQ282SFFQaaYjoq3nV5Xtdn6nvAqwa42e2LYd+rCuvUYVBDCky2z9RGT4vI4cdFU
         UHdbFvK9N+PPlRw00QBK4dF4xGf7hewxebNqVUEGOKvkWs7J6Ows82Vl899mWOs29FXN
         67vw==
X-Gm-Message-State: ACrzQf0O7SrsglEzmIf80OXTe+7Av90P7CxLCSNe+37e1jImihRyib/c
	JaftMzaJZBDDt5Z2sY4Ej3HZLjTIFw1dDnGlz8Q=
X-Google-Smtp-Source: 
 AMsMyM4oGkW9gnoMSG75wHfK5fTeE4UvnaCTksGVkviKR2DmCe4go/Mr+TsEtcf17E9eGibo5LwBPA==
X-Received: by 2002:a05:6a00:9a9:b0:541:787f:f2c with SMTP id
 u41-20020a056a0009a900b00541787f0f2cmr14953851pfg.12.1663516011247;
        Sun, 18 Sep 2022 08:46:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x8-20020a170902a38800b00176c891c893sm18728638pla.131.2022.09.18.08.46.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 08:46:50 -0700 (PDT)
Message-ID: <63273d6a.170a0220.9c0c8.1af0@mx.google.com>
Date: Sun, 18 Sep 2022 08:46:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-231-g7349cef09ddd2
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 6 runs,
 4 regressions (v4.4-st20-231-g7349cef09ddd2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 18 Sep 2022 15:47:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9514

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 6 runs, 4 regressions=
 (v4.4-st20-231-g7349cef09ddd2)

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
nux-test/kernel/v4.4-st20-231-g7349cef09ddd2/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-231-g7349cef09ddd2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7349cef09ddd27c4d55cc11d23fdf232c9184ccc =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6327315c0e783a651835564e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6327315c=
0e783a651835564f
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63272f70ce3da7d1123556af

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63272f70=
ce3da7d1123556b0
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63272f456631d5ca4235565a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63272f45=
6631d5ca4235565b
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63273175cd9c926632355682

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63273175=
cd9c926632355683
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =20

