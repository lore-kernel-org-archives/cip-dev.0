X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.21881.1647222087797718072
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 13 Mar 2022 18:41:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=FSvawJHJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id h2so8949528pfh.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 13 Mar 2022 18:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=LEtRqlLyHTWJvfEOaL+SjLgIkwYhEs0ctRuHIONV1vs=;
        b=FSvawJHJ7RCUZqXfCsgKtZqayWd+lWrzPWqtHC3M2RuWG4lg8RjIZbyaOA7Yxo8dQm
         QCn4BgBIqssNtL3/GC/dfR8p7f+YXAQ1Q+sOUh1c7wTlQB+SrwGgYjbvsiUnR2rV7M10
         BlwdXgqSxm9C1CwHcqq/YpN4rOGG38ZreRDyazqj6tie/K/BlyWjw1Sy978Cq6ahn7Cv
         HPeF3dEf/FURJzSMqPXaSfoJITJ7Sjd/6GVmTCJHFk/pGFoEURgSolRaM0KGEip6WVDC
         6xheVCHjhLx+34OLZkVyqY6E78j1VS5QFbVZNlYHeZpi84EAJcjaUO9D7HorqXloL8xv
         F+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=LEtRqlLyHTWJvfEOaL+SjLgIkwYhEs0ctRuHIONV1vs=;
        b=sS6O1lX3P2VvqmoFw7RUNfQd+g2x19EuJ8sdTh1L0iVtvslIr/ysf6vpSIjxVagaMw
         3qQ0w1QgRBvUoqy0kbjZgg6ms4kwpypdZ8QBUs97yky442xj7/IQduNYvbLDyVDuuAS3
         5+3O3FzMPzm03F9WpNgX21DpyR8DY3ADRnDdSKBO2lfJV1HCMF4gffX8ZKv4AUGLzcF0
         Le7yxqciCkQUJO91zrJABWtGhIFFxCWcnNUolSrr+rQC0Gi4bZJnM8gArGw6bRBaXAtT
         sDAVP55tlM/xPhP0SmkX2cKTySFjgNNyXX1Gg8amT+Xi7LGjqyEY+XzOkxhYsK+E0UDE
         nkvA==
X-Gm-Message-State: AOAM531u+Ku9eUqBxvhlCUaYkUvedRg2NTT6GZwqPwFvNQy8PwsGCq+k
	sW3zR1iXd+5avJ6m4aUoFOrVhevFE+Dsworlxvg=
X-Google-Smtp-Source: ABdhPJwJk5HlqLPs/DwvWgJkOrSl4anKWrx0AEitWCvI8ZXSlt3+h7fN9Z7oBhiW9k3s+gUP+zaBXA==
X-Received: by 2002:a63:e744:0:b0:370:25a8:bfed with SMTP id j4-20020a63e744000000b0037025a8bfedmr18665153pgk.432.1647222086903;
        Sun, 13 Mar 2022 18:41:26 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k12-20020a635a4c000000b0037852b86236sm14250279pgm.75.2022.03.13.18.41.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 18:41:26 -0700 (PDT)
Message-ID: <622e9d46.1c69fb81.cff32.4806@mx.google.com>
Date: Sun, 13 Mar 2022 18:41:26 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.100-cip2-484-gede5006fb276
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 25 runs, 2 regressions (v5.10.100-cip2-484-gede5006fb276) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 25 runs, 2 regress=
ions (v5.10.100-cip2-484-gede5006fb276)

Regressions Summary
-------------------

platform            | arch  | lab           | compiler | defconfig         =
         | regressions
--------------------+-------+---------------+----------+-------------------=
---------+------------
r8a77950-salvator-x | arm64 | lab-baylibre  | gcc-10   | defconfig         =
         | 1          =

rk3399-gru-kevin    | arm64 | lab-collabora | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.100-cip2-484-gede5006fb276/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.100-cip2-484-gede5006fb276
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ede5006fb276670a43bd44dd184690177cf47408 =



Test Regressions
---------------- =



platform            | arch  | lab           | compiler | defconfig         =
         | regressions
--------------------+-------+---------------+----------+-------------------=
---------+------------
r8a77950-salvator-x | arm64 | lab-baylibre  | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/622e94a65c071765b3c62970

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-484-gede5006fb276/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-r8a77950-salvator-x.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-484-gede5006fb276/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-r8a77950-salvator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220228.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/622e94a65c071765b=
3c62971
        new failure (last pass: v5.10.100-cip2-425-g0a0d92194f39) =

 =



platform            | arch  | lab           | compiler | defconfig         =
         | regressions
--------------------+-------+---------------+----------+-------------------=
---------+------------
rk3399-gru-kevin    | arm64 | lab-collabora | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/622e8e1742475b9252c62968

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-484-gede5006fb276/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-484-gede5006fb276/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220228.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/622e8e1742475b9252c6298e
        failing since 4 days (last pass: v5.10.100-cip2-319-gcbff87047566, =
first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-03-14T00:36:23.040806  [   37.042257] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-03-14T00:36:23.603917  [   37.604141] cdn-dp fec00000.dp: Direct f=
irmware load for rockchip/dptx.bin failed with error -2
    2022-03-14T00:36:23.613098  [   37.614479] cdn-dp fec00000.dp: Falling =
back to sysfs fallback for: rockchip/dptx.bin
    2022-03-14T00:36:24.089268  /lava-5873058/1/../bin/lava-test-case   =

 =20

