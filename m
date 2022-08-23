Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C262C32789
	for <webhook@archiver.kernel.org>; Tue, 23 Aug 2022 05:31:09 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.28650.1661232664809579146
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 22:31:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=DPIIOvJ7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id g18so13071884pju.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 22:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=PjAx8K6kcQIU5qm4X6m45djqbCxHIykBoCXUIuG1jTU=;
        b=DPIIOvJ70Rlpe5w+8MJwZ+9QjBgG7BUWRIcRYckJw6Y/thppjpVrqngFICrpCcb5/X
         eEG9fWxCkKuSDBdQEvIiRPGmGJ5Am/DsQO8quGlLqGR2TCkz9QjVJTX3W13om2X8o+79
         J04iepD4WklpK36ywH99BTy4LZ8OMrj2RC8aSGclnga2CvCfr/y8HaHa7Wo8VEG6gQm0
         3ZRAIFqbUPkqwlzCVTQ3AVal5zxskgB2DlSwtbLc4bugAMCywQIiX6DD+Ri6YklN+XhR
         I6PR0lW9kQBEJrxSyjXdXkae2f8d3Wmcunm+l/NZbFDAYTKE9vYLTZc1vZv0kwlqalUB
         gqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=PjAx8K6kcQIU5qm4X6m45djqbCxHIykBoCXUIuG1jTU=;
        b=7YOiCeha6neqcjqu4ewyQxHIKdPqqHBRReMXMbordzb/nMR5UpEHjufb3lnKv2Weld
         cQvqxCc0l5UI0u1GxoCzT7QoK5VdNiZQn7yCFOAvkBjdi1ulLu8EfzroUl2TjrOYwPHk
         Ueeyyz+QGtm6j1K3Aa65faui4qr3KwqjsHF88GfPBHg9g6lIGtumL3e/9/RM9qx3gZiF
         Sg6E/0nqU1uuVmDXoPWbGmZE8L55ISnRpxZwwk8OmwesFzWQnPWVCELWwncKEVKNvjqZ
         LTWGOjnYBgbWScsChxj1reu2vRjcgVstoyp1oeUuQ29HbwiU2RZbvXPvL3f67mYy9OQT
         yYBA==
X-Gm-Message-State: ACgBeo3syCRuUmD3s6NBumlhdXqIBB9wVVxAAxpSree8i7TTAGkk7131
	k0gi9IJ+Um/MsP3OYxlIz+ImHwol85A0GE9i
X-Google-Smtp-Source: 
 AA6agR68eFKcJkMuv9CpHPLwcPb8sVr97GbhbaQEIg0vIJ+8DkwYSVcuvt+Ouk2nP53EEMJY9jxBBA==
X-Received: by 2002:a17:902:e552:b0:16c:571d:fc08 with SMTP id
 n18-20020a170902e55200b0016c571dfc08mr23224995plf.151.1661232663861;
        Mon, 22 Aug 2022 22:31:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 i8-20020a63e448000000b0041c35462316sm8360909pgk.26.2022.08.22.22.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 22:31:03 -0700 (PDT)
Message-ID: <63046617.630a0220.22d93.f30c@mx.google.com>
Date: Mon, 22 Aug 2022 22:31:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.255-cip79
Subject: cip/linux-4.19.y-cip baseline: 122 runs,
 19 regressions (v4.19.255-cip79)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Aug 2022 05:31:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9309

cip/linux-4.19.y-cip baseline: 122 runs, 19 regressions (v4.19.255-cip79)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.255-cip79/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.255-cip79
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d48af81b093ff24e12907e79ce476e6efc4f7e4f =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/630460a70857fa2f6535566d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630460a70857fa2f65355=
66e
        failing since 84 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/630461336a99d9b69d355652

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630461336a99d9b69d355=
653
        failing since 73 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.246-cip75) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6304619fd6ff2307e535567b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6304619fd6ff2307e5355=
67c
        failing since 84 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63046306c0c4a720c1355647

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63046306c0c4a720c1355=
648
        failing since 73 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.246-cip75) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/630460bb7f6a99503135567a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630460bb7f6a995031355=
67b
        failing since 84 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/630461fbbebff64b4c35565d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630461fbbebff64b4c355=
65e
        failing since 73 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.246-cip75) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/630461b1d0860010e3355667

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-=
uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630461b1d0860010e3355=
668
        failing since 84 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6304631bc0c4a720c135568d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6304631bc0c4a720c1355=
68e
        failing since 73 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.246-cip75) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63045f2b2d23d0201135564e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: cip://4.19.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63045f2b2d23d02011355=
64f
        failing since 84 days (last pass: v4.19.235-cip70, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63045fbe3cdc37b458355642

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: cip://4.19.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63045fbe3cdc37b458355=
643
        failing since 84 days (last pass: v4.19.235-cip70, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/630460936a61ea8791355646

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630460936a61ea8791355=
647
        failing since 84 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/630460cf9f89305be9355643

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630460cf9f89305be9355=
644
        failing since 73 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.246-cip75) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6304619ed6ff2307e5355665

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6304619ed6ff2307e5355=
666
        failing since 84 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/630462a2c06a18356335566d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630462a2c06a183563355=
66e
        failing since 73 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.246-cip75) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6304607f2b852c131735564b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6304607f2b852c1317355=
64c
        failing since 84 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/630461e71b9eb3088b35566f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/630461e71b9eb3088b355=
670
        failing since 73 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.246-cip75) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6304617525f1da78f435565c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-=
uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6304617525f1da78f4355=
65d
        failing since 84 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63046307c0c4a720c135564c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63046307c0c4a720c1355=
64d
        failing since 73 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.246-cip75) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63045f9e4d5e7aabfb355669

  Results:     83 PASS, 7 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.255=
-cip79/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/63045f9e4d5e7aabfb35568f
        failing since 146 days (last pass: v4.19.229-cip67, first fail: v4.=
19.235-cip70) =

 =20

