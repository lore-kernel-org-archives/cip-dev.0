Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A29EB64D7
	for <webhook@archiver.kernel.org>; Wed, 21 Jun 2023 20:03:29 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.98.1687377808754158968
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Jun 2023 13:03:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=IDmgiBBp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-668689ce13fso2516300b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Jun 2023 13:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687377807; x=1689969807;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sGKM93wQw0QkjlEONap0TYxMdgXsn4Yx8xRgGDZX3H0=;
        b=IDmgiBBpwB2Sg1cxjNpUaYLR57a16Z4wFRGrlbggAAbSRD3Iw9DEXMUPcPsAXt9jZu
         B9NvDUg1esDCxShdkPQjXJtoLjEYc3D5vlK+7c0XxEnWSgyVBaxpfw4NK2bC4AQSPZJ0
         jlPvXFWXEYcQDDJxfTfiqy0GckLZRAwq2zw9NOMIjM3/+ZLS8hUuBRzouQZPJM4Kzwzn
         u6vccTbK9P3PRNVPqNw++nb/PKeYy0p/aE+okaxZtO4shwBkvvLb+tA5UZOXmboA3yhb
         oeRfGkTcgWSLUji8JKN3qsMBkp7YS0mpLBq+pEPZz3hNAW/cq1bBZJMOhJ9kkgUwPw/X
         A1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687377807; x=1689969807;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGKM93wQw0QkjlEONap0TYxMdgXsn4Yx8xRgGDZX3H0=;
        b=L12h6HUDAFQgXyM+wDzbAWJ/3GY/fK0svUMGYbZ971FyCRqR4n1gO2+gxAeish7L3K
         qQvHoVy6GdpfbWqdm8lTcyf8tfpdYeoynGVUpX7bCE89hWkYCL1TkTJ5L6WcyiA/6ffq
         RFC/F9oHMVyG4jHckaieGWQg1+1TAJ4Izj4nTL9USv1Nc0o4DHfBfinYzvxV3JEH8Xyb
         4ISaGkI2QUnSab8lXa2A0XKOUfQ9kJ4sExgi5YI5WgsVDvP9Mk3+X8z6CMvqlAZmboXA
         911nPBOb7hS1d02AFf3GwduW9o9LG6i/3YTrTaVpHMFPEXQssn/haWlYtZhdAP+aC6in
         7SMQ==
X-Gm-Message-State: AC+VfDxc77F82vIf0r166Xn+sKaw6ccPwc0gqSYcEHhwAnJZ+Jz9T1Vn
	Gv+GUWPjmc8Y2ycnf5iTo6gRFkjGPaS5uhmYpyXKCg==
X-Google-Smtp-Source: ACHHUZ4E/kqTuJrUwbj6mA/+L22RjfJuZf8bhqnVW1DOx9dKRRdMDfxpdTCSrWeVwKXBDrNjsqFJVA==
X-Received: by 2002:a05:6a00:1309:b0:662:2b1c:be80 with SMTP id j9-20020a056a00130900b006622b1cbe80mr11315867pfu.28.1687377807218;
        Wed, 21 Jun 2023 13:03:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i14-20020aa78b4e000000b0065446092699sm3337747pfd.141.2023.06.21.13.03.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:03:26 -0700 (PDT)
Message-ID: <6493578e.a70a0220.b503.833e@mx.google.com>
Date: Wed, 21 Jun 2023 13:03:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-289-g3c0549540706
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 9 runs,
 1 regressions (v5.10.182-cip35-289-g3c0549540706)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jun 2023 20:03:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12097

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 9 runs, 1 regre=
ssions (v5.10.182-cip35-289-g3c0549540706)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-289-g3c0549540706/plan/kselftes=
t-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-289-g3c0549540706
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3c0549540706be602c1cc58f7ebdcae39509baa7 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/649347037abaac382c306144

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm64/defconfig/gcc-10/lab-b=
roonie/kselftest-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm64/defconfig/gcc-10/lab-b=
roonie/kselftest-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/649347037abaac=
382c306145
        new failure (last pass: v5.10.182-cip35-191-gf4efde512959) =

 =20

