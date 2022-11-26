Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8D7C43217
	for <webhook@archiver.kernel.org>; Sat, 26 Nov 2022 11:32:55 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.68442.1669462375086318060
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 26 Nov 2022 03:32:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=xRvk+Tr9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so5090607pjo.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 26 Nov 2022 03:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2dmM92W04hFkfWtQjch6WcxQyeVWN1YJ+/IFpB0RcHE=;
        b=xRvk+Tr9y5A1VEFYg8VNtG9nuCSOfcM0QUWDuQtqH2K6I2+6V74W0BJYDt9fFZSKbw
         QM3XihAjx/rh/0uqFFj31XoOb268gsVVsRwnezW/HdyPykZeQG5K1LSlXy9/OWtFOumB
         oWIpeCDhZDV9CjsvWdE0jfftxHx6LaUJ/bzTCm5WQK/OUPv0wxPk90fbBTD4Osp3PN4c
         LPzMb2aZZ876yoPrx9qH560gUZG+7NM/f7GUujE+d2apI7OsgoofU2rDFj/ZkjpxPiyd
         cFnTXR90Jg8iroThezwR0joLtqsTGMISaAYznpoS7RYTSbnR1YkRyobtotbacC9opR2N
         DHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dmM92W04hFkfWtQjch6WcxQyeVWN1YJ+/IFpB0RcHE=;
        b=Eg6GPdrB7ZWk1M45EAjQITpFkNhlHU7feSBNozFne3gCTfa9Pp0pjMwpVBYFTuYY9K
         HCNcD08aQKVGJMdypbxlI8vAHISwlacFKPOLyj0o1G+kn5+QuabDDt6g+7s/1sjPJFcS
         rbIpxExV2LlhLzstiCri2PYmRZASW1+urvWdNx2W6jH+nd5YWto5SCBWxBfIXKZ1/bEO
         69Vxs7YK1/UmY4h6MaDjNve0qqYqBZ5TdiPMAtXSQqQRqyYl8Q9mKeP/8ChuDHJ9CDzj
         jEjJOUVu8yw7YShK1mux4yfp+mbOL7KT2dHd5BGV62URbhXehWKn703amaXggY87om9b
         ItbQ==
X-Gm-Message-State: ANoB5pm3+kxl1pKbobObE2AkCynGwmFTdDg245+/ETHoEjsgioaH1CKd
	FndgMKD1J2IrvH5wzrEMCjtV16SAp8lPE6fqPxs=
X-Google-Smtp-Source: AA0mqf61Djf2+hcLxFZvviTbf0uUfBmEN2DqlmxOIEX94UT6oI/uHyk6WguP1VXl7hGWYHe/dm7Tsg==
X-Received: by 2002:a17:902:748a:b0:188:4ba9:7a04 with SMTP id h10-20020a170902748a00b001884ba97a04mr28029830pll.45.1669462374106;
        Sat, 26 Nov 2022 03:32:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 77-20020a621850000000b005722f4dfbefsm4560035pfy.193.2022.11.26.03.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 03:32:53 -0800 (PST)
Message-ID: <6381f965.620a0220.93638.61fa@mx.google.com>
Date: Sat, 26 Nov 2022 03:32:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.155-cip21
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline: 94 runs,
 1 regressions (v5.10.155-cip21)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Nov 2022 11:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10115

cip/linux-5.10.y-cip baseline: 94 runs, 1 regressions (v5.10.155-cip21)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.155-cip21/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.155-cip21
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      02e30f9cbbfce3d687cb1ab288e46ad20079e8e0 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6381f27c7199b6d8a92abcfc

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/6381f27c7199b6d8a92abd1e
        failing since 242 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-11-26T11:03:18.237548  /lava-8138470/1/../bin/lava-test-case
    2022-11-26T11:03:18.248272  <8>[   33.730153] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

