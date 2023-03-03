Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41091C64EC4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 16:50:17 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.28621.1677862210416229836
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 03 Mar 2023 08:50:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=dSqWX0wf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id i3so3286831plg.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 03 Mar 2023 08:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1677862210;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UFGdn+7L3DkrAP3pHLdoLpwtsxn0PZAcQXoXW5c2Me4=;
        b=dSqWX0wf3lObYY5LXN1Ib3jIqfGUhKyVt7mHjGUxP22zbAlJ611Ep53NCqoQh7aSmi
         mEkVgP97OPYd2V+hM60JyvuoMB6bb4QRGq3jSf6SdciRxXAMFshT8X3aytADMOkPOlKq
         iDdobJ94pR8w/s/5I07vjDP6+X/gn4aRiiS/E7FzBlWnOkHQI92JFiB8z2d6d+gl4gdP
         wdeRnwIK9xm18+qcVBc+xmGmU923qO3ff38PsGzhiSXWWu6nVvPDm8/+gN+n8/JXF3ft
         wN0gCR+QYwEcdduqBlrKndofgZ5o9x10h0aEx7pzfIN1PH1uHitetcyBs2Yusw3e7jPA
         2cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677862210;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFGdn+7L3DkrAP3pHLdoLpwtsxn0PZAcQXoXW5c2Me4=;
        b=y22xCaQTvToXvz+RP96slmYdBZnuWswUrovARQ81NSDyS1VJXabim1le1thlpSMOgs
         TbitYx4v/bP50udYS3BG0PDKylbmnpvKBZDGb/R+14V/WTA/q0podizVNTT8JR+qwn+V
         38REbCMJkaZR/zm556B85EXNkhepbpIbTKEuKrjsnn/7wfR9KJg3KP7LS1e1+hWBVQx4
         bH8SJCykuiC65Q2aLDW3f2n8ZEf8OyCA7bi0J8JYbDGZC90zPCHqTc0pd0RFOp9MgXAN
         twsissSZeqFnSjBVL5jdUd6YQRxplMq8N+08UNgyWPsY/FO0/o27s+OyMfyc8HeVFq8q
         1RwA==
X-Gm-Message-State: AO0yUKVArYDTrzsSTtlkQq37z1RMC48/5NdujSR0+WalrdRzfWxihAdX
	O5eDJ6Qo1VsxYfN5atjkw+GOUy+bH5Uj1tM7OaXDBg==
X-Google-Smtp-Source: AK7set9cHM7aIVAMs7aW6XFnw8UBPT6K+KFzzLrWxHbAmhKzsqoSp1WyBlEW6D2DIs4GcuqDBOzAdw==
X-Received: by 2002:a17:902:aa02:b0:19a:839d:b682 with SMTP id be2-20020a170902aa0200b0019a839db682mr2330118plb.17.1677862209572;
        Fri, 03 Mar 2023 08:50:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b0019a74afe97dsm1725004plb.187.2023.03.03.08.50.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 08:50:09 -0800 (PST)
Message-ID: <64022541.170a0220.85ca8.3613@mx.google.com>
Date: Fri, 03 Mar 2023 08:50:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.273-cip92-24-g2070ce514972
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 5 runs,
 2 regressions (v4.19.273-cip92-24-g2070ce514972)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 16:50:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10921

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 5 runs, 2 regression=
s (v4.19.273-cip92-24-g2070ce514972)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.273-cip92-24-g2070ce514972/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.273-cip92-24-g2070ce514972
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2070ce514972cfaa8912c58feffcc824d465c865

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a5d15b796362fd2731fa0290d48c096d370a040d =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64021d64396a6416738c862f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-24-g2070ce514972/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230224.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64021d64396=
a6416738c863a
        new failure (last pass: v4.19.273-cip92-14-ga8d1f73f2a28) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64021d64396=
a6416738c863a
        new failure (last pass: v4.19.273-cip92-14-ga8d1f73f2a28) =

 =20

