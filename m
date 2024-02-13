Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A57C48260
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 19:06:26 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.21904.1707851180235666338
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Feb 2024 11:06:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=PbPKDmFk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d751bc0c15so41789845ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Feb 2024 11:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707851179; x=1708455979; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kYI9R4Mxzo+YFn6mGNvAG+7xClgjUWN5GUeWwn5tOsw=;
        b=PbPKDmFkvDDll7K/bl/Go/Nc+WzhH7ghOnr5zkXd9j1P6afwuEe2pNFUm6DdSanV81
         n5JgJCYZ0HCUp+m+ckUtAqIL/LZteHduANAplhdPZSMLJtOmFa1siznBmVweG86Ig5HF
         65jq6ELnKEMnRw3ltze2Sz5WV1a2Cm4jvf/pNX84xIO66/XzfoC/W8yCAcANu67pC44r
         wgKhFYhqvycDpNH5V593l+6v/owzZfHegdRRs883SCBXgURE+kub4NCgbyDYX+PT27yc
         2ZLJgdpDUcAIapiCk7F2RJ1GGcyYznm5NXFq+t/F0SVps4/sbUs6Slc9MVXw1rXmuGrg
         sDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707851179; x=1708455979;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYI9R4Mxzo+YFn6mGNvAG+7xClgjUWN5GUeWwn5tOsw=;
        b=ItU9Eh4KnMgpLYru+grJz4w4Q0FNq/MohYuzS9vtlrwPBW/N6gEs0Fmh6FRpiDzmuj
         6dp4H/ZWE893vys0M91xXnyLbm6C0cGDIQ847aYQD051xc1XeEblh1GFZNcxvW4cpJD/
         v/zoQIKAom+7fuoK7EYSboyGIXQsg/VZNYXmgQdGRgULAOUvpqGB2eeti7gBh7QjCytr
         pL8CsFxtfn3ZlOnGdm8FUgn7MdeedKm2qHbgU58XO+szMslavILDC0aF4/ueU1vDMD2j
         DJ53nZpg/4lZ74mBVuA95RTsqwbIlAmPavGSgjdQrLf6HIcATL2ZzTEniEva55/13iCc
         H44g==
X-Gm-Message-State: AOJu0Yylo0cU4jvspNFJYcDj0394CcvKH18iN8DtSfofWaEbkdEZVDtD
	FNL7mFzfhKbvnt9dEgB3xtIPpN7pyU98DlqoRBfMkCMvQzK1LrZUq9a0Fsb7XNbGdtVdp1j0O2U
	A7hY=
X-Google-Smtp-Source: AGHT+IG8ookxQjXgmeXL2t1LrA7IDNJHCuLxj1WK/UgzTuxuSG5FS9YzPZ9afGixsP1o3BvaZp+JYw==
X-Received: by 2002:a17:903:595:b0:1da:237e:4754 with SMTP id jv21-20020a170903059500b001da237e4754mr374676plb.8.1707851178945;
        Tue, 13 Feb 2024 11:06:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQezZmqXM07XGUgYtaMK/ekLyPd2q35qFKQtrRdVRmMRl7q2fWS9VZAZJQ/WYaxW/oiWzSx9YWl3J0kxPeU9JzEioQpdQkyj4++GVb9U/yTxjipHSLxjyoZRTlA/NsTICTxYd8JPE4fO94huwRWLjUuQ==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id kk13-20020a170903070d00b001d77a0e1374sm2414214plb.151.2024.02.13.11.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:06:14 -0800 (PST)
Message-ID: <65cbbda6.170a0220.bcf9.87cd@mx.google.com>
Date: Tue, 13 Feb 2024 11:06:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44-51-gdb99ac443b0da
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 17 runs,
 3 regressions (v5.10.209-cip44-51-gdb99ac443b0da)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 19:06:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14953

cip/linux-5.10.y-cip ltp-timers: 17 runs, 3 regressions (v5.10.209-cip44-51=
-gdb99ac443b0da)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig    =
              | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-51-gdb99ac443b0da/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-51-gdb99ac443b0da
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      db99ac443b0da75f00a4fc49e0040ac5dfa47e72

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb02277f0ff80dc637015

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qe=
mu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qe=
mu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65cbb02277f0ff80dc6=
37016
        new failure (last pass: v5.10.209-cip44-50-ga624abaa85d7) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbaf304d75a66a3863707d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65cbaf304d75a66a386=
3707e
        failing since 132 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbafd5a686e21db7637026

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1=
-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1=
-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65cbafd5a686e21db76=
37027
        failing since 11 days (last pass: v5.10.201-cip41-69-g8f7b450fc28ed=
, first fail: v5.10.208-cip43-4-g1c63c70fb18b8) =

 =20

