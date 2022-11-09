Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C75C4167B
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 22:37:27 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web09.325.1668033441085582789
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 14:37:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=MGpWoZ7W;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id 136so13576932pga.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 14:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3bPIsAcMdezzW0QWm7LvrmwSFvGujyKDMHDubiYRmLk=;
        b=MGpWoZ7WNoSfs7vn3viYvWkC/Wn/LoAN0aFUE/pnQBeTKDOsB2BJUEQpezjM8kmqY0
         OG3Er5O+3cPMrdSFuF9pEXruZHFHzZcmBeC/SX9c0fhYe+b38wrLiFlC6qXAfxtqHLz0
         5/2ALUPkcTQJX9tXrrSwD+iMP4Utqi+UfDechV5uLKXuGGIuoRXZ2HFSgbkGnn3nuKN2
         S68EKSp3/rb4sZxmQYQefLiJmFHz8+SmAnb08MxC6lHeDmWmQnbHkJN1bOm8IuYhLKqu
         CzdcDbivuA1WSti/hipXzrnhnuwvith+6HOIRrrSsZjgtZOZxyUNmTLPCv69VEF1KTWj
         RMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3bPIsAcMdezzW0QWm7LvrmwSFvGujyKDMHDubiYRmLk=;
        b=zbs+uKCm0i0aSV2WryPerl5JLI+a5XLBY/D58/DyyTREWX58SIM209eQSCeXc0XsgR
         fVIrMeICxf5/ociOk8gtSD7x734CZ0dDEpS5mqXyFOKDTTiJ4JAQPDsGThLhQtmS9XWd
         U6fcncP0GjgjUsmlQqOv9fY652PC3GrvBu9KMDA9uTy+hmqW8/KSWWdO1zRWrjPT5sYk
         sJhyl9Fw+PVDWR+G0S25Brnyji/O3I61Sk0ZFgbW/7KiBVbLfiCnKY7PIGij8gr0RuBF
         UY394RR4nKmxqheBWQ7pQkgC1vBQPaq3zgn0cDwOkCkwGlOuLPjYGwZCOZCNv3pc8n78
         S1mg==
X-Gm-Message-State: ACrzQf1VtsqdBBwHU1EYaHH6sFXUx6qFY5QoeV0cUnqRPEKrSumgZM+3
	bwZlBOZJ3PXUu/8LZ/FKbN/hzQTymeQHSm0EtG4=
X-Google-Smtp-Source: AMsMyM5ypDEXypYrJvwiTRifdyzn3c3QE6XUidz27zZuCcZfgmoYAlIWQVgfVF+ZXOdWNQFh7NobTw==
X-Received: by 2002:a05:6a00:368a:b0:56a:af55:629c with SMTP id dw10-20020a056a00368a00b0056aaf55629cmr1282895pfb.82.1668033440444;
        Wed, 09 Nov 2022 14:37:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d63-20020a621d42000000b005633a06ad67sm8836664pfd.64.2022.11.09.14.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:37:19 -0800 (PST)
Message-ID: <636c2b9f.620a0220.df81e.e247@mx.google.com>
Date: Wed, 09 Nov 2022 14:37:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-3-gc76f4e7e5c71
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 6 runs,
 1 regressions (v5.10.153-cip19-3-gc76f4e7e5c71)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 22:37:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9979

cip/linux-5.10.y-cip ltp-fcntl-locktests: 6 runs, 1 regressions (v5.10.153-=
cip19-3-gc76f4e7e5c71)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.153-cip19-3-gc76f4e7e5c71/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.153-cip19-3-gc76f4e7e5c71
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c76f4e7e5c7160107c9b5d8ec188f61fe326cec3

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b79157c8375cfdd2abfc59f63afe8ea09eaa8c5d =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/636c21263deb6133e7e7db83

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-=
fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-=
fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/636c21263d=
eb6133e7e7db84
        new failure (last pass: v5.10.153-cip19) =

 =20

