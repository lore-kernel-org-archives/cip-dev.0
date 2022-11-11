Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDF1C43217
	for <webhook@archiver.kernel.org>; Fri, 11 Nov 2022 07:03:31 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web08.2844.1668150203919828764
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 10 Nov 2022 23:03:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=crui7tgY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so3972326pjl.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 10 Nov 2022 23:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jaKr6YW8lZrWEXM4Hsjmb+aQ3K71ZxKF0DwH2KQXMJ8=;
        b=crui7tgYyIHJu/+3hHHB4OL9XjxxkUZhVrKmlHluLfdnRt0F8R2UdRM5hIaXi6O4MW
         2zYGCePYPSArDWz4eXohhYMBJpBVb6vNefxqxxTptkb+rUsnglyv1ZggEoYG0WhU/N3H
         SEb6Dm8uDHLyx6fnjxkReAvKRFoGyeMY8vTGj11/aah0qKpdBrtQ/mFuzoNPA5scRCrs
         vc3WO6lybEEcQdSCr4yL5QC7Y/ifzyfdgUIVxlMg2Pl/2c/tsQr7FfXNYRKBvqBGAxbL
         WRSNbXm3QjVFuUD/3vDEvr8Q2/b2Z4FMgmsjTFMGHfgIKDJIMKQPQBb5rBZOZVwz807U
         VdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaKr6YW8lZrWEXM4Hsjmb+aQ3K71ZxKF0DwH2KQXMJ8=;
        b=oPDsJEDE04+JhNLammEm7ujyegZiB9ZxC/HCmio5bXvm9JAu0bI7gEpRn+AbU6Ln8q
         Dnq64e3+9/KelT4O08oBzoKp59mHIs9MlPCE6/jk0wSh9xX5RYW3iyd+QxtR0FXbdvVr
         K2hdnm+pRW3RhYwNXZhOcIaDnn71X4qE1XZo8QWnS/H9wRXCm8tzAe8QSynPO3EH+brm
         HiWlv/gjsOdpilRwpLjej45cIDhfMPxaIQ0SXXEkfWnxZJxW0wnJGPv5sEYngzXhKmyX
         G6p4Ivzk+vMsbjEO8FqXBtgX62ury2gBYVgGk8KW21kawiA0AiG8kts7T4uNIHxwVMq1
         Pk1A==
X-Gm-Message-State: ANoB5pnA0MxCzjTxLYuveokZrCWqlcccrs9I6BjbTBdXbxWfLu++tB8v
	FPD87JuoPTV1f11PylrG8duLnrbyL/n1XN5JR1g=
X-Google-Smtp-Source: AA0mqf4oGaTqiSx8fkE89qG96rAdnQeb/nIzz4zDZFluRUyMuKEYGfGwHoPT4dzmy1zr/qhEnNOb+A==
X-Received: by 2002:a17:902:8ec4:b0:188:537d:78d9 with SMTP id x4-20020a1709028ec400b00188537d78d9mr1057366plo.48.1668150203145;
        Thu, 10 Nov 2022 23:03:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 12-20020a630c4c000000b0047063eb4098sm731767pgm.37.2022.11.10.23.03.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 23:03:22 -0800 (PST)
Message-ID: <636df3ba.630a0220.c7ed3.1437@mx.google.com>
Date: Thu, 10 Nov 2022 23:03:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.264-cip84-50-g1e56b70eaf66
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 35 runs,
 1 regressions (v4.19.264-cip84-50-g1e56b70eaf66)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Nov 2022 07:03:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10020

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 35 runs, 1 regress=
ions (v4.19.264-cip84-50-g1e56b70eaf66)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.264-cip84-50-g1e56b70eaf66/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.264-cip84-50-g1e56b70eaf66
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1e56b70eaf6611ac813c4ddded7645468a027eb7 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/636dec764f0b8aefb2e7db72

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.264-cip84-50-g1e56b70eaf66/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.264-cip84-50-g1e56b70eaf66/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/636dec764f0b8aefb=
2e7db73
        new failure (last pass: v4.19.261-cip83-311-g41979a0fec1a) =

 =20

