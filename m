Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C72C46467
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 16:35:34 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.20399.1674059725489225624
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 08:35:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=BJ1JO77w;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id p24so37402998plw.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 08:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oJwYPZ/Q02RGevS+RqwYXIdDw/lRHplkGWGr4AXhv+A=;
        b=BJ1JO77wgHXJuaK+kRGKIvc4B7iQQrqV4YZLoZqjDY6vCiH4vwEYIgBCPtN+5Iz/k9
         tlAsOf0M4J2+01UV6nvXlAytcfOTBpQ1/bjnhm7sfPvg0DYQQRCT95s3dmT6clqCWLDB
         sKlWeqpfyl/gY+45fZ09EKlPILk1nAN8mXJo6vSL6uNv+pr2dTXYU8fKvSL7KV8zicPL
         6bYFtEzQPOnOOLoiI2pu7dBYknolHLT3ABgwarL6fzvp7e0VeXdzNFLdBIw+XuXMhl0w
         8NZGGPU6IMSX4hqZuKAz5uFNRaUu5SYWxFE2LLeR4rhpfp4EOtApva0EFnv4EUJBg+zZ
         NXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJwYPZ/Q02RGevS+RqwYXIdDw/lRHplkGWGr4AXhv+A=;
        b=mwkNJ12IQPl3MeDdEZ++bV4Ibn/J5xBDRjmSImZJC1i9QqSwllR1chDxX4HA32aa1+
         tgXRxZlWmN+iCyYPQq9XXpqtoPWXM0w1wK4g7vc3AGylk548Ms7bZOtaQFDxGeuJ/NY0
         VhtUTxkcSfA91JRrLof6jT38zvix2XPRJBWb0Zlb3rBLShCu0YNgZaKPp8+WG5beSWiQ
         C+uwrkKbTGbTWTMUK+wy3Nslj3y2qExJ4yUg/1qGNc28YcEegnPExApR4dYlhmpBy69H
         /VhB5vJmpVlG8zIckkU8dbmB7mOSa05MeUEC645xX5EaHAPCAnoNnzpYiYgDqht/1Vq9
         5Ivw==
X-Gm-Message-State: AFqh2koHfTZnz2ZhvCa8y6VFcIVkE//0xAYWORuPMAFhJOjU3FEqYluY
	ZYfbYIC13ylmhnEgR6tu8CtpmafYLLaqM0CL61Q+Iw==
X-Google-Smtp-Source: AMrXdXvBLWccyeft/bXZBbnlCuR5pLT1f4Wke0teumYZIuGXm5A64Id0WExOtm3xkiNC2aZeg4gdjA==
X-Received: by 2002:a17:902:eb88:b0:194:6921:d36a with SMTP id q8-20020a170902eb8800b001946921d36amr22493982plg.22.1674059724403;
        Wed, 18 Jan 2023 08:35:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902a3c800b0017f74cab9eesm18650390plb.128.2023.01.18.08.35.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:35:24 -0800 (PST)
Message-ID: <63c81fcc.170a0220.93708.e07e@mx.google.com>
Date: Wed, 18 Jan 2023 08:35:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.162-cip24-853-g709bb3738fde
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 5
 runs, 1 regressions (v5.10.162-cip24-853-g709bb3738fde)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 16:35:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10392

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 5 runs, 1=
 regressions (v5.10.162-cip24-853-g709bb3738fde)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.162-cip24-853-g709bb3738fde/plan/kselftes=
t-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.162-cip24-853-g709bb3738fde
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      709bb3738fde9ab95ab1303d161730f508a6659e =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/63c80ccc36ad63059a915ed2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-filesystems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-filesystems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230114.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63c80ccc=
36ad63059a915ed3
        failing since 139 days (last pass: v5.10.136-cip14-542-g97767707d3d=
0, first fail: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =20

