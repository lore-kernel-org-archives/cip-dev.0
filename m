Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15353C5478C
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 04:46:02 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.14529.1709613955801835979
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Mar 2024 20:45:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=jrtkcLW8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dd1d9daf02so9534555ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 04 Mar 2024 20:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709613955; x=1710218755; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eIBZFWD8kW6ye5mIY2hpg3ZwoMOM7duuMqydA88B+II=;
        b=jrtkcLW88LqSPSXQ/UfOgY0o1npVCDjmVnVtkFVbsOu8IFrfoKx2F6EhwwstFi7UHl
         zynCDJudXPbLdCfADnFziWeaHe1uxkfTdhYn1oC6m1UIyJ/ISRxPoJuidJGK2CNeNktk
         +9LJKqQR8Aa6nEKAkiD45GZ2pdDeKJakRIJwwjaBN94esIZD5gnhvjMBrnN52nM5ePQr
         IFd2ZA5TCG7KgK9cp6Mb5CbVVkL24dPJWixGL50BYM2nQ/YmGi0mtggBGLrBVFETfBe6
         KJuc+la4GvjET1NE/OWnUdoWaC1slvXczL9e8KSd6eCnR6+yDe46Sy6U+4h37D0m92DM
         QPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709613955; x=1710218755;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIBZFWD8kW6ye5mIY2hpg3ZwoMOM7duuMqydA88B+II=;
        b=qN5ZAP1j4f/qvdlcsnZPrxfk5Mf27afKgytZtTzRdAjRgQFdbKKvj1W8gc/E7nZ647
         mJOKxTBiIoV+FxTCamXcePgKxXt83JQkE32FXmbfXh5V99EiPO6klnqU5mucRpqVTf8i
         D/XwCfLqCao4Adz/q7mPHz/77dOuysJm1dhvlko2gMPXUI9l/WZVChsLEsxovf3SCle+
         KXomIKNtXK0r5C8+VoTx5Y8dWU+6gwHev9W/QwRyZ02IJe7dGIkZqVWtBnBLSECCVEFc
         EvL6lo+QiH411n69XRKy/qQ9Q9WUXUrk45/dPuIcrbixrDf6CasmGnMnqGNOn50oVo0J
         LxHg==
X-Gm-Message-State: AOJu0YxeJOryha6l32NC78HBhihophNwIqTsAqWYT8luEk9iCsVjjclL
	J0WKRxeiUkcjCl0LR/0fAl/kmAsEJXSK9tt5bdQabFmXIVuiZKrmsAmsaaAKmqwAB8yjp8mcy5y
	uCT4=
X-Google-Smtp-Source: AGHT+IFlTricVrOVEtp9Cg0ZiZeXQrE7U3/l8DacXrLohN9zBAop+EarmNuaWxUnKEYkZ/3rTwYHEQ==
X-Received: by 2002:a17:903:191:b0:1dc:b989:9b96 with SMTP id z17-20020a170903019100b001dcb9899b96mr1009449plg.49.1709613954743;
        Mon, 04 Mar 2024 20:45:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b001dc05537e10sm9416171plj.236.2024.03.04.20.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 20:45:54 -0800 (PST)
Message-ID: <65e6a382.170a0220.6ec41.5427@mx.google.com>
Date: Mon, 04 Mar 2024 20:45:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-2244-g20d1c7153f15
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4-st20-2244-g20d1c7153f15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 04:46:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15203

cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4-st20=
-2244-g20d1c7153f15)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-2244-g20d1c7153f15/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-2244-g20d1c7153f15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      20d1c7153f15fe1c99de6372d626390a1fb2ca2c

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


  Details:     https://kernelci.org/test/plan/id/65e69d73d7bbbc9d4e4c42da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-2244-g20d1c7153f15/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora=
/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-2244-g20d1c7153f15/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora=
/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65e69d73d7=
bbbc9d4e4c42db
        failing since 3 days (last pass: v4.4-st20-1987-g9e48fc479c400, fir=
st fail: v4.4-st20-2245-gb01c108f53cc0) =

 =20

