Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BDFC7EE2D
	for <webhook@archiver.kernel.org>; Fri, 26 May 2023 08:27:32 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web10.3646.1685089652349193666
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 26 May 2023 01:27:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=J1kOTii6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2563a4b6285so32369a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 26 May 2023 01:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685089651; x=1687681651;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MTJeJiRv1Nd5hpSRIPOmlUyz1cuzmz2JAsdDJAlcl04=;
        b=J1kOTii6L00DWJqDk52I+ohdGtT9qcp71lc31COaYmkhmW5BpQEjugTRGOyz4Xp/Yf
         KsMOvSEkxpviJrQsNuGTllGLXaQ5nTE6RE1qLAUGK2xLpQfHfR6F/Y5yG8x80xy8FSaG
         j3uIrl5HohQqX+vE7Y+gMxRrJybnWSN3IV4VWtUqoRogckNH5ZJOqB+VvyWTb1VNswUB
         dAyGMxYKOjcs60P5NFjE1G5Jybdh4pdMZ+Fxa2BSNPfLZzQU7gninMQKor05mcpQ3QwF
         ZwuUWD8k/mb9CRS5019fdzQ4IdRgxJeQLUyJY3ny07Az1FGYHyaJlslLdKliWOXFwTzz
         4blQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685089651; x=1687681651;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTJeJiRv1Nd5hpSRIPOmlUyz1cuzmz2JAsdDJAlcl04=;
        b=fTFl2yshTRVyrbprPUzKJale6OvMdqKL2VKLWpwc7UqBA6eYJ/BaKSfJnOXNxie4aj
         H04zUc+9rBOnxPGYeQ9sQqSzsFm4v5pscwJ+StMPO0geNdBQoMJUTcpmeV4WJun/hMuC
         c+fOjvtvnyqrKqFAVAFAsMIF3Rzv4A6htwNCeviKAuQHomsywufFvK7kcvTlwHgiR5ir
         JV7Wv6dNM5SwD2TJ6nB1ugC13J23czzB+gZL0YzaqUA0gtFt93qjbLEbjEa4fBEi13gC
         ff/Nvp+lzFz2BuL8m3u6e3trF2qZUWg262g8sIiifosFT9Zh3SJCpFRog8hsI8RM3upx
         3d2Q==
X-Gm-Message-State: AC+VfDz5QURZw2STdGmBtM3/BuMVw94/KIwXTk8/6MPGB7lgtDi9ANkb
	9iN04Gz+H4zo0Cm0EREj0f4ohOKUq3zlHra6kmcFVQ==
X-Google-Smtp-Source: ACHHUZ4/YD5V7jidmTClGDi/Dx7n1e0UUn93S+6v8uinlM9EMtpa15Jdx5aP/ywBzGnnJHk889ii6g==
X-Received: by 2002:a17:90a:2e0a:b0:24d:fba9:80e9 with SMTP id q10-20020a17090a2e0a00b0024dfba980e9mr1620663pjd.23.1685089651292;
        Fri, 26 May 2023 01:27:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d10-20020a65424a000000b0053051d50a48sm2098425pgq.79.2023.05.26.01.27.30
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 01:27:30 -0700 (PDT)
Message-ID: <64706d72.650a0220.a0fee.3d5f@mx.google.com>
Date: Fri, 26 May 2023 01:27:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.180-cip33-21-g090289427e8b2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs,
 1 regressions (v5.10.180-cip33-21-g090289427e8b2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 May 2023 08:27:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11652

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs, 1 regre=
ssions (v5.10.180-cip33-21-g090289427e8b2)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip33-21-g090289427e8b2/plan/kselftes=
t-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip33-21-g090289427e8b2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      090289427e8b2be9dac126c4d1b760b100f2c6b8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647059477e5c562d4b2e861a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230519.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/647059477e5c56=
2d4b2e861b
        new failure (last pass: v5.10.179-cip32-384-g291adc46abef0) =

 =20

