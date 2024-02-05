Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A779C48295
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 14:17:07 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web11.63407.1707142617849243572
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 06:16:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=vMI+x/l4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso4240134a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 06:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707142617; x=1707747417; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rRcu7IN70eq+ASEclROinNqGRbUQvM6MAMLTTrJcGZk=;
        b=vMI+x/l4TjBUPE2e90oqIsVP+bTPWeC4+NNL/uULoUx0txlksDnfA3c5SdjDsk8VFa
         GP/f5oC+/zpSMZdq017fToxUfQnoh0Bnx/XEBZeuW2Zsaawr6kfEzHtqiNXbLPg5Oxy4
         UrLGKWpeZRS6J0xwGzjMokSqyZGBWP48GycXN1ve1lg2AQz8jTGrraddmuT8ytosVjP3
         dC6bsagIprPZ4QIErHJmIe7Sqq6bEtLp/ai8dC0DZbsDMxsyTMu7E4fErlE/6jW1OvOU
         PbGCv3cqMaviyN6nT3lCWpeIyBJILhDkFUQwTyy930T5hJdmf7Xpn1cApugs/+LuBhri
         ijgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707142617; x=1707747417;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRcu7IN70eq+ASEclROinNqGRbUQvM6MAMLTTrJcGZk=;
        b=GNnu0AGdfrnMqb/zSOwBFecyMl8jSWIQz0GWXnZt9Y7rB1JsIexfPlxk7gjMyBzz15
         oLmOkgJXySwPyudPXCgWHpa7vm50yiRL82a0i0HFAITJlqomjPWiFo730OPjHAgJOIVA
         dhb8t4+1Ngw1dx8YS8ESxZ2ed/53YEF+yyXiCFLJKgtY43zoRiD61k1sxs0Q0zdq0ND6
         LG6AMYgcphECl0b+5X3L12WB33qhbVrcjjg0iuJUWQGgXEwjg2DFOIQnuA4b84gupKRM
         iBap1txPC4fbRfII1lZzlpyf4IO0YKZyvxyla5/dbe9+ENGQ0oKXuMu0Y2ilivWVjBpP
         2jXA==
X-Gm-Message-State: AOJu0YwkGSIu7dCHu+TPV/eFcX9f2n+7MceVAaCGwdoULRbigz6irM+W
	rtAJ6blQkOa2RVunE0hA/PjnIfdEg1YSaUZUT3elQto8g3a7EurYmhTgTTNrJKDxbHmD04fj9/n
	5
X-Google-Smtp-Source: AGHT+IELQIuafw2rkt89wKzkF4q3Y3Ev6chRlBgFDETbuAkrhywCnxISEmxH4NOAlGHm0e2C66/hLA==
X-Received: by 2002:a05:6a20:c78c:b0:19e:4ed7:127a with SMTP id hk12-20020a056a20c78c00b0019e4ed7127amr12233102pzb.46.1707142616777;
        Mon, 05 Feb 2024 06:16:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXDOxAabqdC4vSV0MsN58tKBLX3VuWhWxonc7pA55Xg+KS0T7LJ4Un43m1d7z9ldmpZCnkei8BZjOI/KWb7niFnsMvmwDd9EV8mXYKx6+bMc74Qt8X3Scg2IJGBjJzaHDxkYXkkXeHGdzkY5bfDqX7MgA==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y2-20020a62ce02000000b006e039e97d34sm3230032pfg.151.2024.02.05.06.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 06:16:56 -0800 (PST)
Message-ID: <65c0edd8.620a0220.33ae7.8f0a@mx.google.com>
Date: Mon, 05 Feb 2024 06:16:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.75-cip14-6-geddeb7f8123c
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline: 119 runs,
 2 regressions (v6.1.75-cip14-6-geddeb7f8123c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 14:17:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14729

cip/linux-6.1.y-cip baseline: 119 runs, 2 regressions (v6.1.75-cip14-6-gedd=
eb7f8123c)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig          | reg=
ressions
--------------+-------+---------------+----------+--------------------+----=
--------
odroid-xu3    | arm   | lab-collabora | gcc-10   | multi_v7_defconfig | 1  =
        =

r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig          | 1  =
        =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.75-cip14-6-geddeb7f8123c/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.75-cip14-6-geddeb7f8123c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      eddeb7f8123c49b652f55156c9bdfabba5de8021 =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig          | reg=
ressions
--------------+-------+---------------+----------+--------------------+----=
--------
odroid-xu3    | arm   | lab-collabora | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/65c0e4cd82ce38bdf200a118

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14-6-geddeb7f8123c/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-od=
roid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14-6-geddeb7f8123c/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-od=
roid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c0e4cd82ce38bdf200a=
119
        new failure (last pass: v6.1.75-cip14) =

 =



platform      | arch  | lab           | compiler | defconfig          | reg=
ressions
--------------+-------+---------------+----------+--------------------+----=
--------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig          | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/65c0e6cb994b3adb7900a0a1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14-6-geddeb7f8123c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14-6-geddeb7f8123c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c0e6cb994b3adb7900a0aa
        failing since 73 days (last pass: v6.1.59-cip8, first fail: v6.1.62=
-cip9-12-g3a5321f469b07)

    2024-02-05T13:47:39.831051  / # #

    2024-02-05T13:47:40.910686  export SHELL=3D/bin/sh

    2024-02-05T13:47:40.912509  #

    2024-02-05T13:47:42.401199  / # export SHELL=3D/bin/sh. /lava-12703954/=
environment

    2024-02-05T13:47:42.402937  =


    2024-02-05T13:47:45.123816  / # . /lava-12703954/environment/lava-12703=
954/bin/lava-test-runner /lava-12703954/1

    2024-02-05T13:47:45.125959  =


    2024-02-05T13:47:45.139293  / # /lava-12703954/bin/lava-test-runner /la=
va-12703954/1

    2024-02-05T13:47:45.155289  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-05T13:47:45.198356  + cd /lava-127039<8>[   28.497118] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 12703954_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =20

