Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123E7C38A2D
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 11:17:23 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.6390.1666783041710266725
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 26 Oct 2022 04:17:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=aEOOxVYg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so2083689pjc.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 26 Oct 2022 04:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gugv9aDZi4EzXTyJ6uXR00B8oTN38f+PB+wF7xmH08A=;
        b=aEOOxVYgxc/DSN4lLPE2oZag7HExl909FhP9J4aBIAJ38DKaBu1lKa6emUDqwWNTxT
         nvKci13Ggtl0mP+o4b2kJCSyQLJXVsqnu7Y9AfD2J4Ekv7FnkDzc5JfCwWfgOE2gJgFo
         7Q60KJuajSY5aH+jfmz6AQIEH/PStfyydky6dioEJB8vp4up+XQjoxBmjngG2wB3Jr+c
         W7gRwSzEilBqYasFLW/m6+6wnRSHJRLMP1LtWsjhV/r4qvyOp/JgqIsY8OW/ru2Dly5T
         3lWlE9N8acPwCg9+qTvD+pXI4A6Eoo/zhopPr9/DisZHooqOuz9IyXCT3pYGdm60MTrn
         2CAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gugv9aDZi4EzXTyJ6uXR00B8oTN38f+PB+wF7xmH08A=;
        b=OCqwajb4Wsfs/j79UN3K+toMFHoOGs/JGG1ltkCOIthOkEXkfKbs6CxRiZ0EzlDLnG
         7QB4RV5manGzk631PkW3vtkwlMCc0ajAmwDf7oRLkftvNxoxHFyhmXf9Sb7FmlU125/U
         Bt63DPVXeYR2FwFhhV3Ti9XzWx1Gvjbbikkl8MirzM9R3BOyImAriyGU6eYqg+6TgpJS
         ZxwZDJmX4HitjLaZAvZEI7hxa3P1OYZqHIF+BWb8objwe44VdZE0r3G5SNVujEc6gM1e
         YjRSsUp9n7XqLEl0LzwEvzIV35w5cOZvz632IfpzvwEWozXRajgsY8Z7VQcxjm7oJMAu
         8lrw==
X-Gm-Message-State: ACrzQf08GbA1nq7sISe8AZDgeTpCZcDk67+cAWX9Bd8qVNCHTUgf5JcM
	S465B90DfqGH/8hhnum1w+Jm7Hdk3gYpWjuj
X-Google-Smtp-Source: AMsMyM5+7Eq/DIux12hxUw8NW6yBUoWStYn6avLfH0kTHvJAC22jTB4QgTIGM6ypwKHVttiStAcSqQ==
X-Received: by 2002:a17:90b:4c52:b0:20d:489b:5607 with SMTP id np18-20020a17090b4c5200b0020d489b5607mr3694379pjb.40.1666783040970;
        Wed, 26 Oct 2022 04:17:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t185-20020a625fc2000000b0056bd2ecb7e2sm2813523pfb.139.2022.10.26.04.17.20
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 04:17:20 -0700 (PDT)
Message-ID: <63591740.620a0220.1df00.5af4@mx.google.com>
Date: Wed, 26 Oct 2022 04:17:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-g7bc9523ecfb7f
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 6 runs,
 3 regressions (v5.10.147-cip18-12-g7bc9523ecfb7f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 11:17:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9862

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 6 runs, 3 regre=
ssions (v5.10.147-cip18-12-g7bc9523ecfb7f)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.147-cip18-12-g7bc9523ecfb7f/plan/kselftes=
t-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.147-cip18-12-g7bc9523ecfb7f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7bc9523ecfb7fa7dc71764a249207893ef14174c =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/635907517f731e5fb55e5b3a

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/635907517f731e5fb55e5b40
        failing since 123 days (last pass: v5.10.118-465-g0af29783a3c9, fir=
st fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/635907391c13de0d275e5b4d

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grun=
t.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grun=
t.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/635907391c13de0d275e5b53
        failing since 123 days (last pass: v5.10.118-465-g0af29783a3c9, fir=
st fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/635907271c13de0d275e5b48

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/635907271c13de=
0d275e5b49
        new failure (last pass: v5.10.147-cip18-56-g87bd4289362be) =

 =20

