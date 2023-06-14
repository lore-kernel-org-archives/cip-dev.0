Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E8EEB64D8
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 12:57:25 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.10960.1686747441378924696
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 05:57:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Rqj0lhSM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-652d1d3e040so5040040b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686747440; x=1689339440;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JPmpdxa3QkITC1vPxECre3yZU2rDBIThs/UW4dOheB0=;
        b=Rqj0lhSMpd3V1xWtj/f1p/mtVG2ak0gR3v7K+Xsa1r/ptogyVvDYQn4udI3cejsc4M
         XtLANjxMestSFfpUkZopTerpyo0Y/sluaL7HFS02lPfq7cQY0ut5UWIBU+dfAdJW795E
         kzL/2T4ymX3lvuiDPm0GFWWsinlLzuLdWaRjgiOdFd0YZQEQAuwD3ZZerRLoyAE61ohM
         VFWX6X6NysdmY2qgkzoQAuVAcNUnnbepUrM1nE/n9fOiXqHIyUCCdEpQGKnKUTYQMy0W
         pwKnxFaBr7Do1gQJHtOhPGi3mrgEy81/IpYK820NB3tTyxw7EUWC1lN94dEO0iAySVs2
         hbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686747440; x=1689339440;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPmpdxa3QkITC1vPxECre3yZU2rDBIThs/UW4dOheB0=;
        b=aquN3MeqwksCIpfiCtM3YPs4HYugKmT58qbS3ObOZVaqOPc9cczVzkGqfxCrPg1Wiw
         mOTCOCB8bVELdJr3Aa2Tj4H6qfG1sM+4YLY/wJMbERJLhJ/r48TPP4llypqWW6u9NzeA
         HeSAi/S0pKcJ32E/3mBy+qGTeBfNwZCe739F34F5s34wLYHHOBzN2J+KybAiaShueeG4
         io9iaWSsyo+iL8lx7gKmQmb/Pb/Nfh9VK3N3kpRll7O1oUR3Czdas+lronyc3qW/BQeS
         Y6k5ZSks+In8o6sNqio8KxGSX5rvXD/3aeQiAUxuKY1IBbS5d9+W4RgPjN1tAffosBDu
         s+Sg==
X-Gm-Message-State: AC+VfDxHSLG+yZu0UD+aXFRcC3MGjGoI0cRH0SlPxaxnwpqr0E7oT8Ne
	gLI9xWmOjRBY+XDeZGLwyxcoLXTWaygYImmV+MdHRg==
X-Google-Smtp-Source: ACHHUZ6lDH2wASozOjc5ZaIImerzwpx2L31imQSGgtRTDdFrHFGBNlmCr2H/Qge/NW8U2kkH7OVxpQ==
X-Received: by 2002:a05:6a20:8424:b0:115:1c73:83f5 with SMTP id c36-20020a056a20842400b001151c7383f5mr1475606pzd.26.1686747440187;
        Wed, 14 Jun 2023 05:57:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r64-20020a632b43000000b0054fe6bae952sm81221pgr.4.2023.06.14.05.57.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:57:18 -0700 (PDT)
Message-ID: <6489b92e.630a0220.eaa8.0260@mx.google.com>
Date: Wed, 14 Jun 2023 05:57:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-191-gf4efde512959
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 11 runs,
 2 regressions (v5.10.182-cip35-191-gf4efde512959)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 12:57:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12019

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 11 runs, 2 regressions =
(v5.10.182-cip35-191-gf4efde512959)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
                | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-191-gf4efde512959/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-191-gf4efde512959
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f4efde5129594b413888498ce6f27da48a03771e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b38de92380014e30613b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-ipc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-ipc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6489b38de92380014e3061=
3c
        new failure (last pass: v5.10.182-cip35-8-gc3d08808cfa7) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b51d815d5040ee30613b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/ltp-ipc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/ltp-ipc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6489b51d815d5040ee3061=
3c
        new failure (last pass: v5.10.182-cip35-8-gc3d08808cfa7) =

 =20

