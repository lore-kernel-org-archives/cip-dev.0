Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FD9C6FD1C
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 08:31:02 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.37847.1679473855533230125
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 01:30:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=5aQQ2WNL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so22888500pjt.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679473855;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ry7jafJx4zMmSqCWVw/Gdt4kujPlDg+RkCTIf91TyeU=;
        b=5aQQ2WNLQwg5zZmMUFAj2e0vL57y0MVv/dZwnQIy2irXoLNWGOcNVgQq4UkqyzSKV+
         ony+TrNW+CQzzkUHLhLAU5z+pRwAzA6MJkgp0J9Tl3S8KelTU4aV4vEWb25O8iXk/5wN
         JCABq/4UVwj8z9fUL8W2woEc4z82XIVUJkT/WY4+ly4TDCIoc9wj0q9RIpisZPZ+WDnA
         JC1Wp9OR68d9ZmA7WYvKKDFzAK7Y+kyRhA7I/CNQKOf3N9Q67mheXRLm69zzbyKKQO3A
         6HqKRP9ZZfnPW0XUXEnEf7YECevo1k0MlBrplxM4lCOHXh9azb84KL2y9VJ6eVtYR6Xd
         TxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473855;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ry7jafJx4zMmSqCWVw/Gdt4kujPlDg+RkCTIf91TyeU=;
        b=tb3z2aLR9tV3saRyClTT8J2CndXr09MsV71s6RavVR0bVaVIiNd9Q/lQzDZG9NP2ho
         /q2K2OoMhW7t7cyd1fTZJ+ErhmEgkEChQtyoCyuZWUZ0N158N2RkgQ5EFbUaUd7cVUWr
         thuEbzpLB4n2GsL1bkryB139RnPwsFbVw1y4jUzMGFBsL7PSSuut1EqHVITUk0CMxYBu
         GjSyWNpDvMdzbJqzLeBw6PJy+2Ah8jnOVXahL6ZZqyeBBUVTFvABUtkb/o7nhNHNrTyn
         B5iHZEISZzfGRYwTF10fy7B7Sd9TjRH9fLBGpj8Bw3RXeLHBeZt4zI6q025VvsHjfS25
         NJhg==
X-Gm-Message-State: AO0yUKVxRkvFjrk/QJ5M6ZheAMJM7Qtr2We+Eqbyh/alR3kXLOZNMGj5
	XrdQIGND2BaMO9qLX2zdazyV2KtxeAovSRMLJd4=
X-Google-Smtp-Source: AK7set/FK4yrrZ/Jppq86SRWi2zuP/pPQYJD1fJ5LiRuU7mKUaHiiOYhumseZRwbqNz/IhU+mxajRQ==
X-Received: by 2002:a17:903:70f:b0:19e:e001:6a75 with SMTP id kk15-20020a170903070f00b0019ee0016a75mr1698334plb.6.1679473854824;
        Wed, 22 Mar 2023 01:30:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d2-20020a639742000000b00502e7115cbdsm6729829pgo.51.2023.03.22.01.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 01:30:54 -0700 (PDT)
Message-ID: <641abcbe.630a0220.6904f.ae4b@mx.google.com>
Date: Wed, 22 Mar 2023 01:30:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.277-cip94
Subject: cip/linux-4.19.y-cip ltp-mm: 6 runs, 2 regressions (v4.19.277-cip94)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 08:31:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11051

cip/linux-4.19.y-cip ltp-mm: 6 runs, 2 regressions (v4.19.277-cip94)

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.277-cip94/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.277-cip94
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7027f305d14858b8392890a56cfe71edd50df202

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/641aaeca9e966ae7d69c9507

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/641aaeca9e966ae7d69c9508
        failing since 430 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641ab51373b534f1a99c9521

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/641ab51373b534f1a99c9522
        failing since 430 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =20

