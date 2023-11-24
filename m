Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D78C61D97
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 03:00:23 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.128350.1700794816124304760
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 19:00:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=t3Q/ILqn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1cf98db3569so6025025ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 19:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700794815; x=1701399615; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L8erfFYyM9AkBkKvPltBWYyu1qP+rnvxhwJqPY6hA7I=;
        b=t3Q/ILqnfW3E2TUvXciWaB61ZUHW1F9EsYn7CTneK3mhO/5cstD9BeYcfKZ5n09u5h
         qtJpTgTvxwVg2Q3LeX9Om6rQHmF/YkaSxmM4k9jmBbzuvKcr4xCtju+bRsGt1qoCJ+sk
         fm7bFtGKcpRXSIXg6feh20ZUpA60XBYeIEKy6S5Q/9MwPJ554wrUlSDPKxw+UYqIznmC
         2fwb3KqfvaoSxq6/flNSY1YILSfj3Xji1pzLhpaEpw/Apftby5HUH1HnuQ+XthHMs2Q7
         IOuPv7eveMHw+RpMCsGCPcsVrLBHxW+iRqK5XPrHikiA+xtGZRCNTJRi2jViwo7DQ2KR
         ddFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700794815; x=1701399615;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8erfFYyM9AkBkKvPltBWYyu1qP+rnvxhwJqPY6hA7I=;
        b=NT7Em7HIw537yFqk7xkmn/9BjD1GL4+KuCbldTfnyEKsE/jBtkd4+s7rYxS2e81a9G
         a+maS2bDmu+WoOXk6kdOsRtkigXjbWCZMrI8+x4ZP5dJMyzPvub32n2A/AeuGayIRbT4
         I5Z+fMSquOUsN2hspMCf3DKM4FJpdOni4qRS7ZL8F27cG6Gv9TH3hD/jfBGY511UxhEi
         qfVFL5CqAUFvHQevkCydgFuEq781czBzhpaBRN+akunCnOLv5QV6hAlNbY/rgqacXZpa
         m0sp32G84aEUfqpjHIUgIEkews/pVWqx1gWgmhfCHVD9I4nw95yqCRIGMX+n5d0ZoJom
         Qt/w==
X-Gm-Message-State: AOJu0Yyypy+JBRfjR/dUTnb2j2rigdbW3kxsVO036/XcND6z2anBAeC6
	1gAbZgAiqCzBfrYdcSxkjfggg1NRExGiQCVO0MU=
X-Google-Smtp-Source: AGHT+IE0Nnh12v6sPdh7weECr+OO5qG4nnkN7UFytFK4NXtO6h/gyNAcHxqrACIT3H+x3O4jQGXT2Q==
X-Received: by 2002:a17:902:9893:b0:1cc:37b9:4953 with SMTP id s19-20020a170902989300b001cc37b94953mr1180638plp.67.1700794814759;
        Thu, 23 Nov 2023 19:00:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902e98600b001ca4c7bee0csm2078721plb.232.2023.11.23.19.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 19:00:11 -0800 (PST)
Message-ID: <656011bb.170a0220.821eb.557e@mx.google.com>
Date: Thu, 23 Nov 2023 19:00:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-rt17
Subject: cip/linux-5.10.y-cip-rt ltp-fcntl-locktests: 14 runs,
 3 regressions (v5.10.201-cip41-rt17)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 03:00:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13708

cip/linux-5.10.y-cip-rt ltp-fcntl-locktests: 14 runs, 3 regressions (v5.10.=
201-cip41-rt17)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
      | regressions
-------------------------+-------+-------------+----------+----------------=
------+------------
qemu_smp8_riscv64        | riscv | lab-broonie | gcc-10   | defconfig      =
      | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+preem=
pt_rt | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
      | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.201-cip41-rt17/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.201-cip41-rt17
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      78ed1354cecc021db9a1d8a8b4755fdfcd826e33

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
      | regressions
-------------------------+-------+-------------+----------+----------------=
------+------------
qemu_smp8_riscv64        | riscv | lab-broonie | gcc-10   | defconfig      =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/655fffaf8d27c030eb7e4a7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/riscv/defconfig/gcc-10/lab-broonie/ltp-fcntl-locktests-qemu_=
smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/riscv/defconfig/gcc-10/lab-broonie/ltp-fcntl-locktests-qemu_=
smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/655fffaf8d=
27c030eb7e4a7b
        new failure (last pass: v5.10.186-cip37-rt15) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
      | regressions
-------------------------+-------+-------------+----------+----------------=
------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+preem=
pt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/656002fb3ca3cbff2e7e4a7c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-fcntl-locktest=
s-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-fcntl-locktest=
s-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/656002fb3c=
a3cbff2e7e4a7d
        new failure (last pass: v5.10.184-cip36-rt14) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
      | regressions
-------------------------+-------+-------------+----------+----------------=
------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/65600690b5a35a1e277e4a77

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-=
hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-=
hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65600690b5=
a35a1e277e4a78
        new failure (last pass: v5.10.179-cip32-rt13) =

 =20

