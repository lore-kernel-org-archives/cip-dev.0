Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DB9C4321E
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 15:02:41 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.8555.1665500558532838432
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 08:02:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=dFeoiN84;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id
 a6-20020a17090abe0600b0020d7c0c6650so613063pjs.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hNsT44dI4AFBR+pHhvv6N+b3hsSZvv9DvnM+8w5Cw1A=;
        b=dFeoiN84C7FuNJ8VIpPA7pkFrrzAbyo8eTJHleGuKDhVD/wnMrzI3EfulZtTinialu
         Qb+3FS53SibfGTd20ezhizuUbFh72+ISB9/HuZX82up/GGTtHRLPWP5vsnU1+aX0lQlR
         qF7q/ZqWSHVYEJ5pbx3PsbEFXRkZI1qQ7VOO43UvBz3WXjmKYp4Gp3/fr0HK0WRp/BuF
         lq0S+rJcC1GykERdja7e47LbewycxwSEenBdUsmQh8cCOn9bfFKlmDGA4TVnEqSH5zHh
         CYqll+V9652AjA1m23/mwV/sLm8teVCc2j3yYUqivwPRTz05H5gytXalUyAvMyOfCdAq
         nxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNsT44dI4AFBR+pHhvv6N+b3hsSZvv9DvnM+8w5Cw1A=;
        b=4RKUF2JvL1puTe1MJaSEFTllWce/dHUrlUORxAxAo+N7qNeUmjceXzPuFfDQMwuC5i
         /beOWpQWnrRzLXo6d3WE4tbiE1T3SRzxjBEsPuAWs97D8O9hkV2jWOTUNcWQIxq6wWc7
         taBpHjvPhcubc22MFoPjWzQ40F/nKZGfcCle74n1eDAJi5BfbefDM3fXdLq2lXsa24qo
         ONVUc3NJ9pm4J6BqG0+BTXq3qs4VO1KO3xNF1ZCFA0K1gSilwsC9b0dmVyXKI0EYkCRa
         8Ohf3lzjT5e45QkPul01Eag+9nilmflLUr5Pr/QRwmptj/YDByQp6WWKIQ7iC+08O51f
         oYjA==
X-Gm-Message-State: ACrzQf3FpS7ZEK+B7KLnaTbtX+MBdV2Lpb+FoYInmf9ZWrdZOhf0EIde
	E3cO3tRN5Byqu3QWv+KTodvJBOGiq5G7Cw6Qu60=
X-Google-Smtp-Source: 
 AMsMyM7XczXyUBz8elU5UCcAGvImCKtB/7s7BHs07pIJriAg2lTiv/gtBlFxCkCmzHXeuVNnTFMt6w==
X-Received: by 2002:a17:90b:1b4f:b0:20d:363d:7943 with SMTP id
 nv15-20020a17090b1b4f00b0020d363d7943mr14437579pjb.106.1665500557823;
        Tue, 11 Oct 2022 08:02:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 u16-20020a634550000000b004308422060csm7857655pgk.69.2022.10.11.08.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:02:37 -0700 (PDT)
Message-ID: <6345858d.630a0220.bfbed.d648@mx.google.com>
Date: Tue, 11 Oct 2022 08:02:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.145-cip17-1-ge85493c8cea0
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-mm: 6 runs,
 1 regressions (v5.10.145-cip17-1-ge85493c8cea0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 15:02:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9727

cip/linux-5.10.y-cip ltp-mm: 6 runs, 1 regressions (v5.10.145-cip17-1-ge854=
93c8cea0)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.145-cip17-1-ge85493c8cea0/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.145-cip17-1-ge85493c8cea0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e85493c8cea0c5b53ef511efe088b0749b4d5aa0

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63457ea17fe3599c17cab606

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-=
mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-=
mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63457ea17fe3599c17cab607
        failing since 272 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

