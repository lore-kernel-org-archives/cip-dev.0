Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D875C7EE2E
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 00:32:04 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web11.34724.1677285116110814956
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Feb 2023 16:31:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=FxMn1Rvk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id d6so575362pgu.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Feb 2023 16:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rwvuQTte3btMizZS/x9rhGl25aCz0DalfomM3IxgphY=;
        b=FxMn1Rvk9KttF5xg6mp/vUvH0b5kD7aRdDrIoXMct+ubvJV5LfxT+lTddGCzXzzaJH
         OlNzad0NRvDotaLVmqPQqG6whjfNKuYY5JcDf6fviz09cFbjrAxtsGKtaK7TaNLbjoPe
         h6YCBihkcs1qw8SLxKzlsHHGD2/5Iw4P6ZhqswY+7egiregj7TsbnFG703V/cGB2ILpK
         CtibqT+IWf5FBscXNK23KW9ExjI0rhGqi1rCgxEDdHbMBIt8+XOviGMfBPd5Va3ryVAA
         4jhzqdz88JjW9hRuet46FTiEHiFJlbpkmUsdHnb65D+sbn/e2EKp8+0XhQ6b64gFX0O+
         v+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwvuQTte3btMizZS/x9rhGl25aCz0DalfomM3IxgphY=;
        b=rpoxJNHm34Lrt+lMpZGICOKXarU+3WV/CB2S/8GQ1T3L89hlupLwDBTLZ+R+d5z7C0
         D3CZHu9r3HCZYL65AgpKZECkePEeDvNyN1u7hkMsAzUYf5UgbDNwUiaOjRXgLnhY/1+z
         Wc/axd58gyjSsIkuKuqpnexHp0ISw7VHIVoiuCLzQxzR//Pp1xwNPMxLTeq9yERj2TrD
         /EIYoBerVJ/UM/U6Arn7VPeSQ95p9dFuQCeNde6UF0OsNK9Q2RFAHlwlCEX0kAFRnkSK
         3kGHyn2yYL1Pf5UIYV+TnOvxlGmHOUrTZugxCUW2eWYbs2+V8t9Ae36gYKwtoinQgPBi
         0zsw==
X-Gm-Message-State: AO0yUKWVVN3P5eUakXB2t1jPuF69mvNdWwqj9ficQnSMFDRpkJugPFUi
	KOS0w0VvM2g58zdVsmZLhAPFkPiXzHxLo+Y8zJEZcg==
X-Google-Smtp-Source: AK7set+SQOUZpPWUONcAy+5ODWyM9PVg6NR/djUV+3pvFEuUDl+mW5vVCAZSeeTlV1ZmS9J15GeqFQ==
X-Received: by 2002:aa7:8f11:0:b0:5df:3aa1:10c5 with SMTP id x17-20020aa78f11000000b005df3aa110c5mr5851770pfr.14.1677285115069;
        Fri, 24 Feb 2023 16:31:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l12-20020a62be0c000000b005da23d8cbffsm117654pff.158.2023.02.24.16.31.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 16:31:54 -0800 (PST)
Message-ID: <63f956fa.620a0220.597f9.0548@mx.google.com>
Date: Fri, 24 Feb 2023 16:31:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-456-g42a59c4e5329
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 11 runs,
 1 regressions (v5.10.168-cip27-456-g42a59c4e5329)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Feb 2023 00:32:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10833

cip-gitlab/ci/pavel/linux-test kselftest-futex: 11 runs, 1 regressions (v5.=
10.168-cip27-456-g42a59c4e5329)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.168-cip27-456-g42a59c4e5329/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.168-cip27-456-g42a59c4e5329
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      42a59c4e5329312aec627def5fefeaf40a482f9c =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f94dbf13d52f52ec8c8638

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230217.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63f94dbf13d52f=
52ec8c8639
        new failure (last pass: v5.10.167-cip26-2-g28bb49f7179b) =

 =20

