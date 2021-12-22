X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web08.20854.1640188586221514422
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Dec 2021 07:56:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=XJNA1xhz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id k64so2731991pfd.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Dec 2021 07:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=l9Wf529UWXXuasMGsv3jY45by95Nu2rL2ybOmkoNL2c=;
        b=XJNA1xhz61+MOpqgjYVAW10KToaj9K9nUpJUzTJD0+yTUk8STOTpFP6Rct0yljqOYM
         Zv5NqdDza59ewRAY1FC0aN505WasmU8pv4ecG6k7/ytMWLXV6HKxcBd9bbBM2skgGOpR
         gY7RZg6iYU1fqMWHJ7nQ24ly1/4yMC0/hekhRR3ogrwDI00r8p3KvUPjytPnLWXcKONS
         UJlNbBKxNlBlINlGYQLb+U4pEc2FsdOdtGyZOj+o6buVfVj6hbsbO7HXrLVq7F5hk49P
         wiQOfmNs1PGR2WtFiTB8Csleuv0wfG11DIqab1vpse6coiNmGmr25FEtkb/nDnvNCHQl
         Zm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=l9Wf529UWXXuasMGsv3jY45by95Nu2rL2ybOmkoNL2c=;
        b=XfMnTCbVScVs40+XJ0gCNPQEJsKQ2kM7/TWCheSqyHvQ3sEw3bNSUOWGnSNO9+BBGT
         DmKMzXtXYvgGvh9MkCdXqqV3BPcEWJFxm/Ky3MNG/c+tvHLP7o0SG1lAlO9mZoKVouDF
         uU+jS6QJeX/XMHsdlfjF7VDpTvPE9+e1eH82gh+klqJVzqSsM5xyS7pVUzHGQ0t7YNRZ
         cFYr1opgLmkIzbARmYehGSj2aGTmzm7yaiA3BD1l0/14NypRRKw6eAYUzez3egcU9xD0
         9wuj4l+AgDgwQeiZQpedGurNFKG1VrSxVqL2CuCE4tdwYAcckf53sKPXWEVw7IDsYykY
         d/nQ==
X-Gm-Message-State: AOAM531d8g0COsOk+Tf9JfIbyANqyINruxhgq+OJLp407UpCe3fmSopY
	/It+jyt+KkrQ1jRl9hJTdZ9o5cGusUPDcdFVcDE=
X-Google-Smtp-Source: ABdhPJzAcA3dtyDLCao6RbWncKhEDQRNekNd1UcwYAG6/4U7CcaSY2CWnELR7hySj7bQvxFOROS/QQ==
X-Received: by 2002:a05:6a00:1a48:b0:4ba:c29a:b4af with SMTP id h8-20020a056a001a4800b004bac29ab4afmr3502094pfv.54.1640188585376;
        Wed, 22 Dec 2021 07:56:25 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k126sm2530745pgc.51.2021.12.22.07.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 07:56:25 -0800 (PST)
Message-ID: <61c34aa9.1c69fb81.498fe.6a67@mx.google.com>
Date: Wed, 22 Dec 2021 07:56:25 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.83-cip1-53-g2f788040f8b6
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline: 208 runs, 1 regressions (v5.10.83-cip1-53-g2f788040f8b6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip baseline: 208 runs, 1 regressions (v5.10.83-cip1-53-g2=
f788040f8b6)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
minnowboard-turbot-E3826 | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.83-cip1-53-g2f788040f8b6/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.83-cip1-53-g2f788040f8b6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2f788040f8b67a554aa09c3b410efbe07a24225e =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
minnowboard-turbot-E3826 | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/61c33cbc87484ef0bf397189

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-53-g2f788040f8b6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-minnowboard-turbot-E3826.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-53-g2f788040f8b6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-minnowboard-turbot-E3826.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20211210.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/61c33cbc87484ef0bf397=
18a
        new failure (last pass: v5.10.83-cip1-31-gdcbef6602957) =

 =20

