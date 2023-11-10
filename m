Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21275C05027
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 07:16:53 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web10.22837.1699600604493547149
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 09 Nov 2023 23:16:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Ne/Aa0iN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.51, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6d2de704f53so985627a34.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 09 Nov 2023 23:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699600603; x=1700205403; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zoAJq6uEyreST3k70kUqm6nsDfTNfSKNG85IlJq4Ab0=;
        b=Ne/Aa0iNrOf5XU+ZDVaM7x0PNCtLjxso7oHbN77i3nO8pic08tSipGh5IsufuS+2L9
         lJn7L3uF0wcVyXSXv9VB3EjWuUuSWHoLdX/scNAkLEbNCvbbQIm77LUWf0D0g9U1udrF
         fMiCsX7bfrwRyTyKb96yDZzUKArSI0DCCP1fxSVMTbigMUuKMbxWnD8zV80xjF4AkzPI
         Twhaws9nD/Eka5bYEQscTWwjdEP8hdfMDJW4MNjXTfnaKmSHzcXInxyupm/hUOMMdm86
         1G46STqm/5hQzdXHB0TwCfX2GBToNKWPcEYX1/l8zEfCxche6/4nPdPJ5xOeIvDyPNLr
         n2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699600603; x=1700205403;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zoAJq6uEyreST3k70kUqm6nsDfTNfSKNG85IlJq4Ab0=;
        b=PqUiLL0K8WPlMtNxlUfj55pfiG0/EJS+XoHntpaVFKBdTP5fd/2t9iMWOT+YNfE59S
         IBOy+a62Gj89VLm54GIXOeopBvsDqYCJqHdYRmDdekIkhug99z5dKT5n3wGMbBWNPiyH
         U3yKzAEXR6OzPjtRI/gGxYMSkUmh1dshgjPSd4v3g71u4CdrdOBSpq6ROtPHuclVIrTb
         XEIrNnymtJ5PrPq428+I3Q2wPIWX7mniX3EwLb9B2Ou1ARqv/0bcNEdAjL4z5xfj8UGz
         s+jrVcNr/igbc/IPtI5aZaUoFxO5MrvaX234rEaOaxukKt/Lj43JxC4xGSW8WGPveUHw
         GI4Q==
X-Gm-Message-State: AOJu0YzSSWU4T24S9+NfikGbew1p0bV/oI48ea5QU61nj1AeJktK3GQq
	dQhQLrrHrVfCmoeN38Jau5jcyoU0VmEIiLOJhP9E3Q==
X-Google-Smtp-Source: AGHT+IFWorhhy25uOBa0cpUuMTjcPUe0w9icNtKjNyQy+Yr3ma9gEdRO3o2nLZCi32oGMg4rXz+09A==
X-Received: by 2002:a05:6870:2187:b0:1d5:d8f0:7d7e with SMTP id l7-20020a056870218700b001d5d8f07d7emr8764365oae.53.1699600603166;
        Thu, 09 Nov 2023 23:16:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v4-20020aa78084000000b0069305627491sm11852934pff.159.2023.11.09.23.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 23:16:40 -0800 (PST)
Message-ID: <654dd8d8.a70a0220.921e2.f375@mx.google.com>
Date: Thu, 09 Nov 2023 23:16:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.200-cip40
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-timers: 8 runs,
 4 regressions (v5.10.200-cip40)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Nov 2023 07:16:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13559

cip/linux-5.10.y-cip ltp-timers: 8 runs, 4 regressions (v5.10.200-cip40)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig | r=
egressions
-------------------------+-------+---------------+----------+-----------+--=
----------
qemu_riscv64             | riscv | lab-broonie   | gcc-10   | defconfig | 2=
          =

qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig | 1=
          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig | 1=
          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.200-cip40/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.200-cip40
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      166400a23a22e665f5d880a99149b73abede402d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig | r=
egressions
-------------------------+-------+---------------+----------+-----------+--=
----------
qemu_riscv64             | riscv | lab-broonie   | gcc-10   | defconfig | 2=
          =


  Details:     https://kernelci.org/test/plan/id/654dcb727b13b803e4efcf6c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/654dcb727b1=
3b803e4efcf71
        failing since 51 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/654dcb727b1=
3b803e4efcf71
        failing since 51 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39) =

 =



platform                 | arch  | lab           | compiler | defconfig | r=
egressions
-------------------------+-------+---------------+----------+-----------+--=
----------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/654dcc4e174755fb6eefcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_smp8_riscv64.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/654dcc4e174755fb6ee=
fcef4
        new failure (last pass: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig | r=
egressions
-------------------------+-------+---------------+----------+-----------+--=
----------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/654dccfbaa8ee7794cefcef4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/654dccfbaa8ee7794ce=
fcef5
        new failure (last pass: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =20

