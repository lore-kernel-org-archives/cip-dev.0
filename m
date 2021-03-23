Return-Path: <SRS0=iR0Z=IV=lists.cip-project.org=bounce+64572+6318+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FFEC433E1
	for <cip-dev@archiver.kernel.org>; Tue, 23 Mar 2021 15:59:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F56619D0
	for <cip-dev@archiver.kernel.org>; Tue, 23 Mar 2021 15:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F56619D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6318+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6rmmYY4521723xRH9GK2cuKT; Tue, 23 Mar 2021 08:59:36 -0700
X-Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web11.11100.1616515176070518179
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 23 Mar 2021 08:59:36 -0700
X-Received: by mail-pg1-f174.google.com with SMTP id 32so6022542pgm.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 23 Mar 2021 08:59:36 -0700 (PDT)
X-Gm-Message-State: 8lYIKPD0lR0ZvCbNK3WSSlspx4520388AA=
X-Google-Smtp-Source: ABdhPJzaTrqhVFw1T4hzjKTa6YXsED/j7JhHF1ypyqna5YyUcly7XBlO2H6YpqVS9OHE81lPgO/3vQ==
X-Received: by 2002:aa7:95b5:0:b029:1ef:272f:920c with SMTP id a21-20020aa795b50000b02901ef272f920cmr5332907pfk.21.1616515175279;
        Tue, 23 Mar 2021 08:59:35 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c128sm17296839pfc.76.2021.03.23.08.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 08:59:35 -0700 (PDT)
Message-ID: <605a1067.1c69fb81.66ec6.9d15@mx.google.com>
Date: Tue, 23 Mar 2021 08:59:35 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.182-cip45-40-g0e469137cd784
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
Subject: [cip-dev] cip/linux-4.19.y-cip sleep: 3 runs, 1 regressions (v4.19.182-cip45-40-g0e469137cd784) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="jBafSKQ1WqNt6JnSNTR5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616515176;
 bh=pCJFJ5Ou9EijGSGX8UH6thMgtvhD24gwdOBHWCEoZZ8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=P4HeSrI4+d6T2f3ojB7uMD/ZfWTI2V86sJT7UpJ+loF1E0RJm5NYSDY0jpBbUzVx5Bf
 WBAEoztM5Vp15qNx7qUDEm+ZpmdRsiOvuA3gy/XniuXGdk+iTrh1qmuuH7qCf9Jk4RGK9
 Uqf5vVoaRtZBNcqDsdhfLfJV7jF6R7F33sU=

--jBafSKQ1WqNt6JnSNTR5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip sleep: 3 runs, 1 regressions (v4.19.182-cip45-40-g0e46=
9137cd784)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.182-cip45-40-g0e469137cd784/plan/sleep/

  Test:     sleep
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.182-cip45-40-g0e469137cd784
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0e469137cd784e952b10670400ce2b9143741fd2 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/6059fd68b68d11b7beaddcc1

  Results:     12 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-g=
ru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-g=
ru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0315.0/arm64/rootfs.cpio.gz =



  * sleep.rtcwake-mem-9: https://kernelci.org/test/case/id/6059fd68b68d11b7=
beaddccd
        new failure (last pass: v4.19.182-cip45) =

 =20

--jBafSKQ1WqNt6JnSNTR5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6318): https://lists.cip-project.org/g/cip-dev/message=
/6318
Mute This Topic: https://lists.cip-project.org/mt/81554326/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--jBafSKQ1WqNt6JnSNTR5--
