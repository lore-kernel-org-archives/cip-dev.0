Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8E9C678D6
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 13:35:51 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web10.45040.1674135344300283342
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 19 Jan 2023 05:35:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=if81Rc8E;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id q9so1518338pgq.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 19 Jan 2023 05:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnFDqEDzdKBq7m+lliQWikeWgFihFpq62zv0QW8c9/U=;
        b=if81Rc8EGao5XR9RhHAAxML5XUn4hBth1U649e8f0hunThwdH28ZKS7d6jskuBKN6y
         8y8jJ+bIbOXGjiK3pauKpj6vvq+2A5Jx4C79QHgk12eGOMUrR0uvADWkPpqG+xtSGDCt
         CPeloRv2qcvfQaDr505Omj5YU4/96iKCuah+MEKAGAId+HYVX905bGDYKnhByusg/Aui
         OD1i8J3UuFYJnRe08Vly5bcyrmlHq2McmmC4PP3EMvs1BdA2JUyICrLg4JUqMX1jJzIK
         uqEdTjTBk9vRJ1Yhsl9O1qQCeU4vw8XFEFTq0GSBqvVPeOw/hkJvz6E6TkQVyDyjU/23
         1OGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnFDqEDzdKBq7m+lliQWikeWgFihFpq62zv0QW8c9/U=;
        b=TelEKsACUqCWZ0+5TZjpyzvCw7/yBY13nY5osA+v3B+aZ7EaTWBnGiBMr99uvbpe1M
         B3hq/LIikaTvlmTy8sgDpuwDzYhHy6VQFKzmeX3z7zelWUr8PB6oBH7lO1QhlxFfVeAn
         QgzrI1qCj7u9RyVaVA7X15FCz/u17QVD6DVEjutSD1Jc2EY15q9LQYUwsdz3kIGBZpGj
         Hq/XjUNjjT1/2atFgSBbnOX8okYq0UNRB90QsM2MRsJfasAKDQX/eguue8B4+FNgSDh0
         E8SqQx9oG4TVioCD8tZjvtXCVw4tajbmvRmnpTs1xZX2vaOWkavOfbtqc/t6pPYglPfc
         D0kQ==
X-Gm-Message-State: AFqh2krApg5h/bWObnMlAu7MdBWLfaeWI05LSzj+a+3ONy60k0zJ4tGf
	mf4FBExlIghli5TerKZe8w9+w8LXmaVt0p9R6cHCyA==
X-Google-Smtp-Source: AMrXdXswwY3tNECi6MRNApfPYkDMM1Nqazayv9CSigihrUahR246ftdFKnvRkH8ZqgOa/RNTiAyQPw==
X-Received: by 2002:aa7:8493:0:b0:58d:98e0:79a9 with SMTP id u19-20020aa78493000000b0058d98e079a9mr10453596pfn.34.1674135343446;
        Thu, 19 Jan 2023 05:35:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k19-20020aa79733000000b0058d90bc57basm9230640pfg.90.2023.01.19.05.35.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 05:35:43 -0800 (PST)
Message-ID: <63c9472f.a70a0220.a382f.ed4a@mx.google.com>
Date: Thu, 19 Jan 2023 05:35:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.162-929-gae713b3c4626e
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 10 runs,
 2 regressions (v5.10.162-929-gae713b3c4626e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 13:35:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10443

cip-gitlab/ci/pavel/linux-test baseline-nfs: 10 runs, 2 regressions (v5.10.=
162-929-gae713b3c4626e)

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.162-929-gae713b3c4626e/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.162-929-gae713b3c4626e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ae713b3c4626e7f02c44b3495f9b37717dd93ef0 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c93ef0aa90ee2d23915f0b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-929-gae713b3c4626e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-929-gae713b3c4626e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c93ef0aa90ee2d23915f10
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T13:00:19.713245  <#
    2023-01-19T13:00:19.713571  8>[   11.161785] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 8797818_1.5.2.3.1>
    2023-01-19T13:00:19.814520  / # #export SHELL=3D/bin/sh
    2023-01-19T13:00:19.814708  =

    2023-01-19T13:00:19.915602  / # export SHELL=3D/bin/sh. /lava-8797818/e=
nvironment
    2023-01-19T13:00:19.915786  =

    2023-01-19T13:00:20.016818  / # . /lava-8797818/environment/lava-879781=
8/bin/lava-test-runner /lava-8797818/1
    2023-01-19T13:00:20.018038  =

    2023-01-19T13:00:20.022650  / # /lava-8797818/bin/lava-test-runner /lav=
a-8797818/1
    2023-01-19T13:00:20.095510  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c947240c9ce4e3f2915ee1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-929-gae713b3c4626e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-929-gae713b3c4626e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c947240c9ce4e3f2915ee6
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T13:35:07.272186  + set +x
    2023-01-19T13:35:07.279082  <8>[   15.600581] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8797867_1.5.2.3.1>
    2023-01-19T13:35:07.384627  / # #
    2023-01-19T13:35:07.487603  export SHELL=3D/bin/sh
    2023-01-19T13:35:07.488492  #
    2023-01-19T13:35:07.590520  / # export SHELL=3D/bin/sh. /lava-8797867/e=
nvironment
    2023-01-19T13:35:07.591405  =

    2023-01-19T13:35:07.693193  / # . /lava-8797867/environment/lava-879786=
7/bin/lava-test-runner /lava-8797867/1
    2023-01-19T13:35:07.694370  =

    2023-01-19T13:35:07.699368  / # /lava-8797867/bin/lava-test-runner /lav=
a-8797867/1 =

    ... (12 line(s) more)  =

 =20

