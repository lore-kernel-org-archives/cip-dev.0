Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18669C4828F
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 14:35:22 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.16924.1706798121941577474
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Feb 2024 06:35:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=gPfkgtCn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6dfefb490f9so226349b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Feb 2024 06:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706798121; x=1707402921; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IvO3Ioz7t8OHvPrn+tAXprvGQwqQ8f4yFDQ/YeU4bw4=;
        b=gPfkgtCnfcxUsd1uw34n6FfQbJ2wO33JKs/o2/fpm0k/2+C21H9R3Sx1tSPNAM84nm
         ll1sA+hCPpUMesKeBRUsWHKzvXheM+f7uvbaDQSObnOMmkIdiYziZ3n1d/vi3mFkiDyY
         sEB+MPsnC1tZR/EkP5EZb5mqYna6oOD1vhlYh+FI373I0BMqniqAil4U6uwlf3jKxrk9
         GfTcQtUmhgtiXNuifX6N9BeqH9Dlec8jlrUQ3lrKaEcZSCSdyJntluphUP2ZRQUqHCr1
         YKpkO6J2WGwVSQ3eEm065HesdjkixTQGwYbGt/5SiXVT6Lv8NKyjaPmRU950WhB4C8nQ
         IjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706798121; x=1707402921;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvO3Ioz7t8OHvPrn+tAXprvGQwqQ8f4yFDQ/YeU4bw4=;
        b=QaI77gX0lgFneYWkXFpmgUpcLz5guSJoxXG4DVHTMSvxPDXhX2hW+J/Ru/rr1+UsXY
         xwNq0xnA8KPtJVEIWnuNO3ClRu0H1RY2M0DFwQxrRY98HG/TTsZTI+yLhvekS2gtfiU1
         wLkSVLTh+zM9/yS3urOH48Ay88CgBASbgaKCS0MD7BD2gJ1FCI6LfRU05ZjLq0YCPCPa
         lm02ki74vQ5EUUMIaHo/rM8EK67KX9BCc7eP8lortqqbzCsK/FQHh8K5GI1vmXUNYnja
         y37CcjK4Ks5OcYydOL5ROIUe0HGIk4UM9Jrn3fmp6B/aPZN9FhG7pAge8cA5wHd+MIYd
         stIg==
X-Gm-Message-State: AOJu0YxfXw/Th9czLr1jq6fj8uEG/KfXJixMRS0B0eUZfHhTVujxdREJ
	psj7sOpMxmxt2lZlECaj8Hk3f9i/cvE7QGDpALeiyhjvgpDW24WQXPodIJSaaZRCOvB2ukB4wEW
	T
X-Google-Smtp-Source: AGHT+IEG/G5wmkAjs22bfSPZX3BliQo7rci7seVCcBc+z8vNurjtPYV7jhjXOTY5PR+9axB0X8I6tQ==
X-Received: by 2002:a05:6a00:985:b0:6df:daca:3436 with SMTP id u5-20020a056a00098500b006dfdaca3436mr5485554pfg.12.1706798120971;
        Thu, 01 Feb 2024 06:35:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVIz8qMUtb6NmtD+59E43fE6YXrKJEl3LYBnFRXKHW8OHnMrP2qJL8dQZvn2VzojlWUCKDH8BCF85CodXy/PDAeu0HR8kPIeLbH50WAumOjzqYyCvTjH+0gaAj/cR06F/7foB9RFJps/xY/JK4REVrrdA==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fb13-20020a056a002d8d00b006d98ae070c3sm11889724pfb.135.2024.02.01.06.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 06:35:20 -0800 (PST)
Message-ID: <65bbac28.050a0220.829fb.6873@mx.google.com>
Date: Thu, 01 Feb 2024 06:35:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.72-cip13-31-g9539320ac89dc
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline: 129 runs,
 1 regressions (v6.1.72-cip13-31-g9539320ac89dc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 14:35:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14582

cip/linux-6.1.y-cip baseline: 129 runs, 1 regressions (v6.1.72-cip13-31-g95=
39320ac89dc)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.72-cip13-31-g9539320ac89dc/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.72-cip13-31-g9539320ac89dc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9539320ac89dc2caf6bf646eca56ac33ae7c615b =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65bb9f2a849e7eec5b00a0c0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-31-g9539320ac89dc/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m=
1-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-31-g9539320ac89dc/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m=
1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bb9f2a849e7eec5b00a0c9
        failing since 69 days (last pass: v6.1.59-cip8, first fail: v6.1.62=
-cip9-12-g3a5321f469b07)

    2024-02-01T13:40:32.715324  / # #

    2024-02-01T13:40:33.792253  export SHELL=3D/bin/sh

    2024-02-01T13:40:33.793517  #

    2024-02-01T13:40:35.279299  / # export SHELL=3D/bin/sh. /lava-12682818/=
environment

    2024-02-01T13:40:35.281058  =


    2024-02-01T13:40:38.001299  / # . /lava-12682818/environment/lava-12682=
818/bin/lava-test-runner /lava-12682818/1

    2024-02-01T13:40:38.003688  =


    2024-02-01T13:40:38.010254  / # /lava-12682818/bin/lava-test-runner /la=
va-12682818/1

    2024-02-01T13:40:38.071757  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-01T13:40:38.072237  + cd /lava-126828<8>[   28.484503] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 12682818_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =20

