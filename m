Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263F5C77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 23:29:31 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
 by mx.groups.io with SMTP id smtpd.web11.17.1686007762239928551
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 16:29:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=R1kfWADh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.176, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-39a50fcc719so3762815b6e.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 16:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686007761; x=1688599761;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gcnh8B5ckuw05pGEJS51I1MGChtrKXtd31hLnOzYS3E=;
        b=R1kfWADh7rZHymLB9c9Q4e0MBBJ+is9Yck+i47GlQD3txnOvABx2MDCNtADXlWsNAp
         JMdLXPjDPHoFeZyleA6azM3RP01RubClva5ZhYSOur9IRAnHDGGYdNs/aHp9RcKkiElY
         lNy+/zIGyWNFeotQpItHz5KYaVYbtLQjhsfRfi5I+Lk/yrr03n7JaFzweKwu16C0Rl60
         DjnGRfPxizOFhd6ByBUQAJb7Z1Cntpqgtye70CSuaf1kp2cPcZrjDJ196IOKtyTtwRcQ
         9Qvm9akddXviOYUqfmTZX0ujd4kCmPnjPuCIyuQhK/d71uxv0jU6dQhGBrd0hpkVvt0s
         Hgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686007761; x=1688599761;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gcnh8B5ckuw05pGEJS51I1MGChtrKXtd31hLnOzYS3E=;
        b=EU4TCYgACDOQZDPzR+qCKCcMGyootGocOcm6plzA/Gqhzu5Dg4pxqfsJkp5Zg3EXct
         Za6Bq9oXFnVzIeLH3U7VJetjAmQ1bhudFj2bdnHTvWLR1+UWmxsCOe/q/gH9LuWYSYye
         hJBByWXepIAdS+ZJXxWR4CfOdsyvN+sykZeIU3cfeVspv5cHxdajrvzV4OHutcQ/qVbL
         kLTlu3AO/P+dg+7RDokjdIv79VJKnx50M9ZWqTTu3jq6K+lp4oKcD2XUvWT+JizeSUwB
         j8jJu6iNHe9JM4Q6n1RE5lAVmTruapMVFIiuCU9fI+uiZQi3yUuNge8YDpael/JnTFp+
         OhWA==
X-Gm-Message-State: AC+VfDy09re8UOrcRqPMs2BQe2BojpLpjWqTM3y2XQtnaEsGJq4RoqZO
	WlHAH+NnKCPCnShAdRFa7eCwx4Cy3h77dQETtraXrA==
X-Google-Smtp-Source: ACHHUZ5A+iByNod3TvF7gxZuiWvHvHRi0yvE7BOU6NOj5hQnWwx1zRlKh53qbKRpg4pd49bQSrzsDw==
X-Received: by 2002:aca:d0f:0:b0:39a:bc50:db96 with SMTP id 15-20020aca0d0f000000b0039abc50db96mr78439oin.41.1686007761219;
        Mon, 05 Jun 2023 16:29:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w20-20020a170902c79400b001a980a23802sm7148430pla.111.2023.06.05.16.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 16:29:20 -0700 (PDT)
Message-ID: <647e6fd0.170a0220.44a4a.c9d3@mx.google.com>
Date: Mon, 05 Jun 2023 16:29:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1314-g1ab0ac1d7e2e3
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-6.1.y-cip baseline-nfs: 56 runs,
 2 regressions (v6.1.26-1314-g1ab0ac1d7e2e3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 23:29:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11829

cip/linux-6.1.y-cip baseline-nfs: 56 runs, 2 regressions (v6.1.26-1314-g1ab=
0ac1d7e2e3)

Regressions Summary
-------------------

platform    | arch | lab         | compiler | defconfig           | regress=
ions
------------+------+-------------+----------+---------------------+--------=
----
imx6dl-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1      =
    =

imx6q-udoo  | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.26-1314-g1ab0ac1d7e2e3/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.26-1314-g1ab0ac1d7e2e3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1ab0ac1d7e2e3aeca50f8616b469772a5f010acc =



Test Regressions
---------------- =



platform    | arch | lab         | compiler | defconfig           | regress=
ions
------------+------+-------------+----------+---------------------+--------=
----
imx6dl-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/647e657de060d7cfe7f5de61

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
14-g1ab0ac1d7e2e3/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-i=
mx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
14-g1ab0ac1d7e2e3/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-i=
mx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647e657de060d7cfe=
7f5de62
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =



platform    | arch | lab         | compiler | defconfig           | regress=
ions
------------+------+-------------+----------+---------------------+--------=
----
imx6q-udoo  | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/647e65a5d2a29b9b58f5de27

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
14-g1ab0ac1d7e2e3/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-i=
mx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
14-g1ab0ac1d7e2e3/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-i=
mx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647e65a5d2a29b9b5=
8f5de28
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =20

