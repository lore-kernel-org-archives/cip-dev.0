Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25057C677F1
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 00:28:57 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.34324.1674088128900352223
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 16:28:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Tew4UiAB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id cx21-20020a17090afd9500b00228f2ecc6dbso3190366pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 16:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k0CSB0mb2DB+MIIhDMn9vmtstzSKq3VUqeJfX5PJeIs=;
        b=Tew4UiABbCfAYQkRi8extNtQ9pB6FiWZDZDzrkAYh9bv35+1bIdkl6Bn5VjS0Sf+nj
         cAFfa2LxfYhdzxh/CIUW22QOXpuQVG5O2j0VsA+YsgNUHNwgvK9BAIwAzlpSDCocW+FK
         NqW2kFMZ3ESZK+2n2iOg3jGi6gIoLgnM5ZCvxV+u6yJPBDJhEUs+bp8wMmi/y8I6y0e6
         KRa4EKf5wukqS3IcSg9fgrmyxwIbvpu/XcxXYDzu8/6hn1hXX8tVEsVLR+CmeBYXeFLv
         mRcoG+WSq7F9DlcPk3k6AuYNn5jIl/sFGodqQpIRWUKxKALE01vBpqiggKYdNZn8Re+v
         GdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0CSB0mb2DB+MIIhDMn9vmtstzSKq3VUqeJfX5PJeIs=;
        b=l9HTRxD2m7vNPd/WJRSYVxiz5gMBxbkV7JKuF69aMa0bOWHqjge0uEWHT0pLz/gYhn
         cCP4DcPan6ZuYkunf0Wm/wrz5o7UE4EsrqOZWuCJgiszJNwrWXRRWBdkU5p8BoPmtgWY
         IP3JZG+D2Z7GbZRJmueMHQaKW3Y57kVAJCVavaVvwGIV63F+gOoejPa9ySsmtaLIIFfR
         JIbImShKc0Fry+UsACYqBb1rCZjWK5Y3A0Fq4FDNCRrBb+8YfocfWfrXvsdGjjkSY3mf
         +E2taDb67KcuHHm388ZqXu2maHtc691ZTKcs0neLI7Oo9mA/k37BY9lBEOJs84qyVT0R
         AM/Q==
X-Gm-Message-State: AFqh2koiUCoZ7X+pCicpi8sQj6BRnF5kHajva0dnwGI0+14Hpvk1stNS
	d0ZFJgiXuwDwEZ3Mp9XSx8VPo0gK9eatqWJvSV1XLQ==
X-Google-Smtp-Source: AMrXdXv8MZn9/Jhfo5qfJbTJSFXzmTp1FklzScXFbhnEjsWgnvChidEKHbJCUB1nalNogrIj0yCDdQ==
X-Received: by 2002:a17:902:ec82:b0:192:6bc9:47ba with SMTP id x2-20020a170902ec8200b001926bc947bamr12489404plg.31.1674088128114;
        Wed, 18 Jan 2023 16:28:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00189ac5a2340sm23685146plh.124.2023.01.18.16.28.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 16:28:47 -0800 (PST)
Message-ID: <63c88ebf.170a0220.10cb1.6d21@mx.google.com>
Date: Wed, 18 Jan 2023 16:28:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-rt119-858-g4aae57dbf650
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 5 runs,
 1 regressions (v4.19.269-rt119-858-g4aae57dbf650)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 00:28:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10419

cip-gitlab/ci/pavel/linux-test ltp-mm: 5 runs, 1 regressions (v4.19.269-rt1=
19-858-g4aae57dbf650)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-rt119-858-g4aae57dbf650/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-rt119-858-g4aae57dbf650
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4aae57dbf650bb88d187f251ebdbd3984020b619

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cf59c1fb5f7181453b16171d75654ee9a1216dde =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87a9e056dcef678915ecb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63c87a9e056dcef678915ecc
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =20

