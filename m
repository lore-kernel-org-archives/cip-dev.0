Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AA1C7EE23
	for <webhook@archiver.kernel.org>; Wed,  3 May 2023 15:01:20 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web11.21843.1683126076299007094
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 May 2023 08:01:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=nfHUT0+a;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-51b33c72686so3553589a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 May 2023 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683126075; x=1685718075;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pyBG8neBNH2MS46XhnoRQ+AQaEp8I2Y0wSLKQq9wLUo=;
        b=nfHUT0+ayL4GjqozOaqXuAW5RAS2C79AlP8lze+kD31D7a3YkCIp/NzddCXjqgJBe3
         1xFJbzBYmNt2dJbwy5sPI3iF+hOtXTGuDW3OOXVforV/+/WR1ykqyKUbWlf+dgz4SF4Q
         2uRPkcxFKyGS3W3XBQrw8okV8mFgvCvZkg9+MxZumtSg8QMM2FeObK9262Oao79J5FoZ
         OyQ4jBAxV7lQjtCQi4LIjGwBosvbpyJ1eXxihz4Q4UduMn7Dkq0O7ilUlFIMz8y3a0FV
         XERinvSQHfr/qDfgrcb18JEWVoxE1XayACVaGxZRLNvAwEzvDuHeTH6KOsxRDHxec+NJ
         gUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683126075; x=1685718075;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pyBG8neBNH2MS46XhnoRQ+AQaEp8I2Y0wSLKQq9wLUo=;
        b=aCkrL9CPmD4ly7ALFGZwvcTRyzG9xwSz1eMHfFaFGyHazvJlVDVNyG6RZ9pYriJ2vx
         7R852xtBPQTtuUyhySYK8eQBn99nnWXIbeswV0wsvPj8+HkwbT8tvo8pSyPHfe7Anlzd
         9q9fMi4vxwTRcyAoWPkFyyKEISlsn8FVrdqS7F/qthBRlT0fyPP4aIK2xewp8TTC17QR
         CRNvavn3WLBhWXEL5St5eBotQ5FibXt5chdEavcUzmtYjHRlkujjKwP5X/DwuAgv9EoN
         hz0TusrHAJ8BZclTVxMUtNVvGVbeCds7RgVtcZOV3hhyrZ+/AcWxd46BBr9/GMHKI+39
         8zGw==
X-Gm-Message-State: AC+VfDzgMeWk3rRhDRq7ngtnhfR6F9cqq32TvDtYuqm+4TYRrbZRAAMU
	SgrMIOJkB0Ux3tn3v80uc6ZiMvZzpKKTXsqXRERS+w==
X-Google-Smtp-Source: ACHHUZ71byAe74XUa5KliW5YmtIVICi9OLQ7JUogQDbCY8L/nqfalshvOVOTNlbgAcPCOk4TwRIE3Q==
X-Received: by 2002:a17:902:f544:b0:1a6:45e5:a26a with SMTP id h4-20020a170902f54400b001a645e5a26amr377181plf.27.1683126075226;
        Wed, 03 May 2023 08:01:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709028a8900b0019cb6222691sm21749216plo.133.2023.05.03.08.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:01:14 -0700 (PDT)
Message-ID: <6452773a.170a0220.91f39.c5a3@mx.google.com>
Date: Wed, 03 May 2023 08:01:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1187-g8497d3390dc2
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4-st20-1187-g8497d3390dc2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 15:01:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11402

cip/linux-4.4.y-st ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4-st20-11=
87-g8497d3390dc2)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-1187-g8497d3390dc2/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-1187-g8497d3390dc2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8497d3390dc25bbe1606a8188178942016d00a67

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


  Details:     https://kernelci.org/test/plan/id/645269b9a57353ba7e2e85f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
187-g8497d3390dc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
187-g8497d3390dc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230421.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/645269b9a5=
7353ba7e2e85f2
        failing since 98 days (last pass: v4.4-st20-234-g4e6ec7162c8e, firs=
t fail: v4.4-st20-821-g39bdf0444b23) =

 =20

