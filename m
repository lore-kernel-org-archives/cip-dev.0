Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB269CD80B1
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 11:37:07 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.89163.1696937823976306995
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 04:37:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=NGPGytfk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-69101d33315so4088321b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 04:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696937823; x=1697542623; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QNgZ8mESzla4fQeVA0Qtbn7k81rI+IlkdEum37WsRlc=;
        b=NGPGytfkY9kb1x/om2p4I8BhBuAq3zwcZoEluSWg1eqMbsNmqDMSkqIP8pbDLX2LGg
         9W9hgmsd9HFc5aLN+70bFi+eCAPTNon3krIYqfr7yVyoKcpcsH9vzv4uMrbu+x430S7q
         ZDBZlRacenjv3Ppk00CSMlawd20aKBmBzYIOe+ptNynnZNvK/s+chvNBeZJhRbbUB5Zo
         9nd/iG5uIwgVJgRU5/VG3MdJXK4DW/+MSq5pKpu1iLqCvYCr87i14NGiKdV/Ezsp8q7D
         oN4YpI2Vi+QurL9WYAoakYFWtZSEvit6CaLbixGFI9+P+65fi7kxJs2o3j3w3ulC3pa8
         iNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696937823; x=1697542623;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNgZ8mESzla4fQeVA0Qtbn7k81rI+IlkdEum37WsRlc=;
        b=bZClCTtqsFbW1Q2RFI3xM13dr9N2VpUMng8Ljlpcy1yd8agNvgHDmWOhZFmuUsQzVP
         rpjw5tssrPdp4x321ZDwhVq1PTLihEqmf0j4RaQnG6RInES4oKXI4FVV12dSdhzEKMSN
         hWuMEh+64pMgjLmfyMYm6tqJtKfjiwdASDVW18iWPZ6s2cIhOx7bGaJk0dMIpzzsiD4P
         rRGuYGrOjvT+4km+f8xoBlPGjyOzHaEoTjIGc0MjTkELz+qIC4NI9OmYe9oMX8x6gGQ+
         ZcF+gcx8yG1t+q/Z8GjU7Bv8llMN3chgNWmTxwf8WPr8fumThq4vijpr8j86a+gv+DL4
         SkDg==
X-Gm-Message-State: AOJu0Yw5TIFfz+mUb4ckaEqmMepacqIH88jDvryzXsxKn3ggzc5T7RH+
	lSiPIPvmEkmdm3EvlENCWe5WAodbBue4jiyan95vVw==
X-Google-Smtp-Source: AGHT+IFkLJufrThJoyLH2X929jIzbNUui0FGHaI4sLA9dImv5a5zGiaNBy0Gk36OHyRdl1xDjjBeHg==
X-Received: by 2002:a05:6a20:5b19:b0:16b:80b4:c39a with SMTP id kl25-20020a056a205b1900b0016b80b4c39amr8298270pzb.19.1696937822553;
        Tue, 10 Oct 2023 04:37:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001c62e3e1286sm11565745plg.166.2023.10.10.04.37.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:37:01 -0700 (PDT)
Message-ID: <6525375d.170a0220.d22ad.e8f8@mx.google.com>
Date: Tue, 10 Oct 2023 04:37:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-cip39-552-gc89b2c57483f0
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 11 runs,
 3 regressions (v5.10.194-cip39-552-gc89b2c57483f0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 11:37:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13353

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 11 runs, 3 regression=
s (v5.10.194-cip39-552-gc89b2c57483f0)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-cip39-552-gc89b2c57483f0/plan/kselftest-filesyste=
ms/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-552-gc89b2c57483f0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c89b2c57483f0aae7f9cb377230347592eb3520f =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6525236b352de79e28efcf53

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/kselftest-filesystems-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6525236b=
352de79e28efcf54
        failing since 117 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652524aff1f9a051c9efcf33

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/652524af=
f1f9a051c9efcf34
        failing since 117 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/652529aeeb264bf69aefcefa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/kselftes=
t-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-552-gc89b2c57483f0/arm64/defconfig/gcc-10/lab-cip/kselftes=
t-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/652529ae=
eb264bf69aefcefb
        failing since 5 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =20

