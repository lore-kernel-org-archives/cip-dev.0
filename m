Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFC2C77B7A
	for <webhook@archiver.kernel.org>; Sat, 10 Jun 2023 11:24:59 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web11.15694.1686396289477034214
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 10 Jun 2023 04:24:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=5ngmuB4T;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-54290603887so1222335a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 10 Jun 2023 04:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686396288; x=1688988288;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zlfiVn1CBpiGMJ5xGSVjmvPf8w1cKxcZNYBvSL6si5Q=;
        b=5ngmuB4Twdum79cANfpM/ZUSs23FIeGZA3WJIKB3qyPdeP8MIsHQtkuO51tjzH1Iqr
         3zuHLcolvMTgYkvy8rMdgrQcMW64x4VIb1Zv+WGcof+RCH85X3YES6DvUhNejvI7betG
         onP6jNliL50G8OctyeAr6KPQARXJNULWlTfDgNRi1voRWd9drRELMYanfplSVmVZZvSr
         qaU64p0xtNDtXgMryIC14in6pWMMiNGePFyz/93rp8cG37eoegwufLOkr/2bwDQlEM4V
         ZtFeAnAtNiwJTYQOdaDenIVGTp3n9Gca9ifY9ETS121rYfvxdVo0at5wldv2x81AqLZy
         jHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686396288; x=1688988288;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlfiVn1CBpiGMJ5xGSVjmvPf8w1cKxcZNYBvSL6si5Q=;
        b=KhrqUfTTNDR9E2IumQiZQ7OdmKtTOD4f1iCFX4l+U7EKBZJLzwO1PqVMFBFkkPhKLN
         4Fs9ZGciWHcg2w/5z8iQaH+32KQlQN6hmzi0kHTJEaM4I8eSau9sBh4x5AWIVy7oq5jc
         ZVC6SE2bL96awWTZf0uXru8vvII/LtkIKIdUppp8iiCnweJEZ9M1uaO1Zp/VriUN/SUQ
         a0rSx3TrQzXyFPN2RBQ9SrE3gxVNM3T/7s8OqeW8Xe0lDPotBbVkSqDvY9rqobPp87Xf
         yczGMv92ow+MrCElOrxg+ivGjvkueu9Ghka9Q4t2hNb20Vs+sTA1YZtc6Tvffjp1Wzro
         YpKw==
X-Gm-Message-State: AC+VfDyHtZPUmEwkY1kYCF5aEFHN4lc7ArKrJPApgnzu2xlkPrnQgyiN
	/QpzJozBcZ3k5z517Cg501NlyCvC6pd6q+uS/IJNRw==
X-Google-Smtp-Source: ACHHUZ7/RXw4+1PwYwLAx0Ei3+FwSj/UiwxuUTwB1hU9MHkWUbJK82hwke/7q2lhhpAXYqyizTefCw==
X-Received: by 2002:a17:90a:de06:b0:247:ab52:d5d8 with SMTP id m6-20020a17090ade0600b00247ab52d5d8mr3387851pjv.26.1686396288259;
        Sat, 10 Jun 2023 04:24:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bg1-20020a17090b0d8100b0024752ff8061sm4392180pjb.12.2023.06.10.04.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 04:24:47 -0700 (PDT)
Message-ID: <64845d7f.170a0220.4f488.94eb@mx.google.com>
Date: Sat, 10 Jun 2023 04:24:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-45-gce658d9231044
Subject: cip/linux-6.1.y-cip kselftest-filesystems: 8 runs,
 1 regressions (v6.1.31-45-gce658d9231044)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Jun 2023 11:24:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11965

cip/linux-6.1.y-cip kselftest-filesystems: 8 runs, 1 regressions (v6.1.31-4=
5-gce658d9231044)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.31-45-gce658d9231044/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.31-45-gce658d9231044
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      ce658d9231044091c42896a08fbbfad40ebc58ce =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/64845c19a9c7f7d1b330613b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-45=
-gce658d9231044/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftest-filesys=
tems-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-45=
-gce658d9231044/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftest-filesys=
tems-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/64845c19=
a9c7f7d1b330613c
        failing since 3 days (last pass: v6.1.26-1314-g1ab0ac1d7e2e3, first=
 fail: v6.1.26-1320-gc38e4a9845945) =

 =20

