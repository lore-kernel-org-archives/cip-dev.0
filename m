Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB90C00140
	for <webhook@archiver.kernel.org>; Fri,  5 Aug 2022 03:24:16 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.3069.1659669849542951233
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 04 Aug 2022 20:24:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=tB7JJet/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id c139so1197268pfc.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 04 Aug 2022 20:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=t8QdD9P5iFkBeU+ARX9UoyERe2XT/2ZWhKMtsQY+SBs=;
        b=tB7JJet/0hbbmJPnPCxGoYX+ZPoWgyDdMYXEbnd4FihPfTazfmndvipm9UHvvP+2w+
         jc4FjxRAMz1yDM9aC4tCbND2Ag/vy2tZMpafVzdP6+Yyl4JXrzb9B86JtfSQkSN5yVUy
         hl+34kXlVaxW+e2jnj3uIJ/ctgx9fGaN6hg+CzZuDOlr3TBtpPI7UxH6QYgebd+AmwXc
         RFP+Tmq3szxiYRGcMnOZKn6Q5QwXBGPbDkz4IKi+0jVcPeWuo86s2ER4CZ4+7IF9oRuW
         CzjESBuw5EG9yz3vRsNosCC94XGUDkLamXy6+0Qm2AEynVwRl4iSIq6sWnnIm71QbUla
         RiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=t8QdD9P5iFkBeU+ARX9UoyERe2XT/2ZWhKMtsQY+SBs=;
        b=1AMswe044PVq/HJ0Jw7k4o8StWNViQdWe+X7zunidO2edGaxqRdUffQoi8G+7a8wp2
         jTxdnayw63yvfXwd0vCHmODzw57cJaD3G/7Z8OMHSMjF1qFQA3ro/BuZ3eF+tWQzYdN+
         KGBiFaQYxQf3M8uvqI4wJd7WtAVqpMgH0S6Ip/uSPjDYzgrD8e28lId9lQRsj96HCCzT
         0MV1iInTJLUdd7lC55USyyGSSDCD4kTzdKEsORoKsc5AhNBe04m9zJICE9kZ935cIkBo
         boYmwPN5IfVfkrm68e2W6BO2wJKsG9gOyQxijrnhDUTBbqf2pb+U4qxmFuPt/N5XAeR9
         9E7A==
X-Gm-Message-State: ACgBeo08cNrtl+qYZxBIAwZoPRNg6ISqnUCeyf3/d5mRC9cbrZVlpWaH
	+0B4cP6QB2uLbCGYCgQaARqO3I45gB38bOUtTpg=
X-Google-Smtp-Source: 
 AA6agR5hfG3oS7UaJEi+qHQm7MPPoffHPbBBYqRoN5e/k9I1ztbOFLmYETTU7IiBK9j0E2MZYp0MLw==
X-Received: by 2002:a63:4503:0:b0:419:7b8c:cb11 with SMTP id
 s3-20020a634503000000b004197b8ccb11mr4090209pga.446.1659669848922;
        Thu, 04 Aug 2022 20:24:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 l2-20020a622502000000b0052dd9dbe291sm1744403pfl.105.2022.08.04.20.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 20:24:08 -0700 (PDT)
Message-ID: <62ec8d58.620a0220.adf67.399c@mx.google.com>
Date: Thu, 04 Aug 2022 20:24:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-37-ge3a52725ce96
Subject: cip/linux-5.10.y-cip ltp-mm: 7 runs,
 2 regressions (v5.10.131-cip13-37-ge3a52725ce96)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Aug 2022 03:24:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9132

cip/linux-5.10.y-cip ltp-mm: 7 runs, 2 regressions (v5.10.131-cip13-37-ge3a=
52725ce96)

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
l/v5.10.131-cip13-37-ge3a52725ce96/plan/ltp-mm/

  Test:     ltp-mm
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



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/62ec7b4bb7cd01f815daf089

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62ec7b4bb7cd01f815daf08a
        failing since 205 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ec873f91e2b23a15daf0ac

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62ec873f91e2b23a15daf0ad
        failing since 205 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

