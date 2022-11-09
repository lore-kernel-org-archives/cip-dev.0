Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F17EC433FE
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 22:47:56 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web09.107.1668034072167325190
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 14:47:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=yDSZYcI7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so3227680pjs.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 14:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PXCB0PqPFhsSjHD+69CITeXqBRGoyFRVIGDawnORIyI=;
        b=yDSZYcI7/H9+QYQv2lZVf2f3wH13Ac/NLGalifpEpI69Xd+9ox3XVWoqF27RuoTRko
         prv6JiqvsjoAR0uUtfeY5NU05WM5zyRnJjoBF42mUKALxw0KWqyBTPg5PXWDxpx7ARyj
         6tpgJ3q5Xf/7M4SZb7Co+vJ0zW6tok/bgZpZEQvXB7t2lLa2CTSjDHSiswaW0jd2L38/
         NBJ1LySCnrPZT1MJ5foHfmLWRpUrETonLDGx9g559STbwIDd/K7fmLKA8D05DeAG3xbr
         pmMphuOI3gzjjlfugiUGrWM4mIxMe132x4tChz1KGC3OtiFTiJkBH8jARwRDPMndXo1u
         5byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXCB0PqPFhsSjHD+69CITeXqBRGoyFRVIGDawnORIyI=;
        b=waUCNymzhhX47343OG/6xgUxLLV3uGlpXykL5auJl9SROogQ+95ZjjtNNb0MGBdkQP
         7nUCfmyuwWRgQ7szuein0tZAe5Bk7hMQFtJQ0ujWJUQiYP8q6G4Nl50v5y+OopK7KrfP
         66tFFXEVR7MdSeHKDJG00gSc73UlPHfAdnsl8aV5tRUCi618LUG+iWIuqsPF0W1fK0sK
         F+UKenFbuIKb4tCXpn1a1xaHQKyEIAnxi+51fPUk1k5G/04lqdj7Un1wtJQhqOBy8TPC
         KSoi5xedJF0LlIYC+qcDvK7QZFEQB6nYkR2Cg52w/vdDrYRoVqwUo6YcmhbfBgdhiyRd
         D4bQ==
X-Gm-Message-State: ACrzQf2ylCeTS8Un7dAlBw6KkcDxKaWfS8irTCxy7wSY4x1iwIP/amve
	J9UXrG2ac3tMDk3Y/KzCxXmK2/qj2yF3YapQlVo=
X-Google-Smtp-Source: AMsMyM53zVg+YuA2ySs0T7XAfRqbSjpGRRN8xC5CLAzLbCe9Iw6Y4Wn4y4ECc5Noky3z94vgV9nIKQ==
X-Received: by 2002:a17:902:f691:b0:187:466a:8975 with SMTP id l17-20020a170902f69100b00187466a8975mr41265054plg.59.1668034071406;
        Wed, 09 Nov 2022 14:47:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902ea0100b00174f61a7d09sm9735494plg.247.2022.11.09.14.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:47:51 -0800 (PST)
Message-ID: <636c2e17.170a0220.fbf96.058d@mx.google.com>
Date: Wed, 09 Nov 2022 14:47:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-rt8
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip-rt baseline: 216 runs,
 1 regressions (v5.10.153-cip19-rt8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 22:47:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9986

cip/linux-5.10.y-cip-rt baseline: 216 runs, 1 regressions (v5.10.153-cip19-=
rt8)

Regressions Summary
-------------------

platform              | arch | lab          | compiler | defconfig         =
   | regressions
----------------------+------+--------------+----------+-------------------=
---+------------
at91-sama5d4_xplained | arm  | lab-baylibre | gcc-10   | defconfig+preempt_=
rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.153-cip19-rt8/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.153-cip19-rt8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      4b5bf35ef58ec8f9f73fd6fec577de2f6710955f =



Test Regressions
---------------- =



platform              | arch | lab          | compiler | defconfig         =
   | regressions
----------------------+------+--------------+----------+-------------------=
---+------------
at91-sama5d4_xplained | arm  | lab-baylibre | gcc-10   | defconfig+preempt_=
rt | 1          =


  Details:     https://kernelci.org/test/plan/id/636c22fef8ee338154e7db6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/arm/defconfig+preempt_rt/gcc-10/lab-baylibre/baseline-at91-sa=
ma5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/arm/defconfig+preempt_rt/gcc-10/lab-baylibre/baseline-at91-sa=
ma5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/636c22fef8ee338154e7d=
b6e
        new failure (last pass: v5.10.109-cip5-rt4) =

 =20

