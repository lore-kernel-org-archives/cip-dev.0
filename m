Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE834C7EE31
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 08:06:42 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.45066.1685347599628003846
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 29 May 2023 01:06:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=hv/O2XAT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-64d1e96c082so2235206b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 29 May 2023 01:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685347598; x=1687939598;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pxeq1QPny7fnNqEqOZ4eZpQmCVK1hiR+ESVYPbv+4hY=;
        b=hv/O2XATRU+q9k2WNOg+PvxfWzRbPg+Gx3tShjtauA2ETF8xt/JAJRf+jnwVcCthTv
         IjTmg5b0d8zs3TozKcoSJ8+0ZsRpUgLnptAf3NCZ3/E21Za0BDV1ZyfAF0Hxg3pz2AgI
         BSJOEX1pAVh06pNTojez4TAV80EB3HQnDkFTYL0UgB5pJlHrUOLXBio8z+JhmH6aIl7T
         EFePZKyjGHrwtCklXn4kXE590v4Kue0EN1ejV2Bo2c4EoQ1CXrZW9lzYnARkcwv2iYfv
         mp+9wCdYxBu302AwIBxWVC1xp1B9hl1jc+CqbymW4uJpOcdMik/2NOfnWm33ikT3lY8w
         K9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685347598; x=1687939598;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxeq1QPny7fnNqEqOZ4eZpQmCVK1hiR+ESVYPbv+4hY=;
        b=Gizzf9W63XIVtSqeTub9sB09WCVSkQphde2AeTQS8tnWMiUJaIvzsh6m8wt74YzWQJ
         rxdgpGNH6tN0/gdKMU6xdGcBzAphQ9ATRvkIYxEYA5S3XULb+UYCgmEx1oFsFa0hs4gx
         eakQtH1fS2PY1qbzp7a7htSKZQxa1GH2uc/uqrKh8Y8AqUVu+eYIi5SN0eVdjPHRy69s
         UVGpXoqi1mfU/zsCt6jDeimlmg0A0z//JZEyVAytky3ri8dD/Ngen6DWJlg4x5DGQYio
         u9tMiwkDTKhL6g9aQAaydnQapmgoQsn5QqRhDHurr0VV165/MCqty02ormRJTJeak1Af
         bO/g==
X-Gm-Message-State: AC+VfDwYyz1rE4azBn2A9qAX9WQ+fpPAuqHI/7JnE9dmfp4sHAKANZVx
	jogjGGgT9RQmEAcACqJ8P3zCkd0LBldJ+wnooMjZDQ==
X-Google-Smtp-Source: ACHHUZ7NkbkNnNC34XGUROQt9MjXAogtFQZnNW0kJZ5ajvuMul7zkdj0dgrwO2TzY+joEn+aTrKf8A==
X-Received: by 2002:a05:6a20:8e26:b0:10e:96b5:45fa with SMTP id y38-20020a056a208e2600b0010e96b545famr8782279pzj.43.1685347598513;
        Mon, 29 May 2023 01:06:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 63-20020a630542000000b0051baf3f1b3esm6604351pgf.76.2023.05.29.01.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 01:06:37 -0700 (PDT)
Message-ID: <64745d0d.630a0220.2cbe9.c3cb@mx.google.com>
Date: Mon, 29 May 2023 01:06:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip34
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-mm: 7 runs, 2 regressions (v5.10.180-cip34)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 08:06:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11690

cip/linux-5.10.y-cip ltp-mm: 7 runs, 2 regressions (v5.10.180-cip34)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      aa80091745d6b40c944d419c12ba8cb65b1a57a5

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  04e8f2f4fd9493f595b34320403cf6b4f1f6789d =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6474555d6a83661afc2e85f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6474555d6a83661afc2e85fa
        failing since 502 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64745c05f1870333df2e8601

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/64745c05f1870333df2e8602
        failing since 502 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

