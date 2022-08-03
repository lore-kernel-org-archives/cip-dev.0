Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F48DC19F2C
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 18:19:19 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.190.1659550749258018665
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 11:19:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=BtoetRfH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id z19so17164145plb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=NDkPo7JJk7IWogotqb9KtjnGTYVVuasjdRYWoVMRncg=;
        b=BtoetRfHPFH9BnTg0h7vKJ7Br3+DH/3KAV/G6LFOJ5xKmqYta/pqoUkKe3pwP4ixu/
         8gYs/XkvWpRSGb2toC7nRGrr2ZkoC+D3SDaZwhfRYnUjwOsymodOJ2UsLlZb+5QUhi8p
         6RVHNDFWIXllwGSluVc1D6hWMTTFszz/q6A+5KOG+aU4hsqlEI0Lsa7EG27xFtOW8EIh
         swWIYn/Y301PhZI46BIN6NBLL7Qftl+YZ2mCT1A8PElI9V+u0/v+x3q9IplN3rv0OeHX
         ppUsqxW6bwu4GPDBqIfub3WL0xBq5xxi48gbsUFMAlGh+iGcnoOX6XmwuQPVwuK70UjJ
         F7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=NDkPo7JJk7IWogotqb9KtjnGTYVVuasjdRYWoVMRncg=;
        b=751xaOpHH/+sWrK0eWySxyx/L9p17F0yvjSH1JGnY0PrlEqeHYICAWbHgRJfsdNM1R
         OlH4mvGkczDSTTD5bTCUl3RrpBdnvNNa6d0YflisFAZiobQbgp2q1XrJeqXtfEbWbGSM
         XZdeA/R98TgdNO9p8kGbrmllqOtQrTShQDqi7BDKn0V4t7/+iGxl/XYDRsU+OvKTYTJf
         8z5AhNJ5vjV/dBxlUiCMU27wemiThLqfSfvDDJ1qYlj4hyP7NiH77rCKSoZBxTfhMAfe
         Qhf6UuPIHprUbQYsfYWS/6K/2P20fdVDQjaDpeVCoJ1YZg+P8aCvClUiUhkiAHU4mLRO
         yFyg==
X-Gm-Message-State: ACgBeo3hWDRvfG6efOo3HSWsnaJjdZvJ2eDTu6OgQQqtyoonoUKkuZBt
	svTOBt3EAx4vAziLQva0Ji/y7NEPmxoxdlYywDQ=
X-Google-Smtp-Source: 
 AA6agR5jaXcqstqVSmKbIkfCL8EHJzP3X50X3Q/j1EgfY8q82JV3T+dteGN+vrPPpnsZEMokLkxo6Q==
X-Received: by 2002:a17:902:a502:b0:151:8289:b19 with SMTP id
 s2-20020a170902a50200b0015182890b19mr27076022plq.149.1659550747117;
        Wed, 03 Aug 2022 11:19:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 h10-20020a170902680a00b0016f15140e66sm2146692plk.202.2022.08.03.11.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:19:06 -0700 (PDT)
Message-ID: <62eabc1a.170a0220.707b1.3ac0@mx.google.com>
Date: Wed, 03 Aug 2022 11:19:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-24-ga6f4ea41fe167
Subject: cip/linux-5.10.y-cip ltp-mm: 5 runs,
 2 regressions (v5.10.131-cip13-24-ga6f4ea41fe167)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 18:19:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9104

cip/linux-5.10.y-cip ltp-mm: 5 runs, 2 regressions (v5.10.131-cip13-24-ga6f=
4ea41fe167)

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
l/v5.10.131-cip13-24-ga6f4ea41fe167/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-24-ga6f4ea41fe167
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a6f4ea41fe167f956d4000eaf276a1e383603071

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/62eab0f2421e00fccbdaf06f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62eab0f2421e00fccbdaf070
        failing since 203 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62eab2db00e5a6784cdaf081

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62eab2db00e5a6784cdaf082
        failing since 203 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

