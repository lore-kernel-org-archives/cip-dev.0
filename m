Return-Path: <SRS0=v1bM=GM=lists.cip-project.org=bounce+64572+6058+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD61C433E9
	for <cip-dev@archiver.kernel.org>; Sat,  9 Jan 2021 22:45:55 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6510E2388E
	for <cip-dev@archiver.kernel.org>; Sat,  9 Jan 2021 22:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6510E2388E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6058+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8M4KYY4521723xWSXc1qT3ER; Sat, 09 Jan 2021 14:45:55 -0800
X-Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web12.154.1610170463463981867
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Jan 2021 21:34:23 -0800
X-Received: by mail-pf1-f175.google.com with SMTP id x126so7604150pfc.7
        for <cip-dev@lists.cip-project.org>; Fri, 08 Jan 2021 21:34:23 -0800 (PST)
X-Gm-Message-State: h0L9y6Lp3UCTtvjKkyNCur9zx4520388AA=
X-Google-Smtp-Source: ABdhPJyZq2xiyAXqtZLk4lVnHsdndkUJnVUgIuEgQXh8KokIz/EN2EAqczlTkSw63Y7Tq37tgN+/7A==
X-Received: by 2002:a62:2e86:0:b029:1a6:5f94:2cb with SMTP id u128-20020a622e860000b02901a65f9402cbmr10310639pfu.19.1610170462626;
        Fri, 08 Jan 2021 21:34:22 -0800 (PST)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o9sm6831513pjw.9.2021.01.08.21.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 21:34:21 -0800 (PST)
Message-ID: <5ff9405d.1c69fb81.183b5.072e@mx.google.com>
Date: Fri, 08 Jan 2021 21:34:21 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4.249-cip53
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.4.y-cip ltp-ipc: 12 runs, 1 regressions (v4.4.249-cip53)
To: cip-dev@lists.cip-project.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="BXsT0TJZxivZGGVoBlwN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610232355;
 bh=sc/6PPcvQwCuGqpyYxoma1G5qu8Txx4gK42qkAjiS+c=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=E3K/7aSO85mRNVCa0EeUIN3AU4VjL5msrbeDRr7pbXGTG0k0YH2gcLKCS9Ydv3kqElb
 wUeb2HHq1JV0ica1Fnf0TJ5dO6EN7C1Ia00tQhPxpItXlypPA1gB5FE3zaLrNcGHEpCa2
 GyTaT36VP6HQb3jEtljUFRKthirgChf0lR0=

--BXsT0TJZxivZGGVoBlwN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip ltp-ipc: 12 runs, 1 regressions (v4.4.249-cip53)

Regressions Summary
-------------------

platform   | arch | lab           | compiler | defconfig                   =
 | regressions
-----------+------+---------------+----------+-----------------------------=
-+------------
jetson-tk1 | arm  | lab-collabora | gcc-8    | multi_v7_defc...CONFIG_SMP=
=3Dn | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.249-cip53/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.249-cip53
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      4490d27a976fb4ef09aa7a5ab410a347bb7e2329

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b7ca00a6faa75fee42cb63d40f709cbfe65ec378 =



Test Regressions
---------------- =



platform   | arch | lab           | compiler | defconfig                   =
 | regressions
-----------+------+---------------+----------+-----------------------------=
-+------------
jetson-tk1 | arm  | lab-collabora | gcc-8    | multi_v7_defc...CONFIG_SMP=
=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff93960362ec774d3c94cdc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/ltp-ipc-jets=
on-tk1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.249-c=
ip53/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/ltp-ipc-jets=
on-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster-ltp/=
20201221.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/5ff93960362ec774d3c94c=
dd
        new failure (last pass: v4.4.243-cip51-21-g1d9a9094c010) =

 =20

--BXsT0TJZxivZGGVoBlwN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6058): https://lists.cip-project.org/g/cip-dev/message=
/6058
Mute This Topic: https://lists.cip-project.org/mt/79559761/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--BXsT0TJZxivZGGVoBlwN--
