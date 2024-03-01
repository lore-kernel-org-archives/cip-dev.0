Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47FCC5475B
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 21:13:36 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.35396.1709327611645751591
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 13:13:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=AGYT96HE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d95d67ff45so22300805ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 13:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709327610; x=1709932410; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pZTZ9mYoyZ7/8jjtvue8kg2HlMGrAtU/5ZsCQc5DfBU=;
        b=AGYT96HEjlFqBhDhPo4Ste94xBs77crzfKypLZZf5Jmd0BCuhHMQ7ceZ0Aj6uFf4UD
         IUV9d249D/kmcp4toXQ5ucJIUqmG+IG5+wBjpBGL/PYMRnybjZ4gX9ycD2gz+oxs6oV2
         d+7jJYa+1N7y4rsBQCJ3Kz7FCYka/uYFglkWsbuPw1Ug5ADzqOPu4U5JVwtr0WAZCJYJ
         jEZcnKj+rQ6RIOKJthiqKF9MGuFjz2V7mKQeK9sE02r182JAvrTVIow8b066sLuoXHDQ
         +uXWlxu4B7FpAgVUWrLuyAItraBmCLou1akLSl2IEDeGIEzn43IleV90Ip9k1IZJKW+o
         HMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709327610; x=1709932410;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZTZ9mYoyZ7/8jjtvue8kg2HlMGrAtU/5ZsCQc5DfBU=;
        b=f/aO+ZufeBHzHaJ12gHg2qiF/EoWQl83pxqEfL6jaf7UNE0eyImPkDMH2Ie/LntBYm
         vag3zd1COAHmxquEDPUiGpWNy9bVgSC4euwHl1480fojt4dc0O1ZMgziQeiaOW5U26AQ
         t0F0NpKpw3CpVcEzc84JfU9DTAQR7dLP+86jWId+VnkdqMOE41fUaClC81WOdBibfCgU
         RsAR5IuA1VxWe4rKwDrM2m2s3pPBaXnuNiT13q6PUjCep524BT3GqdeLUSsNlWgBewp2
         KxuKYGiEYIu91TRoZpgrFR2GqREMPCJc3fctn8w4KQNYufKJPGM4yA6/mULVsg70X8Pn
         cjcw==
X-Gm-Message-State: AOJu0YzmEn6G+UX9/TPmEF8l604sXc7xorViX9KPC+oFai4L8fMVYkmk
	lEdyPFjixsQRDvv6htNem7sLjdMXSoXltLYVZHQ89Yf7NWMh5BHYh8qwk+G5mWceK4/a74TnSZ1
	zZ+Y=
X-Google-Smtp-Source: AGHT+IHW4bQAUh8yredLqmUoDs7sHYZNAVA0LdtvTsBO0IxpKLcRM9K7CDyrHryk7DL+eA9/TIs1jg==
X-Received: by 2002:a17:902:7c0f:b0:1dc:d1e1:d314 with SMTP id x15-20020a1709027c0f00b001dcd1e1d314mr2310616pll.30.1709327610321;
        Fri, 01 Mar 2024 13:13:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b001dbcf7f43c9sm3906181plc.303.2024.03.01.13.13.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 13:13:29 -0800 (PST)
Message-ID: <65e244f9.170a0220.90ea9.31be@mx.google.com>
Date: Fri, 01 Mar 2024 13:13:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-552-gc0460fb20fc00
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 6 runs,
 1 regressions (v5.10.209-cip44-552-gc0460fb20fc00)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 21:13:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15141

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 6 runs, 1 regress=
ions (v5.10.209-cip44-552-gc0460fb20fc00)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-552-gc0460fb20fc00/plan/kselfte=
st-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-552-gc0460fb20fc00
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c0460fb20fc000a52548daa693788068d4fc9a8e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65e234c5a21698ecb46370b5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65e234c5a21698ec=
b46370b6
        failing since 120 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

