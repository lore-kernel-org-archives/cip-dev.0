Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE92C7EE2E
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 15:49:59 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.16917.1686325798959879557
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 08:49:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=NOaZ4We5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-65055aa4ed7so1604713b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 08:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686325798; x=1688917798;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B8ONsXfQbIW+3b4h63KMvEsyY/YdjPJUVlWC1hslTb0=;
        b=NOaZ4We5EqCh4wYvaTKV6eaacWyT6XKT3d1nvFOu9A1M8DYwPyJxJgFF1e3tEcKY0M
         dRdc+0oWYVXD507NqhCyrnStfdxOFh1+Ye/5/zaIYjHdkRxBZgb/N/aw8yOzfmQg1kSu
         UaeB7oVcE4wKMiwMFJYdtPSB+7jsAJVupxlbxeK9Jl43vIkzYIHJfDdkRT2cZOfodTto
         PJlZXMkrnjnVyhLqF7s1WH1VPwuDVI5ziSRJkc+a6+bidEDjcORMt48VwsOkOKEwAjZP
         QiCxPvgIyBIhhY9m/S3GBE+sRHTmeNUoxjNrmDAxbjLe/QDDqAvrRdPcE0RmHmR8oz7W
         gxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686325798; x=1688917798;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8ONsXfQbIW+3b4h63KMvEsyY/YdjPJUVlWC1hslTb0=;
        b=Qul88l4dGwFoRQLdVMSYwpliKSZNnHib4B1JJhXWWsg7AUVDuNqGhdfJC9yUvUhloa
         kOxi9dCG+JtUn9RZlU7GOozAXMKLLMHAPit6xUNI69wKthoT1xXX1002VhquppuIGgUW
         LTwvAUx3h7TqyzRpMwoIdasPAQHl+ThdYXjBEl7ih58KJWApUh9rb4S4b9WBUAc93Odx
         5Y7F3qOk6Vp2C8yeNbS5KyIMypFwHo+eaWGPfbyVD65a2nWhWsap3lCw8mSSyJy1Vd/w
         F1VVd26gyGKzz5a3Hym/b/jZLkUxgowr9ohRD52fPAiJGxv5t0QX2kNivXId1EKEMIhN
         c0Nw==
X-Gm-Message-State: AC+VfDze6mXs91tl9tol82Xq1f5sjxgZ+St3BYhF99PcgR9zcs9uuQ0n
	zDhNffx7twGE8Um6hH1Wtcoqf2BRC/Uu4nCNgZFFPA==
X-Google-Smtp-Source: ACHHUZ7XPBjmp3PCLIC5Rhl7RHh++suNoZsE7N39aTYaSWGON4jC816QIPDr86s3uKeyzv7IZeGt5A==
X-Received: by 2002:a05:6a21:2d8e:b0:114:6390:db06 with SMTP id ty14-20020a056a212d8e00b001146390db06mr1238591pzb.32.1686325798047;
        Fri, 09 Jun 2023 08:49:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w1-20020aa78581000000b0064f46570bb7sm2377856pfn.167.2023.06.09.08.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:49:57 -0700 (PDT)
Message-ID: <64834a25.a70a0220.36fa0.4dd6@mx.google.com>
Date: Fri, 09 Jun 2023 08:49:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.284-cip99
Subject: cip/linux-4.19.y-cip baseline-nfs: 34 runs,
 2 regressions (v4.19.284-cip99)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 15:49:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11942

cip/linux-4.19.y-cip baseline-nfs: 34 runs, 2 regressions (v4.19.284-cip99)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.284-cip99/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.284-cip99
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a13de4c6b84ab64a5cb3ef5e852b1620686d0309 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:     https://kernelci.org/test/plan/id/648343cebca8fa1e7d306134

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.284=
-cip99/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.284=
-cip99/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/648343cebca8fa1e7d30613a
        failing since 79 days (last pass: v4.19.276-cip93, first fail: v4.1=
9.277-cip94)

    2023-06-09T15:22:43.140486  /lava-10661301/1/../bin/lava-test-case

    2023-06-09T15:22:43.162879  <8>[   39.391976] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/648343cebca8fa1e7d30613b
        failing since 79 days (last pass: v4.19.276-cip93, first fail: v4.1=
9.277-cip94)

    2023-06-09T15:22:42.084498  /lava-10661301/1/../bin/lava-test-case

    2023-06-09T15:22:42.106600  <8>[   38.335225] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

