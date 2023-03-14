Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72055C6FD1F
	for <webhook@archiver.kernel.org>; Tue, 14 Mar 2023 04:29:09 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.1804.1678768143713451924
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 13 Mar 2023 21:29:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=cpbvDCwz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id a2so15310929plm.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 13 Mar 2023 21:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678768143;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z0mbAwxaWkVFHx5Uxhvr+wJ7hy2jgfIK7/9Gea//WGA=;
        b=cpbvDCwzsMOo9+GHtjglqwktD2cw/JeWsofx/A3UXWhtKGljHU3qPe3ExtMe0oiUAg
         EAYSI1dov+20VUvcOOLwsC2zLEN4cSsMJe2PH/CApQ1dXr8aWrPelyZP3Jv0MevCjoDq
         CLE5VzocLdKp5xUFNfUnlKpQwFxwgeMdmDxSW1GfIoHLU+WQ/50NXqk8TIyWYHiupDev
         VVnCds3wACGxyUMAZWFGS8SzThFy/M6jMhv+CWFZhCkMtOM62Slvn+pIbRxd+TsHrF/s
         GFmTQPTfkg0bzc0p2LRqCcCrxLzAlk1RFD2pfnrofFufSp1ZehKNpO86hf77J4nXLtND
         wFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678768143;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0mbAwxaWkVFHx5Uxhvr+wJ7hy2jgfIK7/9Gea//WGA=;
        b=d0pZ/WeyMIyVgMuoWU13Aq8cuyiIPnRfW2aDJSP/eUKercNn3azy2Gz8pwtiHqr7E6
         XPQ4Q2svnfbCtqWOtqtWXo4zQvGXH9rQHNXtGBGtvfkZK8fgIx9wA4TwbpwVycaR6hAn
         6HDpzTotCmN6qxb4kUChTAmC1BXd20eYDBTgSM7rjgxVnNQwoJoICYZTQuKEDei1BEhQ
         s0yFZpbR1JotrsNKM31/lo8xNw551uaA+Po5zWm3poBV+QjprRtLoDqWLd1gLWsL9fAe
         8xEDED4y3Ob4ugO2hMFI0kzPl4P3c+v1uJIgkgrFLW+W4wXg3Tiht7fiMAXvaZ0DYnxL
         x8Cw==
X-Gm-Message-State: AO0yUKWPFuEZKRnmaKuTziG0En9wKbpRtGGJE9jO3Yxc5wGUnuwkBFiQ
	YKt5tuVrx2sYm7ugNIwRQBcbYvfhwegWAzxQa4q1QQ==
X-Google-Smtp-Source: AK7set/7YtR2c4FHdjB99eBH9Im4FeBpjM2AytkFcC5t8UERs+ce7b0TDbLh3+GQI2zOUCvW9M4EdA==
X-Received: by 2002:a05:6a20:6914:b0:d5:6bff:1a86 with SMTP id q20-20020a056a20691400b000d56bff1a86mr938850pzj.10.1678768142864;
        Mon, 13 Mar 2023 21:29:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x4-20020aa79184000000b006089fb79f1esm519104pfa.96.2023.03.13.21.29.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 21:29:02 -0700 (PDT)
Message-ID: <640ff80e.a70a0220.84a3e.1fdc@mx.google.com>
Date: Mon, 13 Mar 2023 21:29:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.276-cip93-5-g2eb2a953ab59
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 6 runs,
 6 regressions (v4.19.276-cip93-5-g2eb2a953ab59)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Mar 2023 04:29:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11022

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 6 runs, 6 regression=
s (v4.19.276-cip93-5-g2eb2a953ab59)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.276-cip93-5-g2eb2a953ab59/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.276-cip93-5-g2eb2a953ab59
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2eb2a953ab592a2d48310bb70c4377b7a42b89d1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  46a2581e9f3dbef9024a33189ab307f36ec3c53c =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/640fea787d4373faff8c86a1

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230310.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640fea787d4=
373faff8c86a6
        failing since 130 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640fea787d4=
373faff8c86a6
        failing since 130 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/640fed93c0a1ab8c7b8c868e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230310.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640fed93c0a=
1ab8c7b8c8699
        new failure (last pass: v4.19.273-cip92-277-g507c8d80b9e20) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640fed93c0a=
1ab8c7b8c8699
        new failure (last pass: v4.19.273-cip92-277-g507c8d80b9e20) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/640ff1d186ed632e9a8c8666

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230310.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640ff1d186e=
d632e9a8c866b
        failing since 10 days (last pass: v4.19.273-cip92-14-ga8d1f73f2a28,=
 first fail: v4.19.273-cip92-24-g2070ce514972) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640ff1d186e=
d632e9a8c866b
        failing since 10 days (last pass: v4.19.273-cip92-14-ga8d1f73f2a28,=
 first fail: v4.19.273-cip92-24-g2070ce514972) =

 =20

