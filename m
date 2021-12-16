X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web08.9552.1639655066233894741
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 16 Dec 2021 03:44:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Ui9lEGSp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id b13so19261578plg.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 16 Dec 2021 03:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=QJZzRCAFHEcY7I5eQOJLJufyeFQNgj4Rvz7pwTk9Qis=;
        b=Ui9lEGSpAcIN9HTlI6l/WOtrE0c71H+/I3JxdMbc/fnCw7dv4NVf7aDgIRN8H8RQwr
         PGCPPH3DK+fPWDu/RhpzSyAFNeQs/R36VXEyfjBkynW+OlcrpAnakv1t6b1NcnZ0Mugu
         a4/HwY7cU/tw7R/2cLILVLX29G3O9vEU4CCQJpD5ai5bGU7KhXMcsgK8PFlt67wpCKP9
         R2p+UvJxz18v1GQKyHoCXxfWD39ZJ34NcHg85ktKzirIP+wK5wuCMEcM18tR8qkkHjHM
         jTI/JhFebaEOUou13tK4cK1fLql5sOB9PE49a1XHoqYwxEfR8yNArS0ZrN+2SAABu21t
         LVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=QJZzRCAFHEcY7I5eQOJLJufyeFQNgj4Rvz7pwTk9Qis=;
        b=yprIgTrMMOWGGUwySQumfcRy8hpojs6bSzM9PQnqRt+Mt5/l7ArADO6wvmWQ9xnR57
         OTlb8qgCwTJRpagkYZKTkxkNDQIF5adEomEZ2O8xcJ7qmiPYYgvESxZSC79xnRtaa+b0
         qn3EpPw0p87vyljTxam5t+2HCZU4acmXZuobSLoKHYNtwSf4qTki81vcIye7nxQrOmbp
         lKc2k5F80KntwPEDJtuIfpkMXfCsYdzyHcGuCyLJglpDX/nc7lrEepcQRDZ0yHxl3YZX
         jSZsN23ZuRYiwn7ecJv40Ug8juAa/QzxPru/wn9ETuWEa6V2sOh1Z8xhWrYLwkdq5kwL
         qJUg==
X-Gm-Message-State: AOAM530gOpWlcmyksMEPDB/xxoYhtM3GyEbMxpB9H10gD3BNec5cKwje
	ubk3zgqU3fhxPlUowfTodsMF+QKfLmsTQPEb
X-Google-Smtp-Source: ABdhPJy34aypzGjQoeJfZedtcfBMRx5S1SLDLUOd73D6m0FT1+oGecPSSTyJJEJs5ascgh2PCLPQWA==
X-Received: by 2002:a17:90b:f81:: with SMTP id ft1mr5584003pjb.136.1639655065436;
        Thu, 16 Dec 2021 03:44:25 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id pj12sm8637881pjb.51.2021.12.16.03.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 03:44:25 -0800 (PST)
Message-ID: <61bb2699.1c69fb81.fe3e4.73a2@mx.google.com>
Date: Thu, 16 Dec 2021 03:44:25 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.83-cip1-7-geb3270fae08d
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline: 137 runs, 1 regressions (v5.10.83-cip1-7-geb3270fae08d) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip baseline: 137 runs, 1 regressions (v5.10.83-cip1-7-geb=
3270fae08d)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
minnowboard-turbot-E3826 | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.83-cip1-7-geb3270fae08d/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.83-cip1-7-geb3270fae08d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      eb3270fae08d8e549e33314d589f9153d60ce4a6 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
minnowboard-turbot-E3826 | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/61bb1820e5b9921a2c397174

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-7-geb3270fae08d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-minnowboard-turbot-E3826.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-7-geb3270fae08d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-minnowboard-turbot-E3826.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20211210.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/61bb1820e5b9921a2c397=
175
        new failure (last pass: v5.10.8-8301-g3d6168cb89f6) =

 =20

