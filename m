Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9DBC61D97
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 10:51:56 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web11.133153.1700823110576629717
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 02:51:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ynE1Hnw9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c206572eedso1345151a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 02:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700823109; x=1701427909; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=16PIgsyv6FJPAg/y6aoG4REezekPHGthVsFMCSYqH7U=;
        b=ynE1Hnw9iL0/P1g/kNpjjmsjwnM8RboiqVrqRp1YoBE/wS9gOS/GxcdHk/vr4GZOKL
         /K3b5uyryPWGQ+MgrfrAQy5rH5hohYB6HV8OIgUZ5xhnyciltFyH63XKuw+SF1Gkuq3R
         sH1kB7lAsPULsgXuZiZ3Dkclw8tvldqOMCPR0W8zPePEAqdgGuAJc/cElvYw/RmHMN/r
         x6UYs8HiKLrCmWCIYoSE2mbZc9VISb7yObO6nJGieC1Olj8LpOGGo8iDEScTNIp2zovX
         HZuAH+7Qosb5uS/L7nfP6qYD6A6WVSOL8iFkax49wZbr67hQ6BgF/4MTWTXCv4AFQZTb
         w4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700823109; x=1701427909;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16PIgsyv6FJPAg/y6aoG4REezekPHGthVsFMCSYqH7U=;
        b=PVHmRfhxN/fsZ/NrJVPmRvo3Jw9JZdVbkQ85+gliKb2sD/BEFWhhY6+IGYTzRzI5/S
         MJQ1bXfLm+qREpYgfPKmU0S2hnqaWi0Pvt5gviZYgMBv/tTeWxM7XmN41kxWQhjWNZ8k
         YZDs9/vmAofLDfBmXm2weokN7I6607invNGqBqireFQIZr1sDFE2AV4ciUrIwZD5TH4/
         HckfKFwjD/Fp46hyXowuQ5SNy00Vyqb4kRurTwwOrnDOficOT6Tmz1s3jHc/+5XQzFGL
         +ScUlMuosh7AhwTn3WiYNnKzWvTfR8eWkOVopf1bhmiaX9y+bW54fgkQzxm1y5mn7lB7
         F0GA==
X-Gm-Message-State: AOJu0YxvpzU5kayRVyavEe2CC8CiA2wCmMHKKd9yN1+huPpcn0qSzkYr
	GDIzKGz0C6vTsMSHOQ0UIO1rwkcYLzVfPr5jZp0=
X-Google-Smtp-Source: AGHT+IE+7H1woV+w3Va8AFoo6BvDrJM+Ut9CQuEXu3fOlrMbW8g4jVn7vXHwC+Rw25fTrKBOxiJ0dg==
X-Received: by 2002:a05:6a20:d04d:b0:189:fd93:c969 with SMTP id hv13-20020a056a20d04d00b00189fd93c969mr3210849pzb.26.1700823109333;
        Fri, 24 Nov 2023 02:51:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r10-20020a63ce4a000000b005af08f65227sm2844873pgi.80.2023.11.24.02.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 02:51:48 -0800 (PST)
Message-ID: <65608044.630a0220.57541.6c5d@mx.google.com>
Date: Fri, 24 Nov 2023 02:51:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v6.1.62-cip9-12-g3a5321f469b07
Subject: cip/linux-6.1.y-cip baseline: 130 runs,
 1 regressions (v6.1.62-cip9-12-g3a5321f469b07)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 10:51:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13719

cip/linux-6.1.y-cip baseline: 130 runs, 1 regressions (v6.1.62-cip9-12-g3a5=
321f469b07)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.62-cip9-12-g3a5321f469b07/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.62-cip9-12-g3a5321f469b07
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3a5321f469b07e6124d325d7faaa2f8f1993f67c =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65607679e05bf873277e4c56

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.62-ci=
p9-12-g3a5321f469b07/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.62-ci=
p9-12-g3a5321f469b07/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65607679e05bf873277e4c5f
        new failure (last pass: v6.1.59-cip8)

    2023-11-24T10:10:16.126278  / # #

    2023-11-24T10:10:17.205525  export SHELL=3D/bin/sh

    2023-11-24T10:10:17.207399  #

    2023-11-24T10:10:18.697574  / # export SHELL=3D/bin/sh. /lava-12073478/=
environment

    2023-11-24T10:10:18.699538  =


    2023-11-24T10:10:21.423341  / # . /lava-12073478/environment/lava-12073=
478/bin/lava-test-runner /lava-12073478/1

    2023-11-24T10:10:21.425782  =


    2023-11-24T10:10:21.434150  / # /lava-12073478/bin/lava-test-runner /la=
va-12073478/1

    2023-11-24T10:10:21.493736  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-24T10:10:21.494228  + cd /lava-120734<8>[   28.583727] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 12073478_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =20

