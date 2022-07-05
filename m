Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2695EC43334
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 03:04:45 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.79839.1656990284662750350
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:04:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=VBT/OsxU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id z27so383452pff.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=CyzkI6XOFoYE3vGldQRR/Wlbgsg4W2yJnCVp0qQ3rdw=;
        b=VBT/OsxUCowSZ5UgTENoGSi8s9ux0nG2q/s3XYa5rmoBm/Vv8bmoNCmEC5+8QL8FQO
         0fPAPqvD8HDgGT15qa+BL6P0GCeJP0B5yuzarCNKRFs7AeRzKhpl3MNnteKEgTEk24xY
         ORLjyqkFggPuRRYV3BLzYxTLPTvNedbq/8nYj0KHy5pvSC3AkZwNHlQHv5TUeyX7dTeU
         5Z/Wq0zIC615YQ+/+Ypa8Gg0ZBsDZf31qL7/Whqcp2H6csduGW/HlgrqZkzukT0Ae7kp
         zOKbCTddwOns2Rp7MNbYRdiaKfpWzdJo7+PWVcjfMHhjuB57f1iFzulXyFUGrRx+qN4w
         EHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=CyzkI6XOFoYE3vGldQRR/Wlbgsg4W2yJnCVp0qQ3rdw=;
        b=unAvwqKhqbyXEM9ztZStKhV9KYK5OZp/I1jBvDLlxYU8dOJvltEdp562hZbgtXvgRc
         /pZ4n3f1befE8OGmg79IWiXAhy0xrOLfMumHLQ8PM6P2OTihZyk8de2F0OTfMtWiONyn
         BNwRRJPpnJ+Ry85e2vhxMrgFIWDeTCp5Q6un7H4qXsuVmuLU2FGaqo/nyc5cW05D1qa0
         VQcVfBMDnIxxduk2HUPM3C7dh79uHKgrwRQ0KmV7cHdr1kW2qkIgrdUCJqDBGncjPiDv
         pFCnDA+2LD/wP/KIuzUcKCnUpfsNlAlF51wyRyic1etYVgW2YVzBRmvgpssvjtfnJ51x
         vgcg==
X-Gm-Message-State: AJIora/xSTB6nUVQVHDJtUvpCgZzz38Wd8GDqftHIjBoMPUHBzYYgU7j
	b0YDNH8nME8MF2WYyv75dsfGXRIwRmhb/RiQ
X-Google-Smtp-Source: 
 AGRyM1skxFIBSBvn3RvKgPFn8tCwsCmy0ReQDW54bK6s3j4ezNPAGaPQ7yCT/OkYtfkLd1Y+imDsMQ==
X-Received: by 2002:a05:6a00:4107:b0:527:fbd1:ce54 with SMTP id
 bu7-20020a056a00410700b00527fbd1ce54mr31310719pfb.45.1656990284021;
        Mon, 04 Jul 2022 20:04:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 o9-20020a63e349000000b0040cf934a1a0sm21133157pgj.28.2022.07.04.20.04.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 20:04:43 -0700 (PDT)
Message-ID: <62c3aa4b.1c69fb81.48475.ddf4@mx.google.com>
Date: Mon, 04 Jul 2022 20:04:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-119-g603acbe1aceb
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 9 runs,
 1 regressions (v5.10.125-cip10-119-g603acbe1aceb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 03:04:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8661

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 9 runs, 1 regression=
s (v5.10.125-cip10-119-g603acbe1aceb)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-119-g603acbe1aceb/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-119-g603acbe1aceb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      603acbe1acebe85cab7f594d9952a493be976262

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e98f9465925434349d0aa6eb71e81b5464e76df4 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c39fb550c63841f0a39bdc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220610.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62c39fb550c63841f0a=
39bdd
        new failure (last pass: v5.10.121-cip9-287-ge9094c8446fc) =

 =20

