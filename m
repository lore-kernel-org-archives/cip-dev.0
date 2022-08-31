Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EA5ECAAD4
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 13:22:31 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web10.25674.1661952147869928685
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 06:22:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=mLaWQXT4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id x80so9919794pgx.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 06:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=J8ObQg0RkPQJ9oxrgLu4Jl0K7uda+sSQz2SoKQEk+wU=;
        b=mLaWQXT4DuHf9jJLeYmJP+jzs+9nrntkc4bhO9Qhl0QMd4l68520owk+9uC3pXKApI
         uZzgJ896CKeipXhWHw0yk0/BG29iMqLcSDE5soJv1f0ucuID9hXJXrb+FbzTuDxFmkRS
         SiwBkpfJk4xD7HAi8sq5QxDA+Sr5H9fxJEHohkQUK6FD7Z7pin06HKIi4tYDW9WCc4Ok
         qNq4ZH0pxW7QGx8QlOHiJc6yokWxtzvh6vLn6iALKJ5pXgNQi7vkQpU98FYmO/DKFsLO
         1cDurgulVHvNjLvvcW9hXnVZFipikMUwMMPUOtpFblQqnosHE6KHfvwUisnADZSnHSZl
         haMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=J8ObQg0RkPQJ9oxrgLu4Jl0K7uda+sSQz2SoKQEk+wU=;
        b=BKgfjGwNq/QwA1kXrWNjG0+6u5YKmzGWiVQ48YSACNghxcTkeZjUXaOy1E/ymyy0rE
         KdL5HpLDPyOmoxrWYFQJhtVOM1uNpP9C5ptQOwo5QL1AbPgrBp28gcINMnmF91LvU+Q2
         RH+BV7DvVhrMNpJa09w2FtM+nndihXhrXrByGDYXS1wbmxPwPmGF99dnnN19KT4VqA/o
         9X6KTpfrkWc5gPEumovUDNYTsehUEBw2F4wsybV5kTr47wZ768OMpYELyXYYEBefkBDI
         JLHUjiQFBJk/Tz4G7JkZ31cI+gYq8Sx2x3L06H494ojgRAH5F7MBkGo0rJ0EDXFfq8p1
         oDxw==
X-Gm-Message-State: ACgBeo2INQBycuSOMUSxBVU1oDZ07Jp89FFY9FtBf9LFuNVVWV7LQsgH
	rkXz+h/Py51rlNKrKk984745Xt4QqRzpSlHJ2+w=
X-Google-Smtp-Source: 
 AA6agR6ux/Llbmi2bel2AX2tdVZetmDur8r8QS+x/NBIp84fdeVFvq0he4k6aH7Li2pEq3xtAdmuHg==
X-Received: by 2002:a63:4c3:0:b0:42b:5150:fcfa with SMTP id
 186-20020a6304c3000000b0042b5150fcfamr22252109pge.210.1661952147058;
        Wed, 31 Aug 2022 06:22:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 cp9-20020a170902e78900b0017542c2ddabsm1514587plb.288.2022.08.31.06.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 06:22:26 -0700 (PDT)
Message-ID: <630f6092.170a0220.4aec3.2c42@mx.google.com>
Date: Wed, 31 Aug 2022 06:22:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.138-cip15
Subject: cip/linux-5.10.y-cip kselftest-futex: 10 runs,
 2 regressions (v5.10.138-cip15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 13:22:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9341

cip/linux-5.10.y-cip kselftest-futex: 10 runs, 2 regressions (v5.10.138-cip=
15)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
beaglebone-black             | arm   | lab-cip      | gcc-10   | multi_v7_d=
efconfig | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
         | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.138-cip15/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.138-cip15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f2d94917db95e02bef61288aba5b06e0dfef3a73 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
beaglebone-black             | arm   | lab-cip      | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/630f51f3708c20750c355644

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm/multi_v7_defconfig/gcc-10/lab-cip/kselftest-futex-beaglebone-bla=
ck.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm/multi_v7_defconfig/gcc-10/lab-cip/kselftest-futex-beaglebone-bla=
ck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/630f51f3708c20=
750c355645
        new failure (last pass: v5.10.136-cip14) =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/630f51383f29cbe24f355645

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-meson-g12b-a311d=
-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-meson-g12b-a311d=
-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/630f51383f29cb=
e24f355646
        new failure (last pass: v5.10.131-cip13-84-g3b53e4dbd9f41) =

 =20

