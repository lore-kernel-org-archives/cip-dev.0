Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B85BC00A5A
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 13:35:51 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.45297.1674135344077939635
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 19 Jan 2023 05:35:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=DiCMM9ry;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id c85so1480698pfc.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 19 Jan 2023 05:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S0hmVpRB+l8ZAymF4eiSQvo2Wkf6qOn37syzfgQkOoI=;
        b=DiCMM9rysuh/eK2SaZHiEmYl5rYAlqtbotlf4q6Hk2hSpe+jgI1epTYPXehIRz4n6X
         /ipXl/n/ZgPuQQI8yU4HhLI22qSJ/FbDYYa2GMCGFH+VgBuKXy5fFIBiun7Czwgq53Df
         Ra2yfR6PSP4JBBQ+8s6+xMUAKT25COx30r9ezolH039ISFa3rUfmFllQsPG9OBXmcydB
         OU/KMsrSaD1VWImqDhx/pXZ0/7cw7oMo/wbtsDxV9ap6CqdoM6cpLmXIlxSJ5vgC2hA7
         B/Z3VzcFMTV4U6cReWHshyh4wpz0sh18F+nz1NnVbMpyCeLv0SOfIs/BAab6HFoRMMYG
         oiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0hmVpRB+l8ZAymF4eiSQvo2Wkf6qOn37syzfgQkOoI=;
        b=eqMGXTA1kfcjh+796E7xziOlzuQ6630rAKWOkJ12a5I4S39bBMmaLAaqYnPpxlqiof
         UflbETCqi5QPMrnH7rg+rb7kqcWfiv3U+wQXLLo6/ddur/Ln/XJH71L9bVTrwE5WHlY4
         c9ZNFOZC8TY+prUy3UrtzYQgSL9USrbbH3xW3nBzEVjv8KQmoYWTVRiIHfMjDxYoxy78
         JKAegzno7bHwRPzwyf4Wpu8QDxyHoA+My5rRT/5fCuzBLHVD5nhf3jURpgTFikxdX9/k
         qnNT/Ry72vGbO6Zkl5L3wA2IDzMGWq60/nqV+j/HJnpyOcU868svTQpie1O79BpdCFz6
         jByg==
X-Gm-Message-State: AFqh2kpGmGJupagPqAu6LxSigOpO+b/jQZXLDHcqS9Ct1eNi015hWdKG
	z5+kTThBYyeHDgMpNrLvb2O0ccjVZ3JrU+nxc76jcA==
X-Google-Smtp-Source: AMrXdXuk6o597uoI0ym5xf4YzPvu4EiJbdbDdT/pfQFJaA0eHL5hNenDgS32c1jifOfC/GaalQtolA==
X-Received: by 2002:aa7:9399:0:b0:58d:272a:52a0 with SMTP id t25-20020aa79399000000b0058d272a52a0mr9866796pfe.32.1674135343151;
        Thu, 19 Jan 2023 05:35:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p128-20020a625b86000000b00580d25a2bb2sm19534459pfb.108.2023.01.19.05.35.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 05:35:42 -0800 (PST)
Message-ID: <63c9472e.620a0220.b8969.0710@mx.google.com>
Date: Thu, 19 Jan 2023 05:35:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.162-929-gae713b3c4626e
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 35 runs,
 2 regressions (v5.10.162-929-gae713b3c4626e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 13:35:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10442

cip-gitlab/ci/pavel/linux-test baseline: 35 runs, 2 regressions (v5.10.162-=
929-gae713b3c4626e)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.162-929-gae713b3c4626e/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.162-929-gae713b3c4626e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ae713b3c4626e7f02c44b3495f9b37717dd93ef0 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c93f52228225b9c1915eb9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-929-gae713b3c4626e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-929-gae713b3c4626e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c93f52228225b9c1915ebe
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T13:01:48.555573  + set<8>[    7.847195] <LAVA_SIGNAL_ENDRUN =
0_dmesg 8797881_1.4.2.3.1>
    2023-01-19T13:01:48.555696   +x
    2023-01-19T13:01:48.660490  / # #
    2023-01-19T13:01:48.761562  export SHELL=3D/bin/sh
    2023-01-19T13:01:48.761819  #
    2023-01-19T13:01:48.862816  / # export SHELL=3D/bin/sh. /lava-8797881/e=
nvironment
    2023-01-19T13:01:48.863065  =

    2023-01-19T13:01:48.963994  / # . /lava-8797881/environment/lava-879788=
1/bin/lava-test-runner /lava-8797881/1
    2023-01-19T13:01:48.964319  =

    2023-01-19T13:01:48.969631  / # /lava-8797881/bin/lava-test-runner /lav=
a-8797881/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c945cfca91ee778a915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-929-gae713b3c4626e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-929-gae713b3c4626e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c945cfca91ee778a915ebe
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T13:29:32.091460  + set +x
    2023-01-19T13:29:32.098483  <8>[    7.295610] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8797822_1.4.2.3.1>
    2023-01-19T13:29:32.208052  /#
    2023-01-19T13:29:32.311652   # #export SHELL=3D/bin/sh
    2023-01-19T13:29:32.312484  =

    2023-01-19T13:29:32.414509  / # export SHELL=3D/bin/sh. /lava-8797822/e=
nvironment
    2023-01-19T13:29:32.415485  =

    2023-01-19T13:29:32.517551  / # . /lava-8797822/environment/lava-879782=
2/bin/lava-test-runner /lava-8797822/1
    2023-01-19T13:29:32.519076  =

    2023-01-19T13:29:32.524762  / # /lava-8797822/bin/lava-test-runner /lav=
a-8797822/1 =

    ... (13 line(s) more)  =

 =20

