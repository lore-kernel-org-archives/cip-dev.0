Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B48C32771
	for <webhook@archiver.kernel.org>; Wed, 28 Sep 2022 14:35:39 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.8688.1664375737941106077
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 28 Sep 2022 07:35:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=cC7+0IVI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id a29so12711589pfk.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 28 Sep 2022 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=ZWYAiXMgTj+RL7plZbfqS56bPyI4yiuM1zr/nzj3GoI=;
        b=cC7+0IVIItT6hs8FH1mEifAmY1aJoWV/qcBPVlBTygB/T17X5xVU3PwOIK/OQ4QogV
         Jy+GFyJiXx/8yx/E8kkgDSXNDSPT3W/AqR3xmb+wOMVLIgeW/KhocHPK6ss4O+p45Zli
         oG508UPO/tohLa1Yx43ZgyWSHcFCmxVRD48AoQtno9UuLhYMe+QqzL8eXFTgDuifc14f
         7cAODjfwwrUuvAh8WxaP3klFcTS3j5mvbXJa/z5qR8JQHwoCr2P414JNh/ib2s5YbNfH
         3QooKdr5K/KMc8ewCTTjsfG/yTS1X6wYPKWvW4vup94vNqB15PGzwzdHqg+0+WKNUA2d
         2qQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=ZWYAiXMgTj+RL7plZbfqS56bPyI4yiuM1zr/nzj3GoI=;
        b=OujdKZR+r/Y1FtESYazL4VW0qk23+/T2I+eHqfc3OldfNvCyPZq64gLVYFFJ0UCbgQ
         nAAYl8+1MaUc5PAqWKr3lqMxFDfD2dZvukNmIvzJw/Gje4Zf/5VFYVLXRfRDlZN3FAhe
         K+J86necq9qEKdwEu9xGlAWtcN7D6PaWcKlUdZiw58vFST1JpHNYJ/tgaFA/fRhsIpj7
         ui1pCQiGFLpjWzQzGaKlNFd2p0oTUpxXtS2n9lBVEjIIzSJWwypShvMJ5F8wzmlBcWo+
         /PizkNuIAwyF+iZxRuYJHWVHHYfSryT5Rs6V1EOSgemj+pqrxt+8jc2TvTzfg5SVBiTo
         NsvA==
X-Gm-Message-State: ACrzQf2eKwmBEiNJlY3QzEDHU90Dku9bv9xe8zgjUG57MJFbAFFRAJG1
	QyV9VI/Pqbobc37pXZ24aL+HDS4dBokiIP6k
X-Google-Smtp-Source: 
 AMsMyM4kCE5wxRsVA/e/8r5GtB2NjJqPozrs08yVxbaK7PSyGDIraXDfpZQY2PJKcFUtBQeIsZai/g==
X-Received: by 2002:a05:6a00:1a08:b0:545:362c:b219 with SMTP id
 g8-20020a056a001a0800b00545362cb219mr35088169pfv.27.1664375737012;
        Wed, 28 Sep 2022 07:35:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 f15-20020a170902ff0f00b001782aee4881sm2507871plj.153.2022.09.28.07.35.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:35:36 -0700 (PDT)
Message-ID: <63345bb8.170a0220.ef87a.4b45@mx.google.com>
Date: Wed, 28 Sep 2022 07:35:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.259-cip82-57-ge54228ee5a88d
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 3 runs,
 2 regressions (v4.19.259-cip82-57-ge54228ee5a88d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Sep 2022 14:35:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9567

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 3 runs, 2 regressions (=
v4.19.259-cip82-57-ge54228ee5a88d)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.259-cip82-57-ge54228ee5a88d/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.259-cip82-57-ge54228ee5a88d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e54228ee5a88d934b744fe3e17655b848b356724

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/633451745ec2e5f1ffec4ece

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.259-cip82-57-ge54228ee5a88d/arm64/defconfig/gcc-10/lab-c=
ip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.259-cip82-57-ge54228ee5a88d/arm64/defconfig/gcc-10/lab-c=
ip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/633451745ec2e5f1ffec4e=
cf
        new failure (last pass: v4.19.256-cip80-1-g68250b8eafbe0) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63344e773075d1c1dbec4ea7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.259-cip82-57-ge54228ee5a88d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.259-cip82-57-ge54228ee5a88d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/63344e773075d1c1dbec4e=
a8
        new failure (last pass: v4.19.252-cip78-146-g6acc38498265c) =

 =20

