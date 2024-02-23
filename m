Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1662BC54E4C
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 12:06:57 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.9115.1708690013635116809
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Feb 2024 04:06:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=We0/kLmn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso616766b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Feb 2024 04:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708690012; x=1709294812; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r5mcyjBEmzVHpDm7XxgMxMPKw0BLh4J5Fq1ioaztKL8=;
        b=We0/kLmnDQp9MC/rwrjHaHrpUfv/vPNO6pXEBUdVMXNCu29S43NPXU1BiZuVuWcnls
         gmfzp1AWL/SK+URoMubekLFqlAlrvrfM8GFVCtMKYfwA6E7tSEymvg6cFDKSnauf9Ej6
         ++setMj0OE6ejzVa45/t63IqzIkS2tBNTd5SEk06EL+iNPqNebdoegf9Czwz34HsoUWG
         krHekvr/BtW9tpUh8vx2bHPy0PU6LnU0ZAgLRXRv8GOGp1gWJ5UYa+i/ZJ4p150FG54s
         EfGi4UlJmPYAJV4mE8Ds/vwGrmhtJbwqxAD5XY04G43tHITp/EdJigmvmhOJvIfppxo1
         rxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708690012; x=1709294812;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5mcyjBEmzVHpDm7XxgMxMPKw0BLh4J5Fq1ioaztKL8=;
        b=Zc4z/TDh8NaltB+0bQ1HeH6gxSVESgihhfl4PeySyeNF9fTKlgnjxrtbPZvKCMK62K
         RUSccTl4m5PGDO+CILO++jQlsIbcK/p2SCjNzrECs1IXdn+dlQYTOS2Osj1zLd0hkJkn
         CaoV/Or5i442fqIC9lOA9MPbhth/8EbeSSJLD+aivKuI/oDeXOz2VDWiGfrfK7Hhm47m
         m/x5T7lQ79y9otjz+3/OcyE3Oo3JECtjrIUt0Og187wBeZPvvKZH3fLUTm7RvQTnmadu
         XmJ3hZAHx0ML1j5keSXNeBctFmwWIR2RaR27Q4FLgOGD1+JBbg6JQfLE82jzE33TCZk/
         LQ9A==
X-Gm-Message-State: AOJu0YybslAVM8n40kJm8Jm5xYj/V9VATlH3UEf71845cdG56xZgtydt
	8dOZGk9Agtsk/IdRDNeSPHJ6XjdC0/5v6UDmjaurU+TMMhBGuZe6DVv8AgRdZ2SIMoPEgonMPO+
	2kb4=
X-Google-Smtp-Source: AGHT+IFo3j+URVsYbfRxgX+lpZ0T0rlTlQmVH+mPsCb4HpUlPxNDNeOQq2DQdZCAcdriY2Oqu+ySFQ==
X-Received: by 2002:a05:6a00:2d2a:b0:6e4:908c:613b with SMTP id fa42-20020a056a002d2a00b006e4908c613bmr7364248pfb.8.1708690012509;
        Fri, 23 Feb 2024 04:06:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b006e48e64ef54sm5409209pfv.173.2024.02.23.04.06.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 04:06:50 -0800 (PST)
Message-ID: <65d88a5a.050a0220.da55.38d9@mx.google.com>
Date: Fri, 23 Feb 2024 04:06:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-424-g38943e302f8c8
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 12 runs,
 3 regressions (v5.10.209-cip44-424-g38943e302f8c8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Feb 2024 12:06:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15077

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 12 runs, 3 regressio=
ns (v5.10.209-cip44-424-g38943e302f8c8)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 2          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-424-g38943e302f8c8/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-424-g38943e302f8c8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38943e302f8c8bda23c2853f688afa5e35cae90d =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65d8802617f1d7d19e63702b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/ltp-timers-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/ltp-timers-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65d8802617f=
1d7d19e637030
        failing since 48 days (last pass: v5.10.201-cip41-473-gc43d7b7bbe83=
a, first fail: v5.10.205-897-gcc9858ae2881) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65d8802617f=
1d7d19e637030
        failing since 48 days (last pass: v5.10.201-cip41-473-gc43d7b7bbe83=
a, first fail: v5.10.205-897-gcc9858ae2881) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65d87cd07165bed7df63704f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-timers.login: https://kernelci.org/test/case/id/65d87cd07165bed7df6=
37050
        failing since 48 days (last pass: v5.10.201-cip41-540-g3640150b3b16=
9, first fail: v5.10.205-897-gcc9858ae2881) =

 =20

