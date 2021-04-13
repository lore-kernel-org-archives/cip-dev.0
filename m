Return-Path: <SRS0=Fmlw=JK=lists.cip-project.org=bounce+64572+6374+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,WEIRD_PORT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C969C433ED
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 17:30:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0AC613B1
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 17:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0AC613B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6374+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VaO9YY4521723xxHNiyvrqF2; Tue, 13 Apr 2021 10:30:27 -0700
X-Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web09.513.1618335024041074475
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Apr 2021 10:30:26 -0700
X-Received: by mail-ed1-f47.google.com with SMTP id ba6so20347429edb.1
        for <cip-dev@lists.cip-project.org>; Tue, 13 Apr 2021 10:30:23 -0700 (PDT)
X-Gm-Message-State: IbqJU2MLR08T3MQICYvg1fPAx4520388AA=
X-Google-Smtp-Source: ABdhPJwAF78lEb8V75Ophhy6Eoo3tQU8pDCMewGoiSHXJqY+6RHMTOexOK7bDRka9ChF/EofBpGiosHzRjNc/iepnHM=
X-Received: by 2002:a05:6402:2038:: with SMTP id ay24mr35907478edb.240.1618335022374;
 Tue, 13 Apr 2021 10:30:22 -0700 (PDT)
MIME-Version: 1.0
From: "Alice Ferrazzi" <alice.ferrazzi@miraclelinux.com>
Date: Wed, 14 Apr 2021 02:29:46 +0900
Message-ID: <CANgtXuP5wVfj7x_ef=oSV6S80zMnAG4JPa_N_W4hNUAE7qmHQA@mail.gmail.com>
Subject: [cip-dev] Kselftest implementation
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="TJzKkFXCT2424loibyAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618335027;
 bh=gPnEwqHBpq3OIz9/OxIry6TzMtILUCnLiY03wLW2ljU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=fzF7dxnmBBZxteRWfCF2RdLSn/lWaggrHVL+mJ6Vbpdd7oPD0bgX4epLignWBAu2NKG
 0N/r1J6WwqZOHJniX6sX6YiBP0NoLd5mYvfFk+sTiu/zHK9bpeNEbAEaKvhbYZ90Sniwy
 UlmMvc/9AWWJzsr4m9Q5gfv1VEz39IY0pik=

--TJzKkFXCT2424loibyAW
Content-Type: multipart/alternative; boundary="00000000000022f85705bfddfcfd"

--00000000000022f85705bfddfcfd
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

I'm Alice Ferrazzi from Cybertrust Japan.
I'm currently working on adding Kselftest to the current CIP CI tests of
linux-cip Kernel

I made and tested kselftest on a testing instance of lava, currently tested
only on qemu x86_64
I implemented a simple skiplist in the kselftest envelope for skipping
tests that are currently not working.
The usage is similar to how spectre-meltdown-checker-test is currently
working.

Raw log:
http://140.211.166.173:10080/scheduler/job/329
Results list:
http://140.211.166.173:10080/results/329/1_kselftest

My idea is to start implementing kselftest tests for at least qemu x86_64
architecture and expand in the future to other architectures.
As Iwamatsu-san pointed, we need also to create kselftest binary.
I'm currently thinking of implementing kselftest binary creation mechanism
on linux-cip-ci kernel build script but I still didn't start to work on
this yet.

Kselftest test code:
https://gitlab.com/alice.ferrazzi/cip-kselftest

linux-cip Kernel Kselftest implementation (currently in draft):
https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/merge_requests

Thanks,
Alice
-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

--00000000000022f85705bfddfcfd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">Hi =
everyone,</div><div class=3D"gmail_default" style=3D"font-size:small"><br><=
/div><div class=3D"gmail_default" style=3D"font-size:small">I&#39;m Alice F=
errazzi from Cybertrust Japan.<br></div><div class=3D"gmail_default" style=
=3D"font-size:small">I&#39;m currently working on adding Kselftest to the c=
urrent CIP CI tests of linux-cip Kernel</div><div class=3D"gmail_default" s=
tyle=3D"font-size:small"><br></div><div><div style=3D"font-size:small" clas=
s=3D"gmail_default">I made and tested kselftest on a testing instance of la=
va, currently tested only on qemu x86_64</div><div style=3D"font-size:small=
" class=3D"gmail_default">I implemented a simple skiplist in the kselftest =
envelope for skipping tests that are currently not working.</div><div style=
=3D"font-size:small" class=3D"gmail_default"> The usage is similar to how s=
pectre-meltdown-checker-test is currently working.</div><div style=3D"font-=
size:small" class=3D"gmail_default"><br></div><div style=3D"font-size:small=
" class=3D"gmail_default"><div style=3D"font-size:small" class=3D"gmail_def=
ault">Raw log:<br></div><div style=3D"font-size:small" class=3D"gmail_defau=
lt"><a href=3D"http://140.211.166.173:10080/scheduler/job/329" target=3D"_b=
lank">http://140.211.166.173:10080/scheduler/job/329</a></div><div style=3D=
"font-size:small" class=3D"gmail_default">Results list:</div><div style=3D"=
font-size:small" class=3D"gmail_default"><a href=3D"http://140.211.166.173:=
10080/results/329/1_kselftest" target=3D"_blank">http://140.211.166.173:100=
80/results/329/1_kselftest</a></div></div></div><div><br></div><div><div st=
yle=3D"font-size:small" class=3D"gmail_default">My idea is to start impleme=
nting kselftest tests for at least qemu x86_64 architecture and expand in t=
he future to other architectures.</div><div style=3D"font-size:small" class=
=3D"gmail_default">As Iwamatsu-san pointed, we need also to create kselftes=
t binary. <br></div><div style=3D"font-size:small" class=3D"gmail_default">=
I&#39;m currently thinking of implementing kselftest binary creation mechan=
ism<span><span> on linux-cip-ci kernel build script but I still didn&#39;t =
start to work on this yet.</span></span></div><div style=3D"font-size:small=
" class=3D"gmail_default"><br><div style=3D"font-size:small" class=3D"gmail=
_default"><span><span>Kselftest test code:<br></span></span></div><div styl=
e=3D"font-size:small" class=3D"gmail_default"><a href=3D"https://gitlab.com=
/alice.ferrazzi/cip-kselftest" target=3D"_blank"><span><span>https://gitlab=
.com/alice.ferrazzi/cip-kselftest</span></span></a></div><div style=3D"font=
-size:small" class=3D"gmail_default"><br></div><div style=3D"font-size:smal=
l" class=3D"gmail_default">
linux-cip Kernel Kselftest implementation (currently in draft):</div><div s=
tyle=3D"font-size:small" class=3D"gmail_default"><a href=3D"https://gitlab.=
com/cip-project/cip-testing/linux-cip-ci/-/merge_requests">https://gitlab.c=
om/cip-project/cip-testing/linux-cip-ci/-/merge_requests</a></div></div></d=
iv><div><br></div><div><div style=3D"font-size:small" class=3D"gmail_defaul=
t">Thanks,</div><div style=3D"font-size:small" class=3D"gmail_default">Alic=
e</div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-smartma=
il=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div>=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><span>Cybertrust Japan Co.,Ltd.</span>=
<br>Alice Ferrazzi<br><a href=3D"mailto:alice.ferrazzi@miraclelinux.com" ta=
rget=3D"_blank">alice.ferrazzi@miraclelinux.com</a><br>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br></div></div></div></div></div></div>

--00000000000022f85705bfddfcfd--

--TJzKkFXCT2424loibyAW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6374): https://lists.cip-project.org/g/cip-dev/message=
/6374
Mute This Topic: https://lists.cip-project.org/mt/82071182/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--TJzKkFXCT2424loibyAW--
