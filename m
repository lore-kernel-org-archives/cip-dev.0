Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F417BC4828D
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 22:20:43 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
 by mx.groups.io with SMTP id smtpd.web11.9119.1706826034070821487
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Feb 2024 14:20:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=sYJVVMeR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.41, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-58e256505f7so849520eaf.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Feb 2024 14:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706826032; x=1707430832; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z7qQ4lvGVpwHezKVGZRRNc2kC+AzngeoMonNYLCYM3I=;
        b=sYJVVMeR7zJiGTecIiJPkKeyEpZC3MUlxrjjZcQ8UzL7gViUvTegrzLZgWpaLlefM1
         kv0rp3SzF2qu20DmkFEv7FnkHASTfmjYrFpxxUmg04RpMa6gIbnXYZrq0Aqp1vrYpAEg
         d35ueoHEdaTY/KVqZkd/yBR/ynXv4CHQOC+5oPyyNgIJ/I8g/4RPPkeAv+Bdtcb/PItn
         FdhWkLb+1galUc79TbN423BidWqL2fGv/mBvG9F+ByxY7l0U3qSjzttKGwUR29GEUlAu
         6AQ4uODg+XXUYRRStLPj6W0XR+0ssixDymHwvrheLhD46r5TG/060csi0I5bxeJApOnL
         Zxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706826032; x=1707430832;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7qQ4lvGVpwHezKVGZRRNc2kC+AzngeoMonNYLCYM3I=;
        b=PebP2PjbgF2KHPvXBfEp32EtTe4z71fr0CG60ppaDYpFvN6zVsol9cmeMbmLHhPMpZ
         NtDTd2zJ8e9y6FqMfFLdNbIu5bGS0VdwMytzD8M8IsNo3YrTfu1cltCdqNJmaqC1gD4+
         2Ctvec4Di7eKzM/Wt+amqf1OBvyPiUlo7MPdWvl7wTFIBfbdYtv7XpZVLFtuKh+aAUDM
         XBXuwFnHQFcuPnImgOmUBkL64zGiqbRrqmCo0kZJ56Ed9To4VmsA+v7/jq0I4lA3JbSj
         Bkq6qSemugJqiq+Yg3latLC5ku9ZRCS3K+wa2iRwP4jtQxh9WM2cMwOhX5/vitrtEErN
         6vtg==
X-Gm-Message-State: AOJu0Yy5lcjjh5v6NR4h1Btmm04WpapJpBiefwFEnZafhFRwAjCS7OED
	TaeH7bY1h+v5tMroBHaxOt6x+c7Ny3ab4ZZPTR1tjj9iwd9lZPrZNt4Og64JIktc7TKjFUIFPzo
	8
X-Google-Smtp-Source: AGHT+IHiHiJrE1QZUburEcURq3QRmy99As31IDlQrxjLqyQTzzYfIwwXDDQ6t1uxLHak4cUOdJICAw==
X-Received: by 2002:a05:6358:441e:b0:176:7d13:d70e with SMTP id z30-20020a056358441e00b001767d13d70emr232875rwc.16.1706826032491;
        Thu, 01 Feb 2024 14:20:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWrWX2xpmZtFAwdeKfh4lHNo/GgK9vUdxux4lFdRQqyQQQyq5KrhxE8a/u/1H6HP874aoVVMBhYTKJa9a3ckToM5viY4CXxnXQRW2IOJENE3B+HMXl0/mQTKJhJ+R074HLDhZzEtnEwEYul+0ndIiplvg==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z123-20020a633381000000b005d3bae243bbsm344240pgz.4.2024.02.01.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:20:31 -0800 (PST)
Message-ID: <65bc192f.630a0220.979f6.22d5@mx.google.com>
Date: Thu, 01 Feb 2024 14:20:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.208-cip43-4-g1c63c70fb18b8
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 13 runs,
 2 regressions (v5.10.208-cip43-4-g1c63c70fb18b8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 22:20:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14591

cip/linux-5.10.y-cip ltp-fcntl-locktests: 13 runs, 2 regressions (v5.10.208=
-cip43-4-g1c63c70fb18b8)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.208-cip43-4-g1c63c70fb18b8/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.208-cip43-4-g1c63c70fb18b8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1c63c70fb18b87b5bcfe5d7ddf0096c92a1557ed

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc095340f9c74e8600a07a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65bc095340=
f9c74e8600a07b
        failing since 120 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0cc34ef4e314af00a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65bc0cc34e=
f4e314af00a03a
        failing since 231 days (last pass: v5.10.182-cip35-1-g7cde3fba93966=
, first fail: v5.10.182-cip35-8-gdba81ae6f2be) =

 =20

