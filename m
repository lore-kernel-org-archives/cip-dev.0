Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336D1C07E9D
	for <webhook@archiver.kernel.org>; Tue, 27 Sep 2022 09:39:43 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web08.8733.1664271574256496915
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 02:39:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=XqbpMy8r;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id
 i15-20020a17090a4b8f00b0020073b4ac27so9533424pjh.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 02:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=0TU6pOXxD45oYi5mrcxKpn8uM50iBHkrdOiAHXcJj6c=;
        b=XqbpMy8rzSuEQLaMvi5H3q+diJov9ttmc4sGJKoKWG45m9CCCzH0KodjJdKpgpF6/f
         0jqY9crGCD7MdrlDjOf03pjY1novyjTs/6HSoiZ0rIbk/YSz7WG7E9dL2OxLr/Yj3HDT
         7bP1mIdsH4dyn+gCcwFsAWTSUSFVFjBvlRXBvgKbX1DGVSm7YhdYDLjK1SSAqEdlhnl7
         N9u+xk1Zqcz6U3pTvjU+OsYzGmTtFRqLjMFSZ1XBftPm+9dX0Bjmk/jKCVkJB4btWaNc
         TBK3VfQyWrqf2j/07InNk+BdBwOIVWEVV3DoHVEcuVKRzI7fVCd5iTL4XZmzLtvZLW8j
         +H/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=0TU6pOXxD45oYi5mrcxKpn8uM50iBHkrdOiAHXcJj6c=;
        b=GtzAR7VOqykuwowQSUC25CSoD8m+rvN8uNuUXpjuhz3uKmaUFuQ3emmgE0zk+rm6GZ
         7o/0RNl9NTi37zGGIjs7L0ag4O3xhLSWx7eVJRhP/Jqa9Wrd10ddHkIHqBrry87HIfff
         AB5tEV2+YfnhZ3VCpIsTy59yAnntoKGpx8fi9GVGRr+rs2R9GTesa/0McjpYwj8ceL67
         319NalwP15R3bwzghAduiSljxeuKCp8iWUB1mA0sJh5pLqqzX0ALEa7kpdvi1Btk+0yQ
         /22UjoFmMFnk+br8AbtxfmweIh/MvHEByRadjC/RXpzC7w67f4xNqMI7d5JhbUYi7sNU
         qzdA==
X-Gm-Message-State: ACrzQf3j0uRGnHo2Tu1OXBKvh45ihs2Ycmvb/b9FEGXdaxEH66cyYbFe
	z4GxjfCUCohzZfEXDI6hBClfwZON0xENBLx+
X-Google-Smtp-Source: 
 AMsMyM7Eo3wv1y88caLC1QTL7cetuSQoQVLfMmarqsZpKjWxyq3FkKUIvQvpjYMgOexD5gQ1gf1/ig==
X-Received: by 2002:a17:90b:3504:b0:202:7253:9b53 with SMTP id
 ls4-20020a17090b350400b0020272539b53mr3612939pjb.155.1664271573485;
        Tue, 27 Sep 2022 02:39:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 lt21-20020a17090b355500b002002f9eb8c4sm984677pjb.12.2022.09.27.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 02:39:33 -0700 (PDT)
Message-ID: <6332c4d5.170a0220.82686.18e6@mx.google.com>
Date: Tue, 27 Sep 2022 02:39:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-lib: 10 runs,
 1 regressions (v5.10.145-cip17)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Sep 2022 09:39:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9552

cip/linux-5.10.y-cip kselftest-lib: 10 runs, 1 regressions (v5.10.145-cip17)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.145-cip17/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.145-cip17
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      93a53e86925ce8c2e0608e173e2c7b952ee61cdd =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6332b87f11985df87dec4ea8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson-g1=
2b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig+kselftest/gcc-10/lab-baylibre/kselftest-lib-meson-g1=
2b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6332b87f11985df8=
7dec4ea9
        failing since 35 days (last pass: v5.10.131-cip13-84-g3b53e4dbd9f41=
, first fail: v5.10.136-cip14) =

 =20

