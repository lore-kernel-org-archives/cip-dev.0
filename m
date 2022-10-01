Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B788FC4332F
	for <webhook@archiver.kernel.org>; Sat,  1 Oct 2022 20:31:58 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web08.1441.1664656313072514848
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 01 Oct 2022 13:31:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=ERbQaAJg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id f140so1809478pfa.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 01 Oct 2022 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=ap2qnpzoauGjJU0S7om0a9M+RzVLA50a7XSm/OaK6A4=;
        b=ERbQaAJg0bIfrNzO3ZZD2Dtu0vehxihmC8uo5cf0V7tJNHtddNasRMvnRFv4G6ysaZ
         ucoumqzXsWu0OUy14qvUGKEDQ1i3ujz41CnEN8cG/vlUlmfMY4+WVeiNmxfeaXrevWTt
         EZ6vyNUEhG7PSEYTBpTDp88+Z0t2WrIGUFo2fMKWBKNMsvqyGQP5VbYcKaFSq/QquDXi
         ik8BB5FiG5o1WN0UI+kyZdcUrYjRNQCuumgjzi/NxKFqvBlfACQI2oRBAvGEsMbU/EtS
         yzSWDCHVU1wYOoLe+xhNei3DFKZ1KILym1tueo9DvJqfI0DwG8KZwZAJ9LKuS/iTK/Cf
         9FQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=ap2qnpzoauGjJU0S7om0a9M+RzVLA50a7XSm/OaK6A4=;
        b=hinDM4Q3HBvAj6pfruJFDsRYx6z9yE+I4LAZ/DCvQOxDb9/OAyjNrgSwJygXVDUXN+
         UeQR5BhTH208nh+ygb33uxjGAu1wcXEVbUNa3VWRN9U+QKfmvlRwtU1/VsQiHn5D0Q1i
         zBh+F7OQwy9LViWPpaIPiQhnfZmC3ieRTNC+LA7oxV73xt12CKMkQL6PZQdygxZyZpD9
         PPiOVWjxKUfbjaiqXAz/0q7YV7OjmZ0u5i+cyDvjILSyrMQnhOxHILkNyj47pQEDzDQd
         kkrZ6FyT55svCdy5V5mrMw8aV9NIWQbz96UYvQS9f1t6iZYtgrIE9EbklFiFcEzseR+Y
         s4Sw==
X-Gm-Message-State: ACrzQf1uFEHFQtZ9jNkGNYhSd7pyIyn1JS9GRIcJXzxKT6dF/e/CT5MC
	qI4pHhv1m6OeT0AhIVqTJp/T0nO+pqh9UHaC1hc=
X-Google-Smtp-Source: 
 AMsMyM5VeGkX6RNmJ58HbCojSpdMKWIiWP6M5eg9fW6eTK6AFsB7/IQeIauLljfoyYcI8UX2iCsHow==
X-Received: by 2002:a63:5c1c:0:b0:43c:9152:e5ed with SMTP id
 q28-20020a635c1c000000b0043c9152e5edmr12819939pgb.106.1664656312329;
        Sat, 01 Oct 2022 13:31:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 b15-20020a170903228f00b00176acd80f69sm4319943plh.102.2022.10.01.13.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 13:31:51 -0700 (PDT)
Message-ID: <6338a3b7.170a0220.9cfc4.761e@mx.google.com>
Date: Sat, 01 Oct 2022 13:31:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17-rt7
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip-rt kselftest-futex: 3 runs,
 1 regressions (v5.10.145-cip17-rt7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Oct 2022 20:31:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9609

cip/linux-5.10.y-cip-rt kselftest-futex: 3 runs, 1 regressions (v5.10.145-c=
ip17-rt7)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.145-cip17-rt7/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.145-cip17-rt7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      411cd76b5afe81569858976d0e9819ab48717fcb =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6338990d9fddcf7a7dec4eaa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
145-cip17-rt7/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-meson-g12=
b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
145-cip17-rt7/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-meson-g12=
b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6338990d9fddcf=
7a7dec4eab
        new failure (last pass: v5.10.109-cip5-rt4) =

 =20

