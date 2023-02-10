Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A01C636CD
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 11:48:25 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.12357.1676029702466436471
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Feb 2023 03:48:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=DaAYcP/g;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id b5so6199743plz.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 10 Feb 2023 03:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DM2cf/i3OR/ivw6IdLXuNDZa+NkKyMvffdXpX+gfseU=;
        b=DaAYcP/gJbmX9+uyife5LZvS9K1uon0qi5wZ+ebtKH04V/g0rF/Z6bj11aHqiEwUzU
         /tkS+rhjVeQsePrkCNb6DzJ2KgRckUwU/GrXcL6nukoyuozH8tsN14gKueI5L5lutVuM
         U5ZffOpSpcTWwaZpsFN9rGVcaZgLjPSdvf0T+zBJkV/6X30/w4kpm6RyICOHcUJTBgfK
         9IF+LI9vXJ3oH6GdrFvCOZlZLyu8zfqeuagNtxeOnFVXTCpn7Iavl6OJS6BXZNfG0TrM
         tYqAq8B/+t49OdjljI19Zvra2UCAZY5MVSQ4pvkZ3Kw9JtnODeG0j55dZ5j65GXJtn4E
         U5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DM2cf/i3OR/ivw6IdLXuNDZa+NkKyMvffdXpX+gfseU=;
        b=JvT6S72sEA6JVs78TV1Kwm/3VOtSWPx+6AnQPr0yEz/ILZG9fxjJGJXsYRKbBHeg+q
         dcvsQJJ24u+NPXA6HvnC7lA8MPIImTy23eJ8IjLyFCHlpCA7ioGZoMFF72qCqAo+hPMy
         nXKy2/h9hF6NGUouKBDQ4RUZFkpXgeUA2DgBp8neSoGypq8S8C8ePSbgzOHzsmxpGR6J
         pUj44hQwy+tIYFc4BT0CmlBM2lnf7kWdj8kh2cHhtWcjeUFws/HaQgwvCZRNHmgZjInl
         RVBeGBvBoXm+q+4q40gwl9X58COQm0RnNN0/ppgUsBL2LLmyhHJWGDWEGsU7GBTVM+WT
         hV+g==
X-Gm-Message-State: AO0yUKWLl5hHdL51bRvQOTL9nCrCi9979otZnfehQOvVTpW1a0W+dOim
	cAcPm+s28Dg6hGv6X1glc/HL1G4ipkSAq+V43D8=
X-Google-Smtp-Source: AK7set/q7qY09cDnj1JcuPhN8YJNBwrYW0wYdUuUqffpa9EGPMSujBocMaoypnUOpgbIkA8qUtftBQ==
X-Received: by 2002:a17:902:c994:b0:199:73f8:d4e2 with SMTP id g20-20020a170902c99400b0019973f8d4e2mr5726665plc.38.1676029701768;
        Fri, 10 Feb 2023 03:48:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902654200b0019919b7e5b1sm3196089pln.168.2023.02.10.03.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 03:48:21 -0800 (PST)
Message-ID: <63e62f05.170a0220.ce2e.5d01@mx.google.com>
Date: Fri, 10 Feb 2023 03:48:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.272-cip91
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-timers: 6 runs,
 4 regressions (v4.19.272-cip91)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 11:48:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10647

cip/linux-4.19.y-cip ltp-timers: 6 runs, 4 regressions (v4.19.272-cip91)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.272-cip91/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.272-cip91
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a308535fd0f82d23c6acc4bb20c69066ca01bdd6

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  7b5ee038995273bcb614321dd1112311e3b7e8eb =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63e6249767d8e3c3e28c865b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230203.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e6249767d=
8e3c3e28c8660
        failing since 75 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e6249767d=
8e3c3e28c8660
        failing since 75 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/63e62381de6d2827bb8c8634

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230203.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e62381de6=
d2827bb8c863f
        failing since 11 days (last pass: v4.19.270-cip89, first fail: v4.1=
9.271-cip90) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e62381de6=
d2827bb8c863f
        failing since 11 days (last pass: v4.19.270-cip89, first fail: v4.1=
9.271-cip90) =

 =20

