Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDA8C4829F
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 19:45:56 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.23037.1707853556115998462
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Feb 2024 11:45:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=kuqfF28n;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-290fb65531eso945593a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Feb 2024 11:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707853554; x=1708458354; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xpC4lRUff6GsH1Dn4qZmba/jzuuiKEh58wOKv96MEm0=;
        b=kuqfF28nZEn+jhYrlEKi9xNd1oRVyBkaS2zuCa++PAf1fOVN3rxd/dlOUW2bhqui2d
         hSG0se2UcrGXqBiTUR0jdE+9MYysvJedCaVeItrbF9giYhsak5fLhEIpf8LDIQDrA4g8
         jNIm3H6HrkXYrYPSceQYl4Ue/trN6EzjrLvLFnoqbKp7GlqTUr6/4Gga5VRDbrxfvHHT
         x3OjVEbmwiUKbH3FXWDWz9p4ymWTubjJyqyWAR9SIY8tZFOw6XNY5MlAus9I7Fo32EUq
         tkHua8SFQlpZrMQ7fYr9KCypgzXUAxtE/GcYm0EzAlHnGz1UymiwsKOEggSPqDJwYPQZ
         BYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707853554; x=1708458354;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpC4lRUff6GsH1Dn4qZmba/jzuuiKEh58wOKv96MEm0=;
        b=Hob+xUNgwlzUSACiO5JssHoplzoIgRNHB5GG72B+/Icu1v5HtWgDyiQ4lEOL1RqHLh
         U34P10PfAB2dm4aF60YuqpfDvC9kzCgetTLAGA0b2MfXFFIt++Atp7rjET300jbvpRNk
         IEinUfjgnSj1e0HzZqHKWxQhS/nH9kMOZCsOlVPf50TEyR7JDFPVVuEieYU1i/e1PVRG
         VLOI/avTPfcafT3z+5Vik0v9f7PExRQuhgCaHaKj5UdETchyqSZsYpwswAa338FyVvGH
         ojnOXSOmWtNCdkz57A++WRchEnmFxJYl7bwqDnNvKJITgge6r+NrRPdjk3VcMAPpBxH7
         6Qng==
X-Gm-Message-State: AOJu0YwZmk1rc6wMO2NmH0vSArZVa9uInRC+057ve9/Rc+A5ggypHhfs
	banGMNnWNRF86AmpdEqYmx5BnUzQCJ4ETO8V2GR3s62OBZIVw648YQPCh4TtiYxnumBdHRcYaJr
	JagA=
X-Google-Smtp-Source: AGHT+IE4eWNfw9I6y8zkd5VKW6Y422U+XWTkMlkyDysuMZyRtRLJkqMp/0V44l24fZJXO7zjYuXl6A==
X-Received: by 2002:a17:90b:198c:b0:297:190f:de16 with SMTP id mv12-20020a17090b198c00b00297190fde16mr439173pjb.30.1707853554580;
        Tue, 13 Feb 2024 11:45:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id mn7-20020a17090b188700b00297169b3887sm2987939pjb.24.2024.02.13.11.45.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:45:53 -0800 (PST)
Message-ID: <65cbc6f1.170a0220.f365d.a9db@mx.google.com>
Date: Tue, 13 Feb 2024 11:45:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-51-gdb99ac443b0da
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 11 runs,
 2 regressions (v5.10.209-cip44-51-gdb99ac443b0da)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 19:45:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14958

cip-gitlab/ci/pavel/linux-test ltp-pty: 11 runs, 2 regressions (v5.10.209-c=
ip44-51-gdb99ac443b0da)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-51-gdb99ac443b0da/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-51-gdb99ac443b0da
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      db99ac443b0da75f00a4fc49e0040ac5dfa47e72

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


  Details:     https://kernelci.org/test/plan/id/65cbb3f0fb210f9e7a63707d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-pty-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-pty-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65cbb3f0fb210f9e7a6370=
7e
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb539b15d7a8f61637107

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r=
8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r=
8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65cbb539b15d7a8f616371=
08
        failing since 13 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =20

