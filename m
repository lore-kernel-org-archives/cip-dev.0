Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14398C54798
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 04:16:02 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.14143.1709612155825422403
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Mar 2024 20:15:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=qaw6rZcN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc96f64c10so48293285ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 04 Mar 2024 20:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709612155; x=1710216955; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Xro6W9Xzsw06edv1K/PnwfcD046GmB/ABwXI3yZW1Y=;
        b=qaw6rZcNJKVvxufunjVot8L5CjmhdrlHv1/rs/0PNtlS67BGaRGe5Q5SbOcgCny1UL
         kz+BuEXMoMOxwCHdSFKrjBrBGpkpNwZvC2+td+xGjRdOHOLkTmztc8BTrB/W25iNoaCp
         AzAzUwbsKAnZnlVF1M0+q4C8d1Esdq93jdSOaNBsQ+3C5DYGbV9+BlaCTsTfY7AMaDrE
         iA0oWjN/SB1OFf176h8fb+kXtsPuj1NS5jiTQy1cE+DkUEOc5IMRg5eNU7Neko0CKtyY
         CaBIFCm1PA0kKvQNvHRUo5HknV3RndPcbxZfdaP4uysenjkPWkp2IETYHoNWCXj9uH/I
         V94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709612155; x=1710216955;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Xro6W9Xzsw06edv1K/PnwfcD046GmB/ABwXI3yZW1Y=;
        b=FrWhVVpuzq2o95M/w/YSUV3TKUDxYV+YgxrL3OMy8fRlOhWBNUor1VqPWZa7Th9iFb
         syEIVEtjua7E91IQdT09/MGfa4PQ4FsqyR9t1SKezJ+MkJb2VIiO5tY0hro0lO8mJlkQ
         SSNojyTqa4RjxEnmtQm297JcAk4QBuKNSArVqCTG0dOFNfhYkXc37RnYJ+CnuUzct+6L
         4ztTzlZ/rWQNVjg5awPkao9HHJeffCljBCzdS/dTwDpHf08ch0/JbOe8/9CMN4SwDsl8
         Nqw/Ttj3OymDDCV+nEyU5TISMsEEiuaB6jKujXM5FkUbdH5Zbcfv7TdViOw7G4aWc1hl
         wMUg==
X-Gm-Message-State: AOJu0YyA6Ps3fQMZ1aPg1IKSA9/wACh58u7hD79k4gJRtl+D1lNdq6gp
	qG+EAXcnaBggwp/5XkGD2BBLzLbBYaEeSUVPfhKw86TUdkSbXylqJAi4/H2Rw50agWCCcr4U9z8
	eyZQ=
X-Google-Smtp-Source: AGHT+IEPlGRR3xku8cZSlcZUWbBHMBtXVZCw6dUozNn7AZCEYO1BV42gBlPYVGkZwIXgntiqoB7lNg==
X-Received: by 2002:a17:902:da91:b0:1dc:c9f4:2dab with SMTP id j17-20020a170902da9100b001dcc9f42dabmr1074055plx.1.1709612154804;
        Mon, 04 Mar 2024 20:15:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902e31100b001dbcf653017sm9366018plc.289.2024.03.04.20.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 20:15:54 -0800 (PST)
Message-ID: <65e69c7a.170a0220.715e7.5351@mx.google.com>
Date: Mon, 04 Mar 2024 20:15:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-2244-g20d1c7153f15
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc baseline-nfs: 26 runs,
 1 regressions (v4.4-st20-2244-g20d1c7153f15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 04:16:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15202

cip/linux-4.4.y-st-rc baseline-nfs: 26 runs, 1 regressions (v4.4-st20-2244-=
g20d1c7153f15)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-2244-g20d1c7153f15/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-2244-g20d1c7153f15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      20d1c7153f15fe1c99de6372d626390a1fb2ca2c =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e694e514958dc4734c42da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-2244-g20d1c7153f15/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora=
/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-2244-g20d1c7153f15/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora=
/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e694e514958dc47=
34c42db
        new failure (last pass: v4.4-st20-2245-gb01c108f53cc0) =

 =20

