Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2CAC4167D
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 07:16:52 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.22839.1699600605965857986
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 09 Nov 2023 23:16:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=IE71aJVm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6c3363a2b93so1783776b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 09 Nov 2023 23:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699600605; x=1700205405; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c8IZ562J8KTwcHkLhxLtJxLMyMwwQFW7rNDY94um8Ak=;
        b=IE71aJVmBDSY62vlkFiOKRXrD3In2GYJNzOdNG1vlloyGyoG7PwCqh2BrI+GoNEzw1
         DusOLsQcVrqrsV02ZNfqKr/4nQE1zyKngZWegBybElIoHxWDBeYyVjWAcms3K+JGUS9Z
         qpmAvLHFCnh6007/902iywtQAItgy1OQ9tdPcA0VHRg/7ZfEsZ2msr1XFneGEtoYaUZ/
         xXr6qEwQncr6FXXiP8utEH1eYmWQJ0l9BVd3xsP3OsSev3YHt5qzGGnhX7YMc4opHu/c
         jniHS4TztJE3jqYythg+RnBOhjEHJ+AKpRbcKWvbd2UGilHTVoBJG6NKw9Alvm8w/Mmf
         uL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699600605; x=1700205405;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8IZ562J8KTwcHkLhxLtJxLMyMwwQFW7rNDY94um8Ak=;
        b=tbwIXN6rRhRwA++BDDw1iw7qgaHE93sLf//GJwF5/13tQmvpqstOqxw6Q0/1uKrFNv
         3Qjoj1Lrb4txqXxXGCfbOyUHFPLYXlMSBolWPUanSfiZCR2KwxyQ8goTim0/QLT9qqkp
         3aMdta95k36ayowt74veomFQjNxdi678qRa6b+3tUpiLC/6/EhysiewVvdkQMd/Hgw4D
         60qJB/pwAvsdBjAnYdz1XQ/jP8LQUtI3/ozGe+QJTy6ksm3u0UcxnvnwSVDDn9B3sKBB
         BbPCe5Xca1yc0dPl8JjrnooJ9RcrXwzyM9Ft9xaLMhcEXfOQCNjSfiWtiq6M1E42XF3l
         IThQ==
X-Gm-Message-State: AOJu0YyanZzRUQMdUXS4ff9pyCpmbWOgC9djsv32IUd1tqZ28IEm6AeA
	pnQWJrZLGvtTS8HgEN6wzbUoGBOc+41KlY/iL63AqA==
X-Google-Smtp-Source: AGHT+IEx0+xZA8I8Vz49tNO+TyuTBrc47fW32QRrb/bO2MyvBk8xAckNOP75G63FiHqptfzxdrdpHA==
X-Received: by 2002:aa7:88d6:0:b0:68f:d1a7:1a3a with SMTP id k22-20020aa788d6000000b0068fd1a71a3amr7199976pff.8.1699600604435;
        Thu, 09 Nov 2023 23:16:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w28-20020aa79a1c000000b006c4d371beeasm815160pfj.217.2023.11.09.23.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 23:16:40 -0800 (PST)
Message-ID: <654dd8d8.a70a0220.4e503.27b4@mx.google.com>
Date: Thu, 09 Nov 2023 23:16:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.200-cip40
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 2 runs,
 1 regressions (v5.10.200-cip40)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Nov 2023 07:16:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13560

cip/linux-5.10.y-cip kselftest-seccomp: 2 runs, 1 regressions (v5.10.200-ci=
p40)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.200-cip40/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.200-cip40
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      166400a23a22e665f5d880a99149b73abede402d =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/654dcdd8d01885c3a2efcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-=
hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-=
hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/654dcdd8d018=
85c3a2efcef7
        failing since 36 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

