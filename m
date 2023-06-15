Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0EDEB64DB
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 10:38:10 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.14937.1686825481876142536
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 15 Jun 2023 03:38:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=j5SikG14;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-25e8b2931f2so656969a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 15 Jun 2023 03:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686825481; x=1689417481;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MI7e23tfYRbZRLrqovOq+s0kEfB5xdDUhSc8Lwo+lHE=;
        b=j5SikG14T2pBC+a27HIZnoJloYLHPGh1z/EDfP1q2DI+rnGs16kYeht2f24wUGodtm
         QxCRp2C62CuOAO9q07nNC/I6uH8Eg2MY4yCIC6QbObYfR1seIjPXoJgLMzUxvKy84e6s
         DMkOmhHGcjlvpINQZWY/1fir4FFmld04jqiYz74AgXvfvnTf1SUXso0+36FM2pzyu6fs
         aTp2dDo3b8gKlcKKMiQx9obBJY7wzxPtmJQHzO8ALlh2/RKrYWxTHV2QqSF3EXBt1rsZ
         r5qtLI/JEwDEpki2N0uzTumI+XD95rY7VzGNIM0v8+64O+tio+RMFKEOnIHOUbYRLJ5f
         v2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686825481; x=1689417481;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MI7e23tfYRbZRLrqovOq+s0kEfB5xdDUhSc8Lwo+lHE=;
        b=ia/gcUtFdMV/vVG4/LVtypuQfvX5/wggjoKoCY4Mxuh/rP+UGs+vivKWvOwAxdV5Du
         pgcRez1RGPMLHhSxR6kEv21WFXQjUDGS06E8+1QZH54m7yX89svzGiHavN866Owe7tOt
         GWaMED5qg/bjx65yIXH9efVl2w+srkc1zvksdYNYeiLWvw8zW5+f0YD+b5oBIcI+3z6I
         8Q0lE41YnhMvh71thiELuQ+WDl1uYjSf0blr0BpgVe2ISZILdzPTdejqFXiaXsBHkfmP
         4CmcJqNZQym2MywQ6EWXOPWCSEbABaxf3fLfLp3zlKhklJ3Pf0PCW0vQGTY5fdMsgBR4
         h9uA==
X-Gm-Message-State: AC+VfDz/fuhAvPZCtal1Mkc9Hho/fpCCnMtDMQSHrEzIw7GyED1Jljju
	TxBeame6aVhvO7Y5JViZ6MyB+btJQw474TL1Ws+Wuw==
X-Google-Smtp-Source: ACHHUZ6PA74qmbfEY/Ylw5bZdoOBdybQU0dAU8yghI/gBRFSnQVSx7QL94Bal+OlPjxVcT9Nwaow4w==
X-Received: by 2002:a17:90a:7e94:b0:25b:ba0c:ab7c with SMTP id j20-20020a17090a7e9400b0025bba0cab7cmr3507417pjl.27.1686825480716;
        Thu, 15 Jun 2023 03:38:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a031c00b0025c02ef91f6sm5806069pje.22.2023.06.15.03.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:37:59 -0700 (PDT)
Message-ID: <648aea07.170a0220.7200f.c416@mx.google.com>
Date: Thu, 15 Jun 2023 03:37:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-gdba81ae6f2be
Subject: cip/linux-5.10.y-cip kselftest-futex: 12 runs,
 3 regressions (v5.10.182-cip35-8-gdba81ae6f2be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 10:38:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12049

cip/linux-5.10.y-cip kselftest-futex: 12 runs, 3 regressions (v5.10.182-cip=
35-8-gdba81ae6f2be)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
                | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35-8-gdba81ae6f2be/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35-8-gdba81ae6f2be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dba81ae6f2be7f7d87f3a29a8566758d2e0017ae =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad88e7d366b285b30613e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex-m=
eson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex-m=
eson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/648ad88e7d366b=
285b30613f
        new failure (last pass: v5.10.182-cip35-1-g7cde3fba93966) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648adfe483f40919c4306137

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
kselftest-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
kselftest-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/648adfe483f409=
19c4306138
        failing since 0 day (last pass: v5.10.180-cip34-26-g462b2292d23e6, =
first fail: v5.10.182-cip35-1-g7cde3fba93966) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648ae2533ad504dc4f30615c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ksel=
ftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ksel=
ftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/648ae2533ad504=
dc4f30615d
        new failure (last pass: v5.10.182-cip35-1-g7cde3fba93966) =

 =20

