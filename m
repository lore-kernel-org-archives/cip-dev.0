Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47673C61D97
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 11:21:56 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.133512.1700824908913424417
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 03:21:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ev7tu2oT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6c33ab26dddso1459704b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 03:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700824908; x=1701429708; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VOC70CJeBDbeL54JV4vKed6J4RUxHqi4yjzMRueCXek=;
        b=ev7tu2oTANNVHEAtg7AVBZ9NDLmdok10YBPkhGH46XrtDN496koq7RG1wtx0Gvoe2V
         3AEIQGAWS3O8yxasPovo22Nep24VCNUPPLd7f7DNufi7jrn3vM6+tsBmXgJPt9ODfnli
         Ug25yehsNORRxB9KQuDXGHYmEa+baeuyDl6MQmln8cGuD99A1fzzNB12W10lS+dGgb/l
         ldUP4DgksBvxwlMuhmOEJyyE16cunf5fB22Qt9V+/MndRgNByCjIJVcGIyZFAlrVm0At
         mf21PfNBe/wvVAz7Hv+rXXS8WDtWlgGRGqyF7HBDaIMv2NcOUDtbRY/bTRadzEan2xmT
         QvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824908; x=1701429708;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOC70CJeBDbeL54JV4vKed6J4RUxHqi4yjzMRueCXek=;
        b=AGM+ABQIlkuhiDGrFa+vUjpTZQbf8zuf16rNI8h29l3qKoU2mYUzPbeu61e/Jrd1WF
         sFvAi+MxKp+CJh2aCM7gJX8NAz78dbIUdTQUQuCcVri4wSBrMn9OR1DCD49OmWeF/Cbv
         ZALUHyZnetsZrGgXzn3SQoFXVFf0LRpprOgrI4ebyLSrd8nNilC7EZFT/mzeFCZwiLPu
         tM7OrOtUQogo+SRLzbRlOlT4R7ENiY51t/2eKo0nZCta8hnFX7EDnip1zSP9nsoZcoz5
         xguA6hAVYoIHvvFc767hzrnKxSRlax/PDJ3tmxqEqqvKbvEksIGykZI1wp8w7nVOGDYm
         8BXA==
X-Gm-Message-State: AOJu0YzZxwAICFBeYhKDOv11O63a9QrANWQlJhjqZ7W/8S7di1ecYbCk
	k6CDapfwe+FpG9jAnd4MrZMH+IBCRVZJqISrwmo=
X-Google-Smtp-Source: AGHT+IHfJ3UFvjDWX0Jf8Ngh3t+5Bp6+ilbimKOEZ0mBjh6iQfu9pEf/dubfXJvpaYMKrsDlBUK97Q==
X-Received: by 2002:a05:6a00:14c6:b0:691:2d4:2389 with SMTP id w6-20020a056a0014c600b0069102d42389mr2765708pfu.21.1700824907712;
        Fri, 24 Nov 2023 03:21:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i23-20020aa787d7000000b006cb4b7ffe2bsm2635781pfo.195.2023.11.24.03.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:21:47 -0800 (PST)
Message-ID: <6560874b.a70a0220.55ce1.5ccb@mx.google.com>
Date: Fri, 24 Nov 2023 03:21:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v6.1.62-cip9-12-g3a5321f469b07
Subject: cip/linux-6.1.y-cip kselftest-futex: 9 runs,
 1 regressions (v6.1.62-cip9-12-g3a5321f469b07)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 11:21:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13721

cip/linux-6.1.y-cip kselftest-futex: 9 runs, 1 regressions (v6.1.62-cip9-12=
-g3a5321f469b07)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.62-cip9-12-g3a5321f469b07/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.62-cip9-12-g3a5321f469b07
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3a5321f469b07e6124d325d7faaa2f8f1993f67c =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/65607ab8c9e8ef40ac7e4b2b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.62-ci=
p9-12-g3a5321f469b07/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftest-fu=
tex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.62-ci=
p9-12-g3a5321f469b07/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftest-fu=
tex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/65607ab8c9e8ef=
40ac7e4b2c
        new failure (last pass: v6.1.59-cip8) =

 =20

