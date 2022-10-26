Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13624C433FE
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 11:17:23 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web12.6180.1666783040979241074
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 26 Oct 2022 04:17:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=mkVzZg6i;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso1791643pjc.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 26 Oct 2022 04:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KO3WZGG/Hj4hSay0GnUfNvvu2Mq+/lJcB0KSctahzDo=;
        b=mkVzZg6iWbO3+ZvKYWrewsyox1sldHtEL/hW/TSex2zGpE2q2eac3sXkobz9P0JenZ
         vvbeOJwo3aWX6fmaJBoAatmqAQJWwaNAGS2sWYpyzMnhcRmxvCLr08Ur2CqG6Ljdz3h5
         Cokod1kJxOzCsB8d6GcAHGgbQZlpmumksy7KWNMa4KMVoipKYKn8yJrSspc3OTrXE7jH
         dytIJ4HpeI0dH2mSt9xo9hgvJKa4IPOpUyofFfcy2MF/Zs0Vyb3f6HYQqDOkLao/NRpV
         /vjeKoVQtPC2JIo3cB9JJOFW9zET0GqHLfTP748bQAsBaKBcLiJuLupjpG7IiLna8Swl
         TTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KO3WZGG/Hj4hSay0GnUfNvvu2Mq+/lJcB0KSctahzDo=;
        b=O4FRrjZ/BYSIwLIDDsAMTh5XfQyKdzx0RGSvc1Diw4ebYqO7KJtFP1lHcZZneLAkTi
         lihppLLI4fQ0fY+0Du45jsyJAp4ZAucH84Pf/M4H0kI1cKCc4wz11w/rN+OhoheS4ayJ
         5F6ihSbqhlpmAyA4T8zQsvYuiE2KC5DVj69ju3aihDOWaWMyDTkZ5H2nYUAn75kjDwOx
         a65Eb+tFaGMaC7Y2FOeEeh1xDnPsbwnVEq7R8EJfXZDQAZDrggrDxgEEW2eG9MYBZ9LT
         Z0GESIA+yvx33XUlHnJBYyLJ8Lfsi9aa9Pus6Kklep1jDmT16kJkBUH1hD3RASNA/Zgz
         tLDA==
X-Gm-Message-State: ACrzQf1fNVrvhYZMSksngH1oWvvcFftkX9BayF2VIUUmJNSbKMVQ7pbn
	meonFHIu1tQFhvD49wkzqroPW5J9xGNm66JR
X-Google-Smtp-Source: AMsMyM78RXQgyI/PTbfdpW+9qaen0xb9DYa7BIa4cLcpoEU6++jBegDYCjebxczAvzxiYPq57lzRaQ==
X-Received: by 2002:a17:903:2284:b0:178:349b:d21b with SMTP id b4-20020a170903228400b00178349bd21bmr43672442plh.49.1666783040106;
        Wed, 26 Oct 2022 04:17:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 13-20020a630b0d000000b0044e8d66ae05sm2599887pgl.22.2022.10.26.04.17.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 04:17:19 -0700 (PDT)
Message-ID: <6359173f.630a0220.9f5b6.5358@mx.google.com>
Date: Wed, 26 Oct 2022 04:17:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-g7bc9523ecfb7f
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 10
 runs, 3 regressions (v5.10.147-cip18-12-g7bc9523ecfb7f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 11:17:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9860

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 10 runs, =
3 regressions (v5.10.147-cip18-12-g7bc9523ecfb7f)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
                 | regressions
-----------------------------+-------+--------------+----------+-----------=
-----------------+------------
beaglebone-black             | arm   | lab-cip      | gcc-10   | multi_v7_d=
efconfig         | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
                 | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.147-cip18-12-g7bc9523ecfb7f/plan/kselftes=
t-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.147-cip18-12-g7bc9523ecfb7f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7bc9523ecfb7fa7dc71764a249207893ef14174c =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
                 | regressions
-----------------------------+-------+--------------+----------+-----------=
-----------------+------------
beaglebone-black             | arm   | lab-cip      | gcc-10   | multi_v7_d=
efconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/63590bc0f2f31076785e5b3b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/kselftest-filesystems-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/kselftest-filesystems-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/armhf/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63590bc0=
f2f31076785e5b3c
        new failure (last pass: v5.10.147-cip18-56-g87bd4289362be) =

 =



platform                     | arch  | lab          | compiler | defconfig =
                 | regressions
-----------------------------+-------+--------------+----------+-----------=
-----------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/63590943c3b9fdc8e95e5b4c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-filesystems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-filesystems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63590943=
c3b9fdc8e95e5b4d
        failing since 55 days (last pass: v5.10.136-cip14-542-g97767707d3d0=
, first fail: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =



platform                     | arch  | lab          | compiler | defconfig =
                 | regressions
-----------------------------+-------+--------------+----------+-----------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63590bc2f2f31076785e5b42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63590bc2=
f2f31076785e5b43
        new failure (last pass: v5.10.147-cip18-56-g87bd4289362be) =

 =20

