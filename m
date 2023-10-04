Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549CFE7B600
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 12:23:01 +0000 (UTC)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
 by mx.groups.io with SMTP id smtpd.web10.16886.1696422178658926559
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Oct 2023 05:22:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Nw+IB4Er;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.170, mailfrom: bot@kernelci.org)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3514cddf90bso7526115ab.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Oct 2023 05:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696422177; x=1697026977; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a8TfK16mbAOq2M1q/5qg+O0LODxjcsNXouEVZkOahb8=;
        b=Nw+IB4Er+mC+h3JSv3FXTJ1kOYFtyJJhRTlGyp8B9yste2BHE8eXVtE7teQRO93Fy2
         NS2Bh2nq2wEeyn7VTsO3MnfLJMW72eDrM8Jif0qdKRItz00xm3OpqhF9iqA9AUsfPR9o
         CNMvCw64Hm5CVy0Lhxk0s7oKYq3rktAUil88WLcnPTKA0cAv0Q0eHqQz/FJHu4dWIURR
         Teas5lf2PBxNbo3qzMyICHCxqyM9P4Wkk8YmjS3I6YTEPdmE5yqESHMwyeCiOHvOaRfJ
         lI3vW1pkdBiLYf27ZaplmzCky2TukHey24jiWe3NuWtxUowVBsq4PxJtk4sg4yXQLmU5
         +x8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696422177; x=1697026977;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8TfK16mbAOq2M1q/5qg+O0LODxjcsNXouEVZkOahb8=;
        b=kqrqjf+Fh+qcBULllvDOM8E/vpFiM8tsugLlvmkCyE1WN/qIIatVFNFB7MOVVBIQPZ
         jAx8za+KN/TmQHXDiRGHQaHbUkwHN9vd8Qyyqwp06jKOuclbxIDU4mP0lpImK76WfpNJ
         N32t2nLc7W+0S5ta4XVK5Q9+6Tt4uUQQIenkJZfrFVTc+myCDZF0qA3xSnTyKcjCqwIp
         Ie/OYpVlyIZ4ZTjPWa6E8Zf1NRSJ2AFydS7MB09CLLu2RVW8XN4EX3VV4oL1gIdUD6fz
         Nu9pLgPueIlPPskNv2V9SosqEOGxJ8hCr5YQg6ov+AIc6WMbuKc9mg/8o5XrQ3liaf21
         WlVA==
X-Gm-Message-State: AOJu0YwwXtmmDyVZMQyC1zKU+l+4MRffpiiqKDuaXfy18koDpNdRwJGs
	9MrhG9s7e5e6W0Uje1CSgoM9YxbtH90/z4Niu816pQ==
X-Google-Smtp-Source: AGHT+IGFoMDdK4ugx7ZiTt3zcpEDKGodohHvUuq6kbu2M4QzOtqfAQLykE0ld1aOwnWELeg5ERZCzQ==
X-Received: by 2002:a05:6e02:2165:b0:34b:af03:e2a with SMTP id s5-20020a056e02216500b0034baf030e2amr2384396ilv.31.1696422177478;
        Wed, 04 Oct 2023 05:22:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p25-20020a63b819000000b00564b313d526sm3204503pge.54.2023.10.04.05.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 05:22:55 -0700 (PDT)
Message-ID: <651d591f.630a0220.bf746.8003@mx.google.com>
Date: Wed, 04 Oct 2023 05:22:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39-1-g53e59f50ca3ff
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-futex: 11 runs,
 3 regressions (v5.10.194-cip39-1-g53e59f50ca3ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 12:23:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13280

cip/linux-5.10.y-cip kselftest-futex: 11 runs, 3 regressions (v5.10.194-cip=
39-1-g53e59f50ca3ff)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
                | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.194-cip39-1-g53e59f50ca3ff/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.194-cip39-1-g53e59f50ca3ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      53e59f50ca3ff023b612a48397ad7e057a9fd408 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d55008b68a54c568a0a44

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/kselftest-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/kselftest-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/651d55008b68a5=
4c568a0a45
        failing since 111 days (last pass: v5.10.180-cip34-26-g462b2292d23e=
6, first fail: v5.10.182-cip35-1-g7cde3fba93966) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4b1d4c89c4f9e48a0a86

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a7=
74a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a7=
74a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/651d4b1d4c89c4=
f9e48a0a87
        new failure (last pass: v5.10.184-cip36) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d52bbf63419ce398a0a55

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/kse=
lftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/kse=
lftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/651d52bbf63419=
ce398a0a56
        new failure (last pass: v5.10.184-cip36) =

 =20

