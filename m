Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1141ACD6120
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 18:47:02 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.71064.1696877219877973969
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 09 Oct 2023 11:46:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ELXsf0uA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-690ba63891dso3533391b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 09 Oct 2023 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696877218; x=1697482018; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zo3ts+bT5K59MtIYqigf+m1bblveQJ/CXgWqpQ6CUEA=;
        b=ELXsf0uAvQ6MgJZLN0RHy9pH3FprdSyWJrra2tWdLz7aasZIg1mIGu+QI2iVmObWU2
         RbRPnC39ZrV4GPMW35tkVjwGSHMl/Ep9lj8FrjM/iahp2bPx8KqA1pssrTwJNuhFT/iv
         nadAEw6te0EQ90k2p/8p3q5dSsIyfQ425Qxbz9jsNmqNcfEcXza2zbAEMG5aLotiM6sU
         1baSi07yWaRyYNyxQMeVTa3eZ9K8jGXKc7uehBWQiybsH5ZnKrO0fdFmYrSvnQNy6iZ1
         f6pWhayEcHd37k01JBM2ErUNm+7ywJbb1100WJFteIx9bbqe+xmSxoPykWNcasIBaXq1
         DIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696877218; x=1697482018;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zo3ts+bT5K59MtIYqigf+m1bblveQJ/CXgWqpQ6CUEA=;
        b=w8nFqUVs8YfHW5/c98EK3Z9YD+7tApQBMJidmappAd46Xetw+Dm9E6HzUMO40sXt9A
         tKG6VjKPIdWdICbekMgoyYtWHbKm2O8rJ5gE8W2HQIzyMwzQuSdTZBYwYeyyqueOdTFG
         KbaYQ4RfU0/2KawAqLFy/FWGWMAJaDQOLqS1N0GOXlnntxWs7TuCF7+Y272TC4GdLdvg
         xEj+sGRSkw9xxXk5ltSCO9OyP36U/LaJee1R9bXwgP+gctIFwOMsvayTOb8mBVYG9w1+
         8xb+b1uIn2WThLOa8TkpQux9kc/e+aC8a+watHEEKEgqvXhesBKG/WjhKkDvZPErFzQh
         ZP2g==
X-Gm-Message-State: AOJu0Ywx7C92b83mQqZKOXID1w/REskSDtJeMrdaeNfIYl3gWRLMSVS5
	YOLzqoWVdv5vRZjWa/uds6TVAWXL6TbeTJsPc4YDzQ==
X-Google-Smtp-Source: AGHT+IFYmfDHC2PpQjv7KqKDTKr3cbuYxHdTR3w/wC7Z4DLp7QSAyzxPLPFo4hK99LVPQcbosQTYTQ==
X-Received: by 2002:a05:6a21:3294:b0:16b:8572:5a4a with SMTP id yt20-20020a056a21329400b0016b85725a4amr9197085pzb.61.1696877218488;
        Mon, 09 Oct 2023 11:46:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c26-20020aa781da000000b0068be3489b0dsm6950005pfn.172.2023.10.09.11.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:46:56 -0700 (PDT)
Message-ID: <65244aa0.a70a0220.80e9a.fbdf@mx.google.com>
Date: Mon, 09 Oct 2023 11:46:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-1778-gc774a35d86d2
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4-st20-1778-gc774a35d86d2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 18:47:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13329

cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4-st20=
-1778-gc774a35d86d2)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1778-gc774a35d86d2/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1778-gc774a35d86d2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c774a35d86d261f0d49d25d9a02dbaf95cfd288c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652441ff360693f9e4efcf08

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1778-gc774a35d86d2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1778-gc774a35d86d2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/652441ff36=
0693f9e4efcf09
        failing since 6 days (last pass: v4.4-st20-1430-g2fe294a51ca0, firs=
t fail: v4.4-st20-1779-g48d33e0df7175) =

 =20

