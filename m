X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.38700.1653927686270241004
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 30 May 2022 09:21:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=PsnNo9t3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id gd1so3248578pjb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 30 May 2022 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=9f/bUpooMjkVF70oFQ7CyMCpjppuBvUJCXjARvHCN58=;
        b=PsnNo9t3RwwASkwe74ZsKRmKp8luRdahU1Q6b08daYecJZDluiJ78Go68xnKK6q6AA
         JVjuVaFfWNbSl7o/r7k8f8zBiXfkuwOukN5y1Bxhi504V/pf8tLVZcA9cBZsAzicah1g
         jzQFtNd95DuH8gumWGhIwLTgA2lddpuOyJTehYJWauRIe7Ufi+WY2uUwcb+/ifcpdgGo
         18J35MSTtd3nFug2D4R+IWMs40n/a91meX6ByHZgC6Xe6gLsNfFVTn5Uv9U8cc8kzRYJ
         ec02+FCZJnorlvaTrVAW6dV/bqYG92H2BJ9gku/yOEhBxv6TsC9IdtPKlEA/ldUwIQy2
         5SXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=9f/bUpooMjkVF70oFQ7CyMCpjppuBvUJCXjARvHCN58=;
        b=oc0Prw7ihmv8gLXsRoPcZzGsShwxyd8QDFM8+jDqED/72DwqvCC8k/RVYMWlrabun2
         MRfW2w3pKjmEjGCl/D9JlZtZCty9LUC9OVfMEserRNthyXXHdIfpRqSuxXFGXWCGqGyb
         ddu2HFKGOgFzEvOcAvAHcDne1dJIxPZrBqI8IQvRPwiwEurY6OA1DySgZ27Cxm1QpH3Q
         OZ5ubCEdFKt6Z2GO7MECAKufmBFKzeAoX7W8Hjk6deOqZW50TCfafWD0DB+inGVE+lNx
         d8GkvooSS7CRP9byEKBFj+RNIybAc7x5G41f+Mq5aZcCxVVPPf0FVfvD70fqqpGcjHws
         2Q8A==
X-Gm-Message-State: AOAM531/AmgH0WOilMdQOmAMvcwGsARIVopa/nysqBhmpioFO4cxZ8jG
	o0gBbCYmFnPxrPCs1sZ7riKd7hq0MIkYnuEatGM=
X-Google-Smtp-Source: ABdhPJy1hH3P4UKXwwe1URO1fs3zeDUo3/1OPKjPPJCctOAS/Tdkwunn8g5/3vFgfF9gOaUuN+szKA==
X-Received: by 2002:a17:90b:1e01:b0:1e3:1f4c:dd71 with SMTP id pg1-20020a17090b1e0100b001e31f4cdd71mr2564306pjb.168.1653927685521;
        Mon, 30 May 2022 09:21:25 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902724c00b00162037fbb68sm9363240pll.215.2022.05.30.09.21.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 09:21:25 -0700 (PDT)
Message-ID: <6294ef05.1c69fb81.79054.4cef@mx.google.com>
Date: Mon, 30 May 2022 09:21:25 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.118-465-g0af29783a3c9
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 11 runs, 1 regressions (v5.10.118-465-g0af29783a3c9) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 11 runs, 1 reg=
ressions (v5.10.118-465-g0af29783a3c9)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.118-465-g0af29783a3c9/plan/baseline-cip-n=
fs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.118-465-g0af29783a3c9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0af29783a3c96b3caf71bb01eb38e07102566f10 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6294e53eb98dd47124a39be6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-cip/bas=
eline-cip-nfs-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig/gcc-10/lab-cip/bas=
eline-cip-nfs-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm64/cip-core-image-kernelci-cip-core-buster-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6294e53eb98dd=
47124a39be7
        new failure (last pass: v5.10.115-cip7-81-gd05f72e501084) =

 =20

