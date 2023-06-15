Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F634EB64DB
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 12:56:51 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
 by mx.groups.io with SMTP id smtpd.web10.17413.1686833801811664567
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 15 Jun 2023 05:56:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=sev0wkJi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.52, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6b2bdca0884so5753844a34.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 15 Jun 2023 05:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686833800; x=1689425800;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dcQ4McclNu22FY46759z3581ur1p11JtscwqByyIH+E=;
        b=sev0wkJi5wocsRToW4ymrkh9506MeQ+vPWirECI6SX2jTLlv6/Npk6Ec563/SxyNj9
         LuQ1xctEXKuc3ZTGtttwwNt820ALgXeeCdJg/ADbzSYY+ndD6lGkeI/PytQJIqiZhLDj
         Ep3/ZsvQvvjmeKP3YpcRO5S8LIV7NAZMddDTUECl8Dep2Auf/F1Iy/+GfHeN/vyOj9tj
         H1Jr5CGRR3ovkAS2OZarCJL0sk16C2VOP67pA7drO+Rd+hDTlFQCFqE31kbXdlZkVTXQ
         RDvkT/U51XId3Ymz8x9pJ2uztYZ2lEXeNdJwZy2ZAAIRCAx/z/hTAUQORLa70mconFu6
         EbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686833800; x=1689425800;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcQ4McclNu22FY46759z3581ur1p11JtscwqByyIH+E=;
        b=HnkoHHp9EZjFWhLULmSt4eNYq0CQSiWAkM/rXfU3+afOBC3qxZ3sRmX7+RpXGwy5TZ
         Iag2X+V/1Ou9i9O1oTCBY3LX2EcDNbidq6Urk8Ht0xcaTBrVEDcshB2yKupJZ3q8sURh
         J7K9ieOH3ZvpsydYrPAZ3YsdgE8u2tVJICC8s4g1+ovGle8Adh4pJLTpY3Zdpw6j6taz
         Sc7tExvA9hfkBCLuAxuHcvi/4slj2UPlHT/QyNNnMnR53zKJifDVTw9NXr2kSaOeFSAx
         Ahg1zH28c/icvqihT3pedVuCn81HJ4bwV1t7ZKUmKIPcPbBTTCFqxciIg87fREHGulv2
         /m8Q==
X-Gm-Message-State: AC+VfDz8Aele8XUP4duT43d/4oXzFYIIC3IIz6ljKowQ3kFQhFRxUw+C
	onu5C+sk5kfR9BTbR2c+95aX7Hmti53qmeb12kEOxQ==
X-Google-Smtp-Source: ACHHUZ43QkicWxZs2GXwaSFY69MxXuNMOEOftGzFWlHQH2QtIcB8zaaGh4FeFCZS2BnBaQo4190tKw==
X-Received: by 2002:a05:6870:5ab5:b0:1a6:c8bf:b411 with SMTP id dt53-20020a0568705ab500b001a6c8bfb411mr5671617oab.2.1686833800591;
        Thu, 15 Jun 2023 05:56:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t26-20020a65609a000000b0053fed3131e6sm11600717pgu.65.2023.06.15.05.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:56:39 -0700 (PDT)
Message-ID: <648b0a87.650a0220.b5de5.653d@mx.google.com>
Date: Thu, 15 Jun 2023 05:56:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-53-g486caac40d06
Subject: cip/linux-6.1.y-cip kselftest-filesystems: 8 runs,
 1 regressions (v6.1.31-53-g486caac40d06)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 12:56:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12059

cip/linux-6.1.y-cip kselftest-filesystems: 8 runs, 1 regressions (v6.1.31-5=
3-g486caac40d06)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.31-53-g486caac40d06/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.31-53-g486caac40d06
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      486caac40d06a2c987e5514b550d341cf6791b17 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/648afd89b207de524930612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftest-filesyst=
ems-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftest-filesyst=
ems-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/armhf/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/648afd89=
b207de524930612f
        failing since 8 days (last pass: v6.1.26-1314-g1ab0ac1d7e2e3, first=
 fail: v6.1.26-1320-gc38e4a9845945) =

 =20

