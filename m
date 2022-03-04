X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web09.1618.1646352384252441112
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 03 Mar 2022 16:06:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=QYgWzb+j;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id z11so6241109pla.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 03 Mar 2022 16:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Oxl9jtHoe0WqLfhY3gSQhvBtDSKZa12wLLACy+s4EB0=;
        b=QYgWzb+jOPIc2JXCaXZwrdRWZZnN+rdMU7ICNDzCK36/sJjiClIBAZl8PqQAPG9sMB
         giqMOlP6KzvugcCm5ZOA4F05Z5vyKRNaZZ1v64FRsM4CC7G11VkpxRCZyFTx7Pn5DDTf
         W3Xpi1PFxBBCitJ6OM0xn/+xeDkUnx/YEB1CSV6vcDx1es6PhRW6QY+WcWrPMEpBbIa6
         Gvdabew6dvuhLmWq2pkqV0PlCyDxtrkDiSR60r+R4LRRlEpFrpGuZ25E8hwzdj0ycJyQ
         tnGRDl6jkWLQIhbD4ogWZAYVzWj2zJBuHxHb1BmborGUuYU54JveBZpBcP6MAQ5FKX2H
         WBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Oxl9jtHoe0WqLfhY3gSQhvBtDSKZa12wLLACy+s4EB0=;
        b=U086S/HvuXiEieO/Vzdmd9MOhcXeY1s2ZO9mxpRZoE5mPjMkRbrMgS53/emsarIPIv
         fHuEYthz8X2EUal1CYRwIqc7MtArdMjWhVShbV0tXPrak99fdN0Nx7mlE1OiZWacaK07
         bp/MKcgW8KARiysxRa9EssZ5uF2cWxSgnjH5Huj9LpecH0Y8ylL9XPICiHWpwtEarWRw
         qjvONwDOC0DLEf5q7AzxrfUS75keZRVoQgsOcE2TSHPBCSPSYoKwHUuPfQ05IEDNjOH0
         YsU4+HJ6kFHfRcOBMVhGiTUYXIG5HTGPWy2g5XO9fju+O7bHPSG3JYnYucoBSOmbw6a2
         l3XA==
X-Gm-Message-State: AOAM533e+hy6NYTjUe+eKny/LZB5MdvT80BAaADU/U6n1TSxWEmQaONa
	n+xbxMUsvYL6mi4+UPzt+AeijxqFndQezFtM1kw=
X-Google-Smtp-Source: ABdhPJyrBV14EseL84d4AfKmfqzX//8F0ahtdU659uNwDZNzIn46d+gLf+0YGKh8twZctHnAS2mYhQ==
X-Received: by 2002:a17:90a:7883:b0:1bd:2372:c990 with SMTP id x3-20020a17090a788300b001bd2372c990mr7841884pjk.55.1646352383406;
        Thu, 03 Mar 2022 16:06:23 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a0b9700b001b8f602eaeasm9052384pjr.53.2022.03.03.16.06.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:06:22 -0800 (PST)
Message-ID: <622157fe.1c69fb81.bd72c.97a7@mx.google.com>
Date: Thu, 03 Mar 2022 16:06:22 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.100-cip2-319-gcbff87047566
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 11 runs, 1 regressions (v5.10.100-cip2-319-gcbff87047566) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 11 runs, 1 reg=
ressions (v5.10.100-cip2-319-gcbff87047566)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.100-cip2-319-gcbff87047566/plan/baseline-=
cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.100-cip2-319-gcbff87047566
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cbff870475669d78815941c2e765cc5a8b6078f0 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62214e4e2fe8da3528c62973

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-319-gcbff87047566/arm64/defconfig/gcc-10/lab-ci=
p/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-319-gcbff87047566/arm64/defconfig/gcc-10/lab-ci=
p/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm64/cip-core-image-kernelci-cip-core-buster-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62214e4e2fe8d=
a3528c62974
        new failure (last pass: v5.10.100-cip2-239-g01aa183a119a) =

 =20

