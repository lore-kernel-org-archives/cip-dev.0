Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E082FEB64DA
	for <webhook@archiver.kernel.org>; Wed,  5 Jul 2023 11:26:35 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
 by mx.groups.io with SMTP id smtpd.web11.14614.1688556394443972291
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Jul 2023 04:26:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=K+Ublx2Q;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.50, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1b38121a011so3257300fac.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 05 Jul 2023 04:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688556393; x=1691148393;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c9B2QTQWGHXMqmZDzLXwR59OgE7ee36HqqZUzIZHviQ=;
        b=K+Ublx2QXvO8qYew+gVeIzzC5oMfb6iUW+dwUP9EUb2TXWiIt6xlCTI8zM7tqhf2Ef
         2EnClqjjFEvjJcEStc6HQtGXAYtgIFF4QS5kgPvlQwgGG0hqLvRDlRngorXTvgx4ybgK
         D4z2MoEuoIjGipP0VZ9/6UavVlTlp0mit88cUsZWdjJgDs3IjxHOc5BhtKyB3CNDiQLJ
         ARFs+prUlZubFpCzA32ARePw1YNHQW5ItzNzkwgSynhpqMaY0gSEfrov9ZPpAAIe/ZdF
         KyFj5dxFojtjpkRCozfYT//UP9nVr560f7nlKG6xG6AacgUTSEaOMo2JkvOE2b4icnuG
         dq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688556393; x=1691148393;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9B2QTQWGHXMqmZDzLXwR59OgE7ee36HqqZUzIZHviQ=;
        b=ffd/RtMZVDBXATZvZ7l7DtYPu0tbiYAnEELe9hzJeNA4wD3dDWNpEMhcdsjLa1asOA
         I1C8/CWUI61+3C2mFwH+4JQkVmN4PUOi2mgBW1CJiFn/JZpSkiU/kuWpzrpDbyV/hwGB
         Sd+XIbMFXN/QylFUa/8OeWC6iVuf8fQ1wHTvfQmaStBqIjP/Q0n8N45LFNXCHbISKHTP
         ZAm9R8VdGjjh9ZENj8oDYjq3/UBKA6P5gV0alEjwwzNBNdD2zyAP1gsquyxjxQ57HQ/3
         kKQ+4Eg80ensvgU+5vAw+WAKw7CQBSYFPVEBXt342F02qt8/kERfajFkuEijyQa9s3dn
         2aQg==
X-Gm-Message-State: AC+VfDzS0Rxd72HzBk8e2vaCJ1NtuSdwDG13nKpL/3lnlJWUwjvTEoFi
	yMu2YmqeJaQYpehNfl4yuPDHbhz+kzvzW06F5LG/0w==
X-Google-Smtp-Source: ACHHUZ5MoPWiXpKEAZtdt8oHrEF3Wde/th4p33Bb2N/QWAiubCHeCo+/ooCEMwPt/IE2UFa5HV7sEQ==
X-Received: by 2002:a05:6871:28c:b0:1b0:67a9:3089 with SMTP id i12-20020a056871028c00b001b067a93089mr14653922oae.57.1688556393013;
        Wed, 05 Jul 2023 04:26:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z92-20020a17090a6d6500b00262e0c91d27sm1303518pjj.48.2023.07.05.04.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 04:26:31 -0700 (PDT)
Message-ID: <64a55367.170a0220.bea13.2a64@mx.google.com>
Date: Wed, 05 Jul 2023 04:26:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-1430-g2fe294a51ca0
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-st-rc
Subject: cip/linux-4.4.y-st-rc kselftest-futex: 4 runs,
 1 regressions (v4.4-st20-1430-g2fe294a51ca0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jul 2023 11:26:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12234

cip/linux-4.4.y-st-rc kselftest-futex: 4 runs, 1 regressions (v4.4-st20-143=
0-g2fe294a51ca0)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1430-g2fe294a51ca0/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1430-g2fe294a51ca0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2fe294a51ca02b301704e4ab494c690d4b6342b1 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a54402a8274d3bf4bb2a77

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1430-g2fe294a51ca0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1430-g2fe294a51ca0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/64a54402a8274d=
3bf4bb2a78
        new failure (last pass: v4.4-st20-1307-g20af3740f4fc) =

 =20

