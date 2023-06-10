Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BB0C7EE2E
	for <webhook@archiver.kernel.org>; Sat, 10 Jun 2023 11:24:59 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.15726.1686396289806824805
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 10 Jun 2023 04:24:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=QmfM1O+N;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1b0314f057cso13966355ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 10 Jun 2023 04:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686396289; x=1688988289;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Os1tjE0EcIpjwszBCDjECLaorutjGtOGPV4dOC9LJaY=;
        b=QmfM1O+N6wHq8xcnNicu/fjFgsA45ipW3s1OtOLDxT1qzoE4EMVhF2uIpdssZCay1C
         Gk26zOBvq2LT6AygMT57rbYtcRlndAKXpU/q8w4xAzV1CZ3opR9Q5Ew3W23FE0P+GyT5
         gr29n3hqIXnwyLOgqzlW53JotMzIZsci/8/rUby3gydvlEd4CAy3v5SLPiTq82VP+Zk1
         XqoLElACT03pd6B4jhW9JrauFMpdmRJjJlRp7e1l/+8DW3xQnkaKhecfxbTxmJSQebvc
         bx6ocaMKpgwCC9ddB7MnPqN9vBmMMeNXS4Cwswfzyx6XrMGsuDSlfrU8UBeYj8q9/l2r
         QngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686396289; x=1688988289;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Os1tjE0EcIpjwszBCDjECLaorutjGtOGPV4dOC9LJaY=;
        b=SDL63h867TGeaaVmM5HBZy3VA8Fdc3lq2nxDyu6JDpAbfmwksiKbOqz+XrmvrzUJzH
         +ej1D6O61mprx2ifioVCbPlF6WZwQ1W3W+HTTA2V2jyadQT3JVEBF2KiRfKeuPGc391p
         afFQB54czy0MklDcBxm8RnBWRiGIO3IKADP+C9AOrk6t+4WALYx99kXhH43FqFTuQP63
         3hpw4LmxU/LJOIoWfQ0fpnU8+rJi0X9T25NGnpHYS3qk8nm5DzMZbbCn7vpK6M8qgbbH
         oyXiiZ2NXUOYeM09wTxtU+PRLQMjIW87HnJQmC7lJw7lO2M9eVk715VZQZH+/pSKcCJi
         A5hg==
X-Gm-Message-State: AC+VfDymnbcMJebjRnfAGFtRvOvzqcYmNpc811HxJKYhslxZqaYdiCAZ
	LlxXqhFw0Wuh7S01cElWph0aRNIZBc6yqHNm2PHiAw==
X-Google-Smtp-Source: ACHHUZ5iJSRyP24vyyIFhKTIcvPn8tOeHuhxuB8SnmaS+RO573TnBUlwBhChPHKveFIzJ7pllT67Aw==
X-Received: by 2002:a17:903:294c:b0:1af:e2e2:2bd9 with SMTP id li12-20020a170903294c00b001afe2e22bd9mr1205589plb.17.1686396288702;
        Sat, 10 Jun 2023 04:24:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903244500b001afd821c057sm4788656pls.58.2023.06.10.04.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 04:24:47 -0700 (PDT)
Message-ID: <64845d7f.170a0220.4569e.9cf7@mx.google.com>
Date: Sat, 10 Jun 2023 04:24:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-45-gce658d9231044
Subject: cip/linux-6.1.y-cip kselftest-futex: 8 runs,
 1 regressions (v6.1.31-45-gce658d9231044)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Jun 2023 11:24:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11966

cip/linux-6.1.y-cip kselftest-futex: 8 runs, 1 regressions (v6.1.31-45-gce6=
58d9231044)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.31-45-gce658d9231044/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.31-45-gce658d9231044
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      ce658d9231044091c42896a08fbbfad40ebc58ce =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64844c776965b4c891306166

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-45=
-gce658d9231044/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/kselfte=
st-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-45=
-gce658d9231044/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/kselfte=
st-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/64844c776965b4=
c891306167
        new failure (last pass: v6.1.26-1320-gc38e4a9845945) =

 =20

