Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3492DC61DB1
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 20:34:52 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.35388.1700685287652035379
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Nov 2023 12:34:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=dibq56bq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so212917b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Nov 2023 12:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700685286; x=1701290086; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3+VbcKLrPjzbXfxeTiSJnl+fw/dJ8hLZy+XSdmdnz0=;
        b=dibq56bqZhOZgGm40WHWtv8LRCqpO1OzFjA+sF1SuNr9Xhpo9siZhqFQ576AotSsQS
         9CO6J2nvD9Y7H2S1tXRxPsKuEJD4DCw1+nHNPND21x6Wr3KnTYlD8CbRx6fphvi60Si8
         DRYayFZQrgTxjdZ0WmRMRmQyGtTIaXtih4/Qxiu8Cmq7j0iJu4eHLIG70hoHEYbL+V6J
         34mm7LSKHWVGp08X+SzrfOk9Kh+WQ/JaVCUheKbJhY2Eg/UC1bP16n/CNx50XM2s/eZb
         1FGxd5TKl2u5AIorUGEXD/DChEoW4EwHegxyeKWGVnCQkYTY3iL0Rd2GfCNDKrN2Bq1v
         Z2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700685286; x=1701290086;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3+VbcKLrPjzbXfxeTiSJnl+fw/dJ8hLZy+XSdmdnz0=;
        b=ZQtsAXDyj9NtzlRLXvPYIwTeojfS32BYnC8oEC6VHs80PeBvPyGNuSMpeosn8vsUlh
         qmuj3piEl+7q1g8WXMRtcGL1G6MvB3gaHQUrZEgY+UHoWEgvVHwVAO5HVQHpDWFw5qYD
         ByRCCA7p4bFA3qqmliFYpK2As6D2s3npUN+8O7nAi5n2drCsH3F+hyvljuvs3U28bSdy
         MaDEiTuSek8uPDd/kMPe8e5ZF+rdJ39mhDtdPBoBKeRNn+6GJiiPfJEj6+FH1cyD/N83
         9qW/TWGHkQ92R3jt5e/mdOZ9GZ9Ox0a7Qe89lvJ9jdzDV65KxMaAFtQM3TZ8kM05ENLc
         CfIg==
X-Gm-Message-State: AOJu0YzjmT+6iPxPHVFWabwt57fXXl6PBn13vjUp+c385aWaFeXbqBsD
	N3GefYl6I+6GenBmTo2LehwWXF9u+GHuY9V3eqE=
X-Google-Smtp-Source: AGHT+IHnvVymznYqrH8ySNCGCHG8c3/0/vDPyvSZTv1rJju3eaat9LmBsic66Ix5XrIa/y70WTRmdA==
X-Received: by 2002:a05:6a00:4387:b0:6cb:e3c5:7cb3 with SMTP id bt7-20020a056a00438700b006cbe3c57cb3mr314589pfb.16.1700685286622;
        Wed, 22 Nov 2023 12:34:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78182000000b006cb8a8a4bbfsm128642pfi.186.2023.11.22.12.34.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:34:42 -0800 (PST)
Message-ID: <655e65e2.a70a0220.cc270.0c6b@mx.google.com>
Date: Wed, 22 Nov 2023 12:34:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.200-cip40-188-g33d0b44cd71d
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs,
 1 regressions (v5.10.200-cip40-188-g33d0b44cd71d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 20:34:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13650

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs, 1 regre=
ssions (v5.10.200-cip40-188-g33d0b44cd71d)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.200-cip40-188-g33d0b44cd71d/plan/kselftes=
t-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.200-cip40-188-g33d0b44cd71d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      33d0b44cd71d9f81944784e605bc1def7fa0b71e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/655e50ce20e7b4e6347e4a77

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/655e50ce20e7b4=
e6347e4a78
        failing since 20 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

