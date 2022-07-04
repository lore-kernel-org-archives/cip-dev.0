Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C274CCCA47F
	for <webhook@archiver.kernel.org>; Mon,  4 Jul 2022 08:22:49 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web09.70126.1656922965958404419
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 01:22:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=NAvazMYR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id 128so8287452pfv.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 01:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=1RdbwM0lj9iU4/y5umtiuNIBC8EIjDT9HX7RXe2UO1A=;
        b=NAvazMYRD+6cAuIiBNMXGwn8p5sH3BI+sz8LUdFVLDRqtV0/EGesi0oN9r+PcrlT2B
         8/Fl1I/EUGUho/W0qCvBE/pDHOAOv2Q33lwgnTcXs9j4ORm8pmY2HE0zs4e2AJDHTyfT
         Dl8QzAB8PLFEth26ogummBhzPEFq5AesMwj2sxQOgbL5svJb0/xh0HsJjTDb3no3FaH9
         HdEClrBZnW+5K27TT5cnHziEQCtCqsnrqGLVAxbt8Cm/4ZUX1Qa09+HK3CWVw3QyIl6d
         0UAZLB7UPooqCIRMkF7qVk8fgohWUykBbxfUt1Q2ZGwT/1wxlPdFbnjoYPG3brI3pSGw
         Tqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=1RdbwM0lj9iU4/y5umtiuNIBC8EIjDT9HX7RXe2UO1A=;
        b=mqtIFVauOoNoRChj6iFJ5CX1HWZqXQ5U1nJ3PT8T3tIAqWYtdgGUGgAevshORPRATR
         f92iUlLou1hw0uuN/dRtxM4I5CmWzkPIKXiJe47bti22idSSmaUBQCqj21nSzX3IFx8a
         0dmdtKDGUQt6ISpZQGbnDCbL2/wtJE7o+D1mVxHGq3TWSLPSyJHeE/e107xIMGMBicwY
         mqEV2SIJyieHbKabGYPDoL7d9PEtMXfW3NL8/qbbz9UNYqbykoL8A6CXRK8XlfOPR8qO
         KpPglPz37Xp8nuvABLMilpgJ+WFzQMChQzzK4dGA9oSWkaTD9kYWddnu6FKkgBHb1Qbr
         bo1g==
X-Gm-Message-State: AJIora+a7x960ucc3Tm9ngNXUn8dAeZo3rapXDuWMDK3HYB11H2b45rw
	ADafKmJkPfm5yPy/MMbE//KuPwsGZBnhRZzI
X-Google-Smtp-Source: 
 AGRyM1tjC/Py/LL0klKNmast9ogFKFwVuVS/6nv1UWqpkfIlWX/CSJC8OKm2gblcuztwc2hfvlv+NQ==
X-Received: by 2002:a63:694a:0:b0:411:4cc3:711 with SMTP id
 e71-20020a63694a000000b004114cc30711mr21534574pgc.445.1656922965336;
        Mon, 04 Jul 2022 01:22:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 a15-20020a170902b58f00b001677d4a9654sm20437435pls.265.2022.07.04.01.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:22:45 -0700 (PDT)
Message-ID: <62c2a355.1c69fb81.86210.d8f1@mx.google.com>
Date: Mon, 04 Jul 2022 01:22:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-mm: 7 runs, 2 regressions (v5.10.126-cip11)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Jul 2022 08:22:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8648

cip/linux-5.10.y-cip ltp-mm: 7 runs, 2 regressions (v5.10.126-cip11)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.126-cip11/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.126-cip11
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      400500e48ef52304feac8a819c6c911660ce59d8

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e98f9465925434349d0aa6eb71e81b5464e76df4 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/62c296c3c70fd4b53ca39bd3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220610.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62c296c3c70fd4b53ca39bd4
        failing since 173 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c29c27f5d0584981a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220610.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62c29c27f5d0584981a39bce
        failing since 173 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

