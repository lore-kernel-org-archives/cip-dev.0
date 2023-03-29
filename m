Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A7DC77B62
	for <webhook@archiver.kernel.org>; Wed, 29 Mar 2023 16:30:36 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.1106.1680107426401083120
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 29 Mar 2023 09:30:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=08YRSQh0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id iw3so15470940plb.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 29 Mar 2023 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680107425;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fA11Vveg39cVyexk3wtkgDHKk9rKue7XrZojfu+t1ck=;
        b=08YRSQh0RtUR2GRchvSgtMw/S2LEQgaKz1UchRkWM60XxTzz0+bKQMOW5P60uTm8KA
         ihOj7ntv5L6Kf6fwlEM2xEoVl0zgaWe+D2nTK1uyR4Ux4JsNoILPSGIJauxmc60+tlmm
         HpfrcVvvb3PBY7gDjOX7S1uUmR8BilUIgiu9e3Ob9umDcuf3nNdRX5+RsnGQZsBrLSug
         uH+7q2Md6fKrQ6QONYn2gAflaWUf6iL5eGclrAD6OojciB+npxhbSP/u+LW2UIkxv0it
         GgwEEcUuMXvgt44p4UIzkCdXI151iUeftfIah8FkMNhf8TbkOn+27k/T331/J9gRVG7m
         HCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680107425;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fA11Vveg39cVyexk3wtkgDHKk9rKue7XrZojfu+t1ck=;
        b=nN0uYrsYVp8XjwBQVGQl4QTr0K9+zyuwuluzybwyzN/ak++dV+4yx2N+p3bF8Fvc69
         BWzrU8RQkUcOBufLWgd+onZzMBS7b0K14ewOWMZV0PQbfpGamgL52HVuyxTUdoSx+ulX
         0/qLtRHGvl5alpEC0sQe+vvQ91SvvQuX1omfkj6OxHlxUtHGJqx0hVeRHJ9Bppd91FT5
         o1ACELGFwTvMMOFvYDkLKF8fegcvv6BwR4iBXMhAGAAOC904f6WEopMj1b9cQttZ8Kt7
         NZvR/V1+NcJWbRXRB8z82v6DsbSvDEwB6bcpSp76bpeY6roan+CFTwQ04XaZhWznSTjv
         uzgw==
X-Gm-Message-State: AAQBX9c4AYmK78loi2XsRdd3bcdhD87t6RS9hPDuDz+wAty0E8Vnn4Ox
	kGJsME289fUNwUgnBe+4ndoJhkA+bDomZ/wTSI+tYg==
X-Google-Smtp-Source: AKy350ahGgzqIPsRy/r1s3jdO1CrGhnScyZ1PpsyfOkKSAiBxpnTkd+rdn4aaDePiklTdpHtd/dqYw==
X-Received: by 2002:a17:903:644:b0:1a2:7d:8a8d with SMTP id kh4-20020a170903064400b001a2007d8a8dmr15613527plb.57.1680107425737;
        Wed, 29 Mar 2023 09:30:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902b18e00b001a1ccb37847sm19044339plr.146.2023.03.29.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:30:25 -0700 (PDT)
Message-ID: <642467a1.170a0220.e260a.2872@mx.google.com>
Date: Wed, 29 Mar 2023 09:30:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1097-gd51b0e04681f
Subject: cip/linux-4.4.y-st-rc ltp-ipc: 6 runs,
 1 regressions (v4.4-st20-1097-gd51b0e04681f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Mar 2023 16:30:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11129

cip/linux-4.4.y-st-rc ltp-ipc: 6 runs, 1 regressions (v4.4-st20-1097-gd51b0=
e04681f)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1097-gd51b0e04681f/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1097-gd51b0e04681f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d51b0e04681f73604e7ebc991f6a63833a70d3c5

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f41e8a2fa6f048d456ec2b136db9af50c7e42de8 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642452a04a049742c362f793

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-gd51b0e04681f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-gd51b0e04681f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230324.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/642452a04a049742c362f7=
94
        failing since 70 days (last pass: v4.4-st20-799-g1229c813bcd9, firs=
t fail: v4.4-st20-821-g39bdf0444b23) =

 =20

