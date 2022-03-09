X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web10.1607.1646794203011560382
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Mar 2022 18:50:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Yl446fHU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id bc27so792450pgb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Mar 2022 18:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=68qnyFoK/6OlfWgac034V4KVkZ8ce/Eucua3fBtVw3Q=;
        b=Yl446fHUmd4gE63EzLT1Cynl05e73OWFtX/RQ2ABefs+yeCiMBxr9J8Q/zTw/BxVDH
         fm4QH7rGfNsj9JnSYozhLmipl/QWWh2Em5q6jSF8HSgqMWw89Exe1aqL4Vj4zv4hLQwV
         NPfX/NFQY7+m3QV1ZaFb3DFh7LAb+WJlJHZfrRT4uvGePmgOv0vwEdKAWlhrg/KEgC89
         xefb+jh5BHumPWI0p1O7elzs5Hq+VNYvtW8D+cuIZRvFMtn+oh5UTmxW6OV+H25BFZac
         UI28XqmDQnOXwRF2b5OyxUAwyaiHp+0Z31GzpEGYFiCNpQkKxRUCeyUbZL7bH5Yz90+y
         An0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=68qnyFoK/6OlfWgac034V4KVkZ8ce/Eucua3fBtVw3Q=;
        b=FbOBRU4aZ00xMHrBB1ZjjYkPdI/LK9aX2bC+Nah/7EaxCtF1vcwCS2nohUVwKy4Q1X
         shiWfFSNZmihpHJGzjVKHgV597g3yGqkFy0FEkj8HsIwCg44UxGbMb8wcExPOrmdBXWc
         lRmHgN2Xeo+bWeC72nOT9gwq2mUw4FLQXQcT0WzgfdlakDgxo7HQ43u2V/WY2o9nQ+JH
         bXjfV/A6Qrz53i5ayf9UA1Rwsz15nZkntEOO1O8I2pekvo6fWRNzOhJskAq5SIVhxbNB
         +iCtZ5UbTv/Rz0FX6+uF8DlmrBQoCZKnkHR51QwtH2ApE5MT4HFp9nS7oIfbdayfXFRn
         T8+A==
X-Gm-Message-State: AOAM5329Mda6JU0w3kcCAhKt55r/etz6wBmMGm3OrdC0wT9VPtd0F0LK
	NAvn/Th5GddMkW1NqZNrMKNZVVTlHpONK0p3qsw=
X-Google-Smtp-Source: ABdhPJzEXPXSuU6ixGbUM1ZUdtSqlbh4wVz2JZ5sMLviI2lOxIVUJunsPme7sh1HUso+ttexVLCH2w==
X-Received: by 2002:a63:da0d:0:b0:364:b771:ff4 with SMTP id c13-20020a63da0d000000b00364b7710ff4mr16844878pgh.514.1646794202110;
        Tue, 08 Mar 2022 18:50:02 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j13-20020a63594d000000b003639cf2f9c7sm431807pgm.71.2022.03.08.18.50.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 18:50:01 -0800 (PST)
Message-ID: <622815d9.1c69fb81.b3b49.1d06@mx.google.com>
Date: Tue, 08 Mar 2022 18:50:01 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.231-cip68-89-gd39fc5cc85ff
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 5 runs, 2 regressions (v4.19.231-cip68-89-gd39fc5cc85ff) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 5 runs, 2 regression=
s (v4.19.231-cip68-89-gd39fc5cc85ff)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.231-cip68-89-gd39fc5cc85ff/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.231-cip68-89-gd39fc5cc85ff
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d39fc5cc85ffc96513abd78af85d4ceecfbf8abf

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  67eccca54eb68a1bc91cf1f140fc43fa8085d8ed =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6228012630138da2c6c62995

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.231-cip68-89-gd39fc5cc85ff/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.231-cip68-89-gd39fc5cc85ff/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/62280126301=
38da2c6c6299a
        new failure (last pass: v4.19.231-cip68-36-g01a8d14a9290) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/62280126301=
38da2c6c6299a
        new failure (last pass: v4.19.231-cip68-36-g01a8d14a9290) =

 =20

