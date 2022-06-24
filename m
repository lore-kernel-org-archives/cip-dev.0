Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28F4C433EF
	for <webhook@archiver.kernel.org>; Fri, 24 Jun 2022 17:14:18 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.10359.1656090853946558509
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Jun 2022 10:14:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=jfkMU5js;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id
 p3-20020a17090a428300b001ec865eb4a2so6378295pjg.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Jun 2022 10:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=aMS96vucNYxLlkwDUQW4zrEj0wF4Kp7QQFzH7pceMvk=;
        b=jfkMU5jsgUW1+tH2KVAwomYjxhAiV4cEcWMBBE1z2ziNgSMcV05nXOacTH03u4SxMe
         Wby4NESTOx1kHU5Km93H0vBWYvzZno1ihi+S2wqh+3oKqoBUlbnUoLykKlbXJyVN51FZ
         /M3H6O2icFcmtiHhbk9EwOr8/YLn8qfrbKociC8HotnkhdDN8jeecid4TP0rWnC+UiBP
         +UxjOqlzZGJlbIL0TpwkBlrDgOP07ralCp4HbiAJeZlwAohq3noqS4GD40/fIhXoqKZH
         fegDx8MjHRb5qdx81B8d2T5q42IIVQBsiS+bwm9T8IN0aMJxyA/vBcEnSPxG1TfgSHez
         gneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=aMS96vucNYxLlkwDUQW4zrEj0wF4Kp7QQFzH7pceMvk=;
        b=5MamtJaCoGGbTPjYwwLkabMF9wtYcRsJ3JbYjVe9WAMo4fFg3Bzm9047IhDlSnzUKQ
         zqRkM6bJS0K9xcZVDf98dBqZwV7J24Xx2BbYqInbgQZvUEXfg2iX4T3cDWp2urZWaMrU
         64K6ME1avu4riYxpSa7IB8DsRBl7zq6VGD1CG66R3jt03FTy1Oak9Zfr5mbo28OuYy/g
         IY/WM/NMcmN4dcDmI3t+Iysh8qVaDGKjkPEZBnzIFbzV+ga45dVyt1nGUkI9ByEQ5SkS
         E6csRNWj8jg95D1Tj6QMLI0z0L8Vg1v0dmhgEZEDRJlMd8PifXMUhuvfxcUGo/L81z4+
         HVmA==
X-Gm-Message-State: AJIora+on4JIoIdEQUIUnTPvHQjq9SdcmI0dcer/jIe8Yjs4ETXfAN4j
	3CyGPNP3q3A+4QvCvtLV6chxWCh/6mXMCdVwEkg=
X-Google-Smtp-Source: 
 AGRyM1v6NtwgORb8i7/hpCmiQ0XowiyzMxCSF0mm97uvtrzhKSV8p1PmiOTJPpVp9eInSpMmcmX/uQ==
X-Received: by 2002:a17:90a:d148:b0:1ea:4e16:545b with SMTP id
 t8-20020a17090ad14800b001ea4e16545bmr5317003pjw.132.1656090853318;
        Fri, 24 Jun 2022 10:14:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 i72-20020a62874b000000b0051b9d15fc18sm1983338pfe.156.2022.06.24.10.14.07
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:14:11 -0700 (PDT)
Message-ID: <62b5f0e3.1c69fb81.e0b53.2c6a@mx.google.com>
Date: Fri, 24 Jun 2022 10:14:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.121-cip9-272-g3fb28d4c623b
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 10 runs,
 1 regressions (v5.10.121-cip9-272-g3fb28d4c623b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jun 2022 17:14:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8597

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 10 runs, 1 regressio=
ns (v5.10.121-cip9-272-g3fb28d4c623b)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.121-cip9-272-g3fb28d4c623b/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.121-cip9-272-g3fb28d4c623b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3fb28d4c623b354373a844dd48f16cb4f005388e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e98f9465925434349d0aa6eb71e81b5464e76df4 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62b5e202dcd1300db4a39be2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/arm64/defconfig/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/arm64/defconfig/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220610.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62b5e202dcd1300db4a=
39be3
        new failure (last pass: v5.10.118-465-g0af29783a3c9) =

 =20

