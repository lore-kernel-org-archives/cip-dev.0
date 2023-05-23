Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63DFC7EE2D
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 02:11:26 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web11.11555.1684807883548886021
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 19:11:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=BaO58zCT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5343c3daff0so4603716a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 19:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684807882; x=1687399882;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lDTuxZqNYeQ3DJWEpswlDCWzfoNq5MsESdkPnkwihBY=;
        b=BaO58zCT/jxZs7NB6aWTh2KjVUhS0vD9V9AStQjhKIYmAAJcNVmEefFgpUV8xeknBw
         p1ceU/OZ+hyq4npH6Z749mfmIADSgK2kt+cefiOoIk3h5C5wrMr6kAIk9gfH9TLM69AH
         FW69xyvNm6rpa2mBdtIbvZP1azKEc+zgEj4zEv1xzLjtdpm2ipFOdEyNjdZUuLm1uPv7
         LUny9CEG0wM/OrGEem2SMr2bfBQ3hQtemwdLSZN5unDixwGoFSv1FMk6C2ejNTqUu6PO
         rF6CJAWXdj0ehoArbfYMgK5Z77A/r4O33O7PnR3UNCtcNliaiEmut0asBVG1jDZKy3Vh
         cR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684807882; x=1687399882;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDTuxZqNYeQ3DJWEpswlDCWzfoNq5MsESdkPnkwihBY=;
        b=C1g7MbMKH78LAQcFJOeeGzCV1lSw3HEYcYwNkR9Jc/2ssoCzWvDC+4/Bb/JaPgxCzN
         aKWmDYrI478jlXc/Br/E6dPCYeJDgD0bavaOu7bMHxIoDS1i9nBodKAZ7Z+9uD3C6JJK
         rfIOdTM7arl/QCCC6Ug2egF0dS1HNNhv1Jt03RTiclbdkYciYBZLoIN4XV7lcw8e6xA6
         sEN4VFGSMy0K2Zg61KXTJLdSfKJD/NKo8Vt/LcFTsLG8shlqdaV0LQdIGygdUHvahiyD
         iRT0fcFQe71o5T+JXTCjygmczFcPE3HxxfTBGI0C2VZRu1jJo6Y4de+o3akwFgpb1zFA
         ZMOg==
X-Gm-Message-State: AC+VfDz0dOsI5EsbiMWR3GFTqYmm+ofzy1Pu8Y6P6uf4bw/aeyIJBVke
	18DGqYmwpZcyZLd6xB52dLiCHmw3Eaqn8SdhP0pjqQ==
X-Google-Smtp-Source: ACHHUZ6oHKv8lJnDktu4zS6Gmh93HduxuyK9vcRGnZJehVJZQ3Yqno+nNQbHuvaiTyKTlXr6Zi23PQ==
X-Received: by 2002:a17:903:2310:b0:1ae:1364:6079 with SMTP id d16-20020a170903231000b001ae13646079mr16154897plh.44.1684807882461;
        Mon, 22 May 2023 19:11:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o5-20020a170903210500b001aaffe15f39sm5488308ple.30.2023.05.22.19.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 19:11:21 -0700 (PDT)
Message-ID: <646c20c9.170a0220.cca03.9e11@mx.google.com>
Date: Mon, 22 May 2023 19:11:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.280-cip95-rt30
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip-rt ltp-pty: 7 runs,
 1 regressions (v4.19.280-cip95-rt30)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 02:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11608

cip/linux-4.19.y-cip-rt ltp-pty: 7 runs, 1 regressions (v4.19.280-cip95-rt3=
0)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
              | regressions
--------------------------+--------+---------------+----------+------------=
--------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.280-cip95-rt30/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.280-cip95-rt30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dcee20e65677ab5d0e0d47c572f2c71dae6074a1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
              | regressions
--------------------------+--------+---------------+----------+------------=
--------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c133607cc4412c52e8600

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty=
-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty=
-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/646c133607cc4412c52e86=
01
        failing since 61 days (last pass: v4.19.269-cip88-rt28, first fail:=
 v4.19.277-cip94-rt29) =

 =20

