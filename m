Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E48CCA479
	for <webhook@archiver.kernel.org>; Thu,  7 Jul 2022 07:07:52 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web12.2777.1657177662724098441
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Jul 2022 00:07:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=h3lLvp10;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id l124so7206025pfl.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Jul 2022 00:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Kg/q7iPDiWv07kVsBx0we5ATS0N0DZglfXef8jnVaxg=;
        b=h3lLvp10+96oEnDAtEUfBLNfjZd15mxfa0QJ8Oq8GfpwLc1DQfyFq23rc3K2LZRRdG
         G4wV7wLn4crMccIXOBaGqSVZm6lAKrsa37FESIgyJBstzT3loWpwPFbDRvMY8XNIKluN
         ssaNxavvaqS71rt43BpdnK+KB6OkTV30ftOYUMh9SD39p7qlSBWsxWS41gpm23MBjVU5
         EteMiIUPX2SaWIdMAUjXmKqiyAQ3m8rQTrZWVey4HWIioGcb6/LVdX/0bKueYZQaaXMi
         WIdBbWPPyDo2ED5Gn93Ub+KY5gkOlKFS+yjAgQKGRCQCZ9BgnaG51MqZImXfww0cMJAF
         A4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Kg/q7iPDiWv07kVsBx0we5ATS0N0DZglfXef8jnVaxg=;
        b=w5J2JM0ueRPHouq4RxuxeKhGfuyd4VoCa6J4YIb9sLLnAR7qlNtOYpFlM+rksexkla
         HmlbmNAzUzyP1hrkzivzRyDmZunxXgyat6bQdTQVcCuarHCrEyWGp3nHtCqA1N47kr79
         k6cb5Gtl4UpmuSQcG5l6bDlxMNSvXz5JChWY/oRfxm1TA55ujTlYFc4KJXmXjAwJNu7B
         MkCsqOVPpwTpM//9R06AAdDJmtguuymN+53S4sTOKK1Yuk3QjiJP5CfmzcIbgZoS9tkR
         0jtdPPXGKMNah7gG+Bua/aILCScgjYHOwn3dBBBOQcCZc3YMHdFQpKak+U9rI0IuHB2K
         S+1w==
X-Gm-Message-State: AJIora8jMKXSD9OyeaSiwZBcV5mSRQnrBsw9w9jvqt2ExVnolhG0aWhC
	9zFuw/jAm2N18ULtlhmSZra+LcuySHj95q/D
X-Google-Smtp-Source: 
 AGRyM1tMGzH8QHYKtb6KilS4kr6Va3HwoNB3DGV+LMQ0e/0c1X9XXI94UexmIvHP0T8y5ZpbK5iyqg==
X-Received: by 2002:a17:902:8644:b0:16b:ea77:a6cb with SMTP id
 y4-20020a170902864400b0016bea77a6cbmr17500848plt.59.1657177661925;
        Thu, 07 Jul 2022 00:07:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n18-20020a170902e55200b0016bc4a6ce28sm5464911plf.98.2022.07.07.00.07.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:07:41 -0700 (PDT)
Message-ID: <62c6863d.1c69fb81.b1148.8ac9@mx.google.com>
Date: Thu, 07 Jul 2022 00:07:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11-116-gef362fbbff528
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 12 runs,
 2 regressions (v5.10.126-cip11-116-gef362fbbff528)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Jul 2022 07:07:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8712

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 12 runs, 2 regressions =
(v5.10.126-cip11-116-gef362fbbff528)

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.126-cip11-116-gef362fbbff528/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.126-cip11-116-gef362fbbff528
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ef362fbbff528b6dc0695b488cfc8cde20b404e4

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


  Details:     https://kernelci.org/test/plan/id/62c67537f758531754a39bed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig/gcc-10/lab-=
cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig/gcc-10/lab-=
cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220610.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62c67537f758531754a39b=
ee
        new failure (last pass: v5.10.126-cip11-1-gc5218dc69ff1) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c67fec1037195bb5a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220610.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62c67fec1037195bb5a39b=
ce
        new failure (last pass: v5.10.126-cip11-1-gc5218dc69ff1) =

 =20

