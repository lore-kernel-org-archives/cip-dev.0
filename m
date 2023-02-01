Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6B9C636D6
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 10:39:21 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web10.19993.1675247960532803260
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 01 Feb 2023 02:39:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=wo1tJwm2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id 7so7252375pgh.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 01 Feb 2023 02:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hsr17bqx0O7av7lvjiLL6DggRwdmfTymGThIRhcImFA=;
        b=wo1tJwm2pnCEMGFB/EJOEjF6cFO5xk7HjnGyguydCdN/lqaRmgTjoI39BLBcRSwnG6
         RldQEUICbvQlvRJaAtP4huTWbYZzZXu+6V4yPJEU90FDlVvv7qP+8ACakvkiHDbedkax
         l3g6OGLHMYBlBcySs8Dq6yTosa7HDG+yhsZ9btZ+DAe1u+LZMa2Cvzs1MOKgv4m07rKK
         zb5J9ddQTdSUhTyMt0mroB2A4f5vwR0TXaWO7RJzrpkZLoT0/NLnBhuCf2aF3442kdBC
         LwqPu2A1oq3m1edBpbHuhnv2/QEsZ4eWW7Nbqk6XN/bcVkKFvmLSzgVcEEJrsZH5Ey7H
         65ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsr17bqx0O7av7lvjiLL6DggRwdmfTymGThIRhcImFA=;
        b=sGfzDXT6qsbv4j7uBU9Vk/wk5drbc8ozhEd570xx0YLXVf3euXbErB0AwPAUhGTCu3
         sdbwxED5/0XAqnpApcjwXG13uF0WM5ijm+IP1U29By+wD11Ox4D9//RO8kAfgWpKfdDN
         qZcPAk2eyv7UHUYVrFY1EHc/k1/O75NUlN+WlWnJHWeelIQzeNV2X4oQ67HbHJG9PBCX
         vUm2IAkFevP2WIwOp6qTLPAc9j96ciFzT+yqjEYNSVcZ0+LIhA4vqKmHheAHD92niALY
         iiG+lmyTlfl6WQvBHDQ+sad7rpNrlepVDq9sb/tF/lpW+//iBczudpfi2p87J6p636zn
         08xA==
X-Gm-Message-State: AO0yUKU5XYf1YSd08z19tBum++ab0KuUvhj3COgBwrF89fjVBIfTzofk
	famJw0cnPttUbQCjj6Qr7P6RTvJxSbip2XRjcTwjKg==
X-Google-Smtp-Source: AK7set/RUns/pis4nD0RXLBMhN9L7GyP36CQoxAPBIME6B+wNIVz2zHXBRhMOpjd8llP1/Fh4+eFlA==
X-Received: by 2002:a05:6a00:2409:b0:593:5e76:b0 with SMTP id z9-20020a056a00240900b005935e7600b0mr2088406pfh.2.1675247959611;
        Wed, 01 Feb 2023 02:39:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n38-20020a056a000d6600b005813f365afcsm11092956pfv.189.2023.02.01.02.39.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 02:39:19 -0800 (PST)
Message-ID: <63da4157.050a0220.1e330.45fe@mx.google.com>
Date: Wed, 01 Feb 2023 02:39:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.165-cip25-144-g43e1d8dfbb26
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 60 runs,
 2 regressions (v5.10.165-cip25-144-g43e1d8dfbb26)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Feb 2023 10:39:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10551

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 60 runs, 2 regress=
ions (v5.10.165-cip25-144-g43e1d8dfbb26)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =

rk3328-rock64                | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.165-cip25-144-g43e1d8dfbb26/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.165-cip25-144-g43e1d8dfbb26
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      43e1d8dfbb26af10d1f04a30d7d08cdc4a298862 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/63da3b295b0393674a915eec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63da3b295b0393674=
a915eed
        new failure (last pass: v5.10.162-cip24-952-gf408044f5bad) =

 =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
rk3328-rock64                | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/63da38458638f6ca08915ed7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-144-g43e1d8dfbb26/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63da38458638f6ca08915edc
        new failure (last pass: v5.10.145-cip17-192-gbe875d9d93504)

    2023-02-01T10:00:22.308258  [   35.071355] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3263214_1.6.2.4.1>
    2023-02-01T10:00:22.435528  / # #
    2023-02-01T10:00:22.537149  export SHELL=3D/bin/sh
    2023-02-01T10:00:22.537601  #
    2023-02-01T10:00:22.639027  / # export SHELL=3D/bin/sh. /lava-3263214/e=
nvironment
    2023-02-01T10:00:22.639408  =

    2023-02-01T10:00:22.740622  / # . /lava-3263214/environment/lava-326321=
4/bin/lava-test-runner /lava-3263214/1
    2023-02-01T10:00:22.741259  =

    2023-02-01T10:00:22.744524  / # /lava-3263214/bin/lava-test-runner /lav=
a-3263214/1
    2023-02-01T10:00:22.961367  + export TESTRUN_ID=3D1_bootrr =

    ... (12 line(s) more)  =

 =20

