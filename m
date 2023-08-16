Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3045AC001B0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 12:53:19 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web11.159657.1692190392237136855
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 05:53:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Uf6KdoCv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6889656eb58so65497b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692190391; x=1692795191;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X9kj4kOdd+e3F4b4gTmOBXbDooyXtK2oNPsiIj0ohqc=;
        b=Uf6KdoCvJHLjKneWcXfclG1u45xTxM4E7OAqXCNZMOiKikc+HwbqPJ39cQ3G3n4nJi
         J/wUzjj8mifLGsZNhscBRYi9s6DWs7j6gMMkqUgTmxV+UUhYhoQLVA0modFmgM6Otwzs
         7adZ7L6Jlp1Muj8ta4/Eq4LOpViiSdHEjeBAMR/xpXSLCdz/Y45EG+QyeEYaeIbwittn
         DWwrZ2Qyk1LAlnykw9wse8zmLfaecUdPe0P0lUcP+mOhXoohHdyDFoXr38JiJ1eYlhiO
         a8vubZaJFBEpzWMAnZkB2NgSlWG9FOd6bm4IPsj7/9n9oeom4OqtXbOOhRij2uVZyhs7
         o9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692190391; x=1692795191;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9kj4kOdd+e3F4b4gTmOBXbDooyXtK2oNPsiIj0ohqc=;
        b=Z5w1OdOfihyPymtcDR1tc3gJtcLbnqjT79GAWW0S6dCwd/YGRLWPvZHFo4Sfgshxja
         jXnpS4R8UZMb62FMRb5ciKDQ0Fk6iI0cZ0XYmtXuQf410m/fO793xLsHoCXeb3CjtKFG
         XbhkVpyD7qbf0lwZZDbzMIxwbCrImAlR9GIiR557qLrSUvv93Z81Cp/QdKEEagiOD847
         Qmzmiz/1E0pA4olPPgB/HaVbDH4eLujluMzpjXwhkKIEM+ESMXT5A/TzjzVDnjo8lckM
         cuuFb9FyAwpLQYD7gpr8NIIu/PawcMrMd6BJOGM6Tjiwb44mew7mHFP9SqRtFcz5hMlD
         mRLA==
X-Gm-Message-State: AOJu0YwieUmdH5TEZRMIX+shuXjMNFAv2gDjpneARG6Y1VisGzhixadE
	iOnd2KtgEs8RaGBo8OGGhwih/QURJr+Pecbu4kGgIA==
X-Google-Smtp-Source: AGHT+IGlhTSBr7ybzjPSFlSjq4GZ9OE2hiPo3cERcQHvp6a+NdV3evszVGRU0nK7caYVteSakZkhMw==
X-Received: by 2002:a05:6a00:2e29:b0:668:806d:c2d6 with SMTP id fc41-20020a056a002e2900b00668806dc2d6mr2064809pfb.12.1692190391133;
        Wed, 16 Aug 2023 05:53:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j19-20020a62e913000000b0068859ce216csm2386988pfh.0.2023.08.16.05.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:53:10 -0700 (PDT)
Message-ID: <64dcc6b6.620a0220.c174.4a93@mx.google.com>
Date: Wed, 16 Aug 2023 05:53:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.45-cip3-1-g0a940c1b3dc0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
Subject: cip/linux-6.1.y-cip baseline: 121 runs,
 2 regressions (v6.1.45-cip3-1-g0a940c1b3dc0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 12:53:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12675

cip/linux-6.1.y-cip baseline: 121 runs, 2 regressions (v6.1.45-cip3-1-g0a94=
0c1b3dc0)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

sun50i-h6-pine-h64       | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.45-cip3-1-g0a940c1b3dc0/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.45-cip3-1-g0a940c1b3dc0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0a940c1b3dc0b7b907d02c5d9fa674cec6d979fd =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcbf4d9c957c223f35b254

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3-1-g0a940c1b3dc0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3-1-g0a940c1b3dc0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dcbf4d9c957c223f35b=
255
        failing since 2 days (last pass: v6.1.42-cip2-1-g47d13938e615, firs=
t fail: v6.1.45-cip3) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
sun50i-h6-pine-h64       | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcbeb9296b40790935b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3-1-g0a940c1b3dc0/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3-1-g0a940c1b3dc0/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dcbeb9296b40790935b1de
        failing since 16 days (last pass: v6.1.31-53-g486caac40d06, first f=
ail: v6.1.42-cip2)

    2023-08-16T12:20:19.287040  / # #

    2023-08-16T12:20:19.389184  export SHELL=3D/bin/sh

    2023-08-16T12:20:19.389900  #

    2023-08-16T12:20:19.491327  / # export SHELL=3D/bin/sh. /lava-11299230/=
environment

    2023-08-16T12:20:19.492059  =


    2023-08-16T12:20:19.593496  / # . /lava-11299230/environment/lava-11299=
230/bin/lava-test-runner /lava-11299230/1

    2023-08-16T12:20:19.594560  =


    2023-08-16T12:20:19.611410  / # /lava-11299230/bin/lava-test-runner /la=
va-11299230/1

    2023-08-16T12:20:19.678369  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T12:20:19.678874  + cd /lava-11299230/1/tests/1_boot<8>[   17=
.036547] <LAVA_SIGNAL_STARTRUN 1_bootrr 11299230_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

