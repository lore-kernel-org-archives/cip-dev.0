Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C0CC61DF4
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 10:51:56 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.132929.1700823110160028255
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 02:51:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=mmOfgENi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-285636785ddso1215346a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 02:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700823109; x=1701427909; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X28mwPthJ5TCZOQVOJXp06LPU7untxWMSxTrMCnmfXE=;
        b=mmOfgENiTyjDDRutnoB5ylX3jTF5SwcDLacCOS8N4UOBTsKKoEW3GKLpHYfwD2xgw5
         cOcNoHhl488NRhRHNfoXnWwOB74czrqGmyVu1fPVs0H0LRtOb94yvpvnM0+xc/SP4WX5
         6lkymD+CrzI4XFIaifsIIcSNpCi7tYXTO3Wuj66XB3OQ0d8u6rZvkvg4mOngDOhoZ1wI
         2h2Cq1JmiQdnOxlPOlL2YJwYCgcnztRNv/z6hgSg6mozEjNcbUOrmIeFBeJjDQu1Rnsq
         a8pa12OlzbuIR5Kjd0Pq8EmPQIWpsOcL95Qi9/dWrIkXIT28L7u510snCnlAWDI1pwG5
         zdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700823109; x=1701427909;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X28mwPthJ5TCZOQVOJXp06LPU7untxWMSxTrMCnmfXE=;
        b=vItaQyDkMTBAMdoPLSsRfk2hv+PCLtnXJqdkrRNlmSL42rPGIvTTtdxGvZxrqWkITp
         ujnUkAer1LamAmREH+ek+2xQ0Sz+/jCz4Fm6BMfcgCKWqbJGiRncs6pqFYA65le/2vC/
         ei2H/kd3hra9nwWy3Bk0vWzJHxWCnIWzo4sHk5NglZJbVYQx+QVyr8XWAQfjpnL6srJu
         erbHJmQQUCfTK9R8uDS2LtLRZf2UNNZECWoE6R2vjSDupqMWfUGUL4wkgd4Q+W64CMd4
         l0skw1eZThfdhPJAQ4OA12vUgAZW3TRjC2QUuJZ39fWpuARLt2wX7pfFvujlsllyJr9h
         cvWw==
X-Gm-Message-State: AOJu0YxnLo4gD6Yzo2M1EjOvbWDzgz4R4sk3RjmzRhjrqbhexSbOD1Py
	5LoZKhY17UX9aysKNZ7OkdB3ryurngbV6Obhr+Y=
X-Google-Smtp-Source: AGHT+IFBmBNYBiZqw8QlEPXVquetNk/NZe/kR9tvpJoZVxB5w4OaoIQN2E7sD2U/LwAvxcYvsWZ0lg==
X-Received: by 2002:a17:90b:314b:b0:280:2823:6612 with SMTP id ip11-20020a17090b314b00b0028028236612mr2024783pjb.35.1700823108819;
        Fri, 24 Nov 2023 02:51:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090ad48b00b00262eb0d141esm2723422pju.28.2023.11.24.02.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 02:51:48 -0800 (PST)
Message-ID: <65608044.170a0220.3d7e1.62f3@mx.google.com>
Date: Fri, 24 Nov 2023 02:51:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v6.1.62-cip9-12-g3a5321f469b07
Subject: cip/linux-6.1.y-cip baseline-nfs: 66 runs,
 2 regressions (v6.1.62-cip9-12-g3a5321f469b07)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 10:51:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13718

cip/linux-6.1.y-cip baseline-nfs: 66 runs, 2 regressions (v6.1.62-cip9-12-g=
3a5321f469b07)

Regressions Summary
-------------------

platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx6dl-riotboard             | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.62-cip9-12-g3a5321f469b07/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.62-cip9-12-g3a5321f469b07
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3a5321f469b07e6124d325d7faaa2f8f1993f67c =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx6dl-riotboard             | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/656074ded2d90d4add7e4a94

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.62-ci=
p9-12-g3a5321f469b07/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-nfs-imx6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.62-ci=
p9-12-g3a5321f469b07/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-nfs-imx6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/656074ded2d90d4add7e4a9d
        new failure (last pass: v6.1.59-cip8)

    2023-11-24T10:02:43.594320  + set[   31.120867] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1010937_1.6.2.3.1>
    2023-11-24T10:02:43.594481   +x
    2023-11-24T10:02:43.708299  / # #
    2023-11-24T10:02:43.809873  export SHELL=3D/bin/sh
    2023-11-24T10:02:43.810202  #
    2023-11-24T10:02:43.911014  / # export SHELL=3D/bin/sh. /lava-1010937/e=
nvironment
    2023-11-24T10:02:43.911514  =

    2023-11-24T10:02:44.012237  / # . /lava-1010937/environment/lava-101093=
7/bin/lava-test-runner /lava-1010937/1
    2023-11-24T10:02:44.012811  =

    2023-11-24T10:02:44.015630  / # /lava-1010937/bin/lava-test-runner /lav=
a-1010937/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6560779d65f2c5c0157e4a77

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.62-ci=
p9-12-g3a5321f469b07/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i=
-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.62-ci=
p9-12-g3a5321f469b07/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i=
-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6560779d65f2c5c01=
57e4a78
        new failure (last pass: v6.1.59-cip8) =

 =20

