Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64787C10DC3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 14:02:07 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.84311.1701957719075927184
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 06:01:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=mlQKBaB9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ce939ecfc2so565874b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 06:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701957718; x=1702562518; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zsfjo8jC8LbjwHm4gtnpjcMYAC+FZTv1jNLlkRXxHf4=;
        b=mlQKBaB9iZJAaV9n9AK2n6rLOCeYovpdMSQA4kYanoSjstckM1zNyVomeSPz8n5s0J
         HYdp+xGn0M5RV4gCzmY90TphfshBAYImME/Xv9cK1XCxWsLmICHOPX9M6dd8PqSQvobX
         G0weHZN75yr7hy7pAA0fI3tGcDQVWCRhAqPzwQfD3vMMGyUj3ECYemscaIhaRQOYnEHD
         /LtmA0blEpMIr+j8YmLJdl13H63LJzlVyueD0dmojW/PWFP2hB/q3elK2PLnWsidRswe
         iY2edUuiy0/HdaO925yjTTRUF9Zh8JwLlVguLihU5n3GrI1uZNxE2hjjtX6TraJHbQtM
         WjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957718; x=1702562518;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zsfjo8jC8LbjwHm4gtnpjcMYAC+FZTv1jNLlkRXxHf4=;
        b=qp6WlEEijYhKXRV5WIdf9Q0HUAvdMYGopEZxUOoVOQIt4CVxo1HeSIEnwiJwJsJhSY
         xaSSKyMHCK5EfFTphrteBfOSlOREUVrkcHls8VusdbOfeIePvX72ne9qq9PetkxDU1ln
         knWnX0JSw/D9XNTbhpbqUBh/6cadsaNWGP+P+JQZ5lPrYUP2XwnWDDou596kaMdbelKM
         qtdCwpNMK97sZ/jI/OMShosA+uhzQW+IqgLs7nU72uq/YpmaaqyFTp1qRBLTRi8oAYOq
         BqR8Gngukv6XjeE05WTvd/Mp9raotpapKmYihjsj8F/p9RpyRm6MZALjmULa/zhL4bmG
         bokQ==
X-Gm-Message-State: AOJu0Yx0pL3IxpQPQS7Vao7+Aam8AFkCfQUVA0jMcy/G6xlbZ3fGW8sL
	FLG57Zv2IeYRwJcHElIwAS20Jn0Wuu5n4F4OgP4SUw==
X-Google-Smtp-Source: AGHT+IHSqBPvMhLpDfNpa/n6D9iIkdcMFsRQLNxny9EAQRS+XZKwudwy7p9GIAhrEN4oa2H9+FcnBg==
X-Received: by 2002:a05:6a00:27ac:b0:6ce:8388:4c9e with SMTP id bd44-20020a056a0027ac00b006ce83884c9emr2496885pfb.45.1701957718063;
        Thu, 07 Dec 2023 06:01:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h3-20020a62b403000000b0068fe5a5a566sm1357456pfn.142.2023.12.07.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:01:55 -0800 (PST)
Message-ID: <6571d053.620a0220.430a.33e3@mx.google.com>
Date: Thu, 07 Dec 2023 06:01:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-16-g3c85fba3b6e5d
Subject: cip/linux-5.10.y-cip ltp-mm: 5 runs,
 2 regressions (v5.10.201-cip41-16-g3c85fba3b6e5d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 14:02:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13865

cip/linux-5.10.y-cip ltp-mm: 5 runs, 2 regressions (v5.10.201-cip41-16-g3c8=
5fba3b6e5d)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
               | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-16-g3c85fba3b6e5d/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-16-g3c85fba3b6e5d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3c85fba3b6e5da8b112e7ecd142649674648028f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/6571c0317c12c5478be134ae

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6571c0317c12c5478be134af
        new failure (last pass: v5.10.201-cip41-11-ga539098fe70dd) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b9716cb1d87f63e13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6571b9716cb1d87f63e13477
        failing since 694 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

