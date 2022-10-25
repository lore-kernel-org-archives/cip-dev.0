Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA144FA3740
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 17:29:39 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web09.810.1666718977034792847
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 25 Oct 2022 10:29:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=irNB6or/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id q1so12119987pgl.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 25 Oct 2022 10:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PTcp7QDIdMAGPwcRWf9Q5MvNwEYwZ0pEzeBXLy6ntWk=;
        b=irNB6or/qCahqG9KBtsr06x9PCuZYbRqqmkPaKXO+erE5vzOqcLp2bhVW/9Uf6oARr
         7vmHtetEFDm//c3hmuNXxXnQaoD38B+qDRuL+HMk6w8L0/8wbTQFaayaOIr3wTk0/mNP
         fRXLj2Jix9JbPhxgmip25GDEV5s0Ccw71sUib1BjBYHKD+2QLME0QiNvqu7rLCouY02J
         yTBNpqt+pPotmoUOr+uAGU2KghCeXXxUzePGgcA48fCU9WWHwy6CB9leRsusG8bMTRo5
         2INg0vOl0y33sCS4cyAPHufuwBtP61OqhfGmBz2AWR422KvWmKEos+lUmmqDXyQKxq0w
         fUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTcp7QDIdMAGPwcRWf9Q5MvNwEYwZ0pEzeBXLy6ntWk=;
        b=MtHKrq75+BUJRDOVgyhzVGp9QpApj1ONhUO9mhhzUxonCkpMYQA5hiG7gZC99Qo9rV
         0KL3ydWL+uJ8WIDqBaMw5kcPSCDF2TOfdEPVcMInPL5FUkTPT+UjverxLEclDhAYum59
         Nz760UobYBRAHmlP20/lju5MZxpmiVvdV2fzTNoiH6JkyU7nT8dNPiXzz2d2H0uBipjD
         IhrR/B5T3z0mDuPAFRCRrKprLTKA3mVyl5szxVW1VNNSOdv0FNz7zJXgD7FZijHILiku
         MWV8/6WMVNlcLJ16Ycp/Xw8xtNKMGJmT4OpGP8u5k8V3FTPyA9uo1kWHzdQmp86LK38/
         Mv5Q==
X-Gm-Message-State: ACrzQf0y9M6FgIeY4cW71ov0qk1jfuRPvJ3aXHgUYx0BjVpigEGDOHyz
	r1UdZr8sAf3Bp9Yi1Hs2ApL4et8OZ2NEBo3J
X-Google-Smtp-Source: AMsMyM6jqKIOWb0he4A24QoXRJx5NEKLdDu1g9GY3+ZSELKt7Xr/oIfbMSvqqmm/rQwsglCbtkO9PA==
X-Received: by 2002:a62:5e06:0:b0:56b:e3f8:824f with SMTP id s6-20020a625e06000000b0056be3f8824fmr9999819pfb.84.1666718976362;
        Tue, 25 Oct 2022 10:29:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0016c50179b1esm1462993plg.152.2022.10.25.10.29.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 10:29:36 -0700 (PDT)
Message-ID: <63581d00.170a0220.d1deb.334f@mx.google.com>
Date: Tue, 25 Oct 2022 10:29:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-518-gc75907dbbb95a
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test smc: 12 runs,
 3 regressions (v5.10.145-518-gc75907dbbb95a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 17:29:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9840

cip-gitlab/ci/pavel/linux-test smc: 12 runs, 3 regressions (v5.10.145-518-g=
c75907dbbb95a)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig+arm64-=
chromebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
           | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-518-gc75907dbbb95a/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-518-gc75907dbbb95a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c75907dbbb95a00b6b5fd298e65585204cf96ea5 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63581533d26ae152a35e5b48

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm64/defconfig+arm64-chromebook/gcc-10/lab-b=
roonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm64/defconfig+arm64-chromebook/gcc-10/lab-b=
roonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221007.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/63581533d26ae152a35e5b49
        failing since 167 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/63581583758a876ae15e5b3b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_a=
rm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_a=
rm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221007.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/63581583758a876ae15e5b3c
        failing since 167 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/6358103751ae74bd1e5e5bbe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm64/defconfig/gcc-10/lab-collabora/smc-qemu=
_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm64/defconfig/gcc-10/lab-collabora/smc-qemu=
_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221007.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6358103751ae74bd1e5e5bbf
        failing since 167 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

