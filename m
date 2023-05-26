Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B6CC77B7C
	for <webhook@archiver.kernel.org>; Fri, 26 May 2023 08:27:32 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.3694.1685089651902212254
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 26 May 2023 01:27:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=M2M9oj85;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1b01bd7093aso208795ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 26 May 2023 01:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685089651; x=1687681651;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=92jEECHBU0oUT6AR4U6qTSSo+6AEoNwwsZHdOMSYXeQ=;
        b=M2M9oj855XsQb86atMAUxgIditOR/92oflr1RtDv5VQFPTkH6oP8V1tr2zye2przxM
         aU20n4LAwWYj+QG0svAAvTPQBvQvSdQ8Rgdutj4EcKlHclccgcBK4/DUTX8vwUYXa0U4
         Xt8fzGLcUbFSUiCfkMONbCva3Ez6TCfY9S8VyxOdSzv1wNOB43mT9TFM44fIqLTkBxGJ
         7Zk5rsRIJJVB6jVtVzBX2uyjPGSXQdaPN4zYWIoleYq5iRB6DAP/w5wVWd3gxpCpK54l
         PSa8F2niEJ6rPvQeyu2LOj8WcZKqrVQ59i3ClowshqmctAllffs6pCku3Tu/V7r2NO6s
         vpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685089651; x=1687681651;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=92jEECHBU0oUT6AR4U6qTSSo+6AEoNwwsZHdOMSYXeQ=;
        b=YnsuRPNl83TBYLKPZ3TgCPD7sUjyTCNToUzRXY9U6MAMEi8K3+KQBtv/KOnqIpmDfg
         vI1PjKGIqkI6sKcjc7KNeEdNSmAt9xzyqyZbmDUOixxuOij4XqgNYUWET7nPFmk5A+v4
         C9gUR5ljY/nSqHJj3WbvcIG+6LiDvUW9ZjCHQytjdvRu+rs+PHxKWm2TVjTs0vhYkEt6
         /VnI5NdANq0u+eDpZKpftrKxitpImwGPwpmgkeCWvueH2fGgkl+itzWEceQ9oZcgBFVA
         ALCw/AH2j2mK0WmzsfSDALB58Z25vafV7ArecB7/GM1mLFATxagSsR5iodoX1EorocJB
         2pYw==
X-Gm-Message-State: AC+VfDyRsZfjJWrXhbYjNzVOehInGVgjBBKYuUeQAiSlmczdOI2A6IIW
	t7LJY8nb54U6By0Igulrja3R8ApIs5QI5xKl+p6+fQ==
X-Google-Smtp-Source: ACHHUZ6pRjtDsWuX+/RNJQNP/zwkoj++DjsW5e5E1iJftLWap06etQeoHd3QVlc9sEPad5pxmBd8hw==
X-Received: by 2002:a17:902:c94a:b0:1af:e999:a070 with SMTP id i10-20020a170902c94a00b001afe999a070mr2394004pla.14.1685089650715;
        Fri, 26 May 2023 01:27:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d20-20020a170902b71400b001a4edbabad3sm2682721pls.230.2023.05.26.01.27.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 01:27:30 -0700 (PDT)
Message-ID: <64706d72.170a0220.ba73a.5560@mx.google.com>
Date: Fri, 26 May 2023 01:27:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.180-cip33-21-g090289427e8b2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 10 runs,
 3 regressions (v5.10.180-cip33-21-g090289427e8b2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 May 2023 08:27:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11651

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 10 runs, 3 regr=
essions (v5.10.180-cip33-21-g090289427e8b2)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip33-21-g090289427e8b2/plan/kselftes=
t-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip33-21-g090289427e8b2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      090289427e8b2be9dac126c4d1b760b100f2c6b8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64705e6973837540f82e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/kselftest-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/kselftest-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230519.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/64705e69738375=
40f82e85e7
        new failure (last pass: v5.10.177-cip31-122-gfb6ca504156b4) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64705f107a93c7bdb52e85f6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230519.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/64705f107a93c7=
bdb52e85f7
        new failure (last pass: v5.10.179-cip32-384-g291adc46abef0) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64705ffd992f2e1ddb2e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/kselftest-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/kselftest-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230519.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/64705ffd992f2e=
1ddb2e85e7
        new failure (last pass: v5.10.179-cip32-384-g291adc46abef0) =

 =20

