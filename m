Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80354C61DA3
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 11:31:29 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web10.15502.1677238288996483204
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Feb 2023 03:31:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=TTWwpWd+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id gi3-20020a17090b110300b0023762f642dcso2367246pjb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Feb 2023 03:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yM0V0ugsysx79157rpnOjJY+IyZUVKpHTrGoYDpIJbs=;
        b=TTWwpWd+DbZA0DdmD9dI7njrcyJcOXVKWmXdngwKFVK9Z8Hgvg0dI8mHJ+3q2MoyhL
         Zvr5IS6YQoPU6VlA6fddy2iM0Qfw8D8JorUTv+CsdZBs0QSjh5RxMtByYcO5bm4WCwES
         0rIHAjvTH/42yFK38AFlqMDDPtWVdctnUlyOwDSVEhVvwruI6e0yoo5LAxh0Flx3ITH6
         gNlrIdwYIDVFncN8XJ+XT0mpl32/xW7ZlrLrJg1/9stdBcUf6rmKaThIGZENybUNLsa9
         V82XlZ5C9tMaeWEbO+BedtN5sEMyCJKQhulEgIEmbY1CH1Xpy+HY7bnsC4CFlmman74L
         iWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yM0V0ugsysx79157rpnOjJY+IyZUVKpHTrGoYDpIJbs=;
        b=F9lPVAVYot6vV9cVSbC33Kkg3xGXHQ3Xjlv0H9P4gaQ11TE7yI+ngw7A0GLG9j4w03
         OD49zeJkT34S3Yf7dz19UM/g61iZY16lOLEtUSYeRdcvmsTERJXao7QerZYYaw4WCNw9
         KaXfGAvSWoipxB4aQ8GskBn9GQj+48e5hn7CcLDxXZsu2ureuIC549+HjgassEj41Xm8
         2TcwdnH3Osg+6N/+81aOQ204ANEaZVCrnAAgPa+MwTnPMdc21xLN1n6CDEPItBIpGNXl
         qmsjEbVHSm/aBbgzY9HQfZPwoo0SRrgSn4Vq2RMrR7crvxSDQRfZPb4ZE/TMQNfTCbJd
         OI7g==
X-Gm-Message-State: AO0yUKXevEWiJmoYa+hFM0QD77pTMhiyX1yaXcJFay2O5rZYL1iqjhnv
	pTl3oCJHGgOovsaw62C20XY/cTfcIUNjgGVPtAbkkg==
X-Google-Smtp-Source: AK7set8HEinhe24JRvAM4lNxz7hFLl8g5kiRCIhJW603nXYAHOgEcekL8xuRcIFh9mg+hztPKwwjVA==
X-Received: by 2002:a17:902:e80f:b0:19a:972a:7cb3 with SMTP id u15-20020a170902e80f00b0019a972a7cb3mr18544286plg.60.1677238288284;
        Fri, 24 Feb 2023 03:31:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iw4-20020a170903044400b0019a5aa7eab0sm85243plb.54.2023.02.24.03.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 03:31:27 -0800 (PST)
Message-ID: <63f8a00f.170a0220.991c6.01f6@mx.google.com>
Date: Fri, 24 Feb 2023 03:31:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.168-cip27
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 8 runs,
 1 regressions (v5.10.168-cip27)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 11:31:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10810

cip/linux-5.10.y-cip kselftest-seccomp: 8 runs, 1 regressions (v5.10.168-ci=
p27)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.168-cip27/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.168-cip27
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cc82f737b68c179240070fa34771bcfd0a5fa421 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88a9f9e33489c708c87e4

  Results:     87 PASS, 3 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-seccomp-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-seccomp-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230217.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/63f88a9f9e33489c708c87e6
        failing since 106 days (last pass: v5.10.153-cip19, first fail: v5.=
10.153-cip19-3-gc76f4e7e5c71) =

 =20

