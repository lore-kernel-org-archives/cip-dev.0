Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED20C6FA99
	for <webhook@archiver.kernel.org>; Sun, 12 Mar 2023 09:08:32 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.63234.1678612102783026683
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 12 Mar 2023 01:08:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=I0GY555V;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id i10so9904173plr.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 12 Mar 2023 01:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678612102;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IQjneZWyYSYBByF+nWGDOrHXroJmZwxGMTn+PdcXPj4=;
        b=I0GY555VgWQ27GgVp340VoS3RpIHEZuOpB8B7VckItK1uCvZU0Xke/xhZCTohxvysg
         ovX4MlAUX8gep8vphLU+LzAWOMv32PajALLadHwexJIKE++crIyXead4YDX8ym/eNHk3
         3WVP3jDhagqbUt7GLuFgK04rpdQLH73Ggw2qpGZc/gvW+t6yn4grFnUHmHifjQywoJCs
         RPwJNETIoDzXPvdFTzuDup3V22pVZIP9uQ0rLrGjRxfb6rHnIb9CoeC1rfXHd91aGuNE
         SV9JAQdOVyx6DvonY1Siu2xos2SrFmvVbRDRU5t9RUWZuPKzPJuwuXYxkPdIUGOArmLP
         LyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678612102;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQjneZWyYSYBByF+nWGDOrHXroJmZwxGMTn+PdcXPj4=;
        b=Z+0sqGeEQ8akUupaPz9SfC40cB6VlF4+0EkZ5Bty9FIg6EChS9Od0e+6xGFA7NcQAA
         yL6YcX0iyAKiomUAf6Wx8unA0yLmS0/gVitI2DZIbgzwgJZyzjSxlsUmg3I5zuRZHUl5
         Wwfp6KxvXo3Il72jqHW9HtB1qG1wQvrJYgZo692VW6RAB4HAvkLVqVuxvSqAmx3apPUR
         bWFep0ALGd9RtZLNwQAm72oXAJL9sKSeU5ji2Lx6K6cw1nim7XshJUGQjYYKScKhj5R6
         7nBlw0I2RWTkhj7r48TwjtRdi00VmlGbbgGcGiOM5rlSZdda2Yv51/iB4SNGaYiWtCjh
         j9Ww==
X-Gm-Message-State: AO0yUKVax6QfiqLkzPl07DqIOFr9XCj7ScgiI/m4DZVlgM8XYrSPLMDR
	GYx/tnoDjBUnS8ES55I74W8uNJtw7GZjNtcjnHo=
X-Google-Smtp-Source: AK7set/Lv6LOd9NbRS8lF3m3rAQDDRnT4GQ2Y8WCOzXF/sotc3QOVCULgAegiUydd4CqbaVuQymBqw==
X-Received: by 2002:a17:90b:3885:b0:234:409:9754 with SMTP id mu5-20020a17090b388500b0023404099754mr31026161pjb.45.1678612101801;
        Sun, 12 Mar 2023 01:08:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bv17-20020a17090af19100b00233b196fe30sm2524264pjb.20.2023.03.12.01.08.21
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 01:08:21 -0800 (PST)
Message-ID: <640d9685.170a0220.3cde0.4685@mx.google.com>
Date: Sun, 12 Mar 2023 01:08:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-638-g0d599cd2b6695
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 11 runs,
 1 regressions (v5.10.168-cip27-638-g0d599cd2b6695)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 12 Mar 2023 09:08:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10988

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 11 runs, 1 regr=
essions (v5.10.168-cip27-638-g0d599cd2b6695)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.168-cip27-638-g0d599cd2b6695/plan/kselfte=
st-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.168-cip27-638-g0d599cd2b6695
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0d599cd2b6695e03b8e4b1bdf0c2663d16568070 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640d8c56ca655595a68c8633

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/kselftest-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/kselftest-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/640d8c56ca6555=
95a68c8634
        new failure (last pass: v5.10.168-cip27-109-g23841ec76bec) =

 =20

