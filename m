Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6C7C10F13
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 14:02:07 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
 by mx.groups.io with SMTP id smtpd.web10.84740.1701957721577717334
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 06:02:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=svYT4WEQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.174, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b9e2d50e61so203480b6e.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 06:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701957720; x=1702562520; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g8F7tFZ3nLg58EqIhCWURcaziQPEXqXFDWHY9pHFZnI=;
        b=svYT4WEQuX12J8dhfmg1s4I7zaXefDwwflq0RM/nMTTNHt0f62gRY04N3JtT51Cs16
         YgImCpdbp5LInzPdSrSYMhH/JYMGX4xLT2EWPAAjlwzw5mdrx5jX64nyjI9Q0vtVlwLF
         t09G42/Qg4usU1XZYNGrmjZh4YfaIBzTAKf5Y5vSqTO+vRKFiKrf+mKdD3M9+mGpyBez
         vG5OTA7+LSTegAlhxMMY9zMo6d7KAL4Fyh7hxY1MdNifaJ9rzU8/IJVpbjMZrRYoUyGy
         lv2RJq9nbIJWi/htSCNDjNPFhbb/9zsZEUt3igUiYBz/gz1RJqbR0Wh2oRFpddgdzffr
         eDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957720; x=1702562520;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g8F7tFZ3nLg58EqIhCWURcaziQPEXqXFDWHY9pHFZnI=;
        b=sdmX3HpoD5uggOFTXJE+fzf1I+dWvgi++FU6GxNex94MmVE/SNmQOVk6K0epsCUykW
         +bKm6BygUOKAvFgWxFVwoF9B8JQAif8C8EnQMhBGPG81kJGwt1875vnX8v4D4Dhk3TME
         NyI037xdmQFkPztfXH99a4I7qS5OWL3psss1tpQ9pFfrwtZ1pCxtoG0rzIXyMWdj5a9s
         neav2Zx/raVvaZ7kB6f1GP8GkySGX7B0p92P3jlOwi9GkHaOqFCj5N1iuLlaMiR4QI4+
         nIqZgBfYVBIArO9P+EGmUSUDzWiBcV4LI4qNF77aVJdj5KXR4qKzBLykrBEfYnwnMbEL
         Cn3g==
X-Gm-Message-State: AOJu0Yx2mwvkZyx+to1tFxWUvty2p9C+LkFPYoPgtlw9EX0Svy1c1ld9
	zxani8y+GcxkWgm0wRg9tKzxl1+PAXGI8Ku8ue7WTA==
X-Google-Smtp-Source: AGHT+IEpfhWJ7xORI9wxdrEj23n28Lhss+ANtq3BqfjBCylSoRMm5qp+yBnVLQtidy5Cy9Y42cSu+g==
X-Received: by 2002:a05:6358:884:b0:170:560b:ff2c with SMTP id m4-20020a056358088400b00170560bff2cmr3828180rwj.47.1701957720150;
        Thu, 07 Dec 2023 06:02:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b27-20020a63715b000000b005c66b54476bsm1237597pgn.63.2023.12.07.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:01:55 -0800 (PST)
Message-ID: <6571d053.630a0220.70fae.2bd2@mx.google.com>
Date: Thu, 07 Dec 2023 06:01:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-16-g3c85fba3b6e5d
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 2 runs,
 1 regressions (v5.10.201-cip41-16-g3c85fba3b6e5d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 14:02:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13868

cip/linux-5.10.y-cip kselftest-seccomp: 2 runs, 1 regressions (v5.10.201-ci=
p41-16-g3c85fba3b6e5d)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-16-g3c85fba3b6e5d/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-16-g3c85fba3b6e5d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3c85fba3b6e5da8b112e7ecd142649674648028f =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6571bed05e81431251e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6571bed05e81=
431251e13476
        failing since 64 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

