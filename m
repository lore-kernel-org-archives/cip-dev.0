Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9951C63703
	for <webhook@archiver.kernel.org>; Thu,  8 Dec 2022 16:20:47 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.18704.1670516438786426640
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 08 Dec 2022 08:20:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=mFLMaJIt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso2059332pjh.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 08 Dec 2022 08:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vC/321rauhxZ5hVyKgAnya5gRcleZD4IynhvqsVBpQg=;
        b=mFLMaJItOKhgpP5/gi7GM3GSbdkehm1s0PK5CDHrXT4QKtj/3j9xvnqoz+Xhx00CoF
         g+pzsTffQd9csBSAKcNIKu/Bm7FNGS8pyPDUXhLAgjXrkj/MadH+ArFqUDDLA6vF+FI8
         5y1jiFfohBqHkkp5uGpi1Oo2u4MzE3VvqYyiQRcKsEU41lrnZp/YqpkPAw5RDQ29Nza/
         tc8t+hnaIJY89V5Kx1tpjIVh3M7vVV2c7tFqMyBiHJ4WsYnWmEomf7s9bqf/drnoKgfV
         pmyf2hgDd9GZilFJywtVm2SU3c7A5/zhYMnGra3MwXT7GALqD6zQ3H4/h0MJER+GCRFr
         /Wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vC/321rauhxZ5hVyKgAnya5gRcleZD4IynhvqsVBpQg=;
        b=Ldm6FE02UlMNdJyPQznx6f3xMLy5KCBnyYTuWFi5levtQK2TINONJXGIy1SHxqJ/j0
         rdQAXd8fivBNN54y+5ZUPLaOBElKPpOG6eniAY5n/K/TN5UbqnZyuOAcm0VOlwQHFcTB
         rLERX9tkyvh6HXL3wVHJqNGSPOZ8yRN8vs9EwwyVz+VCjky0b57380LBIUO/eh+v6q3V
         xupvWmZ21QibuSt5pE7iMcTwZLXtXCEKCP3yX55iYtyDW13XI354MbL1bLFXWo5rRA76
         Kf//7XdMW0q2Ze+L5003FUxq0J8+MhqXfBt4z3dQmIY9t/B744mEpGCdIQ1Frycs6+OA
         VbYw==
X-Gm-Message-State: ANoB5pkdStchoR3FV8+d+Mwyd+wVUtkheFIb0DbuuxSo45urFLbm7hQx
	xFb5lnECiskEYuoofUfZjRyYhCghxlHklABavec=
X-Google-Smtp-Source: AA0mqf4zFBS40A4le+mH1ZR0+174thSu7zdkTXnhTroA74Zt4O/aOlQBeSJbapRVDQpBCVVOOArCig==
X-Received: by 2002:a17:903:22c5:b0:189:f708:9b67 with SMTP id y5-20020a17090322c500b00189f7089b67mr3430201plg.46.1670516437959;
        Thu, 08 Dec 2022 08:20:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902b41600b0016be834d54asm16666868plr.306.2022.12.08.08.20.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:20:37 -0800 (PST)
Message-ID: <63920ed5.170a0220.58f8.01cc@mx.google.com>
Date: Thu, 08 Dec 2022 08:20:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.155-cip21-405-g26d566555c3de
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 7 runs,
 1 regressions (v5.10.155-cip21-405-g26d566555c3de)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Dec 2022 16:20:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10170

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 7 runs, 1 regress=
ions (v5.10.155-cip21-405-g26d566555c3de)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.155-cip21-405-g26d566555c3de/plan/kselfte=
st-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.155-cip21-405-g26d566555c3de
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      26d566555c3de5796328380cfeda5b2372f45010 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6391ffe6b443bb7a1c2abd06

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.155-cip21-405-g26d566555c3de/arm64/defconfig+kselftest/g=
cc-10/lab-baylibre/kselftest-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.155-cip21-405-g26d566555c3de/arm64/defconfig+kselftest/g=
cc-10/lab-baylibre/kselftest-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221202.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6391ffe6b443bb7a=
1c2abd07
        new failure (last pass: v5.10.153-cip19-122-g149fbc7cd21d) =

 =20

