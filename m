Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1670BEB64D9
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 13:50:56 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.12429.1686750654086239731
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 06:50:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=OUbtzQ0h;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b4f95833c7so4914255ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686750653; x=1689342653;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o1pSohV7uAUG5JIqdk/kTLc8S8oCgrwOiSIiLVfTIw0=;
        b=OUbtzQ0hKEoTlgBcwWmKdS9v1Z0hKw1yKFdOX7K29gj+TpCUgaCZS8gvnjgwJyu9L8
         ZgD8VPyPNEpkDI9aTzO42/+rhRDPATOJTvejgGGBfTvVKoSrC1vnXztws7R9VIPUkJQr
         gLJC16FdmaRFWk7+YUkJWDodZuH4zl1gUqli15bAZGoWgGjVbGQ20Mp3tCVmWRdsbCfo
         nGw22v+MTXZKrEO21wHJBMjWy831kw/9yEDE/h0scWafnvg51qQHQ7KP19ztruTQYHNj
         rw3s4XMMQiwmX2nrP19v2jILcuQ4UnwqefrYCx9+dupUIG8+LzqNCqem9wOU5UEZpdmD
         qu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750653; x=1689342653;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1pSohV7uAUG5JIqdk/kTLc8S8oCgrwOiSIiLVfTIw0=;
        b=UXF3GiFHhxQvjnUh0jWXhuuc/Dkp33LYnILLhxOFU00L23MJ7PPNsk5n29Xj3Tbker
         i9HL6jJ8CsknI0d6Xsxys7ghI18olegu0B4sY+Y2OZUH2V3WWa/9iL0zZcYHeKoDr45j
         hVhYptXE1pwvSzTNjUU1E5ec12ygpavX0y9ppqB9FzXK+00L/+/2yrUvSzNkOwJRuFI7
         UKHvOD/wwMt3TnI+bTCP5vAGYg/njnBRFwSzi4Yo8o8bpFQz5kh+kZmb0ULApV5dzcnc
         eb7yFRK1C9Wa31Kz94CV0Nx+xaEPCtue0oAg57xZQH5vtwU2Xt9Kr6eHxzOMxTOEBod7
         i4KQ==
X-Gm-Message-State: AC+VfDxC4JcJDgylbDaczOGwg47smu1w/aWRfszIcgRr29nZSRzB12fq
	WzHq/trnxNd73k1bM4IQXrT4w+ZZkSGcwynS8TZFKQ==
X-Google-Smtp-Source: ACHHUZ4EjiDP5XiaRRq2eN3pEI57j6Jz05rHh1z+tUloYdq+tGiF73fH6kACip3gvJuiLGbxsD7o0g==
X-Received: by 2002:a17:903:2446:b0:1ad:fa2e:17f8 with SMTP id l6-20020a170903244600b001adfa2e17f8mr13149958pls.12.1686750652856;
        Wed, 14 Jun 2023 06:50:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b20-20020a170902d31400b001b414fae374sm1905354plc.291.2023.06.14.06.50.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:50:52 -0700 (PDT)
Message-ID: <6489c5bc.170a0220.bccbf.3d2a@mx.google.com>
Date: Wed, 14 Jun 2023 06:50:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-g2391124f19a70
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 7 runs,
 2 regressions (v5.10.182-cip35-8-g2391124f19a70)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 13:50:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12034

cip-gitlab/ci/pavel/linux-test kselftest-futex: 7 runs, 2 regressions (v5.1=
0.182-cip35-8-g2391124f19a70)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
beaglebone-black | arm   | lab-cip       | gcc-10   | multi_v7_defconfig   =
      | 1          =

mt8173-elm-hana  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.182-cip35-8-g2391124f19a70/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.182-cip35-8-g2391124f19a70
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2391124f19a7085376080a6a95b6e45ff525076a =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
beaglebone-black | arm   | lab-cip       | gcc-10   | multi_v7_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/6489c1f54ea0ecf29b30612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/multi_v7_defconfig/gcc-10/lab-cip/kse=
lftest-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm/multi_v7_defconfig/gcc-10/lab-cip/kse=
lftest-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6489c1f54ea0ec=
f29b30612f
        new failure (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e9) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
mt8173-elm-hana  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b7daacc6e8326930614b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.182-cip35-8-g2391124f19a70/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6489b7daacc6e8=
326930614c
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =20

