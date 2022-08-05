Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD260C25B08
	for <webhook@archiver.kernel.org>; Fri,  5 Aug 2022 03:24:16 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web08.2971.1659669847049578193
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 04 Aug 2022 20:24:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=OAd4PFsn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id j17so1598105pgl.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 04 Aug 2022 20:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=CevcnEdHp+Nj+4emyLUzJ2xrpYwkliR4bQ50EOxSxYk=;
        b=OAd4PFsnr8jMxlumJOowjdEy0KicWeTGCUQWgeUC7TI9x9gr4Bp+OEyCBglwyPNUb+
         Kj9ewbph2B4mRQHlssidUylXGV7drFvUL5OlGt4E4deHlTuzr7s814vE6ML2+q02KNmV
         bp/vIuS2XIfbZMRknzsxR/l8OyLXMFy0awHtsqv+HzbrZB4Tqu7yLcs3fLqlZcCpsB/K
         eim/zsyiUC3ZeHzr6LEHxnqKWp4ihGiEgamH1WaEUhr047cAZ0RQWiU+gVznSlIUcjVw
         ZfH38vix1WkiJWEYe6au73F+g4vhevtyVOeAdjFBgUwtYpbjcJA1yNJyRr43UZrq+3Wx
         oxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=CevcnEdHp+Nj+4emyLUzJ2xrpYwkliR4bQ50EOxSxYk=;
        b=7rt6ndRvil/R1ofVHfaD57b+cHiVmbQ0vTuOL+c5c5t4OFpjH0GnXk+okFlO8GoC16
         x5IKSZ804knZ6m65nuqfL0npxMac5Rb56FNQND5NPVV3KwmdbzelEWfo0GQdUzbJImGi
         9biRdOmSULAYh1k3frfsK1Yub2USQ6ev8heb4Y7h0AaP3swHsanoGuw+614o3WH0hAwp
         adwRGEkaKGZtPv6/v7MxKhIP4m10YveBaY09dMspkfNYN5qBNB6GR9+JirU/pSoRDNkz
         vhqbbhiR/Gsytt5UDuI/cKXH4SvuUNxuVq+u+pw/KohlV/9RjSyMVCOADRDOw0iFN++a
         KH3Q==
X-Gm-Message-State: ACgBeo0AZm9xMjHoxNnzqsHlKrVXS7UwmLk6a2Z7QZjaDnt5QmfcPXih
	y5Rb0aDpjT+YhKSL7lDcULKtA8Oa0P8QrraOwPA=
X-Google-Smtp-Source: 
 AA6agR5Yc6zy0Iho8OA93KSttaHafrtIATLMzEi8q0fkqNpcKcPuuQ+yiBstdpio/yMgt1lJdt60vA==
X-Received: by 2002:a63:155f:0:b0:41b:6acb:68b6 with SMTP id
 31-20020a63155f000000b0041b6acb68b6mr4048651pgv.225.1659669846267;
        Thu, 04 Aug 2022 20:24:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 h8-20020a056a00000800b0052e6c058bccsm1761458pfk.61.2022.08.04.20.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 20:24:05 -0700 (PDT)
Message-ID: <62ec8d55.050a0220.e9833.3442@mx.google.com>
Date: Thu, 04 Aug 2022 20:24:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-37-ge3a52725ce96
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 11 runs,
 1 regressions (v5.10.131-cip13-37-ge3a52725ce96)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Aug 2022 03:24:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9128

cip/linux-5.10.y-cip kselftest-filesystems: 11 runs, 1 regressions (v5.10.1=
31-cip13-37-ge3a52725ce96)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-37-ge3a52725ce96/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-37-ge3a52725ce96
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e3a52725ce96e4794cc31e31ccd20914f40f19a3 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62ec7b3634dedb87dedaf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig/gcc-10/lab-cip/kselftest-filesystem=
s-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig/gcc-10/lab-cip/kselftest-filesystem=
s-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62ec7b36=
34dedb87dedaf057
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =20

