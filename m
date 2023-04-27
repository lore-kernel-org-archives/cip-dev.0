Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3211FC77B61
	for <webhook@archiver.kernel.org>; Thu, 27 Apr 2023 10:18:32 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.16722.1682590702487617772
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 27 Apr 2023 03:18:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Fesq5EVm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1a9253d4551so64604345ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 27 Apr 2023 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682590701; x=1685182701;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H7i0tLYedjBWK4O2rEcLZ1sMnHdj++v03iCBvL6x7Dw=;
        b=Fesq5EVmca66PfVa4IxywDEGZUa+/7e252qXNpo9yY7E+RRvz4OrGifSCRexEfAe3d
         857BZrLGMXrSPkGW1Ipeum5VaGEUJYmABEDcxQMhv6BHcri7ImPflLYgUsydj1Msn6dq
         4+0IbcOY1gJbILK9W+i7Mc5GPZAN0FBc0/dNsfCmW1y7d0AfSKGMJdErhHHfg1f21jlH
         JYCmIerTLJ2v5dDFozZxxodbPkkc+pIONbenIT5l0vTWeYvLRxckJpen85qoUEpiP9wj
         XoyW+2qpnjrV9bfO9fkYnMLRxY/xoLjBGnw6usb0H6R9qYQOzbW03bhs1wGdhF13TzsY
         9/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682590701; x=1685182701;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7i0tLYedjBWK4O2rEcLZ1sMnHdj++v03iCBvL6x7Dw=;
        b=iW2MYFNfpi+C0tC1pKgvAG+qUY2bZ+A4pR2Ek86Sh4ymk8LaKIPd3IYENVdEwIA0IJ
         uyp5zopjRmlLXRUo2Dd3eJs/mngTTzB2ulgsyFi36wNFQNi4zrPyKwNv6wGH8iZy4ZTH
         FcNgKSBXm0eSNwnppBSE8hCFcmPWsRDsJiVQ96L9lSLxQqiS073KQ2rYN7Itu0NewGJx
         O7FVOVGFddiPQ7wEgduhy2ATNotH9dYQUJmguBE5adFRoxpGrvlG4jXTseuEV6z07KkS
         UZ5bHG2FXHPJRSyneeLi6fR7+C1nm9I1oOYHHDxSmDRAUKvI60qf9m1gtiRdSD9NHL5u
         qvkA==
X-Gm-Message-State: AC+VfDzuM4hzjJd/oqpVx8pezlr7unMfL8TOVYn+6i458b+wVP41348P
	zhVfpk13eVeCAABExo+zRIRxmhcoCFBi/pDu0Y4cMw==
X-Google-Smtp-Source: ACHHUZ6Y5gacnGZOfIOI/QuYlLUTY6d3sMECcTwowcJlbOa+8LRd/qapVMGg9pHB394S6X0Jolo6hw==
X-Received: by 2002:a17:902:d482:b0:1a6:ee5a:7208 with SMTP id c2-20020a170902d48200b001a6ee5a7208mr1247110plg.18.1682590699872;
        Thu, 27 Apr 2023 03:18:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001a640f9ebb9sm11364507plw.21.2023.04.27.03.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 03:18:19 -0700 (PDT)
Message-ID: <644a4beb.170a0220.953cf.789f@mx.google.com>
Date: Thu, 27 Apr 2023 03:18:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1186-g2516b357b2e3a
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc kselftest-futex: 4 runs,
 1 regressions (v4.4-st20-1186-g2516b357b2e3a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Apr 2023 10:18:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11364

cip/linux-4.4.y-st-rc kselftest-futex: 4 runs, 1 regressions (v4.4-st20-118=
6-g2516b357b2e3a)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1186-g2516b357b2e3a/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1186-g2516b357b2e3a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2516b357b2e3a612ef2904362b0acbb97746d0a1 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a3c28fff711840f2e8610

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-g2516b357b2e3a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-g2516b357b2e3a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230414.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/644a3c28fff711=
840f2e8611
        failing since 99 days (last pass: v4.4-st20-799-g1229c813bcd9, firs=
t fail: v4.4-st20-821-g39bdf0444b23) =

 =20

