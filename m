Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE566CD80B5
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 11:37:17 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.web11.88776.1696937831456507703
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 04:37:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=HqZwSinX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.177, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3af8b498d30so3214575b6e.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 04:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696937830; x=1697542630; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WbIuWSCuE4Wag7UGodOLccR3TPXHaYmrWDfYpjzR6bU=;
        b=HqZwSinXeFpj6iNJfCFGSwA7tT9F6QuX+AKQWIZuDBsDxNi6gQ6EIU57pQW05QdgDj
         aVywB9f7qvzp49bI0sLUAL8B/IPTbnLlCyw13TyTkP5Sn07zomH6W02bKLBN8lvkBIOu
         JzlwGd4fP3ASY08jFeY7raq++XH3lMZ6D6GbxJSJH81smusOswcAC2k6fE+uxbOFbZQc
         aI5D33bI9kB93kf+glb1qBu5i6zvNmwxNErpzohPwx38Yvwr0NlrCamuvhqjosE4yBNx
         BvpjF8K37Er2EnGj3Kq/YKMDNdtaphh73OVxzdeKneNjmVGTxbM9Ionq/4CDTbXnWlTe
         wBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696937830; x=1697542630;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbIuWSCuE4Wag7UGodOLccR3TPXHaYmrWDfYpjzR6bU=;
        b=ZAnEJsn5O65gHHtHY5E5Oind2BXrYKb8EqhL1KJX2HGBQddkARtMr+GiwOht5Nx1YY
         GVcxD/rCcyMGqdCJn6ERRZmxtr005S6zR39OOFhyCIjYtufibFLfgLHZrUHzMoS4YRi/
         WXnFxbB4sM0N5A1FekP5VyFt6Mdlb89rem59JaidwpgZ5/69DAGRFlvu5/a1svi08SQe
         73+6tZLU+KcfuitiDvqLq9mVbBheu5hhb5YvtTSmk1eGwnYobs+Ftk3TzBtul/tNA2aW
         q01QPSITO5f8FQTEzZAqh3On37/OvuMs8novxKSFSfJdesdXKYYDROqgs2rDelPXsF+8
         BHjw==
X-Gm-Message-State: AOJu0YxBUAqT9GzJXJ+7QWX1L9NzAQSE8AhSjzNQRhLstGGGZCGz+PE9
	9094SPtCWnfuJwz+hXxVPm1ArHkAtG0YOWTTdwAViw==
X-Google-Smtp-Source: AGHT+IEvbM2gN3+4ecLC7/FV709ikLX4Reyh8jZ6hkaId/FUhuiea7eKc3INV8Q54T2b+wPSq2YjPg==
X-Received: by 2002:aca:2808:0:b0:3a3:9df9:1918 with SMTP id 8-20020aca2808000000b003a39df91918mr15508719oix.20.1696937830072;
        Tue, 10 Oct 2023 04:37:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a24-20020a637058000000b00581048ffc13sm10191203pgn.81.2023.10.10.04.37.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:37:05 -0700 (PDT)
Message-ID: <65253761.630a0220.94617.aa3f@mx.google.com>
Date: Tue, 10 Oct 2023 04:37:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-cip39-552-gc89b2c57483f0
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 16 runs,
 3 regressions (v5.10.194-cip39-552-gc89b2c57483f0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 11:37:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13359

cip-gitlab/ci/pavel/linux-test ltp-timers: 16 runs, 3 regressions (v5.10.19=
4-cip39-552-gc89b2c57483f0)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-cip39-552-gc89b2c57483f0/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-552-gc89b2c57483f0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c89b2c57483f0aae7f9cb377230347592eb3520f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652523d6fef87c55adefcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-timers-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-timers-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/652523d6fef87c55ade=
fcef4
        failing since 117 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65252348352de79e28efcf48

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65252348352de79e28e=
fcf49
        new failure (last pass: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65252ac6804669938fefcf0a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/ltp-time=
rs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/ltp-time=
rs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65252ac6804669938fe=
fcf0b
        failing since 5 days (last pass: v5.10.182-cip35-8-g2391124f19a70, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =20

