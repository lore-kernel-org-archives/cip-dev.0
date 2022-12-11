Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D53C4167B
	for <webhook@archiver.kernel.org>; Sun, 11 Dec 2022 19:04:14 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.24259.1670785444763740217
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 11 Dec 2022 11:04:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=SierGWhh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so10017169pjd.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 11 Dec 2022 11:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9ldJKtYQSZTTczTSxbeYbnK3EYQAO92V+jGw6WtUnv8=;
        b=SierGWhhEwfuF8rfkRaL8Uv48rS2n1YdiUyDTb2dEsN80Qr67NworlUypqcqPOG7E5
         F4ViSpeD8zty8RQiuVDJVKh8OGF0uiv25JCIdjP0DuCTdXQXCDujVyw7pVvGlrroizf1
         x3oydzKHov4+eAceePzTAJZOzfxaunEAVVqkbNkpXBG7TWYkZE+SfVVCN/Qu3NjImbDq
         Okk0U1SK/yohpdfOmi+UJ7n6OHQuMo2kzo2uYrf7MpuaWh3wrf0bUWVL9R/YPy0RkCwh
         JasOu5p8FyAgsmcPjwuhpfDqPjHoD2vJfoXWf+o3HMN9wQ8AyE+MN+gGF8JmpUtF4W78
         OvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ldJKtYQSZTTczTSxbeYbnK3EYQAO92V+jGw6WtUnv8=;
        b=kDJopk1Za4ft9Qtc8kM2aQnbUNeIeMDsY4YnXZHT0DEXy6zwky7IgsQxl5Slk3kRTF
         +xIo+Gja3MLVPS9vO6qkwg4lRiFn5FZc5bzm2ppZvfeO2QLfN/pJoX6pjGzio49a5L1p
         xpq2dyFwgHUaR1kTZYRIcGRENA4sAw0kzN9X530nQmp+wCsjGtEPYIj13Ur8IZyLrj1j
         rbuiv4AvoALITgOmVtGQI29WA/WozBvUS8uUfkczdxVPaXzpTkPBDU+TjSDv4ZdrNGep
         zOBCuLuINtxr0XzKXaUWiDbWsW9UD5EK/mqtRNn+IXZPmioA+TAhtYKDoYus1dmlWJwC
         vOmA==
X-Gm-Message-State: ANoB5plpKZtLQTKXVYM6RplQ8r/F1GxhHgl/GwithVGk1merCsAKaIc0
	q3XHnosd01pFP2Ik29jLxA2U/6Ca1x7t32xw
X-Google-Smtp-Source: AA0mqf5UxNpUum27xNB8kSU2X/WK7o3SyWM2OssolxNeh+j66kWjVE/1RClsH9H6EwECOKmohLK6Yg==
X-Received: by 2002:a17:902:b198:b0:189:fa12:c98a with SMTP id s24-20020a170902b19800b00189fa12c98amr15389294plr.66.1670785443389;
        Sun, 11 Dec 2022 11:04:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e85100b001871acf245csm4677754plg.37.2022.12.11.11.04.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 11:04:02 -0800 (PST)
Message-ID: <639629a2.170a0220.f18b5.7f8b@mx.google.com>
Date: Sun, 11 Dec 2022 11:04:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.158-cip22-435-g2c52868ae1cbc
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 10 runs,
 1 regressions (v5.10.158-cip22-435-g2c52868ae1cbc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 11 Dec 2022 19:04:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10200

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 10 runs, 1 regression=
s (v5.10.158-cip22-435-g2c52868ae1cbc)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.158-cip22-435-g2c52868ae1cbc/plan/kselftest-filesyste=
ms/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.158-cip22-435-g2c52868ae1cbc
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2c52868ae1cbccd8bfb24f6b41a5fd024c1ca7e8 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/63961befd3dd5cd1d72abd30

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig/gcc-10/lab-baylibre/kse=
lftest-filesystems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig/gcc-10/lab-baylibre/kse=
lftest-filesystems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221202.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63961bef=
d3dd5cd1d72abd31
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =20

