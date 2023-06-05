Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C94BC7EE29
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 00:22:50 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web10.1178.1685924560954594323
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 04 Jun 2023 17:22:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=d9UiuzHP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.181, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3980f2df1e7so3559433b6e.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 04 Jun 2023 17:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685924559; x=1688516559;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=89G2YRWUVdKHsQ6JvNvibSpKIukPjVgAfEYPSOHLS8w=;
        b=d9UiuzHPzoZiPKq+ofw0eDnShdjOJQKIYR8OWTtFTCo4AyqjMJZ7Nz8Rb1S+/dMetK
         9It96kOJRUd+0QYHp6jEhvPJpZ2Fxu2TU/Jsa6hryV+QwyDf1KaDoZUrZL2xWJFCNl0u
         We+yy7pgqKlujvcFdsXv3Yaa4KsjTd/iwYU9461ISp1bZL7c1M8soVOgkTbY/LyIneET
         +i1GX/HZb2O0m+wD/8fzyEmA5Caz10NzIid8mGhVHjQ1SiLKK1jYLRuGz72zZ6veYoZo
         Wy4hiFnqVmaTFzc7gNZgFoGlIu/ytNdSO1HcEvcIC/k2rfHuOmbQs2EDejFiFz8CNHu/
         Wr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685924559; x=1688516559;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89G2YRWUVdKHsQ6JvNvibSpKIukPjVgAfEYPSOHLS8w=;
        b=ZRZBg6EpOi3vstNfcwp6eOpJiIileE3AwlCLwxPLdTWU3vneG7cF7KKM44TifmpikB
         yc9w9z++anxLbk1tLozVBRDvVmDV8ZJ4tViVkbX8b5H8KOVLj33uJCtiBvpSI2nx9/bq
         S34SLWIrY+Vn8vHzFEc0N747cdsHZHPTzIAQZrCLPzGVILVjyXhoI+lApk+gvByzdaGW
         DpBJHOSVHYO62Kj+1Mkx0SQDx8ofInMpfoW2eBvyXvGjmK333Flo/0EMrv1F1RnXLoEM
         KfLXRUX52SX4bGQzI8ghKsvhaTH5TSMTI0z3yjZ8yr3jhXv3i6AxyE6vzqgCOS5a8yrq
         h+0Q==
X-Gm-Message-State: AC+VfDzHm9yiss38xgEI0raV75TD5a0NrulN/6dNSfGh6zOPthDZFXWL
	/CwOuD1f/gKx2aRd3aB1y6csXVfEotMe+jIXID3BRA==
X-Google-Smtp-Source: ACHHUZ70Pz7lCCxloiqFX+oT7PdbBee89J8lrEPrfstPcbrw7Tgn2jrr9JGIkkGqvKk3lsrk8VGfXA==
X-Received: by 2002:aca:1817:0:b0:396:4977:e148 with SMTP id h23-20020aca1817000000b003964977e148mr6529971oih.9.1685924559235;
        Sun, 04 Jun 2023 17:22:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ji20-20020a170903325400b001ae42480c82sm5176141plb.226.2023.06.04.17.22.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 17:22:38 -0700 (PDT)
Message-ID: <647d2ace.170a0220.2ec25.884c@mx.google.com>
Date: Sun, 04 Jun 2023 17:22:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1301-g6369cf0363211
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 12 runs,
 1 regressions (v6.1.26-1301-g6369cf0363211)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 00:22:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11766

cip-gitlab/ci/pavel/linux-test ltp-ipc: 12 runs, 1 regressions (v6.1.26-130=
1-g6369cf0363211)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1301-g6369cf0363211/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1301-g6369cf0363211
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6369cf036321117aa7bd9be009c3b7107cea2007

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/647d22be22af89c46bf5de58

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/multi_v7_defconfig/gcc-10/lab-broonie/ltp-=
ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/multi_v7_defconfig/gcc-10/lab-broonie/ltp-=
ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/647d22be22af89c46bf5de=
59
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31) =

 =20

