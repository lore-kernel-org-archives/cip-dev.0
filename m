Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E550C433EF
	for <webhook@archiver.kernel.org>; Fri,  8 Jul 2022 16:46:10 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web12.1487.1657298767745489857
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 09:46:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=sQFYQfXl;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id e132so22804692pgc.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 09:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=NcyLiimxT2wTx/vja+TWYo4B2oqX4Gtb5C2sQRiRRI4=;
        b=sQFYQfXlYAdQQxORbkxDAwv+VhYBPxP/r005759YGYObraGxVyOrg+j9Rk1gJvJ+bI
         GFreYhcDmD8cVsu207HQSGXUNBpyj1t+ILCi8Qiaql/XMVm6r19WvPrOCEpXbjfC3vb5
         xwq7X7Yst44LmnZwPM0TAQE58Ji0sZZmUHd3e4aIymS1+n+PBlWjht9rs3RjRwxHwWdR
         ksThSzkb1WlTF3BoHfdSBo+BP7aEN5Vq67jRsGB0pHMJ+gYyf+ZdIhoHXp4gimPS8e4x
         JgaaZtfu4Tn0Nt+8r9/91At3sua7hjozic1bDP0Dwfv1yibR4FRmtsbtkIKESA7yExpi
         NRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=NcyLiimxT2wTx/vja+TWYo4B2oqX4Gtb5C2sQRiRRI4=;
        b=hF4udgFg20s8/wdfMHGCmusu6yeB/Ro5YmHLCqpwItPq7HKs9o4qMpB2C7SMi4zKNe
         ntyYkbOVRrKp6aqhRWkmN4Tv0h2qfNpmjLnx1TwYcsE6Y9/DrGwTRi4NQBybP+WqIJfo
         D8VXl9LnbNBKYoUpQX0KQwZsdxm6FyxEL2hxlHoXkpmNoK51DyQhB8EFWHwO/qQLDpSZ
         +HWmp4Ys0MMSjWQUfwOK9f81StBKgoMeI2z53zLAauP3GhALU1IadjaU5X6TgpmXdtV6
         fZiNJ2Cg7Dq9UaM2ZUIZmnh+n99UfYR/M3bZ0Q9Wh62ICs3ZGAnWKDF/D1kbTM2hU7bU
         Nwrw==
X-Gm-Message-State: AJIora+k/9BfwJl+id2zagBZmosbR9wg6BRwOEvKONGKFaleKwV+oiyk
	cW/AEkK0wR42ExZeBTqzLPDsZ8kXeX2y1pN1
X-Google-Smtp-Source: 
 AGRyM1vTMrNAWK6m68z4tK/popatxhpYnrmV1r+ssvTRUKCZ9mEy+6Zyh9Fp/EEHGk2Cm37kYsVbsg==
X-Received: by 2002:a63:5a4f:0:b0:412:6081:6cee with SMTP id
 k15-20020a635a4f000000b0041260816ceemr3955952pgm.246.1657298766712;
        Fri, 08 Jul 2022 09:46:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 p2-20020a17090a2d8200b001ef3f85d1aasm1868075pjd.9.2022.07.08.09.46.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:46:06 -0700 (PDT)
Message-ID: <62c85f4e.1c69fb81.64be7.3033@mx.google.com>
Date: Fri, 08 Jul 2022 09:46:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.249-cip76-57-gef3cc1b9e556
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 13 runs,
 1 regressions (v4.19.249-cip76-57-gef3cc1b9e556)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Jul 2022 16:46:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8724

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 13 runs, 1 regr=
essions (v4.19.249-cip76-57-gef3cc1b9e556)

Regressions Summary
-------------------

platform               | arch  | lab          | compiler | defconfig | regr=
essions
-----------------------+-------+--------------+----------+-----------+-----=
-------
sun50i-a64-pine64-plus | arm64 | lab-baylibre | gcc-10   | defconfig | 1   =
       =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.249-cip76-57-gef3cc1b9e556/plan/kselftest=
-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.249-cip76-57-gef3cc1b9e556
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ef3cc1b9e55646468f12d0c0a8caf8874a9e7156 =



Test Regressions
---------------- =



platform               | arch  | lab          | compiler | defconfig | regr=
essions
-----------------------+-------+--------------+----------+-----------+-----=
-------
sun50i-a64-pine64-plus | arm64 | lab-baylibre | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/62c6adc22a0910beeba39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm64/defconfig/gcc-10/lab-ba=
ylibre/kselftest-futex-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm64/defconfig/gcc-10/lab-ba=
ylibre/kselftest-futex-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62c6adc22a0910=
beeba39bce
        new failure (last pass: v4.19.249-cip76-54-gb41c396e258f) =

 =20

