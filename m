Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D06C77B79
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 11:23:10 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.6712.1681471386900422358
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Apr 2023 04:23:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=QKMuui2N;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id fw22-20020a17090b129600b00247255b2f40so4138960pjb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Apr 2023 04:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681471386; x=1684063386;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fkv+CYNPNBOpB65iBTsMAfrs9NdSvqBPIVzQ0uI5OAc=;
        b=QKMuui2NArySbCuhTxHWkFq61qOj0QBLLAEqAy0pFY4SoeE9HjnXQrOgicNDuOjdoF
         Yvg4K/aIUQG1lKSp3UGG5KsQEAzgejOLEBEUZPYrghd4eqM0aCKWwB8MpN7QG+m69TvD
         UCPybn2/I4gnu20+RGVfUTHG4P6rDS/28Q8cBV99F8zP/yBcxfG3ztZGAFBfwPuBE/iG
         xCwzMNg8kjufGcp2HYK1rQ9IizQi9XuykLIW1IMWKRKA6aEH4hip8g8gmQDsQxYPcO5y
         nmHg4fwEC/EU5NRog+60jGu5/ZEp7I8HB6GQxInMKkWWUP3HUZJKt9sTkatL4MlOE+xZ
         6kAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681471386; x=1684063386;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fkv+CYNPNBOpB65iBTsMAfrs9NdSvqBPIVzQ0uI5OAc=;
        b=K2QwZHPnR584qs3BFnseH7s4wo5smwdSCB+2A36+PWo3aWimPwkbL/3yyx5f2GjgWy
         UDZDU4uuQOhBUwvFjzARN515088T1W+Wy81thuQnMwPLEBmVBEalkTPFtEHN3hdwPXu4
         p2kPkRuvjYBnsIfhbvT7aGH8uir2W5JmJjq4ZQmqxm3Rm/XIpulUKPmjNXTxlwgT0Mw0
         72qTglVVgb2TdYv1VDYR/ZwPNMDScNMQQhegJy80rtKYe9cgu21rBAlvJkKtys0HKh73
         vnKlYS0q/uFzIIwhGCgjAOjW/Q9s/AlKgXbC5EQ7t5Z8btRtPdRsJ6nk+lMd1U/WLEP2
         bx4g==
X-Gm-Message-State: AAQBX9e+4Zj2BL5bkeHKx891iDiI/GAztbqZ2BLlV3tQKcLne6W+N4kV
	i8UpL56JtQSsRRSgaOlT/QEb0sIjIEeyAKjo8iC3+rYX
X-Google-Smtp-Source: AKy350awZ1740ygQnTJjP9vRKVSihnOpY8aeS1z7/uY7pdZwIhhfVRFgmMBJLl4cbSBwCszXmPv3Tg==
X-Received: by 2002:a17:90b:1207:b0:246:b038:2f53 with SMTP id gl7-20020a17090b120700b00246b0382f53mr5047666pjb.24.1681471386083;
        Fri, 14 Apr 2023 04:23:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902f7c300b001a20791250esm2902764plw.22.2023.04.14.04.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:23:05 -0700 (PDT)
Message-ID: <64393799.170a0220.f6ee4.683d@mx.google.com>
Date: Fri, 14 Apr 2023 04:23:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.177-cip31
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-mm: 6 runs, 1 regressions (v5.10.177-cip31)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 11:23:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11215

cip/linux-5.10.y-cip ltp-mm: 6 runs, 1 regressions (v5.10.177-cip31)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.177-cip31/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.177-cip31
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      deb75c99ed78d677587a345854b8a00fb2cac68c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cb9b37a6a47ea5f9e442b4473c6eb06877bd18ac =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/643932ab0101cde2b32e85f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230407.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/643932ab0101cde2b32e85f3
        failing since 457 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

