Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41277C77B75
	for <webhook@archiver.kernel.org>; Wed,  3 May 2023 10:01:19 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.15163.1683108074867059959
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 May 2023 03:01:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=YKHxq0AS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-24b725d6898so3292948a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 May 2023 03:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683108074; x=1685700074;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IJ7RfqTKm+Z7WNsdpLqFi2FrAccsOWcFYlXBH0YoZ88=;
        b=YKHxq0ASuRQsHhImsD00yAb6Znm/LRd023eR4sYnzvYtXYeZx+G/VCtwxg/2Ismy3X
         LbUiJ8mjWleeCR2Lr2DYMdVALUPIYYBAg2ttzB1aGQSuhXdlCM1S/9SAoD5WQ3YnIQAE
         aFTVct59ncLGFb7UdPxCClDtBneb62x2aWtMgFQZyz9QhjZgCi97+AduuLSEDGXv4RQV
         QV2tBxQNqpzi0ai2O5c1U5qal9su2WXXq7u1pP+8BAHPC8VcIuZFV0bhWAe3DQNE26Jd
         knloZ1PxOyTAYaAneHq6NohaBoSWlvvibiA3SwGtErSiNb8T4QSBXniaTOrpW2cJ3HWi
         2anA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683108074; x=1685700074;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJ7RfqTKm+Z7WNsdpLqFi2FrAccsOWcFYlXBH0YoZ88=;
        b=iEg7bjZMuQSx3WlwrY0e2fWn64mjV1foHNHh7XS8Ys3zSVEKCdKGdObiTKGFkjVx8w
         WY4d3na73OTqLSP6jReAO2csnwHzXb6+TxA3KU9zWgd8++0Sl3TXpr/d9yO4Aw1qbVu0
         yzB1rQX+by1HIVcS5kpXPvX0OJNPflhjle3f3VsislX0d+PWguoHDIlau9WE28X2X1um
         MVGPwuNm2kAU1KG9HnFdV/KKNSeQZoPzdIQe9R0a9zMUIhThukyaoivK7kE8XnowB5S1
         iupVArW+f/c4hNGQAuGAyuLiUFMy22hfT4vhT5wd5zJrRip05fCQyyRtf0AoeyJzK8Ps
         Nj+Q==
X-Gm-Message-State: AC+VfDzfgimGd2UAXmO0G4E4ALbFoEfCDHxrj9ksy+HOQAqEgzitu9c/
	JJQFF3IeKLPUOP7ZGqSsWqXc4+dH6xbaTTMMc10=
X-Google-Smtp-Source: ACHHUZ6OCdtmMLzPhIXanZvJoXmf6Wh5J4QGQTFgsbcQb15K1YvMT9JRXAhPbOvvDjZFTwBwyE6uSQ==
X-Received: by 2002:a17:90b:17c1:b0:247:862d:a224 with SMTP id me1-20020a17090b17c100b00247862da224mr21261635pjb.27.1683108073587;
        Wed, 03 May 2023 03:01:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o15-20020a17090ac08f00b0024b79a69361sm985532pjs.32.2023.05.03.03.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 03:01:12 -0700 (PDT)
Message-ID: <645230e8.170a0220.9b754.1878@mx.google.com>
Date: Wed, 03 May 2023 03:01:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1186-gb629b961cbe6
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4-st20-1186-gb629b961cbe6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 10:01:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11393

cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4-st20=
-1186-gb629b961cbe6)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1186-gb629b961cbe6/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1186-gb629b961cbe6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      b629b961cbe64f7960f450588400468813a5f85c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ec58cf9bfb5588e6f831ee55aa6b10ebd790a826 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645223ea2fedfd6d8a2e85ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-gb629b961cbe6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-gb629b961cbe6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230421.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/645223ea2f=
edfd6d8a2e85f0
        failing since 34 days (last pass: v4.4-st20-938-gc773c630d0e4f, fir=
st fail: v4.4-st20-1097-gd51b0e04681f) =

 =20

