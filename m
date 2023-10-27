Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B37DC25B47
	for <webhook@archiver.kernel.org>; Fri, 27 Oct 2023 14:02:37 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.7704.1698415352339523208
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 27 Oct 2023 07:02:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=nkau0uYj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1c5cd27b1acso18908175ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 27 Oct 2023 07:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698415351; x=1699020151; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8cj31xSoDcjDRHl7wkxk/HBJM0uSRZIyNoExiDloGa0=;
        b=nkau0uYjIyIY/1j8qgjkARUYUeDWWgGoO3oZGL9OIO8OYi1/uONYsrs3YQg+q8AJBw
         D/uguzZU0H61UXAz17ZBHlYcsYcUmF1DPZe/JIc/La7IkAdm2tfe5VfK/YdtJ7/jVCjL
         qd2f0yTVl1qjpVXxaBhIlXDIhqyXR+eQ+Yr1lsEQ98N46cYysq2GnoEXfqebtaWJgO8s
         0AIDj9uipbQG6KioVogibCWWxqYa906Kp6CYn/bKKyqU8PGza69Ecq/pD/ZtUXEjjZpU
         FbE8hGnh6knZGFrzV6xpGIH3smKZsG8kUo7Hd0kqfirkx0qHBTcwaGL4kqLqCgqhM+zA
         zUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698415351; x=1699020151;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cj31xSoDcjDRHl7wkxk/HBJM0uSRZIyNoExiDloGa0=;
        b=VA4Vsbg+/A9SF15BcCBcCVbeTVbBxQzXiFe9K2OJ8QCT+tNuwXJO2a2lMe0L1o4cIU
         AizO2vzm9/kCkhKJOcmeDlnNY1PChNMXDc1SlHCxx/u9HN26ULs1r7uNoupbiaMwcFD5
         GJSoEk5UiSfVy7fThPkPi/fJ682x+So0BYMph3GhVeNvS5Jq/X5SpzewJ0DbKJy+KoCN
         upvawfcdrq3rW+cDdRb4Pe2zyWf16VIC/nv/ZoSvpv26J+wXYZmm2Lwk1EmXEedraTjQ
         +CCYY6/XhDd6m/8ja0pbxDRCGeoz/fUOP6ojOTfmJR3cwxgwpxMS3Y0V8GzZDi1jGFPn
         WvHQ==
X-Gm-Message-State: AOJu0YyiZwE8ziRl5zDdNAmjtHGaA2pMIKic6Z5WS4gtPsZBfTtDnHRq
	8i3dh9NUAKqIWEYxSzUWL/r4gNu9P3QBzVbcN70=
X-Google-Smtp-Source: AGHT+IHHOW1zxMpqidomLk4JTWI1bcjstYVfyUlyhHpj5J6xc/y4LLCuFDShLk8JocLCpE9wNtxwSg==
X-Received: by 2002:a17:902:f1d2:b0:1c2:1068:1f4f with SMTP id e18-20020a170902f1d200b001c210681f4fmr2398563plc.17.1698415351190;
        Fri, 27 Oct 2023 07:02:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ij27-20020a170902ab5b00b001ca4c20003dsm1622129plb.69.2023.10.27.07.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:02:29 -0700 (PDT)
Message-ID: <653bc2f5.170a0220.1d084.4ade@mx.google.com>
Date: Fri, 27 Oct 2023 07:02:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.59-cip8
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-6.1.y-cip baseline: 123 runs, 3 regressions (v6.1.59-cip8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Oct 2023 14:02:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13481

cip/linux-6.1.y-cip baseline: 123 runs, 3 regressions (v6.1.59-cip8)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig          | reg=
ressions
--------------+-------+---------------+----------+--------------------+----=
--------
odroid-xu3    | arm   | lab-collabora | gcc-10   | multi_v7_defconfig | 1  =
        =

r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig          | 2  =
        =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.59-cip8/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.59-cip8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5ac26de5cee674d669fd90d11fb844eaf356ec9c =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig          | reg=
ressions
--------------+-------+---------------+----------+--------------------+----=
--------
odroid-xu3    | arm   | lab-collabora | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/653bb5647bbdbab2f0efcf04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.59-ci=
p8/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.59-ci=
p8/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653bb5647bbdbab2f0efc=
f05
        new failure (last pass: v6.1.58-cip7) =

 =



platform      | arch  | lab           | compiler | defconfig          | reg=
ressions
--------------+-------+---------------+----------+--------------------+----=
--------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig          | 2  =
        =


  Details:     https://kernelci.org/test/plan/id/653bb8f09e06287794efcf27

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.59-ci=
p8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.59-ci=
p8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/653bb8f09e06287=
794efcf2a
        new failure (last pass: v6.1.58-cip7)
        2 lines

    2023-10-27T13:22:17.859799  kern  :alert : Unable to handle kernel NULL=
 pointer dereference <8>[   23.279296] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=
=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D12>

    2023-10-27T13:22:17.860307  at virtual address 0000000000000008

    2023-10-27T13:22:17.860584  kern  :alert : Mem abort info:

    2023-10-27T13:22:17.860822  kern  :alert :   ESR =3D 0x0000000096000046

    2023-10-27T13:22:17.861095  kern  :alert :   EC =3D 0x25: DABT (current=
 EL), I<8>[   23.302199] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=
=3Dfail UNITS=3Dlines MEASUREMENT=3D2>

    2023-10-27T13:22:17.861365  L =3D 32 bits

    2023-10-27T13:22:17.861592  kern  :aler<8>[   23.312555] <LAVA_SIGNAL_E=
NDRUN 0_dmesg 11893591_1.5.2.4.1>

    2023-10-27T13:22:17.861818  t :   SET =3D 0, FnV =3D 0

    2023-10-27T13:22:17.862038  kern  :alert :   EA =3D 0, S1PTW =3D 0

    2023-10-27T13:22:17.862255  kern  :alert :   FSC =3D 0x06: level 2 tran=
slation fault
   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/653bb8f09e06287=
794efcf2b
        new failure (last pass: v6.1.58-cip7)
        12 lines =

 =20

