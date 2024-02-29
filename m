Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43519C54E5A
	for <webhook@archiver.kernel.org>; Thu, 29 Feb 2024 09:57:02 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.20889.1709200614360783276
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 29 Feb 2024 01:56:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=1Qi9Q/oi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc0e5b223eso6635245ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 29 Feb 2024 01:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709200613; x=1709805413; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gz2+sLU1KfssT3VqFw+aCv7WOf1QBwBC8tro7iWg7UY=;
        b=1Qi9Q/oi4d9GvEFUcRwmwANGK3kM2zD+IJhiqKXBgzLvgAQEcJF1rOPrWd35Fjanfd
         E9haRUCMnJDjsb650TTR2qIxwfLsvCQYQ2anJpLMlApPZKJpnn59LCbCnfdcFwT5V0i+
         z4x7I79RuPIaCNDa0qzCB1IN8pTWkOQE3FPQQEvIGmBxxvSFIqUfWgWfq5ftVygnDfLJ
         i+3jzBBYyWdSxQFGdAZf364Mka8fw/NKm9wTJgqPgqQrEvPwo1HyUHmB6sfu97ZYw3hk
         YxjPQf7FuIhAlf8wTlSdDmc5dbgjnTTbVqyHineVWK5QcAg59tfiqqogJkBGvGE2sAHS
         jHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709200613; x=1709805413;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gz2+sLU1KfssT3VqFw+aCv7WOf1QBwBC8tro7iWg7UY=;
        b=ek7oDBSXwNXvrm4D78Yri5YZm18TvJ3dApA7dVMNeN0sswfHqbGkyxIs1BljMo9GQl
         7CY2TCU9+FlaeWgcjuZHzY0U510SyytW1x5LZc8cuKyJ/b1jt+m0QYK1YSfM0m5BJnov
         2sOGA+BZr+U3iHYdDO5Zd3esrx+OZ1HuavPdq1GcvWYmwf4X3cn2Tiuutn3hixhzk8kH
         MWDqtwATyXy0e2H5k33iLlPGmIVe2n19xzneUuVSvBBOXey2yXnCgJocmYmsdzGoTrx2
         HZfU72yqSWOPvFI9Qp6o0H42eP2vFsupBaYKd2gqtQbkTfEFkBZXP7pdz9dmQV4Qu70Y
         Ro/g==
X-Gm-Message-State: AOJu0YwF6bJ0HlaQJEW5M7JAmEqA3yHmWU+NiBEROdUoS85C4Lb6RkAf
	IZsi+EZjm1t5HPDno/ADjTVJPAO/AheaVI/9Admm9XRHmIiJ7ONuuIRslBlecaNXAs83e+7Rg4F
	iZCw=
X-Google-Smtp-Source: AGHT+IFkwhdQ1MoJFD4cYjVFQnqxh1IHIeMcsVhdMLNzqzwBY/uH+saT0NLBbS89GVx1FfTVXhGwiQ==
X-Received: by 2002:a17:902:e88f:b0:1dc:a00c:5442 with SMTP id w15-20020a170902e88f00b001dca00c5442mr1423142plg.43.1709200612784;
        Thu, 29 Feb 2024 01:56:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902784800b001da001aed18sm1049359pln.54.2024.02.29.01.56.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:56:51 -0800 (PST)
Message-ID: <65e054e3.170a0220.dce6f.2c74@mx.google.com>
Date: Thu, 29 Feb 2024 01:56:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-56-g55117716ac0fd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs,
 2 regressions (v5.10.209-cip44-56-g55117716ac0fd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Feb 2024 09:57:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15106

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs, 2 regres=
sions (v5.10.209-cip44-56-g55117716ac0fd)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-56-g55117716ac0fd/plan/kselftes=
t-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-56-g55117716ac0fd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      55117716ac0fd541adb5a35e66eb21c45107b040 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65e03f048e3003675c637079

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65e03f048e300367=
5c63707a
        failing since 118 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e044410c5617d1266370d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65e044410c5617d1=
266370da
        failing since 70 days (last pass: v5.10.201-cip41-69-g8f7b450fc28ed=
, first fail: v5.10.201-cip41-540-g3640150b3b169) =

 =20

