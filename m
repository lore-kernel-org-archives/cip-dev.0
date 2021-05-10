Return-Path: <SRS0=8Emx=KF=lists.cip-project.org=bounce+64572+6444+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CA0C433ED
	for <cip-dev@archiver.kernel.org>; Mon, 10 May 2021 01:40:21 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D64611F1
	for <cip-dev@archiver.kernel.org>; Mon, 10 May 2021 01:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D64611F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6444+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NJNBYY4521723xGcGchkKzDM; Sun, 09 May 2021 18:40:20 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.26223.1620610818505177843
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 May 2021 18:40:19 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 14A1eGlQ013976; Mon, 10 May 2021 10:40:16 +0900
X-Iguazu-Qid: 34trQhWM3jg68hBiMk
X-Iguazu-QSIG: v=2; s=0; t=1620610816; q=34trQhWM3jg68hBiMk; m=uWMtlFkIdKvPBlbpz4Se5P3iUr5ZUVMhz2mPcum0wAM=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1513) id 14A1eFt4024711
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 May 2021 10:40:16 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 9FFA61000C5;
	Mon, 10 May 2021 10:40:15 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 14A1eF1Y008338;
	Mon, 10 May 2021 10:40:15 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core][Resend PATCH 3/4] .gitlab-ci.yml: Drop 'deploy: disable' from build:qemu-amd64-base
Date: Mon, 10 May 2021 10:40:10 +0900
X-TSB-HOP: ON
Message-Id: <20210510014011.66494-3-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20210510014011.66494-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210510014011.66494-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: oHWQe07BxmT3k6f03FHqTPz4x4520388AA=
Content-Type: multipart/mixed; boundary="KU6ObEuHSDjF7yfUdutt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620610820;
 bh=JTygmrZadKMHiQYn2lr/dpLggCEhc6rzrS+lrtY49LA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=O7ccizBE+mTIWDT0ChV9aYUztqoEKaZOQfK7p0dexdwZiSH3ib0voLHNVciuewQPnhH
 7rYRSla/qEKJuFdyQpgZByTqS+BttvSUdsYZ3K6MVW9QZa1ui1sMqQHGr2c/iT5nexVrf
 tsoB76lUT4K/4UVUG6yUTxvj1F2cMLhnY9w=

--KU6ObEuHSDjF7yfUdutt
Content-Transfer-Encoding: 8bit

This enables uploading of images built with build:qemu-amd64-base.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .gitlab-ci.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b53d9cc..64c7b20 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -72,7 +72,6 @@ build:qemu-amd64-base:
     use_rt: disable
     wic_targz: disable
     targz: enable
-    deploy: disable
 
 build:qemu-arm64-base:
   extends:
-- 
2.31.1


--KU6ObEuHSDjF7yfUdutt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6444): https://lists.cip-project.org/g/cip-dev/message=
/6444
Mute This Topic: https://lists.cip-project.org/mt/82710798/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--KU6ObEuHSDjF7yfUdutt--
