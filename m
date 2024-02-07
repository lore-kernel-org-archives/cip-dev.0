Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1746AC4829F
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 17:49:29 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.4336.1707328161989099004
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 09:49:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=WICkCMAZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e04e7b687bso558308b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 09:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707328161; x=1707932961; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vnyGAT541mtQ1fxWLu+Gu6zosS+VInMFNCDIRuFC+oA=;
        b=WICkCMAZ1PDGD0rCcN1VP5nREgvhCgoUg6CeoYyocWcsYh27UP44acIdBBkUk36xez
         8jJ9hVMuR7gYBER29+kfQcsW6rz3StConxaV13pN2yZEV+mrnPx/6j+5oF9aXhDNoYkU
         1SRuoi9aOzLMgb33Hsd9lYnhvqI7JgoyPmhUH5WVKFVH6XRFt05jhfdigYkd5JL8NWPn
         f/wBrTPeTCiLkfuCCYdekHNJ4sZyiww/Xuli4eC4aytPfQQsRGkezu4aCVP4FTn4gN8A
         4Em6ikzhwaRbndXiy5Jnypt9i539Q3nOrDYui+UE5dcImXz8impP65aeagYQG2MGj/JI
         GE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707328161; x=1707932961;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnyGAT541mtQ1fxWLu+Gu6zosS+VInMFNCDIRuFC+oA=;
        b=hMsmNvspfbqCx8DzzFa8pw9v3VeVTHOlC8iEfcMW7xR6b0kyaq8kUFzdV5YZDJ6U7d
         woQ6XVP08w/r0XwOfzFHdge1HRcafYWH1bAHNHl6s1QKKYFX4XUmbZWyvaRQ1qum0zJm
         7SAJOAIFALMmBnOH/bVG2UHFrmvpICDD+rNCZPpqbKpEPoGeVCIqcV0pPcS72IlYxDep
         Wo5a3VNrBENaYKjISMZUe85uNxqsRQYnn0oM+cB04TyX56P64MubnRSMXTTL4g/LQrVt
         hWfhD8mp0PRdkfJXcGVkAnS1GIycAr+H6RPOzWo0lT2HLnkHT7y4jmHuUEgLgS7NuhMB
         pMyA==
X-Gm-Message-State: AOJu0Yxq4R7C0qgZ7sf9HI/P6Un1z6Rp9yu+15ivW3o0GgSTcWL6vIHI
	dS0hnMH+aYtnr5d2nFNoh8S6d9KqyY/BdQ2UTnBIjk2/E4xot4rly7woi4qtgjZqEvZTzqijwC8
	i854=
X-Google-Smtp-Source: AGHT+IF65BP+TGDm9lxSt3YWp5hLTFrNgjnWgzoHa9Cwy5Rb8mwxo3RKdLJyqtx8YFB6v6oOtmoY0g==
X-Received: by 2002:a05:6a00:9399:b0:6ce:6b61:2f2e with SMTP id ka25-20020a056a00939900b006ce6b612f2emr3701761pfb.24.1707328160712;
        Wed, 07 Feb 2024 09:49:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id hq17-20020a056a00681100b006e025030700sm1880052pfb.190.2024.02.07.09.49.16
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:49:16 -0800 (PST)
Message-ID: <65c3c29c.050a0220.701cf.60a6@mx.google.com>
Date: Wed, 07 Feb 2024 09:49:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1251-g57b839f015944
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 4 regressions (v4.4.302-cip72-1251-g57b839f015944)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 17:49:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14896

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 4 regressions (v4.4.302-=
cip72-1251-g57b839f015944)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip72-1251-g57b839f015944/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-1251-g57b839f015944
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      57b839f0159440df3a9c4b22dccee20e801350a7

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3ac2e02c29b09428e1efe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c3ac2e02c29b09428=
e1eff
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3acf92620db32338e1ea2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c3acf92620db32338=
e1ea3
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3ac3dbbd0d2d0168e1e9e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c3ac3dbbd0d2d0168=
e1e9f
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3adc4a551010a618e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c3adc4a551010a618=
e1e7a
        failing since 0 day (last pass: v5.10.209-cip44-526-gbbb905888ca85,=
 first fail: v4.4.302-cip72-1250-g39ff255b75f5) =

 =20

