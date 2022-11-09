Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E454C43217
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 11:14:00 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web12.2009.1667992437778618620
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 03:13:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Wgsa2a9F;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso3526115pjn.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 03:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nG2XStD/K167XCJ1qlMSRB6JiDNsaGVVYXR5JWEE+NY=;
        b=Wgsa2a9F98nlXHPllg2bTFzsAP99CiEIIeAQZfQJVcoikwOmZoHeYCXFzj1XO9KUsk
         Py+RBW+CvoDn21fgf/Z0dL9yvYW4lcBA5VFHzt299ZbekNgUjf+bGQsb29PdZG6yD7Ww
         RauW8l+aQZswzgaouG/qF7DIL/2ouCq4JDf4BMM6E3ug13fCZwLjFUfG3bew/mmgRpLG
         tNPgmgJU3xxtLxL6eS5HSl17eVjUwp43k0VqE/2xO9eRYODm0NBoxMrcVTNPKW/xgGwI
         KGb+ZyajuytTnYmx0ay16cu072rkSbx9i7ZQLj4iXuW/LyFAY3ZoruUuNIBT8PDiPlzr
         EKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nG2XStD/K167XCJ1qlMSRB6JiDNsaGVVYXR5JWEE+NY=;
        b=LalG5Ig+y+TPP1ZkKz/eevV7p/uL5+/CAg6ZAR9CP3pI7Kv+O4MMlMbsv7DZD2xjtE
         Xg3JZRRLqE9fQGOujgTuF7Ji3x6OsS8cY3arOX83YV5yAEm8usOuGijsep2KFBHqUjsZ
         Y4kwWHezYKMp1AWR+ispByXYNKeifw9Hg757smLRaWOgTeA2QdmoQBhBveIhUEh4vz70
         69kqCuZxZfSbVH6npOlKKQCla3fta6zjV000deEK+FAh5SliBNOZDxyQiHQlTLsn6Dkp
         gTXMZlkQMjXKUU4lpgLPVeg/SrgiLaN2i/p/g2WVCYV784YM29TwsfCU2c0xjmYGyyPN
         2S5w==
X-Gm-Message-State: ACrzQf3TdNzISFJxjfnErk5uBBIip1uKTnITwx6prXqE9W9RUjMJTXOJ
	ojrSqvEVIyICeA4U6CrcGm5Rl1UYU0YrCGhR
X-Google-Smtp-Source: AMsMyM7YpkgBK0KFTJJuUlkEQkLXda4F5zIAj2WsaOJbFhT+oIXiPZe3vnqHgJyebFm5ioM/k3JOcA==
X-Received: by 2002:a17:902:ceca:b0:187:12cc:d6a1 with SMTP id d10-20020a170902ceca00b0018712ccd6a1mr55586499plg.162.1667992437086;
        Wed, 09 Nov 2022 03:13:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b0017f9021ddc6sm8749637plx.289.2022.11.09.03.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:13:56 -0800 (PST)
Message-ID: <636b8b74.170a0220.b9da8.e690@mx.google.com>
Date: Wed, 09 Nov 2022 03:13:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 39 runs,
 2 regressions (v5.10.153-cip19)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 11:14:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9959

cip/linux-5.10.y-cip baseline-nfs: 39 runs, 2 regressions (v5.10.153-cip19)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.153-cip19/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.153-cip19
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0f7fc281d55b27b299e8388c7d44809289ba8b99 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/636b843c662a115dece7db4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-g12b-a311d-kh=
adas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-g12b-a311d-kh=
adas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/636b843c662a115de=
ce7db4f
        failing since 5 days (last pass: v5.10.145-cip17, first fail: v5.10=
.147-cip18-12-gcb2b164780be) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/636b83d66080949ebae7db80

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/636b83d66080949ebae7dba2
        failing since 225 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-11-09T10:41:12.469896  /lava-7914676/1/../bin/lava-test-case   =

 =20

