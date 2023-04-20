Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27738C77B76
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 15:23:39 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.11163.1682004215133155444
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 08:23:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=5dP6M+dZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1a66e7a52d3so10269135ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682004214; x=1684596214;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/zwGsnDP52TU8WepHMZanaSc4Ca11Q8IWNesxAuZi7A=;
        b=5dP6M+dZf9TxSwWmi65YAtDcTCQFnYRyNlPaxuI6y8zbR/xBL6efvDW30+jcfHET4v
         Ai9heL9uireSvnARDeM0YJFjC9oSoj5S+0TfzfTLbDC4LzuBwyDu4riGee1GpGT4s18l
         DtgOkCUY30s1nsoO9rLBHqMig0LZjf5lQxKCydt9ikkyNAk0Ctl/T/ft0NNhFT/Lgz0F
         Txa3/KUQbT/p0lUzHUYDGjsGVbzpP80kBXjLCdqGld6tBuo682M74vZG+ZKVsWLUcx5q
         OXLHwe3RQ7M0rRbv5xd/IBlRYlLXJ81Wefj8/B/uabiFT5r+dnNE3il+fefjAT6458pp
         OyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682004214; x=1684596214;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zwGsnDP52TU8WepHMZanaSc4Ca11Q8IWNesxAuZi7A=;
        b=K1SdZbWNVNuuHQebGQ52otnWP+CB1cZEIWprVyHy61l3xMStr2KezfMbcKaI4FaqYY
         SHLqcPrjTlHRyhFu2/NsH15Nvlnwbl8xzav88X/DeEy3pwOplY3e20nXXFDJggvQKeKN
         GFFM2LzXIuEyU7lLNl+J5wGo7Gte88jfhVFo8/73eURUGqO7VKNlhDEVPl1rUI0VGURk
         d/LapZoEq5v+vUCgyAGlW7h8CKIYRwHT3qRV+/fY/6k+e5jybJRTx+qt0fmwh8cFMLtH
         Tw9SyYaa2UhORagRl8AWej9XxVLLe7/ebtwnUEQq98vMFBex7z467vhsl0d3+81o3hTD
         M4YA==
X-Gm-Message-State: AAQBX9ejRq6X03cWIhQyDxwbPQfhOkKvCiJcPaJlFeWYsg7DPx/0tt2M
	AxuAmZ9n6K61YWQ+denRXJSnYLQxeEmjPVnDNyVy3BnN
X-Google-Smtp-Source: AKy350b6P4KZ6EgcQTDV4nvimcaVHtp83B2OV1U2lEND+laF+vEmjoyNOSmnTqFV4cEhSbfi6tUnBw==
X-Received: by 2002:a17:902:8498:b0:19f:2328:beee with SMTP id c24-20020a170902849800b0019f2328beeemr1745376plo.11.1682004214315;
        Thu, 20 Apr 2023 08:23:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c24400b001a67a37beeesm1307832plg.139.2023.04.20.08.23.33
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:23:34 -0700 (PDT)
Message-ID: <644158f6.170a0220.4ff75.2ce0@mx.google.com>
Date: Thu, 20 Apr 2023 08:23:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.177-cip31-122-gfb6ca504156b4
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 10
 runs, 1 regressions (v5.10.177-cip31-122-gfb6ca504156b4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 15:23:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11249

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 10 runs, =
1 regressions (v5.10.177-cip31-122-gfb6ca504156b4)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.177-cip31-122-gfb6ca504156b4/plan/kselfte=
st-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.177-cip31-122-gfb6ca504156b4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fb6ca504156b4789acc2b019a0aaeae91c6d73dc =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64415150b8fd26a6542e8626

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig/gcc-10/lab-=
cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig/gcc-10/lab-=
cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230414.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/64415150=
b8fd26a6542e8627
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695) =

 =20

