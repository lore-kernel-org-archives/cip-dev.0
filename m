Return-Path: <SRS0=cX24=L6=lists.cip-project.org=bounce+64572+6593+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4129CC07E9C
	for <cip-dev@archiver.kernel.org>; Tue,  6 Jul 2021 16:10:23 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A266461C1B
	for <cip-dev@archiver.kernel.org>; Tue,  6 Jul 2021 16:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A266461C1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6593+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BwHxYY4521723x8upBFhbNJK; Tue, 06 Jul 2021 09:10:22 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web08.8485.1625587821168286037
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jul 2021 09:10:21 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 166GAHL3006129
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Jul 2021 18:10:18 +0200
X-Received: from [167.87.4.249] ([167.87.4.249])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 166GAGlI005639;
	Tue, 6 Jul 2021 18:10:16 +0200
X-Mozilla-News-Host: news://lore.kernel.org:119
To: cip-dev <cip-dev@lists.cip-project.org>,
        "Adler, Michael (CT RDA IOT SES-DE)" <michael.adler@siemens.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Quirin Gylstorff <quirin.gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] isar-cip-core unhappy with our current runners
Message-ID: <cc986bb5-c1b1-0ef5-5dfb-81d4447ecc70@siemens.com>
Date: Tue, 6 Jul 2021 18:10:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: LZaXY20DlfPlV4e2bSgrd0yox4520388AA=
Content-Type: multipart/mixed; boundary="HZ0g8fXNki7AC28sS6MM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625587822;
 bh=ZgerBFHAdng15WwmMT675gdKnMhInnfr6YMf6vXTrQk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Tyh+Gz4IQoBiz8wA1dVGF/wQRYN0Ej5wl24HCr5O/EBCNLU6XNZEffUEdm8Q/xVUffH
 wEW5n6gNj5yiaUW+yClHWjtVRx2Y4NU5h8Dp80NVfg2dEkylUVTNXrhMDF8kPmheeKmPM
 og0cdQMtx08cAffR6OqTel1TFdU/VJ3UcSo=

--HZ0g8fXNki7AC28sS6MM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi all,

maybe someone has a clue: isar-cip-core does not build anymore with the
current runners, see e.g.
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/1401975741:

"update-binfmts: warning: unable to open /proc/sys/fs/binfmt_misc/status
for writing: Permission denied"

I'm also not sure, given that we have two group runners available now,
if they differ and if isar-cip-core will use the right one. Maybe
additional tags are needed?

Did anything change recently?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--HZ0g8fXNki7AC28sS6MM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6593): https://lists.cip-project.org/g/cip-dev/message=
/6593
Mute This Topic: https://lists.cip-project.org/mt/84024159/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--HZ0g8fXNki7AC28sS6MM--
