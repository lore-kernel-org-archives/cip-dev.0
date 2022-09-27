Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DF2C6FA83
	for <webhook@archiver.kernel.org>; Tue, 27 Sep 2022 10:02:43 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web12.9169.1664272958953610304
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 03:02:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=GwDO+040;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id b21so8623041plz.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=gz8DbaVa3Bm5h2RHwvPehOwzjLp0mTWTo61VuCilgZ0=;
        b=GwDO+040w3TsQzByETUwF3NoZrMfmYONnk4WWllxNFY5PZYBy/2gx2o9KgX5mB+OdQ
         g86WoMOoUkW1ddAl1HtmbCN9aF0a4WOyU7JJJJKlyipqRrDgP02k+i/wgfptXgDyAuHB
         WOozkoZIJWdvMY1WWMZaMCp2i+AWuWOQIf8KmrUrJyLlEwloa1roN0AiansoCVLgPLeF
         GqevR0166RhR9f8FJmBHqGDhHqusqf1YjVcJ9s3QiNwHgYIuGaAGoavoATEaoMJpdzKS
         QDajriAhwORhu+rUr6cuIlVnKqVMajUgxQ49ejiu7dBzWSEoh+gPXQkVkfqFkekf/rED
         yvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=gz8DbaVa3Bm5h2RHwvPehOwzjLp0mTWTo61VuCilgZ0=;
        b=LwkTmfwc7aAEEk/KToEUjDZ03eIy65TeKvB6LYXoQesq15khro0rW9Vld8Ui4cx2wU
         HKJRHhPVYFzx7jNFl/rKzljv9ixMi3y8EeQoXa8B6EwWMCuMJAkKUlotOKdpHhv+KMG7
         URB0rsmKhyg/mONOgrAgryxExY+UfE0saxyY5+ABFu1DBpRImmzc1m5Cm0iUJSzIvQAK
         m2d8rFpbVZvBnA58K4muPadrNGbBh2kTGu73dzQg2YWMV6fHArtwpCNbn9TZ3HU41Pld
         sytbeuAzUh5Lv0vHrlmaZx1VIh9EO572WM8rzHTsOWl1Ndn+ivBo1ZhBxHqmVHAbFbpH
         8puw==
X-Gm-Message-State: ACrzQf36tkc18BMmWRICGgAdpeSiIXesZq9MEJ8I8Ps2MuwtOTfxrl5b
	jMnFl11VsEXQYuLjgJvTDGUq3s6barhPtnx1
X-Google-Smtp-Source: 
 AMsMyM7a33/kZB5T+IPUXsyUATxU4JubXnc0fp2M+OjIdVR6Yqie01oCkae8+Jve3bWRJ3x64GSQPg==
X-Received: by 2002:a17:902:f70e:b0:178:8895:d1fb with SMTP id
 h14-20020a170902f70e00b001788895d1fbmr26396695plo.166.1664272958154;
        Tue, 27 Sep 2022 03:02:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 t6-20020a62d146000000b0053e8368ec34sm1265673pfl.32.2022.09.27.03.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 03:02:37 -0700 (PDT)
Message-ID: <6332ca3d.620a0220.77c14.1f3d@mx.google.com>
Date: Tue, 27 Sep 2022 03:02:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.259-cip82
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip baseline-nfs: 22 runs,
 2 regressions (v4.19.259-cip82)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Sep 2022 10:02:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9557

cip/linux-4.19.y-cip baseline-nfs: 22 runs, 2 regressions (v4.19.259-cip82)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig       |=
 regressions
----------------------+-------+--------------+----------+-----------------+=
------------
jetson-tk1            | arm   | lab-baylibre | gcc-10   | tegra_defconfig |=
 1          =

meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig       |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.259-cip82/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.259-cip82
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      91f283faebd1a92efc2cfe0a3de7c568c87e5ee5 =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig       |=
 regressions
----------------------+-------+--------------+----------+-----------------+=
------------
jetson-tk1            | arm   | lab-baylibre | gcc-10   | tegra_defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6332be580b1b093b8fec4eea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6332be580b1b093b8=
fec4eeb
        new failure (last pass: v4.19.256-cip80) =

 =



platform              | arch  | lab          | compiler | defconfig       |=
 regressions
----------------------+-------+--------------+----------+-----------------+=
------------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig       |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6332bdd2062b59b06bec4ee7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxm-khadas-vi=
m2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxm-khadas-vi=
m2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6332bdd2062b59b06=
bec4ee8
        failing since 35 days (last pass: v4.19.233-cip69, first fail: v4.1=
9.255-cip79) =

 =20

