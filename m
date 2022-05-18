X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web08.618.1652901034301575109
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 May 2022 12:10:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=vuNV9zsL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so4506170pjb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 May 2022 12:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8cTEmI+a4eSYiOgyy3+cZBqxpfO7k5IOQItxtCzPH4k=;
        b=vuNV9zsLKeVKspM6zPgz/aLBII7maPjKhl0E6jJFU8AKLIEi7kWzIOr0HJa68RMjDI
         nmnmUTYFj6+YP8yPFDkIO1AgzOXlbcBSBUVrCAgiOn+CJLIEfp7nari6mNPA+Jq6Qb87
         AaIjbNeGU9D8IzIvF3dvP9t0xY7QS2GakV/Awh3D1HO+Bn04bVGtqWlqfjooZc8pqG5k
         ehYjREBKKusqYBqeMF/Vj+Tg3k5Bg+PcTKOU5EL420wZGcOAxAQHJErGfCtPx0yRBQoF
         lgAIjMb805R9YPEhLniDn+N7OIJ5HSbMI3QZ77/hnT4NI70rWijT7QC45nqVUKsxTwmQ
         eIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8cTEmI+a4eSYiOgyy3+cZBqxpfO7k5IOQItxtCzPH4k=;
        b=gHIU5Dv/+AD2ayOF7sMSTNSkLkqIUYiIwykcUQVugoX/06ILo272r04A7u6/xZfYux
         pfdWovIm57z0GhbTSe6hIXVBidw8ePlGQQpOX3YjQGx9zEe9U6K6M68eFJ+AMwL1T+cm
         YhJVjPR97MXG3scHv+PcgY6eGl4IRtQp2zRKpA7QAXQPhOCnjuE1lMgiOcG1GYMDD/sf
         1/juekBS8zg7IUhgDfsJI+7ixsKShCUXrc+oXT+VOG3wtpP4iuFHEqZtF7LKoYbykoEJ
         NNVbtAdBxzt07GN4hohZ2HBg+vgkmYqw6MpH1uPzvULWjjsFvdXinrR4kJBEN60ssthc
         1aDg==
X-Gm-Message-State: AOAM532Kux061FPkb259lWHT6U5IurBIWnF/st0Zy693VkfnzSWZxgy5
	95QMUN44VLEY8JqYoN62qg0vVzgjgp8r7ymF+vQ=
X-Google-Smtp-Source: ABdhPJzB6NSIWLi70s9gwHuxPOmJ8Bd0ph8CJ1guI98MPomSU+BlKPLtmp+MLdRAS97PWLvs0TS1hQ==
X-Received: by 2002:a17:90b:3910:b0:1dc:515e:1b12 with SMTP id ob16-20020a17090b391000b001dc515e1b12mr912272pjb.107.1652901033631;
        Wed, 18 May 2022 12:10:33 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ku18-20020a17090b219200b001cd4989fee4sm3970316pjb.48.2022.05.18.12.10.33
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 12:10:33 -0700 (PDT)
Message-ID: <628544a9.1c69fb81.74ce6.a4f0@mx.google.com>
Date: Wed, 18 May 2022 12:10:33 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.242-cip73-50-gd57bc44cb340
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 7 runs, 1 regressions (v4.19.242-cip73-50-gd57bc44cb340) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 7 runs, 1 regression=
s (v4.19.242-cip73-50-gd57bc44cb340)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.242-cip73-50-gd57bc44cb340/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.242-cip73-50-gd57bc44cb340
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d57bc44cb3404e87a6fb3a587e605ae5d62017d9

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  17e9ae697a340242c49188ace12a60cd3bc95a53 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62853a0d98fe1ad890a39bf9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.242-cip73-50-gd57bc44cb340/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.242-cip73-50-gd57bc44cb340/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62853a0d98fe1ad890a=
39bfa
        new failure (last pass: v4.19.239-cip72-68-g407458469172) =

 =20

