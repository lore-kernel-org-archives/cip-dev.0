Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082FCC04A95
	for <webhook@archiver.kernel.org>; Fri, 23 Sep 2022 19:11:49 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web09.727.1663960301879705952
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Sep 2022 12:11:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=sCc/6sil;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id 78so1060402pgb.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Sep 2022 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=4lG8xj2ZOPGf/TrYLJGHq9S/5LSQa5Msk/GNBENDpU0=;
        b=sCc/6silhEVFRzWGKtdL73uTC53iSWeELge74EhmuLxk+dFY+3efxmAgKBr3Fwj7r/
         k6cu3OdtSj8hk8wyPeaoDsKxKURW/GNHmkhqQvZrwiYOXVdY01+vRY5O6p39YTUjv86v
         mA5ZDES7FDs9hxsUwwsCdX8nShIoRcbfMqBLFaTKWOPX7BXyKVi+N6WWBrIbCH3UKJxo
         5ZQRRrvHoD6tWupAt85GwHZ76Ew1wsOPl77txgbyJiNLWexcRyA9/hIT/G3jv8vBGU+k
         1CIg8CVVACgUMhOOh4vXYxItt9hroN40b5xrWUmdJHPifL4oTDapRuRcHJvs6WjrMW07
         coAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=4lG8xj2ZOPGf/TrYLJGHq9S/5LSQa5Msk/GNBENDpU0=;
        b=Fnm9shdwDQ2wt6rltx29hzSbFekG7Q7vtFOA130pv/Yb7/MfIPN/kyx4yvr3mXNcdF
         OyhdM3nMIHlNnnuqaLIdh3nVDRlNYvYJAHIjRuZlMoPZFefHXGniwig3YK3CuO/EEfEn
         9z8ZV8dZ18rAXwwUNEat/2Kth3DogjjcMtwRqtnnVUbDc6JmSIAt4cTkdvanqUokh8cc
         vbCVAzw4AwlnwPt0Xz6W2Xhqqo0AEDdU/5mHpD6s1LVhiZ53BihRD64VFwQ09gMgajtU
         lS0oh6c8tzxlPxB6WDApfoG1h9pt775kgrCRv4Uc7HQEHeOwj3P3PgcnlVMPghMYvzU6
         DldQ==
X-Gm-Message-State: ACrzQf06mEpkWhoHNSYqUCtHw25Oa3IwcwbHD+c24vojNEP2S6blI+nN
	UmYozSWb3uShNI9iWVGSZAjim667LoX0xjUZVXY=
X-Google-Smtp-Source: 
 AMsMyM5FP8dfkykfEz3FJH1IrztDUvw5IXt96/4bwA9J27CzxNd+qcDyxWEOvmPUP/W1NDqM7Tmeuw==
X-Received: by 2002:a05:6a00:21c8:b0:52b:ffc0:15e7 with SMTP id
 t8-20020a056a0021c800b0052bffc015e7mr10429487pfj.29.1663960301088;
        Fri, 23 Sep 2022 12:11:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 y1-20020a623201000000b0053e9ecf58f0sm6744440pfy.20.2022.09.23.12.11.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:11:40 -0700 (PDT)
Message-ID: <632e04ec.620a0220.4be0b.dbce@mx.google.com>
Date: Fri, 23 Sep 2022 12:11:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.140-cip16-261-g8fa62effa305f
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 7 runs,
 1 regressions (v5.10.140-cip16-261-g8fa62effa305f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Sep 2022 19:11:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9539

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 7 runs, 1 regre=
ssions (v5.10.140-cip16-261-g8fa62effa305f)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.140-cip16-261-g8fa62effa305f/plan/kselfte=
st-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.140-cip16-261-g8fa62effa305f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8fa62effa305f81a2f52692a14ee690927819830 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/632df541ccd4e042ab3556c4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/632df541ccd4e0=
42ab3556c5
        new failure (last pass: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =20

