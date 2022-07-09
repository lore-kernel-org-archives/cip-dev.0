Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0521FC43334
	for <webhook@archiver.kernel.org>; Sat,  9 Jul 2022 00:27:43 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.1665.1657326461554954219
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 17:27:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Mw9gHb/x;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id y18so126409plb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 17:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=hZXj5/loJODNB7G1d+UcRCgZgqvOAyQ6sCIC1cHw2lc=;
        b=Mw9gHb/x8+KrYDtg36U5bFy4qBVj0ZsQ6hikZ6sxtLHabi2irehezp+cWYmbKlg3PP
         1SUaftMZaXe5Hl+YbkYmJPs0uycH1JUMrBd/zeCjd0XHrcKJo9t9AA/QGefeaijfaP9o
         +NzfaHUOwZP1AiiX+DwM1+8efMXbM5ZQPjtRZEry+o00MIv7y/vJDqXzw9B97TUZ4Y68
         06ciB4z4ZxiNIruqMeeVGYqEPB74GjQqO/XyS8kDYVCiCUgtBlFGBJpvHwslK7FN8+6Y
         oVxPsgVfqvFYoCpnNrkZ1WHBDFd4SFY5dtRwrrNRrlpc6/FcHOHz3iREb7KwR2uIp3dY
         9eyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=hZXj5/loJODNB7G1d+UcRCgZgqvOAyQ6sCIC1cHw2lc=;
        b=7IaafbjQ7P3h7ZL5HvlDcuUqJMd/MCnZhTy3JhEFhE0Lx4duTmAZ/mvlFNbc6C6A0I
         +XIjTreLjaZBS3XcCuxB0djNTVybKAOAR7D47HeK9hMmmlcvADSgy7m1lffg7ZcclQMg
         oitPFc6ENXbYqObyq9kzQZgB5LjKOASHyKP8cbNoZD2HFdR+xLAxI7FuBIHdseyBf/Sj
         V46AGTTDoUKhXK5Z7y79xDzSbpDDmWe3P8ZjjUboI1zDrQKWgekvt5xn1T1fwOopvBm1
         y10di6MRDScMSNjgh6V1bqpnyRh8H18VC/vSTPC4I9AEKCI23/jTB940uEh15QciqTfc
         Zehw==
X-Gm-Message-State: AJIora+K82hKFM+zXcSjIWcHm7dtIA6yICqsOHaVVYy2/RDM7B5p/RIF
	zrSUAvJ/+Yr+UDtwJaNE6WOcZSME2YIdRHJZ
X-Google-Smtp-Source: 
 AGRyM1sZV4o1SditKDYnyNyI+WB0T678SwnorzREau4nuJkcXZ7KJ8lAb/dR038RKSTI6Fb2imDTxA==
X-Received: by 2002:a17:90b:3911:b0:1ef:fa84:dc80 with SMTP id
 ob17-20020a17090b391100b001effa84dc80mr2837417pjb.7.1657326460852;
        Fri, 08 Jul 2022 17:27:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 i131-20020a628789000000b0052844157f09sm182896pfe.51.2022.07.08.17.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 17:27:40 -0700 (PDT)
Message-ID: <62c8cb7c.1c69fb81.6ab57.0646@mx.google.com>
Date: Fri, 08 Jul 2022 17:27:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-mm: 6 runs, 1 regressions (v5.10.129-cip12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 09 Jul 2022 00:27:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8737

cip/linux-5.10.y-cip ltp-mm: 6 runs, 1 regressions (v5.10.129-cip12)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.129-cip12/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.129-cip12
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      19dd4538e81e4019bc96ac6521af3a4ec93e110c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e98f9465925434349d0aa6eb71e81b5464e76df4 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8cb7b88b9b796e6a39be0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220610.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62c8cb7b88b9b796e6a39be1
        failing since 178 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

