Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E023C3DA40
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 13:41:17 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.11718.1687441271452702013
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 22 Jun 2023 06:41:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=XANA63RL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6686708c986so5030465b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 22 Jun 2023 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687441270; x=1690033270;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aaOnMsrr5+m52PDbCQIolSoWeVkzD9oXx1ojvTy+624=;
        b=XANA63RLpwCrSWIeggxbOLG7/19pYJutM6rbIdxl1SGC71wOeTzw7dGDmbsM4j/QcO
         5LphSOxKMkfDsFJMpHJTdtHfv79ZjtKSqm4b41b/PgpeS36g5RP+F+LpAgXF1oILYlkE
         DgXN59FaCvmgS5iV6eOc8KKh2NB3+jOt7bznkGvBtGCJrLd4rpHr6QjcY7Buadwhowl0
         oyqEME/FzsTAA71OOvXboxZ3IHGEUfrAQFwiswMMeNvOYeZR5EeZguTsjdPRWjOSspCA
         nJs7EyKQouSOvHAQ25NaPoH++FIQsrU0WTbkPb9rTpcozs4uK8UfrC5WKBhz1za80HPZ
         MqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687441270; x=1690033270;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaOnMsrr5+m52PDbCQIolSoWeVkzD9oXx1ojvTy+624=;
        b=bAHzYLFfHmfNHYYEwV9AOLzBN7cI0nEUfDUVmyA+LOfaWEwkYOxnExHv88qpZMjksq
         g9WJmn+VkhoAqnF8lcWHTpXz14xTE4jqaguTywzp58gbBDBvOm4BHRIMCVb+Tbjbmv91
         7nYPSL63JIAPnujHSgqb7bwr4Yp7n9pmgY15f7xSwpvqImVD8Deex+Ap1MSHR+iPfqq0
         pqrR2l459iZMmanx8SDvE0Hkgx5r5BGMtSN3N4+N3pBUU3dokiulYiOUNaAhdMtUDPar
         wrlUaXItRQ+v7puWrnhCVbpdIV3iHLnZk6UjEdh0ORlq1u+AUDiSKZ5tRtYVfZSninZB
         Lkcw==
X-Gm-Message-State: AC+VfDyIrMIPPPbZQvRurihaFV2GDK5jmOeKp9zPhkNkTWp8We5mKZkR
	pQ0tZgvkg6h1AIHE4BRpqiCa8xS+NdasrKo5Afc6kg==
X-Google-Smtp-Source: ACHHUZ6VbzzrVJ9g2EU0cw/SfCAMu6hpnbapCUPKXztejw65x1rKBv7HQSKjQhu7/QQGafJSxs/SPw==
X-Received: by 2002:a05:6a00:22d2:b0:668:7143:50b0 with SMTP id f18-20020a056a0022d200b00668714350b0mr18888927pfj.31.1687441270213;
        Thu, 22 Jun 2023 06:41:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a15-20020a62e20f000000b0064fa2fdfa9esm4604731pfi.81.2023.06.22.06.41.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:41:09 -0700 (PDT)
Message-ID: <64944f75.620a0220.da66c.9d69@mx.google.com>
Date: Thu, 22 Jun 2023 06:41:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-61-g32a95f5a4e3b
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 8 runs,
 1 regressions (v6.1.31-61-g32a95f5a4e3b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 13:41:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12129

cip-gitlab/ci/pavel/linux-test kselftest-futex: 8 runs, 1 regressions (v6.1=
.31-61-g32a95f5a4e3b)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.31-61-g32a95f5a4e3b/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.31-61-g32a95f5a4e3b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      32a95f5a4e3b66089d84743bbec9da44020328ba =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/649444a2a2a65a7e8b306156

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/multi_v7_defconfig/gcc-10/lab-cip/kselftest-f=
utex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/multi_v7_defconfig/gcc-10/lab-cip/kselftest-f=
utex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/649444a2a2a65a=
7e8b306157
        failing since 7 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e=
9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =20

