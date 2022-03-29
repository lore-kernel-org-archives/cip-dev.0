X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web08.5381.1648553779118239794
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Mar 2022 04:36:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=XMyG+osK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so1746824pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Mar 2022 04:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gUNdLAMgucl6v7TJBLJKgFeOjrc7H3lFKZ3jFG7OFa0=;
        b=XMyG+osKgFSs+1vCDng5w2ClAsIOBQl3jw3qZzdkaZK6Glw+kwI7U8A/Aa9pAj+T9n
         VFbNdH6olRS//2zYXrVPudPCZv12swn9yi18+UJjBWcxLPkYHS3wdo7JIDtRhC/DHeSf
         5zD1InlC21PDgROB4wsL8YSY9aCPe8OGFqDqjDoqoAuNPF+J4X/bKb/9ShItsfde9Vmo
         JBSDhJXJSeIHJpuzg5KEgQrqSJO6ijx3sCMlChIvq9z261s8lEEXkWTtWC7j4a65HBN4
         yatiMrlbdJUC/5Jpfmd6u03p+6IbKsg8IQcFs1oeXKNQXIHmi0h+slc7DLDbouHOr2Vs
         EIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gUNdLAMgucl6v7TJBLJKgFeOjrc7H3lFKZ3jFG7OFa0=;
        b=O7smnwdaOlp6/zk9YwNrSFCNY2izORlDkPNLofiDl/KXI2+rHFCFuc3RKh8UFyPmkb
         M7I2cms9hyR9eAh8qy8HQVGJmWQfps6DesirdLH/vEGovLd2CihksH5d5FeLIMy99oTO
         K9/sAgsikt4V+bKTWiDhoKzrWvYSgrZAP6j1b8G85IlN4DLNWdHp5529V8xMnT8IIndd
         15QY4X3d3dbOCuGDEwvX5pEUyU2NOVFNvEvATiD00iuJUQsLXW7tAUnM6q2zSxZ6G9Io
         R1LrYuf6HFhW/g2HaOhb4d61/V/XpQDe9z2p1oKR0ueFOOXdJYq2jKid72u9P4FQ5bmR
         /rEQ==
X-Gm-Message-State: AOAM532WC2l+6RR83ig2Wh+sZWD5ocwacF9XwQwlgXhRyAxFby4DJAS5
	2yJGNIknV1ZGaW97zS/PYnLE4QpCZjJw+Y5hSlg=
X-Google-Smtp-Source: ABdhPJySSdkmTDAW9YLOZFbqlCr/0XR313J9yojt6Jf0oi9hawn5KioAcQMgTpDzOk+Kb3JhGVf9gg==
X-Received: by 2002:a17:90a:628b:b0:1c6:a410:d73f with SMTP id d11-20020a17090a628b00b001c6a410d73fmr4168597pjj.96.1648553778458;
        Tue, 29 Mar 2022 04:36:18 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t7-20020a056a0021c700b004f7916d44bcsm19260192pfj.220.2022.03.29.04.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:36:18 -0700 (PDT)
Message-ID: <6242ef32.1c69fb81.32217.178d@mx.google.com>
Date: Tue, 29 Mar 2022 04:36:18 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.106-cip4
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 7 runs, 1 regressions (v5.10.106-cip4) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip ltp-timers: 7 runs, 1 regressions (v5.10.106-cip4)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.106-cip4/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.106-cip4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8bb6e30b765989a3c0924158316d689e16317cd1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dc836ec4cd4e02e1346001f828c1f1988a8d7d54 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6242e20fa24d250179ae067c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-timer=
s-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-timer=
s-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6242e20fa24d250179a=
e067d
        new failure (last pass: v5.10.83-cip1-151-ga4163710a1dc) =

 =20

