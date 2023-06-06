Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7CCC7EE24
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 13:44:21 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.304.1686059057379423660
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 06:44:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=WdpizHhG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-650352b89f6so3141464b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686059056; x=1688651056;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3RoxBtwXDo/vD0QMxltoZ9hJ4GkaNOwEjKmw1AWjfEI=;
        b=WdpizHhGdV2lFl7m8DhGCa+qPzGXzBd1oBhktD1S2t3J2YWCnq9eexDw6pbKAdQSgs
         dhxtGd7DLgLOPm3iBm6o7rqbi27c6m1x6TnV9lxcGBBA3LACAyyvhXbZaABlJZihVigb
         n9S3h53c7j2inLKyvU56IC/5a9xhK2ICYpkUHRT9YW18vhV30CyeWvEZvpkP9p4V8r7x
         /AKD/skLWTio7Tv+CwwTPQ8uX4Bo6NnBv9c5l41pkUEK55VJVl46KcljyOAzelhlh5RC
         BUsyE2rRqfAgnt89F30effF1bvJkIAv2xy/tImfqf72GFz3ZUTnHRZXzIgKVX9Zi7bKe
         LlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686059056; x=1688651056;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3RoxBtwXDo/vD0QMxltoZ9hJ4GkaNOwEjKmw1AWjfEI=;
        b=aBbY6m7N0ljlYcC/RXMQBhLbP8njhozBQmJbbBcpNmyg2UrahVEg1rUjGjB3Fov+OE
         +9bQyeWP5vBU9JfotTItJjY2vryxcoCt2Ued6kt2s2hDYcJsdXvtKtu6lzzohqQqdSeV
         wxCpY9MR6Lt6NYu9InTeUL4f8hu4AQvai1hRN9xvQ2Oz5ozjG5iApBRA7NCM7n0IfCG9
         B9mlWOr8MeMPcHF33RRFuMJG8Idv1EXHyiY48vNXPSP6GPQLzqyPrsWSqbATyzrOTxyl
         tDoVz2IrUIPgtGXPVms7WntfKQeiDslAQy9VdHNHzGq92IqcFSEKrmAp7bkwPTBspX0L
         hg/g==
X-Gm-Message-State: AC+VfDzULD/3TplKy0zMOu39qX2w+3vBkedLQnMbgpsBtpm4apycNoa1
	ua6nSDha+z8JQMtr9Y7ClR5cfrHidA4DgamXS1x75Q==
X-Google-Smtp-Source: ACHHUZ4PDaBIgO8gQ3IQxawFJaW2Pz653rZVOIHZIhv3m+eMl0Jt52DKLCWs7QngN9wGJ1BTEXAF/Q==
X-Received: by 2002:a05:6a20:8f1f:b0:114:6f3c:4332 with SMTP id b31-20020a056a208f1f00b001146f3c4332mr1060503pzk.24.1686059056441;
        Tue, 06 Jun 2023 06:44:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902758600b001a260b5319bsm8550356pll.91.2023.06.06.06.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:44:15 -0700 (PDT)
Message-ID: <647f382f.170a0220.147b6.fad5@mx.google.com>
Date: Tue, 06 Jun 2023 06:44:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1320-gc38e4a9845945
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-6.1.y-cip kselftest-filesystems: 8 runs,
 1 regressions (v6.1.26-1320-gc38e4a9845945)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 13:44:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11888

cip/linux-6.1.y-cip kselftest-filesystems: 8 runs, 1 regressions (v6.1.26-1=
320-gc38e4a9845945)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.26-1320-gc38e4a9845945/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.26-1320-gc38e4a9845945
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c38e4a98459459f32d3c7c627ff35defa2415935 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/647f31a863613edd38f5de2c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftest-files=
ystems-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftest-files=
ystems-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/647f31a8=
63613edd38f5de2d
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =20

