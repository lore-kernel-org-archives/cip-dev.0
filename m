Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34908C48BC0
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 01:39:38 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
 by mx.groups.io with SMTP id smtpd.web10.11057.1707269972297485392
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 17:39:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=wq77+tSe;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.47, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5961a2726aaso60194eaf.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 17:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707269971; x=1707874771; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q182zG2V1l+faktSap2kC7VEVZeqeSi+wUMnqHsHn/I=;
        b=wq77+tSe5Nieh8YFMCndgP1FrjA3b7Bcot13/moEplHwC40e5HkTcUysBJxVL8PhED
         JLmY3pbdZ1BjOdpYWauc+3YFNFJq2bdHsf4GwKTxlBpGZp+xlRg62FMUIv/ADTUtQqik
         ND89CElypTB31jmMAQ8tsi/V0mK2Tq9gtnddBoAGnHh1lXnPjkXEhS/buXYzcUEjIkCI
         lc2oRUFwZ+g4V3bjDBRcjPavwmBorUzB1ppJloz17Z5G4EgOiNMAuyrqvExcOc9toJ7S
         QEdWrTPfV713ZwUFQbnEDHPYOqChvEt5kxI83eQvQ/w+HQE+xKShCZmTsHa4/ZGnZG1a
         DFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707269971; x=1707874771;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q182zG2V1l+faktSap2kC7VEVZeqeSi+wUMnqHsHn/I=;
        b=n3iVE+1UzabRnrbBO5gnwWdZWrDaie3GwgknMrKcq6/eyk8h8k3tuXtvstDffbQ4Qp
         sT6mNQdy7dPwafxw+QM4ls/6PEQPpf6Xvibsjj89rbdiWVvjsXem+vj8ToCy4Q+MEuN/
         gG6jI3qWfVcTbTGXgW3TXT8ZN3Nbldn2TYoOlyXzJLP92uqnWk+zpqVmOUfmu5qCsxXG
         8FX5Fi2vY/gKYMR0JwKEmRVBvt1W47+vl4oC7lKgyyeFH9KNgQeHG/DTaEFVrMgAIhoJ
         Zm+2doItyh3DMchNOPVXY8tfDo/Cc4Lv9yAATPHr9mpUwFCCGh49/WrBUXnRgYC/3Tlw
         H3dA==
X-Gm-Message-State: AOJu0YwqChIGDOcPejC5mZA0S396edcBZ2xIZFXVwkXnlSgaFGx1Ca/b
	95HDiyG2Tu9xrb7Ol1vJUriBRFHPPIA0T681Sk6+LEsVZ67X4DkINXkUJFd1EI/hIMAN2jWJYJI
	Q
X-Google-Smtp-Source: AGHT+IFGW8faaTqI++m3IFxVTRwnFuvy149puBbeEzWagjEz3lEgujOn+R5UYJRpLQZf5U/KjlJIRA==
X-Received: by 2002:a05:6358:1901:b0:178:6363:5c67 with SMTP id w1-20020a056358190100b0017863635c67mr1209026rwm.21.1707269970794;
        Tue, 06 Feb 2024 17:39:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxXmqURycZWZlQqqLvNHupwfSi0juSS/SnhsrVcBr69NHK6hX2DvvWHcjKKr0UbqyEHM7LNjStPeVdWw3+2n0lVYneJSDYHHglai2K8xLpEQW/XYj6dO/20+kiDJMHhU+OIGdZ2LW6AZd4ElVYfnTW1g==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bz3-20020a056a02060300b005d66caee3d0sm119524pgb.22.2024.02.06.17.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 17:39:29 -0800 (PST)
Message-ID: <65c2df51.050a0220.f0ba4.0680@mx.google.com>
Date: Tue, 06 Feb 2024 17:39:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.209-cip44-50-ga624abaa85d7
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 2 runs,
 2 regressions (v5.10.209-cip44-50-ga624abaa85d7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 01:39:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14852

cip/linux-5.10.y-cip kselftest-seccomp: 2 runs, 2 regressions (v5.10.209-ci=
p44-50-ga624abaa85d7)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-50-ga624abaa85d7/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-50-ga624abaa85d7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a624abaa85d7f3ff289eb2e257db5c4485d11d18 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d42c56867394d88e1f60

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselft=
est-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselft=
est-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65c2d42c5686=
7394d88e1f61
        new failure (last pass: v5.10.209-cip44) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d282f1978ee0068e1f61

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65c2d282f197=
8ee0068e1f62
        failing since 125 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =20

