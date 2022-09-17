Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B91EC6FA82
	for <webhook@archiver.kernel.org>; Sat, 17 Sep 2022 16:45:35 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web09.426.1663433133587380082
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 17 Sep 2022 09:45:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=vQ8pCgb3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id p18so24219068plr.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 17 Sep 2022 09:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=EYH6GoosYt8cu2Tavx/2kQGo59pTcagMhtcwtTpcUKw=;
        b=vQ8pCgb3kND5TXyueHOWGdPx3zHJXd0ZR2Ohwn+b+KaiYoLCY4ZX0IGVsEo/nySnEz
         P1q6+ZV7Q5CRzaw28lXTG2KVtraEzJ4hLapgAs/uGlfxcNLGKNkUpsnQMhJdhAX5Ilwj
         WeEEJPQWo9fecGsq/B9NZz1kAB7tLkUT+Y99wPNsZErcfXU0I+dwrzmgnXIH82PCZHf+
         H1t8rgA0LxHwjNxJHU3v16HS4o5zhFBkwIJACGs5k0EY6F233PnpBS4pevHEgU7h2ry2
         fWWfAL5BccP2bWVzQOreNNuIllleYAy1qYW1VKfVfcm3dKeRnsUuq7Y3jNQpU7hZ5vjF
         6eEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=EYH6GoosYt8cu2Tavx/2kQGo59pTcagMhtcwtTpcUKw=;
        b=ujRp8VmIseDqIxmWSlfJ1WtDqS+Z7nrcOJxIGS64hAPKvt4DkVpci6AlzVJC3gdUBA
         Nihe706HC7TYYRM1XVYXkV7OgLUrrinP/sYC9PBC4HiLluhJjOGhnX9xtpimvEXmAlNa
         GqDZWFvQR14aGVB8ZFcA0Ar5vPa3m+QCY/PkHj2uZ1iCfw7QdNJsfFT6pDRUx1mbGpJy
         VV+3RCzhuH66xe+scqsyqGEXUGgGR7gnnyIFzIeaDMXxBNPyHXdwY/w5SYjxAbr44rEM
         n48rJ991pDahzSnR3C+E2xBLFLZO944/oLpLUrQrc1M+0Ix/hEZq1O9M7HEzSyr8OIf1
         Tkhw==
X-Gm-Message-State: ACrzQf0PM2c3T3YIXxqHLwIwROFRSR3cvB657FexXCe4Q0+ItB1iToz6
	9DyJf4l/lI7kf2LmiklJ+PKeRWQ2BFQ7SbcmVjY=
X-Google-Smtp-Source: 
 AMsMyM624DP7Vm/6XgYMTQCIFsJ0LtAgfzYgA2cvyfIX0Hjt8IPdgyOsCXnBx6vu1TlodhyOQFicYA==
X-Received: by 2002:a17:903:40cc:b0:177:e44f:1fff with SMTP id
 t12-20020a17090340cc00b00177e44f1fffmr5457899pld.133.1663433132772;
        Sat, 17 Sep 2022 09:45:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 w63-20020a623042000000b00528a097aeffsm16421545pfw.118.2022.09.17.09.45.32
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 09:45:32 -0700 (PDT)
Message-ID: <6325f9ac.620a0220.5e719.d045@mx.google.com>
Date: Sat, 17 Sep 2022 09:45:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-229-gb433f12afe250
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs,
 2 regressions (v4.4-st20-229-gb433f12afe250)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 17 Sep 2022 16:45:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9504

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 2 regressions (=
v4.4-st20-229-gb433f12afe250)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-229-gb433f12afe250/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-229-gb433f12afe250
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b433f12afe2506afd30066f5b2b826129a20bc03

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325eb7410bee55b56355648

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6325eb7410=
bee55b56355649
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325f249598e2bba47355649

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6325f24959=
8e2bba4735564a
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =20

