Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86534C7EE23
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 15:08:40 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.52617.1684336115103204117
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 May 2023 08:08:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=QQRs35La;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ae3bd3361dso1047495ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 17 May 2023 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684336114; x=1686928114;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N2n02rBUYi4kyjrUJECIXgAGfS3Rqz+2qkpPw01pSCk=;
        b=QQRs35LapFv/2ZUEYeQ8ScGz2VZSxd9CH13BqQW8KCGA9p2Zrekp2qdy7OAm6/lH2e
         yHmvUPGOLEsXm84YskvVmcClZnU9/bBU5tPokA0AT1UvX5/H9HJPlmsUuOycMhAc2UJ2
         Sj/pS2oWPoimaI5/WqzXJ4hr9wAcMNVfag+bWAzTMFxRSlIxxO9a/gsjdLIH2algeRFx
         sZyPBnP6RSA75JdqNn+Bgwa4cLjYenbj5tYO0SGjWN8VzYoMLLl1NoaLHb+Fx6xqhyPz
         BhiUjtC7Ua4zh85gKhu0BReu7xlxIAKuNfZjQk9HZNRzyZxCpc/2m4j56SJ5fVdhzwMF
         CSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684336114; x=1686928114;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2n02rBUYi4kyjrUJECIXgAGfS3Rqz+2qkpPw01pSCk=;
        b=Ky3o0QBHvUwjkqZmksrn10+DW3F5U2l4FRxrXLt4ixkEVeomR1ZetAn3oSn/pOA2OT
         xIbQjt9d7ZTDYH7aSGvTb1AK83LhGSuFDZ6AEqfzsuLpuWeAtMV7bCnnNnmzAYcYcLNI
         HwpvFYbCVHjS8hQAi1dDgGyM6rhJrHGcS/m5Xa83nEL7m4OrImMJVcn2ltqjdCY2FgB8
         A4eHlyqshcg4/czeJbHGr89IXSsaQd3V7nMAzi4Gle2QUC1ohm8UmJ2l7It7YxyFiF6k
         6hyTRDImbN9I1Z2M/CuvVc3FLM2Wa/S2zxQZCWkczGEmGx7jWqDEcIDaQ7H6Dh7JSXpQ
         pynw==
X-Gm-Message-State: AC+VfDxlUem7Q5CiYiaG3ch9r6pYGGwaMx3SDljQToGMf2qY6MgDep5m
	gQ0Qw7VXcebDOvSoZto1dqsPt8GqFrmHsZdw2bHMoQ==
X-Google-Smtp-Source: ACHHUZ7DKv1ngBl2mQikp8qfcmeStH8cQtpEu6+foWyhOX1GhtpcuokL+XsvOy9txAe6HSS3RoEJig==
X-Received: by 2002:a17:902:b195:b0:1ae:5cf7:740e with SMTP id s21-20020a170902b19500b001ae5cf7740emr819771plr.1.1684336114019;
        Wed, 17 May 2023 08:08:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s23-20020a170902a51700b001ae5cc14f77sm638027plq.58.2023.05.17.08.08.33
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:08:33 -0700 (PDT)
Message-ID: <6464edf1.170a0220.9ba8a.1232@mx.google.com>
Date: Wed, 17 May 2023 08:08:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.179-cip32-384-g291adc46abef0
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 6 runs,
 1 regressions (v5.10.179-cip32-384-g291adc46abef0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 15:08:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11502

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 6 runs, 1 regre=
ssions (v5.10.179-cip32-384-g291adc46abef0)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.179-cip32-384-g291adc46abef0/plan/kselfte=
st-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.179-cip32-384-g291adc46abef0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      291adc46abef012487ba16bb07999af85de2d34d =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6464db528528f76d2b2e85ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6464db528528f7=
6d2b2e85ef
        new failure (last pass: v5.10.177-cip31-122-gfb6ca504156b4) =

 =20

