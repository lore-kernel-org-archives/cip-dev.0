Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA28C54E4A
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 01:05:52 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.40413.1709341544284963176
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 17:05:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=tqw0WoJ6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so10490185ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 17:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709341543; x=1709946343; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hUDAbcOAeVCD6Zz+sghipbAcBQCfzDb1XyxKWgpEkjA=;
        b=tqw0WoJ6KNdC/k6yxNYjaY6vzs1k+LnS7ME26f+Ok/F1v1soiFKLciPX4n9Ud1MfuF
         EHhBvvwJqJ9EmDI09kJpU6UOrKshmG/P2/J7SP4vjhzSOaurdf4yGYUo4PsAmc8t3Vqh
         PKy795r3ReT6RVK8BM1VyyFX07ncFSXsUzBnfAtvSxc6OHn1iE5pgw7qltK8flFtt5XM
         pUUOca9L1c6GsZxO47YicN8WJ/MlecJPtdAEU0vykBP1NlwtePbZGNsKrUPf6Ltbt1B7
         aRX085zT4T4GRxVDV7I1LGZOD95Shy98+d0Ln61fn+aw8DcYNicWnPEn1URBiZv5buoD
         k63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341543; x=1709946343;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUDAbcOAeVCD6Zz+sghipbAcBQCfzDb1XyxKWgpEkjA=;
        b=uBjK+4hKao67/DqghKN8nUBnYiJK3jcAg3w2bzfyEj//cWhdV77kaFLgh8tx7Lfx+a
         nDuvVz7FlnPehqCpYTSJvSxqYODG2cM5t8mmEpoOv0NOnket3xIZmarJwx1Njut7UFsu
         QwCWRtPVP4ugdZCEGSHjKTTSmZdISwP+1KK7budcPVyVGUFzYb8T09oqoFE5H9oVy446
         D9mAOdPdaY2/kHFsBzTNEMENyjSCZ+fM2suazSM2o01kSjYur6eoySP+kPulYWqIikQl
         tEXbZ0ydVtANhzhIe6ruRwUv74Ef02LmE5OkwW87i2X6zGeZzOjoBoNcx0sqH4luH+Hl
         P3+A==
X-Gm-Message-State: AOJu0YyVpjnC7Wq6Qo9/ppsDOAAUjOW2rWUJPnNlcV0vxUc9xL8OBlS6
	NdzXOm1kF3hsk4MUz9bBHZNo++S+vJGiDromj6lECE/nh9ukfTy375/fpgTjIuer8ZuDHQdgkaK
	gd1Y=
X-Google-Smtp-Source: AGHT+IEDxcayhBD3UhLUrKQEPUknabxG97ypB24D8Y6kw52U9mzJnujW02ByCXFFjPKZDthxVeYArA==
X-Received: by 2002:a17:902:cece:b0:1dc:8f8e:63e2 with SMTP id d14-20020a170902cece00b001dc8f8e63e2mr3722568plg.46.1709341542957;
        Fri, 01 Mar 2024 17:05:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090301c500b001dc11f90512sm4069964plh.126.2024.03.01.17.05.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:05:41 -0800 (PST)
Message-ID: <65e27b65.170a0220.d005f.471c@mx.google.com>
Date: Fri, 01 Mar 2024 17:05:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.306-cip107-1142-gdcbd51e7744f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 5 runs,
 2 regressions (v4.19.306-cip107-1142-gdcbd51e7744f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 01:05:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15155

cip-gitlab/ci/pavel/linux-test ltp-mm: 5 runs, 2 regressions (v4.19.306-cip=
107-1142-gdcbd51e7744f)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.306-cip107-1142-gdcbd51e7744f/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.306-cip107-1142-gdcbd51e7744f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dcbd51e7744fcf9baa3ea87a028b574fda95d428

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e26993957b7c43d6637031

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65e26993957b7c43d6637032
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e270655736421bae637017

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/x86_64/x86_64_defconfig+x86-board/gcc-=
10/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65e270655736421bae637018
        new failure (last pass: v5.10.209-cip44-56-gdc749db3de7d1) =

 =20

