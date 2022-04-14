X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.6730.1649901150849444064
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Apr 2022 18:52:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=UTdySY6G;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id l127so1813961pfl.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Apr 2022 18:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=kcvjDLFyb+VkhdZCTdTHtKy4yUQi+IItDaXGZ2ocRQU=;
        b=UTdySY6GpHklOT/qQmjN3LHCQ3lJ3mAyjNlM2DwFiG3V5A5YPlZBU80Gr3WjcoiA85
         o/kA+M9oN2nzALwxI/xpV46auNRkZDd/aaqrosRziKfDY4bvt5p4VtQaLA3x9Bwx3LrU
         d61VpBirhKIwXk+DguVXGvFfILmQUkyfGoIzL0QINbx6k0D0KuCs+yY23y4BgKi0F2d6
         8E4qV1C2yiYHDmlWBJJlHrUwzlt2GW7SVAEB6vAQYCVMrP92A5PH5PqCnt6SCrMaw9bI
         o7qW2jKcIbWAbX/sDJ3NdkkhuceoL14NMu38Chh7YArU4O6nYg/+NZX05QnD7sGJ6WiI
         QMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=kcvjDLFyb+VkhdZCTdTHtKy4yUQi+IItDaXGZ2ocRQU=;
        b=Gf9mteoFQ+lBhxqqLy+tZKDoLC2JPxQVe2CpT6wrYz5lpg8x8Ryq70enAAX3EBRfBO
         +r8ToSNChhZhuz+CdPvPv+yRy84F63MbEDv4UUmW2yU5BEj+iSIrEN2i3eH7qA3sjOGS
         zGaUR8PtebYNg9tJ3M6nw6Kw/TZ5on320WewX18HXNk1kiHabcRMyVnGGfnINlqBV4NK
         umOK8nuy9LSV7phVegxmt731xf8cP6UDuvEnlPhkqOlhfol2xVwVybkBmuHqYCQJ8dAh
         ZZ82rAHs0pb4TSBCPiiDeUBc6aq2QbjxBSJpECTXO0aEyhKcS23r9T3kQByRZqn6WJya
         vjkg==
X-Gm-Message-State: AOAM532EurtLtrkT+MCUAg2zyd84/rqFW0eez+oSxmaluyB2h2+2wiQO
	mejjk3TTb+WBAL+KLXRVvJyLq9ux8Z80lzod
X-Google-Smtp-Source: ABdhPJzJjrfhiQiFMIDAt8ygdl3hoNZcRJhG2efcpdYfu/CZdWWr6BzL/TS8NBRwePhBnQ8uK31F7A==
X-Received: by 2002:a63:5520:0:b0:399:8cd:5f62 with SMTP id j32-20020a635520000000b0039908cd5f62mr413530pgb.12.1649901150129;
        Wed, 13 Apr 2022 18:52:30 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a11-20020a63cd4b000000b00378b9167493sm356169pgj.52.2022.04.13.18.52.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:52:29 -0700 (PDT)
Message-ID: <62577e5d.1c69fb81.23121.172d@mx.google.com>
Date: Wed, 13 Apr 2022 18:52:29 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.109-cip5-770-g2801336f0f208
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 4 runs, 1 regressions (v5.10.109-cip5-770-g2801336f0f208) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 4 runs, 1 regressions (v5.1=
0.109-cip5-770-g2801336f0f208)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-770-g2801336f0f208/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-770-g2801336f0f208
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2801336f0f2089b0d935efe67d93eccaa85e4bec =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/625771ce5b8b417d36ae0680

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-770-g2801336f0f208/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/smc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-770-g2801336f0f208/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/smc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220401.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/625771ce5b8b417d36ae0681
        new failure (last pass: v5.10.106-cip4-757-gd8c01ae8a4bc9) =

 =20

