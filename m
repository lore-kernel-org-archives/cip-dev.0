Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ED3C433FE
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 13:28:37 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.10525.1664890110085380193
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Oct 2022 06:28:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=fgFvUfBo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id z20so6145521plb.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Oct 2022 06:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=PWxaWUjqASpcFQGbXYtQtSpb9yZoBoITCZdSWgbDvyg=;
        b=fgFvUfBooPMN6iOmXmJxQ7p1pwIGlmtS1RapojBx51yKn+BAUMS9SczEKz3QTh9n5a
         Xpnv+jE6AMhuK4MwhvwYNV2nNR6+DFHK5AwlcHfialEnhEwS3PBBm2ZdbAb485EaWXWu
         VnHRf5KznzMJU580cGCnJdKIzb203BUcrVM10MUDpi3r3k0VvI1RWXEu+BAwIQ3i73EA
         rzIPS11T6NfgeDpUVoxfWMe0WX0MtTy26jVdNTpFyIN/5oKQMIX7e1smHD/b1PvtHb0/
         3mOeB+2d/j+dwd68P1jovAZesf+wmWebU75ByVkPR+HMW7UKTBsK1PJ7oJOU8/BponiU
         WJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=PWxaWUjqASpcFQGbXYtQtSpb9yZoBoITCZdSWgbDvyg=;
        b=Lw4S7wjM9KkJ0YoMq9ZjieSewUF0T1J/fgysb4MEF/77vYg9MQDvBDWZA58meww9KL
         CoA77j5ZFSxduwZ7zywsrQ1eK9KsblNcC2zBL1kdsH01HrLPK55s2bgY78eHOwDPybOn
         TdsRj07mcJZQhBInFiPU2ZWBj7hcmbfKQNVsJDwABYld8BNGevkvKhNrErdUR3QwbbmP
         ki5SJaU3ocCxzaUxQe/Q+cxKYbK6aV5FiqTjx2Xv9sdUpvwWe9cQiSCIRPl6QcLE/35l
         pUr/FQAC4xhg6b4kXiJXwVGyhdq37CtkPBUK3aimBplFnNQcMmo0Wuqlg28jiCMYwsR0
         aTfg==
X-Gm-Message-State: ACrzQf2LToroBbsmbxAAF8rhWuuqMPpbUcHdAh2SEd6021sSfKUusaLv
	TiZYD6TT17Abjhm/CwoDPEBaM4qmg79OmjY1Cf8=
X-Google-Smtp-Source: 
 AMsMyM77NIAD6WWMrxioXVTF7wEpItojzM+YVE0eKTa/2S5u0uQnn7aWUXSVXIW+TH2Whbo24I74jA==
X-Received: by 2002:a17:902:b402:b0:179:e5b0:96d3 with SMTP id
 x2-20020a170902b40200b00179e5b096d3mr26621017plr.142.1664890109232;
        Tue, 04 Oct 2022 06:28:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 p14-20020a170902780e00b0017f7bef8cfasm376478pll.281.2022.10.04.06.28.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:28:28 -0700 (PDT)
Message-ID: <633c34fc.170a0220.7ebce.09d1@mx.google.com>
Date: Tue, 04 Oct 2022 06:28:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-421-g0d804ef4a611
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 58 runs,
 4 regressions (v5.10.145-cip17-421-g0d804ef4a611)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 13:28:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9623

cip-gitlab/ci/pavel/linux-test baseline: 58 runs, 4 regressions (v5.10.145-=
cip17-421-g0d804ef4a611)

Regressions Summary
-------------------

platform    | arch | lab         | compiler | defconfig           | regress=
ions
------------+------+-------------+----------+---------------------+--------=
----
imx6dl-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1      =
    =

imx6dl-udoo | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1      =
    =

imx6q-udoo  | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1      =
    =

imx6q-udoo  | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-cip17-421-g0d804ef4a611/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-cip17-421-g0d804ef4a611
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0d804ef4a611ef583ad77ab7fa646c19f24f99e5 =



Test Regressions
---------------- =



platform    | arch | lab         | compiler | defconfig           | regress=
ions
------------+------+-------------+----------+---------------------+--------=
----
imx6dl-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/633c305084e67a08a0cab5fe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-421-g0d804ef4a611/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-421-g0d804ef4a611/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/633c305084e67a08a0cab=
5ff
        new failure (last pass: v4.4.302-cip70-98-gb2bfffe124dae) =

 =



platform    | arch | lab         | compiler | defconfig           | regress=
ions
------------+------+-------------+----------+---------------------+--------=
----
imx6dl-udoo | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/633c31a4d1899b27c3cab5f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-421-g0d804ef4a611/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-421-g0d804ef4a611/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/633c31a4d1899b27c3cab=
5fa
        new failure (last pass: v4.4.302-cip70-98-gb2bfffe124dae) =

 =



platform    | arch | lab         | compiler | defconfig           | regress=
ions
------------+------+-------------+----------+---------------------+--------=
----
imx6q-udoo  | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/633c30646bec65aa56cab620

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-421-g0d804ef4a611/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-421-g0d804ef4a611/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/633c30656bec65aa56cab=
621
        new failure (last pass: v4.4.302-cip70-98-gb2bfffe124dae) =

 =



platform    | arch | lab         | compiler | defconfig           | regress=
ions
------------+------+-------------+----------+---------------------+--------=
----
imx6q-udoo  | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/633c31cc69fb5cb449cab64d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-421-g0d804ef4a611/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-421-g0d804ef4a611/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/633c31cc69fb5cb449cab=
64e
        new failure (last pass: v4.4.302-cip70-98-gb2bfffe124dae) =

 =20

