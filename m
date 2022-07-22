Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A870CC433EF
	for <webhook@archiver.kernel.org>; Fri, 22 Jul 2022 17:44:17 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web12.10677.1658511851245498512
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Jul 2022 10:44:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=5f8+0Duk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id w185so5052889pfb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Jul 2022 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=GvcUIgG4bs0SLo5xqx/nhraKHnKpemP1Xtd9mzTm+PQ=;
        b=5f8+0DukcdiYGa1omubD6aQfcApuoLNO9vTUi9cNq4S1ddXbOGVh+9CetpN6SxHOgS
         Rj+WXTGCuXkwKSS3TQ/15Mq3jcICi1T135hH6ly4oUCsi8Nb6/2Zjg+NNsp3iifW7E1L
         PG8Jpm+lpmbA+9N5PxGc+lrhKuI8uzc1t7GQXRMxVlIJ1vefttj+cXtuVxHa9ESw50n6
         7kGx6UWYBn5kmZTBdIWLjQBU4z/4bFhiGaENHE8hVCtwp4Ilrcv7y491nk6lzLYt8xCl
         +/LN54hRehqkIAJ/PBxkGZR0G/3YYtRX4PZ4lKirW0pLG72o5GYqDiZg/8w37BmFEt7o
         thuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=GvcUIgG4bs0SLo5xqx/nhraKHnKpemP1Xtd9mzTm+PQ=;
        b=t5IxOhBBdm2Piyjh1V43cqI4x8GUa4Dhae3kXprc78hqLWSuLsjZR9/Df6TPB06MZQ
         XFd0aKv9h6PZ7eE2J2LliJlcTJ3wHYwN2rC5315DvdXtrm57jN64S7mhPAKv/RSnCV9p
         CncDDdvQEKDvldBSzHa7eVvO8qiNJsncUzPKsdNtC8RZcuuVSx9WeoF+yVbhutl9JQzH
         kAHNqUxV2enKOb+86eWMmoqPyE1TWa+FeFwPhr1ljmMw7/j3LG5A6dKfbJk9X7tSn2c8
         IkOYy7Gs6t40ThiLUYTQKrCab/5Ua2AzcAKOk2/XmfSpy323kZ7hIEkql4RxX2kvkSaN
         INdw==
X-Gm-Message-State: AJIora8+MkmrDIRSOFeWpG1bWhJs4/uNSiwf4NE/VOGr1rdwcWF4CXl/
	8dEnfsyTtlrB/J7AWtoPYe3phFr6a0PgADhG
X-Google-Smtp-Source: 
 AGRyM1tIZzHTE+NiHJ/Rz6SRD4gSEFjlLTpCf9tP2qmQ3SkYUgSsvHd5/0fNmfA8vccU3cBDKfmbvA==
X-Received: by 2002:a62:1509:0:b0:528:98a1:1f7e with SMTP id
 9-20020a621509000000b0052898a11f7emr969396pfv.11.1658511850320;
        Fri, 22 Jul 2022 10:44:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 r2-20020aa79ec2000000b0052ba82df682sm4216489pfq.102.2022.07.22.10.44.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 10:44:10 -0700 (PDT)
Message-ID: <62dae1ea.1c69fb81.12b8f.68ab@mx.google.com>
Date: Fri, 22 Jul 2022 10:44:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.251-cip77-82-g10c370b53152
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 49 runs,
 5 regressions (v4.19.251-cip77-82-g10c370b53152)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Jul 2022 17:44:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8883

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 49 runs, 5 regress=
ions (v4.19.251-cip77-82-g10c370b53152)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                  | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.251-cip77-82-g10c370b53152/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.251-cip77-82-g10c370b53152
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      10c370b53152e01c8282be083dc0943e33d50ead =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62da53bae883615b87daf071

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220716.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62da53bbe883615b8=
7daf072
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62da551e78377bbc20daf064

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220716.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62da551e78377bbc2=
0daf065
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62da5a55df4c368c03daf05e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-ci=
p/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-ci=
p/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220716.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62da5a55df4c368c0=
3daf05f
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62da64419c1ee7853ddaf057

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220716.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62da64419c1ee7853=
ddaf058
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62da5b0da160089858daf059

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220716.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62da5b0da16008985=
8daf05a
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =20

