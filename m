Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D21BC4167B
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 15:02:41 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web12.8538.1665500557571841532
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 08:02:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=6Z+sBEsy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id b2so13431926plc.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CEv+c80AwgpbRPe9S+f2iJdeyMiRKBc6xipzW8lZNM0=;
        b=6Z+sBEsyWf1cTbez2TWFs8MtxobdQ1hkhoC9xsBYYtjY7AOK9d5XEKlM9MEqV4QXyO
         XmjGpEz/wcMn2MqH8inmL1sXf3xNy7JKmhaHVx6208qegG9SPOazjoYCJNz9jh7Dl1XT
         UZb1yLR94nNf5iS8OIaUxN5GSGvzH5GmQ4xYJXQSttjD+1aRW5lBQZ6svyh3fv/6h8jw
         vMczjqkOsebY4/TkJhZHcNpphGa0jBWrlA7gVmQz4HagQVdXu8KFM680O/ZDShxF79oP
         a6XnXjbsSp17Z4ylDCntXjaRN9/QoO7YHD81RuPzhHzqQtn64Xmow56Z+nPkq9nkbeat
         Cexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CEv+c80AwgpbRPe9S+f2iJdeyMiRKBc6xipzW8lZNM0=;
        b=X6mD4gJGan29Ee6FIpvTx2o7cCzk00IyrhAh3dzeC5eGY3mN/e33QdIHCaSS5aG9KH
         yTm9sZFQYIY8oFr4WGSxW+W9SnQAyUhdeWT+69Uzhohp7zqUvXsB22jxIap/vV5dmNNJ
         cdGOvSmMLf01/yHb1P8+2ldTlBRkg0XnQibrR7rTsnJ5sW53lL903HT0VnzyL7U6WFhj
         22Fc0jCaY4eex1iErSgPtbsIcIckzoc2awG3ut3OQBxEQsIUDP209sb2/JeYaFF3NOMZ
         HbFuVix3zb9sGrM+6nx+QMfwne3PHXkmmjMWXLHOBRmUTTxDR/m4ni1UhAicV2a+LycT
         zGdQ==
X-Gm-Message-State: ACrzQf0MK+HwpLdI+zmz1mchY5ls/yOqAhTRBM8ifnZEdSWjaSVVKaaW
	AaJ0uMPsQ/sFhhdTiKhCIhnsT9IoGA4jv8FP+LU=
X-Google-Smtp-Source: 
 AMsMyM6TCPhokga5lCNBqXl2roYOnQQczp02XfxiwL10LZ6wKSEs3U1DpyVsD1Oj1SSfhZEtoDXc1w==
X-Received: by 2002:a17:903:200a:b0:181:75fc:e0c6 with SMTP id
 s10-20020a170903200a00b0018175fce0c6mr15718399pla.93.1665500556796;
        Tue, 11 Oct 2022 08:02:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 h25-20020a633859000000b004351358f056sm8148437pgn.85.2022.10.11.08.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:02:36 -0700 (PDT)
Message-ID: <6345858c.630a0220.ceab6.e443@mx.google.com>
Date: Tue, 11 Oct 2022 08:02:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.145-cip17-1-ge85493c8cea0
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 8 runs,
 1 regressions (v5.10.145-cip17-1-ge85493c8cea0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 15:02:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9726

cip/linux-5.10.y-cip kselftest-seccomp: 8 runs, 1 regressions (v5.10.145-ci=
p17-1-ge85493c8cea0)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.145-cip17-1-ge85493c8cea0/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.145-cip17-1-ge85493c8cea0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e85493c8cea0c5b53ef511efe088b0749b4d5aa0 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/63458020d5b068bee6cab600

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-s=
eccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-s=
eccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63458020d5b0=
68bee6cab601
        new failure (last pass: v5.10.145-cip17) =

 =20

