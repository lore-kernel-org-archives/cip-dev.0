Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15D3C43334
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 12:51:15 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web12.5968.1657889473928165809
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 15 Jul 2022 05:51:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Ua9CYDsC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id y9so4566760pff.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 15 Jul 2022 05:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=uWj3vrm+eRyU+g0XmL2PHbD6cckx0vjPtjwr7TGyC04=;
        b=Ua9CYDsCkmY3L/d2kA3Q9fSWjPWjD7EOT9wwVXdKPKOp3RsrgX3XddEzovmDGRXhh9
         4UcL+0OQEVSALnw3+sOBAN9G3Qu2LSUes9OWyoHVdDRErmJ61KzILRLB9OWucEeE4bqI
         ghp7HwoDKn8/NzdCWNoNuuWLI8OOt25w0ibx20KNF/w5ijzYlGjdWzdsHgh9hMr0rgFk
         Fji/cHoc73Yu6jOhFzNmkBaeBp/pQlxTz+QsqllQULriXqy3/Z6vFhcLrEEtpwxvL4Fl
         Og3GZRVpDx/cwcdYUmsczV5OwdI9Dw3XIFDaO4Gf93gTqPfPLgOlbvIvVIn3maUS9YAY
         pRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=uWj3vrm+eRyU+g0XmL2PHbD6cckx0vjPtjwr7TGyC04=;
        b=q4kE5UgH2NN342GNwWdynNxJaXLf2HrLjMJ8CWGYSrlySSos7E6ynd/MrMby1p/Hio
         qJvJ/YMI5beaeML3zGdO1qTyUTKaOWKgg4wms+nGiwCmeOpue48pqetmjWyVkOR0aPLE
         VS8rOUC1L2/k6HGffoKPdONYeo2e3tAseM6/C9JhxcnvTxm0w3UeWAYYUfYVmevbQxxA
         5DlUobl1VtrTppck3Fdo1rhCeLraG+oOb+reHAme5r6zauub1dplis0HYKaA8+1IbdAQ
         NWjxrqbbGt7Bvy97pyfNwKrlCu0pj+hh6eOsLT7+OYb5Dh7YCw9409p7YLGvUYDwppHY
         typA==
X-Gm-Message-State: AJIora/nRpnHNlEkjfeyBJkaNJORXlVIoA+nIjreg4rtfLon6ZGcTM7Z
	/hWRX3QpIV87NRUgoXo8yUibEgfIhgQFRG9f
X-Google-Smtp-Source: 
 AGRyM1t9S352s2Mk/xkL0kc4yqv9E72/UAuvfE0iobzKqa/4OLAgIcfD2mHbYPEhjGXNKEFQhTbOnA==
X-Received: by 2002:a63:ae03:0:b0:408:b78c:e284 with SMTP id
 q3-20020a63ae03000000b00408b78ce284mr12054627pgf.401.1657889473078;
        Fri, 15 Jul 2022 05:51:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 y9-20020a17090a600900b001f07ce88696sm3396732pji.49.2022.07.15.05.51.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 05:51:12 -0700 (PDT)
Message-ID: <62d162c0.1c69fb81.f9d04.53dc@mx.google.com>
Date: Fri, 15 Jul 2022 05:51:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-59-ge5b19636ca9c4
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 3 runs,
 2 regressions (v5.10.129-cip12-59-ge5b19636ca9c4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 12:51:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8831

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 3 runs, 2 regre=
ssions (v5.10.129-cip12-59-ge5b19636ca9c4)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.129-cip12-59-ge5b19636ca9c4/plan/kselftes=
t-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.129-cip12-59-ge5b19636ca9c4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e5b19636ca9c43e262a365d756d491479adb3884 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/62d1523f325257abcea39bf0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220708.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62d1523f325257=
abcea39bf1
        failing since 12 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-118-gb03e159be974) =

 =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/62d154b6254cdb8373a39bd6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220708.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62d154b6254cdb=
8373a39bd7
        new failure (last pass: v5.10.126-cip11-116-gef362fbbff528) =

 =20

