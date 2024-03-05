Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA9CC54E41
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 13:45:34 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.22875.1709646325863994644
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Mar 2024 05:45:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=JVm9FAHq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc96f64c10so52342335ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Mar 2024 05:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709646324; x=1710251124; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SuYc1i4Xz37qc6dezugva9VzSStaeXmshNjNEC1OrD8=;
        b=JVm9FAHqflXdTbTabAmlSXoJoAZL+cpqjkcn8uUDVzZXQhtV4eynInfyqUhyQOh+xW
         dXiQfg2QpaW0WWlTq4ZTqmMSknGprkal4EHv90astd0qDvNTd/rIwQkeX8j+NekK7KMu
         YD77ubxz1Z0kiOIbrj+7XN45v/pLl7MgqVmYxr+dJSIhkPcrV2XLV6yXPruj31okJHKd
         Ckl/2XO5M3NjR4rRz8CpVpQEW3TQXLRuhiwzMBiAAAj3kHIcXM713rIe+9AWmB56XHph
         V3cveT3Jjl5lhfQwtS5mKy6zhcWFbRd8j6a4o4XbCpaY7P+bQoXj8FmsaWyTX1KZdOfN
         c+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709646324; x=1710251124;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuYc1i4Xz37qc6dezugva9VzSStaeXmshNjNEC1OrD8=;
        b=kM6zpNVxXSc5/mdDd3Kt2cokShGCNAyIGgoOfCFF7tUvP0caWNgJLaKXF5dFcWtp8q
         izyZj8oVrDnYo/sdNZfOaLM+zrngWp9IeDBMQ8flVvseQ1rWWTJY+HjSkW0bfpFczniT
         wIB/bqmwleyQ1julN0ONxmu05kaUN9EpnTJiqGYUjRQoxkodahM5shyJMkkgCV/XUyr6
         fdO4hR2ajrEasxvUkuklqogHQuO2Lcp17bwVhhVW1jPrlW7tu0aefWTJGN4PEdKkJvyX
         EcUwZ6OtvZTu2W9tEJznbkYvKCcfkJ2CNrgo6s/Nd2DjmohlFunGaOp7PLNaxDZ7dvf3
         nHVg==
X-Gm-Message-State: AOJu0YxTyhmZF0qRB2wEFU9dHvBP1gsfLNesFTX5lYjPuz2Ccsyaj/6O
	8Sk9c5pUnykiqqtxUGf5qOWQ0EBBjjs9JZ0H9aCXLajverR/Iu8f4Fh6Yi3qOIqwiREHm4cocnL
	sOU0=
X-Google-Smtp-Source: AGHT+IEnthlSRJP0lJsJPVtA21QbG6hkXXew9Z18xy8Yp8FX9NU4JTfp2dsaakRO3nMVhJ5MizkXgA==
X-Received: by 2002:a17:902:d5d0:b0:1dc:4c25:c4fd with SMTP id g16-20020a170902d5d000b001dc4c25c4fdmr1576170plh.21.1709646324524;
        Tue, 05 Mar 2024 05:45:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b001db5bdd5e33sm10555353plh.48.2024.03.05.05.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:45:24 -0800 (PST)
Message-ID: <65e721f4.170a0220.7b9c4.7b35@mx.google.com>
Date: Tue, 05 Mar 2024 05:45:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-2247-g140bf69dc64d
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 2 runs,
 1 regressions (v4.4-st20-2247-g140bf69dc64d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 13:45:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15222

cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 2 runs, 1 regressions (v4.4-st20=
-2247-g140bf69dc64d)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-2247-g140bf69dc64d/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-2247-g140bf69dc64d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      140bf69dc64d0cace758052e3af9e9cc3e90a09f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e71b3386d531dd6f4c4327

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-2247-g140bf69dc64d/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora=
/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-2247-g140bf69dc64d/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora=
/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65e71b3386=
d531dd6f4c4328
        failing since 3 days (last pass: v4.4-st20-1987-g9e48fc479c400, fir=
st fail: v4.4-st20-2245-gb01c108f53cc0) =

 =20

