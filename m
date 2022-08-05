Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71BEC19F2D
	for <webhook@archiver.kernel.org>; Fri,  5 Aug 2022 03:24:16 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.3067.1659669848196917197
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 04 Aug 2022 20:24:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=mMmiRUmO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id 17so1223825pfy.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 04 Aug 2022 20:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=U8MtAtWh/3CD7dZFLf4cQmkXyksnvDfWras4cfbK5dQ=;
        b=mMmiRUmOFLqezd6YilrG3nM3dx3PaJFwZw85cz4w+1uNwyh9k7rVE+QJT2iZtzIOA8
         t/tAE9r1Q5FyOvV7MWn6wF02Smppz21M0Z02rG6u3pX+HX1xxdMnk3PYVsEJWH81JYmF
         wUn7c7RMg86IMomeZIbpZQ+kZp4OPvENGW5wPM4N3KuGSBOV3cUAyyUXdZd/okh5gWPV
         SZLJZjEfN8szvlYK0Vvg94DZYkGb1AGPPph+9dP2r7hTW0vjFP/DCDh4eEd/SXiCtHLM
         XMiqmSE5joaAto0tpwVG3VFO9Y80R6pJaWWXs5YlbkV+mzFU/gxJN/VXHWTm0zuMGS1Y
         tEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=U8MtAtWh/3CD7dZFLf4cQmkXyksnvDfWras4cfbK5dQ=;
        b=FitCgFCJK4/IqXBVIZOS+S+k5lBEgA8mtCrbLruSWiL+cci5APnWXJO/qrrBojNmA8
         Fs8C0ua2sZ54DN/E7F0qxsBfmC9GA+k7H1Em4j9dSiwh0bEvq5ubWErj7WN/XJGA2s9S
         Ici79gjH9v3tEHL3YNw++FZ1ml2SqGkJUyV8+b2ZmnD9VxyMCYycQjIgEwf8BnSlxpld
         eP60bZoLLOTX9hAUiAg7iAoUClfKtLs1IfS5K6umrQ3FAacdaHutR9qFssqJqeuFN1wH
         hhPGUsFgrBR8oYsYN10dvFWCI7lrsRQJ44Z9uiHSkjNGJfDly8HWLiy8LyHixjtUZ1pT
         6VxQ==
X-Gm-Message-State: ACgBeo26Kx6wgqZUTfwudNVfwW569J5trY5HeYqpu4xKL7D119jPTKQv
	hPJQutr07jitKlT4cyEoe/e6aMY4A8WAcBIGvr4=
X-Google-Smtp-Source: 
 AA6agR66sMIcgEoDrMeBOia6eldubgtV1u7jjNlLzh+66BDCbjt0tRx956pY5LLdzxe1w8G9HycF5A==
X-Received: by 2002:a63:d64e:0:b0:41a:b83d:1b2a with SMTP id
 d14-20020a63d64e000000b0041ab83d1b2amr4003434pgj.122.1659669847532;
        Thu, 04 Aug 2022 20:24:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 k2-20020aa79d02000000b0052dfe83e19csm1857258pfp.16.2022.08.04.20.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 20:24:07 -0700 (PDT)
Message-ID: <62ec8d57.a70a0220.8c0d4.37fe@mx.google.com>
Date: Thu, 04 Aug 2022 20:24:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-37-ge3a52725ce96
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 8 runs,
 1 regressions (v5.10.131-cip13-37-ge3a52725ce96)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Aug 2022 03:24:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9130

cip/linux-5.10.y-cip ltp-fcntl-locktests: 8 runs, 1 regressions (v5.10.131-=
cip13-37-ge3a52725ce96)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-37-ge3a52725ce96/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-37-ge3a52725ce96
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e3a52725ce96e4794cc31e31ccd20914f40f19a3

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62ec7f6e243494fd21daf059

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62ec7f6e24=
3494fd21daf05a
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =20

