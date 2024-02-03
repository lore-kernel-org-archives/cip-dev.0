Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E00C48291
	for <webhook@archiver.kernel.org>; Sat,  3 Feb 2024 07:41:20 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.13340.1706946070121993353
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 02 Feb 2024 23:41:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Ndiiydnk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29661facbd0so291948a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 02 Feb 2024 23:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706946069; x=1707550869; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vkd2b9Dg96EmQFV4hhLymWrDlhc+5Rnq4s/2kKXW0o4=;
        b=Ndiiydnkp7nOfG0acqhdFDndDMfL5/BonAvzFJ4G5tTyW9iKi00cWDZfjLFwL+Owe/
         dVgQImZL9N2cMG+3XGQAVNsPwR/d1hDBRrimzU19NmWqv0BaW5FOi6+LA+XfDIpNGw+D
         gwRRZmsnKVDfc8qDKyVXY9aWc5V6zEQ0szwJhvF+igazjz3z9Xq5BfcPPxbDYcc3Bwcu
         QJL7qw2IDU1SkDZQWe/1sURLNjbn+9jM5RKfwPO4Tfdks+6zo972HexkDl08DENaaLpE
         sO8lfs35DfpNNwp+GPINW5BTgPPpvq8IZhDF7jQVeekCuotleBRjVqvEEdXs07CTuCSY
         50WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706946069; x=1707550869;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vkd2b9Dg96EmQFV4hhLymWrDlhc+5Rnq4s/2kKXW0o4=;
        b=Wqh94WzlzVhTpAXyaz+7Nw6rtNqzNEPsvOWsgtsrUhjVX1KtzNpQVOZDwpuXzxRdTR
         R5rjvq//IreutWYmLDMX3ETihdlps6uKL+kiCvfpvCP9nJfl/TU2/+sBkZkHTPkqhQU3
         SCY9J70bCUoZGoSqcSh6zheqRWNWiQxzjido8yqia9f7f1lRnskCbh7jSIub409aMNc4
         9HkBPF/W+kPm80pjtack2iWzM6XwHV6oyHmwwDaLkJEsNO9XgUJFCb4JuxCADMhbtxqq
         Zw/Tn5OsUiwFRgEdqONRdybKJvI6st6zqPP3CMQhNm/tMViNT3wWsqcptPyJQqaqRUlF
         pLEg==
X-Gm-Message-State: AOJu0YzSXXEdh5CfTm/emeQuJ2xJgvzqwrvu3HdKQd2VmooDe1RmcVfO
	eQoa6XllnVN5vPaNyKdYp6IgW8NuL/caJJ7aYI/pLs+3aSdDOdEjaxAFYNqKcwmUxlqnQ5tktdH
	15J7Ouw==
X-Google-Smtp-Source: AGHT+IHFheJBM3bxZVNTWldGT7wWz1dCVk7pAaE+uqZvg5PDGQsShbrW8GiYBrJ+9FZ6pzIPh1dyxQ==
X-Received: by 2002:a17:90b:1293:b0:295:bc73:31c4 with SMTP id fw19-20020a17090b129300b00295bc7331c4mr1171066pjb.11.1706946069036;
        Fri, 02 Feb 2024 23:41:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVOoHL9zwPhq5cu+51y+RDJLSIv7WZVsF332exGeS2GIMPq3acWgH36Z/yT3wLxqSynfr7dDS8Yinwl3K3LIWpQp23Kk7rsofgpYekH0Bz7yCTLinlS5Sk9b/GbW16lY6WUaVPI2mHRFalZJfQ44w49VA==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jx15-20020a17090b46cf00b00296540086a5sm1217495pjb.23.2024.02.02.23.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 23:41:08 -0800 (PST)
Message-ID: <65bdee14.170a0220.abb01.57c1@mx.google.com>
Date: Fri, 02 Feb 2024 23:41:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.75-cip14
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline: 134 runs, 2 regressions (v6.1.75-cip14)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 03 Feb 2024 07:41:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14641

cip/linux-6.1.y-cip baseline: 134 runs, 2 regressions (v6.1.75-cip14)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a779m1-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

sc7180-trogdor-kingoftown-r1 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.75-cip14/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.75-cip14
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f555c0a7ff8af9ddf857352bab79675e17c358ec =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a779m1-ulcb                | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65bde12053e543122900a03a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bde12053e543122900a043
        failing since 70 days (last pass: v6.1.59-cip8, first fail: v6.1.62=
-cip9-12-g3a5321f469b07)

    2024-02-03T06:51:08.011816  / # #

    2024-02-03T06:51:09.087155  export SHELL=3D/bin/sh

    2024-02-03T06:51:09.089033  #

    2024-02-03T06:51:10.578489  / # export SHELL=3D/bin/sh. /lava-12694765/=
environment

    2024-02-03T06:51:10.580364  =


    2024-02-03T06:51:13.303607  / # . /lava-12694765/environment/lava-12694=
765/bin/lava-test-runner /lava-12694765/1

    2024-02-03T06:51:13.305800  =


    2024-02-03T06:51:13.311950  / # /lava-12694765/bin/lava-test-runner /la=
va-12694765/1

    2024-02-03T06:51:13.374854  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-03T06:51:13.375307  + cd /lava-126947<8>[   28.522486] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 12694765_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sc7180-trogdor-kingoftown-r1 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65bde1f14af33e76d300a05e

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-sc7180-t=
rogdor-kingoftown-r1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-sc7180-t=
rogdor-kingoftown-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bde1f14af33e76d300a063
        new failure (last pass: v6.1.72-cip13-31-g9539320ac89dc)

    2024-02-03T06:49:13.009861  / # =


    2024-02-03T06:49:13.011570  <3>[   15.995204] Bluetooth: hci0: Opcode 0=
x203b failed: -16

    2024-02-03T06:49:13.017432  =


    2024-02-03T06:49:13.122929  / # #

    2024-02-03T06:49:13.131162  #

    2024-02-03T06:49:13.233216  / # export SHELL=3D/bin/sh

    2024-02-03T06:49:13.242859  export SHELL=3D/bin/sh

    2024-02-03T06:49:13.344597  / # . /lava-12694820/environment

    2024-02-03T06:49:13.352842  . /lava-12694820/environment

    2024-02-03T06:49:13.454452  / # /lava-12694820/bin/lava-test-runner /la=
va-12694820/0
 =

    ... (44 line(s) more)  =

 =20

