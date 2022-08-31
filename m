Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107F6ECAAD1
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 18:21:38 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web09.2419.1661970097407786145
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 11:21:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=YWdUrTxE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id y141so15248277pfb.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=3MkGQcjwfwxAZtDkn9RTQfGAWHbu3vFrbbfcbDEB15c=;
        b=YWdUrTxEo3qFXgoQL/Z0YYwddv2DfjzPUNlIfzUaLMQgZBbhPSOsCO+IiwBv84Ws0m
         BUsiHVHSwcBnr3Ipmpg5UTNutcJuPVnSzxaHBBpwDOmJvqem0NvLFgBxMEVprlKmCTKA
         I1H7VRaESyzH3/pCnMJUGoHmvEtCx4MJK+fnUstqhDUApE+WLYP1GqLKLGY9sDuw1BvT
         KQaY6nGyCsM1p3ZtnSTTwfLTXQDtEmNeIPMg23aQUgtDHXfR/H4dSK2+pl2boMt5vgdO
         zhWoxPxwjREq+Di8kGzBB7G45y8sEe6RPhXo1flnzjG5bqGkc398N7xkkoqFNvMgsR13
         kS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=3MkGQcjwfwxAZtDkn9RTQfGAWHbu3vFrbbfcbDEB15c=;
        b=vORJPb1UhGIm3TjvdWFwS8uNkfWtaMN/5ogLnNAvsx1PKv6FPN0Tg7fPmesZwTQsCA
         yPrnlV3xB0XZnf7ridAFYOEjhyt0WTmW8MlfGwQnO2N4cOP4JeTCRMrNTKBN8HSKTF/G
         OkOAb+sSwrnF3oq+QXh/nus1uURIN0HzLO10sc49uNO0hAL/lnqoMDvYV21MB0sGR6Ar
         n1xAv3zhvwG4w+I63+LOEGk93tJOtnwS4KiW5FMomzAw3K2RIC7SVzJYkdsiUbWCubgT
         HGtI/3Uu4fcfK8BvjJu7C37R1jSdONheEtonDCeG7EhiUndPoSLS8r5b/tjuxZZOa2jw
         3/9g==
X-Gm-Message-State: ACgBeo281u8Hbu/HQaZsCZZE7BcZBjezXTn+BI+sbdYjMN+6xeyNEjtq
	rYwJecNyjHxu6PEU1fcnhWY+RIxTJoqP5jGHJig=
X-Google-Smtp-Source: 
 AA6agR73zgoHvumJLweBvjmKj/6JlvPwM8y1/qczSLr7we2wFd+50g9jKnw3TP51DV2YSIeIECQFpg==
X-Received: by 2002:a63:2cc2:0:b0:41c:681d:60d2 with SMTP id
 s185-20020a632cc2000000b0041c681d60d2mr22222352pgs.502.1661970096179;
        Wed, 31 Aug 2022 11:21:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 o186-20020a62cdc3000000b005289a50e4c2sm11557559pfg.23.2022.08.31.11.21.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:21:35 -0700 (PDT)
Message-ID: <630fa6af.620a0220.8a022.53f9@mx.google.com>
Date: Wed, 31 Aug 2022 11:21:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.138-cip15-90-gd4130d0ee3c7
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 7 runs,
 1 regressions (v5.10.138-cip15-90-gd4130d0ee3c7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 18:21:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9388

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 7 runs, 1 regr=
essions (v5.10.138-cip15-90-gd4130d0ee3c7)

Regressions Summary
-------------------

platform       | arch  | lab     | compiler | defconfig                  | =
regressions
---------------+-------+---------+----------+----------------------------+-=
-----------
r8a774c0-ek874 | arm64 | lab-cip | gcc-10   | defconfig+arm64-chromebook | =
1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.138-cip15-90-gd4130d0ee3c7/plan/baseline-=
cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.138-cip15-90-gd4130d0ee3c7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d4130d0ee3c72fc50c48ae861863e85537802c47 =



Test Regressions
---------------- =



platform       | arch  | lab     | compiler | defconfig                  | =
regressions
---------------+-------+---------+----------+----------------------------+-=
-----------
r8a774c0-ek874 | arm64 | lab-cip | gcc-10   | defconfig+arm64-chromebook | =
1          =


  Details:     https://kernelci.org/test/plan/id/630f9d4037583745cd35564a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm64/cip-core-image-kernelci-cip-core-buster-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/630f9d4037583=
745cd35564b
        new failure (last pass: v5.10.136-cip14-542-g97767707d3d0) =

 =20

