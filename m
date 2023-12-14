Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050A5C46CC5
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 16:15:50 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.26616.1702570546513581264
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 08:15:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=LJjCmOOS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c66b093b86so630270a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 08:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702570545; x=1703175345; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P9AQ2NOMpKuxHfCv6pMjqKUpKKvQkeSv1GONgtYBE58=;
        b=LJjCmOOSJMr0A8DLdCKBqeAafPH2Wce1lc2BmWTuTU1qkxN5d0ycRUSLohriuvH8sn
         gUQwDkOpFbnvMXku/zQouB/O+np+PcXKeinXNu82pOoIk0kDyg7f6MaCUNjeHbmb1vrq
         6xzAOn3WDG9zIC+x5HMe2UerRR8Y95iI2fqRUsFE2X/buYfFUCB4Hg2pUDMR+/H67tSC
         y44cEFyEbU0QgRmTrtBl4nIP+QTrIGDDpKqozrwlUbDIcUaKRAqz7pWF4mPn6YzfPFYN
         LcOfhkksrs8vjqaQfz+I0C8kmf/wY/iLzr1UcEmRuz/mDDNiRbLSTVg1rTQTZEB++3JS
         xi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570545; x=1703175345;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9AQ2NOMpKuxHfCv6pMjqKUpKKvQkeSv1GONgtYBE58=;
        b=IpGuERgB7xrzxKa9fNsbbqIBj99qw62kh5PWcRiCHALxYUDW0mNwIPbcXSZ7/rj93P
         FqLprM5BdvI+zJH/4FMCVSQGr+Tw69h/brZRHI8a2+PXLBtr71LLt4Fdg1N7ybUACZ5T
         OJRJmiDxYwQ0s40ktnQTq/k5Ve0X8A6rRuUh+zdYBh2N6etRlkw2RrorxZj5lyVp8qVr
         ABAUVN5I4obdVeLAV+sSBSZ6ICRLm8xI9hEJsYm9EwHu1LKwS+wy5B4lctdqPNuGudFW
         0Uhb93EX0eXTCg5qpaHU6IkxcO9W2aCUHqjjGfCNJXj6r0YFw68AvxWFN5PapPORQ+uF
         Ay4Q==
X-Gm-Message-State: AOJu0YwPbTWvDni5xTpJ3bNKh6MEFB9iG0TgfviNjVB18A94jgHVBPq6
	gl6ZxB/qEDutv/qej7jghIPxgd572EVYksQEM+o=
X-Google-Smtp-Source: AGHT+IE4hSQPKtFn3Q+yHuOS/ttNbJB8YPIRTwK6QSPiZ8PntxIW5MsP3Moeeonrty9dlyChCBjqbA==
X-Received: by 2002:a17:90a:8b81:b0:28a:d766:fa15 with SMTP id z1-20020a17090a8b8100b0028ad766fa15mr4881176pjn.12.1702570545479;
        Thu, 14 Dec 2023 08:15:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id hi12-20020a17090b30cc00b0028aec3e481csm3239769pjb.20.2023.12.14.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:15:41 -0800 (PST)
Message-ID: <657b2a2d.170a0220.2f313.9b5e@mx.google.com>
Date: Thu, 14 Dec 2023 08:15:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip/linux-5.10.y-cip kselftest-futex: 8 runs,
 2 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 16:15:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14118

cip/linux-5.10.y-cip kselftest-futex: 8 runs, 2 regressions (v5.10.201-cip4=
1-69-g8f7b450fc28ed)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-69-g8f7b450fc28ed/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/657b28adacce143250e134f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex=
-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex=
-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/657b28adacce14=
3250e134f2
        failing since 3 days (last pass: v5.10.201-cip41-46-g596f4c151d286,=
 first fail: v5.10.201-cip41-63-gfdfe1fbf93bc6) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/657b1b633929032137e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a=
774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a=
774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/657b1b63392903=
2137e13476
        failing since 20 days (last pass: v5.10.200-cip40, first fail: v5.1=
0.201-cip41-11-ga539098fe70dd) =

 =20

