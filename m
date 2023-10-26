Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A089C25B47
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 00:59:23 +0000 (UTC)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
 by mx.groups.io with SMTP id smtpd.web11.60295.1698281956764063110
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 25 Oct 2023 17:59:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=uuZnshGp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.41, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1e59894d105so212426fac.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 25 Oct 2023 17:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698281955; x=1698886755; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ptd6osCuC2CzZzQUr+Kv6b0itI8/9LoqKbejhp7FCJI=;
        b=uuZnshGpZGT0Rix0eMHRiQwfVjxduk3EbiQsy0i36Ecvm4lroBVrbV35sioPsz64Kz
         V5v8/Hb5s8YH8vCjWj2rFAn/ub+eAyM6j1c2DZbeZ2C3nmcetdiKXbWDK0yi+clBKX8V
         JHcDA19V79Y4j1gCC7E2tZJgW+01KihCLJec1VQJ3rslYpWq+etM6XtIZ6vzeaal3Ef3
         ErLsIdZ7l5a0zrzdwHZ3GJDK5L9KX6zGbq8jyW4jjtRKdEU+8VDkHgjRDdkUugO1cg9d
         RLyqJSEN3Eh8miqhLvMTLCvBVniQD3ttduv4gukoLO0BmNibgMujiaND3baoggaaqTF4
         04dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698281955; x=1698886755;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ptd6osCuC2CzZzQUr+Kv6b0itI8/9LoqKbejhp7FCJI=;
        b=W70tNToPxowEUZQueoJAru8aVCN1C98mzP5pHN/zlXoEv8kNQTRooF+yxJ/KcRDf2t
         eLsl1Q3PUz+9R/EziW4tES5KmuvtTEpZ1VLMiKL/0c17baBnn6X58/blWhchdLEY/57R
         cjWddd4BK9WSXYXGb/TjChvEqcRLBwt2RjRZ+atsRVJmsBgJO7YZhOuamfd4l7geQBjx
         1NjYVLjMusRbiLTrwwab5owdHRJ3OC0HJZE9s6C/kgsgfbfpRQSE5lo20sInsCt7f9XM
         dFvQMIKVtFgqrbCiwd5f8mtfSvDJXAK4QknaRl0chbM0NVn3AC3sAh3+nfktzQef6AKr
         J/dA==
X-Gm-Message-State: AOJu0Yx7BR8BKvP/LNYTFrbFYjta6r4xQtc4e1rDQgq1+Fdk7qiAYHZs
	1Np9lbpjfvRFTz8pEn/wOoqJl8K+YA6qbTmo6KU=
X-Google-Smtp-Source: AGHT+IGas4gDW6Wlc3CKK6NZ8qRmepMr2gWNIR8ITtztJPeN+yNzn10ctR7HFDoltcatsZVHB6yeQg==
X-Received: by 2002:a05:6870:1157:b0:1e9:8ab9:11cd with SMTP id 23-20020a056870115700b001e98ab911cdmr18962459oag.45.1698281955552;
        Wed, 25 Oct 2023 17:59:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id by2-20020a056a02058200b0058c1383fa8bsm8211382pgb.0.2023.10.25.17.59.14
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 17:59:14 -0700 (PDT)
Message-ID: <6539b9e2.050a0220.8cde5.a44c@mx.google.com>
Date: Wed, 25 Oct 2023 17:59:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-915-g33f52aa14b957
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 9 runs,
 1 regressions (v5.10.194-915-g33f52aa14b957)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 00:59:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13453

cip-gitlab/ci/pavel/linux-test ltp-pty: 9 runs, 1 regressions (v5.10.194-91=
5-g33f52aa14b957)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-915-g33f52aa14b957/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-915-g33f52aa14b957
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      33f52aa14b9570bcc02c5ccb3277101f421e6f93

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6539b314be6d731f81efd239

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-915-g33f52aa14b957/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-915-g33f52aa14b957/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6539b314be6d731f81efd2=
3a
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =20

