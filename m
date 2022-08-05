Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9579BC19F2D
	for <webhook@archiver.kernel.org>; Fri,  5 Aug 2022 02:54:06 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.2856.1659668046208893472
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 04 Aug 2022 19:54:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=JGO9Sl9O;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id y141so1130385pfb.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 04 Aug 2022 19:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=pqwG7iIMruh5j7HwRalkbrRrF+5BNRVVUPQmvX5rXxU=;
        b=JGO9Sl9OjvEFUc0VkDHBraTgoRqlFxUPHnvEEBYg52Uv5r89ww4mR6uN7UXXpejf+h
         p09j75jFeMannLBgE0McmJ9Oml5cukXO3dhKfVYxjstRZkgbo0JG1CU5Mncd0EgiLhWr
         sCcRWCBjgE925HfH2IfmEW7DJm/zwT4AMeA5zElNlmAwPmG9K/7SHsj1pm6HPRS6IFdI
         j48l3mNC0z3zPNvjkPZAcfQqVObT0w9k6PDvyA4WYnmUcW5wuqsY6ylyrHCNWGv0n0TV
         yg+cpvq9j9FRqNOpi15mAC8tCqD6bqAFRPbMdgYgxYSuofmsj8JRZlgqq5fosMORrQHl
         8A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=pqwG7iIMruh5j7HwRalkbrRrF+5BNRVVUPQmvX5rXxU=;
        b=fa1HB8434VDmyIITt9oUshi0iPi9nZbur4rzs3fiCcriZdpI0QueVi+r3Qx68yQ+j8
         6ka7o2Cc2/iMX/+G8mZBpEybRYb3lczoFoLYuEg1PbpEGFniq8lDJxh1JXXI7FFhtmhT
         TETNcGKU8/c+/i+cTlHkVGxkKi6M0tGi/Ec9Taw/q0hhnu/Gp0R/lAE4AcMfSP3YeAIc
         pDYxV/Fb3X0fnJA/04N6fBowAygU/EjniVno3vmERdBQUzzScA5I/kpmNGhTPhWSjf9I
         wrhef+9/BfWu14+imNncF1tc2ST9knQN6FU36aj032eYG5aOdsf3kDaSH1epK3eYGKgb
         NvvA==
X-Gm-Message-State: ACgBeo3esi49HuNKTKng6JmRtIKjQqhibOvGL3160CAa5UFCm675dle2
	8rivTG/lN0HgnE1/0737koSuJONuSgs+VR8DO5g=
X-Google-Smtp-Source: 
 AA6agR61L4rz1YYsq0KXZh0WavyHgY6SaWr7iViv+jqG5uarY9/w32DsXyA//MzRGS4IBLWxPSRE8A==
X-Received: by 2002:a05:6a00:1c53:b0:52d:d673:2241 with SMTP id
 s19-20020a056a001c5300b0052dd6732241mr4528022pfw.71.1659668045426;
        Thu, 04 Aug 2022 19:54:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 c29-20020aa7953d000000b00518285976cdsm1752313pfp.9.2022.08.04.19.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 19:54:05 -0700 (PDT)
Message-ID: <62ec864d.a70a0220.24af1.36a5@mx.google.com>
Date: Thu, 04 Aug 2022 19:54:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-37-ge3a52725ce96
Subject: cip/linux-5.10.y-cip baseline-cip-nfs: 12 runs,
 1 regressions (v5.10.131-cip13-37-ge3a52725ce96)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Aug 2022 02:54:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9125

cip/linux-5.10.y-cip baseline-cip-nfs: 12 runs, 1 regressions (v5.10.131-ci=
p13-37-ge3a52725ce96)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-37-ge3a52725ce96/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-37-ge3a52725ce96
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e3a52725ce96e4794cc31e31ccd20914f40f19a3 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ec8387cefaab09bbdaf07c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm64/cip-core-image-kernelci-cip-core-buster-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62ec8387cefaa=
b09bbdaf07d
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =20

