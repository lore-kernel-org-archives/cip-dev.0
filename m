Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B101C46CA3
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 00:16:59 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.15082.1701217016341613243
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 28 Nov 2023 16:16:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=dJFxjXI7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-285b926e5deso3134351a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 28 Nov 2023 16:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701217015; x=1701821815; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RBF2MBsaFcTPkihSHIA21AofrlhxEJ2TA+RNsGeiGHA=;
        b=dJFxjXI7UCub8Y9y/nIoe6SgOd0kq3zAaecS0yq34OOdmT7AgLLKiW7zEscahk12qF
         KYBZGisrX3dG4VA46pCRqKhY3mM7YLP9FMQfkNcqkzgdZJ+SxpuDAurdoTJ/Gov2pXpd
         afDUxFQST5zHYIf3/5zTzNMJDaOfvabqlVbj2vwaAXQSwJKWk73VxnSkn2YB6jv9Ck7P
         rv9+P95ySe04yQfeIxVgy51B5HLGQZqMz1mJd8r1BwBmi1d3IkkSV+pHW4igTqo4wE7Q
         u39jwHtCeKvQhlmcA4g0cMJsDjQd8Len+eE1JIK5wJhXbICnTuXrDuiErr+i9UWB0VWc
         aF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701217015; x=1701821815;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBF2MBsaFcTPkihSHIA21AofrlhxEJ2TA+RNsGeiGHA=;
        b=HgnXlUtZ2DDAOhFjxIfj0Kqd+lIOyla6ysAKD8RclqnI1I4920CtxiK8FgBTrMAr+0
         CWC2ctL4m70OuTMgIFNz9d4CqNi98g3kdQgcoBy94POFbcOKcMSzwvaaq+C+NzzN9ig1
         BSWYZo+N+m+BFBeDWPJWhk4dipCMahla+gIn+yL6cRqRMXU82M0fN/e0EpDwDlVX3jl+
         XBhS9FjSMKrYvBkiyP7896JEiZYBoUCp5mNEJp+Brrbbd7blF/jOWG9kutZ0Y+7uGlrS
         m9CCsysjnvheiiiQueVZIMIvGep66loyWVThxPiB0P2Lw/XhZzEH15wrMI4adnPbk6in
         MEKw==
X-Gm-Message-State: AOJu0Yxk89j5/1uXFVmXWYxmW0VKXInukSjAUp9/n8LadZvs47i2LCzm
	3edZB8K9n36HwXbIfqIcHW0u7IMJYhWzGKTHYCI=
X-Google-Smtp-Source: AGHT+IGSLbBOb/0sE8FlJVotORIcGqrNQOGl6rEQVh+KfVyFXYGdcuKjncJCLgvjqvs7eADUmoZIWQ==
X-Received: by 2002:a17:90b:3808:b0:25e:a8ab:9157 with SMTP id mq8-20020a17090b380800b0025ea8ab9157mr16717846pjb.22.1701217015078;
        Tue, 28 Nov 2023 16:16:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z7-20020a170903018700b001c736b0037fsm1199761plg.231.2023.11.28.16.16.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 16:16:54 -0800 (PST)
Message-ID: <656682f6.170a0220.becaa.3e18@mx.google.com>
Date: Tue, 28 Nov 2023 16:16:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-cip41-197-g2d08925b44e52
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 12 runs,
 2 regressions (v5.10.201-cip41-197-g2d08925b44e52)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Nov 2023 00:16:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13753

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 12 runs, 2 regr=
essions (v5.10.201-cip41-197-g2d08925b44e52)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-197-g2d08925b44e52/plan/kselfte=
st-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-197-g2d08925b44e52
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2d08925b44e52ce450bf165f843637412f9c979b =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6566734d3537054c527e4ab3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6566734d353705=
4c527e4ab4
        failing since 26 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/656673b8da331e45687e4aaf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/656673b8da331e=
45687e4ab0
        failing since 26 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

